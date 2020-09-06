import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextCard extends StatelessWidget {
  TextCard({
    Key key,
    this.text: "?",
    this.textColor: Colors.red,
    this.preText: "",
    this.preTextColor: Colors.blue,
    this.size: 32.0,
  }) : super(key: key);

  final String text;
  final double size;
  final String preText;
  final Color textColor;
  final Color preTextColor;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 16.0, left: 16.0),
        width: double.infinity,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(preText,
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    fontSize: size * .75,
                    color: preTextColor,
                  )),
              Flexible(
                  child: Text(text,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        fontSize: size,
                        color: textColor,
                      ))),
            ]));
  }
}
