import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/screens/5screens/fav.dart';
import 'package:drivolution/presentation/screens/5screens/home.dart';
// import 'package:drivolution/presentation/screens/5screens/mess.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/5screens/settings.dart';
import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      //body
      body: _screens[_selectedIndex],
      //bottom nav bar
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: MyColors.myred,
      //   //Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      //   color: MyColors.myred,
      //   animationDuration: const Duration(milliseconds: 250),
      //   height: 60,
      //   onTap: _NavigateBottomNavBar,
      //   items: [
      //     Icon(Icons.home, color: Theme.of(context).backgroundColor, size: 25),
      //     Icon(Icons.favorite,
      //         color: Theme.of(context).backgroundColor, size: 25),
      //     Icon(Icons.message,
      //         color: Theme.of(context).backgroundColor, size: 25),
      //     Icon(Icons.settings,
      //         color: Theme.of(context).backgroundColor, size: 25),
      //     Icon(Icons.person,
      //         color: Theme.of(context).backgroundColor, size: 25),
      //   ],
      // ),
      bottomNavigationBar: Container(
        color: MyColors.myred3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: GNav(
            gap: 6,
            haptic: false,
            iconSize: 25,
            padding: const EdgeInsets.all(13),
            backgroundColor: MyColors.myred3,
            color: Theme.of(context).backgroundColor,
            tabBackgroundGradient: LinearGradient(colors: [
              Theme.of(context).backgroundColor.withOpacity(0.4),
              MyColors.myred2.withOpacity(0.5),
            ]),
            activeColor: Theme.of(context).backgroundColor,
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
    );
  }
}
