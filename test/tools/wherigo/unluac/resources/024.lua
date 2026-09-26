require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _g6vX(str)
  local res = ""
  local dtable = "kV7B'<\026*+-\028x\015NR!b)P&pFXq/,_QIn:.a\020T\av\006\014D\004]@W\0169#EiZ\030{4rChJ36\0170?Uj\\`$\021s\024(\ndc M\029\031L=5G8S\005\tzfmo\000leOy1\002\027\022w>\018\019\0032}~\r\001tgKYA\bH\"[u\v%|;\023\025^\f"
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
_kLqD = Wherigo.ZCartridge()
_kEc = Wherigo.ZMedia(_kLqD)
_kEc.Id = "5f62b985-2bf8-471b-b1c2-a1e54c533fa1"
_kEc.Name = _g6vX("(6!J8]")
_kEc.Description = ""
_kEc.AltText = _g6vX("\0041\\IKI]EK(6!J8]\030")
_kEc.Resources = {
  {
    Type = "jpg",
    Filename = "drache_kl.jpg",
    Directives = {}
  }
}
_gTA0t = Wherigo.ZMedia(_kLqD)
_gTA0t.Id = "cdbb03f2-40ea-45c5-b40c-74fd9e898b4f"
_gTA0t.Name = _g6vX("r\021X]\\")
_gTA0t.Description = ""
_gTA0t.AltText = _g6vX("r\021X]\\")
_gTA0t.Resources = {
  {
    Type = "jpg",
    Filename = "Apfel_kl.jpg",
    Directives = {}
  }
}
_LuL = Wherigo.ZMedia(_kLqD)
_LuL.Id = "a9aa1b97-7479-43ae-8445-610d24880f26"
_LuL.Name = _g6vX("(6!J8]\030EJ8!nW")
_LuL.Description = ""
_LuL.AltText = ""
_LuL.Resources = {
  {
    Type = "jpg",
    Filename = "Drachenschatz.jpg",
    Directives = {}
  }
}
_MOjxr = Wherigo.ZMedia(_kLqD)
_MOjxr.Id = "4031a872-ad62-4252-901e-c44820c09c16"
_MOjxr.Name = _g6vX("(6!J8]\030EJ8!nW\027\001\\")
_MOjxr.Description = ""
_MOjxr.AltText = ""
_MOjxr.Resources = {
  {
    Type = "jpg",
    Filename = "Drachenschatz_kl.jpg",
    Directives = {}
  }
}
_YRuUM = Wherigo.ZMedia(_kLqD)
_YRuUM.Id = "f9b7871d-7075-4950-ae04-da2b8339d0a2"
_YRuUM.Name = _g6vX("RZ\\IYw\030W]\030")
_YRuUM.Description = ""
_YRuUM.AltText = _g6vX("\0041\\IK%Z\030KI6]1KRZ\\IYw\030W]\030")
_YRuUM.Resources = {
  {
    Type = "jpg",
    Filename = "Goldmuenzen.jpg",
    Directives = {}
  }
}
_drTM = Wherigo.ZMedia(_kLqD)
_drTM.Id = "74b09303-504e-4999-bd7a-6b3f6a8889de"
_drTM.Name = _g6vX("(6!J8]\030d!\\I")
_drTM.Description = ""
_drTM.AltText = _g6vX("\0041\\IK%ZYK(6!J8]\030d!\\I")
_drTM.Resources = {
  {
    Type = "jpg",
    Filename = "drachenwald_kl.jpg",
    Directives = {}
  }
}
_YPNN0 = Wherigo.ZMedia(_kLqD)
_YPNN0.Id = "1e298931-1293-42c0-bed7-2dffd2bd72e9"
_YPNN0.Name = _g6vX("9w\030o]")
_YPNN0.Description = ""
_YPNN0.AltText = _g6vX("\0041\\IK]1\030]EK9w\030o]\030")
_YPNN0.Resources = {
  {
    Type = "jpg",
    Filename = "Junge_kl.jpg",
    Directives = {}
  }
}
_Hcphn = Wherigo.ZMedia(_kLqD)
_Hcphn.Id = "36377f9d-70fc-479c-8717-a3ec1a0dcffd"
_Hcphn.Name = _g6vX("TJ8!nW")
_Hcphn.Description = ""
_Hcphn.AltText = _g6vX("\0041\\IK%ZYK(6!J8]\030EJ8!nW")
_Hcphn.Resources = {
  {
    Type = "jpg",
    Filename = "schatz_kl.jpg",
    Directives = {}
  }
}
_gYWu = Wherigo.ZMedia(_kLqD)
_gYWu.Id = "8de3e499-8619-458b-a46e-dd094350c901"
_gYWu.Name = _g6vX("TJ8Y1]I]")
_gYWu.Description = ""
_gYWu.AltText = _g6vX("\0041\\IK]1\030]6KTJ8Y1]I]")
_gYWu.Resources = {
  {
    Type = "jpg",
    Filename = "schmiede_kl.jpg",
    Directives = {}
  }
}
_l9bo = Wherigo.ZMedia(_kLqD)
_l9bo.Id = "b89514bb-693e-44b9-b161-d76818a79e79"
_l9bo.Name = _g6vX("TJ8d]6n")
_l9bo.Description = ""
_l9bo.AltText = _g6vX("\0041\\IK%ZYKTJ8d]6n")
_l9bo.Resources = {
  {
    Type = "jpg",
    Filename = "schwert_kl.jpg",
    Directives = {}
  }
}
_XAEjt = Wherigo.ZMedia(_kLqD)
_XAEjt.Id = "03833900-07c7-4774-ac32-af1a0939f9c7"
_XAEjt.Name = _g6vX("#!%]6\030]")
_XAEjt.Description = ""
_XAEjt.AltText = _g6vX("\0041\\IKI]6K#!%]6\030]")
_XAEjt.Resources = {
  {
    Type = "jpg",
    Filename = "taverne_kl.jpg",
    Directives = {}
  }
}
_MPi = Wherigo.ZMedia(_kLqD)
_MPi.Id = "421bfefb-3c27-4988-9cff-4c68bdd917ed"
_MPi.Name = _g6vX("r\021X]\\\027\001\\")
_MPi.Description = ""
_MPi.AltText = ""
_MPi.Resources = {
  {
    Type = "jpg",
    Filename = "Apfel_tumb.jpg",
    Directives = {}
  }
}
_StY = Wherigo.ZMedia(_kLqD)
_StY.Id = "65800797-48b3-4ddb-bcdf-a3bcb0930d4c"
_StY.Name = _g6vX("RZ\\IYw\030W]\030\027\001\\")
_StY.Description = ""
_StY.AltText = ""
_StY.Resources = {
  {
    Type = "jpg",
    Filename = "Goldmuenzen_tumb.jpg",
    Directives = {}
  }
}
_9oO4 = Wherigo.ZMedia(_kLqD)
_9oO4.Id = "e080965f-8b4a-4d57-a263-d707be4dfc93"
_9oO4.Name = _g6vX("TJ8d]6n\027\001\\")
_9oO4.Description = ""
_9oO4.AltText = ""
_9oO4.Resources = {
  {
    Type = "jpg",
    Filename = "schwert_tumb.jpg",
    Directives = {}
  }
}
_ubJK = Wherigo.ZMedia(_kLqD)
_ubJK.Id = "d4e79f82-a38d-4363-ace3-d935ad693d2b"
_ubJK.Name = _g6vX("T\021Z1\\]6")
_ubJK.Description = ""
_ubJK.AltText = ""
_ubJK.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler_kl.jpg",
    Directives = {}
  }
}
_o81 = Wherigo.ZMedia(_kLqD)
_o81.Id = "9f6bc17e-42b3-4862-b3bd-98136b80ab9d"
_o81.Name = _g6vX("T\021Z1\\]6")
_o81.Description = ""
_o81.AltText = ""
_o81.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler_kl1.jpg",
    Directives = {}
  }
}
_kLqD.Id = "811a1263-a057-4902-9ecb-ee029dfcdc4e"
_kLqD.Name = "Der Drachenschatz"
_kLqD.Description = "Ein kleiner Ausflug in die Welt der Sagen von Helden und Drachen.<BR>\nDu bist unterwegs auf der Suche nach dem Drachenschatz. Der Sage nach kannst du ihn nur finden indem du den Drachen erschl\195\164gst der den Schatz bewacht.<BR>\nViel Spass!"
_kLqD.Visible = true
_kLqD.Activity = "Geocache"
_kLqD.StartingLocationDescription = "In dieser Strasse kannst du parken und hier geht es los."
_kLqD.StartingLocation = ZonePoint(52.422683, 13.023833, 0)
_kLqD.Version = "1"
_kLqD.Company = ""
_kLqD.Author = "fimpler"
_kLqD.BuilderVersion = "URWIGO 1.22.5798.37755"
_kLqD.CreateDate = "02/08/2017 14:59:37"
_kLqD.PublishDate = "1/1/0001 12:00:00 AM"
_kLqD.UpdateDate = "02/11/2017 22:24:19"
_kLqD.LastPlayedDate = "1/1/0001 12:00:00 AM"
_kLqD.TargetDevice = "PocketPC"
_kLqD.TargetDeviceVersion = "0"
_kLqD.StateId = "1"
_kLqD.CountryId = "2"
_kLqD.Complete = false
_kLqD.UseLogging = true
_kLqD.Media = _LuL
_kLqD.Icon = _MOjxr
_KgW = Wherigo.Zone(_kLqD)
_KgW.Id = "83864a2c-9b8a-4012-abe2-97425a5d3384"
_KgW.Name = _g6vX("TJ8!nW%]6En]J\001")
_KgW.Description = ""
_KgW.Visible = false
_KgW.Media = _Hcphn
_KgW.Commands = {}
_KgW.DistanceRange = Distance(-1, "feet")
_KgW.ShowObjects = "OnProximity"
_KgW.ProximityRange = Distance(10, "meters")
_KgW.AllowSetPositionTo = false
_KgW.Active = false
_KgW.Points = {
  ZonePoint(52.425333, 13.017933, 0),
  ZonePoint(52.425332, 13.017933, 0),
  ZonePoint(52.425333, 13.017932, 0)
}
_KgW.OriginalPoint = ZonePoint(52.4253326666667, 13.0179326666667, 0)
_KgW.DistanceRangeUOM = "Feet"
_KgW.ProximityRangeUOM = "Meters"
_KgW.OutOfRangeName = ""
_KgW.InRangeName = ""
_UZ3n = Wherigo.Zone(_kLqD)
_UZ3n.Id = "e591adbf-f923-4873-8386-9205997a84b4"
_UZ3n.Name = _g6vX("(6!J8]\030d!\\I")
_UZ3n.Description = ""
_UZ3n.Visible = true
_UZ3n.Media = _drTM
_UZ3n.Commands = {}
_UZ3n.DistanceRange = Distance(-1, "feet")
_UZ3n.ShowObjects = "OnEnter"
_UZ3n.ProximityRange = Distance(60, "meters")
_UZ3n.AllowSetPositionTo = false
_UZ3n.Active = true
_UZ3n.Points = {
  ZonePoint(52.4244497683182, 13.0206796527074, 0),
  ZonePoint(52.4252741180672, 13.0212053656744, 0),
  ZonePoint(52.4251792532064, 13.0216398835347, 0),
  ZonePoint(52.424318917734, 13.0210444331334, 0)
}
_UZ3n.OriginalPoint = ZonePoint(52.4248055143315, 13.0211423337625, 0)
_UZ3n.DistanceRangeUOM = "Feet"
_UZ3n.ProximityRangeUOM = "Meters"
_UZ3n.OutOfRangeName = ""
_UZ3n.InRangeName = ""
_ZCC = Wherigo.Zone(_kLqD)
_ZCC.Id = "cc7dbb15-7cd6-4613-b742-2fb8f52920ff"
_ZCC.Name = _g6vX("#!%]6\030]")
_ZCC.Description = ""
_ZCC.Visible = false
_ZCC.Media = _XAEjt
_ZCC.Commands = {}
_ZCC.DistanceRange = Distance(-1, "feet")
_ZCC.ShowObjects = "OnEnter"
_ZCC.ProximityRange = Distance(60, "meters")
_ZCC.AllowSetPositionTo = false
_ZCC.Active = false
_ZCC.Points = {
  ZonePoint(52.4249240984299, 13.0228254199194, 0),
  ZonePoint(52.424852131431, 13.0232438445257, 0),
  ZonePoint(52.424688569633, 13.0232009291814, 0),
  ZonePoint(52.4247703506078, 13.0227127671408, 0)
}
_ZCC.OriginalPoint = ZonePoint(52.4248087875254, 13.0229957401918, 0)
_ZCC.DistanceRangeUOM = "Feet"
_ZCC.ProximityRangeUOM = "Meters"
_ZCC.OutOfRangeName = ""
_ZCC.InRangeName = ""
_L09Q = Wherigo.Zone(_kLqD)
_L09Q.Id = "a5f51b43-0bc1-4714-8cf0-9bd04740dc33"
_L09Q.Name = _g6vX("TJ8Y1]I]")
_L09Q.Description = ""
_L09Q.Visible = false
_L09Q.Media = _gYWu
_L09Q.Commands = {}
_L09Q.DistanceRange = Distance(-1, "feet")
_L09Q.ShowObjects = "OnEnter"
_L09Q.ProximityRange = Distance(60, "meters")
_L09Q.AllowSetPositionTo = false
_L09Q.Active = false
_L09Q.Points = {
  ZonePoint(52.4256666601488, 13.0247351527379, 0),
  ZonePoint(52.4256404907855, 13.0251213908361, 0),
  ZonePoint(52.4253951522484, 13.0250623822378, 0),
  ZonePoint(52.4254311353193, 13.0246761441396, 0)
}
_L09Q.OriginalPoint = ZonePoint(52.4255333596255, 13.0248987674878, 0)
_L09Q.DistanceRangeUOM = "Feet"
_L09Q.ProximityRangeUOM = "Meters"
_L09Q.OutOfRangeName = ""
_L09Q.InRangeName = ""
__hxpH = Wherigo.ZCharacter({Cartridge = _kLqD, Container = _UZ3n})
__hxpH.Id = "1cb29569-be2c-41cc-8baa-4cadcbf6bb58"
__hxpH.Name = _g6vX("(6!J8]")
__hxpH.Description = ""
__hxpH.Visible = false
__hxpH.Media = _kEc
__hxpH.Commands = {}
__hxpH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__hxpH.Gender = "It"
__hxpH.Type = "NPC"
_z59 = Wherigo.ZCharacter({Cartridge = _kLqD, Container = _ZCC})
_z59.Id = "3431f1ef-1bc2-4c36-b8d4-d9ad84a5c81b"
_z59.Name = _g6vX("9w\030o]")
_z59.Description = ""
_z59.Visible = false
_z59.Media = _YPNN0
_z59.Commands = {}
_z59.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_z59.Gender = "Male"
_z59.Type = "NPC"
_2k6 = Wherigo.ZCharacter({Cartridge = _kLqD, Container = _L09Q})
_2k6.Id = "4cb4aeca-e649-41fe-80df-331a44e97b7e"
_2k6.Name = _g6vX("TJ8Y1]I")
_2k6.Description = ""
_2k6.Visible = false
_2k6.Media = _gYWu
_2k6.Commands = {}
_2k6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2k6.Gender = "Male"
_2k6.Type = "NPC"
_oBeb = Wherigo.ZItem({Cartridge = _kLqD, Container = Player})
_oBeb.Id = "b7e88e0b-9240-44eb-bbeb-ba553e4d86f8"
_oBeb.Name = _g6vX("TJ8d]6n")
_oBeb.Description = ""
_oBeb.Visible = true
_oBeb.Media = _l9bo
_oBeb.Icon = _9oO4
_oBeb.Commands = {
  _hJ_X = Wherigo.ZCommand({
    Text = _g6vX("#Z]n]KI]\030K(6!J8]\030"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _g6vX("\014Zn81\030oK!%!1\\!\017\\]")
  }),
  _fZAk5 = Wherigo.ZCommand({
    Text = _g6vX("TJ8d]6nK!\017o]\017]\030"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _g6vX("\014Zn81\030oK!%!1\\!\017\\]")
  })
}
_oBeb.Commands._hJ_X.Custom = true
_oBeb.Commands._hJ_X.Id = "c39000d3-99b5-45d5-a390-3ca64f9c25c7"
_oBeb.Commands._hJ_X.WorksWithAll = true
_oBeb.Commands._fZAk5.Custom = true
_oBeb.Commands._fZAk5.Id = "a33dfca8-fdad-4b23-b32f-2cebbd5f6bbf"
_oBeb.Commands._fZAk5.WorksWithAll = true
_oBeb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_oBeb.Locked = false
_oBeb.Opened = false
_KMNC = Wherigo.ZItem({Cartridge = _kLqD, Container = Player})
_KMNC.Id = "226899d2-f199-4a21-aeca-82118749e63a"
_KMNC.Name = _g6vX("RZ\\IYw\030W]\030")
_KMNC.Description = ""
_KMNC.Visible = true
_KMNC.Media = _YRuUM
_KMNC.Icon = _StY
_KMNC.Commands = {
  _TYuKQ = Wherigo.ZCommand({
    Text = _g6vX("\004]W!8\\]KI]\030KTJ8Y1]I"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _g6vX("\014Zn81\030oK!%!1\\!\017\\]")
  })
}
_KMNC.Commands._TYuKQ.Custom = true
_KMNC.Commands._TYuKQ.Id = "fab8154a-4a93-46fa-b942-8420189d4ffc"
_KMNC.Commands._TYuKQ.WorksWithAll = true
_KMNC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KMNC.Locked = false
_KMNC.Opened = false
_22N = Wherigo.ZItem(_kLqD)
_22N.Id = "29f2eb85-7c1a-4e40-a388-4c180cf47e83"
_22N.Name = _g6vX("r]\021X]\\")
_22N.Description = ""
_22N.Visible = false
_22N.Media = _gTA0t
_22N.Icon = _MPi
_22N.Commands = {
  _06fn = Wherigo.ZCommand({
    Text = _g6vX("\022w]nn]6]KI]\030K(6!J8]\030"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _g6vX("\014Zn81\030oK!%!1\\!\017\\]")
  })
}
_22N.Commands._06fn.Custom = true
_22N.Commands._06fn.Id = "d7c0cfcc-285f-477f-b091-b3d5532d9b10"
_22N.Commands._06fn.WorksWithAll = true
_22N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_22N.Locked = false
_22N.Opened = false
_H9EJn = Wherigo.ZItem(_kLqD)
_H9EJn.Id = "47e946f6-876e-4604-b109-e7d03c3ffdb2"
_H9EJn.Name = _g6vX("T\021Z1\\]6")
_H9EJn.Description = _g6vX("(!KX1\030I]EnKIwKI]\030K(6!J8]\030EJ8!nW ")
_H9EJn.Visible = true
_H9EJn.Media = _ubJK
_H9EJn.Commands = {}
_H9EJn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_H9EJn.Locked = false
_H9EJn.Opened = false
_uNk = Wherigo.ZItem(_kLqD)
_uNk.Id = "881ae084-0fea-4bea-9e7a-beb507ffd05d"
_uNk.Name = _g6vX("?\030\\ZJ\001K7ZI]")
_uNk.Description = ""
_uNk.Visible = false
_uNk.Commands = {}
_uNk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_uNk.Locked = false
_uNk.Opened = false
_QpaHP = Wherigo.ZTask(_kLqD)
_QpaHP.Id = "c7b4b2a5-732a-476e-bb16-54ba045bdd97"
_QpaHP.Name = _g6vX("R]8]KWwYK(6!J8]\030d!\\I")
_QpaHP.Description = ""
_QpaHP.Visible = false
_QpaHP.Active = false
_QpaHP.Complete = false
_QpaHP.CorrectState = "None"
_HCA = Wherigo.ZTask(_kLqD)
_HCA.Id = "bd5c629b-3077-4d6b-95ab-831f56b685b3"
_HCA.Name = _g6vX("R]8]KWw6KTJ8Y1]I]")
_HCA.Description = ""
_HCA.Visible = false
_HCA.Active = false
_HCA.Complete = false
_HCA.CorrectState = "None"
_NUCZ = Wherigo.ZTask(_kLqD)
_NUCZ.Id = "ec5336be-1ee3-4880-a28b-298e2b571d02"
_NUCZ.Name = _g6vX("R]8]KWw6K#!%]6\030]")
_NUCZ.Description = ""
_NUCZ.Visible = false
_NUCZ.Active = false
_NUCZ.Complete = false
_NUCZ.CorrectState = "None"
_Tijwg = Wherigo.ZTask(_kLqD)
_Tijwg.Id = "9883d9e0-acb8-46dc-b85f-96c417f4a59d"
_Tijwg.Name = _g6vX("R]8]KWwYKTJ8!nW%]6En]J\001")
_Tijwg.Description = ""
_Tijwg.Visible = false
_Tijwg.Active = false
_Tijwg.Complete = false
_Tijwg.CorrectState = "None"
_u866M = Wherigo.ZTask(_kLqD)
_u866M.Id = "51c68c67-3c4d-48ae-b875-8724ae57352a"
_u866M.Name = _g6vX("21]8]KI]1\030KTJ8d]6n")
_u866M.Description = ""
_u866M.Visible = false
_u866M.Active = false
_u866M.Complete = false
_u866M.CorrectState = "None"
_ep8 = Wherigo.ZTask(_kLqD)
_ep8.Id = "59b08daf-d13d-445e-9d4a-17b7a0ab62db"
_ep8.Name = _g6vX("R1\017KI]YK(6!J8]\030KI1]Kr]\021X]\\")
_ep8.Description = ""
_ep8.Visible = false
_ep8.Active = false
_ep8.Complete = false
_ep8.CorrectState = "None"
_lj3a = Wherigo.ZTask(_kLqD)
_lj3a.Id = "fcc43032-a0b9-4a87-82f9-79d410d81c80"
_lj3a.Name = _g6vX("R1\017KI]YKTJ8Y1]IKI1]KLw]\030W]\030")
_lj3a.Description = ""
_lj3a.Visible = false
_lj3a.Active = false
_lj3a.Complete = false
_lj3a.CorrectState = "None"
_1u0iC = Wherigo.ZTask(_kLqD)
_1u0iC.Id = "7f4587fd-d6c3-47fe-bdac-9d73a6a8a28f"
_1u0iC.Name = _g6vX("R1\017KI]YK9w\030o]\030KI!EKTJ8d]6n")
_1u0iC.Description = ""
_1u0iC.Visible = false
_1u0iC.Active = false
_1u0iC.Complete = false
_1u0iC.CorrectState = "None"
_QSwX = Wherigo.ZTask(_kLqD)
_QSwX.Id = "4cb9e12a-1d46-4092-8adb-9e240b77e3d0"
_QSwX.Name = _g6vX("TwJ8]KI]\030K7!J8]")
_QSwX.Description = ""
_QSwX.Visible = false
_QSwX.Active = false
_QSwX.Complete = false
_QSwX.CorrectState = "None"
_POE3 = _g6vX("\027po,")
_qeY = _g6vX("\027\0278\f\021t")
_tfNc = _g6vX("\027Z\004]\017")
_DnD = _g6vX("\027\028\021!t\019")
_CKK = _g6vX("IwYY_")
_04Ylo = _g6vX("IwYY_")
_kLqD.ZVariables = {
  _POE3 = _g6vX("\027po,"),
  _qeY = _g6vX("\027\0278\f\021t"),
  _tfNc = _g6vX("\027Z\004]\017"),
  _DnD = _g6vX("\027\028\021!t\019"),
  _CKK = _g6vX("IwYY_"),
  _04Ylo = _g6vX("IwYY_")
}
function _kLqD:OnStart()
  _Urwigo.MessageBox({
    Text = _g6vX("R]8]KWwYK(6!J8]\030d!\\IKwYKI]\030K(6!J8]\030KWwK\017]Wd1\030o]\030 KT]1Kn!\021X]6Kw\030IKI]\030\001]KI!6!\030\031K(wKd1\\\\EnKE]1\030]\030KTJ8!nWK8!\017]\030\016")
  })
  _QpaHP.Visible = true
  _QpaHP.Active = true
end
function _kLqD:OnRestore()
end
function _KgW:OnExit()
  _POE3 = _g6vX("\027po,")
  _Urwigo.GlobalZoneExit()
end
function _KgW:OnProximity()
  _POE3 = _g6vX("\027po,")
  _Tijwg.Active = false
  _Tijwg.Visible = false
  _kLqD.Complete = true
  _H9EJn:MoveTo(Player)
  _uNk.Visible = true
  _uNk:MoveTo(Player)
  _uNk.Description = ((_g6vX("(]6K?\030\\ZJ\001JZI]KI]6K\030w6KXw6KI]\030KT\0211]\\]6K") .. Player.Name) .. _g6vX("Kow\\n1oK1En\026K\\!wn]n\031K")) .. string.sub(Player.CompletionCode, 1, 15)
  _kLqD:RequestSync()
  _Urwigo.MessageBox({
    Text = (_g6vX("(wK8!EnK]EKo]EJ8!XXn \006\004\015e(!EKTJ8!nW%]6En]J\001K1EnK]66]1J8n \006\004\015e\014wnW]K\030w\030KI]\030KT\021Z1\\]6K1\030KI]1\030]YK\029\030%]\030n!6KwYKI]\030KTJ8!nWKWwKX1\030I]\030 \006\004\015e(]6K?\030\\ZJ\001K7ZI]KwYKI1]K7!6n61Io]K!wXKd8]6]1oZ JZYK!\\EKo]E\0211]\\nKWwK\\Zoo]\030K\\!wn]n\031K") .. string.sub(Player.CompletionCode, 1, 15)) .. _g6vX("K(1]E]\030KX1\030I]EnKIwK@]nWnK!wJ8K1\030KI]1\030]YK\029\030%]\030n!6 "),
    Callback = function(action)
      if action ~= nil then
        _QSwX.Active = true
        _QSwX.Visible = true
      end
    end
  })
end
function _UZ3n:OnEnter()
  _POE3 = _g6vX("\027?2:\030")
  _QpaHP.Active = false
  _QpaHP.Visible = false
  if _oBeb.Visible == true then
    _oBeb.Commands._hJ_X.Enabled = true
    _Urwigo.MessageBox({
      Text = _g6vX("rJ8nw\030o\016K(]6K(6!J8]K\001ZYYnK\0176w]\\\\]\030IKw\030IKX!wJ8]\030IK!wEKI]YK,!\\IKw\030IKo6]1XnKI1J8K!\030\016K\006\004\015e21]8]KI]1\030KTJ8d]6nKw\030IKnZ]n]K18\030\016")
    })
    _u866M.Active = true
    _u866M.Visible = true
  elseif _22N.Visible == true then
    _22N.Commands._06fn.Enabled = true
    _Urwigo.MessageBox({
      Text = _g6vX("(]6K(6!J8]K\001ZYYnK\\!\030oE!YK!wEKI]YK,!\\IK!wXKI1J8KWwKo]\\!wX]\030\026K\017\\]1\017nK1\030K]1\0301o]6K0\030nX]6\030w\030oKEn]8]\030Kw\030IK\017]Z\017!J8n]nKI1J8 K\006\004\015e\002]6EwJ8]K18\030KY1nKI]\030Kr]\021X]\\\030KWwKXw]nn]6\030 ")
    })
    _ep8.Active = true
    _ep8.Visible = true
  end
end
function _UZ3n:OnExit()
  _POE3 = _g6vX("\027?2:\030")
  _Urwigo.GlobalZoneExit()
end
function _ZCC:OnEnter()
  _POE3 = _g6vX("\027277")
  _NUCZ.Active = false
  _NUCZ.Visible = false
  _z59.Visible = true
  _Urwigo.OldDialog({
    {
      Text = _g6vX("t!\\\\ZK\0226]YI]6K\0151nn]6\016"),
      Media = _YPNN0
    },
    {
      Text = _g6vX("^8KY!\030\016KT1]8EnKIwKY1no]\030ZYY]\030K!wE\016\006\004\015er\\EK8!]nn]EnKIwKY1nK]1\030]YK(6!J8]\030Ko]\001!]Y\021Xn K\006\004\015et!8!8!8!8!\016\016\016Kr\017]6KEZK%]66w]J\001nK\0171EnKIwK@!K\017]En1YYnK\0301J8n\026KZI]6>")
    },
    {
      Text = _g6vX("(wK\001!\030\030EnK\017]En1YYnK]1\030]K\001\\]1\030]KTn!]6\001w\030oKo]\0176!wJ8]\030K!\017]6KI1]K#!%]6\030]K1EnK8]wn]K\\]1I]6Ko]EJ8\\ZEE]\030Kd]1\\KL\029p0K\017]1KE]1\030]6K^Y!KWwYKS=En]\030KR]\017w6nEn!oK]1\030o]\\!I]\030K1En \006\004\015et1]6\026K\0301YYK]1\030]\030Kr\021X]\\Kw\030IK]1\030]\030K\004]J8]6K,!EE]6Kw\030IK]6W!]8\\KY!\\Kd!EKIwKEZKn6]1\017En K,]\030\030K1J8Ko6ZEEK\0171\030Kd1\\\\K1J8K\030!]Y\\1J8K!wJ8K\0151nn]6Kd]6I]\030 ")
    },
    {
      Text = _g6vX(",!!!!!!E>\016>\016>K\006\004\015e(wKd1\\\\EnKI]\030K(6!J8]\030K]6EJ8\\!o]\030KwYKE]1\030]\030KTJ8!nWKWwK\017]\001ZYY]\030>\016>\016>\006\004\015e(!EK\001!\030\030EnKIwK\0301J8nKY!J8]\030 K06K1EnKY]1\030K\0226]w\030I Kr\017Kw\030IKWwK%]6\01761\030o]K1J8K]nd!EK2]1nKY1nK18Y ")
    },
    {
      Text = _g6vX("\014]1\030\026K\030]1\030 K06K1EnK\0301J8nKo]X!]86\\1J8 \006\004\015e\014w6Kd]\030\030KE1J8K@]Y!\030IKY1nK]1\030]YKTJ8d]6nK\030!]8]6nKd16IK]6K]J8nKE!w]6 K(!EK1En\026Kd]1\\K18\030KEn!]\030I1oK16o]\030Id]\\J8]K\0151nn]6K]6EJ8\\!o]\030KdZ\\\\]\030KwYK!\030KI]\030K(6!J8]\030EJ8!nWKWwK\001ZYY]\030 ")
    },
    {
      Text = _g6vX("(wKEJ8]1\030EnK@!K]1o]\030n\\1J8Ko!\030WK\030]nnKWwKE]1\030 \006\004\015e,]\030\030KIwKY16KI]1\030KTJ8d]6nK81]6K\\!]EEnK%]66!n]K1J8KI16KE]1\030]KTJ8d!J8En]\\\\] K\006\004\015e?\030IK1J8K\001!\030\030KEJ8Z\030Y!\\KI!Y1nKw]\017]\030KI!Y1nK1J8KE\021!]n]6K!wJ8K]1\030K\0151nn]6Kd]6I]\030K\001!\030\030 "),
      Media = _YPNN0
    },
    {
      Text = _g6vX("?YK!\030KI]\030KTJ8!nWKWwK\001ZYY]\030K\0176!wJ8EnKIwKI]1\030KTJ8d]6nK\0301J8n K?\030IKd]\030\030KIwK]6EnKI]\030KTJ8!nWK8!EnK\001!\030\030EnKIwKI16K@!K]1\030K\030]w]EK\001!wX]\030 \006\004\015e\014!>K,1]KE1]8nK]EK!wE>K(]!\\>")
    }
  })
  _oBeb.Commands._fZAk5.Enabled = true
  _1u0iC.Active = true
  _1u0iC.Visible = true
end
function _ZCC:OnExit()
  _POE3 = _g6vX("\027277")
  _Urwigo.GlobalZoneExit()
end
function _L09Q:OnEnter()
  _POE3 = _g6vX("\027O=.\028")
  _HCA.Active = false
  _HCA.Visible = false
  _2k6.Visible = true
  _Urwigo.OldDialog({
    {
      Text = _g6vX("t!\\\\ZK\0226]YI]6\026Kd!EK\001!\030\030K1J8KXw]6KI1J8Knw\030>"),
      Media = _gYWu
    },
    {
      Text = _g6vX("(]1\030KTJ8d]6nKE1]8nK!\017]6Ko!\030WKEJ8Z]\030KY1no]\030ZYY]\030K!wE KTZ\\\\K1J8K]EKI16K%1]\\\\]1J8nKd1]I]6KZ6I]\030n\\1J8KEJ8!6XKEJ8\\]1X]\030>")
    },
    {
      Text = _g6vX("(!EKE1]8nK!\017]6K\030!J8K%1]\\Kr6\017]1nK!wE K(!KYwEEK1J8KI16K\\]1I]6K:KRZ\\IEnw]J\001]K\017]6]J8\030]\030 K\006\004\015e(!Xw]6K1EnKI!EKTJ8d]6nKI!\030\030K!\017]6KEZKEJ8!6X\026KI!EEKIwKI!Y1nK\\ZJ\001]6K]1\030]\030K(6!J8]\030KnZ]n]\030K\001Z]\030\030n]En Kt!8!8!8!\016\016\016Kr\017]6KEZK%]66w]J\001nK\0171EnKIwK@!K\017]En1YYnK\0301J8n\026KZI]6>K")
    }
  })
  _KMNC.Commands._TYuKQ.Enabled = true
  _lj3a.Active = true
  _lj3a.Visible = true
end
function _L09Q:OnExit()
  _POE3 = _g6vX("\027O=.\028")
  _Urwigo.GlobalZoneExit()
end
function _oBeb:On_hJ_X(target)
  _u866M.Active = false
  _u866M.Visible = false
  _oBeb.Commands._hJ_X.Enabled = false
  __hxpH.Visible = false
  _L09Q.Visible = true
  _L09Q.Active = true
  _UZ3n.Active = false
  _Urwigo.MessageBox({
    Text = _g6vX("\014!J8K\001w6W]6K\004]dwEEn\\ZE1o\001]1nKd!J8EnKIwK!YK,!\\I6!\030IK!wXKw\030IKI]6K(6!J8]K1EnK%]6EJ8dw\030I]\030 K\006\004\015e(]1\030KTJ8d]6nK1EnK\\]1I]6KWwKEnwY\021XKw\030IK\001Z\030\030n]KI]YK(6!J8]\030K\0301J8nEK!\0308!\017]\030 K\006\004\015eR]8]KWw6KTJ8Y1]I]Kw\030IK\\!EE]KI]1\030KTJ8d]6nK%ZYKTJ8Y1]IKEJ8!]6X]\030\016"),
    Callback = function(action)
      if action ~= nil then
        _HCA.Active = true
        _HCA.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _oBeb:On_fZAk5(target)
  _1u0iC.Active = false
  _1u0iC.Visible = false
  _oBeb.Commands._fZAk5.Enabled = false
  _ZCC.Active = false
  _UZ3n.Active = true
  _oBeb:MoveTo(nil)
  _22N:MoveTo(Player)
  _oBeb.Visible = false
  _22N.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _g6vX(",Zd\026KJZZ\\\016\016\016\006\004\015e9]nWnK8!\017]K1J8K]1\030K]1o]\030]EKTJ8d]6n\016\006\004\015e,1]K%]6E\0216ZJ8]\030K%]66!n]K1J8KI16K@]nWnKE]1\030]KTJ8d!J8En]\\\\] "),
      Media = _YPNN0
    },
    {
      Text = _g6vX("(]6K(6!J8]KY!oKnZn!\\Ko]6\030]Kr]\021X]\\ K(!Xw]6KY!J8nK]6K]1\030X!J8K!\\\\]E K\029J8Ko]\017]KI16KWwYK(!\030\001KI!Xw]6\026KI!EEKIwKY16KI]1\030KTJ8d]6nKo]o]\017]\030K8!EnK]1\030]\030KpZ6\017K%Z\\\\]6Kr]\021X]\\KY1nKI]\030]\030KIwKI]\030K(6!J8]\030KXw]nn]6\030K\001!\030\030En "),
      Media = _YPNN0
    },
    {
      Text = _g6vX("t1]6K\0171nn]EJ8Z]\030\026KI1]Kr]\021X]\\ \006\004\015e\029J8Kdw]\030EJ8]KI16K%1]\\KR\\w]J\001K\017]1KI]1\030]6KTwJ8]K\030!J8KI]YKTJ8!nW \006\004\015e?\030IKI]\030\001KI6!\030\026Kd]\030\030KIwK\001]1\030KTJ8d]6nKI!\017]1K8!EnKw\030IK18YKI1]Kr]\021X]\\Ko1\017EnK1EnKI]6K(6!J8]K]1o]\030n\\1J8Ko!\030WK\030]nn   "),
      Media = _YPNN0
    },
    {
      Text = _g6vX("(wKo]8EnKd1]I]6KWwYK(6!J8]\030d!\\IKwYKWwYKWd]1n]\030KL!\\K!\030KI1]E]YK#!oKI]1\030KR\\w]J\001K\017]1KI]YK(6!J8]\030KWwK%]6EwJ8]\030 ")
    }
  }, function(action)
    _QpaHP.Active = true
    _QpaHP.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _KMNC:On_TYuKQ(target)
  _lj3a.Active = false
  _lj3a.Visible = false
  _KMNC.Commands._TYuKQ.Enabled = false
  _KMNC:MoveTo(nil)
  _Urwigo.Dialog(false, {
    {
      Text = _g6vX("\0021]\\]\030K(!\030\001KXw]6KI]\030KrwXn6!o\026KI!Kd]6I]K1J8KY1J8Ko\\]1J8KY!\\K!\030KI1]Kr6\017]1nKY!J8]\030 "),
      Media = _gYWu
    },
    {
      Text = _g6vX("TZ\026K\0171nn]EJ8Z]\030 \006\004\015er\017]6KEJ8Z]\030K%Z6E1J8n1oKI!Y1n   K@]nWnKEJ8\030]1I]nK]EKIw6J8Kt!wnKw\030IKp\030ZJ8]\030Kd1]K]1\030Kd!6Y]EKL]EE]6KIw6J8KI1]K\004wnn]6 \006\004\015eTJ8Z]\030]\030K#!oK\030ZJ8 ")
    },
    {
      Text = _g6vX("(!KIwKE]86K8w\030o61oK\0171EnKo]8EnKIwK]6EnY!\\KWw6K#!%]6\030]KwYKI1J8KWwKEn!]6\001]\030K\017]%Z6KIwK]EK\030ZJ8Y!\\KY1nKI]YK(6!J8]\030K!wX\0301YYEn K\0021]\\\\]1J8nK\\!]EEnKI1J8KI]6K,16nK!\030EJ86]1\017]\030Kd]\030\030KIwK18YK]6W!]8\\EnKI!EEKI16KEJ8Z\030K\017!\\IKI]6K(6!J8]\030EJ8!nWKo]8Z]6]\030Kd16I ")
    }
  }, function(action)
    _2k6.Visible = false
    _NUCZ.Active = true
    _NUCZ.Visible = true
    _L09Q.Active = false
    _ZCC.Visible = true
    _ZCC.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _22N:On_06fn(target)
  _ep8.Active = false
  _ep8.Visible = false
  _22N.Commands._06fn.Enabled = false
  _22N:MoveTo(nil)
  _UZ3n.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _g6vX("\004wwwww!!!888\016\016\016\016\006\004\015e\029J8Kd1\\\\KI16KX6]EE]]]]]]]\030\016\016\016"),
      Media = _kEc
    },
    {
      Text = _g6vX(",!6K\030w6K]1\030K\001\\]1\030]6KT\021!EE\026KTZ66_ \006\004\015e,!6EnKIwK\0301J8nK%Z681\030KEJ8Z\030Y!\\K81]6>KL1nK]1\030]YKTJ8d]6n\016\006\004\015e\029J8KY!oK\001]1\030]KTJ8d]6n]6\016\006\004\015e\006\004\015e\029EnK@!K!wJ8K]o!\\   K@]nWnK8!EnKIwK@!Kr]\021X]\\KI!\017]1 K\006\004\015e\029J8KY!oKr]\021X]\\ \006\004\015e(!\030\001]EJ8Z]\030 "),
      Media = _kEc
    },
    {
      Text = _g6vX("(wK\0171EnK\017]En1YYnK!wJ8Kd]o]\030KI]YK(6!J8]\030EJ8!nWK!wEKI]6KO]o]\030I]K81]6 KR]\030!wKd1]K!\\\\KI1]K!\030I]6]\030K\0151nn]6KI1]KY1nK\\]]6]\030Kt!]\030I]\030Kd1]I]6K!\017o]WZo]\030KE1\030I \006\004\015e\006\004\015e(16K!\017]6Kd]6I]K1J8KI!EKTJ8!nW%]6En]J\001K%]66!n]\030Kd]1\\KIwKEn!nnKY1nK]1\030]YKo]EJ8!]6Xn]\030KTJ8d]6nKY1nKr]\021X]\\\030KWwKY16KWw6w]J\001Ko]\001ZYY]\030K\0171En K"),
      Media = _kEc
    },
    {
      Text = _g6vX("R]8]K\0151J8nw\030oK,]En]\030K]\030n\\!\030oKI]EK\022]\\Id]o]EK\0171EKIwKWwK]1\030]6K\004!wYo6w\021\021]K\001ZYYEn K(Z6nKX1\030I]EnKIwKI!EKTJ8!nW%]6En]J\001 K\006\004\015e\006\004\015er\017]6K]6d!6n]KI16K\0301J8nKWwK%1]\\ K\006\004\015e\029J8KYwEEn]KEJ8\\1]EE\\1J8K@!868w\030I]6n]\\!\030oKI!%Z\030K\\]\017]\030 K(wKd]1EEnKEJ8Z\030   KTn6ZY6]J8\030w\030o]\030\026K0EE]\030\026KLw]\\\\!\017Xw86KwEd "),
      Media = _kEc
    }
  }, function(action)
    _KgW.Visible = true
    _KgW.Active = true
    _Tijwg.Active = true
    _Tijwg.Visible = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _Urwigo.GlobalZoneExit()
  _kLqD:RequestSync()
end
return _kLqD
