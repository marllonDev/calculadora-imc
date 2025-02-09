import 'package:flutter/material.dart';

class BotaoCalcular extends StatelessWidget {
  const BotaoCalcular({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
        ),
        child: Text(
          'Calcular',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
