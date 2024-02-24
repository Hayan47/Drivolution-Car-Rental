import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/logic/doors_bloc/doors_bloc.dart';
import 'package:drivolution/logic/dropdown_bloc/dropdown_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/logic/seats_bloc/seats_bloc.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/add_car_screen.dart';
import 'package:drivolution/presentation/screens/car_details_screen.dart';
import 'package:drivolution/presentation/screens/forget_password.dart';
import 'package:drivolution/presentation/screens/location_picker.dart';
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
  late ImageBloc imageBloc;
  late LogoBloc logoBloc;
  late DropdownBloc dropdownBloc;
  late AllFieldsFormBloc allFieldsFormBloc;
  late DoorsBloc doorsBloc;
  late SeatsBloc seatsBloc;
  late FeaturesBloc featuresBloc;
  late LocationBloc locationBloc;
  late MapBloc mapBloc;

  AppRouter() {
    carsCubit = CarsCubit();
    resCubit = ReservationsCubit();
    favoriteCarsCubit = FavoriteCubit();
    usrCubit = UsrCubit();
    imageBloc = ImageBloc();
    logoBloc = LogoBloc();
    dropdownBloc = DropdownBloc();
    allFieldsFormBloc = AllFieldsFormBloc();
    doorsBloc = DoorsBloc();
    seatsBloc = SeatsBloc();
    featuresBloc = FeaturesBloc();
    locationBloc = LocationBloc();
    mapBloc = MapBloc();
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
                    BlocProvider.value(value: resCubit),
                    BlocProvider.value(value: favoriteCarsCubit),
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
          builder: (_) => const ProfileScreen(),
        );
      case mapscreen:
        final car = settings.arguments as Car;
        return MaterialPageRoute(builder: (_) => MapScreen(car: car));
      case addcarscreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: carsCubit),
              BlocProvider.value(value: imageBloc),
              BlocProvider.value(value: logoBloc),
              BlocProvider.value(value: dropdownBloc),
              BlocProvider.value(value: allFieldsFormBloc),
              BlocProvider.value(value: doorsBloc),
              BlocProvider.value(value: seatsBloc),
              BlocProvider.value(value: featuresBloc),
              BlocProvider.value(value: locationBloc),
            ],
            child: const AddCarScreen(),
          ),
        );
      case 'locationpicker':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: locationBloc),
              BlocProvider.value(value: mapBloc),
            ],
            child: LocationPicker(),
          ),
        );
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
