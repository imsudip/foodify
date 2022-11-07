import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/maps.dart';
import 'package:foodify/screens/filters/diet_filter.dart';
import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';
import 'package:foodify/widgets/image_card.dart';

class CourseFilterScreen extends StatefulWidget {
  const CourseFilterScreen({Key? key}) : super(key: key);

  @override
  State<CourseFilterScreen> createState() => _CourseFilterScreenState();
}

class _CourseFilterScreenState extends State<CourseFilterScreen> {
  List<String> selectedCourses = [];

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
                        'images/filter/course.png',
                        height: 144,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.05,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 30,
                            ),
                            children: [
                              for (var course in coursesNames.keys)
                                ImageCard(
                                  imagePath: getCourseIcon(course),
                                  text: course,
                                  isSelected: selectedCourses.contains(course),
                                  onTap: () {
                                    setState(() {
                                      if (selectedCourses.contains(course)) {
                                        selectedCourses.remove(course);
                                      } else {
                                        selectedCourses.add(course);
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DietFilterScreen(),
                        ));
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
