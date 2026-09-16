import 'dart:math';

import 'package:gc_wizard/tools/games/tridoku/logic/tridoku.dart';

enum TridokuFillType { USER_FILLED, CALCULATED }

class TridokuBoardValue {
  TridokuFillType type;
  int? value;

  TridokuBoardValue(this.value, this.type);
}

class TridokuBoard {
  late List<List<TridokuBoardValue?>> board;
  List<_TridokuSolution>? solutions;

  TridokuBoard({List<List<int>>? board}) {
    this.board =
        List<List<TridokuBoardValue?>>.generate(9,
                (index) => List<TridokuBoardValue?>.generate(columnCount(index), (index) => null));

    if (board != null) {
      for (int i = 0; i < min(board.length, this.board.length); i++) {
        for (int j = 0; j < min(board[i].length, this.board[i].length); j++) {
          if (board[i][j] > 0 && board[i][j] <= 9) {
            setValue(i, j, board[i][j], TridokuFillType.USER_FILLED);
          }
        }
      }
    }
  }

  void setValue(int i, int j, int? value, TridokuFillType type) {
    board[i][j] = TridokuBoardValue(value, type);
  }

  int? getValue(int i, int j) {
    return board[i][j]?.value;
  }

  TridokuFillType getFillType(int i, int j) {
    return (board[i][j] == null || board[i][j]!.type == TridokuFillType.CALCULATED)
        ? TridokuFillType.CALCULATED
        : TridokuFillType.USER_FILLED;
  }

  void solveTridoku(int maxSolutions) {
    var solutions = solve(_solveableBoard(), maxSolutions: maxSolutions);
    if (solutions == null) {
      this.solutions = null;
      return;
    }

    this.solutions = solutions.map((solution) => _TridokuSolution(solution)).toList();
  }

  List<List<int>> _solveableBoard() {
    return board.map((column) {
      return column
          .map((row) => row != null && row.type == TridokuFillType.USER_FILLED
              ? (row.value is int)
                  ? row.value as int
                  : 0
              : 0)
          .toList();
    }).toList();
  }

  void removeCalculated() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < columnCount(i); j++) {
        if (getFillType(i, j) == TridokuFillType.CALCULATED) setValue(i, j, null, TridokuFillType.CALCULATED);
      }
    }
    solutions = null;
  }

  void mergeSolution(int solutionIndex) {
    if (solutions == null || solutionIndex < 0 || solutionIndex >= solutions!.length) return;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < columnCount(i); j++) {
        if (getFillType(i, j) == TridokuFillType.USER_FILLED) continue;
        setValue(i, j, solutions![solutionIndex].getValue(i, j), TridokuFillType.CALCULATED);
      }
    }
  }
}

class _TridokuSolution {
  final List<List<int>> solution;

  _TridokuSolution(this.solution);

  int? getValue(int i, int j) {
    if (i < 0 || i >= solution.length || j < 0 || j >= solution[i].length) return null;
    return solution[i][j];
  }
}
