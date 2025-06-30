// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyJournalApp());
}

class MyJournalApp extends StatelessWidget {
  const MyJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}