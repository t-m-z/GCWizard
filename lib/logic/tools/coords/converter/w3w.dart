import 'package:latlong/latlong.dart';
import 'package:prefs/prefs.dart';
import 'package:what3words/what3words.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
final WHAT3WORDS_SUPPORTED_LANGUAGE = {};

final Map<String, String> WHAT3WORDS_LANGUAGES = {
  'de' : 'common_language_german',
  'fr' : 'common_language_french',
  'en' : 'common_language_english',
  'it' : 'common_language_italian',
  'nl' : 'common_language_dutch',
  'sv' : 'common_language_swedish',
  'es' : 'common_language_spanish',
  'pl' : 'common_language_polish',
  'da' : 'common_language_danish',
  'no' : 'common_language_norwegian',
  'pt' : 'common_language_portuguese',
  'ru' : 'common_language_russian',
  'cs' : 'common_language_czech',
  'sk' : 'common_language_slovak',
  'el' : 'common_language_greek',
  'tr' : 'common_language_turkish',
  'ro' : 'common_language_romanian',
  'hi' : 'common_language_hindi',
  'ta' : 'common_language_tamil',
  'he' : 'common_language_hebrew',
  'hu' : 'common_language_hungarian',
  'ar' : 'common_language_arabic',
  'zu' : 'common_language_zulu',
  'zh' : 'common_language_chinese',
  'ja' : 'common_language_japanese',
  'af' : 'common_language_afrikaans',
  'bg' : 'common_language_bulgarian',
  'bn' : 'common_language_bengali',
  'uk' : 'common_language_ukrain',
  'id' : 'common_language_indonesia',
  'ur' : 'common_language_urdu',
  'ml' : 'common_language_malayalam',
  'mn' : 'common_language_mongolian',
  'kn' : 'common_language_kannada',
  'ko' : 'common_language_korean',
  'sw' : 'common_language_swahili',
  'mr' : 'common_language_marathi',
  'ms' : 'common_language_malaysia',
  'am' : 'common_language_amharic',
  'gu' : 'common_language_gujarati',
  'xh' : 'common_language_xhosa',
  'pa' : 'common_language_punjabi',
  'te' : 'common_language_telugu',
  'vi' : 'common_language_vietnamese',
  'th' : 'common_language_thai',
  'cy' : 'common_language_welsh',
  'ne' : 'common_language_nepali',
};

String result_words = '';
LatLng result_coords;

Future <LatLng> _wToL (String words, String language) async {
  //TO DO check api-key
  var api = What3WordsV3(Prefs.getString('coord_default_w3w_apikey'));
  var coordinates = await api.convertToCoordinates(words).execute();
  double _lat = coordinates.coordinates.lat;
  double _lng = coordinates.coordinates.lng;
  return LatLng(_lat, _lng);
}

LatLng What3WordsToLatLon (String what3words, String language) {
  _wToL(what3words, language).then((value) {
    result_coords = LatLng(value.latitude, value.longitude);
  });
  return result_coords;
}


Future <String> _lToW (LatLng coord, String language) async {
  //TO DO check api-key
  var api = What3WordsV3(Prefs.getString('coord_default_w3w_apikey'));
  var words = await api.convertTo3wa(Coordinates(coord.latitude, coord.longitude))
      .language(language)
      .execute();
  if (words.isSuccessful())
    return words.words;
  else
    return words.getError().message;
}

String latLonToWhat3Words (LatLng coord, String language)  {
  _lToW(coord, language).then((value) {
    result_words = value;
  });
  return result_words;
}