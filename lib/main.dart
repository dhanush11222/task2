import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:task2/getx/calculatorscreen_getx.dart';
import 'package:task2/provider/calculatorscreen_provider.dart'; // Import the Calculator screen using Provider
import 'package:task2/imagepicker/image_picker.dart';
import 'package:task2/provider/model_provider.dart'; // Import ImagePicker screen
 // Import the CalculatorModel class

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the CalculatorModel to the app
        ChangeNotifierProvider(create: (_) => CalculatorModel()),
      ],
      child: MaterialApp(
        title: 'Rentall',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => BottomNavigation(), // Home screen
          '/getx': (context) => CalculatorscreenGetx(), // GetX state management screen
          '/provider': (context) => CalculatorApp(), // Provider-based Calculator screen
          '/imagepicker': (context) => ImagePickerDemo(), // Image Picker demo
        },
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of the mini apps (pages)
  final List<Widget> _pages = [
    CalculatorscreenGetx(),
    CalculatorApp(),
    ImagePickerDemo(),
  ];

  // Function to handle the navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show the selected mini app
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Current selected index
        onTap: _onItemTapped, // Handle tap
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'GetX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Provider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Upload',
          ),
        ],
      ),
    );
  }
}
