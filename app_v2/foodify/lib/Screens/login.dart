import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Screens/sign_up.dart';
import 'package:foodify/Widgets/button.dart';
import 'package:foodify/Widgets/text_box.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';
import 'package:get/get.dart';
import '../Controllers/auth_controller.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                          'images/illustration2.png',
                        ),
                        Positioned(
                          top: 2,
                          left: -16,
                          child: IconButton(
                            icon: Icon(EvaIcons.arrowBack),
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
                    "Hello Again!",
                    style: Get.textTheme.headline1,
                  ),
                  Text(
                    "Welcome back! You have been missed.",
                    style: AppTextStyle.bodytext2
                        .copyWith(color: AppColors.textSecondaryColor),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 12),
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
                    height: 12,
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
                  const SizedBox(height: 12),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: AppTextStyle.bodytext2
                              .copyWith(color: AppColors.textSecondaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(() => SignUp());
                          },
                          child: Text(
                            " Sign up",
                            style: AppTextStyle.bodytext2
                                .copyWith(color: AppColors.primaryColor),
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
