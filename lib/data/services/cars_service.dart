import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:drivolution/data/models/car_image_model.dart';
import 'package:drivolution/data/models/car_location_model.dart';
import 'api_service.dart';

class CarService extends ApiService {
  Future<List<dynamic>> getAllCars() async {
    final response = await dio.get('cars/');
    return response.data;
  }

  Future<Map<String, dynamic>> addCar(Map<String, dynamic> carData,
      List<CarImage> images, CarLocation location) async {
    final formData = FormData();
    carData.remove('images');

    formData.fields.add(MapEntry(
        'data', jsonEncode(carData) // Send all car data as a single JSON string
        ));

    // Add images maintaining the structured format
    for (var i = 0; i < images.length; i++) {
      final image = images[i];
      formData.files.add(
        MapEntry(
          'images[$i]image',
          await MultipartFile.fromFile(
            image.imageFile!.path,
            filename: image.imageFile!.path.split('/').last,
          ),
        ),
      );
      formData.fields.add(MapEntry(
        'images[$i]is_primary',
        image.isPrimary.toString(),
      ));
    }
    final response = await dio.post('cars/', data: formData);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteCar(int carid) async {
    final response = await dio.delete('cars/$carid');
    return response.data;
  }

  Future<Map<String, dynamic>> getCarsInfo(List<String> ids) async {
    final response = await dio.get('cars/', data: ids);
    return response.data;
  }

  Future<List<dynamic>> searchForCars(String text) async {
    final response = await dio.get('cars/', queryParameters: {'name': text});
    return response.data;
  }
}
