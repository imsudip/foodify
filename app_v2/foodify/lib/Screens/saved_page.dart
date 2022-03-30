import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/Widgets/load_more_delegate.dart';
import 'package:foodify/Widgets/loader.dart';
import 'package:foodify/Widgets/recipe_card.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';

class SavedPage extends StatefulWidget {
  SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  AuthController authController = Get.find();

  List<RecipeModel> recipes = [];
  List<String> recipeIds = [];

  @override
  void initState() {
    super.initState();
    print("initState");

    authController.userData.listen((user) {
      if (recipeIds != authController.savedRecipes) {
        if (mounted) {
          // find if any element is removed from the recipeIds
          var removedItems = recipeIds
              .where((element) => !authController.savedRecipes.contains(element))
              .toList();
          for (var element in removedItems) {
            recipes.removeWhere((recipe) => recipe.recipeId == element);
          }
          recipeIds = authController.savedRecipes;
          if (recipes.isEmpty) {
            _getSavedRecipes();
          }
          setState(() {});
        }
      }
    });
    _getSavedRecipes();
  }

  @override
  void dispose() {
    print("dispose");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Iconsax.heart5,
              color: AppColors.primaryColor,
              size: 28,
            ),
            Text(
              ' Account Details',
              style: AppTextStyle.headline2.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: recipeIds.isEmpty
          ? Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  'images/loaders/not_found.json',
                  height: 150,
                ),
                Text(
                  "No Saved Recipes",
                  style: AppTextStyle.headline2,
                ),
                Text(
                  "You haven't saved any recipes yet",
                  style: AppTextStyle.caption,
                ),
                const SizedBox(height: 120),
              ],
            ))
          : recipes.isEmpty
              ? Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingWidget(
                      height: 200,
                    ),
                    const Text('Loading. . . '),
                  ],
                ))
              : GetBuilder<AuthController>(
                  // init: ,
                  builder: (_) {
                  List<String> favList = _.savedRecipes;
                  return LoadMore(
                    isFinish: recipes.length == recipeIds.length,
                    onLoadMore: () async {
                      var nList = await DatabaseService.instance
                          .paginateRecipes(recipeIds, recipes.length);
                      setState(() {
                        recipes.addAll(nList);
                      });

                      return Future.value(true);
                    },
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          recipe: recipes[index],
                          isFavorite: favList.contains(recipes[index].recipeId),
                        );
                      },
                    ),
                    delegate: ListLoading(),
                  );
                }),
    );
  }

  void _getSavedRecipes() async {
    recipeIds = AuthController.authInstance.savedRecipes;
    // await Future.delayed(Duration(milliseconds: 1000));
    DatabaseService.instance.paginateRecipes(recipeIds, recipes.length).then((value) {
      setState(() {
        recipes.addAll(value);
      });
    });
  }
}
