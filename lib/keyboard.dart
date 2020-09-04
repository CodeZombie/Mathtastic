import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//TODO: MAKE THIS STATELESS.

class Keyboard extends StatelessWidget {
  Keyboard({Key key, this.onKeyPress}) : super(key: key);

  final void Function(String key) onKeyPress;

  @override
  Widget build(BuildContext context) {

    List buttons = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "-",
      "0",
      ".",
      "C"
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.blueGrey[50]),
      child: Wrap(
          spacing: 32.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: List.generate(buttons.length, (index) {
            return RawMaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  onKeyPress(buttons[index]);
                  print("Pressed: " + buttons[index]);
                },
                child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      buttons[index],
                      style: Theme.of(context).textTheme.headline5,
                    )));
          })),
    );
  }
}

/*
  Widget build(BuildContext context) {
    List buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."];
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          children: List.generate(buttons.length, (index) {
            return Center(
                child: Text(
              buttons[index],
              style: Theme.of(context).textTheme.headline5,
            ));
          })),
    );
  }
  */
