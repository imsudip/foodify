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
                        "Choose your Cusine",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Image(
                      image: AssetImage("images/filter/cuisine.png"),
                      height: 158,
                      width: 158,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          // for(var cuisine in mainCuisines)
                          //   CuisineListTile()
                        ],
                      ),
                    ),
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
                  onPressed: () {},
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
}
