import 'package:flutter/material.dart';
import 'package:foodify/Constants/app_constant.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:fraction/fraction.dart';

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
                itemArray[0] =
                    double.tryParse(i)?.toFraction().reduce().toString() ?? itemArray[0];
              }
              // print(itemArray[0]);
              return ListTile(
                // tileColor: Colors.red,
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                leading: Image.network(
                    AppConstant.instance
                        .getIngredientImage(itemArray[2].trim().toLowerCase()),
                    height: 30,
                    width: 30),
                title: Text(itemArray[0] + ' ' + itemArray[1] + ' ' + itemArray[2],
                    style: AppTextStyle.bodytext2),
                subtitle: itemArray[3] != ''
                    ? Text(itemArray[3], style: AppTextStyle.caption)
                    : null,
                dense: true,
                visualDensity: VisualDensity.compact,
                minLeadingWidth: 20,
              );
            }
          }),
      ],
    );
  }
}
