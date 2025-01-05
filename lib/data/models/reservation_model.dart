import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/enums/reservation_status.dart';
import 'package:drivolution/data/models/review_model.dart';
import 'package:drivolution/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final int? id;
  final int renter;
  final int car;
  final Car? carDetails;
  final User? renterDetails;
  final ReservationStatus? status;
  final double? totalCost;
  final Review? review;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Reservation({
    this.id,
    required this.renter,
    required this.car,
    this.carDetails,
    this.renterDetails,
    this.status,
    this.totalCost,
    this.review,
    required this.startDate,
    required this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      renter: json['renter'],
      car: json['car'],
      carDetails: Car.fromJson(json['car_details']),
      renterDetails: User.fromJson(json['renter_details']),
      status: ReservationStatus.fromApiString(json['status']),
      totalCost: double.parse(json['total_cost'].toString()),
      review: json['review'] != null ? Review.fromJson(json['review']) : null,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'car': car,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }

  bool get canBeReviewed {
    return status == ReservationStatus.completed && review == null;
  }

  bool get canBeCancelled {
    return status == ReservationStatus.pending ||
        status == ReservationStatus.confirmed;
  }

  int get durationInDays {
    return endDate.difference(startDate).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        renter,
        car,
        carDetails,
        renterDetails,
        status,
        totalCost,
        review,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];
}
