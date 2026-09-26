part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _ParseStateLHeader {
  late _BIntegerType integer;
  late _BSizeTType sizeT;
  _LNumberType? number;
  _LNumberType? linteger;
  _LNumberType? lfloat;
  late _LStringType string;
  late _LConstantType constant;
  late _LFunctionType function;
  late _CodeExtract extractor;

  int format = 0;

  int lNumberSize = 0;
  bool lNumberIntegrality = false;

  int lIntegerSize = 0;
  int lFloatSize = 0;
}

abstract class _LHeaderType extends _BObjectType<_LHeader> {
  static final _LHeaderType type50 = _LHeaderType50();
  static final _LHeaderType type51 = _LHeaderType51();
  static final _LHeaderType type52 = _LHeaderType52();
  static final _LHeaderType type53 = _LHeaderType53();

  static const List<int> _luacTail = [0x19, 0x93, 0x0D, 0x0A, 0x1A, 0x0A];

  @override
  _LHeader parse(_ByteReader buffer, _BHeader header) {
    final s = _ParseStateLHeader();
    parseMain(buffer, header, s);
    final bool = _LBooleanType();
    final local = _LLocalType();
    final upvalue = _LUpvalueType();
    return _LHeader(
        s.format,
        s.integer,
        s.sizeT,
        bool,
        s.number,
        s.linteger,
        s.lfloat,
        s.string,
        s.constant,
        local,
        upvalue,
        s.function,
        s.extractor);
  }

  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLHeader s);

  void parseFormat(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final format = buffer.get() & 0xFF;
    if (format != 0) {
      throw StateError(
          'The input chunk reports a non-standard lua format: $format');
    }
    s.format = format;
  }

  void parseEndianness(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final endianness = buffer.get() & 0xFF;
    switch (endianness) {
      case 0:
        buffer.order = Endian.big;
        break;
      case 1:
        buffer.order = Endian.little;
        break;
      default:
        throw StateError(
            'The input chunk reports an invalid endianness: $endianness');
    }
  }

  void parseIntSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final intSize = buffer.get() & 0xFF;
    s.integer = _BIntegerType(intSize);
  }

  void parseSizeTSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final sizeTSize = buffer.get() & 0xFF;
    s.sizeT = _BSizeTType(sizeTSize);
  }

  void parseInstructionSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final instructionSize = buffer.get() & 0xFF;
    if (instructionSize != 4) {
      throw StateError(
          'The input chunk reports an unsupported instruction size: $instructionSize bytes');
    }
  }

  void parseNumberSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    s.lNumberSize = buffer.get() & 0xFF;
  }

  void parseNumberIntegrality(
      _ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final code = buffer.get() & 0xFF;
    if (code > 1) {
      throw StateError(
          'The input chunk reports an invalid code for lua number integrality: $code');
    }
    s.lNumberIntegrality = code == 1;
  }

  void parseExtractor(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final sizeOp = buffer.get() & 0xFF;
    final sizeA = buffer.get() & 0xFF;
    final sizeB = buffer.get() & 0xFF;
    final sizeC = buffer.get() & 0xFF;
    s.extractor = _Code50(sizeOp, sizeA, sizeB, sizeC);
  }

  void parseTail(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    for (var i = 0; i < _luacTail.length; i++) {
      if ((buffer.get() & 0xFF) != _luacTail[i]) {
        throw StateError(
            'The input file does not have the header tail of a valid Lua file (it may be corrupted).');
      }
    }
  }
}

class _LHeaderType50 extends _LHeaderType {
  static const double _testNumber = 3.14159265358979323846E7;

  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    s.format = 0;
    parseEndianness(buffer, header, s);
    parseIntSize(buffer, header, s);
    parseSizeTSize(buffer, header, s);
    parseInstructionSize(buffer, header, s);
    parseExtractor(buffer, header, s);
    parseNumberSize(buffer, header, s);
    final lfloat = _LNumberType(s.lNumberSize, false, _NumberMode.modeNumber);
    final linteger = _LNumberType(s.lNumberSize, true, _NumberMode.modeNumber);
    buffer.mark();
    final floatcheck = lfloat.parse(buffer, header).value();
    buffer.reset();
    final intcheck = linteger.parse(buffer, header).value();
    if (floatcheck == lfloat.convert(_testNumber)) {
      s.number = lfloat;
    } else if (intcheck == linteger.convert(_testNumber)) {
      s.number = linteger;
    } else {
      throw StateError(
          'The input chunk is using an unrecognized number format: $intcheck');
    }
    s.function = _LFunctionType.type50;
    s.string = _LStringType.type50();
    s.constant = _LConstantType.type50();
  }
}

class _LHeaderType51 extends _LHeaderType {
  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    parseFormat(buffer, header, s);
    parseEndianness(buffer, header, s);
    parseIntSize(buffer, header, s);
    parseSizeTSize(buffer, header, s);
    parseInstructionSize(buffer, header, s);
    parseNumberSize(buffer, header, s);
    parseNumberIntegrality(buffer, header, s);
    s.number =
        _LNumberType(s.lNumberSize, s.lNumberIntegrality, _NumberMode.modeNumber);
    s.function = _LFunctionType.type51;
    s.string = _LStringType.type50();
    s.constant = _LConstantType.type50();
    s.extractor = _Code.code51;
  }
}

class _LHeaderType52 extends _LHeaderType {
  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    parseFormat(buffer, header, s);
    parseEndianness(buffer, header, s);
    parseIntSize(buffer, header, s);
    parseSizeTSize(buffer, header, s);
    parseInstructionSize(buffer, header, s);
    parseNumberSize(buffer, header, s);
    parseNumberIntegrality(buffer, header, s);
    parseTail(buffer, header, s);
    s.number =
        _LNumberType(s.lNumberSize, s.lNumberIntegrality, _NumberMode.modeNumber);
    s.function = _LFunctionType.type52;
    s.string = _LStringType.type50();
    s.constant = _LConstantType.type50();
    s.extractor = _Code.code51;
  }
}

class _LHeaderType53 extends _LHeaderType {
  void parseIntegerSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    final lIntegerSize = buffer.get() & 0xFF;
    if (lIntegerSize < 2) {
      throw StateError(
          'The input chunk reports an integer size that is too small: $lIntegerSize');
    }
    s.lIntegerSize = lIntegerSize;
  }

  void parseFloatSize(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    s.lFloatSize = buffer.get() & 0xFF;
  }

  @override
  void parseMain(_ByteReader buffer, _BHeader header, _ParseStateLHeader s) {
    parseFormat(buffer, header, s);
    parseTail(buffer, header, s);
    parseIntSize(buffer, header, s);
    parseSizeTSize(buffer, header, s);
    parseInstructionSize(buffer, header, s);
    parseIntegerSize(buffer, header, s);
    parseFloatSize(buffer, header, s);
    final endianness =
        List<int>.generate(s.lIntegerSize, (_) => buffer.get() & 0xFF);
    if (endianness[0] == 0x78 && endianness[1] == 0x56) {
      buffer.order = Endian.little;
    } else if (endianness[s.lIntegerSize - 1] == 0x78 &&
        endianness[s.lIntegerSize - 2] == 0x56) {
      buffer.order = Endian.big;
    } else {
      throw StateError(
          'The input chunk reports an invalid endianness: $endianness');
    }
    s.linteger = _LNumberType(s.lIntegerSize, true, _NumberMode.modeInteger);
    s.lfloat = _LNumberType(s.lFloatSize, false, _NumberMode.modeFloat);
    s.function = _LFunctionType.type53;
    s.string = _LStringType.type53();
    s.constant = _LConstantType.type53();
    s.extractor = _Code.code51;
    final floatcheck = s.lfloat!.parse(buffer, header).value();
    if (floatcheck != s.lfloat!.convert(370.5)) {
      throw StateError(
          'The input chunk is using an unrecognized floating point format: $floatcheck');
    }
  }
}
