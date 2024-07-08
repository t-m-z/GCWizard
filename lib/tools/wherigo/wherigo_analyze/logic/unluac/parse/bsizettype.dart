import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bintegertype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bobjecttype.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bsizet.dart';


class BSizeTType extends BObjectType<BSizeT> {
  final int sizeTSize;
  late final BIntegerType integerType;

  BSizeTType(this.sizeTSize) {
    integerType = BIntegerType(sizeTSize);
  }

  BSizeT parse(ByteBuffer_ buffer, BHeader header) {
    final value = BSizeT(integerType.raw_parse(buffer, header));
    if (header.debug) {
      //print('-- parsed <size_t> $value');
    }
    return value;
  }
}


