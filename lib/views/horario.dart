import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Horario extends StatefulWidget {
  final int medicoId;
  const Horario({super.key, required this.medicoId});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  Future<List<dynamic>> fetchHorarios() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8080/api/horarios?medicoId=${widget.medicoId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar horarios');
    }
  }

  Future<void> guardarFicha(int horarioId) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/fichas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'medicoId': widget.medicoId, 'horarioId': horarioId}),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ficha guardada exitosamente')));
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar ficha')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Horarios"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetchHorarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final horarios = snapshot.data!;
              return ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Horario: ${horarios[index]['hora']}'),
                    onTap: () {
                      guardarFicha(horarios[index]['id']);
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
