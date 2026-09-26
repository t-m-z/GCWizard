part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _GlobalTarget extends _Target {
  final String name;

  _GlobalTarget(this.name);

  @override
  void print(_Decompiler d, _Output out) {
    out.print(name);
  }

  @override
  void printMethod(_Decompiler d, _Output out) {
    throw StateError('GlobalTarget cannot be used as a method target');
  }
}
