import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  static const Locale _defaultAppLocale = DEFAULT_LOCALE; // Locale('en', 'US');
  Locale _appLocale = _defaultAppLocale;

  Locale get appLocal => _appLocale ?? _defaultAppLocale;
  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString(PREFERENCE_LANGUAGE_CODE);
    if (lang == null) {
      Locale platformLocale = getPlatformLocale();
      _appLocale = isLocaleSupported(platformLocale) ? platformLocale : _defaultAppLocale;
      return _appLocale;
    }
    _appLocale = Locale(lang);
    return _appLocale;
  }

  Locale getPlatformLocale() {
    final String lang = ui.window.locale.languageCode.split("_")[0];
    return Locale(lang);
  }

  void changeLocale(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale.languageCode == locale.languageCode) {
      // no need to change
      return;
    }

    _appLocale = Locale(locale.languageCode);
    await prefs.setString(PREFERENCE_LANGUAGE_CODE, _appLocale.languageCode);

    notifyListeners();
  }

  void changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    changeLocale(locale);
  }
}
