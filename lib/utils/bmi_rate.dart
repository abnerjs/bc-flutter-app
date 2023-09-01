import 'package:flutter/material.dart';
import 'package:imc/enum/bmi_type.dart';

class BMIReturnType {
  final BMIType label;
  final Color color;

  BMIReturnType(this.label, this.color);
}

BMIReturnType getBMIType(double imc) {
  if (imc < 16) {
    return BMIReturnType(
      BMIType.magrezaGrave,
      const Color(0xFFFFCCBC),
    );
  } else if (imc < 17) {
    return BMIReturnType(
      BMIType.magrezaModerada,
      const Color(0xFFFFE082),
    );
  } else if (imc < 18.5) {
    return BMIReturnType(
      BMIType.magrezaLeve,
      const Color(0xFFFFF59D),
    );
  } else if (imc < 25) {
    return BMIReturnType(
      BMIType.saudavel,
      const Color(0xFFC8E6C9),
    );
  } else if (imc < 30) {
    return BMIReturnType(
      BMIType.sobrepeso,
      const Color(0xFFFFF59D),
    );
  } else if (imc < 35) {
    return BMIReturnType(
      BMIType.obesidade1,
      const Color(0xFFFFE082),
    );
  } else if (imc < 40) {
    return BMIReturnType(
      BMIType.obesidade2,
      const Color(0xFFFFCCBC),
    );
  } else {
    return BMIReturnType(
      BMIType.obesidade3,
      const Color(0xFFFAB1A9),
    );
  }
}
