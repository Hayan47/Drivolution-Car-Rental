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
  final String message;

  const FavoriteError({required this.message});
}

class AddingCarToFavorite extends FavoriteState {
  final String id;

  const AddingCarToFavorite({required this.id});
}

class RemovingCarFromFavorite extends FavoriteState {
  final String id;

  const RemovingCarFromFavorite({required this.id});
}
