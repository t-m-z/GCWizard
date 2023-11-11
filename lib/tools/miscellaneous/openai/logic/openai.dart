
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:http/http.dart' as http;

part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_text.dart';
part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_image.dart';
part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_audio.dart';
part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_speech.dart';

enum OPENAI_TASK {CHAT, IMAGE, AUDIO_TRANSCRIBE, AUDIO_TRANSLATE, SPEECH, NULL, PROMPT}
enum OPENAI_TASK_STATUS {OK, ERROR}

Map<OPENAI_TASK, String> OPENAI_FILENAME = {
  OPENAI_TASK.CHAT : 'openai_chat',
  OPENAI_TASK.IMAGE : 'openai_image',
  OPENAI_TASK.AUDIO_TRANSLATE : 'openai_translate',
  OPENAI_TASK.AUDIO_TRANSCRIBE : 'openai_transcribe',
  OPENAI_TASK.SPEECH : 'openai_speech',
  OPENAI_TASK.PROMPT : 'openai_prompt',
};

Map<OPENAI_TASK, String> OPENAI_FILETYPE = {
  OPENAI_TASK.CHAT : 'chat',
  OPENAI_TASK.IMAGE : 'png',
  OPENAI_TASK.AUDIO_TRANSLATE : 'translation',
  OPENAI_TASK.AUDIO_TRANSCRIBE : 'transcription',
  OPENAI_TASK.SPEECH : 'mp3',
  OPENAI_TASK.PROMPT : 'prompt',

};

Map<String, OPENAI_TASK> OPENAI_TASK_LIST = {
  'openai_text' : OPENAI_TASK.CHAT,
  'openai_image' : OPENAI_TASK.IMAGE,
  'openai_speech' : OPENAI_TASK.SPEECH,
  'openai_transcribe' : OPENAI_TASK.AUDIO_TRANSCRIBE,
  'openai_translate' : OPENAI_TASK.AUDIO_TRANSLATE,
};

class OPENAIgetChatJobData {
  final String openai_api_key;
  final String openai_model;
  final String openai_prompt;
  final double openai_temperature;
  final String openai_image_size;
  final bool openai_image_url;
  final double openai_speed;
  final String openai_voice;
  final OPENAI_TASK openai_task;
  final GCWFile openai_audiofile;

  OPENAIgetChatJobData({required this.openai_audiofile, required this.openai_speed, required this.openai_voice, required this.openai_api_key, required this.openai_model, required this.openai_prompt, required this.openai_temperature, required this.openai_image_size, required this.openai_image_url, required this.openai_task});
}

class OpenAItaskOutput {
  final OPENAI_TASK_STATUS status;
  final String httpCode;
  final String httpMessage;
  final String textData;
  final String imageData;
  final OPENAI_IMAGE_DATATYPE imageDataType;
  final GCWFile audioFile;

  OpenAItaskOutput({required this.status, required this.httpCode, required this.httpMessage, required this.textData, required this.imageData, required this.imageDataType, required this.audioFile});
}

Future<OpenAItaskOutput> OpenAIrunTaskAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! OPENAIgetChatJobData) {
    return Future.value(
        OpenAItaskOutput(status: OPENAI_TASK_STATUS.ERROR, httpCode: '', httpMessage: '', textData: '',imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, audioFile: GCWFile(bytes: Uint8List.fromList([]), name: '')));
  }
  var ChatGPTgetChatJob = jobData!.parameters as OPENAIgetChatJobData;

  OpenAItaskOutput output = OpenAItaskOutput(status: OPENAI_TASK_STATUS.ERROR, httpCode: '', httpMessage: '', textData: '',imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, audioFile: GCWFile(bytes: Uint8List.fromList([]), name: ''));

  switch (ChatGPTgetChatJob.openai_task) {
    case OPENAI_TASK.CHAT:
      output = await _OpenAIgetTextAsync(
          ChatGPTgetChatJob.openai_api_key,
          ChatGPTgetChatJob.openai_model,
          ChatGPTgetChatJob.openai_prompt,
          ChatGPTgetChatJob.openai_temperature,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case OPENAI_TASK.IMAGE:
      output = await _OpenAIgetImageAsync(
          ChatGPTgetChatJob.openai_api_key,
          ChatGPTgetChatJob.openai_model,
          ChatGPTgetChatJob.openai_prompt,
          ChatGPTgetChatJob.openai_temperature,
          ChatGPTgetChatJob.openai_image_size,
          ChatGPTgetChatJob.openai_image_url,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case OPENAI_TASK.AUDIO_TRANSCRIBE:
    case OPENAI_TASK.AUDIO_TRANSLATE:
      output = await _OpenAIgetAudioAsync(
          ChatGPTgetChatJob.openai_api_key,
          ChatGPTgetChatJob.openai_prompt,
          ChatGPTgetChatJob.openai_temperature,
          ChatGPTgetChatJob.openai_audiofile,
          ChatGPTgetChatJob.openai_task,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case OPENAI_TASK.SPEECH:
      output = await _OpenAIgetSpeechAsync(
          ChatGPTgetChatJob.openai_api_key,
          ChatGPTgetChatJob.openai_model,
          ChatGPTgetChatJob.openai_prompt,
          ChatGPTgetChatJob.openai_speed,
          ChatGPTgetChatJob.openai_voice,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
  }

  jobData.sendAsyncPort?.send(output);

  return output;
}

