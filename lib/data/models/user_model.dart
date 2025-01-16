import 'package:drivolution/data/models/car_model.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final List<Car> favoriteCars;
  final bool isVerified;

  const User({
    this.id,
    required this.firstName,
    required this.lastName,
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
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
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
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        dateOfBirth,
        favoriteCars,
      ];
}
