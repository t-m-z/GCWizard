// Top-level Wet Bulb Globe Temperature (WBGT) calculation.
//
// Ported from `calc_wbgt` in Liljegren's `wbgt.c`
// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c), with one change:
// the original takes measured solar irradiance directly, while this port
// takes fractional cloud cover and estimates solar irradiance from it (see
// [estimateSolarFromCloudCover]).
//
// Reference: Liljegren, J. C., R. A. Carhart, P. Lawday, S. Tschopp, and
// R. Sharp: Modeling the Wet Bulb Globe Temperature Using Standard
// Meteorological Measurements. The Journal of Occupational and
// Environmental Hygiene, vol. 5:10, pp. 645-655, 2008.

// https://wbgt.online/
// https://bulkcalculator.com/temparaturecalculators/wbgt-calculator.html

import 'dart:math' as math;

part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_constants.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_solar_irradiance.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_solar_position.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_wet_bulb_globe.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_wind.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_math_utils.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_psychrometrics.dart';
part 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt_convection.dart';


enum WBGT_HEATSTRESS_CONDITION { WHITE, GREEN, YELLOW, RED, BLACK}

const Map<WBGT_HEATSTRESS_CONDITION, double> WBGT_HEAT_STRESS = {
  // https://en.wikipedia.org/wiki/Wet-bulb_globe_temperature
  WBGT_HEATSTRESS_CONDITION.WHITE: 23.0,
  WBGT_HEATSTRESS_CONDITION.GREEN: 27.8,
  WBGT_HEATSTRESS_CONDITION.YELLOW: 29.5,
  WBGT_HEATSTRESS_CONDITION.RED: 31.1,
  WBGT_HEATSTRESS_CONDITION.BLACK: 32.2,
};


/// Inputs for [calculateWbgt].
class WbgtInput {
  /// Local standard time (i.e. *not* adjusted for daylight saving) of the
  /// observation. Only the calendar date and time-of-day fields
  /// (year/month/day/hour/minute) are used; [gmtOffsetHours] supplies the
  /// offset needed to convert to GMT.
  final DateTime observationTime;

  /// LST - GMT, hours (negative in the USA).
  final int gmtOffsetHours;

  /// Averaging time of the meteorological inputs, minutes.
  final int averagingMinutes;

  /// North-positive latitude, decimal degrees.
  final double latitude;

  /// East-positive longitude, decimal degrees (negative in the USA).
  final double longitude;

  /// Fractional cloud cover, `0.0` (clear sky) to `1.0` (fully overcast).
  /// Solar irradiance is estimated from this (see
  /// [estimateSolarFromCloudCover]) rather than taken as a direct input.
  final double cloudCoverFraction;

  /// Barometric pressure, mb.
  final double pressureMb;

  /// Air (dry bulb) temperature, degC.
  final double airTemperatureC;

  /// Relative humidity, %.
  final double relativeHumidityPct;

  /// Wind speed, m/s, as measured at [windSpeedHeightM].
  final double windSpeedMs;

  /// Height at which [windSpeedMs] was measured, m. If this differs from
  /// the 2-m reference height, wind speed is estimated at 2 m via
  /// [estimateWindSpeedAtReferenceHeight].
  final double windSpeedHeightM;

  /// Vertical temperature difference (upper minus lower level), degC. Only
  /// used (for the nighttime stability class) when [windSpeedHeightM]
  /// differs from the 2-m reference height. Defaults to 0.
  final double verticalTempDiffC;

  /// Whether to use the "urban" (true) or "rural" (false) wind speed power
  /// law exponent when estimating wind speed at the reference height.
  final bool urban;

  /// Clear-sky atmospheric transmittance used by
  /// [estimateSolarFromCloudCover]; see its documentation.
  final double clearSkyTransmittance;

  const WbgtInput({
    required this.observationTime,
    required this.gmtOffsetHours,
    required this.averagingMinutes,
    required this.latitude,
    required this.longitude,
    required this.cloudCoverFraction,
    required this.pressureMb,
    required this.airTemperatureC,
    required this.relativeHumidityPct,
    required this.windSpeedMs,
    required this.windSpeedHeightM,
    this.verticalTempDiffC = 0.0,
    this.urban = false,
    this.clearSkyTransmittance = 0.75,
  });
}

/// Results of [calculateWbgt].
class WbgtResult {
  /// Wind speed estimated at the 2-m reference height, m/s; `null` when
  /// [WbgtInput.windSpeedHeightM] already equals the reference height (no
  /// estimation was needed).
  final double? estimatedWindSpeedMs;

  /// Globe temperature, degC; `null` if the solver failed to converge.
  final double? globeTemperatureC;

  /// Natural wet bulb temperature, degC; `null` if the solver failed to
  /// converge.
  final double? naturalWetBulbC;

  /// Psychrometric wet bulb temperature, degC; `null` if the solver failed
  /// to converge.
  final double? psychrometricWetBulbC;

  /// Wet bulb globe temperature, degC:
  /// `0.1 * Tair + 0.7 * Tnwb + 0.2 * Tglobe`.
  /// `null` if either [globeTemperatureC] or [naturalWetBulbC] failed to converge.
  final double? wetBulbGlobeTemperatureC;

  /// Solar irradiance, W/m^2, estimated from cloud cover and used in the
  /// calculation (after normalizing against the top-of-atmosphere
  /// irradiance implied by the solar geometry).
  final double solarWm2;

  /// Whether [wetBulbGlobeTemperatureC] was successfully computed.
  bool get converged => wetBulbGlobeTemperatureC != null;

  const WbgtResult({
    required this.estimatedWindSpeedMs,
    required this.globeTemperatureC,
    required this.naturalWetBulbC,
    required this.psychrometricWetBulbC,
    required this.wetBulbGlobeTemperatureC,
    required this.solarWm2,
  });
}

/// Calculates the outdoor wet bulb globe temperature (WBGT), the weighted
/// sum of the air temperature (dry bulb), the natural wet bulb temperature,
/// and the globe temperature:
/// `Twbg = 0.1 * Tair + 0.7 * Tnwb + 0.2 * Tglobe`.
///
/// Solar irradiance is not taken directly; it is estimated from
/// [WbgtInput.cloudCoverFraction] and the solar geometry implied by
/// [WbgtInput.observationTime]/[WbgtInput.latitude]/[WbgtInput.longitude]
/// (see [estimateSolarFromCloudCover]).
///
/// Throws an [ArgumentError] if the observation date/site is out of the
/// range supported by the solar position model (years 1950-2049, valid
/// latitude/longitude).
WbgtResult calculateWbgt(WbgtInput input) {

  final t = input.observationTime;

  // Convert time to GMT and center it in the averaging period.
  final hourGmt = t.hour - input.gmtOffsetHours + (t.minute - 0.5 * input.averagingMinutes) / 60.0;
  final dday = t.day + hourGmt / 24.0;

  // Solar geometry, then estimate irradiance from cloud cover and
  // normalize/derive the direct-beam fraction exactly as the original
  // calc_solar_parameters does for a measured value.
  final pos = _solarPosition(
    year: t.year,
    month: t.month,
    day: dday,
    latitude: input.latitude,
    longitude: input.longitude,
  );
  if (pos == null) {
    throw ArgumentError('Invalid observation date, latitude, or longitude for solar position calculation.');
  }

  final cza = math.cos((90.0 - pos.altitudeDeg) * _degRad);
  final rawSolar = _estimateSolarFromCloudCover(
    cza: cza,
    distanceAu: pos.distanceAu,
    cloudCoverFraction: input.cloudCoverFraction,
    clearSkyTransmittance: input.clearSkyTransmittance,
  );
  final solarParams = _calcSolarParameters(
    year: t.year,
    month: t.month,
    day: dday,
    latitude: input.latitude,
    longitude: input.longitude,
    solarWm2In: rawSolar,
  );

  // Estimate wind speed at the reference height, if necessary.
  var speed = input.windSpeedMs;
  double? estSpeed;
  if (input.windSpeedHeightM != _refHeight) {
    final daytime = solarParams.cza > 0.0;
    final stability = _stabilityClass(
      daytime: daytime,
      speedMs: speed,
      solarWm2: solarParams.solarWm2,
      verticalTempDiffC: input.verticalTempDiffC,
    );
    estSpeed = _estimateWindSpeedAtReferenceHeight(
      speedMs: speed,
      heightM: input.windSpeedHeightM,
      stabilityClass: stability,
      urban: input.urban,
    );
    speed = estSpeed;
  }

  // Unit conversions.
  final tk = input.airTemperatureC + 273.15;
  final rh = 0.01 * input.relativeHumidityPct;

  final tGlobe = _globeTemperatureC(
    tempK: tk,
    rh: rh,
    pressureMb: input.pressureMb,
    speedMs: speed,
    solarWm2: solarParams.solarWm2,
    fdir: solarParams.fdir,
    cza: solarParams.cza,
  );

  final tNwb = _naturalOrPsychrometricWetBulbC(
    tempK: tk,
    rh: rh,
    pressureMb: input.pressureMb,
    speedMs: speed,
    solarWm2: solarParams.solarWm2,
    fdir: solarParams.fdir,
    cza: solarParams.cza,
    withRadiativeHeating: true,
  );

  final tPsy = _naturalOrPsychrometricWetBulbC(
    tempK: tk,
    rh: rh,
    pressureMb: input.pressureMb,
    speedMs: speed,
    solarWm2: solarParams.solarWm2,
    fdir: solarParams.fdir,
    cza: solarParams.cza,
    withRadiativeHeating: false,
  );

  double? twbg;
  if (tGlobe != null && tNwb != null) {
    twbg = 0.1 * input.airTemperatureC + 0.2 * tGlobe + 0.7 * tNwb;
  }

  return WbgtResult(
    estimatedWindSpeedMs: estSpeed,
    globeTemperatureC: tGlobe,
    naturalWetBulbC: tNwb,
    psychrometricWetBulbC: tPsy,
    wetBulbGlobeTemperatureC: twbg,
    solarWm2: solarParams.solarWm2,
  );
}