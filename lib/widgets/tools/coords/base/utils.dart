import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:prefs/prefs.dart';

Map<String, String> defaultCoordFormat() {
  var format = Prefs.get(PREFERENCE_COORD_DEFAULT_FORMAT);
  var subtype = Prefs.get(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE);

  var subtypeChanged = false;
  switch (format) {
    case keyCoordsGaussKrueger:
      if (![
        keyCoordsGaussKruegerGK1,
        keyCoordsGaussKruegerGK2,
        keyCoordsGaussKruegerGK3,
        keyCoordsGaussKruegerGK4,
        keyCoordsGaussKruegerGK5
      ].contains(subtype)) {
        subtype = keyCoordsGaussKruegerGK1;
        subtypeChanged = true;
      }
      break;
    case keyCoordsSlippyMap:
      if (int.tryParse(subtype) == null) {
        subtype = '10';
        subtypeChanged = true;
      }
      break;
  }

  if (subtypeChanged) {
    Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, subtype);
  }

  return {'format': format, 'subtype': subtype};
}

int defaultHemiphereLatitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE) == HemisphereLatitude.North.toString() ? 1 : -1;
}

int defaultHemiphereLongitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE) == HemisphereLongitude.East.toString() ? 1 : -1;
}

Ellipsoid defaultEllipsoid() {
  String type = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE);

  if (type == EllipsoidType.STANDARD.toString()) {
    return getEllipsoidByName(Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME));
  }

  if (type == EllipsoidType.USER_DEFINED.toString()) {
    double a = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A);
    double invf = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF);
    return Ellipsoid(null, a, invf, type: EllipsoidType.USER_DEFINED);
  }
}
