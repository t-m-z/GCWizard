part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Upvalues {
  final List<_LUpvalue> _upvalues;

  _Upvalues(_LFunction func, List<_Declaration>? parentDecls, int line)
      : _upvalues = func.upvalues {
    for (final upvalue in _upvalues) {
      if (upvalue.name == null || upvalue.name!.isEmpty) {
        if (upvalue.instack) {
          if (parentDecls != null) {
            for (final decl in parentDecls) {
              if (decl.register == upvalue.idx &&
                  line >= decl.begin &&
                  line < decl.end) {
                upvalue.name = decl.name;
                break;
              }
            }
          }
        } else {
          final parentvals = func.parent!.upvalues;
          if (upvalue.idx >= 0 && upvalue.idx < parentvals.length) {
            upvalue.name = parentvals[upvalue.idx].name;
          }
        }
      }
    }
  }

  String getName(int index) {
    if (index < _upvalues.length &&
        _upvalues[index].name != null &&
        _upvalues[index].name!.isNotEmpty) {
      return _upvalues[index].name!;
    } else {
      return '_UPVALUE${index}_';
    }
  }

  _UpvalueExpression getExpression(int index) =>
      _UpvalueExpression(getName(index));
}
