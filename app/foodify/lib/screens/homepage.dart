import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/Foodify.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              CustomCard(
                  height: 220,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Search for your favorite recipe',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 52,
                        child: CupertinoTextField(
                          placeholder: 'Search for recipes',
                          style: GoogleFonts.poppins(fontSize: 14),
                          suffix: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'images/search.png',
                              height: 24,
                            ),
                          ),
                          suffixMode: OverlayVisibilityMode.always,
                          placeholderStyle: GoogleFonts.poppins(
                              fontSize: 14, color: kblackColor.withOpacity(0.5)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16), color: kgreyColor),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        'images/divider.png',
                      ),
                      const SizedBox(height: 12),
                      Button(
                        height: 52,
                        text: 'Customize your meal',
                        onPressed: () {},
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
