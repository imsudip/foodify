import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodify/screens/filters/cuisine_filter.dart';
import 'package:foodify/screens/details.dart';
import 'package:foodify/screens/homepage.dart';
import 'package:foodify/services/apps_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('filters');
  // Initialize Firebase
  await Firebase.initializeApp();
  // Get the constants from the db
  await AppsData.instance.init();
  // Initialize the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodify',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
