import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/car_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState(favoriteCars: []));

  void addCarToFavorites(Car car) {
    state.favoriteCars.add(car);
    emit(FavoriteState(favoriteCars: state.favoriteCars));
  }

  void removeCarFromFavorites(Car car) {
    state.favoriteCars.remove(car);
    emit(FavoriteState(favoriteCars: state.favoriteCars));
  }
}
