import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:touchable/touchable.dart';

enum GridType { BOXES, LINES, INTERSECTIONS }

enum GridEnumerationStart { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT }

enum GridBoxEnumerationStartDirection { UP, DOWN, LEFT, RIGHT }

enum GridBoxEnumerationBehaviour { ALIGNED, ALTERNATED, SPIRAL }

enum GridPaintColor { BLACK, WHITE, RED, YELLOW, BLUE, GREEN }

enum _TapMode { SINGLE, ROW, COLUMN, ALL }

final GRID_COLORS = {
  GridPaintColor.BLACK: {'color': Colors.black, 'fontColor': Colors.white},
  GridPaintColor.WHITE: {'color': Colors.white, 'fontColor': Colors.black},
  GridPaintColor.RED: {'color': Colors.red, 'fontColor': Colors.black},
  GridPaintColor.YELLOW: {'color': Colors.yellow, 'fontColor': Colors.black},
  GridPaintColor.BLUE: {'color': Colors.indigo, 'fontColor': Colors.white},
  GridPaintColor.GREEN: {'color': Colors.green, 'fontColor': Colors.black},
};

class GridPainter extends StatefulWidget {
  final GridType type;
  final int countRows;
  final int countColumns;
  final GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  GridEnumerationStart boxEnumerationStart;
  GridBoxEnumerationBehaviour boxEnumerationBehaviour;
  GridBoxEnumerationStartDirection boxEnumerationStartDirection;

  GridPainter({
    Key key,
    this.type: GridType.BOXES,
    this.countRows: 10,
    this.countColumns: 10,
    this.tapColor: GridPaintColor.BLACK,
    this.boxEnumeration,
    this.columnEnumeration,
    this.rowEnumeration,
    this.boxEnumerationStart,
    this.boxEnumerationStartDirection,
    this.boxEnumerationBehaviour,
  }) : super(key: key) {
    if (boxEnumerationStart == null) boxEnumerationStart = GridEnumerationStart.TOP_LEFT;
    if (boxEnumerationStartDirection == null) boxEnumerationStartDirection = GridBoxEnumerationStartDirection.RIGHT;
    if (boxEnumerationBehaviour == null) boxEnumerationBehaviour = GridBoxEnumerationBehaviour.ALIGNED;
  }

  @override
  GridPainterState createState() => GridPainterState();
}

class GridPainterState extends State<GridPainter> {
  Map<int, Map<int, GridPaintColor>> gridState;
  List<String> _boxEnumeration;
  List<String> _originalBoxEnumeration;

  List<String> _fillBoxEnumeration() {
    if (widget.boxEnumeration == null || widget.boxEnumeration.isEmpty) return null;

    List<List<String>> helper = List.generate(widget.countRows, (_) => List.generate(widget.countColumns, (_) => null));
    var boxEnumeration;
    if (widget.boxEnumeration.length > widget.countColumns * widget.countRows)
      boxEnumeration = widget.boxEnumeration.sublist(0, widget.countRows * widget.countColumns);
    else
      boxEnumeration = widget.boxEnumeration;

    var i = widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
            widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT
        ? 0
        : (widget.countRows - 1);
    var j = widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
            widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT
        ? 0
        : (widget.countColumns - 1);

    var currentDirection = widget.boxEnumerationStartDirection;

    var idx = 0;
    while (idx < boxEnumeration.length) {
      helper[i][j] = widget.boxEnumeration[idx++];

      switch (currentDirection) {
        case GridBoxEnumerationStartDirection.UP:
          if (i > 0 && helper[i - 1][j] == null) {
            i--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = widget.countRows - 1;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = GridBoxEnumerationStartDirection.DOWN;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = GridBoxEnumerationStartDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = GridBoxEnumerationStartDirection.LEFT;
                }

                break;
            }
          }
          ;
          break;

        case GridBoxEnumerationStartDirection.DOWN:
          if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
            i++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = 0;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = GridBoxEnumerationStartDirection.UP;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = GridBoxEnumerationStartDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = GridBoxEnumerationStartDirection.LEFT;
                }

                break;
            }
          }
          ;
          break;

        case GridBoxEnumerationStartDirection.LEFT:
          if (j > 0 && helper[i][j - 1] == null) {
            j--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }

                j = widget.countColumns - 1;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = GridBoxEnumerationStartDirection.RIGHT;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = GridBoxEnumerationStartDirection.DOWN;
                } else {
                  i--;
                  currentDirection = GridBoxEnumerationStartDirection.UP;
                }

                break;
            }
          }
          ;
          break;

        case GridBoxEnumerationStartDirection.RIGHT:
          if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
            j++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.ALIGNED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT) {
                  i++;
                } else {
                  i--;
                }

                j = 0;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT ||
                    widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = GridBoxEnumerationStartDirection.LEFT;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = GridBoxEnumerationStartDirection.DOWN;
                } else {
                  i--;
                  currentDirection = GridBoxEnumerationStartDirection.UP;
                }

                break;
            }
          }
          ;
          break;
      }
    }

    var output = <String>[];
    for (int i = 0; i < widget.countRows; i++) {
      for (int j = 0; j < widget.countColumns; j++) {
        output.add(helper[i][j]);
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == GridType.BOXES && _originalBoxEnumeration != widget.boxEnumeration) {
      _boxEnumeration = _fillBoxEnumeration();
      _originalBoxEnumeration = widget.boxEnumeration;
    }

    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: widget.countColumns / widget.countRows,
                child: CanvasTouchDetector(
                    gesturesToOverride: [GestureType.onTapDown],
                    builder: (context) {
                      return CustomPaint(
                          painter: CustomGridPainter(
                              context,
                              widget.type,
                              widget.countRows,
                              widget.countColumns,
                              widget.tapColor,
                              _boxEnumeration,
                              widget.columnEnumeration,
                              widget.rowEnumeration,
                              gridState, (int i, int j, int countRows, int countColumns, _TapMode mode) {
                        setState(() {
                          if (gridState == null) gridState = <int, Map<int, GridPaintColor>>{};

                          if (gridState[i] == null) {
                            gridState[i] = <int, GridPaintColor>{};
                          }

                          var delete = gridState[i][j] == widget.tapColor;

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

  void _setColor(int i, int j, bool delete) {
    if (gridState[i] == null) {
      gridState[i] = <int, GridPaintColor>{};
    }

    gridState[i].remove(j);

    if (!delete) {
      gridState[i].putIfAbsent(j, () => widget.tapColor);
    }
  }
}

class CustomGridPainter extends CustomPainter {
  final BuildContext context;
  final GridType type;
  final int countRows;
  final int countColumns;
  final GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  final Map<int, Map<int, GridPaintColor>> gridState;
  final Function(int, int, int, int, _TapMode) onTapped;

  CustomGridPainter(
    this.context,
    this.type,
    this.countRows,
    this.countColumns,
    this.tapColor,
    this.boxEnumeration,
    this.columnEnumeration,
    this.rowEnumeration,
    this.gridState,
    this.onTapped,
  );

  String _getEnumeration(List<String> enumeration, int index) {
    if (enumeration == null) return null;
    if (index >= enumeration.length) return null;

    return enumeration[index];
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = Paint();

    switch (type) {
      case GridType.BOXES:
        _drawBoxesBoard(size, paint, _touchCanvas, canvas);
        break;
      case GridType.INTERSECTIONS:
        _drawPointsBoard(size, paint, _touchCanvas, canvas);
        break;
      case GridType.LINES:
        _drawGridBoard(size, paint, _touchCanvas, canvas);
        break;
    }
  }

  void _drawGridBoard(Size size, Paint paint, TouchyCanvas _touchCanvas, Canvas canvas) {
    double _countRows = countRows + 0.5;
    double _countColumns = countColumns + 0.5;

    double boxWidth = size.width / _countColumns;
    double boxHeight = size.height / _countRows;

    paint.color = themeColors().accent();
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

        String enumerationTextColumn;
        String enumerationTextRow;
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

        if (enumerationTextRow != null && enumerationTextRow.isNotEmpty) {
          TextPainter textPainter = _setFontSize(textColor, enumerationTextRow, boxHeight, boxWidth);

          textPainter.paint(canvas, Offset(0.0, y + boxHeight - textPainter.height * 0.5));
        }
      }
    }

    for (int i = 0; i < (_countRows * 2 - 1); i++) {
      for (int j = 0; j < (_countColumns * 2 - 1); j++) {
        if ((i + j) % 2 == 0) continue;

        var x = j * boxWidth / 2;
        var y = i * boxHeight / 2;

        if (gridState != null && gridState[i] != null && gridState[i][j] != null) {
          paint.color = GRID_COLORS[gridState[i][j]]['color'];
          paint.style = PaintingStyle.stroke;
          paint.strokeWidth = 6;

          var path = Path();

          if (j % 2 == 0 && i > 1) {
            path.moveTo(x + boxWidth, y - boxHeight * 0.5);
            path.relativeLineTo(0.0, boxHeight);
          } else if (i % 2 == 0 && j > 1) {
            path.moveTo(x - boxWidth * 0.5, y + boxHeight);
            path.relativeLineTo(boxWidth, 0.0);
          }

          _touchCanvas.drawPath(path, paint);
        }

        paint.style = PaintingStyle.fill;
        paint.color = paint.color.withOpacity(0.0);

        var mode = _TapMode.SINGLE;

        var path = Path();
        if (i % 2 == 0) {
          path.moveTo(x, y + boxHeight * 0.5);
          if (j == 1) {
            path.relativeLineTo(boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, 0.0);
            path.relativeLineTo(0.0, -boxHeight);
          } else {
            path.relativeLineTo(boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, -boxHeight / 2);
            path.relativeLineTo(boxWidth / 2, -boxHeight / 2);
          }
        } else if (j % 2 == 0) {
          path.moveTo(x + boxWidth * 0.5, y);
          if (i == 1) {
            path.relativeLineTo(0.0, -boxHeight / 2);
            path.relativeLineTo(boxWidth, 0.0);
            path.relativeLineTo(0.0, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
          } else {
            path.relativeLineTo(boxWidth / 2, -boxHeight / 2);
            path.relativeLineTo(boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
            path.relativeLineTo(-boxWidth / 2, -boxHeight / 2);
          }
        }

        _touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
          if (j == 1) {
            mode = _TapMode.ROW;
          } else if (i == 1) {
            mode = _TapMode.COLUMN;
          }

          onTapped(i, j, countRows * 2 - 1, countColumns * 2 - 1, mode);
        });
      }
    }
  }

  void _drawPointsBoard(Size size, Paint paint, TouchyCanvas _touchCanvas, Canvas canvas) {
    double _countRows = countRows + 0.5;
    double _countColumns = countColumns + 0.5;

    double boxWidth = size.width / _countColumns;
    double boxHeight = size.height / _countRows;

    paint.color = themeColors().accent();
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

        String enumerationTextColumn;
        String enumerationTextRow;
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

        paint.color = paint.color.withOpacity(0.0);

        _touchCanvas.drawRect(Rect.fromLTWH(x + boxWidth / 2, 0.0, boxWidth, boxHeight), paint, onTapDown: (tapDetail) {
          onTapped(i, j, countRows, countColumns, _TapMode.COLUMN);
        });

        if (enumerationTextRow != null && enumerationTextRow.isNotEmpty) {
          TextPainter textPainter = _setFontSize(textColor, enumerationTextRow, boxHeight, boxWidth);

          textPainter.paint(canvas, Offset(0.0, y + boxHeight - textPainter.height * 0.5));
        }

        paint.color = paint.color.withOpacity(0.0);

        _touchCanvas.drawRect(Rect.fromLTWH(0.0 / 2, y + boxHeight / 2, boxWidth, boxHeight), paint,
            onTapDown: (tapDetail) {
          onTapped(i, j, countRows, countColumns, _TapMode.ROW);
        });
      }
    }

    for (int i = 0; i < _countRows - 1; i++) {
      for (int j = 0; j < _countColumns - 1; j++) {
        var x = j * boxWidth;
        var y = i * boxHeight;

        paint.color = gridState != null && gridState[i] != null && gridState[i][j] != null
            ? GRID_COLORS[gridState[i][j]]['color']
            : paint.color.withOpacity(0.0);
        ;
        paint.style = PaintingStyle.fill;

        _touchCanvas.drawCircle(Offset(x + boxWidth, y + boxHeight), boxWidth * 0.4, paint, onTapDown: (tapDetail) {
          onTapped(i, j, countRows, countColumns, _TapMode.SINGLE);
        });
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

        paint.color = gridState != null && gridState[i] != null && gridState[i][j] != null
            ? GRID_COLORS[gridState[i][j]]['color']
            : themeColors().gridBackground();
        paint.style = PaintingStyle.fill;

        if (i == 0 || j == 0) paint.color = paint.color.withOpacity(0.0);

        _touchCanvas.drawRect(Rect.fromLTWH(x, y, boxWidth, boxHeight), paint, onTapDown: (tapDetail) {
          var mode;
          if (i == 0 && j == 0) {
            mode = _TapMode.ALL;
          } else if (i == 0) {
            mode = _TapMode.COLUMN;
          } else if (j == 0) {
            mode = _TapMode.ROW;
          } else {
            mode = _TapMode.SINGLE;
          }

          onTapped(i, j, _countRows, countColumns, mode);
        });

        paint.color = themeColors().accent();
        paint.strokeWidth = _strokeWidth();

        _touchCanvas.drawLine(
            Offset(x + boxWidth, 0.0), Offset(x + boxWidth, size.width / (countColumns / countRows)), paint);
        _touchCanvas.drawLine(
            Offset(0.0, y + boxHeight), Offset(size.height * (countColumns / countRows), y + boxHeight), paint);

        var enumerationText;

        if (i == 0 && j == 0) continue;

        if (i == 0) {
          enumerationText = _getEnumeration(columnEnumeration, j - 1);
        } else if (j == 0) {
          enumerationText = _getEnumeration(rowEnumeration, i - 1);
        } else {
          enumerationText = _getEnumeration(boxEnumeration, enumerationIndex);
        }

        if (enumerationText == null || enumerationText.isEmpty) continue;

        var textColor = gridState != null && gridState[i] != null && gridState[i][j] != null && i > 0 && j > 0
            ? GRID_COLORS[gridState[i][j]]['fontColor']
            : themeColors().mainFont();

        TextPainter textPainter = _setFontSize(textColor, enumerationText, boxHeight, boxWidth);

        textPainter.paint(
            canvas, Offset(x + (boxWidth - textPainter.width) * 0.5, y + (boxHeight - textPainter.height) * 0.5));
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
      span = TextSpan(style: gcwTextStyle().copyWith(color: textColor, fontSize: fontSize), text: text ?? '');
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
