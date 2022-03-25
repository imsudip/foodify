import 'package:flutter/material.dart';
//import the package app_colors.dart
import 'package:foodify/ui/app_colors.dart';

class Button extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final String? text;
  final Function? onPressed;
  final double? fontSize;
  final BoxBorder? border;
  final Widget? child;
  final Color? textColor;
  const Button(
      {Key? key,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.color,
      this.text,
      this.onPressed,
      this.fontSize,
      this.border,
      this.child,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.1,
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        padding: padding ?? const EdgeInsets.all(0),
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        child: Center(
          child: child ??
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor ?? AppColors.primaryWhiteColor,
                  fontSize: fontSize ?? 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
      ),
    );
  }
}
