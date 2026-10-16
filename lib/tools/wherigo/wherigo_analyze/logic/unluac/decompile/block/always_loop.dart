part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _AlwaysLoop extends _Block {
  final List<_Statement> statements = [];

  _AlwaysLoop(super.function, super.begin, super.end);

  @override
  int scopeEnd() => end - 2;

  @override
  bool breakable() => true;

  @override
  bool isContainer() => true;

  @override
  bool isUnprotected() => true;

  @override
  int getLoopback() => begin;

  @override
  void print(_Decompiler d, _Output out) {
    out.println('while true do');
    out.indent();
    _Statement.printSequence(d, out, statements);
    out.dedent();
    out.print('end');
  }

  @override
  void addStatement(_Statement statement) {
    statements.add(statement);
  }
}
