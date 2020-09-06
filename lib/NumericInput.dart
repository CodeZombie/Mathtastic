//this class takes in keys and outputs a float value.
class NumericInput {
  NumericInput({this.onEnterPress});
  void Function(double value) onEnterPress;

  String value = "";

  void keyPress(String key) {
    if (key == "backspace") {
      if (value.length > 0) {
        value = value.substring(0, value.length - 1);
      }
    } else if (key == "clear") {
      value = "";
    } else if (key == "enter") {
      onEnterPress(getValueAsDouble());
      value = "";
    } else if (key == "period") {
      if (!value.contains(".")) {
        value += ".";
      }
    } else if (key == "negative") {
      if (!value.contains("-")) {
        value = "-" + value;
      } else {
        value = value.substring(1);
      }
    } else {
      value += key;
    }
  }

  double getValueAsDouble() {
    double answer;
    try {
      answer = double.tryParse(value);
    } catch (e) {
      return null;
    }
    return answer;
  }
}
