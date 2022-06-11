import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:octo_image/octo_image.dart';

import '../Screens/recipe_details.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../widgets/card.dart';

class SmallRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  // final bool isFavorite;
  const SmallRecipeCard({Key? key, required this.recipe}) : super(key: key);

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
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(
          left: 16,
        ),
        // height: 350,
        width: Get.width * 0.6,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: recipe.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: OctoImage(
                      height: 120,
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
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recipe.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              right: -10,
              child: Icon(
                Iconsax.arrow_circle_right5,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
