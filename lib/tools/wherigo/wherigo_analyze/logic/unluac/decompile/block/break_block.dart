part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';
/// unluac calls this `Break`; renamed here because `break` is a Dart
/// keyword and can't be used as a type name.
class _BreakBlock extends _Block {
  final int target;

  _BreakBlock(_LFunction function, int line, this.target)
      : super(function, line, line);

  @override
  void addStatement(_Statement statement) {
    throw StateError('BreakBlock cannot contain statements');
  }

  @override
  bool isContainer() => false;

  @override
  bool breakable() => false;

  @override
  bool isUnprotected() => false; // Actually it is, but not really a block.

  @override
  int getLoopback() => throw StateError('BreakBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('do break end');
  }

  @override
  void printTail(_Decompiler d, _Output out) {
    out.print('break');
  }
}
