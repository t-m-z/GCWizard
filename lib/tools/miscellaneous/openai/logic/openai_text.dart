// https://platform.openai.com/docs/guides/text-generation

part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

const _BASE_URL_CHATGPT_CHAT_COMPLETION_TEXT = 'https://api.openai.com/v1/chat/completions';
const _BASE_URL_CHATGPT_COMPLETIONS_TEXT = 'https://api.openai.com/v1/completions';

final List<String> MODELS_CHAT_COMPLETIONS = [
  'gpt-4-o',
  'gpt-4-turbo',
  'gpt-3.5-turbo',
];

final List<String> MODELS_COMPLETIONS = [
  'gpt-3.5-turbo-instruct',
];

final Map<String, String> _OPENAI_ENDPOINTS = {
  'gpt-4': _BASE_URL_CHATGPT_CHAT_COMPLETION_TEXT,
  'gpt-3.5-turbo': _BASE_URL_CHATGPT_CHAT_COMPLETION_TEXT,
  'gpt-3.5-turbo-instruct': _BASE_URL_CHATGPT_COMPLETIONS_TEXT,
};

Future<OpenAItaskOutput> _OpenAIgetTextAsync(String APIkey, String model, String prompt, double temperature,
    {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  String body = '';
  String uri = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  final Map<String, String> CHATGPT_MODEL_HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + APIkey,
  };
  final OPENAI_CHAT_BODY = {
    'model': model,
    'messages': [
      {'role': 'user', 'content': prompt}
    ],
    'max_tokens': 1000,
    'temperature': temperature,
  };
  final OPENAI_COMPLETION_BODY = {
    'model': model,
    'prompt': prompt,
    'max_tokens': 1000,
    'temperature': temperature,
  };
  if (MODELS_CHAT_COMPLETIONS.contains(model)) {
    body = jsonEncode(OPENAI_CHAT_BODY);
  } else {
    body = jsonEncode(OPENAI_COMPLETION_BODY);
  }
  try {
    uri = _OPENAI_ENDPOINTS[model]!;
    final http.Response responseChat = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = responseChat.statusCode.toString();
    httpMessage = responseChat.reasonPhrase.toString();
    textData = responseChat.body;
    if (httpCode != '200') {
      status = OPENAI_TASK_STATUS.ERROR;
    } else {
      status = OPENAI_TASK_STATUS.OK;
    }
  } catch (exception, stackTrace) {
    status = OPENAI_TASK_STATUS.ERROR;
    httpCode = exception.toString();
    httpMessage = stackTrace.toString();
    textData = '';
  }
  return OpenAItaskOutput(
      status: status,
      httpCode: httpCode,
      httpMessage: httpMessage,
      textData: textData,
      imageData: '',
      imageDataType: OPENAI_IMAGE_DATATYPE.NULL,
      audioFile: GCWFile(bytes: Uint8List.fromList([]), name: ''));
}
