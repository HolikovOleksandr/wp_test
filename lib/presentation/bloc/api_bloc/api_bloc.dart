import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/data/data_provider.dart';
import 'package:wp_test/models/api_response.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final TaskCubit taskCubit;

  ApiBloc({required this.taskCubit}) : super(ApiInitial()) {
    on<FetchTasks>((event, emit) async {
      emit(ApiLoading());

      try {
        final ApiResponse<List<Task>> response = await DataProvider.getRequest(
          endpoint: event.endpoint,
        );

        if (response.error) {
          emit(ApiFailure(message: response.message));
          debugPrint("[ApiBloc] :::>>>" + response.message);
        } else {
          taskCubit.setTasks(response.data!);
          emit(ApiSuccessGet<List<Task>>(
              data: response.data!, endpoint: event.endpoint));

          debugPrint("[ApiBloc] First task :::>>>" +
              response.data![0].gameMap.visualize());
        }
      } catch (e) {
        emit(ApiFailure(message: e.toString()));
      }
    });

    on<SendResults>((event, emit) async {
      try {
        final apiState = state;
        if (apiState is ApiSuccessGet) {
          final success = await DataProvider.postRequest(
            endpoint: apiState.endpoint,
            tasks: event.tasks,
          );

          debugPrint(
              '[ApiBloc] First answer :::>>> ${event.tasks[0].toJson()}');

          if (success) {
            emit(ApiSuccessPost(message: 'Results successfully sent'));
          } else {
            emit(ApiFailure(message: 'Failed to send results'));
          }
        } else {
          emit(ApiFailure(message: 'No endpoint available'));
        }
      } catch (e) {
        emit(ApiFailure(message: e.toString()));
      }
    });
  }
}
