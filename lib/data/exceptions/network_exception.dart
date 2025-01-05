import 'package:drivolution/data/exceptions/app_exception.dart';

class NetworkException extends AppException {
  NetworkException({String? message})
      : super(message: message ?? 'Network connection error');

  @override
  String toString() => message;
}
