/* Dart Port of https://github.com/cosinekitty/astronomy/blob/master/source/kotlin/src/main/kotlin/io/github/cosinekitty/astronomy/astronomy.kt */

part of 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart';

/*
    Astronomy Engine for Kotlin / JVM.
    https://github.com/cosinekitty/astronomy

    MIT License

    Copyright (c) 2019-2025 Don Cross <cosinekitty@gmail.com>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_element, unused_field

/**
 * An invalid body was specified for the given function.
 */
class _InvalidBodyException implements Exception {
  final String message;
  _InvalidBodyException(_Body body) : message = "Invalid body: $body";
  @override
  String toString() => message;
}

/**
 * The Earth is not allowed as the body parameter.
 */
class _EarthNotAllowedException implements Exception {
  final String message = "The Earth is not allowed as the body parameter.";
  @override
  String toString() => message;
}

/**
 * An unexpected internal error occurred in Astronomy Engine
 */
class _InternalError implements Exception {
  final String message;
  _InternalError(this.message);
  @override
  String toString() => message;
}

/**
 * The factor to convert degrees to radians = pi/180.
 */
const double _DEG2RAD = 0.017453292519943296;

/**
 * Convert an angle expressed in degrees to an angle expressed in radians.
 */
extension _AstroDegreesToRadians on double {
  double degreesToRadians() => this * _DEG2RAD;
}
double _degreesToRadians(double deg) => deg * _DEG2RAD;

double _dsin(double degrees) => math.sin(_degreesToRadians(degrees));
double _dcos(double degrees) => math.cos(_degreesToRadians(degrees));
double _dtan(double degrees) => math.tan(_degreesToRadians(degrees));
double _datan(double slope) => _radiansToDegrees(math.atan(slope));
double _datan2(double y, double x) => _radiansToDegrees(math.atan2(y, x));

// Dart's dart:math has no top-level hypot; this mirrors kotlin.math.hypot.
double _hypot(double x, double y) => math.sqrt(x * x + y * y);

// Dart's dart:math has no log10; this mirrors kotlin.math.log10.
double _log10(double x) => math.log(x) / math.ln10;

/**
 * The factor to convert radians to degrees = 180/pi.
 */
const double _RAD2DEG = 57.295779513082321;

/**
 * The factor to convert radians to sidereal hours = 12/pi.
 */
const double _RAD2HOUR = 3.819718634205488;

/**
 * The factor to convert sidereal hours to radians = pi/12.
 */
const double _HOUR2RAD = 0.2617993877991494365;


/**
 * The equatorial radius of Jupiter, expressed in kilometers.
 */
const double _JUPITER_EQUATORIAL_RADIUS_KM = 71492.0;

/**
 * The polar radius of Jupiter, expressed in kilometers.
 */
const double _JUPITER_POLAR_RADIUS_KM = 66854.0;

/**
 * The volumetric mean radius of Jupiter, expressed in kilometers.
 */
const double _JUPITER_MEAN_RADIUS_KM = 69911.0;

/**
 * The mean radius of Jupiter's moon Io, expressed in kilometers.
 */
const double _IO_RADIUS_KM = 1821.6;

/**
 * The mean radius of Jupiter's moon Europa, expressed in kilometers.
 */
const double _EUROPA_RADIUS_KM = 1560.8;

/**
 * The mean radius of Jupiter's moon Ganymede, expressed in kilometers.
 */
const double _GANYMEDE_RADIUS_KM = 2631.2;

/**
 * The mean radius of Jupiter's moon Callisto, expressed in kilometers.
 */
const double _CALLISTO_RADIUS_KM = 2410.3;

/**
 * The speed of light in AU/day.
 */
const double C_AUDAY = 173.1446326846693;

/**
 * The number of astronomical units per light-year.
 */
const double _AU_PER_LY = 63241.07708807546;

/**
 * Convert an angle expressed in radians to an angle expressed in degrees.
 */
extension _AstroRadiansToDegrees on double {
  double radiansToDegrees() => this * _RAD2DEG;
}
double _radiansToDegrees(double rad) => rad * _RAD2DEG;

/**
 * The number of kilometers in one astronomical unit (AU).
 */
const double _KM_PER_AU = 1.4959787069098932e+8;

/**
 * The number of minutes in a day.
 */
const double _MINUTES_PER_DAY = 60.0 * 24.0;

/**
 * The number of seconds in a day.
 */
const double _SECONDS_PER_DAY = 60.0 * _MINUTES_PER_DAY;

/**
 * The number of milliseconds in a day.
 */
const double _MILLISECONDS_PER_DAY = 1000.0 * _SECONDS_PER_DAY;


const double _DAYS_PER_TROPICAL_YEAR = 365.24217;
const double _DAYS_PER_MILLENNIUM = 365250.0;

const double _ASEC360 = 1296000.0;
const double _ASEC2RAD = 4.848136811095359935899141e-6;
const double _PI2 = 2.0 * math.pi;
const double _SUN_RADIUS_KM = 695700.0;
const double _SUN_RADIUS_AU = _SUN_RADIUS_KM / _KM_PER_AU;
const double _EARTH_FLATTENING = 0.996647180302104;
const double _EARTH_FLATTENING_SQUARED = _EARTH_FLATTENING * _EARTH_FLATTENING;
const double _EARTH_EQUATORIAL_RADIUS_KM = 6378.1366;
const double _EARTH_EQUATORIAL_RADIUS_AU = _EARTH_EQUATORIAL_RADIUS_KM / _KM_PER_AU;
const double _EARTH_POLAR_RADIUS_KM = _EARTH_EQUATORIAL_RADIUS_KM * _EARTH_FLATTENING;
const double _EARTH_MEAN_RADIUS_KM = 6371.0;    // mean radius of the Earth's geoid, without atmosphere
const double _EARTH_ATMOSPHERE_KM = 88.0;       // effective atmosphere thickness for lunar eclipses
const double _EARTH_ECLIPSE_RADIUS_KM = _EARTH_MEAN_RADIUS_KM + _EARTH_ATMOSPHERE_KM;
const double _MOON_EQUATORIAL_RADIUS_KM = 1738.1;
const double _MOON_EQUATORIAL_RADIUS_AU = (_MOON_EQUATORIAL_RADIUS_KM / _KM_PER_AU);
const double _MOON_MEAN_RADIUS_KM       = 1737.4;
const double _MOON_POLAR_RADIUS_KM      = 1736.0;
const double _MOON_POLAR_RADIUS_AU      = (_MOON_POLAR_RADIUS_KM / _KM_PER_AU);
const double _ANGVEL = 7.2921150e-5;
const double _SOLAR_DAYS_PER_SIDEREAL_DAY = 0.9972695717592592;
const double _MEAN_SYNODIC_MONTH = 29.530588;     // average number of days for Moon to return to the same phase
const double _EARTH_ORBITAL_PERIOD = 365.256;
const double _NEPTUNE_ORBITAL_PERIOD = 60189.0;
const double _REFRACTION_NEAR_HORIZON = 34.0 / 60.0;  // degrees of refractive "lift" seen for objects near horizon
const double _ASEC180 = 180.0 * 60.0 * 60.0;          // arcseconds per 180 degrees (or pi radians)
const double _AU_PER_PARSEC = (_ASEC180 / math.pi);   // exact definition of how many AU = one parsec
const double _EARTH_MOON_MASS_RATIO = 81.30056;

/*
    Masses of the Sun and outer planets, used for:
    (1) Calculating the Solar System Barycenter
    (2) Integrating the movement of Pluto

    https://web.archive.org/web/20120220062549/http://iau-comm4.jpl.nasa.gov/de405iom/de405iom.pdf

    Page 10 in the above document describes the constants used in the DE405 ephemeris.
    The following are G*M values (gravity constant * mass) in [au^3 / day^2].
    This side-steps issues of not knowing the exact values of G and masses M[i];
    the products GM[i] are known extremely accurately.
*/
const double _SUN_GM     = 0.2959122082855911e-03;
const double _MERCURY_GM = 0.4912547451450812e-10;
const double _VENUS_GM   = 0.7243452486162703e-09;
const double _EARTH_GM   = 0.8887692390113509e-09;
const double _MARS_GM    = 0.9549535105779258e-10;
const double _JUPITER_GM = 0.2825345909524226e-06;
const double _SATURN_GM  = 0.8459715185680659e-07;
const double _URANUS_GM  = 0.1292024916781969e-07;
const double _NEPTUNE_GM = 0.1524358900784276e-07;
const double _PLUTO_GM   = 0.2188699765425970e-11;
const double _MOON_GM = _EARTH_GM / _EARTH_MOON_MASS_RATIO;

double _cbrt(double x) =>       // cube root of any real number
    (x < 0.0)
        ? -_cbrt(-x)
        : math.pow(x, 1.0 / 3.0).toDouble();

double _withMinDegreeValue(double value, double min) {
  var deg = value;
  while (deg < min) {
    deg += 360.0;
  }
  while (deg >= min + 360.0) {
    deg -= 360.0;
  }
  return deg;
}

double _withMaxDegreeValue(double value, double max) {
  var deg = value;
  while (deg <= max - 360.0) {
    deg += 360.0;
  }
  while (deg > max) {
    deg -= 360.0;
  }
  return deg;
}


double _toggleAzimuthDirection(double az) => _withMinDegreeValue(360.0 - az, 0.0);
double _longitudeOffset(double diff) => _withMaxDegreeValue(diff, 180.0);
double _normalizeLongitude(double lon) => _withMinDegreeValue(lon, 0.0);

/**
 * The enumeration of celestial bodies supported by Astronomy Engine.
 */
enum _Body {
  /**
   * The planet Mercury.
   */
  Mercury(_MERCURY_GM, 87.969),

  /**
   * The planet Venus.
   */
  Venus(_VENUS_GM, 224.701),

  /**
   * The planet Earth.
   *
   * Some functions that accept a `Body` parameter will fail if passed this value
   * because they assume that an observation is being made from the Earth,
   * and therefore the Earth is not a target of observation.
   */
  Earth(_EARTH_GM, _EARTH_ORBITAL_PERIOD),

  /**
   * The planet Mars.
   */
  Mars(_MARS_GM, 686.980),

  /**
   * The planet Jupiter.
   */
  Jupiter(_JUPITER_GM, 4332.589),

  /**
   * The planet Saturn.
   */
  Saturn(_SATURN_GM, 10759.22),

  /**
   * The planet Uranus.
   */
  Uranus(_URANUS_GM, 30685.4),

  /**
   * The planet Neptune.
   */
  Neptune(_NEPTUNE_GM, _NEPTUNE_ORBITAL_PERIOD),

  /**
   * The planet Pluto.
   */
  Pluto(_PLUTO_GM, 90560.0),

  /**
   * The Sun.
   */
  Sun(_SUN_GM, null),

  /**
   * The Earth's natural satellite, the Moon.
   */
  Moon(_MOON_GM, _MEAN_SYNODIC_MONTH),

  /**
   * The Earth/Moon Barycenter.
   *
   * This is the common center of gravity between the Earth and Moon,
   * and is the point that both bodies co-orbit. The EMB is located about 4670 km
   * away from the center of the Earth in the direction toward the Moon's center.
   * Thus the EMB is always inside the Earth.
   */
  EMB(_EARTH_GM + _MOON_GM, _MEAN_SYNODIC_MONTH),

  /**
   * The Solar System Barycenter.
   *
   * This is the Solar System's center of gravity, about which the Sun
   * and all the planets revolve. The SSB is sometimes inside the Sun,
   * sometimes outside the Sun, depending mainly on the relative positions
   * of the four most massive planets: Jupiter, Saturn, Uranus, and Neptune.
   * The SSB serves as an inertial reference point that is ideal for
   * simulating the movement of objects in the Solar System.
   */
  SSB(null, null),

  /**
   * User-defined star 1.
   */
  Star1(null, null),

  /**
   * User-defined star 2.
   */
  Star2(null, null),

  /**
   * User-defined star 3.
   */
  Star3(null, null),

  /**
   * User-defined star 4.
   */
  Star4(null, null),

  /**
   * User-defined star 5.
   */
  Star5(null, null),

  /**
   * User-defined star 6.
   */
  Star6(null, null),

  /**
   * User-defined star 7.
   */
  Star7(null, null),

  /**
   * User-defined star 8.
   */
  Star8(null, null);

  final double? _massProduct;
  final double? _orbitalPeriod;
  const _Body(this._massProduct, this._orbitalPeriod);
}


class _StarDef {
  double ra = 0.0;       // heliocentric right ascension in EQJ
  double dec = 0.0;      // heliocentric declination in EQJ
  double dist = 0.0;     // heliocentric distance in AU
}

final List<_StarDef> _starTable = [
  _StarDef(),      // Star1
  _StarDef(),      // Star2
  _StarDef(),      // Star3
  _StarDef(),      // Star4
  _StarDef(),      // Star5
  _StarDef(),      // Star6
  _StarDef(),      // Star7
  _StarDef()       // Star8
];

_StarDef? _getStar(_Body body) {
  switch (body) {
    case _Body.Star1: return _starTable[0];
    case _Body.Star2: return _starTable[1];
    case _Body.Star3: return _starTable[2];
    case _Body.Star4: return _starTable[3];
    case _Body.Star5: return _starTable[4];
    case _Body.Star6: return _starTable[5];
    case _Body.Star7: return _starTable[6];
    case _Body.Star8: return _starTable[7];
    default: return null;
  }
}

_StarDef? _userDefinedStar(_Body body) {
  final star = _getStar(body);
  return (star != null && star.dist > 0.0)     // has the star been defined?
      ? star
      : null;
}


/**
 * Assign equatorial coordinates to a user-defined star.
 *
 * Some Astronomy Engine functions allow their `body` parameter to
 * be a user-defined fixed point in the sky, loosely called a "star".
 * This function assigns a right ascension, declination, and distance
 * to one of the eight user-defined stars `Body.Star1`..`Body.Star8`.
 *
 * Stars are not valid until defined. Once defined, they retain their
 * definition until re-defined by another call to `defineStar`.
 *
 * @param body
 * One of the eight user-defined star identifiers: `Body.Star1`, `Body.Star2`, ..., `Body.Star8`.
 *
 * @param ra
 * The right ascension to be assigned to the star, expressed in J2000 equatorial coordinates (EQJ).
 * The value is in units of sidereal hours, and must be within the half-open range [0, 24).
 *
 * @param dec
 * The declination to be assigned to the star, expressed in J2000 equatorial coordinates (EQJ).
 * The value is in units of degrees north (positive) or south (negative) of the J2000 equator,
 * and must be within the closed range [-90, +90].
 *
 * @param distanceLightYears
 * The distance between the star and the Sun, expressed in light-years.
 * This value is used to calculate the tiny parallax shift as seen by an observer on Earth.
 * If you don't know the distance to the star, using a large value like 1000 will generally work well.
 * The minimum allowed distance is 1 light-year, which is required to provide certain internal optimizations.
 */
void _defineStar(_Body body, double ra, double dec, double distanceLightYears) {
  final star = _getStar(body);
  if (star == null) throw _InvalidBodyException(body);
  if (!ra.isFinite || ra < 0.0 || ra >= 24.0) throw ArgumentError("Invalid right ascension: $ra");
  if (!dec.isFinite || dec < -90.0 || dec > 90.0) throw ArgumentError("Invalid declination: $dec");
  if (!distanceLightYears.isFinite || distanceLightYears < 1.0) throw ArgumentError("Invalid distance: $distanceLightYears");
  star.ra = ra;
  star.dec = dec;
  star.dist = distanceLightYears * _AU_PER_LY;
}


double _universalTimeDays(int year, int month, int day, int hour, int minute, double second) {
  // This formula is adapted from NOVAS C 3.1 function julian_date(),
  // which in turn comes from Henry F. Fliegel & Thomas C. Van Flendern:
  // Communications of the ACM, Vol 11, No 10, October 1968, p. 657.
  // See: https://dl.acm.org/doi/pdf/10.1145/364096.364097
  //
  // [Don Cross - 2023-02-25] I modified the formula so that it will
  // work correctly with years as far back as -999999.

  final y = year;
  final m = month;
  final d = day;
  final f = (14 - m) ~/ 12;

  final int y2000 = (
      (d - 365972956)
      + (1461 * (y + 1000000 - f)) ~/ 4
      + (367 * (m - 2 + 12 * f)) ~/ 12
      - (3 * ((y + 1000100 - f) ~/ 100)) ~/ 4
  );

  return y2000 - 0.5 + (hour / 24.0) + (minute / (24.0 * 60.0)) + (second / (24.0 * 3600.0));
}


/**
 * A universal time resolved into UTC calendar date and time fields.
 */
class _DateTime {
  /**
   * The integer year value.
   */
  final int year;

  /**
   * The month value 1=January, ..., 12=December.
   */
  final int month;

  /**
   * The day of the month, 1..31.
   */
  final int day;

  /**
   * The hour of the day, 0..23.
   */
  final int hour;

  /**
   * The minute value 0..59.
   */
  final int minute;

  /**
   * The floating point second value in the half-open range [0, 60).
   */
  final double second;

  const _DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second);

  /**
   * Convert this date and time to the floating point number of days since the J2000 epoch.
   */
  double toDays() => _universalTimeDays(year, month, day, hour, minute, second);

  /**
   * Convert this date and time to a [_Time] value that can be used for astronomy calculations.
   */
  _Time toTime() => _Time.fromCalendar(year, month, day, hour, minute, second);

  /**
   * Converts this `DateTime` to ISO 8601 format, expressed in UTC with millisecond resolution.
   *
   * @return Example: "2019-08-30T17:45:22.763Z".
   */
  @override
  String toString() {
    // We want to round milliseconds down, not round to the nearest millisecond.
    // Otherwise, we have to handle very complicated logic of rounding up
    // seconds, minutes, hours, ... years, handling leap years, etc.
    // Nothing in Astronomy Engine requires sub-millisecond precision in string formats.

    final int wholeSeconds = second.toInt();
    final double millis = 1000.0 * (second - wholeSeconds);
    final int wholeMillis = millis.toInt();

    final String ytext;
    if (year < 0) {
      ytext = "-${(-year).toString().padLeft(6, '0')}";
    } else if (year <= 9999) {
      ytext = year.toString().padLeft(4, '0');
    } else {
      ytext = "+${year.toString().padLeft(6, '0')}";
    }

    return "$ytext-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}"
        "T${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:"
        "${wholeSeconds.toString().padLeft(2, '0')}.${wholeMillis.toString().padLeft(3, '0')}Z";
  }
}

_DateTime _dayValueToDateTime(double ut) {
  // Adapted from the NOVAS C 3.1 function cal_date()
  final djd = ut + 2451545.5;
  final int jd = djd.floor();

  var x = 24.0 * (djd % 1.0);
  if (x < 0.0) {
    x += 24.0;
  }
  final hour = x.toInt();
  x = 60.0 * (x % 1.0);
  final minute = x.toInt();
  final second = 60.0 * (x % 1.0);

  // This is my own adjustment to the NOVAS cal_date logic
  // so that it can handle dates much farther back in the past.
  // I add c*400 years worth of days at the front,
  // then subtract c*400 years at the back,
  // which avoids negative values in the formulas that mess up
  // the calendar date calculations.
  // Any multiple of 400 years has the same number of days,
  // because it eliminates all the special cases for leap years.
  const int c = 2500;

  var k = jd + (68569 + c * 146097);
  final n = (4 * k) ~/ 146097;
  k -= (146097 * n + 3) ~/ 4;
  final m = (4000 * (k + 1)) ~/ 1461001;
  k = k - (1461 * m) ~/ 4 + 31;

  var month = (80 * k) ~/ 2447;
  final day = (k - (2447 * month) ~/ 80);
  k = month ~/ 11;

  month = (month + 2 - 12 * k);
  final year = (100 * (n - 49) + m + k - 400 * c);

  return _DateTime(year, month, day, hour, minute, second);
}


/**
 * A date and time used for astronomical calculations.
 */
class _Time implements Comparable<_Time> {
  /**
   * UT1/UTC number of days since noon on January 1, 2000.
   *
   * The floating point number of days of Universal Time since noon UTC January 1, 2000.
   * Astronomy Engine approximates UTC and UT1 as being the same thing, although they are
   * not exactly equivalent; UTC and UT1 can disagree by up to plus or minus 0.9 seconds.
   * This approximation is sufficient for the accuracy requirements of Astronomy Engine.
   *
   * Universal Time Coordinate (UTC) is the international standard for legal and civil
   * timekeeping and replaces the older Greenwich Mean Time (GMT) standard.
   * UTC is kept in sync with unpredictable observed changes in the Earth's rotation
   * by occasionally adding leap seconds as needed.
   *
   * UT1 is an idealized time scale based on observed rotation of the Earth, which
   * gradually slows down in an unpredictable way over time, due to tidal drag by the Moon and Sun,
   * large scale weather events like hurricanes, and internal seismic and convection effects.
   * Conceptually, UT1 drifts from atomic time continuously and erratically, whereas UTC
   * is adjusted by a scheduled whole number of leap seconds as needed.
   *
   * The value in `ut` is appropriate for any calculation involving the Earth's rotation,
   * such as calculating rise/set times, culumination, and anything involving apparent
   * sidereal time.
   *
   * Before the era of atomic timekeeping, days based on the Earth's rotation
   * were often known as *mean solar days*.
   */
  final double ut;

  /**
   * Terrestrial Time days since noon on January 1, 2000.
   *
   * Terrestrial Time is an atomic time scale defined as a number of days since noon on January 1, 2000.
   * In this system, days are not based on Earth rotations, but instead by
   * the number of elapsed [SI seconds](https://physics.nist.gov/cuu/Units/second.html)
   * divided by 86400. Unlike `ut`, `tt` increases uniformly without adjustments
   * for changes in the Earth's rotation.
   *
   * The value in `tt` is used for calculations of movements not involving the Earth's rotation,
   * such as the orbits of planets around the Sun, or the Moon around the Earth.
   *
   * Historically, Terrestrial Time has also been known by the term *Ephemeris Time* (ET).
   */
  final double tt;

  /*
   * For internal use only. Used to optimize Earth tilt calculations.
   */
  double _psi = double.nan;

  /*
   * For internal use only. Used to optimize Earth tilt calculations.
   */
  double _eps = double.nan;

  /*
   * For internal use only. Lazy-caches sidereal time (Earth rotation).
   */
  double _st = double.nan;

  _Time._(this.ut, this.tt);

  _Time(double ut) : this._(ut, _terrestrialTime(ut));

  /**
   * Creates a `Time` object from a UTC year, month, day, hour, minute and second.
   *
   * @param year The UTC year value.
   * @param month The UTC month value 1..12.
   * @param day The UTC day of the month 1..31.
   * @param hour The UTC hour value 0..23.
   * @param minute The UTC minute value 0..59.
   * @param second The UTC second in the half-open range [0, 60).
   */
  _Time.fromCalendar(int year, int month, int day, int hour, int minute, double second)
      : this(_universalTimeDays(year, month, day, hour, minute, second));

  /**
   * Resolves this `Time` into year, month, day, hour, minute, second.
   */
  _DateTime _toDateTime() => _dayValueToDateTime(ut);

  /**
   * Converts this `Time` to the integer number of millseconds since 1970.
   */
  int _toMillisecondsSince1970() => ((ut + 10957.5) * _MILLISECONDS_PER_DAY).round();

  /**
   * Converts this `Time` to ISO 8601 format, expressed in UTC with millisecond resolution.
   *
   * @return Example: "2019-08-30T17:45:22.763Z".
   */
  @override
  String toString() => _toDateTime().toString();

  /**
   * Calculates the sum or difference of an [_Time] with a specified floating point number of days.
   *
   * Sometimes we need to adjust a given [_Time] value by a certain amount of time.
   * This function adds the given real number of days in `days` to the date and time in this object.
   *
   * More precisely, the result's Universal Time field `ut` is exactly adjusted by `days` and
   * the Terrestrial Time field `tt` is adjusted for the resulting UTC date and time,
   * using a best-fit piecewise polynomial model devised by
   * [Espenak and Meeus](https://eclipse.gsfc.nasa.gov/SEhelp/deltatpoly2004.html).
   *
   * @param days A floating point number of days by which to adjust `time`. May be negative, 0, or positive.
   * @return A date and time that is conceptually equal to `time + days`.
   */
  _Time _addDays(double days) => _Time(ut + days);

  double _julianCenturies() => tt / 36525.0;
  double _julianMillennia() => tt / _DAYS_PER_MILLENNIUM;

  /**
   * Compares the chronological order of two `Time` values.
   *
   * Two instances of `Time` can be compared for chronological order
   * using the usual operators like `t1 < t2` or `t1 == t2`.
   */
  @override
  int compareTo(_Time other) => tt.compareTo(other.tt);

  double _nutationPsi() => _psi;
  double _nutationEps() => _eps;

  /**
   * Creates a `Time` object from a Terrestrial Time day value.
   *
   * This function can be used in rare cases where a time must be based
   * on Terrestrial Time (TT) rather than Universal Time (UT).
   * Most developers will want to use `Time(ut)` with a universal time
   * instead of this function, because usually time is based on civil time adjusted
   * by leap seconds to match the Earth's rotation, rather than the uniformly
   * flowing TT used to calculate solar system dynamics. In rare cases
   * where the caller already knows TT, this function is provided to create
   * a `Time` value that can be passed to Astronomy Engine functions.
   *
   * @param tt The number of days after the J2000 epoch.
   */
  _Time._fromTerrestrialTime(double tt) : this._(_universalTime(tt), tt);

  /**
   * Creates a `Time` object from the number of milliseconds since the 1970 epoch.
   *
   * Operating systems and runtime libraries commonly measure civil time
   * in integer milliseconds since January 1, 1970 at 00:00 UTC (midnight).
   * To facilitate using such values for astronomy calculations, this
   * function converts a millsecond count into a `Time` object.
   */
  _Time._fromMillisecondsSince1970(int millis)
      : this((millis - 946728000000) / _MILLISECONDS_PER_DAY);
}


class _TerseVector {
  double x;
  double y;
  double z;

  _TerseVector(this.x, this.y, this.z);

  _Vector toAstroVector(_Time time) =>
      _Vector(x, y, z, time);

  _TerseVector operator +(_TerseVector other) =>
      _TerseVector(x + other.x, y + other.y, z + other.z);

  _TerseVector operator -(_TerseVector other) =>
      _TerseVector(x - other.x, y - other.y, z - other.z);

  _TerseVector operator -() =>
      _TerseVector(-x, -y, -z);

  _TerseVector operator *(double other) =>
      _TerseVector(x * other, y * other, z * other);

  _TerseVector operator /(double denom) =>
      _TerseVector(x / denom, y / denom, z / denom);

  _TerseVector mean(_TerseVector other) =>
      _TerseVector((x + other.x) / 2.0, (y + other.y) / 2.0, (z + other.z) / 2.0);

  double quadrature() => (x * x) + (y * y) + (z * z);
  double magnitude() => math.sqrt(quadrature());

  void decrement(_TerseVector other) {
    x -= other.x;
    y -= other.y;
    z -= other.z;
  }

  void increment(_TerseVector other) {
    x += other.x;
    y += other.y;
    z += other.z;
  }

  void mix(double ramp, _TerseVector other) {
    x = (1.0 - ramp) * x + ramp * other.x;
    y = (1.0 - ramp) * y + ramp * other.y;
    z = (1.0 - ramp) * z + ramp * other.z;
  }

  void setToZero() {
    x = 0.0;
    y = 0.0;
    z = 0.0;
  }

  void negate() {
    x = -x;
    y = -y;
    z = -z;
  }

  void copyFrom(_TerseVector other) {
    x = other.x;
    y = other.y;
    z = other.z;
  }

  static _TerseVector zero() => _TerseVector(0.0, 0.0, 0.0);
}



_Time _verifyIdenticalTimes(_Time t1, _Time t2) {
  if (t1.tt != t2.tt) {
    throw ArgumentError("Attempt to operate on two vectors from different times.");
  }
  return t1;
}


/**
 * A 3D Cartesian vector whose components are expressed in Astronomical Units (AU).
 */
class _Vector {
  /**
   * A Cartesian x-coordinate expressed in AU.
   */
  final double x;

  /**
   * A Cartesian y-coordinate expressed in AU.
   */
  final double y;

  /**
   * A Cartesian z-coordinate expressed in AU.
   */
  final double z;

  /**
   * The date and time at which this vector is valid.
   */
  final _Time t;

  const _Vector(this.x, this.y, this.z, this.t);

  /**
   * The total distance in AU represented by this vector.
   */
  double length() => math.sqrt((x * x) + (y * y) + (z * z));

  /**
   * Adds two vectors. Both operands must have identical times.
   */
  _Vector operator +(_Vector other) =>
      _Vector(x + other.x, y + other.y, z + other.z, _verifyIdenticalTimes(t, other.t));

  /**
   * Subtracts one vector from another. Both operands must have identical times.
   */
  _Vector operator -(_Vector other) =>
      _Vector(x - other.x, y - other.y, z - other.z, _verifyIdenticalTimes(t, other.t));

  /**
   * Negates a vector; the same as multiplying the vector by the scalar -1.
   */
  _Vector operator -() =>
      _Vector(-x, -y, -z, t);

  /**
   * Takes the dot product of two vectors.
   */
  double dot(_Vector other) {
    _verifyIdenticalTimes(t, other.t);
    return x * other.x + y * other.y + z * other.z;
  }

  /**
   * Calculates the angle in degrees (0..180) between two vectors.
   */
  double angleWith(_Vector other) {
    final d = (dot(other)) / (length() * other.length());
    if (d <= -1.0) {
      return 180.0;
    } else if (d >= 1.0) {
      return 0.0;
    } else {
      return math.acos(d).radiansToDegrees();
    }
  }

  /**
   * Divides a vector by a scalar.
   */
  _Vector operator /(double denom) =>
      _Vector(x / denom, y / denom, z / denom, t);

  /**
   * Converts Cartesian coordinates to spherical coordinates.
   *
   * Given a Cartesian vector, returns latitude, longitude, and distance.
   */
  _Spherical toSpherical() {
    final xyproj = x * x + y * y;
    final dist = math.sqrt(xyproj + z * z);
    final double lat;
    final double lon;
    if (xyproj == 0.0) {
      if (z == 0.0) {
        // Indeterminate coordinates; pos vector has zero length.
        throw ArgumentError("Cannot convert zero-length vector to spherical coordinates.");
      }
      lon = 0.0;
      lat = (z < 0.0) ? -90.0 : 90.0;
    } else {
      lon = _withMinDegreeValue(_datan2(y, x), 0.0);
      lat = _datan2(z, math.sqrt(xyproj));
    }
    return _Spherical(lat, lon, dist);
  }

  /**
   * Given an equatorial vector, calculates equatorial angular coordinates.
   */
  _Equatorial toEquatorial() {
    final sphere = toSpherical();
    return _Equatorial(sphere.lon / 15.0, sphere.lat, sphere.dist, this);
  }

  /**
   * Converts Cartesian coordinates to horizontal coordinates.
   *
   * Given a horizontal Cartesian vector, returns horizontal azimuth and altitude.
   * *IMPORTANT:* This function differs from [_Vector.toSpherical] in two ways:
   * - `toSpherical` returns a `lon` value that represents azimuth defined counterclockwise
   *   from north (e.g., west = +90), but this function represents a clockwise rotation
   *   (e.g., east = +90). The difference is because `toSpherical` is intended
   *   to preserve the vector "right-hand rule", while this function defines azimuth in a more
   *   traditional way as used in navigation and cartography.
   * - This function optionally corrects for atmospheric refraction, while `toSpherical`
   *   does not.
   *
   * The returned object contains the azimuth in `lon`.
   * It is measured in degrees clockwise from north: east = +90 degrees, west = +270 degrees.
   *
   * The altitude is stored in `lat`.
   *
   * The distance to the observed object is stored in `dist`,
   * and is expressed in astronomical units (AU).
   *
   * @param refraction
   * [Refraction.None]: no atmospheric refraction correction is performed.
   * [Refraction.Normal]: correct altitude for atmospheric refraction.
   * [Refraction.JplHor]: for JPL Horizons compatibility testing only; not recommended for normal use.
   */
  _Spherical toHorizontal(_Refraction refraction) {
    final sphere = toSpherical();
    return _Spherical(
      sphere.lat + _refractionAngle(refraction, sphere.lat),
      _toggleAzimuthDirection(sphere.lon),
      sphere.dist
    );
  }

  /**
   * Calculates the geographic location corresponding to a geocentric equatorial vector.
   *
   * This is the inverse function of [_Observer.toVector].
   * Given an equatorial vector from the center of the Earth to
   * an observer on or near the Earth's surface, this function returns
   * the geographic latitude, longitude, and elevation for that observer.
   *
   * @param equator
   * Selects the date of the Earth's equator in which this vector is expressed.
   * The caller may select [_EquatorEpoch.J2000] to use the orientation of the Earth's equator
   * at noon UTC on January 1, 2000, in which case this function corrects for precession
   * and nutation of the Earth as it was at the moment specified by the time `this.t`.
   * Or the caller may select [_EquatorEpoch.OfDate] to use the Earth's equator at `this.t`
   * as the orientation.
   *
   * @return The geographic coordinates corresponding to the vector.
   */
  _Observer toObserver(_EquatorEpoch equator) {
    final _Vector vector;
    switch (equator) {
      case _EquatorEpoch.J2000:
        vector = _gyration(this, _PrecessDirection.From2000);
        break;
      case _EquatorEpoch.OfDate:
        vector = this;
        break;
    }
    return _inverseTerra(vector);
  }

  /**
   * Creates a new vector with the same coordinates but a different time.
   *
   * Usually it is a mistake to add or subtract vectors corresponding
   * to different times. The overloaded operators for adding and subtracting
   * vectors will throw an exception if the times do not match.
   * However, occasionally it is helpful to adjust the time associated
   * with a vector to get around this safety check. For example,
   * the time an event occurs may be different from the time it is observed.
   * The `geoVector` function stores the observation time in the returned vector,
   * while `helioVector` stores the event time.
   *
   * @param time
   * A time to include in a new vector with the same coordinates as this one.
   *
   * @return
   * A cloned vector that has the same coordinates as this one, but at a different time.
   */
  _Vector withTime(_Time time) => _Vector(x, y, z, time);
}

/**
 * Multiply a scalar by a vector, yielding another vector.
 */
// NOTE: Kotlin defines `operator fun Double.times(vec: Vector)` at this location.
// Dart cannot override the built-in `double * Object` operator through an extension,
// so scalar*vector is expressed at call sites as `vector * scalar` or explicit
// component arithmetic instead.



/**
 * Represents a combined position vector and velocity vector at a given moment in time.
 */
class _StateVector {
  /**
   * A Cartesian position x-coordinate expressed in AU.
   */
  final double x;

  /**
   * A Cartesian position y-coordinate expressed in AU.
   */
  final double y;

  /**
   * A Cartesian position z-coordinate expressed in AU.
   */
  final double z;

  /**
   * A Cartesian velocity x-component expressed in AU/day.
   */
  final double vx;

  /**
   * A Cartesian velocity y-component expressed in AU/day.
   */
  final double vy;

  /**
   * A Cartesian velocity z-component expressed in AU/day.
   */
  final double vz;

  /**
   * The date and time at which this vector is valid.
   */
  final _Time t;

  const _StateVector(this.x, this.y, this.z, this.vx, this.vy, this.vz, this.t);

  /**
   * Combines a position vector and a velocity vector into a single state vector.
   *
   * @param pos   A position vector.
   * @param vel   A velocity vector.
   * @param time  The common time that represents the given position and velocity.
   */
  _StateVector.fromVectors(_Vector pos, _Vector vel, _Time time)
      : this(pos.x, pos.y, pos.z, vel.x, vel.y, vel.z, time);

  _StateVector._fromBodyState(_BodyState state, _Time time)
      : this(state.r.x, state.r.y, state.r.z, state.v.x, state.v.y, state.v.z, time);

  /**
   * Returns the position vector associated with this state vector.
   */
  _Vector position() => _Vector(x, y, z, t);

  /**
   * Returns the velocity vector associated with this state vector.
   */
  _Vector velocity() => _Vector(vx, vy, vz, t);

  /**
   * Adds two state vetors, yielding the state vector sum.
   */
  _StateVector operator +(_StateVector other) =>
      _StateVector(
        x + other.x,
        y + other.y,
        z + other.z,
        vx + other.vx,
        vy + other.vy,
        vz + other.vz,
        _verifyIdenticalTimes(t, other.t)
      );

  /**
   * Subtracts two state vetors, yielding the state vector difference.
   */
  _StateVector operator -(_StateVector other) =>
      _StateVector(
        x - other.x,
        y - other.y,
        z - other.z,
        vx - other.vx,
        vy - other.vy,
        vz - other.vz,
        _verifyIdenticalTimes(t, other.t)
      );

  /**
   * Divides a state vector by a scalar.
   */
  _StateVector operator /(double denom) =>
      _StateVector(
        x / denom,
        y / denom,
        z / denom,
        vx / denom,
        vy / denom,
        vz / denom,
        t
      );

  /**
   * Negates a state vector; the same as multiplying the state vector by the scalar -1.
   */
  _StateVector operator -() =>
      _StateVector(-x, -y, -z, -vx, -vy, -vz, t);
}


/**
 * Holds the positions and velocities of Jupiter's major 4 moons.
 *
 * The [_jupiterMoons] function returns an object of this type
 * to report position and velocity vectors for Jupiter's largest 4 moons
 * Io, Europa, Ganymede, and Callisto. Each position vector is relative
 * to the center of Jupiter. Both position and velocity are oriented in
 * the EQJ system (that is, using Earth's equator at the J2000 epoch).
 * The positions are expressed in astronomical units (AU),
 * and the velocities in AU/day.
 */
class _JupiterMoonsInfo {
  /**
   * The position and velocity of Jupiter's moon Io.
   */
  final _StateVector io;

  /**
   * The position and velocity of Jupiter's moon Europa.
   */
  final _StateVector europa;

  /**
   * The position and velocity of Jupiter's moon Ganymede.
   */
  final _StateVector ganymede;

  /**
   * The position and velocity of Jupiter's moon Callisto.
   */
  final _StateVector callisto;

  const _JupiterMoonsInfo(this.io, this.europa, this.ganymede, this.callisto);
}

/**
 * A rotation matrix that can be used to transform one coordinate system to another.
 */
class _RotationMatrix {
  /**
   * A 3x3 array of numbers to initialize the rotation matrix.
   */
  final List<List<double>> rot;

  _RotationMatrix.fromArray(this.rot) {
    if (rot.length != 3 || rot.any((it) => it.length != 3)) {
      throw ArgumentError("Rotation matrix must be a 3x3 array.");
    }
  }

  _RotationMatrix(
    double a00, double a01, double a02,
    double a10, double a11, double a12,
    double a20, double a21, double a22
  ) : rot = [
        [a00, a01, a02],
        [a10, a11, a12],
        [a20, a21, a22]
      ];

  /**
   * Calculates the inverse of a rotation matrix.
   *
   * Returns a rotation matrix that performs the reverse transformation
   * that this rotation matrix performs.
   */
  _RotationMatrix inverse() => _RotationMatrix(
    rot[0][0], rot[1][0], rot[2][0],
    rot[0][1], rot[1][1], rot[2][1],
    rot[0][2], rot[1][2], rot[2][2]
  );

  /**
   * Applies a rotation to a vector, yielding a rotated vector.
   *
   * This function transforms a vector in one orientation to a vector
   * in another orientation.
   *
   * @param vec
   * The vector whose orientation is to be changed.
   */
  _Vector rotate(_Vector vec) => _Vector(
    rot[0][0] * vec.x + rot[1][0] * vec.y + rot[2][0] * vec.z,
    rot[0][1] * vec.x + rot[1][1] * vec.y + rot[2][1] * vec.z,
    rot[0][2] * vec.x + rot[1][2] * vec.y + rot[2][2] * vec.z,
    vec.t
  );

  /**
   * Applies a rotation to a state vector, yielding a rotated state vector.
   *
   * This function transforms a state vector in one orientation to a state vector in another orientation.
   * The resulting state vector has both position and velocity reoriented.
   *
   * @param state
   * The state vector whose orientation is to be changed.
   * The value of `state` is not changed; the return value is a new state vector object.
   */
  _StateVector rotateState(_StateVector state) => _StateVector.fromVectors(
    rotate(state.position()),
    rotate(state.velocity()),
    state.t
  );

  /**
   * Creates a rotation based on applying one rotation followed by another.
   *
   * Given two rotation matrices, returns a combined rotation matrix that is
   * equivalent to rotating based on this matrix, followed by the matrix `other`.
   */
  _RotationMatrix combine(_RotationMatrix other) => _RotationMatrix(
    other.rot[0][0] * rot[0][0] + other.rot[1][0] * rot[0][1] + other.rot[2][0] * rot[0][2],
    other.rot[0][1] * rot[0][0] + other.rot[1][1] * rot[0][1] + other.rot[2][1] * rot[0][2],
    other.rot[0][2] * rot[0][0] + other.rot[1][2] * rot[0][1] + other.rot[2][2] * rot[0][2],
    other.rot[0][0] * rot[1][0] + other.rot[1][0] * rot[1][1] + other.rot[2][0] * rot[1][2],
    other.rot[0][1] * rot[1][0] + other.rot[1][1] * rot[1][1] + other.rot[2][1] * rot[1][2],
    other.rot[0][2] * rot[1][0] + other.rot[1][2] * rot[1][1] + other.rot[2][2] * rot[1][2],
    other.rot[0][0] * rot[2][0] + other.rot[1][0] * rot[2][1] + other.rot[2][0] * rot[2][2],
    other.rot[0][1] * rot[2][0] + other.rot[1][1] * rot[2][1] + other.rot[2][1] * rot[2][2],
    other.rot[0][2] * rot[2][0] + other.rot[1][2] * rot[2][1] + other.rot[2][2] * rot[2][2]
  );

  /**
   * Re-orients the rotation matrix by pivoting it by an angle around one of its axes.
   *
   * Given this rotation matrix, a selected coordinate axis, and an angle in degrees,
   * this function pivots the rotation matrix by that angle around that coordinate axis.
   * The function returns a new rotation matrix; it does not mutate this matrix.
   *
   * For example, if you have rotation matrix that converts ecliptic coordinates (ECL)
   * to horizontal coordinates (HOR), but you really want to convert ECL to the orientation
   * of a telescope camera pointed at a given body, you can use `RotationMatrix.pivot` twice:
   * (1) pivot around the zenith axis by the body's azimuth, then (2) pivot around the
   * western axis by the body's altitude angle. The resulting rotation matrix will then
   * reorient ECL coordinates to the orientation of your telescope camera.
   *
   * @param axis
   * An integer that selects which coordinate axis to rotate around:
   * 0 = x, 1 = y, 2 = z. Any other value will cause an exception.
   *
   * @param angle
   * An angle in degrees indicating the amount of rotation around the specified axis.
   * Positive angles indicate rotation counterclockwise as seen from the positive
   * direction along that axis, looking towards the origin point of the orientation system.
   * Any finite number of degrees is allowed, but best precision will result from keeping
   * `angle` in the range [-360, +360].
   */
  _RotationMatrix pivot(int axis, double angle) {
    if (axis < 0 || axis > 2) {
      throw ArgumentError("Invalid coordinate axis $axis. Must be 0..2.");
    }

    if (!angle.isFinite) {
      throw ArgumentError("Angle must be a finite number.");
    }

    final radians = angle.degreesToRadians();
    final c = math.cos(radians);
    final s = math.sin(radians);

    // We need to maintain the "right-hand" rule, no matter which
    // axis was selected. That means we pick (i, j, k) axis order
    // such that the following vector cross product is satisfied:
    // i x j = k
    final i = (axis + 1) % 3;
    final j = (axis + 2) % 3;
    final k = axis;

    final piv = [List<double>.filled(3, 0.0), List<double>.filled(3, 0.0), List<double>.filled(3, 0.0)];

    piv[i][i] = c * rot[i][i] - s * rot[i][j];
    piv[i][j] = s * rot[i][i] + c * rot[i][j];
    piv[i][k] = rot[i][k];
    piv[j][i] = c * rot[j][i] - s * rot[j][j];
    piv[j][j] = s * rot[j][i] + c * rot[j][j];
    piv[j][k] = rot[j][k];
    piv[k][i] = c * rot[k][i] - s * rot[k][j];
    piv[k][j] = s * rot[k][i] + c * rot[k][j];
    piv[k][k] = rot[k][k];

    return _RotationMatrix.fromArray(piv);
  }

  /**
   * Creates an identity rotation matrix.
   *
   * Creates a matrix that has no effect on orientation.
   * This matrix can be the starting point for other operations,
   * such as calling a series of [_RotationMatrix.combine] or [_RotationMatrix.pivot].
   */
  static _RotationMatrix identity() => _RotationMatrix(
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0
  );
}


/**
 * Spherical coordinates: latitude, longitude, distance.
 */
class _Spherical {
  /**
   * The latitude angle: -90..+90 degrees.
   */
  final double lat;

  /**
   * The longitude angle: 0..360 degrees.
   */
  final double lon;

  /**
   * Distance in AU.
   */
  final double dist;

  const _Spherical(this.lat, this.lon, this.dist);

  /**
   * Converts spherical coordinates to Cartesian coordinates.
   *
   * Given spherical coordinates and a time at which they are valid,
   * returns a vector of Cartesian coordinates. The returned value
   * includes the time, as required by the type [_Vector].
   *
   * @param time
   * The time that should be included in the return value.
   */
  _Vector toVector(_Time time) {
    final radlat = lat.degreesToRadians();
    final radlon = lon.degreesToRadians();
    final rcoslat = dist * math.cos(radlat);
    return _Vector(
      rcoslat * math.cos(radlon),
      rcoslat * math.sin(radlon),
      dist * math.sin(radlat),
      time
    );
  }

  /**
   * Given apparent angular horizontal coordinates, calculate the unrefracted horizontal vector.
   *
   * Assumes `this` contains apparent horizontal coordinates:
   * `lat` holds the refracted altitude angle,
   * `lon` holds the azimuth in degrees clockwise from north,
   * and `dist` holds the distance from the observer to the object in AU.
   *
   * @param time
   * The date and time of the observation. This is needed because the returned
   * [_Vector] requires a valid time value when passed to certain other functions.
   *
   * @param refraction
   * The refraction option used to model atmospheric lensing. See [refractionAngle].
   * This specifies how refraction is to be removed from the altitude stored in `this.lat`.
   *
   * @return A vector in the horizontal system: `x` = north, `y` = west, and `z` = zenith (up).
   */
  _Vector toVectorFromHorizon(_Time time, _Refraction refraction) =>
      _Spherical(
        lat + _inverseRefractionAngle(refraction, lat),
        _toggleAzimuthDirection(lon),
        dist
      )
      .toVector(time);
}

/**
 * The location of an observer on (or near) the surface of the Earth.
 *
 * This object is passed to functions that calculate phenomena as observed
 * from a particular place on the Earth.
 */
class _Observer {
  /**
   * Geographic latitude in degrees north (positive) or south (negative) of the equator.
   */
  final double latitude;

  /**
   * Geographic longitude in degrees east (positive) or west (negative) of the prime meridian at Greenwich, England.
   */
  final double longitude;

  /**
   * The height above (positive) or below (negative) sea level, expressed in meters.
   */
  final double height;

  const _Observer(this.latitude, this.longitude, this.height);

  /**
   * Calculates geocentric equatorial coordinates of an observer on the surface of the Earth.
   *
   * This function calculates a vector from the center of the Earth to
   * a point on or near the surface of the Earth, expressed in equatorial
   * coordinates. It takes into account the rotation of the Earth at the given
   * time, along with the given latitude, longitude, and elevation of the observer.
   *
   * The caller may pass a value in `equator` to select either [_EquatorEpoch.J2000]
   * for using J2000 coordinates, or [_EquatorEpoch.OfDate] for using coordinates relative
   * to the Earth's equator at the specified time.
   *
   * The returned vector has components expressed in astronomical units (AU).
   * To convert to kilometers, multiply the vector values by the scalar value [_KM_PER_AU].
   *
   * The inverse of this function is also available: [_Vector.toObserver].
   *
   * @param time
   * The date and time for which to calculate the observer's position vector.
   *
   * @param equator
   * Selects the date of the Earth's equator in which to express the equatorial coordinates.
   * The caller may select [_EquatorEpoch.J2000] to use the orientation of the Earth's equator
   * at noon UTC on January 1, 2000, in which case this function corrects for precession
   * and nutation of the Earth as it was at the moment specified by the `time` parameter.
   * Or the caller may select [_EquatorEpoch.OfDate] to use the Earth's equator at `time`
   * as the orientation.
   *
   * @return A vector from the center of the Earth to this geographic location.
   */
  _Vector toVector(_Time time, _EquatorEpoch equator) =>
      toStateVector(time, equator).position();

  /**
   * Calculates geocentric equatorial position and velocity of an observer on the surface of the Earth.
   *
   * This function calculates position and velocity vectors of an observer
   * on or near the surface of the Earth, expressed in equatorial
   * coordinates. It takes into account the rotation of the Earth at the given
   * time, along with the given latitude, longitude, and elevation of the observer.
   *
   * The caller may pass a value in `equator` to select either [_EquatorEpoch.J2000]
   * for using J2000 coordinates, or [_EquatorEpoch.OfDate] for using coordinates relative
   * to the Earth's equator at the specified time.
   *
   * The returned position vector has components expressed in astronomical units (AU).
   * To convert to kilometers, multiply the vector values by the scalar value [_KM_PER_AU].
   *
   * The returned velocity vector is measured in AU/day.
   *
   * @param time
   * The date and time for which to calculate the observer's position vector.
   *
   * @param equator
   * Selects the date of the Earth's equator in which to express the equatorial coordinates.
   * The caller may select [_EquatorEpoch.J2000] to use the orientation of the Earth's equator
   * at noon UTC on January 1, 2000, in which case this function corrects for precession
   * and nutation of the Earth as it was at the moment specified by the `time` parameter.
   * Or the caller may select [_EquatorEpoch.OfDate] to use the Earth's equator at `time`
   * as the orientation.
   *
   * @return The position and velocity of this observer with respect to the Earth's center.
   */
  _StateVector toStateVector(_Time time, _EquatorEpoch equator) {
    final state = _terra(this, time);
    switch (equator) {
      case _EquatorEpoch.OfDate:
        return state;
      case _EquatorEpoch.J2000:
        return _gyrationPosVel(state, _PrecessDirection.Into2000);
    }
  }
}
/**
 * Selects the date for which the Earth's equator is to be used for representing equatorial coordinates.
 *
 * The Earth's equator is not always in the same plane due to precession and nutation.
 *
 * Sometimes it is useful to have a fixed plane of reference for equatorial coordinates
 * across different calendar dates.  In these cases, a fixed *epoch*, or reference time,
 * is helpful. Astronomy Engine provides the J2000 epoch for such cases.  This refers
 * to the plane of the Earth's orbit as it was on noon UTC on 1 January 2000.
 *
 * For some other purposes, it is more helpful to represent coordinates using the Earth's
 * equator exactly as it is on that date. For example, when calculating rise/set times
 * or horizontal coordinates, it is most accurate to use the orientation of the Earth's
 * equator at that same date and time. For these uses, Astronomy Engine allows *of-date*
 * calculations.
 */
enum _EquatorEpoch {
  /**
   * Represent equatorial coordinates in the J2000 epoch.
   */
  J2000,

  /**
   * Represent equatorial coordinates using the Earth's equator at the given date and time.
   */
  OfDate,
}


/**
 * Aberration calculation options.
 *
 * [Aberration](https://en.wikipedia.org/wiki/Aberration_of_light) is an effect
 * causing the apparent direction of an observed body to be shifted due to transverse
 * movement of the Earth with respect to the rays of light coming from that body.
 * This angular correction can be anywhere from 0 to about 20 arcseconds,
 * depending on the position of the observed body relative to the instantaneous
 * velocity vector of the Earth.
 *
 * Some Astronomy Engine functions allow optional correction for aberration by
 * passing in a value of this enumerated type.
 *
 * Aberration correction is useful to improve accuracy of coordinates of
 * apparent locations of bodies seen from the Earth.
 * However, because aberration affects not only the observed body (such as a planet)
 * but the surrounding stars, aberration may be unhelpful (for example)
 * for determining exactly when a planet crosses from one constellation to another.
 */
enum _Aberration {
  /**
   * Request correction for aberration.
   */
  Corrected,

  /**
   * Do not correct for aberration.
   */
  None,
}


/**
 * Selects whether to correct for atmospheric refraction, and if so, how.
 */
enum _Refraction {
  /**
   * No atmospheric refraction correction (airless).
   */
  None,

  /**
   * Recommended correction for standard atmospheric refraction.
   */
  Normal,

  /**
   * Used only for compatibility testing with JPL Horizons online tool.
   */
  JplHor,
}


/**
 * Selects whether to search for a rising event or a setting event for a celestial body.
 */
enum _Direction {
  /**
   * Indicates a rising event: a celestial body is observed to rise above the horizon by an observer on the Earth.
   */
  Rise(1),

  /**
   * Indicates a setting event: a celestial body is observed to sink below the horizon by an observer on the Earth.
   */
  Set(-1);

  /**
   * A numeric value that is helpful in formulas involving rise/set.
   * The sign is +1 for a rising event, or -1 for a setting event.
   */
  final int sign;
  const _Direction(this.sign);
}


/**
 * Indicates whether a body (especially Mercury or Venus) is best seen in the morning or evening.
 */
enum _Visibility {
  /**
   * The body is best visible in the morning, before sunrise.
   */
  Morning,

  /**
   * The body is best visible in the evening, after sunset.
   */
  Evening,
}


/**
 * Equatorial angular and cartesian coordinates.
 *
 * Coordinates of a celestial body as seen from the Earth
 * (geocentric or topocentric, depending on context),
 * oriented with respect to the projection of the Earth's equator onto the sky.
 */
class _Equatorial {
  /**
   * Right ascension in sidereal hours.
   */
  final double ra;

  /**
   * Declination in degrees.
   */
  final double dec;

  /**
   * Distance to the celestial body in AU.
   */
  final double dist;

  /**
   * Equatorial coordinates in cartesian vector form: x = March equinox, y = June solstice, z = north.
   */
  final _Vector vec;

  const _Equatorial(this.ra, this.dec, this.dist, this.vec);
}


/**
 * Ecliptic angular and Cartesian coordinates.
 *
 * Coordinates of a celestial body as seen from the center of the Sun (heliocentric),
 * oriented with respect to the plane of the Earth's orbit around the Sun (the ecliptic).
 */
class _Ecliptic {
  /**
   * Cartesian ecliptic vector, with components as follows:
   * x: the direction of the equinox along the ecliptic plane.
   * y: in the ecliptic plane 90 degrees prograde from the equinox.
   * z: perpendicular to the ecliptic plane. Positive is north.
   */
  final _Vector vec;

  /**
   * Latitude in degrees north (positive) or south (negative) of the ecliptic plane.
   */
  final double elat;

  /**
   * Longitude in degrees around the ecliptic plane prograde from the equinox.
   */
  final double elon;

  const _Ecliptic(this.vec, this.elat, this.elon);
}


/**
 * Coordinates of a celestial body as seen by a topocentric observer.
 *
 * Horizontal and equatorial coordinates seen by an observer on or near
 * the surface of the Earth (a topocentric observer).
 * Optionally corrected for atmospheric refraction.
 */
class _Topocentric {
  /**
   * Compass direction around the horizon in degrees. 0=North, 90=East, 180=South, 270=West.
   */
  final double azimuth;

  /**
   * Angle in degrees above (positive) or below (negative) the observer's horizon.
   */
  final double altitude;

  /**
   * Right ascension in sidereal hours.
   */
  final double ra;

  /**
   * Declination in degrees.
   */
  final double dec;

  const _Topocentric(this.azimuth, this.altitude, this.ra, this.dec);
}


/**
 * The dates and times of changes of season for a given calendar year.
 *
 * Call [seasons] to calculate this data structure for a given year.
 */
class _SeasonsInfo {
  /**
   * The date and time of the March equinox for the specified year.
   */
  final _Time marchEquinox;

  /**
   * The date and time of the June soltice for the specified year.
   */
  final _Time juneSolstice;

  /**
   * The date and time of the September equinox for the specified year.
   */
  final _Time septemberEquinox;

  /**
   * The date and time of the December solstice for the specified year.
   */
  final _Time decemberSolstice;

  const _SeasonsInfo(this.marchEquinox, this.juneSolstice, this.septemberEquinox, this.decemberSolstice);
}


/**
 * Information about idealized atmospheric variables at a given elevation.
 */
class _AtmosphereInfo {
  /**
   * Atmospheric pressure in pascals.
   */
  final double pressure;

  /**
   * Atmospheric temperature in kelvins.
   */
  final double temperature;

  /**
   * Atmospheric density relative to sea level.
   */
  final double density;

  const _AtmosphereInfo(this.pressure, this.temperature, this.density);
}



/**
 * A lunar quarter event (new moon, first quarter, full moon, or third quarter) along with its date and time.
 */
class _MoonQuarterInfo {
  /**
  * 0=new moon, 1=first quarter, 2=full moon, 3=third quarter.
  */
  final int quarter;

  /**
  * The date and time of the lunar quarter.
  */
  final _Time time;

  const _MoonQuarterInfo(this.quarter, this.time);
}


/**
 * Lunar libration angles, returned by [libration].
 */
class _LibrationInfo {
  /**
   * Sub-Earth libration ecliptic latitude angle, in degrees.
   */
  final double elat;

  /**
   * Sub-Earth libration ecliptic longitude angle, in degrees.
   */
  final double elon;

  /**
   * Moon's geocentric ecliptic latitude.
   */
  final double mlat;

  /**
   * Moon's geocentric ecliptic longitude.
   */
  final double mlon;

  /**
   * Distance between the centers of the Earth and Moon in kilometers.
   */
  final double distanceKm;

  /**
   * The apparent angular diameter of the Moon, in degrees, as seen from the center of the Earth.
   */
  final double diamDeg;

  const _LibrationInfo(this.elat, this.elon, this.mlat, this.mlon, this.distanceKm, this.diamDeg);
}


/**
 * Information about a celestial body crossing a specific hour angle.
 *
 * Returned by the function [_searchHourAngle] to report information about
 * a celestial body crossing a certain hour angle as seen by a specified topocentric observer.
 */
class _HourAngleInfo {
  /**
   * The date and time when the body crosses the specified hour angle.
   */
  final _Time time;

  /**
   * Apparent coordinates of the body at the time it crosses the specified hour angle.
   */
  final _Topocentric hor;

  const _HourAngleInfo(this.time, this.hor);
}


/**
 * Contains information about the visibility of a celestial body at a given date and time.
 *
 * See [elongation] for more detailed information about the members of this class.
 * See also [searchMaxElongation] for how to search for maximum elongation events.
 */
class _ElongationInfo {
  /**
   * The date and time of the observation.
   */
  final _Time time;

  /**
   * Whether the body is best seen in the morning or the evening.
   */
  final _Visibility visibility;

  /**
   * The angle in degrees between the body and the Sun, as seen from the Earth.
   */
  final double _elongation;

  /**
   * The difference between the ecliptic longitudes of the body and the Sun, as seen from the Earth.
   */
  final double eclipticSeparation;

  static void _validateAngle(double angle, String name) {
    if (angle < 0.0 || angle > 180.0) {
      throw _InternalError("$name angle is not in the required range [0, 180].");
    }
  }

  _ElongationInfo(this.time, this.visibility, this._elongation, this.eclipticSeparation) {
    _validateAngle(_elongation, "Elongation");
    _validateAngle(eclipticSeparation, "Ecliptic separation");
  }
}


/**
 * The type of apsis: pericenter (closest approach) or apocenter (farthest distance).
 */
enum _ApsisKind {
  /**
   * The body is at its closest approach to the object it orbits.
   */
  Pericenter,

  /**
   * The body is at its farthest distance from the object it orbits.
   */
  Apocenter,
}


/**
 * An apsis event: pericenter (closest approach) or apocenter (farthest distance).
 *
 * For the Moon orbiting the Earth, or a planet orbiting the Sun, an *apsis* is an
 * event where the orbiting body reaches its closest or farthest point from the primary body.
 * The closest approach is called *pericenter* and the farthest point is *apocenter*.
 *
 * More specific terminology is common for particular orbiting bodies.
 * The Moon's closest approach to the Earth is called *perigee* and its farthest
 * point is called *apogee*. The closest approach of a planet to the Sun is called
 * *perihelion* and the furthest point is called *aphelion*.
 *
 * This data structure is returned by [searchLunarApsis] and [nextLunarApsis]
 * to iterate through consecutive alternating perigees and apogees.
 */
class _ApsisInfo {
  /**
   * The date and time of the apsis.
   */
  final _Time time;

  /**
   * Whether this is a pericenter or apocenter event.
   */
  final _ApsisKind kind;

  /**
   * The distance between the centers of the bodies in astronomical units.
   */
  final double distanceAu;

  /**
   * The distance between the centers of the bodies in kilometers.
   */
  final double distanceKm;

  _ApsisInfo(this.time, this.kind, this.distanceAu)
      : distanceKm = distanceAu * _KM_PER_AU;
}

/**
 * The different kinds of lunar/solar eclipses.
 */
enum _EclipseKind {
  /**
   * A penumbral lunar eclipse. (Never used for a solar eclipse.)
   */
  Penumbral,

  /**
   * A partial lunar/solar eclipse.
   */
  Partial,

  /**
   * An annular solar eclipse. (Never used for a lunar eclipse.)
   */
  Annular,

  /**
   * A total lunar/solar eclipse.
   */
  Total,
}


/**
 * Information about a lunar eclipse.
 *
 * Returned by [_searchLunarEclipse] or [_nextLunarEclipse]
 * to report information about a lunar eclipse event.
 * When a lunar eclipse is found, it is classified as penumbral, partial, or total.
 * Penumbral eclipses are difficult to observe, because the Moon is only slightly dimmed
 * by the Earth's penumbra; no part of the Moon touches the Earth's umbra.
 * Partial eclipses occur when part, but not all, of the Moon touches the Earth's umbra.
 * Total eclipses occur when the entire Moon passes into the Earth's umbra.
 *
 * The `kind` field thus holds `EclipseKind.Penumbral`, `EclipseKind.Partial`,
 * or `EclipseKind.Total`, depending on the kind of lunar eclipse found.
 *
 * The `obscuration` field holds a value in the range [0, 1] that indicates what fraction
 * of the Moon's apparent disc area is covered by the Earth's umbra at the eclipse's peak.
 * This indicates how dark the peak eclipse appears. For penumbral eclipses, the obscuration
 * is 0, because the Moon does not pass through the Earth's umbra. For partial eclipses,
 * the obscuration is somewhere between 0 and 1. For total lunar eclipses, the obscuration is 1.
 *
 * Field `peak` holds the date and time of the center of the eclipse, when it is at its peak.
 *
 * Fields `sdPenum`, `sdPartial`, and `sdTotal` hold the semi-duration of each phase
 * of the eclipse, which is half of the amount of time the eclipse spends in each
 * phase (expressed in minutes), or 0.0 if the eclipse never reaches that phase.
 * By converting from minutes to days, and subtracting/adding with `peak`, the caller
 * may determine the date and time of the beginning/end of each eclipse phase.
 */
class _LunarEclipseInfo {
  /**
   * The type of lunar eclipse found.
   */
  final _EclipseKind kind;

  /**
   * The peak fraction of the Moon's apparent disc that is covered by the Earth's umbra.
   */
  final double obscuration;

  /**
   * The time of the eclipse at its peak.
   */
  final _Time peak;

  /**
   * The semi-duration of the penumbral phase in minutes.
   */
  final double sdPenum;

  /**
   * The semi-duration of the partial phase in minutes, or 0.0 if none.
   */
  final double sdPartial;

  /**
   * The semi-duration of the total phase in minutes, or 0.0 if none.
   */
  final double sdTotal;

  const _LunarEclipseInfo(this.kind, this.obscuration, this.peak, this.sdPenum, this.sdPartial, this.sdTotal);
}


/**
 * Reports the time and geographic location of the peak of a solar eclipse.
 *
 * Returned by [searchGlobalSolarEclipse] or [nextGlobalSolarEclipse]
 * to report information about a solar eclipse event.
 *
 * The eclipse is classified as partial, annular, or total, depending on the
 * maximum amount of the Sun's disc obscured, as seen at the peak location
 * on the surface of the Earth.
 *
 * The `kind` field thus holds `EclipseKind.Partial`, `EclipseKind.Annular`, or `EclipseKind.Total`.
 * A total eclipse is when the peak observer sees the Sun completely blocked by the Moon.
 * An annular eclipse is like a total eclipse, but the Moon is too far from the Earth's surface
 * to completely block the Sun; instead, the Sun takes on a ring-shaped appearance.
 * A partial eclipse is when the Moon blocks part of the Sun's disc, but nobody on the Earth
 * observes either a total or annular eclipse.
 *
 * If `kind` is `EclipseKind.Total` or `EclipseKind.Annular`, the `latitude` and `longitude`
 * fields give the geographic coordinates of the center of the Moon's shadow projected
 * onto the daytime side of the Earth at the instant of the eclipse's peak.
 * If `kind` has any other value, `latitude` and `longitude` are undefined and should
 * not be used.
 *
 * For total or annular eclipses, the `obscuration` field holds the fraction (0, 1]
 * of the Sun's apparent disc area that is blocked from view by the Moon's silhouette,
 * as seen by an observer located at the geographic coordinates `latitude`, `longitude`
 * at the darkest time `peak`. The value will always be 1 for total eclipses, and less than
 * 1 for annular eclipses.
 * For partial eclipses, `obscuration` is undefined and should not be used.
 * This is because there is little practical use for an obscuration value of
 * a partial eclipse without supplying a particular observation location.
 * Developers who wish to find an obscuration value for partial solar eclipses should therefore use
 * [_searchLocalSolarEclipse] and provide the geographic coordinates of an observer.
 */
class _GlobalSolarEclipseInfo {
  /**
   * The type of solar eclipse: `EclipseKind.Partial`, `EclipseKind.Annular`, or `EclipseKind.Total`.
   */
  final _EclipseKind kind;

  /**
   * The peak fraction of the Sun's apparent disc area obscured by the Moon (total and annular eclipses only).
   */
  final double obscuration;

  /**
   * The date and time when the solar eclipse is darkest.
   * This is the instant when the axis of the Moon's shadow cone passes closest to the Earth's center.
   */
  final _Time peak;

  /**
   * The distance between the Sun/Moon shadow axis and the center of the Earth, in kilometers.
   */
  final double distance;

  /**
   * The geographic latitude at the center of the peak eclipse shadow.
   */
  final double latitude;

  /**
   * The geographic longitude at the center of the peak eclipse shadow.
   */
  final double longitude;

  const _GlobalSolarEclipseInfo(this.kind, this.obscuration, this.peak, this.distance, this.latitude, this.longitude);
}


/**
 * Holds a time and the observed altitude of the Sun at that time.
 *
 * When reporting a solar eclipse observed at a specific location on the Earth
 * (a "local" solar eclipse), a series of events occur. In addition
 * to the time of each event, it is important to know the altitude of the Sun,
 * because each event may be invisible to the observer if the Sun is below
 * the horizon (i.e. it at night).
 *
 * If `altitude` is negative, the event is theoretical only; it would be
 * visible if the Earth were transparent, but the observer cannot actually see it.
 * If `altitude` is positive but less than a few degrees, visibility will be impaired by
 * atmospheric interference (sunrise or sunset conditions).
 */
class _EclipseEvent {
  /**
   * The date and time of the event.
   */
  final _Time time;

  /**
   * The angular altitude of the center of the Sun above/below the horizon, at `time`,
   * corrected for atmospheric refraction and expressed in degrees.
   */
  final double altitude;

  const _EclipseEvent(this.time, this.altitude);
}


/**
 * Information about a solar eclipse as seen by an observer at a given time and geographic location.
 *
 * Returned by [_searchLocalSolarEclipse] or [_nextLocalSolarEclipse]
 * to report information about a solar eclipse as seen at a given geographic location.
 *
 * When a solar eclipse is found, it is classified as partial, annular, or total.
 * The `kind` field thus holds `EclipseKind.Partial`, `EclipseKind.Annular`, or `EclipseKind.Total`.
 * A partial solar eclipse is when the Moon does not line up directly enough with the Sun
 * to completely block the Sun's light from reaching the observer.
 * An annular eclipse occurs when the Moon's disc is completely visible against the Sun
 * but the Moon is too far away to completely block the Sun's light; this leaves the
 * Sun with a ring-like appearance.
 * A total eclipse occurs when the Moon is close enough to the Earth and aligned with the
 * Sun just right to completely block all sunlight from reaching the observer.
 *
 * The `obscuration` field reports what fraction of the Sun's disc appears blocked
 * by the Moon when viewed by the observer at the peak eclipse time.
 * This is a value that ranges from 0 (no blockage) to 1 (total eclipse).
 * The obscuration value will be between 0 and 1 for partial eclipses and annular eclipses.
 * The value will be exactly 1 for total eclipses. Obscuration gives an indication
 * of how dark the eclipse appears.
 *
 * There are 5 "event" fields, each of which contains a time and a solar altitude.
 * Field `peak` holds the date and time of the center of the eclipse, when it is at its peak.
 * The fields `partialBegin` and `partialEnd` are always set, and indicate when
 * the eclipse begins/ends. If the eclipse reaches totality or becomes annular,
 * `totalBegin` and `totalEnd` indicate when the total/annular phase begins/ends.
 * When an event field is valid, the caller must also check its `altitude` field to
 * see whether the Sun is above the horizon at the time indicated by the `time` field.
 */
class _LocalSolarEclipseInfo {
  /**
   * The type of solar eclipse: `EclipseKind.Partial`, `EclipseKind.Annular`, or `EclipseKind.Total`.
   */
  final _EclipseKind kind;

  /**
   * The fraction of the Sun's apparent disc area obscured by the Moon at the eclipse peak.
   */
  final double obscuration;

  /**
   * The time and Sun altitude at the beginning of the eclipse.
   */
  final _EclipseEvent partialBegin;

  /**
   * If this is an annular or a total eclipse, the time and Sun altitude when annular/total phase begins; otherwise `null`.
   */
  final _EclipseEvent? totalBegin;

  /**
   * The time and Sun altitude when the eclipse reaches its peak.
   */
  final _EclipseEvent peak;

  /**
   * If this is an annular or a total eclipse, the time and Sun altitude when annular/total phase ends; otherwise `null`.
   */
  final _EclipseEvent? totalEnd;

  /**
   * The time and Sun altitude at the end of the eclipse.
   */
  final _EclipseEvent partialEnd;

  const _LocalSolarEclipseInfo(this.kind, this.obscuration, this.partialBegin, this.totalBegin, this.peak, this.totalEnd, this.partialEnd);
}


/**
 * Information about a transit of Mercury or Venus, as seen from the Earth.
 *
 * Returned by [searchTransit] or [nextTransit] to report
 * information about a transit of Mercury or Venus.
 * A transit is when Mercury or Venus passes between the Sun and Earth so that
 * the other planet is seen in silhouette against the Sun.
 *
 * The `start` field reports the moment in time when the planet first becomes
 * visible against the Sun in its background.
 * The `peak` field reports when the planet is most aligned with the Sun,
 * as seen from the Earth.
 * The `finish` field reports the last moment when the planet is visible
 * against the Sun in its background.
 *
 * The calculations are performed from the point of view of a geocentric observer.
 */
class _TransitInfo {
  /**
   * Date and time at the beginning of the transit.
   */
  final _Time start;

  /**
   * Date and time of the peak of the transit.
   */
  final _Time peak;

  /**
   * Date and time at the end of the transit.
   */
  final _Time finish;

  /**
   * Angular separation in arcminutes between the centers of the Sun and the planet at time `peak`.
   */
  final double separation;

  const _TransitInfo(this.start, this.peak, this.finish, this.separation);
}

class _ShadowInfo {
  /**
   * The time of the shadow state.
   */
  final _Time time;

  /**
   * km distance between center of Moon and the line passing through the centers of the Sun and Earth.
   */
  final double r;

  /**
   * Umbra radius in km, at the shadow plane.
   */
  final double k;

  /**
   * Penumbra radius in km, at the shadow plane.
   */
  final double p;

  /**
   * Coordinates of target body relative to shadow-casting body at `time`.
   */
  final _Vector target;

  /**
   * Heliocentric coordinates of shadow-casting body at `time`.
   */
  final _Vector dir;

  const _ShadowInfo(this.time, this.r, this.k, this.p, this.target, this.dir);
}

_ShadowInfo _calcShadow(
  double bodyRadiusKm,
  _Time time,
  _Vector target,
  _Vector dir
) {
  final u = (dir.dot(target)) / (dir.dot(dir));
  final dx = (u * dir.x) - target.x;
  final dy = (u * dir.y) - target.y;
  final dz = (u * dir.z) - target.z;
  final r = _KM_PER_AU * math.sqrt(dx * dx + dy * dy + dz * dz);
  final k = _SUN_RADIUS_KM - (1.0 + u) * (_SUN_RADIUS_KM - bodyRadiusKm);
  final p = -_SUN_RADIUS_KM + (1.0 + u) * (_SUN_RADIUS_KM + bodyRadiusKm);
  return _ShadowInfo(time, r, k, p, target, dir);
}

_ShadowInfo _earthShadow(_Time time) {
  // This function helps find when the Earth's shadow falls upon the Moon.
  final s = _geoVector(_Body.Sun, time, _Aberration.Corrected);
  final m = _geoMoon(time);
  return _calcShadow(_EARTH_ECLIPSE_RADIUS_KM, time, m, -s);
}

_ShadowInfo _moonShadow(_Time time) {
  // This function helps find when the Moon's shadow falls upon the Earth.
  final s = _geoVector(_Body.Sun, time, _Aberration.Corrected);
  final m = _geoMoon(time);

  // -m  = lunacentric Earth
  // m-s = heliocentric Moon
  return _calcShadow(_MOON_MEAN_RADIUS_KM, time, -m, m - s);
}

_ShadowInfo _localMoonShadow(_Time time, _Observer observer) {
  // Calculate observer's geocentric position.
  final o = _geoPos(time, observer);

  // Calculate light-travel and aberration corrected Sun.
  final s = _geoVector(_Body.Sun, time, _Aberration.Corrected);

  // Calculate geocentric Moon.
  final m = _geoMoon(time);

  // o-m = lunacentric observer
  // m-s = heliocentric Moon
  return _calcShadow(_MOON_MEAN_RADIUS_KM, time, o - m, m - s);
}

_ShadowInfo _planetShadow(_Body body, double planetRadiusKm, _Time time) {
  // Calculate light-travel-corrected vector from Earth to planet.
  final g = _geoVector(body, time, _Aberration.Corrected);

  // Calculate light-travel-corrected vector from Earth to Sun.
  final e = _geoVector(_Body.Sun, time, _Aberration.Corrected);

  // -g  = planetocentric Earth
  // g-e = heliocentric planet
  return _calcShadow(planetRadiusKm, time, -g, g - e);
}

double _shadowSemiDurationMinutes(_Time centerTime, double radiusLimit, double windowMinutes) {
  // Search backwards and forwards from the center time until
  // the shadow axis distance crosses the specified radius limit.
  final windowDays = windowMinutes / _MINUTES_PER_DAY;
  final before = centerTime._addDays(-windowDays);
  final after = centerTime._addDays(windowDays);
  final t1 = _searchEarthShadow(radiusLimit, -1.0, before, centerTime);
  final t2 = _searchEarthShadow(radiusLimit, 1.0, centerTime, after);
  // Convert days to minutes and average the semi-durations.
  return (t2.ut - t1.ut) * (_MINUTES_PER_DAY / 2.0);
}

_Time _searchEarthShadow(double radiusLimit, double direction, _Time t1, _Time t2) {
  return _search(t1, t2, 1.0, (time) {
    return direction * (_earthShadow(time).r - radiusLimit);
  }) ?? (throw _InternalError("Failed to find Earth shadow transition."));
}

// We can get away with creating a single Earth shadow slope context
// because it contains no state and it has no side-effects.
// This reduces memory allocation overhead and is thread-safe.
double _earthShadowSlopeContext(_Time time) {
  final dt = 1.0 / _SECONDS_PER_DAY;
  final t1 = time._addDays(-dt);
  final t2 = time._addDays(dt);
  final shadow1 = _earthShadow(t1);
  final shadow2 = _earthShadow(t2);
  return (shadow2.r - shadow1.r) / dt;
}

_ShadowInfo _peakEarthShadow(_Time searchCenterTime) {
  final window = 0.03;      // initial search window, in days, before/after searchCenterTime
  final t1 = searchCenterTime._addDays(-window);
  final t2 = searchCenterTime._addDays(window);
  final tx = _search(t1, t2, 1.0, _earthShadowSlopeContext) ??
      (throw _InternalError("Failed to find Earth peak shadow event."));
  return _earthShadow(tx);
}

double _moonShadowSlopeContext(_Time time) {
  final dt = 1.0 / _SECONDS_PER_DAY;
  final t1 = time._addDays(-dt);
  final t2 = time._addDays(dt);
  final shadow1 = _moonShadow(t1);
  final shadow2 = _moonShadow(t2);
  return (shadow2.r - shadow1.r) / dt;
}

_ShadowInfo _peakMoonShadow(_Time searchCenterTime) {
  // Search for when the Moon's shadow axis is closest to the center of the Earth.
  final window = 0.03;      // days before/after new moon to search for minimum shadow distance
  final t1 = searchCenterTime._addDays(-window);
  final t2 = searchCenterTime._addDays(window);
  final tx = _search(t1, t2, 1.0, _moonShadowSlopeContext) ??
      (throw _InternalError("Failed to find Moon peak shadow event."));
  return _moonShadow(tx);
}

_ShadowInfo _peakLocalMoonShadow(_Time searchCenterTime, _Observer observer) {
  // Search for the time near searchCenterTime that the Moon's shadow axis
  // comes closest to the given observer.
  final window = 0.2;
  final time1 = searchCenterTime._addDays(-window);
  final time2 = searchCenterTime._addDays(window);
  final time = _search(time1, time2, 1.0, (time) {
    final dt = 1.0 / _SECONDS_PER_DAY;
    final t1 = time._addDays(-dt);
    final t2 = time._addDays(dt);
    final shadow1 = _localMoonShadow(t1, observer);
    final shadow2 = _localMoonShadow(t2, observer);
    return (shadow2.r - shadow1.r) / dt;
  }) ?? (throw _InternalError("Failed to find local Moon peak shadow event."));
  return _localMoonShadow(time, observer);
}

_ShadowInfo _peakPlanetShadow(_Body body, double planetRadiusKm, _Time searchCenterTime) {
  // Search for when the body's shadow axis is closest to the center of the Earth.
  final window = 1.0;       // days before/after conjunction to search for minimum shadow distance
  final t1 = searchCenterTime._addDays(-window);
  final t2 = searchCenterTime._addDays(window);
  final time = _search(t1, t2, 1.0, (time) {
    final dt = 1.0 / _SECONDS_PER_DAY;
    final shadow1 = _planetShadow(body, planetRadiusKm, time._addDays(-dt));
    final shadow2 = _planetShadow(body, planetRadiusKm, time._addDays(dt));
    return (shadow2.r - shadow1.r) / dt;
  }) ?? (throw _InternalError("Failed to find peak planet shadow event."));
  return _planetShadow(body, planetRadiusKm, time);
}

_Time _planetTransitBoundary(_Body body, double planetRadiusKm, _Time t1, _Time t2, double direction) {
  // Search for the time when the planet's penumbra begins/ends making contact with the center of the Earth.
  return _search(t1, t2, 1.0, (time) {
    final shadow = _planetShadow(body, planetRadiusKm, time);
    return direction * (shadow.r - shadow.p);
  }) ?? (throw _InternalError("Planet transit boundary search failed."));
}

double _discObscuration(double a, double b, double c) {
  // a = radius of first disc
  // b = radius of second disc
  // c = distance between centers of discs
  if (a <= 0.0) throw _InternalError("Radius of first disc must be positive.");
  if (b <= 0.0) throw _InternalError("Radius of second disc must be positive.");
  if (c < 0.0) throw _InternalError("Distance between discs is not allowed to be negative.");

  if (c >= a + b) {
    // The discs are too far apart to have any overlapping area.
    return 0.0;
  }

  if (c == 0.0) {
    // The discs have a common center. Therefore, one disc is inside the other.
    return (a <= b) ? 1.0 : (b * b) / (a * a);
  }

  final x = (a * a - b * b + c * c) / (2 * c);
  final radicand = a * a - x * x;
  if (radicand <= 0.0) {
    // The circumferences do not intersect, or are tangent.
    // We already ruled out the case of non-overlapping discs.
    // Therefore, one disc is inside the other.
    return (a <= b) ? 1.0 : (b * b) / (a * a);
  }

  // The discs overlap fractionally in a pair of lens-shaped areas.

  final y = math.sqrt(radicand);

  // Return the overlapping fractional area.
  // There are two lens-shaped areas, one to the left of x, the other to the right of x.
  // Each part is calculated by subtracting a triangular area from a sector's area.
  final lens1 = a * a * math.acos(x / a) - x * y;
  final lens2 = b * b * math.acos((c - x) / b) - (c - x) * y;

  // Find the fractional area with respect to the first disc.
  return (lens1 + lens2) / (math.pi * a * a);
}


double _solarEclipseObscuration(_Vector hm, _Vector lo) {
  // Find heliocentric observer.
  final ho = hm + lo;

  // Calculate the apparent angular radius of the Sun for the observer.
  final sunRadius = math.asin(_SUN_RADIUS_AU / ho.length());

  // Calculate the apparent angular radius of the Moon for the observer.
  final moonRadius = math.asin(_MOON_POLAR_RADIUS_AU / lo.length());

  // Calculate the apparent angular separation between the Sun's center and the Moon's center.
  final sunMoonSeparation = lo.angleWith(ho).degreesToRadians();

  // Find the fraction of the Sun's apparent disc area that is covered by the Moon.
  final obscuration = _discObscuration(sunRadius, moonRadius, sunMoonSeparation);

  // HACK: In marginal cases, we need to clamp obscuration to less than 1.0.
  // This function is never called for total eclipses, so it should never return 1.0.
  return math.min(0.9999, obscuration);
}


/**
 * Searches for a lunar eclipse.
 *
 * This function finds the first lunar eclipse that occurs after `startTime`.
 * A lunar eclipse may be penumbral, partial, or total.
 * See [_LunarEclipseInfo] for more information.
 * To find a series of lunar eclipses, call this function once,
 * then keep calling [_nextLunarEclipse] as many times as desired,
 * passing in the `center` value returned from the previous call.
 *
 * See [lunarEclipsesAfter] for convenient iteration of consecutive lunar eclipses.
 *
 * @param startTime
 * The date and time for starting the search for a lunar eclipse.
 *
 * @return Information about the first lunar eclipse that occurs after `startTime`.
 */
_LunarEclipseInfo _searchLunarEclipse(_Time startTime) {
  final pruneLatitude = 1.8;  // full Moon's ecliptic latitude above which eclipse is impossible

  // Iterate through consecutive full moons until we find any kind of lunar eclipse.
  var fmtime = startTime;
  for (var fmcount = 0; fmcount <= 11; fmcount++) {
    final fullmoon = _searchMoonPhase(180.0, fmtime, 40.0) ??
        (throw _InternalError("Failed to find the next full moon."));

    // Pruning: if the full Moon's ecliptic latitude is too large,
    // a lunar eclipse is not possible. Avoid needless work searching for
    // the minimum moon distance.
    final moon = _MoonContext(fullmoon).calcMoon();
    if (moon.lat < pruneLatitude) {
      // Search near the full moon for the time when the center of the Moon
      // is closest to the line passing through the centers of the Sun and Earth.
      final shadow = _peakEarthShadow(fullmoon);
      if (shadow.r < shadow.p + _MOON_MEAN_RADIUS_KM) {
        // This is at least a penumbral eclipse. We will return a result.
        var kind = _EclipseKind.Penumbral;
        var obscuration = 0.0;
        final sdPenum = _shadowSemiDurationMinutes(shadow.time, shadow.p + _MOON_MEAN_RADIUS_KM, 200.0);
        var sdPartial = 0.0;
        var sdTotal = 0.0;

        if (shadow.r < shadow.k + _MOON_MEAN_RADIUS_KM) {
          // This is at least a partial eclipse.
          kind = _EclipseKind.Partial;
          sdPartial = _shadowSemiDurationMinutes(shadow.time, shadow.k + _MOON_MEAN_RADIUS_KM, sdPenum);

          if (shadow.r + _MOON_MEAN_RADIUS_KM < shadow.k) {
            // This is a total eclipse.
            kind = _EclipseKind.Total;
            obscuration = 1.0;
            sdTotal = _shadowSemiDurationMinutes(shadow.time, shadow.k - _MOON_MEAN_RADIUS_KM, sdPartial);
          } else {
            obscuration = _discObscuration(_MOON_MEAN_RADIUS_KM, shadow.k, shadow.r);
          }
        }

        return _LunarEclipseInfo(kind, obscuration, shadow.time, sdPenum, sdPartial, sdTotal);
      }
    }

    fmtime = fullmoon._addDays(10.0);
  }

  // This should never happen, because there should be at least 2 lunar eclipses per year.
  throw _InternalError("Failed to find a lunar eclipse within 12 full moons.");
}


/**
 * Searches for the next lunar eclipse in a series.
 *
 * After using [_searchLunarEclipse] to find the first lunar eclipse
 * in a series, you can call this function to find the next consecutive lunar eclipse.
 * Pass in the `center` value from the [_LunarEclipseInfo] returned by the
 * previous call to `searchLunarEclipse` or `nextLunarEclipse`
 * to find the next lunar eclipse.
 *
 * See [lunarEclipsesAfter] for convenient iteration of consecutive lunar eclipses.
 *
 * @param prevEclipseTime
 * A time near a full moon. Lunar eclipse search will start at the next full moon.
 *
 * @return
 * Information about the next lunar eclipse in a series.
 */
_LunarEclipseInfo _nextLunarEclipse(_Time prevEclipseTime) =>
    _searchLunarEclipse(prevEclipseTime._addDays(10.0));


/**
 * Enumerates a series of consecutive lunar eclipses that occur after a given time.
 *
 * This function enables iteration through an unlimited number
 * of consecutive lunar eclipses starting at a given time.
 *
 * This is a convenience wrapper around [_searchLunarEclipse] and [_nextLunarEclipse].
 *
 * @param startTime
 * The date and time for starting the search for a series of lunar eclipses.
 */
Iterable<_LunarEclipseInfo> _lunarEclipsesAfter(_Time startTime) sync* {
  var item = _searchLunarEclipse(startTime);
  while (true) {
    yield item;
    item = _nextLunarEclipse(item.peak);
  }
}


double _moonEclipticLatitudeDegrees(_Time time) => _MoonContext(time).calcMoon().lat;

// Convert all distances from AU to km.
// But dilate the z-coordinates so that the Earth becomes a perfect sphere.
// Then find the intersection of the vector with the sphere.
// See p 184 in Montenbruck & Pfleger's "Astronomy on the Personal Computer", second edition.
_Vector _kmSpherical(_Vector v) =>
    _Vector(
      v.x * _KM_PER_AU,
      v.y * _KM_PER_AU,
      v.z * (_KM_PER_AU / _EARTH_FLATTENING),
      v.t
    );

_EclipseKind _eclipseKindFromUmbra(double k) => (
    // The umbra radius tells us what kind of eclipse the observer sees.
    // If the umbra radius is positive, this is a total eclipse. Otherwise, it's annular.
    // HACK: I added a tiny bias (14 meters) to match Espenak test data.
    (k > 0.014)
        ? _EclipseKind.Total
        : _EclipseKind.Annular
);

_GlobalSolarEclipseInfo _geoidIntersect(_ShadowInfo shadow) {
  var kind = _EclipseKind.Partial;
  var obscuration = double.nan;
  var latitude = double.nan;
  var longitude = double.nan;

  // We want to calculate the intersection of the shadow axis with the Earth's geoid.
  // First we must convert EQJ (equator of J2000) coordinates to EQD (equator of date)
  // coordinates that are perfectly aligned with the Earth's equator at this
  // moment in time.
  final rot = _rotationEqjEqd(shadow.time);
  final v = _kmSpherical(rot.rotate(shadow.dir));      // shadow axis vector passing through Sun and Moon
  final e = _kmSpherical(rot.rotate(shadow.target));   // lunacentric Earth

  // Solve the quadratic equation that finds whether and where
  // the shadow axis intersects with the Earth in the dilated coordinate system.
  final R = _EARTH_EQUATORIAL_RADIUS_KM;
  final A = v.dot(v);
  final B = -2.0 * (v.dot(e));
  final C = (e.dot(e)) - R * R;
  final radic = B * B - 4.0 * A * C;
  if (radic > 0.0) {
    // Calculate the closer of the two intersection points.
    // This will be on the sunlit side of the Earth.
    final u = (-B - math.sqrt(radic)) / (2.0 * A);

    // Convert lunacentric dilated coordinates to geocentric coordinates.
    final px = u * v.x - e.x;
    final py = u * v.y - e.y;
    final pz = (u * v.z - e.z) * _EARTH_FLATTENING;

    // Convert cartesian coordinates into geodetic latitude/longitude.
    final proj = _hypot(px, py) * _EARTH_FLATTENING_SQUARED;
    latitude = (proj == 0.0) ? (
        (pz > 0.0) ? 90.0 : -90.0
    ) : (
        _datan(pz / proj)
    );

    // Adjust longitude for Earth's rotation at the given time.
    final gast = _siderealTime(shadow.time);
    longitude = _withMaxDegreeValue((_datan2(py, px) - (15.0 * gast)).remainder(360.0), 180.0);

    // We want to determine whether the observer sees a total eclipse or an annular eclipse.
    // We need to perform a series of vector calculations.
    // Calculate the inverse rotation matrix, so we can convert EQD to EQJ.
    final inv = rot.inverse();

    // Get the EQD geocentric coordinates of the observer.
    final obs = _Vector(px / _KM_PER_AU, py / _KM_PER_AU, pz / _KM_PER_AU, shadow.time);

    // Rotate the observer's geocentric EQD back to the EQJ system,
    // and convert the geocentric vector to a lunacentric vector.
    final luna = inv.rotate(obs) + shadow.target;

    // Calculate the shadow using a vector from the Moon's center toward the observer.
    final surface = _calcShadow(_MOON_POLAR_RADIUS_KM, shadow.time, luna, shadow.dir);

    // If we did everything right, the shadow distance should be very close to zero.
    // That's because we already determined the observer is on the shadow axis!
    if (surface.r > 1.0e-9 || surface.r < 0.0) {
      throw _InternalError("Invalid surface distance from intersection.");
    }

    kind = _eclipseKindFromUmbra(surface.k);
    obscuration = (kind == _EclipseKind.Total) ? 1.0 : _solarEclipseObscuration(shadow.dir, luna);
  }

  return _GlobalSolarEclipseInfo(kind, obscuration, shadow.time, shadow.r, latitude, longitude);
}


/**
 * Searches for a solar eclipse visible anywhere on the Earth's surface.
 *
 * This function finds the first solar eclipse that occurs after `startTime`.
 * A solar eclipse may be partial, annular, or total.
 * See [GlobalSolarEclipseInfo] for more information.
 * To find a series of solar eclipses, call this function once,
 * then keep calling [nextGlobalSolarEclipse] as many times as desired,
 * passing in the `peak` value returned from the previous call.
 *
 * See [globalSolarEclipsesAfter] for convenient iteration of consecutive eclipses.
 *
 * @param startTime
 * The date and time for starting the search for a solar eclipse.
 *
 * @return Information about the first solar eclipse after `startTime`.
 */
_GlobalSolarEclipseInfo _searchGlobalSolarEclipse(_Time startTime) {
  final pruneLatitude = 1.8;    // Moon's ecliptic latitude beyond which eclipse is impossible
  var nmtime = startTime;
  for (var nmcount = 0; nmcount <= 11; nmcount++) {
    // Search for the next new moon. Any solar eclipse will be near it.
    final newmoon = _searchMoonPhase(0.0, nmtime, 40.0) ??
        (throw _InternalError("Failed to find next new moon."));

    // Pruning: if the new moon's ecliptic latitude is too large, a solar eclipse is not possible.
    final eclipLat = _moonEclipticLatitudeDegrees(newmoon);
    if (eclipLat.abs() < pruneLatitude) {
      // Search near the new moon for the time when the center of the Earth
      // is closest to the line passing through the centers of the Sun and Moon.
      final shadow = _peakMoonShadow(newmoon);
      if (shadow.r < shadow.p + _EARTH_MEAN_RADIUS_KM) {
        // This is at least a partial solar eclipse visible somewhere on Earth.
        // Try to find an intersection between the shadow axis and the Earth's oblate geoid.
        return _geoidIntersect(shadow);
      }
    }

    nmtime = newmoon._addDays(10.0);
  }
  // This should never happen, because at least 2 solar eclipses happen every year.
  throw _InternalError("Failure to find global solar eclipse.");
}


/**
 * Searches for the next global solar eclipse in a series.
 *
 * After using [searchGlobalSolarEclipse] to find the first solar eclipse
 * in a series, you can call this function to find the next consecutive solar eclipse.
 * Pass in the `peak` value from the [GlobalSolarEclipseInfo] returned by the
 * previous call to `searchGlobalSolarEclipse` or `nextGlobalSolarEclipse`
 * to find the next solar eclipse.
 *
 * See [globalSolarEclipsesAfter] for convenient iteration of consecutive eclipses.
 *
 * @param prevEclipseTime
 * A date and time near a new moon. Solar eclipse search will start at the next new moon.
 *
 * @return Information about the next consecutive solar eclipse.
 */
_GlobalSolarEclipseInfo _nextGlobalSolarEclipse(_Time prevEclipseTime) =>
    _searchGlobalSolarEclipse(prevEclipseTime._addDays(10.0));


/**
 * Enumerates a series of consecutive global solar eclipses that occur after a given time.
 *
 * This function enables iteration through an unlimited number
 * of consecutive global solar eclipses starting at a given time.
 * This is a convenience wrapper around [searchGlobalSolarEclipse] and [nextGlobalSolarEclipse].
 *
 * @param startTime
 * The date and time for starting the search for a series of global solar eclipses.
 */
Iterable<_GlobalSolarEclipseInfo> _globalSolarEclipsesAfter(_Time startTime) sync* {
  var item = _searchGlobalSolarEclipse(startTime);
  while (true) {
    yield item;
    item = _nextGlobalSolarEclipse(item.peak);
  }
}


/**
 * Searches for a solar eclipse visible at a specific location on the Earth's surface.
 *
 * This function finds the first solar eclipse that occurs after `startTime`.
 * A solar eclipse may be partial, annular, or total.
 * See [_LocalSolarEclipseInfo] for more information.
 *
 * To find a series of solar eclipses, call this function once,
 * then keep calling [_nextLocalSolarEclipse] as many times as desired,
 * passing in the `peak` value returned from the previous call.
 *
 * IMPORTANT: An eclipse reported by this function might be partly or
 * completely invisible to the observer due to the time of day.
 * See [_LocalSolarEclipseInfo] for more information about this topic.
 *
 * See [localSolarEclipsesAfter] for convenient iteration of consecutive eclipses.
 *
 * @param startTime
 * The date and time for starting the search for a solar eclipse.
 *
 * @param observer
 * The geographic location of the observer.
 *
 * @return Information about the first solar eclipse visible at the specified observer location.
 */
_LocalSolarEclipseInfo _searchLocalSolarEclipse(_Time startTime, _Observer observer) {
  final pruneLatitude = 1.8;    // Moon's ecliptic latitude beyond which eclipise is impossible.

  // Iterate through consecutive new moons until we find a solar eclipse visible somewhere on Earth.
  var nmtime = startTime;
  while (true) {
    // Search for the next new moon. Any eclipse will be near it.
    final newmoon = _searchMoonPhase(0.0, nmtime, 40.0) ??
        (throw _InternalError("Failed to find next new moon"));

    // Pruning: if the new moon's ecliptic latitude is too large, a solar eclipse is not possible.
    final eclipLat = _moonEclipticLatitudeDegrees(newmoon);
    if (eclipLat.abs() < pruneLatitude) {
      // Search near the new moon for the time when the observer
      // is closest to the line passing through the centers of the Sun and Moon.
      final shadow = _peakLocalMoonShadow(newmoon, observer);
      if (shadow.r < shadow.p) {
        // This is at least a partial solar eclipse for the observer.
        final eclipse = _localEclipse(shadow, observer);

        // Ignore any eclipse that happens completely at night.
        // More precisely, the center of the the Sun must be above the horizon
        // at the beginning or the end of the eclipse, or we skip the event.
        if (eclipse.partialBegin.altitude > 0.0 || eclipse.partialEnd.altitude > 0.0) {
          return eclipse;
        }
      }
    }

    // We didn't find an eclipse on this new moon, so search for the next one.
    nmtime = newmoon._addDays(10.0);
  }
}


_LocalSolarEclipseInfo _localEclipse(_ShadowInfo shadow, _Observer observer) {
  final PARTIAL_WINDOW = 0.2;
  final TOTAL_WINDOW = 0.01;
  final peak = _calcEvent(observer, shadow.time);
  final t1p = shadow.time._addDays(-PARTIAL_WINDOW);
  final t2p = shadow.time._addDays(PARTIAL_WINDOW);
  final partialBegin = _localEclipseTransition(observer, 1.0, t1p, shadow.time, (it) => it.p - it.r);
  final partialEnd   = _localEclipseTransition(observer, -1.0, shadow.time, t2p, (it) => it.p - it.r);
  _EclipseEvent? totalBegin;
  _EclipseEvent? totalEnd;
  final _EclipseKind kind;
  if (shadow.r < shadow.k.abs()) {    // take absolute value of `k` to handle annular eclipses too.
    final t1t = shadow.time._addDays(-TOTAL_WINDOW);
    final t2t = shadow.time._addDays(TOTAL_WINDOW);
    totalBegin = _localEclipseTransition(observer, 1.0, t1t, shadow.time, (it) => it.k.abs() - it.r);
    totalEnd   = _localEclipseTransition(observer, -1.0, shadow.time, t2t, (it) => it.k.abs() - it.r);
    kind = _eclipseKindFromUmbra(shadow.k);
  } else {
    kind = _EclipseKind.Partial;
  }
  final obscuration = (kind == _EclipseKind.Total) ? 1.0 : _solarEclipseObscuration(shadow.dir, shadow.target);
  return _LocalSolarEclipseInfo(kind, obscuration, partialBegin, totalBegin, peak, totalEnd, partialEnd);
}


_EclipseEvent _localEclipseTransition(
  _Observer observer,
  double direction,
  _Time t1,
  _Time t2,
  double Function(_ShadowInfo) func
) {
  final time = _search(t1, t2, 1.0, (time) {
    return direction * func(_localMoonShadow(time, observer));
  }) ?? (throw _InternalError("Local eclipse transition search failed in range [$t1, $t2]."));
  return _calcEvent(observer, time);
}


_EclipseEvent _calcEvent(_Observer observer, _Time time) {
  final sunEqu = _equator(_Body.Sun, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
  final sunHor = _horizon(time, observer, sunEqu.ra, sunEqu.dec, _Refraction.Normal);
  return _EclipseEvent(time, sunHor.altitude);
}


/**
 * Searches for the next local solar eclipse in a series.
 *
 * After using [_searchLocalSolarEclipse] to find the first solar eclipse
 * in a series, you can call this function to find the next consecutive solar eclipse.
 * Pass in the `peak` value from the [_LocalSolarEclipseInfo] returned by the
 * previous call to `searchLocalSolarEclipse` or `nextLocalSolarEclipse`
 * to find the next solar eclipse.
 *
 * See [localSolarEclipsesAfter] for convenient iteration of consecutive eclipses.
 *
 * @param prevEclipseTime
 * A date and time near a new moon. Solar eclipse search will start at the next new moon.
 *
 * @param observer
 * The geographic location of the observer.
 *
 * @return Information about the next solar eclipse visible at the specified observer location.
 */
_LocalSolarEclipseInfo _nextLocalSolarEclipse(_Time prevEclipseTime, _Observer observer) =>
    _searchLocalSolarEclipse(prevEclipseTime._addDays(10.0), observer);


/**
 * Enumerates a series of consecutive local solar eclipses that occur after a given time.
 *
 * This function enables iteration through an unlimited number
 * of consecutive local solar eclipses starting at a given time.
 * This is a convenience wrapper around [_searchLocalSolarEclipse] and [_nextLocalSolarEclipse].
 *
 * @param startTime
 * The date and time for starting the search for a series of local solar eclipses.
 *
 * @param observer
 * The geographic location of the observer.
 */
Iterable<_LocalSolarEclipseInfo> _localSolarEclipsesAfter(_Time startTime, _Observer observer) sync* {
  var item = _searchLocalSolarEclipse(startTime, observer);
  while (true) {
    yield item;
    item = _nextLocalSolarEclipse(item.peak.time, observer);
  }
}

/**
 * Information about the brightness and illuminated shape of a celestial body.
 *
 * Returned by the functions [_illumination] and [searchPeakMagnitude]
 * to report the visual magnitude and illuminated fraction of a celestial body at a given date and time.
 */
class _IlluminationInfo {
  /**
   * The date and time of the observation.
   */
  final _Time time;

  /**
   * The visual magnitude of the body. Smaller values are brighter.
   */
  final double mag;

  /**
   * The angle in degrees between the Sun and the Earth, as seen from the body.
   * Indicates the body's phase as seen from the Earth.
   */
  final double phaseAngle;

  /**
   * A value in the range [0.0, 1.0] indicating what fraction of the body's
   * apparent disc is illuminated, as seen from the Earth.
   */
  final double phaseFraction;

  /**
   * The distance between the Sun and the body at the observation time.
   */
  final double helioDist;

  /**
   * For Saturn, the tilt angle in degrees of its rings as seen from Earth.
   * For all other bodies, 0.0.
   */
  final double ringTilt;

  const _IlluminationInfo(this.time, this.mag, this.phaseAngle, this.phaseFraction, this.helioDist, this.ringTilt);
}


/**
 * Information about a body's rotation axis at a given time.
 *
 * This structure is returned by [rotationAxis] to report
 * the orientation of a body's rotation axis at a given moment in time.
 * The axis is specified by the direction in space that the body's north pole
 * points, using angular equatorial coordinates in the J2000 system (EQJ).
 *
 * Thus `ra` is the right ascension, and `dec` is the declination, of the
 * body's north pole vector at the given moment in time. The north pole
 * of a body is defined as the pole that lies on the north side of the
 * [Solar System's invariable plane](https://en.wikipedia.org/wiki/Invariable_plane),
 * regardless of the body's direction of rotation.
 *
 * The `spin` field indicates the angular position of a prime meridian
 * arbitrarily recommended for the body by the International Astronomical
 * Union (IAU).
 *
 * The fields `ra`, `dec`, and `spin` correspond to the variables
 * α0, δ0, and W, respectively, from
 * [Report of the IAU Working Group on Cartographic Coordinates and Rotational Elements: 2015](https://astropedia.astrogeology.usgs.gov/download/Docs/WGCCRE/WGCCRE2015reprint.pdf).
 *
 * The field `north` is a unit vector pointing in the direction of the body's north pole.
 * It is expressed in the J2000 mean equator system (EQJ).
 */
class _AxisInfo {
  /**
   * The J2000 right ascension of the body's north pole direction, in sidereal hours.
   */
  final double ra;

  /**
   * The J2000 declination of the body's north pole direction, in degrees.
   */
  final double dec;

  /**
   * Rotation angle of the body's prime meridian, in degrees.
   */
  final double spin;

  /**
   * A J2000 dimensionless unit vector pointing in the direction of the body's north pole.
   */
  final _Vector north;

  const _AxisInfo(this.ra, this.dec, this.spin, this.north);
}


/**
 * Indicates whether a crossing through the ecliptic plane is ascending or descending.
 */
enum _NodeEventKind {
  /**
   * The body passes through the ecliptic plane from south to north.
   */
  Ascending,

  /**
   * The body passes through the ecliptic plane from north to south.
   */
  Descending,
}


/**
 * Information about an ascending or descending node of a body.
 *
 * This object is returned by [searchMoonNode] and [nextMoonNode]
 * to report information about the center of the Moon passing through the ecliptic plane.
 */
class _NodeEventInfo {
  /**
   * The time of the body's node.
   */
  final _Time time;

  /**
   * Whether the node is ascending or descending.
   */
  final _NodeEventKind kind;

  const _NodeEventInfo(this.time, this.kind);
}


/**
 * Represents a function whose ascending root is to be found.
 *
 * This interface must be implemented for callers of [_search]
 * in order to find the ascending root of a smooth function.
 * A class that implements `SearchContext` can hold state information
 * needed to evaluate the scalar function `eval`.
 *
 * Evaluates a scalar function at a given time.
 *
 * @param time
 * The time at which to evaluate the function.
 *
 * @return The floating point value of the scalar function at the given time.
 */
typedef _SearchContext = double Function(_Time time);

//---------------------------------------------------------------------------------------

/**
 * Reports the constellation that a given celestial point lies within.
 *
 * The [_constellation] function returns this object
 * to report which constellation corresponds with a given point in the sky.
 * Constellations are defined with respect to the B1875 equatorial system
 * per IAU standard. Although `constellation` requires J2000 equatorial
 * coordinates, `ConstellationInfo` contains converted B1875 coordinates for reference.
 */
class _ConstellationInfo {
  /**
   * 3-character mnemonic symbol for the constellation, e.g. "Ori".
   */
  final String symbol;

  /**
   * Full name of constellation, e.g. "Orion".
   */
  final String name;

  /**
   * Right ascension expressed in B1875 coordinates.
   */
  final double ra1875;

  /**
   * Declination expressed in B1875 coordinates.
   */
  final double dec1875;

  const _ConstellationInfo(this.symbol, this.name, this.ra1875, this.dec1875);
}

class _ConstellationText {
  final String symbol;
  final String name;
  const _ConstellationText(this.symbol, this.name);
}

class _ConstellationBoundary {
  final int index;
  final double raLo;
  final double raHi;
  final double decLo;
  const _ConstellationBoundary(this.index, this.raLo, this.raHi, this.decLo);
}

//---------------------------------------------------------------------------------------
// VSOP87: semi-analytic model of major planet positions

class _VsopTerm {
  final double amplitude;
  final double phase;
  final double frequency;
  const _VsopTerm(this.amplitude, this.phase, this.frequency);
}

class _VsopSeries {
  final List<_VsopTerm> term;
  const _VsopSeries(this.term);
}

class _VsopFormula {
  final List<_VsopSeries> series;
  const _VsopFormula(this.series);
}

class _VsopModel {
  final _VsopFormula lon;
  final _VsopFormula lat;
  final _VsopFormula rad;
  const _VsopModel(this.lon, this.lat, this.rad);
}

double _vsopFormulaCalc(_VsopFormula formula, double t, bool clampAngle) {
  var coord = 0.0;
  var tpower = 1.0;
  for (final series in formula.series) {
    var sum = 0.0;
    for (final term in series.term) {
      sum += term.amplitude * math.cos(term.phase + (t * term.frequency));
    }
    coord +=
        clampAngle
            ? (tpower * sum).remainder(_PI2)    // improve precision: longitude angles can be hundreds of radians
            : tpower * sum;
    tpower *= t;
  }
  return coord;
}

double _vsopDistance(_VsopModel model, _Time time) =>
    _vsopFormulaCalc(model.rad, time._julianMillennia(), false);

_TerseVector _vsopRotate(_TerseVector eclip) =>
    _TerseVector(
      eclip.x + 0.000000440360 * eclip.y - 0.000000190919 * eclip.z,
      -0.000000479966 * eclip.x + 0.917482137087 * eclip.y - 0.397776982902 * eclip.z,
      0.397776982902 * eclip.y + 0.917482137087 * eclip.z
    );

_TerseVector _vsopSphereToRect(double lon, double lat, double radius) {
  final rCosLat = radius * math.cos(lat);
  return _TerseVector(
    rCosLat * math.cos(lon),
    rCosLat * math.sin(lon),
    radius * math.sin(lat)
  );
}

_Vector _calcVsop(_VsopModel model, _Time time) {
  final t = time._julianMillennia();

  // Calculate the VSOP "B" trigonometric series to obtain ecliptic spherical coordinates.
  final lon = _vsopFormulaCalc(model.lon, t, true);
  final lat = _vsopFormulaCalc(model.lat, t, false);
  final rad = _vsopFormulaCalc(model.rad, t, false);

  // Convert ecliptic spherical coordinates to ecliptic Cartesian coordinates.
  final eclip = _vsopSphereToRect(lon, lat, rad);

  // Convert ecliptic Cartesian coordinates to equatorial Cartesian coordinates.
  // Also convert from TerseVector (coordinates only) to Vector (coordinates + time).
  return _vsopRotate(eclip).toAstroVector(time);
}

double _vsopDerivCalc(_VsopFormula formula, double t) {
  var tpower = 1.0;       // t^s
  var dpower = 0.0;       // t^(s-1)
  var deriv = 0.0;
  for (var s = 0; s < formula.series.length; s++) {
    final series = formula.series[s];
    var sinSum = 0.0;
    var cosSum = 0.0;
    for (final term in series.term) {
      final angle = term.phase + (term.frequency * t);
      sinSum += term.amplitude * (term.frequency * math.sin(angle));
      if (s > 0) {
        cosSum += term.amplitude * math.cos(angle);
      }
    }
    deriv += (s * dpower * cosSum) - (tpower * sinSum);
    dpower = tpower;
    tpower *= t;
  }
  return deriv;
}

class _BodyState {
  double tt;
  final _TerseVector r;
  final _TerseVector v;

  _BodyState(this.tt, this.r, this.v);

  void increment(_BodyState other) {
    r.increment(other.r);
    v.increment(other.v);
  }

  void decrement(_BodyState other) {
    r.decrement(other.r);
    v.decrement(other.v);
  }

  void copyFrom(_BodyState other) {
    tt = other.tt;
    r.copyFrom(other.r);
    v.copyFrom(other.v);
  }

  _BodyState operator -(_BodyState other) =>
      _BodyState(tt, r - other.r, v - other.v);
}


_StateVector _exportState(_BodyState bodyState, _Time time) =>
    _StateVector(
      bodyState.r.x, bodyState.r.y, bodyState.r.z,
      bodyState.v.x, bodyState.v.y, bodyState.v.z,
      time
    );


_StateVector _exportGravCalc(_BodyGravCalc calc, _Time time) =>
    _StateVector(
      calc.r.x, calc.r.y, calc.r.z,
      calc.v.x, calc.v.y, calc.v.z,
      time
    );


_BodyState _calcVsopPosVel(_VsopModel model, double tt) {
  final t = tt / _DAYS_PER_MILLENNIUM;

  // Calculate the VSOP "B" trigonometric series to obtain ecliptic spherical coordinates.
  final lon = _vsopFormulaCalc(model.lon, t, true);
  final lat = _vsopFormulaCalc(model.lat, t, false);
  final rad = _vsopFormulaCalc(model.rad, t, false);

  final eclipPos = _vsopSphereToRect(lon, lat, rad);

  // Calculate derivatives of spherical coordinates with respect to time.
  final dlon = _vsopDerivCalc(model.lon, t);      // dlon = d(lon) / dt
  final dlat = _vsopDerivCalc(model.lat, t);      // dlat = d(lat) / dt
  final drad = _vsopDerivCalc(model.rad, t);      // drad = d(rad) / dt

  // Use spherical coords and spherical derivatives to calculate
  // the velocity vector in rectangular coordinates.

  final coslon = math.cos(lon);
  final sinlon = math.sin(lon);
  final coslat = math.cos(lat);
  final sinlat = math.sin(lat);

  final vx = (
        (drad * coslat * coslon)
      - (rad * sinlat * coslon * dlat)
      - (rad * coslat * sinlon * dlon)
  );

  final vy = (
        (drad * coslat * sinlon)
      - (rad * sinlat * sinlon * dlat)
      + (rad * coslat * coslon * dlon)
  );

  final vz = (
        (drad * sinlat)
      + (rad * coslat * dlat)
  );

  // Convert speed units from [AU/millennium] to [AU/day].
  final eclipVel = _TerseVector(
    vx / _DAYS_PER_MILLENNIUM,
    vy / _DAYS_PER_MILLENNIUM,
    vz / _DAYS_PER_MILLENNIUM
  );

  // Rotate the vectors from ecliptic to equatorial coordinates.
  final equPos = _vsopRotate(eclipPos);
  final equVel = _vsopRotate(eclipVel);
  return _BodyState(tt, equPos, equVel);
}

_VsopModel? _optionalVsopModel(_Body body) {
  switch (body) {
    case _Body.Mercury: return _vsopModelMercury;
    case _Body.Venus:   return _vsopModelVenus;
    case _Body.Earth:   return _vsopModelEarth;
    case _Body.Mars:    return _vsopModelMars;
    case _Body.Jupiter: return _vsopModelJupiter;
    case _Body.Saturn:  return _vsopModelSaturn;
    case _Body.Uranus:  return _vsopModelUranus;
    case _Body.Neptune: return _vsopModelNeptune;
    default:           return null;
  }
}

_VsopModel _vsopModel(_Body body) =>
    _optionalVsopModel(body) ?? (throw _InvalidBodyException(body));

_Vector _vsopHelioVector(_Body body, _Time time) =>
    _calcVsop(_vsopModel(body), time);

//---------------------------------------------------------------------------------------
// Geocentric Moon

/**
 * Emulate two-dimensional arrays from the Pascal programming language.
 *
 * The original Pascal source code used 2D arrays
 * with negative lower bounds on the indices. This is trivial
 * in Pascal, but most other languages use 0-based arrays.
 * This wrapper class adapts the original algorithm to Kotlin's
 * zero-based arrays.
 */
class _PascalArray2 {
  final int xmin;
  final int ymin;
  final List<List<double>> array;
  _PascalArray2(this.xmin, int xmax, this.ymin, int ymax)
      : array = List<List<double>>.generate((xmax - xmin) + 1, (_) => List<double>.filled((ymax - ymin) + 1, 0.0));
  double get(int x, int y) => array[x - xmin][y - ymin];
  void set(int x, int y, double v) { array[x - xmin][y - ymin] = v; }
}

class _MoonContext {
  // Variable names inside this class do not follow coding style on purpose.
  // They reflect the exact names from the original Pascal source code,
  // for ease of porting and consistent code generation.
  late double T;
  double DGAM = 0.0;
  late double DLAM;
  double N = 0.0;
  late double GAM1C;
  late double SINPI;
  late double L0;
  late double L;
  late double LS;
  late double F;
  late double D;
  double DL0 = 0.0;
  double DL = 0.0;
  double DLS = 0.0;
  double DF = 0.0;
  double DD = 0.0;
  double DS = 0.0;
  final _PascalArray2 CO = _PascalArray2(-6, 6, 1, 4);
  final _PascalArray2 SI = _PascalArray2(-6, 6, 1, 4);
  final double ARC = 3600.0 * _RAD2DEG;      // arcseconds per radian

  _MoonContext(_Time time) {
    T = time._julianCenturies();
    final T2 = T * T;
    DLAM = 0.0;
    DS = 0.0;
    GAM1C = 0.0;
    SINPI = 3422.7;
    _longPeriodic();
    L0 = _PI2 * _frac(0.60643382 + (1336.85522467 * T) - (0.00000313 * T2)) + (DL0 / ARC);
    L  = _PI2 * _frac(0.37489701 + (1325.55240982 * T) + (0.00002565 * T2)) + (DL  / ARC);
    LS = _PI2 * _frac(0.99312619 + (  99.99735956 * T) - (0.00000044 * T2)) + (DLS / ARC);
    F  = _PI2 * _frac(0.25909118 + (1342.22782980 * T) - (0.00000892 * T2)) + (DF  / ARC);
    D  = _PI2 * _frac(0.82736186 + (1236.85308708 * T) - (0.00000397 * T2)) + (DD  / ARC);
    for (var I = 1; I <= 4; I++) {
      double ARG;
      int MAX;
      double FAC;
      switch (I) {
        case 1:    { ARG = L;  MAX = 4; FAC = 1.000002208;               break; }
        case 2:    { ARG = LS; MAX = 3; FAC = 0.997504612 - 0.002495388 * T; break; }
        case 3:    { ARG = F;  MAX = 4; FAC = 1.000002708 + 139.978 * DGAM;  break; }
        default:   { ARG = D;  MAX = 6; FAC = 1.0;                       break; }
      }
      CO.set(0, I, 1.0);
      CO.set(1, I, math.cos(ARG) * FAC);
      SI.set(0, I, 0.0);
      SI.set(1, I, math.sin(ARG) * FAC);

      for (var J = 2; J <= MAX; J++) {
        final c1 = CO.get(J - 1, I);
        final s1 = SI.get(J - 1, I);
        final c2 = CO.get(1, I);
        final s2 = SI.get(1, I);
        CO.set(J, I, c1 * c2 - s1 * s2);
        SI.set(J, I, s1 * c2 + c1 * s2);
      }

      for (var J = 1; J <= MAX; J++) {
        CO.set(-J, I,  CO.get(J, I));
        SI.set(-J, I, -SI.get(J, I));
      }
    }
  }

  /**
   * Sine of an angle `phi` expressed in revolutions, not radians or degrees.
   */
  double _sine(double phi) => math.sin(_PI2 * phi);

  double _frac(double x) => x - x.floorToDouble();

  void _longPeriodic() {
    final S1 = _sine(0.19833 + (0.05611 * T));
    final S2 = _sine(0.27869 + (0.04508 * T));
    final S3 = _sine(0.16827 - (0.36903 * T));
    final S4 = _sine(0.34734 - (5.37261 * T));
    final S5 = _sine(0.10498 - (5.37899 * T));
    final S6 = _sine(0.42681 - (0.41855 * T));
    final S7 = _sine(0.14943 - (5.37511 * T));

    DL0 = ( 0.84 * S1) + (0.31 * S2) + (14.27 * S3) + (7.26 * S4) + (0.28 * S5) + (0.24 * S6);
    DL  = ( 2.94 * S1) + (0.31 * S2) + (14.27 * S3) + (9.34 * S4) + (1.12 * S5) + (0.83 * S6);
    DLS = (-6.40 * S1) - (1.89 * S6);
    DF  = ( 0.21 * S1) + (0.31 * S2) + (14.27 * S3) - (88.70 * S4) - (15.30 * S5) + (0.24 * S6) - (1.86 * S7);
    DD  = DL0 - DLS;
    DGAM = (
        -3332.0e-9 * _sine(0.59734 - (5.37261 * T))
         -539.0e-9 * _sine(0.35498 - (5.37899 * T))
          -64.0e-9 * _sine(0.39943 - (5.37511 * T))
    );
  }

  // This is an ugly hack for efficiency.
  // Kotlin does not allow passing variables by reference.
  // Because this function is called *millions* of times
  // during the unit test, we can't afford to be allocating
  // tiny arrays or classes to pass a tuple (xTerm, yTerm) by reference.
  // It is much more efficient to keep (xTerm, yTerm) at object scope,
  // and allow term() to overwrite their values.
  // Callers know that each time they call term(), they must
  // access the output through (xTerm, yTerm) before calling term() again.

  double xTerm = double.nan;
  double yTerm = double.nan;
  void _term(int p, int q, int r, int s) {
    xTerm = 1.0;
    yTerm = 0.0;
    if (p != 0) _addTheta(CO.get(p, 1), SI.get(p, 1));
    if (q != 0) _addTheta(CO.get(q, 2), SI.get(q, 2));
    if (r != 0) _addTheta(CO.get(r, 3), SI.get(r, 3));
    if (s != 0) _addTheta(CO.get(s, 4), SI.get(s, 4));
  }

  void _addTheta(double c2, double s2) {
    final c1 = xTerm;
    final s1 = yTerm;
    xTerm = c1 * c2 - s1 * s2;
    yTerm = s1 * c2 + c1 * s2;
  }

  void addSol(
    double coeffl,
    double coeffs,
    double coeffg,
    double coeffp,
    int p,
    int q,
    int r,
    int s
  ) {
    _term(p, q, r, s);
    DLAM  += coeffl * yTerm;
    DS    += coeffs * yTerm;
    GAM1C += coeffg * xTerm;
    SINPI += coeffp * xTerm;
  }

  void _addn(double coeffn, int p, int q, int r, int s) {
    _term(p, q, r, s);
    N += (coeffn * yTerm);
  }

  void _solarN() {
    N = 0.0;
    _addn(-526.069,  0, 0, 1, -2);
    _addn(  -3.352,  0, 0, 1, -4);
    _addn( 44.297,  1, 0, 1, -2);
    _addn(  -6.000,  1, 0, 1, -4);
    _addn( 20.599, -1, 0, 1,  0);
    _addn( -30.598, -1, 0, 1, -2);
    _addn( -24.649, -2, 0, 1,  0);
    _addn(  -2.000, -2, 0, 1, -2);
    _addn( -22.571,  0, 1, 1, -2);
    _addn( 10.985,  0, -1, 1, -2);
  }

  void _planetary() {
    DLAM += (
        0.82 * _sine(0.7736   - 62.5512 * T) + 0.31 * _sine(0.0466  - 125.1025 * T)
        + 0.35 * _sine(0.5785   - 25.1042 * T) + 0.66 * _sine(0.4591 + 1335.8075 * T)
        + 0.64 * _sine(0.3130   - 91.5680 * T) + 1.14 * _sine(0.1480 + 1331.2898 * T)
        + 0.21 * _sine(0.5918 + 1056.5859 * T) + 0.44 * _sine(0.5784 + 1322.8595 * T)
        + 0.24 * _sine(0.2275    - 5.7374 * T) + 0.28 * _sine(0.2965    + 2.6929 * T)
        + 0.33 * _sine(0.3132    + 6.3368 * T)
    );
  }

  _Spherical calcMoon() {
    _addSolarTerms(this);
    _solarN();
    _planetary();
    final S = F + DS / ARC;
    final latSeconds = (1.000002708 + 139.978 * DGAM) * (18518.511 + 1.189 + GAM1C) * math.sin(S) - 6.24 * math.sin(3 * S) + N;
    return _Spherical(
      latSeconds / 3600.0,
      360.0 * _frac((L0 + DLAM / ARC) / _PI2),
      (ARC * _EARTH_EQUATORIAL_RADIUS_AU) / (0.999953253 * SINPI)
    );
  }
}

//---------------------------------------------------------------------------------------
// Pluto/SSB gravitation simulator

class _BodyGravCalc {
  double tt;         // J2000 terrestrial time [days]
  _TerseVector r;    // position [au]
  _TerseVector v;    // velocity [au/day]
  _TerseVector a;    // acceleration [au/day]

  _BodyGravCalc(this.tt, this.r, this.v, this.a);

  void copyFrom(_BodyGravCalc other) {
    tt = other.tt;
    r.copyFrom(other.r);
    v.copyFrom(other.v);
    a.copyFrom(other.a);
  }
}

class _MajorBodies {
  final _BodyState sun;
  final _BodyState jupiter;
  final _BodyState saturn;
  final _BodyState uranus;
  final _BodyState neptune;

  const _MajorBodies(this.sun, this.jupiter, this.saturn, this.uranus, this.neptune);

  _TerseVector acceleration(_TerseVector smallPos) => (
      _accelerationIncrement(smallPos, _SUN_GM,     sun.r    ) +
      _accelerationIncrement(smallPos, _JUPITER_GM, jupiter.r) +
      _accelerationIncrement(smallPos, _SATURN_GM,  saturn.r ) +
      _accelerationIncrement(smallPos, _URANUS_GM,  uranus.r ) +
      _accelerationIncrement(smallPos, _NEPTUNE_GM, neptune.r)
  );

  _TerseVector _accelerationIncrement(_TerseVector smallPos, double gm, _TerseVector majorPos) {
    final delta = majorPos - smallPos;
    final r2 = delta.quadrature();
    return delta * (gm / (r2 * math.sqrt(r2)));
  }
}

_TerseVector _updatePosition(double dt, _TerseVector r, _TerseVector v, _TerseVector a) =>
    _TerseVector(
      r.x + dt * (v.x + dt * a.x / 2.0),
      r.y + dt * (v.y + dt * a.y / 2.0),
      r.z + dt * (v.z + dt * a.z / 2.0),
    );

_TerseVector _updateVelocity(double dt, _TerseVector v, _TerseVector a) =>
    _TerseVector(
      v.x + dt * a.x,
      v.y + dt * a.y,
      v.z + dt * a.z
    );

_BodyState _adjustBarycenterPosVel(_BodyState ssb, double tt, _Body body, double planetGm) {
  final shift = planetGm / (planetGm + _SUN_GM);
  final planet = _calcVsopPosVel(_vsopModel(body), tt);
  ssb.r.increment(planet.r * shift);
  ssb.v.increment(planet.v * shift);
  return planet;
}

_MajorBodies _majorBodyBary(double tt) {
  // Calculate the state vector of the Solar System Barycenter (SSB).
  final ssb = _BodyState(tt, _TerseVector.zero(), _TerseVector.zero());
  final jupiter = _adjustBarycenterPosVel(ssb, tt, _Body.Jupiter, _JUPITER_GM);
  final saturn  = _adjustBarycenterPosVel(ssb, tt, _Body.Saturn,  _SATURN_GM );
  final uranus  = _adjustBarycenterPosVel(ssb, tt, _Body.Uranus,  _URANUS_GM );
  final neptune = _adjustBarycenterPosVel(ssb, tt, _Body.Neptune, _NEPTUNE_GM);

  // Convert planet state vectors from heliocentric to barycentric.
  jupiter.decrement(ssb);
  saturn.decrement(ssb);
  uranus.decrement(ssb);
  neptune.decrement(ssb);

  // Convert the heliocentric SSB to a barycentric Sun state.
  final sun = _BodyState(tt, -ssb.r, -ssb.v);

  return _MajorBodies(sun, jupiter, saturn, uranus, neptune);
}

class _GravSim {
  final _MajorBodies bary;
  final _BodyGravCalc grav;
  const _GravSim(this.bary, this.grav);
}

_GravSim _simulateGravity(
  double tt2,            // a target time to be calculated (before or after current time tt1)
  _BodyGravCalc calc1    // [pos, vel, acc] of the simulated body at tt1
) {
  final dt = tt2 - calc1.tt;

  // Calculate where the major bodies (Sun, Jupiter...Neptune) will be at tt2.
  final bary = _majorBodyBary(tt2);

  // Estimate the position of the small body as if the current
  // acceleration applies across the whole time interval.
  final approxPos = _updatePosition(dt, calc1.r, calc1.v, calc1.a);

  // Calculate the average acceleration of the endpoints.
  // This becomes our estimate of the mean effective acceleration
  // over the whole time interval.
  final meanAcc = bary.acceleration(approxPos).mean(calc1.a);

  // Refine the estimates of [pos, vel, acc] at tt2 using the mean acceleration.
  final pos = _updatePosition(dt, calc1.r, calc1.v, meanAcc);
  final vel = _updateVelocity(dt, calc1.v, meanAcc);
  final acc = bary.acceleration(pos);

  final grav = _BodyGravCalc(tt2, pos, vel, acc);
  return _GravSim(bary, grav);
}


int _clampIndex(double frac, int nsteps) {
  final index = frac.toInt();
  if (index < 0) {
    return 0;
  } else if (index >= nsteps) {
    return nsteps - 1;
  } else {
    return index;
  }
}

_GravSim _gravFromState(_BodyState state) {
  final bary = _majorBodyBary(state.tt);
  final r = state.r + bary.sun.r;
  final v = state.v + bary.sun.v;
  final a = bary.acceleration(r);
  final grav = _BodyGravCalc(state.tt, r, v, a);
  return _GravSim(bary, grav);
}

List<_BodyGravCalc>? _getPlutoSegment(double tt) {
  if (tt < _plutoStateTable[0].tt || tt > _plutoStateTable[_PLUTO_NUM_STATES - 1].tt) {
    return null;    // Don't bother calculating a segment. Let the caller crawl backward/forward to this time
  }

  final segIndex = _clampIndex((tt - _plutoStateTable[0].tt) / _PLUTO_TIME_STEP, _PLUTO_NUM_STATES - 1);
  return _plutoCache.putIfAbsent(segIndex, () {
    final seg = <_BodyGravCalc>[];

    // The first endpoint is exact.
    var sim = _gravFromState(_plutoStateTable[segIndex]);
    seg.add(sim.grav);

    // Simulate forwards from the lower time bound.
    var steptt = sim.grav.tt;
    for (var i = 1; i < _PLUTO_NSTEPS - 1; i++) {
      steptt += _PLUTO_DT;
      sim = _simulateGravity(steptt, sim.grav);
      seg.add(sim.grav);
    }

    // The last endpoint is exact.
    sim = _gravFromState(_plutoStateTable[segIndex + 1]);
    seg.add(sim.grav);

    // Simulate backwards from the upper time bound.
    final reverseTmp = <_BodyGravCalc>[];
    reverseTmp.add(sim.grav);

    steptt = sim.grav.tt;
    for (var i = _PLUTO_NSTEPS - 2; i >= 1; i--) {
      steptt -= _PLUTO_DT;
      sim = _simulateGravity(steptt, sim.grav);
      reverseTmp.add(sim.grav);
    }

    reverseTmp.add(seg[0]);
    final reverse = reverseTmp.reversed.toList();

    // Fade-mix the two series so that there are no discontinuities.
    for (var i = _PLUTO_NSTEPS - 2; i >= 1; i--) {
      final ramp = i.toDouble() / (_PLUTO_NSTEPS - 1);
      seg[i].r.mix(ramp, reverse[i].r);
      seg[i].v.mix(ramp, reverse[i].v);
      seg[i].a.mix(ramp, reverse[i].a);
    }

    return seg;
  });
}

_GravSim _calcPlutoOneWay(
  _BodyState initState,
  double targetTt,
  double dt
) {
  var sim = _gravFromState(initState);
  final int n = ((targetTt - sim.grav.tt) / dt).ceil();
  for (var i = 0; i < n; i++) {
    final tt = (i + 1 == n) ? targetTt : (sim.grav.tt + dt);
    sim = _simulateGravity(tt, sim.grav);
  }
  return sim;
}

_StateVector _calcPluto(_Time time, bool helio) {
  final seg = _getPlutoSegment(time.tt);
  final _BodyGravCalc calc;
  _MajorBodies? bary;
  if (seg == null) {
    // The target time is outside the year range 0000..4000.
    // Calculate it by crawling backward from 0000 or forward from 4000.
    // FIXFIXFIX - This is super slow. Could optimize this with extra caching if needed.
    final sim =
        (time.tt < _plutoStateTable[0].tt)
            ? _calcPlutoOneWay(_plutoStateTable[0], time.tt, (-_PLUTO_DT).toDouble())
            : _calcPlutoOneWay(_plutoStateTable[_PLUTO_NUM_STATES - 1], time.tt, (_PLUTO_DT).toDouble());

    calc = sim.grav;
    bary = sim.bary;
  } else {
    final left = _clampIndex((time.tt - seg[0].tt) / _PLUTO_DT, _PLUTO_NSTEPS - 1);
    final s1 = seg[left];
    final s2 = seg[left + 1];

    // Find mean acceleration vector over the interval.
    final _TerseVector acc = s1.a.mean(s2.a);

    // Use Newtonian mechanics to extrapolate away from t1 in the positive time direction.
    final _TerseVector ra = _updatePosition(time.tt - s1.tt, s1.r, s1.v, acc);
    final _TerseVector va = _updateVelocity(time.tt - s1.tt, s1.v, acc);

    // Use Newtonian mechanics to extrapolate away from t2 in the negative time direction.
    final _TerseVector rb = _updatePosition(time.tt - s2.tt, s2.r, s2.v, acc);
    final _TerseVector vb = _updateVelocity(time.tt - s2.tt, s2.v, acc);

    // Use fade in/out idea to blend the two position estimates.
    final ramp = (time.tt - s1.tt) / _PLUTO_DT;
    calc = _BodyGravCalc(
      time.tt,
      ra * (1.0 - ramp) + rb * ramp,      // ramp/mix the position vector
      va * (1.0 - ramp) + vb * ramp,      // ramp/mix the velocity vector
      _TerseVector.zero()                 // the acceleration isn't used
    );
  }

  if (helio) {
    // Lazy evaluate the Solar System Barycenter state if needed.
    bary ??= _majorBodyBary(time.tt);

    // Convert barycentric vectors to heliocentric vectors.
    calc.r.decrement(bary.sun.r);
    calc.v.decrement(bary.sun.v);
  }

  return _StateVector(
    calc.r.x, calc.r.y, calc.r.z,
    calc.v.x, calc.v.y, calc.v.z,
    time
  );
}

final Map<int, List<_BodyGravCalc>> _plutoCache = {};

//---------------------------------------------------------------------------------------

class _JupiterMoon {
  final double mu;
  final double al0;
  final double al1;
  final List<_VsopTerm> a;
  final List<_VsopTerm> l;
  final List<_VsopTerm> z;
  final List<_VsopTerm> zeta;
  const _JupiterMoon(this.mu, this.al0, this.al1, this.a, this.l, this.z, this.zeta);
}


_StateVector _jupiterMoonElemToPv(
  _Time time,
  double mu,
  double A,
  double AL,
  double K,
  double H,
  double Q,
  double P
) {
  // Translation of FORTRAN subroutine ELEM2PV from:
  // https://ftp.imcce.fr/pub/ephem/satel/galilean/L1/L1.2/

  final AN = math.sqrt(mu / (A * A * A));

  double CE;
  double SE;
  double DE;
  var EE = AL + K * math.sin(AL) - H * math.cos(AL);
  do {
    CE = math.cos(EE);
    SE = math.sin(EE);
    DE = (AL - EE + K * SE - H * CE) / (1.0 - K * CE - H * SE);
    EE += DE;
  } while (DE.abs() >= 1.0e-12);

  CE = math.cos(EE);
  SE = math.sin(EE);
  final DLE = H * CE - K * SE;
  final RSAM1 = -K * CE - H * SE;
  final ASR = 1.0 / (1.0 + RSAM1);
  final PHI = math.sqrt(1.0 - K * K - H * H);
  final PSI = 1.0 / (1.0 + PHI);
  final X1 = A * (CE - K - PSI * H * DLE);
  final Y1 = A * (SE - H + PSI * K * DLE);
  final VX1 = AN * ASR * A * (-SE - PSI * H * RSAM1);
  final VY1 = AN * ASR * A * (CE + PSI * K * RSAM1);
  final F2 = 2.0 * math.sqrt(1.0 - Q * Q - P * P);
  final P2 = 1.0 - 2.0 * P * P;
  final Q2 = 1.0 - 2.0 * Q * Q;
  final PQ = 2.0 * P * Q;

  return _StateVector(
    X1 * P2 + Y1 * PQ,
    X1 * PQ + Y1 * Q2,
    (Q * Y1 - X1 * P) * F2,
    VX1 * P2 + VY1 * PQ,
    VX1 * PQ + VY1 * Q2,
    (Q * VY1 - VX1 * P) * F2,
    time
  );
}


_StateVector _calcJupiterMoon(_Time time, _JupiterMoon m) {
  // This is a translation of FORTRAN code by Duriez, Lainey, and Vienne:
  // https://ftp.imcce.fr/pub/ephem/satel/galilean/L1/L1.2/

  final t = time.tt + 18262.5;    // number of days since 1950-01-01T00:00:00Z

  // Calculate 6 orbital elements at the given time t.
  var elem0 = 0.0;
  for (final term in m.a) {
    elem0 += term.amplitude * math.cos(term.phase + (t * term.frequency));
  }

  var elem1 = m.al0 + (t * m.al1);
  for (final term in m.l) {
    elem1 += term.amplitude * math.sin(term.phase + (t * term.frequency));
  }

  elem1 = elem1.remainder(_PI2);
  if (elem1 < 0) {
    elem1 += _PI2;
  }

  var elem2 = 0.0;
  var elem3 = 0.0;
  for (final term in m.z) {
    final arg = term.phase + (t * term.frequency);
    elem2 += term.amplitude * math.cos(arg);
    elem3 += term.amplitude * math.sin(arg);
  }

  var elem4 = 0.0;
  var elem5 = 0.0;
  for (final term in m.zeta) {
    final arg = term.phase + (t * term.frequency);
    elem4 += term.amplitude * math.cos(arg);
    elem5 += term.amplitude * math.sin(arg);
  }

  // Convert the oribital elements into position vectors in the Jupiter equatorial system (JUP).
  final state = _jupiterMoonElemToPv(time, m.mu, elem0, elem1, elem2, elem3, elem4, elem5);

  // Re-orient position and velocity vectors from Jupiter-equatorial (JUP) to Earth-equatorial in J2000 (EQJ).
  return _rotationJupEqj.rotateState(state);
}


//---------------------------------------------------------------------------------------

double _terrestrialTime(double ut) => ut + _deltaT(ut) / _SECONDS_PER_DAY;

final _Time _epoch2000 = _Time(0.0);

double _deltaT(double ut) {
  /*
      Fred Espenak writes about Delta-T generically here:
      https://eclipse.gsfc.nasa.gov/SEhelp/deltaT.html
      https://eclipse.gsfc.nasa.gov/SEhelp/deltat2004.html

      He provides polynomial approximations for distant years here:
      https://eclipse.gsfc.nasa.gov/SEhelp/deltatpoly2004.html

      They start with a year value 'y' such that y=2000 corresponds
      to the UTC Date 15-January-2000. Convert difference in days
      to mean tropical years.
  */
  double u;
  double u2;
  double u3;
  double u4;
  double u5;
  double u6;
  double u7;
  final y = 2000 + (ut - 14) / _DAYS_PER_TROPICAL_YEAR;
  if (y < -500) {
    u = (y - 1820) / 100;
    return -20.0 + (32.0 * u * u);
  } else if (y < 500.0) {
    u = y / 100;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2; u5 = u2 * u3; u6 = u3 * u3;
    return 10583.6 - (1014.41 * u) + (33.78311 * u2) - (5.952053 * u3) - (0.1798452 * u4) + (0.022174192 * u5) + (0.0090316521 * u6);
  } else if (y < 1600.0) {
    u = (y - 1000) / 100;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2; u5 = u2 * u3; u6 = u3 * u3;
    return 1574.2 - (556.01 * u) + (71.23472 * u2) + (0.319781 * u3) - (0.8503463 * u4) - (0.005050998 * u5) + (0.0083572073 * u6);
  } else if (y < 1700.0) {
    u = y - 1600;
    u2 = u * u; u3 = u * u2;
    return 120.0 - (0.9808 * u) - (0.01532 * u2) + (u3 / 7129);
  } else if (y < 1800.0) {
    u = y - 1700;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2;
    return 8.83 + (0.1603 * u) - (0.0059285 * u2) + (0.00013336 * u3) - (u4 / 1174000);
  } else if (y < 1860.0) {
    u = y - 1800;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2; u5 = u2 * u3; u6 = u3 * u3; u7 = u3 * u4;
    return 13.72 - (0.332447 * u) + (0.0068612 * u2) + (0.0041116 * u3) - (0.00037436 * u4) + (0.0000121272 * u5) - (0.0000001699 * u6) + (0.000000000875 * u7);
  } else if (y < 1900.0) {
    u = y - 1860;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2; u5 = u2 * u3;
    return 7.62 + (0.5737 * u) - (0.251754 * u2) + (0.01680668 * u3) - (0.0004473624 * u4) + (u5 / 233174);
  } else if (y < 1920.0) {
    u = y - 1900;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2;
    return -2.79 + (1.494119 * u) - (0.0598939 * u2) + (0.0061966 * u3) - (0.000197 * u4);
  } else if (y < 1941.0) {
    u = y - 1920;
    u2 = u * u; u3 = u * u2;
    return 21.20 + (0.84493 * u) - (0.076100 * u2) + (0.0020936 * u3);
  } else if (y < 1961) {
    u = y - 1950;
    u2 = u * u; u3 = u * u2;
    return 29.07 + (0.407 * u) - (u2 / 233) + (u3 / 2547);
  } else if (y < 1986.0) {
    u = y - 1975;
    u2 = u * u; u3 = u * u2;
    return 45.45 + (1.067 * u) - (u2 / 260) - (u3 / 718);
  } else if (y < 2005) {
    u = y - 2000;
    u2 = u * u; u3 = u * u2; u4 = u2 * u2; u5 = u2 * u3;
    return 63.86 + (0.3345 * u) - (0.060374 * u2) + (0.0017275 * u3) + (0.000651814 * u4) + (0.00002373599 * u5);
  } else if (y < 2050) {
    u = y - 2000;
    return 62.92 + (0.32217 * u) + (0.005589 * u * u);
  } else if (y < 2150) {
    u = (y - 1820) / 100;
    return -20 + (32 * u * u) - (0.5628 * (2150 - y));
  } else {   // all years after 2150
    u = (y - 1820) / 100;
    return -20 + (32 * u * u);
  }
}

double _universalTime(double tt) {
  // This is the inverse function of terrestrialTime.
  // This is an iterative numerical solver, but because
  // the relationship between UT and TT is almost perfectly linear,
  // it converges extremely fast (never more than 3 iterations).

  // dt = tt - ut
  var dt = _terrestrialTime(tt) - tt;
  while (true) {
    final ut = tt - dt;
    final ttCheck = _terrestrialTime(ut);
    final err = ttCheck - tt;
    if (err.abs() < 1.0e-12) return ut;
    dt += err;
  }
}

/**
 * Calculates the amount of "lift" to an altitude angle caused by atmospheric refraction.
 *
 * Given an altitude angle and a refraction option, calculates
 * the amount of "lift" caused by atmospheric refraction.
 * This is the number of degrees higher in the sky an object appears
 * due to the lensing of the Earth's atmosphere.
 * This function works best near sea level.
 * To correct for higher elevations, call [atmosphere] for that
 * elevation and multiply the refraction angle by the resulting relative density.
 *
 * @param refraction
 * The option selecting which refraction correction to use.
 * If `Refraction.Normal`, uses a well-behaved refraction model that works well for
 * all valid values (-90 to +90) of `altitude`.
 * If `Refraction.JplHor`, this function returns a compatible value with the JPL Horizons tool.
 * If any other value, including `Refraction.None`, this function returns 0.
 *
 * @param altitude
 * An altitude angle in a horizontal coordinate system. Must be a value between -90 and +90.
 */
double _refractionAngle(_Refraction refraction, double altitude) {
  if (altitude < -90.0 || altitude > 90.0) {
    return 0.0;    // no attempt to correct an invalid altitude
  }

  double angle;
  if (refraction == _Refraction.Normal || refraction == _Refraction.JplHor) {
    // http://extras.springer.com/1999/978-1-4471-0555-8/chap4/horizons/horizons.pdf
    // JPL Horizons says it uses refraction algorithm from
    // Meeus "Astronomical Algorithms", 1991, p. 101-102.
    // I found the following Go implementation:
    // https://github.com/soniakeys/meeus/blob/master/v3/refraction/refract.go
    // This is a translation from the function "Saemundsson" there.
    // I found experimentally that JPL Horizons clamps the angle to 1 degree below the horizon.
    // This is important because the tangent formula below goes crazy near hd = -5.11.
    final hd = math.max(altitude, -1.0);
    angle = (1.02 / _dtan(hd + 10.3 / (hd + 5.11))) / 60.0;

    if (refraction == _Refraction.Normal && altitude < -1.0) {
      // In "normal" mode we gradually reduce refraction toward the nadir
      // so that we never get an altitude angle less than -90 degrees.
      // When horizon angle is -1 degrees, the factor is exactly 1.
      // As altitude approaches -90 (the nadir), the fraction approaches 0 linearly.
      angle *= (altitude + 90.0) / 89.0;
    }
  } else {
    // No refraction, or the refraction option is invalid.
    angle = 0.0;
  }
  return angle;
}

/**
 * Calculates the inverse of an atmospheric refraction angle.
 *
 * Given an observed altitude angle that includes atmospheric refraction,
 * calculates the negative angular correction to obtain the unrefracted
 * altitude. This is useful for cases where observed horizontal
 * coordinates are to be converted to another orientation system,
 * but refraction first must be removed from the observed position.
 *
 * @param refraction
 * The option selecting which refraction correction to use.
 *
 * @param bentAltitude
 * The apparent altitude that includes atmospheric refraction.
 *
 * @return
 * The angular adjustment in degrees to be added to the
 * altitude angle to remove atmospheric lensing.
 * This will be less than or equal to zero.
 */
double _inverseRefractionAngle(_Refraction refraction, double bentAltitude) {
  if (bentAltitude < -90.0 || bentAltitude > 90.0) {
    return 0.0;    // no attempt to correct an invalid altitude
  }

  // Find the pre-adjusted altitude whose refraction correction leads to 'altitude'.
  var altitude = bentAltitude - _refractionAngle(refraction, bentAltitude);
  while (true) {
    // See how close we got.
    final diff = (altitude + _refractionAngle(refraction, altitude)) - bentAltitude;
    if (diff.abs() < 1.0e-14) {
      return altitude - bentAltitude;
    }
    altitude -= diff;
  }
}

/**
 * Returns the product of mass and universal gravitational constant of a Solar System body.
 *
 * For problems involving the gravitational interactions of Solar System bodies,
 * it is helpful to know the product GM, where G = the universal gravitational constant
 * and M = the mass of the body. In practice, GM is known to a higher precision than
 * either G or M alone, and thus using the product results in the most accurate results.
 * This function returns the product GM in the units au^3/day^2.
 * The values come from page 10 of a
 * [JPL memorandum regarding the DE405/LE405 ephemeris](https://web.archive.org/web/20120220062549/http://iau-comm4.jpl.nasa.gov/de405iom/de405iom.pdf).
 *
 * @param body
 * The body for which to find the GM product.
 * Allowed to be the Sun, Moon, EMB (Earth/Moon Barycenter), or any planet.
 * Any other value will cause an exception to be thrown.
 *
 * @return The mass product of the given body in au^3/day^2.
 */
double _massProduct(_Body body) =>
    body._massProduct ?? (throw _InvalidBodyException(body));

enum _PrecessDirection {
  From2000,
  Into2000,
}

_RotationMatrix _precessionRot(_Time time, _PrecessDirection dir) {
  final t = time._julianCenturies();
  final eps0 = 84381.406;

  final psia   = (((((-    0.0000000951  * t
                    +    0.000132851 ) * t
                    -    0.00114045  ) * t
                    -    1.0790069   ) * t
                    + 5038.481507    ) * t) * _ASEC2RAD;

  final omegaa = (((((     0.0000003337  * t
                    -    0.000000467 ) * t
                    -    0.00772503  ) * t
                    +    0.0512623   ) * t
                    -    0.025754    ) * t + eps0) * _ASEC2RAD;

  final chia   = (((((-    0.0000000560  * t
                    +    0.000170663 ) * t
                    -    0.00121197  ) * t
                    -    2.3814292   ) * t
                    +   10.556403    ) * t) * _ASEC2RAD;

  final sa = math.sin(eps0 * _ASEC2RAD);
  final ca = math.cos(eps0 * _ASEC2RAD);
  final sb = math.sin(-psia);
  final cb = math.cos(-psia);
  final sc = math.sin(-omegaa);
  final cc = math.cos(-omegaa);
  final sd = math.sin(chia);
  final cd = math.cos(chia);

  final xx =  cd * cb - sb * sd * cc;
  final yx =  cd * sb * ca + sd * cc * cb * ca - sa * sd * sc;
  final zx =  cd * sb * sa + sd * cc * cb * sa + ca * sd * sc;
  final xy = -sd * cb - sb * cd * cc;
  final yy = -sd * sb * ca + cd * cc * cb * ca - sa * cd * sc;
  final zy = -sd * sb * sa + cd * cc * cb * sa + ca * cd * sc;
  final xz =  sb * sc;
  final yz = -sc * cb * ca - sa * cc;
  final zz = -sc * cb * sa + cc * ca;

  switch (dir) {
    // Perform rotation from other epoch to J2000.0.
    case _PrecessDirection.Into2000:
      return _RotationMatrix(
        xx, yx, zx,
        xy, yy, zy,
        xz, yz, zz
      );

    // Perform rotation from J2000.0 to other epoch.
    case _PrecessDirection.From2000:
      return _RotationMatrix(
        xx, xy, xz,
        yx, yy, yz,
        zx, zy, zz
      );
  }
}

_Vector _precession(_Vector pos, _PrecessDirection dir) =>
    _precessionRot(pos.t, dir).rotate(pos);

_StateVector _precessionPosVel(_StateVector state, _PrecessDirection dir) =>
    _precessionRot(state.t, dir).rotateState(state);

class _EarthTilt {
  final double dpsi;
  final double ee;
  final double mobl;
  final double tobl;
  const _EarthTilt(this.dpsi, this.ee, this.mobl, this.tobl);
}

void _iau2000b(_Time time) {
  // Truncated version of the NOVAS C 3.1 function of the same name.
  // We cache Earth nutation angles `psi` and `eps` inside Time for efficiency.
  // If nutation has not already been calculated, these values will be NaN.
  // Lazy-evaluate both angles.

  if (time._psi.isNaN) {
    final t = time._julianCenturies();
    final elp = ((1287104.79305 + t * 129596581.0481).remainder(_ASEC360)) * _ASEC2RAD;
    final f   = ((335779.526232 + t * 1739527262.8478).remainder(_ASEC360)) * _ASEC2RAD;
    final d   = ((1072260.70369 + t * 1602961601.2090).remainder(_ASEC360)) * _ASEC2RAD;
    final om  = ((450160.398036 - t * 6962890.5431).remainder(_ASEC360)) * _ASEC2RAD;

    var sarg = math.sin(om);
    var carg = math.cos(om);
    var dp = (-172064161.0 - 174666.0 * t) * sarg + 33386.0 * carg;
    var de = (92052331.0 + 9086.0 * t) * carg + 15377.0 * sarg;

    var arg = 2.0 * (f - d + om);
    sarg = math.sin(arg);
    carg = math.cos(arg);
    dp += (-13170906.0 - 1675.0 * t) * sarg - 13696.0 * carg;
    de += (5730336.0 - 3015.0 * t) * carg - 4587.0 * sarg;

    arg = 2.0 * (f + om);
    sarg = math.sin(arg);
    carg = math.cos(arg);
    dp += (-2276413.0 - 234.0 * t) * sarg + 2796.0 * carg;
    de += (978459.0 - 485.0 * t) * carg + 1374.0 * sarg;

    arg = 2.0 * om;
    sarg = math.sin(arg);
    carg = math.cos(arg);
    dp += (2074554.0 + 207.0 * t) * sarg - 698.0 * carg;
    de += (-897492.0 + 470.0 * t) * carg - 291.0 * sarg;

    sarg = math.sin(elp);
    carg = math.cos(elp);
    dp += (1475877.0 - 3633.0 * t) * sarg + 11817.0 * carg;
    de += (73871.0 - 184.0 * t) * carg - 1924.0 * sarg;

    time._psi = -0.000135 + (dp * 1.0e-7);
    time._eps = 0.000388 + (de * 1.0e-7);
  }
}

double _meanObliquity(_Time time) {
  final t = time._julianCenturies();
  final asec =
      ((((  -0.0000000434   * t
          -  0.000000576  ) * t
          +  0.00200340   ) * t
          -  0.0001831    ) * t
          - 46.836769     ) * t + 84381.406;
  return asec / 3600;
}

_EarthTilt _earthTilt(_Time time) {
  _iau2000b(time);  // lazy-evaluate time.psi and time.eps
  final mobl = _meanObliquity(time);
  final tobl = mobl + (time._eps / 3600);
  final ee = time._psi * _dcos(mobl) / 15.0;
  return _EarthTilt(time._psi, ee, mobl, tobl);
}

double _earthRotationAngle(_Time time) {
  final thet1 = 0.7790572732640 + (0.00273781191135448 * time.ut);
  final thet3 = time.ut.remainder(1.0);
  final theta = 360.0 * ((thet1 + thet3).remainder(1.0));
  return (theta < 0.0) ? theta + 360.0 : theta;
}

/**
 * Calculates Greenwich Apparent Sidereal Time (GAST).
 *
 * Given a date and time, this function calculates the rotation of the
 * Earth, represented by the equatorial angle of the Greenwich prime meridian
 * with respect to distant stars (not the Sun, which moves relative to background
 * stars by almost one degree per day).
 * This angle is called Greenwich Apparent Sidereal Time (GAST).
 * GAST is measured in sidereal hours in the half-open range [0, 24).
 * When GAST = 0, it means the prime meridian is aligned with the of-date equinox,
 * corrected at that time for precession and nutation of the Earth's axis.
 * In this context, the *equinox* is the direction in space where the Earth's
 * orbital plane (the ecliptic) intersects with the plane of the Earth's equator,
 * at the location on the Earth's orbit of the (seasonal) March equinox.
 * As the Earth rotates, GAST increases from 0 up to 24 sidereal hours,
 * then starts over at 0.
 * To convert to degrees, multiply the return value by 15.
 *
 * @param time
 * The date and time for which to find GAST.
 * As an optimization, this function caches the sidereal time value in `time`,
 * unless it has already been cached, in which case the cached value is reused.
 */
double _siderealTime(_Time time) {
  if (time._st.isNaN) {
    final t = time._julianCenturies();
    final eqeq = 15.0 * _earthTilt(time).ee;
    final theta = _earthRotationAngle(time);
    final st = (eqeq + 0.014506 +
           (((( -    0.0000000368  * t
               -    0.000029956  ) * t
               -    0.00000044   ) * t
               +    1.3915817    ) * t
               + 4612.156534     ) * t);
    final gst = ((st / 3600.0 + theta).remainder(360.0)) / 15.0;
    time._st = (gst < 0.0) ? gst + 24.0 : gst;
  }
  return time._st;
}

/**
 * Calcluate the geocentric position and velocity of a topocentric observer.
 *
 * Given the geographic location of an observer and a time, calculate the position
 * and velocity of the observer, relative to the center of the Earth.
 * The state vector is expressed in the equator-of-date system (EQD).
 *
 * @param observer
 * The latitude, longitude, and elevation of the observer.
 *
 * @param time
 * The time of the observation.
 *
 * @return
 * An EQD state vector that holds the geocentric position and velocity
 * of the observer at the given time.
 */
_StateVector _terra(_Observer observer, _Time time) {
  final st = _siderealTime(time);
  final phi = observer.latitude.degreesToRadians();
  final sinphi = math.sin(phi);
  final cosphi = math.cos(phi);
  final c = 1.0 / _hypot(cosphi, _EARTH_FLATTENING * sinphi);
  final s = c * _EARTH_FLATTENING_SQUARED;
  final heightKm = observer.height / 1000.0;
  final ach = (_EARTH_EQUATORIAL_RADIUS_KM * c) + heightKm;
  final ash = (_EARTH_EQUATORIAL_RADIUS_KM * s) + heightKm;
  final stlocl = (15.0 * st + observer.longitude).degreesToRadians();
  final sinst = math.sin(stlocl);
  final cosst = math.cos(stlocl);

  return _StateVector(
    ach * cosphi * cosst / _KM_PER_AU,
    ach * cosphi * sinst / _KM_PER_AU,
    ash * sinphi / _KM_PER_AU,
    -(_ANGVEL * 86400.0 / _KM_PER_AU) * ach * cosphi * sinst,
    (_ANGVEL * 86400.0 / _KM_PER_AU) * ach * cosphi * cosst,
    0.0,
    time
  );
}

/**
 * Calculate the geographic coordinates corresponding to a position vector.
 *
 * Given a geocentric position vector expressed in equator-of-date (EQD) coordinates,
 * this function calculates the latitude, longitude, and elevation of that location.
 * Note that the time `ovec.t` must be set correctly in order to determine the
 * Earth's rotation angle.
 *
 * This function is intended for positions known to be on or near the Earth's surface.
 *
 * @param ovec
 * A geocentric position on or near the Earth's surface, in EQD coordinates.
 *
 * @return
 * The location on or near the Earth's surface corresponding to
 * the given position vector and time.
 */
_Observer _inverseTerra(_Vector ovec) {
  final double lonDeg;
  final double latDeg;
  final double heightKm;

  // Convert from AU to kilometers.
  final x = ovec.x * _KM_PER_AU;
  final y = ovec.y * _KM_PER_AU;
  final z = ovec.z * _KM_PER_AU;
  final p = _hypot(x, y);
  if (p < 1.0e-6) {
    // Special case: within 1 millimeter of a pole!
    // Use arbitrary longitude, and latitude determined by polarity of z.
    lonDeg = 0.0;
    latDeg = (z > 0.0) ? 90.0 : -90.0;
    // Elevation is calculated directly from z.
    heightKm = z.abs() - _EARTH_POLAR_RADIUS_KM;
  } else {
    // Calculate exact longitude in the half-open range (-180, +180].
    final stlocl = math.atan2(y, x);
    lonDeg = _longitudeOffset(stlocl.radiansToDegrees() - (15 * _siderealTime(ovec.t)));
    // Numerically solve for exact latitude, using Newton's Method.
    final F = _EARTH_FLATTENING_SQUARED;
    // Start with initial latitude estimate, based on a spherical Earth.
    var lat = math.atan2(z, p);
    late double c;
    late double s;
    late double denom;
    var count = 0;
    final distanceAu = math.max(1.0, ovec.length());
    while (true) {
      ++count;
      if (count > 10) {
        throw _InternalError("inverseTerra solver failed to converge.");
      }
      // Calculate the error function W(lat).
      // We try to find the root of W, meaning where the error is 0.
      c = math.cos(lat);
      s = math.sin(lat);
      final factor = (F - 1) * _EARTH_EQUATORIAL_RADIUS_KM;
      final c2 = c * c;
      final s2 = s * s;
      final radicand = c2 + F * s2;
      denom = math.sqrt(radicand);
      final W = ((factor * s * c) / denom) - (z * c) + (p * s);
      if (W.abs() < distanceAu * 2.0e-8) {
        break;  // The error is now negligible.
      }
      // Error is still too large. Find the next estimate.
      // Calculate D = the derivative of W with respect to lat.
      final D = (factor * ((c2 - s2) / denom) - (s2 * c2 * (F - 1) / (factor * radicand))) + (z * s) + (p * c);
      lat -= (W / D);
    }
    // We now have a solution for the latitude in radians.
    latDeg = lat.radiansToDegrees();
    // Solve for exact height in kilometers.
    // There are two formulas I can use. Use whichever has the less risky denominator.
    final adjust = _EARTH_EQUATORIAL_RADIUS_KM / denom;
    heightKm =
        (s.abs() > c.abs())
            ? z / s - F * adjust
            : p / c - adjust;
  }

  return _Observer(latDeg, lonDeg, 1000.0 * heightKm);
}

_Vector _gyration(_Vector pos, _PrecessDirection dir) {
  switch (dir) {
    case _PrecessDirection.Into2000:
      return _precession(_nutation(pos, dir), dir);
    case _PrecessDirection.From2000:
      return _nutation(_precession(pos, dir), dir);
  }
}

_StateVector _gyrationPosVel(_StateVector state, _PrecessDirection dir) {
  switch (dir) {
    case _PrecessDirection.Into2000:
      return _precessionPosVel(_nutationPosVel(state, dir), dir);
    case _PrecessDirection.From2000:
      return _nutationPosVel(_precessionPosVel(state, dir), dir);
  }
}

_Vector _geoPos(_Time time, _Observer observer) =>
    _gyration(
      _terra(observer, time).position(),
      _PrecessDirection.Into2000
    );

_Vector _spin(double angle, _Vector pos) {
  final cosang = _dcos(angle);
  final sinang = _dsin(angle);
  return _Vector(
    cosang * pos.x + sinang * pos.y,
    -sinang * pos.x + cosang * pos.y,
    pos.z,
    pos.t
  );
}

_RotationMatrix _nutationRot(_Time time, _PrecessDirection dir) {
  final tilt = _earthTilt(time);
  final oblm = tilt.mobl.degreesToRadians();
  final oblt = tilt.tobl.degreesToRadians();
  final psi = tilt.dpsi * _ASEC2RAD;
  final cobm = math.cos(oblm);
  final sobm = math.sin(oblm);
  final cobt = math.cos(oblt);
  final sobt = math.sin(oblt);
  final cpsi = math.cos(psi);
  final spsi = math.sin(psi);

  final xx = cpsi;
  final yx = -spsi * cobm;
  final zx = -spsi * sobm;
  final xy = spsi * cobt;
  final yy = cpsi * cobm * cobt + sobm * sobt;
  final zy = cpsi * sobm * cobt - cobm * sobt;
  final xz = spsi * sobt;
  final yz = cpsi * cobm * sobt - sobm * cobt;
  final zz = cpsi * sobm * sobt + cobm * cobt;

  switch (dir) {
    // Perform rotation from other epoch to J2000.0.
    case _PrecessDirection.Into2000:
      return _RotationMatrix(
        xx, yx, zx,
        xy, yy, zy,
        xz, yz, zz
      );

    // Perform rotation from J2000.0 to other epoch.
    case _PrecessDirection.From2000:
      return _RotationMatrix(
        xx, xy, xz,
        yx, yy, yz,
        zx, zy, zz
      );
  }
}

_Vector _nutation(_Vector pos, _PrecessDirection dir) =>
    _nutationRot(pos.t, dir).rotate(pos);

_StateVector _nutationPosVel(_StateVector state, _PrecessDirection dir) =>
    _nutationRot(state.t, dir).rotateState(state);

_Vector _eclipticToEquatorialRad(double oblRadians, _Vector ecl) {
  final cosObl = math.cos(oblRadians);
  final sinObl = math.sin(oblRadians);
  return _Vector(
    ecl.x,
    (ecl.y * cosObl) - (ecl.z * sinObl),
    (ecl.y * sinObl) + (ecl.z * cosObl),
    ecl.t
  );
}

_Vector _eclipticToEquatorial(_Vector ecl) =>
    _eclipticToEquatorialRad(_meanObliquity(ecl.t).degreesToRadians(), ecl);

_AxisInfo _earthRotationAxis(_Time time) {
  // Unlike the other planets, we have a model of precession and nutation
  // for the Earth's axis that provides a north pole vector.
  // So calculate the vector first, then derive the (RA,DEC) angles from the vector.

  // Start with a north pole vector in equator-of-date coordinates: (0,0,1).
  final pos1 = _Vector(0.0, 0.0, 1.0, time);

  // Convert the vector into J2000 coordinates to find the north pole direction.
  final pos2 = _nutation(pos1, _PrecessDirection.Into2000);
  final north = _precession(pos2, _PrecessDirection.Into2000);

  // Derive angular values: right ascension and declination.
  final equ = north.toEquatorial();

  // Use a modified version of the era() function that does not trim to 0..360 degrees.
  // This expression is also corrected to give the correct angle at the J2000 epoch.
  final spin = 190.41375788700253 + (360.9856122880876 * time.ut);

  return _AxisInfo(equ.ra, equ.dec, spin, north);
}

/**
 * Calculates information about a body's rotation axis at a given time.
 *
 * Calculates the orientation of a body's rotation axis, along with
 * the rotation angle of its prime meridian, at a given moment in time.
 *
 * This function uses formulas standardized by the IAU Working Group
 * on Cartographics and Rotational Elements 2015 report, as described
 * in the following document:
 *
 * https://astropedia.astrogeology.usgs.gov/download/Docs/WGCCRE/WGCCRE2015reprint.pdf
 *
 * See [AxisInfo] for more detailed information.
 *
 * @param body
 * One of the following values:
 * [_Body.Sun], [_Body.Moon], [_Body.Mercury], [_Body.Venus], [_Body.Earth], [_Body.Mars],
 * [_Body.Jupiter], [_Body.Saturn], [_Body.Uranus], [_Body.Neptune], [_Body.Pluto].
 *
 * @param time
 * The time at which to calculate the body's rotation axis.
 *
 * @return North pole orientation and body spin angle.
 */
_AxisInfo _rotationAxis(_Body body, _Time time) {
  if (body == _Body.Earth) {
    return _earthRotationAxis(time);
  }

  final d = time.tt;
  final T = time._julianCenturies();
  final double ra;
  final double dec;
  final double w;
  switch (body) {
    case _Body.Sun:
      ra = 286.13;
      dec = 63.87;
      w = 84.176 + (14.1844 * d);
      break;

    case _Body.Mercury:
      ra = 281.0103 - (0.0328 * T);
      dec = 61.4155 - (0.0049 * T);
      w = (
          329.5988
          + (6.1385108 * d)
          + (0.01067257 * _dsin((174.7910857 + 4.092335 * d)))
          - (0.00112309 * _dsin((349.5821714 + 8.184670 * d)))
          - (0.00011040 * _dsin((164.3732571 + 12.277005 * d)))
          - (0.00002539 * _dsin((339.1643429 + 16.369340 * d)))
          - (0.00000571 * _dsin((153.9554286 + 20.461675 * d)))
      );
      break;

    case _Body.Venus:
      ra = 272.76;
      dec = 67.16;
      w = 160.20 - (1.4813688 * d);
      break;

    case _Body.Moon:
      // See page 8, Table 2 in:
      // https://astropedia.astrogeology.usgs.gov/alfresco/d/d/workspace/SpacesStore/28fd9e81-1964-44d6-a58b-fbbf61e64e15/WGCCRE2009reprint.pdf
      final E1  = 125.045 -  0.0529921 * d;
      final E2  = 250.089 -  0.1059842 * d;
      final E3  = 260.008 + 13.0120009 * d;
      final E4  = 176.625 + 13.3407154 * d;
      final E5  = 357.529 +  0.9856003 * d;
      final E6  = 311.589 + 26.4057084 * d;
      final E7  = 134.963 + 13.0649930 * d;
      final E8  = 276.617 +  0.3287146 * d;
      final E9  = 34.226  +  1.7484877 * d;
      final E10 = 15.134  -  0.1589763 * d;
      final E11 = 119.743 +  0.0036096 * d;
      final E12 = 239.961 +  0.1643573 * d;
      final E13 = 25.053  + 12.9590088 * d;

      ra = (
          269.9949 + 0.0031 * T
          - 3.8787 * _dsin(E1)
          - 0.1204 * _dsin(E2)
          + 0.0700 * _dsin(E3)
          - 0.0172 * _dsin(E4)
          + 0.0072 * _dsin(E6)
          - 0.0052 * _dsin(E10)
          + 0.0043 * _dsin(E13)
      );

      dec = (
          66.5392 + 0.0130 * T
          + 1.5419 * _dcos(E1)
          + 0.0239 * _dcos(E2)
          - 0.0278 * _dcos(E3)
          + 0.0068 * _dcos(E4)
          - 0.0029 * _dcos(E6)
          + 0.0009 * _dcos(E7)
          + 0.0008 * _dcos(E10)
          - 0.0009 * _dcos(E13)
      );

      w = (
          38.3213 + (13.17635815 - 1.4e-12 * d) * d
          + 3.5610 * _dsin(E1)
          + 0.1208 * _dsin(E2)
          - 0.0642 * _dsin(E3)
          + 0.0158 * _dsin(E4)
          + 0.0252 * _dsin(E5)
          - 0.0066 * _dsin(E6)
          - 0.0047 * _dsin(E7)
          - 0.0046 * _dsin(E8)
          + 0.0028 * _dsin(E9)
          + 0.0052 * _dsin(E10)
          + 0.0040 * _dsin(E11)
          + 0.0019 * _dsin(E12)
          - 0.0044 * _dsin(E13)
      );
      break;

    case _Body.Mars:
      ra = (
          317.269202 - 0.10927547 * T
          + 0.000068 * _dsin(198.991226 + 19139.4819985 * T)
          + 0.000238 * _dsin(226.292679 + 38280.8511281 * T)
          + 0.000052 * _dsin(249.663391 + 57420.7251593 * T)
          + 0.000009 * _dsin(266.183510 + 76560.6367950 * T)
          + 0.419057 * _dsin(79.398797 + 0.5042615 * T)
      );

      dec = (
          54.432516 - 0.05827105 * T
          + 0.000051 * _dcos(122.433576 + 19139.9407476 * T)
          + 0.000141 * _dcos(43.058401 + 38280.8753272 * T)
          + 0.000031 * _dcos(57.663379 + 57420.7517205 * T)
          + 0.000005 * _dcos(79.476401 + 76560.6495004 * T)
          + 1.591274 * _dcos(166.325722 + 0.5042615 * T)
      );

      w = (
          176.049863 + 350.891982443297 * d
          + 0.000145 * _dsin(129.071773 + 19140.0328244 * T)
          + 0.000157 * _dsin(36.352167 + 38281.0473591 * T)
          + 0.000040 * _dsin(56.668646 + 57420.9295360 * T)
          + 0.000001 * _dsin(67.364003 + 76560.2552215 * T)
          + 0.000001 * _dsin(104.792680 + 95700.4387578 * T)
          + 0.584542 * _dsin(95.391654 + 0.5042615 * T)
      );
      break;

    case _Body.Jupiter:
      final Ja = 99.360714  + 4850.4046 * T;
      final Jb = 175.895369 + 1191.9605 * T;
      final Jc = 300.323162 + 262.5475 * T;
      final Jd = 114.012305 + 6070.2476 * T;
      final Je = 49.511251  + 64.3000 * T;

      ra = (
          268.056595 - 0.006499 * T
          + 0.000117 * _dsin(Ja)
          + 0.000938 * _dsin(Jb)
          + 0.001432 * _dsin(Jc)
          + 0.000030 * _dsin(Jd)
          + 0.002150 * _dsin(Je)
      );

      dec = (
          64.495303 + 0.002413 * T
          + 0.000050 * _dcos(Ja)
          + 0.000404 * _dcos(Jb)
          + 0.000617 * _dcos(Jc)
          - 0.000013 * _dcos(Jd)
          + 0.000926 * _dcos(Je)
      );

      w = 284.95 + 870.536 * d;
      break;

    case _Body.Saturn:
      ra = 40.589 - 0.036 * T;
      dec = 83.537 - 0.004 * T;
      w = 38.90 + 810.7939024 * d;
      break;

    case _Body.Uranus:
      ra = 257.311;
      dec = -15.175;
      w = 203.81 - 501.1600928 * d;
      break;

    case _Body.Neptune:
      final N = 357.85 + 52.316 * T;
      final sinN = _dsin(N);
      ra = 299.36 + 0.70 * sinN;
      dec = 43.46 - 0.51 * _dcos(N);
      w = 249.978 + 541.1397757 * d - 0.48 * sinN;
      break;

    case _Body.Pluto:
      ra = 132.993;
      dec = -6.163;
      w = 302.695 + 56.3625225 * d;
      break;

    default:
      throw _InvalidBodyException(body);
  }

  // Calculate the north pole vector using the given angles.
  final rcoslat = _dcos(dec);
  final north = _Vector(
    rcoslat * _dcos(ra),
    rcoslat * _dsin(ra),
    _dsin(dec),
    time
  );

  return _AxisInfo(ra / 15.0, dec, w, north);
}

/**
* Calculates spherical ecliptic geocentric position of the Moon.
*
* Given a time of observation, calculates the Moon's geocentric position
* in ecliptic spherical coordinates. Provides the ecliptic latitude and
* longitude in degrees, and the geocentric distance in astronomical units (AU).
*
* The ecliptic angles are measured in "ECT": relative to the true ecliptic plane and
* equatorial plane at the specified time. This means the Earth's equator
* is corrected for precession and nutation, and the plane of the Earth's
* orbit is corrected for gradual obliquity drift.
*
* This algorithm is based on the Nautical Almanac Office's *Improved Lunar Ephemeris* of 1954,
* which in turn derives from E. W. Brown's lunar theories from the early twentieth century.
* It is adapted from Turbo Pascal code from the book
* [Astronomy on the Personal Computer](https://www.springer.com/us/book/9783540672210)
* by Montenbruck and Pfleger.
*
* To calculate a J2000 mean equator vector instead, use [_geoMoon].
*
* @param time
* The date and time for which to calculate the Moon's position.
*
* @return The Moon's distance, ecliptic latitude, and ecliptic longitude, expressed in true equinox of date.
*/
_Spherical _eclipticGeoMoon(_Time time) {
  // Find ecliptic coordinates of the Moon in mean equinox of date (ECM).
  final moon = _MoonContext(time).calcMoon();

  // Convert spherical coordinates to a vector.
  final latRad = moon.lat.degreesToRadians();
  final lonRad = moon.lon.degreesToRadians();
  final distCosLat = moon.dist * math.cos(latRad);
  final ecm = _Vector(
    distCosLat * math.cos(lonRad),
    distCosLat * math.sin(lonRad),
    moon.dist * math.sin(latRad),
    time
  );

  // Obtain true and mean obliquity angles for the given time.
  // This serves to pre-calculate the nutation also, and cache it in `time`.
  final et = _earthTilt(time);

  // Convert ecliptic coordinates to equatorial coordinates, both in mean equinox of date.
  final eqm = _eclipticToEquatorialRad(et.mobl.degreesToRadians(), ecm);

  // Add nutation to convert ECM to true equatorial coordinates of date (EQD).
  final eqd = _nutation(eqm, _PrecessDirection.From2000);

  // Convert back to ecliptic, this time in true equinox of date (ECT).
  final eclip = _rotateEquatorialToEcliptic(eqd, et.tobl.degreesToRadians());

  return _Spherical(eclip.elat, eclip.elon, moon.dist);
}

/**
 * Calculates equatorial geocentric position of the Moon at a given time.
 *
 * Given a time of observation, calculates the Moon's position vector.
 * The vector indicates the Moon's center relative to the Earth's center.
 * The vector components are expressed in AU (astronomical units).
 * The coordinates are oriented with respect to the Earth's equator at the J2000 epoch.
 * In Astronomy Engine, this orientation is called EQJ.
 *
 * @param time
 * The date and time for which to calculate the Moon's position.
 *
 * @return The Moon's position vector in J2000 equatorial coordinates (EQJ).
 */
_Vector _geoMoon(_Time time) {
  final eclSphere = _MoonContext(time).calcMoon();
  final eclVec = eclSphere.toVector(time);
  final equVec = _eclipticToEquatorial(eclVec);
  return _precession(equVec, _PrecessDirection.Into2000);
}

/**
 * Calculates equatorial geocentric position and velocity of the Moon at a given time.
 *
 * Given a time of observation, calculates the Moon's position and velocity vectors.
 * The position and velocity are of the Moon's center relative to the Earth's center.
 * The position (x, y, z) components are expressed in AU (astronomical units).
 * The velocity (vx, vy, vz) components are expressed in AU/day.
 * The coordinates are oriented with respect to the Earth's equator at the J2000 epoch.
 * In Astronomy Engine, this orientation is called EQJ.
 * If you need the Moon's position only, and not its velocity,
 * it is much more efficient to use [_geoMoon] instead.
 *
 * @param time
 * The date and time for which to calculate the Moon's position and velocity.
 *
 * @return The Moon's position and velocity vectors in J2000 equatorial coordinates (EQJ).
 */
_StateVector _geoMoonState(_Time time) {
  // This is a hack, because trying to figure out how to derive
  // a time derivative for MoonContext.calcMoon() would be painful!
  // Calculate just before and just after the given time.
  // Average to find position, subtract to find velocity.
  final dt = 1.0e-5;       // 0.864 seconds
  final t1 = time._addDays(-dt);
  final t2 = time._addDays(dt);
  final r1 = _geoMoon(t1);
  final r2 = _geoMoon(t2);

  // The desired position is the average of the two calculated positions.
  // The difference of position vectors divided by the time span gives the velocity vector.
  return _StateVector(
    (r1.x + r2.x) / 2.0,
    (r1.y + r2.y) / 2.0,
    (r1.z + r2.z) / 2.0,
    (r2.x - r1.x) / (2.0 * dt),
    (r2.y - r1.y) / (2.0 * dt),
    (r2.z - r1.z) / (2.0 * dt),
    time
  );
}

/**
 * Calculates the geocentric position and velocity of the Earth/Moon barycenter.
 *
 * Given a time of observation, calculates the geocentric position and velocity vectors
 * of the Earth/Moon barycenter (EMB).
 * The position (x, y, z) components are expressed in AU (astronomical units).
 * The velocity (vx, vy, vz) components are expressed in AU/day.
 *
 * @param time
 * The date and time for which to calculate the EMB vectors.
 *
 * @return The EMB's position and velocity vectors in geocentric J2000 equatorial coordinates.
 */
_StateVector _geoEmbState(_Time time) =>
    _geoMoonState(time) / (1.0 + _EARTH_MOON_MASS_RATIO);

_Vector _helioEarthPos(_Time time) =>
    _calcVsop(_vsopModel(_Body.Earth), time);

_StateVector _helioEarthState(_Time time) =>
    _StateVector._fromBodyState(_calcVsopPosVel(_vsopModel(_Body.Earth), time.tt), time);

_Vector _barycenterPosContrib(_Time time, _Body body, double planetGm) {
  final factor = planetGm / (planetGm + _SUN_GM);
  final v = _vsopHelioVector(body, time);
  return _Vector(factor * v.x, factor * v.y, factor * v.z, v.t);
}

_Vector _solarSystemBarycenterPos(_Time time) {
  final j = _barycenterPosContrib(time, _Body.Jupiter, _JUPITER_GM);
  final s = _barycenterPosContrib(time, _Body.Saturn,  _SATURN_GM);
  final u = _barycenterPosContrib(time, _Body.Uranus,  _URANUS_GM);
  final n = _barycenterPosContrib(time, _Body.Neptune, _NEPTUNE_GM);
  return _Vector(
    j.x + s.x + u.x + n.x,
    j.y + s.y + u.y + n.y,
    j.z + s.z + u.z + n.z,
    time
  );
}

_StateVector _barycenterStateContrib(_Time time, _Body body, double planetGm) {
  final helioPlanet = _calcVsopPosVel(_vsopModel(body), time.tt);
  final factor = planetGm / (planetGm + _SUN_GM);
  return _StateVector(
    factor * helioPlanet.r.x,
    factor * helioPlanet.r.y,
    factor * helioPlanet.r.z,
    factor * helioPlanet.v.x,
    factor * helioPlanet.v.y,
    factor * helioPlanet.v.z,
    time
  );
}

_StateVector _solarSystemBarycenterState(_Time time) {
  final j = _barycenterStateContrib(time, _Body.Jupiter, _JUPITER_GM);
  final s = _barycenterStateContrib(time, _Body.Saturn,  _SATURN_GM);
  final u = _barycenterStateContrib(time, _Body.Uranus,  _URANUS_GM);
  final n = _barycenterStateContrib(time, _Body.Neptune, _NEPTUNE_GM);
  return _StateVector(
    j.x + s.x + u.x + n.x,
    j.y + s.y + u.y + n.y,
    j.z + s.z + u.z + n.z,
    j.vx + s.vx + u.vx + n.vx,
    j.vy + s.vy + u.vy + n.vy,
    j.vz + s.vz + u.vz + n.vz,
    time
  );
}

/**
 * Calculates heliocentric Cartesian coordinates of a body in the J2000 equatorial system.
 *
 * This function calculates the position of the given celestial body as a vector,
 * using the center of the Sun as the origin.  The result is expressed as a Cartesian
 * vector in the J2000 equatorial system: the coordinates are based on the mean equator
 * of the Earth at noon UTC on 1 January 2000.
 *
 * The position is not corrected for light travel time or aberration.
 * This is different from the behavior of [_geoVector].
 *
 * If given an invalid value for `body`, this function will throw an [InvalidBodyException].
 *
 * @param body
 * A body for which to calculate a heliocentric position:
 * the Sun, Moon, EMB, SSB, or any of the planets.
 * Also allowed to be a user-defined star created by [defineStar].
 *
 * @param time
 * The date and time for which to calculate the position.
 *
 * @return The heliocentric position vector of the center of the given body.
 */
_Vector _helioVector(_Body body, _Time time) {
  final star = _userDefinedStar(body);
  if (star != null) {
    return _Spherical(star.dec, 15.0 * star.ra, star.dist).toVector(time);
  }

  switch (body) {
    case _Body.Sun:   return _Vector(0.0, 0.0, 0.0, time);
    case _Body.Pluto: return _calcPluto(time, true).position();
    case _Body.Moon:  return _helioEarthPos(time) + _geoMoon(time);
    case _Body.EMB:   return _helioEarthPos(time) + (_geoMoon(time) / (1.0 + _EARTH_MOON_MASS_RATIO));
    case _Body.SSB:   return _solarSystemBarycenterPos(time);
    default:         return _calcVsop(_vsopModel(body), time);
  }
}

/**
 * Calculates the distance between a body and the Sun at a given time.
 *
 * Given a date and time, this function calculates the distance between
 * the center of `body` and the center of the Sun, expressed in AU.
 * For the planets Mercury through Neptune, this function is significantly
 * more efficient than calling [helioVector] followed by taking the length
 * of the resulting vector.
 *
 * @param body
 * A body for which to calculate a heliocentric distance:
 * the Sun, Moon, EMB, SSB, any of the planets, or a user-defined star.
 *
 * @param time
 * The date and time for which to calculate the distance.
 *
 * @return The heliocentric distance in AU.
 */
double _helioDistance(_Body body, _Time time) {
  if (body == _Body.Sun) {
    return 0.0;
  }
  final star = _userDefinedStar(body);
  if (star != null) {
    return star.dist;
  }
  final vm = _optionalVsopModel(body);
  return (vm != null)
      ? _vsopDistance(vm, time)
      : _helioVector(body, time).length();
}

/**
 * Calculates heliocentric position and velocity vectors for the given body.
 *
 * Given a body and a time, calculates the position and velocity
 * vectors for the center of that body at that time, relative to the center of the Sun.
 * The vectors are expressed in J2000 mean equator coordinates (EQJ).
 * If you need the position vector only, it is more efficient to call [helioVector].
 * The Sun's center is a non-inertial frame of reference. In other words, the Sun
 * experiences acceleration due to gravitational forces, mostly from the larger
 * planets (Jupiter, Saturn, Uranus, and Neptune). If you want to calculate momentum,
 * kinetic energy, or other quantities that require a non-accelerating frame
 * of reference, consider using [baryState] instead.
 *
 * @param body
 * The celestial body whose heliocentric state vector is to be calculated.
 * Supported values are [_Body.Sun], [_Body.Moon], [_Body.EMB], [_Body.SSB], and all planets:
 * [_Body.Mercury], [_Body.Venus], [_Body.Earth], [_Body.Mars], [_Body.Jupiter],
 * [_Body.Saturn], [_Body.Uranus], [_Body.Neptune], [_Body.Pluto].
 * Also allowed to be a user-defined star created by [defineStar].
 *
 * @param time
 * The date and time for which to calculate position and velocity.
 *
 * @return
 * A state vector that contains heliocentric position and velocity vectors.
 * The positions are expressed in AU.
 * The velocities are expressed in AU/day.
 */
_StateVector _helioState(_Body body, _Time time) {
  if (null != _userDefinedStar(body)) {
    final vec = _helioVector(body, time);
    return _StateVector(vec.x, vec.y, vec.z, 0.0, 0.0, 0.0, time);
  }

  switch (body) {
    case _Body.Sun:   return _StateVector(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, time);
    case _Body.Pluto: return _calcPluto(time, true);
    case _Body.Moon:  return _helioEarthState(time) + _geoMoonState(time);
    case _Body.EMB:   return _helioEarthState(time) + (_geoMoonState(time) / (1.0 + _EARTH_MOON_MASS_RATIO));
    case _Body.SSB:   return _solarSystemBarycenterState(time);
    default:         return _StateVector._fromBodyState(_calcVsopPosVel(_vsopModel(body), time.tt), time);
  }
}

/**
 * Calculates barycentric position and velocity vectors for the given body.
 *
 * Given a body and a time, calculates the barycentric position and velocity
 * vectors for the center of that body at that time.
 * The vectors are expressed in J2000 mean equator coordinates (EQJ).
 *
 * @param body
 * The celestial body whose barycentric state vector is to be calculated.
 * Supported values are [_Body.Sun], [_Body.Moon], [_Body.EMB], [_Body.SSB], and all planets:
 * [_Body.Mercury], [_Body.Venus], [_Body.Earth], [_Body.Mars], [_Body.Jupiter],
 * [_Body.Saturn], [_Body.Uranus], [_Body.Neptune], [_Body.Pluto].
 *
 * @param time
 * The date and time for which to calculate position and velocity.
 *
 * @return The barycentric position and velocity vectors of the body.
 */
_StateVector _baryState(_Body body, _Time time) {
  // Trival case: the solar system barycenter itself:
  if (body == _Body.SSB) {
    return _StateVector(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, time);
  }

  if (body == _Body.Pluto) {
    return _calcPluto(time, false);
  }

  // Find the barycentric positions and velocities for the 5 major bodies.
  final bary = _majorBodyBary(time.tt);

  switch (body) {
    // If the caller is asking for one of the major bodies, we already have the answer.
    case _Body.Sun:     return _exportState(bary.sun,     time);
    case _Body.Jupiter: return _exportState(bary.jupiter, time);
    case _Body.Saturn:  return _exportState(bary.saturn,  time);
    case _Body.Uranus:  return _exportState(bary.uranus,  time);
    case _Body.Neptune: return _exportState(bary.neptune, time);

    // The Moon and EMB require calculating both the heliocentric Earth and geocentric Moon.
    case _Body.Moon: return _exportState(bary.sun, time) + _helioEarthState(time) + _geoMoonState(time);
    case _Body.EMB:  return _exportState(bary.sun, time) + _helioEarthState(time) + _geoEmbState(time);

    default: {
      final _BodyState planet = _calcVsopPosVel(_vsopModel(body), time.tt);
      return _StateVector(
        bary.sun.r.x + planet.r.x,
        bary.sun.r.y + planet.r.y,
        bary.sun.r.z + planet.r.z,
        bary.sun.v.x + planet.v.x,
        bary.sun.v.y + planet.v.y,
        bary.sun.v.z + planet.v.z,
        time
      );
    }
  }
}

/**
 * A function for which to solve a light-travel time problem.
 *
 * The function [correctLightTravel] solves a generalized
 * problem of deducing how far in the past light must have left
 * a target object to be seen by an observer at a specified time.
 * This interface expresses an arbitrary position vector as
 * function of time that is passed to [correctLightTravel].
 *
 * Returns a relative position vector for a given time.
 *
 * @param time
 * The time at which to evaluate a relative position vector.
 *
 * @return The relative position vector at the specified time.
 */
typedef _PositionFunction = _Vector Function(_Time time);


/**
 * Solve for light travel time of a vector function.
 *
 * When observing a distant object, for example Jupiter as seen from Earth,
 * the amount of time it takes for light to travel from the object to the
 * observer can significantly affect the object's apparent position.
 * This function is a generic solver that figures out how long in the
 * past light must have left the observed object to reach the observer
 * at the specified observation time. It uses [PositionFunction]
 * to express an arbitrary position vector as a function of time.
 *
 * This function repeatedly calls `func.Position`, passing a series of time
 * estimates in the past. Then `func.Position` must return a relative state vector between
 * the observer and the target. `correctLightTravel` keeps calling
 * `func.Position` with more and more refined estimates of the time light must have
 * left the target to arrive at the observer.
 *
 * For common use cases, it is simpler to use [backdatePosition]
 * for calculating the light travel time correction of one body observing another body.
 *
 * For geocentric calculations, #geoVector also backdates the returned
 * position vector for light travel time, only it returns the observation time in
 * the returned vector's `t` field rather than the backdated time.
 *
 * @param func
 * An arbitrary position vector as a function of time.
 *
 * @param time
 * The observation time for which to solve for light travel delay.
 *
 * @return
 * The position vector at the solved backdated time.
 * The `t` field holds the time that light left the observed
 * body to arrive at the observer at the observation time.
 */
_Vector _correctLightTravel(_PositionFunction func, _Time time) {
  var ltime = time;
  for (var iter = 0; iter <= 10; iter++) {
    final pos = func(ltime);
    final ltime2 = time._addDays(-pos.length() / C_AUDAY);
    final dt = (ltime2.tt - ltime.tt).abs();
    if (dt < 1.0e-9) {       // 86.4 microseconds
      return pos;
    }
    ltime = ltime2;
  }
  throw _InternalError("Light travel time correction did not converge.");
}


class _BodyPosition {
  final _Body observerBody;
  final _Body targetBody;
  final _Aberration aberration;
  final _Vector observerPos;

  const _BodyPosition(this.observerBody, this.targetBody, this.aberration, this.observerPos);

  _Vector position(_Time time) {
    final _Vector opos;
    switch (aberration) {
      case _Aberration.None:
        // No aberration, so use the pre-calculated initial position of
        // the observer body that is already stored in `observerPos`.
        // To avoid an exception in the subtraction below, patch the time.
        opos = observerPos.withTime(time);
        break;

      case _Aberration.Corrected:
        // The following discussion is worded with the observer body being the Earth,
        // which is often the case. However, the same reasoning applies to any observer body
        // without loss of generality.
        //
        // To include aberration, make a good first-order approximation
        // by backdating the Earth's position also.
        // This is confusing, but it works for objects within the Solar System
        // because the distance the Earth moves in that small amount of light
        // travel time (a few minutes to a few hours) is well approximated
        // by a line segment that substends the angle seen from the remote
        // body viewing Earth. That angle is pretty close to the aberration
        // angle of the moving Earth viewing the remote body.
        // In other words, both of the following approximate the aberration angle:
        //     (transverse distance Earth moves) / (distance to body)
        //     (transverse speed of Earth) / (speed of light).
        opos = _helioVector(observerBody, time);
        break;
    }

    // Subtract the bodies' heliocentric positions to obtain a relative position vector.
    return _helioVector(targetBody, time) - opos;
  }
}


/**
 * Solve for light travel time correction of apparent position.
 *
 * When observing a distant object, for example Jupiter as seen from Earth,
 * the amount of time it takes for light to travel from the object to the
 * observer can significantly affect the object's apparent position.
 *
 * This function solves the light travel time correction for the apparent
 * relative position vector of a target body as seen by an observer body
 * at a given observation time.
 *
 * For geocentric calculations, #geoVector also includes light
 * travel time correction, but the time `t` embedded in its returned vector
 * refers to the observation time, not the backdated time that light left
 * the observed body. Thus `backdatePosition` provides direct
 * access to the light departure time for callers that need it.
 *
 * For a more generalized light travel correction solver, see [correctLightTravel].
 *
 * @param time
 * The time of observation.
 *
 * @param observerBody
 * The body to be used as the observation location.
 *
 * @param targetBody
 * The body to be observed.
 *
 * @param aberration
 * `Aberration.Corrected` to correct for aberration, or `Aberration.None` to leave uncorrected.
 *
 * @return
 * The position vector at the solved backdated time.
 * Its `t` field holds the time that light left the observed
 * body to arrive at the observer at the observation time.
 */
_Vector _backdatePosition(
  _Time time,
  _Body observerBody,
  _Body targetBody,
  _Aberration aberration
) {
  final _Vector observerPos;
  switch (aberration) {
    case _Aberration.None:
      // Without aberration, we need the observer body position at the observation time only.
      // For efficiency, calculate it once and hold onto it, so `BodyPosition` can keep using it.
      observerPos = _helioVector(observerBody, time);
      break;

    case _Aberration.Corrected:
      // With aberration, `backdatePosition` will calculate `observerPos` at different times.
      // Therefore, do not waste time calculating it now.
      // Provide a placeholder value, even though it will be ignored.
      observerPos = _Vector(0.0, 0.0, 0.0, time);
      break;
  }
  final func = _BodyPosition(observerBody, targetBody, aberration, observerPos);
  final vec = _correctLightTravel(func.position, time);
  return vec.withTime(time);      // tricky: return the observation time, not the backdated time
}


/**
 * Calculates geocentric Cartesian coordinates of a body in the J2000 equatorial system.
 *
 * This function calculates the position of the given celestial body as a vector,
 * using the center of the Earth as the origin.  The result is expressed as a Cartesian
 * vector in the J2000 equatorial system: the coordinates are based on the mean equator
 * of the Earth at noon UTC on 1 January 2000.
 *
 * If given an invalid value for `body`, this function will throw an exception.
 *
 * Unlike [helioVector], this function always corrects for light travel time.
 * This means the position of the body is "back-dated" by the amount of time it takes
 * light to travel from that body to an observer on the Earth.
 *
 * Also, the position can optionally be corrected for
 * [aberration](https://en.wikipedia.org/wiki/Aberration_of_light), an effect
 * causing the apparent direction of the body to be shifted due to transverse
 * movement of the Earth with respect to the rays of light coming from that body.
 *
 * @param body
 * A body for which to calculate a heliocentric position: the Sun, Moon, or any of the planets.
 *
 * @param time
 * The date and time for which to calculate the position.
 *
 * @param aberration
 * [_Aberration.Corrected] to correct for aberration, or [_Aberration.None] to leave uncorrected.
 *
 * @return A geocentric position vector of the center of the given body.
 */
_Vector _geoVector(_Body body, _Time time, _Aberration aberration) {
  switch (body) {
    case _Body.Earth: return _Vector(0.0, 0.0, 0.0, time);
    case _Body.Moon:  return _geoMoon(time);
    default:         return _backdatePosition(time, _Body.Earth, body, aberration).withTime(time);
  }
}


/**
 * Calculates equatorial coordinates of a celestial body as seen by an observer on the Earth's surface.
 *
 * Calculates topocentric equatorial coordinates in one of two different systems:
 * J2000 or true-equator-of-date, depending on the value of the `equdate` parameter.
 * Equatorial coordinates include right ascension, declination, and distance in astronomical units.
 *
 * This function corrects for light travel time: it adjusts the apparent location
 * of the observed body based on how long it takes for light to travel from the body to the Earth.
 *
 * This function corrects for *topocentric parallax*, meaning that it adjusts for the
 * angular shift depending on where the observer is located on the Earth. This is most
 * significant for the Moon, because it is so close to the Earth. However, parallax corection
 * has a small effect on the apparent positions of other bodies.
 *
 * Correction for aberration is optional, using the `aberration` parameter.
 *
 * @param body
 * The celestial body to be observed. Not allowed to be [_Body.Earth].
 *
 * @param time
 * The date and time at which the observation takes place.
 *
 * @param observer
 * A location on or near the surface of the Earth.
 *
 * @param equdate
 * Selects the date of the Earth's equator in which to express the equatorial coordinates.
 *
 * @param aberration
 * Selects whether or not to correct for aberration.
 *
 * @return Topocentric equatorial coordinates of the celestial body.
 */
_Equatorial _equator(
  _Body body,
  _Time time,
  _Observer observer,
  _EquatorEpoch equdate,
  _Aberration aberration
) {
  final gcObserver = _geoPos(time, observer);
  final gc = _geoVector(body, time, aberration);
  final j2000 = gc - gcObserver;
  final _Vector vec;
  switch (equdate) {
    case _EquatorEpoch.OfDate:
      vec = _gyration(j2000, _PrecessDirection.From2000);
      break;
    case _EquatorEpoch.J2000:
      vec = j2000;
      break;
  }
  return vec.toEquatorial();
}

/**
 * Calculates the apparent location of a body relative to the local horizon of an observer on the Earth.
 *
 * Given a date and time, the geographic location of an observer on the Earth, and
 * equatorial coordinates (right ascension and declination) of a celestial body,
 * this function returns horizontal coordinates (azimuth and altitude angles) for the body
 * relative to the horizon at the geographic location.
 *
 * The right ascension `ra` and declination `dec` passed in must be *equator of date*
 * coordinates, based on the Earth's true equator at the date and time of the observation.
 * Otherwise the resulting horizontal coordinates will be inaccurate.
 * Equator of date coordinates can be obtained by calling [_equator], passing in
 * [_EquatorEpoch.OfDate] as its `equdate` parameter. It is also recommended to enable
 * aberration correction by passing in [_Aberration.Corrected] as the `aberration` parameter.
 *
 * This function optionally corrects for atmospheric refraction.
 * For most uses, it is recommended to pass [_Refraction.Normal] in the `refraction` parameter to
 * correct for optical lensing of the Earth's atmosphere that causes objects
 * to appear somewhat higher above the horizon than they actually are.
 * However, callers may choose to avoid this correction by passing in [_Refraction.None].
 * If refraction correction is enabled, the azimuth, altitude, right ascension, and declination
 * in the [_Topocentric] object returned by this function will all be corrected for refraction.
 * If refraction is disabled, none of these four coordinates will be corrected; in that case,
 * the right ascension and declination in the returned structure will be numerically identical
 * to the respective `ra` and `dec` values passed in.
 *
 * @param time
 * The date and time of the observation.
 *
 * @param observer
 * The geographic location of the observer.
 *
 * @param ra
 * The right ascension of the body in sidereal hours. See remarks above for more details.
 *
 * @param dec
 * The declination of the body in degrees. See remarks above for more details.
 *
 * @param refraction
 * Selects whether to correct for atmospheric refraction, and if so, which model to use.
 * The recommended value for most uses is `Refraction.Normal`.
 * See remarks above for more details.
 *
 * @return
 * The body's apparent horizontal coordinates and equatorial coordinates, both optionally corrected for refraction.
 */
_Topocentric _horizon(
  _Time time,
  _Observer observer,
  double ra,
  double dec,
  _Refraction refraction
) {
  final sinlat = _dsin(observer.latitude);
  final coslat = _dcos(observer.latitude);
  final sinlon = _dsin(observer.longitude);
  final coslon = _dcos(observer.longitude);
  final sindc = _dsin(dec);
  final cosdc = _dcos(dec);
  final sinra = _dsin(ra * 15.0);
  final cosra = _dcos(ra * 15.0);

  // Calculate three mutually perpendicular unit vectors
  // in equatorial coordinates: uze, une, uwe.
  //
  // uze = The direction of the observer's local zenith (straight up).
  // une = The direction toward due north on the observer's horizon.
  // uwe = The direction toward due west on the observer's horizon.
  //
  // HOWEVER, these are uncorrected for the Earth's rotation due to the time of day.
  //
  // The components of these 3 vectors are as follows:
  // x = direction from center of Earth toward 0 degrees longitude (the prime meridian) on equator.
  // y = direction from center of Earth toward 90 degrees west longitude on equator.
  // z = direction from center of Earth toward the north pole.
  final uze = _Vector(coslat * coslon, coslat * sinlon, sinlat, time);
  final une = _Vector(-sinlat * coslon, -sinlat * sinlon, coslat, time);
  final uwe = _Vector(sinlon, -coslon, 0.0, time);

  // Correct the vectors uze, une, uwe for the Earth's rotation by calculating
  // sidereal time. Call spin() for each uncorrected vector to rotate about
  // the Earth's axis to yield corrected unit vectors uz, un, uw.
  // Multiply sidereal hours by -15 to convert to degrees and flip eastward
  // rotation of the Earth to westward apparent movement of objects with time.
  final angle = -15.0 * _siderealTime(time);
  final uz = _spin(angle, uze);
  final un = _spin(angle, une);
  final uw = _spin(angle, uwe);

  // Convert angular equatorial coordinates (RA, DEC) to
  // cartesian equatorial coordinates in 'p', using the
  // same orientation system as uze, une, uwe.
  final p = _Vector(cosdc * cosra, cosdc * sinra, sindc, time);

  // Use dot products of p with the zenith, north, and west
  // vectors to obtain the cartesian coordinates of the body in
  // the observer's horizontal orientation system.
  // pz = zenith component [-1, +1]
  // pn = north  component [-1, +1]
  // pw = west   component [-1, +1]
  final pz = p.dot(uz);
  final pn = p.dot(un);
  final pw = p.dot(uw);

  // projHor is the "shadow" of the body vector along the observer's flat ground.
  final projHor = _hypot(pn, pw);

  // Calculate az = azimuth (compass direction clockwise from East.)
  final az = (
      (projHor > 0.0) ? (
          // If the body is not exactly straight up/down, it has an azimuth.
          // Invert the angle to produce degrees eastward from north.
          _withMinDegreeValue(-_datan2(pw, pn), 0.0)
      ) : (
          // The body is straight up/down, so it does not have an azimuth.
          // Report an arbitrary but reasonable value.
          0.0
      )
  );

  // zd = the angle of the body away from the observer's zenith, in degrees.
  var zd = _datan2(projHor, pz);
  var horRa = ra;
  var horDec = dec;

  if (refraction != _Refraction.None) {
    final zd0 = zd;
    final refr = _refractionAngle(refraction, 90.0 - zd);
    zd -= refr;

    if (refr > 0.0 && zd > 3.0e-4) {
      // Calculate refraction-corrected equatorial coordinates.
      final sinzd  = _dsin(zd);
      final coszd  = _dcos(zd);
      final sinzd0 = _dsin(zd0);
      final coszd0 = _dcos(zd0);

      final prx = ((p.x - coszd0 * uz.x) / sinzd0) * sinzd + uz.x * coszd;
      final pry = ((p.y - coszd0 * uz.y) / sinzd0) * sinzd + uz.y * coszd;
      final prz = ((p.z - coszd0 * uz.z) / sinzd0) * sinzd + uz.z * coszd;

      final projEqu = _hypot(prx, pry);

      horRa =
          (projEqu > 0.0)
              ? _withMinDegreeValue(_datan2(pry, prx), 0.0) / 15.0
              : 0.0;

      horDec = _datan2(prz, projEqu);
    }
  }

  return _Topocentric(az, 90.0 - zd, horRa, horDec);
}

/**
 * Calculates heliocentric ecliptic longitude of a body.
 *
 * This function calculates the angle around the plane of the Earth's orbit
 * of a celestial body, as seen from the center of the Sun.
 * The angle is measured prograde (in the direction of the Earth's orbit around the Sun)
 * in degrees from the true equinox of date. The ecliptic longitude is always in the range [0, 360).
 *
 * @param body
 * A body other than the Sun.
 *
 * @param time
 * The date and time at which the body's ecliptic longitude is to be calculated.
 *
 * @return
 * The ecliptic longitude in degrees of the given body at the given time.
 */
double _eclipticLongitude(_Body body, _Time time) {
  if (body == _Body.Sun) {
    throw _InvalidBodyException(body);
  }

  final hv = _helioVector(body, time);
  final eclip = _equatorialToEcliptic(hv);
  return eclip.elon;
}


double _relativeLongitudeOffset(_Body body, _Time time, int direction, double targetRelativeLongitude) {
  final plon = _eclipticLongitude(body, time);
  final elon = _eclipticLongitude(_Body.Earth, time);
  final diff = direction * (elon - plon);
  return _longitudeOffset(diff - targetRelativeLongitude);
}

/**
 * Finds the mean number of days after which `body` returns to the same ecliptic longitude as seen from the Earth.
 */
double _synodicPeriod(_Body body) {
  final double period = body._orbitalPeriod ?? (throw _InvalidBodyException(body));
  return (_EARTH_ORBITAL_PERIOD / (_EARTH_ORBITAL_PERIOD / period - 1.0)).abs();
}


/**
 * Searches for the time when the Earth and another planet are separated by a specified angle in ecliptic longitude, as seen from the Sun.
 *
 * A relative longitude is the angle between two bodies measured in the plane of the Earth's orbit
 * (the ecliptic plane). The distance of the bodies above or below the ecliptic plane is ignored.
 * If you imagine the shadow of the body cast onto the ecliptic plane, and the angle measured around
 * that plane from one body to the other in the direction the planets orbit the Sun, you will get an
 * angle somewhere between 0 and 360 degrees. This is the relative longitude.
 *
 * Given a planet other than the Earth in `body` and a time to start the search in `startTime`,
 * this function searches for the next time that the relative longitude measured from the planet
 * to the Earth is `targetRelLon`.
 *
 * Certain astronomical events are defined in terms of relative longitude between the Earth and another planet:
 *
 * - When the relative longitude is 0 degrees, it means both planets are in the same direction from the Sun.
 *   For planets that orbit closer to the Sun (Mercury and Venus), this is known as *inferior conjunction*,
 *   a time when the other planet becomes very difficult to see because of being lost in the Sun's glare.
 *   (The only exception is in the rare event of a transit, when we see the silhouette of the planet passing
 *   between the Earth and the Sun.)
 *
 * - When the relative longitude is 0 degrees and the other planet orbits farther from the Sun,
 *   this is known as *opposition*.  Opposition is when the planet is closest to the Earth, and
 *   also when it is visible for most of the night, so it is considered the best time to observe the planet.
 *
 * - When the relative longitude is 180 degrees, it means the other planet is on the opposite side of the Sun
 *   from the Earth. This is called *superior conjunction*. Like inferior conjunction, the planet is
 *   very difficult to see from the Earth. Superior conjunction is possible for any planet other than the Earth.
 *
 * @param body
 * A planet other than the Earth. Any other body will cause an exception.
 *
 * @param targetRelativeLongitude
 * The desired relative longitude, expressed in degrees. Must be in the range [0, 360).
 *
 * @param startTime
 * The date and time at which to begin the search.
 *
 * @return
 * The time of the first relative longitude event that occurs after `startTime`.
 */
_Time _searchRelativeLongitude(_Body body, double targetRelativeLongitude, _Time startTime) {
  final int direction;
  switch (body) {
    // Planets that orbit closer to the Sun than the Earth are called "inferior" planets.
    // Because they orbit faster than the Earth, their relative longitudes are always decreasing.
    case _Body.Mercury:
    case _Body.Venus:
      direction = -1;
      break;

    // Planets that orbit farther from the Sun than the Earth are called "superior" planets.
    // Because they orbit slower than the Earth, their relative longitudes are always increasing.
    case _Body.Mars:
    case _Body.Jupiter:
    case _Body.Saturn:
    case _Body.Uranus:
    case _Body.Neptune:
    case _Body.Pluto:
      direction = 1;
      break;

    // No other bodies are supported by this function.
    default:
      throw _InvalidBodyException(body);
  }

  double syn = _synodicPeriod(body);

  // Iterate until we converge on the desired event.
  // Calculate the error angle, which will be a negative number of degrees,
  // meaning we are "behind" the target relative longitude.
  var errorAngle = _relativeLongitudeOffset(body, startTime, direction, targetRelativeLongitude);
  if (errorAngle > 0.0) {
    errorAngle -= 360.0;    // force searching forward in time, not backward
  }

  var time = startTime;
  for (var iter = 0; iter <= 99; iter++) {
    // Estimate how many days in the future (postive) or past (negative)
    // we have to go to get closer to the target relative longitude.
    final dayAdjust = (-errorAngle / 360.0) * syn;
    time = time._addDays(dayAdjust);
    if (dayAdjust.abs() * _SECONDS_PER_DAY < 1.0) {
      return time;    // we found the solution within a 1-second tolerance
    }

    final prevAngle = errorAngle;
    errorAngle = _relativeLongitudeOffset(body, time, direction, targetRelativeLongitude);
    if (prevAngle.abs() < 30.0 && (prevAngle != errorAngle)) {
      // Improve convergence for the Mercury and Mars, which have eccentric orbits.
      // Adjust the synodic period to more closely match the variable speed of both
      // planets in this part of their respective orbits.
      final ratio = prevAngle / (prevAngle - errorAngle);
      if (ratio > 0.5 && ratio < 2.0) {
        syn *= ratio;
      }
    }
  }

  throw _InternalError("Relative longitude search failed to converge.");
}


/**
 * Searches for the first transit of Mercury or Venus after a given date.
 *
 * Finds the first transit of Mercury or Venus after a specified date.
 * A transit is when an inferior planet passes between the Sun and the Earth
 * so that the silhouette of the planet is visible against the Sun in the background.
 * To continue the search, pass the `finish` time in the returned object to [nextTransit].
 *
 * See [transitsAfter] for convenient iteration of consecutive transits.
 *
 * @param body
 * The planet whose transit is to be found. Must be [_Body.Mercury] or [_Body.Venus].
 *
 * @param startTime
 * The date and time for starting the search for a transit.
 */
_TransitInfo _searchTransit(_Body body, _Time startTime) {
  final thresholdAngle = 0.4;   // maximum angular separation to attempt transit calculations
  final dtDays = 1.0;

  // Validate the planet and find its mean radius.
  final double planetRadiusKm;
  switch (body) {
    case _Body.Mercury: planetRadiusKm = 2439.7; break;
    case _Body.Venus:   planetRadiusKm = 6051.8; break;
    default: throw _InvalidBodyException(body);
  }

  var searchTime = startTime;
  while (true) {
    // Search for the next inferior conjunction of the given planet.
    // This is the next time the Earth and the other planet have the same
    // ecliptic longitude as seen from the Sun.
    final conj = _searchRelativeLongitude(body, 0.0, searchTime);

    // Calculate the angular separation between the body and Sun at this time.
    final separation = _angleFromSun(body, conj);

    if (separation < thresholdAngle) {
      // The planet's angular separation from the Sun is small enough
      // to consider it a transit candidate.
      // Search for the moment when the line passing through the Sun
      // and planet are closest to the Earth's center.
      final shadow = _peakPlanetShadow(body, planetRadiusKm, conj);
      if (shadow.r < shadow.p) {      // does the planet's penumbra touch the Earth's center?
        // Find the beginning and end of the penumbral contact.
        final t1 = shadow.time._addDays(-dtDays);
        final transitStart = _planetTransitBoundary(body, planetRadiusKm, t1, shadow.time, -1.0);

        final t2 = shadow.time._addDays(dtDays);
        final transitFinish = _planetTransitBoundary(body, planetRadiusKm, shadow.time, t2, 1.0);

        final transitSeparation = 60.0 * _angleFromSun(body, shadow.time);

        return _TransitInfo(transitStart, shadow.time, transitFinish, transitSeparation);
      }
    }

    // This inferior conjunction was not a transit. Try the next inferior conjunction.
    searchTime = conj._addDays(10.0);
  }
}


/**
 * Searches for another transit of Mercury or Venus.
 *
 * After calling [searchTransit] to find a transit of Mercury or Venus,
 * this function finds the next transit after that.
 * Keep calling this function as many times as you want to keep finding more transits.
 *
 * See [transitsAfter] for convenient iteration of consecutive transits.
 *
 * @param body
 * The planet whose transit is to be found. Must be [_Body.Mercury] or [_Body.Venus].
 *
 * @param prevTransitTime
 * A date and time near the previous transit.
 */
_TransitInfo _nextTransit(_Body body, _Time prevTransitTime) =>
    _searchTransit(body, prevTransitTime._addDays(100.0));


/**
 * Enumerates a series of consecutive transits of Mercury or Venus.
 *
 * This function enables iteration through a series of consecutive
 * transits of Mercury or Venus that occur after a specified time.
 *
 * This is a convenience wrapper around [searchTransit] and [nextTransit].
 *
 * @param body
 * The planet for which to enumerate transits. Must be [_Body.Mercury] or [_Body.Venus].
 *
 * @param startTime
 * The date and time for starting the search for a series of transits.
 */
Iterable<_TransitInfo> _transitsAfter(_Body body, _Time startTime) sync* {
  var item = _searchTransit(body, startTime);
  while (true) {
    yield item;
    item = _nextTransit(body, item.finish);
  }
}



/**
 * Calculates jovicentric positions and velocities of Jupiter's largest 4 moons.
 *
 * Calculates position and velocity vectors for Jupiter's moons
 * Io, Europa, Ganymede, and Callisto, at the given date and time.
 * The vectors are jovicentric (relative to the center of Jupiter).
 * Their orientation is the Earth's equatorial system at the J2000 epoch (EQJ).
 * The position components are expressed in astronomical units (AU), and the
 * velocity components are in AU/day.
 *
 * To convert to heliocentric position vectors, call [helioVector]
 * with [_Body.Jupiter] to get Jupiter's heliocentric position, then
 * add the jovicentric positions. Likewise, you can call [_geoVector]
 * to convert to geocentric positions; however, you will have to manually
 * correct for light travel time from the Jupiter system to Earth to
 * figure out what time to pass to `jupiterMoons` to get an accurate picture
 * of how Jupiter and its moons look from Earth.
 */
_JupiterMoonsInfo _jupiterMoons(_Time time) =>
    _JupiterMoonsInfo(
      _calcJupiterMoon(time, _jupiterMoonModel[0]),
      _calcJupiterMoon(time, _jupiterMoonModel[1]),
      _calcJupiterMoon(time, _jupiterMoonModel[2]),
      _calcJupiterMoon(time, _jupiterMoonModel[3])
    );

/**
 * Searches for a time at which a function's value increases through zero.
 *
 * Certain astronomy calculations involve finding a time when an event occurs.
 * Often such events can be defined as the root of a function:
 * the time at which the function's value becomes zero.
 *
 * `search` finds the *ascending root* of a function: the time at which
 * the function's value becomes zero while having a positive slope. That is, as time increases,
 * the function transitions from a negative value, through zero at a specific moment,
 * to a positive value later. The goal of the search is to find that specific moment.
 *
 * The `func` parameter is an instance of the interface [_SearchContext].
 * As an example, a caller may wish to find the moment a celestial body reaches a certain
 * ecliptic longitude. In that case, the caller might derive a class that contains
 * a [_Body] member to specify the body and a `Double` to hold the target longitude.
 * It could subtract the target longitude from the actual longitude at a given time;
 * thus the difference would equal zero at the moment in time the planet reaches the
 * desired longitude.
 *
 * Every time it is called, `func.eval` returns a `Double` value or it throws an exception.
 * If `func.eval` throws an exception, the search immediately fails and the exception
 * is propagated to the caller. Otherwise, the search proceeds until it either finds
 * the ascending root or fails for some reason.
 *
 * The search calls `func.eval` repeatedly to rapidly narrow in on any ascending
 * root within the time window specified by `time1` and `time2`. The search never
 * reports a solution outside this time window.
 *
 * `search` uses a combination of bisection and quadratic interpolation
 * to minimize the number of function calls. However, it is critical that the
 * supplied time window be small enough that there cannot be more than one root
 * (ascedning or descending) within it; otherwise the search can fail.
 * Beyond that, it helps to make the time window as small as possible, ideally
 * such that the function itself resembles a smooth parabolic curve within that window.
 *
 * If an ascending root is not found, or more than one root
 * (ascending and/or descending) exists within the window `time1`..`time2`,
 * the search will return `null`.
 *
 * If the search does not converge within 20 iterations, it will throw an exception.
 *
 * @param func
 * The function for which to find the time of an ascending root.
 * See remarks above for more details.
 *
 * @param time1
 * The lower time bound of the search window.
 * See remarks above for more details.
 *
 * @param time2
 * The upper time bound of the search window.
 * See remarks above for more details.
 *
 * @param toleranceSeconds
 * Specifies an amount of time in seconds within which a bounded ascending root
 * is considered accurate enough to stop. A typical value is 1 second.
 *
 * @return
 * If successful, returns an [_Time] value indicating a date and time
 * that is within `toleranceSeconds` of an ascending root.
 * If no ascending root is found, or more than one root exists in the time
 * window `time1`..`time2`, the function returns `null`.
 */
_Time? _search(
  _Time time1,
  _Time time2,
  double toleranceSeconds,
  _SearchContext func,
) {
  var t1 = time1;
  var t2 = time2;
  final iterLimit = 20;
  final toleranceDays = (toleranceSeconds / _SECONDS_PER_DAY).abs();
  var f1 = func(t1);
  var f2 = func(t2);
  var calcFmid = true;
  var fmid = 0.0;

  for (var iter = 1; iter <= iterLimit; iter++) {
    final dt = (t2.tt - t1.tt) / 2.0;
    final tmid = t1._addDays(dt);
    if (dt.abs() < toleranceDays) {
      // We are close enough to the event to stop the search.
      return tmid;
    }

    if (calcFmid) {
      fmid = func(tmid);
    } else {
      calcFmid = true;    // we already have the correct value of fmid from the previous loop
    }

    // Quadratic interpolation:
    // Try to find a parabola that passes through the 3 points we have sampled:
    // (t1,f1), (tmid,fmid), (t2,f2).
    final tm = tmid.ut;
    final tspan = t2.ut - tmid.ut;
    final q = (f2 + f1) / 2.0 - fmid;
    final r = (f2 - f1) / 2.0;
    final s = fmid;
    var foundInterpolation = false;
    var x = double.nan;
    if (q == 0.0) {
      // This is a line, not a parabola.
      if (r != 0.0) {     // skip horizontal lines: they don't have a root
        x = -s / r;
        foundInterpolation = (-1.0 <= x && x <= 1.0);
      }
    } else {
      // This really is a parabola. Find its roots x1, x2.
      final u = r * r - 4.0 * q * s;
      if (u > 0.0) {      // skip imaginary or tangent roots
        // See if there is a unique solution for x in the range [-1, +1].
        final ru = math.sqrt(u);
        final x1 = (-r + ru) / (2.0 * q);
        final x2 = (-r - ru) / (2.0 * q);
        final x1Valid = (-1.0 <= x1 && x1 <= 1.0);
        final x2Valid = (-1.0 <= x2 && x2 <= 1.0);
        if (x1Valid && !x2Valid) {
          x = x1;
          foundInterpolation = true;
        } else if (x2Valid && !x1Valid) {
          x = x2;
          foundInterpolation = true;
        }
      }
    }
    if (foundInterpolation) {
      final qut = tm + x * tspan;
      final qslope = (2 * q * x + r) / tspan;
      final tq = _Time(qut);
      final fq = func(tq);
      if (qslope != 0.0) {
        var dtGuess = (fq / qslope).abs();
        if (dtGuess < toleranceDays) {
          // The estimated time error is small enough that we can quit now.
          return tq;
        }

        // Try guessing a tighter boundary with the interpolated root at the center.
        dtGuess *= 1.2;
        if (dtGuess < dt / 10.0) {
          final tleft = tq._addDays(-dtGuess);
          final tright = tq._addDays(dtGuess);
          if ((tleft.ut - t1.ut) * (tleft.ut - t2.ut) < 0.0) {
            if ((tright.ut - t1.ut) * (tright.ut - t2.ut) < 0.0) {
              final fleft = func(tleft);
              final fright = func(tright);
              if ((fleft < 0.0) && (fright >= 0.0)) {
                f1 = fleft;
                f2 = fright;
                t1 = tleft;
                t2 = tright;
                fmid = fq;
                calcFmid = false;   // save a little work; no need to recalculate fmid next time
                continue;
              }
            }
          }
        }
      }
    }

    // The quadratic interpolation didn't work this time.
    // Use bisection: divide the region in two parts and pick
    // whichever one appears to contain a root.
    if (f1 < 0.0 && fmid >= 0.0) {
      t2 = tmid;
      f2 = fmid;
      continue;
    }

    if (fmid < 0.0 && f2 >= 0.0) {
      t1 = tmid;
      f1 = fmid;
      continue;
    }

    // Either there is no ascending zero-crossing in this range
    // or the search window is too wide (more than one zero-crossing).
    // Either way, the search has failed.
    return null;
  }

  throw _InternalError("Search did not converge within $iterLimit iterations.");
}

/**
 * Calculates geocentric ecliptic coordinates for the Sun.
 *
 * This function calculates the position of the Sun as seen from the Earth.
 * The returned value includes both Cartesian and spherical coordinates.
 * The x-coordinate and longitude values in the returned object are based
 * on the *true equinox of date*: one of two points in the sky where the instantaneous
 * plane of the Earth's equator at the given date and time (the *equatorial plane*)
 * intersects with the plane of the Earth's orbit around the Sun (the *ecliptic plane*).
 * By convention, the apparent location of the Sun at the March equinox is chosen
 * as the longitude origin and x-axis direction, instead of the one for September.
 *
 * `sunPosition` corrects for precession and nutation of the Earth's axis
 * in order to obtain the exact equatorial plane at the given time.
 *
 * This function can be used for calculating changes of seasons: equinoxes and solstices.
 * In fact, the function [seasons] does use this function for that purpose.
 *
 * @param time
 * The date and time for which to calculate the Sun's position.
 *
 * @return The ecliptic coordinates of the Sun using the Earth's true equator of date.
 */
_Ecliptic _sunPosition(_Time time) {
  // Correct for light travel time from the Sun.
  // Otherwise season calculations (equinox, solstice) will all be early by about 8 minutes!
  final adjustedTime = time._addDays(-1.0 / C_AUDAY);
  final earth2000 = _helioEarthPos(adjustedTime);

  // Convert heliocentric location of Earth to geocentric location of Sun.
  final sun2000 = -earth2000;

  // Convert to equatorial Cartesian coordinates of date.
  final sunOfDate = _gyration(sun2000, _PrecessDirection.From2000);

  // Convert equatorial coordinates to ecliptic coordinates.
  final trueObliq = _earthTilt(adjustedTime).tobl.degreesToRadians();
  return _rotateEquatorialToEcliptic(sunOfDate, trueObliq);
}

_Ecliptic _rotateEquatorialToEcliptic(_Vector pos, double obliqRadians) {
  final cosOb = math.cos(obliqRadians);
  final sinOb = math.sin(obliqRadians);
  final ex = pos.x;
  final ey = pos.y * cosOb + pos.z * sinOb;
  final ez = -pos.y * sinOb + pos.z * cosOb;
  final xyproj = _hypot(ex, ey);
  final elon =
      (xyproj > 0.0)
          ? _withMinDegreeValue(_datan2(ey, ex), 0.0)
          : 0.0;
  final elat = _datan2(ez, xyproj);
  final vec = _Vector(ex, ey, ez, pos.t);
  return _Ecliptic(vec, elat, elon);
}

/**
 * Converts a J2000 mean equator (EQJ) vector to a true ecliptic of date (ETC) vector and angles.
 *
 * Given coordinates relative to the Earth's equator at J2000 (the instant of noon UTC
 * on 1 January 2000), this function converts those coordinates to true ecliptic coordinates of date,
 * which are relative to the plane of the Earth's orbit around the Sun.
 *
 * @param eqj
 * Equatorial coordinates in the J2000 frame of reference.
 * You can call [_geoVector] to obtain suitable equatorial coordinates.
 *
 * @return Spherical and vector coordinates expressed in true ecliptic coordinates of date (ECT)..
 */
_Ecliptic _equatorialToEcliptic(_Vector eqj) {
  // Calculate nutation and obliquity for this time.
  // As an optimization, the nutation angles are cached in `eqj.t`,
  // and reused below when the `nutation` function is called.
  final et = _earthTilt(eqj.t);

  // Convert J2000 mean equator (EQJ) to true equator of date (EQD).
  final eqd = _gyration(eqj, _PrecessDirection.From2000);

  // Rotate from EQD to true ecliptic of date (ECT).
  return _rotateEquatorialToEcliptic(eqd, et.tobl.degreesToRadians());
}

/**
 * Searches for the time when the Sun reaches an apparent ecliptic longitude as seen from the Earth.
 *
 * This function finds the moment in time, if any exists in the given time window,
 * that the center of the Sun reaches a specific ecliptic longitude as seen from the center of the Earth.
 *
 * This function can be used to determine equinoxes and solstices.
 * However, it is usually more convenient and efficient to call [seasons]
 * to calculate all equinoxes and solstices for a given calendar year.
 *
 * The function searches the window of time specified by `startTime` and `startTime+limitDays`.
 * The search will return `null` if the Sun never reaches the longitude `targetLon` or
 * if the window is so large that the longitude ranges more than 180 degrees within it.
 * It is recommended to keep the window smaller than 10 days when possible.
 */
_Time? _searchSunLongitude(double targetLon, _Time startTime, double limitDays) {
  final time2 = startTime._addDays(limitDays);
  return _search(startTime, time2, 0.01, (time) {
    return _longitudeOffset(_sunPosition(time).elon - targetLon);
  });
}

/**
 * Finds both equinoxes and both solstices for a given calendar year.
 *
 * The changes of seasons are defined by solstices and equinoxes.
 * Given a calendar year number, this function calculates the
 * March and September equinoxes and the June and December solstices.
 *
 * The equinoxes are the moments twice each year when the plane of the
 * Earth's equator passes through the center of the Sun. In other words,
 * the Sun's declination is zero at both equinoxes.
 * The March equinox defines the beginning of spring in the northern hemisphere
 * and the beginning of autumn in the southern hemisphere.
 * The September equinox defines the beginning of autumn in the northern hemisphere
 * and the beginning of spring in the southern hemisphere.
 *
 * The solstices are the moments twice each year when one of the Earth's poles
 * is most tilted toward the Sun. More precisely, the Sun's declination reaches
 * its minimum value at the December solstice, which defines the beginning of
 * winter in the northern hemisphere and the beginning of summer in the southern
 * hemisphere. The Sun's declination reaches its maximum value at the June solstice,
 * which defines the beginning of summer in the northern hemisphere and the beginning
 * of winter in the southern hemisphere.
 *
 * @param year
 * The calendar year number for which to calculate equinoxes and solstices.
 * The value may be any integer, but only the years 1800 through 2100 have been
 * validated for accuracy: unit testing against data from the
 * United States Naval Observatory confirms that all equinoxes and solstices
 * for that range of years are within 2 minutes of the correct time.
 *
 * @return
 * A [_SeasonsInfo] object that contains four [_Time] values:
 * the March and September equinoxes and the June and December solstices.
 */
_SeasonsInfo _seasons(int year) =>
    _SeasonsInfo(
      _findSeasonChange(  0.0, year,  3, 10),
      _findSeasonChange( 90.0, year,  6, 10),
      _findSeasonChange(180.0, year,  9, 10),
      _findSeasonChange(270.0, year, 12, 10)
    );

_Time _findSeasonChange(double targetLon, int year, int month, int day) {
  final startTime = _Time.fromCalendar(year, month, day, 0, 0, 0.0);
  return _searchSunLongitude(targetLon, startTime, 20.0) ??
      (throw _InternalError("Cannot find solution for Sun longitude $targetLon for year $year"));
}

/**
 * Returns one body's ecliptic longitude with respect to another, as seen from the Earth.
 *
 * This function determines where one body appears around the ecliptic plane
 * (the plane of the Earth's orbit around the Sun) as seen from the Earth,
 * relative to the another body's apparent position.
 * The function returns an angle in the half-open range [0, 360) degrees.
 * The value is the ecliptic longitude of `body1` relative to the ecliptic
 * longitude of `body2`.
 *
 * The angle is 0 when the two bodies are at the same ecliptic longitude
 * as seen from the Earth. The angle increases in the prograde direction
 * (the direction that the planets orbit the Sun and the Moon orbits the Earth).
 *
 * When the angle is 180 degrees, it means the two bodies appear on opposite sides
 * of the sky for an Earthly observer.
 *
 * Neither `body1` nor `body2` is allowed to be [_Body.Earth].
 * If this happens, the function throws an exception.
 *
 * @param body1
 * The first body, whose longitude is to be found relative to the second body.
 *
 * @param body2
 * The second body, relative to which the longitude of the first body is to be found.
 *
 * @param time
 * The date and time of the observation.
 *
 * @return
 * An angle in the range [0, 360), expressed in degrees.
 */
double _pairLongitude(_Body body1, _Body body2, _Time time) {
  if (body1 == _Body.Earth || body2 == _Body.Earth) {
    throw _EarthNotAllowedException();
  }

  final vector1 = _geoVector(body1, time, _Aberration.None);
  final eclip1 = _equatorialToEcliptic(vector1);

  final vector2 = _geoVector(body2, time, _Aberration.None);
  final eclip2 = _equatorialToEcliptic(vector2);

  return _normalizeLongitude(eclip1.elon - eclip2.elon);
}

/**
 * Returns the Moon's phase as an angle from 0 to 360 degrees.
 *
 * This function determines the phase of the Moon using its apparent
 * ecliptic longitude relative to the Sun, as seen from the center of the Earth.
 * Certain values of the angle have conventional definitions:
 *
 * - 0 = new moon
 * - 90 = first quarter
 * - 180 = full moon
 * - 270 = third quarter
 *
 * @param time
 * The date and time of the observation.
 *
 * @return
 * The angle as described above, a value in the range 0..360 degrees.
 */
double _moonPhase(_Time time) =>
    _pairLongitude(_Body.Moon, _Body.Sun, time);

/**
 * Searches for the time that the Moon reaches a specified phase.
 *
 * Lunar phases are conventionally defined in terms of the Moon's geocentric ecliptic
 * longitude with respect to the Sun's geocentric ecliptic longitude.
 * When the Moon and the Sun have the same longitude, that is defined as a new moon.
 * When their longitudes are 180 degrees apart, that is defined as a full moon.
 *
 * This function searches for any value of the lunar phase expressed as an
 * angle in degrees in the range [0, 360).
 *
 * If you want to iterate through lunar quarters (new moon, first quarter, full moon, third quarter)
 * it is much easier to call the functions [_searchMoonQuarter] and [_nextMoonQuarter].
 * This function is useful for finding general phase angles outside those four quarters.
 *
 * @param targetLon
 * The difference in geocentric longitude between the Sun and Moon
 * that specifies the lunar phase being sought. This can be any value
 * in the range [0, 360).  Certain values have conventional names:
 * 0 = new moon, 90 = first quarter, 180 = full moon, 270 = third quarter.
 *
 * @param startTime
 * The beginning of the time window in which to search for the Moon reaching the specified phase.
 *
 * @param limitDays
 * The number of days away from `startTime` that limits the time window for the search.
 * If the value is negative, the search is performed into the past from `startTime`.
 * Otherwise, the search is performed into the future from `startTime`.
 *
 * @return
 * If successful, returns the date and time the moon reaches the phase specified by
 * `targetlon`. This function will return `null` if the phase does not
 * occur within `limitDays` of `startTime`; that is, if the search window is too small.
 */
_Time? _searchMoonPhase(double targetLon, _Time startTime, double limitDays) {
  // To avoid discontinuities in the moonOffset function causing problems,
  // we need to approximate when that function will next return 0.
  // We probe it with the start time and take advantage of the fact
  // that every lunar phase repeats roughly every 29.5 days.
  // There is a surprising uncertainty in the quarter timing,
  // due to the eccentricity of the moon's orbit.
  // I have seen more than 0.9 days away from the simple prediction.
  // To be safe, we take the predicted time of the event and search
  // +/-1.5 days around it (a 3-day wide window).
  final uncertainty = 1.5;
  double moonOffset(_Time time) => _longitudeOffset(_moonPhase(time) - targetLon);
  double estDt;
  double dt1;
  double dt2;
  var ya = moonOffset(startTime);
  if (limitDays < 0.0) {
    // Search backward in time.
    if (ya < 0.0) ya += 360.0;
    estDt = -(_MEAN_SYNODIC_MONTH * ya) / 360.0;
    dt2 = estDt + uncertainty;
    if (dt2 < limitDays) {
      return null;   // not possible for moon phase to occur within specified window (too short)
    }
    dt1 = math.max(limitDays, estDt - uncertainty);
  } else {
    // Search forward in time
    if (ya > 0.0) ya -= 360.0;
    estDt = -(_MEAN_SYNODIC_MONTH * ya) / 360.0;
    dt1 = estDt - uncertainty;
    if (dt1 > limitDays) {
      return null;   // not possible for moon phase to occur within specified window (too short)
    }
    dt2 = math.min(limitDays, estDt + uncertainty);
  }
  final t1 = startTime._addDays(dt1);
  final t2 = startTime._addDays(dt2);
  return _search(t1, t2, 0.1, moonOffset);
}

/**
 * Finds the first lunar quarter after the specified date and time.
 * A lunar quarter is one of the following four lunar phase events:
 * new moon, first quarter, full moon, third quarter.
 * This function finds the lunar quarter that happens soonest
 * after the specified date and time.
 *
 * To continue iterating through consecutive lunar quarters, call this function once,
 * followed by calls to #NextMoonQuarter as many times as desired.
 *
 * See [moonQuartersAfter] for convenient iteration of consecutive quarter phases.
 *
 * @param startTime
 * The date and time at which to start the search.
 *
 * @return
 * A [_MoonQuarterInfo] object reporting the next quarter phase and the time it will occur.
 */
_MoonQuarterInfo _searchMoonQuarter(_Time startTime) {
  final currentPhaseAngle = _moonPhase(startTime);
  final int quarter = (1 + (currentPhaseAngle / 90.0).floor()) % 4;
  final quarterTime = _searchMoonPhase(90.0 * quarter, startTime, 10.0) ??
      (throw _InternalError("Unable to find moon quarter $quarter for startTime=$startTime"));
  return _MoonQuarterInfo(quarter, quarterTime);
}

/**
 * Continues searching for lunar quarters from a previous search.
 *
 * After calling [_searchMoonQuarter], this function can be called
 * one or more times to continue finding consecutive lunar quarters.
 * This function finds the next consecutive moon quarter event after
 * the one passed in as the parameter `mq`.
 *
 * See [moonQuartersAfter] for convenient iteration of consecutive quarter phases.
 *
 * @param mq
 * The previous moon quarter found by a call to [_searchMoonQuarter] or `nextMoonQuarter`.
 *
 * @return
 * The moon quarter that occurs next in time after the one passed in `mq`.
 */
_MoonQuarterInfo _nextMoonQuarter(_MoonQuarterInfo mq) {
  // Skip 6 days past the previous found moon quarter to find the next one.
  // This is less than the minimum possible increment.
  // So far I have seen the interval well contained by the range (6.5, 8.3) days.
  final time = mq.time._addDays(6.0);
  final nextMoonQuarter = _searchMoonQuarter(time);
  // Verify that we found the expected moon quarter.
  final expected = (1 + mq.quarter) % 4;
  if (nextMoonQuarter.quarter != expected) {
    throw _InternalError("Expected to find next quarter $expected, but found ${nextMoonQuarter.quarter}");
  }
  return nextMoonQuarter;
}

/**
 * Enumerates a series of consecutive moon quarter phase events.
 *
 * This function enables iteration through an unlimited number
 * of consecutive lunar quarter phases starting at a given time.
 * This is a convenience wrapper around [_searchMoonQuarter] and [_nextMoonQuarter].
 *
 * @param startTime
 * The date and time for starting the search for a series of quarter phases.
 */
Iterable<_MoonQuarterInfo> _moonQuartersAfter(_Time startTime) sync* {
  var item = _searchMoonQuarter(startTime);
  while (true) {
    yield item;
    item = _nextMoonQuarter(item);
  }
}

/**
 * Searches for the time when the center of a body reaches a specified hour angle as seen by an observer on the Earth.
 *
 * The *hour angle* of a celestial body indicates its position in the sky with respect
 * to the Earth's rotation. The hour angle depends on the location of the observer on the Earth.
 * The hour angle is 0 when the body's center reaches its highest angle above the horizon in a given day.
 * The hour angle increases by 1 unit for every sidereal hour that passes after that point, up
 * to 24 sidereal hours when it reaches the highest point again. So the hour angle indicates
 * the number of hours that have passed since the most recent time that the body has culminated,
 * or reached its highest point.
 *
 * This function searches for the next time a celestial body reaches the given hour angle
 * after the date and time specified by `startTime`.
 * To find when a body culminates, pass 0 for `hourAngle`.
 * To find when a body reaches its lowest point in the sky, pass 12 for `hourAngle`.
 *
 * Note that, especially close to the Earth's poles, a body as seen on a given day
 * may always be above the horizon or always below the horizon, so the caller cannot
 * assume that a culminating object is visible nor that an object is below the horizon
 * at its minimum altitude.
 *
 * On success, the function reports the date and time, along with the horizontal coordinates
 * of the body at that time, as seen by the given observer.
 *
 * @param body
 * The Sun, Moon, any planet other than the Earth,
 * or a user-defined star that was created by a call to [defineStar].
 *
 * @param observer
 * A location on or near the surface of the Earth where the observer is located.
 *
 * @param hourAngle
 * An hour angle value in the range [0, 24) indicating the number of sidereal hours after the
 * body's most recent culmination.
 *
 * @param startTime
 * The date and time at which to start the search.
 *
 * @param direction
 * The direction in time to perform the search: a positive value
 * searches forward in time, a negative value searches backward in time.
 * The function throws an exception if `direction` is zero.
 *
 * @return
 * The time when the body reaches the hour angle, and the horizontal coordinates of the body at that time.
 */
_HourAngleInfo _searchHourAngle(
  _Body body,
  _Observer observer,
  double hourAngle,
  _Time startTime, [
  int direction = 1
]) {
  if (body == _Body.Earth) {
    throw _EarthNotAllowedException();
  }

  if (hourAngle < 0.0 || hourAngle >= 24.0) {
    throw ArgumentError("hourAngle=$hourAngle is out of the allowed range [0, 24).");
  }

  if (direction == 0) {
    throw ArgumentError("direction must be a positive or negative integer, not zero.");
  }

  var time = startTime;
  var iter = 0;
  while (true) {
    ++iter;

    // Calculate Greenwich Apparent Sidereal Time (GAST) at the given time.
    final gast = _siderealTime(time);

    // Obtain equatorial coordinates of date for the body.
    final ofdate = _equator(body, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);

    // Calculate the adjustment needed in sidereal time
    // to bring the hour angle to the desired value.
    var deltaSiderealHours = ((hourAngle + ofdate.ra - observer.longitude / 15.0) - gast).remainder(24.0);
    if (iter == 1) {
      // On the first iteration, always search in the requested time direction.
      if (direction > 0) {
        // Search forward in time.
        if (deltaSiderealHours < 0.0) {
          deltaSiderealHours += 24.0;
        }
      } else {
        // Search backward in time.
        if (deltaSiderealHours > 0.0) {
          deltaSiderealHours -= 24.0;
        }
      }
    } else {
      // On subsequent iterations, we make the smallest possible adjustment,
      // either forward or backward in time.
      if (deltaSiderealHours < -12.0) {
        deltaSiderealHours += 24.0;
      } else if (deltaSiderealHours > 12.0) {
        deltaSiderealHours -= 24.0;
      }
    }

    // If the error is tolerable (less than 0.1 seconds), the search has succeeded.
    if (deltaSiderealHours.abs() * 3600.0 < 0.1) {
      final hor = _horizon(time, observer, ofdate.ra, ofdate.dec, _Refraction.Normal);
      return _HourAngleInfo(time, hor);
    }

    // We need to loop another time to get more accuracy.
    // Update the terrestrial time (in solar days) by adjusting sidereal time.
    time = time._addDays((deltaSiderealHours / 24.0) * _SOLAR_DAYS_PER_SIDEREAL_DAY);
  }
}


/**
 * Finds the hour angle of a body for a given observer and time.
 *
 * The *hour angle* of a celestial body indicates its position in the sky with respect
 * to the Earth's rotation. The hour angle depends on the location of the observer on the Earth.
 * The hour angle is 0 when the body's center reaches its highest angle above the horizon in a given day.
 * The hour angle increases by 1 unit for every sidereal hour that passes after that point, up
 * to 24 sidereal hours when it reaches the highest point again. So the hour angle indicates
 * the number of hours that have passed since the most recent time that the body has culminated,
 * or reached its highest point.
 *
 * @param body
 * The body whose observed hour angle is to be found.
 *
 * @param time
 * The time of the observation.
 *
 * @param observer
 * The geographic location where the observation takes place.
 *
 * @return
 * The real-valued hour angle of the body in the half-open range [0, 24).
 */
double _hourAngle(_Body body, _Time time, _Observer observer) {
  final gast = _siderealTime(time);
  final ofdate = _equator(body, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
  var hourAngle = (observer.longitude / 15 + gast - ofdate.ra).remainder(24.0);
  return (hourAngle < 0.0) ? hourAngle + 24.0 : hourAngle;
}


/**
 * Calculates U.S. Standard Atmosphere (1976) variables as a function of elevation.
 *
 * This function calculates idealized values of pressure, temperature, and density
 * using the U.S. Standard Atmosphere (1976) model.
 * 1. COESA, U.S. Standard Atmosphere, 1976, U.S. Government Printing Office, Washington, DC, 1976.
 * 2. Jursa, A. S., Ed., Handbook of Geophysics and the Space Environment, Air Force Geophysics Laboratory, 1985.
 * See:
 * https://hbcp.chemnetbase.com/faces/documents/14_12/14_12_0001.xhtml
 * https://ntrs.nasa.gov/api/citations/19770009539/downloads/19770009539.pdf
 * https://www.ngdc.noaa.gov/stp/space-weather/online-publications/miscellaneous/us-standard-atmosphere-1976/us-standard-atmosphere_st76-1562_noaa.pdf
 *
 * @param elevationMeters
 * The elevation above sea level at which to calculate atmospheric variables.
 * Must be in the range -500 to +100000, or an exception will occur.
 */
_AtmosphereInfo _atmosphere(double elevationMeters) {
  final P0 = 101325.0;     // pressure at sea level [pascals]
  final T0 = 288.15;       // temperature at sea level [kelvins]
  final T1 = 216.65;       // temperature between 20 km and 32 km [kelvins]

  if (!elevationMeters.isFinite || elevationMeters < -500.0 || elevationMeters > 100000.0) {
    throw ArgumentError("elevationMeters value is not valid: $elevationMeters");
  }

  double temperature;
  double pressure;
  if (elevationMeters <= 11000.0) {
    temperature = T0 - 0.0065 * elevationMeters;
    pressure = P0 * math.pow(T0 / temperature, -5.25577);
  } else if (elevationMeters <= 20000.0) {
    temperature = T1;
    pressure = 22632.0 * math.exp(-0.00015768832 * (elevationMeters - 11000.0));
  } else {
    temperature = T1 + 0.001 * (elevationMeters - 20000.0);
    pressure = 5474.87 * math.pow(T1 / temperature, 34.16319);
  }
  // The density is calculated relative to the sea level value.
  // Using the ideal gas law PV=nRT, we deduce that density is proportional to P/T.
  final density = (pressure / temperature) / (P0 / T0);
  return _AtmosphereInfo(pressure, temperature, density);
}


double _horizonDipAngle(_Observer observer, double metersAboveGround) {
  // Calculate the effective radius of the Earth at ground level below the observer.
  // Correct for the Earth's oblateness.
  final phi = observer.latitude.degreesToRadians();
  final sinphi = math.sin(phi);
  final cosphi = math.cos(phi);
  final c = 1.0 / _hypot(cosphi, sinphi * _EARTH_FLATTENING);
  final s = c * (_EARTH_FLATTENING * _EARTH_FLATTENING);
  final ht_km = (observer.height - metersAboveGround) / 1000.0;    // height of ground above sea level
  final ach = _EARTH_EQUATORIAL_RADIUS_KM * c + ht_km;
  final ash = _EARTH_EQUATORIAL_RADIUS_KM * s + ht_km;
  final radius_m = 1000.0 * _hypot(ach * cosphi, ash * sinphi);

  // Correct refraction of a ray of light traveling tangent to the Earth's surface.
  // Based on: https://www.largeformatphotography.info/sunmooncalc/SMCalc.js
  // which in turn derives from:
  // Sweer, John. 1938.  The Path of a Ray of Light Tangent to the Surface of the Earth.
  // Journal of the Optical Society of America 28 (September):327-329.

  // k = refraction index
  final k = 0.175 * math.pow(1.0 - (6.5e-3 / 283.15) * (observer.height - (2.0 / 3.0) * metersAboveGround), 3.256);

  // Calculate how far below the observer's horizontal plane the observed horizon dips.
  return -((math.sqrt(2 * (1 - k) * metersAboveGround / radius_m) / (1 - k)).radiansToDegrees());
}


class _AscentInfo {
  final _Time tx;
  final _Time ty;
  final double ax;
  final double ay;
  const _AscentInfo(this.tx, this.ty, this.ax, this.ay);
}


_AscentInfo? _findAscent(
  int depth,
  _SearchContext_Altitude context,
  double maxDerivAlt,
  _Time t1,
  _Time t2,
  double a1,
  double a2
) {
  // See if we can find any time interval where the altitude-diff function
  // rises from non-positive to positive.
  if (a1 < 0.0 && a2 >= 0.0) {
    // Trivial success case: the endpoints already rise through zero.
    return _AscentInfo(t1, t2, a1, a2);
  }

  if (a1 >= 0.0 && a2 < 0.0) {
    // Trivial failure case: Assume Nyquist condition prevents an ascent.
    return null;
  }

  if (depth > 17) {
    // Safety valve: do not allow unlimited recursion.
    // This should never happen if the rest of the logic is working correctly,
    // so fail the whole search if it does happen. It's a bug!
    throw _InternalError("Excessive recursion in rise/set ascent search.");
  }

  // Both altitudes are on the same side of zero: both are negative, or both are non-negative.
  // There could be a convex "hill" or a concave "valley" that passes through zero.
  // In polar regions sometimes there is a rise/set or set/rise pair within minutes of each other.
  // For example, the Moon can be below the horizon, then the very top of it becomes
  // visible (moonrise) for a few minutes, then it moves sideways and down below
  // the horizon again (moonset). We want to catch these cases.
  // However, for efficiency and practicality concerns, because the rise/set search itself
  // has a 0.1 second threshold, we do not worry about rise/set pairs that are less than
  // one second apart. These are marginal cases that are rendered highly uncertain
  // anyway, due to unpredictable atmospheric refraction conditions (air temperature and pressure).

  final dt = t2.ut - t1.ut;
  if (dt * _SECONDS_PER_DAY < 1.0) {
    return null;
  }

  // Is it possible to reach zero from the altitude that is closer to zero?
  final da = math.min(a1.abs(), a2.abs());

  // Without loss of generality, assume |a1| <= |a2|.
  // (Reverse the argument in the case |a2| < |a1|.)
  // Imagine you have to "drive" from a1 to 0, then back to a2.
  // You can't go faster than max_deriv_alt. If you can't reach 0 in half the time,
  // you certainly don't have time to reach 0, turn around, and still make your way
  // back up to a2 (which is at least as far from 0 than a1 is) in the time interval dt.
  // Therefore, the time threshold is half the time interval, or dt/2.
  if (da > maxDerivAlt * (dt / 2)) {
    // Prune: the altitude cannot change fast enough to reach zero.
    return null;
  }

  // Bisect the time interval and evaluate the altitude at the midpoint.
  final tmid = _Time((t1.ut + t2.ut) / 2);
  final amid = context.eval(tmid);

  // Use recursion to home in on the first ascending point we can find
  return (
    _findAscent(1 + depth, context, maxDerivAlt, t1, tmid, a1, amid) ??
    _findAscent(1 + depth, context, maxDerivAlt, tmid, t2, amid, a2)
  );
}


double _maxAltitudeSlope(_Body body, double latitude) {
  // Calculate the maximum possible rate that this body's altitude
  // could change [degrees/day] as seen by this observer.
  // First use experimentally determined extreme bounds for this body
  // of how much topocentric RA and DEC can ever change per rate of time.
  // We need minimum possible d(RA)/dt, and maximum possible magnitude of d(DEC)/dt.
  // Conservatively, we round d(RA)/dt down, d(DEC)/dt up.
  // Then calculate the resulting maximum possible altitude change rate.

  if (!latitude.isFinite || latitude < -90.0 || latitude > 90.0) {
    throw ArgumentError("Invalid geographic latitude: $latitude");
  }

  final double derivRa;
  final double derivDec;

  switch (body) {
    case _Body.Moon:
      derivRa  = 4.5;
      derivDec = 8.2;
      break;

    case _Body.Sun:
      derivRa  = 0.8;
      derivDec = 0.5;
      break;

    case _Body.Mercury:
      derivRa  = -1.6;
      derivDec = 1.0;
      break;

    case _Body.Venus:
      derivRa  = -0.8;
      derivDec = 0.6;
      break;

    case _Body.Mars:
      derivRa  = -0.5;
      derivDec = 0.4;
      break;

    case _Body.Jupiter:
    case _Body.Saturn:
    case _Body.Uranus:
    case _Body.Neptune:
    case _Body.Pluto:
      derivRa  = -0.2;
      derivDec = 0.2;
      break;

    case _Body.Star1:
    case _Body.Star2:
    case _Body.Star3:
    case _Body.Star4:
    case _Body.Star5:
    case _Body.Star6:
    case _Body.Star7:
    case _Body.Star8:
      // The minimum allowed heliocentric distance of a user-defined star
      // is one light-year. This can cause a tiny amount of parallax (about 0.001 degrees).
      // Also, including stellar aberration (22 arcsec = 0.006 degrees), we provide a
      // generous safety buffer of 0.008 degrees.
      derivRa  = -0.008;
      derivDec = 0.008;
      break;

    case _Body.Earth:
      throw _EarthNotAllowedException();
    default:
      throw _InvalidBodyException(body);
  }

  final latrad = latitude.degreesToRadians();
  return ((360.0 / _SOLAR_DAYS_PER_SIDEREAL_DAY) - derivRa).abs() * math.cos(latrad) + (derivDec * math.sin(latrad)).abs();
}


const double _RISE_SET_DT = 0.42;     // 10.08 hours: Nyquist-safe for 22-hour period.

class _SearchContext_Altitude {
  final _Body body;
  final _Direction direction;
  final _Observer observer;
  final double bodyRadiusAu;
  final double targetAltitude;

  const _SearchContext_Altitude(this.body, this.direction, this.observer, this.bodyRadiusAu, this.targetAltitude);

  double eval(_Time time) {
    final _Equatorial ofdate = _equator(body, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
    final _Topocentric hor = _horizon(time, observer, ofdate.ra, ofdate.dec, _Refraction.None);
    final altitude = hor.altitude + math.asin(bodyRadiusAu / ofdate.dist).radiansToDegrees();
    return direction.sign * (altitude - targetAltitude);
  }
}


_Time? _internalSearchAltitude(
  _Body body,
  _Observer observer,
  _Direction direction,
  _Time startTime,
  double limitDays,
  double bodyRadiusAu,
  double targetAltitude
) {
  if (!targetAltitude.isFinite || targetAltitude < -90.0 || targetAltitude > 90.0) {
    throw ArgumentError("Target altitude is not valid: $targetAltitude");
  }

  final maxDerivAlt = _maxAltitudeSlope(body, observer.latitude);
  final context = _SearchContext_Altitude(body, direction, observer, bodyRadiusAu, targetAltitude);

  // We allow searching forward or backward in time.
  // But we want to keep t1 < t2, so we need a few if/else statements.
  _Time t1 = startTime;
  _Time t2 = t1;
  double a1 = context.eval(t1);
  double a2 = a1;

  while (true) {
    if (limitDays < 0.0) {
      t1 = t2._addDays(-_RISE_SET_DT);
      a1 = context.eval(t1);
    } else {
      t2 = t1._addDays(_RISE_SET_DT);
      a2 = context.eval(t2);
    }

    final ascent = _findAscent(0, context, maxDerivAlt, t1, t2, a1, a2);
    if (ascent != null) {
      // We found a time interval [t1, t2] that contains an alt-diff
      // rising from negative a1 to non-negative a2.
      // Search for the time where the root occurs.
      final time = _search(ascent.tx, ascent.ty, 0.1, context.eval);
      if (time != null) {
        // Now that we have a solution, we have to check whether it goes outside the time bounds.
        if (limitDays < 0.0) {
          if (time.ut < startTime.ut + limitDays) {
            return null;
          }
        } else {
          if (time.ut > startTime.ut + limitDays) {
            return null;
          }
        }
        return time;   // success!
      }

      // The search should have succeeded. Something is wrong with the ascent finder!
      throw _InternalError("Rise/set search failed after finding ascent: t1=$t1, t2=$t2, a1=$a1, a2=$a2");
    }

    // There is no ascent in this interval, so keep searching.
    if (limitDays < 0.0) {
      if (t1.ut < startTime.ut + limitDays) {
        return null;
      }
      t2 = t1;
      a2 = a1;
    } else {
      if (t2.ut > startTime.ut + limitDays) {
        return null;
      }
      t1 = t2;
      a1 = a2;
    }
  }
}


/**
 * Searches for the next time a celestial body rises or sets as seen by an observer on the Earth.
 *
 * This function finds the next rise or set time of the Sun, Moon, or planet other than the Earth.
 * Rise time is when the body first starts to be visible above the horizon.
 * For example, sunrise is the moment that the top of the Sun first appears to peek above the horizon.
 * Set time is the moment when the body appears to vanish below the horizon.
 * Therefore, this function adjusts for the apparent angular radius of the observed body
 * (significant only for the Sun and Moon).
 *
 * This function corrects for a typical value of atmospheric refraction, which causes celestial
 * bodies to appear higher above the horizon than they would if the Earth had no atmosphere.
 * Astronomy Engine uses a correction of 34 arcminutes. Real-world refraction varies based
 * on air temperature, pressure, and humidity; such weather-based conditions are outside
 * the scope of Astronomy Engine.
 *
 * Note that rise or set may not occur in every 24 hour period.
 * For example, near the Earth's poles, there are long periods of time where
 * the Sun stays below the horizon, never rising.
 * Also, it is possible for the Moon to rise just before midnight but not set during the subsequent 24-hour day.
 * This is because the Moon sets nearly an hour later each day due to orbiting the Earth a
 * significant amount during each rotation of the Earth.
 * Therefore callers must not assume that the function will always succeed.
 *
 * @param body
 * The Sun, Moon, any planet other than the Earth,
 * or a user-defined star that was created by a call to [defineStar].
 *
 * @param observer
 * The location where observation takes place.
 *
 * @param direction
 * Either [_Direction.Rise] to find a rise time or [_Direction.Set] to find a set time.
 *
 * @param startTime
 * The date and time at which to start the search.
 *
 * @param limitDays
 * Limits how many days to search for a rise or set time, and defines
 * the direction in time to search. When `limitDays` is positive, the
 * search is performed into the future, after `startTime`.
 * When negative, the search is performed into the past, before `startTime`.
 * To limit a rise or set time to the same day, you can use a value of 1 day.
 * In cases where you want to find the next rise or set time no matter how far
 * in the future (for example, for an observer near the south pole), you can
 * pass in a larger value like 365.
 *
 * @param metersAboveGround
 * Usually the observer is located at ground level. Then this parameter
 * should be zero. But if the observer is significantly higher than ground
 * level, for example in an airplane, this parameter should be a positive
 * number indicating how far above the ground the observer is.
 * An exception occurs if `metersAboveGround` is negative.
 *
 * @return
 * On success, returns the date and time of the rise or set time as requested.
 * If the function returns `null`, it means the rise or set event does not occur
 * within `limitDays` days of `startTime`. This is a normal condition,
 * not an error.
 */
_Time? _searchRiseSet(
  _Body body,
  _Observer observer,
  _Direction direction,
  _Time startTime,
  double limitDays, [
  double metersAboveGround = 0.0
]) {
  if (!metersAboveGround.isFinite || metersAboveGround < 0.0) {
    throw ArgumentError("metersAboveGround = $metersAboveGround is not valid.");
  }

  final double bodyRadiusAu;
  switch (body) {
    case _Body.Sun:  bodyRadiusAu = _SUN_RADIUS_AU; break;
    case _Body.Moon: bodyRadiusAu = _MOON_EQUATORIAL_RADIUS_AU; break;
    default:        bodyRadiusAu = 0.0; break;
  }

  // Calculate atmospheric density at ground level.
  final atmos = _atmosphere(observer.height - metersAboveGround);

  // Calculate the apparent angular dip of the horizon.
  final dip = _horizonDipAngle(observer, metersAboveGround);

  // Correct refraction for objects near the horizon, using atmospheric density at the ground.
  final altitude = dip - (_REFRACTION_NEAR_HORIZON * atmos.density);

  return _internalSearchAltitude(body, observer, direction, startTime, limitDays, bodyRadiusAu, altitude);
}


/**
 * Finds the next time the center of a body reaches a given altitude.
 *
 * Finds when the center of the given body ascends or descends through a given
 * altitude angle, as seen by an observer at the specified location on the Earth.
 * By using the appropriate combination of `direction` and `altitude` parameters,
 * this function can be used to find when civil, nautical, or astronomical twilight
 * begins (dawn) or ends (dusk).
 *
 * Civil dawn begins before sunrise when the Sun ascends through 6 degrees below
 * the horizon. To find civil dawn, pass `Direction.Rise` for `direction` and -6 for `altitude`.
 *
 * Civil dusk ends after sunset when the Sun descends through 6 degrees below the horizon.
 * To find civil dusk, pass `Direction.Set` for `direction` and -6 for `altitude`.
 *
 * Nautical twilight is similar to civil twilight, only the `altitude` value should be -12 degrees.
 *
 * Astronomical twilight uses -18 degrees as the `altitude` value.
 *
 * By convention for twilight time calculations, the altitude is not corrected for
 * atmospheric refraction. This is because the target altitudes are below the horizon,
 * and refraction is not directly observable.
 *
 * `searchAltitude` is not intended to find rise/set times of a body for two reasons:
 * (1) Rise/set times of the Sun or Moon are defined by their topmost visible portion, not their centers.
 * (2) Rise/set times are affected significantly by atmospheric refraction.
 * Therefore, it is better to use [_searchRiseSet] to find rise/set times, which
 * corrects for both of these considerations.
 *
 * `searchAltitude` will not work reliably for altitudes at or near the body's
 * maximum or minimum altitudes. To find the time a body reaches minimum or maximum altitude
 * angles, use [_searchHourAngle].
 *
 * @param body
 * The Sun, Moon, any planet other than the Earth,
 * or a user-defined star that was created by a call to [defineStar].
 *
 * @param observer
 * The location where observation takes place.
 *
 * @param direction
 * Either [_Direction.Rise] to find an ascending altitude event or [_Direction.Set] to find a descending altitude event.
 *
 * @param startTime
 * The date and time at which to start the search.
 *
 * @param limitDays
 * Limits how many days to search for the body reaching the altitude angle,
 * and defines the direction in time to search. When `limitDays` is positive, the
 * search is performed into the future, after `startTime`.
 * When negative, the search is performed into the past, before `startTime`.
 * To limit the search to the same day, you can use a value of 1 day.
 * In cases where you want to find the altitude event no matter how far
 * in the future (for example, for an observer near the south pole), you can
 * pass in a larger value like 365.
 *
 * @param altitude
 * The desired altitude angle of the body's center above (positive) or below (negative)
 * the observer's local horizon, expressed in degrees. Must be in the range [-90, +90].
 *
 * @return
 * The date and time of the altitude event, or `null` if no such event occurs within the specified time window.
 */
_Time? _searchAltitude(
  _Body body,
  _Observer observer,
  _Direction direction,
  _Time startTime,
  double limitDays,
  double altitude) =>
      _internalSearchAltitude(body, observer, direction, startTime, limitDays, 0.0, altitude);

/**
 * Returns the angle between the given body and the Sun, as seen from the Earth.
 *
 * This function calculates the angular separation between the given body and the Sun,
 * as seen from the center of the Earth. This angle is helpful for determining how
 * easy it is to see the body away from the glare of the Sun.
 *
 * @param body
 * The celestial body whose angle from the Sun is to be measured.
 * Not allowed to be [_Body.Earth].
 *
 * @param time
 * The time at which the observation is made.
 *
 * @return
 * The angle in degrees between the Sun and the specified body as seen from the center of the Earth.
 */
double _angleFromSun(_Body body, _Time time) {
  if (body == _Body.Earth) {
    throw _EarthNotAllowedException();
  }
  final sv = _geoVector(_Body.Sun, time, _Aberration.Corrected);
  final bv = _geoVector(body, time, _Aberration.Corrected);
  return sv.angleWith(bv);
}

double _moonDistance(_Time time) => _MoonContext(time).calcMoon().dist;

double _moonRadialSpeed(_Time time) {
  final dt = 0.001;
  final t1 = time._addDays(-dt / 2.0);
  final t2 = time._addDays(dt / 2.0);
  final dist1 = _moonDistance(t1);
  final dist2 = _moonDistance(t2);
  return (dist2 - dist1) / dt;
}


/**
 * Finds the date and time of the Moon's perigee or apogee.
 *
 * Given a date and time to start the search in `startTime`, this function finds the
 * next date and time that the center of the Moon reaches the closest or farthest point
 * in its orbit with respect to the center of the Earth, whichever comes first
 * after `startTime`.
 *
 * The closest point is called *perigee* and the farthest point is called *apogee*.
 * The word *apsis* refers to either event.
 *
 * To iterate through consecutive alternating perigee and apogee events, call `searchLunarApsis`
 * once, then use the return value to call [nextLunarApsis]. After that,
 * keep feeding the previous return value from `Astronomy.NextLunarApsis` into another
 * call of `Astronomy.NextLunarApsis` as many times as desired.
 *
 * See [lunarApsidesAfter] for convenient iteration of consecutive lunar apsides.
 *
 * @param startTime
 * The date and time at which to start searching for the next perigee or apogee.
 */
_ApsisInfo _searchLunarApsis(_Time startTime) {
  final increment = 0.5;    // number of days to skip in each iteration

  // Check the rate of change of the distance dr/dt at the start time.
  // If it is positive, the Moon is currently getting farther away,
  // so start looking for apogee.
  // Conversely, if dr/dt < 0, start looking for perigee.
  // Either way, the polarity of the slope will change, so the product will be negative.
  // Handle the crazy corner case of exactly touching zero by checking for m1*m2 <= 0.

  var t1 = startTime;
  var m1 = _moonRadialSpeed(t1);
  var iter = 0;
  while (iter * increment < 2.0 * _MEAN_SYNODIC_MONTH) {
    final t2 = t1._addDays(increment);
    final m2 = _moonRadialSpeed(t2);
    if (m1 * m2 <= 0.0) {
      // There is a change of slope polarity within the time range [t1, t2].
      // Therefore this time range contains an apsis.
      // Figure out whether it is perigee or apogee.
      final _ApsisKind kind;
      final int direction;
      if (m1 < 0.0 || m2 > 0.0) {
        // We found a minimum distance event: perigee.
        // Search the time range for the time when the slope goes from negative to positive.
        direction = 1;
        kind = _ApsisKind.Pericenter;
      } else if (m1 > 0.0 || m2 < 0.0) {
        // We found a maximum distance event: apogee.
        // Search the time range for the time when the slope goes from positive to negative.
        direction = -1;
        kind = _ApsisKind.Apocenter;
      } else {
        throw _InternalError("Both slopes are zero in SearchLunarApsis.");
      }

      final apsisTime = _search(t1, t2, 1.0, (time) => direction * _moonRadialSpeed(time)) ??
          (throw _InternalError("Failed to find slope transition in lunar apsis search."));

      final distanceAu = _moonDistance(apsisTime);
      return _ApsisInfo(apsisTime, kind, distanceAu);
    }
    // We have not yet found a slope polarity change. Keep searching.
    t1 = t2;
    m1 = m2;
    ++iter;
  }

  // It should not be possible to fail to find an apsis within 2 synodic months.
  throw _InternalError("Should have found lunar apsis within 2 synodic months.");
}


/**
 * Finds the next lunar perigee or apogee event in a series.
 *
 * Finds the next consecutive time the Moon is closest or farthest from the Earth in its orbit.
 *
 * See [searchLunarApsis] for more details.
 * See [lunarApsidesAfter] for convenient iteration of consecutive lunar apsides.
 *
 * @param apsis
 * An [ApsisInfo] value obtained from a call to [searchLunarApsis] or [nextLunarApsis].
 */
_ApsisInfo _nextLunarApsis(_ApsisInfo apsis) {
  final time = apsis.time._addDays(11.0);
  final next = _searchLunarApsis(time);
  if (next.kind == apsis.kind) {
    throw _InternalError("Found ${next.kind} for two consecutive apsis events: ${apsis.time} and ${next.time}.");
  }
  return next;
}


/**
 * Enumerates a series of consecutive lunar apsides that occur after a given time.
 *
 * This function enables iteration through an unlimited number
 * of consecutive lunar perigees/apogees starting at a given time.
 * This is a convenience wrapper around [searchLunarApsis] and [nextLunarApsis].
 *
 * @param startTime
 * The date and time for starting the search for a series of lunar apsides.
 */
Iterable<_ApsisInfo> _lunarApsidesAfter(_Time startTime) sync* {
  var item = _searchLunarApsis(startTime);
  while (true) {
    yield item;
    item = _nextLunarApsis(item);
  }
}


/**
 * Determines visibility of a celestial body relative to the Sun, as seen from the Earth.
 *
 * This function returns an [ElongationInfo] object, which provides the following
 * information about the given celestial body at the given time:
 *
 * - `visibility` is an enumerated type that specifies whether the body is more easily seen
 *    in the morning before sunrise, or in the evening after sunset.
 *
 * - `elongation` is the angle in degrees between two vectors: one from the center of the Earth to the
 *    center of the Sun, the other from the center of the Earth to the center of the specified body.
 *    This angle indicates how far away the body is from the glare of the Sun.
 *    The elongation angle is always in the range [0, 180].
 *
 * - `eclipticSeparation` is the absolute value of the difference between the body's ecliptic longitude
 *   and the Sun's ecliptic longitude, both as seen from the center of the Earth. This angle measures
 *   around the plane of the Earth's orbit, and ignores how far above or below that plane the body is.
 *   The ecliptic separation is measured in degrees and is always in the range [0, 180].
 *
 * @param body
 * The celestial body whose visibility is to be calculated.
 *
 * @param time
 * The date and time of the observation.
 */
_ElongationInfo _elongation(_Body body, _Time time) {
  final relativeLongitude = _pairLongitude(body, _Body.Sun, time);
  final _elongation = _angleFromSun(body, time);
  return (relativeLongitude > 180.0)
      ? _ElongationInfo(time, _Visibility.Morning, _elongation, 360.0 - relativeLongitude)
      : _ElongationInfo(time, _Visibility.Evening, _elongation, relativeLongitude);
}


double _negativeElongationSlope(_Body body, _Time time) {
  final dt = 0.1;
  final t1 = time._addDays(-dt / 2.0);
  final t2 = time._addDays(dt / 2.0);
  final e1 = _angleFromSun(body, t1);
  final e2 = _angleFromSun(body, t2);
  return (e1 - e2) / dt;
}


/**
 * Finds a date and time when Mercury or Venus reaches its maximum angle from the Sun as seen from the Earth.
 *
 * Mercury and Venus are are often difficult to observe because they are closer to the Sun than the Earth is.
 * Mercury especially is almost always impossible to see because it gets lost in the Sun's glare.
 * The best opportunities for spotting Mercury, and the best opportunities for viewing Venus through
 * a telescope without atmospheric interference, are when these planets reach maximum elongation.
 * These are events where the planets reach the maximum angle from the Sun as seen from the Earth.
 *
 * This function solves for those times, reporting the next maximum elongation event's date and time,
 * the elongation value itself, the relative longitude with the Sun, and whether the planet is best
 * observed in the morning or evening. See [elongation] for more details about the returned structure.
 *
 * @param body
 * Either [_Body.Mercury] or [_Body.Venus]. Any other value will result in an exception.
 * To find the best viewing opportunites for planets farther from the Sun than the Earth is (Mars through Pluto)
 * use [searchRelativeLongitude] to find the next opposition event.
 *
 * @param startTime
 * The date and time at which to begin the search. The maximum elongation event found will always
 * be the first one that occurs after this date and time.
 */
_ElongationInfo _searchMaxElongation(_Body body, _Time startTime) {
  final double s1;
  final double s2;
  switch (body) {
    case _Body.Mercury:
      s1 = 50.0;
      s2 = 85.0;
      break;
    case _Body.Venus:
      s1 = 40.0;
      s2 = 50.0;
      break;
    default:
      throw _InvalidBodyException(body);
  }

  final syn = _synodicPeriod(body);
  var searchTime = startTime;
  var iter = 0;
  while (++iter <= 2) {
    final plon = _eclipticLongitude(body, searchTime);
    final elon = _eclipticLongitude(_Body.Earth, searchTime);
    final rlon = _longitudeOffset(plon - elon);     // clamp to (-180, +180].

    // The slope function is not well-behaved when rlon is near 0 degrees or 180 degrees
    // because there is a cusp there that causes a discontinuity in the derivative.
    // So we need to guard against searching near such times.
    final double adjustDays;
    final double rlonLo;
    final double rlonHi;
    if (rlon >= -s1 && rlon < s1) {
      // Seek to the window [+s1, +s2].
      adjustDays = 0.0;
      // Search forward for the time t1 when rel lon = +s1.
      rlonLo = s1;
      // Search forward for the time t2 when rel lon = +s2.
      rlonHi = s2;
    } else if (rlon > s2 || rlon < -s2) {
      // Seek to the next search window at [-s2, -s1].
      adjustDays = 0.0;
      // Search forward for the time t1 when rel lon = -s2.
      rlonLo = -s2;
      // Search forward for the time t2 when rel lon = -s1.
      rlonHi = -s1;
    } else if (rlon >= 0.0) {
      // rlon must be in the middle of the window [+s1, +s2].
      // Search BACKWARD for the time t1 when rel lon = +s1.
      adjustDays = -syn / 4.0;
      rlonLo = s1;
      rlonHi = s2;
      // Search forward from t1 to find t2 such that rel lon = +s2.
    } else {
      // rlon must be in the middle of the window [-s2, -s1].
      // Search BACKWARD for the time t1 when rel lon = -s2.
      adjustDays = -syn / 4.0;
      rlonLo = -s2;
      // Search forward from t1 to find t2 such that rel lon = -s1.
      rlonHi = -s1;
    }

    final tStart = startTime._addDays(adjustDays);

    final t1 = _searchRelativeLongitude(body, rlonLo, tStart);
    final t2 = _searchRelativeLongitude(body, rlonHi, t1);

    // Now we have a time range [t1,t2] that brackets a maximum elongation event.
    // Confirm the bracketing.
    final m1 = _negativeElongationSlope(body, t1);
    if (m1 >= 0.0) {
      throw _InternalError("There is a bug in the bracketing algorithm! m1 = $m1");
    }

    final m2 = _negativeElongationSlope(body, t2);
    if (m2 <= 0.0) {
      throw _InternalError("There is a bug in the bracketing algorithm! m2 = $m2");
    }

    // Use the generic search algorithm to home in on where the slope crosses from negative to positive.
    final searchx = _search(t1, t2, 10.0, (time) => _negativeElongationSlope(body, time)) ??
        (throw _InternalError("Maximum _elongation search failed."));

    if (searchx.tt >= startTime.tt) {
      return _elongation(body, searchx);
    }

    // This event is in the past (earlier than startTime).
    // We need to search forward from t2 to find the next possible window.
    searchTime = t2._addDays(1.0);
  }

  throw _InternalError("Maximum _elongation search iterated too many times.");
}

/**
 * Finds visual magnitude, phase angle, and other illumination information about a celestial body.
 *
 * This function calculates information about how bright a celestial body appears from the Earth,
 * reported as visual magnitude, which is a smaller (or even negative) number for brighter objects
 * and a larger number for dimmer objects.
 *
 * For bodies other than the Sun, it reports a phase angle, which is the angle in degrees between
 * the Sun and the Earth, as seen from the center of the body. Phase angle indicates what fraction
 * of the body appears illuminated as seen from the Earth. For example, when the phase angle is
 * near zero, it means the body appears "full" as seen from the Earth.  A phase angle approaching
 * 180 degrees means the body appears as a thin crescent as seen from the Earth.  A phase angle
 * of 90 degrees means the body appears "half full".
 * For the Sun, the phase angle is always reported as 0; the Sun emits light rather than reflecting it,
 * so it doesn't have a phase angle.
 *
 * When the body is Saturn, the returned structure contains a field `ringTilt` that holds
 * the tilt angle in degrees of Saturn's rings as seen from the Earth. A value of 0 means
 * the rings appear edge-on, and are thus nearly invisible from the Earth. The `ringTilt` holds
 * 0 for all bodies other than Saturn.
 *
 * @param body
 * The Sun, Moon, or any planet other than the Earth.
 *
 * @param time
 * The date and time of the observation.
 */
_IlluminationInfo _illumination(_Body body, _Time time) {
  if (body == _Body.Earth) {
    throw _EarthNotAllowedException();
  }

  final earth = _helioEarthPos(time);

  final _Vector gc;
  final _Vector hc;
  final double phaseAngle;

  if (body == _Body.Sun) {
    gc = -earth;
    hc = _Vector(0.0, 0.0, 0.0, time);
    // The Sun emits light instead of reflecting it,
    // so we report a placeholder phase angle of 0.
    phaseAngle = 0.0;
  } else {
    if (body == _Body.Moon) {
      // For extra numeric precision, use geocentric Moon formula directly.
      gc = _geoMoon(time);
      hc = earth + gc;
    } else {
      // For planets, the heliocentric vector is more direct to calculate.
      hc = _helioVector(body, time);
      gc = hc - earth;
    }
    phaseAngle = gc.angleWith(hc);
  }

  final geoDist = gc.length();
  final helioDist = hc.length();
  final double mag;
  final double ringTilt;

  if (body == _Body.Saturn) {
    final saturn = _saturnMagnitude(phaseAngle, helioDist, geoDist, gc, time);
    ringTilt = saturn.tilt;
    mag = saturn.mag;
  } else {
    ringTilt = 0.0;
    switch (body) {
      case _Body.Sun:  mag = -0.17 + 5.0 * _log10(geoDist / _AU_PER_PARSEC); break;
      case _Body.Moon: mag = _moonMagnitude(phaseAngle, helioDist, geoDist); break;
      default:        mag = _visualMagnitude(body, phaseAngle, helioDist, geoDist); break;
    }
  }

  final phaseFraction = (1.0 + _dcos(phaseAngle)) / 2.0;
  return _IlluminationInfo(time, mag, phaseAngle, phaseFraction, helioDist, ringTilt);
}

class _MagTiltResult {
  final double mag;
  final double tilt;
  const _MagTiltResult(this.mag, this.tilt);
}

_MagTiltResult _saturnMagnitude(
  double phase,
  double helioDist,
  double geoDist,
  _Vector gc,
  _Time time
) {
  // Based on formulas by Paul Schlyter found here:
  // http://www.stjarnhimlen.se/comp/ppcomp.html#15

  // We must handle Saturn's rings as a major component of its visual magnitude.
  // Find geocentric ecliptic coordinates of Saturn.
  final eclip = _equatorialToEcliptic(gc);

  final ir = 28.06;  // tilt of Saturn's rings to the ecliptic, in degrees
  final nr = (169.51 + (3.82e-5 * time.tt));    // ascending node of Saturn's rings, in degrees

  // Find tilt of Saturn's rings, as seen from Earth.
  final tilt = math.asin(_dsin(eclip.elat) * _dcos(ir) - _dcos(eclip.elat) * _dsin(ir) * _dsin(eclip.elon - nr));
  final sinTilt = math.sin(tilt.abs());

  final mag = (
      -9.0
      + 0.044 * phase
      + sinTilt * (-2.6 + 1.2 * sinTilt)
      + 5.0 * _log10(helioDist * geoDist)
  );

  return _MagTiltResult(mag, _RAD2DEG * tilt);
}


double _moonMagnitude(double phase, double helioDist, double geoDist) {
  // https://astronomy.stackexchange.com/questions/10246/is-there-a-simple-analytical-formula-for-the-lunar-phase-brightness-curve
  final rad = phase.degreesToRadians();
  final rad2 = rad * rad;
  final rad4 = rad2 * rad2;
  final mag = -12.717 + 1.49 * rad.abs() + 0.0431 * rad4;
  final moonMeanDistanceAu = 385000.6 / _KM_PER_AU;
  final geoAu = geoDist / moonMeanDistanceAu;
  return mag + 5.0 * _log10(helioDist * geoAu);
}


double _visualMagnitude(
  _Body body,
  double phase,
  double helioDist,
  double geoDist
) {
  // For Mercury and Venus, see:  https://iopscience.iop.org/article/10.1086/430212
  final double c0;
  var c1 = 0.0;
  var c2 = 0.0;
  var c3 = 0.0;
  switch (body) {
    case _Body.Mercury:
      c0 = -0.60;
      c1 = 4.98;
      c2 = -4.88;
      c3 = 3.02;
      break;
    case _Body.Venus:
      if (phase < 163.6) {
        c0 = -4.47;
        c1 = 1.03;
        c2 = 0.57;
        c3 = 0.13;
      } else {
        c0 = 0.98;
        c1 = -1.02;
      }
      break;
    case _Body.Mars:
      c0 = -1.52;
      c1 = 1.60;
      break;
    case _Body.Jupiter:
      c0 = -9.40;
      c1 = 0.50;
      break;
    case _Body.Uranus:
      c0 = -7.19;
      c1 = 0.25;
      break;
    case _Body.Neptune:
      c0 = -6.87;
      break;
    case _Body.Pluto:
      c0 = -1.00;
      c1 = 4.00;
      break;
    default:
      throw _InvalidBodyException(body);
  }
  final x = phase / 100.0;
  return (c0 + x * (c1 + x * (c2 + x * c3))) + 5.0 * _log10(helioDist * geoDist);
}


double _magnitudeSlope(_Body body, _Time time) {
  // The Search() function finds a transition from negative to positive values.
  // The derivative of magnitude y with respect to time t (dy/dt)
  // is negative as an object gets brighter, because the magnitude numbers
  // get smaller. At peak magnitude dy/dt = 0, then as the object gets dimmer,
  // dy/dt > 0.
  final dt = 0.01;
  final t1 = time._addDays(-dt / 2);
  final t2 = time._addDays(dt / 2);
  final y1 = _illumination(body, t1);
  final y2 = _illumination(body, t2);
  return (y2.mag - y1.mag) / dt;
}


/**
 * Searches for the date and time Venus will next appear brightest as seen from the Earth.
 *
 * This function searches for the date and time Venus appears brightest as seen from the Earth.
 * Currently only Venus is supported for the `body` parameter, though this could change in the future.
 * Mercury's peak magnitude occurs at superior conjunction, when it is virtually impossible to see from the Earth,
 * so peak magnitude events have little practical value for that planet.
 * Planets other than Venus and Mercury reach peak magnitude at opposition, which can
 * be found using [_searchRelativeLongitude].
 * The Moon reaches peak magnitude at full moon, which can be found using
 * [_searchMoonQuarter] or [_searchMoonPhase].
 * The Sun reaches peak magnitude at perihelion, which occurs each year in January.
 * However, the difference is minor and has little practical value.
 *
 * @param body
 * Currently only [_Body.Venus] is allowed. Any other value causes an exception.
 *
 * @param startTime
 * The date and time to start searching for the next peak magnitude event.
 */
_IlluminationInfo _searchPeakMagnitude(_Body body, _Time startTime) {
  if (body != _Body.Venus) {
    throw _InvalidBodyException(body);
  }

  // s1 and s2 are relative longitudes within which peak magnitude of Venus can occur.
  final s1 = 10.0;
  final s2 = 30.0;

  var iter = 0;
  var searchTime = startTime;
  while (++iter <= 2) {
    // Find current heliocentric relative longitude between the
    // inferior planet and the Earth.
    final plon = _eclipticLongitude(body, searchTime);
    final elon = _eclipticLongitude(_Body.Earth, searchTime);
    final rlon = _longitudeOffset(plon - elon);     // clamp to (-180, +180].

    // The slope function is not well-behaved when rlon is near 0 degrees or 180 degrees
    // because there is a cusp there that causes a discontinuity in the derivative.
    // So we need to guard against searching near such times.

    final double rlonLo;
    final double rlonHi;
    final double adjustDays;
    late double syn;
    if (rlon >= -s1 && rlon < s1) {
      // Seek to the window [+s1, +s2].
      adjustDays = 0.0;
      // Search forward for the time t1 when rel lon = +s1.
      rlonLo = s1;
      // Search forward for the time t2 when rel lon = +s2.
      rlonHi = s2;
    } else if (rlon >= s2 || rlon < -s2) {
      // Seek to the next search window at [-s2, -s1].
      adjustDays = 0.0;
      // Search forward for the time t1 when rel lon = -s2.
      rlonLo = -s2;
      // Search forward for the time t2 when rel lon = -s1.
      rlonHi = -s1;
    } else if (rlon >= 0.0) {
      // rlon must be in the middle of the window [+s1, +s2].
      // Search BACKWARD for the time t1 when rel lon = +s1.
      syn = _synodicPeriod(body);
      adjustDays = -syn / 4.0;
      rlonLo = s1;
      // Search forward from t1 to find t2 such that rel lon = +s2.
      rlonHi = s2;
    } else {
      // rlon must be in the middle of the window [-s2, -s1].
      // Search BACKWARD for the time t1 when rel lon = -s2.
      syn = _synodicPeriod(body);
      adjustDays = -syn / 4.0;
      rlonLo = -s2;
      // Search forward from t1 to find t2 such that rel lon = -s1.
      rlonHi = -s1;
    }

    final tStart = searchTime._addDays(adjustDays);
    final t1 = _searchRelativeLongitude(body, rlonLo, tStart);
    final t2 = _searchRelativeLongitude(body, rlonHi, t1);

    // Now we have a time range [t1,t2] that brackets a maximum magnitude event.
    // Confirm the bracketing.
    final m1 = _magnitudeSlope(body, t1);
    if (m1 >= 0.0) {
      throw _InternalError("m1 = $m1; should have been negative.");
    }

    final m2 = _magnitudeSlope(body, t2);
    if (m2 <= 0.0) {
      throw _InternalError("m2 = $m2; should have been positive.");
    }

    // Use the generic search algorithm to home in on where the slope crosses from negative to positive.
    final tx = _search(t1, t2, 10.0, (time) => _magnitudeSlope(body, time)) ??
        (throw _InternalError("Failed to find magnitude slope transition."));

    if (tx.tt >= startTime.tt) {
      return _illumination(body, tx);
    }

    // This event is in the past (earlier than startTime).
    // We need to search forward from t2 to find the next possible window.
    // We never need to search more than twice.
    searchTime = t2._addDays(1.0);
  }
  // This should never happen. If it does, please report as a bug in Astronomy Engine.
  throw _InternalError("Peak magnitude search failed.");
}

/**
 * Calculates the gravitational acceleration experienced by an observer on the Earth.
 *
 * This function implements the WGS 84 Ellipsoidal Gravity Formula.
 * The result is a combination of inward gravitational acceleration
 * with outward centrifugal acceleration, as experienced by an observer
 * in the Earth's rotating frame of reference.
 * The resulting value increases toward the Earth's poles and decreases
 * toward the equator, consistent with changes of the weight measured
 * by a spring scale of a fixed mass moved to different latitudes and heights
 * on the Earth.
 *
 * @param latitude
 * The latitude of the observer in degrees north or south of the equator.
 * By formula symmetry, positive latitudes give the same answer as negative
 * latitudes, so the sign does not matter.
 *
 * @param height
 * The height above the sea level geoid in meters.
 * No range checking is done; however, accuracy is only valid in the
 * range 0 to 100000 meters.
 *
 * @return
 * The effective gravitational acceleration expressed in meters per second squared.
 */
double _observerGravity(double latitude, double height) {
  final s = _dsin(latitude);
  final s2 = s * s;
  final g0 = 9.7803253359 * (1.0 + 0.00193185265241 * s2) / math.sqrt(1.0 - 0.00669437999013 * s2);
  return g0 * (1.0 - (3.15704e-07 - 2.10269e-09 * s2) * height + 7.37452e-14 * height * height);
}


/**
 * Calculates one of the 5 Lagrange points for a pair of co-orbiting bodies.
 *
 * Given a more massive "major" body and a much less massive "minor" body,
 * calculates one of the five Lagrange points in relation to the minor body's
 * orbit around the major body. The parameter `point` is an integer that
 * selects the Lagrange point as follows:
 *
 * 1 = the Lagrange point between the major body and minor body.
 * 2 = the Lagrange point on the far side of the minor body.
 * 3 = the Lagrange point on the far side of the major body.
 * 4 = the Lagrange point 60 degrees ahead of the minor body's orbital position.
 * 5 = the Lagrange point 60 degrees behind the minor body's orbital position.
 *
 * The function returns the state vector for the selected Lagrange point
 * in J2000 mean equator coordinates (EQJ), with respect to the center of the
 * major body.
 *
 * To calculate Sun/Earth Lagrange points, pass in [_Body.Sun] for `majorBody`
 * and [_Body.EMB] (Earth/Moon barycenter) for `minorBody`.
 * For Lagrange points of the Sun and any other planet, pass in just that planet
 * (e.g. [_Body.Jupiter]) for `minorBody`.
 * To calculate Earth/Moon Lagrange points, pass in [_Body.Earth] and [_Body.Moon]
 * for the major and minor bodies respectively.
 *
 * In some cases, it may be more efficient to call [lagrangePointFast],
 * especially when the state vectors have already been calculated, or are needed
 * for some other purpose.
 *
 * @param point
 * An integer 1..5 that selects which of the Lagrange points to calculate.
 *
 * @param time
 * The time for which the Lagrange point is to be calculated.
 *
 * @param majorBody
 * The more massive of the co-orbiting bodies: [_Body.Sun] or [_Body.Earth].
 *
 * @param minorBody
 * The less massive of the co-orbiting bodies. See main remarks.
 *
 * @return
 * The position and velocity of the selected Lagrange point with respect to the major body's center.
 */
_StateVector _lagrangePoint(int point, _Time time, _Body majorBody, _Body minorBody) {
  final majorMass = _massProduct(majorBody);
  final minorMass = _massProduct(minorBody);
  final _StateVector majorState;
  final _StateVector minorState;

  // Calculate the state vectors for the major and minor bodies.
  if (majorBody == _Body.Earth && minorBody == _Body.Moon) {
    // Use geocentric calculations for more precision.
    majorState = _StateVector(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, time);
    minorState = _geoMoonState(time);
  } else {
    majorState = _helioState(majorBody, time);
    minorState = _helioState(minorBody, time);
  }

  return _lagrangePointFast(
    point,
    majorState,
    majorMass,
    minorState,
    minorMass
  );
}


/**
 * Calculates one of the 5 Lagrange points from body masses and state vectors.
 *
 * Given a more massive "major" body and a much less massive "minor" body,
 * calculates one of the five Lagrange points in relation to the minor body's
 * orbit around the major body. The parameter `point` is an integer that
 * selects the Lagrange point as follows:
 *
 * 1 = the Lagrange point between the major body and minor body.
 * 2 = the Lagrange point on the far side of the minor body.
 * 3 = the Lagrange point on the far side of the major body.
 * 4 = the Lagrange point 60 degrees ahead of the minor body's orbital position.
 * 5 = the Lagrange point 60 degrees behind the minor body's orbital position.
 *
 * The caller passes in the state vector and mass for both bodies.
 * The state vectors can be in any orientation and frame of reference.
 * The body masses are expressed as GM products, where G = the universal
 * gravitation constant and M = the body's mass. Thus the units for
 * `major_mass` and `minor_mass` must be au^3/day^2.
 * Use [massProduct] to obtain GM values for various solar system bodies.
 *
 * The function returns the state vector for the selected Lagrange point
 * using the same orientation as the state vector parameters `majorState` and `minorState`,
 * and the position and velocity components are with respect to the major body's center.
 *
 * Consider calling [lagrangePoint], instead of this function, for simpler usage in most cases.
 *
 * @param point
 * An integer 1..5 that selects which of the Lagrange points to calculate.
 *
 * @param majorState
 * The state vector of the major (more massive) of the pair of bodies.
 *
 * @param majorMass
 * The mass product GM of the major body.
 *
 * @param minorState
 * The state vector of the minor (less massive) of the pair of bodies.
 *
 * @param minorMass
 * The mass product GM of the minor body.
 *
 * @return
 * The position and velocity of the selected Lagrange point with respect to the major body's center.
 */
_StateVector _lagrangePointFast(
  int point,
  _StateVector majorState,
  double majorMass,
  _StateVector minorState,
  double minorMass
) {
  final cos_60 = 0.5;
  final sin_60 = 0.8660254037844386;  // sqrt(3) / 2

  if (point < 1 || point > 5) {
    throw ArgumentError("Invalid lagrange point $point");
  }

  if (!majorMass.isFinite || majorMass <= 0.0) {
    throw ArgumentError("Major mass must be a positive number.");
  }

  if (!minorMass.isFinite || minorMass <= 0.0) {
    throw ArgumentError("Minor mass must be a positive number.");
  }

  _verifyIdenticalTimes(majorState.t, minorState.t);

  // Find the relative position vector <dx, dy, dz>.
  var dx = minorState.x - majorState.x;
  var dy = minorState.y - majorState.y;
  var dz = minorState.z - majorState.z;
  final R2 = dx * dx + dy * dy + dz * dz;

  // R = Total distance between the bodies.
  final R = math.sqrt(R2);

  // Find the velocity vector <vx, vy, vz>.
  final vx = minorState.vx - majorState.vx;
  final vy = minorState.vy - majorState.vy;
  final vz = minorState.vz - majorState.vz;

  if (point == 4 || point == 5) {
    // For L4 and L5, we need to find points 60 degrees away from the
    // line connecting the two bodies and in the instantaneous orbital plane.
    // Define the instantaneous orbital plane as the unique plane that contains
    // both the relative position vector and the relative velocity vector.

    // Take the cross product of position and velocity to find a normal vector <nx, ny, nz>.
    final nx = dy * vz - dz * vy;
    final ny = dz * vx - dx * vz;
    final nz = dx * vy - dy * vx;

    // Take the cross product normal*position to get a tangential vector <ux, uy, uz>.
    var ux = ny * dz - nz * dy;
    var uy = nz * dx - nx * dz;
    var uz = nx * dy - ny * dx;

    // Convert the tangential direction vector to a unit vector.
    final U = math.sqrt(ux * ux + uy * uy + uz * uz);
    ux /= U;
    uy /= U;
    uz /= U;

    // Convert the relative position vector into a unit vector.
    dx /= R;
    dy /= R;
    dz /= R;

    // Now we have two perpendicular unit vectors in the orbital plane: 'd' and 'u'.

    // Create new unit vectors rotated (+/-)60 degrees from the radius/tangent directions.
    final vert = (point == 4) ? sin_60 : -sin_60;

    // Rotated radial vector
    final Dx = cos_60 * dx + vert * ux;
    final Dy = cos_60 * dy + vert * uy;
    final Dz = cos_60 * dz + vert * uz;

    // Rotated tangent vector
    final Ux = cos_60 * ux - vert * dx;
    final Uy = cos_60 * uy - vert * dy;
    final Uz = cos_60 * uz - vert * dz;


    // Use dot products to find radial and tangential components of the relative velocity.
    final vrad = vx * dx + vy * dy + vz * dz;
    final vtan = vx * ux + vy * uy + vz * uz;

    return _StateVector(
      R * Dx,
      R * Dy,
      R * Dz,
      vrad * Dx + vtan * Ux,
      vrad * Dy + vtan * Uy,
      vrad * Dz + vtan * Uz,
      majorState.t
    );
  }

  // point = 1..3; all these lie on a straight line between the centers of the two bodies.
  // Calculate the distances of each body from their mutual barycenter.
  // r1 = negative distance of major mass from barycenter (e.g. Sun to the left of barycenter)
  // r2 = positive distance of minor mass from barycenter (e.g. Earth to the right of barycenter)
  final r1 = -R * (minorMass / (majorMass + minorMass));
  final r2 = R * (majorMass / (majorMass + minorMass));

  // Calculate the square of the angular orbital speed in [rad^2 / day^2].
  final omega2 = (majorMass + minorMass) / (R2 * R);

  // Use Newton's Method to numerically solve for the location where
  // outward centrifugal acceleration in the rotating frame of reference
  // is equal to net inward gravitational acceleration.
  // First derive a good initial guess based on approximate analysis.
  double scale;
  final double numer1;
  final double numer2;

  if (point == 1 || point == 2) {
    scale = (majorMass / (majorMass + minorMass)) * _cbrt(minorMass / (3.0 * majorMass));
    numer1 = -majorMass;   // The major mass is to the left of L1 and L2
    if (point == 1) {
      scale = 1.0 - scale;
      numer2 = minorMass;    // The minor mass is to the right of L1.
    } else {
      scale = 1.0 + scale;
      numer2 = -minorMass;   // The minor mass is to the left of L2.
    }
  } else { // point == 3
    scale = ((7.0 / 12.0) * minorMass - majorMass) / (minorMass + majorMass);
    numer1 = majorMass;    // major mass is to the right of L3.
    numer2 = minorMass;    // minor mass is to the right of L3.
  }

  // Iterate Newton's Method until it converges.
  var x = R * scale - r1;
  double deltax;
  do {
    final dr1 = x - r1;
    final dr2 = x - r2;
    final accel = omega2 * x + numer1 / (dr1 * dr1) + numer2 / (dr2 * dr2);
    final deriv = omega2 - 2 * numer1 / (dr1 * dr1 * dr1) - 2 * numer2 / (dr2 * dr2 * dr2);
    deltax = accel / deriv;
    x -= deltax;
  } while ((deltax / R).abs() > 1.0e-14);
  scale = (x - r1) / R;

  return _StateVector(
    scale * dx,
    scale * dy,
    scale * dz,
    scale * vx,
    scale * vy,
    scale * vz,
    majorState.t
  );
}

/**
 * Calculates the Moon's libration angles at a given moment in time.
 *
 * Libration is an observed back-and-forth wobble of the portion of the
 * Moon visible from the Earth. It is caused by the imperfect tidal locking
 * of the Moon's fixed rotation rate, compared to its variable angular speed
 * of orbit around the Earth.
 *
 * This function calculates a pair of perpendicular libration angles,
 * one representing rotation of the Moon in ecliptic longitude `elon`, the other
 * in ecliptic latitude `elat`, both relative to the Moon's mean Earth-facing position.
 *
 * This function also returns the geocentric position of the Moon
 * expressed in ecliptic longitude `mlon`, ecliptic latitude `mlat`, the
 * distance `dist_km` between the centers of the Earth and Moon expressed in kilometers,
 * and the apparent angular diameter of the Moon `diam_deg`.
 *
 * @param time
 * The date and time for which to calculate lunar libration.
 *
 * @return
 * The Moon's ecliptic position and libration angles as seen from the Earth.
 */
_LibrationInfo _libration(_Time time) {
  final t = time._julianCenturies();
  final t2 = t * t;
  final t3 = t2 * t;
  final t4 = t2 * t2;

  final moon = _MoonContext(time).calcMoon();

  final mlon = moon.lon.degreesToRadians();
  final mlat = moon.lat.degreesToRadians();
  final distanceKm = moon.dist * _KM_PER_AU;
  final diamDeg = 2.0 * _datan(_MOON_MEAN_RADIUS_KM / math.sqrt(distanceKm * distanceKm - _MOON_MEAN_RADIUS_KM * _MOON_MEAN_RADIUS_KM));

  // Inclination angle in radians = 0.026930430358272504
  final cosIncl = 0.99963739787586170;
  final sinIncl = 0.02692717526916351;

  // Moon's argument of latitude in radians.
  final f = _normalizeLongitude(93.2720950 + 483202.0175233 * t - 0.0036539 * t2 - t3 / 3526000 + t4 / 863310000).degreesToRadians();

  // Moon's ascending node's mean longitude in radians.
  final omega = _normalizeLongitude(125.0445479 - 1934.1362891 * t + 0.0020754 * t2 + t3 / 467441 - t4 / 60616000).degreesToRadians();

  // Sun's mean anomaly in radians.
  final m = _normalizeLongitude(357.5291092 + 35999.0502909 * t - 0.0001536 * t2 + t3 / 24490000).degreesToRadians();

  // Moon's mean anomaly in radians.
  final mdash = _normalizeLongitude(134.9633964 + 477198.8675055 * t + 0.0087414 * t2 + t3 / 69699 - t4 / 14712000).degreesToRadians();

  // Moon's mean elongation in radians.
  final d = _normalizeLongitude(297.8501921 + 445267.1114034 * t - 0.0018819 * t2 + t3 / 545868 - t4 / 113065000).degreesToRadians();

  // Eccentricity of the Earth's orbit.
  final e = 1.0 - 0.002516 * t - 0.0000074 * t2;

  // Optical librations
  final w = mlon - omega;
  final a = math.atan2(math.sin(w) * math.cos(mlat) * cosIncl - math.sin(mlat) * sinIncl, math.cos(w) * math.cos(mlat));
  final ldash = _longitudeOffset((a - f).radiansToDegrees());
  final bdash = math.asin(-math.sin(w) * math.cos(mlat) * sinIncl - math.sin(mlat) * cosIncl);

  // Physical librations
  final k1 = (119.75 + 131.849 * t).degreesToRadians();
  final k2 = (72.56 + 20.186 * t).degreesToRadians();

  final rho = (
      -0.02752 * math.cos(mdash) +
      -0.02245 * math.sin(f) +
      0.00684 * math.cos(mdash - 2 * f) +
      -0.00293 * math.cos(2 * f) +
      -0.00085 * math.cos(2 * f - 2 * d) +
      -0.00054 * math.cos(mdash - 2 * d) +
      -0.00020 * math.sin(mdash + f) +
      -0.00020 * math.cos(mdash + 2 * f) +
      -0.00020 * math.cos(mdash - f) +
      0.00014 * math.cos(mdash + 2 * f - 2 * d)
  );

  final sigma = (
      -0.02816 * math.sin(mdash) +
      0.02244 * math.cos(f) +
      -0.00682 * math.sin(mdash - 2 * f) +
      -0.00279 * math.sin(2 * f) +
      -0.00083 * math.sin(2 * f - 2 * d) +
      0.00069 * math.sin(mdash - 2 * d) +
      0.00040 * math.cos(mdash + f) +
      -0.00025 * math.sin(2 * mdash) +
      -0.00023 * math.sin(mdash + 2 * f) +
      0.00020 * math.cos(mdash - f) +
      0.00019 * math.sin(mdash - f) +
      0.00013 * math.sin(mdash + 2 * f - 2 * d) +
      -0.00010 * math.cos(mdash - 3 * f)
  );

  final tau = (
      0.02520 * e * math.sin(m) +
      0.00473 * math.sin(2 * mdash - 2 * f) +
      -0.00467 * math.sin(mdash) +
      0.00396 * math.sin(k1) +
      0.00276 * math.sin(2 * mdash - 2 * d) +
      0.00196 * math.sin(omega) +
      -0.00183 * math.cos(mdash - f) +
      0.00115 * math.sin(mdash - 2 * d) +
      -0.00096 * math.sin(mdash - d) +
      0.00046 * math.sin(2 * f - 2 * d) +
      -0.00039 * math.sin(mdash - f) +
      -0.00032 * math.sin(mdash - m - d) +
      0.00027 * math.sin(2 * mdash - m - 2 * d) +
      0.00023 * math.sin(k2) +
      -0.00014 * math.sin(2 * d) +
      0.00014 * math.cos(2 * mdash - 2 * f) +
      -0.00012 * math.sin(mdash - 2 * f) +
      -0.00012 * math.sin(2 * mdash) +
      0.00011 * math.sin(2 * mdash - 2 * m - 2 * d)
  );

  final elon = ldash - tau + (rho * math.cos(a) + sigma * math.sin(a)) * math.tan(bdash);
  final elat = bdash.radiansToDegrees() + sigma * math.cos(a) - rho * math.sin(a);
  return _LibrationInfo(elat, elon, moon.lon, moon.lat, distanceKm, diamDeg);
}

const double _moonNodeStepDays = 10.0;    // a safe number of days to step without missing a Moon node

/**
 * Searches for a time when the Moon's center crosses through the ecliptic plane.
 *
 * Searches for the first ascending or descending node of the Moon after `startTime`.
 * An ascending node is when the Moon's center passes through the ecliptic plane
 * (the plane of the Earth's orbit around the Sun) from south to north.
 * A descending node is when the Moon's center passes through the ecliptic plane
 * from north to south. Nodes indicate possible times of solar or lunar eclipses,
 * if the Moon also happens to be in the correct phase (new or full, respectively).
 * Call `searchMoonNode` to find the first of a series of nodes.
 * Then call [nextMoonNode] to find as many more consecutive nodes as desired.
 *
 * See [moonNodesAfter] for convenient iteration of consecutive nodes.
 *
 * @param startTime
 * The date and time for starting the search for an ascending or descending node of the Moon.
 */
_NodeEventInfo _searchMoonNode(_Time startTime) {
  // Start at the given moment in time and sample the Moon's ecliptic latitude.
  // Step 10 days at a time, searching for an interval where that latitude crosses zero.
  var time1 = startTime;
  var eclip1 = _MoonContext(time1).calcMoon();
  while (true) {
    final time2 = time1._addDays(_moonNodeStepDays);
    final eclip2 = _MoonContext(time2).calcMoon();
    if (eclip1.lat * eclip2.lat <= 0.0) {
      // There is a node somewhere in this closed time interval.
      // Figure out whether it is an ascending node or a descending node.
      final _NodeEventKind kind;
      final double direction;
      if (eclip2.lat > eclip1.lat) {
        direction = 1.0;
        kind = _NodeEventKind.Ascending;
      } else {
        direction = -1.0;
        kind = _NodeEventKind.Descending;
      }
      final nodeTime = _search(time1, time2, 1.0, (time) =>
          direction * _moonEclipticLatitudeDegrees(time)
      ) ?? (throw _InternalError("Could not find Moon node."));
      return _NodeEventInfo(nodeTime, kind);
    }
    time1 = time2;
    eclip1 = eclip2;
  }
}

/**
 * Searches for the next time when the Moon's center crosses through the ecliptic plane.
 *
 * Call [searchMoonNode] to find the first of a series of nodes.
 * Then call `nextMoonNode` to find as many more consecutive nodes as desired.
 *
 * See [moonNodesAfter] for convenient iteration of consecutive nodes.
 *
 * @param prevNode
 * The previous node found from calling [searchMoonNode] or `nextMoonNode`.
 */
_NodeEventInfo _nextMoonNode(_NodeEventInfo prevNode) {
  final time = prevNode.time._addDays(_moonNodeStepDays);
  final node = _searchMoonNode(time);
  if (node.kind == prevNode.kind) {
    throw _InternalError("Invalid repeated moon node kind: ${node.kind}");
  }
  return node;
}


/**
 * Enumerates a series of consecutive ascending/descending nodes of the Moon.
 *
 * This function enables iteration through an unlimited number
 * of consecutive lunar nodes starting at a given time.
 * This is a convenience wrapper around [searchMoonNode] and [nextMoonNode].
 *
 * @param startTime
 * The date and time for starting the search for a series of ascending/descending nodes of the Moon.
 */
Iterable<_NodeEventInfo> _moonNodesAfter(_Time startTime) sync* {
  var item = _searchMoonNode(startTime);
  while (true) {
    yield item;
    item = _nextMoonNode(item);
  }
}



/**
 * Finds the first aphelion or perihelion for a planet after a given time.
 *
 * Given a date and time to start the search in `startTime`, this function finds the
 * next date and time that the center of the specified planet reaches the closest or farthest point
 * in its orbit with respect to the center of the Sun, whichever comes first,
 * after `startTime`.
 *
 * The closest point is called *perihelion* and the farthest point is called *aphelion*.
 * The word *apsis* refers to either event.
 *
 * To iterate through consecutive alternating perihelion and aphelion events,
 * call `searchPlanetApsis` once, then use the return value to call
 * [nextPlanetApsis]. After that, keep feeding the previous return value
 * from `nextPlanetApsis` into another call of `nextPlanetApsis`
 * as many times as desired.
 *
 * See [planetApsidesAfter] for convenient iteration of consecutive apsides.
 *
 * @param body
 * The planet for which to find the next perihelion/aphelion event.
 * Not allowed to be [_Body.Sun] or [_Body.Moon].
 *
 * @param startTime
 * The date and time at which to start searching for the next perihelion or aphelion.
 */
_ApsisInfo _searchPlanetApsis(_Body body, _Time startTime) {
  // Neptune and Pluto have "wavy" orbits for which a brute force search is needed.
  // Their orbits have multiple heliocentric distance maxima/minima clustered near each other!
  if (body == _Body.Neptune || body == _Body.Pluto) {
    return _bruteSearchPlanetApsis(body, startTime);
  }

  // All the other planets have singular local maxima/minima per orbit.
  // Therefore we can use a more efficient calculus-based search.
  final orbitPeriodDays = _planetOrbitalPeriod(body);
  final increment = orbitPeriodDays / 6.0;
  var t1 = startTime;
  var iter = 0;
  var m1 = _helioDistanceSlope(body, t1);
  while (iter * increment < 2.0 * orbitPeriodDays) {
    final t2 = t1._addDays(increment);
    final m2 = _helioDistanceSlope(body, t2);
    if (m1 * m2 <= 0.0) {
      // There is a change of slope polarity within the time range [t1, t2].
      // Therefore this time range contains an apsis.
      // Figure out whether it is perihelion or aphelion.
      final _ApsisKind kind;
      final double direction;
      if (m1 < 0.0 || m2 > 0.0) {
        // We found a minimum-distance event: perihelion.
        // Search the time range for the time when the slope goes from negative to positive.
        direction = 1.0;
        kind = _ApsisKind.Pericenter;
      } else if (m1 > 0.0 || m2 < 0.0) {
        // We found a maximum-distance event: aphelion.
        // Search the time range for the time when the slope goes from positive to negative.
        direction = -1.0;
        kind = _ApsisKind.Apocenter;
      } else {
        // This should never happen. It should not be possible for both slopes to be zero.
        throw _InternalError("Both slopes were zero in _searchPlanetApsis.");
      }

      final apsisTime = _search(t1, t2, 1.0, (time) =>
          direction * _helioDistanceSlope(body, time)
      ) ?? (throw _InternalError("Failed to find slope transition in planetary apsis search."));

      final distance = _helioDistance(body, apsisTime);
      return _ApsisInfo(apsisTime, kind, distance);
    }
    // We have not yet found a slope polarity change. Keep searching.
    t1 = t2;
    m1 = m2;
    ++iter;
  }
  // It should not be possible to fail to find an apsis within 2 planetary orbits.
  throw _InternalError("Should have found planetary apsis within 2 orbital periods.");
}


/**
 * Finds the next planetary perihelion or aphelion event in a series.
 *
 * This function requires an [ApsisInfo] value obtained from a call
 * to [searchPlanetApsis] or `nextPlanetApsis`.
 * Given an aphelion event, this function finds the next perihelion event, and vice versa.
 *
 * See [searchPlanetApsis] for more details.
 * See [planetApsidesAfter] for convenient iteration of consecutive apsides.
 *
 * @param body
 * The planet for which to find the next perihelion/aphelion event.
 * Not allowed to be [_Body.Sun] or [_Body.Moon].
 * Must match the body passed into the call that produced the `apsis` parameter.
 *
 * @param apsis
 * An apsis event obtained from a call to [searchPlanetApsis] or `nextPlanetApsis`.
 */
_ApsisInfo _nextPlanetApsis(_Body body, _ApsisInfo apsis) {
  // Skip 1/4 of an orbit before starting search again.
  final time = apsis.time._addDays(_planetOrbitalPeriod(body) / 4.0);
  final next = _searchPlanetApsis(body, time);
  // Verify that we found the opposite kind of apsis from the previous one.
  if (next.kind == apsis.kind) {
    throw _InternalError("Found ${next.kind} twice in a row.");
  }
  return next;
}


/**
 * Enumerates a series of consecutive planetary perihelia/aphelia events.
 *
 * This function enables iteration through an unlimited number
 * of consecutive planetary apsides.
 * This is a convenience wrapper around [searchPlanetApsis] and [nextPlanetApsis].
 *
 * @param body
 * The planet for which to find a series of perihelia/aphelia events.
 * Not allowed to be [_Body.Sun] or [_Body.Moon].
 *
 * @param startTime
 * The date and time for starting the search for a series of apsides.
 */
Iterable<_ApsisInfo> _planetApsidesAfter(_Body body, _Time startTime) sync* {
  var item = _searchPlanetApsis(body, startTime);
  while (true) {
    yield item;
    item = _nextPlanetApsis(body, item);
  }
}


/**
 * Returns the average number of days it takes for a planet to orbit the Sun.
 *
 * @param body
 * One of the planets: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune, or Pluto.
 */
double _planetOrbitalPeriod(_Body body) =>
    body._orbitalPeriod ?? (throw _InvalidBodyException(body));


double _helioDistanceSlope(_Body body, _Time time) {
  final dt = 0.001;
  final t1 = time._addDays(-dt / 2.0);
  final t2 = time._addDays(dt / 2.0);
  final r1 = _helioDistance(body, t1);
  final r2 = _helioDistance(body, t2);
  return (r2 - r1) / dt;
}


_ApsisInfo _bruteSearchPlanetApsis(_Body body, _Time startTime) {
  // Neptune is a special case for two reasons:
  // 1. Its orbit is nearly circular (low orbital eccentricity).
  // 2. It is so distant from the Sun that the orbital period is very long.
  // Put together, this causes wobbling of the Sun around the Solar System Barycenter (SSB)
  // to be so significant that there are 3 local minima in the distance-vs-time curve
  // near each apsis. Therefore, unlike for other planets, we can't use an optimized
  // algorithm for finding dr/dt = 0.
  // Instead, we use a dumb, brute-force algorithm of sampling and finding min/max
  // heliocentric distance.
  //
  // There is a similar problem in the TOP2013 model for Pluto:
  // Its position vector has high-frequency oscillations that confuse the
  // slope-based determination of apsides.
  //
  // Rewind approximately 30 degrees in the orbit,
  // then search forward for 270 degrees.
  // This is a very cautious way to prevent missing an apsis.
  // Typically we will find two apsides, and we pick whichever
  // apsis is ealier, but after startTime.
  // Sample points around this orbital arc and find when the distance
  // is greatest and smallest.

  final npoints = 100;
  final period = _planetOrbitalPeriod(body);
  final t1 = startTime._addDays(period * (-30.0 / 360.0));
  final t2 = startTime._addDays(period * (270.0 / 360.0));
  var tMin = t1;
  var tMax = t1;
  final interval = (t2.ut - t1.ut) / (npoints - 1.0);
  var maxDist = -1.0;
  var minDist = -1.0;
  for (var i = 0; i < npoints; i++) {
    final time = t1._addDays(i * interval);
    final dist = _helioDistance(body, time);
    if (i == 0) {
      maxDist = dist;
      minDist = dist;
    } else {
      if (dist > maxDist) {
        maxDist = dist;
        tMax = time;
      }
      if (dist < minDist) {
        minDist = dist;
        tMin = time;
      }
    }
  }

  final perihelion = _planetExtreme(body, _ApsisKind.Pericenter, tMin._addDays(-2.0 * interval), 4.0 * interval);
  final aphelion   = _planetExtreme(body, _ApsisKind.Apocenter,  tMax._addDays(-2.0 * interval), 4.0 * interval);

  if (perihelion.time.tt >= startTime.tt) {
    if (aphelion.time.tt >= startTime.tt) {
      // Perihelion and aphelion are both valid. Pick the one that comes first.
      if (aphelion.time.tt < perihelion.time.tt) {
        return aphelion;
      }
    }
    return perihelion;
  }

  if (aphelion.time.tt >= startTime.tt) {
    return aphelion;
  }

  throw _InternalError("Failed to find apsis for $body.");
}


_ApsisInfo _planetExtreme(_Body body, _ApsisKind kind, _Time startTime, double initDaySpan) {
  final double direction;
  switch (kind) {
    case _ApsisKind.Apocenter:  direction = 1.0; break;
    case _ApsisKind.Pericenter: direction = -1.0; break;
  }
  final npoints = 10;
  var searchTime = startTime;
  var daySpan = initDaySpan;
  while (true) {
    final interval = daySpan / (npoints - 1);
    if (interval < 1.0 / 1440.0) {      // iterate until uncertainty is less than one minute
      final apsisTime = searchTime._addDays(interval / 2.0);
      final distance = _helioDistance(body, apsisTime);
      return _ApsisInfo(apsisTime, kind, distance);
    }
    var bestI = -1;
    var bestDistance = 0.0;
    for (var i = 0; i < npoints; i++) {
      final time = searchTime._addDays(i * interval);
      final distance = direction * _helioDistance(body, time);
      if (i == 0 || distance > bestDistance) {
        bestI = i;
        bestDistance = distance;
      }
    }

    // Narrow in on the extreme point.
    searchTime = searchTime._addDays((bestI - 1) * interval);
    daySpan = 2.0 * interval;
  }
}

/**
 * Calculates a rotation matrix from J2000 mean equator (EQJ) to J2000 mean ecliptic (ECL).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQJ = equatorial system, using equator at J2000 epoch.
 * Target: ECL = ecliptic system, using equator at J2000 epoch.
 */
_RotationMatrix _rotationEqjEcl() {
  // ob = mean obliquity of the J2000 ecliptic = 0.40909260059599012 radians.
  final c = 0.9174821430670688;   // cos(ob)
  final s = 0.3977769691083922;   // sin(ob)
  return _RotationMatrix(
    1.0, 0.0, 0.0,
    0.0,  c,  -s,
    0.0,  s,  c
  );
}

/**
 * Calculates a rotation matrix from J2000 mean ecliptic (ECL) to J2000 mean equator (EQJ).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: ECL = ecliptic system, using equator at J2000 epoch.
 * Target: EQJ = equatorial system, using equator at J2000 epoch.
 */
_RotationMatrix _rotationEclEqj() {
  // ob = mean obliquity of the J2000 ecliptic = 0.40909260059599012 radians.
  final c = 0.9174821430670688;   // cos(ob)
  final s = 0.3977769691083922;   // sin(ob)
  return _RotationMatrix(
    1.0, 0.0, 0.0,
    0.0,  c,  s,
    0.0,  -s,  c
  );
}

/**
 * Calculates a rotation matrix from J2000 mean equator (EQJ) to equatorial of-date (EQD).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQJ = equatorial system, using equator at J2000 epoch.
 * Target: EQD = equatorial system, using equator of the specified date/time.
 *
 * @param time
 * The date and time at which the Earth's equator defines the target orientation.
 */
_RotationMatrix _rotationEqjEqd(_Time time) =>
    _precessionRot(time, _PrecessDirection.From2000).combine(
    _nutationRot(time, _PrecessDirection.From2000));

/**
 * Calculates a rotation matrix from J2000 mean equator (EQJ) to true ecliptic of date (ECT).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQJ = equatorial system, using equator at J2000 epoch.
 * Target: ECT = ecliptic system, using true equinox of the specified date/time.
 *
 * @param time
 * The date and time at which the Earth's equator defines the target orientation.
 */
_RotationMatrix _rotationEqjEct(_Time time) =>
    _rotationEqjEqd(time).combine(
    _rotationEqdEct(time));

/**
 * Calculates a rotation matrix from true ecliptic of date (ECT) to J2000 mean equator (EQJ).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: ECT = ecliptic system, using true equinox of the specified date/time.
 * Target: EQJ = equatorial system, using equator at J2000 epoch.
 *
 * @param time
 * The date and time at which the Earth's equator defines the target orientation.
 */
_RotationMatrix _rotationEctEqj(_Time time) =>
    _rotationEctEqd(time).combine(
    _rotationEqdEqj(time));

/**
 * Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean equator (EQJ).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQD = equatorial system, using equator of the specified date/time.
 * Target: EQJ = equatorial system, using equator at J2000 epoch.
 *
 * @param time
 * The date and time at which the Earth's equator defines the source orientation.
 */
_RotationMatrix _rotationEqdEqj(_Time time) =>
    _nutationRot(time, _PrecessDirection.Into2000).combine(
    _precessionRot(time, _PrecessDirection.Into2000));

/**
 * Calculates a rotation matrix from equatorial of-date (EQD) to horizontal (HOR).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQD = equatorial system, using equator of the specified date/time.
 * Target: HOR = horizontal system.
 *
 * @param time
 * The date and time at which the Earth's equator applies.
 *
 * @param observer
 * A location near the Earth's mean sea level that defines the observer's horizon.
 *
 * @return
 * A rotation matrix that converts EQD to HOR at `time` and for `observer`.
 * The components of the horizontal vector are:
 * x = north, y = west, z = zenith (straight up from the observer).
 * These components are chosen so that the "right-hand rule" works for the vector
 * and so that north represents the direction where azimuth = 0.
 */
_RotationMatrix _rotationEqdHor(_Time time, _Observer observer) {
  // See the `horizon` function for more explanation of how this works.

  final sinlat = _dsin(observer.latitude);
  final coslat = _dcos(observer.latitude);
  final sinlon = _dsin(observer.longitude);
  final coslon = _dcos(observer.longitude);

  final uze = _Vector(coslat * coslon, coslat * sinlon, sinlat, time);
  final une = _Vector(-sinlat * coslon, -sinlat * sinlon, coslat, time);
  final uwe = _Vector(sinlon, -coslon, 0.0, time);

  // Multiply sidereal hours by -15 to convert to degrees and flip eastward
  // rotation of the Earth to westward apparent movement of objects with time.

  final angle = -15.0 * _siderealTime(time);
  final uz = _spin(angle, uze);
  final un = _spin(angle, une);
  final uw = _spin(angle, uwe);

  return _RotationMatrix(
    un.x, uw.x, uz.x,
    un.y, uw.y, uz.y,
    un.z, uw.z, uz.z
  );
}

/**
 * Calculates a rotation matrix from horizontal (HOR) to equatorial of-date (EQD).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: HOR = horizontal system (x=North, y=West, z=Zenith).
 * Target: EQD = equatorial system, using equator of the specified date/time.
 *
 * @param time
 * The date and time at which the Earth's equator applies.
 *
 * @param observer
 * A location near the Earth's mean sea level that defines the observer's horizon.
 *
 * @return A rotation matrix that converts HOR to EQD at `time` and for `observer`.
 */
_RotationMatrix _rotationHorEqd(_Time time, _Observer observer) =>
    _rotationEqdHor(time, observer).inverse();

/**
 * Calculates a rotation matrix from horizontal (HOR) to J2000 equatorial (EQJ).
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: HOR = horizontal system (x=North, y=West, z=Zenith).
 * Target: EQJ = equatorial system, using equator at the J2000 epoch.
 *
 * @param time
 * The date and time of the observation.
 *
 * @param observer
 * A location near the Earth's mean sea level that defines the observer's horizon.
 *
 * @return A rotation matrix that converts HOR to EQJ at `time` and for `observer`.
 */
_RotationMatrix _rotationHorEqj(_Time time, _Observer observer) =>
    _rotationHorEqd(time, observer).combine(
    _rotationEqdEqj(time));

/**
 * Calculates a rotation matrix from J2000 mean equator (EQJ) to horizontal (HOR).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQJ = equatorial system, using the equator at the J2000 epoch.
 * Target: HOR = horizontal system.
 *
 * @param time
 * The date and time of the observation.
 *
 * @param observer
 * A location near the Earth's mean sea level that defines the observer's horizon.
 *
 * @return
 * A rotation matrix that converts EQJ to HOR at `time` and for `observer`.
 * The components of the horizontal vector are:
 * x = north, y = west, z = zenith (straight up from the observer).
 * These components are chosen so that the "right-hand rule" works for the vector
 * and so that north represents the direction where azimuth = 0.
 */
_RotationMatrix _rotationEqjHor(_Time time, _Observer observer) =>
    _rotationHorEqj(time, observer).inverse();

/**
 * Calculates a rotation matrix from equatorial of-date (EQD) to J2000 mean ecliptic (ECL).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQD = equatorial system, using equator of date.
 * Target: ECL = ecliptic system, using equator at J2000 epoch.
 *
 * @param time
 * The date and time of the source equator.
 *
 * @return A rotation matrix that converts EQD to ECL.
 */
_RotationMatrix _rotationEqdEcl(_Time time) =>
    _rotationEqdEqj(time).combine(
    _rotationEqjEcl());

/**
 * Calculates a rotation matrix from J2000 mean ecliptic (ECL) to equatorial of-date (EQD).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: ECL = ecliptic system, using equator at J2000 epoch.
 * Target: EQD = equatorial system, using equator of date.
 *
 * @param time
 * The date and time of the desired equator.
 *
 * @return A rotation matrix that converts ECL to EQD.
 */
_RotationMatrix _rotationEclEqd(_Time time) =>
    _rotationEqdEcl(time).inverse();

/**
 * Calculates a rotation matrix from J2000 mean ecliptic (ECL) to horizontal (HOR).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: ECL = ecliptic system, using equator at J2000 epoch.
 * Target: HOR = horizontal system.
 *
 * @param time
 * The date and time of the desired horizontal orientation.
 *
 * @param observer
 * A location near the Earth's mean sea level that defines the observer's horizon.
 *
 * @return
 * A rotation matrix that converts ECL to HOR at `time` and for `observer`.
 * The components of the horizontal vector are:
 * x = north, y = west, z = zenith (straight up from the observer).
 * These components are chosen so that the "right-hand rule" works for the vector
 * and so that north represents the direction where azimuth = 0.
 */
_RotationMatrix _rotationEclHor(_Time time, _Observer observer) =>
    _rotationEclEqd(time).combine(
    _rotationEqdHor(time, observer));

/**
 * Calculates a rotation matrix from horizontal (HOR) to J2000 mean ecliptic (ECL).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: HOR = horizontal system.
 * Target: ECL = ecliptic system, using equator at J2000 epoch.
 *
 * @param time
 * The date and time of the horizontal observation.
 *
 * @param observer
 * The location of the horizontal observer.
 *
 * @return
 * A rotation matrix that converts HOR to ECL.
 */
_RotationMatrix _rotationHorEcl(_Time time, _Observer observer) =>
    _rotationEclHor(time, observer).inverse();

/**
 * Calculates a rotation matrix from galactic (GAL) to J2000 mean equator (EQJ).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: GAL = galactic system (IAU 1958 definition).
 * Target: EQJ = equatorial system, using the equator at the J2000 epoch.
 *
 * @return
 * A rotation matrix that converts GAL to EQJ.
 */
_RotationMatrix _rotationEqjGal() =>
    // This rotation matrix was calculated by the following script:
    // demo/python/galeqj_matrix.py
    _RotationMatrix(
      -0.0548624779711344, 0.4941095946388765, -0.8676668813529025,
      -0.8734572784246782, -0.4447938112296831, -0.1980677870294097,
      -0.4838000529948520, 0.7470034631630423, 0.4559861124470794
    );

/**
 * Calculates a rotation matrix from galactic (GAL) to J2000 mean equator (EQJ).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: GAL = galactic system (IAU 1958 definition).
 * Target: EQJ = equatorial system, using the equator at the J2000 epoch.
 *
 * @return
 * A rotation matrix that converts GAL to EQJ.
 */
_RotationMatrix _rotationGalEqj() =>
    // This rotation matrix was calculated by the following script:
    // demo/python/galeqj_matrix.py
    _RotationMatrix(
      -0.0548624779711344, -0.8734572784246782, -0.4838000529948520,
      0.4941095946388765, -0.4447938112296831, 0.7470034631630423,
      -0.8676668813529025, -0.1980677870294097, 0.4559861124470794
    );


/**
 * Calculates a rotation matrix from true ecliptic of date (ECT) to equator of date (EQD).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: ECT = true ecliptic of date
 * Target: EQD = equator of date
 *
 * @param time
 * The date and time of the ecliptic/equator conversion.
 *
 * @return
 * A rotation matrix that converts ECT to EQD.
 */
_RotationMatrix _rotationEctEqd(_Time time) {
  final et = _earthTilt(time);
  final tobl = et.tobl.degreesToRadians();
  final c = math.cos(tobl);
  final s = math.sin(tobl);
  return _RotationMatrix(
    1.0, 0.0, 0.0,
    0.0,  c,  s,
    0.0,  -s,  c
  );
}


/**
 * Calculates a rotation matrix from equator of date (EQD) to true ecliptic of date (ECT).
 *
 * This is one of the family of functions that returns a rotation matrix
 * for converting from one orientation to another.
 * Source: EQD = equator of date
 * Target: ECT = true ecliptic of date
 *
 * @param time
 * The date and time of the equator/ecliptic conversion.
 *
 * @return
 * A rotation matrix that converts EQD to ECT.
 */
_RotationMatrix _rotationEqdEct(_Time time) {
  final et = _earthTilt(time);
  final tobl = et.tobl.degreesToRadians();
  final c = math.cos(tobl);
  final s = math.sin(tobl);
  return _RotationMatrix(
    1.0, 0.0, 0.0,
    0.0,  c,  -s,
    0.0,  s,  c
  );
}


/**
 * Determines the constellation that contains the given point in the sky.
 *
 * Given J2000 equatorial (EQJ) coordinates of a point in the sky, determines the
 * constellation that contains that point.
 *
 * @param ra
 * The right ascension (RA) of a point in the sky, using the J2000 equatorial system (EQJ).
 *
 * @param dec
 * The declination (DEC) of a point in the sky, using the J2000 equatorial system (EQJ).
 *
 * @return
 * A structure that contains the 3-letter abbreviation and full name
 * of the constellation that contains the given (ra,dec), along with
 * the converted B1875 (ra,dec) for that point.
 */
_ConstellationInfo _constellation(double ra, double dec) {
  if (dec < -90.0 || dec > 90.0) {
    throw ArgumentError("Invalid declination angle $dec. Must be -90..+90.");
  }

  // Convert right ascension to degrees, and normalize to the range [0, 360).
  final raDeg = _withMinDegreeValue(ra * 15.0, 0.0);

  // Convert coordinates from J2000 to B1875.
  final sph2000 = _Spherical(dec, raDeg, 1.0);
  final vec2000 = sph2000.toVector(_epoch2000);
  final vec1875 = _constelRot.rotate(vec2000);
  final equ1875 = vec1875.toEquatorial();

  // Convert DEC from degrees and RA from hours,
  // into compact angle units used in the constelBounds table.
  final xDec = 24.0 * equ1875.dec;
  final xRa = (24.0 * 15.0) * equ1875.ra;

  // Search for the constellation using the B1875 coordinates.
  for (final b in _constelBounds) {
    if ((b.decLo <= xDec) && (b.raHi > xRa) && (b.raLo <= xRa)) {
      return _ConstellationInfo(_constelNames[b.index].symbol, _constelNames[b.index].name, equ1875.ra, equ1875.dec);
    }
  }

  // This should never happen! If it does, please report to: https://github.com/cosinekitty/astronomy/issues
  throw _InternalError("Unable to find constellation for coordinates RA=$ra, DEC=$dec");
}

//=======================================================================================
// Generic gravity simulator

/**
 * A simulation of zero or more small bodies moving through the Solar System.
 *
 * This class calculates the movement of arbitrary small bodies,
 * such as asteroids or comets, that move through the Solar System.
 * It does so by calculating the gravitational forces on the bodies
 * from the Sun and planets. The user of this class supplies a
 * list of initial positions and velocities for the small bodies.
 * Then the class can update the positions and velocities over small
 * time steps. The gravity simulator also provides access to the
 * positions and velocities of the Sun and planets used in the simulation.
 */
class _GravitySimulator {
  /**
   * The origin of the reference frame. See constructor for more info.
   */
  final _Body originBody;

  late _GravSimEndpoint _prev;
  late _GravSimEndpoint _curr;

  /**
   * Creates a gravity simulation object.
   *
   * @param originBody
   * Specifies the origin of the reference frame.
   * All position vectors and velocity vectors will use `originBody`
   * as the origin of the coordinate system.
   * This origin applies to all the input vectors provided in the
   * `bodyStates` parameter of this function, along with all
   * output vectors returned by [GravitySimulator.update].
   * Most callers will want to provide one of the following:
   * [_Body.Sun] for heliocentric coordinates,
   * [_Body.SSB] for solar system barycentric coordinates,
   * or [_Body.Earth] for geocentric coordinates. Note that the
   * gravity simulator does not correct for light travel time;
   * all state vectors are tied to a Newtonian "instantaneous" time.
   *
   * @param time
   * The initial time at which to start the simulation.
   *
   * @param bodyStates
   * An array of initial state vectors (positions and velocities) of the small bodies to be simulated.
   * The caller must know the positions and velocities of the small bodies at an initial moment in time.
   * Their positions and velocities are expressed with respect to `originBody`, using equatorial
   * J2000 orientation (EQJ).
   * Positions are expressed in astronomical units (AU).
   * Velocities are expressed in AU/day.
   * All the times embedded within the state vectors must be exactly equal to `time`,
   * or this constructor will throw an exception.
   */
  _GravitySimulator(
    this.originBody,
    _Time time,
    List<_StateVector> bodyStates
  ) {
    // Verify that all the state vectors have matching times.
    for (final b in bodyStates) {
      if (b.t.tt != time.tt) {
        throw ArgumentError("Inconsistent time(s) in bodyStates array.");
      }
    }

    _curr = _initialEndpoint(time, bodyStates);
    _prev = _initialEndpoint(time, bodyStates);

    // Calculate the states of the Sun and planets.
    _calcSolarSystem();

    // We need to do all the physics calculations in barycentric coordinates.
    // But the caller provides the input vectors with respect to `originBody`.
    // Correct the input body state vectors for the specified origin.
    if (originBody != _Body.SSB) {
      // Determine the barycentric state of the origin body.
      final ostate = _internalBodyState(originBody);

      // Add barycentric origin to origin-centric bodies to obtain barycentric bodies.
      for (final bstate in _curr.bodies) {
        bstate.r.x += ostate.r.x;
        bstate.r.y += ostate.r.y;
        bstate.r.z += ostate.r.z;
        bstate.v.x += ostate.v.x;
        bstate.v.y += ostate.v.y;
        bstate.v.z += ostate.v.z;
      }
    }

    // Calculate the net acceleration experienced by the small bodies.
    _calcBodyAccelerations();

    // To prepare for a possible swap operation, duplicate the current state into the previous state.
    _duplicate();
  }

  /**
   * Returns the time of the current simulation step.
   */
  _Time time() => _curr.time;


  /**
   * Advances the gravity simulation by a small time step.
   *
   * Updates the simulation of the user-supplied small bodies
   * to the time indicated by the `time` parameter.
   * Retuns an updated array of state vectors for the small bodies.
   * The positions and velocities in the returned array are referenced
   * to the `originBody` that was used to construct this simulator.
   *
   * @param time
   * A time that is a small increment away from the current simulation time.
   * It is up to the developer to figure out an appropriate time increment.
   * Depending on the trajectories, a smaller or larger increment
   * may be needed for the desired accuracy. Some experimentation may be needed.
   * Generally, bodies that stay in the outer Solar System and move slowly can
   * use larger time steps.  Bodies that pass into the inner Solar System and
   * move faster will need a smaller time step to maintain accuracy.
   * The `time` value may be after or before the current simulation time
   * to move forward or backward in time.
   */
  List<_StateVector> update(_Time time) {
    final dt = time.tt - _curr.time.tt;
    if (dt == 0.0) {
      // Special case: the time has not changed, so skip the usual physics calculations.
      // This allows another way for the caller to query the current body states.
      // It is also necessary to avoid dividing by `dt` if `dt` is zero.
      // To prepare for a possible swap operation, duplicate the current state into the previous state.
      _duplicate();
    } else {
      // Exchange the current state with the previous state. Then calculate the new current state.
      swap();

      // Update the current time.
      _curr.time = time;

      // Now that the time is set, it is safe to update the Solar System.
      _calcSolarSystem();

      // Estimate the positions of the small bodies as if their existing
      // accelerations apply across the whole time interval.
      for (var i = 0; i < _prev.bodies.length; i++) {
        final p = _prev.bodies[i];
        _curr.bodies[i].r = _updatePosition(dt, p.r, p.v, p.a);
      }

      // Calculate the acceleration experienced by the small bodies
      // at their respective approximate next locations.
      _calcBodyAccelerations();

      for (var i = 0; i < _prev.bodies.length; i++) {
        final p = _prev.bodies[i];
        final c = _curr.bodies[i];

        // Calculate the average of the acceleration vectors
        // experienced by the previous body positions and
        // their estimated next positions.
        // These become estimates of the mean effective accelerations over the whole interval.
        final acc = p.a.mean(c.a);

        // Refine the estimates of position and velocity at the next time step,
        // using the mean acceleration as a better approximation of the
        // continuously changing acceleration acting on each body.
        c.tt = time.tt;
        c.r = _updatePosition(dt, p.r, p.v, acc);
        c.v = _updateVelocity(dt, p.v, acc);
      }

      // Re-calculate accelerations experienced by each body.
      // These will be needed for the next simulation step (if any).
      // Also, they will be potentially useful if some day we add
      // a function to query the acceleration vectors for the bodies.
      _calcBodyAccelerations();
    }

    // Translate our internal calculations of body positions
    // and velocities into state vectors that the caller can understand.
    // We have to convert the internal type BodyGravCalc to the public
    // type StateVector.
    final bodyStateArray = _curr.bodies.map((it) => _exportGravCalc(it, time)).toList();

    if (originBody != _Body.SSB) {
      // Now we have to convert the coordinate system to the caller's chosen origin body.
      // Determine the barycentric state of the origin body.
      final ostate = _internalBodyState(originBody);

      // Subtract vectors to convert barycentric states to origin-centric states.
      for (var i = 0; i < bodyStateArray.length; i++) {
        bodyStateArray[i] = _StateVector(
          bodyStateArray[i].x  - ostate.r.x,
          bodyStateArray[i].y  - ostate.r.y,
          bodyStateArray[i].z  - ostate.r.z,
          bodyStateArray[i].vx - ostate.v.x,
          bodyStateArray[i].vy - ostate.v.y,
          bodyStateArray[i].vz - ostate.v.z,
          time
        );
      }
    }

    return bodyStateArray;
  }

  /**
   * Exchange the current time step with the previous time step.
   *
   * Sometimes it is helpful to "explore" various times near a given
   * simulation time step, while repeatedly returning to the original
   * time step. For example, when backdating a position for light travel
   * time, the caller may wish to repeatedly try different amounts of
   * backdating. When the backdating solver has converged, the caller
   * wants to leave the simulation in its original state.
   *
   * This function allows a single "undo" of a simulation, and does so
   * very efficiently.
   *
   * Usually this function will be called immediately after a matching
   * call to [GravitySimulator.update]. It has the effect of rolling
   * back the most recent update. If called twice in a row, it reverts
   * the swap and thus has no net effect.
   *
   * The constructor initializes the current state and previous
   * state to be identical. Both states represent the `time` parameter that was
   * passed into the constructor. Therefore, `swap` will
   * have no effect from the caller's point of view when passed a simulator
   * that has not yet been updated by a call to [GravitySimulator.update].
   */
  void swap() {
    final s = _curr;
    _curr = _prev;
    _prev = s;
  }


  /**
   * Get the position and velocity of a Solar System body included in the simulation.
   *
   * In order to simulate the movement of small bodies through the Solar System,
   * the simulator needs to calculate the state vectors for the Sun and planets.
   *
   * If an application wants to know the positions of one or more of the planets
   * in addition to the small bodies, this function provides a way to obtain
   * their state vectors. This is provided for the sake of efficiency, to avoid
   * redundant calculations.
   *
   * The state vector is returned relative to the position and velocity
   * of the `originBody` parameter that was passed to this object's constructor.
   *
   * @param body
   * The Sun, Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, or Neptune.
   */
  _StateVector solarSystemBodyState(_Body body) {
    // Subtract the origin's state from the body's barycentric state
    // to get the body in the desired reference frame.
    final bstate = _internalBodyState(body);
    final ostate = _internalBodyState(originBody);
    return _exportState(bstate - ostate, _curr.time);
  }

  _BodyState _internalBodyState(_Body body) {
    // Return the barycentric state of the given solar system body.
    if (body == _Body.Sun || (body.index >= _Body.Mercury.index && body.index <= _Body.Neptune.index)) {
      return _curr.gravitators[body.index];
    } else if (body == _Body.SSB) {
      return _BodyState(_curr.time.tt, _TerseVector.zero(), _TerseVector.zero());
    } else {
      throw _InvalidBodyException(body);
    }
  }

  _GravSimEndpoint _initialEndpoint(_Time time, List<_StateVector> bodyStates) {
    // Create an initial "endpoint" data structure, but without correcting
    // the coordinate system yet for the caller's chosen originBody.
    // That has to wait until after we have called `calcSolarSystem`
    // to know the positions of the planets.
    // We also make placeholders for the Sun and planet body states,
    // which are calculated later by `calcSolarSystem`.

    final gravitators = List<_BodyState>.generate(_Body.Sun.index + 1, (_) =>
      _BodyState(
        time.tt,
        _TerseVector(0.0, 0.0, 0.0),
        _TerseVector(0.0, 0.0, 0.0)
      )
    );

    final bodies = bodyStates.map((it) =>
      _BodyGravCalc(
        time.tt,
        _TerseVector(it.x, it.y, it.z),
        _TerseVector(it.vx, it.vy, it.vz),
        _TerseVector(0.0, 0.0, 0.0)
      )
    ).toList();

    return _GravSimEndpoint(time, gravitators, bodies);
  }

  void _calcSolarSystem() {
    final tt = _curr.time.tt;

    // Initialize the Sun's position/velocity as zero vectors, then adjust from pulls from the planets.
    final _BodyState sun = _curr.gravitators[_Body.Sun.index];
    sun.tt = tt;
    sun.r.setToZero();
    sun.v.setToZero();

    // Calculate the state of each planet, and adjust the SSB state accordingly.
    _curr.gravitators[_Body.Mercury.index] = _adjustBarycenterPosVel(sun, tt, _Body.Mercury, _MERCURY_GM);
    _curr.gravitators[_Body.Venus.index  ] = _adjustBarycenterPosVel(sun, tt, _Body.Venus,   _VENUS_GM);
    _curr.gravitators[_Body.Earth.index  ] = _adjustBarycenterPosVel(sun, tt, _Body.Earth,   _EARTH_GM + _MOON_GM);
    _curr.gravitators[_Body.Mars.index   ] = _adjustBarycenterPosVel(sun, tt, _Body.Mars,    _MARS_GM);
    _curr.gravitators[_Body.Jupiter.index] = _adjustBarycenterPosVel(sun, tt, _Body.Jupiter, _JUPITER_GM);
    _curr.gravitators[_Body.Saturn.index ] = _adjustBarycenterPosVel(sun, tt, _Body.Saturn,  _SATURN_GM);
    _curr.gravitators[_Body.Uranus.index ] = _adjustBarycenterPosVel(sun, tt, _Body.Uranus,  _URANUS_GM);
    _curr.gravitators[_Body.Neptune.index] = _adjustBarycenterPosVel(sun, tt, _Body.Neptune, _NEPTUNE_GM);

    // Convert planet states from heliocentric to barycentric.
    for (var bindex = _Body.Mercury.index; bindex <= _Body.Neptune.index; bindex++) {
      _curr.gravitators[bindex].r.decrement(sun.r);
      _curr.gravitators[bindex].v.decrement(sun.v);
    }

    // Convert heliocentric SSB to barycentric Sun.
    sun.r.negate();
    sun.v.negate();
  }

  void _calcBodyAccelerations() {
    // Calculate the gravitational acceleration experienced by the simulated bodies.
    for (final calc in _curr.bodies) {
      calc.a.setToZero();
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Sun.index    ].r, _SUN_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Mercury.index].r, _MERCURY_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Venus.index  ].r, _VENUS_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Earth.index  ].r, _EARTH_GM + _MOON_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Mars.index   ].r, _MARS_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Jupiter.index].r, _JUPITER_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Saturn.index ].r, _SATURN_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Uranus.index ].r, _URANUS_GM);
      _addAcceleration(calc.a, calc.r, _curr.gravitators[_Body.Neptune.index].r, _NEPTUNE_GM);
    }
  }

  void _addAcceleration(_TerseVector acc, _TerseVector smallPos, _TerseVector majorPos, double gm) {
    final dx = majorPos.x - smallPos.x;
    final dy = majorPos.y - smallPos.y;
    final dz = majorPos.z - smallPos.z;
    final r2 = dx * dx + dy * dy + dz * dz;
    final pull = gm / (r2 * math.sqrt(r2));
    acc.x += dx * pull;
    acc.y += dy * pull;
    acc.z += dz * pull;
  }

  void _duplicate() {
    // Copy the current state into the previous state, so that both become the same moment in time.

    _prev.time = _curr.time;

    for (var i = 0; i < _curr.gravitators.length; i++) {
      _prev.gravitators[i].copyFrom(_curr.gravitators[i]);
    }

    for (var i = 0; i < _curr.bodies.length; i++) {
      _prev.bodies[i].copyFrom(_curr.bodies[i]);
    }
  }
}


class _GravSimEndpoint {
  _Time time;
  List<_BodyState> gravitators;
  List<_BodyGravCalc> bodies;
  _GravSimEndpoint(this.time, this.gravitators, this.bodies);
}

//=======================================================================================
// Generated code goes to the bottom of the source file,
// so that most line numbers are consistent between template code and target code.

//---------------------------------------------------------------------------------------
// Table of coefficients for calculating nutation using the IAU2000b model.

class _IauRow {
  final int nals0;
  final int nals1;
  final int nals2;
  final int nals3;
  final int nals4;
  final double cls0;
  final double cls1;
  final double cls2;
  final double cls3;
  final double cls4;
  final double cls5;
  const _IauRow(this.nals0, this.nals1, this.nals2, this.nals3, this.nals4,
      this.cls0, this.cls1, this.cls2, this.cls3, this.cls4, this.cls5);
}

final List<_IauRow> _iauRow = [
  _IauRow( 0,  0,  0,  0,  1, -172064161.0,    -174666.0,      33386.0,   92052331.0,       9086.0,      15377.0),
  _IauRow( 0,  0,  2, -2,  2,  -13170906.0,      -1675.0,     -13696.0,    5730336.0,      -3015.0,      -4587.0),
  _IauRow( 0,  0,  2,  0,  2,   -2276413.0,       -234.0,       2796.0,     978459.0,       -485.0,       1374.0),
  _IauRow( 0,  0,  0,  0,  2,    2074554.0,        207.0,       -698.0,    -897492.0,        470.0,       -291.0),
  _IauRow( 0,  1,  0,  0,  0,    1475877.0,      -3633.0,      11817.0,      73871.0,       -184.0,      -1924.0)
];

//---------------------------------------------------------------------------------------
// VSOP87 coefficients, for calculating major planet state vectors.
final _VsopSeries _vsopLonMercury0 = _VsopSeries([
  _VsopTerm(4.40250710144, 0.00000000000, 0.00000000000),
  _VsopTerm(0.40989414977, 1.48302034195, 26087.90314157420),
  _VsopTerm(0.05046294200, 4.47785489551, 52175.80628314840),
  _VsopTerm(0.00855346844, 1.16520322459, 78263.70942472259),
  _VsopTerm(0.00165590362, 4.11969163423, 104351.61256629678),
  _VsopTerm(0.00034561897, 0.77930768443, 130439.51570787099),
  _VsopTerm(0.00007583476, 3.71348404924, 156527.41884944518),
]);

final _VsopSeries _vsopLonMercury1 = _VsopSeries([
  _VsopTerm(26087.90313685529, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01131199811, 6.21874197797, 26087.90314157420),
  _VsopTerm(0.00292242298, 3.04449355541, 52175.80628314840),
  _VsopTerm(0.00075775081, 6.08568821653, 78263.70942472259),
  _VsopTerm(0.00019676525, 2.80965111777, 104351.61256629678),
]);

final _VsopFormula _vsopLonMercury = _VsopFormula([
  _vsopLonMercury0,
  _vsopLonMercury1,
]);

final _VsopSeries _vsopLatMercury0 = _VsopSeries([
  _VsopTerm(0.11737528961, 1.98357498767, 26087.90314157420),
  _VsopTerm(0.02388076996, 5.03738959686, 52175.80628314840),
  _VsopTerm(0.01222839532, 3.14159265359, 0.00000000000),
  _VsopTerm(0.00543251810, 1.79644363964, 78263.70942472259),
  _VsopTerm(0.00129778770, 4.83232503958, 104351.61256629678),
  _VsopTerm(0.00031866927, 1.58088495658, 130439.51570787099),
  _VsopTerm(0.00007963301, 4.60972126127, 156527.41884944518),
]);

final _VsopSeries _vsopLatMercury1 = _VsopSeries([
  _VsopTerm(0.00274646065, 3.95008450011, 26087.90314157420),
  _VsopTerm(0.00099737713, 3.14159265359, 0.00000000000),
]);

final _VsopFormula _vsopLatMercury = _VsopFormula([
  _vsopLatMercury0,
  _vsopLatMercury1,
]);

final _VsopSeries _vsopRadMercury0 = _VsopSeries([
  _VsopTerm(0.39528271651, 0.00000000000, 0.00000000000),
  _VsopTerm(0.07834131818, 6.19233722598, 26087.90314157420),
  _VsopTerm(0.00795525558, 2.95989690104, 52175.80628314840),
  _VsopTerm(0.00121281764, 6.01064153797, 78263.70942472259),
  _VsopTerm(0.00021921969, 2.77820093972, 104351.61256629678),
  _VsopTerm(0.00004354065, 5.82894543774, 130439.51570787099),
]);

final _VsopSeries _vsopRadMercury1 = _VsopSeries([
  _VsopTerm(0.00217347740, 4.65617158665, 26087.90314157420),
  _VsopTerm(0.00044141826, 1.42385544001, 52175.80628314840),
]);

final _VsopFormula _vsopRadMercury = _VsopFormula([
  _vsopRadMercury0,
  _vsopRadMercury1,
]);

//============================================================================
// Venus

final _VsopSeries _vsopLonVenus0 = _VsopSeries([
  _VsopTerm(3.17614666774, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01353968419, 5.59313319619, 10213.28554621100),
  _VsopTerm(0.00089891645, 5.30650047764, 20426.57109242200),
  _VsopTerm(0.00005477194, 4.41630661466, 7860.41939243920),
  _VsopTerm(0.00003455741, 2.69964447820, 11790.62908865880),
  _VsopTerm(0.00002372061, 2.99377542079, 3930.20969621960),
  _VsopTerm(0.00001317168, 5.18668228402, 26.29831979980),
  _VsopTerm(0.00001664146, 4.25018630147, 1577.34354244780),
  _VsopTerm(0.00001438387, 4.15745084182, 9683.59458111640),
  _VsopTerm(0.00001200521, 6.15357116043, 30639.85663863300),
]);

final _VsopSeries _vsopLonVenus1 = _VsopSeries([
  _VsopTerm(10213.28554621638, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00095617813, 2.46406511110, 10213.28554621100),
  _VsopTerm(0.00007787201, 0.62478482220, 20426.57109242200),
]);

final _VsopFormula _vsopLonVenus = _VsopFormula([
  _vsopLonVenus0,
  _vsopLonVenus1,
]);

final _VsopSeries _vsopLatVenus0 = _VsopSeries([
  _VsopTerm(0.05923638472, 0.26702775812, 10213.28554621100),
  _VsopTerm(0.00040107978, 1.14737178112, 20426.57109242200),
  _VsopTerm(0.00032814918, 3.14159265359, 0.00000000000),
]);

final _VsopSeries _vsopLatVenus1 = _VsopSeries([
  _VsopTerm(0.00287821243, 1.88964962838, 10213.28554621100),
]);

final _VsopFormula _vsopLatVenus = _VsopFormula([
  _vsopLatVenus0,
  _vsopLatVenus1,
]);

final _VsopSeries _vsopRadVenus0 = _VsopSeries([
  _VsopTerm(0.72334820891, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00489824182, 4.02151831717, 10213.28554621100),
  _VsopTerm(0.00001658058, 4.90206728031, 20426.57109242200),
  _VsopTerm(0.00001378043, 1.12846591367, 11790.62908865880),
  _VsopTerm(0.00001632096, 2.84548795207, 7860.41939243920),
  _VsopTerm(0.00000498395, 2.58682193892, 9683.59458111640),
  _VsopTerm(0.00000221985, 2.01346696541, 19367.18916223280),
  _VsopTerm(0.00000237454, 2.55136053886, 15720.83878487840),
]);

final _VsopSeries _vsopRadVenus1 = _VsopSeries([
  _VsopTerm(0.00034551041, 0.89198706276, 10213.28554621100),
]);

final _VsopFormula _vsopRadVenus = _VsopFormula([
  _vsopRadVenus0,
  _vsopRadVenus1,
]);

//============================================================================
// Earth

final _VsopSeries _vsopLonEarth0 = _VsopSeries([
  _VsopTerm(1.75347045673, 0.00000000000, 0.00000000000),
  _VsopTerm(0.03341656453, 4.66925680415, 6283.07584999140),
  _VsopTerm(0.00034894275, 4.62610242189, 12566.15169998280),
  _VsopTerm(0.00003417572, 2.82886579754, 3.52311834900),
  _VsopTerm(0.00003497056, 2.74411783405, 5753.38488489680),
  _VsopTerm(0.00003135899, 3.62767041756, 77713.77146812050),
  _VsopTerm(0.00002676218, 4.41808345438, 7860.41939243920),
  _VsopTerm(0.00002342691, 6.13516214446, 3930.20969621960),
  _VsopTerm(0.00001273165, 2.03709657878, 529.69096509460),
  _VsopTerm(0.00001324294, 0.74246341673, 11506.76976979360),
  _VsopTerm(0.00000901854, 2.04505446477, 26.29831979980),
  _VsopTerm(0.00001199167, 1.10962946234, 1577.34354244780),
  _VsopTerm(0.00000857223, 3.50849152283, 398.14900340820),
  _VsopTerm(0.00000779786, 1.17882681962, 5223.69391980220),
  _VsopTerm(0.00000990250, 5.23268072088, 5884.92684658320),
  _VsopTerm(0.00000753141, 2.53339052847, 5507.55323866740),
  _VsopTerm(0.00000505267, 4.58292599973, 18849.22754997420),
  _VsopTerm(0.00000492392, 4.20505711826, 775.52261132400),
  _VsopTerm(0.00000356672, 2.91954114478, 0.06731030280),
  _VsopTerm(0.00000284125, 1.89869240932, 796.29800681640),
  _VsopTerm(0.00000242879, 0.34481445893, 5486.77784317500),
  _VsopTerm(0.00000317087, 5.84901948512, 11790.62908865880),
  _VsopTerm(0.00000271112, 0.31486255375, 10977.07880469900),
  _VsopTerm(0.00000206217, 4.80646631478, 2544.31441988340),
  _VsopTerm(0.00000205478, 1.86953770281, 5573.14280143310),
  _VsopTerm(0.00000202318, 2.45767790232, 6069.77675455340),
  _VsopTerm(0.00000126225, 1.08295459501, 20.77539549240),
  _VsopTerm(0.00000155516, 0.83306084617, 213.29909543800),
]);

final _VsopSeries _vsopLonEarth1 = _VsopSeries([
  _VsopTerm(6283.07584999140, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00206058863, 2.67823455808, 6283.07584999140),
  _VsopTerm(0.00004303419, 2.63512233481, 12566.15169998280),
]);

final _VsopSeries _vsopLonEarth2 = _VsopSeries([
  _VsopTerm(0.00008721859, 1.07253635559, 6283.07584999140),
]);

final _VsopFormula _vsopLonEarth = _VsopFormula([
  _vsopLonEarth0,
  _vsopLonEarth1,
  _vsopLonEarth2,
]);

final _VsopSeries _vsopLatEarth0 = _VsopSeries([]);

final _VsopSeries _vsopLatEarth1 = _VsopSeries([
  _VsopTerm(0.00227777722, 3.41376620530, 6283.07584999140),
  _VsopTerm(0.00003805678, 3.37063423795, 12566.15169998280),
]);

final _VsopFormula _vsopLatEarth = _VsopFormula([
  _vsopLatEarth0,
  _vsopLatEarth1,
]);

final _VsopSeries _vsopRadEarth0 = _VsopSeries([
  _VsopTerm(1.00013988784, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01670699632, 3.09846350258, 6283.07584999140),
  _VsopTerm(0.00013956024, 3.05524609456, 12566.15169998280),
  _VsopTerm(0.00003083720, 5.19846674381, 77713.77146812050),
  _VsopTerm(0.00001628463, 1.17387558054, 5753.38488489680),
  _VsopTerm(0.00001575572, 2.84685214877, 7860.41939243920),
  _VsopTerm(0.00000924799, 5.45292236722, 11506.76976979360),
  _VsopTerm(0.00000542439, 4.56409151453, 3930.20969621960),
  _VsopTerm(0.00000472110, 3.66100022149, 5884.92684658320),
  _VsopTerm(0.00000085831, 1.27079125277, 161000.68573767410),
  _VsopTerm(0.00000057056, 2.01374292245, 83996.84731811189),
  _VsopTerm(0.00000055736, 5.24159799170, 71430.69561812909),
  _VsopTerm(0.00000174844, 3.01193636733, 18849.22754997420),
  _VsopTerm(0.00000243181, 4.27349530790, 11790.62908865880),
]);

final _VsopSeries _vsopRadEarth1 = _VsopSeries([
  _VsopTerm(0.00103018607, 1.10748968172, 6283.07584999140),
  _VsopTerm(0.00001721238, 1.06442300386, 12566.15169998280),
]);

final _VsopSeries _vsopRadEarth2 = _VsopSeries([
  _VsopTerm(0.00004359385, 5.78455133808, 6283.07584999140),
]);

final _VsopFormula _vsopRadEarth = _VsopFormula([
  _vsopRadEarth0,
  _vsopRadEarth1,
  _vsopRadEarth2,
]);

//============================================================================
// Mars

final _VsopSeries _vsopLonMars0 = _VsopSeries([
  _VsopTerm(6.20347711581, 0.00000000000, 0.00000000000),
  _VsopTerm(0.18656368093, 5.05037100270, 3340.61242669980),
  _VsopTerm(0.01108216816, 5.40099836344, 6681.22485339960),
  _VsopTerm(0.00091798406, 5.75478744667, 10021.83728009940),
  _VsopTerm(0.00027744987, 5.97049513147, 3.52311834900),
  _VsopTerm(0.00010610235, 2.93958560338, 2281.23049651060),
  _VsopTerm(0.00012315897, 0.84956094002, 2810.92146160520),
  _VsopTerm(0.00008926784, 4.15697846427, 0.01725365220),
  _VsopTerm(0.00008715691, 6.11005153139, 13362.44970679920),
  _VsopTerm(0.00006797556, 0.36462229657, 398.14900340820),
  _VsopTerm(0.00007774872, 3.33968761376, 5621.84292321040),
  _VsopTerm(0.00003575078, 1.66186505710, 2544.31441988340),
  _VsopTerm(0.00004161108, 0.22814971327, 2942.46342329160),
  _VsopTerm(0.00003075252, 0.85696614132, 191.44826611160),
  _VsopTerm(0.00002628117, 0.64806124465, 3337.08930835080),
  _VsopTerm(0.00002937546, 6.07893711402, 0.06731030280),
  _VsopTerm(0.00002389414, 5.03896442664, 796.29800681640),
  _VsopTerm(0.00002579844, 0.02996736156, 3344.13554504880),
  _VsopTerm(0.00001528141, 1.14979301996, 6151.53388830500),
  _VsopTerm(0.00001798806, 0.65634057445, 529.69096509460),
  _VsopTerm(0.00001264357, 3.62275122593, 5092.15195811580),
  _VsopTerm(0.00001286228, 3.06796065034, 2146.16541647520),
  _VsopTerm(0.00001546404, 2.91579701718, 1751.53953141600),
  _VsopTerm(0.00001024902, 3.69334099279, 8962.45534991020),
  _VsopTerm(0.00000891566, 0.18293837498, 16703.06213349900),
  _VsopTerm(0.00000858759, 2.40093811940, 2914.01423582380),
  _VsopTerm(0.00000832715, 2.46418619474, 3340.59517304760),
  _VsopTerm(0.00000832720, 4.49495782139, 3340.62968035200),
  _VsopTerm(0.00000712902, 3.66335473479, 1059.38193018920),
  _VsopTerm(0.00000748723, 3.82248614017, 155.42039943420),
  _VsopTerm(0.00000723861, 0.67497311481, 3738.76143010800),
  _VsopTerm(0.00000635548, 2.92182225127, 8432.76438481560),
  _VsopTerm(0.00000655162, 0.48864064125, 3127.31333126180),
  _VsopTerm(0.00000550474, 3.81001042328, 0.98032106820),
  _VsopTerm(0.00000552750, 4.47479317037, 1748.01641306700),
  _VsopTerm(0.00000425966, 0.55364317304, 6283.07584999140),
  _VsopTerm(0.00000415131, 0.49662285038, 213.29909543800),
  _VsopTerm(0.00000472167, 3.62547124025, 1194.44701022460),
  _VsopTerm(0.00000306551, 0.38052848348, 6684.74797174860),
  _VsopTerm(0.00000312141, 0.99853944405, 6677.70173505060),
  _VsopTerm(0.00000293198, 4.22131299634, 20.77539549240),
  _VsopTerm(0.00000302375, 4.48618007156, 3532.06069281140),
  _VsopTerm(0.00000274027, 0.54222167059, 3340.54511639700),
  _VsopTerm(0.00000281079, 5.88163521788, 1349.86740965880),
  _VsopTerm(0.00000231183, 1.28242156993, 3870.30339179440),
  _VsopTerm(0.00000283602, 5.76885434940, 3149.16416058820),
  _VsopTerm(0.00000236117, 5.75503217933, 3333.49887969900),
  _VsopTerm(0.00000274033, 0.13372524985, 3340.67973700260),
  _VsopTerm(0.00000299395, 2.78323740866, 6254.62666252360),
]);

final _VsopSeries _vsopLonMars1 = _VsopSeries([
  _VsopTerm(3340.61242700512, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01457554523, 3.60433733236, 3340.61242669980),
  _VsopTerm(0.00168414711, 3.92318567804, 6681.22485339960),
  _VsopTerm(0.00020622975, 4.26108844583, 10021.83728009940),
  _VsopTerm(0.00003452392, 4.73210393190, 3.52311834900),
  _VsopTerm(0.00002586332, 4.60670058555, 13362.44970679920),
  _VsopTerm(0.00000841535, 4.45864030426, 2281.23049651060),
]);

final _VsopSeries _vsopLonMars2 = _VsopSeries([
  _VsopTerm(0.00058152577, 2.04961712429, 3340.61242669980),
  _VsopTerm(0.00013459579, 2.45738706163, 6681.22485339960),
]);

final _VsopFormula _vsopLonMars = _VsopFormula([
  _vsopLonMars0,
  _vsopLonMars1,
  _vsopLonMars2,
]);

final _VsopSeries _vsopLatMars0 = _VsopSeries([
  _VsopTerm(0.03197134986, 3.76832042431, 3340.61242669980),
  _VsopTerm(0.00298033234, 4.10616996305, 6681.22485339960),
  _VsopTerm(0.00289104742, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00031365539, 4.44651053090, 10021.83728009940),
  _VsopTerm(0.00003484100, 4.78812549260, 13362.44970679920),
]);

final _VsopSeries _vsopLatMars1 = _VsopSeries([
  _VsopTerm(0.00217310991, 6.04472194776, 3340.61242669980),
  _VsopTerm(0.00020976948, 3.14159265359, 0.00000000000),
  _VsopTerm(0.00012834709, 1.60810667915, 6681.22485339960),
]);

final _VsopFormula _vsopLatMars = _VsopFormula([
  _vsopLatMars0,
  _vsopLatMars1,
]);

final _VsopSeries _vsopRadMars0 = _VsopSeries([
  _VsopTerm(1.53033488271, 0.00000000000, 0.00000000000),
  _VsopTerm(0.14184953160, 3.47971283528, 3340.61242669980),
  _VsopTerm(0.00660776362, 3.81783443019, 6681.22485339960),
  _VsopTerm(0.00046179117, 4.15595316782, 10021.83728009940),
  _VsopTerm(0.00008109733, 5.55958416318, 2810.92146160520),
  _VsopTerm(0.00007485318, 1.77239078402, 5621.84292321040),
  _VsopTerm(0.00005523191, 1.36436303770, 2281.23049651060),
  _VsopTerm(0.00003825160, 4.49407183687, 13362.44970679920),
  _VsopTerm(0.00002306537, 0.09081579001, 2544.31441988340),
  _VsopTerm(0.00001999396, 5.36059617709, 3337.08930835080),
  _VsopTerm(0.00002484394, 4.92545639920, 2942.46342329160),
  _VsopTerm(0.00001960195, 4.74249437639, 3344.13554504880),
  _VsopTerm(0.00001167119, 2.11260868341, 5092.15195811580),
  _VsopTerm(0.00001102816, 5.00908403998, 398.14900340820),
  _VsopTerm(0.00000899066, 4.40791133207, 529.69096509460),
  _VsopTerm(0.00000992252, 5.83861961952, 6151.53388830500),
  _VsopTerm(0.00000807354, 2.10217065501, 1059.38193018920),
  _VsopTerm(0.00000797915, 3.44839203899, 796.29800681640),
  _VsopTerm(0.00000740975, 1.49906336885, 2146.16541647520),
]);

final _VsopSeries _vsopRadMars1 = _VsopSeries([
  _VsopTerm(0.01107433345, 2.03250524857, 3340.61242669980),
  _VsopTerm(0.00103175887, 2.37071847807, 6681.22485339960),
  _VsopTerm(0.00012877200, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00010815880, 2.70888095665, 10021.83728009940),
]);

final _VsopSeries _vsopRadMars2 = _VsopSeries([
  _VsopTerm(0.00044242249, 0.47930604954, 3340.61242669980),
  _VsopTerm(0.00008138042, 0.86998389204, 6681.22485339960),
]);

final _VsopFormula _vsopRadMars = _VsopFormula([
  _vsopRadMars0,
  _vsopRadMars1,
  _vsopRadMars2,
]);

//============================================================================
// Jupiter

final _VsopSeries _vsopLonJupiter0 = _VsopSeries([
  _VsopTerm(0.59954691494, 0.00000000000, 0.00000000000),
  _VsopTerm(0.09695898719, 5.06191793158, 529.69096509460),
  _VsopTerm(0.00573610142, 1.44406205629, 7.11354700080),
  _VsopTerm(0.00306389205, 5.41734730184, 1059.38193018920),
  _VsopTerm(0.00097178296, 4.14264726552, 632.78373931320),
  _VsopTerm(0.00072903078, 3.64042916389, 522.57741809380),
  _VsopTerm(0.00064263975, 3.41145165351, 103.09277421860),
  _VsopTerm(0.00039806064, 2.29376740788, 419.48464387520),
  _VsopTerm(0.00038857767, 1.27231755835, 316.39186965660),
  _VsopTerm(0.00027964629, 1.78454591820, 536.80451209540),
  _VsopTerm(0.00013589730, 5.77481040790, 1589.07289528380),
  _VsopTerm(0.00008246349, 3.58227925840, 206.18554843720),
  _VsopTerm(0.00008768704, 3.63000308199, 949.17560896980),
  _VsopTerm(0.00007368042, 5.08101194270, 735.87651353180),
  _VsopTerm(0.00006263150, 0.02497628807, 213.29909543800),
  _VsopTerm(0.00006114062, 4.51319998626, 1162.47470440780),
  _VsopTerm(0.00004905396, 1.32084470588, 110.20632121940),
  _VsopTerm(0.00005305285, 1.30671216791, 14.22709400160),
  _VsopTerm(0.00005305441, 4.18625634012, 1052.26838318840),
  _VsopTerm(0.00004647248, 4.69958103684, 3.93215326310),
  _VsopTerm(0.00003045023, 4.31676431084, 426.59819087600),
  _VsopTerm(0.00002609999, 1.56667394063, 846.08283475120),
  _VsopTerm(0.00002028191, 1.06376530715, 3.18139373770),
  _VsopTerm(0.00001764763, 2.14148655117, 1066.49547719000),
  _VsopTerm(0.00001722972, 3.88036268267, 1265.56747862640),
  _VsopTerm(0.00001920945, 0.97168196472, 639.89728631400),
  _VsopTerm(0.00001633223, 3.58201833555, 515.46387109300),
  _VsopTerm(0.00001431999, 4.29685556046, 625.67019231240),
  _VsopTerm(0.00000973272, 4.09764549134, 95.97922721780),
]);

final _VsopSeries _vsopLonJupiter1 = _VsopSeries([
  _VsopTerm(529.69096508814, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00489503243, 4.22082939470, 529.69096509460),
  _VsopTerm(0.00228917222, 6.02646855621, 7.11354700080),
  _VsopTerm(0.00030099479, 4.54540782858, 1059.38193018920),
  _VsopTerm(0.00020720920, 5.45943156902, 522.57741809380),
  _VsopTerm(0.00012103653, 0.16994816098, 536.80451209540),
  _VsopTerm(0.00006067987, 4.42422292017, 103.09277421860),
  _VsopTerm(0.00005433968, 3.98480737746, 419.48464387520),
  _VsopTerm(0.00004237744, 5.89008707199, 14.22709400160),
]);

final _VsopSeries _vsopLonJupiter2 = _VsopSeries([
  _VsopTerm(0.00047233601, 4.32148536482, 7.11354700080),
  _VsopTerm(0.00030649436, 2.92977788700, 529.69096509460),
  _VsopTerm(0.00014837605, 3.14159265359, 0.00000000000),
]);

final _VsopFormula _vsopLonJupiter = _VsopFormula([
  _vsopLonJupiter0,
  _vsopLonJupiter1,
  _vsopLonJupiter2,
]);

final _VsopSeries _vsopLatJupiter0 = _VsopSeries([
  _VsopTerm(0.02268615702, 3.55852606721, 529.69096509460),
  _VsopTerm(0.00109971634, 3.90809347197, 1059.38193018920),
  _VsopTerm(0.00110090358, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00008101428, 3.60509572885, 522.57741809380),
  _VsopTerm(0.00006043996, 4.25883108339, 1589.07289528380),
  _VsopTerm(0.00006437782, 0.30627119215, 536.80451209540),
]);

final _VsopSeries _vsopLatJupiter1 = _VsopSeries([
  _VsopTerm(0.00078203446, 1.52377859742, 529.69096509460),
]);

final _VsopFormula _vsopLatJupiter = _VsopFormula([
  _vsopLatJupiter0,
  _vsopLatJupiter1,
]);

final _VsopSeries _vsopRadJupiter0 = _VsopSeries([
  _VsopTerm(5.20887429326, 0.00000000000, 0.00000000000),
  _VsopTerm(0.25209327119, 3.49108639871, 529.69096509460),
  _VsopTerm(0.00610599976, 3.84115365948, 1059.38193018920),
  _VsopTerm(0.00282029458, 2.57419881293, 632.78373931320),
  _VsopTerm(0.00187647346, 2.07590383214, 522.57741809380),
  _VsopTerm(0.00086792905, 0.71001145545, 419.48464387520),
  _VsopTerm(0.00072062974, 0.21465724607, 536.80451209540),
  _VsopTerm(0.00065517248, 5.97995884790, 316.39186965660),
  _VsopTerm(0.00029134542, 1.67759379655, 103.09277421860),
  _VsopTerm(0.00030135335, 2.16132003734, 949.17560896980),
  _VsopTerm(0.00023453271, 3.54023522184, 735.87651353180),
  _VsopTerm(0.00022283743, 4.19362594399, 1589.07289528380),
  _VsopTerm(0.00023947298, 0.27458037480, 7.11354700080),
  _VsopTerm(0.00013032614, 2.96042965363, 1162.47470440780),
  _VsopTerm(0.00009703360, 1.90669633585, 206.18554843720),
  _VsopTerm(0.00012749023, 2.71550286592, 1052.26838318840),
  _VsopTerm(0.00007057931, 2.18184839926, 1265.56747862640),
  _VsopTerm(0.00006137703, 6.26418240033, 846.08283475120),
  _VsopTerm(0.00002616976, 2.00994012876, 1581.95934828300),
]);

final _VsopSeries _vsopRadJupiter1 = _VsopSeries([
  _VsopTerm(0.01271801520, 2.64937512894, 529.69096509460),
  _VsopTerm(0.00061661816, 3.00076460387, 1059.38193018920),
  _VsopTerm(0.00053443713, 3.89717383175, 522.57741809380),
  _VsopTerm(0.00031185171, 4.88276958012, 536.80451209540),
  _VsopTerm(0.00041390269, 0.00000000000, 0.00000000000),
]);

final _VsopFormula _vsopRadJupiter = _VsopFormula([
  _vsopRadJupiter0,
  _vsopRadJupiter1,
]);

//============================================================================
// Saturn

final _VsopSeries _vsopLonSaturn0 = _VsopSeries([
  _VsopTerm(0.87401354025, 0.00000000000, 0.00000000000),
  _VsopTerm(0.11107659762, 3.96205090159, 213.29909543800),
  _VsopTerm(0.01414150957, 4.58581516874, 7.11354700080),
  _VsopTerm(0.00398379389, 0.52112032699, 206.18554843720),
  _VsopTerm(0.00350769243, 3.30329907896, 426.59819087600),
  _VsopTerm(0.00206816305, 0.24658372002, 103.09277421860),
  _VsopTerm(0.00079271300, 3.84007056878, 220.41264243880),
  _VsopTerm(0.00023990355, 4.66976924553, 110.20632121940),
  _VsopTerm(0.00016573588, 0.43719228296, 419.48464387520),
  _VsopTerm(0.00014906995, 5.76903183869, 316.39186965660),
  _VsopTerm(0.00015820290, 0.93809155235, 632.78373931320),
  _VsopTerm(0.00014609559, 1.56518472000, 3.93215326310),
  _VsopTerm(0.00013160301, 4.44891291899, 14.22709400160),
  _VsopTerm(0.00015053543, 2.71669915667, 639.89728631400),
  _VsopTerm(0.00013005299, 5.98119023644, 11.04570026390),
  _VsopTerm(0.00010725067, 3.12939523827, 202.25339517410),
  _VsopTerm(0.00005863206, 0.23656938524, 529.69096509460),
  _VsopTerm(0.00005227757, 4.20783365759, 3.18139373770),
  _VsopTerm(0.00006126317, 1.76328667907, 277.03499374140),
  _VsopTerm(0.00005019687, 3.17787728405, 433.71173787680),
  _VsopTerm(0.00004592550, 0.61977744975, 199.07200143640),
  _VsopTerm(0.00004005867, 2.24479718502, 63.73589830340),
  _VsopTerm(0.00002953796, 0.98280366998, 95.97922721780),
  _VsopTerm(0.00003873670, 3.22283226966, 138.51749687070),
  _VsopTerm(0.00002461186, 2.03163875071, 735.87651353180),
  _VsopTerm(0.00003269484, 0.77492638211, 949.17560896980),
  _VsopTerm(0.00001758145, 3.26580109940, 522.57741809380),
  _VsopTerm(0.00001640172, 5.50504453050, 846.08283475120),
  _VsopTerm(0.00001391327, 4.02333150505, 323.50541665740),
  _VsopTerm(0.00001580648, 4.37265307169, 309.27832265580),
  _VsopTerm(0.00001123498, 2.83726798446, 415.55249061210),
  _VsopTerm(0.00001017275, 3.71700135395, 227.52618943960),
  _VsopTerm(0.00000848642, 3.19150170830, 209.36694217490),
]);

final _VsopSeries _vsopLonSaturn1 = _VsopSeries([
  _VsopTerm(213.29909521690, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01297370862, 1.82834923978, 213.29909543800),
  _VsopTerm(0.00564345393, 2.88499717272, 7.11354700080),
  _VsopTerm(0.00093734369, 1.06311793502, 426.59819087600),
  _VsopTerm(0.00107674962, 2.27769131009, 206.18554843720),
  _VsopTerm(0.00040244455, 2.04108104671, 220.41264243880),
  _VsopTerm(0.00019941774, 1.27954390470, 103.09277421860),
  _VsopTerm(0.00010511678, 2.74880342130, 14.22709400160),
  _VsopTerm(0.00006416106, 0.38238295041, 639.89728631400),
  _VsopTerm(0.00004848994, 2.43037610229, 419.48464387520),
  _VsopTerm(0.00004056892, 2.92133209468, 110.20632121940),
  _VsopTerm(0.00003768635, 3.64965330780, 3.93215326310),
]);

final _VsopSeries _vsopLonSaturn2 = _VsopSeries([
  _VsopTerm(0.00116441330, 1.17988132879, 7.11354700080),
  _VsopTerm(0.00091841837, 0.07325195840, 213.29909543800),
  _VsopTerm(0.00036661728, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00015274496, 4.06493179167, 206.18554843720),
]);

final _VsopFormula _vsopLonSaturn = _VsopFormula([
  _vsopLonSaturn0,
  _vsopLonSaturn1,
  _vsopLonSaturn2,
]);

final _VsopSeries _vsopLatSaturn0 = _VsopSeries([
  _VsopTerm(0.04330678039, 3.60284428399, 213.29909543800),
  _VsopTerm(0.00240348302, 2.85238489373, 426.59819087600),
  _VsopTerm(0.00084745939, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00030863357, 3.48441504555, 220.41264243880),
  _VsopTerm(0.00034116062, 0.57297307557, 206.18554843720),
  _VsopTerm(0.00014734070, 2.11846596715, 639.89728631400),
  _VsopTerm(0.00009916667, 5.79003188904, 419.48464387520),
  _VsopTerm(0.00006993564, 4.73604689720, 7.11354700080),
  _VsopTerm(0.00004807588, 5.43305312061, 316.39186965660),
]);

final _VsopSeries _vsopLatSaturn1 = _VsopSeries([
  _VsopTerm(0.00198927992, 4.93901017903, 213.29909543800),
  _VsopTerm(0.00036947916, 3.14159265359, 0.00000000000),
  _VsopTerm(0.00017966989, 0.51979431110, 426.59819087600),
]);

final _VsopFormula _vsopLatSaturn = _VsopFormula([
  _vsopLatSaturn0,
  _vsopLatSaturn1,
]);

final _VsopSeries _vsopRadSaturn0 = _VsopSeries([
  _VsopTerm(9.55758135486, 0.00000000000, 0.00000000000),
  _VsopTerm(0.52921382865, 2.39226219573, 213.29909543800),
  _VsopTerm(0.01873679867, 5.23549604660, 206.18554843720),
  _VsopTerm(0.01464663929, 1.64763042902, 426.59819087600),
  _VsopTerm(0.00821891141, 5.93520042303, 316.39186965660),
  _VsopTerm(0.00547506923, 5.01532618980, 103.09277421860),
  _VsopTerm(0.00371684650, 2.27114821115, 220.41264243880),
  _VsopTerm(0.00361778765, 3.13904301847, 7.11354700080),
  _VsopTerm(0.00140617506, 5.70406606781, 632.78373931320),
  _VsopTerm(0.00108974848, 3.29313390175, 110.20632121940),
  _VsopTerm(0.00069006962, 5.94099540992, 419.48464387520),
  _VsopTerm(0.00061053367, 0.94037691801, 639.89728631400),
  _VsopTerm(0.00048913294, 1.55733638681, 202.25339517410),
  _VsopTerm(0.00034143772, 0.19519102597, 277.03499374140),
  _VsopTerm(0.00032401773, 5.47084567016, 949.17560896980),
  _VsopTerm(0.00020936596, 0.46349251129, 735.87651353180),
  _VsopTerm(0.00009796004, 5.20477537945, 1265.56747862640),
  _VsopTerm(0.00011993338, 5.98050967385, 846.08283475120),
  _VsopTerm(0.00020839300, 1.52102476129, 433.71173787680),
  _VsopTerm(0.00015298404, 3.05943814940, 529.69096509460),
  _VsopTerm(0.00006465823, 0.17732249942, 1052.26838318840),
  _VsopTerm(0.00011380257, 1.73105427040, 522.57741809380),
  _VsopTerm(0.00003419618, 4.94550542171, 1581.95934828300),
]);

final _VsopSeries _vsopRadSaturn1 = _VsopSeries([
  _VsopTerm(0.06182981340, 0.25843511480, 213.29909543800),
  _VsopTerm(0.00506577242, 0.71114625261, 206.18554843720),
  _VsopTerm(0.00341394029, 5.79635741658, 426.59819087600),
  _VsopTerm(0.00188491195, 0.47215589652, 220.41264243880),
  _VsopTerm(0.00186261486, 3.14159265359, 0.00000000000),
  _VsopTerm(0.00143891146, 1.40744822888, 7.11354700080),
]);

final _VsopSeries _vsopRadSaturn2 = _VsopSeries([
  _VsopTerm(0.00436902572, 4.78671677509, 213.29909543800),
]);

final _VsopFormula _vsopRadSaturn = _VsopFormula([
  _vsopRadSaturn0,
  _vsopRadSaturn1,
  _vsopRadSaturn2,
]);

//============================================================================
// Uranus

final _VsopSeries _vsopLonUranus0 = _VsopSeries([
  _VsopTerm(5.48129294297, 0.00000000000, 0.00000000000),
  _VsopTerm(0.09260408234, 0.89106421507, 74.78159856730),
  _VsopTerm(0.01504247898, 3.62719260920, 1.48447270830),
  _VsopTerm(0.00365981674, 1.89962179044, 73.29712585900),
  _VsopTerm(0.00272328168, 3.35823706307, 149.56319713460),
  _VsopTerm(0.00070328461, 5.39254450063, 63.73589830340),
  _VsopTerm(0.00068892678, 6.09292483287, 76.26607127560),
  _VsopTerm(0.00061998615, 2.26952066061, 2.96894541660),
  _VsopTerm(0.00061950719, 2.85098872691, 11.04570026390),
  _VsopTerm(0.00026468770, 3.14152083966, 71.81265315070),
  _VsopTerm(0.00025710476, 6.11379840493, 454.90936652730),
  _VsopTerm(0.00021078850, 4.36059339067, 148.07872442630),
  _VsopTerm(0.00017818647, 1.74436930289, 36.64856292950),
  _VsopTerm(0.00014613507, 4.73732166022, 3.93215326310),
  _VsopTerm(0.00011162509, 5.82681796350, 224.34479570190),
  _VsopTerm(0.00010997910, 0.48865004018, 138.51749687070),
  _VsopTerm(0.00009527478, 2.95516862826, 35.16409022120),
  _VsopTerm(0.00007545601, 5.23626582400, 109.94568878850),
  _VsopTerm(0.00004220241, 3.23328220918, 70.84944530420),
  _VsopTerm(0.00004051900, 2.27755017300, 151.04766984290),
  _VsopTerm(0.00003354596, 1.06549007380, 4.45341812490),
  _VsopTerm(0.00002926718, 4.62903718891, 9.56122755560),
  _VsopTerm(0.00003490340, 5.48306144511, 146.59425171800),
  _VsopTerm(0.00003144069, 4.75199570434, 77.75054398390),
  _VsopTerm(0.00002922333, 5.35235361027, 85.82729883120),
  _VsopTerm(0.00002272788, 4.36600400036, 70.32818044240),
  _VsopTerm(0.00002051219, 1.51773566586, 0.11187458460),
  _VsopTerm(0.00002148602, 0.60745949945, 38.13303563780),
  _VsopTerm(0.00001991643, 4.92437588682, 277.03499374140),
  _VsopTerm(0.00001376226, 2.04283539351, 65.22037101170),
  _VsopTerm(0.00001666902, 3.62744066769, 380.12776796000),
  _VsopTerm(0.00001284107, 3.11347961505, 202.25339517410),
  _VsopTerm(0.00001150429, 0.93343589092, 3.18139373770),
  _VsopTerm(0.00001533221, 2.58594681212, 52.69019803950),
  _VsopTerm(0.00001281604, 0.54271272721, 222.86032299360),
  _VsopTerm(0.00001372139, 4.19641530878, 111.43016149680),
  _VsopTerm(0.00001221029, 0.19900650030, 108.46121608020),
  _VsopTerm(0.00000946181, 1.19253165736, 127.47179660680),
  _VsopTerm(0.00001150989, 4.17898916639, 33.67961751290),
]);

final _VsopSeries _vsopLonUranus1 = _VsopSeries([
  _VsopTerm(74.78159860910, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00154332863, 5.24158770553, 74.78159856730),
  _VsopTerm(0.00024456474, 1.71260334156, 1.48447270830),
  _VsopTerm(0.00009258442, 0.42829732350, 11.04570026390),
  _VsopTerm(0.00008265977, 1.50218091379, 63.73589830340),
  _VsopTerm(0.00009150160, 1.41213765216, 149.56319713460),
]);

final _VsopFormula _vsopLonUranus = _VsopFormula([
  _vsopLonUranus0,
  _vsopLonUranus1,
]);

final _VsopSeries _vsopLatUranus0 = _VsopSeries([
  _VsopTerm(0.01346277648, 2.61877810547, 74.78159856730),
  _VsopTerm(0.00062341400, 5.08111189648, 149.56319713460),
  _VsopTerm(0.00061601196, 3.14159265359, 0.00000000000),
  _VsopTerm(0.00009963722, 1.61603805646, 76.26607127560),
  _VsopTerm(0.00009926160, 0.57630380333, 73.29712585900),
]);

final _VsopSeries _vsopLatUranus1 = _VsopSeries([
  _VsopTerm(0.00034101978, 0.01321929936, 74.78159856730),
]);

final _VsopFormula _vsopLatUranus = _VsopFormula([
  _vsopLatUranus0,
  _vsopLatUranus1,
]);

final _VsopSeries _vsopRadUranus0 = _VsopSeries([
  _VsopTerm(19.21264847206, 0.00000000000, 0.00000000000),
  _VsopTerm(0.88784984413, 5.60377527014, 74.78159856730),
  _VsopTerm(0.03440836062, 0.32836099706, 73.29712585900),
  _VsopTerm(0.02055653860, 1.78295159330, 149.56319713460),
  _VsopTerm(0.00649322410, 4.52247285911, 76.26607127560),
  _VsopTerm(0.00602247865, 3.86003823674, 63.73589830340),
  _VsopTerm(0.00496404167, 1.40139935333, 454.90936652730),
  _VsopTerm(0.00338525369, 1.58002770318, 138.51749687070),
  _VsopTerm(0.00243509114, 1.57086606044, 71.81265315070),
  _VsopTerm(0.00190522303, 1.99809394714, 1.48447270830),
  _VsopTerm(0.00161858838, 2.79137786799, 148.07872442630),
  _VsopTerm(0.00143706183, 1.38368544947, 11.04570026390),
  _VsopTerm(0.00093192405, 0.17437220467, 36.64856292950),
  _VsopTerm(0.00071424548, 4.24509236074, 224.34479570190),
  _VsopTerm(0.00089806014, 3.66105364565, 109.94568878850),
  _VsopTerm(0.00039009723, 1.66971401684, 70.84944530420),
  _VsopTerm(0.00046677296, 1.39976401694, 35.16409022120),
  _VsopTerm(0.00039025624, 3.36234773834, 277.03499374140),
  _VsopTerm(0.00036755274, 3.88649278513, 146.59425171800),
  _VsopTerm(0.00030348723, 0.70100838798, 151.04766984290),
  _VsopTerm(0.00029156413, 3.18056336700, 77.75054398390),
  _VsopTerm(0.00022637073, 0.72518687029, 529.69096509460),
  _VsopTerm(0.00011959076, 1.75043392140, 984.60033162190),
  _VsopTerm(0.00025620756, 5.25656086672, 380.12776796000),
]);

final _VsopSeries _vsopRadUranus1 = _VsopSeries([
  _VsopTerm(0.01479896629, 3.67205697578, 74.78159856730),
]);

final _VsopFormula _vsopRadUranus = _VsopFormula([
  _vsopRadUranus0,
  _vsopRadUranus1,
]);

//============================================================================
// Neptune

final _VsopSeries _vsopLonNeptune0 = _VsopSeries([
  _VsopTerm(5.31188633046, 0.00000000000, 0.00000000000),
  _VsopTerm(0.01798475530, 2.90101273890, 38.13303563780),
  _VsopTerm(0.01019727652, 0.48580922867, 1.48447270830),
  _VsopTerm(0.00124531845, 4.83008090676, 36.64856292950),
  _VsopTerm(0.00042064466, 5.41054993053, 2.96894541660),
  _VsopTerm(0.00037714584, 6.09221808686, 35.16409022120),
  _VsopTerm(0.00033784738, 1.24488874087, 76.26607127560),
  _VsopTerm(0.00016482741, 0.00007727998, 491.55792945680),
  _VsopTerm(0.00009198584, 4.93747051954, 39.61750834610),
  _VsopTerm(0.00008994250, 0.27462171806, 175.16605980020),
]);

final _VsopSeries _vsopLonNeptune1 = _VsopSeries([
  _VsopTerm(38.13303563957, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00016604172, 4.86323329249, 1.48447270830),
  _VsopTerm(0.00015744045, 2.27887427527, 38.13303563780),
]);

final _VsopFormula _vsopLonNeptune = _VsopFormula([
  _vsopLonNeptune0,
  _vsopLonNeptune1,
]);

final _VsopSeries _vsopLatNeptune0 = _VsopSeries([
  _VsopTerm(0.03088622933, 1.44104372644, 38.13303563780),
  _VsopTerm(0.00027780087, 5.91271884599, 76.26607127560),
  _VsopTerm(0.00027623609, 0.00000000000, 0.00000000000),
  _VsopTerm(0.00015355489, 2.52123799551, 36.64856292950),
  _VsopTerm(0.00015448133, 3.50877079215, 39.61750834610),
]);

final _VsopFormula _vsopLatNeptune = _VsopFormula([
  _vsopLatNeptune0,
]);

final _VsopSeries _vsopRadNeptune0 = _VsopSeries([
  _VsopTerm(30.07013205828, 0.00000000000, 0.00000000000),
  _VsopTerm(0.27062259632, 1.32999459377, 38.13303563780),
  _VsopTerm(0.01691764014, 3.25186135653, 36.64856292950),
  _VsopTerm(0.00807830553, 5.18592878704, 1.48447270830),
  _VsopTerm(0.00537760510, 4.52113935896, 35.16409022120),
  _VsopTerm(0.00495725141, 1.57105641650, 491.55792945680),
  _VsopTerm(0.00274571975, 1.84552258866, 175.16605980020),
  _VsopTerm(0.00012012320, 1.92059384991, 1021.24889455140),
  _VsopTerm(0.00121801746, 5.79754470298, 76.26607127560),
  _VsopTerm(0.00100896068, 0.37702724930, 73.29712585900),
  _VsopTerm(0.00135134092, 3.37220609835, 39.61750834610),
  _VsopTerm(0.00007571796, 1.07149207335, 388.46515523820),
]);

final _VsopFormula _vsopRadNeptune = _VsopFormula([
  _vsopRadNeptune0,
]);

void _addSolarTerms(_MoonContext context) {
  context.addSol(    13.9020,    14.0600,    -0.0010,     0.2607, 0, 0, 0, 4);
  context.addSol(     0.4030,    -4.0100,     0.3940,     0.0023, 0, 0, 0, 3);
  context.addSol(  2369.9120,  2373.3600,     0.6010,    28.2333, 0, 0, 0, 2);
  context.addSol(  -125.1540,  -112.7900,    -0.7250,    -0.9781, 0, 0, 0, 1);
  context.addSol(     1.9790,     6.9800,    -0.4450,     0.0433, 1, 0, 0, 4);
  context.addSol(   191.9530,   192.7200,     0.0290,     3.0861, 1, 0, 0, 2);
  context.addSol(    -8.4660,   -13.5100,     0.4550,    -0.1093, 1, 0, 0, 1);
  context.addSol( 22639.5000, 22609.0700,     0.0790,   186.5398, 1, 0, 0, 0);
  context.addSol(    18.6090,     3.5900,    -0.0940,     0.0118, 1, 0, 0,-1);
  context.addSol( -4586.4650, -4578.1300,    -0.0770,    34.3117, 1, 0, 0,-2);
  context.addSol(     3.2150,     5.4400,     0.1920,    -0.0386, 1, 0, 0,-3);
  context.addSol(   -38.4280,   -38.6400,     0.0010,     0.6008, 1, 0, 0,-4);
  context.addSol(    -0.3930,    -1.4300,    -0.0920,     0.0086, 1, 0, 0,-6);
  context.addSol(    -0.2890,    -1.5900,     0.1230,    -0.0053, 0, 1, 0, 4);
  context.addSol(   -24.4200,   -25.1000,     0.0400,    -0.3000, 0, 1, 0, 2);
  context.addSol(    18.0230,    17.9300,     0.0070,     0.1494, 0, 1, 0, 1);
  context.addSol(  -668.1460,  -126.9800,    -1.3020,    -0.3997, 0, 1, 0, 0);
  context.addSol(     0.5600,     0.3200,    -0.0010,    -0.0037, 0, 1, 0,-1);
  context.addSol(  -165.1450,  -165.0600,     0.0540,     1.9178, 0, 1, 0,-2);
  context.addSol(    -1.8770,    -6.4600,    -0.4160,     0.0339, 0, 1, 0,-4);
  context.addSol(     0.2130,     1.0200,    -0.0740,     0.0054, 2, 0, 0, 4);
  context.addSol(    14.3870,    14.7800,    -0.0170,     0.2833, 2, 0, 0, 2);
  context.addSol(    -0.5860,    -1.2000,     0.0540,    -0.0100, 2, 0, 0, 1);
  context.addSol(   769.0160,   767.9600,     0.1070,    10.1657, 2, 0, 0, 0);
  context.addSol(     1.7500,     2.0100,    -0.0180,     0.0155, 2, 0, 0,-1);
  context.addSol(  -211.6560,  -152.5300,     5.6790,    -0.3039, 2, 0, 0,-2);
  context.addSol(     1.2250,     0.9100,    -0.0300,    -0.0088, 2, 0, 0,-3);
  context.addSol(   -30.7730,   -34.0700,    -0.3080,     0.3722, 2, 0, 0,-4);
  context.addSol(    -0.5700,    -1.4000,    -0.0740,     0.0109, 2, 0, 0,-6);
  context.addSol(    -2.9210,   -11.7500,     0.7870,    -0.0484, 1, 1, 0, 2);
  context.addSol(     1.2670,     1.5200,    -0.0220,     0.0164, 1, 1, 0, 1);
  context.addSol(  -109.6730,  -115.1800,     0.4610,    -0.9490, 1, 1, 0, 0);
  context.addSol(  -205.9620,  -182.3600,     2.0560,     1.4437, 1, 1, 0,-2);
  context.addSol(     0.2330,     0.3600,     0.0120,    -0.0025, 1, 1, 0,-3);
  context.addSol(    -4.3910,    -9.6600,    -0.4710,     0.0673, 1, 1, 0,-4);
  context.addSol(     0.2830,     1.5300,    -0.1110,     0.0060, 1,-1, 0, 4);
  context.addSol(    14.5770,    31.7000,    -1.5400,     0.2302, 1,-1, 0, 2);
  context.addSol(   147.6870,   138.7600,     0.6790,     1.1528, 1,-1, 0, 0);
  context.addSol(    -1.0890,     0.5500,     0.0210,     0.0000, 1,-1, 0,-1);
  context.addSol(    28.4750,    23.5900,    -0.4430,    -0.2257, 1,-1, 0,-2);
  context.addSol(    -0.2760,    -0.3800,    -0.0060,    -0.0036, 1,-1, 0,-3);
  context.addSol(     0.6360,     2.2700,     0.1460,    -0.0102, 1,-1, 0,-4);
  context.addSol(    -0.1890,    -1.6800,     0.1310,    -0.0028, 0, 2, 0, 2);
  context.addSol(    -7.4860,    -0.6600,    -0.0370,    -0.0086, 0, 2, 0, 0);
  context.addSol(    -8.0960,   -16.3500,    -0.7400,     0.0918, 0, 2, 0,-2);
  context.addSol(    -5.7410,    -0.0400,     0.0000,    -0.0009, 0, 0, 2, 2);
  context.addSol(     0.2550,     0.0000,     0.0000,     0.0000, 0, 0, 2, 1);
  context.addSol(  -411.6080,    -0.2000,     0.0000,    -0.0124, 0, 0, 2, 0);
  context.addSol(     0.5840,     0.8400,     0.0000,     0.0071, 0, 0, 2,-1);
  context.addSol(   -55.1730,   -52.1400,     0.0000,    -0.1052, 0, 0, 2,-2);
  context.addSol(     0.2540,     0.2500,     0.0000,    -0.0017, 0, 0, 2,-3);
  context.addSol(     0.0250,    -1.6700,     0.0000,     0.0031, 0, 0, 2,-4);
  context.addSol(     1.0600,     2.9600,    -0.1660,     0.0243, 3, 0, 0, 2);
  context.addSol(    36.1240,    50.6400,    -1.3000,     0.6215, 3, 0, 0, 0);
  context.addSol(   -13.1930,   -16.4000,     0.2580,    -0.1187, 3, 0, 0,-2);
  context.addSol(    -1.1870,    -0.7400,     0.0420,     0.0074, 3, 0, 0,-4);
  context.addSol(    -0.2930,    -0.3100,    -0.0020,     0.0046, 3, 0, 0,-6);
  context.addSol(    -0.2900,    -1.4500,     0.1160,    -0.0051, 2, 1, 0, 2);
  context.addSol(    -7.6490,   -10.5600,     0.2590,    -0.1038, 2, 1, 0, 0);
  context.addSol(    -8.6270,    -7.5900,     0.0780,    -0.0192, 2, 1, 0,-2);
  context.addSol(    -2.7400,    -2.5400,     0.0220,     0.0324, 2, 1, 0,-4);
  context.addSol(     1.1810,     3.3200,    -0.2120,     0.0213, 2,-1, 0, 2);
  context.addSol(     9.7030,    11.6700,    -0.1510,     0.1268, 2,-1, 0, 0);
  context.addSol(    -0.3520,    -0.3700,     0.0010,    -0.0028, 2,-1, 0,-1);
  context.addSol(    -2.4940,    -1.1700,    -0.0030,    -0.0017, 2,-1, 0,-2);
  context.addSol(     0.3600,     0.2000,    -0.0120,    -0.0043, 2,-1, 0,-4);
  context.addSol(    -1.1670,    -1.2500,     0.0080,    -0.0106, 1, 2, 0, 0);
  context.addSol(    -7.4120,    -6.1200,     0.1170,     0.0484, 1, 2, 0,-2);
  context.addSol(    -0.3110,    -0.6500,    -0.0320,     0.0044, 1, 2, 0,-4);
  context.addSol(     0.7570,     1.8200,    -0.1050,     0.0112, 1,-2, 0, 2);
  context.addSol(     2.5800,     2.3200,     0.0270,     0.0196, 1,-2, 0, 0);
  context.addSol(     2.5330,     2.4000,    -0.0140,    -0.0212, 1,-2, 0,-2);
  context.addSol(    -0.3440,    -0.5700,    -0.0250,     0.0036, 0, 3, 0,-2);
  context.addSol(    -0.9920,    -0.0200,     0.0000,     0.0000, 1, 0, 2, 2);
  context.addSol(   -45.0990,    -0.0200,     0.0000,    -0.0010, 1, 0, 2, 0);
  context.addSol(    -0.1790,    -9.5200,     0.0000,    -0.0833, 1, 0, 2,-2);
  context.addSol(    -0.3010,    -0.3300,     0.0000,     0.0014, 1, 0, 2,-4);
  context.addSol(    -6.3820,    -3.3700,     0.0000,    -0.0481, 1, 0,-2, 2);
  context.addSol(    39.5280,    85.1300,     0.0000,    -0.7136, 1, 0,-2, 0);
  context.addSol(     9.3660,     0.7100,     0.0000,    -0.0112, 1, 0,-2,-2);
  context.addSol(     0.2020,     0.0200,     0.0000,     0.0000, 1, 0,-2,-4);
  context.addSol(     0.4150,     0.1000,     0.0000,     0.0013, 0, 1, 2, 0);
  context.addSol(    -2.1520,    -2.2600,     0.0000,    -0.0066, 0, 1, 2,-2);
  context.addSol(    -1.4400,    -1.3000,     0.0000,     0.0014, 0, 1,-2, 2);
  context.addSol(     0.3840,    -0.0400,     0.0000,     0.0000, 0, 1,-2,-2);
  context.addSol(     1.9380,     3.6000,    -0.1450,     0.0401, 4, 0, 0, 0);
  context.addSol(    -0.9520,    -1.5800,     0.0520,    -0.0130, 4, 0, 0,-2);
  context.addSol(    -0.5510,    -0.9400,     0.0320,    -0.0097, 3, 1, 0, 0);
  context.addSol(    -0.4820,    -0.5700,     0.0050,    -0.0045, 3, 1, 0,-2);
  context.addSol(     0.6810,     0.9600,    -0.0260,     0.0115, 3,-1, 0, 0);
  context.addSol(    -0.2970,    -0.2700,     0.0020,    -0.0009, 2, 2, 0,-2);
  context.addSol(     0.2540,     0.2100,    -0.0030,     0.0000, 2,-2, 0,-2);
  context.addSol(    -0.2500,    -0.2200,     0.0040,     0.0014, 1, 3, 0,-2);
  context.addSol(    -3.9960,     0.0000,     0.0000,     0.0004, 2, 0, 2, 0);
  context.addSol(     0.5570,    -0.7500,     0.0000,    -0.0090, 2, 0, 2,-2);
  context.addSol(    -0.4590,    -0.3800,     0.0000,    -0.0053, 2, 0,-2, 2);
  context.addSol(    -1.2980,     0.7400,     0.0000,     0.0004, 2, 0,-2, 0);
  context.addSol(     0.5380,     1.1400,     0.0000,    -0.0141, 2, 0,-2,-2);
  context.addSol(     0.2630,     0.0200,     0.0000,     0.0000, 1, 1, 2, 0);
  context.addSol(     0.4260,     0.0700,     0.0000,    -0.0006, 1, 1,-2,-2);
  context.addSol(    -0.3040,     0.0300,     0.0000,     0.0003, 1,-1, 2, 0);
  context.addSol(    -0.3720,    -0.1900,     0.0000,    -0.0027, 1,-1,-2, 2);
  context.addSol(     0.4180,     0.0000,     0.0000,     0.0000, 0, 0, 4, 0);
  context.addSol(    -0.3300,    -0.0400,     0.0000,     0.0000, 3, 0, 2, 0);
}

//---------------------------------------------------------------------------------------
// Pluto state table

const int _PLUTO_NUM_STATES = 51;
const double _PLUTO_TIME_STEP = 29200;
const int _PLUTO_DT = 146;
const int _PLUTO_NSTEPS = 201;

final List<_BodyState> _plutoStateTable = [
  _BodyState(-730000.0, _TerseVector(-26.118207232108, -14.376168177825,   3.384402515299), _TerseVector( 1.6339372163656e-03, -2.7861699588508e-03, -1.3585880229445e-03)),
  _BodyState(-700800.0, _TerseVector( 41.974905202127,  -0.448502952929, -12.770351505989), _TerseVector( 7.3458569351457e-04,  2.2785014891658e-03,  4.8619778602049e-04)),
  _BodyState(-671600.0, _TerseVector( 14.706930780744,  44.269110540027,   9.353698474772), _TerseVector(-2.1000147999800e-03,  2.2295915939915e-04,  7.0143443551414e-04)),
  _BodyState(-642400.0, _TerseVector(-29.441003929957,  -6.430161530570,   6.858481011305), _TerseVector( 8.4495803960544e-04, -3.0783914758711e-03, -1.2106305981192e-03)),
  _BodyState(-613200.0, _TerseVector( 39.444396946234,  -6.557989760571, -13.913760296463), _TerseVector( 1.1480029005873e-03,  2.2400006880665e-03,  3.5168075922288e-04)),
  _BodyState(-584000.0, _TerseVector( 20.230380950700,  43.266966657189,   7.382966091923), _TerseVector(-1.9754081700585e-03,  5.3457141292226e-04,  7.5929169129793e-04)),
  _BodyState(-554800.0, _TerseVector(-30.658325364620,   2.093818874552,   9.880531138071), _TerseVector( 6.1010603013347e-05, -3.1326500935382e-03, -9.9346125151067e-04)),
  _BodyState(-525600.0, _TerseVector( 35.737703251673, -12.587706024764, -14.677847247563), _TerseVector( 1.5802939375649e-03,  2.1347678412429e-03,  1.9074436384343e-04)),
  _BodyState(-496400.0, _TerseVector( 25.466295188546,  41.367478338417,   5.216476873382), _TerseVector(-1.8054401046468e-03,  8.3283083599510e-04,  8.0260156912107e-04)),
  _BodyState(-467200.0, _TerseVector(-29.847174904071,  10.636426313081,  12.297904180106), _TerseVector(-6.3257063052907e-04, -2.9969577578221e-03, -7.4476074151596e-04)),
  _BodyState(-438000.0, _TerseVector( 30.774692107687, -18.236637015304, -14.945535879896), _TerseVector( 2.0113162005465e-03,  1.9353827024189e-03, -2.0937793168297e-06)),
  _BodyState(-408800.0, _TerseVector( 30.243153324028,  38.656267888503,   2.938501750218), _TerseVector(-1.6052508674468e-03,  1.1183495337525e-03,  8.3333973416824e-04)),
  _BodyState(-379600.0, _TerseVector(-27.288984772533,  18.643162147874,  14.023633623329), _TerseVector(-1.1856388898191e-03, -2.7170609282181e-03, -4.9015526126399e-04)),
  _BodyState(-350400.0, _TerseVector( 24.519605196774, -23.245756064727, -14.626862367368), _TerseVector( 2.4322321483154e-03,  1.6062008146048e-03, -2.3369181613312e-04)),
  _BodyState(-321200.0, _TerseVector( 34.505274805875,  35.125338586954,   0.557361475637), _TerseVector(-1.3824391637782e-03,  1.3833397561817e-03,  8.4823598806262e-04)),
  _BodyState(-292000.0, _TerseVector(-23.275363915119,  25.818514298769,  15.055381588598), _TerseVector(-1.6062295460975e-03, -2.3395961498533e-03, -2.4377362639479e-04)),
  _BodyState(-262800.0, _TerseVector( 17.050384798092, -27.180376290126, -13.608963321694), _TerseVector( 2.8175521080578e-03,  1.1358749093955e-03, -4.9548725258825e-04)),
  _BodyState(-233600.0, _TerseVector( 38.093671910285,  30.880588383337,  -1.843688067413), _TerseVector(-1.1317697153459e-03,  1.6128814698472e-03,  8.4177586176055e-04)),
  _BodyState(-204400.0, _TerseVector(-18.197852930878,  31.932869934309,  15.438294826279), _TerseVector(-1.9117272501813e-03, -1.9146495909842e-03, -1.9657304369835e-05)),
  _BodyState(-175200.0, _TerseVector(  8.528924039997, -29.618422200048, -11.805400994258), _TerseVector( 3.1034370787005e-03,  5.1393633292430e-04, -7.7293066202546e-04)),
  _BodyState(-146000.0, _TerseVector( 40.946857258640,  25.904973592021,  -4.256336240499), _TerseVector(-8.3652705194051e-04,  1.8129497136404e-03,  8.1564228273060e-04)),
  _BodyState(-116800.0, _TerseVector(-12.326958895325,  36.881883446292,  15.217158258711), _TerseVector(-2.1166103705038e-03, -1.4814420035990e-03,  1.7401209844705e-04)),
  _BodyState( -87600.0, _TerseVector( -0.633258375909, -30.018759794709,  -9.171932874950), _TerseVector( 3.2016994581737e-03, -2.5279858672148e-04, -1.0411088271861e-03)),
  _BodyState( -58400.0, _TerseVector( 42.936048423883,  20.344685584452,  -6.588027007912), _TerseVector(-5.0525450073192e-04,  1.9910074335507e-03,  7.7440196540269e-04)),
  _BodyState( -29200.0, _TerseVector( -5.975910552974,  40.611809958460,  14.470131723673), _TerseVector(-2.2184202156107e-03, -1.0562361130164e-03,  3.3652250216211e-04)),
  _BodyState(      0.0, _TerseVector( -9.875369580774, -27.978926224737,  -5.753711824704), _TerseVector( 3.0287533248818e-03, -1.1276087003636e-03, -1.2651326732361e-03)),
  _BodyState(  29200.0, _TerseVector( 43.958831986165,  14.214147973292,  -8.808306227163), _TerseVector(-1.4717608981874e-04,  2.1404187242141e-03,  7.1486567806614e-04)),
  _BodyState(  58400.0, _TerseVector(  0.678136763520,  43.094461639362,  13.243238780721), _TerseVector(-2.2358226110718e-03, -6.3233636090933e-04,  4.7664798895648e-04)),
  _BodyState(  87600.0, _TerseVector(-18.282602096834, -23.305039586660,  -1.766620508028), _TerseVector( 2.5567245263557e-03, -1.9902940754171e-03, -1.3943491701082e-03)),
  _BodyState( 116800.0, _TerseVector( 43.873338744526,   7.700705617215, -10.814273666425), _TerseVector( 2.3174803055677e-04,  2.2402163127924e-03,  6.2988756452032e-04)),
  _BodyState( 146000.0, _TerseVector(  7.392949027906,  44.382678951534,  11.629500214854), _TerseVector(-2.1932815453830e-03, -2.1751799585364e-04,  5.9556516201114e-04)),
  _BodyState( 175200.0, _TerseVector(-24.981690229261, -16.204012851426,   2.466457544298), _TerseVector( 1.8193989149580e-03, -2.6765419531201e-03, -1.3848283502247e-03)),
  _BodyState( 204400.0, _TerseVector( 42.530187039511,   0.845935508021, -12.554907527683), _TerseVector( 6.5059779150669e-04,  2.2725657282262e-03,  5.1133743202822e-04)),
  _BodyState( 233600.0, _TerseVector( 13.999526486822,  44.462363044894,   9.669418486465), _TerseVector(-2.1079296569252e-03,  1.7533423831993e-04,  6.9128485798076e-04)),
  _BodyState( 262800.0, _TerseVector(-29.184024803031,  -7.371243995762,   6.493275957928), _TerseVector( 9.3581363109681e-04, -3.0610357109184e-03, -1.2364201089345e-03)),
  _BodyState( 292000.0, _TerseVector( 39.831980671753,  -6.078405766765, -13.909815358656), _TerseVector( 1.1117769689167e-03,  2.2362097830152e-03,  3.6230548231153e-04)),
  _BodyState( 321200.0, _TerseVector( 20.294955108476,  43.417190420251,   7.450091985932), _TerseVector(-1.9742157451535e-03,  5.3102050468554e-04,  7.5938408813008e-04)),
  _BodyState( 350400.0, _TerseVector(-30.669992302160,   2.318743558955,   9.973480913858), _TerseVector( 4.5605107450676e-05, -3.1308219926928e-03, -9.9066533301924e-04)),
  _BodyState( 379600.0, _TerseVector( 35.626122155983, -12.897647509224, -14.777586508444), _TerseVector( 1.6015684949743e-03,  2.1171931182284e-03,  1.8002516202204e-04)),
  _BodyState( 408800.0, _TerseVector( 26.133186148561,  41.232139187599,   5.006401326220), _TerseVector(-1.7857704419579e-03,  8.6046232702817e-04,  8.0614690298954e-04)),
  _BodyState( 438000.0, _TerseVector(-29.576740229230,  11.863535943587,  12.631323039872), _TerseVector(-7.2292830060955e-04, -2.9587820140709e-03, -7.0824296450300e-04)),
  _BodyState( 467200.0, _TerseVector( 29.910805787391, -19.159019294000, -15.013363865194), _TerseVector( 2.0871080437997e-03,  1.8848372554514e-03, -3.8528655083926e-05)),
  _BodyState( 496400.0, _TerseVector( 31.375957451819,  38.050372720763,   2.433138343754), _TerseVector(-1.5546055556611e-03,  1.1699815465629e-03,  8.3565439266001e-04)),
  _BodyState( 525600.0, _TerseVector(-26.360071336928,  20.662505904952,  14.414696258958), _TerseVector(-1.3142373118349e-03, -2.6236647854842e-03, -4.2542017595384e-04)),
  _BodyState( 554800.0, _TerseVector( 22.599441488648, -24.508879898306, -14.484045731468), _TerseVector( 2.5454108304806e-03,  1.4917058755191e-03, -3.0243665086079e-04)),
  _BodyState( 584000.0, _TerseVector( 35.877864013014,  33.894226366071,  -0.224524636277), _TerseVector(-1.2941245730845e-03,  1.4560427668319e-03,  8.4762160640137e-04)),
  _BodyState( 613200.0, _TerseVector(-21.538149762417,  28.204068269761,  15.321973799534), _TerseVector(-1.7312117409010e-03, -2.1939631314577e-03, -1.6316913275180e-04)),
  _BodyState( 642400.0, _TerseVector( 13.971521374415, -28.339941764789, -13.083792871886), _TerseVector( 2.9334630526035e-03,  9.1860931752944e-04, -5.9939422488627e-04)),
  _BodyState( 671600.0, _TerseVector( 39.526942044143,  28.939897360110,  -2.872799527539), _TerseVector(-1.0068481658095e-03,  1.7021132888090e-03,  8.3578230511981e-04)),
  _BodyState( 700800.0, _TerseVector(-15.576200701394,  34.399412961275,  15.466033737854), _TerseVector(-2.0098814612884e-03, -1.7191109825989e-03,  7.0414782780416e-05)),
  _BodyState( 730000.0, _TerseVector(  4.243252837090, -30.118201690825, -10.707441231349), _TerseVector( 3.1725847067411e-03,  1.6098461202270e-04, -9.0672150593868e-04)),
];
//---------------------------------------------------------------------------------------
// Models for Jupiter's four largest moons.

final _RotationMatrix _rotationJupEqj = _RotationMatrix(
    9.99432765338654e-01, -3.36771074697641e-02,  0.00000000000000e+00,
    3.03959428906285e-02,  9.02057912352809e-01,  4.30543388542295e-01,
   -1.44994559663353e-02, -4.30299169409101e-01,  9.02569881273754e-01
);

final List<_JupiterMoon> _jupiterMoonModel = [
  // [0] Io
  _JupiterMoon(
    2.8248942843381399e-07,
    1.4462132960212239e+00,
    3.5515522861824000e+00,
    [  // a
      _VsopTerm( 0.0028210960212903,  0.0000000000000000e+00,  0.0000000000000000e+00)
    ],
    [  // l
      _VsopTerm(-0.0001925258348666,  4.9369589722644998e+00,  1.3584836583050000e-02),
      _VsopTerm(-0.0000970803596076,  4.3188796477322002e+00,  1.3034138432430000e-02),
      _VsopTerm(-0.0000898817416500,  1.9080016428616999e+00,  3.0506486715799999e-03),
      _VsopTerm(-0.0000553101050262,  1.4936156681568999e+00,  1.2938928911549999e-02)
    ],
    [  // z
      _VsopTerm( 0.0041510849668155,  4.0899396355450000e+00, -1.2906864146660001e-02),
      _VsopTerm( 0.0006260521444113,  1.4461888986270000e+00,  3.5515522949801999e+00),
      _VsopTerm( 0.0000352747346169,  2.1256287034577999e+00,  1.2727416566999999e-04)
    ],
    [  // zeta
      _VsopTerm( 0.0003142172466014,  2.7964219722923001e+00, -2.3150960980000000e-03),
      _VsopTerm( 0.0000904169207946,  1.0477061879627001e+00, -5.6920638196000003e-04)
    ]
  ),

  // [1] Europa
  _JupiterMoon(
    2.8248327439289299e-07,
   -3.7352634374713622e-01,
    1.7693227111234699e+00,
    [  // a
      _VsopTerm( 0.0044871037804314,  0.0000000000000000e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0000004324367498,  1.8196456062910000e+00,  1.7822295777568000e+00)
    ],
    [  // l
      _VsopTerm( 0.0008576433172936,  4.3188693178264002e+00,  1.3034138308049999e-02),
      _VsopTerm( 0.0004549582875086,  1.4936531751079001e+00,  1.2938928819619999e-02),
      _VsopTerm( 0.0003248939825174,  1.8196494533458001e+00,  1.7822295777568000e+00),
      _VsopTerm(-0.0003074250079334,  4.9377037005910998e+00,  1.3584832867240000e-02),
      _VsopTerm( 0.0001982386144784,  1.9079869054759999e+00,  3.0510121286900001e-03),
      _VsopTerm( 0.0001834063551804,  2.1402853388529000e+00,  1.4500978933800000e-03),
      _VsopTerm(-0.0001434383188452,  5.6222140366630002e+00,  8.9111478887838003e-01),
      _VsopTerm(-0.0000771939140944,  4.3002724372349999e+00,  2.6733443704265998e+00)
    ],
    [  // z
      _VsopTerm(-0.0093589104136341,  4.0899396509038999e+00, -1.2906864146660001e-02),
      _VsopTerm( 0.0002988994545555,  5.9097265185595003e+00,  1.7693227079461999e+00),
      _VsopTerm( 0.0002139036390350,  2.1256289300016000e+00,  1.2727418406999999e-04),
      _VsopTerm( 0.0001980963564781,  2.7435168292649998e+00,  6.7797343008999997e-04),
      _VsopTerm( 0.0001210388158965,  5.5839943711203004e+00,  3.2056614899999997e-05),
      _VsopTerm( 0.0000837042048393,  1.6094538368039000e+00, -9.0402165808846002e-01),
      _VsopTerm( 0.0000823525166369,  1.4461887708689001e+00,  3.5515522949801999e+00)
    ],
    [  // zeta
      _VsopTerm( 0.0040404917832303,  1.0477063169425000e+00, -5.6920640539999997e-04),
      _VsopTerm( 0.0002200421034564,  3.3368857864364001e+00, -1.2491307306999999e-04),
      _VsopTerm( 0.0001662544744719,  2.4134862374710999e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0000590282470983,  5.9719930968366004e+00, -3.0561602250000000e-05)
    ]
  ),

  // [2] Ganymede
  _JupiterMoon(
    2.8249818418472298e-07,
    2.8740893911433479e-01,
    8.7820792358932798e-01,
    [  // a
      _VsopTerm( 0.0071566594572575,  0.0000000000000000e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0000013930299110,  1.1586745884981000e+00,  2.6733443704265998e+00)
    ],
    [  // l
      _VsopTerm( 0.0002310797886226,  2.1402987195941998e+00,  1.4500978438400001e-03),
      _VsopTerm(-0.0001828635964118,  4.3188672736968003e+00,  1.3034138282630000e-02),
      _VsopTerm( 0.0001512378778204,  4.9373102372298003e+00,  1.3584834812520000e-02),
      _VsopTerm(-0.0001163720969778,  4.3002659861490002e+00,  2.6733443704265998e+00),
      _VsopTerm(-0.0000955478069846,  1.4936612842567001e+00,  1.2938928798570001e-02),
      _VsopTerm( 0.0000815246854464,  5.6222137132535002e+00,  8.9111478887838003e-01),
      _VsopTerm(-0.0000801219679602,  1.2995922951532000e+00,  1.0034433456728999e+00),
      _VsopTerm(-0.0000607017260182,  6.4978769669238001e-01,  5.0172167043264004e-01)
    ],
    [  // z
      _VsopTerm( 0.0014289811307319,  2.1256295942738999e+00,  1.2727413029000001e-04),
      _VsopTerm( 0.0007710931226760,  5.5836330003496002e+00,  3.2064341100000001e-05),
      _VsopTerm( 0.0005925911780766,  4.0899396636447998e+00, -1.2906864146660001e-02),
      _VsopTerm( 0.0002045597496146,  5.2713683670371996e+00, -1.2523544076106000e-01),
      _VsopTerm( 0.0001785118648258,  2.8743156721063001e-01,  8.7820792442520001e-01),
      _VsopTerm( 0.0001131999784893,  1.4462127277818000e+00,  3.5515522949801999e+00),
      _VsopTerm(-0.0000658778169210,  2.2702423990985001e+00, -1.7951364394536999e+00),
      _VsopTerm( 0.0000497058888328,  5.9096792204858000e+00,  1.7693227129285001e+00)
    ],
    [  // zeta
      _VsopTerm( 0.0015932721570848,  3.3368862796665000e+00, -1.2491307058000000e-04),
      _VsopTerm( 0.0008533093128905,  2.4133881688166001e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0003513347911037,  5.9720789850126996e+00, -3.0561017709999999e-05),
      _VsopTerm(-0.0001441929255483,  1.0477061764435001e+00, -5.6920632124000004e-04)
    ]
  ),

  // [3] Callisto
  _JupiterMoon(
    2.8249214488990899e-07,
   -3.6203412913757038e-01,
    3.7648623343382798e-01,
    [  // a
      _VsopTerm( 0.0125879701715314,  0.0000000000000000e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0000035952049470,  6.4965776007116005e-01,  5.0172168165034003e-01),
      _VsopTerm( 0.0000027580210652,  1.8084235781510001e+00,  3.1750660413359002e+00)
    ],
    [  // l
      _VsopTerm( 0.0005586040123824,  2.1404207189814999e+00,  1.4500979323100001e-03),
      _VsopTerm(-0.0003805813868176,  2.7358844897852999e+00,  2.9729650620000000e-05),
      _VsopTerm( 0.0002205152863262,  6.4979652596399995e-01,  5.0172167243580001e-01),
      _VsopTerm( 0.0001877895151158,  1.8084787604004999e+00,  3.1750660413359002e+00),
      _VsopTerm( 0.0000766916975242,  6.2720114319754998e+00,  1.3928364636651001e+00),
      _VsopTerm( 0.0000747056855106,  1.2995916202344000e+00,  1.0034433456728999e+00)
    ],
    [  // z
      _VsopTerm( 0.0073755808467977,  5.5836071576083999e+00,  3.2065099140000001e-05),
      _VsopTerm( 0.0002065924169942,  5.9209831565786004e+00,  3.7648624194703001e-01),
      _VsopTerm( 0.0001589869764021,  2.8744006242622999e-01,  8.7820792442520001e-01),
      _VsopTerm(-0.0001561131605348,  2.1257397865089001e+00,  1.2727441285000001e-04),
      _VsopTerm( 0.0001486043380971,  1.4462134301023000e+00,  3.5515522949801999e+00),
      _VsopTerm( 0.0000635073108731,  5.9096803285953996e+00,  1.7693227129285001e+00),
      _VsopTerm( 0.0000599351698525,  4.1125517584797997e+00, -2.7985797954588998e+00),
      _VsopTerm( 0.0000540660842731,  5.5390350845569003e+00,  2.8683408228299999e-03),
      _VsopTerm(-0.0000489596900866,  4.6218149483337996e+00, -6.2695712529518999e-01)
    ],
    [  // zeta
      _VsopTerm( 0.0038422977898495,  2.4133922085556998e+00,  0.0000000000000000e+00),
      _VsopTerm( 0.0022453891791894,  5.9721736773277003e+00, -3.0561255249999997e-05),
      _VsopTerm(-0.0002604479450559,  3.3368746306408998e+00, -1.2491309972000001e-04),
      _VsopTerm( 0.0000332112143230,  5.5604137742336999e+00,  2.9003768850700000e-03)
    ]
  )
];
//---------------------------------------------------------------------------------------
// Constellation lookup table.

const List<_ConstellationText> _constelNames = [
  _ConstellationText('And', 'Andromeda'           ),    //  0
  _ConstellationText('Ant', 'Antlia'              ),    //  1
  _ConstellationText('Aps', 'Apus'                ),    //  2
  _ConstellationText('Aql', 'Aquila'              ),    //  3
  _ConstellationText('Aqr', 'Aquarius'            ),    //  4
  _ConstellationText('Ara', 'Ara'                 ),    //  5
  _ConstellationText('Ari', 'Aries'               ),    //  6
  _ConstellationText('Aur', 'Auriga'              ),    //  7
  _ConstellationText('Boo', 'Bootes'              ),    //  8
  _ConstellationText('Cae', 'Caelum'              ),    //  9
  _ConstellationText('Cam', 'Camelopardalis'      ),    // 10
  _ConstellationText('Cap', 'Capricornus'         ),    // 11
  _ConstellationText('Car', 'Carina'              ),    // 12
  _ConstellationText('Cas', 'Cassiopeia'          ),    // 13
  _ConstellationText('Cen', 'Centaurus'           ),    // 14
  _ConstellationText('Cep', 'Cepheus'             ),    // 15
  _ConstellationText('Cet', 'Cetus'               ),    // 16
  _ConstellationText('Cha', 'Chamaeleon'          ),    // 17
  _ConstellationText('Cir', 'Circinus'            ),    // 18
  _ConstellationText('CMa', 'Canis Major'         ),    // 19
  _ConstellationText('CMi', 'Canis Minor'         ),    // 20
  _ConstellationText('Cnc', 'Cancer'              ),    // 21
  _ConstellationText('Col', 'Columba'             ),    // 22
  _ConstellationText('Com', 'Coma Berenices'      ),    // 23
  _ConstellationText('CrA', 'Corona Australis'    ),    // 24
  _ConstellationText('CrB', 'Corona Borealis'     ),    // 25
  _ConstellationText('Crt', 'Crater'              ),    // 26
  _ConstellationText('Cru', 'Crux'                ),    // 27
  _ConstellationText('Crv', 'Corvus'              ),    // 28
  _ConstellationText('CVn', 'Canes Venatici'      ),    // 29
  _ConstellationText('Cyg', 'Cygnus'              ),    // 30
  _ConstellationText('Del', 'Delphinus'           ),    // 31
  _ConstellationText('Dor', 'Dorado'              ),    // 32
  _ConstellationText('Dra', 'Draco'               ),    // 33
  _ConstellationText('Equ', 'Equuleus'            ),    // 34
  _ConstellationText('Eri', 'Eridanus'            ),    // 35
  _ConstellationText('For', 'Fornax'              ),    // 36
  _ConstellationText('Gem', 'Gemini'              ),    // 37
  _ConstellationText('Gru', 'Grus'                ),    // 38
  _ConstellationText('Her', 'Hercules'            ),    // 39
  _ConstellationText('Hor', 'Horologium'          ),    // 40
  _ConstellationText('Hya', 'Hydra'               ),    // 41
  _ConstellationText('Hyi', 'Hydrus'              ),    // 42
  _ConstellationText('Ind', 'Indus'               ),    // 43
  _ConstellationText('Lac', 'Lacerta'             ),    // 44
  _ConstellationText('Leo', 'Leo'                 ),    // 45
  _ConstellationText('Lep', 'Lepus'               ),    // 46
  _ConstellationText('Lib', 'Libra'               ),    // 47
  _ConstellationText('LMi', 'Leo Minor'           ),    // 48
  _ConstellationText('Lup', 'Lupus'               ),    // 49
  _ConstellationText('Lyn', 'Lynx'                ),    // 50
  _ConstellationText('Lyr', 'Lyra'                ),    // 51
  _ConstellationText('Men', 'Mensa'               ),    // 52
  _ConstellationText('Mic', 'Microscopium'        ),    // 53
  _ConstellationText('Mon', 'Monoceros'           ),    // 54
  _ConstellationText('Mus', 'Musca'               ),    // 55
  _ConstellationText('Nor', 'Norma'               ),    // 56
  _ConstellationText('Oct', 'Octans'              ),    // 57
  _ConstellationText('Oph', 'Ophiuchus'           ),    // 58
  _ConstellationText('Ori', 'Orion'               ),    // 59
  _ConstellationText('Pav', 'Pavo'                ),    // 60
  _ConstellationText('Peg', 'Pegasus'             ),    // 61
  _ConstellationText('Per', 'Perseus'             ),    // 62
  _ConstellationText('Phe', 'Phoenix'             ),    // 63
  _ConstellationText('Pic', 'Pictor'              ),    // 64
  _ConstellationText('PsA', 'Piscis Austrinus'    ),    // 65
  _ConstellationText('Psc', 'Pisces'              ),    // 66
  _ConstellationText('Pup', 'Puppis'              ),    // 67
  _ConstellationText('Pyx', 'Pyxis'               ),    // 68
  _ConstellationText('Ret', 'Reticulum'           ),    // 69
  _ConstellationText('Scl', 'Sculptor'            ),    // 70
  _ConstellationText('Sco', 'Scorpius'            ),    // 71
  _ConstellationText('Sct', 'Scutum'              ),    // 72
  _ConstellationText('Ser', 'Serpens'             ),    // 73
  _ConstellationText('Sex', 'Sextans'             ),    // 74
  _ConstellationText('Sge', 'Sagitta'             ),    // 75
  _ConstellationText('Sgr', 'Sagittarius'         ),    // 76
  _ConstellationText('Tau', 'Taurus'              ),    // 77
  _ConstellationText('Tel', 'Telescopium'         ),    // 78
  _ConstellationText('TrA', 'Triangulum Australe' ),    // 79
  _ConstellationText('Tri', 'Triangulum'          ),    // 80
  _ConstellationText('Tuc', 'Tucana'              ),    // 81
  _ConstellationText('UMa', 'Ursa Major'          ),    // 82
  _ConstellationText('UMi', 'Ursa Minor'          ),    // 83
  _ConstellationText('Vel', 'Vela'                ),    // 84
  _ConstellationText('Vir', 'Virgo'               ),    // 85
  _ConstellationText('Vol', 'Volans'              ),    // 86
  _ConstellationText('Vul', 'Vulpecula'           ),    // 87
];

const List<_ConstellationBoundary> _constelBounds = [
  _ConstellationBoundary(83,    0.0, 8640.0,  2112.0),    // UMi
  _ConstellationBoundary(83, 2880.0, 5220.0,  2076.0),    // UMi
  _ConstellationBoundary(83, 7560.0, 8280.0,  2068.0),    // UMi
  _ConstellationBoundary(83, 6480.0, 7560.0,  2064.0),    // UMi
  _ConstellationBoundary(15,    0.0, 2880.0,  2040.0),    // Cep
  _ConstellationBoundary(10, 3300.0, 3840.0,  1968.0),    // Cam
  _ConstellationBoundary(15,    0.0, 1800.0,  1920.0),    // Cep
  _ConstellationBoundary(10, 3840.0, 5220.0,  1920.0),    // Cam
  _ConstellationBoundary(83, 6300.0, 6480.0,  1920.0),    // UMi
  _ConstellationBoundary(33, 7260.0, 7560.0,  1920.0),    // Dra
  _ConstellationBoundary(15,    0.0, 1263.0,  1848.0),    // Cep
  _ConstellationBoundary(10, 4140.0, 4890.0,  1848.0),    // Cam
  _ConstellationBoundary(83, 5952.0, 6300.0,  1800.0),    // UMi
  _ConstellationBoundary(15, 7260.0, 7440.0,  1800.0),    // Cep
  _ConstellationBoundary(10, 2868.0, 3300.0,  1764.0),    // Cam
  _ConstellationBoundary(33, 3300.0, 4080.0,  1764.0),    // Dra
  _ConstellationBoundary(83, 4680.0, 5952.0,  1680.0),    // UMi
  _ConstellationBoundary(13, 1116.0, 1230.0,  1632.0),    // Cas
  _ConstellationBoundary(33, 7350.0, 7440.0,  1608.0),    // Dra
  _ConstellationBoundary(33, 4080.0, 4320.0,  1596.0),    // Dra
  _ConstellationBoundary(15,    0.0,  120.0,  1584.0),    // Cep
  _ConstellationBoundary(83, 5040.0, 5640.0,  1584.0),    // UMi
  _ConstellationBoundary(15, 8490.0, 8640.0,  1584.0),    // Cep
  _ConstellationBoundary(33, 4320.0, 4860.0,  1536.0),    // Dra
  _ConstellationBoundary(33, 4860.0, 5190.0,  1512.0),    // Dra
  _ConstellationBoundary(15, 8340.0, 8490.0,  1512.0),    // Cep
  _ConstellationBoundary(10, 2196.0, 2520.0,  1488.0),    // Cam
  _ConstellationBoundary(33, 7200.0, 7350.0,  1476.0),    // Dra
  _ConstellationBoundary(15, 7393.2, 7416.0,  1462.0),    // Cep
  _ConstellationBoundary(10, 2520.0, 2868.0,  1440.0),    // Cam
  _ConstellationBoundary(82, 2868.0, 3030.0,  1440.0),    // UMa
  _ConstellationBoundary(33, 7116.0, 7200.0,  1428.0),    // Dra
  _ConstellationBoundary(15, 7200.0, 7393.2,  1428.0),    // Cep
  _ConstellationBoundary(15, 8232.0, 8340.0,  1418.0),    // Cep
  _ConstellationBoundary(13,    0.0,  876.0,  1404.0),    // Cas
  _ConstellationBoundary(33, 6990.0, 7116.0,  1392.0),    // Dra
  _ConstellationBoundary(13,  612.0,  687.0,  1380.0),    // Cas
  _ConstellationBoundary(13,  876.0, 1116.0,  1368.0),    // Cas
  _ConstellationBoundary(10, 1116.0, 1140.0,  1368.0),    // Cam
  _ConstellationBoundary(15, 8034.0, 8232.0,  1350.0),    // Cep
  _ConstellationBoundary(10, 1800.0, 2196.0,  1344.0),    // Cam
  _ConstellationBoundary(82, 5052.0, 5190.0,  1332.0),    // UMa
  _ConstellationBoundary(33, 5190.0, 6990.0,  1332.0),    // Dra
  _ConstellationBoundary(10, 1140.0, 1200.0,  1320.0),    // Cam
  _ConstellationBoundary(15, 7968.0, 8034.0,  1320.0),    // Cep
  _ConstellationBoundary(15, 7416.0, 7908.0,  1316.0),    // Cep
  _ConstellationBoundary(13,    0.0,  612.0,  1296.0),    // Cas
  _ConstellationBoundary(50, 2196.0, 2340.0,  1296.0),    // Lyn
  _ConstellationBoundary(82, 4350.0, 4860.0,  1272.0),    // UMa
  _ConstellationBoundary(33, 5490.0, 5670.0,  1272.0),    // Dra
  _ConstellationBoundary(15, 7908.0, 7968.0,  1266.0),    // Cep
  _ConstellationBoundary(10, 1200.0, 1800.0,  1260.0),    // Cam
  _ConstellationBoundary(13, 8232.0, 8400.0,  1260.0),    // Cas
  _ConstellationBoundary(33, 5670.0, 6120.0,  1236.0),    // Dra
  _ConstellationBoundary(62,  735.0,  906.0,  1212.0),    // Per
  _ConstellationBoundary(33, 6120.0, 6564.0,  1212.0),    // Dra
  _ConstellationBoundary(13,    0.0,  492.0,  1200.0),    // Cas
  _ConstellationBoundary(62,  492.0,  600.0,  1200.0),    // Per
  _ConstellationBoundary(50, 2340.0, 2448.0,  1200.0),    // Lyn
  _ConstellationBoundary(13, 8400.0, 8640.0,  1200.0),    // Cas
  _ConstellationBoundary(82, 4860.0, 5052.0,  1164.0),    // UMa
  _ConstellationBoundary(13,    0.0,  402.0,  1152.0),    // Cas
  _ConstellationBoundary(13, 8490.0, 8640.0,  1152.0),    // Cas
  _ConstellationBoundary(39, 6543.0, 6564.0,  1140.0),    // Her
  _ConstellationBoundary(33, 6564.0, 6870.0,  1140.0),    // Dra
  _ConstellationBoundary(30, 6870.0, 6900.0,  1140.0),    // Cyg
  _ConstellationBoundary(62,  600.0,  735.0,  1128.0),    // Per
  _ConstellationBoundary(82, 3030.0, 3300.0,  1128.0),    // UMa
  _ConstellationBoundary(13,   60.0,  312.0,  1104.0),    // Cas
  _ConstellationBoundary(82, 4320.0, 4350.0,  1080.0),    // UMa
  _ConstellationBoundary(50, 2448.0, 2652.0,  1068.0),    // Lyn
  _ConstellationBoundary(30, 7887.0, 7908.0,  1056.0),    // Cyg
  _ConstellationBoundary(30, 7875.0, 7887.0,  1050.0),    // Cyg
  _ConstellationBoundary(30, 6900.0, 6984.0,  1044.0),    // Cyg
  _ConstellationBoundary(82, 3300.0, 3660.0,  1008.0),    // UMa
  _ConstellationBoundary(82, 3660.0, 3882.0,   960.0),    // UMa
  _ConstellationBoundary( 8, 5556.0, 5670.0,   960.0),    // Boo
  _ConstellationBoundary(39, 5670.0, 5880.0,   960.0),    // Her
  _ConstellationBoundary(50, 3330.0, 3450.0,   954.0),    // Lyn
  _ConstellationBoundary( 0,    0.0,  906.0,   882.0),    // And
  _ConstellationBoundary(62,  906.0,  924.0,   882.0),    // Per
  _ConstellationBoundary(51, 6969.0, 6984.0,   876.0),    // Lyr
  _ConstellationBoundary(62, 1620.0, 1689.0,   864.0),    // Per
  _ConstellationBoundary(30, 7824.0, 7875.0,   864.0),    // Cyg
  _ConstellationBoundary(44, 7875.0, 7920.0,   864.0),    // Lac
  _ConstellationBoundary( 7, 2352.0, 2652.0,   852.0),    // Aur
  _ConstellationBoundary(50, 2652.0, 2790.0,   852.0),    // Lyn
  _ConstellationBoundary( 0,    0.0,  720.0,   840.0),    // And
  _ConstellationBoundary(44, 7920.0, 8214.0,   840.0),    // Lac
  _ConstellationBoundary(44, 8214.0, 8232.0,   828.0),    // Lac
  _ConstellationBoundary( 0, 8232.0, 8460.0,   828.0),    // And
  _ConstellationBoundary(62,  924.0,  978.0,   816.0),    // Per
  _ConstellationBoundary(82, 3882.0, 3960.0,   816.0),    // UMa
  _ConstellationBoundary(29, 4320.0, 4440.0,   816.0),    // CVn
  _ConstellationBoundary(50, 2790.0, 3330.0,   804.0),    // Lyn
  _ConstellationBoundary(48, 3330.0, 3558.0,   804.0),    // LMi
  _ConstellationBoundary( 0,  258.0,  507.0,   792.0),    // And
  _ConstellationBoundary( 8, 5466.0, 5556.0,   792.0),    // Boo
  _ConstellationBoundary( 0, 8460.0, 8550.0,   770.0),    // And
  _ConstellationBoundary(29, 4440.0, 4770.0,   768.0),    // CVn
  _ConstellationBoundary( 0, 8550.0, 8640.0,   752.0),    // And
  _ConstellationBoundary(29, 5025.0, 5052.0,   738.0),    // CVn
  _ConstellationBoundary(80,  870.0,  978.0,   736.0),    // Tri
  _ConstellationBoundary(62,  978.0, 1620.0,   736.0),    // Per
  _ConstellationBoundary( 7, 1620.0, 1710.0,   720.0),    // Aur
  _ConstellationBoundary(51, 6543.0, 6969.0,   720.0),    // Lyr
  _ConstellationBoundary(82, 3960.0, 4320.0,   696.0),    // UMa
  _ConstellationBoundary(30, 7080.0, 7530.0,   696.0),    // Cyg
  _ConstellationBoundary( 7, 1710.0, 2118.0,   684.0),    // Aur
  _ConstellationBoundary(48, 3558.0, 3780.0,   684.0),    // LMi
  _ConstellationBoundary(29, 4770.0, 5025.0,   684.0),    // CVn
  _ConstellationBoundary( 0,    0.0,   24.0,   672.0),    // And
  _ConstellationBoundary(80,  507.0,  600.0,   672.0),    // Tri
  _ConstellationBoundary( 7, 2118.0, 2352.0,   672.0),    // Aur
  _ConstellationBoundary(37, 2838.0, 2880.0,   672.0),    // Gem
  _ConstellationBoundary(30, 7530.0, 7824.0,   672.0),    // Cyg
  _ConstellationBoundary(30, 6933.0, 7080.0,   660.0),    // Cyg
  _ConstellationBoundary(80,  690.0,  870.0,   654.0),    // Tri
  _ConstellationBoundary(25, 5820.0, 5880.0,   648.0),    // CrB
  _ConstellationBoundary( 8, 5430.0, 5466.0,   624.0),    // Boo
  _ConstellationBoundary(25, 5466.0, 5820.0,   624.0),    // CrB
  _ConstellationBoundary(51, 6612.0, 6792.0,   624.0),    // Lyr
  _ConstellationBoundary(48, 3870.0, 3960.0,   612.0),    // LMi
  _ConstellationBoundary(51, 6792.0, 6933.0,   612.0),    // Lyr
  _ConstellationBoundary(80,  600.0,  690.0,   600.0),    // Tri
  _ConstellationBoundary(66,  258.0,  306.0,   570.0),    // Psc
  _ConstellationBoundary(48, 3780.0, 3870.0,   564.0),    // LMi
  _ConstellationBoundary(87, 7650.0, 7710.0,   564.0),    // Vul
  _ConstellationBoundary(77, 2052.0, 2118.0,   548.0),    // Tau
  _ConstellationBoundary( 0,   24.0,   51.0,   528.0),    // And
  _ConstellationBoundary(73, 5730.0, 5772.0,   528.0),    // Ser
  _ConstellationBoundary(37, 2118.0, 2238.0,   516.0),    // Gem
  _ConstellationBoundary(87, 7140.0, 7290.0,   510.0),    // Vul
  _ConstellationBoundary(87, 6792.0, 6930.0,   506.0),    // Vul
  _ConstellationBoundary( 0,   51.0,  306.0,   504.0),    // And
  _ConstellationBoundary(87, 7290.0, 7404.0,   492.0),    // Vul
  _ConstellationBoundary(37, 2811.0, 2838.0,   480.0),    // Gem
  _ConstellationBoundary(87, 7404.0, 7650.0,   468.0),    // Vul
  _ConstellationBoundary(87, 6930.0, 7140.0,   460.0),    // Vul
  _ConstellationBoundary( 6, 1182.0, 1212.0,   456.0),    // Ari
  _ConstellationBoundary(75, 6792.0, 6840.0,   444.0),    // Sge
  _ConstellationBoundary(59, 2052.0, 2076.0,   432.0),    // Ori
  _ConstellationBoundary(37, 2238.0, 2271.0,   420.0),    // Gem
  _ConstellationBoundary(75, 6840.0, 7140.0,   388.0),    // Sge
  _ConstellationBoundary(77, 1788.0, 1920.0,   384.0),    // Tau
  _ConstellationBoundary(39, 5730.0, 5790.0,   384.0),    // Her
  _ConstellationBoundary(75, 7140.0, 7290.0,   378.0),    // Sge
  _ConstellationBoundary(77, 1662.0, 1788.0,   372.0),    // Tau
  _ConstellationBoundary(77, 1920.0, 2016.0,   372.0),    // Tau
  _ConstellationBoundary(23, 4620.0, 4860.0,   360.0),    // Com
  _ConstellationBoundary(39, 6210.0, 6570.0,   344.0),    // Her
  _ConstellationBoundary(23, 4272.0, 4620.0,   336.0),    // Com
  _ConstellationBoundary(37, 2700.0, 2811.0,   324.0),    // Gem
  _ConstellationBoundary(39, 6030.0, 6210.0,   308.0),    // Her
  _ConstellationBoundary(61,    0.0,   51.0,   300.0),    // Peg
  _ConstellationBoundary(77, 2016.0, 2076.0,   300.0),    // Tau
  _ConstellationBoundary(37, 2520.0, 2700.0,   300.0),    // Gem
  _ConstellationBoundary(61, 7602.0, 7680.0,   300.0),    // Peg
  _ConstellationBoundary(37, 2271.0, 2496.0,   288.0),    // Gem
  _ConstellationBoundary(39, 6570.0, 6792.0,   288.0),    // Her
  _ConstellationBoundary(31, 7515.0, 7578.0,   284.0),    // Del
  _ConstellationBoundary(61, 7578.0, 7602.0,   284.0),    // Peg
  _ConstellationBoundary(45, 4146.0, 4272.0,   264.0),    // Leo
  _ConstellationBoundary(59, 2247.0, 2271.0,   240.0),    // Ori
  _ConstellationBoundary(37, 2496.0, 2520.0,   240.0),    // Gem
  _ConstellationBoundary(21, 2811.0, 2853.0,   240.0),    // Cnc
  _ConstellationBoundary(61, 8580.0, 8640.0,   240.0),    // Peg
  _ConstellationBoundary( 6,  600.0, 1182.0,   238.0),    // Ari
  _ConstellationBoundary(31, 7251.0, 7308.0,   204.0),    // Del
  _ConstellationBoundary( 8, 4860.0, 5430.0,   192.0),    // Boo
  _ConstellationBoundary(61, 8190.0, 8580.0,   180.0),    // Peg
  _ConstellationBoundary(21, 2853.0, 3330.0,   168.0),    // Cnc
  _ConstellationBoundary(45, 3330.0, 3870.0,   168.0),    // Leo
  _ConstellationBoundary(58, 6570.0, 6718.4,   150.0),    // Oph
  _ConstellationBoundary( 3, 6718.4, 6792.0,   150.0),    // Aql
  _ConstellationBoundary(31, 7500.0, 7515.0,   144.0),    // Del
  _ConstellationBoundary(20, 2520.0, 2526.0,   132.0),    // CMi
  _ConstellationBoundary(73, 6570.0, 6633.0,   108.0),    // Ser
  _ConstellationBoundary(39, 5790.0, 6030.0,    96.0),    // Her
  _ConstellationBoundary(58, 6570.0, 6633.0,    72.0),    // Oph
  _ConstellationBoundary(61, 7728.0, 7800.0,    66.0),    // Peg
  _ConstellationBoundary(66,    0.0,  720.0,    48.0),    // Psc
  _ConstellationBoundary(73, 6690.0, 6792.0,    48.0),    // Ser
  _ConstellationBoundary(31, 7308.0, 7500.0,    48.0),    // Del
  _ConstellationBoundary(34, 7500.0, 7680.0,    48.0),    // Equ
  _ConstellationBoundary(61, 7680.0, 7728.0,    48.0),    // Peg
  _ConstellationBoundary(61, 7920.0, 8190.0,    48.0),    // Peg
  _ConstellationBoundary(61, 7800.0, 7920.0,    42.0),    // Peg
  _ConstellationBoundary(20, 2526.0, 2592.0,    36.0),    // CMi
  _ConstellationBoundary(77, 1290.0, 1662.0,     0.0),    // Tau
  _ConstellationBoundary(59, 1662.0, 1680.0,     0.0),    // Ori
  _ConstellationBoundary(20, 2592.0, 2910.0,     0.0),    // CMi
  _ConstellationBoundary(85, 5280.0, 5430.0,     0.0),    // Vir
  _ConstellationBoundary(58, 6420.0, 6570.0,     0.0),    // Oph
  _ConstellationBoundary(16,  954.0, 1182.0,   -42.0),    // Cet
  _ConstellationBoundary(77, 1182.0, 1290.0,   -42.0),    // Tau
  _ConstellationBoundary(73, 5430.0, 5856.0,   -78.0),    // Ser
  _ConstellationBoundary(59, 1680.0, 1830.0,   -96.0),    // Ori
  _ConstellationBoundary(59, 2100.0, 2247.0,   -96.0),    // Ori
  _ConstellationBoundary(73, 6420.0, 6468.0,   -96.0),    // Ser
  _ConstellationBoundary(73, 6570.0, 6690.0,   -96.0),    // Ser
  _ConstellationBoundary( 3, 6690.0, 6792.0,   -96.0),    // Aql
  _ConstellationBoundary(66, 8190.0, 8580.0,   -96.0),    // Psc
  _ConstellationBoundary(45, 3870.0, 4146.0,  -144.0),    // Leo
  _ConstellationBoundary(85, 4146.0, 4260.0,  -144.0),    // Vir
  _ConstellationBoundary(66,    0.0,  120.0,  -168.0),    // Psc
  _ConstellationBoundary(66, 8580.0, 8640.0,  -168.0),    // Psc
  _ConstellationBoundary(85, 5130.0, 5280.0,  -192.0),    // Vir
  _ConstellationBoundary(58, 5730.0, 5856.0,  -192.0),    // Oph
  _ConstellationBoundary( 3, 7200.0, 7392.0,  -216.0),    // Aql
  _ConstellationBoundary( 4, 7680.0, 7872.0,  -216.0),    // Aqr
  _ConstellationBoundary(58, 6180.0, 6468.0,  -240.0),    // Oph
  _ConstellationBoundary(54, 2100.0, 2910.0,  -264.0),    // Mon
  _ConstellationBoundary(35, 1770.0, 1830.0,  -264.0),    // Eri
  _ConstellationBoundary(59, 1830.0, 2100.0,  -264.0),    // Ori
  _ConstellationBoundary(41, 2910.0, 3012.0,  -264.0),    // Hya
  _ConstellationBoundary(74, 3450.0, 3870.0,  -264.0),    // Sex
  _ConstellationBoundary(85, 4260.0, 4620.0,  -264.0),    // Vir
  _ConstellationBoundary(58, 6330.0, 6360.0,  -280.0),    // Oph
  _ConstellationBoundary( 3, 6792.0, 7200.0,  -288.8),    // Aql
  _ConstellationBoundary(35, 1740.0, 1770.0,  -348.0),    // Eri
  _ConstellationBoundary( 4, 7392.0, 7680.0,  -360.0),    // Aqr
  _ConstellationBoundary(73, 6180.0, 6570.0,  -384.0),    // Ser
  _ConstellationBoundary(72, 6570.0, 6792.0,  -384.0),    // Sct
  _ConstellationBoundary(41, 3012.0, 3090.0,  -408.0),    // Hya
  _ConstellationBoundary(58, 5856.0, 5895.0,  -438.0),    // Oph
  _ConstellationBoundary(41, 3090.0, 3270.0,  -456.0),    // Hya
  _ConstellationBoundary(26, 3870.0, 3900.0,  -456.0),    // Crt
  _ConstellationBoundary(71, 5856.0, 5895.0,  -462.0),    // Sco
  _ConstellationBoundary(47, 5640.0, 5730.0,  -480.0),    // Lib
  _ConstellationBoundary(28, 4530.0, 4620.0,  -528.0),    // Crv
  _ConstellationBoundary(85, 4620.0, 5130.0,  -528.0),    // Vir
  _ConstellationBoundary(41, 3270.0, 3510.0,  -576.0),    // Hya
  _ConstellationBoundary(16,  600.0,  954.0,  -585.2),    // Cet
  _ConstellationBoundary(35,  954.0, 1350.0,  -585.2),    // Eri
  _ConstellationBoundary(26, 3900.0, 4260.0,  -588.0),    // Crt
  _ConstellationBoundary(28, 4260.0, 4530.0,  -588.0),    // Crv
  _ConstellationBoundary(47, 5130.0, 5370.0,  -588.0),    // Lib
  _ConstellationBoundary(58, 5856.0, 6030.0,  -590.0),    // Oph
  _ConstellationBoundary(16,    0.0,  600.0,  -612.0),    // Cet
  _ConstellationBoundary(11, 7680.0, 7872.0,  -612.0),    // Cap
  _ConstellationBoundary( 4, 7872.0, 8580.0,  -612.0),    // Aqr
  _ConstellationBoundary(16, 8580.0, 8640.0,  -612.0),    // Cet
  _ConstellationBoundary(41, 3510.0, 3690.0,  -636.0),    // Hya
  _ConstellationBoundary(35, 1692.0, 1740.0,  -654.0),    // Eri
  _ConstellationBoundary(46, 1740.0, 2202.0,  -654.0),    // Lep
  _ConstellationBoundary(11, 7200.0, 7680.0,  -672.0),    // Cap
  _ConstellationBoundary(41, 3690.0, 3810.0,  -700.0),    // Hya
  _ConstellationBoundary(41, 4530.0, 5370.0,  -708.0),    // Hya
  _ConstellationBoundary(47, 5370.0, 5640.0,  -708.0),    // Lib
  _ConstellationBoundary(71, 5640.0, 5760.0,  -708.0),    // Sco
  _ConstellationBoundary(35, 1650.0, 1692.0,  -720.0),    // Eri
  _ConstellationBoundary(58, 6030.0, 6336.0,  -720.0),    // Oph
  _ConstellationBoundary(76, 6336.0, 6420.0,  -720.0),    // Sgr
  _ConstellationBoundary(41, 3810.0, 3900.0,  -748.0),    // Hya
  _ConstellationBoundary(19, 2202.0, 2652.0,  -792.0),    // CMa
  _ConstellationBoundary(41, 4410.0, 4530.0,  -792.0),    // Hya
  _ConstellationBoundary(41, 3900.0, 4410.0,  -840.0),    // Hya
  _ConstellationBoundary(36, 1260.0, 1350.0,  -864.0),    // For
  _ConstellationBoundary(68, 3012.0, 3372.0,  -882.0),    // Pyx
  _ConstellationBoundary(35, 1536.0, 1650.0,  -888.0),    // Eri
  _ConstellationBoundary(76, 6420.0, 6900.0,  -888.0),    // Sgr
  _ConstellationBoundary(65, 7680.0, 8280.0,  -888.0),    // PsA
  _ConstellationBoundary(70, 8280.0, 8400.0,  -888.0),    // Scl
  _ConstellationBoundary(36, 1080.0, 1260.0,  -950.0),    // For
  _ConstellationBoundary( 1, 3372.0, 3960.0,  -954.0),    // Ant
  _ConstellationBoundary(70,    0.0,  600.0,  -960.0),    // Scl
  _ConstellationBoundary(36,  600.0, 1080.0,  -960.0),    // For
  _ConstellationBoundary(35, 1392.0, 1536.0,  -960.0),    // Eri
  _ConstellationBoundary(70, 8400.0, 8640.0,  -960.0),    // Scl
  _ConstellationBoundary(14, 5100.0, 5370.0, -1008.0),    // Cen
  _ConstellationBoundary(49, 5640.0, 5760.0, -1008.0),    // Lup
  _ConstellationBoundary(71, 5760.0, 5911.5, -1008.0),    // Sco
  _ConstellationBoundary( 9, 1740.0, 1800.0, -1032.0),    // Cae
  _ConstellationBoundary(22, 1800.0, 2370.0, -1032.0),    // Col
  _ConstellationBoundary(67, 2880.0, 3012.0, -1032.0),    // Pup
  _ConstellationBoundary(35, 1230.0, 1392.0, -1056.0),    // Eri
  _ConstellationBoundary(71, 5911.5, 6420.0, -1092.0),    // Sco
  _ConstellationBoundary(24, 6420.0, 6900.0, -1092.0),    // CrA
  _ConstellationBoundary(76, 6900.0, 7320.0, -1092.0),    // Sgr
  _ConstellationBoundary(53, 7320.0, 7680.0, -1092.0),    // Mic
  _ConstellationBoundary(35, 1080.0, 1230.0, -1104.0),    // Eri
  _ConstellationBoundary( 9, 1620.0, 1740.0, -1116.0),    // Cae
  _ConstellationBoundary(49, 5520.0, 5640.0, -1152.0),    // Lup
  _ConstellationBoundary(63,    0.0,  840.0, -1156.0),    // Phe
  _ConstellationBoundary(35,  960.0, 1080.0, -1176.0),    // Eri
  _ConstellationBoundary(40, 1470.0, 1536.0, -1176.0),    // Hor
  _ConstellationBoundary( 9, 1536.0, 1620.0, -1176.0),    // Cae
  _ConstellationBoundary(38, 7680.0, 7920.0, -1200.0),    // Gru
  _ConstellationBoundary(67, 2160.0, 2880.0, -1218.0),    // Pup
  _ConstellationBoundary(84, 2880.0, 2940.0, -1218.0),    // Vel
  _ConstellationBoundary(35,  870.0,  960.0, -1224.0),    // Eri
  _ConstellationBoundary(40, 1380.0, 1470.0, -1224.0),    // Hor
  _ConstellationBoundary(63,    0.0,  660.0, -1236.0),    // Phe
  _ConstellationBoundary(12, 2160.0, 2220.0, -1260.0),    // Car
  _ConstellationBoundary(84, 2940.0, 3042.0, -1272.0),    // Vel
  _ConstellationBoundary(40, 1260.0, 1380.0, -1276.0),    // Hor
  _ConstellationBoundary(32, 1380.0, 1440.0, -1276.0),    // Dor
  _ConstellationBoundary(63,    0.0,  570.0, -1284.0),    // Phe
  _ConstellationBoundary(35,  780.0,  870.0, -1296.0),    // Eri
  _ConstellationBoundary(64, 1620.0, 1800.0, -1296.0),    // Pic
  _ConstellationBoundary(49, 5418.0, 5520.0, -1296.0),    // Lup
  _ConstellationBoundary(84, 3042.0, 3180.0, -1308.0),    // Vel
  _ConstellationBoundary(12, 2220.0, 2340.0, -1320.0),    // Car
  _ConstellationBoundary(14, 4260.0, 4620.0, -1320.0),    // Cen
  _ConstellationBoundary(49, 5100.0, 5418.0, -1320.0),    // Lup
  _ConstellationBoundary(56, 5418.0, 5520.0, -1320.0),    // Nor
  _ConstellationBoundary(32, 1440.0, 1560.0, -1356.0),    // Dor
  _ConstellationBoundary(84, 3180.0, 3960.0, -1356.0),    // Vel
  _ConstellationBoundary(14, 3960.0, 4050.0, -1356.0),    // Cen
  _ConstellationBoundary( 5, 6300.0, 6480.0, -1368.0),    // Ara
  _ConstellationBoundary(78, 6480.0, 7320.0, -1368.0),    // Tel
  _ConstellationBoundary(38, 7920.0, 8400.0, -1368.0),    // Gru
  _ConstellationBoundary(40, 1152.0, 1260.0, -1380.0),    // Hor
  _ConstellationBoundary(64, 1800.0, 1980.0, -1380.0),    // Pic
  _ConstellationBoundary(12, 2340.0, 2460.0, -1392.0),    // Car
  _ConstellationBoundary(63,    0.0,  480.0, -1404.0),    // Phe
  _ConstellationBoundary(35,  480.0,  780.0, -1404.0),    // Eri
  _ConstellationBoundary(63, 8400.0, 8640.0, -1404.0),    // Phe
  _ConstellationBoundary(32, 1560.0, 1650.0, -1416.0),    // Dor
  _ConstellationBoundary(56, 5520.0, 5911.5, -1440.0),    // Nor
  _ConstellationBoundary(43, 7320.0, 7680.0, -1440.0),    // Ind
  _ConstellationBoundary(64, 1980.0, 2160.0, -1464.0),    // Pic
  _ConstellationBoundary(18, 5460.0, 5520.0, -1464.0),    // Cir
  _ConstellationBoundary( 5, 5911.5, 5970.0, -1464.0),    // Ara
  _ConstellationBoundary(18, 5370.0, 5460.0, -1526.0),    // Cir
  _ConstellationBoundary( 5, 5970.0, 6030.0, -1526.0),    // Ara
  _ConstellationBoundary(64, 2160.0, 2460.0, -1536.0),    // Pic
  _ConstellationBoundary(12, 2460.0, 3252.0, -1536.0),    // Car
  _ConstellationBoundary(14, 4050.0, 4260.0, -1536.0),    // Cen
  _ConstellationBoundary(27, 4260.0, 4620.0, -1536.0),    // Cru
  _ConstellationBoundary(14, 4620.0, 5232.0, -1536.0),    // Cen
  _ConstellationBoundary(18, 4860.0, 4920.0, -1560.0),    // Cir
  _ConstellationBoundary( 5, 6030.0, 6060.0, -1560.0),    // Ara
  _ConstellationBoundary(40,  780.0, 1152.0, -1620.0),    // Hor
  _ConstellationBoundary(69, 1152.0, 1650.0, -1620.0),    // Ret
  _ConstellationBoundary(18, 5310.0, 5370.0, -1620.0),    // Cir
  _ConstellationBoundary( 5, 6060.0, 6300.0, -1620.0),    // Ara
  _ConstellationBoundary(60, 6300.0, 6480.0, -1620.0),    // Pav
  _ConstellationBoundary(81, 7920.0, 8400.0, -1620.0),    // Tuc
  _ConstellationBoundary(32, 1650.0, 2370.0, -1680.0),    // Dor
  _ConstellationBoundary(18, 4920.0, 5310.0, -1680.0),    // Cir
  _ConstellationBoundary(79, 5310.0, 6120.0, -1680.0),    // TrA
  _ConstellationBoundary(81,    0.0,  480.0, -1800.0),    // Tuc
  _ConstellationBoundary(42, 1260.0, 1650.0, -1800.0),    // Hyi
  _ConstellationBoundary(86, 2370.0, 3252.0, -1800.0),    // Vol
  _ConstellationBoundary(12, 3252.0, 4050.0, -1800.0),    // Car
  _ConstellationBoundary(55, 4050.0, 4920.0, -1800.0),    // Mus
  _ConstellationBoundary(60, 6480.0, 7680.0, -1800.0),    // Pav
  _ConstellationBoundary(43, 7680.0, 8400.0, -1800.0),    // Ind
  _ConstellationBoundary(81, 8400.0, 8640.0, -1800.0),    // Tuc
  _ConstellationBoundary(81,  270.0,  480.0, -1824.0),    // Tuc
  _ConstellationBoundary(42,    0.0, 1260.0, -1980.0),    // Hyi
  _ConstellationBoundary(17, 2760.0, 4920.0, -1980.0),    // Cha
  _ConstellationBoundary( 2, 4920.0, 6480.0, -1980.0),    // Aps
  _ConstellationBoundary(52, 1260.0, 2760.0, -2040.0),    // Men
  _ConstellationBoundary(57,    0.0, 8640.0, -2160.0),    // Oct
];

//---------------------------------------------------------------------------------------

final _VsopModel _vsopModelMercury = _VsopModel(_vsopLonMercury, _vsopLatMercury, _vsopRadMercury);
final _VsopModel _vsopModelVenus = _VsopModel(_vsopLonVenus, _vsopLatVenus, _vsopRadVenus);
final _VsopModel _vsopModelEarth = _VsopModel(_vsopLonEarth, _vsopLatEarth, _vsopRadEarth);
final _VsopModel _vsopModelMars = _VsopModel(_vsopLonMars, _vsopLatMars, _vsopRadMars);
final _VsopModel _vsopModelJupiter = _VsopModel(_vsopLonJupiter, _vsopLatJupiter, _vsopRadJupiter);
final _VsopModel _vsopModelSaturn = _VsopModel(_vsopLonSaturn, _vsopLatSaturn, _vsopRadSaturn);
final _VsopModel _vsopModelUranus = _VsopModel(_vsopLonUranus, _vsopLatUranus, _vsopRadUranus);
final _VsopModel _vsopModelNeptune = _VsopModel(_vsopLonNeptune, _vsopLatNeptune, _vsopRadNeptune);

// Create a rotation matrix for converting J2000 to B1875.
// Need to calculate the B1875 epoch. Based on this:
// https://en.wikipedia.org/wiki/Epoch_(astronomy)#Besselian_years
// B = 1900 + (JD - 2415020.31352) / 365.242198781
// I'm interested in using TT instead of JD, giving:
// B = 1900 + ((TT+2451545) - 2415020.31352) / 365.242198781
// B = 1900 + (TT + 36524.68648) / 365.242198781
// TT = 365.242198781*(B - 1900) - 36524.68648 = -45655.741449525
// But the Time constructor wants UT, not TT.
// Near that date, I get a historical correction of ut-tt = 3.2 seconds.
// That gives UT = -45655.74141261017 for the B1875 epoch,
// or 1874-12-31T18:12:21.950Z.
final _RotationMatrix _constelRot = _rotationEqjEqd(_Time(-45655.74141261017));
