part of 'package:gc_wizard/tools/images_and_files/jabcode/logic/jabcode.dart';

const int _maxModules = 145;
const int _maxSymbolRows = 3;
const int _maxFinderPatterns = 500;

class _JabDetectMode {
// ignore: unused_field
  static const int quick = 0;
// ignore: unused_field
  static const int normal = 1;
  static const int intensive = 2;
}

class _JabFinderPattern {
  int type = 0;
  double moduleSize = 0;
  _JabPoint center = _JabPoint(0, 0);
  int foundCount = 0;
  int direction = 0;

  _JabFinderPattern clone() {
    final c = _JabFinderPattern();
    c.type = type;
    c.moduleSize = moduleSize;
    c.center = _JabPoint(center.x, center.y);
    c.foundCount = foundCount;
    c.direction = direction;
    return c;
  }
}

({bool Success, double ModuleSize}) _checkPatternCross(List<int> stateCount) {
  const layerNumber = 3;
  int insideLayerSize = 0;
  for (int i = 1; i < layerNumber + 1; i++) {
    if (stateCount[i] == 0) return (Success: false, ModuleSize: 0.0);
    insideLayerSize += stateCount[i];
  }

  final layerSize = insideLayerSize / 3.0;
  final layerTolerance = layerSize / 2.0;

  final sizeCondition = (layerSize - stateCount[1]).abs() < layerTolerance &&
      (layerSize - stateCount[2]).abs() < layerTolerance &&
      (layerSize - stateCount[3]).abs() < layerTolerance &&
      stateCount[0] > 0.5 * layerTolerance &&
      stateCount[4] > 0.5 * layerTolerance &&
      (stateCount[1] - stateCount[3]).abs() < layerTolerance;

  return (Success: sizeCondition, ModuleSize: layerSize);
}

bool _checkModuleSize2(double size1, double size2) {
  final mean = (size1 + size2) / 2.0;
  final tolerance = mean / 2.5;
  return (mean - size1).abs() < tolerance && (mean - size2).abs() < tolerance;
}

({bool Success, int Start, int End, double Center, double ModuleSize, int? Skip}) _seekPattern(
    _JabBitmap ch, int row, int col, int startIn, int endIn) {
  const stateNumber = 5;
  int curState = 0;
  final stateCount = List<int>.filled(5, 0);

  int start = startIn;
  int end = endIn;
  double center = 0;
  double moduleSize = 0;
  int? skip;

  final min = start;
  final max = end;
  for (int p = min; p < max; p++) {
    if (p == min) {
      stateCount[curState]++;
      start = p;
    } else {
      int prev, curr;
      if (row >= 0) {
        prev = ch.pixel[row * ch.width + (p - 1)];
        curr = ch.pixel[row * ch.width + p];
      } else if (col >= 0) {
        prev = ch.pixel[(p - 1) * ch.width + col];
        curr = ch.pixel[p * ch.width + col];
      } else {
        return (Success: false, Start: start, End: end, Center: center, ModuleSize: moduleSize, Skip: skip);
      }

      if (curr == prev) {
        stateCount[curState]++;
      }
      if (curr != prev || p == max - 1) {
        if (curState < stateNumber - 1) {
          if (stateCount[curState] < 3) {
            if (curState == 0) {
              stateCount[curState] = 1;
              start = p;
            } else {
              stateCount[curState - 1] += stateCount[curState];
              stateCount[curState] = 0;
              curState--;
              stateCount[curState]++;
            }
          } else {
            curState++;
            stateCount[curState]++;
          }
        } else {
          if (stateCount[curState] < 3) {
            stateCount[curState - 1] += stateCount[curState];
            stateCount[curState] = 0;
            curState--;
            stateCount[curState]++;
            continue;
          }
          final chk = _checkPatternCross(stateCount);
          moduleSize = chk.ModuleSize;
          if (chk.Success) {
            end = p + 1;
            skip = stateCount[0];
            int endPos;
            if (p == (max - 1) && curr == prev) {
              endPos = p + 1;
            } else {
              endPos = p;
            }
            center = (endPos - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
            return (Success: true, Start: start, End: end, Center: center, ModuleSize: moduleSize, Skip: skip);
          } else {
            start += stateCount[0];
            for (int k = 0; k < stateNumber - 1; k++) {
              stateCount[k] = stateCount[k + 1];
            }
            stateCount[stateNumber - 1] = 1;
            curState = stateNumber - 1;
          }
        }
      }
    }
  }
  end = max;
  return (Success: false, Start: start, End: end, Center: center, ModuleSize: moduleSize, Skip: skip);
}

({bool Success, int StartX, int EndX, double CenterX, double ModuleSize, int? Skip}) _seekPatternHorizontal(
    List<int> row, int startxIn, int endxIn) {
  const stateNumber = 5;
  int curState = 0;
  final stateCount = List<int>.filled(5, 0);

  int startx = startxIn;
  int endx = endxIn;
  double centerx = 0;
  double moduleSize = 0;
  int? skip;

  final min = startx;
  final max = endx;
  for (int j = min; j < max; j++) {
    if (j == min) {
      stateCount[curState]++;
      startx = j;
    } else {
      if (row[j] == row[j - 1]) {
        stateCount[curState]++;
      }
      if (row[j] != row[j - 1] || j == max - 1) {
        if (curState < stateNumber - 1) {
          if (stateCount[curState] < 3) {
            if (curState == 0) {
              stateCount[curState] = 1;
              startx = j;
            } else {
              stateCount[curState - 1] += stateCount[curState];
              stateCount[curState] = 0;
              curState--;
              stateCount[curState]++;
            }
          } else {
            curState++;
            stateCount[curState]++;
          }
        } else {
          if (stateCount[curState] < 3) {
            stateCount[curState - 1] += stateCount[curState];
            stateCount[curState] = 0;
            curState--;
            stateCount[curState]++;
            continue;
          }
          final chk = _checkPatternCross(stateCount);
          moduleSize = chk.ModuleSize;
          if (chk.Success) {
            endx = j + 1;
            skip = stateCount[0];
            int end;
            if (j == (max - 1) && row[j] == row[j - 1]) {
              end = j + 1;
            } else {
              end = j;
            }
            centerx = (end - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
            return (Success: true, StartX: startx, EndX: endx, CenterX: centerx, ModuleSize: moduleSize, Skip: skip);
          } else {
            startx += stateCount[0];
            for (int k = 0; k < stateNumber - 1; k++) {
              stateCount[k] = stateCount[k + 1];
            }
            stateCount[stateNumber - 1] = 1;
            curState = stateNumber - 1;
          }
        }
      }
    }
  }
  endx = max;
  return (Success: false, StartX: startx, EndX: endx, CenterX: centerx, ModuleSize: moduleSize, Skip: skip);
}

({double CenterX, double CenterY, double ModuleSize, int Dir, int Dcc}) _crossCheckPatternDiagonal(
    _JabBitmap image, int type, double moduleSizeMax, double centerxIn, double centeryIn, int dirIn, bool bothDir) {
  const stateNumber = 5;
  const stateMiddle = (stateNumber - 1) ~/ 2;

  double centerx = centerxIn;
  double centery = centeryIn;
  int dir = dirIn;
  double moduleSize = 0;

  int offsetX, offsetY;
  bool fixDir = false;
  if (dir != 0) {
    if (dir > 0) {
      offsetX = -1;
      offsetY = -1;
      dir = 1;
    } else {
      offsetX = 1;
      offsetY = -1;
      dir = -1;
    }
    fixDir = true;
  } else {
    if (type == _fp0 || type == _fp1) {
      offsetX = -1;
      offsetY = -1;
      dir = 1;
    } else {
      offsetX = 1;
      offsetY = -1;
      dir = -1;
    }
  }

  int dcc = 0;
  bool flag = false;
  int tryCount = 0;
  double tmpModuleSize = 0.0;
  do {
    flag = false;
    tryCount++;

    int i = 0, j, stateIndex;
    final stateCount = List<int>.filled(5, 0);
    final startx = centerx.toInt();
    final starty = centery.toInt();

    stateCount[stateMiddle]++;
    stateIndex = 0;
    for (j = 1;
        (starty + j * offsetY) >= 0 &&
        (starty + j * offsetY) < image.height &&
        (startx + j * offsetX) >= 0 &&
        (startx + j * offsetX) < image.width &&
        stateIndex <= stateMiddle;
        j++) {
      if (image.pixel[(starty + j * offsetY) * image.width + (startx + j * offsetX)] ==
          image.pixel[(starty + (j - 1) * offsetY) * image.width + (startx + (j - 1) * offsetX)]) {
        stateCount[stateMiddle - stateIndex]++;
      } else {
        if (stateIndex > 0 && stateCount[stateMiddle - stateIndex] < 3) {
          stateCount[stateMiddle - (stateIndex - 1)] += stateCount[stateMiddle - stateIndex];
          stateCount[stateMiddle - stateIndex] = 0;
          stateIndex--;
          stateCount[stateMiddle - stateIndex]++;
        } else {
          stateIndex++;
          if (stateIndex > stateMiddle) break;
          stateCount[stateMiddle - stateIndex]++;
        }
      }
    }
    if (stateIndex < stateMiddle) {
      if (tryCount == 1) {
        flag = true;
        offsetX = -offsetX;
        dir = -dir;
      } else {
        return (CenterX: centerx, CenterY: centery, ModuleSize: moduleSize, Dir: dir, Dcc: dcc);
      }
    }

    if (!flag) {
      stateIndex = 0;
      for (i = 1;
          (starty - i * offsetY) >= 0 &&
              (starty - i * offsetY) < image.height &&
              (startx - i * offsetX) >= 0 &&
              (startx - i * offsetX) < image.width &&
              stateIndex <= stateMiddle;
          i++) {
        if (image.pixel[(starty - i * offsetY) * image.width + (startx - i * offsetX)] ==
            image.pixel[
                (starty - (i - 1) * offsetY) * image.width + (startx - (i - 1) * offsetX)]) {
          stateCount[stateMiddle + stateIndex]++;
        } else {
          if (stateIndex > 0 && stateCount[stateMiddle + stateIndex] < 3) {
            stateCount[stateMiddle + (stateIndex - 1)] += stateCount[stateMiddle + stateIndex];
            stateCount[stateMiddle + stateIndex] = 0;
            stateIndex--;
            stateCount[stateMiddle + stateIndex]++;
          } else {
            stateIndex++;
            if (stateIndex > stateMiddle) break;
            stateCount[stateMiddle + stateIndex]++;
          }
        }
      }
      if (stateIndex < stateMiddle) {
        if (tryCount == 1) {
          flag = true;
          offsetX = -offsetX;
          dir = -dir;
        } else {
          return (CenterX: centerx, CenterY: centery, ModuleSize: moduleSize, Dir: dir, Dcc: dcc);
        }
      }
    }

    if (!flag) {
      final chk = _checkPatternCross(stateCount);
      moduleSize = chk.ModuleSize;
      if (chk.Success && (moduleSize <= moduleSizeMax)) {
        if (tmpModuleSize > 0) {
          moduleSize = (moduleSize + tmpModuleSize) / 2.0;
        } else {
          tmpModuleSize = moduleSize;
        }

        centerx = (startx + i - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
        centery = (starty + i - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
        dcc++;
        if (!bothDir || tryCount == 2 || fixDir) {
          if (dcc == 2) dir = 2;
          return (CenterX: centerx, CenterY: centery, ModuleSize: moduleSize, Dir: dir, Dcc: dcc);
        }
      } else {
        offsetX = -offsetX;
        dir = -dir;
      }
    }
  } while (tryCount < 2 && !fixDir);

  return (CenterX: centerx, CenterY: centery, ModuleSize: moduleSize, Dir: dir, Dcc: dcc);
}

({bool Success, double CenterY, double ModuleSize}) _crossCheckPatternVertical(
    _JabBitmap image, double moduleSizeMax, double centerx, double centeryIn) {
  const stateNumber = 5;
  const stateMiddle = (stateNumber - 1) ~/ 2;
  final stateCount = List<int>.filled(5, 0);

  final centerxInt = centerx.toInt();
  final centeryInt = centeryIn.toInt();
  int i, stateIndex;
  double centery = centeryIn;
  double moduleSize = 0;

  stateCount[1]++;
  stateIndex = 0;
  for (i = 1; i <= centeryInt && stateIndex <= stateMiddle; i++) {
    if (image.pixel[(centeryInt - i) * image.width + centerxInt] ==
        image.pixel[(centeryInt - (i - 1)) * image.width + centerxInt]) {
      stateCount[stateMiddle - stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[stateMiddle - stateIndex] < 3) {
        stateCount[stateMiddle - (stateIndex - 1)] += stateCount[stateMiddle - stateIndex];
        stateCount[stateMiddle - stateIndex] = 0;
        stateIndex--;
        stateCount[stateMiddle - stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > stateMiddle) break;
        stateCount[stateMiddle - stateIndex]++;
      }
    }
  }
  if (stateIndex < stateMiddle) return (Success: false, CenterY: centery, ModuleSize: moduleSize);

  stateIndex = 0;
  for (i = 1; (centeryInt + i) < image.height && stateIndex <= stateMiddle; i++) {
    if (image.pixel[(centeryInt + i) * image.width + centerxInt] ==
        image.pixel[(centeryInt + (i - 1)) * image.width + centerxInt]) {
      stateCount[stateMiddle + stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[stateMiddle + stateIndex] < 3) {
        stateCount[stateMiddle + (stateIndex - 1)] += stateCount[stateMiddle + stateIndex];
        stateCount[stateMiddle + stateIndex] = 0;
        stateIndex--;
        stateCount[stateMiddle + stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > stateMiddle) break;
        stateCount[stateMiddle + stateIndex]++;
      }
    }
  }
  if (stateIndex < stateMiddle) return (Success: false, CenterY: centery, ModuleSize: moduleSize);

  final chk = _checkPatternCross(stateCount);
  if (chk.Success && (chk.ModuleSize <= moduleSizeMax)) {
    centery = (centeryInt + i - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
    return (Success: true, CenterY: centery, ModuleSize: chk.ModuleSize);
  }
  return (Success: false, CenterY: centery, ModuleSize: chk.ModuleSize);
}

({bool Success, double CenterX, double ModuleSize}) _crossCheckPatternHorizontal(
    _JabBitmap image, double moduleSizeMax, double centerxIn, double centery) {
  const stateNumber = 5;
  const stateMiddle = (stateNumber - 1) ~/ 2;
  final stateCount = List<int>.filled(5, 0);

  final startx = centerxIn.toInt();
  final offset = centery.toInt() * image.width;
  int i, stateIndex;
  double centerx = centerxIn;
  double moduleSize = 0;

  stateCount[stateMiddle]++;
  stateIndex = 0;
  for (i = 1; i <= startx && stateIndex <= stateMiddle; i++) {
    if (image.pixel[offset + (startx - i)] == image.pixel[offset + (startx - (i - 1))]) {
      stateCount[stateMiddle - stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[stateMiddle - stateIndex] < 3) {
        stateCount[stateMiddle - (stateIndex - 1)] += stateCount[stateMiddle - stateIndex];
        stateCount[stateMiddle - stateIndex] = 0;
        stateIndex--;
        stateCount[stateMiddle - stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > stateMiddle) break;
        stateCount[stateMiddle - stateIndex]++;
      }
    }
  }
  if (stateIndex < stateMiddle) return (Success: false, CenterX: centerx, ModuleSize: moduleSize);

  stateIndex = 0;
  for (i = 1; (startx + i) < image.width && stateIndex <= stateMiddle; i++) {
    if (image.pixel[offset + (startx + i)] == image.pixel[offset + (startx + (i - 1))]) {
      stateCount[stateMiddle + stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[stateMiddle + stateIndex] < 3) {
        stateCount[stateMiddle + (stateIndex - 1)] += stateCount[stateMiddle + stateIndex];
        stateCount[stateMiddle + stateIndex] = 0;
        stateIndex--;
        stateCount[stateMiddle + stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > stateMiddle) break;
        stateCount[stateMiddle + stateIndex]++;
      }
    }
  }
  if (stateIndex < stateMiddle) return (Success: false, CenterX: centerx, ModuleSize: moduleSize);

  final chk = _checkPatternCross(stateCount);
  if (chk.Success && (chk.ModuleSize <= moduleSizeMax)) {
    centerx = (startx + i - stateCount[4] - stateCount[3]) - stateCount[2] / 2.0;
    return (Success: true, CenterX: centerx, ModuleSize: chk.ModuleSize);
  }
  return (Success: false, CenterX: centerx, ModuleSize: chk.ModuleSize);
}

bool _crossCheckColor(_JabBitmap image, int color, int moduleSize, int moduleNumber, int centerx,
    int centery, int dir) {
  const tolerance = 3;
  if (dir == 0) {
    final length = moduleSize * (moduleNumber - 1);
    final startx = (centerx - length ~/ 2) < 0 ? 0 : (centerx - length ~/ 2);
    int unmatch = 0;
    for (int j = startx; j < (startx + length) && j < image.width; j++) {
      if (image.pixel[centery * image.width + j] != color) {
        unmatch++;
      } else {
        if (unmatch <= tolerance) unmatch = 0;
      }
      if (unmatch > tolerance) return false;
    }
    return true;
  } else if (dir == 1) {
    final length = moduleSize * (moduleNumber - 1);
    final starty = (centery - length ~/ 2) < 0 ? 0 : (centery - length ~/ 2);
    int unmatch = 0;
    for (int i = starty; i < (starty + length) && i < image.height; i++) {
      if (image.pixel[image.width * i + centerx] != color) {
        unmatch++;
      } else {
        if (unmatch <= tolerance) unmatch = 0;
      }
      if (unmatch > tolerance) return false;
    }
    return true;
  } else if (dir == 2) {
    final offset = (moduleSize * (moduleNumber / (2.0 * 1.41421))).toInt();
    final length = offset * 2;

    int unmatch = 0;
    int startx = (centerx - offset) < 0 ? 0 : (centerx - offset);
    int starty = (centery - offset) < 0 ? 0 : (centery - offset);
    for (int i = 0; i < length && (starty + i) < image.height; i++) {
      if (image.pixel[image.width * (starty + i) + (startx + i)] != color) {
        unmatch++;
      } else {
        if (unmatch <= tolerance) unmatch = 0;
      }
      if (unmatch > tolerance) break;
    }
    if (unmatch < tolerance) return true;

    unmatch = 0;
    startx = (centerx - offset) < 0 ? 0 : (centerx - offset);
    starty = (centery + offset) > (image.height - 1) ? (image.height - 1) : (centery + offset);
    for (int i = 0; i < length && (starty - i) >= 0; i++) {
      if (image.pixel[image.width * (starty - i) + (startx + i)] != color) {
        unmatch++;
      } else {
        if (unmatch <= tolerance) unmatch = 0;
      }
      if (unmatch > tolerance) return false;
    }
    return true;
  } else {
    return false; // "Invalid direction"
  }
}

({bool Success, double ModuleSize, double CenterX, double CenterY, int Dir, int Dcc}) _crossCheckPatternCh(
    _JabBitmap ch, int type, int hV, double moduleSizeMax, double centerxIn, double centeryIn, int dirIn) {
  double moduleSizeV = 0.0, moduleSizeH = 0.0;
  double centerx = centerxIn;
  double centery = centeryIn;
  int dir = dirIn;
  double moduleSize = 0;
  int dcc = 0;

  if (hV == 0) {
    bool vcc = false;
    final vr = _crossCheckPatternVertical(ch, moduleSizeMax, centerx, centery);
    if (vr.Success) {
      vcc = true;
      centery = vr.CenterY;
      moduleSizeV = vr.ModuleSize;
      final hr = _crossCheckPatternHorizontal(ch, moduleSizeMax, centerx, centery);
      if (!hr.Success) return (Success: false, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
      centerx = hr.CenterX;
      moduleSizeH = hr.ModuleSize;
    }
    final dr = _crossCheckPatternDiagonal(ch, type, moduleSizeMax, centerx, centery, dir, !vcc);
    dcc = dr.Dcc;
    centerx = dr.CenterX;
    centery = dr.CenterY;
    dir = dr.Dir;
    if (vcc && dcc > 0) {
      moduleSize = (moduleSizeV + moduleSizeH + dr.ModuleSize) / 3.0;
      return (Success: true, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
    } else if (dcc == 2) {
      final hr = _crossCheckPatternHorizontal(ch, moduleSizeMax, centerx, centery);
      if (!hr.Success) return (Success: false, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
      centerx = hr.CenterX;
      moduleSizeH = hr.ModuleSize;
      moduleSize = (moduleSizeH + dr.ModuleSize * 2.0) / 3.0;
      return (Success: true, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
    }
  } else {
    bool hcc = false;
    final hr = _crossCheckPatternHorizontal(ch, moduleSizeMax, centerx, centery);
    if (hr.Success) {
      hcc = true;
      centerx = hr.CenterX;
      moduleSizeH = hr.ModuleSize;
      final vr = _crossCheckPatternVertical(ch, moduleSizeMax, centerx, centery);
      if (!vr.Success) {
        return (Success: false, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
      }
      centery = vr.CenterY;
      moduleSizeV = vr.ModuleSize;
    }
    final dr = _crossCheckPatternDiagonal(ch, type, moduleSizeMax, centerx, centery, dir, !hcc);
    dcc = dr.Dcc;
    centerx = dr.CenterX;
    centery = dr.CenterY;
    dir = dr.Dir;
    if (hcc && dcc > 0) {
      moduleSize = (moduleSizeV + moduleSizeH + dr.ModuleSize) / 3.0;
      return (Success: true, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
    } else if (dcc == 2) {
      final vr = _crossCheckPatternVertical(ch, moduleSizeMax, centerx, centery);
      if (!vr.Success) {
        return (Success: false, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
      }
      centery = vr.CenterY;
      moduleSize = (vr.ModuleSize + dr.ModuleSize * 2.0) / 3.0;
      return (Success: true, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
    }
  }
  return (Success: false, ModuleSize: moduleSize, CenterX: centerx, CenterY: centery, Dir: dir, Dcc: dcc);
}

bool crossCheckPattern(List<_JabBitmap> ch, _JabFinderPattern fp, int hV) {
  final moduleSizeMax = fp.moduleSize * 2.0;

  final gr = _crossCheckPatternCh(ch[1], fp.type, hV, moduleSizeMax, fp.center.x, fp.center.y, 0);
  if (!gr.Success) return false;

  if (fp.type == _fp1 || fp.type == _fp2) {
    final rr = _crossCheckPatternCh(ch[0], fp.type, hV, moduleSizeMax, fp.center.x, fp.center.y, 0);
    if (!rr.Success) return false;

    if (!_checkModuleSize2(rr.ModuleSize, gr.ModuleSize)) return false;
    fp.moduleSize = (rr.ModuleSize + gr.ModuleSize) / 2.0;
    fp.center = _JabPoint((rr.CenterX + gr.CenterX) / 2.0, (rr.CenterY + gr.CenterY) / 2.0);

    final coreColorInBlueChannel = _jabDefaultPalette[_fp2CoreColor * 3 + 2];
    if (!_crossCheckColor(ch[2], coreColorInBlueChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 0)) {
      return false;
    }
    if (!_crossCheckColor(ch[2], coreColorInBlueChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 1)) {
      return false;
    }
    if (!_crossCheckColor(ch[2], coreColorInBlueChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 2)) {
      return false;
    }

    if (rr.Dcc == 2 || gr.Dcc == 2) {
      fp.direction = 2;
    } else {
      fp.direction = (rr.Dir + gr.Dir) > 0 ? 1 : -1;
    }
  }

  if (fp.type == _fp0 || fp.type == _fp3) {
    final br = _crossCheckPatternCh(ch[2], fp.type, hV, moduleSizeMax, fp.center.x, fp.center.y, 0);
    if (!br.Success) return false;

    if (!_checkModuleSize2(gr.ModuleSize, br.ModuleSize)) return false;
    fp.moduleSize = (gr.ModuleSize + br.ModuleSize) / 2.0;
    fp.center = _JabPoint((gr.CenterX + br.CenterX) / 2.0, (gr.CenterY + br.CenterY) / 2.0);

    final coreColorInRedChannel = _jabDefaultPalette[_fp3CoreColor * 3 + 0];
    if (!_crossCheckColor(ch[0], coreColorInRedChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 0)) {
      return false;
    }
    if (!_crossCheckColor(ch[0], coreColorInRedChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 1)) {
      return false;
    }
    if (!_crossCheckColor(ch[0], coreColorInRedChannel, fp.moduleSize.toInt(), 5,
        fp.center.x.toInt(), fp.center.y.toInt(), 2)) {
      return false;
    }

    if (gr.Dcc == 2 || br.Dcc == 2) {
      fp.direction = 2;
    } else {
      fp.direction = (gr.Dir + br.Dir) > 0 ? 1 : -1;
    }
  }
  return true;
}

int _saveAlignmentPattern(_JabFinderPattern ap, List<_JabFinderPattern> aps) {
  for (int i = 0; i < aps.length; i++) {
    if (aps[i].foundCount > 0) {
      if ((ap.center.x - aps[i].center.x).abs() <= ap.moduleSize &&
          (ap.center.y - aps[i].center.y).abs() <= ap.moduleSize &&
          ((ap.moduleSize - aps[i].moduleSize).abs() <= aps[i].moduleSize ||
          (ap.moduleSize - aps[i].moduleSize).abs() <= 1.0) && ap.type == aps[i].type) {
        aps[i].center = _JabPoint(
            (aps[i].foundCount * aps[i].center.x + ap.center.x) / (aps[i].foundCount + 1),
            (aps[i].foundCount * aps[i].center.y + ap.center.y) / (aps[i].foundCount + 1));
        aps[i].moduleSize = (aps[i].foundCount * aps[i].moduleSize + ap.moduleSize) / (aps[i].foundCount + 1);
        aps[i].foundCount++;
        return i;
      }
    }
  }
  aps.add(ap.clone());
  return -1;
}

void _saveFinderPattern(_JabFinderPattern fp, List<_JabFinderPattern> fps) {
  for (int i = 0; i < fps.length; i++) {
    if (fps[i].foundCount > 0) {
      if ((fp.center.x - fps[i].center.x).abs() <= fp.moduleSize &&
          (fp.center.y - fps[i].center.y).abs() <= fp.moduleSize &&
          ((fp.moduleSize - fps[i].moduleSize).abs() <= fps[i].moduleSize ||
              (fp.moduleSize - fps[i].moduleSize).abs() <= 1.0) &&
          fp.type == fps[i].type) {
        fps[i].center = _JabPoint(
            (fps[i].foundCount * fps[i].center.x + fp.center.x) / (fps[i].foundCount + 1),
            (fps[i].foundCount * fps[i].center.y + fp.center.y) / (fps[i].foundCount + 1));
        fps[i].moduleSize =
            (fps[i].foundCount * fps[i].moduleSize + fp.moduleSize) / (fps[i].foundCount + 1);
        fps[i].foundCount++;
        fps[i].direction += fp.direction;
        return;
      }
    }
  }
  fps.add(fp.clone());
}

_JabFinderPattern _getBestPattern(List<_JabFinderPattern> fps) {
  int counter = 0;
  double totalModuleSize = 0;
  for (int i = 0; i < fps.length; i++) {
    if (fps[i].foundCount > 0) {
      counter++;
      totalModuleSize += fps[i].moduleSize;
    }
  }
  final mean = totalModuleSize / counter;

  int maxFoundCount = 0;
  double minDiff = 100;
  int maxFoundCountIndex = 0;
  for (int i = 0; i < fps.length; i++) {
    if (fps[i].foundCount > 0) {
      if (fps[i].foundCount > maxFoundCount) {
        maxFoundCount = fps[i].foundCount;
        maxFoundCountIndex = i;
        minDiff = (fps[i].moduleSize - mean).abs();
      } else if (fps[i].foundCount == maxFoundCount) {
        if ((fps[i].moduleSize - mean).abs() < minDiff) {
          maxFoundCountIndex = i;
          minDiff = (fps[i].moduleSize - mean).abs();
        }
      }
    }
  }
  final fp = fps[maxFoundCountIndex].clone();
  fps[maxFoundCountIndex].foundCount = 0;
  return fp;
}

int _selectBestPatterns(List<_JabFinderPattern> fps) {
  final fps0 = <_JabFinderPattern>[];
  final fps1 = <_JabFinderPattern>[];
  final fps2 = <_JabFinderPattern>[];
  final fps3 = <_JabFinderPattern>[];

  for (int i = 0; i < fps.length; i++) {
    if (fps[i].foundCount < 3) continue;
    switch (fps[i].type) {
      case _fp0:
        fps0.add(fps[i]);
        break;
      case _fp1:
        fps1.add(fps[i]);
        break;
      case _fp2:
        fps2.add(fps[i]);
        break;
      case _fp3:
        fps3.add(fps[i]);
        break;
    }
  }

  final result = List<_JabFinderPattern>.generate(4, (_) => _JabFinderPattern());

  if (fps0.length > 1) {
    result[0] = _getBestPattern(fps0);
  } else if (fps0.length == 1) {
    result[0] = fps0[0].clone();
  }
  if (fps1.length > 1) {
    result[1] = _getBestPattern(fps1);
  } else if (fps1.length == 1) {
    result[1] = fps1[0].clone();
  }
  if (fps2.length > 1) {
    result[2] = _getBestPattern(fps2);
  } else if (fps2.length == 1) {
    result[2] = fps2[0].clone();
  }
  if (fps3.length > 1) {
    result[3] = _getBestPattern(fps3);
  } else if (fps3.length == 1) {
    result[3] = fps3[0].clone();
  }

  int maxFoundCount = 0;
  for (int i = 0; i < 4; i++) {
    if (result[i].foundCount > maxFoundCount) maxFoundCount = result[i].foundCount;
  }
  for (int i = 0; i < 4; i++) {
    if (result[i].foundCount > 0) {
      if (result[i].foundCount < (0.5 * maxFoundCount)) {
        result[i] = _JabFinderPattern();
      }
    }
  }

  for (int i = 0; i < 4; i++) {
    if (i < fps.length) {
      fps[i] = result[i];
    } else {
      fps.add(result[i]);
    }
  }

  int missingFpCount = 0;
  for (int i = 0; i < 4; i++) {
    if (fps[i].foundCount == 0) missingFpCount++;
  }
  return missingFpCount;
}

void _scanPatternVertical(List<_JabBitmap> ch, int minModuleSize, List<_JabFinderPattern> fps) {
  bool done = false;

  for (int j = 0; j < ch[0].width && !done; j += minModuleSize) {
    int starty = 0;
    int endy = ch[0].height;
    int skip = 0;

    do {
      int typeR = 0, typeG = 0, typeB = 0;
      double centeryR = 0, centeryG, centeryB = 0;
      double moduleSizeR = 0, moduleSizeG, moduleSizeB = 0;
      bool finderPattern1Found = false;
      bool finderPattern2Found = false;

      starty += skip;
      endy = ch[0].height;

      final gr = _seekPattern(ch[1], -1, j, starty, endy);
      final gFound = gr.Success;
      starty = gr.Start;
      endy = gr.End;
      centeryG = gr.Center;
      moduleSizeG = gr.ModuleSize;
      skip = gr.Skip ?? skip;

      if (gFound) {
        typeG = ch[1].pixel[centeryG.toInt() * ch[0].width + j] > 0 ? 255 : 0;
        centeryR = centeryG;
        centeryB = centeryG;

        final bcr = _crossCheckPatternVertical(ch[2], moduleSizeG * 2, j.toDouble(), centeryB);
        if (bcr.Success) {
          centeryB = bcr.CenterY;
          moduleSizeB = bcr.ModuleSize;
          typeB = ch[2].pixel[centeryB.toInt() * ch[2].width + j] > 0 ? 255 : 0;
          moduleSizeR = moduleSizeG;
          final coreColorInRedChannel = _jabDefaultPalette[_fp3CoreColor * 3 + 0];
          if (_crossCheckColor(ch[0], coreColorInRedChannel, moduleSizeR.toInt(), 5, j, centeryR.toInt(), 1)) {
            typeR = 0;
            finderPattern1Found = true;
          }
        } else {
          final rcr = _crossCheckPatternVertical(ch[0], moduleSizeG * 2, j.toDouble(), centeryR);
          if (rcr.Success) {
            centeryR = rcr.CenterY;
            moduleSizeR = rcr.ModuleSize;
            typeR = ch[0].pixel[centeryR.toInt() * ch[0].width + j] > 0 ? 255 : 0;
            moduleSizeB = moduleSizeG;
            final coreColorInBlueChannel = _jabDefaultPalette[_fp2CoreColor * 3 + 2];
            if (_crossCheckColor(
                ch[2], coreColorInBlueChannel, moduleSizeB.toInt(), 5, j, centeryB.toInt(), 1)) {
              typeB = 0;
              finderPattern2Found = true;
            }
          }
        }

        if (finderPattern1Found || finderPattern2Found) {
          final fp = _JabFinderPattern();
          fp.center = _JabPoint(j.toDouble(), 0);
          fp.foundCount = 1;
          bool skipCandidate = false;
          if (finderPattern1Found) {
            if (!_checkModuleSize2(moduleSizeG, moduleSizeB)) {
              skipCandidate = true;
            } else {
              fp.center = _JabPoint(j.toDouble(), (centeryG + centeryB) / 2.0);
              fp.moduleSize = (moduleSizeG + moduleSizeB) / 2.0;
              if (typeR == _jabDefaultPalette[_fp0CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp0CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp0CoreColor * 3 + 2]) {
                fp.type = _fp0;
              } else if (typeR == _jabDefaultPalette[_fp3CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp3CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp3CoreColor * 3 + 2]) {
                fp.type = _fp3;
              } else {
                skipCandidate = true;
              }
            }
          } else if (finderPattern2Found) {
            if (!_checkModuleSize2(moduleSizeR, moduleSizeG)) {
              skipCandidate = true;
            } else {
              fp.center = _JabPoint(j.toDouble(), (centeryR + centeryG) / 2.0);
              fp.moduleSize = (moduleSizeR + moduleSizeG) / 2.0;
              if (typeR == _jabDefaultPalette[_fp1CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp1CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp1CoreColor * 3 + 2]) {
                fp.type = _fp1;
              } else if (typeR == _jabDefaultPalette[_fp2CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp2CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp2CoreColor * 3 + 2]) {
                fp.type = _fp2;
              } else {
                skipCandidate = true;
              }
            }
          }

          if (!skipCandidate) {
            if (crossCheckPattern(ch, fp, 1)) {
              _saveFinderPattern(fp, fps);
              if (fps.length >= (_maxFinderPatterns - 1)) {
                done = true;
                break;
              }
            }
          }
        }
      }
    } while (starty < ch[0].height && endy < ch[0].height);
  }
}

void _seekMissingFinderPattern(_JabBitmap bitmap, List<_JabFinderPattern> fps, int missFpIndex) {
  final radius = fps[missFpIndex].moduleSize * 5;
  final startX = (fps[missFpIndex].center.x - radius) >= 0
      ? (fps[missFpIndex].center.x - radius).toInt()
      : 0;
  final startY = (fps[missFpIndex].center.y - radius) >= 0
      ? (fps[missFpIndex].center.y - radius).toInt()
      : 0;
  final endX = (fps[missFpIndex].center.x + radius) <= (bitmap.width - 1)
      ? (fps[missFpIndex].center.x + radius).toInt()
      : (bitmap.width - 1);
  final endY = (fps[missFpIndex].center.y + radius) <= (bitmap.height - 1)
      ? (fps[missFpIndex].center.y + radius).toInt()
      : (bitmap.height - 1);
  final areaWidth = endX - startX;
  final areaHeight = endY - startY;
  if (areaWidth <= 0 || areaHeight <= 0) return;

  final rgb = List<_JabBitmap>.generate(
      3,
      (_) => _JabBitmap(
          width: areaWidth, height: areaHeight, bitsPerChannel: 8, bitsPerPixel: 8, channelCount: 1));

  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final bytesPerRow = bitmap.width * bytesPerPixel;
  final pixelSum = [0.0, 0.0, 0.0];
  for (int i = startY; i < endY; i++) {
    for (int j = startX; j < endX; j++) {
      final offset = i * bytesPerRow + j * bytesPerPixel;
      pixelSum[0] += bitmap.pixel[offset + 0];
      pixelSum[1] += bitmap.pixel[offset + 1];
      pixelSum[2] += bitmap.pixel[offset + 2];
    }
  }
  final pixelAve = [
    pixelSum[0] / (areaWidth * areaHeight),
    pixelSum[1] / (areaWidth * areaHeight),
    pixelSum[2] / (areaWidth * areaHeight),
  ];

  for (int i = startY, y = 0; i < endY; i++, y++) {
    for (int j = startX, x = 0; j < endX; j++, x++) {
      final offset = i * bytesPerRow + j * bytesPerPixel;
      if (bitmap.pixel[offset + 0] < pixelAve[0] &&
          bitmap.pixel[offset + 1] < pixelAve[1] &&
          bitmap.pixel[offset + 2] < pixelAve[2]) {
        rgb[0].pixel[y * areaWidth + x] = 0;
        rgb[1].pixel[y * areaWidth + x] = 0;
        rgb[2].pixel[y * areaWidth + x] = 0;
      } else if (bitmap.pixel[offset + 0] < bitmap.pixel[offset + 2]) {
        rgb[0].pixel[y * areaWidth + x] = 0;
        rgb[1].pixel[y * areaWidth + x] = 255;
        rgb[2].pixel[y * areaWidth + x] = 255;
      } else {
        rgb[0].pixel[y * areaWidth + x] = 255;
        rgb[1].pixel[y * areaWidth + x] = 255;
        rgb[2].pixel[y * areaWidth + x] = 0;
      }
    }
  }

  int expTypeR = 0, expTypeG = 0, expTypeB = 0;
  switch (missFpIndex) {
    case 0:
    case 1:
      expTypeR = 0;
      expTypeG = 0;
      expTypeB = 0;
      break;
    case 2:
      expTypeR = 255;
      expTypeG = 255;
      expTypeB = 0;
      break;
    case 3:
      expTypeR = 0;
      expTypeG = 255;
      expTypeB = 255;
      break;
  }

  final fpsMiss = <_JabFinderPattern>[];
  bool done = false;

  for (int i = 0; i < areaHeight && !done; i++) {
    final rowR = List<int>.generate(rgb[0].width, (k) => rgb[0].pixel[i * rgb[0].width + k]);
    final rowG = List<int>.generate(rgb[1].width, (k) => rgb[1].pixel[i * rgb[1].width + k]);
    final rowB = List<int>.generate(rgb[2].width, (k) => rgb[2].pixel[i * rgb[2].width + k]);

    int startx = 0;
    int endx = rgb[0].width;
    int skip = 0;

    do {
      final fp = _JabFinderPattern();
      int typeR = 0, typeG, typeB = 0;
      double centerxR = 0, centerxB = 0;
      double moduleSizeR = 0, moduleSizeG, moduleSizeB = 0;
      bool finderPatternFound = false;

      startx += skip;
      endx = rgb[0].width;

      final gr = _seekPatternHorizontal(rowG, startx, endx);
      final gFound = gr.Success;
      startx = gr.StartX;
      endx = gr.EndX;
      moduleSizeG = gr.ModuleSize;
      skip = gr.Skip ?? skip;

      if (gFound) {
        typeG = rowG[gr.CenterX.toInt()] > 0 ? 255 : 0;
        if (typeG != expTypeG) continue;

        centerxR = gr.CenterX;
        centerxB = gr.CenterX;
        bool skipCandidate = false;
        switch (missFpIndex) {
          case 0:
          case 3:
            final bcr = _crossCheckPatternHorizontal(rgb[2], moduleSizeG * 2, centerxB, i.toDouble());
            if (bcr.Success) {
              centerxB = bcr.CenterX;
              moduleSizeB = bcr.ModuleSize;
              typeB = rowB[centerxB.toInt()] > 0 ? 255 : 0;
              if (typeB != expTypeB) {
                skipCandidate = true;
              } else {
                moduleSizeR = moduleSizeG;
                final coreColorInRedChannel = _jabDefaultPalette[_fp3CoreColor * 3 + 0];
                if (_crossCheckColor(rgb[0], coreColorInRedChannel, moduleSizeR.toInt(), 5,
                    centerxR.toInt(), i, 0)) {
                  typeR = 0;
                  finderPatternFound = true;
                }
              }
            }
            if (!skipCandidate && finderPatternFound) {
              if (!_checkModuleSize2(moduleSizeG, moduleSizeB)) {
                skipCandidate = true;
              } else {
                fp.center = _JabPoint((gr.CenterX + centerxB) / 2.0, 0);
                fp.moduleSize = (moduleSizeG + moduleSizeB) / 2.0;
              }
            }
            break;
          case 1:
          case 2:
            final rcr = _crossCheckPatternHorizontal(rgb[0], moduleSizeG * 2, centerxR, i.toDouble());
            if (rcr.Success) {
              centerxR = rcr.CenterX;
              moduleSizeR = rcr.ModuleSize;
              typeR = rowR[centerxR.toInt()] > 0 ? 255 : 0;
              if (typeR != expTypeR) {
                skipCandidate = true;
              } else {
                moduleSizeB = moduleSizeG;
                final coreColorInBlueChannel = _jabDefaultPalette[_fp2CoreColor * 3 + 2];
                if (_crossCheckColor(rgb[2], coreColorInBlueChannel, moduleSizeB.toInt(), 5,
                    centerxB.toInt(), i, 0)) {
                  typeB = 0;
                  finderPatternFound = true;
                }
              }
            }
            if (!skipCandidate && finderPatternFound) {
              if (!_checkModuleSize2(moduleSizeR, moduleSizeG)) {
                skipCandidate = true;
              } else {
                fp.center = _JabPoint((centerxR + gr.CenterX) / 2.0, 0);
                fp.moduleSize = (moduleSizeR + moduleSizeG) / 2.0;
              }
            }
            break;
        }

        if (!skipCandidate && finderPatternFound) {
          fp.center = _JabPoint(fp.center.x, i.toDouble());
          fp.foundCount = 1;
          fp.type = missFpIndex;
          if (crossCheckPattern(rgb, fp, 0)) {
            _saveFinderPattern(fp, fpsMiss);
            if (fpsMiss.length >= (_maxFinderPatterns - 1)) {
              done = true;
              break;
            }
          }
        }
      }
    } while (startx < rgb[0].width && endx < rgb[0].width);
  }

  if (fpsMiss.isNotEmpty) {
    int maxFound = 0;
    int maxIndex = 0;
    for (int i = 0; i < fpsMiss.length; i++) {
      if (fpsMiss[i].foundCount > maxFound) {
        maxFound = fpsMiss[i].foundCount;
        maxIndex = i;
      }
    }
    fps[missFpIndex] = fpsMiss[maxIndex].clone();
    fps[missFpIndex].center =
        _JabPoint(fps[missFpIndex].center.x + startX, fps[missFpIndex].center.y + startY);
  }
}

({bool Success, List<_JabFinderPattern> Fps}) _findMasterSymbol(_JabBitmap bitmap, List<_JabBitmap> ch, int mode) {
  int minModuleSize = ch[0].height ~/ (2 * _maxSymbolRows * _maxModules);
  if (minModuleSize < 1 || mode == _JabDetectMode.intensive) minModuleSize = 1;

  final fps = <_JabFinderPattern>[];
  bool done = false;

  for (int i = 0; i < ch[0].height && !done; i += minModuleSize) {
    final rowR = List<int>.generate(ch[0].width, (k) => ch[0].pixel[i * ch[0].width + k]);
    final rowG = List<int>.generate(ch[1].width, (k) => ch[1].pixel[i * ch[1].width + k]);
    final rowB = List<int>.generate(ch[2].width, (k) => ch[2].pixel[i * ch[2].width + k]);

    int startx = 0;
    int endx = ch[0].width;
    int skip = 0;

    do {
      int typeR = 0, typeG, typeB = 0;
      double centerxR = 0, centerxB = 0;
      double moduleSizeR = 0, moduleSizeB = 0;
      bool finderPattern1Found = false;
      bool finderPattern2Found = false;

      startx += skip;
      endx = ch[0].width;

      final gr = _seekPatternHorizontal(rowG, startx, endx);
      startx = gr.StartX;
      endx = gr.EndX;
      skip = gr.Skip ?? skip;

      if (gr.Success) {
        typeG = rowG[gr.CenterX.toInt()] > 0 ? 255 : 0;
        centerxR = gr.CenterX;
        centerxB = gr.CenterX;

        final bcr = _crossCheckPatternHorizontal(ch[2], gr.ModuleSize * 2, centerxB, i.toDouble());
        if (bcr.Success) {
          centerxB = bcr.CenterX;
          moduleSizeB = bcr.ModuleSize;
          typeB = rowB[centerxB.toInt()] > 0 ? 255 : 0;
          moduleSizeR = gr.ModuleSize;
          final coreColorInRedChannel = _jabDefaultPalette[_fp3CoreColor * 3 + 0];
          if (_crossCheckColor(
              ch[0], coreColorInRedChannel, moduleSizeR.toInt(), 5, centerxR.toInt(), i, 0)) {
            typeR = 0;
            finderPattern1Found = true;
          }
        } else {
          final rcr = _crossCheckPatternHorizontal(ch[0], gr.ModuleSize * 2, centerxR, i.toDouble());
          if (rcr.Success) {
            centerxR = rcr.CenterX;
            moduleSizeR = rcr.ModuleSize;
            typeR = rowR[centerxR.toInt()] > 0 ? 255 : 0;
            moduleSizeB = gr.ModuleSize;
            final coreColorInBlueChannel = _jabDefaultPalette[_fp2CoreColor * 3 + 2];
            if (_crossCheckColor(
                ch[2], coreColorInBlueChannel, moduleSizeB.toInt(), 5, centerxB.toInt(), i, 0)) {
              typeB = 0;
              finderPattern2Found = true;
            }
          }
        }

        if (finderPattern1Found || finderPattern2Found) {
          final fp = _JabFinderPattern();
          fp.center = _JabPoint(0, i.toDouble());
          fp.foundCount = 1;
          bool skipCandidate = false;
          if (finderPattern1Found) {
            if (!_checkModuleSize2(gr.ModuleSize, moduleSizeB)) {
              skipCandidate = true;
            } else {
              fp.center = _JabPoint((gr.CenterX + centerxB) / 2.0, i.toDouble());
              fp.moduleSize = (gr.ModuleSize + moduleSizeB) / 2.0;
              if (typeR == _jabDefaultPalette[_fp0CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp0CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp0CoreColor * 3 + 2]) {
                fp.type = _fp0;
              } else if (typeR == _jabDefaultPalette[_fp3CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp3CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp3CoreColor * 3 + 2]) {
                fp.type = _fp3;
              } else {
                skipCandidate = true;
              }
            }
          } else if (finderPattern2Found) {
            if (!_checkModuleSize2(moduleSizeR, gr.ModuleSize)) {
              skipCandidate = true;
            } else {
              fp.center = _JabPoint((centerxR + gr.CenterX) / 2.0, i.toDouble());
              fp.moduleSize = (moduleSizeR + gr.ModuleSize) / 2.0;
              if (typeR == _jabDefaultPalette[_fp1CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp1CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp1CoreColor * 3 + 2]) {
                fp.type = _fp1;
              } else if (typeR == _jabDefaultPalette[_fp2CoreColor * 3] &&
                  typeG == _jabDefaultPalette[_fp2CoreColor * 3 + 1] &&
                  typeB == _jabDefaultPalette[_fp2CoreColor * 3 + 2]) {
                fp.type = _fp2;
              } else {
                skipCandidate = true;
              }
            }
          }

          if (!skipCandidate) {
            if (crossCheckPattern(ch, fp, 0)) {
              _saveFinderPattern(fp, fps);
              if (fps.length >= (_maxFinderPatterns - 1)) {
                done = true;
                break;
              }
            }
          }
        }
      }
    } while (startx < ch[0].width && endx < ch[0].width);
  }

  bool found(int type) => fps.any((fp) => fp.type == type);
  if ((found(0) && found(1) && !found(2) && !found(3)) || (!found(0) && !found(1) && found(2) && found(3))) {
    _scanPatternVertical(ch, minModuleSize, fps);
  }

  for (int i = 0; i < fps.length; i++) {
    fps[i].direction = fps[i].direction >= 0 ? 1 : -1;
  }

  final missingFpCount = _selectBestPatterns(fps);

  if (missingFpCount > 1) {
    return (Success: false, Fps: fps); // "Too few finder pattern found"
  }

  if (missingFpCount == 1) {
    int missFp = 0;
    if (fps[0].foundCount == 0) {
      missFp = 0;
      final aveSizeFp23 = (fps[2].moduleSize + fps[3].moduleSize) / 2.0;
      final aveSizeFp13 = (fps[1].moduleSize + fps[3].moduleSize) / 2.0;
      fps[0].center = _JabPoint(
          (fps[3].center.x - fps[2].center.x) / aveSizeFp23 * aveSizeFp13 + fps[1].center.x,
          (fps[3].center.y - fps[2].center.y) / aveSizeFp23 * aveSizeFp13 + fps[1].center.y);
      fps[0].type = _fp0;
      fps[0].foundCount = 1;
      fps[0].direction = -fps[1].direction;
      fps[0].moduleSize = (fps[1].moduleSize + fps[2].moduleSize + fps[3].moduleSize) / 3.0;
    } else if (fps[1].foundCount == 0) {
      missFp = 1;
      final aveSizeFp23 = (fps[2].moduleSize + fps[3].moduleSize) / 2.0;
      final aveSizeFp02 = (fps[0].moduleSize + fps[2].moduleSize) / 2.0;
      fps[1].center = _JabPoint(
          (fps[2].center.x - fps[3].center.x) / aveSizeFp23 * aveSizeFp02 + fps[0].center.x,
          (fps[2].center.y - fps[3].center.y) / aveSizeFp23 * aveSizeFp02 + fps[0].center.y);
      fps[1].type = _fp1;
      fps[1].foundCount = 1;
      fps[1].direction = -fps[0].direction;
      fps[1].moduleSize = (fps[0].moduleSize + fps[2].moduleSize + fps[3].moduleSize) / 3.0;
    } else if (fps[2].foundCount == 0) {
      missFp = 2;
      final aveSizeFp01 = (fps[0].moduleSize + fps[1].moduleSize) / 2.0;
      final aveSizeFp13 = (fps[1].moduleSize + fps[3].moduleSize) / 2.0;
      fps[2].center = _JabPoint(
          (fps[1].center.x - fps[0].center.x) / aveSizeFp01 * aveSizeFp13 + fps[3].center.x,
          (fps[1].center.y - fps[0].center.y) / aveSizeFp01 * aveSizeFp13 + fps[3].center.y);
      fps[2].type = _fp2;
      fps[2].foundCount = 1;
      fps[2].direction = fps[3].direction;
      fps[2].moduleSize = (fps[0].moduleSize + fps[1].moduleSize + fps[3].moduleSize) / 3.0;
    } else if (fps[3].foundCount == 0) {
      missFp = 3;
      final aveSizeFp01 = (fps[0].moduleSize + fps[1].moduleSize) / 2.0;
      final aveSizeFp02 = (fps[0].moduleSize + fps[2].moduleSize) / 2.0;
      fps[3].center = _JabPoint(
          (fps[0].center.x - fps[1].center.x) / aveSizeFp01 * aveSizeFp02 + fps[2].center.x,
          (fps[0].center.y - fps[1].center.y) / aveSizeFp01 * aveSizeFp02 + fps[2].center.y);
      fps[3].type = _fp3;
      fps[3].foundCount = 1;
      fps[3].direction = fps[2].direction;
      fps[3].moduleSize = (fps[0].moduleSize + fps[1].moduleSize + fps[2].moduleSize) / 3.0;
    }

    if (fps[missFp].center.x < 0 ||
        fps[missFp].center.x > ch[0].width - 1 ||
        fps[missFp].center.y < 0 ||
        fps[missFp].center.y > ch[0].height - 1) {
      fps[missFp].foundCount = 0;
      return (Success: false, Fps: fps); // "Finder pattern out of image"
    }

    _seekMissingFinderPattern(bitmap, fps, missFp);
  }

  return (Success: true, Fps: fps);
}

int _apCoreColor(int apType, int channel) {
  switch (apType) {
    case _ap0:
      return _jabDefaultPalette[_ap0CoreColor * 3 + channel];
    case _ap1:
      return _jabDefaultPalette[_ap1CoreColor * 3 + channel];
    case _ap2:
      return _jabDefaultPalette[_ap2CoreColor * 3 + channel];
    case _ap3:
      return _jabDefaultPalette[_ap3CoreColor * 3 + channel];
    case _apx:
      return _jabDefaultPalette[_apxCoreColor * 3 + channel];
    default:
      return -1;
  }
}

({double CenterY, int Dir}) _crossCheckPatternDiagonalAP(
    _JabBitmap image, int apType, double moduleSizeMax, _JabPoint center, int dirIn) {
  int dir = dirIn;
  int offsetX, offsetY;
  bool fixDir = false;

  if (dir != 0) {
    if (dir > 0) {
      offsetX = -1;
      offsetY = -1;
      dir = 1;
    } else {
      offsetX = 1;
      offsetY = -1;
      dir = -1;
    }
    fixDir = true;
  } else {
    if (apType == _ap0 || apType == _ap1) {
      offsetX = -1;
      offsetY = -1;
      dir = 1;
    } else {
      offsetX = 1;
      offsetY = -1;
      dir = -1;
    }
  }

  bool flag = false;
  int tryCount = 0;
  do {
    flag = false;
    tryCount++;

    final stateCount = List<int>.filled(3, 0);
    final startx = center.x.toInt();
    final starty = center.y.toInt();
    int i = 0, stateIndex;

    stateCount[1]++;
    stateIndex = 0;
    for (i = 1; i <= starty && i <= startx && stateIndex <= 1; i++) {
      if (image.pixel[(starty + i * offsetY) * image.width + (startx + i * offsetX)] ==
          image.pixel[(starty + (i - 1) * offsetY) * image.width + (startx + (i - 1) * offsetX)]) {
        stateCount[1 - stateIndex]++;
      } else {
        if (stateIndex > 0 && stateCount[1 - stateIndex] < 3) {
          stateCount[1 - (stateIndex - 1)] += stateCount[1 - stateIndex];
          stateCount[1 - stateIndex] = 0;
          stateIndex--;
          stateCount[1 - stateIndex]++;
        } else {
          stateIndex++;
          if (stateIndex > 1) break;
          stateCount[1 - stateIndex]++;
        }
      }
    }
    if (stateIndex < 1) {
      if (tryCount == 1) {
        flag = true;
        offsetX = -offsetX;
        dir = -dir;
      } else {
        return (CenterY: -1.0, Dir: dir);
      }
    }

    if (!flag) {
      stateIndex = 0;
      for (i = 1;
          (starty + i) < image.height && (startx + i) < image.width && stateIndex <= 1;
          i++) {
        if (image.pixel[(starty - i * offsetY) * image.width + (startx - i * offsetX)] ==
            image.pixel[
                (starty - (i - 1) * offsetY) * image.width + (startx - (i - 1) * offsetX)]) {
          stateCount[1 + stateIndex]++;
        } else {
          if (stateIndex > 0 && stateCount[1 + stateIndex] < 3) {
            stateCount[1 + (stateIndex - 1)] += stateCount[1 + stateIndex];
            stateCount[1 + stateIndex] = 0;
            stateIndex--;
            stateCount[1 + stateIndex]++;
          } else {
            stateIndex++;
            if (stateIndex > 1) break;
            stateCount[1 + stateIndex]++;
          }
        }
      }
      if (stateIndex < 1) {
        if (tryCount == 1) {
          flag = true;
          offsetX = -offsetX;
          dir = -dir;
        } else {
          return (CenterY: -1.0, Dir: dir);
        }
      }
    }

    if (!flag) {
      if (stateCount[1] < moduleSizeMax &&
          stateCount[0] > 0.5 * stateCount[1] &&
          stateCount[2] > 0.5 * stateCount[1]) {
        final newCentery = (starty + i - stateCount[2]) - stateCount[1] / 2.0;
        return (CenterY: newCentery, Dir: dir);
      } else {
        flag = true;
        offsetX = -offsetX;
        dir = -dir;
      }
    }
  } while (flag && tryCount < 2 && !fixDir);

  return (CenterY: -1.0, Dir: dir);
}

({double CenterY, double ModuleSize}) _crossCheckPatternVerticalAP(_JabBitmap image, _JabPoint center, double moduleSizeMax) {
  final stateCount = List<int>.filled(3, 0);
  final centerx = center.x.toInt();
  final centery = center.y.toInt();
  int i, stateIndex;
  double moduleSize = 0;

  stateCount[1]++;
  stateIndex = 0;
  for (i = 1; i <= centery && stateIndex <= 1; i++) {
    if (image.pixel[(centery - i) * image.width + centerx] ==
        image.pixel[(centery - (i - 1)) * image.width + centerx]) {
      stateCount[1 - stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[1 - stateIndex] < 3) {
        stateCount[1 - (stateIndex - 1)] += stateCount[1 - stateIndex];
        stateCount[1 - stateIndex] = 0;
        stateIndex--;
        stateCount[1 - stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > 1) break;
        stateCount[1 - stateIndex]++;
      }
    }
  }
  if (stateIndex < 1) return (CenterY: -1.0, ModuleSize: moduleSize);
  stateIndex = 0;
  for (i = 1; (centery + i) < image.height && stateIndex <= 1; i++) {
    if (image.pixel[(centery + i) * image.width + centerx] ==
        image.pixel[(centery + (i - 1)) * image.width + centerx]) {
      stateCount[1 + stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[1 + stateIndex] < 3) {
        stateCount[1 + (stateIndex - 1)] += stateCount[1 + stateIndex];
        stateCount[1 + stateIndex] = 0;
        stateIndex--;
        stateCount[1 + stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > 1) break;
        stateCount[1 + stateIndex]++;
      }
    }
  }
  if (stateIndex < 1) return (CenterY: -1.0, ModuleSize: moduleSize);

  if (stateCount[1] < moduleSizeMax &&
      stateCount[0] > 0.5 * stateCount[1] &&
      stateCount[2] > 0.5 * stateCount[1]) {
    moduleSize = stateCount[1].toDouble();
    final newCentery = (centery + i - stateCount[2]) - stateCount[1] / 2.0;
    return (CenterY: newCentery, ModuleSize: moduleSize);
  }
  return (CenterY: -1.0, ModuleSize: moduleSize);
}

({double CenterX, double ModuleSize}) crossCheckPatternHorizontalAP(List<int> row, int channel, int startx, int endx,
    int centerxIn, int apType, double moduleSizeMax) {
  final coreColor = _apCoreColor(apType, channel);
  if (row[centerxIn] != coreColor) return (CenterX: -1.0, ModuleSize: 0.0);

  final stateCount = List<int>.filled(3, 0);
  int i, stateIndex;
  double moduleSize = 0;

  stateCount[1]++;
  stateIndex = 0;
  for (i = 1; (centerxIn - i) >= startx && stateIndex <= 1; i++) {
    if (row[centerxIn - i] == row[centerxIn - (i - 1)]) {
      stateCount[1 - stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[1 - stateIndex] < 3) {
        stateCount[1 - (stateIndex - 1)] += stateCount[1 - stateIndex];
        stateCount[1 - stateIndex] = 0;
        stateIndex--;
        stateCount[1 - stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > 1) break;
        stateCount[1 - stateIndex]++;
      }
    }
  }
  if (stateIndex < 1) return (CenterX: -1.0, ModuleSize: moduleSize);

  stateIndex = 0;
  for (i = 1; (centerxIn + i) <= endx && stateIndex <= 1; i++) {
    if (row[centerxIn + i] == row[centerxIn + (i - 1)]) {
      stateCount[1 + stateIndex]++;
    } else {
      if (stateIndex > 0 && stateCount[1 + stateIndex] < 3) {
        stateCount[1 + (stateIndex - 1)] += stateCount[1 + stateIndex];
        stateCount[1 + stateIndex] = 0;
        stateIndex--;
        stateCount[1 + stateIndex]++;
      } else {
        stateIndex++;
        if (stateIndex > 1) break;
        stateCount[1 + stateIndex]++;
      }
    }
  }
  if (stateIndex < 1) return (CenterX: -1.0, ModuleSize: moduleSize);

  if (stateCount[1] < moduleSizeMax &&
      stateCount[0] > 0.5 * stateCount[1] &&
      stateCount[2] > 0.5 * stateCount[1]) {
    moduleSize = stateCount[1].toDouble();
    final newCenterx = (centerxIn + i - stateCount[2]) - stateCount[1] / 2.0;
    return (CenterX: newCenterx, ModuleSize: moduleSize);
  }
  return (CenterX: -1.0, ModuleSize: moduleSize);
}

({bool Success, double CenterX, double CenterY, double ModuleSize, int Dir}) _crossCheckPatternAP(
    List<_JabBitmap> ch, int y, int minx, int maxx, int curX, int apType, double maxModuleSize) {
  List<int> rowOf(_JabBitmap bmp, int yy) =>
      List<int>.generate(bmp.width, (k) => bmp.pixel[yy * bmp.width + k]);

  var rowR = rowOf(ch[0], y);
  var rowB = rowOf(ch[2], y);

  final lCenterx = [0.0, 0.0, 0.0];
  final lCentery = [0.0, 0.0, 0.0];
  final lModuleSizeH = [0.0, 0.0, 0.0];
  final lModuleSizeV = [0.0, 0.0, 0.0];

  var hr = crossCheckPatternHorizontalAP(rowR, 0, minx, maxx, curX, apType, maxModuleSize);
  lCenterx[0] = hr.CenterX;
  lModuleSizeH[0] = hr.ModuleSize;
  if (lCenterx[0] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);

  hr = crossCheckPatternHorizontalAP(rowB, 2, minx, maxx, lCenterx[0].toInt(), apType, maxModuleSize);
  lCenterx[2] = hr.CenterX;
  lModuleSizeH[2] = hr.ModuleSize;
  if (lCenterx[2] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);

  var center = _JabPoint((lCenterx[0] + lCenterx[2]) / 2.0, y.toDouble());
  double moduleSize = (lModuleSizeH[0] + lModuleSizeH[2]) / 2.0;

  final coreColorInGreenChannel = _apCoreColor(apType, 1);
  if (!_crossCheckColor(ch[1], coreColorInGreenChannel, moduleSize.toInt(), 3, center.x.toInt(),
      center.y.toInt(), 0)) {
    return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  }

  var vr = _crossCheckPatternVerticalAP(ch[0], center, maxModuleSize);
  lCentery[0] = vr.CenterY;
  lModuleSizeV[0] = vr.ModuleSize;
  if (lCentery[0] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  rowR = rowOf(ch[0], lCentery[0].toInt());
  hr = crossCheckPatternHorizontalAP(rowR, 0, minx, maxx, center.x.toInt(), apType, maxModuleSize);
  lCenterx[0] = hr.CenterX;
  lModuleSizeH[0] = hr.ModuleSize;
  if (lCenterx[0] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);

  vr = _crossCheckPatternVerticalAP(ch[2], center, maxModuleSize);
  lCentery[2] = vr.CenterY;
  lModuleSizeV[2] = vr.ModuleSize;
  if (lCentery[2] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  rowB = rowOf(ch[2], lCentery[2].toInt());
  hr = crossCheckPatternHorizontalAP(rowB, 2, minx, maxx, center.x.toInt(), apType, maxModuleSize);
  lCenterx[2] = hr.CenterX;
  lModuleSizeH[2] = hr.ModuleSize;
  if (lCenterx[2] < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);

  moduleSize = (lModuleSizeH[0] + lModuleSizeH[2] + lModuleSizeV[0] + lModuleSizeV[2]) / 4.0;
  final centerx = (lCenterx[0] + lCenterx[2]) / 2.0;
  final centery = (lCentery[0] + lCentery[2]) / 2.0;
  center = _JabPoint(centerx, centery);

  if (!_crossCheckColor(ch[1], coreColorInGreenChannel, moduleSize.toInt(), 3, center.x.toInt(),
      center.y.toInt(), 1)) {
    return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  }

  final lDir = [0, 0, 0];
  var dr = _crossCheckPatternDiagonalAP(ch[0], apType, moduleSize * 2, center, 0);
  if (dr.CenterY < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  lDir[0] = dr.Dir;
  dr = _crossCheckPatternDiagonalAP(ch[2], apType, moduleSize * 2, center, 0);
  if (dr.CenterY < 0) return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  lDir[2] = dr.Dir;
  if (!_crossCheckColor(ch[1], coreColorInGreenChannel, moduleSize.toInt(), 3, center.x.toInt(), center.y.toInt(), 2)) {
    return (Success: false, CenterX: 0.0, CenterY: 0.0, ModuleSize: 0.0, Dir: 0);
  }
  final dir = (lDir[0] + lDir[2]) > 0 ? 1 : -1;

  return (Success: true, CenterX: centerx,  CenterY: centery, ModuleSize: moduleSize, Dir: dir);
}

_JabFinderPattern _findAlignmentPattern(List<_JabBitmap> ch, double x, double y, double moduleSize, int apType) {
  final ap = _JabFinderPattern();
  ap.type = -1;
  ap.foundCount = 0;

  final coreColorR = _apCoreColor(apType, 0);

  int radius = (4 * moduleSize).toInt();
  final radiusMax = 4 * radius;

  for (; radius < radiusMax; radius <<= 1) {
    final aps = <_JabFinderPattern>[];

    final startx = max(0, x - radius).toInt();
    final starty = max(0, y - radius).toInt();
    final endx = min(ch[0].width - 1, x + radius).toInt();
    final endy = min(ch[0].height - 1, y + radius).toInt();
    if (endx - startx < 3 * moduleSize || endy - starty < 3 * moduleSize) continue;

    for (int k = starty; k < endy; k++) {
      final kk = k - starty;
      final i = (y + ((kk & 0x01) == 0 ? (kk + 1) / 2 : -((kk + 1) / 2))).toInt();
      if (i < starty || i > endy) continue;

      bool apFound = false;
      int dir = -1;
      int leftTmpx = x.toInt();
      int rightTmpx = x.toInt();
      double centerx = 0, centery = 0, apModuleSize = 0;
      int apDir = 0;

      while ((leftTmpx > startx || rightTmpx < endx) && !apFound) {
        if (dir < 0) {
          while (leftTmpx > startx && ch[0].pixel[i * ch[0].width + leftTmpx] != coreColorR) {
            leftTmpx--;
          }
          if (leftTmpx <= startx) {
            dir = -dir;
            continue;
          }
          final r = _crossCheckPatternAP(ch, i, startx, endx, leftTmpx, apType, moduleSize * 2);
          apFound = r.Success;
          if (apFound) {
            centerx = r.CenterX;
            centery = r.CenterY;
            apModuleSize = r.ModuleSize;
            apDir = r.Dir;
          }
          while (leftTmpx > startx && ch[0].pixel[i * ch[0].width + leftTmpx] == coreColorR) {
            leftTmpx--;
          }
          dir = -dir;
        } else {
          while (rightTmpx < endx && ch[0].pixel[i * ch[0].width + rightTmpx] == coreColorR) {
            rightTmpx++;
          }
          while (rightTmpx < endx && ch[0].pixel[i * ch[0].width + rightTmpx] != coreColorR) {
            rightTmpx++;
          }
          if (rightTmpx >= endx) {
            dir = -dir;
            continue;
          }
          final r = _crossCheckPatternAP(ch, i, startx, endx, rightTmpx, apType, moduleSize * 2);
          apFound = r.Success;
          if (apFound) {
            centerx = r.CenterX;
            centery = r.CenterY;
            apModuleSize = r.ModuleSize;
            apDir = r.Dir;
          }
          while (rightTmpx < endx && ch[0].pixel[i * ch[0].width + rightTmpx] == coreColorR) {
            rightTmpx++;
          }
          dir = -dir;
        }
      }

      if (!apFound) continue;

      ap.center = _JabPoint(centerx, centery);
      ap.moduleSize = apModuleSize;
      ap.direction = apDir;
      ap.type = apType;
      ap.foundCount = 1;

      final index = _saveAlignmentPattern(ap, aps);
      if (index >= 0) {
        return aps[index].clone();
      }
    }
  }
  ap.type = -1;
  ap.foundCount = 0;
  return ap;
}

bool _findSlaveSymbol(_JabBitmap bitmap, List<_JabBitmap> ch, _JabDecodedSymbol hostSymbol,
    _JabDecodedSymbol slaveSymbol, int dockedPosition) {
  final aps = List<_JabFinderPattern>.generate(4, (_) => _JabFinderPattern());

  slaveSymbol.sideSize = _JabVector2d(_version2size(slaveSymbol.metadata.sideVersion.x),
      _version2size(slaveSymbol.metadata.sideVersion.y));

  final distx01 = hostSymbol.patternPositions[1].x - hostSymbol.patternPositions[0].x;
  final disty01 = hostSymbol.patternPositions[1].y - hostSymbol.patternPositions[0].y;
  final distx32 = hostSymbol.patternPositions[2].x - hostSymbol.patternPositions[3].x;
  final disty32 = hostSymbol.patternPositions[2].y - hostSymbol.patternPositions[3].y;
  final distx03 = hostSymbol.patternPositions[3].x - hostSymbol.patternPositions[0].x;
  final disty03 = hostSymbol.patternPositions[3].y - hostSymbol.patternPositions[0].y;
  final distx12 = hostSymbol.patternPositions[2].x - hostSymbol.patternPositions[1].x;
  final disty12 = hostSymbol.patternPositions[2].y - hostSymbol.patternPositions[1].y;

  double alpha1 = 0, alpha2 = 0;
  int sign = 1;
  int dockedSideSize = 0, undockedSideSize = 0;
  int apI1 = 0, apI2 = 0, apI3 = 0, apI4 = 0, hp1 = 0, hp2 = 0;

  switch (dockedPosition) {
    case 3:
      alpha1 = atan2(disty01, distx01);
      alpha2 = atan2(disty32, distx32);
      sign = 1;
      dockedSideSize = slaveSymbol.sideSize.y;
      undockedSideSize = slaveSymbol.sideSize.x;
      apI1 = _ap0;
      apI2 = _ap3;
      apI3 = _ap1;
      apI4 = _ap2;
      hp1 = _fp1;
      hp2 = _fp2;
      slaveSymbol.hostPosition = 2;
      break;
    case 2:
      alpha1 = atan2(disty32, distx32);
      alpha2 = atan2(disty01, distx01);
      sign = -1;
      dockedSideSize = slaveSymbol.sideSize.y;
      undockedSideSize = slaveSymbol.sideSize.x;
      apI1 = _ap2;
      apI2 = _ap1;
      apI3 = _ap3;
      apI4 = _ap0;
      hp1 = _fp3;
      hp2 = _fp0;
      slaveSymbol.hostPosition = 3;
      break;
    case 1:
      alpha1 = atan2(disty12, distx12);
      alpha2 = atan2(disty03, distx03);
      sign = 1;
      dockedSideSize = slaveSymbol.sideSize.x;
      undockedSideSize = slaveSymbol.sideSize.y;
      apI1 = _ap1;
      apI2 = _ap0;
      apI3 = _ap2;
      apI4 = _ap3;
      hp1 = _fp2;
      hp2 = _fp3;
      slaveSymbol.hostPosition = 0;
      break;
    case 0:
      alpha1 = atan2(disty03, distx03);
      alpha2 = atan2(disty12, distx12);
      sign = -1;
      dockedSideSize = slaveSymbol.sideSize.x;
      undockedSideSize = slaveSymbol.sideSize.y;
      apI1 = _ap3;
      apI2 = _ap2;
      apI3 = _ap0;
      apI4 = _ap1;
      hp1 = _fp0;
      hp2 = _fp1;
      slaveSymbol.hostPosition = 1;
      break;
  }

  aps[apI1].center = _JabPoint(
      hostSymbol.patternPositions[hp1].x + sign * 7 * hostSymbol.moduleSize * cos(alpha1),
      hostSymbol.patternPositions[hp1].y + sign * 7 * hostSymbol.moduleSize * sin(alpha1));
  aps[apI1] =
      _findAlignmentPattern(ch, aps[apI1].center.x, aps[apI1].center.y, hostSymbol.moduleSize, apI1);
  if (aps[apI1].foundCount == 0) {
    return false; // "The first alignment pattern in slave symbol not found"
  }

  aps[apI2].center = _JabPoint(
      hostSymbol.patternPositions[hp2].x + sign * 7 * hostSymbol.moduleSize * cos(alpha2),
      hostSymbol.patternPositions[hp2].y + sign * 7 * hostSymbol.moduleSize * sin(alpha2));
  aps[apI2] =
      _findAlignmentPattern(ch, aps[apI2].center.x, aps[apI2].center.y, hostSymbol.moduleSize, apI2);
  if (aps[apI2].foundCount == 0) {
    return false; // "The second alignment pattern in slave symbol not found"
  }

  slaveSymbol.moduleSize = _dist(aps[apI1].center.x, aps[apI1].center.y, aps[apI2].center.x,
          aps[apI2].center.y) /
      (dockedSideSize - 7);

  aps[apI3].center = _JabPoint(
      aps[apI1].center.x + sign * (undockedSideSize - 7) * slaveSymbol.moduleSize * cos(alpha1),
      aps[apI1].center.y + sign * (undockedSideSize - 7) * slaveSymbol.moduleSize * sin(alpha1));
  aps[apI3] = _findAlignmentPattern(
      ch, aps[apI3].center.x, aps[apI3].center.y, slaveSymbol.moduleSize, apI3);

  aps[apI4].center = _JabPoint(
      aps[apI2].center.x + sign * (undockedSideSize - 7) * slaveSymbol.moduleSize * cos(alpha2),
      aps[apI2].center.y + sign * (undockedSideSize - 7) * slaveSymbol.moduleSize * sin(alpha2));
  aps[apI4] = _findAlignmentPattern(
      ch, aps[apI4].center.x, aps[apI4].center.y, slaveSymbol.moduleSize, apI4);

  if (aps[apI3].foundCount == 0 && aps[apI4].foundCount == 0) {
    return false;
  }
  if (aps[apI3].foundCount == 0) {
    final aveSizeAp24 = (aps[apI2].moduleSize + aps[apI4].moduleSize) / 2.0;
    final aveSizeAp14 = (aps[apI1].moduleSize + aps[apI4].moduleSize) / 2.0;
    aps[apI3].center = _JabPoint(
        (aps[apI4].center.x - aps[apI2].center.x) / aveSizeAp24 * aveSizeAp14 + aps[apI1].center.x,
        (aps[apI4].center.y - aps[apI2].center.y) / aveSizeAp24 * aveSizeAp14 + aps[apI1].center.y);
    aps[apI3].type = apI3;
    aps[apI3].foundCount = 1;
    aps[apI3].moduleSize =
        (aps[apI1].moduleSize + aps[apI2].moduleSize + aps[apI4].moduleSize) / 3.0;
    if (aps[apI3].center.x > bitmap.width - 1 || aps[apI3].center.y > bitmap.height - 1) {
      return false; // "Alignment pattern out of image"
    }
  }
  if (aps[apI4].foundCount == 0) {
    final aveSizeAp13 = (aps[apI1].moduleSize + aps[apI3].moduleSize) / 2.0;
    final aveSizeAp23 = (aps[apI2].moduleSize + aps[apI3].moduleSize) / 2.0;
    aps[apI4].center = _JabPoint(
        (aps[apI3].center.x - aps[apI1].center.x) / aveSizeAp13 * aveSizeAp23 + aps[apI2].center.x,
        (aps[apI3].center.y - aps[apI1].center.y) / aveSizeAp13 * aveSizeAp23 + aps[apI2].center.y);
    aps[apI4].type = apI4;
    aps[apI4].foundCount = 1;
    // Hinweis: Original addiert hier `aps[ap1].module_size` zweimal (statt
    // ap1+ap3) — offensichtlicher Tippfehler im Original, 1:1 übernommen.
    aps[apI4].moduleSize =
        (aps[apI1].moduleSize + aps[apI1].moduleSize + aps[apI3].moduleSize) / 3.0;
    if (aps[apI4].center.x > bitmap.width - 1 || aps[apI4].center.y > bitmap.height - 1) {
      return false; // "Alignment pattern out of image"
    }
  }

  slaveSymbol.patternPositions[apI1] = aps[apI1].center;
  slaveSymbol.patternPositions[apI2] = aps[apI2].center;
  slaveSymbol.patternPositions[apI3] = aps[apI3].center;
  slaveSymbol.patternPositions[apI4] = aps[apI4].center;
  slaveSymbol.moduleSize =
      (aps[apI1].moduleSize + aps[apI2].moduleSize + aps[apI3].moduleSize + aps[apI4].moduleSize) /
          4.0;

  return true;
}

({int Size, int Flag}) _getSideSize(int sizeIn) {
  int size = sizeIn;
  int flag = 1;
  switch (size & 0x03) {
    case 0:
      size++;
      break;
    case 2:
      size--;
      break;
    case 3:
      size += 2;
      flag = 0;
      break;
  }
  if (size < 21) {
    size = -1;
    flag = -1;
  } else if (size > 145) {
    size = -1;
    flag = -1;
  }
  return (Size: size, Flag: flag);
}

int _chooseSideSize(int size1, int flag1, int size2, int flag2) {
  if (flag1 == -1 && flag2 == -1) {
    return -1;
  } else if (flag1 == flag2) {
    return max(size1, size2);
  } else {
    return flag1 > flag2 ? size1 : size2;
  }
}

int _calculateModuleNumber(_JabFinderPattern p1, _JabFinderPattern p2) {
  final d = _dist(p1.center.x, p1.center.y, p2.center.x, p2.center.y);
  final cosTheta = max((p2.center.x - p1.center.x).abs(), (p2.center.y - p1.center.y).abs()) / d;
  final mean = (p1.moduleSize + p2.moduleSize) * cosTheta / 2.0;
  return (d / mean + 0.5).toInt();
}

_JabVector2d _calculateSideSize(List<_JabFinderPattern> fps) {
  final sideSize = _JabVector2d(-1, -1);

  var sizeXTop = _calculateModuleNumber(fps[0], fps[1]) + 7;
  final r1 = _getSideSize(sizeXTop);
  sizeXTop = r1.Size;
  final flag1a = r1.Flag;
  var sizeXBottom = _calculateModuleNumber(fps[3], fps[2]) + 7;
  final r2 = _getSideSize(sizeXBottom);
  sizeXBottom = r2.Size;
  final flag2a = r2.Flag;
  sideSize.x = _chooseSideSize(sizeXTop, flag1a, sizeXBottom, flag2a);

  var sizeYLeft = _calculateModuleNumber(fps[0], fps[3]) + 7;
  final r3 = _getSideSize(sizeYLeft);
  sizeYLeft = r3.Size;
  final flag1b = r3.Flag;
  var sizeYRight = _calculateModuleNumber(fps[1], fps[2]) + 7;
  final r4 = _getSideSize(sizeYRight);
  sizeYRight = r4.Size;
  final flag2b = r4.Flag;
  sideSize.y = _chooseSideSize(sizeYLeft, flag1b, sizeYRight, flag2b);

  return sideSize;
}

int _getFirstAPPos(int posIn) {
  int pos = posIn;
  switch (pos % 3) {
    case 0:
      pos--;
      break;
    case 1:
      pos++;
      break;
  }
  if (pos < 14 || pos > 26) pos = -1;
  return pos;
}

int _detectFirstAP(
    List<_JabBitmap> ch, int sideVersion, _JabFinderPattern p1, _JabFinderPattern p2) {
  final distx = p2.center.x - p1.center.x;
  final disty = p2.center.y - p1.center.y;
  final alpha = atan2(disty, distx);

  int nextVersion = sideVersion;
  int dir = 1;
  int up = 0, down = 0;
  do {
    final distance =
        p1.moduleSize * (_jabApPos[nextVersion - 1][1] - _jabApPos[nextVersion - 1][0]);
    var ap = _JabFinderPattern();
    ap.center = _JabPoint(p1.center.x + distance * cos(alpha),
        p1.center.y + distance * sin(alpha));
    ap.moduleSize = p1.moduleSize;
    ap.foundCount = 0;
    ap = _findAlignmentPattern(ch, ap.center.x, ap.center.y, ap.moduleSize, _apx);
    if (ap.foundCount > 0) {
      final pos = _getFirstAPPos(4 + _calculateModuleNumber(p1, ap));
      if (pos > 0) return pos;
    }

    dir = -dir;
    if (dir == -1) {
      up++;
      nextVersion = up * dir + sideVersion;
      if (nextVersion < 6 || nextVersion > 32) {
        dir = -dir;
        up--;
        down++;
        nextVersion = down * dir + sideVersion;
      }
    } else {
      down++;
      nextVersion = down * dir + sideVersion;
      if (nextVersion < 6 || nextVersion > 32) {
        dir = -dir;
        down--;
        up++;
        nextVersion = up * dir + sideVersion;
      }
    }
  } while ((up + down) < 5);

  return -1;
}

int _confirmSideVersion(int sideVersion, int firstApPos) {
  if (firstApPos <= 0) return -1;

  int v = sideVersion;
  int k = 1, sign = -1;
  bool flag = false;
  do {
    if (firstApPos == _jabApPos[v - 1][1]) {
      flag = true;
      break;
    }
    v = sideVersion + sign * k;
    if (sign > 0) k++;
    sign = -sign;
  } while (v >= 6 && v <= 32);

  return flag ? v : -1;
}

bool _confirmSymbolSize(List<_JabBitmap> ch, List<_JabFinderPattern> fps, _JabDecodedSymbol symbol) {
  int firstApPos = _detectFirstAP(ch, symbol.metadata.sideVersion.x, fps[0], fps[1]);
  int sideVersionX = _confirmSideVersion(symbol.metadata.sideVersion.x, firstApPos);
  if (sideVersionX == 0) {
    firstApPos = _detectFirstAP(ch, symbol.metadata.sideVersion.x, fps[3], fps[2]);
    sideVersionX = _confirmSideVersion(symbol.metadata.sideVersion.x, firstApPos);
    if (sideVersionX == 0) return false;
  }
  symbol.metadata.sideVersion.x = sideVersionX;
  symbol.sideSize.x = _version2size(sideVersionX);

  firstApPos = _detectFirstAP(ch, symbol.metadata.sideVersion.y, fps[0], fps[3]);
  int sideVersionY = _confirmSideVersion(symbol.metadata.sideVersion.y, firstApPos);
  if (sideVersionY == 0) {
    firstApPos = _detectFirstAP(ch, symbol.metadata.sideVersion.y, fps[1], fps[2]);
    sideVersionY = _confirmSideVersion(symbol.metadata.sideVersion.y, firstApPos);
    if (sideVersionY == 0) return false;
  }
  symbol.metadata.sideVersion.y = sideVersionY;
  symbol.sideSize.y = _version2size(sideVersionY);

  return true;
}

_JabBitmap? _sampleSymbolByAlignmentPattern(
    _JabBitmap bitmap, List<_JabBitmap> ch, _JabDecodedSymbol symbol, List<_JabFinderPattern> fps) {
  if (symbol.metadata.sideVersion.x < 6 && symbol.metadata.sideVersion.y < 6) {
    return null; // "No alignment pattern is available"
  }

  if (symbol.metadata.defaultMode) {
    if (!_confirmSymbolSize(ch, fps, symbol)) {
      return null; // "The symbol size can not be recognized."
    }
  }

  final sideVerXIndex = symbol.metadata.sideVersion.x - 1;
  final sideVerYIndex = symbol.metadata.sideVersion.y - 1;
  final numberOfApX = _jabApNum[sideVerXIndex];
  final numberOfApY = _jabApNum[sideVerYIndex];

  final aps = List<_JabFinderPattern>.generate(numberOfApX * numberOfApY, (_) => _JabFinderPattern());

  for (int i = 0; i < numberOfApY; i++) {
    for (int j = 0; j < numberOfApX; j++) {
      final int index = i * numberOfApX + j;
      if (i == 0 && j == 0) {
        aps[index] = fps[0].clone();
      } else if (i == 0 && j == numberOfApX - 1) {
        aps[index] = fps[1].clone();
      } else if (i == numberOfApY - 1 && j == numberOfApX - 1) {
        aps[index] = fps[2].clone();
      } else if (i == numberOfApY - 1 && j == 0) {
        aps[index] = fps[3].clone();
      } else {
        if (i == 0) {
          final distx = fps[1].center.x - aps[j - 1].center.x;
          final disty = fps[1].center.y - aps[j - 1].center.y;
          final alpha = atan2(disty, distx);
          final distance = aps[j - 1].moduleSize *
              (_jabApPos[sideVerXIndex][j] - _jabApPos[sideVerXIndex][j - 1]);
          aps[index].center = _JabPoint(aps[j - 1].center.x + distance * cos(alpha),
              aps[j - 1].center.y + distance * sin(alpha));
          aps[index].moduleSize = aps[j - 1].moduleSize;
        } else if (j == 0) {
          final distx = fps[3].center.x - aps[(i - 1) * numberOfApX].center.x;
          final disty = fps[3].center.y - aps[(i - 1) * numberOfApX].center.y;
          final alpha = atan2(disty, distx);
          final distance = aps[(i - 1) * numberOfApX].moduleSize *
              (_jabApPos[sideVerYIndex][i] - _jabApPos[sideVerYIndex][i - 1]);
          aps[index].center = _JabPoint(
              aps[(i - 1) * numberOfApX].center.x + distance * cos(alpha),
              aps[(i - 1) * numberOfApX].center.y + distance * sin(alpha));
          aps[index].moduleSize = aps[(i - 1) * numberOfApX].moduleSize;
        } else {
          final indexAp0 = (i - 1) * numberOfApX + (j - 1);
          final indexAp1 = (i - 1) * numberOfApX + j;
          final indexAp3 = i * numberOfApX + (j - 1);
          final aveSizeAp01 = (aps[indexAp0].moduleSize + aps[indexAp1].moduleSize) / 2.0;
          final aveSizeAp13 = (aps[indexAp1].moduleSize + aps[indexAp3].moduleSize) / 2.0;
          aps[index].center = _JabPoint(
              (aps[indexAp1].center.x - aps[indexAp0].center.x) / aveSizeAp01 * aveSizeAp13 +
                  aps[indexAp3].center.x,
              (aps[indexAp1].center.y - aps[indexAp0].center.y) / aveSizeAp01 * aveSizeAp13 +
                  aps[indexAp3].center.y);
          aps[index].moduleSize = aveSizeAp13;
        }

        aps[index].foundCount = 0;
        final tmp = aps[index].clone();
        aps[index] = _findAlignmentPattern(
            ch, aps[index].center.x, aps[index].center.y, aps[index].moduleSize, _apx);
        if (aps[index].foundCount == 0) {
          aps[index] = tmp;
        }
      }
    }
  }

  final blockNumber = (numberOfApX - 1) * (numberOfApY - 1);
  final rect = List<_JabVector2d>.generate(blockNumber * 2, (_) => _JabVector2d(0, 0));
  int rectIndex = 0;

  for (int i = 0; i < numberOfApY - 1; i++) {
    for (int j = 0; j < numberOfApX - 1; j++) {
      var tl = _JabVector2d(0, 0);
      var br = _JabVector2d(0, 0);
      bool flag = true;

      for (int delta = 0;
          delta <= (numberOfApX - 2 + numberOfApY - 2) && flag;
          delta++) {
        for (int dy = 0; dy <= min(delta, numberOfApY - 2) && flag; dy++) {
          final dx = min(delta - dy, numberOfApX - 2);
          for (int dy1 = 0; dy1 <= dy && flag; dy1++) {
            final dy2 = dy - dy1;
            for (int dx1 = 0; dx1 <= dx && flag; dx1++) {
              final dx2 = dx - dx1;

              tl = _JabVector2d(max(j - dx1, 0), max(i - dy1, 0));
              br = _JabVector2d(min(j + 1 + dx2, numberOfApX - 1), min(i + 1 + dy2, numberOfApY - 1));
              if (aps[tl.y * numberOfApX + tl.x].foundCount > 0 &&
                  aps[tl.y * numberOfApX + br.x].foundCount > 0 &&
                  aps[br.y * numberOfApX + tl.x].foundCount > 0 &&
                  aps[br.y * numberOfApX + br.x].foundCount > 0) {
                flag = false;
              }
            }
          }
        }
      }

      bool dupFlag = false;
      for (int k = 0; k < rectIndex; k += 2) {
        if (rect[k].x == tl.x && rect[k].y == tl.y && rect[k + 1].x == br.x && rect[k + 1].y == br.y) {
          dupFlag = true;
          break;
        }
      }
      if (!dupFlag) {
        rect[rectIndex] = tl;
        rect[rectIndex + 1] = br;
        rectIndex += 2;
      }
    }
  }

  for (int i = 0; i < rectIndex - 2; i += 2) {
    for (int j = 0; j < rectIndex - 2 - i; j += 2) {
      final size0 = (rect[j + 1].x - rect[j].x) * (rect[j + 1].y - rect[j].y);
      final size1 = (rect[j + 2 + 1].x - rect[j + 2].x) * (rect[j + 2 + 1].y - rect[j + 2].y);
      if (size1 > size0) {
        var tmp = rect[j];
        rect[j] = rect[j + 2];
        rect[j + 2] = tmp;
        tmp = rect[j + 1];
        rect[j + 1] = rect[j + 2 + 1];
        rect[j + 2 + 1] = tmp;
      }
    }
  }

  final width = symbol.sideSize.x;
  final height = symbol.sideSize.y;
  final mtxBytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final mtxBytesPerRow = width * mtxBytesPerPixel;
  final matrix = _JabBitmap(
      width: width,
      height: height,
      channelCount: bitmap.channelCount,
      bitsPerChannel: bitmap.bitsPerChannel,
      bitsPerPixel: bitmap.bitsPerChannel * bitmap.channelCount);

  for (int i = 0; i < rectIndex; i += 2) {
    var blkSize = _JabVector2d(0, 0);
    _JabPoint p0, p1, p2, p3;

    blkSize.x = _jabApPos[sideVerXIndex][rect[i + 1].x] - _jabApPos[sideVerXIndex][rect[i].x] + 1;
    blkSize.y = _jabApPos[sideVerYIndex][rect[i + 1].y] - _jabApPos[sideVerYIndex][rect[i].y] + 1;
    p0 = _JabPoint(0.5, 0.5);
    p1 = _JabPoint(blkSize.x - 0.5, 0.5);
    p2 = _JabPoint(blkSize.x - 0.5, blkSize.y - 0.5);
    p3 = _JabPoint(0.5, blkSize.y - 0.5);

    if (rect[i].y == 0) {
      blkSize.y += (_distanceToBorder - 1);
      p0.y = 3.5;
      p1.y = 3.5;
      p2.y = blkSize.y - 0.5;
      p3.y = blkSize.y - 0.5;
    }
    if (rect[i + 1].y == (numberOfApY - 1)) {
      blkSize.y += (_distanceToBorder - 1);
      p2.y = blkSize.y - 3.5;
      p3.y = blkSize.y - 3.5;
    }
    if (rect[i].x == 0) {
      blkSize.x += (_distanceToBorder - 1);
      p0.x = 3.5;
      p1.x = blkSize.x - 0.5;
      p2.x = blkSize.x - 0.5;
      p3.x = 3.5;
    }
    if (rect[i + 1].x == (numberOfApX - 1)) {
      blkSize.x += (_distanceToBorder - 1);
      p1.x = blkSize.x - 3.5;
      p2.x = blkSize.x - 3.5;
    }

    final pt = _perspectiveTransform(
        p0.x,
        p0.y,
        p1.x,
        p1.y,
        p2.x,
        p2.y,
        p3.x,
        p3.y,
        aps[rect[i + 0].y * numberOfApX + rect[i + 0].x].center.x,
        aps[rect[i + 0].y * numberOfApX + rect[i + 0].x].center.y,
        aps[rect[i + 0].y * numberOfApX + rect[i + 1].x].center.x,
        aps[rect[i + 0].y * numberOfApX + rect[i + 1].x].center.y,
        aps[rect[i + 1].y * numberOfApX + rect[i + 1].x].center.x,
        aps[rect[i + 1].y * numberOfApX + rect[i + 1].x].center.y,
        aps[rect[i + 1].y * numberOfApX + rect[i + 0].x].center.x,
        aps[rect[i + 1].y * numberOfApX + rect[i + 0].x].center.y);

    final block = _sampleSymbol(bitmap, pt, blkSize);
    if (block == null) {
      return null; // "Sampling block failed"
    }

    int startX = _jabApPos[sideVerXIndex][rect[i].x] - 1;
    int startY = _jabApPos[sideVerYIndex][rect[i].y] - 1;
    if (rect[i].x == 0) startX = 0;
    if (rect[i].y == 0) startY = 0;
    final blkBytesPerPixel = block.bitsPerPixel ~/ 8;
    final blkBytesPerRow = blkSize.x * mtxBytesPerPixel;
    for (int y = 0, mtxY = startY; y < blkSize.y && mtxY < height; y++, mtxY++) {
      for (int x = 0, mtxX = startX; x < blkSize.x && mtxX < width; x++, mtxX++) {
        final mtxOffset = mtxY * mtxBytesPerRow + mtxX * mtxBytesPerPixel;
        final blkOffset = y * blkBytesPerRow + x * blkBytesPerPixel;
        matrix.pixel[mtxOffset] = block.pixel[blkOffset];
        matrix.pixel[mtxOffset + 1] = block.pixel[blkOffset + 1];
        matrix.pixel[mtxOffset + 2] = block.pixel[blkOffset + 2];
        matrix.pixel[mtxOffset + 3] = block.pixel[blkOffset + 3];
      }
    }
  }

  return matrix;
}

List<double> _getAveragePixelValue(_JabBitmap bitmap, List<_JabFinderPattern> fps) {
  final rAve = [0.0, 0.0, 0.0, 0.0];
  final gAve = [0.0, 0.0, 0.0, 0.0];
  final bAve = [0.0, 0.0, 0.0, 0.0];

  final bytesPerPixel = bitmap.bitsPerPixel ~/ 8;
  final bytesPerRow = bitmap.width * bytesPerPixel;

  for (int i = 0; i < 4; i++) {
    if (fps[i].foundCount <= 0) continue;

    final radius = fps[i].moduleSize * 4;
    final startX = (fps[i].center.x - radius) >= 0 ? (fps[i].center.x - radius).toInt() : 0;
    final startY = (fps[i].center.y - radius) >= 0 ? (fps[i].center.y - radius).toInt() : 0;
    final endX = (fps[i].center.x + radius) <= (bitmap.width - 1)
        ? (fps[i].center.x + radius).toInt()
        : (bitmap.width - 1);
    final endY = (fps[i].center.y + radius) <= (bitmap.height - 1)
        ? (fps[i].center.y + radius).toInt()
        : (bitmap.height - 1);
    final areaWidth = endX - startX;
    final areaHeight = endY - startY;

    for (int y = startY; y < endY; y++) {
      for (int x = startX; x < endX; x++) {
        final offset = y * bytesPerRow + x * bytesPerPixel;
        rAve[i] += bitmap.pixel[offset + 0];
        gAve[i] += bitmap.pixel[offset + 1];
        bAve[i] += bitmap.pixel[offset + 2];
      }
    }
    rAve[i] /= (areaWidth * areaHeight);
    gAve[i] /= (areaWidth * areaHeight);
    bAve[i] /= (areaWidth * areaHeight);
  }

  final rgbSum = [0.0, 0.0, 0.0];
  final rgbCount = [0, 0, 0];
  for (int i = 0; i < 4; i++) {
    if (rAve[i] > 0) {
      rgbSum[0] += rAve[i];
      rgbCount[0]++;
    }
    if (gAve[i] > 0) {
      rgbSum[1] += gAve[i];
      rgbCount[1]++;
    }
    if (bAve[i] > 0) {
      rgbSum[2] += bAve[i];
      rgbCount[2]++;
    }
  }
  final rgbAve = [0.0, 0.0, 0.0];
  if (rgbCount[0] > 0) rgbAve[0] = rgbSum[0] / rgbCount[0];
  if (rgbCount[1] > 0) rgbAve[1] = rgbSum[1] / rgbCount[1];
  if (rgbCount[2] > 0) rgbAve[2] = rgbSum[2] / rgbCount[2];
  return rgbAve;
}

bool _detectMaster(_JabBitmap bitmap, List<_JabBitmap> ch, _JabDecodedSymbol masterSymbol) {
  var chLocal = ch;
  var fr = _findMasterSymbol(bitmap, chLocal, _JabDetectMode.intensive);
  var fps = fr.Fps;

  if (!fr.Success) {
    final rgbAve = _getAveragePixelValue(bitmap, fps);
    chLocal = _binarizerRGB(bitmap, rgbAve);

    fr = _findMasterSymbol(bitmap, chLocal, _JabDetectMode.intensive);
    fps = fr.Fps;
    if (!fr.Success) return false;
  }

  final sideSize = _calculateSideSize(fps);
  if (sideSize.x == -1 || sideSize.y == -1) {
    return false; // "Calculating side size failed"
  }

  var matrix = _sampleSymbol(
      bitmap,
      _getPerspectiveTransform(fps[0].center, fps[1].center, fps[2].center, fps[3].center, sideSize),
      sideSize);
  if (matrix == null) {
    return false; // "Sampling master symbol failed"
  }

  masterSymbol.index = 0;
  masterSymbol.hostIndex = 0;
  masterSymbol.sideSize = sideSize;
  masterSymbol.moduleSize = (fps[0].moduleSize + fps[1].moduleSize + fps[2].moduleSize + fps[3].moduleSize) / 4.0;
  masterSymbol.patternPositions[0] = fps[0].center;
  masterSymbol.patternPositions[1] = fps[1].center;
  masterSymbol.patternPositions[2] = fps[2].center;
  masterSymbol.patternPositions[3] = fps[3].center;

  var decodeResult = _decodeMaster(matrix, masterSymbol);
  if (decodeResult == _Status.Success) {
    return true;
  } else if (decodeResult == _Status.FatalError || decodeResult == _Status.DecodeMetadataFailed) {
    return false;
  } else {
    // Versuch mit Alignment-Pattern-basierter Abtastung
    masterSymbol.sideSize = _JabVector2d(_version2size(masterSymbol.metadata.sideVersion.x),
        _version2size(masterSymbol.metadata.sideVersion.y));
    matrix = _sampleSymbolByAlignmentPattern(bitmap, chLocal, masterSymbol, fps);
    if (matrix == null) return false;
    return _decodeMaster(matrix, masterSymbol) == _Status.Success;
  }
}

_JabBitmap? _detectSlave(_JabBitmap bitmap, List<_JabBitmap> ch, _JabDecodedSymbol hostSymbol,
    _JabDecodedSymbol slaveSymbol, int dockedPosition) {
  if (dockedPosition < 0 || dockedPosition > 3) {
    return null; // "Wrong docking position"
  }

  if (!_findSlaveSymbol(bitmap, ch, hostSymbol, slaveSymbol, dockedPosition)) {
    return null; // "Slave symbol not found"
  }

  final pt = _getPerspectiveTransform(
      slaveSymbol.patternPositions[0],
      slaveSymbol.patternPositions[1],
      slaveSymbol.patternPositions[2],
      slaveSymbol.patternPositions[3],
      slaveSymbol.sideSize);

  return _sampleSymbol(bitmap, pt, slaveSymbol.sideSize);
}

({bool Success, int Total}) _decodeDockedSlaves(
    _JabBitmap bitmap, List<_JabBitmap> ch, List<_JabDecodedSymbol> symbols, int hostIndex, int total) {
  final dockedPosition = symbols[hostIndex].metadata.dockedPosition;

  for (int j = 0; j < 4; j++) {
    if ((dockedPosition & (0x08 >> j)) > 0 && total < _maxSymbolNumber) {
      final slave = symbols[total];
      slave.index = total;
      slave.hostIndex = hostIndex;
      slave.metadata = symbols[hostIndex].slaveMetadata[j];

      final matrix = _detectSlave(bitmap, ch, symbols[hostIndex], slave, j);
      if (matrix == null || _decodeSlave(matrix, slave) != _Status.Success) {
        return (Success: false, Total: total); // "Detecting/decoding slave symbol failed"
      }
      total++;
    }
  }
  return (Success: true, Total: total);
}

({_JabData? DecodedData, DecodeResult Result}) _decodeJABCodeEx(_JabBitmap bitmap, _DecodeMode mode, int maxSymbolNumberIn) {
  var status = DecodeResult.NotDetectable;
  final symbols = List<_JabDecodedSymbol>.generate(maxSymbolNumberIn, (_) => _JabDecodedSymbol());

  _balanceRGB(bitmap);
  final ch = _binarizerRGB(bitmap, null);

  int total = _detectMaster(bitmap, ch, symbols[0]) ? 1 : 0;
  bool res = true;

  for (int i = 0; i < total && total < maxSymbolNumberIn; i++) {
    final docked = _decodeDockedSlaves(bitmap, ch, symbols, i, total);
    total = docked.Total;
    if (!docked.Success) {
      res = false;
      break;
    }
  }

  if (total == 0 || (mode == _DecodeMode.Normal && !res)) {
    if (symbols[0].moduleSize > 0) status = DecodeResult.NotDecodable;
    return (DecodedData: null, Result: status);
  }
  if (mode == _DecodeMode.Compatible && !res) {
    status = DecodeResult.PartlyDecodedWithCompatibleDecodeMode;
    res = true;
  }

  int totalDataLength = 0;
  for (int i = 0; i < total; i++) {
    totalDataLength += symbols[i].data!.length;
  }
  final decodedBitsBytes = Uint8List(totalDataLength);
  int offset = 0;
  for (int i = 0; i < total; i++) {
    final src = symbols[i].data!.data;
    decodedBitsBytes.setRange(offset, offset + src.length, src);
    offset += src.length;
  }
  final decodedBits = _JabData(totalDataLength, decodedBitsBytes);

  final decodedData = _decodeData(decodedBits);
  if (decodedData == null) {
    status = DecodeResult.NotDecodable;
    res = false;
  }

  if (!res) return (DecodedData: null, Result: status);
  if (status != DecodeResult.PartlyDecodedWithCompatibleDecodeMode) status = DecodeResult.FullyDecoded;
  return (DecodedData:decodedData, Result: status);
}

({_JabData? DecodedData, DecodeResult Result}) decodeJABCode(_JabBitmap bitmap, _DecodeMode mode) {
  return _decodeJABCodeEx(bitmap, mode, _maxSymbolNumber);
}
