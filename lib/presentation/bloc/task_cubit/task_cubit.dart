import 'package:wp_test/presentation/bloc/task_cubit/task_state.dart';
import 'package:wp_test/models/result.dart';
import 'package:wp_test/models/task.dart';
import 'package:bloc/bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void setTasks(List<Task> tasks) {
    emit(TaskLoaded(tasks: tasks));
  }

  Future<void> findResultsForEachTask() async {
    final state = this.state;

    if (state is! TaskLoaded) {
      emit(TaskError(error: "No tasks available to calculate."));
      return;
    }

    final tasks = state.tasks;
    int totalTasks = tasks.length;

    emit(TaskCalculationInProgress(progress: 0));

    try {
      for (int i = 0; i < totalTasks; i++) {
        final task = tasks[i];
        task.result = Result.calculateOptimalPath(task);

        double progress = ((i + 1) / totalTasks) * 100;
        emit(TaskCalculationInProgress(progress: progress.round()));
      }

      emit(TaskCalculationCompleted(tasks: tasks));
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }
}
