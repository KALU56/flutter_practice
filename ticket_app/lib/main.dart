import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _themeMode == ThemeMode.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;

    return AnimatedTheme(
      data: themeData,
      duration: const Duration(milliseconds: 300),
      child: MaterialApp(
        title: 'Flutter Calculator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: CalculatorScreen(
          toggleTheme: toggleTheme,
          isDarkMode: _themeMode == ThemeMode.dark,
        ),
      ),
    );
  }
}
