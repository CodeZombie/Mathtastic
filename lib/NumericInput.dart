//this class takes in keys and outputs a float value.
class NumericInput {

  String value = "";
  
  void keyPress(String key) {
      if(key == "C"){
        value = "";
      }
      else if(key == "."){
        if(!value.contains(".")){
          value += ".";
        }
      }
      else if(key == "-"){
        if(!value.contains("-")){
          value = "-" + value;
        }else{
          value = value.substring(1);
        }
      }
      else{
        value += key;
      }
  }

  double getValueAsFloat() {
    return 0.0;
  }
}