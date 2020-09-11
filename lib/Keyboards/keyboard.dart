import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../textcard.dart';

class Keyboard extends StatefulWidget {
  Keyboard({Key key, this.onEnter, this.buttons}) : super(key: key);

  final void Function(String key) onEnter;
  final List buttons;

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  String value = "";

  void _onKeyPress(String key) {
    setState(() {
      if (key == "backspace") {
        if (value.length > 0) {
          value = value.substring(0, value.length - 1);
        }
      } else if (key == "clear") {
        value = "";
      } else if (key == "enter") {
        widget.onEnter(value);
        value = "";
      } else if (key == "period") {
        if (!value.contains(".")) {
          value += ".";
        }
      } else if (key == "negative") {
        if (!value.contains("-")) {
          value = "-" + value;
        } else {
          value = value.substring(1);
        }
      } else {
        value += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextCard(
        preText: "=",
        preTextColor: Colors.grey[400],
        text: value,
        textColor: Colors.green,
        size: 64,
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blueGrey[50]),
        child: Wrap(
            spacing: 32.0,
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: List.generate(widget.buttons.length, (index) {
              if (widget.buttons[index]['id'] == "spacing") {
                return Padding(
                  padding: EdgeInsets.all(18.0),
                );
              } else {
                return RawMaterialButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      _onKeyPress(widget.buttons[index]['id']);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: widget.buttons[index]['item'],
                    ));
              }
            })),
      ),
    ]);
  }
}
