import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CarImage extends Equatable {
  final int? id;
  final String imageUrl;
  final bool isPrimary;
  final File? imageFile;

  const CarImage({
    this.id,
    required this.imageUrl,
    required this.isPrimary,
    this.imageFile,
  });

  factory CarImage.fromJson(Map<String, dynamic> json) {
    return CarImage(
      id: json['id'] as int,
      imageUrl: json['image'] ?? '',
      isPrimary: json['is_primary'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': imageFile,
      'is_primary': isPrimary,
    };
  }

  @override
  List<Object?> get props => [id, imageFile, isPrimary];
}
