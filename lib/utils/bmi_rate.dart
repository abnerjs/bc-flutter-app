import 'package:imc/enum/bmi_type.dart';

BMIType getBMIType(double imc) {
  if (imc < 16) {
    return BMIType.magrezaGrave;
  } else if (imc < 17) {
    return BMIType.magrezaModerada;
  } else if (imc < 18.5) {
    return BMIType.magrezaLeve;
  } else if (imc < 25) {
    return BMIType.saudavel;
  } else if (imc < 30) {
    return BMIType.sobrepeso;
  } else if (imc < 35) {
    return BMIType.obesidadeGrau1;
  } else if (imc < 40) {
    return BMIType.obesidadeGrau2;
  } else {
    return BMIType.obesidadeGrau3;
  }
}
