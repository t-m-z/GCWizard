require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _MIPH3(str)
  local res = ""
  local dtable = "b\002j\014#DF=_\000h:N<\005MA\f$x\0066`}tRLzP@/fr,dlTuXYU^~\019k\026\024\004{'&E9I[wvei\0037y2qH\n. >1\023|\020\a%ns;Z\0213K0C\rW\030g8\tm4\v\025(\015\016\017V?-)\001*B\022]S+c\028\029Q\"\\!\031\bGp5oaO\027\018J"
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
cartMurderintheOutfield = Wherigo.ZCartridge()
zmediaMurderscene = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaMurderscene.Id = "dbb613cb-84cb-4b74-9ef2-c52c4640daf0"
zmediaMurderscene.Name = _MIPH3("\016&!#:!DMn:L:")
zmediaMurderscene.Description = ""
zmediaMurderscene.AltText = ""
zmediaMurderscene.Resources = {
  {
    Type = "jpg",
    Filename = "CrimeScenesm.jpg",
    Directives = {}
  }
}
zmediageocacher = Wherigo.ZMedia(cartMurderintheOutfield)
zmediageocacher.Id = "f8427453-4f33-4875-86c4-2f152a96d931"
zmediageocacher.Name = _MIPH3("X:zn{n\v:!")
zmediageocacher.Description = ""
zmediageocacher.AltText = ""
zmediageocacher.Resources = {
  {
    Type = "jpg",
    Filename = "geocachersm.jpg",
    Directives = {}
  }
}
zmediapolicecar = Wherigo.ZMedia(cartMurderintheOutfield)
zmediapolicecar.Id = "ac69269d-b503-47e2-8f30-134093e718f1"
zmediapolicecar.Name = _MIPH3("xz$;n:Dn{!")
zmediapolicecar.Description = ""
zmediapolicecar.AltText = ""
zmediapolicecar.Resources = {
  {
    Type = "jpg",
    Filename = "Policecarsm.jpg",
    Directives = {}
  }
}
zmediadogwalker = Wherigo.ZMedia(cartMurderintheOutfield)
zmediadogwalker.Id = "3110b513-fb4c-45b6-8b02-cc466c17d171"
zmediadogwalker.Name = _MIPH3("#zXD8{$-:!")
zmediadogwalker.Description = ""
zmediadogwalker.AltText = ""
zmediadogwalker.Resources = {
  {
    Type = "png",
    Filename = "fraumithund.png",
    Directives = {}
  }
}
zmediaBaseballPlayer = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaBaseballPlayer.Id = "1996374f-76a3-49f3-a894-6b2eb8f4c143"
zmediaBaseballPlayer.Name = _MIPH3("\029{##$:!")
zmediaBaseballPlayer.Description = ""
zmediaBaseballPlayer.AltText = ""
zmediaBaseballPlayer.Resources = {
  {
    Type = "png",
    Filename = "paddler.png",
    Directives = {}
  }
}
zmediaGardener = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaGardener.Id = "d98c7f16-b345-480b-862c-66fd8bc6a643"
zmediaGardener.Name = _MIPH3("\017LX:M\025:$$\025:!")
zmediaGardener.Description = ""
zmediaGardener.AltText = ""
zmediaGardener.Resources = {
  {
    Type = "jpg",
    Filename = "Gardenersm.jpg",
    Directives = {}
  }
}
zmediaBat = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaBat.Id = "2633d91e-5e41-4179-9675-33dbd65e9888"
zmediaBat.Name = _MIPH3("\029{##:$")
zmediaBat.Description = ""
zmediaBat.AltText = ""
zmediaBat.Resources = {
  {
    Type = "jpg",
    Filename = "paddel1.jpg",
    Directives = {}
  }
}
zmediaGun = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaGun.Id = "17923787-ffde-41fb-ad2f-893917b24a64"
zmediaGun.Name = _MIPH3("w&L")
zmediaGun.Description = ""
zmediaGun.AltText = ""
zmediaGun.Resources = {
  {
    Type = "jpg",
    Filename = "gunsm.jpg",
    Directives = {}
  }
}
zmediaAmmoCan = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaAmmoCan.Id = "21483e1f-cac4-4ac1-8b70-db1860849d4f"
zmediaAmmoCan.Name = _MIPH3("\017$&D\026z\v!")
zmediaAmmoCan.Description = ""
zmediaAmmoCan.AltText = ""
zmediaAmmoCan.Resources = {
  {
    Type = "png",
    Filename = "Alurohr.png",
    Directives = {}
  }
}
zmediaWrench = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaWrench.Id = "398740aa-4356-4878-bace-aacdc1296fc1"
zmediaWrench.Name = _MIPH3("V!:Ln\v")
zmediaWrench.Description = ""
zmediaWrench.AltText = ""
zmediaWrench.Resources = {
  {
    Type = "jpg",
    Filename = "BloodyHammersm.jpg",
    Directives = {}
  }
}
zmediaPolicebadge = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaPolicebadge.Id = "a9e5e300-ea83-4bf5-9aee-97a2b585de7b"
zmediaPolicebadge.Name = _MIPH3("\029z$;n:D\001{#X:")
zmediaPolicebadge.Description = ""
zmediaPolicebadge.AltText = ""
zmediaPolicebadge.Resources = {
  {
    Type = "png",
    Filename = "Notrufmirow1.png",
    Directives = {}
  }
}
zmediabody = Wherigo.ZMedia(cartMurderintheOutfield)
zmediabody.Id = "17de130f-b53c-43f6-8f16-5118ab4983c9"
zmediabody.Name = _MIPH3("\001z#>")
zmediabody.Description = ""
zmediabody.AltText = ""
zmediabody.Resources = {
  {
    Type = "jpg",
    Filename = "DeadBodysm.jpg",
    Directives = {}
  }
}
zmediaMotherDaughter = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaMotherDaughter.Id = "68fdb1e5-3024-49b6-9964-52420c6b5658"
zmediaMotherDaughter.Name = _MIPH3("\016z\025\v:!\006{&X\v\025:!")
zmediaMotherDaughter.Description = ""
zmediaMotherDaughter.AltText = ""
zmediaMotherDaughter.Resources = {
  {
    Type = "jpg",
    Filename = "MotherDaughterBigsm.jpg",
    Directives = {}
  }
}
zmediadma = Wherigo.ZMedia(cartMurderintheOutfield)
zmediadma.Id = "2cb415ce-8658-46bf-ac97-a16b64047a3c"
zmediadma.Name = _MIPH3("\006\r\017")
zmediadma.Description = ""
zmediadma.AltText = ""
zmediadma.Resources = {
  {
    Type = "jpg",
    Filename = "Dnasm.jpg",
    Directives = {}
  }
}
zmediafingerprint = Wherigo.ZMedia(cartMurderintheOutfield)
zmediafingerprint.Id = "42de72e7-ea16-46d3-bb33-9df6c191483b"
zmediafingerprint.Name = _MIPH3(" ;LX:!x!;L\025")
zmediafingerprint.Description = ""
zmediafingerprint.AltText = ""
zmediafingerprint.Resources = {
  {
    Type = "jpg",
    Filename = "Fingerprintsm.jpg",
    Directives = {}
  }
}
zmediaMagnifyer = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaMagnifyer.Id = "6ff55cca-847e-4bfb-af85-4573387e93bf"
zmediaMagnifyer.Name = _MIPH3("\027&x:")
zmediaMagnifyer.Description = ""
zmediaMagnifyer.AltText = ""
zmediaMagnifyer.Resources = {
  {
    Type = "jpg",
    Filename = "MagnifyingGlasssm.jpg",
    Directives = {}
  }
}
zmediaBaseballField = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaBaseballField.Id = "8dceadc1-7acf-48cb-a33c-ed4b5e16c24b"
zmediaBaseballField.Name = _MIPH3("izz\025MM\025:X")
zmediaBaseballField.Description = ""
zmediaBaseballField.AltText = ""
zmediaBaseballField.Resources = {
  {
    Type = "png",
    Filename = "Bootssteg.png",
    Directives = {}
  }
}
zmediaGirlCrying = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaGirlCrying.Id = "a79c595d-fb41-4e44-b410-4cc43d42c323"
zmediaGirlCrying.Name = _MIPH3("w;!$DT!>;LX")
zmediaGirlCrying.Description = _MIPH3("w;!$DT!>;LX")
zmediaGirlCrying.AltText = ""
zmediaGirlCrying.Resources = {
  {
    Type = "jpg",
    Filename = "GirlCryingsm.jpg",
    Directives = {}
  }
}
zmediaDogWalkertalkingbody = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaDogWalkertalkingbody.Id = "9f843519-a886-4cce-af89-181e347c0fdc"
zmediaDogWalkertalkingbody.Name = _MIPH3("\006zXDV{$-:!D\025{$-;LXD\001z#>")
zmediaDogWalkertalkingbody.Description = ""
zmediaDogWalkertalkingbody.AltText = ""
zmediaDogWalkertalkingbody.Resources = {
  {
    Type = "jpg",
    Filename = "DogWalkerTalkingsm.jpg",
    Directives = {}
  }
}
zmediaDogWalkerTalkingFinal = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaDogWalkerTalkingFinal.Id = "eb41a1f7-47f5-47b9-8a4c-2cf4a6654089"
zmediaDogWalkerTalkingFinal.Name = _MIPH3("\006zXDV{$-:!D%{$-;LXD\a;L{$")
zmediaDogWalkerTalkingFinal.Description = ""
zmediaDogWalkerTalkingFinal.AltText = ""
zmediaDogWalkerTalkingFinal.Resources = {
  {
    Type = "jpg",
    Filename = "DogWalkerFinalsm.jpg",
    Directives = {}
  }
}
zmediaGeocacherfromplayground = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaGeocacherfromplayground.Id = "05544ccb-2a29-46ae-908b-543434b03689"
zmediaGeocacherfromplayground.Name = _MIPH3("w:zn{n\v:!D !z[Dx${>X!z&L#")
zmediaGeocacherfromplayground.Description = ""
zmediaGeocacherfromplayground.AltText = ""
zmediaGeocacherfromplayground.Resources = {
  {
    Type = "png",
    Filename = "geocacher.png",
    Directives = {}
  }
}
zmediaBluntForceHead = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaBluntForceHead.Id = "24557885-2ef3-4306-8b51-1b19f3ca1839"
zmediaBluntForceHead.Name = _MIPH3("i$&L\025D\az!n:DA:{#")
zmediaBluntForceHead.Description = ""
zmediaBluntForceHead.AltText = ""
zmediaBluntForceHead.Resources = {
  {
    Type = "jpg",
    Filename = "BluntForcesm.jpg",
    Directives = {}
  }
}
zmediaLogSheet = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaLogSheet.Id = "6939ecb8-18e1-4640-8b06-f2ccb68951d8"
zmediaLogSheet.Name = _MIPH3("\027zXDl\v::\025")
zmediaLogSheet.Description = ""
zmediaLogSheet.AltText = ""
zmediaLogSheet.Resources = {
  {
    Type = "jpg",
    Filename = "LogSheetsm.jpg",
    Directives = {}
  }
}
zmediaSpoiler = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaSpoiler.Id = "57836f23-ff81-4c79-a46a-2578dcec45bf"
zmediaSpoiler.Name = _MIPH3("lxz;$:!")
zmediaSpoiler.Description = ""
zmediaSpoiler.AltText = ""
zmediaSpoiler.Resources = {
  {
    Type = "png",
    Filename = "Falsch_Symbol.png",
    Directives = {}
  }
}
zmediaPlayground = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaPlayground.Id = "a9b4141a-1520-4637-a482-0482f3753588"
zmediaPlayground.Name = _MIPH3("\029${>X!z&L#")
zmediaPlayground.Description = ""
zmediaPlayground.AltText = ""
zmediaPlayground.Resources = {
  {
    Type = "png",
    Filename = "Spielplatz.png",
    Directives = {}
  }
}
zmediaStairs = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaStairs.Id = "a22e0d5e-a37c-461f-8f7c-8663100a31aa"
zmediaStairs.Name = _MIPH3("l\025{;!M")
zmediaStairs.Description = ""
zmediaStairs.AltText = ""
zmediaStairs.Resources = {
  {
    Type = "png",
    Filename = "Strand.png",
    Directives = {}
  }
}
zmediaNotepad = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaNotepad.Id = "983fde5b-1b6a-4774-afde-eeb62605e06e"
zmediaNotepad.Name = _MIPH3("\rz\025:x{#")
zmediaNotepad.Description = ""
zmediaNotepad.AltText = ""
zmediaNotepad.Resources = {
  {
    Type = "png",
    Filename = "Notepadsm.png",
    Directives = {}
  }
}
zmediaBodysfinger = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaBodysfinger.Id = "afce5391-0a55-447c-8f45-6858cead7f15"
zmediaBodysfinger.Name = _MIPH3("iz#>2MD ;LX:!")
zmediaBodysfinger.Description = ""
zmediaBodysfinger.AltText = ""
zmediaBodysfinger.Resources = {
  {
    Type = "jpg",
    Filename = "bodyfingersm.jpg",
    Directives = {}
  }
}
zmediaGardenerTalking = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaGardenerTalking.Id = "fd18a1d6-2e52-4853-a1d4-c773b9011894"
zmediaGardenerTalking.Name = _MIPH3("\017LX:M\025:$$\025:!D%{$-;LX")
zmediaGardenerTalking.Description = ""
zmediaGardenerTalking.AltText = ""
zmediaGardenerTalking.Resources = {
  {
    Type = "jpg",
    Filename = "gardenertalkingsm.jpg",
    Directives = {}
  }
}
zmediagpsaddedsm = Wherigo.ZMedia(cartMurderintheOutfield)
zmediagpsaddedsm.Id = "115dd8e2-fc23-4f77-b0a1-d34c5a0d60af"
zmediagpsaddedsm.Name = _MIPH3("XxMD{##:#DM[")
zmediagpsaddedsm.Description = ""
zmediagpsaddedsm.AltText = ""
zmediagpsaddedsm.Resources = {
  {
    Type = "jpg",
    Filename = "gpsaddedsm.jpg",
    Directives = {}
  }
}
zmediahandcuffs = Wherigo.ZMedia(cartMurderintheOutfield)
zmediahandcuffs.Id = "4b6f2c98-ea0f-4f09-832e-5b8858d199f4"
zmediahandcuffs.Name = _MIPH3("\v{L#n&  M")
zmediahandcuffs.Description = ""
zmediahandcuffs.AltText = ""
zmediahandcuffs.Resources = {
  {
    Type = "jpg",
    Filename = "handcuffssm.jpg",
    Directives = {}
  }
}
zmediaDWTalking2 = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaDWTalking2.Id = "bd0d9e85-b190-4a99-ba29-55e84beaf989"
zmediaDWTalking2.Name = _MIPH3("\006V%{$-;LXD?")
zmediaDWTalking2.Description = ""
zmediaDWTalking2.AltText = ""
zmediaDWTalking2.Resources = {
  {
    Type = "jpg",
    Filename = "DogWalkerTalking2sm.jpg",
    Directives = {}
  }
}
zmediaCleanHammer = Wherigo.ZMedia(cartMurderintheOutfield)
zmediaCleanHammer.Id = "af874d9f-4b30-4e9b-8a0b-6e3293b5ea65"
zmediaCleanHammer.Name = _MIPH3("T$:{LDA{[[:!")
zmediaCleanHammer.Description = ""
zmediaCleanHammer.AltText = ""
zmediaCleanHammer.Resources = {
  {
    Type = "jpg",
    Filename = "BloodyHammerCleansm.jpg",
    Directives = {}
  }
}
cartMurderintheOutfield.Id = "19f6b154-bae6-454f-976b-f7894f0ee354"
cartMurderintheOutfield.Name = "Notruf Mirow"
cartMurderintheOutfield.Description = "<BR>\n<BR>\nFinden Sie heraus, wer der T\195\164ter ist und welche Waffe er verwendet hat."
cartMurderintheOutfield.Visible = true
cartMurderintheOutfield.Activity = "Geocache"
cartMurderintheOutfield.StartingLocationDescription = [[
<BR>
<BR>
Beginnen Sie auf dem Parkplatz, auf dem Sie angekommen sind.]]
cartMurderintheOutfield.StartingLocation = ZonePoint(53.289217, 12.793833, 0)
cartMurderintheOutfield.Version = "1.2"
cartMurderintheOutfield.Company = ""
cartMurderintheOutfield.Author = ""
cartMurderintheOutfield.BuilderVersion = "URWIGO 1.22.5798.37755"
cartMurderintheOutfield.CreateDate = "02/25/2008 19:10:34"
cartMurderintheOutfield.PublishDate = "1/1/0001 12:00:00 AM"
cartMurderintheOutfield.UpdateDate = "03/14/2020 18:11:02"
cartMurderintheOutfield.LastPlayedDate = "1/1/0001 12:00:00 AM"
cartMurderintheOutfield.TargetDevice = "PocketPC"
cartMurderintheOutfield.TargetDeviceVersion = "0"
cartMurderintheOutfield.StateId = "1"
cartMurderintheOutfield.CountryId = "2"
cartMurderintheOutfield.Complete = false
cartMurderintheOutfield.UseLogging = true
cartMurderintheOutfield.Media = zmediaPolicebadge
zoneCrimeScene = Wherigo.Zone(cartMurderintheOutfield)
zoneCrimeScene.Id = "fbc35399-f0af-4d0f-8690-2dcf15cc5d42"
zoneCrimeScene.Name = _MIPH3("%{\025z!\025")
zoneCrimeScene.Description = ""
zoneCrimeScene.Visible = true
zoneCrimeScene.Media = zmediaMurderscene
zoneCrimeScene.Commands = {}
zoneCrimeScene.DistanceRange = Distance(1500, "feet")
zoneCrimeScene.ShowObjects = "OnEnter"
zoneCrimeScene.ProximityRange = Distance(200, "feet")
zoneCrimeScene.AllowSetPositionTo = false
zoneCrimeScene.Active = true
zoneCrimeScene.Points = {
  ZonePoint(53.2867327045379, 12.7962253871793, 0),
  ZonePoint(53.286838609386, 12.7964033897104, 0),
  ZonePoint(53.2868982411711, 12.7962908246694, 0),
  ZonePoint(53.2868032898191, 12.7961268421813, 0)
}
zoneCrimeScene.OriginalPoint = ZonePoint(33.66005, -117.6899, 0)
zoneCrimeScene.DistanceRangeUOM = "Feet"
zoneCrimeScene.ProximityRangeUOM = "Feet"
zoneCrimeScene.OutOfRangeName = ""
zoneCrimeScene.InRangeName = ""
zoneBaseballField = Wherigo.Zone(cartMurderintheOutfield)
zoneBaseballField.Id = "ca6c22c1-1ffc-4d42-a72f-6ae5695258f8"
zoneBaseballField.Name = _MIPH3("izz\025MM\025:X")
zoneBaseballField.Description = ""
zoneBaseballField.Visible = true
zoneBaseballField.Media = zmediaBaseballField
zoneBaseballField.Commands = {}
zoneBaseballField.DistanceRange = Distance(1500, "feet")
zoneBaseballField.ShowObjects = "OnEnter"
zoneBaseballField.ProximityRange = Distance(200, "feet")
zoneBaseballField.AllowSetPositionTo = false
zoneBaseballField.Active = false
zoneBaseballField.Points = {
  ZonePoint(53.2883302214986, 12.7968304282803, 0),
  ZonePoint(53.2883717947735, 12.7970095450367, 0),
  ZonePoint(53.28827535288, 12.797112298562, 0),
  ZonePoint(53.2882252753296, 12.796928303916, 0)
}
zoneBaseballField.OriginalPoint = ZonePoint(33.6595, -117.688867, 0)
zoneBaseballField.DistanceRangeUOM = "Feet"
zoneBaseballField.ProximityRangeUOM = "Feet"
zoneBaseballField.OutOfRangeName = ""
zoneBaseballField.InRangeName = ""
zoneLandscaper = Wherigo.Zone(cartMurderintheOutfield)
zoneLandscaper.Id = "aeec3097-f908-4ff6-ad51-30c37e6887d2"
zoneLandscaper.Name = _MIPH3("l\025!{L#")
zoneLandscaper.Description = ""
zoneLandscaper.Visible = true
zoneLandscaper.Media = zmediaStairs
zoneLandscaper.Commands = {}
zoneLandscaper.DistanceRange = Distance(1500, "feet")
zoneLandscaper.ShowObjects = "OnEnter"
zoneLandscaper.ProximityRange = Distance(200, "feet")
zoneLandscaper.AllowSetPositionTo = false
zoneLandscaper.Active = false
zoneLandscaper.Points = {
  ZonePoint(53.2887093308028, 12.7964196438524, 0),
  ZonePoint(53.2887502176161, 12.7963181119562, 0),
  ZonePoint(53.2887964382358, 12.7963656935947, 0),
  ZonePoint(53.2887635504923, 12.7964712653551, 0)
}
zoneLandscaper.OriginalPoint = ZonePoint(33.658783, -117.68915, 0)
zoneLandscaper.DistanceRangeUOM = "Feet"
zoneLandscaper.ProximityRangeUOM = "Feet"
zoneLandscaper.OutOfRangeName = ""
zoneLandscaper.InRangeName = ""
zoneParkingLot = Wherigo.Zone(cartMurderintheOutfield)
zoneParkingLot.Id = "d5ae11b8-50ea-488e-ae91-ac04813cb92a"
zoneParkingLot.Name = _MIPH3("\029{!-x${\025\028")
zoneParkingLot.Description = ""
zoneParkingLot.Visible = true
zoneParkingLot.Media = zmediapolicecar
zoneParkingLot.Commands = {}
zoneParkingLot.DistanceRange = Distance(1500, "feet")
zoneParkingLot.ShowObjects = "OnEnter"
zoneParkingLot.ProximityRange = Distance(200, "feet")
zoneParkingLot.AllowSetPositionTo = false
zoneParkingLot.Active = false
zoneParkingLot.Points = {
  ZonePoint(53.2888845664262, 12.7943141413942, 0),
  ZonePoint(53.288926412409, 12.794499703788, 0),
  ZonePoint(53.28880672643, 12.7945889421397, 0),
  ZonePoint(53.2887594752587, 12.7943931995401, 0)
}
zoneParkingLot.OriginalPoint = ZonePoint(33.6586, -117.689633, 0)
zoneParkingLot.DistanceRangeUOM = "Feet"
zoneParkingLot.ProximityRangeUOM = "Feet"
zoneParkingLot.OutOfRangeName = ""
zoneParkingLot.InRangeName = ""
zoneGeocacher = Wherigo.Zone(cartMurderintheOutfield)
zoneGeocacher.Id = "ef855346-7063-4c13-8f6b-10b8e7b1847a"
zoneGeocacher.Name = _MIPH3("w:zn{n\v:!")
zoneGeocacher.Description = ""
zoneGeocacher.Visible = true
zoneGeocacher.Media = zmediaGeocacherfromplayground
zoneGeocacher.Commands = {}
zoneGeocacher.DistanceRange = Distance(1500, "feet")
zoneGeocacher.ShowObjects = "OnEnter"
zoneGeocacher.ProximityRange = Distance(200, "feet")
zoneGeocacher.AllowSetPositionTo = false
zoneGeocacher.Active = false
zoneGeocacher.Points = {
  ZonePoint(53.289284665064, 12.7959402091402, 0),
  ZonePoint(53.2892079773184, 12.7959790927821, 0),
  ZonePoint(53.2892301985384, 12.7960950730259, 0),
  ZonePoint(53.2893021952117, 12.7960578998708, 0)
}
zoneGeocacher.OriginalPoint = ZonePoint(33.659567, -117.688183, 0)
zoneGeocacher.DistanceRangeUOM = "Feet"
zoneGeocacher.ProximityRangeUOM = "Feet"
zoneGeocacher.OutOfRangeName = ""
zoneGeocacher.InRangeName = ""
zonePlayground = Wherigo.Zone(cartMurderintheOutfield)
zonePlayground.Id = "fa935f76-1852-4fce-aa17-8ada2add1a75"
zonePlayground.Name = _MIPH3("lx;:$x${\025\028")
zonePlayground.Description = ""
zonePlayground.Visible = true
zonePlayground.Media = zmediaPlayground
zonePlayground.Commands = {}
zonePlayground.DistanceRange = Distance(1500, "feet")
zonePlayground.ShowObjects = "OnEnter"
zonePlayground.ProximityRange = Distance(200, "feet")
zonePlayground.AllowSetPositionTo = false
zonePlayground.Active = false
zonePlayground.Points = {
  ZonePoint(53.2890511070495, 12.7959568170074, 0),
  ZonePoint(53.2890559838641, 12.7958452694238, 0),
  ZonePoint(53.2889848756296, 12.7958289132355, 0),
  ZonePoint(53.2889742093842, 12.7959404327008, 0)
}
zonePlayground.OriginalPoint = ZonePoint(33.65935, -117.688433, 0)
zonePlayground.DistanceRangeUOM = "Feet"
zonePlayground.ProximityRangeUOM = "Feet"
zonePlayground.OutOfRangeName = ""
zonePlayground.InRangeName = ""
zcharacterBaseBallPlayer = Wherigo.ZCharacter({Cartridge = cartMurderintheOutfield, Container = zoneBaseballField})
zcharacterBaseBallPlayer.Id = "b45b7ade-c82a-4eee-9d3e-58b0769cdf24"
zcharacterBaseBallPlayer.Name = _MIPH3("\029{##$:!")
zcharacterBaseBallPlayer.Description = ""
zcharacterBaseBallPlayer.Visible = false
zcharacterBaseBallPlayer.Media = zmediaBaseballPlayer
zcharacterBaseBallPlayer.Commands = {
  Talk = Wherigo.ZCommand({
    Text = _MIPH3("{LMx!:n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzDiiDx${>:!D\v:!:")
  }),
  Observe = Wherigo.ZCommand({
    Text = _MIPH3("{LM:\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD|\001M:!9:")
  })
}
zcharacterBaseBallPlayer.Commands.Talk.Custom = true
zcharacterBaseBallPlayer.Commands.Talk.Id = "906a5899-58fd-4959-8991-d12ec60c32f6"
zcharacterBaseBallPlayer.Commands.Talk.WorksWithAll = true
zcharacterBaseBallPlayer.Commands.Observe.Custom = true
zcharacterBaseBallPlayer.Commands.Observe.Id = "bd251dfc-1fbb-40bb-851b-ed2751991230"
zcharacterBaseBallPlayer.Commands.Observe.WorksWithAll = true
zcharacterBaseBallPlayer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterBaseBallPlayer.Gender = "Male"
zcharacterBaseBallPlayer.Type = "NPC"
zcharacterMotherandChild = Wherigo.ZCharacter({Cartridge = cartMurderintheOutfield, Container = zonePlayground})
zcharacterMotherandChild.Id = "dee097a2-4de7-41b1-b377-97ff4c295d41"
zcharacterMotherandChild.Name = _MIPH3("\016&\025\025:!D[;\025DR;L#")
zcharacterMotherandChild.Description = ""
zcharacterMotherandChild.Visible = false
zcharacterMotherandChild.Media = zmediaMotherDaughter
zcharacterMotherandChild.Commands = {
  Question = Wherigo.ZCommand({
    Text = _MIPH3(" !{X:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD\016z\025\v:!D\v:!:")
  })
}
zcharacterMotherandChild.Commands.Question.Custom = true
zcharacterMotherandChild.Commands.Question.Id = "24018673-af9c-4ce3-8c9f-0138d3d82dbe"
zcharacterMotherandChild.Commands.Question.WorksWithAll = true
zcharacterMotherandChild.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterMotherandChild.Gender = "Female"
zcharacterMotherandChild.Type = "NPC"
zcharacterGardener = Wherigo.ZCharacter({Cartridge = cartMurderintheOutfield, Container = zoneLandscaper})
zcharacterGardener.Id = "98f6e9ae-115f-4f77-ba46-f311d48938b7"
zcharacterGardener.Name = _MIPH3("\017LX:M\025:$$\025:!DR{L&M\025{\025;zL")
zcharacterGardener.Description = ""
zcharacterGardener.Visible = false
zcharacterGardener.Media = zmediaGardener
zcharacterGardener.Commands = {
  Interrogate = Wherigo.ZCommand({
    Text = _MIPH3("\001: !{X:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD\027{L#Mn{x:!")
  })
}
zcharacterGardener.Commands.Interrogate.Custom = true
zcharacterGardener.Commands.Interrogate.Id = "50b62bc9-7ad8-4fb1-a265-fd9fea20bc83"
zcharacterGardener.Commands.Interrogate.WorksWithAll = true
zcharacterGardener.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterGardener.Gender = "Male"
zcharacterGardener.Type = "NPC"
zcharacterGeocacher = Wherigo.ZCharacter({Cartridge = cartMurderintheOutfield, Container = zoneGeocacher})
zcharacterGeocacher.Id = "9b376731-9b44-4601-9a72-ddbd7421dce0"
zcharacterGeocacher.Name = _MIPH3("w:zn{n\v:!")
zcharacterGeocacher.Description = ""
zcharacterGeocacher.Visible = false
zcharacterGeocacher.Media = zmediageocacher
zcharacterGeocacher.Commands = {
  Talk = Wherigo.ZCommand({
    Text = _MIPH3("{LMx!:n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rz\025\v;LXD{9{;${\001$:")
  }),
  Observe = Wherigo.ZCommand({
    Text = _MIPH3("\001:z\001{n\v\025:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rz\025\v;LXD{9{;${\001$:")
  })
}
zcharacterGeocacher.Commands.Talk.Custom = true
zcharacterGeocacher.Commands.Talk.Id = "fefaad76-cfd2-4d68-82ea-c181f36da746"
zcharacterGeocacher.Commands.Talk.WorksWithAll = true
zcharacterGeocacher.Commands.Observe.Custom = true
zcharacterGeocacher.Commands.Observe.Id = "b00acc7d-bd0f-4db5-9c5b-22b6f265f91a"
zcharacterGeocacher.Commands.Observe.WorksWithAll = true
zcharacterGeocacher.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterGeocacher.Gender = "Male"
zcharacterGeocacher.Type = "NPC"
zcharacterDogWalker = Wherigo.ZCharacter({Cartridge = cartMurderintheOutfield, Container = zoneCrimeScene})
zcharacterDogWalker.Id = "cba0bbc6-59d4-443a-a10e-e514e4eadc5a"
zcharacterDogWalker.Name = _MIPH3("\a!{&D[;\025DA&L#")
zcharacterDogWalker.Description = ""
zcharacterDogWalker.Visible = false
zcharacterDogWalker.Media = zmediadogwalker
zcharacterDogWalker.Commands = {
  Talk = Wherigo.ZCommand({
    Text = _MIPH3("{LMx!:n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD%{$-")
  })
}
zcharacterDogWalker.Commands.Talk.Custom = true
zcharacterDogWalker.Commands.Talk.Id = "df60e18e-8572-45e4-8a0a-2c9bac868be0"
zcharacterDogWalker.Commands.Talk.WorksWithAll = true
zcharacterDogWalker.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterDogWalker.Gender = "Female"
zcharacterDogWalker.Type = "NPC"
zitemBat = Wherigo.ZItem(cartMurderintheOutfield)
zitemBat.Id = "7af79593-9ebe-49a0-b623-e26155a996f6"
zitemBat.Name = _MIPH3("\029{##:$")
zitemBat.Description = ""
zitemBat.Visible = false
zitemBat.Media = zmediaBat
zitemBat.Commands = {
  Examine = Wherigo.ZCommand({
    Text = _MIPH3("&L\025:!M&n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("T{L2\025D:\020{[;L:")
  })
}
zitemBat.Commands.Examine.Custom = true
zitemBat.Commands.Examine.Id = "0bf50041-5462-4b5d-b88d-3552ccd50ec3"
zitemBat.Commands.Examine.WorksWithAll = true
zitemBat.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBat.Locked = false
zitemBat.Opened = false
zitemHammer = Wherigo.ZItem(cartMurderintheOutfield)
zitemHammer.Id = "11e45a53-842b-461e-a73e-545fec919877"
zitemHammer.Name = _MIPH3("A{[[:!")
zitemHammer.Description = ""
zitemHammer.Visible = true
zitemHammer.Media = zmediaWrench
zitemHammer.Commands = {
  Examine = Wherigo.ZCommand({
    Text = _MIPH3("&L\025:!M&n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzDV!:Ln\v")
  })
}
zitemHammer.Commands.Examine.Custom = true
zitemHammer.Commands.Examine.Id = "cf8d67ff-2940-4eca-b19d-b413b5b9dd2c"
zitemHammer.Commands.Examine.WorksWithAll = true
zitemHammer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemHammer.Locked = false
zitemHammer.Opened = false
zitemGun = Wherigo.ZItem(cartMurderintheOutfield)
zitemGun.Id = "3931d30a-7c0a-404f-824f-6a4b6a7cc47d"
zitemGun.Name = _MIPH3("V{  :")
zitemGun.Description = ""
zitemGun.Visible = true
zitemGun.Media = zmediaGun
zitemGun.Commands = {}
zitemGun.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemGun.Locked = false
zitemGun.Opened = false
zitemAmmoCan = Wherigo.ZItem(cartMurderintheOutfield)
zitemAmmoCan.Id = "88439ac7-8a6f-4cc5-a897-cf27ce7ac3c6"
zitemAmmoCan.Name = _MIPH3("\017$&!z\v!")
zitemAmmoCan.Description = ""
zitemAmmoCan.Visible = true
zitemAmmoCan.Media = zmediaAmmoCan
zitemAmmoCan.Commands = {
  Open = Wherigo.ZCommand({
    Text = _MIPH3("z:  L:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rz\025\v;LXD{9{;${\001$:")
  }),
  Examine = Wherigo.ZCommand({
    Text = _MIPH3("&L\025:!M&n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rz\025\v;LXD\025zD:\020{[;L:")
  })
}
zitemAmmoCan.Commands.Open.Custom = true
zitemAmmoCan.Commands.Open.Id = "6b5da885-a228-45c2-be24-a2164aa03249"
zitemAmmoCan.Commands.Open.WorksWithAll = true
zitemAmmoCan.Commands.Examine.Custom = true
zitemAmmoCan.Commands.Examine.Id = "3b2d9c1c-f15c-4850-82f5-d28f063067b1"
zitemAmmoCan.Commands.Examine.WorksWithAll = true
zitemAmmoCan.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemAmmoCan.Locked = false
zitemAmmoCan.Opened = false
zitemBody = Wherigo.ZItem({Cartridge = cartMurderintheOutfield, Container = zoneCrimeScene})
zitemBody.Id = "ba47718c-5602-4703-9b9c-95a72f305421"
zitemBody.Name = _MIPH3("\027:;n\v:")
zitemBody.Description = ""
zitemBody.Visible = true
zitemBody.Media = zmediabody
zitemBody.Commands = {
  ExamineBody = Wherigo.ZCommand({
    Text = _MIPH3("\027:;n\v:D&L\025:!M&n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("%\v:D\001z#>D;ML2\025D\v:!:")
  })
}
zitemBody.Commands.ExamineBody.Custom = true
zitemBody.Commands.ExamineBody.Id = "e4a9de66-a8ec-47ba-9d12-25d7a0000ca7"
zitemBody.Commands.ExamineBody.WorksWithAll = true
zitemBody.ObjectLocation = ZonePoint(33.66009, -117.68977, 0)
zitemBody.Locked = true
zitemBody.Opened = false
zitemPolicecar = Wherigo.ZItem({Cartridge = cartMurderintheOutfield, Container = zoneParkingLot})
zitemPolicecar.Id = "f2890cc4-a817-446c-8a08-7571008cd882"
zitemPolicecar.Name = _MIPH3("\029z$;\028:;{&\025z")
zitemPolicecar.Description = ""
zitemPolicecar.Visible = true
zitemPolicecar.Media = zmediapolicecar
zitemPolicecar.Commands = {
  OpenDoortothePoliceCar = Wherigo.ZCommand({
    Text = _MIPH3("|:  L:D#;:D%&:!"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzDn{!D\v:!:")
  })
}
zitemPolicecar.Commands.OpenDoortothePoliceCar.Custom = true
zitemPolicecar.Commands.OpenDoortothePoliceCar.Id = "1695f86e-09bb-4dca-a9c9-d43c142b1df4"
zitemPolicecar.Commands.OpenDoortothePoliceCar.WorksWithAll = true
zitemPolicecar.ObjectLocation = ZonePoint(33.6586, -117.68963, 0)
zitemPolicecar.Locked = false
zitemPolicecar.Opened = false
zitemFingerprint = Wherigo.ZItem(cartMurderintheOutfield)
zitemFingerprint.Id = "710f99c3-8d38-474c-9c3c-0b14ecd39c14"
zitemFingerprint.Name = _MIPH3("\a;LX:!{\001#!&n-")
zitemFingerprint.Description = ""
zitemFingerprint.Visible = true
zitemFingerprint.Media = zmediafingerprint
zitemFingerprint.Commands = {
  Examine = Wherigo.ZCommand({
    Text = _MIPH3("&L\025:!M&n\v:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzDx!;L\025")
  })
}
zitemFingerprint.Commands.Examine.Custom = true
zitemFingerprint.Commands.Examine.Id = "90e22bb1-9658-4e6d-beb8-013ba97380a8"
zitemFingerprint.Commands.Examine.WorksWithAll = true
zitemFingerprint.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemFingerprint.Locked = false
zitemFingerprint.Opened = false
zitemDNA = Wherigo.ZItem(cartMurderintheOutfield)
zitemDNA.Id = "62407673-18e0-44d7-8cab-5522f770d361"
zitemDNA.Name = _MIPH3("\006\r\017")
zitemDNA.Description = ""
zitemDNA.Visible = true
zitemDNA.Media = zmediadma
zitemDNA.Commands = {
  Analyze = Wherigo.ZCommand({
    Text = _MIPH3("{L{$>M;:!:L"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD\006\r\017")
  })
}
zitemDNA.Commands.Analyze.Custom = true
zitemDNA.Commands.Analyze.Id = "f0bdaefa-1bb6-40dd-a71b-369f3feab182"
zitemDNA.Commands.Analyze.WorksWithAll = true
zitemDNA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDNA.Locked = false
zitemDNA.Opened = false
zitemNotepad = Wherigo.ZItem(cartMurderintheOutfield)
zitemNotepad.Id = "46741dc3-5e93-4152-965c-ba19ef4afd05"
zitemNotepad.Name = _MIPH3("\rz\025;\028\001$zn-")
zitemNotepad.Description = _MIPH3("\016:;LD\rz\025;\028\001$zn-C")
zitemNotepad.Visible = true
zitemNotepad.Media = zmediaNotepad
zitemNotepad.Commands = {
  NoteMurderWeapon = Wherigo.ZCommand({
    Text = _MIPH3("\rz\025;\028D\016z!#8{  :"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzDLz\025:\001zz-")
  }),
  NotePrimarySuspect = Wherigo.ZCommand({
    Text = _MIPH3("\rz\025;\028DA{&x\0259:!#\195\164n\v\025;X:!"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _MIPH3("\rzD\rz\025:\001zz-")
  })
}
zitemNotepad.Commands.NoteMurderWeapon.Custom = true
zitemNotepad.Commands.NoteMurderWeapon.Id = "ae19763b-3ae2-48db-b657-c25ccf5b2ae7"
zitemNotepad.Commands.NoteMurderWeapon.WorksWithAll = true
zitemNotepad.Commands.NotePrimarySuspect.Custom = true
zitemNotepad.Commands.NotePrimarySuspect.Id = "3a430f7b-e38e-4ab9-9e34-d41018573234"
zitemNotepad.Commands.NotePrimarySuspect.WorksWithAll = true
zitemNotepad.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemNotepad.Locked = false
zitemNotepad.Opened = false
zitemMagnifyingGlass = Wherigo.ZItem(cartMurderintheOutfield)
zitemMagnifyingGlass.Id = "d18e7026-7fc2-42f0-b2f8-bc95bc4f06f5"
zitemMagnifyingGlass.Name = _MIPH3("\027&x:")
zitemMagnifyingGlass.Description = ""
zitemMagnifyingGlass.Visible = true
zitemMagnifyingGlass.Media = zmediaMagnifyer
zitemMagnifyingGlass.Commands = {
  UseWith = Wherigo.ZCommand({
    Text = _MIPH3("\001:L&\025\028:L"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _MIPH3("6D#zL2\025DM::D{L>\025\v;LXD\025zD[{XL; >CCC&L$:MMD>z&D8{L\025D\025zD !>DMz[:D{L\025Md")
  })
}
zitemMagnifyingGlass.Commands.UseWith.Custom = true
zitemMagnifyingGlass.Commands.UseWith.Id = "9d4d63a7-00a8-4d93-9baf-d214ddb14bfc"
zitemMagnifyingGlass.Commands.UseWith.WorksWithAll = false
zitemMagnifyingGlass.Commands.UseWith.WorksWithListIds = {
  "7af79593-9ebe-49a0-b623-e26155a996f6",
  "3931d30a-7c0a-404f-824f-6a4b6a7cc47d"
}
zitemMagnifyingGlass.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemMagnifyingGlass.Locked = false
zitemMagnifyingGlass.Opened = false
ztaskFindtheculprit = Wherigo.ZTask(cartMurderintheOutfield)
ztaskFindtheculprit.Id = "0283ceda-eb21-42aa-abf7-dc9489d0b3b2"
ztaskFindtheculprit.Name = _MIPH3("\a;L#:D#:LD%\195\164\025:!")
ztaskFindtheculprit.Description = _MIPH3("6\v!:D$:\025\028\025:D\017& X{\001:D;M\025D:MD :M\025\028&M\025:$$:L\"D8:!D#:!D\016\195\182!#:!D;M\025CD\017n\v\025:LDl;:DX:L{&D{& D#;:DA;L8:;M:C")
ztaskFindtheculprit.Visible = true
ztaskFindtheculprit.Active = true
ztaskFindtheculprit.Complete = false
ztaskFindtheculprit.CorrectState = "None"
ztaskFindtheweapon = Wherigo.ZTask(cartMurderintheOutfield)
ztaskFindtheweapon.Id = "95e206ce-9de0-4012-af70-db51748c1c09"
ztaskFindtheweapon.Name = _MIPH3("\a;L#:D#;:DV{  :")
ztaskFindtheweapon.Description = _MIPH3("6\v!:D:!M\025:D\017& X{\001:D;M\025D:M\"D#;:D\016z!#8{  :D\028&D\001:M\025;[[:LCD\az$X:LDl;:D#:LDA;L8:;M:LtDl;:D8:!#:LDl;:D#z!\025\v;LD \195\188\v!:LC")
ztaskFindtheweapon.Visible = true
ztaskFindtheweapon.Active = true
ztaskFindtheweapon.Complete = false
ztaskFindtheweapon.CorrectState = "None"
_khvF = Wherigo.ZTask(cartMurderintheOutfield)
_khvF.Id = "7c84d14f-5157-4454-a967-1346ef6e6e12"
_khvF.Name = _MIPH3("\a6\r\017\027")
_khvF.Description = _MIPH3("\rDyQDF=D?5FDx$&MDizL&M\028{\v$D_\029:\025$;LXf\014i\026E4DF?D\\YDy\\YD[;L&MDizL&M\028{\v$D_\029:\025$;LXf\014i\026E\014i\026E-$:;L:Di{&[X!&xx:")
_khvF.Visible = true
_khvF.Active = false
_khvF.Complete = false
_khvF.CorrectState = "None"
BloodyWrench = true
AmmoDna = true
batexamined = true
y = ""
CacheFound = ""
talked2Dogwalker = true
DNAProcessing = true
bush = _MIPH3("X:zn{n\v:")
hammer = _MIPH3("{[[zDn{L")
x = ""
landscaper = _MIPH3("X:zn{n\v:!")
z = ""
dogwalker = _MIPH3("x{n\vz$;-")
AlreadyspoketoDW = true
Culprit = ""
Weaponvar = ""
_1kt = _MIPH3("\028zL:T!;[:ln:L:")
_Z507 = _MIPH3("\028n\v{!{n\025:!i{M:i{$$\029${>:!")
_vypx_ = _MIPH3("\028;\025:[i{\025")
_K8_W2 = _MIPH3("\028\025{M-\a;L#\025\v:n&$x!;\025")
_oUPPY = _MIPH3("\028;Lx&\025\az&L#T{n\v:")
_z2rtf = _MIPH3("#&[[>")
cartMurderintheOutfield.ZVariables = {
  BloodyWrench = true,
  AmmoDna = true,
  batexamined = true,
  y = "",
  CacheFound = "",
  talked2Dogwalker = true,
  DNAProcessing = true,
  bush = _MIPH3("X:zn{n\v:"),
  hammer = _MIPH3("{[[zDn{L"),
  x = "",
  landscaper = _MIPH3("X:zn{n\v:!"),
  z = "",
  dogwalker = _MIPH3("x{n\vz$;-"),
  AlreadyspoketoDW = true,
  Culprit = "",
  Weaponvar = "",
  _1kt = _MIPH3("\028zL:T!;[:ln:L:"),
  _Z507 = _MIPH3("\028n\v{!{n\025:!i{M:i{$$\029${>:!"),
  _vypx_ = _MIPH3("\028;\025:[i{\025"),
  _K8_W2 = _MIPH3("\028\025{M-\a;L#\025\v:n&$x!;\025"),
  _oUPPY = _MIPH3("\028;Lx&\025\az&L#T{n\v:"),
  _z2rtf = _MIPH3("#&[[>")
}
zinputFoundCache = Wherigo.ZInput(cartMurderintheOutfield)
zinputFoundCache.Id = "23f62cc9-e898-48f4-8f52-cffb09b7f8f5"
zinputFoundCache.Name = _MIPH3("\a;L#:Dw:zn{n\v:")
zinputFoundCache.Description = ""
zinputFoundCache.Visible = true
zinputFoundCache.InputType = "Text"
zinputFoundCache.Text = _MIPH3("V{MD\v{M\025D\006&DX: &L#:LdD_\017$$X:[:;L:Di:\028:;n\vL&LXDw\tD\tD\tD\tD\tD\tD\tDf")
zinputMurderer = Wherigo.ZInput(cartMurderintheOutfield)
zinputMurderer.Id = "5e67fca0-6880-4ff2-ad4c-d947b9fd337d"
zinputMurderer.Name = _MIPH3("\016z:!#:!")
zinputMurderer.Description = ""
zinputMurderer.Visible = true
zinputMurderer.InputType = "Text"
zinputMurderer.Text = _MIPH3("V:!D\v{\025D:MDX:\025{Ld")
zinputWeapon = Wherigo.ZInput(cartMurderintheOutfield)
zinputWeapon.Id = "115ad487-ee45-4401-9d3b-16091a753445"
zinputWeapon.Name = _MIPH3("V{  :")
zinputWeapon.Description = ""
zinputWeapon.Visible = true
zinputWeapon.InputType = "Text"
zinputWeapon.Text = _MIPH3("V{MD8{!D#;:D\016z!#8{  :d")
zitemMagnifyingGlass.Commands.UseWith.WorksWithList = {zitemBat, zitemGun}
function cartMurderintheOutfield:OnStart()
  if _G[_MIPH3("4L9")][_MIPH3("\006:9;n:6\006")] == _MIPH3("\006:M-\025zx") or _G[_MIPH3("4L9")][_MIPH3("\029${\025 z![")] == _MIPH3("V;LQ?") then
    for k, v in pairs(_G[_MIPH3("n{!\025\016&!#:!;L\025\v:|&\025 ;:$#")][_MIPH3("\017$$O|\001\003:n\025M")]) do
      v[_MIPH3("c;M;\001$:")] = false
      v[_MIPH3("\017n\025;9:")] = false
    end
    _G[_MIPH3("V\v:!;Xz")][_MIPH3("Tz[[{L#")](_MIPH3("l{9:T$zM:"))
    return
  end
  zitemMagnifyingGlass.Commands.UseWith.Enabled = false
  zitemMagnifyingGlass:MoveTo(zitemPolicecar)
  ztaskFindtheculprit.Visible = false
  AmmoDna = false
  zitemGun:MoveTo(zcharacterMotherandChild)
  DNAProcessing = false
  AlreadyspoketoDW = false
  BloodyWrench = true
  talked2Dogwalker = false
  batexamined = false
  _Urwigo.MessageBox({
    Text = _MIPH3("l;:DM;L#D#:!D$:;\025:L#:D4![;\025\025$:!CD6\v!:D\017& X{\001:D;M\025D:M\"D#;:D\016z!#8{  :D&L#D#{LLD#:LDA{&x\0259:!#\195\164n\v\025;X:LD\028&D\001:M\025;[[:LD&L#D:;L:Dc:!\v{ \025&LXD9z!\028&L:\v[:LC\014i\026EV:LLDl;:D\001:!:;\025DM;L#\"D {LX:LDl;:D[;\025D#:LD4![;\025\025$&LX:LD{L\014i\026E"),
    Media = zmediaPolicebadge
  })
end
function cartMurderintheOutfield:OnRestore()
end
function zoneCrimeScene:OnEnter()
  _1kt = _MIPH3("\028zL:T!;[:ln:L:")
  zcharacterDogWalker.Visible = true
  zitemBody.Commands.ExamineBody.Enabled = true
  _Urwigo.MessageBox({
    Text = _MIPH3("%{\025z!\025"),
    Media = zmediaMurderscene
  })
end
function zoneCrimeScene:OnExit()
  _1kt = _MIPH3("\028zL:T!;[:ln:L:")
  if talked2Dogwalker == true then
    zcharacterDogWalker:MoveTo(zoneParkingLot)
  end
end
function zoneBaseballField:OnEnter()
  _1kt = _MIPH3("\028zL:i{M:\001{$$\a;:$#")
  if zoneBaseballField:Contains(zitemBat) then
    zitemMagnifyingGlass.Commands.UseWith.Enabled = true
  end
  _Urwigo.MessageBox({
    Text = _MIPH3("izz\025MM\025:X"),
    Media = zmediaBaseballField
  })
  zcharacterBaseBallPlayer.Visible = true
end
function zoneBaseballField:OnExit()
  _1kt = _MIPH3("\028zL:i{M:\001{$$\a;:$#")
  zitemMagnifyingGlass.Commands.UseWith.Enabled = false
end
function zoneLandscaper:OnEnter()
  _1kt = _MIPH3("\028zL:\027{L#Mn{x:!")
  zitemFingerprint:MoveTo(nil)
  zoneBaseballField.Active = false
  _Urwigo.MessageBox({
    Text = _MIPH3("l\025!{L#"),
    Media = zmediaStairs
  })
  zcharacterGardener.Visible = true
end
function zoneParkingLot:OnEnter()
  _1kt = _MIPH3("\028zL:\029{!-;LX\027z\025")
  _Urwigo.MessageBox({
    Text = _MIPH3("\029{!-x${\025\028D[;\025D\029z$;\028:;{&\025z"),
    Media = zmediapolicecar
  })
end
function zoneGeocacher:OnEnter()
  _1kt = _MIPH3("\028zL:w:zn{n\v:!")
  zonePlayground.Active = false
  _Urwigo.MessageBox({
    Text = _MIPH3(":;LDw:zn{n\v:!"),
    Media = zmediageocacher
  })
  zcharacterGeocacher.Visible = true
  if not Player:Contains(zitemGun) then
    zitemMagnifyingGlass:MoveTo(nil)
  end
end
function zoneGeocacher:OnExit()
  _1kt = _MIPH3("\028zL:w:zn{n\v:!")
  if AlreadyspoketoDW == false then
    AlreadyspoketoDW = true
    _Urwigo.MessageBox({
      Text = _MIPH3("\017$MDl;:D#:LDw:zn{n\v:!D9:!${MM:L\"D-z[[\025D#;:D\a!{&D[;\025D#:[DA&L#D{& Dl;:D\028&CDr4MD;M\025D8{\v!Mn\v:;L$;n\vDL;n\v\025Mr\"DM{X\025DM;:\"Dr{\001:!D\003:\025\028\025\"D8zD;n\vD#{!\195\188\001:!DL{n\v#:L-:\"D8:! :LDl;:DLzn\vD:;L:LD8:;\025:!:LDi$;n-D{& D#;:D\027:;n\v:CD6n\vDX${&\001:\"D:!D\v{\025D9:!M&n\v\025\"D[;n\vD{& D:\0258{MD\v;L\028&8:;M:LCD6n\vDX${&\001:\"D:!D\v{\025D9:!M&n\v\025\"D[;!D:\0258{MD\028&DM{X:LCD"),
      Media = zmediaDogWalkerTalkingFinal,
      Buttons = {
        _MIPH3("62$$Dn\v:n-D;\025Dz&\025"),
        _MIPH3("62$$D$zz-D${\025:!")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            AlreadyspoketoDW = true
            _Urwigo.MessageBox({
              Text = _MIPH3("rln\v{&D#;!DM:;L:DA{L#DX:L{&D{LCD4MDM;:\v\025DMzD{&M\"D{$MD8\195\188!#:D:!D{& D:\0258{MD\028:;X:LCr")
            })
          else
            _Urwigo.MessageBox({
              Text = _MIPH3("r\r&L\"D;n\vD#{n\v\025:D:MD8\195\164!:D8;n\v\025;XDCCCDV{LLD-\195\182LL:LD8;!D\v;:!DL{n\vDA{&M:DCCCD\a!;\025\028D8;!#D\v&LX!;XCr")
            })
          end
        end
      end
    })
    zcharacterDogWalker:MoveTo(zoneCrimeScene)
  end
end
function zonePlayground:OnEnter()
  _1kt = _MIPH3("\028zL:\029${>X!z&L#")
  zitemMagnifyingGlass.Commands.UseWith.Enabled = true
  zoneLandscaper.Active = false
  _Urwigo.MessageBox({
    Text = _MIPH3(":;LDlx;:$x${\025\028"),
    Media = zmediaPlayground
  })
  zcharacterMotherandChild.Visible = true
end
function zonePlayground:OnExit()
  _1kt = _MIPH3("\028zL:\029${>X!z&L#")
  if not Player:Contains(zitemGun) then
    zitemMagnifyingGlass.Commands.UseWith.Enabled = false
  end
  if DNAProcessing == true then
    zitemDNA:MoveTo(zitemPolicecar)
    DNAProcessing = false
  end
end
function zinputFoundCache:OnGetInput(input)
  if input == nil then
    input = ""
  end
  CacheFound = input
  if Wherigo.NoCaseEquals(CacheFound, _MIPH3("X:zn{n\v:")) then
    _Urwigo.MessageBox({
      Text = _MIPH3("r\006{MDM;:\v\025DL{n\vDi:8:;M:LD{&MCD6n\vD\vz$:D\001:MM:!D[:;LD\rz\025;\028\001&n\vD\v:!{&M\"D&[D[;!D\rz\025;\028:LD\028&D[{n\v:LCr\014i\026E\014i\026EA;L8:;MD \195\188!D#:LDlx;:$:!\fDA:!\028$;n\v:LDw$\195\188n-8&LMn\vCDl;:D\v{\001:LD:;L:LD\001:#:&\025:L#:LDi:8:;MDX: &L#:LD_izL&Mn{n\v:DwTY\016\a\\\rDO&X{LXD\bDc:!M\025:n-#{\025&[D%%\016\016fCDc:!${MM:LDl;:D#:LDT{n\v:DX:L{&DMz\"D8;:Dl;:D;\vLDX: &L#:LD\v{\001:LCD4;LD9;!\025&:$$:MDi:8:;M[;\025\025:$D\001: ;L#:\025DM;n\vD\003:\025\028\025D;LD6\v!:[D6L9:L\025{!\"D&[D:MD\028&D&L\025:!M&n\v:LCD4;LD\rz\025;\028\001$zn-D\001: ;L#:\025DM;n\vD:\001:L {$$MD;LD6\v!:[D6L9:L\025{!CDc:!8:L#:LDl;:D:M\"D&[D6\v!:D\017& X{\001:LD\028&D:!$:#;X:LC"),
      Media = zmediaAmmoCan
    })
    zitemAmmoCan:MoveTo(Player)
    zitemNotepad:MoveTo(Player)
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("A[[[\"D#{MD;M\025D;L\025:!:MM{L\025\"D{\001:!D;n\vD#:L-:DL;n\v\025\"D#{MMD:MDRzLM:@&:L\028:LD \195\188!D#;:M:LD\a{$$D\v{\025CDln\v{&D$;:\001:!DLzn\v[{$D\v;LC")
    })
  end
end
function zinputMurderer:OnGetInput(input)
  if input == nil then
    input = ""
  end
  Culprit = input
  if Wherigo.NoCaseEquals(Culprit, _MIPH3("X:zn{n\v:!")) or Wherigo.NoCaseEquals(Culprit, _MIPH3("\a%\aDA&L\025:!")) then
    zitemNotepad.Commands.NotePrimarySuspect.Enabled = false
    _Urwigo.MessageBox({
      Text = _MIPH3("A:!\028$;n\v:Dw$\195\188n-8\195\188LMn\v:CDl;:D\v{\001:LD#:LD\a{$$DX:$\195\182M\025C\014i\026E\014i\026EV:LLDl;:D\028&[Dl\025!:; :L8{X:LD\028&!\195\188n--:\v!:L\"D[{n\v:LDl;:D:;L:D\029{&M:\"D&[DM;n\vD\028&D !:&:L\"D3L\001MxN#:LLDM;:DM:\v:LD#{MD#:!Dw:zn{n\v:!DX: :MM:$\025D&L#D8:XX: {\v!:LD8;!#CDV{MD \195\188!D:;LD{$\001:!L:MDlx;:$D;M\025Dw:zn{n\v;LXD\195\188\001:!\v{&x\025d"),
      Media = zmediahandcuffs,
      Buttons = {
        _MIPH3("\006zL:")
      },
      Callback = function(action)
        if action ~= nil then
          cartMurderintheOutfield.Complete = true
          ztaskFindtheculprit.Complete = true
          _Urwigo.OldDialog({
            {
              Text = _MIPH3("6n\vDX:\v:D#{9zLD{&M\"D#{MMD:MD\003:\025\028\025DLzn\vD\028&[D\a;L{$D#:MDV\v:!;XzMDX:\v:LDMz$$CD6n\vD\vz  :Dl;:D\v{\001:LD#;:DQDM\025:$$;X:DO{\v$D{&MD#:[DizL&MD_{&MM:LD{[D\029:\025$;LXfC"),
              Media = zmediahandcuffs
            },
            {
              Text = _MIPH3("\027zMDX:\v\025Mt"),
              Media = zmediaMurderscene
            }
          })
          _khvF.Active = true
          _khvF.Visible = true
          zitemGun:MoveTo(zcharacterMotherandChild)
          zcharacterDogWalker:MoveTo(nil)
          zitemAmmoCan.Commands.Examine.Enabled = false
          zoneGeocacher.Active = false
          zonePlayground.Active = false
          zoneLandscaper.Active = false
          zoneBaseballField.Active = false
          zoneCrimeScene.Active = false
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("\006{MD;M\025D\a{$Mn\vC")
    })
  end
end
function zinputWeapon:OnGetInput(input)
  if input == nil then
    input = ""
  end
  Weaponvar = input
  if Wherigo.NoCaseEquals(Weaponvar, _MIPH3("\017$&!z\v!")) then
    zitemNotepad.Commands.NoteMurderWeapon.Enabled = false
    ztaskFindtheweapon.Complete = true
    _Urwigo.MessageBox({
      Text = _MIPH3("A:!\028$;n\v:LDw$\195\188n-8&LMn\v\"Dl;:D\v{\001:LD#;:D\016z!#8{  :D\v:!{&MX: &L#:LCD\006;:M:D\017& X{\001:D;M\025D\003:\025\028\025D{\001X:Mn\v$zMM:LCD6\v!:DL\195\164n\vM\025:D&L#D$:\025\028\025:D\017& X{\001:D\001:M\025:\v\025D#{!;L\"D :M\025\028&M\025:$$:L\"D8:!D:MDX:\025{LD\v{\025C")
    })
    ztaskFindtheculprit.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("4L\025Mn\v&$#;X&LX\"D#{MD;M\025DL;n\v\025D!;n\v\025;XC")
    })
  end
end
function zcharacterBaseBallPlayer:OnTalk(target)
  if batexamined == true then
    _Urwigo.MessageBox({
      Text = _MIPH3("\r&L\"D8:LLD;n\vD[;\025D{& \001{&:LD[:;L:MD\a{$\025\001zz\025:MD :!\025;XD\001;LD8z$$\025:D;n\vD$zMx{##:$LC"),
      Media = zmediaBaseballPlayer
    })
  else
    _Urwigo.OldDialog({
      {
        Text = _MIPH3("\127{\"D;n\vD\v{\001:D#:LDR:!$D#{D#!\195\188\001:LDX:M:\v:LCD6n\vD ;LXD{L\"D[:;LDizz\025D\028&M{[[:LD\028&D\001{&:LCD6n\vD8&MM\025:DL;n\v\025\"D#{MMD#:!DR:!$D\025z\025D8{!\"D\001;MD#;:M:D\006{[:D;LD\029{L;-DX:!;:\025C"),
        Media = zmediaBaseballPlayer
      },
      {
        Text = _MIPH3("l;:D\001{\025D#{!&[\"D[:;LDA{L#>D\028&D\001:L&\025\028:L\"D{\001:!DM;:D8{!D\028&D\v:-\025;Mn\v\"D&[D{L\028&!& :L\"D{$MzD\001{\025DM;:D[;n\vD#{!&[CD6n\vD\v{\001:D#{!{& DX:8{!\025:\025\"D#{MMD;\v!D-z[[\025\"D&L#D:;LD\029z$;\028;M\025D\v{\025D[;n\vDX:\001:\025:LD\028&D\001$:;\001:L\"D\001;MD;n\vD[;\025D:&n\vDX:Mx!zn\v:LD\v{\001:C"),
        Media = zmediaBaseballPlayer
      },
      {
        Text = _MIPH3("6n\vD\v{\001:D#:LDR:!$DLzn\vDL;:DX:M:\v:L\"D{\001:!D:!DMn\v;:LD:\0258{MD\028&DM&n\v:LC"),
        Media = zmediaBaseballPlayer
      }
    })
  end
end
function zcharacterBaseBallPlayer:OnObserve(target)
  batexamined = true
  zitemBat.Visible = true
  zitemBat:MoveTo(zoneBaseballField)
  _Urwigo.MessageBox({
    Text = _MIPH3("\017$$:MDMn\v:;L\025D:n\v\025D\028&DM:;LCD\a{$\025\001zz\025\"D\029{##:$\"Dln\v8;[[8:M\025:CD|\0018z\v$\"D8:LLD:!DL&!D{$$:;L:Dx{##:$\025\"D8z \195\188!D;LD{$$:!DV:$\025D;M\025D#{MD?CD\029{##:$dD\006{MD\029{##:$D8;!-\025D:\0258{MD9:!#\195\164n\v\025;XC"),
    Media = zmediaBaseballPlayer
  })
end
function zcharacterMotherandChild:OnQuestion(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("A{$$zC"),
    Media = zmediaMotherDaughter,
    Buttons = {
      _MIPH3("\017M-D{\001z&\025DX&L"),
      _MIPH3("\017M-D{\001z&\025D9;n\025;[")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" and zcharacterMotherandChild:Contains(zitemGun) then
          _Urwigo.MessageBox({
            Text = _MIPH3("|\vD#{MdD4MD;M\025DL&!D:;LDlx;:$\028:&XCDl:\v:LDl;:\"D#:!D\027{& D;M\025D{&MDR&LM\025M\025z  C"),
            Media = zmediaGun,
            Buttons = {
              _MIPH3("\r;[[D#;:DV{  :"),
              _MIPH3("\027{MMD:M")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  _Urwigo.MessageBox({
                    Text = _MIPH3("V\195\164\v!:L#Dl;:D#;:DV{  :D\001:Mn\v${XL{\v[:L\"D\001:X;LL\025D#{MD-$:;L:D\016\195\164#n\v:LD\028&D8:;L:LC"),
                    Media = zmediaGirlCrying,
                    Buttons = {
                      _MIPH3("\027{MMD:M"),
                      _MIPH3("L;[[DM;:D\025!z\025\028#:[")
                    },
                    Callback = function(action)
                      if action ~= nil then
                        if action == "Button2" then
                          zitemGun:MoveTo(Player)
                          _Urwigo.MessageBox({
                            Text = _MIPH3("r\006;:MD;M\025DL&!D:;LDi:8:;MCD6n\vD8:!#:D:MD6\vL:LD;LDR\195\188!\028:D\028&!\195\188n-X:\001:LCrD6\v!:DVz!\025:DM;L#D\003:#zn\vDL;n\v\025D\025!\195\182M\025$;n\v\"D#{MD\016\195\164#n\v:LD8:;L\025D;[[:!DLzn\vC"),
                            Media = zmediaGun
                          })
                        else
                          _Urwigo.MessageBox({
                            Text = _MIPH3("\006{MD\016\195\164#n\v:LD#{L-\025D#;!D&L#DM{X\025D#;!\"D#{MMDM;:D\029z$;\028;M\025;LD8:!#:LD8;$$\"D8:LLDM;:D:!8{n\vM:LD;M\025CDl;:DM&n\v:LDMn\vL:$$DL{n\vD:;L:[D%{Mn\v:L\025&n\v\"D\001:9z!DM;:Dl;:D8:;L:LDM:\v:LC"),
                            Media = zmediaMotherDaughter
                          })
                        end
                      end
                    end
                  })
                else
                  _Urwigo.MessageBox({
                    Text = _MIPH3("\006{MD\016\195\164#n\v:LD#{L-\025D#;!D&L#DM{X\025D#;!\"D#{MMDM;:D\029z$;\028;M\025;LD8:!#:LD8;$$\"D8:LLDM;:D:!8{n\vM:LD;M\025CDl;:DM&n\v:LDMn\vL:$$DL{n\vD:;L:[D%{Mn\v:L\025&n\v\"D\001:9z!DM;:Dl;:D8:;L:LDM:\v:LC"),
                    Media = zmediaMotherDaughter
                  })
                end
              end
            end
          })
        elseif action == "Button1" then
          _Urwigo.MessageBox({
            Text = _MIPH3("\006&D\v{M\025D[:;L:Dlx;:$\028:&Xx;M\025z$:CDi:-z[[:D;n\vD:MD\028&!\195\188n-d"),
            Media = zmediaGun,
            Buttons = {
              _MIPH3("\127{"),
              _MIPH3("\r:;L")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" then
                  _Urwigo.MessageBox({
                    Text = _MIPH3("|\vD9;:$:LD\006{L-CD6\v!Dc{\025:!D\v{\025D;\v!D#{MDX:X:\001:LDCCCD6n\vD#:L-:\"D;\vLD-\195\188[[:!\025D#:!Dw:8{$\025{Mx:-\025DL;n\v\025C\014i\026E\014i\026E\006{MD\016\195\164#n\v:LD\v\195\182!\025D{& D\028&D8:;L:LCDr\006{L-:r\"DM{X\025DM;:CDl;:D-\195\182LL:LD#;:D%!\195\164L:LD-{&[D\028&!\195\188n-\v{$\025:LC"),
                    Media = zmediaGirlCrying
                  })
                  zitemGun:MoveTo(zcharacterMotherandChild)
                else
                  _Urwigo.MessageBox({
                    Text = _MIPH3("\006{MD-$:;L:D\016\195\164#n\v:LDMn\v$&n\v\028\025D;[[:!DLzn\vD\195\188\001:!D;\v!D\001:Mn\v${XL{\v[\025:MDlx;:$\028:&XCDr\006&D\001;M\025D:;LDX:[:;L:!D\029z$;\028;M\025r\"DM{X\025DM;:D${&\025C\014i\026E\014i\026E"),
                    Media = zmediaGirlCrying
                  })
                end
              end
            end
          })
        else
          _Urwigo.MessageBox({
            Text = _MIPH3("6n\vD\v{\001:D#{MD|x :!DL;n\v\025DX:M:\v:LCDV;!D-{[:LD\v;:!D{L\"D-&!\028D\001:9z!D#;:D\029z$;\028:;D:;L\025!{ CDl;:D\001{\025:LD&LMD\028&D\001$:;\001:L\"D\001;MD#;:D4![;\025\025$:!D\v;:!D{L-z[[:LC\014i\026E\014i\026EV;MM:LDl;:D8{MDX!&M:$;XD;M\025\"dD\006;:M:!D%>xD#{D#!\195\188\001:LCD6n\vD\v\195\182!\025:D;\vLD:\0258{MD\195\188\001:!Dr\a%\arDM{X:L\"D{$MD8;!D#:LDlx;:$x${\025\028D\001:\025!{\025:LCD4!D\v{\025D;LD#:LDi\195\188Mn\v:LD\v:!&[X:${&:!\025D&L#DMzCDV{!&[D${&:!\025D:!D8z\v$D{& D#;:M:[Dlx;:$x${\025\028dD\006;:D:;L\028;X:LDR;L#:!D\v;:!DM;L#D[:;L:CD6n\vD \195\188\v$:D[;n\vDL;n\v\025DM;n\v:!C"),
            Media = zmediaGeocacherfromplayground
          })
          zoneGeocacher.Active = true
          zoneGeocacher.Visible = true
        end
      end
    end
  })
end
function zcharacterGardener:OnInterrogate(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("\127{\"D;n\vD\001;LD\v;:!D{LX:M\025:$$\025CD6n\vD\v{\001:D\017!\001:;\025D\028&D:!$:#;X:LND-{LLD;n\vD\003:\025\028\025DX:\v:Ld"),
    Media = zmediaGardenerTalking,
    Buttons = {
      _MIPH3("{LMx!:n\v:L"),
      _MIPH3("X:L{&D{LMn\v{&:L")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          zonePlayground.Active = true
          zonePlayground.Visible = true
          _Urwigo.OldDialog({
            {
              Text = _MIPH3("\006{MD\029{##:$dD\r&L\"D;n\vD\v{\001:D#:LDl\025!{L#DX:\v{!-\025\"D#{D {L#D;n\vD#{MD\029{##:$D&L#D\v{\001:D:MD#:[D\029{##$:!D\028&!\195\188n-X:X:\001:LC"),
              Media = zmediaBat
            },
            {
              Text = _MIPH3("\127{\"D;n\vD\v{\001:D#{MD|x :!DX:M:\v:L\"D\001:9z!D#;:D\a!{&D;\vLD\025z\025D:L\025#:n-\025:CD4!DMn\v$\195\164LX:$\025:DM;n\vDL&!D&[D#;:Di\195\188Mn\v:CD6n\vD#{n\v\025:\"D:!DM&n\v\025DL{n\vD\029;$\028:LDz#:!DMzDCCCD#{MD[{n\v:LD\v;:!D9;:$:D\027:&\025:C"),
              Media = zmediaGardenerTalking
            },
            {
              Text = _MIPH3("V{MdD6n\vD\v{\025\025:D-:;L:LDw!&L#D;\vLD\028&D\025\195\182\025:LCD6n\vD{!\001:;\025:DL&!D\v;:!CD6n\vD\001;LD[;!D\003:#zn\vD\028;:[$;n\vDM;n\v:!\"D#{MMD#;:M:D\006{[:D&L#D#{MDR;L#D#z!\025D{& D#:[Dlx;:$x${\025\028D:;L:DV{  :D;LD;\v!:[Di:M;\025\028D\v{\001:LC"),
              Media = zmediaGardenerTalking
            }
          })
        else
          _Urwigo.MessageBox({
            Text = _MIPH3("A;:!D;M\025D:;LD%>x\"D#:!DX:!{#:DM:;L:LD\127z\001D[{n\v\025CD\r;n\v\025MD\028&D9:!#\195\164n\v\025;XD{LD;\v[ND\017\001:!D;M\025D#{MD:;LDA{[[:!D;LDM:;L:!D%{Mn\v:d"),
            Media = zmediaWrench
          })
          zitemHammer:MoveTo(zoneLandscaper)
        end
      end
    end
  })
end
function zcharacterGeocacher:OnTalk(target)
  _Urwigo.OldDialog({
    {
      Text = _MIPH3("V{MD;n\vD\v;:!D[{n\v:dD6n\vDMx;:$:Dw:zn{n\v;LXCD4MD;M\025D:;LD|L$;L:eln\v{\025\028M&n\vMx;:$D[;\025Dw\029le4[x \195\164LX:!L\"D&[D|\001\003:-\025:D\028&D ;L#:LC"),
      Media = zmediageocacher
    },
    {
      Text = _MIPH3("|\v\"D#:!Dln\v${[[D{& D[:;L:LDln\v&\v:LdD|\v\"DL&L\"D;n\vD\v{\001:DL{n\vD:;L:[DX{L\028DL:&:LDT{n\v:D;[Dw:\001\195\188Mn\vDX:M&n\v\025\"DM:\v:LDl;:\"D\v;:!D;M\025D#{MD\027;M\025;LX\001${\025\025CD4MD\v{\025D8;!-$;n\vDlx{\195\159DX:[{n\v\025D9zLD:;L:[Dw:zn{n\v:!DL{[:LMDr:##>ML\028rCD4MD8{!DM:;LD:!M\025:!D\016>M\025:!>eT{n\v:CD4MDM\025:$$\025:DM;n\vD\v:!{&M\"D#{MMD:MD\195\188\001:!\v{&x\025DL;n\v\025D;[Dw:\001\195\188Mn\vD8{!CD4MD8{!D:;LD\029:\025$;LXD[;\025D:;L:[Dln\v$zMMD#{9z!C"),
      Media = zmediaGeocacherfromplayground
    },
    {
      Text = _MIPH3("\016:;LD|L$;L:eT{n\v;LXe\r{[:D;M\025D\a%\aDA&L\025:!D&L#D;n\vD[{n\v:D#{MD\003:\025\028\025DM:;\025D:;L;X:LD\127{\v!:LCD6n\vD[{XD:M\"DMzD9;:$:D8;:D[\195\182X$;n\vD{$MD:!M\025:!D\028&D ;L#:L\"D8:;$D:MD;LDV;!-$;n\v-:;\025DL&!D&[D#;:Dl\025{\025;M\025;-DX:\v\025C"),
      Media = zmediageocacher
    },
    {
      Text = _MIPH3("V{!&[D\001!{&n\v:D;n\vD\0288:;D4[x \195\164LX:!D\028&[Dlx;:$:LdD|\v\"DL&L\"D#;:MD;M\025D:;LDLz![{$:MDw\029l\"D[;\025D#:[D;n\vD#;:M:LDizL&MeT{n\v:DX: &L#:LD\v{\001:CD\006{MD{L#:!:D;M\025D:;LDL:&:MDA{L#>D9zLD\026\a%\"D#{MD;n\vD\001!{&n\v:\"D&[D#;:M:LDV\v:!;XzD\028&D[{n\v:LC"),
      Media = zmediagpsaddedsm
    }
  })
end
function zcharacterGeocacher:OnObserve(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("4;L:DM:$\025M{[D{&MM:\v:L#:D\029:!MzLD[;\025Dr\a%\aDA&L\025:!rD{& DM:;L:[DA:[#CD4!DMn\v:;L\025D?Dw\029le4[x \195\164LX:!D\028&D\025!{X:LD&L#D\v{\025D:\0258{MDln\v${[[D{& DM:;L:LDln\v&\v:LCD4!DMn\v:;L\025D{&n\vD\0288:;Di${\025\025D\029{x;:!D\028&D\v{\001:LCD\017& D:;L:[DM\025:\v\025DizL&MD&L#D{& D#:[D{L#:!:LDM\025:\v\025DV\v:!;XzC"),
    Media = zmediageocacher
  })
end
function zcharacterDogWalker:OnTalk(target)
  if zoneGeocacher:Contains(zcharacterDogWalker) and AlreadyspoketoDW == false then
    _Urwigo.MessageBox({
      Text = _MIPH3("\006;:D\a!{&D $\195\188M\025:!\025\fDr\r;n\v\025D\v;:!\"D;n\vD[&MMDx!;9{\025D[;\025D6\vL:LDMx!:n\v:LCr"),
      Media = zmediaDWTalking2
    })
  elseif zoneGeocacher.Active == true then
    AlreadyspoketoDW = true
    _Urwigo.MessageBox({
      Text = _MIPH3("6n\vD:!;LL:!:D[;n\vD\003:\025\028\025DLzn\vD{LD[:\v!\"D:!D[&![:$\025:D;!X:L#:\0258{MD9zLD:;L:[Dc:!M\025:n-CDl;:\v\025D:MDL;n\v\025DMzD{&M\"D{$MD8\195\188!#:D:!D{& D:\0258{MD\028:;X:Ld"),
      Media = zmediaDogWalkertalkingbody
    })
    zcharacterDogWalker:MoveTo(nil)
  else
    _Urwigo.OldDialog({
      {
        Text = _MIPH3("\017$MD;n\vD;\vLD#{MD:!M\025:D[{$D\025!{ \"DMn\v;:LD:!D8{MD\028&DM&n\v:L\"D{\001:!D\001:;[D\026\195\188n-8:XD:;LDx{{!D\016;L&\025:LDMx\195\164\025:!D${XD:!D#z!\025C"),
        Media = zmediaDWTalking2
      },
      {
        Text = _MIPH3("\017$MD;n\vD[;n\vDL\195\164\v:!\025:\"DM{X\025:D:!D:\0258{MD\195\188\001:!D#:LD\029{##$:!\"D{\001:!D;n\vD-zLL\025:D:MDL;n\v\025D!;n\v\025;XD9:!M\025:\v:L\"D&L#D#{LLDM\025{!\001D:!C"),
        Media = zmediaDogWalkertalkingbody
      }
    })
    zcharacterBaseBallPlayer.Visible = true
    zoneBaseballField.Active = true
    zoneBaseballField.Visible = true
  end
end
function zitemBat:OnExamine(target)
  if Player:Contains(zitemMagnifyingGlass) then
    _Urwigo.MessageBox({
      Text = _MIPH3("4MDMn\v:;L\025D:;L:LD\a;LX:!{\001#!&n-D{& D#:[D\029{##:$D\028&DX:\001:L\"D{\001:!D[{LD-{LLD:MDL;n\v\025DX{L\028D:!-:LL:LDCCCD8:LLD[{LD:MDL&!D\001:MM:!DM:\v:LD-\195\182LL\025:C"),
      Media = zmediaBat
    })
  else
    zoneParkingLot.Active = true
    zoneParkingLot.Visible = true
    _Urwigo.MessageBox({
      Text = _MIPH3("4MDMn\v:;L\025DL&!D:;LDX:8\195\182\vL$;n\v:MDAz$\028x{##:$D3L\001MxN\028&DM:;LC\014i\026E\014i\026EA[[[\"D8:LLD;n\vDL&!D[:;L:D\027&x:D\v\195\164\025\025:CD6n\vD#:L-:\"D:MD;M\025D;LD[:;L:[Dl\025!:; :L8{X:LC"),
      Media = zmediaBat,
      Buttons = {
        _MIPH3("|-")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zitemHammer:OnExamine(target)
  if BloodyWrench == true then
    _Urwigo.MessageBox({
      Text = _MIPH3("i:;DL\195\164\v:!:!Di:\025!{n\v\025&LXD#:MDA{[[:!MDMn\v:;L\025DM;n\vD:\0258{MDi$&\025D#{!{& D\028&D\001: ;L#:LC"),
      Media = zmediaWrench,
      Buttons = {
        _MIPH3("i$&\025x!z\001:DL:\v[:L"),
        _MIPH3("\016{n\vD;\vLDM{&\001:!")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.MessageBox({
              Text = _MIPH3("\006:!D\017LX:M\025:$$\025:D#:!DR{L&M\025{\025;zLDM;:\v\025D:\0258{MDL:!9\195\182MD{&M\"D{$MDl;:D:;L:LDi$&\025\025&x :!DL:\v[:LD&L#D;\vLD6\v!:[D\017MM;M\025:L\025:LDX:\001:LCD\006:!D\017LX:M\025:$$\025:DM{X\025D6\vL:LD#{LL\"D#{MMD#{MDi$&\025DM:;LMD;M\025D&L#D:!D\028:;X\025D6\vL:LD:;L:D !;Mn\v:DV&L#:D{LDM:;L:[Dln\v;:L\001:;LCD4!D\001:\v{&x\025:\025:\"D:!DM:;D{&MX:!&\025Mn\v\025\"D{$MD:!D:;LDl\025\195\188n-D#:MDl\025:XMD!:x{!;:!\025:C\014i\026E\014i\026E6\v!:Di$&\025x!z\001:D-{LLD;LDR\195\188!\028:D{L{$>M;:!\025D8:!#:LCD4MDMz$$\025:D;LD8:L;X:LD\016;L&\025:LD;LD6\v!:[D\029z$;\028:;{&\025zD :!\025;XD&L#D9:! \195\188X\001{!DM:;LCDl;:D\v{\001:LD#;:D\001:M\025:LD\a{n\ve\027:&\025:\"D#;:D[{LD \195\188!Dw:$#D-{& :LD-{LLCDl;:D\v{\001:LD:MD :!\025;X\"DL{n\v#:[Dl;:D[;\025D[:\v!D\027:&\025:LDX:Mx!zn\v:LD\v{\001:LC"),
              Media = zmediadma
            })
            DNAProcessing = true
          else
            _Urwigo.MessageBox({
              Text = _MIPH3("V{MD \195\188!D:;LDMn\v\195\182L:!DX$\195\164L\028:L#:!DA{[[:!D#{MDX:8z!#:LD;M\025CD\127:\025\028\025D[\195\188MM:LDl;:D6\v!:[D\027:\001:LMX: \195\164\v!\025:LDL&!DLzn\vD6\v!:LD\001$&\025;X:LDA:[#\195\164![:$D:!-$\195\164!:LC")
            })
            zitemHammer.Media = zmediaCleanHammer
            BloodyWrench = false
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("\006{MD;M\025D:;LD[\195\164n\v\025;XDX$\195\164L\028:L#:!Dln\v!{&\001:LMn\v$\195\188MM:$CD4MD#{! DL;n\v\025D9;:$D9:!8:L#:\025D8:!#:LC")
    })
  end
end
function zitemAmmoCan:OnOpen(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("A[[[\"D{LMn\v:;L:L#D\v{\025D\a%\aDA&L\025:!\"D#:LDw:zn{n\v:\"D{$MD:!M\025:!DX: &L#:LCD\017\001:!D8{MD;M\025D#{MD\v;:!D#&!n\vX:M\025!;n\v:Ld"),
    Media = zmediaLogSheet
  })
end
function zitemAmmoCan:OnExamine(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("\006{MDM;:\v\025D{&MD8;:Di$&\025CDcz[D|x :!d"),
    Media = zmediaAmmoCan,
    Buttons = {
      _MIPH3("i$&\025x!z\001:\031\006\r\017DL:\v[:L"),
      _MIPH3(";M\025DL&!D-:\025n\v&x")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button2" then
          _Urwigo.MessageBox({
            Text = _MIPH3("V:LLD:MDL&!D\029z[[:MDX\195\164\001:DCCCD8;:D${LX:DLzn\vD\001;MD\028&[D\016;\025\025{X:MM:Ld")
          })
        else
          zitemDNA:MoveTo(zitemPolicecar)
          AmmoDna = true
          _Urwigo.MessageBox({
            Text = _MIPH3("4;LD%&x :!D8&!#:DX:Lz[[:LCD\006;:D4!X:\001L;MM:D8:!#:LD;LD8:L;X:LD\016;L&\025:LD;LD6\v!:[D\029z$;\028:;{&\025zD \195\188!Dl;:D\001:!:;\025M\025:\v:LC")
          })
        end
      end
    end
  })
end
function zitemBody:OnExamineBody(target)
  if AlreadyspoketoDW == true then
    _Urwigo.MessageBox({
      Text = _MIPH3("A[[[[\"D:MDM;:\v\025DMzD{&M\"D{$MD8\195\188!#:D:!D{& D#;:DAz$\028M\025{\025&:D\028:;X:LCD6n\vDMn\v{&:D:MD[;!D\001:MM:!D{LDCCCD|\v\"D8;:D;n\vD:MD\v{MM:\"DAz$\028M\025\195\164[[:DL{n\vDi:8:;M:LD\028&D#&!n\vM&n\v:LCD\014i\026E\017LD#:LDlx;:$:!\fDl&n\v:DA;:!DL{n\vD#:[DizL&Mn{n\v:DwTY\016\a\\\rD&L#D-z[[:D8;:#:!D;LD#;:M:DOzL:D\028&!\195\188n-"),
      Media = zmediaBodysfinger,
      Buttons = {
        _MIPH3("V{MDX: &L#:Ld"),
        _MIPH3("\r;n\v\025MDX: &L#:Ld")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(zinputFoundCache)
            end)
          else
            _Urwigo.MessageBox({
              Text = _MIPH3("\017LD#:LDlx;:$:!\fD\006{MD;M\025D#:!DizL&Mn{n\v:D3L\001MxNwTY\016\a\\\rCD4!D8;!#D#{MDln\v$\195\188MM:$8z!\025D:L\025\v{$\025:L\"D#{MDl;:D\001:L\195\182\025;X:L\"D&[D z!\025\028& {\v!:LC"),
              Media = zmediaSpoiler
            })
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("i:;DL\195\164\v:!:!Di:\025!{n\v\025&LXD#:MDR\195\182!x:!MD\001:[:!-:LDl;:D:;L:DM\025&[x :DRzx 9:!$:\025\028&LXD{[DA;L\025:!-zx C"),
      Media = zmediaBluntForceHead,
      Buttons = {
        _MIPH3("|-")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function zitemPolicecar:OnOpenDoortothePoliceCar(target)
  if zitemPolicecar:Contains(zitemMagnifyingGlass) then
    _Urwigo.MessageBox({
      Text = _MIPH3("|\v\"D#{D;M\025D[:;L:D\027&x:C"),
      Media = zmediaMagnifyer,
      Buttons = {
        _MIPH3("\r;[[D#;:D\027&x:"),
        _MIPH3("\027{MMD:M")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            zitemMagnifyingGlass:MoveTo(Player)
            _Urwigo.MessageBox({
              Text = _MIPH3("\006;:MDMz$$\025:DM;n\vD{$MDL\195\188\025\028$;n\vD:!8:;M:LC"),
              Media = zmediaMagnifyer
            })
          else
            _Urwigo.MessageBox({
              Text = _MIPH3("6n\vD8:!#:D:MDMx\195\164\025:!D\001:-z[[:LCD6n\vD8\195\188!#:D:MDL;n\v\025D&[MzLM\025DMn\v[&\025\028;XD[{n\v:LD8z$$:LC"),
              Media = zmediaMagnifyer
            })
          end
        end
      end
    })
  elseif zitemPolicecar:Contains(zitemDNA) then
    _Urwigo.MessageBox({
      Text = _MIPH3("6\v!D\006\r\017e\r{n\v8:;MD8&!#:D9:!{!\001:;\025:\025C"),
      Media = zmediadma,
      Buttons = {
        _MIPH3("\r;[[Di:8:;M:"),
        _MIPH3("\027{MMD:M")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            zitemDNA:MoveTo(Player)
          else
            _Urwigo.MessageBox({
              Text = _MIPH3("\006{MD;M\025D8{\v!Mn\v:;L$;n\vDMz8;:MzDL;n\v\025D8;n\v\025;XCDl;:D8:!#:LD#{MD8{\v!Mn\v:;L$;n\vD[;\025Dx&!:[Dw$\195\188n-D\v:!{&M ;L#:LC")
            })
          end
        end
      end
    })
  elseif cartMurderintheOutfield.Complete == true then
    zitemDNA:MoveTo(nil)
    _Urwigo.MessageBox({
      Text = _MIPH3("l;:DM\025:;X:LD;LD6\v!D\017&\025z\"DM\025{!\025:LD#:LD\016z\025z!D&L#D {\v!:LD8:XCD\006{MD8{!D:;L {n\vCDV{MD8{!D#{MD \195\188!D:;LD2c;X:M;[{$2e\006;LX\"D9zLD#:[D;n\vD#;:M:LD\006!:n-M{n-DX:\v\195\182!\025D\v{\001:DCCCD;M\025D#{MDL;n\v\025D#{MD\r&[[:!;:!&LXMM>M\025:[D#:!D\016{>{dDi{M;MD?SD6n\vD#:L-:D:MD;M\025C\014i\026E\014i\026E\006{L-:D \195\188!MDlx;:$:LCDAz  :D#&D {L#:M\025D:MD$&M\025;XCD\027{MM:LDl;:D[;n\vD8;MM:L\"D8:LLDl;:Dcz!Mn\v$\195\164X:D\v{\001:LC"),
      Media = zmediapolicecar
    })
    zoneParkingLot.Active = false
    zitemPolicecar:MoveTo(nil)
    zitemNotepad:MoveTo(nil)
    zitemAmmoCan:MoveTo(nil)
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("A[[[\"D8z \195\188!D\001;LD;n\vD\v:!X:-z[[:LdD6n\vD\v{MM:D:MD8;!-$;n\vD{$\025D\028&D8:!#:LDCCCD8zD;M\025D[:;LDw;L-zd")
    })
  end
end
function zitemFingerprint:OnExamine(target)
  _Urwigo.MessageBox({
    Text = _MIPH3("A[[[\"D#;:M:!D\a;LX:!{\001#!&n-D:L\025Mx!;n\v\025D#:[D#:MD\017LX:M\025:$$\025:L\"D#:LD#;:D{L#:!:LDi:{[\025:LD9z!D[:;L:!D\017L-&L \025D{& X:Lz[[:LD\v{\001:LC\014i\026E\014i\026E\006:!D\029{##$:!D&L\025:!\001!;n\v\025Dr\127{\"D:!D\v{\025D[;!D[:;L:LD\029{##:$DX:X:\001:L\"D8\195\164\v!:L#D;n\vD[:;LD\a{$\025\001zz\025D{& X:\001{&\025D\v{\001:CD6n\vD\v{\025\025:D:MD8z\v$D&L\025:!8:XMD9:!$z!:LC"),
    Media = zmediaBaseballPlayer
  })
  zoneLandscaper.Active = true
  zoneLandscaper.Visible = true
end
function zitemDNA:OnAnalyze(target)
  if AmmoDna == false then
    _Urwigo.MessageBox({
      Text = _MIPH3("4MDMn\v:;L\025\"D#{MMD#:!D\017LX:M\025:$$\025:D#;:DV{\v!\v:;\025DM{X\025:CD\006;:M:D\006\r\017D;M\025D#: ;L;\025;9DM:;L:C"),
      Media = zmediaGardener
    })
  else
    _Urwigo.MessageBox({
      Text = _MIPH3("\006;:MDMn\v:;L\025D#;:D\006\r\017D#:MD|x :!MD\028&DM:;LC"),
      Media = zmediabody
    })
  end
end
function zitemNotepad:OnNoteMurderWeapon(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(zinputWeapon)
  end)
end
function zitemNotepad:OnNotePrimarySuspect(target)
  if ztaskFindtheweapon.Complete == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(zinputMurderer)
    end)
  else
    _Urwigo.MessageBox({
      Text = _MIPH3(")[D6\v!:D\017LMn\v&$#;X&LXD{& !:n\v\025\028&:!\v{$\025:L\"DMz$$\025:LDl;:D\028&:!M\025D#;:D\016z!#8{  :D ;L#:LC")
    })
  end
end
function zitemMagnifyingGlass:OnUseWith(target)
  if target == zitemBat and Player:Contains(zitemFingerprint) then
    _Urwigo.MessageBox({
      Text = _MIPH3("l;:D\v{\001:LD\001:!:;\025MD#:LD\a;LX:!{\001#!&n-D:!\v{$\025:LCD4!;LL:!M\025D#&D#;n\vDL;n\v\025dDVzD;M\025D[:;LDw;L-zd"),
      Media = zmediafingerprint
    })
  elseif target == zitemBat then
    zitemFingerprint:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = _MIPH3("l;:DM:\v:LD\v;:!D:;L:LDMn\v\195\182L:LDX!z\195\159:LD\a;LX:!{\001#!&n-CDl;:DL:\v[:LD6\v!D\a;LX:!{\001#!&n-eR;\025D\v:!{&M\"DL:\v[:LD:;L:D\029!z\001:D&L#DMn{LL:LDM;:D;LD6\v!DV\027\017\re\rz\025:\001zz-CD)L#D;LD8:L;X:LD\017&X:L\001$;n-:LDM;L#D#;:D4!X:\001L;MM:D;LD6\v!:[Di:M;\025\028C"),
      Media = zmediafingerprint
    })
  elseif target == zitemGun then
    _Urwigo.MessageBox({
      Text = _MIPH3("Vz8\"D:MD;M\025D8;!-$;n\vD\029${M\025;-CDc;:$$:;n\v\025D\v\195\164\025\025:D;n\vD:MD#:[D-$:;L:LD\016\195\164#n\v:LD\028&!\195\188n-X:\001:LDMz$$:LC"),
      Media = zmediaGun
    })
  end
end
cartMurderintheOutfield.MsgBoxCBFuncs = {}
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB4(action)
  if action ~= nil then
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB16(action)
  if action ~= nil then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB12(action)
  if action == "Button1" then
    zitemDNA:MoveTo(Player)
  else
    Wherigo.MessageBox({
      Text = "That probably isn't important anyway. You'll probably figure this out on pure luck."
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB5(action)
  if action == "Button2" then
    zitemGun:MoveTo(Player)
    Wherigo.MessageBox({
      Text = "\"This is just evidence. I'll get it back to you shortly.\" However, your authoritative words are of no comfort, the girl is still crying.",
      Media = zmediaGun
    })
  else
    Wherigo.MessageBox({
      Text = "The girl thanks you and tells you that she wants to be a cop when she grows up. You quickly search for a tissue before they see you crying.",
      Media = zmediaMotherDaughter
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB8(action)
  if action == "Button1" then
    zonePlayground.Active = true
    zonePlayground.Visible = true
    Wherigo.Dialog({
      {
        Text = "The Bat? Well, I was checking out the sprinker heads when I found it lying in the field and so I returned it to the Baseball player.",
        Media = zmediaBat
      },
      {
        Text = "Yeah, I noticed the victim before the dog walker discovered him dead. He was just meandering around the bushes. I thought he was looking for a golf ball or something....they do that here all the time you know.",
        Media = zmediaGardenerTalking
      },
      {
        Text = "Me? I had no reason to kill him. I just work here. However, that lady and kid over there in the playground, I'm pretty sure I saw a gun in their possession.",
        Media = zmediaGardenerTalking
      }
    })
  else
    Wherigo.MessageBox({
      Text = "Here's a guy just doing his job. Nothing too suspicious about him; however, is that a hammer in his pocket?",
      Media = zmediaWrench
    })
    zitemHammer:MoveTo(zoneLandscaper)
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB17(action)
  if action == "Button1" then
    AlreadyspoketoDW = true
    Wherigo.MessageBox({
      Text = "\"Take a good look at his hand. It looks like he's pointing at something.\""
    })
  else
    Wherigo.MessageBox({
      Text = "\"Well, I thought it was important.... When can we get out of here...Fritz is getting hungry.\""
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB3(action)
  if action == "Button1" then
    zitemMagnifyingGlass:MoveTo(Player)
    Wherigo.MessageBox({
      Text = "This should come in handy.",
      Media = zmediaMagnifyer
    })
  else
    Wherigo.MessageBox({
      Text = "I'll get it later. I wouldn't want to get it dirty for nothing.",
      Media = zmediaMagnifyer
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB6(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = "As you confiscate the gun, the little girl begins to cry.",
      Media = zmediaGirlCrying,
      Buttons = {
        "Leave it",
        "Take it anyway"
      },
      Callback = cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB5
    })
  else
    Wherigo.MessageBox({
      Text = "The girl thanks you and tells you that she wants to be a cop when she grows up. You quickly search for a tissue before they see you crying.",
      Media = zmediaMotherDaughter
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB13(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = [[
Oh thank you very much. Her dad just gave her that...I guess he doesn't care about the violence aspect of that thing.<BR>
<BR>
The girl stops crying. "Thank You" she says. You can barely hold back the tears. ]],
      Media = zmediaGirlCrying
    })
    zitemGun:MoveTo(zcharacterMotherandChild)
  else
    Wherigo.MessageBox({
      Text = "The little girl is still sobbing over her confiscated toy. \"You're a mean police officer\" she says loudly.",
      Media = zmediaGirlCrying
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB7(action)
  if action == "Button1" and zcharacterMotherandChild:Contains(zitemGun) then
    Wherigo.MessageBox({
      Text = "Oh this? It's just a toy. See, the barrel is plastic.",
      Media = zmediaGun,
      Buttons = {"Take Gun", "Leave it"},
      Callback = cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB6
    })
  elseif action == "Button1" then
    Wherigo.MessageBox({
      Text = "You've got our toy gun. Are you going to give it back?",
      Media = zmediaGun,
      Buttons = {"Yes", "No"},
      Callback = cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB13
    })
  else
    Wherigo.MessageBox({
      Text = [[
I didn't see the victim. We got here just before the police arrived. They asked us to stay until the investigators got here.<BR>
<BR>
However, you know what's creepy, is that guy over there. I heard him say something about "Vigesimal" as we were entering the gate. He's been lurking around in the bushes and stuff. Why do you think he is lurking around this playground? The only kids here are mine. I don't feel safe.]],
      Media = zmediaGeocacherfromplayground
    })
    zoneGeocacher.Active = true
    zoneGeocacher.Visible = true
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB18(action)
  if action ~= nil then
    cartMurderintheOutfield.Complete = true
    ztaskFindtheculprit.Complete = true
    Wherigo.Dialog({
      {
        Text = "I predict some new caches popping up soon in San Quinten.",
        Media = zmediahandcuffs
      },
      {
        Text = [[
Special Thanks to...in order of appearance<BR>
<BR>
Dog walker: Ycats of Ycats &amp; Ekard<BR>
Dog: Fritz of Ycats &amp; Ekard<BR>
Dead body: cache_in_pocket<BR>
Baseball Player: Duck of DopeyDuck<BR>
Landscaper: cache_in_pocket<BR>
Mother: Dopey of DopeyDuck<BR>
Little Girl: LittleDuckling of DopeyDuck<BR>
Geocacher: Pacholik]],
        Media = zmediaMurderscene
      }
    })
    zitemGun:MoveTo(zcharacterMotherandChild)
    zcharacterDogWalker:MoveTo(nil)
    zitemAmmoCan.Commands.Examine.Enabled = false
    zoneGeocacher.Active = false
    zonePlayground.Active = false
    zoneLandscaper.Active = false
    zoneBaseballField.Active = false
    zoneCrimeScene.Active = false
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB15(action)
  if action ~= nil then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB9(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = [[
The landscaper looks a little nervous as you take a swab of blood and hand it to your assistant. The landscaper then tells you that the blood was his and he shows you a fresh wound on his shin. He claimed it slipped while he was pounding a piece of his lawn equipment into submission.<BR>
<BR>
Your blood sample will be ready to analyze shortly. It should be ready and available in your police car in a few minutes. You've got the best CSI guys money can buy; they'll have it ready after you've spoken with more people.]],
      Media = zmediadma
    })
    DNAProcessing = true
  else
    Wherigo.MessageBox({
      Text = "What a nice shiney hammer this has become. Now you just have to explain your bloody shirt sleeve to your significant other."
    })
    zitemHammer.Media = zmediaCleanHammer
    BloodyWrench = false
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB10(action)
  if action == "Button1" then
    Wherigo.GetInput(zinputFoundCache)
  else
    Wherigo.MessageBox({
      Text = [[
To Player: The original cache is long since gone, but a backup cache is located in the same spot. Look for a backup camo'd matchstick container attached to an irigation pipe on a 2 ft wire and hidden in a bush. It will have the key word you need to continue.<BR>
<BR>
No need to step on the bushes.]],
      Media = zmediaSpoiler
    })
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB14(action)
  if action ~= nil then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function cartMurderintheOutfield.MsgBoxCBFuncs.MsgBoxCB11(action)
  if action == "Button2" then
    Wherigo.MessageBox({
      Text = "If only there were some french fries...how much longer till lunch?"
    })
  else
    zitemDNA:MoveTo(zitemPolicecar)
    AmmoDna = true
    Wherigo.MessageBox({
      Text = "A swab has been taken. Results will be ready for you in your police car in a few minutes."
    })
  end
end
return cartMurderintheOutfield
