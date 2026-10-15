part of 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';



/// Physical, astronomical, and model-tuning constants used throughout the
/// WBGT calculation.
///
/// Ported from `DEG_RAD`/`RAD_DEG`/etc. in Liljegren's `wbgt.h`
/// (https://github.com/t-m-z/wbgt/blob/dev/src/wbgt.h).


/// Degrees to radians.
const double _degRad = math.pi / 180.0;

/// Radians to degrees.
const double _radDeg = 180.0 / math.pi;

/// Two pi, for convenience.
const double _twoPi = 2 * math.pi;

/// Solar constant, W/m^2.
const double _solarConst = 1367.0;

/// Stefan-Boltzmann constant, W/(m^2 K^4).
const double stefanBoltzmann = 5.6696e-8;

/// Specific heat of air at constant pressure, J/(kg K).
const double _cpAir = 1003.5;

/// Molecular weight of dry air, g/mol.
const double _mAir = 28.97;

/// Molecular weight of water, g/mol.
const double _mH2o = 18.015;

/// Cp * M_AIR / M_H2O, used in the wet-bulb energy balance.
const double _ratioCpM = _cpAir * _mAir / _mH2o;

/// Universal gas constant, J/(kmol K).
const double _rGas = 8314.34;

/// Gas constant for dry air, J/(kg K).
const double _rAir = _rGas / _mAir;

/// Prandtl number of air.
const double _prandtl = _cpAir / (_cpAir + 1.25 * _rAir);

/// Wick (natural/psychrometric wet-bulb sensor) emissivity.
const double _emisWick = 0.95;

/// Wick albedo.
const double _albWick = 0.4;

/// Wick diameter, m.
const double _dWick = 0.007;

/// Wick length, m.
const double _lWick = 0.0254;

/// Globe thermometer emissivity.
const double emisGlobe = 0.95;

/// Globe thermometer albedo.
const double _albGlobe = 0.05;

/// Globe thermometer diameter, m.
const double dGlobe = 0.0508;

/// Surface emissivity.
const double _emisSfc = 0.999;

/// Surface albedo.
const double _albSfc = 0.45;

/// Minimum cosine of solar zenith angle for which the sun is considered to
/// be above the horizon.
const double _czaMin = 0.00873;

/// Maximum plausible ratio of measured/estimated solar irradiance to
/// top-of-atmosphere irradiance.
const double _normsolarMax = 0.85;

/// Reference height for wind speed measurements/estimates, m.
const double _refHeight = 2.0;

/// Minimum wind speed used in convective heat transfer calculations, m/s.
const double _minSpeed = 0.13;

/// Convergence threshold for the iterative wet-bulb/globe solvers, K.
const double _convergence = 0.02;

/// Maximum number of iterations for the iterative wet-bulb/globe solvers.
const int _maxIter = 1000;