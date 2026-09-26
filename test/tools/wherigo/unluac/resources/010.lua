require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
objDusseldorp = Wherigo.ZCartridge()
function _HMdUi(str)
  local res = ""
  local dtable = "\023CHP5h\003emI\vz\"#7?6\f3%Gf\rg\028-BdT+{\027^=Ya;r\022>S\b\002\006|Zb\016,utk!cVUNOQiw\031M \029\n<]KX4nv\\\t@`\a&\004$y091\019}('\020s.\021[\005AW\024\015L\001\026l/\018j~\030oE\017q\025\000RFp*D8)2:\014x_J"
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
objRadschlaegerbrunnen = Wherigo.ZMedia(objDusseldorp)
objRadschlaegerbrunnen.Id = "66775ac7-61c9-4d73-8b11-6ec8e3b1b6f4"
objRadschlaegerbrunnen.Name = _HMdUi("s$\028[6\006g$\b\024\b&/&2HH\bH")
objRadschlaegerbrunnen.Description = ""
objRadschlaegerbrunnen.AltText = ""
objRadschlaegerbrunnen.Resources = {
  {
    Type = "jpg",
    Filename = "Radschlaegerbrunnen.jpg",
    Directives = {}
  }
}
objSchlossturm = Wherigo.ZMedia(objDusseldorp)
objSchlossturm.Id = "9d945d61-2238-487d-a628-fafad32cd199"
objSchlossturm.Name = _HMdUi(")6\006gm[[32&\t")
objSchlossturm.Description = ""
objSchlossturm.AltText = ""
objSchlossturm.Resources = {
  {
    Type = "jpg",
    Filename = "schlossturm.jpg",
    Directives = {}
  }
}
objOberkasslerBruecke = Wherigo.ZMedia(objDusseldorp)
objOberkasslerBruecke.Id = "6ec8dd61-d438-4c93-b145-eb9a743324f8"
objOberkasslerBruecke.Name = _HMdUi(":/\b&4$[[g\b&@\027&2\b64\b")
objOberkasslerBruecke.Description = ""
objOberkasslerBruecke.AltText = ""
objOberkasslerBruecke.Resources = {
  {
    Type = "jpg",
    Filename = "OberkasslerBruecke.jpg",
    Directives = {}
  }
}
objPfennig = Wherigo.ZMedia(objDusseldorp)
objPfennig.Id = "ed06cef0-c54d-4f5c-83f4-433630d08809"
objPfennig.Name = _HMdUi("\004\022\bHH<\024")
objPfennig.Description = ""
objPfennig.AltText = ""
objPfennig.Resources = {
  {
    Type = "jpg",
    Filename = "Pfennig.jpg",
    Directives = {}
  }
}
objTonhalle = Wherigo.ZMedia(objDusseldorp)
objTonhalle.Id = "79bde796-7ffc-40f5-bbca-72afbd8ebec0"
objTonhalle.Name = _HMdUi("\029mH\006$gg\b")
objTonhalle.Description = ""
objTonhalle.AltText = ""
objTonhalle.Resources = {
  {
    Type = "jpg",
    Filename = "Tonhalle.jpg",
    Directives = {}
  }
}
objBengel = Wherigo.ZMedia(objDusseldorp)
objBengel.Id = "e8d76e74-370f-4148-8f36-bfb7a15ae9ba"
objBengel.Name = _HMdUi("\027\bH\024\bg")
objBengel.Description = ""
objBengel.AltText = ""
objBengel.Resources = {
  {
    Type = "jpg",
    Filename = "Bengel.jpg",
    Directives = {}
  }
}
objRobertSchumann = Wherigo.ZMedia(objDusseldorp)
objRobertSchumann.Id = "d3859d49-9ccd-4202-b8d0-e68caa6ed8ff"
objRobertSchumann.Name = _HMdUi("sm/\b&3@)6\0062\t$HH")
objRobertSchumann.Description = ""
objRobertSchumann.AltText = ""
objRobertSchumann.Resources = {
  {
    Type = "jpg",
    Filename = "Schumann.jpg",
    Directives = {}
  }
}
objJoachimMurat = Wherigo.ZMedia(objDusseldorp)
objJoachimMurat.Id = "d0d9b34e-5252-45e5-8ccc-738395b7a318"
objJoachimMurat.Name = _HMdUi("\127m$6\006<\t@?2&$3")
objJoachimMurat.Description = ""
objJoachimMurat.AltText = ""
objJoachimMurat.Resources = {
  {
    Type = "jpg",
    Filename = "Grossherzog.jpg",
    Directives = {}
  }
}
objJanWellem = Wherigo.ZMedia(objDusseldorp)
objJanWellem.Id = "1ecae9a3-91a5-4c98-837b-802b8bb961f3"
objJanWellem.Name = _HMdUi("\127$H@a\bgg\b\t")
objJanWellem.Description = ""
objJanWellem.AltText = ""
objJanWellem.Resources = {
  {
    Type = "jpg",
    Filename = "JanWellem.jpg",
    Directives = {}
  }
}
objMutterundSohn = Wherigo.ZMedia(objDusseldorp)
objMutterundSohn.Id = "3f504768-c279-4b62-8dd4-38784f5ccea2"
objMutterundSohn.Name = _HMdUi("?233\b&@2H\028@)m\006H")
objMutterundSohn.Description = ""
objMutterundSohn.AltText = ""
objMutterundSohn.Resources = {
  {
    Type = "jpg",
    Filename = "MutterSohn.jpg",
    Directives = {}
  }
}
objFragezeichen = Wherigo.ZMedia(objDusseldorp)
objFragezeichen.Id = "9ffe4f5a-92f4-40bc-9976-34edbb2d0ed6"
objFragezeichen.Name = _HMdUi("t&$\024\b\f\b<6\006\bH")
objFragezeichen.Description = ""
objFragezeichen.AltText = ""
objFragezeichen.Resources = {
  {
    Type = "jpg",
    Filename = "Fragezeichen.jpg",
    Directives = {}
  }
}
objJohannaEy = Wherigo.ZMedia(objDusseldorp)
objJohannaEy.Id = "30ee4cc5-06f3-4ced-beaa-71b1076c9b4c"
objJohannaEy.Name = _HMdUi("\127m\006$HH$@nR")
objJohannaEy.Description = ""
objJohannaEy.AltText = ""
objJohannaEy.Resources = {
  {
    Type = "jpg",
    Filename = "MutterEy.jpg",
    Directives = {}
  }
}
objRadschlaeger = Wherigo.ZMedia(objDusseldorp)
objRadschlaeger.Id = "9472bbcf-6287-4e6d-b685-465e48ce18c2"
objRadschlaeger.Name = _HMdUi("s$\028[6\006g$\b\024\b&")
objRadschlaeger.Description = ""
objRadschlaeger.AltText = ""
objRadschlaeger.Resources = {
  {
    Type = "jpg",
    Filename = "Radschlaeger.jpg",
    Directives = {}
  }
}
objPferdeapfel = Wherigo.ZMedia(objDusseldorp)
objPferdeapfel.Id = "845554af-9289-4af6-9579-911c24492711"
objPferdeapfel.Name = _HMdUi("\004\022\b&\028\b$u\022\bg")
objPferdeapfel.Description = ""
objPferdeapfel.AltText = ""
objPferdeapfel.Resources = {
  {
    Type = "jpg",
    Filename = "Pferdeapfel.jpg",
    Directives = {}
  }
}
objKoeSchild = Wherigo.ZMedia(objDusseldorp)
objKoeSchild.Id = "898ebfc4-6d6a-4715-b4b4-3271e10c854f"
objKoeSchild.Name = _HMdUi("Em\b)6\006<g\028")
objKoeSchild.Description = ""
objKoeSchild.AltText = ""
objKoeSchild.Resources = {
  {
    Type = "jpg",
    Filename = "KoeSchild.jpg",
    Directives = {}
  }
}
objPolaroid = Wherigo.ZMedia(objDusseldorp)
objPolaroid.Id = "b1b7530f-6bcc-41bc-b63a-11a02ead2dca"
objPolaroid.Name = _HMdUi("\004mg$&m<\028")
objPolaroid.Description = ""
objPolaroid.AltText = ""
objPolaroid.Resources = {
  {
    Type = "jpg",
    Filename = "Polaroid.jpg",
    Directives = {}
  }
}
objRohr = Wherigo.ZMedia(objDusseldorp)
objRohr.Id = "273380ed-13b9-4c96-935b-a634017cf252"
objRohr.Name = _HMdUi("sm\006&")
objRohr.Description = ""
objRohr.AltText = ""
objRohr.Resources = {
  {
    Type = "jpg",
    Filename = "Rohr.jpg",
    Directives = {}
  }
}
objKoenig = Wherigo.ZMedia(objDusseldorp)
objKoenig.Id = "3a5beea9-331a-4469-af2a-34e5e485e06e"
objKoenig.Name = _HMdUi("Em\bH<\024")
objKoenig.Description = ""
objKoenig.AltText = ""
objKoenig.Resources = {
  {
    Type = "jpg",
    Filename = "Koenig.jpg",
    Directives = {}
  }
}
objMagie = Wherigo.ZMedia(objDusseldorp)
objMagie.Id = "bd51f123-631e-4af3-ae82-2d46466078a2"
objMagie.Name = _HMdUi("?$\024<\b")
objMagie.Description = ""
objMagie.AltText = ""
objMagie.Resources = {
  {
    Type = "jpg",
    Filename = "Zauber.jpg",
    Directives = {}
  }
}
objName = Wherigo.ZMedia(objDusseldorp)
objName.Id = "8a20e54b-f6c2-472e-b1bd-f42ad2dd7316"
objName.Name = _HMdUi("9$\t\b")
objName.Description = ""
objName.AltText = ""
objName.Resources = {
  {
    Type = "jpg",
    Filename = "AngyKing.jpg",
    Directives = {}
  }
}
objWappen = Wherigo.ZMedia(objDusseldorp)
objWappen.Id = "c9417fa8-2757-4a5f-8c9a-56b501f5270a"
objWappen.Name = _HMdUi("a$uu\bH")
objWappen.Description = ""
objWappen.AltText = ""
objWappen.Resources = {
  {
    Type = "jpg",
    Filename = "Wappen.jpg",
    Directives = {}
  }
}
objSenf = Wherigo.ZMedia(objDusseldorp)
objSenf.Id = "6632baa9-eec9-4fe9-bea1-dcaba8b40075"
objSenf.Name = _HMdUi(")\bH\022")
objSenf.Description = ""
objSenf.AltText = ""
objSenf.Resources = {
  {
    Type = "jpg",
    Filename = "Senf.jpg",
    Directives = {}
  }
}
objMaria = Wherigo.ZMedia(objDusseldorp)
objMaria.Id = "5541ddc0-4aa0-4275-9066-d92ee50ff0a5"
objMaria.Name = _HMdUi("?$&<$")
objMaria.Description = ""
objMaria.AltText = ""
objMaria.Resources = {
  {
    Type = "jpg",
    Filename = "Maria_Medici.jpg",
    Directives = {}
  }
}
objPalaisSpee = Wherigo.ZMedia(objDusseldorp)
objPalaisSpee.Id = "d3e17fbd-8031-436a-8b78-2df8ce24137d"
objPalaisSpee.Name = _HMdUi("\004$g$<[@)u\b\b")
objPalaisSpee.Description = ""
objPalaisSpee.AltText = ""
objPalaisSpee.Resources = {
  {
    Type = "jpg",
    Filename = "PalaisSpee.jpg",
    Directives = {}
  }
}
objWWM = Wherigo.ZMedia(objDusseldorp)
objWWM.Id = "83bc6ddd-fcfa-4819-ac79-8e22eaaf52b8"
objWWM.Name = _HMdUi("aa?")
objWWM.Description = ""
objWWM.AltText = ""
objWWM.Resources = {
  {
    Type = "mp3",
    Filename = "WWM.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "indiana.fdl",
    Directives = {}
  }
}
objRaNa2009 = Wherigo.ZMedia(objDusseldorp)
objRaNa2009.Id = "66b05c03-256c-41cf-aec5-ea819d48904b"
objRaNa2009.Name = _HMdUi("s$9$zSST")
objRaNa2009.Description = ""
objRaNa2009.AltText = ""
objRaNa2009.Resources = {
  {
    Type = "jpg",
    Filename = "RaNa2009.jpg",
    Directives = {}
  }
}
objHurra = Wherigo.ZMedia(objDusseldorp)
objHurra.Id = "6fc94669-4ae5-47e3-a811-9a9f9068fd08"
objHurra.Name = _HMdUi("\0032&&$")
objHurra.Description = ""
objHurra.AltText = ""
objHurra.Resources = {
  {
    Type = "jpg",
    Filename = "Hurra.jpg",
    Directives = {}
  }
}
objBier = Wherigo.ZMedia(objDusseldorp)
objBier.Id = "c801672b-e8c7-47a4-9836-8d8c9c5e09c1"
objBier.Name = _HMdUi("\027<\b&")
objBier.Description = ""
objBier.AltText = ""
objBier.Resources = {
  {
    Type = "jpg",
    Filename = "Altbier.jpg",
    Directives = {}
  }
}
objAltestadt = Wherigo.ZMedia(objDusseldorp)
objAltestadt.Id = "50c9df7e-15d9-4f7d-a7fb-d180cc8f8c5e"
objAltestadt.Name = _HMdUi("`g3\b[3$\0283")
objAltestadt.Description = ""
objAltestadt.AltText = ""
objAltestadt.Resources = {
  {
    Type = "jpg",
    Filename = "altestadt.jpg",
    Directives = {}
  }
}
objKastanien = Wherigo.ZMedia(objDusseldorp)
objKastanien.Id = "b51b53c6-e58e-43c3-9682-4195b3f56f00"
objKastanien.Name = _HMdUi("E$[3$H<\bH")
objKastanien.Description = ""
objKastanien.AltText = ""
objKastanien.Resources = {
  {
    Type = "jpg",
    Filename = "kastanien.jpg",
    Directives = {}
  }
}
objKIT = Wherigo.ZMedia(objDusseldorp)
objKIT.Id = "aec7948e-eb68-4100-ad10-71f64280ba7f"
objKIT.Name = _HMdUi("E\n\029")
objKIT.Description = ""
objKIT.AltText = ""
objKIT.Resources = {
  {
    Type = "jpg",
    Filename = "KIT.jpg",
    Directives = {}
  }
}
objCache = Wherigo.ZMedia(objDusseldorp)
objCache.Id = "a2c20a30-f660-4693-89a5-d11af07f7b9a"
objCache.Name = _HMdUi("\002$6\006\b")
objCache.Description = ""
objCache.AltText = ""
objCache.Resources = {
  {
    Type = "jpg",
    Filename = "geocaching.jpg",
    Directives = {}
  }
}
objDusseldorp.Id = "5ef58ba0-b2ab-4eed-a5cb-e3ebf3f8865c"
objDusseldorp.Name = "Dusseldorp"
objDusseldorp.Description = [[
Der Name "Dusseldorp" findet sich zum ersten Mal in einem Grundstuecksverzeichnis, vermutlich aus dem Jahre 1135. Dieser Cache zeigt ein paar Episoden und Persoenlichkeiten der Duesseldorfer Stadtgeschichte auf. Es ist ein Spaziergang ueber zwei Bruecken und durch die Altstadt. Ihr muesst einige Aufgaben loesen, und es gibt ein (nicht ganz leichtes) Quiz. Ihr findet den Cache aber auch, falls Ihr alle Fragen falsch beantwortet...<BR>
<BR>
Startpunkt ist die linksrheinische Seite der Oberkasseler Bruecke! Der Weg ist ca. 5km lang, &nbsp;wenn ihr in der Altstadt umherirrt, auch mehr. Zwei Stunden sollten genuegen, ausserdem haben wir eine Pause an einem bekannten Brauhaus vorgesehen :-)<BR>
]]
objDusseldorp.Visible = true
objDusseldorp.Activity = "Geocache"
objDusseldorp.StartingLocationDescription = "Oberkasseler Bruecke auf der linken Rheinseite."
objDusseldorp.StartingLocation = ZonePoint(51.2312, 6.7635, 0)
objDusseldorp.Version = "2.4"
objDusseldorp.Company = ""
objDusseldorp.Author = "RaNa2009"
objDusseldorp.BuilderVersion = "URWIGO 1.12.4091.37853"
objDusseldorp.CreateDate = "12/14/2010 09:20:05"
objDusseldorp.PublishDate = "1/1/0001 12:00:00 AM"
objDusseldorp.UpdateDate = "11/28/2011 10:10:33"
objDusseldorp.LastPlayedDate = "1/1/0001 12:00:00 AM"
objDusseldorp.TargetDevice = "PocketPC"
objDusseldorp.TargetDeviceVersion = "0"
objDusseldorp.StateId = "1"
objDusseldorp.CountryId = "2"
objDusseldorp.Complete = false
objDusseldorp.UseLogging = true
objDusseldorp.Media = objSchlossturm
objDusseldorp.Icon = objWappen
zOberkasselerBruecke = Wherigo.Zone(objDusseldorp)
zOberkasselerBruecke.Id = "94aac91b-8b5e-4fd4-a674-b625319335ab"
zOberkasselerBruecke.Name = _HMdUi(":/\b&4$[[\bg\b&@\027&2\b64\b")
zOberkasselerBruecke.Description = _HMdUi("n<H\b@\028\b&@[<\b/\bH@s\006\b<H/&2\b64\bH@w2\b[[\bg\028m&\022[C\027s(C\027s(tg\b\006\b&@\027&2\b64\bC\027s(E$&\028<H$g\026t&<H\024[@\027&2\b64\bC\027s(n<[\bH/$\006H/&2\b64\b@\003$\t\tC\027s(s\006\b<H4H<\b/&2\b64\bC\027s(:/\b&4$[[\bg\b&@\027&2\b64\bC\027s(\029\006\bm\028m&\026\003\b2[[@\027&2\b64\bC\027s(tg2\024\006$\022\bH/&2\b64\b")
zOberkasselerBruecke.Visible = true
zOberkasselerBruecke.Media = objOberkasslerBruecke
zOberkasselerBruecke.Commands = {}
zOberkasselerBruecke.DistanceRange = Distance(-1, "feet")
zOberkasselerBruecke.ShowObjects = "OnEnter"
zOberkasselerBruecke.ProximityRange = Distance(60, "meters")
zOberkasselerBruecke.AllowSetPositionTo = false
zOberkasselerBruecke.Active = true
zOberkasselerBruecke.Points = {
  ZonePoint(51.2317588954546, 6.76705777645111, 0),
  ZonePoint(51.2313961169573, 6.76707923412323, 0),
  ZonePoint(51.2313961169573, 6.76845252513886, 0),
  ZonePoint(51.231765613548, 6.76842033863068, 0)
}
zOberkasselerBruecke.OriginalPoint = ZonePoint(51.2315791857293, 6.76775246858597, 0)
zOberkasselerBruecke.DistanceRangeUOM = "Feet"
zOberkasselerBruecke.ProximityRangeUOM = "Meters"
zOberkasselerBruecke.OutOfRangeName = ""
zOberkasselerBruecke.InRangeName = ""
zRadschlaegerbrunnen = Wherigo.Zone(objDusseldorp)
zRadschlaegerbrunnen.Id = "bdc4b2b3-8d82-4027-a9b0-4a0b9595fed5"
zRadschlaegerbrunnen.Name = _HMdUi("s$\028[6\006g$\b\024\b&/&2HH\bH")
zRadschlaegerbrunnen.Description = _HMdUi("w\b&@s$\028[6\006g$\b\024\b&/&2HH\bH@3&$\b\0243@\003$H[@?2\bgg\b&\026)6\006gm\b[[\b&[@\nH[6\006&<\0223C\027s(C\027s(\rs$\028[6\006g$\b\024\b&@=mgg\b@\t\b&@/g<\bI\b1@=<\b@j\b64@\b3@\028\b@?<H[6\006\bH@m6\006@\028&<\bI\b\r@C\027s(C\027s(Xs$\028[6\006g$\b\024\b&@=mgg\bH@=<&@/g\b</\bH1@=<\b@I\b&&2\b643@\b[@\028<\b@?\bH[6\006\bH@$26\006@3&\b</\bHy")
zRadschlaegerbrunnen.Visible = true
zRadschlaegerbrunnen.Media = objRadschlaegerbrunnen
zRadschlaegerbrunnen.Commands = {}
zRadschlaegerbrunnen.DistanceRange = Distance(-1, "feet")
zRadschlaegerbrunnen.ShowObjects = "OnEnter"
zRadschlaegerbrunnen.ProximityRange = Distance(60, "meters")
zRadschlaegerbrunnen.AllowSetPositionTo = false
zRadschlaegerbrunnen.Active = false
zRadschlaegerbrunnen.Points = {
  ZonePoint(51.2273677818089, 6.77162624895573, 0),
  ZonePoint(51.2274127133268, 6.77172280848026, 0),
  ZonePoint(51.227390037613, 6.77184015512466, 0),
  ZonePoint(51.2273316685946, 6.77191659808159, 0),
  ZonePoint(51.2272455846554, 6.77190184593201, 0),
  ZonePoint(51.2272023326642, 6.77179120481014, 0),
  ZonePoint(51.2272073717333, 6.77166245877743, 0),
  ZonePoint(51.2272942955871, 6.77157327532768, 0)
}
zRadschlaegerbrunnen.OriginalPoint = ZonePoint(51.2273064732479, 6.77175432443619, 0)
zRadschlaegerbrunnen.DistanceRangeUOM = "Feet"
zRadschlaegerbrunnen.ProximityRangeUOM = "Meters"
zRadschlaegerbrunnen.OutOfRangeName = ""
zRadschlaegerbrunnen.InRangeName = ""
zTonhalle = Wherigo.Zone(objDusseldorp)
zTonhalle.Id = "21b8963b-92e9-46bc-bf96-89569e46620c"
zTonhalle.Name = _HMdUi("\029mH\006$gg\b")
zTonhalle.Description = _HMdUi("w<\b@\029mH\006$gg\b@X$26\006@9\b2\b@\029mH\006$gg\b@\f2&@8H3\b&[6\006\b<\0282H\024@ImH@\028\b&@4&<\b\024[\f\b&[3m\b&3\bH@$g3\bH@\029mH\006$gg\b@$H@\028\b&@\029mH\006$gg\bH[3&$[[\b@h@n64\b@)6\006$\028m=[3&$[[\by@<[3@\b<H@EmH\f\b&3\006$2[@<H@w2\b[[\bg\028m&\022\\C\027s(C\027s(w$[@\r\021&2\bH\b@\021\b=m\bg/\b\r@\024\b\006m\b&3@\006\b23\b@\f2@\028\bH@[6\006m\bH[3\bH@\027\b<[u<\bg\bH@\b}u&\b[[<mH<[3<[6\006\b&@\027$242H[3\\")
zTonhalle.Visible = false
zTonhalle.Media = objTonhalle
zTonhalle.Commands = {}
zTonhalle.DistanceRange = Distance(-1, "feet")
zTonhalle.ShowObjects = "OnEnter"
zTonhalle.ProximityRange = Distance(60, "meters")
zTonhalle.AllowSetPositionTo = false
zTonhalle.Active = true
zTonhalle.Points = {
  ZonePoint(51.231800883522, 6.77135199308395, 0),
  ZonePoint(51.2313902385785, 6.77139222621918, 0),
  ZonePoint(51.2313868795045, 6.77182406187058, 0),
  ZonePoint(51.231796684717, 6.77180796861649, 0)
}
zTonhalle.OriginalPoint = ZonePoint(51.2315936715805, 6.77159406244755, 0)
zTonhalle.DistanceRangeUOM = "Feet"
zTonhalle.ProximityRangeUOM = "Meters"
zTonhalle.OutOfRangeName = ""
zTonhalle.InRangeName = ""
zAltestadt = Wherigo.Zone(objDusseldorp)
zAltestadt.Id = "07469c72-7295-43b6-ad44-d4b946bd01fd"
zAltestadt.Name = _HMdUi("`g3\b[3$\0283")
zAltestadt.Description = _HMdUi("w<\b@`g3\b[3$\0283@<[3@\b<H\b@\028\b&@$\bg3\b[3\bH@)3&$[[\bH@\028\b&@)3$\02831@\028<\b@[mgg3\b3@<\006&@n26\006@\t$g@$H[\b\006\bH\\C\027s(C\027s(\003<\b&@\022<H\028\b3@\n\006&@$26\006@\028<\b@E<&6\006\b@)3\\@d$\t/\b&32[@\t<3@<\006&\b\t@I\b&\028&\b\0063\b\t@\0292&\t\028$6\0061@\b<H@=<6\0063<\024\b[@a$\006&\f\b<6\006\bH@w2\b[[\bg\028m&\022[\\C\027s(C\027s(w\b&@\0292&\t@[mgg@[<6\006@2\b/&<\024\bH[@=<\b\028\b&@&<6\0063\bH1@[m/$g\028@\b<H\b@\1272H\024\022&$2@<H@\028\b&@E<&6\006\b@\024\b3&$23@=<&\028\\\\\\")
zAltestadt.Visible = true
zAltestadt.Media = objAltestadt
zAltestadt.Commands = {}
zAltestadt.DistanceRange = Distance(-1, "feet")
zAltestadt.ShowObjects = "OnEnter"
zAltestadt.ProximityRange = Distance(60, "meters")
zAltestadt.AllowSetPositionTo = false
zAltestadt.Active = false
zAltestadt.Points = {
  ZonePoint(51.2283829294664, 6.77058488130569, 0),
  ZonePoint(51.2290077537891, 6.77297741174698, 0),
  ZonePoint(51.2288028392203, 6.77324026823044, 0),
  ZonePoint(51.2280772327556, 6.77055805921555, 0)
}
zAltestadt.OriginalPoint = ZonePoint(51.2285676888079, 6.77184015512467, 0)
zAltestadt.DistanceRangeUOM = "Feet"
zAltestadt.ProximityRangeUOM = "Meters"
zAltestadt.OutOfRangeName = ""
zAltestadt.InRangeName = ""
zJanWellem = Wherigo.Zone(objDusseldorp)
zJanWellem.Id = "c01b2d87-bd1f-47b9-ace2-a28981303d87"
zJanWellem.Name = _HMdUi("\127$H@a\bgg\b\t")
zJanWellem.Description = _HMdUi("w\b&@d\b\024\bH\028\b@\f2\022mg\024\b@[mgg@\028$[@s\b<3\b&[3$H\028/<g\028@\127$H@a\bgg\b\t[@ImH@\028\bH@\0272\b&\024\b&H@\024\b[3<\0223\b3@=m&\028\bH@[\b<H@2H\0281@H$6\006\028\b\t@\028\b\t@E2\bH[3g\b&@\028$[@?$3\b&<$g@$2[\024\b\024$H\024\bH@=$&1@4gmu\0223\b@[\b<H@\021<\b[[\b&j2H\024\b@$H@\028<\b@\0292\b&\bH@\028\b&@\0272\b&\024\b&@2H\028@[$\t\t\bg3\b@)u\bH\028\bH@<H@tm&\t@ImH@)<g/\b&/\b[3\b64\\@w\b&@j2H\024\b@\003\b<H&<6\006@\003\b<H\b@[<HH<\b&3\b@[u$\b3\b&1@=<\b@I<\bg\b@`u\022\bg3m\b&36\006\bH@\b&@=m\006g@\t<3@\028\bH@\024$H\f\bH@)<g/\b&gm\b\022\022\bgH@\006$\b33\b@\b[[\bH@4m\bHH\bH\\")
zJanWellem.Visible = true
zJanWellem.Media = objJanWellem
zJanWellem.Commands = {}
zJanWellem.DistanceRange = Distance(-1, "feet")
zJanWellem.ShowObjects = "OnEnter"
zJanWellem.ProximityRange = Distance(60, "meters")
zJanWellem.AllowSetPositionTo = false
zJanWellem.Active = false
zJanWellem.Points = {
  ZonePoint(51.225692056822, 6.77192062139511, 0),
  ZonePoint(51.2258062793326, 6.77181333303452, 0),
  ZonePoint(51.2258936257671, 6.77189379930496, 0),
  ZonePoint(51.2259205015598, 6.77215129137039, 0),
  ZonePoint(51.2257357301684, 6.77221029996872, 0),
  ZonePoint(51.2256987758011, 6.77212983369827, 0)
}
zJanWellem.OriginalPoint = ZonePoint(51.2257911615752, 6.77201986312866, 0)
zJanWellem.DistanceRangeUOM = "Feet"
zJanWellem.ProximityRangeUOM = "Meters"
zJanWellem.OutOfRangeName = ""
zJanWellem.InRangeName = ""
zKommoedchen = Wherigo.Zone(objDusseldorp)
zKommoedchen.Id = "3b8988c2-90a7-4e64-8ce5-9b50c748988b"
zKommoedchen.Name = _HMdUi("Em\t\tm\b\0286\006\bH")
zKommoedchen.Description = ""
zKommoedchen.Visible = false
zKommoedchen.Commands = {}
zKommoedchen.DistanceRange = Distance(-1, "feet")
zKommoedchen.ShowObjects = "OnEnter"
zKommoedchen.ProximityRange = Distance(60, "meters")
zKommoedchen.AllowSetPositionTo = false
zKommoedchen.Active = true
zKommoedchen.Points = {
  ZonePoint(51.2275279813658, 6.77532702684402, 0),
  ZonePoint(51.2275347000768, 6.77560597658157, 0),
  ZonePoint(51.2271819664213, 6.77563816308975, 0),
  ZonePoint(51.2271752476588, 6.77538603544235, 0)
}
zKommoedchen.OriginalPoint = ZonePoint(51.2273549738807, 6.77548930048942, 0)
zKommoedchen.DistanceRangeUOM = "Feet"
zKommoedchen.ProximityRangeUOM = "Meters"
zKommoedchen.OutOfRangeName = ""
zKommoedchen.InRangeName = ""
zKastanienallee = Wherigo.Zone(objDusseldorp)
zKastanienallee.Id = "9e8e6105-7b19-4e66-a1de-5e12781f8541"
zKastanienallee.Name = _HMdUi("E$[3$H<\bH$gg\b\b")
zKastanienallee.Description = _HMdUi("\003\t\t\\\\@<[3@\028<\b@H<6\0063@<H@\021&$\022\bH/\b&\024\0165@)\b\006&@\t\b&4=2\b&\028<\024\\")
zKastanienallee.Visible = true
zKastanienallee.Media = objKastanien
zKastanienallee.Commands = {}
zKastanienallee.DistanceRange = Distance(-1, "feet")
zKastanienallee.ShowObjects = "OnEnter"
zKastanienallee.ProximityRange = Distance(60, "meters")
zKastanienallee.AllowSetPositionTo = false
zKastanienallee.Active = false
zKastanienallee.Points = {
  ZonePoint(51.225592951767, 6.77852556109428, 0),
  ZonePoint(51.2255862327725, 6.77945360541344, 0),
  ZonePoint(51.225310753153, 6.7794643342495, 0),
  ZonePoint(51.225327550738, 6.77856311202049, 0)
}
zKastanienallee.OriginalPoint = ZonePoint(51.2254543721076, 6.77900165319443, 0)
zKastanienallee.DistanceRangeUOM = "Feet"
zKastanienallee.ProximityRangeUOM = "Meters"
zKastanienallee.OutOfRangeName = ""
zKastanienallee.InRangeName = ""
zUerige = Wherigo.Zone(objDusseldorp)
zUerige.Id = "d193165f-fc3d-4f9b-8bd1-0c92df34297b"
zUerige.Name = _HMdUi("8\b&<\024\b")
zUerige.Description = _HMdUi(")\b<3@Ux\017z@=<&\028@\006<\b&@\028$[@I<\bgg\b<6\0063@/\b[3\b@\027<\b&@ImH@w2\b[[\bg\028m&\022@\024\b/&$23\\@`g3@2H\028@\1272H\024@3&<\022\0223@[<6\006@\006<\b&@\026@\028\b&@u\b&\022\b43\b@:&3@\0222\b&@\b<H\b@\004$2[\b@%\026y")
zUerige.Visible = true
zUerige.Media = objBier
zUerige.Commands = {}
zUerige.DistanceRange = Distance(-1, "feet")
zUerige.ShowObjects = "OnEnter"
zUerige.ProximityRange = Distance(60, "meters")
zUerige.AllowSetPositionTo = false
zUerige.Active = false
zUerige.Points = {
  ZonePoint(51.2252250853742, 6.77247583866119, 0),
  ZonePoint(51.2248966907452, 6.77253618836403, 0),
  ZonePoint(51.2247765867535, 6.77145257592201, 0),
  ZonePoint(51.2251486561429, 6.77137479186058, 0)
}
zUerige.OriginalPoint = ZonePoint(51.225011754754, 6.77195984870195, 0)
zUerige.DistanceRangeUOM = "Feet"
zUerige.ProximityRangeUOM = "Meters"
zUerige.OutOfRangeName = ""
zUerige.InRangeName = ""
zKIT = Wherigo.Zone(objDusseldorp)
zKIT.Id = "49d2b64d-356b-4da9-9b7d-bc0492220ce1"
zKIT.Name = _HMdUi("E\n\029")
zKIT.Description = _HMdUi("E2H[3@<\t@\0292HH\bg@XE\n\029y@<[3@\b<H@2H3\b&<&\028<[6\006\b[@`2[[3\bgg2H\024[\006$2[@\0222&@\f\b<3\024\bHm\b[[<[6\006\b@E2H[3@<H@w2\b[[\bg\028m&\022\\@w$/\b<@\006$H\028\bg3@\b[@[<6\006@2\t@\b<H\bH@[m\024\bH$HH3\bH@\0292HH\bg&\b[3&$2\t@\f=\b<@?\b3\b&@2H3\b&\006$g/@\028\b&@s\006\b<H2\022\b&u&m\t\bH$\028\b1@\028\b&@=$\b\006&\bH\028@\028\b[@\027$2[@\028\b[@s\006\b<H2\022\b&32HH\bg[@\bH3[3$H\028\\")
zKIT.Visible = true
zKIT.Media = objKIT
zKIT.Commands = {}
zKIT.DistanceRange = Distance(-1, "feet")
zKIT.ShowObjects = "OnEnter"
zKIT.ProximityRange = Distance(60, "meters")
zKIT.AllowSetPositionTo = false
zKIT.Active = false
zKIT.Points = {
  ZonePoint(51.2204039161474, 6.76662996411324, 0),
  ZonePoint(51.220259441263, 6.76728174090385, 0),
  ZonePoint(51.2196059387382, 6.7669115960598, 0),
  ZonePoint(51.2197957746179, 6.76617935299873, 0)
}
zKIT.OriginalPoint = ZonePoint(51.2200162676916, 6.7667506635189, 0)
zKIT.DistanceRangeUOM = "Feet"
zKIT.ProximityRangeUOM = "Meters"
zKIT.OutOfRangeName = ""
zKIT.InRangeName = ""
zStadtmuseum = Wherigo.Zone(objDusseldorp)
zStadtmuseum.Id = "05096aca-0187-4cc6-84d3-171ff10747dc"
zStadtmuseum.Name = _HMdUi(")3$\0283\t2[\b2\t")
zStadtmuseum.Description = _HMdUi("\n\t@\004$g$<[@)u\b\b@/\b\022<H\028\b3@[<6\006@\028$[@)3$\0283\t2[\b2\t\\@\003<\b&@<[3@\028$[@\021\b\028$\b6\0063H<[@\028\b&@)3$\0283@2H3\b&\024\b/&$6\0063\\@n<H@\027\b[26\006@gm\006H3@[<6\006\\\\")
zStadtmuseum.Visible = true
zStadtmuseum.Media = objPalaisSpee
zStadtmuseum.Commands = {}
zStadtmuseum.DistanceRange = Distance(-1, "feet")
zStadtmuseum.ShowObjects = "OnEnter"
zStadtmuseum.ProximityRange = Distance(60, "meters")
zStadtmuseum.AllowSetPositionTo = false
zStadtmuseum.Active = false
zStadtmuseum.Points = {
  ZonePoint(51.2223475632401, 6.76953479647636, 0),
  ZonePoint(51.222226612661, 6.76992505788803, 0),
  ZonePoint(51.2218503199379, 6.76961928606033, 0),
  ZonePoint(51.2219611922206, 6.76924377679825, 0)
}
zStadtmuseum.OriginalPoint = ZonePoint(51.2220964220149, 6.76958072930574, 0)
zStadtmuseum.DistanceRangeUOM = "Feet"
zStadtmuseum.ProximityRangeUOM = "Meters"
zStadtmuseum.OutOfRangeName = ""
zStadtmuseum.InRangeName = ""
zCache = Wherigo.Zone(objDusseldorp)
zCache.Id = "1e8f69ba-e751-46b7-bf70-dd3c80b1b336"
zCache.Name = _HMdUi("\002$6\006\b")
zCache.Description = _HMdUi("\003mg3@<\006H@n26\0065")
zCache.Visible = true
zCache.Media = objCache
zCache.Commands = {}
zCache.DistanceRange = Distance(-1, "feet")
zCache.ShowObjects = "OnEnter"
zCache.ProximityRange = Distance(60, "meters")
zCache.AllowSetPositionTo = false
zCache.Active = false
zCache.Points = {
  ZonePoint(51.2279374010284, 6.76143385469913, 0),
  ZonePoint(51.2279810722441, 6.76132924854755, 0),
  ZonePoint(51.2279105264135, 6.76122196018696, 0),
  ZonePoint(51.2278609763012, 6.76133595407009, 0)
}
zCache.OriginalPoint = ZonePoint(51.2279224939968, 6.76133025437593, 0)
zCache.DistanceRangeUOM = "Feet"
zCache.ProximityRangeUOM = "Meters"
zCache.OutOfRangeName = ""
zCache.InRangeName = ""
zRheinkniebruecke = Wherigo.Zone(objDusseldorp)
zRheinkniebruecke.Id = "6d1dfc63-00b8-48c0-8832-345c9e5838bc"
zRheinkniebruecke.Name = _HMdUi("s\006\b<H4H<\b/&2\b64\b")
zRheinkniebruecke.Description = ""
zRheinkniebruecke.Visible = true
zRheinkniebruecke.Commands = {}
zRheinkniebruecke.DistanceRange = Distance(-1, "feet")
zRheinkniebruecke.ShowObjects = "OnEnter"
zRheinkniebruecke.ProximityRange = Distance(60, "meters")
zRheinkniebruecke.AllowSetPositionTo = false
zRheinkniebruecke.Active = false
zRheinkniebruecke.Points = {
  ZonePoint(51.2224113981399, 6.76149621605873, 0),
  ZonePoint(51.2227204921918, 6.76222577691078, 0),
  ZonePoint(51.2220619849731, 6.76301971077919, 0),
  ZonePoint(51.2217797647098, 6.76222577691078, 0)
}
zRheinkniebruecke.OriginalPoint = ZonePoint(51.2222434100036, 6.76224187016487, 0)
zRheinkniebruecke.DistanceRangeUOM = "Feet"
zRheinkniebruecke.ProximityRangeUOM = "Meters"
zRheinkniebruecke.OutOfRangeName = ""
zRheinkniebruecke.InRangeName = ""
objEinJunge = Wherigo.ZCharacter({Cartridge = objDusseldorp, Container = zRadschlaegerbrunnen})
objEinJunge.Id = "7c4967d1-8a13-44fd-87ae-d9c18aeafd75"
objEinJunge.Name = _HMdUi("n<H@\1272H\024\b")
objEinJunge.Description = _HMdUi("n<H@\1272H\024\b1@4H$uu@US@\127$\006&\b@$g31@[u<\bg3@\006<\b&@$\t@\027&2HH\bH\\C\027s(C\027s()<\b\0063@$2[1@$g[@=$&3\b@\b&@$2\022@\b3=$[1@\b&@[6\006$23@w<6\006@\024$H\f@\b&=$&32H\024[Imgg@$H\\\\\\")
objEinJunge.Visible = true
objEinJunge.Media = objBengel
objEinJunge.Commands = {}
objEinJunge.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objEinJunge.Gender = "Male"
objEinJunge.Type = "NPC"
objKomponist = Wherigo.ZCharacter({Cartridge = objDusseldorp, Container = zTonhalle})
objKomponist.Id = "831d21f9-3d6e-49af-8df1-5579b131c561"
objKomponist.Name = _HMdUi("Em\tumH<[3")
objKomponist.Description = _HMdUi("w\b&@\029Ru@[<\b\0063@\b6\0063@\t\b&4=2\b&\028<\024@$2[\\\\@Em\t\t3@\b&@n26\006@H<6\0063@\b3=$[@/\b4$HH3@Im&\016@a<\b@$26\006@<\t\t\b&{@$\t@/\b[3\bH@H<6\0063@/\b$6\0063\bH1@\b&@=<&43@\b3=$[@H\b/\bH@\028\b&@)u2&\\")
objKomponist.Visible = true
objKomponist.Media = objRobertSchumann
objKomponist.Commands = {}
objKomponist.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKomponist.Gender = "Male"
objKomponist.Type = "NPC"
objeenePenning = Wherigo.ZItem({Cartridge = objDusseldorp, Container = zOberkasselerBruecke})
objeenePenning.Id = "7ceb3fd3-596b-4055-857c-406cbf858e49"
objeenePenning.Name = _HMdUi("\b\bH\b@\004\bHH<H\024")
objeenePenning.Description = _HMdUi(")<\b\0063@$2[@=<\b@\b<H@$g3\b&@\004\022\bHH<\024")
objeenePenning.Visible = true
objeenePenning.Media = objPfennig
objeenePenning.Commands = {
  cmdNehmen = Wherigo.ZCommand({
    Text = _HMdUi("9\b\006\t\bH"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _HMdUi("w$[@<[3@\028\b&@\b\tu3R@3\b}3\\")
  }),
  cmdGeben = Wherigo.ZCommand({
    Text = _HMdUi("\021\b/\bH"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _HMdUi("w$[@<[3@\028\b&@\b\tu3R@3\b}35")
  })
}
objeenePenning.Commands.cmdNehmen.Custom = true
objeenePenning.Commands.cmdNehmen.Id = "67071ef3-0557-46ee-8fcb-e08c5e8adf75"
objeenePenning.Commands.cmdNehmen.WorksWithAll = true
objeenePenning.Commands.cmdGeben.Custom = true
objeenePenning.Commands.cmdGeben.Id = "6460b67b-6b30-4fa5-9e9b-5cda3ef8a5b7"
objeenePenning.Commands.cmdGeben.WorksWithAll = true
objeenePenning.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objeenePenning.Locked = false
objeenePenning.Opened = false
objFotoKind = Wherigo.ZItem(objDusseldorp)
objFotoKind.Id = "df3464e1-7df8-463d-9da8-87c7343120a0"
objFotoKind.Name = _HMdUi("tm3m{@E<H\028")
objFotoKind.Description = _HMdUi("n<H@E<H\028@[6\006g$\b\0243@\024\b&$\028\b@\b<H@s$\028\\@w2@\006$[3@\b[@$2\022@\028\b\t@Emu\022@[3\b\006\bH\028@\b&=<[6\0063\\")
objFotoKind.Visible = true
objFotoKind.Media = objRadschlaeger
objFotoKind.Commands = {}
objFotoKind.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFotoKind.Locked = false
objFotoKind.Opened = false
objSofortbildkamera = Wherigo.ZItem({Cartridge = objDusseldorp, Container = Player})
objSofortbildkamera.Id = "4f971270-3194-4878-868e-7b78c75dbcf1"
objSofortbildkamera.Name = _HMdUi(")m\022m&3/<g\0284$\t\b&$")
objSofortbildkamera.Description = _HMdUi("9\b@mgg\b@\004mg$&m<\028\\\\")
objSofortbildkamera.Visible = true
objSofortbildkamera.Media = objPolaroid
objSofortbildkamera.Commands = {
  cmdFotomachen = Wherigo.ZCommand({
    Text = _HMdUi("tm3m@\t$6\006\bH"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _HMdUi("9m3\006<H\024@$I$<g$/g\b")
  })
}
objSofortbildkamera.Commands.cmdFotomachen.Custom = true
objSofortbildkamera.Commands.cmdFotomachen.Id = "e7f40aa8-6a9c-4c5d-8e2f-833cd7fd9ed7"
objSofortbildkamera.Commands.cmdFotomachen.WorksWithAll = true
objSofortbildkamera.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSofortbildkamera.Locked = false
objSofortbildkamera.Opened = false
objPferdeapfel1 = Wherigo.ZItem(objDusseldorp)
objPferdeapfel1.Id = "c27dfc6e-27ce-4bc6-aeef-f8fcd4d02755"
objPferdeapfel1.Name = _HMdUi("\004\022\b&\028\b$u\022\bg")
objPferdeapfel1.Description = _HMdUi("9<6\0063@[\b\006&@$uu\b3<3g<6\006\\\\C\027s(\021m33@[\b<@w$H4@<[3@\b&@H2&@I<&32\bgg@{\026y")
objPferdeapfel1.Visible = true
objPferdeapfel1.Media = objPferdeapfel
objPferdeapfel1.Commands = {}
objPferdeapfel1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPferdeapfel1.Locked = false
objPferdeapfel1.Opened = false
objFotoKoe = Wherigo.ZItem(objDusseldorp)
objFotoKoe.Id = "43ee75ec-368f-46b0-8b57-8467ebd99824"
objFotoKoe.Name = _HMdUi("tm3m{@Em\b")
objFotoKoe.Description = _HMdUi("tm3m@\028\b[@)3&$[[\bH[6\006<g\028[")
objFotoKoe.Visible = true
objFotoKoe.Media = objKoeSchild
objFotoKoe.Commands = {}
objFotoKoe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFotoKoe.Locked = false
objFotoKoe.Opened = false
objFotoOfenrohr = Wherigo.ZItem(objDusseldorp)
objFotoOfenrohr.Id = "75bb4c44-df3e-4cb1-b168-e55caa621041"
objFotoOfenrohr.Name = _HMdUi("tm3m{@:\022\bH&m\006&")
objFotoOfenrohr.Description = _HMdUi("w$[@/\b&2\b\006\t3\b@:\022\bH&m\006&@ImH@\127m[\bu\006@\027\b2R[\\")
objFotoOfenrohr.Visible = true
objFotoOfenrohr.Media = objRohr
objFotoOfenrohr.Commands = {}
objFotoOfenrohr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFotoOfenrohr.Locked = false
objFotoOfenrohr.Opened = false
objBeendetdenWherigo = Wherigo.ZItem({Cartridge = objDusseldorp, Container = Player})
objBeendetdenWherigo.Id = "17ef0b4a-6314-42c0-a21f-ed886a79d0f1"
objBeendetdenWherigo.Name = _HMdUi("\027\b\bH\028\b3@\028\bH@a\006\b&<\024m5")
objBeendetdenWherigo.Description = _HMdUi("\027\b$H3=m&3\b3@\028<\b@t<H$g\022&$\024\b@X\028<\b@`H3=m&3@\022<H\028\b3@\n\006&@<H@\028\b&@wm[\by@2H\028@<\006&@\b&\006$g3\b3@\028\bH@t&\b<[6\006$g36m\028\b@\0222\b&@\028<\b[\b@\002$&3&<\028\024\b1@\028\bH@\n\006&@$2\022@\028\b&@a\006\b&<\024m@a\b/[\b<3\b@\b<H\024\b/\bH@\t2\b[[3\\C\027s(C\027s(w<\b@\024\bH$2\bH@t<H$g4mm&\028<H$3\bH@g$23\bH{C\027s(C\027s(9@\005U@U\019\\\017\015\015@n@SS\017@G\005\\\017\015xC\027s(C\027s(\027$2\t@H\b/\bH@\004$u<\b&4m&/1@\006<H3\b&@\028\b\t@\0272\b&\024\b&[3\b<\0241@<H@6$\\@U\\xS\t@\003m\006\b\\@n<H@\004\b3g<H\0241@\022\b[3\024\b/2H\028\bH\\")
objBeendetdenWherigo.Visible = false
objBeendetdenWherigo.Media = objCache
objBeendetdenWherigo.Commands = {
  cmdFinalfrage = Wherigo.ZCommand({
    Text = _HMdUi("t<H$g\022&$\024\b"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _HMdUi("9m3\006<H\024@$I$<g$/g\b")
  })
}
objBeendetdenWherigo.Commands.cmdFinalfrage.Custom = true
objBeendetdenWherigo.Commands.cmdFinalfrage.Id = "2417dc26-b797-4123-9e94-f1a2a6ab2f20"
objBeendetdenWherigo.Commands.cmdFinalfrage.WorksWithAll = true
objBeendetdenWherigo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBeendetdenWherigo.Locked = false
objBeendetdenWherigo.Opened = false
tKastanienallee = Wherigo.ZTask(objDusseldorp)
tKastanienallee.Id = "18879a79-15f8-40db-a090-649bd289d1bc"
tKastanienallee.Name = _HMdUi("8\t/\bHH2H\024@E$[3$H<\bH$gg\b\b")
tKastanienallee.Description = _HMdUi(")m&\0243@\028$\0222\b&1@\028$[@\028<\b@E$[3$H<\bH$gg\b\b@<\006&\bH@&<6\0063<\024\bH@9$\t\bH@/\b4m\t\t35")
tKastanienallee.Visible = true
tKastanienallee.Active = true
tKastanienallee.Complete = false
tKastanienallee.CorrectState = "None"
tRohr = Wherigo.ZTask(objDusseldorp)
tRohr.Id = "32c68c53-e3f6-4427-97b0-4cf854edcc1a"
tRohr.Name = _HMdUi("sm\006&@\024\b[26\0063")
tRohr.Description = _HMdUi("am@\t$\024@\028$[@[\b<H\016@a\bHH@<\006&@\b[@[\b\00631@\t$6\0063@\b<H@tm3m@\t<3@\028\b&@)m\022m&3/<g\0284$\t\b&$\\C\027s(C\027s(t$gg[@<\006&@\b[@H<6\0063@\022<H\028\b3{@.\b<\0243@\b<H\b\t@\004$[[$H3\bH@\028$[@\027<g\0281@w2\b[[\bg\028m&\022\b&@[mgg3\b3@n26\006@\006\bg\022\bH@4m\bHH\bH\\")
tRohr.Visible = true
tRohr.Media = objRohr
tRohr.Active = true
tRohr.Complete = false
tRohr.CorrectState = "None"
tQuiz = Wherigo.ZTask(objDusseldorp)
tQuiz.Id = "a7689669-e0bf-4b79-a7d3-c55aa747322b"
tQuiz.Name = _HMdUi("w2[[\bg\028m&u@;2<\f")
tQuiz.Description = _HMdUi("\027\b$H3=m&3\b3@\t<H\028\b[3\bH[@\017@t&$\024\bH5@C\027s(C\027s(\n\t@d$2\022\b@\028\b[@)u<\bg[@=\b&\028\bH@XH<6\0063@\024$H\f@g\b<6\0063\by@t&$\024\bH@\024\b[3\bgg3@\026@\n\006&@\t2\b[[3@H<6\0063@$gg\b[@=<[[\bH1@2\t@\028<\b[\bH@\002$6\006\b@\f2@\022<H\028\bH\\@s<6\0063<\024\b@`H3=m&3\bH@\024\b/\bH@\005@\0042H43\b1@/\b<@\022$g[6\006\bH@\f<\b\006\b@<6\006@\b<H\bH@\0042H43@$/\\@C\027s(C\027s(E2&\f@Im&@)6\006g2[[@=\b&\028\b3@\n\006&@\b2&\b@\0042H43\f$\006g@\b&\022$\006&\bH@2H\028@<\t@\002$6\006\b@$gg\b@&<6\0063<\024\bH@`H3=m&3\bH@\022<H\028\bH\\")
tQuiz.Visible = true
tQuiz.Active = true
tQuiz.Complete = false
tQuiz.CorrectState = "None"
tKindskopf = Wherigo.ZTask(objDusseldorp)
tKindskopf.Id = "406c864e-8e3c-415f-b6f8-f8ad93b850df"
tKindskopf.Name = _HMdUi("E<H\028[4mu\022")
tKindskopf.Description = _HMdUi("7\b&[26\0063@\b<H@E<H\028@\f2@\022m3m\024&$\022<\b&\bH@\026@$2\022@\028\b\t@Emu\0225")
tKindskopf.Visible = true
tKindskopf.Active = true
tKindskopf.Complete = false
tKindskopf.CorrectState = "None"
vScore = 0
vAntworten = 0
vAufgaben = 0
vReason = 0
vFragen = 0
objDusseldorp.ZVariables = {
  vScore = 0,
  vAntworten = 0,
  vAufgaben = 0,
  vReason = 0,
  vFragen = 0
}
objRheinische = Wherigo.ZInput(objDusseldorp)
objRheinische.Id = "26a0737e-8ed7-4d7d-a288-407ecc9eb316"
objRheinische.Name = _HMdUi("s\006\b<H<[6\006\b")
objRheinische.Description = ""
objRheinische.Visible = true
objRheinische.Choices = {
  "Eurovision Sendung",
  "Aktuelle Stunde",
  "Drehscheibe",
  "Hier und Heute",
  "Lokalzeit Duesseldorf",
  "Tagesschau",
  "Heute",
  "Bericht aus Bonn"
}
objRheinische.InputType = "MultipleChoice"
objRheinische.Text = _HMdUi("a\bg6\006\b@)\bH\0282H\024@=$&@\b[\016")
objGrossherzog = Wherigo.ZInput(objDusseldorp)
objGrossherzog.Id = "cb617dc7-6297-4211-a8b9-4d388f564fdc"
objGrossherzog.Name = _HMdUi("\021&m[[\006\b&\fm\024")
objGrossherzog.Description = ""
objGrossherzog.Visible = true
objGrossherzog.Choices = {
  "Frank Selim",
  "Paul Hakan",
  "Pierre Lafitte",
  "Peter Mehmmet",
  "Joachim Murat",
  "Ralf Berkan"
}
objGrossherzog.InputType = "MultipleChoice"
objGrossherzog.Text = _HMdUi("a<\b@=$&@[\b<H@9$\t\b\016")
objHeinrichHeine = Wherigo.ZInput(objDusseldorp)
objHeinrichHeine.Id = "6ff844a6-f95f-4a57-971c-9c12e33309bc"
objHeinrichHeine.Name = _HMdUi("\003\b<H&<6\006@\003\b<H\b")
objHeinrichHeine.Description = ""
objHeinrichHeine.Visible = true
objHeinrichHeine.Choices = {
  "Winzigtromm",
  "Riesenharf",
  "Grossfloet",
  "Minibratsch",
  "Kleinpauk",
  "Schmalobo"
}
objHeinrichHeine.InputType = "MultipleChoice"
objHeinrichHeine.Text = _HMdUi("a<\b@g$23\b3@\b[\016")
objNationalversammlung = Wherigo.ZInput(objDusseldorp)
objNationalversammlung.Id = "b18ca21a-a9e8-432b-a3bc-e39f2a803cd5"
objNationalversammlung.Name = _HMdUi("9$3<mH$gI\b&[$\t\tg2H\024")
objNationalversammlung.Description = ""
objNationalversammlung.Visible = true
objNationalversammlung.Choices = {
  "Berlin",
  "Frankfurt",
  "Duesseldorf",
  "Weimar",
  "Stuttgart",
  "Wien"
}
objNationalversammlung.InputType = "MultipleChoice"
objNationalversammlung.Text = _HMdUi(")3$\0283@\028\b&@9$3<mH$gI\b&[$\t\tg2H\024@UxGxhGT\016")
objKuenstler = Wherigo.ZInput(objDusseldorp)
objKuenstler.Id = "be5a04b0-ca76-4597-befe-153ac0fe5356"
objKuenstler.Name = _HMdUi("E2\bH[3g\b&")
objKuenstler.Description = ""
objKuenstler.Visible = false
objKuenstler.Choices = {
  "Peter von Cornelius",
  "Guenter Grass",
  "Paul Klee",
  "Christoph Schlingensief",
  "Albrecht Duerer",
  "August Macke"
}
objKuenstler.InputType = "MultipleChoice"
objKuenstler.Text = _HMdUi("n<H\b&@ImH@\028\bH\bH@\f\\\027\\@H<\b5")
objUerige = Wherigo.ZInput(objDusseldorp)
objUerige.Id = "a6635317-cd0e-4aba-a5f3-8a50ce7b3ade"
objUerige.Name = _HMdUi("8\b&<\024\b")
objUerige.Description = ""
objUerige.Visible = true
objUerige.Choices = {
  "Theo Lingen",
  "Karl Valentin",
  "Peter Alexander",
  "Lore Lorentz",
  "Willy Millowitsch",
  "Heinz Erhardt"
}
objUerige.InputType = "MultipleChoice"
objUerige.Text = _HMdUi("a\b[[\bH@7$3\b&@=$&@\b[\016")
objSenf1 = Wherigo.ZInput(objDusseldorp)
objSenf1.Id = "3b6a1ecf-6a0c-4325-bc0e-31d8fc7b2f20"
objSenf1.Name = _HMdUi(")\bH\022")
objSenf1.Description = ""
objSenf1.Visible = true
objSenf1.Choices = {
  "Paul Klee",
  "Peter von Cornelius",
  "August Macke",
  "Albrecht Duerer",
  "Wilhelm von Schadow",
  "Vincent van Gogh"
}
objSenf1.InputType = "MultipleChoice"
objSenf1.Text = _HMdUi("a\bg6\006\b&@E2\bH[3g\b&@\006$3@\b[@\024\b\t$g3\016")
iMaria = Wherigo.ZInput(objDusseldorp)
iMaria.Id = "fda8faed-35bf-4445-8e10-c1707aeaf6ba"
iMaria.Name = _HMdUi("?$&<$")
iMaria.Description = ""
iMaria.Visible = true
iMaria.Choices = {
  "Anna Maria Luisa de Medici",
  "Katharina II.",
  "Louise Dumont",
  "Sissi",
  "Bertha von Suttner",
  "Emily Bronte"
}
iMaria.InputType = "MultipleChoice"
iMaria.Text = _HMdUi("a\b&@=$&@\028$[\016")
objFinalfrage = Wherigo.ZInput(objDusseldorp)
objFinalfrage.Id = "7c67cd73-1efd-4e00-a75d-404b7a5fa35d"
objFinalfrage.Name = _HMdUi("t<H$g\022&$\024\b")
objFinalfrage.Description = ""
objFinalfrage.Visible = true
objFinalfrage.InputType = "Text"
objFinalfrage.Text = _HMdUi("t<H$g$H3=m&3@$2[@\028\b\t@\002$6\006\b{")
function objDusseldorp:OnStart()
  if _G[_HMdUi("nHI")][_HMdUi("\004g$3\022m&\t")] == _HMdUi("a<H\019z") or _G[_HMdUi("nHI")][_HMdUi("w\bI<6\b\nw")] == _HMdUi("w\b[43mu") then
    for k, v in pairs(_G[_HMdUi("m/jw2[[\bg\028m&u")][_HMdUi("`gg.:/j\b63[")]) do
      v[_HMdUi("7<[</g\b")] = false
      v[_HMdUi("`63<I\b")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_HMdUi(":6\006@Hm\b1@H<6\0063@<H@\028\b&@=$&\t\bH@)32/\b\\\\")),
      Callback = function(action)
        if action ~= nil then
          _G[_HMdUi("a\006\b&<\024m")][_HMdUi("\002m\t\t$H\028")](_HMdUi(")$I\b\002gm[\b"))
        end
      end
    })
    return
  end
  MyShowStatus()
  _Urwigo.Dialog(false, {
    {
      Text = (_HMdUi("\003$ggm@") .. Player.Name) .. _HMdUi("5C\027s(C\027s(\003\b&\fg<6\006@=<gg4m\t\t\bH@\f2\t@w2\b[[\bg\028m&\022\b&@a\006\b&<\024m\\\\@\rw2[[\bg\028m&u\r"),
      Media = objRaNa2009
    },
    {
      Text = _HMdUi("n<H@\003<H=\b<[@Im&H\b=\b\024{@a2H\028\b&3@n26\006@H<6\00631@=\bHH@\b&[3@\t$g@H<6\0063[@u$[[<\b&31@H$6\006\028\b\t@\n\006&@\b<H\b@dm6$3<mH@\b&&\b<6\0063@\006$/3\\C\027s(C\027s(t$gg[@\b[@H<6\0063[@\f2@[\b\006\bH@\024</31@\024\b\0063@\b<H\022$6\006@=\b<3\b&@\f2\t@H$\b6\006[3\bH@.<\bg\\@:\0223@u$[[<\b&3@\b3=$[@/\b<\t@7\b&g$[[\bH@\028\b&@:\b&3g<6\0064\b<35"),
      Media = objRaNa2009
    },
    {
      Text = _HMdUi("a<&@\006m\022\022\bH@\n\006&@\006$/3@)u$[[@\t<3@\028<\b[\b&@\002$&3&<\028\024\b@2H\028@=2\bH[6\006\bH@n26\006@I<\bg@n&\022mg\024@2H\028@4\b<H\b@`/[32\b&\f\b@%\026yC\027s(C\027s(a<\b@<\t\t\b&@\021&2[[@$2[@\027<g41C\027s(s$9$zSST"),
      Media = objRaNa2009
    }
  }, function(action)
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("\003$/3@\n\006&@\024\b&$\028\b@\b3=$[@\024\b\006m\b&3\016@t$gg[@\n\006&@H<6\0063@\028\bH@\127<H\024g\b@$2[@\ra\b&@=<&\028@?<gg<mH$\b&\r@\024\b\006m\b&3@\006$/31@4$HH@n2\b&@\021\b&$\b3@I\b&\t23g<6\006@4\b<H\b@`2\028<m\028$3\b<\bH@$/[u<\bg\bH\\@X:\028\b&@<[3@$2\022@g\b<[\b@\024\b[3\bgg3\016yC\027s(C\027s(\nH@\028\b\t@t$gg@<\t@7\b&g$2\022@\028\b[@\002$6\006\b[@<\t\t\b&@$2\022[@w<[ug$R@$6\0063\bH5")
    })
  end)
end
function objDusseldorp:OnRestore()
  MyShowStatus()
end
function zOberkasselerBruecke:OnEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _HMdUi("\003<\b&@<[3@\f=$&@g\b<\028\b&@<\t\t\b&@I<\bg@7\b&4\b\006&1@$/\b&@ImH@\006<\b&@\006$/3@\n\006&@\b<H\b@3mgg\b@)<6\0063@$2\022@\028<\b@s\006\b<H\022&mH3\\@a<&@\006m\022\022\bH1@\n\006&@\006$/3@[6\006m\bH\b[@a\b33\b&5C\027s(C\027s(w<\b@\027&2\b64\b@=2&\028\b@UT\015\017@2\t@\022$[3@\005S@?\b3\b&@s\006\b<H$/=$\b&3[@$2\022@\028<\b@\006\b23<\024\b@\004m[<3<mH@I\b&[6\006m/\bH\\C\027s(C\027s(\003<\b&@\b<H@d2\0223/<g\028@$2[@\028\b&@.\b<31@Im&@\028\b&@7\b&[6\006<\b/2H\024\\@w<\b@\004RgmH\b@$H@\028\b&@H\b2\bH@\004m[<3<mH@[<H\028@\028\b23g<6\006@\f2@\b&4\bHH\bH\\")
    },
    {Text = "", Media = objOberkasslerBruecke},
    {
      Text = _HMdUi("`/\b&@=$[@<[3@\028$[\016@\003<\b&@g<\b\0243@\028m6\006@\b3=$[@$2\022@\028\b\t@a\b\024\\\\")
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function zTonhalle:OnEnter()
  _Urwigo.MessageBox({
    Text = _HMdUi("w<\b@H\b2\b@\029mH\006$gg\b@Xj$1@\028$@g<H4[@ImH@n26\006yC\027s(C\027s(UTz\005hz\017@$g[@?\b\006&\f=\b64\006$gg\b@\024\b/$231@\028<\bH3\b@[<\b@2H3\b&@$H\028\b&\b\t@$g[@\004g$H\b3$&<2\t\\C\027s(C\027s()\b<3@?<33\b@\028\b&@\015S\b&@\127$\006&\b@<[3@[<\b@\028\b&@[6\006m\bH[3\b@EmH\f\b&3[$$g@w2\b[[\bg\028m&\022[\\@w$[@\r\021&2\bH\b@\021\b=m\bg/\b\r@<[3@[\b\006\bH[=\b&3\\C\027s(C\027s(7m&@$gg\b\t@<H@\028\bH@\004$2[\bH@\t<3@\b<H\b\t@\021g$[@)\b43@<H@\028\b&@\003$H\028@%\026y"),
    Media = objTonhalle,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = _HMdUi("7mH@\028\b&@\029mH\006$gg\b@4m\t\t3@\b<H@?$HH@$2\022@n26\006@\f2\\@n&@[<\b\0063@$2[@=<\b@$2[@\b<H\b&@$H\028\b&\bH@.\b<3\\"),
          Media = objRobertSchumann
        })
      end
    end
  })
end
function zTonhalle:OnExit()
  if objRheinische.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("\004gm\b3\fg<6\006@[u&<6\0063@n26\006@\028\b&@\b3=$[@I\b&=<&&3\b@?$HH@$H{@C\027s(C\027s(\rw$[@=$&@\b<H@3mgg\b[@EmH\f\b&31@\028$[@<6\006@\024\b&$\028\b@\024\b\006m\b&3@\006$/\b\\@w<\b@)R\tu\006mH<4\b&@\006$/\bH@\t\b<H\b@\rs\006\b<H<[6\006\b\r@\024\b[u<\bg3\\@?$H@[$\0243\b@\t<&1@\028$[@d\b<33\006\b\t$@\028\b[@\b&[3\bH@)$3\f\b[@=$\b&\b@[m\024$&@\0222\b&@\b<H\b@t\b&H[\b\006[\bH\0282H\024@I\b&=\bH\028\b3@=m&\028\bH\\\\\rC\027s(C\027s(:\006H\b@\b<H\b@`H3=m&3@$/\f2=$&3\bH@\024\b\0063@\b&@=\b<3\b&@s<6\00632H\024@:/\b&4$[[\bg\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objRheinische)
          end)
        end
      end
    })
  end
end
function zAltestadt:OnEnter()
  zJanWellem.Active = true
  _Urwigo.OldDialog({
    {
      Text = _HMdUi("E$2\t@4m\t\t3@\n\006&@<H@)<6\0063=\b<3\b@\028\b&@$\bg3\b[3\bH@)3&$[[\b@w2\b[[\bg\028m&\022[1@\028$@/<\b\0243@\b<H@/<\f$&&@$2[[\b\006\bH\028\b&@?$HH@\006m6\006@\f2@sm[[@2\t@\028<\b@n64\b\\\\")
    },
    {Text = "", Media = objJoachimMurat},
    {
      Text = _HMdUi("n&@\t2&\t\bg3@\t<3@\022&$H\fm\b[<[6\006\b\t@w<$g\b43@Im&@[<6\006@\006<H{C\027s(C\027s(\rn<H\b@t&\b[6\006Y\b<35@8H\028@\028$[@\t<&1@\028\b\t@\021&m[[Y\b&\fm\024@ImH@\027\b&\0245@w<\b[\b&@w2[[\bg\028m&\022\b&@\027\bH\024\bg@4g\b33\b&3@\028$@$2\022@\028\b\t@\127$H@a\bgg\b\t@)3$H\028/<g\028@Y\b&2\t@2H\028@\f\b<\0243@4\b<H\b&g\b<@s\b[u\b435\rC\027s(C\027s(\r7\b&\t23g<[6\006@32&H3@\b&@\028$@<\t\t\b&@Hm6\006@&2\t\\@\n[6\006@Y\b33\b@<\006H@I\b&$\0223\bH@g$[[\bH@[mgg\bH5\r1@&2\0223@\b&@2H\028@&\b<3\b3@=\b<3\b&\\")
    }
  })
end
function zAltestadt:OnExit()
  if objGrossherzog.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("w\b&@E\b&g@$2\022@\028\b\t@\004\022\b&\028@=$&@j$@[6\006mH@4m\t<[6\0061@m\028\b&\016C\027s(C\027s(`/\b&@j$1@w2\b[[\bg\028m&\022@[3$H\028@j$@=<&4g<6\006@\t$g@2H3\b&@\022&$H\fm\b[<[6\006\b&@\003\b&&[6\006$\02231@\028$@\024$/@\b[@\028m6\006@\028<\b[\bH@)6\006=$\024\b&@ImH@9$umg\bmH\\\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objGrossherzog)
          end)
        end
      end
    })
  end
end
function zJanWellem:OnEnter()
  _Urwigo.OldDialog({
    {
      Text = _HMdUi("\029$3[$6\006g<6\0061@=<\b@\028\b&@/\b&<33\bH\b@\021&m[[\006\b&\fm\024@[$\0243\b1@$2\022@\028\b\t@s\b<3\b&[3$H\028/<g\028@4g\b33\b&3@\b<H@\1272H\024\b@\006\b&2\t1@I<\bgg\b<6\0063@\017@\127$\006&\b@$g3\\@8H3\bH@[3\b\0063@\b<H\b@t&$21@\028<\b@g$23@&2\0223\\@\027\b<\028\b@3&$\024\bH@[\b\006&@$g3\tm\028<[6\006\b@Eg\b<\0282H\024\\")
    },
    {Text = "", Media = objMutterundSohn},
    {
      Text = _HMdUi("t&$2{@\r\003$&&R1@4m\t\t@\028$@j\b3\f3@&2H3\b&5@a$[@[mgg\bH@\028\bHH@\028<\b@d\b23\b@[$\024\bH1@\022<H\028\b[3@w2@\028$[@4g2\024\016@d$[[@2H[@H$6\006@\003$2[\b@\024\b\006\bH\\\rC\027s(C\027s(\1272H\024\b{@\rn<H@Eg2\024\b&@/\b\t\b&43@$gg\b[\\@92&@w2\t\t\b@\t$6\006\bH@2\b/\b&@$gg\b[@\b<H\b@\027\b\t\b&42H\024\\\rC\027s(C\027s(t&$2{@\r)m@[6\006g$21@=<\b@w2@<\t\t\b&@\028$\006\b&&\b\028\b[35@w2@=<&[3@Hm6\006\b<H\t$g@)6\006&<\0223[3\bgg\b&1@<6\006@[\b\006\b@\b[@4m\t\t\bH\\\r")
    },
    {
      Text = _HMdUi("\127\b3\f3@4g\b33\b&3@\b&@$/\b&@\028m6\006@&2H3\b&@2H\028@I\b&[6\006=<H\028\b3@\t<3@[\b<H\b&@?233\b&@<H@s<6\00632H\024@\027mg4\b&[3&$[[\b\\")
    }
  })
end
function zJanWellem:OnExit()
  if objHeinrichHeine.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi(")$\0243@\t$g1@=$&@\028\b&@\1272H\024\b@$2\022@\028\b&@)3$32\b@\b3=$@\003\b<H&<6\006@\003\b<H\b\016C\027s(C\027s(a<&@\024g$2/\bH@[6\006mH1@\b&[3@H$6\006@[\b<H\b&@\029$2\022\b@\024$/@\b&@[<6\006@j$@[\b<H\bH@/\b4$HH3\bH@7m&H$\t\bH\\@?<3@9$\t\bH@\006$3@\b&@\b[@j$@\b\0061@\028\b&@\006$33\b@\028m6\006@$26\006@[m@\b<H@\t\b&4=2\b&\028<\024\b[@\004[\b2\028mHR\t\\\\\r"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objHeinrichHeine)
          end)
        end
      end
    })
  end
end
function zKommoedchen:OnExit()
  if objKuenstler.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.Dialog(false, {
      {
        Text = _HMdUi("\027\bIm&@\n\006&@\028\bH@\027\b&\b<6\006@I\b&g$[[\bH@4m\bHH31@[u&<6\0063@n26\006@\b<H\b@H\b33\b@$\bg3\b&\b@w$\t\b@$H\\\\")
      },
      {
        Text = (_HMdUi("\003$ggm1@") .. Player.Name) .. _HMdUi("@[6\006m\bH1@\028$[[@<6\006@n26\006@3&\b\022\022\b1@<6\006@/<H@\028<\b@?233\b&@nR5"),
        Media = objJohannaEy
      },
      {
        Text = _HMdUi("a2[[3\b3@\n\006&1@\028$[[@<6\006@\028<\b@\t\b<[3\024\b\t$g3\b@t&$2@w\b23[6\006g$H\028[@/<H\016C\027s(C\027s(\n6\006@\006$33\b@Im&@g$H\024\b&@.\b<3@\b<H\b@E$\022\022\b\b[32/\b@<H@\028\b&@9$\b\006\b@\028\b&@E2H[3$4\b\028\b\t<\b@2H\028@\024$/@I<\bg\bH@\028\b&@E2\bH[3g\b&@\028m&3@E&\b\028<3\\\\\\C\027s(C\027s(:\0223@\f$\006g3\bH@[<\b@<\006&\bH@)6\0062g\028\bH@\f2&2\b641@<H\028\b\t@[<\b@\t<&@$H/m3\bH1@\t<6\006@\f2@\t$g\bH@\026@[m@4$\t@\028$[\\\\")
      }
    }, function(action)
      _Urwigo.MessageBox({
        Text = _HMdUi("\127$1@j$@\028<\b@w2\b[[\bg\028m&\022\b&@E2H[3$4$\028\b\t<\b@<[3@=\bg3/\b&2\b\006\t3\\@)m@I<\bg\b@E2\bH[3g\b&@=$&\bH@[6\006mH@\006<\b&\\\\@$/\b&@H$32\b&g<6\006@H<6\0063@$gg\b\\"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(objKuenstler)
            end)
          end
        end
      })
    end)
  end
  if Player:Contains(objFotoOfenrohr) then
    zKommoedchen.Active = false
  end
end
function zKastanienallee:OnEnter()
  objPferdeapfel1:MoveTo(nil)
  tKastanienallee.Complete = true
  objFotoKoe:MoveTo(Player)
  vAufgaben = vAufgaben + 1
  MyShowStatus()
  _Urwigo.OldDialog({
    {
      Text = _HMdUi("?m\t\bH3@\t$g@\026@=<\b[m@E$[3$H<\bH$gg\b\b\016@w$[@\006<\b&@<[3@\028m6\006@\028<\b@E:n\0165C\027s(C\027s(`/\b&@3$3[$6\006g<6\0061@$2\022@\028\b\t@)3&$[[\bH[6\006<g\028@$H@\028\b&@n64\b@[3\b\0063@E$[3$H<\bH$gg\b\b5")
    },
    {
      Text = _HMdUi(":4$R1@m4$R@\026@H2&@I<&32\bgg1@[u<\bg3@\006$g3@\t<3@{\026yC\027s(C\027s(a$\b\006&\bH\028@\n\006&@\b26\006@Hm6\006@=2H\028\b&31@4m\t\t\bH@\b<H@u$$&@E23[6\006\bH@\028<\b@)3&$[[\b@\006\b&$2\022\\\\\\")
    },
    {
      Text = _HMdUi("?\bH[6\006@<6\006@\024g$2/\b1@\028$[@<[3@Em\bH<\024@t&<\b\028&<6\006@a<g\006\bg\t@\n7\\@ImH@\004&\b2[[\bH55C\027s(C\027s(\127$1@\006$/\bH@=<&@\028\bHH@UxGx\016"),
      Media = objKoenig
    },
    {
      Text = _HMdUi("\n\006&@=<[[3@\024$&@H<6\0063@=$&2\t1@$/\b&@ugm\b3\fg<6\006@=<&\028@n26\006@\028\b&@\021\b[3$H4@\028\b[@\004\022\b&\028\b$u\022\bg[@<H@n2&\b&@\029$[6\006\b@2H\b&3&$\b\024g<6\006\\C\027s(C\027s(\n\006&@\006mg3@<\006H@&$2[@2H\028@=\b&\0223@<\006H@$H\024\b=<\028\b&3@=\b<3@ImH@n26\0065"),
      Media = objPferdeapfel
    },
    {
      Text = _HMdUi("n[@4m\t\t3@=<\b@\b[@4m\t\t\bH@\t2[[\\\\@\028$[@w<H\024@3&<\02233@\028\bH@Em\bH<\0241@\028\b&@\028$&2\b/\b&@H$32\b&g<6\006@=\bH<\024@\b&\006\b<3\b&3@<[3\\"),
      Media = objName
    },
    {
      Text = _HMdUi("\\\\$/\b&@4$2\t@\006$/3@<\006&@\028\bH@\029&\b\022\022\b&@\024\b[\b3\f31@\028$@I\b&[6\006=<H\028\b3@\028\b&@\024$H\f\b@\029&m[[5"),
      Media = objMagie
    },
    {
      Text = (_HMdUi("8H\028@ugm3\fg<6\006@<[3@$26\006@\028$[@)3&$[[\bH[6\006<g\028@=<\b\028\b&@&<6\0063<\024@\026@E:n9\n\021)`ddnn\\C\027s(C\027s(X9$6\006\028\b\t@UxGx@\028\b&@Em\bH<\024@ImH@8H/\b4$HH3\bH@X$6\006@H\b<H1@\028$[@=$&@j$@") .. Player.Name) .. _HMdUi("5y@\t<3@\004\022\b&\028\b$\bu\022\bgH@/\b=m&\022\bH@=2&\028\b1@/\bH$HH3\bH@\028<\b@w2\b[[\bg\028m&\022\b&@\028<\b@E$[3$H<\bH$gg\b\b@<H@Em\bH<\024[$gg\b@2\t\\@:/@\028$[@\028\bH@Em\bH<\024@/\b[$\bH\0223<\024\bH@4mHH3\b\016yC\027s(C\027s(a<\b@$26\006@<\t\t\b&1@<\006&@\t$6\0063@j\b\028\bH\022$gg[@\b<H@tm3m@Im\t@)3&$[[\bH[6\006<g\028\\@Eg<645")
    },
    {
      Text = _HMdUi(")m@<[3@\b[@&<6\0063<\0245"),
      Media = objKoeSchild
    }
  })
end
function zKastanienallee:OnExit()
  objPferdeapfel1:MoveTo(nil)
  Wherigo.PlayAudio(objWWM)
  _Urwigo.MessageBox({
    Text = _HMdUi("am@=<&@\024\b&$\028\b@<\t@\127$\006&\b@UxGx@=$&\bH\\\\C\027s(C\027s($g[@n&\024\b/H<[@\028\b&@?$\b&\f&\bImg23<mH@3&$\022@<H@\028<\b[\b\t@\127$\006&@$26\006@\f2\t@\b&[3\bH@?$g@\028<\b@9$3<mH$gI\b&[$\t\tg2H\024@\f2[$\t\t\bH1@\028\b&\bH@\b&$&/\b<3\b3\b@7\b&\022$[[2H\024@\f2@=\b[\bH3g<6\006\bH@\029\b<g\bH@$26\006@Hm6\006@<\t@\021&2H\028\024\b[\b3\f@\f2@\022<H\028\bH@<[3@\026@=m@=$&@\028$[@\028m6\006@\024g\b<6\006\016"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(objNationalversammlung)
        end)
      end
    end
  })
end
function zUerige:OnEnter()
  objDusseldorp:RequestSync()
  _Urwigo.MessageBox({
    Text = _HMdUi("\nH@\028\b&@9$\b\006\b@\024</3@\b[@g\b64\b&\b@\021\b3&$\bH4\b\\\\@I<\bgg\b<6\0063@\b<H@4g\b<H\b@\004$2[\b\016"),
    Media = objBier
  })
end
function zUerige:OnExit()
  if objUerige.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("\\\\\\@2H\0281@\006$3@\b[@\024\b[6\006\t\b643\016C\027s(C\027s(a2[[3\b3@\n\006&1@\028$[[@\028\b&@7$3\b&@\b<H\b[@/\b&2\b\006\t3\bH@\028\b23[6\006\bH@Em\tm\b\028<$H3\bHh\026<H@<\t@\003$2[@\028\b&@\027&$2\b&\b<@\024\b/m&\bH@=2&\028\b\016"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objUerige)
          end)
        end
      end
    })
  end
end
function zKIT:OnEnter()
  if objSenf1.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("\n\t@2H3\b&<&\028<[6\006\bH@?2[\b2\t@E\n\0291@\028$[@\f=<[6\006\bH@\028\bH@/\b<\028\bH@sm\b\006&\bH@\028\b[@s\006\b<H2\022\b&32HH\bg[@\b<H\024\b&<6\0063\b3@=2&\028\b1@<[3@=m\006g@\024\b&$\028\b@\b<H\b@`2[[3\bgg2H\024@4g$[[<[6\006\b&@a\b&4\b\\\\@C\027s(C\027s(a<\b@\f\\\027\\@\028<\b[\b[@)3<ggg\b/\bH@\t<3@\b6\0063@w2\b[[\bg\028m&\022\b&@?m[3\b&3{"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _HMdUi("w\b&@`\027\027@)\bH\022@XH$6\006@[\b<H\b\t@n&\022<H\028\b&@`\028$\t@\027\b&H\006$&\028@\027\b&\024&$3\006y@<H@\028\b&@?<33\b\\"),
            Media = objSenf,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.RunDialogs(function()
                  Wherigo.GetInput(objSenf1)
                end)
              end
            end
          })
        end
      end
    })
  end
end
function zKIT:OnExit()
  if tQuiz.Complete == false and vAntworten >= 6 then
    tQuiz.Complete = true
    vAufgaben = vAufgaben + 1
  end
  if vAufgaben >= 4 then
    _Urwigo.MessageBox({
      Text = (((_HMdUi("\003\b&\fg<6\006\bH@\021g2\b64=2H[6\0061@\n\006&@\006$/3@$gg\b@`2\022\024$/\bH@\b&g\b\028<\02435C\027s(C\027s(`2[[\b&\028\b\t@\006$/3@\n\006&@") .. vAntworten) .. _HMdUi("@ImH@x@t&$\024\bH@/\b$H3=m&3\b3@\t<3@")) .. vScore) .. _HMdUi("@ImH@\005S@\tm\b\024g<6\006\bH@\0042H43\bH5C\027s(C\027s(w<\b@\002$6\006\b\fmH\b@<[3@j\b3\f3@$43<I1@\006mg3@\n\006H@n26\0065C\027s(C\027s(8H\028@\n\006&@\006$/3@\b<H@H\b2\b[@\n3\b\t@\b&\006$g3\bH1@\t<3@\028\b\t@\n\006&@\028\bH@a\006\b&<\024m@/\b\bH\028\bH@4m\bHH35C\027s("),
      Media = objHurra,
      Callback = function(action)
        if action ~= nil then
          zCache.Active = true
          objBeendetdenWherigo.Visible = true
          MyUpdateZones(100)
          MyShowStatus()
          objDusseldorp:RequestSync()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _HMdUi("\n\006&@[\b<\028@$\t@nH\028\b@\028\b[@&\b6\0063[&\006\b<H<[6\006\bH@\029\b<g[@\028\b[@OH/[u%a\006\b&<\024m[@$H\024\bg$H\02431@\b[@\022\b\006g3@$/\b&@Hm6\006@=$[\\C\027s(C\027s()m@\022<H\028\b3@\n\006&@\028\bH@\002$6\006\b@H<6\0063\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.OldDialog({
            {
              Text = _HMdUi("\n\006&@[mgg3\b3@\028\bH@\1272H\024\bH@$\t@\027&2HH\bH@\f2\t@s$\028[6\006g$\024\bH@/&<H\024\bH\\\\\\")
            },
            {
              Text = _HMdUi("\\\\\\\028$[@:\022\bH&m\006&@\022<H\028\bH\\\\\\")
            },
            {
              Text = _HMdUi("\\\\\\\028<\b@E$[3$H<\bH$gg\b\b@2\t/\bH\bHH\bH\\\\\\")
            },
            {
              Text = _HMdUi("2H\028@\t<H\028\b[3\bH[@\017@t&$\024\bH@/\b$H3=m&3\bH\\C\027s(C\027s(\027\bIm&@\n\006&@<H@s<6\00632H\024@s\006\b<H4H<\b/&2\b64\b@\024\b\0063{@C\027s(C\027s(n&g\b\028<\02431@=$[@Hm6\006@\022\b\006g3@2H\028@4m\t\t3@\028$HH@=<\b\028\b&@\006<\b&@$\t@E\n\029@Im&/\b<\\")
            }
          })
        end
      end
    })
  end
end
function zStadtmuseum:OnExit()
  if iMaria.Visible then
    Wherigo.PlayAudio(objWWM)
    _Urwigo.MessageBox({
      Text = _HMdUi("\n\t@\004$g$<[@)u\b\b@/\b\022<H\028\b3@[<6\006@\028$[@)3$\0283\t2[\b2\t\\@\003<\b&@<[3@\028$[@\021\b\028$\b6\0063H<[@\028\b&@)3$\0283@2H3\b&\024\b/&$6\0063\\@n<H@\027\b[26\006@gm\006H3@[<6\006\\\\C\027s(C\027s(n<H\b@t&$2@<H@$g3\tm\028<[6\006\b&@Eg\b<\0282H\024@[3\b\0063@Im&@n26\006\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _HMdUi("\r\n6\006@/<H@\028<\b@g\b3\f3\b@\t\b<H\b&@t$\t<g<\b1@\t\b<H@?$HH@=$&@\028\b&@d<\b/g<H\024[\0222\b&[3@\b2&\b&@)3$\0283\\\\"),
            Media = objMaria,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.RunDialogs(function()
                  Wherigo.GetInput(iMaria)
                end)
              end
            end
          })
        end
      end
    })
  end
end
function zCache:OnEnter()
  _Urwigo.MessageBox({
    Text = _HMdUi("w<\b@\024\bH$2\bH@t<H$g4mm&\028<H$3\bH@g$23\bH{C\027s(C\027s(9@\005U@U\019\\\017\015\015@n@SS\017@G\005\\\017\015xC\027s(C\027s(\027$2\t@H\b/\bH@\004$u<\b&4m&/1@\006<H3\b&@\028\b\t@\0272\b&\024\b&[3\b<\0241@<H@6$\\@U\\xS\t@\003m\006\b\\@n<H@\004\b3g<H\0241@\022\b[3\024\b/2H\028\bH\\C\027s(C\027s(w\bH43@$H@\028$[@\n3\b\t@\r\027\b\bH\028\b3@\028\bH@a\006\b&<\024m\r@<H@\b2&\b\t@s264[$645")
  })
end
function objRheinische:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("\004gm3\fg<6\006@[u&<6\0063@n26\006@\028\b&@\b3=$[@I\b&=<&&3\b@?$HH@$H{@C\027s(C\027s(\rw$[@=$&@\b<H@3mgg\b[@EmH\f\b&31@\028$[@<6\006@\024\b&$\028\b@\024\b\006m\b&3@\006$/\b\\@w<\b@)R\tu\006mH<4\b&@\006$/\bH@\t\b<H\b@\rs\006\b<H<[6\006\b\r@\024\b[u<\bg3\\@?$H@[$\0243\b@\t<&1@\028$[@d\b<33\006\b\t$@\028\b[@\b&[3\bH@)$3\f\b[@=$\b&\b@[m\024$&@\0222\b&@\b<H\b@t\b&H[\b\006[\bH\0282H\024@I\b&=\bH\028\b3@=m&\028\bH\\\\\rC\027s(C\027s(:\006H\b@\b<H\b@`H3=m&3@$/\f2=$&3\bH@\024\b\0063@\b&@=\b<3\b&@s<6\00632H\024@:/\b&4$[[\bg\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objRheinische)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 19457 then
      vScore = vScore + 5
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(\127\b3\f3@\024\b\006\bH@=<&@\b&[3@\t$g@<H@\028<\b@`g3[3$\0283\\"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          objRheinische.Visible = false
          MyShowStatus()
          MyUpdateZones(20)
          objDusseldorp:RequestSync()
          if not Player:Contains(objeenePenning) then
            _Urwigo.MessageBox({
              Text = _HMdUi("7mH@\028\b&@?<33\b@\028\b&@\027&2\b64\b@\006m\b&3@\n\006&@\028\bH@Em\tumH<[3\bH@&2\022\bH{C\027s(C\027s(\r\003<\b&@\006$/3@\n\006&@Hm6\006@\b3=$[@I\b&\024\b[[\bH5@Em\t\t3@Hm6\006\t$g@42&\f@\f2&2\b645\r"),
              Media = objRobertSchumann
            })
          end
        end
      end
    })
  end
end
function objGrossherzog:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("w\b&@E\b&g@$2\022@\028\b\t@\004\022\b&\028@=$&@j$@[6\006mH@4m\t<[6\0061@m\028\b&\016C\027s(C\027s(`/\b&@j$1@w2\b[[\bg\028m&\022@[3$H\028@j$@=<&4g<6\006@\t$g@2H3\b&@\022&$H\fm\b[<[6\006\b&@\003\b&&[6\006$\02231@\028$@\024$/@\b[@\028m6\006@\028<\b[\bH@)6\006=$\024\b&@ImH@9$umg\bmH\\\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objGrossherzog)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 32674 then
      vScore = vScore + 5
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(8H\028@=\b<3\b&@\024\b\0063Y[\\\\@m\0061@\028$[@\004\022\b&\028@\028\b[@\021&m[[\006\b&\fm\024[@\006$3@\006<\b&@=m\006g@\b3=$[@\006<H3\b&g$[[\bH5"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _HMdUi("\027$\0061@\004\022\b&\028\b$\bu\022\bg\\@`/\b&@\028$[@\006<\b&@<[3@\b<H@`\028I\bH32&\b@\026@$g[m@$gg\b[@\t<3H\b\006\t\bH\\C\027s(C\027s(\n\006&@u$643@\028$[@w<H\024@XIm&[<6\0063<\024y@\b<H@\026@I<\bgg\b<6\0063@\022<H\028\b3@[<6\006@\b<H\b@\021\bg\b\024\bH\006\b<31@\b[@=<\b\028\b&@gm[\f2=\b&\028\bH\\\\"),
            Media = objPferdeapfel,
            Callback = function(action)
              if action ~= nil then
                vAntworten = vAntworten + 1
                objGrossherzog.Visible = false
                objPferdeapfel1:MoveTo(Player)
                MyShowStatus()
                MyUpdateZones(30)
                objDusseldorp:RequestSync()
              end
            end
          })
        end
      end
    })
  end
end
function objHeinrichHeine:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi(")$\0243@\t$g1@=$&@\028\b&@\1272H\024\b@$2\022@\028\b&@)3$32\b@\b3=$@\003\b<H\b\016@a<&@\024g$2/\bH@[6\006mH1@\b&[3@H$6\006@[\b<H\b&@\029$2\022\b@\024$/@\b&@[<6\006@j$@[\b<H\bH@/\b4$HH3\bH@7m&H$\t\bH\\@?<3@9$\t\bH@\006$3@\b&@\b[@j$@\b\0061@\028\b&@\006$33\b@\028m6\006@$26\006@[m@\b<H@\t\b&4=2\b&\028<\024\b[@\004[\b2\028mHR\t\\\\\r"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objHeinrichHeine)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 42355 then
      vScore = vScore + 10
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(n&42H\028\bH@=<&@=\b<3\b&@\028<\b@`g3[3$\02835"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          objHeinrichHeine.Visible = false
          MyShowStatus()
          MyUpdateZones(40)
          objDusseldorp:RequestSync()
        end
      end
    })
  end
end
function objNationalversammlung:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("am@=<&@\024\b&$\028\b@<\t@\127$\006&\b@UxGx@=$&\bH\\\\C\027s(C\027s($g[@n&\024\b/H<[@\028\b&@?$\b&\f&\bImg23<mH@3&$\022@<H@\028<\b[\b\t@\127$\006&@$26\006@\f2\t@\b&[3\bH@?$g@\028<\b@9$3<mH$gI\b&[$\t\tg2H\024@\f2[$\t\t\bH1@\028\b&\bH@\b&$&/\b<3\b3\b@7\b&\022$[[2H\024@\f2@=\b[\bH3g<6\006\bH@\029\b<g\bH@$26\006@Hm6\006@<\t@\021&2H\028\024\b[\b3\f@\f2@\022<H\028\bH@<[3@\026@=m@=$&@\028$[@\028m6\006@\024g\b<6\006\016"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objNationalversammlung)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 38809 then
      vScore = vScore + 5
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(8H\028@=\b<3\b&@\024\b\0063Y[\\\\@"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          objNationalversammlung.Visible = false
          MyShowStatus()
          MyUpdateZones(50)
          objDusseldorp:RequestSync()
          if tRohr.Complete then
          else
            _Urwigo.MessageBox({
              Text = _HMdUi("\n\006&@\006$/3@\028$[@:\022\bH&m\006&@Hm6\006@H<6\0063@\024\b\0222H\028\bH\\\\\\@/\bIm&@\n\006&@=\b<3\b&@H$6\006@)2\b\028\bH@<H@s<6\00632H\024@)3$\0283\t2[\b2\t@g$2\02231@[mgg3\b3@\n\006&@\028$[@\b&[3@\b&g\b\028<\024\bH5")
            })
          end
        end
      end
    })
  end
end
function objKuenstler:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("\127$1@j$@\028<\b@w2\b[[\bg\028m&\022\b&@E2H[3$4$\028\b\t<\b@<[3@=\bg3/\b&2\b\006\t3\\@)m@I<\bg\b@E2\bH[3g\b&@=$&\bH@[6\006mH@\006<\b&\\\\@$/\b&@H$32\b&g<6\006@H<6\0063@$gg\b\\"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objKuenstler)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 40803 then
      vScore = vScore + 5
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(8H\028@=\b<3\b&@\024\b\0063Y[\\\\@"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          objKuenstler.Visible = false
          vAntworten = vAntworten + 1
          MyShowStatus()
          MyUpdateZones(60)
          objDusseldorp:RequestSync()
        end
      end
    })
  end
end
function objUerige:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("\\\\\\@2H\0281@\006$3@\b[@\024\b[6\006\t\b643\016C\027s(C\027s(a2[[3\b3@\n\006&1@\028$[[@\028\b&@7$3\b&@\b<H\b[@/\b&2\b\006\t3\bH@\028\b23[6\006\bH@Em\tm\b\028<$H3\bHh\026<H@<\t@\003$2[@\028\b&@\027&$2\b&\b<@\024\b/m&\bH@=2&\028\b\016"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objUerige)
          end)
        end
      end
    })
  else
    if _Urwigo.Hash(string.lower(input)) == 56303 then
      vScore = vScore + 5
    else
      vScore = vScore + -1
    end
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(n&42H\028\bH@=<&@=\b<3\b&@\028<\b@`g3[3$\02835"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          objUerige.Visible = false
          MyShowStatus()
          MyUpdateZones(70)
          objDusseldorp:RequestSync()
        end
      end
    })
  end
end
function objSenf1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 40151 then
    vScore = vScore + 5
  else
    vScore = vScore + -1
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("w\b&@`\027\027@)\bH\022@XH$6\006@[\b<H\b\t@n&\022<H\028\b&@`\028$\t@\027\b&H\006$&\028@\027\b&\024&$3\006y@<H@\028\b&@?<33\b\\"),
      Media = objSenf,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objSenf1)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(8H\028@=\b<3\b&@\024\b\0063Y[\\\\@"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          objSenf1.Visible = false
          MyShowStatus()
          MyUpdateZones(90)
          objDusseldorp:RequestSync()
        end
      end
    })
  end
end
function iMaria:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 40539 then
    vScore = vScore + 10
  else
    vScore = vScore + -1
  end
  if _Urwigo.Hash(string.lower(input)) == 0 then
    _Urwigo.MessageBox({
      Text = _HMdUi("\r\n6\006@/<H@\028<\b@g\b3\f3\b@\t\b<H\b&@t$\t<g<\b1@\t\b<H@?$HH@=$&@\028\b&@d<\b/g<H\024[\0222\b&[3@\b2&\b&@)3$\0283\\\\"),
      Media = objMaria,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(iMaria)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _HMdUi(":/@\028$[@[3<\t\t31@\b&\022$\006&3@\n\006&@$\t@)6\006g2[[\\\\C\027s(C\027s(n&42H\028\bH@=<&@=\b<3\b&@\028<\b@`g3[3$\02835"),
      Media = objFragezeichen,
      Callback = function(action)
        if action ~= nil then
          vAntworten = vAntworten + 1
          MyShowStatus()
          MyUpdateZones(80)
          objDusseldorp:RequestSync()
        end
      end
    })
  end
end
function objFinalfrage:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _HMdUi("t$g[6\0065")
    })
    return
  end
  if input == 6976 then
    objDusseldorp.Complete = true
    _Urwigo.MessageBox({
      Text = _HMdUi("\0032&&$5@a\006\b&<\024m@\002:?\004dn\029nw5C\027s(C\027s(w\b&@8Hgm646m\028\b@<[3{@") .. string.sub(Player.CompletionCode, 1, 15),
      Media = objHurra,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _HMdUi("w<\b@`H3=m&3\bH@\0222\b&@\028$[@;2<\f@\022<H\028\b3@\n\006&@2H3\b&C\027s(C\027s(@OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%OH/[u%\00633u{hh\028/\\33h.ma4\0068`"),
            Media = objFragezeichen,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _HMdUi("t$g[6\0065")
    })
  end
end
function objeenePenning:OncmdNehmen(target)
  if zOberkasselerBruecke:Contains(objeenePenning) then
    objeenePenning:MoveTo(Player)
  end
  objeenePenning.Commands.cmdNehmen.Enabled = false
  objeenePenning.Commands.cmdGeben.Enabled = true
  MyUpdateZones(10)
  _Urwigo.MessageBox({
    Text = _HMdUi("a\b&@=\b<[[1@=m\0222\b&@\028\b&@Hm6\006@\02423@<[3\\\\@\024\b\006\bH@=<&@=\b<3\b&\\"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objeenePenning:OncmdGeben(target)
  if zRadschlaegerbrunnen:Contains(Player) then
    objeenePenning:MoveTo(objEinJunge)
    objFotoKind:MoveTo(Player)
    tKindskopf.Complete = true
    vAufgaben = vAufgaben + 1
    zRadschlaegerbrunnen.Active = false
    MyShowStatus()
    _Urwigo.MessageBox({
      Text = _HMdUi("\r\022m\b&@\b\bH\b@\004\bHH<H\024\r1@&2\0223@\028\b&@Eg\b<H\b@2H\028@[6\006$\0243@Im&@n2&\bH@`2\024\bH@\t\b\006&\t$g[@\b<H@s$\028\\C\027s(C\027s(w2@\t$6\006[3@[m\022m&3@\b<H@tm3m@\028$ImH\\"),
      Media = objRadschlaeger,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _HMdUi("9<\b\t$H\028@=<gg@\028$[@w<H\024@\006$/\bH\\"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objSofortbildkamera:OncmdFotomachen(target)
  if zKommoedchen:Contains(Player) then
    _Urwigo.Dialog(false, {
      {
        Text = _HMdUi("9$@$g[m1@\027\b2R[@:\022\bH&m\006&@\024\b\0222H\028\bH\\@Eg<645C\027s("),
        Media = objRohr
      }
    }, function(action)
      tRohr.Complete = true
      objKuenstler.Visible = true
      vAufgaben = vAufgaben + 1
      MyShowStatus()
      objFotoOfenrohr:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _HMdUi("?$\024@[\b<H1@\028$[@\b[@\006<\b&@\b<H@[6\006m\bH\b[@?m3<I@\024</3@\026@$/\b&@4\b<H@)u<\bg&\bg\bI$H3\b[1@[m&&R\\"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objBeendetdenWherigo:OncmdFinalfrage(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objFinalfrage)
  end)
end
function MyShowStatus()
  if vAntworten > 8 then
    vAntworten = 8
  end
  if vAufgaben > 4 then
    vAufgaben = 4
  end
  if vScore > 50 then
    vScore = 50
  end
  if vScore < 0 then
    vScore = 0
  end
  if vAntworten >= 6 and tQuiz.Complete == false then
    tQuiz.Complete = true
    vAufgaben = vAufgaben + 1
  end
  Wherigo.ShowStatusText(" Aufgaben: " .. vAufgaben .. "/4 " .. " Quiz: " .. vAntworten .. "/8 ")
end
function MyUpdateZones(vReason)
  if vReason == 10 then
    zOberkasselerBruecke.Active = false
    zAltestadt.Active = true
  elseif vReason == 20 then
    zTonhalle.Active = false
    zAltestadt.Active = true
    zRadschlaegerbrunnen.Active = true
    zKommoedchen.Active = true
  elseif vReason == 30 then
    zAltestadt.Active = false
    zKastanienallee.Active = true
  elseif vReason == 40 then
    zJanWellem.Active = false
  elseif vReason == 50 then
    zKastanienallee.Active = false
    zStadtmuseum.Active = true
    zKIT.Active = true
  elseif vReason == 60 then
    zUerige.Active = true
  elseif vReason == 70 then
    zUerige.Active = false
    zKIT.Active = true
    zStadtmuseum.Active = true
  elseif vReason == 80 then
    zStadtmuseum.Active = false
  elseif vReason == 90 then
    if iMaria.Display == false then
      zStadtmuseum.Active = false
    end
    zRheinkniebruecke.Active = true
  elseif vReason == 100 and zCache.Active == true then
    zKIT.Active = false
  end
end
return objDusseldorp
