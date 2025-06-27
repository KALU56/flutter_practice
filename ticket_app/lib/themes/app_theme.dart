// lib/themes/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal, // Example primary color
    scaffoldBackgroundColor: const Color(0xFFF0F0F0), // Light background
    cardColor: const Color(0xFFFFFFFF), // For button backgrounds that aren't specific
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.w300), // For calculator output
      displayMedium: TextStyle(color: Colors.black, fontSize: 30), // For calculator input/smaller text
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
      // Define other text styles as needed
    ),
    iconTheme: const IconThemeData(color: Colors.black87), // Icon colors
    // Define other component themes like buttonTheme, elevatedButtonTheme, etc.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // Text color for default ElevatedButton
        backgroundColor: Colors.grey[200], // Background for default ElevatedButton
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal[800], // Example primary color for dark mode
    scaffoldBackgroundColor: Colors.black, // Dark background
    cardColor: const Color(0xFF222222), // Darker background for button cards
    appBarTheme: AppBarTheme(
      color: Colors.teal[800],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300), // For calculator output
      displayMedium: TextStyle(color: Colors.white70, fontSize: 30), // For calculator input/smaller text
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      // Define other text styles as needed
    ),
    iconTheme: const IconThemeData(color: Colors.white), // Icon colors
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Text color for default ElevatedButton
        backgroundColor: Colors.grey[800], // Background for default ElevatedButton
      ),
    ),
  );
}