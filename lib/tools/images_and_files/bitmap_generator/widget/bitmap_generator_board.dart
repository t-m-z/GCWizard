import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:touchable/touchable.dart';

class Image2BinaryBoard extends StatefulWidget {
  final void Function(List<List<bool>>) onChanged;
  final List<List<bool>> state;
  final int width;
  final int height;

  const Image2BinaryBoard(
      {super.key,
      required this.onChanged,
      required this.state,
      required this.width,
      required this.height,
  });

  @override
  _Image2BinaryBoardState createState() => _Image2BinaryBoardState();
}

class _Image2BinaryBoardState extends State<Image2BinaryBoard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: (widget.width != 0 && widget.height != 0)
                    ? widget.width / widget.height
                    : 1.0,
                child: CanvasTouchDetector(
                  gesturesToOverride: const [GestureType.onTapDown],
                  builder: (context) {
                    return CustomPaint(
                        painter: Image2BinaryBoardPainter(
                      context,
                      widget.state,
                      (int x, int y) {
                        setState(() {
                          widget.state[x][y] = !widget.state[x][y];
                          widget.onChanged(widget.state);
                        });
                      },
                      widget.width,
                      widget.height,
                    ));
                  },
                )))
      ],
    );
  }
}

class Image2BinaryBoardPainter extends CustomPainter {
  final List<List<bool>> state;
  final BuildContext context;
  final void Function(int, int) onInvertCell;
  final int width;
  final int height;

  Image2BinaryBoardPainter(this.context, this.state, this.onInvertCell,
      this.width, this.height,);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    var paintLine = Paint();
    var paintFull = Paint();
    var paintBackground = Paint();
    var paintTransparent = Paint();
    double boxSize = size.width / width;

    paintLine.strokeWidth = 2;
    paintLine.style = PaintingStyle.stroke;
    paintLine.color = themeColors().secondary();

    paintBackground.style = PaintingStyle.fill;
    paintBackground.color = themeColors().gridBackground();

    paintTransparent.style = PaintingStyle.fill;
    paintTransparent.color = Colors.transparent;

    paintFull.style = PaintingStyle.fill;
    paintFull.color = themeColors().mainFont();

    if (width != 0 && height != 0) {
      _touchCanvas.drawRect(
          Rect.fromLTWH(0, 0, width * boxSize, height * boxSize),
          paintBackground);
    }
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        paintFull.color = (state[i][j] == true) ? Colors.black : Colors.white;
        _touchCanvas.drawRect(
            Rect.fromLTWH(j * boxSize, i * boxSize, boxSize, boxSize),
            paintFull);
      }
    }

    if (max(width, height) <= 50) {
      for (double j = 0; j <= width * boxSize + 0.0000001; j += boxSize) {
        _touchCanvas.drawLine(
            Offset(j, 0.0), Offset(j, size.height), paintLine);
      }
      for (double i = 0; i <= height * boxSize + 0.0000001; i += boxSize) {
        _touchCanvas.drawLine(Offset(0.0, i), Offset(size.width, i), paintLine);
      }
    }

    _touchCanvas.drawRect(
        Rect.fromLTWH(0, 0, width * boxSize, height * boxSize),
        paintTransparent, onTapDown: (tapDetail) {
      var j = (tapDetail.localPosition.dx / boxSize).toInt();
      var i = (tapDetail.localPosition.dy / boxSize).toInt();
      onInvertCell(i, j);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
