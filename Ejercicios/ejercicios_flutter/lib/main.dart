import 'package:ejercicios_flutter/ejercicio10.dart';
import 'package:ejercicios_flutter/ejercicio11.dart';
import 'package:ejercicios_flutter/ejercicio12.dart';
import 'package:ejercicios_flutter/ejercicio9.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios del 6 al 10'),
      ),
      body: const Center(
        child: Text('Relación de ejercicios'),
      ),
      drawer: const DrawerWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/imagen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'AROA',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 50,
              ),
            ),
          ),
          ListTile(
            title: const Text('Ejercicio 9'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Botones()),
              );
            },
          ),
          ListTile(
            title: const Text('Ejercicio 10'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Ejercicio10()),
              );
            },
          ),
          ListTile(
            title: const Text('Ejercicio 11'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyForm()),
              );
            },
          ),
          ListTile(
            title: const Text('Ejercicio 12'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GuessNumberScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
