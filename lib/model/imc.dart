import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  DateTime nascimento;
  double _altura;
  double _peso;

  IMC(this.nascimento, this._altura, this._peso);

  double imc() => _peso / ((_altura / 100) * (_altura / 100));

  String get id => _id;

  double get altura => _altura;

  double get peso => _peso;

  set altura(double altura) => _altura = altura;

  set peso(double peso) => _peso = peso;

  List<double> pesoIdeal() {
    double imcMin = 18.5;
    double imcMax = 25.0;
    var pesoMin = imcMin * (_altura * _altura);
    var pesoMax = imcMax * (_altura * _altura);

    return [pesoMin, pesoMax];
  }
}
