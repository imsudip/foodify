import 'package:flutter/material.dart';
import 'package:foodify/Widgets/card.dart';
import 'package:foodify/models/recipe_model.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';

class NutritionDetails extends StatelessWidget {
  const NutritionDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            Text(
              "Nutritional Details",
              style: AppTextStyle.subHeading,
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(recipe.nutrition.length, (index) {
              var items = recipe.nutrition[index].split(',');
              return Column(
                children: [
                  _rowBulder(items[0], items[1], items[2]),
                  const Divider(
                    color: AppColors.textSecondaryColor,
                  )
                ],
              );
            })
          ],
        ));
  }

  Row _rowBulder(String title, String value, String unit) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.bodytext2.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.bodytext2.copyWith(color: AppColors.textPrimaryColor),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          unit,
          style: AppTextStyle.bodytext2.copyWith(
              color: AppColors.textSecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 10),
        ),
      ],
    );
  }
}
