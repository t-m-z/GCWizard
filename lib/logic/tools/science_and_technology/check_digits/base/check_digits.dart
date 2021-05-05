import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/ean.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_persid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_taxid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/iban.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/imei.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/isbn.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/euro.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum CheckDigitsMode {
  EAN,
  DEPERSID,
  DETAXID,
  EURO,
  IBAN,
  IMEI,
  ISBN
}

final MASKINPUTFORMATTER_EURO = MaskTextInputFormatter(mask: "@########", filter: {"@": RegExp(r'[AB?]'), "#": RegExp(r'[0-9?]')});
final MASKINPUTFORMATTER_IBAN = MaskTextInputFormatter(mask: "@@################################", filter: {"@": RegExp(r'[A-Za-z?]'), "#": RegExp(r'[0-9?]')});
final MASKINPUTFORMATTER_ISBN = MaskTextInputFormatter(mask: "#########@###", filter: {"@": RegExp(r'[A-Za-z0-9?]'), "#": RegExp(r'[0-9?]')});
final MASKINPUTFORMATTER_DEPERSID = MaskTextInputFormatter(mask: "##########@<<#######<#######<<<<<<<#", filter: {"@": RegExp(r'[A-Za-z?]'), "#": RegExp(r'[0-9?]')});
final MASKINPUTFORMATTER_DETAXID = MaskTextInputFormatter(mask: "###########");
final MASKINPUTFORMATTER_IMEI = MaskTextInputFormatter(mask: "###############");
final MASKINPUTFORMATTER_EAN = MaskTextInputFormatter(mask: "##################");

Map INPUTFORMATTERS = {
  CheckDigitsMode.ISBN : MASKINPUTFORMATTER_ISBN,
  CheckDigitsMode.IBAN : MASKINPUTFORMATTER_IBAN,
  CheckDigitsMode.EURO : MASKINPUTFORMATTER_EURO,
  CheckDigitsMode.DEPERSID : MASKINPUTFORMATTER_DEPERSID,
};

Map INPUTFORMATTERS_HINT = {
  CheckDigitsMode.ISBN : "000000000@000",
  CheckDigitsMode.IBAN : "AA00000000000000000000000000000000",
  CheckDigitsMode.EURO : "A@0000000000",
  CheckDigitsMode.DEPERSID : "0000000000@<<0000000<0000000<<<<<<<0",
};

final Map maxInt = {
  CheckDigitsMode.EAN     : 999999999999999999, // 18 digits
  CheckDigitsMode.IMEI    : 999999999999999,    // 15 digits
  CheckDigitsMode.DETAXID : 99999999999,        // 11 digits
};

class CheckDigitOutput{
  final bool correct;
  final String correctDigit;
  final List<String> correctNumbers;

  CheckDigitOutput(this.correct, this.correctDigit, this.correctNumbers);
}

CheckDigitOutput checkDigitsCheckNumber(CheckDigitsMode mode, String number){
  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CheckEANNumber(number);
    case CheckDigitsMode.DEPERSID:
      return CheckDEPersIDNumber(number);
    case CheckDigitsMode.DETAXID:
      return CheckDETaxIDNumber(number);
    case CheckDigitsMode.EURO:
      return CheckEURONumber(number);
    case CheckDigitsMode.IBAN:
      return CheckIBANNumber(number);
    case CheckDigitsMode.IMEI:
      return CheckIMEINumber(number);
    case CheckDigitsMode.ISBN:
      return CheckISBNNumber(number);
    default:
      return CheckDigitOutput(false, '', ['']);
  }
}

String checkDigitsCalculateNumber(CheckDigitsMode mode, String number){
  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CalculateNumber(number, CalculateEANNumber);
    case CheckDigitsMode.DEPERSID:
      return CalculateNumber(number, CalculateDEPersIDNumber);
    case CheckDigitsMode.DETAXID:
      return CalculateNumber(number, CalculateDETaxIDNumber);
    case CheckDigitsMode.EURO:
      return CalculateNumber(number, CalculateEURONumber);
    case CheckDigitsMode.IBAN:
      return CalculateNumber(number, CalculateIBANNumber);
    case CheckDigitsMode.IMEI:
      return CalculateNumber(number, CalculateIMEINumber);
    case CheckDigitsMode.ISBN:
      return CalculateNumber(number, CalculateISBNNumber);
    default:
      return '';
  }
}

List<String> checkDigitsCalculateDigits(CheckDigitsMode mode, String number){
  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CalculateEANDigits(number);
    case CheckDigitsMode.DEPERSID:
      return CalculateDEPersIDDigits(number);
    case CheckDigitsMode.DETAXID:
      return CalculateDETaxIDDigits(number);
    case CheckDigitsMode.EURO:
      return CalculateIBANDigits(number);
    case CheckDigitsMode.IBAN:
      return CalculateIBANDigits(number);
    case CheckDigitsMode.IMEI:
      return CalculateIMEIDigits(number);
    case CheckDigitsMode.ISBN:
      return CalculateISBNDigits(number);
    default:
      return [''];
  }
}

bool checkNumber(String number, Function f){
  return f(number);
}

String  calculateCheckDigit(String number, Function f) {
  return f(number);
}

String CalculateNumber(String number, Function f){
  return f(number);
}

List<String> CalculateGlitch(String number, Function f) {
  List<String> result = new List<String>();
  String test = '';
  String testLeft = '';
  String testRight = '';
  int startIndex = 1;
  if (f == checkIBAN)
    startIndex = 4;
  for (int index = startIndex; index < number.length; index ++) {
    testLeft = number.substring(0, index - 1);
    testRight = number.substring(index);
    for (int testDigit = 0; testDigit <= 9; testDigit++) {
      test = testLeft + testDigit.toString() + testRight;
      if (checkNumber(test, f))
        result.add(test);
    } // for testDigit
  } // for index
  return result;
}

List<String> CalculateDigits(String number, Function f){
  List<String> result = new List<String>();
  int maxDigits = 0;
  int len = 0;
  int letters = 0;
  String maxNumber = '';
  int index = 0;
  String numberToCheck = '';
  if (f == checkIBAN) {
    for (int i = 0 ; i < number.length; i++){
      if (number[i] == '?')
        if (i < 2)
          maxNumber = maxNumber + 'Z';
        else
          maxNumber = maxNumber + '9';
    }
    if (maxNumber.startsWith('ZZ')){
      letters = 2;
      maxNumber = maxNumber.substring(2);
    }
    else
    if (maxNumber.startsWith('Z')){
      letters = 1;
      maxNumber = maxNumber.substring(1);
    }
    else {
      letters = 0;
    }
    len = maxNumber.length;
    maxDigits = int.parse(maxNumber);

    if (letters == 0) {
      for (int i = 0; i < maxDigits; i++) {
        maxNumber = i.toString();
        maxNumber = maxNumber.padLeft(len, '0');
        index = 0;
        numberToCheck = number.substring(0,2);
        print('check ' + number + ' ' + maxNumber);
        for (int i = 2; i < number.length; i++) {
          if (int.tryParse(number[i]) == null) {
            numberToCheck = numberToCheck + maxNumber[index];
            index++;
          } else {
            numberToCheck = numberToCheck + number[i];
          }
        }
        if (checkNumber(numberToCheck, f))
          result.add(numberToCheck);
      }
    }else
      for (int l1 = 65; l1 < 92; l1++){
        numberToCheck = String.fromCharCode(l1);
        if (letters == 2)
          for (int l2 = 65; l2 < 92; l2++) {
            numberToCheck = numberToCheck + String.fromCharCode(l2);
            for (int i = 0; i < maxDigits; i++) {
              maxNumber = i.toString();
              maxNumber = maxNumber.padLeft(len, '0');
              index = 0;
              numberToCheck = '';
              for (int i = 0; i < number.length; i++) {
                if (int.tryParse(number[i]) == null) {
                  numberToCheck = numberToCheck + maxNumber[index];
                  index++;
                } else {
                  numberToCheck = numberToCheck + number[i];
                }
              }
              if (checkNumber(numberToCheck, f))
                result.add(numberToCheck);
            }
          }
        else
          for (int i = 0; i < maxDigits; i++) {
            maxNumber = i.toString();
            maxNumber = maxNumber.padLeft(len, '0');
            index = 0;
            numberToCheck = '';
            for (int i = 0; i < number.length; i++) {
              if (int.tryParse(number[i]) == null) {
                numberToCheck = numberToCheck + maxNumber[index];
                index++;
              } else {
                numberToCheck = numberToCheck + number[i];
              }
            }
            if (checkNumber(numberToCheck, f))
              result.add(numberToCheck);
          }
      }

    } else {
      for (int i = 0; i < number.length; i++)
        if (int.tryParse(number[i]) == null) {
          maxNumber = maxNumber + '9';
        }

      len = maxNumber.length;
      maxDigits = int.parse(maxNumber);
      for (int i = 0; i < maxDigits; i++) {
        maxNumber = i.toString();
        maxNumber = maxNumber.padLeft(len, '0');
        index = 0;
        numberToCheck = '';
        for (int i = 0; i < number.length; i++) {
          if (int.tryParse(number[i]) == null) {
            numberToCheck = numberToCheck + maxNumber[index];
            index++;
          } else {
            numberToCheck = numberToCheck + number[i];
          }
        }
        if (checkNumber(numberToCheck, f))
          result.add(numberToCheck);
      }
    }
  return result;
}