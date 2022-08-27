import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:latlong2/latlong.dart';

LatLng dmmToLatLon(DMM dmm) {
  return decToLatLon(_DMMToDEC(dmm));
}

DEC _DMMToDEC(DMM coord) {
  var lat = _DMMPartToDouble(coord.latitude);
  var lon = _DMMPartToDouble(coord.longitude);

  return normalizeDEC(DEC(lat, lon));
}

double _DMMPartToDouble(DMMPart dmmPart) {
  return dmmPart.sign * (dmmPart.degrees.abs() + dmmPart.minutes / 60.0);
}

DMM latLonToDMM(LatLng coord) {
  return _DECToDMM(DEC.fromLatLon(coord));
}

DMM _DECToDMM(DEC coord) {
  var normalizedCoord = normalizeDEC(coord);

  var lat = DMMLatitude.from(_doubleToDMMPart(normalizedCoord.latitude));
  var lon = DMMLongitude.from(_doubleToDMMPart(normalizedCoord.longitude));

  return DMM(lat, lon);
}

DMMPart _doubleToDMMPart(double value) {
  var _sign = coordinateSign(value);

  int _degrees = value.abs().floor();
  double _minutes = (value.abs() - _degrees) * 60.0;

  return DMMPart(_sign, _degrees, _minutes);
}

DMM normalize(DMM coord) {
  return _DECToDMM(_DMMToDEC(coord));
}

DMM parseDMM(String input, {leftPadMilliMinutes: false, wholeString: false}) {
  input = prepareInput(input, wholeString: wholeString);
  if (input == null) return null;

  var parsedTrailingSigns = _parseDMMTrailingSigns(input, leftPadMilliMinutes);
  if (parsedTrailingSigns != null) return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DMM + regexEnd, caseSensitive: false);
  if (regex.hasMatch(input)) {
    var matches = regex.firstMatch(input);

    var latSign = sign(matches.group(1));
    var latDegrees = int.tryParse(matches.group(2));
    var latMinutes = 0.0;
    if (matches.group(4) != null) {
      if (leftPadMilliMinutes && (matches.group(4).length) < 3)
        latMinutes = _leftPadDMMMilliMinutes(matches.group(3), matches.group(4));
      else
        latMinutes = double.parse('${matches.group(3)}.${matches.group(4)}');
    } else {
      latMinutes = double.parse('${matches.group(3)}.0');
    }
    var lat = DMMLatitude(latSign, latDegrees, latMinutes);

    var lonSign = sign(matches.group(5));
    var lonDegrees = int.tryParse(matches.group(6));
    var lonMinutes = 0.0;
    if (matches.group(8) != null) {
      if (leftPadMilliMinutes && matches.group(8).length < 3)
        lonMinutes = _leftPadDMMMilliMinutes(matches.group(7), matches.group(8));
      else
        lonMinutes = double.parse('${matches.group(7)}.${matches.group(8)}');
    } else {
      lonMinutes = double.parse('${matches.group(7)}.0');
    }
    var lon = DMMLongitude(lonSign, lonDegrees, lonMinutes);

    return DMM(lat, lon);
  }

  return null;
}

double _leftPadDMMMilliMinutes(String minutes, String milliMinutes) {
  if (milliMinutes.length <= 3) return double.tryParse('$minutes.${milliMinutes.padLeft(3, '0')}');

  int milliMinuteValue = int.tryParse(milliMinutes);
  int minuteValue = int.tryParse(minutes) + (milliMinuteValue / 1000).floor();

  return double.tryParse('$minuteValue.${milliMinuteValue % 1000}');
}

DMM _parseDMMTrailingSigns(String text, leftPadMilliMinutes) {
  RegExp regex = RegExp(PATTERN_DMM_TRAILINGSIGN + regexEnd, caseSensitive: false);

  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = sign(matches.group(4));
    var latDegrees = int.tryParse(matches.group(1));
    var latMinutes = 0.0;
    if (matches.group(3) != null) {
      if (leftPadMilliMinutes)
        latMinutes = _leftPadDMMMilliMinutes(matches.group(2), matches.group(3));
      else
        latMinutes = double.parse('${matches.group(2)}.${matches.group(3)}');
    } else {
      latMinutes = double.parse('${matches.group(2)}.0');
    }
    var lat = DMMLatitude(latSign, latDegrees, latMinutes);

    var lonSign = sign(matches.group(8));
    var lonDegrees = lonSign * int.tryParse(matches.group(5));
    var lonMinutes = 0.0;
    if (matches.group(7) != null) {
      if (leftPadMilliMinutes)
        lonMinutes = _leftPadDMMMilliMinutes(matches.group(6), matches.group(7));
      else
        lonMinutes = double.parse('${matches.group(6)}.${matches.group(7)}');
    } else {
      lonMinutes = double.parse('${matches.group(6)}.0');
    }
    var lon = DMMLongitude(lonSign, lonDegrees, lonMinutes);

    return DMM(lat, lon);
  }

  return null;
}

final PATTERN_DMM_TRAILINGSIGN = '^\\s*?'
    '(\\d{1,3})\\s*?[\\s°]\\s*?' //lat degrees + symbol
    '([0-5]?\\d)\\s*?' //lat minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lat milliminutes
    '[\\s\'´′`’‘]?\\s*?' //lat minute symbol
    '([NS]$LETTER*?|[\\+\\-])\\s*?' //lat sign

    '[,\\s]\\s*?' //delimiter lat lon

    '(\\d{1,3})\\s*?[\\s°]\\s*?' //lon degrees + symbol
    '([0-5]?\\d)\\s*?' //lon minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lon milliminutes
    '[\\s\'´′`’‘]?\\s*?' //lon minutes symbol
    '([EWO]$LETTER*?|[\\+\\-])' //lon sign;
    '\\s*?';

final PATTERN_DMM = '^\\s*?'
    '([NS]$LETTER*?|[\\+\\-])?\\s*?' //lat sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?' //lat degrees + symbol
    '([0-5]?\\d)\\s*?' //lat minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lat milliminutes
    '[\\s\'´′`’‘]?\\s*?' //lat minute symbol

    '\\s*?[,\\s]\\s*?' //delimiter lat lon

    '([EWO]$LETTER*?|[\\+\\-])?\\s*?' //lon sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?' //lon degrees + symbol
    '([0-5]?\\d)\\s*?' //lon minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lon milliminutes
    '[\\s\'´′`’‘]?' //lon minutes symbol
    '\\s*?';
