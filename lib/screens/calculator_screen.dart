import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '0';
  int themeIndex = 0;
  List<String> _history = [];

  final List<Color> backgroundColors = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.green,
  ];

  final List<Color> textColors = [
    Colors.white,
    Colors.black,
    Colors.white,
    Colors.white,
  ];

  final List<Color> buttonBackgroundColors = [
    Color(0xFF333333),
    Colors.grey[300]!,
    Colors.blueAccent,
    Colors.greenAccent,
  ];

  final List<Color> buttonTextColors = [
    Colors.white,
    Colors.black,
    Colors.white,
    Colors.white,
  ];

  void _toggleTheme() {
    setState(() {
      themeIndex = (themeIndex + 1) % 4;
    });
  }

  void _buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '0';
      } else if (text == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          _result = eval.toString();
          _history.insert(0, '$_expression = $_result');
        } catch (e) {
          _result = 'Error';
        }
      } else if (text == '√') {
        try {
          double value = double.tryParse(_expression) ?? 0;
          double sqrtValue = value >= 0 ? sqrt(value) : double.nan;
          _result = sqrtValue.toString();
          _history.insert(0, '√($_expression) = $_result');
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text, {Color? color, Color? bgColor}) {
    return Container(
      margin: EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 28, color: color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = backgroundColors[themeIndex];
    final Color textColor = textColors[themeIndex];
    final Color buttonColor = buttonTextColors[themeIndex];
    final Color buttonBackgroundColor = buttonBackgroundColors[themeIndex];

    final List<List<String>> buttons = [
      ['C', '÷', '×', '√'],
      ['7', '8', '9', '-'],
      ['4', '5', '6', '+'],
      ['1', '2', '3', '='],
      ['0', '.', '', ''],
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Kalkulator Mini', style: TextStyle(color: textColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.palette, color: textColor),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              reverse: true,
              children: [
                ..._history.map((item) => Text(
                  item,
                  style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 16),
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_expression, style: TextStyle(fontSize: 32, color: textColor.withOpacity(0.7))),
                SizedBox(height: 10),
                Text(_result, style: TextStyle(fontSize: 48, color: textColor)),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              double buttonWidth = constraints.maxWidth / 4 - 12;
              double buttonHeight = constraints.maxHeight / 15;

              return Column(
                children: buttons.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row.map((btn) {
                      if (btn == '') return SizedBox(width: buttonWidth);
                      Color color = (btn == 'C') ? Colors.redAccent : (['+', '-', '×', '÷', '=', '√'].contains(btn) ? Colors.orange : buttonColor);
                      return _buildButton(btn, color: color, bgColor: buttonBackgroundColor);
                    }).toList(),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _history.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            icon: Icon(Icons.delete, color: Colors.white),
            label: Text("Hapus Riwayat", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
