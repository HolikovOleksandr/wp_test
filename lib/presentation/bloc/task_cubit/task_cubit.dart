import 'package:logger/logger.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wp_test/models/result.dart';
import 'package:wp_test/models/task.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  final Logger _logger = Logger();

  void setTasks(List<Task> tasks) {
    emit(TaskLoaded(tasks: tasks));
  }

  Future<void> findResultsForEachTask() async {
    final state = this.state;

    if (state is! TaskLoaded) {
      emit(TaskError(error: "No tasks available to calculate"));
      return;
    }

    final tasks = state.tasks;

    emit(TaskCalculationInProgress(progress: 0, tasks: tasks));

    try {
      for (int i = 0; i < tasks.length; i++) {
        final task = tasks[i];
        task.result = Result.calculateOptimalPath(task);
        _logger.d("!!!!!!!!!" + tasks[i].result!.steps.toString());

        double progress = ((i + 1) / tasks.length) * 100;

        emit(TaskCalculationInProgress(
          progress: progress.round(),
          tasks: tasks,
        ));
      }
      emit(TaskCalculationCompleted(tasks: tasks));
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }

  @override
  TaskState fromJson(Map<String, dynamic> json) {
    final tasksJson = json['tasks'] as List<dynamic>?;
    if (tasksJson == null) return TaskInitial();

    final tasks = tasksJson
        .map((taskJson) => Task.fromJson(taskJson as Map<String, dynamic>))
        .toList();

    return TaskLoaded(tasks: tasks);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state is TaskLoaded
        ? {'tasks': state.tasks.map((task) => task.toJson()).toList()}
        : null;
  }
}
