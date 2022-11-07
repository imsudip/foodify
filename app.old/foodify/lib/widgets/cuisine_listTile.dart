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
    return Container(
      height: 54,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? kredColor.withOpacity(0.05) : kwhiteColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
            color: isSelected
                ? kredColor
                : kgreyColor //Color.fromARGB(255, 189, 186, 186),
            ),
      ),
      child: ListTile(
        title: Text(
          cuisineName,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff0A0909),
          ),
        ),
        onTap: () => onTap(),
        trailing: Icon(
          Icons.check,
          color: isSelected ? kredColor : kwhiteColor,
        ),
      ),
    );
  }
}
