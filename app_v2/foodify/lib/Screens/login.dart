import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/text_box.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:get/get.dart';
import '../Controllers/auth_controller.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FocusScope(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Hello Again!",
                    style: Get.textTheme.headline1,
                  ),
                ),
                SizedBox(height: 20),
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
                const SizedBox(
                  height: 30,
                ),
                Button(
                  height: 52,
                  color: AppColors.primaryColor,
                  text: 'Login',
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      AuthController.authInstance.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill all the fields',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.accentColor,
                        borderRadius: 10,
                        margin: EdgeInsets.all(16),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
