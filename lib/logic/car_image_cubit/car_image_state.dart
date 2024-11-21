part of 'car_image_cubit.dart';

sealed class CarImageState extends Equatable {
  const CarImageState();

  @override
  List<Object> get props => [];
}

class CarImageInitial extends CarImageState {}

class CarImageLoading extends CarImageState {}

class CarImageChanged extends CarImageState {
  final Uint8List imageData;

  const CarImageChanged(this.imageData);

  @override
  List<Object> get props => [imageData];
}

class CarImageError extends CarImageState {
  final String message;

  const CarImageError(this.message);

  @override
  List<Object> get props => [message];
}
