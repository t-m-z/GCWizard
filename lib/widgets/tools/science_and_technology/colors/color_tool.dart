import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_cmyk.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_hue.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_yuv.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/base/gcw_colors.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';

class ColorTool extends StatefulWidget {
  final RGB color;

  const ColorTool({Key key, this.color}) : super(key: key);

  @override
  ColorToolState createState() => ColorToolState();
}

class ColorToolState extends State<ColorTool> {
  dynamic _currentColor = defaultColor;
  String _currentColorSpace = keyColorSpaceRGB;
  String _currentOutputColorSpace = keyColorSpaceHex;

  final NumberFormat _numberFormat = NumberFormat('0.' + '#' * COLOR_DOUBLE_PRECISION);

  @override
  void initState() {
    super.initState();

    _currentColor = widget.color ?? defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWColors(
          color: _currentColor,
          colorSpace: _currentColorSpace,
          onChanged: (value) {
            setState(() {
              _currentColorSpace = value['colorSpace'];
              _currentColor = value['color'];
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'colors_outputcolorspace')),
        GCWDropDownButton(
          value: _currentOutputColorSpace,
          items: allColorSpaces.map((colorSpace) {
            return GCWDropDownMenuItem(value: colorSpace.key, child: i18n(context, colorSpace.name));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentOutputColorSpace = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var colorSpaceOutputs;

    switch (_currentOutputColorSpace) {
      case keyColorSpaceRGB:
        RGB rgb = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceRGB);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_rgb_red'), _numberFormat.format(rgb.red)],
          [i18n(context, 'colors_colorspace_rgb_green'), _numberFormat.format(rgb.green)],
          [i18n(context, 'colors_colorspace_rgb_blue'), _numberFormat.format(rgb.blue)]
        ];
        break;
      case keyColorSpaceHex:
        HexCode hex = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHex);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_hex_hexcode'), hex.toString()],
          [i18n(context, 'colors_colorspace_hex_shorthexcode'), (hex.isShortHex ? hex.shortHexCode : '-')]
        ];
        break;
      case keyColorSpaceHSV:
        HSV hsv = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSV);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_hsv_hue'), _numberFormat.format(hsv.hue)],
          [i18n(context, 'colors_colorspace_hsv_saturation'), _numberFormat.format(hsv.saturation * 100.0)],
          [i18n(context, 'colors_colorspace_hsv_value'), _numberFormat.format(hsv.value * 100.0)]
        ];
        break;
      case keyColorSpaceHSL:
        HSL hsl = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSL);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_hsl_hue'), _numberFormat.format(hsl.hue)],
          [i18n(context, 'colors_colorspace_hsl_saturation'), _numberFormat.format(hsl.saturation * 100.0)],
          [i18n(context, 'colors_colorspace_hsl_lightness'), _numberFormat.format(hsl.lightness * 100.0)]
        ];
        break;
      case keyColorSpaceHSI:
        HSI hsi = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSI);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_hsi_hue'), _numberFormat.format(hsi.hue)],
          [i18n(context, 'colors_colorspace_hsi_saturation'), _numberFormat.format(hsi.saturation * 100.0)],
          [i18n(context, 'colors_colorspace_hsi_intensity'), _numberFormat.format(hsi.intensity * 100.0)]
        ];
        break;
      case keyColorSpaceCMYK:
        CMYK cmyk = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceCMYK);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_cmyk_cyan'), _numberFormat.format(cmyk.cyan * 100.0)],
          [i18n(context, 'colors_colorspace_cmyk_magenta'), _numberFormat.format(cmyk.magenta * 100.0)],
          [i18n(context, 'colors_colorspace_cmyk_yellow'), _numberFormat.format(cmyk.yellow * 100.0)],
          [i18n(context, 'colors_colorspace_cmyk_key'), _numberFormat.format(cmyk.key * 100.0)]
        ];
        break;
      case keyColorSpaceCMY:
        CMY cmy = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceCMY);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_cmy_cyan'), _numberFormat.format(cmy.cyan * 100.0)],
          [i18n(context, 'colors_colorspace_cmy_magenta'), _numberFormat.format(cmy.magenta * 100.0)],
          [i18n(context, 'colors_colorspace_cmy_yellow'), _numberFormat.format(cmy.yellow * 100.0)]
        ];
        break;
      case keyColorSpaceYUV:
        YUV yuv = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYUV);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_yuv_y'), _numberFormat.format(yuv.y * 100.0)],
          [i18n(context, 'colors_colorspace_yuv_u'), _numberFormat.format(yuv.u * 100.0)],
          [i18n(context, 'colors_colorspace_yuv_v'), _numberFormat.format(yuv.v * 100.0)]
        ];
        break;
      case keyColorSpaceYPbPr:
        YPbPr yPbPr = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYPbPr);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_ypbpr_y'), _numberFormat.format(yPbPr.y * 100.0)],
          [i18n(context, 'colors_colorspace_ypbpr_pb'), _numberFormat.format(yPbPr.pb * 100.0)],
          [i18n(context, 'colors_colorspace_ypbpr_pr'), _numberFormat.format(yPbPr.pr * 100.0)]
        ];
        break;
      case keyColorSpaceYCbCr:
        YCbCr yCbCr = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYCbCr);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_ycbcr_y'), _numberFormat.format(yCbCr.y)],
          [i18n(context, 'colors_colorspace_ycbcr_cb'), _numberFormat.format(yCbCr.cb)],
          [i18n(context, 'colors_colorspace_ycbcr_cr'), _numberFormat.format(yCbCr.cr)]
        ];
        break;
      case keyColorSpaceYIQ:
        YIQ yiq = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYIQ);
        colorSpaceOutputs = [
          [i18n(context, 'colors_colorspace_yiq_y'), _numberFormat.format(yiq.y * 100.0)],
          [i18n(context, 'colors_colorspace_yiq_i'), _numberFormat.format(yiq.i * 100.0)],
          [i18n(context, 'colors_colorspace_yiq_q'), _numberFormat.format(yiq.q * 100.0)]
        ];
        break;
    }

    var rows = columnedMultiLineOutput(context, colorSpaceOutputs);

    rows.insert(0, GCWTextDivider(text: i18n(context, 'common_output')));

    return Column(children: rows);
  }
}
