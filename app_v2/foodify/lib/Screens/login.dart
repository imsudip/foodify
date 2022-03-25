import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/auth_controller.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: Get.textTheme.headline3,
              ),
              TextField(
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // this is for the register function in auth controller
                      AuthController.authInstance.register(emailController.text.trim(),
                          passwordController.text.trim(), "qwerty");
                    },
                    child: const Text("Sign Up"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // this is for the login function in auth controller
                      AuthController.authInstance.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // this is for the register function in auth controller
                  AuthController.authInstance.googleSignIn();
                },
                child: const Text("Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
