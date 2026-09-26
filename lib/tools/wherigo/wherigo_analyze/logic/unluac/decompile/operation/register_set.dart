part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _RegisterSet extends _Operation {
  final int register;
  final _Expression value;

  _RegisterSet(super.line, this.register, this.value);

  @override
  _Statement? process(_Registers r, _Block block) {
    r.setValue(register, line, value);
    if (r.isAssignable(register, line)) {
      return _Assignment.single(r.getTarget(register, line), value);
    } else {
      return null;
    }
  }
}
