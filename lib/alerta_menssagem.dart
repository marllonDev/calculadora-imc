import 'package:flutter/material.dart';

class AlertaMenssagem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text(
      'Adicione seu peso e sua altura \npara calcular seu IMC',
      style: TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
