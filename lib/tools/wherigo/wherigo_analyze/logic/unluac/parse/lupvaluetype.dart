import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobjecttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lupvalue.dart';

class LUpvalueType extends BObjectType<LUpvalue> {
  @override
  LUpvalue parse(ByteBuffer_ buffer, BHeader header) {
    LUpvalue upvalue = LUpvalue();
    upvalue.instack = buffer.getInt8_(0) != 0;
    upvalue.idx = buffer.getInt8_(1) & 0xFF;
    return upvalue;
  }
}

