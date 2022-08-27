import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/humidex.dart';

void main() {
  group("humidex.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'temperature' : 0.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : true, 'expectedOutput' : '-5.556'},
      {'temperature' : 27.0, 'humidity' : 40.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : true, 'expectedOutput' : '29.364'},
      {'temperature' : 27.0, 'humidity' : 100.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : true, 'expectedOutput' : '41.243'},
      {'temperature' : 45.0, 'humidity' : 40.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : true, 'expectedOutput' : '60.703'},
      {'temperature' : 45.0, 'humidity' : 100.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : true, 'expectedOutput' : '92.590'},
      {'temperature' : 30.0, 'humidity' : 15.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : false, 'expectedOutput' : '33.988'},
      {'temperature' : 30.0, 'humidity' : 25.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'isHumidity' : false, 'expectedOutput' : '42.375'},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}, temperatureUnit: ${elem['temperatureUnit'].symbol}, isHumidity: ${elem['isHumidity']}', () {
        var _actual = calculateHumidex(elem['temperature'], elem['humidity'], elem['temperatureUnit'], elem['isHumidity']);
        expect(_actual.toStringAsFixed(3), elem['expectedOutput']);
      });
    });
  });
}
