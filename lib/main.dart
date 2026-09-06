import 'package:flutter/material.dart';
import 'screens/bmi_calculator_screen.dart';

/// Main entry point of the BMI Calculator application
void main() {
  runApp(const BmiCalculatorApp());
}

/// Root widget of the application
class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BmiCalculatorScreen(),
    );
  }
}
