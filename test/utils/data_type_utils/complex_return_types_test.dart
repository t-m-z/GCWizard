import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/complex_return_types.dart';

void main() {
  group("DateTimeTimezone.toLocalTime:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : DateTimeUTCwithTZ(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezoneOffset: const Duration()), 'expectedOutput' : DateTime.utc(2024, 9, 30, 12)},
      {'input' : DateTimeUTCwithTZ(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezoneOffset: const Duration(hours: 2)), 'expectedOutput' : DateTime.utc(2024, 9, 30, 14)},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = (elem['input'] as DateTimeUTCwithTZ).toLocalTime();
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("DateTimeTimezone.fromLocalTime:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : DateTime.utc(2024, 9, 30, 12), 'timezone': const Duration(), 'expectedOutput' : DateTimeUTCwithTZ(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezoneOffset: const Duration())},
      {'input' : DateTime.utc(2024, 9, 30, 14), 'timezone': const Duration(hours: 2), 'expectedOutput' : DateTimeUTCwithTZ(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezoneOffset: const Duration(hours: 2))},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']} timezone: ${elem['timezone']}', () {
        var _actual = DateTimeUTCwithTZ.fromLocalTime(elem['input'] as DateTime, timezone: elem['timezone'] as Duration);
        expect(_actual.dateTimeUtc, (elem['expectedOutput'] as DateTimeUTCwithTZ).dateTimeUtc);
        expect(_actual.timezoneOffset, (elem['expectedOutput'] as DateTimeUTCwithTZ).timezoneOffset);
      });
    }
  });
}