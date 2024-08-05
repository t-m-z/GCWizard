import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/codeextract.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobject.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bintegertype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bsizettype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lbooleantype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lconstanttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunctiontype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/llocaltype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lnumbertype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lstringtype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lupvaluetype.dart';

class LHeader extends BObject {
  final int format;
  final BIntegerType integer;
  final BSizeTType sizeT;
  final LBooleanType bool_;
  final LNumberType number;
  final LNumberType linteger;
  final LNumberType lfloat;
  final LStringType string;
  final LConstantType constant;
  final LLocalType local;
  final LUpvalueType upvalue;
  final LFunctionType function;
  final CodeExtract extractor;

  LHeader(
    this.format,
    this.integer,
    this.sizeT,
    this.bool_,
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