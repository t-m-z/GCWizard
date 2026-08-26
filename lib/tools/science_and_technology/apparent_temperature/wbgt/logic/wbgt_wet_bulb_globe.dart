part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';



/// Iterative solvers for the natural/psychrometric wet-bulb temperature and
/// the globe temperature.
///
/// Ported from `Twb` and `Tglobe` in Liljegren's `wbgt.c`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.c).

/// Calculates the natural wet-bulb temperature ([withRadiativeHeating] =
/// true) or the psychrometric wet-bulb temperature ([withRadiativeHeating]
/// = false), degC.
///
/// [tempK] is the air (dry bulb) temperature, K; [rh] is relative humidity
/// as a fraction between 0 and 1; [pressureMb] is barometric pressure, mb;
/// [speedMs] is wind speed, m/s; [solarWm2] is solar irradiance, W/m^2;
/// [fdir] is the fraction of solar irradiance due to the direct beam; [cza]
/// is the cosine of the solar zenith angle.
///
/// Returns `null` if the iteration fails to converge.
double? _naturalOrPsychrometricWetBulbC({
  required double tempK,
  required double rh,
  required double pressureMb,
  required double speedMs,
  required double solarWm2,
  required double fdir,
  required double cza,
  required bool withRadiativeHeating,
}) {
  const a = 0.56; // from Bedingfield and Drew
  final radiative = withRadiativeHeating ? 1.0 : 0.0;

  final tsfc = tempK;
  final sza = math.acos(cza); // solar zenith angle, radians
  final eair = rh * _saturationVaporPressure(tempK);
  final tdew = _dewOrFrostPoint(eair);

  var twbPrev = tdew; // first guess is the dew point temperature
  var twbNew = twbPrev;
  var converged = false;
  var iter = 0;

  do {
    iter++;
    final tref = 0.5 * (twbPrev + tempK); // properties at the average temperature
    final h = _convectiveCoefficientCylinder(
      diameterM: _dWick,
      lengthM: _lWick,
      tempK: tref,
      pressureMb: pressureMb,
      speedMs: speedMs,
    );
    final fatm = _stefanBoltzmann *
        _emisWick *
        (0.5 * (_atmosphericEmissivity(tempK, rh) * _dpow(tempK, 4.0) + _emisSfc * _dpow(tsfc, 4.0)) -
            _dpow(twbPrev, 4.0)) +
        (1.0 - _albWick) *
            solarWm2 *
            ((1.0 - fdir) * (1.0 + 0.25 * _dWick / _lWick) +
                fdir * ((math.tan(sza) / math.pi) + 0.25 * _dWick / _lWick) +
                _albSfc);
    final ewick = _saturationVaporPressure(twbPrev);
    final density = pressureMb * 100.0 / (_rAir * tref);
    final sc = _airViscosity(tref) / (density * _waterVaporDiffusivity(tref, pressureMb));
    twbNew = tempK -
        _heatOfEvaporation(tref) / _ratioCpM * (ewick - eair) / (pressureMb - ewick) * _dpow(_prandtl / sc, a) +
        (fatm / h * radiative);
    if ((twbNew - twbPrev).abs() < _convergence) converged = true;
    twbPrev = 0.9 * twbPrev + 0.1 * twbNew;
  } while (!converged && iter < _maxIter);

  return converged ? (twbNew - 273.15) : null;
}

/// Calculates the globe temperature, degC.
///
/// [tempK] is the air (dry bulb) temperature, K; [rh] is relative humidity
/// as a fraction between 0 and 1; [pressureMb] is barometric pressure, mb;
/// [speedMs] is wind speed, m/s; [solarWm2] is solar irradiance, W/m^2;
/// [fdir] is the fraction of solar irradiance due to the direct beam; [cza]
/// is the cosine of the solar zenith angle.
///
/// Returns `null` if the iteration fails to converge.
double? _globeTemperatureC({
  required double tempK,
  required double rh,
  required double pressureMb,
  required double speedMs,
  required double solarWm2,
  required double fdir,
  required double cza,
}) {
  final tsfc = tempK;
  var tGlobePrev = tempK; // first guess is the air temperature
  var tGlobeNew = tGlobePrev;
  var converged = false;
  var iter = 0;

  do {
    iter++;
    final tref = 0.5 * (tGlobePrev + tempK); // properties at the average temperature
    final h = _convectiveCoefficientSphere(
      diameterM: _dGlobe,
      tempK: tref,
      pressureMb: pressureMb,
      speedMs: speedMs,
    );
    tGlobeNew = _dpow(
      0.5 * (_atmosphericEmissivity(tempK, rh) * _dpow(tempK, 4.0) + _emisSfc * _dpow(tsfc, 4.0)) -
          h / (_stefanBoltzmann * _emisGlobe) * (tGlobePrev - tempK) +
          solarWm2 /
              (2.0 * _stefanBoltzmann * _emisGlobe) *
              (1.0 - _albGlobe) *
              (fdir * (1.0 / (2.0 * cza) - 1.0) + 1.0 + _albSfc),
      0.25,
    );
    if ((tGlobeNew - tGlobePrev).abs() < _convergence) converged = true;
    tGlobePrev = 0.9 * tGlobePrev + 0.1 * tGlobeNew;
  } while (!converged && iter < _maxIter);

  return converged ? (tGlobeNew - 273.15) : null;
}