part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

class _JabPerspectiveTransform {
  double a11 = 0, a21 = 0, a31 = 0;
  double a12 = 0, a22 = 0, a32 = 0;
  double a13 = 0, a23 = 0, a33 = 0;
}

_JabPerspectiveTransform _square2Quad(double x0, double y0, double x1, double y1,
    double x2, double y2, double x3, double y3) {
  final pt = _JabPerspectiveTransform();
  final dx3 = x0 - x1 + x2 - x3;
  final dy3 = y0 - y1 + y2 - y3;
  if (dx3 == 0 && dy3 == 0) {
    return pt
      ..a11 = x1 - x0
      ..a21 = x2 - x1
      ..a31 = x0
      ..a12 = y1 - y0
      ..a22 = y2 - y1
      ..a32 = y0
      ..a13 = 0
      ..a23 = 0
      ..a33 = 1;
  }

  final dx1 = x1 - x2;
  final dx2 = x3 - x2;
  final dy1 = y1 - y2;
  final dy2 = y3 - y2;
  final denominator = dx1 * dy2 - dx2 * dy1;
  final a13 = (dx3 * dy2 - dx2 * dy3) / denominator;
  final a23 = (dx1 * dy3 - dx3 * dy1) / denominator;
  return pt
    ..a11 = x1 - x0 + a13 * x1
    ..a21 = x3 - x0 + a23 * x3
    ..a31 = x0
    ..a12 = y1 - y0 + a13 * y1
    ..a22 = y3 - y0 + a23 * y3
    ..a32 = y0
    ..a13 = a13
    ..a23 = a23
    ..a33 = 1;
}

_JabPerspectiveTransform _quad2Square(double x0, double y0, double x1, double y1,
    double x2, double y2, double x3, double y3) {
  final s2q = _square2Quad(x0, y0, x1, y1, x2, y2, x3, y3);
  return _JabPerspectiveTransform()
    ..a11 = s2q.a22 * s2q.a33 - s2q.a23 * s2q.a32
    ..a21 = s2q.a23 * s2q.a31 - s2q.a21 * s2q.a33
    ..a31 = s2q.a21 * s2q.a32 - s2q.a22 * s2q.a31
    ..a12 = s2q.a13 * s2q.a32 - s2q.a12 * s2q.a33
    ..a22 = s2q.a11 * s2q.a33 - s2q.a13 * s2q.a31
    ..a32 = s2q.a12 * s2q.a31 - s2q.a11 * s2q.a32
    ..a13 = s2q.a12 * s2q.a23 - s2q.a13 * s2q.a22
    ..a23 = s2q.a13 * s2q.a21 - s2q.a11 * s2q.a23
    ..a33 = s2q.a11 * s2q.a22 - s2q.a12 * s2q.a21;
}

_JabPerspectiveTransform _multiply(_JabPerspectiveTransform m1, _JabPerspectiveTransform m2) {
  return _JabPerspectiveTransform()
    ..a11 = m1.a11 * m2.a11 + m1.a12 * m2.a21 + m1.a13 * m2.a31
    ..a21 = m1.a21 * m2.a11 + m1.a22 * m2.a21 + m1.a23 * m2.a31
    ..a31 = m1.a31 * m2.a11 + m1.a32 * m2.a21 + m1.a33 * m2.a31
    ..a12 = m1.a11 * m2.a12 + m1.a12 * m2.a22 + m1.a13 * m2.a32
    ..a22 = m1.a21 * m2.a12 + m1.a22 * m2.a22 + m1.a23 * m2.a32
    ..a32 = m1.a31 * m2.a12 + m1.a32 * m2.a22 + m1.a33 * m2.a32
    ..a13 = m1.a11 * m2.a13 + m1.a12 * m2.a23 + m1.a13 * m2.a33
    ..a23 = m1.a21 * m2.a13 + m1.a22 * m2.a23 + m1.a23 * m2.a33
    ..a33 = m1.a31 * m2.a13 + m1.a32 * m2.a23 + m1.a33 * m2.a33;
}

_JabPerspectiveTransform _perspectiveTransform(
    double x0,
    double y0,
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
    double x0p,
    double y0p,
    double x1p,
    double y1p,
    double x2p,
    double y2p,
    double x3p,
    double y3p) {
  return _multiply(
    _quad2Square(x0, y0, x1, y1, x2, y2, x3, y3),
    _square2Quad(x0p, y0p, x1p, y1p, x2p, y2p, x3p, y3p),
  );
}

_JabPerspectiveTransform _getPerspectiveTransform(
  _JabPoint p0, _JabPoint p1, _JabPoint p2, _JabPoint p3, _JabVector2d sideSize) {
  return _perspectiveTransform(
    3.5,
    3.5,
    sideSize.x - 3.5,
    3.5,
    sideSize.x - 3.5,
    sideSize.y - 3.5,
    3.5,
    sideSize.y - 3.5,
    p0.x,
    p0.y,
    p1.x,
    p1.y,
    p2.x,
    p2.y,
    p3.x,
    p3.y,
  );
}

void _warpPoints(_JabPerspectiveTransform pt, List<_JabPoint> points) {
  for (final point in points) {
    final x = point.x;
    final y = point.y;
    final denominator = pt.a13 * x + pt.a23 * y + pt.a33;
    point.x = (pt.a11 * x + pt.a21 * y + pt.a31) / denominator;
    point.y = (pt.a12 * x + pt.a22 * y + pt.a32) / denominator;
  }
}
