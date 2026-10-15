part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';


/// Low-precision solar position ("Astronomical Almanac" 1990 formulas).
///
/// Ported from `solarposition` and `daynum` in Liljegren's `wbgt.c`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c), which in turn
/// credits Nels Larson (Pacific Northwest National Laboratory).
///
/// Only the calendar-date input mode (`year`/`month`/`day.fraction`) is
/// ported here; it is the only mode [calcSolarParameters] and
/// `calc_wbgt` ever use in the original code, so the alternative
/// "days since 1900" input mode of the original `solarposition()` is
/// intentionally omitted.


/// The Sun's apparent position, as computed by [solarPosition].
class _SolarPosition {
  /// Apparent right ascension, hours, `0.0 <= value < 24.0`.
  final double apparentRightAscensionHours;

  /// Apparent declination, degrees, `-90.0 <= value <= 90.0`.
  final double apparentDeclinationDeg;

  /// Solar altitude, degrees, corrected for atmospheric refraction.
  final double altitudeDeg;

  /// Refraction correction that was added to the geometric altitude to
  /// obtain [altitudeDeg], degrees.
  final double refractionDeg;

  /// Solar azimuth, degrees, `0.0 <= value < 360.0`, east is 90.0.
  final double azimuthDeg;

  /// Distance of the Sun from Earth, astronomical units (1 a.u. is the mean
  /// distance).
  final double distanceAu;

  const _SolarPosition({
    required this.apparentRightAscensionHours,
    required this.apparentDeclinationDeg,
    required this.altitudeDeg,
    required this.refractionDeg,
    required this.azimuthDeg,
    required this.distanceAu,
  });
}

/// Sequential day number (1-365, or 366 in a leap year) of [day] of
/// [month] in [year], Gregorian calendar. Returns -1 if [year] < 1.
int dayOfYear(int year, int month, int day) {
  const begMonth = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  if (year < 1) return -1;
  // Leap years are divisible by 4, except centurial years not divisible by
  // 400.
  final isLeap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  var dnum = begMonth[month] + day;
  if (isLeap && month > 2) dnum += 1;
  return dnum;
}

/// Computes the Sun's apparent position for the given date and site.
///
/// [year] is the four-digit Gregorian year, `1950 <= year <= 2049`. If
/// [month] is non-zero (`1..12`), [day] is the day.fraction of the month
/// (UT); if [month] is 0, [day] is instead the day.fraction of the year.
/// [latitude] is north-positive decimal degrees, [longitude] is
/// east-positive decimal degrees.
///
/// Returns `null` if any input is out of the supported range.
_SolarPosition? _solarPosition({
  required int year,
  required int month,
  required double day,
  required double latitude,
  required double longitude,
}) {
  if (latitude < -90.0 || latitude > 90.0 || longitude < -180.0 || longitude > 180.0) {
    return null;
  }
  if (year < 1950 || year > 2049) return null;

  int daynumber;
  if (month != 0) {
    if (month < 1 || month > 12 || day < 0.0 || day > 33.0) return null;
    daynumber = dayOfYear(year, month, day.truncate());
  } else {
    if (day < 0.0 || day > 368.0) return null;
    daynumber = day.truncate();
  }

  // Construct Julian centuries since J2000 at 0 hours UT of date,
  // days.fraction since J2000, and UT hours.
  final deltaYears = year - 2000;
  var deltaDays = deltaYears * 365 + deltaYears ~/ 4 + daynumber;
  if (year > 2000) deltaDays += 1;
  // J2000 is 2000/01/01.5
  var daysJ2000 = deltaDays - 1.5;
  final centJ2000 = daysJ2000 / 36525.0;

  final (_, utFraction) = _modf(day);
  daysJ2000 += utFraction;
  final ut = utFraction * 24.0;

  // Compute solar position parameters. A. A. 1990, C24.
  var meanAnomaly = 357.528 + 0.9856003 * daysJ2000;
  var meanLongitude = 280.460 + 0.9856474 * daysJ2000;

  // Put mean_anomaly and mean_longitude in the range 0 -> 2 pi.
  final (_, maFrac) = _modf(meanAnomaly / 360.0);
  meanAnomaly = maFrac * _twoPi;
  final (_, mlFrac) = _modf(meanLongitude / 360.0);
  meanLongitude = mlFrac * _twoPi;

  final meanObliquity = (23.439 - 4.0e-7 * daysJ2000) * _degRad;
  final eclipticLong =
      ((1.915 * math.sin(meanAnomaly)) + (0.020 * math.sin(2.0 * meanAnomaly))) * _degRad + meanLongitude;

  final distanceAu = 1.00014 - 0.01671 * math.cos(meanAnomaly) - 0.00014 * math.cos(2.0 * meanAnomaly);

  // Tangent of ecliptic_long separated into sine/cosine parts for ap_ra.
  var apRaRad = math.atan2(math.cos(meanObliquity) * math.sin(eclipticLong), math.cos(eclipticLong));
  if (apRaRad < 0.0) apRaRad += _twoPi;
  final (_, apRaFrac) = _modf(apRaRad / _twoPi);
  final apRaHours = apRaFrac * 24.0;

  var apDec = math.asin(math.sin(meanObliquity) * math.sin(eclipticLong)); // radians for now

  // Calculate local mean sidereal time. A. A. 1990, B6-B7.
  // Horner's method of polynomial exponent expansion for gmst0h.
  var gmst0h = 24110.54841 + centJ2000 * (8640184.812866 + centJ2000 * (0.093104 - centJ2000 * 6.2e-6));
  final (_, gmstFrac) = _modf(gmst0h / 3600.0 / 24.0);
  gmst0h = gmstFrac * 24.0;
  if (gmst0h < 0.0) gmst0h += 24.0;

  // Ratio of lengths of mean solar day to mean sidereal day is
  // 1.00273790934 in 1990. A. A. 1990, B6.
  var lmst = gmst0h + (ut * 1.00273790934) + longitude / 15.0;
  final (_, lmstFrac) = _modf(lmst / 24.0);
  lmst = lmstFrac * 24.0;
  if (lmst < 0.0) lmst += 24.0;

  // Calculate local hour angle, altitude, azimuth, and refraction
  // correction. A. A. 1990, B61-B62.
  var localHa = lmst - apRaHours;
  if (localHa < -12.0) {
    localHa += 24.0;
  } else if (localHa > 12.0) {
    localHa -= 24.0;
  }

  final latitudeRad = latitude * _degRad;
  final localHaRad = localHa / 24.0 * _twoPi;

  final cosApDec = math.cos(apDec);
  final sinApDec = math.sin(apDec);
  final cosLat = math.cos(latitudeRad);
  final sinLat = math.sin(latitudeRad);
  final cosLha = math.cos(localHaRad);

  var altitude = math.asin(sinApDec * sinLat + cosApDec * cosLha * cosLat); // radians

  final cosAlt = math.cos(altitude);
  // Avoid tangent overflow at altitudes of +-90 degrees. 1.57079615 radians
  // is equal to 89.99999 degrees.
  final tanAlt = altitude.abs() < 1.57079615 ? math.tan(altitude) : 6.0e6;

  final cosAz = (sinApDec * cosLat - cosApDec * cosLha * sinLat) / cosAlt;
  final sinAz = -(cosApDec * math.sin(localHaRad) / cosAlt);
  var azimuth = math.acos(cosAz); // radians

  // Change range of azimuth from 0 -> pi to 0 -> 2 pi.
  if (math.atan2(sinAz, cosAz) < 0.0) azimuth = _twoPi - azimuth;

  // Convert ap_dec, altitude, and azimuth to degrees.
  apDec *= _radDeg;
  altitude *= _radDeg;
  azimuth *= _radDeg;

  // Compute refraction correction to be added to altitude to obtain actual
  // position. See the original wbgt.c for the rationale behind the 19.225
  // degree crossover.
  const pressure = 1013.25; // mb, standard atmosphere at sea level
  const temp = 15.0; // degC, standard atmosphere at sea level
  double refraction;
  if (altitude < -1.0 || tanAlt == 6.0e6) {
    refraction = 0.0;
  } else if (altitude < 19.225) {
    refraction = (0.1594 + altitude * (0.0196 + 0.00002 * altitude)) * pressure;
    refraction /= (1.0 + altitude * (0.505 + 0.0845 * altitude)) * (273.0 + temp);
  } else {
    refraction = 0.00452 * (pressure / (273.0 + temp)) / tanAlt;
  }
  altitude += refraction;

  return _SolarPosition(
    apparentRightAscensionHours: apRaHours,
    apparentDeclinationDeg: apDec,
    altitudeDeg: altitude,
    refractionDeg: refraction,
    azimuthDeg: azimuth,
    distanceAu: distanceAu,
  );
}