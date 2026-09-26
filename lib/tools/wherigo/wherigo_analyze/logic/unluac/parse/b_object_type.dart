part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _BObjectType<T extends _BObject> {
  T parse(_ByteReader buffer, _BHeader header);

  _BList<T> parseList(_ByteReader buffer, _BHeader header) {
    final length = header.integer.parse(buffer, header).asInt();
    final values = <T>[];
    for (var i = 0; i < length; i++) {
      values.add(parse(buffer, header));
    }
    return _BList<T>(length, values);
  }
}
