import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/services/notifications.dart';

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
      FirebaseNotifications().sendNotificationToOwner(res);
    });
    // Retrieve car details to get owner ID
    // final carDoc = await _store.collection('cars').doc(res.carId).get();
    // final ownerId = carDoc['ownerId'];

    // Assuming you have a method to get the owner's OneSignal player ID
    // final ownerPlayerId = await getOwnerPlayerId(ownerId);

    // if (ownerId != null) {
    //   // Send notification using OneSignal
    //   await OneSignal.Notifications.(
    //       OSNotification(
    //         headings: {'en': 'Car Booked!'},
    //         contents: {
    //           'en':
    //               'Your car ${carDoc['model']} has been booked by a customer from ${res.startDate.toString()} to ${res.endDate.toString()}.'
    //         },
    //         playerIds: [ownerId],
    //       ),
    //       publish: true);
    // } else {
    //   // Handle case where owner Player ID is unavailable (log, display message)
    //   print('Owner OneSignal Player ID not found for car: ${res.carId}');
    // }
    // });
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
