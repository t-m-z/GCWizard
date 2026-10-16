require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _uHM5(str)
  local res = ""
  local dtable = "^qT4\030=\001\018M\023mn\014BbS\nHC\015G\016Ypz2cgJ9\0226R\\$lL\003:\020K-0\028v\vX7uEs8\017F)Ui\000];Q\024![\027(\021V%\axr{P\b'I>wdf}?_aD\004W+\t3\002khe,\026/&<*\019o~\031.5@1\r#t\025ZA\006N\f\"\029|O\005jy `"
  for i = 1, #str do
    local b = str:byte(i)
    if b > 0 and b <= 127 then
      res = res .. string.char(dtable:byte(b))
    else
      res = res .. string.char(b)
    end
  end
  return res
end
require("table")
require("math")
math.randomseed(os.time())
math.random()
math.random()
math.random()
_Urwigo = {}
_Urwigo.InlineRequireLoaded = {}
_Urwigo.InlineRequireRes = {}
function _Urwigo.InlineRequire(moduleName)
  local res
  if _Urwigo.InlineRequireLoaded[moduleName] == nil then
    res = _Urwigo.InlineModuleFunc[moduleName]()
    _Urwigo.InlineRequireLoaded[moduleName] = 1
    _Urwigo.InlineRequireRes[moduleName] = res
  else
    res = _Urwigo.InlineRequireRes[moduleName]
  end
  return res
end
function _Urwigo.Round(num, idp)
  local mult = 10 ^ (idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
function _Urwigo.Ceil(num, idp)
  local mult = 10 ^ (idp or 0)
  return math.ceil(num * mult) / mult
end
function _Urwigo.Floor(num, idp)
  local mult = 10 ^ (idp or 0)
  return math.floor(num * mult) / mult
end
_Urwigo.DialogQueue = {}
function _Urwigo.RunDialogs(callback)
  local dialogs = _Urwigo.DialogQueue
  local lastCallback
  _Urwigo.DialogQueue = {}
  local msgcb = {}
  function msgcb(action)
    if action ~= nil then
      if lastCallback ~= nil then
        lastCallback(action)
      end
      local entry = table.remove(dialogs, 1)
      if entry ~= nil then
        lastCallback = entry.Callback
        if entry.Text ~= nil then
          Wherigo.MessageBox({
            Text = entry.Text,
            Media = entry.Media,
            Buttons = entry.Buttons,
            Callback = msgcb
          })
        else
          msgcb(action)
        end
      elseif callback ~= nil then
        callback()
      end
    end
  end
  msgcb(true)
end
function _Urwigo.MessageBox(tbl)
  _Urwigo.RunDialogs(function()
    Wherigo.MessageBox(tbl)
  end)
end
function _Urwigo.OldDialog(tbl)
  _Urwigo.RunDialogs(function()
    Wherigo.Dialog(tbl)
  end)
end
function _Urwigo.Dialog(buffered, tbl, callback)
  for k, v in ipairs(tbl) do
    table.insert(_Urwigo.DialogQueue, v)
  end
  if callback ~= nil then
    table.insert(_Urwigo.DialogQueue, {Callback = callback})
  end
  if not buffered then
    _Urwigo.RunDialogs(nil)
  end
end
function _Urwigo.Hash(str)
  local b = 378551
  local a = 63689
  local hash = 0
  for i = 1, #str do
    hash = hash * a + string.byte(str, i)
    hash = math.fmod(hash, 65535)
    a = a * b
    a = math.fmod(a, 65535)
  end
  return hash
end
_Urwigo.DaysInMonth = {
  31,
  28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
}
function _Urwigo_Date_IsLeapYear(year)
  if year % 400 == 0 then
    return true
  elseif year % 100 == 0 then
    return false
  elseif year % 4 == 0 then
    return true
  else
    return false
  end
end
function _Urwigo.Date_DaysInMonth(year, month)
  if month ~= 2 then
    return _Urwigo.DaysInMonth[month]
  elseif _Urwigo_Date_IsLeapYear(year) then
    return 29
  else
    return 28
  end
end
function _Urwigo.Date_DayInYear(t)
  local res = t.day
  for month = 1, t.month - 1 do
    res = res + _Urwigo.Date_DaysInMonth(t.year, month)
  end
  return res
end
function _Urwigo.Date_HourInWeek(t)
  return t.hour + (t.wday - 1) * 24
end
function _Urwigo.Date_HourInMonth(t)
  return t.hour + t.day * 24
end
function _Urwigo.Date_HourInYear(t)
  return t.hour + (_Urwigo.Date_DayInYear(t) - 1) * 24
end
function _Urwigo.Date_MinuteInDay(t)
  return t.min + t.hour * 60
end
function _Urwigo.Date_MinuteInWeek(t)
  return t.min + t.hour * 60 + (t.wday - 1) * 1440
end
function _Urwigo.Date_MinuteInMonth(t)
  return t.min + t.hour * 60 + (t.day - 1) * 1440
end
function _Urwigo.Date_MinuteInYear(t)
  return t.min + t.hour * 60 + (_Urwigo.Date_DayInYear(t) - 1) * 1440
end
function _Urwigo.Date_SecondInHour(t)
  return t.sec + t.min * 60
end
function _Urwigo.Date_SecondInDay(t)
  return t.sec + t.min * 60 + t.hour * 3600
end
function _Urwigo.Date_SecondInWeek(t)
  return t.sec + t.min * 60 + t.hour * 3600 + (t.wday - 1) * 86400
end
function _Urwigo.Date_SecondInMonth(t)
  return t.sec + t.min * 60 + t.hour * 3600 + (t.day - 1) * 86400
end
function _Urwigo.Date_SecondInYear(t)
  return t.sec + t.min * 60 + t.hour * 3600 + (_Urwigo.Date_DayInYear(t) - 1) * 86400
end
_Urwigo.InlineModuleFunc = {}
_PIVhQ = Wherigo.ZCartridge()
_1XXCf = Wherigo.ZMedia(_PIVhQ)
_1XXCf.Id = "82de8f1e-2e6f-452a-af9d-1e831f8e7831"
_1XXCf.Name = _uHM5("%9\f]3~H_\027^p3~\016\027^9$P")
_1XXCf.Description = ""
_1XXCf.AltText = ""
_1XXCf.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
_s4E = Wherigo.ZMedia(_PIVhQ)
_s4E.Id = "0c393472-6121-4726-be57-bc642beb62a0"
_s4E.Name = _uHM5("6HU\028_\025_9\027^_\f")
_s4E.Description = ""
_s4E.AltText = ""
_s4E.Resources = {
  {
    Type = "jpg",
    Filename = "Fragezeichengro.jpg",
    Directives = {}
  }
}
_aFFPz = Wherigo.ZMedia(_PIVhQ)
_aFFPz.Id = "03ccf703-ccc6-4048-91e7-1dabbfa5ae89"
_aFFPz.Name = _uHM5("\018U]\027^_\f")
_aFFPz.Description = ""
_aFFPz.AltText = ""
_aFFPz.Resources = {
  {
    Type = "jpg",
    Filename = "GrunerHaken.jpg",
    Directives = {}
  }
}
_SxsP1 = Wherigo.ZMedia(_PIVhQ)
_SxsP1.Id = "95e04fb9-61be-43dd-9a97-bf2bf82e051b"
_SxsP1.Name = _uHM5(")H_1\025")
_SxsP1.Description = ""
_SxsP1.AltText = ""
_SxsP1.Resources = {
  {
    Type = "jpg",
    Filename = "roteskreuz.jpg",
    Directives = {}
  }
}
_mOGZ = Wherigo.ZMedia(_PIVhQ)
_mOGZ.Id = "7affda44-de00-47e0-9d38-86d6088c2723"
_mOGZ.Name = _uHM5("\018U\fP3^U]_")
_mOGZ.Description = ""
_mOGZ.AltText = ""
_mOGZ.Resources = {
  {
    Type = "jpg",
    Filename = "handshake-deal.jpg",
    Directives = {}
  }
}
_Xyr = Wherigo.ZMedia(_PIVhQ)
_Xyr.Id = "03bdfa9e-8eca-41a7-abef-6ed444dc8f3c"
_Xyr.Name = _uHM5("\018U\fP_")
_Xyr.Description = ""
_Xyr.AltText = ""
_Xyr.Resources = {
  {
    Type = "jpg",
    Filename = "20160710_195740.jpg",
    Directives = {}
  }
}
_iNc = Wherigo.ZMedia(_PIVhQ)
_iNc.Id = "1cd9b075-4467-48a8-aa25-211749ac8de6"
_iNc.Name = _uHM5("s13H1Q_\025_9\027^_\f")
_iNc.Description = ""
_iNc.AltText = ""
_iNc.Resources = {
  {
    Type = "jpg",
    Filename = "ausrufezeichen.jpg",
    Directives = {}
  }
}
_PIVhQ.Id = "89146dba-e59b-47c3-8262-041e26a72a8f"
_PIVhQ.Name = "Teamwork"
_PIVhQ.Description = [[
<BR>
Hier wird TEAM gross geschrieben.....]]
_PIVhQ.Visible = true
_PIVhQ.Activity = "Geocache"
_PIVhQ.StartingLocationDescription = ""
_PIVhQ.StartingLocation = ZonePoint(51.319167, 12.334267, 0)
_PIVhQ.Version = "1.4"
_PIVhQ.Company = ""
_PIVhQ.Author = "schmunzelhaase"
_PIVhQ.BuilderVersion = "URWIGO 1.22.5798.37755"
_PIVhQ.CreateDate = "06/30/2016 19:10:08"
_PIVhQ.PublishDate = "1/1/0001 12:00:00 AM"
_PIVhQ.UpdateDate = "07/06/2020 07:38:20"
_PIVhQ.LastPlayedDate = "1/1/0001 12:00:00 AM"
_PIVhQ.TargetDevice = "PocketPC"
_PIVhQ.TargetDeviceVersion = "0"
_PIVhQ.StateId = "1"
_PIVhQ.CountryId = "2"
_PIVhQ.Complete = false
_PIVhQ.UseLogging = true
_PIVhQ.Media = _Xyr
_uLj1 = Wherigo.Zone(_PIVhQ)
_uLj1.Id = "ebeb4a21-fcdb-43b2-8b46-5b1369334a82"
_uLj1.Name = _uHM5("\003_U\v~m~rg\f_~m")
_uLj1.Description = ""
_uLj1.Visible = false
_uLj1.Commands = {}
_uLj1.DistanceRange = Distance(-1, "feet")
_uLj1.ShowObjects = "OnEnter"
_uLj1.ProximityRange = Distance(60, "meters")
_uLj1.AllowSetPositionTo = false
_uLj1.Active = false
_uLj1.Points = {
  ZonePoint(51.318633054505, 12.3337206536024, 0),
  ZonePoint(51.3184787899505, 12.3341100212338, 0),
  ZonePoint(51.3178893431526, 12.3335957484242, 0),
  ZonePoint(51.3180997624849, 12.3330011885654, 0)
}
_uLj1.OriginalPoint = ZonePoint(51.3182752375233, 12.3336069029564, 0)
_uLj1.DistanceRangeUOM = "Feet"
_uLj1.ProximityRangeUOM = "Meters"
_uLj1.OutOfRangeName = ""
_uLj1.InRangeName = ""
_rRhT = Wherigo.Zone(_PIVhQ)
_rRhT.Id = "920f9bd6-cf2d-42cb-b8b3-df9cb28d8912"
_rRhT.Name = _uHM5("\003_U\v~m~rg\f_~\026")
_rRhT.Description = ""
_rRhT.Visible = false
_rRhT.Commands = {}
_rRhT.DistanceRange = Distance(-1, "feet")
_rRhT.ShowObjects = "OnEnter"
_rRhT.ProximityRange = Distance(60, "meters")
_rRhT.AllowSetPositionTo = false
_rRhT.Active = false
_rRhT.Points = {
  ZonePoint(51.3179386189844, 12.3332725676389, 0),
  ZonePoint(51.3177972959865, 12.3336643926163, 0),
  ZonePoint(51.317555016428, 12.3334379382791, 0),
  ZonePoint(51.3177185594539, 12.3330110531033, 0)
}
_rRhT.OriginalPoint = ZonePoint(51.3177523727132, 12.3333464879094, 0)
_rRhT.DistanceRangeUOM = "Feet"
_rRhT.ProximityRangeUOM = "Meters"
_rRhT.OutOfRangeName = ""
_rRhT.InRangeName = ""
_chp = Wherigo.Zone(_PIVhQ)
_chp.Id = "ee0407a9-5968-4f69-b6cb-d962061de41b"
_chp.Name = _uHM5("\003_U\v~m~rg\f_~[")
_chp.Description = ""
_chp.Visible = false
_chp.Commands = {}
_chp.DistanceRange = Distance(-1, "feet")
_chp.ShowObjects = "OnEnter"
_chp.ProximityRange = Distance(60, "meters")
_chp.AllowSetPositionTo = false
_chp.Active = false
_chp.Points = {
  ZonePoint(51.3162024725021, 12.3344287210686, 0),
  ZonePoint(51.3161052968376, 12.3347759017481, 0),
  ZonePoint(51.3158884344703, 12.3347045549244, 0),
  ZonePoint(51.3159697093671, 12.3343156778641, 0)
}
_chp.OriginalPoint = ZonePoint(51.3160414782943, 12.3345562139013, 0)
_chp.DistanceRangeUOM = "Feet"
_chp.ProximityRangeUOM = "Meters"
_chp.OutOfRangeName = ""
_chp.InRangeName = ""
_02yZ = Wherigo.Zone(_PIVhQ)
_02yZ.Id = "07612a6e-fc88-4bf5-aacd-edd70e2a6841"
_02yZ.Name = _uHM5("\003_U\v~m~rg\f_~\004")
_02yZ.Description = ""
_02yZ.Visible = false
_02yZ.Commands = {}
_02yZ.DistanceRange = Distance(-1, "feet")
_02yZ.ShowObjects = "OnEnter"
_02yZ.ProximityRange = Distance(60, "meters")
_02yZ.AllowSetPositionTo = false
_02yZ.Active = false
_02yZ.Points = {
  ZonePoint(51.3124539874126, 12.332481168733, 0),
  ZonePoint(51.3126498928261, 12.3330118809418, 0),
  ZonePoint(51.3119247483293, 12.3343224321973, 0),
  ZonePoint(51.3116417198664, 12.3335234772883, 0),
  ZonePoint(51.3117143226469, 12.3326642403522, 0)
}
_02yZ.OriginalPoint = ZonePoint(51.3120769342163, 12.3332006399025, 0)
_02yZ.DistanceRangeUOM = "Feet"
_02yZ.ProximityRangeUOM = "Meters"
_02yZ.OutOfRangeName = ""
_02yZ.InRangeName = ""
_goK = Wherigo.Zone(_PIVhQ)
_goK.Id = "ac52264c-14e4-47c7-aeb6-1dd712a3a471"
_goK.Name = _uHM5("\003_U\v~m~rg\f_~k")
_goK.Description = ""
_goK.Visible = false
_goK.Commands = {}
_goK.DistanceRange = Distance(-1, "feet")
_goK.ShowObjects = "OnEnter"
_goK.ProximityRange = Distance(60, "meters")
_goK.AllowSetPositionTo = false
_goK.Active = false
_goK.Points = {
  ZonePoint(51.3125788421307, 12.338138861232, 0),
  ZonePoint(51.3123538591651, 12.3387015173999, 0),
  ZonePoint(51.3118621447231, 12.3382101052655, 0),
  ZonePoint(51.3119627941044, 12.3376137870059, 0)
}
_goK.OriginalPoint = ZonePoint(51.3121894100308, 12.3381660677258, 0)
_goK.DistanceRangeUOM = "Feet"
_goK.ProximityRangeUOM = "Meters"
_goK.OutOfRangeName = ""
_goK.InRangeName = ""
_8r2 = Wherigo.Zone(_PIVhQ)
_8r2.Id = "a74f7bf3-d84e-4100-94bc-8879666db168"
_8r2.Name = _uHM5("\003_U\v~m~rg\f_~ ")
_8r2.Description = ""
_8r2.Visible = true
_8r2.Commands = {}
_8r2.DistanceRange = Distance(-1, "feet")
_8r2.ShowObjects = "OnEnter"
_8r2.ProximityRange = Distance(60, "meters")
_8r2.AllowSetPositionTo = false
_8r2.Active = false
_8r2.Points = {
  ZonePoint(51.3131736091909, 12.339217452832, 0),
  ZonePoint(51.3128601637057, 12.339476540682, 0),
  ZonePoint(51.3130743516856, 12.3399194973287, 0),
  ZonePoint(51.3134034678525, 12.3397189131868, 0)
}
_8r2.OriginalPoint = ZonePoint(51.3131278981087, 12.3395831010074, 0)
_8r2.DistanceRangeUOM = "Feet"
_8r2.ProximityRangeUOM = "Meters"
_8r2.OutOfRangeName = ""
_8r2.InRangeName = ""
_FmQ4 = Wherigo.Zone(_PIVhQ)
_FmQ4.Id = "574691a4-6acb-4db9-a312-28f9b581218b"
_FmQ4.Name = _uHM5("%_p\025p_~!1\fP_")
_FmQ4.Description = ""
_FmQ4.Visible = false
_FmQ4.Commands = {}
_FmQ4.DistanceRange = Distance(-1, "feet")
_FmQ4.ShowObjects = "OnEnter"
_FmQ4.ProximityRange = Distance(60, "meters")
_FmQ4.AllowSetPositionTo = false
_FmQ4.Active = false
_FmQ4.Points = {
  ZonePoint(51.3139990053913, 12.3392675988675, 0),
  ZonePoint(51.3140564691309, 12.3398609936207, 0),
  ZonePoint(51.3136019812243, 12.3400615777626, 0),
  ZonePoint(51.3137221336374, 12.3392174528321, 0)
}
_FmQ4.OriginalPoint = ZonePoint(51.313844897346, 12.3396019057707, 0)
_FmQ4.DistanceRangeUOM = "Feet"
_FmQ4.ProximityRangeUOM = "Meters"
_FmQ4.OutOfRangeName = ""
_FmQ4.InRangeName = ""
_CbefJ = Wherigo.Zone(_PIVhQ)
_CbefJ.Id = "833ad400-bc11-40b2-848f-400ca9ba565b"
_CbefJ.Name = _uHM5("\003_U\v~\026~rg\f_~m")
_CbefJ.Description = ""
_CbefJ.Visible = false
_CbefJ.Commands = {}
_CbefJ.DistanceRange = Distance(-1, "feet")
_CbefJ.ShowObjects = "OnEnter"
_CbefJ.ProximityRange = Distance(60, "meters")
_CbefJ.AllowSetPositionTo = false
_CbefJ.Active = false
_CbefJ.Points = {
  ZonePoint(51.3182400277922, 12.334524619679, 0),
  ZonePoint(51.318372184374, 12.3350641563898, 0),
  ZonePoint(51.3182437367618, 12.3357586651257, 0),
  ZonePoint(51.3175647055067, 12.3356685754168, 0),
  ZonePoint(51.317628874609, 12.3348254958918, 0),
  ZonePoint(51.3178325932414, 12.3343929863358, 0)
}
_CbefJ.OriginalPoint = ZonePoint(51.3179803537142, 12.3350390831398, 0)
_CbefJ.DistanceRangeUOM = "Feet"
_CbefJ.ProximityRangeUOM = "Meters"
_CbefJ.OutOfRangeName = ""
_CbefJ.InRangeName = ""
_2xiF = Wherigo.Zone(_PIVhQ)
_2xiF.Id = "51657aca-16f3-445c-9417-cbcad516e9f4"
_2xiF.Name = _uHM5("\003_U\v~\026~rg\f_~\026")
_2xiF.Description = ""
_2xiF.Visible = false
_2xiF.Commands = {}
_2xiF.DistanceRange = Distance(-1, "feet")
_2xiF.ShowObjects = "OnEnter"
_2xiF.ProximityRange = Distance(60, "meters")
_2xiF.AllowSetPositionTo = false
_2xiF.Active = false
_2xiF.Points = {
  ZonePoint(51.3173872840324, 12.3352350218483, 0),
  ZonePoint(51.3172958710501, 12.3357176774397, 0),
  ZonePoint(51.3169184640946, 12.3355985806055, 0),
  ZonePoint(51.3170386078222, 12.3350929414144, 0)
}
_2xiF.OriginalPoint = ZonePoint(51.3171600567498, 12.335411055327, 0)
_2xiF.DistanceRangeUOM = "Feet"
_2xiF.ProximityRangeUOM = "Meters"
_2xiF.OutOfRangeName = ""
_2xiF.InRangeName = ""
_uDRe = Wherigo.Zone(_PIVhQ)
_uDRe.Id = "7feb00ba-5b26-4956-b0de-296a686d05d7"
_uDRe.Name = _uHM5("\003_U\v~\026~rg\f_~[")
_uDRe.Description = ""
_uDRe.Visible = false
_uDRe.Commands = {}
_uDRe.DistanceRange = Distance(-1, "feet")
_uDRe.ShowObjects = "OnEnter"
_uDRe.ProximityRange = Distance(60, "meters")
_uDRe.AllowSetPositionTo = false
_uDRe.Active = false
_uDRe.Points = {
  ZonePoint(51.318788005395, 12.3364747357383, 0),
  ZonePoint(51.318733645573, 12.3369420764727, 0),
  ZonePoint(51.3181551458925, 12.3366370214236, 0),
  ZonePoint(51.3182792040005, 12.3361334716507, 0)
}
_uDRe.OriginalPoint = ZonePoint(51.3184890002153, 12.3365468263213, 0)
_uDRe.DistanceRangeUOM = "Feet"
_uDRe.ProximityRangeUOM = "Meters"
_uDRe.OutOfRangeName = ""
_uDRe.InRangeName = ""
_zBN = Wherigo.Zone(_PIVhQ)
_zBN.Id = "61df3518-b3d9-4d75-849a-9468dfe88a11"
_zBN.Name = _uHM5("\003_U\v~\026~rg\f_~\004")
_zBN.Description = ""
_zBN.Visible = false
_zBN.Commands = {}
_zBN.DistanceRange = Distance(-1, "feet")
_zBN.ShowObjects = "OnEnter"
_zBN.ProximityRange = Distance(60, "meters")
_zBN.AllowSetPositionTo = false
_zBN.Active = false
_zBN.Points = {
  ZonePoint(51.3184600250706, 12.3387302293804, 0),
  ZonePoint(51.3183702675599, 12.3390438528888, 0),
  ZonePoint(51.3181470745648, 12.3389234446853, 0),
  ZonePoint(51.3182989309036, 12.3384738760156, 0)
}
_zBN.OriginalPoint = ZonePoint(51.3183190745247, 12.3387928507425, 0)
_zBN.DistanceRangeUOM = "Feet"
_zBN.ProximityRangeUOM = "Meters"
_zBN.OutOfRangeName = ""
_zBN.InRangeName = ""
_L7z = Wherigo.Zone(_PIVhQ)
_L7z.Id = "ab3b45d2-224e-4ce5-8320-999d49739393"
_L7z.Name = _uHM5("\003_U\v~\026~rg\f_~k")
_L7z.Description = ""
_L7z.Visible = false
_L7z.Commands = {}
_L7z.DistanceRange = Distance(-1, "feet")
_L7z.ShowObjects = "OnEnter"
_L7z.ProximityRange = Distance(60, "meters")
_L7z.AllowSetPositionTo = false
_L7z.Active = false
_L7z.Points = {
  ZonePoint(51.3167874226613, 12.3385843511882, 0),
  ZonePoint(51.316819642029, 12.3383352921504, 0),
  ZonePoint(51.3164341004419, 12.3381964389183, 0),
  ZonePoint(51.3163848227216, 12.3384410451369, 0)
}
_L7z.OriginalPoint = ZonePoint(51.3166064969635, 12.3383892818484, 0)
_L7z.DistanceRangeUOM = "Feet"
_L7z.ProximityRangeUOM = "Meters"
_L7z.OutOfRangeName = ""
_L7z.InRangeName = ""
_BnJKW = Wherigo.Zone(_PIVhQ)
_BnJKW.Id = "6df6ea84-5bfc-4445-8cf3-d5f141f082f9"
_BnJKW.Name = _uHM5("\003_U\v~\026~rg\f_~ ")
_BnJKW.Description = ""
_BnJKW.Visible = false
_BnJKW.Commands = {}
_BnJKW.DistanceRange = Distance(-1, "feet")
_BnJKW.ShowObjects = "OnEnter"
_BnJKW.ProximityRange = Distance(60, "meters")
_BnJKW.AllowSetPositionTo = false
_BnJKW.Active = false
_BnJKW.Points = {
  ZonePoint(51.3154388421726, 12.337669193988, 0),
  ZonePoint(51.3154022754485, 12.3382375157234, 0),
  ZonePoint(51.3150915119487, 12.3380989803727, 0),
  ZonePoint(51.3151580886382, 12.3375148543229, 0)
}
_BnJKW.OriginalPoint = ZonePoint(51.315272679552, 12.3378801361017, 0)
_BnJKW.DistanceRangeUOM = "Feet"
_BnJKW.ProximityRangeUOM = "Meters"
_BnJKW.OutOfRangeName = ""
_BnJKW.InRangeName = ""
_6dB = Wherigo.Zone(_PIVhQ)
_6dB.Id = "5375114c-39b0-4147-8bbe-9c1b22a79cc8"
_6dB.Name = _uHM5("Vg3_\f-_H3p_\027]")
_6dB.Description = ""
_6dB.Visible = false
_6dB.Commands = {}
_6dB.DistanceRange = Distance(-1, "feet")
_6dB.ShowObjects = "OnProximity"
_6dB.ProximityRange = Distance(20, "meters")
_6dB.AllowSetPositionTo = false
_6dB.Active = false
_6dB.Points = {
  ZonePoint(51.314817, 12.338733, 0),
  ZonePoint(51.3148364229472, 12.3387545134005, 0),
  ZonePoint(51.3148389376268, 12.3387162927487, 0)
}
_6dB.OriginalPoint = ZonePoint(51.314830786858, 12.3387346020497, 0)
_6dB.DistanceRangeUOM = "Feet"
_6dB.ProximityRangeUOM = "Meters"
_6dB.OutOfRangeName = ""
_6dB.InRangeName = ""
_PnG = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _uLj1})
_PnG.Id = "03291eef-ffd8-4112-b70e-afb79155e5a2"
_PnG.Name = _uHM5("m*m")
_PnG.Description = ""
_PnG.Visible = true
_PnG.Media = _s4E
_PnG.Commands = {
  _r29O0 = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_PnG.Commands._r29O0.Custom = true
_PnG.Commands._r29O0.Id = "b5beb1f5-d7ec-4653-aa3f-1a7b2ef944f2"
_PnG.Commands._r29O0.WorksWithAll = true
_PnG.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_PnG.Locked = false
_PnG.Opened = false
_h1DKX = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _rRhT})
_h1DKX.Id = "4523beab-fe62-4735-8658-e6e9534b2bea"
_h1DKX.Name = _uHM5("m*\026")
_h1DKX.Description = ""
_h1DKX.Visible = true
_h1DKX.Media = _s4E
_h1DKX.Commands = {
  _fVd = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_h1DKX.Commands._fVd.Custom = true
_h1DKX.Commands._fVd.Id = "e476d70d-96a1-4b2c-b9c2-a4b74cf493fd"
_h1DKX.Commands._fVd.WorksWithAll = true
_h1DKX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_h1DKX.Locked = false
_h1DKX.Opened = false
_rGMu = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _chp})
_rGMu.Id = "0ad1da9e-98d9-48a6-8047-23a5387d761d"
_rGMu.Name = _uHM5("m*[")
_rGMu.Description = ""
_rGMu.Visible = true
_rGMu.Media = _s4E
_rGMu.Commands = {
  _w9qL = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_rGMu.Commands._w9qL.Custom = true
_rGMu.Commands._w9qL.Id = "70deca4b-ba57-4c32-bc79-446714443481"
_rGMu.Commands._w9qL.WorksWithAll = true
_rGMu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rGMu.Locked = false
_rGMu.Opened = false
_KA5tb = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _02yZ})
_KA5tb.Id = "3f694663-70f0-4d7c-b369-6c6f41af0d30"
_KA5tb.Name = _uHM5("m*\004")
_KA5tb.Description = ""
_KA5tb.Visible = true
_KA5tb.Media = _s4E
_KA5tb.Commands = {
  _QFkWv = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_KA5tb.Commands._QFkWv.Custom = true
_KA5tb.Commands._QFkWv.Id = "89764ae1-1cf3-4de2-a4ed-3d3bf4125c37"
_KA5tb.Commands._QFkWv.WorksWithAll = true
_KA5tb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KA5tb.Locked = false
_KA5tb.Opened = false
_9RNLU = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _goK})
_9RNLU.Id = "9abe54fe-a8a3-4de0-8878-2486bbe08316"
_9RNLU.Name = _uHM5("m*k")
_9RNLU.Description = ""
_9RNLU.Visible = true
_9RNLU.Media = _s4E
_9RNLU.Commands = {
  _YDgk_ = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_9RNLU.Commands._YDgk_.Custom = true
_9RNLU.Commands._YDgk_.Id = "71b06738-efbc-4461-be1d-7f953eaffc90"
_9RNLU.Commands._YDgk_.WorksWithAll = true
_9RNLU.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_9RNLU.Locked = false
_9RNLU.Opened = false
_5jLmp = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _8r2})
_5jLmp.Id = "2e4eeed2-b755-4e9f-9c59-1b441fd1b1aa"
_5jLmp.Name = _uHM5("m* ")
_5jLmp.Description = ""
_5jLmp.Visible = true
_5jLmp.Media = _s4E
_5jLmp.Commands = {
  _5Rcci = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_5jLmp.Commands._5Rcci.Custom = true
_5jLmp.Commands._5Rcci.Id = "6eecde7e-f8b1-477f-a639-d42fcb80a306"
_5jLmp.Commands._5Rcci.WorksWithAll = true
_5jLmp.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_5jLmp.Locked = false
_5jLmp.Opened = false
_8kI7N = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _CbefJ})
_8kI7N.Id = "07942e6e-a46d-444f-bba8-7c6cb6ea60d9"
_8kI7N.Name = _uHM5("\026*m")
_8kI7N.Description = ""
_8kI7N.Visible = true
_8kI7N.Media = _s4E
_8kI7N.Commands = {
  _Ksou = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_8kI7N.Commands._Ksou.Custom = true
_8kI7N.Commands._Ksou.Id = "6d8306c2-699c-4eb4-bc8e-dfa161cb159e"
_8kI7N.Commands._Ksou.WorksWithAll = true
_8kI7N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8kI7N.Locked = false
_8kI7N.Opened = false
_7RdN = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _2xiF})
_7RdN.Id = "c8807a04-cf6a-4bfb-ae03-43e36fa3a09b"
_7RdN.Name = _uHM5("\026*\026")
_7RdN.Description = ""
_7RdN.Visible = true
_7RdN.Media = _s4E
_7RdN.Commands = {
  _Di1AA = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_7RdN.Commands._Di1AA.Custom = true
_7RdN.Commands._Di1AA.Id = "cd428c37-aa84-4ced-a4c7-b6f241f6f94f"
_7RdN.Commands._Di1AA.WorksWithAll = true
_7RdN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_7RdN.Locked = false
_7RdN.Opened = false
_z4q = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _zBN})
_z4q.Id = "0d7c69e7-0756-4872-90a0-f56472687e9d"
_z4q.Name = _uHM5("\026*\004")
_z4q.Description = ""
_z4q.Visible = true
_z4q.Media = _s4E
_z4q.Commands = {
  _qp4O = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_z4q.Commands._qp4O.Custom = true
_z4q.Commands._qp4O.Id = "0bc611b1-cfa5-4ffd-beb0-89be338a5454"
_z4q.Commands._qp4O.WorksWithAll = true
_z4q.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_z4q.Locked = false
_z4q.Opened = false
_7I7PJ = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _L7z})
_7I7PJ.Id = "3b86099d-a86d-45b5-beec-b1b79f658e56"
_7I7PJ.Name = _uHM5("\026*k")
_7I7PJ.Description = ""
_7I7PJ.Visible = true
_7I7PJ.Media = _s4E
_7I7PJ.Commands = {
  _42GK = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_7I7PJ.Commands._42GK.Custom = true
_7I7PJ.Commands._42GK.Id = "5ddb2a8b-acf6-42b7-a4a3-8e0bd592c465"
_7I7PJ.Commands._42GK.WorksWithAll = true
_7I7PJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_7I7PJ.Locked = false
_7I7PJ.Opened = false
_NJLQF = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _BnJKW})
_NJLQF.Id = "542cae93-1330-4bfe-a1d0-e7b8be7b72db"
_NJLQF.Name = _uHM5("\026* ")
_NJLQF.Description = ""
_NJLQF.Visible = true
_NJLQF.Media = _s4E
_NJLQF.Commands = {
  _s5o = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_NJLQF.Commands._s5o.Custom = true
_NJLQF.Commands._s5o.Id = "7e755adc-d593-4729-89f5-3241c645476f"
_NJLQF.Commands._s5o.WorksWithAll = true
_NJLQF.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_NJLQF.Locked = false
_NJLQF.Opened = false
_mTr5V = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _uDRe})
_mTr5V.Id = "a2b86c3d-6acf-4acf-9f27-77300140fec7"
_mTr5V.Name = _uHM5("\026*[")
_mTr5V.Description = ""
_mTr5V.Visible = true
_mTr5V.Media = _s4E
_mTr5V.Commands = {
  _Qjuvz = Wherigo.ZCommand({
    Text = _uHM5("X_9p_H"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_mTr5V.Commands._Qjuvz.Custom = true
_mTr5V.Commands._Qjuvz.Id = "342c61a0-f67d-40db-9461-208956952611"
_mTr5V.Commands._Qjuvz.WorksWithAll = true
_mTr5V.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_mTr5V.Locked = false
_mTr5V.Opened = false
_zNxV = Wherigo.ZItem(_PIVhQ)
_zNxV.Id = "e4d51e65-fa0e-44ea-8cc8-0bc75b29f301"
_zNxV.Name = _uHM5("8\f$g\027]~\019gP_")
_zNxV.Description = ""
_zNxV.Visible = true
_zNxV.Commands = {
  _dKLs = Wherigo.ZCommand({
    Text = _uHM5("8\f$g\027]~\019gP_"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_zNxV.Commands._dKLs.Custom = true
_zNxV.Commands._dKLs.Id = "4b877cb6-0c02-4b5d-80ae-420929c5bdad"
_zNxV.Commands._dKLs.WorksWithAll = true
_zNxV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zNxV.Locked = false
_zNxV.Opened = false
_1Tz = Wherigo.ZItem({Cartridge = _PIVhQ, Container = Player})
_1Tz.Id = "87c2560d-4250-4c84-aa9a-76987d4c9e82"
_1Tz.Name = _uHM5("\016pUHpHU_p3_$")
_1Tz.Description = ""
_1Tz.Visible = true
_1Tz.Media = _s4E
_1Tz.Commands = {
  _sK0d8 = Wherigo.ZCommand({
    Text = _uHM5("!U_p3_$"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_1Tz.Commands._sK0d8.Custom = true
_1Tz.Commands._sK0d8.Id = "8e36b976-f9c1-4ab9-ac01-4340e3f37a43"
_1Tz.Commands._sK0d8.WorksWithAll = true
_1Tz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_1Tz.Locked = false
_1Tz.Opened = false
_A_TZP = Wherigo.ZItem({Cartridge = _PIVhQ, Container = _FmQ4})
_A_TZP.Id = "4116384d-d35d-45be-8a28-eb8fdbb0ff2d"
_A_TZP.Name = _uHM5("\021_g\027^_\027]_H")
_A_TZP.Description = _uHM5("\0189_H~]U\f\f3p~V1~P9_~69\fU$]ggHP9\fUp_\f~\015_H_\027^\f_\fj")
_A_TZP.Visible = true
_A_TZP.Commands = {
  _ZVmRm = Wherigo.ZCommand({
    Text = _uHM5("69\fU$"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _uHM5("u9\027^p~-_HQ1\028\015UH")
  })
}
_A_TZP.Commands._ZVmRm.Custom = true
_A_TZP.Commands._ZVmRm.Id = "db3829a6-f6fd-4c13-8cd6-d2e39b77b9be"
_A_TZP.Commands._ZVmRm.WorksWithAll = true
_A_TZP.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_A_TZP.Locked = false
_A_TZP.Opened = false
_sdk = Wherigo.ZTask(_PIVhQ)
_sdk.Id = "3f343910-5ce1-430b-92da-c3eb3bd23049"
_sdk.Name = _uHM5("\003_U\v~m")
_sdk.Description = _uHM5("\014_\0289\015~V9\027^~U1Q~P9_~!_93_~1\fP~Q9\fP_~P9_~s\fpOgHp_\f~Q1_H~PU3~\003_U\v~\026?~M\f~|_P_H~rg\f_~\0289\015p~_3~_9\f_~6HU\028_`~P9_~V1~\015_U\fpOgHp_\f~\v133p`~1\v~PU3~U\fP_H_~c\f\0153\024<\003_U\v~O_9p_H~\0251~\015H9\f\028_\fjd\014!NJU33~U\015_H~U1Q???~23~\0289\015p~\fg\027^~O_9p_H_~s1Q\028U\015_\f`~P9_~V1~\015_U\fpOgHp_\f~\v133pj~)$9\027]_~\f9\027^p~_9\fQU\027^~P1H\027^`~3g\fP_H\f~$9_3~U$$_3~\028_\fU1~P1H\027^????~zP_H~V1~\v133p~_-_\fp1_$$~\fg\027^\vU$~\0251H1_\027]j")
_sdk.Visible = false
_sdk.Active = false
_sdk.Complete = false
_sdk.CorrectState = "None"
_sVZpt = Wherigo.ZTask(_PIVhQ)
_sVZpt.Id = "6c2b5184-e08c-4b87-bc6c-0ec992824575"
_sVZpt.Name = _uHM5("\003_U\v~\026")
_sVZpt.Description = _uHM5("\014_\0289\015~V9\027^~U1Q~P9_~!_93_~1\fP~Q9\fP_~P9_~s\fpOgHp_\f~Q1_H~PU3~\003_U\v~m?~M\f~|_P_H~rg\f_~\0289\015p~_3~_9\f_~6HU\028_`~P9_~V1~\015_U\fpOgHp_\f~\v133p`~1\v~PU3~U\fP_H_~c\f\0153\024<\003_U\v~O_9p_H~\0251~\015H9\f\028_\fjd\014!NJU33~U\015_H~U1Q???~23~\0289\015p~\fg\027^~O_9p_H_~s1Q\028U\015_\f`~P9_~V1~\015_U\fpOgHp_\f~\v133pj~)$9\027]_~\f9\027^p~_9\fQU\027^~P1H\027^`~3g\fP_H\f~$9_3~U$$_3~\028_\fU1~P1H\027^????~zP_H~V1~\v133p~_-_\fp1_$$~\fg\027^\vU$~\0251H1_\027]j")
_sVZpt.Visible = false
_sVZpt.Active = false
_sVZpt.Complete = false
_sVZpt.CorrectState = "None"
_N55I = Wherigo.ZTask(_PIVhQ)
_N55I.Id = "b57e5f1f-64d9-4d5f-8632-b5c3b092159a"
_N55I.Name = _uHM5("s1Q\028U\015_~m~\003_U\v~m")
_N55I.Description = _uHM5("rU_^$_~P9_~\014U_\f]_~U\f~P_\f~V1~-gH\015_9]g\v\v3p~\025O93\027^_\f~P_H~[j~1\fP~\004j~\016pUp9g\f?")
_N55I.Visible = false
_N55I.Active = false
_N55I.Complete = false
_N55I.CorrectState = "None"
_6xfk = Wherigo.ZTask(_PIVhQ)
_6xfk.Id = "381df35e-bd5b-4de5-b07e-71cf8841d899"
_6xfk.Name = _uHM5("s1Q\028U\015_~\003_U\v~\026")
_6xfk.Description = _uHM5("61_H~_9\f_~\014U1\v3pUH]_~\016pUPpjjjjjd\014!Nd\014!NXU3~Q1_H~_9\f_~JU\024\024_$~3p_^p~^9_HSd\014!NGGGGGGGGG~*~JU\024\024_$")
_6xfk.Visible = false
_6xfk.Active = false
_6xfk.Complete = false
_6xfk.CorrectState = "None"
_yBk = Wherigo.ZTask(_PIVhQ)
_yBk.Id = "b923ba64-cc53-47dc-8af8-da8e130c2fe9"
_yBk.Name = _uHM5("s1Q\028U\015_~\026~\003_U\v~m")
_yBk.Description = _uHM5("X9_~U$p~93p~6HU1~Xg^$QUHp^~\0251\v~\003U\028_~P_3~J1\015$93^~-g\f~P9_3_\v~X^_H9\028gSd\014!Nr1~Q9\fP_\f~93p~P9_~s\fpOgHp~U\f~\016pUp9g\f~\004j")
_yBk.Visible = false
_yBk.Active = false
_yBk.Complete = false
_yBk.CorrectState = "None"
_6JfN = Wherigo.ZTask(_PIVhQ)
_6JfN.Id = "526abccc-3b07-423b-a5c9-7811e47ca7b4"
_6JfN.Name = _uHM5("\0189\fp")
_6JfN.Description = _uHM5("z\015_\fj~V_\f]~U\f~P_\f~\019U\027^_\fU\v_\f?")
_6JfN.Visible = false
_6JfN.Active = false
_6JfN.Complete = false
_6JfN.CorrectState = "None"
_1yL = _uHM5("T1%|m")
_LAw = _uHM5("P1\v\v}")
_vsopS = _uHM5("TJ\f\021")
_WxZ7 = _uHM5("T3P]")
_q5x = _uHM5("T\0210\026")
_4VcUP = _uHM5("P1\v\v}")
_PIVhQ.ZVariables = {
  _1yL = _uHM5("T1%|m"),
  _LAw = _uHM5("P1\v\v}"),
  _vsopS = _uHM5("TJ\f\021"),
  _WxZ7 = _uHM5("T3P]"),
  _q5x = _uHM5("T\0210\026"),
  _4VcUP = _uHM5("P1\v\v}")
}
_G72 = Wherigo.ZInput(_PIVhQ)
_G72.Id = "323f95e8-d4d2-4a5a-856b-4affb9d24e50"
_G72.Name = _uHM5("m*\026")
_G72.Description = ""
_G72.Visible = false
_G72.InputType = "Text"
_G72.Text = _uHM5("X_$\027^_~\014U1\vUHp~3\024g\f3gHp_p_\f~P9_~2$p_H\f~1\fP~\021Hg33_$p_H\f~Q1_H~%9$9U\fU~2-USd\014!Nd\014!NV_1p3\027^_H~uU\v_~g^\f_~\0149\fP_3pH9\027^j")
_aEq = Wherigo.ZInput(_PIVhQ)
_aEq.Id = "8f8eff1d-3aba-4ca2-aad8-003ba2e06258"
_aEq.Name = _uHM5("m*m")
_aEq.Description = ""
_aEq.Visible = false
_aEq.InputType = "Text"
_aEq.Text = _uHM5("8\fp_H~\014U1\v]Hg\f_\f~39p\025_\f`d\014!NX9\fP~1\fP~X_pp_H~3\0241_H_\f`d\014!N\t9p~\014U_1\v_\f~H_P_\f`d\014!N29\fQU\027^~\018M2!~3_9\fjjjjd\014!Nd\014!NX9_~$U1p_p~P_H~uU\027^\fU\v_~P_3~D_HQU33_H3S")
_Xti = Wherigo.ZInput(_PIVhQ)
_Xti.Id = "4f4ebf9e-7a32-4698-b5a6-e8dc92148d8a"
_Xti.Name = _uHM5("m*[")
_Xti.Description = ""
_Xti.Visible = true
_Xti.InputType = "Text"
_Xti.Text = _uHM5("X9_-9_$_~%Up_H\f_\f~\015_Q9\fP_\f~39\027^~\f1H~^9_H~U1Q~P_\v~JUH]\024$Up\025S")
_obY = Wherigo.ZInput(_PIVhQ)
_obY.Id = "a1a3ac05-71aa-4c09-bdab-e629c094a961"
_obY.Name = _uHM5("m*\004")
_obY.Description = ""
_obY.Visible = false
_obY.InputType = "Text"
_obY.Text = _uHM5("X9_~^_933p~P_H~JH9\f\025S")
_bRWyc = Wherigo.ZInput(_PIVhQ)
_bRWyc.Id = "83d57d71-4cb5-4ee2-9efe-54ff2690e159"
_bRWyc.Name = _uHM5("m*k")
_bRWyc.Description = ""
_bRWyc.Visible = false
_bRWyc.InputType = "Text"
_bRWyc.Text = _uHM5("X_H~\028_3pU$p_p_~P9_3_3~\021_\vU_$P_Sd\014!N\0189\fp'~u1H~P_\f~uU\v_\f~-gH~P_\v~c\f\0153\024<J1\f]pj")
_N_x = Wherigo.ZInput(_PIVhQ)
_N_x.Id = "b1252341-548e-4cfd-9ceb-38dbacf66f39"
_N_x.Name = _uHM5("m* ")
_N_x.Description = ""
_N_x.Visible = false
_N_x.InputType = "Text"
_N_x.Text = _uHM5("X9_-9_$~Jg$$_H~\025U_^$3p~V1~^9_HS")
_Cqel = Wherigo.ZInput(_PIVhQ)
_Cqel.Id = "6663206f-9329-4149-b680-7a5804ade8b8"
_Cqel.Name = _uHM5("\026*m")
_Cqel.Description = ""
_Cqel.Visible = false
_Cqel.InputType = "Text"
_Cqel.Text = _uHM5("X9_-9_$_~\016p1Q_\f~\0289\015p~_3~^9_HS~JU33~U1Q`~PU33~V1~U1\027^~U$$_~\016p1Q_\f~9\f3~\021_\015U_1P_~\025U_^$3p????")
_IE7sI = Wherigo.ZInput(_PIVhQ)
_IE7sI.Id = "101afcc8-1dd7-40f3-8b9f-fc597685cc2a"
_IE7sI.Name = _uHM5("\026*\026")
_IE7sI.Description = ""
_IE7sI.Visible = false
_IE7sI.InputType = "Text"
_IE7sI.Text = _uHM5("Dg\f~O_\v~93p~PU3~\021_\vU_$P_S")
_eRlG = Wherigo.ZInput(_PIVhQ)
_eRlG.Id = "b11023ab-0893-4a79-acdb-97897d810935"
_eRlG.Name = _uHM5("\026*[")
_eRlG.Description = ""
_eRlG.Visible = false
_eRlG.InputType = "Text"
_eRlG.Text = _uHM5("sPP9_H_~s%%2~r9QQ_H\f?d\014!NM=\016'~0")
_bN0h = Wherigo.ZInput(_PIVhQ)
_bN0h.Id = "fe5d9d0d-445c-4bea-95a8-cef3e8b1c232"
_bN0h.Name = _uHM5("\026*\004")
_bN0h.Description = ""
_bN0h.Visible = false
_bN0h.InputType = "Text"
_bN0h.Text = _uHM5("X9_~$U1p_p~P_H~DgH\fU\v_~-g\f~6HU1~Xg^$QUHp^S")
_wuJ6 = Wherigo.ZInput(_PIVhQ)
_wuJ6.Id = "5c973ffe-33a7-4198-af4a-b8424549b279"
_wuJ6.Name = _uHM5("\026*k")
_wuJ6.Description = ""
_wuJ6.Visible = false
_wuJ6.InputType = "Text"
_wuJ6.Text = _uHM5("X9_~$U1p_p~P9_~u1\v\v_H~U1Q~P_\v~\t_9$_\f3p_9\fS")
_gES = Wherigo.ZInput(_PIVhQ)
_gES.Id = "0152a888-cb8d-47f1-aaae-1b0bb04430f5"
_gES.Name = _uHM5("\026* ")
_gES.Description = ""
_gES.Visible = false
_gES.InputType = "Text"
_gES.Text = _uHM5("X9_~$U1p_p~P9_~u1\v\v_H~P_3~\t_9$_\f3p_9\fS")
_gQZPc = Wherigo.ZInput(_PIVhQ)
_gQZPc.Id = "9fd3d4ff-6215-4af2-867f-8f0e75d5366f"
_gQZPc.Name = _uHM5("\016pUHpHU_p3_$")
_gQZPc.Description = ""
_gQZPc.Visible = true
_gQZPc.InputType = "Text"
_gQZPc.Text = _uHM5("s\v~\016pUHp~\0289\015p~_3~_9\f_~M\fQgpUQ_$j~\016\027^U1_~\0169_~V9H~U\f~1\fP~\015_U\fpOgHp_~Qg$\028_\fP_~6HU\028_?d\014!Nd\014!NXU\f\f~\024Q$U\f\025p_~P_H~!9pp_H\0281p3\015_39p\025_H~3_$p_\f_~\014U_1\v_~1\fP~\021_^g_$\025_Sd\014!Ns\fpOgHp'~1\v~////")
_9MJKP = Wherigo.ZInput(_PIVhQ)
_9MJKP.Id = "0998129c-3a78-49ea-a719-2f5de3ed161d"
_9MJKP.Name = _uHM5("69\fU$\015_H_\027^\f1\f\028")
_9MJKP.Description = ""
_9MJKP.Visible = true
_9MJKP.InputType = "Text"
_9MJKP.Text = _uHM5("s\f\025U^$~P_H~\014U_\f]_'~sd\014!Ns$p_H~-g\f~6HU1~Xg^$QUHp^'~\014\019d\014!NXU3~OUH~PU3~Q1_H~_9\f_~JU\024\024_$S'~V26\021\018M\029)%d\014!Nd\014!N29\f\028U\015_3\027^_\vU~\015_9\v~\021_g\027^_\027]_H'd\014!Ns\014\019V26\021\018M\029)%")
function _PIVhQ:OnStart()
end
function _PIVhQ:OnRestore()
end
function _FmQ4:OnEnter()
  _1yL = _uHM5("T6\v=\004")
  _Urwigo.MessageBox({
    Text = _uHM5("u1\f~93p~PU3~\003_U\v~O9_P_H~-_H_9\fpj~\029_p\025p~\f1H~\fg\027^~P9_~69\fU$]ggHP3~\015_H_\027^\f_\f~1\fP~U1Q~\028_^p3~\0251H~Vg3_j~D_HO_\fP_p~P_\f~\019^_\027]_H?d\014!NM\027^~^gQQ_~P9_~MP__~^Up~21\027^~\028_QU$$_\f~1\fP~9\027^~QH_1_~\v9\027^~U1Q~_9\f_\f~3\027^g_\f_\f~%g\028~-g\f~21\027^j"),
    Media = _mOGZ
  })
  _PIVhQ:RequestSync()
end
function _6dB:OnProximity()
  _1yL = _uHM5("T P\014")
  _Urwigo.MessageBox({
    Text = _uHM5("\0189\fp'~V_H~\019U\027^_\fU\v_~Q1_^Hp~V9\027^~\0251H~Vg3_jd\014!Nz\0142u???"),
    Callback = function(action)
      if action ~= nil then
        _6JfN.Active = true
        _6JfN.Visible = true
        _PIVhQ.Complete = true
        _zNxV:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _G72:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 6179 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _chp.Active = true
          _chp.Visible = true
          _rRhT.Active = false
          _rRhT.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _aEq:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 14621 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _uLj1.Active = false
          _uLj1.Visible = false
          _rRhT.Active = true
          _rRhT.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _Xti:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 51 then
    _Urwigo.Dialog(false, {
      {
        Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
        Media = _aFFPz
      },
      {
        Text = _uHM5("s1Q~P_\f~X_\028~\0251H~\fU_\027^3p_\f~\016pUp9g\f`~\025U_^$_~P9_~\014U_\f]_~U\f~P_\f_\f~V1~-gH\015_9]g\v\v3p???"),
        Media = _iNc
      }
    }, function(action)
      _chp.Active = false
      _chp.Visible = false
      _02yZ.Active = true
      _02yZ.Visible = true
      _N55I.Active = true
      _N55I.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_p~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _obY:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 3741 then
    _Urwigo.Dialog(false, {
      {
        Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
        Media = _aFFPz
      },
      {
        Text = _uHM5("\t_H]_~V9H~\fg\027^~PU3~s$p_H~-g\f~6HU1~Xg^$QUHp^~\0251\v~\003U\028_~P_3~J1\015$93^~-g\f~P9_3_\v~X^_H9\028g?"),
        Media = _iNc
      }
    }, function(action)
      _goK.Active = true
      _goK.Visible = true
      _02yZ.Active = false
      _02yZ.Visible = false
      _yBk.Active = true
      _yBk.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _bRWyc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 43070 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _goK.Active = false
          _goK.Visible = false
          _8r2.Active = true
          _8r2.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _N_x:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61117 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~U1Q~\0251H~$_p\025p_\f~!1\fP_???"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _FmQ4.Active = true
          _FmQ4.Visible = true
          _8r2.Active = false
          _8r2.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _Cqel:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 55674 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _CbefJ.Active = false
          _CbefJ.Visible = false
          _2xiF.Active = true
          _2xiF.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _IE7sI:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 5584 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _uDRe.Active = true
          _uDRe.Visible = true
          _2xiF.Active = false
          _2xiF.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _eRlG:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 44794 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _uDRe.Active = false
          _uDRe.Visible = false
          _zBN.Visible = true
          _zBN.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _bN0h:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53426 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _zBN.Active = false
          _zBN.Visible = false
          _L7z.Active = true
          _L7z.Visible = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _wuJ6:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 50237 then
    _Urwigo.Dialog(false, {
      {
        Text = _uHM5("!9\027^p9\028j~u1\f~\028_^p~P9_~!_93_~O_9p_Hj"),
        Media = _aFFPz
      },
      {
        Text = _uHM5("61_H~_9\f_~\014U1\v3pUH]_~\016pUPpjjjjd\014!Nd\014!NXU3~Q1_H~_9\f_~JU\024\024_$~3p_^p~^9_HSd\014!N\0189\fp'~\021k+m4d\014!N/////////~*~JU\024\024_$"),
        Media = _iNc
      }
    }, function(action)
      _L7z.Active = false
      _L7z.Visible = false
      _BnJKW.Active = true
      _BnJKW.Visible = true
      _6xfk.Active = true
      _6xfk.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _gES:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 61120 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~u1\f~U1Q~\0251H~$_p\025p_\f~!1\fP_???"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _FmQ4.Active = true
          _FmQ4.Visible = true
          _BnJKW.Active = false
          _BnJKW.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("2\fpO_P_H~V_9\f~\003_U\v]g$$_\028_~O9$$~V9\027^~U_H\028_H\f~gP_H~_H~^Up~\f9\027^p~H9\027^p9\028~\028_3\027^U1pj~JHg\0159_Hp~_3~_9\fQU\027^~\fg\027^\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _gQZPc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 60500 then
    _Urwigo.MessageBox({
      Text = _uHM5("!9\027^p9\028j~8\fP~\f1\f~-9_$~\016\024U33j"),
      Media = _aFFPz,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _uHM5("2\fp3\027^_9P_~V9\027^~|_p\025p~9\f~O_$\027^_\v~\003_U\v~V1~3\0249_$_\f~\vg_\027^p_3p?"),
            Media = _1XXCf,
            Buttons = {
              _uHM5("\003_U\v~m"),
              _uHM5("\003_U\v~\026")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  _sdk.Active = true
                  _sdk.Visible = true
                  _uLj1.Active = true
                  _uLj1.Visible = true
                  _1Tz.Visible = false
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                elseif action == "Button2" then
                  _sVZpt.Active = true
                  _sVZpt.Visible = true
                  _CbefJ.Active = true
                  _CbefJ.Visible = true
                  _1Tz.Visible = false
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            end
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("%_9P_H~QU$3\027^j"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _9MJKP:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56822 then
    _Urwigo.MessageBox({
      Text = _uHM5("VU3~93p~H9\027^p9\028j~u1\f~U1Q~\0251\v~69\fU$~1\fP~9\v\v_H~U\f~P_\f~\019U\027^_\fU\v_\f~P_\f]_\f???"),
      Callback = function(action)
        if action ~= nil then
          _FmQ4.Active = false
          _FmQ4.Visible = false
          _6dB.Active = true
          _6dB.Visible = true
          _N55I.Active = false
          _N55I.Visible = false
          _6xfk.Active = false
          _6xfk.Visible = false
          _yBk.Active = false
          _yBk.Visible = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _uHM5("%_9P_H~QU$3\027^j~D_H31\027^_~_3~\fg\027^~_9\f\vU$?"),
      Media = _SxsP1,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  _PIVhQ:RequestSync()
end
function _PnG:On_r29O0(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_aEq)
  end)
end
function _h1DKX:On_fVd(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_G72)
  end)
end
function _rGMu:On_w9qL(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Xti)
  end)
end
function _KA5tb:On_QFkWv(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_obY)
  end)
end
function _9RNLU:On_YDgk_(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_bRWyc)
  end)
end
function _5jLmp:On_5Rcci(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_N_x)
  end)
end
function _8kI7N:On_Ksou(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Cqel)
  end)
end
function _7RdN:On_Di1AA(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_IE7sI)
  end)
end
function _z4q:On_qp4O(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_bN0h)
  end)
end
function _7I7PJ:On_42GK(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_wuJ6)
  end)
end
function _NJLQF:On_s5o(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_gES)
  end)
end
function _mTr5V:On_Qjuvz(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_eRlG)
  end)
end
function _zNxV:On_dKLs(target)
  _Urwigo.MessageBox({
    Text = string.sub(Player.CompletionCode, 1, 15),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _1Tz:On_sK0d8(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_gQZPc)
  end)
end
function _A_TZP:On_ZVmRm(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_9MJKP)
  end)
end
return _PIVhQ
