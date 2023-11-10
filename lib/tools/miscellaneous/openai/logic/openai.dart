
import 'dart:convert';
import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:http/http.dart' as http;

part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_text.dart';
part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_image.dart';
part 'package:gc_wizard/tools/miscellaneous/openai/logic/openai_audio.dart';

enum OPENAI_TASK {CHAT, IMAGE, AUDIO, NULL}
enum OPENAI_TASK_STATUS {OK, ERROR}

class OPENAIgetChatJobData {
  final String chatgpt_api_key;
  final String chatgpt_model;
  final String chatgpt_prompt;
  final double chatgpt_temperature;
  final String chatgpt_image_size;
  final bool chatgpt_image_url;
  final OPENAI_TASK task;

  OPENAIgetChatJobData({required this.chatgpt_api_key, required this.chatgpt_model, required this.chatgpt_prompt, required this.chatgpt_temperature, required this.chatgpt_image_size, required this.chatgpt_image_url, required this.task});
}

class OpenAItaskOutput {
  final OPENAI_TASK_STATUS status;
  final String httpCode;
  final String httpMessage;
  final String textData;
  final String imageData;
  final OPENAI_IMAGE_DATATYPE imageDataType;
  final OPENAI_TASK task;

  OpenAItaskOutput({required this.status, required this.httpCode, required this.httpMessage, required this.textData, required this.imageData, required this.imageDataType, required this.task});
}

Future<OpenAItaskOutput> OpenAIrunTaskAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! OPENAIgetChatJobData) {
    return Future.value(
        OpenAItaskOutput(status: OPENAI_TASK_STATUS.ERROR, httpCode: '', httpMessage: '', textData: '',imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, task: OPENAI_TASK.NULL ));
  }
  var ChatGPTgetChatJob = jobData!.parameters as OPENAIgetChatJobData;

  OpenAItaskOutput output = OpenAItaskOutput(status: OPENAI_TASK_STATUS.ERROR, httpCode: '', httpMessage: '', textData: '',imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, task: OPENAI_TASK.NULL );

  switch (ChatGPTgetChatJob.task) {
    case OPENAI_TASK.CHAT:
      OpenAItaskOutput output = await _OpenAIgetTextAsync(
          ChatGPTgetChatJob.chatgpt_api_key,
          ChatGPTgetChatJob.chatgpt_model,
          ChatGPTgetChatJob.chatgpt_prompt,
          ChatGPTgetChatJob.chatgpt_temperature,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case OPENAI_TASK.IMAGE:
      break;
    case OPENAI_TASK.AUDIO:
      break;
  }

  jobData.sendAsyncPort?.send(output);

  return output;
}

