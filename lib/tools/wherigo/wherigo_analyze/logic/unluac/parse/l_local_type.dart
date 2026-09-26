part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LLocalType extends _BObjectType<_LLocal> {
  @override
  _LLocal parse(_ByteReader buffer, _BHeader header) {
    final name = header.string.parse(buffer, header);
    final start = header.integer.parse(buffer, header).asInt();
    final end = header.integer.parse(buffer, header).asInt();
    return _LLocal(name, start, end);
  }
}
