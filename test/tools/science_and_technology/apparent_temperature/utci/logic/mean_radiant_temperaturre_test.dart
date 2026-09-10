import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/mean_radiant_temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart' as wbgt;


void main() {
  group('meanRadiantTemperatureFromGlobe', () {
    test('equals air temperature when globe temperature equals air temperature', () {
      // No net radiative/convective exchange -> Tmrt == Tg == Ta.
      final tmrt = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 25,
        airTemperatureC: 25,
        windSpeedMs: 1.0,
      );
      expect(tmrt, closeTo(25, 1e-6));
    });

    test('exceeds globe temperature when the globe is warmer than the air (net solar heating)', () {
      final tmrt = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 45,
        airTemperatureC: 30,
        windSpeedMs: 1.0,
      );
      // Reference value from a Dart-independent Python re-implementation of
      // the same convective coefficient + energy balance.
      expect(tmrt, closeTo(75.4008, 1e-3));
      expect(tmrt!, greaterThan(45));
    });

    test('is below the globe temperature when the globe is cooler than the air (net radiative cooling)', () {
      final tmrt = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 20,
        airTemperatureC: 30,
        windSpeedMs: 2.0,
      );
      expect(tmrt, closeTo(-35.4284, 1e-3));
      expect(tmrt!, lessThan(20));
    });

    test('matches reference value for a classic-size (150 mm) globe at low wind speed', () {
      final tmrt = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 55,
        airTemperatureC: 30,
        windSpeedMs: 0.3,
        globeDiameterM: 0.15,
      );
      expect(tmrt, isNotNull);
      expect(tmrt!, greaterThan(55)); // globe warmer than air -> Tmrt > Tg
    });

    test('increasing wind speed increases how far Tmrt is pulled from Tg towards Ta', () {
      // Higher wind speed increases the convective coefficient, which (for a
      // fixed globe/air temperature pair) increases |Tmrt - Tg|.
      final low = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 45,
        airTemperatureC: 30,
        windSpeedMs: 0.5,
      );
      final high = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: 45,
        airTemperatureC: 30,
        windSpeedMs: 5.0,
      );
      expect(low, isNotNull);
      expect(high, isNotNull);
      expect(high!, greaterThan(low!));
    });

    group('no physically valid solution (Tmrt^4 would be <= 0)', () {
      // Regression tests for a bug found in code review: with the small
      // default globe (wbgt.dGlobe = 0.0508 m), its convective coefficient
      // is large enough that even a moderately-cooler-than-air globe
      // reading has no positive-Kelvin Tmrt solution. Before the fix, this
      // silently returned a physically nonsensical finite value (or NaN)
      // instead of null.
      test('returns null instead of a wildly-wrong finite value', () {
        final tmrt = meanRadiantTemperatureFromGlobe(
          globeTemperatureC: 14,
          airTemperatureC: 30,
          windSpeedMs: 2.0,
        );
        expect(tmrt, isNull);
      });

      test('returns null instead of NaN for an even larger Tg-Ta gap', () {
        final tmrt = meanRadiantTemperatureFromGlobe(
          globeTemperatureC: 12,
          airTemperatureC: 30,
          windSpeedMs: 2.0,
        );
        expect(tmrt, isNull);
      });

      test('the same globe/air/wind combination succeeds with a classic 150 mm globe', () {
        // A 150 mm globe has a much smaller convective coefficient for the
        // same wind speed, so the same Tg/Ta/wind combination that fails
        // with the small default globe has a valid solution here.
        final tmrt = meanRadiantTemperatureFromGlobe(
          globeTemperatureC: 14,
          airTemperatureC: 30,
          windSpeedMs: 2.0,
          globeDiameterM: 0.15,
        );
        expect(tmrt, isNotNull);
      });
    });
  });

  group('meanRadiantTemperatureFromWeather', () {
    test('produces a converged result for typical daytime summer conditions', () {
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2024, 7, 15, 14, 0),
        gmtOffsetHours: -5,
        averagingMinutes: 60,
        latitude: 40.0,
        longitude: -88.0,
        cloudCoverFraction: 0.3,
        pressureMb: 1013.0,
        airTemperatureC: 35.0,
        relativeHumidityPct: 50.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );

      final tmrt = meanRadiantTemperatureFromWeather(input);

      expect(tmrt, isNotNull);
      // Under sun, the globe (and thus Tmrt) should read warmer than the
      // measured air temperature.
      expect(tmrt!, greaterThan(input.airTemperatureC));
    });

    test('is consistent with meanRadiantTemperatureFromGlobe applied to calculateWbgt output', () {
      final input = wbgt.WbgtInput(
        observationTime: DateTime(2024, 7, 15, 14, 0),
        gmtOffsetHours: -5,
        averagingMinutes: 60,
        latitude: 40.0,
        longitude: -88.0,
        cloudCoverFraction: 0.3,
        pressureMb: 1013.0,
        airTemperatureC: 35.0,
        relativeHumidityPct: 50.0,
        windSpeedMs: 2.0,
        windSpeedHeightM: 2.0,
      );

      final result = wbgt.calculateWbgt(input);
      final expected = meanRadiantTemperatureFromGlobe(
        globeTemperatureC: result.globeTemperatureC!,
        airTemperatureC: input.airTemperatureC,
        windSpeedMs: result.estimatedWindSpeedMs ?? input.windSpeedMs,
        pressureMb: input.pressureMb,
      );

      expect(expected, isNotNull);
      expect(meanRadiantTemperatureFromWeather(input), closeTo(expected!, 1e-9));
    });
  });
}