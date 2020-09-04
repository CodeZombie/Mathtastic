import 'package:flutter/material.dart';
import 'package:math_app/numericInput.dart';
import 'keyboard.dart';
import 'textcard.dart';
import 'Calculator.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Math!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  NumericInput keyboardValue = new NumericInput();
  Calculator calculator = new Calculator();

  void _getKeyPress(String key) {
    setState(() {
      keyboardValue.keyPress(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView(
          children: <Widget>[
            TextCard(text: calculator.operands[0].toString(), size: 64),
            TextCard(text: calculator.operator),
            TextCard(text: calculator.operands[1].toString(), size: 64),
            TextCard(text: keyboardValue.value, size: 64),
          ],
        )),
        Keyboard(onKeyPress: _getKeyPress),
      ]),
    );
  }
}
