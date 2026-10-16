part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Assignment extends _Statement {
  final List<_Target> targets = [];
  final List<_Expression> values = [];

  bool _allnil = true;
  bool _declare = false;
  int _declareStart = 0;

  _Assignment();

  _Assignment.single(_Target target, _Expression value) {
    targets.add(target);
    values.add(value);
    _allnil = _allnil && value.isNil;
  }

  @override
  bool get beginsWithParen => targets[0].beginsWithParen;

  _Target getFirstTarget() => targets[0];

  _Expression getFirstValue() => values[0];

  bool assignsTarget(_Declaration decl) {
    for (final target in targets) {
      if (target.isDeclaration(decl)) return true;
    }
    return false;
  }

  int getArity() => targets.length;

  void addFirst(_Target target, _Expression value) {
    targets.insert(0, target);
    values.insert(0, value);
    _allnil = _allnil && value.isNil;
  }

  void addLast(_Target target, _Expression value) {
    var v = value;
    final index = targets.indexOf(target);
    if (index >= 0) {
      targets.removeAt(index);
      v = values.removeAt(index);
    }
    targets.add(target);
    values.add(v);
    _allnil = _allnil && v.isNil;
  }

  bool assignListEquals(List<_Declaration> decls) {
    if (decls.length != targets.length) return false;
    for (final target in targets) {
      var found = false;
      for (final decl in decls) {
        if (target.isDeclaration(decl)) {
          found = true;
          break;
        }
      }
      if (!found) return false;
    }
    return true;
  }

  void declare(int declareStart) {
    _declare = true;
    _declareStart = declareStart;
  }

  @override
  void print(_Decompiler d, _Output out) {
    if (targets.isNotEmpty) {
      if (_declare) {
        out.print('local ');
      }
      var functionSugar = false;
      if (targets.length == 1 &&
          values.length == 1 &&
          values[0].isClosure &&
          targets[0].isFunctionName) {
        final closure = values[0];
        if (!_declare || _declareStart >= closure.closureUpvalueLine()) {
          functionSugar = true;
        }
        if (targets[0].isLocal && closure.isUpvalueOf(targets[0].index)) {
          functionSugar = true;
        }
      }
      if (!functionSugar) {
        targets[0].print(d, out);
        for (var i = 1; i < targets.length; i++) {
          out.print(', ');
          targets[i].print(d, out);
        }
        if (!_declare || !_allnil) {
          out.print(' = ');
          _Expression.printSequence(d, out, values, false, false);
        }
      } else {
        values[0].printClosure(d, out, targets[0]);
      }
      if (comment != null) {
        out.print(' -- ');
        out.print(comment!);
      }
    }
  }
}
