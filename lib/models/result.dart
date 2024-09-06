import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:wp_test/models/game_map.dart';
import 'package:wp_test/models/game_point.dart';
import 'package:wp_test/models/task.dart';

class Result {
  final List<GamePoint> steps;
  final String path;

  Result({required this.steps, required this.path});

  static Result calculateOptimalPath(Task task) {
    debugPrint('[calculateOptimalPath] start');
    final start = task.start;
    final end = task.end;
    final gameMap = task.gameMap;

    final Queue<GamePoint> queue = Queue();
    final Map<GamePoint, GamePoint?> cameFrom = {};
    final Set<GamePoint> visited = {};

    cameFrom.addAll(_initializeAlgorithm(start, queue, visited));

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current == end) {
        final path = _reconstructPath(cameFrom, current);
        return Result(
          steps: path,
          path: _formatPath(path),
        );
      }

      for (var neighbor in _getNeighbors(current, gameMap)) {
        if (visited.contains(neighbor)) continue;

        queue.add(neighbor);
        visited.add(neighbor);
        cameFrom[neighbor] = current;
      }
      debugPrint('[calculateOptimalPath] end');
    }

    debugPrint('[calculateOptimalPath] No path found');
    return Result(steps: [], path: 'No path found');
  }

  static Map<GamePoint, GamePoint?> _initializeAlgorithm(
    GamePoint start,
    Queue<GamePoint> queue,
    Set<GamePoint> visited,
  ) {
    final cameFrom = <GamePoint, GamePoint?>{};
    debugPrint('[_initializeAlgorithm] Start');

    queue.add(start);
    cameFrom[start] = null;
    visited.add(start);

    debugPrint('[_initializeAlgorithm] End');
    return cameFrom;
  }

  static List<GamePoint> _reconstructPath(
    Map<GamePoint, GamePoint?> cameFrom,
    GamePoint current,
  ) {
    debugPrint('[_reconstructPath] Start');
    final path = <GamePoint>[];

    while (cameFrom.containsKey(current)) {
      path.add(current);
      final previous = cameFrom[current];

      if (previous == null) {
        debugPrint('[_reconstructPath] Error: current has no previous');
        break;
      }

      current = previous;
    }

    debugPrint('[_reconstructPath] End');
    return path.reversed.toList();
  }

  static List<GamePoint> _getNeighbors(GamePoint point, GameMap gameMap) {
    debugPrint('[_getNeighbors] Start');
    final neighbors = <GamePoint>[];

    final directions = [
      GamePoint(1, 0), // Right
      GamePoint(-1, 0), // Left
      GamePoint(0, 1), // Down
      GamePoint(0, -1), // Up
      GamePoint(1, 1), // Down-right
      GamePoint(1, -1), // Down-left
      GamePoint(-1, 1), // Up-right
      GamePoint(-1, -1), // Up-left
    ];

    for (var direction in directions) {
      final newX = point.x + direction.x;
      final newY = point.y + direction.y;

      if (newX >= 0 &&
          newX < gameMap.field.length &&
          newY >= 0 &&
          newY < gameMap.field[0].length &&
          !gameMap.isBlocked(GamePoint(newX, newY))) {
        neighbors.add(GamePoint(newX, newY));
      }
    }

    debugPrint('[_getNeighbors] End');
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
