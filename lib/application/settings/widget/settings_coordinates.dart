import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/default_settings.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_sign_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:prefs/prefs.dart';

part 'package:gc_wizard/application/settings/widget/ellipsoid_picker.dart';

class CoordinatesSettings extends StatefulWidget {
  const CoordinatesSettings({Key? key}) : super(key: key);

  @override
 _CoordinatesSettingsState createState() => _CoordinatesSettingsState();
}

class _CoordinatesSettingsState extends State<CoordinatesSettings> {
  late CoordinateFormat _currentDefaultFormat;
  var _currentDefaultHemisphereLatitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE);
  var _currentDefaultHemisphereLongitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE);
  Ellipsoid _currentDefaultEllipsoid = defaultEllipsoid;
  GCWSwitchPosition _currentGC8K7RCEllipsoid = (Prefs.getString(PREFERENCE_COORD_GC8K7RC_USE_DEFAULT_ELLIPSOID) == 'left') ? GCWSwitchPosition.left : GCWSwitchPosition.right;

  late TextEditingController _controllerAPIKey;

  var _currentAPIKey = Prefs.getString(PREFERENCE_COORD_DEFAULT_W3W_APIKEY);

  @override
  void initState() {
    super.initState();

    _currentDefaultFormat = defaultCoordinateFormat;
    _controllerAPIKey = TextEditingController(text: _currentAPIKey.toString());
  }

  @override
  void dispose() {
    _controllerAPIKey.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultformat'),
        ),
        GCWCoordsFormatSelector(
          format: _currentDefaultFormat,
          onChanged: (newValue) {
            setState(() {
              _currentDefaultFormat = newValue;

              var typePersistenceKey = persistenceKeyByCoordinateFormatKey(_currentDefaultFormat.type);
              Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT, typePersistenceKey);
              
              if (_currentDefaultFormat.subtype == null) {
                initDefaultSettings(PreferencesInitMode.REINIT_SINGLE, reinitSinglePreference: PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE);
              } else {
                var subtypePersistenceKey = persistenceKeyByCoordinateFormatKey(_currentDefaultFormat.subtype!);
                Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, subtypePersistenceKey);
              }
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaulthemispheres'),
        ),
        Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: GCWText(
                text: i18n(context, 'coords_common_latitude'),
              )),
          Expanded(
              flex: 4,
              child: GCWSignDropDown(
                  itemList: [i18n(context, 'coords_common_north'), i18n(context, 'coords_common_south')],
                  value: _currentDefaultHemisphereLatitude == HemisphereLatitude.North.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLatitude =
                          value > 0 ? HemisphereLatitude.North.toString() : HemisphereLatitude.South.toString();
                      Prefs.setString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE, _currentDefaultHemisphereLatitude);
                    });
                  }))
        ]),
        Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: GCWText(
                text: i18n(context, 'coords_common_longitude'),
              )),
          Expanded(
              flex: 4,
              child: GCWSignDropDown(
                  itemList: [i18n(context, 'coords_common_east'), i18n(context, 'coords_common_west')],
                  value: _currentDefaultHemisphereLongitude == HemisphereLongitude.East.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLongitude =
                          value > 0 ? HemisphereLongitude.East.toString() : HemisphereLongitude.West.toString();
                      Prefs.setString(
                          PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE, _currentDefaultHemisphereLongitude);
                    });
                  }))
        ]),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultrotationellipsoid'),
        ),
        _EllipsoidPicker(
          onChanged: (ells) {
            _currentDefaultEllipsoid = ells;

            switch (_currentDefaultEllipsoid.type) {
              case EllipsoidType.STANDARD:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.STANDARD.toString());
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME, ells.name);
                break;
              case EllipsoidType.USER_DEFINED:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.USER_DEFINED.toString());
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A, ells.a);
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF, ells.invf);
                break;
            }
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultw3wapikey'),
        ),
        GCWTextField(
          controller: _controllerAPIKey,
          onChanged: (value) {
            setState(() {
              _currentAPIKey = value;
              Prefs.setString(PREFERENCE_COORD_DEFAULT_W3W_APIKEY, value);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_gc8k7rc'),
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'settings_coordinates_gc8k7rc_default_ellipsoid'),
          rightValue: i18n(context, 'settings_coordinates_gc8k7rc_listing'),
          value: _currentGC8K7RCEllipsoid,
          onChanged: (value) {
            if (value == GCWSwitchPosition.left){
              Prefs.setString(PREFERENCE_COORD_GC8K7RC_USE_DEFAULT_ELLIPSOID, 'left');
            } else {
              Prefs.setString(PREFERENCE_COORD_GC8K7RC_USE_DEFAULT_ELLIPSOID, 'right');
            }
            setState(() {
              _currentGC8K7RCEllipsoid = value;
            });
          },
        ),
      ],
    );
  }
}
