import 'package:flutter/material.dart';
import 'package:math_app/QuestionProvider.dart';
import 'ToggleListTile.dart';

void main() {
  runApp(Mathtastic());
}

class Mathtastic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyscalculia Trainer',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(title: 'Dyscalculia Trainer'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool showQuestion = true;
  AnimationController _animationController;
  String fullscreenNotificationText = "";
  AnimatedIconData fullscreenNotificationIcon = AnimatedIcons.event_add;

  List<QuestionType> availableQuestionTypes = [
    QuestionType.addition,
    QuestionType.subtraction
  ];

  void toggleAvailableQuestionType(
      bool toggleDirection, QuestionType questionType) {
    if (toggleDirection == false) {
      if (availableQuestionTypes.length == 1) {
        return;
      }
      if (availableQuestionTypes.contains(questionType)) {
        setState(() {
          availableQuestionTypes.remove(questionType);
        });
      }
    } else {
      availableQuestionTypes.add(questionType);
    }
  }

  _HomeScreenState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
  }

  void _onAnswer(bool correct) {
    setState(() {
      showQuestion = false;
      _animationController.reset();
      _animationController.forward();

      if (correct) {
        fullscreenNotificationIcon = AnimatedIcons.event_add;
        fullscreenNotificationText = "correct";
      } else {
        fullscreenNotificationIcon = AnimatedIcons.menu_close;
        fullscreenNotificationText = "incorrect";
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          showQuestion = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (showQuestion) {
      body = QuestionProvider(
        onAnswer: _onAnswer,
        availableQuestionTypes: availableQuestionTypes,
      );
    } else {
      body = Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            AnimatedIcon(
              icon: fullscreenNotificationIcon,
              progress: _animationController,
              size: 96,
            ),
            Text(fullscreenNotificationText),
          ]));
    }

    return Scaffold(
      drawer: Drawer(
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
            DrawerHeader(
              child: Text('Mathtastic',
                  style: new TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ToggleListTile(
                title: "Addition",
                enabled: availableQuestionTypes.contains(QuestionType.addition),
                onChange: (v) {
                  setState(() {
                    toggleAvailableQuestionType(v, QuestionType.addition);
                  });
                }),
            ToggleListTile(
                title: "Subtraction",
                enabled:
                    availableQuestionTypes.contains(QuestionType.subtraction),
                onChange: (v) {
                  setState(() {
                    toggleAvailableQuestionType(v, QuestionType.subtraction);
                  });
                }),
            ToggleListTile(
                title: "Multiplication",
                enabled: availableQuestionTypes
                    .contains(QuestionType.multiplication),
                onChange: (v) {
                  setState(() {
                    toggleAvailableQuestionType(v, QuestionType.multiplication);
                  });
                }),
            ToggleListTile(
                title: "Division",
                enabled: availableQuestionTypes.contains(QuestionType.division),
                onChange: (v) {
                  setState(() {
                    toggleAvailableQuestionType(v, QuestionType.division);
                  });
                }),
          ])),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }
}
