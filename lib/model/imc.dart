// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'imc.g.dart';

@HiveType(typeId: 1)
class IMC extends HiveObject {
  @HiveField(0)
  final String _id = UniqueKey().toString();
  @HiveField(1)
  DateTime dataCalculo;
  @HiveField(2)
  double _altura;
  @HiveField(3)
  double _peso;

  IMC(this.dataCalculo, this._altura, this._peso);

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
