import 'dart:typed_data';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ------------------------------------------------------------
// Einfache Complex-Klasse
// ------------------------------------------------------------

class Complex {
  final double re;
  final double im;

  const Complex(this.re, this.im);

  Complex operator +(Complex other) => Complex(re + other.re, im + other.im);
  Complex operator -(Complex other) => Complex(re - other.re, im - other.im);
  Complex operator *(Complex other) =>
      Complex(re * other.re - im * other.im, re * other.im + im * other.re);

  double get abs => sqrt(re * re + im * im);
}

// ------------------------------------------------------------
// Radix-2 Cooley–Tukey FFT (iterativ)
// ------------------------------------------------------------

List<Complex> fft(List<Complex> input) {
  final n = input.length;
  if (n == 0) return [];
  if ((n & (n - 1)) != 0) {
    throw ArgumentError('FFT-Länge muss Potenz von 2 sein, n=$n');
  }

  final a = List<Complex>.from(input);

  // Bit-Reversal
  int j = 0;
  for (int i = 1; i < n; i++) {
    int bit = n >> 1;
    while ((j & bit) != 0) {
      j ^= bit;
      bit >>= 1;
    }
    j ^= bit;
    if (i < j) {
      final tmp = a[i];
      a[i] = a[j];
      a[j] = tmp;
    }
  }

  // Stufen
  for (int len = 2; len <= n; len <<= 1) {
    final ang = -2 * pi / len;
    final wlen = Complex(cos(ang), sin(ang));
    for (int i = 0; i < n; i += len) {
      var w = const Complex(1, 0);
      for (int k = 0; k < len ~/ 2; k++) {
        final u = a[i + k];
        final v = a[i + k + len ~/ 2] * w;
        a[i + k] = u + v;
        a[i + k + len ~/ 2] = u - v;
        w = w * wlen;
      }
    }
  }

  return a;
}

// ------------------------------------------------------------
// WAV → PCM → FFT → Spektrum
// ------------------------------------------------------------

class WavSpectrum {
  final List<double> frequencies;
  final List<double> magnitudes;
  final int sampleRate;
  final int channels;
  final int bitsPerSample;
  final bool isFloat;

  WavSpectrum({
    required this.frequencies,
    required this.magnitudes,
    required this.sampleRate,
    required this.channels,
    required this.bitsPerSample,
    required this.isFloat,
  });
}

WavSpectrum computeWavSpectrum(Uint8List wavBytes) {
  final bd = wavBytes.buffer.asByteData();

  // --- WAV HEADER ---
  final audioFormat = bd.getUint16(20, Endian.little); // 1=PCM, 3=float
  final channels = bd.getUint16(22, Endian.little);
  final sampleRate = bd.getUint32(24, Endian.little);
  final bitsPerSample = bd.getUint16(34, Endian.little);
  final isFloat = audioFormat == 3;

  // --- DATA-CHUNK FINDEN ---
  int offset = 12;
  int dataOffset = -1;
  int dataSize = 0;

  while (offset + 8 <= wavBytes.length) {
    final chunkId = String.fromCharCodes(wavBytes.sublist(offset, offset + 4));
    final chunkSize = bd.getUint32(offset + 4, Endian.little);

    if (chunkId == 'data') {
      dataOffset = offset + 8;
      dataSize = chunkSize;
      break;
    }
    offset += 8 + chunkSize;
  }

  if (dataOffset < 0 || dataOffset + dataSize > wavBytes.length) {
    throw Exception('Kein gültiger DATA-Chunk gefunden.');
  }

  final pcmBytes = wavBytes.sublist(dataOffset, dataOffset + dataSize);

  // --- PCM → DOUBLE ---
  // --- PCM → DOUBLE ---
  final samples = <double>[];

  if (isFloat && bitsPerSample == 32) {
    // 32-bit IEEE float
    final floatList = pcmBytes.buffer.asFloat32List(
      pcmBytes.offsetInBytes,
      pcmBytes.lengthInBytes ~/ 4,
    );
    samples.addAll(floatList);

  } else if (!isFloat && bitsPerSample == 16) {
    // 16-bit signed PCM
    final int16 = pcmBytes.buffer.asInt16List(
      pcmBytes.offsetInBytes,
      pcmBytes.lengthInBytes ~/ 2,
    );
    for (final v in int16) {
      samples.add(v.toDouble());
    }

  } else if (!isFloat && bitsPerSample == 8) {
    // 8-bit *unsigned* PCM → signed
    for (int i = 0; i < pcmBytes.length; i++) {
      final unsigned = pcmBytes[i];      // 0..255
      final signed = unsigned - 128;     // -128..127
      samples.add(signed.toDouble());
    }

  } else {
    throw Exception(
        'Nicht unterstütztes WAV-Format: Format=$audioFormat Bits=$bitsPerSample');
  }

  // Stereo → Mono
  if (channels == 2) {
    final mono = <double>[];
    for (int i = 0; i + 1 < samples.length; i += 2) {
      mono.add((samples[i] + samples[i + 1]) * 0.5);
    }
    samples
      ..clear()
      ..addAll(mono);
  }

  if (samples.isEmpty) {
    throw Exception('Keine Samples gefunden.');
  }

  // --- FFT-VORBEREITUNG ---
  final n = samples.length;
  final N = 1 << (log(n) ~/ log(2)); // größte 2er-Potenz ≤ n
  final windowed = samples.sublist(0, N);

  // Optional: Hann-Window
  final windowedComplex = <Complex>[];
  for (int i = 0; i < N; i++) {
    final w = 0.5 * (1 - cos(2 * pi * i / (N - 1)));
    windowedComplex.add(Complex(windowed[i] * w, 0.0));
  }

  final fftResult = fft(windowedComplex);

  final magnitudes = <double>[];
  final half = fftResult.length ~/ 2;
  for (int i = 0; i < half; i++) {
    magnitudes.add(fftResult[i].abs);
  }

  final frequencies = List<double>.generate(
    half,
        (i) => i * sampleRate / N,
  );

  return WavSpectrum(
    frequencies: frequencies,
    magnitudes: magnitudes,
    sampleRate: sampleRate,
    channels: channels,
    bitsPerSample: bitsPerSample,
    isFloat: isFloat,
  );
}

// ------------------------------------------------------------
// Spektrum als Bild rendern
// ------------------------------------------------------------

class SpectrumImage extends StatefulWidget {
  final List<double> frequencies;
  final List<double> magnitudes;
  final double width;
  final double height;

  const SpectrumImage({
    super.key,
    required this.frequencies,
    required this.magnitudes,
    this.width = 1000,
    this.height = 400,
  });

  @override
  State<SpectrumImage> createState() => _SpectrumImageState();
}

class _SpectrumImageState extends State<SpectrumImage> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _render();
  }

  Future<void> _render() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(widget.width, widget.height);

    _drawSpectrum(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      widget.width.toInt(),
      widget.height.toInt(),
    );

    if (mounted) {
      setState(() => image = img);
    }
  }

  void _drawSpectrum(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.black;
    canvas.drawRect(Offset.zero & size, bg);

    final freqs = widget.frequencies;
    final mags = widget.magnitudes;

    if (freqs.isEmpty || mags.isEmpty) return;

    final maxMag = mags.reduce(max);
    final minMag = mags.reduce(min);
    final dy = maxMag - minMag == 0 ? 1.0 : (maxMag - minMag);

    final dx = size.width / (mags.length - 1);
    final scaleY = size.height / dy;

    final paintLine = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final paintAxis = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    final path = Path();

    for (int i = 0; i < mags.length; i++) {
      final x = i * dx;
      final y = size.height - (mags[i] - minMag) * scaleY;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Achsen
    canvas.drawLine(
      Offset(0, size.height - 1),
      Offset(size.width, size.height - 1),
      paintAxis,
    );

    canvas.drawLine(
      Offset(0, 0),
      Offset(0, size.height),
      paintAxis,
    );

    // Spektrum
    canvas.drawPath(path, paintLine);
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RawImage(
      image: image,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );
  }
}

// ------------------------------------------------------------
// Beispielverwendung (z.B. in einem Widget):
// ------------------------------------------------------------
//
// final spectrum = computeWavSpectrum(wavBytes);
//
// SpectrumImage(
//   frequencies: spectrum.frequencies,
//   magnitudes: spectrum.magnitudes,
// );
//
// ------------------------------------------------------------

List<List<double>> computeSpectrogram(
    List<double> samples, {
      int fftSize = 1024,
      int hopSize = 256,
    }) {
  final hann = List<double>.generate(
    fftSize,
        (i) => 0.5 * (1 - cos(2 * pi * i / (fftSize - 1))),
  );

  final frames = <List<double>>[];

  for (int start = 0; start + fftSize <= samples.length; start += hopSize) {
    final windowed = <Complex>[];

    for (int i = 0; i < fftSize; i++) {
      windowed.add(Complex(samples[start + i] * hann[i], 0.0));
    }

    final fftResult = fft(windowed);

    final half = fftSize ~/ 2;
    final mags = List<double>.generate(
      half,
          (i) => fftResult[i].abs,
    );

    frames.add(mags);
  }

  return frames; // [time][frequency]
}

class SpectrogramImage extends StatefulWidget {
  final List<List<double>> spectrogram;
  final double width;
  final double height;

  const SpectrogramImage({
    super.key,
    required this.spectrogram,
    this.width = 1000,
    this.height = 400,
  });

  @override
  State<SpectrogramImage> createState() => _SpectrogramImageState();
}

class _SpectrogramImageState extends State<SpectrogramImage> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _render();
  }

  Future<void> _render() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(widget.width, widget.height);

    _drawSpectrogram(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      widget.width.toInt(),
      widget.height.toInt(),
    );

    if (mounted) {
      setState(() => image = img);
    }
  }

  void _drawSpectrogram(Canvas canvas, Size size) {
    final spec = widget.spectrogram;
    if (spec.isEmpty) return;

    final timeBins = spec.length;
    final freqBins = spec[0].length;

    // Min/Max für Normalisierung
    double minVal = double.infinity;
    double maxVal = double.negativeInfinity;

    for (var row in spec) {
      for (var v in row) {
        if (v < minVal) minVal = v;
        if (v > maxVal) maxVal = v;
      }
    }

    final dx = size.width / timeBins;
    final dy = size.height / freqBins;

    for (int t = 0; t < timeBins; t++) {
      for (int f = 0; f < freqBins; f++) {
        final v = (spec[t][f] - minVal) / (maxVal - minVal + 1e-12);

        // Heatmap-Farbe (Blau → Rot)
        final color = Color.lerp(
          Colors.blue,
          Colors.red,
          v,
        )!;

        final paint = Paint()..color = color;

        canvas.drawRect(
          Rect.fromLTWH(t * dx, size.height - (f + 1) * dy, dx, dy),
          paint,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RawImage(
      image: image,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );
  }
}

// final wav = computeWavSpectrum(wavBytes); // du hast das schon
//
// final spectrogram = computeSpectrogram(
//   wav.magnitudes, // oder direkt PCM-Samples
//   fftSize: 1024,
//   hopSize: 256,
// );
//
// SpectrogramImage(
//   spectrogram: spectrogram,
//   width: 1200,
//   height: 600,
// );

double rms(List<double> samples, int start, int length) {
  double sum = 0.0;
  for (int i = start; i < start + length; i++) {
    final v = samples[i];
    sum += v * v;
  }
  return sqrt(sum / length);
}

List<double> computeRmsTimeline(
    List<double> samples, {
      int windowSize = 1024,
      int hopSize = 256,
    }) {
  final rmsValues = <double>[];

  for (int start = 0; start + windowSize <= samples.length; start += hopSize) {
    rmsValues.add(rms(samples, start, windowSize));
  }

  return rmsValues;
}

class RmsSpectrogramImage extends StatefulWidget {
  final List<double> rmsValues;
  final double width;
  final double height;

  const RmsSpectrogramImage({
    super.key,
    required this.rmsValues,
    this.width = 1000,
    this.height = 200,
  });

  @override
  State<RmsSpectrogramImage> createState() => _RmsSpectrogramImageState();
}

class _RmsSpectrogramImageState extends State<RmsSpectrogramImage> {
  ui.Image? image;

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
    final rms = widget.rmsValues;
    if (rms.isEmpty) return;

    final maxVal = rms.reduce(max);
    final minVal = rms.reduce(min);

    final dx = size.width / rms.length;

    for (int i = 0; i < rms.length; i++) {
      final v = (rms[i] - minVal) / (maxVal - minVal + 1e-12);

      final color = Color.lerp(Colors.blue, Colors.red, v)!;

      final paint = Paint()..color = color;

      canvas.drawRect(
        Rect.fromLTWH(i * dx, 0, dx, size.height),
        paint,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RawImage(
      image: image,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );
  }
}

// final wav = computeWavSpectrum(wavBytes); // liefert PCM-Samples
//
// final rmsTimeline = computeRmsTimeline(
//   wav.magnitudes, // oder wav.samples, je nachdem was du willst
//   windowSize: 1024,
//   hopSize: 256,
// );
//
// RmsSpectrogramImage(
//   rmsValues: rmsTimeline,
//   width: 1200,
//   height: 200,
// );

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:math';

class WaveformImage extends StatefulWidget {
  final List<double> samples;
  final double width;
  final double height;

  const WaveformImage({
    super.key,
    required this.samples,
    this.width = 1200,
    this.height = 300,
  });

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

    _drawWaveform(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      widget.width.toInt(),
      widget.height.toInt(),
    );

    if (mounted) {
      setState(() => image = img);
    }
  }

  void _drawWaveform(Canvas canvas, Size size) {
    final samples = widget.samples;
    if (samples.isEmpty) return;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black,
    );

    final axisPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    final midY = size.height / 2;
    canvas.drawLine(
      Offset(0, midY),
      Offset(size.width, midY),
      axisPaint,
    );

    final maxAmp = samples.map((v) => v.abs()).reduce(max);
    final scaleY = (size.height / 2) / (maxAmp == 0 ? 1 : maxAmp);

    final visibleSamples = (samples.length / zoom).floor();
    final start = (pan * samples.length).clamp(0, samples.length - visibleSamples).toInt();
    final end = (start + visibleSamples).clamp(0, samples.length);

    final dx = size.width / (end - start);

    final path = Path();

    for (int i = start; i < end; i++) {
      final x = (i - start) * dx;
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

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:math';

class StereoWaveformImage extends StatefulWidget {
  final List<double> left;
  final List<double> right;
  final double width;
  final double height;

  const StereoWaveformImage({
    super.key,
    required this.left,
    required this.right,
    this.width = 1200,
    this.height = 400,
  });

  @override
  State<StereoWaveformImage> createState() => _StereoWaveformImageState();
}

class _StereoWaveformImageState extends State<StereoWaveformImage> {
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

    _drawStereo(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      widget.width.toInt(),
      widget.height.toInt(),
    );

    if (mounted) {
      setState(() => image = img);
    }
  }

  void _drawStereo(Canvas canvas, Size size) {
    final left = widget.left;
    final right = widget.right;

    if (left.isEmpty || right.isEmpty) return;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black,
    );

    final halfHeight = size.height / 2;

    _drawChannel(canvas, left, Rect.fromLTWH(0, 0, size.width, halfHeight));
    _drawChannel(canvas, right, Rect.fromLTWH(0, halfHeight, size.width, halfHeight));
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
    final start = (pan * samples.length).clamp(0, samples.length - visibleSamples).toInt();
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

// final left = leftChannelSamples;
// final right = rightChannelSamples;
//
// StereoWaveformImage(
// left: left,
// right: right,
// width: 1200,
// height: 400,
// );
