import 'package:wp_test/models/game_map.dart';
import 'package:wp_test/models/game_point.dart';
import 'package:wp_test/models/result.dart';
import 'package:wp_test/models/send_task_dto.dart';

class Task {
  final String id;
  final GameMap gameMap;
  final GamePoint start, end;
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

    final result =
        json['result'] != null ? Result.fromJson(json['result']) : null;

    return Task(
      id: json['id'],
      gameMap: gameMap,
      start: start,
      end: end,
      result: result,
    );
  }

  SendTaskDto toSendTaskDto() {
    return result != null
        ? SendTaskDto(id: id, result: result!)
        : throw Exception('Task result is null');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameMap': gameMap.toJson(),
      'start': {'x': start.x, 'y': start.y},
      'end': {'x': end.x, 'y': end.y},
      'result': result?.toJson(),
    };
  }
}
