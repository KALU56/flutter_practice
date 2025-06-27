// lib/models/calculator.dart

class Calculator {
  String _output = '0';
  String _input = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _operandPressed = false;
  bool _decimalPressed = false;

  String get output => _output;
  String get input => _input;

  void buttonPressed(String buttonText) {
    if (buttonText == 'AC') {
      _output = '0';
      _input = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _operandPressed = false;
      _decimalPressed = false;
    } else if (buttonText == 'DEL') {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
        if (_input.isEmpty) {
          _input = '0';
        }
        _output = _input;
        _decimalPressed = _input.contains('.'); // Reset decimal flag
      }
    } else if (buttonText == '.' && !_decimalPressed) {
      if (_input.isEmpty || _input == '0') {
        _input = '0.';
      } else {
        _input = _input + buttonText;
      }
      _decimalPressed = true;
      _output = _input;
    } else if (buttonText == '+/-') {
      if (_input.isNotEmpty && _input != '0') {
        if (_input.startsWith('-')) {
          _input = _input.substring(1);
        } else {
          _input = '-$_input';
        }
        _output = _input;
      }
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '×' ||
        buttonText == '÷' ||
        buttonText == '%') {
      if (_input.isEmpty && _operator.isEmpty) return; // No number to operate on

      if (!_operandPressed && _input.isNotEmpty) {
        _num1 = double.parse(_input);
        _operator = buttonText;
        _operandPressed = true;
        _input = ''; // Clear input for next number
        _decimalPressed = false; // Reset decimal for next number
      } else if (_operandPressed && _input.isEmpty) {
        _operator = buttonText; // Allow changing operator if no second number entered yet
      } else if (_operandPressed && _input.isNotEmpty) {
        // If an operator was already pressed and a second number is entered, calculate first
        _num2 = double.parse(_input);
        _calculate();
        _num1 = double.parse(_output); // Result becomes num1 for next operation
        _operator = buttonText;
        _input = ''; // Clear input for next number
        _decimalPressed = false;
      }
    } else if (buttonText == '=') {
      if (_operandPressed && _input.isNotEmpty) {
        _num2 = double.parse(_input);
        _calculate();
        _input = _output; // Set output as input for chaining operations
        _num1 = 0;
        _num2 = 0;
        _operator = '';
        _operandPressed = false;
        _decimalPressed = _output.contains('.'); // Keep decimal flag for chained result
      }
    } else {
      // Numbers
      if (_input == '0' && buttonText != '.') {
        _input = buttonText;
      } else if (buttonText == '.' && _input.isEmpty) {
        _input = '0.';
        _decimalPressed = true;
      } else if (_input.length < 15) { // Limit input length
        _input += buttonText;
      }
      _output = _input;
    }

    // Handle output formatting (remove trailing .0)
    if (_output.endsWith('.0')) {
      _output = _output.substring(0, _output.length - 2);
    }
  }

  void _calculate() {
    double result = 0;
    try {
      switch (_operator) {
        case '+':
          result = _num1 + _num2;
          break;
        case '-':
          result = _num1 - _num2;
          break;
        case '×':
          result = _num1 * _num2;
          break;
        case '÷':
          if (_num2 != 0) {
            result = _num1 / _num2;
          } else {
            _output = 'Error'; // Division by zero
            return;
          }
          break;
        case '%':
          result = _num1 % _num2; // Simple modulo for now
          // For percentage of a number (e.g., 50% of 200), logic would be different
          // (e.g., result = _num1 * (_num2 / 100);)
          break;
        default:
          break;
      }
      _output = result.toStringAsFixed(10); // Use enough precision
      // Remove trailing zeros and decimal if it's a whole number
      if (_output.contains('.')) {
        _output = _output.replaceAll(RegExp(r'0*$'), ''); // Remove trailing zeros
        if (_output.endsWith('.')) {
          _output = _output.substring(0, _output.length - 1); // Remove trailing decimal if it ends with .
        }
      }
    } catch (e) {
      _output = 'Error';
    }
  }
}