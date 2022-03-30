// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Screens/onboarding/login.dart';
import 'package:foodify/Screens/onboarding/sign_up.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      body: SafeArea(
        child: Column(children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: [
                Image.asset(
                  'images/Cooking-pana.png',
                ),
                Positioned(
                  top: -3,
                  left: 6,
                  child: Image.asset(
                    'images/Foodify.png',
                    height: 75,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Welcome to Foodify",
                  style: Get.textTheme.headline1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Foodify is a food recipe app that helps you find the best recipes for your diet.",
                  style: AppTextStyle.bodytext2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "Let's get started",
            style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    height: 54,
                    // width: 150,
                    color: AppColors.primaryColor,
                    text: 'Sign Up',
                    onPressed: () {
                      Get.to(() => SignUp());
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Button(
                    height: 54,
                    // width: 150,
                    color: AppColors.primaryWhiteColor,
                    border: Border.all(color: AppColors.accentColor),
                    textColor: AppColors.textPrimaryColor,
                    text: 'Sign In',
                    onPressed: () {
                      Get.to(() => Login());
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Image(
              image: AssetImage('images/divider.png'),
              height: 16,
            ),
          ),
          Button(
            height: 54,
            margin: EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.primaryWhiteColor,
            border: Border.all(color: AppColors.accentColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/google_icon.png',
                  height: 24,
                ),
                SizedBox(width: 8),
                Text(
                  "Sign in with Google",
                  style: AppTextStyle.button,
                ),
              ],
            ),
            onPressed: () {
              AuthController.authInstance.googleSignIn();
            },
          ),
          SizedBox(height: 32)
        ]),
      ),
    );
  }
}
