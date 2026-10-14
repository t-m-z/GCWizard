import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/links/link_view_data.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';

class LinkView extends StatefulWidget {
  const LinkView({
    super.key,
  });

  @override
  _LinkViewState createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {
  final _PADDING_CONTAINER = EdgeInsets.only(top: 15, bottom: 10);

  Container _buildUrl(String key) {
    return Container(
        padding: _PADDING_CONTAINER,
        child: Row(children: <Widget>[
          Expanded(
              flex: 2,
              child: GCWText(
                  text: LINK[key]![0],)
          ),
          Expanded(
              flex: 3,
              child: buildUrl(
                LINK[key]![1],
                LINK[key]![1],
              )
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_common_tools'),
            child: Column(
              children: [
                _buildUrl('netteleute'),
                _buildUrl('cyberchef'),
                _buildUrl('cachesleuth'),
                _buildUrl('geocachingmysterytoolbox'),
                _buildUrl('dennistreysa'),
                _buildUrl('mysterymaster'),
                _buildUrl('kryptografie'),
                _buildUrl('dcode'),
                _buildUrl('codeknacker'),
                _buildUrl('boxentriq'),
                _buildUrl('cryptii'),
                _buildUrl('cipheridentifier'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_stegano_tools'),
            child: Column(
              children: [
                _buildUrl('steg01'),
                _buildUrl('steg02'),
                _buildUrl('steg03'),
                _buildUrl('steg04'),
                _buildUrl('steg05'),
                _buildUrl('steg06'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_image_tools'),
            child: Column(
              children: [
                _buildUrl('magiceye'),
                _buildUrl('ezgif'),
                _buildUrl('decryptimage'),
                _buildUrl('fotoforensic'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_audio_tools'),
            child: Column(
              children: [
                _buildUrl('oscilloscope'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_math_tools'),
            child: Column(
              children: [
                _buildUrl('wolfram'),
                _buildUrl('numbersequence'),
                _buildUrl('numberempire'),
                _buildUrl('pi'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_science_tools'),
            child: Column(
              children: [
                _buildUrl('sun'),
                _buildUrl('circuit'),
                _buildUrl('chemistry'),
                _buildUrl('logicly'),
                _buildUrl('epochconverter'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_letter_tools'),
            child: Column(
              children: [
                _buildUrl('anagram'),
                _buildUrl('wortsuchen'),
              ],
            ),
          ),
          GCWExpandableTextDivider(
            suppressTopSpace: false,
            expanded: false,
            text: i18n(context, 'linkview_section_misc_tools'),
            child: Column(
              children: [
                _buildUrl('wigcrumbler'),
                _buildUrl('coordinates'),
                _buildUrl('lab2gpx'),
                _buildUrl('flopp'),
                _buildUrl('samuraisudoku'),
                _buildUrl('steno'),
                _buildUrl('jigidi'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
