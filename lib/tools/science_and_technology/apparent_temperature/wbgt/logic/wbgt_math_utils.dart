part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';

/// Small numeric helpers shared by the WBGT port.


/// `dart:math`'s [math.pow] returns `num`; this pins the result to `double`
/// for arguments that are already `double`, mirroring C's `pow()`.
double _dpow(double base, double exponent) => math.pow(base, exponent).toDouble();

/// Equivalent of C's `modf`: splits [value] into its integral part
/// (truncated toward zero) and fractional part (same sign as [value]).
///
/// Returns `(integral, fractional)`.
(double, double) _modf(double value) {
  final integral = value.truncateToDouble();
  return (integral, value - integral);
}