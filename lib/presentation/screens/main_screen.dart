import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/presentation/screens/5screens/fav.dart';
import 'package:drivolution/presentation/screens/5screens/home.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/5screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '5screens/add.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  List<Car> favCars = [];
  List<String> favCarsIds = [];
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const AddCarScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    //?get cars
    await BlocProvider.of<CarsCubit>(context).getAllCars();
    //?get user info
    if (FirebaseAuth.instance.currentUser != null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      final usr = await context.read<UsrCubit>().getUserInfo(id);
      //?get favorite cars
      if (usr!.favoriteCars != null) {
        favCarsIds = usr.favoriteCars!;
        await context.read<FavoriteCubit>().getFavoriteCars(favCarsIds);
      }
    }
  }

  void navigateBottomNavBar(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          //?body
          // body: _screens[_selectedIndex],
          body: SizedBox.expand(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {},
              children: _screens,
            ),
          ),
        ),

        //!Google Nav Example
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 114, 121),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: GNav(
                  gap: 9,
                  haptic: false,
                  iconSize: 20,
                  padding: const EdgeInsets.all(13),
                  backgroundColor: const Color.fromARGB(255, 36, 114, 121),
                  color: MyColors.mywhite,
                  activeColor: MyColors.mywhite,
                  tabBackgroundGradient: LinearGradient(
                    colors: [
                      MyColors.myBlue2.withOpacity(0.87),
                      MyColors.myBlue2.withOpacity(0.3),
                    ],
                  ),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 16,
                      ),
                  tabs: const [
                    GButton(icon: FontAwesomeIcons.house, text: 'home'),
                    GButton(icon: FontAwesomeIcons.heart, text: 'favorite'),
                    GButton(icon: FontAwesomeIcons.car, text: 'add car'),
                    GButton(icon: FontAwesomeIcons.gear, text: 'settings'),
                    GButton(icon: FontAwesomeIcons.user, text: 'profile'),
                  ],
                  onTabChange: navigateBottomNavBar,
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
