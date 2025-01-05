import 'package:drivolution/data/models/car_model.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String username;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final List<Car> favoriteCars;
  final bool isVerified;

  const User({
    this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    this.dateOfBirth,
    required this.favoriteCars,
    required this.isVerified,
  });

  // Factory constructor for creating a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      profilePicture: json['profile_picture'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      favoriteCars: (json['favorite_cars'] as List)
          .map((car) => Car.fromJson(car))
          .toList(),
      isVerified: json['is_verified'] as bool,
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'favorite_cars': favoriteCars.map((car) => car.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phoneNumber,
        profilePicture,
        dateOfBirth,
        favoriteCars,
      ];
}
