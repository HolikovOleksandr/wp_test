import 'package:flutter/material.dart';
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
    result,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      gameMap: GameMap.fromDynamicList(json['field']),
      start: GamePoint.fromJson(json['start']),
      end: GamePoint.fromJson(json['end']),
    );
  }
}
