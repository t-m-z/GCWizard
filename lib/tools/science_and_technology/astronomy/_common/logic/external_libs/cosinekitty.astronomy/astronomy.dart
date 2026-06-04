import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy/astronomy.dart';

class RiseSet {
  final DateTime? rise;
  final DateTime? culmination;
  final DateTime? set;

  RiseSet(this.rise, this.culmination, this.set);
}

class Twilights {
  final DateTime? astronomicalMorning;
  final DateTime? nauticalMorning;
  final DateTime? civilMorning;
  final DateTime? civilEvening;
  final DateTime? nauticalEvening;
  final DateTime? astronomicalEvening;

  Twilights(
    this.astronomicalMorning,
    this.nauticalMorning,
    this.civilMorning,
    this.civilEvening,
    this.nauticalEvening,
    this.astronomicalEvening
  );
}

DateTime _withoutTime(DateTime utcDate) {
  return DateTime(utcDate.year, utcDate.month, utcDate.day);
}

DateTime _timeToDateTime(_Time time) {
  return DateTime.fromMillisecondsSinceEpoch(time._toMillisecondsSince1970(), isUtc: true);
}

RiseSet _riseSetUTC(LatLng coord, DateTime utcDate, _Body body) {
  DateTime? rise;
  DateTime? culmination;
  DateTime? set;

  var observer = _Observer(coord.latitude, coord.longitude, 0.0);
  var time = _Time._fromMillisecondsSince1970(_withoutTime(utcDate).millisecondsSinceEpoch);

  var _rise = _searchRiseSet(body, observer, _Direction.Rise, time, 1);
  if (_rise != null) {
    rise = _timeToDateTime(_rise);
  }

  var _culmination = DateTime.fromMillisecondsSinceEpoch(
    _searchHourAngle(body, observer, 0.0, time).time._toMillisecondsSince1970(), isUtc: true
  );
  if (_culmination.day == utcDate.day && _culmination.month == utcDate.month) {
    culmination = _culmination;
  }

  var _set = _searchRiseSet(body, observer, _Direction.Set, time, 1);
  if (_set != null) {
    set = _timeToDateTime(_set);
  }

  return RiseSet(rise, culmination, set);
}

RiseSet moonRiseSetUTC(LatLng coord, DateTime utcDate) {
  return _riseSetUTC(coord, utcDate, _Body.Moon);
}

RiseSet sunRiseSetUTC(LatLng coord, DateTime utcDate) {
  return _riseSetUTC(coord, utcDate, _Body.Sun);
}

Twilights twilights(LatLng coord, DateTime utcDate) {
  DateTime? astronomicalMorning;
  DateTime? nauticalMorning;
  DateTime? civilMorning;
  DateTime? civilEvening;
  DateTime? nauticalEvening;
  DateTime? astronomicalEvening;

  var observer = _Observer(coord.latitude, coord.longitude, 0.0);
  var time = _Time._fromMillisecondsSince1970(_withoutTime(utcDate).millisecondsSinceEpoch);

  _Time? searchSunAltitude(_Direction direction, double altitude) {
    return _searchAltitude(_Body.Sun, observer, direction, time, 1, altitude);
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

  var _astronomicalEvening = _searchAltitude(_Body.Sun, observer, _Direction.Set, time, 1, -18.0);
  if (_astronomicalEvening != null) {
    astronomicalEvening = _timeToDateTime(_astronomicalEvening);
  }

  return Twilights(astronomicalMorning, nauticalMorning, civilMorning, civilEvening, nauticalEvening, astronomicalEvening);
}

void main() {
  var ll = LatLng(52, 13);
  var time = DateTime(2026, 6, 4, 17, 24, 4);
  var moonRise = moonRiseSetUTC(ll, time);
  var sunRise = sunRiseSetUTC(ll, time);
  print(moonRise.rise!.toLocal());
  print(moonRise.culmination?.toLocal());
  print(moonRise.set!.toLocal());
  print('');
  print(sunRise.rise!.toLocal());
  print(sunRise.culmination!.toLocal());
  print(sunRise.set!.toLocal());
  print('');

  var tl = twilights(ll, time);
  print(tl.astronomicalMorning?.toLocal());
  print(tl.nauticalMorning?.toLocal());
  print(tl.civilMorning?.toLocal());
  print(tl.civilEvening?.toLocal());
  print(tl.nauticalEvening?.toLocal());
  print(tl.astronomicalEvening?.toLocal());
}