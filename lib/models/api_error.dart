class ApiError {
  final String message;
  final int statusCode;

  ApiError({required this.message, required this.statusCode});

  factory ApiError.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiError(
      message: json['error'] ?? 'Ocorreu um erro desconhecido.',
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return 'Erro $statusCode: $message';
  }
}
