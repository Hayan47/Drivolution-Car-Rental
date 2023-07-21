import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String? id;
  final String logo;
  final String img;
  final String name;
  final String model;
  final int rent;
  final List<String> images;
  final GeoPoint geoPoint;
  final String locationName;
  final String type;
  final int seats;
  final int doors;
  final String fuel;
  final List<String> features;
  final String color;
  final String interiorColor;
  final String engine;
  final String drivetrain;
  final int kilometrage;
  final String transmission;
  final String ownerid;
  final String description;

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
    required this.logo,
    required this.img,
    required this.name,
    required this.model,
    required this.rent,
    required this.images,
    required this.geoPoint,
    required this.locationName,
    required this.type,
    required this.seats,
    required this.doors,
    required this.fuel,
    required this.features,
    required this.color,
    required this.interiorColor,
    required this.engine,
    required this.drivetrain,
    required this.kilometrage,
    required this.transmission,
    required this.ownerid,
    required this.description,
  });

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Car(
      id: snapshot.id,
      logo: data?['logo'],
      img: data?['image'],
      name: data?['name'],
      model: data?['model'],
      rent: data?['rent'],
      images: List<String>.from(data?['images']),
      geoPoint: data?['geoPoint'],
      locationName: data?['locationName'],
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
      // 'id': id,
      'logo': logo,
      'image': img,
      'name': name,
      'model': model,
      'rent': rent,
      'images': images,
      'locationName': locationName,
      'geoPoint': geoPoint,
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

  @override
  List<Object?> get props => [
        id,
        logo,
        img,
        name,
        model,
        rent,
        images,
        geoPoint,
        locationName,
        type,
        seats,
        doors,
        fuel,
        features,
        color,
        interiorColor,
        engine,
        drivetrain,
        kilometrage,
        transmission,
        ownerid,
        description,
      ];
}
