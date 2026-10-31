part of 'package:gc_wizard/tools/general_tools/gcwizardscript/logic/gcwizard_script.dart';

// Performance: these helpers are called for nearly every token and every
// arithmetic operation. They used to compare `value.toString()` with 'null',
// which allocated a string per call and serialized whole lists. They now use
// plain type tests.
//
// Semantics kept: every _isX(null) and every _isNotX(null) is false.

bool _isALetter(String vname) {
  if (vname.length != 1) return false;
  return _isALetterCode(vname.codeUnitAt(0));
}

bool _isALetterCode(int c) {
  return (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A); // A-Z, a-z
}

bool _isADigit(String vname) {
  if (vname.length != 1) return false;
  return _isADigitCode(vname.codeUnitAt(0));
}

bool _isADigitCode(int c) {
  return c >= 0x30 && c <= 0x39; // 0-9
}

bool _isNotADouble(Object? value) {
  return value != null && value is! double;
}

bool _isADouble(Object? value) {
  return value is double;
}

bool _isNotAInt(Object? value) {
  return value != null && value is! int;
}

bool _isAInt(Object? value) {
  return value is int;
}

bool _isNotAString(Object? value) {
  return value != null && value is! String;
}

bool _isAString(Object? value) {
  return value is String;
}

bool _isANumber(Object? value) {
  return value is num;
}

bool _isNotANumber(Object? value) {
  return value != null && value is! num;
}

bool _isAList(Object? value) {
  return value is _GCWList;
}

bool _isNotAList(Object? value) {
  return value != null && value is! _GCWList;
}
