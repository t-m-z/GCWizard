part of 'package:gc_wizard/tools/games/tridoku/widget/tridoku_solver.dart';

class _TridokuBoard extends StatefulWidget {
  final void Function(TridokuBoard) onChanged;
  final TridokuBoard board;

  const _TridokuBoard({required this.onChanged, required this.board});

  @override
  _TridokuBoardState createState() => _TridokuBoardState();
}

class _TridokuBoardState extends State<_TridokuBoard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CanvasTouchDetector(
                  gesturesToOverride: const [GestureType.onTapDown],
                  builder: (context) {
                    return CustomPaint(
                        painter: TridokuBoardPainter(context, widget.board, (y, x, value) {
                      setState(() {
                        if (value == null) {
                          widget.board.setValue(y, x, null, TridokuFillType.CALCULATED);
                          widget.onChanged(widget.board);
                          return;
                        }

                        widget.board.setValue(y, x, value, TridokuFillType.USER_FILLED);
                        widget.onChanged(widget.board);
                      });
                    }));
                  },
                )))
      ],
    );
  }
}

class TridokuBoardPainter extends CustomPainter {
  final void Function(int, int, int?) setBoxValue;
  final TridokuBoard board;
  final BuildContext context;

  TridokuBoardPainter(this.context, this.board, this.setBoxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    paint.style = PaintingStyle.fill;

    for (int l = 0; l < 9; l++) {
      for (int k = 0; k < columnCount(l); k++) {
        var boardY = l;
        var boardX = k;

        var corner = _getCellCorner(boardY, boardX, size);
        paint.color = _getCellBackColor(boardY, boardX) ?? colors.gridBackground();

        Path path = Path();
        path.moveTo(corner.P1.dx, corner.P1.dy);
        path.lineTo(corner.P2.dx, corner.P2.dy);
        path.lineTo(corner.P3.dx, corner.P3.dy);
        path.close();

        _touchCanvas.drawPath(path, paint);

        _touchCanvas.drawPath(path, paint,
            onTapDown: (tapDetail) {
          board.removeCalculated();
          _showInputDialog(boardY, boardX);
        });

        if (board.getValue(boardY, boardX) != null) {
          var textColor = board.getFillType(boardY, boardX) == TridokuFillType.USER_FILLED
              ? colors.secondary()
              : colors.mainFont();

          var heightInner = corner.P3.dy - corner.P1.dy;
          bool pointsUp = boardX.isEven;
          var xPos = pointsUp ? corner.P1.dx : corner.P3.dx;
          var yPos = corner.P1.dy + heightInner / 2 + (pointsUp ? 0.12 : -0.12) * heightInner;

          TextSpan span = TextSpan(
              style: gcwTextStyle().copyWith(color: textColor, fontSize: heightInner * 0.7),
              text: board.getValue(boardY, boardX)?.toString());
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas,
              Offset(xPos - textPainter.width * 0.5, yPos - textPainter.height * 0.5));
        }
      }
    }
    paint.color = colors.secondary();
    paint.style = PaintingStyle.stroke;

    paint.strokeWidth = 4;

    Offset p1 = _getCellCorner(0, 0, size).P1;
    Offset p2 = _getCellCorner(8, columnCount(8) - 1, size).P2;
    Offset p3 = _getCellCorner(8, 0, size).P3;

    _touchCanvas.drawLine(p1, p2, paint);
    _touchCanvas.drawLine(p2, p3, paint);
    _touchCanvas.drawLine(p3, p1, paint);

    for (int l = 1; l < 9; l++) {
      paint.strokeWidth = l % 3 == 0 ? 3 : 1;

      p1 = _getCellCorner(l, 0, size).P1;
      p2 = _getCellCorner(l, columnCount(l) - 1, size).P1;
      _touchCanvas.drawLine(p1, p2, paint);

      p3 = _getCellCorner(8, columnCount(8 - l + 1) - 1, size).P3;
      _touchCanvas.drawLine(p1, p3, paint);

      p3 = _getCellCorner(8, columnCount(l- 1) - 1, size).P2;
      _touchCanvas.drawLine(p2, p3, paint);
    }
  }


  ({Offset P1, Offset P2, Offset P3}) _getCellCorner(int row, int col, Size size) {
    double widthInner = size.width / 9;
    double heightInner = size.height / 9;
    bool pointsUp = col.isEven;

    var startX = size.width / 2 + (col - row) * widthInner / 2;
    if (pointsUp) {
      var p1 = Offset(startX, row * heightInner);
      var p2 = Offset(p1.dx + widthInner / 2, p1.dy + heightInner);
      var p3 = Offset(p2.dx - widthInner, p2.dy);

      return (P1: p1, P2: p2, P3: p3);
    } else {
      var p1 = Offset(startX - widthInner / 2, row * heightInner);
      var p2 = Offset(p1.dx + widthInner, p1.dy);
      var p3 = Offset(p2.dx - widthInner / 2, p2.dy + heightInner);

      return (P1: p1, P2: p2, P3: p3);
    }
  }

  Color? _getCellBackColor(int row, int col) {
    var lastIndex = columnCount(row) - 1;
    if (col == 0 || col == lastIndex || (row == 8 && col.isEven)) {
      if (row == 4 || (row == 8 && col == 8)) {
        return Colors.greenAccent;
      } else {
        return Colors.grey;
      }
    } else if ((row == 4) || ((row > 4) && ((col == (row - 5) * 2 + 1) ||
        (col == (row - 5) * 2 + 2) || (col == 8) || (col == 9)))) {
      return Colors.blueAccent;
    }
    return null;
  }

  void _showInputDialog(int x, int y) {
    var columns = <Widget>[];

    for (int i = 0; i < 3; i++) {
      var rows = <Widget>[];
      for (int j = 0; j < 3; j++) {
        var value = i * 3 + j + 1;

        rows.add(GCWButton(
          text: value.toString(),
          textStyle: gcwTextStyle().copyWith(fontSize: 32, color: themeColors().dialogText()),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            setBoxValue(x, y, value);
          },
        ));
      }

      columns.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }

    columns.add(GCWButton(
      text: i18n(context, 'sudokusolver_removevalue'),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        setBoxValue(x, y, null);
      },
    ));

    showGCWDialog(
        context,
        i18n(context, 'sudokusolver_entervalue'),
        SizedBox(
          height: 300,
          child: Column(children: columns),
        ),
        []);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
