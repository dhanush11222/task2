import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';  // Import the math_expressions package

class CalculatorController extends GetxController {
  var display = ''.obs;

  void clear() {
    display.value = '';
  }

  void append(String value) {
    // If the current display is '0' and the new value is a number, replace the '0' with the new value
    if (display.value == '0' && value != '.' && value != '%') {
      display.value = value;  // Replace the '0' with the new number
    } else {
      display.value += value;  // Otherwise, just append the value
    }
  }


  void calculate() {
    String userInput = display.value;

    // Replacing '%' with '/100' to handle percentage calculations
    userInput = userInput.replaceAll('%', '/100');

    Parser p = Parser();
    try {
      Expression exp = p.parse(userInput);  // Parse the input
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);  // Evaluate the expression

      // Check if the result is a whole number
      if (result == result.toInt()) {
        display.value = result.toInt().toString(); // Show integer if no decimal part
      } else {
        display.value = result.toString(); // Otherwise, show the decimal result
      }
    } catch (e) {
      display.value = 'Error';  // In case of any error, display an error message
    }
  }

  void delete() {
    if (display.value.isNotEmpty) {
      display.value = display.value.substring(0, display.value.length - 1);
    }
  }
}
