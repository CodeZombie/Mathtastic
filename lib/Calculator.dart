import 'dart:math';

class Calculator {
  //this class will handle all the state and business logic of the application.
  void Function(bool correct) onAnswer;
  List operands = [];
  Random randomNumberGenerator;
  String operator = "+";

  bool enableAddition = true;
  bool enableSubtraction = true;
  bool enableMultiplication = true;
  bool enableDivision = false;

  void setEnableAddition(bool value){
    if (!enableSubtraction && !enableMultiplication && !enableDivision){
      return;
    }
    enableAddition = value;
    if(value == false && operator == "+"){
      newQuestion();
    }
  }
   void setEnableSubtraction(bool value){
     if (!enableAddition && !enableMultiplication && !enableDivision){
      return;
    }
    enableSubtraction = value;
    if(value == false && operator == "-"){
      newQuestion();
    }
  }
   void setEnableMultiplication(bool value){
     if (!enableAddition& !enableSubtraction && !enableDivision){
      return;
    }
    enableMultiplication = value;
    if(value == false && operator == "×"){
      newQuestion();
    }
  }
   void setEnableDivision(bool value){
     if (!enableAddition& !enableSubtraction && !enableMultiplication){
      return;
    }
    enableDivision = value;
    if(value == false && operator == "÷"){
      newQuestion();
    }
  }

  List getOperators() {
    List ops = [];
    if(enableAddition) {
      ops.add("+");
    }
    if(enableSubtraction){
      ops.add("-");
    }
    if(enableMultiplication){
      ops.add("×");
    }
    if(enableDivision){
      ops.add("÷");
    }
    return ops;
  }

  Calculator(this.onAnswer) {
    randomNumberGenerator = new Random();
    newQuestion();
  }

  void newQuestion() {
    operands = new List();
    operator = getOperators()[randomNumberGenerator.nextInt(getOperators().length)];

    if(operator == "÷"){
      double divisor = randomNumberGenerator.nextInt(11).toDouble() + 1;
      operands.add(divisor * randomNumberGenerator.nextInt(15).toDouble());
      operands.add(divisor);
    }else if(operator == "×"){
      operands.add(randomNumberGenerator.nextInt(12).toDouble());
      operands.add(randomNumberGenerator.nextInt(12).toDouble());
    }else{
      operands.add(randomNumberGenerator.nextInt(150).toDouble());
      operands.add(randomNumberGenerator.nextInt(150).toDouble());
    }
  }

  void checkAnswer(double answer) {
    if (answer == null) {
      print("Answer cannot be null. Handle this");
      return;
    }
    double realAnswer;
    if (getOperators() == "+") {
      realAnswer = (operands[0] + operands[1]).toDouble();
    } else if (operator == "-") {
      realAnswer = (operands[0] - operands[1]).toDouble();
    } else if (operator == "×") {
      realAnswer = (operands[0] * operands[1]).toDouble();
    } else if (operator == "÷") {
      realAnswer = (operands[0] / operands[1]).toDouble();
    }
    if (realAnswer == answer) {
      onAnswer(true);
      print("CORRECT");
    } else {
      onAnswer(false);
      print("WRONG");
    }
    newQuestion();
  }
}
