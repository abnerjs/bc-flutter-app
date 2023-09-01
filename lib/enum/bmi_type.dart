enum BMIType {
  magrezaGrave('Magreza grave'), // < 16
  magrezaModerada('Magreza moderada'), // < 17
  magrezaLeve('Magreza leve'), // < 18.5
  saudavel('Saudável'), // < 25
  sobrepeso('Sobrepeso'), // < 30
  obesidade1('Obesidade grau 1'), // < 35
  obesidade2('Obesidade grau 2'), // < 40
  obesidade3('Obesidade grau 3'); // >= 40

  const BMIType(this.value);

  final String value;
}
