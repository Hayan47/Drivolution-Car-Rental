import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/screens/5screens/add.dart';
import 'package:drivolution/presentation/screens/5screens/fav.dart';
import 'package:drivolution/presentation/screens/5screens/home.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/5screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  final List<Widget> _screens = [
    HomeScreen(),
    const FavoriteScreen(),
    const AddScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];
  bool isFirstPage = true;

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
    context.read<CarsBloc>().add(GetAllCarsEvent());
    final state = BlocProvider.of<AuthCubit>(context).state;
    if (state is Authenticated) {
      context.read<UserBloc>().add(GetUserInfo(userID: state.user.uid));
    }
  }

  void navigateBottomNavBar(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          context.read<FavoriteBloc>().add(
              GetFavoriteCars(favoriteCarsIDs: state.userInfo.favoriteCars));
        }
      },
      child: Stack(
        children: [
          DecoratedBox(
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              //?body
              appBar: isFirstPage
                  ? null
                  : AppBar(
                      title: Row(
                        children: [
                          SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                          Image.asset(
                            'assets/img/logo/drivolution.png',
                            width: MediaQuery.sizeOf(context).width / 2,
                          ),
                        ],
                      ),
                    ),
              body: SizedBox.expand(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      isFirstPage = index == 0 || index == 4;
                    });
                  },
                  children: _screens,
                ),
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
                  color: const Color(0xff1E1E24),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: GNav(
                    gap: 9,
                    haptic: false,
                    iconSize: 20,
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                    backgroundColor: MyColors.myGrey,
                    color: MyColors.mywhite,
                    activeColor: MyColors.mywhite,
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyColors.mywhite,
                          fontSize: 16,
                        ),
                    tabs: const [
                      GButton(
                        icon: IconlyLight.home,
                        text: 'home',
                        iconSize: 25,
                      ),
                      GButton(
                        icon: IconlyLight.heart,
                        text: 'favorite',
                        iconSize: 25,
                      ),
                      GButton(icon: FontAwesomeIcons.car, text: 'add car'),
                      GButton(
                        icon: IconlyLight.setting,
                        text: 'settings',
                        iconSize: 25,
                      ),
                      GButton(
                        icon: IconlyLight.profile,
                        text: 'profile',
                        iconSize: 25,
                      ),
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
      ),
    );
  }
}
