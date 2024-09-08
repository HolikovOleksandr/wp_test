import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';

class MyBlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<TaskCubit>(create: (context) => TaskCubit()),
        BlocProvider<ApiBloc>(
          create: (context) => ApiBloc(
            taskCubit: context.read<TaskCubit>(),
          ),
        ),
      ];
}
