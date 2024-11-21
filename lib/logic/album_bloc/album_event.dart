part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class AddAlbumEvent extends AlbumEvent {}

class NoAlbumSelectedEvent extends AlbumEvent {}

class ResetAlbumEvent extends AlbumEvent {}
