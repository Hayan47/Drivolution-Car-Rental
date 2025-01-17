import 'package:cloud_firestore/cloud_firestore.dart';

class Usr {
  String userid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String? img;
  int? age;
  List<String> favoriteCars;
  String? fcm;

  Usr({
    required this.userid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.img,
    this.age,
    required this.favoriteCars,
    this.fcm,
  });

  factory Usr.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usr(
      userid: snapshot.reference.id,
      firstName: data?['first name'],
      lastName: data?['last name'],
      email: data?['email'],
      age: data?['age'],
      img: data?['image'],
      phoneNumber: data?['phoneNumber'] ?? '',
      favoriteCars: List<String>.from(data?['favoriteCars'] ?? []),
      fcm: data?['FCM'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      if (age != null) "age": age,
      "phoneNumber": phoneNumber,
      if (img != null) "image": img,
      "favoriteCars": favoriteCars,
      if (fcm != null) "FCM": fcm,
    };
  }
}
