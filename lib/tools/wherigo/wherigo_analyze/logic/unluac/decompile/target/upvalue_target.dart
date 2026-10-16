part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _UpvalueTarget extends _Target {
  final String name;

  _UpvalueTarget(this.name);

  @override
  void print(_Decompiler d, _Output out) {
    out.print(name);
  }

  @override
  void printMethod(_Decompiler d, _Output out) {
    throw StateError('UpvalueTarget cannot be used as a method target');
  }
}
