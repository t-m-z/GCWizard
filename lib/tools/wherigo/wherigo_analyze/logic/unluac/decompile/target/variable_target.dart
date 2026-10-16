part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

class _VariableTarget extends _Target {
  final _Declaration decl;

  _VariableTarget(this.decl);

  @override
  void print(_Decompiler d, _Output out) {
    out.print(decl.name);
  }

  @override
  void printMethod(_Decompiler d, _Output out) {
    throw StateError('VariableTarget cannot be used as a method target');
  }

  @override
  bool isDeclaration(_Declaration? decl) => identical(this.decl, decl);

  @override
  bool get isLocal => true;

  @override
  int get index => decl.register;

  @override
  bool operator ==(Object other) =>
      other is _VariableTarget && identical(other.decl, decl);

  @override
  int get hashCode => decl.hashCode;
}
