import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/auth_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome!"),
        actions: [
          IconButton(
              onPressed: () {
                // this icon button is for the user to signout
                AuthController.authInstance.signOut();
              },
              icon: const Icon(Icons.power_off))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Home Page"),
            Obx(() => Text(AuthController.authInstance.userData.value.toString())),
          ],
        ),
      ),
    );
  }
}
