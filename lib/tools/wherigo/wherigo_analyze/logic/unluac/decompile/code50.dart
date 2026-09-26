part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Code50 implements _CodeExtract {
  late final int shiftA;
  late final int shiftB;
  late final int shiftBx;
  late final int shiftC;
  late final int maskOp;
  late final int maskA;
  late final int maskB;
  late final int maskBx;
  late final int maskC;
  late final int excessK;

  _Code50(int sizeOp, int sizeA, int sizeB, int sizeC) {
    shiftC = sizeOp;
    shiftB = sizeC + sizeOp;
    shiftBx = sizeOp;
    shiftA = sizeB + sizeC + sizeOp;
    maskOp = (1 << sizeOp) - 1;
    maskA = (1 << sizeA) - 1;
    maskB = (1 << sizeB) - 1;
    maskBx = (1 << (sizeB + sizeC)) - 1;
    maskC = (1 << sizeC) - 1;
    excessK = maskBx ~/ 2;
  }

  @override
  int extractA(int codepoint) => (codepoint >> shiftA) & maskA;

  @override
  int extractC(int codepoint) => (codepoint >> shiftC) & maskC;

  @override
  int extractB(int codepoint) => (codepoint >> shiftB) & maskB;

  @override
  int extractBx(int codepoint) => (codepoint >> shiftBx) & maskBx;

  @override
  int extractSBx(int codepoint) => ((codepoint >> shiftBx) & maskBx) - excessK;

  @override
  int extractOp(int codepoint) => codepoint & maskOp;
}
