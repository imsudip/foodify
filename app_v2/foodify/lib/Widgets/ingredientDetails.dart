import 'package:flutter/material.dart';
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
      children: [
        // Row(children: const [
        //   Image(
        //     image: AssetImage("images/Ingredients.png"),
        //     height: 20,
        //     width: 20,
        //   ),
        //   SizedBox(
        //     width: 6,
        //   ),
        //   Text(
        //     "Ingredients",
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   )
        // ]),
        //Add a padding of 10
        const SizedBox(
          height: 5,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < recipe.ingredients.length; i++)
              Builder(builder: (context) {
                var item = recipe.ingredients[i];
                if (item.contains('@@T@@')) {
                  return Text(item.replaceAll('@@T@@', ""),
                      style: AppTextStyle.subHeading);
                } else {
                  var itemArray = item.split(',');

                  if (itemArray[0].contains("-")) {
                    var itemSubArray = itemArray[0].split("-");
                    for (int i = 0; i < itemSubArray.length; i++) {
                      if (itemSubArray[i].contains(".")) {
                        var itemQ = itemSubArray[i];
                        var x = double.parse(itemQ).toStringAsPrecision(2);

                        itemSubArray[i] =
                            double.parse(x).toFraction().reduce().toString();
                      }
                    }
                    itemArray[0] = itemSubArray.join("-");
                  } else {
                    var itemQ = itemArray[0];
                    var i = double.parse(itemQ).toStringAsPrecision(1);
                    print(i);
                    itemArray[0] =
                        double.parse(i).toFraction().reduce().toString();
                  }

                  print(itemArray[0]);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //add an image
                          Image.asset("images/bullet_yellow.png",
                              height: 20, width: 20),
                          Text(
                              itemArray[0] +
                                  ' ' +
                                  itemArray[1] +
                                  ' ' +
                                  itemArray[2],
                              style: AppTextStyle.bodytext2),
                        ],
                      ),
                      if (itemArray[3] != '')
                        const SizedBox(
                          height: 1,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(itemArray[3], style: AppTextStyle.caption),
                      ),
                    ],
                  );
                }
              }),
          ],
        ),
      ],
    );
  }
}
