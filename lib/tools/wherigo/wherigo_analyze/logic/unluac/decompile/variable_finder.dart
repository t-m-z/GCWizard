part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _RegisterState {
  bool temporary = false;
  bool local = false;
  bool read = false;
  bool written = false;
}

class _RegisterStates {
  final int registers;
  final int lines;
  final List<List<_RegisterState>> states;

  _RegisterStates(this.registers, this.lines)
      : states = List.generate(
            lines, (_) => List.generate(registers, (_) => _RegisterState()));

  _RegisterState get(int register, int line) => states[line - 1][register];

  void setLocal(int register, int line) {
    for (var r = 0; r <= register; r++) {
      get(r, line).local = true;
    }
  }

  void setTemporary(int register, int line) {
    for (var r = register; r < registers; r++) {
      get(r, line).temporary = true;
    }
  }
}

bool _isConstantReference(int value) => (value & 0x100) != 0;

/// Monotonic counter used to keep synthesized local names unique across a
/// whole decompilation run (mirrors unluac's static VariableFinder.lc).
int _lc = 0;

class _VariableFinder {
  static List<_Declaration> process(_Decompiler d, int args, int registers) {
    final code = d.code;
    final states = _RegisterStates(registers, code.length());
    final skip = List<bool>.filled(code.length(), false);
    for (var line = 1; line <= code.length(); line++) {
      if (skip[line - 1]) continue;
      final op = code.op(line);
      switch (op) {
        case _Op.move:
          states.get(code.A(line), line).written = true;
          states.get(code.B(line), line).read = true;
          states.setLocal(
              code.A(line) < code.B(line) ? code.A(line) : code.B(line), line);
          break;
        case _Op.loadk:
        case _Op.loadbool:
        case _Op.getupval:
        case _Op.getglobal:
        case _Op.newtable:
        case _Op.newtable50:
          states.get(code.A(line), line).written = true;
          break;
        case _Op.loadnil:
          for (var register = code.A(line);
              register <= code.B(line);
              register++) {
            states.get(register, line).written = true;
          }
          break;
        case _Op.gettable:
          states.get(code.A(line), line).written = true;
          if (!_isConstantReference(code.B(line))) {
            states.get(code.B(line), line).read = true;
          }
          if (!_isConstantReference(code.C(line))) {
            states.get(code.C(line), line).read = true;
          }
          break;
        case _Op.setglobal:
        case _Op.setupval:
          states.get(code.A(line), line).read = true;
          break;
        case _Op.settable:
        case _Op.add:
        case _Op.sub:
        case _Op.mul:
        case _Op.div:
        case _Op.mod:
        case _Op.pow:
          states.get(code.A(line), line).read = true;
          if (!_isConstantReference(code.B(line))) {
            states.get(code.B(line), line).read = true;
          }
          if (!_isConstantReference(code.C(line))) {
            states.get(code.C(line), line).read = true;
          }
          break;
        case _Op.self:
          states.get(code.A(line), line).written = true;
          states.get(code.A(line) + 1, line).written = true;
          states.get(code.B(line), line).read = true;
          if (!_isConstantReference(code.C(line))) {
            states.get(code.C(line), line).read = true;
          }
          break;
        case _Op.unm:
        case _Op.not:
        case _Op.len:
          states.get(code.A(line), line).written = true;
          states.get(code.B(line), line).read = true;
          break;
        case _Op.concat:
          states.get(code.A(line), line).written = true;
          for (var register = code.B(line);
              register <= code.C(line);
              register++) {
            states.get(register, line).read = true;
            states.setTemporary(register, line);
          }
          break;
        case _Op.setlist:
          states.setTemporary(code.A(line) + 1, line);
          break;
        case _Op.jmp:
          break;
        case _Op.eq:
        case _Op.lt:
        case _Op.le:
          if (!_isConstantReference(code.B(line))) {
            states.get(code.B(line), line).read = true;
          }
          if (!_isConstantReference(code.C(line))) {
            states.get(code.C(line), line).read = true;
          }
          break;
        case _Op.test:
          states.get(code.A(line), line).read = true;
          break;
        case _Op.testset:
          states.get(code.A(line), line).written = true;
          states.get(code.B(line), line).read = true;
          break;
        case _Op.closure:
          final f = d.function.functions[code.Bx(line)];
          for (final _LUpvalue upvalue in f.upvalues) {
            if (upvalue.instack) {
              states.setLocal(upvalue.idx, line);
            }
          }
          break;
        case _Op.call:
        case _Op.tailcall:
          {
            final B = code.B(line);
            var C = code.C(line);
            if (code.op(line) != _Op.tailcall) {
              if (C >= 2) {
                for (var register = code.A(line);
                    register <= code.A(line) + C - 2;
                    register++) {
                  states.get(register, line).written = true;
                }
              }
            }
            for (var register = code.A(line);
                register <= code.A(line) + B - 1;
                register++) {
              states.get(code.A(line), line).read = true;
              states.setTemporary(code.A(line), line);
            }
            if (C >= 2) {
              var nline = line + 1;
              var register = code.A(line) + C - 2;
              while (register >= code.A(line) && nline <= code.length()) {
                if (code.op(nline) == _Op.move && code.B(nline) == register) {
                  states.get(code.A(nline), nline).written = true;
                  states.get(code.B(nline), nline).read = true;
                  states.setLocal(code.A(nline), nline);
                  skip[nline - 1] = true;
                }
                register--;
                nline++;
              }
            }
            break;
          }
        default:
          break;
      }
    }
    final declList = <_Declaration>[];
    for (var register = 0; register < registers; register++) {
      var id = 'L';
      var local = false;
      var temporary = false;
      var read = 0;
      if (register < args) {
        local = true;
        id = 'A';
      }
      if (!local && !temporary) {
        for (var line = 1; line <= code.length(); line++) {
          final state = states.get(register, line);
          if (state.local) local = true;
          if (state.temporary) temporary = true;
          if (state.read) read++;
          // `written` is tracked in _RegisterState for parity with unluac's
          // VariableFinder but (as in the original) never actually factors
          // into the locality decision below.
        }
      }
      if (!local && !temporary) {
        if (read >= 2 || read == 0) {
          local = true;
        }
      }
      if (local) {
        final decl = _Declaration('$id${register}_$_lc', 0,
            code.length() + d.getVersion().getOuterBlockScopeAdjustment());
        decl.register = register;
        _lc++;
        declList.add(decl);
      }
    }
    return declList;
  }
}
