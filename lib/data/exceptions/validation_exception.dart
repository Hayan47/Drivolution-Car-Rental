import 'package:drivolution/data/exceptions/api_exception.dart';

class ValidationException extends ApiException {
  ValidationException({
    required Map<String, List<String>> super.errors,
    super.statusCode,
  }) : super(
          message: _generateMessage(errors),
        );

  factory ValidationException.fromJson(Map<String, dynamic> json) {
    final errors = <String, List<String>>{};

    json.forEach((key, value) {
      if (value is List) {
        errors[key] = value.map((e) => e.toString()).toList();
      } else if (value is String) {
        errors[key] = [value];
      }
    });

    return ValidationException(errors: errors);
  }

  /// Generates a formatted message from the errors map.
  static String _generateMessage(Map<String, List<String>> errors) {
    return errors.entries
        .map((e) => '${e.key}: ${e.value.join(", ")}')
        .join('\n');
  }

  List<String>? getFieldErrors(String field) => errors![field];

  @override
  String toString() => message;
}
