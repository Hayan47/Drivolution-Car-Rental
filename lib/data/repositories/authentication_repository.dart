import 'package:dio/dio.dart';
import 'package:drivolution/data/exceptions/storage_exception.dart';
import 'package:drivolution/data/services/authentication_service.dart';
import 'package:drivolution/data/services/user_service.dart';

class AuthRepository {
  final AuthService authService;
  final UserService userService;

  AuthRepository({
    required this.authService,
    required this.userService,
  });

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    try {
      await authService.saveTokens(accessToken, refreshToken);
    } on StorageException {
      rethrow;
    } catch (e) {
      throw StorageException(
        message: 'Failed to save authentication tokens',
      );
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final token = await authService.getAccessToken();
      return token;
    } on StorageException {
      rethrow;
    } catch (e) {
      throw StorageException(
        message: 'Failed to retrieve access token',
      );
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final token = await authService.getRefreshToken();
      return token;
    } on StorageException {
      rethrow;
    } catch (e) {
      throw StorageException(
        message: 'Failed to retrieve refresh token',
      );
    }
  }

  Future<void> clearTokens() async {
    try {
      await authService.clearTokens();
    } on StorageException {
      rethrow;
    } catch (e) {
      throw StorageException(
        message: 'Failed to clear authentication tokens: ${e.toString()}',
      );
    }
  }

  Future<bool> checkAuth(String accessToken) async {
    try {
      final response = await userService.checkAuth(accessToken);
      if (response == 200) {
        return true;
      } else {
        clearTokens();
        return false;
      }
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }
}
