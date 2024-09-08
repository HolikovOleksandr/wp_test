import 'package:flutter/material.dart';
import 'package:wp_test/models/task.dart';
import 'package:wp_test/presentation/widgets/map_grid.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.title, required this.task});

  final String title;
  final Task task;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
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
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: GameMapGrid(task: widget.task)),
              Text(
                widget.task.result!.path,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
