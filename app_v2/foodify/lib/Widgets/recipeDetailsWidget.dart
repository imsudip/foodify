import 'package:flutter/material.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(children: const [
        //   Image(
        //     image: AssetImage("images/recipe.png"),
        //     height: 20,
        //     width: 20,
        //   ),
        //   SizedBox(
        //     width: 6,
        //   ),
        //   Text(
        //     "Recipe",
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   )
        // ]),
        const SizedBox(
          height: 5,
        ),
        Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < recipe.instructions.length; i++)
                Builder(builder: (context) {
                  var recipeItem = recipe.instructions[i];
                  if (recipeItem.contains('@@T@@')) {
                    return Text(recipeItem.replaceAll('@@T@@', ""),
                        style: AppTextStyle.subHeading);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("images/bullet_red.png",
                              height: 20, width: 20),
                          Expanded(
                            child: Text(
                              recipe.instructions[i],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xff373737)
                                      .withOpacity(0.98)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  ;
                }),
            ],
          );
        }),
        const SizedBox(
          height: 8,
        ),
        recipe.videoId != ""
            ? Button(
                text: "Watch Video",
                height: 50,
                width: 150,
                onPressed: () => launchUrl(recipe.videoId),
              )
            : Container(),
      ],
    );
  }
}

void launchUrl(videoId) async {
  {
    if (!await launch("https://www.youtube.com/watch?v=$videoId"))
      throw 'Could not launch ';
  }
}
