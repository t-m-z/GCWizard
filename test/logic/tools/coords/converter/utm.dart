import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group("Parser.utm.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '35 T 391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T W 391892.0 N 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T mW 391892.0 mN 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T m W 391892.0 m N 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35TmW391892mN5118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35TW391892N5118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},

      {'text': '35T 391892.0 W 5118448.0002 N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 mW 5118448.0002 mN', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 m W 5118448.0002 m N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892mW5118448mN', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892W5118448N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},

      {'text': '35T3918925118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T5701685650300', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(50.83043359228835, 27.99948922153779)}},

    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = UTMREF.parse(elem['text'])?.toLatLng(ells: ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });
}