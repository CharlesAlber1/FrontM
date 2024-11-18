import 'package:clinica/views/login.dart';
import 'package:clinica/views/perfil.dart';
import 'package:clinica/views/sacar_ficha.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routename = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Bienvenido"),
          leading: PopupMenuButton<String>(
            icon: const Icon(Icons.menu), // Icono de tres rayas
            onSelected: (String opcion) {
              // Acción para cada opción seleccionada
              if (opcion == 'Sacar Ficha') {
                // Realiza la acción para "Sacar Ficha"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sacar_Ficha()),
                );
              } else if (opcion == 'Perfil') {
                // Realiza la acción para "Perfil"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'Sacar Ficha',
                child: Text('Sacar Ficha'),
              ),
              const PopupMenuItem(
                value: 'Perfil',
                child: Text('Perfil'),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.popAndPushNamed(context, Login.routename);
                },
                icon: Icon(Icons.logout))
          ],
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Selecciona una opción en el menú'),
        ),
      ),
    );
  }
}
