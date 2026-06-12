part of 'package:gc_wizard/tools/general_tools/grid_generator/grid/widget/grid.dart';

enum _GridType { BOXES, INTERSECTIONS }

enum _GridEnumerationStart { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT }

enum _GridBoxEnumerationStartDirection { UP, DOWN, LEFT, RIGHT }

enum _GridBoxEnumerationBehaviour { ALIGNED, ALTERNATED, SPIRAL }

enum _GridPaintColor { BLACK, WHITE, RED, YELLOW, BLUE, GREEN, ERASER }

enum _GridMode {POINTS, LINES}

enum _TapMode { SINGLE, ROW, COLUMN, ALL }

final _GRID_COLORS = {
  _GridPaintColor.BLACK: {'color': Colors.black, 'fontColor': Colors.white},
  _GridPaintColor.WHITE: {'color': Colors.white, 'fontColor': Colors.black},
  _GridPaintColor.RED: {'color': Colors.red, 'fontColor': Colors.black},
  _GridPaintColor.YELLOW: {'color': Colors.yellow, 'fontColor': Colors.black},
  _GridPaintColor.BLUE: {'color': Colors.indigo, 'fontColor': Colors.white},
  _GridPaintColor.GREEN: {'color': Colors.green, 'fontColor': Colors.black},
  _GridPaintColor.ERASER: {'color': Color.fromARGB(0, 0, 0, 0)},
};

class _GridPoint {
  final Point<int> point;
  final _GridPaintColor color;
  bool isEndOfLine = false;

  _GridPoint({required this.point, required this.color});

  @override
  String toString() {
    return 'P: (${point.x}, ${point.y}; C: $color}';
  }
}

class _GridPainter extends StatefulWidget {
  final _GridType type;
  final int countRows;
  final int countColumns;
  final _GridMode mode;
  final _GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  _GridEnumerationStart boxEnumerationStart;
  _GridBoxEnumerationBehaviour boxEnumerationBehaviour;
  _GridBoxEnumerationStartDirection boxEnumerationStartDirection;

  _GridPainter({
    this.type = _GridType.BOXES,
    this.countRows = 10,
    this.countColumns = 10,
    this.mode = _GridMode.POINTS,
    this.tapColor = _GridPaintColor.BLACK,
    required this.boxEnumeration,
    required this.columnEnumeration,
    required this.rowEnumeration,
    this.boxEnumerationStart = _GridEnumerationStart.TOP_LEFT,
    this.boxEnumerationStartDirection = _GridBoxEnumerationStartDirection.RIGHT,
    this.boxEnumerationBehaviour = _GridBoxEnumerationBehaviour.ALIGNED,
  });

  @override
  _GridPainterState createState() => _GridPainterState();
}

class _GridPainterState extends State<_GridPainter> {
  List<String>? _boxEnumeration;
  List<String>? _originalBoxEnumeration;

  var _lastClickedX = -1;
  var _lastClickedY = -1;
  var _lastSetColor = _GridPaintColor.ERASER;

  var _doubleTapped = false;

  List<String>? _fillBoxEnumeration() {
    if (widget.boxEnumeration.isEmpty) return null;

    var helper = List<List<String?>>.generate(
        widget.countRows, (index) => List<String?>.generate(widget.countColumns, (index) => null));

    List<String> boxEnumeration;
    if (widget.boxEnumeration.length > widget.countColumns * widget.countRows) {
      boxEnumeration = widget.boxEnumeration.sublist(0, widget.countRows * widget.countColumns);
    } else {
      boxEnumeration = widget.boxEnumeration;
    }

    var i = widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
            widget.boxEnumerationStart == _GridEnumerationStart.TOP_RIGHT
        ? 0
        : (widget.countRows - 1);
    var j = widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
            widget.boxEnumerationStart == _GridEnumerationStart.BOTTOM_LEFT
        ? 0
        : (widget.countColumns - 1);

    var currentDirection = widget.boxEnumerationStartDirection;

    var idx = 0;
    while (idx < boxEnumeration.length) {
      helper[i][j] = widget.boxEnumeration[idx++];

      switch (currentDirection) {
        case _GridBoxEnumerationStartDirection.UP:
          if (i > 0 && helper[i - 1][j] == null) {
            i--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case _GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = widget.countRows - 1;
                break;
              case _GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == _GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = _GridBoxEnumerationStartDirection.DOWN;
                break;
              case _GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = _GridBoxEnumerationStartDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = _GridBoxEnumerationStartDirection.LEFT;
                }
                break;
            }
          }
          break;

        case _GridBoxEnumerationStartDirection.DOWN:
          if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
            i++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case _GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = 0;
                break;
              case _GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == _GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = _GridBoxEnumerationStartDirection.UP;
                break;
              case _GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = _GridBoxEnumerationStartDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = _GridBoxEnumerationStartDirection.LEFT;
                }
                break;
            }
          }
          break;

        case _GridBoxEnumerationStartDirection.LEFT:
          if (j > 0 && helper[i][j - 1] == null) {
            j--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case _GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }

                j = widget.countColumns - 1;
                break;
              case _GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == _GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = _GridBoxEnumerationStartDirection.RIGHT;
                break;
              case _GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = _GridBoxEnumerationStartDirection.DOWN;
                } else {
                  i--;
                  currentDirection = _GridBoxEnumerationStartDirection.UP;
                }

                break;
            }
          }
          break;

        case _GridBoxEnumerationStartDirection.RIGHT:
          if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
            j++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case _GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT) {
                  i++;
                } else {
                  i--;
                }

                j = 0;
                break;
              case _GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == _GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == _GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = _GridBoxEnumerationStartDirection.LEFT;
                break;
              case _GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = _GridBoxEnumerationStartDirection.DOWN;
                } else {
                  i--;
                  currentDirection = _GridBoxEnumerationStartDirection.UP;
                }

                break;
            }
          }
          break;
      }
    }

    var output = <String>[];
    for (int i = 0; i < widget.countRows; i++) {
      for (int j = 0; j < widget.countColumns; j++) {
        output.add(helper[i][j] ?? '');
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == _GridType.BOXES && _originalBoxEnumeration != widget.boxEnumeration) {
      _boxEnumeration = _fillBoxEnumeration();
      _originalBoxEnumeration = widget.boxEnumeration;
    }

    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: widget.countColumns / widget.countRows,
                child: CanvasTouchDetector(
                    gesturesToOverride: const [GestureType.onTapDown],
                    builder: (context) {
                      return CustomPaint(
                          painter: _CustomGridPainter(
                              context,
                              widget.type,
                              widget.countRows,
                              widget.countColumns,
                              widget.mode,
                              widget.tapColor,
                              _boxEnumeration ?? [],
                              widget.columnEnumeration,
                              widget.rowEnumeration,
                              _gridState, (int i, int j, int countRows, int countColumns, _TapMode mode) {
                        setState(() {
                          if (_gridState.isNotEmpty) {
                            if (_lastClickedX == j
                                && _lastClickedY == i
                                && _lastSetColor == widget.tapColor) {
                              _doubleTapped = (_lastSetColor != _GridPaintColor.ERASER);
                            } else {
                              _doubleTapped = false;
                            }
                          }
                          _lastClickedX = j;
                          _lastClickedY = i;
                          _lastSetColor = widget.tapColor;

                          var delete = widget.tapColor == _GridPaintColor.ERASER;

                          switch (mode) {
                            case _TapMode.ALL:
                              for (int k = 0; k <= countRows; k++) {
                                for (int l = 0; l <= countColumns; l++) {
                                  _setColor(k, l, delete);
                                }
                              }
                              break;
                            case _TapMode.COLUMN:
                              for (int k = 0; k <= countRows; k++) {
                                _setColor(k, j, delete);
                              }
                              break;
                            case _TapMode.ROW:
                              for (int l = 0; l <= countColumns; l++) {
                                _setColor(i, l, delete);
                              }
                              break;
                            case _TapMode.SINGLE:
                              _setColor(i, j, delete);
                          }
                        });
                      }));
                    })))
      ],
    );
  }

  void _removeColor(int i, int j) {
    for (int k = _gridState.length - 1; k >= 0; k--) {
      var point = _gridState[k];
      if (point.point.x == j && point.point.y == i) {
        if (point.isEndOfLine && k > 0) {
          _gridState[k - 1].isEndOfLine = true;
        }
        _gridState.remove(point);
        break;
      }
    }

    // If maybe before remove the pointlist was (1, 2, 1),
    // now you remove 2, the list is now (1, 1), which should not be, so clearing
    if (_gridState.length <= 1) return;

    var _clearedGridState = <_GridPoint>[];

    var _lastX = -1;
    var _lastY = -1;
    var _lastColor = _GridPaintColor.ERASER; //ERASER is only a placeholder which can never be found in the list
    for (_GridPoint point in _gridState) {
      if (_clearedGridState.isEmpty) {
        _clearedGridState.add(point);
      } else {
        if (point.point.x == _lastX && point.point.y == _lastY && point.color == _lastColor) {
          continue;
        }

        _clearedGridState.add(point);
      }
      _lastX = point.point.x;
      _lastY = point.point.y;
      _lastColor = point.color;
    }

    _gridState = _clearedGridState;
  }

  void _setColor(int i, int j, bool delete) {
    if (delete) {
      _removeColor(i, j);
      return;
    }

    if (_gridState.isNotEmpty && _doubleTapped) {
      _gridState.last.isEndOfLine = true;
    } else {
      _gridState.add(_GridPoint(
        point: Point(j, i),
        color: widget.tapColor
      ));
    }
  }
}

class _CustomGridPainter extends CustomPainter {
  final BuildContext context;
  final _GridType type;
  final int countRows;
  final int countColumns;
  final _GridMode mode;
  final _GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  final List<_GridPoint> gridState;
  final void Function(int, int, int, int, _TapMode) onTapped;

  _CustomGridPainter(
    this.context,
    this.type,
    this.countRows,
    this.countColumns,
    this.mode,
    this.tapColor,
    this.boxEnumeration,
    this.columnEnumeration,
    this.rowEnumeration,
    this.gridState,
    this.onTapped,
  );

  String? _getEnumeration(List<String> enumeration, int index) {
    if (index >= enumeration.length) return null;

    return enumeration[index];
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = Paint();

    switch (type) {
      case _GridType.BOXES:
        _drawBoxesBoard(size, paint, _touchCanvas, canvas);
        break;
      case _GridType.INTERSECTIONS:
        _drawPointsBoard(size, paint, _touchCanvas, canvas);
        break;
    }
  }

  void _drawPointsBoard(Size size, Paint paint, TouchyCanvas _touchCanvas, Canvas canvas) {
    double _countRows = countRows + 0.5;
    double _countColumns = countColumns + 0.5;

    double boxWidth = size.width / _countColumns;
    double boxHeight = size.height / _countRows;

    paint.color = themeColors().secondary();
    paint.strokeWidth = _strokeWidth();

    for (int i = 0; i < _countRows - 1; i++) {
      for (int j = 0; j < _countColumns - 1; j++) {
        var x = j * boxWidth;
        var y = i * boxHeight;

        _touchCanvas.drawLine(Offset(x + boxWidth, boxHeight * 0.8),
            Offset(x + boxWidth, (size.width / (countColumns / countRows) - boxHeight / 2)), paint);
        _touchCanvas.drawLine(Offset(boxWidth * 0.8, y + boxHeight),
            Offset((size.height * (countColumns / countRows) - boxWidth / 2), y + boxHeight), paint);
      }
    }

    for (int i = 0; i < _countRows - 1; i++) {
      for (int j = 0; j < _countColumns - 1; j++) {
        var x = j * boxWidth;
        var y = i * boxHeight;

        String? enumerationTextColumn;
        String? enumerationTextRow;
        if (i == 0) {
          enumerationTextColumn = _getEnumeration(columnEnumeration, j);
        }
        if (j == 0) {
          enumerationTextRow = _getEnumeration(rowEnumeration, i);
        }

        var textColor = themeColors().mainFont();

        if (enumerationTextColumn != null && enumerationTextColumn.isNotEmpty) {
          TextPainter textPainter = _setFontSize(textColor, enumerationTextColumn, boxHeight, boxWidth);

          textPainter.paint(canvas, Offset(x + boxWidth - textPainter.width * 0.5, 0.0));
        }

        paint.color = paint.color.withAlpha(0);

        _touchCanvas.drawRect(Rect.fromLTWH(x + boxWidth / 2, 0.0, boxWidth, boxHeight), paint, onTapDown: (tapDetail) {
          onTapped(i, j, countRows - 1, countColumns - 1, _TapMode.COLUMN);
        });

        if (enumerationTextRow != null && enumerationTextRow.isNotEmpty) {
          TextPainter textPainter = _setFontSize(textColor, enumerationTextRow, boxHeight, boxWidth);

          textPainter.paint(canvas, Offset(0.0, y + boxHeight - textPainter.height * 0.5));
        }

        paint.color = paint.color.withAlpha(0);

        _touchCanvas.drawRect(Rect.fromLTWH(0.0 / 2, y + boxHeight / 2, boxWidth, boxHeight), paint, onTapDown: (tapDetail) {
          onTapped(i, j, countRows - 1, countColumns - 1, _TapMode.ROW);
        });
      }
    }

    var lastX = double.nan;
    var lastY = double.nan;
    var foundEndOfLine = false;

    for (_GridPoint point in gridState) {
      var i = point.point.y;
      var j = point.point.x;

      var x = j * boxWidth;
      var y = i * boxHeight;

      paint.color = _GRID_COLORS[point.color]!['color']!;

      paint.style = PaintingStyle.fill;
      paint.strokeCap = StrokeCap.round;

      var circleRadius = mode == _GridMode.POINTS ? 0.3 : 0.15;

      _touchCanvas.drawCircle(
        Offset(x + boxWidth, y + boxHeight),
        boxWidth * circleRadius,
        paint);

      if (mode == _GridMode.LINES && !foundEndOfLine && !lastX.isNaN && !lastY.isNaN) {
        paint.strokeWidth = _strokeWidth() * 2;
        _touchCanvas.drawLine(
          Offset(x + boxWidth, y + boxHeight),
          Offset(lastX + boxWidth, lastY + boxHeight),
          paint
        );
      }

      lastX = x;
      lastY = y;
      foundEndOfLine = point.isEndOfLine;
    }

    paint.color = paint.color.withAlpha(0);

    // Create invisible touchfields
    for (int i = 0; i < _countRows - 1; i++) {
      for (int j = 0; j < _countColumns - 1; j++) {
        var x = j * boxWidth;
        var y = i * boxHeight;

        _touchCanvas.drawRect(
          Rect.fromCircle(center: Offset(x + boxWidth, y + boxHeight), radius: boxWidth * 0.5),
          paint,
          onTapDown: (tapDetail) {
            onTapped(i, j, countRows, countColumns, _TapMode.SINGLE);
          }
        );
      }
    }
  }

  void _drawBoxesBoard(Size size, Paint paint, TouchyCanvas _touchCanvas, Canvas canvas) {
    int _countRows = countRows + 1;
    int _countColumns = countColumns + 1;

    double boxWidth = size.width / _countColumns;
    double boxHeight = size.height / _countRows;

    var enumerationIndex = -1;
    for (int i = 0; i < _countRows; i++) {
      for (int j = 0; j < _countColumns; j++) {
        if (i > 0 && j > 0) enumerationIndex++;

        var x = j * boxWidth;
        var y = i * boxHeight;

        var point = gridState.firstWhereOrNull((_GridPoint point) => point.point.x == j && point.point.y == i);
        paint.color = point != null ? _GRID_COLORS[point.color]!['color']! : themeColors().gridBackground();
        paint.style = PaintingStyle.fill;

        if (i == 0 || j == 0) {
          paint.color = paint.color.withAlpha(0);
        } else if (mode == _GridMode.LINES) {
          paint.color = paint.color.withAlpha(100);
        }

        _touchCanvas.drawRect(Rect.fromLTWH(x, y, boxWidth, boxHeight), paint);

        paint.color = themeColors().secondary();
        paint.strokeWidth = _strokeWidth();

        _touchCanvas.drawLine(
            Offset(x + boxWidth, 0.0), Offset(x + boxWidth, size.width / (countColumns / countRows)), paint);
        _touchCanvas.drawLine(
            Offset(0.0, y + boxHeight), Offset(size.height * (countColumns / countRows), y + boxHeight), paint);

        String? enumerationText;

        if (i == 0 && j == 0) continue;

        if (i == 0) {
          enumerationText = _getEnumeration(columnEnumeration, j - 1);
        } else if (j == 0) {
          enumerationText = _getEnumeration(rowEnumeration, i - 1);
        } else {
          enumerationText = _getEnumeration(boxEnumeration, enumerationIndex);
        }

        if (enumerationText == null || enumerationText.isEmpty) continue;

        var textColor = point != null ? _GRID_COLORS[point.color]!['fontColor']! : themeColors().mainFont();

        TextPainter textPainter = _setFontSize(textColor, enumerationText, boxHeight, boxWidth);

        textPainter.paint(
            canvas, Offset(x + (boxWidth - textPainter.width) * 0.5, y + (boxHeight - textPainter.height) * 0.5));
      }
    }

    var lastX = double.nan;
    var lastY = double.nan;
    var foundEndOfLine = false;

    if (mode == _GridMode.LINES) {
      for (_GridPoint point in gridState) {
        var i = point.point.y;
        var j = point.point.x;
        if (i == 0 || j == 0) continue;

        var x = j * boxWidth;
        var y = i * boxHeight;

        paint.color = _GRID_COLORS[point.color]!['color']!;
        paint.style = PaintingStyle.fill;
        paint.strokeCap = StrokeCap.round;

        paint.strokeWidth = _strokeWidth() * 3;

        if (!foundEndOfLine && !lastX.isNaN && !lastY.isNaN) {
          _touchCanvas.drawLine(
            Offset(x + boxWidth / 2, y + boxHeight / 2),
            Offset(lastX + boxWidth / 2, lastY + boxHeight / 2),
            paint
          );
        } else {
          _touchCanvas.drawCircle(
            Offset(x + boxWidth / 2, y + boxHeight / 2),
            paint.strokeWidth / 2,
            paint
          );
        }

        lastX = x;
        lastY = y;
        foundEndOfLine = point.isEndOfLine;
      }
    }

    paint.color = paint.color.withAlpha(0);

    // Create invisible touchfields
    for (int i = 0; i < _countRows; i++) {
      for (int j = 0; j < _countColumns; j++) {
        var x = j * boxWidth;
        var y = i * boxHeight;

        _touchCanvas.drawRect(Rect.fromLTWH(x, y, boxWidth, boxHeight), paint, onTapDown: (tapDetail) {
          _TapMode mode;
          if (i == 0 && j == 0) {
            mode = _TapMode.ALL;
          } else if (i == 0) {
            mode = _TapMode.COLUMN;
          } else if (j == 0) {
            mode = _TapMode.ROW;
          } else {
            mode = _TapMode.SINGLE;
          }

          onTapped(i, j, countRows, countColumns, mode);
        });
      }
    }
  }

  double _strokeWidth() {
    return max(countRows, countColumns) > 20 ? 1 : 2;
  }

  TextPainter _setFontSize(Color textColor, String text, double maxHeight, double maxWidth) {
    var fontSize = 20.0;
    TextPainter textPainter;
    TextSpan span;
    do {
      fontSize -= 0.5;
      span = TextSpan(style: gcwTextStyle().copyWith(color: textColor, fontSize: fontSize), text: text);
      textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
      textPainter.layout();
    } while (textPainter.height > maxHeight * 0.9 || textPainter.width > maxWidth * 0.9);
    return textPainter;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
