class AuthException implements Exception {
  String _message;
  AuthException(this._message);

  String toString() {
    return _message;
  }
}
