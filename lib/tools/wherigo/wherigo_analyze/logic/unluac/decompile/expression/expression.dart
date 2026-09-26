part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _Expression {
  static const int precedenceOr = 1;
  static const int precedenceAnd = 2;
  static const int precedenceCompare = 3;
  static const int precedenceBor = 4;
  static const int precedenceBxor = 5;
  static const int precedenceBand = 6;
  static const int precedenceShift = 7;
  static const int precedenceConcat = 8;
  static const int precedenceAdd = 9;
  static const int precedenceMul = 10;
  static const int precedenceUnary = 11;
  static const int precedencePow = 12;
  static const int precedenceAtomic = 13;

  static const int associativityNone = 0;
  static const int associativityLeft = 1;
  static const int associativityRight = 2;

  static final _Expression nil = _ConstantExpression(_Constant(_LNil.nil), -1);

  static _BinaryExpression makeCONCAT(_Expression left, _Expression right) =>
      _BinaryExpression('..', left, right, precedenceConcat, associativityRight);

  static _BinaryExpression makeADD(_Expression left, _Expression right) =>
      _BinaryExpression('+', left, right, precedenceAdd, associativityLeft);

  static _BinaryExpression makeSUB(_Expression left, _Expression right) =>
      _BinaryExpression('-', left, right, precedenceAdd, associativityLeft);

  static _BinaryExpression makeMUL(_Expression left, _Expression right) =>
      _BinaryExpression('*', left, right, precedenceMul, associativityLeft);

  static _BinaryExpression makeDIV(_Expression left, _Expression right) =>
      _BinaryExpression('/', left, right, precedenceMul, associativityLeft);

  static _BinaryExpression makeMOD(_Expression left, _Expression right) =>
      _BinaryExpression('%', left, right, precedenceMul, associativityLeft);

  static _UnaryExpression makeUNM(_Expression expression) =>
      _UnaryExpression('-', expression, precedenceUnary);

  static _UnaryExpression makeNOT(_Expression expression) =>
      _UnaryExpression('not ', expression, precedenceUnary);

  static _UnaryExpression makeLEN(_Expression expression) =>
      _UnaryExpression('#', expression, precedenceUnary);

  static _BinaryExpression makePOW(_Expression left, _Expression right) =>
      _BinaryExpression('^', left, right, precedencePow, associativityRight);

  static _BinaryExpression makeIDIV(_Expression left, _Expression right) =>
      _BinaryExpression('//', left, right, precedenceMul, associativityLeft);

  static _BinaryExpression makeBAND(_Expression left, _Expression right) =>
      _BinaryExpression('&', left, right, precedenceBand, associativityLeft);

  static _BinaryExpression makeBOR(_Expression left, _Expression right) =>
      _BinaryExpression('|', left, right, precedenceBor, associativityLeft);

  static _BinaryExpression makeBXOR(_Expression left, _Expression right) =>
      _BinaryExpression('~', left, right, precedenceBxor, associativityLeft);

  static _BinaryExpression makeSHL(_Expression left, _Expression right) =>
      _BinaryExpression('<<', left, right, precedenceShift, associativityLeft);

  static _BinaryExpression makeSHR(_Expression left, _Expression right) =>
      _BinaryExpression('>>', left, right, precedenceShift, associativityLeft);

  static _UnaryExpression makeBNOT(_Expression expression) =>
      _UnaryExpression('~', expression, precedenceUnary);

  /// Prints a sequence of expressions with commas, optionally handling
  /// multiple-value adjustment and line breaks.
  static void printSequence(_Decompiler d, _Output out, List<_Expression> exprs,
      bool linebreak, bool multiple) {
    final n = exprs.length;
    var i = 1;
    for (final expr in exprs) {
      var last = i == n;
      if (expr.isMultiple) {
        last = true;
      }
      if (last) {
        if (multiple) {
          expr.printMultiple(d, out);
        } else {
          expr.print(d, out);
        }
        break;
      } else {
        expr.print(d, out);
        out.print(',');
        if (linebreak) {
          out.println();
        } else {
          out.print(' ');
        }
      }
      i++;
    }
  }

  final int precedence;

  _Expression(this.precedence);

  void print(_Decompiler d, _Output out);

  /// Prints the expression in a context where it is surrounded by braces.
  void printBraced(_Decompiler d, _Output out) {
    print(d, out);
  }

  /// Prints the expression in a context that accepts multiple values.
  void printMultiple(_Decompiler d, _Output out) {
    print(d, out);
  }

  /// The index of the last-declared constant in this expression, or -1.
  int get constantIndex;

  bool get beginsWithParen => false;

  bool get isNil => false;

  bool get isClosure => false;

  bool get isConstant => false;

  /// An ungrouped expression needs parentheses before it can be
  /// dereferenced (e.g. `(a+b).c`).
  bool get isUngrouped => false;

  // Only supported for closures.
  bool isUpvalueOf(int register) {
    throw StateError('isUpvalueOf is only supported for closures');
  }

  bool get isBoolean => false;

  bool get isInteger => false;

  int asInteger() {
    throw StateError('Expression is not an integer');
  }

  bool get isString => false;

  bool get isIdentifier => false;

  /// Whether this can be part of a function name: `{Name . } Name`.
  bool get isDotChain => false;

  int closureUpvalueLine() {
    throw StateError('closureUpvalueLine is only supported for closures');
  }

  void printClosure(_Decompiler d, _Output out, _Target name) {
    throw StateError('printClosure is only supported for closures');
  }

  String asName() {
    throw StateError('asName is not supported');
  }

  bool get isTableLiteral => false;

  bool get isNewEntryAllowed {
    throw StateError('isNewEntryAllowed is only supported for tables');
  }

  void addEntry(_TableLiteralEntry entry) {
    throw StateError('addEntry is only supported for tables');
  }

  /// Whether the expression has more than one return stored into registers.
  bool get isMultiple => false;

  bool get isMemberAccess => false;

  _Expression get table {
    throw StateError('table is only supported for member access');
  }

  String get field {
    throw StateError('field is only supported for member access');
  }

  bool get isBrief => false;

  bool isEnvironmentTable(_Decompiler d) => false;
}
