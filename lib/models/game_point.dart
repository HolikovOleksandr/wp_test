class GamePoint {
  final int x;
  final int y;
  final String symbol;
  final bool isAccessible;

  const GamePoint({
    required this.x,
    required this.y,
    required this.symbol,
  }) : isAccessible = symbol == '.';

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y, 'symbol': symbol};
  }

  factory GamePoint.fromJson(Map<String, dynamic> json) {
    return GamePoint(
      x: json['x'],
      y: json['y'],
      symbol: json['symbol'] ?? '!',
    );
  }
}
