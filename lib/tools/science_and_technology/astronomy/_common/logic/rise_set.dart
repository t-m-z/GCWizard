import 'package:gc_wizard/tools/science_and_technology/astronomy/_common/logic/external_libs/cosinekitty.astronomy/astronomy.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';

enum RiseSetType {RISE, CULMINATION, SET}

List<(RiseSetType, DateTime)> getRiseSetsAtDay(RiseSetUTC riseCulSets, DateTimeUTCwithTZ dateTime, {bool strict = false}) {

  var riseSets = <(RiseSetType, DateTime)>[];
  for (var rise in riseCulSets.rises) {
    riseSets.add((RiseSetType.RISE, DateTimeUTCwithTZ(dateTimeUtc: rise, timezoneOffset: dateTime.timezoneOffset).toLocalTime()));
  }
  for (var culmination in riseCulSets.culminations) {
    riseSets.add((RiseSetType.CULMINATION, DateTimeUTCwithTZ(dateTimeUtc: culmination, timezoneOffset: dateTime.timezoneOffset).toLocalTime()));
  }
  for (var set in riseCulSets.sets) {
    riseSets.add((RiseSetType.SET, DateTimeUTCwithTZ(dateTimeUtc: set, timezoneOffset: dateTime.timezoneOffset).toLocalTime()));
  }
  riseSets.sort((a, b) => a.$2.compareTo(b.$2));

  var _day = dateTime.toLocalTime();

  var finalRS = <(RiseSetType, DateTime)>[];

  for (int i = 0; i < riseSets.length; i++) {
    var rs = riseSets[i];
    if (rs.$2.isBefore(_day)) continue;

    if (finalRS.isEmpty) {
      finalRS.add(rs);
      if (!strict) {
        var j = i - 1;
        while (j >= 0 && finalRS.first.$1 != RiseSetType.RISE) {
          finalRS.insert(0, riseSets[j]);
          j--;
        }
      }
      continue;
    }

    if (rs.$2.isAfter(_day.add(Duration(days: 1)))) {
      if (strict) {
        break;
      }

      var j = i;
      while (j < riseSets.length && finalRS.last.$1 != RiseSetType.SET) {
        finalRS.add(riseSets[j]);
        j++;
      }
      break;
    }

    finalRS.add(rs);
  }

  return finalRS;
}