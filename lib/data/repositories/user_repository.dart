import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/user_model.dart';
import 'package:drivolution/data/services/authentication_service.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:drivolution/data/services/user_service.dart';

class UserRepository {
  final logger = LoggerService().getLogger('User Repo Logger');
  final UserService userService;
  final AuthService authService;

  UserRepository({
    required this.userService,
    required this.authService,
  });

  Future<User> registerUser(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      final userData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
      };
      final response = await userService.registerUser(userData);

      final accessToken = response['access'];
      final refreshToken = response['refresh'];
      await authService.saveTokens(accessToken, refreshToken);
      logger.info("Tokens Saved Successfully");

      final user = User.fromJson(response['user']);
      return user;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<User> loginUser(
    String email,
    String password,
  ) async {
    try {
      final userData = {
        'email': email,
        'password': password,
      };
      final response = await userService.loginUser(userData);
      final accessToken = response['access'];
      final refreshToken = response['refresh'];
      await authService.saveTokens(accessToken, refreshToken);
      final User user = User.fromJson(response['user']);
      return user;
    } on NetworkException {
      rethrow;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<User> getUserInfo() async {
    try {
      final response = await userService.getUserInfo();
      return User.fromJson(response);
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<List<Car>> getFavoriteCars(int userid) async {
    try {
      List<Car> favoriteCars = [];
      final response = await userService.getFavoriteCars(userid);
      favoriteCars = (response)
          .map((car) => Car.fromJson(car as Map<String, dynamic>))
          .toList();
      return favoriteCars;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<String> addToFavorite(int carid, int userid) async {
    try {
      final response = await userService.addToFavorite(carid, userid);
      return response['message'];
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<void> removeFromFavorite(int carid, int userid) async {
    try {
      final response = await userService.removeFromFavorite(carid, userid);
      return response['message'];
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  //todo
  Future<void> signOut() async {
    try {
      await authService.clearTokens();
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<void> resetPassword(String email) async {
    //   try {
    //     await userService.resetPassword(email);
    //   } on FirebaseAuthException catch (e) {
    //     throw AuthException.fromFirebaseAuthException(e);
    //   } catch (e) {
    //     throw NetworkException.connectionFailed();
    //   }
  }

  Future<void> addPhoneNumber(String phoneNumber, int userid) async {
    // try {
    //   await userService.addPhoneNumber(phoneNumber, userID);
    // } on FirebaseException catch (e) {
    //   throw FirestoreException.fromFirebaseException(e);
    // } catch (e) {
    //   throw NetworkException.connectionFailed();
    // }
  }

  Future<void> addImage(File image, int userid) async {
    try {
      final response = await userService.addImage(image, userid);
      logger.info(response);
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<List<Car>> getUserCars() async {
    try {
      List<Car> userCars = [];
      final response = await userService.getUserCars();
      userCars = (response)
          .map(
            (e) => Car.fromJson(e),
          )
          .toList();
      return userCars;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }
}
