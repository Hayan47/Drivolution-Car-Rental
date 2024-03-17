import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/services/reservations_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final reservationsServices = ReservationsServices();
  DateTimeRange? selectedRange;
  List<DateTime> disabledDates = [];
  List<Reservation> reservations = [];
  List<Reservation> userReservations = [];
  int duration = 0;
  ReservationBloc() : super(ReservationsInitial()) {
    on<GetCarReservations>((event, emit) async {
      try {
        emit(ReservationsLoading());
        print(state);
        reservations =
            await reservationsServices.getCarReservations(event.carID);
        disabledDates = [];
        for (Reservation reservation in reservations) {
          DateTime startDate = reservation.startDate;
          DateTime endDate = reservation.endDate;
          for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
            DateTime currentDay = startDate.add(Duration(days: i));
            disabledDates.add(
                DateTime(currentDay.year, currentDay.month, currentDay.day));
          }
        }
        emit(ReservationsLoaded(
            reservations: reservations, disabledDates: disabledDates));
        print(state);
      } catch (error) {
        emit(ReservationsError(message: error.toString()));
        print(state);
      }
    });

    on<PickRange>((event, emit) {
      selectedRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
      //* when the user pick the start and the end days
      if (event.pickerDateRange.startDate != null &&
          event.pickerDateRange.endDate != null) {
        selectedRange = DateTimeRange(
          start: event.pickerDateRange.startDate!,
          end: event.pickerDateRange.endDate!,
        );
      }
      //* when the user pick the start day only
      if (event.pickerDateRange.startDate != null &&
          event.pickerDateRange.endDate == null) {
        selectedRange = DateTimeRange(
          start: event.pickerDateRange.startDate!,
          end: event.pickerDateRange.startDate!,
        );
      }
    });

    on<ConfirmRange>((event, emit) {
      if (selectedRange != null) {
        for (int i = 0; i <= selectedRange!.duration.inDays; i++) {
          final date = selectedRange!.start.add(Duration(days: i));
          if (disabledDates.contains(date)) {
            emit(const ReservationsError(
                message: 'Selected Date Range contains blackout days'));
            print(state);
            emit(ReservationsLoaded(
                reservations: reservations, disabledDates: disabledDates));
            print(state);
            break;
          } else {
            duration = selectedRange!.duration.inDays;
            emit(
                RangePicked(selectedRange: selectedRange!, duration: duration));
            print(state);
          }
        }
      } else {
        emit(const ReservationsError(message: 'Choose a range first'));
        print(state);
        emit(ReservationsLoaded(
            reservations: reservations, disabledDates: disabledDates));
        print(state);
      }
    });

    on<MakeReservation>((event, emit) {
      try {
        reservationsServices.makeReservation(event.reservation);
        emit(ReservationsInitial());
        print(state);
      } catch (e) {
        emit(const ReservationsError(message: 'Failed to make a reservation'));
        print(state);
      }
    });

    on<GetUserReservations>((event, emit) async {
      try {
        userReservations =
            await reservationsServices.getUserReservations(event.userID);
        emit(ReservationsLoaded(
            reservations: userReservations, disabledDates: const []));
        print(state);
      } catch (e) {
        emit(const ReservationsError(message: 'Error getting reservations'));
        print(state);
      }
    });
  }
}
