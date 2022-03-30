import 'package:flutter/material.dart';
import 'package:foodify/Controllers/auth_controller.dart';
import 'package:foodify/Screens/onboarding/diet_filter.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/card.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  var divider = const Divider(
    color: AppColors.textSecondaryColor,
  );
  List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extremely Active'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Iconsax.personalcard5,
              color: AppColors.primaryColor,
              size: 28,
            ),
            Text(
              ' Account Details',
              style: AppTextStyle.headline2.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.accentColor,
                  child: authController.firebaseUser.value?.photoURL != null
                      ? ClipOval(
                          child: Image.network(
                            authController.firebaseUser.value?.photoURL ?? '',
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Iconsax.people,
                          size: 52,
                          color: AppColors.primaryColor,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                authController.firebaseUser.value?.displayName ?? '',
                style: AppTextStyle.headline3.copyWith(color: AppColors.textPrimaryColor),
              ),
              Text(
                authController.firebaseUser.value?.email ?? '',
                style: AppTextStyle.bodytext2,
              ),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(" Personal Details", style: AppTextStyle.headline3)),
              const SizedBox(height: 6),
              CustomCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(children: [
                    _rowBulder('Food Preference',
                        '${authController.userData.value['diet'] ?? 'None'}'),
                    divider,
                    _rowBulder('Calories Intake',
                        '${authController.userData.value['calorie'] ?? 'None'} cal'),
                    divider,
                    _rowBulder('Weight',
                        '${authController.userData.value['weight'] ?? 'None'} kg'),
                    divider,
                    _rowBulder('Height',
                        '${authController.userData.value['height'] ?? 'None'} cm'),
                    divider,
                    _rowBulder(
                        'Age', '${authController.userData.value['age'] ?? 'None'}'),
                    divider,
                    _rowBulder(
                        'Gender', '${authController.userData.value['gender'] ?? 'None'}'),
                    divider,
                    _rowBulder(
                        'Activity Level',
                        activityLevels[
                            authController.userData.value['activityLevel'] ?? 0]),
                    const SizedBox(height: 12),
                    Button(
                      text: 'Change Personal Details',
                      height: 52,
                      color: AppColors.backgroundColor,
                      border: Border.all(color: AppColors.accentColor),
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        Get.to(() => DietFilterScreen());
                      },
                    ),
                  ])),
              const SizedBox(height: 12),
              Button(
                text: 'Logout',
                height: 52,
                onPressed: () {
                  authController.signOut();
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Row _rowBulder(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.bodytext2.copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.bodytext2.copyWith(color: AppColors.textPrimaryColor),
        ),
      ],
    );
  }
}
