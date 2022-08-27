// https://www.geocaching.com/geocache/GC79E3Z_nah-am-wasser-gebaut
// 66730386309934047230685502248
// 078658068550685506386
//
//
// 678068550685506386047230386303863 07865807432360386308437

import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';

class VanityWordsDecodeOutput {
  final String number;
  final String numWord;
  final String digit;
  final bool ambigous;
  VanityWordsDecodeOutput(this.number, this.numWord, this.digit, this.ambigous);
}

final VanityToDEU = {
  '6855': 'NULL',
  '3467': 'EINS',
  '9934': 'ZWEI',
  '996': 'ZWO',
  '3734': 'DREI',
  '8437': 'VIER',
  '38363': 'FUENF',
  '3863': 'FÜNF',
  '73247': 'SECHS',
  '743236': 'SIEBEN',
  '2248': 'ACHT',
  '6386': 'NEUN',
  '6673': 'NORD',
  '678': 'OST',
  '9378': 'WEST',
  '7833': 'SUED',
  '783': 'SÜD',
  '4723': 'GRAD',
  '78658': 'PUNKT',
};
final VanityToENG = {
  '9376': 'ZERO',
  '663': 'ONE',
  '896': 'TWO',
  '84733': 'THREE',
  '3687': 'FOUR',
  '3483': 'FIVE',
  '749': 'SIX',
  '73836': 'SEVEN',
  '34448': 'EIGHT',
  '6386': 'NINE',
  '66784': 'NORTH',
  '3278': 'EAST',
  '9378': 'WEST',
  '76884': 'SOUTH',
  '334733': 'DEGREE',
  '76468': 'POINT',
};
final VanityToFRA = {
  '9376': 'ZÉRO',
  '86': 'UN',
  '3389': 'DEUX',
  '8764': 'TROIS',
  '782873': 'QUATRE',
  '2467': 'CINQ',
  '749': 'SIX',
  '7378': 'SEPT',
  '4848': 'HUIT',
  '6386': 'NEUF',
  '6673': 'NORD',
  '378': 'EST',
  '68378': 'OUEST',
  '783': 'SUD',
  '33473': 'DEGRÉ',
  '76468': 'POINT',
};
final VanityToITA = {
  '9376': 'ZERO',
  '866': 'UNO',
  '383': 'DUE',
  '873': 'TRE',
  '7828876': 'QUATTRO',
  '346783': 'CINQUE',
  '734': 'SEI',
  '73883': 'SETTE',
  '6886': 'OTTO',
  '6683': 'NOVE',
  '6673': 'NORD',
  '378': 'EST',
  '68378': 'OVEST',
  '783': 'SUD',
  '47236': 'GRADO',
  '78686': 'PUNTO',
};
final VanityToDNK = {
  '685': 'NUL',
  '36': 'EN',
  '86': 'TO',
  '873': 'TRE',
  '3473': 'FIRE',
  '336': 'FEM',
  '7253': 'SEKS',
  '7983': 'SYVE',
  '6883': 'OTTE',
  '64': 'NI',
  '6673': 'NORD',
  '678': 'ØST',
  '8378': 'VEST',
  '793': 'SYD',
  '4723': 'GRAD',
  '78658': 'PUNKT',
};
final VanityToESP = {
  '2376': 'CERO',
  '876': 'UNO',
  '872': 'UNA',
  '367': 'DOS',
  '8737': 'TRES',
  '282876': 'CUATRO',
  '24626': 'CINCO',
  '7347': 'SEIS',
  '74383': 'SIETE',
  '6246': 'OCHO',
  '68383': 'NUEVE',
  '66783': 'NORTE',
  '3783': 'ESTE',
  '63783': 'OESTE',
  '787': 'SUR',
  '47236': 'GRADO',
  '78686': 'PUNTO',
};
final VanityToNLD = {
  '685': 'NUL',
  '336': 'EEN',
  '9933': 'TWEE',
  '3743': 'DRIE',
  '8437': 'VIER',
  '8453': 'VIJF',
  '937': 'ZES',
  '93836': 'ZEVEN',
  '2248': 'ACHT',
  '6343': 'NEGEN',
  '66673': 'NOORD',
  '6678': 'OOST',
  '9378': 'WEST',
  '9843': 'ZUID',
  '47223': 'GRAAD',
  '7868': 'PUNT',
};
final VanityToNOR = {
  '685': 'NUL',
  '36': 'EN',
  '388': 'ETT',
  '86': 'TO',
  '873': 'TRE',
  '3473': 'FIRE',
  '336': 'FEM',
  '7357': 'SEKS',
  '758': 'SJU',
  '798': 'SYV',
  '2883': 'ÅTTE',
  '64': 'NI',
  '6673': 'NORD',
  '678': 'ØST',
  '8378': 'VEST',
  '767': 'SØR',
  '4723': 'GRAD',
  '78658': 'PUNKT',
};
final VanityToPOL = {
  '9376': 'ZERO',
  '53336': 'JEDEN',
  '53362': 'JEDNA',
  '53366': 'JEDNO',
  '392': 'DWA',
  '3943': 'DWIE',
  '8779': 'TRZY',
  '298379': 'CZTERY',
  '7342': 'PIĘĆ',
  '79372': 'SZEŚĆ',
  '743336': 'SIEDEM',
  '67436': 'OSIEM',
  '39439432': 'DZIEWIĘĆ',
  '76566269': 'PÓŁNOC',
  '972463': 'WSCHÓD',
  '922463': 'ZACHÓD',
  '76583643': 'POŁUDNIE',
  '7867436': 'STOPIEŃ',
  '78658': 'PUNKT',
};
final VanityToPOR = {
  '9376': 'ZERO',
  '86': 'UM',
  '3647': 'DOIS',
  '3827': 'DUAS',
  '8737': 'TRES',
  '72876': 'QUATRO',
  '24626': 'CINCO',
  '7347': 'SEIS',
  '7393': 'SETE',
  '6886': 'OITO',
  '6683': 'NOVE',
  '66783': 'NORTE',
  '53783': 'LESTE',
  '63783': 'OESTE',
  '785': 'SUL',
  '4728': 'GRAU',
  '76686': 'PONTO',
};
final VanityToSWE = {
  '8655': 'NOLL',
  '36': 'EN',
  '388': 'ETT',
  '882': 'TVÅ',
  '873': 'TRE',
  '3972': 'FYRA',
  '336': 'FEM',
  '739': 'SEX',
  '758': 'SJU',
  '2882': 'ÅTTA',
  '646': 'NIO',
  '6677': 'NORR',
  '678': 'OST',
  '8378': 'VÄST',
  '793': 'SYD',
  '4723': 'GRAD',
  '78658': 'PUNKT',
};
final VanityToRUS = {
  '665': 'NOL',
  '685': 'NUL',
  '2363': 'ADNA',
  '2366': 'ADNO',
  '2346': 'ADIN',
  '392': 'DWA',
  '3953': 'DWJE',
  '874': 'TRI',
  '2389743': 'ČETÝRJE',
  '7528': 'PJAT',
  '7378': 'ŠEST',
  '736': 'SEM',
  '86736': 'VOSEM',
  '3538528': 'DJÈVJAT',
  '73837': 'SEVER',
  '867865': 'VOSTOK',
  '92723': 'ZAPAD',
  '984': 'YUG',
  '4723': 'GRAD',
  '862454': 'TOCHKI',
};
final VanityToVOL = {
  '737': 'SER',
  '225': 'BAL',
  '835': 'TEL',
  '545': 'KIL',
  '365': 'FOL',
  '585': 'LUL',
  '6235': 'MAEL',
  '935': 'VEL',
  '5635': 'JOEL',
  '9835': 'ZUEL',
};
final VanityToEPO = {
  '6856': 'NULO',
  '868': 'UNU',
  '38': 'DU',
  '874': 'TRI',
  '5927': 'KVAR',
  '5946': 'KVIN',
  '737': 'SES',
  '737': 'SEP',
  '65': 'OK',
  '628': 'NAŬ',
};
final VanityToSOL = {
  '76536': 'SOLDO',
  '733636': 'REDODO',
  '736464': 'REMIMI',
  '733232': 'REFAFA',
  '73765765': 'RESOLSOL',
  '735252': 'RELALA',
  '737474': 'RESISI',
  '646436': 'MIMIDO',
  '646473': 'MIMIRE',
  '646432': 'MIMIFA',
};
final VanityToLAT = {
  '93786': 'ZERUM',
  '685586': 'NULLUM',
  '8687': 'UNUS',
  '386': 'DUO',
  '8742': 'TRIA',
  '8737': 'TRES',
  '78288867': 'QUATTUOR',
  '7846783': 'QUINQUE',
  '43927': 'HEXAS',
  '739': 'SEX',
  '737836': 'SEPTEM',
  '6286': 'OCTO',
  '66836': 'NOVEM',
};

Map VanWords = {
  NumeralWordsLanguage.DEU: VanityToDEU,
  NumeralWordsLanguage.ENG: VanityToENG,
  NumeralWordsLanguage.FRA: VanityToFRA,
  NumeralWordsLanguage.ITA: VanityToITA,
  NumeralWordsLanguage.DNK: VanityToDNK,
  NumeralWordsLanguage.ESP: VanityToESP,
  NumeralWordsLanguage.NLD: VanityToNLD,
  NumeralWordsLanguage.NOR: VanityToNOR,
  NumeralWordsLanguage.POL: VanityToPOL,
  NumeralWordsLanguage.POR: VanityToPOR,
  NumeralWordsLanguage.SWE: VanityToSWE,
  NumeralWordsLanguage.RUS: VanityToRUS,
  NumeralWordsLanguage.VOL: VanityToVOL,
  NumeralWordsLanguage.EPO: VanityToEPO,
  NumeralWordsLanguage.SOL: VanityToSOL,
  NumeralWordsLanguage.LAT: VanityToLAT
};

Map<NumeralWordsLanguage, String> VANITYWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU: 'common_language_german',
  NumeralWordsLanguage.ENG: 'common_language_english',
  NumeralWordsLanguage.FRA: 'common_language_french',
  NumeralWordsLanguage.ITA: 'common_language_italian',
  NumeralWordsLanguage.DNK: 'common_language_danish',
  NumeralWordsLanguage.ESP: 'common_language_spanish',
  NumeralWordsLanguage.NLD: 'common_language_dutch',
  NumeralWordsLanguage.NOR: 'common_language_norwegian',
  NumeralWordsLanguage.POL: 'common_language_polish',
  NumeralWordsLanguage.POR: 'common_language_portuguese',
  NumeralWordsLanguage.SWE: 'common_language_swedish',
  NumeralWordsLanguage.RUS: 'common_language_russian',
  NumeralWordsLanguage.VOL: 'common_language_volapuek',
  NumeralWordsLanguage.EPO: 'common_language_esperanto',
  NumeralWordsLanguage.SOL: 'common_language_solresol',
  NumeralWordsLanguage.LAT: 'common_language_latin'
};

List<VanityWordsDecodeOutput> decodeVanityWords(String text, NumeralWordsLanguage language) {
  List<VanityWordsDecodeOutput> output = <VanityWordsDecodeOutput>[];
  if (text == null || text == '') {
    output.add(VanityWordsDecodeOutput('', '', '', false));
    return output;
  }

  // build map to identify numeral words
  Map decodingTable = new Map();
  VanWords[language].forEach((key, value) {
    //decodingTable[key] = removeAccents(value);
    decodingTable[key] = (value);
  });

  // start decoding text with searchlanguages
  bool found = false;
  bool ambigous = false;
  String hDigits = '';
  String hWord = '';
  text = text.replaceAll('\n', '').replaceAll('0', '').replaceAll('1', '').replaceAll(' ', '');
  while (text.length > 0) {
    found = false;
    ambigous = false;
    hDigits = '';
    hWord = '';
    decodingTable.forEach((digits, word) {
      if (text.startsWith(digits)) {
        if (!found) {
          hDigits = digits;
          hWord = word;
          found = true;
        } else {
          // already found
          ambigous = true;
          output.add(VanityWordsDecodeOutput(hDigits, hWord, NumWords[language][hWord.toString().toLowerCase()], true));
          output.add(VanityWordsDecodeOutput(digits, word, NumWords[language][word.toString().toLowerCase()], true));
        }
      }
    }); // end decodingTable.forEach
    if (found && !ambigous) {
      output.add(VanityWordsDecodeOutput(hDigits, hWord, NumWords[language][hWord.toString().toLowerCase()], false));
      if (hDigits.length > 0) {
        text = text.substring(hDigits.length);
      }
    }
    if (!found) {
      output.add(VanityWordsDecodeOutput('?', '', '', false));
      if (text.length > 0) text = text.substring(1);
    }
    if (ambigous) text = '';
  } // end while text.length > 0
  return output;
}
