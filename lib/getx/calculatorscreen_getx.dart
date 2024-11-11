
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model_getx.dart';

class CalculatorscreenGetx extends StatelessWidget {
  final CalculatorController calculatorController = Get.put(CalculatorController());

  // Button data list
  final List<List<dynamic>> buttonData = [
    ['C', Colors.grey[200]!],
    ['%', Colors.grey[200]!],
    ['⌫', Colors.grey[200]!],
    ['/', Colors.orange],
    ['7', Colors.grey[200]!],
    ['8', Colors.grey[200]!],
    ['9', Colors.grey[200]!],
    ['*', Colors.orange],
    ['4', Colors.grey[200]!],
    ['5', Colors.grey[200]!],
    ['6', Colors.grey[200]!],
    ['-', Colors.orange],
    ['1', Colors.grey[200]!],
    ['2', Colors.grey[200]!],
    ['3', Colors.grey[200]!],
    ['+', Colors.orange],
    ['.', Colors.grey[200]!],
    ['0', Colors.grey[200]!],
    ['00', Colors.grey[200]!],
    ['=', Colors.blue],
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Display Container
            Container(
              padding: EdgeInsets.all(screenHeight * 0.02), // 2% of screen height
              alignment: Alignment.centerRight,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.rocket_launch_rounded, color: Colors.red),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    "RadicalStart",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.025), // 2.5% of screen height
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1, // Keep buttons circular
                ),
                itemCount: buttonData.length, // Use the length of the buttonData list
                itemBuilder: (context, index) {
                  return buildButton(
                    buttonData[index][0] as String,
                    buttonData[index][1] as Color,
                    screenWidth,
                    screenHeight,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(screenHeight * 0.02), // 2% of screen height
              alignment: Alignment.centerRight,
              color: Colors.grey[200],
              child: Obx(() => Text(
                calculatorController.display.value,
                style: TextStyle(
                    fontSize: screenHeight * 0.06,
                    fontWeight: FontWeight.bold), // 6% of screen height
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText, Color color, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01), // 1% of screen height
      child: Container(
        // Use Flexible to avoid static width and height
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.2, // 20% of screen width for max width
          maxHeight: screenWidth * 0.2, // 20% of screen width for max height (to keep buttons square)
        ),
        child: ElevatedButton(
          onPressed: () => handleButtonPress(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: CircleBorder(), // Keep circular shape
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: screenHeight * 0.03, color: Colors.black), // 3% of screen height
          ),
        ),
      ),
    );
  }

  void handleButtonPress(String button) {
    switch (button) {
      case 'C':
        calculatorController.clear();
        break;
      case '⌫':
        calculatorController.delete();
        break;
      case '=':
        calculatorController.calculate();
        break;
      case '%':
        calculatorController.append('%');
        break;
      default:
        calculatorController.append(button);
        break;
    }
  }
}
