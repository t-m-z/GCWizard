import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/parse/lfunction.dart';

String _unluac(){
  LFunction lmain = LFunction();
  Decompiler d = new Decompiler(lmain);
  d.decompile();
  d.print();
  return '';
}