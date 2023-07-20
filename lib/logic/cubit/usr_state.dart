// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'usr_cubit.dart';

@immutable
abstract class UsrState {}

class UsrInitial extends UsrState {}

class UsrLoaded extends UsrState {
  final Usr userInfo;
  final List<Reservation> reservation;

  UsrLoaded(
    this.userInfo,
    this.reservation,
  );
}

class UsrError extends UsrState {
  final String errorMessage;

  UsrError(this.errorMessage);
}
