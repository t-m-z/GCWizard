import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsLambert extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;
  final String subtype;

  const GCWCoordsLambert({Key key, this.onChanged, this.coordinates, this.subtype: keyCoordsGaussKruegerGK1})
      : super(key: key);

  @override
  GCWCoordsLambertState createState() => GCWCoordsLambertState();
}

class GCWCoordsLambertState extends State<GCWCoordsLambert> {
  TextEditingController _eastingController;
  TextEditingController _northingController;

  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  var _currentSubtype = DefaultLambertType;

  @override
  void initState() {
    super.initState();

    _currentSubtype = getLambertType(widget.subtype);

    _eastingController = TextEditingController(text: _currentEasting['text']);
    _northingController = TextEditingController(text: _currentNorthing['text']);
  }

  @override
  void dispose() {
    _eastingController.dispose();
    _northingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var lambert = widget.coordinates is Lambert
          ? widget.coordinates as Lambert
          : Lambert.fromLatLon(widget.coordinates.toLatLng(), _currentSubtype, defaultEllipsoid());
      _currentEasting['value'] = lambert.easting;
      _currentNorthing['value'] = lambert.northing;
      _currentSubtype = lambert.type;

      _eastingController.text = _currentEasting['value'].toString();
      _northingController.text = _currentNorthing['value'].toString();
    } else if (_subtypeChanged()) {
      _currentSubtype = getLambertType(widget.subtype);
      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _eastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _northingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  bool _subtypeChanged() {
    return _currentSubtype != getLambertType(widget.subtype);
  }

  _setCurrentValueAndEmitOnChange() {
    var lambert = Lambert(_currentSubtype, _currentEasting['value'], _currentNorthing['value']);
    widget.onChanged(lambert);
  }
}
