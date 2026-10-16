part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _BSizeTType extends _BObjectType<_BSizeT> {
  final int sizeTSize;
  late final _BIntegerType _integerType;

  _BSizeTType(this.sizeTSize) {
    _integerType = _BIntegerType(sizeTSize);
  }

  @override
  _BSizeT parse(_ByteReader buffer, _BHeader header) {
    final raw = _integerType.rawParse(buffer, header);
    return _BSizeT(raw.asInt());
  }
}
