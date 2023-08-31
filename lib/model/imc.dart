import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  DateTime nascimento;
  double altura;
  double peso;

  IMC(this.nascimento, this.altura, this.peso);

  double get imc => peso / (altura * altura);

  String get id => _id;

  List<double> pesoIdeal() {
    double imcMin = 18.5;
    double imcMax = 25.0;
    var pesoMin = imcMin * (altura * altura);
    var pesoMax = imcMax * (altura * altura);

    return [pesoMin, pesoMax];
  }
}
