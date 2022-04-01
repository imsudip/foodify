import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodify/Screens/home_page.dart';
import 'package:foodify/Screens/saved_page.dart';
import 'package:foodify/ui/app_colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Controllers/auth_controller.dart';
import 'account_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentPage = 0;
  static final List<GlobalKey> _pageKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BottomBarPageTransition(
        builder: (_, index) => _getBody(index),
        currentIndex: _currentPage,
        totalLength: 3,
        transitionType: TransitionType.circular,
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOut,
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBody(int index) {
    return [
      HomePage(
        key: _pageKeys[index],
      ),
      SavedPage(
        key: _pageKeys[index],
      ),
      HomePage(
        key: _pageKeys[index],
      ),
      AccountPage(
        key: _pageKeys[index],
      ),
    ][index];
  }

  Widget _getBottomBar() {
    return DotNavigationBar(
      currentIndex: _currentPage,
      onTap: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      marginR: const EdgeInsets.only(right: 30, bottom: 12, left: 30),
      paddingR: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      dotIndicatorColor: const Color.fromARGB(0, 216, 7, 7),
      enablePaddingAnimation: false,
      boxShadow: [
        BoxShadow(
          color: const Color(0xff404040).withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 0),
        ),
      ],
      items: [
        /// Home
        DotNavigationBarItem(
            icon: const Icon(Iconsax.home5),
            selectedColor: AppColors.primaryColor,
            unselectedColor: AppColors.accentColor),

        /// Likes
        DotNavigationBarItem(
            icon: const Icon(Iconsax.heart5),
            selectedColor: AppColors.primaryColor,
            unselectedColor: AppColors.accentColor),

        /// Search
        DotNavigationBarItem(
            icon: const Icon(Icons.restaurant_rounded),
            selectedColor: AppColors.primaryColor,
            unselectedColor: AppColors.accentColor),

        /// Profile
        DotNavigationBarItem(
            icon: const Icon(Iconsax.personalcard5),
            selectedColor: AppColors.primaryColor,
            unselectedColor: AppColors.accentColor),
      ],
    );
  }
}
