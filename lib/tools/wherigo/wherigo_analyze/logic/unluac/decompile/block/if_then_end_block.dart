part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _IfThenEndBlock extends _Block {
  final _Branch branch;
  final _Stack<_Branch>? stack;
  final _Registers r;
  final List<_Statement> statements = [];

  _IfThenEndBlock(_LFunction function, this.branch, this.stack, this.r)
      : super(
    function,
    branch.begin == branch.end ? branch.begin - 1 : branch.begin,
    branch.begin == branch.end ? branch.begin - 1 : branch.end,
  );

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }

  @override
  bool breakable() => false;

  @override
  bool isContainer() => true;

  @override
  bool isUnprotected() => false;

  @override
  int getLoopback() => throw StateError('IfThenEndBlock has no loopback');

  @override
  void print(_Decompiler d, _Output out) {
    out.print('if ');
    branch.asExpression(r).print(d, out);
    out.print(' then');
    out.println();
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }

  @override
  _Operation process(_Decompiler d) {
    if (statements.length == 1) {
      final stmt = statements[0];
      if (stmt is _Assignment) {
        final assign = stmt;
        if (assign.getArity() == 1) {
          if (branch is _TestNode) {
            final node = branch as _TestNode;
            final decl = r.getDeclaration(node.test, node.line);
            if (assign.getFirstTarget().isDeclaration(decl)) {
              final _Expression expr;
              if (node.invert_) {
                expr = _BinaryExpression(
                    'or',
                    _LocalVariable(decl!),
                    assign.getFirstValue(),
                    _Expression.precedenceOr,
                    _Expression.associativityNone);
              } else {
                expr = _BinaryExpression(
                    'and',
                    _LocalVariable(decl!),
                    assign.getFirstValue(),
                    _Expression.precedenceAnd,
                    _Expression.associativityNone);
              }
              return _AssignSugarOperation(
                  end - 1, assign.getFirstTarget(), expr);
            }
          }
        }
      }
    } else if (statements.isEmpty && stack != null) {
      var test = branch.getRegister();
      if (test < 0) {
        for (var reg = 0; reg < r.registers; reg++) {
          if (r.getUpdated(reg, branch.end - 1) >= branch.begin) {
            if (test >= 0) {
              test = -1;
              break;
            }
            test = reg;
          }
        }
      }
      if (test >= 0) {
        if (r.getUpdated(test, branch.end - 1) >= branch.begin) {
          final right = r.getValue(test, branch.end);
          final setb = d.popSetCondition(stack!, stack!.peek().end, test);
          setb.useExpression(right);
          return _SetValueOperation(end - 1, test, branch.end - 1, setb);
        }
      }
    }
    return super.process(d);
  }
}

class _AssignSugarOperation extends _Operation {
  final _Target target;
  final _Expression expr;

  _AssignSugarOperation(super.line, this.target, this.expr);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _Assignment.single(target, expr);
  }
}

class _SetValueOperation extends _Operation {
  final int testreg;
  final int atLine;
  final _Branch setb;

  _SetValueOperation(super.line, this.testreg, this.atLine, this.setb);

  @override
  _Statement? process(_Registers r, _Block block) {
    r.setValue(testreg, atLine, setb.asExpression(r));
    return null;
  }
}
