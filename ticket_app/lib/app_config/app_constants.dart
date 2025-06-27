// lib/app_config/app_constants.dart

import 'package:flutter/material.dart';

// Define common padding, font sizes, etc.
class AppConstants {
  static const double buttonPadding = 16.0;
  static const double displayFontSizeLarge = 72.0;
  static const double displayFontSizeSmall = 48.0;
  static const double buttonTextSize = 32.0;
}

// Define specific colors not directly from ThemeData (e.g., operator colors)
class AppColors {
  // Light Mode Specific
  static const Color lightOperatorColor = Colors.orange;
  static const Color lightACDELColor = Color(0xFFC7C7C7); // Light gray
  static const Color lightNumberColor = Color(0xFFEFEFEF); // Lighter gray

  // Dark Mode Specific
  static const Color darkOperatorColor = Color(0xFFF1A33C); // Orange
  static const Color darkACDELColor = Color(0xFF6C6C6C); // Darker gray
  static const Color darkNumberColor = Color(0xFF333333); // Dark gray
}