import 'package:flutter/material.dart';
import '../ui/app_colors.dart';

class Tag extends StatelessWidget {
  final String text;
  final String assetIcon;
  const Tag({Key? key, required this.text, required this.assetIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accentColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(9),
      ),
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
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor),
          ),
        ],
      ),
    );
  }
}
