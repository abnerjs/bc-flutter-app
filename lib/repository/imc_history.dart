import 'package:hive/hive.dart';
import 'package:imc/model/imc.dart';

class IMCRepository {
  static late Box _box;

  IMCRepository._();

  static Future<IMCRepository> init() async {
    _box = Hive.isBoxOpen('imc_history')
        ? Hive.box('imc_history')
        : await Hive.openBox('imc_history');

    return IMCRepository._();
  }

  List<IMC> get imcHistory => _box.values.toList().cast<IMC>();

  void add(IMC imc) => _box.add(imc);

  void delete(IMC imc) => _box.delete(imc.key);

  void update(IMC imc) => _box.put(imc.key, imc);

  void clear() => _box.clear();
}
