import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'views/calculator_view.dart'; // Путь к калькулятору
import 'viewmodels/calculator_viewmodel.dart'; 

void main() {
  runApp(
    
    ChangeNotifierProvider(
      create: (context) => CalculatorViewModel(),
      child: const CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculatorView(),
    );
  }
}
