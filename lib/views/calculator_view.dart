import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Импортируем provider
import '../viewmodels/calculator_viewmodel.dart'; // Путь к ViewModel

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  Widget buildButton(String text, CalculatorViewModel viewModel,
      {Color? color, double fontSize = 26}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => viewModel.pressButton(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CalculatorViewModel>(); // Теперь работает!

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Экран выражения
            Container(
              width: double.infinity,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                viewModel.expression,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 22,
                ),
              ),
            ),

            // Экран результата
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 24, bottom: 20),
              child: Text(
                viewModel.display.isEmpty ? '0' : viewModel.display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            const Divider(color: Colors.white24),

            // Кнопки
            Column(
              children: [
                Row(
                  children: [
                    buildButton('AC', viewModel, color: Colors.grey[700]),
                    buildButton('÷', viewModel, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('7', viewModel),
                    buildButton('8', viewModel),
                    buildButton('9', viewModel),
                    buildButton('×', viewModel, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4', viewModel),
                    buildButton('5', viewModel),
                    buildButton('6', viewModel),
                    buildButton('-', viewModel, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1', viewModel),
                    buildButton('2', viewModel),
                    buildButton('3', viewModel),
                    buildButton('+', viewModel, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('0', viewModel),
                    buildButton('.', viewModel, fontSize: 30),
                    buildButton('=', viewModel, color: Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
