import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lobject.dart';

class LNil extends LObject {
  static final LNil NIL = LNil._internal();

  LNil._internal();

  @override
  bool operator ==(Object other) {
    return identical(this, other);
  }

  int get hashCode => super.hashCode;
}