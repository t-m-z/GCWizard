require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _EEt_(str)
  local res = ""
  local dtable = "\023b,P3:\t\029kYM\004W\003\014\021\005o#\018V\017\019e\r\002\028\000CIn2$1@\a^]sd%}mZ4uy0\016f>K\030Ug?+`X9|S\027\024wFBL(\\!\020GDjvE\022iz\015=N<_l\026JQ~*\025HO/qt\001\006;6\"\b'-A[.\vh\f&r{)85pac\031R\n7 xT"
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
cartDiegrueneZitadellevonMagdeburg = Wherigo.ZCartridge()
zmediaPling = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediaPling.Id = "a3e74201-8a91-47b7-942f-e056213e28f4"
zmediaPling.Name = _EEt_("BqO\024(\024\031'q\024Oxn")
zmediaPling.Description = ""
zmediaPling.AltText = _EEt_("\030xn}\002O\031}BqO\024(\024\031'q\024Oxn}].\031(\024qaAw''\024q")
zmediaPling.Resources = {
  {
    Type = "jpg",
    Filename = "F-Hundertw.jpg",
    Directives = {}
  }
}
zmediazitadelle = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediazitadelle.Id = "d6c85f7d-ca4e-4613-bdf9-4114f20e328b"
zmediazitadelle.Name = _EEt_("POaw(\024VV\024")
zmediazitadelle.Description = ""
zmediazitadelle.AltText = _EEt_("JO\024}7q.\024\031\024},Oaw(\024VV\024")
zmediazitadelle.Resources = {
  {
    Type = "JPG",
    Filename = "zita.JPG",
    Directives = {}
  }
}
zmediabrunnen = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediabrunnen.Id = "bc7b81b8-fa53-44bb-bc84-832c3a82a1fa"
zmediabrunnen.Name = _EEt_("\002q.\031\031\024\031")
zmediabrunnen.Description = ""
zmediabrunnen.AltText = ""
zmediabrunnen.Resources = {
  {
    Type = "jpg",
    Filename = "Faunenbrunnen.jpg",
    Directives = {}
  }
}
zmediakloster = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediakloster.Id = "20028e4d-6acc-4a66-9c53-2b68739dc6ae"
zmediakloster.Name = _EEt_("\tV\018'a\024q")
zmediakloster.Description = ""
zmediakloster.AltText = ""
zmediakloster.Resources = {
  {
    Type = "jpg",
    Filename = "kloster-kl.jpg",
    Directives = {}
  }
}
zmedialandtag = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmedialandtag.Id = "d26ab897-90ce-496d-8184-fad18bb7305a"
zmedialandtag.Name = _EEt_("Vw\031(aw7")
zmedialandtag.Description = ""
zmedialandtag.AltText = ""
zmedialandtag.Resources = {
  {
    Type = "jpg",
    Filename = "landtag-kl.jpg",
    Directives = {}
  }
}
zmediaschimpa = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediaschimpa.Id = "98dadb0e-4354-499c-bd57-aa0b5e45f049"
zmediaschimpa.Name = _EEt_("'aw(a2.\024n")
zmediaschimpa.Description = ""
zmediaschimpa.AltText = ""
zmediaschimpa.Resources = {
  {
    Type = "JPG",
    Filename = "butler2.JPG",
    Directives = {}
  }
}
zmedianichtmd = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmedianichtmd.Id = "81f2d896-dda7-45a5-88dd-8082e75e8fec"
zmedianichtmd.Name = _EEt_("\031Oxna+(")
zmedianichtmd.Description = ""
zmedianichtmd.AltText = ""
zmedianichtmd.Resources = {
  {
    Type = "JPG",
    Filename = "nichtmd.JPG",
    Directives = {}
  }
}
zmediatuer = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediatuer.Id = "908c3c10-27ec-4f09-bec3-9971ea7f4a8b"
zmediatuer.Name = _EEt_("a.\024q")
zmediatuer.Description = ""
zmediatuer.AltText = ""
zmediatuer.Resources = {
  {
    Type = "JPG",
    Filename = "landtuer.JPG",
    Directives = {}
  }
}
zmediafaun = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
zmediafaun.Id = "0a6f065f-6919-46ac-991c-aaebe536e8e9"
zmediafaun.Name = _EEt_("2w.\031")
zmediafaun.Description = ""
zmediafaun.AltText = ""
zmediafaun.Resources = {
  {
    Type = "JPG",
    Filename = "faun.JPG",
    Directives = {}
  }
}
_VvaT = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_VvaT.Id = "d6a2b0fa-ba00-4961-be41-c915d5147f94"
_VvaT.Name = _EEt_("vOw\031\018")
_VvaT.Description = ""
_VvaT.AltText = ""
_VvaT.Resources = {
  {
    Type = "mp3",
    Filename = "Piano60.mp3",
    Directives = {}
  }
}
_cAm9 = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_cAm9.Id = "8a21f6e7-6a27-44b9-984e-2691ae25784b"
_cAm9.Name = _EEt_("]O\031A\024O'")
_cAm9.Description = ""
_cAm9.AltText = ""
_cAm9.Resources = {
  {
    Type = "mp3",
    Filename = "siehnur1.mp3",
    Directives = {}
  }
}
_BJC = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_BJC.Id = "c49b2bf1-d995-4695-9468-dd9c1da3940d"
_BJC.Name = _EEt_("\127q\018\024a")
_BJC.Description = ""
_BJC.AltText = ""
_BJC.Resources = {
  {
    Type = "mp3",
    Filename = "troet.mp3",
    Directives = {}
  }
}
_Habf = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_Habf.Id = "7e97ec0c-e776-4717-b9ed-0afcb32a6eff"
_Habf.Name = _EEt_(",\030i\030]")
_Habf.Description = ""
_Habf.AltText = ""
_Habf.Resources = {
  {
    Type = "jpg",
    Filename = "Zitadelle-ih.jpg",
    Directives = {}
  }
}
_BsczY = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_BsczY.Id = "1cb99626-1b79-46dd-8dcc-3a567c193aab"
_BsczY.Name = _EEt_(",\030iI>")
_BsczY.Description = ""
_BsczY.AltText = ""
_BsczY.Resources = {
  {
    Type = "jpg",
    Filename = "Zitadelle-gs.jpg",
    Directives = {}
  }
}
_essm = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_essm.Id = "960d3eb9-8dc5-44df-ad92-37fab081f2c0"
_essm.Name = _EEt_("Iwq+O\031O\0312\018")
_essm.Description = ""
_essm.AltText = ""
_essm.Resources = {
  {
    Type = "fdl",
    Filename = "04.fdl",
    Directives = {}
  }
}
_dp49 = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_dp49.Id = "fb731606-4aeb-401a-8237-03bf833fe248"
_dp49.Name = _EEt_("]\0182 ")
_dp49.Description = ""
_dp49.AltText = ""
_dp49.Resources = {
  {
    Type = "jpg",
    Filename = "ZI-IH2.jpg",
    Directives = {}
  }
}
_OPFH = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_OPFH.Id = "1497167f-144d-454b-889a-c6b986c119b7"
_OPFH.Name = _EEt_(">awqa")
_OPFH.Description = ""
_OPFH.AltText = ""
_OPFH.Resources = {
  {
    Type = "jpg",
    Filename = "zita-start.jpg",
    Directives = {}
  }
}
_oW7c = Wherigo.ZMedia(cartDiegrueneZitadellevonMagdeburg)
_oW7c.Id = "eac9f19c-2350-406e-9830-4b3b1bff55fc"
_oW7c.Name = _EEt_(",Oawiw.''\024\031")
_oW7c.Description = ""
_oW7c.AltText = ""
_oW7c.Resources = {
  {
    Type = "jpg",
    Filename = "zitadelle_aussen.jpg",
    Directives = {}
  }
}
cartDiegrueneZitadellevonMagdeburg.Id = "edbbc56b-10d7-488d-bc91-bd712a7ac599"
cartDiegrueneZitadellevonMagdeburg.Name = "Die gruene Zitadelle von Magdeburg"
cartDiegrueneZitadellevonMagdeburg.Description = "Ein Spaziergang an, in und bei der \"Gruenen Zitadelle von Magdeburg\", dem letzten Werk von Friedensreich Hundertwasser."
cartDiegrueneZitadellevonMagdeburg.Visible = true
cartDiegrueneZitadellevonMagdeburg.Activity = "Geocache"
cartDiegrueneZitadellevonMagdeburg.StartingLocationDescription = "Heute gehts rund um die \"Gruene Zitadelle von Magdeburg\""
cartDiegrueneZitadellevonMagdeburg.StartingLocation = ZonePoint(52.12675, 11.63365, 0)
cartDiegrueneZitadellevonMagdeburg.Version = "1.8"
cartDiegrueneZitadellevonMagdeburg.Company = "GC-Anhalt"
cartDiegrueneZitadellevonMagdeburg.Author = "Dirk, der ottoknopf"
cartDiegrueneZitadellevonMagdeburg.BuilderVersion = "URWIGO 1.22.5798.37755"
cartDiegrueneZitadellevonMagdeburg.CreateDate = "05/24/2010 21:48:58"
cartDiegrueneZitadellevonMagdeburg.PublishDate = "1/1/0001 12:00:00 AM"
cartDiegrueneZitadellevonMagdeburg.UpdateDate = "03/12/2019 18:07:43"
cartDiegrueneZitadellevonMagdeburg.LastPlayedDate = "1/1/0001 12:00:00 AM"
cartDiegrueneZitadellevonMagdeburg.TargetDevice = "PocketPC"
cartDiegrueneZitadellevonMagdeburg.TargetDeviceVersion = "0"
cartDiegrueneZitadellevonMagdeburg.StateId = "1"
cartDiegrueneZitadellevonMagdeburg.CountryId = "2"
cartDiegrueneZitadellevonMagdeburg.Complete = false
cartDiegrueneZitadellevonMagdeburg.UseLogging = true
cartDiegrueneZitadellevonMagdeburg.Media = zmediazitadelle
cartDiegrueneZitadellevonMagdeburg.Icon = zmediazitadelle
zoneStartpunkt = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneStartpunkt.Id = "1e7ee2d9-eb09-4e54-ac5c-fa933b95bdbb"
zoneStartpunkt.Name = _EEt_(">awqav.\031\ta")
zoneStartpunkt.Description = _EEt_("]O\024q}\002\0247O\031\031a}wVV\024'l")
zoneStartpunkt.Visible = true
zoneStartpunkt.Media = _OPFH
zoneStartpunkt.Icon = zmediazitadelle
zoneStartpunkt.Commands = {}
zoneStartpunkt.DistanceRange = Distance(1500, "feet")
zoneStartpunkt.ShowObjects = "OnEnter"
zoneStartpunkt.ProximityRange = Distance(200, "feet")
zoneStartpunkt.AllowSetPositionTo = false
zoneStartpunkt.Active = true
zoneStartpunkt.Points = {
  ZonePoint(52.12683, 11.63352, 0),
  ZonePoint(52.12683, 11.63378, 0),
  ZonePoint(52.12667, 11.63378, 0),
  ZonePoint(52.12667, 11.63352, 0)
}
zoneStartpunkt.OriginalPoint = ZonePoint(52.126753, 11.633653, 0)
zoneStartpunkt.DistanceRangeUOM = "Feet"
zoneStartpunkt.ProximityRangeUOM = "Feet"
zoneStartpunkt.OutOfRangeName = ""
zoneStartpunkt.InRangeName = ""
zoneGrundstein = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneGrundstein.Id = "3de0cb8f-fed5-4054-82a3-802b5923670f"
zoneGrundstein.Name = _EEt_("Iq.\031('a\024O\031")
zoneGrundstein.Description = _EEt_(">.xn\024}(\024\031}Iq.\031('a\024O\031}(\024q}7q.\024\031\024\031},Oaw(\024VV\024")
zoneGrundstein.Visible = false
zoneGrundstein.Media = _BsczY
zoneGrundstein.Icon = zmediazitadelle
zoneGrundstein.Commands = {}
zoneGrundstein.DistanceRange = Distance(1500, "feet")
zoneGrundstein.ShowObjects = "OnEnter"
zoneGrundstein.ProximityRange = Distance(200, "feet")
zoneGrundstein.AllowSetPositionTo = false
zoneGrundstein.Active = false
zoneGrundstein.Points = {
  ZonePoint(52.1276378449544, 11.6341760380796, 0),
  ZonePoint(52.127401069256, 11.6350991420578, 0),
  ZonePoint(52.1264576526032, 11.6345017739228, 0),
  ZonePoint(52.1271015845196, 11.6337468214886, 0)
}
zoneGrundstein.OriginalPoint = ZonePoint(52.126809, 11.634229, 0)
zoneGrundstein.DistanceRangeUOM = "Feet"
zoneGrundstein.ProximityRangeUOM = "Feet"
zoneGrundstein.OutOfRangeName = ""
zoneGrundstein.InRangeName = ""
zoneInnenhof = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneInnenhof.Id = "1092fc34-566a-4804-a084-6ff2cb7e6095"
zoneInnenhof.Name = _EEt_("\030\031\031\024\031n\0182")
zoneInnenhof.Description = _EEt_("]O\024q}\tw\031\031}+w\031}'Oxn}.+'\024n\024\031lll")
zoneInnenhof.Visible = false
zoneInnenhof.Media = _dp49
zoneInnenhof.Icon = zmediazitadelle
zoneInnenhof.Commands = {}
zoneInnenhof.DistanceRange = Distance(1500, "feet")
zoneInnenhof.ShowObjects = "OnEnter"
zoneInnenhof.ProximityRange = Distance(200, "feet")
zoneInnenhof.AllowSetPositionTo = false
zoneInnenhof.Active = false
zoneInnenhof.Points = {
  ZonePoint(52.1278086105543, 11.6342516051428, 0),
  ZonePoint(52.1275763611898, 11.6353569104084, 0),
  ZonePoint(52.126806899242, 11.6347741575464, 0),
  ZonePoint(52.1271322781407, 11.6337681313808, 0)
}
zoneInnenhof.OriginalPoint = ZonePoint(52.127123, 11.634461, 0)
zoneInnenhof.DistanceRangeUOM = "Feet"
zoneInnenhof.ProximityRangeUOM = "Feet"
zoneInnenhof.OutOfRangeName = ""
zoneInnenhof.InRangeName = ""
zoneBrunnen = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneBrunnen.Id = "3d7b031e-fb18-4a3e-b4b4-2ef099641865"
zoneBrunnen.Name = _EEt_("Cq.\031\031\024\031")
zoneBrunnen.Description = _EEt_("J\024q}\127\024.2\024V'\002q.\031\031\024\031}O\031}(\024q}D\024Oa\024q'aqw''\024")
zoneBrunnen.Visible = false
zoneBrunnen.Media = zmediabrunnen
zoneBrunnen.Icon = zmediabrunnen
zoneBrunnen.Commands = {}
zoneBrunnen.DistanceRange = Distance(1500, "feet")
zoneBrunnen.ShowObjects = "OnEnter"
zoneBrunnen.ProximityRange = Distance(200, "feet")
zoneBrunnen.AllowSetPositionTo = false
zoneBrunnen.Active = false
zoneBrunnen.Points = {
  ZonePoint(52.1282260070043, 11.632765329998, 0),
  ZonePoint(52.1281744028217, 11.6330747700615, 0),
  ZonePoint(52.1279941294269, 11.6329486800079, 0),
  ZonePoint(52.12804, 11.6326649249553, 0)
}
zoneBrunnen.OriginalPoint = ZonePoint(52.128091, 11.632848, 0)
zoneBrunnen.DistanceRangeUOM = "Feet"
zoneBrunnen.ProximityRangeUOM = "Feet"
zoneBrunnen.OutOfRangeName = ""
zoneBrunnen.InRangeName = ""
zoneKloster = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneKloster.Id = "edd71173-3874-40f9-ac42-d75ef9b4ab6c"
zoneKloster.Name = _EEt_("4V\018'a\024q")
zoneKloster.Description = _EEt_("j\031}(\024q}'.\024(VOxn\024}>\024Oa\024}(\024'}4V\018'a\024q'")
zoneKloster.Visible = false
zoneKloster.Media = zmediakloster
zoneKloster.Icon = zmediakloster
zoneKloster.Commands = {}
zoneKloster.DistanceRange = Distance(1500, "feet")
zoneKloster.ShowObjects = "OnEnter"
zoneKloster.ProximityRange = Distance(200, "feet")
zoneKloster.AllowSetPositionTo = false
zoneKloster.Active = false
zoneKloster.Points = {
  ZonePoint(52.1269972362845, 11.6369966499901, 0),
  ZonePoint(52.1269556651068, 11.6372047200318, 0),
  ZonePoint(52.1268469263503, 11.637137005003, 0),
  ZonePoint(52.1268913646128, 11.6369406099662, 0)
}
zoneKloster.OriginalPoint = ZonePoint(52.12694, 11.637076, 0)
zoneKloster.DistanceRangeUOM = "Feet"
zoneKloster.ProximityRangeUOM = "Feet"
zoneKloster.OutOfRangeName = ""
zoneKloster.InRangeName = ""
zoneLandtag = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
zoneLandtag.Id = "8716a588-cc95-4361-aee4-0aac94358d22"
zoneLandtag.Name = _EEt_("Dw\031(aw7")
zoneLandtag.Description = _EEt_("Jw'}I\024\002w\024.(\024}(\024'}Dw\031(aw7\024'")
zoneLandtag.Visible = false
zoneLandtag.Media = zmedialandtag
zoneLandtag.Icon = zmedialandtag
zoneLandtag.Commands = {}
zoneLandtag.DistanceRange = Distance(1500, "feet")
zoneLandtag.ShowObjects = "OnEnter"
zoneLandtag.ProximityRange = Distance(200, "feet")
zoneLandtag.AllowSetPositionTo = false
zoneLandtag.Active = false
zoneLandtag.Points = {
  ZonePoint(52.1264343350656, 11.6349549249553, 0),
  ZonePoint(52.1264300345464, 11.6352814200516, 0),
  ZonePoint(52.1262841622355, 11.6352160400238, 0),
  ZonePoint(52.1262913297907, 11.6349992899742, 0)
}
zoneLandtag.OriginalPoint = ZonePoint(52.12639, 11.635113, 0)
zoneLandtag.DistanceRangeUOM = "Feet"
zoneLandtag.ProximityRangeUOM = "Feet"
zoneLandtag.OutOfRangeName = ""
zoneLandtag.InRangeName = ""
_J3eO = Wherigo.Zone(cartDiegrueneZitadellevonMagdeburg)
_J3eO.Id = "d130783b-e2cc-40a4-a698-714040b6b18a"
_J3eO.Name = _EEt_(",Oaw(\024VV\024}j.''\024\031n\0182")
_J3eO.Description = ""
_J3eO.Visible = false
_J3eO.Media = _oW7c
_J3eO.Icon = zmediazitadelle
_J3eO.Commands = {}
_J3eO.DistanceRange = Distance(-1, "feet")
_J3eO.ShowObjects = "OnEnter"
_J3eO.ProximityRange = Distance(60, "meters")
_J3eO.AllowSetPositionTo = false
_J3eO.Active = false
_J3eO.Points = {
  ZonePoint(52.1267454254416, 11.634297906379, 0),
  ZonePoint(52.1265891740689, 11.6347859215865, 0),
  ZonePoint(52.1270220893724, 11.6350777967106, 0),
  ZonePoint(52.127156836986, 11.6347298815627, 0)
}
_J3eO.OriginalPoint = ZonePoint(52.1268783814672, 11.6347228765597, 0)
_J3eO.DistanceRangeUOM = "Feet"
_J3eO.ProximityRangeUOM = "Meters"
_J3eO.OutOfRangeName = ""
_J3eO.InRangeName = ""
zcharacterFriedensreich = Wherigo.ZCharacter(cartDiegrueneZitadellevonMagdeburg)
zcharacterFriedensreich.Id = "40260530-e948-45dd-a41c-6e9562ec10c6"
zcharacterFriedensreich.Name = _EEt_("BqO\024(\024\031'q\024Oxn")
zcharacterFriedensreich.Description = ""
zcharacterFriedensreich.Visible = true
zcharacterFriedensreich.Media = zmediaPling
zcharacterFriedensreich.Icon = zmediaPling
zcharacterFriedensreich.Commands = {}
zcharacterFriedensreich.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterFriedensreich.Gender = "Male"
zcharacterFriedensreich.Type = "NPC"
zitemFriedensreich = Wherigo.ZItem({Cartridge = cartDiegrueneZitadellevonMagdeburg, Container = zoneStartpunkt})
zitemFriedensreich.Id = "38f4716b-f9be-45a5-a54f-49bcb3640343"
zitemFriedensreich.Name = _EEt_("BqO\024(\024\031'q\024Oxn")
zitemFriedensreich.Description = ""
zitemFriedensreich.Visible = true
zitemFriedensreich.Media = zmediaPling
zitemFriedensreich.Icon = zmediaPling
zitemFriedensreich.Commands = {}
zitemFriedensreich.ObjectLocation = ZonePoint(52.1267514558255, 11.6336499966946, 0)
zitemFriedensreich.Locked = false
zitemFriedensreich.Opened = false
_CyAI = Wherigo.ZItem({Cartridge = cartDiegrueneZitadellevonMagdeburg, Container = Player})
_CyAI.Id = "c929e52b-b3e9-4a89-a170-bb86533168a5"
_CyAI.Name = _EEt_("6\031V\018x\tx\018(\024")
_CyAI.Description = _EEt_("\030'a}\031\018xn}\031Oxna}'Oxna\002wqlll")
_CyAI.Visible = true
_CyAI.Commands = {}
_CyAI.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_CyAI.Locked = false
_CyAI.Opened = true
hausnummer = ""
fehlplatz = ""
kugelzahl = ""
stufen = ""
tagdesjahres = 0
toi = ""
Starttelnu = 0
jahreszahl = 0
_S8m = _EEt_("P\018\031\024>awqav.\031\ta")
_EVh_ = _EEt_("Pxnwqwxa\024qBqO\024(\024\031'q\024Oxn")
_ilQE = _EEt_("POa\024+BqO\024(\024\031'q\024Oxn")
_4vG = _EEt_("(.++/")
_snHg = _EEt_("PO\031v.aBqw7\024w+>awqa")
_rWmo = _EEt_("PaO+\024qa\018O")
cartDiegrueneZitadellevonMagdeburg.ZVariables = {
  hausnummer = "",
  fehlplatz = "",
  kugelzahl = "",
  stufen = "",
  tagdesjahres = 0,
  toi = "",
  Starttelnu = 0,
  jahreszahl = 0,
  _S8m = _EEt_("P\018\031\024>awqav.\031\ta"),
  _EVh_ = _EEt_("Pxnwqwxa\024qBqO\024(\024\031'q\024Oxn"),
  _ilQE = _EEt_("POa\024+BqO\024(\024\031'q\024Oxn"),
  _4vG = _EEt_("(.++/"),
  _snHg = _EEt_("PO\031v.aBqw7\024w+>awqa"),
  _rWmo = _EEt_("PaO+\024qa\018O")
}
ztimertoi = Wherigo.ZTimer(cartDiegrueneZitadellevonMagdeburg)
ztimertoi.Id = "443ed705-06c1-4722-8b06-6f7d2b75cbe4"
ztimertoi.Name = _EEt_("aO\00500")
ztimertoi.Description = ""
ztimertoi.Visible = true
ztimertoi.Duration = 300
ztimertoi.Type = "Countdown"
_TbQ1 = Wherigo.ZTimer(cartDiegrueneZitadellevonMagdeburg)
_TbQ1.Id = "21f8c5ea-282e-4b1f-af8a-14b4cca4ff7c"
_TbQ1.Name = _EEt_("aO\" 0")
_TbQ1.Description = ""
_TbQ1.Visible = true
_TbQ1.Duration = 120
_TbQ1.Type = "Countdown"
zinputFrageamStart = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputFrageamStart.Id = "e144e8f3-249a-4d33-830e-f097d72bfd7f"
zinputFrageamStart.Name = _EEt_("Bqw7\024}w+}>awqa")
zinputFrageamStart.Description = _EEt_("]O\024q}'\018VV}\024O\031\024}\127\024V\0242\018\031\031.++\024q}w\0027\024V\024'\024\031}A\024q(\024\031l")
zinputFrageamStart.Visible = true
zinputFrageamStart.Media = zmediazitadelle
zinputFrageamStart.InputType = "Text"
zinputFrageamStart.Text = _EEt_("lll}\031.q}+wV}P.+}j.2Aw\024q+\024\031\006}\127Ovv\024}(O\024}V\024aPa\024\031}(q\024O},O22\024q\031}(\024q}\127\024V\0242\018\031\031.++\024q}(\024q}\024\0317VO'xn'vqwxnO7\024\031}\030\0312\018}\024O\031l")
zinputGrundstein = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputGrundstein.Id = "7f100e78-ac2a-4e6c-98a4-e63846fb9bbc"
zinputGrundstein.Name = _EEt_("Iq.\031('a\024O\031")
zinputGrundstein.Description = _EEt_("\127w7}(\024'}Xwnq\024'")
zinputGrundstein.Visible = true
zinputGrundstein.InputType = "Text"
zinputGrundstein.Text = _EEt_("A\024\031\031}(\024q}\"l\"l 00-}(\024q}\024q'a\024}\127w7}(\024'}Xwnq\024'}Awq\003}A\024Vxn\024q}Awq}(w\031\031}(\024q}\127w7}(\024q}Iq.\031('a\024O\031V\0247.\03178}IO\002}\031.q}(O\024},wnV}\024O\031ll}E,,s}p7ad'xnq\024O\002\024}PlCl}ut}pVad")
zinputKugeln = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputKugeln.Id = "0a72c8b6-6ecc-4035-b7d0-dc49724380c5"
zinputKugeln.Name = _EEt_("4.7\024V\031")
zinputKugeln.Description = _EEt_("j\031PwnV}(\024q}4.7\024V\031}O+}\030\031\031\024\031n\0182")
zinputKugeln.Visible = true
zinputKugeln.Choices = {
  "7",
  "8",
  "11",
  "34"
}
zinputKugeln.InputType = "MultipleChoice"
zinputKugeln.Text = _EEt_("\rO\024LO\024V}7qw.\024}4.7\024V\031}'O\031(}(Oq\024\ta}.\024\002\024q}JOq}w+}I\024Vw\024\031(\024q}888")
zinputToiToi = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputToiToi.Id = "6ee03159-c216-426e-bc2f-d45a8e4417ad"
zinputToiToi.Name = _EEt_("\127\018O\127\018O")
zinputToiToi.Description = _EEt_("S.++\024q}(\024q}\127\018OV\024aa\024}w.2}(\024+}\004Vw\031}(\024'}]w.'\024'l")
zinputToiToi.Visible = true
zinputToiToi.Choices = {
  "25",
  "00",
  "5",
  "14a"
}
zinputToiToi.InputType = "MultipleChoice"
zinputToiToi.Text = _EEt_("J.}Vw\024.2'a}K\024aPa}'xn\018\031}'\024Oa}>a.\031(\024\031}nO\024q}n\024q.+\003}+.''a}J.}LO\024VV\024Oxna}+wV}P.q}\127\018OV\024aa\0248}\r\024Vxn\024}S.++\024q}nwa}'O\024}O+}\004Vw\031}(\024'}]w.'\024'}8")
zinputBrunnen = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputBrunnen.Id = "0d1514d2-59a4-458e-b8fc-eb9c689968c7"
zinputBrunnen.Name = _EEt_("Cq.\031\031\024\031")
zinputBrunnen.Description = _EEt_(",wnV}O+}\rwvv\024\031")
zinputBrunnen.Visible = true
zinputBrunnen.InputType = "Text"
zinputBrunnen.Text = _EEt_("\vOaa\024}(\024q}\031\024.\031P\024n\031n.\031(\024qawxnaPO7\024q}Xwnq\024}A.q(\024}(\024q}Cq.\031\031\024\031}w.27\024'a\024VVa\003}A\024Vxn\024}Xwnq\024'PwnV}w\002\024q}2O\031(\024'a}J.}w+}Cq.\031\031\024\0318}E,,,,s")
zinputLeiter = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputLeiter.Id = "700a4ad7-8026-430e-853c-c85defd62c0f"
zinputLeiter.Name = _EEt_("D\024Oa\024q")
zinputLeiter.Description = _EEt_("D\024Oa\024q'a.2\024\031")
zinputLeiter.Visible = true
zinputLeiter.InputType = "Text"
zinputLeiter.Text = _EEt_("D.'aO7\024}BO7.q\024\031}'O\031(}nO\024q}w+}fBw.\031\024\031\002q.\031\031\024\031f\003}AOq}'O\031(}nO\024q}O\031}(\024q}D\024Oa\024q'aqw''\024}i}AO\024LO\024V}>vq\018''\024\031}nwa}(O\024}D\024Oa\024q}(\024'}Cq.\031\031\024\031'}8}>xnq\024O\002\024}(O\024},wnV}wV'}\r\018qaG")
zinputKloster = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputKloster.Id = "a023705a-7aea-42f2-b734-4a84887930ad"
zinputKloster.Name = _EEt_("4V\018'a\024q")
zinputKloster.Description = _EEt_("2\024nV}w+}\004VwaP")
zinputKloster.Visible = true
zinputKloster.Choices = {
  "Warnschild",
  "Verteilerkasten",
  "Abdeckgitter",
  "Notausgang"
}
zinputKloster.InputType = "MultipleChoice"
zinputKloster.Text = _EEt_("nO\024q}O'a}\024aAw'\003}Aw'}nO\024q}\024O7\024\031aVOxn}\031Oxna}nO\0317\024n\018\024qa8}\rw'}'a\018\024qa}nO\024q8}\021O\024VV\024Oxna}O'a}\024'}w.xn}O\031PAO'xn\024\031}\031Oxna}+\024nq}(wlll")
zinputLandtag = Wherigo.ZInput(cartDiegrueneZitadellevonMagdeburg)
zinputLandtag.Id = "b46f3302-b2c0-432d-a06f-aeb0893abad1"
zinputLandtag.Name = _EEt_("Dw\031(aw7")
zinputLandtag.Description = _EEt_("]w.'\031.++\024q")
zinputLandtag.Visible = true
zinputLandtag.InputType = "Text"
zinputLandtag.Text = _EEt_("J\024q}Dw\031(aw7}L\018\031}>wxn'\024\031ij\031nwVa}nwa}\024O\031\024}]w.'\031.++\024qlll}w((O\024q\024}P.}(O\024'\024q},wnV}\005e}.\031(}'xnq\024O\002\024}(O\024'\024},wnV}wV'}\r\018qa")
function cartDiegrueneZitadellevonMagdeburg:OnStart()
  Wherigo.PlayAudio(_VvaT)
  _Urwigo.MessageBox({
    Text = _EEt_("]wVV\018}7\024\018xwxn\024qG}>xn\018\024\031\003}(w''}J.}n\024.a\024}nO\024q}(O\024'\024\031}\rn\024qO7\018}'vO\024V\024\031}+\018\024xna\024'aG}\rOq}A\024q(\024\031}.\031'}7\024+\024O\031'w+}w.2}(O\024}>v.q\024\031}L\018\031}BqO\024(\024\031'q\024Oxn}].\031(\024qaAw''\024q}\002\0247\024\002\024\031l}Jw\002\024O}A\024q(\024\031}AOq}(O\024},Oaw(\024VV\024}w.xn}\t.qP}L\024qVw''\024\031}.\031(}(O\024}\031w\024n\024q\024}6+7\024\002.\0317}\024q\t.\031(\024\031l}S.\031}wV'\018\003}BqO'xn}w\031'}\r\024q\tlll}"),
    Buttons = {
      _EEt_("\127Ovv")
    },
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _EEt_("B.\024q}\024O\031\024\031}>aw(aq.\031(7w\0317}+Oa}E'\024nqs}LO\024V\024\031}\030\0312\018q+waO\018\031\024\031}p\031\002'vd\024+v2\024nV\024}Oxn}(\024\031}\rn\024qO7\018}f>aw(aq.\031(7w\0317fl}B.\024q}+\024nq}>vO\024V}7O\002a}\024'}(\024\031}fjVa'aw(ai\rn\024qO7\018flll")
        })
      end
    end
  })
end
function cartDiegrueneZitadellevonMagdeburg:OnRestore()
end
function zoneStartpunkt:OnEnter()
  _S8m = _EEt_("P\018\031\024>awqav.\031\ta")
  Wherigo.PlayAudio(_cAm9)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputFrageamStart)
  end)
end
function zoneGrundstein:OnEnter()
  _S8m = _EEt_("P\018\031\024Iq.\031('a\024O\031")
  Wherigo.PlayAudio(_cAm9)
  _Urwigo.MessageBox({
    Text = _EEt_("\rOVV\t\018++\024\031}O\031}+\024O\031\024q},Oaw(\024VV\024G}COaa\024}\002\024wxna\024\003}(w''}nO\024q}O\031\031\024qnwV\002}(\024'}I\024\002w\024.(\024'}(\024q}I\004>}M+v2w\0317}\031Oxna}O++\024q}\018vaO+wV}O'aG"),
    Media = zmediaPling,
    Buttons = {
      _EEt_("V\0187O'xnG")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(zinputGrundstein)
        end)
      end
    end
  })
end
function zoneInnenhof:OnEnter()
  _S8m = _EEt_("P\018\031\024\030\031\031\024\031n\0182")
  Wherigo.PlayAudio(_cAm9)
  _Urwigo.MessageBox({
    Text = _EEt_("\rO\024}Vw\0317\024}+\018\024xna\024'a}J.}JOxn}nO\024q}.+'\024n\024\031\003}\002\024L\018q}(O\024}\031w\024xn'a\024\031}Bqw7\024\031}\t\018++\024\0318"),
    Buttons = {
      _EEt_(" }\vO\031.a\024\031"),
      _EEt_("u}\vO\031.a\024\031")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _TbQ1:Start()
        elseif action == "Button2" then
          ztimertoi:Start()
        end
      end
    end
  })
end
function zoneBrunnen:OnEnter()
  _S8m = _EEt_("P\018\031\024Cq.\031\031\024\031")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputLeiter)
  end)
end
function zoneKloster:OnEnter()
  _S8m = _EEt_("P\018\031\0244V\018'a\024q")
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputKloster)
  end)
end
function zoneLandtag:OnEnter()
  _S8m = _EEt_("P\018\031\024Dw\031(aw7")
  _Urwigo.MessageBox({
    Text = _EEt_("\rOVV'a}J.}\024'}V\024Oxna}\018(\024q}'xnA\024q}nw\002\024\031}8"),
    Media = zmediaPling,
    Buttons = {
      _EEt_("D\024Oxna"),
      _EEt_(">xnA\024q")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputLandtag)
          end)
        else
          Wherigo.Command("Alert")
          _Urwigo.MessageBox({
            Text = _EEt_("Sw}7.al}Jw\031\031}7\024n\024}+wV}q\024O\031}P.+}\0042\018\024qa\031\024q}.\031(}2qw7\024}\031wxn}(\024q}vqOLwa\024\031}]w\031(/\031.++\024q}(\024'}\vO\031O'a\024qvqw\024'O(\024\031a\024\031lll"),
            Media = zmediaPling,
            Buttons = {
              _EEt_("Jw}O'a}7\024qw(\024}\031O\024+w\031(l")
            },
            Callback = function(action)
              if action ~= nil then
                _Urwigo.RunDialogs(function()
                  Wherigo.GetInput(zinputLandtag)
                end)
              end
            end
          })
        end
      end
    end
  })
end
function _J3eO:OnEnter()
  _S8m = _EEt_("UX\005\024^")
  _Urwigo.MessageBox({
    Text = _EEt_("J.}nw'a}\024'}JOq}q\024(VOxn}L\024q(O\024\031aG}I\024n\024}P.+}>awqav.\031\ta}.\031(}'.xn\024}\018\002\024\031}O\031}(\024q}\030\0312\018aw2\024V}\031wxn}(\024q}BO\031wV(\018'\024l}EB.\024q}(O\024}I\024\018xwxn\024q}w.'}fCw(}jVPn\024O+f}\006}Jw}i}A\018}J.}(O\024}\127\024V\0242\018\031\031.++\024q}\024O\031aOvv\024\031}'\018VVa\024'as"),
    Media = zmediaPling,
    Buttons = {
      _EEt_("\002\024\024\031(\024\031}.\031(}'v\024Oxn\024q\031")
    },
    Callback = function(action)
      if action ~= nil and action == "Button1" then
        Wherigo.Command("Alert")
        cartDiegrueneZitadellevonMagdeburg.Complete = true
        _CyAI.Description = string.sub(Player.CompletionCode, 1, 15)
        _J3eO.Visible = false
        _J3eO.Active = false
        cartDiegrueneZitadellevonMagdeburg:RequestSync()
        _Urwigo.MessageBox({
          Text = _EEt_("JO\024}\029wqaqO(7\024}A.q(\024}7\024'v\024Oxn\024qalllllllll}\030+}\030\031L\024\031awq}nw'a}J.}J\024O\031\024\031}6\031V\018x\tx\018(\024}2.\024q}An\024qO7\018lx\018+}EA\024\031\031}J.}(\018qa}(\024\031}>awa.'}(\024q}\029wqaqO(7\024}w\024\031(\024q\031}AOVV'as")
        })
      end
    end
  })
end
function zinputFrageamStart:OnGetInput(input)
  if input == nil then
    input = ""
  end
  Starttelnu = tonumber(input)
  if Starttelnu == 205 then
    _Urwigo.MessageBox({
      Text = _EEt_(">.xn\024}\031.\031}(\024\031}Iq.\031('a\024O\031}(\024q}fIq.\024\031\024\031},Oaw(\024VV\024}L\018\031}\vw7(\024\002.q7fl}\021O\024VV\024Oxna}+.''a}J.}Kw}7wq}\031Oxna}'.xn\024\031\003}'\018\031(\024q\031}A\024O''a\003}A\018}(\024q}Iq.\031('a\024O\031}O'a}8G"),
      Buttons = {
        _EEt_("4\024\031\031}Oxn}G"),
        _EEt_("\030xn}+.''}'.xn\024\031}G")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button2" then
            _Urwigo.MessageBox({
              Text = _EEt_("lll}(w\031\031}7\024n}K\024aPa}'\0182\018qa}'.xn\024\031l}J\024q}>a\024O\031}O'a}O+}'.\024(VOxn\024\031}\030\031\031\024\031n\0182}O\031}4\031O\024n\018\024n\024l"),
              Media = _Habf
            })
          end
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = _EEt_("Jw\031\031}7\024n}'xn\031\024VV}(w}nO\031\003}(w'}Awq}(\018xn}Oq7\024\031(A\018}O+}'.\024(VOxn\024\031}\030\031\031\024\031n\0182\003}'aO++a'8"),
              Media = _BsczY
            })
          end
        end
      end
    })
    zoneStartpunkt.Visible = false
    zoneStartpunkt.Active = false
    zoneGrundstein.Visible = true
    zoneGrundstein.Active = true
  else
    Wherigo.Command("Alert")
    _Urwigo.MessageBox({
      Text = _EEt_("S\024O\031\003}J.}'\018VV'a}(O\024}V\024aPa\024\031}(q\024O},O22\024q\031}(\024q}\127\024V\0242\018\031\031.++\024q}\024O\031aOvv\024\031l}JO\024'\024}\127\024V\0242\018\031\031.++\024q}\002\0247O\031\031a}+Oa}9-<}E0s}t<}lll}MO\031\024\031}\021\024q'.xn}nw'a}J.}\031\018xn\003}\002\024O}\024O\031\024q}\024q\031\024.a\024\031}B\024nV\024O\0317w\002\024}AOq(}J\024O\031\024}M\029i4wqa\024}\024O\031\002\024nwVa\024\031ll}\018(\024q}J.}+.''a}(O\024},\018\031\024}L\024qVw''\024\031}.\031(}\031\018xn+wV'}\031\024.}\002\024aq\024a\024\031l"),
      Media = zmediaPling,
      Buttons = {
        _EEt_("S\024.\024O\0317w\002\024")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputFrageamStart)
          end)
        end
      end
    })
  end
end
function zinputGrundstein:OnGetInput(input)
  if input == nil then
    input = ""
  end
  tagdesjahres = tonumber(input)
  if tagdesjahres == 79 then
    _Urwigo.MessageBox({
      Text = _EEt_("jVV\024}BO\0317\024q}L\018+}w\002Pw\024nV\024\031}(\024q}\127w7\024}\031\018xn}(qw\0318}Jw\031\031}7\024n\024}K\024aPa}O\031}(\024\031}w\031(\024q\024\031}\030\031\031\024\031n\0182l}>xnw.}JOxn}w.2}(\024+}\r\0247\024}(wnO\031}VO\031\t'}.\031(}q\024xna'}.+\003J.}\tw\031\031'a}\030\0312\018q+waO\018\031\024\031}'w++\024V\031lll}I\024n\024}w.xn}P.+}w\031(\024q\024\031}j.'7w\0317}(\024'}]\0182\024'\003}(\018qa}O'a}\024O\031}I\024\002w\024.(\024vVw\031lll"),
      Media = zmediaPling,
      Buttons = {
        _EEt_("K\024vvv")
      },
      Callback = function(action)
        if action ~= nil then
          zoneInnenhof.Active = true
          zoneInnenhof.Visible = true
          zoneGrundstein.Visible = false
          zoneGrundstein.Active = false
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _EEt_("S\024\024\024\024\024\003}(w}nw'a}J.}JOxn}L\024qPw\024nVaG}jV'\018\003}(\024q}\"l\"l}Awq}(\024q}\"l}\127w7\003}(w\031\031}Awq}(\024q} l\"l}(\024q}PA\024Oa\024}\127w7\003}(w\031\031}Awq}(\024q}lll}O'a}(\018xn}7wwwww\031P}\024O\0312wxnl}J.}\tw\031\031'a}w.xn}(O\024}\031\024\002\024\031}JOq}'a\024n\024\031(\024}z\024O'\0247q.vv\024}\002Oaa\024\031\003}(O\024}\127w7\024}+Oa}Onq\024\031}BO\0317\024q\031}(wqP.'a\024VV\024\031lll"),
      Media = zmediaPling,
      Buttons = {
        _EEt_("\031\018xn+wV}\024O\0317\024\002\024\031")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputGrundstein)
          end)
        end
      end
    })
  end
end
function zinputKugeln:OnGetInput(input)
  if input == nil then
    input = ""
  end
  kugelzahl = input
  if Wherigo.NoCaseEquals(kugelzahl, _EEt_("t")) then
    zoneBrunnen.Active = true
    zoneBrunnen.Visible = true
    zoneInnenhof.Visible = false
    zoneInnenhof.Active = false
    _Urwigo.MessageBox({
      Text = _EEt_("]w'a}J.}O+}I\024Vw\024\031(\024q}(O\024}\r\024q\tP\024.7\024}7\024'\024n\024\0318}Jw'}'O\031(}(O\024}\024xna\024\031}I\024qw\024a\024}(\024q}Cw.wq\002\024Oa\024qlll}jxn\003}'O\024n}\031.q\006}Jw}O'a}\024O\031\024}\031\024.\024},\018\031\024}w.27\024aw.xna\003}(O\024'\024}O'a}\024aAw'}fw\002'\024Oa'fl}\r\024\031\031}\t\024O\031}>xn\031\024\024}VO\0247a\003}\tw\031\031'a}J.}w+}C\018(\024\031}\024O\031}fCw\031(f}'\024n\024\031\003}A\024Vxn\024'}JOxn}2.\024nqal"),
      Media = zmediaPling
    })
  else
    _Urwigo.MessageBox({
      Text = _EEt_("JO\024}(Ox\t\024\031}7qw.\024\031}(Oq\024\ta}.\024\002\024q}JOq\003}\031Oxna}(O\024}LO\024V\024\031}w\031(\024q\024\031l"),
      Media = zmediaPling,
      Buttons = {
        _EEt_("M\031a'xn.V(O7.\0317G")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputKugeln)
          end)
        end
      end
    })
  end
end
function zinputToiToi:OnGetInput(input)
  if input == nil then
    input = ""
  end
  toi = input
  if Wherigo.NoCaseEquals(toi, _EEt_("u")) then
    _Urwigo.MessageBox({
      Text = _EEt_("\004qO+wl}6\031(}A\024Oa\024q}7\024na}(O\024}Bqw7\024q\024Ollll"),
      Buttons = {
        _EEt_("A\024\031\031'}(\024\031\031}'\024O\031}+.''lll")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputKugeln)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _EEt_("S\018xn+wV}\002Oaa\024lll"),
      Media = zmediaPling,
      Buttons = {
        _EEt_("S\024.\024}MO\0317w\002\024")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputToiToi)
          end)
        end
      end
    })
  end
end
function zinputBrunnen:OnGetInput(input)
  if input == nil then
    input = ""
  end
  jahreszahl = tonumber(input)
  if jahreszahl == 1976 then
    zoneKloster.Active = true
    zoneKloster.Visible = true
    zoneBrunnen.Visible = false
    zoneBrunnen.Active = false
    _Urwigo.MessageBox({
      Text = _EEt_("Jw'}O'a}nO\024q}wVV\024'}LOOOO\024V}P.}+\018(\024q\031l}Dw''}.\031'}\031.\031}+wV}P.+}4V\018'a\024q}7\024n\024\031\003}(w}O'a}wVV\024'}\031\018xn}w.'}(\024+}\vOaa\024VwVa\024q\003}\018(\024q}(\018xn}\031Oxna}8"),
      Media = zmediaPling
    })
  else
    Wherigo.Command("Alert")
    _Urwigo.MessageBox({
      Text = _EEt_("MO\031'}S\024.\031}>O\024\002\024\031}lll}O'a}(w'}'\018}'xnA\024q}8"),
      Media = zmediafaun,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputBrunnen)
          end)
        end
      end
    })
  end
end
function zinputLeiter:OnGetInput(input)
  if input == nil then
    input = ""
  end
  stufen = input
  if Wherigo.NoCaseEquals(stufen, _EEt_("\031\024.\031")) then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(zinputBrunnen)
    end)
  else
    _Urwigo.MessageBox({
      Text = _EEt_("]wa}(w'}\127\024.2\024Vxn\024\031}\024O\031\024}L\024q(\024x\ta8}S\018xn+wV}\002Oaa\024G"),
      Media = zmediafaun,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputLeiter)
          end)
        end
      end
    })
  end
end
function zinputKloster:OnGetInput(input)
  if input == nil then
    input = ""
  end
  fehlplatz = input
  if Wherigo.NoCaseEquals(fehlplatz, _EEt_("j\002(\024x\t7Oaa\024q")) then
    _Urwigo.MessageBox({
      Text = _EEt_("J.}+.''a}K\024aPa}7w\031P}awv2\024q}'\024O\031l}S.\031}7\024na}\024'}\031wxn}]wVV\024G}J\018qa}O'a}(\024q}Dw\031(aw7}L\018\031}>wxn'\024\031ij\031nwVal}j\024nnnn\003}\018(\024q}Awq}(\024q}O\031}J\024''w.8G}^(\024q}Awq}(O\024}\021\024q\002qw.xn\024qP\024\031aqwV\024}O\031}]wVV\024}.\031(}(\024q}Dw\031(aw7}O\031}C\024qVO\0318}IO\002a}\024'}\031\018xn}'\024xnP\024n\031}C.\031(\024'Vw\024\031(\024q\003}\018(\024q}\031.q}\031\018xn}f^\002\024\031f}f6\031a\024\031f}fDO\031\t'f}.\031(}fz\024xna'f}iii}J6}nw'a}\024'}O\031}(\024q}]w\031(\003}\024\031a'xn\024O(\024}JOxn}K\024aPaG}\r\018}O'a}(w'}v\018VOaO'xn\024},\024\031aq.+}L\018\031}>wxn'\024\031ij\031nwVa8}"),
      Media = zmediaschimpa,
      Buttons = {
        _EEt_("\vw7(\024\002.q7"),
        _EEt_("S\030\029]\127}\vw7(\024\002.q7}E\004q\018LO\031PGs")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = _EEt_("zOxnaO7G}J.}(wq2'a}A\024Oa\024q'vO\024V\024\031G}E6+}\024O\031}]wwq}Aw\024q\024}K\024aPa}(O\024}\029wqaqO(7\024}.\0317\024'v\024Oxn\024qa}\002\024\024\031(\024a}.\031(}7\024V\018\024'xna}A\018q(\024\031Gs}I\024n\024}\031.\031}P.+}I\024\002w\024.(\024}(\024'}Dw\031(aw7\024'}L\018\031}>wxn'\024\031ij\031nwVal"),
              Media = zmediatuer
            })
          else
            _Urwigo.MessageBox({
              Text = _EEt_("MO7\024\031aVOxn}+.\024'Pa\024}(w'}>vO\024V}nO\024q}K\024aPa}\002\024\024\031(\024a}A\024q(\024\031\003}w\002\024q}nO\024q}\024q7\024na}I\031w(\024}L\018q}z\024xnaG"),
              Media = zmedianichtmd
            })
          end
        end
      end
    })
    zoneKloster.Visible = false
    zoneKloster.Active = false
    zoneLandtag.Active = true
    zoneLandtag.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _EEt_("z.\031(\003}L\024qxnq\018+a}llll"),
      Media = zmediaschimpa,
      Buttons = {
        _EEt_("jxn}'\018}G}S\024.\024O\0317w\002\024")
      },
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputKloster)
          end)
        end
      end
    })
  end
end
function zinputLandtag:OnGetInput(input)
  if input == nil then
    input = ""
  end
  hausnummer = input
  if Wherigo.NoCaseEquals(hausnummer, _EEt_("\021O\024q.\031(LO\024qPO7")) then
    _Urwigo.MessageBox({
      Text = _EEt_("J.}nw'a}\024'}7V\024Oxn}7\024'xnw22aG}>O\024n}JOq}(\018xn}\024O\0312wxn}\031\018xn}(O\024},Oaw(\024VV\024}L\018\031}w.''\024\031}w\031}.\031(}7\024n\024}(w\031\031}L\018\031}(\018qa}P.+}BO\031wVG"),
      Media = zmediaPling,
      Buttons = {
        _EEt_(".+'\024n\024\031")
      },
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          zoneLandtag.Visible = false
          zoneLandtag.Active = false
          _J3eO.Active = true
          _J3eO.Visible = true
          _Urwigo.MessageBox({
            Text = _EEt_("S.\031}L\024q'a\024n'a}J.}\002\024'aO++a}w.xn\003}Awq.+}+\024O\031}V\024aPa\024'}\r\024q\t}i}7q.\024\031\024},Oaw(\024VV\024}i}n\024O'Pal}D\024O(\024q}\t\018\031\031a\024}Oxn}+\024O\031\024},Oaw(\024VV\024}\031Oxna}+\024nq}\024qV\024\002\024\031\003}\002O\031}+Oq}w\002\024q}'Oxn\024q\003}(w''}'O\024}(\024\031}\v\024\031'xn\024\031}7\0242w\024VVal"),
            Media = zmediaPling
          })
        end
      end
    })
  else
    Wherigo.Command("Alert")
    _Urwigo.MessageBox({
      Text = _EEt_("jV'\018\003}Dwa\024O\031}O'a}\031Oxna}J\024O\031\024}>aw\024q\t\024G}^(\024q}AO\024}n\024O'Pa}(w'\003}A\018}+w\031}w((O\024q\024\031}+.'P8"),
      Media = zmediaschimpa,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(zinputLandtag)
          end)
        end
      end
    })
  end
end
function ztimertoi:OnStart()
  _Urwigo.MessageBox({
    Text = _EEt_(">O\024n}JOxn}\031.\031}O\031}z.n\024}.+\003}(O\024}\031w\024xn'a\024}Bqw7\024}'a\024VV\024}Oxn}JOq}O\031}2.\024\0312}\vO\031.a\024\031l}MO\031}\127\018\031'O7\031wV}\024qa\018\024\031a}\031wxn}j\002Vw.2}(\024q},\024Oalll}J.}AOq'a}\024q'aw.\031a}'\024O\031\003}AO\024}Vw\0317\024}2.\024\0312}\vO\031.a\024\031}'\024O\031}\t\018\024\031\031\024\031G"),
    Media = zmediaPling,
    Buttons = {
      _EEt_("L\024q'aw\031(\024\031")
    }
  })
end
function ztimertoi:OnTick()
  Wherigo.PlayAudio(_BJC)
  Wherigo.PlayAudio(_essm)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputToiToi)
  end)
end
function _TbQ1:OnStart()
  _Urwigo.MessageBox({
    Text = _EEt_(">O\024n}JOxn}\031.\031}O\031}z.n\024}.+\003}(O\024}\031w\024xn'a\024}Bqw7\024}'a\024VV\024}Oxn}JOq}O\031}PA\024O}\vO\031.a\024\031l}MO\031}\127\018\031'O7\031wV}\024qa\018\024\031a}\031wxn}j\002Vw.2}(\024q},\024Oalll}J.}AOq'a}\024q'aw.\031a}'\024O\031\003}AO\024}Vw\0317\024}\" 0}>\024\t.\031(\024\031}'\024O\031}\t\018\024\031\031\024\031G"),
    Media = zmediaPling,
    Buttons = {
      _EEt_("L\024q'aw\031(\024\031")
    }
  })
end
function _TbQ1:OnTick()
  Wherigo.PlayAudio(_BJC)
  Wherigo.PlayAudio(_essm)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputToiToi)
  end)
end
cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs = {}
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB2(action)
  if action == "Button2" then
    Wherigo.MessageBox({
      Text = "... dann geh jetzt sofort suchen. Der Stein ist in Kniehoehe.",
      Media = zmediaPling
    })
  end
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = "Dann geh schnell da hin",
      Media = zmediaPling
    })
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB8(action)
  if action == "Button1" then
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB6(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = "Richtig! Du darfst weiterspielen! (Um ein Haar waere jetzt die Cartridge ungespeichert beendet und geloescht worden!) Gehe nun zum Gebaeude des Landtages von Sachsen-Anhalt.",
      Media = zmediatuer
    })
  else
    Wherigo.MessageBox({
      Text = "Eigentlich mueszte das Spiel hier jetzt beendet werden, aber hier ergeht Gnade vor Recht!",
      Media = zmedianichtmd
    })
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB9(action)
  if action ~= nil then
    Wherigo.GetInput(zinputToiToi)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB10(action)
  if action ~= nil then
    Wherigo.GetInput(zinputFrageamStart)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB11(action)
  if action ~= nil then
    Wherigo.GetInput(zinputGrundstein)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB12(action)
  if action ~= nil then
    Wherigo.GetInput(zinputKugeln)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB13(action)
  if action ~= nil then
    Wherigo.GetInput(zinputKloster)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB14(action)
  if action ~= nil then
    Wherigo.GetInput(zinputLandtag)
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB7(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputLandtag)
  else
    Wherigo.Command("Alert")
    Wherigo.MessageBox({
      Text = "Na gut. Dann gehe mal rein zum Pfoertner und frage nach der privaten Handynummer des Ministerpraesidenten...",
      Media = zmediaPling,
      Buttons = {
        "Da ist gerade niemand."
      },
      Callback = cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB14
    })
  end
end
function cartDiegrueneZitadellevonMagdeburg.MsgBoxCBFuncs.MsgBoxCB5(action)
  if action == "Button1" then
    Wherigo.Command("Alert")
    cartDiegrueneZitadellevonMagdeburg.Complete = true
    cartDiegrueneZitadellevonMagdeburg:RequestSync()
    zoneLandtag.Visible = false
    Wherigo.MessageBox({
      Text = "Die Cartridge wurde gespeichert........."
    })
  end
end
return cartDiegrueneZitadellevonMagdeburg
