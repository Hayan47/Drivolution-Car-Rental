import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/repositories/reservation_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final logger = LoggerService().getLogger('Reservation Bloc Logger');
  final ReservationRepository reservationRepository;
  DateTimeRange? selectedRange;
  List<DateTime> disabledDates = [];
  List<Reservation> reservations = [];
  List<Reservation> userReservations = [];
  int duration = 0;
  ReservationBloc({required this.reservationRepository})
      : super(ReservationsInitial()) {
    on<GetCarReservations>((event, emit) async {
      try {
        emit(ReservationsLoading());
        reservations =
            await reservationRepository.getCarReservations(event.carid);
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
      } catch (e) {
        emit(ReservationsError(message: e.toString()));
        logger.severe(e);
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
            emit(ReservationsLoaded(
                reservations: reservations, disabledDates: disabledDates));
            break;
          } else {
            duration = selectedRange!.duration.inDays;
            emit(
                RangePicked(selectedRange: selectedRange!, duration: duration));
          }
        }
      } else {
        emit(const ReservationsError(message: 'Choose a range first'));
        emit(ReservationsLoaded(
            reservations: reservations, disabledDates: disabledDates));
      }
    });

    on<MakeReservation>((event, emit) async {
      try {
        await reservationRepository.makeReservation(event.reservation);
        emit(ReservationsInitial());
      } catch (e) {
        emit(ReservationsError(message: e.toString()));
        logger.severe(e);
      }
    });

    on<GetUserReservations>((event, emit) async {
      try {
        userReservations =
            await reservationRepository.getUserReservations(event.userid);
        disabledDates = [];
        for (Reservation reservation in userReservations) {
          DateTime startDate = reservation.startDate;
          DateTime endDate = reservation.endDate;
          for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
            DateTime currentDay = startDate.add(Duration(days: i));
            disabledDates.add(
                DateTime(currentDay.year, currentDay.month, currentDay.day));
          }
        }
        emit(ReservationsLoaded(
            reservations: userReservations, disabledDates: disabledDates));
      } catch (e) {
        emit(ReservationsError(message: e.toString()));
        logger.severe(e);
      }
    });
  }
}
