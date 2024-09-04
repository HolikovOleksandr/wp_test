import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()),
        BlocProvider(
          create: (context) => ApiBloc(
            taskCubit: TaskCubit(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGeneratedRoute,
        initialRoute: '/',
      ),
    );
  }
}
