part of 'user_image_cubit.dart';

sealed class UserImageState extends Equatable {
  const UserImageState();

  @override
  List<Object> get props => [];
}

class UserImageInitial extends UserImageState {}

class UserImageLoading extends UserImageState {}

class UserImageChanged extends UserImageState {
  final String imageUrl;
  final String message;

  const UserImageChanged({
    required this.message,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [message];
}

class UserImageError extends UserImageState {
  final String message;

  const UserImageError(this.message);

  @override
  List<Object> get props => [message];
}
