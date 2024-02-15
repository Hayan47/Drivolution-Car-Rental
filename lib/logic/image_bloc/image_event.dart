part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class AddImageEvent extends ImageEvent {}

class NoImageSelectedEvent extends ImageEvent {}
