import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../ui/app_colors.dart';
import '../ui/text_styles.dart';
import 'card.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
  final double? height;
  LoadingWidget({Key? key, this.height}) : super(key: key);
  var r = Random();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: Lottie.asset('images/loaders/${r.nextInt(6) + 1}.json'),
    );
  }
}

class PopupLoader extends StatelessWidget {
  const PopupLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(height: 120, width: 120, child: LoadingWidget()),
    );
  }
}

class BigPopupLoader extends StatelessWidget {
  const BigPopupLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
          height: Get.height * 0.4,
          width: Get.width * 0.75,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('images/cooking.json'),
                const SizedBox(height: 10),
                Text('Our AI is cooking your recipe!',
                    style: AppTextStyle.subHeading.copyWith(color: AppColors.primaryColor.withOpacity(0.6))),
              ],
            ),
          )),
    );
  }
}
