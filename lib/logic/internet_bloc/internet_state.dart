part of 'internet_bloc.dart';

sealed class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

final class InternetInitial extends InternetState {}

class ConnectedState extends InternetState {
  final String message;

  const ConnectedState({required this.message});
}

class NotConnectedState extends InternetState {
  final String message;

  const NotConnectedState({required this.message});
}
