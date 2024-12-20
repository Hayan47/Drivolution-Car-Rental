import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/services/image_service.dart';

class ImageRepository {
  final ImageService imageService;

  ImageRepository({required this.imageService});

  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    return await imageService.removeBackground(imageFile);
  }

  Future<List<String>> uploadImages({
    required List<Uint8List> images,
    required String path,
  }) async {
    try {
      return await imageService.uploadImages(images: images, path: path);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Uint8List compressImage(
      Uint8List imageBytes, int targetWidth, int targetHeight) {
    return imageService.compressImage(imageBytes, targetWidth, targetHeight);
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    return imageService.resizeImage(data, width, height);
  }

  //? featch Logos
  Future<List<String>> getCarLogos() async {
    try {
      return await imageService.fetchCarLogos();
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }
}
