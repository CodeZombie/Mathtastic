import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:math_app/InputLibrary.dart';
import 'package:math_app/Keyboards/DecimalNumberKeyboard.dart';

import '../equation.dart';

class SubtractionQuestion extends StatefulWidget {
  SubtractionQuestion(
      {Key key, this.difficulty: 1, this.onCorrect, this.onFalse})
      : super(key: key);
  final Function() onCorrect;
  final Function() onFalse;
  final double difficulty;

  _SubtractionQuestionState createState() => _SubtractionQuestionState();
}

class _SubtractionQuestionState extends State<SubtractionQuestion> {
  List<double> operands;

  void initState() {
    super.initState();
    newQuestion();
  }

  void newQuestion() {
    setState(() {
      Random random = new Random();
      operands = new List();
      operands.add(random.nextInt(150).toDouble());
      operands.add(random.nextInt(150).toDouble());
    });
  }

  void onKeyboardEnter(String value) {
    setState(() {
      double answer = InputLibrary.getValueAsDouble(value);
      if (answer == null) {
        return;
      }
      if (answer == operands[0] - operands[1]) {
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
        operator: "-",
      ),
      DecimalNumberKeyboard(onEnter: onKeyboardEnter),
    ]);
  }
}
