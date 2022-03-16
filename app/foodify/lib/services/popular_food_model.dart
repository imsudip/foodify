// To parse this JSON data, do
//
//     final popularFoodModel = popularFoodModelFromMap(jsonString);

import 'dart:convert';

/// PopularFoodModel class is used to store the data of the popular food
/// [recipe_id] is the id of the recipe
class PopularFoodModel {
  PopularFoodModel({
    required this.cookTime,
    required this.description,
    required this.recipeId,
    required this.cuisine,
    required this.ingredients,
    required this.recipeName,
    required this.imageUrl,
    required this.name,
    required this.foodId,
  });

  int cookTime;
  String description;
  String recipeId;
  String cuisine;
  String ingredients;
  String recipeName;
  String imageUrl;
  String name;
  String foodId;

  factory PopularFoodModel.fromJson(String str) =>
      PopularFoodModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopularFoodModel.fromMap(Map<String, dynamic> json) => PopularFoodModel(
        cookTime: json["cook_time"],
        description: json["description"],
        recipeId: json["recipe_id"],
        cuisine: json["cuisine"],
        ingredients: json["ingredients"],
        recipeName: json["recipe_name"],
        imageUrl: json["image_url"],
        name: json["name"],
        foodId: json["food_id"],
      );

  Map<String, dynamic> toMap() => {
        "cook_time": cookTime,
        "description": description,
        "recipe_id": recipeId,
        "cuisine": cuisine,
        "ingredients": ingredients,
        "recipe_name": recipeName,
        "image_url": imageUrl,
        "name": name,
        "food_id": foodId,
      };
}
