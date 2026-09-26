part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Block extends _Statement implements Comparable<_Block> {
  final _LFunction function;
  int begin;
  int end;
  bool loopRedirectAdjustment = false;

  _Block(this.function, this.begin, this.end);

  void addStatement(_Statement statement);

  bool containsBlock(_Block block) => begin <= block.begin && end >= block.end;

  bool contains(int line) => begin <= line && line < end;

  int scopeEnd() => end - 1;

  /// An unprotected block is one that ends in a JMP instruction. If this is
  /// the case, any inner statement that tries to jump to the end of this
  /// block will be redirected.
  ///
  /// (One of the Lua compiler's few optimizations is that it changes any
  /// JMP that targets another JMP to the ultimate target. This is what
  /// unluac calls redirection.)
  bool isUnprotected();

  int getLoopback();

  bool breakable();

  bool isContainer();

  @override
  int compareTo(_Block block) {
    if (begin < block.begin) {
      return -1;
    } else if (begin == block.begin) {
      if (end < block.end) {
        return 1;
      } else if (end == block.end) {
        if (isContainer() && !block.isContainer()) {
          return -1;
        } else if (!isContainer() && block.isContainer()) {
          return 1;
        } else {
          return 0;
        }
      } else {
        return -1;
      }
    } else {
      return 1;
    }
  }

  _Operation process(_Decompiler d) {
    final statement = this;
    return _StatementOperation(end - 1, statement);
  }
}

class _StatementOperation extends _Operation {
  final _Statement statement;

  _StatementOperation(super.line, this.statement);

  @override
  _Statement? process(_Registers r, _Block block) => statement;
}
