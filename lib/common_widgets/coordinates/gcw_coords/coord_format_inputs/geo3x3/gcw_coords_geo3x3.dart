part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGeo3x3 extends StatefulWidget {
  final void Function(Geo3x3?) onChanged;
  final Geo3x3 coordinates;
  final bool isDefault;

  const _GCWCoordsGeo3x3({Key? key, required this.onChanged, required this.coordinates, this.isDefault = true})
      : super(key: key);

  @override
  _GCWCoordsGeo3x3State createState() => _GCWCoordsGeo3x3State();
}

class _GCWCoordsGeo3x3State extends State<_GCWCoordsGeo3x3> {
  late TextEditingController _controller;
  var _currentCoord = '';

  bool _initialized = false;

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
    if (!widget.isDefault && !_initialized) {
      var geo3x3 = widget.coordinates;
      _currentCoord = geo3x3.text;

      _controller.text = _currentCoord;

      _initialized = true;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geo3x3_locator'),
          controller: _controller,
          inputFormatters: [_Geo3x3TextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    try {
      widget.onChanged(Geo3x3.parse(_currentCoord));
    } catch (e) {}
  }
}
