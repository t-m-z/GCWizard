import 'dart:typed_data';

import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/configuration.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/bheader.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/util/bytebuffer.dart';

LFunction _file_to_function(String program, Configuration config) {
  ByteBuffer_ buffer = ByteBuffer_(Uint8List.fromList(program.codeUnits) as ByteBuffer);
  buffer.order = Endian.little;
  BHeader header = new BHeader(buffer, config);
  LFunction lFunction = header.main;
  return lFunction;
}

String unluac(String program){
  Configuration config = new Configuration();
  LFunction lmain = _file_to_function(program, config);
  Decompiler d = new Decompiler(lmain);
  String result = d.decompile();
  d.print(result,config.getOutput());
  return '';
}
