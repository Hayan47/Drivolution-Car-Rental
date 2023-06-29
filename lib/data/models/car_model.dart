// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? id;
  String? logo;
  String? img;
  String? name;
  String? model;
  int? rentd;
  List<String>? imgs;
  GeoPoint? geoPoint;
  String? location;
  String? type;
  int? seats;
  int? doors;
  String? fuel;
  List<String>? features;
  String? color;
  String? interiorColor;
  String? engine;
  String? drivetrain;
  int? kilometrage;
  String? description;
  String? transmission;
  String? ownerid;

  //Owner? owner;
  //Review? review;

  // Car.fromJson(Map<String, dynamic> json) {
  //   id = json["id"];
  //   logo = json["logo"];
  //   img = json["img"];
  //   name = json["name"];
  //   model = json["model"];
  //   rentd = json["rentd"];
  //   imgs = json["imgs"].cast<String>();
  //   location1 = json["location1"];
  //   location2 = json["location2"];
  //   location = json["location"];
  //   type = json["type"];
  //   seats = json["seats"];
  //   doors = json["doors"];
  //   fuel = json["fuel"];
  //   features = json["features"].cast<String>();
  //   color = json["color"];
  //   interiorColor = json["interiorColor"];
  //   drivetrain = json["drivetrain"];
  //   engine = json["engine"];
  //   kilometrage = json["kilometrage"];
  //   transmission = json["transmission"];
  //   userid = json["userid"];
  //   description = json["description"];
  // }

  Car({
    this.id,
    this.logo,
    this.img,
    this.name,
    this.model,
    this.rentd,
    this.imgs,
    this.geoPoint,
    this.location,
    this.type,
    this.seats,
    this.doors,
    this.fuel,
    this.features,
    this.color,
    this.interiorColor,
    this.engine,
    this.drivetrain,
    this.kilometrage,
    this.description,
    this.transmission,
    this.ownerid,
  });

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Car(
      // id: data?['id'],
      logo: data?['logo'],
      img: data?['image'],
      name: data?['name'],
      model: data?['model'],
      rentd: data?['rent'],
      imgs: List<String>.from(data?['images']),
      geoPoint: data?['location'],
      // location1: data?['location1'],
      // location2: data?['location2'],
      location: data?['location_name'],
      type: data?['type'],
      seats: data?['seats'],
      doors: data?['doors'],
      fuel: data?['fuel'],
      features: List<String>.from(data?['features']),
      color: data?['color'],
      interiorColor: data?['interiorColor'],
      engine: data?['engine'],
      drivetrain: data?['drivetrain'],
      kilometrage: data?['kilometrage'],
      description: data?['description'],
      transmission: data?['transmission'],
      ownerid: data?['ownerid'],
    );
  }

  //? Convert Car object to a Map for writing to Firebase
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'logo': logo,
      'image': img,
      'name': name,
      'model': model,
      'rentd': rentd,
      'images': imgs,
      'location': location,
      // 'location1': location1,
      // 'location2': location2,
      'location_name': location,
      'type': type,
      'seats': seats,
      'doors': doors,
      'fuel': fuel,
      'features': features,
      'color': color,
      'interiorColor': interiorColor,
      'engine': engine,
      'drivetrain': drivetrain,
      'kilometrage': kilometrage,
      'description': description,
      'transmission': transmission,
      'ownerid': ownerid,
    };
  }
}
