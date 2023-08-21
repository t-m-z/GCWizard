import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/images_and_files/magic_eye_solver/logic/magic_eye_solver.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:image/image.dart' as Image;
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';

class MagicEyeSolver extends StatefulWidget {
  const MagicEyeSolver({Key? key}) : super(key: key);

  @override
 _MagicEyeSolverState createState() => _MagicEyeSolverState();
}

class _MagicEyeSolverState extends State<MagicEyeSolver> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  GCWFile? _decodeImage;
  Image.Image? _decodeImageData;
  Uint8List? _decodeOutData;
  int? _displacement;
  GCWFile? _encodeHiddenDataImage;
  GCWFile? _encodeTextureImage;
  Uint8List? _encodeOutData;
  TextureType _currentEncodeTextureType = TextureType.BITMAP;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.right ? _decodeWidgets() : _encodeWidgets()
    ]);
  }

  Widget _decodeWidgets() {
    return Column(children: [
      GCWOpenFile(
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        file: _decodeImage,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }

          _decodeImage = _file;
          _decodeImageData = null;
          _decodeOutData = null;
          _displacement = null;

          if (_decodeImage == null) return;
          decodeImageAsync(_buildJobDataDecode()).then((output) {
            _saveOutputDecode(output);
          });
        },
      ),
      Container(height: 25),
      GCWIntegerSpinner(
        title: i18n(context, 'magic_eye_offset'),
        value: _displacement ?? 0,
        onChanged: (value) {
          setState(() {
            _displacement = value;
            _decodeOutData = null;

            if (_decodeImage == null) return;
            decodeImageAsync(_buildJobDataDecode()).then((output) {
              _saveOutputDecode(output);
            });
          });
        },
      ),
      GCWDefaultOutput(child: _buildOutputDecode())
    ]);
  }

  Widget _buildOutputDecode() {
    if (_decodeOutData == null) return Container();

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _decodeOutData!)),
        toolBarRight: false,
        fileName: buildFileNameWithDate('img_', null),
      ),
    ]);
  }

  GCWAsyncExecuterParameters _buildJobDataDecode() {
    return GCWAsyncExecuterParameters(
        Tuple3<Uint8List, Image.Image?, int?>(_decodeImage!.bytes, _decodeImageData, _displacement));
  }

  void _saveOutputDecode(Tuple3<Image.Image, Uint8List, int>? output) {
    _decodeImageData = output?.item1;
    _decodeOutData = output?.item2;
    _displacement = output?.item3;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  Widget _encodeWidgets() {
    return Column(children: [
      Container(height: 20),
      GCWOpenFile(
        title: i18n(context, 'magic_eye_hidden_image'),
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        file: _encodeHiddenDataImage,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }
          _encodeHiddenDataImage = _file;
          _generateEncodeImage();
        },
      ),
      Container(), // fixes strange behaviour: First GCWOpenFile widget from encode/decode affect each other
      _buildEncodeTextureSelection(),

      GCWDefaultOutput(child: _buildOutputEncode())
    ]);
  }

  Widget _buildEncodeTextureSelection() {
    return Column(children: [
      GCWTextDivider(text: i18n(context, 'magic_eye_texture_image')),
      GCWDropDown<TextureType>(
          value: _currentEncodeTextureType,
          onChanged: (value) {
            setState(() {
              _currentEncodeTextureType = value;
              _generateEncodeImage();
            });
          },
          items: [
            GCWDropDownMenuItem(
              value: TextureType.BITMAP,
              child: i18n(context, 'magic_eye_texture_bitmap'),
            ),
            GCWDropDownMenuItem(
              value: TextureType.COLORDOTS,
              child: i18n(context, 'magic_eye_texture_colordots'),
            ),
            GCWDropDownMenuItem(
              value: TextureType.GREYDOTS,
              child: i18n(context, 'magic_eye_texture_graydots'),
            )
          ]),
      _currentEncodeTextureType == TextureType.BITMAP
          ? GCWOpenFile(
              supportedFileTypes: SUPPORTED_IMAGE_TYPES,
              file: _encodeTextureImage,
              onLoaded: (_file) {
                if (_file == null) {
                  showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                  return;
                }
                _encodeTextureImage = _file;
                _generateEncodeImage();
              },
            )
          : Container(),
    ]);
  }

  Widget _buildOutputEncode() {
    if (_encodeOutData == null) return Container();

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _encodeOutData!)),
        toolBarRight: false,
        fileName: buildFileNameWithDate('img_', null),
      ),
    ]);
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataEncode() async {
    return GCWAsyncExecuterParameters(Tuple3<Uint8List?, Uint8List?, TextureType?>(
        _encodeHiddenDataImage?.bytes, _encodeTextureImage?.bytes, _currentEncodeTextureType));
  }

  void _saveOutputEncode(Tuple2<Uint8List?, MagicEyeErrorCode>? output) {
    if (output == null) {
      _encodeOutData = null;
      return;
    }

    _encodeOutData = output.item1;
    if (output.item2 == MagicEyeErrorCode.IMAGE_TOO_SMALL) showToast(i18n(context, 'magic_eye_image_too_small'));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _generateEncodeImage() async {
    if (_encodeHiddenDataImage == null ||
        (_currentEncodeTextureType == TextureType.BITMAP && _encodeTextureImage == null)) return;

    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<Tuple2<Uint8List?, MagicEyeErrorCode>?>(
              isolatedFunction: generateImageAsync,
              parameter: _buildJobDataEncode,
              onReady: (data) => _saveOutputEncode(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }
}
