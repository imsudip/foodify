import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'Constants/app_constant.dart';
import 'Constants/firebase_constants.dart';
import 'Controllers/auth_controller.dart';
import 'Controllers/database_service.dart';
import 'Screens/splash_screen.dart';
import 'ui/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((value) async {
    // we are going to inject the auth controller over here!
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    AppConstant.instance.init();
    DatabaseService.instance.init();
    Get.put(AuthController(initialLink));
  });
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodify',
      theme: MyTheme.ligthTheme,
      home: const SplashScreen(),
    );
  }
}
