import 'package:drivolution/data/models/car_image_model.dart';
import 'package:drivolution/data/models/car_location_model.dart';
import 'package:drivolution/data/enums/drivetrain_type.dart';
import 'package:drivolution/data/enums/fuel_type.dart';
import 'package:drivolution/data/enums/transmission.dart';
import 'package:drivolution/data/enums/car_type.dart';
import 'package:drivolution/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final int? id;
  final User? owner;
  final String name;
  final String model;
  final String color;
  final String interiorColor;
  final String engine;
  final int kilometrage;
  final int doors;
  final int seats;
  final DrivetrainType drivetrain;
  final Transmission transmission;
  final CarType type;
  final FuelType fuel;
  final double dailyRate;
  final String description;
  final String logo;
  final List<CarImage> images;
  final CarLocation location;
  final List<String> features;

  const Car({
    this.id,
    this.owner,
    required this.logo,
    required this.name,
    required this.model,
    required this.dailyRate,
    required this.images,
    required this.location,
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
    required this.description,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      name: json['name'],
      model: json['model'],
      interiorColor: json['interior_color'],
      color: json['color'],
      kilometrage: json['kilometrage'],
      doors: json['doors'],
      seats: json['seats'],
      drivetrain: DrivetrainType.fromApiString(json['drivetrain']),
      transmission: Transmission.fromApiString(json['transmission']),
      type: CarType.fromApiString(json['type']),
      fuel: FuelType.fromApiString(json['fuel']),
      dailyRate: double.parse(json['daily_rate'].toString()),
      description: json['description'],
      logo: json['logo'],
      images: (json['images'] as List)
          .map((image) => CarImage.fromJson(image))
          .toList(),
      location: CarLocation.fromJson(json['location']),
      features: List<String>.from(json['features']),
      engine: json['engine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'model': model,
      'interior_color': interiorColor,
      'color': color,
      'kilometrage': kilometrage,
      'doors': doors,
      'seats': seats,
      'drivetrain': drivetrain.toApiString(),
      'transmission': transmission.toApiString(),
      'type': type.toApiString(),
      'fuel': fuel.toApiString(),
      'daily_rate': dailyRate.toString(),
      'description': description,
      'logo': logo,
      'images': images.map((image) => image.toJson()).toList(),
      'location': location.toJson(),
      'features': features,
      'engine': engine,
    };
  }

  @override
  List<Object?> get props => [
        id,
        owner,
        name,
        model,
        interiorColor,
        color,
        kilometrage,
        doors,
        seats,
        drivetrain,
        transmission,
        type,
        fuel,
        dailyRate,
        description,
        logo,
        images,
        location,
        features,
        engine,
      ];
}
