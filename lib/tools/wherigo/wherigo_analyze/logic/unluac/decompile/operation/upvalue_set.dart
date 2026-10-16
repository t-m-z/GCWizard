part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _UpvalueSet extends _Operation {
  final _UpvalueTarget target;
  final _Expression value;

  _UpvalueSet(super.line, String upvalue, this.value)
      : target = _UpvalueTarget(upvalue);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _Assignment.single(target, value);
  }
}
