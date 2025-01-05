import 'package:drivolution/data/exceptions/app_exception.dart';

class StorageException extends AppException {
  StorageException({String? message})
      : super(message: message ?? 'Can\'t access storage');

  @override
  String toString() => message;
}
