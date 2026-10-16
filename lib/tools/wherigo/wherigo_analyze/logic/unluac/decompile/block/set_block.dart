part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _SetBlock extends _Block {
  final int target;
  _Assignment? assign;
  final _Branch branch;
  final _Registers r;
  final bool empty;
  bool _finalize = false;

  _SetBlock(_LFunction function, this.branch, this.target, int line, int begin,
      int end, this.empty, this.r)
      : super(function, begin == end ? begin - 1 : begin, end);

  @override
  void addStatement(_Statement statement) {
    if (!_finalize && statement is _Assignment) {
      assign = statement;
    } else if (statement is _BooleanIndicator) {
      _finalize = true;
    }
  }

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('SetBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    final a = assign;
    if (a != null) {
      final assignOut = _Assignment.single(a.getFirstTarget(), getValue());
      assignOut.print(d, out);
    } else {
      out.print('-- unhandled set block');
      out.println();
    }
  }

  @override
  bool breakable() => false;

  @override
  bool isContainer() => false;

  void useAssignment(_Assignment assign) {
    this.assign = assign;
    branch.useExpression(assign.getFirstValue());
  }

  _Expression getValue() => branch.asExpression(r);

  @override
  _Operation process(_Decompiler d) {
    if (empty) {
      final expression = r.getExpression(branch.setTarget, end);
      branch.useExpression(expression);
      return _RegisterSet(end - 1, branch.setTarget, branch.asExpression(r));
    } else if (assign != null) {
      branch.useExpression(assign!.getFirstValue());
      final target = assign!.getFirstTarget();
      final value = getValue();
      return _SetAssignOperation(end - 1, target, value);
    } else {
      return _SetFallbackOperation(end - 1, d, branch, target, r);
    }
  }
}

class _SetAssignOperation extends _Operation {
  final _Target target;
  final _Expression value;

  _SetAssignOperation(super.line, this.target, this.value);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _Assignment.single(target, value);
  }
}

class _SetFallbackOperation extends _Operation {
  final _Decompiler d;
  final _Branch branch;
  final int target;
  final _Registers outerR;

  _SetFallbackOperation(
      super.line, this.d, this.branch, this.target, this.outerR);

  @override
  _Statement? process(_Registers r, _Block block) {
    _Expression? expr;
    var register = 0;
    for (; register < r.registers; register++) {
      if (r.getUpdated(register, branch.end - 1) == branch.end - 1) {
        expr = r.getValue(register, branch.end);
        break;
      }
    }
    if (d.code.op(branch.end - 2) == _Op.loadbool &&
        d.code.C(branch.end - 2) != 0) {
      final t = d.code.A(branch.end - 2);
      if (d.code.op(branch.end - 3) == _Op.jmp &&
          d.code.sBx(branch.end - 3) == 2) {
        expr = r.getValue(t, branch.end - 2);
      } else {
        expr = r.getValue(t, branch.begin);
      }
      branch.useExpression(expr);
      if (r.isLocal(t, branch.end - 1)) {
        return _Assignment.single(
            r.getTarget(t, branch.end - 1), branch.asExpression(r));
      }
      r.setValue(t, branch.end - 1, branch.asExpression(r));
    } else if (expr != null && target >= 0) {
      branch.useExpression(expr);
      if (r.isLocal(target, branch.end - 1)) {
        return _Assignment.single(
            r.getTarget(target, branch.end - 1), branch.asExpression(r));
      }
      r.setValue(target, branch.end - 1, branch.asExpression(r));
    }
    return null;
  }
}
