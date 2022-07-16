class MomentException implements Exception {
  final String message;

  const MomentException(this.message);

  @override
  String toString() {
    return "[Moment Dart] Exception: $message";
  }
}
