import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/Screens/category_screen.dart';
import 'package:foodify/Widgets/card.dart';
import 'package:foodify/Widgets/image_card.dart';
import 'package:foodify/Widgets/loader.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _typeAheadController = TextEditingController();
  final CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/Foodify.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              CustomCard(
                  height: 220,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Search for your favorite recipe',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        child: CupertinoTypeAheadFormField(
                          getImmediateSuggestions: false,
                          suggestionsBoxController: _suggestionsBoxController,
                          minCharsForSuggestions: 2,
                          hideOnEmpty: true,
                          textFieldConfiguration: CupertinoTextFieldConfiguration(
                            controller: _typeAheadController,
                            placeholder: 'Search for recipes',
                            style: GoogleFonts.poppins(fontSize: 14),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (val) {
                              print(val);
                            },
                            suffix: GestureDetector(
                              onTap: () {
                                log(_typeAheadController.text);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return SearchResultScreen(
                                //       searchText: _typeAheadController.text,
                                //       haveResult: DatabaseService()
                                //           .getSuggestions(_typeAheadController.text)
                                //           .isNotEmpty,
                                //     );
                                //   }),
                                // );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  'images/search.png',
                                  height: 24,
                                ),
                              ),
                            ),
                            suffixMode: OverlayVisibilityMode.always,
                            // placeholderStyle: GoogleFonts.poppins(
                            //     fontSize: 14, color: kblackColor.withOpacity(0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.accentColor),
                          ),
                          suggestionsCallback: (pattern) {
                            return DatabaseService.instance.getSuggestions(pattern);
                          },
                          itemBuilder: (context, Map<String, dynamic> suggestion) {
                            return Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  suggestion['title'],
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected: (Map<String, dynamic> suggestion) {
                            _typeAheadController.text = '';
                            // create a loading dialog
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Loading . . .',
                                        style: GoogleFonts.poppins()),
                                    content: SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: LoadingWidget(
                                          height: 120,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                            // search for the recipe
                            // DatabaseService()
                            //     .getRecipe(AppsData.instance.getIdFromName(suggestion))
                            //     .then((value) {
                            //   Navigator.pop(context);
                            //   Navigator.of(context).push(CupertinoPageRoute(
                            //       builder: (context) => RecipeDetailScreen(
                            //             recipe: value,
                            //           )));
                            // });
                          },
                          onSaved: (value) {
                            log(value!);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        'images/divider.png',
                      ),
                      const SizedBox(height: 12),
                      Button(
                        height: 52,
                        text: 'Customize your meal',
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const CourseFilterScreen(),
                          // ));
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Top Categories',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 0),
                  children: [
                    ImageCard(
                      imagePath: 'courses/main course',
                      text: "Indian",
                      isSelected: false,
                      onTap: () {
                        Get.to(() => const CategoryPage(
                            category: 'indian', categoryText: 'Indian recipes'));
                      },
                    ),
                    ImageCard(
                      imagePath: 'filter/cuisine',
                      text: "Veg Recipes",
                      isSelected: false,
                      onTap: () {
                        Get.to(() => const CategoryPage(
                            category: 'veg', categoryText: 'Veg Recipes'));
                      },
                    ),
                    ImageCard(
                      imagePath: 'courses/dinner',
                      text: "Dinner",
                      isSelected: false,
                      onTap: () {
                        Get.to(() => const CategoryPage(
                            category: 'dinner', categoryText: 'Dinner Recipes'));
                      },
                    ),
                    ImageCard(
                      imagePath: 'courses/dessert',
                      text: "Desserts",
                      isSelected: false,
                      onTap: () {
                        Get.to(() => const CategoryPage(
                            category: 'dessert', categoryText: 'Dessert Recipes'));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
