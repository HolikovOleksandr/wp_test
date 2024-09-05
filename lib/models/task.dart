import 'package:wp_test/models/game_map.dart';
import 'package:wp_test/models/game_point.dart';
import 'package:wp_test/models/result.dart';

class Task {
  final String id;
  final GameMap gameMap;
  final GamePoint start;
  final GamePoint end;
  Result? result;

  Task({
    required this.id,
    required this.gameMap,
    required this.start,
    required this.end,
    this.result,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    final gameMap = GameMap.createGameMap(json['field']);
    final start = GamePoint(json['start']['x'], json['start']['y']);
    final end = GamePoint(json['end']['x'], json['end']['y']);

    return Task(
      id: json['id'],
      gameMap: gameMap,
      start: start,
      end: end,
    );
  }
}
