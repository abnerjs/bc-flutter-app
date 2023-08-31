import 'package:flutter/material.dart';

class BMIStatus {
  final String label;
  final Color color;

  const BMIStatus({required this.label, required this.color});
}

enum BMIType {
  @BMIStatus(label: 'Magreza grave', color: Colors.black) // < 16
  magrezaGrave,
  @BMIStatus(label: 'Magreza moderada', color: Colors.black) // < 17
  magrezaModerada,
  @BMIStatus(label: 'Magreza leve', color: Colors.black) // < 18.5
  magrezaLeve,
  @BMIStatus(label: 'Saudável', color: Colors.black) // < 25
  saudavel,
  @BMIStatus(label: 'Sobrepeso', color: Colors.black) // < 30
  sobrepeso,
  @BMIStatus(label: 'Obesidade grau 1', color: Colors.black) // < 35
  obesidadeGrau1,
  @BMIStatus(label: 'Obesidade grau 2', color: Colors.black) // < 40
  obesidadeGrau2,
  @BMIStatus(label: 'Obesidade grau 3', color: Colors.black) // >= 40
  obesidadeGrau3,
}
