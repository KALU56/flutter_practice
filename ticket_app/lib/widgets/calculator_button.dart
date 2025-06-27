// lib/widgets/calculator_button.dart

import 'package:flutter/material.dart';
import '../app_config/app_constants.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int flex;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.text,
    this.flex = 1,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.buttonPadding / 2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // Circular buttons
            ),
            padding: const EdgeInsets.all(AppConstants.buttonPadding),
            minimumSize: const Size(0, 70), // Ensure minimum height
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppConstants.buttonTextSize,
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}