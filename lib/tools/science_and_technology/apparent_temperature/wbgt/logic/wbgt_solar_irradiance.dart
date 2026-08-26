part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';


/// Solar irradiance estimation: from cloud cover, and normalized against
/// the top-of-atmosphere irradiance implied by the solar geometry.
///
/// The normalization/direct-beam-fraction step is ported from
/// `calc_solar_parameters` in Liljegren's `wbgt.c`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c). The cloud-cover
/// model is not part of the original code (which expects solar irradiance
/// to be supplied as a measurement) — it is a standard empirical
/// clear-sky/cloud-attenuation model, added so WBGT can be estimated from
/// forecast/observed cloud cover instead of a pyranometer reading.

/// The solar-related quantities the wet-bulb/globe solvers need: irradiance
/// actually used (after normalizing against the top-of-atmosphere value),
/// cosine of the solar zenith angle, and the fraction of that irradiance
/// due to the direct beam.
///
class _SolarIrradianceParameters {
  /// Solar irradiance, W/m^2, clipped to be consistent with the
  /// top-of-atmosphere irradiance implied by the solar geometry.
  final double solarWm2;

  /// Cosine of the solar zenith angle.
  final double cza;

  /// Fraction of [solarWm2] due to the direct beam (vs. diffuse).
  final double fdir;

  const _SolarIrradianceParameters({
    required this.solarWm2,
    required this.cza,
    required this.fdir,
  });
}

/// Estimates global horizontal solar irradiance, W/m^2, from fractional
/// cloud cover.
///
/// [cza] is the cosine of the solar zenith angle and [distanceAu] the
/// Earth-Sun distance in astronomical units (both from [solarPosition]).
/// [cloudCoverFraction] ranges from `0.0` (clear sky) to `1.0` (fully
/// overcast) — convert oktas by dividing by 8.
///
/// The clear-sky irradiance is taken as [clearSkyTransmittance] (typically
/// ~0.70-0.80 at sea level; defaults to 0.75) times the top-of-atmosphere
/// irradiance, and cloud attenuation follows the empirical model of Kasten
/// & Czeplak (1980): `Rs = Rso * (1 - 0.75 * C^3.4)`.
double _estimateSolarFromCloudCover({
  required double cza,
  required double distanceAu,
  required double cloudCoverFraction,
  double clearSkyTransmittance = 0.75,
}) {
  assert(cloudCoverFraction >= 0.0 && cloudCoverFraction <= 1.0, 'cloudCoverFraction must be within 0.0-1.0');
  if (cza <= 0.0) return 0.0; // sun below the horizon

  final toaSolar = _solarConst * cza / (distanceAu * distanceAu);
  final clearSkySolar = clearSkyTransmittance * toaSolar;
  final clampedCover = cloudCoverFraction.clamp(0.0, 1.0).toDouble();
  final attenuation = 1.0 - 0.75 * _dpow(clampedCover, 3.4);
  final solar = clearSkySolar * attenuation;
  return math.max(solar, 0.0);
}

/// Computes the cosine of the solar zenith angle and the fraction of solar
/// irradiance due to the direct beam, normalizing [solarWm2In] against the
/// top-of-atmosphere irradiance implied by the solar geometry (adjusting it
/// down if it is unrealistically high for the given sun angle).
///
/// [year], [month], [day] (day.fraction, GMT), [latitude], and [longitude]
/// are as in [solarPosition].
///
/// Throws an [ArgumentError] if [solarPosition] cannot be computed for the
/// given date/site (see its documentation for the supported range).
_SolarIrradianceParameters _calcSolarParameters({
  required int year,
  required int month,
  required double day,
  required double latitude,
  required double longitude,
  required double solarWm2In,
}) {
  final pos = _solarPosition(year: year, month: month, day: day, latitude: latitude, longitude: longitude);
  if (pos == null) {
    throw ArgumentError('Invalid date, latitude, or longitude for solar position calculation.');
  }

  final cza = math.cos((90.0 - pos.altitudeDeg) * _degRad);
  var toaSolar = _solarConst * math.max(0.0, cza) / (pos.distanceAu * pos.distanceAu);
  // If the sun is not fully above the horizon, the top-of-atmosphere solar
  // irradiance is zero.
  if (cza < _czaMin) toaSolar = 0.0;

  var solar = solarWm2In;
  double fdir;
  if (toaSolar > 0.0) {
    // Account for any solar sensor/estimate calibration errors and make the
    // solar irradiance consistent with normsolar.
    final normSolar = math.min(solar / toaSolar, _normsolarMax);
    solar = normSolar * toaSolar;
    if (normSolar > 0.0) {
      fdir = math.exp(3.0 - 1.34 * normSolar - 1.65 / normSolar);
      fdir = math.max(math.min(fdir, 0.9), 0.0);
    } else {
      fdir = 0.0;
    }
  } else {
    // Faithful to the original: when the top-of-atmosphere irradiance is
    // zero, `solar` is left untouched (only `fdir` is forced to zero).
    fdir = 0.0;
  }

  return _SolarIrradianceParameters(solarWm2: solar, cza: cza, fdir: fdir);
}
