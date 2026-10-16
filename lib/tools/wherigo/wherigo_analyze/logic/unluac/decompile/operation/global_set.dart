part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _GlobalSet extends _Operation {
  final String global;
  final _Expression value;

  _GlobalSet(super.line, this.global, this.value);

  @override
  _Statement? process(_Registers r, _Block block) {
    return _Assignment.single(_GlobalTarget(global), value);
  }
}
