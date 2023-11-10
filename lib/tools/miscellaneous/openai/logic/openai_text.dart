part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final BASE_URL_CHATGPT_CHAT_TEXT = 'https://api.openai.com/v1/chat/completions';
final BASE_URL_CHATGPT_COMPLETIONS_TEXT = 'https://api.openai.com/v1/completions';

final List<String> MODELS_CHAT = [
  'gpt-4-1106-preview ', 'gpt-4', 'gpt-4-0613', 'gpt-4-32k', 'gpt-4-32k-0613', 'gpt-3.5-turbo', 'gpt-3.5-turbo-0613', 'gpt-3.5-turbo-16k', 'gpt-3.5-turbo-16k-0613', 'gpt-3.5-turbo-1106 ',
];

final List<String> MODELS_COMPLETIONS = [
  'gpt-3.5-turbo-instruct', 'babbage-002', 'davinci-002',
];

final Map<String, String> ENDPOINTS = {
  'gpt-4' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-32k' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-32k-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-16k' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-16k-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-instruct': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
  'babbage-002': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
  'davinci-002': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
};

Future<OpenAItaskOutput> _OpenAIgetTextAsync(String APIkey, String model, String prompt, double temperature, {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  String body = '';
  String uri = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  final Map<String, String> CHATGPT_MODEL_HEADERS = {
    'Content-Type': 'application/json',
    'Authorization' : 'Bearer '+APIkey,
  };

  final CHATGPT_CHAT_BODY = {
    'model': model,
    'messages': [
      {'role': 'user', 'content': prompt}
    ],
    'max_tokens': 1000,
    'temperature': temperature,
  };

  final CHATGPT_COMPLETION_BODY = {
    'model': model,
    'prompt': prompt,
    'max_tokens': 1000,
    'temperature': temperature,
  };

  if (MODELS_CHAT.contains(model)) {
    body = jsonEncode(CHATGPT_CHAT_BODY);
  } else {
    body = jsonEncode(CHATGPT_COMPLETION_BODY);
  }
  try {
    uri = ENDPOINTS[model]!;
    final http.Response responseChat = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = responseChat.statusCode.toString();
    httpMessage = responseChat.reasonPhrase.toString();
    textData = responseChat.body;
    if (httpCode != '200') {
      print('ERROR    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    } else {
      status = OPENAI_TASK_STATUS.OK;
      print('CORECT    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    }
  } catch (e) {
    print(e.toString());
  }

  return OpenAItaskOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, textData: textData, imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL, task: OPENAI_TASK.NULL, );
}