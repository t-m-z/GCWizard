import 'package:latlong/latlong.dart';
import 'package:prefs/prefs.dart';
import 'package:what3words/what3words.dart';

enum What3WordsLanguage {DE, FR, EN, IT, NL, SV, ES, PL, DA, NO, PT, RU, CS, SK, EL}
final Map<What3WordsLanguage, String> WHAT3WORDS_LANGUAGES = {
  What3WordsLanguage.DE : 'common_language_german',
  What3WordsLanguage.FR : 'common_language_french',
  What3WordsLanguage.EN : 'common_language_english',
  What3WordsLanguage.IT : 'common_language_italian',
  What3WordsLanguage.NL : 'common_language_dutch',
  What3WordsLanguage.SV : 'common_language_swedish',
  What3WordsLanguage.ES : 'common_language_spanish',
  What3WordsLanguage.PL : 'common_language_polish',
  What3WordsLanguage.DA : 'common_language_danish',
  What3WordsLanguage.NO : 'common_language_norwegian',
  What3WordsLanguage.PT : 'common_language_portuguese',
  What3WordsLanguage.RU : 'common_language_russian',
  What3WordsLanguage.CS : 'common_language_czech',
  What3WordsLanguage.SK : 'common_language_slovak',
  What3WordsLanguage.EL : 'common_language_greek',
};
final Map<What3WordsLanguage, String> language = {
  What3WordsLanguage.DE : 'de',
  What3WordsLanguage.FR : 'fr',
  What3WordsLanguage.EN : 'en',
  What3WordsLanguage.IT : 'it',
  What3WordsLanguage.NL : 'nl',
  What3WordsLanguage.SV : 'sv',
  What3WordsLanguage.ES : 'es',
  What3WordsLanguage.PL : 'pl',
  What3WordsLanguage.DA : 'da',
  What3WordsLanguage.NO : 'no',
  What3WordsLanguage.PT : 'pt',
  What3WordsLanguage.RU : 'ru',
  What3WordsLanguage.CS : 'cs',
  What3WordsLanguage.SK : 'sk',
  What3WordsLanguage.EL : 'el',
};

String result_words = '';
LatLng result_coords;

Future <LatLng> _wToL (String words) async {
  var api = What3WordsV3(Prefs.getString('coord_default_w3w_apikey'));
  var coordinates = await api.convertToCoordinates(words).execute();
  return LatLng(coordinates.coordinates.lat, coordinates.coordinates.lng);
}

LatLng What3WordsToLatLon (String what3words) {
  _wToL(what3words).then((value) {
    result_coords = LatLng(value.latitude, value.longitude);
  });
  return result_coords;
}


Future <String> _lToW (LatLng coord, String language) async {
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