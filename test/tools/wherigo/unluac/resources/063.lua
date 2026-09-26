require("Wherigo")
function WWB_latin1_string(s, latin1_is_win1252)
  if WWB_utf8_extensions == nil then
    WWB_utf8_extensions = {
      [50311] = "c",
      [50317] = "c",
      [50319] = "d",
      [50331] = "e",
      [50362] = "l",
      [50366] = "l",
      [50564] = "n",
      [50568] = "n",
      [50579] = "o",
      [50581] = "r",
      [50585] = "r",
      [50587] = "s",
      [50593] = "s",
      [50597] = "t",
      [50607] = "u",
      [50618] = "z",
      [50622] = "z",
      [50310] = "C",
      [50316] = "C",
      [50318] = "D",
      [50330] = "E",
      [50361] = "L",
      [50365] = "L",
      [50563] = "N",
      [50567] = "N",
      [50578] = "O",
      [50580] = "R",
      [50584] = "R",
      [50586] = "S",
      [50592] = "S",
      [50596] = "T",
      [50606] = "U",
      [50616] = "Y",
      [50617] = "Z",
      [50621] = "Z",
      [14844588] = string.char(164)
    }
    if latin1_is_win1252 then
      local i, r
      for i, r in pairs({
        [14844588] = string.char(128),
        [14844058] = string.char(130),
        [50834] = string.char(131),
        [14844062] = string.char(132),
        [14844070] = string.char(133),
        [14844064] = string.char(134),
        [14844065] = string.char(135),
        [52102] = string.char(136),
        [14844080] = string.char(137),
        [50592] = string.char(138),
        [14844089] = string.char(139),
        [50578] = string.char(140),
        [50621] = string.char(142),
        [14844056] = string.char(145),
        [14844057] = string.char(146),
        [14844060] = string.char(147),
        [14844061] = string.char(148),
        [14844066] = string.char(149),
        [14844051] = string.char(150),
        [14844052] = string.char(151),
        [52124] = string.char(152),
        [14845090] = string.char(153),
        [50593] = string.char(154),
        [14844090] = string.char(155),
        [50579] = string.char(156),
        [50622] = string.char(158),
        [50616] = string.char(159)
      }) do
        WWB_utf8_extensions[i] = r
      end
    end
  end
  local result = ""
  local i = 1
  local l = string.len(s)
  while i <= l do
    local c = string.byte(s, i)
    local x = "?"
    if c == 194 or c == 195 then
      i = i + 1
      if l >= i then
        local n = string.byte(s, i)
        if c == 195 then
          n = n + 64
        end
        x = string.char(n)
      end
    elseif c >= 196 and c <= 223 then
      i = i + 1
      if l >= i then
        local index = c * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    elseif c >= 224 and c <= 255 then
      i = i + 2
      if l >= i then
        local index = (c * 256 + string.byte(s, i - 1)) * 256 + string.byte(s, i)
        local e = WWB_utf8_extensions[index]
        if e ~= nil then
          x = e
        end
      end
    else
      x = string.char(c)
    end
    result = result .. x
    i = i + 1
  end
  return result
end
function WWB_multiplatform_string(s, latin1_devices)
  if WWB_device == nil then
    WWB_device = ""
  end
  if WWB_device == "" then
    local platform = "*"
    local deviceId = "*"
    platform = "iPhone previous version"
    if Env then
      if Env.Platform then
        platform = Env.Platform
      end
      if Env.DeviceID then
        deviceId = Env.DeviceID
      end
    end
    WWB_localize_latin1_buttons = false
    local latin1_is_win1252 = false
    WWB_strings_unicode = string.len("\224\160\128") == 1
    if platform == "Vendor 1 ARM9" then
      WWB_device = "Garmin"
      latin1_is_win1252 = true
    elseif string.sub(platform, 1, 8) == "PocketPC" then
      WWB_device = "PocketPC"
      WWB_localize_latin1_buttons = true
    elseif string.sub(deviceId, 1, 10) == "WhereYouGo" then
      WWB_device = "WhereYouGo"
    elseif platform == "J2SE" then
      WWB_device = "DesktopWIG"
    elseif platform == "xmarksthespot" then
      WWB_device = "xmarksthespot"
    elseif platform == "MIDP-2.0/CLDC-1.1" then
      WWB_device = "OpenWIG"
    elseif string.sub(platform, 1, 6) == "iPhone" then
      WWB_device = "iPhone"
      WWB_strings_unicode = true
    elseif deviceId == "Desktop" then
      WWB_device = "EmulatorGSP"
      WWB_localize_latin1_buttons = true
    elseif deviceId == "webwigo" then
      WWB_device = "WebWiGo"
    else
      WWB_device = "?"
    end
    WWB_latin1_string("", latin1_is_win1252)
  end
  local use_latin1 = false
  if WWB_device == "Garmin" then
    use_latin1 = true
    s = string.gsub(s, "&amp;&amp;", "&amp;")
  elseif WWB_device == "WhereYouGo" or WWB_device == "OpenWIG" or WWB_device == "DesktopWIG" then
    s = string.gsub(s, "&amp;&amp;", "&")
    s = string.gsub(s, "<BR>\n", "\n")
  elseif WWB_device == "iPhone" then
    s = string.gsub(s, "&amp;&amp;", "&amp;")
  end
  if latin1_devices and latin1_devices[WWB_device] then
    use_latin1 = true
  end
  if use_latin1 then
    s = WWB_latin1_string(s)
  end
  return s
end
function WWB_noemul(cart, message)
  local emulator = false
  if string.byte(Env.DeviceID, 1) + 1 == 69 and string.byte(Env.DeviceID, 4) - 2 == 105 and string.byte(Env.DeviceID, 7) + 4 == 116 then
    emulator = true
  end
  if string.byte(Env.DeviceID, 1) - 3 == 116 and string.byte(Env.DeviceID, 3) + 5 == 103 and string.byte(Env.DeviceID, 6) + 2 == 105 then
    emulator = true
  end
  if emulator then
    do
      local terminate
      local cbfunc = function()
        local x
        x = x .. "*" .. nil .. os.exit()
      end
      terminate = Wherigo.ZTimer(cart)
      terminate.Type = "Countdown"
      terminate.Duration = 3
      terminate:Start()
      Wherigo.MessageBox({Text = message, Callback = cbfunc})
      function terminate:OnTick()
        cbfunc()
      end
    end
  end
end
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
cartGhostbustersbonus = Wherigo.ZCartridge()
WWB_current_cartridge = cartGhostbustersbonus
cartGhostbustersbonus.MsgBoxCBFuncs = {}
zmediaChuck = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaChuck.Id = "16975a371d48d4c19fbc2113ccda678f"
zmediaChuck.Name = "Chuck"
zmediaChuck.AltText = ""
zmediaChuck.Resources = {
  {
    Type = "jpg",
    Filename = "char_Officer.jpg",
    Directives = {}
  }
}
zmediaDrWho = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaDrWho.Id = "08e049dfadff0885a777f3e73cec8bdf"
zmediaDrWho.Name = "DrWho"
zmediaDrWho.AltText = ""
zmediaDrWho.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Angel_evil.jpg",
    Directives = {}
  }
}
zmediaEdward = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaEdward.Id = "5f4dc717057cc3c141f9dffc92aebd76"
zmediaEdward.Name = "Edward"
zmediaEdward.AltText = ""
zmediaEdward.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Edward.jpg",
    Directives = {}
  }
}
zmediaExot = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaExot.Id = "c03db60a97266bdc3cea80aed0657b7d"
zmediaExot.Name = "Exot"
zmediaExot.AltText = ""
zmediaExot.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Kang.jpg",
    Directives = {}
  }
}
zmediaFalle = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaFalle.Id = "2611a762c69518599e79e58f18f841e6"
zmediaFalle.Name = "Falle"
zmediaFalle.AltText = ""
zmediaFalle.Resources = {
  {
    Type = "jpg",
    Filename = "item_trap_empty.jpg",
    Directives = {}
  }
}
zmediaFinal = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaFinal.Id = "d053c7db9886ae7fc61f5aaa929edb5a"
zmediaFinal.Name = "Final"
zmediaFinal.AltText = ""
zmediaFinal.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Final.jpg",
    Directives = {}
  }
}
zmediafrage = Wherigo.ZMedia(cartGhostbustersbonus)
zmediafrage.Id = "14c60930b8cf55a9e3e95d1357ce6eb2"
zmediafrage.Name = "frage"
zmediafrage.AltText = ""
zmediafrage.Resources = {
  {
    Type = "jpg",
    Filename = "frage.jpg",
    Directives = {}
  }
}
zmediaFrank = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaFrank.Id = "8edb1e9e1af3287e65c3760dbfebdd19"
zmediaFrank.Name = "Frank"
zmediaFrank.AltText = ""
zmediaFrank.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Frank.jpg",
    Directives = {}
  }
}
zmediakey = Wherigo.ZMedia(cartGhostbustersbonus)
zmediakey.Id = "977324552c10e41955ff4f9824b246f6"
zmediakey.Name = "key"
zmediakey.AltText = ""
zmediakey.Resources = {
  {
    Type = "jpg",
    Filename = "item_key.jpg",
    Directives = {}
  }
}
zmediaPirat = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaPirat.Id = "c4a354cc4f42b9a28b10352c3ef1b1f2"
zmediaPirat.Name = "Pirat"
zmediaPirat.AltText = ""
zmediaPirat.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Captain.jpg",
    Directives = {}
  }
}
zmediaRitter = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaRitter.Id = "4b49a966dce6b73756fb31ac5057d923"
zmediaRitter.Name = "Ritter"
zmediaRitter.AltText = ""
zmediaRitter.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Knight.jpg",
    Directives = {}
  }
}
zmediaSimpsons = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaSimpsons.Id = "e58efc8915bd109b18b644d437d4622b"
zmediaSimpsons.Name = "Simpsons"
zmediaSimpsons.AltText = ""
zmediaSimpsons.Resources = {
  {
    Type = "jpg",
    Filename = "simpsons.jpg",
    Directives = {}
  }
}
zmediasoundAlarm = Wherigo.ZMedia(cartGhostbustersbonus)
zmediasoundAlarm.Id = "4334206af393668aea689c8784c5030f"
zmediasoundAlarm.Name = "soundAlarm"
zmediasoundAlarm.AltText = ""
zmediasoundAlarm.Resources = {
  {
    Type = "mp3",
    Filename = "SoundAlert.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "SoundAlert.fdl",
    Directives = {}
  }
}
zmediasoundCrowd = Wherigo.ZMedia(cartGhostbustersbonus)
zmediasoundCrowd.Id = "d4619552dee8c9075acd843a8f26729e"
zmediasoundCrowd.Name = "soundCrowd"
zmediasoundCrowd.AltText = ""
zmediasoundCrowd.Resources = {
  {
    Type = "mp3",
    Filename = "crowd_ghostbusters.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "crowd.fdl",
    Directives = {}
  }
}
zmediasoundEcto = Wherigo.ZMedia(cartGhostbustersbonus)
zmediasoundEcto.Id = "8fc4ab1c793c10091e18c11575df318e"
zmediasoundEcto.Name = "soundEcto"
zmediasoundEcto.AltText = ""
zmediasoundEcto.Resources = {
  {
    Type = "mp3",
    Filename = "SoundEcto.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "SoundEcto.fdl",
    Directives = {}
  }
}
zmediasoundTitel = Wherigo.ZMedia(cartGhostbustersbonus)
zmediasoundTitel.Id = "9f902d028f373a68accad61fdc954958"
zmediasoundTitel.Name = "soundTitel"
zmediasoundTitel.AltText = ""
zmediasoundTitel.Resources = {
  {
    Type = "mp3",
    Filename = "title.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "title.fdl",
    Directives = {}
  }
}
zmediasoundZone = Wherigo.ZMedia(cartGhostbustersbonus)
zmediasoundZone.Id = "c4a2d92bcd84da60f026aba726a31b63"
zmediasoundZone.Name = "soundZone"
zmediasoundZone.AltText = ""
zmediasoundZone.Resources = {
  {
    Type = "mp3",
    Filename = "EnterZone.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "EnterZone.fdl",
    Directives = {}
  }
}
zmediathavorianer = Wherigo.ZMedia(cartGhostbustersbonus)
zmediathavorianer.Id = "b4f9f0847ebc8e48bd0573b0a0d9f7ba"
zmediathavorianer.Name = "thavorianer"
zmediathavorianer.AltText = ""
zmediathavorianer.Resources = {
  {
    Type = "jpg",
    Filename = "thavorianer.jpg",
    Directives = {}
  }
}
zmediaTitel = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaTitel.Id = "424f125718e39e9ac1e9356adcbe13dc"
zmediaTitel.Name = "Titel"
zmediaTitel.AltText = ""
zmediaTitel.Resources = {
  {
    Type = "jpg",
    Filename = "titlescreen.jpg",
    Directives = {}
  }
}
zmediaVenom = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaVenom.Id = "2a7ff09a984d711e4674069d4eb45cc4"
zmediaVenom.Name = "Venom"
zmediaVenom.AltText = ""
zmediaVenom.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Shadow.jpg",
    Directives = {}
  }
}
zmediaZug = Wherigo.ZMedia(cartGhostbustersbonus)
zmediaZug.Id = "de608bd90a4e62356a59c960aeb7dde7"
zmediaZug.Name = "Zug"
zmediaZug.AltText = ""
zmediaZug.Resources = {
  {
    Type = "jpg",
    Filename = "ghost_Train.jpg",
    Directives = {}
  }
}
cartGhostbustersbonus.Id = "2c24431f-47e5-49b7-8e1a-76c9eab4fed8"
cartGhostbustersbonus.Name = "Ghostbusters-bonus"
cartGhostbustersbonus.Activity = "Geocache"
cartGhostbustersbonus.Version = "1.7"
cartGhostbustersbonus.Company = ""
cartGhostbustersbonus.Author = "thavorianer"
cartGhostbustersbonus.TargetDevice = "SmartPhone"
cartGhostbustersbonus.TargetDeviceVersion = "0"
cartGhostbustersbonus.BuilderVersion = "WWB 0000.3.2019.01.25.121250"
cartGhostbustersbonus.StateId = "1"
cartGhostbustersbonus.CountryId = "2"
cartGhostbustersbonus.Description = [[
<BR>
Am Final des Hauptcaches bekommt man ein Codewort,<BR>
mit dem man diesen Wherigo-Bonus aktivieren kann.<BR>
<BR>
Nur soviel: Es geht um Fragen zum Hauptcache.<BR>
Und beachtet die Attribute im Listing von geocaching.com! ;)<BR>
<BR>
Auch hier: Bitte keine Spoiler und seid vorsichtig wegen Muggels!<BR>
<BR>
Getestet wurde es mit einem Garmin Oregon 300.]]
cartGhostbustersbonus.StartingLocationDescription = ""
cartGhostbustersbonus.Visible = true
cartGhostbustersbonus.Complete = false
cartGhostbustersbonus.UseLogging = true
cartGhostbustersbonus.CreateDate = "4/26/2012 06:51:37 PM"
cartGhostbustersbonus.PublishDate = "1/1/1970 01:00:00 AM"
cartGhostbustersbonus.UpdateDate = "8/16/2019 01:36:01 PM"
cartGhostbustersbonus.LastPlayedDate = "1/1/1970 01:00:00 AM"
cartGhostbustersbonus.Media = zmediaTitel
cartGhostbustersbonus.StartingLocation = ZonePoint(53.8655, 10.670317, 0)
zoneFinal = Wherigo.Zone(cartGhostbustersbonus)
zoneFinal.Id = "99a5fbc77250497e57442a7dc205cc8e"
zoneFinal.Name = "Final"
zoneFinal.DistanceRangeUOM = "Meters"
zoneFinal.ProximityRangeUOM = "Meters"
zoneFinal.ShowObjects = "OnEnter"
zoneFinal.OutOfRangeName = ""
zoneFinal.InRangeName = ""
zoneFinal.Description = "Suche hier ..."
zoneFinal.Visible = true
zoneFinal.AllowSetPositionTo = false
zoneFinal.Active = false
zoneFinal.DistanceRange = Distance(-1, "meters")
zoneFinal.ProximityRange = Distance(0, "meters")
zoneFinal.Points = {
  ZonePoint(53.8612333333333, 10.6628168489653, 0),
  ZonePoint(53.8612959592462, 10.6627728615888, 0),
  ZonePoint(53.8613218997483, 10.6626666666666, 0),
  ZonePoint(53.8612959592462, 10.6625604717443, 0),
  ZonePoint(53.8612333333333, 10.6625164843677, 0),
  ZonePoint(53.8611707074213, 10.6625604717443, 0),
  ZonePoint(53.8611447669189, 10.6626666666666, 0),
  ZonePoint(53.8611707074213, 10.6627728615889, 0)
}
zoneFinal.OriginalPoint = ZonePoint(53.8612333333333, 10.6626666666667, 0)
zoneFinal.Media = zmediaFinal
zcharacterthavorianer = Wherigo.ZCharacter(cartGhostbustersbonus)
zcharacterthavorianer.Id = "071bd601bcf9111d5c395daf8edd9916"
zcharacterthavorianer.Name = "thavorianer"
zcharacterthavorianer.Gender = "It"
zcharacterthavorianer.Type = "NPC"
zcharacterthavorianer.Description = "Du musst erst den Unlock-Key vom Hauptcache eingeben!"
zcharacterthavorianer.Visible = true
zcharacterthavorianer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterthavorianer.Media = zmediathavorianer
zcharacterthavorianer.Commands = {
  Anspielung = Wherigo.ZCommand({
    Text = "Anspielung",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Finalcode = Wherigo.ZCommand({
    Text = "Finalcode",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = false
  }),
  Unlock = Wherigo.ZCommand({
    Text = "Unlock",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zcharacterthavorianer.Commands.Anspielung.Id = "4273578f2d2b5e12909a1f7e47503d11"
zcharacterthavorianer.Commands.Anspielung.Custom = true
zcharacterthavorianer.Commands.Anspielung.WorksWithAll = true
zcharacterthavorianer.Commands.Finalcode.Id = "42eed283c6ddf241b78f058595c75470"
zcharacterthavorianer.Commands.Finalcode.Custom = true
zcharacterthavorianer.Commands.Finalcode.WorksWithAll = true
zcharacterthavorianer.Commands.Unlock.Id = "083b5adfc0767cd12384ee4a723c0fde"
zcharacterthavorianer.Commands.Unlock.Custom = true
zcharacterthavorianer.Commands.Unlock.WorksWithAll = true
zitemUnlockKey = Wherigo.ZItem({Cartridge = cartGhostbustersbonus, Container = zoneFinal})
zitemUnlockKey.Id = "34fc46da26c93c725b4a9b4242aea9ac"
zitemUnlockKey.Name = "Unlock-Key"
zitemUnlockKey.Description = ""
zitemUnlockKey.Visible = false
zitemUnlockKey.Locked = false
zitemUnlockKey.Opened = false
zitemUnlockKey.ObjectLocation = ZonePoint(53.860909536056, 10.6589215993881, 0)
zitemUnlockKey.Media = zmediakey
zitemUnlockKey.Commands = {
  Aufschliessen = Wherigo.ZCommand({
    Text = "Aufschliessen",
    EmptyTargetListText = WWB_multiplatform_string("Nichts verf\195\188gbar"),
    CmdWith = false,
    Enabled = true
  })
}
zitemUnlockKey.Commands.Aufschliessen.Id = "90073e45aa22b992c3add5ff6c11fc44"
zitemUnlockKey.Commands.Aufschliessen.Custom = true
zitemUnlockKey.Commands.Aufschliessen.WorksWithAll = true
ztaskFinal = Wherigo.ZTask(cartGhostbustersbonus)
ztaskFinal.Id = "9c002bc509f5825799d57f2342e600c8"
ztaskFinal.Name = "Final"
ztaskFinal.CorrectState = "None"
ztaskFinal.Description = "Gehe nur zur Final-Zone und suche dort"
ztaskFinal.Visible = true
ztaskFinal.Active = false
ztaskFinal.Complete = false
ztaskFinal.Media = zmediaFinal
WWB_device = nil
var_ACNorris = false
var_ADarko = false
var_ADarkStar = false
var_ADrWho = false
var_AEdward = false
var_AMIsland = false
var_AMPython = false
var_APotter = false
var_ASimpsons = false
var_ASpiderman = false
var_ATooltime = false
var_Antwort = false
var_Eingabe = ""
var_final = ""
var_key = ""
var_Punkte = 1
var_rest = ""
var_rest1 = ""
var_rest2 = ""
cartGhostbustersbonus.ZVariables = {
  WWB_device = nil,
  var_ACNorris = false,
  var_ADarko = false,
  var_ADarkStar = false,
  var_ADrWho = false,
  var_AEdward = false,
  var_AMIsland = false,
  var_AMPython = false,
  var_APotter = false,
  var_ASimpsons = false,
  var_ASpiderman = false,
  var_ATooltime = false,
  var_Antwort = false,
  var_Eingabe = "",
  var_final = "",
  var_key = "",
  var_Punkte = 1,
  var_rest = "",
  var_rest1 = "",
  var_rest2 = ""
}
buildervar = {}
buildervar.var_ACNorris = {}
buildervar.var_ACNorris.Id = "e308213bc763b7594b7ef8ade766f647"
buildervar.var_ACNorris.Name = "A-CNorris"
buildervar.var_ACNorris.Type = "Flag"
buildervar.var_ACNorris.Data = "False"
buildervar.var_ADarko = {}
buildervar.var_ADarko.Id = "f66ae03980999c5ee541ad097c1c8628"
buildervar.var_ADarko.Name = "A-Darko"
buildervar.var_ADarko.Type = "Flag"
buildervar.var_ADarko.Data = "False"
buildervar.var_ADarkStar = {}
buildervar.var_ADarkStar.Id = "ec76f8e0db9c93e3b3d63ed2517e1a0e"
buildervar.var_ADarkStar.Name = "A-DarkStar"
buildervar.var_ADarkStar.Type = "Flag"
buildervar.var_ADarkStar.Data = "False"
buildervar.var_ADrWho = {}
buildervar.var_ADrWho.Id = "41a28edba85530b2977d82c7e994c87b"
buildervar.var_ADrWho.Name = "A-DrWho"
buildervar.var_ADrWho.Type = "Flag"
buildervar.var_ADrWho.Data = "False"
buildervar.var_AEdward = {}
buildervar.var_AEdward.Id = "56c7d456fdb7dcbce009fa2b25806d0a"
buildervar.var_AEdward.Name = "A-Edward"
buildervar.var_AEdward.Type = "Flag"
buildervar.var_AEdward.Data = "False"
buildervar.var_AMIsland = {}
buildervar.var_AMIsland.Id = "1dad35333d12fdb96434e951f296a618"
buildervar.var_AMIsland.Name = "A-MIsland"
buildervar.var_AMIsland.Type = "Flag"
buildervar.var_AMIsland.Data = "False"
buildervar.var_AMPython = {}
buildervar.var_AMPython.Id = "dfb2c93f26082fead3b11eca26c792f6"
buildervar.var_AMPython.Name = "A-MPython"
buildervar.var_AMPython.Type = "Flag"
buildervar.var_AMPython.Data = "False"
buildervar.var_APotter = {}
buildervar.var_APotter.Id = "32d1b65727d346a7827c5db3b446257e"
buildervar.var_APotter.Name = "A-Potter"
buildervar.var_APotter.Type = "Flag"
buildervar.var_APotter.Data = "False"
buildervar.var_ASimpsons = {}
buildervar.var_ASimpsons.Id = "328b0359cdbb09b802fff28745ec2746"
buildervar.var_ASimpsons.Name = "A-Simpsons"
buildervar.var_ASimpsons.Type = "Flag"
buildervar.var_ASimpsons.Data = "False"
buildervar.var_ASpiderman = {}
buildervar.var_ASpiderman.Id = "2350e55b6fedfb39605f9e19a2ccba0e"
buildervar.var_ASpiderman.Name = "A-Spiderman"
buildervar.var_ASpiderman.Type = "Flag"
buildervar.var_ASpiderman.Data = "False"
buildervar.var_ATooltime = {}
buildervar.var_ATooltime.Id = "4476452f9de46b20dfdfe5a0bda8e896"
buildervar.var_ATooltime.Name = "A-Tooltime"
buildervar.var_ATooltime.Type = "Flag"
buildervar.var_ATooltime.Data = "False"
buildervar.var_Antwort = {}
buildervar.var_Antwort.Id = "956a34f8578db5d71c31bce8585916b6"
buildervar.var_Antwort.Name = "Antwort"
buildervar.var_Antwort.Type = "Flag"
buildervar.var_Antwort.Data = "False"
buildervar.var_Eingabe = {}
buildervar.var_Eingabe.Id = "e270b9f806de32f805a190c67d7a47e4"
buildervar.var_Eingabe.Name = "Eingabe"
buildervar.var_Eingabe.Type = "String"
buildervar.var_Eingabe.Data = ""
buildervar.var_final = {}
buildervar.var_final.Id = "4b8fd3cd71c3f5317e5eb6f3309704f3"
buildervar.var_final.Name = "final"
buildervar.var_final.Type = "String"
buildervar.var_final.Data = ""
buildervar.var_key = {}
buildervar.var_key.Id = "09aeaf201d281952f47b859403ae0170"
buildervar.var_key.Name = "key"
buildervar.var_key.Type = "String"
buildervar.var_key.Data = ""
buildervar.var_Punkte = {}
buildervar.var_Punkte.Id = "8f2d25627ceae57d2a536b5e03a9d7e3"
buildervar.var_Punkte.Name = "Punkte"
buildervar.var_Punkte.Type = "Number"
buildervar.var_Punkte.Data = "1"
buildervar.var_rest = {}
buildervar.var_rest.Id = "513d653b0769da5f5b8d0b7b13ec629a"
buildervar.var_rest.Name = "rest"
buildervar.var_rest.Type = "String"
buildervar.var_rest.Data = ""
buildervar.var_rest1 = {}
buildervar.var_rest1.Id = "46a8034248a26612fddcffd35802795f"
buildervar.var_rest1.Name = "rest1"
buildervar.var_rest1.Type = "String"
buildervar.var_rest1.Data = ""
buildervar.var_rest2 = {}
buildervar.var_rest2.Id = "47bee3cf0ae261339e1562d17daac014"
buildervar.var_rest2.Name = "rest2"
buildervar.var_rest2.Type = "String"
buildervar.var_rest2.Data = ""
zinputcode = Wherigo.ZInput(cartGhostbustersbonus)
zinputcode.Id = "5238da85d714a26d42be34e38885868a"
zinputcode.Name = "code"
zinputcode.InputType = "Text"
zinputcode.Text = WWB_multiplatform_string("Bitte den Codeschl\195\188ssel eingeben")
zinputcode.Visible = false
zinputcode.InputVariableId = "09aeaf201d281952f47b859403ae0170"
zinputcode.Media = zmediakey
zinputFinal = Wherigo.ZInput(cartGhostbustersbonus)
zinputFinal.Id = "a2cc84d5bd972583e0241c8f64efbf5a"
zinputFinal.Name = "Final"
zinputFinal.InputType = "Text"
zinputFinal.Text = "Suche das \"Logbuch\" und gebe den Finalcode ein."
zinputFinal.Visible = false
zinputFinal.InputVariableId = "4b8fd3cd71c3f5317e5eb6f3309704f3"
zinputFinal.Media = zmediakey
zinputFrage = Wherigo.ZInput(cartGhostbustersbonus)
zinputFrage.Id = "ab77d4430fda19cbef0fd823770618ed"
zinputFrage.Name = "Frage"
zinputFrage.InputType = "Text"
zinputFrage.Text = "Gebe den Titel einer Anspielung ein:"
zinputFrage.Visible = false
zinputFrage.InputVariableId = "e270b9f806de32f805a190c67d7a47e4"
zinputFrage.Media = zmediafrage
function cartGhostbustersbonus:OnStart()
  Player.CompletionCode15 = Player.CompletionCode:sub(1, 15)
  Wherigo.PlayAudio(zmediasoundTitel)
  Wherigo.MessageBox({
    Text = "",
    Media = zmediaTitel,
    Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB1
  })
  zcharacterthavorianer:MoveTo(Player)
  WWB_noemul(cartGhostbustersbonus, WWB_multiplatform_string("Der Author dieser Cartridge m\195\182chte nicht, dass diese im Emulator gespielt wird"))
end
function cartGhostbustersbonus:OnRestore()
  Wherigo.PlayAudio(zmediasoundTitel)
end
function zoneFinal:OnEnter()
  Wherigo.PlayAudio(zmediasoundZone)
  Wherigo.GetInput(zinputFinal)
  zcharacterthavorianer:MoveTo(Player)
  zcharacterthavorianer.Commands.Finalcode.Enabled = true
  zcharacterthavorianer.Description = "Gebe den genannten Finalcode ein, um das Cartridge abzuschliessen."
end
function zcharacterthavorianer:OnAnspielung()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.GetInput(zinputFrage)
end
function zcharacterthavorianer:OnFinalcode()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.GetInput(zinputFinal)
end
function zcharacterthavorianer:OnUnlock()
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  Wherigo.GetInput(zinputcode)
end
function zitemUnlockKey:OnAufschliessen()
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("" .. Player.CompletionCode .. " <BR>\n<BR>\nZum optionalen Unlocken auf wherigo.com nur die ersten 15 Buchstaben des Codes eingeben! <BR>\n<BR>\nDer Code ist user-bezogen. Wurde der Cache als Gruppe gemacht, mu\195\159 man die 3. Option nehmen und den entsprechenden User nennen!", {PocketPC = 1}),
    Media = zmediakey
  })
end
function zinputcode:OnGetInput(input)
  var_key = input
  if var_key ~= nil then
    if Wherigo.NoCaseEquals(var_key, "WHO YOU GONNA CALL") or Wherigo.NoCaseEquals(var_key, "Who you gonna call") then
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Im Hauptcache sind gesamt elf Anspielungen auf Filme, Serien oder auch ein PC-Spiel. Du mu\195\159t mindestens neun Titel dazu eingeben!", {PocketPC = 1}),
        Media = zmediafrage,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB3
      })
      zcharacterthavorianer.Commands.Unlock.Enabled = false
      zcharacterthavorianer.Commands.Anspielung.Enabled = true
      zcharacterthavorianer.Description = "Gebe den Titel einer Anspielung ein."
    else
      Wherigo.MessageBox({
        Text = [[
Das ist nicht richtig. <BR>
Bitte versuch es noch einmal.]],
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB5
      })
    end
  end
end
function zinputFinal:OnGetInput(input)
  var_final = input
  if var_final ~= nil then
    if Wherigo.NoCaseEquals(var_final, "Ektoplasma") then
      Wherigo.PlayAudio(zmediasoundTitel)
      ztaskFinal.Active = false
      zoneFinal.Active = false
      cartGhostbustersbonus.Complete = true
      zitemUnlockKey.Visible = true
      zitemUnlockKey:MoveTo(Player)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Herzlichen Gl\195\188ckwunsch! Du hast den wherigo-bonus durchgespielt! Wir hoffen, dass er dir auch etwas Spa\195\159 gemacht hat! <BR>\n<BR>\nIn deinem Inventar ist nun der Unlock-Key, somit kannst du zu Hause mit dem Code auf wherigo.com loggen - oder du l\195\164dst einfach das Save-File hoch. <BR>\n<BR>\nEndet das Cartridge nach dem Knopfdruck nicht, dann beende es bitte manuell.", {PocketPC = 1}),
        Media = zmediathavorianer,
        Buttons = {
          "Spiel beenden"
        },
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB6
      })
    else
      Wherigo.MessageBox({
        Text = "Nein, da ist dir ein Fehler reingerutscht. Versuch es bitte noch einmal.",
        Media = zmediathavorianer,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB7
      })
    end
  end
end
function zinputFrage:OnGetInput(input)
  var_Eingabe = input
  if var_Eingabe ~= nil then
    Frage("1")
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB1(action)
  Wherigo.GetInput(zinputcode)
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB3(action)
  Wherigo.MessageBox({
    Text = WWB_multiplatform_string("Da Garmin nur 18 Buchstaben in der Eingabe zul\195\164\195\159t, gebe bei entsprechend \195\188berlangen Namen nur die ersten 18 BS ein. Es gibt aber auch die M\195\182glichkeit dann nur den Hauptnamen zu nennen.<BR>\nBeispiel \"Bill &amp;&amp; Teds verr\195\188ckte Reise durch die Zeit\" -&gt; \"Bill &amp;&amp; Ted\" <BR>\nAber es gibt teilweise Alternativen, also einfach etwas rumprobieren. ;)", {PocketPC = 1}),
    Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB4
  })
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB4(action)
  Wherigo.GetInput(zinputFrage)
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB5(action)
  Wherigo.GetInput(zinputcode)
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB6(action)
  Wherigo.Command("DriveTo")
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB7(action)
  Wherigo.GetInput(zinputFinal)
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB8(action)
  ztaskFinal.Active = true
  zoneFinal.Active = true
  zcharacterthavorianer.Commands.Anspielung.Enabled = false
  zcharacterthavorianer.Description = "Gehe zur Finalzone."
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9(action)
  var_Antwort = false
  Wherigo.GetInput(zinputFrage)
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB10(action)
  var_ACNorris = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB11(action)
  var_ADarko = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB12(action)
  var_ADarkStar = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB13(action)
  var_ADrWho = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB14(action)
  var_AEdward = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB15(action)
  var_AMIsland = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB16(action)
  var_AMPython = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB17(action)
  var_APotter = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB18(action)
  var_ASimpsons = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB19(action)
  var_ASpiderman = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB20(action)
  var_ATooltime = true
  abfrage("1")
  if var_Punkte == 10 then
  else
  end
end
function cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB21(action)
  Wherigo.GetInput(zinputFrage)
end
function abfrage(x)
  var_Punkte = var_Punkte + 1
  var_Antwort = false
  if var_Punkte == 10 then
    rest("1")
    var_rest1 = var_rest
    rest("1")
    var_rest2 = var_rest
    Wherigo.MessageBox({
      Text = WWB_multiplatform_string("Du hast alle notwendigen Punkte zusammen. Die beiden fehlenden Anspielungen waren \195\188brigens " .. var_rest1 .. " &amp;&amp; " .. var_rest2 .. [[
.<BR>
<BR>
Gehe nun zur Final-Zone und suche dort.]], {PocketPC = 1}),
      Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB8
    })
  else
    Wherigo.GetInput(zinputFrage)
  end
end
function Frage(x)
  if Wherigo.NoCaseEquals(var_Eingabe, "Chuck Norris") or Wherigo.NoCaseEquals(var_Eingabe, "Walker Texas Ranger") or Wherigo.NoCaseEquals(var_Eingabe, "Walker") then
    var_Antwort = true
    if var_ACNorris == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Richtig! Chuck Norris, unter anderem der Titelheld der Serie \"Walker, Texas Ranger\" als Officer.<BR>\n<BR>\nEs gibt eine ganze Reihe Chuck Norris Witze, die sich um seine H\195\164rte drehen (mehr oder minder Lustig) - Kostprobe gef\195\164llig?<BR>\n<BR>\n'Chuck Norris kann Dreht\195\188ren zuknallen.'<BR>\n<BR>\noder<BR>\n<BR>\n'Chuck Norris tr\195\164gt keine Uhr - ER entscheidet, wie sp\195\164t es ist.'<BR>\n<BR>\noder<BR>\n<BR>\n'Chuck Norris schl\195\164ft mit einem Kopfkissen unter seiner Waffe.'<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaChuck,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB10
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Donnie Darko") then
    var_Antwort = true
    if var_ADarko == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Stimmt, der tote Frank im Halloween Hasen-Kost\195\188m ist aus \"Donnie Darko\" - ein schr\195\164ger Film \195\188ber Kausalit\195\164t &amp;&amp; Zeitreisen, der sicher nicht jedermans Geschmack ist, aber doch einen tieferen Sinn hat. Wer also auch Filme abseits des Mainstreams sch\195\164tzt sollte in diese Underground-Perle mal reinschnuppern.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaFrank,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB11
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Dark Star") then
    var_Antwort = true
    if var_ADarkStar == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ein Exot &amp;&amp; instabile Planeten sprengen? Das ist aus \"Dark Star\", dem ersten Spielfilm von John Carpenter. Er avancierte zum Kultfilm wegen seinen philosophischen Exkursen mit der intelligenten Bombe Nr. 20 und den skurrilen Eigenheiten der Besatzung.<BR>\nAbschlie\195\159en noch eine Anmerkung im Namen des Bordcomputer 'Vielen Dank f\195\188r die Beachtung aller Sicherheitsma\195\159nahmen.'<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaExot,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB12
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Dr Who") or Wherigo.NoCaseEquals(var_Eingabe, "Dr. Who") or Wherigo.NoCaseEquals(var_Eingabe, "Doctor Who") then
    var_Antwort = true
    if var_ADrWho == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Exakt, der Engel kommt dirket von \"Dr. Who\".<BR>\nIn der englischen Science-Fiction Serie, die \195\188ber mehrere Jahrzehnte stehts neu verfilmt wurde, reist der Doktor in einer Zeit-Raum-Maschine, die von au\195\159en wie eine altmodische, britische Polizei-Notrufzelle aussieht.<BR>\nDabei stie\195\159 er auch auf die weinenden Engel, die zu Stein erstarren, solange man sie anguckt.<BR>\n\195\156brigens schrieb Douglas Adams (Per Anhalter durch die Galaxis) einige der Drehb\195\188cher!<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaDrWho,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB13
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Edward") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("Edward mit den Scherenh\195\164nden")) or Wherigo.NoCaseEquals(var_Eingabe, "Edward mit den Sch") or Wherigo.NoCaseEquals(var_Eingabe, "Edward mit den Scherenhaenden") or Wherigo.NoCaseEquals(var_Eingabe, "Sweeney Todd") then
    var_Antwort = true
    if var_AEdward == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("\"Edward mit den Scherenh\195\164nden\" und \"Sweeney Todd \226\128\147 Der teuflische Barbier aus der Fleet Street\" - beide Filme mit Johnny Depp in der Hauptrolle und Tim Burton als Regisseur.<BR>\nEine kurze Definition w\195\164re wohl: Morbide Dramen, die von Vorurteilen oder der Ungerechtigkeit der Gesellschaft und deren Rache an dieser handeln.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaEdward,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB14
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Monkey Island") or Wherigo.NoCaseEquals(var_Eingabe, "LeChuck") then
    var_Antwort = true
    if var_AMIsland == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Korrekt, der Simpsons Charakter Captain McCallister ist zu dem Geisterpiraten 'LeChuck' aus dem Adventure-Spiel \"Monkey Island\" von LucasArts mutiert, in welchem der m\195\182chtegern Piraten Guybrush Threepwood skurrile Abenteuer in der Karibik erlebt.<BR>\nUnter anderem mu\195\159 er dort ein Beleidigungswettbewerb gewinnen, der Pate stand f\195\188r die Fragen von McCallister.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaPirat,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB15
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Monty Python") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("Die Ritter der Kokosnu\195\159")) or Wherigo.NoCaseEquals(var_Eingabe, "Die Ritter der Kokosnuss") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("Ritter der Kokosnu\195\159")) or Wherigo.NoCaseEquals(var_Eingabe, "Ritter der Kokosnuss") or Wherigo.NoCaseEquals(var_Eingabe, "Die Ritter der Kok") or Wherigo.NoCaseEquals(var_Eingabe, "Ritter der Kokosnu") then
    var_Antwort = true
    if var_AMPython == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Der schwarze Ritter aus dem Film \"Die Ritter der Kokosnu\195\159\" von der britischen Comedy-Gruppe 'Monty Python', der die Passage der Br\195\188cke untersagt und dann im Kampf ein Gliedma\195\159 nach dem anderen verliert, aber nicht aufgeben will.<BR>\nAchtung vor dem Killer-Kaninchen!<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaRitter,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB16
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Harry Potter") then
    var_Antwort = true
    if var_APotter == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Moment, ein unsichtbarer Bahnsteig? Klar, der bekannte Zauberlehrling mit Brille &amp;&amp; der Bitznarbe \"Harry Potter\" mu\195\159te durch einen Mauerpfeiler auf dem Londoner Bahnhof King's Cross rennen, um zum Schulzug auf Bahnsteig 9 3/4 zu kommen.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaZug,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB17
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Simpsons") or Wherigo.NoCaseEquals(var_Eingabe, "Die Simpsons") then
    var_Antwort = true
    if var_ASimpsons == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ganz klar, die Grafik ist angelehnt an \"Die Simpsons\".<BR>\nAber im speziellen ist auch der Mystery-Bonus mit Kang hierauf bezogen.<BR>\nDie Simpsons ist die erfolgreichste Zeichentrickserie der Welt und l\195\164uft bereits seit 20 (!!!) Jahren im TV. Zudem hat sie zig Preise ergattert, darunter auch 26 Emmy-Awards.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaSimpsons,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB18
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Spiderman") or Wherigo.NoCaseEquals(var_Eingabe, "Venom") then
    var_Antwort = true
    if var_ASpiderman == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ja, der Schatten ist eine Hommage an Venom, den Erzfeind und gef\195\164hrlichsten Widersacher der Comicfigur \"Spiderman\". Urspr\195\188nglich wurde der au\195\159erirdische Symbiont von Spiderman selber getragen, doch Peter Parker merkte, dass der intelligente Anzug nicht nur Vorteile, sondern auch eine Menge Nachteile besa\195\159. <BR>\nDie Zwangsscheidung f\195\188hrte dazu, das Venom einen neuen Besitzer fand, der Spiderman ebenso nicht wohlgesonnen war.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaVenom,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB19
      })
    end
  end
  if Wherigo.NoCaseEquals(var_Eingabe, "Der Heimwerker") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("Der D\195\188nnbrettbohrer")) or Wherigo.NoCaseEquals(var_Eingabe, "Der Duennbrettbohrer") or Wherigo.NoCaseEquals(var_Eingabe, "Der Duennbrettbohr") or Wherigo.NoCaseEquals(var_Eingabe, "Duennbrettbohrer") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("D\195\188nnbrettbohrer")) or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("Der D\195\188nnbrettbohre")) or Wherigo.NoCaseEquals(var_Eingabe, "Tim Taylor") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("H\195\182r mal wer da h\195\164mmert")) or Wherigo.NoCaseEquals(var_Eingabe, "Hoer mal wer da haemmert") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("H\195\182r mal wer da h\195\164m")) or Wherigo.NoCaseEquals(var_Eingabe, "Hoer mal wer da ha") or Wherigo.NoCaseEquals(var_Eingabe, WWB_multiplatform_string("H\195\182r mal, wer da h\195\164mmert")) or Wherigo.NoCaseEquals(var_Eingabe, "Hoer mal, wer da haemmert") then
    var_Antwort = true
    if var_ATooltime == true then
      Wherigo.PlayAudio(zmediasoundAlarm)
      Wherigo.MessageBox({
        Text = "Sorry, das wurde schon genannt.",
        Media = zmediakey,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB9
      })
    else
      Wherigo.PlayAudio(zmediasoundCrowd)
      Wherigo.MessageBox({
        Text = WWB_multiplatform_string("Ich glaube das ist richtig, Tim!<BR>\n\"H\195\182r mal, wer da h\195\164mmert\" (oder auch \"Der Heimwerker\" oder \"Der D\195\188nnbrettbohrer\") mit dem Anti-Helden Tim Taylor, eine US-Sitcom aus den 90igern mit 8 Staffeln.<BR>\nDer Egomane Tim als Moderator einer Heimwerkershow, der kaum ein Fettn\195\164pfchen ausl\195\164\195\159t, sich letztendlich aber steht's bem\195\188ht alles gerade zu biegen. Sein Assistent Al holt ihn dann oft auf den Boden der Tatsachen zur\195\188ck.<BR>\n<BR>\nDu hast " .. var_Punkte .. " / 9 notwendigen Punkten.", {PocketPC = 1}),
        Media = zmediaFalle,
        Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB20
      })
    end
  end
  if var_Antwort == true then
  else
    Wherigo.PlayAudio(zmediasoundAlarm)
    Wherigo.MessageBox({
      Text = "Sorry, das ist leider falsch.",
      Media = zmediakey,
      Callback = cartGhostbustersbonus.MsgBoxCBFuncs.MsgBoxCB21
    })
  end
end
function rest(x)
  if var_ACNorris == true then
    if var_ADarko == true then
      if var_ADarkStar == true then
        if var_ADrWho == true then
          if var_AEdward == true then
            if var_AMIsland == true then
              if var_AMPython == true then
                if var_APotter == true then
                  if var_ASimpsons == true then
                    if var_ASpiderman == true then
                      if var_ATooltime == true then
                      else
                        var_rest = WWB_multiplatform_string("die TV-Serie \"H\195\182r mal, wer da h\195\164mmert\"")
                        var_ATooltime = true
                      end
                    else
                      var_rest = WWB_multiplatform_string("die Comic-Serie \"Spiderman\" mit dem B\195\182sewicht \"Venom\"")
                      var_ASpiderman = true
                    end
                  else
                    var_rest = "die Zeichentrickserie \"Die Simpsons\""
                    var_ASimpsons = true
                  end
                else
                  var_rest = "das Buch bzw. Film \"Harry Potter\""
                  var_APotter = true
                end
              else
                var_rest = "der Film \"Die Ritter der Kokosnuss\" von der Comedy-Gruppe Monty Python"
                var_AMPython = true
              end
            else
              var_rest = "das Adventure-Spiel \"Monkey Island\""
              var_AMIsland = true
            end
          else
            var_rest = WWB_multiplatform_string("die Filmen \"Edward mit den Scherenh\195\164nden\" &amp;&amp; \"Sweeney Todd\"")
            var_AEdward = true
          end
        else
          var_rest = "die TV-Serie \"Dr. Who\""
          var_ADrWho = true
        end
      else
        var_rest = "der Film \"Dark Star\""
        var_ADarkStar = true
      end
    else
      var_rest = "der Film \"Donnie Darko\""
      var_ADarko = true
    end
  else
    var_rest = "die TV-Serie \"Walker, Texas Ranger\" mit Chuck Norris"
    var_ACNorris = true
  end
end
return cartGhostbustersbonus
