part of 'gcwizard_scipt_test.dart';

// ignore: unused_element

List<Map<String, Object?>> _inputsListsToExpected = [
  // DIM
  // LISTADD
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  print l1''',
    'expectedOutput': '[A, 1, hallo]'
  },
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  dim l2
  listadd(l2, 15)
  listadd(l2, "ende")
  listadd(l1, l2)
  print l1''',
    'expectedOutput': '[A, 1, hallo, [15, ende]]'
  },
  // LISTCLEAR, LISTISEMPTY, LISTISNOTEMPTY
  {
    'code': '''
  dim l1
  print listisempty(l1)
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  print listisempty(l1);listisnotempty(l1)
  listclear(l1)
  print l1''',
    'expectedOutput': '1\n0 1\n[]'
  },
  // LISTADDALL
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  dim l2
  listadd(l2, 15)
  listadd(l2, "ende")
  listaddall(l1, l2)
  print l1
 ''',
    'expectedOutput': '[A, 1, hallo, 15, ende]'
  },
  // LISTINSERT
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listinsert(l1,2, "insert")
  print l1''',
    'expectedOutput': '[A, 1, insert, hallo]'
  },
  // LISTREMOVE(list, object) – löscht das erste Vorkommnis von Objekt aus der Liste
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listinsert(l1,2, "insert")
  listremove(l1, 1)
  print l1''',
    'expectedOutput': '[A, insert, hallo]'
  },
  // LISTREMOVEAT(list, index) – löscht aus einer Liste an der Stelle index ein Objekt
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listinsert(l1,2, "insert")
  listremoveat(l1, 2)
  print l1''',
    'expectedOutput': '[A, 1, hallo]'
  },
  // LISTREMOVELAST(list) – löscht das letzte Element in einer Liste
  {
    'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listinsert(l1,2, "insert")
  listremovelast(l1)
  print l1''',
    'expectedOutput': '[A, 1, insert]'
  },
  // LISTSHUFFLE(list) – mischt eine Liste durcheinander
  // nicht testbar, da Zufallsgenerator im Spiel
  //{'code': '''dim l1
  //listadd(l1, "A")
  //listadd(l1,1)
  //listadd(l1, "hallo")
  //listshuffle(l1)
  //print l1''', 'expectedOutput': ''},
  // LISTSORT(list, modus) – sortiert eine Liste auf- oder absteigend
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, "B")
  listadd(l1, "C")
  listsort(l1, 1)
  print l1''', 'expectedOutput': '[A, B, C]'},
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, "B")
  listadd(l1, "C")
  listsort(l1, 0)
  print l1''', 'expectedOutput': '[C, B, A]'},
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, "b")
  listadd(l1, "C")
  listadd(l1, "d")
  listsort(l1, 1)
  print l1''', 'expectedOutput': '[A, C, b, d]'},
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, "b")
  listadd(l1, "C")
  listadd(l1, "d")
  listsort(l1, 0)
  print l1''', 'expectedOutput': '[d, C, b, A]'},
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listsort(l1, 0)
  print l1''', 'expectedOutput': '[hallo, 1, A]'},
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1,1)
  listadd(l1, "hallo")
  listsort(l1, 1)
  print l1''', 'expectedOutput': '[1, A, hallo]'},
  // LISTGET(list, index) – holt das Element einer Liste an der Stelle index
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, 1)
  listadd(l1, "hallo")
  listadd(l1, 34)
  a = listget(l1, 3)
  b = listget(l1, 2)
  print a; b''', 'expectedOutput': '34 hallo'},
  // LISTLENGTH(liste) – berechnet die Länge der Liste – die Anzahl der gespeicherten Objekte
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, 1)
  listadd(l1, "hallo")
  listadd(l1, 34)
  print listlength(l1)''', 'expectedOutput': '4'},
  // LISTTOSTRING(liste) – gibt den Inhalt einer Liste als eine Zeichenkette aus
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, 1)
  listadd(l1, "hallo")
  listadd(l1, 34)
  print listtostring(l1)''', 'expectedOutput': '[A, 1, hallo, 34]'},
  // LISTFROM(zeichenkette, object) – erstellt eine neue Liste und fügt das object ein.
  {'code': '''
  listfrom("l", 34)
  print listlength(l)
  print l''', 'expectedOutput': '1\n[34]'},
  // LISTEQUALS(list1, list2) – prüft zwei Listen auf Gleichheit
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, 1)
  listadd(l1, "hallo")
  dim l2
  listadd(l2, "A")
  listadd(l2, 1)
  listadd(l2, "hallo")
  print listequals(l1, l2)
  listremovelast(l2)
  print listequals(l1, l2)''', 'expectedOutput': '1\n0'},
  // LISTSUBLIST(zeichenkette, list, start, end) – erstellt eine neue Liste im Bereich start – end
  {'code': '''
  dim l1
  listadd(l1, "A")
  listadd(l1, 1)
  listadd(l1, "hallo")
  listadd(l1, "42")
  dim l2
  listadd(l2, 15)
  listadd(l2, "ende")
  listadd(l1, l2)
  listsublist("sl", l1, 2, 4)
  print l1
  listsublist("sl1", l1, 2, 5)
  print sl1
  listsublist("sl2", l1, 1,3)
  print sl2''', 'expectedOutput': '[A, 1, hallo, 42, [15, ende]]\n[hallo, 42, [15, ende]]\n[1, hallo]'},
];
