import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../ui/app_colors.dart';
import '../../ui/text_styles.dart';
import '../../widgets/button.dart';
import '../../widgets/image_card.dart';
import 'calorie_page.dart';

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
                      style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor),
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
                                  if (selectedDiet == veg) {
                                    selectedDiet = '';
                                  } else {
                                    selectedDiet = veg;
                                  }
                                });
                              }),
                          ImageCard(
                              imagePath: "diets/nonveg protein",
                              text: "Non Vegeterian",
                              isSelected: selectedDiet == nonVeg,
                              onTap: () {
                                setState(() {
                                  if (selectedDiet == nonVeg) {
                                    selectedDiet = '';
                                  } else {
                                    selectedDiet = nonVeg;
                                  }
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
                        await AuthController.authInstance.updateUserDocument({'diet': selectedDiet});
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
