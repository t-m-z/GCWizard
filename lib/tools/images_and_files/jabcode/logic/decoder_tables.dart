part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

final Uint8List _jabDecodingTableUpper = Uint8List.fromList(const [
  32, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82,
  83, 84, 85, 86, 87, 88, 89, 90
]);

final Uint8List _jabDecodingTableLower = Uint8List.fromList(const [
  32, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
  112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122
]);

final Uint8List _jabDecodingTableNumeric = Uint8List.fromList(const [
  32, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 44, 46
]);

final Uint8List _jabDecodingTablePunct = Uint8List.fromList(const [
  33, 34, 36, 37, 38, 39, 40, 41, 44, 45, 46, 47, 58, 59, 63, 64
]);

final Uint8List _jabDecodingTableMixed = Uint8List.fromList(const [
  35, 42, 43, 60, 61, 62, 91, 92, 93, 94, 95, 96, 123, 124, 125, 126, 9, 10,
  13, 0, 0, 0, 0, 164, 167, 196, 214, 220, 223, 228, 246, 252
]);

final Uint8List _jabDecodingTableAlphanumeric = Uint8List.fromList(const [
  32, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 71, 72,
  73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85,
  86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
  109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122
]);

class _JabEncodeMode {
  static const int none = -1;
  static const int upper = 0;
  static const int lower = 1;
  static const int numeric = 2;
  static const int punct = 3;
  static const int mixed = 4;
  static const int alphanumeric = 5;
  static const int byte = 6;
  static const int eci = 7;
  static const int fnc1 = 8;
}

