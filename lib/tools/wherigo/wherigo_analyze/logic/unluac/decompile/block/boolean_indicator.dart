part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _BooleanIndicator extends _Block {
  _BooleanIndicator(_LFunction function, int line) : super(function, line, line);

  @override
  void addStatement(_Statement statement) {}

  @override
  bool isContainer() => false;

  @override
  bool isUnprotected() => false;

  @override
  bool breakable() => false;

  @override
  int getLoopback() => throw StateError('BooleanIndicator has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('-- unhandled boolean indicator');
  }
}
