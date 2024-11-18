import 'package:flutter/material.dart';
class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Pefil"),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.popAndPushNamed(context, Home.routename);
                },
                icon: Icon(Icons.logout))
          ],
          centerTitle: true,
        ),
        body: Container(),
      ),
    );
  }
}