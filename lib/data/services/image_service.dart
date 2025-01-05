import 'dart:convert';
import 'dart:typed_data';
import 'package:drivolution/data/services/api_service.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image/image.dart' as IMG;

class ImageService extends ApiService {
  final loggerr = LoggerService().getLogger("Image Service Logger");
  //? remove img background
  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    try {
      // Prepare the base64-encoded image
      final encodedImage = base64.encode(imageFile);

      // Create the multipart request
      final uri = Uri.parse('https://api.remove.bg/v1.0/removebg');
      final request = http.MultipartRequest('POST', uri);

      // Add the API key
      request.headers['X-Api-Key'] = dotenv.env['REMOVE_BG_API_KEY'].toString();

      // Add the base64 image
      request.fields['image_file_b64'] = encodedImage;

      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        return responseBody.bodyBytes; // Return the image bytes
      } else {
        logger.warning("Failed to remove background: ${response.statusCode}");
        throw Exception(
            "Failed to remove background: ${response.reasonPhrase}");
      }
    } catch (e) {
      logger.severe("Error removing background: $e");
      rethrow;
    }
  }

  //? compress img
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

  //? resize image
  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  //? featch Logos
  Future<List<dynamic>> getCarLogos() async {
    final response = await dio.get('car_logos/');
    return response.data;
  }
}
