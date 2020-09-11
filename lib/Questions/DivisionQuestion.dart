import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:math_app/InputLibrary.dart';
import 'package:math_app/Keyboards/DecimalNumberKeyboard.dart';

import '../equation.dart';

class DivisionQuestion extends StatefulWidget {
  DivisionQuestion({Key key, this.difficulty: 1, this.onCorrect, this.onFalse})
      : super(key: key);
  final Function() onCorrect;
  final Function() onFalse;
  final double difficulty;

  _DivisionQuestionState createState() => _DivisionQuestionState();
}

class _DivisionQuestionState extends State<DivisionQuestion> {
  List<double> operands;

  void initState() {
    super.initState();
    newQuestion();
  }

  void newQuestion() {
    setState(() {
      Random random = new Random();
      operands = new List();
      double divisor = random.nextInt(11).toDouble() + 1;
      operands.add(divisor * random.nextInt(15).toDouble());
      operands.add(divisor);
    });
  }

  void onKeyboardEnter(String value) {
    setState(() {
      double answer = InputLibrary.getValueAsDouble(value);
      if (answer == null) {
        return;
      }
      if (answer == operands[0] / operands[1]) {
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
        operator: "÷",
      ),
      DecimalNumberKeyboard(onEnter: onKeyboardEnter),
    ]);
  }
}
