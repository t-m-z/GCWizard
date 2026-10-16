part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Operation {
  final int line;

  _Operation(this.line);

  _Statement? process(_Registers r, _Block block);
}
