import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';
import 'package:wp_test/data/data_provider.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/models/api_response.dart';
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
        } else {
          taskCubit.setTasks(response.data);
          emit(ApiSuccess<List<Task>>(data: response.data));
        }
      } catch (e) {
        emit(ApiFailure(message: e.toString()));
      }
    });

    on<ValidateUrl>((event, emit) async {
      final error = _validateUrl(event.url);

      if (error != null) {
        emit(ApiUrlValidation(error: error));
        return;
      }

      try {
        final response = await DataProvider.getRequest(endpoint: event.url);

        response.error
            ? emit(ApiUrlValidation(error: response.message))
            : emit(ApiUrlValidation(error: null));
      } catch (e) {
        emit(ApiUrlValidation(error: 'Failed to validate URL'));
      }
    });
  }

  String? _validateUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'Invalid URL format';
    }
    return null;
  }
}
