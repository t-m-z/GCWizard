// Mean radiant temperature (Tmrt) from a globe thermometer reading, using
// building blocks reused from `package:wbgt`
// (https://github.com/t-m-z/wbgt_port_dart), a Dart port of Liljegren
// et al.'s Wet Bulb Globe Temperature (WBGT) model.
//
// [utciApprox] (see `utci.dart`) needs Tmrt as an input, but a globe
// thermometer only measures the globe temperature `Tg` directly. This file
// converts `Tg` to Tmrt via the classic globe-thermometer energy balance
// (see e.g. ISO 7726, Annex C), using the same forced-convection
// correlation for a sphere that the `wbgt` package's own globe-temperature
// solver (`globeTemperatureC`) uses internally, so the two stay physically
// consistent.

import 'dart:math' as math;

import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart' as wbgt;


/// Conservative sanity floor for [meanRadiantTemperatureFromGlobe]'s result,
/// degree Celsius: below this, the underlying quartic inversion is so
/// ill-conditioned (see that function's doc) that its output is treated as
/// unreliable rather than a genuine measurement of a terrestrial thermal
/// environment. Set a couple of degrees below -89.2 degC, the coldest
/// naturally occurring surface temperature ever recorded on Earth (Vostok
/// Station, Antarctica, 1983) -- not a claim that Tmrt can never be colder
/// in principle, just a floor no real near-surface human thermal comfort
/// scenario should ever cross.
const double _minPlausibleTmrtC = -90.0;

/// Calculates the mean radiant temperature (Tmrt), degree Celsius, from a
/// globe thermometer reading.
///
/// This solves the steady-state radiative/convective energy balance of a
/// globe thermometer for Tmrt:
///
/// ```
/// Tmrt^4 = Tg^4 + h / (sigma * eps) * (Tg - Ta)      [temperatures in K]
/// ```
///
/// where `h` is the convective heat transfer coefficient of the globe
/// (from [wbgt.convectiveCoefficientSphere], the same sphere-in-cross-flow
/// correlation the `wbgt` package itself uses to solve for the globe
/// temperature — see `globeTemperatureC` in `package:wbgt`), and `sigma` is
/// the Stefan-Boltzmann constant ([wbgt.stefanBoltzmann]).
///
/// Parameters:
/// - [globeTemperatureC]: globe thermometer temperature, degree Celsius.
/// - [airTemperatureC]: air (dry bulb) temperature, degree Celsius.
/// - [windSpeedMs]: wind speed at the globe's height, m/s.
/// - [pressureMb]: barometric pressure, mb (hPa). Defaults to standard
///   sea-level pressure.
/// - [globeDiameterM]: diameter of the globe thermometer, m. Defaults to
///   [wbgt.dGlobe] (0.0508 m), the small black globe used by Liljegren's
///   model; pass `0.15` for a classic 150 mm globe thermometer.
/// - [globeEmissivity]: emissivity of the globe's surface. Defaults to
///   [wbgt.emisGlobe] (0.95), matching Liljegren's model.
///
/// Properties of air (viscosity, thermal conductivity) are evaluated at the
/// average of [globeTemperatureC] and [airTemperatureC], mirroring the
/// convention used throughout `package:wbgt`.
///
/// Returns `null` when [globeTemperatureC], [airTemperatureC], and
/// [windSpeedMs] describe a combination this quartic inversion cannot
/// answer reliably. Two distinct failure modes are both mapped to `null`:
///
/// - `Tmrt^4` (the quantity above computed before taking the 4th root) can
///   come out zero or negative, which has no real, positive-Kelvin
///   solution: the convective term (globe cooler than air) outweighs the
///   radiative one entirely.
/// - Even when `Tmrt^4` stays positive, it can be driven so close to zero
///   that the inversion becomes numerically ill-conditioned: a tiny change
///   in `Tg` then swings the computed Tmrt by tens of degrees, and the
///   nominal result can land far colder than any terrestrial thermal
///   environment could plausibly be (see [_minPlausibleTmrtC]) -- a sign
///   the equation is being pushed outside the regime it was meant for,
///   not a genuine reading.
///
/// Both happen whenever `Tg` reads *colder* than `Ta` by more than the
/// globe can plausibly explain through radiative cooling alone for the
/// given [globeDiameterM]/wind speed — the smaller [wbgt.dGlobe] default
/// is considerably more sensitive to this than a classic 150 mm globe,
/// since its convective coefficient is much larger for the same wind
/// speed. If you see unexpected `null`s with a small globe diameter and a
/// significantly-cooler-than-air `Tg`, try `globeDiameterM: 0.15` (a
/// classic globe thermometer) instead.
double? meanRadiantTemperatureFromGlobe({
  required double globeTemperatureC,
  required double airTemperatureC,
  required double windSpeedMs,
  double pressureMb = 1013.25,
  double globeDiameterM = wbgt.dGlobe,
  double globeEmissivity = wbgt.emisGlobe,
}) {
  final double tGlobeK = globeTemperatureC + 273.15;
  final double tAirK = airTemperatureC + 273.15;
  final double tRefK = 0.5 * (tGlobeK + tAirK);

  final double h = wbgt.convectiveCoefficientSphere(
    diameterM: globeDiameterM,
    tempK: tRefK,
    pressureMb: pressureMb,
    speedMs: windSpeedMs,
  );

  final double tMrtK4 = math.pow(tGlobeK, 4).toDouble() +
      h / (wbgt.stefanBoltzmann * globeEmissivity) * (tGlobeK - tAirK);
  // tMrtK4 <= 0 has no real, positive-Kelvin solution: the convective term
  // (globe cooler than air) outweighs the radiative one entirely.
  if (tMrtK4 <= 0) return null;

  final double tMrtC = math.pow(tMrtK4, 0.25).toDouble() - 273.15;
  // Even a positive tMrtK4 can be so close to zero that the result is
  // numerically meaningless for any real terrestrial environment.
  if (tMrtC < _minPlausibleTmrtC) return null;
  return tMrtC;
}

/// Calculates the mean radiant temperature (Tmrt), degree Celsius, from
/// standard meteorological measurements, by first running the Liljegren
/// WBGT model ([wbgt.calculateWbgt]) to estimate the globe temperature and
/// the wind speed at the globe's reference height, then converting that
/// globe temperature to Tmrt via [meanRadiantTemperatureFromGlobe].
///
/// This is the function to reach for when no globe thermometer reading is
/// available, only the kind of standard meteorological inputs
/// [wbgt.calculateWbgt] itself takes (air temperature, humidity, wind,
/// pressure, solar geometry derived from time/location/cloud cover).
///
/// Returns `null` if the underlying globe-temperature solver failed to
/// converge (see `wbgt.WbgtResult.converged`), or if the resulting globe
/// temperature has no physically valid Tmrt (see [meanRadiantTemperatureFromGlobe]).
double? meanRadiantTemperatureFromWeather(wbgt.WbgtInput input) {
  final wbgt.WbgtResult result = wbgt.calculateWbgt(input);
  final double? globeTemperatureC = result.globeTemperatureC;
  if (globeTemperatureC == null) return null;

  final double windSpeedMs = result.estimatedWindSpeedMs ?? input.windSpeedMs;
  return meanRadiantTemperatureFromGlobe(
    globeTemperatureC: globeTemperatureC,
    airTemperatureC: input.airTemperatureC,
    windSpeedMs: windSpeedMs,
    pressureMb: input.pressureMb,
  );
}