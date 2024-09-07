import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wp_test/helpers/app_bloc_observer.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/router/app_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

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
        BlocProvider(create: (context) => ApiBloc(taskCubit: TaskCubit())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGeneratedRoute,
        initialRoute: '/',
      ),
    );
  }
}
