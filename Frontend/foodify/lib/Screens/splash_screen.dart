import 'package:flutter/material.dart';

import '../Widgets/loader.dart';
import '../ui/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/Foodify.png',
            height: 120,
          ),
          const SizedBox(
            height: 12,
          ),
          LoadingWidget(
            height: 100,
          )
        ],
      ),
    );
  }
}
