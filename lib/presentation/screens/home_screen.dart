import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/widgets/input_field.dart';
import 'package:wp_test/presentation/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() => super.initState();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // ========== Only during development =============
        leading: IconButton(
          onPressed: () {
            setState(
              () => _inputController.text =
                  'https://flutter.webspark.dev/flutter/api',
            );
          },
          icon: Icon(
            Icons.arrow_downward_rounded,
          ),
        ),
        // ================================================
        title: Text(
          '${widget.title} Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        listener: (context, state) {
          if (state is ApiSuccess<List<Task>>) {
            context.read<TaskCubit>().setTasks(state.data);
            Navigator.of(context).pushNamed('/process');
          } else if (state is ApiFailure) {
            _showSnackbar('Error: ${state.message}');
          }
        },
        builder: (context, state) {
          if (state is ApiLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InputField(
                      label: 'API URL',
                      icon: Icons.api,
                      controller: _inputController,
                    ),
                    Spacer(),
                    PrimaryButton(
                      text: 'Start',
                      onPressed: () {
                        context
                            .read<ApiBloc>()
                            .add(FetchTasks(endpoint: _inputController.text));
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
