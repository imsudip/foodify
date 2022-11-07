import 'package:flutter/material.dart';
import 'package:foodify/maps.dart';
import 'package:foodify/screens/details.dart';
import 'package:foodify/services/recipe_model.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/tags.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(
            recipe: recipe,
          ),
        ),
      ),
      child: CustomCard(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: recipe.image,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: NetworkImage(recipe.image), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.name,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Tag(text: recipe.diet, assetIcon: getDietIcon(recipe.diet)),
                Tag(text: recipe.course, assetIcon: getCourseIcon(recipe.course)),
                Tag(text: recipe.cuisine, assetIcon: 'tags/cuisine'),
                Tag(text: recipe.serving.toString(), assetIcon: 'tags/Serving'),
                Tag(text: recipe.totalTime.toString() + " mins", assetIcon: 'tags/time'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
