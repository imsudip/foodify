import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Screens/onboarding/calorie_page.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';

import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/image_card.dart';
import 'package:get/get.dart';

class DietFilterScreen extends StatefulWidget {
  const DietFilterScreen({Key? key}) : super(key: key);

  @override
  State<DietFilterScreen> createState() => _DietFilterScreenState();
}

class _DietFilterScreenState extends State<DietFilterScreen> {
  String selectedDiet = '';
  String veg = "Vegeterian";
  String nonVeg = "Non Vegeterian";
  @override
  void initState() {
    var user = AuthController.authInstance.userData.value;
    selectedDiet = user['diet'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset(
                      'images/Eat-pana.png',
                      height: 250,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'What Do You Eat?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "What is your food preference?",
                      style: AppTextStyle.bodytext2
                          .copyWith(color: AppColors.textSecondaryColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,
                        ),
                        children: [
                          ImageCard(
                              imagePath: "diets/veg protein",
                              text: "Vegeterian",
                              isSelected: selectedDiet == veg,
                              onTap: () {
                                setState(() {
                                  if (selectedDiet == veg)
                                    selectedDiet = '';
                                  else
                                    selectedDiet = veg;
                                });
                              }),
                          ImageCard(
                              imagePath: "diets/nonveg protein",
                              text: "Non Vegeterian",
                              isSelected: selectedDiet == nonVeg,
                              onTap: () {
                                setState(() {
                                  if (selectedDiet == nonVeg)
                                    selectedDiet = '';
                                  else
                                    selectedDiet = nonVeg;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Next',
                      height: 52,
                      fontSize: 18,
                      onPressed: () async {
                        await AuthController.authInstance
                            .updateUserDocument({'diet': selectedDiet});
                        Get.to(() => const CaloriePage());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
