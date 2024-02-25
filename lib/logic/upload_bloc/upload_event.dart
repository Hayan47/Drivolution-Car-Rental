part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadImagesEvent extends UploadEvent {
  final List<Uint8List> images;
  final String imagesName;
  final String id;

  const UploadImagesEvent(this.images, this.imagesName, this.id);

  @override
  List<Object> get props => [images];
}
