import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drivolution/data/services/api_service.dart';
import 'package:drivolution/data/services/logger_service.dart';

class UserService extends ApiService {
  final logger = LoggerService().getLogger('User Service Logger');

  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData) async {
    final response = await dio.post('register/', data: userData);
    return response.data;
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> userData) async {
    final response = await dio.post('login/', data: userData);
    return response.data;
  }

  //? add img
  Future addImage(File image, int userid) async {
    final formData = FormData.fromMap({
      'profile_picture': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
    final response = await dio.patch('users/$userid/', data: formData);
    return response.data;
  }

  //? get user info
  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await dio.get('users/me/');
    return response.data;
  }

  //? reset password
  Future resetPassword(String email) async {
    // firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //?get favorite cars
  Future<List<dynamic>> getFavoriteCars(int userid) async {
    final response = await dio.get('users/$userid/favorite_cars/');
    return response.data;
  }

  //? add to favorite
  Future addToFavorite(int carid, int userid) async {
    final response = await dio
        .post('users/$userid/add_favorite_car/', data: {"car_id": carid});
    return response.data;
  }

  //? remove from favorite
  Future removeFromFavorite(int carid, int userid) async {
    final response = await dio
        .post('users/$userid/remove_favorite_car/', data: {"car_id": carid});
    return response.data;
  }

  //?get user cars
  Future<List<dynamic>> getUserCars() async {
    final response = await dio.get('cars/my_cars/');
    return response.data;
  }

  Future<int> checkAuth(String accessToken) async {
    final response =
        await dio.post('token/verify/', data: {'token': accessToken});
    logger.info("CheckAuth Response:  $response");
    return response.statusCode!;
  }
}
