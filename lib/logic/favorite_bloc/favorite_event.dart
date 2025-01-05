part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteCars extends FavoriteEvent {
  final int userid;

  const GetFavoriteCars({required this.userid});
}

class AddCarToFavorites extends FavoriteEvent {
  final int carid;
  final int userid;

  const AddCarToFavorites({required this.carid, required this.userid});
}

class RemoveCarFromFavorites extends FavoriteEvent {
  final int carid;
  final int userid;

  const RemoveCarFromFavorites({required this.carid, required this.userid});
}
