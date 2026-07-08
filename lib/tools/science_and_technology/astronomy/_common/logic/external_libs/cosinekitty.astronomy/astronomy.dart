import 'dart:math' as math;

import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/astronomy_constants.dart';
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy/astronomy.dart';

enum RiseSetType {RISE, CULMINATION, SET}

class RiseSetUTC {
  final List<DateTime> rises;
  final List<DateTime> culminations;
  final List<DateTime> sets;

  RiseSetUTC(this.rises, this.culminations, this.sets);
}

class TwilightsUTC {
  late DateTime? astronomicalMorning;
  late DateTime? nauticalMorning;
  late DateTime? civilMorning;
  late DateTime? civilEvening;
  late DateTime? nauticalEvening;
  late DateTime? astronomicalEvening;

  TwilightsUTC(LatLng coord, DateTime utcDate) {
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    var time = _Time._fromMillisecondsSince1970(utcDate.millisecondsSinceEpoch);

    _Time? searchSunAltitude(_Direction direction, double altitude, [bool searchBackwards = false]) {
      return _searchAltitude(_Body.Sun, observer, direction, time,  366 * (searchBackwards ? -1 : 1), altitude);
    }

    var _astronomicalMorning = searchSunAltitude(_Direction.Rise, -18.0);
    if (_astronomicalMorning != null) {
      astronomicalMorning = _timeToDateTime(_astronomicalMorning);
    }

    var _nauticalMorning = searchSunAltitude(_Direction.Rise, -12.0);
    if (_nauticalMorning != null) {
      nauticalMorning = _timeToDateTime(_nauticalMorning);
    }

    var _civilMorning = searchSunAltitude(_Direction.Rise, -6.0);
    if (_civilMorning != null) {
      civilMorning = _timeToDateTime(_civilMorning);
    }

    var _civilEvening = searchSunAltitude(_Direction.Set, -6.0);
    if (_civilEvening != null) {
      civilEvening = _timeToDateTime(_civilEvening);
    }

    var _nauticalEvening = searchSunAltitude(_Direction.Set, -12.0);
    if (_nauticalEvening != null) {
      nauticalEvening = _timeToDateTime(_nauticalEvening);
    }

    var _astronomicalEvening = searchSunAltitude(_Direction.Set, -18.0);
    if (_astronomicalEvening != null) {
      astronomicalEvening = _timeToDateTime(_astronomicalEvening);
    }
  }
}

class PlanetApsis {
  final DateTime date;
  final double distanceKm;
  final double distanceAu;

  PlanetApsis(this.date, this.distanceKm, this.distanceAu);
}

class SeasonsUTC {
  late DateTime? spring;
  late DateTime? summer;
  late DateTime? fall;
  late DateTime? winter;

  late PlanetApsis perihelion;
  late PlanetApsis aphelion;

  SeasonsUTC(int year) {
    var _s = _seasons(year);
    spring = _timeToDateTime(_s.marchEquinox);
    summer = _timeToDateTime(_s.juneSolstice);
    fall = _timeToDateTime(_s.septemberEquinox);
    winter = _timeToDateTime(_s.decemberSolstice);

    var _perihelion = _searchPlanetApsis(_Body.Earth, _Time.fromCalendar(year, 1, 1, 0, 0, 0));
    var _aphelion = _nextPlanetApsis(_Body.Earth, _perihelion);

    perihelion = PlanetApsis(
      _timeToDateTime(_perihelion.time),
      _perihelion.distanceKm,
      _perihelion.distanceAu
    );
    aphelion = PlanetApsis(
      _timeToDateTime(_aphelion.time),
      _aphelion.distanceKm,
      _aphelion.distanceAu
    );
  }
}

class SunPosition {
  late double distanceCenterToEarthCenterKm;
  late double distanceCenterToObserverKm;
  late double distanceSurfaceToObserverKm;
  late double eclipticLongitudeDeg;
  late double rightAscensionDeg;
  late double declinationDeg;
  late double azimuthDeg;
  late double altitudeDeg;
  late double apparentDiameterDeg;

  SunPosition(LatLng coord, DateTime utcDate) {
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    var time = _Time._fromMillisecondsSince1970(utcDate.millisecondsSinceEpoch);

    final equ2000 = _equator(_Body.Sun, time, observer, _EquatorEpoch.J2000, _Aberration.Corrected);
    final equOfDate = _equator(_Body.Sun, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
    final hor = _horizon(time, observer, equOfDate.ra, equOfDate.dec, _Refraction.Normal);

    rightAscensionDeg = equ2000.ra;
    declinationDeg = equ2000.dec;
    azimuthDeg = hor.azimuth;
    altitudeDeg = hor.altitude;

    distanceCenterToEarthCenterKm = _distanceSunCenterToEarthCenter(time);
    distanceCenterToObserverKm = _distanceSunCenterToEarthSurface(observer, coord, time);
    distanceSurfaceToObserverKm = distanceCenterToObserverKm - _SUN_RADIUS_KM;
    apparentDiameterDeg = _apparentDiameter();
    eclipticLongitudeDeg = _eclipticLng(time);
  }

  double _distanceSunCenterToEarthCenter(_Time time) {
    var sunGeo = _geoVector(_Body.Sun, time, _Aberration.Corrected);
    return sunGeo.length() * _KM_PER_AU;
  }

  double _distanceSunCenterToEarthSurface(_Observer observer, LatLng coord, _Time time) {
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    var topocentricEquator = _equator(_Body.Sun, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
    return topocentricEquator.dist * _KM_PER_AU;
  }

  double _apparentDiameter() {
    var angularRad = 2.0 * math.atan(_SUN_RADIUS_KM / distanceCenterToObserverKm);
    return _radiansToDegrees(angularRad);
  }

  double _eclipticLng(_Time time) {
    var el = _eclipticLongitude(_Body.Earth, time);
    if (el <= 180) {
      return el + 180;
    } else {
      return el - 180;
    }
  }
}

class MoonPosition {
  late double distanceCenterToEarthCenterKm;
  late double distanceCenterToObserverKm;
  late double distanceSurfaceToObserverKm;
  late double eclipticLongitudeDeg;
  late double eclipticLatitudeDeg;
  late double rightAscensionDeg;
  late double declinationDeg;
  late double azimuthDeg;
  late double altitudeDeg;
  late double apparentDiameterDeg;
  late int phaseNumber;
  late MoonPhase phaseName;
  late double age;
  late double illuminationPercent;

  MoonPosition(LatLng coord, DateTime utcDate) {
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    var time = _Time._fromMillisecondsSince1970(utcDate.millisecondsSinceEpoch);

    final equ2000 = _equator(_Body.Moon, time, observer, _EquatorEpoch.J2000, _Aberration.Corrected);
    final equOfDate = _equator(_Body.Moon, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
    final hor = _horizon(time, observer, equOfDate.ra, equOfDate.dec, _Refraction.Normal);

    rightAscensionDeg = equ2000.ra;
    declinationDeg = equ2000.dec;
    azimuthDeg = hor.azimuth;
    altitudeDeg = hor.altitude;

    distanceCenterToEarthCenterKm = _distanceMoonCenterToEarthCenter(time);
    distanceCenterToObserverKm = _distanceMoonCenterToEarthSurface(observer, coord, time);
    distanceSurfaceToObserverKm = _distanceMoonSurfaceToEarthSurface(distanceCenterToObserverKm, time);
    apparentDiameterDeg = _apparentDiameter();

    illuminationPercent = _illumination(_Body.Moon, time).phaseFraction * 100;
    age = _moonPhase(time) / 360.0 * _MEAN_SYNODIC_MONTH;
    phaseName = _moonPhaseName(time);
    phaseNumber = MoonPhase.values.indexOf(phaseName) + 1;

    var moonEcliptic = _eclipticGeoMoon(time);
    eclipticLatitudeDeg = moonEcliptic.lat;
    eclipticLongitudeDeg = moonEcliptic.lon;
  }

  double _distanceMoonCenterToEarthCenter(_Time time) {
    var sunGeo = _geoVector(_Body.Moon, time, _Aberration.Corrected);
    return sunGeo.length() * _KM_PER_AU;
  }

  double _distanceMoonCenterToEarthSurface(_Observer observer, LatLng coord, _Time time) {
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    var topocentricEquator = _equator(_Body.Moon, time, observer, _EquatorEpoch.OfDate, _Aberration.Corrected);
    return topocentricEquator.dist * _KM_PER_AU;
  }

  double _distanceMoonSurfaceToEarthSurface(double observerToMoonCenterKm, _Time time) {
    var libration = _libration(time);
    var latRad = _degreesToRadians(libration.elat);

    var sinLat = math.sin(latRad);
    var cosLat = math.cos(latRad);

    var a = _MOON_EQUATORIAL_RADIUS_KM;
    var b = _MOON_POLAR_RADIUS_KM;

    var numerator = a * b;
    var denominator = math.sqrt((a * a * sinLat * sinLat) + (b * b * cosLat * cosLat));
    var dynamicMoonRadiusKm = numerator / denominator;

    return observerToMoonCenterKm - dynamicMoonRadiusKm;
  }

  double _apparentDiameter() {
    var angularRad = 2.0 * math.atan(_MOON_MEAN_RADIUS_KM / distanceCenterToObserverKm);
    return _radiansToDegrees(angularRad);
  }

  MoonPhase _moonPhaseName(_Time time) {
    var degrees = _moonPhase(time);

    // Tolerance for main phases (full, quarters, new) which are only at one specific degree value.
    // 6.0 deg are approx 1 day.
    var t = 6.0;
    if (degrees >= 360.0 - t || degrees < 0.0 + t) return MoonPhase.NEW_MOON;
    if (degrees >= 90.0 - t && degrees < 90.0 + t) return MoonPhase.FIRST_QUARTER;
    if (degrees >= 180.0 - t && degrees < 180.0 + t) return MoonPhase.FULL_MOON;
    if (degrees >= 270.0 - t && degrees < 270.0 + t) return MoonPhase.LAST_QUARTER;

    if (degrees >= 0.0 + t && degrees < 90.0 - t) return MoonPhase.WAXING_CRESCENT;
    if (degrees >= 90.0 + t && degrees < 180.0 - t) return MoonPhase.WAXING_GIBBOUS;
    if (degrees >= 180.0 + t && degrees < 270.0 - t) return MoonPhase.WANING_GIBBOUS;
    if (degrees >= 270.0 + t && degrees < 360.0 - t) return MoonPhase.WANING_CRESCENT;

    return MoonPhase.FULL_MOON; // dummy, should not happen
  }
}

DateTime _timeToDateTime(_Time time) {
  return DateTime.fromMillisecondsSinceEpoch(time._toMillisecondsSince1970(), isUtc: true);
}

RiseSetUTC _riseSetUTC(LatLng coord, DateTime utcDate, _Body body) {
  var rises = <_Time>[];
  var culminations = <_Time>[];
  var sets = <_Time>[];

  var observer = _Observer(coord.latitude, coord.longitude, 0.0);
  var time = _Time._fromMillisecondsSince1970(utcDate.subtract(Duration(days: 2)).millisecondsSinceEpoch);

  var limitDays = time._addDays(5);
  var limitDaysReached = false;
  var _rise = time;
  while (!limitDaysReached) {
    var rise = _searchRiseSet(body, observer, _Direction.Rise, _rise, 5)!;
    limitDaysReached = rise.compareTo(limitDays) >= 0;
    rises.add(rise);
    _rise = rise._addDays(1 / 60 / 24); // add a minute
  }

  for (_Time rise in rises) {
    sets.add(_searchRiseSet(body, observer, _Direction.Set, rise, 5)!);
    culminations.add(_searchHourAngle(body, observer, 0.0, rise).time);
  }

  return RiseSetUTC(
    rises.map((_Time rise) => _timeToDateTime(rise)).toList(),
    culminations.map((_Time culmination) => _timeToDateTime(culmination)).toList(),
    sets.map((_Time set) => _timeToDateTime(set)).toList()
  );
}

RiseSetUTC moonRiseSetUTC(LatLng coord, DateTime utcDate) {
  return _riseSetUTC(coord, utcDate, _Body.Moon);
}

RiseSetUTC sunRiseSetUTC(LatLng coord, DateTime utcDate) {
  return _riseSetUTC(coord, utcDate, _Body.Sun);
}

class AstroTime {
  late double julianDateUT;
  late double julianDateTT;
  late double julianDateReduced;
  late double julianDateModified;
  late int julianDateTruncated;
  late double julianDateDublin;
  late double julianDateCNES;
  late double julianDateCCSDS;
  late double julianDateJD2000;
  late double julianDateModifiedJD2000;
  late double julianCenturies;
  late double julianMillennia;
  late double deltaT;
  late double universalTime;
  late double terrestrialTime;
  late double greenwichApparentSiderealTime;
  late double localApparentSiderealTime;

  AstroTime(LatLng coord, DateTime utcDate) {
    var time = _Time._fromMillisecondsSince1970(utcDate.millisecondsSinceEpoch);

    julianDateUT = time.ut + 2451545.0;
    julianDateTT = time.tt + 2451545.0;

    // https://en.wikipedia.org/wiki/Julian_day

    julianDateReduced = julianDateUT - 2400000;
    julianDateModified = julianDateUT - 2400000.5;
    julianDateTruncated = (julianDateUT - 2440000.5).floor();
    julianDateDublin = julianDateUT - 2415020;
    julianDateCNES = julianDateUT - 2433282.5;
    julianDateCCSDS = julianDateUT - 2436204.5;
    julianDateJD2000 = julianDateUT - 2451545.5;
    julianDateModifiedJD2000 = julianDateUT - 2451544.5;

    julianCenturies = time._julianCenturies();
    julianMillennia = time._julianMillennia();

    universalTime = time.ut;
    terrestrialTime = time.tt;
    deltaT = (time.tt - time.ut) * 86400.0;

    greenwichApparentSiderealTime = _siderealTime(time);
    var observer = _Observer(coord.latitude, coord.longitude, 0.0);
    localApparentSiderealTime = greenwichApparentSiderealTime + (observer.longitude / 15.0);

    // Normalize LST so it stays strictly within the 0.0 to 24.0 hour bounds
    localApparentSiderealTime %= 24.0;
    if (localApparentSiderealTime < 0.0) {
      localApparentSiderealTime += 24.0;
    }
  }
}