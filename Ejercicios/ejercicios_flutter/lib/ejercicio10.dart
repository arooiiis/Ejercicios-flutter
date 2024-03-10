import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Ejercicio10 extends StatelessWidget {
  const Ejercicio10({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Ejercicio 10',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: RandomColors(),
      ),
    );
  }
}

class RandomColors extends StatefulWidget {
  const RandomColors({Key? key});

  @override
  _RandomColors createState() => _RandomColors();
}

class _RandomColors extends State<RandomColors>
    with SingleTickerProviderStateMixin {
  int points = 0;
  late String randomName;
  late Color randomColor;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool canTap = true;

  var colorNames = [
    'blue',
    'green',
    'orange',
    'pink',
    'red',
    'yellow',
    'cyan'
  ];
  var colorHex = [
    const Color(0xFF0000FF),
    const Color(0xFF00FF00),
    const Color(0xFFFF914D),
    const Color(0xFFFF66C4),
    const Color(0xFFFF0000),
    const Color(0xFFFFFF00),
    const Color(0xFF00FFFF)
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _scaleAnimation.addListener(() {
      // No es necesario llamar a setState aquí
    });

    getRandomColor();
    getRandomName();
    timer();
  }

  void timer() async {
    while (points < 30) {
      await Future.delayed(getDelayDuration());
      getRandomColor();
      getRandomName();
      canTap = true;
      setState(() {});
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Enhorabuena!'),
          content: const Text(
              'Has conseguido 30 puntos. ¿Quieres volver a jugar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                points = 0;
                getRandomColor();
                getRandomName();
                setState(() {});
                Navigator.of(context).pop();
                timer();
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  Duration getDelayDuration() {
    if (points < 10) {
      return const Duration(seconds: 2);
    } else if (points < 15) {
      return const Duration(milliseconds: 1750);
    } else if (points < 20) {
      return const Duration(milliseconds: 1500);
    } else if (points < 25) {
      return const Duration(milliseconds: 1250);
    } else {
      return const Duration(milliseconds: 1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Puntos: $points',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onGiftTap(randomName, randomColor);
                },
                child: Column(
                  children: [
                    Container(
                      width: 120 * _scaleAnimation.value,
                      height: 120 * _scaleAnimation.value,
                      color: randomColor,
                    ),
                    Text(
                      randomName,
                      style: TextStyle(
                        color: randomColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getRandomColor() {
    final Random random = Random();
    final int randomNumber = random.nextInt(7);
    randomColor = colorHex[randomNumber];
  }

  void getRandomName() {
    final Random random = Random();
    final int randomNumber = random.nextInt(7);
    randomName = colorNames[randomNumber];
  }

  String hexToStringConverter(Color hexColor) {
    if (hexColor == const Color(0xFF0000FF)) {
      return 'azul';
    } else if (hexColor == const Color(0xFF00FF00)) {
      return 'verde';
    } else if (hexColor == const Color(0xFFFF914D)) {
      return 'naranja';
    } else if (hexColor == const Color(0xFFFF66C4)) {
      return 'rosa';
    } else if (hexColor == const Color(0xFFFF0000)) {
      return 'rojo';
    } else if (hexColor == const Color(0xFFFFFF00)) {
      return 'amarillo';
    } else {
      return 'cian';
    }
  }

  void onGiftTap(String name, Color color) {
    if (canTap) {
      final String colorToString = hexToStringConverter(color);
      if (name == colorToString) {
        points++;
        canTap = false;
        _animationController.forward().then((value) {
          _animationController.reverse();
        });
      } else {
        points--;
        canTap = false;
      }
      setState(() {});
    }
  }

 @override
void dispose() {
  _animationController.dispose();
  super.dispose();
}

}
