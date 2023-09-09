part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsQuadtree extends StatefulWidget {
  final void Function(Quadtree?) onChanged;
  final BaseCoordinate coordinates;
  final bool initialize;

  const _GCWCoordsQuadtree({Key? key, required this.onChanged, required this.coordinates, this.initialize = false}) : super(key: key);

  @override
  _GCWCoordsQuadtreeState createState() => _GCWCoordsQuadtreeState();
}

class _GCWCoordsQuadtreeState extends State<_GCWCoordsQuadtree> {
  late TextEditingController _controller;
  var _currentCoord = '';

  final _maskInputFormatter = GCWMaskTextInputFormatter(mask: '#' * 100, filter: {"#": RegExp(r'[0123]')});



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
    if (widget.initialize) {
      var quadtree = widget.coordinates;
      _currentCoord = quadtree.toString();

      _controller.text = _currentCoord;

    }

    return Column(children: <Widget>[
      GCWTextField(
          controller: _controller,
          inputFormatters: [_maskInputFormatter],
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
      widget.onChanged(Quadtree.parse(_currentCoord));
    } catch (e) {}
  }
}
