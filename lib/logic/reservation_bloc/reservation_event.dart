part of 'reservation_bloc.dart';

sealed class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class GetCarReservations extends ReservationEvent {
  final String carID;

  const GetCarReservations({required this.carID});

  @override
  List<Object> get props => [carID];
}

class PickRange extends ReservationEvent {
  final PickerDateRange pickerDateRange;

  const PickRange({required this.pickerDateRange});
  @override
  List<Object> get props => [pickerDateRange];
}

class ConfirmRange extends ReservationEvent {}

class MakeReservation extends ReservationEvent {
  final Reservation reservation;

  const MakeReservation({required this.reservation});
}

class GetUserReservations extends ReservationEvent {
  final String userID;

  const GetUserReservations({required this.userID});
}
