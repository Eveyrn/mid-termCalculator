// lib/viewmodels/calculator_viewmodel.dart
import 'package:flutter/foundation.dart';
import '../models/calculator_model.dart';

class CalculatorViewModel extends ChangeNotifier {
  final CalculatorModel _model = CalculatorModel();
  String _display = '';
  String _expression = '';
  bool _justCalculated = false;

  String get display => _display;
  String get expression => _expression;

  void pressButton(String value) {
    if (value == 'AC') {
      _clear();
    } else if (RegExp(r'^[0-9.]$').hasMatch(value)) {
      _handleNumberOrDecimal(value);
    } else if (['+', '-', '×', '÷'].contains(value)) {
      _handleOperation(value);
    } else if (value == '=') {
      _calculateResult();
    }
    notifyListeners();
  }

  void _clear() {
    _display = '';
    _expression = '';
    _model.num1 = 0;
    _model.num2 = 0;
    _model.operation = '';
    _justCalculated = false;
  }

  void _handleNumberOrDecimal(String value) {
    if (_justCalculated) {
      _display = '';
      _expression = '';
      _justCalculated = false;
    }
    _display += value;
    _expression += value;
  }

  void _handleOperation(String value) {
    if (_display.isEmpty && _expression.isEmpty) return;

    if (_justCalculated) {
      _expression = _display;
      _justCalculated = false;
    }

    _model.num1 = double.tryParse(_display) ?? 0;
    _model.operation = value;
    _display = '';
    _expression += ' $value ';
  }

  void _calculateResult() {
    _model.num2 = double.tryParse(_display) ?? 0;
    double result = 0;

    if (_model.operation == '+') result = _model.num1 + _model.num2;
    if (_model.operation == '-') result = _model.num1 - _model.num2;
    if (_model.operation == '×') result = _model.num1 * _model.num2;
    if (_model.operation == '÷') {
      result = (_model.num2 == 0) ? double.nan : _model.num1 / _model.num2;
    }

    _display = result.isNaN ? 'Ошибка' : result.toString();
    _expression += ' = $_display';
    _justCalculated = true;
    _model.operation = '';
  }
}
