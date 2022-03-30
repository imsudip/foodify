// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RecipeModel {
  RecipeModel({
    required this.url,
    required this.image,
    required this.videoId,
    required this.pId,
    required this.title,
    required this.description,
    required this.course,
    required this.servings,
    required this.cuisine,
    required this.diet,
    required this.time,
    required this.calories,
    required this.author,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
    required this.rawIngredients,
    required this.blurhash,
    required this.aspectRatio,
    required this.recipeId,
  });

  String url;
  String image;
  String videoId;
  String pId;
  String title;
  String description;
  List<String> course;
  int servings;
  List<String> cuisine;
  List<String> diet;
  String time;
  int calories;
  String author;
  List<String> ingredients;
  List<String> instructions;
  List<String> nutrition;
  List<String> rawIngredients;
  String blurhash;
  double aspectRatio;
  String recipeId;

  factory RecipeModel.fromJson(String str) => RecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        url: json["url"],
        image: json["image"],
        videoId: json["video_id"],
        pId: json["p_id"],
        title: json["title"],
        description: json["description"],
        course: List<String>.from(json["course"].map((x) => x)),
        servings: json["servings"],
        cuisine: List<String>.from(json["cuisine"].map((x) => x)),
        diet: List<String>.from(json["diet"].map((x) => x)),
        time: json["time"],
        calories: json["calories"],
        author: json["author"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        nutrition: List<String>.from(json["nutrition"].map((x) => x)),
        rawIngredients: List<String>.from(json["raw_ingredients"].map((x) => x)),
        blurhash: json["blurhash"],
        aspectRatio: json["aspect_ratio"].toDouble(),
        recipeId: json["recipe_id"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "image": image,
        "video_id": videoId,
        "p_id": pId,
        "title": title,
        "description": description,
        "course": List<dynamic>.from(course.map((x) => x)),
        "servings": servings,
        "cuisine": List<dynamic>.from(cuisine.map((x) => x)),
        "diet": List<dynamic>.from(diet.map((x) => x)),
        "time": time,
        "calories": calories,
        "author": author,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "nutrition": List<dynamic>.from(nutrition.map((x) => x)),
        "raw_ingredients": List<dynamic>.from(rawIngredients.map((x) => x)),
        "blurhash": blurhash,
        "aspect_ratio": aspectRatio,
        "recipe_id": recipeId,
      };
}
