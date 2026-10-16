part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LBoolean extends _LObject {
  static final _LBoolean ltrue = _LBoolean._(true);
  static final _LBoolean lfalse = _LBoolean._(false);

  final bool value;

  _LBoolean._(this.value);

  @override
  String toString() => value.toString();
}
