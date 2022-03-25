// ignore_for_file: prefer_const_constructors

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/text_box.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';
import '../Controllers/auth_controller.dart';

class SignUp extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(EvaIcons.arrowBack),
            color: AppColors.textPrimaryColor,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FocusScope(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Welcome",
                      style: AppTextStyle.headline1,
                      textAlign: TextAlign.left,
                    ),
                  ),
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
                    height: 30,
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
                          margin: EdgeInsets.all(16),
                        );
                      }

                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        AuthController.authInstance.register(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          nameController.text.trim(),
                        );
                      } else {
                        Get.snackbar('Error', 'Passwords do not match',
                            backgroundColor: AppColors.accentColor,
                            snackPosition: SnackPosition.BOTTOM,
                            borderRadius: 10,
                            margin: EdgeInsets.all(16),
                            icon: Icon(Icons.error));
                      }
                    },
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         // this is for the register function in auth controller
                  //         AuthController.authInstance.register(
                  //             emailController.text.trim(),
                  //             passwordController.text.trim(),
                  //             "qwerty");
                  //       },
                  //       child: const Text("Sign Up"),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         // this is for the login function in auth controller
                  //         AuthController.authInstance.login(
                  //           emailController.text.trim(),
                  //           passwordController.text.trim(),
                  //         );
                  //       },
                  //       child: const Text("Login"),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
