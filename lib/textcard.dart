import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextCard extends StatelessWidget {
  TextCard({Key key, this.text: "?", this.size: 32.0}) : super(key: key);
  String text;
  double size;

  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: EdgeInsets.only(right: 16.0),
            width: double.infinity,
            child: Text(text,
                textAlign: TextAlign.right,
                style: new TextStyle(
                  fontSize: size,
                  color: Colors.red,
                ))));
  }
}
