// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/colors.dart';
import 'package:foodify/main.dart';
import 'package:foodify/maps.dart';
import 'package:foodify/widgets/button.dart';
import 'package:foodify/widgets/card.dart';

import '../../widgets/cuisine_listTile.dart';

class CuisineFilterScreen extends StatefulWidget {
  const CuisineFilterScreen({Key? key}) : super(key: key);

  @override
  State<CuisineFilterScreen> createState() => _CuisineFilterScreenState();
}

class _CuisineFilterScreenState extends State<CuisineFilterScreen> {
  List<String> selectedCuisines = [];
  List<String> mainList = [];
  bool isMoreCuisines = false;
  bool isvisible = true;
  bool warning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 67, left: 15, right: 15, bottom: 30),
              child: CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Choose your Cuisine",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Image(
                      image: AssetImage("images/filter/cuisine.png"),
                      height: 144,
                      width: 144,
                    ),
                    if (warning)
                      Text(
                        "Max 10 options can be selected",
                        style: TextStyle(
                            fontSize: 12,
                            color: kredColor,
                            fontWeight: FontWeight.bold),
                      ),
                    Expanded(
                        child: ListView(
                      children: [
                        for (var cuisine in mainCuisines)
                          CuisineListTile(
                            cuisineName: cuisine,
                            isSelected: selectedCuisines.contains(cuisine),
                            onTap: () {
                              _addToList(cuisine);
                            },
                          ),
                        !isMoreCuisines
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isMoreCuisines = !isMoreCuisines;
                                        print(selectedCuisines);
                                      });
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Text(
                                        "More Cuisines",
                                        style: TextStyle(
                                            color: kredColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "More Cuisines",
                                      style: TextStyle(
                                          color: kblackColor.withOpacity(0.5),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Divider(
                                      color: kgreyColor,
                                      height: 1,
                                    )),
                                  ],
                                ),
                              ),
                        if (isMoreCuisines)
                          for (var cuisine in secondaryCuisine.keys)
                            CuisineListTile(
                              cuisineName: cuisine,
                              isSelected: selectedCuisines.contains(cuisine),
                              onTap: () {
                                _addToList(cuisine);
                              },
                            ),
                        if (isMoreCuisines)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMoreCuisines = !isMoreCuisines;
                                    print(selectedCuisines);
                                  });
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text(
                                    "Show less",
                                    style: TextStyle(
                                        color: kredColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 25, left: 15, right: 8),
                child: Button(
                  height: 51,
                  width: 167,
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Color(0xffE7E9EA),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: Button(
                    height: 51, width: 167, text: "Next", onPressed: () {}),
              ),
            ],
          )
        ],
      ),
    );
  }

  _addToList(String cuisine) {
    if (selectedCuisines.length == 10) {
      setState(() {
        warning = true;
      });
    } else {
      setState(() {
        warning = false;
      });
      if (selectedCuisines.contains(cuisine)) {
        selectedCuisines.remove(cuisine);
      } else {
        selectedCuisines.add(cuisine);
      }
    }
  }
}
