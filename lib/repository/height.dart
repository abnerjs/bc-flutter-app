import 'package:hive/hive.dart';

class HeightRepository {
  static late Box _box;

  HeightRepository._();

  static Future<HeightRepository> init() async {
    _box = Hive.isBoxOpen('height')
        ? Hive.box('height')
        : await Hive.openBox('height');

    return HeightRepository._();
  }

  int get height => _box.get('height', defaultValue: 175);

  set height(int value) => _box.put('height', value);
}
