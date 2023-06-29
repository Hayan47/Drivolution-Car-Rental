import 'package:cloud_firestore/cloud_firestore.dart';

class Usr {
  int? userid;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? img;
  int? age;

  Usr(
      {this.userid,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.img,
      this.age});

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
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstName != null) "first_name": firstName,
      if (lastName != null) "last_name": lastName,
      if (email != null) "email": email,
      if (age != null) "age": age,
      if (img != null) "image": img,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }
}
