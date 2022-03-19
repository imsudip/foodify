import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodify/services/apps_data.dart';
import 'package:foodify/services/recipe_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'popular_food_model.dart';

class DatabaseService {
  static const String recipeCollection = 'recipe';
  static const String popularFoodsCollection = 'popularFoods';
  static const int pageSize = 20;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Collection reference
  late CollectionReference recipeCollectionRef;
  late CollectionReference popularFoodsCollectionRef;

  DatabaseService() {
    recipeCollectionRef = _firestore.collection(recipeCollection);
    popularFoodsCollectionRef = _firestore.collection(popularFoodsCollection);
  }

  // popularFoods Collection
  Future<List<PopularFoodModel>> getPopularFoods() async {
    QuerySnapshot querySnapshot = await popularFoodsCollectionRef.get();
    var l = querySnapshot.docs
        .map((doc) => PopularFoodModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    l.shuffle();
    return l;
  }

  // recipe Collection
  Future<RecipeModel> getRecipe(String recipeId) async {
    DocumentSnapshot documentSnapshot = await recipeCollectionRef.doc(recipeId).get();
    return RecipeModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<RecipeModel>> getRecipes({int? page}) {
    List<String> diets, courses, cuisines;

    //open hive box to get the filters
    diets = Hive.box('filters').get('diets', defaultValue: []);
    courses = Hive.box('filters').get('courses', defaultValue: []);
    cuisines = Hive.box('filters').get('cuisines', defaultValue: []);

    Query query = recipeCollectionRef;
    if (diets.isNotEmpty) {
      query = query.where('Diet', whereIn: diets);
    }
    if (courses.isNotEmpty) {
      query = query.where('course', whereIn: courses);
    }
    if (cuisines.isNotEmpty) {
      query = query.where('cuisine', whereIn: cuisines);
    }
    // if (page != null) {
    //   query = query.limit(pageSize).startAfter([page]);
    // }
    // get the recipes
    return query.limit(pageSize).get().then((snapshot) {
      return snapshot.docs
          .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  List<String> getSuggestions(String pattern, {bool limit = true}) {
    List<String> suggestions = [];
    List<String> recipes = AppsData.instance.recipes;
    for (var recipe in recipes) {
      if (recipe.toLowerCase().contains(pattern.toLowerCase())) {
        suggestions.add(recipe);
      }
      if (suggestions.length == 15 && limit) {
        break;
      }
    }
    return suggestions;
  }

  Future<List<RecipeModel>> getRecipesByNameList(String search) async {
    List<String> recipeNames = getSuggestions(search, limit: false);
    List<String> ids = [];
    for (var recipeName in recipeNames) {
      var id = AppsData.instance.getIdFromName(recipeName);
      ids.add(id);
    }
    // seperate the ids into batches of 10 to avoid firebase limit
    List<List<String>> batches = [];
    for (var i = 0; i < ids.length; i += 10) {
      if (i + 10 > ids.length) {
        batches.add(ids.sublist(i));
      } else {
        batches.add(ids.sublist(i, i + 10));
      }
    }
    // max of 5 batches
    if (batches.length > 5) {
      batches = batches.sublist(0, 5);
    }
    // get the recipes
    List<RecipeModel> recipes = [];
    for (var batch in batches) {
      Query query = recipeCollectionRef.where('recipe_id', whereIn: batch);
      var batchRecipes = await query.get();
      recipes.addAll(batchRecipes.docs
          .map((doc) => RecipeModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    }
    return recipes;
  }
}
