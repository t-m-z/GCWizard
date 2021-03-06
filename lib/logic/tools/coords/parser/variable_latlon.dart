import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong/latlong.dart';

class ParseVariableLatLonJobData {
  final String coordinate;
  final Map<String, String> substitutions;
  final Map<String, dynamic> projectionData;

  ParseVariableLatLonJobData({
      this.coordinate = null,
      this.substitutions = null,
      this.projectionData = const {}
  });
}

Map<String, LatLng> _parseCoordText(String text) {
  var parsedCoord = parseLatLon(text);
  if (parsedCoord == null)
    return null;

  var out = <String, LatLng>{'coordinate': parsedCoord['coordinate']};

  if (parsedCoord['format'] == keyCoordsDMM) {
    out.putIfAbsent('leftPadCoordinate', () => parseDMM(text, leftPadMilliMinutes: true));
  }

  return out;
}

_sanitizeVariableDoubleText(String text) {
  if (text == null)
    return null;

  return text.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9\.\[\]]'), '');
}

_sanitizeForFormula(String formula) {
  RegExp regExp = new RegExp(r'\[.+?\]');
  if (regExp.hasMatch(formula))
    return formula;

  return '[$formula]';
}

void parseVariableLatLonAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return;
  }

  var output = parseVariableLatLon(
      jobData.parameters.coordinate,
      jobData.parameters.substitutions,
      projectionData : jobData.parameters.projectionData
  );

  jobData.sendAsyncPort.send(output);
}

Map<String, dynamic> parseVariableLatLon(String coordinate, Map<String, String> substitutions, {Map<String, dynamic> projectionData = const {}}) {
  var textToExpand = _sanitizeForFormula(coordinate);

  var withProjection = false;
  if (projectionData != null) {
    if (projectionData['bearing'] != null && projectionData['bearing'].length > 0
        && projectionData['distance'] != null && projectionData['distance'].length > 0) {
      withProjection = true;
      textToExpand += String.fromCharCode(1) + _sanitizeForFormula(projectionData['bearing']);
      textToExpand += String.fromCharCode(1) + _sanitizeForFormula(projectionData['distance']);
    }
  }

  var formulaParser = FormulaParser();

  var expandedTexts = VariableStringExpander(textToExpand, substitutions, (e) {
    return formulaParser
        .parse(e, {})['result']
        .replaceAll(RegExp(r'[\[\]]'), '');
  }, uniqueResults: true).run();

  var coords = <Map<String, dynamic>>[];
  var leftPadCoords = <Map<String, dynamic>>[];

  for (Map<String, dynamic> expandedText in expandedTexts) {
    if (withProjection) {
      var evaluatedTexts = expandedText['text'].split(String.fromCharCode(1));

      var parsedCoord = _parseCoordText(evaluatedTexts[0]);
      if (parsedCoord == null)
        continue;

      var parsedBearing = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[1]));
      var parsedDistance = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[2]));

      if (parsedBearing == null || parsedDistance == null)
        continue;

      parsedBearing = modulo(parsedBearing, 360);
      parsedDistance = parsedDistance.abs();

      parsedCoord.entries.forEach((entry) {

        if (projectionData['reverseBearing'] != null && projectionData['reverseBearing']) {

          var revProjected = reverseProjection(entry.value, parsedBearing, projectionData['lengthUnit'].toMeter(parsedDistance), projectionData['ellipsoid']);
          if (revProjected == null || revProjected.length == 0)
            return;

          var projected = revProjected.map((projection) {
            return {'variables': expandedText['variables'], 'coordinate': projection};
          }).toList();

          if (entry.key == 'coordinate')
            coords.addAll(projected);
          else
            leftPadCoords.addAll(projected);

        } else {
          var projected = {
            'coordinate' : projection(entry.value, parsedBearing, projectionData['lengthUnit'].toMeter(parsedDistance), projectionData['ellipsoid']),
            'variables' : expandedText['variables']
          };

          if (entry.key == 'coordinate')
            coords.add(projected);
          else
            leftPadCoords.add(projected);
        }
      });

    } else {
      var parsedCoord = _parseCoordText(expandedText['text']);
      if (parsedCoord == null)
        continue;

      coords.add({'variables': expandedText['variables'], 'coordinate': parsedCoord['coordinate']});
      if (parsedCoord['leftPadCoordinate'] != null) {
        leftPadCoords.add({'variables': expandedText['variables'], 'coordinate': parsedCoord['leftPadCoordinate']});
      }
    }
  }

  return {'coordinates' : coords, 'leftPadCoordinates': leftPadCoords};
}