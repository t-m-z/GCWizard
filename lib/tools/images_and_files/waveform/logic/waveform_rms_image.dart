import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';

/// Public widget: zeigt die Wellenform eines WAV-Files aus Bytes.
class WavWaveformWidget extends StatelessWidget {
  final Uint8List wavBytes;
  final double height;
  final Color backgroundColor;
  final Color waveformColor;
  final double strokeWidth;

  const WavWaveformWidget({
    super.key,
    required this.wavBytes,
    this.height = 200,
    this.backgroundColor = Colors.black,
    this.waveformColor = Colors.orange,
    this.strokeWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WavData>(
      future: WavParser.parse(wavBytes),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return SizedBox(
            height: height,
            child: Center(
              child: Text(
                'Fehler beim Lesen der WAV-Datei',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        }

        final data = snapshot.data!;
        return SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(
            painter: WavWaveformPainter(
              data: data,
              backgroundColor: backgroundColor,
              waveformColor: waveformColor,
              strokeWidth: strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

/// Struktur mit den normalisierten Samples pro Kanal.
class WavData {
  final int sampleRate;
  final int numChannels;
  final List<List<double>> channels; // channels[c][i] in [-1, 1]

  WavData({
    required this.sampleRate,
    required this.numChannels,
    required this.channels,
  });

  int get length => channels.isEmpty ? 0 : channels[0].length;
}

/// Parser für einfache PCM/Float-WAV-Dateien.
class WavParser {
  static Future<WavData> parse(Uint8List bytes) async {
    final bd = ByteData.sublistView(bytes);

    // Minimaler RIFF/WAVE-Check
    if (bytes.length < 44) {
      throw FormatException('Datei zu kurz für WAV-Header');
    }
    if (String.fromCharCodes(bytes.sublist(0, 4)) != 'RIFF') {
      throw FormatException('Kein RIFF-Header');
    }
    if (String.fromCharCodes(bytes.sublist(8, 12)) != 'WAVE') {
      throw FormatException('Kein WAVE-Header');
    }

    int offset = 12;
    int? audioFormat;
    int? numChannels;
    int? sampleRate;
    int? bitsPerSample;
    int? dataOffset;
    int? dataSize;

    // Chunks durchlaufen
    while (offset + 8 <= bytes.length) {
      final chunkId = String.fromCharCodes(bytes.sublist(offset, offset + 4));
      final chunkSize = bd.getUint32(offset + 4, Endian.little);
      final chunkDataStart = offset + 8;

      if (chunkId == 'fmt ') {
        audioFormat = bd.getUint16(chunkDataStart + 0, Endian.little);
        numChannels = bd.getUint16(chunkDataStart + 2, Endian.little);
        sampleRate = bd.getUint32(chunkDataStart + 4, Endian.little);
        // byteRate = bd.getUint32(chunkDataStart + 8, Endian.little);
        // blockAlign = bd.getUint16(chunkDataStart + 12, Endian.little);
        bitsPerSample = bd.getUint16(chunkDataStart + 14, Endian.little);
      } else if (chunkId == 'data') {
        dataOffset = chunkDataStart;
        dataSize = chunkSize;
      }

      offset = chunkDataStart + chunkSize;
      if (offset.isOdd) offset++; // Padding
      if (offset >= bytes.length) break;
    }

    if (audioFormat == null ||
        numChannels == null ||
        sampleRate == null ||
        bitsPerSample == null ||
        dataOffset == null ||
        dataSize == null) {
      throw FormatException('Unvollständiger WAV-Header');
    }

    if (!(audioFormat == 1 || audioFormat == 3)) {
      throw FormatException('Nur PCM (1) oder IEEE Float (3) wird unterstützt');
    }

    final bytesPerSample = bitsPerSample ~/ 8;
    final frameSize = bytesPerSample * numChannels;
    final totalFrames = dataSize ~/ frameSize;

    final channels = List.generate(
      numChannels,
          (_) => List<double>.filled(totalFrames, 0.0, growable: false),
    );

    int pos = dataOffset;
    for (int i = 0; i < totalFrames; i++) {
      for (int ch = 0; ch < numChannels; ch++) {
        final sample = _readSample(
          bd,
          pos,
          bitsPerSample,
          audioFormat,
        );
        channels[ch][i] = sample;
        pos += bytesPerSample;
      }
    }

    return WavData(
      sampleRate: sampleRate,
      numChannels: numChannels,
      channels: channels,
    );
  }

  static double _readSample(
      ByteData bd,
      int offset,
      int bitsPerSample,
      int audioFormat,
      ) {
    // PCM
    if (audioFormat == 1) {
      switch (bitsPerSample) {
        case 8:
          final v = bd.getUint8(offset);
          return (v - 128) / 128.0;
        case 16:
          final v = bd.getInt16(offset, Endian.little);
          return v / 32768.0;
        case 24:
        // 24-bit little endian, sign-extend auf 32-bit
          final b0 = bd.getUint8(offset);
          final b1 = bd.getUint8(offset + 1);
          final b2 = bd.getUint8(offset + 2);
          int v = (b2 << 16) | (b1 << 8) | b0;
          if (v & 0x800000 != 0) {
            v |= 0xFF000000;
          }
          return v / 8388608.0; // 2^23
        case 32:
          final v = bd.getInt32(offset, Endian.little);
          return v / 2147483648.0; // 2^31
        default:
          throw FormatException('Nicht unterstützte PCM-Bittiefe: $bitsPerSample');
      }
    }

    // IEEE Float
    if (audioFormat == 3) {
      if (bitsPerSample == 32) {
        final v = bd.getFloat32(offset, Endian.little);
        // typischerweise schon in [-1,1], aber wir clampen sicherheitshalber
        return v.clamp(-1.0, 1.0);
      } else {
        throw FormatException('Nicht unterstützte Float-Bittiefe: $bitsPerSample');
      }
    }

    throw FormatException('Unbekanntes Audioformat: $audioFormat');
  }
}

/// Painter für die Wellenform.
/// - Mehrkanal: Kanäle werden vertikal gestapelt.
/// - Pro Kanal: mittige Nulllinie, Ausschläge nach oben/unten.
class WavWaveformPainter extends CustomPainter {
  final WavData data;
  final Color backgroundColor;
  final Color waveformColor;
  final double strokeWidth;

  WavWaveformPainter({
    required this.data,
    required this.backgroundColor,
    required this.waveformColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, paintBg);

    if (data.length == 0 || data.numChannels == 0) return;

    final numChannels = data.numChannels;
    final channelHeight = size.height / numChannels;

    final paintWave = Paint()
      ..color = waveformColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int ch = 0; ch < numChannels; ch++) {
      _drawChannel(canvas, size, ch, channelHeight, paintWave);
    }
  }

  void _drawChannel(
      Canvas canvas,
      Size size,
      int channelIndex,
      double channelHeight,
      Paint paintWave,
      ) {
    final samples = data.channels[channelIndex];
    final totalSamples = samples.length;

    if (totalSamples == 0) return;

    final top = channelIndex * channelHeight;
    final midY = top + channelHeight / 2;

    // Nulllinie
    final zeroPaint = Paint()
      ..color = waveformColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawLine(
      Offset(0, midY),
      Offset(size.width, midY),
      zeroPaint,
    );

    // Downsampling: pro Pixel eine Min/Max-Aggregation
    final width = size.width;
    if (width <= 0) return;

    final samplesPerPixel = math.max(1, (totalSamples / width).floor());
    final path = Path();

    for (int x = 0; x < width; x++) {
      final start = x * samplesPerPixel;
      if (start >= totalSamples) break;
      final end = math.min(start + samplesPerPixel, totalSamples);

      double minVal = 1.0;
      double maxVal = -1.0;
      for (int i = start; i < end; i++) {
        final v = samples[i];
        if (v < minVal) minVal = v;
        if (v > maxVal) maxVal = v;
      }

      final xPos = x.toDouble();
      final yMin = midY - minVal * (channelHeight / 2);
      final yMax = midY - maxVal * (channelHeight / 2);

      path.moveTo(xPos, yMin);
      path.lineTo(xPos, yMax);
    }

    canvas.drawPath(path, paintWave);
  }

  @override
  bool shouldRepaint(covariant WavWaveformPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.waveformColor != waveformColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

// // Beispiel: Bytes aus File oder Asset laden und anzeigen
// class WavDemoPage extends StatelessWidget {
//   final Uint8List wavBytes;
//
//   const WavDemoPage({super.key, required this.wavBytes});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('WAV Waveform')),
//       body: Center(
//         child: WavWaveformWidget(
//           wavBytes: wavBytes,
//           height: 240,
//           backgroundColor: Colors.black,
//           waveformColor: Colors.lightGreenAccent,
//           strokeWidth: 1.0,
//         ),
//       ),
//     );
//   }
// }