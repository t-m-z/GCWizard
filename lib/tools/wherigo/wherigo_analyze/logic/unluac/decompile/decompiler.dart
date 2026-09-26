part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// Mirrors unluac's `private static Stack<Branch> backup` — genuinely
/// process-global mutable state in the original, kept that way here.
_Stack<_Branch>? _backup;

class _Decompiler {
  late final int registers;
  late final int length;
  late final _Code code;
  late final _Upvalues upvalues;
  late final List<_Declaration> declList;

  late _ConstantPool f;
  late _LFunction function;
  late final List<_LFunction> functions;
  late final int params;
  late final int vararg;

  late final _Op? tforTarget;
  late final _Op? forTarget;

  _Decompiler(_LFunction function,
      [List<_Declaration>? parentDecls, int line = -1]) {
    f = _ConstantPool(function);
    this.function = function;
    registers = function.maximumStackSize;
    length = function.code.length;
    code = _Code(function);
    if (function.stripped) {
      declList = _VariableFinder.process(
          this, function.numParams, function.maximumStackSize);
    } else if (function.locals.length >= function.numParams) {
      declList = [
        for (final local in function.locals) _Declaration.fromLocal(local)
      ];
    } else {
      declList = [
        for (var i = 0; i < function.numParams; i++)
          _Declaration('_ARG_${i}_', 0, length - 1)
      ];
    }
    upvalues = _Upvalues(function, parentDecls, line);
    functions = function.functions;
    params = function.numParams;
    vararg = function.vararg;
    tforTarget = function.header.version.getTForTarget();
    forTarget = function.header.version.getForTarget();
  }

  _Configuration getConfiguration() => function.header.config;

  _Version getVersion() => function.header.version;

  late _Registers r;
  late _Block outer;

  void decompile() {
    r = _Registers(registers, length, declList, f);
    _findReverseTargets();
    _handleBranches(true);
    outer = _handleBranches(false);
    _processSequence(1, length);
  }

  void print(_Output out) {
    _handleInitialDeclares(out);
    outer.print(this, out);
  }

  void _handleInitialDeclares(_Output out) {
    final initdecls = <_Declaration>[];
    for (var i = params + (vararg & 1); i < declList.length; i++) {
      if (declList[i].begin == 0) {
        initdecls.add(declList[i]);
      }
    }
    if (initdecls.isNotEmpty) {
      out.print('local ');
      out.print(initdecls[0].name);
      for (var i = 1; i < initdecls.length; i++) {
        out.print(', ');
        out.print(initdecls[i].name);
      }
      out.println();
    }
  }

  int _fb2int50(int fb) => (fb & 7) << (fb >> 3);

  int _fb2int(int fb) {
    final exponent = (fb >> 3) & 0x1f;
    if (exponent == 0) {
      return fb;
    } else {
      return ((fb & 7) + 8) << (exponent - 1);
    }
  }

  List<_Operation> _processLine(int line) {
    final operations = <_Operation>[];
    var A = code.A(line);
    final B = code.B(line);
    var C = code.C(line);
    final Bx = code.Bx(line);
    switch (code.op(line)) {
      case _Op.move:
        operations.add(_RegisterSet(line, A, r.getExpression(B, line)));
        break;
      case _Op.loadk:
        operations.add(_RegisterSet(line, A, f.getConstantExpression(Bx)));
        break;
      case _Op.loadbool:
        operations.add(_RegisterSet(
            line,
            A,
            _ConstantExpression(
                _Constant(B != 0 ? _LBoolean.ltrue : _LBoolean.lfalse), -1)));
        break;
      case _Op.loadnil:
        {
          int maximum;
          if (function.header.version.usesOldLoadNilEncoding()) {
            maximum = B;
          } else {
            maximum = A + B;
          }
          while (A <= maximum) {
            operations.add(_RegisterSet(line, A, _Expression.nil));
            A++;
          }
          break;
        }
      case _Op.getupval:
        operations.add(_RegisterSet(line, A, upvalues.getExpression(B)));
        break;
      case _Op.gettabup:
        operations.add(_RegisterSet(
            line,
            A,
            _TableReference(
                upvalues.getExpression(B), r.getKExpression(C, line))));
        break;
      case _Op.getglobal:
        operations.add(_RegisterSet(line, A, f.getGlobalExpression(Bx)));
        break;
      case _Op.gettable:
        operations.add(_RegisterSet(
            line,
            A,
            _TableReference(
                r.getExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.setupval:
        operations.add(
            _UpvalueSet(line, upvalues.getName(B), r.getExpression(A, line)));
        break;
      case _Op.settabup:
        operations.add(_TableSet(line, upvalues.getExpression(A),
            r.getKExpression(B, line), r.getKExpression(C, line), true, line));
        break;
      case _Op.setglobal:
        operations.add(
            _GlobalSet(line, f.getGlobalName(Bx), r.getExpression(A, line)));
        break;
      case _Op.settable:
        operations.add(_TableSet(line, r.getExpression(A, line),
            r.getKExpression(B, line), r.getKExpression(C, line), true, line));
        break;
      case _Op.newtable:
        operations
            .add(_RegisterSet(line, A, _TableLiteral(_fb2int(B), _fb2int(C))));
        break;
      case _Op.newtable50:
        operations
            .add(_RegisterSet(line, A, _TableLiteral(_fb2int50(B), 1 << C)));
        break;
      case _Op.self:
        {
          // We can later determine if : syntax was used by comparing subexpressions with ==.
          final common = r.getExpression(B, line);
          operations.add(_RegisterSet(line, A + 1, common));
          operations.add(_RegisterSet(
              line, A, _TableReference(common, r.getKExpression(C, line))));
          break;
        }
      case _Op.add:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeADD(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.sub:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeSUB(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.mul:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeMUL(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.div:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeDIV(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.mod:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeMOD(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.pow:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makePOW(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.idiv:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeIDIV(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.band:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeBAND(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.bor:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeBOR(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.bxor:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeBXOR(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.shl:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeSHL(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.shr:
        operations.add(_RegisterSet(
            line,
            A,
            _Expression.makeSHR(
                r.getKExpression(B, line), r.getKExpression(C, line))));
        break;
      case _Op.unm:
        operations.add(
            _RegisterSet(line, A, _Expression.makeUNM(r.getExpression(B, line))));
        break;
      case _Op.not:
        operations.add(
            _RegisterSet(line, A, _Expression.makeNOT(r.getExpression(B, line))));
        break;
      case _Op.len:
        operations.add(
            _RegisterSet(line, A, _Expression.makeLEN(r.getExpression(B, line))));
        break;
      case _Op.bnot:
        operations.add(_RegisterSet(
            line, A, _Expression.makeBNOT(r.getExpression(B, line))));
        break;
      case _Op.concat:
        {
          _Expression value = r.getExpression(C, line);
          // CONCAT is right associative.
          while (C-- > B) {
            value = _Expression.makeCONCAT(r.getExpression(C, line), value);
          }
          operations.add(_RegisterSet(line, A, value));
          break;
        }
      case _Op.jmp:
      case _Op.eq:
      case _Op.lt:
      case _Op.le:
      case _Op.test:
      case _Op.testset:
      case _Op.test50:
      /* Do nothing ... handled with branches */
        break;
      case _Op.call:
        {
          var b = B;
          var c = C;
          final multiple = (c >= 3 || c == 0);
          if (b == 0) b = registers - A;
          if (c == 0) c = registers - A + 1;
          final fn = r.getExpression(A, line);
          final arguments = List<_Expression>.generate(
              b - 1, (i) => r.getExpression(A + 1 + i, line));
          final value = _FunctionCall(fn, arguments, multiple);
          if (c == 1) {
            operations.add(_CallOperation(line, value));
          } else {
            if (c == 2 && !multiple) {
              operations.add(_RegisterSet(line, A, value));
            } else {
              for (var register = A; register <= A + c - 2; register++) {
                operations.add(_RegisterSet(line, register, value));
              }
            }
          }
          break;
        }
      case _Op.tailcall:
        {
          var b = B;
          if (b == 0) b = registers - A;
          final fn = r.getExpression(A, line);
          final arguments = List<_Expression>.generate(
              b - 1, (i) => r.getExpression(A + 1 + i, line));
          final value = _FunctionCall(fn, arguments, true);
          operations.add(_ReturnOperation(line, value));
          skip[line + 1] = true;
          break;
        }
      case _Op.return_:
        {
          var b = B;
          if (b == 0) b = registers - A + 1;
          final values = List<_Expression>.generate(
              b - 1, (i) => r.getExpression(A + i, line));
          operations.add(_ReturnOperation.multi(line, values));
          break;
        }
      case _Op.forloop:
      case _Op.forprep:
      case _Op.tforprep:
      case _Op.tforcall:
      case _Op.tforloop:
      /* Do nothing ... handled with branches */
        break;
      case _Op.setlist50:
      case _Op.setlisto:
        {
          final table = r.getValue(A, line);
          final n = Bx % 32;
          for (var i = 1; i <= n + 1; i++) {
            operations.add(_TableSet(
                line,
                table,
                _ConstantExpression(_Constant.fromInt(Bx - n + i), -1),
                r.getExpression(A + i, line),
                false,
                r.getUpdated(A + i, line)));
          }
          break;
        }
      case _Op.setlist:
        {
          var b = B;
          var c = C;
          if (c == 0) {
            c = code.codepoint(line + 1);
            skip[line + 1] = true;
          }
          if (b == 0) {
            b = registers - A - 1;
          }
          final table = r.getValue(A, line);
          for (var i = 1; i <= b; i++) {
            operations.add(_TableSet(
                line,
                table,
                _ConstantExpression(_Constant.fromInt((c - 1) * 50 + i), -1),
                r.getExpression(A + i, line),
                false,
                r.getUpdated(A + i, line)));
          }
          break;
        }
      case _Op.close:
        break;
      case _Op.closure:
        {
          final closureFn = functions[Bx];
          operations.add(_RegisterSet(
              line, A, _ClosureExpression(closureFn, declList, line + 1)));
          if (function.header.version.usesInlineUpvalueDeclarations()) {
            for (var i = 0; i < closureFn.numUpvalues; i++) {
              skip[line + 1 + i] = true;
            }
          }
          break;
        }
      case _Op.vararg:
        {
          var b = B;
          final multiple = (b != 2);
          if (b == 1) throw StateError('Illegal VARARG encoding');
          if (b == 0) b = registers - A + 1;
          final value = _Vararg(b - 1, multiple);
          for (var register = A; register <= A + b - 2; register++) {
            operations.add(_RegisterSet(line, register, value));
          }
          break;
        }
      default:
        throw StateError('Illegal instruction: ${code.op(line)}');
    }
    return operations;
  }

  /// When lines are processed out of order, they are noted here so they can
  /// be skipped when encountered normally.
  late List<bool> skip;

  /// Precalculated: which lines are targets of backward jumps. Such targets
  /// must be at the statement/block level in the output (never mid-expression).
  late List<bool> reverseTarget;

  void _findReverseTargets() {
    reverseTarget = List<bool>.filled(length + 1, false);
    for (var line = 1; line <= length; line++) {
      if (code.op(line) == _Op.jmp && code.sBx(line) < 0) {
        reverseTarget[line + 1 + code.sBx(line)] = true;
      }
    }
  }

  _Assignment? _processOperation(
      _Operation operation, int line, int nextLine, _Block block) {
    _Assignment? assign;
    var wasMultiple = false;
    final stmt = operation.process(r, block);
    if (stmt != null) {
      if (stmt is _Assignment) {
        assign = stmt;
        if (!assign.getFirstValue().isMultiple) {
          block.addStatement(stmt);
        } else {
          wasMultiple = true;
        }
      } else {
        block.addStatement(stmt);
      }
      if (assign != null) {
        var next = nextLine;
        while (next < block.end && _isMoveIntoTarget(next)) {
          final target = _getMoveIntoTargetTarget(next, line + 1);
          final value = _getMoveIntoTargetValue(next, line + 1);
          assign.addFirst(target, value);
          skip[next] = true;
          next++;
        }
        if (wasMultiple && !assign.getFirstValue().isMultiple) {
          block.addStatement(stmt);
        }
      }
    }
    return assign;
  }

  void _processSequence(int begin, int end) {
    var blockIndex = 1;
    final blockStack = _Stack<_Block>();
    blockStack.push(blocks[0]);
    skip = List<bool>.filled(end + 1, false);
    for (var line = begin; line <= end; line++) {
      _Operation? blockHandler;
      while (blockStack.peek().end <= line) {
        final block = blockStack.pop();
        blockHandler = block.process(this);
        // block.process() never actually returns null in this hierarchy,
        // but the check is kept for parity with the Java original.
        // ignore: unnecessary_null_comparison
        if (blockHandler != null) {
          break;
        }
      }
      if (blockHandler == null) {
        while (blockIndex < blocks.length && blocks[blockIndex].begin <= line) {
          blockStack.push(blocks[blockIndex++]);
        }
      }
      final block = blockStack.peek();
      r.startLine(line); // Must occur AFTER block.rewrite
      if (skip[line]) {
        final newLocals = r.getNewLocals(line);
        if (newLocals.isNotEmpty) {
          final assign = _Assignment();
          assign.declare(newLocals[0].begin);
          for (final decl in newLocals) {
            assign.addLast(
                _VariableTarget(decl), r.getValue(decl.register, line));
          }
          blockStack.peek().addStatement(assign);
        }
        continue;
      }
      final operations = _processLine(line);
      var newLocals = r.getNewLocals(blockHandler == null ? line : line - 1);
      _Assignment? assign;
      if (blockHandler == null) {
        if (code.op(line) == _Op.loadnil) {
          assign = _Assignment();
          var count = 0;
          for (final operation in operations) {
            final set = operation as _RegisterSet;
            operation.process(r, block);
            if (r.isAssignable(set.register, set.line)) {
              assign.addLast(r.getTarget(set.register, set.line), set.value);
              count++;
            }
          }
          if (count > 0) {
            block.addStatement(assign);
          }
        } else if (code.op(line) == _Op.tforprep) {
          // Lua 5.0 FORPREP - no assignments.
          newLocals = const [];
        } else {
          for (final operation in operations) {
            final temp = _processOperation(operation, line, line + 1, block);
            if (temp != null) {
              assign = temp;
            }
          }
          if (assign != null && assign.getFirstValue().isMultiple) {
            block.addStatement(assign);
          }
        }
      } else {
        assign = _processOperation(blockHandler, line, line, block);
      }
      if (assign != null) {
        if (newLocals.isNotEmpty) {
          assign.declare(newLocals[0].begin);
          for (final decl in newLocals) {
            assign.addLast(
                _VariableTarget(decl), r.getValue(decl.register, line + 1));
          }
        }
      }
      if (blockHandler == null) {
        if (assign != null) {
          // handled above
        } else if (newLocals.isNotEmpty && code.op(line) != _Op.forprep) {
          if (code.op(line) != _Op.jmp ||
              code.op(line + 1 + code.sBx(line)) != tforTarget) {
            final a = _Assignment();
            a.declare(newLocals[0].begin);
            for (final decl in newLocals) {
              a.addLast(_VariableTarget(decl), r.getValue(decl.register, line));
            }
            blockStack.peek().addStatement(a);
          }
        }
      }
      if (blockHandler != null) {
        line--;
        continue;
      }
    }
  }

  bool _isMoveIntoTarget(int line) {
    switch (code.op(line)) {
      case _Op.move:
        return r.isAssignable(code.A(line), line) &&
            !r.isLocal(code.B(line), line);
      case _Op.setupval:
      case _Op.setglobal:
        return !r.isLocal(code.A(line), line);
      case _Op.settable:
      case _Op.settabup:
        {
          final c = code.C(line);
          if (f.isConstant(c)) {
            return false;
          } else {
            return !r.isLocal(c, line);
          }
        }
      default:
        return false;
    }
  }

  _Target _getMoveIntoTargetTarget(int line, int previous) {
    switch (code.op(line)) {
      case _Op.move:
        return r.getTarget(code.A(line), line);
      case _Op.setupval:
        return _UpvalueTarget(upvalues.getName(code.B(line)));
      case _Op.setglobal:
        return _GlobalTarget(f.getGlobalName(code.Bx(line)));
      case _Op.settable:
        return _TableTarget(r.getExpression(code.A(line), previous),
            r.getKExpression(code.B(line), previous));
      case _Op.settabup:
        {
          final A = code.A(line);
          final B = code.B(line);
          return _TableTarget(
              upvalues.getExpression(A), r.getKExpression(B, previous));
        }
      default:
        throw StateError('Illegal move-into-target opcode: ${code.op(line)}');
    }
  }

  _Expression _getMoveIntoTargetValue(int line, int previous) {
    final A = code.A(line);
    final C = code.C(line);
    switch (code.op(line)) {
      case _Op.move:
        return r.getValue(code.B(line), previous);
      case _Op.setupval:
      case _Op.setglobal:
        return r.getExpression(A, previous);
      case _Op.settable:
      case _Op.settabup:
        if (f.isConstant(C)) {
          throw StateError(
              'Constant operand cannot be a move-into-target value');
        } else {
          return r.getExpression(C, previous);
        }
      default:
        throw StateError('Illegal move-into-target opcode: ${code.op(line)}');
    }
  }

  late List<_Block> blocks;

  _OuterBlock _handleBranches(bool first) {
    final oldBlocks = first ? const <_Block>[] : blocks;
    blocks = <_Block>[];
    final outerBlock = _OuterBlock(function, length);
    blocks.add(outerBlock);
    final isBreak = List<bool>.filled(length + 1, false);
    final loopRemoved = List<bool>.filled(length + 1, false);
    if (!first) {
      for (final block in oldBlocks) {
        if (block is _AlwaysLoop) {
          blocks.add(block);
        }
        if (block is _BreakBlock) {
          blocks.add(block);
          isBreak[block.begin] = true;
        }
      }
      final delete = <_Block>[];
      for (final block in blocks) {
        if (block is _AlwaysLoop) {
          for (final block2 in blocks) {
            if (!identical(block, block2)) {
              if (block.begin == block2.begin) {
                if (block.end < block2.end) {
                  delete.add(block);
                  loopRemoved[block.end - 1] = true;
                } else {
                  delete.add(block2);
                  loopRemoved[block2.end - 1] = true;
                }
              }
            }
          }
        }
      }
      for (final block in delete) {
        blocks.remove(block);
      }
    }
    skip = List<bool>.filled(length + 1, false);
    final stack = _Stack<_Branch>();
    var reduce = false;
    var testset = false;
    var testsetend = -1;
    for (var line = 1; line <= length; line++) {
      if (!skip[line]) {
        switch (code.op(line)) {
          case _Op.eq:
            {
              final node = _EQNode(code.B(line), code.C(line), code.A(line) != 0,
                  line, line + 2, line + 2 + code.sBx(line + 1));
              stack.push(node);
              skip[line + 1] = true;
              if (code.op(node.end) == _Op.loadbool) {
                if (code.C(node.end) != 0) {
                  node.isCompareSet = true;
                  node.setTarget = code.A(node.end);
                } else if (node.end - 1 >= 1 &&
                    code.op(node.end - 1) == _Op.loadbool) {
                  if (code.C(node.end - 1) != 0) {
                    node.isCompareSet = true;
                    node.setTarget = code.A(node.end);
                  }
                }
              }
              continue;
            }
          case _Op.lt:
            {
              final node = _LTNode(code.B(line), code.C(line), code.A(line) != 0,
                  line, line + 2, line + 2 + code.sBx(line + 1));
              stack.push(node);
              skip[line + 1] = true;
              if (code.op(node.end) == _Op.loadbool) {
                if (code.C(node.end) != 0) {
                  node.isCompareSet = true;
                  node.setTarget = code.A(node.end);
                } else if (node.end - 1 >= 1 &&
                    code.op(node.end - 1) == _Op.loadbool) {
                  if (code.C(node.end - 1) != 0) {
                    node.isCompareSet = true;
                    node.setTarget = code.A(node.end);
                  }
                }
              }
              continue;
            }
          case _Op.le:
            {
              final node = _LENode(code.B(line), code.C(line), code.A(line) != 0,
                  line, line + 2, line + 2 + code.sBx(line + 1));
              stack.push(node);
              skip[line + 1] = true;
              if (code.op(node.end) == _Op.loadbool) {
                if (code.C(node.end) != 0) {
                  node.isCompareSet = true;
                  node.setTarget = code.A(node.end);
                } else if (node.end - 1 >= 1 &&
                    code.op(node.end - 1) == _Op.loadbool) {
                  if (code.C(node.end - 1) != 0) {
                    node.isCompareSet = true;
                    node.setTarget = code.A(node.end);
                  }
                }
              }
              continue;
            }
          case _Op.test:
            stack.push(_TestNode(code.A(line), code.C(line) != 0, line, line + 2,
                line + 2 + code.sBx(line + 1)));
            skip[line + 1] = true;
            continue;
          case _Op.testset:
            testset = true;
            testsetend = line + 2 + code.sBx(line + 1);
            stack.push(_TestSetNode(
                code.A(line),
                code.B(line),
                code.C(line) != 0,
                line,
                line + 2,
                line + 2 + code.sBx(line + 1)));
            skip[line + 1] = true;
            continue;
          case _Op.test50:
            if (code.A(line) == code.B(line)) {
              stack.push(_TestNode(code.A(line), code.C(line) != 0, line,
                  line + 2, line + 2 + code.sBx(line + 1)));
            } else {
              testset = true;
              testsetend = line + 2 + code.sBx(line + 1);
              stack.push(_TestSetNode(
                  code.A(line),
                  code.B(line),
                  code.C(line) != 0,
                  line,
                  line + 2,
                  line + 2 + code.sBx(line + 1)));
            }
            skip[line + 1] = true;
            continue;
          case _Op.jmp:
            {
              reduce = true;
              final tline = line + 1 + code.sBx(line);
              if (tline >= 2 &&
                  code.op(tline - 1) == _Op.loadbool &&
                  code.C(tline - 1) != 0) {
                stack.push(
                    _TrueNode(code.A(tline - 1), false, line, line + 1, tline));
                skip[line + 1] = true;
              } else if (code.op(tline) == tforTarget && !skip[tline]) {
                final A = code.A(tline);
                final C = code.C(tline);
                if (C == 0) {
                  throw StateError('Illegal TFORLOOP/TFORCALL encoding');
                }
                r.setInternalLoopVariable(A, tline, line + 1);
                r.setInternalLoopVariable(A + 1, tline, line + 1);
                r.setInternalLoopVariable(A + 2, tline, line + 1);
                for (var index = 1; index <= C; index++) {
                  r.setExplicitLoopVariable(A + 2 + index, line, tline + 2);
                }
                skip[tline] = true;
                skip[tline + 1] = true;
                blocks.add(_TForBlock(function, line + 1, tline + 2, A, C, r));
              } else if (code.op(tline) == forTarget && !skip[tline]) {
                final A = code.A(tline);
                r.setInternalLoopVariable(A, tline, line + 1);
                r.setInternalLoopVariable(A + 1, tline, line + 1);
                r.setInternalLoopVariable(A + 2, tline, line + 1);
                skip[tline] = true;
                blocks.add(_ForBlock(function, line + 1, tline + 1, A, r));
              } else if (code.sBx(line) == 2 &&
                  code.op(line + 1) == _Op.loadbool &&
                  code.C(line + 1) != 0) {
                // This is the tail of a boolean set with a compare node and assign node.
                blocks.add(_BooleanIndicator(function, line));
              } else if (code.op(tline) == _Op.jmp &&
                  code.sBx(tline) + tline == line) {
                if (first) blocks.add(_AlwaysLoop(function, line, tline + 1));
                skip[tline] = true;
              } else {
                if (first || loopRemoved[line] || reverseTarget[line + 1]) {
                  if (!isBreak[line]) {
                    if (tline > line) {
                      isBreak[line] = true;
                      blocks.add(_BreakBlock(function, line, tline));
                    } else {
                      final enclosing = _enclosingBreakableBlock(line);
                      if (enclosing != null &&
                          enclosing.breakable() &&
                          code.op(enclosing.end) == _Op.jmp &&
                          code.sBx(enclosing.end) + enclosing.end + 1 ==
                              tline) {
                        isBreak[line] = true;
                        blocks.add(_BreakBlock(function, line, enclosing.end));
                      } else {
                        blocks.add(_AlwaysLoop(function, tline, line + 1));
                      }
                    }
                  }
                }
              }
              break;
            }
          case _Op.forprep:
            reduce = true;
            blocks.add(_ForBlock(function, line + 1, line + 2 + code.sBx(line),
                code.A(line), r));
            skip[line + 1 + code.sBx(line)] = true;
            r.setInternalLoopVariable(
                code.A(line), line, line + 2 + code.sBx(line));
            r.setInternalLoopVariable(
                code.A(line) + 1, line, line + 2 + code.sBx(line));
            r.setInternalLoopVariable(
                code.A(line) + 2, line, line + 2 + code.sBx(line));
            r.setExplicitLoopVariable(
                code.A(line) + 3, line, line + 2 + code.sBx(line));
            break;
          case _Op.forloop:
          /* Should be skipped by preceding FORPREP */
            throw StateError('Unexpected unguarded FORLOOP');
          case _Op.tforprep:
            {
              reduce = true;
              final tline = line + 1 + code.sBx(line);
              final A = code.A(tline);
              final C = code.C(tline);
              r.setInternalLoopVariable(A, tline, line + 1);
              r.setInternalLoopVariable(A + 1, tline, line + 1);
              r.setInternalLoopVariable(A + 2, tline, line + 1);
              for (var index = 1; index <= C; index++) {
                r.setExplicitLoopVariable(A + 2 + index, line, tline + 2);
              }
              skip[tline] = true;
              skip[tline + 1] = true;
              blocks.add(_TForBlock(function, line + 1, tline + 2, A, C, r));
              break;
            }
          default:
            reduce = _isStatement(line);
            break;
        }
      }

      if ((line + 1) <= length && reverseTarget[line + 1]) {
        reduce = true;
      }
      if (testset && testsetend == line + 1) {
        reduce = true;
      }
      if (stack.isEmpty) {
        reduce = false;
      }
      if (reduce) {
        reduce = false;
        final conditions = _Stack<_Branch>();
        final backups = _Stack<_Stack<_Branch>?>();
        do {
          var isAssignNode = stack.peek() is _TestSetNode;
          var assignEnd = stack.peek().end;
          var compareCorrect = false;
          if (stack.peek() is _TrueNode) {
            isAssignNode = true;
            compareCorrect = true;
            if (code.C(assignEnd) != 0) {
              assignEnd += 2;
            } else {
              assignEnd += 1;
            }
          } else if (stack.peek().isCompareSet) {
            if (code.op(stack.peek().begin) != _Op.loadbool ||
                code.C(stack.peek().begin) == 0) {
              isAssignNode = true;
              if (code.C(assignEnd) != 0) {
                assignEnd += 2;
              } else {
                assignEnd += 1;
              }
              compareCorrect = true;
            }
          } else if (assignEnd - 3 >= 1 &&
              code.op(assignEnd - 2) == _Op.loadbool &&
              code.C(assignEnd - 2) != 0 &&
              code.op(assignEnd - 3) == _Op.jmp &&
              code.sBx(assignEnd - 3) == 2) {
            final top = stack.peek();
            if (top is _TestNode) {
              if (top.test == code.A(assignEnd - 2)) {
                isAssignNode = true;
              }
            }
          } else if (assignEnd - 2 >= 1 &&
              code.op(assignEnd - 1) == _Op.loadbool &&
              code.C(assignEnd - 1) != 0 &&
              code.op(assignEnd - 2) == _Op.jmp &&
              code.sBx(assignEnd - 2) == 2) {
            if (stack.peek() is _TestNode) {
              isAssignNode = true;
              assignEnd += 1;
            }
          } else if (assignEnd - 1 >= 1 &&
              code.op(assignEnd) == _Op.loadbool &&
              code.C(assignEnd) != 0 &&
              code.op(assignEnd - 1) == _Op.jmp &&
              code.sBx(assignEnd - 1) == 2) {
            if (stack.peek() is _TestNode) {
              isAssignNode = true;
              assignEnd += 2;
            }
          } else if (assignEnd - 1 >= 1 &&
              r.isLocal(_getAssignment(assignEnd - 1), assignEnd - 1) &&
              assignEnd > stack.peek().line) {
            final decl = r.getDeclaration(
                _getAssignment(assignEnd - 1), assignEnd - 1)!;
            if (decl.begin == assignEnd - 1 && decl.end > assignEnd - 1) {
              isAssignNode = true;
            }
          }
          if (!compareCorrect &&
              assignEnd - 1 == stack.peek().begin &&
              code.op(stack.peek().begin) == _Op.loadbool &&
              code.C(stack.peek().begin) != 0) {
            _backup = null;
            final beginL = stack.peek().begin;
            assignEnd = beginL + 2;
            final target = code.A(beginL);
            conditions.push(_popCompareSetCondition(stack, assignEnd, target));
            conditions.peek().setTarget = target;
            conditions.peek().end = assignEnd;
            conditions.peek().begin = beginL;
          } else if (isAssignNode) {
            _backup = null;
            final target = stack.peek().setTarget;
            final beginL = stack.peek().begin;
            conditions.push(_popSetCondition(stack, assignEnd, target));
            conditions.peek().setTarget = target;
            conditions.peek().end = assignEnd;
            conditions.peek().begin = beginL;
          } else {
            _backup = _Stack<_Branch>();
            conditions.push(_popCondition(stack));
            _backup!.reverse();
          }
          backups.push(_backup);
        } while (!stack.isEmpty);
        do {
          final cond = conditions.pop();
          final theBackup = backups.pop();
          var breakTarget = _breakTarget(cond.begin);
          final breakable = (breakTarget >= 1);
          if (breakable &&
              code.op(breakTarget) == _Op.jmp &&
              breakTarget != cond.end) {
            breakTarget += 1 + code.sBx(breakTarget);
          }
          if (breakable && breakTarget == cond.end) {
            final immediateEnclosing = _enclosingBlock(cond.begin);
            final breakableEnclosing = _enclosingBreakableBlock(cond.begin);
            var loopstart = immediateEnclosing.end;
            if (identical(immediateEnclosing, breakableEnclosing)) loopstart--;
            for (var iline = loopstart;
            iline >=
                (cond.begin > immediateEnclosing.begin
                    ? cond.begin
                    : immediateEnclosing.begin);
            iline--) {
              if (code.op(iline) == _Op.jmp &&
                  iline + 1 + code.sBx(iline) == breakTarget) {
                cond.end = iline;
                break;
              }
            }
          }
          // A branch has a tail if the instruction just before the end target is JMP.
          var hasTail = cond.end >= 2 && code.op(cond.end - 1) == _Op.jmp;
          // This is the target of the tail JMP.
          var tail = hasTail ? cond.end + code.sBx(cond.end - 1) : -1;
          final originalTail = tail;
          final enclosing = _enclosingUnprotectedBlock(cond.begin);
          // Checking enclosing unprotected block to undo JMP redirects.
          if (enclosing != null) {
            if (enclosing.getLoopback() == cond.end) {
              cond.end = enclosing.end - 1;
              hasTail = cond.end >= 2 && code.op(cond.end - 1) == _Op.jmp;
              tail = hasTail ? cond.end + code.sBx(cond.end - 1) : -1;
            }
            if (hasTail && enclosing.getLoopback() == tail) {
              tail = enclosing.end - 1;
            }
          }
          if (cond.isSet) {
            var empty = cond.begin == cond.end;
            if (code.op(cond.begin) == _Op.jmp &&
                code.sBx(cond.begin) == 2 &&
                code.op(cond.begin + 1) == _Op.loadbool &&
                code.C(cond.begin + 1) != 0) {
              empty = true;
            }
            blocks.add(_SetBlock(function, cond, cond.setTarget, line,
                cond.begin, cond.end, empty, r));
          } else if (code.op(cond.begin) == _Op.loadbool &&
              code.C(cond.begin) != 0) {
            final beginL = cond.begin;
            final target = code.A(beginL);
            var c = cond;
            if (code.B(beginL) == 0) {
              c = cond.invert();
            }
            blocks.add(_CompareBlock(function, beginL, beginL + 2, target, c));
          } else if (cond.end < cond.begin) {
            if (isBreak[cond.end - 1]) {
              skip[cond.end - 1] = true;
              blocks.add(_WhileBlock(function, cond.invert(), originalTail, r));
            } else {
              blocks.add(_RepeatBlock(function, cond, r));
            }
          } else if (hasTail) {
            final endOp = code.op(cond.end - 2);
            final isEndCondJump = endOp == _Op.eq ||
                endOp == _Op.le ||
                endOp == _Op.lt ||
                endOp == _Op.test ||
                endOp == _Op.testset ||
                endOp == _Op.test50;
            if (tail > cond.end || (tail == cond.end && !isEndCondJump)) {
              final op = code.op(tail - 1);
              final sbx = code.sBx(tail - 1);
              final loopback2 = tail + sbx;
              final isBreakableLoopEnd =
              function.header.version.isBreakableLoopEnd(op);
              if (isBreakableLoopEnd &&
                  loopback2 <= cond.begin &&
                  !isBreak[tail - 1]) {
                // (ends with break)
                blocks.add(_IfThenEndBlock(function, cond, theBackup, r));
              } else {
                skip[cond.end - 1] = true; // Skip the JMP over the else block.
                final emptyElse = tail == cond.end;
                final ifthen =
                _IfThenElseBlock(function, cond, originalTail, emptyElse, r);
                blocks.add(ifthen);
                if (!emptyElse) {
                  final elseend = _ElseEndBlock(function, cond.end, tail);
                  blocks.add(elseend);
                }
              }
            } else {
              final loopback = tail;
              var existsStatement = false;
              for (var sl = loopback; sl < cond.begin; sl++) {
                if (!skip[sl] && _isStatement(sl)) {
                  existsStatement = true;
                  break;
                }
              }
              if (loopback >= cond.begin || existsStatement) {
                blocks.add(_IfThenEndBlock(function, cond, theBackup, r));
              } else {
                skip[cond.end - 1] = true;
                blocks.add(_WhileBlock(function, cond, originalTail, r));
              }
            }
          } else {
            blocks.add(_IfThenEndBlock(function, cond, theBackup, r));
          }
        } while (!conditions.isEmpty);
      }
    }
    // Find variables whose scope isn't controlled by existing blocks.
    for (final decl in declList) {
      if (!decl.forLoop && !decl.forLoopExplicit) {
        var needsDoEnd = true;
        for (final block in blocks) {
          if (block.contains(decl.begin)) {
            if (block.scopeEnd() == decl.end) {
              needsDoEnd = false;
              break;
            }
          }
        }
        if (needsDoEnd) {
          blocks.add(_DoEndBlock(function, decl.begin, decl.end + 1));
        }
      }
    }
    // Remove breaks that were later parsed as else jumps.
    blocks.removeWhere((block) => skip[block.begin] && block is _BreakBlock);
    blocks.sort();
    _backup = null;
    return outerBlock;
  }

  int _breakTarget(int line) {
    var tline = 1 << 30;
    for (final block in blocks) {
      if (block.breakable() && block.contains(line)) {
        if (block.end < tline) tline = block.end;
      }
    }
    if (tline == 1 << 30) return -1;
    return tline;
  }

  _Block _enclosingBlock(int line) {
    final outerBlock = blocks[0];
    var enclosing = outerBlock;
    for (var i = 1; i < blocks.length; i++) {
      final next = blocks[i];
      if (next.isContainer() &&
          enclosing.containsBlock(next) &&
          next.contains(line) &&
          !next.loopRedirectAdjustment) {
        enclosing = next;
      }
    }
    return enclosing;
  }

  _Block? _enclosingBreakableBlock(int line) {
    final outerBlock = blocks[0];
    var enclosing = outerBlock;
    for (var i = 1; i < blocks.length; i++) {
      final next = blocks[i];
      if (enclosing.containsBlock(next) &&
          next.contains(line) &&
          next.breakable() &&
          !next.loopRedirectAdjustment) {
        enclosing = next;
      }
    }
    return identical(enclosing, outerBlock) ? null : enclosing;
  }

  _Block? _enclosingUnprotectedBlock(int line) {
    final outerBlock = blocks[0];
    var enclosing = outerBlock;
    for (var i = 1; i < blocks.length; i++) {
      final next = blocks[i];
      if (enclosing.containsBlock(next) &&
          next.contains(line) &&
          next.isUnprotected() &&
          !next.loopRedirectAdjustment) {
        enclosing = next;
      }
    }
    return identical(enclosing, outerBlock) ? null : enclosing;
  }

  _Branch _popCondition(_Stack<_Branch> stack) {
    var branch = stack.pop();
    if (_backup != null) _backup!.push(branch);
    if (branch is _TestSetNode) {
      throw StateError('Unexpected TestSetNode in popCondition');
    }
    var begin = branch.begin;
    if (code.op(branch.begin) == _Op.jmp) {
      begin += 1 + code.sBx(branch.begin);
    }
    while (!stack.isEmpty) {
      final next = stack.peek();
      if (next is _TestSetNode) break;
      if (next.end == begin) {
        branch = _OrBranch(popCondition(stack).invert(), branch);
      } else if (next.end == branch.end) {
        branch = _AndBranch(popCondition(stack), branch);
      } else {
        break;
      }
    }
    return branch;
  }

  /// Public wrapper used by IfThenEndBlock.process, mirroring the Java
  /// method's package-visible access from the block package.
  _Branch popCondition(_Stack<_Branch> stack) => _popCondition(stack);

  _Branch _popSetCondition(_Stack<_Branch> stack, int assignEnd, int target) {
    stack.push(_AssignNode(assignEnd - 1, assignEnd, assignEnd));
    return _helperPopSetCondition(stack, false, assignEnd, target);
  }

  _Branch popSetCondition(_Stack<_Branch> stack, int assignEnd, int target) =>
      _popSetCondition(stack, assignEnd, target);

  _Branch _popCompareSetCondition(
      _Stack<_Branch> stack, int assignEnd, int target) {
    var top = stack.pop();
    var invert = false;
    if (code.B(top.begin) == 0) invert = true;
    top.begin = assignEnd;
    top.end = assignEnd;
    stack.push(top);
    return _helperPopSetCondition(stack, invert, assignEnd, target);
  }

  int _adjustLine(int line, int target) {
    var testline = line;
    while (testline >= 1 &&
        code.op(testline) == _Op.loadbool &&
        (target == -1 || code.A(testline) == target)) {
      testline--;
    }
    if (testline == line) {
      return testline;
    }
    testline++;
    if (code.C(testline) != 0) {
      return testline + 2;
    } else {
      return testline + 1;
    }
  }

  _Branch _helperPopSetCondition(
      _Stack<_Branch> stack, bool invert, int assignEnd, int target) {
    var branch = stack.pop();
    var begin = branch.begin;
    var end = branch.end;
    if (invert) {
      branch = branch.invert();
    }
    begin = _adjustLine(begin, target);
    end = _adjustLine(end, target);
    final btarget = branch.setTarget;
    while (!stack.isEmpty) {
      final next = stack.peek();
      bool ninvert;
      var nend = next.end;
      if (code.op(nend) == _Op.loadbool &&
          (target == -1 || code.A(nend) == target)) {
        ninvert = code.B(nend) != 0;
        nend = _adjustLine(nend, target);
      } else if (next is _TestSetNode) {
        ninvert = next.invert_;
      } else if (next is _TestNode) {
        ninvert = next.invert_;
      } else {
        ninvert = false;
        if (nend >= assignEnd) {
          break;
        }
      }
      final addr = (ninvert == invert) ? end : begin;
      if (addr == nend) {
        if (ninvert) {
          branch = _OrBranch(
              _helperPopSetCondition(stack, ninvert, assignEnd, target),
              branch);
        } else {
          branch = _AndBranch(
              _helperPopSetCondition(stack, ninvert, assignEnd, target),
              branch);
        }
        branch.end = nend;
      } else {
        if (branch is! _TestSetNode) {
          stack.push(branch);
          branch = _popCondition(stack);
        }
        break;
      }
    }
    branch.isSet = true;
    branch.setTarget = btarget;
    return branch;
  }

  bool _isStatement(int line, [int testRegister = -1]) {
    switch (code.op(line)) {
      case _Op.move:
      case _Op.loadk:
      case _Op.loadbool:
      case _Op.getupval:
      case _Op.gettabup:
      case _Op.getglobal:
      case _Op.gettable:
      case _Op.newtable:
      case _Op.newtable50:
      case _Op.add:
      case _Op.sub:
      case _Op.mul:
      case _Op.div:
      case _Op.mod:
      case _Op.pow:
      case _Op.unm:
      case _Op.not:
      case _Op.len:
      case _Op.idiv:
      case _Op.band:
      case _Op.bor:
      case _Op.bxor:
      case _Op.shl:
      case _Op.shr:
      case _Op.bnot:
      case _Op.concat:
      case _Op.closure:
        return r.isLocal(code.A(line), line) || code.A(line) == testRegister;
      case _Op.loadnil:
        for (var register = code.A(line);
        register <= code.B(line);
        register++) {
          if (r.isLocal(register, line)) {
            return true;
          }
        }
        return false;
      case _Op.setglobal:
      case _Op.setupval:
      case _Op.settabup:
      case _Op.settable:
      case _Op.jmp:
      case _Op.tailcall:
      case _Op.return_:
      case _Op.forloop:
      case _Op.forprep:
      case _Op.tforprep:
      case _Op.tforcall:
      case _Op.tforloop:
      case _Op.close:
        return true;
      case _Op.self:
        return r.isLocal(code.A(line), line) ||
            r.isLocal(code.A(line) + 1, line);
      case _Op.eq:
      case _Op.lt:
      case _Op.le:
      case _Op.test:
      case _Op.testset:
      case _Op.test50:
      case _Op.setlist:
      case _Op.setlisto:
      case _Op.setlist50:
        return false;
      case _Op.call:
        {
          final a = code.A(line);
          var c = code.C(line);
          if (c == 1) {
            return true;
          }
          if (c == 0) c = registers - a + 1;
          for (var register = a; register < a + c - 1; register++) {
            if (r.isLocal(register, line)) {
              return true;
            }
          }
          return (c == 2 && a == testRegister);
        }
      case _Op.vararg:
        {
          final a = code.A(line);
          var b = code.B(line);
          if (b == 0) b = registers - a + 1;
          for (var register = a; register < a + b - 1; register++) {
            if (r.isLocal(register, line)) {
              return true;
            }
          }
          return false;
        }
      default:
        throw StateError('Illegal opcode: ${code.op(line)}');
    }
  }

  /// Returns the single register assigned to at the line, or -1 if no
  /// register or multiple registers is/are assigned to.
  int _getAssignment(int line) {
    switch (code.op(line)) {
      case _Op.move:
      case _Op.loadk:
      case _Op.loadbool:
      case _Op.getupval:
      case _Op.gettabup:
      case _Op.getglobal:
      case _Op.gettable:
      case _Op.newtable:
      case _Op.newtable50:
      case _Op.add:
      case _Op.sub:
      case _Op.mul:
      case _Op.div:
      case _Op.mod:
      case _Op.pow:
      case _Op.unm:
      case _Op.not:
      case _Op.len:
      case _Op.idiv:
      case _Op.band:
      case _Op.bor:
      case _Op.bxor:
      case _Op.shl:
      case _Op.shr:
      case _Op.bnot:
      case _Op.concat:
      case _Op.closure:
        return code.A(line);
      case _Op.loadnil:
        if (code.A(line) == code.B(line)) {
          return code.A(line);
        } else {
          return -1;
        }
      case _Op.setglobal:
      case _Op.setupval:
      case _Op.settabup:
      case _Op.settable:
      case _Op.jmp:
      case _Op.tailcall:
      case _Op.return_:
      case _Op.forloop:
      case _Op.forprep:
      case _Op.tforcall:
      case _Op.tforloop:
      case _Op.close:
        return -1;
      case _Op.self:
        return -1;
      case _Op.eq:
      case _Op.lt:
      case _Op.le:
      case _Op.test:
      case _Op.testset:
      case _Op.setlist:
      case _Op.setlist50:
      case _Op.setlisto:
        return -1;
      case _Op.call:
        if (code.C(line) == 2) {
          return code.A(line);
        } else {
          return -1;
        }
      case _Op.vararg:
        if (code.C(line) == 2) {
          return code.B(line);
        } else {
          return -1;
        }
      default:
        throw StateError('Illegal opcode: ${code.op(line)}');
    }
  }
}
