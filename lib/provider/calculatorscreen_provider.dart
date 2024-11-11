
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model_provider.dart'; // Make sure to import your CalculatorModel

class CalculatorApp extends StatelessWidget {
  // Dynamic list of button data (text and color)
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Display Container with logo
            Container(
              padding: EdgeInsets.all(screenHeight * 0.02),
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
                        fontSize: screenHeight * 0.025),
                  ),
                ],
              ),
            ),

            // GridView for calculator buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemCount: buttonData.length,
                itemBuilder: (context, index) {
                  return buildButton(
                    context, // pass context
                    buttonData[index][0] as String,
                    buttonData[index][1] as Color,
                    screenWidth,
                    screenHeight,
                  );
                },
              ),
            ),

            // Display Result Container
            Container(
              padding: EdgeInsets.all(screenHeight * 0.02),
              alignment: Alignment.centerRight,
              color: Colors.grey[200],
              child: Consumer<CalculatorModel>(
                builder: (context, calculatorModel, child) {
                  return Text(
                    calculatorModel.display,
                    style: TextStyle(
                        fontSize: screenHeight * 0.06,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Button Widget
  Widget buildButton(BuildContext context, String buttonText, Color color,
      double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.2,
          maxHeight: screenWidth * 0.2,
        ),
        child: ElevatedButton(
          onPressed: () => handleButtonPress(buttonText, context),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: CircleBorder(),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: screenHeight * 0.03, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Handle button press based on the type of button
  void handleButtonPress(String button, BuildContext context) {
    final calculatorModel = Provider.of<CalculatorModel>(context, listen: false);

    switch (button) {
      case 'C':
        calculatorModel.clear();
        break;
      case '⌫':
        calculatorModel.delete();
        break;
      case '=':
        calculatorModel.calculate();
        break;
      case '%':
        calculatorModel.append('%');
        break;
      default:
        calculatorModel.append(button);
        break;
    }
  }
}
