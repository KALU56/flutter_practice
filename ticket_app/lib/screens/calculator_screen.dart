import 'package:flutter/material.dart';
import '../app_config/app_constants.dart';
import '../models/calculator.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display_panel.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const CalculatorScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Calculator _calculator = Calculator();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.isDarkMode;

    // Use Theme.of(context).iconTheme.color for consistency with defined themes
    final Color iconColor = Theme.of(context).iconTheme.color ?? (isDarkMode ? Colors.white : Colors.black);

    // Color for the 'active' indicator in the theme switcher
    final Color activeSwitchColor = isDarkMode ? Colors.white : Colors.black;
    final Color inactiveSwitchColor = isDarkMode ? Colors.white38 : Colors.black38;


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Theme Icons (Sun and Moon) aligned to the right, in a combined tappable area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector( // Use GestureDetector to make the whole area tappable
                  onTap: widget.toggleTheme, // Toggles theme on tap anywhere in this row
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Keep the row size to its children
                    children: [
                      // Sun Icon for Light Mode
                      Icon(
                        Icons.brightness_7, // Sun icon
                        size: 30,
                        // Color changes based on whether light mode is currently active
                        color: isDarkMode ? inactiveSwitchColor : activeSwitchColor,
                      ),
                      const SizedBox(width: 8), // Small space between icons

                      // Moon Icon for Dark Mode
                      Icon(
                        Icons.brightness_4, // Moon icon
                        size: 30,
                        // Color changes based on whether dark mode is currently active
                        color: isDarkMode ? activeSwitchColor : inactiveSwitchColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Display Panel
            Expanded(
              flex: 2,
              child: DisplayPanel(
                output: _calculator.output,
                input: _calculator.input,
              ),
            ),

            // Buttons Grid
            Expanded(
              flex: 5,
              child: Column(
                children: _buildButtonRows(isDarkMode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtonRows(bool isDarkMode) {
    return [
      _buildButtonRow(['AC', 'DEL', '%', '÷'], isDarkMode),
      _buildButtonRow(['7', '8', '9', '×'], isDarkMode),
      _buildButtonRow(['4', '5', '6', '-'], isDarkMode),
      _buildButtonRow(['1', '2', '3', '+'], isDarkMode),
      _buildButtonRow(['+/-', '0', '.', '='], isDarkMode),
    ];
  }

  Widget _buildButtonRow(List<String> texts, bool isDarkMode) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: texts.map((text) {
          Color buttonColor;
          Color textColor;

          if (text == 'AC' || text == 'DEL') {
            buttonColor = isDarkMode
                ? AppColors.darkACDELColor
                : AppColors.lightACDELColor;
            textColor = isDarkMode ? Colors.white : Colors.black;
          } else if (['+', '-', '×', '÷', '%', '='].contains(text)) {
            buttonColor = isDarkMode
                ? AppColors.darkOperatorColor
                : AppColors.lightOperatorColor;
            textColor = Colors.white;
          } else {
            buttonColor = isDarkMode
                ? AppColors.darkNumberColor
                : AppColors.lightNumberColor;
            textColor = isDarkMode ? Colors.white : Colors.black;
          }

          int flex = (text == '0') ? 2 : 1;

          return CalculatorButton(
            text: text,
            flex: flex,
            buttonColor: buttonColor,
            textColor: textColor,
            onPressed: () {
              setState(() {
                _calculator.buttonPressed(text);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}