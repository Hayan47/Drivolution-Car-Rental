import 'package:drivolution/data/exceptions/app_exception.dart';

class ApiException extends AppException {
  final int? statusCode;
  final Map<String, List<String>>? errors;

  ApiException({
    required super.message,
    this.statusCode,
    this.errors,
  });
  @override
  String toString() => message;
}
