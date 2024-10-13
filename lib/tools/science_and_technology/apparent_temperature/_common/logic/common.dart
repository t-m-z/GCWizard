import 'dart:math';

import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/liljegren.dart';

enum TMRT {WIKIPEDIA, THORSSON, BERNARD, CLIMATCHIP}

enum CLOUD_COVER {
  CLEAR_0,
  FEW_1,
  FEW_2,
  SCATTERED_3,
  SCATTERED_4,
  BROKEN_5,
  BROKEN_6,
  BROKEN_7,
  OVERCAST_8,
  OBSCURED_9,
  NULL
}

Map<CLOUD_COVER, String> CLOUD_COVER_LIST = {
  CLOUD_COVER.CLEAR_0: 'weathersymbols_n_0',
  CLOUD_COVER.FEW_1: 'weathersymbols_n_1',
  CLOUD_COVER.FEW_2: 'weathersymbols_n_2',
  CLOUD_COVER.SCATTERED_3: 'weathersymbols_n_3',
  CLOUD_COVER.SCATTERED_4: 'weathersymbols_n_4',
  CLOUD_COVER.BROKEN_5: 'weathersymbols_n_5',
  CLOUD_COVER.BROKEN_6: 'weathersymbols_n_6',
  CLOUD_COVER.BROKEN_7: 'weathersymbols_n_7',
  CLOUD_COVER.OVERCAST_8: 'weathersymbols_n_8',
  CLOUD_COVER.OBSCURED_9: 'weathersymbols_n_9',
};

class CloudCoverConfig {
  final String image;
  final String title;
  final String subtitle;

  const CloudCoverConfig({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

const Map<CLOUD_COVER, CloudCoverConfig> CLOUD_COVER_MAP = {
  CLOUD_COVER.CLEAR_0: CloudCoverConfig(image: '0', title: 'weathersymbols_n_0', subtitle: ''),
  CLOUD_COVER.FEW_1: CloudCoverConfig(image: '1', title: 'weathersymbols_n_1', subtitle: ''),
  CLOUD_COVER.FEW_2: CloudCoverConfig(image: '2', title: 'weathersymbols_n_2', subtitle: ''),
  CLOUD_COVER.SCATTERED_3: CloudCoverConfig(image: '3', title: 'weathersymbols_n_3', subtitle: ''),
  CLOUD_COVER.SCATTERED_4: CloudCoverConfig(image: '4', title: 'weathersymbols_n_4', subtitle: ''),
  CLOUD_COVER.BROKEN_5: CloudCoverConfig(image: '5', title: 'weathersymbols_n_5', subtitle: ''),
  CLOUD_COVER.BROKEN_6: CloudCoverConfig(image: '6', title: 'weathersymbols_n_6', subtitle: ''),
  CLOUD_COVER.BROKEN_7: CloudCoverConfig(image: '7', title: 'weathersymbols_n_7', subtitle: ''),
  CLOUD_COVER.OVERCAST_8: CloudCoverConfig(image: '8', title: 'weathersymbols_n_8', subtitle: ''),
  CLOUD_COVER.OBSCURED_9: CloudCoverConfig(image: '9', title: 'weathersymbols_n_9', subtitle: ''),
};

Map<CLOUD_COVER, double> CLOUD_COVER_VALUE = {
  // https://geo.libretexts.org/Bookshelves/Meteorology_and_Climate_Science/Practical_Meteorology_(Stull)/06%3A_Clouds/6.05%3A_Sky_Cover_(Cloud_Amount)
  // https://earthscience.stackexchange.com/questions/16471/how-do-i-interpret-this-sky-cover-chart
  // sunny - clear - CLR - 1/8 or less - 0.000 to 0.125
  CLOUD_COVER.CLEAR_0: 0.0,
  // mostly sunny - mostly clear - FEW - 1/8 - 3/8 - 0.125 to 0.375
  CLOUD_COVER.FEW_1: 0.125,
  CLOUD_COVER.FEW_2: 0.250,
  // partly sunny - partly cloudy - SCT - 3/8 - 5/8 - 0.375 to 0.625
  CLOUD_COVER.SCATTERED_3: 0.375,
  CLOUD_COVER.SCATTERED_4: 0.500,
  // mostly cloudy - mostly cloudy - BKN - 5/8 - 7/8 - 0.625 to 0.875
  CLOUD_COVER.BROKEN_5: 0.625,
  CLOUD_COVER.BROKEN_6: 0.750,
  CLOUD_COVER.BROKEN_7: 0.875,
  // cloudy - cloudy - OVC - 7/8 - 9/8 - 0.875 to 1.000
  CLOUD_COVER.OVERCAST_8: 1.0,
  CLOUD_COVER.OBSCURED_9: 1.0,
};

// https://github.com/achristen/Solar-Irradiance-Calculations-IDL/blob/master/rad_solar_constant.pro
// ;   Calculates the current solar irradiance at top of the atmosphere
// ;   perpendicular to sun rays in W / m2 using the solar constant and correcting
// ;   for the changing distance Earth-Sun.
//
// function rad_solar_constant, julian_time_utc
//
//    solar_constant_av = 1366.5 ; W m^-2
//
//    ; **************************************************
//    ; calculate fractional year in radians
//    ; **************************************************
//
//    caldat, julian_time_utc, month, day, year
//    d_julian_utc = dat_dat2doy(day,month,year)
//    frac_year = (d_julian_utc) * 2 * !pi / 365
//
//    ; **************************************************
//    ; calculate ratio (squared) of average radius
//    ; Earth-Sun to actual radius Earth-Sun (R_av / R)^2
//    ; **************************************************
//
//     ratio_squared = 1.00011 + 0.034221 * cos(frac_year) + 0.001280 * sin(frac_year) + 0.000719 * cos(2*frac_year) + 0.000077 * sin(2*frac_year)
//     i0 = ratio_squared * solar_constant_av
//     return, i0
//
// end


double calculateSolarIrradiance({double solarElevationAngleOld = 0.0, double solarElevationAngleNew = 0.0, required CLOUD_COVER cloudcover}) {
  // https://scool.larc.nasa.gov/lesson_plans/CloudCoverSolarRadiation.pdf#:~:text=There%20is%20a%20simple%20formula%20to%20predict%20how,%280%25%20no%20clouds%29%20to%201.0%20%28100%25%20complete%20coverage%29.
  // https://web.archive.org/web/20240920192708/https://scool.larc.nasa.gov/lesson_plans/CloudCoverSolarRadiation.pdf#:~:text=There%20is%20a%20simple%20formula%20to%20predict%20how,%280%25%20no%20clouds%29%20to%201.0%20%28100%25%20complete%20coverage%29

  // http://www.shodor.org/os411/courses/_master/tools/calculators/solarrad/
  // https://web.archive.org/web/20240920193138/http://www.shodor.org/os411/courses/_master/tools/calculators/solarrad/
  double R0 = 990 * sin((solarElevationAngleOld + solarElevationAngleNew) / 2 * pi / 180) - 30;
  double cloudCoverFraction = CLOUD_COVER_VALUE[cloudcover]!;
  return R0 * (1.0 - 0.75 * pow(cloudCoverFraction, 3.4));
}

double calculateDewPoint({
  required double tair, // temperature in °C
  required double rh,
} // relative humidity in %
) {
  // https://energie-m.de/tools/taupunkt.html
  // https://myscope.net/taupunkttemperatur/
  // https://web.archive.org/web/20240920213646/https://myscope.net/taupunkttemperatur/
  double log10(double x) {
    return log(x) / log(10);
  }

  var mw = 18.016; // Molekulargewicht des Wasserdampfes (kg/kmol)
  var gk = 8214.3; // universelle Gaskonstante (J/(kmol*K))
  var t0 = 273.15; // Absolute Temperatur von 0 °C (Kelvin)
  var tk = tair + t0; // Temperatur in Kelvin

  double a = 0;
  double b = 0;

  if (tair >= 0) {
    a = 7.5;
    b = 237.3;
  } else if (tair < 0) {
    a = 7.6;
    b = 240.7;
  }

  // Sättigungsdampfdruck (hPa)
  double sdd = 6.1078 * pow(10, (a * tair) / (b + tair));

  // Dampfdruck (hPa)
  double dd = sdd * (rh / 100);

  // Wasserdampfdichte bzw. absolute Feuchte (g/m3)
  double af = pow(10, 5) * mw / gk * dd / tk;

  // v-Parameter
  double v = log10(dd / 6.1078);

  return (b * v) / (a - v);
}

double _fTmrtB({
  required double Tg, // globe temperature (°C)
  required double va, // air velocity at the level of the globe (m/s)
  required double Ta, // air temperature (°C)
}
) {
  double WF = 0.0;
  double WF1 = 0.4 * pow((Tg - Ta).abs(), 0.25);
  double WF2 = 2.5 * pow(va, 0.6);
  (WF1 > WF2) ? WF = WF1 : WF = WF2;
  return  100 * pow(pow((Tg + 273) / 100, 4) + WF * (Tg - Ta), 0.25) - 273;
}

double calculateMeanRadiantTemperature({
  required double Tg, // globe temperature (°C)
  required double va, // air velocity at the level of the globe (m/s)
  double e = 0.95, // emissivity of the globe (no dimension) - Standard: 0.95
  double D = 0.15, // diameter of the globe (m) - Standard: 0.15
  required double Ta, // air temperature (°C)
  double solar = -99,
  TMRT tmrtFormula = TMRT.CLIMATCHIP,
}) {
  double MRT = 0.0;

  switch (tmrtFormula) {
    case TMRT.WIKIPEDIA:
    // https://en.wikipedia.org/wiki/Mean_radiant_temperature
      MRT =   pow(pow(Tg + 273.15, 4) + 1.100 * 100000000 * pow(va, 0.60) * (Tg - Ta) / e / pow(D, 0.4), 0.25) - 273.15;
      break;
    case TMRT.THORSSON:
    // Sofia Thorsson calculation
      MRT =  pow(pow(Tg + 273.15, 4) + 1.335 * pow(va, 0.71) * (Tg - Ta) / (e * pow(D, 0.4)) * 100000000, 0.25) - 273.15;
      break;
    case TMRT.BERNARD:
    // Bernard calculation
      double WF = 0.0;
      double WF1 = 0.4 * pow((Tg - Ta).abs(), 0.25);
      double WF2 = 2.5 * pow(va, 0.6);
      (WF1 > WF2) ? WF = WF1 : WF = WF2;
      MRT =  100 * pow(pow((Tg + 273) / 100, 4) + WF * (Tg - Ta), 0.25) - 273;
      break;
    case TMRT.CLIMATCHIP:
      // Calculation from https://climatechip.org/excel-wbgt-calculator
      double propDirect = 0.8;
      double ZenithAngle = 0.5;
      if (solar <= 0) {
        MRT = _fTmrtB(Ta: Ta, Tg: Tg, va: va);
      }
      else if (Tg <= 0) {
        //Use the solar to get the globe temperature (Liljegren) then use the globe temperature to get MRT using Bernard’s formula
        double RH = 60.0; //assume a value - not very sensitive to RH
        double Tg = Tglobe(
            Tair: Ta,
            rh: RH,
            Pair: 1013.25,
            speed: va,
            solar: solar,
            fdir: propDirect,
            cza: ZenithAngle,
        );
        print(Tg);
        MRT = _fTmrtB(Ta: Ta, Tg: Tg, va: va);
      }
      break;
  }

  return MRT;
}

double calculateGlobeTemperature({
  required double Ta, // T ambient in °C
  required double Td, // T DewPoint in C°
  required double P, // Barometric pressure
  required double u, // Wind speed in m/s
  required double S, // Solar irridiance in W/m/m
  required double fdb, // direct beam radiation from the sun
  required double fdif, // diffuse radiation from the sun
  required double cza, // Zenith angle in radians
}
) {
  // https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
  // https://web.archive.org/web/20240920214629/https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
  const h = 0.315;
  final sb = 5.67 * pow(10, -8);

  double ea =
      exp(17.67 * (Td - Td) / (Td + 243.5)) * (1.0007 + 0.00000346 * P) * 6.112 * exp(17.502 * Ta / (240.97 + Ta));
  double epsilona = 0.575 * pow(ea, 1 / 7);

  double B = S * (fdb / 4 / sb / cza + 1.2 / sb * fdif) + epsilona * pow(Ta, 4);
  double C = h * pow(u, 0.58) / (5.3865 * pow(10, -8));

  return (B + C * Ta + 7680000) / (C + 256000);
}

double calculateVaporPressure(
    double temperature  // °C
    ) {
  // https://www.weather.gov/media/epz/wxcalc/vaporPressure.pdf
  // https://web.archive.org/web/20240927172834/https://www.weather.gov/media/epz/wxcalc/vaporPressure.pdf
  // temperature = tair => es = Vapor pressure saturated
  // temperature = tdew => e = Vapor pressure actual
  return 6.11 * pow(10, (7.5 * temperature / (237.3 + temperature)));
}

double calculateRelativeHumidityFromTairTdew(
    double tair, // °C
    double tdew  // °C
    ) {
  // https://www.weather.gov/media/epz/wxcalc/vaporPressure.pdf
  // https://web.archive.org/web/20240927172834/https://www.weather.gov/media/epz/wxcalc/vaporPressure.pdf
  return pow(10, (7.5 * tdew / (237.3 + tdew))) / pow(10, (7.5 * tair / (237.3 + tair))) * 100;
}

