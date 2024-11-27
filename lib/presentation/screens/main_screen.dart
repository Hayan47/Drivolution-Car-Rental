import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/logic/notifications_bloc/notifications_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/screens/5screens/add.dart';
import 'package:drivolution/presentation/screens/5screens/fav.dart';
import 'package:drivolution/presentation/screens/5screens/home.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/5screens/notifications.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
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
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
  late PageController _pageController;
  final List<Widget> _screens = [
    HomeScreen(),
    const FavoriteScreen(),
    const AddScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndexNotifier.value);
    loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    context.read<CarsBloc>().add(GetAllCarsEvent());
    final state = BlocProvider.of<AuthCubit>(context).state;
    if (state is Authenticated) {
      context.read<UserBloc>().add(GetUserInfo(userID: state.user.uid));
      context
          .read<NotificationsBloc>()
          .add(GetUserNotifications(userID: state.user.uid));
    }
  }

  void navigate(int index) {
    _currentIndexNotifier.value = index;
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
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return ResponsiveWidget(
            mobile: Builder(builder: (context) {
              _pageController =
                  PageController(initialPage: _currentIndexNotifier.value);
              return Stack(
                children: [
                  //! 1- Background Scaffold
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: AppColors.backgroundGradient,
                    ),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SizedBox.expand(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: _screens,
                        ),
                      ),
                    ),
                  ),
                  //! 2- Google Nav Example
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.charcoal,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          child: GNav(
                            selectedIndex: currentIndex,
                            gap: 9,
                            haptic: false,
                            iconSize: 20,
                            padding: EdgeInsets.symmetric(
                                vertical: 11, horizontal: 8),
                            backgroundColor: AppColors.charcoal,
                            color: AppColors.pureWhite,
                            activeColor: AppColors.pureWhite,
                            textStyle: AppTypography.h4.copyWith(
                              color: AppColors.pureWhite,
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
                              GButton(
                                  icon: FontAwesomeIcons.car, text: 'add car'),
                              GButton(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                icon: IconlyLight.notification,
                                text: 'notifications',
                                iconSize: 25,
                              ),
                              GButton(
                                icon: IconlyLight.profile,
                                text: 'profile',
                                iconSize: 25,
                              ),
                            ],
                            onTabChange: navigate,
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(milliseconds: 300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            //! Background Scaffold
            tablet: Builder(builder: (context) {
              _pageController =
                  PageController(initialPage: _currentIndexNotifier.value);
              return DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Row(
                    children: [
                      //! 1- Nav Rail
                      NavigationRail(
                        selectedIndex: currentIndex,
                        backgroundColor: AppColors.charcoal,
                        indicatorColor: AppColors.oceanBlue,
                        useIndicator: true,
                        leading: Image.asset(
                          'assets/img/logo/logo.png',
                          height: 35,
                          width: 35,
                        ),
                        // onDestinationSelected: navigateBottomNavBar,
                        onDestinationSelected: navigate,
                        destinations: [
                          NavigationRailDestination(
                            icon: Icon(IconlyLight.home),
                            label: Text(
                              'home',
                              style: AppTypography.h4.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(IconlyLight.heart),
                            label: Text(
                              'favorite',
                              style: AppTypography.h4.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(FontAwesomeIcons.car),
                            label: Text(
                              'add car',
                              style: AppTypography.h4.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(IconlyLight.notification),
                            label: Text(
                              'notifications',
                              style: AppTypography.h4.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            icon: Icon(IconlyLight.profile),
                            label: Text(
                              'profile',
                              style: AppTypography.h4.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //! 2- Screens Page View
                      Expanded(
                        child: SizedBox.expand(
                          child: PageView(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: _screens,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
