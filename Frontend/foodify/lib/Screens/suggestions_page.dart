import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Controllers/auth_controller.dart';
import '../Widgets/recipe_card.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';

class SuggestionViewPage extends StatelessWidget {
  final List<RecipeModel> suggestions;
  const SuggestionViewPage({Key? key, required this.suggestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 62,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Our Suggested Recipes',
                style: AppTextStyle.headline3.copyWith(color: AppColors.textPrimaryColor, height: 1),
              ),
              Text(
                'Based on your preferences',
                style: AppTextStyle.bodytext2.copyWith(color: AppColors.primaryColor.withOpacity(0.6)),
              ),
            ],
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: suggestions.isEmpty
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LottieBuilder.network(
                    'https://assets10.lottiefiles.com/packages/lf20_dmw3t0vg.json',
                    height: 200,
                    width: 200,
                  ),
                  const Text('Sorry, We could not find any recipes for you'),
                ],
              ))
            : GetX<AuthController>(builder: (_) {
                List<String> favList = _.savedRecipes;
                return ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      recipe: suggestions[index],
                      isFavorite: favList.contains(suggestions[index].recipeId),
                    );
                  },
                );
              }));
  }
}
