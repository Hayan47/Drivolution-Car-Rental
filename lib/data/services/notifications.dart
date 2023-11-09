import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  //?init notifications
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('TOKEN::::::::::::');
    print(fCMToken);
    if (fCMToken != null) {
      if (_auth.currentUser != null) {
        _store.collection('users').doc(_auth.currentUser!.uid).update({
          'FCM': fCMToken,
        });
      }
    }
    FirebaseMessaging.onBackgroundMessage((message) async {
      print('TITLE:: ${message.notification!.title}');
      print('BODY:: ${message.notification!.body}');
      print('PAYLOAD:: ${message.data}');
    });
  }
}
