part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteCars extends FavoriteEvent {
  final List<String> favoriteCarsIDs;

  const GetFavoriteCars({required this.favoriteCarsIDs});
}

class AddCarToFavorites extends FavoriteEvent {
  final Car car;
  final String userid;

  const AddCarToFavorites({required this.car, required this.userid});
}

class RemoveCarFromFavorites extends FavoriteEvent {
  final Car car;
  final String userid;

  const RemoveCarFromFavorites({required this.car, required this.userid});
}
