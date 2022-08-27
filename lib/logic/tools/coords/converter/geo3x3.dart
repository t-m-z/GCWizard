import 'package:gc_wizard/logic/tools/coords/converter/taisukef/geo3x3/geo3x3.dart' as Geo3x3Converter;
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong2/latlong.dart';

LatLng geo3x3ToLatLon(Geo3x3 geo3x3) {
  var latLon = Geo3x3Converter.Geo3x3.decode(geo3x3.text.toUpperCase());
  return latLon == null ? null : LatLng(latLon[0], latLon[1]);
}

Geo3x3 parseGeo3x3(String input) {
  if (input == null) return null;
  input = input.trim();
  if (input == '') return null;

  input = input.toUpperCase();
  if (RegExp(r'[EeWw][1-9]+').hasMatch(input)) {
    var geo3x3 = Geo3x3(input);
    var latLon = geo3x3ToLatLon(geo3x3);
    return latLon == null ? null : geo3x3;
  }

  return null;
}

Geo3x3 latLonToGeo3x3(LatLng coord, int level) {
  return Geo3x3(Geo3x3Converter.Geo3x3.encode(coord.latitude, coord.longitude, level));
}
