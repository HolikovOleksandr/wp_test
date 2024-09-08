import 'package:flutter/material.dart';
import 'package:wp_test/models/game_point.dart';

class GridItem extends StatelessWidget {
  final GamePoint gamePoint;
  final List<GamePoint> steps;

  const GridItem({super.key, required this.steps, required this.gamePoint});

  Color _setItemColor(GamePoint point) {
    if (point == steps.first) {
      return Color(0xFF64FFDA);
    } else if (point == steps.last) {
      return Color(0xFF009688);
    } else if (steps.contains(point)) {
      return Color(0xFF4CAF50);
    } else if (gamePoint.symbol == 'X') {
      return Color(0xFF000000);
    } else {
      return Color(0xFFFFFFFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
        ),
        color: _setItemColor(gamePoint),
      ),
      child: Center(
        child: Text(
          gamePoint.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: gamePoint.symbol == 'X' ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
