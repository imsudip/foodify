import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/screens/details.dart';
import 'package:foodify/screens/filters/course_filter.dart';
import 'package:foodify/screens/search_result_screen.dart';
import 'package:foodify/services/apps_data.dart';
import 'package:foodify/services/firebase.dart';
import 'package:foodify/services/popular_food_model.dart';
import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/loader.dart';
import 'package:foodify/widgets/popular_food_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PopularFoodModel> _popularfoods = [];
  bool timeUp = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        timeUp = true;
      });
    });
    DatabaseService().getPopularFoods().then((value) {
      _popularfoods = value;
    });
  }

  final TextEditingController _typeAheadController = TextEditingController();
  final CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            suffix: GestureDetector(
                              onTap: () {
                                log(_typeAheadController.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SearchResultScreen(
                                      searchText: _typeAheadController.text,
                                      haveResult: DatabaseService()
                                          .getSuggestions(_typeAheadController.text)
                                          .isNotEmpty,
                                    );
                                  }),
                                );
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
                                color: kgreyColor),
                          ),
                          suggestionsCallback: (pattern) {
                            return DatabaseService().getSuggestions(pattern);
                          },
                          itemBuilder: (context, String suggestion) {
                            return Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  suggestion,
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected: (String suggestion) {
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
                            DatabaseService()
                                .getRecipe(AppsData.instance.getIdFromName(suggestion))
                                .then((value) {
                              Navigator.pop(context);
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                        recipe: value,
                                      )));
                            });
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CourseFilterScreen(),
                          ));
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
                    'Popular Recipes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              _popularfoods.isNotEmpty
                  ? SizedBox(
                      height: 420,
                      child: CarouselSlider.builder(
                        itemCount: _popularfoods.length,
                        itemBuilder:
                            (BuildContext context, int itemIndex, int pageViewIndex) =>
                                PopularFoodCard(
                          popularFood: _popularfoods[itemIndex],
                        ),
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 0.95,
                          viewportFraction: 0.68,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                        ),
                      ))
                  : LoadingWidget(
                      height: 250,
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
