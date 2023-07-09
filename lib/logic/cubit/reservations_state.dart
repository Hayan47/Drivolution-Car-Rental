part of 'reservations_cubit.dart';

@immutable
abstract class ReservationsState {}

class ReservationsInitial extends ReservationsState {}

class ReservationsLoading extends ReservationsState {}

class ReservationsLoaded extends ReservationsState {
  final List<Reservation> reservations;

  ReservationsLoaded(this.reservations);
}

class ReservationsError extends ReservationsState {
  final String errorMessage;

  ReservationsError(this.errorMessage);
}
