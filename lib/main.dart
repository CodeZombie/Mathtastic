import 'package:flutter/material.dart';
import 'package:math_app/numericInput.dart';
import 'keyboard.dart';
import 'Calculator.dart';
import 'equation.dart';
import 'ToggleListTile.dart';

void main() {
  runApp(Mathtastic());
}

class Mathtastic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathtastic',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
      drawer: Drawer(child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Mathtastic', style: new TextStyle(fontSize: 25, color: Colors.white,)),
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
      ToggleListTile(title: "Addition", enabled: calculator.enableAddition, onChange: (v) {
        setState(() {
          calculator.setEnableAddition(v);
        });
      }),
      ToggleListTile(title: "Subtraction", enabled: calculator.enableSubtraction, onChange: (v) {
        setState(() {
          calculator.setEnableSubtraction(v);
        });
      }),
      ToggleListTile(title: "Multiplication", enabled: calculator.enableMultiplication, onChange: (v) {
        setState(() {
          calculator.setEnableMultiplication(v);
        });
      }),
      ToggleListTile(title: "Division", enabled: calculator.enableDivision, onChange: (v) {
        setState(() {
          calculator.setEnableDivision(v);
        });
      }),
      ])),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Visibility(
          visible: (showCorrectWidget == false && showIncorrectWidget == false),
          child: Equation(
              operands: calculator.operands,
              operator: calculator.operator,
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
