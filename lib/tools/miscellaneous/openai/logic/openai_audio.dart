part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

final BASE_URL_CHATGPT_AUDIO = 'https://api.openai.com/v1/images/generations';

class OpenAIaudioOutput {
  final OPENAI_TASK_STATUS status;
  final String httpCode;
  final String httpMessage;
  final String imageData;
  final OPENAI_IMAGE_DATATYPE imageDataType;

  OpenAIaudioOutput({required this.status, required this.httpCode, required this.httpMessage, required this.imageData, required this.imageDataType,});
}

Future<OpenAIaudioOutput> OpenAIgetAudioAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! OPENAIgetChatJobData) {
    return Future.value(
        OpenAIaudioOutput(status: OPENAI_TASK_STATUS.ERROR, httpCode: '', httpMessage: '', imageData: '', imageDataType: OPENAI_IMAGE_DATATYPE.NULL));
  }
  var ChatGPTgetChatJob = jobData!.parameters as OPENAIgetChatJobData;
  OpenAIaudioOutput output = await _OpenAIgetAudioAsync(
      ChatGPTgetChatJob.chatgpt_api_key,
      ChatGPTgetChatJob.chatgpt_model,
      ChatGPTgetChatJob.chatgpt_prompt,
      ChatGPTgetChatJob.chatgpt_temperature,
      ChatGPTgetChatJob.chatgpt_image_size,
      ChatGPTgetChatJob.chatgpt_image_url,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<OpenAIaudioOutput> _OpenAIgetAudioAsync(String APIkey, String model, String prompt, double temperature, String size, bool imageUrl, {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String imageData = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  try {
    final Map<String, String> CHATGPT_MODEL_HEADERS = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer '+APIkey,
    };

    final CHATGPT_IMAGE_BODY = {
      //'model': 'dall-e-3',
      'prompt': prompt,
      'n': 1,
      'size': size,
      'response_format': imageUrl ? 'url' : 'b64_json',
    };

    final body = jsonEncode(CHATGPT_IMAGE_BODY);
    print(body);
    final uri = BASE_URL_CHATGPT_IMAGE;
    final http.Response responseImage = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = responseImage.statusCode.toString();
    httpMessage = responseImage.reasonPhrase.toString();
    imageData = responseImage.body;
    if (httpCode != '200') {
      print('ERROR    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(imageData);
    } else {
      status = OPENAI_TASK_STATUS.OK;
      print('CORECT    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(imageData);
    }
  } catch (e) {
    print(e.toString());
  }

  return OpenAIaudioOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, imageData: imageData, imageDataType: OPENAI_IMAGE_DATATYPE.NULL);
}