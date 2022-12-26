import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsSwissGrid extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsSwissGrid({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsSwissGridState createState() => GCWCoordsSwissGridState();
}

class GCWCoordsSwissGridState extends State<GCWCoordsSwissGrid> {
  TextEditingController _EastingController;
  TextEditingController _NorthingController;

  var _currentEasting = {'text': '', 'value': 0.0};
  var _currentNorthing = {'text': '', 'value': 0.0};

  @override
  void initState() {
    super.initState();
    _EastingController = TextEditingController(text: _currentEasting['text']);
    _NorthingController = TextEditingController(text: _currentNorthing['text']);
  }

  @override
  void dispose() {
    _EastingController?.dispose();
    _NorthingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var swissGrid = widget.coordinates is SwissGrid
          ? widget.coordinates as SwissGrid
          : SwissGrid.fromLatLon(widget.coordinates.toLatLng(), defaultEllipsoid());
      _currentEasting['value'] = swissGrid.easting;
      _currentNorthing['value'] = swissGrid.northing;

      _EastingController.text = _currentEasting['value'].toString();
      _NorthingController.text = _currentNorthing['value'].toString();
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_easting'),
          controller: _EastingController,
          onChanged: (ret) {
            setState(() {
              _currentEasting = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: i18n(context, 'coords_formatconverter_northing'),
          controller: _NorthingController,
          onChanged: (ret) {
            setState(() {
              _currentNorthing = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(SwissGrid(_currentEasting['value'], _currentNorthing['value']));
  }
}
