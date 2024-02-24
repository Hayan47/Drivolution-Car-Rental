import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:drivolution/data/services/error_handling.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ErrorHandling _errorHandling = ErrorHandling();

  //? remove img background
  Future<Uint8List> removeBackground(
      Uint8List imageFile, BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: {
        'X-Api-Key': 'v9hizpcYyJfHxJFLyNKBHdrs',
      },
      body: {
        'image_file_b64': base64.encode(imageFile),
      },
    );
    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;
      return imageBytes;
    } else {
      _errorHandling.showError('image upload failed', context);
      throw Exception('Failed to remove background: ${response.body}');
    }
  }

  //? resize img
  Uint8List compressImage(
      Uint8List imageBytes, int targetWidth, int targetHeight) {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    // Resize the image
    img.Image resizedImage =
        img.copyResize(image!, width: targetWidth, height: targetHeight);
    // Compress the image and return it as a Uint8List
    return img.encodeJpg(resizedImage, quality: 50);
  }

  //? pick main image
  Future<Uint8List?> pickMainImage(BuildContext context) async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        final imageData = await image.readAsBytes();
        final img = await removeBackground(imageData, context);
        // final compressedImage =
        //     compressImage(img, 815, 300);
        // setState(() {
        //   carImage = img;
        // });
        return img;
      }
    } catch (e) {
      _errorHandling.showError('image not picked correctly', context);
    }
  }

  //? pick images
  Future<List<Uint8List>?> pickImages(BuildContext context) async {
    try {
      List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      final List<Uint8List> carImages = [];
      for (var pickedFile in pickedFiles) {
        final image = File(pickedFile.path);
        final imageData = await image.readAsBytes();
        // setState(() {
        //   carImages.add(Uint8List.fromList(imageData));
        // });
        carImages.add(imageData);
      }
      return carImages;
    } catch (e) {
      _errorHandling.showError('images not picked correctly', context);
    }
  }

  //?remove images from album
  List<Uint8List> removeImages() {
    return [];
  }

  //?upload Image
  Future<void> uploadImage(
      {required file,
      required String folderName,
      required String imageName,
      required String id,
      required int i,
      required BuildContext context}) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('cars')
        .child(id)
        .child(folderName)
        .child(imageName);
    try {
      ref
          .putData(file)
          .snapshotEvents
          .listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload $i is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            break;
          case TaskState.success:
            final imageUrl = ref.getDownloadURL();
            print('Uploaded image $i: $imageUrl');
        }
      });
    } on FirebaseException {
      _errorHandling.showError('upload images failed', context);
    }
  }
}
