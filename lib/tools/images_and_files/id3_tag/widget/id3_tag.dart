import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/images_and_files/id3_tag/logic/id3_tag.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';

import 'package:id3_codec/encode_metadata.dart';
import 'package:id3_codec/id3_encoder.dart';

class ID3Tag extends StatefulWidget {
  const ID3Tag({Key? key}) : super(key: key);

  @override
  _ID3TagState createState() => _ID3TagState();
}

class _ID3TagState extends State<ID3Tag> {
  GCWFile? _currentSoundFile;
  GCWFile? _currentImageFile;

  String _currentArtist = '';
  String _currentTitle = '';
  String _currentAlbum = '';
  String _currentYear = '';
  String _currentComment = '';
  String _currentTrack = '0';
  String _currentGenre = '0';

  late TextEditingController _artistController;
  late TextEditingController _albumController;
  late TextEditingController _titleController;
  late TextEditingController _commentController;
  late TextEditingController _yearController;

  ID3TagList _ID3TagList = EMPTY_ID3TAGLIST;

  ID3TagData _ID3TagDataSet = EMPTY_ID3TAGDATASET;

  bool _soundFileLoaded = false;
  bool _imageFileLoaded = false;

  @override
  initState() {
    super.initState();

    _artistController = TextEditingController(text: _currentArtist);
    _albumController = TextEditingController(text: _currentAlbum);
    _titleController = TextEditingController(text: _currentTitle);
    _commentController = TextEditingController(text: _currentComment);
    _yearController = TextEditingController(text: _currentYear);
  }

  @override
  void dispose() {
    _artistController.dispose();
    _albumController.dispose();
    _titleController.dispose();
    _commentController.dispose();
    _yearController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildWidgetOpenSoundFile(),
        //_buildWidgetModeSwitchReadWrite(),
        //(_currentMode == GCWSwitchPosition.right)
        //    ? _buildWidgetInputMetaData()
        //    : Container(),
        _buildOutput()
      ],
    );
  }

  Widget _widgetOutputV1() {
    List<int> resultBytes = [];
    _currentAlbum = _ID3TagDataSet.ID3v1data.tags['Album']!;
    _currentArtist = _ID3TagDataSet.ID3v1data.tags['Artist']!;
    _currentTitle = _ID3TagDataSet.ID3v1data.tags['Title']!;
    _currentYear = _ID3TagDataSet.ID3v1data.tags['Year']!;
    _currentComment = _ID3TagDataSet.ID3v1data.tags['Comment']!;
    _currentGenre = _ID3TagDataSet.ID3v1data.tags['Genre']!;
    _currentTrack = _ID3TagDataSet.ID3v1data.tags['Track']!;
    return Column(
      children: [
        Row(// Artist
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.only(right: DEFAULT_MARGIN),
              child: Text(i18n(context, 'metadata_artist'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                controller: _artistController,
                onChanged: (text) {
                  setState(() {
                    _currentArtist = text;
                  });
                },
              ),
            )),
          ],
        ),
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_title'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                controller: _titleController,
                onChanged: (text) {
                  setState(() {
                    _currentTitle = text;
                  });
                },
              ),
            )),
          ],
        ),
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_album'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                controller: _albumController,
                onChanged: (text) {
                  setState(() {
                    _currentAlbum = text;
                  });
                },
              ),
            )),
          ],
        ),  // Album
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_comment'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                controller: _commentController,
                onChanged: (text) {
                  setState(() {
                    _currentComment = text;
                  });
                },
              ),
            )),
          ],
        ),  // Comment
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_year'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: GCWTextField(
                controller: _yearController,
                onChanged: (text) {
                  setState(() {
                    _currentYear = text;
                  });
                },
              ),
            )),
          ],
        ),  // Comment
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_genre'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: Container(),
            )),
          ],
        ),  // Genre
        Row(// Artist
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                child: Text(i18n(context, 'metadata_track'))
            )),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              child: Container(),
            )),
          ],
        ),  // Track
        GCWButton(
            text: i18n(context, 'metadata_write'),
            onPressed: () {
              final encoder = ID3Encoder(_currentSoundFile?.bytes as List<int>);

              resultBytes = encoder.encodeSync(MetadataV1Body(
                title: _currentTitle,
                artist: _currentArtist,
                album: _currentAlbum,
                year: _currentYear,
                comment: _currentComment,
                track: int.parse(_currentTrack),
                genre: int.parse(_currentGenre),
              ));

              _exportFile(context, Uint8List.fromList(resultBytes),
                  _currentSoundFile!.name!);

              setState(() {
                _ID3TagList =
                    decodeID3MetaData(Uint8List.fromList(resultBytes));
              });
            })
      ],
    );
  }

  Widget _widgetOutputV23() {
    return Column();
  }

  Widget _widgetOutputV24() {
    return Column();
  }

  Widget _buildOutput() {
    if (!_soundFileLoaded) {
      return Container();
    }

    switch (_ID3TagDataSet.version) {
      case null:
      case ID3_VERSION.NULL:
        return Container();
      case ID3_VERSION.V10:
      case ID3_VERSION.V11:
        return _widgetOutputV1();
      case ID3_VERSION.V23:
        return _widgetOutputV23();
      case ID3_VERSION.V24:
        return _widgetOutputV24();
    }

    return GCWDefaultOutput(
      child: Column(
        children: [
          GCWExpandableTextDivider(
            text: i18n(context, 'metadata_header'),
            child:
                GCWColumnedMultilineOutput(data: _ID3TagList.tableTagsHeader),
          ),
          GCWExpandableTextDivider(
            text: i18n(context, 'metadata_frames'),
            child:
                GCWColumnedMultilineOutput(data: _ID3TagList.tableTagsFrames),
          ),
          GCWExpandableTextDivider(
            text: i18n(context, 'metadata_padding'),
            child:
                GCWColumnedMultilineOutput(data: _ID3TagList.tableTagsPadding),
          ),
          _ID3TagList.tableTagsImages.isNotEmpty
              ? _buildImageOutput(_ID3TagList.tableTagsImages)
              : Container(),
          _ID3TagList.tableTagsMisc.isNotEmpty
              ? GCWExpandableTextDivider(
                  text: i18n(context, 'metadata_miscelleanous'),
                  child: GCWColumnedMultilineOutput(
                      data: _ID3TagList.tableTagsMisc),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildImageOutput(List<List<String>> imageData) {
    if (imageData.isEmpty) return Container();

    List<Widget> result = [];

    for (var imageEntry in imageData) {
      result.add(GCWImageView(
          imageData: GCWImageViewData(GCWFile(
              bytes:
                  Uint8List.fromList(decodeBase64(imageEntry[2]).codeUnits)))));
    }

    return GCWExpandableTextDivider(
        text: i18n(context, 'metadata_images'),
        child: Column(
          children: result,
        ));
  }

  Widget _buildWidgetOpenImageFile() {
    return GCWOpenFile(
      title: i18n(context, 'metadata_imagefile'),
      supportedFileTypes: SUPPORTED_IMAGE_TYPES,
      suppressGallery: false,
      onLoaded: (_imageFile) {
        if (_imageFile == null) {
          showSnackBar(
              i18n(context, 'common_loadfile_exception_notloaded'), context);
          return;
        }
        _currentImageFile = _imageFile;
        _imageFileLoaded = true;
        setState(() {});
      },
    );
  }

  Widget _buildWidgetOpenSoundFile() {
    return GCWOpenFile(
      title: i18n(context, 'metadata_soundfile'),
      supportedFileTypes: SUPPORTED_SOUND_TYPES,
      suppressGallery: true,
      onLoaded: (_file) {
        if (_file == null) {
          showSnackBar(
              i18n(context, 'common_loadfile_exception_notloaded'), context);
          return;
        }
        _soundFileLoaded = true;
        _currentSoundFile = _file;

        _ID3TagList = decodeID3MetaData(_currentSoundFile!.bytes);
        _ID3TagDataSet = ID3MetaInfoToDataSet(_currentSoundFile!.bytes);

        setState(() {});
      },
    );
  }

  Future<void> _exportFile(
      BuildContext context, Uint8List data, String filename) async {
    await saveByteDataToFile(context, data, filename).then((value) {
      if (value) {
        showExportedFileDialog(
          context,
        );
      }
    });
  }
}
