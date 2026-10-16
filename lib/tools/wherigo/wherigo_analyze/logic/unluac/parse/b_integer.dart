part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

/// A parsed integer value from the bytecode stream. Dart's native `int` is
/// 64-bit, which covers every intSize unluac actually encounters in
/// practice (1, 2, 4, or 8 bytes), so unlike the Java original this doesn't
/// need a BigInteger fallback for the common cases; an arbitrary-size
/// fallback using BigInt is kept for exotic custom int sizes.
class _BInteger extends _BObject {
  final BigInt? _big;
  final int _n;

  _BInteger(int n)
      : _big = null,
        _n = n;

  _BInteger.big(BigInt big)
      : _big = big,
        _n = 0;

  int asInt() {
    if (_big == null) {
      return _n;
    }
    final big = _big;
    if (big.bitLength > 62) {
      throw StateError(
          'The size of an integer is outside the range that unluac can handle.');
    }
    return big.toInt();
  }
}
