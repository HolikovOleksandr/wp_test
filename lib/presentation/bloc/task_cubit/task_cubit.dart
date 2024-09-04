import 'package:bloc/bloc.dart';
import 'package:wp_test/models/task.dart';

class TaskCubit extends Cubit<List<Task>> {
  TaskCubit() : super([]);

  void setTasks(List<Task> tasks) => emit(tasks);
}
