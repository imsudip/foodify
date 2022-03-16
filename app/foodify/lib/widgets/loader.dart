import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
