part of 'car_owner_bloc.dart';

sealed class CarOwnerState extends Equatable {
  const CarOwnerState();

  @override
  List<Object> get props => [];
}

final class CarOwnerInitial extends CarOwnerState {}

final class CarOwnerLoading extends CarOwnerState {}

final class CarOwnerLoaded extends CarOwnerState {
  final Usr userInfo;

  const CarOwnerLoaded({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

final class CarOwnerError extends CarOwnerState {
  final String message;

  const CarOwnerError({required this.message});

  @override
  List<Object> get props => [message];
}
