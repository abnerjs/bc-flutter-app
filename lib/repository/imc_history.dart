import 'package:imc/model/imc.dart';

class IMCRepository {
  final List<IMC> _imcHistory = [];

  List<IMC> get imcHistory => _imcHistory;

  addIMC(IMC imc) {
    _imcHistory.add(imc);
  }

  removeIMC(IMC imc) {
    _imcHistory.remove(imc);
  }

  removeAll() {
    _imcHistory.clear();
  }

  updateIMC(IMC imc) {
    var index = _imcHistory.indexWhere((element) => element.id == imc.id);
    _imcHistory[index] = imc;
  }
}
