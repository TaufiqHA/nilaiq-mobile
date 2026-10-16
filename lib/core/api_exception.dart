/// A user friendly wrapper around API failures.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.errors});

  final String message;
  final int? statusCode;
  final Map<String, List<String>>? errors;

  bool get isUnauthenticated => statusCode == 401;

  bool get isUnreachable =>
      statusCode == null &&
      (message.toLowerCase().contains('socket') ||
          message.toLowerCase().contains('connection') ||
          message.toLowerCase().contains('timeout') ||
          message.toLowerCase().contains('unreachable'));

  @override
  String toString() => message;
}
