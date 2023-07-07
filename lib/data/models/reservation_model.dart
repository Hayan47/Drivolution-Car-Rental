import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String? id;
  final String carId;
  final String customerId;
  final DateTime startDate;
  final DateTime endDate;

  Reservation({
    this.id,
    required this.carId,
    required this.customerId,
    required this.startDate,
    required this.endDate,
  });

  factory Reservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Reservation(
      carId: data?['carid'],
      customerId: data?['customerid'],
      startDate: (data?['startDate'] as Timestamp).toDate(),
      endDate: (data?['endDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'carid': carId,
      'customerid': customerId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
    };
  }
}
