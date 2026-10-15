import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';
import 'package:latlong2/latlong.dart';

void main() {
  var coords = LatLng(36.0, -121.0);
  var dt = DateTime(2026, 9, 3, 12, 00);
  var tz = -7;
  group("calc.WBGT:", () {
    // Expected wetBulbGlobeTemperatureC values were obtained by running
    // calculateWbgt itself (cross-checked against James C. Liljegren's
    // reference C implementation, https://github.com/t-m-z/wbgt) and are
    // used here as golden/regression values, not independently verified
    // against an external calculator.
    // Because there is no valid calculator based on Liljegren's implementation.
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': WbgtInput(
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
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 30.08165560540848,
            solarWm2: 0.0)
      },
      // Same scenario as above, but fully overcast (cloudCoverFraction: 1.0)
      // instead of clear sky: solar irradiance drops sharply, which should
      // pull WBGT well below the clear-sky case.
      {
        'input': WbgtInput(
            observationTime: dt,
            gmtOffsetHours: tz,
            averagingMinutes: 0,
            latitude: coords.latitude,
            longitude: coords.longitude,
            cloudCoverFraction: 1.0,
            pressureMb: 1013.25,
            airTemperatureC: 30.0,
            relativeHumidityPct: 30.0,
            windSpeedMs: 0.44704,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 24.653219314734645,
            solarWm2: 0.0)
      },
      // Wind measured at 10 m (a typical station anemometer height) instead
      // of the 2 m reference height: exercises the wind-speed-estimation
      // path (estimatedWindSpeedMs is non-null).
      {
        'input': WbgtInput(
            observationTime: dt,
            gmtOffsetHours: tz,
            averagingMinutes: 0,
            latitude: coords.latitude,
            longitude: coords.longitude,
            cloudCoverFraction: 0.0,
            pressureMb: 1013.25,
            airTemperatureC: 30.0,
            relativeHumidityPct: 30.0,
            windSpeedMs: 3.0,
            windSpeedHeightM: 10.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: 2.6803613963017265,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 25.49513495988387,
            solarWm2: 0.0)
      },
      // Nighttime: solar irradiance must be 0 regardless of cloudCoverFraction
      // once the sun is below the horizon.
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 9, 3, 0, 00),
            gmtOffsetHours: tz,
            averagingMinutes: 0,
            latitude: coords.latitude,
            longitude: coords.longitude,
            cloudCoverFraction: 0.3,
            pressureMb: 1013.25,
            airTemperatureC: 18.0,
            relativeHumidityPct: 60.0,
            windSpeedMs: 1.5,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 14.383109738984796,
            solarWm2: 0.0)
      },
      // Hot & humid, partly cloudy, different site (Miami, FL) to broaden
      // coverage beyond the dry-heat California scenario above.
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 15, 15, 00),
            gmtOffsetHours: -4,
            averagingMinutes: 0,
            latitude: 25.7617,
            longitude: -80.1918,
            cloudCoverFraction: 0.5,
            pressureMb: 1015.0,
            airTemperatureC: 33.0,
            relativeHumidityPct: 70.0,
            windSpeedMs: 2.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 33.851769996006404,
            solarWm2: 0.0)
      },
      // Berlin, summer heatwave afternoon, partly cloudy (CEST, gmtOffsetHours: 2).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 14, 00),
            gmtOffsetHours: 2,
            averagingMinutes: 0,
            latitude: 52.5200,
            longitude: 13.4050,
            cloudCoverFraction: 0.4,
            pressureMb: 1015.0,
            airTemperatureC: 29.0,
            relativeHumidityPct: 45.0,
            windSpeedMs: 3.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 26.432554804476645,
            solarWm2: 0.0)
      },
      // Rome, hot summer afternoon, mostly clear (CEST, gmtOffsetHours: 2).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 15, 00),
            gmtOffsetHours: 2,
            averagingMinutes: 0,
            latitude: 41.9028,
            longitude: 12.4964,
            cloudCoverFraction: 0.1,
            pressureMb: 1012.0,
            airTemperatureC: 35.0,
            relativeHumidityPct: 40.0,
            windSpeedMs: 2.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 31.472222905882965,
            solarWm2: 0.0)
      },
      // Madrid, dry summer heat, clear sky, late afternoon (CEST, gmtOffsetHours: 2).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 16, 00),
            gmtOffsetHours: 2,
            averagingMinutes: 0,
            latitude: 40.4168,
            longitude: -3.7038,
            cloudCoverFraction: 0.0,
            pressureMb: 1010.0,
            airTemperatureC: 38.0,
            relativeHumidityPct: 20.0,
            windSpeedMs: 1.5,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 30.775870207073304,
            solarWm2: 0.0)
      },
      // Cairo, dry desert heat, clear sky, early afternoon (EET, gmtOffsetHours: 2).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 13, 00),
            gmtOffsetHours: 2,
            averagingMinutes: 0,
            latitude: 30.0444,
            longitude: 31.2357,
            cloudCoverFraction: 0.0,
            pressureMb: 1008.0,
            airTemperatureC: 42.0,
            relativeHumidityPct: 15.0,
            windSpeedMs: 3.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 31.191353909781064,
            solarWm2: 0.0)
      },
      // Dubai, extreme humid Gulf heat, nearly clear sky, midday (Gulf Standard
      // Time, gmtOffsetHours: 4). High heat + high humidity pushes this close
      // to the dangerous end of the WBGT scale.
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 14, 00),
            gmtOffsetHours: 4,
            averagingMinutes: 0,
            latitude: 25.2048,
            longitude: 55.2708,
            cloudCoverFraction: 0.05,
            pressureMb: 1002.0,
            airTemperatureC: 41.0,
            relativeHumidityPct: 55.0,
            windSpeedMs: 2.5,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 38.65823412825792,
            solarWm2: 0.0)
      },
      // Singapore, equatorial tropical heat, partly cloudy, low sun angle
      // spread (near the equator) but persistently high humidity (SGT,
      // gmtOffsetHours: 8).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 7, 20, 14, 00),
            gmtOffsetHours: 8,
            averagingMinutes: 0,
            latitude: 1.3521,
            longitude: 103.8198,
            cloudCoverFraction: 0.6,
            pressureMb: 1010.0,
            airTemperatureC: 32.0,
            relativeHumidityPct: 75.0,
            windSpeedMs: 1.5,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 33.922716704976956,
            solarWm2: 0.0)
      },
      // Seoul, humid East Asian summer monsoon heat, partly cloudy, afternoon
      // (KST, gmtOffsetHours: 9).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 8, 10, 15, 00),
            gmtOffsetHours: 9,
            averagingMinutes: 0,
            latitude: 37.5665,
            longitude: 126.9780,
            cloudCoverFraction: 0.5,
            pressureMb: 1006.0,
            airTemperatureC: 33.0,
            relativeHumidityPct: 70.0,
            windSpeedMs: 2.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 33.4918817995911,
            solarWm2: 0.0)
      },
      // Sydney, southern-hemisphere summer afternoon, mostly clear (AEDT,
      // gmtOffsetHours: 11 - daylight saving is in effect in January).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 1, 15, 15, 00),
            gmtOffsetHours: 11,
            averagingMinutes: 0,
            latitude: -33.8688,
            longitude: 151.2093,
            cloudCoverFraction: 0.2,
            pressureMb: 1015.0,
            airTemperatureC: 35.0,
            relativeHumidityPct: 30.0,
            windSpeedMs: 4.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 28.8922829559259,
            solarWm2: 0.0)
      },
      // Brasilia, southern-hemisphere summer/rainy-season afternoon, mostly
      // cloudy (BRT, gmtOffsetHours: -3 - Brazil no longer observes DST).
      {
        'input': WbgtInput(
            observationTime: DateTime(2026, 1, 15, 14, 00),
            gmtOffsetHours: -3,
            averagingMinutes: 0,
            latitude: -15.7942,
            longitude: -47.8822,
            cloudCoverFraction: 0.7,
            pressureMb: 1010.0,
            airTemperatureC: 29.0,
            relativeHumidityPct: 65.0,
            windSpeedMs: 2.0,
            windSpeedHeightM: 2.0),
        'expectedOutput': WbgtResult(
            estimatedWindSpeedMs: null,
            globeTemperatureC: null,
            naturalWetBulbC: null,
            psychrometricWetBulbC: null,
            wetBulbGlobeTemperatureC: 29.643752060187108,
            solarWm2: 0.0)
      },
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
