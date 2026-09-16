import 'dart:math';

late List<List<int>> _board;
late  Map<Point<int>, Set<Point<int>>> _cellUnits;
int _MAX_SOLUTIONS = 1000;

const List<List<Point<int>>> _unitlist = [
    <Point<int>>[Point<int>(0,0), Point<int>(1,0), Point<int>(2,0), Point<int>(3,0), Point<int>(4,0), Point<int>(5,0), Point<int>(6,0), Point<int>(7,0), Point<int>(8,0)], // outer sides
    <Point<int>>[Point<int>(8,0), Point<int>(8,2), Point<int>(8,4), Point<int>(8,6), Point<int>(8,8), Point<int>(8,10), Point<int>(8,12), Point<int>(8,14), Point<int>(8,16)],
    <Point<int>>[Point<int>(0,0), Point<int>(1,2), Point<int>(2,4), Point<int>(3,6), Point<int>(4,8), Point<int>(5,10), Point<int>(6,12), Point<int>(7,14), Point<int>(8,16)],
    <Point<int>>[Point<int>(4,0), Point<int>(4,1), Point<int>(4,2), Point<int>(4,3), Point<int>(4,4), Point<int>(4,5), Point<int>(4,6), Point<int>(4,7), Point<int>(4,8)], // inner triangle
    <Point<int>>[Point<int>(4,0), Point<int>(5,1), Point<int>(5,2), Point<int>(6,3), Point<int>(6,4), Point<int>(7,5), Point<int>(7,6), Point<int>(8,7), Point<int>(8,8)],
    <Point<int>>[Point<int>(4,8), Point<int>(5,8), Point<int>(5,9), Point<int>(6,8), Point<int>(6,9), Point<int>(7,8), Point<int>(7,9), Point<int>(8,8), Point<int>(8,9)],
    <Point<int>>[Point<int>(0,0), Point<int>(1,0), Point<int>(1,1), Point<int>(1,2), Point<int>(2,0), Point<int>(2,1), Point<int>(2,2), Point<int>(2,3), Point<int>(2,4)], // 9 Nonets
    <Point<int>>[Point<int>(3,0), Point<int>(4,0), Point<int>(4,1), Point<int>(4,2), Point<int>(5,0), Point<int>(5,1), Point<int>(5,2), Point<int>(5,3), Point<int>(5,4)],
    <Point<int>>[Point<int>(6,0), Point<int>(7,0), Point<int>(7,1), Point<int>(7,2), Point<int>(8,0), Point<int>(8,1), Point<int>(8,2), Point<int>(8,3), Point<int>(8,4)],
    <Point<int>>[Point<int>(3,6), Point<int>(4,6), Point<int>(4,7), Point<int>(4,8), Point<int>(5,6), Point<int>(5,7), Point<int>(5,8), Point<int>(5,9), Point<int>(5,10)],
    <Point<int>>[Point<int>(6,12), Point<int>(7,12), Point<int>(7,13), Point<int>(7,14), Point<int>(8,12), Point<int>(8,13), Point<int>(8,14), Point<int>(8,15), Point<int>(8,16)],
    <Point<int>>[Point<int>(6,6), Point<int>(7,6), Point<int>(7,7), Point<int>(7,8), Point<int>(8,6), Point<int>(8,7), Point<int>(8,8), Point<int>(8,9), Point<int>(8,10)],
    <Point<int>>[Point<int>(3,1), Point<int>(3,2), Point<int>(3,3), Point<int>(3,4), Point<int>(3,5), Point<int>(4,3), Point<int>(4,4), Point<int>(4,5), Point<int>(5,5)],
    <Point<int>>[Point<int>(6,1), Point<int>(6,2), Point<int>(6,3), Point<int>(6,4), Point<int>(6,5), Point<int>(7,3), Point<int>(7,4), Point<int>(7,5), Point<int>(8,5)],
    <Point<int>>[Point<int>(6,7), Point<int>(6,8), Point<int>(6,9), Point<int>(6,10), Point<int>(6,11), Point<int>(7,9), Point<int>(7,10), Point<int>(7,11), Point<int>(8,11)],
  ];

int columnCount(int row) => (row * 2) + 1;

Set<Point<int>> _cellVertices(int row, int column) {
  final k = column ~/ 2;
  if (column.isEven) {
    return {Point<int>(row, k), Point<int>(row + 1, k), Point<int>(row + 1, k + 1)};
  } else {
    return {Point<int>(row, k), Point<int>(row, k + 1), Point<int>(row + 1, k + 1)};
  }
}

Map<Point<int>, Set<Point<int>>> _buildCellUnitMap() {
  final cells = <Point<int>>[
    for (int r = 0; r < 9; r++)
      for (int c = 0; c < columnCount(r); c++)
        Point<int>(r, c)
  ];
  final vertices = {for (final p in cells) p: _cellVertices(p.x, p.y)};
  final result = {for (final p in cells) p: <Point<int>>{}};

  for (int i = 0; i < cells.length; i++) {
    for (int j = i + 1; j < cells.length; j++) {
      final a = cells[i];
      final b = cells[j];
      if (vertices[a]!.intersection(vertices[b]!).isNotEmpty) {
        result[a]!.add(b);
        result[b]!.add(a);
      }
    }
  }

  for (int row = 0; row < 9; row++) {
    for (int column = 0; column < columnCount(row); column++) {
      final point = Point<int>(row, column);
      for (final unit in _unitlist) {
        if (unit.contains(point)) {
          var list = List<Point<int>>.from(unit);
          list.remove(point);
          result[point]!.addAll(list);
        }
      }
    }
  }
  return result;
}

List<int> _validNumbers(int row, int column) {
  final numbers = List<int>.generate(9, (i) => i + 1);

  for (final p in _cellUnits[Point<int>(row, column)]!) {
    numbers.remove(_board[p.x][p.y]);
  }
  return numbers;
}

List<List<List<int>>>? solve(List<List<int>> grid, {int? maxSolutions}) {
  if (maxSolutions != null && maxSolutions > 0) _MAX_SOLUTIONS = maxSolutions;

  _board = grid;
  _cellUnits = _buildCellUnitMap();

  final List<List<List<int>>> results = [];
  _searchAll(grid, results);

  return results.isEmpty ? null : results;
}

void _searchAll(List<List<int>> _board, List<List<List<int>>> results) {
  if (results.length >= _MAX_SOLUTIONS) return;

  Point<int> bestCell = Point<int>(-1,-1);
  List<int> bestList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  for (int r = 0; r < 9; r++) {
    for (int c = 0; c < columnCount(r); c++) {
      if (_board[r][c] == 0) {
        var validNumbers = _validNumbers(r, c);
        if (validNumbers.isEmpty) return; // Dead end
        if (validNumbers.length < bestList.length) {
          bestList = validNumbers;
          bestCell = Point<int>(r, c);
        }
      }
    }
  }

  if (bestCell == Point<int>(-1,-1)) {
    results.add(_board.map(List<int>.from).toList());
    return;
  }

  for (int n in bestList) {
    _board[bestCell.x][bestCell.y] = n;
    _searchAll(_board, results);
    if (results.length >= _MAX_SOLUTIONS) return;
    _board[bestCell.x][bestCell.y] = 0;
  }
}