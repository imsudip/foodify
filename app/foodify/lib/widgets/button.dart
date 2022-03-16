import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';

class Button extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final String? text;
  final Function? onPressed;
  final double? fontSize;
  const Button(
      {Key? key,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.color,
      this.text,
      this.onPressed,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.1,
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      padding: padding ?? const EdgeInsets.all(0),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color ?? kredColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text ?? '',
          style: TextStyle(
            color: (color?.computeLuminance() ?? 1) > 0.5 ? kwhiteColor : kblackColor,
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
