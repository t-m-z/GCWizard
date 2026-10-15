import 'dart:math' as math;

import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart' as wbgt;
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/mean_radiant_temperature.dart';


enum UTCI_HEATSTRESS_CONDITION {
  BLUE_VIOLETT,
  BLUE_DARK,
  BLUE,
  BLUE_LIGHT,
  CYAN,
  GREEN,
  ORANGE,
  RED_LIGHT,
  RED,
  RED_DARK}

const Map<UTCI_HEATSTRESS_CONDITION, double> UTCI_HEAT_STRESS = {
  // https://utci.org/resources/utci_poster.pdf
  UTCI_HEATSTRESS_CONDITION.BLUE_VIOLETT: -40.0,
  UTCI_HEATSTRESS_CONDITION.BLUE_DARK: -30.0,
  UTCI_HEATSTRESS_CONDITION.BLUE: -20.0,
  UTCI_HEATSTRESS_CONDITION.BLUE_LIGHT: -10.0,
  UTCI_HEATSTRESS_CONDITION.CYAN: 0.0,
  UTCI_HEATSTRESS_CONDITION.GREEN: 10.0,
  UTCI_HEATSTRESS_CONDITION.ORANGE: 20.0,
  UTCI_HEATSTRESS_CONDITION.RED_LIGHT: 30.0,
  UTCI_HEATSTRESS_CONDITION.RED: 40.0,
  UTCI_HEATSTRESS_CONDITION.RED_DARK: 50.0,
};

// UTCI straight from standard meteorological measurements, hiding the
// intermediate globe temperature / mean radiant temperature steps.


// Calculates the Universal Thermal Climate Index (UTCI), degree Celsius,
// directly from standard meteorological measurements — the same kind of
// input [wbgt.calculateWbgt] itself takes.
//
// This is the simplest way to get a UTCI value when no globe thermometer
// reading or mean radiant temperature is available:
// it runs Liljegren's WBGT model (`package:wbgt`) to estimate the globe
// temperature `Tg` from [input],
// converts `Tg` to the mean radiant temperature Tmrt (see [meanRadiantTemperatureFromGlobe]),
// derives the water vapour pressure from [wbgt.WbgtInput.relativeHumidityPct] (see
// [vapourPressureFromRelativeHumidity]),
// and feeds all of that into [utciApprox]:
//
// weather -> (wbgt.calculateWbgt) -> Tg -> (meanRadiantTemperatureFromGlobe) -> Tmrt -> (utciApprox) -> UTCI
//
// [input.windSpeedMs] is passed straight through as `utciApprox`'s wind
// speed argument; per the original FORTRAN model, `utciApprox` is only
// validated for wind speed measured 10 m above ground level (see
// [UtciValidRange]) — if [input.windSpeedHeightM] differs, that mismatch
// is not corrected here (it only affects the globe/wet-bulb solvers
// inside `wbgt.calculateWbgt`, which do estimate their own wind speed at
// their 2-m reference height).
//
// Returns `null` if the underlying globe-temperature solver failed to
// converge, or if the resulting globe temperature has no physically valid
// Tmrt (see [meanRadiantTemperatureFromWeather]).

double? calculateUtciFromWeather(wbgt.WbgtInput input) {
  final double? tmrt = meanRadiantTemperatureFromWeather(input);
  if (tmrt == null) return null;

  final double ehPa = vapourPressureFromRelativeHumidity(
    input.airTemperatureC,
    input.relativeHumidityPct,
  );
  return utciApprox(input.airTemperatureC, ehPa, tmrt, input.windSpeedMs);
}


// Dart port of UTCI_a002.f90 (Universal Thermal Climate Index, UTCI).
//
// Original FORTRAN source: UTCI_a002.f90, Version a 0.002, October 2009,
// Copyright (C) 2009 Peter Broede, released for public use after
// termination of COST Action 730.
//
// This file ports the `UTCI_approx` and `es` functions to Dart, keeping
// the numerical structure (and every coefficient) of the original 6th
// order polynomial approximation unchanged.


// Result range of validity for [utciApprox], as documented in the
// original FORTRAN ReadMe:
// - air temperature: -50 to +50 degC
// - mean radiant temperature: 30 degC below to 70 degC above air
//   temperature
// - wind speed at 10 m: 0.5 to 17 m/s
// - water vapour pressure: below 50 hPa (or 100% relative humidity)
//
// Values outside this range are still computed, but the polynomial
// approximation is no longer validated there.

class UtciValidRange {
  static const double minAirTemperatureC = -50;
  static const double maxAirTemperatureC = 50;
  static const double minMeanRadiantOffsetC = -30;
  static const double maxMeanRadiantOffsetC = 70;
  static const double minWindSpeedMs = 0.5;
  static const double maxWindSpeedMs = 17;
  static const double maxVapourPressureHpa = 50;
}

// Calculates the Universal Thermal Climate Index (UTCI), in degree
// Celsius, approximated by a 6th order polynomial regression function
// from the 4 input parameters.
//
// This is a direct port of the `UTCI_approx` DOUBLE PRECISION function
// from `UTCI_a002.f90` (Version a 0.002, October 2009, Peter Broede).
//
// Parameters:
// - [ta]: air temperature, degree Celsius (valid range: -50 to +50 degC)
// - [ehPa]: water vapour pressure, hPa = hecto Pascal (valid range: up
//   to 50 hPa, or 100% relative humidity)
// - [tmrt]: mean radiant temperature, degree Celsius (valid range: 30
//   degC below to 70 degC above air temperature)
// - [va]: wind speed 10 m above ground level, in m/s (valid range: 0.5
//   to 17 m/s)
//
// Returns the UTCI in degree Celsius. The polynomial approximation is
// only validated within the ranges given above; this function does not
// enforce or clamp them, mirroring the original FORTRAN function.

double utciApprox(double ta, double ehPa, double tmrt, double va) {
  final double dTmrt = tmrt - ta;
  final double pa = ehPa / 10.0; // use vapour pressure in kPa

  // 6th order polynomial approximation, term-for-term identical to the
  // original FORTRAN `UTCI_approx` function.
  return ta +
      ( 6.07562052e-01 )   +
      ( -2.27712343e-02 ) * ta +
      ( 8.06470249e-04 ) * ta*ta +
      ( -1.54271372e-04 ) * ta*ta*ta +
      ( -3.24651735e-06 ) * ta*ta*ta*ta +
      ( 7.32602852e-08 ) * ta*ta*ta*ta*ta +
      ( 1.35959073e-09 ) * ta*ta*ta*ta*ta*ta +
      ( -2.25836520e+00 ) * va +
      ( 8.80326035e-02 ) * ta*va +
      ( 2.16844454e-03 ) * ta*ta*va +
      ( -1.53347087e-05 ) * ta*ta*ta*va +
      ( -5.72983704e-07 ) * ta*ta*ta*ta*va +
      ( -2.55090145e-09 ) * ta*ta*ta*ta*ta*va +
      ( -7.51269505e-01 ) * va*va +
      ( -4.08350271e-03 ) * ta*va*va +
      ( -5.21670675e-05 ) * ta*ta*va*va +
      ( 1.94544667e-06 ) * ta*ta*ta*va*va +
      ( 1.14099531e-08 ) * ta*ta*ta*ta*va*va +
      ( 1.58137256e-01 ) * va*va*va +
      ( -6.57263143e-05 ) * ta*va*va*va +
      ( 2.22697524e-07 ) * ta*ta*va*va*va +
      ( -4.16117031e-08 ) * ta*ta*ta*va*va*va +
      ( -1.27762753e-02 ) * va*va*va*va +
      ( 9.66891875e-06 ) * ta*va*va*va*va +
      ( 2.52785852e-09 ) * ta*ta*va*va*va*va +
      ( 4.56306672e-04 ) * va*va*va*va*va +
      ( -1.74202546e-07 ) * ta*va*va*va*va*va +
      ( -5.91491269e-06 ) * va*va*va*va*va*va +
      ( 3.98374029e-01 ) * dTmrt +
      ( 1.83945314e-04 ) * ta*dTmrt +
      ( -1.73754510e-04 ) * ta*ta*dTmrt +
      ( -7.60781159e-07 ) * ta*ta*ta*dTmrt +
      ( 3.77830287e-08 ) * ta*ta*ta*ta*dTmrt +
      ( 5.43079673e-10 ) * ta*ta*ta*ta*ta*dTmrt +
      ( -2.00518269e-02 ) * va*dTmrt +
      ( 8.92859837e-04 ) * ta*va*dTmrt +
      ( 3.45433048e-06 ) * ta*ta*va*dTmrt +
      ( -3.77925774e-07 ) * ta*ta*ta*va*dTmrt +
      ( -1.69699377e-09 ) * ta*ta*ta*ta*va*dTmrt +
      ( 1.69992415e-04 ) * va*va*dTmrt +
      ( -4.99204314e-05 ) * ta*va*va*dTmrt +
      ( 2.47417178e-07 ) * ta*ta*va*va*dTmrt +
      ( 1.07596466e-08 ) * ta*ta*ta*va*va*dTmrt +
      ( 8.49242932e-05 ) * va*va*va*dTmrt +
      ( 1.35191328e-06 ) * ta*va*va*va*dTmrt +
      ( -6.21531254e-09 ) * ta*ta*va*va*va*dTmrt +
      ( -4.99410301e-06 ) * va*va*va*va*dTmrt +
      ( -1.89489258e-08 ) * ta*va*va*va*va*dTmrt +
      ( 8.15300114e-08 ) * va*va*va*va*va*dTmrt +
      ( 7.55043090e-04 ) * dTmrt*dTmrt +
      ( -5.65095215e-05 ) * ta*dTmrt*dTmrt +
      ( -4.52166564e-07 ) * ta*ta*dTmrt*dTmrt +
      ( 2.46688878e-08 ) * ta*ta*ta*dTmrt*dTmrt +
      ( 2.42674348e-10 ) * ta*ta*ta*ta*dTmrt*dTmrt +
      ( 1.54547250e-04 ) * va*dTmrt*dTmrt +
      ( 5.24110970e-06 ) * ta*va*dTmrt*dTmrt +
      ( -8.75874982e-08 ) * ta*ta*va*dTmrt*dTmrt +
      ( -1.50743064e-09 ) * ta*ta*ta*va*dTmrt*dTmrt +
      ( -1.56236307e-05 ) * va*va*dTmrt*dTmrt +
      ( -1.33895614e-07 ) * ta*va*va*dTmrt*dTmrt +
      ( 2.49709824e-09 ) * ta*ta*va*va*dTmrt*dTmrt +
      ( 6.51711721e-07 ) * va*va*va*dTmrt*dTmrt +
      ( 1.94960053e-09 ) * ta*va*va*va*dTmrt*dTmrt +
      ( -1.00361113e-08 ) * va*va*va*va*dTmrt*dTmrt +
      ( -1.21206673e-05 ) * dTmrt*dTmrt*dTmrt +
      ( -2.18203660e-07 ) * ta*dTmrt*dTmrt*dTmrt +
      ( 7.51269482e-09 ) * ta*ta*dTmrt*dTmrt*dTmrt +
      ( 9.79063848e-11 ) * ta*ta*ta*dTmrt*dTmrt*dTmrt +
      ( 1.25006734e-06 ) * va*dTmrt*dTmrt*dTmrt +
      ( -1.81584736e-09 ) * ta*va*dTmrt*dTmrt*dTmrt +
      ( -3.52197671e-10 ) * ta*ta*va*dTmrt*dTmrt*dTmrt +
      ( -3.36514630e-08 ) * va*va*dTmrt*dTmrt*dTmrt +
      ( 1.35908359e-10 ) * ta*va*va*dTmrt*dTmrt*dTmrt +
      ( 4.17032620e-10 ) * va*va*va*dTmrt*dTmrt*dTmrt +
      ( -1.30369025e-09 ) * dTmrt*dTmrt*dTmrt*dTmrt +
      ( 4.13908461e-10 ) * ta*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 9.22652254e-12 ) * ta*ta*dTmrt*dTmrt*dTmrt*dTmrt +
      ( -5.08220384e-09 ) * va*dTmrt*dTmrt*dTmrt*dTmrt +
      ( -2.24730961e-11 ) * ta*va*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 1.17139133e-10 ) * va*va*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 6.62154879e-10 ) * dTmrt*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 4.03863260e-13 ) * ta*dTmrt*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 1.95087203e-12 ) * va*dTmrt*dTmrt*dTmrt*dTmrt*dTmrt +
      ( -4.73602469e-12 ) * dTmrt*dTmrt*dTmrt*dTmrt*dTmrt*dTmrt +
      ( 5.12733497e+00 ) * pa +
      ( -3.12788561e-01 ) * ta*pa +
      ( -1.96701861e-02 ) * ta*ta*pa +
      ( 9.99690870e-04 ) * ta*ta*ta*pa +
      ( 9.51738512e-06 ) * ta*ta*ta*ta*pa +
      ( -4.66426341e-07 ) * ta*ta*ta*ta*ta*pa +
      ( 5.48050612e-01 ) * va*pa +
      ( -3.30552823e-03 ) * ta*va*pa +
      ( -1.64119440e-03 ) * ta*ta*va*pa +
      ( -5.16670694e-06 ) * ta*ta*ta*va*pa +
      ( 9.52692432e-07 ) * ta*ta*ta*ta*va*pa +
      ( -4.29223622e-02 ) * va*va*pa +
      ( 5.00845667e-03 ) * ta*va*va*pa +
      ( 1.00601257e-06 ) * ta*ta*va*va*pa +
      ( -1.81748644e-06 ) * ta*ta*ta*va*va*pa +
      ( -1.25813502e-03 ) * va*va*va*pa +
      ( -1.79330391e-04 ) * ta*va*va*va*pa +
      ( 2.34994441e-06 ) * ta*ta*va*va*va*pa +
      ( 1.29735808e-04 ) * va*va*va*va*pa +
      ( 1.29064870e-06 ) * ta*va*va*va*va*pa +
      ( -2.28558686e-06 ) * va*va*va*va*va*pa +
      ( -3.69476348e-02 ) * dTmrt*pa +
      ( 1.62325322e-03 ) * ta*dTmrt*pa +
      ( -3.14279680e-05 ) * ta*ta*dTmrt*pa +
      ( 2.59835559e-06 ) * ta*ta*ta*dTmrt*pa +
      ( -4.77136523e-08 ) * ta*ta*ta*ta*dTmrt*pa +
      ( 8.64203390e-03 ) * va*dTmrt*pa +
      ( -6.87405181e-04 ) * ta*va*dTmrt*pa +
      ( -9.13863872e-06 ) * ta*ta*va*dTmrt*pa +
      ( 5.15916806e-07 ) * ta*ta*ta*va*dTmrt*pa +
      ( -3.59217476e-05 ) * va*va*dTmrt*pa +
      ( 3.28696511e-05 ) * ta*va*va*dTmrt*pa +
      ( -7.10542454e-07 ) * ta*ta*va*va*dTmrt*pa +
      ( -1.24382300e-05 ) * va*va*va*dTmrt*pa +
      ( -7.38584400e-09 ) * ta*va*va*va*dTmrt*pa +
      ( 2.20609296e-07 ) * va*va*va*va*dTmrt*pa +
      ( -7.32469180e-04 ) * dTmrt*dTmrt*pa +
      ( -1.87381964e-05 ) * ta*dTmrt*dTmrt*pa +
      ( 4.80925239e-06 ) * ta*ta*dTmrt*dTmrt*pa +
      ( -8.75492040e-08 ) * ta*ta*ta*dTmrt*dTmrt*pa +
      ( 2.77862930e-05 ) * va*dTmrt*dTmrt*pa +
      ( -5.06004592e-06 ) * ta*va*dTmrt*dTmrt*pa +
      ( 1.14325367e-07 ) * ta*ta*va*dTmrt*dTmrt*pa +
      ( 2.53016723e-06 ) * va*va*dTmrt*dTmrt*pa +
      ( -1.72857035e-08 ) * ta*va*va*dTmrt*dTmrt*pa +
      ( -3.95079398e-08 ) * va*va*va*dTmrt*dTmrt*pa +
      ( -3.59413173e-07 ) * dTmrt*dTmrt*dTmrt*pa +
      ( 7.04388046e-07 ) * ta*dTmrt*dTmrt*dTmrt*pa +
      ( -1.89309167e-08 ) * ta*ta*dTmrt*dTmrt*dTmrt*pa +
      ( -4.79768731e-07 ) * va*dTmrt*dTmrt*dTmrt*pa +
      ( 7.96079978e-09 ) * ta*va*dTmrt*dTmrt*dTmrt*pa +
      ( 1.62897058e-09 ) * va*va*dTmrt*dTmrt*dTmrt*pa +
      ( 3.94367674e-08 ) * dTmrt*dTmrt*dTmrt*dTmrt*pa +
      ( -1.18566247e-09 ) * ta*dTmrt*dTmrt*dTmrt*dTmrt*pa +
      ( 3.34678041e-10 ) * va*dTmrt*dTmrt*dTmrt*dTmrt*pa +
      ( -1.15606447e-10 ) * dTmrt*dTmrt*dTmrt*dTmrt*dTmrt*pa +
      ( -2.80626406e+00 ) * pa*pa +
      ( 5.48712484e-01 ) * ta*pa*pa +
      ( -3.99428410e-03 ) * ta*ta*pa*pa +
      ( -9.54009191e-04 ) * ta*ta*ta*pa*pa +
      ( 1.93090978e-05 ) * ta*ta*ta*ta*pa*pa +
      ( -3.08806365e-01 ) * va*pa*pa +
      ( 1.16952364e-02 ) * ta*va*pa*pa +
      ( 4.95271903e-04 ) * ta*ta*va*pa*pa +
      ( -1.90710882e-05 ) * ta*ta*ta*va*pa*pa +
      ( 2.10787756e-03 ) * va*va*pa*pa +
      ( -6.98445738e-04 ) * ta*va*va*pa*pa +
      ( 2.30109073e-05 ) * ta*ta*va*va*pa*pa +
      ( 4.17856590e-04 ) * va*va*va*pa*pa +
      ( -1.27043871e-05 ) * ta*va*va*va*pa*pa +
      ( -3.04620472e-06 ) * va*va*va*va*pa*pa +
      ( 5.14507424e-02 ) * dTmrt*pa*pa +
      ( -4.32510997e-03 ) * ta*dTmrt*pa*pa +
      ( 8.99281156e-05 ) * ta*ta*dTmrt*pa*pa +
      ( -7.14663943e-07 ) * ta*ta*ta*dTmrt*pa*pa +
      ( -2.66016305e-04 ) * va*dTmrt*pa*pa +
      ( 2.63789586e-04 ) * ta*va*dTmrt*pa*pa +
      ( -7.01199003e-06 ) * ta*ta*va*dTmrt*pa*pa +
      ( -1.06823306e-04 ) * va*va*dTmrt*pa*pa +
      ( 3.61341136e-06 ) * ta*va*va*dTmrt*pa*pa +
      ( 2.29748967e-07 ) * va*va*va*dTmrt*pa*pa +
      ( 3.04788893e-04 ) * dTmrt*dTmrt*pa*pa +
      ( -6.42070836e-05 ) * ta*dTmrt*dTmrt*pa*pa +
      ( 1.16257971e-06 ) * ta*ta*dTmrt*dTmrt*pa*pa +
      ( 7.68023384e-06 ) * va*dTmrt*dTmrt*pa*pa +
      ( -5.47446896e-07 ) * ta*va*dTmrt*dTmrt*pa*pa +
      ( -3.59937910e-08 ) * va*va*dTmrt*dTmrt*pa*pa +
      ( -4.36497725e-06 ) * dTmrt*dTmrt*dTmrt*pa*pa +
      ( 1.68737969e-07 ) * ta*dTmrt*dTmrt*dTmrt*pa*pa +
      ( 2.67489271e-08 ) * va*dTmrt*dTmrt*dTmrt*pa*pa +
      ( 3.23926897e-09 ) * dTmrt*dTmrt*dTmrt*dTmrt*pa*pa +
      ( -3.53874123e-02 ) * pa*pa*pa +
      ( -2.21201190e-01 ) * ta*pa*pa*pa +
      ( 1.55126038e-02 ) * ta*ta*pa*pa*pa +
      ( -2.63917279e-04 ) * ta*ta*ta*pa*pa*pa +
      ( 4.53433455e-02 ) * va*pa*pa*pa +
      ( -4.32943862e-03 ) * ta*va*pa*pa*pa +
      ( 1.45389826e-04 ) * ta*ta*va*pa*pa*pa +
      ( 2.17508610e-04 ) * va*va*pa*pa*pa +
      ( -6.66724702e-05 ) * ta*va*va*pa*pa*pa +
      ( 3.33217140e-05 ) * va*va*va*pa*pa*pa +
      ( -2.26921615e-03 ) * dTmrt*pa*pa*pa +
      ( 3.80261982e-04 ) * ta*dTmrt*pa*pa*pa +
      ( -5.45314314e-09 ) * ta*ta*dTmrt*pa*pa*pa +
      ( -7.96355448e-04 ) * va*dTmrt*pa*pa*pa +
      ( 2.53458034e-05 ) * ta*va*dTmrt*pa*pa*pa +
      ( -6.31223658e-06 ) * va*va*dTmrt*pa*pa*pa +
      ( 3.02122035e-04 ) * dTmrt*dTmrt*pa*pa*pa +
      ( -4.77403547e-06 ) * ta*dTmrt*dTmrt*pa*pa*pa +
      ( 1.73825715e-06 ) * va*dTmrt*dTmrt*pa*pa*pa +
      ( -4.09087898e-07 ) * dTmrt*dTmrt*dTmrt*pa*pa*pa +
      ( 6.14155345e-01 ) * pa*pa*pa*pa +
      ( -6.16755931e-02 ) * ta*pa*pa*pa*pa +
      ( 1.33374846e-03 ) * ta*ta*pa*pa*pa*pa +
      ( 3.55375387e-03 ) * va*pa*pa*pa*pa +
      ( -5.13027851e-04 ) * ta*va*pa*pa*pa*pa +
      ( 1.02449757e-04 ) * va*va*pa*pa*pa*pa +
      ( -1.48526421e-03 ) * dTmrt*pa*pa*pa*pa +
      ( -4.11469183e-05 ) * ta*dTmrt*pa*pa*pa*pa +
      ( -6.80434415e-06 ) * va*dTmrt*pa*pa*pa*pa +
      ( -9.77675906e-06 ) * dTmrt*dTmrt*pa*pa*pa*pa +
      ( 8.82773108e-02 ) * pa*pa*pa*pa*pa +
      ( -3.01859306e-03 ) * ta*pa*pa*pa*pa*pa +
      ( 1.04452989e-03 ) * va*pa*pa*pa*pa*pa +
      ( 2.47090539e-04 ) * dTmrt*pa*pa*pa*pa*pa +
      ( 1.48348065e-03 ) * pa*pa*pa*pa*pa*pa;
}

// Calculates the saturation vapour pressure over water, in hPa, for the
// given air temperature [ta] in degree Celsius.
//
// This is a direct port of the `es` FUNCTION from `UTCI_a002.f90`,
// following:
// Hardy, R.; ITS-90 Formulations for Vapor Pressure, Frostpoint
// Temperature, Dewpoint Temperature and Enhancement Factors in the
// Range -100 to 100 degC; Proceedings of Third International Symposium
// on Humidity and Moisture; edited by National Physical Laboratory
// (NPL), London, 1998, pp. 214-221.
// http://www.thunderscientific.com/tech_info/reflibrary/its90formulas.pdf
// (retrieved 2008-10-01)

double saturationVapourPressure(double ta) {
  const List<double> g = <double>[
    -2.8365744e3,
    -6.028076559e3,
    1.954263612e1,
    -2.737830188e-2,
    1.6261698e-5,
    7.0229056e-10,
    -1.8680009e-13,
    2.7150305,
  ];

  final double tk = ta + 273.15; // air temperature in K
  double es = g[7] * math.log(tk);
  for (int i = 0; i <= 6; i++) {
    es += g[i] * math.pow(tk, i - 2);
  }
  return math.exp(es) * 0.01; // convert Pa to hPa
}

// Converts relative humidity [relativeHumidityPercent] (0-100) at air
// temperature [ta] (degree Celsius) to water vapour pressure in hPa,
// using [saturationVapourPressure].
//
// Mirrors the conversion done in the original FORTRAN `UTCI_Temperature`
// program when the user chooses to enter relative humidity instead of
// vapour pressure directly (`ehPa = es(tt) * RH / 100.0D0`).

double vapourPressureFromRelativeHumidity(
    double ta,
    double relativeHumidityPercent,
    ) {
  return saturationVapourPressure(ta) * relativeHumidityPercent / 100.0;
}