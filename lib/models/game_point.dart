import 'dart:math';

class GamePoint extends Point<int> {
  final String? symbol;

  const GamePoint(super.x, super.y, [this.symbol = '.']);

  factory GamePoint.fromJson(Map<String, dynamic> json) {
    return GamePoint(json['x'] as int, json['y'] as int, json['symbol']);
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'symbol': symbol};

  @override
  String toString() => symbol != null ? symbol! : '($x, $y)';
}
