part of 'gcwizard_scipt_test.dart';

List<Map<String, Object?>> _inputsCryptoToExpected = [
  {'code' : 'a="HALLO"\nprint ABADDON(a, 1)', 'expectedOutput' : 'þµ¥¥¥µµ¥¥µ¥¥þþþ'},
  {'code' : 'a="þµ¥¥¥µµ¥¥µ¥¥þþþ"\nprint ABADDON(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint ATBASH(a)', 'expectedOutput' : 'SZOOL'},
  {'code' : 'a="SZOOL"\nprint ATBASH(a)', 'expectedOutput' : 'HALLO'},

  // It does not mak sense to test a function which is based on a random function
  // {'code' : 'a="HALLO"\nprint AVEMARIA(a, 1)', 'expectedOutput' : 'arbiter clemens immortalis immortalis gloriosus'},
  {'code' : 'a="arbiter clemens immortalis immortalis gloriosus"\nprint AVEMARIA(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint BACON(a, 1)', 'expectedOutput' : 'AABBBAAAAAABABAABABAABBAB'},
  {'code' : 'a="AABBBAAAAAABABAABABAABBAB"\nprint BACON(a, 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'a="HALLO"\nprint rot5(a)', 'expectedOutput' : 'HALLO'},
  {'code' : 'a="123"\nprint rot5(a)', 'expectedOutput' : '678'},
  {'code' : 'a="HALLO"\nprint rot13(a)', 'expectedOutput' : 'MFQQT'},
  {'code' : 'a="HALLO123"\nprint rot13(a)', 'expectedOutput' : 'MFQQT123'},
  {'code' : 'a="HALLO"\nprint rot18(a)', 'expectedOutput' : 'MFQQT'},
  {'code' : 'a="HALLO123"\nprint rot18(a)', 'expectedOutput' : 'MFQQT678'},
  {'code' : 'a="HALLO"\nprint rot47(a)', 'expectedOutput' : 'wp{{~'},
  {'code' : 'a="HALLO123"\nprint rot47(a)', 'expectedOutput' : 'wp{{~`ab'},
  {'code' : 'a="HALLO"\nprint rotx(a, 1)', 'expectedOutput' : 'IBMMP'},
  {'code' : 'a="HALLO123"\nprint rotx(a, 1)', 'expectedOutput' : 'IBMMP123'},

  {'code' : 'print gccode("gcafdx1", 0)', 'expectedOutput' : '9284317'},
  {'code' : 'print gccode("9284317", 1)', 'expectedOutput' : 'GCAFDX1'},
  {'code' : 'print gccode(9284317, 1)', 'expectedOutput' : 'GCAFDX1'},

  {'code' : 'print morse("hallo", 1, 0)', 'expectedOutput' : '.... .- .-.. .-.. ---'},
  {'code' : 'print morse("1234", 1, 0)\nmorse("1234", 1, 1)\nmorse("1234", 1, 2)\nmorse("1234", 1, 3)', 'expecteOutput' : ''},
  {'code' : 'print morse(".... .- .-.. .-.. ---", 0)', 'expectedOutput' : 'HALLO'},

  {'code' : 'print enclosedareas("HALLO 9876543210 MEINS", 0, 0)', 'expectedOutput' : '2 5 0'},
  {'code' : 'print enclosedareas("HALLO 9876543210 MEINS", 0, 1)', 'expectedOutput' : '2 6 0'},
  {'code' : 'print enclosedareas("HALLO 9876543210 MEINS", 1, 0)', 'expectedOutput' : '5'},
  {'code' : 'print enclosedareas("HALLO 9876543210 MEINS", 1, 1)', 'expectedOutput' : '6'},

  {'code' : 'print bcd("1234567890", 1, 0)', 'expectedOutput' : '0001 0010 0011 0100 0101 0110 0111 1000 1001 0000'},
  {'code' : 'print bcd(1234567890, 1, 0)', 'expectedOutput' : '0001 0010 0011 0100 0101 0110 0111 1000 1001 0000'},
  {'code' : 'print bcd("0001 0010 0011 0100 0101 0110 0111 1000 1001 0000", 0, 0)', 'expectedOutput' : '1234567890'},


];