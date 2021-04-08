import 'package:flutter/services.dart';

class CoordsTextWhat3WordsTextInputFormatter extends TextInputFormatter {

  RegExp _exp;

  CoordsTextWhat3WordsTextInputFormatter() {
    _exp = new RegExp(r'^[a-z]+[.][a-z]+[.][a-z]+\$');
  }

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(_exp.hasMatch(newValue.text.toLowerCase())){
      return newValue;
    }

    return oldValue;
  }
}