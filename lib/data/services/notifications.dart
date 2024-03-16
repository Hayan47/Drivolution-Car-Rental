import 'dart:convert';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:drivolution/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Received Background Message');
  if (message.notification != null) {
    FirebaseNotifications().showNotification(
      id: int.parse(message.data['reservationId']),
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      // payload: jsonEncode(message.data),
    );
  }
}

class FirebaseNotifications {
  final firebaseMessaging = FirebaseMessaging.instance;
  final userServices = UserServices();
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //?init notifications
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received Foreground Message');
      if (message.notification != null) {
        showNotification(
          id: int.parse(message.data['reservationId']),
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? '',
          // payload: jsonEncode(message.data),
        );
      }
    });
  }

  Future<void> sendNotificationToOwner(Reservation res) async {
    final Car? car = await CarServices().getCarInfo(res.carId);
    final Usr? usr = await UserServices().getUserInfo(car!.ownerid);

    final Map<String, dynamic> notificationData = {
      "message": {
        "token": usr!.fcm,
        "notification": {
          "title": "New Reservation for Your Car",
          "body":
              "Your ${car.name} has been reserved from ${res.startDate.year}-${res.startDate.month}-${res.startDate.day} to ${res.endDate.year}-${res.endDate.month}-${res.endDate.day} by ${usr.firstName} ${usr.lastName}",
        },
        "data": {
          "reservationId":
              res.startDate.millisecondsSinceEpoch.toString().substring(0, 8),
          "car_img": car.img,
        }
      }
    };
    final String token = await getAccessToken();
    const url =
        'https://fcm.googleapis.com/v1/projects/drivolution/messages:send';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(notificationData));
      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print('Error sending notification: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error sending notification: $error');
    }
  }

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(
          jsonDecode(dotenv.env['SERVICE_ACCOUNT']!)),
      ["https://www.googleapis.com/auth/firebase.messaging"],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }

  Future<void> initLocalNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    // String image = '';
    // if (payload != null) {
    //   final data = jsonDecode(payload);
    //   final String carImageUrl = data['car_img'];
    //   final response = await http.get(Uri.parse(carImageUrl));
    //   print(response);
    //   image = response.body;
    // }
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        icon: 'logo',
        channelShowBadge: true,
        // largeIcon: DrawableResourceAndroidBitmap(),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
