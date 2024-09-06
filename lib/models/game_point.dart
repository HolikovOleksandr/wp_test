import 'dart:math';

class GamePoint extends Point<int> {
  const GamePoint(super.x, super.y);

  factory GamePoint.fromJson(Map<String, dynamic> json) {
    return GamePoint(json['x'] as int, json['y'] as int);
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y};

  @override
  String toString() => '($x, $y)';
}
