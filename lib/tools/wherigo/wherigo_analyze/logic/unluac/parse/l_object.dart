part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _LObject extends _BObject {
  String deref() {
    throw StateError('LObject.deref() not supported on this type');
  }
}
