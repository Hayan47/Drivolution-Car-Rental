part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

class FavoriteCarsLoading extends FavoriteState {}

class FavoriteCarsLoaded extends FavoriteState {
  final List<Car> favoriteCars;

  const FavoriteCarsLoaded(this.favoriteCars);

  // @override
  // List<Object> get props => [favoriteCars];
}

final class FavoriteError extends FavoriteState {
  final String errorMessage;

  const FavoriteError({required this.errorMessage});
}

class AddingCarToFavorite extends FavoriteState {
  final int id;

  const AddingCarToFavorite({required this.id});
}

class RemovingCarFromFavorite extends FavoriteState {
  final int id;

  const RemovingCarFromFavorite({required this.id});
}
