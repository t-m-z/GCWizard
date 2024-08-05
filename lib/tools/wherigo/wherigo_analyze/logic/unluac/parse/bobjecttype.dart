import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/blist.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobject.dart';

abstract class BObjectType<T extends BObject> {
  T parse(ByteBuffer_ buffer, BHeader header);

  BList<T> parseList(ByteBuffer_ buffer, BHeader header) {
    final length = header.integer.parse(buffer, header);
    final values = <T>[];
    length.iterate(() {
      values.add(parse(buffer, header));
    });
    return BList<T>(length, values);
  }
}



