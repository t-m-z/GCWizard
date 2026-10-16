part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _FunctionCallStatement extends _Statement {
  final _FunctionCall call;

  _FunctionCallStatement(this.call);

  @override
  void print(_Decompiler d, _Output out) {
    call.print(d, out);
  }

  @override
  bool get beginsWithParen => call.beginsWithParen;
}
