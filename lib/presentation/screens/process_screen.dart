import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:wp_test/presentation/bloc/task_cubit/task_state.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_bloc.dart';
import 'package:wp_test/presentation/bloc/api_bloc/api_event.dart';
import 'package:wp_test/presentation/widgets/primary_button.dart';
import 'package:wp_test/models/send_task_dto.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.title});

  final String title;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskCubit>().findResultsForEachTask();
    });
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
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskInitial) {
                return Center(child: Text('No tasks loaded'));
              } else if (state is TaskLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TaskCalculationInProgress) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Calculating...'),
                    SizedBox(height: 20),
                    LinearProgressIndicator(value: state.progress / 100),
                    Text('${state.progress}% completed'),
                  ],
                );
              } else if (state is TaskCalculationCompleted) {
                final tasks = state.tasks;

                return Column(
                  children: [
                    Spacer(),
                    PrimaryButton(
                      text: 'Send results to server',
                      onPressed: () async {
                        final List<SendTaskDto> sendTasks =
                            tasks.map((task) => task.toSendTaskDto()).toList();

                        context
                            .read<ApiBloc>()
                            .add(SendResults(tasks: sendTasks));

                        Navigator.of(context).pushReplacementNamed('/results');
                      },
                    ),
                  ],
                );
              }

              return Center(child: Text('Unexpected state'));
            },
          ),
        ),
      ),
    );
  }
}
