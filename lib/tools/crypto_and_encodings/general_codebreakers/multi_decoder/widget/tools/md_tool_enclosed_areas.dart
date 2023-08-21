import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enclosed_areas/logic/enclosed_areas.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';

const MDT_INTERNALNAMES_ENCLOSEDAREAS = 'multidecoder_tool_enclosedareas_title';
const MDT_ENCLOSEDAREAS_OPTION_MODE = 'multidecoder_tool_bacon_option_mode';
const MDT_ENCLOSEDAREAS_OPTION_WITH4 = 'enclosedareas_with4';
const MDT_ENCLOSEDAREAS_OPTION_WITHOUT4 = 'enclosedareas_without4';

class MultiDecoderToolEnclosedAreas extends AbstractMultiDecoderTool {
  MultiDecoderToolEnclosedAreas({
    Key? key,
    required int id,
    required String name,
    required Map<String, Object?> options,
    required BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ENCLOSEDAREAS,
            onDecode: (String input, String key) {
              return decodeEnclosedAreas(input,
                  with4: checkStringFormatOrDefaultOption(MDT_INTERNALNAMES_ENCLOSEDAREAS, options, MDT_ENCLOSEDAREAS_OPTION_MODE) == MDT_ENCLOSEDAREAS_OPTION_WITH4);
            },
            options: options);
  @override
  State<StatefulWidget> createState() => _MultiDecoderToolEnclosedAreasState();
}

class _MultiDecoderToolEnclosedAreasState extends State<MultiDecoderToolEnclosedAreas> {
  @override
  Widget build(BuildContext context) {
    return createMultiDecoderToolConfiguration(
        context, {
      MDT_ENCLOSEDAREAS_OPTION_MODE: GCWDropDown<String>(
        value: checkStringFormatOrDefaultOption(MDT_INTERNALNAMES_ENCLOSEDAREAS, widget.options, MDT_ENCLOSEDAREAS_OPTION_MODE),
        onChanged: (newValue) {
          setState(() {
            widget.options[MDT_ENCLOSEDAREAS_OPTION_MODE] = newValue;
          });
        },
        items: [MDT_ENCLOSEDAREAS_OPTION_WITH4, MDT_ENCLOSEDAREAS_OPTION_WITHOUT4].map((mode) {
          return GCWDropDownMenuItem(
            value: mode,
            child: i18n(context, mode),
          );
        }).toList(),
      )
    }
    );
  }
}
