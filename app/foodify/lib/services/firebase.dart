import 'package:cloud_firestore/cloud_firestore.dart';
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
    return querySnapshot.docs
        .map((doc) => PopularFoodModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
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
}
