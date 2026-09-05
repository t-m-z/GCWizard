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
double meanRadiantTemperatureFromGlobe({
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
  return math.pow(tMrtK4, 0.25).toDouble() - 273.15;
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
/// converge (see `wbgt.WbgtResult.converged`).
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