import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Controllers/savedpaged_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';

import '../Controllers/auth_controller.dart';
import '../Controllers/database_service.dart';
import '../Widgets/load_more_delegate.dart';
import '../Widgets/loader.dart';
import '../Widgets/recipe_card.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final _savepageController = Get.put(SavedPageController());
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("initState");
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print("dispose");
    }
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
              ' Saved Recipes',
              style: AppTextStyle.headline2.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () {
          return _savepageController.recipeIds.isEmpty
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
              : _savepageController.savedRecipes.isEmpty
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
                  : GetX<AuthController>(
                      // init: ,
                      builder: (_) {
                      List<String> favList = _.savedRecipes;
                      return LoadMore(
                        isFinish: _savepageController.savedRecipes.length == _savepageController.recipeIds.length,
                        onLoadMore: () async {
                          var nList = await DatabaseService.instance
                              .paginateRecipes(_savepageController.recipeIds, _savepageController.savedRecipes.length);
                          setState(() {
                            _savepageController.savedRecipes.addAll(nList);
                          });

                          return Future.value(true);
                        },
                        delegate: ListLoading(),
                        child: ListView.builder(
                          itemCount: _savepageController.savedRecipes.length,
                          itemBuilder: (context, index) {
                            return RecipeCard(
                              recipe: _savepageController.savedRecipes[index],
                              isFavorite: favList.contains(_savepageController.savedRecipes[index].recipeId),
                            );
                          },
                        ),
                      );
                    });
        },
      ),
    );
  }

  // void _getSavedRecipes() async {
  //   recipeIds = AuthController.authInstance.savedRecipes;
  //   // await Future.delayed(Duration(milliseconds: 1000));
  //   DatabaseService.instance.paginateRecipes(recipeIds, recipes.length).then((value) {
  //     setState(() {
  //       recipes.addAll(value);
  //     });
  //   });
  // }
}
