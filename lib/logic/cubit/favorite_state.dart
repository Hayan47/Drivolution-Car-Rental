part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteCarsState {
  const FavoriteCarsState();
}

class FavoriteCarsLoading extends FavoriteCarsState {}

class FavoriteCarsLoaded extends FavoriteCarsState {
  final List<Car> favoriteCars;

  const FavoriteCarsLoaded(this.favoriteCars);
}
