import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const ProfileScreen();
    }
    return DecoratedBox(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppBar(
                title: Row(
                  children: [
                    SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                    const Text(
                      'Add Car',
                    ),
                  ],
                ),
              ),
              Image.asset('assets/lottie/add_car.png'),
              Text(
                'add your cars for others to rent!',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, addcarscreen);
              },
              backgroundColor: MyColors.myBlue,
              label: const Text("Add Car"),
            ),
          ),
        ],
      ),
    );
  }
}
