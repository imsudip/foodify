import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/services/firebase.dart';
import 'package:foodify/services/recipe_model.dart';
import 'package:foodify/widgets/loader.dart';
import 'package:foodify/widgets/recipe_card.dart';
import 'package:lottie/lottie.dart';

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
    DatabaseService().getRecipesByNameList(widget.searchText).then((value) {
      setState(() {
        recipes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgWhite,
        appBar: AppBar(
          backgroundColor: kbgWhite,
          elevation: 0,
          title: Text(
            'Result for ${widget.searchText}',
            style: TextStyle(color: kblackColor),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kredColor,
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
                : ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        recipe: recipes[index],
                      );
                    },
                  ));
  }
}
