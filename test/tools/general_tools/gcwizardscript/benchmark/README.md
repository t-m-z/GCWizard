# GC Wizard Script – Performance-Messung

Branches (Basis: `tmz-master-3.8.0` @ `59d9c1d67`):

- `perf/gcwscript-quick-wins-master-3.8.0`: lokale Optimierungen

Die Messwerte in der Tabelle stammen vom ersten Stand auf `tmz-master`. Eine
Kontrollmessung auf `tmz-master-3.8.0` ergab dasselbe Bild (z. B. IF-Schleife
1506 → 95 ms, verschachtelte FOR 1313 → 92 ms).

## Ergebnisse

Laufzeit eines kompletten Skriptlaufs (`GCWizardScriptInterpretScript`), Median.

| Programm | Was es testet | vorher | quick wins | Faktor |
|---|---|---:|---:|---:|
| `for_nested_arith` | 200×200 verschachtelte FOR, Arithmetik | 1092 ms | 91 ms | 12× |
| `if_elseif_else` | 20.000× IF/ELSEIF/ELSE/ENDIF | 1479 ms | 117 ms | 13× |
| `if_in_long_script` | wie oben, aber 400 Zeilen Code dahinter | 141.316 ms | 88 ms | 1606× |
| `while_strings` | WHILE/WEND, String-Verkettung, CHAR/LEN/MID | 159 ms | 15 ms | 11× |
| `repeat_gosub` | REPEAT/UNTIL mit 10.000 GOSUB/RETURN | 386 ms | 21 ms | 18× |
| `functions_math` | 20.000× ABS(SIN()), SQRT, MOD | 1158 ms | 93 ms | 12× |
| `list_sieve` | Primzahlsieb mit DIM/LISTADD/LISTGET/LISTINSERT/LISTREMOVE | 847 ms | 276 ms | 3,1× |
| `print_heavy` | 5.000× PRINT | 123 ms | 6 ms | 20× |

`list_sieve` wird von den Listenoperationen selbst dominiert (Einfügen und
Entfernen verschieben jedes Mal die ganze Dart-Liste), nicht vom Interpreter.

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

**Achtung beim Ergänzen neuer Operatoren:** Es gibt jetzt zwei Trennerprüfungen,
`isDelimiter()` (String) und `_isDelimiterCode()` (Code-Unit, im Tokenizer
genutzt). Ein neuer Operator muss in **beide**. Fehlt er in
`_isDelimiterCode()`, wird z. B. `a@b` still als ein Variablenname gelesen.

## Geänderte Dateien

Alle Pfade relativ zu `lib/tools/general_tools/gcwizardscript/logic/` bzw. `test/tools/general_tools/gcwizardscript/`.

| Datei | +/− | Änderung |
|---|---:|---|
| `gcwizard_script.dart` | +147 / −69 | `isTokenAFunction` mit Set-Lookup, neues `_keywordAt` für alle Blocksuchen, Tokenizer über Code-Units/`substring`, `_isDelimiterCode` (inkl. `@`), Caches in `lookUpToken` und `getValueOfVariable`, `putBack` ohne Schleife, STDOUT-Zugriffe über `writeSTDOUT` |
| `gcwizard_script_classes.dart` | +13 / −1 | `ScriptState.STDOUT` als `StringBuffer` mit Getter/Setter und `writeSTDOUT()` |
| `gcwizard_script_test_datatypes.dart` | +29 / −50 | Typprüfungen als `is`-Tests, `_isALetterCode` / `_isADigitCode` |
| `benchmark/gcwizard_script_benchmark_test.dart` | neu | Benchmark-Programme, lauffähig mit `flutter test` |
| `benchmark/README.md` | neu | diese Datei |

Nicht geändert: Widget, Funktionsteile (`gcwizard_script_functions_*.dart`),
Konstanten, Fehlerbehandlung, Hilfetexte, bestehende Tests.

## Korrektheit

Alle 335 Testfälle aus `test/tools/general_tools/gcwizardscript/logic` (inkl.
der Zeilennummer-Tests) plus 4 Zusatzfälle für den Operator `@`
(ohne Koordinaten, Krypto, Hashes, Geocaching, Basen, Wegpunkte, Dateien,
Grafik, Datum) liefern exakt dieselbe Ausgabe und Fehlermeldung wie vorher
(Golden-Vergleich). 4 Fälle (`MOD(11, )`, `SGN( )`, `GGT(11, )`, `KGV(11, )`)
schlagen schon auf `tmz-master-3.8.0` fehl und sind unverändert.

Einzige bewusste Verhaltensänderung: Der String `"null"` (in beliebiger
Schreibweise) wurde von den alten Typprüfungen wie ein fehlender Wert
behandelt, jetzt ist er ein normaler String.

## Nebenbefund: JIT-Fehler auf der Basis

Auf `tmz-master-3.8.0` rechnet der Interpreter im **JIT-Modus** (so läuft
Flutter im Debug-Build) nach einer bestimmten Abfolge falsch. Wird zuerst
eine Schleife mit Ganzzahl-Additionen ausgeführt, danach Kommazahlen, dann
gemischt, ergibt `a = "ab"`, `b = "cd"`, `print a + b` nur `ab`. Ebenso ergibt
`input x`, `input y`, `print x + y` mit den Eingaben 5 und 3 im Ablauf der
App (Isolate, INPUT-Fortsetzung) `5.0` statt `8.0`.

Schon das Auswerten von `op == '+'` vor dem `switch` in
`evaluateExpressionAddSubOperators` lässt den Fehler verschwinden. Das spricht
für ein Deoptimierungsproblem der Dart-VM, nicht für einen Logikfehler.
Im AOT-Modus (Release-Build) tritt er nicht auf. Beide Performance-Branches
liefern in allen diesen Abläufen das richtige Ergebnis, auch im JIT-Modus.
Beobachtet mit Dart 3.13.7; mit anderen SDK-Versionen nicht geprüft.

## Messbedingungen

- Dart SDK 3.13.7, Linux x64, 2 Kerne
- Interpreter AOT-kompiliert (`dart compile exe`), wie in der App
- Median aus 7 Läufen, alle Stände abwechselnd gemessen (vorher: 3 Läufe;
  `if_in_long_script` vorher: 3 Läufe in einem separaten Durchgang)
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
