# GC Wizard Script – Performance-Messung

Branch: `perf/gcwscript-quick-wins` (Basis: `tmz-master` @ `88006fcdc`)

## Ergebnisse

Laufzeit eines kompletten Skriptlaufs (`GCWizardScriptInterpretScript`), Median.

| Programm | Was es testet | vorher | quick wins | Faktor |
|---|---|---:|---:|---:|
| `for_nested_arith` | 200×200 verschachtelte FOR, Arithmetik | 1092 ms | 91 ms | 12× |
| `if_elseif_else` | 20.000× IF/ELSEIF/ELSE/ENDIF | 1479 ms | 117 ms | 13× |
| `if_in_long_script` | wie oben, aber 400 Zeilen Code dahinter | 141.316 ms | 88 ms | 1600× |
| `while_strings` | WHILE/WEND, String-Verkettung, CHAR/LEN/MID | 159 ms | 15 ms | 11× |
| `repeat_gosub` | REPEAT/UNTIL mit 10.000 GOSUB/RETURN | 386 ms | 21 ms | 19× |
| `functions_math` | 20.000× ABS(SIN()), SQRT, MOD | 1158 ms | 93 ms | 12× |
| `list_sieve` | Primzahlsieb mit DIM/LISTADD/LISTGET/LISTINSERT/LISTREMOVE | 847 ms | 276 ms | 3× |
| `print_heavy` | 5.000× PRINT | 123 ms | 6 ms | 21× |

Ausgaben aller Programme sind vorher und nachher identisch.

## Was geändert wurde

- **Typprüfungen** (`_isANumber`, `_isAString`, …): `is`-Tests statt
  `value.toString().toLowerCase() == 'null'`. Das alte Verfahren erzeugte bei
  jeder Rechenoperation mehrere Strings und serialisierte Listen komplett.
- **Funktionserkennung** (`isTokenAFunction`): ein `Set`-Lookup statt 16×
  `substring` + `toUpperCase` + `List.contains` vor jedem Token.
- **Blocksuche** (IF/ELSE/ENDIF, FOR/NEXT, WHILE/WEND, REPEAT/UNTIL,
  SWITCH/CASE): Schlüsselwortvergleich direkt im Skript statt
  `script.substring(pc).toUpperCase()` pro Zeichen. Das war O(n²) pro Suche
  und erklärt die 141 s beim langen Skript.
- **Tokenizer**: `substring` statt zeichenweisem Aufbau; Trenner, Buchstaben,
  Ziffern über Code-Units.
- Caches für Schlüsselwort- und Konstanten-Lookup, `StringBuffer` für STDOUT,
  `putBack` ohne Schleife.

## Korrektheit

Alle 330 Testfälle aus `test/tools/general_tools/gcwizardscript/logic`
(ohne Koordinaten, Krypto, Hashes, Geocaching, Basen, Wegpunkte, Dateien,
Grafik, Datum) liefern exakt dieselbe Ausgabe und Fehlermeldung wie vorher
(Golden-Vergleich). 4 Fälle (`MOD(11, )`, `SGN( )`, `GGT(11, )`, `KGV(11, )`)
schlagen schon auf `tmz-master` fehl und sind unverändert.

Einzige bewusste Verhaltensänderung: Der String `"null"` (in beliebiger
Schreibweise) wurde von den alten Typprüfungen wie ein fehlender Wert
behandelt, jetzt ist er ein normaler String.

## Messbedingungen

- Dart SDK 3.13.7, Linux x64, 2 Kerne
- Interpreter AOT-kompiliert (`dart compile exe`), wie in der App
- Median aus 7 Läufen (vorher: 3 Läufe; `if_in_long_script` vorher: 3 Läufe
  in einem separaten Durchgang)
- Die Maschine streut um ±20 %; Faktoren sind belastbar, Einzelwerte nicht.

Da Flutter-SDK und pub.dev in der Messumgebung nicht erreichbar waren, lief
der Interpreter in einem Harness ohne Flutter: Kerndateien unverändert, die
Funktionsteile mit schweren Abhängigkeiten (Koordinaten, Krypto usw.)
weggelassen. Die Funktionstabelle des Tokenizers blieb vollständig.

## Selbst messen

```
flutter test test/tools/general_tools/gcwizardscript/benchmark/gcwizard_script_benchmark_test.dart
```

Das läuft im JIT-Modus; die Zahlen sind untereinander vergleichbar, aber
nicht direkt mit der Tabelle oben.

## Nebenbefund (nicht behoben)

`_GCWList.remove(int index)` ruft `_contents.remove(index)` auf und entfernt
damit das erste Element mit dem **Wert** `index` statt des Elements **an**
Position `index` (richtig wäre `removeAt`). Deshalb findet `list_sieve` 450
statt 430 Primzahlen bis 3000.
