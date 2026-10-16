part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _Declaration {
  final String name;
  final int begin;
  final int end;
  int register = 0;

  /// Whether this is an invisible for-loop book-keeping variable.
  bool forLoop = false;

  /// Whether this is an explicit for-loop declared variable.
  bool forLoopExplicit = false;

  _Declaration(this.name, this.begin, this.end);

  _Declaration.fromLocal(_LLocal local)
      : name = local.toString(),
        begin = local.start,
        end = local.end;
}
