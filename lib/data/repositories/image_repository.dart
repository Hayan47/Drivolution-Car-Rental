import 'dart:typed_data';

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
    return await imageService.uploadImages(images: images, path: path);
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
    return await imageService.fetchCarLogos();
  }
}
