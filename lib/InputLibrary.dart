class InputLibrary {
  static double getValueAsDouble(String value) {
    double answer;
    try {
      answer = double.tryParse(value);
    } catch (e) {
      return null;
    }
    return answer;
  }
}
