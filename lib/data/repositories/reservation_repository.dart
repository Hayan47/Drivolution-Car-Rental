import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:drivolution/data/services/reservations_services.dart';

class ReservationRepository {
  final logger = LoggerService().getLogger('Reservation Repo Logger');
  final ReservationServices reservationServices;

  ReservationRepository({required this.reservationServices});

  Future<List<Reservation>> getCarReservations(String carid) async {
    try {
      return await reservationServices.getCarReservations(carid);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> makeReservation(Reservation res) async {
    try {
      return await reservationServices.makeReservation(res);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      logger.severe(e);
      throw NetworkException.connectionFailed();
    }
  }

  Future<List<Reservation>> getUserReservations(String userid) async {
    try {
      return await reservationServices.getUserReservations(userid);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }
}
