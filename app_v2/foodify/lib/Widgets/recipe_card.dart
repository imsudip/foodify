import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Screens/recipe_details.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/tags.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:octo_image/octo_image.dart';
import 'package:readmore/readmore.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool isFavorite;
  const RecipeCard({Key? key, required this.recipe, required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(
              recipe: recipe,
            ),
          ),
        );
      },
      child: CustomCard(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: recipe.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    OctoImage(
                      height: 200,
                      width: double.maxFinite,
                      image: NetworkImage(
                        recipe.image,
                      ),
                      placeholderBuilder: OctoPlaceholder.blurHash(
                        recipe.blurhash,
                      ),
                      errorBuilder: OctoError.icon(color: AppColors.primaryColor),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhiteColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: AppColors.accentColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                            child: LikeButton(
                          size: 22,
                          likeCountPadding: EdgeInsets.zero,
                          bubblesColor: const BubblesColor(
                              dotPrimaryColor: AppColors.primaryColor,
                              dotSecondaryColor: AppColors.accentColor),
                          circleColor: const CircleColor(
                            start: AppColors.primaryColor,
                            end: AppColors.accentColor,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked ? Iconsax.heart5 : Iconsax.heart,
                              color: isLiked
                                  ? AppColors.primaryColor
                                  : AppColors.textPrimaryColor.withOpacity(0.3),
                              size: 22,
                            );
                          },
                          isLiked: isFavorite,
                          onTap: (bool isLiked) async {
                            return await AuthController.authInstance.saveRecipe(
                              recipe.recipeId,
                            );
                          },
                        )),
                      ),
                      bottom: 12,
                      right: 12,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.title,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ReadMoreText(
              recipe.description,
              trimLines: 2,
              colorClickableText: AppColors.primaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              delimiter: '..  ',
              style: AppTextStyle.caption,
              moreStyle: AppTextStyle.caption.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.maxFinite,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  Tag(
                      text: recipe.calories.toString() + ' cal',
                      assetIcon: 'tags/calorie'),
                  Tag(text: recipe.servings.toString(), assetIcon: 'tags/Serving'),
                  Tag(text: recipe.time.toString(), assetIcon: 'tags/time'),
                  if (recipe.diet.first != '')
                    Tag(text: recipe.diet.join(' , '), assetIcon: 'tags/diet'),
                  if (recipe.course.first != '')
                    Tag(text: recipe.course.join(' , '), assetIcon: 'tags/course'),
                  if (recipe.cuisine.first != '')
                    Tag(text: recipe.cuisine.join(' , '), assetIcon: 'tags/cuisine'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
