import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

enum DataType { CHAR, DOUBLE, BOOL, INT }

class Variable {
  String _name;
  double _value;
  DataType _type;
  bool _error;
  List<String> _errorList;

  Variable(String variable) {
    _errorList = new List<String>();

    var tokens = variable.replaceAll('-', ' ').split(' ');
    int i = 0;
    _type = DataType.CHAR;
    if (RegExp(r'^([0-9]+)[ a-z]*').hasMatch(tokens[i])) {
      _value = int.parse(RegExp(r'^([0-9]+)[ a-z]*').firstMatch(tokens[i]).group(1)) * 1.0;
      i++;
      if (i < tokens.length) {
        if (DataTypeDouble.hasMatch(tokens[i])) {
          _type = DataType.DOUBLE;
          i++;
        } else if (DataTypeInt.hasMatch(tokens[i])) {
          _type = DataType.INT;
          i++;
        } else if (DataTypeChar.hasMatch(tokens[i])) {
          _type = DataType.CHAR;
          i++;
        } else if (DataTypeBool.hasMatch(tokens[i])) {
          _type = DataType.BOOL;
          i++;
        }
      } else {
        _name = 'INVALID';
      }
    } else {
      // no amount
      _value = 0;
      _type = DataType.DOUBLE;
    }
    _name = '';
    while (i < tokens.length) {
      _name = _name + tokens[i] + (i == tokens.length - 1 ? '' : ' ');
      i++;
    }
    if (_name == '') {
      _name = 'INVALID';
    }
  }

  double getValue() {
    return _value;
  }

  void setValue(double n) {
    _value = n;
  }

  DataType getDataType() {
    return _type;
  }

  void setDataType(DataType s) {
    _type = s;
  }

  void toChar() {
    _type = DataType.CHAR;
  }

  void toDouble() {
    _type = DataType.DOUBLE;
  }

  void toInt() {
    _type = DataType.INT;
    _value = _value.round() * 1.0;
  }

  String getName() {
    return _name;
  }

  void setName(String n) {
    _name = n;
  }

  bool isValid() {
    return _error;
  }

  List<String> getError() {
    return _errorList;
  }
}
