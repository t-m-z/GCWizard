part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _LHeader extends _BObject {
  final int format;
  final _BIntegerType integer;
  final _BSizeTType sizeT;
  final _LBooleanType bool;
  final _LNumberType? number;
  final _LNumberType? linteger;
  final _LNumberType? lfloat;
  final _LStringType string;
  final _LConstantType constant;
  final _LLocalType local;
  final _LUpvalueType upvalue;
  final _LFunctionType function;
  final _CodeExtract extractor;

  _LHeader(
    this.format,
    this.integer,
    this.sizeT,
    this.bool,
    this.number,
    this.linteger,
    this.lfloat,
    this.string,
    this.constant,
    this.local,
    this.upvalue,
    this.function,
    this.extractor,
  );
}
