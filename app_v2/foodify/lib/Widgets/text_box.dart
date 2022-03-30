import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:foodify/ui/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.icon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isfocused = false;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          isfocused = value;
        });
      },
      child: Container(
        height: 54,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: CupertinoTextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          placeholder: widget.hintText,
          padding: EdgeInsets.symmetric(horizontal: 10),
          style: AppTextStyle.defaultFontStyle,
          prefix: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(widget.icon,
                      color: isfocused ? AppColors.primaryColor : AppColors.accentColor),
                )
              : null,
          decoration: BoxDecoration(
            color: AppColors.primaryWhiteColor,
            border: Border.all(
              color: AppColors.accentColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
