import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Go to Calculator"),
          onPressed: () {
            Navigator.pushNamed(context, '/calculator');
          },
        ),
      ),
    );
  }
}
