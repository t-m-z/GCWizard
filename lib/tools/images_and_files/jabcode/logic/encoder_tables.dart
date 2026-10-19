part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

final _jabDefaultPalette = Uint8List.fromList(const [
  0, 0, 0, // 0: black
  0, 0, 255, // 1: blue
  0, 255, 0, // 2: green
  0, 255, 255, // 3: cyan
  255, 0, 0, // 4: red
  255, 0, 255, // 5: magenta
  255, 255, 0, // 6: yellow
  255, 255, 255, // 7: white
]);

final List<Uint8List> _masterPalettePlacementIndex = [
  Uint8List.fromList(const [0, 3, 5, 6, 1, 2, 4, 7]),
  Uint8List.fromList(const [0, 6, 5, 3, 1, 2, 4, 7]),
  Uint8List.fromList(const [6, 0, 5, 3, 1, 2, 4, 7]),
  Uint8List.fromList(const [3, 0, 5, 6, 1, 2, 4, 7]),
];

const List<int> _slavePalettePlacementIndex = [3, 6, 5, 0, 1, 2, 4, 7];

const int _fp0CoreColor = 0;
const int _fp1CoreColor = 0;
const int _fp2CoreColor = 6;
const int _fp3CoreColor = 3;

const int _ap0CoreColor = 3;
const int _ap1CoreColor = 3;
const int _ap2CoreColor = 3;
const int _ap3CoreColor = 3;
const int _apxCoreColor = 6;

const List<int> _fp0CoreColorIndex = [0, 0, _fp0CoreColor, 0, 0, 0, 0, 0];
const List<int> _fp1CoreColorIndex = [0, 0, _fp1CoreColor, 0, 0, 0, 0, 0];
const List<int> _fp2CoreColorIndex = [0, 2, _fp2CoreColor, 14, 30, 60, 124, 252];
const List<int> _fp3CoreColorIndex = [0, 3, _fp3CoreColor, 3, 7, 15, 15, 31];

const List<int> _apnCoreColorIndex = [0, 3, _ap0CoreColor, 3, 7, 15, 15, 31];
const List<int> _apxCoreColorIndex = [0, 2, _apxCoreColor, 14, 30, 60, 124, 252];

const int _fp0 = 0, _fp1 = 1, _fp2 = 2, _fp3 = 3;
const int _ap0 = 0, _ap1 = 1, _ap2 = 2, _ap3 = 3, _apx = 4;

class _JabCode {
  int dimension = 0;
  _JabVector2d codeSize = _JabVector2d(0, 0);
  int minX = 0;
  int minY = 0;
  int rows = 0;
  int cols = 0;
  List<int> rowHeight = const [];
  List<int> colWidth = const [];
}

const List<List<int>> _jabSymbolPosRaw = [
  [0, 0],
  [0, -1], [0, 1], [-1, 0], [1, 0], [0, -2], [-1, -1], [1, -1], [0, 2], [-1, 1], [1, 1],
  [-2, 0], [2, 0], [0, -3], [-1, -2], [1, -2], [-2, -1], [2, -1], [0, 3], [-1, 2], [1, 2],
  [-2, 1], [2, 1], [-3, 0], [3, 0], [0, -4], [-1, -3], [1, -3], [-2, -2], [2, -2], [-3, -1],
  [3, -1], [0, 4], [-1, 3], [1, 3], [-2, 2], [2, 2], [-3, 1], [3, 1], [-4, 0], [4, 0],
  [0, -5], [-1, -4], [1, -4], [-2, -3], [2, -3], [-3, -2], [3, -2], [-4, -1], [4, -1], [0, 5],
  [-1, 4], [1, 4], [-2, 3], [2, 3], [-3, 2], [3, 2], [-4, 1], [4, 1], [-5, 0], [5, 0],
];
final List<_JabVector2d> _jabSymbolPos =
    _jabSymbolPosRaw.map((p) => _JabVector2d(p[0], p[1])).toList();

const List<List<int>> _ncColorEncodeTable = [
  [0, 0], [0, 3], [0, 6], [3, 0], [3, 3], [3, 6], [6, 0], [6, 3],
];

final List<Uint8List> _jabEncodingTable = [
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 16, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 17, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -19, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [0, 0, 0, -1, -1, 0]), Uint8List.fromList(const [-1, -1, -1, 0, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 0, -1]), Uint8List.fromList(const [-1, -1, -1, 2, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 3, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 4, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 5, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, 6, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 7, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 2, -1]), Uint8List.fromList(const [-1, -1, 11, 8, -20, -1]),
  Uint8List.fromList(const [-1, -1, -1, 9, -1, -1]), Uint8List.fromList(const [-1, -1, 12, 10, -21, -1]), Uint8List.fromList(const [-1, -1, -1, 11, -1, -1]), Uint8List.fromList(const [-1, -1, 1, -1, -1, 1]), Uint8List.fromList(const [-1, -1, 2, -1, -1, 2]),
  Uint8List.fromList(const [-1, -1, 3, -1, -1, 3]), Uint8List.fromList(const [-1, -1, 4, -1, -1, 4]), Uint8List.fromList(const [-1, -1, 5, -1, -1, 5]), Uint8List.fromList(const [-1, -1, 6, -1, -1, 6]), Uint8List.fromList(const [-1, -1, 7, -1, -1, 7]),
  Uint8List.fromList(const [-1, -1, 8, -1, -1, 8]), Uint8List.fromList(const [-1, -1, 9, -1, -1, 9]), Uint8List.fromList(const [-1, -1, 10, -1, -1, 10]), Uint8List.fromList(const [-1, -1, -1, 12, -22, -1]), Uint8List.fromList(const [-1, -1, -1, 13, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 3, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 4, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 5, -1]), Uint8List.fromList(const [-1, -1, -1, 14, -1, -1]), Uint8List.fromList(const [-1, -1, -1, 15, -1, -1]),
  Uint8List.fromList(const [1, -1, -1, -1, -1, 11]), Uint8List.fromList(const [2, -1, -1, -1, -1, 12]), Uint8List.fromList(const [3, -1, -1, -1, -1, 13]), Uint8List.fromList(const [4, -1, -1, -1, -1, 14]), Uint8List.fromList(const [5, -1, -1, -1, -1, 15]),
  Uint8List.fromList(const [6, -1, -1, -1, -1, 16]), Uint8List.fromList(const [7, -1, -1, -1, -1, 17]), Uint8List.fromList(const [8, -1, -1, -1, -1, 18]), Uint8List.fromList(const [9, -1, -1, -1, -1, 19]), Uint8List.fromList(const [10, -1, -1, -1, -1, 20]),
  Uint8List.fromList(const [11, -1, -1, -1, -1, 21]), Uint8List.fromList(const [12, -1, -1, -1, -1, 22]), Uint8List.fromList(const [13, -1, -1, -1, -1, 23]), Uint8List.fromList(const [14, -1, -1, -1, -1, 24]), Uint8List.fromList(const [15, -1, -1, -1, -1, 25]),
  Uint8List.fromList(const [16, -1, -1, -1, -1, 26]), Uint8List.fromList(const [17, -1, -1, -1, -1, 27]), Uint8List.fromList(const [18, -1, -1, -1, -1, 28]), Uint8List.fromList(const [19, -1, -1, -1, -1, 29]), Uint8List.fromList(const [20, -1, -1, -1, -1, 30]),
  Uint8List.fromList(const [21, -1, -1, -1, -1, 31]), Uint8List.fromList(const [22, -1, -1, -1, -1, 32]), Uint8List.fromList(const [23, -1, -1, -1, -1, 33]), Uint8List.fromList(const [24, -1, -1, -1, -1, 34]), Uint8List.fromList(const [25, -1, -1, -1, -1, 35]),
  Uint8List.fromList(const [26, -1, -1, -1, -1, 36]), Uint8List.fromList(const [-1, -1, -1, -1, 6, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 7, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 8, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 9, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 10, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 11, -1]), Uint8List.fromList(const [-1, 1, -1, -1, -1, 37]), Uint8List.fromList(const [-1, 2, -1, -1, -1, 38]), Uint8List.fromList(const [-1, 3, -1, -1, -1, 39]),
  Uint8List.fromList(const [-1, 4, -1, -1, -1, 40]), Uint8List.fromList(const [-1, 5, -1, -1, -1, 41]), Uint8List.fromList(const [-1, 6, -1, -1, -1, 42]), Uint8List.fromList(const [-1, 7, -1, -1, -1, 43]), Uint8List.fromList(const [-1, 8, -1, -1, -1, 44]),
  Uint8List.fromList(const [-1, 9, -1, -1, -1, 45]), Uint8List.fromList(const [-1, 10, -1, -1, -1, 46]), Uint8List.fromList(const [-1, 11, -1, -1, -1, 47]), Uint8List.fromList(const [-1, 12, -1, -1, -1, 48]), Uint8List.fromList(const [-1, 13, -1, -1, -1, 49]),
  Uint8List.fromList(const [-1, 14, -1, -1, -1, 50]), Uint8List.fromList(const [-1, 15, -1, -1, -1, 51]), Uint8List.fromList(const [-1, 16, -1, -1, -1, 52]), Uint8List.fromList(const [-1, 17, -1, -1, -1, 53]), Uint8List.fromList(const [-1, 18, -1, -1, -1, 54]),
  Uint8List.fromList(const [-1, 19, -1, -1, -1, 55]), Uint8List.fromList(const [-1, 20, -1, -1, -1, 56]), Uint8List.fromList(const [-1, 21, -1, -1, -1, 57]), Uint8List.fromList(const [-1, 22, -1, -1, -1, 58]), Uint8List.fromList(const [-1, 23, -1, -1, -1, 59]),
  Uint8List.fromList(const [-1, 24, -1, -1, -1, 60]), Uint8List.fromList(const [-1, 25, -1, -1, -1, 61]), Uint8List.fromList(const [-1, 26, -1, -1, -1, 62]), Uint8List.fromList(const [-1, -1, -1, -1, 12, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 13, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 14, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 15, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 23, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 24, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 25, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 26, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, 27, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 28, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 29, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 30, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, 31, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]), Uint8List.fromList(const [-1, -1, -1, -1, -1, -1]),
  Uint8List.fromList(const [-1, -1, -1, -1, -1, -1])
];

const List<List<int>> _latchShiftTo = [
  [0,5,5,_encMax,_encMax,5,_encMax,_encMax,_encMax,_encMax,5,7,_encMax,11],
  [7,0,5,_encMax,_encMax,5,_encMax,5,_encMax,_encMax,5,7,_encMax,11],
  [4,6,0,_encMax,_encMax,9,_encMax,6,_encMax,_encMax,4,6,_encMax,10],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,_encMax,_encMax,0,_encMax],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,_encMax,_encMax,0,_encMax],
  [8,13,13,_encMax,_encMax,0,_encMax,_encMax,_encMax,_encMax,8,8,_encMax,12],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,0,_encMax,_encMax,0,0],
  [0,5,5,_encMax,_encMax,5,_encMax,_encMax,_encMax,_encMax,5,7,_encMax,11],
  [7,0,5,_encMax,_encMax,5,_encMax,5,_encMax,_encMax,5,7,_encMax,11],
  [4,6,0,_encMax,_encMax,9,_encMax,6,_encMax,_encMax,4,6,_encMax,10],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,_encMax,_encMax,0,_encMax],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,_encMax,_encMax,0,_encMax],
  [8,13,13,_encMax,_encMax,0,_encMax,_encMax,_encMax,_encMax,8,8,_encMax,12],
  [_encMax,_encMax,_encMax,_encMax,_encMax,_encMax,0,0,0,0,_encMax,_encMax,0,0],
];

const List<int> _characterSize = [5, 5, 4, 4, 5, 6, 8];

const List<List<int>> _modeSwitch = [
  [-1,28,29,-1,-1,30,-1,-1,-1,-1,27,125,-1,124,126,-1],
  [126,-1,29,-1,-1,30,-1,28,-1,127,27,125,-1,124,-1,127],
  [14,63,-1,-1,-1,478,-1,62,-1,-1,13,61,-1,60,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
  [255,8188,8189,-1,-1,-1,-1,-1,-1,-1,254,253,-1,252,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
];


const List<List<int>> _ecclevel2wcwr = [
  [4, 9], [3, 8], [3, 7], [4, 9], [3, 6], [4, 7], [4, 6], [3, 4], [4, 5], [5, 6], [6, 7],
];

final List<Uint8List> _jabApPos = [
  Uint8List.fromList(const [4, 18, 0, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 22, 0, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 26, 0, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 30, 0, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 34, 0, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 17, 38, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 20, 42, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 23, 46, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 26, 50, 0, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 14, 32, 54, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 17, 39, 58, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 20, 46, 62, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 23, 44, 66, 0, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 26, 37, 51, 70, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 14, 36, 58, 74, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 17, 39, 56, 78, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 20, 42, 63, 82, 0, 0, 0, 0]),
  Uint8List.fromList(const [4, 23, 38, 54, 70, 86, 0, 0, 0]),
  Uint8List.fromList(const [4, 26, 38, 56, 77, 90, 0, 0, 0]),
  Uint8List.fromList(const [4, 14, 33, 53, 72, 94, 0, 0, 0]),
  Uint8List.fromList(const [4, 17, 38, 59, 79, 98, 0, 0, 0]),
  Uint8List.fromList(const [4, 20, 36, 53, 70, 86, 102, 0, 0]),
  Uint8List.fromList(const [4, 23, 36, 55, 74, 93, 106, 0, 0]),
  Uint8List.fromList(const [4, 26, 36, 58, 79, 100, 110, 0, 0]),
  Uint8List.fromList(const [4, 14, 36, 58, 80, 92, 114, 0, 0]),
  Uint8List.fromList(const [4, 17, 34, 52, 70, 88, 99, 118, 0]),
  Uint8List.fromList(const [4, 20, 37, 54, 72, 89, 106, 122, 0]),
  Uint8List.fromList(const [4, 23, 38, 56, 74, 92, 113, 126, 0]),
  Uint8List.fromList(const [4, 26, 36, 58, 78, 98, 120, 130, 0]),
  Uint8List.fromList(const [4, 14, 32, 49, 67, 84, 102, 112, 134]),
  Uint8List.fromList(const [4, 17, 35, 53, 71, 89, 107, 119, 138]),
  Uint8List.fromList(const [4, 20, 38, 55, 73, 91, 108, 126, 142]),
];

final Uint8List _jabApNum = Uint8List.fromList(const [
  2, 2, 2, 2, 2,
  3, 3, 3, 3,
  4, 4, 4, 4,
  5, 5, 5, 5,
  6, 6, 6, 6,
  7, 7, 7, 7,
  8, 8, 8, 8,
  9, 9, 9,
]);

const int _masterMetadataX = 6;
const int _masterMetadataY = 1;

final List<_JabVector2d> _slavePalettePosition = [
  _JabVector2d(4, 5), _JabVector2d(4, 6), _JabVector2d(4, 7), _JabVector2d(4, 8),
  _JabVector2d(4, 9), _JabVector2d(4, 10), _JabVector2d(4, 11), _JabVector2d(4, 12),
  _JabVector2d(5, 12), _JabVector2d(5, 11), _JabVector2d(5, 10), _JabVector2d(5, 9),
  _JabVector2d(5, 8), _JabVector2d(5, 7), _JabVector2d(5, 6), _JabVector2d(5, 5),
  _JabVector2d(6, 5), _JabVector2d(6, 6), _JabVector2d(6, 7), _JabVector2d(6, 8),
  _JabVector2d(6, 9), _JabVector2d(6, 10), _JabVector2d(6, 11), _JabVector2d(6, 12),
  _JabVector2d(7, 12), _JabVector2d(7, 11), _JabVector2d(7, 10), _JabVector2d(7, 9),
  _JabVector2d(7, 8), _JabVector2d(7, 7), _JabVector2d(7, 6), _JabVector2d(7, 5),
];
