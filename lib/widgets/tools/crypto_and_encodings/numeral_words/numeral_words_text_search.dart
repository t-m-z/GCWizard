import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_code_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/app_builder.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumeralWordsTextSearch extends StatefulWidget {
  @override
  NumeralWordsTextSearchState createState() => NumeralWordsTextSearchState();
}

class NumeralWordsTextSearchState extends State<NumeralWordsTextSearch> {
  TextEditingController _decodeController;
  TextEditingController _codeControllerHighlighted;

  var _currentDecodeInput = '';
  GCWSwitchPosition _currentDecodeMode = GCWSwitchPosition.left;
  var _currentLanguage;
  bool _setDefaultLanguage = false;

  Map<String, NumeralWordsLanguage> _languageList;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _codeControllerHighlighted = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _codeControllerHighlighted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_setDefaultLanguage) {
      _currentLanguage = _defaultLanguage(context);
      _setDefaultLanguage = true;
    }
    if (_languageList == null) {
      var sorted = SplayTreeMap<String, NumeralWordsLanguage>.from(
          switchMapKeyValue(NUMERALWORDS_LANGUAGES).map((key, value) => MapEntry(i18n(context, key), value)));

      _languageList = {};
      _languageList.addAll(sorted);
    }

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;

              AppBuilder.of(context).rebuild();
            });
          },
          items: _languageList.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
        ),
        GCWTextField(
          controller: _decodeController,
          onChanged: (text) {
            setState(() {
              _currentDecodeInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentDecodeMode,
          leftValue: i18n(context, 'numeralwords_decodemode_left'),
          rightValue: i18n(context, 'numeralwords_decodemode_right'),
          onChanged: (value) {
            setState(() {
              _currentDecodeMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: _buildOutput(context),
        )
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    List<NumeralWordsDecodeOutput> detailedOutput;
    List<String> output = [];
    detailedOutput = decodeNumeralwords(
        input: removeAccents(_currentDecodeInput.toLowerCase()),
        language: _currentLanguage,
        decodeModeWholeWords: (_currentDecodeMode == GCWSwitchPosition.left));
    for (int i = 0; i < detailedOutput.length; i++) {
      if (detailedOutput[i].number != '') if (detailedOutput[i].number.startsWith('numeralwords_'))
        output.add(i18n(context, detailedOutput[i].number));
      else
        output.add(detailedOutput[i].number);
    }

    List<List<String>> columnData = [];
    var flexData;
    String columnDataRowNumber;
    String columnDataRowNumWord;

    for (int i = 0; i < detailedOutput.length; i++) {
      if (detailedOutput[i].number.startsWith('numeralwords_'))
        columnDataRowNumber = i18n(context, detailedOutput[i].number);
      else
        columnDataRowNumber = detailedOutput[i].number;
      if (detailedOutput[i].numWord.startsWith('numeralwords_'))
        columnDataRowNumWord = i18n(context, detailedOutput[i].numWord);
      else
        columnDataRowNumWord = detailedOutput[i].numWord;
      columnData.add([columnDataRowNumber, columnDataRowNumWord]);
    }
    flexData = [1, 2];

    if (_currentDecodeMode == GCWSwitchPosition.left) {
      _codeControllerHighlighted.text = _currentDecodeInput.toLowerCase();
    } else {
      _codeControllerHighlighted.text =
          removeAccents(_currentDecodeInput.toLowerCase()).replaceAll(RegExp(r'[^a-z0-9]'), '');
    }

    return Column(
      children: <Widget>[
        GCWOutputText(
          text: output.join(' '),
        ),
        output.length == 0
            ? Container()
            : GCWExpandableTextDivider(
                text: i18n(context, 'numeralwords_syntax_highlight'),
                suppressTopSpace: false,
                child: GCWCodeTextField(
                  wrap: true,
                  controller: _codeControllerHighlighted,
                  patternMap: _numeralWordsHiglightMap(),
                )),
        output.length == 0
            ? Container()
            : GCWExpandableTextDivider(
                text: i18n(context, 'common_outputdetail'),
                suppressTopSpace: false,
                expanded: true,
                child:
                    Column(children: columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 1)),
              ),
      ],
    );
  }

  Map<String, TextStyle> _numeralWordsHiglightMap() {
    Map<String, TextStyle> result = {};
    if (NUMERAL_WORDS_ACCENTS[_currentLanguage] != null) {
      NUMERAL_WORDS_ACCENTS[_currentLanguage].forEach((element) {
        if (int.tryParse(NUMERAL_WORDS[_currentLanguage][removeAccents(element)]) < 10) {
          result[r'' + element + ''] = TextStyle(color: Colors.red);
          result[r'' + removeAccents(element) + ''] = TextStyle(color: Colors.red);
        } else {
          result[r'' + element + ''] = TextStyle(color: Colors.orange);
          result[r'' + removeAccents(element) + ''] = TextStyle(color: Colors.orange);
        }
      });
    }

    NUMERAL_WORDS[_currentLanguage].forEach((key, value) {
      if (int.tryParse(value) == null) if (value.startsWith('numeral'))
        result[r'' + key + ''] = TextStyle(color: Colors.blue);
      else
        result[r'' + key + ''] = TextStyle(color: Colors.green);
      else if (int.parse(value) < 10)
        result[r'' + key + ''] = TextStyle(color: Colors.red);
      else
        result[r'' + key + ''] = TextStyle(color: Colors.orange);
    });
    return result;
  }

  NumeralWordsLanguage _defaultLanguage(BuildContext context) {
    final Locale appLocale = Localizations.localeOf(context);
    if (isLocaleSupported(appLocale)) {
      return SUPPORTED_LANGUAGES_LOCALES[appLocale];
    } else {
      return SUPPORTED_LANGUAGES_LOCALES[DEFAULT_LOCALE];
    }
  }
}
