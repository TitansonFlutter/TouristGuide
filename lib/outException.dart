class AppExc implements Exception {
  String _message;
  AppExc(this._message);

  String toString() {
    return _message;
  }
}
