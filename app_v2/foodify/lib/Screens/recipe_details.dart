// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodify/Widgets/ingredientDetails.dart';
import 'package:foodify/Widgets/recipeDetailsWidget.dart';
import 'package:foodify/Widgets/tab_title.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:fraction/fraction.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:foodify/widgets/tags.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with SingleTickerProviderStateMixin {
  late RecipeModel recipe;
  TabController? tabController;
  @override
  void initState() {
    recipe = widget.recipe;

    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: recipe.image,
                  child: Container(
                    height: 359,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.image),
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
                  Text(recipe.title, style: AppTextStyle.headline2),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 7,
                    alignment: WrapAlignment.center,
                    children: [
                      Tag(
                          text: recipe.calories.toString() + ' cal',
                          assetIcon: 'tags/calorie'),
                      Tag(
                          text: recipe.servings.toString(),
                          assetIcon: 'tags/Serving'),
                      Tag(text: recipe.time.toString(), assetIcon: 'tags/time'),
                      if (recipe.diet.first != '')
                        Tag(
                            text: recipe.diet.join(' , '),
                            assetIcon: 'tags/diet'),
                      if (recipe.course.first != '')
                        Tag(
                            text: recipe.course.join(' , '),
                            assetIcon: 'tags/course'),
                      if (recipe.cuisine.first != '')
                        Tag(
                            text: recipe.cuisine.join(' , '),
                            assetIcon: 'tags/cuisine'),
                    ],
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    recipe.description,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff373737).withOpacity(0.6)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: TabBar(
                            labelColor: AppColors.primaryColor,
                            unselectedLabelColor:
                                AppColors.primaryColor.withOpacity(0.5),
                            indicatorColor: AppColors.primaryColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 3,
                            tabs: [
                              Tab(
                                child: TabTitle(
                                    image: "Ingredients", text: "Ingredients"),
                              ),
                              Tab(
                                child:
                                    TabTitle(image: "recipe", text: "Recipe"),
                              ),
                              Tab(
                                child: TabTitle(
                                    image: "nutrition", text: "nutrition"),
                              ),
                            ],
                          ),
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(children: [
                            // Icon(Icons.local_dining),
                            // Icon(Icons.local_dining),
                            IngredientsDetails(recipe: recipe),
                            RecipeDetails(recipe: recipe),
                            Icon(Icons.local_dining),
                          ]),
                        )
                      ],
                    ),
                  ),

                  //Add a textbox with the ingredients of the food

                  //Add a padding of 20
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            )
          ],
        ),
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
            //color: kredColor,
          ),
        ),
      ),
    );
  }
}
