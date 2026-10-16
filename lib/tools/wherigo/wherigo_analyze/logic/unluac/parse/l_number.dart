part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

abstract class _LNumber extends _LObject {
  static _LNumber makeInteger(int number) => _LIntNumber(number);

  double value();
}

class _LFloatNumber extends _LNumber {
  final double number; // stored at float precision by the reader
  final _NumberMode mode;

  _LFloatNumber(this.number, this.mode);

  @override
  String toString() {
    if (mode == _NumberMode.modeNumber && number == number.roundToDouble()) {
      return number.round().toString();
    }
    return _formatDouble(number);
  }

  @override
  double value() => number;
}

class _LDoubleNumber extends _LNumber {
  final double number;
  final _NumberMode mode;

  _LDoubleNumber(this.number, this.mode);

  @override
  String toString() {
    if (mode == _NumberMode.modeNumber && number == number.roundToDouble()) {
      return number.round().toString();
    }
    return _formatDouble(number);
  }

  @override
  double value() => number;
}

class _LIntNumber extends _LNumber {
  final int number;

  _LIntNumber(this.number);

  @override
  String toString() => number.toString();

  @override
  double value() => number.toDouble();
}

class _LLongNumber extends _LNumber {
  final int number;

  _LLongNumber(this.number);

  @override
  String toString() => number.toString();

  @override
  double value() => number.toDouble();
}

/// Approximates Java's Double.toString/Float.toString formatting closely
/// enough for decompiled source (Lua just needs a value that reads back the
/// same number; exact digit-for-digit fidelity with Java isn't required).
String _formatDouble(double value) {
  if (value.isNaN) return '(0/0)';
  if (value.isInfinite) return value > 0 ? '(1/0)' : '(-1/0)';
  if (value == 0) return (1 / value < 0) ? '-0.0' : '0.0';
  final abs = value.abs();
  if (abs >= 1e-3 && abs < 1e7) {
    var s = value.toString();
    return s;
  }
  // Scientific notation, matching java.lang.Double.toString's "E" form
  // (uppercase E, no leading '+', no zero-padded exponent). Dart's own
  // double.toString() already produces the correct shortest round-trip
  // digit string (just in a different layout/threshold), so digits are
  // extracted from that rather than reconstructed via log10/pow, which
  // loses precision for 16-17 significant digit values.
  final digits = _significantDigits(abs);
  final mantissa = digits.digits.length == 1
      ? digits.digits
      : '${digits.digits[0]}.${digits.digits.substring(1)}';
  final mstr = digits.digits.length == 1 ? '$mantissa.0' : mantissa;
  final sign = value < 0 ? '-' : '';
  return '$sign${mstr}E${digits.exponent}';
}

class _Digits {
  final String digits; // significant digits, no leading/trailing zeros
  final int
      exponent; // value == 0.d1d2d3... * 10^(exponent+1), i.e. d1.d2d3 * 10^exponent
  _Digits(this.digits, this.exponent);
}

_Digits _significantDigits(double abs) {
  final raw = abs.toString();
  String mantissaPart;
  int exp;
  final eIdx = raw.indexOf('e');
  if (eIdx >= 0) {
    mantissaPart = raw.substring(0, eIdx);
    exp = int.parse(raw.substring(eIdx + 1).replaceFirst('+', ''));
  } else {
    mantissaPart = raw;
    exp = 0;
  }
  final dotIdx = mantissaPart.indexOf('.');
  final intPart =
      dotIdx >= 0 ? mantissaPart.substring(0, dotIdx) : mantissaPart;
  final fracPart = dotIdx >= 0 ? mantissaPart.substring(dotIdx + 1) : '';
  final allDigits = intPart + fracPart;
  var firstNonZero = allDigits.indexOf(RegExp(r'[1-9]'));
  if (firstNonZero < 0) firstNonZero = allDigits.length - 1;
  exp += intPart.length - 1 - firstNonZero;
  var digits = allDigits.substring(firstNonZero);
  digits = digits.replaceFirst(RegExp(r'0+$'), '');
  if (digits.isEmpty) digits = '0';
  return _Digits(digits, exp);
}
