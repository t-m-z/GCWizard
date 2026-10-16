require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _uAh_(str)
  local res = ""
  local dtable = "!xH|0\022n7Oq \vc:Jf\021\006u`}\027M\a#,B\014P\fVTKb<pF]Q\031m\b\020i\001N(v\003\028+/l%\t92\017A{>\000S\015W=L~h&\023\005C\030E3\029D1G\\'\025Y4g?\024\njs\002Z@\"6t.[\018kI\ro-*;R$5w_r\019\026aeU)\004yz\016dX^8"
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
objKlausraeumtauf = Wherigo.ZCartridge()
objKlaus = Wherigo.ZMedia(objKlausraeumtauf)
objKlaus.Id = "e2ea0a1b-d691-45f0-8b3e-3cc7205ab3b8"
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
objKoordinaten = Wherigo.ZMedia(objKlausraeumtauf)
objKoordinaten.Id = "3b1d3425-f734-4820-b870-13e50b4f6d43"
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
objicoKoordinaten = Wherigo.ZMedia(objKlausraeumtauf)
objicoKoordinaten.Id = "be9d2922-bfae-4671-989c-ed0405f8e37b"
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
objSpoiler = Wherigo.ZMedia(objKlausraeumtauf)
objSpoiler.Id = "9dbcd953-2f0b-4bf2-bfd4-daad64dc7111"
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
objicoSpoiler = Wherigo.ZMedia(objKlausraeumtauf)
objicoSpoiler.Id = "f86aa04f-7058-44e3-9dfd-2983998eab88"
objicoSpoiler.Name = "ico-Spoiler"
objicoSpoiler.Description = ""
objicoSpoiler.AltText = ""
objicoSpoiler.Resources = {
  {
    Type = "jpg",
    Filename = "ico-spoiler.jpg",
    Directives = {}
  }
}
objFreischaltcode = Wherigo.ZMedia(objKlausraeumtauf)
objFreischaltcode.Id = "93bbe88b-e391-49ba-a114-569fcf3e13b1"
objFreischaltcode.Name = "Freischaltcode"
objFreischaltcode.Description = ""
objFreischaltcode.AltText = ""
objFreischaltcode.Resources = {
  {
    Type = "jpg",
    Filename = "grundbuch.jpg",
    Directives = {}
  }
}
objicoFreischaltcode = Wherigo.ZMedia(objKlausraeumtauf)
objicoFreischaltcode.Id = "364f7ece-4498-41fe-ba11-93a017d9c4bc"
objicoFreischaltcode.Name = "ico-Freischaltcode"
objicoFreischaltcode.Description = ""
objicoFreischaltcode.AltText = ""
objicoFreischaltcode.Resources = {
  {
    Type = "jpg",
    Filename = "ico-grundbuch.jpg",
    Directives = {}
  }
}
objAnleitung = Wherigo.ZMedia(objKlausraeumtauf)
objAnleitung.Id = "cbad4262-4f8c-48a9-bde9-a055aec92f5c"
objAnleitung.Name = "Anleitung"
objAnleitung.Description = ""
objAnleitung.AltText = ""
objAnleitung.Resources = {
  {
    Type = "jpg",
    Filename = "Notizbuch.jpg",
    Directives = {}
  }
}
objicoAnleitung = Wherigo.ZMedia(objKlausraeumtauf)
objicoAnleitung.Id = "996cce74-a03a-4730-b65b-8fd93b5af6e6"
objicoAnleitung.Name = "ico-Anleitung"
objicoAnleitung.Description = ""
objicoAnleitung.AltText = ""
objicoAnleitung.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Notizbuch.jpg",
    Directives = {}
  }
}
objfahne = Wherigo.ZMedia(objKlausraeumtauf)
objfahne.Id = "ef52bcf3-6d2c-46dd-8cf7-fc9f52eeee9f"
objfahne.Name = "fahne"
objfahne.Description = ""
objfahne.AltText = ""
objfahne.Resources = {
  {
    Type = "jpg",
    Filename = "fahne.jpg",
    Directives = {}
  }
}
objicofahne = Wherigo.ZMedia(objKlausraeumtauf)
objicofahne.Id = "964d47f4-485e-4892-9038-87493a9e00ec"
objicofahne.Name = "ico-fahne"
objicofahne.Description = ""
objicofahne.AltText = ""
objicofahne.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fahne.jpg",
    Directives = {}
  }
}
objtest = Wherigo.ZMedia(objKlausraeumtauf)
objtest.Id = "f81d2fc8-c77a-4fb4-b4b5-03528330ed40"
objtest.Name = "test"
objtest.Description = ""
objtest.AltText = ""
objtest.Resources = {
  {
    Type = "jpg",
    Filename = "fragezeichen.jpg",
    Directives = {}
  }
}
imgT = Wherigo.ZMedia(objKlausraeumtauf)
imgT.Id = "85f1bba9-dbe1-447a-bba4-a437d14efbf6"
imgT.Name = "ico-test"
imgT.Description = ""
imgT.AltText = ""
imgT.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fragezeichen.jpg",
    Directives = {}
  }
}
objicoKarte = Wherigo.ZMedia(objKlausraeumtauf)
objicoKarte.Id = "d3fea377-b6f4-4b8b-a2df-52fdd092561b"
objicoKarte.Name = "ico-Karte"
objicoKarte.Description = ""
objicoKarte.AltText = ""
objicoKarte.Resources = {
  {
    Type = "jpg",
    Filename = "karte.jpg",
    Directives = {}
  }
}
objkartegross = Wherigo.ZMedia(objKlausraeumtauf)
objkartegross.Id = "a0f6f1a7-55aa-4823-8ed0-4153c4f5126d"
objkartegross.Name = "karte-gross"
objkartegross.Description = ""
objkartegross.AltText = ""
objkartegross.Resources = {
  {
    Type = "jpg",
    Filename = "kartenfeld.jpg",
    Directives = {}
  }
}
img0 = Wherigo.ZMedia(objKlausraeumtauf)
img0.Id = "6fcbcbbd-bf8e-4be0-9cdd-d8d2efcf9d6b"
img0.Name = "0"
img0.Description = ""
img0.AltText = ""
img0.Resources = {
  {
    Type = "jpg",
    Filename = "0.jpg",
    Directives = {}
  }
}
img1 = Wherigo.ZMedia(objKlausraeumtauf)
img1.Id = "7660775c-97f4-4db3-b3e8-63fb5bb256bc"
img1.Name = "1"
img1.Description = ""
img1.AltText = ""
img1.Resources = {
  {
    Type = "jpg",
    Filename = "1.jpg",
    Directives = {}
  }
}
img2 = Wherigo.ZMedia(objKlausraeumtauf)
img2.Id = "e034cad0-d9c2-48eb-a865-0b2a1a631217"
img2.Name = "2"
img2.Description = ""
img2.AltText = ""
img2.Resources = {
  {
    Type = "jpg",
    Filename = "2.jpg",
    Directives = {}
  }
}
img3 = Wherigo.ZMedia(objKlausraeumtauf)
img3.Id = "c9bc6cb2-b04f-491b-b301-6b8c0b53dd4c"
img3.Name = "3"
img3.Description = ""
img3.AltText = ""
img3.Resources = {
  {
    Type = "jpg",
    Filename = "3.jpg",
    Directives = {}
  }
}
img4 = Wherigo.ZMedia(objKlausraeumtauf)
img4.Id = "9c2929a9-4d23-4644-81e4-148da20758d2"
img4.Name = "4"
img4.Description = ""
img4.AltText = ""
img4.Resources = {
  {
    Type = "jpg",
    Filename = "4.jpg",
    Directives = {}
  }
}
img5 = Wherigo.ZMedia(objKlausraeumtauf)
img5.Id = "8c99a8bf-d67a-467e-90a8-1e2312d25c62"
img5.Name = "5"
img5.Description = ""
img5.AltText = ""
img5.Resources = {
  {
    Type = "jpg",
    Filename = "5.jpg",
    Directives = {}
  }
}
img6 = Wherigo.ZMedia(objKlausraeumtauf)
img6.Id = "52126c21-3965-4248-b5dc-a83fe5416079"
img6.Name = "6"
img6.Description = ""
img6.AltText = ""
img6.Resources = {
  {
    Type = "jpg",
    Filename = "6.jpg",
    Directives = {}
  }
}
img7 = Wherigo.ZMedia(objKlausraeumtauf)
img7.Id = "26b39528-290f-4a7b-beb3-7e9ca7ef62fc"
img7.Name = "7"
img7.Description = ""
img7.AltText = ""
img7.Resources = {
  {
    Type = "jpg",
    Filename = "7.jpg",
    Directives = {}
  }
}
img8 = Wherigo.ZMedia(objKlausraeumtauf)
img8.Id = "8ce4c4bf-1bc0-460d-8b6e-ffeea9763792"
img8.Name = "8"
img8.Description = ""
img8.AltText = ""
img8.Resources = {
  {
    Type = "jpg",
    Filename = "8.jpg",
    Directives = {}
  }
}
imgF = Wherigo.ZMedia(objKlausraeumtauf)
imgF.Id = "0701f9c5-effe-4c87-9613-66d1c4edce84"
imgF.Name = "feldfahne"
imgF.Description = ""
imgF.AltText = ""
imgF.Resources = {
  {
    Type = "jpg",
    Filename = "f-fahne.jpg",
    Directives = {}
  }
}
objexplosion = Wherigo.ZMedia(objKlausraeumtauf)
objexplosion.Id = "6b113579-29a9-4a63-b6a3-e63a758abe17"
objexplosion.Name = "explosion"
objexplosion.Description = ""
objexplosion.AltText = ""
objexplosion.Resources = {
  {
    Type = "jpg",
    Filename = "explosion.jpg",
    Directives = {}
  }
}
obj_explosion = Wherigo.ZMedia(objKlausraeumtauf)
obj_explosion.Id = "c5ff8325-d0e4-4542-bb2e-2aa88be8f41f"
obj_explosion.Name = "_explosion"
obj_explosion.Description = ""
obj_explosion.AltText = ""
obj_explosion.Resources = {
  {
    Type = "mp3",
    Filename = "donner.mp3",
    Directives = {}
  }
}
obj_tusch = Wherigo.ZMedia(objKlausraeumtauf)
obj_tusch.Id = "bc4ec0b5-5640-4176-be3a-e9972c90d4c5"
obj_tusch.Name = "_tusch"
obj_tusch.Description = ""
obj_tusch.AltText = ""
obj_tusch.Resources = {
  {
    Type = "mp3",
    Filename = "tusch.mp3",
    Directives = {}
  }
}
obj_intro = Wherigo.ZMedia(objKlausraeumtauf)
obj_intro.Id = "1a05222c-d65e-4b13-964c-efdfd70d5414"
obj_intro.Name = "_intro"
obj_intro.Description = ""
obj_intro.AltText = ""
obj_intro.Resources = {
  {
    Type = "mp3",
    Filename = "DieserWeg.mp3",
    Directives = {}
  }
}
objMarkierung = Wherigo.ZMedia(objKlausraeumtauf)
objMarkierung.Id = "2f670b50-b66f-443a-bcf2-5693425a5750"
objMarkierung.Name = "Markierung"
objMarkierung.Description = ""
objMarkierung.AltText = ""
objMarkierung.Resources = {
  {
    Type = "jpg",
    Filename = "minenfahne.jpg",
    Directives = {}
  }
}
objicomarker = Wherigo.ZMedia(objKlausraeumtauf)
objicomarker.Id = "1ea42ceb-814d-4710-a06f-1ad46bb228e1"
objicomarker.Name = "ico-marker"
objicomarker.Description = ""
objicomarker.AltText = ""
objicomarker.Resources = {
  {
    Type = "jpg",
    Filename = "ico-minenfahne.jpg",
    Directives = {}
  }
}
objKlausraeumtauf.Id = "773a9f9a-4d2d-4b84-aca0-c64e3c52328c"
objKlausraeumtauf.Name = "Klaus macht sauber"
objKlausraeumtauf.Description = "Hilf ihm, die 10 kritischsten Dinge zu finden und zu markieren.<BR>\n<BR>\nSucht Euch dazu ein freies Feld, ca. 100m x 100m, stellt Euch in die Mitte und legt dann los!<BR>\n<BR>\nViel Spa\195\159 und viel Erfolg!"
objKlausraeumtauf.Visible = true
objKlausraeumtauf.Activity = "Puzzle"
objKlausraeumtauf.StartingLocationDescription = ""
objKlausraeumtauf.StartingLocation = Wherigo.INVALID_ZONEPOINT
objKlausraeumtauf.Version = "1.5"
objKlausraeumtauf.Company = ""
objKlausraeumtauf.Author = "tmz"
objKlausraeumtauf.BuilderVersion = "URWIGO 1.22.5798.37755"
objKlausraeumtauf.CreateDate = "12/04/2015 21:44:19"
objKlausraeumtauf.PublishDate = "1/1/0001 12:00:00 AM"
objKlausraeumtauf.UpdateDate = "02/25/2018 20:14:22"
objKlausraeumtauf.LastPlayedDate = "1/1/0001 12:00:00 AM"
objKlausraeumtauf.TargetDevice = "PocketPC"
objKlausraeumtauf.TargetDeviceVersion = "0"
objKlausraeumtauf.StateId = "1"
objKlausraeumtauf.CountryId = "2"
objKlausraeumtauf.Complete = false
objKlausraeumtauf.UseLogging = true
objKlausraeumtauf.Media = objkartegross
objKlausraeumtauf.Icon = objicoKarte
z01 = Wherigo.Zone(objKlausraeumtauf)
z01.Id = "1aa1da3f-1318-46b9-84b8-bdaf75adfad4"
z01.Name = "1"
z01.Description = ""
z01.Visible = true
z01.Media = objtest
z01.Icon = imgT
z01.Commands = {}
z01.DistanceRange = Distance(-1, "feet")
z01.ShowObjects = "OnEnter"
z01.ProximityRange = Distance(100, "meters")
z01.AllowSetPositionTo = false
z01.Active = false
z01.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z01.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z01.DistanceRangeUOM = "Feet"
z01.ProximityRangeUOM = "Meters"
z01.OutOfRangeName = ""
z01.InRangeName = ""
z02 = Wherigo.Zone(objKlausraeumtauf)
z02.Id = "abacb2b1-b86c-4b5c-ae15-9273712fed9a"
z02.Name = "2"
z02.Description = ""
z02.Visible = true
z02.Media = objtest
z02.Icon = imgT
z02.Commands = {}
z02.DistanceRange = Distance(-1, "feet")
z02.ShowObjects = "OnEnter"
z02.ProximityRange = Distance(100, "meters")
z02.AllowSetPositionTo = false
z02.Active = false
z02.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z02.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z02.DistanceRangeUOM = "Feet"
z02.ProximityRangeUOM = "Meters"
z02.OutOfRangeName = ""
z02.InRangeName = ""
z49 = Wherigo.Zone(objKlausraeumtauf)
z49.Id = "a0def54d-1e74-49f7-8e03-8a08b1075b49"
z49.Name = "49"
z49.Description = ""
z49.Visible = true
z49.Media = objtest
z49.Icon = imgT
z49.Commands = {}
z49.DistanceRange = Distance(-1, "feet")
z49.ShowObjects = "OnEnter"
z49.ProximityRange = Distance(100, "meters")
z49.AllowSetPositionTo = false
z49.Active = false
z49.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z49.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z49.DistanceRangeUOM = "Feet"
z49.ProximityRangeUOM = "Meters"
z49.OutOfRangeName = ""
z49.InRangeName = ""
z03 = Wherigo.Zone(objKlausraeumtauf)
z03.Id = "7cd36397-6bf4-440d-bbea-bd2e8e3727b0"
z03.Name = "3"
z03.Description = ""
z03.Visible = true
z03.Media = objtest
z03.Icon = imgT
z03.Commands = {}
z03.DistanceRange = Distance(0, "meters")
z03.ShowObjects = "OnEnter"
z03.ProximityRange = Distance(100, "meters")
z03.AllowSetPositionTo = false
z03.Active = false
z03.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z03.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z03.DistanceRangeUOM = "Meters"
z03.ProximityRangeUOM = "Meters"
z03.OutOfRangeName = ""
z03.InRangeName = ""
z48 = Wherigo.Zone(objKlausraeumtauf)
z48.Id = "942b4ab5-fc99-49b4-9a88-5e717c062a38"
z48.Name = "48"
z48.Description = ""
z48.Visible = true
z48.Media = objtest
z48.Icon = imgT
z48.Commands = {}
z48.DistanceRange = Distance(-1, "feet")
z48.ShowObjects = "OnEnter"
z48.ProximityRange = Distance(100, "meters")
z48.AllowSetPositionTo = false
z48.Active = false
z48.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z48.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z48.DistanceRangeUOM = "Feet"
z48.ProximityRangeUOM = "Meters"
z48.OutOfRangeName = ""
z48.InRangeName = ""
z04 = Wherigo.Zone(objKlausraeumtauf)
z04.Id = "00e680ea-e2ca-4b15-966e-c045bbba1eb5"
z04.Name = "4"
z04.Description = ""
z04.Visible = true
z04.Media = objtest
z04.Icon = imgT
z04.Commands = {}
z04.DistanceRange = Distance(0, "meters")
z04.ShowObjects = "OnEnter"
z04.ProximityRange = Distance(100, "meters")
z04.AllowSetPositionTo = false
z04.Active = false
z04.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z04.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z04.DistanceRangeUOM = "Meters"
z04.ProximityRangeUOM = "Meters"
z04.OutOfRangeName = ""
z04.InRangeName = ""
z47 = Wherigo.Zone(objKlausraeumtauf)
z47.Id = "19e1bb14-2865-4b5a-92ec-304a200e59aa"
z47.Name = "47"
z47.Description = ""
z47.Visible = true
z47.Media = objtest
z47.Icon = imgT
z47.Commands = {}
z47.DistanceRange = Distance(-1, "feet")
z47.ShowObjects = "OnEnter"
z47.ProximityRange = Distance(100, "meters")
z47.AllowSetPositionTo = false
z47.Active = false
z47.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z47.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z47.DistanceRangeUOM = "Feet"
z47.ProximityRangeUOM = "Meters"
z47.OutOfRangeName = ""
z47.InRangeName = ""
z05 = Wherigo.Zone(objKlausraeumtauf)
z05.Id = "f5a3b94c-fbf9-4738-b650-4d13a3862b1e"
z05.Name = "5"
z05.Description = ""
z05.Visible = true
z05.Media = objtest
z05.Icon = imgT
z05.Commands = {}
z05.DistanceRange = Distance(-1, "feet")
z05.ShowObjects = "OnEnter"
z05.ProximityRange = Distance(100, "meters")
z05.AllowSetPositionTo = false
z05.Active = false
z05.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z05.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z05.DistanceRangeUOM = "Feet"
z05.ProximityRangeUOM = "Meters"
z05.OutOfRangeName = ""
z05.InRangeName = ""
z46 = Wherigo.Zone(objKlausraeumtauf)
z46.Id = "0b7ae714-6c9f-4239-8d43-5e00ea2f4f27"
z46.Name = "46"
z46.Description = ""
z46.Visible = true
z46.Media = objtest
z46.Icon = imgT
z46.Commands = {}
z46.DistanceRange = Distance(-1, "feet")
z46.ShowObjects = "OnEnter"
z46.ProximityRange = Distance(100, "meters")
z46.AllowSetPositionTo = false
z46.Active = false
z46.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z46.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z46.DistanceRangeUOM = "Feet"
z46.ProximityRangeUOM = "Meters"
z46.OutOfRangeName = ""
z46.InRangeName = ""
z06 = Wherigo.Zone(objKlausraeumtauf)
z06.Id = "d7a8ac25-f0be-4571-a09e-8dbc65b18e07"
z06.Name = "6"
z06.Description = ""
z06.Visible = true
z06.Media = objtest
z06.Icon = imgT
z06.Commands = {}
z06.DistanceRange = Distance(-1, "feet")
z06.ShowObjects = "OnEnter"
z06.ProximityRange = Distance(100, "meters")
z06.AllowSetPositionTo = false
z06.Active = false
z06.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z06.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z06.DistanceRangeUOM = "Feet"
z06.ProximityRangeUOM = "Meters"
z06.OutOfRangeName = ""
z06.InRangeName = ""
z45 = Wherigo.Zone(objKlausraeumtauf)
z45.Id = "ab2545ef-fdb8-42bc-aa05-53347e3b8dbb"
z45.Name = "45"
z45.Description = ""
z45.Visible = true
z45.Media = objtest
z45.Icon = imgT
z45.Commands = {}
z45.DistanceRange = Distance(0, "meters")
z45.ShowObjects = "OnEnter"
z45.ProximityRange = Distance(100, "meters")
z45.AllowSetPositionTo = false
z45.Active = false
z45.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z45.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z45.DistanceRangeUOM = "Meters"
z45.ProximityRangeUOM = "Meters"
z45.OutOfRangeName = ""
z45.InRangeName = ""
z07 = Wherigo.Zone(objKlausraeumtauf)
z07.Id = "5593997a-46dd-468f-a154-c4460fae5d35"
z07.Name = "7"
z07.Description = ""
z07.Visible = true
z07.Media = objtest
z07.Icon = imgT
z07.Commands = {}
z07.DistanceRange = Distance(-1, "feet")
z07.ShowObjects = "OnEnter"
z07.ProximityRange = Distance(100, "meters")
z07.AllowSetPositionTo = false
z07.Active = false
z07.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z07.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z07.DistanceRangeUOM = "Feet"
z07.ProximityRangeUOM = "Meters"
z07.OutOfRangeName = ""
z07.InRangeName = ""
z44 = Wherigo.Zone(objKlausraeumtauf)
z44.Id = "07ee04c5-6620-48a5-9204-661112783882"
z44.Name = "44"
z44.Description = ""
z44.Visible = true
z44.Media = objtest
z44.Icon = imgT
z44.Commands = {}
z44.DistanceRange = Distance(-1, "feet")
z44.ShowObjects = "OnEnter"
z44.ProximityRange = Distance(100, "meters")
z44.AllowSetPositionTo = false
z44.Active = false
z44.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z44.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z44.DistanceRangeUOM = "Feet"
z44.ProximityRangeUOM = "Meters"
z44.OutOfRangeName = ""
z44.InRangeName = ""
z08 = Wherigo.Zone(objKlausraeumtauf)
z08.Id = "7f558726-7b44-4d64-8e22-556af8b3965f"
z08.Name = "8"
z08.Description = ""
z08.Visible = true
z08.Media = objtest
z08.Icon = imgT
z08.Commands = {}
z08.DistanceRange = Distance(-1, "feet")
z08.ShowObjects = "OnEnter"
z08.ProximityRange = Distance(100, "meters")
z08.AllowSetPositionTo = false
z08.Active = false
z08.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z08.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z08.DistanceRangeUOM = "Feet"
z08.ProximityRangeUOM = "Meters"
z08.OutOfRangeName = ""
z08.InRangeName = ""
z43 = Wherigo.Zone(objKlausraeumtauf)
z43.Id = "7422b997-81b2-457e-8084-846408978e6d"
z43.Name = "43"
z43.Description = ""
z43.Visible = true
z43.Media = objtest
z43.Icon = imgT
z43.Commands = {}
z43.DistanceRange = Distance(0, "meters")
z43.ShowObjects = "OnEnter"
z43.ProximityRange = Distance(100, "meters")
z43.AllowSetPositionTo = false
z43.Active = false
z43.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z43.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z43.DistanceRangeUOM = "Meters"
z43.ProximityRangeUOM = "Meters"
z43.OutOfRangeName = ""
z43.InRangeName = ""
z09 = Wherigo.Zone(objKlausraeumtauf)
z09.Id = "7a561b80-338e-4fbf-bba5-3bb8ccbb00bc"
z09.Name = "9"
z09.Description = ""
z09.Visible = true
z09.Media = objtest
z09.Icon = imgT
z09.Commands = {}
z09.DistanceRange = Distance(-1, "feet")
z09.ShowObjects = "OnEnter"
z09.ProximityRange = Distance(100, "meters")
z09.AllowSetPositionTo = false
z09.Active = false
z09.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z09.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z09.DistanceRangeUOM = "Feet"
z09.ProximityRangeUOM = "Meters"
z09.OutOfRangeName = ""
z09.InRangeName = ""
z42 = Wherigo.Zone(objKlausraeumtauf)
z42.Id = "639ac2c0-2639-4a95-9946-6c528bcde287"
z42.Name = "42"
z42.Description = ""
z42.Visible = true
z42.Media = objtest
z42.Icon = imgT
z42.Commands = {}
z42.DistanceRange = Distance(-1, "feet")
z42.ShowObjects = "OnEnter"
z42.ProximityRange = Distance(100, "meters")
z42.AllowSetPositionTo = false
z42.Active = false
z42.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z42.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z42.DistanceRangeUOM = "Feet"
z42.ProximityRangeUOM = "Meters"
z42.OutOfRangeName = ""
z42.InRangeName = ""
z10 = Wherigo.Zone(objKlausraeumtauf)
z10.Id = "472388f9-97b2-4749-85f8-effd6eb31e8b"
z10.Name = "10"
z10.Description = ""
z10.Visible = true
z10.Media = objtest
z10.Icon = imgT
z10.Commands = {}
z10.DistanceRange = Distance(-1, "feet")
z10.ShowObjects = "OnEnter"
z10.ProximityRange = Distance(100, "meters")
z10.AllowSetPositionTo = false
z10.Active = false
z10.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z10.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z10.DistanceRangeUOM = "Feet"
z10.ProximityRangeUOM = "Meters"
z10.OutOfRangeName = ""
z10.InRangeName = ""
z41 = Wherigo.Zone(objKlausraeumtauf)
z41.Id = "56364de6-91d3-434b-8aaa-278cb4def586"
z41.Name = "41"
z41.Description = ""
z41.Visible = true
z41.Media = objtest
z41.Icon = imgT
z41.Commands = {}
z41.DistanceRange = Distance(0, "meters")
z41.ShowObjects = "OnEnter"
z41.ProximityRange = Distance(100, "meters")
z41.AllowSetPositionTo = false
z41.Active = false
z41.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z41.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z41.DistanceRangeUOM = "Meters"
z41.ProximityRangeUOM = "Meters"
z41.OutOfRangeName = ""
z41.InRangeName = ""
z11 = Wherigo.Zone(objKlausraeumtauf)
z11.Id = "d9d5222b-4271-46ce-adde-051fa8489dfa"
z11.Name = "11"
z11.Description = ""
z11.Visible = true
z11.Media = objtest
z11.Icon = imgT
z11.Commands = {}
z11.DistanceRange = Distance(-1, "feet")
z11.ShowObjects = "OnEnter"
z11.ProximityRange = Distance(100, "meters")
z11.AllowSetPositionTo = false
z11.Active = false
z11.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z11.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z11.DistanceRangeUOM = "Feet"
z11.ProximityRangeUOM = "Meters"
z11.OutOfRangeName = ""
z11.InRangeName = ""
z40 = Wherigo.Zone(objKlausraeumtauf)
z40.Id = "0d36d6c2-7179-4242-be3a-b1d1ec0312b5"
z40.Name = "40"
z40.Description = ""
z40.Visible = true
z40.Media = objtest
z40.Icon = imgT
z40.Commands = {}
z40.DistanceRange = Distance(-1, "feet")
z40.ShowObjects = "OnEnter"
z40.ProximityRange = Distance(100, "meters")
z40.AllowSetPositionTo = false
z40.Active = false
z40.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z40.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z40.DistanceRangeUOM = "Feet"
z40.ProximityRangeUOM = "Meters"
z40.OutOfRangeName = ""
z40.InRangeName = ""
z12 = Wherigo.Zone(objKlausraeumtauf)
z12.Id = "38555ba6-beaa-4017-9e57-1e368f7f2d57"
z12.Name = "12"
z12.Description = ""
z12.Visible = true
z12.Media = objtest
z12.Icon = imgT
z12.Commands = {}
z12.DistanceRange = Distance(-1, "feet")
z12.ShowObjects = "OnEnter"
z12.ProximityRange = Distance(100, "meters")
z12.AllowSetPositionTo = false
z12.Active = false
z12.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z12.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z12.DistanceRangeUOM = "Feet"
z12.ProximityRangeUOM = "Meters"
z12.OutOfRangeName = ""
z12.InRangeName = ""
z39 = Wherigo.Zone(objKlausraeumtauf)
z39.Id = "2153b2e6-b760-43f9-ac8f-bcc59612beae"
z39.Name = "39"
z39.Description = ""
z39.Visible = true
z39.Media = objtest
z39.Icon = imgT
z39.Commands = {}
z39.DistanceRange = Distance(-1, "feet")
z39.ShowObjects = "OnEnter"
z39.ProximityRange = Distance(100, "meters")
z39.AllowSetPositionTo = false
z39.Active = false
z39.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z39.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z39.DistanceRangeUOM = "Feet"
z39.ProximityRangeUOM = "Meters"
z39.OutOfRangeName = ""
z39.InRangeName = ""
z13 = Wherigo.Zone(objKlausraeumtauf)
z13.Id = "a7cbf161-75db-4f58-8f3a-0bff13bc66e2"
z13.Name = "13"
z13.Description = ""
z13.Visible = true
z13.Media = objtest
z13.Icon = imgT
z13.Commands = {}
z13.DistanceRange = Distance(-1, "feet")
z13.ShowObjects = "OnEnter"
z13.ProximityRange = Distance(100, "meters")
z13.AllowSetPositionTo = false
z13.Active = false
z13.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z13.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z13.DistanceRangeUOM = "Feet"
z13.ProximityRangeUOM = "Meters"
z13.OutOfRangeName = ""
z13.InRangeName = ""
z38 = Wherigo.Zone(objKlausraeumtauf)
z38.Id = "5d65d2ff-0319-43c0-a3b9-b35f607b3c22"
z38.Name = "38"
z38.Description = ""
z38.Visible = true
z38.Media = objtest
z38.Icon = imgT
z38.Commands = {}
z38.DistanceRange = Distance(-1, "feet")
z38.ShowObjects = "OnEnter"
z38.ProximityRange = Distance(100, "meters")
z38.AllowSetPositionTo = false
z38.Active = false
z38.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z38.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z38.DistanceRangeUOM = "Feet"
z38.ProximityRangeUOM = "Meters"
z38.OutOfRangeName = ""
z38.InRangeName = ""
z14 = Wherigo.Zone(objKlausraeumtauf)
z14.Id = "78d88b4f-78f4-4c92-874d-e974fdc0aa05"
z14.Name = "14"
z14.Description = ""
z14.Visible = true
z14.Media = objtest
z14.Icon = imgT
z14.Commands = {}
z14.DistanceRange = Distance(0, "meters")
z14.ShowObjects = "OnEnter"
z14.ProximityRange = Distance(100, "meters")
z14.AllowSetPositionTo = false
z14.Active = false
z14.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z14.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z14.DistanceRangeUOM = "Meters"
z14.ProximityRangeUOM = "Meters"
z14.OutOfRangeName = ""
z14.InRangeName = ""
z37 = Wherigo.Zone(objKlausraeumtauf)
z37.Id = "fa4119b2-cc1a-4bcb-a4c4-bb75fc3a5238"
z37.Name = "37"
z37.Description = ""
z37.Visible = true
z37.Media = objtest
z37.Icon = imgT
z37.Commands = {}
z37.DistanceRange = Distance(-1, "feet")
z37.ShowObjects = "OnEnter"
z37.ProximityRange = Distance(100, "meters")
z37.AllowSetPositionTo = false
z37.Active = false
z37.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z37.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z37.DistanceRangeUOM = "Feet"
z37.ProximityRangeUOM = "Meters"
z37.OutOfRangeName = ""
z37.InRangeName = ""
z15 = Wherigo.Zone(objKlausraeumtauf)
z15.Id = "60af7874-b856-4040-96e4-b92bd1ae9007"
z15.Name = "15"
z15.Description = ""
z15.Visible = true
z15.Media = objtest
z15.Icon = imgT
z15.Commands = {}
z15.DistanceRange = Distance(-1, "feet")
z15.ShowObjects = "OnEnter"
z15.ProximityRange = Distance(100, "meters")
z15.AllowSetPositionTo = false
z15.Active = false
z15.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z15.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z15.DistanceRangeUOM = "Feet"
z15.ProximityRangeUOM = "Meters"
z15.OutOfRangeName = ""
z15.InRangeName = ""
z36 = Wherigo.Zone(objKlausraeumtauf)
z36.Id = "7b829d7d-2cc6-444c-bb0d-3600a074ea04"
z36.Name = "36"
z36.Description = ""
z36.Visible = true
z36.Media = objtest
z36.Icon = imgT
z36.Commands = {}
z36.DistanceRange = Distance(-1, "feet")
z36.ShowObjects = "OnEnter"
z36.ProximityRange = Distance(100, "meters")
z36.AllowSetPositionTo = false
z36.Active = false
z36.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z36.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z36.DistanceRangeUOM = "Feet"
z36.ProximityRangeUOM = "Meters"
z36.OutOfRangeName = ""
z36.InRangeName = ""
z16 = Wherigo.Zone(objKlausraeumtauf)
z16.Id = "503dfb1f-628d-4023-88dc-fbabcfde67f2"
z16.Name = "16"
z16.Description = ""
z16.Visible = true
z16.Media = objtest
z16.Icon = imgT
z16.Commands = {}
z16.DistanceRange = Distance(0, "meters")
z16.ShowObjects = "OnEnter"
z16.ProximityRange = Distance(100, "meters")
z16.AllowSetPositionTo = false
z16.Active = false
z16.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z16.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z16.DistanceRangeUOM = "Meters"
z16.ProximityRangeUOM = "Meters"
z16.OutOfRangeName = ""
z16.InRangeName = ""
z35 = Wherigo.Zone(objKlausraeumtauf)
z35.Id = "de260382-c5a0-425a-9119-85b66da89b53"
z35.Name = "35"
z35.Description = ""
z35.Visible = true
z35.Media = objtest
z35.Icon = imgT
z35.Commands = {}
z35.DistanceRange = Distance(-1, "feet")
z35.ShowObjects = "OnEnter"
z35.ProximityRange = Distance(100, "meters")
z35.AllowSetPositionTo = false
z35.Active = false
z35.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z35.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z35.DistanceRangeUOM = "Feet"
z35.ProximityRangeUOM = "Meters"
z35.OutOfRangeName = ""
z35.InRangeName = ""
z17 = Wherigo.Zone(objKlausraeumtauf)
z17.Id = "32f3010b-dad4-4db6-8589-a1ffcca5246a"
z17.Name = "17"
z17.Description = ""
z17.Visible = true
z17.Media = objtest
z17.Icon = imgT
z17.Commands = {}
z17.DistanceRange = Distance(-1, "feet")
z17.ShowObjects = "OnEnter"
z17.ProximityRange = Distance(0, "meters")
z17.AllowSetPositionTo = false
z17.Active = false
z17.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z17.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z17.DistanceRangeUOM = "Feet"
z17.ProximityRangeUOM = "Meters"
z17.OutOfRangeName = ""
z17.InRangeName = ""
z34 = Wherigo.Zone(objKlausraeumtauf)
z34.Id = "58c61d07-48c1-4070-85c8-b7c249acc6a6"
z34.Name = "34"
z34.Description = ""
z34.Visible = true
z34.Media = objtest
z34.Icon = imgT
z34.Commands = {}
z34.DistanceRange = Distance(-1, "feet")
z34.ShowObjects = "OnEnter"
z34.ProximityRange = Distance(100, "meters")
z34.AllowSetPositionTo = false
z34.Active = false
z34.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z34.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z34.DistanceRangeUOM = "Feet"
z34.ProximityRangeUOM = "Meters"
z34.OutOfRangeName = ""
z34.InRangeName = ""
z18 = Wherigo.Zone(objKlausraeumtauf)
z18.Id = "adb9ae31-10ad-4380-869c-02107fe87ae5"
z18.Name = "18"
z18.Description = ""
z18.Visible = true
z18.Media = objtest
z18.Icon = imgT
z18.Commands = {}
z18.DistanceRange = Distance(0, "meters")
z18.ShowObjects = "OnEnter"
z18.ProximityRange = Distance(100, "meters")
z18.AllowSetPositionTo = false
z18.Active = false
z18.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z18.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z18.DistanceRangeUOM = "Meters"
z18.ProximityRangeUOM = "Meters"
z18.OutOfRangeName = ""
z18.InRangeName = ""
z33 = Wherigo.Zone(objKlausraeumtauf)
z33.Id = "ab274369-1de5-4797-8574-0a896c7abbba"
z33.Name = "33"
z33.Description = ""
z33.Visible = true
z33.Media = objtest
z33.Icon = imgT
z33.Commands = {}
z33.DistanceRange = Distance(-1, "feet")
z33.ShowObjects = "OnEnter"
z33.ProximityRange = Distance(100, "meters")
z33.AllowSetPositionTo = false
z33.Active = false
z33.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z33.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z33.DistanceRangeUOM = "Feet"
z33.ProximityRangeUOM = "Meters"
z33.OutOfRangeName = ""
z33.InRangeName = ""
z19 = Wherigo.Zone(objKlausraeumtauf)
z19.Id = "7b999d88-2707-4754-9c78-dfbf13743512"
z19.Name = "19"
z19.Description = ""
z19.Visible = true
z19.Media = objtest
z19.Icon = imgT
z19.Commands = {}
z19.DistanceRange = Distance(-1, "feet")
z19.ShowObjects = "OnEnter"
z19.ProximityRange = Distance(100, "meters")
z19.AllowSetPositionTo = false
z19.Active = false
z19.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z19.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z19.DistanceRangeUOM = "Feet"
z19.ProximityRangeUOM = "Meters"
z19.OutOfRangeName = ""
z19.InRangeName = ""
z32 = Wherigo.Zone(objKlausraeumtauf)
z32.Id = "53842c17-c451-4a98-b46a-ca65992cdc09"
z32.Name = "32"
z32.Description = ""
z32.Visible = true
z32.Media = objtest
z32.Icon = imgT
z32.Commands = {}
z32.DistanceRange = Distance(-1, "feet")
z32.ShowObjects = "OnEnter"
z32.ProximityRange = Distance(100, "meters")
z32.AllowSetPositionTo = false
z32.Active = false
z32.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z32.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z32.DistanceRangeUOM = "Feet"
z32.ProximityRangeUOM = "Meters"
z32.OutOfRangeName = ""
z32.InRangeName = ""
z20 = Wherigo.Zone(objKlausraeumtauf)
z20.Id = "dc206a59-8a84-456f-8c33-f9ce5cea51a2"
z20.Name = "20"
z20.Description = ""
z20.Visible = true
z20.Media = objtest
z20.Icon = imgT
z20.Commands = {}
z20.DistanceRange = Distance(0, "meters")
z20.ShowObjects = "OnEnter"
z20.ProximityRange = Distance(100, "meters")
z20.AllowSetPositionTo = false
z20.Active = false
z20.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z20.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z20.DistanceRangeUOM = "Meters"
z20.ProximityRangeUOM = "Meters"
z20.OutOfRangeName = ""
z20.InRangeName = ""
z31 = Wherigo.Zone(objKlausraeumtauf)
z31.Id = "99040752-3ce9-4b40-8d86-5fd2841f5f32"
z31.Name = "31"
z31.Description = ""
z31.Visible = true
z31.Media = objtest
z31.Icon = imgT
z31.Commands = {}
z31.DistanceRange = Distance(-1, "feet")
z31.ShowObjects = "OnEnter"
z31.ProximityRange = Distance(100, "meters")
z31.AllowSetPositionTo = false
z31.Active = false
z31.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z31.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z31.DistanceRangeUOM = "Feet"
z31.ProximityRangeUOM = "Meters"
z31.OutOfRangeName = ""
z31.InRangeName = ""
z21 = Wherigo.Zone(objKlausraeumtauf)
z21.Id = "c831118c-2266-4841-9937-b2b33a9acc56"
z21.Name = "21"
z21.Description = ""
z21.Visible = true
z21.Media = objtest
z21.Icon = imgT
z21.Commands = {}
z21.DistanceRange = Distance(-1, "feet")
z21.ShowObjects = "OnEnter"
z21.ProximityRange = Distance(100, "meters")
z21.AllowSetPositionTo = false
z21.Active = false
z21.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z21.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z21.DistanceRangeUOM = "Feet"
z21.ProximityRangeUOM = "Meters"
z21.OutOfRangeName = ""
z21.InRangeName = ""
z30 = Wherigo.Zone(objKlausraeumtauf)
z30.Id = "daa978f9-0b1f-4f70-be7a-38264bada235"
z30.Name = "30"
z30.Description = ""
z30.Visible = true
z30.Media = objtest
z30.Icon = imgT
z30.Commands = {}
z30.DistanceRange = Distance(-1, "feet")
z30.ShowObjects = "OnEnter"
z30.ProximityRange = Distance(100, "meters")
z30.AllowSetPositionTo = false
z30.Active = false
z30.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z30.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z30.DistanceRangeUOM = "Feet"
z30.ProximityRangeUOM = "Meters"
z30.OutOfRangeName = ""
z30.InRangeName = ""
z22 = Wherigo.Zone(objKlausraeumtauf)
z22.Id = "26cf878c-6814-4c1c-a82f-8ea1130258d9"
z22.Name = "22"
z22.Description = ""
z22.Visible = true
z22.Media = objtest
z22.Icon = imgT
z22.Commands = {}
z22.DistanceRange = Distance(-1, "feet")
z22.ShowObjects = "OnEnter"
z22.ProximityRange = Distance(100, "meters")
z22.AllowSetPositionTo = false
z22.Active = false
z22.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z22.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z22.DistanceRangeUOM = "Feet"
z22.ProximityRangeUOM = "Meters"
z22.OutOfRangeName = ""
z22.InRangeName = ""
z29 = Wherigo.Zone(objKlausraeumtauf)
z29.Id = "39a301e4-e437-4c54-a65b-0ff35bde97b9"
z29.Name = "29"
z29.Description = ""
z29.Visible = true
z29.Media = objtest
z29.Icon = imgT
z29.Commands = {}
z29.DistanceRange = Distance(-1, "feet")
z29.ShowObjects = "OnEnter"
z29.ProximityRange = Distance(100, "meters")
z29.AllowSetPositionTo = false
z29.Active = false
z29.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z29.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z29.DistanceRangeUOM = "Feet"
z29.ProximityRangeUOM = "Meters"
z29.OutOfRangeName = ""
z29.InRangeName = ""
z23 = Wherigo.Zone(objKlausraeumtauf)
z23.Id = "dec59aba-7908-4707-9560-f6cd9c5a9681"
z23.Name = "23"
z23.Description = ""
z23.Visible = true
z23.Media = objtest
z23.Icon = imgT
z23.Commands = {}
z23.DistanceRange = Distance(-1, "feet")
z23.ShowObjects = "OnEnter"
z23.ProximityRange = Distance(100, "meters")
z23.AllowSetPositionTo = false
z23.Active = false
z23.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z23.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z23.DistanceRangeUOM = "Feet"
z23.ProximityRangeUOM = "Meters"
z23.OutOfRangeName = ""
z23.InRangeName = ""
z28 = Wherigo.Zone(objKlausraeumtauf)
z28.Id = "136a0c34-9fa0-4e19-8942-983dee20c12b"
z28.Name = "28"
z28.Description = ""
z28.Visible = true
z28.Media = objtest
z28.Icon = imgT
z28.Commands = {}
z28.DistanceRange = Distance(-1, "feet")
z28.ShowObjects = "OnEnter"
z28.ProximityRange = Distance(100, "meters")
z28.AllowSetPositionTo = false
z28.Active = false
z28.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z28.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z28.DistanceRangeUOM = "Feet"
z28.ProximityRangeUOM = "Meters"
z28.OutOfRangeName = ""
z28.InRangeName = ""
z24 = Wherigo.Zone(objKlausraeumtauf)
z24.Id = "373780ec-57af-4856-a73d-ac8f966660f9"
z24.Name = "24"
z24.Description = ""
z24.Visible = true
z24.Media = objtest
z24.Icon = imgT
z24.Commands = {}
z24.DistanceRange = Distance(0, "meters")
z24.ShowObjects = "OnEnter"
z24.ProximityRange = Distance(100, "meters")
z24.AllowSetPositionTo = false
z24.Active = false
z24.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z24.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z24.DistanceRangeUOM = "Meters"
z24.ProximityRangeUOM = "Meters"
z24.OutOfRangeName = ""
z24.InRangeName = ""
z27 = Wherigo.Zone(objKlausraeumtauf)
z27.Id = "edbbce10-f383-4c48-8c01-cf5a1e7e8dc1"
z27.Name = "27"
z27.Description = ""
z27.Visible = true
z27.Media = objtest
z27.Icon = imgT
z27.Commands = {}
z27.DistanceRange = Distance(-1, "feet")
z27.ShowObjects = "OnEnter"
z27.ProximityRange = Distance(100, "meters")
z27.AllowSetPositionTo = false
z27.Active = false
z27.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z27.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z27.DistanceRangeUOM = "Feet"
z27.ProximityRangeUOM = "Meters"
z27.OutOfRangeName = ""
z27.InRangeName = ""
z25 = Wherigo.Zone(objKlausraeumtauf)
z25.Id = "429a556f-ae43-48f7-871a-3402c172774c"
z25.Name = "25"
z25.Description = ""
z25.Visible = true
z25.Media = objtest
z25.Icon = imgT
z25.Commands = {}
z25.DistanceRange = Distance(-1, "feet")
z25.ShowObjects = "OnEnter"
z25.ProximityRange = Distance(100, "meters")
z25.AllowSetPositionTo = false
z25.Active = false
z25.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z25.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z25.DistanceRangeUOM = "Feet"
z25.ProximityRangeUOM = "Meters"
z25.OutOfRangeName = ""
z25.InRangeName = ""
z26 = Wherigo.Zone(objKlausraeumtauf)
z26.Id = "3b8d3ab3-b36e-4600-b18b-150094ab6d11"
z26.Name = "26"
z26.Description = ""
z26.Visible = true
z26.Media = objtest
z26.Icon = imgT
z26.Commands = {}
z26.DistanceRange = Distance(0, "meters")
z26.ShowObjects = "OnEnter"
z26.ProximityRange = Distance(100, "meters")
z26.AllowSetPositionTo = false
z26.Active = false
z26.Points = {
  ZonePoint(52.4731215581625, 13.1346631273493, 0),
  ZonePoint(52.4731219666184, 13.1346745267376, 0),
  ZonePoint(52.4731166566918, 13.1346684917673, 0)
}
z26.OriginalPoint = ZonePoint(52.4731200604909, 13.1346687152847, 0)
z26.DistanceRangeUOM = "Meters"
z26.ProximityRangeUOM = "Meters"
z26.OutOfRangeName = ""
z26.InRangeName = ""
final = Wherigo.Zone(objKlausraeumtauf)
final.Id = "7babaf5b-c8e9-4999-b7cb-00f529874de9"
final.Name = "Final"
final.Description = ""
final.Visible = false
final.Commands = {}
final.DistanceRange = Distance(-1, "feet")
final.ShowObjects = "OnEnter"
final.ProximityRange = Distance(60, "meters")
final.AllowSetPositionTo = false
final.Active = false
final.Points = {
  ZonePoint(52.4786214412581, 13.1491158018351, 0),
  ZonePoint(52.4786212370557, 13.1491825217843, 0),
  ZonePoint(52.4785814175678, 13.1491882214785, 0),
  ZonePoint(52.4785789671366, 13.1491158018351, 0)
}
final.OriginalPoint = ZonePoint(52.4786007657546, 13.1491505867333, 0)
final.DistanceRangeUOM = "Feet"
final.ProximityRangeUOM = "Meters"
final.OutOfRangeName = ""
final.InRangeName = ""
objMinesweeper = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objMinesweeper.Id = "51dce9e6-46ef-4f47-b9fa-a1a1f3b6f28a"
objMinesweeper.Name = "Minesweeper"
objMinesweeper.Description = [[
Aufraeumen der besonderen Art.<BR>
Aber Vorsicht - nicht zuviel Staub aufwirbeln,]]
objMinesweeper.Visible = true
objMinesweeper.Media = objkartegross
objMinesweeper.Icon = objicoKarte
objMinesweeper.Commands = {
  cmdspielen = Wherigo.ZCommand({
    Text = "spielen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMinesweeper.Commands.cmdspielen.Custom = true
objMinesweeper.Commands.cmdspielen.Id = "aceae0c2-0665-4764-b3ac-4fa47fcc8d9d"
objMinesweeper.Commands.cmdspielen.WorksWithAll = true
objMinesweeper.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMinesweeper.Locked = false
objMinesweeper.Opened = false
objSpoiler1 = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objSpoiler1.Id = "2193cbfa-1d64-404d-9fa9-305d13223724"
objSpoiler1.Name = "Spoiler"
objSpoiler1.Description = [[
Jetzt auf zum Ziel!<BR>
52 &nbsp;&nbsp;28.713 &nbsp;&nbsp;&nbsp;&nbsp;13 &nbsp;&nbsp;08.949]]
objSpoiler1.Visible = false
objSpoiler1.Media = objSpoiler
objSpoiler1.Icon = objicoSpoiler
objSpoiler1.Commands = {}
objSpoiler1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpoiler1.Locked = false
objSpoiler1.Opened = false
objKoordinaten1 = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objKoordinaten1.Id = "20e9d778-bd3e-46bb-83e9-700f56930b26"
objKoordinaten1.Name = "Koordinaten"
objKoordinaten1.Description = [[
Jetzt auf zum Ziel!<BR>
52 &nbsp;&nbsp;28.718 &nbsp;&nbsp;&nbsp;&nbsp;13 &nbsp;&nbsp;08.947]]
objKoordinaten1.Visible = false
objKoordinaten1.Media = objKoordinaten
objKoordinaten1.Icon = objicoKoordinaten
objKoordinaten1.Commands = {}
objKoordinaten1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKoordinaten1.Locked = false
objKoordinaten1.Opened = false
objFreischaltcode1 = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objFreischaltcode1.Id = "517020ba-bf59-45e1-9e4a-dfb46dc0a031"
objFreischaltcode1.Name = "Freischaltcode"
objFreischaltcode1.Description = ""
objFreischaltcode1.Visible = false
objFreischaltcode1.Media = objFreischaltcode
objFreischaltcode1.Icon = objicoFreischaltcode
objFreischaltcode1.Commands = {}
objFreischaltcode1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFreischaltcode1.Locked = false
objFreischaltcode1.Opened = false
objAnleitung1 = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objAnleitung1.Id = "69901ede-2a03-48e3-a3c3-b433523f2de8"
objAnleitung1.Name = "Anleitung"
objAnleitung1.Description = "Minenraeumen im vorbeigehen - oder auch aufraeumen der anderen Art"
objAnleitung1.Visible = true
objAnleitung1.Media = objAnleitung
objAnleitung1.Icon = objicoAnleitung
objAnleitung1.Commands = {
  cmdlesen = Wherigo.ZCommand({
    Text = "lesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objAnleitung1.Commands.cmdlesen.Custom = true
objAnleitung1.Commands.cmdlesen.Id = "71bba034-718b-4255-ae9c-decad8e62f22"
objAnleitung1.Commands.cmdlesen.WorksWithAll = true
objAnleitung1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAnleitung1.Locked = false
objAnleitung1.Opened = false
objKarte = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objKarte.Id = "a3850a48-39e3-418e-bad0-7b04c91fdfb9"
objKarte.Name = "Karte"
objKarte.Description = ""
objKarte.Visible = false
objKarte.Icon = objicoKarte
objKarte.Commands = {}
objKarte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKarte.Locked = false
objKarte.Opened = false
aktuellesFeld = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
aktuellesFeld.Id = "6b9ad62a-0c0f-4346-8703-b3db6ba096a2"
aktuellesFeld.Name = "aktuelles Feld"
aktuellesFeld.Description = ""
aktuellesFeld.Visible = false
aktuellesFeld.Media = objtest
aktuellesFeld.Icon = imgT
aktuellesFeld.Commands = {
  cmdsetzenFahne = Wherigo.ZCommand({
    Text = "setzen Fahne",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdnehmenFahne = Wherigo.ZCommand({
    Text = "nehmen Fahne",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  }),
  cmdaufdecken = Wherigo.ZCommand({
    Text = "aufdecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
aktuellesFeld.Commands.cmdsetzenFahne.Custom = true
aktuellesFeld.Commands.cmdsetzenFahne.Id = "37392b40-12c8-4e6d-879f-37d6940a2f30"
aktuellesFeld.Commands.cmdsetzenFahne.WorksWithAll = true
aktuellesFeld.Commands.cmdnehmenFahne.Custom = true
aktuellesFeld.Commands.cmdnehmenFahne.Id = "31caa4d8-0a59-4e7e-b9c5-98ec0c0d1429"
aktuellesFeld.Commands.cmdnehmenFahne.WorksWithAll = true
aktuellesFeld.Commands.cmdaufdecken.Custom = true
aktuellesFeld.Commands.cmdaufdecken.Id = "b9e0757c-5a82-4ad8-8d6c-3a0db463e12d"
aktuellesFeld.Commands.cmdaufdecken.WorksWithAll = true
aktuellesFeld.ObjectLocation = Wherigo.INVALID_ZONEPOINT
aktuellesFeld.Locked = false
aktuellesFeld.Opened = false
objMarkierungsfahne = Wherigo.ZItem({Cartridge = objKlausraeumtauf, Container = Player})
objMarkierungsfahne.Id = "6a9f94fa-e589-4e1f-b08f-3a1818961213"
objMarkierungsfahne.Name = "Markierungsfahne"
objMarkierungsfahne.Description = "Du hast noch 10 Fahnen"
objMarkierungsfahne.Visible = false
objMarkierungsfahne.Media = objfahne
objMarkierungsfahne.Icon = objicofahne
objMarkierungsfahne.Commands = {
  cmdsetzen = Wherigo.ZCommand({
    Text = "setzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objMarkierungsfahne.Commands.cmdsetzen.Custom = true
objMarkierungsfahne.Commands.cmdsetzen.Id = "2a9b652f-8dc8-4f81-841e-931c4ad05cac"
objMarkierungsfahne.Commands.cmdsetzen.WorksWithAll = true
objMarkierungsfahne.Commands.cmdnehmen.Custom = true
objMarkierungsfahne.Commands.cmdnehmen.Id = "d3013405-d075-4941-8128-2ad62084504e"
objMarkierungsfahne.Commands.cmdnehmen.WorksWithAll = true
objMarkierungsfahne.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMarkierungsfahne.Locked = false
objMarkierungsfahne.Opened = false
objMarkierung1 = Wherigo.ZItem(objKlausraeumtauf)
objMarkierung1.Id = "7cb462d8-40ad-46ef-925a-ba3dd84a8f06"
objMarkierung1.Name = "Markierung"
objMarkierung1.Description = [[
Hier sollte also eine Mine sein.<BR>
Also nicht aufdecken!]]
objMarkierung1.Visible = true
objMarkierung1.Media = objMarkierung
objMarkierung1.Icon = objicomarker
objMarkierung1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objMarkierung1.Commands.cmdnehmen.Custom = true
objMarkierung1.Commands.cmdnehmen.Id = "39b952bd-d24e-4a13-bd16-bec3d6e6ac0e"
objMarkierung1.Commands.cmdnehmen.WorksWithAll = true
objMarkierung1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMarkierung1.Locked = false
objMarkierung1.Opened = false
objspieleMinesweeper = Wherigo.ZTask(objKlausraeumtauf)
objspieleMinesweeper.Id = "48116977-1069-4376-8864-de7c7d671915"
objspieleMinesweeper.Name = "spiele Minesweeper"
objspieleMinesweeper.Description = ""
objspieleMinesweeper.Visible = true
objspieleMinesweeper.Media = objkartegross
objspieleMinesweeper.Icon = objicoKarte
objspieleMinesweeper.Active = true
objspieleMinesweeper.Complete = false
objspieleMinesweeper.CorrectState = "None"
objraeumeauf = Wherigo.ZTask(objKlausraeumtauf)
objraeumeauf.Id = "72c7668e-9c83-4245-8533-89e0bc7236df"
objraeumeauf.Name = "raeume auf"
objraeumeauf.Description = ""
objraeumeauf.Visible = false
objraeumeauf.Media = objKlaus
objraeumeauf.Active = true
objraeumeauf.Complete = false
objraeumeauf.CorrectState = "None"
objtrageDichinsLogbuchein = Wherigo.ZTask(objKlausraeumtauf)
objtrageDichinsLogbuchein.Id = "6be0823d-d89a-45eb-a7c6-a087c2fc9bcc"
objtrageDichinsLogbuchein.Name = "trage Dich ins Logbuch ein"
objtrageDichinsLogbuchein.Description = ""
objtrageDichinsLogbuchein.Visible = false
objtrageDichinsLogbuchein.Media = objFreischaltcode
objtrageDichinsLogbuchein.Icon = objicoFreischaltcode
objtrageDichinsLogbuchein.Active = true
objtrageDichinsLogbuchein.Complete = false
objtrageDichinsLogbuchein.CorrectState = "None"
iMinen = 10
iFahnen = 10
iZone = 25
bFlag = false
bMine = false
iSeed = 0
s0 = " &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;1 &nbsp;| &nbsp;2 &nbsp;| &nbsp;3 &nbsp;| &nbsp;4 &nbsp;| &nbsp;5 &nbsp;| &nbsp;6 &nbsp;| &nbsp;7"
sZ = "-------------------------------------------------"
s1 = ""
s5 = ""
s4 = ""
s2 = ""
s3 = ""
s6 = ""
s7 = ""
sT = "Aktuelle Position: 4, 4"
iFeldMine = 0
bLoesung = false
sZone = "xx"
x = 0
y = 0
iTimeStart = 0
iTimeStop = 0
sCR = ""
objiStd = 0
objiMin = 0
objiSek = 0
objbFirst = true
currentZone = "z01"
currentCharacter = "dummy"
currentItem = "objMinesweeper"
currentTask = "objspieleMinesweeper"
currentInput = "dummy"
currentTimer = "objName"
objKlausraeumtauf.ZVariables = {
  iMinen = 10,
  iFahnen = 10,
  iZone = 25,
  bFlag = false,
  bMine = false,
  iSeed = 0,
  s0 = " &nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;1 &nbsp;| &nbsp;2 &nbsp;| &nbsp;3 &nbsp;| &nbsp;4 &nbsp;| &nbsp;5 &nbsp;| &nbsp;6 &nbsp;| &nbsp;7",
  sZ = "-------------------------------------------------",
  s1 = "",
  s5 = "",
  s4 = "",
  s2 = "",
  s3 = "",
  s6 = "",
  s7 = "",
  sT = "Aktuelle Position: 4, 4",
  iFeldMine = 0,
  bLoesung = false,
  sZone = "xx",
  x = 0,
  y = 0,
  iTimeStart = 0,
  iTimeStop = 0,
  sCR = "",
  objiStd = 0,
  objiMin = 0,
  objiSek = 0,
  objbFirst = true,
  currentZone = "z01",
  currentCharacter = "dummy",
  currentItem = "objMinesweeper",
  currentTask = "objspieleMinesweeper",
  currentInput = "dummy",
  currentTimer = "objName"
}
objName = Wherigo.ZTimer(objKlausraeumtauf)
objName.Id = "97365719-e775-41db-91d9-4d38af94ff80"
objName.Name = "Name"
objName.Description = ""
objName.Visible = true
objName.Duration = 0
objName.Type = "Countdown"
function objKlausraeumtauf:OnStart()
  local _Urwigo_Date = os.date("*t")
  iZone = 25
  iSeed = _Urwigo.Date_SecondInHour(_Urwigo_Date)
  initZufall()
  _Urwigo.OldDialog({
    {
      Text = [[
Du willst mir beim aufraeumen helfen? Das finde ich super.<BR>
<BR>
Es ist ganz einfach. In meinem Zimmer sind 10 Dinge versteckt, die ich unbedingt wegraeumen muss. Wenn Du glaubst, eines gefunden zu haben, setze eine Fahne.<BR>
Wenn Du alle Fahnen gesetzt hast, lade ich Dich auf einen Drink ein.<BR>
Wenn nicht, dann halt nicht.]],
      Media = objKlaus
    },
    {
      Text = [[
Falls Dir etwas unklar ist, lies einfach nochmal die Anleitung durch.<BR>
<BR>
Und ich wuerde mich wirklich freuen, wenn Du mir beim aufraeumen helfen wuerdest!]],
      Media = objKlaus
    }
  })
end
function objKlausraeumtauf:OnRestore()
end
function z01:OnEnter()
  currentZone = "z01"
  _Urwigo.GlobalZoneEnter()
end
function z02:OnEnter()
  currentZone = "z02"
  _Urwigo.GlobalZoneEnter()
end
function z49:OnEnter()
  currentZone = "z49"
  _Urwigo.GlobalZoneEnter()
end
function z03:OnEnter()
  currentZone = "z03"
  _Urwigo.GlobalZoneEnter()
end
function z48:OnEnter()
  currentZone = "z48"
  _Urwigo.GlobalZoneEnter()
end
function z04:OnEnter()
  currentZone = "z04"
  _Urwigo.GlobalZoneEnter()
end
function z47:OnEnter()
  currentZone = "z47"
  _Urwigo.GlobalZoneEnter()
end
function z05:OnEnter()
  currentZone = "z05"
  _Urwigo.GlobalZoneEnter()
end
function z46:OnEnter()
  currentZone = "z46"
  _Urwigo.GlobalZoneEnter()
end
function z06:OnEnter()
  currentZone = "z06"
  _Urwigo.GlobalZoneEnter()
end
function z45:OnEnter()
  currentZone = "z45"
  _Urwigo.GlobalZoneEnter()
end
function z07:OnEnter()
  currentZone = "z07"
  _Urwigo.GlobalZoneEnter()
end
function z44:OnEnter()
  currentZone = "z44"
  _Urwigo.GlobalZoneEnter()
end
function z08:OnEnter()
  currentZone = "z08"
  _Urwigo.GlobalZoneEnter()
end
function z43:OnEnter()
  currentZone = "z43"
  _Urwigo.GlobalZoneEnter()
end
function z09:OnEnter()
  currentZone = "z09"
  _Urwigo.GlobalZoneEnter()
end
function z42:OnEnter()
  currentZone = "z42"
  _Urwigo.GlobalZoneEnter()
end
function z10:OnEnter()
  currentZone = "z10"
  _Urwigo.GlobalZoneEnter()
end
function z41:OnEnter()
  currentZone = "z41"
  _Urwigo.GlobalZoneEnter()
end
function z11:OnEnter()
  currentZone = "z11"
  _Urwigo.GlobalZoneEnter()
end
function z40:OnEnter()
  currentZone = "z40"
  _Urwigo.GlobalZoneEnter()
end
function z12:OnEnter()
  currentZone = "z12"
  _Urwigo.GlobalZoneEnter()
end
function z39:OnEnter()
  currentZone = "z39"
  _Urwigo.GlobalZoneEnter()
end
function z13:OnEnter()
  currentZone = "z13"
  _Urwigo.GlobalZoneEnter()
end
function z38:OnEnter()
  currentZone = "z38"
  _Urwigo.GlobalZoneEnter()
end
function z14:OnEnter()
  currentZone = "z14"
  _Urwigo.GlobalZoneEnter()
end
function z37:OnEnter()
  currentZone = "z37"
  _Urwigo.GlobalZoneEnter()
end
function z15:OnEnter()
  currentZone = "z15"
  _Urwigo.GlobalZoneEnter()
end
function z36:OnEnter()
  currentZone = "z36"
  _Urwigo.GlobalZoneEnter()
end
function z16:OnEnter()
  currentZone = "z16"
  _Urwigo.GlobalZoneEnter()
end
function z35:OnEnter()
  currentZone = "z35"
  _Urwigo.GlobalZoneEnter()
end
function z17:OnEnter()
  currentZone = "z17"
  _Urwigo.GlobalZoneEnter()
end
function z34:OnEnter()
  currentZone = "z34"
  _Urwigo.GlobalZoneEnter()
end
function z18:OnEnter()
  currentZone = "z18"
  _Urwigo.GlobalZoneEnter()
end
function z33:OnEnter()
  currentZone = "z33"
  _Urwigo.GlobalZoneEnter()
end
function z19:OnEnter()
  currentZone = "z19"
  _Urwigo.GlobalZoneEnter()
end
function z32:OnEnter()
  currentZone = "z32"
  _Urwigo.GlobalZoneEnter()
end
function z20:OnEnter()
  currentZone = "z20"
  _Urwigo.GlobalZoneEnter()
end
function z31:OnEnter()
  currentZone = "z31"
  _Urwigo.GlobalZoneEnter()
end
function z21:OnEnter()
  currentZone = "z21"
  _Urwigo.GlobalZoneEnter()
end
function z30:OnEnter()
  currentZone = "z30"
  _Urwigo.GlobalZoneEnter()
end
function z22:OnEnter()
  currentZone = "z22"
  _Urwigo.GlobalZoneEnter()
end
function z29:OnEnter()
  currentZone = "z29"
  _Urwigo.GlobalZoneEnter()
end
function z23:OnEnter()
  currentZone = "z23"
  _Urwigo.GlobalZoneEnter()
end
function z28:OnEnter()
  currentZone = "z28"
  _Urwigo.GlobalZoneEnter()
end
function z24:OnEnter()
  currentZone = "z24"
  _Urwigo.GlobalZoneEnter()
end
function z27:OnEnter()
  currentZone = "z27"
  _Urwigo.GlobalZoneEnter()
end
function z25:OnEnter()
  currentZone = "z25"
  _Urwigo.GlobalZoneEnter()
end
function z26:OnEnter()
  currentZone = "z26"
  _Urwigo.GlobalZoneEnter()
end
function final:OnEnter()
  currentZone = "final"
  _Urwigo.GlobalZoneEnter()
end
function objMinesweeper:Oncmdspielen(target)
  Wherigo.PlayAudio(obj_intro)
  objMinesweeper.Commands.cmdspielen.Enabled = false
  objMarkierungsfahne.Visible = true
  _Urwigo.MessageBox({
    Text = Player.Name .. ", Du willst mir helfen? Warte - ich schau mal nach ...",
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        initFeld()
        objspieleMinesweeper.Visible = false
        objraeumeauf.Visible = true
        objKarte.Visible = true
        objMinesweeper.Visible = false
        aktuellesFeld.Visible = true
        AnzeigeInit()
        objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ
        iZone = 25
        _Urwigo.MessageBox({
          Text = [[
Oh ja!<BR>
Hier gibt es einiges zum aufraeumen!]],
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              local _Urwigo_Date = os.date("*t")
              iTimeStart = _Urwigo.Date_SecondInYear(_Urwigo_Date)
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objAnleitung1:Oncmdlesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = [[
Ziel des Spiels<BR>
<BR>
Auf dem 7x7-Spielfeld sind 10 Minen versteckt.<BR>
Gehe in die entsprechende Zone und setze eine Fahne.<BR>
Wenn Du alle Fahnen verteilt hast, sagt Dir Klaus, ob Du alle Fahnen richtig gesetzt hast.]]
    },
    {
      Text = [[
Start des Spiels<BR>
<BR>
Suche ein freies Feld mit einer Groesse von mindestens 80m x 80m.<BR>
Gehe in die Mitte und starte Minesweeper.<BR>
Damit wird das Spielfeld erzeugt und die Minen verteilt.<BR>
Du befindest Dich in der Mitte des Spielfeldes.]]
    },
    {
      Text = [[
Minen suchen<BR>
<BR>
Sobald Du eine Zone betreten hast, kannst Du in der aktuellen Umgebung eine Fahne setzen, eine Fahne nehmen oder aufdecken.<BR>
Sollte die Zone eine Mine enthalten, hast Du beim Aufdecken Pech. Andernfalls wird Dir angezeigt, wieviele Minen sich in der Umgebung befinden.]]
    },
    {
      Text = [[
Karte<BR>
<BR>
Deine Karte zeigt Dir jeweils Deine aktuelle Position sowie de bisher aufgedeckten Zonen an.<BR>
Fuer jede aufgedeckte Zone wird angezeigt, wieviele Minen sich in der Umgebung befinden.]]
    },
    {
      Text = [[
Ende des Spiels<BR>
<BR>
Das Spiel endet automatisch, wenn Du alle Fahnen richtig gesetzt hast.]]
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function aktuellesFeld:OncmdsetzenFahne(target)
  iZone = tonumber(_G[currentZone].Name)
  _G[currentZone].Media = imgF
  _G[currentZone].Icon = imgF
  aktuellesFeld.Media = imgF
  aktuellesFeld.Icon = imgF
  objMarkierung1:MoveTo(_G[currentZone])
  FahneSetzen(iZone)
  objMarkierungsfahne.Description = ("Du hast noch " .. iFahnen) .. " Fahnen."
  aktuellesFeld.Commands.cmdnehmenFahne.Enabled = true
  aktuellesFeld.Commands.cmdsetzenFahne.Enabled = false
  objMarkierungsfahne.Commands.cmdnehmen.Enabled = true
  objMarkierungsfahne.Commands.cmdsetzen.Enabled = false
  objMarkierung1.Commands.cmdnehmen.Enabled = true
  AnzeigeTitel()
  sT = (("Aktuelle Position: " .. x) .. ",") .. y
  AnzeigeBody()
  objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
  if iFahnen == 0 then
    CheckLoesung()
    _Urwigo.MessageBox({
      Text = Player.Name .. ", Du hast also alle Fahnen gesetzt. Mal sehen, ob sie auch richtig stecken!",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          local _Urwigo_Date = os.date("*t")
          if bLoesung == true then
            iTimeStop = _Urwigo.Date_SecondInYear(_Urwigo_Date)
            objiSek = iTimeStop - iTimeStart
            objiMin = _Urwigo.Floor(objiSek / 60, 0)
            objiSek = objiSek - 60 * objiMin
            objiStd = _Urwigo.Floor(objiMin / 60, 0)
            objiMin = objiMin - 60 * objiStd
            Wherigo.PlayAudio(obj_tusch)
            _Urwigo.MessageBox({
              Text = ((((((Player.Name .. [[
, Du hast die Fahnen richtig gesetzt!<BR>
Herzlichen Glueckwunsch!<BR>
Du hast alle Minen gefunden!<BR>
<BR>
Deine Zeit: ]]) .. objiStd) .. " Std &nbsp;") .. objiMin) .. " Min &nbsp;") .. objiSek) .. " Sek",
              Media = objKlaus,
              Callback = function(action)
                if action ~= nil then
                  final.Active = true
                  final.Visible = true
                  ZonenAus()
                  objKoordinaten1.Visible = true
                  objraeumeauf.Complete = true
                  objKlausraeumtauf.Complete = true
                  objAnleitung1.Visible = false
                  objtrageDichinsLogbuchein.Visible = true
                  aktuellesFeld.Visible = false
                  objMarkierungsfahne.Visible = false
                  objKarte.Visible = false
                  objKlausraeumtauf:RequestSync()
                  objFreischaltcode1.Description = (Player.Name .. ", Dein Freischaltcode ist ") .. string.sub(Player.CompletionCode, 1, 15)
                  objFreischaltcode1.Visible = true
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = Player.Name .. [[
, Du hast die Fahnen leider nicht richtig gesetzt!<BR>
Irgendwo ist noch eine Mine nicht gefunden!]],
              Media = objKlaus,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          end
        end
      end
    })
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function aktuellesFeld:OncmdnehmenFahne(target)
  iZone = tonumber(_G[currentZone].Name)
  FahneNehmen(iZone)
  objMarkierung1:MoveTo(final)
  objMarkierungsfahne.Description = ("Du hast noch " .. iFahnen) .. " Fahnen."
  _G[currentZone].Media = objtest
  _G[currentZone].Icon = imgT
  aktuellesFeld.Media = objtest
  aktuellesFeld.Icon = imgT
  aktuellesFeld.Commands.cmdsetzenFahne.Enabled = true
  aktuellesFeld.Commands.cmdnehmenFahne.Enabled = false
  objMarkierungsfahne.Commands.cmdsetzen.Enabled = true
  objMarkierungsfahne.Commands.cmdnehmen.Enabled = false
  objMarkierung1.Commands.cmdnehmen.Enabled = false
  AnzeigeTitel()
  sT = (("Aktuelle Position: " .. x) .. ",") .. y
  AnzeigeBody()
  objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function aktuellesFeld:Oncmdaufdecken(target)
  CheckZone()
  if objbFirst == true then
    objbFirst = false
    if bMine == false then
      if iFeldMine == 0 then
        z25.Icon = img0
        z25.Description = "Es sind 0 Minen in der Umgebung"
        Aufdecken(25)
      elseif iFeldMine == 1 then
        z25.Icon = img1
        z25.Description = "Es sind Minen in der Umgebung: 1"
      elseif iFeldMine == 2 then
        z25.Icon = img2
        z25.Description = "Es sind Minen in der Umgebung: 2"
      elseif iFeldMine == 3 then
        z25.Icon = img3
        z25.Description = "Es sind Minen in der Umgebung: 3"
      elseif iFeldMine == 4 then
        z25.Icon = img4
        z25.Description = "Es sind Minen in der Umgebung: 4"
      elseif iFeldMine == 5 then
        z25.Icon = img5
        z25.Description = "Es sind Minen in der Umgebung: 5"
      elseif iFeldMine == 6 then
        z25.Icon = img6
        z25.Description = "Es sind Minen in der Umgebung: 6"
      elseif iFeldMine == 7 then
        z25.Icon = img7
        z25.Description = "Es sind Minen in der Umgebung: 7"
      else
        z25.Icon = img8
        z25.Description = "Es sind Minen in der Umgebung: 8"
      end
      z25.Media = z25.Icon
      aktuellesFeld.Description = z25.Description
      aktuellesFeld.Media = z25.Icon
      aktuellesFeld.Icon = z25.Icon
      AnzeigeTitel()
      sT = (("Aktuelle Position: " .. x) .. ",") .. y
      AnzeigeBody()
      objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
      _Urwigo.MessageBox({
        Text = [[
Glueckwunsch - keine Mine.<BR>
Aber:]] .. z25.Description,
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      Wherigo.PlayAudio(obj_explosion)
      objraeumeauf.Visible = false
      objKarte.Visible = false
      objMarkierungsfahne.Visible = false
      aktuellesFeld.Visible = false
      _Urwigo.Dialog(false, {
        {Text = "", Media = objexplosion},
        {
          Text = "Schade. Leider verloren!",
          Media = objKlaus
        }
      }, function(action)
        ZonenAus()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  elseif bMine == false then
    if iFeldMine == 0 then
      _G[currentZone].Icon = img0
      _G[currentZone].Description = "Es sind 0 Minen in der Umgebung"
      Aufdecken(iZone)
    elseif iFeldMine == 1 then
      _G[currentZone].Icon = img1
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 1"
    elseif iFeldMine == 2 then
      _G[currentZone].Icon = img2
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 2"
    elseif iFeldMine == 3 then
      _G[currentZone].Icon = img3
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 3"
    elseif iFeldMine == 4 then
      _G[currentZone].Icon = img4
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 4"
    elseif iFeldMine == 5 then
      _G[currentZone].Icon = img5
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 5"
    elseif iFeldMine == 6 then
      _G[currentZone].Icon = img6
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 6"
    elseif iFeldMine == 7 then
      _G[currentZone].Icon = img7
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 7"
    else
      _G[currentZone].Icon = img8
      _G[currentZone].Description = "Es sind Minen in der Umgebung: 8"
    end
    _G[currentZone].Media = _G[currentZone].Icon
    aktuellesFeld.Description = _G[currentZone].Description
    aktuellesFeld.Media = _G[currentZone].Icon
    aktuellesFeld.Icon = _G[currentZone].Icon
    AnzeigeTitel()
    sT = (("Aktuelle Position: " .. x) .. ",") .. y
    AnzeigeBody()
    objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
    _Urwigo.MessageBox({
      Text = [[
Glueckwunsch - keine Mine.<BR>
Aber:<BR>
]] .. _G[currentZone].Description,
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(obj_explosion)
    objAnleitung1.Visible = false
    objraeumeauf.Visible = false
    objKarte.Visible = false
    objMarkierungsfahne.Visible = false
    aktuellesFeld.Visible = false
    _Urwigo.Dialog(false, {
      {Text = "", Media = objexplosion},
      {
        Text = "Schade. Leider verloren!",
        Media = objKlaus
      }
    }, function(action)
      ZonenAus()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objMarkierungsfahne:Oncmdsetzen(target)
  iZone = tonumber(_G[currentZone].Name)
  _G[currentZone].Icon = imgF
  _G[currentZone].Media = imgF
  aktuellesFeld.Icon = imgF
  aktuellesFeld.Media = imgF
  objMarkierung1:MoveTo(_G[currentZone])
  FahneSetzen(iZone)
  objMarkierungsfahne.Description = ("Du hast noch " .. iFahnen) .. " Fahnen."
  aktuellesFeld.Commands.cmdnehmenFahne.Enabled = true
  aktuellesFeld.Commands.cmdsetzenFahne.Enabled = false
  objMarkierungsfahne.Commands.cmdnehmen.Enabled = true
  objMarkierungsfahne.Commands.cmdsetzen.Enabled = false
  objMarkierung1.Commands.cmdnehmen.Enabled = true
  AnzeigeTitel()
  sT = (("Aktuelle Position: " .. x) .. ",") .. y
  AnzeigeBody()
  objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
  if iFahnen == 0 then
    CheckLoesung()
    _Urwigo.MessageBox({
      Text = Player.Name .. ", Du hast also alle Fahnen gesetzt. Mal sehen, ob sie auch richtig stecken!",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          local _Urwigo_Date = os.date("*t")
          if bLoesung == true then
            iTimeStop = _Urwigo.Date_SecondInYear(_Urwigo_Date)
            objiSek = iTimeStop - iTimeStart
            objiMin = _Urwigo.Floor(objiSek / 60, 0)
            objiSek = objiSek - 60 * objiMin
            objiStd = _Urwigo.Floor(objiMin / 60, 0)
            objiMin = objiMin - 60 * objiStd
            Wherigo.PlayAudio(obj_tusch)
            _Urwigo.MessageBox({
              Text = ((((((Player.Name .. [[
, Du hast die Fahnen richtig gesetzt!<BR>
Herzlichen Glueckwunsch!<BR>
Du hast alle Minen gefunden!<BR>
<BR>
Deine Zeit: ]]) .. objiStd) .. " Std &nbsp;") .. objiMin) .. " Min &nbsp;") .. objiSek) .. " Sek",
              Media = objKlaus,
              Callback = function(action)
                if action ~= nil then
                  final.Active = true
                  final.Visible = true
                  ZonenAus()
                  objKoordinaten1.Visible = true
                  objMarkierungsfahne.Visible = false
                  aktuellesFeld.Visible = false
                  objraeumeauf.Complete = true
                  objKlausraeumtauf.Complete = true
                  objtrageDichinsLogbuchein.Visible = true
                  objAnleitung1.Visible = false
                  objKarte.Visible = false
                  objKlausraeumtauf:RequestSync()
                  objFreischaltcode1.Description = (Player.Name .. ", Dein Freischaltcode ist ") .. string.sub(Player.CompletionCode, 1, 15)
                  objFreischaltcode1.Visible = true
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = Player.Name .. [[
, Du hast die Fahnen leider nicht richtig gesetzt!<BR>
Irgendwo ist noch eine Mine nicht gefunden!]],
              Media = objKlaus,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          end
        end
      end
    })
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function objMarkierungsfahne:Oncmdnehmen(target)
  iZone = tonumber(_G[currentZone].Name)
  FahneNehmen(iZone)
  objMarkierung1:MoveTo(final)
  objMarkierungsfahne.Description = ("Du hast noch " .. iFahnen) .. " Fahnen."
  _G[currentZone].Icon = imgT
  aktuellesFeld.Icon = imgT
  _G[currentZone].Media = objtest
  aktuellesFeld.Media = objtest
  aktuellesFeld.Commands.cmdsetzenFahne.Enabled = true
  aktuellesFeld.Commands.cmdnehmenFahne.Enabled = false
  objMarkierungsfahne.Commands.cmdsetzen.Enabled = true
  objMarkierungsfahne.Commands.cmdnehmen.Enabled = false
  objMarkierung1.Commands.cmdnehmen.Enabled = false
  AnzeigeTitel()
  sT = (("Aktuelle Position: " .. x) .. ",") .. y
  AnzeigeBody()
  objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objMarkierung1:Oncmdnehmen(target)
  iZone = tonumber(_G[currentZone].Name)
  FahneNehmen(iZone)
  objMarkierung1:MoveTo(final)
  objMarkierungsfahne.Description = ("Du hast noch " .. iFahnen) .. " Fahnen."
  _G[currentZone].Icon = imgT
  aktuellesFeld.Icon = imgT
  _G[currentZone].Media = objtest
  aktuellesFeld.Media = objtest
  aktuellesFeld.Commands.cmdsetzenFahne.Enabled = true
  aktuellesFeld.Commands.cmdnehmenFahne.Enabled = false
  objMarkierungsfahne.Commands.cmdsetzen.Enabled = true
  objMarkierungsfahne.Commands.cmdnehmen.Enabled = false
  objMarkierung1.Commands.cmdnehmen.Enabled = false
  AnzeigeTitel()
  sT = (("Aktuelle Position: " .. x) .. ",") .. y
  AnzeigeBody()
  objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _Urwigo.GlobalZoneEnter()
  sZone = _G[currentZone].Name
  if Wherigo.NoCaseEquals(sZone, "final") then
    objSpoiler1.Visible = true
    Wherigo.PlayAudio(obj_tusch)
  else
    BestimmeZone(sZone)
    CheckFahne(iZone)
    AnzeigeTitel()
    sT = (("Aktuelle Position: " .. x) .. ",") .. y
    AnzeigeBody()
    objKarte.Description = ((((((((((((((((((((((((((((((((sT .. sCR) .. sCR) .. s0) .. sCR) .. sZ) .. sCR) .. s7) .. sCR) .. sZ) .. sCR) .. s6) .. sCR) .. sZ) .. sCR) .. s5) .. sCR) .. sZ) .. sCR) .. s4) .. sCR) .. sZ) .. sCR) .. s3) .. sCR) .. sZ) .. sCR) .. s2) .. sCR) .. sZ) .. sCR) .. s1) .. sCR) .. sZ
    aktuellesFeld.Icon = _G[currentZone].Icon
    aktuellesFeld.Media = _G[currentZone].Media
    aktuellesFeld.Description = "Aktuelle Zone: " .. _G[currentZone].Name
    if bFlag == false then
      aktuellesFeld.Commands.cmdnehmenFahne.Enabled = false
      objMarkierungsfahne.Commands.cmdnehmen.Enabled = false
      if iFahnen == 0 then
        aktuellesFeld.Commands.cmdsetzenFahne.Enabled = false
        objMarkierungsfahne.Commands.cmdsetzen.Enabled = false
      else
        aktuellesFeld.Commands.cmdsetzenFahne.Enabled = true
        objMarkierungsfahne.Commands.cmdsetzen.Enabled = true
      end
    else
      aktuellesFeld.Commands.cmdnehmenFahne.Enabled = true
      aktuellesFeld.Commands.cmdsetzenFahne.Enabled = false
      objMarkierung1:MoveTo(_G[currentZone])
      objMarkierungsfahne.Commands.cmdnehmen.Enabled = true
      objMarkierungsfahne.Commands.cmdsetzen.Enabled = false
      objMarkierung1.Commands.cmdnehmen.Enabled = true
    end
  end
end
i = 0
m = 0
p = ZonePoint(0, 0, 0)
sCR = "<BR>\n"
sZ = "-------------------------------------------------"
feldM = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = 0,
  [17] = 0,
  [18] = 0,
  [19] = 0,
  [20] = 0,
  [21] = 0,
  [22] = 0,
  [23] = 0,
  [24] = 0,
  [25] = 0,
  [26] = 0,
  [27] = 0,
  [28] = 0,
  [29] = 0,
  [30] = 0,
  [31] = 0,
  [32] = 0,
  [33] = 0,
  [34] = 0,
  [35] = 0,
  [36] = 0,
  [37] = 0,
  [38] = 0,
  [39] = 0,
  [40] = 0,
  [41] = 0,
  [42] = 0,
  [43] = 0,
  [44] = 0,
  [45] = 0,
  [46] = 0,
  [47] = 0,
  [48] = 0,
  [49] = 0,
  [50] = 0
}
feldK = {
  [1] = p,
  [2] = p,
  [3] = p,
  [4] = p,
  [5] = p,
  [6] = p,
  [7] = p,
  [8] = p,
  [9] = p,
  [10] = p,
  [11] = p,
  [12] = p,
  [13] = p,
  [14] = p,
  [15] = p,
  [16] = p,
  [17] = p,
  [18] = p,
  [19] = p,
  [20] = p,
  [21] = p,
  [22] = p,
  [23] = p,
  [24] = p,
  [25] = p,
  [26] = p,
  [27] = p,
  [28] = p,
  [29] = p,
  [30] = p,
  [31] = p,
  [32] = p,
  [33] = p,
  [34] = p,
  [35] = p,
  [36] = p,
  [37] = p,
  [38] = p,
  [39] = p,
  [40] = p,
  [41] = p,
  [42] = p,
  [43] = p,
  [44] = p,
  [45] = p,
  [46] = p,
  [47] = p,
  [48] = p,
  [49] = p,
  [50] = p
}
feldC = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = 0,
  [17] = 0,
  [18] = 0,
  [19] = 0,
  [20] = 0,
  [21] = 0,
  [22] = 0,
  [23] = 0,
  [24] = 0,
  [25] = 0,
  [26] = 0,
  [27] = 0,
  [28] = 0,
  [29] = 0,
  [30] = 0,
  [31] = 0,
  [32] = 0,
  [33] = 0,
  [34] = 0,
  [35] = 0,
  [36] = 0,
  [37] = 0,
  [38] = 0,
  [39] = 0,
  [40] = 0,
  [41] = 0,
  [42] = 0,
  [43] = 0,
  [44] = 0,
  [45] = 0,
  [46] = 0,
  [47] = 0,
  [48] = 0,
  [49] = 0,
  [50] = 0
}
feldA = {
  [1] = " &nbsp;&nbsp;",
  [2] = " &nbsp;&nbsp;",
  [3] = " &nbsp;&nbsp;",
  [4] = " &nbsp;&nbsp;",
  [5] = " &nbsp;&nbsp;",
  [6] = " &nbsp;&nbsp;",
  [7] = " &nbsp;&nbsp;",
  [8] = " &nbsp;&nbsp;",
  [9] = " &nbsp;&nbsp;",
  [10] = " &nbsp;&nbsp;",
  [11] = " &nbsp;&nbsp;",
  [12] = " &nbsp;&nbsp;",
  [13] = " &nbsp;&nbsp;",
  [14] = " &nbsp;&nbsp;",
  [15] = " &nbsp;&nbsp;",
  [16] = " &nbsp;&nbsp;",
  [17] = " &nbsp;&nbsp;",
  [18] = " &nbsp;&nbsp;",
  [19] = " &nbsp;&nbsp;",
  [20] = " &nbsp;&nbsp;",
  [21] = " &nbsp;&nbsp;",
  [22] = " &nbsp;&nbsp;",
  [23] = " &nbsp;&nbsp;",
  [24] = " &nbsp;&nbsp;",
  [25] = " &nbsp;&nbsp;",
  [26] = " &nbsp;&nbsp;",
  [27] = " &nbsp;&nbsp;",
  [28] = " &nbsp;&nbsp;",
  [29] = " &nbsp;&nbsp;",
  [30] = " &nbsp;&nbsp;",
  [31] = " &nbsp;&nbsp;",
  [32] = " &nbsp;&nbsp;",
  [33] = " &nbsp;&nbsp;",
  [34] = " &nbsp;&nbsp;",
  [35] = " &nbsp;&nbsp;",
  [36] = " &nbsp;&nbsp;",
  [37] = " &nbsp;&nbsp;",
  [38] = " &nbsp;&nbsp;",
  [39] = " &nbsp;&nbsp;",
  [40] = " &nbsp;&nbsp;",
  [41] = " &nbsp;&nbsp;",
  [42] = " &nbsp;&nbsp;",
  [43] = " &nbsp;&nbsp;",
  [44] = " &nbsp;&nbsp;",
  [45] = " &nbsp;&nbsp;",
  [46] = " &nbsp;&nbsp;",
  [47] = " &nbsp;&nbsp;",
  [48] = " &nbsp;&nbsp;",
  [49] = " &nbsp;&nbsp;",
  [50] = " &nbsp;&nbsp;"
}
feldF = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = 0,
  [6] = 0,
  [7] = 0,
  [8] = 0,
  [9] = 0,
  [10] = 0,
  [11] = 0,
  [12] = 0,
  [13] = 0,
  [14] = 0,
  [15] = 0,
  [16] = 0,
  [17] = 0,
  [18] = 0,
  [19] = 0,
  [20] = 0,
  [21] = 0,
  [22] = 0,
  [23] = 0,
  [24] = 0,
  [25] = 0,
  [26] = 0,
  [27] = 0,
  [28] = 0,
  [29] = 0,
  [30] = 0,
  [31] = 0,
  [32] = 0,
  [33] = 0,
  [34] = 0,
  [35] = 0,
  [36] = 0,
  [37] = 0,
  [38] = 0,
  [39] = 0,
  [40] = 0,
  [41] = 0,
  [42] = 0,
  [43] = 0,
  [44] = 0,
  [45] = 0,
  [46] = 0,
  [47] = 0,
  [48] = 0,
  [49] = 0,
  [50] = 0
}
feldZ = {
  [1] = z01,
  [2] = z02,
  [3] = z03,
  [4] = z04,
  [5] = z05,
  [6] = z06,
  [7] = z07,
  [8] = z08,
  [9] = z09,
  [10] = z10,
  [11] = z11,
  [12] = z12,
  [13] = z13,
  [14] = z14,
  [15] = z15,
  [16] = z16,
  [17] = z17,
  [18] = z18,
  [19] = z19,
  [20] = z20,
  [21] = z21,
  [22] = z22,
  [23] = z23,
  [24] = z24,
  [25] = z25,
  [26] = z26,
  [27] = z27,
  [28] = z28,
  [29] = z29,
  [30] = z30,
  [31] = z31,
  [32] = z32,
  [33] = z33,
  [34] = z34,
  [35] = z35,
  [36] = z36,
  [37] = z37,
  [38] = z38,
  [39] = z39,
  [40] = z40,
  [41] = z41,
  [42] = z42,
  [43] = z43,
  [44] = z44,
  [45] = z45,
  [46] = z46,
  [47] = z47,
  [48] = z48,
  [49] = z49,
  [50] = z50
}
feldI = {
  [1] = img0,
  [2] = img1,
  [3] = img2,
  [4] = img3,
  [5] = img4,
  [6] = img5,
  [7] = img6,
  [8] = img7,
  [9] = img8
}
function initZufall()
  math.randomseed(iSeed)
end
function initFeld()
  local dist = Wherigo.Distance(0, "m")
  feldK[25] = Player.ObjectLocation
  feldK[22] = GetPoint(feldK[25], 30, 270)
  feldK[1] = GetPoint(feldK[22], 30, 180)
  for y = 1, 7 do
    for x = 2, 7 do
      feldK[(y - 1) * 7 + x] = GetPoint(feldK[(y - 1) * 7 + x - 1], 10, 90)
    end
    feldK[y * 7 + 1] = GetPoint(feldK[(y - 1) * 7 + 1], 10, 0)
  end
  for x = 1, 49 do
    feldM[x] = 0
    feldA[x] = " &nbsp;&nbsp;"
  end
  iMinen = 10
  while 0 < iMinen do
    y = math.random(49)
    if y ~= 25 and feldM[y] == 0 then
      feldM[y] = 1
      iMinen = iMinen - 1
    end
  end
  iMinen = 10
  feldC[1] = feldM[8] + feldM[9] + feldM[2]
  feldC[43] = feldM[36] + feldM[37] + feldM[44]
  feldC[49] = feldM[48] + feldM[41] + feldM[42]
  feldC[7] = feldM[6] + feldM[13] + feldM[14]
  feldC[2] = feldM[1] + feldM[8] + feldM[9] + feldM[10] + feldM[3]
  feldC[3] = feldM[2] + feldM[9] + feldM[10] + feldM[11] + feldM[4]
  feldC[4] = feldM[3] + feldM[10] + feldM[11] + feldM[12] + feldM[5]
  feldC[5] = feldM[4] + feldM[11] + feldM[12] + feldM[13] + feldM[6]
  feldC[6] = feldM[5] + feldM[12] + feldM[13] + feldM[14] + feldM[7]
  feldC[8] = feldM[1] + feldM[2] + feldM[9] + feldM[15] + feldM[16]
  feldC[15] = feldM[8] + feldM[9] + feldM[16] + feldM[22] + feldM[23]
  feldC[22] = feldM[15] + feldM[16] + feldM[23] + feldM[29] + feldM[30]
  feldC[29] = feldM[22] + feldM[23] + feldM[30] + feldM[36] + feldM[37]
  feldC[36] = feldM[29] + feldM[30] + feldM[37] + feldM[43] + feldM[44]
  feldC[44] = feldM[43] + feldM[45] + feldM[36] + feldM[37] + feldM[38]
  feldC[45] = feldM[44] + feldM[46] + feldM[37] + feldM[38] + feldM[39]
  feldC[46] = feldM[45] + feldM[47] + feldM[38] + feldM[39] + feldM[40]
  feldC[47] = feldM[46] + feldM[48] + feldM[39] + feldM[40] + feldM[41]
  feldC[48] = feldM[47] + feldM[49] + feldM[40] + feldM[41] + feldM[42]
  feldC[14] = feldM[6] + feldM[7] + feldM[13] + feldM[20] + feldM[21]
  feldC[21] = feldM[13] + feldM[14] + feldM[20] + feldM[27] + feldM[28]
  feldC[28] = feldM[20] + feldM[21] + feldM[27] + feldM[34] + feldM[35]
  feldC[35] = feldM[27] + feldM[28] + feldM[34] + feldM[41] + feldM[42]
  feldC[42] = feldM[34] + feldM[35] + feldM[41] + feldM[48] + feldM[49]
  for y = 2, 6 do
    for x = 2, 6 do
      i = (y - 1) * 7 + x
      feldC[i] = feldM[i - 1] + feldM[i + 1] + feldM[i + 7] + feldM[i - 7] + feldM[i - 8] + feldM[i + 8] + feldM[i - 6] + feldM[i + 6]
    end
  end
  for x = 1, 49 do
    feldZ[x].Active = false
    feldZ[x].OriginalPoint = Wherigo.TranslatePoint(feldK[x], dist, 0)
    feldZ[x].Points = GetZonePoints(feldK[x])
    feldZ[x].Active = true
  end
end
function GetPoint(refPt, entf, winkel)
  local dist = Wherigo.Distance(entf, "m")
  return Wherigo.TranslatePoint(refPt, dist, winkel)
end
function GetZonePoints(refPt)
  local dist = Wherigo.Distance(4, "m")
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
function CheckZone()
  iFeldMine = feldC[iZone]
  feldA[iZone] = tostring(feldC[iZone])
  bMine = false
  if feldM[iZone] == 1 then
    bMine = true
  end
end
function CheckFahne()
  bFlag = false
  if feldF[iZone] == 1 then
    bFlag = true
  end
end
function FahneSetzen(Zone)
  feldF[Zone] = 1
  iFahnen = iFahnen - 1
  feldA[Zone] = "x"
end
function FahneNehmen(Zone)
  feldF[Zone] = 0
  iFahnen = iFahnen + 1
  feldA[Zone] = " &nbsp;&nbsp;"
end
function ZonenAus()
  for x = 1, 49 do
    feldZ[x].Active = false
  end
end
function AnzeigeInit()
  sT = "Aktuelle Position: &nbsp;4, 4"
  s1 = "1 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s2 = "2 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s3 = "3 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s4 = "4 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s5 = "5 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s6 = "6 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
  s7 = "7 &nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|"
end
function BestimmeZone(paramsz)
  iZone = tonumber(paramsz)
end
function AnzeigeTitel()
  x = iZone % 7
  if x == 0 then
    x = 7
  end
  y = iZone - x
  y = y / 7
  y = y + 1
end
function AnzeigeBody()
  s1 = "1 &nbsp;| &nbsp;" .. feldA[1]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[2]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[3]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[4]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[5]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[6]
  s1 = (s1 .. " &nbsp;| &nbsp;") .. feldA[7]
  s2 = "2 &nbsp;| &nbsp;" .. feldA[8]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[9]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[10]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[11]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[12]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[13]
  s2 = (s2 .. " &nbsp;| &nbsp;") .. feldA[14]
  s3 = "3 &nbsp;| &nbsp;" .. feldA[15]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[16]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[17]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[18]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[19]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[20]
  s3 = (s3 .. " &nbsp;| &nbsp;") .. feldA[21]
  s4 = "4 &nbsp;| &nbsp;" .. feldA[22]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[23]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[24]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[25]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[26]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[27]
  s4 = (s4 .. " &nbsp;| &nbsp;") .. feldA[28]
  s5 = "5 &nbsp;| &nbsp;" .. feldA[29]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[30]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[31]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[32]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[33]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[34]
  s5 = (s5 .. " &nbsp;| &nbsp;") .. feldA[35]
  s6 = "6 &nbsp;| &nbsp;" .. feldA[36]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[37]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[38]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[39]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[40]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[41]
  s6 = (s6 .. " &nbsp;| &nbsp;") .. feldA[42]
  s7 = "7 &nbsp;| &nbsp;" .. feldA[43]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[44]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[45]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[46]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[47]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[48]
  s7 = (s7 .. " &nbsp;| &nbsp;") .. feldA[49]
end
function CheckLoesung()
  local richtig = 0
  bLoesung = false
  for i = 1, 49 do
    if feldM[i] == 1 and feldF[i] == 1 then
      richtig = richtig + 1
    end
  end
  if richtig == 10 then
    bLoesung = true
  end
end
function MarkiereFeld(Position)
  if feldC[Position] == 0 then
    feldA[Position] = "- "
    feldZ[Position].Description = "Es sind 0 Minen in der Umgebung: "
  else
    feldA[Position] = tostring(feldC[Position])
    feldZ[Position].Description = "Es sind Minen in der Umgebung: " .. tostring(feldC[Position])
  end
  feldZ[Position].Icon = feldI[1 + feldC[Position]]
  feldZ[Position].Image = feldI[1 + feldC[Position]]
end
function Aufdecken(aktzone)
  if feldC[aktzone] == 0 then
    feldA[aktzone] = "- "
    x = aktzone % 7
    if x == 0 then
      x = 7
    end
    y = aktzone - x
    y = y / 7
    y = y + 1
    if y == 7 and x == 1 then
      MarkiereFeld(44)
      MarkiereFeld(36)
      MarkiereFeld(37)
    elseif y == 7 and x == 7 then
      MarkiereFeld(48)
      MarkiereFeld(41)
      MarkiereFeld(42)
    elseif y == 1 and x == 1 then
      MarkiereFeld(8)
      MarkiereFeld(9)
      MarkiereFeld(2)
    elseif y == 1 and x == 7 then
      MarkiereFeld(6)
      MarkiereFeld(13)
      MarkiereFeld(14)
    elseif y == 7 then
      MarkiereFeld(42 + x - 1)
      MarkiereFeld(42 + x + 1)
      MarkiereFeld(35 + x - 1)
      MarkiereFeld(35 + x)
      MarkiereFeld(35 + x + 1)
    elseif y == 1 then
      MarkiereFeld(x - 1)
      MarkiereFeld(x + 1)
      MarkiereFeld(7 + x - 1)
      MarkiereFeld(7 + x)
      MarkiereFeld(7 + x + 1)
    elseif x == 1 then
      MarkiereFeld((y - 1) * 7 + 1 - 7)
      MarkiereFeld((y - 1) * 7 + 1 + 7)
      MarkiereFeld((y - 1) * 7 + 1 - 7 + 1)
      MarkiereFeld((y - 1) * 7 + 1 + 7 + 1)
      MarkiereFeld((y - 1) * 7 + 1)
    elseif x == 7 then
      MarkiereFeld(y * 7 - 7)
      MarkiereFeld(y * 7 + 7)
      MarkiereFeld(y * 7 - 1)
      MarkiereFeld(y * 7 + 7 - 1)
      MarkiereFeld(y * 7 - 1)
    else
      MarkiereFeld(y * 7 + x - 1)
      MarkiereFeld(y * 7 + x)
      MarkiereFeld(y * 7 + x + 1)
      MarkiereFeld((y - 1) * 7 + x - 1)
      MarkiereFeld((y - 1) * 7 + x + 1)
      MarkiereFeld((y - 2) * 7 + x - 1)
      MarkiereFeld((y - 2) * 7 + x)
      MarkiereFeld((y - 2) * 7 + x + 1)
    end
  end
end
return objKlausraeumtauf
