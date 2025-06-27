import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/calculator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Screen App',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/calculator': (context) => const CalculatorPage(),
      },
    );
  }
}
