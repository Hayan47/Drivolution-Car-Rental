part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  final int userid;

  const Authenticated({required this.userid});

  @override
  List<Object> get props => [userid];
}

final class NotAuthenticated extends AuthState {}
