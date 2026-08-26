part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';

/// Convective heat transfer coefficients for the wick (cylinder) and globe
/// (sphere) sensors.
///
/// Ported from `h_cylinder_in_air` and `h_sphere_in_air` in Liljegren's
/// `wbgt.c` (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c).

/// Convective heat transfer coefficient, W/(m^2 K), for a long cylinder
/// (the wet-bulb wick) of [diameterM] and [lengthM] in cross flow, at
/// temperature [tempK], pressure [pressureMb], and wind speed [speedMs].
///
/// Reference: Bedingfield and Drew, eqn 32.
double _convectiveCoefficientCylinder({
  required double diameterM,
  // Unused, faithfully carried over from the original `h_cylinder_in_air`,
  // which never uses its `length` parameter in the computation either.
  required double lengthM,
  required double tempK,
  required double pressureMb,
  required double speedMs,
}) {
  const a = 0.56; // parameters from Bedingfield and Drew
  const b = 0.281;
  const c = 0.4;

  final density = pressureMb * 100.0 / (_rAir * tempK);
  final re = math.max(speedMs, _minSpeed) * density * diameterM / _airViscosity(tempK);
  final nu = b * _dpow(re, 1.0 - c) * _dpow(_prandtl, 1.0 - a);
  return nu * _airThermalConductivity(tempK) / diameterM;
}

/// Convective heat transfer coefficient, W/(m^2 K), for flow around a
/// sphere (the globe thermometer) of [diameterM], at temperature [tempK],
/// pressure [pressureMb], and wind speed [speedMs].
///
/// Reference: Bird, Stewart, and Lightfoot (BSL), page 409.
double _convectiveCoefficientSphere({
  required double diameterM,
  required double tempK,
  required double pressureMb,
  required double speedMs,
}) {
  final density = pressureMb * 100.0 / (_rAir * tempK);
  final re = math.max(speedMs, _minSpeed) * density * diameterM / _airViscosity(tempK);
  final nu = 2.0 + 0.6 * math.sqrt(re) * _dpow(_prandtl, 0.3333);
  return nu * _airThermalConductivity(tempK) / diameterM;
}