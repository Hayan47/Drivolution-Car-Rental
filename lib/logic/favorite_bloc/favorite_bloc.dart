import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/repositories/user_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final logger = LoggerService().getLogger('Favorite Bloc Logger');
  List<Car> favoriteCars = [];
  final UserRepository userRepository;
  FavoriteBloc({required this.userRepository}) : super(FavoriteInitial()) {
    on<GetFavoriteCars>(
      (event, emit) async {
        try {
            emit(FavoriteCarsLoading());
            logger.info(state);
            favoriteCars =
                await userRepository.getFavoriteCars(event.favoriteCarsIDs);
            emit(FavoriteCarsLoaded(favoriteCars));
            logger.info(state);
        } catch (e) {
          emit(const FavoriteError(message: 'Error Geitting Favorites'));
          logger.info(state);
          logger.severe(e);
        }
      },
    );
    on<AddCarToFavorites>(
      (event, emit) async {
        emit(AddingCarToFavorite(id: event.car.id!));
        logger.info(state);
        await  userRepository.addToFavorite(event.car.id!, event.userid);
        favoriteCars.add(event.car);
        Future.delayed(const Duration(seconds: 3));
        emit(FavoriteCarsLoaded(favoriteCars));
        logger.info(state);
      },
    );
    on<RemoveCarFromFavorites>(
      (event, emit) async {
        emit(RemovingCarFromFavorite(id: event.car.id!));
        logger.info(state);
        await userRepository.removeFromFavorite(event.car.id!, event.userid);
        favoriteCars.remove(event.car);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(FavoriteCarsLoaded(favoriteCars));
        logger.info(state);
      },
    );
  }
}
