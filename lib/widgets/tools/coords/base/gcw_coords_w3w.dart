import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_what3words_textinputformatter.dart';
import 'package:gc_wizard/logic/tools/coords/converter/w3w.dart';

class GCWCoordsW3W extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsW3W({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsW3WState createState() => GCWCoordsW3WState();
}

class GCWCoordsW3WState extends State<GCWCoordsW3W> {
  var _controller;
  var _currentCoord = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentCoord);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          GCWTextField(
              hintText: i18n(context, 'coords_formatconverter_w3w_locator'),
              controller: _controller,
              //inputFormatters: [CoordsTextWhat3WordsTextInputFormatter()],
              onChanged: (ret) {
                setState(() {
                  _currentCoord = ret;
                  print(ret.toString());
                  _setCurrentValueAndEmitOnChange();
                });
              }
          ),
        ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    print("gcw_coord_w3w.dart: "+_currentCoord);
    var coords = What3WordsToLatLon(_currentCoord);
    widget.onChanged(coords);
  }
}