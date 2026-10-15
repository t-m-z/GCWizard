// Regression tests for utciFromWeather across a broad set of realistic
// global weather scenarios (clear/overcast/night, dry/humid, calm/windy,
// northern/southern hemisphere, wind measured at a non-reference height).
//
// There is no independent public calculator for the full
// "weather -> Tg -> Tmrt -> UTCI" pipeline the way utci.org/utci_calc.php
// exists for the UTCI_approx polynomial alone (see
// test/utci_calc_reference_test.dart for that cross-check) -- Liljegren's
// WBGT model has no equivalent official online calculator either. These
// expected values are therefore golden/regression values obtained by
// running utciFromWeather itself (which is exercised in more targeted,
// hand-verified scenarios in test/utci_from_weather_test.dart); they guard
// against accidental regressions in this broader, more realistic input
// matrix rather than independently verifying correctness.
import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart' as wbgt;
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/utci.dart';

void main() {
  group('utciFromWeather across realistic global scenarios', () {
    test('California, clear sky, midday', () {
      // utciFromWeather(...) -> UTCI=42.478168021284006
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 9, 3, 12, 0),
        gmtOffsetHours: -7,
        averagingMinutes: 0,
        latitude: 36.0,
        longitude: -121.0,
        cloudCoverFraction: 0.0,
        pressureMb: 1013.25,
        airTemperatureC: 30.0,
        relativeHumidityPct: 30.0,
        windSpeedMs: 0.44704, // 1 mph
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(42.478168021284006, 1e-6));
    });

    test('California, fully overcast, midday (lower solar than clear sky)', () {
      // Same scenario as above, but fully overcast (cloudCoverFraction: 1.0)
      // instead of clear sky: solar irradiance drops sharply, which pulls
      // UTCI below the clear-sky case.
      // utciFromWeather(...) -> UTCI=33.260388831349424
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 9, 3, 12, 0),
        gmtOffsetHours: -7,
        averagingMinutes: 0,
        latitude: 36.0,
        longitude: -121.0,
        cloudCoverFraction: 1.0,
        pressureMb: 1013.25,
        airTemperatureC: 30.0,
        relativeHumidityPct: 30.0,
        windSpeedMs: 0.44704,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(33.260388831349424, 1e-6));
      expect(utci, lessThan(42.478168021284006)); // clear-sky value above
    });

    test('California, wind measured at 10 m (exercises wind speed estimation)', () {
      // Wind measured at 10 m (a typical station anemometer height) instead
      // of the 2 m reference height: exercises the wind-speed-estimation
      // path inside wbgt.calculateWbgt (estimatedWindSpeedMs is non-null).
      // utciFromWeather(...) -> UTCI=40.84010304879733
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 9, 3, 12, 0),
        gmtOffsetHours: -7,
        averagingMinutes: 0,
        latitude: 36.0,
        longitude: -121.0,
        cloudCoverFraction: 0.0,
        pressureMb: 1013.25,
        airTemperatureC: 30.0,
        relativeHumidityPct: 30.0,
        windSpeedMs: 3.0,
        windSpeedHeightM: 10.0,
      );
      expect(wbgt.calculateWbgt(input).estimatedWindSpeedMs, isNotNull);
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(40.84010304879733, 1e-6));
    });

    test('California, nighttime (zero solar irradiance)', () {
      // Nighttime: solar irradiance must be 0 regardless of
      // cloudCoverFraction once the sun is below the horizon.
      // utciFromWeather(...) -> UTCI=14.87401619555411
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 9, 3, 0, 0),
        gmtOffsetHours: -7,
        averagingMinutes: 0,
        latitude: 36.0,
        longitude: -121.0,
        cloudCoverFraction: 0.3,
        pressureMb: 1013.25,
        airTemperatureC: 18.0,
        relativeHumidityPct: 60.0,
        windSpeedMs: 1.5,
        windSpeedHeightM: 2.0,
      );
      expect(wbgt.calculateWbgt(input).solarWm2, equals(0.0));
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(14.87401619555411, 1e-6));
    });

    test('Miami, hot & humid, partly cloudy', () {
      // utciFromWeather(...) -> UTCI=48.51367407846337
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 15, 15, 0),
        gmtOffsetHours: -4,
        averagingMinutes: 0,
        latitude: 25.7617,
        longitude: -80.1918,
        cloudCoverFraction: 0.5,
        pressureMb: 1015.0,
        airTemperatureC: 33.0,
        relativeHumidityPct: 70.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(48.51367407846337, 1e-6));
    });

    test('Berlin, summer heatwave afternoon, partly cloudy', () {
      // utciFromWeather(...) -> UTCI=40.07584592656771
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 14, 0),
        gmtOffsetHours: 2, // CEST
        averagingMinutes: 0,
        latitude: 52.5200,
        longitude: 13.4050,
        cloudCoverFraction: 0.4,
        pressureMb: 1015.0,
        airTemperatureC: 29.0,
        relativeHumidityPct: 45.0,
        windSpeedMs: 3.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(40.07584592656771, 1e-6));
    });

    test('Rome, hot summer afternoon, mostly clear', () {
      // utciFromWeather(...) -> UTCI=48.010445604101584
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 15, 0),
        gmtOffsetHours: 2, // CEST
        averagingMinutes: 0,
        latitude: 41.9028,
        longitude: 12.4964,
        cloudCoverFraction: 0.1,
        pressureMb: 1012.0,
        airTemperatureC: 35.0,
        relativeHumidityPct: 40.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(48.010445604101584, 1e-6));
    });

    test('Madrid, dry summer heat, clear sky, late afternoon', () {
      // utciFromWeather(...) -> UTCI=49.90697127530975
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 16, 0),
        gmtOffsetHours: 2, // CEST
        averagingMinutes: 0,
        latitude: 40.4168,
        longitude: -3.7038,
        cloudCoverFraction: 0.0,
        pressureMb: 1010.0,
        airTemperatureC: 38.0,
        relativeHumidityPct: 20.0,
        windSpeedMs: 1.5,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(49.90697127530975, 1e-6));
    });

    test('Cairo, dry desert heat, clear sky, early afternoon', () {
      // utciFromWeather(...) -> UTCI=53.965476878645354
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 13, 0),
        gmtOffsetHours: 2, // EET
        averagingMinutes: 0,
        latitude: 30.0444,
        longitude: 31.2357,
        cloudCoverFraction: 0.0,
        pressureMb: 1008.0,
        airTemperatureC: 42.0,
        relativeHumidityPct: 15.0,
        windSpeedMs: 3.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(53.965476878645354, 1e-6));
    });

    test('Dubai, extreme humid Gulf heat, nearly clear sky, midday', () {
      // High heat + high humidity pushes this close to the dangerous end
      // of the UTCI scale.
      // utciFromWeather(...) -> UTCI=58.86524707253236
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 14, 0),
        gmtOffsetHours: 4, // Gulf Standard Time
        averagingMinutes: 0,
        latitude: 25.2048,
        longitude: 55.2708,
        cloudCoverFraction: 0.05,
        pressureMb: 1002.0,
        airTemperatureC: 41.0,
        relativeHumidityPct: 55.0,
        windSpeedMs: 2.5,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(58.86524707253236, 1e-6));
    });

    test('Singapore, equatorial tropical heat, partly cloudy', () {
      // utciFromWeather(...) -> UTCI=47.827084832680136
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 7, 20, 14, 0),
        gmtOffsetHours: 8, // SGT
        averagingMinutes: 0,
        latitude: 1.3521,
        longitude: 103.8198,
        cloudCoverFraction: 0.6,
        pressureMb: 1010.0,
        airTemperatureC: 32.0,
        relativeHumidityPct: 75.0,
        windSpeedMs: 1.5,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(47.827084832680136, 1e-6));
    });

    test('Seoul, humid East Asian summer monsoon heat, partly cloudy', () {
      // utciFromWeather(...) -> UTCI=47.41022017354899
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 8, 10, 15, 0),
        gmtOffsetHours: 9, // KST
        averagingMinutes: 0,
        latitude: 37.5665,
        longitude: 126.9780,
        cloudCoverFraction: 0.5,
        pressureMb: 1006.0,
        airTemperatureC: 33.0,
        relativeHumidityPct: 70.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(47.41022017354899, 1e-6));
    });

    test('Sydney, southern-hemisphere summer afternoon, mostly clear', () {
      // Daylight saving is in effect in January (AEDT).
      // utciFromWeather(...) -> UTCI=46.31452788651787
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 1, 15, 15, 0),
        gmtOffsetHours: 11,
        averagingMinutes: 0,
        latitude: -33.8688,
        longitude: 151.2093,
        cloudCoverFraction: 0.2,
        pressureMb: 1015.0,
        airTemperatureC: 35.0,
        relativeHumidityPct: 30.0,
        windSpeedMs: 4.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(46.31452788651787, 1e-6));
    });

    test('Brasilia, southern-hemisphere rainy-season afternoon, mostly cloudy', () {
      // Brazil no longer observes DST (BRT, gmtOffsetHours: -3).
      // utciFromWeather(...) -> UTCI=42.504985891659075
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2026, 1, 15, 14, 0),
        gmtOffsetHours: -3,
        averagingMinutes: 0,
        latitude: -15.7942,
        longitude: -47.8822,
        cloudCoverFraction: 0.7,
        pressureMb: 1010.0,
        airTemperatureC: 29.0,
        relativeHumidityPct: 65.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );
      final utci = calculateUtciFromWeather(input);
      expect(utci, isNotNull);
      expect(utci!, closeTo(42.504985891659075, 1e-6));
    });
  });
}