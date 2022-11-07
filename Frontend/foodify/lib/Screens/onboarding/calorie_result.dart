import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../Widgets/button.dart';
import '../../ui/app_colors.dart';
import '../../ui/text_styles.dart';
import '../home.dart';

class CalorieResult extends StatefulWidget {
  final String gender;
  final int height, weight, age, activityLevel;
  const CalorieResult({
    Key? key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.activityLevel,
  }) : super(key: key);

  @override
  State<CalorieResult> createState() => _CalorieResultState();
}

class _CalorieResultState extends State<CalorieResult> {
  double value = 0.0;
  List<double> activityLevelsValues = [1.2, 1.375, 1.55, 1.725, 1.9];
  @override
  void initState() {
    double bmr;
    if (widget.gender == "Male") {
      bmr = 66.47 + (13.75 * widget.weight) + (5.003 * widget.height) - (6.755 * widget.age);
    } else {
      bmr = 655.1 + (9.563 * widget.weight) + (1.850 * widget.height) - (4.676 * widget.age);
    }
    double amr = bmr * activityLevelsValues[widget.activityLevel];
    value = amr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.backgroundColor,
      //   elevation: 0,

      // ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FocusScope(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/calorie_illustration.png',
                        ),
                        Positioned(
                          top: 2,
                          left: -16,
                          child: IconButton(
                            icon: const Icon(EvaIcons.arrowBack),
                            color: AppColors.textPrimaryColor,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Your Daily Calorie Intake is",
                    style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "${value.round()} Calories",
                    style: Get.textTheme.headline1,
                  ),
                  const SizedBox(height: 24),
                  Button(
                    height: 52,
                    color: AppColors.primaryColor,
                    text: 'Continue',
                    onPressed: () async {
                      await AuthController.authInstance.updateUserDocument({
                        'age': widget.age,
                        'gender': widget.gender,
                        'height': widget.height,
                        'weight': widget.weight,
                        'activityLevel': widget.activityLevel,
                        'calorie': value.round(),
                      });
                      Get.offAll(() => const Home());
                    },
                  ),
                  const SizedBox(height: 12),
                  Button(
                    height: 54,
                    color: AppColors.primaryWhiteColor,
                    border: Border.all(color: AppColors.accentColor),
                    text: "Recalculate",
                    textColor: AppColors.textPrimaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
