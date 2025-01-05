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
          favoriteCars = await userRepository.getFavoriteCars(event.userid);
          emit(FavoriteCarsLoaded(favoriteCars));
          logger.info(state);
        } catch (e) {
          emit(FavoriteError(errorMessage: e.toString()));
          logger.severe(e);
        }
      },
    );
    on<AddCarToFavorites>(
      (event, emit) async {
        try {
          emit(AddingCarToFavorite(id: event.carid));
          await userRepository.addToFavorite(event.carid, event.userid);
          // favoriteCars.add(event.car);
          add(GetFavoriteCars(userid: event.userid));
          Future.delayed(const Duration(seconds: 3));
          emit(FavoriteCarsLoaded(favoriteCars));
        } catch (e) {
          emit(FavoriteError(errorMessage: e.toString()));
          logger.severe(e);
        }
      },
    );
    on<RemoveCarFromFavorites>(
      (event, emit) async {
        try {
          emit(RemovingCarFromFavorite(id: event.carid));
          await userRepository.removeFromFavorite(event.carid, event.userid);
          // favoriteCars.remove(event.car);
          add(GetFavoriteCars(userid: event.userid));
          await Future.delayed(const Duration(milliseconds: 500));
          emit(FavoriteCarsLoaded(favoriteCars));
        } catch (e) {
          emit(FavoriteError(errorMessage: e.toString()));
          logger.severe(e);
        }
      },
    );
  }
}
