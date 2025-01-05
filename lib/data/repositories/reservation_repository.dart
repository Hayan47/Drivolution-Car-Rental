import 'package:dio/dio.dart';
import 'package:drivolution/data/exceptions/api_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:drivolution/data/services/reservations_service.dart';

class ReservationRepository {
  final logger = LoggerService().getLogger('Reservation Repo Logger');
  final ReservationService reservationServices;

  ReservationRepository({required this.reservationServices});

  Future<void> makeReservation(Reservation reservation) async {
    try {
      Map<String, dynamic> reservationData = reservation.toJson();
      final response =
          await reservationServices.makeReservation(reservationData);
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<List<Reservation>> getCarReservations(int carid) async {
    try {
      List<Reservation> reservations = [];
      final response = await reservationServices.getCarReservations(carid);
      reservations = (response as List<dynamic>)
          .map(
            (e) => Reservation.fromJson(e),
          )
          .toList();
      return reservations;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<List<Reservation>> getUserReservations(int userid) async {
    try {
      List<Reservation> reservations = [];
      final response = await reservationServices.getUserReservations(userid);
      reservations = (response as List<dynamic>)
          .map(
            (e) => Reservation.fromJson(e),
          )
          .toList();
      return reservations;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }
}
