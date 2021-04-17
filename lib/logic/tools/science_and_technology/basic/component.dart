import 'package:gc_wizard/logic/tools/science_and_technology/basic/variables.dart';

class Component {
  DataType _dataType;
  double _value;
  String _name;

  Component(double n, DataType s, String name) {
    _value = n;
    _dataType = s;
    _name = name;
  }

  Component.Contructor1(Variable variable) {
    _value = variable.getValue();
    _dataType = variable.getDataType();
    _name = variable.getName();
  }

  double getValue() {
    return _value;
  }

  void setValue(double n) {
    _value = n;
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
