import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String nombre = "";
  String usuario = "";
  String contrasena = "";
  int edad = 0;

  TextEditingController nombreController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController edadController = TextEditingController();

  Future<void> guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('detalles', [nombre, usuario, contrasena, edad.toString()]);
  }

  Future<void> recuperarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    final detalles = prefs.getStringList("detalles");
    if (detalles != null) {
      setState(() {
        nombre = detalles[0];
        nombreController.text = nombre;
        usuario = detalles[1];
        usuarioController.text = usuario;
        contrasena = detalles[2];
        contrasenaController.text = contrasena;
        edad = int.tryParse(detalles[3] ?? "") ?? 0;
        edadController.text = edad.toString();
      });
    }
  }

  void mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          TextField(
            controller: nombreController,
            autofocus: true,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: "Nombre",
              labelStyle: TextStyle(color: Colors.grey),
              helperText: "Andrea Navas",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 156, 93, 215)),
              ),
              hintText: "Nombre completo",
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 225, 208, 182),
              ),
            ),
            onChanged: (input) {
              nombre = input;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: usuarioController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Correo electrónico",
              labelStyle: TextStyle(color: Colors.grey),
              helperText: "ejemplo@ejemplo.com",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 156, 93, 215)),
              ),
              hintText: "Correo",
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromARGB(255, 225, 208, 182),
              ),
            ),
            onChanged: (input) {
              usuario = input;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: contrasenaController,
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Contraseña",
              labelStyle: TextStyle(color: Colors.grey),
              helperText: "******",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 156, 93, 215)),
              ),
              hintText: "Contraseña",
              prefixIcon: Icon(
                Icons.password,
                color: Color.fromARGB(255, 225, 208, 182),
              ),
            ),
            onChanged: (input) {
              contrasena = input;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: edadController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Edad",
              labelStyle: TextStyle(color: Colors.grey),
              helperText: "25",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 156, 93, 215)),
              ),
              hintText: "Edad",
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Color.fromARGB(255, 225, 208, 182),
              ),
            ),
            onChanged: (input) {
              if (input.isNotEmpty) {
                int? parsedEdad = int.tryParse(input);
                if (parsedEdad != null) {
                  edad = parsedEdad;
                } else {
                  mostrarError("La edad debe ser un número.");
                }
              } else {
                edad = 0;
              }
            },
          ),
          ElevatedButton(
            child: const Text("Guardar datos"),
            onPressed: () async {
              await guardarDatos();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            child: const Text("Recuperar datos"),
            onPressed: () async {
              await recuperarDatos();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            child: const Text("Imprimir Datos"),
            onPressed: () {
              print("Nombre: $nombre");
              print("Usuario: $usuario");
              print("Contraseña: $contrasena");
              print("Edad: $edad");
            },
          ),
        ],
      ),
    );
  }
}
