import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding, margin;
  const CustomCard(
      {Key? key, required this.child, this.height, this.width, this.padding, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.1,
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      padding: padding ?? const EdgeInsets.all(0),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: kwhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff404040).withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
