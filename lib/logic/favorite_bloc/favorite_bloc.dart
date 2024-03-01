import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<Car> favoriteCars = [];
  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavoriteCars>(
      (event, emit) async {
        try {
          if (event.favoriteCarsIDs.isEmpty) {
            print(state);
            emit(const FavoriteCarsLoaded([]));
          } else {
            emit(FavoriteCarsLoading());
            print(state);
            favoriteCars =
                await UserServices().getFavoriteCars(event.favoriteCarsIDs);
            emit(FavoriteCarsLoaded(favoriteCars));
            print(state);
          }
        } catch (e) {
          emit(const FavoriteError(message: 'Error Geitting Favorites'));
          print(state);
        }
      },
    );
    on<AddCarToFavorites>(
      (event, emit) async {
        emit(AddingCarToFavorite(id: event.car.id!));
        print(state);
        await await UserServices().addToFavorite(event.car.id!, event.userid);
        favoriteCars.add(event.car);
        Future.delayed(const Duration(seconds: 3));
        emit(FavoriteCarsLoaded(favoriteCars));
        print(state);
      },
    );
    on<RemoveCarFromFavorites>(
      (event, emit) async {
        emit(RemovingCarFromFavorite(id: event.car.id!));
        print(state);
        await UserServices().removeFromFavorite(event.car.id!, event.userid);
        favoriteCars.remove(event.car);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(FavoriteCarsLoaded(favoriteCars));
        print(state);
      },
    );
  }
}
