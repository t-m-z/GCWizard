part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LLocal extends _BObject {
  final _LString name;
  final int start;
  final int end;

  /// Used by the decompiler for annotation.
  bool forLoop = false;

  _LLocal(this.name, this.start, this.end);

  @override
  String toString() => name.deref();
}
