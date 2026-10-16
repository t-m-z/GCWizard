part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _CallOperation extends _Operation {
  final _FunctionCall call;

  _CallOperation(super.line, this.call);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _FunctionCallStatement(call);
  }
}
