import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/logic/projection.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_rgb.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/general_tools/randomizer/logic/randomizer_cards.dart';
part 'package:gc_wizard/tools/general_tools/randomizer/logic/randomizer_lists.dart';
part 'package:gc_wizard/tools/general_tools/randomizer/logic/randomizer_password.dart';
part 'package:gc_wizard/tools/general_tools/randomizer/logic/randomizer_rockpaperscissors.dart';

String randomLetter(Alphabet alphabet, bool caseSensitive) {
  var length = alphabet.alphabet.length;
  var random = getRandom();
  var randomIndex = random.nextInt(length);
  var randomLetter = alphabet.alphabet.keys.toList()[randomIndex];

  if (!caseSensitive) {
    var randomCase = random.nextInt(2);
    randomLetter = randomCase == 0 ? randomLetter.toUpperCase() : randomLetter.toLowerCase();
  }
  return randomLetter;
}

int randomInteger(int start, int end) {
  if (start > end) {
    var temp = end;
    end = start;
    start = temp;
  }

  return getRandom().nextInt(end + 1 - start) + start;
}

double randomDouble(double start, double end) {
  if (start > end) {
    var temp = end;
    end = start;
    start = temp;
  }

  return getRandom().nextDouble() * (end - start) + start;
}

RGB randomColor() {
  var random = getRandom();
  var r = random.nextInt(256);
  var g = random.nextInt(256);
  var b = random.nextInt(256);

  return RGB(r.toDouble(), g.toDouble(), b.toDouble());
}

DateTime randomDateTime(DateTime from, DateTime to) {
  var seconds = to.difference(from).inSeconds;
  var randomSeconds = randomInteger(0, seconds);
  return from.add(Duration(seconds: randomSeconds));
}

LatLng randomCoordinateAroundPoint(LatLng center, double maxDistance, Ellipsoid ellipsoid) {
  var bearing = randomDouble(0.0, 360.0);
  var distance = randomDouble(0.0, maxDistance);

  return projection(center, bearing, distance, ellipsoid);
}

LatLng randomCoordinateInsideBounds(LatLng northWest, LatLng southEast) {
  var north = northWest.latitude;
  var west = northWest.longitude;
  var south = southEast.latitude;
  var east = southEast.longitude;

  if (west > east) {
    east += 360.0;
  }

  var lat = randomDouble(south, north);
  var lon = randomDouble(west, east);

  if (lon > 180.0) {
    lon -= 360.0;
  }

  return LatLng(lat, lon);
}

String shuffleString(String text, bool removeWhitespace) {
  var _text = text;
  if (removeWhitespace) {
    _text = _text.replaceAll(RegExp(r'\s'), '');
  }

  var list = shuffleList(_text.split('').toList());
  return list.join();
}

String shuffleLines(String text) {
  var list = shuffleList(text.split(RegExp(r'\r?\n')).toList());
  return list.join('\n');
}