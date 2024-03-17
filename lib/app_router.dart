import 'package:drivolution/data/services/user_services.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/check_cubit/check_cubit.dart';
import 'package:drivolution/logic/doors_bloc/doors_bloc.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/logic/notifications_bloc/notifications_bloc.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/logic/seats_bloc/seats_bloc.dart';
import 'package:drivolution/logic/upload_bloc/upload_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/screens/add_car_screen.dart';
import 'package:drivolution/presentation/screens/car_details_screen.dart';
import 'package:drivolution/presentation/screens/date_range_picker.dart';
import 'package:drivolution/presentation/screens/forget_password.dart';
import 'package:drivolution/presentation/screens/location_picker.dart';
import 'package:drivolution/presentation/screens/log_in_screen.dart';
import 'package:drivolution/presentation/screens/map_screen.dart';
import 'package:drivolution/presentation/screens/my_cars_screen.dart';
import 'package:drivolution/presentation/screens/my_reservations.dart';
import 'package:drivolution/presentation/screens/sign_up_screen.dart';
import 'package:drivolution/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/presentation/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  late CarsBloc carsBloc;
  late UserBloc userBloc;
  late ReservationBloc reservationBloc;
  late FavoriteBloc favoriteBloc;
  late ImageBloc imageBloc;
  late LogoBloc logoBloc;
  late AllFieldsFormBloc allFieldsFormBloc;
  late DoorsBloc doorsBloc;
  late SeatsBloc seatsBloc;
  late FeaturesBloc featuresBloc;
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late AlbumBloc albumBloc;
  late UploadBloc uploadBloc;
  late AuthCubit authCubit;
  late CheckCubit checkCubit;
  late NotificationsBloc notificationsBloc;

  AppRouter() {
    carsBloc = CarsBloc();
    reservationBloc = ReservationBloc();
    favoriteBloc = FavoriteBloc();
    userBloc = UserBloc();
    imageBloc = ImageBloc();
    logoBloc = LogoBloc();
    allFieldsFormBloc = AllFieldsFormBloc();
    doorsBloc = DoorsBloc();
    seatsBloc = SeatsBloc();
    featuresBloc = FeaturesBloc();
    locationBloc = LocationBloc();
    mapBloc = MapBloc();
    albumBloc = AlbumBloc();
    uploadBloc = UploadBloc();
    authCubit = AuthCubit(userServices: UserServices());
    checkCubit = CheckCubit();
    notificationsBloc = NotificationsBloc();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case 'mainscreen':
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: userBloc),
              BlocProvider.value(value: carsBloc),
              BlocProvider.value(value: favoriteBloc),
              BlocProvider.value(value: authCubit),
              BlocProvider.value(value: notificationsBloc),
            ],
            child: const MainScreen(),
          ),
          type: PageTransitionType.leftToRight,
        );
      case 'cardetailsscreen':
        final car = settings.arguments as Car;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: carsBloc),
              BlocProvider.value(value: reservationBloc),
              BlocProvider.value(value: favoriteBloc),
              BlocProvider.value(value: authCubit),
            ],
            child: CarDetailsScreen(car: car),
          ),
        );
      case 'loginscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: const LogInScreen(),
          ),
        );
      case 'signupscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: const SignUpScreen(),
          ),
        );
      case 'forgetpasswordscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: ForgetPasswordScreen(),
          ),
        );
      case 'daterangepicker':
        final carID = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: reservationBloc,
            child: DateRangePicker(carid: carID),
          ),
        );
      case 'mapscreen':
        final car = settings.arguments as Car;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MapBloc(),
            child: MapScreen(car: car),
          ),
        );
      case 'addcarscreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: carsBloc),
              BlocProvider.value(value: imageBloc),
              BlocProvider.value(value: logoBloc),
              BlocProvider.value(value: allFieldsFormBloc),
              BlocProvider.value(value: doorsBloc),
              BlocProvider.value(value: seatsBloc),
              BlocProvider.value(value: featuresBloc),
              BlocProvider.value(value: locationBloc),
              BlocProvider.value(value: albumBloc),
              BlocProvider.value(value: uploadBloc),
              BlocProvider.value(value: checkCubit),
            ],
            child: AddCarScreen(),
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
      case 'mycarsscreen':
        final userID = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: MyCars(userID: userID),
          ),
        );
      case 'myreservationsscreen':
        final userID = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: reservationBloc),
              BlocProvider.value(value: carsBloc),
            ],
            child: MyReservations(userID: userID),
          ),
        );
    }
    return null;
  }

  void dispose() {
    // resCubit.close();
  }

  void disposeAddCarBlocs() {
    imageBloc.close();
    logoBloc.close();
    allFieldsFormBloc.close();
    doorsBloc.close();
    seatsBloc.close();
    featuresBloc.close();
    locationBloc.close();
    mapBloc.close();
    albumBloc.close();
    uploadBloc.close();
  }
}
