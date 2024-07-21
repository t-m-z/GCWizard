import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';

import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/wtf/logic/wtf.dart';

import 'package:prefs/prefs.dart';

class WTFIs extends StatefulWidget {
  const WTFIs({Key? key}) : super(key: key);

  @override
  WTFIsState createState() => WTFIsState();
}

class WTFIsState extends State<WTFIs> {
  late TextEditingController _inputControllerAddress;

  var _currentInputAddress = '';
  var _currentMode = WTFmode.NULL;

  var _outputSHODAN = <List<Object>>[[]];
  var _outputPT = <List<Object>>[[]];
  var _outputVT = <List<Object>>[[]];
  var _outputWhoIs = <List<Object>>[[]];
  var _outputIPWhoIs = <List<Object>>[[]];
  var _outputGreyNoise = <List<Object>>[[]];

  bool _getDataSHODAN = false;
  bool _getDataPT = false;
  bool _getDataVT = false;
  bool _getDataWhoIs = false;
  bool _getDataIPWhoIs = false;
  bool _getDataGreyNoise = false;

  String VT_API_KEY = Prefs.get(PREFERENCE_WTF_VT) as String;
  String PT_API_USER = Prefs.get(PREFERENCE_WTF_MAIL) as String;
  String PT_API_KEY = Prefs.get(PREFERENCE_WTF_PT) as String;
  String SHODAN_API_KEY = Prefs.get(PREFERENCE_WTF_SHODAN) as String;
  String WHOIS_API_KEY = Prefs.get(PREFERENCE_WTF_WHOIS) as String;
  String GREYNOISE_API_KEY = Prefs.get(PREFERENCE_WTF_GREYNOISE) as String;

  @override
  void initState() {
    super.initState();
    _inputControllerAddress = TextEditingController(text: _currentInputAddress);
  }

  @override
  void dispose() {
    _inputControllerAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextField(
        controller: _inputControllerAddress,
        onChanged: (text) {
          setState(() {
            _currentInputAddress = text;
            _currentMode = WTFMode(_currentInputAddress);
          });
        },
      ),
      GCWButton(
        text: i18n(context, 'common_start'),
        onPressed: () {
          setState(() {
            _analyseWTFAsync();
          });
        },
      ),
      _buildOutput(context)
    ]);
  }

  Widget _buildOutput(BuildContext context) {
    return GCWDefaultOutput(
      child: Column(children: <Widget>[
        _getDataSHODAN == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_shodan'),
                child: GCWColumnedMultilineOutput(
                  data: _outputSHODAN,
                  flexValues: const [1, 1],
                ),
              ),
        _getDataVT == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_vt'),
                child: GCWColumnedMultilineOutput(data: _outputVT, flexValues: const [1, 1]),
              ),
        _getDataPT == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_pt'),
                child: GCWColumnedMultilineOutput(data: _outputPT, flexValues: const [1, 1]),
              ),
        _getDataWhoIs == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_whois'),
                child: GCWColumnedMultilineOutput(data: _outputWhoIs, flexValues: const [1, 1]),
              ),
        _getDataIPWhoIs == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_ipwhois'),
                child: GCWColumnedMultilineOutput(data: _outputIPWhoIs, flexValues: const [1, 1]),
              ),
        _getDataGreyNoise == false
            ? Container()
            : GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wtf_data_greynoise'),
                child: GCWColumnedMultilineOutput(data: _outputGreyNoise, flexValues: const [1, 1]),
              ),
      ]),
    );
  }

  Future<GCWAsyncExecuterParameters> _buildWTFJobData() async {
    return GCWAsyncExecuterParameters(
        WTFjobData(
          WTFjobDataAdress: _currentInputAddress,
           WTFjobDataMode: WTFmodeToString(_currentMode),
           WTFjobDataShodan_api_key: SHODAN_API_KEY,
           WTFjobDataVt_api_key: VT_API_KEY,
           WTFjobDataPt_api_key: PT_API_KEY,
           WTFjobDataWhois_api_key: WHOIS_API_KEY,
           WTFjobDataGreynoise_api_key: GREYNOISE_API_KEY,
        )
    );
  }

  void _analyseWTFAsync() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<WTFoutput>(
              isolatedFunction: WTFgetInformationAsync,
              parameter: _buildWTFJobData,
              onReady: (data) => _showWTFOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  void _showWTFOutput(WTFoutput output) {

    if (output.result == WTFstatus.OK) {
      showSnackBar(i18n(context, 'wtf_result_ok'), context);

      _handleSHODAN(output.dataSHODAN);
      _handleVirusTotal(output.dataVirusTotal);
      _handlePassiveTotal(output.dataPassiveTotal);
      _handleWhoIs(output.dataWhoIs);
      _handleIPWhoIs(output.dataIPWhoIs);
      _handleGreyNoise(output.dataGreyNoise);
    } else {
      showSnackBar(i18n(context, 'wtf_result_error_2') + '\n' + output.httpCode + '\n' + output.httpMessage, context);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _handleSHODAN(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.OK:
        _getDataSHODAN = true;
        _outputSHODAN = [];
        output.data.forEach((key, value) {
          if (key == 'data') {
            _outputSHODAN.add(['data', '']);
            value.forEach((Map<String, dynamic> element) {
              element.forEach((key, value) {
                if (['_shodan', 'location', 'dns', 'opts', 'http', 'ssl', 'favicon', 'redirects'].contains(key)) {
                  _outputSHODAN.add(['    ' + key , '']);
                  if ((value as Map<String, String>).isNotEmpty) {
                    value.forEach((String key, String value) {
                      if (['favicon', 'redirects', 'ssl'].contains(key)) {
                        _outputSHODAN.add(['        ' + key, '']);
                        if (value.isNotEmpty) {
                          _outputSHODAN.add(['        ' + key, value]);
                        }
                      } else {
                        _outputSHODAN.add(['        ' + key, value]);
                      }
                    });
                  }
                } else {
                  _outputSHODAN.add(['    ' + key, value as Object]);
                }
              });
            });
          } else {
            _outputSHODAN.add([key, value as Object]);
          }
        });
        break;

      case WTFstatus.ERROR:
        _getDataSHODAN = false;
        showSnackBar(i18n(context, 'wtf_result_error_shodan') + '\n' + output.httpCode + '\n' + output.httpMessage,
            context, duration: 15);
        break;

      case WTFstatus.NULL:
        _getDataSHODAN = false;
        showSnackBar(i18n(context, 'wtf_result_null_shodan'), context, duration: 15);
        break;
    }
  }

  void _handleVirusTotal(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.OK:
        _getDataVT = true;
        _outputVT = [];
        output.data.forEach((key, value) {
          _outputVT.add([key, value as Object]);
        });
        break;
      case WTFstatus.ERROR:
        _getDataVT = false;
        showSnackBar(i18n(context, 'wtf_result_error_vt') + '\n' + output.httpCode + '\n' + output.httpMessage,
            context, duration: 15);
        break;
      case WTFstatus.NULL:
        _getDataVT = false;
        showSnackBar(i18n(context, 'wtf_result_null_vt'), context, duration: 15);
        break;
    }
  }

  void _handlePassiveTotal(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.OK:
        _getDataPT = true;
        _outputPT = [];
        output.data.forEach((key, value) {
          _outputPT.add([key, value as Object]);
        });
        break;
      case WTFstatus.ERROR:
        _getDataPT = false;
        showSnackBar(i18n(context, 'wtf_result_error_pt') + '\n' + output.httpCode + '\n' + output.httpMessage,
            context, duration: 15);
        break;
      case WTFstatus.NULL:
        _getDataPT = false;
        showSnackBar(i18n(context, 'wtf_result_null_pt'), context, duration: 15);
        break;
    }
  }

  void _handleWhoIs(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.OK:
        _getDataWhoIs = true;
        _outputWhoIs = [];
        output.data.forEach((key, value) {
          if (key == 'contacts') {
            _outputWhoIs.add(['contacts', '']);
            value.forEach((Map<String, dynamic> element) {
              element.forEach((key, value) {
                _outputWhoIs.add([key, value as Object]);
              });
            });
          } else {
            _outputWhoIs.add([key, value as Object]);
          }
        });
        break;
      case WTFstatus.ERROR:
        _getDataWhoIs = false;
        showSnackBar(i18n(context, 'wtf_result_error_whois') + '\n' + output.httpCode + '\n' + output.httpMessage,
            context, duration: 15);
        break;
      case WTFstatus.NULL:
        _getDataWhoIs = false;
        showSnackBar(i18n(context, 'wtf_result_null_whois'), context, duration: 15);
        break;
    }
  }

  void _handleIPWhoIs(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.OK:
        _getDataIPWhoIs = true;
        _outputIPWhoIs = [];
        WTFIPWhoIs IPWhoIsData = WTFIPWhoIs.fromJson(output.data);
        output.data.forEach((key, value) {
          if (key == 'flag' || key == 'connection' || key == 'timezone') {
            _outputIPWhoIs.add([key, '', '']);
            value.forEach((String key, String value) {
              _outputIPWhoIs.add(['', key, value]);
            });
          } else {
            _outputIPWhoIs.add([key, value as Object, '']);
          }
        });
        break;

      case WTFstatus.ERROR:
        _getDataIPWhoIs = false;
        showSnackBar(i18n(context, 'wtf_result_error_ipwhois') + '\n' + output.httpCode + '\n' + output.httpMessage, context,
            duration: 15);
        break;

      case WTFstatus.NULL:
        _getDataIPWhoIs = false;
        showSnackBar(i18n(context, 'wtf_result_null_ipwhois'), context, duration: 15);
        break;
    }
  }

  void _handleGreyNoise(WTFDetailedOutput output) {
    switch (output.result) {
      case WTFstatus.ERROR:
      case WTFstatus.OK:
        _getDataGreyNoise = true;
        _outputGreyNoise = [];
        output.data.forEach((key, value) {
          _outputGreyNoise.add([key, value as Object]);
        });
        break;

      case WTFstatus.NULL:
        _getDataGreyNoise = false;
        showSnackBar(i18n(context, 'wtf_result_null_greynoise'), context, duration: 15);
        break;
    }
  }
}
