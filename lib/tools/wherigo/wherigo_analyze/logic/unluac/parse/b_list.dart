part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _BList<T extends _BObject> extends _BObject {
  final int length;
  final List<T> values;

  _BList(this.length, this.values);

  T get(int index) => values[index];

  List<T> asList() => values;
}
