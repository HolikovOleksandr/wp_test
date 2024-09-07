abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccessPost extends ApiState {
  final String message;

  ApiSuccessPost({required this.message});
}

class ApiSuccessGet<T> extends ApiState {
  final T data;

  ApiSuccessGet({required this.data});
}

class ApiFailure extends ApiState {
  final String message;

  ApiFailure({required this.message});
}
