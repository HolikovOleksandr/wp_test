import 'dart:collection';
import 'package:wp_test/models/game_map.dart';
import 'package:wp_test/models/game_point.dart';
import 'package:wp_test/models/task.dart';

class Result {
  final List<GamePoint> steps;
  final String path;

  Result({required this.steps, required this.path});

  static Result calculateOptimalPath(Task task) {
    final start = task.start;
    final end = task.end;
    final gameMap = task.gameMap;

    final Queue<GamePoint> queue = Queue();
    final Map<GamePoint, GamePoint?> cameFrom = {};
    final Set<GamePoint> visited = {};

    cameFrom.addAll(_initializeAlgorithm(start, queue, visited));

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      // Якщо досягли кінцевої точки
      if (current == end) {
        final path = _reconstructPath(cameFrom, current);
        return Result(
          steps: path,
          path: _formatPath(path),
        );
      }

      // Перевірка сусідніх точок
      for (var neighbor in _getNeighbors(current, gameMap)) {
        if (visited.contains(neighbor)) continue;

        queue.add(neighbor);
        visited.add(neighbor);
        cameFrom[neighbor] = current;
      }
    }

    return Result(steps: [], path: 'No path found');
  }

  static Map<GamePoint, GamePoint?> _initializeAlgorithm(
    GamePoint start,
    Queue<GamePoint> queue,
    Set<GamePoint> visited,
  ) {
    final cameFrom = <GamePoint, GamePoint?>{};

    queue.add(start);
    cameFrom[start] = null;
    visited.add(start);

    return cameFrom;
  }

  static List<GamePoint> _reconstructPath(
    Map<GamePoint, GamePoint?> cameFrom,
    GamePoint current,
  ) {
    final path = <GamePoint>[];

    while (cameFrom.containsKey(current)) {
      path.add(current);
      final previous = cameFrom[current];

      if (previous == null) break;
      current = previous;
    }

    return path.reversed.toList();
  }

  static List<GamePoint> _getNeighbors(GamePoint point, GameMap gameMap) {
    final neighbors = <GamePoint>[];

    final directions = [
      GamePoint(1, 0),
      GamePoint(-1, 0),
      GamePoint(0, 1),
      GamePoint(0, -1),
      GamePoint(1, 1),
      GamePoint(1, -1),
      GamePoint(-1, 1),
      GamePoint(-1, -1),
    ];

    for (var direction in directions) {
      final newX = point.x + direction.x;
      final newY = point.y + direction.y;

      if (newX >= 0 &&
          newX < gameMap.field.length &&
          newY >= 0 &&
          newY < gameMap.field[0].length) {
        final neighborPoint = gameMap.field[newX][newY];

        if (neighborPoint.symbol != 'X') {
          neighbors.add(neighborPoint);
        }
      }
    }

    return neighbors;
  }

  static String _formatPath(List<GamePoint> path) {
    return path.map((p) => '(${p.x},${p.y})').join('->');
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((e) => {'x': e.x, 'y': e.y}).toList(),
      'path': path,
    };
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      steps: (json['steps'] as List<dynamic>)
          .map((item) => GamePoint(item['x'] as int, item['y'] as int))
          .toList(),
      path: json['path'] as String,
    );
  }
}
