import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/screens/5screens/fav.dart';
import 'package:drivolution/presentation/screens/5screens/home.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/5screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '5screens/add.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Navigat arround the bottom nav bar
  int _selectedIndex = 0;
  // ignore: non_constant_identifier_names
  void _NavigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // different pages to navigate to
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const AddCarScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          //?body
          body: _screens[_selectedIndex],
          //?bottom nav bar
        ),

        //!Curved Example
        // Align(
        //   alignment: Alignment.center,
        //   child: Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: const Color.fromARGB(255, 36, 114, 121),
        //         borderRadius: BorderRadius.circular(14),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(15),
        //         child: CurvedNavigationBar(
        //           backgroundColor: Colors.transparent,
        //           color: const Color.fromARGB(255, 36, 114, 121),
        //           animationDuration: const Duration(milliseconds: 250),
        //           height: 30,
        //           onTap: _NavigateBottomNavBar,
        //           items: const [
        //             Icon(Icons.home, color: MyColors.mywhite, size: 25),
        //             Icon(Icons.favorite, color: MyColors.mywhite, size: 25),
        //             Icon(Icons.message, color: MyColors.mywhite, size: 25),
        //             Icon(Icons.settings, color: MyColors.mywhite, size: 25),
        //             Icon(Icons.person, color: MyColors.mywhite, size: 25),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        //!Google Nav Example
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                //cc
                color: const Color.fromARGB(255, 36, 114, 121),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: GNav(
                  gap: 6,
                  haptic: false,
                  iconSize: 25,
                  padding: const EdgeInsets.all(13),
                  //cc
                  backgroundColor: const Color.fromARGB(255, 36, 114, 121),
                  color: MyColors.mywhite,
                  activeColor: MyColors.mywhite,
                  tabBackgroundGradient: LinearGradient(
                    colors: [
                      MyColors.myBlue2.withOpacity(0.87),
                      MyColors.myBlue2.withOpacity(0.3),
                    ],
                  ),

                  tabs: const [
                    GButton(icon: Icons.home, text: 'home'),
                    GButton(icon: Icons.favorite, text: 'favorite'),
                    GButton(icon: Icons.add_circle_outline, text: 'add car'),
                    GButton(icon: Icons.settings, text: 'settings'),
                    GButton(icon: Icons.person, text: 'profile'),
                  ],
                  onTabChange: _NavigateBottomNavBar,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
