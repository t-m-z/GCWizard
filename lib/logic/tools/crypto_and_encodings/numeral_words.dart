import 'dart:math';

import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';

// https://www.languagesandnumbers.com/how-to-count-in-volapuk/en/vol/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-solresol/en/solresol/
// https://www.languagesandnumbers.com/how-to-count-in-german/en/deu/
// https://www.languagesandnumbers.com/how-to-count-in-english/en/eng/
// https://www.languagesandnumbers.com/how-to-count-in-polish/en/pol/
// https://www.languagesandnumbers.com/how-to-count-in-portuguese-portugal/en/por-prt/
// https://www.languagesandnumbers.com/how-to-count-in-english/en/eng/
// https://www.languagesandnumbers.com/how-to-count-in-russian/en/rus/
// https://www.languagesandnumbers.com/how-to-count-in-spanish/en/spa/
// https://www.languagesandnumbers.com/how-to-count-in-italian/en/ita/
// https://www.languagesandnumbers.com/how-to-count-in-french/en/fra/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-bulgarian/en/bul/
//
// https://de.wikipedia.org/wiki/Zahlen_in_unterschiedlichen_Sprachen
//
// https://learnnavi.org/navi-vocabulary/
// https://james-camerons-avatar.fandom.com/de/wiki/Oktale_Arithmetik

class OutputConvertToNumeralWord {
  final String numeralWord;
  final String numbersystem;
  final String title;
  final String error;

  OutputConvertToNumeralWord(this.numeralWord, this.numbersystem, this.title, this.error);
}

class OutputConvertToNumber {
  final int number;
  final String numbersystem;
  final String title;
  final String error;

  OutputConvertToNumber(this.number, this.numbersystem, this.title, this.error);
}

class NumeralWordsDecodeOutput {
  final String number;
  final String numWord;
  final String language;

  NumeralWordsDecodeOutput(this.number, this.numWord, this.language);
}

class NumeralWordsOutput {
  final bool state;
  final String output;
  final String language;

  NumeralWordsOutput(this.state, this.output, this.language);
}

enum NumeralWordsLanguage {
  DEU,
  DNK,
  ENG,
  EPO,
  ESP,
  FRA,
  ITA,
  KYR,
  LAT,
  NLD,
  NOR,
  POL,
  POR,
  RUS,
  BUL,
  BULKYR,
  SOL,
  SWE,
  VOL,
  MAP,
  BAS,
  DOT,
  UNG,
  PER,
  AMH,
  VIE,
  VIECHUNOM,
  VIEHANTU,
  VIESINO,
  TUR,
  MEG,
  BRE,
  SCO,
  IND,
  TAM,
  FIN,
  QUE,
  CEQ,
  KLI,
  LOJ,
  JAP,
  JAPHIRAGANA,
  CHI,
  CHISYMBOL,
  CHIZHUYIN,
  CHIFINANCE,
  KOR,
  SINOKOR,
  HANJA,
  HANGULKOR,
  HANGULSINOKOR,
  MIN,
  SHA,
  NAVI,
  THAI,
  THAIRTGS,
  ALL,
  NUM
}

final Map<String, String> DEUWordToNum = {
  'null': '0',
  'eins': '1',
  'zwei': '2',
  'zwo': '2',
  'drei': '3',
  'vier': '4',
  'fuenf': '5',
  'sechs': '6',
  'sieben': '7',
  'acht': '8',
  'neun': '9',
  'zehn': '10',
  'elf': '11',
  'zwoelf': '12',
  'dreizehn': '13',
  'vierzehn': '14',
  'fuenfzehn': '15',
  'sechzehn': '16',
  'siebzehn': '17',
  'achtzehn': '18',
  'neunzehn': '19',
  'zwanzig': '20',
  'dreißig': '30',
  'vierzig': '40',
  'fuenfzig': '50',
  'sechzig': '60',
  'siebzig': '70',
  'achtzig': '80',
  'neunzig': '90',
  'hundert': '100',
  'tausend': '1000',
  'grad': '°',
  'punkt': '.',
  'komma': ',',
  'nord': 'numeralwords_n',
  'ost': 'numeralwords_e',
  'west': 'numeralwords_w',
  'sued': 'numeralwords_s',
};
final Map<String, String> ENGWordToNum = {
  'zero': '0',
  'one': '1',
  'two': '2',
  'three': '3',
  'four': '4',
  'five': '5',
  'six': '6',
  'seven': '7',
  'eight': '8',
  'nine': '9',
  'ten': '10',
  'eleven': '11',
  'twelve': '12',
  'thirteen': '13',
  'fourteen': '14',
  'fifteen': '15',
  'sixteen': '16',
  'seventeen': '17',
  'eighteen': '18',
  'nineteen': '19',
  'twenty': '20',
  'thirty': '30',
  'fourty': '40',
  'fifty': '50',
  'sixty': '60',
  'seventy': '70',
  'eighty': '80',
  'ninety': '90',
  'hundred': '100',
  'thousand': '1000',
  'degree': '°',
  'degrees': '°',
  'point': '.',
  'komma': ',',
  'north': 'numeralwords_n',
  'east': 'numeralwords_e',
  'west': 'numeralwords_w',
  'south': 'numeralwords_s'
};
final Map<String, String> DNKWordToNum = {
  'nul': '0',
  'en': '1',
  'to': '2',
  'tre': '3',
  'fire': '4',
  'fem': '5',
  'seks': '6',
  'syve': '7',
  'otte': '8',
  'ni': '9',
  'ti': '10',
  'elleve': '11',
  'tolv': '12',
  'tretten': '13',
  'fjorten': '14',
  'femten': '15',
  'seksten': '16',
  'sytten': '17',
  'atten': '18',
  'nitten': '19',
  'tyve': '20',
  'tredive': '30',
  'fyrre': '40',
  'halvtreds': '50',
  'tres': '60',
  'halvfjerds': '70',
  'firs': '80',
  'halvfems': '90',
  'hundrede': '100',
  'tusind': '1000',
  'grad': '°',
  'punkt': '.',
  'komma': ',',
  'nord': 'numeralwords_n',
  'øst': 'numeralwords_e',
  'vest': 'numeralwords_w',
  'syd': 'numeralwords_s'
};
final Map<String, String> NLDWordToNum = {
  'nul': '0',
  'een': '1',
  'twee': '2',
  'drie': '3',
  'vier': '4',
  'vijf': '5',
  'zes': '6',
  'zeven': '7',
  'acht': '8',
  'negen': '9',
  'tien': '10',
  'elf': '11',
  'twaalf': '12',
  'dertien': '13',
  'veerteen': '14',
  'vijfteen': '15',
  'zestien': '16',
  'zeventien': '17',
  'achttien': '18',
  'negentien': '19',
  'twintig': '20',
  'dertig': '30',
  'veertig': '40',
  'vijftig': '50',
  'testig': '60',
  'zeventig': '70',
  'tachtig': '80',
  'negentig': '90',
  'honderd': '100',
  'duizend': '1000',
  'graad': '°',
  'punt': '.',
  'komma': ',',
  'noord': 'numeralwords_n',
  'oost': 'numeralwords_e',
  'west': 'numeralwords_w',
  'zuid': 'numeralwords_s'
};
final Map<String, String> SWEWordToNum = {
  'noll': '0',
  'en': '1',
  'ett': '1',
  'två': '2',
  'tre': '3',
  'fyra': '4',
  'fem': '5',
  'sex': '6',
  'sju': '7',
  'åtta': '8',
  'nio': '9',
  'tio': '10',
  'elva': '11',
  'tolv': '12',
  'tretton': '13',
  'fjorton': '14',
  'femton': '15',
  'sexton': '16',
  'sjutton': '17',
  'arton': '18',
  'nitton': '19',
  'tjugo': '20',
  'trettio': '30',
  'fyrtio': '40',
  'femtio': '50',
  'sextio': '60',
  'sjuttio': '70',
  'åttio': '80',
  'nittio': '90',
  'hundra': '100',
  'tusen': '1000',
  'grad': '°',
  'punkt': '.',
  'komma': ',',
  'norr': 'numeralwords_n',
  'ost': 'numeralwords_e',
  'väst': 'numeralwords_w',
  'syd': 'numeralwords_s'
};
final Map<String, String> NORWordToNum = {
  'nul': '0',
  'en': '1',
  'ett': '1',
  'to': '2',
  'tre': '3',
  'fire': '4',
  'fem': '5',
  'seks': '6',
  'sju': '7',
  'syv': '7',
  'åtte': '8',
  'ni': '9',
  'ti': '10',
  'elleve': '11',
  'tolv': '12',
  'tretten': '13',
  'fjorten': '14',
  'femten': '15',
  'seksten': '16',
  'sytten': '17',
  'atten': '18',
  'nitten': '19',
  'tjue': '20',
  'tretti': '30',
  'førti': '40',
  'femti': '50',
  'seksti': '60',
  'sytti': '70',
  'åtti': '80',
  'nitti': '90',
  'hundre': '100',
  'tusen': '1000',
  'grad': '°',
  'punkt': '.',
  'komma': ',',
  'nord': 'numeralwords_n',
  'øst': 'numeralwords_e',
  'vest': 'numeralwords_w',
  'sør': 'numeralwords_s'
};
final Map<String, String> ITAWordToNum = {
  'zero': '0',
  'uno': '1',
  'due': '2',
  'tre': '3',
  'quattro': '4',
  'cinque': '5',
  'sei': '6',
  'sette': '7',
  'otto': '8',
  'nove': '9',
  'dieci': '10',
  'undici': '11',
  'dodici': '12',
  'tredici': '13',
  'quattordici': '14',
  'quindici': '15',
  'sedici': '16',
  'diciasette': '17',
  'diciotto': '18',
  'diciannove': '19',
  'venti': '20',
  'trenta': '30',
  'quaranta': '40',
  'cinquanta': '50',
  'sessanta': '60',
  'settanta': '70',
  'ottanta': '80',
  'novanta': '90',
  'cento': '100',
  'mille': '1000',
  'grado': '°',
  'punto': '.',
  'virgola': ',',
  'nord': 'numeralwords_n',
  'est': 'numeralwords_e',
  'ovest': 'numeralwords_w',
  'sud': 'numeralwords_s'
};
final Map<String, String> FRAWordToNum = {
  'zéro': '0',
  'un': '1',
  'une': '1',
  'deux': '2',
  'trois': '3',
  'quatre': '4',
  'cinq': '5',
  'six': '6',
  'sept': '7',
  'huit': '8',
  'neuf': '9',
  'dix': '10',
  'onze': '11',
  'douze': '12',
  'treize': '13',
  'quatorze': '14',
  'quinze': '15',
  'seize': '16',
  'dix-sept': '17',
  'dix-huit': '18',
  'dix-neuf': '19',
  'vingt': '20',
  'trente': '30',
  'quarante': '40',
  'cinqante': '50',
  'soixante': '60',
  'soixante-dix': '70',
  'quatre-vingt': '80',
  'quatre-vingt-dix': '90',
  'cent': '100',
  'mille': '1000',
  'degré': '°',
  'point': '.',
  'komma': ',',
  'nord': 'numeralwords_n',
  'est': 'numeralwords_e',
  'ouest': 'numeralwords_w',
  'sud': 'numeralwords_s'
};
final Map<String, String> ESPWordToNum = {
  'cero': '0',
  'uno': '1',
  'una': '1',
  'dos': '2',
  'tres': '3',
  'cuatro': '4',
  'cinco': '5',
  'seis': '6',
  'siete': '7',
  'ocho': '8',
  'nueve': '9',
  'diez': '10',
  'once': '11',
  'doce': '12',
  'trece': '13',
  'catorce': '14',
  'quince': '15',
  'dieciséis': '16',
  'diecisiete': '17',
  'dieciocho': '18',
  'diecinueve': '19',
  'viente': '20',
  'treinta': '30',
  'cuaranta': '40',
  'cincuenta': '50',
  'sesenta': '60',
  'setenta': '70',
  'ochenta': '80',
  'noventa': '90',
  'cien': '100',
  'mil': '1000',
  'grado': '°',
  'punto': '.',
  'coma': ',',
  'norte': 'numeralwords_n',
  'este': 'numeralwords_e',
  'oeste': 'numeralwords_w',
  'sur': 'numeralwords_s'
};
final Map<String, String> PORWordToNum = {
  'zero': '0',
  'um': '1',
  'dois': '2',
  'duas': '2',
  'tres': '3',
  'quatro': '4',
  'cinco': '5',
  'seis': '6',
  'sete': '7',
  'oito': '8',
  'nove': '9',
  'dez': '10',
  'onze': '11',
  'doze': '12',
  'treze': '13',
  'catorze': '14',
  'quinze': '15',
  'dezasseis': '16',
  'dezassete': '17',
  'dezoito': '18',
  'dezanove': '19',
  'vinte': '20',
  'trinta': '30',
  'quaranta': '40',
  'cinquenta': '50',
  'sessenta': '60',
  'setenta': '70',
  'oitenta': '80',
  'noventa': '90',
  'cem': '100',
  'cento': '100',
  'mil': '1000',
  'grau': '°',
  'ponto': '.',
  'virgula': ',',
  'norte': 'numeralwords_n',
  'leste': 'numeralwords_e',
  'oeste': 'numeralwords_w',
  'sul': 'numeralwords_s'
};
final Map<String, String> POLWordToNum = {
  'zero': '0',
  'jeden': '1',
  'jedna': '1',
  'jedno': '1',
  'dwa': '2',
  'dwie': '2',
  'trzy': '3',
  'cztery': '4',
  'pięć': '5',
  'sześć': '6',
  'siedem': '7',
  'osiem': '8',
  'dziewięć': '9',
  'dziesięć': '10',
  'jedenaście': '11',
  'dwanaście': '12',
  'trzynaście': '13',
  'czternaście': '14',
  'piętnaście': '15',
  'szesnaście': '16',
  'siedemnaście': '17',
  'osiemnaście': '18',
  'dziewiętnaście': '19',
  'dwadzieścia': '20',
  'trzydzieści': '30',
  'czterdzieści': '40',
  'pięćdziesiąt': '50',
  'sześćdziesiąt': '60',
  'siedemdziesiąt': '70',
  'osiemdziesiąt': '80',
  'dziewięćdziesiąt': '90',
  'sto': '100',
  'tysiąc': '1000',
  'stopień': '°',
  'kropka': '.',
  'przecinek': ',',
  'północ': 'numeralwords_n',
  'wschód': 'numeralwords_e',
  'zachód': 'numeralwords_w',
  'południe': 'numeralwords_s'
};
final Map<String, String> RUSWordToNum = {
  'nol': '0',
  'nul': '0',
  'adna': '1',
  'adno': '1',
  'adin': '1',
  'dwa': '2',
  'dwje': '2',
  'tri': '3',
  'četýrje': '4',
  'pjat': '5',
  'šest': '6',
  'sem': '7',
  'vosem': '8',
  'djèvjat': '9',
  'djèsjat': '10',
  'odinnàẓat': '11',
  'dvjennàẓat': '12',
  'trinnàẓat': '13',
  'četyrnàẓat': '14',
  'pjatnnàẓat': '15',
  'šestnàẓat': '16',
  'semnàẓat': '17',
  'vosemnàẓat	': '18',
  'djvjatnàẓat': '19',
  'dvàẓat': '20',
  'trizat': '30',
  'sòrak': '40',
  'pjatdesjat': '50',
  'šestdesjat': '60',
  'semdesjat': '70',
  'vosemdesjat': '80',
  'devianosto': '90',
  'sto': '100',
  'týsjača': '1000',
  'grad': '°',
  'tochki': '.',
  'sever': 'numeralwords_n',
  'vostok': 'numeralwords_e',
  'zapad': 'numeralwords_w',
  'yug': 'numeralwords_s'
};
final Map<String, String> KYRWordToNum = {
  'ноль': '0',
  'нуль': '0',
  'один': '1',
  'одна': '1',
  'одно': '1',
  'два': '2',
  'две': '2',
  'три': '3',
  'четыре': '4',
  'пять': '5',
  'шесть': '6',
  'семь': '7',
  'восемь': '8',
  'девять': '9',
  'десять': '10',
  'одиннадцать': '11',
  'двенадцать': '12',
  'тринадцать': '13',
  'четырнадцать': '14',
  'пятнадцать': '15',
  'шестнадцать': '16',
  'семнадцать': '17',
  'восемнадцать': '18',
  'девятнадцать': '19',
  'двадцать': '20',
  'тридцать': '30',
  'сорок': '40',
  'пятьдесят': '50',
  'шестьдесят': '60',
  'семьдесят': '70',
  'восемьдесят': '80',
  'девяносто': '90',
  'сто': '100',
  'тысяча': '1000',
  'градус': '°',
  'точка': '.',
  'Запятой': ',',
  'север': 'numeralwords_n',
  'Восток': 'numeralwords_e',
  'Запад': 'numeralwords_w',
  'юг': 'numeralwords_s'
};
final Map<String, String> VOLWordToNum = {
  'ser': '0',
  'bal': '1',
  'tel': '2',
  'kil': '3',
  'fol': '4',
  'lul': '5',
  'mael': '6',
  'vel': '7',
  'joel': '8',
  'zuel': '9',
  'deg': '10',
  'degbal': '11',
  'degtel': '12',
  'degtil': '13',
  'degfol': '14',
  'deglul': '15',
  'degmael': '16',
  'degvel': '17',
  'degjoel': '18',
  'degzuel': '19',
  'teldeg': '20',
  'tildeg': '30',
  'foldeg': '40',
  'luldeg': '50',
  'maeldeg': '60',
  'veldeg': '70',
  'joeldeg': '80',
  'zueldeg': '90',
  'tum': '100',
  'mil': '1000',
  'grad': 'grad',
  'puen': 'punkt',
  'nolued': 'numeralwords_n',
  'sulued': 'numeralwords_s',
  'lofued': 'numeralwords_e',
  'vesued': 'numeralwords_w',
};
final Map<String, String> EPOWordToNum = {
  'nulo': '0',
  'unu': '1',
  'du': '2',
  'tri': '3',
  'kvar': '4',
  'kvin': '5',
  'ses': '6',
  'sep': '7',
  'ok': '8',
  'naŭ': '9',
  'dek': '10',
  'dek unu': '11',
  'dek du': '12',
  'dek tri': '13',
  'dek kvar': '14',
  'dek kvin': '15',
  'dek ses': '16',
  'dek sep': '17',
  'dek ok': '18',
  'dek naŭ': '19',
  'dudek': '20',
  'tridek': '30',
  'kvardek': '40',
  'kvindek': '50',
  'sesdek': '60',
  'sepdek': '70',
  'okdek': '80',
  'naŭdek': '90',
  'cent': '100',
  'mil': '1000',
  'grado': '°',
  'punkto': '.',
  'komo': ',',
  'nordo': 'numeralwords_n',
  'sudo': 'numeralwords_s',
  'oriento': 'numeralwords_e',
  'okcidento': 'numeralwords_w',
  'grado': 'grad',
  'punkto': 'punkt',
};
final Map<String, String> SOLWordToNum = {
  'soldo': '0',
  'redodo': '1',
  'remimi': '2',
  'refafa': '3',
  'resolsol': '4',
  'relala': '5',
  'resisi': '6',
  'mimido': '7',
  'mimire': '8',
  'mimifa': '9',
  'mimisol': '10',
  'mimila': '11',
  'mimisi': '12',
  'midodo': '13',
  'mirere': '14',
  'mifafa': '15',
  'misolsol': '16',
  'milala': '17',
  'misisi': '18',
  'fafado': '19',
  'fafare': '20',
  'fafami': '30',
  'fafasol': '40',
  'fafala': '50',
  'fafasi': '60',
  'fafasi mimisol': '70',
  'fadodo': '80',
  'fadodo mimisol': '90',
  'farere': '100',
  'famimi': '1000',
  'dolasifa': 'numeralwords_n',
  'fasilado': 'numeralwords_s',
  'fasilare': 'numeralwords_e',
  'relasifa': 'numeralwords_w',
  'famidosi': 'grad',
  'relaresol': 'punkt',
};
final Map<String, String> LATWordToNum = {
  'zerum': '0',
  'nullum': '0',
  'unus': '1',
  'duo': '2',
  'tria': '3',
  'tres': '3',
  'quattuor': '4',
  'quinque': '5',
  'hexas': '6',
  'sex': '6',
  'septem': '7',
  'octo': '8',
  'novem': '9',
  'decem': '10',
  'undecim': '11',
  'duodecim': '12',
  'trēdecim': '13',
  'quattuordecim': '14',
  'quīndecim': '15',
  'sēdecim': '16',
  'septendecim': '17',
  'duodēvīgintī': '18',
  'undēvīgintī': '19',
  'vīgintī': '20',
  'trīgintā': '30',
  'quadrāgintā': '40',
  'quīnquāgintā': '50',
  'sexāgintā': '60',
  'septuāgintā': '70',
  'octōgintā': '80',
  'nōnāgintā': '90',
  'centum': '100',
  'mīlle': '1000',
  'gradus': '°',
  'punctum': '.',
  'septentriones': 'numeralwords_n',
  'oriens': 'numeralwords_e',
  'west': 'numeralwords_w',
  'meridies': 'numeralwords_s',
};
final Map<String, String> MAPWordToNum = {
  'kinhe': '1',
  'epu': '2',
  'kyla': '3',
  'meli': '4',
  'kecu': '5',
  'kaju': '6',
  'reqle': '7',
  'pura': '8',
  'ailha': '9',
  'mari ': '10',
};
final Map<String, String> BASWordToNum = {
  'huts / zero': '0',
  'bat': '1',
  'bi': '2',
  'hiru': '3',
  'lau': '4',
  'bost': '5',
  'sei': '6',
  'zazpi': '7',
  'zortzi': '8',
  'bederatzi': '9',
  'hamar': '10',
};
final Map<String, String> DOTWordToNum = {
  'som': '0',
  'at': '1',
  'akat': '2',
  'sen': '3',
  'tor': '4',
  'mek': '5',
  'zhinda': '6',
  'fekh': '7',
  'ori': '8',
  'qazat': '9',
  'thi': '10',
  'atthi': '11',
  'akatthi': '12',
  'senthi': '13',
  'torthi': '14',
  'mekthi': '15',
  'zhindatthi': '16',
  'fekhthi': '17',
  'oritthi': '18',
  'qazatthi': '19',
  'chakat': '20',
  'chisen': '30',
  'chitor': '40',
  'chimek': '50',
  'chizhinda': '60',
  'chifekh': '70',
  'chori': '80',
  'chiqazat': '90',
  'ken': '100',
  'dalen': '1000',
};
final Map<String, String> UNGWordToNum = {
  'nulla': '0',
  'egy': '1',
  'kettő': '2',
  'három': '3',
  'négy': '4',
  'öt': '5',
  'hat': '6',
  'hét': '7',
  'nyolc': '8',
  'kilenc': '9',
  'tíz ': '10',
};
final Map<String, String> PERWordToNum = {
  'sefr': '0',
  'yek': '1',
  'do': '2',
  'se': '3',
  'chahar': '4',
  'panj': '5',
  'sesh': '6',
  'haft': '7',
  'hasht': '8',
  'noh': '9',
  'dah': '10',
};
final Map<String, String> AMHWordToNum = {
  'bado': '0',
  'ahnd': '1',
  'hulet': '2',
  'sost': '3',
  'arat': '4',
  'amest\'': '5',
  'sidest': '6',
  'sābat': '7',
  'siment': '8',
  'zetegn': '9',
  '\'asser ': '10',
};
final Map<String, String> TURWordToNum = {
  'sıfır': '0',
  'bir': '1',
  'iki': '2',
  'üç': '3',
  'dört': '4',
  'beş': '5',
  'altı': '6',
  'yedi': '7',
  'sekiz': '8',
  'dokuz': '9',
  'on': '10',
  'yüz': '100',
  'bin': '1000',
};
final Map<String, String> BREWordToNum = {
  'mann': '0',
  'unan': '1',
  'daou': '2',
  'tri': '3',
  'pevar': '4',
  'pemp': '5',
  'c\'hwec\'h': '6',
  'seizh': '7',
  'eizh': '8',
  'nav': '9',
  'dek': '10',
};
final Map<String, String> INDWordToNum = {
  'nol': '0',
  'satu': '1',
  'dua': '2',
  'tiga': '3',
  'empat': '4',
  'lima': '5',
  'enam': '6',
  'tujuh': '7',
  'delapan': '8',
  'sembilan': '9',
  'sepuluh': '10',
};
final Map<String, String> FINWordToNum = {
  'nolla': '0',
  'yksi': '1',
  'kaksi': '2',
  'kolme': '3',
  'neljä': '4',
  'viisi': '5',
  'kuusi': '6',
  'seitsemän': '7',
  'kahdeksan': '8',
  'yhdeksän': '9',
  'kymmenen': '10',
};
final Map<String, String> CEQWordToNum = {
  'han': '1',
  'du': '2',
  'tri': '3',
  'for': '4',
  'fai': '5',
  'ce': '6',
  'cil': '7',
  'pal': '8',
  'gau': '9',
  'hanzoi': '10',
};
final Map<String, String> SCOWordToNum = {
  'nocht': '0',
  'ane': '1',
  'ae': '1',
  'twa': '2',
  'three': '3',
  'fower': '4',
  'five': '5',
  'sax': '6',
  'seiven': '7',
  'aicht': '8',
  'nine': '9',
  'ten ': '10',
};
final Map<String, String> QUEWordToNum = {
  'huk': '0',
  'iskay': '1',
  'kimsa': '2',
  'tawa': '3',
  'pichqa': '4',
  'soqta': '5',
  'qanchis': '6',
  'pusaq': '7',
  'isqon': '8',
  'chunka ': '9',
};
final Map<String, String> LOJWordToNum = {
  'no': '0',
  'pa': '1',
  're': '2',
  'ci': '3',
  'vo': '4',
  'mu': '5',
  'xa': '6',
  'ze': '7',
  'bi': '8',
  'so': '9',
  'pano': '10',
};
final Map<String, String> CHIWordToNum = {
// https://de.wikipedia.org/wiki/Chinesische_Zahlzeichen
  'líng': '0',
  'yī': '1',
  'yāo': '1',
  'èr': '2',
  'liǎng': '2',
  'sān': '3',
  'sì': '4',
  'wǔ': '5',
  'liù': '6',
  'qī': '7',
  'bā': '8',
  'jiǔ': '9',
  'shí': '10',
  'shí yī': '11',
  'shí èr': '12',
  'shí sān': '13',
  'shí sì': '14',
  'shí wǔ': '15',
  'shí liù': '16',
  'shí qī': '17',
  'shí bā': '18',
  'shí jiǔ': '19',
  'liǎng shí': '20',
  'sān shí': '30',
  'sì shí': '40',
  'wǔ shí': '50',
  'liù shí': '60',
  'qī shí': '70',
  'bā shí': '80',
  'jiǔ shí': '90',
  'bǎi': '100',
  'qiān': '1000',
  'wàn': '10000'
};
final Map<String, String> CHISymbolWordToNum = {
// https://de.wikipedia.org/wiki/Chinesische_Zahlzeichen
  '零': '0',
  '〇': '0',
  '一': '1',
  '二': '2',
  '兩': '2',
  '三': '3',
  '四': '4',
  '五': '5',
  '六': '6',
  '七': '7',
  '八': '8',
  '九': '9',
  '十': '10',
  '十一': '11',
  '十二': '12',
  '十三': '13',
  '十四': '14',
  '十五': '15',
  '十六': '16',
  '十七': '17',
  '十八': '18',
  '十九': '19',
  '二十': '20',
  '三十': '30',
  '四十': '40',
  '五十': '50',
  '六十': '60',
  '七十': '70',
  '八十': '80',
  '九十': '90',
  '百': '100',
  '千': '1000',
  '万': '10000',
  '萬': '10000',
};
final Map<String, String> CHIFinanceWordToNum = {
// https://de.wikipedia.org/wiki/Chinesische_Zahlzeichen
  '零': '0',
  '壹': '1',
  '弌': '1',
  '貳': '2',
  '弍': '2',
  '叄 ': '3',
  '弎 ': '3',
  '肆': '4',
  '伍': '5',
  '陸': '6',
  '陆': '6',
  '柒': '7',
  '捌': '8',
  '玖': '9',
  '拾': '10',
  '拾壹': '11',
  '拾貳': '12',
  '拾弎': '13',
  '拾sì': '14',
  '拾wǔ': '15',
  '拾陸': '16',
  '拾qī': '17',
  '拾bā': '18',
  '拾jiǔ': '19',
  '貳拾': '20',
  '弎拾': '30',
  '肆拾': '40',
  '伍拾': '50',
  '陸拾': '60',
  '柒拾': '70',
  '捌拾': '80',
  '玖拾': '90',
  '佰': '100',
  '仟': '1000',
  '萬': '10000'
};
final Map<String, String> CHIZhuyinWordToNum = {
// https://de.wikipedia.org/wiki/Chinesische_Zahlzeichen
  'ㄌㄧㄥˊ': '0',
  'ㄧ': '1',
  'ㄦˋ': '2',
  'ㄌㄧㄤˇ': '2',
  'ㄙㄢ': '3',
  'ㄙˋ': '4',
  'ㄨˇ': '5',
  'ㄌㄧㄡˋ': '6',
  'ㄑㄧ': '7',
  'ㄅㄚ': '8',
  'ㄐㄧㄡˇ': '9',
  'ㄕˊ': '10',
  'ㄕˊㄧ': '11',
  'ㄕˊㄦˋ': '12',
  'ㄕˊㄙㄢ': '13',
  'ㄕˊㄙˋ': '14',
  'ㄕˊㄨˇ': '15',
  'ㄕˊㄌㄧㄡˋ': '16',
  'ㄕˊㄧ': '17',
  'ㄕˊㄅㄚ': '18',
  'ㄕˊjiǔ': '19',
  'ㄦˋㄕˊ': '20',
  'ㄙㄢㄕˊ': '30',
  'ㄙˋㄕˊ': '40',
  'ㄨˇㄕˊ': '50',
  'ㄌㄧㄡˋㄕˊ ': '60',
  'ㄑㄧㄕˊ': '70',
  'ㄅㄚㄕˊ': '80',
  'ㄐㄧㄡˇㄕˊ': '90',
  'ㄅㄞˇ': '100',
  'ㄑㄧㄢ': '1000',
  'ㄨㄢˋ': '10000'
};
final Map<String, String> KLIWordToNum = {
  'pagh': '0',
  'wa\'': '1',
  'cha\'': '2',
  'wej': '3',
  'loS': '4',
  'vagh': '5',
  'jav': '6',
  'Soch': '7',
  'chorgh': '8',
  'Hut': '9',
  'wa\'maH': '10',
  'wa\'maH wa\'': '11',
  'wa\'maH cha\'': '12',
  'wa\'maH wej': '13',
  'wa\'maH loS': '14',
  'wa\'maH vagh': '15',
  'wa\'maH jav': '16',
  'wa\'maH Soch': '17',
  'wa\'maH chorgh': '18',
  'wa\'maH Hut': '19',
  'cha\'mah': '20',
  'wejmaH': '30',
  'loSmaH': '40',
  'vaghmaH': '50',
  'javmaH': '60',
  'SochmaH': '70',
  'horghmaH': '80',
  'HutmaH': '90',
  'wa\'vatlh': '100',
  'cha\'vatlh': '200',
  'wejvatlh': '300',
  'IoSvatlh': '400',
  'vaghvatlh': '500',
  'javvatlh': '600',
  'Sochvatlh': '700',
  'chorghvatlh': '800',
  'Hutvatlh': '900',
  'wa\'SaD': '1000',
  'wa\'SanID': '1000',
  'wa\'netlh': '10000',
  'wa\'blp': '100000',
  'ngev': '.',
  'ghob': '.',
  'Qoch': '°',
  'chan': 'numeralwords_e',
  'watlh': 'numeralwords_s',
  '\'oy\'': 'numeralwords_n',
  'ting\'ev': 'numeralwords_w',
  '\'evting': 'numeralwords_w',
  'maH': 'numeralwords_w',
};
final Map<String, String> VIEWordToNum = {
  'cê-rô': '0',
  'một': '1',
  'hai': '2',
  'ba': '3',
  'bốn': '4',
  'năm': '5',
  'sáu': '6',
  'bảy': '7',
  'tám': '8',
  'chín': '9',
  'mười': '10',
  'mười một': '11',
  'mười hai': '12',
  'mười ba': '13',
  'mười bốn': '14',
  'mười năm': '15',
  'mười sáu': '16',
  'mười bảy': '17',
  'mười tám': '18',
  'mười chín': '19',
  'hai mười': '20',
  'ba mười': '30',
  'bốn mười': '40',
  'năm mười': '50',
  'sáu mười': '60',
  'bảy mười': '70',
  'tám mười': '80',
  'chín mười': '90',
  'một trăm': '100',
};
final Map<String, String> VIESINOWordToNum = {
// https://chunom.org/pages/?search=mot
  'không': '0',
  'nhất': '1',
  'nhị': '2',
  'tam': '3',
  'tứ': '4',
  'ngũ': '5',
  'lục': '6',
  'thất': '7',
  'bát': '8',
  'cửu': '9',
  'thập': '10',
};
final Map<String, String> VIEHANTUWordToNum = {
// https://chunom.org/pages/?search=mot
  '空': '0',
  '零': '0',
  '一': '1',
  '壹': '1',
  '二': '2',
  '貳': '2',
  '三': '3',
  '叄': '3',
  '四': '4',
  '肆': '4',
  '五': '5',
  '伍': '5',
  '六': '6',
  '陸': '6',
  '七': '7',
  '柒': '7',
  '八': '8',
  '捌': '8',
  '九': '9',
  '玖': '9',
  '十': '10',
  '拾': '10',
};
final Map<String, String> VIECHUNOMWordToNum = {
  // https://chunom.org/pages/?search=mot
  // https://www.omniglot.com/language/numbers/vietnamese.htm
  '𠬠': '1',
  '𠄩': '2',
  '𠀧': '3',
  '𦊚': '4',
  '𠄼': '5',
  '𦒹': '6',
  '𦉱': '7',
  '𠔭': '8',
  '𢒂': '9',
  '𨒒': '10',
  '𨒒𠬠': '11',
  '𨒒𠄩': '12',
  '𨒒𠀧': '13',
  '𨒒𦊚': '14',
  '𨒒𠄼': '15',
  '𨒒𦒹': '16',
  '𨒒𦉱': '17',
  '𨒒𠔭': '18',
  '𨒒𢒂': '19',
  '𠄩𨒒': '20',
  '𠀧𨒒': '30',
  '𦊚𨒒': '40',
  '𠄼𨒒': '50',
  '𦒹𨒒': '60',
  '𦉱𨒒': '70',
  '𠔭𨒒': '80',
  '𢒂𨒒': '90',
  '𠬠𤾓': '100',
};
final Map<String, String> MEGWordToNum = {
  'zero': '0',
  'ună': '1',
  'dău': '2',
  'trei': '3',
  'pătru': '4',
  'ţinţi': '5',
  'şăsi': '6',
  'şapti': '7',
  'optu': '8',
  'nău': '9',
  'dzieţi ': '10',
};
final Map<String, String> TAMWordToNum = {
  'cuḻiyam': '0',
  'oṉdṟu': '1',
  'irandu': '2',
  'mūṉdṟu': '3',
  'nāṉgu': '4',
  'aindhu': '5',
  'āṟu': '6',
  'ēḻu': '7',
  'eṯṯu': '8',
  'oṉbadhu': '9',
  'paththu': '10',
};
final Map<String, String> JAPWordToNum = {
// https://darkfairyssenf.de/2018/05/17/nihongo-zahlen-auf-japanisch/#:~:text=Gro%C3%9Fe%20Spr%C3%BCnge%20%20%20%20Zahl%20%20,1000%20%20%20sen%20%20%20%E3%81%9B%E3%82%93%20
  'zero': '0',
  'rei': '0',
  'ichi': '1',
  'ni': '2',
  'san': '3',
  'shi': '4',
  'yon': '4',
  'go': '5',
  'roku': '6',
  'shichi': '7',
  'nana': '7',
  'hachi': '8',
  'kyū': '9',
  'ku': '9',
  'jū': '10',
  'jūichi': '11',
  'jūni': '12',
  'jūsan': '13',
  'jūyon ': '14',
  'jūshi': '14',
  'jūgo': '15',
  'jūroku': '16',
  'jūshichi': '17',
  'jūnana': '17',
  'jūhachi': '18',
  'jūkyū': '19',
  'jūku': '19',
  'nijū': '20',
  'sanjū': '30',
  'yonjū': '40',
  'shijū': '40',
  'gojū': '50',
  'rokujū': '60',
  'shichijū': '70',
  'nanajū': '70',
  'hachijū': '80',
  'kyūjū': '90',
  'kujū': '90',
  'hyaku': '100',
  'sen': '1000',
};
final Map<String, String> JAPHiraganaWordToNum = {
// https://darkfairyssenf.de/2018/05/17/nihongo-zahlen-auf-japanisch/#:~:text=Gro%C3%9Fe%20Spr%C3%BCnge%20%20%20%20Zahl%20%20,1000%20%20%20sen%20%20%20%E3%81%9B%E3%82%93%20
  'ゼロ': '0',
  'れい': '0',
  'いち': '1',
  'に': '2',
  'さん': '3',
  'し': '4',
  'よん': '4',
  'ご': '5',
  'ろく': '6',
  'しち': '7',
  'なな': '7',
  'はち': '8',
  'きゅう': '9',
  'く': '9',
  'じゅう': '10',
  'じゅういち': '11',
  'じゅうに': '12',
  'じゅうさん': '13',
  'じゅうよん': '14',
  'じゅうし': '14',
  'じゅうご': '15',
  'じゅうろく': '16',
  'じゅうしち': '17',
  'じゅうなな': '17',
  'じゅうはち': '18',
  'じゅうきゅう': '19',
  'じゅうく': '19',
  'にじゅう': '20',
  'さんじゅう': '30',
  'よんじゅう': '40',
  'しじゅう': '40',
  'ごじゅう': '50',
  'ろくじゅう': '60',
  'しちじゅう': '70',
  'ななじゅう': '70',
  'はちじゅう': '80',
  'きゅうじゅう': '90',
  'くじゅう': '90',
  'ひゃく': '100',
  'せん': '1000',
};
final Map<String, String> MINWordToNum = {
  'hana': '1',
  'dul': '2',
  'sae': '3',
  'duldul': '4',
  'duldulhana': '5',
  'saesae': '6',
  'saesaehana': '7',
  'saesaedul': '8',
  'saesaesae': '9',
  'saesaesaehana': '10',
};
final Map<String, String> SHAWordToNum = {
  'ga': '0',
  'bu': '1',
  'zo': '2',
  'meu': '3',
  'buga': '4',
  'bubu': '5',
  'buzo': '6',
  'bumeu': '7',
  'zoga': '8',
  'zobu': '9',
  'zozo': '10',
};
final Map<String, String> HANGULSINOKORWordToNum = {
  '영': '0',
  '령': '0',
  '령': '0',
  '일': '1',
  '이': '2',
  '삼': '3',
  '사': '4',
  '오': '5',
  '육': '6',
  '륙': '6',
  '칠': '7',
  '팔': '8',
  '구': '9',
  '십': '10',
  '십일': '11',
  '십이': '12',
  '십삼': '13',
  '십사': '14',
  '십오': '15',
  '십육': '16',
  '십륙': '16',
  '십칠': '17',
  '십팔': '18',
  '십구': '19',
  '이십': '20',
  '삼십': '30',
  '사십': '40',
  '오십': '50',
  '육십': '60',
  '륙십': '60',
  '칠십': '70',
  '팔십': '80',
  '구십': '90',
  '백': '100',
  '천': '1000',
  '만': '10000',
};
final Map<String, String> HANGULKORWordToNum = {
  '하나': '1',
  '하': '1',
  '두': '2',
  '둘': '2',
  '세': '3',
  '셋': '3',
  '네': '4',
  '넷': '4',
  '다섯': '5',
  '여섯': '6',
  '일곱': '7',
  '여덟': '8',
  '아': '9',
  '열': '10',
  '열한': '11',
  '열하나': '11',
  '열두': '12',
  '열둘': '12',
  '열세': '13',
  '열셋': '13',
  '열네': '14',
  '열넷': '14',
  '열다섯': '15',
  '열여섯': '16',
  '열일곱': '17',
  '열여덟': '18',
  '열아': '19',
  '스물': '20',
  '서른': '30',
  '마흔': '40',
  '쉰': '50',
  '예순': '60',
  '일흔': '70',
  '여든': '80',
  '아흔': '90',
  '온': '100',
  '즈믄': '1000',
  '드먼': '10000',
  '골': '10000',
};
final Map<String, String> HANJAWordToNum = {
  '零': '0',
  '空': '0',
  '一': '1',
  '二': '2',
  '三': '3',
  '四': '4',
  '五': '5',
  '六': '6',
  '七': '7',
  '八': '8',
  '九': '9',
  '十': '10',
  '十一': '11',
  '十二': '12',
  '十三': '13',
  '十四': '14',
  '十五': '15',
  '十六': '16',
  '十七': '17',
  '十八': '18',
  '十九': '19',
  '二十': '20',
  '三十': '30',
  '四十': '40',
  '五十': '50',
  '六十': '60',
  '七十': '70',
  '八十': '80',
  '九十': '90',
  '百': '100',
  '千': '1000',
  '萬': '10000'
};
final Map<String, String> KORWordToNum = {
  'hana': '1',
  'hah-nah': '1',
  'han': '1',
  'du': '2',
  'dul': '2',
  'dool': '2',
  'seht': '3',
  'set': '3',
  'se': '3',
  'neht': '4',
  'net': '4',
  'ne': '4',
  'dausut': '5',
  'dahsuht': '5',
  'daseot': '5',
  'dseot': '5',
  'yeoseot': '6',
  'yeosut': '6',
  'yuhsuht': '6',
  'ilgob': '7',
  'ilgub': '7',
  'ilgup': '7',
  'ilgop': '7',
  'eelgob': '7',
  'yeodeol': '8',
  'ahop': '9',
  'ah-hope': '9',
  'ahhob': '9',
  'yeol': '10',
  'yuhl': '10',
  'yeolhana': '11',
  'yeolhan': '11',
  'yuhlhana': '11',
  'yuhlhan': '11',
  'yeoldul': '12',
  'yeoldool': '12',
  'yeoldu': '12',
  'yuhldul': '12',
  'yuhldool': '12',
  'yuhldu': '12',
  'yeolseht': '13',
  'yeolset': '13',
  'yeolse': '13',
  'yuhlseht': '13',
  'yuhlset': '13',
  'yuhlse': '13',
  'yeolneht': '14',
  'yeolnet': '14',
  'yeolne': '14',
  'yuhlneht': '14',
  'yuhlnet': '14',
  'yuhlne': '14',
  'yeoldausut': '15',
  'yeoldahsuht': '15',
  'yeoldaseot': '15',
  'yeoldseot': '15',
  'yuhldausut': '15',
  'yuhldahsuht': '15',
  'yuhldaseot': '15',
  'yuhldseot': '15',
  'yeolyeoseot': '16',
  'yeolyeosut': '16',
  'yeolyuhsuht': '16',
  'yuhlyeoseot': '16',
  'yuhlyeosut': '16',
  'yuhlyuhsuht': '16',
  'yeolilgob': '17',
  'yeolilgub': '17',
  'yeolilgup': '17',
  'yeolilgop': '17',
  'yeoleelgob': '17',
  'yuhlilgob': '17',
  'yuhlilgub': '17',
  'yuhlilgup': '17',
  'yuhlilgop': '17',
  'yuhleelgob': '17',
  'yeolyeodeol': '18',
  'yuhlyeodeol': '18',
  'yeolahop': '19',
  'yeolah-hope': '19',
  'yeolahhob': '19',
  'yuhllahop': '19',
  'yuhlah-hope': '19',
  'yuhlahhob': '19',
  'semul': '20',
  'semu': '20',
  'seoreun': '30',
  'maheun': '40',
  'swin': '50',
  'yesun': '60',
  'ilheun': '70',
  'yeodeun': '80',
  'aheun': '90',
  'on': '100',
  'jeumeun': '1000',
  'deumeun': '10000',
  'gol': '10000',
};
final Map<String, String> SINOKORWordToNum = {
  'yeong': '0',
  'ryeong': '0',
  'eel': '1',
  'il': '1',
  'ee': '2',
  'i': '2',
  'sam': '3',
  'sahm': '3',
  'sa': '4',
  'sah': '4',
  'o': '5',
  'oh': '5',
  'yuk': '6',
  'ryuk': '6',
  'yoogh': '6',
  'chil': '7',
  'pal': '8',
  'pahl': '8',
  'gu': '9',
  'goo': '9',
  'sip': '10',
  'sib': '10',
  'sibil': '11',
  'sipil': '11',
  'sipi': '12',
  'sibi': '12',
  'sibsam': '13',
  'sipsam': '13',
  'sipsa': '14',
  'sibsa': '14',
  'sibo': '15',
  'sipo': '15',
  'sibyuk': '16',
  'sipyuk': '16',
  'sipryuk': '16',
  'sim-nyuk': '16',
  'sibchil': '17',
  'sipchil': '17',
  'sippal': '18',
  'sibpal': '18',
  'sibgu': '19',
  'sipgu': '19',
  'isip': '20',
  'samsip': '30',
  'sasip': '40',
  'osip': '50',
  'yuksip': '60',
  'ryuksip': '60',
  'chilsip': '70',
  'palsip': '80',
  'gusip': '90',
  'shib': '10',
  'baek': '100',
  'cheon': '1000',
  'man': '10000',
};
final Map<String, String> NAVIWordToNum = {
  'kew': '0',
  "'aw": '1',
  'mune': '2',
  'pxey': '3',
  'tsing': '4',
  'mrr': '5',
  'pukap': '6',
  'kinae': '7',
  'vol': '8',
  'volaw': '9',
  'vomun ': '10',
  'vopey': '11',
  'vosìng': '12',
  'vomrr': '13',
  'vofu': '14',
  'vohin': '15',
  'mevol': '16',
  'zam': '64',
  'vozam': '512',
  'zazam': '4096',
  'nefae': 'numeralwords_n',
  'skien': 'numeralwords_e',
  'ftaer': 'numeralwords_w',
  'nekll': 'numeralwords_s',
};

final Map<String, String> BULKYRWordToNum = {
  'нула': '0',
  "едно": '1',
  "една": '1',
  "един": '1',
  'двe': '2',
  'два': '2',
  'три': '3',
  'четири': '4',
  'пет': '5',
  'шест': '6',
  'седем': '7',
  'осем': '8',
  'девет': '9',
  'десет': '10',
  'единайсет': '11',
  'дванайсет': '12',
  'тринайсет': '13',
  'четиринайсет': '14',
  'петнайсет': '15',
  'шестнайсет': '16',
  'седемнадесет': '17',
  'осемнадесет': '18',
  'деветнадесет': '19',
  'двайсет': '20',
  'тридесет': '30',
  'четиридесет': '40',
  'петдесет': '50',
  'шестдесет': '60',
  'седемдесет': '70',
  'осемдесет': '80',
  'деветдесет': '90',
  'сто': '100',
  'хиляда': '1000',
  'север': 'numeralwords_n',
  'изток': 'numeralwords_e',
  'запад': 'numeralwords_w',
  'юг': 'numeralwords_s',
};

final Map<String, String> BULWordToNum = {
  'nula': '0',
  "edno": '1',
  "edna": '1',
  "edin": '1',
  'dwe': '2',
  'dwa': '2',
  'tri': '3',
  'chetiri': '4',
  'pet': '5',
  'shest': '6',
  'sedem': '7',
  'osem ': '8',
  'devet': '9',
  'deset': '10',
  'edinadeset': '11',
  'dvanadeset': '12',
  'trinadeset': '13',
  'chetirinadeset': '14',
  'petnadeset': '15',
  'shestnadeset': '16',
  'sedemnadeset': '17',
  'osemnadeset': '18',
  'devetnadeset': '19',
  'dvadeset': '20',
  'trideset': '30',
  'chetirideset': '40',
  'petdeset': '50',
  'shestdeset': '60',
  'sedemdeset': '70',
  'osemdeset': '80',
  'devetdeset': '90',
  'sto': '100',
  'hilyada': '1000',
  'sever': 'numeralwords_n',
  'iztok': 'numeralwords_e',
  'zapad': 'numeralwords_w',
  'yug': 'numeralwords_s',
};

final Map<String, String> THAIRTGSWordToNum = {
  'sun': '0',
  'nueng': '1',
  'song': '2',
  'yi': '2',
  'sam': '3',
  'si': '4',
  'ha': '5',
  'hok': '6',
  'chet': '7',
  'paet': '8',
  'kao': '9',
  'sip': '10',
  'sip et': '11',
  'sip song': '12',
  'sip sam': '13',
  'sip si': '14',
  'sip ha': '15',
  'sip hok': '16',
  'sip chet': '17',
  'sip paet': '18',
  'sip kao': '19',
  'yi sip': '20',
  'sam sip': '30',
  'si sip': '40',
  'ha sip': '50',
  'hok sip': '60',
  'chet sip': '70',
  'paet sip': '80',
  'kao sip': '90',
  'roi': '100',
  'phan': '1000',
  'muen': '10000',
};

final Map<String, String> THAIWordToNum = {
  'ศูนย์': '0',
  'หนึ่ง': '1',
  'สอง': '2',
  'ยี่': '2',
  'สาม': '3',
  'สี่': '4',
  'ห้า': '5',
  'หก': '6',
  'เจ็ด': '7',
  'แปด': '8',
  'เก้า': '9',
  'สิบ': '10',
  'สิบหนึ่ง': '11',
  'สิบสอง': '12',
  'สิบสาม': '13',
  'สิบสี่': '14',
  'สิบห้า': '15',
  'สิบหก': '16',
  'สิบเจ็ด': '17',
  'สิบแปด': '18',
  'สิบเก้า': '19',
  'ยี่สิบสิบ': '20',
  'สามสิบ': '30',
  'สี่สิบ': '40',
  'ห้าสิบ': '50',
  'หกสิบ': '60',
  'เจ็ดสิบ': '70',
  'แปดสิบ': '80',
  'เก้าสิบ': '90',
  'ร้อยสิบ': '100',
  'พันสิบ': '1000',
  'หมื่นสิบ': '10000',
};

List ZOOMABLE_LANGUAGE = [
  NumeralWordsLanguage.JAPHIRAGANA,
  NumeralWordsLanguage.HANGULKOR,
  NumeralWordsLanguage.HANGULSINOKOR,
  NumeralWordsLanguage.VIEHANTU,
  NumeralWordsLanguage.VIESINO,
  NumeralWordsLanguage.BULKYR,
  NumeralWordsLanguage.KYR,
  NumeralWordsLanguage.THAI,
  NumeralWordsLanguage.CHISYMBOL,
  NumeralWordsLanguage.CHIZHUYIN,
  NumeralWordsLanguage.CHIFINANCE,
];

Map<NumeralWordsLanguage, String> NUMERALWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU: 'common_language_german',
  NumeralWordsLanguage.ENG: 'common_language_english',
  NumeralWordsLanguage.FRA: 'common_language_french',
  NumeralWordsLanguage.ITA: 'common_language_italian',
  NumeralWordsLanguage.DNK: 'common_language_danish',
  NumeralWordsLanguage.ESP: 'common_language_spanish',
  NumeralWordsLanguage.NLD: 'common_language_dutch',
  NumeralWordsLanguage.NOR: 'common_language_norwegian',
  NumeralWordsLanguage.POR: 'common_language_portuguese',
  NumeralWordsLanguage.SWE: 'common_language_swedish',
  NumeralWordsLanguage.POL: 'common_language_polish',
  NumeralWordsLanguage.RUS: 'common_language_russian',
  NumeralWordsLanguage.KYR: 'numeralwords_language_kyr',
  NumeralWordsLanguage.BUL: 'common_language_bulgarian',
  NumeralWordsLanguage.BULKYR: 'numeralwords_language_bul_kyr',
  NumeralWordsLanguage.JAP: 'numeralwords_language_jap',
  NumeralWordsLanguage.JAPHIRAGANA: 'numeralwords_language_jap_hiragana',
  NumeralWordsLanguage.CHI: 'numeralwords_language_chi',
  NumeralWordsLanguage.CHISYMBOL: 'numeralwords_language_chi_symbol',
  NumeralWordsLanguage.CHIZHUYIN: 'numeralwords_language_chi_zhuyin',
  NumeralWordsLanguage.CHIFINANCE: 'numeralwords_language_chi_finance',
  NumeralWordsLanguage.KOR: 'common_language_korean',
  NumeralWordsLanguage.SINOKOR: 'common_language_sino_korean',
  NumeralWordsLanguage.HANJA: 'common_language_hanja',
  NumeralWordsLanguage.HANGULKOR: 'common_language_hangul_korean',
  NumeralWordsLanguage.HANGULSINOKOR: 'common_language_hangul_sino_korean',
  NumeralWordsLanguage.UNG: 'numeralwords_language_ung',
  NumeralWordsLanguage.PER: 'numeralwords_language_per',
  NumeralWordsLanguage.AMH: 'numeralwords_language_amh',
  NumeralWordsLanguage.VIE: 'numeralwords_language_vie',
  NumeralWordsLanguage.VIEHANTU: 'numeralwords_language_vie_hantu',
  NumeralWordsLanguage.VIESINO: 'numeralwords_language_vie_sino',
  //NumeralWordsLanguage.VIECHUNOM: 'numeralwords_language_vie_chunom',
  NumeralWordsLanguage.TUR: 'numeralwords_language_tur',
  NumeralWordsLanguage.MEG: 'numeralwords_language_meg',
  NumeralWordsLanguage.BRE: 'numeralwords_language_bre',
  NumeralWordsLanguage.SCO: 'numeralwords_language_sco',
  NumeralWordsLanguage.IND: 'numeralwords_language_ind',
  NumeralWordsLanguage.TAM: 'numeralwords_language_tam',
  NumeralWordsLanguage.FIN: 'numeralwords_language_fin',
  NumeralWordsLanguage.QUE: 'numeralwords_language_que',
  NumeralWordsLanguage.VOL: 'common_language_volapuek',
  NumeralWordsLanguage.EPO: 'common_language_esperanto',
  NumeralWordsLanguage.SOL: 'common_language_solresol',
  NumeralWordsLanguage.LOJ: 'numeralwords_language_loj',
  NumeralWordsLanguage.CEQ: 'numeralwords_language_ceq',
  NumeralWordsLanguage.LAT: 'common_language_latin',
  NumeralWordsLanguage.MAP: 'numeralwords_language_map',
  NumeralWordsLanguage.BAS: 'numeralwords_language_bas',
  NumeralWordsLanguage.KLI: 'numeralwords_language_kli',
  NumeralWordsLanguage.DOT: 'numeralwords_language_dot',
  NumeralWordsLanguage.MIN: 'numeralwords_language_min',
  NumeralWordsLanguage.SHA: 'numeralwords_language_sha',
  NumeralWordsLanguage.NAVI: 'numeralwords_language_navi',
  NumeralWordsLanguage.THAI: 'common_language_thai',
  NumeralWordsLanguage.THAIRTGS: 'common_language_thai_rtgs',
};

Map<NumeralWordsLanguage, String> NUMERALWORDS_LANGUAGES_CONVERTER = {
  NumeralWordsLanguage.KLI: 'numeralwords_language_kli',
  NumeralWordsLanguage.MIN: 'numeralwords_language_min',
  NumeralWordsLanguage.NAVI: 'numeralwords_language_navi',
  NumeralWordsLanguage.SHA: 'numeralwords_language_sha',
};

Map<NumeralWordsLanguage, List<int>> MIN_MAX_NUMBER = {
  NumeralWordsLanguage.KLI: [pow(-2, 53), pow(2, 53) - 1],
  NumeralWordsLanguage.MIN: [1, 100],
  NumeralWordsLanguage.NAVI: [0, 32767],
  NumeralWordsLanguage.SHA: [0, pow(2, 53) - 1],
};

Map<NumeralWordsLanguage, String> _languageList;

Map NumWords = {
  NumeralWordsLanguage.DEU: DEUWordToNum,
  NumeralWordsLanguage.ENG: ENGWordToNum,
  NumeralWordsLanguage.SCO: SCOWordToNum,
  NumeralWordsLanguage.FRA: FRAWordToNum,
  NumeralWordsLanguage.BRE: BREWordToNum,
  NumeralWordsLanguage.BAS: BASWordToNum,
  NumeralWordsLanguage.ITA: ITAWordToNum,
  NumeralWordsLanguage.ESP: ESPWordToNum,
  NumeralWordsLanguage.NLD: NLDWordToNum,
  NumeralWordsLanguage.DNK: DNKWordToNum,
  NumeralWordsLanguage.NOR: NORWordToNum,
  NumeralWordsLanguage.POR: PORWordToNum,
  NumeralWordsLanguage.SWE: SWEWordToNum,
  NumeralWordsLanguage.POL: POLWordToNum,
  NumeralWordsLanguage.RUS: RUSWordToNum,
  NumeralWordsLanguage.KYR: KYRWordToNum,
  NumeralWordsLanguage.BUL: BULWordToNum,
  NumeralWordsLanguage.BULKYR: BULKYRWordToNum,
  NumeralWordsLanguage.JAP: JAPWordToNum,
  NumeralWordsLanguage.JAPHIRAGANA: JAPHiraganaWordToNum,
  NumeralWordsLanguage.CHI: CHIWordToNum,
  NumeralWordsLanguage.CHISYMBOL: CHISymbolWordToNum,
  NumeralWordsLanguage.CHIZHUYIN: CHIZhuyinWordToNum,
  NumeralWordsLanguage.CHIFINANCE: CHIFinanceWordToNum,
  NumeralWordsLanguage.KOR: KORWordToNum,
  NumeralWordsLanguage.SINOKOR: SINOKORWordToNum,
  NumeralWordsLanguage.HANJA: HANJAWordToNum,
  NumeralWordsLanguage.HANGULKOR: HANGULKORWordToNum,
  NumeralWordsLanguage.HANGULSINOKOR: HANGULSINOKORWordToNum,
  NumeralWordsLanguage.VOL: VOLWordToNum,
  NumeralWordsLanguage.EPO: EPOWordToNum,
  NumeralWordsLanguage.SOL: SOLWordToNum,
  NumeralWordsLanguage.LOJ: LOJWordToNum,
  NumeralWordsLanguage.CEQ: CEQWordToNum,
  NumeralWordsLanguage.LAT: LATWordToNum,
  NumeralWordsLanguage.DOT: DOTWordToNum,
  NumeralWordsLanguage.KLI: KLIWordToNum,
  NumeralWordsLanguage.MAP: MAPWordToNum,
  NumeralWordsLanguage.UNG: UNGWordToNum,
  NumeralWordsLanguage.PER: PERWordToNum,
  NumeralWordsLanguage.AMH: AMHWordToNum,
  NumeralWordsLanguage.VIE: VIEWordToNum,
  NumeralWordsLanguage.VIEHANTU: VIEHANTUWordToNum,
  NumeralWordsLanguage.VIESINO: VIESINOWordToNum,
  NumeralWordsLanguage.VIECHUNOM: VIECHUNOMWordToNum,
  NumeralWordsLanguage.TUR: TURWordToNum,
  NumeralWordsLanguage.MEG: MEGWordToNum,
  NumeralWordsLanguage.IND: INDWordToNum,
  NumeralWordsLanguage.TAM: TAMWordToNum,
  NumeralWordsLanguage.FIN: FINWordToNum,
  NumeralWordsLanguage.QUE: QUEWordToNum,
  NumeralWordsLanguage.MIN: MINWordToNum,
  NumeralWordsLanguage.SHA: SHAWordToNum,
  NumeralWordsLanguage.NAVI: NAVIWordToNum,
  NumeralWordsLanguage.THAI: THAIWordToNum,
  NumeralWordsLanguage.THAIRTGS: THAIRTGSWordToNum,
};

bool _isNumeral(String input) {
  return (int.tryParse(input) != null);
}

NumeralWordsOutput _isNumeralWordTable(String input, NumeralWordsLanguage language, var decodingTable) {
  bool state = false;
  String output = '';
  String checkWord = '';
  if (language == NumeralWordsLanguage.EPO) {
    if (input.contains('dek'))
      checkWord = 'dek ' + input.split('dek').join('');
    else
      checkWord = input;
  } else {
    checkWord = input;
  }
  decodingTable.forEach((key, value) {
    if (removeAccents(key) == checkWord) {
      state = true;
      output = value;
    }
  });
  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWord10(String input, NumeralWordsLanguage language, var decodingTable) {
  bool state = false;
  String output = '';
  int orderOne = 0;
  int orderTen = 0;
  RegExp expr;
  if (language == NumeralWordsLanguage.DEU) {
    var pattern =
        '(ein|zwei|drei|vier|fuenf|sechs|sieben|acht|neun)(und)(zwanzig|dreissig|vierzig|fuenfzig|sechzig|siebzig|achtzig|neunzig)';
    expr = RegExp(pattern);
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input);
      if (matches.group(1) == 'ein')
        orderOne = 1;
      else
        orderOne = int.parse(decodingTable[matches.group(1)]);
      orderTen = int.parse(decodingTable[matches.group(3)]);
      output = (orderTen + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.ENG) {
    expr = RegExp(
        r'(twenty|thirty|fourty|fifty|sixty|seventy|eighty|ninety)[-]?(one|two|three|four|five|six|seven|eight|nine)');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input);
      orderOne = int.parse(decodingTable[matches.group(2)]);
      orderTen = int.parse(decodingTable[matches.group(1)]);
      output = (orderTen + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.VOL) {
    RegExp expr = RegExp('(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?(deg)(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input);
      if (matches.group(1) != null) orderTen = int.parse(decodingTable[matches.group(1)]);
      if (matches.group(3) != null) orderOne = int.parse(decodingTable[matches.group(3)]);
      output = (orderTen * 10 + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.EPO) {
    expr = RegExp('(unu|du|tri|kvar|kvin|ses|sep|ok|nau)?(dek)(unu|du|tri|kvar|kvin|ses|spe|ok|nau)?');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input);
      if (matches.group(1) != null) orderTen = int.parse(decodingTable[matches.group(1)]);
      if (matches.group(3) != null) orderOne = int.parse(decodingTable[matches.group(3)]);
      output = (orderTen * 10 + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.SOL) {
    expr = RegExp(
        r'^(mimisol|fafare|fafami|fafasol|fafala|fafasi|fafasimimisol|fadodo|fadodomimisol)?(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado)$');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input);
      if (matches.group(1) != null) {
        if (matches.group(1) == 'fafasimimisol' || matches.group(1) == 'fadodomimisol')
          orderTen = int.parse(decodingTable[matches.group(1).replaceAll('mimisol', ' mimisol')]);
        else
          orderTen = int.parse(decodingTable[matches.group(1)]);
      }
      if (matches.group(2) != null) orderOne = int.parse(decodingTable[matches.group(2)]);
      output = (orderTen + orderOne).toString();
    }
  }

  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language, var decodingTable) {
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch (language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
      switch (language) {
        case NumeralWordsLanguage.DEU:
          pattern = 'tausend';
          break;
        case NumeralWordsLanguage.SOL:
          pattern = 'famimi';
          break;
        case NumeralWordsLanguage.ENG:
          pattern = 'thousand';
          break;
        case NumeralWordsLanguage.VOL:
        case NumeralWordsLanguage.EPO:
          pattern = 'mil';
          break;
      }
      if (input.contains(pattern)) {
        // numeral word contains 1000
        var decode = input.split(pattern);
        if (decode.length == 2) {
          if (decode[0] == null || decode[0] == '')
            resultBefore = NumeralWordsOutput(true, '1', _languageList[language]);
          else
            resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);

          if (decode[1] == null || decode[1] == '')
            resultAfter = NumeralWordsOutput(true, '0', _languageList[language]);
          else
            resultAfter = _isNumeralWordBelow1000(decode[1], language, decodingTable);

          if (resultBefore.state && resultAfter.state) {
            state = true;
            numberBefore = int.parse(resultBefore.output) * 1000;
            numberAfter = int.parse(resultAfter.output);
            output = (numberBefore + numberAfter).toString();
          }
        } else {
          resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      } else {
        resultBefore = _isNumeralWordBelow1000(input, language, decodingTable);
        if (resultBefore.state) {
          state = true;
          output = resultBefore.output;
        }
      }
      break;
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
} // _isNumeralWord

NumeralWordsOutput _isNumeralWordBelow1000(String input, NumeralWordsLanguage language, var decodingTable) {
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  List<String> decode = new List<String>();
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch (language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
      switch (language) {
        case NumeralWordsLanguage.DEU:
          pattern = 'hundert';
          break;
        case NumeralWordsLanguage.ENG:
          pattern = 'hundred';
          break;
        case NumeralWordsLanguage.VOL:
          pattern = 'tum';
          break;
        case NumeralWordsLanguage.EPO:
          pattern = 'cent';
          break;
        case NumeralWordsLanguage.SOL:
          pattern = 'farere';
          break;
      }
      if (input.contains(pattern)) {
        // numeral word contains 100
        if (language == NumeralWordsLanguage.SOL) {
          if (decodingTable[input.split(pattern)[0]] != null)
            decode = input.split(pattern);
          else {
            decode.add(input);
          }
        } else
          decode = input.split(pattern);
        if (decode.length == 2) {
          if (decode[0] == null || decode[0] == '')
            resultBefore = NumeralWordsOutput(true, '1', _languageList[language]);
          else
            resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);

          if (decode[1] == null || decode[1] == '')
            resultAfter = NumeralWordsOutput(true, '0', _languageList[language]);
          else
            resultAfter = _isNumeralWordBelow100(decode[1], language, decodingTable);

          if (resultBefore.state && resultAfter.state) {
            state = true;
            numberBefore = int.parse(resultBefore.output) * 100;
            numberAfter = int.parse(resultAfter.output);
            output = (numberBefore + numberAfter).toString();
          }
        } else {
          resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      } else {
        resultBefore = _isNumeralWordBelow100(input, language, decodingTable);
        if (resultBefore.state) {
          state = true;
          output = resultBefore.output;
        }
      }
      break;
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWordBelow100(String input, NumeralWordsLanguage language, decodingTable) {
  bool state = false;
  String output = '';
  NumeralWordsOutput result;
  result = _isNumeralWordTable(input, language, decodingTable);
  if (result.state) {
    state = true;
    output = result.output;
  } else {
    result = _isNumeralWord10(input, language, decodingTable);
    if (result.state) {
      state = true;
      output = result.output;
    }
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
}

List<NumeralWordsDecodeOutput> decodeNumeralwords(
    String input, NumeralWordsLanguage language, var decodeModeWholeWords) {
  RegExp expr;
  List<NumeralWordsDecodeOutput> output = new List<NumeralWordsDecodeOutput>();
  if (input == null || input == '') {
    output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    return output;
  }

  _languageList = {NumeralWordsLanguage.NUM: 'numeralwords_language_num'};
  _languageList.addAll(NUMERALWORDS_LANGUAGES);

  bool _alreadyFound = false;
  var decodeText;

  if (decodeModeWholeWords) {
    // search only whole words

    String helpText;
    String helpText1;
    String inputToDecode;

    // simplify input
    input = input.replaceAll(RegExp(r'\s+'), ' ');

    // trim korean
    input = input
        .replaceAll('hah - nah', 'hah-nah')
        .replaceAll('dah suht', 'dahsuht')
        .replaceAll('yuh suht', 'yuhsuht')
        .replaceAll('eel gob', 'eelgob')
        .replaceAll('yuh duh', 'yuhduh')
        .replaceAll('ah hob', 'ahhob')
        .replaceAll('-sip', 'sip')
        .replaceAll('sip-', 'sip')
        .replaceAll('yeol-', 'yeol');

    // trim Klingon
    // identify west
    expr = RegExp(r"(ting 'ev|'ev ting)");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll(' ', '');
      });
      input = helpText;
    }

    // identify complex klingon numbers
    //expr = RegExp(r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)( |-)?(bip|netlh|sad|sanid|vatlh|mah))+( |-)?(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?\s");
    expr = RegExp(
        r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(bip|netlh|sad|sanid|vatlh|mah)( |-)?)+(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?(\s|$)");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return _complexMultipleKlingon(m.group(0));
      });
      input = helpText;
    }

    // identify single digits - change "-" to " "
    expr =
        RegExp(r"(pagh|wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(-(pagh|wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut))+");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll('-', ' ');
      });
      input = helpText;
    }

    // trim english: identify correct numeral words and remove spaces
    expr = RegExp(
        '(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen)[ ](hundred|thousand)');
    if (expr.hasMatch(input))
      helpText1 = input.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll(' ', '');
      });
    else
      helpText1 = input;

    if (helpText1.startsWith('a hundred'))
      helpText = helpText1.replaceFirst('a hundred', 'onehundred');
    else if (helpText1.startsWith('a thousand'))
      helpText = helpText1.replaceFirst('a thousand', ' a thousand');
    else
      helpText = helpText1;

    // trim esperanto : identify correct numeral words and remove spaces
    expr = RegExp('cent( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau|dek)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText1 = helpText;

    expr = RegExp('dek( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText = helpText1;

    // trim solresol : identify correct numeral words and remove spaces
    // 1st trim: SOL_farere => SOLfarere_
    expr = RegExp(r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) farere');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText1 = helpText;

    // 2nd trim:
    expr = RegExp(
        r'(fafare|fafami|fafasol|fafala|fafasi|fadodo) (mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText = helpText1;

    expr = RegExp(r'mimisol (redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText1 = helpText;

    // 3rd trim: SOLfarere_SOL => SOLfarereSOL
    expr = RegExp(
        r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)farere (fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText = helpText1;

    //4th trim: famimi_SOL => SOLfamimiSOL
    expr = RegExp(
        r'famimi (farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText1 = helpText;

    // 5th trim: SOL_famimi => SOLfamimi
    expr = RegExp(
        r'(farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) famimi');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        if (m.group(0) != ' ') return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText = helpText1;

    // trim esperanto: identify correct numeral words and remove spaces
    expr = RegExp(
        r'(.*unu|.*du|.*tri|.*kvar|.*kvin|.*ses|.*sep|.*ok|.*nau)( )mil(( )(unu.*|du.*|tri.*|kvar.*|kvin.*|ses.*|spe.*|ok.*|nau.*))?');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return m.group(0).replaceAll(' ', '');
      });
    } else
      helpText1 = helpText;

    // trim german
    inputToDecode = helpText1
        .replaceAll('zehnten', 'zehn')
        .replaceAll('zehnter', 'zehn')
        .replaceAll('zehnte', 'zehn')
        .replaceAll('zigsten', 'zig')
        .replaceAll('zigster', 'zig')
        .replaceAll('zigste', 'zig')
        .replaceAll('hundertsten', 'hundert')
        .replaceAll('hundertster', 'hundert')
        .replaceAll('hundertste', 'hundert')
        .replaceAll('tausendsten', 'tausend')
        .replaceAll('tausendster', 'tausend')
        .replaceAll('tausendste', 'tausend')
        .replaceAll(' a hundred', ' onehundred')
        .replaceAll(' hundred ', 'hundred ')
        .replaceAll('hundred and ', 'hundred')
        .replaceAll(' a thousand', ' onethousand')
        .replaceAll(' thousand', 'thousand')
        .replaceAll('thousand and ', 'thousand')
        .replaceAll('einhundert', 'einshundert')
        .replaceAll('eintausend', 'einstausend')
        .replaceAll('hundertund', 'hundert')
        .replaceAll('tausendund', 'tausend')
        .replaceAll('mil ', 'mil');

    // build map to identify numeral words
    Map searchLanguages = new Map();
    if (language == NumeralWordsLanguage.ALL) {
      // search element in all languages
      NumWords.forEach((key, value) {
        // key: language  value: map
        var sKey = key;
        Map sValue = new Map();
        value.forEach((key, value) {
          sValue[removeAccents(key.toLowerCase())] = value;
        });
        searchLanguages[sKey] = sValue;
      });
    } else {
      // search only in one language
      Map sValue = new Map();
      NumWords[language].forEach((key, value) {
        sValue[removeAccents(key.toLowerCase())] = value;
      });
      searchLanguages[language] = sValue;
    }

    // check degree ° and dot .
    inputToDecode = inputToDecode.replaceAll('°', ' ° ').replaceAll('.', ' . ').replaceAll('  ', ' ');
    // start decoding
    decodeText = inputToDecode.split(RegExp(r'[ ]'));
    decodeText.forEach((element) {
      _alreadyFound = false;
      if (element != '') {
        if (element == '°')
          output.add(NumeralWordsDecodeOutput(element, element, ''));
        else if (element == '.')
          output.add(NumeralWordsDecodeOutput(element, element, ''));
        else if (_isShadoks(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.SHA)) {
          output
              .add(NumeralWordsDecodeOutput(_decodeShadoks(element), element, _languageList[NumeralWordsLanguage.SHA]));
        } else if (_isMinion(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.MIN)) {
          output
              .add(NumeralWordsDecodeOutput(_decodeMinion(element), element, _languageList[NumeralWordsLanguage.MIN]));
        } else if (_isKlingon(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.KLI)) {
          output.add(NumeralWordsDecodeOutput(
              _decodeKlingon(element), element.replaceAll('€', ' ').trim(), _languageList[NumeralWordsLanguage.KLI]));
        } else if (_isNavi(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.NAVI)) {
          output.add(NumeralWordsDecodeOutput(_decodeNavi(element), element, _languageList[NumeralWordsLanguage.NAVI]));
        } else if (_isNumeral(element)) {
          // checks - if is a number/digit
          output.add(NumeralWordsDecodeOutput(element, element, _languageList[NumeralWordsLanguage.NUM]));
        } else {
          _alreadyFound = false;
          searchLanguages.forEach((key, value) {
            var result = _isNumeralWordTable(element, key, value); // checks - if element is part of a map
            if (result.state) {
              if (!_alreadyFound) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList[key]));
                _alreadyFound = true;
              } else {
                output.add(NumeralWordsDecodeOutput('', '', _languageList[key]));
              }
            } else {
              result = _isNumeralWord(element, key, value); // checks - if is a numeral word
              if (result.state) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList[key]));
              }
            }
          }); //forEach searchLanguage
        }
      }
    }); //for each element to decode
    return output;
  } else {
    // search parts of words: weight => eight => 8

    decodeText = input.replaceAll(' ', '').split(RegExp(r'[^a-z0-9\-]'));

    decodeText.forEach((element) {
      for (int i = 0; i < element.length; i++) {
        String checkWord = element.substring(i);
        RegExp exp = new RegExp(r"([0-9]+)");
        if (checkWord.startsWith(exp)) {
          // search for numbers
          String match = exp.firstMatch(checkWord).group(0);
          output.add(NumeralWordsDecodeOutput(match, match, _languageList[NumeralWordsLanguage.NUM]));
          i = i + match.length;
        }
        if (language == NumeralWordsLanguage.ALL) {
          _alreadyFound = false;
          int oldValueInt = 0;
          String oldValueStr = '';
          NumWords.forEach((key, value) {
            // forEach language
            var _language = key;
            value.forEach((key, value) {
              // check language map
              if (checkWord.startsWith(removeAccents(key))) {
                if (!_alreadyFound) {
                  _alreadyFound = true;
                  if (int.tryParse(value) == null)
                    oldValueStr = value;
                  else
                    oldValueInt = int.parse(value);
                  output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                } else {
                  if (int.tryParse(value) == null) if (oldValueStr == value)
                    output.add(NumeralWordsDecodeOutput('', removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                  else
                    output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                  else if (oldValueInt == int.parse(value))
                    output.add(NumeralWordsDecodeOutput('', removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                  else
                    output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                }
              }
            });
          });
        } else {
          // search for specific language
          NumWords[language].forEach((key, value) {
            if (checkWord.startsWith(removeAccents(key))) {
              _alreadyFound = true;
              output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[language]));
            }
          });
        } // else
      } // for element
    }); // forEach element
    return output;
  }
}

bool _isShadoks(String element) {
  if (element != '') if (element.replaceAll('ga', '').replaceAll('bu', '').replaceAll('zo', '').replaceAll('meu', '') ==
      '')
    return true;
  else
    return false;
  else
    return false;
}

bool _isMinion(String element) {
  if (element != '')
    return (element.replaceAll('hana', '').replaceAll('dul', '').replaceAll('sae', '') == '');
  else
    return false;
}

bool _isKlingon(String element) {
  if (element != '')
    return (element
            .replaceAll(' ', '')
            .replaceAll('€', '')
            .replaceAll('pagh', '')
            .replaceAll("wa'", '')
            .replaceAll("cha'", '')
            .replaceAll('wej', '')
            .replaceAll('los', '')
            .replaceAll('vagh', '')
            .replaceAll('jav', '')
            .replaceAll('soch', '')
            .replaceAll('chorgh', '')
            .replaceAll('hut', '')
            .replaceAll('mah', '')
            .replaceAll('vatlh', '')
            .replaceAll('sad', '')
            .replaceAll('sanid', '')
            .replaceAll('netlh', '')
            .replaceAll('bip', '')
            .replaceAll('chan', '') ==
        '');
  else
    return false;
}

bool _isNavi(String element) {
  element = element.replaceAll('zame', 'zamme').replaceAll('zamrr', 'zammrr');
  element = element
      .replaceAll('mezazam', '')
      .replaceAll('pxezazam', '')
      .replaceAll('tsizazam', '')
      .replaceAll('mrrzazam', '')
      .replaceAll('puzazam', '')
      .replaceAll('kizazam', '')
      .replaceAll('zazam', '')
      .replaceAll('mevozam', '')
      .replaceAll('pxevozam', '')
      .replaceAll('tsivozam', '')
      .replaceAll('mrrvozam', '')
      .replaceAll('puvozam', '')
      .replaceAll('kivozam', '')
      .replaceAll('vozam', '')
      .replaceAll('mezam', '')
      .replaceAll('pxezam', '')
      .replaceAll('tsizam', '')
      .replaceAll('mrrzam', '')
      .replaceAll('puzam', '')
      .replaceAll('kizam', '')
      .replaceAll('zam', '')
      .replaceAll('mevol', '')
      .replaceAll('pxevol', '')
      .replaceAll('tsivol', '')
      .replaceAll('mrrvol', '')
      .replaceAll('puvol', '')
      .replaceAll('kivol', '')
      .replaceAll('vol', '')
      .replaceAll('mevo', '')
      .replaceAll('pxevo', '')
      .replaceAll('tsivo', '')
      .replaceAll('mrrvo', '')
      .replaceAll('puvo', '')
      .replaceAll('kivo', '')
      .replaceAll('vo', '')
      .replaceAll('kew', '')
      .replaceAll('aw', '')
      .replaceAll('mune', '')
      .replaceAll('mun', '')
      .replaceAll('mrr', '')
      .replaceAll('peysing', '')
      .replaceAll('pxey', '')
      .replaceAll('pey', '')
      .replaceAll('fu', '')
      .replaceAll('hin', '')
      .replaceAll('tsing', '')
      .replaceAll('pukap', '')
      .replaceAll('kinae', '')
      .replaceAll('sing', '')
      .replaceAll('za', '')
      .replaceAll('ki', '');

  return (element == '');
}

String _decodeNavi(String element) {
  // https://de.wikipedia.org/wiki/Na%E2%80%99vi-Sprache#Zahlen
  // https://james-camerons-avatar.fandom.com/de/wiki/Oktale_Arithmetik
  // https://forum.learnnavi.org/navi-lernen/das-navi-zahlensystem/#:~:text=Das%20Na%27vi%20hat%20zwei%20Lehnw%C3%B6rter%20aus%20dem%20Englischen.,Ziffern%2C%20wie%20z.%20B.%20Telefonnummern%2C%20Autokennzeichen%2C%20IDs%20etc.
  String octal = '';
  if (NAVIWordToNum[element] != null) return NAVIWordToNum[element];

  element = element
      .replaceAll('zame', 'zamme')
      .replaceAll('zavo', 'zamvo')
      .replaceAll('zapxe', 'zampxe')
      .replaceAll('zatsi', 'zamtsi')
      .replaceAll('zapu', 'zampu')
      .replaceAll('zamrr', 'zammrr')
      .replaceAll('zaki', 'zamki')
      .replaceAll('zasing', 'zamsing')
      .replaceAll('voaw', 'volaw')
      .replaceAll('vomun', 'volmun')
      .replaceAll('vopey', 'volpey')
      .replaceAll('vosing', 'volsing')
      .replaceAll('vomrr', 'volmrr')
      .replaceAll('vofu', 'volfu')
      .replaceAll('vohin', 'volhin');

  // check 4096
  if (element.contains('kizazam') ||
      element.contains('puzazam') ||
      element.contains('mrrzazam') ||
      element.contains('tsizazam') ||
      element.contains('pxezazam') ||
      element.contains('mezazam') ||
      element.contains('zazam')) {
    if (element.contains('kizazam')) {
      octal = '7';
      element = element.replaceAll('kizazam', '');
    } else if (element.contains('puzazam')) {
      octal = '6';
      element = element.replaceAll('puzazam', '');
    } else if (element.contains('mrrzazam')) {
      octal = '5';
      element = element.replaceAll('mrrzazam', '');
    } else if (element.contains('tsizazam')) {
      octal = '4';
      element = element.replaceAll('tsizazam', '');
    } else if (element.contains('pxezazam')) {
      octal = '3';
      element = element.replaceAll('pxezazam', '');
    } else if (element.contains('mezazam')) {
      octal = '2';
      element = element.replaceAll('mezazam', '');
    } else if (element.contains('zazam')) {
      octal = '1';
      element = element.replaceAll('zazam', '');
    }
  } else
    octal = '0';

  // check 512
  if (element.contains('kivozam') ||
      element.contains('puvozam') ||
      element.contains('mrrvozam') ||
      element.contains('tsivozam') ||
      element.contains('pxevozam') ||
      element.contains('mevozam') ||
      element.contains('vozam')) {
    if (element.contains('kivozam')) {
      octal = octal + '7';
      element = element.replaceAll('kivozam', '');
    } else if (element.contains('puvozam')) {
      octal = octal + '6';
      element = element.replaceAll('puvozam', '');
    } else if (element.contains('mrrvozam')) {
      octal = octal + '5';
      element = element.replaceAll('mrrvozam', '');
    } else if (element.contains('tsivozam')) {
      octal = octal + '4';
      element = element.replaceAll('tsivozam', '');
    } else if (element.contains('pxevozam')) {
      octal = octal + '3';
      element = element.replaceAll('pxevozam', '');
    } else if (element.contains('mevozam')) {
      octal = octal + '2';
      element = element.replaceAll('mevozam', '');
    } else if (element.contains('vozam')) {
      octal = octal + '1';
      element = element.replaceAll('vozam', '');
    }
  } else
    octal = octal + '0';

  // check 64
  if (element.contains('kizam') ||
      element.contains('puzam') ||
      element.contains('mrrzam') ||
      element.contains('tsizam') ||
      element.contains('pxezam') ||
      element.contains('mezam') ||
      element.contains('zam')) {
    if (element.contains('kizam')) {
      octal = octal + '7';
      element = element.replaceAll('kizam', '');
    } else if (element.contains('puzam')) {
      octal = octal + '6';
      element = element.replaceAll('puzam', '');
    } else if (element.contains('mrrzam')) {
      octal = octal + '5';
      element = element.replaceAll('mrrzam', '');
    } else if (element.contains('tsizam')) {
      octal = octal + '4';
      element = element.replaceAll('tsizam', '');
    } else if (element.contains('pxezam')) {
      octal = octal + '3';
      element = element.replaceAll('pxezam', '');
    } else if (element.contains('mezam')) {
      octal = octal + '2';
      element = element.replaceAll('mezam', '');
    } else if (element.contains('zam')) {
      octal = octal + '1';
      element = element.replaceAll('zam', '');
    }
  } else
    octal = octal + '0';

  // check 8
  if (element.contains('kivol') ||
      element.contains('puvol') ||
      element.contains('mrrvol') ||
      element.contains('tsivol') ||
      element.contains('pxevol') ||
      element.contains('mevol') ||
      element.contains('vol')) {
    if (element.contains('kivol')) {
      octal = octal + '7';
      element = element.replaceAll('kivol', '');
    } else if (element.contains('puvol')) {
      octal = octal + '6';
      element = element.replaceAll('puvol', '');
    } else if (element.contains('mrrvol')) {
      octal = octal + '5';
      element = element.replaceAll('mrrvol', '');
    } else if (element.contains('tsivol')) {
      octal = octal + '4';
      element = element.replaceAll('tsivol', '');
    } else if (element.contains('pxevol')) {
      octal = octal + '3';
      element = element.replaceAll('pxevol', '');
    } else if (element.contains('mevol')) {
      octal = octal + '2';
      element = element.replaceAll('mevol', '');
    } else if (element.contains('vol')) {
      octal = octal + '1';
      element = element.replaceAll('vol', '');
    }
  } else
    octal = octal + '0';

  // check 1
  if (element.contains('hin') ||
      element.contains('fu') ||
      element.contains('mrr') ||
      element.contains('sing') ||
      element.contains('pey') ||
      element.contains('mun') ||
      element.contains('aw')) {
    if (element.contains('hin')) {
      octal = octal + '7';
    } else if (element.contains('fu')) {
      octal = octal + '6';
    } else if (element.contains('mrr')) {
      octal = octal + '5';
    } else if (element.contains('sing')) {
      octal = octal + '4';
    } else if (element.contains('pey')) {
      octal = octal + '3';
    } else if (element.contains('mun')) {
      octal = octal + '2';
    } else if (element.contains('aw')) {
      octal = octal + '1';
    }
  } else
    octal = octal + '0';

  return convertBase(octal, 8, 10);
}

String _decodeKlingon(String element) {
  if (element == '') return '';
  if (element[0] == '€' && element[element.length - 1] == '€')
    return _decodeMultipleKlingon(element.substring(1, element.length - 1));
  if (element == 'chan') return 'numeralwords_e';
  if (element == "ting'ev" || element == "'evting" || element == 'maH') return 'numeralwords_w';
  if (element == "'oy'") return 'numeralwords_n';
  if (element == 'watlh') return 'numeralwords_s';
  if (element == 'ngev' || element == 'ghob') return '.';
  if (element == 'qoch') return '°';
  String result = element
      .replaceAll('pagh', '0')
      .replaceAll("wa'", '1')
      .replaceAll("cha'", '2')
      .replaceAll('wej', '3')
      .replaceAll('los', '4')
      .replaceAll('vagh', '5')
      .replaceAll('jav', '6')
      .replaceAll('soch', '7')
      .replaceAll('chorgh', '8')
      .replaceAll('hut', '9')
      .replaceAll('mah', '0')
      .replaceAll('vatlh', '00')
      .replaceAll('sad', '000')
      .replaceAll('sanid', '000')
      .replaceAll('netlh', '0000')
      .replaceAll('bip', '00000');
  return result;
}

String _decodeShadoks(String element) {
  return convertBase(
      element.replaceAll('ga', '0').replaceAll('bu', '1').replaceAll('zo', '2').replaceAll('meu', '3'), 4, 10);
}

String _decodeMinion(String element) {
  int number = 0;
  element.replaceAll('hana', '1').replaceAll('dul', '2').replaceAll('sae', '3').split('').forEach((element) {
    number = number + int.parse(element);
  });
  return number.toString();
}

String _decodeMultipleKlingon(String kliNumber) {
  kliNumber = kliNumber.trim();
  if (kliNumber == '') return '';
  int number = 0;
  kliNumber.split('€').forEach((element) {
    if (int.tryParse(_decodeKlingon(element)) != null) number = number + int.parse(_decodeKlingon(element));
  });
  return number.toString();
}

String _complexMultipleKlingon(String kliNumber) {
  return '€' + kliNumber.trim().replaceAll('-', '€').replaceAll(' ', '€') + '€ ';
}

OutputConvertToNumber decodeNumeralWordToNumber(NumeralWordsLanguage _currentLanguage, String currentDecodeInput) {
  if (currentDecodeInput == '' || currentDecodeInput == null) return OutputConvertToNumber(0, '', '', '');

  if (_currentLanguage == NumeralWordsLanguage.NAVI) {
    if (_isNavi(currentDecodeInput))
      return OutputConvertToNumber(int.parse(_decodeNavi(currentDecodeInput)),
          convertBase(_decodeNavi(currentDecodeInput), 10, 8), 'common_numeralbase_octenary', '');
    else
      return OutputConvertToNumber(0, '', '', 'numeralwords_converter_error_navi');
  }
  if (_currentLanguage == NumeralWordsLanguage.SHA) {
    if (_isShadoks(currentDecodeInput))
      return OutputConvertToNumber(int.parse(_decodeShadoks(currentDecodeInput)),
          convertBase(_decodeShadoks(currentDecodeInput), 10, 4), 'common_numeralbase_quaternary', '');
    else
      return OutputConvertToNumber(0, '', '', 'numeralwords_converter_error_shadoks');
  } else if (_currentLanguage == NumeralWordsLanguage.MIN) {
    if (_isMinion(currentDecodeInput))
      return OutputConvertToNumber(int.parse(_decodeMinion(currentDecodeInput)), '', '', '');
    else
      return OutputConvertToNumber(0, '', '', 'numeralwords_converter_error_minion');
  } else if (_currentLanguage == NumeralWordsLanguage.KLI) {
    if (_isKlingon(currentDecodeInput)) {
      RegExp expr = RegExp(
          r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(bip|netlh|sad|sanid|vatlh|mah)( |-)?)+(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?(\s|$)");
      if (expr.hasMatch(currentDecodeInput)) {
        String helpText = currentDecodeInput.replaceAllMapped(expr, (Match m) {
          return _complexMultipleKlingon(m.group(0));
        });
        currentDecodeInput = helpText;
      }
      return OutputConvertToNumber(
          int.parse(_decodeMultipleKlingon(currentDecodeInput.replaceAll(' ', ''))), '', '', '');
    } else
      return OutputConvertToNumber(0, '', '', 'numeralwords_converter_error_klingon');
  }
}

OutputConvertToNumeralWord _encodeNavi(int currentNumber) {
  String numeralWord = '';
  String octal = '';
  if (0 <= currentNumber && currentNumber <= 7) {
    switch (currentNumber) {
      case 0:
        numeralWord = 'kew';
        break;
      case 1:
        numeralWord = "'aw";
        break;
      case 2:
        numeralWord = 'mune';
        break;
      case 3:
        numeralWord = 'pxey';
        break;
      case 4:
        numeralWord = 'tsìng';
        break;
      case 5:
        numeralWord = 'mrr';
        break;
      case 6:
        numeralWord = 'pukap';
        break;
      case 7:
        numeralWord = 'kinä';
        break;
    }
  } else {
    octal = convertBase(currentNumber.toString(), 10, 8);
    while (octal.length < 5) octal = '0' + octal;
    switch (octal[0]) {
      //  4096
      case '0':
        numeralWord = '';
        break;
      case '1':
        numeralWord = 'zazam';
        break;
      case '2':
        numeralWord = 'mezazam';
        break;
      case '3':
        numeralWord = 'pxezazam';
        break;
      case '4':
        numeralWord = 'tsìzazam';
        break;
      case '5':
        numeralWord = 'mrrzazam';
        break;
      case '6':
        numeralWord = 'puzazam';
        break;
      case '7':
        numeralWord = 'kizazam';
        break;
    }
    switch (octal[1]) {
      // 512
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'vozam';
        break;
      case '2':
        numeralWord = numeralWord + 'mevozam';
        break;
      case '3':
        numeralWord = numeralWord + 'pxevozam';
        break;
      case '4':
        numeralWord = numeralWord + 'tsìvozam';
        break;
      case '5':
        numeralWord = numeralWord + 'mrrvozam';
        break;
      case '6':
        numeralWord = numeralWord + 'puvozam';
        break;
      case '7':
        numeralWord = numeralWord + 'kivozam';
        break;
    }
    switch (octal[2]) {
      // 64
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'zam';
        break;
      case '2':
        numeralWord = numeralWord + 'mezam';
        break;
      case '3':
        numeralWord = numeralWord + 'pxezam';
        break;
      case '4':
        numeralWord = numeralWord + 'tsìzam';
        break;
      case '5':
        numeralWord = numeralWord + 'mrrzam';
        break;
      case '6':
        numeralWord = numeralWord + 'puzam';
        break;
      case '7':
        numeralWord = numeralWord + 'kizam';
        break;
    }
    if (octal[4] == '0')
      switch (octal[3]) {
        // 8
        case '0':
          numeralWord = numeralWord + '';
          break;
        case '1':
          numeralWord = numeralWord + 'vol';
          break;
        case '2':
          numeralWord = numeralWord + 'mevol';
          break;
        case '3':
          numeralWord = numeralWord + 'pxevol';
          break;
        case '4':
          numeralWord = numeralWord + 'tsìvol';
          break;
        case '5':
          numeralWord = numeralWord + 'mrrvol';
          break;
        case '6':
          numeralWord = numeralWord + 'puvol';
          break;
        case '7':
          numeralWord = numeralWord + 'kivol';
          break;
      }
    else
      switch (octal[3]) {
        // 8
        case '0':
          numeralWord = numeralWord + '';
          break;
        case '1':
          numeralWord = numeralWord + 'vo';
          break;
        case '2':
          numeralWord = numeralWord + 'mevo';
          break;
        case '3':
          numeralWord = numeralWord + 'pxevo';
          break;
        case '4':
          numeralWord = numeralWord + 'tsìvo';
          break;
        case '5':
          numeralWord = numeralWord + 'mrrvo';
          break;
        case '6':
          numeralWord = numeralWord + 'puvo';
          break;
        case '7':
          numeralWord = numeralWord + 'kivo';
          break;
      }
    switch (octal[4]) {
      // 1
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'aw';
        break;
      case '2':
        numeralWord = numeralWord + 'mun';
        break;
      case '3':
        numeralWord = numeralWord + 'pey';
        break;
      case '4':
        numeralWord = numeralWord + 'sìng';
        break;
      case '5':
        numeralWord = numeralWord + 'mrr';
        break;
      case '6':
        numeralWord = numeralWord + 'fu';
        break;
      case '7':
        numeralWord = numeralWord + 'hin';
        break;
    }
  }
  return OutputConvertToNumeralWord(
      numeralWord
          .replaceAll('zamk', 'zak')
          .replaceAll('zamm', 'zam')
          .replaceAll('zamp', 'zap')
          .replaceAll('zams', 'zas')
          .replaceAll('zamt', 'zat')
          .replaceAll('zamv', 'zav')
          .replaceAll('voaw', 'volaw'),
      convertBase(currentNumber.toString(), 10, 8),
      'common_numeralbase_octenary',
      '');
}

OutputConvertToNumeralWord _encodeShadok(int currentNumber) {
  String numeralWord = '';
  numeralWord = convertBase(currentNumber.toString(), 10, 4)
      .toString()
      .replaceAll('0', 'GA')
      .replaceAll('1', 'BU')
      .replaceAll('2', 'ZO')
      .replaceAll('3', 'MEU');
  return OutputConvertToNumeralWord(
      numeralWord, convertBase(currentNumber.toString(), 10, 4), 'common_numeralbase_quaternary', '');
}

OutputConvertToNumeralWord _encodeMinion(int currentNumber) {
  String numeralWord = '';
  if (currentNumber < 1) return OutputConvertToNumeralWord('', '', '', '');
  List<String> digits = [];
  numeralWord = '';
  while (currentNumber >= 3) {
    currentNumber = currentNumber - 3;
    digits.add('3');
  }
  while (currentNumber >= 2) {
    currentNumber = currentNumber - 2;
    digits.add('2');
  }
  while (currentNumber >= 1) {
    currentNumber = currentNumber - 1;
    digits.add('1');
  }
  numeralWord = digits.join('').replaceAll('3', 'SAE').replaceAll('2', 'DUL').replaceAll('1', 'HANA');
  return OutputConvertToNumeralWord(numeralWord, '', '', '');
}

OutputConvertToNumeralWord _encodeKlingon(int currentNumber) {
  String numeralWord = '';
  numeralWord = '';
  if (currentNumber == 0) return OutputConvertToNumeralWord('pagh', '', '', '');

  bool negative = false;
  if (currentNumber < 0) {
    negative = true;
    currentNumber = -1 * currentNumber;
  }
  int tenth = pow(10, (currentNumber.toString().length - 1));
  while (currentNumber > 0) {
    switch (currentNumber ~/ tenth) {
      case 0:
        numeralWord = numeralWord + "pagh";
        break;
      case 1:
        numeralWord = numeralWord + "wa'";
        break;
      case 2:
        numeralWord = numeralWord + "cha'";
        break;
      case 3:
        numeralWord = numeralWord + "wej";
        break;
      case 4:
        numeralWord = numeralWord + "loS";
        break;
      case 5:
        numeralWord = numeralWord + "vagh";
        break;
      case 6:
        numeralWord = numeralWord + "jav";
        break;
      case 7:
        numeralWord = numeralWord + "Soch";
        break;
      case 8:
        numeralWord = numeralWord + "chorgh";
        break;
      case 9:
        numeralWord = numeralWord + "Hut";
        break;
    }
    switch (tenth) {
      case 10:
        numeralWord = numeralWord + "maH ";
        break;
      case 100:
        numeralWord = numeralWord + "vatlh ";
        break;
      case 1000:
        numeralWord = numeralWord + "SaD ";
        break;
      case 10000:
        numeralWord = numeralWord + "SanID ";
        break;
      case 100000:
        numeralWord = numeralWord + "netlh ";
        break;
      case 1000000:
        numeralWord = numeralWord + "bIp ";
        break;
      case 10000000:
        numeralWord = numeralWord + "'uy' ";
        break;
      case 100000000:
        numeralWord = numeralWord + "Saghan ";
        break;
    }
    currentNumber = currentNumber % tenth;
    tenth = tenth ~/ 10;
  }
  if (negative) numeralWord = numeralWord + ' Dop';
  return OutputConvertToNumeralWord(numeralWord, '', '', '');
}

OutputConvertToNumeralWord encodeNumberToNumeralWord(NumeralWordsLanguage _currentLanguage, int currentNumber) {
  if (currentNumber == '' || currentNumber == null) return OutputConvertToNumeralWord('', '', '', '');

  switch (_currentLanguage) {
    case NumeralWordsLanguage.NAVI:
      return _encodeNavi(currentNumber);
      break;
    case NumeralWordsLanguage.SHA:
      return _encodeShadok(currentNumber);
      break;
    case NumeralWordsLanguage.MIN:
      return _encodeMinion(currentNumber);
      break;
    case NumeralWordsLanguage.KLI:
      return _encodeKlingon(currentNumber);
      break;
  }
}
