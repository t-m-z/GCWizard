part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Registers {
  final int registers;
  final int length;

  late final List<List<_Declaration?>> _decls;
  final _ConstantPool _f;
  late final List<List<_Expression?>> _values;
  late final List<List<int>> _updated;
  late final List<bool> _startedLines;

  _Registers(this.registers, this.length, List<_Declaration> declList, this._f) {
    _decls = List.generate(
        registers, (_) => List<_Declaration?>.filled(length + 1, null));
    for (final decl in declList) {
      var register = 0;
      while (_decls[register][decl.begin] != null) {
        register++;
      }
      decl.register = register;
      for (var line = decl.begin; line <= decl.end; line++) {
        _decls[register][line] = decl;
      }
    }
    _values = List.generate(
        registers, (_) => List<_Expression?>.filled(length + 1, null));
    for (var register = 0; register < registers; register++) {
      _values[register][0] = _Expression.nil;
    }
    _updated = List.generate(registers, (_) => List<int>.filled(length + 1, 0));
    _startedLines = List<bool>.filled(length + 1, false);
  }

  bool isAssignable(int register, int line) =>
      isLocal(register, line) && !_decls[register][line]!.forLoop;

  bool isLocal(int register, int line) {
    if (register < 0) return false;
    return _decls[register][line] != null;
  }

  bool isNewLocal(int register, int line) {
    final decl = _decls[register][line];
    return decl != null && decl.begin == line && !decl.forLoop;
  }

  List<_Declaration> getNewLocals(int line) {
    final locals = <_Declaration>[];
    for (var register = 0; register < registers; register++) {
      if (isNewLocal(register, line)) {
        locals.add(getDeclaration(register, line)!);
      }
    }
    return locals;
  }

  // Nullable, matching unluac's Registers.getDeclaration: some callers (e.g.
  // IfThenEndBlock.process) probe a register that may not hold a live local
  // at that line and are written to tolerate a null result.
  _Declaration? getDeclaration(int register, int line) => _decls[register][line];

  void startLine(int line) {
    _startedLines[line] = true;
    for (var register = 0; register < registers; register++) {
      _values[register][line] = _values[register][line - 1];
      _updated[register][line] = _updated[register][line - 1];
    }
  }

  _Expression getExpression(int register, int line) {
    if (isLocal(register, line - 1)) {
      return _LocalVariable(getDeclaration(register, line - 1)!);
    } else {
      return _values[register][line - 1]!;
    }
  }

  _Expression getKExpression(int register, int line) {
    if (_f.isConstant(register)) {
      return _f.getConstantExpression(_f.constantIndex(register));
    } else {
      return getExpression(register, line);
    }
  }

  _Expression getValue(int register, int line) => _values[register][line - 1]!;

  int getUpdated(int register, int line) => _updated[register][line];

  void setValue(int register, int line, _Expression expression) {
    _values[register][line] = expression;
    _updated[register][line] = line;
  }

  _Target getTarget(int register, int line) {
    if (!isLocal(register, line)) {
      throw StateError(
          'No declaration exists in register $register at line $line');
    }
    return _VariableTarget(_decls[register][line]!);
  }

  void setInternalLoopVariable(int register, int begin, int end) {
    var decl = _decls[register][begin];
    if (decl == null) {
      decl = _Declaration('_FOR_', begin, end);
      decl.register = register;
      _newDeclaration(decl, register, begin, end);
    }
    decl.forLoop = true;
  }

  void setExplicitLoopVariable(int register, int begin, int end) {
    var decl = _decls[register][begin];
    if (decl == null) {
      decl = _Declaration('_FORV_${register}_', begin, end);
      decl.register = register;
      _newDeclaration(decl, register, begin, end);
    }
    decl.forLoopExplicit = true;
  }

  void _newDeclaration(_Declaration decl, int register, int begin, int end) {
    for (var line = begin; line <= end; line++) {
      _decls[register][line] = decl;
    }
  }
}
