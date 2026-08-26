part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';



/// Psychrometric and air-property helper functions.
///
/// Ported from `esat`, `dew_point`, `viscosity`, `thermal_cond`,
/// `diffusivity`, `evap`, and `emis_atm` in Liljegren's `wbgt.c`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c).

/// Saturation vapor pressure, mb, over liquid water ([overIce] = false) or
/// ice ([overIce] = true), for temperature [tempK] in Kelvin.
///
/// Reference: Buck's (1981) approximation (eqn 3) of Wexler's (1976)
/// formulae.
double _saturationVaporPressure(double tempK, {bool overIce = false}) {
  double y, es;
  if (!overIce) {
    y = (tempK - 273.15) / (tempK - 32.18);
    es = 6.1121 * math.exp(17.502 * y);
  } else {
    y = (tempK - 273.15) / (tempK - 0.6);
    es = 6.1115 * math.exp(22.452 * y);
  }
  // Correction for moist air, if pressure is not available; valid for
  // pressure > 800 mb.
  es = 1.004 * es;
  return es;
}

/// Dew point ([frostPoint] = false) or frost point ([frostPoint] = true)
/// temperature, K, for vapor pressure [vaporPressureMb], mb.
double _dewOrFrostPoint(double vaporPressureMb, {bool frostPoint = false}) {
  double z, tdk;
  if (!frostPoint) {
    z = math.log(vaporPressureMb / (6.1121 * 1.004));
    tdk = 273.15 + 240.97 * z / (17.502 - z);
  } else {
    z = math.log(vaporPressureMb / (6.1115 * 1.004));
    tdk = 273.15 + 272.55 * z / (22.452 - z);
  }
  return tdk;
}

/// Viscosity of air, kg/(m s), at temperature [tempK], K.
///
/// Reference: Bird, Stewart, and Lightfoot (BSL), page 23.
double _airViscosity(double tempK) {
  const sigma = 3.617;
  const epsKappa = 97.0;
  final tr = tempK / epsKappa;
  final omega = (tr - 2.9) / 0.4 * (-0.034) + 1.048;
  return 2.6693e-6 * math.sqrt(_mAir * tempK) / (sigma * sigma * omega);
}

/// Thermal conductivity of air, W/(m K), at temperature [tempK], K.
///
/// Reference: BSL, page 257.
double _airThermalConductivity(double tempK) => (_cpAir + 1.25 * _rAir) * _airViscosity(tempK);

/// Diffusivity of water vapor in air, m^2/s, at temperature [tempK], K, and
/// pressure [pressureMb], mb.
///
/// Reference: BSL, page 505.
double _waterVaporDiffusivity(double tempK, double pressureMb) {
  const pCritAir = 36.4;
  const pCritH2o = 218.0;
  const tCritAir = 132.0;
  const tCritH2o = 647.3;
  const a = 3.640e-4;
  const b = 2.334;

  final pCrit13 = _dpow(pCritAir * pCritH2o, 1.0 / 3.0);
  final tCrit512 = _dpow(tCritAir * tCritH2o, 5.0 / 12.0);
  final tCrit12 = math.sqrt(tCritAir * tCritH2o);
  final mMix = math.sqrt(1.0 / _mAir + 1.0 / _mH2o);
  final pAtm = pressureMb / 1013.25; // mb to atmospheres

  return a * _dpow(tempK / tCrit12, b) * pCrit13 * tCrit512 * mMix / pAtm * 1e-4;
}

/// Heat of evaporation, J/(kg K), for temperature [tempK], K, in the range
/// 283-313 K.
///
/// Reference: Van Wylen and Sonntag, Table A.1.1.
double _heatOfEvaporation(double tempK) => (313.15 - tempK) / 30.0 * (-71100.0) + 2.4073e6;

/// Atmospheric emissivity for air temperature [tempK], K, and relative
/// humidity [rh] (fraction, 0-1).
///
/// Reference: Oke (2nd edition), page 373.
double _atmosphericEmissivity(double tempK, double rh) {
  final e = rh * _saturationVaporPressure(tempK);
  return 0.575 * _dpow(e, 0.143);
}