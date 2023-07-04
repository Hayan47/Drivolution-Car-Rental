import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Uint8List? carImage;

  //? resize img
  // Uint8List compressImage(
  //     Uint8List imageBytes, int targetWidth, int targetHeight) {
  //   // Decode the image
  //   img.Image? image = img.decodeImage(imageBytes);

  //   // Resize the image
  //   img.Image resizedImage =
  //       img.copyResize(image!, width: targetWidth, height: targetHeight);

  //   // Compress the image and return it as a Uint8List
  //   return img.encodeJpg(resizedImage, quality: 50);
  // }

  Future<Uint8List> removeBackground(Uint8List imageFile) async {
//? remove img background
    final response = await http.post(
      headers: {
        'X-Api-Key': 'v9hizpcYyJfHxJFLyNKBHdrs',
      },
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      body: {
        'image_file_b64': base64.encode(imageFile),
      },
    );
    if (response.statusCode == 200) {
      Uint8List _imageBytes = response.bodyBytes;
      return _imageBytes;
    } else {
      print('EEEE');
      throw Exception('Failed to remove background: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          try {
            XFile? pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              final image = File(pickedFile.path);
              final imageData = await image.readAsBytes();
              // final compressedImage = compressImage(imageData, 815, 300);
              final img = await removeBackground(imageData);
              setState(() {
                carImage = img;
              });
              print(carImage);
            }
          } catch (e) {
            print(e);
          }
        },
        child: Center(
          child: SizedBox(
            height: 200,
            child: carImage != null
                ? Card(
                    color: Colors.transparent,
                    child: Image.memory(
                      carImage!,
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/cars/carholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
