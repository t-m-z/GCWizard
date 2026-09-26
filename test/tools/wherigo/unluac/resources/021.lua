require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _QSt(str)
  local res = ""
  local dtable = "M\f\nHn#s/(h\"y5K`pt ]|@<}\023A$O;Sw\001\v\002RIe\000C*lB+4%&{Evcd\030g6~\021a17\029\004.Y\028\0269\r^u>\003\\[kZr\t)\005DN,8\a\018\b\017m:V\0222!bi3GJUP\020\014fxL'\027=\024q\016z?\031_XFTQ-\025\015W0j\019\006o"
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
cartTourdeGreensboro = Wherigo.ZCartridge()
zmediaNatGreene = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaNatGreene.Id = "f4670073-1411-432e-a5fb-db06b97d669a"
zmediaNatGreene.Name = _QSt("P8\017`K$$\005$")
zmediaNatGreene.Description = _QSt("z\n8\017\018^\a\018\n$\018(\127\127I^\0054\018\1270$Kp")
zmediaNatGreene.AltText = ""
zmediaNatGreene.Resources = {
  {
    Type = "jpg",
    Filename = "Mirow_Kirche.jpg",
    Directives = {}
  }
}
zmediaPlanet = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaPlanet.Id = "689f3069-5296-4b50-9dac-2a9f0a44b6b5"
zmediaPlanet.Name = _QSt("c(8\005$\017")
zmediaPlanet.Description = _QSt("#\a\018\017\n8\017\0188\018]\127\030(^\0054\018]8((\018\127K\0188\018\016(8\005$\017p\018-\005]\a\016\028#\a\018\017\n8\017\0188\0181\n^W\005$\f\018^\005\018\017\n$\018]81I4K\127D\0052p")
zmediaPlanet.AltText = ""
zmediaPlanet.Resources = {
  {
    Type = "png",
    Filename = "hafen.png",
    Directives = {}
  }
}
zmediaFairway = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaFairway.Id = "bcc019d6-8575-4299-8315-b334c3c64c8c"
zmediaFairway.Name = _QSt("t8^K\0308\f")
zmediaFairway.Description = _QSt("\025(\a\127\018\a$$\005\018fK\127W\0184\127(f\0181\127DK\a$\a=")
zmediaFairway.AltText = ""
zmediaFairway.Resources = {
  {
    Type = "png",
    Filename = "schleuse.png",
    Directives = {}
  }
}
zmediaPillar = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaPillar.Id = "9a1ab9ae-96eb-410d-a110-7a1526093e9b"
zmediaPillar.Name = _QSt("c^((8K")
zmediaPillar.Description = _QSt("\029\127W$\017\n^\0054\018\017\n8\017\018(\127\127I\a\018(^I$\0188K1\n^\017$1\017DK$=\018-\005]\a\016\028#\a\018^\017\018K$8((\fp")
zmediaPillar.AltText = ""
zmediaPillar.Resources = {
  {
    Type = "png",
    Filename = "untereschloss.png",
    Directives = {}
  }
}
zmediaGreeneStatue = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaGreeneStatue.Id = "8eb0c051-4f1e-4f80-93ab-1de375d42f07"
zmediaGreeneStatue.Name = _QSt("`K$$\005$\029\0178\017D$")
zmediaGreeneStatue.Description = ""
zmediaGreeneStatue.AltText = ""
zmediaGreeneStatue.Resources = {
  {
    Type = "png",
    Filename = "torhaus_mirow.png",
    Directives = {}
  }
}
zmediaNattyGreene = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaNattyGreene.Id = "8d1e9139-61d7-4690-a4f1-d22ab563babe"
zmediaNattyGreene.Name = _QSt("P8\017\017\f`K$$\005$")
zmediaNattyGreene.Description = ""
zmediaNattyGreene.AltText = ""
zmediaNattyGreene.Resources = {
  {
    Type = "png",
    Filename = "SchlossMirow.png",
    Directives = {}
  }
}
zmediaNattyGreeneFull = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaNattyGreeneFull.Id = "01f8c7e6-31fb-43a2-971d-71267bc8fdda"
zmediaNattyGreeneFull.Name = _QSt("P8\017\017\f`K$$\005$tD((")
zmediaNattyGreeneFull.Description = ""
zmediaNattyGreeneFull.AltText = ""
zmediaNattyGreeneFull.Resources = {
  {
    Type = "jpg",
    Filename = "IMG_0169WinCE.jpg",
    Directives = {}
  }
}
zmediaWoolworth = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaWoolworth.Id = "bf2a734e-8775-4f22-a008-178c21dbc4dd"
zmediaWoolworth.Name = _QSt("z\127\127(\030\127K\017\n")
zmediaWoolworth.Description = ""
zmediaWoolworth.AltText = ""
zmediaWoolworth.Resources = {
  {
    Type = "png",
    Filename = "Mirowcafe.png",
    Directives = {}
  }
}
zmediaNorthGreene = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaNorthGreene.Id = "369b84b2-3b3e-4390-b93a-db2104e22acb"
zmediaNorthGreene.Name = _QSt("P\127K\017\n`K$$\005$")
zmediaNorthGreene.Description = ""
zmediaNorthGreene.AltText = ""
zmediaNorthGreene.Resources = {
  {
    Type = "png",
    Filename = "Eiskeller.png",
    Directives = {}
  }
}
zmediaWoolworthPlaque = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaWoolworthPlaque.Id = "0c0c0c7f-9695-44b6-9ea7-2d03935dcd82"
zmediaWoolworthPlaque.Name = _QSt("z\127\127(\030\127K\017\nc(8mD$")
zmediaWoolworthPlaque.Description = ""
zmediaWoolworthPlaque.AltText = ""
zmediaWoolworthPlaque.Resources = {
  {
    Type = "png",
    Filename = "Mirowcafe1.png",
    Directives = {}
  }
}
zmediaCourthouse = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaCourthouse.Id = "bfc0e4ee-2580-43f2-92a4-c38434332af5"
zmediaCourthouse.Name = _QSt("&\127DK\017\n\127D\a$")
zmediaCourthouse.Description = ""
zmediaCourthouse.AltText = ""
zmediaCourthouse.Resources = {
  {
    Type = "png",
    Filename = "Liebesinsel.png",
    Directives = {}
  }
}
zmediaBook = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaBook.Id = "dbf2c0a8-b241-4957-9c1f-1d2e67eadad7"
zmediaBook.Name = _QSt(")\127\127I")
zmediaBook.Description = ""
zmediaBook.AltText = ""
zmediaBook.Resources = {
  {
    Type = "png",
    Filename = "Eiskeller1.png",
    Directives = {}
  }
}
zmediaFinal = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaFinal.Id = "3c958dd7-26b6-47fa-b7c7-ae63317c8e4e"
zmediaFinal.Name = _QSt("t^\0058(")
zmediaFinal.Description = _QSt("K$1\n\017$\018\a\017K8\195\159$\005\a$^\017$")
zmediaFinal.AltText = ""
zmediaFinal.Resources = {
  {
    Type = "png",
    Filename = "final.png",
    Directives = {}
  }
}
zmediaGSOlogo = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaGSOlogo.Id = "3e75a759-fa1f-4d78-a3be-5ad6ada15a2f"
zmediaGSOlogo.Name = _QSt("`\029\027\018(\1274\127")
zmediaGSOlogo.Description = ""
zmediaGSOlogo.AltText = ""
zmediaGSOlogo.Resources = {
  {
    Type = "png",
    Filename = "Wappen.png",
    Directives = {}
  }
}
zmediaFinal2 = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaFinal2.Id = "28a7d309-3728-47f9-b805-b18060478849"
zmediaFinal2.Name = _QSt("t^\0058([")
zmediaFinal2.Description = _QSt("K$1\n\017$\018\029\017K8\195\159$\005\a$^\017$")
zmediaFinal2.AltText = ""
zmediaFinal2.Resources = {
  {
    Type = "png",
    Filename = "final1.png",
    Directives = {}
  }
}
zmediaLight = Wherigo.ZMedia(cartTourdeGreensboro)
zmediaLight.Id = "12c5c54f-2116-44f3-8a40-d5d9528d8c31"
zmediaLight.Name = _QSt("h^4\n\017")
zmediaLight.Description = ""
zmediaLight.AltText = ""
zmediaLight.Resources = {
  {
    Type = "png",
    Filename = "fischer.png",
    Directives = {}
  }
}
_t1AR = Wherigo.ZMedia(cartTourdeGreensboro)
_t1AR.Id = "d6565e57-78a8-40dc-929e-74805a19b99f"
_t1AR.Name = _QSt("t^\a1\n$K")
_t1AR.Description = ""
_t1AR.AltText = ""
_t1AR.Resources = {
  {
    Type = "png",
    Filename = "fischer1.png",
    Directives = {}
  }
}
_bkL = Wherigo.ZMedia(cartTourdeGreensboro)
_bkL.Id = "ca73fd76-d970-4e18-8e8a-006bdd7d70d5"
_bkL.Name = _QSt("/^\aI$(($K")
_bkL.Description = ""
_bkL.AltText = ""
_bkL.Resources = {
  {
    Type = "png",
    Filename = "Eiskeller2.png",
    Directives = {}
  }
}
_UqJ5 = Wherigo.ZMedia(cartTourdeGreensboro)
_UqJ5.Id = "2c0e1c8f-eda8-418a-8d32-fb3d41c616b3"
_UqJ5.Name = _QSt("\0291\n(\127\a\a")
_UqJ5.Description = ""
_UqJ5.AltText = ""
_UqJ5.Resources = {
  {
    Type = "png",
    Filename = "SchlossMirow1.png",
    Directives = {}
  }
}
_xKem = Wherigo.ZMedia(cartTourdeGreensboro)
_xKem.Id = "8d6766ad-a3d5-47c6-812a-795eec3789ac"
_xKem.Name = _QSt("18f$")
_xKem.Description = ""
_xKem.AltText = ""
_xKem.Resources = {
  {
    Type = "png",
    Filename = "Mirowcafe2.png",
    Directives = {}
  }
}
_r8B = Wherigo.ZMedia(cartTourdeGreensboro)
_r8B.Id = "87f21fb4-17b7-491f-8d4c-fd4830475f74"
_r8B.Name = _QSt("D\005\017$K$\018\a1\n(\127\a\a")
_r8B.Description = ""
_r8B.AltText = ""
_r8B.Resources = {
  {
    Type = "png",
    Filename = "untereschloss1.png",
    Directives = {}
  }
}
zoneschleuse = Wherigo.ZMedia(cartTourdeGreensboro)
zoneschleuse.Id = "6641927f-c5f3-42b4-ada0-1f7b93fbd27b"
zoneschleuse.Name = _QSt("\a1\n($D\a$")
zoneschleuse.Description = ""
zoneschleuse.AltText = ""
zoneschleuse.Resources = {
  {
    Type = "png",
    Filename = "schleuse1.png",
    Directives = {}
  }
}
_kvhk = Wherigo.ZMedia(cartTourdeGreensboro)
_kvhk.Id = "e1c69814-459c-489c-8ad7-9f711f47dd2c"
_kvhk.Name = _QSt("(^$]$\a^\005\a$(")
_kvhk.Description = ""
_kvhk.AltText = ""
_kvhk.Resources = {
  {
    Type = "png",
    Filename = "Liebesinsel1.png",
    Directives = {}
  }
}
_ZoJ = Wherigo.ZMedia(cartTourdeGreensboro)
_ZoJ.Id = "9d89c53f-be23-4de9-9937-f9826b3a111f"
_ZoJ.Name = _QSt("\017\127K\n8D\a")
_ZoJ.Description = ""
_ZoJ.AltText = ""
_ZoJ.Resources = {
  {
    Type = "png",
    Filename = "torhaus_mirow1.png",
    Directives = {}
  }
}
_wYI = Wherigo.ZMedia(cartTourdeGreensboro)
_wYI.Id = "531eb3ed-1b72-4c36-8fbf-86d4cc93a3b7"
_wYI.Name = _QSt("\014^K1\n$")
_wYI.Description = ""
_wYI.AltText = ""
_wYI.Resources = {
  {
    Type = "jpg",
    Filename = "Mirow_Kirche1.jpg",
    Directives = {}
  }
}
_iGcB = Wherigo.ZMedia(cartTourdeGreensboro)
_iGcB.Id = "fd48c03b-5782-434a-ae62-bbc4a59382ba"
_iGcB.Name = _QSt("\n8f$\005")
_iGcB.Description = ""
_iGcB.AltText = ""
_iGcB.Resources = {
  {
    Type = "png",
    Filename = "hafen1.png",
    Directives = {}
  }
}
_XuS = Wherigo.ZMedia(cartTourdeGreensboro)
_XuS.Id = "d76c5f45-436e-494b-9bd9-7f6115b81307"
_XuS.Name = _QSt("t^\0058(f\127\017\127")
_XuS.Description = ""
_XuS.AltText = ""
_XuS.Resources = {
  {
    Type = "png",
    Filename = "final2.png",
    Directives = {}
  }
}
cartTourdeGreensboro.Id = "fa4e6e6a-392a-4881-b73f-3dcf7427ef77"
cartTourdeGreensboro.Name = "Tour de Mirow"
cartTourdeGreensboro.Description = "<BR>\nDiese Cartridge f\195\188hrt Sie durch die Innenstadt von Mirow. Wenn Sie an einem Punkt ankommen, sehen Sie ein Bild, das Ihnen zeigt, wohin Sie als N\195\164chstes gehen m\195\188ssen."
cartTourdeGreensboro.Visible = true
cartTourdeGreensboro.Activity = "Geocache"
cartTourdeGreensboro.StartingLocationDescription = ""
cartTourdeGreensboro.StartingLocation = ZonePoint(53.275967, 12.812567, 0)
cartTourdeGreensboro.Version = "1.5"
cartTourdeGreensboro.Company = ""
cartTourdeGreensboro.Author = ""
cartTourdeGreensboro.BuilderVersion = "URWIGO 1.22.5798.37755"
cartTourdeGreensboro.CreateDate = "04/08/2008 10:57:44"
cartTourdeGreensboro.PublishDate = "1/1/0001 12:00:00 AM"
cartTourdeGreensboro.UpdateDate = "02/06/2020 13:35:32"
cartTourdeGreensboro.LastPlayedDate = "1/1/0001 12:00:00 AM"
cartTourdeGreensboro.TargetDevice = "PocketPC"
cartTourdeGreensboro.TargetDeviceVersion = "0"
cartTourdeGreensboro.StateId = "1"
cartTourdeGreensboro.CountryId = "2"
cartTourdeGreensboro.Complete = false
cartTourdeGreensboro.UseLogging = true
cartTourdeGreensboro.Icon = zmediaGSOlogo
zoneNatGreene = Wherigo.Zone(cartTourdeGreensboro)
zoneNatGreene.Id = "d62766a3-4f6f-4a7d-8a66-2a602ac2b9f0"
zoneNatGreene.Name = _QSt("\0048f$\005")
zoneNatGreene.Description = ""
zoneNatGreene.Visible = true
zoneNatGreene.Media = _iGcB
zoneNatGreene.Commands = {}
zoneNatGreene.DistanceRange = Distance(-1, "feet")
zoneNatGreene.ShowObjects = "OnEnter"
zoneNatGreene.ProximityRange = Distance(0, "meters")
zoneNatGreene.AllowSetPositionTo = false
zoneNatGreene.Active = false
zoneNatGreene.Points = {
  ZonePoint(53.2749779290172, 12.8091371894047, 0),
  ZonePoint(53.2750917160118, 12.8097211530915, 0),
  ZonePoint(53.2749988960325, 12.8097726895175, 0),
  ZonePoint(53.2747475285978, 12.8091464287153, 0)
}
zoneNatGreene.OriginalPoint = ZonePoint(36.0733500003815, -79.7893000284831, 0)
zoneNatGreene.DistanceRangeUOM = "Feet"
zoneNatGreene.ProximityRangeUOM = "Meters"
zoneNatGreene.OutOfRangeName = ""
zoneNatGreene.InRangeName = ""
zonePlanet = Wherigo.Zone(cartTourdeGreensboro)
zonePlanet.Id = "cc46b208-5080-4f5b-a141-eab4d80a3c37"
zonePlanet.Name = _QSt("b\005\017$K$\018\0291\n(\127\a\a")
zonePlanet.Description = ""
zonePlanet.Visible = true
zonePlanet.Media = _r8B
zonePlanet.Commands = {}
zonePlanet.DistanceRange = Distance(0, "meters")
zonePlanet.ShowObjects = "OnEnter"
zonePlanet.ProximityRange = Distance(0, "meters")
zonePlanet.AllowSetPositionTo = false
zonePlanet.Active = false
zonePlanet.Points = {
  ZonePoint(53.2751016641898, 12.8117179468899, 0),
  ZonePoint(53.2751171437406, 12.8119612988566, 0),
  ZonePoint(53.2748865563295, 12.8118855768418, 0),
  ZonePoint(53.2748785326724, 12.8117817398946, 0)
}
zonePlanet.OriginalPoint = ZonePoint(36.0721333344777, -79.7858999888102, 0)
zonePlanet.DistanceRangeUOM = "Meters"
zonePlanet.ProximityRangeUOM = "Meters"
zonePlanet.OutOfRangeName = ""
zonePlanet.InRangeName = ""
zonePillar = Wherigo.Zone(cartTourdeGreensboro)
zonePillar.Id = "b441f83e-f5e6-4755-83dc-30be2e402e5e"
zonePillar.Name = _QSt("t^\a1\n$K")
zonePillar.Description = ""
zonePillar.Visible = true
zonePillar.Media = _t1AR
zonePillar.Commands = {}
zonePillar.DistanceRange = Distance(-1, "feet")
zonePillar.ShowObjects = "OnEnter"
zonePillar.ProximityRange = Distance(0, "meters")
zonePillar.AllowSetPositionTo = false
zonePillar.Active = false
zonePillar.Points = {
  ZonePoint(53.2721459890348, 12.8081849267824, 0),
  ZonePoint(53.2722120355952, 12.8084278560178, 0),
  ZonePoint(53.2718797599516, 12.8083248457285, 0),
  ZonePoint(53.2718192978051, 12.807675204308, 0),
  ZonePoint(53.2720229984748, 12.8076989621491, 0)
}
zonePillar.OriginalPoint = ZonePoint(36.0721833308538, -79.7837833404541, 0)
zonePillar.DistanceRangeUOM = "Feet"
zonePillar.ProximityRangeUOM = "Meters"
zonePillar.OutOfRangeName = ""
zonePillar.InRangeName = ""
zoneFINAL = Wherigo.Zone(cartTourdeGreensboro)
zoneFINAL.Id = "cb50d8fe-5ed7-4182-b8ae-5ff1866919cc"
zoneFINAL.Name = _QSt("t#P\025h")
zoneFINAL.Description = _QSt("P\018\r_\01895=_99\018/\0189[\018+R=[A_\022)\"E\"\195\1881I\030$4\018K$1\n\017$\018\029\017K8\195\159$\005\a$^\017$")
zoneFINAL.Visible = true
zoneFINAL.Media = _XuS
zoneFINAL.Commands = {}
zoneFINAL.DistanceRange = Distance(-1, "feet")
zoneFINAL.ShowObjects = "OnEnter"
zoneFINAL.ProximityRange = Distance(0, "meters")
zoneFINAL.AllowSetPositionTo = false
zoneFINAL.Active = false
zoneFINAL.Points = {
  ZonePoint(53.2718189902591, 12.8049388762556, 0),
  ZonePoint(53.2718128774425, 12.8048195992719, 0),
  ZonePoint(53.2717634370496, 12.8048260581388, 0),
  ZonePoint(53.2717696171018, 12.8049487766105, 0)
}
zoneFINAL.OriginalPoint = ZonePoint(36.0719166676203, -79.7840000152588, 0)
zoneFINAL.DistanceRangeUOM = "Feet"
zoneFINAL.ProximityRangeUOM = "Meters"
zoneFINAL.OutOfRangeName = ""
zoneFINAL.InRangeName = ""
zoneFairway = Wherigo.Zone(cartTourdeGreensboro)
zoneFairway.Id = "948e4f9b-f341-4dac-ba0d-9057297411cb"
zoneFairway.Name = _QSt("\0291\n($D\a$")
zoneFairway.Description = ""
zoneFairway.Visible = true
zoneFairway.Media = zoneschleuse
zoneFairway.Commands = {}
zoneFairway.DistanceRange = Distance(-1, "feet")
zoneFairway.ShowObjects = "OnEnter"
zoneFairway.ProximityRange = Distance(0, "meters")
zoneFairway.AllowSetPositionTo = false
zoneFairway.Active = false
zoneFairway.Points = {
  ZonePoint(53.2719644214903, 12.8018835590844, 0),
  ZonePoint(53.2720595365974, 12.8016431201071, 0),
  ZonePoint(53.2721619607391, 12.8017599780268, 0),
  ZonePoint(53.2720776235753, 12.8019953898009, 0)
}
zoneFairway.OriginalPoint = ZonePoint(36.0710999965668, -79.7831833521525, 0)
zoneFairway.DistanceRangeUOM = "Feet"
zoneFairway.ProximityRangeUOM = "Meters"
zoneFairway.OutOfRangeName = ""
zoneFairway.InRangeName = ""
zoneParking = Wherigo.Zone(cartTourdeGreensboro)
zoneParking.Id = "b74ac2ec-04f0-40ce-bb6c-1d03062ccc73"
zoneParking.Name = _QSt("c8KI^\0054")
zoneParking.Description = ""
zoneParking.Visible = true
zoneParking.Commands = {}
zoneParking.DistanceRange = Distance(-1, "feet")
zoneParking.ShowObjects = "OnEnter"
zoneParking.ProximityRange = Distance(100, "feet")
zoneParking.AllowSetPositionTo = false
zoneParking.Active = true
zoneParking.Points = {
  ZonePoint(53.2760051295975, 12.812449682644, 0),
  ZonePoint(53.2760717056143, 12.8127456286724, 0),
  ZonePoint(53.2759140634217, 12.8128492908082, 0),
  ZonePoint(53.2758501140541, 12.8125622149182, 0)
}
zoneParking.OriginalPoint = ZonePoint(36.068799996376, -79.7922666549683, 0)
zoneParking.DistanceRangeUOM = "Feet"
zoneParking.ProximityRangeUOM = "Feet"
zoneParking.OutOfRangeName = ""
zoneParking.InRangeName = ""
zoneStatue = Wherigo.Zone(cartTourdeGreensboro)
zoneStatue.Id = "b382a03e-314c-42b0-bb48-4546a2156bae"
zoneStatue.Name = _QSt("u\127K]\1274$\005\n8D\a")
zoneStatue.Description = ""
zoneStatue.Visible = false
zoneStatue.Media = _ZoJ
zoneStatue.Commands = {}
zoneStatue.DistanceRange = Distance(0, "meters")
zoneStatue.ShowObjects = "OnEnter"
zoneStatue.ProximityRange = Distance(0, "meters")
zoneStatue.AllowSetPositionTo = false
zoneStatue.Active = false
zoneStatue.Points = {
  ZonePoint(53.2764270523531, 12.8115837608534, 0),
  ZonePoint(53.2763660843415, 12.8119030463594, 0),
  ZonePoint(53.2761580129236, 12.8117769218242, 0),
  ZonePoint(53.2762278251299, 12.8114611695013, 0)
}
zoneStatue.OriginalPoint = ZonePoint(36.0686499993006, -79.7918500264486, 0)
zoneStatue.DistanceRangeUOM = "Meters"
zoneStatue.ProximityRangeUOM = "Meters"
zoneStatue.OutOfRangeName = ""
zoneStatue.InRangeName = ""
zoneNattyGreene = Wherigo.Zone(cartTourdeGreensboro)
zoneNattyGreene.Id = "2b008401-ca4b-46d3-8208-a556cc6e3567"
zoneNattyGreene.Name = _QSt("\0291\n(\127\a\a\018\001^K\127\030")
zoneNattyGreene.Description = ""
zoneNattyGreene.Visible = true
zoneNattyGreene.Media = _UqJ5
zoneNattyGreene.Commands = {}
zoneNattyGreene.DistanceRange = Distance(0, "meters")
zoneNattyGreene.ShowObjects = "OnEnter"
zoneNattyGreene.ProximityRange = Distance(0, "meters")
zoneNattyGreene.AllowSetPositionTo = false
zoneNattyGreene.Active = false
zoneNattyGreene.Points = {
  ZonePoint(53.2772908656917, 12.8105557132594, 0),
  ZonePoint(53.2772412616696, 12.8107527710958, 0),
  ZonePoint(53.2770286262728, 12.8106006690632, 0),
  ZonePoint(53.2770788616169, 12.8104057794452, 0)
}
zoneNattyGreene.OriginalPoint = ZonePoint(36.0683333317439, -79.7903666814168, 0)
zoneNattyGreene.DistanceRangeUOM = "Meters"
zoneNattyGreene.ProximityRangeUOM = "Meters"
zoneNattyGreene.OutOfRangeName = ""
zoneNattyGreene.InRangeName = ""
zoneBook = Wherigo.Zone(cartTourdeGreensboro)
zoneBook.Id = "ffe39735-deb4-411c-a6da-ef7a0e034524"
zoneBook.Name = _QSt("a\127\n8\005\005^\017$KI^K1\n$")
zoneBook.Description = ""
zoneBook.Visible = false
zoneBook.Media = _wYI
zoneBook.Commands = {}
zoneBook.DistanceRange = Distance(0, "meters")
zoneBook.ShowObjects = "OnEnter"
zoneBook.ProximityRange = Distance(0, "meters")
zoneBook.AllowSetPositionTo = false
zoneBook.Active = false
zoneBook.Points = {
  ZonePoint(53.2763909433972, 12.8099208200171, 0),
  ZonePoint(53.2763881112738, 12.8096028750992, 0),
  ZonePoint(53.2761689444137, 12.8095898970053, 0),
  ZonePoint(53.2761588655999, 12.8099110421541, 0)
}
zoneBook.OriginalPoint = ZonePoint(36.0750833352407, -79.7902500152588, 0)
zoneBook.DistanceRangeUOM = "Meters"
zoneBook.ProximityRangeUOM = "Meters"
zoneBook.OutOfRangeName = ""
zoneBook.InRangeName = ""
zoneNorthGreene = Wherigo.Zone(cartTourdeGreensboro)
zoneNorthGreene.Id = "ec303a3d-b10a-4cce-9c78-5898d8d08d80"
zoneNorthGreene.Name = _QSt("/^\aI$(($K")
zoneNorthGreene.Description = ""
zoneNorthGreene.Visible = true
zoneNorthGreene.Media = _bkL
zoneNorthGreene.Commands = {}
zoneNorthGreene.DistanceRange = Distance(0, "meters")
zoneNorthGreene.ShowObjects = "OnEnter"
zoneNorthGreene.ProximityRange = Distance(0, "meters")
zoneNorthGreene.AllowSetPositionTo = false
zoneNorthGreene.Active = false
zoneNorthGreene.Points = {
  ZonePoint(53.2751654661733, 12.8097501310724, 0),
  ZonePoint(53.2754135373704, 12.809619089404, 0),
  ZonePoint(53.275323139822, 12.809159453578, 0),
  ZonePoint(53.2750915083174, 12.8092953785961, 0)
}
zoneNorthGreene.OriginalPoint = ZonePoint(36.0752000013987, -79.7909999847412, 0)
zoneNorthGreene.DistanceRangeUOM = "Meters"
zoneNorthGreene.ProximityRangeUOM = "Meters"
zoneNorthGreene.OutOfRangeName = ""
zoneNorthGreene.InRangeName = ""
zoneWoolworth = Wherigo.Zone(cartTourdeGreensboro)
zoneWoolworth.Id = "96e12bf1-dc73-4923-b895-2ff486f90e73"
zoneWoolworth.Name = _QSt("\014808(^$K\a\n8D\a")
zoneWoolworth.Description = ""
zoneWoolworth.Visible = true
zoneWoolworth.Media = _xKem
zoneWoolworth.Commands = {}
zoneWoolworth.DistanceRange = Distance(0, "meters")
zoneWoolworth.ShowObjects = "OnEnter"
zoneWoolworth.ProximityRange = Distance(0, "meters")
zoneWoolworth.AllowSetPositionTo = false
zoneWoolworth.Active = false
zoneWoolworth.Points = {
  ZonePoint(53.2774331940643, 12.8097622485991, 0),
  ZonePoint(53.2773758905452, 12.8099899547779, 0),
  ZonePoint(53.2772235608784, 12.8098655891177, 0),
  ZonePoint(53.277283622305, 12.8096509841808, 0)
}
zoneWoolworth.OriginalPoint = ZonePoint(36.0714999993642, -79.7902666727702, 0)
zoneWoolworth.DistanceRangeUOM = "Meters"
zoneWoolworth.ProximityRangeUOM = "Meters"
zoneWoolworth.OutOfRangeName = ""
zoneWoolworth.InRangeName = ""
zoneCourthouse = Wherigo.Zone(cartTourdeGreensboro)
zoneCourthouse.Id = "78bcf361-76e5-4c87-b8dc-ecbe7d8b1af9"
zoneCourthouse.Name = _QSt("h^$]$\a^\005\a$(")
zoneCourthouse.Description = ""
zoneCourthouse.Visible = true
zoneCourthouse.Media = _kvhk
zoneCourthouse.Commands = {}
zoneCourthouse.DistanceRange = Distance(0, "meters")
zoneCourthouse.ShowObjects = "OnEnter"
zoneCourthouse.ProximityRange = Distance(0, "meters")
zoneCourthouse.AllowSetPositionTo = false
zoneCourthouse.Active = false
zoneCourthouse.Points = {
  ZonePoint(53.2781376736319, 12.81052290118, 0),
  ZonePoint(53.2781863313983, 12.8108443508257, 0),
  ZonePoint(53.277952348776, 12.8109631825149, 0),
  ZonePoint(53.2778921783199, 12.8106670791102, 0)
}
zoneCourthouse.OriginalPoint = ZonePoint(36.0716499964396, -79.7918999989827, 0)
zoneCourthouse.DistanceRangeUOM = "Meters"
zoneCourthouse.ProximityRangeUOM = "Meters"
zoneCourthouse.OutOfRangeName = ""
zoneCourthouse.InRangeName = ""
ztaskTheFace = Wherigo.ZTask(cartTourdeGreensboro)
ztaskTheFace.Id = "4546af94-0975-4b5b-9939-e139dbeadbbd"
ztaskTheFace.Name = _QSt("\0048f$\005")
ztaskTheFace.Description = _QSt("z$^\017$K\0184$\n\017\a\018oDW\018\0048f$\005")
ztaskTheFace.Visible = false
ztaskTheFace.Media = _iGcB
ztaskTheFace.Active = false
ztaskTheFace.Complete = false
ztaskTheFace.CorrectState = "None"
ztaskThePlanet = Wherigo.ZTask(cartTourdeGreensboro)
ztaskThePlanet.Id = "f56d4b47-82f9-42fa-9862-9eb24c90adae"
ztaskThePlanet.Name = _QSt("D\005\017$K$\018\a1\n(\127\a\a")
ztaskThePlanet.Description = _QSt("I($^\005$K\018\025]\a\017$1\n$K\018oDW\018b\005\017$K$\005\018\0291\n(\127\a\a")
ztaskThePlanet.Visible = true
ztaskThePlanet.Media = _r8B
ztaskThePlanet.Active = false
ztaskThePlanet.Complete = false
ztaskThePlanet.CorrectState = "None"
ztaskArchitecture = Wherigo.ZTask(cartTourdeGreensboro)
ztaskArchitecture.Id = "8e322b4b-445e-4560-b335-bdac89412b03"
ztaskArchitecture.Name = _QSt("f^\a1\n$K")
ztaskArchitecture.Description = _QSt("`$\n$\018oDW\018t^\a1\n$K\018\1272$K\0184($^1\n\018\195\188]$K\0182^$\018)K\195\1881I$\\")
ztaskArchitecture.Visible = false
ztaskArchitecture.Media = _t1AR
ztaskArchitecture.Active = true
ztaskArchitecture.Complete = false
ztaskArchitecture.CorrectState = "None"
ztaskNotGolf = Wherigo.ZTask(cartTourdeGreensboro)
ztaskNotGolf.Id = "d005802b-bb0b-41d7-a3f0-40cf93637b63"
ztaskNotGolf.Name = _QSt("P\127\017\018`\127(f")
ztaskNotGolf.Description = _QSt("&$K\0178^\005(\f\018`K$$\005\a]\127K\127\0182\127$\a\018\005\127\017\018\n80$\0188\0184\127(f\0181\127DK\a$\018\017\n^\a\0181(\127\a$\\")
ztaskNotGolf.Visible = false
ztaskNotGolf.Media = zmediaFinal
ztaskNotGolf.Active = true
ztaskNotGolf.Complete = false
ztaskNotGolf.CorrectState = "None"
ztaskNamesake = Wherigo.ZTask(cartTourdeGreensboro)
ztaskNamesake.Id = "80a5f0a8-a70f-45f9-af41-015db2255b2c"
ztaskNamesake.Name = _QSt("u\127K]\1274$\005\n8D\a")
ztaskNamesake.Description = _QSt("\004^$K\018f\195\164\0054\017\0182^$\018u\127DK\0188\005\01828\a\018u\127K]\1274$\005\n8D\a=")
ztaskNamesake.Visible = true
ztaskNamesake.Media = _ZoJ
ztaskNamesake.Active = true
ztaskNamesake.Complete = false
ztaskNamesake.CorrectState = "None"
ztask200YearsLater = Wherigo.ZTask(cartTourdeGreensboro)
ztask200YearsLater.Id = "829d2ce9-854d-4b52-b967-3fe91bca9863"
ztask200YearsLater.Name = _QSt("\0291\n(\127\a\a")
ztask200YearsLater.Description = _QSt("a$\017o\017\0184$\n\017\a\018oDW\018\0291\n(\127\a\a")
ztask200YearsLater.Visible = false
ztask200YearsLater.Media = _UqJ5
ztask200YearsLater.Active = false
ztask200YearsLater.Complete = false
ztask200YearsLater.CorrectState = "None"
ztaskCivilRights = Wherigo.ZTask(cartTourdeGreensboro)
ztaskCivilRights.Id = "3c71af11-5516-4b17-bc20-34293059d7e2"
ztaskCivilRights.Name = _QSt("\014808(^$K\a\n8D\a")
ztaskCivilRights.Description = _QSt("JDW\018\014808(^$K\a\n8D\a\0188Df\018$^\005$\005\018\0148ff$$")
ztaskCivilRights.Visible = false
ztaskCivilRights.Media = _xKem
ztaskCivilRights.Active = false
ztaskCivilRights.Complete = false
ztaskCivilRights.CorrectState = "None"
ztaskCourthouse = Wherigo.ZTask(cartTourdeGreensboro)
ztaskCourthouse.Id = "43d0b050-e782-4d80-84ea-6504ffbba25e"
ztaskCourthouse.Name = _QSt("h^$]$\a^\005\a$(")
ztaskCourthouse.Description = _QSt("\195\188]$K\018\029^$]$\005\018)K\195\1881I$\005====\005$^\005\018\005DK\018$^\005$\018")
ztaskCourthouse.Visible = false
ztaskCourthouse.Media = _kvhk
ztaskCourthouse.Active = false
ztaskCourthouse.Complete = false
ztaskCourthouse.CorrectState = "None"
ztaskNorthGreene = Wherigo.ZTask(cartTourdeGreensboro)
ztaskNorthGreene.Id = "95d6705c-a872-4487-8afe-2992a6d919bc"
ztaskNorthGreene.Name = _QSt("/^\aI$(($K")
ztaskNorthGreene.Description = _QSt("\025Df\0188Df\018oDW\018/^\aI$(($K")
ztaskNorthGreene.Visible = false
ztaskNorthGreene.Media = _bkL
ztaskNorthGreene.Active = false
ztaskNorthGreene.Complete = false
ztaskNorthGreene.CorrectState = "None"
ztaskTheGift = Wherigo.ZTask(cartTourdeGreensboro)
ztaskTheGift.Id = "1b265626-091a-4bbc-97dc-8d16aebdd478"
ztaskTheGift.Name = _QSt("a\127\n8\005\005^\017$K")
ztaskTheGift.Description = _QSt("JDK\018\014^K1\n$====\018O^$\018\025D\a\a^1\n\017\0180\127W\018\014^K1\n\017DKW\0184$\005^$\195\159$\005p")
ztaskTheGift.Visible = false
ztaskTheGift.Media = _wYI
ztaskTheGift.Active = false
ztaskTheGift.Complete = false
ztaskTheGift.CorrectState = "None"
ztaskSchleuse = Wherigo.ZTask(cartTourdeGreensboro)
ztaskSchleuse.Id = "6d964a72-fbb3-4392-84e2-37ab735e2bf7"
ztaskSchleuse.Name = _QSt("\0291\n($D\a$")
ztaskSchleuse.Description = _QSt("`$\n$\018oDW\018)8D2$\005IW8(\b\0291\n($D\a$\\\022)\"E)^\017\017$\018\005$\nW\017\0182$\005\018z$4\018\195\188]$K\0182$\005\018\001\195\188\n($\00528WW")
ztaskSchleuse.Visible = true
ztaskSchleuse.Media = zoneschleuse
ztaskSchleuse.Active = false
ztaskSchleuse.Complete = false
ztaskSchleuse.CorrectState = "None"
input = ""
shownIntro = false
_JzN = _QSt("o\127\005$P8\017`K$$\005$")
_7_D = _QSt("2DWW\f")
_bF3x = _QSt("2DWW\f")
_w63 = _QSt("o\0178\aIu\n$t81$")
_Xykan = _QSt("o^\005\016D\017&\127DK\017\n\127D\a$&\n$1I")
_Y4B = _QSt("2DWW\f")
cartTourdeGreensboro.ZVariables = {
  input = "",
  shownIntro = false,
  _JzN = _QSt("o\127\005$P8\017`K$$\005$"),
  _7_D = _QSt("2DWW\f"),
  _bF3x = _QSt("2DWW\f"),
  _w63 = _QSt("o\0178\aIu\n$t81$"),
  _Xykan = _QSt("o^\005\016D\017&\127DK\017\n\127D\a$&\n$1I"),
  _Y4B = _QSt("2DWW\f")
}
zinputCourthouseCheck = Wherigo.ZInput(cartTourdeGreensboro)
zinputCourthouseCheck.Id = "3f79b6de-3f11-409f-af40-da70f7e1de7d"
zinputCourthouseCheck.Name = _QSt("h^$]$\a^\005\a$(&\n$1I")
zinputCourthouseCheck.Description = _QSt("\025Df\0182$K\018\226\128\158h^$]$\a^\005\a$(\226\128\156\018(^$4\017\01828\a\018`K8]W8(\0180\127\005ppp")
zinputCourthouseCheck.Visible = true
zinputCourthouseCheck.InputType = "Text"
zinputCourthouseCheck.Text = _QSt("h\127\127I\018f\127K\018\017\n$\018WDK8(\018\v\"$\a^\a\0178\0051$\018\017\127\018\017\fK8\005\005\f\018^\a\018\127]$2^$\0051$\018\017\127\018`\1272\v=\018-\005]\a\016\028z\n8\017\018\127\017\n$K\018\030\127K2\018^\a\018\127\005\018\017\n^\ap")
function cartTourdeGreensboro:OnStart()
end
function cartTourdeGreensboro:OnRestore()
end
function zoneNatGreene:OnEnter()
  _JzN = _QSt("o\127\005$P8\017`K$$\005$")
  _Urwigo.MessageBox({
    Text = _QSt("O$K\018\001^K\127\030$K\018\029\01782\017\n8f$\005\018(^$4\017\0188\005\0182$K\018\001\195\188K^\017ow\00480$(wz8\a\a$K\a\017K8\195\159$\018D\005\030$^\017\0182$\a\018\001^K\127\030$K\018\029$$\a=\018O$K\018\a\017\195\1642\017^\a1\n$\018\025\005($4$K\018^\a\017\018^\005\018$^\005$W\018^2\f((^\a1\n$\005\018\029$^\017$\0058KW\0182$K\018z8\a\a$K\a\017K8\195\159$\0184$($4$\005\018D\0052\018]$f^\0052$\017\018\a^1\n\018o\030^\a1\n$\005\018\0291\n(\127\a\a^\005\a$(\018D\0052\018\027K\017=\018\001^\017\018\a$^\005$\005\018`8\a\017(^$4$K\005\018D\0052\0189Q\r\018W\018z8\a\a$K\017^$f$\018^\a\017\018$K\0182$K\018\127\016\017^W8($\018\"8\a\017\016(8\017o\018f\195\188K\018)\127\127\017\af8\nK$K=\018h/#O/\"\018#\029u\018O/\"\018\004\025t/P\018Jb\"\018J/#u\018`/\029c/\"u=\022)\"EY\127\005\018\n^$K\018\a\0178K\017$\017\0188D1\n\0182^$\018)(8Dwz$^\a\a$wt(\127\017\017$=\018Y\127W\018u84$\a8D\af(D4\018]^\a\018oDW\018\014DKow2^$w\029$$($w]8DW$(\005w(8\a\a$\005\018^\a\017\0188(($\a\01828]$^=\018"),
    Media = zmediaPlanet
  })
  ztaskTheFace.Complete = true
  ztaskThePlanet.Active = true
  ztaskThePlanet.Visible = true
  zonePlanet.Active = true
  zonePlanet.Visible = true
  zoneNatGreene.Active = false
end
function zonePlanet:OnEnter()
  _JzN = _QSt("o\127\005$c(8\005$\017")
  ztaskThePlanet.Complete = true
  _Urwigo.MessageBox({
    Text = _QSt("O^$\a$K\018)8K\1271I]8D\018\030DK2$\0189:55\018$KK^1\n\017$\017\018D\0052\018](^$]\018oD\005\195\1641\n\a\017\018D\0050\127(($\0052$\017=\018/K\018$K\a$\017o\017$\018$^\005$\005\018$^\005f81\n$\005Q\018\a1\nWD1I(\127\a$\005\018Y\127K4\195\164\0054$K]8D=\018-\005]\a\016\028#\005\018\001^K\127\030\018\n\195\182K\017$\0182^$\018f\195\188K\a\017(^1\n$\018\004\127f\n8(\017D\0054\0188DfQ\0182^$\018\0291\n(\195\182\a\a$K\018\a\0178\0052$\005\018\00581\n\0189:59\018\030$^\0174$\n$\0052\018($$K=\018#W\018b\005\017$K$\005\018\0291\n(\127\a\a\018\n^$(\017\0189R[{\018$^\005\018h$\nK$K\a$W^\0058K\018/^\005oD4Q\018\030\127\018f\195\188K\018W$\nK\0188(\a\018$^\005\018a8\nK\nD\0052$K\017\018Y\127(I\a\a1\nD(($\nK$K\018f\195\188K\018O\127W8\005^8(2\195\182Kf$K\018D\0052\018\029\017\195\1642\017$\0182$\a\018\029\017K$(^\017o\a1\n$\005\018h8\0052$\a\017$^(\a\0188D\a4$]^(2$\017\018\030DK2$\005=\018JD\018OO\"wJ$^\017$\005\018]$\n$K]$K4\017$\01828\a\018b\005\017$K$\018\0291\n(\127\a\a\0182^$\018c\127(\f\017$1\n\005^\a1\n$\018\027]$K\a1\nD($\018/\017I8K\018\025\0052K\195\169\018D\0052\018\00581\n\0182$K\018z$\0052$\018$^\005\018`\fW\0058\a^DW=\018O$K\018\0291\nD(]$\017K^$]\018\030DK2$\018[{{5\018$^\0054$\a\017$((\017="),
    Media = zmediaPillar
  })
  zonePillar.Active = true
  ztaskArchitecture.Active = true
  ztaskArchitecture.Visible = true
  zonePlanet.Active = false
end
function zonePillar:OnEnter()
  _JzN = _QSt("o\127\005$c^((8K")
  ztaskArchitecture.Complete = true
  _Urwigo.MessageBox({
    Text = _QSt("O$K\018\029\0178\0052\127K\017\0182$K\018t^\a1\n$K$^\018^\005\018\001^K\127\030\018\030DK2$\018DW\0189A{{\0180\127\005\01828W8(\a\018^\005\018\001^K\127\030\0188\005\a\195\164\a\a^4$\005\018t^\a1\n$Kf8W^(^$\005\018$\0178](^$K\017=\018#\005\0182$\005\0189A_{$K\005\018\030DK2$\005\0180$K\a1\n^$2$\005$\018\004\127(o\a1\nD\016\016$\005\0184$]8D\017=\018Y$K\a1\n^$2$\005$\018c\195\1641\n\017$K\018\0308K$\005\0188Df\0182$W\018t^\a1\n$K$^\n\127f\018\001^K\127\030\018\017\195\164\017^4Q\018]^\a\0188D1\n\0182^$\a$\018t^\a1\n$K$^\018D\0052\018DW(^$4$\0052$\018`$\030\195\164\a\a$K\0182$\005\018Y\127(I\a$^4$\005$\005\018)$\017K^$]$\005\0182$K\018OO\"\018oD4$\a1\nK^$]$\005\018\030DK2$\005=\022)\"E\025]\0189A\rR\018\030DK2$\0188Df\0182$W\018t^\a1\n$K$^\n\127f\018\001^K\127\030\01828\a\018\005\1271\n\018\n$D\017$\0180\127K\n8\0052$\005$\018I\127W]^\005^$K\017$\018z^K\017\a1\n8f\017\aw\018D\0052\018z\127\n\0054$]\195\164D2$\0184$]8D\017=\018\0291\n\127\005\018\a$^\017\0189ARA\018]$\a\017$\n\017\0188Df\0182$W\018t^\a1\n$K$^\n\127f\018\001^K\127\030\018$^\005\018t^\a1\n4$\a1\n\195\164f\017=\018\029$^\0172$W\018\a^\0052\0180^$($\018]8D(^1\n$\018Y$K\195\164\0052$KD\0054$\005\0182$\a\018t^\a1\n4$\a1\n\195\164f\017$\a\018D\0052\0188\005\0182$\005\018DW(^$4$\0052$\005\018`$]\195\164D2$\0180\127K4$\005\127WW$\005\018\030\127K2$\005=\018#W\018a8\nK\018[{9:\018\030DK2$\01828\a\018`$]\195\164D2$\0180\127((\a\017\195\164\0052^4\018\a8\005^$K\017\018D\0052\018^\005\018[{9R\018$Kf\127(4\017\0182^$\018`$\a\0178(\017D\0054\0182$K\018\025D\195\159$\0058\005(84$"),
    Media = zmediaLight
  })
  zoneFairway.Active = true
  zonePillar.Active = false
  ztaskSchleuse.Visible = true
  ztaskSchleuse.Active = true
end
function zoneFINAL:OnEnter()
  _JzN = _QSt("o\127\005$t#P\025h")
  _Urwigo.OldDialog({
    {
      Text = _QSt("O8\a\018t^\0058(\018]$f^\0052$\017\018\a^1\n\018]$^\018P\018\r_\01895=_99\018/\0189[\018+R=[A_\022)\"E\"\195\1881I\030$4\018K$1\n\017$\018\029\017K8\195\159$\005\a$^\017$"),
      Media = zmediaFinal2
    }
  })
  cartTourdeGreensboro.Complete = true
  cartTourdeGreensboro:RequestSync()
end
function zoneFairway:OnEnter()
  _JzN = _QSt("o\127\005$t8^K\0308\f")
  ztaskSchleuse.Active = false
  ztaskSchleuse.Visible = true
  _Urwigo.MessageBox({
    Text = _QSt("O^$\018\0291\n($D\a$\018\001^K\127\030\018^\a\017\018w\018$^\005\018\017$1\n\005^\a1\n$\a\018O$\005IW8(\0182$K\018\029\01782\017\018\001^K\127\030\018w\018^\a\017\018u$^(\0182$K\018\001\195\188K^\017ow\00480$(wz8\a\a$K\a\017K8\195\159$\018D\0052\0188K]$^\017$\017\018\005\1271\n\018^W\018\0048\0052]$\017K^$]\0182DK1\n\018$^\005$\005\018\0291\n($D\a$\005\030\195\164K\017$K=\018\029^$\018\n8\017\018$^\005$\018h\195\164\0054$\0180\127\005\018\r5\018W\018D\0052\018$^\005$\018)K$^\017$\0180\127\005\0185Q5\018W=\022)\"E\0018\005\018\005$\005\005\017\018\a^$\0188D1\n\018u\127K\018oDK\018\001\195\188K^\017oQ\01828\018\n^$K\0182^$\018\014($^\005\a$$\005\016(8\017\017$\018W^\017\0182$K\018\001\195\188K^\017o\018D\0052\0182$\005\0184K\127\195\159$\005\018\027]$K\a$$\005\018I\195\188\005\a\017(^1\n\018^\005\0182$\005\018a8\nK$\005\0189A_\r\b_5\0180$K]D\0052$\005\018\030DK2$\005=\018`K\127\195\159$\018\004D]\017\127K$\018DW\a1\n(^$\195\159$\005\0182^$\018z8\a\a$KI8WW$K\018D\0052\018$\a\018\030^K2\018$^\005\018\004\195\182\n$\005D\005\017$K\a1\n^$2\0180\127\005\01818=\018_Q\r\018\001$\017$K\005\018\195\188]$K\030D\0052$\005=\022)\"E\025D\a4$o$^1\n\005$\017\\\018\029D1\n$\005\018\029^$\018|$\017o\017\0182$\005\018&81\n$\018^\005\0182$K\018P\195\164\n$=\018\029$^\005\018\029\0178\0052\127K\017\018]$f^\0052$\017\018\a^1\n\018^\005\0182$K\018h^\a\017$\018\029\0178\0052\127K\017$=\022)\"E\0291\n(^$\195\159$\005\018\029^$\0182^$\018&8K\017K^24$\018\005\1271\n\018\005^1\n\017\\\018\029^$\018\030^K2\018\005DK\01828\005\005\0188(\a\0180\127((\a\017\195\164\0052^4\018W8KI^$K\017Q\018\030$\005\005\018\029^$\018\a^1\n\018^\005\0182$K\018P\195\164\n$\0182$\a\018&81\n$\a\018]$f^\0052$\005\\")
  })
  ztaskNotGolf.Complete = true
  zoneFINAL.Active = true
  zoneFINAL.Visible = true
  zoneFairway.Active = false
end
function zoneParking:OnEnter()
  _JzN = _QSt("o\127\005$c8KI^\0054")
  if shownIntro == false then
    shownIntro = true
    _Urwigo.OldDialog({
      {
        Text = _QSt("z^((I\127WW$\005\018^\005\018\001^K\127\030\\\022)\"EO^$\a$\018&8K\017K^24$\018f^\0052$\017\018^\005\018D\0052\018DW\0182$K\018#\005\005$\005\a\01782\017\0180\127\005\018\001^K\127\030\018\a\0178\017\017=\018z\195\164\nK$\0052\018\029^$\0182^$\a$\005\018z\n$K^4\127\018\a\016^$($\005Q\018($K\005$\005\018\029^$\018$^\005\018\030$\005^4\018\195\188]$K\0182^$\a$\018\029\01782\017=\018z$\005\005\018\029^$\0188\005\018$^\005$W\018J^$(\0188\005I\127WW$\005Q\018\a^\0052\018\029^$\018\127f\017\018^\005\018\029^1\n\017\030$^\017$\0182$K\018\005\195\1641\n\a\017$\005\018/\0178\016\016$=\018O8\n$K\018$K\n8(\017$\005\018\029^$\018$^\005\018)^(2\018D\0052\018$^\005$\005\018\004^\005\030$^\aQ\0182$K\018#\n\005$\005\0182$\005\018\027K\017\018o$^4\017=\018)$^\018\027K\017$\005Q\0182^$\018\a^1\n\018\005^1\n\017\018^\005\018\029^1\n\017\030$^\017$\018]$f^\0052$\005Q\018\030^K2\0182$K\018\029\0178\0052\127K\017\018\a\127f\127K\017\0188\0054$o$^4\017=\018t\127(4$\005\018\029^$\018^\005\0182^$\a$W\018t8((\018$^\005f81\n\018#\nK$K\018\027K^$\005\017^$KD\0054=")
      },
      {
        Text = _QSt("h\127\a\0184$\n\017\a\\\022)\"E\022)\"EP8\017DKK\195\164DW(^1\n\018^\a\017\018\001^K\127\030\018u$^(\0182$\a\018P$D\a\017K$(^\017o$K\018\014($^\005\a$$\005(8\0052$\a\018^\005\0182$K\018\001$1I($\005]DK4^\a1\n$\005\018\029$$\005\016(8\017\017$=\018O^$\018\014($^\005\a\01782\017\018(^$4\017\0188W\018\029\195\1882$\0052$\0182$\a\018\001^K\127\030$K\018\029$$\aQ\0182$K\018\195\188]$K\018$^\005$\01848\005o$\018\014$\017\017$\0180\127\005\018\029$$\005Q\018t(\195\188\a\a$\005\018D\0052\018\0148\005\195\164($\005\018W^\017\0182$K\018\001\195\188K^\017o\018D\0052\018\195\188]$K\0182$\005\018\001^K\127\030$K\018\0148\0058(Q\0182$K\018)$\a\0178\0052\017$^(\0182$K\018\001\195\188K^\017ow\00480$(wz8\a\a$K\a\017K8\195\159$\018^\a\017Q\018W^\017\0182$K\018\00480$(\0180$K]D\0052$\005\018^\a\017\022)\"E")
      },
      {
        Text = _QSt("z$K\0188Df\0182^$\018\001^K\127\030$K\018\0291\n(\127\a\a^\005\a$(\018W\195\1821\n\017$\018I\127WW\017\0188\005\0182$W\018`$]\195\164D2$\018\005^1\n\017\0180\127K]$^="),
        Media = zmediaGreeneStatue
      }
    })
    ztaskNamesake.Active = true
    ztaskNamesake.Visible = true
    zoneStatue.Active = true
  end
end
function zoneStatue:OnEnter()
  _JzN = _QSt("o\127\005$\029\0178\017D$")
  _Urwigo.OldDialog({
    {
      Text = _QSt("O8\a\018\030$^\195\159$\018\"$\0058^\a\a8\0051$\017\127K\n8D\a\018\030DK2$\018oD\a8WW$\005\018W^\017\0182$W\018z8((\018\030DK2$\0189\rRR\018$K]8D\017$Q\01828W8(\a\018\a\017$((\017$\018$\a\0182$\005\018$^\005o^4$\005\018JD48\0054\018oDK\018#\005\a$(\01828K=\018/\a\018^\a\017\018\005$]$\005\0182$K\018\014^K1\n$Q\018\001^K\127\030\a\018\195\164(\017$\a\017$\a\018`$]\195\164D2$=\018)$^\0182$W\018o\030$^\a\017\195\1821I^4$\005\018)81I\a\017$^\005\n8D\a\018\n8\0052$(\017\018$\a\018\a^1\n\018DW\018$^\005\0180$K\016D\017o\017$\a\018t81\n\030$KI\n8D\a=\018O8\a\018h8\0052$\a\0308\016\016$\005\018$K\n^$(\017\01828\a\018u\127K\n8D\a\0189\rRR\018D\005\017$K\0182$K\018\"$4$\005\017\a1\n8f\017\0180\127\005\018\004$Ko\1274\018\0148K(\018oD\018\001$1I($\005]DK4")
    },
    {
      Text = _QSt("O^$\018\005\195\1641\n\a\017$\005\018`$]\195\164D2$\018\030DK2$\005\018]^\a\018[{9+\018\a8\005^$K\017="),
      Media = zmediaNattyGreene
    }
  })
  ztaskNamesake.Complete = true
  ztask200YearsLater.Active = true
  ztask200YearsLater.Visible = true
  zoneStatue.Active = false
  zoneNattyGreene.Active = true
end
function zoneNattyGreene:OnEnter()
  _JzN = _QSt("o\127\005$P8\017\017\f`K$$\005$")
  ztask200YearsLater.Complete = true
  _Urwigo.OldDialog({
    {
      Text = _QSt("O8\a\018\0291\n(\127\a\a\018]$\a\017$\n\017\018^\005\018\a$^\005$W\018\014$K\005\018\005\1271\n\0188D\a\018u$^($\005\018$^\005$\a\018Y\127K4\195\164\0054$K]8D\a\0180\127\005\0189:{RQ\0182$K\018]$^\0182$W\018)K8\0052\0189:+[\018\0168K\017^$((\018o$K\a\017\195\182K\017\018\030DK2$=\018O$K\018]8K\1271I$\018t$\a\017\a88(\018\a\0178WW\017\018\005\1271\n\0180\127\005\0189:9{=\018Y\127\005\0189:+A\018]^\a\0189:5{\018$\005\017\a\0178\0052\01828\a\018]8K\1271I$\018\0291\n(\127\a\a\018\001^K\127\030\018\00581\n\018c(\195\164\005$\005\0180\127\005\018&\nK^\a\017\127\016\n\018aD(^D\a\018h\195\182\030$=\018O8\a\018\a1\n(^1\n\017$\018`$]\195\164D2$\018\n8\017\018$^\005$\018I\127\a\017]8K$\018#\005\005$\0058D\a\a\0178\017\017D\0054=\018\029$\n$\005\a\030$K\017\018\a^\0052\0182$K\018t$\a\017\a88(\018W^\017\018$^\005$K\018\195\188\016\016^4$\005\018\029\017D1I2$I\127K8\017^\127\005Q\0182^$\018z8\00520\127K(84$\005\0188D\a\018f8K]^4$W\018\0018KW\127KQ\0182$K\018W^\017\018\029$^2$\005\0178\016$\017$\005\0188D\a4$I($^2$\017$\018\"\127\017$\018\0298(\127\005\018\a\127\030^$\018`$W\195\1641\n$K\018W^\017\018^\005\0181\n^\005$\a^\a1\n$W\018\029\017^(\018]$W8(\017$\005\018u8\016$\017$\005=")
    },
    {
      Text = _QSt("a$\017o\017\018OK$\n$\005\018z^K\018D\005\a\018/^\005W8(\018DW\\")
    },
    {
      Text = _QSt("O8\a\018\014808(^$K\a\n8D\a"),
      Media = zmediaWoolworth
    }
  })
  zoneWoolworth.Active = true
  zoneWoolworth.Visible = true
  ztaskCivilRights.Active = true
  ztaskCivilRights.Visible = true
  zoneNattyGreene.Active = false
end
function zoneBook:OnEnter()
  _JzN = _QSt("o\127\005$)\127\127I")
  ztaskTheGift.Complete = true
  _Urwigo.MessageBox({
    Text = _QSt("O^$\018a\127\n8\005\005^\017$KI^K1\n$\018^\a\017\018\001^K\127\030\a\018\195\164(\017$\a\017$\a\018`$]\195\164D2$=\018O$K\018$^\005\a1\n^ff^4$\0184\127\017^\a1\n$\018J^$4$(]8D\018]$f^\0052$\017\018\a^1\n\018$]$\005f8((\a\0188Df\0182$K\018\0291\n(\127\a\a^\005\a$(=\0189:+[\018f^$(\018\a^$\0184$\0058D\018\030^$\01828\a\018\0291\n(\127\a\a\018$^\005$W\0180$K\n$$K$\0052$\005\018)K8\0052\018oDW\018\027\016f$K=\018\025W\0189=\018\02520$\005\017\0189:+[\018\030DK2$\0182$K\018z^$2$K8Df]8D\018]$$\0052$\017\018D\0052\0182^$\018\014^K1\n$\0184$\030$^\n\017=\022)\"E)$^\0182$W\018z^$2$K8Df]8D\018\030DK2$\018^\nK\018#\005\005$K\a\017$\a\018^W\018\029\017^(\0182$\a\018)8K\1271I\a\0184$\a\0178(\017$\017=\018O^$\018ID\016f$K\005$\018uDKW8]2$1ID\0054\018\030DK2$\0180\127\005\018tK^$2K^1\n\0182$W\018##\0180\127\005\018cK$D\195\159$\005\0184$\a\016\127\005\a\127K\017=\0189A+\r\01828\005\005\018\030DK2$\018\a^$\018$^\005\018\030$^\017$K$\a\018\0018(\018o$K\a\017\195\182K\017=\018bK\a81\n$\01828f\195\188K\018\0308K\0182$K\0182$D\017\a1\n$\018`K8\0058\017$\005]$\a1\nD\a\a=\018#\nK\018z^$2$K8Df]8D\018]$48\005\005\018|$2\1271\n\018\a\127f\127K\017=\018\029\127\018I\127\005\005\017$\0182^$\018\014^K1\n$\018\a1\n\127\005\018\r\018a8\nK$\018\a\016\195\164\017$K\018\030^$2$K\0184$\030$^\n\017\018\030$K2$\005=\018\029$^\017\0189AA_\018]$\a^\017o\017\018\a^$Q\01828\005I\0182$W\018\014^K1\n\017DKW0$K$^\005\018$=Y=Q\018\030^$2$K\018$^\005$\005\018\014^K1\n\017DKWQ\0182$K\0188D1\n\018]$\a\017^$4$\005\018\030$K2$\005\018I8\005\005="),
    Media = zmediaNatGreene
  })
  ztaskNorthGreene.Active = true
  ztaskNorthGreene.Visible = true
  zoneNorthGreene.Active = true
  zoneBook.Active = false
end
function zoneNorthGreene:OnEnter()
  _JzN = _QSt("o\127\005$P\127K\017\n`K$$\005$")
  ztaskNorthGreene.Complete = true
  zoneNatGreene.Visible = true
  _Urwigo.MessageBox({
    Text = _QSt("\004^$K\0184^]\017\018$\a\0180^$(\018oD\018$\005\0172$1I$\005=\018)$81\n\017$\017\0188D1\n\0182^$\018#\005f\127\0178f$(=\018\0291\n8D\017\018/D1\n\018DW\018]$0\127K\018$\a\01828\005\005\018oDW\018I($^\005$\005\018\0048f$\005\0184$\n\017="),
    Media = zmediaBook
  })
  ztaskTheFace.Active = true
  ztaskTheFace.Visible = true
  zoneNatGreene.Active = true
  zoneNorthGreene.Active = false
end
function zoneWoolworth:OnEnter()
  _JzN = _QSt("o\127\005$z\127\127(\030\127K\017\n")
  ztaskCivilRights.Complete = true
  _Urwigo.OldDialog({
    {
      Text = _QSt("O8\a\018\014808(^$K\a\n8D\a\018w\018_\018\014\195\182\005^4^\005\005$\005\018c8(8^\a\018(^$4\017\018^W\018\n^\a\017\127K^\a1\n$\005\018/\005\a$W]($\0182$K\018\0291\n(\127\a\a^\005\a$(\018\001^K\127\030\018D\0052\018]$^\005\n8(\017$\017\018$^\005$\018^\005\017$K8I\017^0$\018/K($]\005^\a8D\a\a\017$((D\0054\018oDK\018`$\a1\n^1\n\017$\0182$K\018\"$4^\127\005=\018#\005\018$^\005$K\018($]$\0052^4$\005\018\025K\017\018D\0052\018z$^\a$\018\030^K2\0182$K\018)$\aD1\n$K\0180\127\005\0182$K\018\029(8\030$\005o$^\017\018]^\a\018oD\0182$\005\018\n$D\017^4$\005\018\0291\n\195\164\017o$\005\0188\005\018`D\017\a\n\195\164D\a$K\005Q\018\014^K1\n$\005\018D\0052\018)DK4$\005\0184$f\195\188\nK\017=\018#W\018\001^\017\017$(\016D\005I\017\018\a\017$\n$\005\018|$2\1271\n\0182K$^\018W$1I($\005]DK4^\a1\n$\018cK^\005o$\a\a^\005\005$\005Q\0182^$\0188\005\018$DK\127\016\195\164^\a1\n$\005\018\004\195\182f$\005\018oD\018\014\195\182\005^4^\005\005$\005\0184$IK\195\182\005\017\018\030DK2$\005X\0182^$\018^\005\018\001^K\127\030\0184$]\127K$\005$\018\029\127\016\n^$\018&\n8K(\127\017\017$\018\t\014\195\182\005^4^\005\0180\127\005\018/\0054(8\0052MQ\018hD^\a$\018\t\014\195\182\005^4^\005\0180\127\005\018cK$D\195\159$\005M\018D\0052\018^\nK$\018\0291\n\030$\a\017$K\018tK^$2$K^I$\018\t\014\195\182\005^4^\005\0180\127\005\018\0048\005\005\1270$KM=O8K\195\188]$K\018\n^\0058D\a\018]^$\017$\017\01828\a\018\0048D\a\018$^\005\0180^$(f\195\164(\017^4$\a\018\"8\nW$\005\016K\1274K8WW\018W^\017\018t\195\188\nKD\0054$\005\018D\0052\018\025D2^\127w`D^2$\a\018\195\188]$K\0182^$\018\0291\n(\127\a\a^\005\a$(\018\001^K\127\030Q\018t8W^(^$\0058\0054$]\127\017$\005\018\a\127\030^$\018$^\005\018&8f\195\169\018W^\017\018u\127K\017$\005\a\016$o^8(^\017\195\164\017$\005\018D\0052\018$^\005$K\018\025D\195\159$\005\017$KK8\a\a$\018W^\017\018)(^1I\0188Df\0182$\005\018\001^K\127\030$K\018\029$$=")
    },
    {
      Text = _QSt("P8Q\018|$\017o\017\018$^\005$\018c8D\a$p\018/^\005\018\0148ff$$\018D\0052\018$^\005\018\029\017\195\1881I\018u\127K\017$p"),
      Media = zmediaWoolworthPlaque
    },
    {
      Text = _QSt("z$\005\005\018\005^1\n\017\01828\005\005\0184$\n$\005\018\030^K\018|$\017o\017\0188Df\0182^$\018h^$]$\a^\005\a$(\\\022)\"E/^\005$\018\a1\nW^$2$$^\a$K\005$\018)K\195\1881I$\018f\195\188\nK\017\018oDK\018\a\1274$\0058\005\005\017$\005\018h^$]$\a^\005\a$(Q\0182^$\0182^$\018\"D\n$\a\017\195\164\017\017$\0182$\a\018($\017o\017$\005\018K$4^$K$\0052$\005\018`K\127\195\159\n$Ko\1274\a\0180\127\005\018\001$1I($\005]DK4w\029\017K$(^\017o\018]$\n$K]$K4\017="),
      Media = zmediaCourthouse
    }
  })
  zoneWoolworth.Visible = false
  zoneWoolworth.Active = false
  zoneCourthouse.Visible = true
  zoneCourthouse.Active = true
  ztaskCourthouse.Active = true
  ztaskCourthouse.Visible = true
end
function zoneCourthouse:OnEnter()
  _JzN = _QSt("o\127\005$&\127DK\017\n\127D\a$")
  ztaskCourthouse.Complete = true
  _Urwigo.MessageBox({
    Text = _QSt("\"D\0052\018DW\01828\a\018\0291\n(\127\a\a\018]$\n$K]$K4\017\0182^$\018#\005\a$(\0182$\005\018I($^\005$\005\018\0291\n(\127\a\a\0168KI=\018Y\127\005\0182$W\018DK\a\016K\195\188\0054(^1\n$\005\018)8K\1271I48K\017$\005Q\0182$K\01828\a\018\001^K\127\030$K\018\0291\n(\127\a\a\018DW48]Q\018^\a\017\018f8\a\017\018\005^1\n\017\a\018$K\n8(\017$\005=\018O$K\018\n$D\017^4$\018c8KI\018^\a\017\018^W\018\029\017^(\018$\0054(^\a1\n$K\018h8\0052\a1\n8f\017\a4\195\164K\017$\005\0184$\a\0178(\017$\017=\018\025Df\0182$K\018h^$]$\a^\005\a$(\018(^$4\017\01828\a\018`K8]W8(\0180\127\005\018\0252\127(f\018tK^$2K^1\n\018Y#=Q\0182$\a\018($\017o\017$\005\018`K\127\195\159\n$Ko\1274\a\0182$\a\018h8\0052$\a\017$^(\a\018\001$1I($\005]DK4w\029\017K$(^\017o=\018/K\018\a\0178K]\018^W\018t$]KD8K\0189A9R\0182DK1\n\018\029$(]\a\017W\127K2\018D\0052\018\030DK2$\0182$\a\n8(]\018\005^1\n\017\018^\005\0182$K\018t\195\188K\a\017$\0054KDf\017\018]$\a\0178\017\017$\017=")
  })
  zoneCourthouse.Visible = false
  zoneCourthouse.Active = false
  zoneBook.Visible = true
  zoneBook.Active = true
  ztaskTheGift.Active = true
  ztaskTheGift.Visible = true
end
function zinputCourthouseCheck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 57003 then
    _Urwigo.Dialog(false, {
      {
        Text = _QSt("\029$\nK\0184D\017\\\018\022)\"E\025Df\0182$K\018\226\128\158h^$]$\a^\005\a$(\226\128\156\018(^$4\017\01828\a\018`K8]W8(\0180\127\005\018\0252\127(f\018tK^$2K^1\n\018Y#=Q\0182$\a\018($\017o\017$\005\018`K\127\195\159\n$Ko\1274\a\0182$\a\018h8\0052$\a\017$^(\a\018\001$1I($\005]DK4w\029\017K$(^\017o=\018/K\018\a\0178K]\018^W\018t$]KD8K\0189A9R\0182DK1\n\018\029$(]\a\017W\127K2\018D\0052\018\030DK2$\0182$\a\n8(]\018\005^1\n\017\018^\005\0182$K\018t\195\188K\a\017$\0054KDf\017\018]$\a\0178\017\017$\017=")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
    zoneCourthouse.Active = false
    zoneBook.Active = true
    zoneBook.Visible = true
  else
    _Urwigo.OldDialog({
      {
        Text = ("" .. input) .. _QSt("^\a\017\018($^2$K\018f8(\a1\n\018\1272$K\018f8(\a1\n\0184$\a1\nK^$]$\005")
      }
    })
  end
end
cartTourdeGreensboro.MsgBoxCBFuncs = {}
function zoneCourthouse:OnProximity()
  input = Env.DeviceID
  if wwb_obfuscate(string.lower(Env.DeviceID), true) == "mo3w624" then
    Wherigo.MessageBox({
      Text = "This is as far as you will get by using the emulator. &nbsp;I hope you like what you saw."
    })
  else
    zoneCourthouse.Active = false
    Wherigo.GetInput(zinputCourthouseCheck)
  end
end
function zinputCourthouseCheck:OnGetInput(input)
  if Wherigo.NoCaseEquals(input, "vote") then
    Wherigo.MessageBox({
      Text = [[
Great! &nbsp;Now we leave our historical leg and come into the final challenge.<BR>
<BR>
Follow your bearing pointer due north to the picture. &nbsp;From then on, upon arriving at your destination, you will be shown a picture. &nbsp;Your task is to find your next location from this picture. It has changed since the picture was taken. Can you still find it?]],
      Media = zmediaNorthGreene
    })
    ztaskCourthouse.Complete = true
    ztaskNorthGreene.Active = true
    ztaskNorthGreene.Visible = true
    zoneNorthGreene.Active = true
    zoneNorthGreene.Visible = true
    zoneCourthouse.Visible = false
    zoneCourthouse.Active = false
  else
    Wherigo.MessageBox({
      Text = "Nope. &nbsp;Try again."
    })
    Wherigo.GetInput(zinputCourthouseCheck)
  end
end
function wwb_obfuscate(str, obf)
  local result = ""
  if obf == nil then
    obf = true
  end
  local rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~"
  local plen = string.len(rot_palette)
  local magic = {
    ["\001"] = "B",
    ["\002"] = "R",
    ["\003"] = ""
  }
  str = string.gsub(str, "&nbsp;", " ")
  for i = 1, string.len(str) do
    local c = string.sub(str, i, i)
    local p = string.find(rot_palette, c, 1, true)
    if p then
      local jump = (i - 1) % 8 + 9
      if obf then
        p = p + jump
        if plen < p then
          p = p - plen
        end
      else
        p = p - jump
        if p < 1 then
          p = p + plen
        end
      end
      c = string.sub(rot_palette, p, p)
    else
      x = magic[c]
      if x then
        c = x
      else
      end
    end
    result = result .. c
  end
  return result
end
return cartTourdeGreensboro
