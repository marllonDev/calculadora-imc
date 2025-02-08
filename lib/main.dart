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
  TextEditingController pesoController = TextEditingController(text: '');
  TextEditingController alturaController = TextEditingController(text: '');

  double? imc;
  String? classificacao;
  Color? corResultado;
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
                        color: Colors.green,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          imc!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 42, color: Colors.green),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Peso normal',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Seu Peso'),
                    SizedBox(height: 6),
                    Container(
                      width: 80,
                      child: TextField(
                        controller: pesoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixText: 'kg',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text('Sua Altura'),
                    SizedBox(height: 6),
                    Container(
                      width: 80,
                      child: TextField(
                        controller: alturaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixText: 'm',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  double peso = double.parse(pesoController.text);
                  double altura = double.parse(alturaController.text);
                  setState(() {
                    imc = peso / (altura * altura);
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                ),
                child: Text(
                  'Calcular',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
