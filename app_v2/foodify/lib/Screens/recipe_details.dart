import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:octo_image/octo_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controllers/auth_controller.dart';
import '../Widgets/button.dart';
import '../Widgets/ingredientDetails.dart';
import '../Widgets/loader.dart';
import '../Widgets/nutrition_details.dart';
import '../Widgets/recipeDetailsWidget.dart';
import '../Widgets/tab_title.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';
import '../widgets/tags.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> with SingleTickerProviderStateMixin {
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
                              color: AppColors.primaryWhiteColor,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(110),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.31),
                                  blurRadius: 17,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(110),
                              ),
                              child: OctoImage(
                                height: 359,
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
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            children: [
                              _backButton(context),
                              const Spacer(),
                              _saveButton(context),
                            ],
                          ),
                        ),
                        Positioned(right: 16, top: 75, child: _shareButton(context))
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(recipe.title, style: AppTextStyle.headline2)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 7,
                                alignment: WrapAlignment.center,
                                children: [
                                  Tag(text: '${recipe.calories} cal', assetIcon: 'tags/calorie'),
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
                              const SizedBox(height: 12),
                              recipe.videoId != ""
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Button(
                                            height: 50,
                                            width: double.maxFinite,
                                            color: AppColors.primaryWhiteColor,
                                            border: Border.all(color: AppColors.accentColor, width: 1),
                                            onPressed: () => launchUrlVideo(recipe.videoId),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
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
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Button(
                                          height: 50,
                                          width: 50,
                                          color: AppColors.primaryWhiteColor,
                                          border: Border.all(color: AppColors.accentColor, width: 1),
                                          onPressed: () => launch(recipe.url),
                                          child: const Icon(
                                            Iconsax.global,
                                            color: AppColors.primaryColor,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Button(
                                      height: 50,
                                      width: double.maxFinite,
                                      color: AppColors.primaryWhiteColor,
                                      border: Border.all(color: AppColors.accentColor, width: 1),
                                      onPressed: () => launch(recipe.url),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Iconsax.global,
                                            color: AppColors.primaryColor,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Visit Website',
                                            style: AppTextStyle.button,
                                          ),
                                        ],
                                      ),
                                    ),
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
                          unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
                          indicatorWeight: 0,
                          // isScrollable: true,
                          indicatorColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          indicator: BoxDecoration(
                            color: AppColors.primaryWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: const [
                            Tab(
                              height: 58,
                              child: TabTitle(image: "Ingredients", text: "Ingredients"),
                            ),
                            Tab(
                              height: 58,
                              child: TabTitle(image: "recipe", text: "Recipe"),
                            ),
                            Tab(
                              height: 58,
                              child: TabTitle(image: "nutrition", text: "Nutrition"),
                            ),
                          ],
                        ),
                      )),
                ];
              },
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBarView(children: [
                  // Icon(Icons.local_dining),
                  // Icon(Icons.local_dining),
                  SingleChildScrollView(child: IngredientsDetails(recipe: recipe)),
                  SingleChildScrollView(child: RecipeInstructionWidget(recipe: recipe)),
                  SingleChildScrollView(child: NutritionDetails(recipe: recipe)),
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

  GestureDetector _shareButton(BuildContext context) {
    return GestureDetector(
      onTap: (() async {
        Get.dialog(const PopupLoader());
        // generate dynamic link
        final dynamicLinkParams = DynamicLinkParameters(
          link: Uri.https(
            'foodify.page.link',
            recipe.recipeId,
          ),
          uriPrefix: "https://foodify.page.link",
          androidParameters: const AndroidParameters(packageName: "com.softperks.foodify"),
        );
        var link = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
        print(link.shortUrl);
        // download image
        var documentDirectory = await getApplicationDocumentsDirectory();
        var imagePath = '${documentDirectory.path}/image.png';
        var response = await get(Uri.parse(recipe.image));
        var file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        // share image

        Get.back();
        Share.shareFiles([
          file.path,
        ],
            text:
                'Check out this recipe for \n${recipe.title} \nClick the link to view recipe in FOODIFY app\n ${link.shortUrl}');
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
        child: Center(
          child: Icon(
            EvaIcons.shareOutline,
            color: AppColors.textPrimaryColor.withOpacity(0.3),
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
            bubblesColor:
                const BubblesColor(dotPrimaryColor: AppColors.primaryColor, dotSecondaryColor: AppColors.accentColor),
            circleColor: const CircleColor(
              start: AppColors.primaryColor,
              end: AppColors.accentColor,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                isLiked ? Iconsax.heart5 : Iconsax.heart,
                color: isLiked ? AppColors.primaryColor : AppColors.textPrimaryColor.withOpacity(0.3),
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
  // ignore: use_key_in_widget_constructors
  const CustomTabBar({
    required Widget child,
  }) : super(child: child, preferredSize: const Size.fromHeight(74));

  @override
  Size get preferredSize => const Size.fromHeight(74);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
