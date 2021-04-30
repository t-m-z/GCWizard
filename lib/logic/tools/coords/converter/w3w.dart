import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:prefs/prefs.dart';
import 'package:what3words/what3words.dart';

String _result_words = '';
LatLng _result_coords;

Future<LatLng> _wToL(String words, String language) async {
  String _APIKey = '';
  _APIKey = Prefs.getString('coord_default_w3w_apikey');
  if (_APIKey == null || _APIKey == '') return LatLng(0.0, 0.0);
  var _api = What3WordsV3(_APIKey);
  var _coordinates = await _api.convertToCoordinates(words).execute();
  return LatLng(_coordinates.coordinates.lat, _coordinates.coordinates.lng);
}

LatLng What3WordsToLatLon(String what3words, String language) {
  _wToL(what3words, language).then((value) {
    _result_coords = LatLng(value.latitude, value.longitude);
  });
  return _result_coords;
}

Future _lToW(LatLng coord, String language) async {
  String _APIKey = '';
  _APIKey = Prefs.getString('coord_default_w3w_apikey');
  if (_APIKey == null || _APIKey == '') return 'ERROR';
  var _api = What3WordsV3(_APIKey);
  var _words = await _api
      .convertTo3wa(Coordinates(coord.latitude, coord.longitude))
      .language(language)
      .execute();

  if (_words.isSuccessful()) {
    _result_words = _words.words;
  } else {
    _result_words = _words.getError().message;
  }
  return _result_words;
}

String latLonToWhat3Words(LatLng coord, String language) {
  _lToW(coord, language).then((value) {
    _result_words = value;
    return _result_words;
  });
  return _result_words;
}
