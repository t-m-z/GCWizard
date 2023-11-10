import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/logic/hexstring2file.dart';
import 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:prefs/prefs.dart';

class OpenAI extends StatefulWidget {
  const OpenAI({Key? key}) : super(key: key);

  @override
  _OpenAIState createState() => _OpenAIState();
}

class _OpenAIState extends State<OpenAI> {
  late TextEditingController _promptController;

  String _currentPrompt = '';
  String _currentAPIkey = Prefs.getString(PREFERENCE_CHATGPT_API_KEY);
  double _currentTemperature = 0.0;
  double _currentSpeed = 1.0;
  String _currentVoice = 'alloy';
  String _currentOutput = '';
  String _currentModel = 'gpt-3.5-turbo-instruct';
  String _currentImageData = '';
  String _currentImageSize = '256x256';
  Uint8List _currentAudioFile = Uint8List.fromList([]);
  OPENAI_TASK _currentTask = OPENAI_TASK.CHAT;

  bool _loadFile = false;

  Widget _outputWidget = Container();

  Map<String, String> _modelIDs = {};

  GCWSwitchPosition _currentImageMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    for (String model in MODELS_CHAT) {
      _modelIDs[model] = model;
    }
    for (String model in MODELS_COMPLETIONS) {
      _modelIDs[model] = model;
    }

    _promptController = TextEditingController(text: _currentPrompt);
  }

  @override
  void dispose() {
    _promptController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<OPENAI_TASK>(
          title: i18n(context, 'openai_task'),
          value: _currentTask,
          items: OPENAI_TASK_LIST.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: i18n(context, mode.key),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentTask = value;
            });
          },
        ),
        _currentTask == OPENAI_TASK.CHAT
            ? Column(
                children: <Widget>[
                  GCWDropDown<String>(
                    title: i18n(context, 'openai_model'),
                    value: _currentModel,
                    items: _modelIDs.entries.map((mode) {
                      return GCWDropDownMenuItem(
                        value: mode.key,
                        child: mode.value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentModel = value;
                      });
                    },
                  ),
                  GCWDoubleSpinner(
                      title: i18n(context, 'openai_temperature'),
                      min: 0,
                      max: 1,
                      numberDecimalDigits: 6,
                      onChanged: (value) {
                        setState(() {
                          _currentTemperature = value;
                        });
                      },
                      value: _currentTemperature),
                ],
              )
            : Container(),
        _currentTask == OPENAI_TASK.IMAGE
            ? Column(children: <Widget>[
                GCWDropDown<String>(
                  title: i18n(context, 'openai_size'),
                  value: _currentImageSize,
                  items: OPEN_AI_IMAGE_SIZE.entries.map((mode) {
                    return GCWDropDownMenuItem(
                      value: mode.key,
                      child: mode.value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentImageSize = value;
                    });
                  },
                ),
                GCWTwoOptionsSwitch(
                  leftValue: i18n(context, 'openai_image_url'),
                  rightValue: i18n(context, 'openai_image'),
                  value: _currentImageMode,
                  onChanged: (value) {
                    setState(() {
                      _currentImageMode = value;
                    });
                  },
                ),
              ])
            : Container(),
        _currentTask == OPENAI_TASK.SPEECH
            ? Column(children: <Widget>[
                GCWDropDown<String>(
                  title: i18n(context, 'openai_voice'),
                  value: _currentVoice,
                  items: OPEN_AI_SPEECH_VOICE.entries.map((mode) {
                    return GCWDropDownMenuItem(
                      value: mode.key,
                      child: mode.value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentVoice = value;
                    });
                  },
                ),
                GCWDoubleSpinner(
                    title: i18n(context, 'openai_speed'),
                    min: 0.25,
                    max: 4,
                    numberDecimalDigits: 6,
                    onChanged: (value) {
                      setState(() {
                        _currentSpeed = value;
                      });
                    },
                    value: _currentSpeed),
                GCWOpenFile(
                  onLoaded: (_file) {
                    if (_file == null) {
                      showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
                      return;
                    }
                    _currentAudioFile = _file.bytes;
                    setState(() {});
                  },
                ),
              ])
            : Container(),
        GCWTextDivider(
          text: i18n(context, 'openai_prompt'),
          suppressTopSpace: true,
          suppressBottomSpace: true,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GCWIconButton(
                icon: Icons.file_open,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  setState(() {
                    _loadFile = !_loadFile;
                  });
                },
              ),
              GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  _exportFile(
                    context,
                    Uint8List.fromList(_currentPrompt.codeUnits),
                  );
                },
              ),
            ],
          ),
        ),
        GCWTextField(
          controller: _promptController,
          onChanged: (text) {
            setState(() {
              _currentPrompt = text;
            });
          },
        ),
        if (_loadFile)
          GCWOpenFile(
            onLoaded: (_file) {
              if (_file == null) {
                showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
                _loadFile = !_loadFile;
                return;
              }
              _currentPrompt = String.fromCharCodes(_file.bytes);
              _loadFile = !_loadFile;
              setState(() {});
            },
          ),
        GCWButton(
          text: i18n(context, 'common_start'),
          onPressed: () {
            setState(() {
              _calcOutput();
            });
          },
        ),
        _outputWidget,
      ],
    );
  }

  void _calcOutput() {
    _getOpenAItask();
    //if (_currentMode == GCWSwitchPosition.left) {
    //  _getChatGPTtext();
    //  setState(() {});
    //} else {
    //  _getChatGPTimage();
    //}
  }

  void _exportFile(
    BuildContext context,
    Uint8List data,
  ) async {
    bool value = false;
    String filename = buildFileNameWithDate('openai.dart', null) + '.prompt';
    value = await saveByteDataToFile(context, data, filename);
    if (value) showExportedFileDialog(context);
  }

  void _getOpenAItask() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<OpenAItaskOutput>(
              isolatedFunction: OpenAIrunTaskAsync,
              parameter: _buildChatGPTgetJobData,
              onReady: (data) => _showOpenAIOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildChatGPTgetJobData() async {
    return GCWAsyncExecuterParameters(OPENAIgetChatJobData(
      openai_api_key: _currentAPIkey,
      openai_model: _currentModel,
      openai_prompt: _currentPrompt,
      openai_temperature: _currentTemperature,
      openai_image_size: _currentImageSize,
      openai_image_url: _currentImageMode == GCWSwitchPosition.left,
      openai_speed: _currentSpeed,
      openai_voice: _currentVoice,
      openai_audiofile: _currentAudioFile,
      openai_task: _currentTask,
    ));
  }

  void _showOpenAIOutput(OpenAItaskOutput output) {
    if (output.status == OPENAI_TASK_STATUS.OK) {
      switch (_currentTask) {
        case OPENAI_TASK.CHAT:
          var outputMap = jsonDecode(output.textData);
          _currentOutput = outputMap['choices'][0]['text'] as String;
          _outputWidget = GCWDefaultOutput(
            child: _currentOutput,
            trailing: GCWIconButton(
              icon: Icons.email_outlined,
              size: IconButtonSize.SMALL,
              onPressed: () async {
                final Email email = Email(
                  body: 'Model: ' +
                      _currentModel +
                      '\n' +
                      'Prompt: ' +
                      _currentPrompt +
                      '\n' +
                      'Temperature: ' +
                      _currentTemperature.toString() +
                      '\n' +
                      _currentOutput,
                  subject: 'Invalid Content created',
                  recipients: ['thomas@familiezimmermann.de'],
                  //cc: ['cc@example.com'],
                  //bcc: ['bcc@example.com'],
                  //attachmentPaths: ['/path/to/attachment.zip'],
                  isHTML: false,
                );
                try {
                  await FlutterEmailSender.send(email);
                  showSnackBar('SUCCESS - e-Mail send', context);
                } catch (error) {
                  showSnackBar(error.toString(), context);
                }
              },
            ),
          );
          break;
        case OPENAI_TASK.IMAGE:
          var outputMap = jsonDecode(output.imageData);
          if (_currentImageMode == GCWSwitchPosition.left) {
            _currentOutput = outputMap['data'][0]['url'] as String;
            _outputWidget = GCWDefaultOutput(child: _currentOutput);
          } else {
            _currentOutput = outputMap['data'][0]['b64_json'] as String;
            _currentImageData = decodeBase64(_currentOutput);
            _currentImageData = asciiToHexString(_currentImageData);
            var fileData = hexstring2file(_currentImageData);
            _outputWidget = Column(
              children: <Widget>[
                GCWExpandableTextDivider(
                    expanded: false,
                    text: 'BASE64',
                    child: GCWDefaultOutput(
                      child: _currentOutput,
                    )),
                GCWImageView(imageData: GCWImageViewData(GCWFile(bytes: fileData!)))
              ],
            );
          }
          break;
        case OPENAI_TASK.SPEECH:
          break;
        case OPENAI_TASK.AUDIO_TRANSLATE:
          break;
        case OPENAI_TASK.AUDIO_TRANSCRIBE:
          break;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      if (output.status == OPENAI_TASK_STATUS.ERROR) {
        _currentOutput =
            i18n(context, 'openai_error') + '\n' + output.httpCode + '\n' + output.httpMessage + '\n' + output.textData;
      }
    });
  }
}
