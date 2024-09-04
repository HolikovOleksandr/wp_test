abstract class ApiEvent {}

class FetchTasks extends ApiEvent {
  final String endpoint;

  FetchTasks({required this.endpoint});
}
