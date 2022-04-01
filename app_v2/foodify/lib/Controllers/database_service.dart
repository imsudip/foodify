import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodify/Constants/app_constant.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/models/recipe_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:meilisearch/meilisearch.dart';

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
  late MeiliSearchIndex recipeIndex;
  void init() {
    recipeCollectionRef = _firestore.collection(recipeCollection);
    popularFoodsCollectionRef = _firestore.collection(popularFoodsCollection);
    client = MeiliSearchClient('http://ec2-3-89-98-23.compute-1.amazonaws.com',
        'ZGQ3MzY2ZDBlNmEyNjJiYTViMTRiMDhj');
    recipeIndex = client.index('recipes');
  }

  // // popularFoods Collection
  // Future<List<PopularFoodModel>> getPopularFoods() async {
  //   QuerySnapshot querySnapshot = await popularFoodsCollectionRef.get();
  //   var l = querySnapshot.docs
  //       .map((doc) => PopularFoodModel.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  //   l.shuffle();
  //   return l;
  // }

  // // recipe Collection
  // Future<RecipeModel> getRecipe(String recipeId) async {
  //   DocumentSnapshot documentSnapshot = await recipeCollectionRef.doc(recipeId).get();
  //   return RecipeModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  // }

  // Future<List<RecipeModel>> getRecipes({int? page}) {
  //   List<String> diets, courses, cuisines;

  //   //open hive box to get the filters
  //   diets = Hive.box('filters').get('diets', defaultValue: []);
  //   courses = Hive.box('filters').get('courses', defaultValue: []);
  //   cuisines = Hive.box('filters').get('cuisines', defaultValue: []);

  //   Query query = recipeCollectionRef;
  //   if (diets.isNotEmpty) {
  //     query = query.where('Diet', whereIn: diets);
  //   }
  //   if (courses.isNotEmpty) {
  //     query = query.where('course', whereIn: courses);
  //   }
  //   if (cuisines.isNotEmpty) {
  //     query = query.where('cuisine', whereIn: cuisines);
  //   }
  //   // if (page != null) {
  //   //   query = query.limit(pageSize).startAfter([page]);
  //   // }
  //   // get the recipes
  //   return query.limit(pageSize).get().then((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   });
  // }

  Future<List<Map<String, dynamic>>> getSuggestions(String pattern,
      {bool limited = true}) async {
    List<Map<String, dynamic>> suggestions = [];
    if (pattern.isNotEmpty) {
      await recipeIndex
          .search(pattern, limit: limited ? 10 : 500)
          .then((value) {
        suggestions = value.hits?.toList() ?? [];
      });
    }
    return suggestions;
  }

  // Future<List<RecipeModel>> getRecipesByNameList(String search) async {
  //   List<String> recipeNames = getSuggestions(search, limit: false);
  //   List<String> ids = [];
  //   for (var recipeName in recipeNames) {
  //     var id = AppsData.instance.getIdFromName(recipeName);
  //     ids.add(id);
  //   }
  //   // seperate the ids into batches of 10 to avoid firebase limit
  //   List<List<String>> batches = [];
  //   for (var i = 0; i < ids.length; i += 10) {
  //     if (i + 10 > ids.length) {
  //       batches.add(ids.sublist(i));
  //     } else {
  //       batches.add(ids.sublist(i, i + 10));
  //     }
  //   }
  //   // max of 5 batches
  //   if (batches.length > 5) {
  //     batches = batches.sublist(0, 5);
  //   }
  //   // get the recipes
  //   List<RecipeModel> recipes = [];
  //   for (var batch in batches) {
  //     Query query = recipeCollectionRef.where('recipe_id', whereIn: batch);
  //     var batchRecipes = await query.get();
  //     recipes.addAll(batchRecipes.docs
  //         .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList());
  //   }
  //   return recipes;
  // }
  Future<List<RecipeModel>> paginateRecipes(
      List<String> idList, int lastIndex) async {
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
      var finalList = batchRecipes.docs
          .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
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
      recipes.addAll(batchRecipes.docs
          .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }

    return recipes;
  }

  Future<List<RecipeModel>> getRecipesByCategory(String category,
      {int lastIndex = 0}) async {
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
}
