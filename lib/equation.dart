import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'textcard.dart';

class Equation extends StatelessWidget {
  Equation({
    Key key,
    this.operands,
    this.operator,
    this.answer,
  }) : super(key: key);

  List operands;
  String operator, answer;

  String formatNumber(double number) {
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
  }

  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: <Widget>[
        TextCard(
          text: formatNumber(operands[0]),
          textColor: Colors.blue,
          size: 72,
        ),
        TextCard(
            preText: operator,
            preTextColor: Colors.red,
            text: formatNumber(operands[1]),
            textColor: Colors.blue,
            size: 72),
        Divider(
          color: Colors.red,
          height: 20,
          thickness: 3,
          indent: 16,
          endIndent: 16,
        ),
        TextCard(
          preText: "=",
          preTextColor: Colors.green,
          text: answer,
          textColor: Colors.green,
          size: 64,
        ),
      ],
    ));
  }
}
