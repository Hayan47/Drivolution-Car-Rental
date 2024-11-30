enum NetworkExceptionType { connectionFailed, timeout, unknown }

class NetworkException implements Exception {
  final String message;
  final NetworkExceptionType type;

  NetworkException({required this.message, required this.type});

  factory NetworkException.connectionFailed() {
    return NetworkException(
        message:
            'Unable to connect to the service. Please check your internet connection.',
        type: NetworkExceptionType.connectionFailed);
  }

  factory NetworkException.timeout() {
    return NetworkException(
        message: 'Connection timed out. Please try again.',
        type: NetworkExceptionType.timeout);
  }
}
