part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _TableReference extends _Expression {
  final _Expression table_;
  final _Expression index_;

  _TableReference(this.table_, this.index_) : super(_Expression.precedenceAtomic);

  @override
  int get constantIndex {
    final t = table_.constantIndex;
    final i = index_.constantIndex;
    return t > i ? t : i;
  }

  @override
  void print(_Decompiler d, _Output out) {
    final isGlobal = table_.isEnvironmentTable(d) && index_.isIdentifier;
    if (!isGlobal) {
      if (table_.isUngrouped) {
        out.print('(');
        table_.print(d, out);
        out.print(')');
      } else {
        table_.print(d, out);
      }
    }
    if (index_.isIdentifier) {
      if (!isGlobal) {
        out.print('.');
      }
      out.print(index_.asName());
    } else {
      out.print('[');
      index_.printBraced(d, out);
      out.print(']');
    }
  }

  @override
  bool get isDotChain => index_.isIdentifier && table_.isDotChain;

  @override
  bool get isMemberAccess => index_.isIdentifier;

  @override
  bool get beginsWithParen => table_.isUngrouped || table_.beginsWithParen;

  @override
  _Expression get table => table_;

  @override
  String get field => index_.asName();
}
