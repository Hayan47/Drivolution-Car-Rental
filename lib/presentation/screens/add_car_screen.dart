import 'package:drivolution/presentation/screens/add_car_screen1.dart';
import 'package:drivolution/presentation/screens/add_car_screen2.dart';
import 'package:drivolution/presentation/screens/add_car_screen3.dart';
import 'package:drivolution/presentation/screens/add_car_screen4.dart';
import 'package:flutter/material.dart';

class AddCarScreen extends StatelessWidget {
  final _pageController = PageController();
  AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //?gradiant effect
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff1E1E24),
              Color(0xff243B55),
              Color(0xff1E1E24),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const AddCar1(),
                    AddCar2(),
                    const AddCar3(),
                    const AddCar4(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Image.asset(
                      'assets/icons/arrow_left.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Image.asset(
                      'assets/icons/arrow_right.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
