import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String display = '';        // Показывает результат
  String expression = '';     // Показывает всё выражение
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  bool justCalculated = false;

  void pressButton(String value) {
    setState(() {
      // Очистка
      if (value == 'AC') {
        display = '';
        expression = '';
        num1 = 0;
        num2 = 0;
        operation = '';
        return;
      }

      // Если нажали число или точку
      if (RegExp(r'^[0-9.]$').hasMatch(value)) {
        if (justCalculated) {
          // Если до этого был результат, начинаем заново
          display = '';
          expression = '';
          justCalculated = false;
        }
        display += value;
        expression += value;
        return;
      }

      // Если нажали операцию
      if (['+', '-', '×', '÷'].contains(value)) {
        if (display.isEmpty && expression.isEmpty) return;

        // Если только что посчитали — продолжаем с результатом
        if (justCalculated) {
          expression = display;
          justCalculated = false;
        }

        num1 = double.tryParse(display) ?? 0;
        operation = value;
        display = '';
        expression += ' $value ';
        return;
      }

      // Вычисление
      if (value == '=') {
        num2 = double.tryParse(display) ?? 0;
        double result = 0;

        if (operation == '+') result = num1 + num2;
        if (operation == '-') result = num1 - num2;
        if (operation == '×') result = num1 * num2;
        if (operation == '÷') {
          result = (num2 == 0) ? double.nan : num1 / num2;
        }

        display = result.isNaN ? 'Ошибка' : result.toString();
        expression += ' = $display';
        justCalculated = true;
        operation = '';
      }
    });
  }

  Widget buildButton(String text, {Color? color, double fontSize = 26}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => pressButton(text),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  expression,
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
                  display.isEmpty ? '0' : display,
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
                      buildButton('AC', color: Colors.grey[700]),
                      buildButton('÷', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('×', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('-', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('+', color: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0'),
                      buildButton('.', fontSize: 30),
                      buildButton('=', color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
