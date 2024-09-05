// ignore_for_file: unused_local_variable

import 'dart:collection';
import 'package:wp_test/models/game_point.dart';
import 'package:wp_test/models/task.dart';

class Result {
  final List<GamePoint> steps;
  final String path;

  Result({required this.steps, required this.path});

  static Result calculateOptimalPath(Task task) {
    final map = task.gameMap; // Get the game map
    final start = task.start; // Starting point
    final finish = task.end; // Ending point

    // Check if start or end points are not accessible
    if (!start.isAccessible || !finish.isAccessible) {
      return Result(steps: [], path: "No path found");
    }

    // Define directions to move (including diagonals)
    final directions = [
      GamePoint(x: 0, y: 1, symbol: '.'),
      GamePoint(x: 1, y: 0, symbol: '.'),
      GamePoint(x: 0, y: -1, symbol: '.'),
      GamePoint(x: -1, y: 0, symbol: '.'),
      GamePoint(x: 1, y: 1, symbol: '.'),
      GamePoint(x: 1, y: -1, symbol: '.'),
      GamePoint(x: -1, y: 1, symbol: '.'),
      GamePoint(x: -1, y: -1, symbol: '.'),
    ];

    final queue = Queue<List<GamePoint>>(); // Queue for BFS
    final visited = <GamePoint>{}; // Set to track visited points
    final parent = <GamePoint, GamePoint>{}; // Map to store parent points

    queue.add([start]); // Start with the starting point
    visited.add(start); // Mark the start point as visited

    while (queue.isNotEmpty) {
      final path = queue.removeFirst(); // Get the current path
      final current = path.last; // Current point in the path

      // Check if we've reached the end point
      if (current.x == finish.x && current.y == finish.y) {
        return Result(steps: path, path: _formatPath(path));
      }

      // Explore all directions
      for (var dir in directions) {
        final newX = current.x + dir.x;
        final newY = current.y + dir.y;

        try {
          // Get the next point
          final nextPoint = map.getPoint(newX, newY);

          // Check if the next point is accessible and not visited
          if (nextPoint.isAccessible && !visited.contains(nextPoint)) {
            visited.add(nextPoint); // Mark next point as visited
            parent[nextPoint] = current; // Set the parent of next point
            queue.add([...path, nextPoint]); // Add new path to the queue
          }
        } catch (e) {
          // Handle cases where coordinates are out of bounds
        }
      }
    }

    return Result(steps: [], path: "No path found");
  }

  static String _formatPath(List<GamePoint> path) {
    return path.map((p) => '(${p.x},${p.y})').join('->');
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((e) => e.toJson()).toList(),
      'path': path,
    };
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      steps: (json['steps'] as List<dynamic>)
          .map((item) => GamePoint.fromJson(item as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
    );
  }
}
