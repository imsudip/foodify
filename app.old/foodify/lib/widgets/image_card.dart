import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;
  final void Function()? onTap;
  const ImageCard(
      {Key? key,
      required this.imagePath,
      required this.text,
      required this.isSelected,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(children: [
          Positioned.fill(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? kredColor : kwhiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? kwhiteColor : kgreyColor,
                width: 1,
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color(0xff404040).withOpacity(0.08),
              //     blurRadius: 10,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
            ),
          )),
          Positioned(
              left: 0,
              right: 0,
              top: 8,
              child: SizedBox(
                height: 96,
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.asset(
                      'images/$imagePath.png',
                    )),
              )),
          Positioned(
            bottom: 11,
            left: 6,
            right: 6,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? kwhiteColor : kblackColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
