import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:isolate';

import 'package:latlong2/latlong.dart';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';

const Map<int, CoordinateFormatKey> WHAT3WORDS_CODE = {
  1: CoordinateFormatKey.WHAT3WORDS_DE,
  2: CoordinateFormatKey.WHAT3WORDS_EN,
  3: CoordinateFormatKey.WHAT3WORDS_FR,
  4: CoordinateFormatKey.WHAT3WORDS_IT,
  5: CoordinateFormatKey.WHAT3WORDS_RU,
  6: CoordinateFormatKey.WHAT3WORDS_NL,
  7: CoordinateFormatKey.WHAT3WORDS_SP,
  8: CoordinateFormatKey.WHAT3WORDS_KO,
  9: CoordinateFormatKey.WHAT3WORDS_JA,
  10: CoordinateFormatKey.WHAT3WORDS_ZH,
  11: CoordinateFormatKey.WHAT3WORDS_DK,
  12: CoordinateFormatKey.WHAT3WORDS_CZ,
  13: CoordinateFormatKey.WHAT3WORDS_PL,
};

const Map<CoordinateFormatKey, String> WHAT3WORDS_LANGUAGE = {
  CoordinateFormatKey.WHAT3WORDS_DE: 'common_language_german',
  CoordinateFormatKey.WHAT3WORDS_EN: 'common_language_english',
  CoordinateFormatKey.WHAT3WORDS_FR: 'common_language_french',
  CoordinateFormatKey.WHAT3WORDS_IT: 'common_language_italian',
  CoordinateFormatKey.WHAT3WORDS_RU: 'common_language_russian',
  CoordinateFormatKey.WHAT3WORDS_NL: 'common_language_dutch',
  CoordinateFormatKey.WHAT3WORDS_SP: 'common_language_spanish',
  CoordinateFormatKey.WHAT3WORDS_KO: 'common_language_korean',
  CoordinateFormatKey.WHAT3WORDS_JA:'common_language_japanese' ,
  CoordinateFormatKey.WHAT3WORDS_ZH: 'common_language_chinese',
  CoordinateFormatKey.WHAT3WORDS_DK:'common_language_danish' ,
  CoordinateFormatKey.WHAT3WORDS_CZ: 'common_language_czech',
  CoordinateFormatKey.WHAT3WORDS_PL: 'common_language_polish',
};

class LatLngFromW3WJobData {
  final String words;
  final String APIKey;

  LatLngFromW3WJobData(this.words, this.APIKey);
}

class W3WFromLatLngJobData {
  final LatLng coordinates;
  final CoordinateFormatKey language;
  final String APIKey;

  W3WFromLatLngJobData(this.coordinates, this.language, this.APIKey);
}

class W3WSuggestion {
  final String country;
  final String nearestPlace;
  final String words;
  final String distanceToFocusKm;
  final String rank;
  final String language;
  final String locale;

  W3WSuggestion(
      {required this.country,
        required this.nearestPlace,
        required this.words,
        required this.distanceToFocusKm,
        required this.rank,
        required this.language,
        required this.locale});
}

class W3WResults {
  final int statusCode;
  final String error;
  final String country;
  final String nearestPlace;
  final LatLng square_sw;
  final LatLng square_ne;
  final LatLng coordinates;
  final String words;
  final String map;
  final String locale;
  final String language;
  final List<W3WSuggestion> suggestions;

  W3WResults({
    required this.statusCode,
    required this.error,
    required this.country,
    required this.nearestPlace,
    required this.square_sw,
    required this.square_ne,
    required this.words,
    required this.coordinates,
    required this.map,
    required this.locale,
    required this.language,
    required this.suggestions,
  });
}

final W3WRESULTS_EMPTY = W3WResults(
  statusCode: 0,
  error: '',
  country: '',
  nearestPlace: '',
  square_sw: const LatLng(0.0, 0.0),
  square_ne: const LatLng(0.0, 0.0),
  coordinates: const LatLng(0.0, 0.0),
  words: '',
  map: '',
  locale: '',
  language: '',
  suggestions: [],
);

const _URL_w3wToCoordinate = 'https://api.what3words.com/v3/convert-to-coordinates';
const _URL_coordinates2w2w = 'https://api.what3words.com/v3/convert-to-3wa';
const _URL_autosuggest = 'https://api.what3words.com/v3/autosuggest';

String _convertLanguageFromFormatKey(CoordinateFormatKey formatKey) {
  switch (formatKey) {
    case CoordinateFormatKey.WHAT3WORDS_DE:
      return 'de';
    case CoordinateFormatKey.WHAT3WORDS_EN:
      return 'en';
    case CoordinateFormatKey.WHAT3WORDS_FR:
      return 'fr';
    case CoordinateFormatKey.WHAT3WORDS_ZH:
      return 'zh';
    case CoordinateFormatKey.WHAT3WORDS_DK:
      return 'da';
    case CoordinateFormatKey.WHAT3WORDS_NL:
      return 'nl';
    case CoordinateFormatKey.WHAT3WORDS_IT:
      return 'it';
    case CoordinateFormatKey.WHAT3WORDS_JA:
      return 'ja';
    case CoordinateFormatKey.WHAT3WORDS_KO:
      return 'ko';
    case CoordinateFormatKey.WHAT3WORDS_PL:
      return 'pl';
    case CoordinateFormatKey.WHAT3WORDS_RU:
      return 'ru';
    case CoordinateFormatKey.WHAT3WORDS_SP:
      return 'sp';
    case CoordinateFormatKey.WHAT3WORDS_CZ:
      return 'cs';
    default:
      return 'en';
  }
}

W3WResults _errorHandlingW3WResults(http.Response response) {
  String error = '';
  switch (response.statusCode) {
    case 400:
      break;
    case 401:
      break;
    case 404:
      break;
    case 405:
      break;
    default:
  }
  return W3WResults(
    statusCode: response.statusCode,
    error: error,
    country: '',
    nearestPlace: '',
    square_sw: const LatLng(0.0, 0.0),
    square_ne: const LatLng(0.0, 0.0),
    coordinates: const LatLng(0.0, 0.0),
    words: '',
    map: '',
    locale: '',
    language: '',
    suggestions: [],
  );
}

List<W3WSuggestion> _analyzeSuggestions(http.Response suggestionsW3W) {
  List<W3WSuggestion> result = [];
  if (suggestionsW3W.statusCode == 200) {
    String data = suggestionsW3W.body;
    var decodedData = json.decode(data);
    List<dynamic> suggestions = decodedData['suggestions'] as List<dynamic>;
    for (var suggestion in suggestions) {
      result.add(W3WSuggestion(
        country: decodedData['country'].toString(),
        nearestPlace: suggestion['nearestPlace'].toString(),
        words: suggestion['words'].toString(),
        distanceToFocusKm: suggestion['distanceToFocusKm'].toString(),
        rank: suggestion['rank'].toString(),
        language: suggestion['language'].toString(),
        locale: suggestion['locale'].toString(),
      ));
    }
  }
  return result;
}

W3WResults _analyzeHttpResponse(http.Response response, {http.Response? suggestionsW3W}) {
  if (response.statusCode == 200) {
    String data = response.body;
    var decodedData = json.decode(data);
    double sw_lat = double.parse(decodedData['square']['southwest']['lat'].toString());
    double sw_lon = double.parse(decodedData['square']['southwest']['lng'].toString());
    double ne_lat = double.parse(decodedData['square']['northeast']['lat'].toString());
    double ne_lon = double.parse(decodedData['square']['northeast']['lng'].toString());
    double ct_lat = double.parse(decodedData['coordinates']['lat'].toString());
    double ct_lon = double.parse(decodedData['coordinates']['lng'].toString());
    return W3WResults(
      statusCode: 200,
      error: '',
      country: decodedData['country'].toString(),
      nearestPlace: decodedData['nearestPlace'].toString(),
      square_sw: LatLng(sw_lat, sw_lon),
      square_ne: LatLng(ne_lat, ne_lon),
      coordinates: LatLng(ct_lat, ct_lon),
      words: decodedData['words'].toString(),
      map: decodedData['map'].toString(),
      locale: decodedData['locale'].toString(),
      language: decodedData['language'].toString(),
      suggestions: suggestionsW3W != null ? _analyzeSuggestions(suggestionsW3W) : [],
    );
  } else {
    return _errorHandlingW3WResults(response);
  }
}

Future<W3WResults> convertLatLonFromW3Wasync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! LatLngFromW3WJobData) {
    return Future.value(W3WRESULTS_EMPTY);
  }

  var buildLatLonjob = jobData!.parameters as LatLngFromW3WJobData;
  var output =
  await _getLatLonFromW3W(buildLatLonjob.words, buildLatLonjob.APIKey, sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<W3WResults> _getLatLonFromW3W(String words, String APIKey, {required SendPort sendAsyncPort}) async {
  String address = _URL_w3wToCoordinate + '?words=' + words + '&key=' + APIKey + '&format=json';
  http.Response response = await http.get(Uri.parse(address));

  address = _URL_autosuggest + '?input=' + words + '&key=' + APIKey + '&format=json';
  http.Response suggestions = await http.get(Uri.parse(address));
  return _analyzeHttpResponse(response, suggestionsW3W: suggestions);
}

Future<W3WResults> convertW3WFromLatLngAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! W3WFromLatLngJobData) {
    return Future.value(W3WRESULTS_EMPTY);
  }

  var buildW3Wjob = jobData!.parameters as W3WFromLatLngJobData;
  var output = await _getW3WFromLatLng(buildW3Wjob.coordinates, buildW3Wjob.APIKey, buildW3Wjob.language,
      sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<W3WResults> _getW3WFromLatLng(LatLng coordinates, String APIKey, CoordinateFormatKey language,
    {required SendPort sendAsyncPort}) async {
  String address = _URL_coordinates2w2w +
      '?key=' +
      APIKey +
      '&coordinates=' +
      coordinates.latitude.toString() +
      ',' +
      coordinates.longitude.toString() +
      '&language=' +
      _convertLanguageFromFormatKey(language) +
      '&format=json';
  http.Response response = await http.get(Uri.parse(address));
  return _analyzeHttpResponse(
    response,
  );
}