// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodify/ui/app_colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.isSelected,
      required this.title,
      required this.onTap,
      this.margin,
      this.borderRadius})
      : super(key: key);

  final bool isSelected;
  final String title;
  final Function onTap;
  final EdgeInsets? margin;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: margin ?? EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.05)
            : AppColors.primaryWhiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.accentColor //Color.fromARGB(255, 189, 186, 186),
            ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff0A0909),
          ),
        ),
        onTap: () => onTap(),
        trailing: Icon(
          Icons.check,
          color: isSelected ? AppColors.primaryColor : AppColors.primaryWhiteColor,
        ),
      ),
    );
  }
}
