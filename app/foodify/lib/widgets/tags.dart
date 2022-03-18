import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';

class Tag extends StatelessWidget {
  final String text;
  final String assetIcon;
  const Tag({Key? key, required this.text, required this.assetIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: kwhiteColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 136, 136, 136).withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/$assetIcon.png',
            height: 18,
            width: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: kblackColor),
          ),
        ],
      ),
    );
  }
}
