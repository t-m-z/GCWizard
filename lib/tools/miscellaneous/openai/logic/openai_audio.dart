part of 'package:gc_wizard/tools/miscellaneous/openai/logic/openai.dart';

Future<OpenAItaskOutput> _OpenAIgetAudioAsync(String APIkey, String prompt, double temperature, GCWFile audioFile, OPENAI_TASK task,
    {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  OPENAI_TASK_STATUS status = OPENAI_TASK_STATUS.ERROR;

  try {
    OpenAI.apiKey = APIkey;

    if (task == OPENAI_TASK.AUDIO_TRANSCRIBE) {
      final transcription = await OpenAI.instance.audio.createTranscription(
        prompt: prompt,
        temperature: temperature,
        file: File(audioFile.path!),
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.text,
      );
      textData = transcription.text.toString();
      status = OPENAI_TASK_STATUS.OK;
    } else {
      final translation = await OpenAI.instance.audio.createTranslation(
        prompt: prompt,
        temperature: temperature,
        file: File(audioFile.path!),
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.text,
      );
      textData = translation.text.toString();
      status = OPENAI_TASK_STATUS.OK;
    }
  } on RequestFailedException catch(e) {
    status = OPENAI_TASK_STATUS.ERROR;
    httpMessage = e.message;
    httpCode = e.statusCode.toString();
    textData = '';
  }

  return OpenAItaskOutput(
      status: status,
      httpCode: httpCode,
      httpMessage: httpMessage,
      imageData: '',
      imageDataType: OPENAI_IMAGE_DATATYPE.NULL,
      textData: textData,
      audioFile: GCWFile(bytes: Uint8List.fromList([]), name: ''));
}
