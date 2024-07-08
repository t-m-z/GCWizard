import 'dart:typed_data';

import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobjecttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bintegertype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bsizettype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lnumbertype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lstringtype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lconstanttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunctiontype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lbooleantype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/llocaltype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lupvaluetype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/code.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/code50.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/codeextract.dart';

abstract class LHeaderType extends BObjectType<LHeader> {
  static final LHeaderType TYPE50 = LHeaderType50();
  static final LHeaderType TYPE51 = LHeaderType51();
  static final LHeaderType TYPE52 = LHeaderType52();
  static final LHeaderType TYPE53 = LHeaderType53();

  static final List<int> luacTail = [
    0x19, 0x93, 0x0D, 0x0A, 0x1A, 0x0A,
  ];

  @override
  LHeader parse(ByteBuffer_ buffer, BHeader header) {
    var s = LHeaderParseState();
    parse_main(buffer, header, s);
    var bool = LBooleanType();
    var local = LLocalType();
    var upvalue = LUpvalueType();
    return LHeader(
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
      s.extractor,
    );
  }

  void parse_main(ByteBuffer_ buffer, BHeader header, LHeaderParseState s);

  void parse_format(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var format = buffer.getUint8();
    if (format != 0) {
      throw StateError('The input chunk reports a non-standard lua format: $format');
    }
    s.format = format;
    if (header.debug) {
      //print('-- format: $format');
    }
  }

  void parse_endianness(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var endianness = buffer.getUint8();
    switch (endianness) {
      case 0:
        buffer.order = Endian.big;
        break;
      case 1:
        buffer.order = Endian.little;
        break;
      default:
        throw StateError('The input chunk reports an invalid endianness: $endianness');
    }
    if (header.debug) {
      //print('-- endianness: $endianness ${endianness == 0 ? "(big)" : "(little)"}');
    }
  }

  void parse_int_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var intSize = buffer.getUint8();
    if (header.debug) {
      //print('-- int size: $intSize');
    }
    s.integer = BIntegerType(intSize);
  }

  void parse_size_t_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var sizeTSize = buffer.getUint8();
    if (header.debug) {
      //print('-- size_t size: $sizeTSize');
    }
    s.sizeT = BSizeTType(sizeTSize);
  }

  void parse_instruction_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var instructionSize = buffer.getUint8();
    if (header.debug) {
      //print('-- instruction size: $instructionSize');
    }
    if (instructionSize != 4) {
      throw StateError('The input chunk reports an unsupported instruction size: $instructionSize bytes');
    }
  }

  void parse_number_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var lNumberSize = buffer.getUint8();
    if (header.debug) {
      //print('-- Lua number size: $lNumberSize');
    }
    s.lNumberSize = lNumberSize;
  }

  void parse_number_integrality(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var lNumberIntegralityCode = buffer.getUint8();
    if (header.debug) {
      //print('-- Lua number integrality code: $lNumberIntegralityCode');
    }
    if (lNumberIntegralityCode > 1) {
      throw StateError('The input chunk reports an invalid code for lua number integrality: $lNumberIntegralityCode');
    }
    s.lNumberIntegrality = (lNumberIntegralityCode == 1);
  }

  void parse_extractor(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var sizeOp = buffer.getUint8();
    var sizeA = buffer.getUint8();
    var sizeB = buffer.getUint8();
    var sizeC = buffer.getUint8();
    if (header.debug) {
      //print('-- Lua opcode extractor sizeOp: $sizeOp, sizeA: $sizeA, sizeB: $sizeB, sizeC: $sizeC');
    }
    s.extractor = Code50(sizeOp, sizeA, sizeB, sizeC);
  }

  void parse_tail(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    for (var i = 0; i < luacTail.length; i++) {
      if (buffer.getUint8() != luacTail[i]) {
        throw StateError('The input file does not have the header tail of a valid Lua file (it may be corrupted).');
      }
    }
  }
}

class LHeaderType50 extends LHeaderType {
  static const double TEST_NUMBER = 3.14159265358979323846E7;

  @override
  void parse_main(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    s.format = 0;
    parse_endianness(buffer, header, s);
    parse_int_size(buffer, header, s);
    parse_size_t_size(buffer, header, s);
    parse_instruction_size(buffer, header, s);
    parse_extractor(buffer, header, s);
    parse_number_size(buffer, header, s);
    var lfloat = LNumberType(s.lNumberSize, false, NumberMode.MODE_NUMBER);
    var linteger = LNumberType(s.lNumberSize, true, NumberMode.MODE_NUMBER);
    buffer.mark();
    var floatcheck = lfloat.parse(buffer, header).value();
    buffer.reset();
    var intcheck = linteger.parse(buffer, header).value();
    if (floatcheck == lfloat.convert(TEST_NUMBER)) {
      s.number = lfloat;
    } else if (intcheck == linteger.convert(TEST_NUMBER)) {
      s.number = linteger;
    } else {
      throw StateError('The input chunk is using an unrecognized number format: $intcheck');
    }
    s.function = LFunctionType.TYPE50;
    s.string = LStringType.getType50();
    s.constant = LConstantType.getType50();
  }
}

class LHeaderType51 extends LHeaderType {
  @override
  void parse_main(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    parse_format(buffer, header, s);
    parse_endianness(buffer, header, s);
    parse_int_size(buffer, header, s);
    parse_size_t_size(buffer, header, s);
    parse_instruction_size(buffer, header, s);
    parse_number_size(buffer, header, s);
    parse_number_integrality(buffer, header, s);
    s.number = LNumberType(s.lNumberSize, s.lNumberIntegrality, NumberMode.MODE_NUMBER);
    s.function = LFunctionType.TYPE51;
    s.string = LStringType.getType50();
    s.constant = LConstantType.getType50();
    s.extractor = Code51();
  }
}

class LHeaderType52 extends LHeaderType {
  @override
  void parse_main(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    parse_format(buffer, header, s);
    parse_endianness(buffer, header, s);
    parse_int_size(buffer, header, s);
    parse_size_t_size(buffer, header, s);
    parse_instruction_size(buffer, header, s);
    parse_number_size(buffer, header, s);
    parse_number_integrality(buffer, header, s);
    parse_tail(buffer, header, s);
    s.number = LNumberType(s.lNumberSize, s.lNumberIntegrality, NumberMode.MODE_NUMBER);
    s.function = LFunctionType.TYPE52;
    s.string = LStringType.getType50();
    s.constant = LConstantType.getType50();
    s.extractor = Code51();
  }
}

class LHeaderType53 extends LHeaderType {
  void parse_integer_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var lIntegerSize = buffer.getUint8();
    if (header.debug) {
      //print('-- Lua integer size: $lIntegerSize');
    }
    if (lIntegerSize < 2) {
      throw StateError('The input chunk reports an integer size that is too small: $lIntegerSize');
    }
    s.lIntegerSize = lIntegerSize;
  }

  void parse_float_size(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    var lFloatSize = buffer.getUint8();
    if (header.debug) {
      //print('-- Lua float size: $lFloatSize');
    }
    s.lFloatSize = lFloatSize;
  }

  @override
  void parse_main(ByteBuffer_ buffer, BHeader header, LHeaderParseState s) {
    parse_format(buffer, header, s);
    parse_tail(buffer, header, s);
    parse_int_size(buffer, header, s);
    parse_size_t_size(buffer, header, s);
    parse_instruction_size(buffer, header, s);
    parse_integer_size(buffer, header, s);
    parse_float_size(buffer, header, s);
    var endianness = Uint8List(s.lIntegerSize);
    buffer.getInt8_(endianness as int);
    if (endianness[0] == 0x78 && endianness[1] == 0x56) {
      buffer.order = Endian.little;
    } else if (endianness[s.lIntegerSize - 1] == 0x78 && endianness[s.lIntegerSize - 2] == 0x56) {
      buffer.order = Endian.big;
    } else {
      throw StateError('The input chunk reports an invalid endianness: $endianness');
    }
    s.linteger = LNumberType(s.lIntegerSize, true, NumberMode.MODE_INTEGER);
    s.lfloat = LNumberType(s.lFloatSize, false, NumberMode.MODE_FLOAT);
    s.function = LFunctionType.TYPE53;
    s.string = LStringType.getType53();
    s.constant = LConstantType.getType53();
    s.extractor = Code51();
    var floatcheck = s.lfloat.parse(buffer, header).value();
    if (floatcheck != s.lfloat.convert(370.5)) {
      throw StateError('The input chunk is using an unrecognized floating point format: $floatcheck');
    }
  }
}

class LHeaderParseState {
  late BIntegerType integer;
  late BSizeTType sizeT;
  late LNumberType number;
  late LNumberType linteger;
  late LNumberType lfloat;
  late LStringType string;
  late LConstantType constant;
  late LFunctionType function;
  late CodeExtract extractor;

  late int format;

  late int lNumberSize;
  late bool lNumberIntegrality;

  late int lIntegerSize;
  late int lFloatSize;
}
