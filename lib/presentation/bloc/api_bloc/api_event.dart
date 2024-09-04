// api_event.dart
abstract class ApiEvent {}

class FetchTasks extends ApiEvent {
  final String endpoint;

  FetchTasks({required this.endpoint});
}

class ValidateUrl extends ApiEvent {
  final String url;

  ValidateUrl({required this.url});
}
