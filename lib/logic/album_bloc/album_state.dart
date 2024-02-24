part of 'album_bloc.dart';

sealed class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

final class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumChanged extends AlbumState {
  final List<Uint8List> images;

  const AlbumChanged(this.images);
}

class AlbumError extends AlbumState {
  final String errorMessage;

  const AlbumError(this.errorMessage);
}
