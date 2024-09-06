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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(value: state.progress / 100),
                      SizedBox(height: 20),
                      Text('Progress: ${state.progress}%'),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return ListTile(
                              title: Text('Task ${task.id}'),
                              subtitle:
                                  Text('Field: ${task.gameMap.toString()}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is TaskCalculationCompleted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Calculation Completed'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('Results: ${state.tasks}');
                    // Logic to send results to the server
                  },
                  child: Text('Send results to server'),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return ListTile(
                        title: Text('Task ${task.id}'),
                        subtitle: Text('Field: ${task.gameMap.toString()}'),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error occurred: ${state.error}'),
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

          // Initial state or any other state
          return Center(
            child: ElevatedButton(
              onPressed: state is! TaskCalculationInProgress
                  ? () {
                      context.read<TaskCubit>().findResultsForEachTask();
                    }
                  : null, 
              child: Text('Start Calculation'),
            ),
          );
        },
      ),
    );
  }
}
