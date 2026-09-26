part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Target {
  void print(_Decompiler d, _Output out);

  void printMethod(_Decompiler d, _Output out);

  bool isDeclaration(_Declaration? decl) => false;

  bool get isLocal => false;

  int get index => throw StateError('Target has no register index');

  bool get isFunctionName => true;

  bool get beginsWithParen => false;
}