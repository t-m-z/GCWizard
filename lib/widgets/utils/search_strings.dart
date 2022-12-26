// Tools with search strings
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';

Map<String, String> _COMMON_SEARCHSTRINGS;
Map<String, String> _EN_SEARCHSTRINGS;
Map<String, String> _LOCALE_SEARCHSTRINGS;

final ALLOWED_SEARCH_CHARACTERS = RegExp(r'[^a-z0-9α-ω¥, ]');

Future loadSearchStrings(String languageCode) async {
  if (_COMMON_SEARCHSTRINGS == null) {
    _COMMON_SEARCHSTRINGS = await _getSearchStringsForLocale('common');
    _EN_SEARCHSTRINGS = await _getSearchStringsForLocale('en');
  }
  await _loadLocaleSearchStrings(languageCode);
}

Future _loadLocaleSearchStrings(String languageCode) async {
  if (languageCode != 'en') {
    _LOCALE_SEARCHSTRINGS = await _getSearchStringsForLocale(languageCode);
  } else {
    _LOCALE_SEARCHSTRINGS = {};
  }
}

Future<Map<String, String>> _getSearchStringsForLocale(String locale) async {
  var file;
  try {
    file = await rootBundle.loadString('assets/searchstrings/$locale.json');
  } catch (e) {}

  if (file == null) file = '{}';

  Map<String, dynamic> _rawStrings = json.decode(file);
  Map<String, String> _strings = _rawStrings.map((key, value) {
    return MapEntry(key, value.toString());
  });

  return _strings;
}

// Build indexed strings for each tool : concatenated lower case no accent
void createIndexedSearchStrings() {
  if (registeredTools == null) return;

  for (GCWTool tool in registeredTools) {
    List<String> searchStrings = [];
    if (tool.searchKeys == null || tool.searchKeys.where((element) => element != null && element.isNotEmpty).isEmpty)
      continue;

    for (String searchKey in tool.searchKeys) {
      var commonStrings = _COMMON_SEARCHSTRINGS[searchKey];
      var enStrings = _EN_SEARCHSTRINGS[searchKey];
      var localeStrings = _LOCALE_SEARCHSTRINGS[searchKey];

      if (commonStrings != null && commonStrings.isNotEmpty) searchStrings.add(commonStrings);
      if (enStrings != null && enStrings.isNotEmpty) searchStrings.add(enStrings);
      if (localeStrings != null && localeStrings.isNotEmpty) searchStrings.add(localeStrings);
    }

    var _toolName;
    if (tool.toolName != null) {
      _toolName = removeAccents(tool.toolName).toLowerCase().replaceAll(RegExp(r'\s+'), '');
    }
    var _indexedSearchStrings =
        removeAccents(searchStrings.join(' ').toLowerCase()).replaceAll(ALLOWED_SEARCH_CHARACTERS, '');
    if (_indexedSearchStrings == null || _indexedSearchStrings.length == 0) {
      if (_toolName != null) tool.indexedSearchStrings = _toolName;
      continue;
    }

    tool.indexedSearchStrings = _removeDuplicates(_indexedSearchStrings + ' ' + (_toolName ?? ''));
  }
}

String _removeDuplicates(String strings) {
  return strings.split(REGEXP_SPLIT_STRINGLIST).toSet().join(' ');
}
