import 'package:equatable/equatable.dart';
import 'package:wp_test/models/send_task_dto.dart';

abstract class ApiEvent extends Equatable {}

class FetchTasks extends ApiEvent {
  final String endpoint;

  FetchTasks({required this.endpoint});

  @override
  List<Object?> get props => [endpoint];
}

class SendResults extends ApiEvent {
  final String? endpoint;
  final List<SendTaskDto> tasks;

  SendResults({required this.tasks, this.endpoint});

  @override
  List<Object?> get props => [tasks, endpoint];
}
