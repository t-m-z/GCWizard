part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';

/// Estimation of 2-m wind speed from a measurement at another height, via
/// an atmospheric stability class.
///
/// Ported from `stab_srdt` and `est_wind_speed` in Liljegren's `wbgt.c`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c).
///
/// Reference: EPA-454/5-99-005, 2000, section 6.2.5.

/// Estimates the atmospheric stability class (1-6, Pasquill-Gifford-style)
/// from [daytime], wind speed [speedMs], solar irradiance [solarWm2], and
/// (nighttime only) the vertical temperature difference [verticalTempDiffC]
/// (upper minus lower level, degC).
int _stabilityClass({
  required bool daytime,
  required double speedMs,
  required double solarWm2,
  required double verticalTempDiffC,
}) {
  const lsrdt = [
    [1, 1, 2, 4, 0, 5, 6, 0],
    [1, 2, 3, 4, 0, 5, 6, 0],
    [2, 2, 3, 4, 0, 4, 4, 0],
    [3, 3, 4, 4, 0, 0, 0, 0],
    [3, 4, 4, 4, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
  ];

  int i, j;
  if (daytime) {
    if (solarWm2 >= 925.0) {
      j = 0;
    } else if (solarWm2 >= 675.0) {
      j = 1;
    } else if (solarWm2 >= 175.0) {
      j = 2;
    } else {
      j = 3;
    }

    if (speedMs >= 6.0) {
      i = 4;
    } else if (speedMs >= 5.0) {
      i = 3;
    } else if (speedMs >= 3.0) {
      i = 2;
    } else if (speedMs >= 2.0) {
      i = 1;
    } else {
      i = 0;
    }
  } else {
    j = verticalTempDiffC >= 0.0 ? 6 : 5;

    if (speedMs >= 2.5) {
      i = 2;
    } else if (speedMs >= 2.0) {
      i = 1;
    } else {
      i = 0;
    }
  }
  return lsrdt[i][j];
}

/// Estimates 2-m ([refHeight]) wind speed, m/s, from a measurement of
/// [speedMs] taken at [heightM], given the atmospheric [stabilityClass]
/// (1-6, see [stabilityClass]) and whether the site is [urban].
double _estimateWindSpeedAtReferenceHeight({
  required double speedMs,
  required double heightM,
  required int stabilityClass,
  required bool urban,
}) {
  const urbanExp = [0.15, 0.15, 0.20, 0.25, 0.30, 0.30];
  const ruralExp = [0.07, 0.07, 0.10, 0.15, 0.35, 0.55];
  final exponent = urban ? urbanExp[stabilityClass - 1] : ruralExp[stabilityClass - 1];
  final estSpeed = speedMs * _dpow(_refHeight / heightM, exponent);
  return math.max(estSpeed, _minSpeed);
}