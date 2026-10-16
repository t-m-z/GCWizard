require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _aOx0(str)
  local res = ""
  local dtable = "eB:\006UI(r\002w8[/0JRnC\001M*7X+\023LV`\017\028mzx&_$kS3\031\n\024A\\Nhig\f9H]|\0294'Dq,d1Zsl\aK6E\016YT\v\020Qy}#b>a\021\b~\005jWP\003\000)\026F\030-<\018\014o@\015O!\027\t\" \019=\r2v.t^?ufcp%5{;\004\022\025G"
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
KlausKlabuster = Wherigo.ZCartridge()
obj_audioTheme = Wherigo.ZMedia(KlausKlabuster)
obj_audioTheme.Id = "8595be45-0965-43bc-ba8c-fa3b960f78ad"
obj_audioTheme.Name = "_audio Theme"
obj_audioTheme.Description = ""
obj_audioTheme.AltText = ""
obj_audioTheme.Resources = {
  {
    Type = "mp3",
    Filename = "ThemeTandy.mp3",
    Directives = {}
  }
}
objKlaus = Wherigo.ZMedia(KlausKlabuster)
objKlaus.Id = "615ef02e-e34d-4224-885b-fb23009e571e"
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
objDoll = Wherigo.ZMedia(KlausKlabuster)
objDoll.Id = "251de38b-bb54-4835-90fd-3ac705c7f977"
objDoll.Name = "Doll"
objDoll.Description = ""
objDoll.AltText = ""
objDoll.Resources = {
  {
    Type = "jpg",
    Filename = "puppe.jpg",
    Directives = {}
  }
}
objEve = Wherigo.ZMedia(KlausKlabuster)
objEve.Id = "8ddde5a0-6c04-44e2-88cd-b9b2d5734814"
objEve.Name = "Eve"
objEve.Description = ""
objEve.AltText = ""
objEve.Resources = {
  {
    Type = "jpg",
    Filename = "eve.jpg",
    Directives = {}
  }
}
objFawn = Wherigo.ZMedia(KlausKlabuster)
objFawn.Id = "e9803762-1a5c-4f9a-a9c0-3d116c8125fa"
objFawn.Name = "Fawn"
objFawn.Description = ""
objFawn.AltText = ""
objFawn.Resources = {
  {
    Type = "jpg",
    Filename = "fawn.jpg",
    Directives = {}
  }
}
objHotel = Wherigo.ZMedia(KlausKlabuster)
objHotel.Id = "01c3be83-3ac6-4269-93b7-369021e32132"
objHotel.Name = "Hotel"
objHotel.Description = ""
objHotel.AltText = ""
objHotel.Resources = {
  {
    Type = "jpg",
    Filename = "hotel.jpg",
    Directives = {}
  }
}
objBar = Wherigo.ZMedia(KlausKlabuster)
objBar.Id = "4f42442b-ce01-4595-9f55-7092acbf7216"
objBar.Name = "Bar"
objBar.Description = ""
objBar.AltText = ""
objBar.Resources = {
  {
    Type = "jpg",
    Filename = "blauemaus.jpg",
    Directives = {}
  }
}
objMarktplatz = Wherigo.ZMedia(KlausKlabuster)
objMarktplatz.Id = "f8d6b201-1c94-4399-826c-e5172adce47b"
objMarktplatz.Name = "Marktplatz"
objMarktplatz.Description = ""
objMarktplatz.AltText = ""
objMarktplatz.Resources = {
  {
    Type = "jpg",
    Filename = "Marktplatz.jpg",
    Directives = {}
  }
}
objKirche = Wherigo.ZMedia(KlausKlabuster)
objKirche.Id = "6bb644a9-457d-4327-83f4-9401f45dcbd3"
objKirche.Name = "Kirche"
objKirche.Description = ""
objKirche.AltText = ""
objKirche.Resources = {
  {
    Type = "jpg",
    Filename = "kirche.jpg",
    Directives = {}
  }
}
objCasino = Wherigo.ZMedia(KlausKlabuster)
objCasino.Id = "bbcc2982-003c-4254-abef-640b1ae5f5a8"
objCasino.Name = "Casino"
objCasino.Description = ""
objCasino.AltText = ""
objCasino.Resources = {
  {
    Type = "jpg",
    Filename = "casino.jpg",
    Directives = {}
  }
}
objicohotel = Wherigo.ZMedia(KlausKlabuster)
objicohotel.Id = "b4cd8e2b-e03b-4cb1-b4be-e3c599a223d1"
objicohotel.Name = "ico-hotel"
objicohotel.Description = ""
objicohotel.AltText = ""
objicohotel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hotel.jpg",
    Directives = {}
  }
}
objicocasino = Wherigo.ZMedia(KlausKlabuster)
objicocasino.Id = "4270f424-5c01-466e-bd9f-95599268c4c2"
objicocasino.Name = "ico-casino"
objicocasino.Description = ""
objicocasino.AltText = ""
objicocasino.Resources = {
  {
    Type = "jpg",
    Filename = "ico-casino.jpg",
    Directives = {}
  }
}
objicoblauemaus = Wherigo.ZMedia(KlausKlabuster)
objicoblauemaus.Id = "429cd640-52d3-4885-86b0-17b84b7252d5"
objicoblauemaus.Name = "ico-blauemaus"
objicoblauemaus.Description = ""
objicoblauemaus.AltText = ""
objicoblauemaus.Resources = {
  {
    Type = "jpg",
    Filename = "ico-blauemaus.jpg",
    Directives = {}
  }
}
objicomarktplatz = Wherigo.ZMedia(KlausKlabuster)
objicomarktplatz.Id = "64ae5410-6bde-4315-a4e4-c29e1eafa464"
objicomarktplatz.Name = "ico-marktplatz"
objicomarktplatz.Description = ""
objicomarktplatz.AltText = ""
objicomarktplatz.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Marktplatz.jpg",
    Directives = {}
  }
}
objicoKirche = Wherigo.ZMedia(KlausKlabuster)
objicoKirche.Id = "135cc43d-eaa3-430b-bc19-4eb055526cd5"
objicoKirche.Name = "ico-Kirche"
objicoKirche.Description = ""
objicoKirche.AltText = ""
objicoKirche.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kirche.jpg",
    Directives = {}
  }
}
objWhiskey = Wherigo.ZMedia(KlausKlabuster)
objWhiskey.Id = "b13ed800-1669-4203-8158-c89aec7837ab"
objWhiskey.Name = "Whiskey"
objWhiskey.Description = ""
objWhiskey.AltText = ""
objWhiskey.Resources = {
  {
    Type = "jpg",
    Filename = "whiskey.jpg",
    Directives = {}
  }
}
objicoTitel = Wherigo.ZMedia(KlausKlabuster)
objicoTitel.Id = "df02415c-95e6-4e8a-bb13-4443d2ad4cc2"
objicoTitel.Name = "ico-Titel"
objicoTitel.Description = ""
objicoTitel.AltText = ""
objicoTitel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Titel.jpg",
    Directives = {}
  }
}
objHammer = Wherigo.ZMedia(KlausKlabuster)
objHammer.Id = "8c9db39e-b083-4946-9ffc-74ff47e64f55"
objHammer.Name = "Hammer"
objHammer.Description = ""
objHammer.AltText = ""
objHammer.Resources = {
  {
    Type = "jpg",
    Filename = "hammer.jpg",
    Directives = {}
  }
}
objicohammer = Wherigo.ZMedia(KlausKlabuster)
objicohammer.Id = "60131dde-6508-4c2e-b9da-1d11e1b87326"
objicohammer.Name = "ico-hammer"
objicohammer.Description = ""
objicohammer.AltText = ""
objicohammer.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hammer.jpg",
    Directives = {}
  }
}
objGeldbeutel = Wherigo.ZMedia(KlausKlabuster)
objGeldbeutel.Id = "3492d7cf-f857-4267-9d8a-5071134786a3"
objGeldbeutel.Name = "Geldbeutel"
objGeldbeutel.Description = ""
objGeldbeutel.AltText = ""
objGeldbeutel.Resources = {
  {
    Type = "jpg",
    Filename = "geldbeutel.jpg",
    Directives = {}
  }
}
objicogeldbeutel = Wherigo.ZMedia(KlausKlabuster)
objicogeldbeutel.Id = "b57b9414-5583-40bf-bd16-c41862b54762"
objicogeldbeutel.Name = "ico-geldbeutel"
objicogeldbeutel.Description = ""
objicogeldbeutel.AltText = ""
objicogeldbeutel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-geldbeutel.jpg",
    Directives = {}
  }
}
objApfel = Wherigo.ZMedia(KlausKlabuster)
objApfel.Id = "32fb785f-40eb-408e-baf6-df1c3cbc4673"
objApfel.Name = "Apfel"
objApfel.Description = ""
objApfel.AltText = ""
objApfel.Resources = {
  {
    Type = "jpg",
    Filename = "apfel.jpg",
    Directives = {}
  }
}
objicoapfel = Wherigo.ZMedia(KlausKlabuster)
objicoapfel.Id = "bf614d84-ccba-4ab8-b103-47d51e1b416c"
objicoapfel.Name = "ico-apfel"
objicoapfel.Description = ""
objicoapfel.AltText = ""
objicoapfel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-apfel.jpg",
    Directives = {}
  }
}
objAtemspray = Wherigo.ZMedia(KlausKlabuster)
objAtemspray.Id = "82ef02f5-fe9c-4cb7-99b4-5dfc8548471e"
objAtemspray.Name = "Atemspray"
objAtemspray.Description = ""
objAtemspray.AltText = ""
objAtemspray.Resources = {
  {
    Type = "jpg",
    Filename = "atemspray.jpg",
    Directives = {}
  }
}
objicoatemspray = Wherigo.ZMedia(KlausKlabuster)
objicoatemspray.Id = "407bde7d-21ef-4b6d-9bda-3885c0825635"
objicoatemspray.Name = "ico-atemspray"
objicoatemspray.Description = ""
objicoatemspray.AltText = ""
objicoatemspray.Resources = {
  {
    Type = "jpg",
    Filename = "ico-atemspray.jpg",
    Directives = {}
  }
}
objicowhiskey = Wherigo.ZMedia(KlausKlabuster)
objicowhiskey.Id = "3666eaa7-e66b-48be-bc72-1cb17948ccca"
objicowhiskey.Name = "ico-whiskey"
objicowhiskey.Description = ""
objicowhiskey.AltText = ""
objicowhiskey.Resources = {
  {
    Type = "jpg",
    Filename = "ico-whiskey.jpg",
    Directives = {}
  }
}
objWein = Wherigo.ZMedia(KlausKlabuster)
objWein.Id = "c47cdbf8-b494-4489-96d3-dab1e6efc516"
objWein.Name = "Wein"
objWein.Description = ""
objWein.AltText = ""
objWein.Resources = {
  {
    Type = "jpg",
    Filename = "weinflasche.jpg",
    Directives = {}
  }
}
objWeinglass = Wherigo.ZMedia(KlausKlabuster)
objWeinglass.Id = "18365ea5-bd44-4d57-a1ea-fb7cf30a5fd5"
objWeinglass.Name = "Weinglass"
objWeinglass.Description = ""
objWeinglass.AltText = ""
objWeinglass.Resources = {
  {
    Type = "jpg",
    Filename = "weinglas.jpg",
    Directives = {}
  }
}
objBierglass = Wherigo.ZMedia(KlausKlabuster)
objBierglass.Id = "2bb59f2e-f0e9-45b0-ae32-74b0883c72fa"
objBierglass.Name = "Bierglass"
objBierglass.Description = ""
objBierglass.AltText = ""
objBierglass.Resources = {
  {
    Type = "jpg",
    Filename = "bierglas.jpg",
    Directives = {}
  }
}
objBartender = Wherigo.ZMedia(KlausKlabuster)
objBartender.Id = "1b20f858-bd48-49d9-9930-ea7bfe6684b9"
objBartender.Name = "Bartender"
objBartender.Description = ""
objBartender.AltText = ""
objBartender.Resources = {
  {
    Type = "jpg",
    Filename = "bartender.jpg",
    Directives = {}
  }
}
objFernbedienung = Wherigo.ZMedia(KlausKlabuster)
objFernbedienung.Id = "66dfe663-eaac-4f3b-b502-22e0a67cc2aa"
objFernbedienung.Name = "Fernbedienung"
objFernbedienung.Description = ""
objFernbedienung.AltText = ""
objFernbedienung.Resources = {
  {
    Type = "jpg",
    Filename = "fernbedienung.jpg",
    Directives = {}
  }
}
objicofernbedienung = Wherigo.ZMedia(KlausKlabuster)
objicofernbedienung.Id = "fa15ad00-4009-40e6-bd5b-3e5dc6f23704"
objicofernbedienung.Name = "ico-fernbedienung"
objicofernbedienung.Description = ""
objicofernbedienung.AltText = ""
objicofernbedienung.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernbedienung.jpg",
    Directives = {}
  }
}
objKondom = Wherigo.ZMedia(KlausKlabuster)
objKondom.Id = "7a7490c2-6ce3-452f-9e46-0f5151c559d4"
objKondom.Name = "Kondom"
objKondom.Description = ""
objKondom.AltText = ""
objKondom.Resources = {
  {
    Type = "jpg",
    Filename = "kondom.jpg",
    Directives = {}
  }
}
objicokondom = Wherigo.ZMedia(KlausKlabuster)
objicokondom.Id = "95644ed2-f214-4564-b116-d4330dcb9bdb"
objicokondom.Name = "ico-kondom"
objicokondom.Description = ""
objicokondom.AltText = ""
objicokondom.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kondom.jpg",
    Directives = {}
  }
}
objPralinen = Wherigo.ZMedia(KlausKlabuster)
objPralinen.Id = "3a92a523-4c5c-413f-b567-1760b45ca46a"
objPralinen.Name = "Pralinen"
objPralinen.Description = ""
objPralinen.AltText = ""
objPralinen.Resources = {
  {
    Type = "jpg",
    Filename = "pralinen.jpg",
    Directives = {}
  }
}
objicopralinen = Wherigo.ZMedia(KlausKlabuster)
objicopralinen.Id = "4526eaf6-174b-4129-aee4-0eced02a0e51"
objicopralinen.Name = "ico-pralinen"
objicopralinen.Description = ""
objicopralinen.AltText = ""
objicopralinen.Resources = {
  {
    Type = "jpg",
    Filename = "ico-pralinen.jpg",
    Directives = {}
  }
}
objTaschentuch = Wherigo.ZMedia(KlausKlabuster)
objTaschentuch.Id = "fde86872-86f1-478f-ac51-62b539eb7374"
objTaschentuch.Name = "Taschentuch"
objTaschentuch.Description = ""
objTaschentuch.AltText = ""
objTaschentuch.Resources = {
  {
    Type = "jpg",
    Filename = "taschentuch.jpg",
    Directives = {}
  }
}
objicotaschentuch = Wherigo.ZMedia(KlausKlabuster)
objicotaschentuch.Id = "c7a4d48b-6e8f-4f7d-a4ab-fa09ef42784d"
objicotaschentuch.Name = "ico-taschentuch"
objicotaschentuch.Description = ""
objicotaschentuch.AltText = ""
objicotaschentuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-taschentuch.jpg",
    Directives = {}
  }
}
objarmbanduhr = Wherigo.ZMedia(KlausKlabuster)
objarmbanduhr.Id = "21e800c2-60a6-4c25-a81c-916baab214a7"
objarmbanduhr.Name = "armbanduhr"
objarmbanduhr.Description = ""
objarmbanduhr.AltText = ""
objarmbanduhr.Resources = {
  {
    Type = "jpg",
    Filename = "armbanduhr.jpg",
    Directives = {}
  }
}
objicoarmbanduhr = Wherigo.ZMedia(KlausKlabuster)
objicoarmbanduhr.Id = "0bbf290b-70b9-49b1-9626-2c24086e36b4"
objicoarmbanduhr.Name = "ico-armbanduhr"
objicoarmbanduhr.Description = ""
objicoarmbanduhr.AltText = ""
objicoarmbanduhr.Resources = {
  {
    Type = "jpg",
    Filename = "ico-armbanduhr.jpg",
    Directives = {}
  }
}
objGasse = Wherigo.ZMedia(KlausKlabuster)
objGasse.Id = "2d98dc8f-7df4-4b81-93bb-2ce613d384a0"
objGasse.Name = "Gasse"
objGasse.Description = ""
objGasse.AltText = ""
objGasse.Resources = {
  {
    Type = "jpg",
    Filename = "gasse.jpg",
    Directives = {}
  }
}
objicogasse = Wherigo.ZMedia(KlausKlabuster)
objicogasse.Id = "283436e9-35ca-4f98-8553-b6418dd8c119"
objicogasse.Name = "ico-gasse"
objicogasse.Description = ""
objicogasse.AltText = ""
objicogasse.Resources = {
  {
    Type = "jpg",
    Filename = "ico-gasse.jpg",
    Directives = {}
  }
}
objBarraum = Wherigo.ZMedia(KlausKlabuster)
objBarraum.Id = "7e5c43e4-4ce7-461b-b235-8ae82c6bc3e9"
objBarraum.Name = "Barraum"
objBarraum.Description = ""
objBarraum.AltText = ""
objBarraum.Resources = {
  {
    Type = "jpg",
    Filename = "bar-innen.jpg",
    Directives = {}
  }
}
objbarflur = Wherigo.ZMedia(KlausKlabuster)
objbarflur.Id = "a788276f-9926-42b1-a8cb-7d892f005099"
objbarflur.Name = "bar-flur"
objbarflur.Description = ""
objbarflur.AltText = ""
objbarflur.Resources = {
  {
    Type = "jpg",
    Filename = "bar-flur.jpg",
    Directives = {}
  }
}
objbartoilette = Wherigo.ZMedia(KlausKlabuster)
objbartoilette.Id = "0ee0a0b4-2da5-4b29-b003-766400549ae7"
objbartoilette.Name = "bar-toilette"
objbartoilette.Description = ""
objbartoilette.AltText = ""
objbartoilette.Resources = {
  {
    Type = "jpg",
    Filename = "bar-toilette.jpg",
    Directives = {}
  }
}
objbarzimmer = Wherigo.ZMedia(KlausKlabuster)
objbarzimmer.Id = "7be0090f-73eb-4eb4-8398-de7b6dd78790"
objbarzimmer.Name = "bar-zimmer"
objbarzimmer.Description = ""
objbarzimmer.AltText = ""
objbarzimmer.Resources = {
  {
    Type = "jpg",
    Filename = "bar-zimmer-hure.jpg",
    Directives = {}
  }
}
objbartreppenhaustuersteher = Wherigo.ZMedia(KlausKlabuster)
objbartreppenhaustuersteher.Id = "4a0a2da6-14b1-44fa-84b4-ca02fa47e925"
objbartreppenhaustuersteher.Name = "bar-treppenhaus-tuersteher"
objbartreppenhaustuersteher.Description = ""
objbartreppenhaustuersteher.AltText = ""
objbartreppenhaustuersteher.Resources = {
  {
    Type = "jpg",
    Filename = "bar-treppe-tursteher.jpg",
    Directives = {}
  }
}
objbartreppenhaus = Wherigo.ZMedia(KlausKlabuster)
objbartreppenhaus.Id = "f5b6f87f-5fb9-438a-bdc0-62cc5b835623"
objbartreppenhaus.Name = "bar-treppenhaus"
objbartreppenhaus.Description = ""
objbartreppenhaus.AltText = ""
objbartreppenhaus.Resources = {
  {
    Type = "jpg",
    Filename = "bar-treppe.jpg",
    Directives = {}
  }
}
objicoeve = Wherigo.ZMedia(KlausKlabuster)
objicoeve.Id = "f0420a76-9eb1-4220-9ebf-a59cc7e44082"
objicoeve.Name = "ico-eve"
objicoeve.Description = ""
objicoeve.AltText = ""
objicoeve.Resources = {
  {
    Type = "jpg",
    Filename = "ico-eve.jpg",
    Directives = {}
  }
}
objMusikbox = Wherigo.ZMedia(KlausKlabuster)
objMusikbox.Id = "9ec99ddc-f1f4-42be-bf91-4d06c5f5b87f"
objMusikbox.Name = "Musikbox"
objMusikbox.Description = ""
objMusikbox.AltText = ""
objMusikbox.Resources = {
  {
    Type = "jpg",
    Filename = "musicbox.jpg",
    Directives = {}
  }
}
objHund = Wherigo.ZMedia(KlausKlabuster)
objHund.Id = "adca3607-0afc-4475-9beb-02f8b893f0c5"
objHund.Name = "Hund"
objHund.Description = ""
objHund.AltText = ""
objHund.Resources = {
  {
    Type = "jpg",
    Filename = "hund-sitzend.jpg",
    Directives = {}
  }
}
objHundpissend = Wherigo.ZMedia(KlausKlabuster)
objHundpissend.Id = "da717acd-696d-4d8f-960c-943d26addd34"
objHundpissend.Name = "Hund-pissend"
objHundpissend.Description = ""
objHundpissend.AltText = ""
objHundpissend.Resources = {
  {
    Type = "jpg",
    Filename = "hund-pisst.jpg",
    Directives = {}
  }
}
objicoBarraum = Wherigo.ZMedia(KlausKlabuster)
objicoBarraum.Id = "95af71b2-1605-4932-bdc5-b871aac8ebbf"
objicoBarraum.Name = "ico-Barraum"
objicoBarraum.Description = ""
objicoBarraum.AltText = ""
objicoBarraum.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-innen.jpg",
    Directives = {}
  }
}
objbarfrau = Wherigo.ZMedia(KlausKlabuster)
objbarfrau.Id = "37f6b7f9-6db8-4622-99d8-06a599581c95"
objbarfrau.Name = "bar-frau"
objbarfrau.Description = ""
objbarfrau.AltText = ""
objbarfrau.Resources = {
  {
    Type = "jpg",
    Filename = "bar-frau.jpg",
    Directives = {}
  }
}
objfraubetrunken = Wherigo.ZMedia(KlausKlabuster)
objfraubetrunken.Id = "925836ed-fdaf-466d-8c5c-b319cf25e0e1"
objfraubetrunken.Name = "frau-betrunken"
objfraubetrunken.Description = ""
objfraubetrunken.AltText = ""
objfraubetrunken.Resources = {
  {
    Type = "jpg",
    Filename = "frau-betrunken.jpg",
    Directives = {}
  }
}
objbardunkel = Wherigo.ZMedia(KlausKlabuster)
objbardunkel.Id = "2a598b3e-8b7d-4686-a0a9-615ba6730d25"
objbardunkel.Name = "bar-dunkel"
objbardunkel.Description = ""
objbardunkel.AltText = ""
objbardunkel.Resources = {
  {
    Type = "jpg",
    Filename = "blauemaus-dunkel.jpg",
    Directives = {}
  }
}
objLarry = Wherigo.ZMedia(KlausKlabuster)
objLarry.Id = "11953cb4-4961-4cc9-a3ed-5c199b0fe514"
objLarry.Name = "Larry"
objLarry.Description = ""
objLarry.AltText = ""
objLarry.Resources = {
  {
    Type = "jpg",
    Filename = "leisure-suit-larry.jpg",
    Directives = {}
  }
}
objTitelbild = Wherigo.ZMedia(KlausKlabuster)
objTitelbild.Id = "c6377750-7962-401e-a975-b95ae5d7341c"
objTitelbild.Name = "Titelbild"
objTitelbild.Description = ""
objTitelbild.AltText = ""
objTitelbild.Resources = {
  {
    Type = "jpg",
    Filename = "Titel.jpg",
    Directives = {}
  }
}
objFSK18 = Wherigo.ZMedia(KlausKlabuster)
objFSK18.Id = "f31fb1f2-083f-444e-b993-28d57e0cbddc"
objFSK18.Name = "FSK18"
objFSK18.Description = ""
objFSK18.AltText = ""
objFSK18.Resources = {
  {
    Type = "jpg",
    Filename = "FSK_ab_18.jpg",
    Directives = {}
  }
}
objicobartender = Wherigo.ZMedia(KlausKlabuster)
objicobartender.Id = "c9435062-9b22-41b9-98f1-22b80926c2f9"
objicobartender.Name = "ico-bartender"
objicobartender.Description = ""
objicobartender.AltText = ""
objicobartender.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bartender.jpg",
    Directives = {}
  }
}
objicobarfrau = Wherigo.ZMedia(KlausKlabuster)
objicobarfrau.Id = "10c83856-6f21-4007-94db-eb782cf9e4d2"
objicobarfrau.Name = "ico-bar-frau"
objicobarfrau.Description = ""
objicobarfrau.AltText = ""
objicobarfrau.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-frau.jpg",
    Directives = {}
  }
}
objicofraubetrunken = Wherigo.ZMedia(KlausKlabuster)
objicofraubetrunken.Id = "9e5db225-eaf9-4722-b422-36af75c27d2d"
objicofraubetrunken.Name = "ico-frau-betrunken"
objicofraubetrunken.Description = ""
objicofraubetrunken.AltText = ""
objicofraubetrunken.Resources = {
  {
    Type = "jpg",
    Filename = "ico-frau-betrunken.jpg",
    Directives = {}
  }
}
objbarflurbetrunken = Wherigo.ZMedia(KlausKlabuster)
objbarflurbetrunken.Id = "8b266225-155f-4873-bd80-7865439194c9"
objbarflurbetrunken.Name = "bar-flur-betrunken"
objbarflurbetrunken.Description = ""
objbarflurbetrunken.AltText = ""
objbarflurbetrunken.Resources = {
  {
    Type = "jpg",
    Filename = "bar-flur-betrunkene.jpg",
    Directives = {}
  }
}
objicomusikbox = Wherigo.ZMedia(KlausKlabuster)
objicomusikbox.Id = "3f83db3a-0dc4-4790-9a9f-6eeec11c7e2f"
objicomusikbox.Name = "ico-musikbox"
objicomusikbox.Description = ""
objicomusikbox.AltText = ""
objicomusikbox.Resources = {
  {
    Type = "jpg",
    Filename = "ico-musicbox.jpg",
    Directives = {}
  }
}
objHure = Wherigo.ZMedia(KlausKlabuster)
objHure.Id = "8cc74c1c-7558-4b1d-b768-6dd78b641e7f"
objHure.Name = "Hure"
objHure.Description = ""
objHure.AltText = ""
objHure.Resources = {
  {
    Type = "jpg",
    Filename = "hure.jpg",
    Directives = {}
  }
}
objicohure = Wherigo.ZMedia(KlausKlabuster)
objicohure.Id = "7b9969f3-699f-4bff-a89e-b25a19b7ba38"
objicohure.Name = "ico-hure"
objicohure.Description = ""
objicohure.AltText = ""
objicohure.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hure.jpg",
    Directives = {}
  }
}
objicobarzimmerhure = Wherigo.ZMedia(KlausKlabuster)
objicobarzimmerhure.Id = "5b52efa0-9e02-4671-a940-55085a578acd"
objicobarzimmerhure.Name = "ico-bar-zimmer-hure"
objicobarzimmerhure.Description = ""
objicobarzimmerhure.AltText = ""
objicobarzimmerhure.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-zimmer-hure.jpg",
    Directives = {}
  }
}
objRose = Wherigo.ZMedia(KlausKlabuster)
objRose.Id = "6675a7f6-b6b2-4a05-853e-867d601ae5f5"
objRose.Name = "Rose"
objRose.Description = ""
objRose.AltText = ""
objRose.Resources = {
  {
    Type = "jpg",
    Filename = "rose.jpg",
    Directives = {}
  }
}
objicoRose = Wherigo.ZMedia(KlausKlabuster)
objicoRose.Id = "0e20a10b-559c-41b4-ab83-4499f0f110fc"
objicoRose.Name = "ico-Rose"
objicoRose.Description = ""
objicoRose.AltText = ""
objicoRose.Resources = {
  {
    Type = "jpg",
    Filename = "ico-rose.jpg",
    Directives = {}
  }
}
obj_audiostrullern = Wherigo.ZMedia(KlausKlabuster)
obj_audiostrullern.Id = "9ec37942-2598-4e9e-ad5a-7864d874697c"
obj_audiostrullern.Name = "_audio strullern"
obj_audiostrullern.Description = ""
obj_audiostrullern.AltText = ""
obj_audiostrullern.Resources = {
  {
    Type = "mp3",
    Filename = "strullern.mp3",
    Directives = {}
  }
}
objBestellung = Wherigo.ZMedia(KlausKlabuster)
objBestellung.Id = "f12e8789-4e4b-4c47-891d-f09fdd185414"
objBestellung.Name = "Bestellung"
objBestellung.Description = ""
objBestellung.AltText = ""
objBestellung.Resources = {
  {
    Type = "jpg",
    Filename = "Bestellung.jpg",
    Directives = {}
  }
}
objicobartreppe = Wherigo.ZMedia(KlausKlabuster)
objicobartreppe.Id = "3b287176-c04f-40cf-bf3e-99b55f59f59e"
objicobartreppe.Name = "ico-bar-treppe"
objicobartreppe.Description = ""
objicobartreppe.AltText = ""
objicobartreppe.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-treppe.jpg",
    Directives = {}
  }
}
objicoFernseher = Wherigo.ZMedia(KlausKlabuster)
objicoFernseher.Id = "923cb0ef-31cd-4460-96fa-518f9adc72ba"
objicoFernseher.Name = "ico-Fernseher"
objicoFernseher.Description = ""
objicoFernseher.AltText = ""
objicoFernseher.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernseher.jpg",
    Directives = {}
  }
}
objfernseheran = Wherigo.ZMedia(KlausKlabuster)
objfernseheran.Id = "bed61557-665a-4808-bde8-b3a2ccb53a3d"
objfernseheran.Name = "fernseher-an"
objfernseheran.Description = ""
objfernseheran.AltText = ""
objfernseheran.Resources = {
  {
    Type = "jpg",
    Filename = "fernseher.jpg",
    Directives = {}
  }
}
objTuer = Wherigo.ZMedia(KlausKlabuster)
objTuer.Id = "e33c527e-154a-4191-a2b0-974625b9216d"
objTuer.Name = "Tuer"
objTuer.Description = ""
objTuer.AltText = ""
objTuer.Resources = {
  {
    Type = "jpg",
    Filename = "tur.jpg",
    Directives = {}
  }
}
objtoilettenschussel = Wherigo.ZMedia(KlausKlabuster)
objtoilettenschussel.Id = "4108f028-c363-4c9d-9707-3ec07fbbef72"
objtoilettenschussel.Name = "toilettenschussel"
objtoilettenschussel.Description = ""
objtoilettenschussel.AltText = ""
objtoilettenschussel.Resources = {
  {
    Type = "jpg",
    Filename = "toilette-schussel.jpg",
    Directives = {}
  }
}
objtoilettewaschbecken = Wherigo.ZMedia(KlausKlabuster)
objtoilettewaschbecken.Id = "b7145dad-c595-4a0a-adcf-75a6413d8fc8"
objtoilettewaschbecken.Name = "toilette-waschbecken"
objtoilettewaschbecken.Description = ""
objtoilettewaschbecken.AltText = ""
objtoilettewaschbecken.Resources = {
  {
    Type = "jpg",
    Filename = "toilette-waschbecken.jpg",
    Directives = {}
  }
}
objtoilettespiegel = Wherigo.ZMedia(KlausKlabuster)
objtoilettespiegel.Id = "8e80b2b3-bde8-43d9-910a-80466ab697d9"
objtoilettespiegel.Name = "toilette-spiegel"
objtoilettespiegel.Description = ""
objtoilettespiegel.AltText = ""
objtoilettespiegel.Resources = {
  {
    Type = "jpg",
    Filename = "toilettenspiegel.jpg",
    Directives = {}
  }
}
objtoilettewand1 = Wherigo.ZMedia(KlausKlabuster)
objtoilettewand1.Id = "100d9367-204f-4068-93e8-4f580d716980"
objtoilettewand1.Name = "toilette-wand-1"
objtoilettewand1.Description = ""
objtoilettewand1.AltText = ""
objtoilettewand1.Resources = {
  {
    Type = "jpg",
    Filename = "toilettenwand-1.jpg",
    Directives = {}
  }
}
objtoilettewand2 = Wherigo.ZMedia(KlausKlabuster)
objtoilettewand2.Id = "023bdba3-436f-4d25-8f39-1d487978ee1a"
objtoilettewand2.Name = "toilette-wand-2"
objtoilettewand2.Description = ""
objtoilettewand2.AltText = ""
objtoilettewand2.Resources = {
  {
    Type = "jpg",
    Filename = "toilettenwand-2.jpg",
    Directives = {}
  }
}
objtoilettewand4 = Wherigo.ZMedia(KlausKlabuster)
objtoilettewand4.Id = "51c01e9e-e980-4b7f-9e21-713f055b46d1"
objtoilettewand4.Name = "toilette-wand-4"
objtoilettewand4.Description = ""
objtoilettewand4.AltText = ""
objtoilettewand4.Resources = {
  {
    Type = "jpg",
    Filename = "toilettenwand-4.jpg",
    Directives = {}
  }
}
objtoilettewand3 = Wherigo.ZMedia(KlausKlabuster)
objtoilettewand3.Id = "3a9dfeaf-9a71-432a-b2e3-a80d19ab110f"
objtoilettewand3.Name = "toilette-wand-3"
objtoilettewand3.Description = ""
objtoilettewand3.AltText = ""
objtoilettewand3.Resources = {
  {
    Type = "jpg",
    Filename = "toilettenwand-3.jpg",
    Directives = {}
  }
}
objicotoilettewaschbecken = Wherigo.ZMedia(KlausKlabuster)
objicotoilettewaschbecken.Id = "b57484d0-a0fd-4dd7-8c56-fb1f0e59327a"
objicotoilettewaschbecken.Name = "ico-toilette-waschbecken"
objicotoilettewaschbecken.Description = ""
objicotoilettewaschbecken.AltText = ""
objicotoilettewaschbecken.Resources = {
  {
    Type = "jpg",
    Filename = "ico-toilette-waschbecken.jpg",
    Directives = {}
  }
}
objicotoiletteschussel = Wherigo.ZMedia(KlausKlabuster)
objicotoiletteschussel.Id = "c7789b7a-8b50-4bcc-b3d4-53043d7e0472"
objicotoiletteschussel.Name = "ico-toilette-schussel"
objicotoiletteschussel.Description = ""
objicotoiletteschussel.AltText = ""
objicotoiletteschussel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-toilette-schussel.jpg",
    Directives = {}
  }
}
objToilettespiegelbild = Wherigo.ZMedia(KlausKlabuster)
objToilettespiegelbild.Id = "3184e476-6edd-4b5a-83f7-05dfb1d944df"
objToilettespiegelbild.Name = "Toilette-spiegelbild"
objToilettespiegelbild.Description = ""
objToilettespiegelbild.AltText = ""
objToilettespiegelbild.Resources = {
  {
    Type = "jpg",
    Filename = "toilette-spiegelbild.jpg",
    Directives = {}
  }
}
objicotoilettespiegel = Wherigo.ZMedia(KlausKlabuster)
objicotoilettespiegel.Id = "9d9eef07-0b58-436c-9958-19e956105933"
objicotoilettespiegel.Name = "ico-toilette-spiegel"
objicotoilettespiegel.Description = ""
objicotoilettespiegel.AltText = ""
objicotoilettespiegel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-toilettenspiegel.jpg",
    Directives = {}
  }
}
objklowand = Wherigo.ZMedia(KlausKlabuster)
objklowand.Id = "769fc63f-2355-4886-90f5-4c1524ee1889"
objklowand.Name = "klowand"
objklowand.Description = ""
objklowand.AltText = ""
objklowand.Resources = {
  {
    Type = "jpg",
    Filename = "klowand.jpg",
    Directives = {}
  }
}
objicoklowand = Wherigo.ZMedia(KlausKlabuster)
objicoklowand.Id = "f6670546-5ec1-4c1b-9a69-a9c0bd6e4f66"
objicoklowand.Name = "ico-klowand"
objicoklowand.Description = ""
objicoklowand.AltText = ""
objicoklowand.Resources = {
  {
    Type = "jpg",
    Filename = "ico-klowand.jpg",
    Directives = {}
  }
}
objNotizbuch = Wherigo.ZMedia(KlausKlabuster)
objNotizbuch.Id = "ea9803c7-792b-4dc0-88c1-78c4ab41eb6e"
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
objicoNotizbuch = Wherigo.ZMedia(KlausKlabuster)
objicoNotizbuch.Id = "967819cb-2997-4d9f-bfe8-62e537dd9007"
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
objicobarflur = Wherigo.ZMedia(KlausKlabuster)
objicobarflur.Id = "ef2e0947-75cb-4023-8ff0-a73d26bdac21"
objicobarflur.Name = "ico-bar-flur"
objicobarflur.Description = ""
objicobarflur.AltText = ""
objicobarflur.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-flur.jpg",
    Directives = {}
  }
}
objicoToilette = Wherigo.ZMedia(KlausKlabuster)
objicoToilette.Id = "7f9e6bb4-3f91-4bc1-94d5-71e2354aeb86"
objicoToilette.Name = "ico-Toilette"
objicoToilette.Description = ""
objicoToilette.AltText = ""
objicoToilette.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bar-toilette.jpg",
    Directives = {}
  }
}
objicoTuer = Wherigo.ZMedia(KlausKlabuster)
objicoTuer.Id = "9a225bb7-3a36-46b1-ade9-fec8234b9fd1"
objicoTuer.Name = "ico-Tuer"
objicoTuer.Description = ""
objicoTuer.AltText = ""
objicoTuer.Resources = {
  {
    Type = "jpg",
    Filename = "ico-tur.jpg",
    Directives = {}
  }
}
objTreppe = Wherigo.ZMedia(KlausKlabuster)
objTreppe.Id = "32d7b355-6337-4027-a04f-c88de9773899"
objTreppe.Name = "Treppe"
objTreppe.Description = ""
objTreppe.AltText = ""
objTreppe.Resources = {
  {
    Type = "jpg",
    Filename = "treppe.jpg",
    Directives = {}
  }
}
objicoTreppe = Wherigo.ZMedia(KlausKlabuster)
objicoTreppe.Id = "3c184e66-6ae7-4de2-900d-7e67cce6cf7b"
objicoTreppe.Name = "ico-Treppe"
objicoTreppe.Description = ""
objicoTreppe.AltText = ""
objicoTreppe.Resources = {
  {
    Type = "jpg",
    Filename = "ico-treppe.jpg",
    Directives = {}
  }
}
objRing = Wherigo.ZMedia(KlausKlabuster)
objRing.Id = "6947d32c-2e40-4fa4-afed-fe42bdbc78e4"
objRing.Name = "Ring"
objRing.Description = ""
objRing.AltText = ""
objRing.Resources = {
  {
    Type = "jpg",
    Filename = "ring.jpg",
    Directives = {}
  }
}
objicoRing = Wherigo.ZMedia(KlausKlabuster)
objicoRing.Id = "8a3ccf76-cd6d-430a-bafa-04d05f7ff246"
objicoRing.Name = "ico-Ring"
objicoRing.Description = ""
objicoRing.AltText = ""
objicoRing.Resources = {
  {
    Type = "jpg",
    Filename = "ico-ring.jpg",
    Directives = {}
  }
}
objfernsehermaja = Wherigo.ZMedia(KlausKlabuster)
objfernsehermaja.Id = "be2526c4-1559-4264-a95c-e0ab40b0d8f6"
objfernsehermaja.Name = "fernseher-maja"
objfernsehermaja.Description = ""
objfernsehermaja.AltText = ""
objfernsehermaja.Resources = {
  {
    Type = "jpg",
    Filename = "fernseher-maja.jpg",
    Directives = {}
  }
}
objfernsehersport = Wherigo.ZMedia(KlausKlabuster)
objfernsehersport.Id = "a11e0586-b248-4b6c-a076-5cf392113189"
objfernsehersport.Name = "fernseher-sport"
objfernsehersport.Description = ""
objfernsehersport.AltText = ""
objfernsehersport.Resources = {
  {
    Type = "jpg",
    Filename = "fernseher-sport.jpg",
    Directives = {}
  }
}
objfernseherporno = Wherigo.ZMedia(KlausKlabuster)
objfernseherporno.Id = "31af7418-1db2-45f2-821f-8c6f98e4da9b"
objfernseherporno.Name = "fernseher-porno"
objfernseherporno.Description = ""
objfernseherporno.AltText = ""
objfernseherporno.Resources = {
  {
    Type = "jpg",
    Filename = "fernseher-porno.jpg",
    Directives = {}
  }
}
objfernseheraus = Wherigo.ZMedia(KlausKlabuster)
objfernseheraus.Id = "077fb910-6afa-41f8-a4b8-a54810f1370e"
objfernseheraus.Name = "fernseher-aus"
objfernseheraus.Description = ""
objfernseheraus.AltText = ""
objfernseheraus.Resources = {
  {
    Type = "jpg",
    Filename = "fernseher-aus.jpg",
    Directives = {}
  }
}
objLandstreicher = Wherigo.ZMedia(KlausKlabuster)
objLandstreicher.Id = "b529a2ca-0a8f-41f3-b5e2-603fe78c5ce3"
objLandstreicher.Name = "Landstreicher"
objLandstreicher.Description = ""
objLandstreicher.AltText = ""
objLandstreicher.Resources = {
  {
    Type = "jpg",
    Filename = "landstreicher.jpg",
    Directives = {}
  }
}
objicoLandstreicher = Wherigo.ZMedia(KlausKlabuster)
objicoLandstreicher.Id = "9efacf5b-348a-47ac-8601-42c69eea7837"
objicoLandstreicher.Name = "ico-Landstreicher"
objicoLandstreicher.Description = ""
objicoLandstreicher.AltText = ""
objicoLandstreicher.Resources = {
  {
    Type = "jpg",
    Filename = "ico-landstreicher.jpg",
    Directives = {}
  }
}
objLandwirt = Wherigo.ZMedia(KlausKlabuster)
objLandwirt.Id = "1d758a16-3e1c-4b38-967f-e92654ad25ad"
objLandwirt.Name = "Landwirt"
objLandwirt.Description = ""
objLandwirt.AltText = ""
objLandwirt.Resources = {
  {
    Type = "jpg",
    Filename = "landwirt.jpg",
    Directives = {}
  }
}
objicoLandwirt = Wherigo.ZMedia(KlausKlabuster)
objicoLandwirt.Id = "832c8f96-5cee-43e9-bc80-f819f03bb141"
objicoLandwirt.Name = "ico-Landwirt"
objicoLandwirt.Description = ""
objicoLandwirt.AltText = ""
objicoLandwirt.Resources = {
  {
    Type = "jpg",
    Filename = "ico-landwirt.jpg",
    Directives = {}
  }
}
objTaschenmesser = Wherigo.ZMedia(KlausKlabuster)
objTaschenmesser.Id = "1e39e699-5b1f-435f-8fb1-9a9e6a60058a"
objTaschenmesser.Name = "Taschenmesser"
objTaschenmesser.Description = ""
objTaschenmesser.AltText = ""
objTaschenmesser.Resources = {
  {
    Type = "jpg",
    Filename = "taschenmesser.jpg",
    Directives = {}
  }
}
objicoTaschenmesser = Wherigo.ZMedia(KlausKlabuster)
objicoTaschenmesser.Id = "ac2428ea-8586-49b5-a8f9-90b70187e231"
objicoTaschenmesser.Name = "ico-Taschenmesser"
objicoTaschenmesser.Description = ""
objicoTaschenmesser.AltText = ""
objicoTaschenmesser.Resources = {
  {
    Type = "jpg",
    Filename = "ico-taschenmesser.jpg",
    Directives = {}
  }
}
objDisco = Wherigo.ZMedia(KlausKlabuster)
objDisco.Id = "704be0b0-9678-4812-918a-c6b129acedd0"
objDisco.Name = "Disco"
objDisco.Description = ""
objDisco.AltText = ""
objDisco.Resources = {
  {
    Type = "jpg",
    Filename = "disco.jpg",
    Directives = {}
  }
}
objicoDisco = Wherigo.ZMedia(KlausKlabuster)
objicoDisco.Id = "ef563b3f-a5d6-4765-9470-a16ec16bb541"
objicoDisco.Name = "ico-Disco"
objicoDisco.Description = ""
objicoDisco.AltText = ""
objicoDisco.Resources = {
  {
    Type = "jpg",
    Filename = "ico-disco.jpg",
    Directives = {}
  }
}
objDisocinnen = Wherigo.ZMedia(KlausKlabuster)
objDisocinnen.Id = "5d8e7d3d-3f8e-44b8-b36b-b2b0a8bfb340"
objDisocinnen.Name = "Disoc-innen"
objDisocinnen.Description = ""
objDisocinnen.AltText = ""
objDisocinnen.Resources = {
  {
    Type = "jpg",
    Filename = "disco-innen.jpg",
    Directives = {}
  }
}
objicoDiscoinnen = Wherigo.ZMedia(KlausKlabuster)
objicoDiscoinnen.Id = "6f69a317-4a18-478a-9e5a-faa82f1622fd"
objicoDiscoinnen.Name = "ico-Disco-innen"
objicoDiscoinnen.Description = ""
objicoDiscoinnen.AltText = ""
objicoDiscoinnen.Resources = {
  {
    Type = "jpg",
    Filename = "ico-disco-innen.jpg",
    Directives = {}
  }
}
objCasinoinnen = Wherigo.ZMedia(KlausKlabuster)
objCasinoinnen.Id = "d8c96d67-3058-41cc-8c32-1fb5bc11f5bc"
objCasinoinnen.Name = "Casino-innen"
objCasinoinnen.Description = ""
objCasinoinnen.AltText = ""
objCasinoinnen.Resources = {
  {
    Type = "jpg",
    Filename = "casino-innen.jpg",
    Directives = {}
  }
}
objicoCasinoinnen = Wherigo.ZMedia(KlausKlabuster)
objicoCasinoinnen.Id = "d7f7eb6d-0292-416e-acec-f666f02ac85a"
objicoCasinoinnen.Name = "ico-Casino-innen"
objicoCasinoinnen.Description = ""
objicoCasinoinnen.AltText = ""
objicoCasinoinnen.Resources = {
  {
    Type = "jpg",
    Filename = "ico-casino-innen.jpg",
    Directives = {}
  }
}
objKaisers = Wherigo.ZMedia(KlausKlabuster)
objKaisers.Id = "e896acc0-d613-43c4-9220-0a793931c3b7"
objKaisers.Name = "Kaisers"
objKaisers.Description = ""
objKaisers.AltText = ""
objKaisers.Resources = {
  {
    Type = "jpg",
    Filename = "Kaisers.jpg",
    Directives = {}
  }
}
objicoKaisers = Wherigo.ZMedia(KlausKlabuster)
objicoKaisers.Id = "47052d36-9cbd-4b23-82d1-3966966acf28"
objicoKaisers.Name = "ico-Kaisers"
objicoKaisers.Description = ""
objicoKaisers.AltText = ""
objicoKaisers.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Kaisers.jpg",
    Directives = {}
  }
}
objKaisersinnen = Wherigo.ZMedia(KlausKlabuster)
objKaisersinnen.Id = "3305b87a-6911-4949-8884-aaa20558ae80"
objKaisersinnen.Name = "Kaisers-innen"
objKaisersinnen.Description = ""
objKaisersinnen.AltText = ""
objKaisersinnen.Resources = {
  {
    Type = "jpg",
    Filename = "kaisers-innen.jpg",
    Directives = {}
  }
}
objicoKaisersinnen = Wherigo.ZMedia(KlausKlabuster)
objicoKaisersinnen.Id = "8d1c84ca-15e8-4f19-b572-21c66d03c7fd"
objicoKaisersinnen.Name = "ico-Kaisers-innen"
objicoKaisersinnen.Description = ""
objicoKaisersinnen.AltText = ""
objicoKaisersinnen.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kaisers-innen.jpg",
    Directives = {}
  }
}
objPillendose = Wherigo.ZMedia(KlausKlabuster)
objPillendose.Id = "9dcf2d92-b9ae-4721-822b-94e917df9317"
objPillendose.Name = "Pillendose"
objPillendose.Description = ""
objPillendose.AltText = ""
objPillendose.Resources = {
  {
    Type = "jpg",
    Filename = "pillendose.jpg",
    Directives = {}
  }
}
objicoPillendose = Wherigo.ZMedia(KlausKlabuster)
objicoPillendose.Id = "f8e6d4a5-2464-465c-a96a-118909d876cb"
objicoPillendose.Name = "ico-Pillendose"
objicoPillendose.Description = ""
objicoPillendose.AltText = ""
objicoPillendose.Resources = {
  {
    Type = "jpg",
    Filename = "ico-pillendose.jpg",
    Directives = {}
  }
}
objSeil = Wherigo.ZMedia(KlausKlabuster)
objSeil.Id = "792887a7-c305-4428-87a9-1f4f80709e16"
objSeil.Name = "Seil"
objSeil.Description = ""
objSeil.AltText = ""
objSeil.Resources = {
  {
    Type = "jpg",
    Filename = "seil.jpg",
    Directives = {}
  }
}
objicoSeil = Wherigo.ZMedia(KlausKlabuster)
objicoSeil.Id = "e6c4f40d-e61e-4124-a56e-77a821fe4bc4"
objicoSeil.Name = "ico-Seil"
objicoSeil.Description = ""
objicoSeil.AltText = ""
objicoSeil.Resources = {
  {
    Type = "jpg",
    Filename = "ico-seil.jpg",
    Directives = {}
  }
}
objDiscopass = Wherigo.ZMedia(KlausKlabuster)
objDiscopass.Id = "fe64fc06-7322-4d9d-845d-fc3fbc603020"
objDiscopass.Name = "Discopass"
objDiscopass.Description = ""
objDiscopass.AltText = ""
objDiscopass.Resources = {
  {
    Type = "jpg",
    Filename = "discopass.jpg",
    Directives = {}
  }
}
objicoDiscopass = Wherigo.ZMedia(KlausKlabuster)
objicoDiscopass.Id = "8c7b981c-cf5d-479d-80ee-4e6406bd4c83"
objicoDiscopass.Name = "ico-Discopass"
objicoDiscopass.Description = ""
objicoDiscopass.AltText = ""
objicoDiscopass.Resources = {
  {
    Type = "jpg",
    Filename = "ico-discopass.jpg",
    Directives = {}
  }
}
objRadio = Wherigo.ZMedia(KlausKlabuster)
objRadio.Id = "0f978617-fccc-486e-989f-0e7309499c58"
objRadio.Name = "Radio"
objRadio.Description = ""
objRadio.AltText = ""
objRadio.Resources = {
  {
    Type = "jpg",
    Filename = "Radio.jpg",
    Directives = {}
  }
}
objicoRadio = Wherigo.ZMedia(KlausKlabuster)
objicoRadio.Id = "b9cbc481-133b-466e-aa8c-667a087ad986"
objicoRadio.Name = "ico-Radio"
objicoRadio.Description = ""
objicoRadio.AltText = ""
objicoRadio.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Radio.jpg",
    Directives = {}
  }
}
objMagazin = Wherigo.ZMedia(KlausKlabuster)
objMagazin.Id = "db222b67-b1f8-4066-a824-fe9bb26daac5"
objMagazin.Name = "Magazin"
objMagazin.Description = ""
objMagazin.AltText = ""
objMagazin.Resources = {
  {
    Type = "jpg",
    Filename = "magazin.jpg",
    Directives = {}
  }
}
objicoMagazin = Wherigo.ZMedia(KlausKlabuster)
objicoMagazin.Id = "30c86088-2574-424d-ba8c-c83e065ca31d"
objicoMagazin.Name = "ico-Magazin"
objicoMagazin.Description = ""
objicoMagazin.AltText = ""
objicoMagazin.Resources = {
  {
    Type = "jpg",
    Filename = "ico-magazin.jpg",
    Directives = {}
  }
}
objVerkaeuferin = Wherigo.ZMedia(KlausKlabuster)
objVerkaeuferin.Id = "aacf9d26-9489-4c64-b57d-ad700efc8dcc"
objVerkaeuferin.Name = "Verkaeuferin"
objVerkaeuferin.Description = ""
objVerkaeuferin.AltText = ""
objVerkaeuferin.Resources = {
  {
    Type = "jpg",
    Filename = "verkaeuferin.jpg",
    Directives = {}
  }
}
objicoVerkaeuferin = Wherigo.ZMedia(KlausKlabuster)
objicoVerkaeuferin.Id = "cb1d8bea-629b-46d9-8c51-c5e7edc650c8"
objicoVerkaeuferin.Name = "ico-Verkaeuferin"
objicoVerkaeuferin.Description = ""
objicoVerkaeuferin.AltText = ""
objicoVerkaeuferin.Resources = {
  {
    Type = "jpg",
    Filename = "ico-verkaeuferin.jpg",
    Directives = {}
  }
}
objicoWeinflasche = Wherigo.ZMedia(KlausKlabuster)
objicoWeinflasche.Id = "24f135d4-de60-49fa-a96b-58da3098cb75"
objicoWeinflasche.Name = "ico-Weinflasche"
objicoWeinflasche.Description = ""
objicoWeinflasche.AltText = ""
objicoWeinflasche.Resources = {
  {
    Type = "jpg",
    Filename = "ico-weinflasche.jpg",
    Directives = {}
  }
}
objRezeption = Wherigo.ZMedia(KlausKlabuster)
objRezeption.Id = "4129d221-8ef1-4476-83cb-d39b6572a9e4"
objRezeption.Name = "Rezeption"
objRezeption.Description = ""
objRezeption.AltText = ""
objRezeption.Resources = {
  {
    Type = "jpg",
    Filename = "hotellobby.jpg",
    Directives = {}
  }
}
objicoRezeption = Wherigo.ZMedia(KlausKlabuster)
objicoRezeption.Id = "3a70cdf2-101e-437c-b793-34136108059b"
objicoRezeption.Name = "ico-Rezeption"
objicoRezeption.Description = ""
objicoRezeption.AltText = ""
objicoRezeption.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hotellobby.jpg",
    Directives = {}
  }
}
objHotelzimmer = Wherigo.ZMedia(KlausKlabuster)
objHotelzimmer.Id = "77afaa8f-2c0d-4c94-9039-b417e88b9c43"
objHotelzimmer.Name = "Hotelzimmer"
objHotelzimmer.Description = ""
objHotelzimmer.AltText = ""
objHotelzimmer.Resources = {
  {
    Type = "jpg",
    Filename = "hotelzimmer.jpg",
    Directives = {}
  }
}
objicoHotelzimmer = Wherigo.ZMedia(KlausKlabuster)
objicoHotelzimmer.Id = "7d008e0e-2168-44f2-b378-fef4ce9b16bc"
objicoHotelzimmer.Name = "ico-Hotelzimmer"
objicoHotelzimmer.Description = ""
objicoHotelzimmer.AltText = ""
objicoHotelzimmer.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hotelzimmer.jpg",
    Directives = {}
  }
}
objWellnessbereich = Wherigo.ZMedia(KlausKlabuster)
objWellnessbereich.Id = "5c776633-34ee-4cd5-9e66-673661f1dd6d"
objWellnessbereich.Name = "Wellnessbereich"
objWellnessbereich.Description = ""
objWellnessbereich.AltText = ""
objWellnessbereich.Resources = {
  {
    Type = "jpg",
    Filename = "wellnessbereich.jpg",
    Directives = {}
  }
}
objicoWellnessbereich = Wherigo.ZMedia(KlausKlabuster)
objicoWellnessbereich.Id = "4e491ad8-abcf-4382-bacf-12edcb33bb84"
objicoWellnessbereich.Name = "ico-Wellnessbereich"
objicoWellnessbereich.Description = ""
objicoWellnessbereich.AltText = ""
objicoWellnessbereich.Resources = {
  {
    Type = "jpg",
    Filename = "ico-wellnessbereich.jpg",
    Directives = {}
  }
}
objAschenbecher = Wherigo.ZMedia(KlausKlabuster)
objAschenbecher.Id = "6ed4e117-a377-4db0-8ecc-fd5940d4e30d"
objAschenbecher.Name = "Aschenbecher"
objAschenbecher.Description = ""
objAschenbecher.AltText = ""
objAschenbecher.Resources = {
  {
    Type = "jpg",
    Filename = "aschenbecher.jpg",
    Directives = {}
  }
}
objicoAschenbecher = Wherigo.ZMedia(KlausKlabuster)
objicoAschenbecher.Id = "d0a1de76-ad89-4a2a-9796-7ccd9f8b2cc6"
objicoAschenbecher.Name = "ico-Aschenbecher"
objicoAschenbecher.Description = ""
objicoAschenbecher.AltText = ""
objicoAschenbecher.Resources = {
  {
    Type = "jpg",
    Filename = "ico-aschenbecher.jpg",
    Directives = {}
  }
}
objEmpfangsdame = Wherigo.ZMedia(KlausKlabuster)
objEmpfangsdame.Id = "9d4fbe85-8bef-415d-accc-67e2be78bea8"
objEmpfangsdame.Name = "Empfangsdame"
objEmpfangsdame.Description = ""
objEmpfangsdame.AltText = ""
objEmpfangsdame.Resources = {
  {
    Type = "jpg",
    Filename = "empfangsdame.jpg",
    Directives = {}
  }
}
objicoEmpfangsdame = Wherigo.ZMedia(KlausKlabuster)
objicoEmpfangsdame.Id = "2520a16d-355a-483f-be78-d25605ff7142"
objicoEmpfangsdame.Name = "ico-Empfangsdame"
objicoEmpfangsdame.Description = ""
objicoEmpfangsdame.AltText = ""
objicoEmpfangsdame.Resources = {
  {
    Type = "jpg",
    Filename = "ico-empfangsdame.jpg",
    Directives = {}
  }
}
objicoFawn = Wherigo.ZMedia(KlausKlabuster)
objicoFawn.Id = "48aff9c9-6dba-4b52-9be1-c879b1a69578"
objicoFawn.Name = "ico-Fawn"
objicoFawn.Description = ""
objicoFawn.AltText = ""
objicoFawn.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fawn.jpg",
    Directives = {}
  }
}
objSchlager = Wherigo.ZMedia(KlausKlabuster)
objSchlager.Id = "43aa5f98-f88c-4a59-9e1f-3ded994d90e9"
objSchlager.Name = "Schlager"
objSchlager.Description = ""
objSchlager.AltText = ""
objSchlager.Resources = {
  {
    Type = "jpg",
    Filename = "schlager.jpg",
    Directives = {}
  }
}
objicoSchlager = Wherigo.ZMedia(KlausKlabuster)
objicoSchlager.Id = "9441aa32-2f8b-4bfb-a18d-e1368cbc7904"
objicoSchlager.Name = "ico-Schlager"
objicoSchlager.Description = ""
objicoSchlager.AltText = ""
objicoSchlager.Resources = {
  {
    Type = "jpg",
    Filename = "ico-schlager.jpg",
    Directives = {}
  }
}
objTursteherDisco = Wherigo.ZMedia(KlausKlabuster)
objTursteherDisco.Id = "c45391b6-b78b-44ca-be67-d3eff8dea162"
objTursteherDisco.Name = "Tursteher Disco"
objTursteherDisco.Description = ""
objTursteherDisco.AltText = ""
objTursteherDisco.Resources = {
  {
    Type = "jpg",
    Filename = "tursteher-disco.jpg",
    Directives = {}
  }
}
objicoTursteherdisco = Wherigo.ZMedia(KlausKlabuster)
objicoTursteherdisco.Id = "d2534d75-6021-4282-9621-466827f5f9e9"
objicoTursteherdisco.Name = "ico-Tursteher disco"
objicoTursteherdisco.Description = ""
objicoTursteherdisco.AltText = ""
objicoTursteherdisco.Resources = {
  {
    Type = "jpg",
    Filename = "ico-tursteher-disco.jpg",
    Directives = {}
  }
}
objAltarraum = Wherigo.ZMedia(KlausKlabuster)
objAltarraum.Id = "940fdbb3-53a2-496a-b8a6-d6a4dfaccfa5"
objAltarraum.Name = "Altarraum"
objAltarraum.Description = ""
objAltarraum.AltText = ""
objAltarraum.Resources = {
  {
    Type = "jpg",
    Filename = "kirche-innen.jpg",
    Directives = {}
  }
}
objicoAltarraum = Wherigo.ZMedia(KlausKlabuster)
objicoAltarraum.Id = "a03db6bf-2a31-40cd-b39b-150644ad10bb"
objicoAltarraum.Name = "ico-Altarraum"
objicoAltarraum.Description = ""
objicoAltarraum.AltText = ""
objicoAltarraum.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kirche-innen.jpg",
    Directives = {}
  }
}
objZigarettengirl = Wherigo.ZMedia(KlausKlabuster)
objZigarettengirl.Id = "0319f991-9047-4085-9684-5503a406f804"
objZigarettengirl.Name = "Zigarettengirl"
objZigarettengirl.Description = ""
objZigarettengirl.AltText = ""
objZigarettengirl.Resources = {
  {
    Type = "jpg",
    Filename = "zigarettenmadchen.jpg",
    Directives = {}
  }
}
objCasinitoilette = Wherigo.ZMedia(KlausKlabuster)
objCasinitoilette.Id = "45540848-42bf-461a-ac46-7aa064c2cca2"
objCasinitoilette.Name = "Casinitoilette"
objCasinitoilette.Description = ""
objCasinitoilette.AltText = ""
objCasinitoilette.Resources = {
  {
    Type = "jpg",
    Filename = "casino-toilette.jpg",
    Directives = {}
  }
}
objicocasinotoilette = Wherigo.ZMedia(KlausKlabuster)
objicocasinotoilette.Id = "2832fbc8-5dcb-4aad-ba2c-8ee4b2f4936e"
objicocasinotoilette.Name = "ico-casinotoilette"
objicocasinotoilette.Description = ""
objicocasinotoilette.AltText = ""
objicocasinotoilette.Resources = {
  {
    Type = "jpg",
    Filename = "ico-casino-toilette.jpg",
    Directives = {}
  }
}
objCroupier = Wherigo.ZMedia(KlausKlabuster)
objCroupier.Id = "53ba2a4b-3cab-4d84-82ec-80124592a8b6"
objCroupier.Name = "Croupier"
objCroupier.Description = ""
objCroupier.AltText = ""
objCroupier.Resources = {
  {
    Type = "jpg",
    Filename = "croupier.jpg",
    Directives = {}
  }
}
objicocroupier = Wherigo.ZMedia(KlausKlabuster)
objicocroupier.Id = "87dce8c2-0d50-4c00-a727-cab6fa7b2cdd"
objicocroupier.Name = "ico-croupier"
objicocroupier.Description = ""
objicocroupier.AltText = ""
objicocroupier.Resources = {
  {
    Type = "jpg",
    Filename = "ico-croupier.jpg",
    Directives = {}
  }
}
objSpielautomat = Wherigo.ZMedia(KlausKlabuster)
objSpielautomat.Id = "a06240c4-c32e-4bb1-bc01-df951ed91a5b"
objSpielautomat.Name = "Spielautomat"
objSpielautomat.Description = ""
objSpielautomat.AltText = ""
objSpielautomat.Resources = {
  {
    Type = "jpg",
    Filename = "slotmachine.jpg",
    Directives = {}
  }
}
objicoSpielautomat = Wherigo.ZMedia(KlausKlabuster)
objicoSpielautomat.Id = "98980ac1-2841-4fa5-9940-949aba8cbcff"
objicoSpielautomat.Name = "ico-Spielautomat"
objicoSpielautomat.Description = ""
objicoSpielautomat.AltText = ""
objicoSpielautomat.Resources = {
  {
    Type = "jpg",
    Filename = "ico-slotmachine.jpg",
    Directives = {}
  }
}
obj_audiohausamsee = Wherigo.ZMedia(KlausKlabuster)
obj_audiohausamsee.Id = "d1e5b8a9-5a83-45fa-8930-b8e8b9e9b77a"
obj_audiohausamsee.Name = "_audio haus-am-see"
obj_audiohausamsee.Description = ""
obj_audiohausamsee.AltText = ""
obj_audiohausamsee.Resources = {
  {
    Type = "mp3",
    Filename = "refrain.mp3",
    Directives = {}
  }
}
objseeblick = Wherigo.ZMedia(KlausKlabuster)
objseeblick.Id = "604aaeba-e566-44f7-a779-90059fb37168"
objseeblick.Name = "seeblick"
objseeblick.Description = ""
objseeblick.AltText = ""
objseeblick.Resources = {
  {
    Type = "jpg",
    Filename = "seeblick.jpg",
    Directives = {}
  }
}
objicoseeblick = Wherigo.ZMedia(KlausKlabuster)
objicoseeblick.Id = "c509dc45-ab59-4e33-a25f-1ba2eba4e721"
objicoseeblick.Name = "ico-seeblick"
objicoseeblick.Description = ""
objicoseeblick.AltText = ""
objicoseeblick.Resources = {
  {
    Type = "jpg",
    Filename = "ico-seeblick.jpg",
    Directives = {}
  }
}
objgrundbuch = Wherigo.ZMedia(KlausKlabuster)
objgrundbuch.Id = "10fa7c39-e120-451c-b26e-f8cbd9aa2631"
objgrundbuch.Name = "grundbuch"
objgrundbuch.Description = ""
objgrundbuch.AltText = ""
objgrundbuch.Resources = {
  {
    Type = "jpg",
    Filename = "grundbuch.jpg",
    Directives = {}
  }
}
objicogrundbuch = Wherigo.ZMedia(KlausKlabuster)
objicogrundbuch.Id = "7cba1e5c-cf2d-4901-9477-aa8bf3468dc2"
objicogrundbuch.Name = "ico-grundbuch"
objicogrundbuch.Description = ""
objicogrundbuch.AltText = ""
objicogrundbuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-grundbuch.jpg",
    Directives = {}
  }
}
objicokabarett = Wherigo.ZMedia(KlausKlabuster)
objicokabarett.Id = "be0100bf-9de0-445b-9c79-08eb53cb6f5b"
objicokabarett.Name = "ico-kabarett"
objicokabarett.Description = ""
objicokabarett.AltText = ""
objicokabarett.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kabarett.jpg",
    Directives = {}
  }
}
objkabarett = Wherigo.ZMedia(KlausKlabuster)
objkabarett.Id = "e89dc04f-3130-42a7-ac33-52d44219ee19"
objkabarett.Name = "kabarett"
objkabarett.Description = ""
objkabarett.AltText = ""
objkabarett.Resources = {
  {
    Type = "jpg",
    Filename = "kabarett.jpg",
    Directives = {}
  }
}
objvarieteplakat = Wherigo.ZMedia(KlausKlabuster)
objvarieteplakat.Id = "02303f54-2909-42b3-8fc9-12d69d6a8d23"
objvarieteplakat.Name = "varieteplakat"
objvarieteplakat.Description = ""
objvarieteplakat.AltText = ""
objvarieteplakat.Resources = {
  {
    Type = "jpg",
    Filename = "varieteplakat.jpg",
    Directives = {}
  }
}
objicovarieteplakat = Wherigo.ZMedia(KlausKlabuster)
objicovarieteplakat.Id = "98f72842-aa18-485b-b663-5f45de76fea6"
objicovarieteplakat.Name = "ico-varieteplakat"
objicovarieteplakat.Description = ""
objicovarieteplakat.AltText = ""
objicovarieteplakat.Resources = {
  {
    Type = "jpg",
    Filename = "ico-varieteplakat.jpg",
    Directives = {}
  }
}
objpoledance = Wherigo.ZMedia(KlausKlabuster)
objpoledance.Id = "31fc75c3-cbb8-40fb-bd62-59a8c7d115e7"
objpoledance.Name = "poledance"
objpoledance.Description = ""
objpoledance.AltText = ""
objpoledance.Resources = {
  {
    Type = "jpg",
    Filename = "pole-dance.jpg",
    Directives = {}
  }
}
objicopoledance = Wherigo.ZMedia(KlausKlabuster)
objicopoledance.Id = "6d434840-9d8b-423b-8644-ed8b0596f8c7"
objicopoledance.Name = "ico-poledance"
objicopoledance.Description = ""
objicopoledance.AltText = ""
objicopoledance.Resources = {
  {
    Type = "jpg",
    Filename = "ico-pole-dance.jpg",
    Directives = {}
  }
}
objTelefonzelle = Wherigo.ZMedia(KlausKlabuster)
objTelefonzelle.Id = "8b4746f9-87e0-49fd-92c4-e72f4c669442"
objTelefonzelle.Name = "Telefonzelle"
objTelefonzelle.Description = ""
objTelefonzelle.AltText = ""
objTelefonzelle.Resources = {
  {
    Type = "jpg",
    Filename = "telefonzelle.jpg",
    Directives = {}
  }
}
objicoTelefonzelle = Wherigo.ZMedia(KlausKlabuster)
objicoTelefonzelle.Id = "0b441ddf-d506-4c4e-b924-35b07a964c5b"
objicoTelefonzelle.Name = "ico-Telefonzelle"
objicoTelefonzelle.Description = ""
objicoTelefonzelle.AltText = ""
objicoTelefonzelle.Resources = {
  {
    Type = "jpg",
    Filename = "ico-telefonzelle.jpg",
    Directives = {}
  }
}
objFilmdose = Wherigo.ZMedia(KlausKlabuster)
objFilmdose.Id = "e9072cf3-b970-421b-881a-a46a0fac20d6"
objFilmdose.Name = "Filmdose"
objFilmdose.Description = ""
objFilmdose.AltText = ""
objFilmdose.Resources = {
  {
    Type = "jpg",
    Filename = "filmdose.jpg",
    Directives = {}
  }
}
objicoFilmdose = Wherigo.ZMedia(KlausKlabuster)
objicoFilmdose.Id = "1e324a63-432b-4aa8-b69f-7b3d555a915d"
objicoFilmdose.Name = "ico-Filmdose"
objicoFilmdose.Description = ""
objicoFilmdose.AltText = ""
objicoFilmdose.Resources = {
  {
    Type = "jpg",
    Filename = "ico-filmdose.jpg",
    Directives = {}
  }
}
objTaxischild = Wherigo.ZMedia(KlausKlabuster)
objTaxischild.Id = "8b3b4edd-d475-44a4-a509-7a205d751786"
objTaxischild.Name = "Taxischild"
objTaxischild.Description = ""
objTaxischild.AltText = ""
objTaxischild.Resources = {
  {
    Type = "jpg",
    Filename = "taxi.jpg",
    Directives = {}
  }
}
objicoTaxischild = Wherigo.ZMedia(KlausKlabuster)
objicoTaxischild.Id = "d009430f-4785-4444-a23a-a7f0c0e22184"
objicoTaxischild.Name = "ico-Taxischild"
objicoTaxischild.Description = ""
objicoTaxischild.AltText = ""
objicoTaxischild.Resources = {
  {
    Type = "jpg",
    Filename = "ico-taxi.jpg",
    Directives = {}
  }
}
objMobiltelefon = Wherigo.ZMedia(KlausKlabuster)
objMobiltelefon.Id = "c35af8f2-978b-48eb-bcc0-181f6d8aba8b"
objMobiltelefon.Name = "Mobiltelefon"
objMobiltelefon.Description = ""
objMobiltelefon.AltText = ""
objMobiltelefon.Resources = {
  {
    Type = "jpg",
    Filename = "mobiltelefon.jpg",
    Directives = {}
  }
}
objicoMobiltelefon = Wherigo.ZMedia(KlausKlabuster)
objicoMobiltelefon.Id = "a2cfaa92-fbe1-4f5e-930c-1c5bbc3c087c"
objicoMobiltelefon.Name = "ico-Mobiltelefon"
objicoMobiltelefon.Description = ""
objicoMobiltelefon.AltText = ""
objicoMobiltelefon.Resources = {
  {
    Type = "jpg",
    Filename = "ico-mobiltelefon.jpg",
    Directives = {}
  }
}
objakkuleer = Wherigo.ZMedia(KlausKlabuster)
objakkuleer.Id = "ae0e5dcd-445a-44b5-a513-a42c7d8337ec"
objakkuleer.Name = "akkuleer"
objakkuleer.Description = ""
objakkuleer.AltText = ""
objakkuleer.Resources = {
  {
    Type = "jpg",
    Filename = "akkuleer.jpg",
    Directives = {}
  }
}
obj_audioshutdown = Wherigo.ZMedia(KlausKlabuster)
obj_audioshutdown.Id = "a3123934-2d49-4a25-9de2-a6907f703946"
obj_audioshutdown.Name = "_audio shutdown"
obj_audioshutdown.Description = ""
obj_audioshutdown.AltText = ""
obj_audioshutdown.Resources = {
  {
    Type = "mp3",
    Filename = "shutdown.mp3",
    Directives = {}
  }
}
objlogbuch = Wherigo.ZMedia(KlausKlabuster)
objlogbuch.Id = "71e48fd4-be8b-4ae1-a514-09d85d596d20"
objlogbuch.Name = "logbuch"
objlogbuch.Description = ""
objlogbuch.AltText = ""
objlogbuch.Resources = {
  {
    Type = "jpg",
    Filename = "logbuch.jpg",
    Directives = {}
  }
}
obj_audiokeinanschluss = Wherigo.ZMedia(KlausKlabuster)
obj_audiokeinanschluss.Id = "5ad049a4-69f6-4be9-b117-2b3250202dc0"
obj_audiokeinanschluss.Name = "_audio kein-anschluss"
obj_audiokeinanschluss.Description = ""
obj_audiokeinanschluss.AltText = ""
obj_audiokeinanschluss.Resources = {
  {
    Type = "mp3",
    Filename = "kein-anschluss.mp3",
    Directives = {}
  }
}
obj_audiopoolsplash = Wherigo.ZMedia(KlausKlabuster)
obj_audiopoolsplash.Id = "52db4a7b-b31a-4cc7-99b3-2d1f836e014e"
obj_audiopoolsplash.Name = "_audio pool-splash"
obj_audiopoolsplash.Description = ""
obj_audiopoolsplash.AltText = ""
obj_audiopoolsplash.Resources = {
  {
    Type = "mp3",
    Filename = "pool-splash.mp3",
    Directives = {}
  }
}
objFenster = Wherigo.ZMedia(KlausKlabuster)
objFenster.Id = "3135d470-626e-4218-942c-03668daa2667"
objFenster.Name = "Fenster"
objFenster.Description = ""
objFenster.AltText = ""
objFenster.Resources = {
  {
    Type = "jpg",
    Filename = "fenster.jpg",
    Directives = {}
  }
}
objicoFenster = Wherigo.ZMedia(KlausKlabuster)
objicoFenster.Id = "63aaa55b-5da9-41d2-9d64-0a65d4f66cea"
objicoFenster.Name = "ico-Fenster"
objicoFenster.Description = ""
objicoFenster.AltText = ""
objicoFenster.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fenster.jpg",
    Directives = {}
  }
}
objHinterhof = Wherigo.ZMedia(KlausKlabuster)
objHinterhof.Id = "12325699-cecb-4688-beef-20bdc9e88b74"
objHinterhof.Name = "Hinterhof"
objHinterhof.Description = ""
objHinterhof.AltText = ""
objHinterhof.Resources = {
  {
    Type = "jpg",
    Filename = "hinterhof.jpg",
    Directives = {}
  }
}
objicohinterhof = Wherigo.ZMedia(KlausKlabuster)
objicohinterhof.Id = "3a196246-f261-47de-b2ea-398b20e269e6"
objicohinterhof.Name = "ico-hinterhof"
objicohinterhof.Description = ""
objicohinterhof.AltText = ""
objicohinterhof.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hinterhof.jpg",
    Directives = {}
  }
}
obj_audiobolero = Wherigo.ZMedia(KlausKlabuster)
obj_audiobolero.Id = "b70b74e3-caf5-4067-ae10-c46cf8edaef9"
obj_audiobolero.Name = "_audio bolero"
obj_audiobolero.Description = ""
obj_audiobolero.AltText = ""
obj_audiobolero.Resources = {
  {
    Type = "mp3",
    Filename = "track09ravelbolero.mp3",
    Directives = {}
  }
}
objXXX = Wherigo.ZMedia(KlausKlabuster)
objXXX.Id = "7dc8df1e-979a-4922-af77-e5cc8cc7b1c7"
objXXX.Name = "XXX"
objXXX.Description = ""
objXXX.AltText = ""
objXXX.Resources = {
  {
    Type = "jpg",
    Filename = "bar-zimmer-hure-doit.jpg",
    Directives = {}
  }
}
objWandtelefon = Wherigo.ZMedia(KlausKlabuster)
objWandtelefon.Id = "59ff9d1d-f155-4dc1-834c-ef14f0374349"
objWandtelefon.Name = "Wandtelefon"
objWandtelefon.Description = ""
objWandtelefon.AltText = ""
objWandtelefon.Resources = {
  {
    Type = "jpg",
    Filename = "telefon-wand.jpg",
    Directives = {}
  }
}
objicoWandtelefon = Wherigo.ZMedia(KlausKlabuster)
objicoWandtelefon.Id = "13344673-1d7b-4618-b1e4-06b04fff63be"
objicoWandtelefon.Name = "ico-Wandtelefon"
objicoWandtelefon.Description = ""
objicoWandtelefon.AltText = ""
objicoWandtelefon.Resources = {
  {
    Type = "jpg",
    Filename = "ico-telefon-wand.jpg",
    Directives = {}
  }
}
objTelefon = Wherigo.ZMedia(KlausKlabuster)
objTelefon.Id = "d0fdc6e5-bf4e-4ad1-b709-0fc581aa1590"
objTelefon.Name = "Telefon"
objTelefon.Description = ""
objTelefon.AltText = ""
objTelefon.Resources = {
  {
    Type = "jpg",
    Filename = "telefon.jpg",
    Directives = {}
  }
}
objicoTelefon = Wherigo.ZMedia(KlausKlabuster)
objicoTelefon.Id = "5c39d777-60e3-4d09-a7fb-0ba25ced4c77"
objicoTelefon.Name = "ico-Telefon"
objicoTelefon.Description = ""
objicoTelefon.AltText = ""
objicoTelefon.Resources = {
  {
    Type = "jpg",
    Filename = "ico-telefon.jpg",
    Directives = {}
  }
}
objWaschbecken = Wherigo.ZMedia(KlausKlabuster)
objWaschbecken.Id = "7d4f05ad-4b3c-4981-9f58-4c0c14b5ba2f"
objWaschbecken.Name = "Waschbecken"
objWaschbecken.Description = ""
objWaschbecken.AltText = ""
objWaschbecken.Resources = {
  {
    Type = "jpg",
    Filename = "waschbecken.jpg",
    Directives = {}
  }
}
objicoWaschbecken = Wherigo.ZMedia(KlausKlabuster)
objicoWaschbecken.Id = "5621ab5d-5095-4640-8bea-76df42619153"
objicoWaschbecken.Name = "ico-Waschbecken"
objicoWaschbecken.Description = ""
objicoWaschbecken.AltText = ""
objicoWaschbecken.Resources = {
  {
    Type = "jpg",
    Filename = "ico-waschbecken.jpg",
    Directives = {}
  }
}
objSpiegel = Wherigo.ZMedia(KlausKlabuster)
objSpiegel.Id = "3363b629-163f-48cf-88ae-2a6dd5515d22"
objSpiegel.Name = "Spiegel"
objSpiegel.Description = ""
objSpiegel.AltText = ""
objSpiegel.Resources = {
  {
    Type = "jpg",
    Filename = "wandspiegel.jpg",
    Directives = {}
  }
}
objicoWandpsiegel = Wherigo.ZMedia(KlausKlabuster)
objicoWandpsiegel.Id = "f6221a4d-2d41-4d1b-a492-c16f0d6c7493"
objicoWandpsiegel.Name = "ico-Wandpsiegel"
objicoWandpsiegel.Description = ""
objicoWandpsiegel.AltText = ""
objicoWandpsiegel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-wandspiegel.jpg",
    Directives = {}
  }
}
objPriester = Wherigo.ZMedia(KlausKlabuster)
objPriester.Id = "5ba8fa88-97cd-4b99-87cd-5b9e88f9527e"
objPriester.Name = "Priester"
objPriester.Description = ""
objPriester.AltText = ""
objPriester.Resources = {
  {
    Type = "jpg",
    Filename = "priester.jpg",
    Directives = {}
  }
}
objicoPriester = Wherigo.ZMedia(KlausKlabuster)
objicoPriester.Id = "f3c5fddd-200e-42fe-bbb0-d89d1805ef93"
objicoPriester.Name = "ico-Priester"
objicoPriester.Description = ""
objicoPriester.AltText = ""
objicoPriester.Resources = {
  {
    Type = "jpg",
    Filename = "ico-priester.jpg",
    Directives = {}
  }
}
objicozigarettengirl = Wherigo.ZMedia(KlausKlabuster)
objicozigarettengirl.Id = "3e883146-3c6a-44eb-b513-2afddfb39365"
objicozigarettengirl.Name = "ico-zigarettengirl"
objicozigarettengirl.Description = ""
objicozigarettengirl.AltText = ""
objicozigarettengirl.Resources = {
  {
    Type = "jpg",
    Filename = "ico-zigarettenmadchen.jpg",
    Directives = {}
  }
}
objicoDoll = Wherigo.ZMedia(KlausKlabuster)
objicoDoll.Id = "968ba8c8-bacb-4854-8c44-50b74b64c093"
objicoDoll.Name = "ico-Doll"
objicoDoll.Description = ""
objicoDoll.AltText = ""
objicoDoll.Resources = {
  {
    Type = "jpg",
    Filename = "ico-puppe.jpg",
    Directives = {}
  }
}
objPolizist = Wherigo.ZMedia(KlausKlabuster)
objPolizist.Id = "89253b15-2a78-46d9-9489-02db6e2b4c3c"
objPolizist.Name = "Polizist"
objPolizist.Description = ""
objPolizist.AltText = ""
objPolizist.Resources = {
  {
    Type = "jpg",
    Filename = "polizist.jpg",
    Directives = {}
  }
}
objicoPolizist = Wherigo.ZMedia(KlausKlabuster)
objicoPolizist.Id = "b9986ac4-09f6-4a56-87bc-bedbea63e379"
objicoPolizist.Name = "ico-Polizist"
objicoPolizist.Description = ""
objicoPolizist.AltText = ""
objicoPolizist.Resources = {
  {
    Type = "jpg",
    Filename = "ico-polizist.jpg",
    Directives = {}
  }
}
objTeufel = Wherigo.ZMedia(KlausKlabuster)
objTeufel.Id = "c5d55d7c-95c1-485e-b923-e4a576ce306f"
objTeufel.Name = "Teufel"
objTeufel.Description = ""
objTeufel.AltText = ""
objTeufel.Resources = {
  {
    Type = "jpg",
    Filename = "teufel.jpg",
    Directives = {}
  }
}
objicoTeufel = Wherigo.ZMedia(KlausKlabuster)
objicoTeufel.Id = "ae735116-b744-4c83-84b8-da5fd67703c7"
objicoTeufel.Name = "ico-Teufel"
objicoTeufel.Description = ""
objicoTeufel.AltText = ""
objicoTeufel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-teufel.jpg",
    Directives = {}
  }
}
objEngel = Wherigo.ZMedia(KlausKlabuster)
objEngel.Id = "5fa26cff-f5f3-4673-ad75-66d7b53a4169"
objEngel.Name = "Engel"
objEngel.Description = ""
objEngel.AltText = ""
objEngel.Resources = {
  {
    Type = "jpg",
    Filename = "engel.jpg",
    Directives = {}
  }
}
objicoEngel = Wherigo.ZMedia(KlausKlabuster)
objicoEngel.Id = "b84305cd-6a00-4c97-86a1-9c7398f80155"
objicoEngel.Name = "ico-Engel"
objicoEngel.Description = ""
objicoEngel.AltText = ""
objicoEngel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-engel.jpg",
    Directives = {}
  }
}
objicohilfe = Wherigo.ZMedia(KlausKlabuster)
objicohilfe.Id = "9d1eda9d-a722-4948-8dd3-f3a26833f9e1"
objicohilfe.Name = "ico-hilfe"
objicohilfe.Description = ""
objicohilfe.AltText = ""
objicohilfe.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hilfe.jpg",
    Directives = {}
  }
}
objprefinal = Wherigo.ZMedia(KlausKlabuster)
objprefinal.Id = "81c99ae8-608e-4060-b0b1-845091db88f4"
objprefinal.Name = "prefinal"
objprefinal.Description = ""
objprefinal.AltText = ""
objprefinal.Resources = {
  {
    Type = "jpg",
    Filename = "prefinal.jpg",
    Directives = {}
  }
}
objicoprefinal = Wherigo.ZMedia(KlausKlabuster)
objicoprefinal.Id = "a743627d-ebcf-4763-b276-e3bddaba6418"
objicoprefinal.Name = "ico-prefinal"
objicoprefinal.Description = ""
objicoprefinal.AltText = ""
objicoprefinal.Resources = {
  {
    Type = "jpg",
    Filename = "ico-prefinal.jpg",
    Directives = {}
  }
}
objHilfe = Wherigo.ZMedia(KlausKlabuster)
objHilfe.Id = "e5a97faf-124f-48a8-9630-ffac86b09170"
objHilfe.Name = "Hilfe"
objHilfe.Description = ""
objHilfe.AltText = ""
objHilfe.Resources = {
  {
    Type = "jpg",
    Filename = "hilfe.jpg",
    Directives = {}
  }
}
obj_audiospray = Wherigo.ZMedia(KlausKlabuster)
obj_audiospray.Id = "94b0cdd1-b5f0-4f1b-8f98-cb446532a83c"
obj_audiospray.Name = "_audio spray"
obj_audiospray.Description = ""
obj_audiospray.AltText = ""
obj_audiospray.Resources = {
  {
    Type = "mp3",
    Filename = "aerosol-spray.mp3",
    Directives = {}
  }
}
obj_audiosteamburst = Wherigo.ZMedia(KlausKlabuster)
obj_audiosteamburst.Id = "1377069f-653d-48e8-941b-8bfb07d40f17"
obj_audiosteamburst.Name = "_audio steam burst"
obj_audiosteamburst.Description = ""
obj_audiosteamburst.AltText = ""
obj_audiosteamburst.Resources = {
  {
    Type = "mp3",
    Filename = "steam-burst.mp3",
    Directives = {}
  }
}
obj_audiomaleorgasm = Wherigo.ZMedia(KlausKlabuster)
obj_audiomaleorgasm.Id = "6b503d06-4c1f-4ac5-ba65-3bcbb73ae9f2"
obj_audiomaleorgasm.Name = "_audio male orgasm"
obj_audiomaleorgasm.Description = ""
obj_audiomaleorgasm.AltText = ""
obj_audiomaleorgasm.Resources = {
  {
    Type = "mp3",
    Filename = "male-orgasm.mp3",
    Directives = {}
  }
}
obj_audiofemalorgasm = Wherigo.ZMedia(KlausKlabuster)
obj_audiofemalorgasm.Id = "5d39d0da-5301-43dc-9d21-6e188f87ac6e"
obj_audiofemalorgasm.Name = "_audio femal orgasm"
obj_audiofemalorgasm.Description = ""
obj_audiofemalorgasm.AltText = ""
obj_audiofemalorgasm.Resources = {
  {
    Type = "mp3",
    Filename = "female_orgasm.mp3",
    Directives = {}
  }
}
obj_audiodisco = Wherigo.ZMedia(KlausKlabuster)
obj_audiodisco.Id = "6be57694-a847-42eb-a604-fde30fa1ae22"
obj_audiodisco.Name = "_audio disco"
obj_audiodisco.Description = ""
obj_audiodisco.AltText = ""
obj_audiodisco.Resources = {
  {
    Type = "mp3",
    Filename = "disco.mp3",
    Directives = {}
  }
}
obj_audiocasino = Wherigo.ZMedia(KlausKlabuster)
obj_audiocasino.Id = "457ba7a8-b4cc-49ee-b2e4-1d41c2189ad2"
obj_audiocasino.Name = "_audio casino"
obj_audiocasino.Description = ""
obj_audiocasino.AltText = ""
obj_audiocasino.Resources = {
  {
    Type = "mp3",
    Filename = "casino.mp3",
    Directives = {}
  }
}
obj_audiowhirlpool = Wherigo.ZMedia(KlausKlabuster)
obj_audiowhirlpool.Id = "c6c358fa-5a6c-4c5d-9e81-7710db613ef5"
obj_audiowhirlpool.Name = "_audio whirlpool"
obj_audiowhirlpool.Description = ""
obj_audiowhirlpool.AltText = ""
obj_audiowhirlpool.Resources = {
  {
    Type = "mp3",
    Filename = "whirlpool.mp3",
    Directives = {}
  }
}
obj_audiotoilettenmusic = Wherigo.ZMedia(KlausKlabuster)
obj_audiotoilettenmusic.Id = "cdcc9e54-3ea3-4561-b784-6704870061b8"
obj_audiotoilettenmusic.Name = "_audio toilettenmusic"
obj_audiotoilettenmusic.Description = ""
obj_audiotoilettenmusic.AltText = ""
obj_audiotoilettenmusic.Resources = {
  {
    Type = "mp3",
    Filename = "toilettenmusik.mp3",
    Directives = {}
  }
}
obj_audiowin = Wherigo.ZMedia(KlausKlabuster)
obj_audiowin.Id = "50a1e967-482e-46b1-9449-bde6e2ace445"
obj_audiowin.Name = "_audio win"
obj_audiowin.Description = ""
obj_audiowin.AltText = ""
obj_audiowin.Resources = {
  {
    Type = "mp3",
    Filename = "win.mp3",
    Directives = {}
  }
}
obj_audioloose = Wherigo.ZMedia(KlausKlabuster)
obj_audioloose.Id = "50803778-3dd6-42dd-b6c7-f9d2990e8126"
obj_audioloose.Name = "_audio loose"
obj_audioloose.Description = ""
obj_audioloose.AltText = ""
obj_audioloose.Resources = {
  {
    Type = "mp3",
    Filename = "loose.mp3",
    Directives = {}
  }
}
objHoftor = Wherigo.ZMedia(KlausKlabuster)
objHoftor.Id = "0d7fb89e-2de6-4b22-a0c3-ad8969d701e1"
objHoftor.Name = "Hoftor"
objHoftor.Description = ""
objHoftor.AltText = ""
objHoftor.Resources = {
  {
    Type = "jpg",
    Filename = "Hoftor.jpg",
    Directives = {}
  }
}
objicoHoftor = Wherigo.ZMedia(KlausKlabuster)
objicoHoftor.Id = "21708d70-e617-46ac-8d0d-81d830b08c75"
objicoHoftor.Name = "ico-Hoftor"
objicoHoftor.Description = ""
objicoHoftor.AltText = ""
objicoHoftor.Resources = {
  {
    Type = "jpg",
    Filename = "ico-Hoftor.jpg",
    Directives = {}
  }
}
objGlastur = Wherigo.ZMedia(KlausKlabuster)
objGlastur.Id = "405a34e0-b9b3-4850-9f4d-7c934cf456e1"
objGlastur.Name = "Glastur"
objGlastur.Description = ""
objGlastur.AltText = ""
objGlastur.Resources = {
  {
    Type = "jpg",
    Filename = "glastur.jpg",
    Directives = {}
  }
}
objicoGlastur = Wherigo.ZMedia(KlausKlabuster)
objicoGlastur.Id = "93096413-c0b0-4756-9caa-d9bd92fbfadf"
objicoGlastur.Name = "ico-Glastur"
objicoGlastur.Description = ""
objicoGlastur.AltText = ""
objicoGlastur.Resources = {
  {
    Type = "jpg",
    Filename = "ico-glastur.jpg",
    Directives = {}
  }
}
obj_audiofemalestop = Wherigo.ZMedia(KlausKlabuster)
obj_audiofemalestop.Id = "7776df4c-db84-467b-8f58-44279da8c305"
obj_audiofemalestop.Name = "_audio female stop"
obj_audiofemalestop.Description = ""
obj_audiofemalestop.AltText = ""
obj_audiofemalestop.Resources = {
  {
    Type = "mp3",
    Filename = "female-stop.mp3",
    Directives = {}
  }
}
obj_audiomalestop = Wherigo.ZMedia(KlausKlabuster)
obj_audiomalestop.Id = "7f0b8591-d4aa-4c34-addd-f93726dc8672"
obj_audiomalestop.Name = "_audio male stop"
obj_audiomalestop.Description = ""
obj_audiomalestop.AltText = ""
obj_audiomalestop.Resources = {
  {
    Type = "mp3",
    Filename = "male-stop.mp3",
    Directives = {}
  }
}
obj_audiobesetzt = Wherigo.ZMedia(KlausKlabuster)
obj_audiobesetzt.Id = "c90699f4-d917-474e-aa94-707207f9650d"
obj_audiobesetzt.Name = "_audio besetzt"
obj_audiobesetzt.Description = ""
obj_audiobesetzt.AltText = ""
obj_audiobesetzt.Resources = {
  {
    Type = "mp3",
    Filename = "besetzt.mp3",
    Directives = {}
  }
}
obj_audioradio = Wherigo.ZMedia(KlausKlabuster)
obj_audioradio.Id = "6f4755be-2e47-4120-b785-9237a0828783"
obj_audioradio.Name = "_audio radio"
obj_audioradio.Description = ""
obj_audioradio.AltText = ""
obj_audioradio.Resources = {
  {
    Type = "mp3",
    Filename = "radio.mp3",
    Directives = {}
  }
}
objTelefonbuch = Wherigo.ZMedia(KlausKlabuster)
objTelefonbuch.Id = "98c0db5e-3552-4290-881b-efd0bb8bffaa"
objTelefonbuch.Name = "Telefonbuch"
objTelefonbuch.Description = ""
objTelefonbuch.AltText = ""
objTelefonbuch.Resources = {
  {
    Type = "jpg",
    Filename = "telefonbuch.jpg",
    Directives = {}
  }
}
objicoTelefonbuch = Wherigo.ZMedia(KlausKlabuster)
objicoTelefonbuch.Id = "bed71344-b248-4545-8b5f-11298f9fdece"
objicoTelefonbuch.Name = "ico-Telefonbuch"
objicoTelefonbuch.Description = ""
objicoTelefonbuch.AltText = ""
objicoTelefonbuch.Resources = {
  {
    Type = "jpg",
    Filename = "ico-telefonbuch.jpg",
    Directives = {}
  }
}
objiconsa = Wherigo.ZMedia(KlausKlabuster)
objiconsa.Id = "06f9a1d6-ee2c-4c04-a1ca-7511463ba508"
objiconsa.Name = "ico-nsa"
objiconsa.Description = ""
objiconsa.AltText = ""
objiconsa.Resources = {
  {
    Type = "jpg",
    Filename = "ico-nsa.jpg",
    Directives = {}
  }
}
obj_audiobellen = Wherigo.ZMedia(KlausKlabuster)
obj_audiobellen.Id = "4c993d12-21f4-46ff-8f07-85eeb269e237"
obj_audiobellen.Name = "_audio bellen"
obj_audiobellen.Description = ""
obj_audiobellen.AltText = ""
obj_audiobellen.Resources = {
  {
    Type = "mp3",
    Filename = "bellen.mp3",
    Directives = {}
  }
}
objErzaehler = Wherigo.ZMedia(KlausKlabuster)
objErzaehler.Id = "9e9fa468-6689-4340-b712-87ff92f356a0"
objErzaehler.Name = "Erzaehler"
objErzaehler.Description = ""
objErzaehler.AltText = ""
objErzaehler.Resources = {
  {
    Type = "jpg",
    Filename = "erzahler.jpg",
    Directives = {}
  }
}
objicoErzaehler = Wherigo.ZMedia(KlausKlabuster)
objicoErzaehler.Id = "b3f89ab4-bd32-4227-8927-9ebbe1c449d0"
objicoErzaehler.Name = "ico-Erzaehler"
objicoErzaehler.Description = ""
objicoErzaehler.AltText = ""
objicoErzaehler.Resources = {
  {
    Type = "jpg",
    Filename = "ico-erzahler.jpg",
    Directives = {}
  }
}
obj_audioFenster = Wherigo.ZMedia(KlausKlabuster)
obj_audioFenster.Id = "e6b6d6d7-fffb-4617-af26-6c36e755c8eb"
obj_audioFenster.Name = "_audio Fenster"
obj_audioFenster.Description = ""
obj_audioFenster.AltText = ""
obj_audioFenster.Resources = {
  {
    Type = "mp3",
    Filename = "fenster.mp3",
    Directives = {}
  }
}
objvorFinal2 = Wherigo.ZMedia(KlausKlabuster)
objvorFinal2.Id = "ea73912e-5462-4458-b806-7076ecfe244b"
objvorFinal2.Name = "vorFinal2"
objvorFinal2.Description = ""
objvorFinal2.AltText = ""
objvorFinal2.Resources = {
  {
    Type = "jpg",
    Filename = "vorfinal2.jpg",
    Directives = {}
  }
}
objicoVorFinal2 = Wherigo.ZMedia(KlausKlabuster)
objicoVorFinal2.Id = "16644c44-8751-4472-9471-f5abfaa7a3b8"
objicoVorFinal2.Name = "ico-VorFinal2"
objicoVorFinal2.Description = ""
objicoVorFinal2.AltText = ""
objicoVorFinal2.Resources = {
  {
    Type = "jpg",
    Filename = "ico-vorfinal2.jpg",
    Directives = {}
  }
}
obj_audioHochzeit = Wherigo.ZMedia(KlausKlabuster)
obj_audioHochzeit.Id = "22435838-288a-40fc-a8ad-66e9d1c83891"
obj_audioHochzeit.Name = "_audio Hochzeit"
obj_audioHochzeit.Description = ""
obj_audioHochzeit.AltText = ""
obj_audioHochzeit.Resources = {
  {
    Type = "mp3",
    Filename = "hochzeit.mp3",
    Directives = {}
  }
}
obj_audiorefrain = Wherigo.ZMedia(KlausKlabuster)
obj_audiorefrain.Id = "dc575e20-c8f6-4256-af70-92b7fcab77c5"
obj_audiorefrain.Name = "_audio refrain"
obj_audiorefrain.Description = ""
obj_audiorefrain.AltText = ""
obj_audiorefrain.Resources = {
  {
    Type = "mp3",
    Filename = "refrain1.mp3",
    Directives = {}
  }
}
obj_audiovorFinal = Wherigo.ZMedia(KlausKlabuster)
obj_audiovorFinal.Id = "51bde412-f709-4d5c-8f20-f97a9d318fe5"
obj_audiovorFinal.Name = "_audio vorFinal"
obj_audiovorFinal.Description = ""
obj_audiovorFinal.AltText = ""
obj_audiovorFinal.Resources = {
  {
    Type = "mp3",
    Filename = "vorfinal.mp3",
    Directives = {}
  }
}
obj_audioknock = Wherigo.ZMedia(KlausKlabuster)
obj_audioknock.Id = "2867599f-8546-4cc6-a115-ad9f24bb6fe9"
obj_audioknock.Name = "_audio knock"
obj_audioknock.Description = ""
obj_audioknock.AltText = ""
obj_audioknock.Resources = {
  {
    Type = "mp3",
    Filename = "knock.mp3",
    Directives = {}
  }
}
obj_audioTusch = Wherigo.ZMedia(KlausKlabuster)
obj_audioTusch.Id = "45f63382-d802-4bba-926f-c0981a88ac8c"
obj_audioTusch.Name = "_audio Tusch"
obj_audioTusch.Description = ""
obj_audioTusch.AltText = ""
obj_audioTusch.Resources = {
  {
    Type = "mp3",
    Filename = "tusch.mp3",
    Directives = {}
  }
}
objschlaegerei = Wherigo.ZMedia(KlausKlabuster)
objschlaegerei.Id = "213f0ed5-e4b6-4e4e-8b25-430da6b101b4"
objschlaegerei.Name = "schlaegerei"
objschlaegerei.Description = ""
objschlaegerei.AltText = ""
objschlaegerei.Resources = {
  {
    Type = "jpg",
    Filename = "schlaegerei.jpg",
    Directives = {}
  }
}
objicoschlaegerei = Wherigo.ZMedia(KlausKlabuster)
objicoschlaegerei.Id = "28cb917a-9a12-4882-be06-42dd62f39d52"
objicoschlaegerei.Name = "ico-schlaegerei"
objicoschlaegerei.Description = ""
objicoschlaegerei.AltText = ""
objicoschlaegerei.Resources = {
  {
    Type = "jpg",
    Filename = "ico-schlaegerei.jpg",
    Directives = {}
  }
}
objspiegelklaus = Wherigo.ZMedia(KlausKlabuster)
objspiegelklaus.Id = "d7b9df09-a8f8-47fa-83c2-40e96049242f"
objspiegelklaus.Name = "spiegel-klaus"
objspiegelklaus.Description = ""
objspiegelklaus.AltText = ""
objspiegelklaus.Resources = {
  {
    Type = "jpg",
    Filename = "wandspiegel-Klaus.jpg",
    Directives = {}
  }
}
objshow1 = Wherigo.ZMedia(KlausKlabuster)
objshow1.Id = "180325b2-89bb-4957-9a0f-376d8d44a02c"
objshow1.Name = "show-1"
objshow1.Description = ""
objshow1.AltText = ""
objshow1.Resources = {
  {
    Type = "jpg",
    Filename = "show-01.jpg",
    Directives = {}
  }
}
objshow2 = Wherigo.ZMedia(KlausKlabuster)
objshow2.Id = "666bf9e8-8bfd-44ca-ac2a-ed73db3a137c"
objshow2.Name = "show-2"
objshow2.Description = ""
objshow2.AltText = ""
objshow2.Resources = {
  {
    Type = "jpg",
    Filename = "show-02.jpg",
    Directives = {}
  }
}
objshow3 = Wherigo.ZMedia(KlausKlabuster)
objshow3.Id = "030d5935-d8f5-4f97-9c48-6857ee0ca02d"
objshow3.Name = "show-3"
objshow3.Description = ""
objshow3.AltText = ""
objshow3.Resources = {
  {
    Type = "jpg",
    Filename = "show-03.jpg",
    Directives = {}
  }
}
obj_audioshow = Wherigo.ZMedia(KlausKlabuster)
obj_audioshow.Id = "065169c6-8141-4bc6-967c-fdf9f782b783"
obj_audioshow.Name = "_audio show"
obj_audioshow.Description = ""
obj_audioshow.AltText = ""
obj_audioshow.Resources = {
  {
    Type = "mp3",
    Filename = "show.mp3",
    Directives = {}
  }
}
objshow = Wherigo.ZMedia(KlausKlabuster)
objshow.Id = "643fc32d-b56a-4ac2-87b8-7fdb7d4d5711"
objshow.Name = "show"
objshow.Description = ""
objshow.AltText = ""
objshow.Resources = {
  {
    Type = "jpg",
    Filename = "show.jpg",
    Directives = {}
  }
}
objKoordinaten = Wherigo.ZMedia(KlausKlabuster)
objKoordinaten.Id = "2ce65ed2-ae28-4435-8773-4e7572cc66da"
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
objicoKoordinaten = Wherigo.ZMedia(KlausKlabuster)
objicoKoordinaten.Id = "2b2d7168-1de9-4e0e-a907-93248a17f891"
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
objicocurrywurststand = Wherigo.ZMedia(KlausKlabuster)
objicocurrywurststand.Id = "409bff0d-8c38-4a13-b3a5-48743bbf878b"
objicocurrywurststand.Name = "ico-currywurststand"
objicocurrywurststand.Description = ""
objicocurrywurststand.AltText = ""
objicocurrywurststand.Resources = {
  {
    Type = "jpg",
    Filename = "ico-currywurststand.jpg",
    Directives = {}
  }
}
objcurrywurst = Wherigo.ZMedia(KlausKlabuster)
objcurrywurst.Id = "dcb4d27f-e380-416f-bd68-ceec2ca7e9a5"
objcurrywurst.Name = "currywurst"
objcurrywurst.Description = ""
objcurrywurst.AltText = ""
objcurrywurst.Resources = {
  {
    Type = "jpg",
    Filename = "currywurst.jpg",
    Directives = {}
  }
}
objicocurrywurst = Wherigo.ZMedia(KlausKlabuster)
objicocurrywurst.Id = "0d9a362a-e1f1-45a3-a06e-5421b27de5dd"
objicocurrywurst.Name = "ico-currywurst"
objicocurrywurst.Description = ""
objicocurrywurst.AltText = ""
objicocurrywurst.Resources = {
  {
    Type = "jpg",
    Filename = "ico-currywurst.jpg",
    Directives = {}
  }
}
objgewonnen = Wherigo.ZMedia(KlausKlabuster)
objgewonnen.Id = "4d66cc21-0962-4476-8416-ba41ab5966b0"
objgewonnen.Name = "gewonnen"
objgewonnen.Description = ""
objgewonnen.AltText = ""
objgewonnen.Resources = {
  {
    Type = "jpg",
    Filename = "gewonnen.jpg",
    Directives = {}
  }
}
objverloren = Wherigo.ZMedia(KlausKlabuster)
objverloren.Id = "7462c960-2b87-4720-861d-5b43cf9d64ef"
objverloren.Name = "verloren"
objverloren.Description = ""
objverloren.AltText = ""
objverloren.Resources = {
  {
    Type = "jpg",
    Filename = "verloren.jpg",
    Directives = {}
  }
}
objcola = Wherigo.ZMedia(KlausKlabuster)
objcola.Id = "06953513-852f-4ceb-a148-17bc14545aec"
objcola.Name = "cola"
objcola.Description = ""
objcola.AltText = ""
objcola.Resources = {
  {
    Type = "jpg",
    Filename = "cola.jpg",
    Directives = {}
  }
}
objicocola = Wherigo.ZMedia(KlausKlabuster)
objicocola.Id = "04fddc36-d81e-4964-a29f-434cc7ff3bb0"
objicocola.Name = "ico-cola"
objicocola.Description = ""
objicocola.AltText = ""
objicocola.Resources = {
  {
    Type = "jpg",
    Filename = "ico-cola.jpg",
    Directives = {}
  }
}
objcurrywurststand = Wherigo.ZMedia(KlausKlabuster)
objcurrywurststand.Id = "d9e4a5d5-407b-4ada-8795-2f7234d72484"
objcurrywurststand.Name = "currywurststand"
objcurrywurststand.Description = ""
objcurrywurststand.AltText = ""
objcurrywurststand.Resources = {
  {
    Type = "jpg",
    Filename = "currywurststand.jpg",
    Directives = {}
  }
}
objcurryverkaeufer = Wherigo.ZMedia(KlausKlabuster)
objcurryverkaeufer.Id = "e19895ff-ecf2-4883-a496-1bf0912d2b1b"
objcurryverkaeufer.Name = "curryverkaeufer"
objcurryverkaeufer.Description = ""
objcurryverkaeufer.AltText = ""
objcurryverkaeufer.Resources = {
  {
    Type = "jpg",
    Filename = "curryverkaeufer.jpg",
    Directives = {}
  }
}
obj_audioDonner = Wherigo.ZMedia(KlausKlabuster)
obj_audioDonner.Id = "c5a57d1b-ebe6-43e2-bbae-5433dfddbf28"
obj_audioDonner.Name = "_audio Donner"
obj_audioDonner.Description = ""
obj_audioDonner.AltText = ""
obj_audioDonner.Resources = {
  {
    Type = "mp3",
    Filename = "thunder.mp3",
    Directives = {}
  }
}
obj_audiotrinken = Wherigo.ZMedia(KlausKlabuster)
obj_audiotrinken.Id = "d71a322f-b952-4965-b85e-a3a72b80f793"
obj_audiotrinken.Name = "_audio trinken"
obj_audiotrinken.Description = ""
obj_audiotrinken.AltText = ""
obj_audiotrinken.Resources = {
  {
    Type = "mp3",
    Filename = "trinken.mp3",
    Directives = {}
  }
}
obj_audiotelefonsex = Wherigo.ZMedia(KlausKlabuster)
obj_audiotelefonsex.Id = "86282b32-32c8-4647-b503-77fce68747c3"
obj_audiotelefonsex.Name = "_audio telefonsex"
obj_audiotelefonsex.Description = ""
obj_audiotelefonsex.AltText = ""
obj_audiotelefonsex.Resources = {
  {
    Type = "mp3",
    Filename = "telefonsex.mp3",
    Directives = {}
  }
}
objLandkarte = Wherigo.ZMedia(KlausKlabuster)
objLandkarte.Id = "92b87504-fd95-40e0-af03-fecd12e142a6"
objLandkarte.Name = "Landkarte"
objLandkarte.Description = ""
objLandkarte.AltText = ""
objLandkarte.Resources = {
  {
    Type = "jpg",
    Filename = "landkarte.jpg",
    Directives = {}
  }
}
objicolandkarte = Wherigo.ZMedia(KlausKlabuster)
objicolandkarte.Id = "547db125-e843-4628-a915-83bb41893ce7"
objicolandkarte.Name = "ico-landkarte"
objicolandkarte.Description = ""
objicolandkarte.AltText = ""
objicolandkarte.Resources = {
  {
    Type = "jpg",
    Filename = "ico-landkarte.jpg",
    Directives = {}
  }
}
objicoBier = Wherigo.ZMedia(KlausKlabuster)
objicoBier.Id = "3d6420d8-ba57-4723-9b6b-076015be904e"
objicoBier.Name = "ico-Bier"
objicoBier.Description = ""
objicoBier.AltText = ""
objicoBier.Resources = {
  {
    Type = "jpg",
    Filename = "ico-bierglas.jpg",
    Directives = {}
  }
}
objicoweinglas = Wherigo.ZMedia(KlausKlabuster)
objicoweinglas.Id = "11717828-467b-45d0-bceb-ff2c6c655d73"
objicoweinglas.Name = "ico-weinglas"
objicoweinglas.Description = ""
objicoweinglas.AltText = ""
objicoweinglas.Resources = {
  {
    Type = "jpg",
    Filename = "ico-weinglas.jpg",
    Directives = {}
  }
}
objgefesselt = Wherigo.ZMedia(KlausKlabuster)
objgefesselt.Id = "772d3f77-7866-4719-b90a-ae06585dfe4b"
objgefesselt.Name = "gefesselt"
objgefesselt.Description = ""
objgefesselt.AltText = ""
objgefesselt.Resources = {
  {
    Type = "jpg",
    Filename = "gefesselt.jpg",
    Directives = {}
  }
}
objSpoiler = Wherigo.ZMedia(KlausKlabuster)
objSpoiler.Id = "c6d079d5-060a-449d-8c93-982748afd880"
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
objicoSpoiler = Wherigo.ZMedia(KlausKlabuster)
objicoSpoiler.Id = "38d9878a-152d-4843-843f-a881114d5ff7"
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
objllbar = Wherigo.ZMedia(KlausKlabuster)
objllbar.Id = "4fd7282c-bbf2-4d88-9752-d2a39ed94827"
objllbar.Name = "ll-bar"
objllbar.Description = ""
objllbar.AltText = ""
objllbar.Resources = {
  {
    Type = "jpg",
    Filename = "ll-bar.jpg",
    Directives = {}
  }
}
objllbarauen = Wherigo.ZMedia(KlausKlabuster)
objllbarauen.Id = "054009ee-0564-484f-b454-c197cf84d31a"
objllbarauen.Name = "ll-bar-au?en"
objllbarauen.Description = ""
objllbarauen.AltText = ""
objllbarauen.Resources = {
  {
    Type = "jpg",
    Filename = "ll-bar-aussen.jpg",
    Directives = {}
  }
}
objllbartoilette = Wherigo.ZMedia(KlausKlabuster)
objllbartoilette.Id = "87b408c6-1913-4a2f-9b14-7e4e3400b62f"
objllbartoilette.Name = "ll-bar-toilette"
objllbartoilette.Description = ""
objllbartoilette.AltText = ""
objllbartoilette.Resources = {
  {
    Type = "jpg",
    Filename = "ll-bar-toilette.jpg",
    Directives = {}
  }
}
objllcasino = Wherigo.ZMedia(KlausKlabuster)
objllcasino.Id = "4ddeadf3-41ef-4f64-9057-45e5c8142704"
objllcasino.Name = "ll-casino"
objllcasino.Description = ""
objllcasino.AltText = ""
objllcasino.Resources = {
  {
    Type = "jpg",
    Filename = "ll-casino.jpg",
    Directives = {}
  }
}
objlldisco = Wherigo.ZMedia(KlausKlabuster)
objlldisco.Id = "949163d5-136a-435b-8260-2595d2fe22cc"
objlldisco.Name = "ll-disco"
objlldisco.Description = ""
objlldisco.AltText = ""
objlldisco.Resources = {
  {
    Type = "jpg",
    Filename = "ll-disco.jpg",
    Directives = {}
  }
}
objlldiscoaussen = Wherigo.ZMedia(KlausKlabuster)
objlldiscoaussen.Id = "4cd3e57c-6539-4583-9fc8-db5f3b96de47"
objlldiscoaussen.Name = "ll-disco-aussen"
objlldiscoaussen.Description = ""
objlldiscoaussen.AltText = ""
objlldiscoaussen.Resources = {
  {
    Type = "jpg",
    Filename = "ll-disco-aussen.jpg",
    Directives = {}
  }
}
objlldoll = Wherigo.ZMedia(KlausKlabuster)
objlldoll.Id = "048a53e6-aa08-442f-bfb8-c26a03002bd1"
objlldoll.Name = "ll-doll"
objlldoll.Description = ""
objlldoll.AltText = ""
objlldoll.Resources = {
  {
    Type = "jpg",
    Filename = "ll-doll.jpg",
    Directives = {}
  }
}
objllempfangsdame = Wherigo.ZMedia(KlausKlabuster)
objllempfangsdame.Id = "48c9cda7-1c0b-450e-9ec3-a5a6d451cf3e"
objllempfangsdame.Name = "ll-empfangsdame"
objllempfangsdame.Description = ""
objllempfangsdame.AltText = ""
objllempfangsdame.Resources = {
  {
    Type = "jpg",
    Filename = "ll-empfangsdame.jpg",
    Directives = {}
  }
}
objlleve = Wherigo.ZMedia(KlausKlabuster)
objlleve.Id = "89af7f5d-32ef-4598-a4c4-260a0cb800fc"
objlleve.Name = "ll-eve"
objlleve.Description = ""
objlleve.AltText = ""
objlleve.Resources = {
  {
    Type = "jpg",
    Filename = "ll-eve.jpg",
    Directives = {}
  }
}
objllfawn = Wherigo.ZMedia(KlausKlabuster)
objllfawn.Id = "8d0a5ab8-611a-43f7-8388-dc4384192c79"
objllfawn.Name = "ll-fawn"
objllfawn.Description = ""
objllfawn.AltText = ""
objllfawn.Resources = {
  {
    Type = "jpg",
    Filename = "ll-fawn.jpg",
    Directives = {}
  }
}
objllhinterzimmer = Wherigo.ZMedia(KlausKlabuster)
objllhinterzimmer.Id = "d0d5e2b4-72a8-4a9b-b9cd-89ad818277b4"
objllhinterzimmer.Name = "ll-hinterzimmer"
objllhinterzimmer.Description = ""
objllhinterzimmer.AltText = ""
objllhinterzimmer.Resources = {
  {
    Type = "jpg",
    Filename = "ll-hinterzimmer.jpg",
    Directives = {}
  }
}
objllhooker = Wherigo.ZMedia(KlausKlabuster)
objllhooker.Id = "7f50cd8a-925c-4cfe-88ff-6029670fd6c7"
objllhooker.Name = "ll-hooker"
objllhooker.Description = ""
objllhooker.AltText = ""
objllhooker.Resources = {
  {
    Type = "jpg",
    Filename = "ll-hooker.jpg",
    Directives = {}
  }
}
objllkapelle = Wherigo.ZMedia(KlausKlabuster)
objllkapelle.Id = "170c695d-420d-44db-8713-829c6e37f60e"
objllkapelle.Name = "ll-kapelle"
objllkapelle.Description = ""
objllkapelle.AltText = ""
objllkapelle.Resources = {
  {
    Type = "jpg",
    Filename = "ll-kapelle.jpg",
    Directives = {}
  }
}
objllwellness = Wherigo.ZMedia(KlausKlabuster)
objllwellness.Id = "54cd2630-89d0-4d2e-ac8e-2aafa4082c64"
objllwellness.Name = "ll-wellness"
objllwellness.Description = ""
objllwellness.AltText = ""
objllwellness.Resources = {
  {
    Type = "jpg",
    Filename = "ll-wellness.jpg",
    Directives = {}
  }
}
objlltreppenhaus = Wherigo.ZMedia(KlausKlabuster)
objlltreppenhaus.Id = "5e3251d4-7e5c-4e60-a0d4-ee9a595811a6"
objlltreppenhaus.Name = "ll-treppenhaus"
objlltreppenhaus.Description = ""
objlltreppenhaus.AltText = ""
objlltreppenhaus.Resources = {
  {
    Type = "jpg",
    Filename = "ll-treppenhaus.jpg",
    Directives = {}
  }
}
objllladen = Wherigo.ZMedia(KlausKlabuster)
objllladen.Id = "8bfb1234-14ba-40fe-9382-9c7b418f93b7"
objllladen.Name = "ll-laden"
objllladen.Description = ""
objllladen.AltText = ""
objllladen.Resources = {
  {
    Type = "jpg",
    Filename = "ll-laden.jpg",
    Directives = {}
  }
}
objllspielhalle = Wherigo.ZMedia(KlausKlabuster)
objllspielhalle.Id = "b4ec9831-d7c5-41f8-ac09-340f9fb5dc5b"
objllspielhalle.Name = "ll-spielhalle"
objllspielhalle.Description = ""
objllspielhalle.AltText = ""
objllspielhalle.Resources = {
  {
    Type = "jpg",
    Filename = "ll-spielhalle.jpg",
    Directives = {}
  }
}
objlltitel = Wherigo.ZMedia(KlausKlabuster)
objlltitel.Id = "7de0295b-7bbd-4937-b346-8815aa179cf4"
objlltitel.Name = "ll-titel"
objlltitel.Description = ""
objlltitel.AltText = ""
objlltitel.Resources = {
  {
    Type = "jpg",
    Filename = "ll-titel.jpg",
    Directives = {}
  }
}
objicolltitel = Wherigo.ZMedia(KlausKlabuster)
objicolltitel.Id = "cbc1c445-ce93-46be-b8ce-bd2a0bcc5c5f"
objicolltitel.Name = "ico-ll-titel"
objicolltitel.Description = ""
objicolltitel.AltText = ""
objicolltitel.Resources = {
  {
    Type = "jpg",
    Filename = "ico-ll-titel.jpg",
    Directives = {}
  }
}
objgeocoin = Wherigo.ZMedia(KlausKlabuster)
objgeocoin.Id = "17f0472b-83eb-41af-9f5b-1ea17e0f126e"
objgeocoin.Name = "geocoin"
objgeocoin.Description = ""
objgeocoin.AltText = ""
objgeocoin.Resources = {
  {
    Type = "jpg",
    Filename = "geocoin.jpg",
    Directives = {}
  }
}
objicogeocoin = Wherigo.ZMedia(KlausKlabuster)
objicogeocoin.Id = "9075e21d-fd83-4720-bb22-21310696ea43"
objicogeocoin.Name = "ico-geocoin"
objicogeocoin.Description = ""
objicogeocoin.AltText = ""
objicogeocoin.Resources = {
  {
    Type = "jpg",
    Filename = "ico-geocoin-detail.jpg",
    Directives = {}
  }
}
objgeld = Wherigo.ZMedia(KlausKlabuster)
objgeld.Id = "83fa518f-6a93-4347-a2a0-0f6f7bf7eca7"
objgeld.Name = "geld"
objgeld.Description = ""
objgeld.AltText = ""
objgeld.Resources = {
  {
    Type = "jpg",
    Filename = "geld.jpg",
    Directives = {}
  }
}
objicogeld = Wherigo.ZMedia(KlausKlabuster)
objicogeld.Id = "e07b4c44-a9e6-4149-80ac-c9563d5d8a69"
objicogeld.Name = "ico-geld"
objicogeld.Description = ""
objicogeld.AltText = ""
objicogeld.Resources = {
  {
    Type = "jpg",
    Filename = "ico-geld.jpg",
    Directives = {}
  }
}
objzigaretten = Wherigo.ZMedia(KlausKlabuster)
objzigaretten.Id = "9ff4e97f-9fc2-478e-93ac-e705acdb34e4"
objzigaretten.Name = "zigaretten"
objzigaretten.Description = ""
objzigaretten.AltText = ""
objzigaretten.Resources = {
  {
    Type = "jpg",
    Filename = "DDR_Club_Zigaretten.jpg",
    Directives = {}
  }
}
objicozigaretten = Wherigo.ZMedia(KlausKlabuster)
objicozigaretten.Id = "43b66c23-9070-4369-8eda-4181fa61fa16"
objicozigaretten.Name = "ico-zigaretten"
objicozigaretten.Description = ""
objicozigaretten.AltText = ""
objicozigaretten.Resources = {
  {
    Type = "jpg",
    Filename = "ico-DDR_Club_Zigaretten.jpg",
    Directives = {}
  }
}
objicohundsitzend = Wherigo.ZMedia(KlausKlabuster)
objicohundsitzend.Id = "3391b1f5-0db1-4a38-aa10-2b04cc69ba87"
objicohundsitzend.Name = "ico-hund-sitzend"
objicohundsitzend.Description = ""
objicohundsitzend.AltText = ""
objicohundsitzend.Resources = {
  {
    Type = "jpg",
    Filename = "ico-hund-sitzend.jpg",
    Directives = {}
  }
}
obj24stdshop = Wherigo.ZMedia(KlausKlabuster)
obj24stdshop.Id = "45324801-0dd0-4b3f-9410-c7651f7300dc"
obj24stdshop.Name = "24stdshop"
obj24stdshop.Description = ""
obj24stdshop.AltText = ""
obj24stdshop.Resources = {
  {
    Type = "jpg",
    Filename = "telefon-zelle.jpg",
    Directives = {}
  }
}
objicofernsehermaja = Wherigo.ZMedia(KlausKlabuster)
objicofernsehermaja.Id = "474068bb-08de-4f46-818b-3db903856495"
objicofernsehermaja.Name = "ico-fernseher-maja"
objicofernsehermaja.Description = ""
objicofernsehermaja.AltText = ""
objicofernsehermaja.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernseher-maja.jpg",
    Directives = {}
  }
}
objicofernsehersport = Wherigo.ZMedia(KlausKlabuster)
objicofernsehersport.Id = "8165a03f-fb1f-4f7e-a6ef-48c05a58a179"
objicofernsehersport.Name = "ico-fernseher-sport"
objicofernsehersport.Description = ""
objicofernsehersport.AltText = ""
objicofernsehersport.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernseher-sport.jpg",
    Directives = {}
  }
}
objicofernseherporno = Wherigo.ZMedia(KlausKlabuster)
objicofernseherporno.Id = "cb2fcbbf-a26b-40a2-ba10-6aafa4673305"
objicofernseherporno.Name = "ico-fernseher-porno"
objicofernseherporno.Description = ""
objicofernseherporno.AltText = ""
objicofernseherporno.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernseher-porno.jpg",
    Directives = {}
  }
}
objicofernseheraus = Wherigo.ZMedia(KlausKlabuster)
objicofernseheraus.Id = "b01b205b-7987-491a-80c3-1693863590bc"
objicofernseheraus.Name = "ico-fernseher-aus"
objicofernseheraus.Description = ""
objicofernseheraus.AltText = ""
objicofernseheraus.Resources = {
  {
    Type = "jpg",
    Filename = "ico-fernseher-aus.jpg",
    Directives = {}
  }
}
objkippe = Wherigo.ZMedia(KlausKlabuster)
objkippe.Id = "520afb73-1f1a-4ace-b8dc-00a17dd936c9"
objkippe.Name = "kippe"
objkippe.Description = ""
objkippe.AltText = ""
objkippe.Resources = {
  {
    Type = "jpg",
    Filename = "kippe.jpg",
    Directives = {}
  }
}
objicokippe = Wherigo.ZMedia(KlausKlabuster)
objicokippe.Id = "40540810-a6b3-493a-8529-f355716ee9a6"
objicokippe.Name = "ico-kippe"
objicokippe.Description = ""
objicokippe.AltText = ""
objicokippe.Resources = {
  {
    Type = "jpg",
    Filename = "ico-kippe.jpg",
    Directives = {}
  }
}
objzigarettenqualm = Wherigo.ZMedia(KlausKlabuster)
objzigarettenqualm.Id = "e09c4b9f-2d7f-48a4-b929-6675db6d7103"
objzigarettenqualm.Name = "zigarettenqualm"
objzigarettenqualm.Description = ""
objzigarettenqualm.AltText = ""
objzigarettenqualm.Resources = {
  {
    Type = "jpg",
    Filename = "zigarettenqualm.jpg",
    Directives = {}
  }
}
objhandschellen = Wherigo.ZMedia(KlausKlabuster)
objhandschellen.Id = "bf0c49c5-b35f-4f44-a451-6e672dab38ce"
objhandschellen.Name = "handschellen"
objhandschellen.Description = ""
objhandschellen.AltText = ""
objhandschellen.Resources = {
  {
    Type = "jpg",
    Filename = "handschellen.jpg",
    Directives = {}
  }
}
objmuelleimer = Wherigo.ZMedia(KlausKlabuster)
objmuelleimer.Id = "301bd22b-e6f8-42a2-8038-1d9073b7fce5"
objmuelleimer.Name = "muelleimer"
objmuelleimer.Description = ""
objmuelleimer.AltText = ""
objmuelleimer.Resources = {
  {
    Type = "jpg",
    Filename = "muelleimer.jpg",
    Directives = {}
  }
}
objicomuelleimer = Wherigo.ZMedia(KlausKlabuster)
objicomuelleimer.Id = "2bb36ce6-6040-4ae0-a521-fee427c9fb88"
objicomuelleimer.Name = "ico-muelleimer"
objicomuelleimer.Description = ""
objicomuelleimer.AltText = ""
objicomuelleimer.Resources = {
  {
    Type = "jpg",
    Filename = "ico-muelleimer.jpg",
    Directives = {}
  }
}
objZentrale = Wherigo.ZMedia(KlausKlabuster)
objZentrale.Id = "a2c5c0c6-0ae2-41cc-9d28-469f2728a4ff"
objZentrale.Name = "Zentrale"
objZentrale.Description = ""
objZentrale.AltText = ""
objZentrale.Resources = {
  {
    Type = "jpg",
    Filename = "polizeizentrale.jpg",
    Directives = {}
  }
}
KlausKlabuster.Id = "8347e85e-172c-4942-b10b-e40d3d9908f6"
KlausKlabuster.Name = "Klaus Klabuster"
KlausKlabuster.Description = [[
Begleitet Klaus auf seiner Suche nach dem Glueck. Nach seinem letzten Telefonat mit seinem Halbbruder Larry ist Klaus sicher, ebenfalls seine Traumfrau zu finden. Und wo kann dies besser gelingen als in der Spandau, der kleinen Stadt noerdlich seines Dorfes Kladow. <BR>
<BR>
Wenn Klaus seine Traumfrau finden sollte, erhaelt er als Belohnung eine Einladung, sich als Miteigentuemer ihres Hauses am See! einzutragen. <BR>
<BR>
Es handelt sich um einen relativ einfachen Wherigo-Cache, bei dem ihr wenig falsch machen koennt. Allerdings wirken sich falsche Entscheidungen auf die Dauer eurer Suche aus. Also denkt nach! ]]
KlausKlabuster.Visible = true
KlausKlabuster.Activity = "Fiction"
KlausKlabuster.StartingLocationDescription = [[
Du startest in der Fussgaengerzone in Spandau. Ein Parkplatz findest Du in den Spandau-Arcaden. Du kannst aber auch mit der BVG bis zum Rathaus Spandau fahren. <BR>
Dein Ziel? Natuerlich das Haus am See!]]
KlausKlabuster.StartingLocation = ZonePoint(52.5349, 13.198733, 0)
KlausKlabuster.Version = "5.7"
KlausKlabuster.Company = ""
KlausKlabuster.Author = "tmz"
KlausKlabuster.BuilderVersion = "URWIGO 1.22.5798.37755"
KlausKlabuster.CreateDate = "08/19/2015 14:15:13"
KlausKlabuster.PublishDate = "1/1/0001 12:00:00 AM"
KlausKlabuster.UpdateDate = "05/22/2016 15:09:33"
KlausKlabuster.LastPlayedDate = "1/1/0001 12:00:00 AM"
KlausKlabuster.TargetDevice = "PocketPC"
KlausKlabuster.TargetDeviceVersion = "0"
KlausKlabuster.StateId = "1"
KlausKlabuster.CountryId = "2"
KlausKlabuster.Complete = false
KlausKlabuster.UseLogging = true
KlausKlabuster.Media = objTitelbild
KlausKlabuster.Icon = objicoTitel
zMP = Wherigo.Zone(KlausKlabuster)
zMP.Id = "fbe0646f-2d19-4320-9dcf-5c43f45ea48b"
zMP.Name = "Marktplatz"
zMP.Description = "Der Marktplatz in der Altstadt von Spandau. Alle Abenteuer liegen jetzt vor Dir. Greif' zu!"
zMP.Visible = true
zMP.Media = objMarktplatz
zMP.Icon = objicomarktplatz
zMP.Commands = {}
zMP.DistanceRange = Distance(-1, "feet")
zMP.ShowObjects = "OnEnter"
zMP.ProximityRange = Distance(10, "meters")
zMP.AllowSetPositionTo = false
zMP.Active = true
zMP.Points = {
  ZonePoint(52.5376592695246, 13.2037304506655, 0),
  ZonePoint(52.5374929263969, 13.2035513912502, 0),
  ZonePoint(52.5366135182036, 13.2051999209691, 0),
  ZonePoint(52.5368793715109, 13.2055208587472, 0),
  ZonePoint(52.5369918736837, 13.2052780578996, 0),
  ZonePoint(52.5371273366921, 13.2054423805585, 0)
}
zMP.OriginalPoint = ZonePoint(52.5371273826686, 13.2047871766817, 0)
zMP.DistanceRangeUOM = "Feet"
zMP.ProximityRangeUOM = "Meters"
zMP.OutOfRangeName = ""
zMP.InRangeName = ""
zBA = Wherigo.Zone(KlausKlabuster)
zBA.Id = "d83e478f-4619-4f71-93c2-b0c3f92915fc"
zBA.Name = "Bar"
zBA.Description = "Die blaue Maus - eine kleine Bar in der Altstadt von Spandau. Auch ein Himmel auf Erden."
zBA.Visible = true
zBA.Media = objBar
zBA.Icon = objicoblauemaus
zBA.Commands = {}
zBA.DistanceRange = Distance(-1, "feet")
zBA.ShowObjects = "OnEnter"
zBA.ProximityRange = Distance(10, "meters")
zBA.AllowSetPositionTo = false
zBA.Active = false
zBA.Points = {
  ZonePoint(52.5378418250045, 13.2027337453133, 0),
  ZonePoint(52.5379706420352, 13.2028363523549, 0),
  ZonePoint(52.5376608791346, 13.203691900701, 0),
  ZonePoint(52.537507542184, 13.2035209508043, 0)
}
zBA.OriginalPoint = ZonePoint(52.5377452220896, 13.2031957372934, 0)
zBA.DistanceRangeUOM = "Feet"
zBA.ProximityRangeUOM = "Meters"
zBA.OutOfRangeName = ""
zBA.InRangeName = ""
zHA = Wherigo.Zone(KlausKlabuster)
zHA.Id = "4e936538-00f6-44c8-8333-3b631f03d93c"
zHA.Name = "Hotel"
zHA.Description = "Ein kleines vertraeumtes Hotel in der Spandauer Altstadt."
zHA.Visible = true
zHA.Media = objHotel
zHA.Icon = objicohotel
zHA.Commands = {}
zHA.DistanceRange = Distance(-1, "feet")
zHA.ShowObjects = "OnEnter"
zHA.ProximityRange = Distance(10, "meters")
zHA.AllowSetPositionTo = false
zHA.Active = false
zHA.Points = {
  ZonePoint(52.5369891640762, 13.2053068726757, 0),
  ZonePoint(52.5368886165071, 13.205544259077, 0),
  ZonePoint(52.5370215886804, 13.2056232609021, 0),
  ZonePoint(52.5371146433113, 13.2054501257137, 0)
}
zHA.OriginalPoint = ZonePoint(52.5370035031438, 13.2054811295921, 0)
zHA.DistanceRangeUOM = "Feet"
zHA.ProximityRangeUOM = "Meters"
zHA.OutOfRangeName = ""
zHA.InRangeName = ""
zKA = Wherigo.Zone(KlausKlabuster)
zKA.Id = "2238f05a-6ca0-45f1-835f-43639b5684ed"
zKA.Name = "Kirche"
zKA.Description = "St. Nicolai in Spandau. Der Himmel auf Erden hat einen Vordereingang."
zKA.Visible = true
zKA.Media = objKirche
zKA.Icon = objicoKirche
zKA.Commands = {
  cmdinfo = Wherigo.ZCommand({
    Text = "info",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
zKA.Commands.cmdinfo.Custom = true
zKA.Commands.cmdinfo.Id = "7862b6ca-3306-4d0f-93a7-55592293a65d"
zKA.Commands.cmdinfo.WorksWithAll = true
zKA.DistanceRange = Distance(-1, "feet")
zKA.ShowObjects = "OnEnter"
zKA.ProximityRange = Distance(10, "meters")
zKA.AllowSetPositionTo = false
zKA.Active = false
zKA.Points = {
  ZonePoint(52.537436926259, 13.2048324118342, 0),
  ZonePoint(52.5373539885293, 13.2047514014771, 0),
  ZonePoint(52.5372997409478, 13.2049346195277, 0),
  ZonePoint(52.5373908623695, 13.2050049279292, 0)
}
zKA.OriginalPoint = ZonePoint(52.5373703795264, 13.2048808401921, 0)
zKA.DistanceRangeUOM = "Feet"
zKA.ProximityRangeUOM = "Meters"
zKA.OutOfRangeName = ""
zKA.InRangeName = ""
zCA = Wherigo.Zone(KlausKlabuster)
zCA.Id = "830f8e1b-63e8-4610-8cf8-ef44f8ae138e"
zCA.Name = "Casino"
zCA.Description = [[
Die Rotunde am Rand der Altstadt.<BR>
Geld oder Heisse Liebe - oder Geld fur die Liebe. Hier ist alles moglich.]]
zCA.Visible = true
zCA.Media = objCasino
zCA.Icon = objicocasino
zCA.Commands = {}
zCA.DistanceRange = Distance(-1, "feet")
zCA.ShowObjects = "OnEnter"
zCA.ProximityRange = Distance(10, "meters")
zCA.AllowSetPositionTo = false
zCA.Active = false
zCA.Points = {
  ZonePoint(52.537494406668, 13.2034912550805, 0),
  ZonePoint(52.5370184219937, 13.2027744693965, 0),
  ZonePoint(52.5369363389843, 13.2029841795986, 0),
  ZonePoint(52.537393482917, 13.203727602178, 0)
}
zCA.OriginalPoint = ZonePoint(52.5372106626408, 13.2032443765634, 0)
zCA.DistanceRangeUOM = "Feet"
zCA.ProximityRangeUOM = "Meters"
zCA.OutOfRangeName = ""
zCA.InRangeName = ""
zBF = Wherigo.Zone(KlausKlabuster)
zBF.Id = "0985ece3-9234-4602-9d70-1a604801300f"
zBF.Name = "Flur"
zBF.Description = "Vorne hui, hinten pfui. Scheinbar hat des Geld nur fuer den Barraum gereicht."
zBF.Visible = true
zBF.Media = objbarflur
zBF.Icon = objicobarflur
zBF.Commands = {}
zBF.DistanceRange = Distance(-1, "feet")
zBF.ShowObjects = "OnEnter"
zBF.ProximityRange = Distance(10, "meters")
zBF.AllowSetPositionTo = false
zBF.Active = false
zBF.Points = {
  ZonePoint(52.5376735439885, 13.2025721723872, 0),
  ZonePoint(52.53782627517, 13.2027125156877, 0),
  ZonePoint(52.5379077336027, 13.2024927591805, 0),
  ZonePoint(52.5377625844181, 13.2023536253969, 0)
}
zBF.OriginalPoint = ZonePoint(52.5377925342948, 13.2025327681631, 0)
zBF.DistanceRangeUOM = "Feet"
zBF.ProximityRangeUOM = "Meters"
zBF.OutOfRangeName = ""
zBF.InRangeName = ""
zBK = Wherigo.Zone(KlausKlabuster)
zBK.Id = "decf13d8-20c7-4f85-8bda-fed0de512284"
zBK.Name = "Toilette"
zBK.Description = "Auf dem Weg nach unten bist du schon weit gekommen."
zBK.Visible = true
zBK.Media = objbartoilette
zBK.Icon = objicoToilette
zBK.Commands = {}
zBK.DistanceRange = Distance(-1, "feet")
zBK.ShowObjects = "OnEnter"
zBK.ProximityRange = Distance(10, "meters")
zBK.AllowSetPositionTo = false
zBK.Active = false
zBK.Points = {
  ZonePoint(52.5376579655014, 13.2025519239778, 0),
  ZonePoint(52.5377430074503, 13.2023437644815, 0),
  ZonePoint(52.5376262801868, 13.2022311114576, 0),
  ZonePoint(52.537536711536, 13.2024389295371, 0)
}
zBK.OriginalPoint = ZonePoint(52.5376409911686, 13.2023914323635, 0)
zBK.DistanceRangeUOM = "Feet"
zBK.ProximityRangeUOM = "Meters"
zBK.OutOfRangeName = ""
zBK.InRangeName = ""
zBI = Wherigo.Zone(KlausKlabuster)
zBI.Id = "75f32287-4772-40ba-81a9-1909964b1107"
zBI.Name = "Barraum"
zBI.Description = "Schummriges Licht, Musik - ein Hauch von Caipirinha in der Luft. Ein guter Ort, um das Wochenende zu beginnen."
zBI.Visible = true
zBI.Media = objBarraum
zBI.Icon = objicoBarraum
zBI.Commands = {}
zBI.DistanceRange = Distance(-1, "feet")
zBI.ShowObjects = "OnEnter"
zBI.ProximityRange = Distance(10, "meters")
zBI.AllowSetPositionTo = false
zBI.Active = false
zBI.Points = {
  ZonePoint(52.5379195211846, 13.2025097206706, 0),
  ZonePoint(52.5378367991909, 13.2027125156592, 0),
  ZonePoint(52.5379706706884, 13.2028073393456, 0),
  ZonePoint(52.5380250829404, 13.2026105915699, 0)
}
zBI.OriginalPoint = ZonePoint(52.5379380185011, 13.2026600418113, 0)
zBI.DistanceRangeUOM = "Feet"
zBI.ProximityRangeUOM = "Meters"
zBI.OutOfRangeName = ""
zBI.InRangeName = ""
zBZ = Wherigo.Zone(KlausKlabuster)
zBZ.Id = "2ce259b0-4739-4bce-a547-fecda203c197"
zBZ.Name = "Hinterzimmer"
zBZ.Description = "Etwas plueschig im Vergleich zum Rest."
zBZ.Visible = true
zBZ.Media = objbarzimmer
zBZ.Icon = objicobarzimmerhure
zBZ.Commands = {}
zBZ.DistanceRange = Distance(-1, "feet")
zBZ.ShowObjects = "OnEnter"
zBZ.ProximityRange = Distance(10, "meters")
zBZ.AllowSetPositionTo = false
zBZ.Active = false
zBZ.Points = {
  ZonePoint(52.5385090440062, 13.2031419619491, 0),
  ZonePoint(52.5380899956681, 13.2046644218288, 0),
  ZonePoint(52.5380563995447, 13.2043271491959, 0),
  ZonePoint(52.5383724822574, 13.2032244815648, 0)
}
zBZ.OriginalPoint = ZonePoint(52.5382569803691, 13.2038395036347, 0)
zBZ.DistanceRangeUOM = "Feet"
zBZ.ProximityRangeUOM = "Meters"
zBZ.OutOfRangeName = ""
zBZ.InRangeName = ""
zHG = Wherigo.Zone(KlausKlabuster)
zHG.Id = "05bb5483-18f6-4088-8787-4fb9c416ab6f"
zHG.Name = "Hinterhof"
zHG.Description = "Ein Blick, und du hast alle gesehen."
zHG.Visible = true
zHG.Media = objHinterhof
zHG.Icon = objicohinterhof
zHG.Commands = {}
zHG.DistanceRange = Distance(-1, "feet")
zHG.ShowObjects = "OnEnter"
zHG.ProximityRange = Distance(10, "meters")
zHG.AllowSetPositionTo = false
zHG.Active = false
zHG.Points = {
  ZonePoint(52.5375792086743, 13.204028245061, 0),
  ZonePoint(52.5376702180165, 13.2037515035952, 0),
  ZonePoint(52.5380410928001, 13.2042973623305, 0),
  ZonePoint(52.5380643574708, 13.2045967692175, 0)
}
zHG.OriginalPoint = ZonePoint(52.5378387192404, 13.2041684700511, 0)
zHG.DistanceRangeUOM = "Feet"
zHG.ProximityRangeUOM = "Meters"
zHG.OutOfRangeName = ""
zHG.InRangeName = ""
zBT = Wherigo.Zone(KlausKlabuster)
zBT.Id = "21a1b4c9-f02d-4fa1-bacc-2936d7ff84c9"
zBT.Name = "Treppenhaus"
zBT.Description = "oha - ein Weg nach oben, naeher zum Himmel."
zBT.Visible = true
zBT.Media = objbartreppenhaus
zBT.Icon = objicobartreppe
zBT.Commands = {}
zBT.DistanceRange = Distance(1, "meters")
zBT.ShowObjects = "OnEnter"
zBT.ProximityRange = Distance(10, "meters")
zBT.AllowSetPositionTo = false
zBT.Active = false
zBT.Points = {
  ZonePoint(52.5383684173854, 13.2032011846034, 0),
  ZonePoint(52.5385079577423, 13.2031212044063, 0),
  ZonePoint(52.5380373986353, 13.2026209790258, 0),
  ZonePoint(52.5379771963576, 13.20282516875, 0)
}
zBT.OriginalPoint = ZonePoint(52.5382227425302, 13.2029421341964, 0)
zBT.DistanceRangeUOM = "Meters"
zBT.ProximityRangeUOM = "Meters"
zBT.OutOfRangeName = ""
zBT.InRangeName = ""
zCI = Wherigo.Zone(KlausKlabuster)
zCI.Id = "dc81ba15-42ae-483f-b8a8-c889656c5a9f"
zCI.Name = "Spielhalle"
zCI.Description = "Spielhallo, oder Spielhoelle? Auf jeden Fall Chancen und Risiken."
zCI.Visible = true
zCI.Media = objCasinoinnen
zCI.Icon = objicoCasinoinnen
zCI.Commands = {}
zCI.DistanceRange = Distance(-1, "feet")
zCI.ShowObjects = "OnEnter"
zCI.ProximityRange = Distance(10, "meters")
zCI.AllowSetPositionTo = false
zCI.Active = false
zCI.Points = {
  ZonePoint(52.5369073880219, 13.202628605586, 0),
  ZonePoint(52.5370018997988, 13.2027505927675, 0),
  ZonePoint(52.536929285157, 13.202947155296, 0),
  ZonePoint(52.5368347732312, 13.2028180675685, 0)
}
zCI.OriginalPoint = ZonePoint(52.5369183365522, 13.2027861053045, 0)
zCI.DistanceRangeUOM = "Feet"
zCI.ProximityRangeUOM = "Meters"
zCI.OutOfRangeName = ""
zCI.InRangeName = ""
zLA = Wherigo.Zone(KlausKlabuster)
zLA.Id = "bd2c2d21-651d-45aa-bc5b-c929b5f018ca"
zLA.Name = "Kaisers"
zLA.Description = "Der Gourmet-Tempel in der Altstadt."
zLA.Visible = true
zLA.Media = objKaisers
zLA.Icon = objicoKaisers
zLA.Commands = {}
zLA.DistanceRange = Distance(-1, "feet")
zLA.ShowObjects = "OnEnter"
zLA.ProximityRange = Distance(10, "meters")
zLA.AllowSetPositionTo = false
zLA.Active = false
zLA.Points = {
  ZonePoint(52.5370947613094, 13.2039156778381, 0),
  ZonePoint(52.5369742622442, 13.2041363173809, 0),
  ZonePoint(52.5370950847967, 13.2042583639908, 0),
  ZonePoint(52.5371973825349, 13.2040542899997, 0)
}
zLA.OriginalPoint = ZonePoint(52.5370903727213, 13.2040911623024, 0)
zLA.DistanceRangeUOM = "Feet"
zLA.ProximityRangeUOM = "Meters"
zLA.OutOfRangeName = ""
zLA.InRangeName = ""
zLI = Wherigo.Zone(KlausKlabuster)
zLI.Id = "da130533-56d5-4e05-b606-ee82e9c4629b"
zLI.Name = "Verkaufsraum"
zLI.Description = "Einfach, uebersichtlich - wie es von Kaisers bekannt ist."
zLI.Visible = true
zLI.Media = objKaisersinnen
zLI.Icon = objicoKaisersinnen
zLI.Commands = {}
zLI.DistanceRange = Distance(-1, "feet")
zLI.ShowObjects = "OnEnter"
zLI.ProximityRange = Distance(10, "meters")
zLI.AllowSetPositionTo = false
zLI.Active = false
zLI.Points = {
  ZonePoint(52.5369436326681, 13.2037175899149, 0),
  ZonePoint(52.5368502625209, 13.2039143428804, 0),
  ZonePoint(52.536968139793, 13.2041211025563, 0),
  ZonePoint(52.5370839077794, 13.2038999211614, 0)
}
zLI.OriginalPoint = ZonePoint(52.5369614856903, 13.2039132391282, 0)
zLI.DistanceRangeUOM = "Feet"
zLI.ProximityRangeUOM = "Meters"
zLI.OutOfRangeName = ""
zLI.InRangeName = ""
zDA = Wherigo.Zone(KlausKlabuster)
zDA.Id = "d44502e2-f9cc-441e-a3da-bfd0fe999730"
zDA.Name = "Disco"
zDA.Description = "Natuerlich gehoert ein Tanztempel in jede Stadt - und ist sie auch noch so klein."
zDA.Visible = true
zDA.Media = objDisco
zDA.Icon = objicoDisco
zDA.Commands = {}
zDA.DistanceRange = Distance(-1, "feet")
zDA.ShowObjects = "OnEnter"
zDA.ProximityRange = Distance(10, "meters")
zDA.AllowSetPositionTo = false
zDA.Active = false
zDA.Points = {
  ZonePoint(52.5367195491272, 13.2049641232351, 0),
  ZonePoint(52.5366069242909, 13.2051882350063, 0),
  ZonePoint(52.5365124582193, 13.2050391094383, 0),
  ZonePoint(52.5366114974259, 13.2048415398959, 0)
}
zDA.OriginalPoint = ZonePoint(52.5366126072658, 13.2050082518939, 0)
zDA.DistanceRangeUOM = "Feet"
zDA.ProximityRangeUOM = "Meters"
zDA.OutOfRangeName = ""
zDA.InRangeName = ""
zDI = Wherigo.Zone(KlausKlabuster)
zDI.Id = "ed20401c-8426-4847-8135-245389ae99ef"
zDI.Name = "Tanzflaeche"
zDI.Description = "Schwitzende Menschen, heisse, zuckende Leiber im Rhythmus der Nacht."
zDI.Visible = true
zDI.Media = objDisocinnen
zDI.Icon = objicoDiscoinnen
zDI.Commands = {}
zDI.DistanceRange = Distance(-1, "feet")
zDI.ShowObjects = "OnEnter"
zDI.ProximityRange = Distance(10, "meters")
zDI.AllowSetPositionTo = false
zDI.Active = false
zDI.Points = {
  ZonePoint(52.5365925243663, 13.2048053936805, 0),
  ZonePoint(52.536500545132, 13.2050091262405, 0),
  ZonePoint(52.5363655941358, 13.2048567982979, 0),
  ZonePoint(52.5364583767012, 13.204631177051, 0)
}
zDI.OriginalPoint = ZonePoint(52.5364792600838, 13.2048256238175, 0)
zDI.DistanceRangeUOM = "Feet"
zDI.ProximityRangeUOM = "Meters"
zDI.OutOfRangeName = ""
zDI.InRangeName = ""
zHL = Wherigo.Zone(KlausKlabuster)
zHL.Id = "0dc0d84c-8d7e-42f1-9206-ee752d502640"
zHL.Name = "Hotelrezeption"
zHL.Description = "Stylisch, modern. Ein wohltuender Kontrast zur Altstadt."
zHL.Visible = true
zHL.Media = objRezeption
zHL.Icon = objicoRezeption
zHL.Commands = {}
zHL.DistanceRange = Distance(-1, "feet")
zHL.ShowObjects = "OnEnter"
zHL.ProximityRange = Distance(10, "meters")
zHL.AllowSetPositionTo = false
zHL.Active = false
zHL.Points = {
  ZonePoint(52.5372180750545, 13.205582220173, 0),
  ZonePoint(52.5371446116887, 13.2057601766705, 0),
  ZonePoint(52.5370274675057, 13.2056329025176, 0),
  ZonePoint(52.5371214760225, 13.2054693043483, 0)
}
zHL.OriginalPoint = ZonePoint(52.5371279075679, 13.2056111509273, 0)
zHL.DistanceRangeUOM = "Feet"
zHL.ProximityRangeUOM = "Meters"
zHL.OutOfRangeName = ""
zHL.InRangeName = ""
zHZ = Wherigo.Zone(KlausKlabuster)
zHZ.Id = "c82b8933-d265-4aac-9c43-2b14ae998111"
zHZ.Name = "Hotelzimmer"
zHZ.Description = "Die Hochzeitssuite. Werden hier deine Traeume wahr?"
zHZ.Visible = true
zHZ.Media = objHotelzimmer
zHZ.Icon = objicoHotelzimmer
zHZ.Commands = {}
zHZ.DistanceRange = Distance(-1, "feet")
zHZ.ShowObjects = "OnEnter"
zHZ.ProximityRange = Distance(10, "meters")
zHZ.AllowSetPositionTo = false
zHZ.Active = false
zHZ.Points = {
  ZonePoint(52.5370695894221, 13.205980415806, 0),
  ZonePoint(52.5371415565337, 13.2057834078603, 0),
  ZonePoint(52.5370238607867, 13.2056540186095, 0),
  ZonePoint(52.5369467918435, 13.2058429417851, 0)
}
zHZ.OriginalPoint = ZonePoint(52.5370454496465, 13.2058151960152, 0)
zHZ.DistanceRangeUOM = "Feet"
zHZ.ProximityRangeUOM = "Meters"
zHZ.OutOfRangeName = ""
zHZ.InRangeName = ""
zHW = Wherigo.Zone(KlausKlabuster)
zHW.Id = "df5fb910-88b4-452c-ae56-49f90195fd5a"
zHW.Name = "Wellnessbereich"
zHW.Description = "Natuerlich. Ein Hotel dieser Klasse hat auch einen Wellnessbereich."
zHW.Visible = true
zHW.Media = objWellnessbereich
zHW.Icon = objicoWellnessbereich
zHW.Commands = {}
zHW.DistanceRange = Distance(-1, "feet")
zHW.ShowObjects = "OnEnter"
zHW.ProximityRange = Distance(10, "meters")
zHW.AllowSetPositionTo = false
zHW.Active = false
zHW.Points = {
  ZonePoint(52.5373170418683, 13.2057273238148, 0),
  ZonePoint(52.5372510484285, 13.2059026140404, 0),
  ZonePoint(52.537145692471, 13.2057956667317, 0),
  ZonePoint(52.5372244172822, 13.205594422474, 0)
}
zHW.OriginalPoint = ZonePoint(52.5372345500125, 13.2057550067652, 0)
zHW.DistanceRangeUOM = "Feet"
zHW.ProximityRangeUOM = "Meters"
zHW.OutOfRangeName = ""
zHW.InRangeName = ""
zF0 = Wherigo.Zone(KlausKlabuster)
zF0.Id = "998a1262-98b9-4c2a-9564-50300f287d38"
zF0.Name = "Final"
zF0.Description = "Endlich. Der See, das Haus. Dein Ziel ist zum Greifen nah."
zF0.Visible = true
zF0.Media = objseeblick
zF0.Icon = objicoseeblick
zF0.Commands = {}
zF0.DistanceRange = Distance(-1, "feet")
zF0.ShowObjects = "OnEnter"
zF0.ProximityRange = Distance(10, "meters")
zF0.AllowSetPositionTo = false
zF0.Active = false
zF0.Points = {
  ZonePoint(52.4710639780315, 13.1172608860723, 0),
  ZonePoint(52.4711164472213, 13.1167653836084, 0),
  ZonePoint(52.4713975820741, 13.1170846373192, 0),
  ZonePoint(52.4713745244321, 13.1174915152889, 0)
}
zF0.OriginalPoint = ZonePoint(52.4712381329398, 13.1171506055722, 0)
zF0.DistanceRangeUOM = "Feet"
zF0.ProximityRangeUOM = "Meters"
zF0.OutOfRangeName = ""
zF0.InRangeName = ""
zKI = Wherigo.Zone(KlausKlabuster)
zKI.Id = "6d4a7688-276e-4892-8001-694c53f80e56"
zKI.Name = "Altarraum"
zKI.Description = [[
Das Kirchenschiff der St. Nicolai-Kirche, lichtdurchflutet und schlicht.<BR>
Jedoch ein Schritt weiter auf dem Weg zum Himmel.]]
zKI.Visible = true
zKI.Media = objAltarraum
zKI.Icon = objicoAltarraum
zKI.Commands = {}
zKI.DistanceRange = Distance(-1, "feet")
zKI.ShowObjects = "OnEnter"
zKI.ProximityRange = Distance(10, "meters")
zKI.AllowSetPositionTo = false
zKI.Active = false
zKI.Points = {
  ZonePoint(52.5374501958693, 13.2048443268009, 0),
  ZonePoint(52.5374037952619, 13.2050199929529, 0),
  ZonePoint(52.5375088138491, 13.2050986712073, 0),
  ZonePoint(52.537552991093, 13.2049344919969, 0)
}
zKI.OriginalPoint = ZonePoint(52.5374789490183, 13.2049743707395, 0)
zKI.DistanceRangeUOM = "Feet"
zKI.ProximityRangeUOM = "Meters"
zKI.OutOfRangeName = ""
zKI.InRangeName = ""
zCT = Wherigo.Zone(KlausKlabuster)
zCT.Id = "3318ce5b-4e7e-49b8-a358-262fe032fc87"
zCT.Name = "Casinotoilette"
zCT.Description = "Luxus pur. Warum eigentlich. Hier sollte sich doch keiner wohlfuehlen."
zCT.Visible = true
zCT.Media = objCasinitoilette
zCT.Icon = objicocasinotoilette
zCT.Commands = {}
zCT.DistanceRange = Distance(-1, "feet")
zCT.ShowObjects = "OnEnter"
zCT.ProximityRange = Distance(10, "meters")
zCT.AllowSetPositionTo = false
zCT.Active = false
zCT.Points = {
  ZonePoint(52.536825011312, 13.2028220892843, 0),
  ZonePoint(52.536909319234, 13.202956200081, 0),
  ZonePoint(52.5368209178264, 13.2031340651348, 0),
  ZonePoint(52.536742494873, 13.2029890694181, 0)
}
zCT.OriginalPoint = ZonePoint(52.5368244358113, 13.2029753559796, 0)
zCT.DistanceRangeUOM = "Feet"
zCT.ProximityRangeUOM = "Meters"
zCT.OutOfRangeName = ""
zCT.InRangeName = ""
zCK = Wherigo.Zone(KlausKlabuster)
zCK.Id = "db13423d-b0ba-476c-9a49-d39b88f7151c"
zCK.Name = "Kabarett"
zCK.Description = "200 Plaetze und keine Besucher - wie schlecht muss das Programm sein."
zCK.Visible = true
zCK.Media = objkabarett
zCK.Icon = objicokabarett
zCK.Commands = {}
zCK.DistanceRange = Distance(-1, "feet")
zCK.ShowObjects = "OnEnter"
zCK.ProximityRange = Distance(10, "meters")
zCK.AllowSetPositionTo = false
zCK.Active = false
zCK.Points = {
  ZonePoint(52.5370224473847, 13.2027475139278, 0),
  ZonePoint(52.5370900251345, 13.2025931548391, 0),
  ZonePoint(52.5369697306163, 13.2024633843554, 0),
  ZonePoint(52.5369186749057, 13.2026045957091, 0)
}
zCK.OriginalPoint = ZonePoint(52.5370002195103, 13.2026021622078, 0)
zCK.DistanceRangeUOM = "Feet"
zCK.ProximityRangeUOM = "Meters"
zCK.OutOfRangeName = ""
zCK.InRangeName = ""
zFC = Wherigo.Zone(KlausKlabuster)
zFC.Id = "62d5bba8-fd50-4453-9230-df04f1daf5e5"
zFC.Name = "Cache"
zFC.Description = "Du bist am Ziel. Eva wartet und das Grundbuch ist zum Greifen nah."
zFC.Visible = true
zFC.Media = objEve
zFC.Icon = objicoeve
zFC.Commands = {}
zFC.DistanceRange = Distance(-1, "feet")
zFC.ShowObjects = "OnEnter"
zFC.ProximityRange = Distance(10, "meters")
zFC.AllowSetPositionTo = false
zFC.Active = false
zFC.Points = {
  ZonePoint(52.4710747687021, 13.1169828607784, 0),
  ZonePoint(52.4710798780251, 13.1169221717001, 0),
  ZonePoint(52.4710417031091, 13.1169045777794, 0),
  ZonePoint(52.4710365937817, 13.1169797656208, 0)
}
zFC.OriginalPoint = ZonePoint(52.4710582359045, 13.1169473439697, 0)
zFC.DistanceRangeUOM = "Feet"
zFC.ProximityRangeUOM = "Meters"
zFC.OutOfRangeName = ""
zFC.InRangeName = ""
zF1 = Wherigo.Zone(KlausKlabuster)
zF1.Id = "dc813ac5-cb13-4d57-9e55-a52d05ce7eba"
zF1.Name = "vorFinal1"
zF1.Description = "Ah - der Weg zum See."
zF1.Visible = false
zF1.Commands = {}
zF1.DistanceRange = Distance(-1, "feet")
zF1.ShowObjects = "OnEnter"
zF1.ProximityRange = Distance(10, "meters")
zF1.AllowSetPositionTo = false
zF1.Active = false
zF1.Points = {
  ZonePoint(52.4714140857029, 13.1231348944483, 0),
  ZonePoint(52.4710586604457, 13.1172883123982, 0),
  ZonePoint(52.4713777244331, 13.1175097018044, 0),
  ZonePoint(52.4720845454167, 13.1226861226536, 0)
}
zF1.OriginalPoint = ZonePoint(52.4714837539996, 13.1201547578261, 0)
zF1.DistanceRangeUOM = "Feet"
zF1.ProximityRangeUOM = "Meters"
zF1.OutOfRangeName = ""
zF1.InRangeName = ""
objEva = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zHW})
objEva.Id = "1af2b45f-2999-476a-ba3e-5fb245fa1771"
objEva.Name = "Eva"
objEva.Description = "Da ist sie - die Frau Deiner Traeume. Das zauberhafte Wesen, dass Du nur schemenhaft durch die Glastuer erkennen konntest."
objEva.Visible = false
objEva.Media = objEve
objEva.Icon = objicoeve
objEva.Commands = {
  cmdanreden = Wherigo.ZCommand({
    Text = "anreden ",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
objEva.Commands.cmdanreden.Custom = true
objEva.Commands.cmdanreden.Id = "c71f36c6-aff0-4868-94cf-4bb5f556e3fc"
objEva.Commands.cmdanreden.WorksWithAll = true
objEva.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objEva.Gender = "Female"
objEva.Type = "NPC"
objBartender1 = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zBI})
objBartender1.Id = "9031ebb3-4f1a-472f-aad5-f643c29e5274"
objBartender1.Name = "Bartender"
objBartender1.Description = "Bart Enders. Mr. Magic Fingers. Der Koenig der Copacabana mit dem magischen Shake."
objBartender1.Visible = true
objBartender1.Media = objBartender
objBartender1.Icon = objicobartender
objBartender1.Commands = {
  cmdbestellen = Wherigo.ZCommand({
    Text = "bestellen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdreden = Wherigo.ZCommand({
    Text = "reden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objBartender1.Commands.cmdbestellen.Custom = true
objBartender1.Commands.cmdbestellen.Id = "b76175c5-6480-43be-8a77-d8d6ba738f24"
objBartender1.Commands.cmdbestellen.WorksWithAll = true
objBartender1.Commands.cmdreden.Custom = true
objBartender1.Commands.cmdreden.Id = "7fe5849a-074d-49bb-a487-aca8361b31f2"
objBartender1.Commands.cmdreden.WorksWithAll = true
objBartender1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBartender1.Gender = "Male"
objBartender1.Type = "NPC"
objBetrunkene = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zBF})
objBetrunkene.Id = "93bed8be-3ad3-4561-a8df-dca39cfdcd97"
objBetrunkene.Name = "Betrunkene"
objBetrunkene.Description = "Warum nur, muessen es einige immer uebertreiben und kennen ihre Grenzen nicht. Und morgen gibt es 1000 klicks auf Instagram."
objBetrunkene.Visible = true
objBetrunkene.Media = objfraubetrunken
objBetrunkene.Icon = objicofraubetrunken
objBetrunkene.Commands = {
  cmdAnquatschen = Wherigo.ZCommand({
    Text = "Anquatschen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objBetrunkene.Commands.cmdAnquatschen.Custom = true
objBetrunkene.Commands.cmdAnquatschen.Id = "cf407f62-cb10-4d87-bf48-6c9fe7e76ab9"
objBetrunkene.Commands.cmdAnquatschen.WorksWithAll = true
objBetrunkene.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBetrunkene.Gender = "Female"
objBetrunkene.Type = "NPC"
objBlondine = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zBI})
objBlondine.Id = "8aec9cae-8d8f-402d-a33b-4f39abd04244"
objBlondine.Name = "Blondine"
objBlondine.Description = "Ein blonder Engel. Umschwirrt von Maennern wie Motten um ein Licht."
objBlondine.Visible = true
objBlondine.Media = objbarfrau
objBlondine.Icon = objicobarfrau
objBlondine.Commands = {
  cmdanquatschenundflirten = Wherigo.ZCommand({
    Text = "anquatschen und flirten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdzumTanzenauffordern = Wherigo.ZCommand({
    Text = "zum Tanzen auffordern",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objBlondine.Commands.cmdanquatschenundflirten.Custom = true
objBlondine.Commands.cmdanquatschenundflirten.Id = "f8da54ff-157b-4927-a942-66b39c6b2596"
objBlondine.Commands.cmdanquatschenundflirten.WorksWithAll = true
objBlondine.Commands.cmdzumTanzenauffordern.Custom = true
objBlondine.Commands.cmdzumTanzenauffordern.Id = "47639b5b-e941-4fa8-a065-25a812946f87"
objBlondine.Commands.cmdzumTanzenauffordern.WorksWithAll = true
objBlondine.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBlondine.Gender = "Female"
objBlondine.Type = "NPC"
objMonique = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zBZ})
objMonique.Id = "575e9d91-729b-4367-899f-6f898b7a8db6"
objMonique.Name = "Monique"
objMonique.Description = [[
Monique? Stand zumindest unter dem Bild an der Bar.<BR>
Egal, Namen sind Schall und Rauch.]]
objMonique.Visible = true
objMonique.Media = objHure
objMonique.Icon = objicohure
objMonique.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdxxx = Wherigo.ZCommand({
    Text = "xxx",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objMonique.Commands.cmdansprechen.Custom = true
objMonique.Commands.cmdansprechen.Id = "2e04a5dc-3454-48e9-93ad-ae704029ea9b"
objMonique.Commands.cmdansprechen.WorksWithAll = true
objMonique.Commands.cmdxxx.Custom = true
objMonique.Commands.cmdxxx.Id = "7f56f95a-733a-4a5c-80ad-a7eb4935bfc7"
objMonique.Commands.cmdxxx.WorksWithAll = true
objMonique.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMonique.Gender = "Female"
objMonique.Type = "NPC"
Landstreicher = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zLA})
Landstreicher.Id = "789fc871-a51b-4a78-a0ff-48b7d58e9048"
Landstreicher.Name = "Landstreicher"
Landstreicher.Description = "Conny Kulant, Landstreicher mit Poesie und Musik"
Landstreicher.Visible = false
Landstreicher.Media = objLandstreicher
Landstreicher.Icon = objicoLandstreicher
Landstreicher.Commands = {
  cmdInfo = Wherigo.ZCommand({
    Text = "Info",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
Landstreicher.Commands.cmdInfo.Custom = true
Landstreicher.Commands.cmdInfo.Id = "b7ebd139-cbe0-461a-97aa-cc1fb7340ffe"
Landstreicher.Commands.cmdInfo.WorksWithAll = true
Landstreicher.Commands.cmdansprechen.Custom = true
Landstreicher.Commands.cmdansprechen.Id = "ccdf368e-cea1-49f1-b9ce-5d2cfa62dac4"
Landstreicher.Commands.cmdansprechen.WorksWithAll = true
Landstreicher.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Landstreicher.Gender = "Male"
Landstreicher.Type = "NPC"
Landwirt = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zCA})
Landwirt.Id = "19b0cbe5-6995-4e8f-8243-f4a98c967fcf"
Landwirt.Name = "Landwirt"
Landwirt.Description = "Hein Luehs, Obstbauer aus dem Alten Land vom Herzapfelhof"
Landwirt.Visible = false
Landwirt.Media = objLandwirt
Landwirt.Icon = objicoLandwirt
Landwirt.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
Landwirt.Commands.cmdansprechen.Custom = true
Landwirt.Commands.cmdansprechen.Id = "576aa266-a820-4f6d-8ce6-4d84135278d5"
Landwirt.Commands.cmdansprechen.WorksWithAll = true
Landwirt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Landwirt.Gender = "Male"
Landwirt.Type = "NPC"
objKauffrau = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zLI})
objKauffrau.Id = "3f98e97e-debd-4370-babf-37b57057dc49"
objKauffrau.Name = "Kauffrau"
objKauffrau.Description = "Frau Manz - sie liebt hoffentlich nicht nur Lebensmittel, sondern auch das Leben."
objKauffrau.Visible = true
objKauffrau.Media = objVerkaeuferin
objKauffrau.Icon = objicoVerkaeuferin
objKauffrau.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objKauffrau.Commands.cmdansprechen.Custom = true
objKauffrau.Commands.cmdansprechen.Id = "d049b651-1cc8-4669-b0f7-d9167955ae61"
objKauffrau.Commands.cmdansprechen.WorksWithAll = true
objKauffrau.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKauffrau.Gender = "Female"
objKauffrau.Type = "NPC"
objTuersteher = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zDA})
objTuersteher.Id = "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a"
objTuersteher.Name = "Tuersteher"
objTuersteher.Description = "Das ist zwar nicht das Berghain - aber irgendwie kommt Dir der Tuersteher bekannt vor. Aber ob Sven Marquardt einen Zwillingsbruder hat? Wer weiss das schon."
objTuersteher.Visible = true
objTuersteher.Media = objTursteherDisco
objTuersteher.Icon = objicoTursteherdisco
objTuersteher.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objTuersteher.Commands.cmdansprechen.Custom = true
objTuersteher.Commands.cmdansprechen.Id = "86a1cec1-1cda-48e7-915a-e6b50e523a3f"
objTuersteher.Commands.cmdansprechen.WorksWithAll = true
objTuersteher.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTuersteher.Gender = "Male"
objTuersteher.Type = "NPC"
objEmpfangsdame1 = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zHL})
objEmpfangsdame1.Id = "cdd93f24-52b3-4157-9c19-7200c2c3082e"
objEmpfangsdame1.Name = "Empfangsdame"
objEmpfangsdame1.Description = "\"Maren Glitzer\" kannst Du gerade noch lesen, bevor Dich die blauen Augen ablenken. "
objEmpfangsdame1.Visible = true
objEmpfangsdame1.Media = objEmpfangsdame
objEmpfangsdame1.Icon = objicoEmpfangsdame
objEmpfangsdame1.Commands = {
  cmdreden = Wherigo.ZCommand({
    Text = "reden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objEmpfangsdame1.Commands.cmdreden.Custom = true
objEmpfangsdame1.Commands.cmdreden.Id = "2eaa1dde-ce47-4833-8a09-353eda72042e"
objEmpfangsdame1.Commands.cmdreden.WorksWithAll = true
objEmpfangsdame1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objEmpfangsdame1.Gender = "Female"
objEmpfangsdame1.Type = "NPC"
objFawn1 = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zDI})
objFawn1.Id = "6dc780fa-998d-4830-ac4a-93e6c74cc103"
objFawn1.Name = "Fawn"
objFawn1.Description = "Ein Traum steht vor Dir - und zwinkert Dir zu."
objFawn1.Visible = true
objFawn1.Media = objFawn
objFawn1.Icon = objicoFawn
objFawn1.Commands = {
  cmdtanzen = Wherigo.ZCommand({
    Text = "tanzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  cmdanreden = Wherigo.ZCommand({
    Text = "anreden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdkuessen = Wherigo.ZCommand({
    Text = "kuessen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objFawn1.Commands.cmdtanzen.Custom = true
objFawn1.Commands.cmdtanzen.Id = "af4ca67a-08f5-4ff5-9fff-24b232e18e2c"
objFawn1.Commands.cmdtanzen.WorksWithAll = true
objFawn1.Commands.cmdanreden.Custom = true
objFawn1.Commands.cmdanreden.Id = "adb25a74-1718-45af-a5de-1df1c12f638b"
objFawn1.Commands.cmdanreden.WorksWithAll = true
objFawn1.Commands.cmdkuessen.Custom = true
objFawn1.Commands.cmdkuessen.Id = "e3add70d-1d09-41a9-8621-bd4d1a390934"
objFawn1.Commands.cmdkuessen.WorksWithAll = true
objFawn1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFawn1.Gender = "Female"
objFawn1.Type = "NPC"
objSchlaeger = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zHG})
objSchlaeger.Id = "68b76555-6ccc-49f6-8155-50f36394e13a"
objSchlaeger.Name = "Schlaeger"
objSchlaeger.Description = [[
Dunkle Ecken, dunkle Typen. Was ist nun mit der inneren Sicherheit? Ich seh wohl schwarz.<BR>
Ich sollte hier wohl schleunigst raus!]]
objSchlaeger.Visible = true
objSchlaeger.Media = objSchlager
objSchlaeger.Icon = objicoSchlager
objSchlaeger.Commands = {}
objSchlaeger.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSchlaeger.Gender = "Male"
objSchlaeger.Type = "NPC"
objCroupier1 = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zCI})
objCroupier1.Id = "f99cb935-2ed7-49e6-b619-b64b6bac6855"
objCroupier1.Name = "Croupier"
objCroupier1.Description = [[
Eine adrette Bruenette, die Dir verfuehrerisch mit den Karten winkt?<BR>
Ob sie Dir auch die Karten legt?]]
objCroupier1.Visible = true
objCroupier1.Media = objCroupier
objCroupier1.Icon = objicocroupier
objCroupier1.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objCroupier1.Commands.cmdansprechen.Custom = true
objCroupier1.Commands.cmdansprechen.Id = "38f8f7b2-bac2-4079-bcb6-96e1bb94536e"
objCroupier1.Commands.cmdansprechen.WorksWithAll = true
objCroupier1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objCroupier1.Gender = "Female"
objCroupier1.Type = "NPC"
Zigarettengirl = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zCI})
Zigarettengirl.Id = "6683526d-d18a-4e40-8859-feac4cb5d309"
Zigarettengirl.Name = "Zigarettengirl"
Zigarettengirl.Description = "Rauchen ist ja schaedlich, aber so huebsch verpackt. Wer kann da widerstehen?"
Zigarettengirl.Visible = true
Zigarettengirl.Media = objZigarettengirl
Zigarettengirl.Icon = objicozigarettengirl
Zigarettengirl.Commands = {
  cmdreden = Wherigo.ZCommand({
    Text = "reden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdZigarettenkaufen = Wherigo.ZCommand({
    Text = "Zigaretten kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
Zigarettengirl.Commands.cmdreden.Custom = true
Zigarettengirl.Commands.cmdreden.Id = "8bc8bf17-7c5c-4781-bdc5-835e032ed492"
Zigarettengirl.Commands.cmdreden.WorksWithAll = true
Zigarettengirl.Commands.cmdZigarettenkaufen.Custom = true
Zigarettengirl.Commands.cmdZigarettenkaufen.Id = "16dd6503-927d-4bed-a2dd-b925966ea83d"
Zigarettengirl.Commands.cmdZigarettenkaufen.WorksWithAll = true
Zigarettengirl.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Zigarettengirl.Gender = "Female"
Zigarettengirl.Type = "NPC"
objPriester1 = Wherigo.ZCharacter({Cartridge = KlausKlabuster, Container = zKI})
objPriester1.Id = "4126aff1-6945-4978-9817-82907db9dce5"
objPriester1.Name = "Priester"
objPriester1.Description = "Och noe - Don Promillo, der Austauschpastor aus Uzgetuetsk."
objPriester1.Visible = true
objPriester1.Media = objPriester
objPriester1.Icon = objicoPriester
objPriester1.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdheiraten = Wherigo.ZCommand({
    Text = "heiraten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objPriester1.Commands.cmdansprechen.Custom = true
objPriester1.Commands.cmdansprechen.Id = "c8845c10-4a25-4ebc-a877-4d9c563b594f"
objPriester1.Commands.cmdansprechen.WorksWithAll = true
objPriester1.Commands.cmdheiraten.Custom = true
objPriester1.Commands.cmdheiraten.Id = "67900fa5-c06e-45df-8c33-fb8b72fe18b6"
objPriester1.Commands.cmdheiraten.WorksWithAll = true
objPriester1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPriester1.Gender = "Male"
objPriester1.Type = "NPC"
Polizist = Wherigo.ZCharacter(KlausKlabuster)
Polizist.Id = "2119a664-659c-4a01-873b-850e80835465"
Polizist.Name = "Polizist"
Polizist.Description = [[
Heinz Hilmer. Der schwarze Sheriff von Spandau.<BR>
Der Mann, der schneller spricht als sein Schatten.]]
Polizist.Visible = false
Polizist.Media = objPolizist
Polizist.Icon = objicoPolizist
Polizist.Commands = {
  cmdansprechen = Wherigo.ZCommand({
    Text = "ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
Polizist.Commands.cmdansprechen.Custom = true
Polizist.Commands.cmdansprechen.Id = "fe36bac1-0ca0-439d-85b3-c4435fe28fe9"
Polizist.Commands.cmdansprechen.WorksWithAll = true
Polizist.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Polizist.Gender = "Male"
Polizist.Type = "NPC"
objHund1 = Wherigo.ZCharacter(KlausKlabuster)
objHund1.Id = "3c04bbe7-bf3e-4fc3-adb5-2436b340dc40"
objHund1.Name = "Hund"
objHund1.Description = [[
Ein kleiner suesser Mischlingshund mit hoffentlich guten Manieren.<BR>
Und einem treuherzigen Blick.]]
objHund1.Visible = true
objHund1.Media = objHund
objHund1.Icon = objicohundsitzend
objHund1.Commands = {}
objHund1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHund1.Gender = "Male"
objHund1.Type = "NPC"
objRose1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBF})
objRose1.Id = "389a907b-cf56-4624-bee7-7d45b902c9de"
objRose1.Name = "Rose"
objRose1.Description = "Okay, eine Bakkarat-Rose ist es nicht, aber viel zu schade fur diese verbluhte Tulpe am Boden."
objRose1.Visible = true
objRose1.Media = objRose
objRose1.Icon = objicoRose
objRose1.Commands = {
  cmdaufheben = Wherigo.ZCommand({
    Text = "aufheben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdRosegeben = Wherigo.ZCommand({
    Text = "Rose geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier die Rose geben?"
  }),
  cmdRosewegwerfen = Wherigo.ZCommand({
    Text = "Rose wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objRose1.Commands.cmdaufheben.Custom = true
objRose1.Commands.cmdaufheben.Id = "c98d8af8-2aa8-4d99-b276-53985b6161f4"
objRose1.Commands.cmdaufheben.WorksWithAll = true
objRose1.Commands.cmdRosegeben.Custom = true
objRose1.Commands.cmdRosegeben.Id = "64f3ed0a-0d3e-4dec-928e-03801dcedfc5"
objRose1.Commands.cmdRosegeben.WorksWithAll = false
objRose1.Commands.cmdRosegeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objRose1.Commands.cmdRosewegwerfen.Custom = true
objRose1.Commands.cmdRosewegwerfen.Id = "dc506acd-3b3b-4f3b-9cba-b4a6278aa660"
objRose1.Commands.cmdRosewegwerfen.WorksWithAll = false
objRose1.Commands.cmdRosewegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "51a5c622-7caa-4bf1-b461-6d46d259320d"
}
objRose1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objRose1.Locked = false
objRose1.Opened = false
Whiskey = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
Whiskey.Id = "366e2d40-9e05-4d5a-8ec4-75224bcbecc5"
Whiskey.Name = "Whiskey"
Whiskey.Description = [[
Glendronagh - 15 Jahre.<BR>
Steht zumindest auf der Flasche.]]
Whiskey.Visible = true
Whiskey.Media = objWhiskey
Whiskey.Icon = objicowhiskey
Whiskey.Commands = {
  cmdWhiskeybestellen = Wherigo.ZCommand({
    Text = "Whiskey bestellen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Bei wem willst Du hier bestellen?"
  })
}
Whiskey.Commands.cmdWhiskeybestellen.Custom = true
Whiskey.Commands.cmdWhiskeybestellen.Id = "3d720814-036e-4217-955c-38bfaf842321"
Whiskey.Commands.cmdWhiskeybestellen.WorksWithAll = false
Whiskey.Commands.cmdWhiskeybestellen.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855"
}
Whiskey.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Whiskey.Locked = false
Whiskey.Opened = false
objFernbedienung1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = objBetrunkene})
objFernbedienung1.Id = "df4bb573-a913-4a02-a77d-ced9bcce926e"
objFernbedienung1.Name = "Fernbedienung"
objFernbedienung1.Description = "Und wo ist der Fernseher dazu?"
objFernbedienung1.Visible = true
objFernbedienung1.Media = objFernbedienung
objFernbedienung1.Icon = objicofernbedienung
objFernbedienung1.Commands = {
  cmdFernbedienunggeben = Wherigo.ZCommand({
    Text = "Fernbedienung geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du hier eine Fernbedienung geben?"
  }),
  cmdFernbedienungwegwerfen = Wherigo.ZCommand({
    Text = "Fernbedienung wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objFernbedienung1.Commands.cmdFernbedienunggeben.Custom = true
objFernbedienung1.Commands.cmdFernbedienunggeben.Id = "77b2f6f3-aa5d-4636-89a6-19328dd945b9"
objFernbedienung1.Commands.cmdFernbedienunggeben.WorksWithAll = false
objFernbedienung1.Commands.cmdFernbedienunggeben.WorksWithListIds = {
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objFernbedienung1.Commands.cmdFernbedienungwegwerfen.Custom = true
objFernbedienung1.Commands.cmdFernbedienungwegwerfen.Id = "08c0b204-5a6f-498e-babf-8544381e9ffa"
objFernbedienung1.Commands.cmdFernbedienungwegwerfen.WorksWithAll = false
objFernbedienung1.Commands.cmdFernbedienungwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objFernbedienung1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFernbedienung1.Locked = false
objFernbedienung1.Opened = false
objPralinen1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBZ})
objPralinen1.Id = "e7ec6435-9325-4d91-96b8-5cc3059b69fd"
objPralinen1.Name = "Pralinen"
objPralinen1.Description = "Belgische Schokolade aus Bruessel. Zarter Schmelz, der auf der Zunge vergeht."
objPralinen1.Visible = true
objPralinen1.Media = objPralinen
objPralinen1.Icon = objicopralinen
objPralinen1.Commands = {
  cmdeinstecken = Wherigo.ZCommand({
    Text = "einstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdessen = Wherigo.ZCommand({
    Text = "essen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdPralinengeben = Wherigo.ZCommand({
    Text = "Pralinen geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier die Pralinen geben?"
  }),
  cmdPralinenwegwerfen = Wherigo.ZCommand({
    Text = "Pralinen wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objPralinen1.Commands.cmdeinstecken.Custom = true
objPralinen1.Commands.cmdeinstecken.Id = "36fa9155-1cdd-4270-ba4b-875fe166dfea"
objPralinen1.Commands.cmdeinstecken.WorksWithAll = true
objPralinen1.Commands.cmdessen.Custom = true
objPralinen1.Commands.cmdessen.Id = "26608e7d-bb28-4f59-859c-4ee860cad85d"
objPralinen1.Commands.cmdessen.WorksWithAll = true
objPralinen1.Commands.cmdPralinengeben.Custom = true
objPralinen1.Commands.cmdPralinengeben.Id = "09fffe30-1312-4a51-bdaa-ca48fbfd8069"
objPralinen1.Commands.cmdPralinengeben.WorksWithAll = false
objPralinen1.Commands.cmdPralinengeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "2119a664-659c-4a01-873b-850e80835465",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objPralinen1.Commands.cmdPralinenwegwerfen.Custom = true
objPralinen1.Commands.cmdPralinenwegwerfen.Id = "3e42e2c3-d6e6-43e1-aa9b-f7f82f001501"
objPralinen1.Commands.cmdPralinenwegwerfen.WorksWithAll = false
objPralinen1.Commands.cmdPralinenwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objPralinen1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPralinen1.Locked = false
objPralinen1.Opened = false
objKondome = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zLI})
objKondome.Id = "48bfeb4e-8154-4b0f-9827-e67759519aa0"
objKondome.Name = "Kondome"
objKondome.Description = ""
objKondome.Visible = true
objKondome.Media = objKondom
objKondome.Icon = objicokondom
objKondome.Commands = {
  cmdkaufen = Wherigo.ZCommand({
    Text = "kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdbenutzen = Wherigo.ZCommand({
    Text = "benutzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdeinstecken = Wherigo.ZCommand({
    Text = "einstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdKondomegeben = Wherigo.ZCommand({
    Text = "Kondome geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier die Kondome geben?"
  }),
  cmdKondomewegwerfen = Wherigo.ZCommand({
    Text = "Kondome wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objKondome.Commands.cmdkaufen.Custom = true
objKondome.Commands.cmdkaufen.Id = "20a3a131-0b9f-4b6b-b80a-f75b8e2764bd"
objKondome.Commands.cmdkaufen.WorksWithAll = true
objKondome.Commands.cmdbenutzen.Custom = true
objKondome.Commands.cmdbenutzen.Id = "429d0eec-3dba-4b02-b7d8-85180debd9a4"
objKondome.Commands.cmdbenutzen.WorksWithAll = true
objKondome.Commands.cmdeinstecken.Custom = true
objKondome.Commands.cmdeinstecken.Id = "aff309ff-8604-4037-8cc1-239aaa466e11"
objKondome.Commands.cmdeinstecken.WorksWithAll = true
objKondome.Commands.cmdKondomegeben.Custom = true
objKondome.Commands.cmdKondomegeben.Id = "cd95712a-6ee8-40ea-a447-5e736dcc23a2"
objKondome.Commands.cmdKondomegeben.WorksWithAll = false
objKondome.Commands.cmdKondomegeben.WorksWithListIds = {
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a"
}
objKondome.Commands.cmdKondomewegwerfen.Custom = true
objKondome.Commands.cmdKondomewegwerfen.Id = "3ae13ab5-4eaa-4e64-9c3d-14957358b055"
objKondome.Commands.cmdKondomewegwerfen.WorksWithAll = false
objKondome.Commands.cmdKondomewegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objKondome.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKondome.Locked = false
objKondome.Opened = false
objApfel1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Landwirt})
objApfel1.Id = "036b0ea1-b7e8-4723-b600-e1f676848867"
objApfel1.Name = "Apfel"
objApfel1.Description = "An apple a day keeps the doctor away - oder hast Du Angst vor der Hexe?"
objApfel1.Visible = true
objApfel1.Media = objApfel
objApfel1.Icon = objicoapfel
objApfel1.Commands = {
  cmdessen = Wherigo.ZCommand({
    Text = "essen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdApfelgeben = Wherigo.ZCommand({
    Text = "Apfel geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du hier einen Apfel geben?"
  }),
  cmdApfelwegwerfen = Wherigo.ZCommand({
    Text = "Apfel wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objApfel1.Commands.cmdessen.Custom = true
objApfel1.Commands.cmdessen.Id = "dd135c66-5714-4b6c-b50c-ce836e6782cd"
objApfel1.Commands.cmdessen.WorksWithAll = true
objApfel1.Commands.cmdApfelgeben.Custom = true
objApfel1.Commands.cmdApfelgeben.Id = "479dc380-71c2-4ce0-81cd-13a637c1735f"
objApfel1.Commands.cmdApfelgeben.WorksWithAll = false
objApfel1.Commands.cmdApfelgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objApfel1.Commands.cmdApfelwegwerfen.Custom = true
objApfel1.Commands.cmdApfelwegwerfen.Id = "037bac35-d8f0-47b5-ba57-798eee042ebe"
objApfel1.Commands.cmdApfelwegwerfen.WorksWithAll = false
objApfel1.Commands.cmdApfelwegwerfen.WorksWithListIds = {
  "df5fb910-88b4-452c-ae56-49f90195fd5a",
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objApfel1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objApfel1.Locked = false
objApfel1.Opened = false
objHammer1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHG})
objHammer1.Id = "9e1c8169-fdc9-48d8-a480-cccda391b597"
objHammer1.Name = "Hammer"
objHammer1.Description = [[
Ein fast neuer Hammer, handlich, 2 kg.<BR>
Halt? Oh - Dein Hammer. Wo kommt der denn her?]]
objHammer1.Visible = true
objHammer1.Media = objHammer
objHammer1.Icon = objicohammer
objHammer1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdHammergeben = Wherigo.ZCommand({
    Text = "Hammer geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier einen Hammer geben?"
  }),
  cmdHammerwegwerfen = Wherigo.ZCommand({
    Text = "Hammer wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHammer1.Commands.cmdnehmen.Custom = true
objHammer1.Commands.cmdnehmen.Id = "3df9b092-c199-41d5-b361-bb752e98c1c8"
objHammer1.Commands.cmdnehmen.WorksWithAll = true
objHammer1.Commands.cmdHammergeben.Custom = true
objHammer1.Commands.cmdHammergeben.Id = "cf0dc449-493d-49c7-98d8-98e8c8d354a6"
objHammer1.Commands.cmdHammergeben.WorksWithAll = false
objHammer1.Commands.cmdHammergeben.WorksWithListIds = {
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274"
}
objHammer1.Commands.cmdHammerwegwerfen.Custom = true
objHammer1.Commands.cmdHammerwegwerfen.Id = "71dfbb2a-ef73-4d9d-9044-e14ddb9e1902"
objHammer1.Commands.cmdHammerwegwerfen.WorksWithAll = false
objHammer1.Commands.cmdHammerwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objHammer1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHammer1.Locked = false
objHammer1.Opened = false
objAtemspray1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objAtemspray1.Id = "7e9d54dc-3520-4bba-a7f8-6f45a6a7d54e"
objAtemspray1.Name = "Atemspray"
objAtemspray1.Description = "Schlechter Atem, schlechter Geruch - ein Zisch und es geht wieder."
objAtemspray1.Visible = true
objAtemspray1.Media = objAtemspray
objAtemspray1.Icon = objicoatemspray
objAtemspray1.Commands = {
  cmdbenutzen = Wherigo.ZCommand({
    Text = "benutzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdSpraygeben = Wherigo.ZCommand({
    Text = "Spray geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du denn das Atemspray geben?"
  }),
  cmdSpraywegwerfen = Wherigo.ZCommand({
    Text = "Spray wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objAtemspray1.Commands.cmdbenutzen.Custom = true
objAtemspray1.Commands.cmdbenutzen.Id = "3ea3572e-e4a6-4e9e-a5bc-f327c9f4a1d7"
objAtemspray1.Commands.cmdbenutzen.WorksWithAll = true
objAtemspray1.Commands.cmdSpraygeben.Custom = true
objAtemspray1.Commands.cmdSpraygeben.Id = "b891bd51-00ce-42ec-b355-e25ec0f49e74"
objAtemspray1.Commands.cmdSpraygeben.WorksWithAll = false
objAtemspray1.Commands.cmdSpraygeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048"
}
objAtemspray1.Commands.cmdSpraywegwerfen.Custom = true
objAtemspray1.Commands.cmdSpraywegwerfen.Id = "cb73b06b-9e60-4900-b540-46518c58ca38"
objAtemspray1.Commands.cmdSpraywegwerfen.WorksWithAll = false
objAtemspray1.Commands.cmdSpraywegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objAtemspray1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAtemspray1.Locked = false
objAtemspray1.Opened = false
objTaschentuch1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objTaschentuch1.Id = "15d6090a-57a8-4853-afdb-ef2e647a7f99"
objTaschentuch1.Name = "Taschentuch"
objTaschentuch1.Description = [[
Ein Ueberbleibsel aus Deiner Bundeswehrzeit.<BR>
Haesslich, aber gross genug, um anderes Haessliches zu verdecken.]]
objTaschentuch1.Visible = true
objTaschentuch1.Media = objTaschentuch
objTaschentuch1.Icon = objicotaschentuch
objTaschentuch1.Commands = {
  cmdTaschentuchgeben = Wherigo.ZCommand({
    Text = "Taschentuch geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du das Taschentuch geben?"
  }),
  cmdTaschentuchwegwerfen = Wherigo.ZCommand({
    Text = "Taschentuch wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objTaschentuch1.Commands.cmdTaschentuchgeben.Custom = true
objTaschentuch1.Commands.cmdTaschentuchgeben.Id = "f682d91f-fb49-4e3b-8666-fff4960ad1a9"
objTaschentuch1.Commands.cmdTaschentuchgeben.WorksWithAll = false
objTaschentuch1.Commands.cmdTaschentuchgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objTaschentuch1.Commands.cmdTaschentuchwegwerfen.Custom = true
objTaschentuch1.Commands.cmdTaschentuchwegwerfen.Id = "4d40719b-cc62-4980-8467-59880f2ee069"
objTaschentuch1.Commands.cmdTaschentuchwegwerfen.WorksWithAll = false
objTaschentuch1.Commands.cmdTaschentuchwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objTaschentuch1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTaschentuch1.Locked = false
objTaschentuch1.Opened = false
objArmbanduhr = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objArmbanduhr.Id = "9c637627-fb42-4715-a5bd-d1f1f400f983"
objArmbanduhr.Name = "Armbanduhr"
objArmbanduhr.Description = [[
Na ja, nicht ganz passend fuer einen Mann von Welt, aber es sind Erinnerungen an die Jugend.<BR>
Aber hoppla - wieso wackelt der Zeiger?]]
objArmbanduhr.Visible = true
objArmbanduhr.Media = objarmbanduhr
objArmbanduhr.Icon = objicoarmbanduhr
objArmbanduhr.Commands = {
  cmdUhrzeitablesen = Wherigo.ZCommand({
    Text = "Uhrzeit ablesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdUhrgeben = Wherigo.ZCommand({
    Text = "Uhr geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du die Armbanduhr geben?"
  }),
  cmdUhrwegwerfen = Wherigo.ZCommand({
    Text = "Uhr wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objArmbanduhr.Commands.cmdUhrzeitablesen.Custom = true
objArmbanduhr.Commands.cmdUhrzeitablesen.Id = "ea9afeda-dcff-442a-9356-7c30d44cca0f"
objArmbanduhr.Commands.cmdUhrzeitablesen.WorksWithAll = true
objArmbanduhr.Commands.cmdUhrgeben.Custom = true
objArmbanduhr.Commands.cmdUhrgeben.Id = "355aa2a4-81e6-4ac5-8735-4f13ca1b7e42"
objArmbanduhr.Commands.cmdUhrgeben.WorksWithAll = false
objArmbanduhr.Commands.cmdUhrgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objArmbanduhr.Commands.cmdUhrwegwerfen.Custom = true
objArmbanduhr.Commands.cmdUhrwegwerfen.Id = "aa74063c-c321-49f1-b136-606809237cd1"
objArmbanduhr.Commands.cmdUhrwegwerfen.WorksWithAll = false
objArmbanduhr.Commands.cmdUhrwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objArmbanduhr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objArmbanduhr.Locked = false
objArmbanduhr.Opened = false
objMusikbox1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
objMusikbox1.Id = "1ce4bd48-9317-4696-8a8c-9c978a1dad03"
objMusikbox1.Name = "Musikbox"
objMusikbox1.Description = "Ein Wurlitzer 1968 - der Klassiker unter den Jukeboxes."
objMusikbox1.Visible = true
objMusikbox1.Media = objMusikbox
objMusikbox1.Icon = objicomusikbox
objMusikbox1.Commands = {
  cmdMusikabspielen = Wherigo.ZCommand({
    Text = "Musik abspielen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objMusikbox1.Commands.cmdMusikabspielen.Custom = true
objMusikbox1.Commands.cmdMusikabspielen.Id = "62834c25-1aab-4664-916e-d2928e88fc34"
objMusikbox1.Commands.cmdMusikabspielen.WorksWithAll = true
objMusikbox1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMusikbox1.Locked = false
objMusikbox1.Opened = true
Bier = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
Bier.Id = "b31d1c3b-0c93-4c2b-b6d7-1b07f9841806"
Bier.Name = "Bier"
Bier.Description = "Frisch gebrautes Spandauer Brauhaus-Bier."
Bier.Visible = true
Bier.Media = objBierglass
Bier.Icon = objicoBier
Bier.Commands = {
  cmdBierbestellen = Wherigo.ZCommand({
    Text = "Bier bestellen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "bei wem willst Du hier bestellen?"
  })
}
Bier.Commands.cmdBierbestellen.Custom = true
Bier.Commands.cmdBierbestellen.Id = "fbbde91f-c5c2-4391-ba7d-ee6d30403c9b"
Bier.Commands.cmdBierbestellen.WorksWithAll = false
Bier.Commands.cmdBierbestellen.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855"
}
Bier.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Bier.Locked = false
Bier.Opened = false
Wein = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
Wein.Id = "4c3de570-9dd5-4bfd-bee6-b579a50b5948"
Wein.Name = "Wein"
Wein.Description = "Baeujolais primeur. Suedlage - steht zumindest auf der Flasche"
Wein.Visible = true
Wein.Media = objWeinglass
Wein.Icon = objicoweinglas
Wein.Commands = {
  cmdWeinbestellen = Wherigo.ZCommand({
    Text = "Wein bestellen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Bei wem willst Du hier bestellen?"
  })
}
Wein.Commands.cmdWeinbestellen.Custom = true
Wein.Commands.cmdWeinbestellen.Id = "351aa31c-64a8-4e2d-a188-30f6a7857377"
Wein.Commands.cmdWeinbestellen.WorksWithAll = false
Wein.Commands.cmdWeinbestellen.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855"
}
Wein.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Wein.Locked = false
Wein.Opened = false
objFernseher = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBT})
objFernseher.Id = "6e653985-fe0a-4847-b86d-4bcff6b97b38"
objFernseher.Name = "Fernseher"
objFernseher.Description = "Das High-End-Modell der letzten IFA"
objFernseher.Visible = true
objFernseher.Media = objfernseheraus
objFernseher.Icon = objicofernseheraus
objFernseher.Commands = {
  cmdeinschalten = Wherigo.ZCommand({
    Text = "einschalten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdausschalten = Wherigo.ZCommand({
    Text = "ausschalten",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdSenderwechseln = Wherigo.ZCommand({
    Text = "Sender wechseln",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objFernseher.Commands.cmdeinschalten.Custom = true
objFernseher.Commands.cmdeinschalten.Id = "28a946e7-5a6a-4a6e-8102-6197712e3216"
objFernseher.Commands.cmdeinschalten.WorksWithAll = true
objFernseher.Commands.cmdausschalten.Custom = true
objFernseher.Commands.cmdausschalten.Id = "a45f1fa0-514c-4659-99cd-3d37164fa3ad"
objFernseher.Commands.cmdausschalten.WorksWithAll = true
objFernseher.Commands.cmdSenderwechseln.Custom = true
objFernseher.Commands.cmdSenderwechseln.Id = "f749e54d-1d12-43ce-b6f7-db1dbba28932"
objFernseher.Commands.cmdSenderwechseln.WorksWithAll = true
objFernseher.Commands.cmdansehen.Custom = true
objFernseher.Commands.cmdansehen.Id = "3ae874dd-3377-4f6c-9e6b-827d8bf46fe0"
objFernseher.Commands.cmdansehen.WorksWithAll = true
objFernseher.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFernseher.Locked = false
objFernseher.Opened = false
objTuer1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
objTuer1.Id = "59736ad1-2739-4f6d-8d64-5ab720b2df87"
objTuer1.Name = "Tuer"
objTuer1.Description = [[
Eine geschlossene Tuer? Zugang nur fuer Gentlemen/Privat?<BR>
Das klingt interessant!]]
objTuer1.Visible = true
objTuer1.Media = objTuer
objTuer1.Icon = objicoTuer
objTuer1.Commands = {
  cmdanklopfen = Wherigo.ZCommand({
    Text = "anklopfen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objTuer1.Commands.cmdanklopfen.Custom = true
objTuer1.Commands.cmdanklopfen.Id = "2a630486-4261-439c-a7a6-09357353e657"
objTuer1.Commands.cmdanklopfen.WorksWithAll = true
objTuer1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTuer1.Locked = false
objTuer1.Opened = false
objKlo = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBK})
objKlo.Id = "e1d1f671-d9d7-4e47-a9b6-34a971d55fef"
objKlo.Name = "Klo"
objKlo.Description = ""
objKlo.Visible = true
objKlo.Media = objtoilettenschussel
objKlo.Icon = objicotoiletteschussel
objKlo.Commands = {
  cmdbenutzen = Wherigo.ZCommand({
    Text = "benutzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objKlo.Commands.cmdbenutzen.Custom = true
objKlo.Commands.cmdbenutzen.Id = "a200aec4-fdcb-4ae3-94fd-a745dc2449be"
objKlo.Commands.cmdbenutzen.WorksWithAll = true
objKlo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKlo.Locked = false
objKlo.Opened = false
objWaschbecken1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBK})
objWaschbecken1.Id = "5ac89df6-f13d-4bea-a2b0-6b56f78cccfc"
objWaschbecken1.Name = "Waschbecken"
objWaschbecken1.Description = "Stylisch ist anders. Aber das Waschbecken es passt zum Ambiente und ist mit seinen Schmutzraendern authentisch."
objWaschbecken1.Visible = true
objWaschbecken1.Media = objtoilettewaschbecken
objWaschbecken1.Icon = objicotoilettewaschbecken
objWaschbecken1.Commands = {
  cmdHaendewaschen = Wherigo.ZCommand({
    Text = "Haende waschen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtrinken = Wherigo.ZCommand({
    Text = "trinken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objWaschbecken1.Commands.cmdHaendewaschen.Custom = true
objWaschbecken1.Commands.cmdHaendewaschen.Id = "419e642f-f7cc-48b1-901e-527e9b833b20"
objWaschbecken1.Commands.cmdHaendewaschen.WorksWithAll = true
objWaschbecken1.Commands.cmdtrinken.Custom = true
objWaschbecken1.Commands.cmdtrinken.Id = "33543642-9e5e-465d-bc60-d3433d6b7c33"
objWaschbecken1.Commands.cmdtrinken.WorksWithAll = true
objWaschbecken1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objWaschbecken1.Locked = false
objWaschbecken1.Opened = false
objSpiegel1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBK})
objSpiegel1.Id = "ad733708-29f1-4205-b00f-f9fb08b49764"
objSpiegel1.Name = "Spiegel"
objSpiegel1.Description = "Der klassische Toilettenspiegel aus dem Baumarkt. Passend zum Rest hier."
objSpiegel1.Visible = true
objSpiegel1.Media = objtoilettespiegel
objSpiegel1.Icon = objicotoilettespiegel
objSpiegel1.Commands = {
  cmdbetrachten = Wherigo.ZCommand({
    Text = "betrachten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objSpiegel1.Commands.cmdbetrachten.Custom = true
objSpiegel1.Commands.cmdbetrachten.Id = "4ed9912a-1118-4b23-bc09-5ed4489091aa"
objSpiegel1.Commands.cmdbetrachten.WorksWithAll = true
objSpiegel1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpiegel1.Locked = false
objSpiegel1.Opened = false
objKlowand = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBK})
objKlowand.Id = "c670f362-5898-468a-84d1-415958907b0d"
objKlowand.Name = "Klowand"
objKlowand.Description = ""
objKlowand.Visible = true
objKlowand.Media = objklowand
objKlowand.Icon = objicoklowand
objKlowand.Commands = {
  cmdbetrachten = Wherigo.ZCommand({
    Text = "betrachten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objKlowand.Commands.cmdbetrachten.Custom = true
objKlowand.Commands.cmdbetrachten.Id = "b1858c70-5a95-4003-9af9-247e79f611ff"
objKlowand.Commands.cmdbetrachten.WorksWithAll = true
objKlowand.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKlowand.Locked = false
objKlowand.Opened = false
Notizbuch = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
Notizbuch.Id = "f81f79a3-bff0-4231-b920-b9e36f2e3918"
Notizbuch.Name = "Notizbuch"
Notizbuch.Description = ""
Notizbuch.Visible = true
Notizbuch.Media = objNotizbuch
Notizbuch.Icon = objicoNotizbuch
Notizbuch.Commands = {
  cmdeintragen = Wherigo.ZCommand({
    Text = "eintragen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
Notizbuch.Commands.cmdeintragen.Custom = true
Notizbuch.Commands.cmdeintragen.Id = "80b52cc2-df1d-4df9-87dc-98293432013e"
Notizbuch.Commands.cmdeintragen.WorksWithAll = false
Notizbuch.Commands.cmdeintragen.WorksWithListIds = {
  "f81f79a3-bff0-4231-b920-b9e36f2e3918"
}
Notizbuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
Notizbuch.Locked = false
Notizbuch.Opened = false
objTreppe1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBT})
objTreppe1.Id = "dbd86a81-ef53-4c2b-9c4f-95783503aa95"
objTreppe1.Name = "Treppe"
objTreppe1.Description = ""
objTreppe1.Visible = true
objTreppe1.Media = objTreppe
objTreppe1.Icon = objicoTreppe
objTreppe1.Commands = {
  cmdTreppebetreten = Wherigo.ZCommand({
    Text = "Treppe betreten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objTreppe1.Commands.cmdTreppebetreten.Custom = true
objTreppe1.Commands.cmdTreppebetreten.Id = "9fe3445d-6907-4b17-b97b-db2e9f095d01"
objTreppe1.Commands.cmdTreppebetreten.WorksWithAll = true
objTreppe1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTreppe1.Locked = false
objTreppe1.Opened = false
objRing1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBK})
objRing1.Id = "901c8b74-690f-4730-ab3c-2d162ac9dddc"
objRing1.Name = "Ring"
objRing1.Description = "45 Karat. Ohinger-Grau."
objRing1.Visible = false
objRing1.Media = objRing
objRing1.Icon = objicoRing
objRing1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdRinggeben = Wherigo.ZCommand({
    Text = "Ring geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier den Ring geben?"
  }),
  cmdRingwegwerfen = Wherigo.ZCommand({
    Text = "Ring wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objRing1.Commands.cmdnehmen.Custom = true
objRing1.Commands.cmdnehmen.Id = "4bb36d8a-a14e-4df1-9120-7b0dc1afca69"
objRing1.Commands.cmdnehmen.WorksWithAll = true
objRing1.Commands.cmdRinggeben.Custom = true
objRing1.Commands.cmdRinggeben.Id = "b579428d-3fff-4eff-89b0-0800d5c92b9f"
objRing1.Commands.cmdRinggeben.WorksWithAll = false
objRing1.Commands.cmdRinggeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf"
}
objRing1.Commands.cmdRingwegwerfen.Custom = true
objRing1.Commands.cmdRingwegwerfen.Id = "f0ea815c-d8db-4e47-a883-a3aeedbb396c"
objRing1.Commands.cmdRingwegwerfen.WorksWithAll = false
objRing1.Commands.cmdRingwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objRing1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objRing1.Locked = false
objRing1.Opened = false
objRadio1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHZ})
objRadio1.Id = "e759c46d-8ebb-4c0e-b7b9-270357f48ecc"
objRadio1.Name = "Radio"
objRadio1.Description = "Was fuer ein wohltuender Kontrast zu diesem modernen Ambiente. Ein Telefunken von 1965."
objRadio1.Visible = true
objRadio1.Media = objRadio
objRadio1.Icon = objicoRadio
objRadio1.Commands = {
  cmdanschalten = Wherigo.ZCommand({
    Text = "anschalten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdRadiogeben = Wherigo.ZCommand({
    Text = "Radio geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wemm willst Du das Radio denn geben?"
  })
}
objRadio1.Commands.cmdanschalten.Custom = true
objRadio1.Commands.cmdanschalten.Id = "971e88f6-68a3-4122-84e9-65a39d04d9d5"
objRadio1.Commands.cmdanschalten.WorksWithAll = true
objRadio1.Commands.cmdnehmen.Custom = true
objRadio1.Commands.cmdnehmen.Id = "245b0130-6408-46c4-a15c-22cb36a2b757"
objRadio1.Commands.cmdnehmen.WorksWithAll = true
objRadio1.Commands.cmdRadiogeben.Custom = true
objRadio1.Commands.cmdRadiogeben.Id = "6afee76b-5e15-48da-9669-efe1c1a782ce"
objRadio1.Commands.cmdRadiogeben.WorksWithAll = false
objRadio1.Commands.cmdRadiogeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "3c04bbe7-bf3e-4fc3-adb5-2436b340dc40",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objRadio1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objRadio1.Locked = false
objRadio1.Opened = false
objDiscopass1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCI})
objDiscopass1.Id = "ef68867f-38be-4371-b8d5-37ad3590a3b2"
objDiscopass1.Name = "Discopass"
objDiscopass1.Description = "Oh. Ein VIP-Pass fuer die Spandauer Disco. Das klingt nach vielversprechende Abende mit Tanz ohne Pause - nur fuer VIPs"
objDiscopass1.Visible = false
objDiscopass1.Media = objDiscopass
objDiscopass1.Icon = objicoDiscopass
objDiscopass1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdPassgeben = Wherigo.ZCommand({
    Text = "Pass geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du den Discopass denn geben?"
  }),
  cmdPasswegwerfen = Wherigo.ZCommand({
    Text = "Pass wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objDiscopass1.Commands.cmdnehmen.Custom = true
objDiscopass1.Commands.cmdnehmen.Id = "8ecbc462-efd7-4866-8928-1775377e6bd4"
objDiscopass1.Commands.cmdnehmen.WorksWithAll = true
objDiscopass1.Commands.cmdPassgeben.Custom = true
objDiscopass1.Commands.cmdPassgeben.Id = "da5208c7-a4d1-4e61-8ef8-a582868a3bf6"
objDiscopass1.Commands.cmdPassgeben.WorksWithAll = false
objDiscopass1.Commands.cmdPassgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objDiscopass1.Commands.cmdPasswegwerfen.Custom = true
objDiscopass1.Commands.cmdPasswegwerfen.Id = "0ebad379-0d3a-49f5-860a-4fc0df1f5e17"
objDiscopass1.Commands.cmdPasswegwerfen.WorksWithAll = false
objDiscopass1.Commands.cmdPasswegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objDiscopass1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objDiscopass1.Locked = false
objDiscopass1.Opened = false
objSeil1 = Wherigo.ZItem(KlausKlabuster)
objSeil1.Id = "8519a378-b866-459d-b779-79967c1f3c79"
objSeil1.Name = "Seil"
objSeil1.Description = "Ein 20m Hochleistungsseil fuer Bergsteiger und Extremkletterer"
objSeil1.Visible = false
objSeil1.Media = objSeil
objSeil1.Icon = objicoSeil
objSeil1.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdSeilgeben = Wherigo.ZCommand({
    Text = "Seil geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du das Seil denn geben?"
  }),
  cmdSeilwegwerfen = Wherigo.ZCommand({
    Text = "Seil wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objSeil1.Commands.cmdnehmen.Custom = true
objSeil1.Commands.cmdnehmen.Id = "2affe940-d363-40ca-90b9-ef89f9c71742"
objSeil1.Commands.cmdnehmen.WorksWithAll = true
objSeil1.Commands.cmdSeilgeben.Custom = true
objSeil1.Commands.cmdSeilgeben.Id = "2dd0733a-8f0f-492a-a4e5-4d2e62cb622e"
objSeil1.Commands.cmdSeilgeben.WorksWithAll = false
objSeil1.Commands.cmdSeilgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objSeil1.Commands.cmdSeilwegwerfen.Custom = true
objSeil1.Commands.cmdSeilwegwerfen.Id = "acf96012-73b3-4f2d-80e1-44c48624c45b"
objSeil1.Commands.cmdSeilwegwerfen.WorksWithAll = false
objSeil1.Commands.cmdSeilwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objSeil1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSeil1.Locked = false
objSeil1.Opened = false
objPillendose1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHG})
objPillendose1.Id = "701a41fc-11a5-4d21-bb6e-6db204c684ea"
objPillendose1.Name = "Pillendose"
objPillendose1.Description = [[
Eine leicht angegraute Pillendose - aber gut gefuellt.<BR>
Fuer was moegen die wohl sein - oder gegen was?!]]
objPillendose1.Visible = true
objPillendose1.Media = objPillendose
objPillendose1.Icon = objicoPillendose
objPillendose1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdPillengeben = Wherigo.ZCommand({
    Text = "Pillen geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier die Pillendose geben?"
  }),
  cmdPillenwegwerfen = Wherigo.ZCommand({
    Text = "Pillen wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objPillendose1.Commands.cmdansehen.Custom = true
objPillendose1.Commands.cmdansehen.Id = "d79b2c33-034c-4c93-86ec-b808c94be085"
objPillendose1.Commands.cmdansehen.WorksWithAll = true
objPillendose1.Commands.cmdnehmen.Custom = true
objPillendose1.Commands.cmdnehmen.Id = "aaf333a3-4a0f-4feb-ab99-3a012d231fdb"
objPillendose1.Commands.cmdnehmen.WorksWithAll = true
objPillendose1.Commands.cmdPillengeben.Custom = true
objPillendose1.Commands.cmdPillengeben.Id = "c0f6cc38-1440-4d08-981b-ddcd61b1cf98"
objPillendose1.Commands.cmdPillengeben.WorksWithAll = false
objPillendose1.Commands.cmdPillengeben.WorksWithListIds = {
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465"
}
objPillendose1.Commands.cmdPillenwegwerfen.Custom = true
objPillendose1.Commands.cmdPillenwegwerfen.Id = "ba7b60a9-1048-48ed-9c1b-5c03be3edd68"
objPillendose1.Commands.cmdPillenwegwerfen.WorksWithAll = false
objPillendose1.Commands.cmdPillenwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objPillendose1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPillendose1.Locked = false
objPillendose1.Opened = false
objMagazin1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zLI})
objMagazin1.Id = "aa9a5256-92f4-4a6b-98e8-1bce32095422"
objMagazin1.Name = "Magazin"
objMagazin1.Description = [[
Das Geocaching Magazin 3/2012 von<BR>
www.geocacher.de mit einem spannenden Inhalt:<BR>
u.a. Touri-Cachen in Berlin, Klettern und Schmerzmittel.]]
objMagazin1.Visible = true
objMagazin1.Media = objMagazin
objMagazin1.Icon = objicoMagazin
objMagazin1.Commands = {
  cmdkaufen = Wherigo.ZCommand({
    Text = "kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = "lesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdeinstecken = Wherigo.ZCommand({
    Text = "einstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdMagazingeben = Wherigo.ZCommand({
    Text = "Magazin geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du das Magazin geben?"
  }),
  cmdMagazinwegwerfen = Wherigo.ZCommand({
    Text = "Magazin wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMagazin1.Commands.cmdkaufen.Custom = true
objMagazin1.Commands.cmdkaufen.Id = "fc2772d5-24dc-4abd-82b0-5b093f27d303"
objMagazin1.Commands.cmdkaufen.WorksWithAll = true
objMagazin1.Commands.cmdlesen.Custom = true
objMagazin1.Commands.cmdlesen.Id = "ddbbc9f1-5305-4afb-8929-dded540da847"
objMagazin1.Commands.cmdlesen.WorksWithAll = true
objMagazin1.Commands.cmdeinstecken.Custom = true
objMagazin1.Commands.cmdeinstecken.Id = "f1a5366c-f4d8-4969-8a34-c2b9909e12ed"
objMagazin1.Commands.cmdeinstecken.WorksWithAll = true
objMagazin1.Commands.cmdMagazingeben.Custom = true
objMagazin1.Commands.cmdMagazingeben.Id = "e77997db-378d-441a-ad3d-19f3e6aa3c1e"
objMagazin1.Commands.cmdMagazingeben.WorksWithAll = false
objMagazin1.Commands.cmdMagazingeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objMagazin1.Commands.cmdMagazinwegwerfen.Custom = true
objMagazin1.Commands.cmdMagazinwegwerfen.Id = "bcd909f0-8de8-4784-9d64-1f33c8bf8f28"
objMagazin1.Commands.cmdMagazinwegwerfen.WorksWithAll = false
objMagazin1.Commands.cmdMagazinwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objMagazin1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMagazin1.Locked = true
objMagazin1.Opened = false
objTaschenmesser1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Landstreicher})
objTaschenmesser1.Id = "9eaf451f-caa9-4925-9d3d-205804e81a34"
objTaschenmesser1.Name = "Taschenmesser"
objTaschenmesser1.Description = "Der Klassiker aus Frankreich. Der Penner hat Geschmack!"
objTaschenmesser1.Visible = true
objTaschenmesser1.Media = objTaschenmesser
objTaschenmesser1.Icon = objicoTaschenmesser
objTaschenmesser1.Commands = {
  cmdbenutzen = Wherigo.ZCommand({
    Text = "benutzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdMessergeben = Wherigo.ZCommand({
    Text = "Messer geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du das Messer geben?"
  }),
  cmdMesserwegwerfen = Wherigo.ZCommand({
    Text = "Messer wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objTaschenmesser1.Commands.cmdbenutzen.Custom = true
objTaschenmesser1.Commands.cmdbenutzen.Id = "2ef11641-c4c3-4598-900d-74163e1dc12e"
objTaschenmesser1.Commands.cmdbenutzen.WorksWithAll = true
objTaschenmesser1.Commands.cmdMessergeben.Custom = true
objTaschenmesser1.Commands.cmdMessergeben.Id = "d71504da-d133-4439-b9f2-a917f7e1f4a2"
objTaschenmesser1.Commands.cmdMessergeben.WorksWithAll = false
objTaschenmesser1.Commands.cmdMessergeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "8519a378-b866-459d-b779-79967c1f3c79"
}
objTaschenmesser1.Commands.cmdMesserwegwerfen.Custom = true
objTaschenmesser1.Commands.cmdMesserwegwerfen.Id = "8d078eed-8f17-4a5e-919b-20f3b1b16001"
objTaschenmesser1.Commands.cmdMesserwegwerfen.WorksWithAll = false
objTaschenmesser1.Commands.cmdMesserwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objTaschenmesser1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTaschenmesser1.Locked = false
objTaschenmesser1.Opened = false
objFlascheWein = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zLI})
objFlascheWein.Id = "6d3376a4-5c44-4029-9bfb-75e492b6e967"
objFlascheWein.Name = "Flasche Wein"
objFlascheWein.Description = "Kreuzberger Suedhang, lieblich. Aber ein Abfueller aus Oesterreich? Seltsam."
objFlascheWein.Visible = true
objFlascheWein.Media = objWein
objFlascheWein.Icon = objicoWeinflasche
objFlascheWein.Commands = {
  cmdkaufen = Wherigo.ZCommand({
    Text = "kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdeinstecken = Wherigo.ZCommand({
    Text = "einstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdprobieren = Wherigo.ZCommand({
    Text = "probieren",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtrinken = Wherigo.ZCommand({
    Text = "trinken",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdWeingeben = Wherigo.ZCommand({
    Text = "Wein geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier einen Apfel geben?"
  }),
  cmdWeinwegwerfen = Wherigo.ZCommand({
    Text = "Wein wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objFlascheWein.Commands.cmdkaufen.Custom = true
objFlascheWein.Commands.cmdkaufen.Id = "6fef53df-1bdf-4af4-89da-3921b4f8450f"
objFlascheWein.Commands.cmdkaufen.WorksWithAll = true
objFlascheWein.Commands.cmdeinstecken.Custom = true
objFlascheWein.Commands.cmdeinstecken.Id = "d7776a9b-5cf1-45e5-af73-0041df724d7b"
objFlascheWein.Commands.cmdeinstecken.WorksWithAll = true
objFlascheWein.Commands.cmdprobieren.Custom = true
objFlascheWein.Commands.cmdprobieren.Id = "2e0085f3-ad6f-4a2f-bda5-057baafec4a5"
objFlascheWein.Commands.cmdprobieren.WorksWithAll = true
objFlascheWein.Commands.cmdtrinken.Custom = true
objFlascheWein.Commands.cmdtrinken.Id = "1d6cc3a8-3ff4-41f3-b00a-d3d140d04c2a"
objFlascheWein.Commands.cmdtrinken.WorksWithAll = true
objFlascheWein.Commands.cmdWeingeben.Custom = true
objFlascheWein.Commands.cmdWeingeben.Id = "27567115-2906-4450-9751-f1aa2ed69f58"
objFlascheWein.Commands.cmdWeingeben.WorksWithAll = false
objFlascheWein.Commands.cmdWeingeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244"
}
objFlascheWein.Commands.cmdWeinwegwerfen.Custom = true
objFlascheWein.Commands.cmdWeinwegwerfen.Id = "9926dd2f-87ed-48dc-bf41-1e5fbe463259"
objFlascheWein.Commands.cmdWeinwegwerfen.WorksWithAll = false
objFlascheWein.Commands.cmdWeinwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objFlascheWein.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFlascheWein.Locked = true
objFlascheWein.Opened = false
objAschenbecher1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCI})
objAschenbecher1.Id = "6411ad11-0839-4804-b430-c9058e12ae35"
objAschenbecher1.Name = "Aschenbecher"
objAschenbecher1.Description = "Ein handelsueblicher Standaschenbecher - nur etwas schmutzig und unordentlich."
objAschenbecher1.Visible = true
objAschenbecher1.Media = objAschenbecher
objAschenbecher1.Icon = objicoAschenbecher
objAschenbecher1.Commands = {
  cmdputzen = Wherigo.ZCommand({
    Text = "putzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmddurchsuchen = Wherigo.ZCommand({
    Text = "durchsuchen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objAschenbecher1.Commands.cmdputzen.Custom = true
objAschenbecher1.Commands.cmdputzen.Id = "38f0f9b0-2d06-427f-bcd5-0fc620dc0091"
objAschenbecher1.Commands.cmdputzen.WorksWithAll = true
objAschenbecher1.Commands.cmddurchsuchen.Custom = true
objAschenbecher1.Commands.cmddurchsuchen.Id = "94c0fc79-49c8-432c-b6d0-ce4d3b34da80"
objAschenbecher1.Commands.cmddurchsuchen.WorksWithAll = true
objAschenbecher1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAschenbecher1.Locked = false
objAschenbecher1.Opened = false
objSpielautomat1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCI})
objSpielautomat1.Id = "e3ad038b-920c-4401-92cf-453b581a1c56"
objSpielautomat1.Name = "Spielautomat"
objSpielautomat1.Description = [[
Der klassische einarmige Bandit RXC von 1968.<BR>
Aber halt , gabe es bei diesem Modell nicht eine paar Kniffe, die Gewinnchancen zu erhoehen?]]
objSpielautomat1.Visible = true
objSpielautomat1.Media = objSpielautomat
objSpielautomat1.Icon = objicoSpielautomat
objSpielautomat1.Commands = {
  cmdspielen = Wherigo.ZCommand({
    Text = "spielen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objSpielautomat1.Commands.cmdspielen.Custom = true
objSpielautomat1.Commands.cmdspielen.Id = "836e04e8-0f8f-4c51-8291-5e02acfe6d65"
objSpielautomat1.Commands.cmdspielen.WorksWithAll = true
objSpielautomat1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpielautomat1.Locked = false
objSpielautomat1.Opened = false
objFreischaltcode = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objFreischaltcode.Id = "120307fe-9a8b-4575-8459-083a6d639df6"
objFreischaltcode.Name = "Freischaltcode"
objFreischaltcode.Description = "Der Code, um die Cartridge bei www.wherigo.com freizuschalten."
objFreischaltcode.Visible = false
objFreischaltcode.Media = objgrundbuch
objFreischaltcode.Icon = objicogrundbuch
objFreischaltcode.Commands = {
  cmdaufschreiben = Wherigo.ZCommand({
    Text = "aufschreiben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objFreischaltcode.Commands.cmdaufschreiben.Custom = true
objFreischaltcode.Commands.cmdaufschreiben.Id = "33ceae09-c70f-482c-a5cb-5c1041b3adef"
objFreischaltcode.Commands.cmdaufschreiben.WorksWithAll = true
objFreischaltcode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFreischaltcode.Locked = false
objFreischaltcode.Opened = false
objKoordinaten1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zFC})
objKoordinaten1.Id = "16410378-ac0d-4b8b-a0b6-0267d188643b"
objKoordinaten1.Name = "Koordinaten"
objKoordinaten1.Description = [[
Das Grundbuch liegt bei<BR>
N 52 &nbsp;&nbsp;28,263 &nbsp;&nbsp;&nbsp;&nbsp;E 013 &nbsp;07,017]]
objKoordinaten1.Visible = true
objKoordinaten1.Media = objKoordinaten
objKoordinaten1.Icon = objicoKoordinaten
objKoordinaten1.Commands = {
  cmdaufschreiben = Wherigo.ZCommand({
    Text = "aufschreiben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objKoordinaten1.Commands.cmdaufschreiben.Custom = true
objKoordinaten1.Commands.cmdaufschreiben.Id = "14f7ce7e-daca-4d04-ad55-b46d9b7ddb2a"
objKoordinaten1.Commands.cmdaufschreiben.WorksWithAll = true
objKoordinaten1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKoordinaten1.Locked = false
objKoordinaten1.Opened = false
objVarieteplakat = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCI})
objVarieteplakat.Id = "a1244d07-38db-466d-9ac2-7d9e2d2a779d"
objVarieteplakat.Name = "Varieteplakat"
objVarieteplakat.Description = "Werbung. Ueberall Werbung!"
objVarieteplakat.Visible = true
objVarieteplakat.Media = objvarieteplakat
objVarieteplakat.Icon = objicovarieteplakat
objVarieteplakat.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objVarieteplakat.Commands.cmdansehen.Custom = true
objVarieteplakat.Commands.cmdansehen.Id = "7c127464-5505-44e4-a4be-3a8f165e8850"
objVarieteplakat.Commands.cmdansehen.WorksWithAll = true
objVarieteplakat.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objVarieteplakat.Locked = false
objVarieteplakat.Opened = false
objMobiltelefon1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objMobiltelefon1.Id = "f11a4768-87fc-48a6-9531-4da849add987"
objMobiltelefon1.Name = "Mobiltelefon"
objMobiltelefon1.Description = "Oje - nicht das neueste Modell, aber dafuer eine lange Stehzeit - in der Theorie"
objMobiltelefon1.Visible = true
objMobiltelefon1.Media = objMobiltelefon
objMobiltelefon1.Icon = objicoMobiltelefon
objMobiltelefon1.Commands = {
  cmdtelefonieren = Wherigo.ZCommand({
    Text = "telefonieren",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdMobiltelefongeben = Wherigo.ZCommand({
    Text = "Mobiltelefon geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du Dein Telefon geben?"
  }),
  cmdMobilelefonwegwerfen = Wherigo.ZCommand({
    Text = "Mobilelefon wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMobiltelefon1.Commands.cmdtelefonieren.Custom = true
objMobiltelefon1.Commands.cmdtelefonieren.Id = "484db8db-b6b4-4bf5-b47f-22ac8400c069"
objMobiltelefon1.Commands.cmdtelefonieren.WorksWithAll = true
objMobiltelefon1.Commands.cmdMobiltelefongeben.Custom = true
objMobiltelefon1.Commands.cmdMobiltelefongeben.Id = "5b85349c-d094-4f23-a6c7-de2486b21246"
objMobiltelefon1.Commands.cmdMobiltelefongeben.WorksWithAll = false
objMobiltelefon1.Commands.cmdMobiltelefongeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objMobiltelefon1.Commands.cmdMobilelefonwegwerfen.Custom = true
objMobiltelefon1.Commands.cmdMobilelefonwegwerfen.Id = "679055e2-da9d-4cdd-8712-d7afae7acadd"
objMobiltelefon1.Commands.cmdMobilelefonwegwerfen.WorksWithAll = false
objMobiltelefon1.Commands.cmdMobilelefonwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objMobiltelefon1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMobiltelefon1.Locked = false
objMobiltelefon1.Opened = false
objInfos = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objInfos.Id = "27b4e59d-a64f-449e-b7a5-1a10e5797d70"
objInfos.Name = "Infos"
objInfos.Description = "Infos, Tips und Tricks"
objInfos.Visible = true
objInfos.Media = objHilfe
objInfos.Icon = objicohilfe
objInfos.Commands = {
  cmdanzeigen = Wherigo.ZCommand({
    Text = "anzeigen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objInfos.Commands.cmdanzeigen.Custom = true
objInfos.Commands.cmdanzeigen.Id = "4e44d052-4806-4960-bb4e-16d8064ae25a"
objInfos.Commands.cmdanzeigen.WorksWithAll = true
objInfos.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objInfos.Locked = false
objInfos.Opened = false
objSchild = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objSchild.Id = "be1db57e-8f48-4407-9d43-a427ef3b7afe"
objSchild.Name = "Schild"
objSchild.Description = "Aha - ein Taxistand. Gut zu wissen."
objSchild.Visible = true
objSchild.Media = objTaxischild
objSchild.Icon = objicoTaxischild
objSchild.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdTaxirufen = Wherigo.ZCommand({
    Text = "Taxi rufen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objSchild.Commands.cmdansehen.Custom = true
objSchild.Commands.cmdansehen.Id = "bb150a6c-bb4d-497b-9ca8-4741a1be9120"
objSchild.Commands.cmdansehen.WorksWithAll = true
objSchild.Commands.cmdTaxirufen.Custom = true
objSchild.Commands.cmdTaxirufen.Id = "798cc959-e654-4ef4-96d9-79106c7ae909"
objSchild.Commands.cmdTaxirufen.WorksWithAll = true
objSchild.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSchild.Locked = false
objSchild.Opened = false
objFilmdose1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objFilmdose1.Id = "97adda1b-2fd9-43f9-a9a8-bf0507a82f1d"
objFilmdose1.Name = "Filmdose"
objFilmdose1.Description = "Im Zeitalter von Smartphones gibt es noch Filmdosen?"
objFilmdose1.Visible = false
objFilmdose1.Media = objFilmdose
objFilmdose1.Icon = objicoFilmdose
objFilmdose1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdFilmdosewegwerfen = Wherigo.ZCommand({
    Text = "Filmdose wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdeintragen = Wherigo.ZCommand({
    Text = "eintragen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdverstecken = Wherigo.ZCommand({
    Text = "verstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objFilmdose1.Commands.cmdansehen.Custom = true
objFilmdose1.Commands.cmdansehen.Id = "9d694df0-bb2b-4294-815a-2205ad871f29"
objFilmdose1.Commands.cmdansehen.WorksWithAll = true
objFilmdose1.Commands.cmdFilmdosewegwerfen.Custom = true
objFilmdose1.Commands.cmdFilmdosewegwerfen.Id = "03d239c8-c604-432e-85a8-aec53c3a3099"
objFilmdose1.Commands.cmdFilmdosewegwerfen.WorksWithAll = false
objFilmdose1.Commands.cmdFilmdosewegwerfen.WorksWithListIds = {
  "14e91fa0-8c16-412f-9c97-ff24031f83a0"
}
objFilmdose1.Commands.cmdeintragen.Custom = true
objFilmdose1.Commands.cmdeintragen.Id = "ee79681e-45a3-4604-a3f7-07bd925280c6"
objFilmdose1.Commands.cmdeintragen.WorksWithAll = true
objFilmdose1.Commands.cmdverstecken.Custom = true
objFilmdose1.Commands.cmdverstecken.Id = "bb03ad8d-86a7-4e2a-bbd2-e881f9b57ccf"
objFilmdose1.Commands.cmdverstecken.WorksWithAll = true
objFilmdose1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFilmdose1.Locked = true
objFilmdose1.Opened = false
objTelefonzelle1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objTelefonzelle1.Id = "9831441d-b323-493e-aa3f-5dc3922d0b66"
objTelefonzelle1.Name = "Telefonzelle"
objTelefonzelle1.Description = ""
objTelefonzelle1.Visible = true
objTelefonzelle1.Media = objTelefonzelle
objTelefonzelle1.Icon = objicoTelefonzelle
objTelefonzelle1.Commands = {
  cmdsetzen = Wherigo.ZCommand({
    Text = "setzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtelefonieren = Wherigo.ZCommand({
    Text = "telefonieren",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objTelefonzelle1.Commands.cmdsetzen.Custom = true
objTelefonzelle1.Commands.cmdsetzen.Id = "a1393d33-a890-409a-b5d7-fe4faa2dd7a5"
objTelefonzelle1.Commands.cmdsetzen.WorksWithAll = true
objTelefonzelle1.Commands.cmdtelefonieren.Custom = true
objTelefonzelle1.Commands.cmdtelefonieren.Id = "4b44bf10-53ee-4ba5-8954-c0c91ec0c5d6"
objTelefonzelle1.Commands.cmdtelefonieren.WorksWithAll = true
objTelefonzelle1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTelefonzelle1.Locked = false
objTelefonzelle1.Opened = false
objBild = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBI})
objBild.Id = "c9829d9b-1113-4e58-b34d-3abef600b900"
objBild.Name = "Bild"
objBild.Description = [[
Ein Werbeplakat der besonderen Art.<BR>
Heisst die Signatur nun Monet oder Monique - und was bedeutet der Hinweis Gentlemen/Privat?<BR>
Seltsam.]]
objBild.Visible = true
objBild.Media = objHure
objBild.Icon = objicohure
objBild.Commands = {}
objBild.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBild.Locked = false
objBild.Opened = false
objFenster1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zBZ})
objFenster1.Id = "c9fbafbe-2c63-4774-8bdb-e8aaeca95d55"
objFenster1.Name = "Fenster"
objFenster1.Description = [[
Ein altes, klappriges Fenster. Bei dem der Lack sichtlich ab ist - ganz anders wie bei der Zimmerbewohnerin.<BR>
Draussen ist ein kleiner Balkon und ein Hinterhof zu erkennen, der &nbsp;auf den Marktplatz fuehrt.]]
objFenster1.Visible = true
objFenster1.Media = objFenster
objFenster1.Icon = objicoFenster
objFenster1.Commands = {
  cmdoeffnen = Wherigo.ZCommand({
    Text = "oeffnen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdschliessen = Wherigo.ZCommand({
    Text = "schliessen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objFenster1.Commands.cmdoeffnen.Custom = true
objFenster1.Commands.cmdoeffnen.Id = "c9ae079b-eda3-4add-9aaf-a1f98a4898c9"
objFenster1.Commands.cmdoeffnen.WorksWithAll = true
objFenster1.Commands.cmdschliessen.Custom = true
objFenster1.Commands.cmdschliessen.Id = "bdeaba7e-c4b4-4efa-a7de-7bbe359f43f6"
objFenster1.Commands.cmdschliessen.WorksWithAll = true
objFenster1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFenster1.Locked = false
objFenster1.Opened = false
objWandtelefon1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHL})
objWandtelefon1.Id = "69c56d34-8514-466f-8c77-ae83bc11a495"
objWandtelefon1.Name = "Wandtelefon"
objWandtelefon1.Description = "Ein stylisches Wandtelefon, das perfekt zum Ambiente des Hotels passt. "
objWandtelefon1.Visible = true
objWandtelefon1.Media = objWandtelefon
objWandtelefon1.Icon = objicoWandtelefon
objWandtelefon1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtelefonieren = Wherigo.ZCommand({
    Text = "telefonieren",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
objWandtelefon1.Commands.cmdansehen.Custom = true
objWandtelefon1.Commands.cmdansehen.Id = "5dd15f61-c964-4e34-979c-59f0b1513258"
objWandtelefon1.Commands.cmdansehen.WorksWithAll = true
objWandtelefon1.Commands.cmdtelefonieren.Custom = true
objWandtelefon1.Commands.cmdtelefonieren.Id = "4ca591d4-60ba-4bd7-a0b5-6eb2c6edf9a9"
objWandtelefon1.Commands.cmdtelefonieren.WorksWithAll = true
objWandtelefon1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objWandtelefon1.Locked = false
objWandtelefon1.Opened = false
objTelefon1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHZ})
objTelefon1.Id = "1eab9ae7-b33d-4511-b78e-bccfd3d2c677"
objTelefon1.Name = "Telefon"
objTelefon1.Description = "Ein handelsuebliches Tischtelefon, einfach und robust."
objTelefon1.Visible = true
objTelefon1.Media = objTelefon
objTelefon1.Icon = objicoTelefon
objTelefon1.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtelefonieren = Wherigo.ZCommand({
    Text = "telefonieren",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objTelefon1.Commands.cmdansehen.Custom = true
objTelefon1.Commands.cmdansehen.Id = "b0b8c2f8-c70e-4a47-8cc2-a0807dc2d32f"
objTelefon1.Commands.cmdansehen.WorksWithAll = true
objTelefon1.Commands.cmdtelefonieren.Custom = true
objTelefon1.Commands.cmdtelefonieren.Id = "0c970615-24b0-4316-b339-ce5ae898fa26"
objTelefon1.Commands.cmdtelefonieren.WorksWithAll = true
objTelefon1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objTelefon1.Locked = false
objTelefon1.Opened = false
objWaschbecken2 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCT})
objWaschbecken2.Id = "27610193-5bbb-4951-8f02-b83ba92f8bde"
objWaschbecken2.Name = "Waschbecken"
objWaschbecken2.Description = "Ein stylisches Waschbecken, passend zum Ambiente. Was fuer ein Unterschied zur blauen Maus."
objWaschbecken2.Visible = true
objWaschbecken2.Media = objWaschbecken
objWaschbecken2.Icon = objicoWaschbecken
objWaschbecken2.Commands = {
  cmdHaendewaschen = Wherigo.ZCommand({
    Text = "Haende waschen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdtrinken = Wherigo.ZCommand({
    Text = "trinken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objWaschbecken2.Commands.cmdHaendewaschen.Custom = true
objWaschbecken2.Commands.cmdHaendewaschen.Id = "980c3883-572e-4486-a4e0-97a2ad201650"
objWaschbecken2.Commands.cmdHaendewaschen.WorksWithAll = true
objWaschbecken2.Commands.cmdtrinken.Custom = true
objWaschbecken2.Commands.cmdtrinken.Id = "7bc54f92-191f-42aa-a343-750b3c648a72"
objWaschbecken2.Commands.cmdtrinken.WorksWithAll = true
objWaschbecken2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objWaschbecken2.Locked = false
objWaschbecken2.Opened = false
objSpiegel2 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zCT})
objSpiegel2.Id = "7822f9f8-f4d8-41ec-ae60-4860769812b1"
objSpiegel2.Name = "Spiegel"
objSpiegel2.Description = "Ein stylischer Wandspiegel, der mit seinem Holzrahmen einen modernen Kontrapunkt zum klassischen Ambiente setzt."
objSpiegel2.Visible = true
objSpiegel2.Media = objSpiegel
objSpiegel2.Icon = objicoWandpsiegel
objSpiegel2.Commands = {
  cmdbetrachten = Wherigo.ZCommand({
    Text = "betrachten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objSpiegel2.Commands.cmdbetrachten.Custom = true
objSpiegel2.Commands.cmdbetrachten.Id = "991b7cf3-9b9a-4a7d-b611-685134633308"
objSpiegel2.Commands.cmdbetrachten.WorksWithAll = true
objSpiegel2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpiegel2.Locked = false
objSpiegel2.Opened = false
objPuppe = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHZ})
objPuppe.Id = "17b7d95c-1885-41c6-a83f-4f658c8ab883"
objPuppe.Name = "Puppe"
objPuppe.Description = [[
Das Standartmodell von Enterprise.<BR>
Nicht besonders huebsch, aber in der Not - was soll es schon ...]]
objPuppe.Visible = true
objPuppe.Media = objDoll
objPuppe.Icon = objicoDoll
objPuppe.Commands = {
  cmdbenutzen = Wherigo.ZCommand({
    Text = "benutzen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdmitnehmen = Wherigo.ZCommand({
    Text = "mitnehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdweglegen = Wherigo.ZCommand({
    Text = "weglegen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdPuppegeben = Wherigo.ZCommand({
    Text = "Puppe geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du hier die Puppe geben?"
  })
}
objPuppe.Commands.cmdbenutzen.Custom = true
objPuppe.Commands.cmdbenutzen.Id = "ebc7f658-0fb1-4bbc-8a6f-43b4057a3d91"
objPuppe.Commands.cmdbenutzen.WorksWithAll = true
objPuppe.Commands.cmdmitnehmen.Custom = true
objPuppe.Commands.cmdmitnehmen.Id = "21e777a3-e1f4-4174-b2ed-64766260da9f"
objPuppe.Commands.cmdmitnehmen.WorksWithAll = true
objPuppe.Commands.cmdweglegen.Custom = true
objPuppe.Commands.cmdweglegen.Id = "f60911bf-ebde-4c53-bf53-2901d9f4e46e"
objPuppe.Commands.cmdweglegen.WorksWithAll = true
objPuppe.Commands.cmdPuppegeben.Custom = true
objPuppe.Commands.cmdPuppegeben.Id = "2298d940-d9ee-4a06-9ed9-a6f1c8eaa2d2"
objPuppe.Commands.cmdPuppegeben.WorksWithAll = false
objPuppe.Commands.cmdPuppegeben.WorksWithListIds = {
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274"
}
objPuppe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objPuppe.Locked = false
objPuppe.Opened = false
objHoftor1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objHoftor1.Id = "5d1a3325-b5d7-4ae0-a6d3-b7250b5ae56b"
objHoftor1.Name = "Hoftor"
objHoftor1.Description = [[
Ein handwerkliches Meisterwerk an Schreinerkunst, das zwar den Blick auf einen Hinterhof erlaubt, jedoch mit einem Knauf fest verschlossen ist.<BR>
Der Hinterhof scheint zur Blauen Maus zu gehoeren.]]
objHoftor1.Visible = true
objHoftor1.Media = objHoftor
objHoftor1.Icon = objicoHoftor
objHoftor1.Commands = {}
objHoftor1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHoftor1.Locked = false
objHoftor1.Opened = false
objGlastuer = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zHL})
objGlastuer.Id = "fad1a981-42b2-4bdc-b263-a7e64e40f6c1"
objGlastuer.Name = "Glastuer"
objGlastuer.Description = [[
Ein dezentes Schild macht deutlich, was sich sonst nur erahnen laesst: dahinter liegt der Wellness-Bereich des Hotels.<BR>
Du drueckst Deine Nase platt und kannst schemenhaft ein zauberhaftes Wesen erkennen, das gerade in den Whirlpool steigt.]]
objGlastuer.Visible = true
objGlastuer.Media = objGlastur
objGlastuer.Icon = objicoGlastur
objGlastuer.Commands = {
  cmdoeffnen = Wherigo.ZCommand({
    Text = "oeffnen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objGlastuer.Commands.cmdoeffnen.Custom = true
objGlastuer.Commands.cmdoeffnen.Id = "a3b1f637-8493-4cd7-bdc9-1ab96c6673fd"
objGlastuer.Commands.cmdoeffnen.WorksWithAll = true
objGlastuer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGlastuer.Locked = false
objGlastuer.Opened = false
objNummerTaxiSchmidt = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objNummerTaxiSchmidt.Id = "fd856189-1a18-453b-96d7-e3e7d6cf4c2a"
objNummerTaxiSchmidt.Name = "Nummer Taxi Schmidt"
objNummerTaxiSchmidt.Description = "01723939563"
objNummerTaxiSchmidt.Visible = false
objNummerTaxiSchmidt.Media = objTelefonbuch
objNummerTaxiSchmidt.Icon = objicoTelefonbuch
objNummerTaxiSchmidt.Commands = {}
objNummerTaxiSchmidt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objNummerTaxiSchmidt.Locked = false
objNummerTaxiSchmidt.Opened = false
objNummerRosi = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objNummerRosi.Id = "162ef72c-ad54-418d-a085-f7089b208c40"
objNummerRosi.Name = "Nummer Rosi"
objNummerRosi.Description = "32168"
objNummerRosi.Visible = false
objNummerRosi.Media = objTelefonbuch
objNummerRosi.Icon = objicoTelefonbuch
objNummerRosi.Commands = {}
objNummerRosi.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objNummerRosi.Locked = false
objNummerRosi.Opened = false
objNummer24hLieferservice = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objNummer24hLieferservice.Id = "93eccb26-7534-453e-b8fa-20e003f71894"
objNummer24hLieferservice.Name = "Nummer 24h Lieferservice"
objNummer24hLieferservice.Description = "08004711"
objNummer24hLieferservice.Visible = false
objNummer24hLieferservice.Media = objTelefonbuch
objNummer24hLieferservice.Icon = objicoTelefonbuch
objNummer24hLieferservice.Commands = {}
objNummer24hLieferservice.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objNummer24hLieferservice.Locked = false
objNummer24hLieferservice.Opened = false
objCurrywurststand = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objCurrywurststand.Id = "7ec5d6c5-36ab-4398-ae5c-c0ba3f63f2b0"
objCurrywurststand.Name = "Currywurststand"
objCurrywurststand.Description = ""
objCurrywurststand.Visible = true
objCurrywurststand.Media = objcurrywurststand
objCurrywurststand.Icon = objicocurrywurststand
objCurrywurststand.Commands = {
  cmdCurrywurstkaufen = Wherigo.ZCommand({
    Text = "Currywurst kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdColakaufen = Wherigo.ZCommand({
    Text = "Cola kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objCurrywurststand.Commands.cmdCurrywurstkaufen.Custom = true
objCurrywurststand.Commands.cmdCurrywurstkaufen.Id = "79d36461-6377-49da-9b19-69042fca54d5"
objCurrywurststand.Commands.cmdCurrywurstkaufen.WorksWithAll = true
objCurrywurststand.Commands.cmdColakaufen.Custom = true
objCurrywurststand.Commands.cmdColakaufen.Id = "52b7eec2-350c-4118-9de8-d9f0de273ca6"
objCurrywurststand.Commands.cmdColakaufen.WorksWithAll = true
objCurrywurststand.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objCurrywurststand.Locked = false
objCurrywurststand.Opened = false
objCurrywurst = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = objCurrywurststand})
objCurrywurst.Id = "c5f9a161-62fa-44e1-be8b-4871b4a75191"
objCurrywurst.Name = "Currywurst"
objCurrywurst.Description = ""
objCurrywurst.Visible = true
objCurrywurst.Media = objcurrywurst
objCurrywurst.Icon = objicocurrywurst
objCurrywurst.Commands = {
  cmdessen = Wherigo.ZCommand({
    Text = "essen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdWurstgeben = Wherigo.ZCommand({
    Text = "Wurst geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du denn hier die Currywurst geben?"
  }),
  cmdWurstwegwerfen = Wherigo.ZCommand({
    Text = "Wurst wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objCurrywurst.Commands.cmdessen.Custom = true
objCurrywurst.Commands.cmdessen.Id = "76068274-a280-4854-a677-c7a6c43d33a0"
objCurrywurst.Commands.cmdessen.WorksWithAll = true
objCurrywurst.Commands.cmdWurstgeben.Custom = true
objCurrywurst.Commands.cmdWurstgeben.Id = "7b92ea3f-087a-4f7d-a9ee-eac1f34252d4"
objCurrywurst.Commands.cmdWurstgeben.WorksWithAll = false
objCurrywurst.Commands.cmdWurstgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "3c04bbe7-bf3e-4fc3-adb5-2436b340dc40"
}
objCurrywurst.Commands.cmdWurstwegwerfen.Custom = true
objCurrywurst.Commands.cmdWurstwegwerfen.Id = "8952f0c0-6fd3-4045-9f93-37ca44fdbc3c"
objCurrywurst.Commands.cmdWurstwegwerfen.WorksWithAll = false
objCurrywurst.Commands.cmdWurstwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objCurrywurst.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objCurrywurst.Locked = false
objCurrywurst.Opened = false
objCola = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = objCurrywurststand})
objCola.Id = "155af088-5a29-4c73-a848-cb06c53fc5df"
objCola.Name = "Cola"
objCola.Description = ""
objCola.Visible = true
objCola.Media = objcola
objCola.Icon = objicocola
objCola.Commands = {
  cmdtrinken = Wherigo.ZCommand({
    Text = "trinken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdColageben = Wherigo.ZCommand({
    Text = "Cola geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du denn die Cola geben?"
  }),
  cmdColawegwerfen = Wherigo.ZCommand({
    Text = "Cola wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objCola.Commands.cmdtrinken.Custom = true
objCola.Commands.cmdtrinken.Id = "fba74b21-d2d2-4c73-8522-59ae66d1f41e"
objCola.Commands.cmdtrinken.WorksWithAll = true
objCola.Commands.cmdColageben.Custom = true
objCola.Commands.cmdColageben.Id = "07222b04-ae3c-4d9d-bb0d-d111aff9feb4"
objCola.Commands.cmdColageben.WorksWithAll = false
objCola.Commands.cmdColageben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objCola.Commands.cmdColawegwerfen.Custom = true
objCola.Commands.cmdColawegwerfen.Id = "fc11b837-230c-41f8-931d-aa0822bcf448"
objCola.Commands.cmdColawegwerfen.WorksWithAll = false
objCola.Commands.cmdColawegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objCola.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objCola.Locked = false
objCola.Opened = false
objStadtplan = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objStadtplan.Id = "14deab64-a6af-4e25-bd7c-aaa8a011646f"
objStadtplan.Name = "Stadtplan"
objStadtplan.Description = "Ein alter Stadtplan der Altstadt von Spandau"
objStadtplan.Visible = true
objStadtplan.Media = objLandkarte
objStadtplan.Icon = objicolandkarte
objStadtplan.Commands = {
  cmdnehmen = Wherigo.ZCommand({
    Text = "nehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdStadtplanwegwerfen = Wherigo.ZCommand({
    Text = "Stadtplan wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objStadtplan.Commands.cmdnehmen.Custom = true
objStadtplan.Commands.cmdnehmen.Id = "52dfa075-ac87-499a-9dec-b6b87d62ae66"
objStadtplan.Commands.cmdnehmen.WorksWithAll = true
objStadtplan.Commands.cmdStadtplanwegwerfen.Custom = true
objStadtplan.Commands.cmdStadtplanwegwerfen.Id = "0fa8ac18-d58a-4de5-8bdd-b8a0879625a5"
objStadtplan.Commands.cmdStadtplanwegwerfen.WorksWithAll = false
objStadtplan.Commands.cmdStadtplanwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objStadtplan.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objStadtplan.Locked = false
objStadtplan.Opened = false
objSpoiler1 = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objSpoiler1.Id = "c4a95eaa-cbe9-4834-a933-9accd0224d10"
objSpoiler1.Name = "Spoiler"
objSpoiler1.Description = ""
objSpoiler1.Visible = false
objSpoiler1.Media = objSpoiler
objSpoiler1.Icon = objicoSpoiler
objSpoiler1.Commands = {}
objSpoiler1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpoiler1.Locked = false
objSpoiler1.Opened = false
objBiographie = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zLI})
objBiographie.Id = "51a5c622-7caa-4bf1-b461-6d46d259320d"
objBiographie.Name = "Biographie"
objBiographie.Description = [[
Oh - Larry hat sogar ein Buch geschrieben.<BR>
Aber 25 Euro - das ist heftig!]]
objBiographie.Visible = true
objBiographie.Media = objlltitel
objBiographie.Icon = objicolltitel
objBiographie.Commands = {
  cmdeinstecken = Wherigo.ZCommand({
    Text = "einstecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdkaufen = Wherigo.ZCommand({
    Text = "kaufen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdlesen = Wherigo.ZCommand({
    Text = "lesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdBuchgeben = Wherigo.ZCommand({
    Text = "Buch geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du das Buch denn geben?"
  }),
  cmdBuchwegwerfen = Wherigo.ZCommand({
    Text = "Buch wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objBiographie.Commands.cmdeinstecken.Custom = true
objBiographie.Commands.cmdeinstecken.Id = "21989508-4f48-460f-ae54-a6cbead10447"
objBiographie.Commands.cmdeinstecken.WorksWithAll = true
objBiographie.Commands.cmdkaufen.Custom = true
objBiographie.Commands.cmdkaufen.Id = "443aeffc-b4e7-4b62-9f5f-862843812874"
objBiographie.Commands.cmdkaufen.WorksWithAll = true
objBiographie.Commands.cmdlesen.Custom = true
objBiographie.Commands.cmdlesen.Id = "057e0687-4ebc-4c22-b9c1-63406e1532a8"
objBiographie.Commands.cmdlesen.WorksWithAll = true
objBiographie.Commands.cmdBuchgeben.Custom = true
objBiographie.Commands.cmdBuchgeben.Id = "1431ae26-dee6-4249-bfa7-0ade86c0b20e"
objBiographie.Commands.cmdBuchgeben.WorksWithAll = false
objBiographie.Commands.cmdBuchgeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objBiographie.Commands.cmdBuchwegwerfen.Custom = true
objBiographie.Commands.cmdBuchwegwerfen.Id = "6f211c68-df45-4079-be72-9fe617935668"
objBiographie.Commands.cmdBuchwegwerfen.WorksWithAll = false
objBiographie.Commands.cmdBuchwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objBiographie.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBiographie.Locked = true
objBiographie.Opened = false
objGeocoin = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objGeocoin.Id = "138f275e-aa1b-4e43-b34a-5b1cc4c2c9f3"
objGeocoin.Name = "Geocoin"
objGeocoin.Description = [[
Hoppla - da hat jemand ein Osterei versteckt:<BR>
<BR>
Tracking code EAJHNB]]
objGeocoin.Visible = false
objGeocoin.Media = objgeocoin
objGeocoin.Icon = objicogeocoin
objGeocoin.Commands = {
  cmdmitnehmen = Wherigo.ZCommand({
    Text = "mitnehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  cmdGeocCoingeben = Wherigo.ZCommand({
    Text = "GeocCoin geben",
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = "Wem willst Du die GeoCoin geben?"
  })
}
objGeocoin.Commands.cmdmitnehmen.Custom = true
objGeocoin.Commands.cmdmitnehmen.Id = "595effe7-4909-4924-8112-e161c158fab8"
objGeocoin.Commands.cmdmitnehmen.WorksWithAll = true
objGeocoin.Commands.cmdGeocCoingeben.Custom = true
objGeocoin.Commands.cmdGeocCoingeben.Id = "6140cf91-182c-492b-a426-1e0135917e5c"
objGeocoin.Commands.cmdGeocCoingeben.WorksWithAll = false
objGeocoin.Commands.cmdGeocCoingeben.WorksWithListIds = {
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "2119a664-659c-4a01-873b-850e80835465",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "97adda1b-2fd9-43f9-a9a8-bf0507a82f1d"
}
objGeocoin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGeocoin.Locked = true
objGeocoin.Opened = false
objGeld = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objGeld.Id = "fcbbcc08-6c21-47e9-961e-9fe4531cf847"
objGeld.Name = "Geld"
objGeld.Description = "Du hast 34 Euro"
objGeld.Visible = true
objGeld.Media = objgeld
objGeld.Icon = objicogeld
objGeld.Commands = {
  cmdGeldgeben = Wherigo.ZCommand({
    Text = "Geld geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Hier ist niemand, dem Du Geld geben kannst"
  })
}
objGeld.Commands.cmdGeldgeben.Custom = true
objGeld.Commands.cmdGeldgeben.Id = "5cf30575-f650-4c2d-8ee4-0df4d80f1da0"
objGeld.Commands.cmdGeldgeben.WorksWithAll = false
objGeld.Commands.cmdGeldgeben.WorksWithListIds = {
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "6683526d-d18a-4e40-8859-feac4cb5d309",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a"
}
objGeld.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGeld.Locked = false
objGeld.Opened = false
objZigaretten = Wherigo.ZItem(KlausKlabuster)
objZigaretten.Id = "2116c52c-9bce-45a4-96fa-2f386d8255e0"
objZigaretten.Name = "Zigaretten"
objZigaretten.Description = "Ui - hat es diese Traditionsmarke doch tatsaechlich geschafft zu ueberleben. Zu DDR-Zeiten war &gt;die Club&lt; eine der hoeherpreisigen Filterzigaretten. "
objZigaretten.Visible = true
objZigaretten.Media = objzigaretten
objZigaretten.Icon = objicozigaretten
objZigaretten.Commands = {
  cmdZigarettengeben = Wherigo.ZCommand({
    Text = "Zigaretten geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du denn die Zigaretten geben?"
  }),
  cmdrauchen = Wherigo.ZCommand({
    Text = "rauchen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  }),
  cmdZigarettenwegwerfen = Wherigo.ZCommand({
    Text = "Zigaretten wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objZigaretten.Commands.cmdZigarettengeben.Custom = true
objZigaretten.Commands.cmdZigarettengeben.Id = "31f2bd9b-0d5f-4cc2-be95-a6d94a327d43"
objZigaretten.Commands.cmdZigarettengeben.WorksWithAll = false
objZigaretten.Commands.cmdZigarettengeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objZigaretten.Commands.cmdrauchen.Custom = true
objZigaretten.Commands.cmdrauchen.Id = "174f998e-111c-4906-955b-ba69540bb476"
objZigaretten.Commands.cmdrauchen.WorksWithAll = true
objZigaretten.Commands.cmdZigarettenwegwerfen.Custom = true
objZigaretten.Commands.cmdZigarettenwegwerfen.Id = "ab29f4d7-a988-49b9-ae92-f4e689b59387"
objZigaretten.Commands.cmdZigarettenwegwerfen.WorksWithAll = false
objZigaretten.Commands.cmdZigarettenwegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objZigaretten.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objZigaretten.Locked = false
objZigaretten.Opened = false
objGlasWhiskey = Wherigo.ZItem(KlausKlabuster)
objGlasWhiskey.Id = "84cd2ac2-6857-4b0c-99d4-9cb118c2fe54"
objGlasWhiskey.Name = "Glas Whiskey"
objGlasWhiskey.Description = ""
objGlasWhiskey.Visible = true
objGlasWhiskey.Media = objWhiskey
objGlasWhiskey.Icon = objicowhiskey
objGlasWhiskey.Commands = {
  cmdWhiskeygeben = Wherigo.ZCommand({
    Text = "Whiskey geben",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Wem willst Du hier den Whiskey geben?"
  }),
  cmdWhiskywegwerfen = Wherigo.ZCommand({
    Text = "Whisky wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objGlasWhiskey.Commands.cmdWhiskeygeben.Custom = true
objGlasWhiskey.Commands.cmdWhiskeygeben.Id = "32d05d34-c200-42f3-b2a1-3f4b4a14c2f4"
objGlasWhiskey.Commands.cmdWhiskeygeben.WorksWithAll = false
objGlasWhiskey.Commands.cmdWhiskeygeben.WorksWithListIds = {
  "9031ebb3-4f1a-472f-aad5-f643c29e5274",
  "93bed8be-3ad3-4561-a8df-dca39cfdcd97",
  "8aec9cae-8d8f-402d-a33b-4f39abd04244",
  "f99cb935-2ed7-49e6-b619-b64b6bac6855",
  "cdd93f24-52b3-4157-9c19-7200c2c3082e",
  "1af2b45f-2999-476a-ba3e-5fb245fa1771",
  "6dc780fa-998d-4830-ac4a-93e6c74cc103",
  "3f98e97e-debd-4370-babf-37b57057dc49",
  "789fc871-a51b-4a78-a0ff-48b7d58e9048",
  "19b0cbe5-6995-4e8f-8243-f4a98c967fcf",
  "3c04bbe7-bf3e-4fc3-adb5-2436b340dc40",
  "575e9d91-729b-4367-899f-6f898b7a8db6",
  "2119a664-659c-4a01-873b-850e80835465",
  "4126aff1-6945-4978-9817-82907db9dce5",
  "68b76555-6ccc-49f6-8155-50f36394e13a",
  "f8c70bb0-8053-4397-b12b-6a8c65ae0c8a",
  "6683526d-d18a-4e40-8859-feac4cb5d309"
}
objGlasWhiskey.Commands.cmdWhiskywegwerfen.Custom = true
objGlasWhiskey.Commands.cmdWhiskywegwerfen.Id = "d565015f-2194-4dc2-8eb4-164d75ae3bb3"
objGlasWhiskey.Commands.cmdWhiskywegwerfen.WorksWithAll = false
objGlasWhiskey.Commands.cmdWhiskywegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objGlasWhiskey.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGlasWhiskey.Locked = false
objGlasWhiskey.Opened = false
objKippe = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = Player})
objKippe.Id = "f5de0937-0795-4c6a-86a7-728836a2864f"
objKippe.Name = "Kippe"
objKippe.Description = ""
objKippe.Visible = false
objKippe.Media = objkippe
objKippe.Icon = objicokippe
objKippe.Commands = {
  cmdKippewegwerfen = Wherigo.ZCommand({
    Text = "Kippe wegwerfen",
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objKippe.Commands.cmdKippewegwerfen.Custom = true
objKippe.Commands.cmdKippewegwerfen.Id = "00091959-6416-4585-bf8b-d85c60ba6d8e"
objKippe.Commands.cmdKippewegwerfen.WorksWithAll = false
objKippe.Commands.cmdKippewegwerfen.WorksWithListIds = {
  "6411ad11-0839-4804-b430-c9058e12ae35",
  "14e91fa0-8c16-412f-9c97-ff24031f83a0",
  "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
}
objKippe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objKippe.Locked = false
objKippe.Opened = false
objMuelleimer = Wherigo.ZItem({Cartridge = KlausKlabuster, Container = zMP})
objMuelleimer.Id = "14e91fa0-8c16-412f-9c97-ff24031f83a0"
objMuelleimer.Name = "Muelleimer"
objMuelleimer.Description = ""
objMuelleimer.Visible = true
objMuelleimer.Media = objmuelleimer
objMuelleimer.Icon = objicomuelleimer
objMuelleimer.Commands = {
  cmdansehen = Wherigo.ZCommand({
    Text = "ansehen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMuelleimer.Commands.cmdansehen.Custom = true
objMuelleimer.Commands.cmdansehen.Id = "210f3095-0117-42c0-b2cc-24c488d30200"
objMuelleimer.Commands.cmdansehen.WorksWithAll = true
objMuelleimer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMuelleimer.Locked = false
objMuelleimer.Opened = false
objaktuelleUmgebung = Wherigo.ZItem(KlausKlabuster)
objaktuelleUmgebung.Id = "ee3b5cc5-efa6-42a3-b146-d92c8ae8a56c"
objaktuelleUmgebung.Name = "aktuelle Umgebung"
objaktuelleUmgebung.Description = ""
objaktuelleUmgebung.Visible = true
objaktuelleUmgebung.Commands = {}
objaktuelleUmgebung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objaktuelleUmgebung.Locked = false
objaktuelleUmgebung.Opened = false
tGM = Wherigo.ZTask(KlausKlabuster)
tGM.Id = "a869d211-89ad-4328-a423-3caf43e167ff"
tGM.Name = "Gehe zum Marktplatz"
tGM.Description = "Gehe zum Spandauer Marktplatz in der Altstadt und stuerze Dich ins Leben."
tGM.Visible = true
tGM.Media = objMarktplatz
tGM.Icon = objicomarktplatz
tGM.Active = true
tGM.Complete = false
tGM.CorrectState = "None"
tFE = Wherigo.ZTask(KlausKlabuster)
tFE.Id = "e68c9f14-4667-47ee-ac38-7be0938b7abd"
tFE.Name = "Finde deine Eva"
tFE.Description = [[
Eva - Ursprung des Lebens, Frau Deiner schlaflosen Naechte.<BR>
Sie ist zum greifen nah. Wenn Du sie findest ...<BR>
.. hast Du bestimmt einige Erfahrungen mit Frauen gesammelt. Lesen hilft zwar, aber nur das Leben bringt dir Praxis!]]
tFE.Visible = true
tFE.Media = objEve
tFE.Icon = objicoeve
tFE.Active = false
tFE.Complete = false
tFE.CorrectState = "None"
tL = Wherigo.ZTask(KlausKlabuster)
tL.Id = "08a96f7a-4f7e-4aa3-b6cc-a54453aaf86c"
tL.Name = "Trage Dich ins Grundbuch ein"
tL.Description = "Wie so oft: was nicht geschrieben ist, ist nicht passiert. Also trage Dich ein."
tL.Visible = false
tL.Media = objgrundbuch
tL.Icon = objicogrundbuch
tL.Active = false
tL.Complete = false
tL.CorrectState = "None"
objvarGeld = 34
iA = 0
objvarBartenderBestellung = false
iTV = 0
objvarOhneGummi = false
iT = 0
iS = 0
bpLS = false
bpLW = false
bpH = false
bpBF = false
bpCR = false
bpED = false
objvarFawn = 0
bHZ = false
bW = false
objvarGefesselt = false
objvarFawnReden = false
objvarGewinn = 0
objvarFalschverbunden = 0
bzKI = false
bzBA = false
bzBI = false
bzCA = false
objvarBoolCasinotoilette = false
objvarBoolDisco = false
bzBF = false
bzHG = false
bzLI = false
objvarBoolMarktplatz = false
objvarBoolKirche = false
objvarBoolToilette = false
bzCI = false
bzBT = false
bzHA = false
bzHL = false
bzHZ = false
bzCK = false
bzLA = false
bzHW = false
objvarBoolHinterzimmer = false
bzDI = false
objvarHunger = 0
objvarDurst = 0
bpEV = false
sI = ""
bKW = false
bHB = false
bStatusGM = false
bStatusFE = false
bStatusL = false
bzF0 = false
bzC = false
objbBartWhisky = false
objbBartBier = false
objbBartWein = false
objbHundCurry = false
objiSpende = 0
objvarBefehlsziel = ""
objbSongF = false
objbSongF1 = false
objbPuppe = false
objbGC1 = false
objbGC2 = false
objbGC7 = false
objbGC6 = false
objbGC3 = false
objbGC5 = false
objbGC4 = false
objbW4 = false
objbW2 = false
objbW1 = false
objbW3 = false
objbPleite = false
bzF1 = false
currentZone = "zMP"
currentCharacter = "objEva"
currentItem = "objRose1"
currentTask = "tGM"
currentInput = "objBestellungBartender"
currentTimer = "objHund2"
KlausKlabuster.ZVariables = {
  objvarGeld = 34,
  iA = 0,
  objvarBartenderBestellung = false,
  iTV = 0,
  objvarOhneGummi = false,
  iT = 0,
  iS = 0,
  bpLS = false,
  bpLW = false,
  bpH = false,
  bpBF = false,
  bpCR = false,
  bpED = false,
  objvarFawn = 0,
  bHZ = false,
  bW = false,
  objvarGefesselt = false,
  objvarFawnReden = false,
  objvarGewinn = 0,
  objvarFalschverbunden = 0,
  bzKI = false,
  bzBA = false,
  bzBI = false,
  bzCA = false,
  objvarBoolCasinotoilette = false,
  objvarBoolDisco = false,
  bzBF = false,
  bzHG = false,
  bzLI = false,
  objvarBoolMarktplatz = false,
  objvarBoolKirche = false,
  objvarBoolToilette = false,
  bzCI = false,
  bzBT = false,
  bzHA = false,
  bzHL = false,
  bzHZ = false,
  bzCK = false,
  bzLA = false,
  bzHW = false,
  objvarBoolHinterzimmer = false,
  bzDI = false,
  objvarHunger = 0,
  objvarDurst = 0,
  bpEV = false,
  sI = "",
  bKW = false,
  bHB = false,
  bStatusGM = false,
  bStatusFE = false,
  bStatusL = false,
  bzF0 = false,
  bzC = false,
  objbBartWhisky = false,
  objbBartBier = false,
  objbBartWein = false,
  objbHundCurry = false,
  objiSpende = 0,
  objvarBefehlsziel = "",
  objbSongF = false,
  objbSongF1 = false,
  objbPuppe = false,
  objbGC1 = false,
  objbGC2 = false,
  objbGC7 = false,
  objbGC6 = false,
  objbGC3 = false,
  objbGC5 = false,
  objbGC4 = false,
  objbW4 = false,
  objbW2 = false,
  objbW1 = false,
  objbW3 = false,
  objbPleite = false,
  bzF1 = false,
  currentZone = "zMP",
  currentCharacter = "objEva",
  currentItem = "objRose1",
  currentTask = "tGM",
  currentInput = "objBestellungBartender",
  currentTimer = "objHund2"
}
objHund2 = Wherigo.ZTimer(KlausKlabuster)
objHund2.Id = "8c527e68-ca80-44b3-97da-84775ee5461d"
objHund2.Name = "Hund"
objHund2.Description = ""
objHund2.Visible = true
objHund2.Duration = 120
objHund2.Type = "Countdown"
objPissen = Wherigo.ZTimer(KlausKlabuster)
objPissen.Id = "54e853ac-da2d-45dd-a7e3-faf336ef33a7"
objPissen.Name = "Pissen"
objPissen.Description = ""
objPissen.Visible = true
objPissen.Duration = 30
objPissen.Type = "Countdown"
objSchlaeger1 = Wherigo.ZTimer(KlausKlabuster)
objSchlaeger1.Id = "58c21499-3061-4092-a5c3-4708d6d519aa"
objSchlaeger1.Name = "Schlaeger"
objSchlaeger1.Description = ""
objSchlaeger1.Visible = true
objSchlaeger1.Duration = 120
objSchlaeger1.Type = "Countdown"
objPruegelei = Wherigo.ZTimer(KlausKlabuster)
objPruegelei.Id = "c0a4c588-8348-44e7-8ae5-724a66d1203a"
objPruegelei.Name = "Pruegelei"
objPruegelei.Description = ""
objPruegelei.Visible = true
objPruegelei.Duration = 60
objPruegelei.Type = "Countdown"
objHunger = Wherigo.ZTimer(KlausKlabuster)
objHunger.Id = "a423c69f-c4bc-4f3e-928e-bed9f899e88e"
objHunger.Name = "Hunger"
objHunger.Description = ""
objHunger.Visible = true
objHunger.Duration = 3600
objHunger.Type = "Countdown"
objDurst = Wherigo.ZTimer(KlausKlabuster)
objDurst.Id = "c97e6ba3-d957-469e-a064-b84db4f6afba"
objDurst.Name = "Durst"
objDurst.Description = ""
objDurst.Visible = true
objDurst.Duration = 2700
objDurst.Type = "Countdown"
objWasser = Wherigo.ZTimer(KlausKlabuster)
objWasser.Id = "48525c8f-8b14-47be-9d54-660de94f3f99"
objWasser.Name = "Wasser"
objWasser.Description = ""
objWasser.Visible = true
objWasser.Duration = 600
objWasser.Type = "Countdown"
objHIV = Wherigo.ZTimer(KlausKlabuster)
objHIV.Id = "e6048ca5-3944-4a51-ab02-67ea573fd4c7"
objHIV.Name = "HIV"
objHIV.Description = ""
objHIV.Visible = true
objHIV.Duration = 600
objHIV.Type = "Countdown"
trPause = Wherigo.ZTimer(KlausKlabuster)
trPause.Id = "a666007a-1b41-4827-9e8d-d11243b5ef8d"
trPause.Name = "Pause"
trPause.Description = ""
trPause.Visible = true
trPause.Duration = 300
trPause.Type = "Countdown"
objBefreien = Wherigo.ZTimer(KlausKlabuster)
objBefreien.Id = "29f23606-cb51-4a1e-a42b-0867c1b135e3"
objBefreien.Name = "Befreien"
objBefreien.Description = ""
objBefreien.Visible = true
objBefreien.Duration = 600
objBefreien.Type = "Countdown"
objBestellungBartender = Wherigo.ZInput(KlausKlabuster)
objBestellungBartender.Id = "995a4d8f-533e-4a21-b429-568f925cc14b"
objBestellungBartender.Name = "Bestellung Bartender"
objBestellungBartender.Description = ""
objBestellungBartender.Visible = true
objBestellungBartender.Media = objBestellung
objBestellungBartender.Choices = {
  "Bier",
  "Wein",
  "Whiskey"
}
objBestellungBartender.InputType = "MultipleChoice"
objBestellungBartender.Text = "Also, was mochtest Du:"
objPasswort = Wherigo.ZInput(KlausKlabuster)
objPasswort.Id = "48eb287c-b820-4f03-8f0c-9bee83b7a470"
objPasswort.Name = "Passwort"
objPasswort.Description = ""
objPasswort.Visible = true
objPasswort.Media = objTuer
objPasswort.Icon = objicoTuer
objPasswort.InputType = "Text"
objPasswort.Text = "Wie ist das Kennwort"
objSpieleinsatz = Wherigo.ZInput(KlausKlabuster)
objSpieleinsatz.Id = "978da3fa-4cbc-4008-a3a6-a56c90ff2ad2"
objSpieleinsatz.Name = "Spieleinsatz"
objSpieleinsatz.Description = ""
objSpieleinsatz.Visible = true
objSpieleinsatz.Media = objSpielautomat
objSpieleinsatz.Icon = objicoSpielautomat
objSpieleinsatz.InputType = "Text"
objSpieleinsatz.Text = "Wieviel willst Du setzen?"
objTelefonnummer = Wherigo.ZInput(KlausKlabuster)
objTelefonnummer.Id = "912a16d3-432e-4572-b4f9-ab9422431974"
objTelefonnummer.Name = "Telefonnummer"
objTelefonnummer.Description = ""
objTelefonnummer.Visible = true
objTelefonnummer.Media = obj24stdshop
objTelefonnummer.Icon = objicoTelefonzelle
objTelefonnummer.InputType = "Text"
objTelefonnummer.Text = "Wen willst Du anrufen?"
objFrage1 = Wherigo.ZInput(KlausKlabuster)
objFrage1.Id = "8c50a79d-c232-4640-a35c-38fdcfecd6ad"
objFrage1.Name = "Frage-1"
objFrage1.Description = ""
objFrage1.Visible = true
objFrage1.Media = objErzaehler
objFrage1.Choices = {
  "... offensiv.",
  "... acceptable.",
  "... repulsive.",
  "... under my bed."
}
objFrage1.InputType = "MultipleChoice"
objFrage1.Text = "I find computer games with adult content ..."
objFrage2 = Wherigo.ZInput(KlausKlabuster)
objFrage2.Id = "63eeb231-1748-4bcb-aa5a-1db7fd55af76"
objFrage2.Name = "Frage-2"
objFrage2.Description = ""
objFrage2.Visible = true
objFrage2.Media = objErzaehler
objFrage2.Choices = {
  "... unchanged.",
  "... eliminated.",
  "... lower.",
  "... higher."
}
objFrage2.InputType = "MultipleChoice"
objFrage2.Text = "Taxes should be ..."
objFrage3 = Wherigo.ZInput(KlausKlabuster)
objFrage3.Id = "7c3de0b7-b9b6-42e3-bf00-9b06729e36a8"
objFrage3.Name = "Frage-3"
objFrage3.Description = ""
objFrage3.Visible = true
objFrage3.Media = objErzaehler
objFrage3.Choices = {
  "... terre-voracic.",
  "... trans-veneral.",
  "... television.",
  "... transvestite."
}
objFrage3.InputType = "MultipleChoice"
objFrage3.Text = "In some personal ads TV stands for ..."
objName = Wherigo.ZInput(KlausKlabuster)
objName.Id = "897015ea-96dc-4304-b492-a9b84d1dc623"
objName.Name = "Name"
objName.Description = ""
objName.Visible = true
objName.Media = objEve
objName.Icon = objicoeve
objName.InputType = "Text"
objName.Text = "Nun, wie heisse ich?"
objGeld1 = Wherigo.ZInput(KlausKlabuster)
objGeld1.Id = "b8c4e408-2100-4720-9d27-53b1c31c932c"
objGeld1.Name = "Geld"
objGeld1.Description = ""
objGeld1.Visible = true
objGeld1.Media = objErzaehler
objGeld1.InputType = "Text"
objGeld1.Text = "Wieviel Geld moechtest Du denn geben?"
objTagebucheintrag = Wherigo.ZInput(KlausKlabuster)
objTagebucheintrag.Id = "874d20a9-3108-4e1d-b9ba-11816e21a47a"
objTagebucheintrag.Name = "Tagebucheintrag"
objTagebucheintrag.Description = ""
objTagebucheintrag.Visible = true
objTagebucheintrag.Media = objNotizbuch
objTagebucheintrag.InputType = "Text"
objTagebucheintrag.Text = "Was willst Du eintragen:"
objRose1.Commands.cmdRosegeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objRose1.Commands.cmdRosewegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objBiographie
}
Whiskey.Commands.cmdWhiskeybestellen.WorksWithList = {
  objBartender1,
  objBlondine,
  objFawn1,
  objCroupier1
}
objFernbedienung1.Commands.cmdFernbedienunggeben.WorksWithList = {
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine,
  objBetrunkene,
  objBartender1,
  Zigarettengirl
}
objFernbedienung1.Commands.cmdFernbedienungwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objPralinen1.Commands.cmdPralinengeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  objPriester1,
  objSchlaeger,
  Polizist,
  objTuersteher,
  Zigarettengirl
}
objPralinen1.Commands.cmdPralinenwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objKondome.Commands.cmdKondomegeben.WorksWithList = {
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objFawn1,
  objKauffrau,
  Zigarettengirl,
  objBartender1,
  objEva,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher
}
objKondome.Commands.cmdKondomewegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objApfel1.Commands.cmdApfelgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objApfel1.Commands.cmdApfelwegwerfen.WorksWithList = {
  zHW,
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objHammer1.Commands.cmdHammergeben.WorksWithList = {
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine,
  objBetrunkene,
  objBartender1
}
objHammer1.Commands.cmdHammerwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objAtemspray1.Commands.cmdSpraygeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEva,
  objFawn1,
  objKauffrau,
  objEmpfangsdame1,
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher
}
objAtemspray1.Commands.cmdSpraywegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objTaschentuch1.Commands.cmdTaschentuchgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objTaschentuch1.Commands.cmdTaschentuchwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objArmbanduhr.Commands.cmdUhrgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objArmbanduhr.Commands.cmdUhrwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
Bier.Commands.cmdBierbestellen.WorksWithList = {
  objBartender1,
  objBlondine,
  objFawn1,
  objCroupier1
}
Wein.Commands.cmdWeinbestellen.WorksWithList = {
  objBartender1,
  objBlondine,
  objFawn1,
  objCroupier1
}
Notizbuch.Commands.cmdeintragen.WorksWithList = {Notizbuch}
objRing1.Commands.cmdRinggeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objKauffrau,
  Landstreicher,
  objFawn1,
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt
}
objRing1.Commands.cmdRingwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objRadio1.Commands.cmdRadiogeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  objHund1,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objDiscopass1.Commands.cmdPassgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objDiscopass1.Commands.cmdPasswegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objSeil1.Commands.cmdSeilgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objSeil1.Commands.cmdSeilwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objPillendose1.Commands.cmdPillengeben.WorksWithList = {
  objEva,
  objBartender1,
  objBetrunkene,
  objBlondine,
  objMonique,
  Landwirt,
  objKauffrau,
  Landstreicher,
  objTuersteher,
  objEmpfangsdame1,
  objFawn1,
  objSchlaeger,
  objCroupier1,
  Zigarettengirl,
  objPriester1,
  Polizist
}
objPillendose1.Commands.cmdPillenwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objMagazin1.Commands.cmdMagazingeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objMagazin1.Commands.cmdMagazinwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objTaschenmesser1.Commands.cmdMessergeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl,
  objSeil1
}
objTaschenmesser1.Commands.cmdMesserwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objFlascheWein.Commands.cmdWeingeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine
}
objFlascheWein.Commands.cmdWeinwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objMobiltelefon1.Commands.cmdMobiltelefongeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objMobiltelefon1.Commands.cmdMobilelefonwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objFilmdose1.Commands.cmdFilmdosewegwerfen.WorksWithList = {objMuelleimer}
objPuppe.Commands.cmdPuppegeben.WorksWithList = {
  Zigarettengirl,
  objSchlaeger,
  objPriester1,
  Polizist,
  objTuersteher,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine,
  objBetrunkene,
  objBartender1
}
objCurrywurst.Commands.cmdWurstgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine,
  objHund1
}
objCurrywurst.Commands.cmdWurstwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objCola.Commands.cmdColageben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objCola.Commands.cmdColawegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objStadtplan.Commands.cmdStadtplanwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objBiographie.Commands.cmdBuchgeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objBiographie.Commands.cmdBuchwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objGeocoin.Commands.cmdGeocCoingeben.WorksWithList = {
  Zigarettengirl,
  objTuersteher,
  objSchlaeger,
  objPriester1,
  Polizist,
  objMonique,
  Landwirt,
  Landstreicher,
  objKauffrau,
  objFawn1,
  objEva,
  objEmpfangsdame1,
  objCroupier1,
  objBlondine,
  objBetrunkene,
  objBartender1,
  objFilmdose1
}
objGeld.Commands.cmdGeldgeben.WorksWithList = {
  objEva,
  objBartender1,
  objBetrunkene,
  objBlondine,
  objMonique,
  objKauffrau,
  Landwirt,
  Landstreicher,
  Polizist,
  objPriester1,
  Zigarettengirl,
  objCroupier1,
  objSchlaeger,
  objFawn1,
  objEmpfangsdame1,
  objTuersteher
}
objZigaretten.Commands.cmdZigarettengeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objZigaretten.Commands.cmdZigarettenwegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objGlasWhiskey.Commands.cmdWhiskeygeben.WorksWithList = {
  objBartender1,
  objBetrunkene,
  objBlondine,
  objCroupier1,
  objEmpfangsdame1,
  objEva,
  objFawn1,
  objKauffrau,
  Landstreicher,
  Landwirt,
  objHund1,
  objMonique,
  Polizist,
  objPriester1,
  objSchlaeger,
  objTuersteher,
  Zigarettengirl
}
objGlasWhiskey.Commands.cmdWhiskywegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
objKippe.Commands.cmdKippewegwerfen.WorksWithList = {
  objAschenbecher1,
  objMuelleimer,
  objaktuelleUmgebung
}
function KlausKlabuster:OnStart()
  Wherigo.PlayAudio(obj_audioTheme)
  _Urwigo.Dialog(false, {
    {
      Text = "Wer kennt ihn nicht - Larry Laffer, den einsamen Helden der achtziger Jahre des letzten Jahrtausends. Staendig auf der Suche nach der Richtigen!",
      Media = objLarry
    },
    {
      Text = [[
Aber wusstest Du auch, dass Larry einen Halbbruder hat!<BR>
Klaus Klabuster, aus Kladow!<BR>
]],
      Media = objKlaus,
      Buttons = {"Na Klar", "Echt?"}
    }
  }, function(action)
    if action == "Button1" then
      _Urwigo.OldDialog({
        {
          Text = [[
Wie, Du kennst Larry und Klaus schon?<BR>
Na dann brauchst Du auch nicht zu spielen!]],
          Media = objErzaehler
        }
      })
      zMP.Active = false
      zMP.Visible = false
      tGM.Active = false
      Wherigo.Command("StopSound")
    else
      _Urwigo.MessageBox({
        Text = ("Ach, " .. Player.Name) .. [[
, Du kennst also Larry und Klaus noch nicht.<BR>
Bist Du denn schon ueber 18?]],
        Media = objErzaehler,
        Buttons = {"Na Klar!", "Na ja ..."},
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" then
              _Urwigo.MessageBox({
                Text = "Dann werden fuer Dich ein paar einfache Fragen sicherlich kein Problem sein!",
                Media = objTeufel,
                Callback = function(action)
                  if action ~= nil then
                    objvarGeld = 0
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(objFrage1)
                    end)
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = "Also unter 18 - und dann mit Klaus das Glueck suchen? Das geht gar nicht!",
                Media = objFSK18
              })
              zMP.Active = false
              zMP.Visible = false
              tGM.Active = false
              zMP.Active = false
              Wherigo.Command("StopSound")
            end
          end
        end
      })
    end
  end)
end
function KlausKlabuster:OnRestore()
end
function zMP:OnEnter()
  currentZone = "zMP"
  _Urwigo.GlobalZoneEnter()
  objHund2:Start()
  if objvarBoolMarktplatz == false then
    _Urwigo.MessageBox({
      Text = "Der Marktplatz von Spandau - gehe los, und finde Dein Glueck!",
      Media = objMarktplatz
    })
    objvarBoolMarktplatz = true
    tGM.Complete = true
    tGM.Name = "Geschafft! Du hast den Marktplatz erreicht!"
    tGM.Active = false
    tFE.Active = true
    tFE.Visible = true
  end
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.5 then
    objCurrywurststand.Visible = false
  else
    objCurrywurststand.Visible = true
  end
  zHG.Active = false
  zBA.Active = true
  zBI.Active = false
  zCA.Active = true
  zCI.Active = false
  zHA.Active = true
  zHL.Active = false
  zHZ.Active = false
  zKA.Active = true
  zKI.Active = false
  zLA.Active = true
  zLI.Active = false
  zDA.Active = true
  zDI.Active = false
end
function zMP:OnExit()
  currentZone = "zMP"
  objHund2:Stop()
  objPissen:Stop()
  Polizist.Visible = false
  Landstreicher.Visible = false
  objCurrywurststand.Visible = false
  if objFilmdose1.Visible == true then
    _Urwigo.MessageBox({
      Text = ("Also wirklich " .. Player.Name) .. [[
, hast Du an der Telefonzelle nicht was vergessen?<BR>
Soll die Dose so liegenbleiben?]],
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "Boeser Bube!",
              Media = objTeufel
            })
          else
            objFilmdose1.Visible = false
            objGeocoin.Visible = false
            _Urwigo.MessageBox({
              Text = "Guter Junge!",
              Media = objEngel
            })
          end
        end
      end
    })
  end
end
function zBA:OnEnter()
  currentZone = "zBA"
  _Urwigo.GlobalZoneEnter()
  zBT.Active = false
  zBF.Active = false
  zMP.Active = true
  zBI.Active = true
  zCA.Active = false
  zHA.Active = false
  zKA.Active = false
  zLA.Active = false
  zDA.Active = false
  objHund2:Start()
  AnzeigePolizist(zBA)
  if bzBA == false then
    bzBA = true
    _Urwigo.MessageBox({
      Text = "Hier soll der Himmel auf Erden sein. Na mal sehen. ",
      Media = objBar,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = [[
Du machst die Tuer auf &nbsp;und siehst erst mal ...<BR>
<BR>
... nichts. Es ist zu dunkel da drinnen. Also rein, oder?]],
            Media = objbardunkel,
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
    TodPolizist()
    _Urwigo.MessageBox({
      Text = [[
Schon witzig, wie Dich dieser Ort anzieht.<BR>
Also rein, oder?]],
      Media = objbardunkel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zBA:OnExit()
  currentZone = "zBA"
  objHund2:Stop()
  objPissen:Stop()
  Polizist.Visible = false
end
function zHA:OnEnter()
  currentZone = "zHA"
  _Urwigo.GlobalZoneEnter()
  zMP.Active = true
  zBA.Active = false
  zKA.Active = false
  zCA.Active = false
  zLA.Active = false
  zDA.Active = false
  zHL.Active = true
  objHund2:Start()
  AnzeigePolizist(zHA)
  AnzeigeLandstreicher(zHA)
  AnzeigeLandwirt(zHA)
  if bzHA == false then
    bzHA = true
    _Urwigo.MessageBox({
      Text = "Du stehst vor dem Hotel Benn. Einem kleinen romantischen Hotel in der Altstadt von Spandau.",
      Media = objHotel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    TodPolizist()
    _Urwigo.MessageBox({
      Text = "Und wieder vor dem Hotel - was ist mit Deiner Traumfrau?",
      Media = objHotel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHA:OnExit()
  currentZone = "zHA"
  objHund2:Stop()
  objPissen:Stop()
  AnzeigePersonenAus()
end
function zKA:Oncmdinfo(target)
  currentZone = "zKA"
  _Urwigo.MessageBox({
    Text = "Die St.-Nikolai-Kirche im Berliner Ortsteil Spandau ist eine dreischiffige gotische Hallenkirche. Erbaut wurde sie im 14. Jahrhundert an der Stelle einer um 1240 als ?ecclesia forensis? (Marktkirche) erstmals urkundlich erwaehnten Vorgangerkirche. Zusammen mit der Nikolaikirche in Berlin-Mitte ist sie eines der wenigen erhaltenen mittelalterlichen Gotteshaeuser aus den Urspruengen der Stadt Berlin.",
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function zKA:OnEnter()
  currentZone = "zKA"
  _Urwigo.GlobalZoneEnter()
  zBA.Active = false
  zBF.Active = false
  zCA.Active = false
  zCT.Active = false
  zCK.Active = false
  zCI.Active = false
  zDA.Active = false
  zDI.Active = false
  zHA.Active = false
  zHL.Active = false
  zLA.Active = false
  zLI.Active = false
  zMP.Active = true
  zKI.Active = true
  objHund2:Start()
  AnzeigePolizist(zKA)
  AnzeigeLandstreicher(zKA)
  if objvarBoolKirche == false then
    objvarBoolKirche = true
    _Urwigo.MessageBox({
      Text = "Du stehst vor St. Nicolai in Spandau.",
      Media = objKirche,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    TodPolizist()
    _Urwigo.MessageBox({
      Text = "Und wieder vor der Kirche - was ist mit Deiner Traumfrau?",
      Media = objKirche,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zKA:OnExit()
  currentZone = "zKA"
  objHund2:Stop()
  objPissen:Stop()
  Polizist.Visible = false
  Landstreicher.Visible = false
end
function zCA:OnEnter()
  currentZone = "zCA"
  _Urwigo.GlobalZoneEnter()
  zBA.Active = false
  zDA.Active = false
  zHA.Active = false
  zLA.Active = false
  zKA.Active = false
  zMP.Active = true
  zCI.Active = true
  zCT.Active = false
  zCK.Active = false
  AnzeigePolizist(zCA)
  AnzeigeLandstreicher(zCA)
  AnzeigeLandwirt(zCA)
  objHund2:Start()
  if bzCA == false then
    bzCA = true
    _Urwigo.MessageBox({
      Text = [[
Das Spandauer Casino.<BR>
Kein Geld fuer die Liebe? Ohne Moos nix Los?<BR>
Dann kann sich hier dein Glueck wenden.]],
      Media = objCasino,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Du stehst wieder vor dem Casino.",
      Media = objCasino,
      Callback = function(action)
        if action ~= nil then
          TodPolizist()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zCA:OnExit()
  currentZone = "zCA"
  objHund2:Stop()
  objPissen:Stop()
  AnzeigePersonenAus()
end
function zBF:OnEnter()
  currentZone = "zBF"
  _Urwigo.GlobalZoneEnter()
  zBA.Active = false
  zBI.Active = true
  zBF.Active = true
  zBK.Active = true
  if bzBF == false then
    bzBF = true
    _Urwigo.MessageBox({
      Text = [[
Aussen hui - Innen &nbsp;pfui. Das ist ja ein deutlicher Kontrast zum Innenraum der Bar. Und vor allem die dekorativ hingeworfene Betrunkene.<BR>
Das Spandauer Brauhaus-Bier ist wohl nichts fur Touristen.]],
      Media = objbarflurbetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Na klasse. Der Touri liegt immer noch hier.<BR>
Du solltest Bart mal Bescheid geben, dass seine Stammkundin Hilfe braucht.]],
      Media = objbarflurbetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zBK:OnEnter()
  currentZone = "zBK"
  _Urwigo.GlobalZoneEnter()
  zBI.Active = false
  zBF.Active = true
  if objvarBoolToilette == false then
    objvarBoolToilette = true
    _Urwigo.MessageBox({
      Text = "Boah - Schlimmer geht immer! Schmierereien nicht nur an den Waenden. Aber wenn Du schon mal hier bist ...",
      Media = objbartoilette,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Ein Fixpunkt in einer sich aendernden Welt. Oder hast Du erwartet, dass hier einer renoviert?",
      Media = objbartoilette,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zBI:OnEnter()
  currentZone = "zBI"
  _Urwigo.GlobalZoneEnter()
  Bier:MoveTo(zBI)
  Whiskey:MoveTo(zBI)
  Wein:MoveTo(zBI)
  zBZ.Active = false
  zBK.Active = false
  zBF.Active = true
  if bKW == false then
    zBT.Active = false
  else
    zBT.Active = true
    zBT.Visible = true
  end
  zBA.Active = true
  zMP.Active = false
  zCA.Active = false
  zKA.Active = false
  zDA.Active = false
  zLA.Active = false
  if bzBI == false then
    bzBI = true
    _Urwigo.MessageBox({
      Text = "Schaurig? Vielleicht. Schummrig? Auf jeden Fall. Du brauchst ein paar Sekunden, bis sich Deine Augen an das Licht gewoehnt haben.",
      Media = objBarraum,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Die Stimmung ist unveraendert. Alle himmeln Blondi an und ignorieren Bart.",
      Media = objBarraum,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zBZ:OnEnter()
  currentZone = "zBZ"
  _Urwigo.GlobalZoneEnter()
  zBI.Active = false
  zBT.Active = true
  if objFenster1.Opened == false then
    zHG.Active = false
  else
    zHG.Active = true
  end
  if objvarBoolHinterzimmer == false then
    objvarBoolHinterzimmer = true
    _Urwigo.MessageBox({
      Text = [[
Ist die hier wirklich das Ziel deiner Traeume?<BR>
Nach Eva sieht sie auf jeden Fall nicht aus.<BR>
Huebsch? Ja! Aber auch etwas fuers Leben?]],
      Media = objbarzimmer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Faszinierend, welche Ausdauer Monique hat.<BR>
Vielleicht ist sie doch die richtige!]],
      Media = objbarzimmer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHG:OnEnter()
  currentZone = "zHG"
  _Urwigo.GlobalZoneEnter()
  objHund2:Start()
  zBT.Active = false
  zBZ.Active = false
  zMP.Active = true
  objSchlaeger1:Stop()
  AnzeigeLandstreicher(zHG)
  if bzHG == false then
    bzHG = true
    _Urwigo.MessageBox({
      Text = "Boa - Spandau mal anders. Nichts wie weg hier.",
      Media = objHinterhof,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Der Hof scheint so weit weg zu sein, dass ihn die BSR wohl nicht auf der Karte hat.",
      Media = objHinterhof,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHG:OnExit()
  currentZone = "zHG"
  objHund2:Stop()
  objPissen:Stop()
  objSchlaeger1:Stop()
  objPruegelei:Stop()
  AnzeigePersonenAus()
end
function zBT:OnEnter()
  currentZone = "zBT"
  _Urwigo.GlobalZoneEnter()
  zBA.Active = false
  zBF.Active = false
  zBI.Active = true
  zHG.Active = false
  zBZ.Active = false
  if bzBT == false then
    bzBT = true
    if objFernseher.Opened == false then
      _Urwigo.MessageBox({
        Text = "Na das sieht hier edel aus. Wohin die Treppe wohl fuehrt? Und was macht der Gorilla hier? Fernsehen wohl nicht.",
        Media = objbartreppenhaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Da. Der Weg ist frei ins Hinterzimmer.",
        Media = objbartreppenhaus,
        Callback = function(action)
          if action ~= nil then
            zBZ.Active = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif objFernseher.Opened == false then
    _Urwigo.MessageBox({
      Text = "Na das sieht hier edel aus. Wohin die Treppe wohl fuehrt? Und was macht der Gorilla hier? Fernsehen wohl nicht.",
      Media = objbartreppenhaus,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Da. Der Weg ist frei ins Hinterzimmer.",
      Media = objbartreppenhaus,
      Callback = function(action)
        if action ~= nil then
          zBZ.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zCI:OnEnter()
  currentZone = "zCI"
  _Urwigo.GlobalZoneEnter()
  Wherigo.PlayAudio(obj_audiocasino)
  Bier:MoveTo(zCI)
  Wein:MoveTo(zCI)
  Whiskey:MoveTo(zCI)
  AnzeigeZigarettengirl(zCI)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.5 then
    objCroupier1.Visible = true
  else
    objCroupier1.Visible = false
  end
  objvarGewinn = 0
  zMP.Active = false
  zCA.Active = true
  zCT.Active = true
  zCK.Active = true
  if bzCI == false then
    bzCI = true
    _Urwigo.MessageBox({
      Text = [[
Die Spielhalle. Oder doch Spielhoelle?<BR>
Auf jeden Fall hoellisch viel Betrieb hier.]],
      Media = objCasinoinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Da regen sich viele auf, sie haetten kein Geld, aber hier ist immer was los!",
      Media = objCasinoinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zCI:OnExit()
  currentZone = "zCI"
  Zigarettengirl.Visible = false
  objCroupier1.Visible = false
end
function zLA:OnEnter()
  currentZone = "zLA"
  _Urwigo.GlobalZoneEnter()
  zBA.Active = false
  zCA.Active = false
  zKA.Active = false
  zDA.Active = false
  zHA.Active = false
  zCA.Active = false
  zMP.Active = true
  zLA.Active = true
  zLI.Active = true
  objHund2:Start()
  AnzeigePolizist(zLA)
  AnzeigeLandstreicher(zLA)
  AnzeigeLandwirt(zLA)
  if bzLA == false then
    bzLA = true
    _Urwigo.MessageBox({
      Text = [[
Du stehst vor dem Lieblingsausstatter der oertlichen Gourmets und Gourmonds.<BR>
Wie von Zauberhand oeffnet sich die Ladentuer.]],
      Media = objKaisers
    })
  else
    _Urwigo.MessageBox({
      Text = "Du stehst wieder vor dem Spandauer Genusstempel.",
      Media = objKaisers,
      Callback = function(action)
        if action ~= nil then
          TodPolizist()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zLA:OnExit()
  currentZone = "zLA"
  objHund2:Stop()
  objPissen:Stop()
  AnzeigePersonenAus()
end
function zLI:OnEnter()
  currentZone = "zLI"
  _Urwigo.GlobalZoneEnter()
  zMP.Active = false
  zLA.Active = true
  if bzLI == false then
    bzLI = true
    _Urwigo.MessageBox({
      Text = [[
Du steht in einem blitzblank aufgeraeumten kleinen Verkaufsraum.<BR>
Nett aussehendes Personal laechelt Dich an. Ein Traum.]],
      Media = objKaisersinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Ui. Der Verkaufsraum sieht schon reichlich leer aus.<BR>
Wochenendeinkaeufe scheinen hier ueblich zu sein.]],
      Media = objKaisersinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zLI:OnExit()
  currentZone = "zLI"
  sI = "gut"
  if Player:Contains(objKondome) and objKondome.Locked == true then
    sI = "Haltet den Dieb. Der klaut Kondome!"
    objKondome:MoveTo(zLI)
  elseif Player:Contains(objFlascheWein) and objFlascheWein.Locked == true then
    sI = "Haltet den Dieb. Der klaut eine Flasche Wein!"
    objFlascheWein:MoveTo(zLI)
  elseif Player:Contains(objBiographie) and objBiographie.Locked == true then
    sI = "Haltet den Dieb. Der klaut ein Buch!"
    objBiographie:MoveTo(zLI)
  elseif Player:Contains(objMagazin1) and objMagazin1.Locked == true then
    sI = "Haltet den Dieb. Der klaut ein Magazin!"
    objMagazin1:MoveTo(zLI)
  end
  if Wherigo.NoCaseEquals(sI, "gut") then
  else
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.Dialog(false, {
      {Text = sI, Media = objVerkaeuferin},
      {
        Text = [[
Wusste ich es doch, dass Du ein schraeger Vogel bist!<BR>
Das war's!]],
        Media = objPolizist
      },
      {
        Text = "Oh je. Ich denke, Du suchst Dir auf dem Marktplatz eine Bank und machst mal 5min Pause!",
        Media = objEngel
      }
    }, function(action)
      Spielende()
      trPause:Start()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function zDA:OnEnter()
  currentZone = "zDA"
  _Urwigo.GlobalZoneEnter()
  Wherigo.PlayAudio(obj_audiodisco)
  zBA.Active = false
  zHA.Active = false
  zLA.Active = false
  zCA.Active = false
  zKA.Active = false
  zMP.Active = true
  zDA.Active = true
  objHund2:Start()
  AnzeigePolizist(zDA)
  if Player:Contains(objDiscopass1) then
    zDI.Active = true
  else
    zDI.Active = false
  end
  if objvarBoolDisco == false then
    objvarBoolDisco = true
    _Urwigo.MessageBox({
      Text = "Du stehst vor der Spandauer Edeldisco. Eine massive Tuer daemmt deutlich Deine Lieblingsmusik, waehrend ein massiver Tuersteher Deinem Verlangen einen Daempfer versetzt.",
      Media = objDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objDiscopass1.Opened == true then
    _Urwigo.MessageBox({
      Text = "Wahnsinn. Immer noch die laute Musik - scheint keinen zu interessieren!",
      Media = objDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Wahnsinn. Immer noch die laute Musik - scheint keinen zu interessieren!<BR>
Und immer noch der Gorilla. Dass der keine Pause braucht.]],
      Media = objDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zDA:OnExit()
  currentZone = "zDA"
  objHund2:Stop()
  objPissen:Stop()
  Polizist.Visible = false
end
function zDI:OnEnter()
  currentZone = "zDI"
  _Urwigo.GlobalZoneEnter()
  Bier:MoveTo(zDI)
  Wein:MoveTo(zDI)
  Whiskey:MoveTo(zDI)
  zMP.Active = false
  zDA.Active = true
  zDI.Active = true
  if objDiscopass1.Opened == true then
  else
    objDiscopass1.Opened = true
    _Urwigo.OldDialog({
      {
        Text = "Geschlossene Gesellschaft. Nur fuer VIPs. Wie ich sagte - nichts fuer Dich!",
        Media = objTursteherDisco
      },
      {
        Text = "Na - das glaube ich nicht: Schau Dir mal diesen VIP-Pass an!",
        Media = objDiscopass
      },
      {
        Text = [[
Das ist nun wirklich eine Uerberraschung. Typen kennt der Boss. Unglaublich!<BR>
Dann mal hereinspaziert.]],
        Media = objTursteherDisco
      }
    })
  end
  if bzDI == false then
    bzDI = true
    _Urwigo.MessageBox({
      Text = "Die Tanzflaeche - schummriges Lift, wummernde Baesse, heisse Koerper im Rhythmus der Nacht. Und mitten drin - wie das Licht fuer die Motten - ein blauer Engel.",
      Media = objDisocinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Der Rhythmus, bei dem Mann mit muss!",
      Media = objDisocinnen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHL:OnEnter()
  currentZone = "zHL"
  _Urwigo.GlobalZoneEnter()
  zMP.Active = false
  zHA.Active = true
  zHZ.Active = true
  if zHL:Contains(objEmpfangsdame1) and Player:Contains(objRadio1) then
    _Urwigo.OldDialog({
      {
        Text = "Hey - Du da",
        Media = objEmpfangsdame
      },
      {Text = "Wer? Ich?", Media = objKlaus},
      {
        Text = [[
Ja, Du, mit der dicken Hose!<BR>
Das sieht nicht natuerlich aus. Und das Brummen passt auch nicht.]],
        Media = objEmpfangsdame
      }
    })
  end
  if objEmpfangsdame1:Contains(objPillendose1) then
    zHW.Active = true
  else
    zHW.Active = false
  end
  if bzHL == false then
    bzHL = true
    _Urwigo.MessageBox({
      Text = "Du stehst in der Lobby. Eine bezaubernde Empfangsdame laechelt Dich an.",
      Media = objRezeption,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Ah - der Drachen am Empfang scheint verschwunden zu sein. Der Weg in den Wellnessbereich sollte frei sein!",
      Media = objRezeption,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHZ:OnEnter()
  currentZone = "zHZ"
  _Urwigo.GlobalZoneEnter()
  zHA.Active = false
  zHW.Active = false
  zHL.Active = true
  if bzHZ == false then
    bzHZ = true
    _Urwigo.MessageBox({
      Text = [[
Die Hochzeitssuite - kaum zu glauben, dass Du kurz vor dem Ziel Deiner Traeume bist.<BR>
Ob hier die Frau Deiner Traeume ist?.]],
      Media = objHotelzimmer,
      Callback = function(action)
        if action ~= nil and zHZ:Contains(objFawn1) then
          _Urwigo.MessageBox({
            Text = [[
Wo bleibst Du denn so lange - ich warte schon sehnsuechtig!<BR>
Dich zu kuessen ...]],
            Media = objFawn,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  elseif zHZ:Contains(objFawn1) then
    _Urwigo.MessageBox({
      Text = [[
Wo bleibst Du denn so lange - ich warte schon sehnsuechtig!<BR>
Dich zu kuessen ...]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Ob jetzt die Frau Deiner Traeume da ist?",
      Media = objHotelzimmer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zHW:OnEnter()
  currentZone = "zHW"
  _Urwigo.GlobalZoneEnter()
  zHA.Active = false
  zHZ.Active = false
  zHL.Active = true
  if bzHW == false then
    bzHW = true
    _Urwigo.MessageBox({
      Text = [[
Der Wellnessbereiche - eine Oase der Ruhe und Entspannung ueber den Daechern von Spandau.<BR>
Wo ist wohl das zauberhafte Wesen?]],
      Media = objWellnessbereich,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Endlich wieder bei Eva - ob sie noch da ist?",
      Media = objWellnessbereich,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zF0:OnEnter()
  currentZone = "zF0"
  _Urwigo.GlobalZoneEnter()
  zFC.Active = true
  zF1.Active = false
  if objbSongF == false then
    objbSongF = true
    Wherigo.PlayAudio(obj_audiorefrain)
    _Urwigo.MessageBox({
      Text = "Nur noch wenige Schritte bis zum Ziel",
      Media = objseeblick,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zKI:OnEnter()
  currentZone = "zKI"
  _Urwigo.GlobalZoneEnter()
  zMP.Active = false
  if bzKI == false then
    bzKI = true
    _Urwigo.MessageBox({
      Text = "Der Altarraum der St. Nicolai-Kirche. Der Eintritt zum Himmel.",
      Media = objAltarraum,
      Callback = function(action)
        if action ~= nil and zKI:Contains(objFawn1) then
          _Urwigo.MessageBox({
            Text = "Dein Glueck scheint sich zu wenden, Fawn steht neben dem Priester und wartet auf Dich.",
            Media = objErzaehler,
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
      Text = "Und wieder der Altarraum der St. Nicolai-Kirche. Ob es jetzt mit Deiner Hochzeit und Traumfrau klappt?",
      Media = objAltarraum,
      Callback = function(action)
        if action ~= nil and zKI:Contains(objFawn1) then
          _Urwigo.MessageBox({
            Text = "Dein Glueck scheint sich zu wenden, Fawn steht neben dem Priester und wartet auf Dich.",
            Media = objErzaehler,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  end
end
function zCT:OnEnter()
  currentZone = "zCT"
  _Urwigo.GlobalZoneEnter()
  Wherigo.PlayAudio(obj_audiotoilettenmusic)
  zMP.Active = false
  zCA.Active = false
  zCK.Active = false
  if objvarBoolCasinotoilette == false then
    objvarBoolCasinotoilette = true
    _Urwigo.MessageBox({
      Text = [[
Wow. Welch ein Ort. Reich und Verschwenderisch.<BR>
Wie Dein Leben.]],
      Media = objCasinitoilette,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Wow.<BR>
Hier kommt die Putzfrau wohl stuendlich!]],
      Media = objCasinitoilette,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zCK:OnEnter()
  currentZone = "zCK"
  _Urwigo.GlobalZoneEnter()
  zMP.Active = false
  zCA.Active = false
  zCT.Active = false
  zCI.Active = true
  if objbPleite == true then
    if Player:Contains(objTaschentuch1) then
      objTaschentuch1:MoveTo(Zigarettengirl)
      _Urwigo.MessageBox({
        Text = [[
Ich habe gehoert, Du bist Pleite? Das ist Schade.<BR>
Aber - ich habe eine Idee: Du hast da ein Taschentuch. Mein Bruder muss morgen seine Bundeswehrausruestung vorzeigen und ihm fehlt eins.<BR>
Ich gebe Dir 10 Euro dafuer ...]],
        Media = objZigarettengirl,
        Buttons = {"Super", "Nein"}
      })
    elseif Player:Contains(objArmbanduhr) then
      objTaschentuch1:MoveTo(objArmbanduhr)
      _Urwigo.MessageBox({
        Text = [[
Ich habe gehoert, Du bist Pleite? Das ist Schade.<BR>
Aber ich habe eine Idee: Du hast da eine Armbanduhr. Mein Neffe ist ganz verrueckt nach Micky Maus.<BR>
Ich gebe Dir 10 Euro dafuer ...]],
        Buttons = {"Super", "Nein"}
      })
    else
      _Urwigo.MessageBox({
        Text = [[
Meine Kollegin sagte mir, Du brauchst Hilfe.<BR>
Ich auch. Ich suche ein Bundeswehrtaschentuch fuer meinen Bruder bzw. eine witzige Uhr fuer meinen Neffen.<BR>
Aber ich sehe gerade, Du kannst mir auch nicht helfen.<BR>
Schade.<BR>
Aber fuer Deine Hilfsbereitschaft schenke ich Dir 10 Euro.]],
        Media = objZigarettengirl
      })
    end
    objvarGeld = 10
    objbPleite = false
    objGeld.Description = "Du hast 10 Euro"
  end
  AnzeigeZigarettengirl(zCK)
  if bzCK == false then
    Wherigo.PlayAudio(obj_audioshow)
    bzCK = true
    _Urwigo.Dialog(false, {
      {
        Text = [[
Ein schummriger Keller - Licht aus - Spot an.<BR>
<BR>
Die Show beginnt.]],
        Media = objshow
      },
      {
        Text = [[
Eieiei - was fuer ein Anblick.<BR>
<BR>
Da kann Mann das Gleichgewicht verlieren.]],
        Media = objpoledance
      },
      {
        Text = [[
Und es werden mehr!<BR>
<BR>
Ob der Staubwedel auch zum Putzen geeignet ist?<BR>
Das waere eine Frage wert.]],
        Media = objshow1
      },
      {
        Text = "Aber diese Truppe wuerde wohl eher Staub aufwirbeln als ihn beseitigen.",
        Media = objshow2
      },
      {
        Text = [[
Endlich! Dita.<BR>
<BR>
Die ungekroente Koenigin der Nacht.<BR>
Fantastisch, was sie mit Champagner macht.]],
        Media = objshow3
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = "Die Vorstellung ist leider vorbei fuer heute. Komm ein anderes Mal wieder.",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zCK:OnExit()
  currentZone = "zCK"
  Zigarettengirl.Visible = false
end
function zFC:OnEnter()
  currentZone = "zFC"
  _Urwigo.GlobalZoneEnter()
  zF0.Active = false
  Wherigo.PlayAudio(obj_audioTusch)
  objEva.Description = [[
Da ist sie - die Frau Deiner Traeume. Das zauberhafte Wesen, dass Du nur schemenhaft durch die Glastuer erkennen konntest.<BR>
Jetzt gehoert ihr zusammen.]]
  objSpoiler1.Visible = true
  tL.Complete = true
  tL.Name = "Geschafft! Du hast Eva und ihr Haus erreicht!"
  KlausKlabuster.Complete = true
  objFreischaltcode.Description = (("Gratulation " .. Player.Name) .. ", Dein Freischaltcode ist<BR>\n") .. string.sub(Player.CompletionCode, 1, 15)
  objFreischaltcode.Visible = true
  KlausKlabuster:RequestSync()
  _Urwigo.Dialog(false, {
    {
      Text = "Endlich! Was habe ich auf Dich gewartet!",
      Media = objEve
    },
    {
      Text = [[
Das Buch liegt vor Dir.<BR>
Greife zu und trage Dich ein.]],
      Media = objgrundbuch
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function zF1:OnEnter()
  currentZone = "zF1"
  _Urwigo.GlobalZoneEnter()
  zF0.Visible = true
  if objbSongF == false then
    objbSongF = true
    Wherigo.PlayAudio(obj_audiovorFinal)
  end
end
function objBestellungBartender:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Whiskey") then
    objbBartWhisky = true
    _Urwigo.MessageBox({
      Text = [[
Nach Glendronagh, 15 Jahre, sieht das nun definitiv nicht aus. Und der Geruch erst.<BR>
Na den steck ich doch lieber ein fuer schlechte - ganz schlechte Zeiten.]],
      Media = objWhiskey,
      Callback = function(action)
        if action ~= nil then
          objGlasWhiskey:MoveTo(Player)
          objvarGeld = objvarGeld + -5
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "Wein") then
    objbBartWein = true
    _Urwigo.MessageBox({
      Text = "Oh. Ein 2010 Chateau Nierentritt, Nordhang. Soll ja gut gegen Herzprobleme sein.",
      Media = objWeinglass,
      Callback = function(action)
        if action ~= nil then
          Wherigo.PlayAudio(obj_audiotrinken)
          objvarGeld = objvarGeld + -5
          objDurst:Stop()
          objvarDurst = 0
          objDurst:Start()
        end
      end
    })
  else
    objbBartBier = true
    _Urwigo.MessageBox({
      Text = "Ahhhh. Das gute Spandauer Brauhaus-Bier. Endlich nicht mehr unterhopft.",
      Media = objBierglass,
      Callback = function(action)
        if action ~= nil then
          objvarGeld = objvarGeld + -5
          Wherigo.PlayAudio(obj_audiotrinken)
          objDurst:Stop()
          objvarDurst = 0
          objDurst:Start()
        end
      end
    })
  end
  objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
end
function objPasswort:OnGetInput(input)
  if input == nil then
    input = ""
  end
  sI = input
  if Wherigo.NoCaseEquals(sI, "TMZ SCHICKT MICH") then
    zBT.Active = true
    zBT.Visible = true
    bKW = true
    Wherigo.PlayAudio(obj_audioFenster)
    _Urwigo.MessageBox({
      Text = ("Oh, Entschuldigung " .. Player.Name) .. [[
. Ich hatte Sie nicht erkannt.<BR>
Und jetzt hereinspaziert - auch wenn es unsichtbar erscheint - hier ist Leben in der Bude!]],
      Media = objTuer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Das war wohl nix. Is halt nur fuer Privat!<BR>
Und jetzt gewinn' Land!]],
      Media = objTuer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objSpieleinsatz:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = Player.Name .. ", was ist bei der Eingabe von Zahlen so schwer?",
      Media = objErzaehler
    })
    return
  end
  iS = input
  if iS > objvarGeld then
    _Urwigo.MessageBox({
      Text = "Oha - so viel Geld hast Du nicht mehr!",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif iS == 0 then
    _Urwigo.MessageBox({
      Text = "Spassvogel",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif iT == 2 then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.75 then
      objvarGeld = objvarGeld + iS * 3
      objvarGewinn = objvarGewinn + iS * 3
      Wherigo.PlayAudio(obj_audiowin)
      _Urwigo.MessageBox({Text = "gewonnen", Media = objgewonnen})
    else
      objvarGeld = objvarGeld - iS
      objvarGewinn = objvarGewinn - iS
      Wherigo.PlayAudio(obj_audioloose)
      _Urwigo.MessageBox({
        Text = "verloren",
        Media = objverloren,
        Callback = function(action)
          if action ~= nil and objvarGeld <= 0 then
            objbPleite = true
            _Urwigo.MessageBox({
              Text = ("Oha " .. Player.Name) .. "! Du bist pleite! Das wars dann wohl. Leider verloren. Und zwar richtig!",
              Media = objErzaehler,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = [[
Nicht ganz - ich habe da eine Idee!<BR>
Geh mal ins Kabarett...]],
                    Media = objCroupier,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                end
              end
            })
          end
        end
      })
    end
  elseif iT == 1 then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.666666666666667 then
      objvarGeld = objvarGeld + iS * 2
      objvarGewinn = objvarGewinn + iS * 2
      Wherigo.PlayAudio(obj_audiowin)
      _Urwigo.MessageBox({Text = "gewonnen", Media = objgewonnen})
    else
      objvarGeld = objvarGeld - iS
      objvarGewinn = objvarGeld - iS
      Wherigo.PlayAudio(obj_audioloose)
      _Urwigo.MessageBox({
        Text = "verloren",
        Media = objverloren,
        Callback = function(action)
          if action ~= nil and objvarGeld <= 0 then
            objbPleite = true
            _Urwigo.MessageBox({
              Text = ("Oha " .. Player.Name) .. "! Du bist pleite! Das wars dann wohl. Leider verloren. Und zwar richtig!",
              Media = objErzaehler,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = [[
Nicht ganz - ich habe da eine Idee!<BR>
Geh mal ins Kabarett...]],
                    Media = objCroupier,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                end
              end
            })
          end
        end
      })
    end
  elseif iT == 0 then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.5 then
      objvarGeld = objvarGeld + iS
      objvarGewinn = objvarGewinn + iS
      Wherigo.PlayAudio(obj_audiowin)
      _Urwigo.MessageBox({Text = "gewonnen", Media = objgewonnen})
    else
      objvarGeld = objvarGeld - iS
      objvarGewinn = objvarGewinn - iS
      Wherigo.PlayAudio(obj_audioloose)
      _Urwigo.MessageBox({
        Text = "verloren",
        Media = objverloren,
        Callback = function(action)
          if action ~= nil and objvarGeld <= 0 then
            objbPleite = true
            _Urwigo.MessageBox({
              Text = ("Oha " .. Player.Name) .. "! Du bist pleite! Das wars dann wohl. Leider verloren. Und zwar richtig!",
              Media = objErzaehler,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = [[
Nicht ganz - ich habe da eine Idee!<BR>
Geh mal ins Kabarett...]],
                    Media = objCroupier,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                end
              end
            })
          end
        end
      })
    end
  end
  objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
end
function objTelefonnummer:OnGetInput(input)
  if input == nil then
    input = ""
  end
  sI = input
  if Wherigo.NoCaseEquals(sI, "08004711") then
    _Urwigo.Dialog(false, {
      {
        Text = [[
Halli Hallo Halloele<BR>
Ringeling<BR>
hier ist der 24-Std Shopping Mann<BR>
Der alles tun kann]],
        Media = obj24stdshop
      },
      {
        Text = "Was kann ich tun?",
        Media = obj24stdshop
      },
      {
        Text = "Ich brauch dringend eine Flasche Wein",
        Media = objKlaus
      },
      {
        Text = [[
Daran soll es nicht scheitern!<BR>
Wohin denn?]],
        Media = obj24stdshop
      },
      {
        Text = "Berlin-Spandau, Altsdtadt - Hotel Benn, die Hochzeitssuite",
        Media = objKlaus
      },
      {
        Text = [[
Ahhh - Ohhh. Dann erhaelst Du unseren Sonderrabatt.<BR>
Aber Fussgaengerzone kostet leider extra.<BR>
Das macht dann 55 Euro!]],
        Media = obj24stdshop
      }
    }, function(action)
      if objvarGeld > 55 then
        objvarGeld = objvarGeld + -55
        bW = true
        _Urwigo.MessageBox({
          Text = "Perfekt!",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Okay - dann muss ich kurz noch mal weg und rufe spaeter noch mal an.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif Wherigo.NoCaseEquals(sI, "01723939563") or Wherigo.NoCaseEquals(sI, "112") then
    Wherigo.PlayAudio(obj_audiobesetzt)
    _Urwigo.MessageBox({
      Text = "Besetzt - probiere es spaeter noch mal.",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(sI, "110") then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.142857142857143 then
      if objbGC1 == false then
        objbGC1 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC5FC5T - Zombiehunter NC]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code GC5FC5T erhalten und muessen nach Kladow.<BR>
Dort sollen Zombies gesichtet worden sein.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.285714285714286 then
      if objbGC2 == false then
        objbGC2 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC584NG - Agent Karl Toffel]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code GC584NG erhalten und muessen nach Kladow.<BR>
Agent Karl Toffel braucht Hilfe.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.428571428571429 then
      if objbGC3 == false then
        objbGC3 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC53X9T7 - Kaufdorf]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code &nbsp;GC3X9T7 erhalten und muessen nach Elstal.<BR>
Im Kaufdorf sind Randalierer.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.571428571428571 then
      if objbGC4 == false then
        objbGC4 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC3C36A - Der verlassene Friedhof]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code GC3C36A erhalten und muessen nach Staaken.<BR>
In der Naehe vom verlassenen Friedhof sind Kinder verschwunden.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.714285714285714 then
      if objbGC5 == false then
        objbGC5 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC5K5WB - rettet die Million]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code GC5K5WB erhalten und muessen nach Spandau.<BR>
Dort ist eine Million zu retten.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif _rndChoiceValue < 0.857142857142857 then
      if objbGC6 == false then
        objbGC6 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC4ZRQE - Jagd auf Z]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code &nbsp;GC4ZRQE erhalten und ich muss mich konzentrieren.<BR>
Z wurde gesichtet und k-zuse braucht Hilfe.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      if objbGC7 == false then
        objbGC7 = true
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
GC4432N - Nighttrain NC]]
      end
      _Urwigo.MessageBox({
        Text = [[
Du? Stoer nicht. Wir haben gerade den Code GC4432N erhalten und muessen nach Priort.<BR>
Dort in der Naehe soll der Nachtzug ueberfallen werden.]],
        Media = objZentrale,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(sI, "32168") then
    Wherigo.PlayAudio(obj_audiotelefonsex)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    Wherigo.PlayAudio(obj_audiokeinanschluss)
    objvarFalschverbunden = objvarFalschverbunden + 1
    if objvarFalschverbunden > 10 then
      _Urwigo.MessageBox({
        Text = [[
So wird das nichts.<BR>
Die Nummer in Deinem Kopf sollten schon was mit Telefonieren zu tun haben!]],
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end
end
function objFrage1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "... acceptable.") then
    _Urwigo.MessageBox({
      Text = "Richtig",
      Media = objTeufel,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage2)
          end)
        end
      end
    })
  else
    objvarGeld = objvarGeld + 1
    _Urwigo.MessageBox({
      Text = ("Aiaiaiaiai, " .. Player.Name) .. [[
. Das war Falsch!<BR>
Aufpassen, jetzt gehts es ums Ganze.]],
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage2)
          end)
        end
      end
    })
  end
end
function objFrage2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "... lower.") then
    _Urwigo.MessageBox({
      Text = "Richtig",
      Media = objTeufel,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objFrage3)
          end)
        end
      end
    })
  else
    objvarGeld = objvarGeld + 1
    if objvarGeld == 2 then
      _Urwigo.MessageBox({
        Text = ("Autsch, " .. Player.Name) .. [[
. Das war wieder Falsch!<BR>
Du bist wohl doch keine 18!]],
        Media = objEngel,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "Schade!",
              Media = objTeufel,
              Callback = function(action)
                if action ~= nil then
                  zMP.Active = false
                  zMP.Visible = false
                  tGM.Active = false
                  Wherigo.Command("StopSound")
                end
              end
            })
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = ("Aiaiaiaiai, " .. Player.Name) .. [[
. Das war Falsch!<BR>
Aufpassen, jetzt gehts es ums Ganze.]],
        Media = objEngel,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(objFrage3)
            end)
          end
        end
      })
    end
  end
end
function objFrage3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "... transvestite.") then
    _Urwigo.MessageBox({
      Text = "Richtig",
      Media = objTeufel,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = [[
Jetzt aber los - Klaus wartet schon.<BR>
Viel Spass in Spandau!]],
            Media = objErzaehler,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Aber schoen artig bleiben!",
                  Media = objTeufel,
                  Callback = function(action)
                    if action ~= nil then
                      objvarGeld = 34
                    end
                  end
                })
              end
            end
          })
        end
      end
    })
  else
    objvarGeld = objvarGeld + 1
    if objvarGeld == 2 then
      _Urwigo.MessageBox({
        Text = ("Autsch, " .. Player.Name) .. [[
. Das war wieder Falsch!<BR>
Du bist wohl doch keine 18!]],
        Media = objEngel,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "Schade!",
              Media = objTeufel,
              Callback = function(action)
                if action ~= nil then
                  zMP.Active = false
                  zMP.Visible = false
                  tGM.Active = false
                  Wherigo.Command("StopSound")
                end
              end
            })
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = ("Aiaiaiaiai, " .. Player.Name) .. [[
. Das war Falsch!<BR>
Aber ein Fehlschuss ist erlaubt!]],
        Media = objEngel,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = [[
Jetzt aber los - Klaus wartet schon.<BR>
Viel Spass in Spandau!]],
              Media = objErzaehler,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = "Aber schoen artig bleiben!",
                    Media = objTeufel,
                    Callback = function(action)
                      if action ~= nil then
                        objvarGeld = 34
                      end
                    end
                  })
                end
              end
            })
          end
        end
      })
    end
  end
end
function objName:OnGetInput(input)
  if input == nil then
    input = ""
  end
  sI = input
  if Wherigo.NoCaseEquals(sI, "Eva") then
    _Urwigo.MessageBox({
      Text = "Oh! Ich glaube, mit uns koennte das was werden!",
      Media = objEve
    })
  else
    _Urwigo.MessageBox({
      Text = "Schade, so wird das nichts mit uns!",
      Media = objEve
    })
  end
end
function objGeld1:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Es kann doch so schwer sein, eine Zahl einzugeben!",
      Media = objErzaehler
    })
    return
  end
  objiSpende = input
  if objiSpende < objvarGeld then
    objvarGeld = objvarGeld - objiSpende
    objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
    if Wherigo.NoCaseEquals(objvarBefehlsziel, "Croupier") or Wherigo.NoCaseEquals(objvarBefehlsziel, "Zigarettengirl") then
      if objiSpende > 10 then
        if iT == 0 then
          iT = 1
        else
          iT = 2
        end
        if Wherigo.NoCaseEquals(objvarBefehlsziel, "Croupier") then
          _Urwigo.MessageBox({
            Text = [[
Ich weiss zwar nicht warum, aber vielen Dank. Komm mal naeher, ich habe einen Tipp fuer Dich ...<BR>
Weisst Du, der Spielautomat, da kannst Du ...]],
            Media = objCroupier,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Zigarettengirl") then
          _Urwigo.MessageBox({
            Text = [[
Ich weiss zwar nicht warum, aber vielen Dank. Komm mal naeher, ich habe einen Tipp fuer Dich ...<BR>
Weisst Du, der Spielautomat, da kannst Du ...]],
            Media = objZigarettengirl,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Der Spielautomat hat ein Problem bei Tilt]]
      elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Croupier") then
        _Urwigo.MessageBox({
          Text = "Danke fuer das Trinkgeld - aber ich haette schon gedacht, dass mein Service besser ist!",
          Media = objCroupier,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Zigarettengirl") then
        _Urwigo.MessageBox({
          Text = "Danke fuer das Trinkgeld - aber ich haette schon gedacht, dass mein Service besser ist!",
          Media = objZigarettengirl,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Landwirt") then
      if objiSpende > 10 then
        _Urwigo.MessageBox({
          Text = [[
Ui - Du bist ja grosszuegig!<BR>
Da moechte ich mich gerne revanchieren:<BR>
]],
          Media = objLandwirt,
          Callback = function(action)
            if action ~= nil then
              if Player:Contains(objApfel1) then
                _Urwigo.MessageBox({
                  Text = "Ich sehe, Du hast schon einen Apfel - dann pass auf, dass Du ihn der richtigen gibst!",
                  Media = objLandwirt,
                  Callback = function(action)
                    if action ~= nil then
                      Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Der Apfel ist fuer die Traumfrau]]
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              else
                _Urwigo.MessageBox({
                  Text = "Nimm bitte diesen Apfel!",
                  Media = objLandwirt,
                  Callback = function(action)
                    if action ~= nil then
                      objApfel1:MoveTo(Player)
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              end
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Herzlichen Dank fuer Deine milde Gabe!",
          Media = objLandwirt,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Landstreicher") then
      if objiSpende > 10 then
        _Urwigo.MessageBox({
          Text = [[
Ui - Du bist ja grosszuegig!<BR>
Da moechte ich mich gerne revanchieren:<BR>
]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              if Player:Contains(objTaschenmesser1) then
                _Urwigo.MessageBox({
                  Text = [[
Ich sehe, Du hast schon ein Taschenmesser - dann pass gut darauf auf, dass Du in einer verstrickten Situation Dich auch befreien kannst!<BR>
Frauen koennen einen Mann auf viele Arten fesseln. Und wer weiss, wozu Du dann ein Seil noch brauchen kannst.]],
                  Media = objLandstreicher,
                  Callback = function(action)
                    if action ~= nil then
                      Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Taschenmesser ist wichtig]]
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              else
                _Urwigo.MessageBox({
                  Text = "Nimm bitte dieses Taschenmesser!",
                  Media = objLandstreicher,
                  Callback = function(action)
                    if action ~= nil then
                      objTaschenmesser1:MoveTo(Player)
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              end
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Herzlichen Dank fuer Deine milde Gabe!",
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    elseif Wherigo.NoCaseEquals(objvarBefehlsziel, "Monique") then
      if objiSpende > 30 then
        _Urwigo.Dialog(false, {
          {
            Text = "Na Du weisst ja, was Du willst!",
            Media = objHure
          },
          {
            Text = "Dann komm mal her!",
            Media = objHure
          }
        }, function(action)
          if Player:Contains(objKondome) then
            _Urwigo.MessageBox({
              Text = "dann",
              Media = objKlaus,
              Buttons = {"mit", "ohne"},
              Callback = function(action)
                if action ~= nil then
                  Wherigo.PlayAudio(obj_audiobolero)
                  objKondome:MoveTo(zLI)
                  _Urwigo.MessageBox({
                    Text = ("Na, " .. Player.Name) .. ", dann entspann' Dich mal!",
                    Media = objHure,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.PlayAudio(obj_audiofemalorgasm)
                        _Urwigo.MessageBox({
                          Text = "",
                          Media = objXXX,
                          Callback = function(action)
                            if action ~= nil then
                              Wherigo.Command("StopSound")
                              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                            end
                          end
                        })
                      end
                    end
                  })
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = "Oh - ein Draufgaenger! Bist Du Dir wirklich sicher? ",
              Media = objTeufel,
              Buttons = {
                "na ich will",
                "stimmt"
              },
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objHIV:Start()
                    Wherigo.PlayAudio(obj_audiobolero)
                    _Urwigo.MessageBox({
                      Text = ("Na, " .. Player.Name) .. ", dann entspann' Dich aml",
                      Media = objHure,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.PlayAudio(obj_audiofemalorgasm)
                          _Urwigo.MessageBox({
                            Text = "",
                            Media = objXXX,
                            Callback = function(action)
                              if action ~= nil then
                                Wherigo.Command("StopSound")
                              end
                            end
                          })
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = [[
Was haette denn schon passieren sollen?<BR>
Schade!]],
                      Media = objTeufel,
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
          end
        end)
      else
        _Urwigo.MessageBox({
          Text = "Na ich nehm das mal als Trinkgeld. Fuer mehr reicht es ja nicht.",
          Media = objHure,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  else
    _Urwigo.MessageBox({
      Text = "Jetzt wirst Du aber uebermuetig. So viel Geld hast Du nicht!",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objTagebucheintrag:OnGetInput(input)
  if input == nil then
    input = ""
  end
  Notizbuch.Description = (Notizbuch.Description .. "") .. input
  KlausKlabuster:RequestSync()
end
function objHund2:OnTick()
  objHund1:MoveTo(_G[currentZone])
  Wherigo.PlayAudio(obj_audiobellen)
  _Urwigo.MessageBox({
    Text = [[
Huch. Na der ist ja putzig. Ja - wo kommst Du denn her?<BR>
Was geht ab?]],
    Media = objHund
  })
  if objbHundCurry == false then
    objPissen:Start()
  end
end
function objPissen:OnTick()
  Wherigo.PlayAudio(obj_audiostrullern)
  iA = iA + 1
  objHund1:MoveTo(zHG)
  _Urwigo.MessageBox({
    Text = "Hey - Bloedes Vieh! Was soll das?",
    Media = objHundpissend
  })
end
function objSchlaeger1:OnTick()
  _Urwigo.MessageBox({
    Text = "Ach du Scheisse - die sehen nicht gut aus. Nichts wie weg.",
    Media = objSchlager,
    Callback = function(action)
      if action ~= nil then
        objPruegelei:Start()
      end
    end
  })
end
function objPruegelei:OnTick()
  Spielende()
  TodSchlaeger()
  trPause:Start()
end
function objHunger:OnTick()
  Wherigo.PlayAudio(obj_audioDonner)
  objvarHunger = objvarHunger + 1
  if objvarHunger == 1 then
    _Urwigo.MessageBox({
      Text = [[
Hungerrrrrrr!<BR>
Das frische Luft so hungrig machen muss!]],
      Media = objKlaus
    })
  elseif objvarHunger == 2 then
    _Urwigo.MessageBox({
      Text = [[
Hungerrrrrrr! Boa, watt knurrt der Magen.<BR>
Langsam tut ne Pause not!<BR>
Ohne Mampf kein Kampf - oder wie das frueher hies.]],
      Media = objKlaus
    })
  elseif objvarHunger == 3 then
    TodHunger()
    Spielende()
    trPause:Start()
  end
end
function objDurst:OnTick()
  objvarDurst = objvarDurst + 1
  if objvarDurst == 1 then
    _Urwigo.MessageBox({
      Text = [[
Durrrrst!<BR>
Das Laufen an der frischen Luft so durstig machen muss!]]
    })
  elseif objvarDurst == 2 then
    _Urwigo.MessageBox({
      Text = [[
Durrrst! Boa, watt knurtt die Kehle.<BR>
Langsam tut ne Pause not!<BR>
Ohne Mampf kein Kampf - oder wie das frueher hies.]]
    })
  elseif objvarDurst == 3 then
    TodDurst()
    Spielende()
    trPause:Start()
  end
end
function objWasser:OnTick()
  TodWasser()
  Spielende()
  trPause:Start()
end
function objHIV:OnTick()
  TodHIV()
  Spielende()
  trPause:Start()
end
function trPause:OnTick()
  Spielstart()
end
function objBefreien:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = "Hey - ihre beiden Turteltauben - geht es auch ein bisschen ruhiger zu? Mein Kopf platzt!!!",
      Media = objEmpfangsdame
    },
    {
      Text = "Ach Du meine Nase! Was soll das denn?",
      Media = objEmpfangsdame
    },
    {
      Text = [[
Du kannst Fragen fragen!<BR>
Das ist einfach nicht mein Tag.<BR>
<BR>
Wenn Du bitte ...]],
      Media = objgefesselt
    },
    {
      Text = "... natuerlich. Wir sind ja ein ehrenwertes Haus!",
      Media = objEmpfangsdame
    },
    {
      Text = "Schade - an diesen Anblick haette ich mich gewoehnen koennen.",
      Media = objTeufel
    },
    {
      Text = [[
Ein Glueck! Fawn hat die versteckte Geldtasche nicht gefunden!<BR>
Die 10 Euro sind noch da!<BR>
Auf ein Neues!]],
      Media = objKlaus
    }
  }, function(action)
    objvarGefesselt = false
    zHL.Active = true
    objSeil1.Opened = true
    objSeil1:MoveTo(zHZ)
    objSeil1.Visible = true
    objvarGeld = 10
    objGeld.Description = "Du hast 10 Euro"
  end)
end
function objEva:Oncmdanreden(target)
  if bpEV == false then
    bpEV = true
    tFE.Complete = true
    tFE.Name = "Geschafft! Du hast Deine Traumfrau gefunden!"
    _Urwigo.Dialog(false, {
      {
        Text = "Hallo - Als ich dich von da hinten gesehen habe fragte ich mich die ganze Zeit woher ich dich kenne. Jetzt wo ich neben Dir stehe weiss ich es ? Du bist das Maedchen meiner Traume.",
        Media = objKlaus
      },
      {
        Text = "Magst Du nicht noch naeher kommen?",
        Media = objEve
      },
      {
        Text = "Gerne - darf ich dir den Ruecken eincremen?",
        Media = objKlaus
      },
      {
        Text = "Wie kommst Du darauf?",
        Media = objEve
      },
      {
        Text = "Ich dachte mir vielleicht wirds dir dann warm und du zeigst mir nicht die kalte Schulter.",
        Media = objKlaus
      },
      {Text = "Charmant!", Media = objEve},
      {
        Text = "Ich hab mir gedacht, wenn ich Dich jetzt nicht anspreche, sehen wir uns vielleicht nie wieder und das waere echt schade.",
        Media = objKlaus
      },
      {
        Text = "Ich weiss, wir kennen uns nicht, aber das hat sich ja gerade geaendert. Mein Name ist Klaus, und wie heisst du?",
        Media = objKlaus
      },
      {
        Text = "Nun, wenn das hier Dein Paradies ist, dann rate mal.",
        Media = objEve
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(objName)
      end)
    end)
  elseif Player:Contains(objApfel1) then
    _Urwigo.Dialog(false, {
      {
        Text = "Eva, kannst du nicht irgendwas tun damit ich mir nicht mehr so daemlich vorkomme nachdem ich dich angesprochen habe?",
        Media = objKlaus
      },
      {
        Text = "Nein, ich geniesse die Situation und lasse mich ueberraschen, was noch so alles passiert!",
        Media = objEve
      },
      {
        Text = "Aber ich gebe Dir einen Tip: was wollte Eva denn im Paradies unbedingt haben?",
        Media = objEve
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Eva, kannst du nicht irgendwas tun damit ich mir nicht mehr so daemlich vorkomme nachdem ich dich angesprochen habe?",
        Media = objKlaus
      },
      {
        Text = "Nun, wenn das hier Dein Paradies ist, dann rate mal, was mir fehlt!",
        Media = objEve
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objBartender1:Oncmdbestellen(target)
  if objvarBartenderBestellung == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Bart, Was soll's. Was kannst Du denn empfehlen?",
        Media = objKlaus
      },
      {
        Text = [[
Na unsere Klassiker: Bier, Wein, Whiskey.<BR>
Jeweils 5 Euro. ]],
        Media = objBartender
      }
    }, function(action)
      if objvarGeld > 5 then
        objvarBartenderBestellung = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(objBestellungBartender)
        end)
      else
        _Urwigo.MessageBox({
          Text = "Ups. Da komm ich doch gleich mal wieder.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Na Dir ist ja kalt. Also noch etwas zum Waermen?",
        Media = objBartender
      },
      {
        Text = "Wenn Du es sagst. Was gabs noch mal?",
        Media = objKlaus
      },
      {
        Text = [[
Das ist ja echt nicht Dein Tag,was? Immer noch unsere Klassiker Bier, Wein, Whiskey.<BR>
Und sie kosten immer noch 5 Euro.]],
        Media = objBartender
      }
    }, function(action)
      if objvarGeld > 5 then
        objvarBartenderBestellung = true
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(objBestellungBartender)
        end)
      else
        _Urwigo.MessageBox({
          Text = "Ups. Da komm ich doch gleich mal wieder.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  end
end
function objBartender1:Oncmdreden(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo Bart. Ist ja nicht viel los heute.",
      Media = objKlaus
    },
    {
      Text = "Ist ja auch zu frueh. Und dann noch Blondi. Die Kerle haengen an ihrer Lippe und sabbern, anstatt zu bestellen.",
      Media = objBartender
    },
    {
      Text = "Mir ging es echt schon besser.",
      Media = objBartender
    },
    {
      Text = "Bart. Da kann ich helfen!",
      Media = objKlaus
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objBetrunkene:OncmdAnquatschen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hoppla, wie siehst Du denn aus?",
      Media = objKlaus
    },
    {
      Text = "Ergh &nbsp;ischhhh ufzzzpf Biaer gulp Schpanndau",
      Media = objfraubetrunken
    },
    {
      Text = "Ja ja - das Brauhaus-Bier. Nichts fur schwache Nerven. Du konntest einen Verteiler brauchen.",
      Media = objKlaus
    },
    {
      Text = "Vaertlerrr? Hicks. Medisin? Whssky? Guaeeeeet",
      Media = objfraubetrunken
    }
  }, function(action)
    if Player:Contains(objGlasWhiskey) then
      _Urwigo.MessageBox({
        Text = "Hmm. Whiskey brauchst Du! Na ja, ",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.Dialog(false, {
        {
          Text = "Ups. Hochprozentiges als Medizin habe ich leider nicht.",
          Media = objKlaus
        },
        {
          Text = "Uarrghhhhhhhhhh",
          Media = objfraubetrunken
        },
        {
          Text = "Ich glaube, hier geh ich besser. Und zwar schnell.",
          Media = objKlaus
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  end)
end
function objBlondine:Oncmdanquatschenundflirten(target)
  if bpBF == false then
    bpBF = true
    _Urwigo.Dialog(false, {
      {
        Text = "Hallo, Schone der Nacht. Was fuehrt Dich in diese Ecke der Stadt - so alleine.",
        Media = objKlaus
      },
      {
        Text = "Was soll das Gequatsche? Glaubst Du, ich brauche Hilfe? Die brauchst eher Du, wenn mein Freund kommt.",
        Media = objbarfrau
      },
      {
        Text = "Aber mach ruhig weiter, wenn Du es brauchst.",
        Media = objbarfrau
      },
      {
        Text = "Und wenn Du dabei bist, gebrauch mal was gegen Deinen Geruch.",
        Media = objbarfrau
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Wie? Du schon wieder? Ich bin ganz sicher nicht Dein Typ - ich kann naemlich sehen!",
        Media = objbarfrau
      },
      {
        Text = "Da ist etwas an Dir, ",
        Media = objKlaus
      },
      {
        Text = "Ja, aber es fehlt doch auch einiges ... was mann mir geben koenntest.",
        Media = objbarfrau
      },
      {
        Text = "Blumen, Schmuck, Pralinen - Frauen moegen so etwas.",
        Media = objbarfrau
      },
      {
        Text = "Aber nicht von Dir - Du bist definitiv nicht mein Typ!",
        Media = objbarfrau
      },
      {
        Text = "Ich seh klar - ...",
        Media = objKlaus
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objBlondine:OncmdzumTanzenauffordern(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Na Sweety - wie waere es mit etwas Bewegung? Mal die Beine schwingen?",
      Media = objKlaus
    },
    {
      Text = "erstens - die Musik ist Mist. Und zweitens, welchen Teil von Looser hast Du nicht verstanden?",
      Media = objbarfrau
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objMonique:Oncmdansprechen(target)
  if bpH == false then
    bpH = true
    objMonique.Commands.cmdxxx.Enabled = true
    _Urwigo.Dialog(false, {
      {
        Text = "Hallo Suesse, wie siehts aus?",
        Media = objKlaus
      },
      {
        Text = "Wollen wir uns ueber die Einrichtung unterhalten - oder was?",
        Media = objHure
      },
      {
        Text = "Na schau Dir doch mal die Decke genauer an ...",
        Media = objKlaus
      },
      {
        Text = "Das kostet aber ",
        Media = objHure
      },
      {Text = "Was?", Media = objKlaus},
      {
        Text = "30 mit oder ohne, Sonderwuensche extra.",
        Media = objHure
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = [[
Da bist Du ja wieder? Hast wohl nicht genug von quatschen?<BR>
Ich bin aber kein Psychiater!]],
        Media = objHure
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objMonique:Oncmdxxx(target)
  _Urwigo.MessageBox({
    Text = "Hmm, Monique - 30 also",
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = "Was ist daran nicht zu verstehen?",
          Media = objHure,
          Callback = function(action)
            if action ~= nil then
              if objvarGeld > 30 then
                _Urwigo.MessageBox({
                  Text = "also",
                  Media = objKlaus,
                  Buttons = {
                    "okay",
                    "ne - doch nicht"
                  },
                  Callback = function(action)
                    if action ~= nil then
                      if action == "Button1" then
                        if Player:Contains(objKondome) then
                          _Urwigo.MessageBox({
                            Text = "dann",
                            Media = objKlaus,
                            Buttons = {"mit", "ohne"},
                            Callback = function(action)
                              if action ~= nil then
                                Wherigo.PlayAudio(obj_audiobolero)
                                objvarGeld = objvarGeld - 30
                                objKondome:MoveTo(zLI)
                                objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
                                _Urwigo.MessageBox({
                                  Text = ("Na, " .. Player.Name) .. ", dann entspann' Dich mal!",
                                  Media = objHure,
                                  Callback = function(action)
                                    if action ~= nil then
                                      Wherigo.PlayAudio(obj_audiofemalorgasm)
                                      _Urwigo.MessageBox({
                                        Text = "",
                                        Media = objXXX,
                                        Callback = function(action)
                                          if action ~= nil then
                                            Wherigo.Command("StopSound")
                                            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                                          end
                                        end
                                      })
                                    end
                                  end
                                })
                              end
                            end
                          })
                        else
                          _Urwigo.MessageBox({
                            Text = "Oh - ein Draufgaenger! Bist Du Dir wirklich sicher? ",
                            Media = objTeufel,
                            Buttons = {
                              "na ich will",
                              "stimmt"
                            },
                            Callback = function(action)
                              if action ~= nil then
                                if action == "Button1" then
                                  objHIV:Start()
                                  objvarGeld = objvarGeld - 30
                                  Wherigo.PlayAudio(obj_audiobolero)
                                  objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
                                  _Urwigo.MessageBox({
                                    Text = ("Na, " .. Player.Name) .. ", dann entspann' Dich aml",
                                    Media = objHure,
                                    Callback = function(action)
                                      if action ~= nil then
                                        Wherigo.PlayAudio(obj_audiofemalorgasm)
                                        _Urwigo.MessageBox({
                                          Text = "",
                                          Media = objXXX,
                                          Callback = function(action)
                                            if action ~= nil then
                                              Wherigo.Command("StopSound")
                                            end
                                          end
                                        })
                                      end
                                    end
                                  })
                                else
                                  _Urwigo.MessageBox({
                                    Text = [[
Was haette denn schon passieren sollen?<BR>
Schade!]],
                                    Media = objTeufel,
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
                        end
                      else
                        _Urwigo.MessageBox({
                          Text = "ja ja - erst grosse Klappe und dann nichts in der Hose",
                          Media = objHure,
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
                _Urwigo.MessageBox({
                  Text = "Ups. Eigentlich wuerde ich ja gerne. Du bist aber ne Nummer zu gross, leider.",
                  Media = objKlaus,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = [[
ja ja - erst grosse Klappe und dann nichts in der Hose.<BR>
Umsonst ist nur der Tode - und der kostet das Leben.<BR>
Komm wieder, wenn Du dazu bereits bist.]],
                        Media = objHure,
                        Callback = function(action)
                          if action ~= nil then
                            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                          end
                        end
                      })
                    end
                  end
                })
              end
            end
          end
        })
      end
    end
  })
end
function Landstreicher:OncmdInfo(target)
  _Urwigo.MessageBox({
    Text = [[
www.tim-verbargsichnicht.de<BR>
<BR>
Er kommt als "Zufallsgast" fuer ca. 30-45 Minuten ins Zentrum einer Veranstaltung, aber nicht auf die Buehne. Conny verzaubert auf poetisch-musikalische Art jeden Anlass!(mit Quetschkasten)<BR>
Hier wird Kabaret mit Musik und Poesie verbunden und das Ganze als Lebensgeschichte zum Verkauf angeboten!<BR>
Jedes Geburtstagskind wird mit stilvollem Gedicht bedacht und jede Weihnachtsfeier mit &nbsp;entsprechend umgeformten, wenn auch bekanntem, Kulturgut belebt!<BR>
Bei Bedarf kann er sich thematisch auf spezielle Wuensche des Gastgebers einstellen.<BR>
Er ist dramatisch-musikalisch-komisch-philosophisch-optimistisch-depressiv und vor allem: Liebenswerter Geschichtenerzahler...!<BR>
Er scheitert immer wieder und macht am Ende deutlich, das er trotzdem immer gewinnt!]],
    Media = objLandstreicher,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function Landstreicher:Oncmdansprechen(target)
  if bpLS == false then
    if Landstreicher:Contains(objFlascheWein) then
      sI = "Nun ja, Rotwein habe ich, Essen waere nett. Ich habe den ganzen Tag nur Aepfel gegessen, die sind zwar gesund, aber auf Dauer? Ich bin doch kein Pferd!"
    else
      sI = [[
klar - wie du siehst, ist meine Flasche leer. Und Rotwein ist ja gut fuers Herz.<BR>
Und ich habe noch nicht einmal das Geld, um mir welchen zu kaufen. Das Leben stinkt!]]
    end
    _Urwigo.Dialog(false, {
      {
        Text = "Moin. Du siehst aus, als ob Du Hilfe gebrauchen kannst.",
        Media = objKlaus
      },
      {Text = sI, Media = objLandstreicher}
    }, function(action)
      bpLS = true
      if Player:Contains(objFlascheWein) or Player:Contains(objCurrywurst) then
        _Urwigo.MessageBox({
          Text = "Na mal sehen ...",
          Media = objKlaus,
          Buttons = {
            "machbar",
            "leider nicht machbar"
          }
        })
      else
        _Urwigo.Dialog(false, {
          {
            Text = "Bloed. Da kann ich Dir nicht helfen.",
            Media = objKlaus
          },
          {
            Text = "Na ja. Ein Versuch war es wert. ",
            Media = objLandstreicher
          }
        }, function(action)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = "Moin. Na wie gehts?",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          if Landstreicher:Contains(objFlascheWein) then
            _Urwigo.Dialog(false, {
              {
                Text = "Danke der Nachfrage. Aber mit voller Flasche laesst es sich gut leben. Prost!",
                Media = objLandstreicher
              },
              {
                Text = "Na das freut mich fuer Dich. Ich mag glueckliche Menschen. ",
                Media = objKlaus
              }
            }, function(action)
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          else
            _Urwigo.MessageBox({
              Text = [[
klar. Wie Du siehst, ist meine Flasche leer, und Rotwein ist gut fuers Herz.<BR>
Und ich habe noch nicht einmal das Geld, um mir welchen zu kaufen. Das Leben stinkt!]],
              Media = objLandstreicher,
              Callback = function(action)
                if action ~= nil then
                  if Player:Contains(objFlascheWein) then
                    _Urwigo.MessageBox({
                      Text = "Na das ist",
                      Media = objKlaus,
                      Buttons = {
                        "machbar",
                        "leider nicht machbar"
                      },
                      Callback = function(action)
                        if action ~= nil then
                          if action == "Button1" then
                            objFlascheWein:MoveTo(Landstreicher)
                            _Urwigo.MessageBox({
                              Text = "Echt. Klasse. Mercie beaucoup. Dafuer moechte ich mich mit meinem Taschenmesser bedanken. Es soll Dir Glueck bringen.",
                              Media = objLandstreicher,
                              Callback = function(action)
                                if action ~= nil then
                                  objTaschenmesser1:MoveTo(Player)
                                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                                end
                              end
                            })
                          else
                            _Urwigo.MessageBox({
                              Text = "Schade. Aber einen Versuch war es wert.",
                              Media = objLandstreicher,
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
                    _Urwigo.Dialog(false, {
                      {
                        Text = "Bloed. Da kann ich Dir nicht helfen.",
                        Media = objKlaus
                      },
                      {
                        Text = "Na ja. Ein Versuch war es wert. ",
                        Media = objLandstreicher
                      }
                    }, function(action)
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end)
                  end
                end
              end
            })
          end
        end
      end
    })
  end
end
function Landwirt:Oncmdansprechen(target)
  if bpLW == false then
    bpLW = true
    _Urwigo.Dialog(false, {
      {
        Text = "Na die Aepfel sehen ja lecker aus. Schmecken die auch?",
        Media = objKlaus
      },
      {
        Text = "Was fuer eine Frage. Natuerlich. Und sie kosten so gut wie nichts. Nur 5 Euro.",
        Media = objLandwirt
      }
    }, function(action)
      if objvarGeld > 5 then
        _Urwigo.MessageBox({
          Text = "Das ist ein gutes Angebot. Ich nehm",
          Media = objKlaus,
          Buttons = {
            "einen",
            "doch keinen"
          },
          Callback = function(action)
            if action ~= nil then
              if action == "Button1" then
                objvarGeld = objvarGeld + -5
                objApfel1:MoveTo(Player)
                objApfel1.Commands.cmdessen.Enabled = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              else
                _Urwigo.MessageBox({
                  Text = "Schade. Aber vielleicht ein anderes mal.",
                  Media = objLandwirt,
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
        _Urwigo.MessageBox({
          Text = "Schade. Da reicht mein Geld leider nicht.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif Player:Contains(objApfel1) then
    _Urwigo.MessageBox({
      Text = "Mann, die Aepfel sind echt lecker. Danke fuer den Tip.",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objvarGeld > 5 then
    _Urwigo.Dialog(false, {
      {
        Text = "Na - kannst Du dir jetzt etwas Gesundheit leisten?",
        Media = objLandwirt
      }
    }, function(action)
      _Urwigo.MessageBox({
        Text = "Du meinst - an apple a day keeps the doctor away? ",
        Media = objKlaus,
        Buttons = {
          "ja - ich nehm einen",
          "daran glaub ich nicht"
        },
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" then
              _Urwigo.MessageBox({
                Text = "Eine gute Entscheidung.",
                Media = objLandwirt,
                Callback = function(action)
                  if action ~= nil then
                    objApfel1:MoveTo(Player)
                    objvarGeld = objvarGeld + -5
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = "Schade. Vielleicht ein anderes Mal.",
                Media = objLandwirt,
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
    end)
  else
    _Urwigo.MessageBox({
      Text = "Schade, mein Geld reicht immer noch nicht.",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKauffrau:Oncmdansprechen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo junge Frau. Was koennen Sie mir den empfehlen? Ich bin selten hier in der Stadt, aber heute will ich einen drauf machen.",
      Media = objKlaus
    },
    {
      Text = "Hmm. Nun, wenn Sie Dosen suchen, empfehle ich das Geocaching-Magazin, Rotwein und natuerlich Kondome.",
      Media = objVerkaeuferin
    },
    {
      Text = "Geocaching? Nie was davon gehoert. Aber Dosen suchen, das passt schon. Und der Rest ist ja auch nicht verkehrt.",
      Media = objKlaus
    },
    {
      Text = "Was kostet das denn?",
      Media = objKlaus
    },
    {
      Text = [[
Das Magazin 5 Euro<BR>
Die Kondome 10 Euro<BR>
Die Flasche Wein 15 Euro]],
      Media = objVerkaeuferin
    },
    {
      Text = "Vielen Dank",
      Media = objKlaus
    },
    {
      Text = "Gerne. Wir sehen uns dann an der Kasse.",
      Media = objVerkaeuferin
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objTuersteher:Oncmdansprechen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Ola - was geht ab.",
      Media = objKlaus
    },
    {
      Text = "Fuer Typen wie Dich? Nichts",
      Media = objTursteherDisco
    },
    {
      Text = "Das ist aber nicht umsatzfreundlich - apropos freundlich - was ist denn heute los?",
      Media = objKlaus
    },
    {
      Text = "Geschlossene Gesellschaft. Nur fuer VIPs. Wie ich sagte - nichts fuer Dich!",
      Media = objTursteherDisco
    }
  }, function(action)
    if Player:Contains(objDiscopass1) then
      _Urwigo.Dialog(false, {
        {
          Text = "Na - das glaube ich nicht: Schau Dir mal diesen VIP-Pass an!",
          Media = objDiscopass
        },
        {
          Text = [[
Das ist nun wirklich eine Uerberraschung. Typen kennt der Boss. Unglaublich!<BR>
Dann mal hereinspaziert.]],
          Media = objTursteherDisco
        }
      }, function(action)
        zDI.Active = true
        objDiscopass1.Opened = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = "Oh - und wie werde ich VIP?",
          Media = objKlaus
        },
        {
          Text = "Das, mein Freund, musst Du selbst herausfinden um dann aus der Asche aufzustehen.",
          Media = objTursteherDisco
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  end)
end
function objEmpfangsdame1:Oncmdreden(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo Sweetheart, wie geht es so? Heute schon was vor?",
      Media = objKlaus
    },
    {
      Text = "Grundsaetzlich ja - aber der Ruecken schmerzt, der Kopf droehnt, mir geht es beschissen. Wie soll da Stimmung aufkommen!",
      Media = objEmpfangsdame
    }
  }, function(action)
    if Player:Contains(objPillendose1) then
      _Urwigo.MessageBox({
        Text = "Hm, da laesst sich was machen.",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Tja, da kann ich dir nicht helfen.",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end)
end
function objFawn1:Oncmdtanzen(target)
  if objvarFawn < 4 then
    objvarFawn = objvarFawn + 1
    _Urwigo.MessageBox({
      Text = [[
Tanzen? Du bist ein Traummann und weist, was Frauen gefaellt!<BR>
Auf gehts. Hotten wir ab!]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Tanzen? Was fuer eine Ausdauer!!!<BR>
Auf gehts. Hotten wir ab!]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = "Du bist ein Mann zum Heiraten. Ich koennte die Hochzeitssuite reservieren, das kostet allerdings 100 Euro.",
            Media = objFawn,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end
    })
  end
end
function objFawn1:Oncmdanreden(target)
  if objvarFawnReden == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Hallo Sweetheart. Du bist der Lichtblink in dieser dunklen Stube",
        Media = objKlaus
      },
      {
        Text = "Ach was Du nicht sagst",
        Media = objFawn
      },
      {
        Text = "Aber natuerlich, wass soll ich denn ",
        Media = objKlaus
      },
      {
        Text = "machen? Lass Taten sprechen.",
        Media = objFawn
      },
      {
        Text = "ich mag das.",
        Media = objFawn
      },
      {
        Text = "und Geschenke.",
        Media = objFawn
      }
    }, function(action)
      objvarFawnReden = true
    end)
  elseif objvarFawn == 0 then
    _Urwigo.MessageBox({
      Text = "Mein Schatz, glaubst, Reden hilft? Taten zeichnen den Mann aus!",
      Media = objFawn
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Du bist auf dem richtigen Weg mein Schatz!<BR>
Nicht immer Reden, machen. Ich steh'n auf Sachen.]],
      Media = objFawn
    })
  end
end
function objFawn1:Oncmdkuessen(target)
  if bW == false then
    if Player:Contains(objFlascheWein) then
      _Urwigo.MessageBox({
        Text = [[
Oh mein stuermischer Held. Es fehlt noch eine Kleinigkeit fuer eine romantische Stimmung: ein gutes Glas Wein.<BR>
Und damit meine ich nicht die Ploerre in Deiner Tasche. Die ist eher was fuer Penner.<BR>
Koenntest Du ...]],
        Media = objFawn,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "Na klasse! Wo soll ich jetzt einen guten Wein herbekommen. Der Shop hat ja nicht das passende? Internet, Lieferservice? Aber wie komm ich da rein? ",
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
        Text = "Oh mein stuermischer Held. Es fehlt noch eine Kleinigkeit fuer eine romantische Stimmung: ein gutes Glas Wein. Koenntest Du ...",
        Media = objFawn,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  else
    _Urwigo.Dialog(false, {
      {
        Text = [[
Mein Held, mein Traummann. Und jetzt mach die Augen zu und lass mich Dich ueberraschen.<BR>
Sei entspannt in meinen Haenden.]],
        Media = objFawn
      }
    }, function(action)
      zHW.Active = false
      zHL.Active = false
      objvarGefesselt = true
      objFawn1.Visible = false
      objFawn1:MoveTo(nil)
      objvarGeld = 0
      objGeld.Description = "Du hast 0 Euro"
      _Urwigo.Dialog(false, {
        {
          Text = "Etwas ist komisch, du machst die Augen auf - ",
          Media = objKlaus
        },
        {
          Text = "- du liegst im Bett"
        },
        {
          Text = "- von Fawn keine Spur",
          Media = objFawn
        },
        {
          Text = "- und bist gefesselt!",
          Media = objgefesselt
        },
        {
          Text = [[
Und Fawn ist weg, mit Deinem Geld!<BR>
Aus der Traum. Sie war doch nicht die Richtige.]],
          Media = objKlaus
        },
        {
          Text = "Wie krieg ich jetzt das Seil zerschnitten, damit es weitergeht?",
          Media = objgefesselt
        },
        {
          Text = [[
Bei Handschellen haette ich noch eine Idee.<BR>
Aber bei einem Seil ...]],
          Media = objhandschellen
        }
      }, function(action)
        if Player:Contains(objTaschenmesser1) then
          _Urwigo.MessageBox({
            Text = "Gut, dass ich ein Taschenmesser habe!",
            Media = objgefesselt,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.Dialog(false, {
            {
              Text = "Mist! Jetzt waere ein Taschenmesser hilfreich!",
              Media = objgefesselt
            },
            {
              Text = [[
Ach quatsch - bei den Geraeuschen, die ihr gemacht habe, kommt bestimmt gleich die Empfangsdame und schaut nach ...<BR>
Warte einfach mal die 10 Minuten ...]],
              Media = objTeufel
            }
          }, function(action)
            objBefreien:Start()
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end)
        end
      end)
    end)
  end
end
function objCroupier1:Oncmdansprechen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo - Belle de Nuit - was steht heute noch an?",
      Media = objKlaus
    },
    {
      Text = "Na - Du siehst nicht gluecklich aus. Verloren? Laeuft wohl nicht so gut.",
      Media = objCroupier
    },
    {
      Text = "Sieht man das? Na ja, es koennte besser laufen.",
      Media = objKlaus
    },
    {
      Text = "So wie Du riechst, brauchst Du dich nicht zu wundern. Und wasch Dir mal die Finger, da klebt doch das Pech dran!",
      Media = objCroupier
    },
    {
      Text = "Du schaust an Dir herunter und stellst fest, so ganz unrecht hat sie nicht.",
      Media = objKlaus
    },
    {
      Text = "Ansonsten, die Eingeborenen hier, haben frueher Tabak verbrannt, als Opfer.",
      Media = objCroupier
    },
    {
      Text = "Tabak verbrannt? Wo soll ich hier Tabak bekommen?",
      Media = objKlaus
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Zigarettengirl:Oncmdreden(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo!? Bei Deinem Anblick raucht der Kopf.",
      Media = objKlaus
    },
    {
      Text = "Du siehst nicht gluecklich aus. Es laeuft wohl nicht, oder?",
      Media = objZigarettengirl
    },
    {
      Text = "Das stimmt leider. Ich komme so richtig nicht voran.",
      Media = objKlaus
    },
    {
      Text = "Dann immer mit der Ruhe, entspanne Dich, mach mal eine Zigarettenpause. Rauchen enstpannt und gefaellt den Goettern.",
      Media = objZigarettengirl
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Zigarettengirl:OncmdZigarettenkaufen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hallo - das ist genau das, was ich brauche. Was kosten denn diese Glimmstengel?",
      Media = objKlaus
    },
    {
      Text = "Fuer Dich - nur 10 Euro",
      Media = objZigarettengirl
    }
  }, function(action)
    if objvarGeld > 10 then
      _Urwigo.MessageBox({
        Text = "Daran soll es nicht scheitern",
        Media = objKlaus,
        Buttons = {
          "Ich nehme eine Packung",
          "aber nein, Rauchen ist gefaehrlich"
        },
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" then
              _Urwigo.MessageBox({
                Text = "Eine gute Entscheidung!",
                Media = objZigarettengirl,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = [[
Ich habe da einen Tip fuer Dich. Du kannst den Spielautomaten manipulieren.<BR>
<BR>
Komm mal naeher...]],
                      Media = objZigarettengirl,
                      Callback = function(action)
                        if action ~= nil then
                          objvarGeld = objvarGeld + -10
                          if iT == 0 then
                            iT = 1
                          else
                            iT = 2
                          end
                          objZigaretten:MoveTo(Player)
                          objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
                          objZigaretten.Commands.cmdrauchen.Enabled = true
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = "Schade. Du weisst nicht, was Dir entgeht.",
                Media = objZigarettengirl,
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
      _Urwigo.MessageBox({
        Text = "Ups. Dann werden wir uns wiedersehen. Spaeter.",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end)
end
function objPriester1:Oncmdansprechen(target)
  if objPriester1.Commands.cmdheiraten.Enabled == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Guten Tag Herr Pastor, mein Name ist Klaus, Klaus Klabuster aus Kladow. Und ich will meine Traumfrau heiraten. Geht des hier?",
        Media = objKlaus
      },
      {
        Text = [[
Natuerlich mein Sohn. Wenn Du Dir sicher bist, deine Traumfrau bereit ist und die Gebuehren bezahlt sind - kein Problem.<BR>
Das Brautpaar in die Betten springt, die Muenze erst im Kasten klingt.]],
        Media = objPriester
      },
      {Text = "Gebuehren?", Media = objKlaus},
      {
        Text = "Ja. Heiraten ist nicht billig. Es faengt mit 100 Euro an ...",
        Media = objPriester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = [[
Auf was wartest Du mein Sohn. Du hast meinen Segen erhalten - also Los.<BR>
Sein Gluck laesst man nicht warten!]],
        Media = objPriester
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function objPriester1:Oncmdheiraten(target)
  if zKI:Contains(objFawn1) then
    if bHB == true then
      Wherigo.PlayAudio(obj_audioHochzeit)
      objPriester1.Commands.cmdheiraten.Enabled = false
      objFawn1:MoveTo(zHZ)
      objFawn1.Commands.cmdkuessen.Enabled = true
      KlausKlabuster:RequestSync()
      _Urwigo.MessageBox({
        Text = "Nun liebes Brautpaar, wenn ich ... bla bla bla .. willst Du ... laber ... bis dass ... suelz ... so seid fruchtbar und mehret Euch. ",
        Media = objPriester,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "Mein Held - ich warte auf Dich in der Hochzeitssuite. Beeile Dich ...",
              Media = objFawn,
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
        Text = "Nicht so schnell, junger Mann. Wie alles in Deutschland geht ohne Gebuehren nichts. Die Trauung kostet 100 Euro!",
        Media = objPriester,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = "Du willst heiraten? Nun, dann bist Du hier richtig. Aber wo ist Deine Traumfrau? So geht das nicht!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          if bHB == true then
            _Urwigo.MessageBox({
              Text = "Immerhin hast Du die Gebuehren schon bezahlt!",
              Media = objPriester,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = "Und denk an die Gebuehren. Die Trauung kostet 100 Euro!",
              Media = objPriester,
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
  end
end
function Polizist:Oncmdansprechen(target)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.333333333333333 then
    _Urwigo.Dialog(false, {
      {
        Text = "Hallo Wachtmeister. Koennen Sie mir helfen?",
        Media = objKlaus
      },
      {
        Text = [[
Helfen? Du bist wohl auch von der Fraktion "Mein Freund ich helf Dir."<BR>
Aber Typen wie Dich kenn ich zur Genuege, Dir ist nicht mehr zu helfen.]],
        Media = objPolizist
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = "Hallo Wachtmeister. Koennen Sie mir helfen?",
      Media = objKlaus,
      Callback = function(action)
        if action ~= nil then
          local _rndChoiceValue = math.random()
          if _rndChoiceValue < 0.142857142857143 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC5FC5T erhalten und muss nach Kladow.<BR>
Dort sollen Zombies gesichtet worden sein.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          elseif _rndChoiceValue < 0.285714285714286 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC584NG erhalten und muss nach Kladow.<BR>
Agent Karl Toffel braucht meine Hilfe.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          elseif _rndChoiceValue < 0.428571428571429 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC3X9T7 erhalten und muss nach Elstal.<BR>
Im Kaufdorf sind Randalierer.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          elseif _rndChoiceValue < 0.571428571428571 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC3C36A erhalten und muss nach Staaken.<BR>
In der Naehe vom verlassenen Friedhof sind Kinder verschwunden.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          elseif _rndChoiceValue < 0.714285714285714 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC5K5WB erhalten und muss nach Spandau.<BR>
Dort ist eine Million zu retten.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          elseif _rndChoiceValue < 0.857142857142857 then
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC4ZRQEerhalten und muss mich konzentrieren.<BR>
Z wurde gesichtet und k-zuse braucht Hilfe.]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = [[
Du? Stoer mich nicht. Ich habe gerade den Code GC4432N erhalten und muss nach Priort.<BR>
Dort in der Naehe soll der Nachtzug ueberfallen werden.]],
              Media = objPolizist,
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
  end
end
function objRose1:Oncmdaufheben(target)
  objRose1:MoveTo(Player)
  objRose1.Commands.cmdaufheben.Enabled = false
  objRose1.Commands.cmdRosegeben.Enabled = true
  _Urwigo.MessageBox({
    Text = "Oh, Du wirst zum Rosenkavalier?",
    Media = objTeufel,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objRose1:OncmdRosegeben(target)
  if target == objFawn1 then
    objRose1:MoveTo(objFawn1)
    _Urwigo.MessageBox({
      Text = [[
Eine Rose?<BR>
Du bist ein Traummann und weist, was Frauen gefaellt!<BR>
Und dieser Duft! So ganz anders wie Du.]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          if objvarFawn < 4 then
            objvarFawn = objvarFawn + 1
          else
            _Urwigo.MessageBox({
              Text = "Du bist ein Mann zum Heiraten. Ich koennte die Hochzeitssuite reservieren, das kostet allerdings 100 Euro.",
              Media = objFawn,
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
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Was an - Du bist nicht mein Typ, hast Du nicht verstanden?",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objRose1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objRose1:OncmdRosewegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objRose1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function Whiskey:OncmdWhiskeybestellen(target)
  if target == objBartender1 then
    if objbBartWhisky == false then
      sI = "Bart, der Whisky sieht lecker aus. Da probier ich mal ein Glas."
    else
      sI = "Bart, der Whiskey war zwar nicht der Beste, aber er hat mir Glueck gebracht. Ich nehm noch einen!"
    end
    _Urwigo.Dialog(false, {
      {Text = sI, Media = objKlaus},
      {
        Text = "Das macht dann 5 Euro. ",
        Media = objBartender
      }
    }, function(action)
      if objvarGeld > 5 then
        objvarBartenderBestellung = true
        objbBartWhisky = true
        _Urwigo.MessageBox({
          Text = [[
Nach Glendronagh, 15 Jahre, sieht das nun definitiv nicht aus. Und der Geruch erst.<BR>
Na den steck ich doch lieber ein fuer schlechte - ganz schlechte Zeiten.]],
          Media = objWhiskey,
          Callback = function(action)
            if action ~= nil then
              objGlasWhiskey:MoveTo(Player)
              objvarGeld = objvarGeld + -5
              objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Ups. Da komm ich doch gleich mal wieder.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = [[
Was willst Du? &nbsp;So wirst Du nie erfolgreich sein?<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Das ist keine gute Idee. Hier brauchst Du einen klaren Kopf!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Und Du willst ein Gentleman sein? Pass besser auf, bevor ich es mir anders ueberlege!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFernbedienung1:OncmdFernbedienunggeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objFernbedienung1:MoveTo(_G[currentCharacter])
                  _Urwigo.MessageBox({
                    Text = "Wenn das mal gut war ...",
                    Media = objEngel,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Gute Entscheidung!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung!",
            Media = objEngel,
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
end
function objFernbedienung1:OncmdFernbedienungwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objFernbedienung1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Eine gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Eine gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPralinen1:Oncmdeinstecken(target)
  _Urwigo.MessageBox({
    Text = "Oh. Bruesseler Leckereien. Lecker.",
    Media = objPralinen,
    Callback = function(action)
      if action ~= nil then
        objPralinen1:MoveTo(Player)
        objPralinen1.Commands.cmdPralinengeben.Enabled = true
        objPralinen1.Commands.cmdeinstecken.Enabled = false
        _Urwigo.MessageBox({
          Text = "Hey Fremder - wenn Du auf der suche nach etwas suessem bist - wie waere es mit mir?",
          Media = objHure,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objPralinen1:Oncmdessen(target)
  _Urwigo.MessageBox({
    Text = [[
Glaubst, das ist eine gute Idee? Ich weiss ja, dass Du Hunger hast und Schokolade gut fuers Herz ist.<BR>
Aber meinst Du wirklich, das muss jetzt sein?]],
    Media = objTeufel,
    Buttons = {
      "aber ja",
      "obwohl, nein"
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Das war keine gute Idee!",
            Media = objEngel,
            Callback = function(action)
              if action ~= nil then
                objHunger:Stop()
                objvarHunger = 0
                objHunger:Start()
                objPralinen1:MoveTo(zBZ)
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Ich wusste, Du bist vernuenftig!",
            Media = objEngel,
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
end
function objPralinen1:OncmdPralinengeben(target)
  if target == objFawn1 then
    objPralinen1:MoveTo(objFawn1)
    _Urwigo.MessageBox({
      Text = [[
Belgische Schokolade? Du bist ein Traummann und weist, was Frauen gefaellt!<BR>
Und dieser zarte Schmelz! Wahnsinn! Ich schmelze!!!]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          if objvarFawn < 4 then
            objvarFawn = objvarFawn + 1
          else
            _Urwigo.MessageBox({
              Text = "Du bist ein Mann zum Heiraten. Ich koennte die Hochzeitssuite reservieren, das kostet allerdings 100 Euro.",
              Media = objFawn,
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
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Was an - Du bist nicht mein Typ, hast Du nicht verstanden?",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objPralinen1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wnn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objPralinen1:OncmdPralinenwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objPralinen1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    objPralinen1:MoveTo(zBZ)
    _Urwigo.MessageBox({
      Text = "Oh - Du hast es Dir besser ueberlegt - das ist nett.<BR>\n",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKondome:Oncmdkaufen(target)
  if objvarGeld > 10 then
    objKondome.Locked = false
    objvarGeld = objvarGeld + -10
    objKondome.Commands.cmdKondomegeben.Enabled = true
    objKondome.Commands.cmdkaufen.Enabled = false
    objKondome.Commands.cmdeinstecken.Enabled = false
    objKondome:MoveTo(Player)
    objGeld.Description = ("Du hast " .. objvarGeld) .. "Euro"
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = "Oje - kein Geld und Bedarf. Was nun? Doch mitnehmen?",
      Media = objKondom,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objKondome:MoveTo(Player)
          end
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKondome:Oncmdbenutzen(target)
  if Player:Contains(objKondome) then
    if _G[currentZone].Name ~= "Hinterzimmer" then
      _Urwigo.MessageBox({
        Text = "Du hast es aber noetig. Glaubst Du, das ist hier der richtige Ort?",
        Media = objTeufel,
        Buttons = {"egal", "nein"},
        Callback = function(action)
          if action ~= nil and action == "Button1" then
            Polizist:MoveTo(_G[currentZone])
            Wherigo.PlayAudio(obj_audiomalestop)
            _Urwigo.Dialog(false, {
              {
                Text = [[
Schaemst Du Dich denn nicht?<BR>
Sittenstrolch!<BR>
Hier ist jetzt aber Pause!]],
                Media = objPolizist
              },
              {
                Text = "Das war ja abzusehen. Suche Dir mal eine Bank und mach mal 5 Minuten Pause!",
                Media = objEngel
              }
            }, function(action)
              Spielende()
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          end
        end
      })
    else
      objKondome.Opened = true
      _Urwigo.MessageBox({
        Text = "Sitz, Passt, Wackelt und hat Luft.",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  else
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = [[
Hey. Hallo - erst kaufen!<BR>
Und dann sehen wir weiter!]],
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKondome:Oncmdeinstecken(target)
  _Urwigo.MessageBox({
    Text = "Gute Idee. Das spart Geld!",
    Media = objTeufel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Eigentlich ja - aber bist Du Dir sicher?",
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objKondome:MoveTo(Player)
                  objKondome.Commands.cmdKondomegeben.Enabled = true
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                else
                  _Urwigo.MessageBox({
                    Text = "Diese Idee ist besser!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Diese Idee ist besser!",
            Media = objEngel,
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
end
function objKondome:OncmdKondomegeben(target)
  if target == objBartender1 then
    _Urwigo.MessageBox({
      Text = "Ich glaube, an der Stelle hoeren wir besser auf und vergessen die letzten Minuten!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Ich glaube, an der Stelle hoeren wir besser auf und vergessen die letzten Minuten!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = "Ich glaube, an der Stelle hoeren wir besser auf und vergessen die letzten Minuten!",
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Ich habe ja schon viele Anmachen erlebt - aber das ist unterirdisch!",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Schatz - Du bist ja auf alles vorbereitet - aber lass uns erst mal heiraten!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    if _G[currentZone] == zFC then
      _Urwigo.MessageBox({
        Text = "Ja - Du bist der richtige!",
        Media = objEve,
        Callback = function(action)
          if action ~= nil then
            Wherigo.PlayAudio(obj_audiobolero)
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Ich sehe, Du bist auf alles vorbereitet - aber so leicht bin ich nicht zu erobern!",
        Media = objEve,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Auch wenn Du bisher auf der Gewinnerstra?e bist, so viel Geld kannst Du gar nicht haben.",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Auch wenn Du bisher auf der Gewinnerstra?e bist, so viel Geld kannst Du gar nicht haben.",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    objMonique.Commands.cmdxxx.Enabled = true
    _Urwigo.MessageBox({
      Text = "Du verlierst wohl nicht viele Worte. Aber die alleine reichen nicht!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBetrunkene then
    objKondome:MoveTo(zLI)
    _Urwigo.MessageBox({
      Text = "Uadfwjrogfnnasfoeaekdf &nbsp;sdoef,saaeem mspgfffgrsss a a a a u u h hsfafs",
      Media = objfraubetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = [[
Hmmm - ein unmoralisches Angebot. Und wir sind ja auch schon im Hotel - wie praktisch.<BR>
Aber mit meiner Migraene wird das kein Spass. &nbsp;]],
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objKauffrau then
    _Urwigo.MessageBox({
      Text = [[
Hmmm - ein unmoralisches Angebot. Und das Hotel ist ja auch gleich um die Ecke.<BR>
Leider habe ich heute Spaetschicht. Das klappt also nicht. ]],
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Also wirklich! So wirst Du Dein Glueck nicht finden!<BR>
Behalte die besser bei Dir.]],
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKondome:OncmdKondomewegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objKondome:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Eine gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Eine gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objApfel1:Oncmdessen(target)
  _Urwigo.MessageBox({
    Text = [[
Glaubst, das ist eine gute Idee? Ich weiss ja, dass Du Hunger hast und Aepfel gesund sind.<BR>
Aber meinst Du wirklich, das muss jetzt sein?]],
    Media = objTeufel,
    Buttons = {
      "aber ja",
      "obwohl, nein"
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Das war keine gute Idee!",
            Media = objEngel,
            Callback = function(action)
              if action ~= nil then
                objHunger:Stop()
                objvarHunger = 0
                objHunger:Start()
                objApfel1.Commands.cmdessen.Enabled = false
                objApfel1:MoveTo(Landwirt)
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Ich wusste, Du bist vernuenftig!",
            Media = objEngel,
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
end
function objApfel1:OncmdApfelgeben(target)
  if target == objEva then
    objApfel1:MoveTo(objEva)
    _Urwigo.MessageBox({
      Text = "Eva? Ein biblischer Name. Klassisch. Aber, da faellt mir etwas ein? Etwas, was zu Dir passt. Einfach voller Anmut. ",
      Media = objKlaus,
      Buttons = {
        "ein Apfel",
        "ein klassisches Gedicht"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objApfel1:MoveTo(objEva)
            zHW.Active = false
            zHL.Active = false
            zF1.Active = true
            zF0.Active = true
            objEva:MoveTo(zFC)
            objEva.Commands.cmdanreden.Enabled = false
            tFE.Complete = true
            tFE.Active = false
            tFE.Name = "Geschafft! Du hast Deine Traumfrau gefunden"
            tL.Active = true
            tL.Visible = true
            _Urwigo.Dialog(false, {
              {
                Text = "Endlich ein Mann, der mich versteht und meine Wuensche erkennt.",
                Media = objEve
              },
              {
                Text = "Ich glaube, Du bist der richtige - fuer mich und mein Haus am See.",
                Media = objEve
              },
              {
                Text = "Du musst nur den Weg gehen, Dich in das Grundbuch eintragen und wir sehen uns wieder.",
                Media = objEve
              }
            }, function(action)
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          else
            _Urwigo.Dialog(false, {
              {
                Text = [[
Der Apfelgarten - von Rilke<BR>
<BR>
Komm gleich nach dem Sonnenuntergange,<BR>
sieh das Abendgruen des Rasengrunds;<BR>
ist es nicht, als haetten wir es lange<BR>
angesammelt und erspart in uns,<BR>
um es jetzt aus Fuehlen und Erinnern,<BR>
neuer Hoffnung, halbverge?nem Freun,<BR>
noch vermischt mit Dunkel aus dem Innern,<BR>
in Gedanken vor uns hinzustreun<BR>
<BR>
unter Baeume wie von Duerer, die<BR>
das Gewicht von hundert Arbeitstagen<BR>
in den ueberfuellten Fruechten tragen,<BR>
dienend, voll Geduld, versuchend, wie<BR>
<BR>
das, was alle Ma?e uebersteigt,<BR>
noch zu heben ist und hinzugeben,<BR>
wenn man willig, durch ein langes Leben<BR>
nur das Eine will und waechst und?schweigt.<BR>
]],
                Media = objKlaus
              },
              {
                Text = "Du tickst doch nicht richtig! Was soll der Quatsch. Was habe ich mich doch geirrt. Leider.",
                Media = objEve
              }
            }, function(action)
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objApfel1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objApfel1:OncmdApfelwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objApfel1:MoveTo(Landwirt)
    _Urwigo.MessageBox({
      Text = "Solltest Du doch noch einen Apfel brauchen - der Landwirt hat ja welche!",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objHammer1:Oncmdnehmen(target)
  objHammer1:MoveTo(Player)
  objHammer1.Commands.cmdnehmen.Enabled = false
  objHammer1.Commands.cmdHammergeben.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objHammer1:OncmdHammergeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objHammer1:MoveTo(_G[currentCharacter])
                  _Urwigo.MessageBox({
                    Text = "Wenn das mal eine gute Entscheidung war",
                    Media = objEngel,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Gute Entscheidung",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung",
            Media = objEngel,
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
end
function objHammer1:OncmdHammerwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objHammer1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objAtemspray1:Oncmdbenutzen(target)
  Wherigo.PlayAudio(obj_audiospray)
  _Urwigo.MessageBox({
    Text = "ahhhhh - jetzt geht es wieder. Ob das auch als Deo hilft?",
    Media = objAtemspray,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objAtemspray1:OncmdSpraygeben(target)
  _Urwigo.MessageBox({
    Text = "Ich wuerde noch mal nachdenken! Dein Mundgeruch ist umwerfend. Glaubt Du, Du brauchst das Atemspray nicht mehr? ",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button2" then
          _Urwigo.MessageBox({
            Text = "Genau - und nicht vergessen: frischer Atmen kommt an!",
            Media = objTeufel,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          objAtemspray1:MoveTo(_G[currentCharacter])
          _Urwigo.MessageBox({
            Text = "Na ja, zumindest sind Deine Taschen jetzt nicht mehr so ausgebeult!",
            Media = objErzaehler,
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
end
function objAtemspray1:OncmdSpraywegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objAtemspray1:MoveTo(_G[currentItem])
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich!",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objTaschentuch1:OncmdTaschentuchgeben(target)
  if target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Looser - wie tief willst Du noch sinken?",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Das fing so gut an mit uns - und jetzt das!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    _Urwigo.MessageBox({
      Text = "Das fing so gut an mit uns - und jetzt das!",
      Media = objicoeve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Erstens bin ich nicht bestechlich - und dieser Versuch ist ja unterirdisch!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Erstens bin ich nicht bestechlich - und dieser Versuch ist ja unterirdisch!",
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Wenn ich bestechlich sein sollte - aber damit?",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Wenn ich bestechlich sein sollte - aber damit?",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    _Urwigo.MessageBox({
      Text = "Ach Schatzi - das reicht noch nicht mal fuer einen kurzen Blick!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = "Was soll das denn? Mein Kopf schmerzt und Du glaubst, mit diesem Ticken und Wackeln waere mir geholfen?",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objTaschentuch1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = [[
Wenn das mal gut war!<BR>
Na ja, zumindest sind Deine Taschen jetzt nicht mehr so ausgebeult!]],
                      Media = objErzaehler,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
                      Buttons = {"ja", "nein"},
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
              Buttons = {"ja", "nein"},
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
  end
end
function objTaschentuch1:OncmdTaschentuchwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objTaschentuch1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entcheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entcheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objArmbanduhr:OncmdUhrzeitablesen(target)
  local _Urwigo_Date = os.date("*t")
  _Urwigo.MessageBox({
    Text = ((("Es ist jetzt ... so ungefaehr ... " .. _Urwigo_Date.hour) .. " : ") .. _Urwigo_Date.min) .. " Uhr",
    Media = objarmbanduhr,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objArmbanduhr:OncmdUhrgeben(target)
  if target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Looser - wie tief willst Du noch sinken?",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Das fing so gut an mit uns - und jetzt das!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    _Urwigo.MessageBox({
      Text = "Das fing so gut an mit uns - und jetzt das!",
      Media = objicoeve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Erstens bin ich nicht bestechlich - und dieser Versuch ist ja unterirdisch!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Erstens bin ich nicht bestechlich - und dieser Versuch ist ja unterirdisch!",
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Wenn ich bestechlich sein sollte - aber damit?",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Also wirklich. Wenn ich bestechlich sein sollte - aber damit?",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    _Urwigo.MessageBox({
      Text = "Ach Schatzi - das reicht noch nicht mal fuer einen kurzen Blick!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = "Was soll das denn? Mein Kopf schmerzt und Du glaubst, mit diesem Ticken und Wackeln waere mir geholfen?",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objArmbanduhr:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = [[
Wenn das mal gut war.<BR>
Na ja, zumindest bis Du dieses olle Ding los!]],
                      Media = objTeufel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
                      Buttons = {"ja", "nein"},
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
              Buttons = {"ja", "nein"},
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
  end
end
function objArmbanduhr:OncmdUhrwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objArmbanduhr:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objMusikbox1:OncmdMusikabspielen(target)
  _Urwigo.MessageBox({
    Text = [[
Wow. Eine Original Wurlitzer aus den 50er.<BR>
Und Dein Lied ist auch dabei!]],
    Media = objMusikbox,
    Buttons = {
      "Lied spielen",
      "nichts dabei"
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          local _rndChoiceValue = math.random()
          if _rndChoiceValue < 0.166666666666667 then
            Wherigo.PlayAudio(obj_audioTheme)
          elseif _rndChoiceValue < 0.333333333333333 then
            Wherigo.PlayAudio(obj_audiotoilettenmusic)
          elseif _rndChoiceValue < 0.5 then
            Wherigo.PlayAudio(obj_audiodisco)
          elseif _rndChoiceValue < 0.666666666666667 then
            Wherigo.PlayAudio(obj_audiobolero)
          elseif _rndChoiceValue < 0.833333333333333 then
            Wherigo.PlayAudio(obj_audiohausamsee)
          else
            Wherigo.PlayAudio(obj_audioHochzeit)
          end
        end
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function Bier:OncmdBierbestellen(target)
  if target == objBartender1 then
    if objbBartBier == false then
      sI = "Bart, das Bier sieht lecker aus. Da probier ich mal ein Glas."
    else
      sI = "Bart, das Spandauer Bier ist Klasse. Ich nehm noch eins!"
    end
    _Urwigo.Dialog(false, {
      {Text = sI, Media = objKlaus},
      {
        Text = "Das macht dann 5 Euro. ",
        Media = objBartender
      }
    }, function(action)
      if objvarGeld > 5 then
        objvarBartenderBestellung = true
        objbBartBier = true
        _Urwigo.MessageBox({
          Text = "Ahhhh. Das gute Spandauer Brauhaus-Bier. Endlich nicht mehr unterhopft.",
          Media = objBierglass,
          Callback = function(action)
            if action ~= nil then
              objvarGeld = objvarGeld + -5
              Wherigo.PlayAudio(obj_audiotrinken)
              objDurst:Stop()
              objvarDurst = 0
              objDurst:Start()
              objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Ups. Da komm ich doch gleich mal wieder.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = [[
Was willst Du? &nbsp;So wirst Du nie erfolgreich sein?<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Das ist keine gute Idee. Hier brauchst Du einen klaren Kopf!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Und Du willst ein Gentleman sein? Pass besser auf, bevor ich es mir anders ueberlege!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function Wein:OncmdWeinbestellen(target)
  if target == objBartender1 then
    if objbBartWein == false then
      sI = "Bart, der Wein sieht lecker aus. Da probier ich mal ein Glas."
    else
      sI = "Bart, der Wein war zwar nicht der Beste, aber er ist gut gegen Durst. Ich nehm noch einen!"
    end
    _Urwigo.Dialog(false, {
      {Text = sI, Media = objKlaus},
      {
        Text = "Das macht dann 5 Euro. ",
        Media = objBartender
      }
    }, function(action)
      if objvarGeld > 5 then
        objvarBartenderBestellung = true
        objbBartWein = true
        _Urwigo.MessageBox({
          Text = "Oh. Ein 2010 Chateau Nierentritt, Nordhang. Soll ja gut gegen Herzprobleme sein.",
          Media = objWeinglass,
          Callback = function(action)
            if action ~= nil then
              Wherigo.PlayAudio(obj_audiotrinken)
              objvarGeld = objvarGeld + -5
              objDurst:Stop()
              objvarDurst = 0
              objDurst:Start()
              objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = "Ups. Da komm ich doch gleich mal wieder.",
          Media = objKlaus,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = [[
Was willst Du? &nbsp;So wirst Du nie erfolgreich sein?<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Das ist keine gute Idee. Hier brauchst Du einen klaren Kopf!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Was willst Du? &nbsp;Und Du willst ein Gentleman sein? Pass besser auf, bevor ich es mir anders ueberlege!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFernseher:Oncmdeinschalten(target)
  if Player:Contains(objFernbedienung1) then
    iTV = 1
    objFernseher.Icon = objicoFernseher
    objFernseher.Opened = true
    objFernseher.Commands.cmdausschalten.Enabled = true
    objFernseher.Commands.cmdeinschalten.Enabled = false
    objFernseher.Commands.cmdSenderwechseln.Enabled = true
    _Urwigo.MessageBox({
      Text = "Ups. Interessantes Programm. Aber besser als nichts.",
      Media = objfernseheran
    })
  else
    _Urwigo.MessageBox({
      Text = "Dummerle. Wie willst Du denn ohne Fernbedienung den Fernseher einschalten?"
    })
  end
end
function objFernseher:Oncmdausschalten(target)
  if Player:Contains(objFernbedienung1) then
    _Urwigo.MessageBox({
      Text = "Leider ist der Aus-Knopf der Fernbedienung defekt. So ein Pech aber auch.",
      Media = objfernseheran
    })
  else
    _Urwigo.MessageBox({
      Text = "Dummerle! Wie willst Du die heutigen Fernseher ohne Fernbedienung ausschalten?",
      Media = objfernseheran
    })
  end
end
function objFernseher:OncmdSenderwechseln(target)
  if Player:Contains(objFernbedienung1) then
    if objFernseher.Opened == true then
      if iTV == 1 then
        iTV = 2
        objFernseher.Media = objfernsehersport
        objFernseher.Icon = objicofernsehersport
        _Urwigo.MessageBox({
          Text = "Da geht was",
          Media = objfernsehersport,
          Callback = function(action)
            if action ~= nil then
              zBZ.Active = false
              objTreppe1.Visible = true
              objTreppe1.Opened = false
            end
          end
        })
      elseif iTV == 2 then
        iTV = 3
        objFernseher.Media = objfernsehermaja
        objFernseher.Icon = objicofernsehermaja
        _Urwigo.MessageBox({
          Text = "Na immerhin was mit Bienen.",
          Media = objfernsehermaja,
          Callback = function(action)
            if action ~= nil then
              zBZ.Active = false
              objTreppe1.Visible = true
              objTreppe1.Opened = false
            end
          end
        })
      elseif iTV == 3 then
        iTV = 4
        objFernseher.Media = objfernseherporno
        objFernseher.Icon = objicofernseherporno
        Wherigo.PlayAudio(obj_audiofemalorgasm)
        _Urwigo.MessageBox({
          Text = [[
Ui. Das gefaellt doch!<BR>
Vor allem diesem Gorilla. Damit scheint der Weg zur Treppe frei zu sein.]],
          Media = objfernseherporno,
          Callback = function(action)
            if action ~= nil then
              objTreppe1.Opened = true
              objTreppe1.Visible = false
              zBZ.Active = true
            end
          end
        })
      elseif iTV == 4 then
        iTV = 1
        objFernseher.Media = objfernseheran
        objFernseher.Icon = objicoFernseher
        _Urwigo.MessageBox({
          Text = "Romantisch!",
          Media = objfernseheran,
          Callback = function(action)
            if action ~= nil then
              zBZ.Active = false
              objTreppe1.Visible = true
              objTreppe1.Opened = false
            end
          end
        })
      end
    else
      _Urwigo.MessageBox({
        Text = "Du solltest erst einmal den Fernseher einschalten!",
        Media = objfernseheraus
      })
    end
  else
    _Urwigo.MessageBox({
      Text = "Wie willst Du ohne Fernbedienung den Sender wechseln?",
      Media = objfernseheraus
    })
  end
end
function objFernseher:Oncmdansehen(target)
  if iTV == 0 then
    _Urwigo.MessageBox({
      Text = "Ich seh schwarz.",
      Media = objfernseheraus
    })
  elseif iTV == 1 then
    _Urwigo.MessageBox({
      Text = "Romantisch.",
      Media = objfernseheran
    })
  elseif iTV == 2 then
    _Urwigo.MessageBox({
      Text = "Da geht doch was.",
      Media = objfernsehersport
    })
  elseif iTV == 3 then
    _Urwigo.MessageBox({
      Text = "Na immerhin was mit Bienen.",
      Media = objfernsehermaja
    })
  elseif iTV == 4 then
    _Urwigo.MessageBox({
      Text = "Das gefaellt doch, wenn es auch nicht das wahre Leben ist.",
      Media = objfernseherporno
    })
  end
end
function objTuer1:Oncmdanklopfen(target)
  Wherigo.PlayAudio(obj_audioknock)
  if bKW == false then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objPasswort)
    end)
  else
    zBT.Active = true
    _Urwigo.MessageBox({
      Text = ("Hallo " .. Player.Name) .. ", Willkommen und hereinspaziert.",
      Media = objTuer,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKlo:Oncmdbenutzen(target)
  _Urwigo.MessageBox({
    Text = [[
Bist Du wirklich sicher?<BR>
Na jaj, wenn es halt drueckt und raus muss ...]],
    Media = objtoilettenschussel,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = "HALT! Hast Du nicht etwas vergessen?",
          Media = objEngel,
          Buttons = {
            "spuelen",
            "doch nicht spuelen"
          },
          Callback = function(action)
            if action ~= nil then
              if action == "Button1" then
                _Urwigo.MessageBox({
                  Text = "Keine gute Idee. Warum soll hier denn auch alles in Ordnung sein. Mit lautem Schwall ergiesst sich Wasser in die Schuessel und drueckt die Reste der letzten Monate nach oben. ",
                  Media = objTeufel,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = [[
Der Boden wird immer glitschiger und Du stellst mit Erschrecken fest, dass Deine italienischen Edelslipper keine rutschfesten Sohlen haben, bevor Dein Kopf hart auf dem Boden in einer ueblen Pfuetze aufschlaegt.<BR>
<BR>
Jetzt ist wohl eine Pause faellig!]],
                        Media = objErzaehler,
                        Callback = function(action)
                          if action ~= nil then
                            Spielende()
                            trPause:Start()
                            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                          end
                        end
                      })
                    end
                  end
                })
              else
                _Urwigo.MessageBox({
                  Text = "Gute Entscheidung. Blos nicht zuviel anfassen. Wer weiss, ob das Waschbecken ueberhaupt funktioniert.",
                  Media = objbartoilette,
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
      end
    end
  })
end
function objWaschbecken1:OncmdHaendewaschen(target)
  _Urwigo.MessageBox({
    Text = "Na ja - immerhin ein duennes Rinnsaal kalten Wassers troepfelt langsam ueber Deine Haende. ",
    Media = objtoilettewaschbecken,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = "Hoppla, was loest sich denn da unter einer Schmutzschicht im Waschbecken - da blitzt doch etwas auf.",
          Media = objtoilettewaschbecken,
          Callback = function(action)
            if action ~= nil then
              objRing1.Visible = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objWaschbecken1:Oncmdtrinken(target)
  _Urwigo.MessageBox({
    Text = "Durst ist schon schlimm. Und dieses Rinnsaal - es dauert halt, aber besser wie nichts. Und immer nur Alkohol - ist auch keine Loesung.",
    Media = objtoilettewaschbecken,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = "Wenn das mal eine gute Idee war! Hast Du Dir diesen PLatz denn nicht naeher angesehen?",
          Media = objEngel,
          Callback = function(action)
            if action ~= nil then
              objWasser:Start()
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objSpiegel1:Oncmdbetrachten(target)
  _Urwigo.MessageBox({
    Text = "Ui. Ein huebscher junger Mann mit reichlich Potenzial. Aber was soll die Tastatur?",
    Media = objToilettespiegelbild,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objKlowand:Oncmdbetrachten(target)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.25 then
    if objbW1 == false then
      objbW1 = true
      Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Rosi, 32168]]
      objNummerRosi.Visible = true
      _Urwigo.MessageBox({
        Text = [[
Zum Dichter und Pulitzerpreistraeger ist es fuer einige noch ein weiter Weg.<BR>
Und was soll das hier bedeuten:<BR>
unter 32 16 8, herrscht Konjunktur die ganze Nacht?<BR>
Komische Nummer! Und wer ist Rosi?]],
        Media = objtoilettewand1,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Zssss, sind ja schon witzige Sprueche.",
        Media = objtoilettewand1,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _rndChoiceValue < 0.5 then
    if objbW2 == false then
      objbW2 = true
      _Urwigo.MessageBox({
        Text = "Aha. Fuer andere scheint dieser Ort hier doch interessant zu sein.",
        Media = objtoilettewand2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Die reinste Kontaktboerse.",
        Media = objtoilettewand2,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _rndChoiceValue < 0.75 then
    if objbW3 == false then
      objbW3 = true
      Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Kennwort: TMZ SCHICKT MICH]]
      _Urwigo.MessageBox({
        Text = [[
Das liest sich interessant.<BR>
Gut, dass ich mein Notizbuch mithabe.]],
        Media = objtoilettewand3,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Sind ja schon witzige Sprueche.",
        Media = objtoilettewand3,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif objbW4 == false then
    objbW4 = true
    _Urwigo.MessageBox({
      Text = "Ich wusste es: Spandau war schon immer die Heimat zahlreicher Kuenstler.",
      Media = objtoilettewand4,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Schon interessant, was hier alles als Kunst gilt.",
      Media = objtoilettewand4,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function Notizbuch:Oncmdeintragen(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objTagebucheintrag)
  end)
end
function objTreppe1:OncmdTreppebetreten(target)
  if objTreppe1.Opened == false then
    _Urwigo.Dialog(false, {
      {
        Text = [[
Hey! Watt geht ab? Ick helf Dir jleich mal uff die andre Seite.<BR>
Hier is nuescht fur Disch! Gar nuescht.]],
        Media = objbartreppenhaustuersteher
      },
      {Text = "Aber", Media = objKlaus},
      {
        Text = "Nuescht aber. Raus jetzt. Aber Dalli.",
        Media = objbartreppenhaustuersteher
      },
      {
        Text = "Irgendwie muss ich den beschaeftigen und ablenken.",
        Media = objKlaus
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    zBZ.Active = true
  end
end
function objRing1:Oncmdnehmen(target)
  _Urwigo.MessageBox({
    Text = [[
Nicht uebel. Den kann ich sicher noch brauchen.<BR>
Fuer Eva.]],
    Media = objRing,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = Player.Name .. " - bist Du sicher, dass Du den Ring nicht im Fundbuero abgeben moechtest?",
          Media = objEngel,
          Buttons = {
            "aber ja",
            "hmmm - wenn Du meinst."
          },
          Callback = function(action)
            if action ~= nil then
              if action == "Button1" then
                objRing1:MoveTo(Player)
                objRing1.Commands.cmdnehmen.Enabled = false
                objRing1.Commands.cmdRinggeben.Enabled = true
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              else
                _Urwigo.MessageBox({
                  Text = "Wenn das mal klug war.",
                  Media = objTeufel,
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
      end
    end
  })
end
function objRing1:OncmdRinggeben(target)
  if target == objFawn1 then
    objRing1:MoveTo(objFawn1)
    _Urwigo.MessageBox({
      Text = [[
Ein Ring?<BR>
Du bist ein Traummann und weist, was Frauen gefaellt!<BR>
Und dieser Glanz!]],
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          objRing1:MoveTo(objFawn1)
          if objvarFawn < 4 then
            objvarFawn = objvarFawn + 1
          else
            _Urwigo.MessageBox({
              Text = "Du bist ein Mann zum Heiraten. Ich koennte die Hochzeitssuite reservieren, das kostet allerdings 100 Euro.",
              Media = objFawn,
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
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Was an - Du bist nicht mein Typ, hast Du nicht verstanden?",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objRing1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objRing1:OncmdRingwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objRing1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objRadio1:Oncmdanschalten(target)
  _Urwigo.MessageBox({
    Text = "Einschalten ist eine Sache, den richtigen Sender zu finden etwas ganz anderes. Paradiso, rs2, 104.6, antenne - du hast die Qual der Wahl.",
    Media = objRadio,
    Callback = function(action)
      if action ~= nil then
        Wherigo.PlayAudio(obj_audioradio)
        _Urwigo.MessageBox({
          Text = [[
und dazwischen immer wieder Werbung - sogar von einem 24h Lieferservice fuer alkoholische Getraenke.<BR>
Also ob Mann so etwas braucht. Aber die Nummer ist eingaengig: 08004711]],
          Media = objRadio,
          Callback = function(action)
            if action ~= nil then
              objNummer24hLieferservice.Visible = true
              Notizbuch.Description = Notizbuch.Description .. [[
<BR>
24h-Shop, 08004711]]
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objRadio1:Oncmdnehmen(target)
  _Urwigo.MessageBox({
    Text = "Willst Du Dich echt mit diesem Teil belasten?",
    Media = objTeufel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        objRadio1:MoveTo(Player)
        objRadio1.Commands.cmdRadiogeben.Enabled = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objRadio1:OncmdRadiogeben(target)
  if target == Landstreicher then
    objRadio1:MoveTo(Landstreicher)
    _Urwigo.OldDialog({
      {
        Text = "Ich habe zwar nicht viel, was ich mit Dir teilen kann, aber wie waere es mit einem Radio?",
        Media = objKlaus
      },
      {
        Text = "Radio? &nbsp;Na ja, Einsamkeit ist auf Dauer auch nicht das Beste. Eine kleine Abwechslung waere ein Traum.",
        Media = objLandstreicher
      },
      {
        Text = "Der in Erfuellung geht!",
        Media = objKlaus
      }
    })
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = [[
Witzige Idee. Natuerlich mag ich Musik, aber auch mit dem passenden Bass.<BR>
Lass die Kiste mal stecken!]],
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Was soll ich mit dieser Antiqutaet?",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    objRadio1:MoveTo(zHZ)
    _Urwigo.MessageBox({
      Text = [[
Hab ich mir doch gedacht, dass da etwas grosses in Deiner Hose ist.<BR>
Gut dass Du einsichtig bist, auf Polizei und Papierkram haette ich keine Lust gehabt.<BR>
]],
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    objRadio1:MoveTo(zBZ)
    _Urwigo.MessageBox({
      Text = [[
Ist ja nett! Vielen Dank. Aber hast Du nicht auch ein Mikrofon?<BR>
Das waere etwas.]],
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Landwirt then
    objRadio1:MoveTo(Landwirt)
    objApfel1:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = "Das ist ja eine nette Geste. Dafuer schenke ich Dir einen Apfel.",
      Media = objLandwirt,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBetrunkene then
    _Urwigo.MessageBox({
      Text = "Buaehhh glp brrr Golllaaaaa rrrgacfvsavb",
      Media = objfraubetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Und was soll ich hier damit?",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Und was soll ich hier damit?",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = [[
Meinst Du echt, dieses olle Ding macht tolle Mucke - besser als der Wurlitzer hier?<BR>
Lass mal stecken!]],
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    _Urwigo.MessageBox({
      Text = "Ihhhh - bist Du irre? Ich sitz hier im Wasser!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objKauffrau then
    objRadio1:MoveTo(objKauffrau)
    _Urwigo.MessageBox({
      Text = "Oh - eine nette Idee. Das Gedudel hier geht mir echt auf den Kranz.",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBartender1 then
    _Urwigo.MessageBox({
      Text = [[
Klasse Idee! Und was glaubst Du, was der Wurlitzer hier macht?<BR>
Lass das olle Ding mal stecken.]],
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    objRadio1:MoveTo(Polizist)
    _Urwigo.MessageBox({
      Text = [[
Aha - jetzt sag nicht, das hast Du zufaellig gefunden.<BR>
Aber ich will mal nicht so sein!]],
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objPriester1 then
    objRadio1:MoveTo(zKI)
    _Urwigo.MessageBox({
      Text = "Vielen Dank. Das koennte mir helfen, die kaputte Musikanlage zu reparieren.",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objSchlaeger then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber das hilft Dir nicht weiter.",
      Media = objschlaegerei,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objDiscopass1:Oncmdnehmen(target)
  objDiscopass1:MoveTo(Player)
  objDiscopass1.Commands.cmdnehmen.Enabled = false
  objDiscopass1.Commands.cmdPassgeben.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objDiscopass1:OncmdPassgeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER???]],
            Media = objEngel,
            Buttons = {"nein", "ja"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button2" then
                  objDiscopass1:MoveTo(_G[currentCharacter])
                  objDiscopass1.Locked = true
                  _Urwigo.MessageBox({
                    Text = "Wenn das mal gut war",
                    Media = objEngel,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Gute Entscheidung!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung!",
            Media = objEngel,
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
end
function objDiscopass1:OncmdPasswegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objDiscopass1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Eine gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Eine gute Entscheidung!",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objSeil1:Oncmdnehmen(target)
  objSeil1:MoveTo(Player)
  objSeil1.Commands.cmdnehmen.Enabled = false
  objSeil1.Commands.cmdSeilgeben.Enabled = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objSeil1:OncmdSeilgeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objSeil1:MoveTo(_G[currentCharacter])
                  _Urwigo.MessageBox({
                    Text = "Wenn das mal gut war ...",
                    Media = objEngel,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Gute Entscheidung!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung!",
            Media = objEngel,
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
end
function objSeil1:OncmdSeilwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objSeil1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entcheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entcheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPillendose1:Oncmdansehen(target)
  if objMagazin1.Opened == true then
    _Urwigo.MessageBox({
      Text = [[
Hey - das sind doch die Pillen, die im Magazin beschrieben wurden. Die brauche ich!<BR>
Nur, wie komme ich daran? Das Fenster ist zu und der Balkon ist ausser Reichweite. Da muesste ich hinklettern! Ohne Seil ist das gefaehrlich.<BR>
Und dann muss ich noch das Fenster auf kriegen oder einschlagen.]],
      Media = objPillendose,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Sieht interessant aus - aber um genau zu sehen, ob sich der Aufwand lohnt, muesste ich schon dahin klettern. Die sind ausser Reichweite.<BR>\n",
      Media = objPillendose,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPillendose1:Oncmdnehmen(target)
  if Player:Contains(objHammer1) and Player:Contains(objSeil1) then
    if objMagazin1.Opened == true then
      _Urwigo.MessageBox({
        Text = [[
Perfekt. Mit dem Seil kannst Du auf den Nachbarbalkon klettern und dann mit dem Hammer das Fenster einschlagen.<BR>
Ein Griff und die Pillendose wandert in Deine Tasche.]],
        Media = objErzaehler,
        Callback = function(action)
          if action ~= nil then
            objPillendose1:MoveTo(Player)
            objPillendose1.Commands.cmdPillengeben.Enabled = true
            objPillendose1.Commands.cmdnehmen.Enabled = false
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = [[
Tja. Du hast einen Hammer, um das Fenster einzuschlagen und sogar ein Seil.<BR>
Aber ich glaube nicht, dass Du mit dem Seil umgehen kannst.<BR>
Lass es lieber, bevor Du abstuerzt und erkundige Dich, wie man klettert!]],
        Media = objErzaehler,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Player:Contains(objSeil1) then
    if objMagazin1.Opened == true then
      _Urwigo.MessageBox({
        Text = "Tja. Mit dem Seil kommst Du zwar auf den Nachbarbalkon, aber dann hast Du nichts, um das Fenster einzuschlagen. Du brauchst einen Hammer.",
        Media = objErzaehler,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = [[
Tja. Du hast zwar ein Seil, aber weisst Du denn, wie Du damit kletterst?<BR>
Und dann hast Du nichts, um das Fenster einzuschlagen. ]],
        Media = objErzaehler,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Player:Contains(objHammer1) then
    Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Mir fehlt noch das Seil]]
    _Urwigo.MessageBox({
      Text = "Tja. Mit dem Hammer kannst Du zwar das Fenster einschlagen, aber Dir fehlt ein Seil, um auf den Balkon zu klettern.",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Ich brauche Seil und Hammer fuer die Pillen]]
    _Urwigo.MessageBox({
      Text = "Tja. Ich denke, die Pillen liegen ausser Reichweite. Wie willst Du zum Fenster klettern und wie willst Du dann das Fenster einschlagen?",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPillendose1:OncmdPillengeben(target)
  if target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = "Die junge Dame sieht wirklich fertig aus. Aber glaubst Du, dass Pillen helfen?",
      Media = objEmpfangsdame,
      Buttons = {"aber ja", "eher nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.Dialog(false, {
              {
                Text = "Schau mal, das muesste Dir helfen.",
                Media = objKlaus
              },
              {
                Text = "Boah ey, das rettet den Tag. Und jetzt nichts wie weg nach Hause.",
                Media = objEmpfangsdame
              }
            }, function(action)
              objPillendose1:MoveTo(objEmpfangsdame1)
              objEva.Visible = true
              objEmpfangsdame1.Visible = false
              objGlastuer.Visible = false
              zHW.Active = true
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end)
          else
            _Urwigo.MessageBox({
              Text = "Also wirklich. Pillen sind keine Losung, sondern heftige Chemie. Lass besser die Finger davon.",
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
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objPillendose1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objPillendose1:OncmdPillenwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objPillendose1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objMagazin1:Oncmdkaufen(target)
  if objvarGeld > 5 then
    objMagazin1.Locked = false
    objMagazin1:MoveTo(Player)
    objMagazin1.Commands.cmdkaufen.Enabled = false
    objMagazin1.Commands.cmdeinstecken.Enabled = false
    objMagazin1.Commands.cmdMagazingeben.Enabled = true
    objvarGeld = objvarGeld + -5
    objGeld.Description = ("Du hast " .. objvarGeld) .. "Euro"
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = "Ups. Du hast nicht genug Geld dabei. Willst Du das Magazin dennoch mitnehmen?",
      Media = objMagazin,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          objMagazin1:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objMagazin1:Oncmdlesen(target)
  if objMagazin1.Locked == false then
    _Urwigo.Dialog(false, {
      {
        Text = [[
Interessant. Der Kauf hat sich gelohnt. Hier sind ja nicht nur interessante Artikel ueber Dosen in Berlin, sondern auch ueber Klettern und aktives Leben.<BR>
Mal sehen:]],
        Media = objMagazin
      },
      {
        Text = "Oha - so klettert man also. Und das sind also die richtigen Knoten fuer die Sicherung. Interessant, was man mit einem Seil so alles machen kann.",
        Media = objMagazin
      },
      {
        Text = [[
Und hier: Touristisch hat Berlin einiges zu bieten. Wer sich zu einem Cache-Kurztrip entschliesst, findet an fast allen Attraktionen einen Cache.<BR>
Ui, sogar auf dem Marktplatz in Spandau soll eine Dose sein! ]],
        Media = objMagazin
      },
      {
        Text = "Aha - kleine Wehwechen leicht kuriert. Interessant, welche Pillen die Stimmung aufhellen sollen.",
        Media = objMagazin
      }
    }, function(action)
      if objMagazin1.Opened == false then
        Notizbuch.Description = Notizbuch.Description .. [[
<BR>
T-Saeule Marktplatz Spandau<BR>
Seil zum Klettern<BR>
Pillen zur Stimmungsaufhellung]]
        objMagazin1.Opened = true
      end
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hallo Hallo. So geht das nicht, junger Mann. Erst kaufen, dann lesen!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objMagazin1:Oncmdeinstecken(target)
  _Urwigo.MessageBox({
    Text = "Gute Idee. Das spart Geld!",
    Media = objTeufel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Eigentlich ja - aber bist Du Dir sicher?",
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objMagazin1:MoveTo(Player)
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                else
                  _Urwigo.MessageBox({
                    Text = "Diese Idee ist besser!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Diese Idee ist besser!",
            Media = objEngel,
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
end
function objMagazin1:OncmdMagazingeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          if objMagazin1.Opened == false then
            _Urwigo.MessageBox({
              Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???<BR>
Du hast es immerhin noch nicht gelesen!]],
              Media = objEngel,
              Buttons = {"ja", "nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objMagazin1:MoveTo(_G[currentCharacter])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung!",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          end
        else
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function objMagazin1:OncmdMagazinwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objMagazin1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entscheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objTaschenmesser1:Oncmdbenutzen(target)
  if objvarGefesselt == true then
    _Urwigo.MessageBox({
      Text = "Du fummelst das Messer aus Deiner Hosentasche und schneidest den Knoten auf.",
      Media = objTaschenmesser,
      Callback = function(action)
        if action ~= nil then
          objvarGefesselt = false
          zHL.Active = true
          objSeil1.Opened = true
          objSeil1:MoveTo(zHZ)
          objSeil1.Visible = true
          objvarGeld = 10
          objGeld.Description = "Du hast 10 Euro"
          _Urwigo.MessageBox({
            Text = [[
Ein Glueck! Fawn hat die versteckte Geldtasche nicht gefunden!<BR>
Die 10 Euro sind noch da!<BR>
Auf ein Neues!]],
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
      Text = "hier ist nichts, was Du schneiden kannst.",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objTaschenmesser1:OncmdMessergeben(target)
  _Urwigo.MessageBox({
    Text = "Bist Du Dir sicher?",
    Media = objEngel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
BIST DU DIR WIRKLICH SICHER?<BR>
GANZ SICHER ???]],
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objTaschenmesser1:MoveTo(_G[currentCharacter])
                  _Urwigo.MessageBox({
                    Text = "Wenn das mal gut war ...",
                    Media = objEngel,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Gute Entscheidung!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung!",
            Media = objEngel,
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
end
function objTaschenmesser1:OncmdMesserwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "BIST DU DIR WIRKLICH SICHER???",
              Media = objEngel,
              Buttons = {"Ja", "Nein"},
              Callback = function(action)
                if action ~= nil then
                  if action == "Button1" then
                    objTaschenmesser1:MoveTo(_G[currentItem])
                    _Urwigo.MessageBox({
                      Text = "Wenn das mal gut war ...",
                      Media = objEngel,
                      Callback = function(action)
                        if action ~= nil then
                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                        end
                      end
                    })
                  else
                    _Urwigo.MessageBox({
                      Text = "Gute Entcheidung",
                      Media = objEngel,
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
            _Urwigo.MessageBox({
              Text = "Gute Entcheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFlascheWein:Oncmdkaufen(target)
  if objvarGeld > 15 then
    objvarGeld = objvarGeld + -15
    objFlascheWein.Locked = false
    objFlascheWein:MoveTo(Player)
    objFlascheWein.Commands.cmdkaufen.Enabled = false
    objFlascheWein.Commands.cmdprobieren.Enabled = false
    objFlascheWein.Commands.cmdeinstecken.Enabled = false
    objFlascheWein.Commands.cmdtrinken.Enabled = true
    objFlascheWein.Commands.cmdWeingeben.Enabled = true
    objGeld.Description = ("Du hast " .. objvarGeld) .. "Euro"
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = "Oje - kein Geld und Bedarf. Was nun? Doch mitnehmen?",
      Media = objKondom,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          objFlascheWein:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFlascheWein:Oncmdeinstecken(target)
  _Urwigo.MessageBox({
    Text = "Gute Idee. Das spart Geld!",
    Media = objTeufel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Eigentlich ja - aber bist Du Dir sicher?",
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objFlascheWein:MoveTo(Player)
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                else
                  _Urwigo.MessageBox({
                    Text = "Diese Idee ist besser!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Diese Idee ist besser!",
            Media = objEngel,
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
end
function objFlascheWein:Oncmdprobieren(target)
  if objFlascheWein.Locked == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Interessanter Geschmack. Der Kauf hat sich gelohnt. ",
        Media = objWein
      }
    }, function(action)
      objFlascheWein:MoveTo(zLI)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hallo Hallo. So geht das nicht, junger Mann. Erst kaufen, dann probieren!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFlascheWein:Oncmdtrinken(target)
  _Urwigo.MessageBox({
    Text = "Ich weiss ja, dass Du Durst hast. Aber glaubst Du wirklich, dieser Wein hilft Dir?",
    Media = objEngel,
    Buttons = {"aber ja", "na ja"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          Wherigo.PlayAudio(obj_audiotrinken)
          objFlascheWein:MoveTo(zLI)
          objvarDurst = 0
          objDurst:Stop()
          _Urwigo.MessageBox({
            Text = "Ups. Das Etikett haette mich warnen sollen. So gut war das nicht - und gegen den Durst? Na ja.",
            Media = objKlaus,
            Callback = function(action)
              if action ~= nil then
                objDurst:Start()
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Eine gute Entscheidung!",
            Media = objEngel,
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
end
function objFlascheWein:OncmdWeingeben(target)
  if target == Landstreicher then
    objFlascheWein:MoveTo(Landstreicher)
    if Player:Contains(objTaschenmesser1) then
      _Urwigo.MessageBox({
        Text = "Echt. Klasse. Mercie beaucoup. Dafuer moechte ich mich bedanken. Abber ich sehe, Du hast schon ein Taschenmesser, dann hoere mir gut zu: pass gut auf das Messer auf. Du wirst es noch brauchen!",
        Media = objLandstreicher,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      objTaschenmesser1:MoveTo(Player)
      _Urwigo.MessageBox({
        Text = "Echt. Klasse. Mercie beaucoup. Dafuer moechte ich mich mit meinem Taschenmesser bedanken. Es soll Dir Glueck bringen.",
        Media = objLandstreicher,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == objBetrunkene then
    objFlascheWein:MoveTo(zLI)
    _Urwigo.MessageBox({
      Text = [[
Uaegaldf &nbsp;... &nbsp;Whuhisskeyyy ... isss aaerr nischd dasfghgwezggggg &nbsp;&nbsp;&nbsp;&nbsp;egallll<BR>
gulpgulpgulp &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dnnnnkeeee]],
      Media = objfraubetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = [[
Aber Hallo. Denkst Du etwa, Du koenntest mich bestechen?<BR>
Sieh blos zu, dass Du Land gewinnst!]],
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = [[
Aber Hallo. Denkst Du etwa, Du koenntest mich bestechen?<BR>
Sieh blos zu, dass Du Land gewinnst!]],
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objPriester1 then
    objFlascheWein:MoveTo(zLI)
    _Urwigo.MessageBox({
      Text = [[
Das ist ein netter Zug von Dir. Aber das macht das Heiraten nicht einfacher.<BR>
Gebuehren sind Gebuehren!]],
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objFlascheWein:MoveTo(zLI)
            _Urwigo.MessageBox({
              Text = "Na ja. Falls Du ne Flasche Wein brauchst, Du weisst ja, wo Du welchen bekommst!",
              Media = objEngel,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objFlascheWein:OncmdWeinwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objFlascheWein:MoveTo(zLI)
    _Urwigo.MessageBox({
      Text = [[
Wenn das mal gut war ...<BR>
Ansonsten musst Du halt wieder einkaufen!]],
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objAschenbecher1:Oncmdputzen(target)
  if Player:Contains(objDiscopass1) then
    _Urwigo.MessageBox({
      Text = Player.Name .. ", Ordnung und Sauberkeit ist ja wichtig. Aber uebertreiben musst Du es nicht!",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objDiscopass1.Locked == false then
    _Urwigo.MessageBox({
      Text = Player.Name .. ", Du willst Dir doch nicht die Finger schmutzig machen!",
      Media = objTeufel,
      Buttons = {
        "Doch, Ordnung muss sein!",
        "Nein!"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = "Hoppla, was ist das denn? Beim Aufraeumen taucht ein blauer Zettel auf - ein Discoausweis!",
              Media = objErzaehler,
              Callback = function(action)
                if action ~= nil then
                  objDiscopass1.Visible = true
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = Player.Name .. ", glaubst Du wirklich, Du findest noch einen Disco-Pass?",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objAschenbecher1:Oncmddurchsuchen(target)
  _Urwigo.MessageBox({
    Text = [[
Hey Du Ferkel. Das ist ja ekelig.<BR>
Lass das mal.]],
    Media = objCroupier,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objSpielautomat1:Oncmdspielen(target)
  if objvarGewinn <= 250 then
    objSpieleinsatz.Text = ("Du hast " .. objvarGeld) .. [[
 Euro.<BR>
Wie viel willst Du setzen?]]
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objSpieleinsatz)
    end)
  else
    _Urwigo.MessageBox({
      Text = [[
Du hast den Maximalbetrag fuer diesen Besuch erspielt.<BR>
Rien ne va plus.]],
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objFreischaltcode:Oncmdaufschreiben(target)
  objFreischaltcode:MoveTo(Player)
  Notizbuch.Description = (Notizbuch.Description .. [[
<BR>
Der Freischaltcode ist ]]) .. string.sub(Player.CompletionCode, 1, 15)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objKoordinaten1:Oncmdaufschreiben(target)
  objKoordinaten1:MoveTo(Player)
  Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Das Grundbuch liegt bei N52-28,358 &nbsp;&nbsp;E013-07,127]]
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objVarieteplakat:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = "Das klingt interessant - und es ist kostenlos. Ich brauche also keinen VIP-Pass oder Discopass oder Geld. Klasse.",
    Media = objvarieteplakat,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objMobiltelefon1:Oncmdtelefonieren(target)
  Wherigo.PlayAudio(obj_audioshutdown)
  _Urwigo.MessageBox({
    Text = "Mist. Mit einem leisen Piep schaltet sich das Telefon ab. Akkus ist leer.",
    Media = objakkuleer,
    Callback = function(action)
      if action ~= nil then
        objMobiltelefon1.Commands.cmdtelefonieren.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objMobiltelefon1:OncmdMobiltelefongeben(target)
  _Urwigo.MessageBox({
    Text = "Findest Du es witzig, Dein leeres Telefon zu verschenken?",
    Media = objTeufel,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objMobiltelefon1:MoveTo(_G[currentCharacter])
          _Urwigo.MessageBox({
            Text = "Na ja, zumindest sind Deine Taschen jetzt nicht mehr so ausgebeult!",
            Media = objErzaehler,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Gute Entscheidung!",
            Media = objEngel,
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
end
function objMobiltelefon1:OncmdMobilelefonwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objMobiltelefon1:MoveTo(_G[currentItem])
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich. Das olle Teil hat ja eh nicht richtig funktioniert.",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objInfos:Oncmdanzeigen(target)
  _Urwigo.MessageBox({
    Text = ("Na, " .. Player.Name) .. ", brauchst Du",
    Media = objErzaehler,
    Buttons = {"Loesungen", "Tips"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = [[
Also eine Loesungshilfe ist doch wirklich nicht noetig.<BR>
<BR>
]],
            Media = objTeufel,
            Buttons = {"Doch!", "stimmt!"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  _Urwigo.MessageBox({
                    Text = [[
Na dann:<BR>
- schau mal bei Tante google nach Leisure Suit Larry in the Land of the Lounge Lizards,<BR>
- beschaffe dir Geld im Casino, denn Du wirst es immer wieder brauchen.]],
                    Media = objErzaehler,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = "Dann weiterhin viel Spass beim Spielen.",
                    Media = objErzaehler,
                    Callback = function(action)
                      if action ~= nil then
                        _Urwigo.MessageBox({
                          Text = "Und immer schoen artig bleiben!",
                          Media = objTeufel,
                          Callback = function(action)
                            if action ~= nil then
                              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                            end
                          end
                        })
                      end
                    end
                  })
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = ("Also, " .. Player.Name) .. [[
, pass mal auf:<BR>
- warst Du schon einkaufen?<BR>
- Sauberkeit ist wichtig!<BR>
- Reden hilft.<BR>
- Geschenke erhalten die Freundschaft.<BR>
- Lesen bildet.<BR>
- Betrunkene haben auch ihren Charme.<BR>
- Alleine essen macht dick.<BR>
- Neugier ist nie verkehrt.]],
            Media = objErzaehler,
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
end
function objSchild:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = [[
Hier steht sogar 'ne Nummer:<BR>
Taxi Schmidt, Kladow, 01723939563]],
    Media = objTaxischild,
    Callback = function(action)
      if action ~= nil then
        objSchild.Commands.cmdTaxirufen.Enabled = true
        if objNummerTaxiSchmidt.Visible == false then
          objNummerTaxiSchmidt.Visible = true
          Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Taxi Schmidt, Kladow, 01723939563]]
        end
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objSchild:OncmdTaxirufen(target)
  _Urwigo.MessageBox({
    Text = [[
Also wirklich. Glaubst Du echt, hier in der Fussgaengerzone ist ein Taxi notwendig?<BR>
Was bist Du den fuer ein Cacher!]],
    Media = objTaxischild,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFilmdose1:Oncmdansehen(target)
  objGeocoin.Visible = true
  objFilmdose1.Locked = false
  _Urwigo.MessageBox({
    Text = [[
Na ja - warum solltest Du es gerade hier zu einem FTF bringen.<BR>
Aber hoppla, was ist das da? Was da aus der Dose kullert?]],
    Media = objlogbuch,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFilmdose1:OncmdFilmdosewegwerfen(target)
  if target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du etwa doch ein Muggel?",
      Media = objTeufel,
      Buttons = {"aber ja", "NEIN!"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = Player.Name .. ", Du bist eine Enttaeuschung!",
              Media = objEngel,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = Player.Name .. ", ich bin stolz auf Dich!",
              Media = objEngel,
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
    _Urwigo.MessageBox({
      Text = "Du Boeser Bube! Bist Du Dir sicher?",
      Media = objTeufel,
      Buttons = {
        "aber ja",
        "ne, lieber nicht"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            Wherigo.PlayAudio(obj_audiomalestop)
            _Urwigo.MessageBox({
              Text = [[
Ick glob mein Schwein pfeift. Umweltverschmutzung?<BR>
Das macht mann doch nicht!]],
              Media = objPolizist,
              Callback = function(action)
                if action ~= nil then
                  Spielende()
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = Player.Name .. ", das war eine weise Entscheidung!",
              Media = objEngel,
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
  end
end
function objFilmdose1:Oncmdeintragen(target)
  _Urwigo.MessageBox({
    Text = "Ist zwar kein FTF, STF oder TTF. Aber loggen gehoert nun mal dazu.",
    Media = objlogbuch,
    Callback = function(action)
      if action ~= nil then
        if objFilmdose1.Opened == false then
          objFilmdose1.Opened = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        else
          _Urwigo.MessageBox({
            Text = "Einmal eintragen reicht doch!",
            Media = objEngel,
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
end
function objFilmdose1:Oncmdverstecken(target)
  objFilmdose1.Visible = false
  objGeocoin.Visible = false
end
function objTelefonzelle1:Oncmdsetzen(target)
  _Urwigo.MessageBox({
    Text = [[
Oh - ein Platz zum ausruhen. Na besser als nichts.<BR>
Huch - was ist das denn - unter der Sitzflaeche?]],
    Media = objTelefonzelle,
    Callback = function(action)
      if action ~= nil then
        objFilmdose1.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objTelefonzelle1:Oncmdtelefonieren(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objTelefonnummer)
  end)
end
function objFenster1:Oncmdoeffnen(target)
  Wherigo.PlayAudio(obj_audioFenster)
  _Urwigo.MessageBox({
    Text = "Mit einem lauten Knarren oeffnest Du das Fenster. Ob die frische Luft vom Hinterhof eine Verbesserung darstellt, na ja.",
    Media = objFenster,
    Callback = function(action)
      if action ~= nil then
        objFenster1.Opened = true
        zHG.Active = true
        objFenster1.Commands.cmdschliessen.Enabled = true
        objFenster1.Commands.cmdoeffnen.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFenster1:Oncmdschliessen(target)
  Wherigo.PlayAudio(obj_audioFenster)
  _Urwigo.MessageBox({
    Text = "Mit lautem Fluchen schliesst Du das Fenster. Immerhin riecht es im Zimmer jetzt deutlich besser.",
    Media = objFenster,
    Callback = function(action)
      if action ~= nil then
        objFenster1.Opened = false
        objFenster1.Commands.cmdoeffnen.Enabled = true
        objFenster1.Commands.cmdschliessen.Enabled = false
        zHG.Active = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objWandtelefon1:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = "Leider haben ein paar Vandalen das Telefon mit Kaugummi beschaedigt.",
    Media = objWandtelefon,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objWandtelefon1:Oncmdtelefonieren(target)
  _Urwigo.MessageBox({
    Text = "Du hast Dir das Telefon doch angesehen, oder?",
    Media = objWandtelefon,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Wenn Du weisst, dass es kaputt ist, warum versuchst Du dann zu telefonieren?",
            Media = objWandtelefon,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Na dann ...",
            Media = objWandtelefon,
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
end
function objTelefon1:Oncmdansehen(target)
  _Urwigo.MessageBox({
    Text = "Oh - scheint kaputt zu sein. Oder funktioniert der Hoerer jetzt mit Funk?",
    Media = objTelefon,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objTelefon1:Oncmdtelefonieren(target)
  _Urwigo.MessageBox({
    Text = "Du hast Dir das Telefon doch angesehen, oder?",
    Media = objTelefon,
    Buttons = {"ja", "nein"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Wenn Du weisst, dass es kaputt ist, warum versuchst Du dann zu telefonieren?",
            Media = objTelefon,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = "Na dann ...",
            Media = objTelefon,
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
end
function objWaschbecken2:OncmdHaendewaschen(target)
  _Urwigo.MessageBox({
    Text = "Du drehst den Heisswasserhahn auf und und mit einem sanften perlenden Strahl rinnt der Schmutz von Deinen Haenden.",
    Media = objWaschbecken,
    Callback = function(action)
      if action ~= nil then
        objWaschbecken1.Opened = true
        _Urwigo.MessageBox({
          Text = "Im Augenwinkel siehts Du etwas auf dem Spiegel.",
          Media = objSpiegel,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end
  })
end
function objWaschbecken2:Oncmdtrinken(target)
  _Urwigo.MessageBox({
    Text = "Durst ist schon schlimm. Aber in diesem edlen Ambiente kommt sogar das Wasser aus San Pellegrino und schmeckt nach einem fitzelchen Limone.",
    Media = objWaschbecken,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objSpiegel2:Oncmdbetrachten(target)
  if objWaschbecken1.Opened == false then
    _Urwigo.MessageBox({
      Text = ("Oje " .. Player.Name) .. ", der Tag ist bisher auch nicht spurlos an Dir voruebergegangen.",
      Media = objspiegelklaus,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Im feuchten Spiegel siehst Du einen Kniff, wie das Spielergebnis im Casino verbessert werden kann. Na dann mal los!",
      Media = objSpiegel,
      Callback = function(action)
        if action ~= nil then
          if iT == 0 then
            iT = 1
          else
            iT = 2
          end
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPuppe:Oncmdbenutzen(target)
  if objbPuppe == false then
    objbPuppe = true
    _Urwigo.MessageBox({
      Text = [[
Okay - der Anblick ist nicht besonders, und auch das Gefuehl bleibt auf der Strecke.<BR>
Aber bisher lief es alles andere als rund. Was solls.<BR>
Vielleicht wird es jetzt ja bessser.]],
      Media = objDoll,
      Callback = function(action)
        if action ~= nil then
          Wherigo.PlayAudio(obj_audiomaleorgasm)
          Wherigo.PlayAudio(obj_audiosteamburst)
          _Urwigo.MessageBox({
            Text = "Das ist wohl nicht Dein Tag. Mit einem satten Plopp reist eine Naht auf und die Puppe fliegt davon.",
            Media = objTeufel,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = [[
Du siehst gerade noch, wie die Puppe mit einem letzten Seufzer im Wellnessbereich des nahegelegenen Hotels landet.<BR>
Die Suche geht weiter.]],
                  Media = objWellnessbereich,
                  Callback = function(action)
                    if action ~= nil then
                      objPuppe:MoveTo(zHW)
                      objPuppe.Description = [[
Das Standartmodell von Enterprise.<BR>
Nicht besonders huebsch, und hier ist sogar die Luft endgueltig raus!]]
                      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                    end
                  end
                })
              end
            end
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Du hast es ja echt noetig, aus dieser schlappen Huelle noch das letzte rauszuholen!",
      Media = objTeufel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          Wherigo.PlayAudio(obj_audiomaleorgasm)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objPuppe:Oncmdmitnehmen(target)
  _Urwigo.MessageBox({
    Text = [[
Bist Du Dir sicher, dass Du mit dieser Begleitung durch Spandau laufen willst?<BR>
Auf der anderen Seite, Du hast recht. Es koennte Leute geben, die etwas Naehe und Waerme gebrauchen koennen.]],
    Media = objTeufel,
    Buttons = {"aber ja", "na ja"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objPuppe:MoveTo(Player)
          objPuppe.Commands.cmdweglegen.Enabled = true
          objPuppe.Commands.cmdPuppegeben.Enabled = true
          objPuppe.Commands.cmdmitnehmen.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        else
          _Urwigo.MessageBox({
            Text = Player.Name .. ", Du verblueffst mich.",
            Media = objEngel,
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
end
function objPuppe:Oncmdweglegen(target)
  objPuppe:MoveTo(_G[currentZone])
  objPuppe.Commands.cmdmitnehmen.Enabled = true
  objPuppe.Commands.cmdweglegen.Enabled = false
  _Urwigo.MessageBox({
    Text = "Das war eine weise Entscheidung, " .. Player.Name,
    Media = objEngel,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objPuppe:OncmdPuppegeben(target)
  objPuppe:MoveTo(_G[currentCharacter])
  _Urwigo.MessageBox({
    Text = "Eine gute Entscheidung.",
    Media = objEngel
  })
end
function objGlastuer:Oncmdoeffnen(target)
  Wherigo.PlayAudio(obj_audiofemalestop)
  _Urwigo.Dialog(false, {
    {
      Text = "Hey - was soll das? Du bist doch kein Gast hier. Zugang ist nur fuer Gaeste!",
      Media = objEmpfangsdame
    },
    {
      Text = "Aber - etwas Entspannung tut doch gut. Eine Ausnahme ist doch sicher drin?",
      Media = objKlaus
    },
    {
      Text = "Nichts da. Mein Tag lief eh schon nicht so gut. Und jetzt noch das hier. &nbsp;So einfach geht das nicht.",
      Media = objEmpfangsdame
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objCurrywurststand:OncmdCurrywurstkaufen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Oh - lecker! Da nehme ich eine. Was macht das?",
      Media = objKlaus
    },
    {Text = "5 Euro!", Media = objcurryverkaeufer}
  }, function(action)
    if objvarGeld > 5 then
      objvarGeld = objvarGeld + -5
      objCurrywurst:MoveTo(Player)
      objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = false
      objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
      _Urwigo.MessageBox({
        Text = "Mir laeuft das Wasser im Mund zusammen!",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Mist. Dann bis spaeter. Ich kommen bestimmt wieder!",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end)
end
function objCurrywurststand:OncmdColakaufen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Oh - lecker! Da nehme ich eine. Was macht das?",
      Media = objKlaus
    },
    {Text = "3 Euro!", Media = objcurryverkaeufer}
  }, function(action)
    if objvarGeld > 3 then
      objvarGeld = objvarGeld + -3
      objCola:MoveTo(Player)
      objCurrywurststand.Commands.cmdColakaufen.Enabled = false
      objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
      _Urwigo.MessageBox({
        Text = "Mir laeuft das Wasser im Mund zusammen!",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Mist. Dann bis spaeter. Ich kommen bestimmt wieder!",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end)
end
function objCurrywurst:Oncmdessen(target)
  objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
  objCurrywurst:MoveTo(objCurrywurststand)
  objHunger:Stop()
  objvarHunger = 0
  objHunger:Start()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objCurrywurst:OncmdWurstgeben(target)
  if target == Landstreicher then
    objCurrywurst:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
    _Urwigo.Dialog(false, {
      {
        Text = "Ich habe zwar nicht viel, was ich mit Dir teilen kann, aber wie waere es mit einer Currywurst?",
        Media = objKlaus
      },
      {
        Text = [[
Currywurst? &nbsp;Ein Traum. Seit heute morgen habe ich nur Aepfel gegessen, die sind zwar gesund, aber ich bin doch kein Pferd.<BR>
Currywurst waere ein Traum!]],
        Media = objLandstreicher
      },
      {
        Text = "Der in Erfuellung geht!",
        Media = objKlaus
      }
    }, function(action)
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.25 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Pass in den dunklen Gassen auf Dich auf!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif _rndChoiceValue < 0.5 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Wasser ist kostbar - aber nicht immer die Quelle des Lebens!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif _rndChoiceValue < 0.75 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Auch in der Hoelle gibt es gute Menschen!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Zuviel Essen ist ungesund!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = "Die Idee ist nicht schlecht - aber auch wenn Liebe durch den Magen geht, Du kommst hier nicht rein!",
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Glaubst Du, diese Figur vertraegt eine Currywurst?",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Glaubst Du, meine Kopfschmerzen werden durch Glutamat besser?",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Dieses Wuerstchen ueberzeugt mich nicht!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Landwirt then
    objCurrywurst:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
    objApfel1:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = "Das ist ja eine nette Geste. Dafuer schenke ich Dir einen Apfel.",
      Media = objLandwirt,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBetrunkene then
    objCurrywurst:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
    _Urwigo.MessageBox({
      Text = "Buaehhh glp brrr Cuaerrywursch rrrgacfvsavb",
      Media = objfraubetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Ohhh - lecker. Aber das geht hier nicht.",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Ohhh - lecker. Aber das geht hier nicht.",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Also dieses Wuerstchen - na ja. Groesse ist schon wichtig.",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    _Urwigo.MessageBox({
      Text = "Ihhhh - was ist das denn?",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objKauffrau then
    _Urwigo.MessageBox({
      Text = "Oh - ein Traum. Schade, dass ich keine Pause habe.",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBartender1 then
    _Urwigo.MessageBox({
      Text = "Klasse Idee! Und ein Tipp: der Gorilla hinter der Tuer braucht Ablenkung.",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber ich bin im Dienst!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objPriester1 then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber ich bin im Dienst!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objSchlaeger then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber das hilft Dir nicht weiter.",
      Media = objschlaegerei,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objHund1 then
    objCurrywurst:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
    objPissen:Stop()
    objbHundCurry = true
    Wherigo.PlayAudio(obj_audiobellen)
    _Urwigo.MessageBox({
      Text = "Du bist doch ein Guter!",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objCurrywurst:OncmdWurstwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objCurrywurst:MoveTo(_G[currentItem])
    objCurrywurststand.Commands.cmdCurrywurstkaufen.Enabled = true
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich.",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objCola:Oncmdtrinken(target)
  Wherigo.PlayAudio(obj_audiotrinken)
  objCurrywurststand.Commands.cmdColakaufen.Enabled = true
  objCola:MoveTo(objCurrywurststand)
  objDurst:Stop()
  objvarDurst = 0
  _Urwigo.MessageBox({
    Text = "Ahhhhh - das tat gut!",
    Callback = function(action)
      if action ~= nil then
        objDurst:Start()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objCola:OncmdColageben(target)
  objCola:MoveTo(objCurrywurststand)
  objCurrywurststand.Commands.cmdColakaufen.Enabled = true
  if target == Landstreicher then
    objCola:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdColakaufen.Enabled = true
    _Urwigo.Dialog(false, {
      {
        Text = "Ich habe zwar nicht viel, was ich mit Dir teilen kann, aber wie waere es mit einer Cola?",
        Media = objKlaus
      },
      {
        Text = "Cola? &nbsp;Na ja, Rotwein ist auf Dauer auch nicht das Beste. Eine kleine Abwechslung waere ein Traum.",
        Media = objLandstreicher
      },
      {
        Text = "Der in Erfuellung geht!",
        Media = objKlaus
      }
    }, function(action)
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.25 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Pass in den dunklen Gassen auf Dich auf!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif _rndChoiceValue < 0.5 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Wasser ist kostbar - aber nicht immer die Quelle des Lebens!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      elseif _rndChoiceValue < 0.75 then
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Auch in der Hoelle gibt es gute Menschen!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = [[
Ich danke Dir. Und ein kleiner Rat:<BR>
Zuviel Essen ist ungesund!]],
          Media = objLandstreicher,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = "Die Idee ist nicht schlecht - aber auch wenn Liebe durch den Magen geht, Du kommst hier nicht rein!",
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objFawn1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Glaubst Du, diese Figur vertraegt eine Cola?",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Glaubst Du, meine Kopfschmerzen werden durch Zucker und Koffein besser?",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objMonique then
    _Urwigo.MessageBox({
      Text = "Also wirklich? Dieses Zueckerli ueberzeugt mich nicht!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Landwirt then
    objCola:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdColakaufen.Enabled = true
    objApfel1:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = "Das ist ja eine nette Geste. Dafuer schenke ich Dir einen Apfel.",
      Media = objLandwirt,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBetrunkene then
    objCola:MoveTo(objCurrywurststand)
    objCurrywurststand.Commands.cmdColakaufen.Enabled = true
    _Urwigo.MessageBox({
      Text = "Buaehhh glp brrr Golllaaaaa rrrgacfvsavb",
      Media = objfraubetrunken,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Zigarettengirl then
    _Urwigo.MessageBox({
      Text = "Ohhh - lecker. Aber das geht hier nicht.",
      Media = objZigarettengirl,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objCroupier1 then
    _Urwigo.MessageBox({
      Text = "Ohhh - lecker. Aber das geht hier nicht.",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBlondine then
    _Urwigo.MessageBox({
      Text = "Also das hier soll mich aufputschen, entfachen ???",
      Media = objbarfrau,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objEva then
    _Urwigo.MessageBox({
      Text = "Ihhhh - was ist das denn? Naturrain ist das nicht!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objKauffrau then
    _Urwigo.MessageBox({
      Text = "Oh - ein Traum. Schade, dass ich keine Pause habe.",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objBartender1 then
    _Urwigo.MessageBox({
      Text = "Klasse Idee! Und was glaubst Du, mache ich hier?",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber ich bin im Dienst!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objPriester1 then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber ich bin im Dienst!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objSchlaeger then
    _Urwigo.MessageBox({
      Text = "Netter Versuch - aber das hilft Dir nicht weiter.",
      Media = objschlaegerei,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objCola:OncmdColawegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objCola:MoveTo(_G[currentItem])
    objCurrywurststand.Commands.cmdColakaufen.Enabled = true
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich.",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objStadtplan:Oncmdnehmen(target)
  objStadtplan:MoveTo(Player)
  objStadtplan.Commands.cmdnehmen.Enabled = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objStadtplan:OncmdStadtplanwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objStadtplan:MoveTo(_G[currentItem])
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich.",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objBiographie:Oncmdeinstecken(target)
  _Urwigo.MessageBox({
    Text = "Gute Idee. Das spart Geld!",
    Media = objTeufel,
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = "Eigentlich ja - aber bist Du Dir sicher?",
            Media = objEngel,
            Buttons = {"ja", "nein"},
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  objBiographie:MoveTo(Player)
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                else
                  _Urwigo.MessageBox({
                    Text = "Diese Idee ist besser!",
                    Media = objEngel,
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
          _Urwigo.MessageBox({
            Text = "Diese Idee ist besser!",
            Media = objEngel,
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
end
function objBiographie:Oncmdkaufen(target)
  if objvarGeld > 25 then
    objBiographie.Locked = false
    objBiographie:MoveTo(Player)
    objBiographie.Commands.cmdkaufen.Enabled = false
    objBiographie.Commands.cmdeinstecken.Enabled = false
    objBiographie.Commands.cmdBuchgeben.Enabled = true
    objvarGeld = objvarGeld + -25
    objGeld.Description = ("Du hast " .. objvarGeld) .. "Euro"
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  else
    _Urwigo.MessageBox({
      Text = "Ups. Du hast nicht genug Geld dabei. Willst Du das Magazin dennoch mitnehmen?",
      Media = objMagazin,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          objBiographie:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objBiographie:Oncmdlesen(target)
  if objBiographie.Locked == false then
    objBiographie.Opened = true
    _Urwigo.Dialog(false, {
      {
        Text = [[
Larr Laffer - Mein Leben im Land der Salonloewen, meine Frauen und anderes mehr.<BR>
Was Mann tun und lassen sollte.]],
        Media = objlltitel
      },
      {
        Text = [[
Inhaltsverzeichnis<BR>
<BR>
Meine Frauen<BR>
- Pueppi,<BR>
- Hooker<BR>
- Reception girl<BR>
- Fawn - Koenigin der Disco<BR>
- Eve<BR>
<BR>
Ein Tag voll Leben in der Stadt<BR>
- Leftys Bar<BR>
- im Casino<BR>
- Disco Fever<BR>
- Shoppette<BR>
- Hochzeitsglocken<BR>
- Der Wellnessbereich im Hotel]],
        Media = objlltitel
      },
      {
        Text = [[
Pueppi<BR>
<BR>
Na ja - eher etwas fuer zwischendurch. Aber sie wies mir den Weg.]],
        Media = objlldoll
      },
      {
        Text = [[
Hooker<BR>
<BR>
Ein suesses Fruechtchen, an dem Mann sich verschlucken kann. Aufpassen hat sich hier gelohnt, bevor der Spass ins Auge ging.]],
        Media = objllhooker
      },
      {
        Text = [[
Reception girl<BR>
<BR>
Was fuer ein Empfang bot dieser Anblick im Hotel. Scharf.<BR>
Ja - wie ein Schwert und bissig wie ein Drache passte sie auf ihr Revier auf. Was Migraene doch aus einer Frau machen kann.<BR>
Gut, wenn man hier mit Pillen helfen kann.]],
        Media = objllempfangsdame
      },
      {
        Text = [[
Fawn. Koenigin der Disco.<BR>
<BR>
Eine Frau, die mich gefesselt hat, nicht nur nachdem ich sie mit Flirten, Geschenken und Tanzen fuer mich gewinnen konnte.<BR>
Wie anspruchsvoll sie war, habe ich leider zu spaet gemerkt. Wo sollte ich zum Beispiel auf die Schnelle in der Hochzeitssuite eine Flasche Wein beschaffen?<BR>
Gut, dass ich beim Versuc, etwas Romantik zu erzeugen das Radio anschaltete und im Radio ein 24-Stundenshop gerade Werbung fuer seinen Lieferservice machte!<BR>
War leider etwas teuer, aber nun ja. wer wird in so einer Nacht schon knausrig sein.]],
        Media = objllfawn
      },
      {
        Text = [[
Eve.<BR>
<BR>
Ja das war und ist sie - meine Traumfrau.<BR>
Gut, dass ich fuer diesen Augenblick im Paradies den richtigen Riecher hatte.<BR>
Von wegen romantischen Gedichten, ein einfacher Apfel war der Schluessel zum Herzen.]],
        Media = objlleve
      },
      {
        Text = [[
Leftys Bar<BR>
<BR>
Ein magischer Ort voller verrueckter Typen. Wichtig ist nur - aufpassen auf der Stra?e und in den dunklen Gassen.<BR>
Nichts wie raus aus den dunklen Ecken und rein ins Leben.]],
        Media = objllbarauen
      },
      {
        Text = [[
Der Bartender ist nett - erzaehlt nur ein bischen viel, und auch der Whiskey ist eher etwas zum verschenken. Aber dafuer ist die Stimmung klasse.<BR>
Frauen? Na ja. Die Blondine ist attraktiv. Aber sie bringt Dich nicht weiter. Weiter bringt Dich der Flur und die verschlossene Tuer. Denn wer klopfet, dem wird aufgetan &nbsp;- wenn er das Kennwort gelesen hat!<BR>
Wobei ich mich noch immer frage, was der Betrunkene im Flur mit der Rose und Fernbedienung will. Der braucht doch nur Alkohol.]],
        Media = objllbar
      },
      {
        Text = [[
Ja, die Toilette. Gruselig - aber interessante Waende. Viel Stoff zum Lesen. Aber blos nichts anfassen! Das Wasser reicht gerade mal, die Finger zu waschen.<BR>
Und das ist immer wieder mal notwendig.<BR>
Ansonsten: Finger weg!]],
        Media = objllbartoilette
      },
      {
        Text = "Oh ja - kaum hatte ich das Kennwort und damit den Eingang gefunden, kam das naechste Hindernis. Dieser tumbe Tor war doch tatsaechlich nicht zu bewegen. Was fuer ein Glueck, dass ich eine Ferbedienung hatte, mit der sich der Fernseher anschalten lies. Und kaum hatte ich den passenden Sender gefunden ging es ab ...",
        Media = objlltreppenhaus
      },
      {
        Text = [[
... ins Hinterzimmer. Hier gab es einiges an Suesskram. Mal mehr, mal weniger gut verdaulich.<BR>
Der Blick aus dem Fenster war zwar nicht der Beste, aber aus Respekt vor dem Brocken probierte ich diesen Weg - und das war gar nicht mal so schlecht. Selbst im Hinterhof gab es einiges zu entdecken. Problematisch waren nur die Schlaeger, die mir wenig Zeit liessen.]],
        Media = objllhinterzimmer
      },
      {
        Text = [[
Im Casino<BR>
<BR>
Eigentlich haette mich der arme Wicht mit seiner Geschichte und den Aepfeln abschrecken sollen. Aber Aepfel sind gesund und wer nichts wagt, der nichts gewinnt. Und am Gelde haengt am Ende alles.]],
        Media = objllcasino
      },
      {
        Text = [[
Hihihi. Wenn der Casino-Besitzer wuesste, dass die Automaten manipuliert werden koennen. Und haette er mehr fuer sein Personal ueber, waere dieses auch loyaler.<BR>
Wie so oft ist es das Personal, das einem hilft. Und gutes Personal ist nun mal teuer.]],
        Media = objllspielhalle
      },
      {
        Text = [[
Disco Fever<BR>
<BR>
Wo sollte ich wohl meine Traumfrau finden, wenn nicht in der Disco. Allerdings war der Tuerstehen ein unueberwindbares Hindernis - aber nicht fuer mich. Wozu gibt es VIP-Disco-Paesse.<BR>
Okay, es war Zufall und eher meinem Putzfimmel geschuldet. Aber das Glueck gehoert dem Tuechtigen!]],
        Media = objlldiscoaussen
      },
      {
        Text = [[
Und so lernte ich Fawn kennen. Mann o mann - gut, dass mein Anzug grosse Taschen hatte und ich unterwegs so vieles sammeln konnte.<BR>
Geschenke bringen einen weiter.]],
        Media = objlldisco
      },
      {
        Text = [[
Shoppette<BR>
<BR>
Gute, dass ich durch Zufall diesen Laden fand. Das aktuelle Geocaching-Magazin war richtig lesenswert. Und Kondome kann Mann immer brauchen.<BR>
Der Landstreicher hat mir zwar die Flasche Wein gleich wieder abgeschwatzt, aber sein Taschenmesser war letztendlich doch ein guter Tausch. So gut war der Wein dann doch nicht.]],
        Media = objllladen
      },
      {
        Text = [[
Hochzeitsglocken<BR>
<BR>
Meine Kapelle. Aussen unscheinbar und doch kam ich hier dem Himmel naeher. Wenn auch der Weg bis hierhin kostspielig war.<BR>
Ich musste nur Fawn fuer mich gewinnen.]],
        Media = objllkapelle
      },
      {
        Text = [[
Der Wellnessbereich im Hotel.<BR>
<BR>
Oben leuchteten die Sterne und unten leuchteten die Augen von Eve. Wie im Maerchen.<BR>
Es wurde sogar der Weg von einem Drachen versperrt.]],
        Media = objllwellness
      },
      {
        Text = [[
Hallo Freunde. So war mein Leben. Raus aus dem Sofa, rein in den Freizeitanzug und ins Leben.<BR>
Augen auf und aufpassen und das Glueck laeuft Dir ueber den Weg.<BR>
Lass Dich nicht von Fehlern entmutigen. Manchmal muss mann Fehler oder Umwege machen, um weiter zu kommen.]],
        Media = objLarry
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hallo Hallo. So geht das nicht, junger Mann. Erst kaufen, dann lesen!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objBiographie:OncmdBuchgeben(target)
  objBiographie:MoveTo(_G[currentCharacter])
  _Urwigo.MessageBox({
    Text = "Ich glaube, Du koenntest etwas Abwechslung gebrauchen. Hierr, nimm einfach.",
    Media = objKlaus,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objBiographie:OncmdBuchwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objBiographie:MoveTo(_G[currentItem])
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich!",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objGeocoin:Oncmdmitnehmen(target)
  _Urwigo.MessageBox({
    Text = ("Also wirklich " .. Player.Name) .. ", ich denke, Du schreibst Dir den Code auf und laesst die Coin noch fuer andere da!",
    Media = objEngel,
    Buttons = {"nein", "nja"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objGeocoin:MoveTo(Player)
          objGeocoin.Commands.cmdGeocCoingeben.Enabled = true
          objGeocoin.Commands.cmdmitnehmen.Enabled = false
        else
          Notizbuch.Description = Notizbuch.Description .. [[
<BR>
Easter Bunny GeoCoin - Trackingcode EAJHNB]]
        end
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objGeocoin:OncmdGeocCoingeben(target)
  if target == objFilmdose1 then
    objGeocoin:MoveTo(objFilmdose1)
    objGeocoin.Visible = false
    objGeocoin.Commands.cmdmitnehmen.Enabled = true
    _Urwigo.MessageBox({
      Text = "Na - es geht doch. Die Community wird sich freuen, dass die Coin noch da ist.",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Na ja - schoen, dass Du die Coin nicht behalten hast, aber ob der Empfaenger tatsaechlich weiss, was das ist?.",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
  objGeocoin.Commands.cmdGeocCoingeben.Enabled = false
end
function objGeld:OncmdGeldgeben(target)
  if target == objFawn1 then
    if objvarFawn == 4 then
      if objvarGeld > 100 then
        objvarGeld = objvarGeld + -100
        _Urwigo.MessageBox({
          Text = "Mein Held. Das Zimmer ist so gut wie gebucht. Wir sehen uns in der Kirche.",
          Media = objFawn,
          Callback = function(action)
            if action ~= nil then
              objFawn1:MoveTo(zKI)
              objFawn1.Commands.cmdtanzen.Enabled = false
              objFawn1.Commands.cmdanreden.Enabled = false
              bHZ = true
              objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = [[
Was ist an 100 Euro nicht zu verstehen?<BR>
Fuer eine Hochzeitsnacht brauchen wir schon ein Zimmer!]],
          Media = objFawn,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    else
      _Urwigo.MessageBox({
        Text = "Du hast ja echt miese Vorstellungen! Was glaubst Du denn, wer ich bin? So Eine auf jeden Fall nicht!",
        Media = objFawn,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == objPriester1 then
    if objvarGeld > 100 then
      bHB = true
      objvarGeld = objvarGeld + -100
      objGeld.Description = ("Du hast " .. objvarGeld) .. " Euro"
      KlausKlabuster:RequestSync()
      if zKI:Contains(objFawn1) then
        sI = [[
Mein Sohn, das freut mich!<BR>
Jetzt kann geheiratet werden!]]
      else
        sI = [[
Mein Sohn, das freut mich!<BR>
Aber Dir fehlt noch Deine Traumfau!<BR>
Worauf wartest Du? Los gehts!]]
      end
      _Urwigo.MessageBox({
        Text = "Pastor, ich moechte heiraten, die Gebuehren sind kein Problem. ",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = sI,
              Media = objPriester,
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
        Text = "Oh Vater &nbsp;- gerne wuerde ich ja Heiraten. Aber die Gebuehren - gibt es keine Ausnahme? Mein Geld reicht leider nicht.",
        Media = objKlaus,
        Callback = function(action)
          if action ~= nil then
            _Urwigo.MessageBox({
              Text = "Mein Sohn, die Spielhalle muss nicht immer die Hoelle sein. Manchmal muss man durch dunkle Gassen gehen, um ins Licht zu kommen.",
              Media = objPriester,
              Callback = function(action)
                if action ~= nil then
                  _Urwigo.MessageBox({
                    Text = "Suche Dein Glueck und komme wieder!",
                    Media = objPriester,
                    Callback = function(action)
                      if action ~= nil then
                        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                      end
                    end
                  })
                end
              end
            })
          end
        end
      })
    end
  elseif target == objTuersteher then
    _Urwigo.MessageBox({
      Text = [[
Was glaubst Du wer Du bist? Ich habe einen Ruf zu verlieren!<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Landstreicher then
    objvarBefehlsziel = "Landstreicher"
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objGeld1)
    end)
  elseif target == Landwirt then
    objvarBefehlsziel = "Landwirt"
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objGeld1)
    end)
  elseif target == objMonique then
    objvarBefehlsziel = "Monique"
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objGeld1)
    end)
  elseif target == Zigarettengirl then
    objvarBefehlsziel = "Zigarettengirl"
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objGeld1)
    end)
  elseif target == objCroupier1 then
    objvarBefehlsziel = "Croupier"
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objGeld1)
    end)
  elseif target == objEmpfangsdame1 then
    _Urwigo.MessageBox({
      Text = [[
Was glaubst Du wer Du bist? Ich habe einen Ruf zu verlieren!<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = [[
Was glaubst Du wer Du bist? Denkst Du, ich bin bestechlich?<BR>
Sieh zu, dass Du Land gewinnst!]],
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Also wirklich - Geld loest nicht alle Probleme!",
      Media = objTeufel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objZigaretten:OncmdZigarettengeben(target)
  if target == objTuersteher then
    objZigaretten:MoveTo(_G[currentCharacter])
    _Urwigo.MessageBox({
      Text = [[
Danke. Ein netter Zug von Dir. Aber das hilft Dir auch nicht.<BR>
Wenn Du kein VIP bist, oder einen Disco-Pass hast, kommst Du hier nicht rein!]],
      Media = objTursteherDisco,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == objPriester1 then
    objZigaretten:MoveTo(_G[currentCharacter])
    _Urwigo.MessageBox({
      Text = [[
Danke. Ein netter Zug von Dir. Aber das hilft Dir auch nicht.<BR>
Heiraten koset nun mal Geld!]],
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == Polizist then
    _Urwigo.MessageBox({
      Text = "Danke. Ein netter Zug von Dir. Aber ich rauche nicht. Und schon gar nicht im Dienst!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objZigaretten:MoveTo(_G[currentCharacter])
    _Urwigo.MessageBox({
      Text = "Na ja, zumindest sind Deine Taschen jetzt nicht mehr so ausgebeult!",
      Media = objErzaehler,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objZigaretten:Oncmdrauchen(target)
  if _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier raucht nur eins. Und das riecht dann nicht nach Zigarette!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Und ich dachte, Du bist Nichtraucher.",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hier ist Rauchverbot!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objKippe.Visible = true
    _Urwigo.MessageBox({
      Text = [[
Aaaaaahhhhhhhhhhhhhh<BR>
<BR>
Und Dir geht Truck Stop nicht aus dem Kopf:<BR>
Rauchen entspannt - kolossal,<BR>
wie du dann stinkst, ist dir egal.<BR>
Rauchen entspannt, rauchen tut gut,<BR>
zum aufhoern fehlt dann doch der Mut.]],
      Media = objzigarettenqualm,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objZigaretten:OncmdZigarettenwegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objZigaretten:MoveTo(_G[currentItem])
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich.",
      Media = objEngel
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objGlasWhiskey:OncmdWhiskeygeben(target)
  if target == objBetrunkene then
    _Urwigo.Dialog(false, {
      {
        Text = "da kann ich Dir helfen.",
        Media = objKlaus
      }
    }, function(action)
      objGlasWhiskey:MoveTo(objBetrunkene)
      _Urwigo.Dialog(false, {
        {
          Text = "glglglglgl - ahhhhh - besssr.",
          Media = objfraubetrunken
        },
        {
          Text = "Ischh wll mischh danken. Hicks. Hier isch wasch fur Dischhh",
          Media = objfraubetrunken
        }
      }, function(action)
        if objBetrunkene:Contains(objFernbedienung1) then
          objFernbedienung1:MoveTo(Player)
          _Urwigo.MessageBox({
            Text = "Oh - eine alte Fernbedienung. Na toll. Aber was solls. Haben ist besser als brauchen. Und so toll roch der Whiskey auch nicht.",
            Media = objFernbedienung,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = [[
Ssssuuu hrrrr sssuuu - hhuhhuuhnnnnd wrschssst nschd strullluliili<BR>
wschdschh]],
            Media = objfraubetrunken,
            Callback = function(action)
              if action ~= nil then
                Wherigo.ShowScreen(Wherigo.MAINSCREEN)
              end
            end
          })
        end
      end)
    end)
  else
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"ja", "nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objGlasWhiskey:MoveTo(_G[currentCharacter])
            _Urwigo.MessageBox({
              Text = [[
Wenn das mal gut war ...<BR>
Ansonsten musst Du halt wieder einkaufen!]],
              Media = objEngel,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung!",
              Media = objEngel,
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
  end
end
function objGlasWhiskey:OncmdWhiskywegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    _Urwigo.MessageBox({
      Text = "Bist Du Dir sicher?",
      Media = objEngel,
      Buttons = {"Ja", "Nein"},
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objGlasWhiskey:MoveTo(_G[currentItem])
            _Urwigo.MessageBox({
              Text = [[
Wenn das mal gut war ...<BR>
abe Du weisst ja, wo es welchen gibt!]],
              Media = objEngel,
              Callback = function(action)
                if action ~= nil then
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          else
            _Urwigo.MessageBox({
              Text = "Gute Entscheidung",
              Media = objEngel,
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
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objKippe:OncmdKippewegwerfen(target)
  if target == objAschenbecher1 or target == objMuelleimer then
    objKippe.Visible = false
    _Urwigo.MessageBox({
      Text = "Sehr ordentlich!",
      Media = objEngel,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objHure,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBT then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objbartreppenhaustuersteher,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zLI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objVerkaeuferin,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zDI then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objFawn,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHL then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCK then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objshow,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zCT then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objCroupier,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zKI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPriester,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHW then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEve,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zHZ then
    Wherigo.PlayAudio(obj_audiofemalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objEmpfangsdame,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBI then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBF then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _G[currentZone] == zBK then
    Wherigo.PlayAudio(obj_audiomalestop)
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objBartender,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hey Du Ferkel! Lass das bleiben!",
      Media = objPolizist,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objMuelleimer:Oncmdansehen(target)
  Landstreicher:MoveTo(zMP)
  Landstreicher.Visible = true
  _Urwigo.MessageBox({
    Text = [[
Hey! Du da! Finger weg. Das ist mein Revier.<BR>
Mein Leben ist schon schwer genug, so ohne Wein, Essen. Und jetzt suchst Du auch noch nach Leergut und machst mir das Pfandgeld streitig!<BR>
Das ist nicht fair!]],
    Media = objLandstreicher,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _Urwigo.GlobalZoneEnter()
  objaktuelleUmgebung.Description = _G[currentZone].Description
  objaktuelleUmgebung.Icon = _G[currentZone].Icon
  objaktuelleUmgebung.Media = _G[currentZone].Media
  objaktuelleUmgebung:MoveTo(_G[currentZone])
end
function Logbuch(value)
  Notizbuch.Beschreibung = (Notizbuch.Beschreibung .. "") .. value
end
function Spielstart()
  tFE.Visible = bStatusFE
  tGM.Visible = bStatusGM
  tL.Visible = bStatusL
  if tL.Visible == false then
    zBA.Active = true
    zCA.Active = true
    zDA.Active = true
    zHA.Active = true
    zLA.Active = true
    zMP.Active = true
    zKA.Active = true
  else
    zF1.Active = bzF1
    zF0.Active = bzF0
    zFC.Active = bzC
  end
end
function Spielende()
  bzF0 = zF0.Active
  bzF1 = zF1.Active
  bzC = zFC.Active
  bStatusFE = tFE.Visible
  bStatusGM = tGM.Visible
  bStatusL = tL.Visible
  tFE.Visible = false
  tGM.Visible = false
  tL.Visible = false
  zKI.Active = false
  zKA.Active = false
  zBA.Active = false
  zBI.Active = false
  zBF.Active = false
  zBK.Active = false
  zBT.Active = false
  zBZ.Active = false
  zHG.Active = false
  zCA.Active = false
  zCT.Active = false
  zCI.Active = false
  zCK.Active = false
  zDA.Active = false
  zDI.Active = false
  zHA.Active = false
  zHL.Active = false
  zHZ.Active = false
  zHW.Active = false
  zLA.Active = false
  zLI.Active = false
  zMP.Active = false
  zF1.Active = false
  zF0.Active = false
  zFC.Active = false
end
function TodPolizist()
  if Polizist.Visible == true and Player:Contains(objPuppe) then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.5 then
      Wherigo.PlayAudio(obj_audiomalestop)
      _Urwigo.Dialog(false, {
        {
          Text = "He - Du da. Stehenbleiben!",
          Media = objPolizist
        },
        {
          Text = "Ich? Warum denn?",
          Media = objKlaus
        },
        {
          Text = [[
a - weil ich es sage<BR>
b - weil das, was Du mit Dir rumschleppst, nichts fuer diese Stadt ist. Du kommst jetzt besser mal mit. Typen wie Dich wollen wir hier nicht haben.]],
          Media = objPolizist
        },
        {
          Text = [[
Oh Klaus - haettest Du mal auf mich gehoert. Hier kann ich Dir auch nicht mehr helfen.<BR>
Jetzt ist erst mal Pause angesagt. Such Dir mal auf dem Marktplatz eine Bank und warte 5min.]],
          Media = objEngel
        }
      }, SpielEnde())
      trPause:Start()
    else
      _Urwigo.MessageBox({
        Text = "Hey - Kerle - ich weiss zwar nicht, was oder wen Du da unter dem Arm traegst, aber das scheint nichts fuer die Oeffentlichkeit zu sein. Bring das besser Weg, bevor sich meine gute Laune verfluechtigt!!",
        Media = objPolizist
      })
    end
  else
  end
end
function TodDurst()
  _Urwigo.MessageBox({
    Text = "Das war es - Habe keine Lust mehr. Durst ist schlimmer als Heimweh und hier unheilbar. Schade. Jetzt such Dir auf dem Marktplatz mal ne Bank und mach 5min Pause!",
    Media = objErzaehler,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function TodWasser()
  _Urwigo.MessageBox({
    Text = [[
Habe ich Dich nicht davor gewarnt, das Wasser zu trinken?<BR>
Dieses leichte Gefuehl der Uebelkeit, die Schweissausbrueche und Hitzewallungen sind nur die ersten Symptome. Das wird noch schlimmer!<BR>
Ich denke, hier ist Pause fuer Dich. Such Dir auf dem Marktplatz ne Bank und mach mal 5min Pause!]],
    Media = objErzaehler,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function TodHIV()
  _Urwigo.MessageBox({
    Text = [[
Wurdest Du nicht davor gewarnt, es ohne zu tun?<BR>
Monique sah gut aus - aber reicht das auch?<BR>
Dieses leichte Gefuehl der Uebelkeit, die Schweissausbrueche und Hitzewallungen sind nur die ersten Symptome. Das wird noch schlimmer!<BR>
Ich denke, hier ist Pause fuer Dich. Such Dir auf dem Marktplatz ne Bank und mach mal 5min Pause!]],
    Media = objErzaehler,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function TodHunger()
  _Urwigo.MessageBox({
    Text = [[
Das war es - habe keine Lust mehr.<BR>
Essen und Liebe ist der Welt Getriebe - und beides laeuft nicht. Einfach Mist. Ich hoer auf! Pause fuer Dich. Such Dir auf dem Marktplatz ne Bank und mach mal 5min Pause!]],
    Media = objErzaehler,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function TodSchlaeger()
  _Urwigo.MessageBox({
    Text = "Das war es wohl. Zu langsam - zu viele. Dein Traum endet in einer dunklen Ecke von Spandau. Pause fuer Dich. Such Dir auf dem Marktplatz ne Bank und mach mal 5min Pause!",
    Media = objErzaehler,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function AnzeigeLandwirt(Ort)
  if Landwirt:Contains(objApfel1) then
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.75 then
      Landwirt.Visible = false
    else
      Landwirt:MoveTo(Ort)
      Landwirt.Visible = true
    end
  end
end
function AnzeigeLandstreicher(Ort)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.75 then
    Landstreicher.Visible = false
  else
    Landstreicher:MoveTo(Ort)
    Landstreicher.Visible = true
  end
end
function AnzeigePolizist(Ort)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.5 then
    Polizist:MoveTo(Ort)
    Polizist.Visible = true
  else
  end
end
function AnzeigeZigarettengirl(Ort)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.5 then
    Zigarettengirl:MoveTo(Ort)
    Zigarettengirl.Visible = true
  else
  end
end
function AnzeigePersonenAus()
  Polizist.Visible = false
  Landwirt.Visible = false
  Landstreicher.Visible = false
  Zigarettengirl.Visible = false
end
NL = ""
my_cartridge = nil
my_objects_names = {}
my_command_names = {}
my_befehl = ""
my_objects_nr = 0
my_current_object = 0
my_object1 = nil
my_object2 = nil
function get_object_by_name(object_name)
  local objects = my_cartridge.AllZObjects
  if object_name == "nil" then
    return nil
  elseif object_name == "Player" then
    return Player
  else
    local beginn, ende = string.find(object_name, "|")
    if beginn ~= nil then
      local akt_name = string.sub(object_name, 1, beginn - 1)
      for index = 1, #objects do
        local inhalt = objects[index]
        if akt_name == inhalt.Name then
          return inhalt
        end
      end
    end
  end
  return nil
end
function get_command_by_name(name)
  local objects = my_cartridge.AllZObjects
  local beginn, ende = string.find(name, "|")
  if beginn ~= nil then
    local akt_name = string.sub(name, 1, beginn - 1)
    for index = 1, #objects do
      local inhalt = objects[index]
      if akt_name == inhalt.Name then
        local akt_command = string.sub(name, beginn + 1)
        for key, value in pairs(inhalt.Commands) do
          if value.Text == akt_command then
            return value
          end
        end
      end
    end
  end
  return nil
end
function get_type(inhalt)
  local anfang, ende = string.find(tostring(inhalt), "ZCartridge")
  if anfang ~= nil then
    return "ZCartridge"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZCharacter")
  if anfang ~= nil then
    return "ZCharacter"
  end
  local anfang, ende = string.find(tostring(inhalt), "Zone")
  if anfang ~= nil then
    return "Zone"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZInput")
  if anfang ~= nil then
    return "ZInput"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZItem")
  if anfang ~= nil then
    return "ZItem"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZCommand")
  if anfang ~= nil then
    return "ZCommand"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZTask")
  if anfang ~= nil then
    return "ZTask"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZMedia")
  if anfang ~= nil then
    return "ZMedia"
  end
  local anfang, ende = string.find(tostring(inhalt), "ZObject")
  if anfang ~= nil then
    return "ZObject"
  end
  return "Unknown"
end
function get_target_info()
  local target_string = Env.Platform
  local target_identifier = "Unknown"
  if Env.Platform == "Win32" then
    target_identifier = "Emulator"
  elseif Env.Platform == "Vendor 1 ARM9" then
    target_identifier = "Garmin"
  elseif Env.Platform == "PocketPC 2003" then
    target_identifier = "Pocket PC"
  elseif Env.Platform == "MIDP-2.0/CLDC-1.1" then
    target_identifier = "OpenWIG_WhereYouGo"
  elseif Env.Platform == "iPhone OS 4.3.3" then
    target_identifier = "iPhone"
  end
  return target_string, target_identifier
end
function create_objects_name_list()
  local objects = my_cartridge.AllZObjects
  table.insert(my_objects_names, "nil")
  table.insert(my_objects_names, "Player")
  for index = 1, #objects do
    local inhalt = objects[index]
    local objname = inhalt.Name
    if objname == nil then
      objname = "Unknown"
    end
    local name = (objname .. "|") .. get_type(inhalt)
    table.insert(my_objects_names, name)
    if inhalt.Commands ~= nil then
      for key, value in pairs(inhalt.Commands) do
        local cmdname = value.Text
        if cmdname == nil then
          cmdname = "Unknown"
        end
        local commandtext = (inhalt.Name .. "|") .. cmdname
        table.insert(my_command_names, commandtext)
      end
    end
  end
end
function store_befehl(name)
  my_befehl = name
  my_current_object = 1
  if name == "Move to Object" then
    my_objects_nr = 2
  else
    my_objects_nr = 1
  end
  return my_objects_nr
end
function store_object(name)
  if my_current_object == 1 then
    my_object1 = name
  else
    my_object2 = name
  end
  my_current_object = my_current_object + 1
end
function print_befehl()
  local befehl = ""
  befehl = ((befehl .. my_befehl) .. " ") .. my_object1
  if my_objects_nr == 2 then
    befehl = (befehl .. " ") .. my_object2
  end
  debug_item.Description = (befehl .. NL) .. debug_item.Description
  debug_item.Description = string.sub(debug_item.Description, 1, 500)
end
function get_bool_state(boolean)
  local msg = "is now false"
  if boolean then
    msg = "is now true"
  end
  return msg
end
function debug_zone_verschieben(zone, distance)
  local dist = Wherigo.Distance(distance, "m")
  local b = math.random(0, 360)
  local zone_name = "Unknown"
  if zone.Name ~= nil then
    zone_name = zone.Name
  end
  local msg = "Fehler Zone verschieben " .. zone.Name
  if get_type(zone) == "Zone" and zone ~= nil then
    msg = (((((" Zone " .. zone_name) .. " nach ") .. Player.ObjectLocation.latitude) .. " ") .. Player.ObjectLocation.longitude) .. " verschoben"
    local activation = zone.Active
    zone.Active = false
    zone.OriginalPoint = Wherigo.TranslatePoint(Player.ObjectLocation, dist, b)
    zone.Points = GetZonePoints(zone.OriginalPoint, 10)
    zone.Active = activation
  end
  return msg
end
function fuehre_befehl_aus(befehl, object1, object2)
  local msg = "OK"
  if object1 == nil or object1 == Player then
    msg = "nil oder Player ist als erstes Objekt eines Befehls nicht erlaubt"
    return msg
  end
  if befehl == "Toggle Visible" then
    if object1.Visible == nil then
      msg = ((befehl .. " ist bei Objekt ") .. object1.Name) .. " nicht erlaubt"
    else
      object1.Visible = not object1.Visible
      msg = (befehl .. " ") .. get_bool_state(object1.Visible)
    end
  elseif befehl == "Toggle Active" then
    if object1.Active == nil then
      msg = ((befehl .. " ist bei Objekt ") .. object1.Name) .. " nicht erlaubt"
    else
      object1.Active = not object1.Active
      msg = (befehl .. " ") .. get_bool_state(object1.Active)
    end
  elseif befehl == "Toggle Complete" then
    if object1.Complete == nil then
      msg = ((befehl .. " ist bei Objekt ") .. object1.Name) .. " nicht erlaubt"
    else
      object1.Complete = not object1.Complete
      msg = (befehl .. " ") .. get_bool_state(object1.Complete)
    end
  elseif befehl == "Move to Object" then
    object1:MoveTo(object2)
    msg = "Moveto ausgefuehrt ohne Plausi-Pruefung"
  elseif befehl == "Move Zone here" then
    msg = debug_zone_verschieben(object1, 0)
    debug_item.Description = (msg .. NL) .. debug_item.Description
  elseif befehl == "Move Zone away" then
    msg = debug_zone_verschieben(object1, 50)
    debug_item.Description = (msg .. NL) .. debug_item.Description
  end
  return msg
end
function befehl_ausfuehren()
  local object1, object2
  local msg = "OK"
  object1 = get_object_by_name(my_object1)
  msg = (msg .. " ") .. my_befehl
  if my_objects_nr == 2 then
    object2 = get_object_by_name(my_object2)
  end
  debug_item.Description = ("Befehl wird ausgefuehrt" .. NL) .. debug_item.Description
  msg = fuehre_befehl_aus(my_befehl, object1, object2)
  return msg
end
function toggle_command(answer)
  local msg = "Fehler, Command not found"
  local command = get_command_by_name(answer)
  if command ~= nil then
    command.Enabled = not command.Enabled
    msg = (answer .. " ") .. get_bool_state(command.Enabled)
    debug_item.Description = ((("Toggle Command " .. answer) .. " wird ausgefuehrt") .. NL) .. debug_item.Description
  end
  return msg
end
function init_debug(cartridge)
  my_cartridge = cartridge
  create_objects_name_list()
  input_objects.Choices = my_objects_names
  input_commands.Choices = my_command_names
end
function GetZonePoints(refPt, radi)
  local dist = Wherigo.Distance(radi, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, dist, 22.5),
    Wherigo.TranslatePoint(refPt, dist, 67.5),
    Wherigo.TranslatePoint(refPt, dist, 112.5),
    Wherigo.TranslatePoint(refPt, dist, 157.5),
    Wherigo.TranslatePoint(refPt, dist, 202.5),
    Wherigo.TranslatePoint(refPt, dist, 247.5),
    Wherigo.TranslatePoint(refPt, dist, 292.5),
    Wherigo.TranslatePoint(refPt, dist, 337.5)
  }
  return pts
end
return KlausKlabuster
