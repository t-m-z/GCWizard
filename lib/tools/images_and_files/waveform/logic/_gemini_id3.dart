import 'dart:convert';
import 'dart:typed_data';

///////////////////////////////////////////////////////////////////////////////
// ID3v1
///////////////////////////////////////////////////////////////////////////////

class Id3v1Tag {
  final String title;
  final String artist;
  final String album;
  final String year;
  final String comment;
  final int? track;
  final int genre;

  Id3v1Tag({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.comment,
    required this.track,
    required this.genre,
  });
}

class Id3v1Decoder {
  static Id3v1Tag? decode(Uint8List bytes) {
    if (bytes.length < 128) return null;

    final tag = bytes.sublist(bytes.length - 128);
    if (tag[0] != 0x54 || tag[1] != 0x41 || tag[2] != 0x47) {
      return null; // "TAG"
    }

    String _str(int start, int len) =>
        latin1.decode(tag.sublist(start, start + len)).trimRight();

    final title = _str(3, 30);
    final artist = _str(33, 30);
    final album = _str(63, 30);
    final year = _str(93, 4);

    int? track;
    String comment;

    if (tag[125] == 0 && tag[126] != 0) {
      comment = _str(97, 28);
      track = tag[126];
    } else {
      comment = _str(97, 30);
      track = null;
    }

    final genre = tag[127];

    return Id3v1Tag(
      title: title,
      artist: artist,
      album: album,
      year: year,
      comment: comment,
      track: track,
      genre: genre,
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
// ID3v2 STRUCTURES
///////////////////////////////////////////////////////////////////////////////

class Id3v2Frame {
  final String id;
  final int size;
  final int flags;
  final int offset;
  final Map<String, dynamic> data;

  Id3v2Frame({
    required this.id,
    required this.size,
    required this.flags,
    required this.offset,
    required this.data,
  });
}

class Id3v2Tag {
  final int versionMajor;
  final int versionMinor;
  final int flags;
  final int size;
  final List<Id3v2Frame> frames;

  Id3v2Tag({
    required this.versionMajor,
    required this.versionMinor,
    required this.flags,
    required this.size,
    required this.frames,
  });
}

class Id3Parser {
  static Id3v2Tag parse(Uint8List bytes) {
    final frames = <Id3v2Frame>[];
    final size = bytes.length;
    int pos = 10;
    final end = size;

    while (pos + 10 <= end) {
      final id = String.fromCharCodes(bytes.sublist(pos, pos + 4));
      final frameSize = _u32(bytes, pos + 4);
      final flags = (bytes[pos + 8] << 8) | bytes[pos + 9];

      if (frameSize == 0 || id.trim().isEmpty) break;

      frames.add(Id3v2Frame(
          id: id,
          size: frameSize,
          flags: flags,
          offset: pos,
          data: Id3Decoder.decodeFrame(
              Id3v2Frame(
                  id: id, size: frameSize, flags: flags, offset: pos, data: {}),
              bytes)));
      pos += 10 + frameSize;
    }

    return Id3v2Tag(
      versionMajor: bytes[3],
      versionMinor: bytes[4],
      flags: bytes[5],
      size: size,
      frames: frames,
    );
  }

  static int _u32(Uint8List b, int p) =>
      (b[p] << 24) | (b[p + 1] << 16) | (b[p + 2] << 8) | b[p + 3];
}
///////////////////////////////////////////////////////////////////////////////
// ID3v2 DECODER (ALL IMPORTANT FRAMES)
///////////////////////////////////////////////////////////////////////////////

class Id3Decoder {
  static Map<String, dynamic> decodeFrame(Id3v2Frame frame, Uint8List bytes) {
    final data =
        bytes.sublist(frame.offset + 10, frame.offset + 10 + frame.size);

    if (frame.id.startsWith('T') && frame.id != 'TXXX') {
      return _decodeTextFrame(frame.id, data);
    }

    switch (frame.id) {
      case 'TXXX':
        return _decodeUserTextFrame(data);
      case 'WXXX':
        return _decodeUserUrlFrame(data);
      case 'COMM':
        return _decodeCommentFrame(data);
      case 'APIC':
        return _decodeApicFrame(data);
      case 'USLT':
        return _decodeLyricsFrame(data);
      case 'SYLT':
        return _decodeSyncedLyricsFrame(data);
      case 'GEOB':
        return _decodeGeobFrame(data);
      case 'POPM':
        return _decodePopmFrame(data);
      case 'PRIV':
        return _decodePrivFrame(data);
      case 'UFID':
        return _decodeUfidFrame(data);
      default:
        return {'type': 'unknown', 'raw': data};
    }
  }

  // TEXT FRAMES --------------------------------------------------------------

  static Map<String, dynamic> _decodeTextFrame(String id, Uint8List data) {
    if (data.isEmpty) return {'type': 'text', 'id': id, 'text': ''};

    final encoding = data[0];
    final contentBytes = data.sublist(1);
    final text = _decodeString(contentBytes, encoding);

    return {'type': 'text', 'id': id, 'text': text};
  }

  static Map<String, dynamic> _decodeUserTextFrame(Uint8List data) {
    final encoding = data[0];
    final rest = data.sublist(1);
    final parts = _splitEncoded(rest, encoding);

    return {
      'type': 'user_text',
      'description': parts[0],
      'value': parts.length > 1 ? parts[1] : '',
    };
  }

  // URL FRAMES ---------------------------------------------------------------

  static Map<String, dynamic> _decodeUserUrlFrame(Uint8List data) {
    final encoding = data[0];
    final rest = data.sublist(1);
    final parts = _splitEncoded(rest, encoding);

    return {
      'type': 'user_url',
      'description': parts[0],
      'url': parts.length > 1 ? parts[1] : '',
    };
  }

  // COMMENT ------------------------------------------------------------------

  static Map<String, dynamic> _decodeCommentFrame(Uint8List data) {
    final encoding = data[0];
    final lang = utf8.decode(data.sublist(1, 4));
    final rest = data.sublist(4);
    final parts = _splitEncoded(rest, encoding);

    return {
      'type': 'comment',
      'language': lang,
      'description': parts[0],
      'text': parts.length > 1 ? parts[1] : '',
    };
  }

  // APIC ---------------------------------------------------------------------

  static Map<String, dynamic> _decodeApicFrame(Uint8List data) {
    final encoding = data[0];
    int pos = 1;

    final mimeEnd = data.indexOf(0, pos);
    final mime = utf8.decode(data.sublist(pos, mimeEnd));
    pos = mimeEnd + 1;

    final pictureType = data[pos];
    pos++;

    final descEnd = _findTerminator(data, pos, encoding);
    final description = _decodeString(data.sublist(pos, descEnd), encoding);
    pos = descEnd + (encoding == 1 ? 2 : 1);

    final imageData = data.sublist(pos);

    return {
      'type': 'picture',
      'mime': mime,
      'pictureType': pictureType,
      'description': description,
      'imageBytes': imageData,
    };
  }

  // LYRICS -------------------------------------------------------------------

  static Map<String, dynamic> _decodeLyricsFrame(Uint8List data) {
    final encoding = data[0];
    final lang = utf8.decode(data.sublist(1, 4));
    final rest = data.sublist(4);
    final parts = _splitEncoded(rest, encoding);

    return {
      'type': 'lyrics',
      'language': lang,
      'description': parts[0],
      'text': parts.length > 1 ? parts[1] : '',
    };
  }

  static Map<String, dynamic> _decodeSyncedLyricsFrame(Uint8List data) {
    final encoding = data[0];
    final lang = utf8.decode(data.sublist(1, 4));
    final timestampFormat = data[4];
    final contentType = data[5];

    final rest = data.sublist(6);
    final parts = _splitEncoded(rest, encoding);

    return {
      'type': 'synced_lyrics',
      'language': lang,
      'timestampFormat': timestampFormat,
      'contentType': contentType,
      'description': parts[0],
      'text': parts.length > 1 ? parts[1] : '',
    };
  }

  // GEOB ---------------------------------------------------------------------

  static Map<String, dynamic> _decodeGeobFrame(Uint8List data) {
    final encoding = data[0];
    int pos = 1;

    final mimeEnd = data.indexOf(0, pos);
    final mime = utf8.decode(data.sublist(pos, mimeEnd));
    pos = mimeEnd + 1;

    final filenameEnd = _findTerminator(data, pos, encoding);
    final filename = _decodeString(data.sublist(pos, filenameEnd), encoding);
    pos = filenameEnd + (encoding == 1 ? 2 : 1);

    final descEnd = _findTerminator(data, pos, encoding);
    final description = _decodeString(data.sublist(pos, descEnd), encoding);
    pos = descEnd + (encoding == 1 ? 2 : 1);

    final objectData = data.sublist(pos);

    return {
      'type': 'geob',
      'mime': mime,
      'filename': filename,
      'description': description,
      'data': objectData,
    };
  }

  // POPM ---------------------------------------------------------------------

  static Map<String, dynamic> _decodePopmFrame(Uint8List data) {
    int pos = data.indexOf(0);
    final email = utf8.decode(data.sublist(0, pos));
    pos++;

    final rating = data[pos];
    final counter = data.sublist(pos + 1);

    return {
      'type': 'popularimeter',
      'email': email,
      'rating': rating,
      'counter': counter,
    };
  }

  // PRIV ---------------------------------------------------------------------

  static Map<String, dynamic> _decodePrivFrame(Uint8List data) {
    int pos = data.indexOf(0);
    final owner = utf8.decode(data.sublist(0, pos));
    final payload = data.sublist(pos + 1);

    return {'type': 'private', 'owner': owner, 'data': payload};
  }

  // UFID ---------------------------------------------------------------------

  static Map<String, dynamic> _decodeUfidFrame(Uint8List data) {
    int pos = data.indexOf(0);
    final owner = utf8.decode(data.sublist(0, pos));
    final id = data.sublist(pos + 1);

    return {'type': 'ufid', 'owner': owner, 'id': id};
  }

  // HELPERS ------------------------------------------------------------------

  static String _decodeString(Uint8List bytes, int encoding) {
    switch (encoding) {
      case 0:
        return latin1.decode(bytes);
      case 1:
        return utf8.decode(bytes);
      default:
        return utf8.decode(bytes);
    }
  }

  static List<String> _splitEncoded(Uint8List bytes, int encoding) {
    final term =
        encoding == 1 ? Uint8List.fromList([0, 0]) : Uint8List.fromList([0]);

    int idx = _findTerminator(bytes, 0, encoding);
    if (idx < 0) return [_decodeString(bytes, encoding)];

    final first = _decodeString(bytes.sublist(0, idx), encoding);

    final skip = encoding == 1 ? 2 : 1;
    final second = bytes.length > idx + skip
        ? _decodeString(bytes.sublist(idx + skip), encoding)
        : '';

    return [first, second];
  }

  static int _findTerminator(Uint8List bytes, int start, int encoding) {
    if (encoding == 1) {
      for (int i = start; i < bytes.length - 1; i++) {
        if (bytes[i] == 0 && bytes[i + 1] == 0) return i;
      }
      return -1;
    } else {
      return bytes.indexOf(0, start);
    }
  }
}
