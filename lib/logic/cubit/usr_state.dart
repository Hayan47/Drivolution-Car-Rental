part of 'usr_cubit.dart';

@immutable
abstract class UsrState {}

class UsrInitial extends UsrState {}

class UsrLoaded extends UsrState {
  final Usr userInfo;

  UsrLoaded(this.userInfo);
}

class UsrError extends UsrState {
  final String errorMessage;

  UsrError(this.errorMessage);
}
