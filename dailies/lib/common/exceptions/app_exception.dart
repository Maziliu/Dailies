class AppException implements Exception {
  final String customErrorMessage;

  AppException({required this.customErrorMessage});

  @override
  String toString() => customErrorMessage;
}
