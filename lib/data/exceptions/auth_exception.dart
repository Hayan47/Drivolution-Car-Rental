import 'package:firebase_auth/firebase_auth.dart';

enum AuthExceptionType {
  userNotFound,
  invalidCredentials,
  emailAlreadyInUse,
  invalidEmail,
  weakPassword,
  networkError,
  tooManyRequests,
  unknown
}

class AuthException implements Exception {
  final String message;
  final AuthExceptionType type;

  AuthException({required this.message, required this.type});

  factory AuthException.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException(
            message: 'No user found with this email.',
            type: AuthExceptionType.userNotFound);
      case 'wrong-password':
        return AuthException(
            message: 'Incorrect password. Please try again.',
            type: AuthExceptionType.invalidCredentials);
      case 'email-already-in-use':
        return AuthException(
            message: 'An account already exists with this email.',
            type: AuthExceptionType.emailAlreadyInUse);
      case 'invalid-email':
        return AuthException(
            message: 'The email address is not valid.',
            type: AuthExceptionType.invalidEmail);
      case 'weak-password':
        return AuthException(
            message:
                'The password is too weak. Please choose a stronger password.',
            type: AuthExceptionType.weakPassword);
      case 'network-request-failed':
        return AuthException(
            message: 'Network error. Please check your internet connection.',
            type: AuthExceptionType.networkError);
      case 'too-many-requests':
        return AuthException(
            message: 'Too many requests. Please try again later.',
            type: AuthExceptionType.tooManyRequests);
      default:
        return AuthException(
            message: e.message ?? 'An unknown error occurred',
            type: AuthExceptionType.unknown);
    }
  }
}
