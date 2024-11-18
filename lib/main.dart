import 'package:clinica/views/home.dart';
import 'package:clinica/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      routes: {
        Login.routename: (context) => const Login(),
        Home.routename: (context) => const Home(),

      },
    );
  }
}
