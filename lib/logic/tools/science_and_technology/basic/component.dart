import 'package:gc_wizard/logic/tools/science_and_technology/basic/variables.dart';

class Component {
  DataType _dataType;
  Map<DataType, dynamic> _value = new Map();
  String _name;

  Component(Map<DataType, dynamic> n, DataType s, String name) {
    _value = n;
    _dataType = s;
    _name = name;
  }

  Component.Contructor1(Variable variable) {
    _value = variable.getData();
    _dataType = variable.getDataType();
    _name = variable.getName();
  }

  getValue(DataType type) {
    return _value[type];
  }

  void setValue(DataType type, var n) {
    _value[type] = n;
  }

  DataType getDataType() {
    return _dataType;
  }

  void setDataType(DataType s) {
    _dataType = s;
  }

  String getName() {
    return _name;
  }

  void setName(String n) {
    _name = n;
  }

  //@Override
  Component clone() {
    return Component(_value, _dataType, _name);
  }

  void toChar() {
    _dataType = DataType.CHAR;
  }

  void toDouble() {
    _dataType = DataType.DOUBLE;
  }

}
