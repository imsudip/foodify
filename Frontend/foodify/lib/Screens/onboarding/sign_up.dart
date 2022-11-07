//

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/text_box.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';

import '../../Controllers/auth_controller.dart';
import 'login.dart';

class SignUp extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FocusScope(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            'images/illustration3.png',
                          ),
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
                    "Let's get started!",
                    style: AppTextStyle.headline1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Enter your details to create an account.",
                    style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                    icon: EvaIcons.personOutline,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    icon: EvaIcons.emailOutline,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    icon: EvaIcons.lockOutline,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    icon: EvaIcons.lockOutline,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Button(
                    height: 52,
                    color: AppColors.primaryColor,
                    text: 'Sign Up',
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        return Get.snackbar(
                          'Error',
                          'Please fill all the fields',
                          backgroundColor: AppColors.accentColor,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 10,
                          margin: const EdgeInsets.all(16),
                        );
                      }

                      if (passwordController.text == confirmPasswordController.text) {
                        AuthController.authInstance.register(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          nameController.text.trim(),
                        );
                        // Get.to(() => const DietFilterScreen());
                      } else {
                        Get.snackbar('Error', 'Passwords do not match',
                            backgroundColor: AppColors.accentColor,
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(16),
                            icon: const Icon(Icons.error));
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Center(
                      child: Image(
                        image: AssetImage('images/divider.png'),
                        height: 16,
                      ),
                    ),
                  ),
                  Button(
                    height: 54,
                    color: AppColors.primaryWhiteColor,
                    border: Border.all(color: AppColors.accentColor),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'images/google_icon.png',
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Sign up with Google",
                          style: AppTextStyle.button,
                        ),
                      ],
                    ),
                    onPressed: () {
                      AuthController.authInstance.googleSignIn();
                    },
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account?",
                          style: AppTextStyle.bodytext2.copyWith(color: AppColors.textSecondaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(() => Login());
                          },
                          child: Text(
                            " Sign in",
                            style: AppTextStyle.bodytext2.copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
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
