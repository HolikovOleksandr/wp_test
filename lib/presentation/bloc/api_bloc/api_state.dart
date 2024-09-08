abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccessPost extends ApiState {
  final String message;

  ApiSuccessPost({required this.message});
}

class ApiSuccessGet<T> extends ApiState {
  final T data;
  final String endpoint;

  ApiSuccessGet({required this.data, required this.endpoint});
}

class ApiFailure extends ApiState {
  final String message;

  ApiFailure({required this.message});
}
