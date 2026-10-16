part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/unluac/unluac.dart';

enum _NumberMode {
  modeNumber, // Lua 5.0 - 5.2: numbers can represent integers or floats
  modeFloat, // Lua 5.3 floats
  modeInteger, // Lua 5.3 integers
}
