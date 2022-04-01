import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Controllers/database_service.dart';
import 'package:foodify/Widgets/recipe_card.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/loader.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchText;
  final bool haveResult;
  const SearchResultScreen({Key? key, required this.searchText, required this.haveResult})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<RecipeModel> recipes = [];
  @override
  void initState() {
    super.initState();
    _getRecipes();
  }

  void _getRecipes() async {
    List<String> recipeIds = [];
    await DatabaseService.instance
        .getSuggestions(widget.searchText, limited: false)
        .then((value) {
      recipeIds = value.map<String>((e) => e['recipe_id']).toList();
    });
    if (recipeIds.isNotEmpty) {
      recipes = await DatabaseService.instance.getAllRecipes(recipeIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            'Results for "${widget.searchText}"',
            style: const TextStyle(color: AppColors.textPrimaryColor),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: !widget.haveResult
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LottieBuilder.network(
                    'https://assets10.lottiefiles.com/packages/lf20_dmw3t0vg.json',
                    height: 200,
                    width: 200,
                  ),
                  const Text('No Recipe found'),
                ],
              ))
            : recipes.isEmpty
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingWidget(
                        height: 200,
                      ),
                      const Text('Loading. . . '),
                    ],
                  ))
                : GetX<AuthController>(builder: (_) {
                    List<String> favList = _.savedRecipes;
                    return ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          recipe: recipes[index],
                          isFavorite: favList.contains(recipes[index].recipeId),
                        );
                      },
                    );
                  }));
  }
}
