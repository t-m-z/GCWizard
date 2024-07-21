import 'package:flutter/services.dart';

class DegreesLonTextInputFormatter extends TextInputFormatter {
  final bool allowNegativeValues;

  DegreesLonTextInputFormatter({this.allowNegativeValues = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!allowNegativeValues && newValue.text == '-') return oldValue;

    if (newValue.text.isEmpty || newValue.text == '-') return newValue;

    var _newInt = int.tryParse(newValue.text);
    if (_newInt == null) return oldValue;

    if (!allowNegativeValues && _newInt < 0) return oldValue;

    if (_newInt >= -180 && _newInt <= 180) return newValue;

    return oldValue;
  }
}
