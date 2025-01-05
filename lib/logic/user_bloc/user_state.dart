part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User userInfo;
  final List<Car> cars;

  const UserLoaded({
    required this.userInfo,
    required this.cars,
  });
}

class UserError extends UserState {
  final String errorMessage;

  const UserError({required this.errorMessage});
}
