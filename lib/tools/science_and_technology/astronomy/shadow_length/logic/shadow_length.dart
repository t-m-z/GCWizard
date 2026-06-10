import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/logic/projection.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart' as astronomy;
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/utils/coordinate_utils.dart' as utils;

class ShadowLength {
  final double length;
  final double bearing;
  final LatLng shadowEndPosition;
  final astronomy.SunPosition sunPosition;

  ShadowLength(this.length, this.bearing, this.shadowEndPosition, this.sunPosition);
}

ShadowLength shadowLength(
  double objectHeight,
  LatLng coords,
  Ellipsoid ells,
  DateTime utcDateTime,
) {
  var sunPosition = astronomy.SunPosition(coords, utcDateTime);
  var shadowLen =
      objectHeight * cos(degreesToRadian(sunPosition.altitudeDeg)) / sin(degreesToRadian(sunPosition.altitudeDeg));
  // Sun is in one Direction, so shadow is the opposite direction
  var shadowAzimuth = utils.normalizeBearing(sunPosition.azimuthDeg + 180.0);

  var _currentPosition = projection(coords, shadowAzimuth, shadowLen, ells);

  return ShadowLength(shadowLen, shadowAzimuth, _currentPosition, sunPosition);
}
