import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
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

class AppRouter {
  late CarsCubit carsCubit;
  late UsrCubit usrCubit;
  late ReservationsCubit resCubit;
  late FavoriteCubit favoriteCarsCubit;

  AppRouter() {
    carsCubit = CarsCubit();
    resCubit = ReservationsCubit();
    favoriteCarsCubit = FavoriteCubit();
    usrCubit = UsrCubit();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case mainScreen:
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: usrCubit),
              BlocProvider.value(value: carsCubit),
              BlocProvider.value(value: favoriteCarsCubit),
            ],
            child: const MainScreen(),
          ),
          type: PageTransitionType.leftToRight,
        );

      case cardetailsscreen:
        final car = settings.arguments as Car;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: resCubit,
                    ),
                    BlocProvider.value(
                      value: favoriteCarsCubit,
                    ),
                  ],
                  child: CarDetailsScreen(car: car),
                ));
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
      // case profiledetailsscreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => UsrCubit(),
      //       // value: UsrCubit(),
      //       child: const ProfileDetailsScreen(),
      //     ),
      //   );
      // case locationpickerscreen:
      //   return MaterialPageRoute(builder: (_) => LocationPicker());
      // case daterangepicker:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: resCubit,
      //             child: const DateRangePicker(),
      //           ));
    }
    return null;
  }

  void dispose() {
    carsCubit.close();
    usrCubit.close();
    resCubit.close();
    resCubit.close();
  }
}
