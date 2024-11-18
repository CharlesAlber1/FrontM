import 'dart:convert';
import 'package:clinica/views/horario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medico extends StatefulWidget {
  final int especialidadId;
  const Medico({super.key, required this.especialidadId});

  @override
  State<Medico> createState() => _MedicoState();
}

class _MedicoState extends State<Medico> {
  Future<List<dynamic>> fetchMedicos() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/api/medicos?especialidadId=${widget.especialidadId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar médicos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Médicos"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchMedicos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final medicos = snapshot.data!;
              return ListView.builder(
                itemCount: medicos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medicos[index]['nombre']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Horario(medicoId: medicos[index]['id']),
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
