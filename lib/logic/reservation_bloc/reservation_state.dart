part of 'reservation_bloc.dart';

sealed class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class ReservationsInitial extends ReservationState {}

class ReservationsLoading extends ReservationState {}

class ReservationsLoaded extends ReservationState {
  final List<Reservation> reservations;
  final List<DateTime> disabledDates;

  const ReservationsLoaded(
      {required this.reservations, required this.disabledDates});
}

class ReservationsError extends ReservationState {
  final String message;

  const ReservationsError({required this.message});
}

class RangePicked extends ReservationState {
  final DateTimeRange selectedRange;
  final int duration;

  const RangePicked({required this.selectedRange, required this.duration});
}
