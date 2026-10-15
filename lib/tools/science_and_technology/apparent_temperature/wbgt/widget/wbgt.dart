import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/cloudcover.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wbgt/logic/wbgt.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/humidity.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/length.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/pressure.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart' as velocity;
import 'package:gc_wizard/tools/symbol_tables/_common/logic/symbol_table_data.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:intl/intl.dart';

class WBGT extends StatefulWidget {
  const WBGT({super.key});

  @override
  _WBGTState createState() => _WBGTState();
}

class _WBGTState extends State<WBGT> {
  DateTime _currentDateTime = DateTime.now();
  int _currentDateTimeTZ = 0;
  var _currentCoords = defaultBaseCoordinate;
  double _currentTemperature = 20.0;
  double _currentHumidity = 10.0;
  double _currentAirPressure = 1024;
  double _currentWindSpeed = 0.13;
  double _currentWindSpeedHeight = 2.0;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;

  Unit _currentOutputUnit = TEMPERATURE_CELSIUS;

  List<Map<String, SymbolData>> _images = [];
  final String _ASSET_PATH = 'lib/tools/symbol_tables/_common/assets/weather_n/weather_n.zip';

  Future<ui.Image> _initializeImage(Uint8List bytes) async {
    return decodeImageFromList(bytes);
  }

  Future<void> _initalizeImages() async {
    // Read the Zip file from disk.
    final bytes = await DefaultAssetBundle.of(context).load(_ASSET_PATH);
    // Decode the Zip file
    final archive = extractZipArchive(bytes.buffer.asUint8List());

    _images = [];
    for (var file in archive) {
      var key = file.name.split('.png')[0];

      var imagePath = (file.isFile && SymbolTableConstants.IMAGE_SUFFIXES.hasMatch(file.name)) ? file.name : null;
      if (imagePath == null) continue;

      var data = toUint8ListOrNull(file.content);
      if (data != null) {
        var standardImage = await _initializeImage(data);
        ui.Image? specialEncryptionImage;

        _images.add({
          key: SymbolData(
              path: imagePath,
              bytes: data,
              standardImage: standardImage,
              specialEncryptionImage: specialEncryptionImage)
        });
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initalizeImages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDateTimePicker(
          config: const {DateTimePickerConfig.DATE, DateTimePickerConfig.TIME, DateTimePickerConfig.TIMEZONES},
          onChanged: (datetime) {
            setState(() {
              _currentDateTime = datetime.toLocalTime();//
              _currentDateTimeTZ = datetime.timezoneOffset.inHours;
            });
          },
        ),
        GCWCoords(
          title: i18n(context, 'coords_antipodes_coorda'),
          coordsFormat: _currentCoords.format,
          onChanged: (ret) {
            setState(() {
              if (ret != null) {
                _currentCoords = ret;
              }
            });
          },
        ),
        GCWUnitInput<Temperature>(
          value: _currentTemperature,
          title: i18n(context, 'common_measure_temperature'),
          initialUnit: TEMPERATURE_CELSIUS,
          min: 0.0,
          unitList: temperatures,
          onChanged: (value) {
            setState(() {
              _currentTemperature = TEMPERATURE_CELSIUS.fromKelvin(value);
            });
          },
        ),
        GCWUnitInput<Humidity>(
          value: _currentHumidity,
          title: i18n(context, 'common_measure_humidity'),
          initialUnit: HUMIDITY,
          min: 0.0,
          max: 100.0,
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),
        GCWUnitInput<Pressure>(
          value: _currentAirPressure,
          title: i18n(context, 'common_measure_airpressure'),
          initialUnit: PRESSURE_MBAR,
          min: 0.0,
          max: 2000.0,
          numberDecimalDigits: 2,
          unitList: allPressures(),
          onChanged: (value) {
            setState(() {
              _currentAirPressure = value;
            });
          },
        ),
        GCWUnitInput<velocity.Velocity>(
          value: _currentWindSpeed,
          title: i18n(context, 'common_measure_windspeed'),
          initialUnit: velocity.VELOCITY_MS,
          min: 0.13,
          max: 100.0,
          unitList: velocity.velocities,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          },
        ),
        GCWUnitInput<Length>(
          value: _currentWindSpeedHeight,
          title: i18n(context, 'common_height'),
          initialUnit: LENGTH_METER,
          min: 2.0,
          max: 10.0,
          unitList: allLengths(),
          onChanged: (value) {
            setState(() {
              _currentWindSpeedHeight = value;
            });
          },
        ),
        GCWDropDown<CLOUD_COVER>(
          title: i18n(context, 'wet_bulb_globe_temperature_cloud'),
          value: _currentCloudCover,
          onChanged: (value) {
            setState(() {
              _currentCloudCover = value;
            });
          },
          items: CLOUD_COVER_MAP.entries.map((entry) {
            //items: CLOUD_COVER_LIST.entries.map((entry) {
            return GCWDropDownMenuItem(
              value: entry.key,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: DEFAULT_MARGIN * 2),
                    child: _images.isEmpty
                        ? Container()
                        : Image.memory(
                      _images[int.parse(entry.value.image)].values.first.bytes,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: DEFAULT_MARGIN * 2),
                    child: Text(
                      i18n(context, entry.value.title),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String hintWBGT = '';
    double? WBGT_C = 0.0;
    double WBGT = 0.0;

    WbgtResult wbgt = calculateWbgt(
        WbgtInput(
            observationTime: _currentDateTime,
            gmtOffsetHours: _currentDateTimeTZ,
            averagingMinutes: 0,
            latitude: _currentCoords.toLatLng()!.latitude,
            longitude: _currentCoords.toLatLng()!.longitude,
            cloudCoverFraction: CLOUD_COVER_VALUE[_currentCloudCover]!,
            pressureMb: PRESSURE_MBAR.fromReference(_currentAirPressure),
            airTemperatureC: (_currentTemperature),
            relativeHumidityPct: _currentHumidity,
            windSpeedMs: velocity.VELOCITY_MS.fromReference(_currentWindSpeed),
            windSpeedHeightM: _currentWindSpeedHeight));

    WBGT_C = wbgt.wetBulbGlobeTemperatureC;

    if (WBGT_C == null) {
      return GCWDefaultOutput(
        child: i18n(context, 'wbgt_error_null'),
      );
    } else {
      WBGT = TEMPERATURE_CELSIUS.toKelvin(WBGT_C);
      WBGT = _currentOutputUnit.fromReference(WBGT);
      hintWBGT = _calculateHintWBGT(WBGT_C);

      return Column(
        children: [
          GCWDefaultOutput(
              child: Row(children: <Widget>[
                Container(
                  width: 50,
                  padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
                  child: GCWIconButton(
                    icon: Icons.wb_sunny,
                    iconColor: _colorWBT(WBGT_C),
                    backgroundColor: const Color(0xFF4d4d4d),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 2,
                  //child: Text(_currentOutputUnit.symbol),
                  child: Container(
                      margin: const EdgeInsets.only(left: DEFAULT_MARGIN, right: 2 * DEFAULT_MARGIN),
                      child: GCWUnitDropDown(
                        value: _currentOutputUnit,
                        onlyShowSymbols: false,
                        unitList: temperatures,
                        unitCategory: UNITCATEGORY_TEMPERATURE,
                        onChanged: (value) {
                          setState(() {
                            _currentOutputUnit = value;
                          });
                        },
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: const EdgeInsets.only(left: 2 * DEFAULT_MARGIN),
                      child: GCWOutput(child: NumberFormat('#.###').format(WBGT))),
                ),
              ])),
          GCWTextDivider(text: i18n(context, 'heatindex_hint')),
          GCWOutput(
            child: i18n(context, hintWBGT),
          ),
        ],
      );
    }
  }

  String _calculateHintWBGT(double WBT) {
          if (WBT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.GREEN]!) {
            if (WBT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.YELLOW]!) {
              if (WBT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.RED]!) {
                if (WBT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.BLACK]!) {
                  return 'wbgt_index_wbgt_black';
                } else {
                  return 'wbgt_index_wbgt_red';
                }
              } else {
                return 'wbgt_index_wbgt_yellow';
              }
            } else {
              return 'wbgt_index_wbgt_green';
            }
          } else {
            return 'wbgt_index_wbgt_white';
          }
  }

  Color _colorWBT(double WBGT) {
          if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.GREEN]!) {
            if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.YELLOW]!) {
              if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.RED]!) {
                if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.BLACK]!) {
                  return Colors.black;
                } else {
                  return Colors.red;
                }
              } else {
                return Colors.yellow;
              }
            } else {
              return Colors.green;
            }
          } else {
            return Colors.white;
          }
  }
}
