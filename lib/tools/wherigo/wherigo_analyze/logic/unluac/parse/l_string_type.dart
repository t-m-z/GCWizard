part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _LStringType extends _BObjectType<_LString> {
  _LStringType._();

  factory _LStringType.type50() = _LStringType50;
  factory _LStringType.type53() = _LStringType53;
}

class _LStringType50 extends _LStringType {
  _LStringType50() : super._();

  @override
  _LString parse(_ByteReader buffer, _BHeader header) {
    final size = header.sizeT.parse(buffer, header).asInt();
    final bytes = List<int>.generate(size, (_) => buffer.get() & 0xFF);
    final s = String.fromCharCodes(bytes);
    return _LString(size, s);
  }
}

class _LStringType53 extends _LStringType {
  _LStringType53() : super._();

  @override
  _LString parse(_ByteReader buffer, _BHeader header) {
    int size = buffer.get() & 0xFF;
    if (size == 0xFF) {
      size = header.sizeT.parse(buffer, header).asInt();
    }
    // `size` counts one more than the bytes actually stored (matching
    // Lua's convention of length+1, with 0 meaning empty); the first
    // "tick" of the original iteration is a no-op, so size-1 bytes follow.
    final bytes = <int>[];
    for (var i = 1; i < size; i++) {
      bytes.add(buffer.get() & 0xFF);
    }
    bytes.add(0);
    final s = String.fromCharCodes(bytes);
    return _LString(size, s);
  }
}
