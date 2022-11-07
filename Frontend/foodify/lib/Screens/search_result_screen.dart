import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:lottie/lottie.dart';

import '../Controllers/auth_controller.dart';
import '../Controllers/database_service.dart';
import '../Widgets/load_more_delegate.dart';
import '../Widgets/loader.dart';
import '../Widgets/recipe_card.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchText;
  final bool haveResult;
  const SearchResultScreen({Key? key, required this.searchText, required this.haveResult}) : super(key: key);

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

  List<String> recipeIds = [];
  void _getRecipes() async {
    await DatabaseService.instance.getSuggestions(widget.searchText, limited: false).then((value) {
      recipeIds = value.map<String>((e) => e['recipe_id']).toList();
    });
    log('results found : ${recipeIds.length}');
    if (recipeIds.isNotEmpty) {
      recipes = await DatabaseService.instance.paginateRecipes(recipeIds, 0);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 62,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Results for "${widget.searchText}"',
                style: AppTextStyle.headline3.copyWith(color: AppColors.textPrimaryColor, height: 1),
              ),
              if (widget.haveResult)
                Text(
                  '${recipeIds.length} results found',
                  style: AppTextStyle.caption,
                ),
            ],
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
                    return LoadMore(
                      isFinish: recipeIds.length == recipes.length,
                      onLoadMore: () async {
                        var nList = await DatabaseService.instance.paginateRecipes(recipeIds, recipes.length);
                        setState(() {
                          recipes.addAll(nList);
                        });
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
                  }));
  }
}
