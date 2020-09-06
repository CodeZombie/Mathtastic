import 'package:flutter/material.dart';
import 'package:math_app/numericInput.dart';
import 'keyboard.dart';
import 'Calculator.dart';
import 'equation.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Calculator calculator;
  NumericInput keyboardValue;
  bool equationVisible = true;

  AnimationController _animationController;

  _MyHomePageState() {
    calculator = new Calculator(
      _onCorrectAnswer,
    );
    keyboardValue = new NumericInput(
      onEnterPress: calculator.checkAnswer,
    );
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
  }

  void _getKeyPress(String key) {
    setState(() {
      keyboardValue.keyPress(key);
    });
  }

  void _onCorrectAnswer() {
    setState(() {
      _animationController.reset();
      equationVisible = false;
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          equationVisible = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Visibility(
          visible: equationVisible,
          child: Equation(
              operands: calculator.operands,
              operator: calculator.getOperator(),
              answer: keyboardValue.value),
        ),
        Visibility(
            visible: !equationVisible,
            child: Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: _animationController,
                  semanticLabel: 'Show menu',
                  size: 96,
                ),
                Text("Correct!"),
              ],
            ))),
        Keyboard(onKeyPress: _getKeyPress),
      ]),
    );
  }
}
