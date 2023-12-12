import 'package:flutter/material.dart';
import 'package:nuframework/pagina_dinamica.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nu Framework Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 23, 77, 255),
        ),
        useMaterial3: true,
      ),
      home: const PaginaDinamica(),
    );
  }
}
