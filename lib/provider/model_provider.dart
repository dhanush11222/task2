import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorModel extends ChangeNotifier {
  String _display = '';

  String get display => _display;

  void append(String value) {
    // If the current display is '0' and the new value is a number, replace the '0' with the new value
    if (_display == '0' && value != '.' && value != '%') {
      _display = value; // Replace the '0' with the new number
    } else {
      _display += value; // Otherwise, append the value
    }
    notifyListeners();
  }

  void clear() {
    _display = '';
    notifyListeners();
  }

  void delete() {
    if (_display.isNotEmpty) {
      _display = _display.substring(0, _display.length - 1);
      notifyListeners();
    }
  }

  void calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_display.replaceAll('%', '/100'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Check if the result is a whole number
      if (eval == eval.toInt()) {
        _display = eval.toInt().toString(); // Show integer if no decimal part
      } else {
        _display = eval.toString(); // Otherwise, show the decimal result
      }
    } catch (e) {
      _display = 'Error';
    }
    notifyListeners();
  }
}
