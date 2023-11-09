import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/reservation_model.dart';

class ReservationsServices {
  final _store = FirebaseFirestore.instance;

  Future<void> makeReservation(Reservation res) async {
    try {
      await _store
          .collection('reservations')
          .withConverter<Reservation>(
            fromFirestore: Reservation.fromFirestore,
            toFirestore: (res, options) => res.toFirestore(),
          )
          .add(res);
    } catch (e) {
      print('EEEEEEEEEEEEEEEEEEE111$e');
    }
  }

  Future<List<Reservation>> getCarReservations(String carid) async {
    List<Reservation> reservations = [];
    try {
      var snapshot = await _store
          .collection('reservations')
          .where('carid', isEqualTo: carid)
          .withConverter(
            fromFirestore: Reservation.fromFirestore,
            toFirestore: (res, options) => res.toFirestore(),
          )
          .get();
      for (var doc in snapshot.docs) {
        var reservation = doc.data();
        reservations.add(reservation);
      }
      return reservations;
    } catch (e) {
      print('EEEEEEEEEEEEEEEEEEE222$e');
      return [];
    }
  }

  Future<List<Reservation>> getUserReservations(String userid) async {
    List<Reservation> reservations = [];
    try {
      var snapshot = await _store
          .collection('reservations')
          .where('customerid', isEqualTo: userid)
          .withConverter(
            fromFirestore: Reservation.fromFirestore,
            toFirestore: (res, options) => res.toFirestore(),
          )
          .get();
      for (var doc in snapshot.docs) {
        var reservation = doc.data();
        reservations.add(reservation);
      }
      print(reservations);
      return reservations;
    } catch (e) {
      print('EEEEEEEEEEEEEEEEEEE222$e');
      return [];
    }
  }
}
