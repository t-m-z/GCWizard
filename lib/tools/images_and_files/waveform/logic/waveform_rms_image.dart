import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:math';

class WaveformImage extends StatefulWidget {
  final List<double> left;
  final List<double>? right; // null = mono
  final double width;
  final double height;

  const WaveformImage({
    super.key,
    required this.left,
    this.right,
    this.width = 1200,
    this.height = 400,
  });

  bool get isStereo => right != null;

  @override
  State<WaveformImage> createState() => _WaveformImageState();
}

class _WaveformImageState extends State<WaveformImage> {
  ui.Image? image;

  double zoom = 1.0;
  double pan = 0.0;

  @override
  void initState() {
    super.initState();
    _render();
  }

  Future<void> _render() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(widget.width, widget.height);

    _draw(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      widget.width.toInt(),
      widget.height.toInt(),
    );

    if (mounted) {
      setState(() => image = img);
    }
  }

  void _draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black,
    );

    if (widget.isStereo) {
      final half = size.height / 2;

      _drawChannel(canvas, widget.left,
          Rect.fromLTWH(0, 0, size.width, half));

      _drawChannel(canvas, widget.right!,
          Rect.fromLTWH(0, half, size.width, half));
    } else {
      _drawChannel(canvas, widget.left,
          Rect.fromLTWH(0, 0, size.width, size.height));
    }
  }

  void _drawChannel(Canvas canvas, List<double> samples, Rect area) {
    final axisPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    final midY = area.top + area.height / 2;

    canvas.drawLine(
      Offset(area.left, midY),
      Offset(area.right, midY),
      axisPaint,
    );

    final maxAmp = samples.map((v) => v.abs()).reduce(max);
    final scaleY = (area.height / 2) / (maxAmp == 0 ? 1 : maxAmp);

    final visibleSamples = (samples.length / zoom).floor();
    final start = (pan * samples.length)
        .clamp(0, samples.length - visibleSamples)
        .toInt();
    final end = (start + visibleSamples).clamp(0, samples.length);

    final dx = area.width / (end - start);

    final path = Path();

    for (int i = start; i < end; i++) {
      final x = area.left + (i - start) * dx;
      final y = midY - samples[i] * scaleY;

      if (i == start) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final linePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);
  }

  void _onScaleUpdate(ScaleUpdateDetails d) {
    setState(() {
      zoom = (zoom * d.scale).clamp(1.0, 200.0);

      pan -= d.focalPointDelta.dx / widget.width;
      pan = pan.clamp(0.0, 1.0);
    });

    _render();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: _onScaleUpdate,
      child: image == null
          ? const Center(child: CircularProgressIndicator())
          : RawImage(
        image: image,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      ),
    );
  }
}

// WaveformImage(
//   left: monoSamples,
// );

// WaveformImage(
//   left: leftChannel,
//   right: rightChannel,
// );