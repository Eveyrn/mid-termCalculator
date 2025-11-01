import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();
  double result = 0;

  void calculate(String operation) {
    double n1 = double.tryParse(num1.text) ?? 0;
    double n2 = double.tryParse(num2.text) ?? 0;

    setState(() {
      if (operation == '+') result = n1 + n2;
      if (operation == '-') result = n1 - n2;
      if (operation == '×') result = n1 * n2;
      if (operation == '÷') {
        if (n2 != 0) {
          result = n1 / n2;
        } else {
          result = double.nan;
        }
      }
    });
  }

  void clearAll() {
    num1.clear();
    num2.clear();
    setState(() {
      result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Калькулятор'),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Экран результата
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[700]!),
                    ),
                    child: Text(
                      'Результат: $result',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Поля ввода
                  TextField(
                    controller: num1,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Первое число',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: num2,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Второе число',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[850],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Кнопки операций
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _calcButton('+', Colors.orangeAccent),
                      _calcButton('-', Colors.orangeAccent),
                      _calcButton('×', Colors.orangeAccent),
                      _calcButton('÷', Colors.orangeAccent),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Кнопка очистки
                  ElevatedButton(
                    onPressed: clearAll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Очистить',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _calcButton(String symbol, Color color) {
    return ElevatedButton(
      onPressed: () => calculate(symbol),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        elevation: 6,
      ),
      child: Text(
        symbol,
        style: TextStyle(fontSize: 26, color: Colors.white),
      ),
    );
  }
}
