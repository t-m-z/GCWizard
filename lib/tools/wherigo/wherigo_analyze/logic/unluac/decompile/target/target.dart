import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/declaration.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/decompiler.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/decompile/output.dart';

class Target {

  void print(Decompiler d, Output out) {
    print(d, out);
  }
  
  void printMethod(Decompiler d, Output out) {
    printMethod(d, out);
  }
  
  bool isDeclaration(Declaration decl) {
    return false;
  }
  
  bool isLocal() {
    return false;
  }
  
  int? getIndex() {
    throw StateError('Illegal state');
  }
  
  bool isFunctionName() {
    return true;
  }
  
  bool beginsWithParen() {
    return false;
  }
}


