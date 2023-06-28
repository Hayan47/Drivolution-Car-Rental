import 'package:drivolution/business-logic/cubit/cars_cubit.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/repository/cars_repository.dart';
import 'package:drivolution/data/web_services/cars_web_services.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/car_details_screen.dart';
import 'package:drivolution/presentation/screens/forget_password.dart';
import 'package:drivolution/presentation/screens/log_in_screen.dart';
import 'package:drivolution/presentation/screens/map_screen.dart';
import 'package:drivolution/presentation/screens/sign_up_screen.dart';
import 'package:drivolution/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/presentation/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'business-logic/cubit/usr_cubit.dart';

class AppRouter {
  late CarsRepository carsRepository;
  late CarsCubit carsCubit;
  late UsrCubit usrCubit;

  AppRouter() {
    carsRepository = CarsRepository(CarsWebServices());
    carsCubit = CarsCubit(carsRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case mainScreen:
        return PageTransition(
          child: BlocProvider(
            create: (BuildContext context) => carsCubit,
            child: const MainScreen(),
          ),
          type: PageTransitionType.leftToRight,
        );

      case cardetailsscreen:
        final car = settings.arguments as Car;
        return MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car));
      case loginscreen:
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      case signupscreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgetpasswordscreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case profilescreen:
        return MaterialPageRoute(
          builder: (_) =>
              // BlocProvider.value(
              // value: usrCubit,
              // child:
              const ProfileScreen(),
          // )
        );
      case mapscreen:
        final car = settings.arguments as Car;
        return MaterialPageRoute(builder: (_) => MapScreen(car: car));
    }
    return null;
  }
}
