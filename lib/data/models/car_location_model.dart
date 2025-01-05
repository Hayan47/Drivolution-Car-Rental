import 'package:equatable/equatable.dart';

class CarLocation extends Equatable {
  final int? id;
  final String name;
  final double latitude;
  final double longitude;

  const CarLocation({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory CarLocation.fromJson(Map<String, dynamic> json) {
    return CarLocation(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }

  @override
  List<Object?> get props => [name, latitude, longitude];
}
