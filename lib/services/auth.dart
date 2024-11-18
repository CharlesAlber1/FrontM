import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080/login";

  Future<int> login(String username, String password) async {
    final url = Uri.parse(baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'username': username, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return 0; // Login exitoso
      } else if (response.statusCode == 401) {
        return 1; // Credenciales incorrectas
      } else {
        return 2; // Otros errores del servidor
      }
    } on Exception catch (e) {
      print('Exception: $e'); // Registro del error para depuración
      throw 'Error de conexión: no se pudo conectar al servidor.';
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}