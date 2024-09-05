import 'package:equatable/equatable.dart';
import 'package:wp_test/models/task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskCalculationInProgress extends TaskState {
  final int progress;

  TaskCalculationInProgress({required this.progress});

  @override
  List<Object> get props => [progress];
}

class TaskCalculationCompleted extends TaskState {
  final List<Task> tasks;

  TaskCalculationCompleted({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String error;

  TaskError({required this.error});

  @override
  List<Object> get props => [error];
}
