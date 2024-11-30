import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/notification_model.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:drivolution/data/services/notifications_services.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:drivolution/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  final logger = LoggerService().getLogger('Notification Service Logger');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  logger.info('Received Background Message');

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final UserServices userServices = UserServices(
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
    googleSignIn: googleSignIn,
    firebaseMessaging: firebaseMessaging,
  );

  final CarServices carServices = CarServices(
    firebaseFirestore: firebaseFirestore,
  );

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final NotificationServices notificationServices = NotificationServices(
    firebaseMessaging: firebaseMessaging,
    userServices: userServices,
    carServices: carServices,
    notificationsPlugin: notificationsPlugin,
  );

  notificationServices.showNotification(
    id: int.parse(message.data['reservationId']),
    title: message.data['title'] ?? '',
    body: message.data['body'] ?? '',
    // payload: jsonEncode(message.data),
  );
  notificationServices.storeNotification(
    Notification(
      title: message.data['title'],
      body: message.data['body'],
      timestamp: Timestamp.fromDate(DateTime.now()),
      payload: '',
    ),
    message.data['ownerID'],
  );
}
