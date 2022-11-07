import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/maps.dart';
import 'package:foodify/services/firebase.dart';
import 'package:foodify/services/popular_food_model.dart';
import 'package:foodify/services/recipe_model.dart';
import 'package:foodify/widgets/tags.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel? recipe;
  final PopularFoodModel? popularFood;

  const RecipeDetailScreen({Key? key, this.recipe, this.popularFood}) : super(key: key);
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late RecipeModel recipe;
  late PopularFoodModel pFood;
  bool isPopularFoods = false;
  bool isloading = false;
  @override
  void initState() {
    if (widget.recipe == null) {
      isPopularFoods = true;
      isloading = true;
      pFood = widget.popularFood!;
      DatabaseService().getRecipe(pFood.recipeId).then((value) {
        setState(() {
          recipe = value;
          isloading = false;
        });
      });
    } else {
      recipe = widget.recipe!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: isPopularFoods ? pFood.imageUrl : recipe.image,
                child: Container(
                  height: 359,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(isPopularFoods ? pFood.imageUrl : recipe.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(140),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.31),
                        blurRadius: 17,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: kToolbarHeight - 10,
                left: 16,
                child: _backButton(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPopularFoods ? pFood.name : recipe.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isPopularFoods)
                  Text(
                    pFood.recipeName,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff373737).withOpacity(0.85)),
                  ),
                const SizedBox(height: 8),
                if (!isloading)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Tag(text: recipe.diet, assetIcon: getDietIcon(recipe.diet)),
                      Tag(text: recipe.course, assetIcon: getCourseIcon(recipe.course)),
                      Tag(text: recipe.cuisine, assetIcon: 'tags/cuisine'),
                      Tag(text: recipe.serving.toString(), assetIcon: 'tags/Serving'),
                      Tag(
                          text: recipe.totalTime.toString() + " mins",
                          assetIcon: 'tags/time'),
                    ],
                  ),
                if (isPopularFoods)
                  const SizedBox(
                    height: 12,
                  ),
                if (isPopularFoods)
                  Text(
                    pFood.description,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff373737).withOpacity(0.6)),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: const [
                  Image(
                    image: AssetImage("images/Ingredients.png"),
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ]),
                //Add a padding of 10
                const SizedBox(
                  height: 5,
                ),
                //Add a textbox with the ingredients of the food
                Builder(builder: (context) {
                  var list = ((isPopularFoods ? pFood.ingredients : recipe.ingredients)
                          .replaceAll(",", " \n"))
                      .split("\n");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < list.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('🟡   ', style: TextStyle(fontSize: 12)),
                              Expanded(
                                child: Text(
                                  list[i],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xff373737).withOpacity(0.98)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
                //Add a padding of 20
                const SizedBox(
                  height: 20,
                ),
                Row(children: const [
                  Image(
                    image: AssetImage("images/recipe.png"),
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Recipe",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ]),

                const SizedBox(
                  height: 5,
                ),
                if (!isloading)
                  Builder(builder: (context) {
                    var list = recipe.instructions.trim().split('\n');

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < list.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('🟠   ', style: TextStyle(fontSize: 12)),
                                Expanded(
                                  child: Text(
                                    list[i],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xff373737).withOpacity(0.98)),
                                  ),
                                ),
                              ],
                            ),
                            //  Text(
                            //   list[i],
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.normal,
                            //       color: const Color(0xff373737).withOpacity(0.98)),
                            // ),
                          ),
                      ],
                    );
                  }),
              ],
            ),
          )
        ],
      ),
    ));
  }

  GestureDetector _backButton(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pop(context);
      }),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 17,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            color: kredColor,
          ),
        ),
      ),
    );
  }
}
