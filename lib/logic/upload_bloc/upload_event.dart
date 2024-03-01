part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadImagesEvent extends UploadEvent {
  final List<Uint8List> images;
  final String path;

  const UploadImagesEvent({required this.images, required this.path});

  @override
  List<Object> get props => [images];
}
