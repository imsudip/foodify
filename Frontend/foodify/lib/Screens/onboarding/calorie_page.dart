import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import '../../Widgets/button.dart';
import '../../Widgets/custom_list_tile.dart';
import '../../Widgets/text_box.dart';
import '../../ui/app_colors.dart';
import '../../ui/text_styles.dart';
import 'calorie_result.dart';

class CaloriePage extends StatefulWidget {
  const CaloriePage({Key? key}) : super(key: key);

  @override
  State<CaloriePage> createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  String gender = '';
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  List<String> activityLevels = ['Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active', 'Extremely Active'];
  @override
  void initState() {
    super.initState();
    var user = AuthController.authInstance.userData.value;
    gender = user['gender'] ?? '';
    ageController.text = user['age'] != null ? user['age'].toString() : '';
    heightController.text = user['height'] != null ? user['height'].toString() : '';
    weightController.text = user['weight'] != null ? user['weight'].toString() : '';
    selectedActivityLevel = activityLevels[user['activityLevel'] ?? 0];
  }

  String selectedActivityLevel = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text("Calculate your calorie intake",
            style: AppTextStyle.headline3.copyWith(color: AppColors.textPrimaryColor)),
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowBack),
          color: AppColors.textPrimaryColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose your gender",
                style: AppTextStyle.subHeading,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    label: Text(
                      ' Male ',
                      style: AppTextStyle.bodytext1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: gender == 'Male' ? AppColors.primaryWhiteColor : AppColors.textPrimaryColor),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    visualDensity: VisualDensity.comfortable,
                    labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.13, vertical: 8),
                    backgroundColor: AppColors.primaryWhiteColor,
                    selectedColor: AppColors.primaryColor,
                    selected: gender == 'Male',
                    onSelected: (v) {
                      setState(() {
                        gender = 'Male';
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      'Female',
                      style: AppTextStyle.bodytext1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: gender == 'Female' ? AppColors.primaryWhiteColor : AppColors.textPrimaryColor),
                    ),
                    visualDensity: VisualDensity.comfortable,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.13, vertical: 8),
                    backgroundColor: AppColors.primaryWhiteColor,
                    selectedColor: AppColors.primaryColor,
                    selected: gender == 'Female',
                    onSelected: (v) {
                      setState(() {
                        gender = 'Female';
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Age",
                        style: AppTextStyle.subHeading,
                      ),
                      Text(" in years", style: AppTextStyle.caption),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    controller: ageController,
                    hintText: "Enter your age",
                    obscureText: false,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Height",
                            style: AppTextStyle.subHeading,
                          ),
                          Text(" in cm", style: AppTextStyle.caption),
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                        controller: heightController,
                        hintText: "height",
                        obscureText: false,
                      ),
                    ],
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Weight",
                            style: AppTextStyle.subHeading,
                          ),
                          Text(" in kg", style: AppTextStyle.caption),
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(
                        controller: weightController,
                        hintText: "weight",
                        obscureText: false,
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Text("Choose your activity level", style: AppTextStyle.subHeading),
              Column(
                children: [
                  ...List.generate(activityLevels.length, (index) {
                    var activityLevel = activityLevels[index];
                    return CustomListTile(
                        isSelected: activityLevel == selectedActivityLevel,
                        title: activityLevel,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        borderRadius: 16,
                        onTap: () {
                          setState(() {
                            selectedActivityLevel = activityLevel;
                          });
                        });
                  })
                ],
              ),
              const SizedBox(height: 16),
              Button(
                height: 52,
                color: AppColors.primaryColor,
                text: 'Calculate your calorie intake',
                onPressed: () {
                  if (gender.isEmpty ||
                      ageController.text.isEmpty ||
                      heightController.text.isEmpty ||
                      weightController.text.isEmpty ||
                      selectedActivityLevel.isEmpty) {
                    return Get.snackbar(
                      'Error',
                      'Please fill all the fields',
                      backgroundColor: AppColors.accentColor,
                      snackPosition: SnackPosition.BOTTOM,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(16),
                    );
                  } else {
                    var age = num.tryParse(ageController.text) ?? -1;
                    var height = num.tryParse(heightController.text) ?? -1;
                    var weight = num.tryParse(weightController.text) ?? -1;
                    var activityLevel = activityLevels.indexOf(selectedActivityLevel);
                    if (age < 0 || height < 0 || weight < 0) {
                      return Get.snackbar(
                        'Error',
                        'Please fill all the fields correctly',
                        backgroundColor: AppColors.accentColor,
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(16),
                      );
                    }
                    Get.to(() => CalorieResult(
                          gender: gender,
                          age: age.toInt(),
                          height: height.toInt(),
                          weight: weight.toInt(),
                          activityLevel: activityLevel,
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
