// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';

class CuisineListTile extends StatelessWidget {
  const CuisineListTile(
      {Key? key,
      required this.isSelected,
      required this.cuisineName,
      required this.onTap})
      : super(key: key);

  final bool isSelected;
  final String cuisineName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: isSelected
                    ? kredColor
                    : kgreyColor //Color.fromARGB(255, 189, 186, 186),
                ),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                cuisineName,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff0A0909),
                ),
              ),
            ),
            leading: Icon(
              Icons.check,
              color: isSelected ? kredColor : kwhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
