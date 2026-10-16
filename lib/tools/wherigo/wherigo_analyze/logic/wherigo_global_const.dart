part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

const bool _WHERIGO_EXPERT_MODE = true;
const bool _WHERIGO_USER_MODE = false;

const int _WHERIGO_MEDIATYPE_UNK = 0;
const int _WHERIGO_MEDIATYPE_BMP = 1;
const int _WHERIGO_MEDIATYPE_PNG = 2;
const int _WHERIGO_MEDIATYPE_JPG = 3;
const int _WHERIGO_MEDIATYPE_GIF = 4;
const int _WHERIGO_MEDIATYPE_WAV = 17;
const int _WHERIGO_MEDIATYPE_MP3 = 18;
const int _WHERIGO_MEDIATYPE_FDL = 19;
const int _WHERIGO_MEDIATYPE_SND = 20;
const int _WHERIGO_MEDIATYPE_OGG = 21;
const int _WHERIGO_MEDIATYPE_SWF = 33;
const int _WHERIGO_MEDIATYPE_TXT = 49;

const Map<int, String> WHERIGO_MEDIATYPE = {
  _WHERIGO_MEDIATYPE_UNK: UNKNOWN_ELEMENT,
  _WHERIGO_MEDIATYPE_BMP: 'bmp',
  _WHERIGO_MEDIATYPE_PNG: 'png',
  _WHERIGO_MEDIATYPE_JPG: 'jpg',
  _WHERIGO_MEDIATYPE_GIF: 'gif',
  _WHERIGO_MEDIATYPE_WAV: 'wav',
  _WHERIGO_MEDIATYPE_MP3: 'mp3',
  _WHERIGO_MEDIATYPE_FDL: 'fdl',
  _WHERIGO_MEDIATYPE_SND: 'snd',
  _WHERIGO_MEDIATYPE_OGG: 'ogg',
  _WHERIGO_MEDIATYPE_SWF: 'swf',
  _WHERIGO_MEDIATYPE_TXT: 'txt'
};

const Map<int, String> WHERIGO_MEDIACLASS = {
  _WHERIGO_MEDIATYPE_UNK: 'n/a',
  _WHERIGO_MEDIATYPE_BMP: 'Image',
  _WHERIGO_MEDIATYPE_PNG: 'Image',
  _WHERIGO_MEDIATYPE_JPG: 'Image',
  _WHERIGO_MEDIATYPE_GIF: 'Image',
  _WHERIGO_MEDIATYPE_WAV: 'Sound',
  _WHERIGO_MEDIATYPE_MP3: 'Sound',
  _WHERIGO_MEDIATYPE_FDL: 'Sound',
  _WHERIGO_MEDIATYPE_SND: 'Sound',
  _WHERIGO_MEDIATYPE_OGG: 'Sound',
  _WHERIGO_MEDIATYPE_SWF: 'Video',
  _WHERIGO_MEDIATYPE_TXT: 'Text'
};

const Map<WHERIGO_ACTIONMESSAGETYPE, String> _WHERIGO_ACTIONMESSAGETYPE_TEXT = {
  WHERIGO_ACTIONMESSAGETYPE.TEXT: 'txt',
  WHERIGO_ACTIONMESSAGETYPE.IMAGE: 'img',
  WHERIGO_ACTIONMESSAGETYPE.BUTTON: 'btn',
  WHERIGO_ACTIONMESSAGETYPE.COMMAND: 'cmd',
  WHERIGO_ACTIONMESSAGETYPE.CASE: 'cse',
};

Map<String, WHERIGO_ACTIONMESSAGETYPE> WHERIGO_TEXT_ACTIONMESSAGETYPE =
    switchMapKeyValue(_WHERIGO_ACTIONMESSAGETYPE_TEXT);

const String WHERIGO_NULLDATE = '0-01-01 00:00:00.000';
const WherigoZonePoint _WHERIGO_NULLPOINT = WherigoZonePoint();

const Map<bool, Map<WHERIGO_OBJECT, String>> WHERIGO_DROPDOWN_DATA = {
  _WHERIGO_EXPERT_MODE: _WHERIGO_DATA_FULL_EXPERT,
  _WHERIGO_USER_MODE: _WHERIGO_DATA_FULL_USER,
};

const Map<WHERIGO_OBJECT, String> _WHERIGO_DATA_FULL_EXPERT = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.GWCFILE: 'wherigo_data_gwc',
  WHERIGO_OBJECT.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO_OBJECT.LUAFILE: 'wherigo_data_lua',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.TASKS: 'wherigo_data_task_list',
  WHERIGO_OBJECT.TIMERS: 'wherigo_data_timer_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
  WHERIGO_OBJECT.VARIABLES: 'wherigo_data_identifier_list',
  WHERIGO_OBJECT.BUILDERVARIABLES: 'wherigo_data_builder_identifier_list',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.RESULTS_LUA: 'wherigo_data_results_lua',
};

const Map<WHERIGO_OBJECT, String> _WHERIGO_DATA_FULL_USER = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
};

const Map<String, TextStyle> WHERIGO_SYNTAX_HIGHLIGHT_STRINGMAP = {
  // fontWeight: FontWeight.bold
  // fontStyle: FontStyle.italic
  "function": TextStyle(color: Colors.purple),
  "if": TextStyle(color: Colors.purple),
  "then": TextStyle(color: Colors.purple),
  "else": TextStyle(color: Colors.purple),
  "end": TextStyle(color: Colors.purple),
  "return": TextStyle(color: Colors.purple),
  "Dialog": TextStyle(color: Colors.red),
  "MessageBox": TextStyle(color: Colors.red),
  "Wherigo.ZMedia": TextStyle(color: Colors.red),
  "Wherigo.ZCharacter": TextStyle(color: Colors.red),
  "Wherigo.Zone": TextStyle(color: Colors.red),
  "Wherigo.ZItem": TextStyle(color: Colors.red),
  "Wherigo.ZTask": TextStyle(color: Colors.red),
  "Wherigo.ZTimer": TextStyle(color: Colors.red),
  ".ZVariables": TextStyle(color: Colors.red),
  "Wherigo.ZCartridge": TextStyle(color: Colors.red),
  "OnEnter": TextStyle(color: Colors.blue),
  "OnExit": TextStyle(color: Colors.blue),
  "OnGetInput": TextStyle(color: Colors.blue),
  "MoveTo": TextStyle(color: Colors.blue),
  "Id": TextStyle(color: Colors.orange),
  "Type": TextStyle(color: Colors.orange),
  "ZonePoint": TextStyle(color: Colors.orange),
  "Filename": TextStyle(color: Colors.orange),
  "Text": TextStyle(color: Colors.orange),
  "Media": TextStyle(color: Colors.orange),
  "Name": TextStyle(color: Colors.orange),
  "Description": TextStyle(color: Colors.orange),
  "Choices": TextStyle(color: Colors.orange),
};

const WherigoCartridgeLUA WHERIGO_EMPTYCARTRIDGE_LUA = WherigoCartridgeLUA(
    LUAFile: '',
    CartridgeLUAName: '',
    CartridgeGUID: '',
    ObfuscatorTable: [],
    ObfuscatorFunction: [],
    Characters: [],
    Items: [],
    Tasks: [],
    Inputs: [],
    Zones: [],
    Timers: [],
    Media: [],
    Messages: [],
    //Answers: [],
    Variables: [],
    BuilderVariables: [],
    NameToObject: {},
    ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
    ResultsLUA: [],
    Builder: WHERIGO_BUILDER.UNKNOWN,
    BuilderVersion: '',
    TargetDevice: '',
    TargetDeviceVersion: '',
    StartLocation: WherigoZonePoint(),
    CountryID: '',
    StateID: '',
    UseLogging: '',
    CreateDate: WHERIGO_NULLDATE,
    PublishDate: WHERIGO_NULLDATE,
    UpdateDate: WHERIGO_NULLDATE,
    LastPlayedDate: WHERIGO_NULLDATE,
);
const WherigoCartridgeGWC _WHERIGO_EMPTYCARTRIDGE_GWC = WherigoCartridgeGWC(
  Signature: '',
  NumberOfObjects: 0,
  MediaFilesHeaders: [],
  MediaFilesContents: [],
  HeaderLength: 0,
  Splashscreen: 0,
  SplashscreenIcon: 0,
  Latitude: 0.0,
  Longitude: 0.0,
  Altitude: 0.0,
  DateOfCreation: 0,
  TypeOfCartridge: '',
  Player: '',
  PlayerID: 0,
  CartridgeLUAName: '',
  CartridgeGUID: '',
  CartridgeDescription: '',
  StartingLocationDescription: '',
  Version: '',
  Author: '',
  Company: '',
  RecommendedDevice: '',
  LengthOfCompletionCode: 0,
  CompletionCode: '',
  ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
  ResultsGWC: [],
);
const WherigoTaskData _WHERIGO_EMPTYTESTTASK_LUA = WherigoTaskData(
  TaskLUAName: '',
  TaskID: '',
  TaskName: '',
  TaskDescription: '',
  TaskVisible: '',
  TaskMedia: '',
  TaskIcon: '',
  TaskActive: '',
  TaskComplete: '',
  TaskCorrectstate: '',
);
const WherigoZoneData _WHERIGO_EMPTYTESTZONE_LUA = WherigoZoneData(
  ZoneLUAName: '',
  ZoneID: '',
  ZoneName: '',
  ZoneDescription: '',
  ZoneVisible: '',
  ZoneMediaName: '',
  ZoneIconName: '',
  ZoneActive: '',
  ZoneDistanceRange: '',
  ZoneShowObjects: '',
  ZoneProximityRange: '',
  ZoneOriginalPoint: WherigoZonePoint(),
  ZoneDistanceRangeUOM: '',
  ZoneProximityRangeUOM: '',
  ZoneOutOfRange: '',
  ZoneInRange: '',
  ZonePoints: [],
);
const WherigoItemData _WHERIGO_EMPTYTESTITEM_LUA = WherigoItemData(
  ItemLUAName: '',
  ItemID: '',
  ItemName: '',
  ItemDescription: '',
  ItemVisible: '',
  ItemMedia: '',
  ItemIcon: '',
  ItemLocation: '',
  ItemZonepoint: WherigoZonePoint(),
  ItemContainer: '',
  ItemLocked: '',
  ItemOpened: '',
);
const WherigoMediaData _WHERIGO_EMPTYTESTMEDIA_LUA = WherigoMediaData(
  MediaLUAName: '',
  MediaID: '',
  MediaName: '',
  MediaDescription: '',
  MediaAltText: '',
  MediaType: '',
  MediaFilename: '',
);
const WherigoCharacterData _WHERIGO_EMPTYTESTCHARACTER_LUA = WherigoCharacterData(
  CharacterLUAName: '',
  CharacterID: '',
  CharacterName: '',
  CharacterDescription: '',
  CharacterVisible: '',
  CharacterMediaName: '',
  CharacterIconName: '',
  CharacterLocation: '',
  CharacterZonepoint: WherigoZonePoint(),
  CharacterContainer: '',
  CharacterGender: '',
  CharacterType: '',
);
const WherigoTimerData _WHERIGO_EMPTYTESTTIMER_LUA = WherigoTimerData(
  TimerLUAName: '',
  TimerID: '',
  TimerName: '',
  TimerDescription: '',
  TimerVisible: '',
  TimerDuration: '',
  TimerType: '',
);
const WherigoInputData _WHERIGO_EMPTYTESTINPUT_LUA = WherigoInputData(
  InputLUAName: '',
  InputID: '',
  InputVariableID: '',
  InputName: '',
  InputDescription: '',
  InputVisible: '',
  InputMedia: '',
  InputIcon: '',
  InputType: '',
  InputText: '',
  InputChoices: [],
  InputAnswers: [],
);
const WherigoObfuscationData _WHERIGO_EMPTYTESTOBFUSCATION_LUA = WherigoObfuscationData(
  ObfuscationTable: '',
  ObfuscationName: '',
);
WherigoAnswer _WHERIGO_EMPTYTESTANSWER_LUA = WherigoAnswer(
  InputFunction: '',
  InputAnswers: [],
);

const EMPTY_WHERIGOMEDIADATA = WherigoMediaData(
    MediaLUAName: '',
    MediaID: '',
    MediaName: '',
    MediaDescription: '',
    MediaAltText: '',
    MediaType: '',
    MediaFilename: ''
);
