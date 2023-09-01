import 'package:cloud_firestore/cloud_firestore.dart';

class Usr {
  int? userid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String? img;
  int? age;
  List<String>? favoriteCars;

  Usr({
    this.userid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.img,
    this.age,
    this.favoriteCars,
  });

  factory Usr.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usr(
      firstName: data?['first name'],
      lastName: data?['last name'],
      email: data?['email'],
      age: data?['age'],
      img: data?['image'],
      phoneNumber: data?['phoneNumber'],
      favoriteCars: List<String>.from(data?['favoriteCars'] ?? []),
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
      if (favoriteCars != null) "favoriteCars": favoriteCars,
    };
  }
}
