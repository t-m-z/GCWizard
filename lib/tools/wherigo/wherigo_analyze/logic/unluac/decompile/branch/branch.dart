part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Branch {
  final int line;
  int begin;
  int end; // Might be modified to undo redirect

  bool isSet = false;
  bool isCompareSet = false;
  bool isTest = false;
  int setTarget = -1;

  _Branch(this.line, this.begin, this.end);

  _Branch invert();

  int getRegister();

  _Expression asExpression(_Registers r);

  void useExpression(_Expression expression);
}
