// ignore_for_file: invalid_use_of_protected_member

import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:get/get.dart';

class SavedPageController extends GetxController {
  final _savedRecipes = <RecipeModel>[].obs;
  final _recipeIds = <String>[].obs;

  List<RecipeModel> get savedRecipes => _savedRecipes.value;
  List<String> get recipeIds => _recipeIds.value;

  // setter
  set savedRecipes(List<RecipeModel> value) {
    _savedRecipes.value = value;
    update();
  }

  set recipeIds(List<String> value) {
    _recipeIds.value = value;
    update();
  }

  @override
  void onReady() {
    AuthController authController = Get.find();
    authController.userData.listen((user) {
      if (recipeIds != authController.savedRecipes) {
        var removedItems = recipeIds.where((element) => !authController.savedRecipes.contains(element)).toList();
        for (var element in removedItems) {
          savedRecipes.removeWhere((recipe) => recipe.recipeId == element);
        }
        var addedItems = authController.savedRecipes.where((element) => !recipeIds.contains(element)).toList();
        for (var element in addedItems) {
          DatabaseService.instance.getRecipe(element).then((value) {
            savedRecipes.insert(0, value);
          });
        }
        recipeIds = authController.savedRecipes;
      }
    });
    _getSavedRecipes();
    super.onReady();
  }

  void _getSavedRecipes() async {
    recipeIds = AuthController.authInstance.savedRecipes;
    // await Future.delayed(Duration(milliseconds: 1000));
    DatabaseService.instance.paginateRecipes(recipeIds, savedRecipes.length).then((value) {
      savedRecipes.addAll(value);
    });
  }
}
