part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _CompareBlock extends _Block {
  final int target;
  final _Branch branch;

  _CompareBlock(super.function, super.begin, super.end, this.target, this.branch);

  @override
  bool isContainer() => false;

  @override
  bool breakable() => false;

  @override
  void addStatement(_Statement statement) {
    /* Do nothing */
  }

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('CompareBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('-- unhandled compare assign');
  }

  @override
  _Operation process(_Decompiler d) {
    return _CompareOperation(end - 1, end, target, branch);
  }
}

class _CompareOperation extends _Operation {
  final int end;
  final int target;
  final _Branch branch;

  _CompareOperation(super.line, this.end, this.target, this.branch);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _RegisterSet(end - 1, target, branch.asExpression(r))
        .process(r, block);
  }
}
