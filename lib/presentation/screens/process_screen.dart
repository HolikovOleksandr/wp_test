import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiSuccess<List<Task>>) {
            final tasks = state.data;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text('Task ID: ${task.id}'),
                  subtitle: Text('Start: (${task.start.x}, ${task.start.y})'),
                );
              },
            );
          } else if (state is ApiFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No tasks available.'));
          }
        },
      ),
    );
  }
}
