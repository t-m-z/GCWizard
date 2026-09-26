part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ReturnOperation extends _Operation {
  final List<_Expression> values;

  _ReturnOperation(super.line, _Expression value) : values = [value];

  _ReturnOperation.multi(super.line, this.values);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _ReturnStatement(values);
  }
}
