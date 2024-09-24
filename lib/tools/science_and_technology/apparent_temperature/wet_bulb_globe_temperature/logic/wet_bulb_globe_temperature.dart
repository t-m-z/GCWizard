// https://ksi.uconn.edu/prevention/wet-bulb-globe-temperature-monitoring/
//
// https://www.researchgate.net/profile/Thieres-Silva/publication/261706490_Estimating_Black_Globe_Temperature_Based_on_Meteorological_Data/links/00b7d535176fd08364000000/Estimating-Black-Globe-Temperature-Based-on-Meteorological-Data.pdf?origin=publication_detail
//
//
// https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
// https://web.archive.org/web/20240825174718/https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
//
// https://climatechip.org/excel-wbgt-calculator
// https://web.archive.org/web/20240825152849/https://climatechip.org/excel-wbgt-calculator
//
// https://wbgt.app/
//
// https://www.osha.gov/heat-exposure/wbgt-calculator
// https://web.archive.org/web/20240825152957/https://www.osha.gov/heat-exposure/wbgt-calculator
//
// https://raw.githubusercontent.com/mdljts/wbgt/master/src/wbgt.c.original
// https://github.com/mdljts/wbgt

import 'dart:core';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/common.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/julian_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/logic/sun_position.dart' as sunposition;
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/liljegren.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';

enum WBGT_HEATSTRESS_CONDITION { WHITE, GREEN, YELLOW, RED, BLACK }

final Map<WBGT_HEATSTRESS_CONDITION, double> WBGT_HEAT_STRESS = {
  // https://en.wikipedia.org/wiki/Wet-bulb_globe_temperature
  WBGT_HEATSTRESS_CONDITION.WHITE: 27.7, // max value
  WBGT_HEATSTRESS_CONDITION.GREEN: 29.4, // max value
  WBGT_HEATSTRESS_CONDITION.YELLOW: 31.0, // max value
  WBGT_HEATSTRESS_CONDITION.RED: 32.1, // max value
};

class WBGTOutput {
  final int Status;
  final double Solar;
  final double Tg;
  final double Tnwb;
  final double Tpsy;
  final double Twbg;
  final double Tdew;
  final double Tmrt;
  final sunposition.SunPosition SunPos;

  WBGTOutput(
      {this.Status = 0,
      this.Solar = 0.0,
      this.Tg = 0.0,
      this.Tnwb = 0.0,
      this.Tpsy = 0.0,
      this.Twbg = 0.0,
      this.Tdew = 0.0,
      this.Tmrt = 0.0,
      required this.SunPos});
}

WBGTOutput calculateWetBulbGlobeTemperature(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int gmt,
    LatLng coords,
    double windSpeed,
    double windSpeedHeight,
    double temperature,
    double humidity,
    double airPressure,
    bool urban,
    CLOUD_COVER cloudcover) {
  var sunPosition = sunposition.SunPosition(
      LatLng(coords.latitude, coords.longitude),
      JulianDate(
          DateTimeTimezone(datetime: DateTime(year, month, day, hour - 1, minute), timezone: Duration(hours: gmt))),
      const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563));
  // var sunPositionNew = sunposition.SunPosition(
  //     LatLng(coords.latitude, coords.longitude),
  //     JulianDate(DateTimeTimezone(datetime: DateTime(year, month, day, hour, minute), timezone: Duration(hours: gmt))),
  //     const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563));
  //
  // double solar = calculateSolarIrradiance(
  //     solarElevationAngleOld: sunPositionOld.altitude,
  //     solarElevationAngleNew: sunPositionNew.altitude,
  //     cloudcover: cloudcover);
  // print(
  //     'calculateSolarIrradiance --------------------------------------------------------------------------------------');
  // print(solar);
  // print(sunPositionNew.altitude);
  // print(sunPositionNew.azimuth);

  liljegrenOutputWBGT WBGT = calc_wbgt(
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    gmt: gmt,
    avg: 0,
    urban: urban ? 1 : 0,
    lat: coords.latitude,
    lon: coords.longitude,
    pres: airPressure,
    Tair: temperature,
    relhum: humidity,
    speed: windSpeed,
    zspeed: windSpeedHeight,
    dT: 0,
    //solar: solar,
  );

  if (WBGT.Status != 0) {
    return WBGTOutput(Status: -1, SunPos: sunPosition);
  }

  double Tmrt = calculateMeanRadiantTemperature(
    Tg: WBGT.Tg,
    va: windSpeed,
    e: 0.95,
    D: 0.15,
    Ta: temperature,
  );

  return WBGTOutput(
      Status: 0, Twbg: WBGT.Twbg, Solar: WBGT.solar, Tdew: WBGT.Tdew, Tg: WBGT.Tg, Tmrt: Tmrt, SunPos: sunPosition);
}
