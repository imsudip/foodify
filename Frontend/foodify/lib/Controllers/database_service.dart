// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meilisearch/meilisearch.dart';

import '../Constants/app_constant.dart';
import '../models/recipe_model.dart';
import 'auth_controller.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService _databaseService = DatabaseService._();
  static DatabaseService get instance => _databaseService;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //firestore reference
  static const String recipeCollection = 'recipesNew';
  static const String popularFoodsCollection = 'popularFoods';
  late CollectionReference recipeCollectionRef;
  late CollectionReference popularFoodsCollectionRef;
  static const int pageSize = 10;

  // Meili Search
  late MeiliSearchClient client;
  late MeiliSearchIndex recipeIndex, ingredientIndex;
  late Map<String, String> env;
  void init() {
    env = dotenv.env;
    recipeCollectionRef = _firestore.collection(recipeCollection);
    popularFoodsCollectionRef = _firestore.collection(popularFoodsCollection);
    client = MeiliSearchClient('https://meilisearch-on-koyeb-imsudip.koyeb.app', env['MASTER_KEY_MILLIE']);
    recipeIndex = client.index('recipes');
    ingredientIndex = client.index('ingredient_images');
  }

  Future<RecipeModel> getRecipe(String recipeId) async {
    DocumentSnapshot documentSnapshot = await recipeCollectionRef.doc(recipeId).get();
    return RecipeModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

// meilli search ---------------------------------------------------------------
  Future<List<Map<String, dynamic>>> getSuggestions(String pattern, {bool limited = true}) async {
    List<Map<String, dynamic>> suggestions = [];
    if (pattern.isNotEmpty) {
      await recipeIndex.search(pattern, limit: limited ? 10 : 500).then((value) {
        suggestions = value.hits?.toList() ?? [];
      });
    }
    return suggestions;
  }

  Future<List<Map<String, dynamic>>> getIngredientsSuggestions(String pattern, {bool limited = true}) async {
    List<Map<String, dynamic>> suggestions = [];
    if (pattern.isNotEmpty) {
      await ingredientIndex.search(pattern, limit: limited ? 5 : 500).then((value) {
        suggestions = value.hits?.toList() ?? [];
      });
    }
    return suggestions;
  }

  // ---------------------------------------------------------------------------

  Future<List<RecipeModel>> paginateRecipes(List<String> idList, int lastIndex) async {
    int limit = lastIndex + pageSize;
    if (limit > idList.length) {
      limit = idList.length;
    }

    List<String> l = idList.sublist(lastIndex, limit);
    print(l);
    print(l.length);
    if (l.isNotEmpty) {
      Query query = recipeCollectionRef.where('recipe_id', whereIn: l);
      var batchRecipes = await query.get();
      var finalList = batchRecipes.docs.map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      // sort finalList according to the l
      finalList.sort((a, b) {
        int indexA = l.indexOf(a.recipeId);
        int indexB = l.indexOf(b.recipeId);
        return indexA.compareTo(indexB);
      });
      return finalList;
    } else {
      return [];
    }
  }

  Future<List<RecipeModel>> getAllRecipes(List<String> idList) async {
    List<RecipeModel> recipes = [];
    // seperate the ids into batches of 10 to avoid firebase limit
    List<List<String>> batches = [];
    for (var i = 0; i < idList.length; i += 10) {
      if (i + 10 > idList.length) {
        batches.add(idList.sublist(i));
      } else {
        batches.add(idList.sublist(i, i + 10));
      }
    }
    // max of 5 batches
    if (batches.length > 5) {
      batches = batches.sublist(0, 5);
    }
    // get the recipes
    for (var batch in batches) {
      Query query = recipeCollectionRef.where('recipe_id', whereIn: batch);
      var batchRecipes = await query.get();
      recipes.addAll(batchRecipes.docs.map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
    }

    return recipes;
  }

  Future<List<RecipeModel>> getRecipesByCategory(String category, {int lastIndex = 0}) async {
    var map = {
      'indian': AppConstant.instance.indian,
      'veg': AppConstant.instance.veg,
      'dinner': AppConstant.instance.dinner,
      'dessert': AppConstant.instance.dessert,
      'appetizers': AppConstant.instance.appetizers,
      'chicken': AppConstant.instance.chicken,
      'eggless': AppConstant.instance.eggless,
      'healthy': AppConstant.instance.healthy,
      'indian_chinese': AppConstant.instance.chinese,
      'paneer': AppConstant.instance.paneer,
      'pasta_noodles': AppConstant.instance.pastaNoodles,
      'seafood': AppConstant.instance.seafood,
      'side_dishes': AppConstant.instance.sideDish,
      'soups': AppConstant.instance.soup
    };

    var categoryList = map[category] ?? [];
    print('categoryList: $lastIndex');
    return paginateRecipes(categoryList, lastIndex);
  }

  // Meal suggestion
  Future<List<RecipeModel>> getMealSuggestions(List<String> ingredients, {int limit = 10}) async {
    List<RecipeModel> recipes = [];
    var base = env['RECOMMENDATIONS_API_URL'];
    try {
      var url = "$base/recipe?limit=$limit&ingredients=";
      var finalUrl = url + ingredients.join(',');
      var response = await http.get(Uri.parse(finalUrl));
      print(response.request);
      var json = jsonDecode(response.body);
      List<String> idList = [];
      for (var item in json) {
        idList.add(item['recipe_id'].toString());
      }
      recipes = await getAllRecipes(idList);
      // sort list
      recipes.sort((a, b) {
        int indexA = idList.indexOf(a.recipeId);
        int indexB = idList.indexOf(b.recipeId);
        return indexA.compareTo(indexB);
      });

      return recipes;
    } on Exception {
      Get.back();
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
        // snackStyle: SnackStyle.GROUNDED,
      );
      // rethrow;
      return [];
    }
  }

  // get recommended Recipes
  Future<List<RecipeModel>> getRandomRecipes() async {
    var savedIds = AuthController.authInstance.savedRecipes;
    // select 5 random ids from the saved recipes
    List<String> randomIds = [];
    if (savedIds.isNotEmpty) {
      for (var i = 0; i < 5; i++) {
        var randomIndex = Random().nextInt(savedIds.length);
        randomIds.add(savedIds[randomIndex]);
      }
    } else {
      await recipeCollectionRef.get().then((value) {
        for (var i = 0; i < 5; i++) {
          var randomIndex = Random().nextInt(value.docs.length);
          randomIds.add(value.docs[randomIndex].id);
        }
      });
    }
    // get the recipes
    List<RecipeModel> recipes = await getAllRecipes(randomIds);
    // get all the ingredients and make a set
    Set<String> ingredients = {};
    for (var recipe in recipes) {
      ingredients.addAll(recipe.rawIngredients);
    }
    // select any 8 random ingredients
    List<String> randomIngredients = [];
    for (var i = 0; i < 8; i++) {
      var randomIndex = Random().nextInt(ingredients.length);
      randomIngredients.add(ingredients.elementAt(randomIndex));
    }
    // check if the user is vegetarian
    String diet = AuthController.authInstance.userData.value['diet'];
    // use the suggestions to get the recipes
    if (diet == 'Vegetarian') {
      recipes = await getMealSuggestions(randomIngredients, limit: 50);
      recipes = recipes.where((recipe) => recipe.diet.contains("Vegetarian")).toList();
    } else {
      recipes = await getMealSuggestions(randomIngredients, limit: 30);
    }
    return recipes;
  }
}
