part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Code51Extract implements _CodeExtract {
  const _Code51Extract();

  @override
  int extractA(int codepoint) => (codepoint >> 6) & 0xFF;

  @override
  int extractC(int codepoint) => (codepoint >> 14) & 0x1FF;

  @override
  int extractB(int codepoint) => codepoint >> 23;

  @override
  int extractBx(int codepoint) => codepoint >> 14;

  @override
  int extractSBx(int codepoint) => (codepoint >> 14) - 131071;

  @override
  int extractOp(int codepoint) => codepoint & 0x3F;
}

/// Reads and decodes a function's bytecode instruction stream.
class _Code {
  static const _CodeExtract code51 = _Code51Extract();

  final _CodeExtract _extractor;
  final _OpcodeMap _map;
  final List<int> _code;

  _Code(_LFunction function)
      : _code = function.code,
        _map = function.header.version.getOpcodeMap(),
        _extractor = function.header.extractor;

  _Op? op(int line) => _map.get(opcode(line));

  int opcode(int line) => _code[line - 1] & 0x3F;

  int A(int line) => _extractor.extractA(_code[line - 1]);

  int C(int line) => _extractor.extractC(_code[line - 1]);

  int B(int line) => _extractor.extractB(_code[line - 1]);

  int Bx(int line) => _extractor.extractBx(_code[line - 1]);

  int sBx(int line) => _extractor.extractSBx(_code[line - 1]);

  int codepoint(int line) => _code[line - 1];

  int length() => _code.length;

  String toStringAt(int line) =>
      op(line)!.codePointToString(codepoint(line), _extractor);
}
