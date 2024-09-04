class ApiResponse<T> {
  final bool error;
  final String message;
  final T data;

  ApiResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return ApiResponse(
      error: json['error'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }

  List<T>? extractData() {
    return data is List<T> ? data as List<T> : null;
  }
}
