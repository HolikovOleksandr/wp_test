// api_state.dart
abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccess<T> extends ApiState {
  final T data;

  ApiSuccess({required this.data});
}

class ApiFailure extends ApiState {
  final String message;

  ApiFailure({required this.message});
}

class ApiUrlValidation extends ApiState {
  final String? error;

  ApiUrlValidation({this.error});
}
