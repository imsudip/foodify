import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../Constants/app_constant.dart';
import '../Controllers/database_service.dart';
import '../Widgets/button.dart';
import '../Widgets/card.dart';
import '../Widgets/loader.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';
import 'suggestions_page.dart';

class MealSuggestionTab extends StatefulWidget {
  const MealSuggestionTab({Key? key}) : super(key: key);

  @override
  State<MealSuggestionTab> createState() => _MealSuggestionTabState();
}

class _MealSuggestionTabState extends State<MealSuggestionTab> {
  final TextEditingController _typeAheadController = TextEditingController();

  final CupertinoSuggestionsBoxController _suggestionsBoxController = CupertinoSuggestionsBoxController();
  List<Map<String, dynamic>> _selectedingredients = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Meal Suggestion", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
              // Text("What would you like to eat today?", style: AppTextStyle.bodytext2),
              const SizedBox(
                height: 2,
              ),
              Text("Give us a few ingredients and we'll suggest a meal for you.",
                  textAlign: TextAlign.center, style: AppTextStyle.bodytext2),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: _searchBar(),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.centerLeft, child: Text("Selected ingredients", style: AppTextStyle.subHeading)),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _selectedingredients.isEmpty
                    ? Center(
                        child: Text("Add minimum 3 ingredient\nfor best results",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor)),
                      )
                    : ListView.builder(
                        itemCount: _selectedingredients.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            minVerticalPadding: 0,
                            leading: CachedNetworkImage(
                                imageUrl: AppConstant.instance.getFullImage(_selectedingredients[index]['image']),
                                height: 30,
                                width: 30),
                            title: Text(_selectedingredients[index]['ingredient'], style: AppTextStyle.bodytext2),
                            // subtitle: itemArray[3] != '' ? Text(itemArray[3], style: AppTextStyle.caption) : null,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            minLeadingWidth: 20,
                            trailing: IconButton(
                              icon: const Icon(
                                Iconsax.trash,
                                color: AppColors.textSecondaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedingredients.removeAt(index);
                                });
                              },
                            ),
                          );
                        }),
              ),
              Button(
                text: 'Suggest Meals',
                height: 52,
                onPressed: () async {
                  if (_selectedingredients.isEmpty) return;
                  Get.dialog(const BigPopupLoader());
                  List<RecipeModel> recipes = await DatabaseService.instance
                      .getMealSuggestions(List<String>.from(_selectedingredients.map((e) => e['ingredient']).toList()));
                  Get.back();
                  Get.to(() => SuggestionViewPage(suggestions: recipes));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  CupertinoTypeAheadFormField<Map<String, dynamic>> _searchBar() {
    return CupertinoTypeAheadFormField(
      getImmediateSuggestions: false,
      suggestionsBoxController: _suggestionsBoxController,
      minCharsForSuggestions: 2,
      hideOnEmpty: true,
      textFieldConfiguration: CupertinoTextFieldConfiguration(
        controller: _typeAheadController,
        placeholder: 'Search for ingredients',
        style: GoogleFonts.poppins(fontSize: 14),
        textInputAction: TextInputAction.search,
        onSubmitted: (val) {
          log(_typeAheadController.text);
        },
        suffix: GestureDetector(
          onTap: () {
            log(_typeAheadController.text);
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
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.accentColor.withOpacity(0.6)),
      ),
      suggestionsCallback: (pattern) {
        return DatabaseService.instance.getIngredientsSuggestions(pattern);
      },
      itemBuilder: (context, Map<String, dynamic> suggestion) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  suggestion['ingredient'],
                ),
                const Divider(
                  color: AppColors.accentColor,
                ),
              ],
            ),
          ),
        );
      },
      suggestionsBoxDecoration: CupertinoSuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryWhiteColor,
        border: Border.all(
          color: AppColors.accentColor,
          width: 1,
        ),
      ),
      onSuggestionSelected: (Map<String, dynamic> suggestion) {
        _typeAheadController.text = '';
        _suggestionsBoxController.close();
        setState(() {
          if (!_selectedingredients.any((element) => element['id'] == suggestion['id'])) {
            _selectedingredients.add(suggestion);
          }
        });
      },
    );
  }
}
