// https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592
// https://www.bundesbank.de/resource/blob/603320/16a80c739bbbae592ca575905975c2d0/mL/pruefzifferberechnungsmethoden-data.pdf

import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/de_bankaccount_methods.dart';

final Map BANK_ACCOUNT_CHECKDIGITS = {
  '00' : {'mod' : 10, 'weight' : [2,1,2,1,2,1,2,1,2]},
  '01' : {'mod' : 10, 'weight' : [3,7,1,3,7,1,3,7,1]},
  '02' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,8,9,2]},
  '03' : {'mod' : 10, 'weight' : [2,1,2,1,2,1,2,1,2]},
  '04' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,2,3,4]},
  '05' : {'mod' : 10, 'weight' : [7,3,1,7,3,1,7,3,1]},
  '06' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,2,3,4]},
  '07' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,8,9,10]},
  '08' : {'mod' : 10, 'weight' : [2,1,2,1,2,1,2,1,2]},
  '09' : {'mod' : 1, 'weight' : [1,1,1,1,1,1,1,1,1]},
  '10' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,8,9,10]},
  '11' : {'mod' : 11, 'weight' : [2,3,4,5,6,7,8,9,10]},
  '12' : {'mod' : 1, 'weight' : [1,1,1,1,1,1,1,1,1]},
  '13' : {'mod' : 10, 'weight' : [2,1,2,1,2,1]},
  '14' : {'mod' : 10, 'weight' : []},
  '15' : {'mod' : 10, 'weight' : []},
  '16' : {'mod' : 10, 'weight' : []},
  '17' : {'mod' : 10, 'weight' : []},
};

final Map IBAN_DATA = {
  'DE' : [4, 12],
};

bool checkBankaccount(String iban){
  String bankNumber = iban.substring(IBAN_DATA[iban.substring(0,2)][0], 12);
  String bankAccount = iban.substring(IBAN_DATA[iban.substring(0,2)][1]);
  String bankMethod = BANK_ACCOUNT_METHODS[bankNumber];
  print(iban+'.'+bankNumber+'.'+bankAccount+'.'+bankMethod);

  return false;
}

String calcBankaccount(String iban){

}