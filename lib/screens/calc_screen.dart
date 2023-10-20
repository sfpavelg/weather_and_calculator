import 'package:flutter/material.dart';
import 'package:weather_and_calculator/arithmetic_utils/arithmetic_operations.dart';
import 'package:weather_and_calculator/screens/features/button.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  _CalcScreenState createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  final ArithmeticOperations _arithmeticOperations = ArithmeticOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(12),
              ),
              // color: Colors.cyan,
              child: Row(
                children: [
                  Text(
                    _arithmeticOperations.resultNumber,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '1',
                  onPressed: () => _onNumberPressed(1),
                ),
                Button(
                  value: '2',
                  onPressed: () => _onNumberPressed(2),
                ),
                Button(
                  value: '3',
                  onPressed: () => _onNumberPressed(3),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '4',
                  onPressed: () => _onNumberPressed(4),
                ),
                Button(
                  value: '5',
                  onPressed: () => _onNumberPressed(5),
                ),
                Button(
                  value: '6',
                  onPressed: () => _onNumberPressed(6),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '7',
                  onPressed: () => _onNumberPressed(7),
                ),
                Button(
                  value: '8',
                  onPressed: () => _onNumberPressed(8),
                ),
                Button(
                  value: '9',
                  onPressed: () => _onNumberPressed(9),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '0',
                  onPressed: () => _onNumberPressed(0),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '+',
                  onPressed: () => _onOperationPressed('+'),
                ),
                Button(
                  value: '-',
                  onPressed: () => _onOperationPressed('-'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  value: '*',
                  onPressed: () => _onOperationPressed('*'),
                ),
                Button(
                  value: '/',
                  onPressed: () => _onOperationPressed('/'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Button(
              value: '=',
              onPressed: _onEqualsPressed,
            ),
            Button(
              value: 'C',
              onPressed: _onClear,
            ),
          ],
        ),
      ),
    );
  }

  void _onNumberPressed(int number) {
    setState(() {
      _arithmeticOperations.numberPressed(number);
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _arithmeticOperations.operationPressed(operation);
    });
  }

  void _onEqualsPressed() {
    setState(() {
      _arithmeticOperations.equalsPressed();
    });
  }

  void _onClear() {
    setState(() {
      _arithmeticOperations.clear();
    });
  }
}
