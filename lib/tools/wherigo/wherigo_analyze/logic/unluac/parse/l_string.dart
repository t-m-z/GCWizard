part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LString extends _LObject {
  final int size;
  final String value;

  _LString(this.size, String value)
      : value = value.isEmpty ? '' : value.substring(0, value.length - 1);

  @override
  String deref() => value;

  @override
  String toString() => '"$value"';
}
