import 'package:firebase_auth/firebase_auth.dart';

enum StorageExceptionType {
  unauthorized,
  objectNotFound,
  bucketNotFound,
  quotaExceeded,
  invalidChecksum,
  unknown
}

class StorageException implements Exception {
  final String message;
  final StorageExceptionType type;

  StorageException({required this.message, required this.type});

  factory StorageException.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'unauthorized':
        return StorageException(
            message:
                'You are not authorized to perform this storage operation.',
            type: StorageExceptionType.unauthorized);
      case 'object-not-found':
        return StorageException(
            message: 'The requested file does not exist.',
            type: StorageExceptionType.objectNotFound);
      case 'bucket-not-found':
        return StorageException(
            message: 'The specified storage bucket was not found.',
            type: StorageExceptionType.bucketNotFound);
      case 'quota-exceeded':
        return StorageException(
            message: 'Storage quota has been exceeded.',
            type: StorageExceptionType.quotaExceeded);
      case 'invalid-checksum':
        return StorageException(
            message: 'File upload failed due to checksum validation.',
            type: StorageExceptionType.invalidChecksum);
      default:
        return StorageException(
            message: e.message ?? 'An unknown storage error occurred',
            type: StorageExceptionType.unknown);
    }
  }
}
