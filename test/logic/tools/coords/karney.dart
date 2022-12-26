
import 'dart:math';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/antipodes.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/external_libs/net.sf.geographiclib/geodesic.dart';
import 'package:gc_wizard/logic/tools/coords/external_libs/net.sf.geographiclib/geodesic_data.dart';
import 'package:gc_wizard/logic/tools/coords/vincenty/distance_bearing_vincenty.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong2/latlong.dart';

import 'utils.dart';

void main() {

  group("Karney VS Vincenty:", () {
    var lats = [-90.0, -67.5, -45.0, -22.5, 0.0, 22.5, 45.0, 67.5, 90.0];
    var lons = [-180.0, -135.0, -90.0, -45.0, 0.0, 45.0, 90.0, 135.0, 180.0];

    var ellipsoid = getEllipsoidByName(ELLIPSOID_NAME_WGS84);

    var countErrors = 0;

    for (var lat1 in lats) {
      for (var lon1 in lons) {
        var coord1 = LatLng(lat1, lon1);
        for (var lat2 in lats) {
          for (var lon2 in lons) {
            var coord2 = LatLng(lat2, lon2);

            try {
              // Karney
              GeodesicData karney = Geodesic(ellipsoid.a, ellipsoid.f).inverse(coord1.latitude, coord1.longitude, coord2.latitude, coord2.longitude);

              // Vincenty
              DistanceBearingData vincenty = vincentyInverse(
                  coord1, coord2, ellipsoid);

              var karneyAzi1 = normalizeBearing(karney.azi1);
              var karneyAzi2 = normalizeBearing(karney.azi2 + 180.0);

              var vincentyAzi1 = normalizeBearing(vincenty.bearingAToB);
              var vincentyAzi2 = normalizeBearing(vincenty.bearingBToA);

              if (!doubleEquals(karney.s12, vincenty.distance, tolerance: 1e-4) ||
                  !doubleEquals(karneyAzi1, vincentyAzi1, tolerance: 1e-4) ||
                  !doubleEquals(karneyAzi2, vincentyAzi2, tolerance: 1e-4)
              ) {
                if (equalsLatLng(coord1, coord2) && doubleEquals(karney.s12, 0.0)
                    || (coord1.latitude.abs() == 90.0 && coord2.latitude.abs() == 90.0) && doubleEquals(karney.s12, 20003931.4586255, tolerance: 1e-3)
                )
                  continue;

                var antipode = antipodes(coord1);
                if (equalsLatLng(coord2, antipode) && doubleEquals(karney.s12, 20003931.45862552, tolerance: 1e-3))
                  continue;

                countErrors++;

                print('==============================');
                print('A:');
                print(coord1);
                print('B:');
                print(coord2);
                print('Dist Karney: ${karney.s12} vs Vincenty: ${vincenty.distance}');
                print('AzAB Karney: ${karneyAzi1} vs Vincenty: ${vincentyAzi1}');
                print('AzBA Karney: ${karneyAzi2} vs Vincenty: ${vincentyAzi2}');
              }
            } catch(e) {
              print('= ERROR ========================');
              print('A:');
              print(coord1);
              print('B:');
              print(coord2);
              print(e);
            }
          }
        }
      }
    }

    test('errors', () {
      expect(countErrors, 0);
    });
  });

  group("Karney VS Vincenty RANDOM:", () {
    var ellipsoid = getEllipsoidByName(ELLIPSOID_NAME_WGS84);

    var countErrors = 0;

    for (int i = 0; i < 1000000; i++) {
      var rand = Random();
      var coord1 = LatLng(rand.nextDouble() * 180.0 - 90.0, rand.nextDouble() * 360.0 - 180.0);
      var coord2 = LatLng(rand.nextDouble() * 180.0 - 90.0, rand.nextDouble() * 360.0 - 180.0);

      try {
        // Karney
        GeodesicData karney = Geodesic(ellipsoid.a, ellipsoid.f).inverse(coord1.latitude, coord1.longitude, coord2.latitude, coord2.longitude);

        // Vincenty
        DistanceBearingData vincenty = vincentyInverse(coord1, coord2, ellipsoid);

        var karneyAzi1 = normalizeBearing(karney.azi1);
        var karneyAzi2 = normalizeBearing(karney.azi2 + 180.0);

        var vincentyAzi1 = normalizeBearing(vincenty.bearingAToB);
        var vincentyAzi2 = normalizeBearing(vincenty.bearingBToA);

        if (!doubleEquals(karney.s12, vincenty.distance, tolerance: 1e-2) ||
            !doubleEquals(karneyAzi1, vincentyAzi1, tolerance: 1e-2) ||
            !doubleEquals(karneyAzi2, vincentyAzi2, tolerance: 1e-2)
        ) {
          if (equalsLatLng(coord1, coord2) && doubleEquals(karney.s12, 0.0)
              || (coord1.latitude.abs() == 90.0 && coord2.latitude.abs() == 90.0) && doubleEquals(karney.s12, 20003931.4586255, tolerance: 1e-3)
          )
            continue;

          // var antipode = antipodes(coord1);
          // if (equalsLatLng(coord2, antipode) && doubleEquals(karney.s12, 20003931.45862552, tolerance: 1e-3))
          //   continue;

          countErrors++;

          print('==============================');
          print('A:');
          print(coord1);
          print('B:');
          print(coord2);
          print('Dist Karney: ${karney.s12} vs Vincenty: ${vincenty.distance}');
          print('AzAB Karney: ${karneyAzi1} vs Vincenty: ${vincentyAzi1}');
          print('AzBA Karney: ${karneyAzi2} vs Vincenty: ${vincentyAzi2}');
        }
      } catch(e) {
        print('= ERROR ========================');
        print('A:');
        print(coord1);
        print('B:');
        print(coord2);
        print(e);
      }
    }
    test('errors', () {
      expect(countErrors, 0);
    });
  });

  group("Karney Direct VS Inverse:", () {
    var lats = [-90.0, -67.5, -45.0, -22.5, 0.0, 22.5, 45.0, 67.5, 90.0];
    var lons = [-180.0, -135.0, -90.0, -45.0, 0.0, 45.0, 90.0, 135.0, 180.0];

    int countErrors = 0;

    var ellipsoid = getEllipsoidByName(ELLIPSOID_NAME_WGS84);

    for (var lat1 in lats) {
      for (var lon1 in lons) {
        var coord1 = LatLng(lat1, lon1);
        for (var lat2 in lats) {
          for (var lon2 in lons) {
            var coord2 = LatLng(lat2, lon2);

            try {
              // Karney
              GeodesicData karney = Geodesic(ellipsoid.a, ellipsoid.f).inverse(coord1.latitude, coord1.longitude, coord2.latitude, coord2.longitude);

              var karneyAzi1 = normalizeBearing(karney.azi1);
              var karneyAzi2 = normalizeBearing(karney.azi2 + 180.0);

              GeodesicData karneyB = Geodesic(ellipsoid.a, ellipsoid.f).direct(coord1.latitude, coord1.longitude, karneyAzi1, karney.s12);
              LatLng calcB = LatLng(karneyB.lat2, karneyB.lon2);
              GeodesicData karneyA = Geodesic(ellipsoid.a, ellipsoid.f).direct(coord2.latitude, coord2.longitude, karneyAzi2, karney.s12);
              LatLng calcA = LatLng(karneyA.lat2, karneyA.lon2);

              if (!equalsLatLng(calcB, coord2))
              {
                countErrors++;
                print('A -> B ==============================');
                print('A:');
                print(coord1);
                print('B:');
                print(coord2);
                print('Distance:');
                print(karney.s12);
                print('Azi1:');
                print(karneyAzi1);
                print('Azi2:');
                print(karneyAzi2);
                print('Calc:');
                print(calcB);
                print('Exp:');
                print(coord2);
              }

              if (!equalsLatLng(calcA, coord1))
              {
                countErrors++;
                print('B -> A ==============================');
                print('A:');
                print(coord1);
                print('B:');
                print(coord2);
                print('Distance:');
                print(karney.s12);
                print('Azi1:');
                print(karneyAzi1);
                print('Azi2:');
                print(karneyAzi2);
                print('Calc:');
                print(calcA);
                print('Exp:');
                print(coord1);
              }
            } catch(e) {
              print('= ERROR ========================');
              print('A:');
              print(coord1);
              print('B:');
              print(coord2);
              print(e);
            }
          }
        }
      }
    }

    test('errors', () {
      expect(countErrors, 0);
    });
  });

  group("Karney Direct VS Inverse - RANDOM:", () {
    var ellipsoid = getEllipsoidByName(ELLIPSOID_NAME_WGS84);

    int countErrors = 0;

    for (int i = 0; i < 1000000; i++) {
      var rand = Random();
      var coord1 = LatLng(rand.nextDouble() * 180.0 - 90.0, rand.nextDouble() * 360.0 - 180.0);
      var coord2 = LatLng(rand.nextDouble() * 180.0 - 90.0, rand.nextDouble() * 360.0 - 180.0);

      if (i % 10000 == 0) {
        print(i);
        print(coord1);
        print(coord2);
      }

      try {
        // Karney
        GeodesicData karney = Geodesic(ellipsoid.a, ellipsoid.f).inverse(coord1.latitude, coord1.longitude, coord2.latitude, coord2.longitude);

        var karneyAzi1 = normalizeBearing(karney.azi1);
        var karneyAzi2 = normalizeBearing(karney.azi2 + 180.0);

        GeodesicData karneyB = Geodesic(ellipsoid.a, ellipsoid.f).direct(coord1.latitude, coord1.longitude, karneyAzi1, karney.s12);
        LatLng calcB = LatLng(karneyB.lat2, karneyB.lon2);
        GeodesicData karneyA = Geodesic(ellipsoid.a, ellipsoid.f).direct(coord2.latitude, coord2.longitude, karneyAzi2, karney.s12);
        LatLng calcA = LatLng(karneyA.lat2, karneyA.lon2);

        if (!equalsLatLng(calcB, coord2)) {
          countErrors++;
          print('A -> B ==============================');
          print('A:');
          print(coord1);
          print('B:');
          print(coord2);
          print('Distance:');
          print(karney.s12);
          print('Azi1:');
          print(karneyAzi1);
          print('Azi2:');
          print(karneyAzi2);
          print('Calc:');
          print(calcB);
          print('Exp:');
          print(coord2);
        }

        if (!equalsLatLng(calcA, coord1)) {
          countErrors++;
          print('B -> A ==============================');
          print('A:');
          print(coord1);
          print('B:');
          print(coord2);
          print('Distance:');
          print(karney.s12);
          print('Azi1:');
          print(karneyAzi1);
          print('Azi2:');
          print(karneyAzi2);
          print('Calc:');
          print(calcA);
          print('Exp:');
          print(coord1);
        }
      } catch (e) {
        print('= ERROR ========================');
        print('A:');
        print(coord1);
        print('B:');
        print(coord2);
        print(e);
      }
    }

    test('errors', () {
      expect(countErrors, 0);
    });
  });
}