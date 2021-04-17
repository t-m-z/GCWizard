import 'package:gc_wizard/logic/tools/science_and_technology/basic/basic_data.dart';

enum DataType { CHAR, STRING, DOUBLE, BOOL, INT, NULL }

class Variable {
  String _name;
  //double _value;
  Map<DataType, dynamic> _value = new Map();
  DataType _type;
  bool _error;
  List<String> _errorList;

  Variable(String variable) {
    print('inside variable');
    _errorList = new List<String>();

    _name = 'INVALID';
    _type = DataType.NULL;
    if (matchesVariable.hasMatch(variable)) {
      print('match '+variable);
      _name = matchesVariable.firstMatch(variable).group(2);
      switch (matchesVariable.firstMatch(variable).group(1)) {
        case 'double':
          _type = DataType.DOUBLE;
          _value[_type] = double.parse(matchesVariable.firstMatch(variable).group(3)) * 1.0;
          break;
        case 'int':
          _type = DataType.INT;
          _value[_type] = int.parse(matchesVariable.firstMatch(variable).group(3));
          break;
        case 'bool':
          _type = DataType.BOOL;
          break;
        case 'char':
          _type = DataType.CHAR;
          break;
        case 'string':
          _type = DataType.CHAR;
          _value[_type] = matchesVariable.firstMatch(variable).group(3);
          break;
      }
    }
    print('reslt '+_name + ' '+_type.toString()+' '+_value[_type].toString());
  }

  Map<DataType, dynamic> getData(){
    return _value;
  }

  void setData(Map<DataType, dynamic> data){
     _value = data;
  }

  getValue(DataType type) {
    return _value[type];
  }

  void setValue(DataType type, var n) {
    _value[type] = n;
  }

  DataType getDataType() {
    return _type;
  }

  void setDataType(DataType type) {
    _type = type;
  }

  void toBool() {
    switch (_type) {
      case DataType.DOUBLE:
      case DataType.INT:
        if (_value[_type] > 0)
          _value[DataType.BOOL] = true;
        else
          _value[DataType.BOOL] = false;
        break;
      case DataType.CHAR:
        if (_value[_type].startsWith('t'))
          _value[DataType.BOOL] = true;
        else
          _value[DataType.BOOL] = false;
        break;
      case DataType.STRING:
        if (_value[_type] == 'true')
          _value[DataType.BOOL] = true;
        else
          _value[DataType.BOOL] = false;
        break;
    }
    _type = DataType.BOOL;
  }

  void toChar() {
    _type = DataType.CHAR;
  }

  void toDouble() {
    _type = DataType.DOUBLE;
  }

  void toInt() {
    _type = DataType.INT;
    _value[_type] = _value[DataType.DOUBLE].round();
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
