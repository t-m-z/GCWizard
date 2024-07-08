import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/exception.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobjecttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lboolean.dart';


class LBooleanType extends BObjectType<LBoolean> {
  @override
  LBoolean parse(ByteBuffer_ buffer, BHeader header) {
    int value = buffer.asUint8List().first;
    if ((value & 0xFFFFFFFE) != 0) {
      throw IllegalStateException();
    } else {
      LBoolean bool = value == 0 ? LBoolean.LFALSE : LBoolean.LTRUE;
      if (header.debug) {
        //print('-- parsed <boolean> $bool');
      }
      return bool;
    }
  }
}

