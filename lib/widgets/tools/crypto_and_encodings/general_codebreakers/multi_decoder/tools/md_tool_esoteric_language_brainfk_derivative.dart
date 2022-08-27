import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivative.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE =
    'multidecoder_tool_esotericlanguage_brainfk_derivate_title';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE = 'common_language';

const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK = 'brainfk_title';

class MultiDecoderToolEsotericLanguageBrainfkDerivate extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageBrainfkDerivate(
      {Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE,
            optionalKey: true,
            onDecode: (String input, String key) {
              if (options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE] ==
                  MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK) {
                try {
                  return interpretBrainfk(input, input: key);
                } catch (e) {
                  return null;
                }
              } else {
                var bfDerivatives = switchMapKeyValue(
                    BRAINFK_DERIVATIVES)[options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE]];
                if (bfDerivatives == null) return null;

                try {
                  return bfDerivatives.interpretBrainfkDerivatives(input, input: key);
                } catch (e) {
                  return null;
                }
              }
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE] = newValue;
                },
                items: ([MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK] + BRAINFK_DERIVATIVES.values.toList())
                    .map((language) {
                  return GCWDropDownMenuItem(
                    value: language,
                    child: i18n(context, language) ?? language,
                  );
                }).toList(),
              )
            }));
}
