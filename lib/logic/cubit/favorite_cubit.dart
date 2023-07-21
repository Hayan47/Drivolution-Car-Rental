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
    print("CAR ID ADED");
    favoriteCars.add(car);
    emit(FavoriteCarsLoaded(favoriteCars));
  }

  //?remove from favorites
  void removeCarFromFavorites(Car car, String userid) async {
    await UserServices().removeFromFavorite(car.id!, userid);
    print("CAR ID REMOVED");
    favoriteCars.remove(car);
    emit(FavoriteCarsLoaded(favoriteCars));
  }

  //? get favorite cars
  List<Car> getFavoriteCars(List<String> favoriteCarsIds) {
    UserServices().getFavoriteCars(favoriteCarsIds).then((favoriteCars) {
      emit(FavoriteCarsLoaded(favoriteCars));
      this.favoriteCars = favoriteCars;
    });
    return favoriteCars;
  }
}
