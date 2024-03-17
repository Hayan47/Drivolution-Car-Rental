import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? id;
  final String title;
  final String body;
  final Timestamp timestamp;
  final String payload;

  Notification({
    this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.payload,
  });

  factory Notification.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Notification(
      id: snapshot.id,
      title: data?['title'] ?? '',
      body: data?['body'] ?? '',
      timestamp: data?['timestamp'] ?? Timestamp.fromDate(DateTime.now()),
      payload: data?['payload'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp,
      'payload': payload,
    };
  }
}
