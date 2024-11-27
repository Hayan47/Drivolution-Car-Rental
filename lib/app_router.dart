import 'package:drivolution/data/repositories/car_repository.dart';
import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:drivolution/data/repositories/user_repository.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:drivolution/data/services/image_service.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/car_image_cubit/car_image_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/logic/notifications_bloc/notifications_bloc.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/logic/user_image_cubit/user_image_cubit.dart';
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
import 'package:drivolution/presentation/widgets/photo_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/presentation/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  late FirebaseStorage firebaseStorage;

  late CarServices carServices;
  late UserServices userServices;
  late ImageService imageService;

  late CarRepository carRepository;
  late UserRepository userRepository;
  late ImageRepository imageRepository;

  late CarsBloc carsBloc;
  late UserBloc userBloc;
  late ReservationBloc reservationBloc;
  late FavoriteBloc favoriteBloc;
  late LogoBloc logoBloc;
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  late AlbumBloc albumBloc;
  late NotificationsBloc notificationsBloc;
  late CarFormBloc carFormBloc;
  late AuthCubit authCubit;
  late CarImageCubit carImageCubit;
  late UserImageCubit userImageCubit;

  AppRouter() {
    firebaseStorage = FirebaseStorage.instance;

    imageService = ImageService(firebaseStorage: firebaseStorage);
    carServices = CarServices();
    userServices = UserServices();

    carRepository = CarRepository(carServices: carServices);
    userRepository = UserRepository(userServices: userServices);
    imageRepository = ImageRepository(imageService: imageService);

    carsBloc = CarsBloc(carRepository: carRepository);
    userBloc = UserBloc();
    favoriteBloc = FavoriteBloc(userRepository: userRepository);
    reservationBloc = ReservationBloc();
    logoBloc = LogoBloc(imageRepository: imageRepository);
    locationBloc = LocationBloc();
    mapBloc = MapBloc(imageService: imageService);
    albumBloc = AlbumBloc();
    notificationsBloc = NotificationsBloc();
    carFormBloc = CarFormBloc(
        carRepository: carRepository, imageRepository: imageRepository);

    authCubit = AuthCubit(userServices: userServices);
    carImageCubit = CarImageCubit(imageRepository: imageRepository);
    userImageCubit = UserImageCubit(imageRepository: imageRepository);
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
              BlocProvider.value(value: userImageCubit),
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
            create: (context) => MapBloc(imageService: imageService),
            child: MapScreen(car: car),
          ),
        );
      case 'addcarscreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: carFormBloc),
              BlocProvider.value(value: carsBloc),
              BlocProvider.value(value: carImageCubit),
              BlocProvider.value(value: logoBloc),
              BlocProvider.value(value: locationBloc),
              BlocProvider.value(value: albumBloc),
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
      case 'photoview':
        final imagesUrl = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) => PhotoViewPage(imagesUrl: imagesUrl),
        );
    }
    return null;
  }

  void dispose() {
    carsBloc.close();
    userBloc.close();
    reservationBloc.close();
    logoBloc.close();
    locationBloc.close();
    favoriteBloc.close();
    mapBloc.close();
    albumBloc.close();
    notificationsBloc.close();
    carFormBloc.close();
    authCubit.close();
    carImageCubit.close();
    userImageCubit.close();
  }
}
