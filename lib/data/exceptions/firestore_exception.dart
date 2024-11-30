import 'package:firebase_auth/firebase_auth.dart';

enum FirestoreExceptionType {
  permissionDenied,
  documentNotFound,
  documentAlreadyExists,
  invalidArgument,
  dataLoss,
  unknown
}

class FirestoreException implements Exception {
  final String message;
  final FirestoreExceptionType type;

  FirestoreException({required this.message, required this.type});

  factory FirestoreException.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return FirestoreException(
            message: 'You do not have permission to access this data.',
            type: FirestoreExceptionType.permissionDenied);
      case 'not-found':
        return FirestoreException(
            message: 'The requested document was not found.',
            type: FirestoreExceptionType.documentNotFound);
      case 'already-exists':
        return FirestoreException(
            message: 'A document with this ID already exists.',
            type: FirestoreExceptionType.documentAlreadyExists);
      case 'invalid-argument':
        return FirestoreException(
            message: 'Invalid argument provided to Firestore operation.',
            type: FirestoreExceptionType.invalidArgument);
      case 'data-loss':
        return FirestoreException(
            message: 'Unrecoverable data loss or corruption occurred.',
            type: FirestoreExceptionType.dataLoss);
      default:
        return FirestoreException(
            message: e.message ?? 'An unknown Firestore error occurred',
            type: FirestoreExceptionType.unknown);
    }
  }
}
