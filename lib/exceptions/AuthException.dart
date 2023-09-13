class AuthException implements Exception {
  final String message;
  final int code; // You can add a custom error code if needed

  AuthException(this.message, {this.code = 0});

  @override
  String toString() {
    return 'AuthException: $message (Code: $code)';
  }
}