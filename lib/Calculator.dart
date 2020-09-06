import 'dart:math';

class Calculator {
  //this class will handle all the state and business logic of the application.
  void Function() onCorrectAnswer;
  final List operators = ["+", "-", "×", "÷"];
  List operands = [];
  Random randomNumberGenerator;
  int operatorIndex = 0;

  Calculator(this.onCorrectAnswer) {
    randomNumberGenerator = new Random();
    newQuestion();
  }

  String getOperator() {
    return operators[operatorIndex];
  }

  void newQuestion() {
    operands = new List();
    var range = 100;
    operatorIndex = randomNumberGenerator.nextInt(operators.length);
    if (operatorIndex > 1) {
      range = 10;
    }
    operands.add(randomNumberGenerator.nextInt(range).toDouble());
    operands.add(randomNumberGenerator.nextInt(range).toDouble());
  }

  void checkAnswer(double answer) {
    if (answer == null) {
      print("Answer cannot be null. Handle this");
      return;
    }
    double realAnswer;
    if (operatorIndex == 0) {
      realAnswer = (operands[0] + operands[1]).toDouble();
    } else if (operatorIndex == 1) {
      realAnswer = (operands[0] - operands[1]).toDouble();
    } else if (operatorIndex == 2) {
      realAnswer = (operands[0] * operands[1]).toDouble();
    } else if (operatorIndex == 3) {
      realAnswer = (operands[0] / operands[1]).toDouble();
    }
    if (realAnswer == answer) {
      onCorrectAnswer();
      print("CORRECT");
    } else {
      print("WRONG");
    }
    newQuestion();
  }
}
