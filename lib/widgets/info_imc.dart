import 'package:flutter/material.dart';

class InfoImc extends StatelessWidget {

  const InfoImc({
      super.key,
      required this.imc,
      required this.classificacao,
      required this.corResultado
      });

  final double imc;
  final String classificacao;
  final Color corResultado;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        border: Border.all(
          width: 10,
          color: corResultado,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            imc.toStringAsFixed(2),
            style: TextStyle(fontSize: 42, color: corResultado),
          ),
          SizedBox(height: 12),
          Text(
            classificacao,
            style: TextStyle(fontSize: 20, color: corResultado),
          ),
        ],
      ),
    );
  }
}
