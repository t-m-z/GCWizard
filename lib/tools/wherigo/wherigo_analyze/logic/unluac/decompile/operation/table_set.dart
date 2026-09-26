part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TableSet extends _Operation {
  final _Expression table;
  final _Expression index;
  final _Expression value;
  final bool isTable;
  final int timestamp;

  _TableSet(super.line, this.table, this.index, this.value, this.isTable,
      this.timestamp);

  @override
  _Statement? process(_Registers r, _Block block) {
    // isTableLiteral is sufficient when there is debugging info.
    if (table.isTableLiteral && (value.isMultiple || table.isNewEntryAllowed)) {
      table.addEntry(_TableLiteralEntry(index, value, !isTable, timestamp));
      return null;
    } else {
      return _Assignment.single(_TableTarget(table, index), value);
    }
  }
}
