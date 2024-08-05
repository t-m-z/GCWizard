import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobjecttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/llocal.dart';

class LLocalType extends BObjectType<LLocal> {
  @override
  LLocal parse(ByteBuffer_ buffer, BHeader header) {
    final name = header.string.parse(buffer, header);
    final start = header.integer.parse(buffer, header);
    final end = header.integer.parse(buffer, header);
    if (header.debug) {
      print('-- parsing local, name: $name from ${start.asInt()} to ${end.asInt()}');
    }
    return LLocal(name, start, end);
  }
}
