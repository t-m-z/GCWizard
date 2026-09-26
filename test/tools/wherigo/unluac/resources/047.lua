require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _JH8(str)
  local res = ""
  local dtable = "}\019ym~T\r\006;\0266?[\001s\024wQ|O3k\"-^i\0291AVeS\021)%\020q9\015\016bj#L\005E\025@\003\002`gc<\017YnGI2\027W_z\014N\\ \f4\028P]lX8Rf0.\004a\ntuU\031\023{p\030\bDH(*h\018\v5\t&d+7r\022!MoKJZ:/x,F$BCv>\a'\000="
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
objKaufdorf = Wherigo.ZCartridge()
objHausb = Wherigo.ZMedia(objKaufdorf)
objHausb.Id = "1fd223f5-c233-41ba-8fdf-3837f3e3e1ca"
objHausb.Name = "Haus b"
objHausb.Description = ""
objHausb.AltText = ""
objHausb.Resources = {
  {
    Type = "jpg",
    Filename = "m_b.jpg",
    Directives = {}
  }
}
objHausa = Wherigo.ZMedia(objKaufdorf)
objHausa.Id = "89ffadd3-92f3-4345-9d09-d7db128339a6"
objHausa.Name = "Haus a"
objHausa.Description = ""
objHausa.AltText = ""
objHausa.Resources = {
  {
    Type = "jpg",
    Filename = "m_a.jpg",
    Directives = {}
  }
}
objHausc = Wherigo.ZMedia(objKaufdorf)
objHausc.Id = "1c5c3718-699a-45e0-8ed3-64b858212253"
objHausc.Name = "Haus c"
objHausc.Description = ""
objHausc.AltText = ""
objHausc.Resources = {
  {
    Type = "jpg",
    Filename = "m_c.jpg",
    Directives = {}
  }
}
objHausd = Wherigo.ZMedia(objKaufdorf)
objHausd.Id = "a2fa9663-572b-41b0-b379-95988f4b8446"
objHausd.Name = "Haus d"
objHausd.Description = ""
objHausd.AltText = ""
objHausd.Resources = {
  {
    Type = "jpg",
    Filename = "m_d.jpg",
    Directives = {}
  }
}
objHause = Wherigo.ZMedia(objKaufdorf)
objHause.Id = "372f613a-b33d-43b4-b903-fe89076904c3"
objHause.Name = "Haus e"
objHause.Description = ""
objHause.AltText = ""
objHause.Resources = {
  {
    Type = "jpg",
    Filename = "m_e.jpg",
    Directives = {}
  }
}
objHausf = Wherigo.ZMedia(objKaufdorf)
objHausf.Id = "bfb216e0-8000-4ec1-b426-1680813125db"
objHausf.Name = "Haus f"
objHausf.Description = ""
objHausf.AltText = ""
objHausf.Resources = {
  {
    Type = "jpg",
    Filename = "m_f.jpg",
    Directives = {}
  }
}
objHausg = Wherigo.ZMedia(objKaufdorf)
objHausg.Id = "1c6c41ee-8062-47d5-8155-a40cb49716ba"
objHausg.Name = "Haus g"
objHausg.Description = ""
objHausg.AltText = ""
objHausg.Resources = {
  {
    Type = "jpg",
    Filename = "m_g.jpg",
    Directives = {}
  }
}
objHaush = Wherigo.ZMedia(objKaufdorf)
objHaush.Id = "31685690-678c-48b3-9064-937aa32a6a71"
objHaush.Name = "Haus h"
objHaush.Description = ""
objHaush.AltText = ""
objHaush.Resources = {
  {
    Type = "jpg",
    Filename = "m_h.jpg",
    Directives = {}
  }
}
objHausi = Wherigo.ZMedia(objKaufdorf)
objHausi.Id = "c876fccd-1622-4021-ae09-1b88814f62c0"
objHausi.Name = "Haus i"
objHausi.Description = ""
objHausi.AltText = ""
objHausi.Resources = {
  {
    Type = "jpg",
    Filename = "m_i.jpg",
    Directives = {}
  }
}
objHausj = Wherigo.ZMedia(objKaufdorf)
objHausj.Id = "b70ff701-3475-4df0-b1db-e38544f4b16a"
objHausj.Name = "Haus j"
objHausj.Description = ""
objHausj.AltText = ""
objHausj.Resources = {
  {
    Type = "jpg",
    Filename = "m_j.jpg",
    Directives = {}
  }
}
objHausk = Wherigo.ZMedia(objKaufdorf)
objHausk.Id = "f4f942e0-222f-4538-985c-51c3b2b5ded5"
objHausk.Name = "Haus k"
objHausk.Description = ""
objHausk.AltText = ""
objHausk.Resources = {
  {
    Type = "jpg",
    Filename = "m_k.jpg",
    Directives = {}
  }
}
objHausl = Wherigo.ZMedia(objKaufdorf)
objHausl.Id = "1803e98c-b8e2-4e5b-a47f-60c478a2de52"
objHausl.Name = "Haus l"
objHausl.Description = ""
objHausl.AltText = ""
objHausl.Resources = {
  {
    Type = "jpg",
    Filename = "m_l.jpg",
    Directives = {}
  }
}
objHausm = Wherigo.ZMedia(objKaufdorf)
objHausm.Id = "bbd9b046-e677-4e42-9aca-ae346390c93a"
objHausm.Name = "Haus m"
objHausm.Description = ""
objHausm.AltText = ""
objHausm.Resources = {
  {
    Type = "jpg",
    Filename = "m_m.jpg",
    Directives = {}
  }
}
objHausn = Wherigo.ZMedia(objKaufdorf)
objHausn.Id = "d419ae3d-3c39-4d5b-aa99-2409d63924fb"
objHausn.Name = "Haus n"
objHausn.Description = ""
objHausn.AltText = ""
objHausn.Resources = {
  {
    Type = "jpg",
    Filename = "m_n.jpg",
    Directives = {}
  }
}
objHauso = Wherigo.ZMedia(objKaufdorf)
objHauso.Id = "99c3563e-a864-4e69-b465-d5069eb95eaf"
objHauso.Name = "Haus o"
objHauso.Description = ""
objHauso.AltText = ""
objHauso.Resources = {
  {
    Type = "jpg",
    Filename = "m_o.jpg",
    Directives = {}
  }
}
objHausp = Wherigo.ZMedia(objKaufdorf)
objHausp.Id = "c8e412be-18d3-4b45-a3ab-6a8f101bad11"
objHausp.Name = "Haus p"
objHausp.Description = ""
objHausp.AltText = ""
objHausp.Resources = {
  {
    Type = "jpg",
    Filename = "m_p.jpg",
    Directives = {}
  }
}
objia = Wherigo.ZMedia(objKaufdorf)
objia.Id = "f0826c48-09c3-479e-be9b-7ad0a5d5586e"
objia.Name = "i a"
objia.Description = ""
objia.AltText = ""
objia.Resources = {
  {
    Type = "jpg",
    Filename = "i_a.jpg",
    Directives = {}
  }
}
objib = Wherigo.ZMedia(objKaufdorf)
objib.Id = "26542ffd-b1da-4bc7-bc42-18cbb59753d4"
objib.Name = "i b"
objib.Description = ""
objib.AltText = ""
objib.Resources = {
  {
    Type = "jpg",
    Filename = "i_b.jpg",
    Directives = {}
  }
}
objic = Wherigo.ZMedia(objKaufdorf)
objic.Id = "ca1947ee-f363-4cf6-9076-e7bf44e2eee5"
objic.Name = "i c"
objic.Description = ""
objic.AltText = ""
objic.Resources = {
  {
    Type = "jpg",
    Filename = "i_c.jpg",
    Directives = {}
  }
}
objid = Wherigo.ZMedia(objKaufdorf)
objid.Id = "5d160126-50fe-41bd-ad7b-8b6e950f3b11"
objid.Name = "i d"
objid.Description = ""
objid.AltText = ""
objid.Resources = {
  {
    Type = "jpg",
    Filename = "i_d.jpg",
    Directives = {}
  }
}
objie = Wherigo.ZMedia(objKaufdorf)
objie.Id = "3b4df3e5-f440-4891-8cea-42518c43b25d"
objie.Name = "i e"
objie.Description = ""
objie.AltText = ""
objie.Resources = {
  {
    Type = "jpg",
    Filename = "i_e.jpg",
    Directives = {}
  }
}
objif = Wherigo.ZMedia(objKaufdorf)
objif.Id = "ccc7c249-e934-43fd-9cf2-38c2bb86965e"
objif.Name = "i f"
objif.Description = ""
objif.AltText = ""
objif.Resources = {
  {
    Type = "jpg",
    Filename = "i_f.jpg",
    Directives = {}
  }
}
objig = Wherigo.ZMedia(objKaufdorf)
objig.Id = "c2cf2874-7f67-47a3-80cb-755c9e7c10c4"
objig.Name = "i g"
objig.Description = ""
objig.AltText = ""
objig.Resources = {
  {
    Type = "jpg",
    Filename = "i_g.jpg",
    Directives = {}
  }
}
objih = Wherigo.ZMedia(objKaufdorf)
objih.Id = "a962f623-0171-4bc0-9340-7c54aedef79c"
objih.Name = "i h"
objih.Description = ""
objih.AltText = ""
objih.Resources = {
  {
    Type = "jpg",
    Filename = "i_h.jpg",
    Directives = {}
  }
}
objii = Wherigo.ZMedia(objKaufdorf)
objii.Id = "be2e3c41-ec86-4c7e-9c78-504978fd1d05"
objii.Name = "i i"
objii.Description = ""
objii.AltText = ""
objii.Resources = {
  {
    Type = "jpg",
    Filename = "i_i.jpg",
    Directives = {}
  }
}
objij = Wherigo.ZMedia(objKaufdorf)
objij.Id = "467eec78-f902-4f63-8899-c4522f18cfb6"
objij.Name = "i j"
objij.Description = ""
objij.AltText = ""
objij.Resources = {
  {
    Type = "jpg",
    Filename = "i_j.jpg",
    Directives = {}
  }
}
objik = Wherigo.ZMedia(objKaufdorf)
objik.Id = "ad3c4279-ce5c-41e0-b374-93e0cb92289f"
objik.Name = "i k"
objik.Description = ""
objik.AltText = ""
objik.Resources = {
  {
    Type = "jpg",
    Filename = "i_k.jpg",
    Directives = {}
  }
}
objil = Wherigo.ZMedia(objKaufdorf)
objil.Id = "3059e60e-2554-4eb6-9ebe-d068960de745"
objil.Name = "i l"
objil.Description = ""
objil.AltText = ""
objil.Resources = {
  {
    Type = "jpg",
    Filename = "i_l.jpg",
    Directives = {}
  }
}
objim = Wherigo.ZMedia(objKaufdorf)
objim.Id = "dacdea06-4407-4368-989f-a2d912759d50"
objim.Name = "i m"
objim.Description = ""
objim.AltText = ""
objim.Resources = {
  {
    Type = "jpg",
    Filename = "i_m.jpg",
    Directives = {}
  }
}
objin = Wherigo.ZMedia(objKaufdorf)
objin.Id = "4319c52f-34b0-4d06-bbb5-1353f9a233f2"
objin.Name = "i n"
objin.Description = ""
objin.AltText = ""
objin.Resources = {
  {
    Type = "jpg",
    Filename = "i_n.jpg",
    Directives = {}
  }
}
objip = Wherigo.ZMedia(objKaufdorf)
objip.Id = "f375c8d3-361c-4cbc-ab02-e273538289fc"
objip.Name = "i p"
objip.Description = ""
objip.AltText = ""
objip.Resources = {
  {
    Type = "jpg",
    Filename = "i_p.jpg",
    Directives = {}
  }
}
objio = Wherigo.ZMedia(objKaufdorf)
objio.Id = "4d7510bf-d4c6-493f-af56-257d9446b8cc"
objio.Name = "i o"
objio.Description = ""
objio.AltText = ""
objio.Resources = {
  {
    Type = "jpg",
    Filename = "i_o.jpg",
    Directives = {}
  }
}
objSueddorf = Wherigo.ZMedia(objKaufdorf)
objSueddorf.Id = "cc1dfb10-03c7-431b-81eb-ab66c84a2a64"
objSueddorf.Name = "Sueddorf"
objSueddorf.Description = ""
objSueddorf.AltText = ""
objSueddorf.Resources = {
  {
    Type = "jpg",
    Filename = "sueddorf.jpg",
    Directives = {}
  }
}
objNorddorf = Wherigo.ZMedia(objKaufdorf)
objNorddorf.Id = "5be3a350-a18f-43af-ac3c-f61b73bb17e6"
objNorddorf.Name = "Norddorf"
objNorddorf.Description = ""
objNorddorf.AltText = ""
objNorddorf.Resources = {
  {
    Type = "jpg",
    Filename = "norddorf.jpg",
    Directives = {}
  }
}
objEingang = Wherigo.ZMedia(objKaufdorf)
objEingang.Id = "670b6a35-b42b-42f1-8a74-831b85ec192c"
objEingang.Name = "Eingang"
objEingang.Description = ""
objEingang.AltText = ""
objEingang.Resources = {
  {
    Type = "jpg",
    Filename = "m_eingang.jpg",
    Directives = {}
  }
}
objifinal = Wherigo.ZMedia(objKaufdorf)
objifinal.Id = "c2df6f7d-95db-42b8-919f-0d3a34423502"
objifinal.Name = "i final"
objifinal.Description = ""
objifinal.AltText = ""
objifinal.Resources = {
  {
    Type = "jpg",
    Filename = "i_Schatztruhe.jpg",
    Directives = {}
  }
}
objmfinal = Wherigo.ZMedia(objKaufdorf)
objmfinal.Id = "99db3740-81af-4014-b1f2-5da2afbfec6d"
objmfinal.Name = "m final"
objmfinal.Description = ""
objmfinal.AltText = ""
objmfinal.Resources = {
  {
    Type = "jpg",
    Filename = "m_Schatztruhe.jpg",
    Directives = {}
  }
}
obji_Tor = Wherigo.ZMedia(objKaufdorf)
obji_Tor.Id = "e04d37f1-7740-424c-9f7a-0aafa8d5c116"
obji_Tor.Name = "i_Tor"
obji_Tor.Description = ""
obji_Tor.AltText = ""
obji_Tor.Resources = {
  {
    Type = "jpg",
    Filename = "i_B5_Eingang.jpg",
    Directives = {}
  }
}
objm_tor = Wherigo.ZMedia(objKaufdorf)
objm_tor.Id = "c6f17322-c509-451a-8b97-ff4db4491dd8"
objm_tor.Name = "m_tor"
objm_tor.Description = ""
objm_tor.AltText = ""
objm_tor.Resources = {
  {
    Type = "jpg",
    Filename = "m_B5_Eingang.jpg",
    Directives = {}
  }
}
obji_tafel = Wherigo.ZMedia(objKaufdorf)
obji_tafel.Id = "461835dc-6abd-4bf3-99e4-3296107460ae"
obji_tafel.Name = "i_tafel"
obji_tafel.Description = ""
obji_tafel.AltText = ""
obji_tafel.Resources = {
  {
    Type = "jpg",
    Filename = "i_tafel.jpg",
    Directives = {}
  }
}
objm_tafel = Wherigo.ZMedia(objKaufdorf)
objm_tafel.Id = "5282330c-4ad2-4854-a2ed-ef3cd8d56838"
objm_tafel.Name = "m_tafel"
objm_tafel.Description = ""
objm_tafel.AltText = ""
objm_tafel.Resources = {
  {
    Type = "jpg",
    Filename = "m_tafel.jpg",
    Directives = {}
  }
}
objKaufdorf.Id = "e8c98ed5-3a1a-4c24-b4bd-8cd2409074be"
objKaufdorf.Name = "Kaufdorf"
objKaufdorf.Description = "Das ehemalige \"B5 Center\" wurde 2009 zum \"Designer Outlet Center\" umgebaut, einem Shopping Village (neudeutsch f\195\188r Kaufdorf) mit nett gemachten H\195\164usern, die es sich n\195\164her anzusehen lohnt.<BR>\nUm Dir das Suchen zu erleichtern solltest Du vor dem Start den Centerplan unter http://www.designer-outlet-berlin.de/shops/index.php herunterladen."
objKaufdorf.Visible = true
objKaufdorf.Activity = "Geocache"
objKaufdorf.StartingLocationDescription = "Du stehst vor dem Eingang zum Kaufdorf. Hoffentlich hast Du die Laden\195\182ffnungszeiten beachtet, da sonst dieser Eingang verschlossen ist und Kameras und Wachschutz aufpassen, dass niemand unbefugt hier umherstreift. "
objKaufdorf.StartingLocation = ZonePoint(52.541883, 12.978383, 0)
objKaufdorf.Version = "2"
objKaufdorf.Company = ""
objKaufdorf.Author = "k-zuse"
objKaufdorf.BuilderVersion = "URWIGO 1.15.4973.39887"
objKaufdorf.CreateDate = "08/27/2012 13:44:15"
objKaufdorf.PublishDate = "1/1/0001 12:00:00 AM"
objKaufdorf.UpdateDate = "09/14/2013 13:29:59"
objKaufdorf.LastPlayedDate = "1/1/0001 12:00:00 AM"
objKaufdorf.TargetDevice = "PocketPC"
objKaufdorf.TargetDeviceVersion = "0"
objKaufdorf.StateId = "1"
objKaufdorf.CountryId = "2"
objKaufdorf.Complete = false
objKaufdorf.UseLogging = true
objKaufdorf.Media = objEingang
objNorddorf1 = Wherigo.Zone(objKaufdorf)
objNorddorf1.Id = "21601fe3-aa27-40c6-97b3-f5407af5f074"
objNorddorf1.Name = "Norddorf"
objNorddorf1.Description = "Der noerdliche Bereich mit den Haeusern 1-62"
objNorddorf1.Visible = false
objNorddorf1.Media = objNorddorf
objNorddorf1.Commands = {}
objNorddorf1.DistanceRange = Distance(-1, "feet")
objNorddorf1.ShowObjects = "OnEnter"
objNorddorf1.ProximityRange = Distance(60, "meters")
objNorddorf1.AllowSetPositionTo = false
objNorddorf1.Active = false
objNorddorf1.Points = {
  ZonePoint(52.5418344712878, 12.9778468608856, 0),
  ZonePoint(52.5418377338302, 12.9791074991226, 0),
  ZonePoint(52.5414755901471, 12.9803198575974, 0),
  ZonePoint(52.5410938678957, 12.9803305864334, 0),
  ZonePoint(52.540881798544, 12.9806309938431, 0),
  ZonePoint(52.5406534150195, 12.9808241128922, 0),
  ZonePoint(52.5392113087567, 12.9810386896133, 0),
  ZonePoint(52.539387496225, 12.9801696538925, 0),
  ZonePoint(52.540708879699, 12.9777878522873, 0)
}
objNorddorf1.OriginalPoint = ZonePoint(52.5407871734894, 12.9797840118408, 0)
objNorddorf1.DistanceRangeUOM = "Feet"
objNorddorf1.ProximityRangeUOM = "Meters"
objNorddorf1.OutOfRangeName = ""
objNorddorf1.InRangeName = ""
objSueddorf1 = Wherigo.Zone(objKaufdorf)
objSueddorf1.Id = "63aea74b-48cf-4eea-aa88-7c9a148e6c7b"
objSueddorf1.Name = "Sueddorf"
objSueddorf1.Description = "Der suedliche Bereich mit den Haeusern 63 - 116"
objSueddorf1.Visible = false
objSueddorf1.Media = objSueddorf
objSueddorf1.Commands = {}
objSueddorf1.DistanceRange = Distance(-1, "feet")
objSueddorf1.ShowObjects = "OnEnter"
objSueddorf1.ProximityRange = Distance(60, "meters")
objSueddorf1.AllowSetPositionTo = false
objSueddorf1.Active = false
objSueddorf1.Points = {
  ZonePoint(52.5384804494869, 12.9795581102371, 0),
  ZonePoint(52.5374754981245, 12.9837530851364, 0),
  ZonePoint(52.5380693358008, 12.9842358827591, 0),
  ZonePoint(52.5391852068496, 12.9811245203018, 0),
  ZonePoint(52.5394853778464, 12.9810708761215, 0),
  ZonePoint(52.5395441067144, 12.9798263311386, 0),
  ZonePoint(52.5388002019146, 12.9789465665817, 0)
}
objSueddorf1.OriginalPoint = ZonePoint(52.5387200252482, 12.9812164817537, 0)
objSueddorf1.DistanceRangeUOM = "Feet"
objSueddorf1.ProximityRangeUOM = "Meters"
objSueddorf1.OutOfRangeName = ""
objSueddorf1.InRangeName = ""
objFinalzone = Wherigo.Zone(objKaufdorf)
objFinalzone.Id = "fdc589d7-ad27-4151-b055-a9e55e6fe4df"
objFinalzone.Name = "Finalzone"
objFinalzone.Description = [[
Hier findest Du die Finaldose. Die genauen Koordinaten stehen auch in Deinem Inventar! Es handelt sich um einen Regular!<BR>
Im Logbuch steht ein Code, den Du eingeben musst, um den Freischaltcode fur wherigo.com zu erhalten. Gib diesen hier ein.]]
objFinalzone.Visible = false
objFinalzone.Media = objmfinal
objFinalzone.Icon = objifinal
objFinalzone.Commands = {}
objFinalzone.DistanceRange = Distance(-1, "feet")
objFinalzone.ShowObjects = "Always"
objFinalzone.ProximityRange = Distance(60, "meters")
objFinalzone.AllowSetPositionTo = false
objFinalzone.Active = false
objFinalzone.Points = {
  ZonePoint(52.5419551851942, 12.982681542635, 0),
  ZonePoint(52.5418312087455, 12.9830919206142, 0),
  ZonePoint(52.5413401933185, 12.9827110469341, 0),
  ZonePoint(52.5415228973748, 12.9822121560574, 0)
}
objFinalzone.OriginalPoint = ZonePoint(52.5416623711582, 12.9826741665602, 0)
objFinalzone.DistanceRangeUOM = "Feet"
objFinalzone.ProximityRangeUOM = "Meters"
objFinalzone.OutOfRangeName = ""
objFinalzone.InRangeName = ""
objEingang1 = Wherigo.Zone(objKaufdorf)
objEingang1.Id = "b6b2e463-2ef1-4534-bb8a-c3f3b2f1a0e6"
objEingang1.Name = "Eingang"
objEingang1.Description = "Im Torbogen haengt eine Gedenktafel, zu der eine Frage zu beantworten ist, bevor es losgehen kann."
objEingang1.Visible = true
objEingang1.Media = objm_tor
objEingang1.Icon = obji_Tor
objEingang1.Commands = {}
objEingang1.DistanceRange = Distance(-1, "feet")
objEingang1.ShowObjects = "Always"
objEingang1.ProximityRange = Distance(60, "meters")
objEingang1.AllowSetPositionTo = false
objEingang1.Active = true
objEingang1.Points = {
  ZonePoint(52.5418997220896, 12.9782545566559, 0),
  ZonePoint(52.5418948282829, 12.978540211916, 0),
  ZonePoint(52.5417088632228, 12.9785294830799, 0),
  ZonePoint(52.5417088632228, 12.9782666265965, 0)
}
objEingang1.OriginalPoint = ZonePoint(52.5418030692045, 12.9783977195621, 0)
objEingang1.DistanceRangeUOM = "Feet"
objEingang1.ProximityRangeUOM = "Meters"
objEingang1.OutOfRangeName = ""
objEingang1.InRangeName = ""
objaFachwerk = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objaFachwerk.Id = "04d35421-61b0-4011-8c40-62a095aa5de7"
objaFachwerk.Name = "a) Fachwerk"
objaFachwerk.Description = "Ein Fachwerkhaus mit eckigen gruenen Fensterlaeden"
objaFachwerk.Visible = true
objaFachwerk.Media = objHausa
objaFachwerk.Icon = objia
objaFachwerk.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objaFachwerk.Commands.cmdErkannt.Custom = true
objaFachwerk.Commands.cmdErkannt.Id = "ca62c0e3-d3f1-4bc3-b755-e82b4f3df922"
objaFachwerk.Commands.cmdErkannt.WorksWithAll = true
objaFachwerk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objaFachwerk.Locked = false
objaFachwerk.Opened = false
objbEckigeSaeulen = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objbEckigeSaeulen.Id = "81ccaedd-a563-4471-abff-15efd195d491"
objbEckigeSaeulen.Name = "b) Eckige Saeulen"
objbEckigeSaeulen.Description = "Ein braunes Haus mit eckigen, oben verschnoerkelten Saeulen"
objbEckigeSaeulen.Visible = true
objbEckigeSaeulen.Media = objHausb
objbEckigeSaeulen.Icon = objib
objbEckigeSaeulen.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objbEckigeSaeulen.Commands.cmdErkannt.Custom = true
objbEckigeSaeulen.Commands.cmdErkannt.Id = "cbefeb2e-1048-44c1-aace-cb97b81a477f"
objbEckigeSaeulen.Commands.cmdErkannt.WorksWithAll = true
objbEckigeSaeulen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objbEckigeSaeulen.Locked = false
objbEckigeSaeulen.Opened = false
objcVerzierteFenster = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objcVerzierteFenster.Id = "962339f2-eb51-40c8-822f-01696252775b"
objcVerzierteFenster.Name = "c) Verzierte Fenster"
objcVerzierteFenster.Description = "Ein gruengraues Haus mit schnoerkeliger Verzierung ueber den Fenstern"
objcVerzierteFenster.Visible = true
objcVerzierteFenster.Media = objHausc
objcVerzierteFenster.Icon = objic
objcVerzierteFenster.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objcVerzierteFenster.Commands.cmdErkannt.Custom = true
objcVerzierteFenster.Commands.cmdErkannt.Id = "09a33e73-5207-42fa-8d46-5a1fbd48c8e1"
objcVerzierteFenster.Commands.cmdErkannt.WorksWithAll = true
objcVerzierteFenster.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objcVerzierteFenster.Locked = false
objcVerzierteFenster.Opened = false
objdRotmitWetterhahn = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objdRotmitWetterhahn.Id = "1e045b40-cec5-41b5-8107-ec786a312e67"
objdRotmitWetterhahn.Name = "d) Rot mit Wetterhahn"
objdRotmitWetterhahn.Description = "Ein eckiges rotes Haus mit Wetterhahn auf dem Dach"
objdRotmitWetterhahn.Visible = true
objdRotmitWetterhahn.Media = objHausd
objdRotmitWetterhahn.Icon = objid
objdRotmitWetterhahn.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objdRotmitWetterhahn.Commands.cmdErkannt.Custom = true
objdRotmitWetterhahn.Commands.cmdErkannt.Id = "02d34e1b-db22-44ad-abc9-2f3cc86e7d04"
objdRotmitWetterhahn.Commands.cmdErkannt.WorksWithAll = true
objdRotmitWetterhahn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objdRotmitWetterhahn.Locked = false
objdRotmitWetterhahn.Opened = false
objeGraumitWetterhahn = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objeGraumitWetterhahn.Id = "de61afe2-76b7-4d74-bbd3-c71ce56b2c76"
objeGraumitWetterhahn.Name = "e) Grau mit Wetterhahn"
objeGraumitWetterhahn.Description = "Ein weissgraues Haus mit Turm und Wetterhahn obendrauf"
objeGraumitWetterhahn.Visible = true
objeGraumitWetterhahn.Media = objHause
objeGraumitWetterhahn.Icon = objie
objeGraumitWetterhahn.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objeGraumitWetterhahn.Commands.cmdErkannt.Custom = true
objeGraumitWetterhahn.Commands.cmdErkannt.Id = "67bdba50-6a80-4582-b9d6-0490a3004b7b"
objeGraumitWetterhahn.Commands.cmdErkannt.WorksWithAll = true
objeGraumitWetterhahn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objeGraumitWetterhahn.Locked = false
objeGraumitWetterhahn.Opened = false
objfBlumenzierde = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objfBlumenzierde.Id = "7d0825d7-56af-4d38-b5e1-f6e8f700877d"
objfBlumenzierde.Name = "f) Blumenzierde"
objfBlumenzierde.Description = "Ein lachsfarbenes Haus mit Blumen als Verzierung an der Wand"
objfBlumenzierde.Visible = true
objfBlumenzierde.Media = objHausf
objfBlumenzierde.Icon = objif
objfBlumenzierde.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objfBlumenzierde.Commands.cmdErkannt.Custom = true
objfBlumenzierde.Commands.cmdErkannt.Id = "5a3a751d-906f-42ff-973a-16c78da0adf4"
objfBlumenzierde.Commands.cmdErkannt.WorksWithAll = true
objfBlumenzierde.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objfBlumenzierde.Locked = false
objfBlumenzierde.Opened = false
objgWasserspender = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objgWasserspender.Id = "d568fb28-cea2-41c3-a6b9-0e79b8f8093b"
objgWasserspender.Name = "g) Wasserspender"
objgWasserspender.Description = "Ein weisses Haus mit schwarzem Wasserspender fuer Hunde"
objgWasserspender.Visible = true
objgWasserspender.Media = objHausg
objgWasserspender.Icon = objig
objgWasserspender.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objgWasserspender.Commands.cmdErkannt.Custom = true
objgWasserspender.Commands.cmdErkannt.Id = "632eb2b2-c70b-4057-9121-929bcd045c98"
objgWasserspender.Commands.cmdErkannt.WorksWithAll = true
objgWasserspender.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objgWasserspender.Locked = false
objgWasserspender.Opened = false
objhRosamitBalkon = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objhRosamitBalkon.Id = "fac0183f-b1f3-46cd-ac37-234a9e7e83cf"
objhRosamitBalkon.Name = "h) Rosa mit Balkon"
objhRosamitBalkon.Description = "Ein rosafarbenes Haus mit franzoesischen Balkons vor den Fenstern"
objhRosamitBalkon.Visible = true
objhRosamitBalkon.Media = objHaush
objhRosamitBalkon.Icon = objih
objhRosamitBalkon.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objhRosamitBalkon.Commands.cmdErkannt.Custom = true
objhRosamitBalkon.Commands.cmdErkannt.Id = "ea898616-0496-4243-ac51-e8d38ed8e2d9"
objhRosamitBalkon.Commands.cmdErkannt.WorksWithAll = true
objhRosamitBalkon.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objhRosamitBalkon.Locked = false
objhRosamitBalkon.Opened = false
objiWetterVerzierungen = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objiWetterVerzierungen.Id = "35924e29-c570-4f9d-ab7c-b969b30f89fe"
objiWetterVerzierungen.Name = "i) Wetter+Verzierungen"
objiWetterVerzierungen.Description = "Ein Haus mit Wetterhahn auf dem Turm und Verzierungen an der Wand"
objiWetterVerzierungen.Visible = true
objiWetterVerzierungen.Media = objHausi
objiWetterVerzierungen.Icon = objii
objiWetterVerzierungen.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objiWetterVerzierungen.Commands.cmdErkannt.Custom = true
objiWetterVerzierungen.Commands.cmdErkannt.Id = "5e15e0a4-dfe9-41fd-a2ec-7d015457a2f8"
objiWetterVerzierungen.Commands.cmdErkannt.WorksWithAll = true
objiWetterVerzierungen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objiWetterVerzierungen.Locked = false
objiWetterVerzierungen.Opened = false
objjWeisserGiebel = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objjWeisserGiebel.Id = "0bd86b9f-18a5-4454-8cc6-f47ced148cb5"
objjWeisserGiebel.Name = "j) Weisser Giebel"
objjWeisserGiebel.Description = "Ein weisses Haus mit markantem Giebel"
objjWeisserGiebel.Visible = true
objjWeisserGiebel.Media = objHausj
objjWeisserGiebel.Icon = objij
objjWeisserGiebel.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objjWeisserGiebel.Commands.cmdErkannt.Custom = true
objjWeisserGiebel.Commands.cmdErkannt.Id = "61891cc8-3a15-41c1-a6d8-91d82b0cf500"
objjWeisserGiebel.Commands.cmdErkannt.WorksWithAll = true
objjWeisserGiebel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objjWeisserGiebel.Locked = false
objjWeisserGiebel.Opened = false
objkGelbmitSaeulen = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objkGelbmitSaeulen.Id = "b3a82418-c1f2-4ea3-b841-dc69d5c8d6fd"
objkGelbmitSaeulen.Name = "k) Gelb mit Saeulen"
objkGelbmitSaeulen.Description = "Ein gelbliches Haus mit angedeuteten Saeulen"
objkGelbmitSaeulen.Visible = true
objkGelbmitSaeulen.Media = objHausk
objkGelbmitSaeulen.Icon = objik
objkGelbmitSaeulen.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objkGelbmitSaeulen.Commands.cmdErkannt.Custom = true
objkGelbmitSaeulen.Commands.cmdErkannt.Id = "39a0de58-c6b2-44e1-8b84-0af800dd2f6b"
objkGelbmitSaeulen.Commands.cmdErkannt.WorksWithAll = true
objkGelbmitSaeulen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objkGelbmitSaeulen.Locked = false
objkGelbmitSaeulen.Opened = false
objlFachwerk2 = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objlFachwerk2.Id = "7f598dbd-556d-4d91-ac21-cdae51df8126"
objlFachwerk2.Name = "l) Fachwerk 2"
objlFachwerk2.Description = "Ein Fachwerkhaus mit runden gruenen Fensterlaeden"
objlFachwerk2.Visible = true
objlFachwerk2.Media = objHausl
objlFachwerk2.Icon = objil
objlFachwerk2.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objlFachwerk2.Commands.cmdErkannt.Custom = true
objlFachwerk2.Commands.cmdErkannt.Id = "19a4bb16-67eb-4526-b674-e27d176a8bc2"
objlFachwerk2.Commands.cmdErkannt.WorksWithAll = true
objlFachwerk2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objlFachwerk2.Locked = false
objlFachwerk2.Opened = false
objmSonne = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objmSonne.Id = "a88e2651-5748-48b8-b50c-e9deb8e9be26"
objmSonne.Name = "m) Sonne"
objmSonne.Description = "Ein graues Haus mit weisser Sonne"
objmSonne.Visible = true
objmSonne.Media = objHausm
objmSonne.Icon = objim
objmSonne.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objmSonne.Commands.cmdErkannt.Custom = true
objmSonne.Commands.cmdErkannt.Id = "e93c5bd7-4c9a-4e5c-aaf9-cbabae84deac"
objmSonne.Commands.cmdErkannt.WorksWithAll = true
objmSonne.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objmSonne.Locked = false
objmSonne.Opened = false
objnSonnenuhr = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objnSonnenuhr.Id = "576a3e57-343b-4ab7-a601-e8d76d31254e"
objnSonnenuhr.Name = "n) Sonnenuhr"
objnSonnenuhr.Description = "Ein hellblaues Haus mit gelber Sonnenuhr"
objnSonnenuhr.Visible = true
objnSonnenuhr.Media = objHausn
objnSonnenuhr.Icon = objin
objnSonnenuhr.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objnSonnenuhr.Commands.cmdErkannt.Custom = true
objnSonnenuhr.Commands.cmdErkannt.Id = "f91b8280-9f96-407e-965c-8988f07e9ee9"
objnSonnenuhr.Commands.cmdErkannt.WorksWithAll = true
objnSonnenuhr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objnSonnenuhr.Locked = false
objnSonnenuhr.Opened = false
objoPutte = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objSueddorf1})
objoPutte.Id = "c76b18e9-596b-4897-847a-34d1efd656ff"
objoPutte.Name = "o) Putte"
objoPutte.Description = "Ein rosafarbenes Haus mit grauer Putte (Engel) am Giebel"
objoPutte.Visible = true
objoPutte.Media = objHauso
objoPutte.Icon = objio
objoPutte.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objoPutte.Commands.cmdErkannt.Custom = true
objoPutte.Commands.cmdErkannt.Id = "c1186d27-df0a-4e1f-b51c-ec57e0fb7467"
objoPutte.Commands.cmdErkannt.WorksWithAll = true
objoPutte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objoPutte.Locked = false
objoPutte.Opened = false
objpFensterlaeden = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objNorddorf1})
objpFensterlaeden.Id = "ff9a8c2d-69e8-44e1-902c-af75ff834704"
objpFensterlaeden.Name = "p) Fensterlaeden"
objpFensterlaeden.Description = "Ein graues Haus mit offenen grauen Fensterlaeden"
objpFensterlaeden.Visible = true
objpFensterlaeden.Media = objHausp
objpFensterlaeden.Icon = objip
objpFensterlaeden.Commands = {
  cmdErkannt = Wherigo.ZCommand({
    Text = "Erkannt!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objpFensterlaeden.Commands.cmdErkannt.Custom = true
objpFensterlaeden.Commands.cmdErkannt.Id = "c8160575-6e86-43df-91c2-11674be19774"
objpFensterlaeden.Commands.cmdErkannt.WorksWithAll = true
objpFensterlaeden.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objpFensterlaeden.Locked = false
objpFensterlaeden.Opened = false
objChecker = Wherigo.ZItem({Cartridge = objKaufdorf, Container = Player})
objChecker.Id = "8b12ec74-0994-4ab6-a4c9-0d52bc842d8c"
objChecker.Name = "Checker"
objChecker.Description = "Prueft, wie viele Antworten bisher richtig sind."
objChecker.Visible = true
objChecker.Commands = {
  cmdRichtigezaehlen = Wherigo.ZCommand({
    Text = "Richtige zaehlen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objChecker.Commands.cmdRichtigezaehlen.Custom = true
objChecker.Commands.cmdRichtigezaehlen.Id = "166be147-d65d-4491-96f4-ccce4640dfd3"
objChecker.Commands.cmdRichtigezaehlen.WorksWithAll = true
objChecker.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objChecker.Locked = false
objChecker.Opened = false
objAnleitung = Wherigo.ZItem({Cartridge = objKaufdorf, Container = Player})
objAnleitung.Id = "9b7034ff-bd0b-4c47-9ea4-b98c4e6e1654"
objAnleitung.Name = "Anleitung"
objAnleitung.Description = "Hier wird Dir erklaert, wie dieser Wherigo funktioniert. Du solltest die Anleitung mindestens einmal lesen!"
objAnleitung.Visible = true
objAnleitung.Commands = {
  cmdLesen = Wherigo.ZCommand({
    Text = "Lesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objAnleitung.Commands.cmdLesen.Custom = true
objAnleitung.Commands.cmdLesen.Id = "1c1d8076-d87d-4cf4-98c2-cd451dbb763f"
objAnleitung.Commands.cmdLesen.WorksWithAll = true
objAnleitung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objAnleitung.Locked = false
objAnleitung.Opened = false
objSpielstand = Wherigo.ZItem({Cartridge = objKaufdorf, Container = Player})
objSpielstand.Id = "54e2493b-e1f6-41f4-b6b4-c0469cd39a2c"
objSpielstand.Name = "Spielstand"
objSpielstand.Description = "Hiermit kannst Du jederzeit den Spielstand sichern und den Wherigo spaeter wieder fortsetzen."
objSpielstand.Visible = true
objSpielstand.Commands = {
  cmdSpeichern = Wherigo.ZCommand({
    Text = "Speichern",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objSpielstand.Commands.cmdSpeichern.Custom = true
objSpielstand.Commands.cmdSpeichern.Id = "ae868179-4c25-45c7-87af-2bfc67a8ed7d"
objSpielstand.Commands.cmdSpeichern.WorksWithAll = true
objSpielstand.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSpielstand.Locked = false
objSpielstand.Opened = false
objFinalkoordinate = Wherigo.ZItem(objKaufdorf)
objFinalkoordinate.Id = "9a9d138f-d709-43c4-8ce7-768e543be9a6"
objFinalkoordinate.Name = "Finalkoordinate"
objFinalkoordinate.Description = [[
Die Finalkoordinate lautet:<BR>
<BR>
N52'32.493 E12'58.950<BR>
]]
objFinalkoordinate.Visible = false
objFinalkoordinate.Commands = {}
objFinalkoordinate.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFinalkoordinate.Locked = false
objFinalkoordinate.Opened = false
objFreischaltcode = Wherigo.ZItem(objKaufdorf)
objFreischaltcode.Id = "56a61724-d59d-4bec-9f0a-a5ba0f05fe22"
objFreischaltcode.Name = "Freischaltcode"
objFreischaltcode.Description = "Hier musst Du den Code aus dem Logbuch eingeben, um einen Freischaltcode fuer wherigo.com zu erhalten!"
objFreischaltcode.Visible = false
objFreischaltcode.Commands = {
  cmdCodeeingeben = Wherigo.ZCommand({
    Text = "Code eingeben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objFreischaltcode.Commands.cmdCodeeingeben.Custom = true
objFreischaltcode.Commands.cmdCodeeingeben.Id = "99c04bab-c390-429e-bc6c-0db3d04d470a"
objFreischaltcode.Commands.cmdCodeeingeben.WorksWithAll = true
objFreischaltcode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFreischaltcode.Locked = false
objFreischaltcode.Opened = false
objGedenktafel = Wherigo.ZItem({Cartridge = objKaufdorf, Container = objEingang1})
objGedenktafel.Id = "8aa518fc-9f5a-44c7-ac8d-061fc87e389f"
objGedenktafel.Name = "Gedenktafel"
objGedenktafel.Description = "Im Eingangstor hangt eine Gedenktafel"
objGedenktafel.Visible = false
objGedenktafel.Media = objm_tafel
objGedenktafel.Icon = obji_tafel
objGedenktafel.Commands = {
  cmdFragebeantworten = Wherigo.ZCommand({
    Text = "Frage beantworten",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
objGedenktafel.Commands.cmdFragebeantworten.Custom = true
objGedenktafel.Commands.cmdFragebeantworten.Id = "bd93adc1-744b-4532-a248-7fb9da296d31"
objGedenktafel.Commands.cmdFragebeantworten.WorksWithAll = true
objGedenktafel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objGedenktafel.Locked = false
objGedenktafel.Opened = false
objl = 0
objk = 0
obja = 0
objj = 0
objm = 0
objp = 0
objo = 0
objn = 0
obji = 0
objc = 0
objd = 0
objb = 0
obje = 0
objh = 0
objg = 0
objf = 0
objAnzahlRichtige = 0
objGedenktafelkorrekt = false
currentZone = "objNorddorf1"
currentCharacter = "dummy"
currentItem = "objaFachwerk"
currentTask = "dummy"
currentInput = "obja1"
currentTimer = "dummy"
objKaufdorf.ZVariables = {
  objl = 0,
  objk = 0,
  obja = 0,
  objj = 0,
  objm = 0,
  objp = 0,
  objo = 0,
  objn = 0,
  obji = 0,
  objc = 0,
  objd = 0,
  objb = 0,
  obje = 0,
  objh = 0,
  objg = 0,
  objf = 0,
  objAnzahlRichtige = 0,
  objGedenktafelkorrekt = false,
  currentZone = "objNorddorf1",
  currentCharacter = "dummy",
  currentItem = "objaFachwerk",
  currentTask = "dummy",
  currentInput = "obja1",
  currentTimer = "dummy"
}
obja1 = Wherigo.ZInput(objKaufdorf)
obja1.Id = "9bc8c766-402f-431a-b437-79a62c848adb"
obja1.Name = "a"
obja1.Description = ""
obja1.Visible = true
obja1.Choices = {
  "82",
  "95",
  "103"
}
obja1.InputType = "MultipleChoice"
obja1.Text = "Nummer eingeben"
objb1 = Wherigo.ZInput(objKaufdorf)
objb1.Id = "edd98073-52b6-40a9-8dc6-53b8148e7cc2"
objb1.Name = "b"
objb1.Description = ""
objb1.Visible = true
objb1.Choices = {
  "63",
  "75",
  "102"
}
objb1.InputType = "MultipleChoice"
objb1.Text = "Nummer eingeben"
objp1 = Wherigo.ZInput(objKaufdorf)
objp1.Id = "fa21ddb2-caf6-47a3-b630-c6d5f7d94cee"
objp1.Name = "p"
objp1.Description = ""
objp1.Visible = true
objp1.Choices = {
  "9",
  "17",
  "51"
}
objp1.InputType = "MultipleChoice"
objp1.Text = "Nummer eingeben"
objo1 = Wherigo.ZInput(objKaufdorf)
objo1.Id = "8c7943e5-78b3-40e1-a2ec-c8236711d966"
objo1.Name = "o"
objo1.Description = ""
objo1.Visible = true
objo1.Choices = {
  "68",
  "81",
  "97"
}
objo1.InputType = "MultipleChoice"
objo1.Text = "Nummer eingeben"
objn1 = Wherigo.ZInput(objKaufdorf)
objn1.Id = "eac1a4a8-7a46-44ff-8734-3b55c8cef487"
objn1.Name = "n"
objn1.Description = ""
objn1.Visible = true
objn1.Choices = {
  "13",
  "44",
  "48"
}
objn1.InputType = "MultipleChoice"
objn1.Text = "Nummer eingeben"
objm1 = Wherigo.ZInput(objKaufdorf)
objm1.Id = "246685a2-c758-4b77-b9c3-275590e41ba6"
objm1.Name = "m"
objm1.Description = ""
objm1.Visible = true
objm1.Choices = {
  "87",
  "91",
  "101"
}
objm1.InputType = "MultipleChoice"
objm1.Text = "Nummer eingeben"
objc1 = Wherigo.ZInput(objKaufdorf)
objc1.Id = "13249b99-5d22-4646-923a-06bce37adac4"
objc1.Name = "c"
objc1.Description = ""
objc1.Visible = true
objc1.Choices = {
  "65",
  "69",
  "71"
}
objc1.InputType = "MultipleChoice"
objc1.Text = "Nummer eingeben"
objl1 = Wherigo.ZInput(objKaufdorf)
objl1.Id = "64e7b551-81cb-4d8b-85e2-ce87266c6c00"
objl1.Name = "l"
objl1.Description = ""
objl1.Visible = true
objl1.Choices = {
  "42",
  "51",
  "54"
}
objl1.InputType = "MultipleChoice"
objl1.Text = "Nummer eingeben"
objd1 = Wherigo.ZInput(objKaufdorf)
objd1.Id = "13edfe07-958d-4748-92fc-818e75e80ddf"
objd1.Name = "d"
objd1.Description = ""
objd1.Visible = true
objd1.Choices = {
  "86",
  "112",
  "115"
}
objd1.InputType = "MultipleChoice"
objd1.Text = "Nummer eingeben"
objk1 = Wherigo.ZInput(objKaufdorf)
objk1.Id = "f2e9ab15-1659-49fa-8786-8be4063316ec"
objk1.Name = "k"
objk1.Description = ""
objk1.Visible = true
objk1.Choices = {
  "20",
  "37",
  "58"
}
objk1.InputType = "MultipleChoice"
objk1.Text = "Nummer eingeben"
obje1 = Wherigo.ZInput(objKaufdorf)
obje1.Id = "4464ae8c-b78d-4a70-8cd2-7f19673afb44"
obje1.Name = "e"
obje1.Description = ""
obje1.Visible = true
obje1.Choices = {
  "80",
  "95",
  "110"
}
obje1.InputType = "MultipleChoice"
obje1.Text = "Nummer eingeben"
objj1 = Wherigo.ZInput(objKaufdorf)
objj1.Id = "d016f206-f91e-44b3-a7aa-14fd4b3f0032"
objj1.Name = "j"
objj1.Description = ""
objj1.Visible = true
objj1.Choices = {
  "25",
  "37",
  "40"
}
objj1.InputType = "MultipleChoice"
objj1.Text = "Nummer eingeben"
objf1 = Wherigo.ZInput(objKaufdorf)
objf1.Id = "d67edb88-b910-49c0-8ba8-fb65e1000fc9"
objf1.Name = "f"
objf1.Description = ""
objf1.Visible = true
objf1.Choices = {
  "15",
  "39",
  "54"
}
objf1.InputType = "MultipleChoice"
objf1.Text = "Nummer eingeben"
obji1 = Wherigo.ZInput(objKaufdorf)
obji1.Id = "d9aa04cd-911b-475c-8736-53f345444982"
obji1.Name = "i"
obji1.Description = ""
obji1.Visible = true
obji1.Choices = {
  "16",
  "17",
  "38"
}
obji1.InputType = "MultipleChoice"
obji1.Text = "Nummer eingeben"
objg1 = Wherigo.ZInput(objKaufdorf)
objg1.Id = "d6582011-e21a-4909-9927-1b0c1c49427e"
objg1.Name = "g"
objg1.Description = ""
objg1.Visible = true
objg1.Choices = {
  "11",
  "34",
  "61"
}
objg1.InputType = "MultipleChoice"
objg1.Text = "Nummer eingeben"
objh1 = Wherigo.ZInput(objKaufdorf)
objh1.Id = "f7495ae8-44ca-4917-8ccc-fa6810230530"
objh1.Name = "h"
objh1.Description = ""
objh1.Visible = true
objh1.Choices = {
  "2",
  "4",
  "60"
}
objh1.InputType = "MultipleChoice"
objh1.Text = "Nummer eingeben"
objFreischalten = Wherigo.ZInput(objKaufdorf)
objFreischalten.Id = "a4184e8f-ddf4-4cfa-9398-18056529211f"
objFreischalten.Name = "Freischalten"
objFreischalten.Description = ""
objFreischalten.Visible = true
objFreischalten.InputType = "Text"
objFreischalten.Text = "Wie lautet der Code im Logbuch?"
objGedenktafel1 = Wherigo.ZInput(objKaufdorf)
objGedenktafel1.Id = "e1f29c8c-1a2c-4391-abea-cd3276e6b77f"
objGedenktafel1.Name = "Gedenktafel"
objGedenktafel1.Description = ""
objGedenktafel1.Visible = true
objGedenktafel1.InputType = "Text"
objGedenktafel1.Text = "Wem ist die Gedenktafel gewidmet (Nachname, 4 Buchstaben)?"
function objKaufdorf:OnStart()
  _Urwigo.Dialog(false, {
    {
      Text = "Wenn Du diesen Wherigo zum ersten mal startest, solltest Du unbedingt die Anleitung aus Deinem Inventar lesen!"
    },
    {
      Text = "Wenn Du nicht alles auf einmal schaffst, kannst Du auch den Spielstand speichern und spaeter noch einmal wiederkommen und weiter machen."
    }
  }, function(action)
    local _Urwigo_Date = os.date("*t")
    if Player.Name ~= "k-zuse" and (_Urwigo_Date.hour > 18 or _Urwigo_Date.hour < 9 or _Urwigo_Date.wday == 1) then
      _Urwigo.MessageBox({
        Text = "Um Begegnungen mit dem Wachpersonal zu vermeiden, muessen die Ladenoeffnungszeiten eingehalten werden! Komm Mo-Sa zwischen 9:00 und 19:00 Uhr wieder!",
        Callback = function(action)
          if action ~= nil then
            Wherigo.Command("SaveClose")
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "Prima, dass Du die Ladenoeffnungszeiten beachtest. Bitte verlasse das Gelaende auf jeden Fall auch wieder rechtzeitig!"
      })
    end
  end)
end
function objKaufdorf:OnRestore()
end
function objEingang1:OnEnter()
  currentZone = "objEingang1"
  objGedenktafel.Visible = true
  Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
end
function obja1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  obja = tonumber(input)
  objaFachwerk.Name = ("a) Fachwerk [" .. obja) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objb1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objb = tonumber(input)
  objbEckigeSaeulen.Name = ("b) Eckige Saeulen [" .. objb) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objp1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objp = tonumber(input)
  objpFensterlaeden.Name = ("p) Fensterlaeden [" .. objp) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objo1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objo = tonumber(input)
  objoPutte.Name = ("o) Putte [" .. objo) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objn1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objn = tonumber(input)
  objnSonnenuhr.Name = ("n) Sonnenuhr [" .. objn) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objm1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objm = tonumber(input)
  objmSonne.Name = ("m) Sonne [" .. objm) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objc1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objc = tonumber(input)
  objcVerzierteFenster.Name = ("c) Verzierte Fenster [" .. objc) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objl1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objl = tonumber(input)
  objlFachwerk2.Name = ("l) Fachwerk 2 [" .. objl) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objd1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objd = tonumber(input)
  objdRotmitWetterhahn.Name = ("d) Rot mit Wetterhahn [" .. objd) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objk1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objk = tonumber(input)
  objkGelbmitSaeulen.Name = ("k) Gelb mit Saeulen [" .. objk) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function obje1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  obje = tonumber(input)
  objeGraumitWetterhahn.Name = ("e) Grau mit Wetterhahn [" .. obje) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objj1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objj = tonumber(input)
  objjWeisserGiebel.Name = ("j) Weisser Giebel [" .. objj) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objf1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objf = tonumber(input)
  objfBlumenzierde.Name = ("f) Blumenzierde [" .. objf) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function obji1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  obji = tonumber(input)
  objiWetterVerzierungen.Name = ("i) Wetter+Verzierungen [" .. obji) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objg1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objg = tonumber(input)
  objgWasserspender.Name = ("g) Wasserspender [" .. objg) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objh1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  objh = tonumber(input)
  objhRosamitBalkon.Name = ("h) Rosa mit Balkon [" .. objh) .. "]"
  objKaufdorf:RequestSync()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objFreischalten:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "sale50%off") then
    objKaufdorf.Complete = true
    objFreischaltcode.Description = "Dein Freischaltcode fuer Wherigo.com lautet:<BR>\n" .. string.sub(Player.CompletionCode, 1, 15)
    objFreischaltcode.Commands.cmdCodeeingeben.Enabled = false
  else
    _Urwigo.MessageBox({
      Text = "Das war leider der falsche Code, versuch' es noch einmal!"
    })
  end
end
function objGedenktafel1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Kock") then
    objGedenktafelkorrekt = true
    objNorddorf1.Active = true
    objNorddorf1.Visible = true
    objSueddorf1.Active = true
    objSueddorf1.Visible = true
    objEingang1.Active = false
    objEingang1.Visible = false
    objGedenktafel.Visible = false
    _Urwigo.MessageBox({
      Text = "Prima! Jetzt kann es losgehen, diese Frage diente nur zum Emulatorschutz!",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Das stimmt leider nicht! Bitte nicht im Emulator spielen und nicht raten!",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objaFachwerk:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(obja1)
  end)
end
function objbEckigeSaeulen:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objb1)
  end)
end
function objcVerzierteFenster:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objc1)
  end)
end
function objdRotmitWetterhahn:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objd1)
  end)
end
function objeGraumitWetterhahn:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(obje1)
  end)
end
function objfBlumenzierde:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objf1)
  end)
end
function objgWasserspender:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objg1)
  end)
end
function objhRosamitBalkon:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objh1)
  end)
end
function objiWetterVerzierungen:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(obji1)
  end)
end
function objjWeisserGiebel:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objj1)
  end)
end
function objkGelbmitSaeulen:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objk1)
  end)
end
function objlFachwerk2:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objl1)
  end)
end
function objmSonne:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objm1)
  end)
end
function objnSonnenuhr:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objn1)
  end)
end
function objoPutte:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objo1)
  end)
end
function objpFensterlaeden:OncmdErkannt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objp1)
  end)
end
function objChecker:OncmdRichtigezaehlen(target)
  objRichtigezaehlen()
  _Urwigo.MessageBox({
    Text = "Bisher richtig erkannt:" .. objAnzahlRichtige,
    Callback = function(action)
      if action ~= nil then
        if objAnzahlRichtige == 16 then
          objFinalzone.Active = true
          objFinalzone.Visible = true
          objFinalkoordinate.Visible = true
          objFinalkoordinate:MoveTo(Player)
          objFreischaltcode.Visible = true
          objFreischaltcode:MoveTo(Player)
          _Urwigo.MessageBox({
            Text = "Bravo, Du hast alle Haeuser richtig erkannt! In Deinem Inventar findest Du nun die Zielkoordinate. Gehe in die Finalzone und gib den Code aus dem Logbuch dann hier ein, um den Freischaltcode fuer wherigo.com angezeigt zu bekommen!",
            Callback = function(action)
              if action ~= nil then
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
end
function objAnleitung:OncmdLesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = [[
1<BR>
<BR>
Bei diesem Wherigo geht es darum, die Giebel der verschiedenen Haeuser im "Kaufdorf" zu finden.]]
    },
    {
      Text = [[
2<BR>
<BR>
Das Kaufdorf ist dabei unterteilt in zwei Teile, in denen sich einmal neun und einmal sieben der insgesamt sechzehn zu erkennenden Haeuser befinden.]]
    },
    {
      Text = [[
3<BR>
<BR>
Gehe in die verschiedenen Teile und die jeweiligen Haeuser werden Dir in den beiden Dorfteilen mit einer Beschreibung und einem kleinen Bild des Giebels angezeigt.]]
    },
    {
      Text = [[
4<BR>
<BR>
Waehle das Haus aus, das Du gefunden hast und klicke dort auf "Erkannt!". Gib dann die Nummer an, die zum jeweiligen Haus gehort.]]
    },
    {
      Text = [[
5<BR>
<BR>
Die Nummern findest Du auf dem Infoplan, der an den verschiedenen Infotafeln an mindestens drei Stellen im Kaufdorf angebracht ist. Die Markennamen helfen Dir beim Erkennen.]]
    },
    {
      Text = [[
6<BR>
<BR>
Damit es bei Mehrdeutigkeiten nicht zu schwer wird, sind bei jedem Haus nur drei Moglichkeiten angegeben, aus der Du eine auswaehlen musst.]]
    },
    {
      Text = [[
7<BR>
<BR>
Bei Gebauden mit mehreren Nummern oder Gebaeudeteilen ist jeweils die kleinste Zahl ohne Buchstaben als richtige Loesung angegeben.]]
    },
    {
      Text = [[
8<BR>
<BR>
Wenn Du bei einem Haus eine Nummer angegeben hast, wird Dir diese zur Kontrolle hinter dem Namen in eckigen Klammern angezeigt. Du kannst die Nummer jederzeit wieder aendern.]]
    },
    {
      Text = [[
9<BR>
<BR>
In Deinem Inventar findest Du einen Checker, mit dem Du jederzeit pruefen kannst, wie viele (aber nicht welche!) Antworten schon richtig sind.]]
    },
    {
      Text = [[
10<BR>
<BR>
Wenn Du glaubst, dass Du alle 16 Haeuser erkannt hast, benutze den Checker und die Final-Koordinaten werden Dir angezeigt.]]
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function objSpielstand:OncmdSpeichern(target)
  objKaufdorf:RequestSync()
  _Urwigo.MessageBox({
    Text = "Spielstand wurde gespeichert!",
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objFreischaltcode:OncmdCodeeingeben(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objFreischalten)
  end)
end
function objGedenktafel:OncmdFragebeantworten(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objGedenktafel1)
  end)
end
function objRichtigezaehlen()
  objAnzahlRichtige = 0
  if obja == 95 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objb == 63 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objc == 69 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objd == 115 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if obje == 110 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objf == 39 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objg == 61 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objh == 2 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if obji == 17 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objj == 37 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objk == 20 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objl == 54 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objm == 87 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objn == 48 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objo == 97 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
  if objp == 9 then
    objAnzahlRichtige = objAnzahlRichtige + 1
  end
end
return objKaufdorf
