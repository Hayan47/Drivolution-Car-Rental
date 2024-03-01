part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class AddImageEvent extends ImageEvent {
  final bool removeBackground;

  const AddImageEvent({required this.removeBackground});
}

class NoImageSelectedEvent extends ImageEvent {}
