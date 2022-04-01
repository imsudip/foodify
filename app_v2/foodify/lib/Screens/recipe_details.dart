// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/ingredientDetails.dart';
import 'package:foodify/Widgets/recipeDetailsWidget.dart';
import 'package:foodify/Widgets/tab_title.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:fraction/fraction.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:foodify/widgets/tags.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';

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
  ScrollController scrollController = ScrollController();
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
        backgroundColor: AppColors.primaryWhiteColor,
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, b) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Stack(
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
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            children: [
                              _backButton(context),
                              Spacer(),
                              _saveButton(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(recipe.title,
                                      style: AppTextStyle.headline2)),
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
                                  Tag(
                                      text: recipe.time.toString(),
                                      assetIcon: 'tags/time'),
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
                                    color: const Color(0xff373737)
                                        .withOpacity(0.6)),
                              ),
                              const SizedBox(height: 12),
                              recipe.videoId != ""
                                  ? Button(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Iconsax.video_play,
                                            color: AppColors.primaryColor,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Watch Video',
                                            style: AppTextStyle.button,
                                          ),
                                        ],
                                      ),
                                      height: 50,
                                      width: double.maxFinite,
                                      color: AppColors.primaryWhiteColor,
                                      border: Border.all(
                                          color: AppColors.accentColor,
                                          width: 1),
                                      onPressed: () =>
                                          launchUrl(recipe.videoId),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverAppBar(
                      backgroundColor: AppColors.primaryWhiteColor,
                      floating: true,
                      pinned: true,
                      expandedHeight: 0,
                      elevation: 0,
                      bottom: CustomTabBar(
                        child: TabBar(
                          labelColor: AppColors.primaryColor,
                          unselectedLabelColor:
                              AppColors.primaryColor.withOpacity(0.5),
                          indicatorWeight: 0,
                          // isScrollable: true,
                          indicatorColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          indicator: BoxDecoration(
                            color: AppColors.primaryWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: const [
                            Tab(
                              height: 58,
                              child: TabTitle(
                                  image: "Ingredients", text: "Ingredients"),
                            ),
                            Tab(
                              height: 58,
                              child: TabTitle(image: "recipe", text: "Recipe"),
                            ),
                            Tab(
                              height: 58,
                              child: TabTitle(
                                  image: "nutrition", text: "Nutrition"),
                            ),
                          ],
                        ),
                      )),
                ];
              },
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TabBarView(children: [
                  // Icon(Icons.local_dining),
                  // Icon(Icons.local_dining),
                  SingleChildScrollView(
                      child: IngredientsDetails(recipe: recipe)),
                  SingleChildScrollView(child: RecipeDetails(recipe: recipe)),
                  Icon(Icons.local_dining),
                ]),
              ),
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

  Widget _saveButton(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      List<String> favList = _.savedRecipes;
      return GestureDetector(
        onTap: (() {}),
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
          child: Center(
              child: LikeButton(
            size: 28,
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
                size: 28,
              );
            },
            isLiked: favList.contains(recipe.recipeId),
            onTap: (bool isLiked) async {
              return await AuthController.authInstance.saveRecipe(
                recipe.recipeId,
              );
            },
          )),
        ),
      );
    });
  }
}

class CustomTabBar extends PreferredSize {
  CustomTabBar({
    required Widget child,
  }) : super(child: child, preferredSize: Size.fromHeight(74));

  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
