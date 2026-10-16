part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

enum _Op {
  // Lua 5.1 opcodes
  move(_OpcodeFormat.aB),
  loadk(_OpcodeFormat.aBx),
  loadbool(_OpcodeFormat.aBC),
  loadnil(_OpcodeFormat.aB),
  getupval(_OpcodeFormat.aB),
  getglobal(_OpcodeFormat.aBx),
  gettable(_OpcodeFormat.aBC),
  setglobal(_OpcodeFormat.aBx),
  setupval(_OpcodeFormat.aB),
  settable(_OpcodeFormat.aBC),
  newtable(_OpcodeFormat.aBC),
  self(_OpcodeFormat.aBC),
  add(_OpcodeFormat.aBC),
  sub(_OpcodeFormat.aBC),
  mul(_OpcodeFormat.aBC),
  div(_OpcodeFormat.aBC),
  mod(_OpcodeFormat.aBC),
  pow(_OpcodeFormat.aBC),
  unm(_OpcodeFormat.aB),
  not(_OpcodeFormat.aB),
  len(_OpcodeFormat.aB),
  concat(_OpcodeFormat.aBC),
  jmp(_OpcodeFormat.sBx), // Different in 5.2
  eq(_OpcodeFormat.aBC),
  lt(_OpcodeFormat.aBC),
  le(_OpcodeFormat.aBC),
  test(_OpcodeFormat.aC),
  testset(_OpcodeFormat.aBC),
  call(_OpcodeFormat.aBC),
  tailcall(_OpcodeFormat.aBC),
  return_(_OpcodeFormat.aB),
  forloop(_OpcodeFormat.aSBx),
  forprep(_OpcodeFormat.aSBx),
  tforloop(_OpcodeFormat.aC),
  setlist(_OpcodeFormat.aBC),
  close(_OpcodeFormat.a),
  closure(_OpcodeFormat.aBx),
  vararg(_OpcodeFormat.aB),
  // Lua 5.2 opcodes
  loadkx(_OpcodeFormat.a),
  gettabup(_OpcodeFormat.aBC),
  settabup(_OpcodeFormat.aBC),
  tforcall(_OpcodeFormat.aC),
  extraarg(_OpcodeFormat.ax),
  // Lua 5.0 opcodes
  newtable50(_OpcodeFormat.aBC),
  setlist50(_OpcodeFormat.aBC),
  setlisto(_OpcodeFormat.aBx),
  tforprep(_OpcodeFormat.aSBx),
  test50(_OpcodeFormat.aBC),
  // Lua 5.3 opcodes
  idiv(_OpcodeFormat.aBC),
  band(_OpcodeFormat.aBC),
  bor(_OpcodeFormat.aBC),
  bxor(_OpcodeFormat.aBC),
  shl(_OpcodeFormat.aBC),
  shr(_OpcodeFormat.aBC),
  bnot(_OpcodeFormat.aB);

  final _OpcodeFormat format;

  const _Op(this.format);

  String codePointToString(int codepoint, _CodeExtract ex) {
    switch (format) {
      case _OpcodeFormat.a:
        return '$name ${ex.extractA(codepoint)}';
      case _OpcodeFormat.aB:
        return '$name ${ex.extractA(codepoint)} ${ex.extractB(codepoint)}';
      case _OpcodeFormat.aC:
        return '$name ${ex.extractA(codepoint)} ${ex.extractC(codepoint)}';
      case _OpcodeFormat.aBC:
        return '$name ${ex.extractA(codepoint)} ${ex.extractB(codepoint)} ${ex.extractC(codepoint)}';
      case _OpcodeFormat.aBx:
        return '$name ${ex.extractA(codepoint)} ${ex.extractBx(codepoint)}';
      case _OpcodeFormat.aSBx:
        return '$name ${ex.extractA(codepoint)} ${ex.extractSBx(codepoint)}';
      case _OpcodeFormat.ax:
        return '$name <Ax>';
      case _OpcodeFormat.sBx:
        return '$name ${ex.extractSBx(codepoint)}';
    }
  }
}
