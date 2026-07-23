import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:latlong2/latlong.dart';

void main() {

  bool _equals(double a, double b, double tolerance) {
    return (a - b).abs() <= tolerance;
  }

  double tolerance = 1e-1;

  //https://gml.noaa.gov/grad/solcalc/
  group("sun_position.calculate:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'year': 2016,
        'month': 6,
        'day': 23,
        'hour': 16,
        'minute': 9,
        'second': 0,
        'timezone': 2,
        'coords': const LatLng(52.43115, 13.4337),
        'expectedOutputAzimuth': 247.35,
        'expectedOutputAltitude': 45.24,
      },
      {
        'year': 2025,
        'month': 3,
        'day': 19,
        'hour': 12,
        'minute': 53,
        'second': 42,
        'timezone': -10,
        'coords': const LatLng(21.3, -157.85),
        'expectedOutputAzimuth': 190.01,
        'expectedOutputAltitude': 68.24,
      },
      {
        'year': 2025,
        'month': 3,
        'day': 19,
        'hour': 12,
        'minute': 53,
        'second': 42,
        'timezone': 11,
        'coords': const LatLng(-38.13455, 145.371093),
        'expectedOutputAzimuth': 13.2,
        'expectedOutputAltitude': 51.65,
      },
      {
        'year': 2025,
        'month': 3,
        'day': 19,
        'hour': 12,
        'minute': 53,
        'second': 42,
        'timezone': -3,
        'coords': const LatLng(-55.07836, -67.851562),
        'expectedOutputAzimuth': 13.78,
        'expectedOutputAltitude': 34.45,
      },
    ];

    for (var elem in _inputsToExpected) {
      test('year: ${elem['year']}, month: ${elem['month']}, day: ${elem['day']}, hour: ${elem['hour']}, minute: ${elem['minute']}, second: ${elem['second']}, utc: ${elem['utc']}, coords: ${elem['coords']}', () {
        var _actual = SunPosition(
            elem['coords'] as LatLng,
            DateTimeUTCwithTZ(
              dateTimeUtc: DateTime.utc(
                elem['year'] as int,
                elem['month'] as int,
                elem['day'] as int,
                (elem['hour'] as int) - (elem['timezone'] as int),
                elem['minute'] as int,
                elem['second'] as int,
              ),
              timezoneOffset: Duration(hours: (elem['timezone'] as int))
            ).dateTimeUtc
        );

        expect(_equals(_actual.azimuthDeg, elem['expectedOutputAzimuth'] as double, tolerance), true);
        expect(_equals(_actual.altitudeDeg, elem['expectedOutputAltitude'] as double, tolerance), true);

      });
    }
  });
}
