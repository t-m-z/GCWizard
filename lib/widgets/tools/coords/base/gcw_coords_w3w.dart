import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_what3words_textinputformatter.dart';
import 'package:gc_wizard/logic/tools/coords/converter/w3w.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsW3W extends StatefulWidget {
  final Function onChanged;
  final LatLng coordinates;
  final String subtype;

  const GCWCoordsW3W({Key key, this.onChanged, this.coordinates, this.subtype: keyCoordsWhat3WordsDE})
      : super(key: key);

  @override
  GCWCoordsW3WState createState() => GCWCoordsW3WState();
}

class GCWCoordsW3WState extends State<GCWCoordsW3W> {
  var _controllerCoord;
  var _currentCoord = '';
  var _currentSubtype;
  var _APIKeymissing = false;

  @override
  void initState() {
    super.initState();
    _controllerCoord = TextEditingController(text: _currentCoord);
    if (widget.subtype != null)
      _currentSubtype = widget.subtype;
    else
      _currentSubtype = keyCoordsWhat3WordsDE;
  }

  @override
  void dispose() {
    _controllerCoord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w'),
          controller: _controllerCoord,
          //inputFormatters: [CoordsTextWhat3WordsTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange(context);
            });
          }),
      (_APIKeymissing)
          ? GCWOutput(
              title: i18n(context, 'coords_formatconverter_w3w_error'),
              child: i18n(context, 'coords_formatconverter_w3w_no_apikey'),
              suppressCopyButton: true)
          : Container()
    ]);
  }

  _setCurrentValueAndEmitOnChange(var context) {
    LatLng coords = What3WordsToLatLon(_currentCoord, _getSubTypeLanguage(_currentSubtype));
    _APIKeymissing = (coords == null || (coords.latitude == 0.0 && coords.longitude == 0.0));
    widget.onChanged(coords);
  }
}

String _getSubTypeLanguage(String subtype) {
  switch (subtype) {
    case keyCoordsWhat3WordsDE:
      return 'de';
    case keyCoordsWhat3WordsEN:
      return 'en';
    case keyCoordsWhat3WordsFR:
      return 'fr';
    case keyCoordsWhat3WordsZH:
      return 'zh';
    case keyCoordsWhat3WordsDA:
      return 'da';
    case keyCoordsWhat3WordsNL:
      return 'nl';
    case keyCoordsWhat3WordsIT:
      return 'it';
    case keyCoordsWhat3WordsJA:
      return 'ja';
    case keyCoordsWhat3WordsKO:
      return 'ko';
    case keyCoordsWhat3WordsPL:
      return 'pl';
    case keyCoordsWhat3WordsRU:
      return 'ru';
    case keyCoordsWhat3WordsSP:
      return 'sp';
    case keyCoordsWhat3WordsCS:
      return 'cs';
    default:
      return 'en';
  }
}
