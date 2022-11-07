// ignore_for_file: avoid_print

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import '../ui/app_colors.dart';

class MealPlanner extends StatelessWidget {
  const MealPlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        accent: AppColors.primaryColor,
        backButton: true,
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
      ),
    );
  }
}
