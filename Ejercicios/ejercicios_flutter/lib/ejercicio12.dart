import 'package:flutter/material.dart';
import 'dart:math';

class GuessNumberScreen extends StatefulWidget {
  const GuessNumberScreen({Key? key}) : super(key: key);

  @override
  GuessNumberScreenState createState() => GuessNumberScreenState();
}

class GuessNumberScreenState extends State<GuessNumberScreen> {
  final _random = Random();
  late int targetNumber;
  final TextEditingController _numberController = TextEditingController();
  String _message = '';
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    generateTargetNumber();
  }

  void generateTargetNumber() {
    targetNumber = _random.nextInt(100) + 1;
    _isCorrect = false;
    setState(() {
      _message = '';
    });
  }

  void checkGuess() {
    if (_isCorrect) {
      return;
    }

    int guessedNumber = int.tryParse(_numberController.text) ?? 0;

    if (guessedNumber > targetNumber) {
      setState(() {
        _message = 'El número es menor. ¡Intenta de nuevo!';
      });
    } else if (guessedNumber < targetNumber) {
      setState(() {
        _message = 'El número es mayor. ¡Intenta de nuevo!';
      });
    } else {
      setState(() {
        _message = '¡Correcto! Has adivinado el número.';
        _isCorrect = true;
      });

      // Animación de éxito
      Future.delayed(const Duration(seconds: 2), () {
        generateTargetNumber();
      });
    }
  }

  void resetGame() {
    _numberController.clear();
    generateTargetNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess Number Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Adivina el número entre 1 y 100:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkGuess,
              child: const Text('Comprobar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: const Text('Reiniciar Juego'),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(
                fontSize: 16,
                color: _isCorrect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
