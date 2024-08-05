import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';

class LSourceLines {
  static LSourceLines? parse(ByteBuffer_ buffer) {
    int number = buffer.getInt32();
    while(number-- > 0) {
      buffer.getInt32();
    }
    return null;
  }
}