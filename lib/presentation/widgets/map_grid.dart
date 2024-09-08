import 'package:wp_test/presentation/widgets/map_grid_item.dart';
import 'package:wp_test/models/task.dart';
import 'package:flutter/material.dart';

class GameMapGrid extends StatelessWidget {
  final Task task;

  const GameMapGrid({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final gameMap = task.gameMap;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gameMap.field[0].length,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
      itemCount: gameMap.field.length * gameMap.field[0].length,
      itemBuilder: (context, index) {
        final x = index ~/ gameMap.field[0].length;
        final y = index % gameMap.field[0].length;
        final point = gameMap.field[x][y];

        return GridItem(steps: task.result!.steps, gamePoint: point);
      },
    );
  }
}
