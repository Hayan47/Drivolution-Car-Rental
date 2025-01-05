import 'package:drivolution/data/exceptions/api_exception.dart';

class UnauthorizedException extends ApiException {
  UnauthorizedException({String? message})
      : super(message: message ?? 'Unauthorized access', statusCode: 401);

  @override
  String toString() => message;
}
