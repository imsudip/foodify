import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/recipe_model.dart';
import '../ui/text_styles.dart';

class RecipeInstructionWidget extends StatelessWidget {
  const RecipeInstructionWidget({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 6,
          ),
          for (var i = 0; i < recipe.instructions.length; i++)
            Builder(builder: (context) {
              var recipeItem = recipe.instructions[i];
              if (recipeItem.contains('@@T@@')) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 4),
                  child: Text(recipeItem.replaceAll('@@T@@', ""), style: AppTextStyle.subHeading),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("images/bullet_red.png", height: 20, width: 20),
                      Expanded(
                        child: Text(
                          recipe.instructions[i],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff373737).withOpacity(0.98)),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
        ],
      );
    });
  }
}

void launchUrlVideo(videoId) async {
  {
    if (!await launch("https://www.youtube.com/watch?v=$videoId")) throw 'Could not launch ';
  }
}
