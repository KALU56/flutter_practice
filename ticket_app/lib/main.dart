import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controllers to read input from text fields
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  double result = 0; // Stores the result of addition

  void addNumbers() {
    double n1 = double.tryParse(num1Controller.text) ?? 0;
    double n2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      result = n1 + n2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Add Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              decoration: const InputDecoration(labelText: 'Enter first number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: num2Controller,
              decoration: const InputDecoration(labelText: 'Enter second number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addNumbers,
              child: const Text("Add"),
            ),
            const SizedBox(height: 20),
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
