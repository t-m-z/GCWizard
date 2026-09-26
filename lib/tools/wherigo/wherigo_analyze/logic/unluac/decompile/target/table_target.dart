part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TableTarget extends _Target {
  final _Expression table;
  final _Expression key;

  _TableTarget(this.table, this.key);

  @override
  void print(_Decompiler d, _Output out) {
    _TableReference(table, key).print(d, out);
  }

  @override
  void printMethod(_Decompiler d, _Output out) {
    table.print(d, out);
    out.print(':');
    out.print(key.asName());
  }

  @override
  bool get isFunctionName {
    if (!key.isIdentifier) return false;
    if (!table.isDotChain) return false;
    return true;
  }

  @override
  bool get beginsWithParen => table.isUngrouped || table.beginsWithParen;
}
