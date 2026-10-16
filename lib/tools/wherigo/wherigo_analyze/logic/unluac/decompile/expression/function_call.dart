part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _FunctionCall extends _Expression {
  final _Expression function;
  final List<_Expression> arguments;
  final bool multiple;

  _FunctionCall(this.function, this.arguments, this.multiple)
      : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex {
    var index = function.constantIndex;
    for (final argument in arguments) {
      final a = argument.constantIndex;
      if (a > index) index = a;
    }
    return index;
  }

  @override
  bool get isMultiple => multiple;

  @override
  void printMultiple(_Decompiler d, _Output out) {
    if (!multiple) out.print('(');
    print(d, out);
    if (!multiple) out.print(')');
  }

  bool get _isMethodCall =>
      function.isMemberAccess &&
      arguments.isNotEmpty &&
      identical(function.table, arguments[0]);

  @override
  bool get beginsWithParen {
    if (_isMethodCall) {
      final obj = function.table;
      return obj.isUngrouped || obj.beginsWithParen;
    } else {
      return function.isUngrouped || function.beginsWithParen;
    }
  }

  @override
  void print(_Decompiler d, _Output out) {
    final args = <_Expression>[];
    if (_isMethodCall) {
      final obj = function.table;
      if (obj.isUngrouped) {
        out.print('(');
        obj.print(d, out);
        out.print(')');
      } else {
        obj.print(d, out);
      }
      out.print(':');
      out.print(function.field);
      for (var i = 1; i < arguments.length; i++) {
        args.add(arguments[i]);
      }
    } else {
      if (function.isUngrouped) {
        out.print('(');
        function.print(d, out);
        out.print(')');
      } else {
        function.print(d, out);
      }
      args.addAll(arguments);
    }
    out.print('(');
    _Expression.printSequence(d, out, args, false, true);
    out.print(')');
  }
}
