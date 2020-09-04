import 'dart:math';

class Calculator {
  //this class will handle all the state and business logic of the application.
  final List operators = ["+", "-", "*", "/"];
  List operands = [];
  Random randomNumberGenerator;
  String operator = "+";

  Calculator() {
    randomNumberGenerator = new Random();
    newQuestion();
  }

  void newQuestion() {
    operands = new List();
    operands.add(randomNumberGenerator.nextInt(100));
    operands.add(randomNumberGenerator.nextInt(100));
    operator = operators[randomNumberGenerator.nextInt(operators.length)];
  }

  void attemptSolve(double answer){

  }
  
}