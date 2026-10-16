part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

const List<int> _signature = [0x1B, 0x4C, 0x75, 0x61];

class _BHeader {
  final _Configuration config;
  late final _Version version;
  late final _LHeader lheader;
  late final _BIntegerType integer;
  late final _BSizeTType sizeT;
  late final _LBooleanType bool;
  late final _LNumberType? number;
  late final _LNumberType? linteger;
  late final _LNumberType? lfloat;
  late final _LStringType string;
  late final _LConstantType constant;
  late final _LLocalType local;
  late final _LUpvalueType upvalue;
  late final _LFunctionType function;
  late final _CodeExtract extractor;

  late final _LFunction main;

  _BHeader(_ByteReader buffer, this.config) {
    for (var i = 0; i < _signature.length; i++) {
      if (buffer.get() != _signature[i]) {
        throw StateError(
            'The input file does not have the signature of a valid Lua file.');
      }
    }
    final versionNumber = buffer.get() & 0xFF;
    switch (versionNumber) {
      case 0x50:
        version = _Version.lua50;
        break;
      case 0x51:
        version = _Version.lua51;
        break;
      case 0x52:
        version = _Version.lua52;
        break;
      case 0x53:
        version = _Version.lua53;
        break;
      default:
        final major = versionNumber >> 4;
        final minor = versionNumber & 0x0F;
        throw StateError(
            "The input chunk's Lua version is $major.$minor; unluac can only handle Lua 5.0 - Lua 5.3.");
    }
    lheader = version.getLHeaderType().parse(buffer, this);
    integer = lheader.integer;
    sizeT = lheader.sizeT;
    bool = lheader.bool;
    number = lheader.number;
    linteger = lheader.linteger;
    lfloat = lheader.lfloat;
    string = lheader.string;
    constant = lheader.constant;
    local = lheader.local;
    upvalue = lheader.upvalue;
    function = lheader.function;
    extractor = lheader.extractor;

    int upvalues = -1;
    if (versionNumber >= 0x53) {
      upvalues = buffer.get() & 0xFF;
    }
    main = function.parse(buffer, this);
    if (upvalues >= 0) {
      if (main.numUpvalues != upvalues) {
        throw StateError(
            'The main chunk has the wrong number of upvalues: ${main.numUpvalues} ($upvalues expected)');
      }
    }
    if (main.numUpvalues >= 1 &&
        versionNumber >= 0x52 &&
        (main.upvalues[0].name == null || main.upvalues[0].name!.isEmpty)) {
      main.upvalues[0].name = '_ENV';
    }
  }
}
