import 'package:drivolution/data/exceptions/api_exception.dart';

class NotFoundException extends ApiException {
  NotFoundException({String? message})
      : super(message: message ?? 'Resource not found', statusCode: 404);

  @override
  String toString() => message;
}
