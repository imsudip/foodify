import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/maps.dart';
import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/image_card.dart';

class DietFilterScreen extends StatefulWidget {
  const DietFilterScreen({Key? key}) : super(key: key);

  @override
  State<DietFilterScreen> createState() => _DietFilterScreenState();
}

class _DietFilterScreenState extends State<DietFilterScreen> {
  List<String> selectedDiets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Expanded(
                child: CustomCard(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                  child: Column(
                    children: [
                      const Text(
                        'Choose your Course',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Image.asset(
                        'images/filter/diet.png',
                        height: 144,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.98,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 30,
                            ),
                            children: [
                              for (var diet in DIETICONS.keys)
                                ImageCard(
                                  imagePath: getDietIcon(diet),
                                  text: diet,
                                  isSelected: selectedDiets.contains(diet),
                                  onTap: () {
                                    setState(() {
                                      if (selectedDiets.contains(diet)) {
                                        selectedDiets.remove(diet);
                                      } else {
                                        selectedDiets.add(diet);
                                      }
                                    });
                                  },
                                )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      text: 'Back',
                      height: 52,
                      color: kgreyColor,
                      fontSize: 18,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Button(
                      text: 'Next',
                      height: 52,
                      fontSize: 18,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
