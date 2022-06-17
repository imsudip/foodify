// ignore_for_file: invalid_use_of_protected_member

import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final _recomended = <RecipeModel>[].obs;

  List<RecipeModel> get recomended => _recomended.value;

  @override
  void onReady() {
    DatabaseService.instance.getRandomRecipes().then((value) {
      _recomended.value = value;
    });
    super.onReady();
  }
}
