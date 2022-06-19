import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../Controllers/auth_controller.dart';
import '../Controllers/database_service.dart';
import '../Widgets/load_more_delegate.dart';
import '../Widgets/loader.dart';
import '../Widgets/recipe_card.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';

class CategoryPage extends StatefulWidget {
  final String category, categoryText;
  const CategoryPage({Key? key, required this.category, required this.categoryText}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<RecipeModel> recipes = [];
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    DatabaseService.instance.getRecipesByCategory(widget.category).then((value) {
      setState(() {
        recipes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Text(
            widget.categoryText,
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
        body: recipes.isEmpty
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
            : GetX<AuthController>(
                builder: (_) {
                  List<String> favList = _.savedRecipes;
                  return LoadMore(
                    isFinish: isCompleted,
                    onLoadMore: () async {
                      var nList = await DatabaseService.instance
                          .getRecipesByCategory(widget.category, lastIndex: recipes.length);
                      setState(() {
                        recipes.addAll(nList);
                      });
                      if (nList.length < 10) {
                        setState(() {
                          isCompleted = true;
                        });
                      }
                      return Future.value(true);
                    },
                    delegate: ListLoading(),
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          recipe: recipes[index],
                          isFavorite: favList.contains(recipes[index].recipeId),
                        );
                      },
                    ),
                  );
                },
              ));
  }
}
