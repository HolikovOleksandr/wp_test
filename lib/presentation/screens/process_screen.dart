import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_state.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.title});

  final String title;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.title} Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskCalculationInProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: state.progress / 100),
                  SizedBox(height: 20),
                  Text('Progress: ${state.progress}%'),
                ],
              ),
            );
          }

          if (state is TaskCalculationCompleted) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Calculation Completed'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => debugPrint(state.tasks.toString()),
                    child: Text('Send results to server'),
                  ),
                ],
              ),
            );
          }

          if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Error: ${state.error}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TaskCubit>().findResultsForEachTask();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                final result =
                    context.read<TaskCubit>().findResultsForEachTask();
                debugPrint(result.toString());
              },
              child: Text('Start Calculation'),
            ),
          );
        },
      ),
    );
  }
}
