import 'dart:convert';
import 'package:clinica/views/home.dart';
import 'package:clinica/views/medico.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sacar_Ficha extends StatefulWidget {
  const Sacar_Ficha({super.key});
  static const String routename = '/sacar_ficha';

  @override
  _Sacar_FichaState createState() => _Sacar_FichaState();
}

class _Sacar_FichaState extends State<Sacar_Ficha> {
  Future<List<dynamic>> fetchEspecialidades() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/api/especialidad/listar'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar especialidades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Especialidades"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, Home.routename);
                },
                icon: const Icon(Icons.logout)),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchEspecialidades(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final especialidades = snapshot.data!;
              return ListView.builder(
                itemCount: especialidades.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(especialidades[index]['nombre']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Medico(
                              especialidadId: especialidades[index]['id']),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
