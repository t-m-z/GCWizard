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
import 'package:gc_wizard/common_widgets/gcw_soundplayer.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
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
  final _currentAPIkey = Prefs.getString(PREFERENCE_CHATGPT_API_KEY);
  double _currentTemperature = 0.0;
  double _currentSpeed = 1.0;
  String _currentVoice = 'alloy';
  String _currentOutput = '';
  String _currentChatModel = MODELS_CHAT_COMPLETIONS[0]; // gpt-4
  String _currentImageModel = MODELS_IMAGE[0]; // dall-e-2
  String _currentImageData = '';
  String _currentLanguage = 'german';
  String _currentImageSize = '1024x1024';
  String _currentImageQuality = 'standard';
  GCWFile _currentAudioFile = GCWFile(bytes: Uint8List.fromList([]), name: '');

  String _outputId = '';
  String _outputObject = '';
  String _outputCreated = '';
  String _outputModel = '';

  List<int> _currentOutputData = [];
  List<List<String>> _currentChatHistory = [];
  OPENAI_TASK _currentTask = OPENAI_TASK.CHAT;

  bool _loadFile = false;

  Widget _outputWidget = Container();

  Map<String, String> _textModelIDs = {};
  Map<String, String> _imageModelIDs = {};

  GCWSwitchPosition _currentImageMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    for (String model in MODELS_CHAT_COMPLETIONS) {
      _textModelIDs[model] = model;
    }
    for (String model in MODELS_COMPLETIONS) {
      _textModelIDs[model] = model;
    }

    for (String model in MODELS_IMAGE) {
      _imageModelIDs[model] = model;
    }

    _promptController = TextEditingController(text: _currentPrompt);
  }

  @override
  void dispose() {
    _promptController.dispose();

    super.dispose();
  }

  Widget _widgetInputDataChat(){
    return Column(
      children: [
        GCWDropDown<String>(
          title: i18n(context, 'openai_model'),
          value: _currentChatModel,
          items: _textModelIDs.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentChatModel = value;
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
    );
  }

  Widget _widgetInputDataImage(){
    return Column(
      children: [
        GCWDropDown<String>(
          title: i18n(context, 'openai_model'),
          value: _currentImageModel,
          items: _imageModelIDs.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentImageModel = value;
            });
          },
        ),
        GCWDropDown<String>(
          title: i18n(context, 'openai_size'),
          value: _currentImageSize,
          items: OPEN_AI_IMAGE_SIZE[_currentImageModel]!.entries.map((mode) {
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
        GCWDropDown<String>(
          title: i18n(context, 'openai_quality'),
          value: _currentImageQuality,
          items: OPEN_AI_IMAGE_QUALITY[_currentImageModel]!.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentImageQuality = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'openai_image_url'),
          rightValue: i18n(context, 'openai_image_image'),
          value: _currentImageMode,
          onChanged: (value) {
            setState(() {
              _currentImageMode = value;
            });
          },
        ),
      ],
    );
  }

  Widget _widgetInputDataAudioTranslate(){
    return Column(
      children: [
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
        GCWOpenFile(
          onLoaded: (_file) {
            if (_file == null) {
              showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
              return;
            }
            _currentAudioFile = _file;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _widgetInputDataAudioTranscribe(){
    return Column(
      children: [
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
        GCWOpenFile(
          onLoaded: (_file) {
            if (_file == null) {
              showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
              return;
            }
            _currentAudioFile = _file;
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _widgetInputDataSpeech(){
    return Column(
      children: [
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
        GCWDropDown<String>(
          title: i18n(context, 'openai_language'),
          value: _currentLanguage,
          items: OPEN_AI_SPEECH_LANGUAGE.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
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
      ],
    );
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
            _outputWidget = Container();
            setState(() {
              _currentTask = value;
            });
          },
        ),
        _currentTask == OPENAI_TASK.CHAT
            ? _widgetInputDataChat()
            : Container(),
        _currentTask == OPENAI_TASK.IMAGE
            ? _widgetInputDataImage()
            : Container(),
        _currentTask == OPENAI_TASK.AUDIO_TRANSCRIBE
            ? _widgetInputDataAudioTranscribe()
            : Container(),
        _currentTask == OPENAI_TASK.AUDIO_TRANSLATE
            ? _widgetInputDataAudioTranslate()
            : Container(),
        _currentTask == OPENAI_TASK.SPEECH
            ? _widgetInputDataSpeech()
            : Container(),
        Column(children: <Widget>[
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
                          _loadFile = !_loadFile;
                          setState(() {});
                        },
                      ),
                      GCWIconButton(
                        icon: Icons.save,
                        size: IconButtonSize.SMALL,
                        onPressed: () {
                          _exportFile(
                            context,
                            OPENAI_TASK.PROMPT,
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
              ]),
        if (_loadFile)
          GCWOpenFile(
            onLoaded: (_file) {
              if (_file == null) {
                showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
                _loadFile = !_loadFile;
                return;
              }
              _loadFile = !_loadFile;
              setState(() {
                _currentPrompt = String.fromCharCodes(_file.bytes);
                _promptController.text = _currentPrompt;
              });
            },
          ),
        GCWButton(
          text: i18n(context, 'openai_start'),
          onPressed: () {
            setState(() {
              switch (_currentTask) {
                case OPENAI_TASK.AUDIO_TRANSLATE:
                  _currentChatHistory.add(['USER', 'TRANSLATE\nPROMPT: ' + _currentPrompt]);
                  break;
                case OPENAI_TASK.AUDIO_TRANSCRIBE:
                  _currentChatHistory.add(['USER', 'TRANSCRIBE\nPROMPT: ' + _currentPrompt]);
                  break;
                case OPENAI_TASK.IMAGE:
                  _currentChatHistory.add(['USER', 'CREATE IMAGE\nPROMPT: ' + _currentPrompt]);
                  break;
                case OPENAI_TASK.SPEECH:
                  _currentChatHistory.add([
                    'USER',
                    'SPEECH\nPROMPT: ' +
                        _currentPrompt +
                        '\nVOICE: ' +
                        _currentVoice +
                        '\nSPEED: ' +
                        _currentSpeed.toStringAsFixed(2)
                  ]);
                  break;
                case OPENAI_TASK.CHAT:
                  _currentChatHistory.add(['USER', _currentPrompt]);
                  break;
                default: {}
              }
              _calcOutput();
            });
          },
        ),
        _outputWidget,
        GCWExpandableTextDivider(
          suppressTopSpace: false,
          expanded: false,
          text: i18n(context, 'openai_history'),
          child: GCWColumnedMultilineOutput(
            data: _buildCurrentChatHistory(_currentChatHistory),
            flexValues: const [2, 8],
          ),
        ),
      ],
    );
  }

  void _calcOutput() {
    _getOpenAItask();
    setState(() {});
  }

  List<List<String>> _buildCurrentChatHistory(List<List<String>> history) {
    List<List<String>> result = [];
    for (List<String> chatItem in history) {
      result.add(chatItem);
    }
    return result;
  }

  void _exportFile(
    BuildContext context,
    OPENAI_TASK task,
    Uint8List data,
  ) async {
    List<String> chat = [];
    if (task == OPENAI_TASK.CHAT) {
      for (var chatElement in _currentChatHistory) {
        chat.add(chatElement[0]);
        chat.add(chatElement[1]);
      }
    }
    Uint8List finalData = Uint8List.fromList((String.fromCharCodes(data) + '\n\n\n' 'History' + '\n\n' + chat.join('\n')).codeUnits);
    bool value = false;
    String filename = buildFileNameWithDate(OPENAI_FILENAME[task]!, null) + '.' + OPENAI_FILETYPE[task]!;
    value = await saveByteDataToFile(context, finalData, filename);
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
      openai_chat_model: _currentChatModel,
      openai_image_model: _currentImageModel,
      openai_prompt: _currentPrompt,
      openai_temperature: _currentTemperature,
      openai_image_size: _currentImageSize,
      openai_image_url: _currentImageMode == GCWSwitchPosition.left,
      openai_speed: _currentSpeed,
      openai_voice: _currentVoice,
      openai_audiofile: _currentAudioFile,
      openai_task: _currentTask,
      openai_language: _currentLanguage,
    ));
  }

  void _showOpenAIOutput(OpenAItaskOutput output) {
    if (output.status == OPENAI_TASK_STATUS.OK) {
      switch (_currentTask) {
        case OPENAI_TASK.CHAT:
          var outputMap = jsonDecode(output.textData);
          _outputId = outputMap['id'].toString();
          _outputObject = outputMap['object'].toString();
          _outputCreated = outputMap['created'].toString();
          _outputModel = outputMap['model'].toString();

          if (_outputObject == 'chat.completion') {
            _currentOutput = outputMap['choices'][0]['message']['content'] as String;
          } else {
            _currentOutput = outputMap['choices'][0]['text'] as String;
          }
          _currentOutput = _currentOutput.trim();
          _currentOutputData = _currentOutput.codeUnits;
          _outputWidget = GCWDefaultOutput(
            child: _currentOutput,
            trailing: _defaultOutputTrailing(),
          );
          _currentChatHistory.add(['OPENAI', _currentOutput]);
          break;
        case OPENAI_TASK.IMAGE:
          var outputMap = jsonDecode(output.imageData);
          _outputId = outputMap['id'].toString();
          _outputObject = outputMap['object'].toString();
          _outputCreated = outputMap['created'].toString();
          _outputModel = outputMap['model'].toString();

          if (_currentImageMode == GCWSwitchPosition.left) {
            _currentOutput = outputMap['data'][0]['url'] as String;
            _currentOutputData = _currentOutput.codeUnits;
            _outputWidget = GCWDefaultOutput(trailing: _defaultOutputTrailing(), child: _currentOutput);
          } else {
            _currentOutput = outputMap['data'][0]['b64_json'] as String;
            _currentImageData = decodeBase64(_currentOutput);
            _currentOutputData = _currentImageData.codeUnits;
            var fileData = Uint8List.fromList(_currentOutputData);
            _outputWidget = GCWDefaultOutput(
                trailing: _defaultOutputTrailing(),
                child: Column(
                  children: <Widget>[
                    GCWExpandableTextDivider(
                        expanded: false,
                        text: 'BASE64',
                        child: GCWDefaultOutput(
                          child: _currentOutput,
                        )),
                    GCWImageView(
                      imageData: GCWImageViewData(GCWFile(bytes: fileData, name: _currentPrompt)),
                      suppressOpenInTool: const {
                        GCWImageViewOpenInTools.HIDDENDATA,
                      },
                      suppressedButtons: const {GCWImageViewButtons.SAVE},
                    )
                  ],
                ));
          }
          _currentChatHistory.add(['OPENAI', 'CREATED IMAGE']);
          break;
        case OPENAI_TASK.SPEECH:
          _currentOutputData = output.audioFile.bytes;
          _outputWidget = GCWDefaultOutput(
            trailing: _defaultOutputTrailing(),
            child: GCWSoundPlayer(
              file: output.audioFile,
            ),
          );
          _currentChatHistory.add(['OPENAI: ', 'CREATED SPEECH']);
          break;
        case OPENAI_TASK.AUDIO_TRANSLATE:
        case OPENAI_TASK.AUDIO_TRANSCRIBE:
          _currentOutput = output.textData;
          _outputWidget = GCWDefaultOutput(
            child: _currentOutput,
            trailing: _defaultOutputTrailing(),
          );
          _currentChatHistory.add(['OPENAI', _currentOutput]);
          break;
        default: Container();
      }
    } else {
      _currentOutput = output.textData;
      _currentChatHistory.add(['OPENAI', _currentOutput]);
      _outputWidget = GCWDefaultOutput(trailing: _defaultOutputTrailing(), child: _currentOutput);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      if (output.status == OPENAI_TASK_STATUS.ERROR) {
        _currentOutput =
            i18n(context, 'openai_error') + '\n' + output.httpCode + '\n' + output.httpMessage + '\n' + output.textData;
      }
    });
  }

  Widget _defaultOutputTrailing() {
    return Row(
      children: <Widget>[
        GCWIconButton(
          icon: Icons.save,
          size: IconButtonSize.SMALL,
          onPressed: () {
            _exportFile(
              context,
              _currentTask,
              Uint8List.fromList(_currentOutputData),
            );
          },
        ),
        GCWIconButton(
          icon: Icons.email_outlined,
          size: IconButtonSize.SMALL,
          onPressed: () async {
            final Email email = Email(
              body: 'Model: ' +
                  _currentModel() +
                  '\n' +
                  'Prompt: ' +
                  _currentPrompt +
                  '\n' +
                  'Temperature: ' +
                  _currentTemperature.toString() +
                  '\n' +
                  'ID: ' +
                  _outputId +
                  '\n' +
                  'Object: ' +
                  _outputObject +
                  '\n' +
                  'Created: ' +
                  _outputCreated +
                  '\n' +
                  'Model: ' +
                  _outputModel +
                  '\n' +
                  _currentOutput,
              subject: 'Invalid Content created',
              recipients: ['thomas@familiezimmermann.de'],
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
      ],
    );
  }

  String _currentModel(){
    switch (_currentTask) {
      case OPENAI_TASK.IMAGE: return _currentImageModel;
      case OPENAI_TASK.CHAT: return _currentChatModel;
      case OPENAI_TASK.SPEECH: return 'tts-1';
      case OPENAI_TASK.AUDIO_TRANSCRIBE: return 'whisper-1';
      case OPENAI_TASK.AUDIO_TRANSLATE: return 'whisper-1';
      default: return '';
    }
  }
}
