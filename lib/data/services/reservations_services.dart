import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/services/notifications_services.dart';

class ReservationsServices {
  final _store = FirebaseFirestore.instance;

  Future<void> makeReservation(Reservation res) async {
    await _store
        .collection('reservations')
        .withConverter<Reservation>(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (res, options) => res.toFirestore(),
        )
        .add(res)
        .then((docRef) async {
      await FirebaseNotifications().sendNotificationToOwner(res);
    });
  }

  Future<List<Reservation>> getCarReservations(String carid) async {
    List<Reservation> reservations = [];
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
  }

  Future<List<Reservation>> getUserReservations(String userid) async {
    List<Reservation> reservations = [];
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
    return reservations;
  }
}
