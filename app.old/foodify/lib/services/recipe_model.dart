// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromMap(jsonString);

import 'dart:convert';

class RecipeModel {
  RecipeModel({
    required this.instructions,
    required this.cuisine,
    required this.ingredients,
    required this.name,
    required this.totalTime,
    required this.serving,
    required this.diet,
    required this.recipeId,
    required this.course,
    required this.image,
    required this.postUrl,
    required this.rawIngredients,
    required this.ingredientsCount,
  });

  String instructions;
  String cuisine;
  String ingredients;
  String name;
  int totalTime;
  int serving;
  String diet;
  String recipeId;
  String course;
  String image;
  String postUrl;
  String rawIngredients;
  int ingredientsCount;

  factory RecipeModel.fromJson(String str) => RecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        instructions: json["instructions"],
        cuisine: json["cuisine"],
        ingredients: json["ingredients"],
        name: json["name"],
        totalTime: int.tryParse(json["total_time"].toString()) ??
            double.parse(json["total_time"].toString()).toInt(),
        serving: json["serving"],
        diet: json["Diet"],
        recipeId: json["recipe_id"],
        course: json["course"],
        image: json["image"],
        postUrl: json["post_url"],
        rawIngredients: json["raw_ingredients"],
        ingredientsCount: int.tryParse(json["ingredients_count"].toString()) ??
            double.parse(json["ingredients_count"].toString()).toInt(),
      );

  Map<String, dynamic> toMap() => {
        "instructions": instructions,
        "cuisine": cuisine,
        "ingredients": ingredients,
        "name": name,
        "total_time": totalTime,
        "serving": serving,
        "Diet": diet,
        "recipe_id": recipeId,
        "course": course,
        "image": image,
        "post_url": postUrl,
        "raw_ingredients": rawIngredients,
        "ingredients_count": ingredientsCount,
      };
}
