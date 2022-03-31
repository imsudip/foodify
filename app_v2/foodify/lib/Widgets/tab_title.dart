import 'package:flutter/material.dart';
import 'package:foodify/ui/text_styles.dart';

class TabTitle extends StatelessWidget {
  final String? image;
  final String? text;
  const TabTitle({Key? key, required this.image, required this.text})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image(
        image: AssetImage("images/$image.png"),
        height: 10,
        width: 10,
      ),
      SizedBox(
        width: 3,
      ),
      Text(
        text!,
        style: AppTextStyle.caption,
      )
    ]);
  }
}
