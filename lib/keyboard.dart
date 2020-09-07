import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Keyboard extends StatelessWidget {
  Keyboard({Key key, this.onKeyPress}) : super(key: key);

  final void Function(String key) onKeyPress;

  @override
  Widget build(BuildContext context) {
    List buttons = [
      {
        'id': '1',
        'item': Text("1", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '2',
        'item': Text("2", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '3',
        'item': Text("3", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '4',
        'item': Text("4", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '5',
        'item': Text("5", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '6',
        'item': Text("6", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '7',
        'item': Text("7", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '8',
        'item': Text("8", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': '9',
        'item': Text("9", style: Theme.of(context).textTheme.headline5)
      },
      {
        'id': 'negative',
        'item': Text("-",
            style: Theme.of(context)
                .textTheme
                .headline5
                .apply(fontSizeFactor: 1.5))
      },
      {
        'id': '0',
        'item': Text("0", style: Theme.of(context).textTheme.headline5),
      },
      {
        'id': 'period',
        'item': Text("•", style: Theme.of(context).textTheme.headline5),
      },
      {
        'id': 'backspace',
        'item': Icon(Icons.arrow_back, size: 24,),
      },
      {'id': "spacing"},
      {
        'id': 'enter',
        'item': Icon(Icons.done, size: 24, color: Colors.red),
      },
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.blueGrey[50]),
      child: Wrap(
          spacing: 32.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: List.generate(buttons.length, (index) {
            if (buttons[index]['id'] == "spacing") {
              return Padding(
                padding: EdgeInsets.all(18.0),
              );
            } else {
              return RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    onKeyPress(buttons[index]['id']);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: buttons[index]['item'],
                  ));
            }
          })),
    );
  }
}