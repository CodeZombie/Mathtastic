import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:math_app/InputLibrary.dart';
import 'package:math_app/Keyboards/DecimalNumberKeyboard.dart';

import '../equation.dart';

class MultiplicationQuestion extends StatefulWidget {
  MultiplicationQuestion(
      {Key key, this.difficulty: 1, this.onCorrect, this.onFalse})
      : super(key: key);
  final Function() onCorrect;
  final Function() onFalse;
  final double difficulty;

  _MultiplicationQuestionState createState() => _MultiplicationQuestionState();
}

class _MultiplicationQuestionState extends State<MultiplicationQuestion> {
  List<double> operands;

  void initState() {
    super.initState();
    newQuestion();
  }

  void newQuestion() {
    setState(() {
      Random random = new Random();
      operands = new List();
      operands.add(random.nextInt(15).toDouble());
      operands.add(random.nextInt(15).toDouble());
    });
  }

  void onKeyboardEnter(String value) {
    setState(() {
      double answer = InputLibrary.getValueAsDouble(value);
      if (answer == null) {
        return;
      }
      if (answer == operands[0] * operands[1]) {
        widget.onCorrect();
      } else {
        widget.onFalse();
      }
    });
    newQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Equation(
        operands: operands,
        operator: "×",
      ),
      DecimalNumberKeyboard(onEnter: onKeyboardEnter),
    ]);
  }
}
