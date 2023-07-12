import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/pokemon/logic/pokemon.dart';
import 'package:gc_wizard/utils/constants.dart';

void main() {
  group("Pokemon.encodePokemon:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'cache nord drei vier sechs acht', 'expectedOutput' : 'FLAPIFLAKASA TUSAMKLALU LUKLASAFLOR ASFLORSAKLA SESAFLAKASE PIFLAKADA'},

    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodePokemon(elem['input'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Pokemon.decodePokemon:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'se', 'expectedOutput' : 'S'},
      {'input' : 'sew', 'expectedOutput' : UNKNOWN_ELEMENT},
      {'input' : 'x', 'expectedOutput' : UNKNOWN_ELEMENT},
      {'input' : 'x sa', 'expectedOutput' : UNKNOWN_ELEMENT + ' E'},
      {'input' : 'x sa y', 'expectedOutput' : UNKNOWN_ELEMENT + ' E ' + UNKNOWN_ELEMENT},

      {'input' : 'Piluffme luflorsasesa Florlusasa manpison sonsaflortu SesamkatuMansamsonsonpi lupi sakla arsaklatusa Regsammansasonsamtu seregflorsakarda lufftulu saflortusa Assaklamonflortululufftuar zuluffson Arsasamflapiflakasatu mosamkarkardasaReglufftumanda', 'expectedOutput' : 'AUF DIESE IDEE KAM MEIN SOHNKOMMA DA ER GERNE POKEMON SPIELT UND EINE VERBINDUNG ZUM GEOCACHEN WOLLTEPUNKT'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = decodePokemon(elem['input'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}