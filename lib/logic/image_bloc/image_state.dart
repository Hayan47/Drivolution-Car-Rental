part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageChanged extends ImageState {
  Uint8List image;

  ImageChanged(this.image);
}

class ImageError extends ImageState {
  final String errorMessage;

  const ImageError(this.errorMessage);
}
