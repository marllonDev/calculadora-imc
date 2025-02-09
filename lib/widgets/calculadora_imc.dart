import 'package:calculadora_imc/widgets/alerta_menssagem.dart';
import 'package:calculadora_imc/widgets/botao_calcular.dart';
import 'package:calculadora_imc/widgets/info_imc.dart';
import 'package:flutter/material.dart';

class MinhaCalculadoraDeImc extends StatefulWidget {
  const MinhaCalculadoraDeImc({super.key});

  @override
  State<MinhaCalculadoraDeImc> createState() => _MinhaCalculadoraDeImcState();
}

class _MinhaCalculadoraDeImcState extends State<MinhaCalculadoraDeImc> {
  late TextEditingController pesoController;
  late TextEditingController alturaController;

  double valorPeso = 50;
  double valorAltura = 1.4;
  double? imc;
  String? classificacao;
  Color? corResultado;

  @override
  void initState() {
    pesoController = TextEditingController(text: valorPeso.toString());
    alturaController = TextEditingController(text: valorAltura.toString());
    super.initState();
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == null
                ? AlertaMenssagem()
                : InfoImc(
                    classificacao: classificacao!,
                    corResultado: corResultado!,
                    imc: imc!,
                  ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Seu Peso',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          enabled: false,
                          controller: pesoController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixText: 'kg',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTickMarkColor: Colors.purple,
                            trackHeight: 5,
                          ),
                          child: Slider(
                            activeColor: Colors.purple,
                            value: valorPeso,
                            onChanged: (peso) {
                              setState(() {
                                valorPeso = peso;
                                pesoController.text =
                                    valorPeso.toStringAsFixed(2);
                              });
                            },
                            min: 50,
                            max: 200,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sua Altura',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          enabled: false,
                          controller: alturaController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixText: 'm',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: SliderTheme(
                          data: SliderThemeData(
                            activeTickMarkColor: Colors.purple,
                            trackHeight: 5,
                          ),
                          child: Slider(
                            activeColor: Colors.purple,
                            value: valorAltura,
                            onChanged: (altura) {
                              setState(() {
                                valorAltura = altura;
                                alturaController.text =
                                    valorAltura.toStringAsFixed(2);
                              });
                            },
                            min: 0.5,
                            max: 2.5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BotaoCalcular(
              onPressed: () {
                double peso = double.parse(pesoController.text);
                double altura = double.parse(alturaController.text);
                setState(
                  () {
                    imc = peso / (altura * altura);
                    classificacao = getClassificacaoIMC(imc!);
                    corResultado = getCorIMC(imc!);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getClassificacaoIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc < 24.9) {
      return 'Peso normal';
    } else if (imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc < 34.9) {
      return 'Obesidade grau 1';
    } else if (imc < 39.9) {
      return 'Obesidade grau 2';
    } else if (imc >= 40) {
      return 'Obesidade grau 3';
    } else {
      return 'Erro';
    }
  }

  Color getCorIMC(double imc) {
    if (imc < 18.5) {
      return Colors.yellow;
    } else if (imc < 24.9) {
      return Colors.green;
    } else if (imc < 29.9) {
      return Colors.orange;
    } else if (imc < 34.9) {
      return Colors.red;
    } else if (imc < 39.9) {
      return Colors.red[900]!;
    } else if (imc >= 40) {
      return Colors.red[900]!;
    } else {
      return Colors.black;
    }
  }
}
