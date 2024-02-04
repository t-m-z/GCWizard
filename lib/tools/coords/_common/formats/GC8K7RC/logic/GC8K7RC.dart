// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/formats/dec/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

const GC8K7RCKey = 'coords_gc8k7rc';
const _secondsPerDay = 24 * 60 * 60;
const _rEarth = 6378905.94503519;

final GC8K7RCFormatDefinition = CoordinateFormatDefinition(
    CoordinateFormatKey.GC8K7RC, GC8K7RCKey, GC8K7RCKey,
    GC8K7RCCoordinate.parse, GC8K7RCCoordinate(0, 0,));

class GC8K7RCCoordinate extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.GC8K7RC);
  double velocity;
  double distance;

  GC8K7RCCoordinate(this.velocity, this.distance );

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    ells ??= defaultEllipsoid;
    return _GC8K7RCToLatLon(this, ells);
  }

  static GC8K7RCCoordinate fromLatLon(LatLng coord) {
    return _latLonToGC8K7RC(coord);
  }

  static GC8K7RCCoordinate? parse(String input) {
    return _parseGC8K7RC(input);
  }

  @override
  String toString([int? precision]) {
    var numberFormat = NumberFormat('0.##');
    return '${numberFormat.format(velocity)}\n${numberFormat.format(distance)}';
  }
}

LatLng _GC8K7RCToLatLon(GC8K7RCCoordinate GC8K7RC, Ellipsoid ells) {
  var velocity = GC8K7RC.velocity;
  var distance = GC8K7RC.distance;

  double u = velocity * _secondsPerDay;
  double r = u.abs() / 2 / pi;

  double lat = 0;
  if (r / _rEarth >= 1) {
    lat = 0;
  } else {
    lat = acos(r / _rEarth);
  }
  lat = lat * 180 / pi;

  if (u < 0) {
    lat = -lat;
  }
  lat = num.parse(lat.toString()) as double;

  double lon = 0.0;
  if (u != 0) {
    lon = 360 * distance / u.abs();
  } else {
    lon = 0;
  }
  lon = num.parse(lon.toString()) as double;

  return DECCoordinate(lat, lon).toLatLng();
}

GC8K7RCCoordinate _latLonToGC8K7RC(LatLng coord, ) {
  var lat = coord.latitude;
  var lon = coord.longitude;
  double u = cos(lat * pi / 180) * _rEarth * 2 * pi;
  double velocity = u / 24 / 60 / 60;

  double distance = lon * u / 360;
  return GC8K7RCCoordinate(velocity, distance,);
}

GC8K7RCCoordinate? _parseGC8K7RC(String input) {
  RegExp regExp = RegExp(r'^\s*([\-0-9\.]+)(\s*,\s*|\s+)([\-0-9\.]+)\s*$');
  var matches = regExp.allMatches(input);

  String? velocityString = '';
  String? distanceString = '';

  if (matches.isNotEmpty) {
    var match = matches.elementAt(0);
    velocityString = match.group(1);
    distanceString = match.group(3);
  }
  if (matches.isEmpty) {
    regExp =
        RegExp(r'^\s*(X|x)\:?\s*([\-0-9\.]+)(\s*\,?\s*)(Y|y)\:?\s*([\-0-9\.]+)(\s*\,?\s*)(Z|z)\:?\s*([\-0-9\.]+)\s*$');
    matches = regExp.allMatches(input);
    if (matches.isNotEmpty) {
      var match = matches.elementAt(0);
      velocityString = match.group(2);
      distanceString = match.group(5);
    }
  }

  if (matches.isEmpty) return null;
  if (velocityString == null || distanceString == null) {
    return null;
  }

  var velocity = double.tryParse(velocityString);
  var distance = double.tryParse(distanceString);

  if (velocity == null || distance == null) return null;

  return GC8K7RCCoordinate(velocity, distance,);
}
