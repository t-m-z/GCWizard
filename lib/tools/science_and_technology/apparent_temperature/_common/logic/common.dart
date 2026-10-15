import 'dart:math';


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
