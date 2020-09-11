import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:math_app/Questions/DivisionQuestion.dart';
import 'package:math_app/Questions/MultiplicationQuestion.dart';
import 'package:math_app/Questions/SubtractionQuestion.dart';
import 'Questions/AdditionQuestion.dart';

enum QuestionType {
  addition,
  subtraction,
  multiplication,
  division,
  clock,
  month,
  alphabet,
}

class QuestionProvider extends StatefulWidget {
  QuestionProvider({Key key, this.onAnswer, this.availableQuestionTypes})
      : super(key: key);

  final void Function(bool correct) onAnswer;
  final List<QuestionType> availableQuestionTypes;

  @override
  _QuestionProviderState createState() => _QuestionProviderState();
}

class _QuestionProviderState extends State<QuestionProvider> {
  final random = new Random();
  Widget currentQuestion;

  void initState() {
    super.initState();
    newQuestion();
  }

  void onCorrect() {
    widget.onAnswer(true);
    newQuestion();
  }

  void onFalse() {
    widget.onAnswer(false);
    newQuestion();
  }

  void newQuestion() {
    setState(() {
      QuestionType currentQuestionType = widget.availableQuestionTypes[
          random.nextInt(widget.availableQuestionTypes.length)];
      if (currentQuestionType == QuestionType.addition) {
        currentQuestion = AdditionQuestion(
            difficulty: 1, onCorrect: onCorrect, onFalse: onFalse);
      } else if (currentQuestionType == QuestionType.subtraction) {
        currentQuestion = SubtractionQuestion(
            difficulty: 1, onCorrect: onCorrect, onFalse: onFalse);
      } else if (currentQuestionType == QuestionType.multiplication) {
        currentQuestion = MultiplicationQuestion(
            difficulty: 1, onCorrect: onCorrect, onFalse: onFalse);
      } else if (currentQuestionType == QuestionType.division) {
        currentQuestion = DivisionQuestion(
            difficulty: 1, onCorrect: onCorrect, onFalse: onFalse);
      }
    });
  }

  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    newQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return currentQuestion;
  }
}
