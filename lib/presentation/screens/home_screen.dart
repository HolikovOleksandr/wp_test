import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ApiSuccess<List<Task>>) {
            final tasks = state.data;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text('Task ID: ${task.id}'),
                  subtitle: Text('Start: (${task.start.x}, ${task.start.y})'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/second',
                    );
                  },
                );
              },
            );
          } else if (state is ApiFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Press the button to fetch tasks.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ApiBloc>(context).add(
            FetchTasks(endpoint: 'https://flutter.webspark.dev/flutter/api'),
          );
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
