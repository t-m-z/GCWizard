import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/logic/maya_calendar.dart';
import 'package:prefs/prefs.dart';

class ToolSettings extends StatefulWidget {
  const ToolSettings({Key? key}) : super(key: key);

  @override
  _ToolSettingsState createState() => _ToolSettingsState();
}

class _ToolSettingsState extends State<ToolSettings> {
  late TextEditingController _chatGPTAPIKeyController;
  String _chatgpt_api_key = Prefs.get(PREFERENCE_CHATGPT_API_KEY).toString();

  late TextEditingController _inputControllerSHODAN;
  late TextEditingController _inputControllerWhoIs;
  late TextEditingController _inputControllerPT;
  late TextEditingController _inputControllerVT;
  late TextEditingController _inputControllerMail;
  late TextEditingController _inputControllerGreyNoise;

  String _currentInputMail = Prefs.get(PREFERENCE_WTF_MAIL).toString();
  String _currentInputSHODAN = Prefs.get(PREFERENCE_WTF_SHODAN).toString();
  String _currentInputPT = Prefs.get(PREFERENCE_WTF_PT).toString();
  String _currentInputVT = Prefs.get(PREFERENCE_WTF_VT).toString();
  String _currentInputWhoIs = Prefs.get(PREFERENCE_WTF_WHOIS).toString();
  String _currentInputGreyNoise = Prefs.get(PREFERENCE_WTF_GREYNOISE).toString();

  late TextEditingController _inputControllerOpenGTINDBApiKey;
  String _currentInputOpenGTINDBApiKey = Prefs.get(PREFERENCE_EAN_DEFAULT_OPENGTIN_APIKEY).toString();

  @override
  void initState() {
    super.initState();

    _chatGPTAPIKeyController = TextEditingController(text: _chatgpt_api_key);
    _inputControllerOpenGTINDBApiKey = TextEditingController(text: _currentInputOpenGTINDBApiKey);

    _inputControllerWhoIs = TextEditingController(text: _currentInputWhoIs);
    _inputControllerSHODAN = TextEditingController(text: _currentInputSHODAN);
    _inputControllerVT = TextEditingController(text: _currentInputVT);
    _inputControllerPT = TextEditingController(text: _currentInputPT);
    _inputControllerMail = TextEditingController(text: _currentInputMail);
    _inputControllerGreyNoise = TextEditingController(text: _currentInputGreyNoise);

    _inputControllerOpenGTINDBApiKey = TextEditingController(text: _currentInputOpenGTINDBApiKey);
  }

  @override
  void dispose() {
    _chatGPTAPIKeyController.dispose();

    _inputControllerWhoIs.dispose();
    _inputControllerSHODAN.dispose();
    _inputControllerVT.dispose();
    _inputControllerPT.dispose();
    _inputControllerMail.dispose();
    _inputControllerGreyNoise.dispose();

    _inputControllerOpenGTINDBApiKey.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_mayacalendar_title'),
        ),
        GCWDropDown<String>(
          value: Prefs.getString(PREFERENCE_MAYACALENDAR_CORRELATION),
          onChanged: (String value) {
            setState(() {
              Prefs.setString(PREFERENCE_MAYACALENDAR_CORRELATION, value);
            });
          },
          items: CORRELATION_SYSTEMS.entries.map((mode) {
            // Map<String, String> CORRELATION_SYSTEMS = {
            //   THOMPSON: 'Thompson (584283)',
            //   SMILEY: 'Smiley (482699)',
            //   WEITZEL: 'Weitzel (774078)',
            // };
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_chatgpt_title'),
        ),
        GCWTextField(
          controller: _chatGPTAPIKeyController,
          onChanged: (text) {
            setState(() {
              _chatgpt_api_key = text;
              Prefs.setString(PREFERENCE_CHATGPT_API_KEY, _chatgpt_api_key);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_wtf_title'),
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_virustotal'),
          controller: _inputControllerVT,
          onChanged: (text) {
            setState(() {
              _currentInputVT = text;
              Prefs.setString(PREFERENCE_WTF_VT, text);
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_passivetotal'),
          controller: _inputControllerPT,
          onChanged: (text) {
            setState(() {
              _currentInputPT = text;
              Prefs.setString(PREFERENCE_WTF_PT, text);
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_email'),
          controller: _inputControllerMail,
          onChanged: (text) {
            setState(() {
              _currentInputMail = text;
              Prefs.setString(PREFERENCE_WTF_MAIL, text);
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_shodan'),
          controller: _inputControllerSHODAN,
          onChanged: (text) {
            setState(() {
              _currentInputSHODAN = text;
              Prefs.setString(PREFERENCE_WTF_SHODAN, text);
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_whois'),
          controller: _inputControllerWhoIs,
          onChanged: (text) {
            setState(() {
              _currentInputWhoIs = text;
              Prefs.setString(PREFERENCE_WTF_WHOIS, text);
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'settings_wtf_greynoise'),
          controller: _inputControllerGreyNoise,
          onChanged: (text) {
            setState(() {
              _currentInputGreyNoise = text;
              Prefs.setString(PREFERENCE_WTF_GREYNOISE, text);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_tools_defaultopengtindb_apikey'),
        ),
        GCWTextField(
          controller: _inputControllerOpenGTINDBApiKey,
          onChanged: (text) {
            setState(() {
              _currentInputOpenGTINDBApiKey = text;
              Prefs.setString(PREFERENCE_EAN_DEFAULT_OPENGTIN_APIKEY, text);
            });
          },
        ),
      ],
    );
  }
}
