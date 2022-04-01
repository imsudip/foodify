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
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image(
        image: AssetImage("images/$image.png"),
        height: 20,
        width: 20,
      ),
      const SizedBox(height: 4),
      Text(
        text!,
        style: AppTextStyle.bodytext2.copyWith(fontWeight: FontWeight.w500),
      )
    ]);
  }
}
