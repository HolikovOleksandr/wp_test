import 'package:wp_test/models/game_point.dart';

class GameMap {
  final List<List<GamePoint>> field;
  GameMap(this.field);

  String getSymbol(GamePoint point) {
    if (point.x >= 0 &&
        point.x < field.length &&
        point.y >= 0 &&
        point.y < field[0].length) {
      return field[point.x][point.y].toString();
    } else {
      throw ArgumentError('Invalid coordinates');
    }
  }

  bool isBlocked(GamePoint point) {
    return getSymbol(point) == 'X';
  }

  static GameMap createGameMap(List<dynamic> fieldStrings) {
    final List<String> stringField = fieldStrings.cast<String>();

    final field = List<List<GamePoint>>.generate(
      stringField.length,
      (x) => List<GamePoint>.generate(
        stringField[x].length,
        (y) => GamePoint(x, y),
      ),
    );

    return GameMap(field);
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field
          .map((row) => row.map((point) => point.toJson()).toList())
          .toList(),
    };
  }
}
