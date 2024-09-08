import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_state.dart';
import 'package:wp_test/presentation/widgets/task_list_item.dart';

class ResultsListScreen extends StatefulWidget {
  const ResultsListScreen({super.key, required this.title});

  final String title;

  @override
  State<ResultsListScreen> createState() => _ResultsListScreenState();
}

class _ResultsListScreenState extends State<ResultsListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.title} Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is TaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is TaskCalculationInProgress) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TaskCalculationCompleted) {
                final tasks = state.tasks;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(task: tasks[index]);
                  },
                );
              } else if (state is TaskError) {
                return Center(child: Text(state.error));
              } else {
                return Center(child: Text('No results available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
