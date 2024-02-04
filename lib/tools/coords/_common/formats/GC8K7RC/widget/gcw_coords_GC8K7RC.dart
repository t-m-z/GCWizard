part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordWidgetInfoGC8K7RC extends GCWCoordWidgetInfo {
  @override
  CoordinateFormatKey get type => CoordinateFormatKey.GC8K7RC;
  @override
  String get i18nKey => GC8K7RCKey;
  @override
  String get name => 'GC8K7RC: vvv.vv m/s  ddddd.dd m';
  @override
  String get example => '283 m/s, 883927.86 m';

  @override
  _GCWCoordWidget mainWidget({
    Key? key,
    required void Function(BaseCoordinate?) onChanged,
    required BaseCoordinate? coordinates,
    bool? initialize
  }) {
    return _GCWCoordsGC8K7RC(key: key, onChanged: onChanged, coordinates: coordinates, initialize: initialize ?? false);
  }
}

class _GCWCoordsGC8K7RC extends _GCWCoordWidget {

  _GCWCoordsGC8K7RC({super.key, required super.onChanged, required BaseCoordinate? coordinates, super.initialize}) :
        super(coordinates: coordinates is GC8K7RCCoordinate ? coordinates : GC8K7RCFormatDefinition.defaultCoordinate);

  @override
  _GCWCoordsGC8K7RCState createState() => _GCWCoordsGC8K7RCState();
}

class _GCWCoordsGC8K7RCState extends State<_GCWCoordsGC8K7RC> {
  late TextEditingController _velocityController;
  late TextEditingController _velocityMilliController;
  late TextEditingController _distanceController;
  late TextEditingController _distanceMilliController;

  int _currentVelocitySign = defaultHemiphereLatitude();
  int _currentDistanceSign = defaultHemiphereLongitude();

  String _currentVelocity = '';
  String _currentVelocityMilli = '';
  String _currentDistance = '';
  String _currentDistanceMilli = '';

  @override
  void initState() {
    super.initState();

    _velocityController = TextEditingController(text: _currentVelocity);
    _velocityMilliController = TextEditingController(text: _currentVelocityMilli);
    _distanceController = TextEditingController(text: _currentDistance);
    _distanceMilliController = TextEditingController(text: _currentDistanceMilli);
  }

  @override
  void dispose() {
    _velocityController.dispose();
    _velocityMilliController.dispose();
    _distanceController.dispose();
    _distanceMilliController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialize) {
      var GC8K7RC = widget.coordinates as GC8K7RCCoordinate;
      _currentVelocity = GC8K7RC.latitude.abs().floor().toString();
      _currentVelocityMilli = GC8K7RC.latitude.toString().split('.')[1];
      _currentVelocitySign = sign(GC8K7RC.latitude);

      _currentDistance = GC8K7RC.longitude.abs().floor().toString();
      _currentDistanceMilli = GC8K7RC.longitude.toString().split('.')[1];
      _currentDistanceSign = sign(GC8K7RC.longitude);

    }

    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWSignDropDown(
                itemList: const ['+', '-'],
                value: _currentVelocitySign,
                onChanged: (value) {
                  setState(() {
                    _currentVelocitySign = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          ),
          Expanded(
              flex: 15,
              child: Container(
                padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN, ),
                child: GCWIntegerTextField(
                    hintText: 'vvv',
                    textInputFormatter: IntTextInputFormatter(range: 999, allowNegativeValues: false),
                    controller: _velocityController,
                    onChanged: (IntegerText ret) {
                      setState(() {
                        _currentVelocity = ret.text;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }),
              )),
          const Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '.'),
          ),
          Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                child: GCWIntegerTextField(
                    hintText: 'vv',
                    textInputFormatter: IntTextInputFormatter(range: 99, allowNegativeValues: false),
                    controller: _velocityMilliController,
                    onChanged: (IntegerText ret) {
                      setState(() {
                        _currentVelocityMilli = ret.text;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }),
              )),
          const Expanded(
            flex: 4,
            child: GCWText(align: Alignment.center, text: 'm/s'),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWSignDropDown(
                itemList: const ['+', '-'],
                value: _currentDistanceSign,
                onChanged: (value) {
                  setState(() {
                    _currentDistanceSign = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          ),
          Expanded(
              flex: 15,
              child: Container(
                padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN, right: DOUBLE_DEFAULT_MARGIN),
                child: GCWIntegerTextField(
                    hintText: 'ddddd',
                    textInputFormatter: IntTextInputFormatter(range: 99999999, allowNegativeValues: false),
                    controller: _distanceController,
                    onChanged: (IntegerText ret) {
                      setState(() {
                        _currentDistance = ret.text;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }),
              )),
          const Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '.'),
          ),
          Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                child: GCWIntegerTextField(
                    hintText: 'dd',
                    textInputFormatter: IntTextInputFormatter(range: 99, allowNegativeValues: false),
                    controller: _distanceMilliController,
                    onChanged: (IntegerText ret) {
                      setState(() {
                        _currentDistanceMilli = ret.text;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }),
              )),
          const Expanded(
            flex: 4,
            child: GCWText(align: Alignment.center, text: 'm'),
          ),
        ],
      )
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    int _degrees = ['', '-'].contains(_currentVelocity) ? 0 : int.parse(_currentVelocity);
    double _degreesD = double.parse('$_degrees.$_currentVelocityMilli');
    double _currentVel = _currentVelocitySign * _degreesD;

    _degrees = ['', '-'].contains(_currentDistance) ? 0 : int.parse(_currentDistance);
    _degreesD = double.parse('$_degrees.$_currentDistanceMilli');
    double _currentDist = _currentDistanceSign * _degreesD;

    widget.onChanged(GC8K7RCCoordinate(_currentVel, _currentDist));
  }
}

class IntTextInputFormatter extends TextInputFormatter {
  final bool allowNegativeValues;
  final int range;

  IntTextInputFormatter({this.range = 0, this.allowNegativeValues = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!allowNegativeValues && newValue.text == '-') return oldValue;

    if (newValue.text.isEmpty || newValue.text == '-') return newValue;

    var _newInt = int.tryParse(newValue.text);
    if (_newInt == null) return oldValue;

    if (!allowNegativeValues && _newInt < 0) return oldValue;

    if (_newInt >= -range && _newInt <= range) return newValue;

    return oldValue;
  }
}
