import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/triangles/_common/logic/ellipsoid_triangle.dart';
import 'package:gc_wizard/tools/coords/triangles/special_points/napoleon/logic/ellipsoidtriangle_napoleon.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../science_and_technology/euclidic_triangle/logic/triangle_test_utils.dart';

void main() async {
  group("triangle.calculateEllipsoidTriangleNapoleonPoints:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'inputA': LatLng(0, 0), 'inputB': LatLng(0, 0), 'inputC': LatLng(0, 0),
        'expectedOutput': <LatLng>[]},
      {'inputA': LatLng(1, 1), 'inputB': LatLng(1, 1), 'inputC': LatLng(1, 1),
        'expectedOutput': <LatLng>[]},
      {'inputA': LatLng(1, 1), 'inputB': LatLng(2, 2), 'inputC': LatLng(3, 3),
        'expectedOutput': [LatLng(1.8067175752448756, 2.1910355243659287), LatLng(2.1940089340049655, 1.8083806117294263)]},
      {'inputA': LatLng(0, 0), 'inputB': LatLng(0, 3), 'inputC': LatLng(4, 0),
        'expectedOutput': [LatLng(1.0017633038742462, 0.923838893744496), LatLng(2.4196373548673815, 0.7587605025686457)]},
      {'inputA': LatLng(40, 9), 'inputB': LatLng(42, 9), 'inputC': LatLng(38, 8),
        'expectedOutput': [LatLng(39.98307901648059, 9.146762265852246), LatLng(40.186579294479365, 8.171469831092255)]},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['inputA']} ${elem['inputB']} ${elem['inputC']}', () {
        var triangle = EllipsoidTriangle(elem['inputA'] as LatLng, elem['inputB'] as LatLng, elem['inputC'] as LatLng, Ellipsoid.WGS84);
        var _actual = calculateEllipsoidTriangleNapoleonPoints(triangle, Ellipsoid.WGS84);
        expect(_actual.length, (elem['expectedOutput'] as List<LatLng>).length);

        if (_actual.isNotEmpty) {
          latLngListTest([_actual.first.centerpoint, _actual.last.centerpoint], elem['expectedOutput'] as List<LatLng>);
        }
      });
    }
  });
}