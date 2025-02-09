import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MinhaCalculadoraDeImc(),
    );
  }
}

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
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == null
                ? Text(
                    'Adicione seu peso e sua altura \npara calcular seu IMC',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                        width: 10,
                        color: corResultado!,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          imc!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 42, color: corResultado),
                        ),
                        SizedBox(height: 12),
                        Text(
                          classificacao!,
                          style: TextStyle(fontSize: 20, color: corResultado),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Seu Peso'),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          enabled: false,
                          controller: pesoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixText: 'kg',
                          ),
                        ),
                      ),
                      Slider(
                        activeColor: Colors.purple,
                        value: valorPeso,
                        onChanged: (peso) {
                          setState(() {
                            valorPeso = peso;
                            pesoController.text = valorPeso.toStringAsFixed(2);
                          });
                        },
                        min: 50,
                        max: 200,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      Text('Sua Altura'),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          enabled: false,
                          controller: alturaController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixText: 'm',
                          ),
                        ),
                      ),
                      Slider(
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
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (imc == null) {
                    try {
                      double peso = double.parse(pesoController.text);
                      double altura = double.parse(alturaController.text);
                      setState(
                        () {
                          imc = peso / (altura * altura);
                          classificacao = getClassificacaoIMC(imc!);
                          corResultado = getCorIMC(imc!);
                        },
                      );
                    } on Exception {
                      imc = null;
                      classificacao = null;
                      corResultado = null;
                      pesoController.text = '';
                      alturaController.text = '';
                    }
                  } else {
                    setState(() {
                      imc = null;
                      classificacao = null;
                      corResultado = null;
                      pesoController.text = '';
                      alturaController.text = '';
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                ),
                child: Text(
                  imc == null ? 'Calcular' : 'Limpar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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

  Color? getCorIMC(double imc) {
    if (imc < 18.5) {
      return Colors.yellow;
    } else if (imc < 24.9) {
      return Colors.green;
    } else if (imc < 29.9) {
      return Colors.orange;
    } else if (imc < 34.9) {
      return Colors.red;
    } else if (imc < 39.9) {
      return Colors.red[900];
    } else if (imc >= 40) {
      return Colors.red[900];
    } else {
      return Colors.black;
    }
  }
}
