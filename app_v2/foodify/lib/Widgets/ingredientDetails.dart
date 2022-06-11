// ignore_for_file: file_names

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/app_constant.dart';
import '../models/recipe_model.dart';
import '../ui/app_colors.dart';
import '../ui/text_styles.dart';

class IngredientsDetails extends StatelessWidget {
  const IngredientsDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: FittedBox(
                      child: Text("Tap on the ingredient to search for it on ",
                          style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor)))),
              Image.asset(
                "images/AmazonFreshWordmark.png",
                height: 20,
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < recipe.ingredients.length; i++)
          Builder(builder: (context) {
            var item = recipe.ingredients[i];
            if (item.contains('@@T@@')) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(item.replaceAll('@@T@@', ""), style: AppTextStyle.subHeading),
              );
            } else {
              var itemArray = item.split(',');

              if (itemArray[0].contains("-")) {
              } else {
                var itemQ = itemArray[0];
                var i = double.tryParse(itemQ)?.toStringAsPrecision(1) ?? itemQ;
                // print(i);
                itemArray[0] = double.tryParse(i)?.toFraction().reduce().toString() ?? itemArray[0];
              }
              // print(itemArray[0]);
              return ListTile(
                // tileColor: Colors.red,
                onTap: () {
                  var url = "https://www.flipkart.com/search?q=${itemArray[2]}&as=on&as-show=on&marketplace=GROCERY";
                  var url2 =
                      Uri.parse("https://www.amazon.in/s?k=${itemArray[2]}&ref=nb_sb_noss_2&i=nowstore").toString();
                  log(url2);
                  launch(url2);
                },
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                leading: CachedNetworkImage(
                    imageUrl: AppConstant.instance.getIngredientImage(itemArray[2].trim().toLowerCase()),
                    height: 30,
                    width: 30),
                title: Text('${itemArray[0]} ${itemArray[1]} ${itemArray[2]}', style: AppTextStyle.bodytext2),
                subtitle: itemArray[3] != '' ? Text(itemArray[3], style: AppTextStyle.caption) : null,
                dense: true,
                visualDensity: VisualDensity.compact,
                minLeadingWidth: 20,
                trailing: const Icon(
                  EvaIcons.shoppingCartOutline,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              );
            }
          }),
      ],
    );
  }
}
