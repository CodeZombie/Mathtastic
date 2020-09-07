import 'package:flutter/material.dart';
import 'package:math_app/numericInput.dart';
import 'keyboard.dart';
import 'Calculator.dart';
import 'equation.dart';

void main() {
  runApp(Mathtastic());
}

class Mathtastic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mathtastic'),
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
  bool showCorrectWidget = false;
  bool showIncorrectWidget = false;

  AnimationController _animationController;

  _MyHomePageState() {
    calculator = new Calculator(
      _onAnswer,
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

  void _onAnswer(bool correct) {
    setState(() {
      showCorrectWidget = showIncorrectWidget = false;
      _animationController.reset();
      _animationController.forward();

      if(correct) {
        showCorrectWidget = true;
      }else{
        showIncorrectWidget = true;
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          showCorrectWidget = showIncorrectWidget = false;
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
          visible: (showCorrectWidget == false && showIncorrectWidget == false),
          child: Equation(
              operands: calculator.operands,
              operator: calculator.getOperator(),
              answer: keyboardValue.value),
        ),

        Visibility(
            visible: showCorrectWidget,
            child: Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedIcon(
                  icon: AnimatedIcons.event_add,
                  progress: _animationController,
                  size: 96,
                ),
                Text("Correct!"),
              ],
            ))),

            Visibility(
            visible: showIncorrectWidget,
            child: Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedIcon(
                  icon: AnimatedIcons.search_ellipsis,
                  progress: _animationController,
                  size: 96,
                ),
                Text("Incorrect!"),
              ],
            ))),

        Keyboard(onKeyPress: _getKeyPress),
      ]),
    );
  }
}
