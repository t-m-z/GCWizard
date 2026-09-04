import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';
import 'package:latlong2/latlong.dart';

void main() {
  var coords = LatLng(36.0, -121.0);
  var dt = DateTime(2026,9,3,12,00);
  var tz = -7;
  group("calc.WBGT:", () {
    // https://www.osha.gov/heat-exposure/wbgt-calculator
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : WbgtInput(
          observationTime: dt,
          gmtOffsetHours: tz,
          averagingMinutes: 0,
          latitude: coords.latitude,
          longitude: coords.longitude,
          cloudCoverFraction: 0.0,
          pressureMb: 1013.25,
          airTemperatureC: 30.0,
          relativeHumidityPct: 30.0,
          windSpeedMs: 0.44704,
          windSpeedHeightM: 2.0

      ), 'expectedOutput' : WbgtResult(
          estimatedWindSpeedMs: null,
          globeTemperatureC: null,
          naturalWetBulbC: null,
          psychrometricWetBulbC: null,
          wetBulbGlobeTemperatureC: 30.08165560540848,
          solarWm2: 0.0

      )},

    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _expect = elem['expectedOutput'] as WbgtResult;
        var _actual = calculateWbgt(elem['input'] as WbgtInput);
        expect(_actual.wetBulbGlobeTemperatureC, _expect.wetBulbGlobeTemperatureC);
      });
    }
  });
}
