abstract class AppException implements Exception {
  final String message;
  AppException({required this.message});
}