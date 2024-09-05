import 'package:wp_test/models/game_point.dart';

class GameMap {
  final List<List<GamePoint>> field;

  GameMap(this.field);

  static GameMap fromDynamicList(List<dynamic> lines) {
    List<List<GamePoint>> field = [];

    if (lines.isEmpty || lines.first is! String) {
      throw ArgumentError('Invalid format for lines');
    }

    for (int x = 0; x < lines.length; x++) {
      List<GamePoint> row = [];

      if (lines[x] is! String) {
        throw ArgumentError('Invalid format for line $x');
      }

      for (int y = 0; y < (lines[x] as String).length; y++) {
        String symbol = (lines[x] as String)[y];
        row.add(GamePoint(x: x, y: y, symbol: symbol));
      }

      field.add(row);
    }

    return GameMap(field);
  }

  GamePoint getPoint(int x, int y) {
    if (x >= 0 && x < field.length && y >= 0 && y < field[0].length) {
      return field[x][y];
    } else {
      throw ArgumentError('Invalid coordinates');
    }
  }
}
