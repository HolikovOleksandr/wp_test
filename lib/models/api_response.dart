class ApiResponse<T> {
  final bool error;
  final String message;
  final T? data;

  ApiResponse({required this.error, required this.message, this.data});

  Map<String, dynamic> toJson() {
    return {'error': error, 'message': message, 'data': data};
  }

  static ApiResponse<T> fromJson<T>(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse<T>(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
