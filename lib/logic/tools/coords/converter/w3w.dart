import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:prefs/prefs.dart';
import 'package:what3words/what3words.dart';

final WHAT3WORDS_SUPPORTED_LANGUAGE = {};

String result_words = '';
LatLng result_coords;

Future<LatLng> _wToL(String words, String language) async {
  String APIKey = Prefs.getString('coord_default_w3w_apikey');
  if (APIKey == null || APIKey == '') return LatLng(0.0, 0.0);
  var api = What3WordsV3(APIKey);
  var coordinates = await api.convertToCoordinates(words).execute();
  double _lat = coordinates.coordinates.lat;
  double _lng = coordinates.coordinates.lng;
  return LatLng(_lat, _lng);
}

LatLng What3WordsToLatLon(String what3words, String language) {
  _wToL(what3words, language).then((value) {
    result_coords = LatLng(value.latitude, value.longitude);
  });
  return result_coords;
}

Future<String> _lToW(LatLng coord, String language) async {
  String APIKey = Prefs.getString('coord_default_w3w_apikey');
  if (APIKey == null || APIKey == '') return 'ERROR';
  var api = What3WordsV3(APIKey);
  var words = await api.convertTo3wa(Coordinates(coord.latitude, coord.longitude)).language(language).execute();
  if (words.isSuccessful())
    return words.words;
  else
    return words.getError().message;
}

String latLonToWhat3Words(LatLng coord, String language) {
  _lToW(coord, language).then((value) {
    result_words = value;
  });
  return result_words;
}
