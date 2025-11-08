import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('Calculator test', (WidgetTester tester) async {
    // Строим приложение и запускаем его.
    await tester.pumpWidget(CalculatorApp() as Widget);

    // Проверяем, что на экране изначально отображается 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Нажимаем кнопку '1'.
    await tester.tap(find.text('1'));
    await tester.pump();

    // Проверяем, что на экране теперь отображается '1'.
    expect(find.text('1'), findsOneWidget);

    // Нажимаем кнопку '+'.
    await tester.tap(find.text('+'));
    await tester.pump();

    // Проверяем, что знак '+' отображается.
    expect(find.text('+'), findsOneWidget);
    
    // Нажимаем кнопку '2'.
    await tester.tap(find.text('2'));
    await tester.pump();

    // Проверяем, что на экране отображается '2'.
    expect(find.text('2'), findsOneWidget);

    // Нажимаем кнопку '=' для получения результата.
    await tester.tap(find.text('='));
    await tester.pump();

    // Проверяем, что результат вычисления отображается.
    expect(find.text('3'), findsOneWidget);
  });
}

class CalculatorApp {
}

