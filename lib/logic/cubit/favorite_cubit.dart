import 'package:bloc/bloc.dart';
import 'package:drivolution/services/user_services.dart';
import 'package:meta/meta.dart';
import '../../data/models/car_model.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteCarsState> {
  List<Car> favoriteCars = [];

  FavoriteCubit() : super(FavoriteCarsLoading());

  //?add to favorites
  void addCarToFavorites(Car car, String userid) async {
    await UserServices().addToFavorite(car.id!, userid);
    favoriteCars.add(car);
    emit(FavoriteCarsLoaded(favoriteCars));
  }

  //?remove from favorites
  void removeCarFromFavorites(Car car, String userid) async {
    await UserServices().removeFromFavorite(car.id!, userid);
    favoriteCars.remove(car);
    emit(FavoriteCarsLoaded(favoriteCars));
  }

  //? get favorite cars
  Future<List<Car>> getFavoriteCars(List<String> favoriteCarsIds) async {
    emit(FavoriteCarsLoading());
    if (favoriteCarsIds.isEmpty) {
      emit(const FavoriteCarsLoaded([]));
      return [];
    }
    await UserServices().getFavoriteCars(favoriteCarsIds).then((favoriteCars) {
      emit(FavoriteCarsLoaded(favoriteCars));
      this.favoriteCars = favoriteCars;
    });
    return favoriteCars;
  }
}
