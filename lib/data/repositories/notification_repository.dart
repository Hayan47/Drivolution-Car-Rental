import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/notification_model.dart';
import 'package:drivolution/data/services/notifications_services.dart';

class NotificationRepository {
  final NotificationServices notificationServices;

  NotificationRepository({required this.notificationServices});

  //?get all notifications
  Future<List<Notification>> getUserNotifications(String userID) async {
    try {
      return await notificationServices.getUserNotifications(userID);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }
}
