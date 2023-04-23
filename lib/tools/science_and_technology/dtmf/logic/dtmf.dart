import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

final Map<String, AssetSource> DTMFSOUND = {
  '0': AssetSource('audio/DTMF0.mp3'),
  '1': AssetSource('audio/DTMF1.mp3'),
  '2': AssetSource('audio/DTMF2.mp3'),
  '3': AssetSource('audio/DTMF3.mp3'),
  '4': AssetSource('audio/DTMF4.mp3'),
  '5': AssetSource('audio/DTMF5.mp3'),
  '6': AssetSource('audio/DTMF6.mp3'),
  '7': AssetSource('audio/DTMF7.mp3'),
  '8': AssetSource('audio/DTMF8.mp3'),
  '9': AssetSource('audio/DTMF9.mp3'),
  'A': AssetSource('audio/DTMFA.mp3'),
  'B': AssetSource('audio/DTMFB.mp3'),
  'C': AssetSource('audio/DTMFC.mp3'),
  'D': AssetSource('audio/DTMFD.mp3'),
  '*': AssetSource('audio/DTMFStar.mp3'),
  '#': AssetSource('audio/DTMFPound.mp3'),
};

const Map<String, List<int>> _DigitToDTMF = {
  '1': [697, 1209],
  '2': [697, 1336],
  '3': [697, 1477],
  'A': [697, 1633],
  '4': [770, 1209],
  '5': [770, 1336],
  '6': [770, 1477],
  'B': [770, 1633],
  '7': [852, 1209],
  '8': [852, 1336],
  '9': [852, 1477],
  'C': [852, 1633],
  '*': [941, 1209],
  '0': [941, 1336],
  '#': [941, 1477],
  'D': [941, 1633]
};
final _DTMFToDigit = switchMapKeyValue(_DigitToDTMF);

final DTMF_FREQUENCIES_LOW = [697, 770, 852, 941];
final DTMF_FREQUENCIES_HIGH = [1209, 1336, 1477, 1633];
var _dtmfFrequencies = DTMF_FREQUENCIES_LOW + DTMF_FREQUENCIES_HIGH;

String encodeDTMF(String plain) {
  return plain
      .toUpperCase()
      .split('')
      .where((digit) => _DigitToDTMF[digit] != null)
      .map((digit) => _DigitToDTMF[digit])
      .join('\u2003');
}

String decodeDTMF(String chiffre) {
  var _chiffreList = chiffre.split(RegExp(r'\D'));

  var _chiffreListClean = _chiffreList
      .map((chiffre) => int.tryParse(chiffre))
      .where((chiffre) => chiffre != null && _dtmfFrequencies.contains(chiffre))
      .toList();

  var _dtmfCodes = <List<int?>>[];
  for (var i = 0; i < _chiffreListClean.length - 1; i = i + 2) {
    if (i + 1 <= _chiffreListClean.length - 1) {
      var _tones = [_chiffreListClean[i], _chiffreListClean[i + 1]];
      _tones.sort();
      _dtmfCodes.add(_tones);
    }
  }

  return _dtmfCodes.map((frequencies) {
    var character = _DTMFToDigit.entries.firstWhereOrNull((entry) {
      return entry.key.join() == frequencies.join();
    });

    if (character == null) return '';

    return character.value;
  }).join();
}
