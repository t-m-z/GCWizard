require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _zrkGT(str)
  local res = ""
  local dtable = "sd\002\0182\\_R`\003z4#?,=M\023'\021A-l!\tP{*)aV]\"\027}\000x\024&w\0297\019O.XnT\005fj:NE9rC35vY|\030\028\025\006m0i\bo\017Gy$gD1\f\022HF\015u^\014K\a JS\0316U\020<Z\n\rc[%\026I\vqp+W>h\001L@b\004/;QBt8(ek\016~"
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
_Urwigo.InlineModuleFunc = {
  [0] = function()
    local last_pos = ZonePoint(0, 0, 0)
    function store_current_position()
      last_pos = Player.ObjectLocation
    end
    function get_gps_accuracy()
      local pos_acc = Player.PositionAccuracy
      local gps_acc = pos_acc:GetValue("m")
      return gps_acc
    end
    function walked_distance()
      local d, b = Wherigo.VectorToPoint(last_pos, Player.ObjectLocation)
      local dn = d:GetValue("m")
      local gps_acc = get_gps_accuracy()
      if dn > 2 * gps_acc then
        store_current_position()
        return dn
      end
      return 0
    end
  end
}
objKlausMastermindKlabuster = Wherigo.ZCartridge()
objFinal = Wherigo.ZMedia(objKlausMastermindKlabuster)
objFinal.Id = "8f1b9416-d3a0-4440-aca2-c940ba58891b"
objFinal.Name = "Final"
objFinal.Description = ""
objFinal.AltText = ""
objFinal.Resources = {
  {
    Type = "jpg",
    Filename = "final.jpg",
    Directives = {}
  }
}
objicoFinal = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoFinal.Id = "e6fece3f-c58b-4dd4-b072-30494ac89da2"
objicoFinal.Name = "ico-Final"
objicoFinal.Description = ""
objicoFinal.AltText = ""
objicoFinal.Resources = {
  {
    Type = "jpg",
    Filename = "ico-final.jpg",
    Directives = {}
  }
}
objGrundbuch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objGrundbuch.Id = "a55799bc-6731-4993-8ca3-3a188f1acc52"
objGrundbuch.Name = "Grundbuch"
objGrundbuch.Description = ""
objGrundbuch.AltText = ""
objGrundbuch.Resources = {
  {
    Type = "jpg",
    Filename = "grundbuch.jpg",
    Directives = {}
  }
}
objicoGrundbuch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoGrundbuch.Id = "7a35923b-bb77-463d-85f4-478e1493188a"
objicoGrundbuch.Name = "ico-Grundbuch"
objicoGrundbuch.Description = ""
objicoGrundbuch.AltText = ""
objicoGrundbuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-grundbuch.jpg",
    Directives = {}
  }
}
objKlaus = Wherigo.ZMedia(objKlausMastermindKlabuster)
objKlaus.Id = "4bee268b-e6f1-4fc5-9b5a-a775d1d0785b"
objKlaus.Name = "Klaus"
objKlaus.Description = ""
objKlaus.AltText = ""
objKlaus.Resources = {
  {
    Type = "jpg",
    Filename = "Klaus.jpg",
    Directives = {}
  }
}
objicoKlaus = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoKlaus.Id = "5022e2fb-d680-4a7d-aa98-7a8b36c09b84"
objicoKlaus.Name = "ico-Klaus"
objicoKlaus.Description = ""
objicoKlaus.AltText = ""
objicoKlaus.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Klaus.jpg",
    Directives = {}
  }
}
objNotizbuch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objNotizbuch.Id = "5ddb1f48-9de4-47a4-9d8a-50c271cc9a83"
objNotizbuch.Name = "Notizbuch"
objNotizbuch.Description = ""
objNotizbuch.AltText = ""
objNotizbuch.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch.jpg",
    Directives = {}
  }
}
objicoNotizbuch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoNotizbuch.Id = "bff47128-24b7-48c8-b0d3-3ea5379f74b8"
objicoNotizbuch.Name = "ico-Notizbuch"
objicoNotizbuch.Description = ""
objicoNotizbuch.AltText = ""
objicoNotizbuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Notizbuch.jpg",
    Directives = {}
  }
}
objKoordinaten = Wherigo.ZMedia(objKlausMastermindKlabuster)
objKoordinaten.Id = "66fbc424-f937-46a1-ba67-b1cf0dadf017"
objKoordinaten.Name = "Koordinaten"
objKoordinaten.Description = ""
objKoordinaten.AltText = ""
objKoordinaten.Resources = {
  {
    Type = "jpg",
    Filename = "koordinaten.jpg",
    Directives = {}
  }
}
objicoKoordinaten = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoKoordinaten.Id = "83f12fe5-14cf-446e-9028-7e5651fe6086"
objicoKoordinaten.Name = "ico-Koordinaten"
objicoKoordinaten.Description = ""
objicoKoordinaten.AltText = ""
objicoKoordinaten.Resources = {
  {
    Type = "jpg",
    Filename = "ico-koordinaten.jpg",
    Directives = {}
  }
}
objTitel = Wherigo.ZMedia(objKlausMastermindKlabuster)
objTitel.Id = "8129dc96-2532-4997-9015-3d7a7dc886d2"
objTitel.Name = "Titel"
objTitel.Description = ""
objTitel.AltText = ""
objTitel.Resources = {
  {
    Type = "jpg",
    Filename = "mastermind.jpg",
    Directives = {}
  }
}
objicoTitel = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoTitel.Id = "7f0149dd-09f6-429d-87a7-b9094f1292f4"
objicoTitel.Name = "ico-Titel"
objicoTitel.Description = ""
objicoTitel.AltText = ""
objicoTitel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-mastermind.jpg",
    Directives = {}
  }
}
objbeep = Wherigo.ZMedia(objKlausMastermindKlabuster)
objbeep.Id = "9b5206ba-e4f7-4c94-9dd7-7452d763b163"
objbeep.Name = "beep"
objbeep.Description = ""
objbeep.AltText = ""
objbeep.Resources = {
  {
    Type = "mp3",
    Filename = "beep.mp3",
    Directives = {}
  }
}
objtusch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objtusch.Id = "a7ededd2-7df3-46b8-9baa-e5c76e6fcf16"
objtusch.Name = "tusch"
objtusch.Description = ""
objtusch.AltText = ""
objtusch.Resources = {
  {
    Type = "mp3",
    Filename = "tusch.mp3",
    Directives = {}
  }
}
objSpielfeld = Wherigo.ZMedia(objKlausMastermindKlabuster)
objSpielfeld.Id = "c2263fee-51e8-424d-a923-9fc7b4954e24"
objSpielfeld.Name = "Spielfeld"
objSpielfeld.Description = ""
objSpielfeld.AltText = ""
objSpielfeld.Resources = {
  {
    Type = "jpg",
    Filename = "Spielfeld.jpg",
    Directives = {}
  }
}
objicoSpielfeld = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoSpielfeld.Id = "699b0231-7f29-49aa-b59d-3d99d5d2970a"
objicoSpielfeld.Name = "ico-Spielfeld"
objicoSpielfeld.Description = ""
objicoSpielfeld.AltText = ""
objicoSpielfeld.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Spielfeld.jpg",
    Directives = {}
  }
}
objStrickanleitung = Wherigo.ZMedia(objKlausMastermindKlabuster)
objStrickanleitung.Id = "07a1f242-e656-4ee4-90c0-859b452f29ab"
objStrickanleitung.Name = "Strickanleitung"
objStrickanleitung.Description = ""
objStrickanleitung.AltText = ""
objStrickanleitung.Resources = {
  {
    Type = "jpg",
    Filename = "Stricken.jpg",
    Directives = {}
  }
}
objicoStrickanleitung = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicoStrickanleitung.Id = "c696dcac-0f08-4351-811b-df92ee910cf4"
objicoStrickanleitung.Name = "ico-Strickanleitung"
objicoStrickanleitung.Description = ""
objicoStrickanleitung.AltText = ""
objicoStrickanleitung.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Stricken.jpg",
    Directives = {}
  }
}
objschade = Wherigo.ZMedia(objKlausMastermindKlabuster)
objschade.Id = "5c917fcf-b42f-4d7c-a5b5-8913070abb94"
objschade.Name = "schade"
objschade.Description = ""
objschade.AltText = ""
objschade.Resources = {
  {
    Type = "mp3",
    Filename = "schade.mp3",
    Directives = {}
  }
}
objSpoiler = Wherigo.ZMedia(objKlausMastermindKlabuster)
objSpoiler.Id = "5d5d2ed7-743f-4d83-92eb-48b1579b77ea"
objSpoiler.Name = "Spoiler"
objSpoiler.Description = ""
objSpoiler.AltText = ""
objSpoiler.Resources = {
  {
    Type = "jpg",
    Filename = "spoiler.jpg",
    Directives = {}
  }
}
objicospoiler = Wherigo.ZMedia(objKlausMastermindKlabuster)
objicospoiler.Id = "233c2988-a38c-4ca5-8ddf-fe8fcc2ffb86"
objicospoiler.Name = "ico-spoiler"
objicospoiler.Description = ""
objicospoiler.AltText = ""
objicospoiler.Resources = {
  {
    Type = "jpg",
    Filename = "ico-spoiler.jpg",
    Directives = {}
  }
}
objgarminBeep = Wherigo.ZMedia(objKlausMastermindKlabuster)
objgarminBeep.Id = "f9c1c8d4-c1c5-464c-885a-586e4816857b"
objgarminBeep.Name = "garminBeep"
objgarminBeep.Description = ""
objgarminBeep.AltText = ""
objgarminBeep.Resources = {
  {
    Type = "fdl",
    Filename = "quickalert.fdl",
    Directives = {}
  }
}
objgarminTusch = Wherigo.ZMedia(objKlausMastermindKlabuster)
objgarminTusch.Id = "2ccf8fa3-a07d-4338-8cbc-61f84dd3830d"
objgarminTusch.Name = "garminTusch"
objgarminTusch.Description = ""
objgarminTusch.AltText = ""
objgarminTusch.Resources = {
  {
    Type = "fdl",
    Filename = "IndianaJones.fdl",
    Directives = {}
  }
}
objgarminSchade = Wherigo.ZMedia(objKlausMastermindKlabuster)
objgarminSchade.Id = "a588cf5e-af27-4a85-a946-cfe27e7ec56e"
objgarminSchade.Name = "garminSchade"
objgarminSchade.Description = ""
objgarminSchade.AltText = ""
objgarminSchade.Resources = {
  {
    Type = "fdl",
    Filename = "phaser.fdl",
    Directives = {}
  }
}
objKlausMastermindKlabuster.Id = "af1681ad-5533-43f2-8640-0299cbb1f764"
objKlausMastermindKlabuster.Name = "Klaus Mastermind Klabuster"
objKlausMastermindKlabuster.Description = [[
Nun denn, wenn Du zum Spielen bereit bist, wird sich Klaus eine 4-stellige Zahlenkombination aus 6 Zahlen ausdenken, die Du in 5 Versuchen erraten musst. Wenn nicht - bist Du kein Mastermind.<BR>
<BR>
Die Regeln sind einfach.<BR>
- Der Code ist 4-stellig.<BR>
- Es gibt 6 verschiedene Zahlen.<BR>
- Zahlen koennen auch mehrfach vorkommen.<BR>
- Du musst den Coden in moeglichst wenig Versuchen herausfinden. <BR>
<BR>
Nach jeder Runde sagt Dir Klaus, wie viele Stellen Du in Ziffer und Position richtig gesetzt hast und wie viele Stellen zwar die richtige Ziffer haben, aber an einer falschen Position stehen. <BR>
Alle Fragen und Antworten bleiben bis zum Ende des Spiels sichtbar.<BR>
<BR>
Zum Starten nimmst Du aus Deinem Inventory das Mastermind-Spiel und startest es. Nach dem Start musst Du ca. 50m laufen, bis die erste Zahl eingegeben werden muss.<BR>
Damit Du Zeit zum Nachdenken hast, musst Du zwischen jeder Eingabe etwas laufen - so ca. 50m.<BR>
<BR>
Donald E. Knuth hat uebrigens bereits 1976 bewiesen, dass dies in maximal 5 Ver]]
objKlausMastermindKlabuster.Visible = true
objKlausMastermindKlabuster.Activity = "Puzzle"
objKlausMastermindKlabuster.StartingLocationDescription = "Es ist eine Walk &amp; Play Anywhere Cartridge. Sucht Euch zum Start eine moeglichst lange und gerade Strasse."
objKlausMastermindKlabuster.StartingLocation = Wherigo.INVALID_ZONEPOINT
objKlausMastermindKlabuster.Version = "4.3"
objKlausMastermindKlabuster.Company = ""
objKlausMastermindKlabuster.Author = "tmz"
objKlausMastermindKlabuster.BuilderVersion = "URWIGO 1.21.5528.18461"
objKlausMastermindKlabuster.CreateDate = "04/19/2012 19:13:38"
objKlausMastermindKlabuster.PublishDate = "1/1/0001 12:00:00 AM"
objKlausMastermindKlabuster.UpdateDate = "10/14/2015 18:01:58"
objKlausMastermindKlabuster.LastPlayedDate = "1/1/0001 12:00:00 AM"
objKlausMastermindKlabuster.TargetDevice = "PocketPC"
objKlausMastermindKlabuster.TargetDeviceVersion = "0"
objKlausMastermindKlabuster.StateId = "1"
objKlausMastermindKlabuster.CountryId = "2"
objKlausMastermindKlabuster.Complete = false
objKlausMastermindKlabuster.UseLogging = true
objKlausMastermindKlabuster.Media = objTitel
objKlausMastermindKlabuster.Icon = objicoTitel
objFinal1 = Wherigo.Zone(objKlausMastermindKlabuster)
objFinal1.Id = "575abfa1-4b5c-47f9-9581-0a3e497ca2be"
objFinal1.Name = "Final"
objFinal1.Description = "Der Stuhl der Champions."
objFinal1.Visible = false
objFinal1.Media = objFinal
objFinal1.Icon = objicoFinal
objFinal1.Commands = {}
objFinal1.DistanceRange = Distance(-1, "feet")
objFinal1.ShowObjects = "OnEnter"
objFinal1.ProximityRange = Distance(60, "meters")
objFinal1.AllowSetPositionTo = false
objFinal1.Active = true
objFinal1.Points = {
  ZonePoint(52.46164, 13.11985, 0),
  ZonePoint(52.46164, 13.11999, 0),
  ZonePoint(52.4615, 13.11999, 0),
  ZonePoint(52.4615, 13.11985, 0)
}
objFinal1.OriginalPoint = ZonePoint(52.46157, 13.11992, 0)
objFinal1.DistanceRangeUOM = "Feet"
objFinal1.ProximityRangeUOM = "Meters"
objFinal1.OutOfRangeName = ""
objFinal1.InRangeName = ""
board = Wherigo.Zone(objKlausMastermindKlabuster)
board.Id = "bbe8913e-8b76-46c3-9c03-e094b5c019e4"
board.Name = "Spielfeld"
board.Description = "Die ganze Welt ist Dein Spielfeld. Und doch wuerde ich Kladow vorziehen."
board.Visible = false
board.Media = objSpielfeld
board.Icon = objicoSpielfeld
board.Commands = {}
board.DistanceRange = Distance(-1, "feet")
board.ShowObjects = "OnEnter"
board.ProximityRange = Distance(60, "meters")
board.AllowSetPositionTo = false
board.Active = true
board.Points = {
  ZonePoint(52.4620999265143, 13.1231067868456, 0),
  ZonePoint(52.46192, 13.12318, 0),
  ZonePoint(52.4619668383105, 13.1228628589529, 0)
}
board.OriginalPoint = ZonePoint(52.4619955882749, 13.1230498819328, 0)
board.DistanceRangeUOM = "Feet"
board.ProximityRangeUOM = "Meters"
board.OutOfRangeName = ""
board.InRangeName = ""
objKoordinaten1 = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objKoordinaten1.Id = "108bb64b-efa5-4bf5-a915-b6a5cac121e0"
objKoordinaten1.Name = "Koordinaten"
objKoordinaten1.Description = "N 52 27,694 &nbsp;&nbsp;E 13 07,195"
objKoordinaten1.Visible = false
objKoordinaten1.Media = objKoordinaten
objKoordinaten1.Icon = objicoKoordinaten
objKoordinaten1.Commands = {}
objKoordinaten1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKoordinaten1.Locked = false
objKoordinaten1.Opened = false
objFreischaltcode = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objFreischaltcode.Id = "9274aa4d-a341-47e6-9378-a94003c868b4"
objFreischaltcode.Name = "Freischaltcode"
objFreischaltcode.Description = ""
objFreischaltcode.Visible = false
objFreischaltcode.Media = objNotizbuch
objFreischaltcode.Icon = objicoNotizbuch
objFreischaltcode.Commands = {}
objFreischaltcode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFreischaltcode.Locked = false
objFreischaltcode.Opened = false
objAnleitung = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objAnleitung.Id = "17d55c55-4ce9-4701-8ffd-043d9d495de1"
objAnleitung.Name = "Anleitung"
objAnleitung.Description = [[
Die Regeln sind einfach.<BR>
- Der Code ist 4-stellig.<BR>
- Es gibt 6 verschiedene Zahlen von 1 - 6.<BR>
- Zahlen koennen auch mehrfach vorkommen.<BR>
<BR>
Du musst den Code in moeglichst wenig Versuchen herausfinden.<BR>
<BR>
Donald E. Knuth hat uebrigens bereits 1976 bewiesen, dass dies in maximal 5 Versuchen moeglich ist! Also streng Dich an.<BR>
]]
objAnleitung.Visible = true
objAnleitung.Media = objNotizbuch
objAnleitung.Icon = objicoNotizbuch
objAnleitung.Commands = {
  cmdDetails = Wherigo.ZCommand({
    Text = "Details",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objAnleitung.Commands.cmdDetails.Custom = true
objAnleitung.Commands.cmdDetails.Id = "56a8f076-3e04-41a4-b8bb-e55724f4e766"
objAnleitung.Commands.cmdDetails.WorksWithAll = true
objAnleitung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAnleitung.Locked = false
objAnleitung.Opened = false
objSpielstand = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objSpielstand.Id = "46d59ac6-07a4-42b2-871b-f9d95048b2b9"
objSpielstand.Name = "Spielstand"
objSpielstand.Description = ""
objSpielstand.Visible = false
objSpielstand.Media = objGrundbuch
objSpielstand.Icon = objicoGrundbuch
objSpielstand.Commands = {}
objSpielstand.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpielstand.Locked = false
objSpielstand.Opened = false
objMastermind = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objMastermind.Id = "fc84ae43-701a-4eb6-ac22-d31afa7e7e88"
objMastermind.Name = "Mastermind"
objMastermind.Description = ""
objMastermind.Visible = false
objMastermind.Media = objTitel
objMastermind.Icon = objicoTitel
objMastermind.Commands = {
  cmdspielen = Wherigo.ZCommand({
    Text = "spielen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objMastermind.Commands.cmdspielen.Custom = true
objMastermind.Commands.cmdspielen.Id = "6a17f030-e736-40c7-afa0-f685365c357b"
objMastermind.Commands.cmdspielen.WorksWithAll = true
objMastermind.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMastermind.Locked = false
objMastermind.Opened = false
objStrickanleitung1 = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objStrickanleitung1.Id = "4182ed28-3959-48e0-bd63-47d74aeef442"
objStrickanleitung1.Name = "Strickanleitung"
objStrickanleitung1.Description = ""
objStrickanleitung1.Visible = true
objStrickanleitung1.Media = objStrickanleitung
objStrickanleitung1.Icon = objicoStrickanleitung
objStrickanleitung1.Commands = {}
objStrickanleitung1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objStrickanleitung1.Locked = false
objStrickanleitung1.Opened = false
objSpoiler1 = Wherigo.ZItem({Cartridge = objKlausMastermindKlabuster, Container = Player})
objSpoiler1.Id = "7cf2606b-049c-44cb-9e46-48b742f6ecb2"
objSpoiler1.Name = "Spoiler"
objSpoiler1.Description = ""
objSpoiler1.Visible = false
objSpoiler1.Media = objSpoiler
objSpoiler1.Icon = objicospoiler
objSpoiler1.Commands = {}
objSpoiler1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpoiler1.Locked = false
objSpoiler1.Opened = false
objwerdeMastermind = Wherigo.ZTask(objKlausMastermindKlabuster)
objwerdeMastermind.Id = "376fa2d8-dc30-4bb3-bc29-5998a281c1a8"
objwerdeMastermind.Name = "werde Mastermind"
objwerdeMastermind.Description = [[
Donald E. Knuth hat 1976 gezeigt, dass es moeglich ist, jeden moeglichen Farbcode des Spiels (4 Stellen, 6 Farben) in maximal fuenf Zuegen zu ermitteln.<BR>
Kenji Koyama und Tony W. Lai fanden 1994 eine Mastermind-Strategie, die im Durchschnitt nur 4,34 Versuche benoetigt.<BR>
Diese Strategie - und jede andere, die im Durchschnitt genauso schnell ist - benoetigt im schlechtesten Fall sechs Versuche.<BR>
Sie bewiesen ausserdem, dass es keine schnellere Strategie geben kann.]]
objwerdeMastermind.Visible = false
objwerdeMastermind.Media = objFinal
objwerdeMastermind.Icon = objicoFinal
objwerdeMastermind.Active = true
objwerdeMastermind.Complete = false
objwerdeMastermind.CorrectState = "None"
objGesamtstrecke = 0
objSpalte1 = false
objSpalte2 = false
objSpalte3 = false
objSpalte4 = false
objvarFeld = 0
objvarRunde = 1
objvarC1 = ""
objvarZ = 0
objvarC2 = ""
objvarP = 0
objvarC3 = ""
objvarF4 = "-"
objvarC4 = ""
objvarF3 = "-"
objvarF1 = "-"
objvarF2 = "-"
objvarT1 = "----"
objvarE3 = "- | -"
objvarE4 = "- | -"
objvarE5 = "- | -"
objvarT2 = "----"
objvarE2 = "- | -"
objvarT3 = "----"
objvarT4 = "----"
objvarT5 = "----"
objvarE1 = "- | -"
objvarLegende = [[
<BR>
<BR>
R = Nummer der Runde<BR>
P = richtige Ziffer, richtige Position<BR>
Z = richtige Ziffer]]
objvarAusgabe = ""
objvarH1 = ""
objvarH3 = ""
objvarH4 = ""
objvarH2 = ""
objEingabe = ""
currentZone = "objFinal1"
currentCharacter = "dummy"
currentItem = "objKoordinaten1"
currentTask = "objwerdeMastermind"
currentInput = "inZiffer"
currentTimer = "objupdate_distance"
objKlausMastermindKlabuster.ZVariables = {
  objGesamtstrecke = 0,
  objSpalte1 = false,
  objSpalte2 = false,
  objSpalte3 = false,
  objSpalte4 = false,
  objvarFeld = 0,
  objvarRunde = 1,
  objvarC1 = "",
  objvarZ = 0,
  objvarC2 = "",
  objvarP = 0,
  objvarC3 = "",
  objvarF4 = "-",
  objvarC4 = "",
  objvarF3 = "-",
  objvarF1 = "-",
  objvarF2 = "-",
  objvarT1 = "----",
  objvarE3 = "- | -",
  objvarE4 = "- | -",
  objvarE5 = "- | -",
  objvarT2 = "----",
  objvarE2 = "- | -",
  objvarT3 = "----",
  objvarT4 = "----",
  objvarT5 = "----",
  objvarE1 = "- | -",
  objvarLegende = [[
<BR>
<BR>
R = Nummer der Runde<BR>
P = richtige Ziffer, richtige Position<BR>
Z = richtige Ziffer]],
  objvarAusgabe = "",
  objvarH1 = "",
  objvarH3 = "",
  objvarH4 = "",
  objvarH2 = "",
  objEingabe = "",
  currentZone = "objFinal1",
  currentCharacter = "dummy",
  currentItem = "objKoordinaten1",
  currentTask = "objwerdeMastermind",
  currentInput = "inZiffer",
  currentTimer = "objupdate_distance"
}
objupdate_distance = Wherigo.ZTimer(objKlausMastermindKlabuster)
objupdate_distance.Id = "f8e161bb-9069-4a91-8f41-ea3927d37561"
objupdate_distance.Name = "update_distance"
objupdate_distance.Description = ""
objupdate_distance.Visible = true
objupdate_distance.Duration = 3
objupdate_distance.Type = "Interval"
objSpielzeit = Wherigo.ZTimer(objKlausMastermindKlabuster)
objSpielzeit.Id = "c9c175bb-e4eb-4c33-a78e-77d873f7c170"
objSpielzeit.Name = "Spielzeit"
objSpielzeit.Description = ""
objSpielzeit.Visible = true
objSpielzeit.Duration = 2700
objSpielzeit.Type = "Countdown"
inZiffer = Wherigo.ZInput(objKlausMastermindKlabuster)
inZiffer.Id = "716d3fcc-aa68-45d6-8555-22db2a61c73c"
inZiffer.Name = "Ziffer"
inZiffer.Description = ""
inZiffer.Visible = false
inZiffer.InputType = "Text"
inZiffer.Text = "Welche Ziffer waehlst Du?"
function objKlausMastermindKlabuster:OnStart()
  _Urwigo.MessageBox({
    Text = ("Na, " .. Player.Name) .. ", Du willst mich also tatsaechlich herausfordern?",
    Media = objKlaus,
    Buttons = {
      "aber ja",
      "eher nicht ..."
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
Du hast es so gewollt! Dann nimm in Deinem Inventory Mastermind und beginne das Spiel!<BR>
Die Regeln kannst Du jederzeit in der Anleitung nachlesen.<BR>
Und nicht vergessen - nach dem Start musst Du bis zur Eingabe der ersten Ziffern mindestens 50m laufen. Und auch zwischen den Eingaben der weiteren Ziffern!<BR>
Nach jeweils vier Ziffern sage ich Dir, wie Du getippt hast. Und aufpassen: Korrekturmoeglichkeiten gibt es nicht!<BR>
Und noch etwas: Du hast max. 45min Zeit. Also hau rein!]],
            Media = objKlaus,
            Callback = function(action)
              if action ~= nil then
                objMastermind.Visible = true
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Eine gute Entscheidung!",
            Media = objKlaus
          })
        end
      end
    end
  })
end
function objKlausMastermindKlabuster:OnRestore()
  store_current_position()
end
function objFinal1:OnEnter()
  currentZone = "objFinal1"
  if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
    Wherigo.PlayAudio(objgarminTusch)
  else
    Wherigo.PlayAudio(objtusch)
  end
  objKoordinaten1.Visible = true
  objSpoiler1.Visible = true
  objKlausMastermindKlabuster.Complete = true
  objFreischaltcode.Visible = true
  objKlausMastermindKlabuster:RequestSync()
  objFreischaltcode.Description = (("Hallo " .. Player.Name) .. ", Dein Freischaltode ist<BR>\n") .. string.sub(Player.CompletionCode, 1, 15)
  _Urwigo.MessageBox({
    Text = ("Willkommen " .. Player.Name) .. [[
 zur Finalen Aufgabe:<BR>
finde das Logbuch und trage Dich in die Liste der Superhirne ein!]],
    Media = objKlaus
  })
end
function inZiffer:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objEingabe = input
  if Wherigo.NoCaseEquals(objEingabe, "1") or Wherigo.NoCaseEquals(objEingabe, "2") or Wherigo.NoCaseEquals(objEingabe, "3") or Wherigo.NoCaseEquals(objEingabe, "4") or Wherigo.NoCaseEquals(objEingabe, "5") or Wherigo.NoCaseEquals(objEingabe, "6") then
    if objvarFeld == 1 then
      objvarF1 = objEingabe
      if objvarRunde == 1 then
        objvarT1 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 2 then
        objvarT2 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 3 then
        objvarT3 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 4 then
        objvarT4 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 5 then
        objvarT5 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      end
      objvarAusgabe = (((((((((((((((((([[
R &nbsp;&nbsp;TIPP &nbsp;=&gt; &nbsp;P I Z<BR>
1 &nbsp;&nbsp;]] .. objvarT1) .. " &nbsp;=&gt; &nbsp;") .. objvarE1) .. [[
<BR>
2 &nbsp;&nbsp;]]) .. objvarT2) .. " &nbsp;=&gt; &nbsp;") .. objvarE2) .. [[
<BR>
3 &nbsp;&nbsp;]]) .. objvarT3) .. " &nbsp;=&gt; &nbsp;") .. objvarE3) .. [[
<BR>
4 &nbsp;&nbsp;]]) .. objvarT4) .. " &nbsp;=&gt; &nbsp;") .. objvarE4) .. [[
<BR>
5 &nbsp;&nbsp;]]) .. objvarT5) .. " &nbsp;=&gt; &nbsp;") .. objvarE5
      objSpielstand.Description = ((("Hallo " .. Player.Name) .. ", Deine Ergebnisse sind:<BR>\n") .. objvarAusgabe) .. objvarLegende
      objvarFeld = 2
      objGesamtstrecke = 0
      store_current_position()
      move_zone()
      objKlausMastermindKlabuster:RequestSync()
      objupdate_distance.Duration = 3
      objupdate_distance:Start()
    elseif objvarFeld == 2 then
      objvarF2 = objEingabe
      if objvarRunde == 1 then
        objvarT1 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 2 then
        objvarT2 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 3 then
        objvarT3 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 4 then
        objvarT4 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 5 then
        objvarT5 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      end
      objvarAusgabe = (((((((((((((((((([[
R &nbsp;&nbsp;TIPP &nbsp;=&gt; &nbsp;P I Z<BR>
1 &nbsp;&nbsp;]] .. objvarT1) .. " &nbsp;=&gt; &nbsp;") .. objvarE1) .. [[
<BR>
2 &nbsp;&nbsp;]]) .. objvarT2) .. " &nbsp;=&gt; &nbsp;") .. objvarE2) .. [[
<BR>
3 &nbsp;&nbsp;]]) .. objvarT3) .. " &nbsp;=&gt; &nbsp;") .. objvarE3) .. [[
<BR>
4 &nbsp;&nbsp;]]) .. objvarT4) .. " &nbsp;=&gt; &nbsp;") .. objvarE4) .. [[
<BR>
5 &nbsp;&nbsp;]]) .. objvarT5) .. " &nbsp;=&gt; &nbsp;") .. objvarE5
      objSpielstand.Description = ((("Hallo " .. Player.Name) .. ", Deine Ergebnisse sind:<BR>\n") .. objvarAusgabe) .. objvarLegende
      objvarFeld = 3
      objGesamtstrecke = 0
      store_current_position()
      move_zone()
      objKlausMastermindKlabuster:RequestSync()
      objupdate_distance.Duration = 3
      objupdate_distance:Start()
    elseif objvarFeld == 3 then
      objvarF3 = objEingabe
      if objvarRunde == 1 then
        objvarT1 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 2 then
        objvarT2 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 3 then
        objvarT3 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 4 then
        objvarT4 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      elseif objvarRunde == 5 then
        objvarT5 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
      end
      objvarAusgabe = (((((((((((((((((([[
R &nbsp;&nbsp;TIPP &nbsp;=&gt; &nbsp;P I Z<BR>
1 &nbsp;&nbsp;]] .. objvarT1) .. " &nbsp;=&gt; &nbsp;") .. objvarE1) .. [[
<BR>
2 &nbsp;&nbsp;]]) .. objvarT2) .. " &nbsp;=&gt; &nbsp;") .. objvarE2) .. [[
<BR>
3 &nbsp;&nbsp;]]) .. objvarT3) .. " &nbsp;=&gt; &nbsp;") .. objvarE3) .. [[
<BR>
4 &nbsp;&nbsp;]]) .. objvarT4) .. " &nbsp;=&gt; &nbsp;") .. objvarE4) .. [[
<BR>
5 &nbsp;&nbsp;]]) .. objvarT5) .. " &nbsp;=&gt; &nbsp;") .. objvarE5
      objSpielstand.Description = ((("Hallo " .. Player.Name) .. ", Deine Ergebnisse sind:<BR>\n") .. objvarAusgabe) .. objvarLegende
      objvarFeld = 4
      objGesamtstrecke = 0
      store_current_position()
      move_zone()
      objKlausMastermindKlabuster:RequestSync()
      objupdate_distance.Duration = 3
      objupdate_distance:Start()
    elseif objvarFeld == 4 then
      objvarF4 = objEingabe
      objvarZ = 0
      objvarP = 0
      objvarH1 = objvarC1
      objvarH2 = objvarC2
      objvarH3 = objvarC3
      objvarH4 = objvarC4
      objSpalte1 = false
      objSpalte2 = false
      objSpalte3 = false
      objSpalte4 = false
      if Wherigo.NoCaseEquals(objvarF1, objvarC1) then
        objvarP = objvarP + 1
        objvarH1 = "0"
        objSpalte1 = true
      end
      if Wherigo.NoCaseEquals(objvarF2, objvarC2) then
        objvarP = objvarP + 1
        objvarH2 = "0"
        objSpalte2 = true
      end
      if Wherigo.NoCaseEquals(objvarF3, objvarC3) then
        objvarP = objvarP + 1
        objvarH3 = "0"
        objSpalte3 = true
      end
      if Wherigo.NoCaseEquals(objvarF4, objvarC4) then
        objvarP = objvarP + 1
        objvarH4 = "0"
        objSpalte4 = true
      end
      if objSpalte1 == false then
        if Wherigo.NoCaseEquals(objvarF1, objvarH1) then
          objvarZ = objvarZ + 1
          objvarH1 = "0"
        elseif Wherigo.NoCaseEquals(objvarF1, objvarH2) then
          objvarZ = objvarZ + 1
          objvarH2 = "0"
        elseif Wherigo.NoCaseEquals(objvarF1, objvarH3) then
          objvarZ = objvarZ + 1
          objvarH3 = "0"
        elseif Wherigo.NoCaseEquals(objvarF1, objvarH4) then
          objvarZ = objvarZ + 1
          objvarH4 = "0"
        end
      end
      if objSpalte2 == false then
        if Wherigo.NoCaseEquals(objvarF2, objvarH1) then
          objvarZ = objvarZ + 1
          objvarH1 = "0"
        elseif Wherigo.NoCaseEquals(objvarF2, objvarH2) then
          objvarZ = objvarZ + 1
          objvarH2 = "0"
        elseif Wherigo.NoCaseEquals(objvarF2, objvarH3) then
          objvarZ = objvarZ + 1
          objvarH3 = "0"
        elseif Wherigo.NoCaseEquals(objvarF2, objvarH4) then
          objvarZ = objvarZ + 1
          objvarH4 = "0"
        end
      end
      if objSpalte3 == false then
        if Wherigo.NoCaseEquals(objvarF3, objvarH1) then
          objvarZ = objvarZ + 1
          objvarH1 = "0"
        elseif Wherigo.NoCaseEquals(objvarF3, objvarH2) then
          objvarZ = objvarZ + 1
          objvarH2 = "0"
        elseif Wherigo.NoCaseEquals(objvarF3, objvarH3) then
          objvarZ = objvarZ + 1
          objvarH3 = "0"
        elseif Wherigo.NoCaseEquals(objvarF3, objvarH4) then
          objvarZ = objvarZ + 1
          objvarH4 = "0"
        end
      end
      if objSpalte4 == false then
        if Wherigo.NoCaseEquals(objvarF4, objvarH1) then
          objvarZ = objvarZ + 1
          objvarH1 = "0"
        elseif Wherigo.NoCaseEquals(objvarF4, objvarH2) then
          objvarZ = objvarZ + 1
          objvarH2 = "0"
        elseif Wherigo.NoCaseEquals(objvarF4, objvarH3) then
          objvarZ = objvarZ + 1
          objvarH3 = "0"
        elseif Wherigo.NoCaseEquals(objvarF4, objvarH4) then
          objvarZ = objvarZ + 1
          objvarH4 = "0"
        end
      end
      objKlausMastermindKlabuster:RequestSync()
      if objvarRunde == 1 then
        objvarT1 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
        objvarE1 = (objvarP .. " I ") .. objvarZ
      elseif objvarRunde == 2 then
        objvarT2 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
        objvarE2 = (objvarP .. " I ") .. objvarZ
      elseif objvarRunde == 3 then
        objvarT3 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
        objvarE3 = (objvarP .. " I ") .. objvarZ
      elseif objvarRunde == 4 then
        objvarT4 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
        objvarE4 = (objvarP .. " I ") .. objvarZ
      elseif objvarRunde == 5 then
        objvarT5 = ((objvarF1 .. objvarF2) .. objvarF3) .. objvarF4
        objvarE5 = (objvarP .. " I ") .. objvarZ
      end
      objvarAusgabe = (((((((((((((((((([[
R &nbsp;&nbsp;TIPP &nbsp;=&gt; &nbsp;P | Z<BR>
1 &nbsp;&nbsp;]] .. objvarT1) .. " &nbsp;=&gt; &nbsp;") .. objvarE1) .. [[
<BR>
2 &nbsp;&nbsp;]]) .. objvarT2) .. " &nbsp;=&gt; &nbsp;") .. objvarE2) .. [[
<BR>
3 &nbsp;&nbsp;]]) .. objvarT3) .. " &nbsp;=&gt; &nbsp;") .. objvarE3) .. [[
<BR>
4 &nbsp;&nbsp;]]) .. objvarT4) .. " &nbsp;=&gt; &nbsp;") .. objvarE4) .. [[
<BR>
5 &nbsp;&nbsp;]]) .. objvarT5) .. " &nbsp;=&gt; &nbsp;") .. objvarE5
      objSpielstand.Description = ((("Hallo " .. Player.Name) .. ", Deine Ergebnisse sind:<BR>\n") .. objvarAusgabe) .. objvarLegende
      objKlausMastermindKlabuster:RequestSync()
      if objvarP == 4 then
        objSpielzeit:Stop()
        objKlausMastermindKlabuster:RequestSync()
        if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
          Wherigo.PlayAudio(objgarminTusch)
        else
          Wherigo.PlayAudio(objtusch)
        end
        objFinal1.Visible = true
        board.Visible = false
        objKoordinaten1.Visible = true
        objwerdeMastermind.Complete = true
        objKlausMastermindKlabuster:RequestSync()
        _Urwigo.MessageBox({
          Text = ("Respekt, " .. Player.Name) .. ", Du bist ein Mastermind!",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = "Und jetzt los, trage Dich in das Buch der Champions ein!",
                Media = objKlaus,
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
          Text = ((("Hallo " .. Player.Name) .. ", Deine Ergebnisse sind:<BR>\n") .. objvarAusgabe) .. objvarLegende,
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              if objvarRunde == 5 then
                objKlausMastermindKlabuster:RequestSync()
                objSpielzeit:Stop()
                if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
                  Wherigo.PlayAudio(objgarminSchade)
                else
                  Wherigo.PlayAudio(objschade)
                end
                objMastermind.Visible = false
                board.Visible = false
                objKlausMastermindKlabuster:RequestSync()
                _Urwigo.MessageBox({
                  Text = ((((("Tja, " .. Player.Name) .. ", leider Verloren. Der Code war ") .. objvarC1) .. objvarC2) .. objvarC3) .. objvarC4,
                  Media = objKlaus,
                  Callback = function(action)
                    if action ~= nil then
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              else
                objvarFeld = 1
                objvarRunde = objvarRunde + 1
                objvarF1 = "-"
                objvarF2 = "-"
                objvarF3 = "-"
                objvarF4 = "-"
                objGesamtstrecke = 0
                store_current_position()
                move_zone()
                objKlausMastermindKlabuster:RequestSync()
                objupdate_distance.Duration = 3
                objupdate_distance:Start()
              end
            end
          end
        })
      end
    end
  else
    _Urwigo.MessageBox({
      Text = [[
Eieieieiei - das war eine falsche Eingabe.<BR>
Es sind nur Zahlen zwischen 1 und 6 erlaubt!]],
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(inZiffer)
          end)
        end
      end
    })
  end
end
function objupdate_distance:OnTick()
  objGesamtstrecke = objGesamtstrecke + tonumber(walked_distance())
  if objGesamtstrecke > 50 then
    objupdate_distance.Duration = 86400
    objupdate_distance:Stop()
    if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
      Wherigo.PlayAudio(objgarminBeep)
    else
      Wherigo.PlayAudio(objbeep)
    end
    inZiffer.Text = (((((("Okay, " .. Player.Name) .. [[
,<BR>
jetzt Dein Tip fuer Runde ]]) .. objvarRunde) .. ", Feld ") .. objvarFeld) .. [[
:<BR>
Bisherige Tips:<BR>
]]) .. objvarAusgabe
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(inZiffer)
    end)
  end
end
function objSpielzeit:OnTick()
  _Urwigo.MessageBox({
    Text = Player.Name .. ", das war es. Die Zeit ist um! Schade!",
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        objKlausMastermindKlabuster:RequestSync()
        if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
          Wherigo.PlayAudio(objgarminSchade)
        else
          Wherigo.PlayAudio(objschade)
        end
        objMastermind.Visible = false
        board.Visible = false
        objupdate_distance.Duration = 86400
        objupdate_distance:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objAnleitung:OncmdDetails(target)
  _Urwigo.Dialog(false, {
    {
      Text = [[
Nach dem Start musst Du ca. 50m laufen, bis ich nach der ersten Ziffer frage. Danach wieder 50m laufen und so weiter.<BR>
Aber pass auf, es gibt keine Korrekturmoeglichkeit fuer die eingetippte Ziffer. Ist der Schuss erst aus dem Rohr ...<BR>
Nach jeweils 4 Ziffern ist die Runde fertig und ich werte aus.]],
      Media = objKlaus
    },
    {
      Text = [[
Nach jeder Runde sage ich Dir, wie viele Stellen Du in Ziffer und Position richtig gesetzt hast und wie viele Stellen zwar die richtige Ziffer haben, aber an einer falschen Position stehen.<BR>
<BR>
Alle Fragen und Antworten bleiben bis zum Ende des Spiels sichtbar.]],
      Media = objKlaus
    },
    {
      Text = "Damit Du Zeit zum Nachdenken hast, musst Du zwischen jeder Eingabe einer Ziffer etwas laufen - so ca. 50m.",
      Media = objKlaus
    },
    {
      Text = "Aber denke nicht zu lange - nach 45min ist das Spiel aus!",
      Media = objKlaus
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objMastermind:Oncmdspielen(target)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.166666666666667 then
    objvarC1 = tostring(1)
  elseif _rndChoiceValue < 0.333333333333333 then
    objvarC1 = tostring(2)
  elseif _rndChoiceValue < 0.5 then
    objvarC1 = tostring(3)
  elseif _rndChoiceValue < 0.666666666666667 then
    objvarC1 = tostring(4)
  elseif _rndChoiceValue < 0.833333333333333 then
    objvarC1 = tostring(5)
  else
    objvarC1 = tostring(6)
  end
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.166666666666667 then
    objvarC2 = tostring(1)
  elseif _rndChoiceValue < 0.333333333333333 then
    objvarC2 = tostring(2)
  elseif _rndChoiceValue < 0.5 then
    objvarC2 = tostring(3)
  elseif _rndChoiceValue < 0.666666666666667 then
    objvarC2 = tostring(4)
  elseif _rndChoiceValue < 0.833333333333333 then
    objvarC2 = tostring(5)
  else
    objvarC2 = tostring(6)
  end
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.166666666666667 then
    objvarC3 = tostring(1)
  elseif _rndChoiceValue < 0.333333333333333 then
    objvarC3 = tostring(2)
  elseif _rndChoiceValue < 0.5 then
    objvarC3 = tostring(3)
  elseif _rndChoiceValue < 0.666666666666667 then
    objvarC3 = tostring(4)
  elseif _rndChoiceValue < 0.833333333333333 then
    objvarC3 = tostring(5)
  else
    objvarC3 = tostring(6)
  end
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.166666666666667 then
    objvarC4 = tostring(1)
  elseif _rndChoiceValue < 0.333333333333333 then
    objvarC4 = tostring(2)
  elseif _rndChoiceValue < 0.5 then
    objvarC4 = tostring(3)
  elseif _rndChoiceValue < 0.666666666666667 then
    objvarC4 = tostring(4)
  elseif _rndChoiceValue < 0.833333333333333 then
    objvarC4 = tostring(5)
  else
    objvarC4 = tostring(6)
  end
  objvarFeld = 1
  objvarRunde = 1
  objvarF1 = "-"
  objvarF2 = "-"
  objvarF3 = "-"
  objvarF4 = "-"
  objvarT1 = "----"
  objvarT2 = "----"
  objvarT3 = "----"
  objvarT4 = "----"
  objvarT5 = "----"
  objvarE1 = "- I -"
  objvarE2 = "- I -"
  objvarE3 = "- I -"
  objvarE4 = "- I -"
  objvarE5 = "- I -"
  objMastermind.Visible = false
  move_zone()
  board.Visible = true
  objGesamtstrecke = 0
  objwerdeMastermind.Visible = true
  objSpielstand.Visible = true
  store_current_position()
  objupdate_distance:Start()
  _Urwigo.MessageBox({
    Text = "Zeit laeuft!",
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        objSpielzeit:Start()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
_Urwigo.InlineRequire(0)
function move_zone()
  local dist = Wherigo.Distance(0, "m")
  board.Active = false
  board.OriginalPoint = Wherigo.TranslatePoint(Player.ObjectLocation, dist, 0)
  board.Points = GetZonePoints(Player.ObjectLocation, 1000)
  board.Active = true
end
function GetZonePoints(refPt, entf)
  local dist = Wherigo.Distance(entf, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, dist, 0),
    Wherigo.TranslatePoint(refPt, dist, 45),
    Wherigo.TranslatePoint(refPt, dist, 90),
    Wherigo.TranslatePoint(refPt, dist, 135),
    Wherigo.TranslatePoint(refPt, dist, 180),
    Wherigo.TranslatePoint(refPt, dist, 225),
    Wherigo.TranslatePoint(refPt, dist, 270),
    Wherigo.TranslatePoint(refPt, dist, 315)
  }
  return pts
end
return objKlausMastermindKlabuster
