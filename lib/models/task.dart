import 'package:wp_test/models/position.dart';

class Task {
  final String id;
  final List<String> field;
  final Position start;
  final Position end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Position.fromJson(json['start']),
      end: Position.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}
