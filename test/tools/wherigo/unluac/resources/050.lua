require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _s95(str)
  local res = ""
  local dtable = "\029{T\024`/\023:\nS!D\016K5\\\017-;MO\031_2EW+\000]k4^s*qg)1\030\021\014\022 I\az\0183\rt\002uNU\019$\026PjlVH\027d\teB%=ra\003LmyG\020}Y\004<\001@,o~|vcn9h\0158\028ZX7\bR\005?\"\025\006[p'x.wbJ6>#CifF(\v&AQ\f0"
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
objIAMLEGEND = Wherigo.ZCartridge()
objtastatur = Wherigo.ZMedia(objIAMLEGEND)
objtastatur.Id = "2e0d6f60-7326-4fd1-a037-f6cffc0eaea4"
objtastatur.Name = "tastatur"
objtastatur.Description = ""
objtastatur.AltText = ""
objtastatur.Resources = {
  {
    Type = "jpg",
    Filename = "tastatur1.jpg",
    Directives = {}
  }
}
objtastaturOK = Wherigo.ZMedia(objIAMLEGEND)
objtastaturOK.Id = "7acb60cc-6bb6-428e-a4c5-d1b3c25d372f"
objtastaturOK.Name = "tastaturOK"
objtastaturOK.Description = ""
objtastaturOK.AltText = ""
objtastaturOK.Resources = {
  {
    Type = "jpg",
    Filename = "tastaturok.jpg",
    Directives = {}
  }
}
objdenk = Wherigo.ZMedia(objIAMLEGEND)
objdenk.Id = "3cce01b0-1ddc-44ee-b8fb-031c2c66b043"
objdenk.Name = "denk"
objdenk.Description = ""
objdenk.AltText = ""
objdenk.Resources = {
  {
    Type = "jpg",
    Filename = "Denkblase180.jpg",
    Directives = {}
  }
}
objdenksprech = Wherigo.ZMedia(objIAMLEGEND)
objdenksprech.Id = "c45601fb-d0fd-4550-b170-1cbcf45f123e"
objdenksprech.Name = "denksprech"
objdenksprech.Description = ""
objdenksprech.AltText = ""
objdenksprech.Resources = {
  {
    Type = "jpg",
    Filename = "Denksprechblase180.jpg",
    Directives = {}
  }
}
objsoundbiss = Wherigo.ZMedia(objIAMLEGEND)
objsoundbiss.Id = "321170e8-92e8-4830-b62e-328a8ddd7124"
objsoundbiss.Name = "sound biss"
objsoundbiss.Description = "biss"
objsoundbiss.AltText = ""
objsoundbiss.Resources = {
  {
    Type = "fdl",
    Filename = "biss4.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "ZombieInPain.mp3",
    Directives = {}
  }
}
objherz100 = Wherigo.ZMedia(objIAMLEGEND)
objherz100.Id = "c32869a7-76fc-4539-bec2-e4bfa883d85d"
objherz100.Name = "herz100"
objherz100.Description = ""
objherz100.AltText = ""
objherz100.Resources = {
  {
    Type = "jpg",
    Filename = "herz100.jpg",
    Directives = {}
  }
}
objherz075 = Wherigo.ZMedia(objIAMLEGEND)
objherz075.Id = "2ad3d27d-3707-4749-9fa8-409980c3b845"
objherz075.Name = "herz075"
objherz075.Description = ""
objherz075.AltText = ""
objherz075.Resources = {
  {
    Type = "jpg",
    Filename = "herz75.jpg",
    Directives = {}
  }
}
objherz050 = Wherigo.ZMedia(objIAMLEGEND)
objherz050.Id = "55afc9ce-3424-42f1-ab03-96b063d903cc"
objherz050.Name = "herz050"
objherz050.Description = ""
objherz050.AltText = ""
objherz050.Resources = {
  {
    Type = "jpg",
    Filename = "herz50.jpg",
    Directives = {}
  }
}
objherz025 = Wherigo.ZMedia(objIAMLEGEND)
objherz025.Id = "36ffa438-de3c-43a0-a8da-8e214f89c6cd"
objherz025.Name = "herz025"
objherz025.Description = ""
objherz025.AltText = ""
objherz025.Resources = {
  {
    Type = "jpg",
    Filename = "herz25.jpg",
    Directives = {}
  }
}
objrip = Wherigo.ZMedia(objIAMLEGEND)
objrip.Id = "a4c12ddf-935d-42a9-8b8e-21217be648af"
objrip.Name = "rip"
objrip.Description = ""
objrip.AltText = ""
objrip.Resources = {
  {
    Type = "jpg",
    Filename = "tot.jpg",
    Directives = {}
  }
}
objherz005 = Wherigo.ZMedia(objIAMLEGEND)
objherz005.Id = "4abd4aed-a663-4631-89a1-de21f547bb81"
objherz005.Name = "herz005"
objherz005.Description = ""
objherz005.AltText = ""
objherz005.Resources = {
  {
    Type = "jpg",
    Filename = "herz05.jpg",
    Directives = {}
  }
}
objstetoskop = Wherigo.ZMedia(objIAMLEGEND)
objstetoskop.Id = "d3dbd59b-980f-4d7b-82e4-c05c1f204a92"
objstetoskop.Name = "stetoskop"
objstetoskop.Description = ""
objstetoskop.AltText = ""
objstetoskop.Resources = {
  {
    Type = "jpg",
    Filename = "stetoskop.jpg",
    Directives = {}
  }
}
objbrutalin = Wherigo.ZMedia(objIAMLEGEND)
objbrutalin.Id = "76775a26-0051-4629-8eea-acc81f671d2e"
objbrutalin.Name = "brutalin"
objbrutalin.Description = ""
objbrutalin.AltText = ""
objbrutalin.Resources = {
  {
    Type = "jpg",
    Filename = "brutalin.jpg",
    Directives = {}
  }
}
objsanduhr = Wherigo.ZMedia(objIAMLEGEND)
objsanduhr.Id = "24a2c794-5ab8-4ee3-b756-af52e79c59cb"
objsanduhr.Name = "sanduhr"
objsanduhr.Description = ""
objsanduhr.AltText = ""
objsanduhr.Resources = {
  {
    Type = "jpg",
    Filename = "sanduhr.jpg",
    Directives = {}
  }
}
objidee = Wherigo.ZMedia(objIAMLEGEND)
objidee.Id = "f8fcfc5f-1bd3-49b0-9a53-41bfa3256880"
objidee.Name = "idee"
objidee.Description = ""
objidee.AltText = ""
objidee.Resources = {
  {
    Type = "jpg",
    Filename = "idee.jpg",
    Directives = {}
  }
}
objbuchzu = Wherigo.ZMedia(objIAMLEGEND)
objbuchzu.Id = "3eeffb5b-398e-44f1-b3ca-7d9cb0dd5772"
objbuchzu.Name = "buchzu"
objbuchzu.Description = ""
objbuchzu.AltText = ""
objbuchzu.Resources = {
  {
    Type = "jpg",
    Filename = "buchzu.jpg",
    Directives = {}
  }
}
objbuchoffen = Wherigo.ZMedia(objIAMLEGEND)
objbuchoffen.Id = "81708093-74bc-4628-b20f-36ae152c8e4d"
objbuchoffen.Name = "buchoffen"
objbuchoffen.Description = ""
objbuchoffen.AltText = ""
objbuchoffen.Resources = {
  {
    Type = "JPG",
    Filename = "buchoffen.JPG",
    Directives = {}
  }
}
objsoundHinweis = Wherigo.ZMedia(objIAMLEGEND)
objsoundHinweis.Id = "e6d9eb57-0c2d-46f1-b8b7-515861eecc1e"
objsoundHinweis.Name = "sound Hinweis"
objsoundHinweis.Description = ""
objsoundHinweis.AltText = ""
objsoundHinweis.Resources = {
  {
    Type = "fdl",
    Filename = "s1_1.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "hinweis.mp3",
    Directives = {}
  }
}
objsoundlaut = Wherigo.ZMedia(objIAMLEGEND)
objsoundlaut.Id = "412a7f69-0290-4a24-a6a0-f15ac2290f65"
objsoundlaut.Name = "sound laut"
objsoundlaut.Description = ""
objsoundlaut.AltText = ""
objsoundlaut.Resources = {
  {
    Type = "fdl",
    Filename = "biss4_1.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "HORSERAC21_TM01.mp3",
    Directives = {}
  }
}
objhirn = Wherigo.ZMedia(objIAMLEGEND)
objhirn.Id = "794e306b-e7ad-4f03-81e1-13dd5f36dbf6"
objhirn.Name = "hirn"
objhirn.Description = ""
objhirn.AltText = ""
objhirn.Resources = {
  {
    Type = "jpg",
    Filename = "hirn.jpg",
    Directives = {}
  }
}
objz10 = Wherigo.ZMedia(objIAMLEGEND)
objz10.Id = "7bda09ea-6889-41bd-a4b6-3fe9fe1a4fd1"
objz10.Name = "z10"
objz10.Description = ""
objz10.AltText = ""
objz10.Resources = {
  {
    Type = "jpg",
    Filename = "z10.jpg",
    Directives = {}
  }
}
objz11 = Wherigo.ZMedia(objIAMLEGEND)
objz11.Id = "444d39d7-a8a8-42c0-8543-91a8dc1d95c0"
objz11.Name = "z11"
objz11.Description = ""
objz11.AltText = ""
objz11.Resources = {
  {
    Type = "jpg",
    Filename = "z11.jpg",
    Directives = {}
  }
}
objz12 = Wherigo.ZMedia(objIAMLEGEND)
objz12.Id = "07b1c7f5-73a3-4c6d-8141-99bc7b515885"
objz12.Name = "z12"
objz12.Description = ""
objz12.AltText = ""
objz12.Resources = {
  {
    Type = "jpg",
    Filename = "z12.jpg",
    Directives = {}
  }
}
objz13 = Wherigo.ZMedia(objIAMLEGEND)
objz13.Id = "d6c42b13-685e-4451-800c-0f6ac60f5291"
objz13.Name = "z13"
objz13.Description = ""
objz13.AltText = ""
objz13.Resources = {
  {
    Type = "jpg",
    Filename = "z13.jpg",
    Directives = {}
  }
}
objz20 = Wherigo.ZMedia(objIAMLEGEND)
objz20.Id = "5c0e8c58-f032-4643-973a-21e7455ff467"
objz20.Name = "z20"
objz20.Description = ""
objz20.AltText = ""
objz20.Resources = {
  {
    Type = "jpg",
    Filename = "z20.jpg",
    Directives = {}
  }
}
objz14 = Wherigo.ZMedia(objIAMLEGEND)
objz14.Id = "5b9f23da-498f-4b3a-a41f-a3923cbea384"
objz14.Name = "z14"
objz14.Description = ""
objz14.AltText = ""
objz14.Resources = {
  {
    Type = "jpg",
    Filename = "z14.jpg",
    Directives = {}
  }
}
objz21 = Wherigo.ZMedia(objIAMLEGEND)
objz21.Id = "39803592-5e9a-49cf-8ed3-006660d5a249"
objz21.Name = "z21"
objz21.Description = ""
objz21.AltText = ""
objz21.Resources = {
  {
    Type = "jpg",
    Filename = "z21.jpg",
    Directives = {}
  }
}
objz3 = Wherigo.ZMedia(objIAMLEGEND)
objz3.Id = "01da3fd1-2c8a-4f0e-ad16-c4fc86df1ad4"
objz3.Name = "z3"
objz3.Description = ""
objz3.AltText = ""
objz3.Resources = {
  {
    Type = "jpg",
    Filename = "z3.jpg",
    Directives = {}
  }
}
objmedikit = Wherigo.ZMedia(objIAMLEGEND)
objmedikit.Id = "6bc991f5-700f-4d77-8c27-b6e3f33d5345"
objmedikit.Name = "medikit"
objmedikit.Description = ""
objmedikit.AltText = ""
objmedikit.Resources = {
  {
    Type = "jpg",
    Filename = "medikit.jpg",
    Directives = {}
  }
}
objz15 = Wherigo.ZMedia(objIAMLEGEND)
objz15.Id = "46b25eda-cc5d-4312-a693-2ab4f67dfdf1"
objz15.Name = "z15"
objz15.Description = ""
objz15.AltText = ""
objz15.Resources = {
  {
    Type = "jpg",
    Filename = "z15.jpg",
    Directives = {}
  }
}
objsoundmusikoderpiep = Wherigo.ZMedia(objIAMLEGEND)
objsoundmusikoderpiep.Id = "4df6ad6a-225c-4290-b8b4-1429d66d7bbc"
objsoundmusikoderpiep.Name = "sound musik oder piep"
objsoundmusikoderpiep.Description = ""
objsoundmusikoderpiep.AltText = ""
objsoundmusikoderpiep.Resources = {
  {
    Type = "fdl",
    Filename = "StationErreicht2.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "HORSERAC21_TM01_1.mp3",
    Directives = {}
  }
}
objanleitung = Wherigo.ZMedia(objIAMLEGEND)
objanleitung.Id = "9f01c3f9-8b86-4b37-8a8f-a7cbc4bb9fa4"
objanleitung.Name = "anleitung"
objanleitung.Description = ""
objanleitung.AltText = ""
objanleitung.Resources = {
  {
    Type = "jpg",
    Filename = "images.jpg",
    Directives = {}
  }
}
objtelefon = Wherigo.ZMedia(objIAMLEGEND)
objtelefon.Id = "9c803658-e4a9-448b-9809-43e0ded4ea13"
objtelefon.Name = "telefon"
objtelefon.Description = ""
objtelefon.AltText = ""
objtelefon.Resources = {
  {
    Type = "jpg",
    Filename = "telefon.jpg",
    Directives = {}
  }
}
objhoerer = Wherigo.ZMedia(objIAMLEGEND)
objhoerer.Id = "4d473be0-2e25-4962-bf4e-17187e5f11d6"
objhoerer.Name = "hoerer"
objhoerer.Description = ""
objhoerer.AltText = ""
objhoerer.Resources = {
  {
    Type = "jpg",
    Filename = "telefonhoerer.jpg",
    Directives = {}
  }
}
objsoundtel = Wherigo.ZMedia(objIAMLEGEND)
objsoundtel.Id = "5b49bbaf-1551-480c-8a56-a87b99d1a236"
objsoundtel.Name = "soundtel"
objsoundtel.Description = ""
objsoundtel.AltText = ""
objsoundtel.Resources = {
  {
    Type = "fdl",
    Filename = "s1.fdl",
    Directives = {}
  },
  {
    Type = "mp3",
    Filename = "telkurz.mp3",
    Directives = {}
  }
}
objopfer1 = Wherigo.ZMedia(objIAMLEGEND)
objopfer1.Id = "dc9d0a8a-ed5e-4009-9bbe-ccae99e184cf"
objopfer1.Name = "opfer1"
objopfer1.Description = ""
objopfer1.AltText = ""
objopfer1.Resources = {
  {
    Type = "jpg",
    Filename = "opfer1.jpg",
    Directives = {}
  }
}
objopfer2 = Wherigo.ZMedia(objIAMLEGEND)
objopfer2.Id = "82e5e6c5-b55c-42f1-a976-eeeebde21e68"
objopfer2.Name = "opfer2"
objopfer2.Description = ""
objopfer2.AltText = ""
objopfer2.Resources = {
  {
    Type = "jpg",
    Filename = "opfer2.jpg",
    Directives = {}
  }
}
objdefib = Wherigo.ZMedia(objIAMLEGEND)
objdefib.Id = "66591c46-8f61-403c-9ff4-5fff4da5a349"
objdefib.Name = "defib"
objdefib.Description = ""
objdefib.AltText = ""
objdefib.Resources = {
  {
    Type = "jpg",
    Filename = "defibrillator.jpg",
    Directives = {}
  }
}
objschranke = Wherigo.ZMedia(objIAMLEGEND)
objschranke.Id = "4da6b79e-e355-467b-bed1-7a4c1dd38c7a"
objschranke.Name = "schranke"
objschranke.Description = ""
objschranke.AltText = ""
objschranke.Resources = {
  {
    Type = "jpg",
    Filename = "schranke.jpg",
    Directives = {}
  }
}
objdetektor = Wherigo.ZMedia(objIAMLEGEND)
objdetektor.Id = "31c09230-96ce-40f1-8d48-a7910f1800e7"
objdetektor.Name = "detektor"
objdetektor.Description = ""
objdetektor.AltText = ""
objdetektor.Resources = {
  {
    Type = "jpg",
    Filename = "detektor.jpg",
    Directives = {}
  }
}
objhinweisprof = Wherigo.ZMedia(objIAMLEGEND)
objhinweisprof.Id = "707747a9-217f-49d7-bdea-eca59e3d5ff6"
objhinweisprof.Name = "hinweisprof"
objhinweisprof.Description = ""
objhinweisprof.AltText = ""
objhinweisprof.Resources = {
  {
    Type = "gif",
    Filename = "zettel.gif",
    Directives = {}
  }
}
objhinweisbaum = Wherigo.ZMedia(objIAMLEGEND)
objhinweisbaum.Id = "c0056adc-ec0b-4ea7-9ec6-9d5d8eaebca6"
objhinweisbaum.Name = "hinweisbaum"
objhinweisbaum.Description = ""
objhinweisbaum.AltText = ""
objhinweisbaum.Resources = {
  {
    Type = "gif",
    Filename = "infobaum2Kopie.gif",
    Directives = {}
  }
}
objdecryptionkey = Wherigo.ZMedia(objIAMLEGEND)
objdecryptionkey.Id = "079ddcda-a72f-4c61-acd2-88986ff06f2d"
objdecryptionkey.Name = "decryptionkey"
objdecryptionkey.Description = ""
objdecryptionkey.AltText = ""
objdecryptionkey.Resources = {
  {
    Type = "gif",
    Filename = "decryptionkey.gif",
    Directives = {}
  }
}
objvanity = Wherigo.ZMedia(objIAMLEGEND)
objvanity.Id = "94e0a450-830a-4712-9507-0fed44d9b262"
objvanity.Name = "vanity"
objvanity.Description = ""
objvanity.AltText = ""
objvanity.Resources = {
  {
    Type = "gif",
    Filename = "telefontasten.gif",
    Directives = {}
  }
}
objMorse = Wherigo.ZMedia(objIAMLEGEND)
objMorse.Id = "28d86717-4707-452d-a626-4f425345e9be"
objMorse.Name = "Morse"
objMorse.Description = ""
objMorse.AltText = ""
objMorse.Resources = {
  {
    Type = "gif",
    Filename = "morsecode.gif",
    Directives = {}
  }
}
objschafalarm = Wherigo.ZMedia(objIAMLEGEND)
objschafalarm.Id = "8783515c-01d0-45cc-b583-c47f4ec69bcc"
objschafalarm.Name = "schafalarm"
objschafalarm.Description = ""
objschafalarm.AltText = ""
objschafalarm.Resources = {
  {
    Type = "jpg",
    Filename = "schafmelder.jpg",
    Directives = {}
  }
}
objsounddose = Wherigo.ZMedia(objIAMLEGEND)
objsounddose.Id = "42dc011d-bffa-4bd5-9aee-6b3b8a67264d"
objsounddose.Name = "sound dose"
objsounddose.Description = ""
objsounddose.AltText = ""
objsounddose.Resources = {
  {
    Type = "mp3",
    Filename = "alarm.mp3",
    Directives = {}
  },
  {
    Type = "fdl",
    Filename = "StationErreicht3.fdl",
    Directives = {}
  }
}
objsoundschluck = Wherigo.ZMedia(objIAMLEGEND)
objsoundschluck.Id = "cc12f0bc-d63e-4d1a-a9b2-7bb8ef16ce4e"
objsoundschluck.Name = "sound schluck"
objsoundschluck.Description = ""
objsoundschluck.AltText = ""
objsoundschluck.Resources = {
  {
    Type = "mp3",
    Filename = "schlucken.mp3",
    Directives = {}
  }
}
objschrank = Wherigo.ZMedia(objIAMLEGEND)
objschrank.Id = "8ac0f30e-5097-403d-9730-7b3e44a3f4ff"
objschrank.Name = "schrank"
objschrank.Description = ""
objschrank.AltText = ""
objschrank.Resources = {
  {
    Type = "jpg",
    Filename = "zombies1024.jpg",
    Directives = {}
  }
}
objschrankpf = Wherigo.ZMedia(objIAMLEGEND)
objschrankpf.Id = "3fa38ce8-6a45-4e6b-bfd1-7c91a0f52cdf"
objschrankpf.Name = "schrankpf"
objschrankpf.Description = ""
objschrankpf.AltText = ""
objschrankpf.Resources = {
  {
    Type = "jpg",
    Filename = "passwort.jpg",
    Directives = {}
  }
}
objsoundappear = Wherigo.ZMedia(objIAMLEGEND)
objsoundappear.Id = "d5fa8558-511c-4f81-83f5-214ed5dd1b0c"
objsoundappear.Name = "sound appear"
objsoundappear.Description = ""
objsoundappear.AltText = ""
objsoundappear.Resources = {
  {
    Type = "mp3",
    Filename = "Appear.mp3",
    Directives = {}
  }
}
objdose = Wherigo.ZMedia(objIAMLEGEND)
objdose.Id = "141dcf82-f8d4-4d16-9a70-accfe611e714"
objdose.Name = "dose"
objdose.Description = ""
objdose.AltText = ""
objdose.Resources = {
  {
    Type = "jpg",
    Filename = "dose.jpg",
    Directives = {}
  }
}
objsoundschranke = Wherigo.ZMedia(objIAMLEGEND)
objsoundschranke.Id = "65cc9ad1-33ea-4620-b69c-e736ee150d41"
objsoundschranke.Name = "soundschranke"
objsoundschranke.Description = ""
objsoundschranke.AltText = ""
objsoundschranke.Resources = {
  {
    Type = "mp3",
    Filename = "soundSqeaking_door.mp3",
    Directives = {}
  }
}
objblut = Wherigo.ZMedia(objIAMLEGEND)
objblut.Id = "5efb6a2c-b662-4a75-bd21-0cf6eecb7627"
objblut.Name = "blut"
objblut.Description = ""
objblut.AltText = ""
objblut.Resources = {
  {
    Type = "JPG",
    Filename = "blut.JPG",
    Directives = {}
  }
}
objdosefrage = Wherigo.ZMedia(objIAMLEGEND)
objdosefrage.Id = "b1b423c7-b740-4c78-ab7d-d61ce748eed7"
objdosefrage.Name = "dosefrage"
objdosefrage.Description = ""
objdosefrage.AltText = ""
objdosefrage.Resources = {
  {
    Type = "jpg",
    Filename = "dosefrage.jpg",
    Directives = {}
  }
}
objrettung = Wherigo.ZMedia(objIAMLEGEND)
objrettung.Id = "e8d00000-09b5-4471-9acf-8111159fef82"
objrettung.Name = "rettung"
objrettung.Description = ""
objrettung.AltText = ""
objrettung.Resources = {
  {
    Type = "jpg",
    Filename = "rettung.jpg",
    Directives = {}
  }
}
objiqtest = Wherigo.ZMedia(objIAMLEGEND)
objiqtest.Id = "ac2d6261-6365-42f0-81af-758276fa4cea"
objiqtest.Name = "iqtest"
objiqtest.Description = ""
objiqtest.AltText = ""
objiqtest.Resources = {
  {
    Type = "jpg",
    Filename = "iqtest.jpg",
    Directives = {}
  }
}
objpasswort = Wherigo.ZMedia(objIAMLEGEND)
objpasswort.Id = "27fb9db8-fbe4-4b04-90df-f52baa23fa5f"
objpasswort.Name = "passwort"
objpasswort.Description = ""
objpasswort.AltText = ""
objpasswort.Resources = {
  {
    Type = "jpg",
    Filename = "passwort1.jpg",
    Directives = {}
  }
}
objangst = Wherigo.ZMedia(objIAMLEGEND)
objangst.Id = "a56c3ed3-cfb0-408c-bef4-c7a926d8c87d"
objangst.Name = "angst"
objangst.Description = ""
objangst.AltText = ""
objangst.Resources = {
  {
    Type = "jpg",
    Filename = "angst.jpg",
    Directives = {}
  }
}
objIAMLEGEND1 = Wherigo.ZMedia(objIAMLEGEND)
objIAMLEGEND1.Id = "04a3895a-3908-48ee-b01c-104e029fa5e6"
objIAMLEGEND1.Name = "I AM LEGEND"
objIAMLEGEND1.Description = ""
objIAMLEGEND1.AltText = ""
objIAMLEGEND1.Resources = {
  {
    Type = "png",
    Filename = "280px-I_am_legendsvg.png",
    Directives = {}
  }
}
objhologramm = Wherigo.ZMedia(objIAMLEGEND)
objhologramm.Id = "2c401a49-c905-4c79-a2eb-d4529dc44b4a"
objhologramm.Name = "hologramm"
objhologramm.Description = ""
objhologramm.AltText = ""
objhologramm.Resources = {
  {
    Type = "png",
    Filename = "hologramm2.png",
    Directives = {}
  }
}
objhologramm2 = Wherigo.ZMedia(objIAMLEGEND)
objhologramm2.Id = "c15536f8-a957-4278-a35a-7f110b1aab90"
objhologramm2.Name = "hologramm 2"
objhologramm2.Description = ""
objhologramm2.AltText = ""
objhologramm2.Resources = {
  {
    Type = "png",
    Filename = "hologramm2_1.png",
    Directives = {}
  }
}
objhologramm3 = Wherigo.ZMedia(objIAMLEGEND)
objhologramm3.Id = "654f4ed3-7fcb-46f1-9c1e-55a3afb09f3c"
objhologramm3.Name = "hologramm 3"
objhologramm3.Description = ""
objhologramm3.AltText = ""
objhologramm3.Resources = {
  {
    Type = "png",
    Filename = "hologramm2_2.png",
    Directives = {}
  }
}
objIAMLEGEND.Id = "1dfa3ab2-b3ef-4e3e-afed-0fbebaaf7d81"
objIAMLEGEND.Name = "I AM LEGEND"
objIAMLEGEND.Description = "<BR>\n<BR>\n<BR>\n<BR>\nAm 02. 02. 2020 scheint der Virologe Dr. Dietbald Dagobert der letzte lebende Mensch in Mirow zu sein. Drei Jahre zuvor hat Dr. Adelmut Answald ein Masern-Virus modifiziert und damit ein Heilmittel gegen Krebs mit einer hundertprozentigen Erfolgsquote gefunden. Jedoch mutierte das Virus und toetete 5,4 Milliarden Menschen. Von den 600 Millionen Ueberlebenden erwiesen sich nur 12 Millionen als immun. Die restlichen Ueberlebenden entwickeln zun\195\164chst Symptome, die der Tollwut gleichen, degenerieren aber bald in einen tier\195\164hnlichen Zustand, getriebeae von Hunger und blinder, grenzenloser Aggression gegen Nichtinfizierte. Ihre Haut wird haarlos und heller und sie verstecken sich in Gebaeuden, da sie sehr schmerzempfindlich auf UV-Licht reagieren. Sie entwickeln einen hoeheren Puls, schnellere Atmung und Stoffwechsel sowie eine erhoehte Koerpertemperatur."
objIAMLEGEND.Visible = true
objIAMLEGEND.Activity = "Fiction"
objIAMLEGEND.StartingLocationDescription = ""
objIAMLEGEND.StartingLocation = ZonePoint(53.279533, 12.812367, 0)
objIAMLEGEND.Version = "1.3"
objIAMLEGEND.Company = ""
objIAMLEGEND.Author = "eddysnz"
objIAMLEGEND.BuilderVersion = "URWIGO 1.22.5798.37755"
objIAMLEGEND.CreateDate = "02/20/2011 01:18:51"
objIAMLEGEND.PublishDate = "1/1/0001 12:00:00 AM"
objIAMLEGEND.UpdateDate = "03/05/2020 18:36:45"
objIAMLEGEND.LastPlayedDate = "1/1/0001 12:00:00 AM"
objIAMLEGEND.TargetDevice = "PocketPC"
objIAMLEGEND.TargetDeviceVersion = "0"
objIAMLEGEND.StateId = "1"
objIAMLEGEND.CountryId = "2"
objIAMLEGEND.Complete = false
objIAMLEGEND.UseLogging = true
objIAMLEGEND.Media = objIAMLEGEND1
objTelefon = Wherigo.Zone(objIAMLEGEND)
objTelefon.Id = "f182a3c0-9876-446f-a5dc-59d4d6e4b433"
objTelefon.Name = "Telefon"
objTelefon.Description = "da muss ich hin, dort befindet sich ein Hologramm"
objTelefon.Visible = true
objTelefon.Commands = {}
objTelefon.DistanceRange = Distance(-1, "feet")
objTelefon.ShowObjects = "OnEnter"
objTelefon.ProximityRange = Distance(60, "meters")
objTelefon.AllowSetPositionTo = false
objTelefon.Active = false
objTelefon.Points = {
  ZonePoint(53.2807700791618, 12.8116409609138, 0),
  ZonePoint(53.2808970966846, 12.8115674393982, 0),
  ZonePoint(53.2808453127984, 12.8112873947182, 0),
  ZonePoint(53.2807197736938, 12.811359197165, 0)
}
objTelefon.OriginalPoint = ZonePoint(53.2808080655846, 12.8114637480488, 0)
objTelefon.DistanceRangeUOM = "Feet"
objTelefon.ProximityRangeUOM = "Meters"
objTelefon.OutOfRangeName = ""
objTelefon.InRangeName = ""
objTodeszone = Wherigo.Zone(objIAMLEGEND)
objTodeszone.Id = "504a5f69-1d6f-4b60-8bff-897177cf03d2"
objTodeszone.Name = "Todeszone"
objTodeszone.Description = ""
objTodeszone.Visible = false
objTodeszone.Commands = {}
objTodeszone.DistanceRange = Distance(-1, "feet")
objTodeszone.ShowObjects = "OnEnter"
objTodeszone.ProximityRange = Distance(60, "meters")
objTodeszone.AllowSetPositionTo = false
objTodeszone.Active = false
objTodeszone.Points = {
  ZonePoint(53.2838097531559, 12.8110317853928, 0),
  ZonePoint(53.2838051822095, 12.8105460117341, 0),
  ZonePoint(53.2840315764864, 12.8105427808988, 0),
  ZonePoint(53.284053593508, 12.8111016585289, 0)
}
objTodeszone.OriginalPoint = ZonePoint(53.28392502634, 12.8108055591387, 0)
objTodeszone.DistanceRangeUOM = "Feet"
objTodeszone.ProximityRangeUOM = "Meters"
objTodeszone.OutOfRangeName = ""
objTodeszone.InRangeName = ""
objKantine = Wherigo.Zone(objIAMLEGEND)
objKantine.Id = "0cc5036e-7842-4a87-8dab-e17b818bf246"
objKantine.Name = "Kantine"
objKantine.Description = "das Zentrum des Infomationsaustauschs"
objKantine.Visible = true
objKantine.Commands = {}
objKantine.DistanceRange = Distance(-1, "feet")
objKantine.ShowObjects = "OnEnter"
objKantine.ProximityRange = Distance(60, "meters")
objKantine.AllowSetPositionTo = false
objKantine.Active = false
objKantine.Points = {
  ZonePoint(53.2864608986902, 12.8109177452564, 0),
  ZonePoint(53.2864630432034, 12.811377998861, 0),
  ZonePoint(53.2862724171397, 12.8113597877491, 0),
  ZonePoint(53.286276112119, 12.8109040587207, 0)
}
objKantine.OriginalPoint = ZonePoint(53.2863681177881, 12.8111398976468, 0)
objKantine.DistanceRangeUOM = "Feet"
objKantine.ProximityRangeUOM = "Meters"
objKantine.OutOfRangeName = ""
objKantine.InRangeName = ""
objseltsameDame = Wherigo.Zone(objIAMLEGEND)
objseltsameDame.Id = "ac0ccb5a-fbfd-4c68-8e2b-636dd0a48e83"
objseltsameDame.Name = "seltsame Dame"
objseltsameDame.Description = "sieht garnicht gesund aus. Ob die wohl Hilfe benoetigt?.."
objseltsameDame.Visible = true
objseltsameDame.Media = objz15
objseltsameDame.Commands = {}
objseltsameDame.DistanceRange = Distance(-1, "feet")
objseltsameDame.ShowObjects = "OnEnter"
objseltsameDame.ProximityRange = Distance(15, "meters")
objseltsameDame.AllowSetPositionTo = false
objseltsameDame.Active = false
objseltsameDame.Points = {
  ZonePoint(53.2858211886163, 12.8112595853442, 0),
  ZonePoint(53.2858222310532, 12.8110798310106, 0),
  ZonePoint(53.285716400737, 12.8110798310106, 0),
  ZonePoint(53.2857180042286, 12.8112622212237, 0)
}
objseltsameDame.OriginalPoint = ZonePoint(53.2857694561588, 12.8111703671473, 0)
objseltsameDame.DistanceRangeUOM = "Feet"
objseltsameDame.ProximityRangeUOM = "Meters"
objseltsameDame.OutOfRangeName = ""
objseltsameDame.InRangeName = ""
objseltlsamedamerahmen = Wherigo.Zone(objIAMLEGEND)
objseltlsamedamerahmen.Id = "6d5cb4f9-1969-41ab-9582-de2881d98dee"
objseltlsamedamerahmen.Name = "seltlsame dame rahmen"
objseltlsamedamerahmen.Description = "03kauzrahmen"
objseltlsamedamerahmen.Visible = false
objseltlsamedamerahmen.Commands = {}
objseltlsamedamerahmen.DistanceRange = Distance(-1, "feet")
objseltlsamedamerahmen.ShowObjects = "OnEnter"
objseltlsamedamerahmen.ProximityRange = Distance(60, "meters")
objseltlsamedamerahmen.AllowSetPositionTo = false
objseltlsamedamerahmen.Active = false
objseltlsamedamerahmen.Points = {
  ZonePoint(53.2858832794664, 12.810498105089, 0),
  ZonePoint(53.2858861260802, 12.8114801355898, 0),
  ZonePoint(53.2854937058094, 12.8114883100726, 0),
  ZonePoint(53.2854919933404, 12.8104893429956, 0)
}
objseltlsamedamerahmen.OriginalPoint = ZonePoint(53.2856887761741, 12.8109889734367, 0)
objseltlsamedamerahmen.DistanceRangeUOM = "Feet"
objseltlsamedamerahmen.ProximityRangeUOM = "Meters"
objseltlsamedamerahmen.OutOfRangeName = ""
objseltlsamedamerahmen.InRangeName = ""
objzombie3ausloeser = Wherigo.Zone(objIAMLEGEND)
objzombie3ausloeser.Id = "5aca83b7-4c28-4f6e-a742-cd994971c061"
objzombie3ausloeser.Name = "zombie 3 ausloeser"
objzombie3ausloeser.Description = "z3 ausloeser"
objzombie3ausloeser.Visible = false
objzombie3ausloeser.Commands = {}
objzombie3ausloeser.DistanceRange = Distance(-1, "feet")
objzombie3ausloeser.ShowObjects = "OnEnter"
objzombie3ausloeser.ProximityRange = Distance(60, "meters")
objzombie3ausloeser.AllowSetPositionTo = false
objzombie3ausloeser.Active = false
objzombie3ausloeser.Points = {
  ZonePoint(53.2860460914211, 12.8178144710799, 0),
  ZonePoint(53.2860495928295, 12.8187270543859, 0),
  ZonePoint(53.2873268296984, 12.818688083476, 0),
  ZonePoint(53.2873286219649, 12.8179024618773, 0)
}
objzombie3ausloeser.OriginalPoint = ZonePoint(53.2866877839785, 12.8182830177048, 0)
objzombie3ausloeser.DistanceRangeUOM = "Feet"
objzombie3ausloeser.ProximityRangeUOM = "Meters"
objzombie3ausloeser.OutOfRangeName = ""
objzombie3ausloeser.InRangeName = ""
objLagerhaus = Wherigo.Zone(objIAMLEGEND)
objLagerhaus.Id = "0a2dc64e-3692-493e-b78e-0483a52cea26"
objLagerhaus.Name = "Lagerhaus"
objLagerhaus.Description = "Hier finde ich vermutlich den 1. Hinweis"
objLagerhaus.Visible = true
objLagerhaus.Commands = {}
objLagerhaus.DistanceRange = Distance(-1, "feet")
objLagerhaus.ShowObjects = "OnEnter"
objLagerhaus.ProximityRange = Distance(60, "meters")
objLagerhaus.AllowSetPositionTo = false
objLagerhaus.Active = false
objLagerhaus.Points = {
  ZonePoint(53.2867822028401, 12.8109443729393, 0),
  ZonePoint(53.2867913658725, 12.8114285934198, 0),
  ZonePoint(53.2870959103858, 12.8114348227624, 0),
  ZonePoint(53.2870852599337, 12.810976644877, 0)
}
objLagerhaus.OriginalPoint = ZonePoint(53.286938684758, 12.8111961084996, 0)
objLagerhaus.DistanceRangeUOM = "Feet"
objLagerhaus.ProximityRangeUOM = "Meters"
objLagerhaus.OutOfRangeName = ""
objLagerhaus.InRangeName = ""
objAuditorium = Wherigo.Zone(objIAMLEGEND)
objAuditorium.Id = "6085b909-c87c-483e-a856-96506c296173"
objAuditorium.Name = "Auditorium"
objAuditorium.Description = "dort wird hoffentlich der 3. Hinweis sein.."
objAuditorium.Visible = true
objAuditorium.Commands = {}
objAuditorium.DistanceRange = Distance(-1, "feet")
objAuditorium.ShowObjects = "OnEnter"
objAuditorium.ProximityRange = Distance(60, "meters")
objAuditorium.AllowSetPositionTo = false
objAuditorium.Active = false
objAuditorium.Points = {
  ZonePoint(53.2873861881971, 12.8166605444123, 0),
  ZonePoint(53.2873655402827, 12.8173052345381, 0),
  ZonePoint(53.2870917174664, 12.8172912912797, 0),
  ZonePoint(53.2871140859097, 12.8166168757541, 0)
}
objAuditorium.OriginalPoint = ZonePoint(53.287239382964, 12.816968486496, 0)
objAuditorium.DistanceRangeUOM = "Feet"
objAuditorium.ProximityRangeUOM = "Meters"
objAuditorium.OutOfRangeName = ""
objAuditorium.InRangeName = ""
objZombies = Wherigo.Zone(objIAMLEGEND)
objZombies.Id = "6518db5a-a2ba-4972-a3c5-8c07889496a7"
objZombies.Name = "Zombies"
objZombies.Description = "um die mache ich lieber einen Bogen!"
objZombies.Visible = true
objZombies.Media = objz3
objZombies.Commands = {}
objZombies.DistanceRange = Distance(-1, "feet")
objZombies.ShowObjects = "OnEnter"
objZombies.ProximityRange = Distance(60, "meters")
objZombies.AllowSetPositionTo = false
objZombies.Active = false
objZombies.Points = {
  ZonePoint(53.2862180008912, 12.8108525530749, 0),
  ZonePoint(53.2862102727805, 12.8114011941138, 0),
  ZonePoint(53.2870965286896, 12.8114879190542, 0),
  ZonePoint(53.285721555033, 12.8123187099127, 0),
  ZonePoint(53.2857166744988, 12.8103154643893, 0),
  ZonePoint(53.2876724249744, 12.8104012788637, 0),
  ZonePoint(53.2876474082905, 12.812207455264, 0),
  ZonePoint(53.2859475194869, 12.8123840711654, 0),
  ZonePoint(53.28714393282, 12.8119161897543, 0),
  ZonePoint(53.287151066708, 12.8108660443607, 0)
}
objZombies.OriginalPoint = ZonePoint(53.2866525384173, 12.8114150879953, 0)
objZombies.DistanceRangeUOM = "Feet"
objZombies.ProximityRangeUOM = "Meters"
objZombies.OutOfRangeName = ""
objZombies.InRangeName = ""
objKuehlhaus = Wherigo.Zone(objIAMLEGEND)
objKuehlhaus.Id = "8a3a48a6-a96c-476f-94d8-6dd85938bb87"
objKuehlhaus.Name = "Kuehlhaus"
objKuehlhaus.Description = "den 2. Hinweis werde ich wohl hier finden.."
objKuehlhaus.Visible = true
objKuehlhaus.Commands = {}
objKuehlhaus.DistanceRange = Distance(-1, "feet")
objKuehlhaus.ShowObjects = "OnEnter"
objKuehlhaus.ProximityRange = Distance(60, "meters")
objKuehlhaus.AllowSetPositionTo = false
objKuehlhaus.Active = false
objKuehlhaus.Points = {
  ZonePoint(53.2866945758914, 12.8133811074476, 0),
  ZonePoint(53.286982901177, 12.8133580988864, 0),
  ZonePoint(53.2869827031582, 12.8137076480449, 0),
  ZonePoint(53.2866965082041, 12.8137327024247, 0)
}
objKuehlhaus.OriginalPoint = ZonePoint(53.2868391721077, 12.8135448892009, 0)
objKuehlhaus.DistanceRangeUOM = "Feet"
objKuehlhaus.ProximityRangeUOM = "Meters"
objKuehlhaus.OutOfRangeName = ""
objKuehlhaus.InRangeName = ""
objZombiedort = Wherigo.Zone(objIAMLEGEND)
objZombiedort.Id = "10484163-ee2f-470a-b3cc-88c8f1392d0c"
objZombiedort.Name = "Zombie dort"
objZombiedort.Description = ""
objZombiedort.Visible = true
objZombiedort.Media = objz20
objZombiedort.Icon = objz20
objZombiedort.Commands = {}
objZombiedort.DistanceRange = Distance(-1, "feet")
objZombiedort.ShowObjects = "OnEnter"
objZombiedort.ProximityRange = Distance(60, "meters")
objZombiedort.AllowSetPositionTo = false
objZombiedort.Active = false
objZombiedort.Points = {
  ZonePoint(53.2866023280869, 12.8160340045493, 0),
  ZonePoint(53.2865557790304, 12.8168154507974, 0),
  ZonePoint(53.2863901086594, 12.8167202368306, 0),
  ZonePoint(53.28645709914, 12.8159425434617, 0)
}
objZombiedort.OriginalPoint = ZonePoint(53.2865013287292, 12.8163780589098, 0)
objZombiedort.DistanceRangeUOM = "Feet"
objZombiedort.ProximityRangeUOM = "Meters"
objZombiedort.OutOfRangeName = ""
objZombiedort.InRangeName = ""
objZombiedrueben = Wherigo.Zone(objIAMLEGEND)
objZombiedrueben.Id = "6c359e21-b7ce-4510-a397-839f9f2d6a71"
objZombiedrueben.Name = "Zombie drueben"
objZombiedrueben.Description = ""
objZombiedrueben.Visible = true
objZombiedrueben.Media = objz10
objZombiedrueben.Commands = {}
objZombiedrueben.DistanceRange = Distance(-1, "feet")
objZombiedrueben.ShowObjects = "OnEnter"
objZombiedrueben.ProximityRange = Distance(60, "meters")
objZombiedrueben.AllowSetPositionTo = false
objZombiedrueben.Active = false
objZombiedrueben.Points = {
  ZonePoint(53.2863570814509, 12.8159379787377, 0),
  ZonePoint(53.2863066768433, 12.8166445887068, 0),
  ZonePoint(53.2861665231426, 12.8166317270655, 0),
  ZonePoint(53.2862338845114, 12.8158479634495, 0)
}
objZombiedrueben.OriginalPoint = ZonePoint(53.286266041487, 12.8162655644899, 0)
objZombiedrueben.DistanceRangeUOM = "Feet"
objZombiedrueben.ProximityRangeUOM = "Meters"
objZombiedrueben.OutOfRangeName = ""
objZombiedrueben.InRangeName = ""
objZombiesrechts = Wherigo.Zone(objIAMLEGEND)
objZombiesrechts.Id = "18c8dfc5-cf71-4a9e-925f-87107fe2b20f"
objZombiesrechts.Name = "Zombies rechts"
objZombiesrechts.Description = ""
objZombiesrechts.Visible = true
objZombiesrechts.Media = objz3
objZombiesrechts.Commands = {}
objZombiesrechts.DistanceRange = Distance(-1, "feet")
objZombiesrechts.ShowObjects = "OnEnter"
objZombiesrechts.ProximityRange = Distance(60, "meters")
objZombiesrechts.AllowSetPositionTo = false
objZombiesrechts.Active = false
objZombiesrechts.Points = {
  ZonePoint(53.2872732095252, 12.8162105157041, 0),
  ZonePoint(53.2872555173456, 12.8164769291348, 0),
  ZonePoint(53.2862254693463, 12.8158467014737, 0),
  ZonePoint(53.2862604868303, 12.81561764064, 0)
}
objZombiesrechts.OriginalPoint = ZonePoint(53.2867536707619, 12.8160379467381, 0)
objZombiesrechts.DistanceRangeUOM = "Feet"
objZombiesrechts.ProximityRangeUOM = "Meters"
objZombiesrechts.OutOfRangeName = ""
objZombiesrechts.InRangeName = ""
objEingangzurBibliothek = Wherigo.Zone(objIAMLEGEND)
objEingangzurBibliothek.Id = "1e116b98-12d2-494e-b5b6-b6c74d353bfc"
objEingangzurBibliothek.Name = "Eingang zur Bibliothek"
objEingangzurBibliothek.Description = "Eingang zur Bibliothek, da muss ich hin."
objEingangzurBibliothek.Visible = true
objEingangzurBibliothek.Commands = {}
objEingangzurBibliothek.DistanceRange = Distance(-1, "feet")
objEingangzurBibliothek.ShowObjects = "OnEnter"
objEingangzurBibliothek.ProximityRange = Distance(60, "meters")
objEingangzurBibliothek.AllowSetPositionTo = false
objEingangzurBibliothek.Active = false
objEingangzurBibliothek.Points = {
  ZonePoint(53.2868144613882, 12.8162864340671, 0),
  ZonePoint(53.2867696110663, 12.8167752153072, 0),
  ZonePoint(53.286596373047, 12.8167093347502, 0),
  ZonePoint(53.286643209765, 12.8161985826902, 0)
}
objEingangzurBibliothek.OriginalPoint = ZonePoint(53.2867059138166, 12.8164923917037, 0)
objEingangzurBibliothek.DistanceRangeUOM = "Feet"
objEingangzurBibliothek.ProximityRangeUOM = "Meters"
objEingangzurBibliothek.OutOfRangeName = ""
objEingangzurBibliothek.InRangeName = ""
objGaragen = Wherigo.Zone(objIAMLEGEND)
objGaragen.Id = "4c0ae6b4-6a5d-46bf-b594-9cd3e683cce6"
objGaragen.Name = "Garagen"
objGaragen.Description = "Bei den Garagen ist es immer soo inspirierend!<BR>\n"
objGaragen.Visible = true
objGaragen.Commands = {}
objGaragen.DistanceRange = Distance(-1, "feet")
objGaragen.ShowObjects = "OnEnter"
objGaragen.ProximityRange = Distance(60, "meters")
objGaragen.AllowSetPositionTo = false
objGaragen.Active = false
objGaragen.Points = {
  ZonePoint(53.2853147093897, 12.8154196172647, 0),
  ZonePoint(53.2855028242429, 12.8154222851657, 0),
  ZonePoint(53.2855048428733, 12.8150277866218, 0),
  ZonePoint(53.2853137566863, 12.8150388440791, 0)
}
objGaragen.OriginalPoint = ZonePoint(53.2854090332981, 12.8152271332828, 0)
objGaragen.DistanceRangeUOM = "Feet"
objGaragen.ProximityRangeUOM = "Meters"
objGaragen.OutOfRangeName = ""
objGaragen.InRangeName = ""
objZombielinks = Wherigo.Zone(objIAMLEGEND)
objZombielinks.Id = "f8d9d655-fa66-4a0b-a3e8-ed9c108f8926"
objZombielinks.Name = "Zombie links"
objZombielinks.Description = ""
objZombielinks.Visible = true
objZombielinks.Media = objopfer1
objZombielinks.Commands = {}
objZombielinks.DistanceRange = Distance(-1, "feet")
objZombielinks.ShowObjects = "OnEnter"
objZombielinks.ProximityRange = Distance(60, "meters")
objZombielinks.AllowSetPositionTo = false
objZombielinks.Active = false
objZombielinks.Points = {
  ZonePoint(53.2870934113878, 12.8115457681427, 0),
  ZonePoint(53.2870973043143, 12.8121383625302, 0),
  ZonePoint(53.2870399004718, 12.8122425549499, 0),
  ZonePoint(53.2869853993953, 12.812327211291, 0),
  ZonePoint(53.2869425770722, 12.8123532593959, 0),
  ZonePoint(53.2869620417699, 12.8125160600518, 0),
  ZonePoint(53.286993581305, 12.8128006017559, 0),
  ZonePoint(53.2870204358096, 12.8132063348328, 0),
  ZonePoint(53.2873894033707, 12.8131734434599, 0),
  ZonePoint(53.2874018741353, 12.8115522801689, 0)
}
objZombielinks.OriginalPoint = ZonePoint(53.2870925929032, 12.8123855876579, 0)
objZombielinks.DistanceRangeUOM = "Feet"
objZombielinks.ProximityRangeUOM = "Meters"
objZombielinks.OutOfRangeName = ""
objZombielinks.InRangeName = ""
objZombiesrechts1 = Wherigo.Zone(objIAMLEGEND)
objZombiesrechts1.Id = "e1cc4ff4-686d-4b18-87be-d64dd7b18a97"
objZombiesrechts1.Name = "Zombies rechts"
objZombiesrechts1.Description = ""
objZombiesrechts1.Visible = true
objZombiesrechts1.Media = objopfer2
objZombiesrechts1.Commands = {}
objZombiesrechts1.DistanceRange = Distance(-1, "feet")
objZombiesrechts1.ShowObjects = "OnEnter"
objZombiesrechts1.ProximityRange = Distance(60, "meters")
objZombiesrechts1.AllowSetPositionTo = false
objZombiesrechts1.Active = false
objZombiesrechts1.Points = {
  ZonePoint(53.2869613923854, 12.8119475187557, 0),
  ZonePoint(53.286888149893, 12.8121847433358, 0),
  ZonePoint(53.2867334349515, 12.8121178774496, 0),
  ZonePoint(53.2867485225415, 12.8118826277711, 0),
  ZonePoint(53.2863823519265, 12.8120565647385, 0),
  ZonePoint(53.28671066618, 12.8125258790975, 0),
  ZonePoint(53.286721022377, 12.8122721877537, 0),
  ZonePoint(53.2868368528322, 12.8123503824736, 0),
  ZonePoint(53.2868657305501, 12.8126485420007, 0),
  ZonePoint(53.2869094130405, 12.8132335463502, 0),
  ZonePoint(53.2864724205917, 12.8132598558889, 0),
  ZonePoint(53.2862927735138, 12.8120471549305, 0),
  ZonePoint(53.2866699694172, 12.8112798775162, 0),
  ZonePoint(53.2868608253737, 12.8113211037934, 0),
  ZonePoint(53.2869737206735, 12.8113601759373, 0)
}
objZombiesrechts1.OriginalPoint = ZonePoint(53.2867351497498, 12.8121658691862, 0)
objZombiesrechts1.DistanceRangeUOM = "Feet"
objZombiesrechts1.ProximityRangeUOM = "Meters"
objZombiesrechts1.OutOfRangeName = ""
objZombiesrechts1.InRangeName = ""
objZombieslinks = Wherigo.Zone(objIAMLEGEND)
objZombieslinks.Id = "b52b2633-bb92-4b47-b54c-8ff79528fab4"
objZombieslinks.Name = "Zombies links"
objZombieslinks.Description = ""
objZombieslinks.Visible = true
objZombieslinks.Media = objz21
objZombieslinks.Commands = {}
objZombieslinks.DistanceRange = Distance(-1, "feet")
objZombieslinks.ShowObjects = "OnEnter"
objZombieslinks.ProximityRange = Distance(60, "meters")
objZombieslinks.AllowSetPositionTo = false
objZombieslinks.Active = false
objZombieslinks.Points = {
  ZonePoint(53.286492731458, 12.8147501419375, 0),
  ZonePoint(53.2864876977072, 12.8154959008466, 0),
  ZonePoint(53.2868303503673, 12.8156502738439, 0),
  ZonePoint(53.2868346846245, 12.8147665264317, 0)
}
objZombieslinks.OriginalPoint = ZonePoint(53.2866613660392, 12.8151657107649, 0)
objZombieslinks.DistanceRangeUOM = "Feet"
objZombieslinks.ProximityRangeUOM = "Meters"
objZombieslinks.OutOfRangeName = ""
objZombieslinks.InRangeName = ""
objZombiesrechts2 = Wherigo.Zone(objIAMLEGEND)
objZombiesrechts2.Id = "d4a2687c-9ded-424c-bfda-1007e870fc9b"
objZombiesrechts2.Name = "Zombies rechts"
objZombiesrechts2.Description = ""
objZombiesrechts2.Visible = true
objZombiesrechts2.Media = objz11
objZombiesrechts2.Commands = {}
objZombiesrechts2.DistanceRange = Distance(-1, "feet")
objZombiesrechts2.ShowObjects = "OnEnter"
objZombiesrechts2.ProximityRange = Distance(60, "meters")
objZombiesrechts2.AllowSetPositionTo = false
objZombiesrechts2.Active = false
objZombiesrechts2.Points = {
  ZonePoint(53.2872072962003, 12.8148603894968, 0),
  ZonePoint(53.2871996485439, 12.8157407088274, 0),
  ZonePoint(53.2868859792392, 12.8157275923186, 0),
  ZonePoint(53.2869014957475, 12.8147955928315, 0)
}
objZombiesrechts2.OriginalPoint = ZonePoint(53.2870486049327, 12.8152810708686, 0)
objZombiesrechts2.DistanceRangeUOM = "Feet"
objZombiesrechts2.ProximityRangeUOM = "Meters"
objZombiesrechts2.OutOfRangeName = ""
objZombiesrechts2.InRangeName = ""
objz2i = Wherigo.Zone(objIAMLEGEND)
objz2i.Id = "ed5fd013-b155-4fb8-a723-38ffc7c1fba2"
objz2i.Name = "z2 i"
objz2i.Description = "z2i 1.haelfte"
objz2i.Visible = false
objz2i.Commands = {}
objz2i.DistanceRange = Distance(-1, "feet")
objz2i.ShowObjects = "OnEnter"
objz2i.ProximityRange = Distance(60, "meters")
objz2i.AllowSetPositionTo = false
objz2i.Active = false
objz2i.Points = {
  ZonePoint(53.2874334115515, 12.814561817381, 0),
  ZonePoint(53.2862486557321, 12.8144785639283, 0),
  ZonePoint(53.2862735425888, 12.812805924199, 0),
  ZonePoint(53.2866252790361, 12.8128289918002, 0),
  ZonePoint(53.2866381825741, 12.8138340535124, 0),
  ZonePoint(53.2870845819917, 12.8138656944377, 0),
  ZonePoint(53.2871077737374, 12.8128945902355, 0),
  ZonePoint(53.287435908384, 12.8129075218317, 0)
}
objz2i.OriginalPoint = ZonePoint(53.2868559169495, 12.8135221446657, 0)
objz2i.DistanceRangeUOM = "Feet"
objz2i.ProximityRangeUOM = "Meters"
objz2i.OutOfRangeName = ""
objz2i.InRangeName = ""
objSicherheitszone = Wherigo.Zone(objIAMLEGEND)
objSicherheitszone.Id = "a1b87d23-593d-47c1-9078-6e2614975e84"
objSicherheitszone.Name = "Sicherheitszone"
objSicherheitszone.Description = [[
Dort bin ich sicher!<BR>
HIN!!!]]
objSicherheitszone.Visible = true
objSicherheitszone.Commands = {}
objSicherheitszone.DistanceRange = Distance(-1, "feet")
objSicherheitszone.ShowObjects = "OnEnter"
objSicherheitszone.ProximityRange = Distance(60, "meters")
objSicherheitszone.AllowSetPositionTo = false
objSicherheitszone.Active = false
objSicherheitszone.Points = {
  ZonePoint(53.2870970392377, 12.8114373503638, 0),
  ZonePoint(53.2870970392377, 12.8121390958976, 0),
  ZonePoint(53.286984845577, 12.8123300229504, 0),
  ZonePoint(53.2869441598187, 12.8123528206521, 0),
  ZonePoint(53.2870193441583, 12.8132293827149, 0),
  ZonePoint(53.2869099269567, 12.8132339716504, 0),
  ZonePoint(53.2868372633369, 12.8123448314092, 0),
  ZonePoint(53.2867201817387, 12.8122720353779, 0),
  ZonePoint(53.2867104405863, 12.812525743549, 0),
  ZonePoint(53.2863819199844, 12.8120583850272, 0),
  ZonePoint(53.2867464264885, 12.8118862516021, 0),
  ZonePoint(53.286733262808, 12.8121176558272, 0),
  ZonePoint(53.2868886343432, 12.8121825833285, 0),
  ZonePoint(53.2869630472839, 12.8119447987131, 0),
  ZonePoint(53.2869678731195, 12.8115981033046, 0),
  ZonePoint(53.2869737290014, 12.8114441045439, 0)
}
objSicherheitszone.OriginalPoint = ZonePoint(53.2868734458548, 12.812193571057, 0)
objSicherheitszone.DistanceRangeUOM = "Feet"
objSicherheitszone.ProximityRangeUOM = "Meters"
objSicherheitszone.OutOfRangeName = ""
objSicherheitszone.InRangeName = ""
objAussichtshuegel = Wherigo.Zone(objIAMLEGEND)
objAussichtshuegel.Id = "730a0a58-2915-4bcf-a47a-e6b870da6781"
objAussichtshuegel.Name = "Aussichtshuegel"
objAussichtshuegel.Description = "von oben hat man einfach den Ueberblick"
objAussichtshuegel.Visible = true
objAussichtshuegel.Commands = {}
objAussichtshuegel.DistanceRange = Distance(-1, "feet")
objAussichtshuegel.ShowObjects = "OnEnter"
objAussichtshuegel.ProximityRange = Distance(60, "meters")
objAussichtshuegel.AllowSetPositionTo = false
objAussichtshuegel.Active = false
objAussichtshuegel.Points = {
  ZonePoint(53.2865615705213, 12.8192328095458, 0),
  ZonePoint(53.2867558940804, 12.8192301447576, 0),
  ZonePoint(53.2867559174224, 12.8189291836609, 0),
  ZonePoint(53.2865618657045, 12.818929613346, 0)
}
objAussichtshuegel.OriginalPoint = ZonePoint(53.2866588119321, 12.8190804378276, 0)
objAussichtshuegel.DistanceRangeUOM = "Feet"
objAussichtshuegel.ProximityRangeUOM = "Meters"
objAussichtshuegel.OutOfRangeName = ""
objAussichtshuegel.InRangeName = ""
objHinterausgangBibliothek = Wherigo.Zone(objIAMLEGEND)
objHinterausgangBibliothek.Id = "216525b0-befa-469f-b77c-34291a82d799"
objHinterausgangBibliothek.Name = "Hinterausgang Bibliothek"
objHinterausgangBibliothek.Description = "Hinterausgang der Bibliothek, da geht es weiter.."
objHinterausgangBibliothek.Visible = true
objHinterausgangBibliothek.Commands = {}
objHinterausgangBibliothek.DistanceRange = Distance(-1, "feet")
objHinterausgangBibliothek.ShowObjects = "OnEnter"
objHinterausgangBibliothek.ProximityRange = Distance(60, "meters")
objHinterausgangBibliothek.AllowSetPositionTo = false
objHinterausgangBibliothek.Active = false
objHinterausgangBibliothek.Points = {
  ZonePoint(53.2861309571247, 12.8157949439273, 0),
  ZonePoint(53.286066654484, 12.8165884121199, 0),
  ZonePoint(53.2858333024736, 12.8164955006613, 0),
  ZonePoint(53.2859093951155, 12.815669389328, 0)
}
objHinterausgangBibliothek.OriginalPoint = ZonePoint(53.2859850772995, 12.8161370615091, 0)
objHinterausgangBibliothek.DistanceRangeUOM = "Feet"
objHinterausgangBibliothek.ProximityRangeUOM = "Meters"
objHinterausgangBibliothek.OutOfRangeName = ""
objHinterausgangBibliothek.InRangeName = ""
objZombiea1 = Wherigo.Zone(objIAMLEGEND)
objZombiea1.Id = "5b4ff5b0-c7a4-43da-ad0c-7dc39be818b0"
objZombiea1.Name = "Zombie a1"
objZombiea1.Description = ""
objZombiea1.Visible = false
objZombiea1.Commands = {}
objZombiea1.DistanceRange = Distance(-1, "feet")
objZombiea1.ShowObjects = "OnEnter"
objZombiea1.ProximityRange = Distance(60, "meters")
objZombiea1.AllowSetPositionTo = false
objZombiea1.Active = false
objZombiea1.Points = {
  ZonePoint(53.2869390545423, 12.8184853229238, 0),
  ZonePoint(53.2869378310587, 12.818748742974, 0),
  ZonePoint(53.2867230262012, 12.8187428957823, 0),
  ZonePoint(53.2867261247969, 12.818485182768, 0)
}
objZombiea1.OriginalPoint = ZonePoint(53.2868315091498, 12.818615536112, 0)
objZombiea1.DistanceRangeUOM = "Feet"
objZombiea1.ProximityRangeUOM = "Meters"
objZombiea1.OutOfRangeName = ""
objZombiea1.InRangeName = ""
objZombieza2 = Wherigo.Zone(objIAMLEGEND)
objZombieza2.Id = "64b05082-1d16-4962-8f3a-6fcad733487e"
objZombieza2.Name = "Zombie za2"
objZombieza2.Description = ""
objZombieza2.Visible = false
objZombieza2.Commands = {}
objZombieza2.DistanceRange = Distance(-1, "feet")
objZombieza2.ShowObjects = "OnEnter"
objZombieza2.ProximityRange = Distance(60, "meters")
objZombieza2.AllowSetPositionTo = false
objZombieza2.Active = false
objZombieza2.Points = {
  ZonePoint(53.2864696233439, 12.818646691747, 0),
  ZonePoint(53.286467914568, 12.8190561189954, 0),
  ZonePoint(53.2862895799509, 12.8190751874992, 0),
  ZonePoint(53.2862873934489, 12.8186433649203, 0)
}
objZombieza2.OriginalPoint = ZonePoint(53.2863786278279, 12.8188553407905, 0)
objZombieza2.DistanceRangeUOM = "Feet"
objZombieza2.ProximityRangeUOM = "Meters"
objZombieza2.OutOfRangeName = ""
objZombieza2.InRangeName = ""
objZombieza3 = Wherigo.Zone(objIAMLEGEND)
objZombieza3.Id = "3b6c8dee-cdb5-4ab1-9c3f-42f5ec3ebbd3"
objZombieza3.Name = "Zombie za3"
objZombieza3.Description = ""
objZombieza3.Visible = false
objZombieza3.Commands = {}
objZombieza3.DistanceRange = Distance(-1, "feet")
objZombieza3.ShowObjects = "OnEnter"
objZombieza3.ProximityRange = Distance(60, "meters")
objZombieza3.AllowSetPositionTo = false
objZombieza3.Active = false
objZombieza3.Points = {
  ZonePoint(53.2866798173164, 12.8182176823374, 0),
  ZonePoint(53.2866853714346, 12.8185547686907, 0),
  ZonePoint(53.2863266690246, 12.8185635612252, 0),
  ZonePoint(53.286328425468, 12.8182064296754, 0)
}
objZombieza3.OriginalPoint = ZonePoint(53.2865050708109, 12.8183856104822, 0)
objZombieza3.DistanceRangeUOM = "Feet"
objZombieza3.ProximityRangeUOM = "Meters"
objZombieza3.OutOfRangeName = ""
objZombieza3.InRangeName = ""
objZombieslinks1 = Wherigo.Zone(objIAMLEGEND)
objZombieslinks1.Id = "413e67a3-85ca-4c3e-8209-67e416d6df96"
objZombieslinks1.Name = "Zombies links"
objZombieslinks1.Description = ""
objZombieslinks1.Visible = true
objZombieslinks1.Media = objz12
objZombieslinks1.Commands = {}
objZombieslinks1.DistanceRange = Distance(-1, "feet")
objZombieslinks1.ShowObjects = "OnEnter"
objZombieslinks1.ProximityRange = Distance(60, "meters")
objZombieslinks1.AllowSetPositionTo = false
objZombieslinks1.Active = false
objZombieslinks1.Points = {
  ZonePoint(53.2870652908595, 12.8169962471738, 0),
  ZonePoint(53.2870516736274, 12.8172322691179, 0),
  ZonePoint(53.2860257850197, 12.8168448891885, 0),
  ZonePoint(53.2860493179299, 12.8166319969596, 0)
}
objZombieslinks1.OriginalPoint = ZonePoint(53.2865480168591, 12.81692635061, 0)
objZombieslinks1.DistanceRangeUOM = "Feet"
objZombieslinks1.ProximityRangeUOM = "Meters"
objZombieslinks1.OutOfRangeName = ""
objZombieslinks1.InRangeName = ""
objFamama = Wherigo.Zone(objIAMLEGEND)
objFamama.Id = "82f46eb1-6765-4564-8a07-26ef6afcc69d"
objFamama.Name = "Famama"
objFamama.Description = "Das Facility-Management-Main-Head-Quarter. Dort laufen alle Energie- und Versorgungswege zusammen."
objFamama.Visible = true
objFamama.Commands = {}
objFamama.DistanceRange = Distance(-1, "feet")
objFamama.ShowObjects = "OnEnter"
objFamama.ProximityRange = Distance(60, "meters")
objFamama.AllowSetPositionTo = false
objFamama.Active = false
objFamama.Points = {
  ZonePoint(53.2854929622128, 12.8148105579336, 0),
  ZonePoint(53.2854900471112, 12.8154038585627, 0),
  ZonePoint(53.2852377854918, 12.8154271802125, 0),
  ZonePoint(53.2852517831844, 12.8148211234531, 0)
}
objFamama.OriginalPoint = ZonePoint(53.2853681445001, 12.8151156800405, 0)
objFamama.DistanceRangeUOM = "Feet"
objFamama.ProximityRangeUOM = "Meters"
objFamama.OutOfRangeName = ""
objFamama.InRangeName = ""
objZombies1 = Wherigo.Zone(objIAMLEGEND)
objZombies1.Id = "c2f1dfa5-82f7-48d0-923d-2b267ed0d6ed"
objZombies1.Name = "Zombies"
objZombies1.Description = "diese Kreuzung queren die Zombies.."
objZombies1.Visible = true
objZombies1.Media = objz14
objZombies1.Commands = {}
objZombies1.DistanceRange = Distance(-1, "feet")
objZombies1.ShowObjects = "OnEnter"
objZombies1.ProximityRange = Distance(60, "meters")
objZombies1.AllowSetPositionTo = false
objZombies1.Active = false
objZombies1.Points = {
  ZonePoint(53.2850401894022, 12.8156848403389, 0),
  ZonePoint(53.2847078952754, 12.8157003083401, 0),
  ZonePoint(53.2847105387159, 12.8142299496131, 0),
  ZonePoint(53.2850546484233, 12.8141946984499, 0),
  ZonePoint(53.2850467889271, 12.8149893530804, 0)
}
objZombies1.OriginalPoint = ZonePoint(53.2849120121488, 12.8149598299645, 0)
objZombies1.DistanceRangeUOM = "Feet"
objZombies1.ProximityRangeUOM = "Meters"
objZombies1.OutOfRangeName = ""
objZombies1.InRangeName = ""
objswzombiesquerrahmen = Wherigo.Zone(objIAMLEGEND)
objswzombiesquerrahmen.Id = "44d3cfe6-f8b9-4826-86c5-1b4a1e5fa5d3"
objswzombiesquerrahmen.Name = "sw zombiesquer rahmen"
objswzombiesquerrahmen.Description = ""
objswzombiesquerrahmen.Visible = false
objswzombiesquerrahmen.Commands = {}
objswzombiesquerrahmen.DistanceRange = Distance(-1, "feet")
objswzombiesquerrahmen.ShowObjects = "OnEnter"
objswzombiesquerrahmen.ProximityRange = Distance(60, "meters")
objswzombiesquerrahmen.AllowSetPositionTo = false
objswzombiesquerrahmen.Active = false
objswzombiesquerrahmen.Points = {
  ZonePoint(53.2852576270138, 12.8141707930066, 0),
  ZonePoint(53.2852579530059, 12.8156612701244, 0),
  ZonePoint(53.2850585819013, 12.8156682349854, 0),
  ZonePoint(53.2850613267991, 12.8141686580706, 0)
}
objswzombiesquerrahmen.OriginalPoint = ZonePoint(53.28515887218, 12.8149172390467, 0)
objswzombiesquerrahmen.DistanceRangeUOM = "Feet"
objswzombiesquerrahmen.ProximityRangeUOM = "Meters"
objswzombiesquerrahmen.OutOfRangeName = ""
objswzombiesquerrahmen.InRangeName = ""
objswquerstop = Wherigo.Zone(objIAMLEGEND)
objswquerstop.Id = "a641d5a8-d24d-473a-af3e-5922a1f4cd5c"
objswquerstop.Name = "swquerstop"
objswquerstop.Description = ""
objswquerstop.Visible = false
objswquerstop.Commands = {}
objswquerstop.DistanceRange = Distance(-1, "feet")
objswquerstop.ShowObjects = "OnEnter"
objswquerstop.ProximityRange = Distance(60, "meters")
objswquerstop.AllowSetPositionTo = false
objswquerstop.Active = false
objswquerstop.Points = {
  ZonePoint(53.2844504665734, 12.8142860736142, 0),
  ZonePoint(53.2844388699809, 12.8156729955391, 0),
  ZonePoint(53.2846688635539, 12.8156676697955, 0),
  ZonePoint(53.2846718360747, 12.8142716494933, 0)
}
objswquerstop.OriginalPoint = ZonePoint(53.2845575090457, 12.8149745971105, 0)
objswquerstop.DistanceRangeUOM = "Feet"
objswquerstop.ProximityRangeUOM = "Meters"
objswquerstop.OutOfRangeName = ""
objswquerstop.InRangeName = ""
objfinalewarnung = Wherigo.Zone(objIAMLEGEND)
objfinalewarnung.Id = "4dc31a12-9426-4144-a1a8-7446416417ed"
objfinalewarnung.Name = "finale warnung"
objfinalewarnung.Description = ""
objfinalewarnung.Visible = false
objfinalewarnung.Commands = {}
objfinalewarnung.DistanceRange = Distance(-1, "feet")
objfinalewarnung.ShowObjects = "OnEnter"
objfinalewarnung.ProximityRange = Distance(60, "meters")
objfinalewarnung.AllowSetPositionTo = false
objfinalewarnung.Active = false
objfinalewarnung.Points = {
  ZonePoint(53.2843920111425, 12.8157495576558, 0),
  ZonePoint(53.2842096391583, 12.8157582119711, 0),
  ZonePoint(53.2842055985851, 12.8147059845135, 0),
  ZonePoint(53.2843899512541, 12.8147156832106, 0)
}
objfinalewarnung.OriginalPoint = ZonePoint(53.284299300035, 12.8152323593378, 0)
objfinalewarnung.DistanceRangeUOM = "Feet"
objfinalewarnung.ProximityRangeUOM = "Meters"
objfinalewarnung.OutOfRangeName = ""
objfinalewarnung.InRangeName = ""
objHundertevonihnen = Wherigo.Zone(objIAMLEGEND)
objHundertevonihnen.Id = "29378b91-c984-4416-a178-f31b544c05fd"
objHundertevonihnen.Name = "Hunderte von ihnen"
objHundertevonihnen.Description = "da ist absolut kein Durchkommen"
objHundertevonihnen.Visible = true
objHundertevonihnen.Media = objz3
objHundertevonihnen.Commands = {}
objHundertevonihnen.DistanceRange = Distance(-1, "feet")
objHundertevonihnen.ShowObjects = "OnEnter"
objHundertevonihnen.ProximityRange = Distance(60, "meters")
objHundertevonihnen.AllowSetPositionTo = false
objHundertevonihnen.Active = false
objHundertevonihnen.Points = {
  ZonePoint(53.2857226302419, 12.8135738258277, 0),
  ZonePoint(53.2857143479768, 12.8142927848394, 0),
  ZonePoint(53.2852470024243, 12.8142853627746, 0),
  ZonePoint(53.2850550908567, 12.814253367438, 0),
  ZonePoint(53.2850702680427, 12.8147233542667, 0),
  ZonePoint(53.2849095215612, 12.814576277207, 0),
  ZonePoint(53.2848514067541, 12.8137970773879, 0),
  ZonePoint(53.2835840097178, 12.8141375806858, 0),
  ZonePoint(53.2836467467975, 12.8161780221828, 0),
  ZonePoint(53.283932789892, 12.814816668067, 0),
  ZonePoint(53.2850151293425, 12.8151243894342, 0),
  ZonePoint(53.2849475067681, 12.8141334781072, 0),
  ZonePoint(53.2851370815862, 12.8140402985201, 0),
  ZonePoint(53.2851197257998, 12.8137347655345, 0)
}
objHundertevonihnen.OriginalPoint = ZonePoint(53.2848538041258, 12.8144048037338, 0)
objHundertevonihnen.DistanceRangeUOM = "Feet"
objHundertevonihnen.ProximityRangeUOM = "Meters"
objHundertevonihnen.OutOfRangeName = ""
objHundertevonihnen.InRangeName = ""
objmedikit1 = Wherigo.Zone(objIAMLEGEND)
objmedikit1.Id = "b05ff6c7-a005-4f5a-ae35-33291d74b1fa"
objmedikit1.Name = "medikit"
objmedikit1.Description = ""
objmedikit1.Visible = false
objmedikit1.Commands = {}
objmedikit1.DistanceRange = Distance(-1, "feet")
objmedikit1.ShowObjects = "OnProximity"
objmedikit1.ProximityRange = Distance(10, "meters")
objmedikit1.AllowSetPositionTo = false
objmedikit1.Active = false
objmedikit1.Points = {
  ZonePoint(53.2865367454034, 12.8121963558839, 0),
  ZonePoint(53.2865447698228, 12.8120407388253, 0),
  ZonePoint(53.2866621866852, 12.812064743102, 0),
  ZonePoint(53.2866537789528, 12.8122193361035, 0)
}
objmedikit1.OriginalPoint = ZonePoint(53.286599370216, 12.8121302934787, 0)
objmedikit1.DistanceRangeUOM = "Feet"
objmedikit1.ProximityRangeUOM = "Meters"
objmedikit1.OutOfRangeName = ""
objmedikit1.InRangeName = ""
objmedikitII = Wherigo.Zone(objIAMLEGEND)
objmedikitII.Id = "c32fb0c1-5ef0-4725-af2f-feb35e4ab490"
objmedikitII.Name = "medikitII"
objmedikitII.Description = ""
objmedikitII.Visible = false
objmedikitII.Commands = {}
objmedikitII.DistanceRange = Distance(-1, "feet")
objmedikitII.ShowObjects = "OnProximity"
objmedikitII.ProximityRange = Distance(10, "meters")
objmedikitII.AllowSetPositionTo = false
objmedikitII.Active = false
objmedikitII.Points = {
  ZonePoint(53.2868409129192, 12.8169308392896, 0),
  ZonePoint(53.2869113657745, 12.8162683946659, 0),
  ZonePoint(53.2870466163955, 12.8163490939367, 0),
  ZonePoint(53.2869870779917, 12.8169727178404, 0)
}
objmedikitII.OriginalPoint = ZonePoint(53.2869464932702, 12.8166302614332, 0)
objmedikitII.DistanceRangeUOM = "Feet"
objmedikitII.ProximityRangeUOM = "Meters"
objmedikitII.OutOfRangeName = ""
objmedikitII.InRangeName = ""
objroteInfosaeule = Wherigo.Zone(objIAMLEGEND)
objroteInfosaeule.Id = "9e41f084-2e42-4a0d-b837-a61733a73989"
objroteInfosaeule.Name = "rote Infosaeule"
objroteInfosaeule.Description = ""
objroteInfosaeule.Visible = true
objroteInfosaeule.Commands = {}
objroteInfosaeule.DistanceRange = Distance(0, "meters")
objroteInfosaeule.ShowObjects = "OnProximity"
objroteInfosaeule.ProximityRange = Distance(30, "meters")
objroteInfosaeule.AllowSetPositionTo = false
objroteInfosaeule.Active = false
objroteInfosaeule.Points = {
  ZonePoint(53.2839185756039, 12.8149667996788, 0),
  ZonePoint(53.2841085747011, 12.814953795709, 0),
  ZonePoint(53.2841221576016, 12.8153975750151, 0),
  ZonePoint(53.2839409576616, 12.8154394555772, 0)
}
objroteInfosaeule.OriginalPoint = ZonePoint(53.284022566392, 12.815189406495, 0)
objroteInfosaeule.DistanceRangeUOM = "Meters"
objroteInfosaeule.ProximityRangeUOM = "Meters"
objroteInfosaeule.OutOfRangeName = ""
objroteInfosaeule.InRangeName = ""
objStrehlow = Wherigo.Zone(objIAMLEGEND)
objStrehlow.Id = "8ae9fe23-b062-4fb1-9cad-2779953edea1"
objStrehlow.Name = "Strehlow"
objStrehlow.Description = "Endlich..."
objStrehlow.Visible = false
objStrehlow.Commands = {}
objStrehlow.DistanceRange = Distance(-1, "feet")
objStrehlow.ShowObjects = "OnEnter"
objStrehlow.ProximityRange = Distance(60, "meters")
objStrehlow.AllowSetPositionTo = false
objStrehlow.Active = false
objStrehlow.Points = {
  ZonePoint(53.2850873946306, 12.8137137378348, 0),
  ZonePoint(53.2851046653617, 12.8139990231725, 0),
  ZonePoint(53.2849310323995, 12.8140433844592, 0),
  ZonePoint(53.2849114086459, 12.8137662902173, 0)
}
objStrehlow.OriginalPoint = ZonePoint(53.2850086252594, 12.813880608921, 0)
objStrehlow.DistanceRangeUOM = "Feet"
objStrehlow.ProximityRangeUOM = "Meters"
objStrehlow.OutOfRangeName = ""
objStrehlow.InRangeName = ""
objnichtbetreten = Wherigo.Zone(objIAMLEGEND)
objnichtbetreten.Id = "1c91c534-7e4c-4ffe-81eb-c9d005e9320c"
objnichtbetreten.Name = "nicht betreten"
objnichtbetreten.Description = ""
objnichtbetreten.Visible = true
objnichtbetreten.Commands = {}
objnichtbetreten.DistanceRange = Distance(-1, "feet")
objnichtbetreten.ShowObjects = "OnEnter"
objnichtbetreten.ProximityRange = Distance(60, "meters")
objnichtbetreten.AllowSetPositionTo = false
objnichtbetreten.Active = false
objnichtbetreten.Points = {
  ZonePoint(53.2856173338911, 12.8157346573011, 0),
  ZonePoint(53.2856395041021, 12.8170820683272, 0),
  ZonePoint(53.2850556847092, 12.8171685993105, 0),
  ZonePoint(53.2850261240215, 12.8158088267153, 0)
}
objnichtbetreten.OriginalPoint = ZonePoint(53.285334661681, 12.8164485379135, 0)
objnichtbetreten.DistanceRangeUOM = "Feet"
objnichtbetreten.ProximityRangeUOM = "Meters"
objnichtbetreten.OutOfRangeName = ""
objnichtbetreten.InRangeName = ""
h2 = Wherigo.Zone(objIAMLEGEND)
h2.Id = "f9e3bca4-720d-44a4-9e0f-187a45b68b84"
h2.Name = "Hinterausgang"
h2.Description = ""
h2.Visible = true
h2.Commands = {}
h2.DistanceRange = Distance(-1, "feet")
h2.ShowObjects = "OnEnter"
h2.ProximityRange = Distance(60, "meters")
h2.AllowSetPositionTo = false
h2.Active = false
h2.Points = {
  ZonePoint(53.2859193086715, 12.8140132900611, 0),
  ZonePoint(53.2859178684989, 12.8142958750094, 0),
  ZonePoint(53.285756810174, 12.8142908434009, 0),
  ZonePoint(53.2857618817323, 12.8140106961166, 0)
}
h2.OriginalPoint = ZonePoint(53.2858389672692, 12.814152676147, 0)
h2.DistanceRangeUOM = "Feet"
h2.ProximityRangeUOM = "Meters"
h2.OutOfRangeName = ""
h2.InRangeName = ""
objHologramm = Wherigo.ZCharacter({Cartridge = objIAMLEGEND, Container = objTelefon})
objHologramm.Id = "f02d2bd5-8a76-4fb6-b0df-ce4e2c8f6892"
objHologramm.Name = "Hologramm"
objHologramm.Description = ""
objHologramm.Visible = true
objHologramm.Media = objhologramm2
objHologramm.Commands = {
  cmdAnsprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHologramm.Commands.cmdAnsprechen.Custom = true
objHologramm.Commands.cmdAnsprechen.Id = "d0f29134-2a16-4619-8040-01b2fdce7a84"
objHologramm.Commands.cmdAnsprechen.WorksWithAll = true
objHologramm.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHologramm.Gender = "It"
objHologramm.Type = "NPC"
objHologramm2 = Wherigo.ZCharacter({Cartridge = objIAMLEGEND, Container = objKantine})
objHologramm2.Id = "be5cb268-74e6-482c-a047-2a22fd9ffcd2"
objHologramm2.Name = "Hologramm 2"
objHologramm2.Description = ""
objHologramm2.Visible = true
objHologramm2.Media = objhologramm2
objHologramm2.Commands = {
  cmdAnsprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHologramm2.Commands.cmdAnsprechen.Custom = true
objHologramm2.Commands.cmdAnsprechen.Id = "52501bc8-841e-4ff6-a1d6-2bf0056bf7c0"
objHologramm2.Commands.cmdAnsprechen.WorksWithAll = true
objHologramm2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHologramm2.Gender = "It"
objHologramm2.Type = "NPC"
objHologramm3 = Wherigo.ZCharacter({Cartridge = objIAMLEGEND, Container = h2})
objHologramm3.Id = "55826909-9846-4b7c-8c6c-ada8ef2d797a"
objHologramm3.Name = "Hologramm 3"
objHologramm3.Description = ""
objHologramm3.Visible = true
objHologramm3.Media = objhologramm2
objHologramm3.Commands = {
  cmdAnsprechen = Wherigo.ZCommand({
    Text = "Ansprechen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHologramm3.Commands.cmdAnsprechen.Custom = true
objHologramm3.Commands.cmdAnsprechen.Id = "a07bc2be-21cf-4946-81be-6b89499ed057"
objHologramm3.Commands.cmdAnsprechen.WorksWithAll = true
objHologramm3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHologramm3.Gender = "It"
objHologramm3.Type = "NPC"
objBedienungsanleitung = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objBedienungsanleitung.Id = "781ba32e-91dc-43e9-a4d0-163c81db1e90"
objBedienungsanleitung.Name = "Bedienungsanleitung"
objBedienungsanleitung.Description = "Hier gibts Tipps und Tricks zum Thema \"Wherigo\""
objBedienungsanleitung.Visible = true
objBedienungsanleitung.Media = objanleitung
objBedienungsanleitung.Commands = {
  cmdAllgemein = Wherigo.ZCommand({
    Text = "Allgemein",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdGarmin = Wherigo.ZCommand({
    Text = "Garmin",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdPPCPDA = Wherigo.ZCommand({
    Text = "PPC/PDA",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdAndroid = Wherigo.ZCommand({
    Text = "Android",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdIPhone = Wherigo.ZCommand({
    Text = "I-Phone",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdJavafaehigesHandy = Wherigo.ZCommand({
    Text = "Javafaehiges Handy",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objBedienungsanleitung.Commands.cmdAllgemein.Custom = true
objBedienungsanleitung.Commands.cmdAllgemein.Id = "7cac75a1-e469-4273-bb57-174da75b8678"
objBedienungsanleitung.Commands.cmdAllgemein.WorksWithAll = true
objBedienungsanleitung.Commands.cmdGarmin.Custom = true
objBedienungsanleitung.Commands.cmdGarmin.Id = "58cfabfc-aa6f-46d0-bf39-81a871c4b5d9"
objBedienungsanleitung.Commands.cmdGarmin.WorksWithAll = true
objBedienungsanleitung.Commands.cmdPPCPDA.Custom = true
objBedienungsanleitung.Commands.cmdPPCPDA.Id = "9ff83bb0-e1ec-4ad9-a528-2473cd8d4a4f"
objBedienungsanleitung.Commands.cmdPPCPDA.WorksWithAll = true
objBedienungsanleitung.Commands.cmdAndroid.Custom = true
objBedienungsanleitung.Commands.cmdAndroid.Id = "dd8d6747-c1de-4a73-b3a6-78eb7036e767"
objBedienungsanleitung.Commands.cmdAndroid.WorksWithAll = true
objBedienungsanleitung.Commands.cmdIPhone.Custom = true
objBedienungsanleitung.Commands.cmdIPhone.Id = "65d3156f-7e6c-4eeb-97b3-8fa6eb85e4f0"
objBedienungsanleitung.Commands.cmdIPhone.WorksWithAll = true
objBedienungsanleitung.Commands.cmdJavafaehigesHandy.Custom = true
objBedienungsanleitung.Commands.cmdJavafaehigesHandy.Id = "924a4bb7-1d4f-4d8d-852a-7ce7ecda775e"
objBedienungsanleitung.Commands.cmdJavafaehigesHandy.WorksWithAll = true
objBedienungsanleitung.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBedienungsanleitung.Locked = false
objBedienungsanleitung.Opened = false
objNotizbuch = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objNotizbuch.Id = "67bc78dc-61d8-4636-a979-6f84b57a76ec"
objNotizbuch.Name = "Notizbuch"
objNotizbuch.Description = [[
Wenn ich einen Hinweis-Code gefunden habe, trage ich ihn hier ein.<BR>
Das Notizbuch entschluessel ihn mir dann und zeigt mir den kompletten Hinweis an.<BR>
<BR>
Was es nicht alles gibt!]]
objNotizbuch.Visible = true
objNotizbuch.Media = objbuchzu
objNotizbuch.Commands = {
  cmdLesen = Wherigo.ZCommand({
    Text = "Lesen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdCodeeintragen = Wherigo.ZCommand({
    Text = "Code eintragen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdUnlockcode = Wherigo.ZCommand({
    Text = "Unlockcode",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objNotizbuch.Commands.cmdLesen.Custom = true
objNotizbuch.Commands.cmdLesen.Id = "fc6eb47e-7f7c-415a-8748-c33f0149ff5d"
objNotizbuch.Commands.cmdLesen.WorksWithAll = true
objNotizbuch.Commands.cmdCodeeintragen.Custom = true
objNotizbuch.Commands.cmdCodeeintragen.Id = "82e4c822-60d2-4771-b1f2-007a14fc24a1"
objNotizbuch.Commands.cmdCodeeintragen.WorksWithAll = true
objNotizbuch.Commands.cmdUnlockcode.Custom = true
objNotizbuch.Commands.cmdUnlockcode.Id = "fa3ef95b-94cf-484f-9fa8-3f9f0b72b49e"
objNotizbuch.Commands.cmdUnlockcode.WorksWithAll = true
objNotizbuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objNotizbuch.Locked = false
objNotizbuch.Opened = false
objStetoskop = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objStetoskop.Id = "f4eb3c2e-0a29-47db-8618-64e6dffb42ec"
objStetoskop.Name = "Stetoskop"
objStetoskop.Description = [[
Mit diesem Geraet kann ich jederzeit sehen wie es um meine Gesundheit steht.<BR>
Sehr praktisch!]]
objStetoskop.Visible = true
objStetoskop.Media = objstetoskop
objStetoskop.Commands = {
  cmdDiagnose = Wherigo.ZCommand({
    Text = "Diagnose",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdAutopsie = Wherigo.ZCommand({
    Text = "Autopsie",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objStetoskop.Commands.cmdDiagnose.Custom = true
objStetoskop.Commands.cmdDiagnose.Id = "593483d5-b9b9-41e4-9254-be202927f657"
objStetoskop.Commands.cmdDiagnose.WorksWithAll = true
objStetoskop.Commands.cmdAutopsie.Custom = true
objStetoskop.Commands.cmdAutopsie.Id = "604f689d-9bbd-4b0e-b091-ba4c5a81d6fb"
objStetoskop.Commands.cmdAutopsie.WorksWithAll = true
objStetoskop.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objStetoskop.Locked = false
objStetoskop.Opened = false
objBrutalin = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objBrutalin.Id = "f9a17bd9-f40a-457e-b8d1-bd90fa9f1145"
objBrutalin.Name = "Brutalin"
objBrutalin.Description = [[
Eine volle Packung "Brutalin Forte 400"<BR>
Wenn ich nicht mehr weiter weiss, nehm ich eine dieser Pillen und in kurzer Zeit kann ich klarer denken, sehr praktisch!<BR>
(Hilft sogar, wenn ich mir sicher bin, dass der Hinweis-Code verschwunden ist!!!)]]
objBrutalin.Visible = false
objBrutalin.Media = objbrutalin
objBrutalin.Commands = {
  cmdEinnahme = Wherigo.ZCommand({
    Text = "Einnahme",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdWirktesschon = Wherigo.ZCommand({
    Text = "Wirkt es schon?",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  }),
  cmdNocheine = Wherigo.ZCommand({
    Text = "Noch eine!",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objBrutalin.Commands.cmdEinnahme.Custom = true
objBrutalin.Commands.cmdEinnahme.Id = "509248c5-4f2a-45c7-84fe-93b28f755f3f"
objBrutalin.Commands.cmdEinnahme.WorksWithAll = true
objBrutalin.Commands.cmdWirktesschon.Custom = true
objBrutalin.Commands.cmdWirktesschon.Id = "02d0256e-326d-469f-88fd-362f94a1e711"
objBrutalin.Commands.cmdWirktesschon.WorksWithAll = true
objBrutalin.Commands.cmdNocheine.Custom = true
objBrutalin.Commands.cmdNocheine.Id = "c886fb72-d3a2-43f9-b4f4-bf70bf37de97"
objBrutalin.Commands.cmdNocheine.WorksWithAll = true
objBrutalin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objBrutalin.Locked = false
objBrutalin.Opened = false
objHirn = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objHirn.Id = "ce09299a-a3cd-4aaf-a1fc-344ddf7db9bc"
objHirn.Name = "Hirn"
objHirn.Description = [[
hilft beim Denken :)<BR>
Wenn ich das Logik-raetsel geloest habe, kann ich den IQ-Test machen. Stupides Raten kostet nur unnoetig Zeit!]]
objHirn.Visible = false
objHirn.Media = objhirn
objHirn.Commands = {
  cmdIQTest = Wherigo.ZCommand({
    Text = "IQ-Test",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHirn.Commands.cmdIQTest.Custom = true
objHirn.Commands.cmdIQTest.Id = "43d2624c-5667-4345-a45e-5dbb8c8420de"
objHirn.Commands.cmdIQTest.WorksWithAll = true
objHirn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHirn.Locked = false
objHirn.Opened = false
objHirn1 = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objHirn1.Id = "21be29b0-c05d-455b-9e4f-0e4a19e2bcae"
objHirn1.Name = "Hirn"
objHirn1.Description = [[
Hilft beim Denken :)<BR>
<BR>
Ich behalte es mal, wer weiss fuer was es gut ist...]]
objHirn1.Visible = false
objHirn1.Media = objhirn
objHirn1.Commands = {}
objHirn1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHirn1.Locked = false
objHirn1.Opened = false
objMedikit = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objMedikit.Id = "6074fab7-4c1b-4bf4-bf09-49d278bb138f"
objMedikit.Name = "Medikit"
objMedikit.Description = [[
dieses Medikit heilt Verletzungen.<BR>
(Lebensenergier +40)]]
objMedikit.Visible = false
objMedikit.Media = objmedikit
objMedikit.Commands = {
  cmdAnwenden = Wherigo.ZCommand({
    Text = "Anwenden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMedikit.Commands.cmdAnwenden.Custom = true
objMedikit.Commands.cmdAnwenden.Id = "ec4f7413-6746-491b-80c4-07326cdb9af0"
objMedikit.Commands.cmdAnwenden.WorksWithAll = true
objMedikit.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMedikit.Locked = false
objMedikit.Opened = false
objMedikit1 = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = objmedikit1})
objMedikit1.Id = "89f55e05-4e92-4027-9273-6e925f4e70ff"
objMedikit1.Name = "Medikit"
objMedikit1.Description = ""
objMedikit1.Visible = true
objMedikit1.Media = objmedikit
objMedikit1.Commands = {
  cmdAufheben = Wherigo.ZCommand({
    Text = "Aufheben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMedikit1.Commands.cmdAufheben.Custom = true
objMedikit1.Commands.cmdAufheben.Id = "af4578ee-a8f5-470c-8e03-65bb15a20018"
objMedikit1.Commands.cmdAufheben.WorksWithAll = true
objMedikit1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMedikit1.Locked = false
objMedikit1.Opened = false
objSicherheitsTerminal = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = objTodeszone})
objSicherheitsTerminal.Id = "489397ad-53e6-4157-85a9-53681924b1e2"
objSicherheitsTerminal.Name = "Sicherheits-Terminal"
objSicherheitsTerminal.Description = "hier muss der richtige Zugangscode eingegeben werden"
objSicherheitsTerminal.Visible = true
objSicherheitsTerminal.Media = objtastatur
objSicherheitsTerminal.Commands = {
  cmdEingeben = Wherigo.ZCommand({
    Text = "Eingeben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objSicherheitsTerminal.Commands.cmdEingeben.Custom = true
objSicherheitsTerminal.Commands.cmdEingeben.Id = "b13910ac-a523-48e9-bfc2-8350a72f1a7b"
objSicherheitsTerminal.Commands.cmdEingeben.WorksWithAll = true
objSicherheitsTerminal.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objSicherheitsTerminal.Locked = false
objSicherheitsTerminal.Opened = false
objMediKit = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = objmedikitII})
objMediKit.Id = "66b65ef7-e144-403a-bf0a-3a6a57f95ec9"
objMediKit.Name = "Medi-Kit"
objMediKit.Description = ""
objMediKit.Visible = true
objMediKit.Media = objmedikit
objMediKit.Commands = {
  cmdAufheben = Wherigo.ZCommand({
    Text = "Aufheben",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMediKit.Commands.cmdAufheben.Custom = true
objMediKit.Commands.cmdAufheben.Id = "e7f2ee7a-9c9f-4010-8106-cb00672826bf"
objMediKit.Commands.cmdAufheben.WorksWithAll = true
objMediKit.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMediKit.Locked = false
objMediKit.Opened = false
objMediKit1 = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objMediKit1.Id = "d5062e1e-7757-4f43-b71e-c880116a8fc5"
objMediKit1.Name = "Medi-Kit"
objMediKit1.Description = [[
dieses Medikit heilt Verletzungen.<BR>
(Lebensenergier +25)]]
objMediKit1.Visible = false
objMediKit1.Media = objmedikit
objMediKit1.Commands = {
  cmdAnwenden = Wherigo.ZCommand({
    Text = "Anwenden",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objMediKit1.Commands.cmdAnwenden.Custom = true
objMediKit1.Commands.cmdAnwenden.Id = "b8d3786b-003a-4741-a897-7181f7ea45c1"
objMediKit1.Commands.cmdAnwenden.WorksWithAll = true
objMediKit1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objMediKit1.Locked = false
objMediKit1.Opened = false
objDefibrillator = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objDefibrillator.Id = "f387a367-01cc-44c2-a0fc-f1235442736e"
objDefibrillator.Name = "Defibrillator"
objDefibrillator.Description = [[
...dient der Wiederbelebung abgestuerzter Geraete!<BR>
<BR>
Bedienungsanleitung:<BR>
Wenn sich ein Geraet hoffnungslos aufgehaengt hat, die Cartridge nochmal ganz neustarten (nicht die gespeicherte Version). Dann den Rettungscode von einem anderen Geraet abrufen, das noch im Spiel ist und damit den Patienten reanimieren.<BR>
Die optimalen Bedingungen fuer solch eine Operation sind immer nach Vollenden einer Station.<BR>
<BR>
Eine Garantie auf diese Methode gibt es nicht, es kommt immer auf einen Versuch an. Wenn es bei einer Station nicht funktioniert, einfach nach der naechsten nochmal probieren!]]
objDefibrillator.Visible = true
objDefibrillator.Media = objdefib
objDefibrillator.Commands = {
  cmdRetten = Wherigo.ZCommand({
    Text = "Retten!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdGerettetwerden = Wherigo.ZCommand({
    Text = "Gerettet werden!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objDefibrillator.Commands.cmdRetten.Custom = true
objDefibrillator.Commands.cmdRetten.Id = "69424e1c-d2d8-4a1e-97f9-225a292b8c4f"
objDefibrillator.Commands.cmdRetten.WorksWithAll = true
objDefibrillator.Commands.cmdGerettetwerden.Custom = true
objDefibrillator.Commands.cmdGerettetwerden.Id = "79e7d3e7-9d85-4d84-9ed2-c1250e0c7cfa"
objDefibrillator.Commands.cmdGerettetwerden.WorksWithAll = true
objDefibrillator.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objDefibrillator.Locked = false
objDefibrillator.Opened = false
objHinweis = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = objroteInfosaeule})
objHinweis.Id = "a290cf3b-283d-471a-88e1-96f59cc854b4"
objHinweis.Name = "Hinweis"
objHinweis.Description = "Diesen Zettel hat der Prof hinterlassen.."
objHinweis.Visible = true
objHinweis.Media = objhinweisbaum
objHinweis.Commands = {
  cmdAbnehmen = Wherigo.ZCommand({
    Text = "Abnehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHinweis.Commands.cmdAbnehmen.Custom = true
objHinweis.Commands.cmdAbnehmen.Id = "b608ee24-3029-4a16-b2a4-6f8ada63101c"
objHinweis.Commands.cmdAbnehmen.WorksWithAll = true
objHinweis.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHinweis.Locked = false
objHinweis.Opened = false
objHinweiszettel = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objHinweiszettel.Id = "2ff973ed-3520-4819-8b08-c35b87ab7f7a"
objHinweiszettel.Name = "Hinweiszettel"
objHinweiszettel.Description = "Post-it vom Prof. was fuer ein Gekrakel.."
objHinweiszettel.Visible = false
objHinweiszettel.Commands = {
  cmdAnschauen = Wherigo.ZCommand({
    Text = "Anschauen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  }),
  cmdVorderseite = Wherigo.ZCommand({
    Text = "Vorderseite",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  }),
  cmdRueckseite = Wherigo.ZCommand({
    Text = "Rueckseite",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nothing available"
  })
}
objHinweiszettel.Commands.cmdAnschauen.Custom = true
objHinweiszettel.Commands.cmdAnschauen.Id = "769702ad-2bbc-4f6d-9ec8-2ee0358aaac0"
objHinweiszettel.Commands.cmdAnschauen.WorksWithAll = true
objHinweiszettel.Commands.cmdVorderseite.Custom = true
objHinweiszettel.Commands.cmdVorderseite.Id = "f17ea93b-b4a4-4e52-b1b1-e3213977db02"
objHinweiszettel.Commands.cmdVorderseite.WorksWithAll = true
objHinweiszettel.Commands.cmdRueckseite.Custom = true
objHinweiszettel.Commands.cmdRueckseite.Id = "e81fa7a6-7462-4f8e-8e30-085663a9105d"
objHinweiszettel.Commands.cmdRueckseite.WorksWithAll = true
objHinweiszettel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHinweiszettel.Locked = false
objHinweiszettel.Opened = false
objHundemuggel = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = Player})
objHundemuggel.Id = "78519529-cf74-4c83-afde-7d221d9fa412"
objHundemuggel.Name = "Hundemuggel"
objHundemuggel.Description = "ACHTUNG: Wenn Hundemuggel im Weg sind, bitte Hundemuggel &nbsp;ausloesen.<BR>\n"
objHundemuggel.Visible = false
objHundemuggel.Media = objschafalarm
objHundemuggel.Commands = {
  cmdAusloesen = Wherigo.ZCommand({
    Text = "Ausloesen!",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objHundemuggel.Commands.cmdAusloesen.Custom = true
objHundemuggel.Commands.cmdAusloesen.Id = "2c5f2608-3bbf-4502-8cfa-7826198f6ed8"
objHundemuggel.Commands.cmdAusloesen.WorksWithAll = true
objHundemuggel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objHundemuggel.Locked = true
objHundemuggel.Opened = false
objContainer = Wherigo.ZItem({Cartridge = objIAMLEGEND, Container = h2})
objContainer.Id = "91a538eb-5681-44ff-a596-e0d7c4e89cb4"
objContainer.Name = "Container"
objContainer.Description = [[
ein biologischer Behaelter. Der Chef hat ihn eigenhaendig sichergestellt.<BR>
<BR>
Er hat auf der Seite ein Symbol . Wenn du ihn gefunden hast, druecke den Knopf.]]
objContainer.Visible = false
objContainer.Media = objdose
objContainer.Commands = {
  cmdKnopfdruecken = Wherigo.ZCommand({
    Text = "Knopf druecken",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nothing available"
  })
}
objContainer.Commands.cmdKnopfdruecken.Custom = true
objContainer.Commands.cmdKnopfdruecken.Id = "c052f987-c1cc-46d2-a1cd-ab6462ae14ae"
objContainer.Commands.cmdKnopfdruecken.WorksWithAll = true
objContainer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objContainer.Locked = false
objContainer.Opened = false
objFINAL = Wherigo.ZItem(objIAMLEGEND)
objFINAL.Id = "3a78a4c2-85b6-4d46-b75e-603423b2a642"
objFINAL.Name = "FINAL"
objFINAL.Description = "-- FINAL 53 17 039 &nbsp;12 48 910 -- bodennah"
objFINAL.Visible = true
objFINAL.Commands = {}
objFINAL.ObjectLocation = Wherigo.INVALID_ZONEPOINT
objFINAL.Locked = false
objFINAL.Opened = false
objDerWegzurKantine = Wherigo.ZTask(objIAMLEGEND)
objDerWegzurKantine.Id = "69e59c76-8219-4bc5-8e09-048396f8bc83"
objDerWegzurKantine.Name = "Der Weg zur Kantine"
objDerWegzurKantine.Description = [[
Wenn du in eine "unsichtbare Zone" betrittst, ertoent ein Hinweissignal und eine Nachricht erscheint!<BR>
Achte darauf!]]
objDerWegzurKantine.Visible = true
objDerWegzurKantine.Active = false
objDerWegzurKantine.Complete = false
objDerWegzurKantine.CorrectState = "None"
objHinweis1 = Wherigo.ZTask(objIAMLEGEND)
objHinweis1.Id = "40e42ee7-e342-4e3b-a21d-7aca34e4c5d3"
objHinweis1.Name = "Hinweis 1"
objHinweis1.Description = [[
Suche den 1. Hinweis und trage das gefunden Codewort ins Notizbuch ein.<BR>
<BR>
Tipp:<BR>
Falls Du nicht fuendig wirst, denke an die Medikamente, die dir das Hologramm mitgegeben hat.<BR>
Keine Scheu, die wirken Wunder und haben auch kaum Nebenwirkungen! ;)]]
objHinweis1.Visible = true
objHinweis1.Active = false
objHinweis1.Complete = false
objHinweis1.CorrectState = "None"
objDieSpurzumLagerhaus = Wherigo.ZTask(objIAMLEGEND)
objDieSpurzumLagerhaus.Id = "a6f0de42-0c95-44d9-87e9-2e7899ea7e70"
objDieSpurzumLagerhaus.Name = "Die Spur zum Lagerhaus"
objDieSpurzumLagerhaus.Description = [[
Gehe zum Lagerhaus und suche den 1. Hinweis. Pass auf die Zombies auf, du kannst &nbsp;ihre roten Augen sehen...<BR>
<BR>
Tipp:<BR>
Mit Hilfe der Locations-Liste (oder der Karte, wenn dein Geraet das kann..) kannst du sicher gehen, dass du den Zombies nicht zu nahe kommst!]]
objDieSpurzumLagerhaus.Visible = true
objDieSpurzumLagerhaus.Active = false
objDieSpurzumLagerhaus.Complete = false
objDieSpurzumLagerhaus.CorrectState = "None"
objzumHintereingang = Wherigo.ZTask(objIAMLEGEND)
objzumHintereingang.Id = "6279dae2-32da-436a-8fac-3ca304346fe5"
objzumHintereingang.Name = "zum Hintereingang"
objzumHintereingang.Description = ""
objzumHintereingang.Visible = true
objzumHintereingang.Active = true
objzumHintereingang.Complete = false
objzumHintereingang.CorrectState = "None"
objHinweis2 = Wherigo.ZTask(objIAMLEGEND)
objHinweis2.Id = "58f5a17e-38c5-47a1-92d1-dd73cfe7f067"
objHinweis2.Name = "Hinweis 2"
objHinweis2.Description = [[
Suche den 2. Hinweis und trage das entschluesselte Codewort ins Notizbuch ein<BR>
<BR>
Tipp:<BR>
Falls Du nicht fuendig wirst, denke an die Medikamente, die dir das Hologramm mitgegeben hat!]]
objHinweis2.Visible = true
objHinweis2.Active = false
objHinweis2.Complete = false
objHinweis2.CorrectState = "None"
objDieSpurzumKuelhaus = Wherigo.ZTask(objIAMLEGEND)
objDieSpurzumKuelhaus.Id = "9dd4da74-d48c-490a-9c8c-a952375d62ae"
objDieSpurzumKuelhaus.Name = "Die Spur zum Kuelhaus"
objDieSpurzumKuelhaus.Description = [[
Folge der Schlurfspur zum Kuelhaus.<BR>
<BR>
Tipp:<BR>
- es gibt einen sicheren Korridor zwischen all den Zombies durch.<BR>
- beobachte die Zombies "links" und "rechts"<BR>
- versuche dich moeglichst immer zwischen den beiden zu bewegen<BR>
- entweder du beobachtest die Liste "Locations" oder du hast eine eingebaute Karte, die dir die Zonen anzeigt (z.b. bei Androids)<BR>
-falls du vom sicheren Pfad abkommst und angegriffen wirst, schaue zu, dass du schnell wieder in die Sicherheitszone kommst, die dir dann angezeigt wird!<BR>
<BR>
viel Glueck]]
objDieSpurzumKuelhaus.Visible = true
objDieSpurzumKuelhaus.Active = false
objDieSpurzumKuelhaus.Complete = false
objDieSpurzumKuelhaus.CorrectState = "None"
objSprintzumHoersaal = Wherigo.ZTask(objIAMLEGEND)
objSprintzumHoersaal.Id = "0a70b520-ad72-4aab-bab6-344daab37e41"
objSprintzumHoersaal.Name = "Sprint zum Hoersaal"
objSprintzumHoersaal.Description = [[
Sie sind ueberall! jetzt heisst es laufen und zwar dalli!<BR>
Je langsamer ich bin desto oefter werde ich gebissen.<BR>
(Nicht auf das Display achten!)<BR>
<BR>
Beim Hoersaal werde ich sicher sein..<BR>
<BR>
HOPP HOPP HOPP HOPP...]]
objSprintzumHoersaal.Visible = true
objSprintzumHoersaal.Active = false
objSprintzumHoersaal.Complete = false
objSprintzumHoersaal.CorrectState = "None"
objGehezumEingangTodeszone = Wherigo.ZTask(objIAMLEGEND)
objGehezumEingangTodeszone.Id = "f5291307-62e7-49d8-bb52-aee2c7a3c236"
objGehezumEingangTodeszone.Name = "Gehe zum Eingang Todeszone"
objGehezumEingangTodeszone.Description = [[
Tipp:<BR>
Bei "Locations" im Hauptmenue siehst du wo du hinmusst.<BR>
Falls du nicht weisst, wie du vorbeikommst, probiere einfach aus!]]
objGehezumEingangTodeszone.Visible = true
objGehezumEingangTodeszone.Active = false
objGehezumEingangTodeszone.Complete = false
objGehezumEingangTodeszone.CorrectState = "None"
objZumAussichtshuegel = Wherigo.ZTask(objIAMLEGEND)
objZumAussichtshuegel.Id = "dae065f6-18d2-488b-b009-1f7da1a0c908"
objZumAussichtshuegel.Name = "Zum Aussichtshuegel"
objZumAussichtshuegel.Description = [[
gehe zum Aussichtshuegel und verschaffe dir einen &nbsp;Ueberblick!<BR>
<BR>
Tipp:<BR>
achte auf Rote Augen, umgehe sie grossraeumig!]]
objZumAussichtshuegel.Visible = true
objZumAussichtshuegel.Active = false
objZumAussichtshuegel.Complete = false
objZumAussichtshuegel.CorrectState = "None"
objDieSpurzumAuditorium = Wherigo.ZTask(objIAMLEGEND)
objDieSpurzumAuditorium.Id = "c7650bec-e197-4480-9de7-f48a5906a4c8"
objDieSpurzumAuditorium.Name = "Die Spur zum Auditorium"
objDieSpurzumAuditorium.Description = "Gehe ueber das Feld zum Hoersaal aber vooorsichtig!"
objDieSpurzumAuditorium.Visible = true
objDieSpurzumAuditorium.Active = false
objDieSpurzumAuditorium.Complete = false
objDieSpurzumAuditorium.CorrectState = "None"
objHinweis3 = Wherigo.ZTask(objIAMLEGEND)
objHinweis3.Id = "fdd1eda2-7cf0-49f1-9799-1bb9bb5a5ccd"
objHinweis3.Name = "Hinweis 3"
objHinweis3.Description = [[
Suche den 3. Hinweis und trage das entschluesselte Codewort ins Notizbuch ein<BR>
<BR>
Falls Du nicht fuendig wirst, denke an die Medikamente, die dir das Hologramm mitgegeben hat!<BR>
Sie helfen auch, falls der Ort vermuggelt ist!! Kommt vor..]]
objHinweis3.Visible = true
objHinweis3.Active = false
objHinweis3.Complete = false
objHinweis3.CorrectState = "None"
objZurBibliothek = Wherigo.ZTask(objIAMLEGEND)
objZurBibliothek.Id = "04988654-5753-4f09-8248-e5c963162874"
objZurBibliothek.Name = "Zur Bibliothek"
objZurBibliothek.Description = [[
Gehe zum Eingang der Bibliothek.<BR>
<BR>
Tipp;<BR>
Momentan ist es ruhig, du koenntest dich hier ein wenig umschauen...<BR>
]]
objZurBibliothek.Visible = true
objZurBibliothek.Active = false
objZurBibliothek.Complete = false
objZurBibliothek.CorrectState = "None"
objZumHinterausgangderBibliothek = Wherigo.ZTask(objIAMLEGEND)
objZumHinterausgangderBibliothek.Id = "544af39c-2c85-408e-99d7-64c90f4769c1"
objZumHinterausgangderBibliothek.Name = "Zum Hinterausgang der Bibliothek"
objZumHinterausgangderBibliothek.Description = [[
Gehe zum anderen Ende der Bibliothek &nbsp;und weiche den Zombies aus...<BR>
<BR>
Tipp:<BR>
Beobachte sie genau, dann erkennst du ihr Bewegungsmuster. &nbsp;Sie tauchen immer wieder an den gleichen Stellen auf.<BR>
Wenn es nicht anders geht: RENNEN!!]]
objZumHinterausgangderBibliothek.Visible = true
objZumHinterausgangderBibliothek.Active = false
objZumHinterausgangderBibliothek.Complete = false
objZumHinterausgangderBibliothek.CorrectState = "None"
objZudenGaragen = Wherigo.ZTask(objIAMLEGEND)
objZudenGaragen.Id = "fdd6fff8-cbbc-401d-869f-5e3c3da4fe10"
objZudenGaragen.Name = "Zu den Garagen"
objZudenGaragen.Description = "Bei den Garagen laesst es sich hervorragend gruebeln, da ist es ruhig und entspannt. Da gehe hin.."
objZudenGaragen.Visible = true
objZudenGaragen.Active = false
objZudenGaragen.Complete = false
objZudenGaragen.CorrectState = "None"
obj3Codes = Wherigo.ZTask(objIAMLEGEND)
obj3Codes.Id = "013dc061-5fe4-4fc2-bc60-6cea194e6273"
obj3Codes.Name = "3 Codes"
obj3Codes.Description = "Entschluessele die 3 gefundenen Codes (und trage sie dann ins Notizbuch ein!) und loese das Gesamtraetsel dann an einem ruhigen Ort, du wirst es merken, wenn es soweit ist..."
obj3Codes.Visible = true
obj3Codes.Active = false
obj3Codes.Complete = false
obj3Codes.CorrectState = "None"
objSucheErleuchtung = Wherigo.ZTask(objIAMLEGEND)
objSucheErleuchtung.Id = "d6677de2-4508-4362-89f2-d10b3f541a00"
objSucheErleuchtung.Name = "Suche Erleuchtung!"
objSucheErleuchtung.Description = [[
Bevor du dich nun ans Raetseln machst, muss du erst noch Erleuchtung in Form eines Codes finden!<BR>
<BR>
Suche. Denke. nimm Medizin!<BR>
Benutze den Kopf, nicht die Muskeln..]]
objSucheErleuchtung.Visible = true
objSucheErleuchtung.Active = false
objSucheErleuchtung.Complete = false
objSucheErleuchtung.CorrectState = "None"
objzumFamama = Wherigo.ZTask(objIAMLEGEND)
objzumFamama.Id = "680cf55b-d4f2-4870-bd14-ee2f13c09b6c"
objzumFamama.Name = "zum Famama"
objzumFamama.Description = [[
Da gehts hin.<BR>
Und wie immer:<BR>
Obacht geben...]]
objzumFamama.Visible = true
objzumFamama.Active = false
objzumFamama.Complete = false
objzumFamama.CorrectState = "None"
objFolgederorangenSpur = Wherigo.ZTask(objIAMLEGEND)
objFolgederorangenSpur.Id = "9639a5c3-3e64-4d15-8144-800fab190446"
objFolgederorangenSpur.Name = "Folge der orangen Spur"
objFolgederorangenSpur.Description = [[
Folge der Spur des Forschers.<BR>
verlasse nicht den Weg (echt!!) und pass gut auf.<BR>
<BR>
Besonders im Wald ist es wichtig, dass Dein Geraet GPS Empfang hat, deswegen nicht in die Tasche stecken...]]
objFolgederorangenSpur.Visible = true
objFolgederorangenSpur.Active = false
objFolgederorangenSpur.Complete = false
objFolgederorangenSpur.CorrectState = "None"
objAbdurchdieMitte = Wherigo.ZTask(objIAMLEGEND)
objAbdurchdieMitte.Id = "ca1a3537-2b42-49d1-ad44-c28c0ae8e00a"
objAbdurchdieMitte.Name = "Ab durch die Mitte!"
objAbdurchdieMitte.Description = [[
Ich muss den richtigen Zeitpunkt abwarten, dass ich sicher zwischen den Zomies durchrennen kann. Also beobachte ich bei den "Locations", wann die Luft rein ist..<BR>
<BR>
Es gibt einen Hinweis, wenn ich nach dem Spurt wieder in sicheren Gefielden bin.]]
objAbdurchdieMitte.Visible = true
objAbdurchdieMitte.Active = false
objAbdurchdieMitte.Complete = false
objAbdurchdieMitte.CorrectState = "None"
objVersteckdesProfs = Wherigo.ZTask(objIAMLEGEND)
objVersteckdesProfs.Id = "5341dedd-9d5f-422c-814c-23f4a56a60e0"
objVersteckdesProfs.Name = "Versteck des Profs"
objVersteckdesProfs.Description = "Suche das Codewort. Gib es in das Notizbuch ein."
objVersteckdesProfs.Visible = true
objVersteckdesProfs.Active = false
objVersteckdesProfs.Complete = false
objVersteckdesProfs.CorrectState = "None"
objOnlineLoggen = Wherigo.ZTask(objIAMLEGEND)
objOnlineLoggen.Id = "82b9674a-1e4d-4b38-a9ff-1f371974da61"
objOnlineLoggen.Name = "Online Loggen"
objOnlineLoggen.Description = "Du kannst auf der Wherigo-Seite den Cache als \"completed\" loggen. Nimm dazu den \"Unlock-code\" den du im Notizbuch findest. "
objOnlineLoggen.Visible = true
objOnlineLoggen.Active = false
objOnlineLoggen.Complete = false
objOnlineLoggen.CorrectState = "None"
objFolgederorangenenSpur = Wherigo.ZTask(objIAMLEGEND)
objFolgederorangenenSpur.Id = "e6a01d36-6909-4507-b13f-c7f15b869b84"
objFolgederorangenenSpur.Name = "Folge der orangenen Spur"
objFolgederorangenenSpur.Description = "Kurz vor der Zombie-Front geht links eine orangene Spur weg. Folge den Reflektoren bis zur Roten Infosaeule."
objFolgederorangenenSpur.Visible = true
objFolgederorangenenSpur.Active = false
objFolgederorangenenSpur.Complete = false
objFolgederorangenenSpur.CorrectState = "None"
objHinweiszettel1 = Wherigo.ZTask(objIAMLEGEND)
objHinweiszettel1.Id = "77809643-355d-499c-9394-406b7baeb850"
objHinweiszettel1.Name = "Hinweiszettel"
objHinweiszettel1.Description = [[
Lies den (virtuellen) Zettel, den der Prof hinterlassen hat.<BR>
<BR>
(you see)]]
objHinweiszettel1.Visible = true
objHinweiszettel1.Active = false
objHinweiszettel1.Complete = false
objHinweiszettel1.CorrectState = "None"
objSpurtzumVersteck = Wherigo.ZTask(objIAMLEGEND)
objSpurtzumVersteck.Id = "f84d3324-3470-4270-b974-8d5685601db2"
objSpurtzumVersteck.Name = "Spurt zum Versteck"
objSpurtzumVersteck.Description = "folge den orangenen Reflektoren bis zum Roten. Suche dort das Codewort unter dem X.."
objSpurtzumVersteck.Visible = true
objSpurtzumVersteck.Active = false
objSpurtzumVersteck.Complete = false
objSpurtzumVersteck.CorrectState = "None"
objbenutzedeinHirn = Wherigo.ZTask(objIAMLEGEND)
objbenutzedeinHirn.Id = "d28784a0-9e2b-4c0c-80a2-e9f5c20042d8"
objbenutzedeinHirn.Name = "benutze dein Hirn"
objbenutzedeinHirn.Description = "... ist in der virtuellen Ausruestung"
objbenutzedeinHirn.Visible = true
objbenutzedeinHirn.Active = false
objbenutzedeinHirn.Complete = false
objbenutzedeinHirn.CorrectState = "None"
objHundemuggelnichtstoeren = Wherigo.ZTask(objIAMLEGEND)
objHundemuggelnichtstoeren.Id = "4230155c-2647-4b61-b44e-c16bf64ec95e"
objHundemuggelnichtstoeren.Name = "Hundemuggel nicht stoeren!!"
objHundemuggelnichtstoeren.Description = [[
Bitte unbedingt Ruecksicht nehmen auf die Hundemuggel. Wenn welche im Weg sind den "Hundemuggel" ausloesen (im Inventar).<BR>
<BR>
Die laufende Aufgabe wird uebersprungen! Missbrauch ist langweilig..]]
objHundemuggelnichtstoeren.Visible = true
objHundemuggelnichtstoeren.Active = false
objHundemuggelnichtstoeren.Complete = false
objHundemuggelnichtstoeren.CorrectState = "None"
objKnackedenContainer = Wherigo.ZTask(objIAMLEGEND)
objKnackedenContainer.Id = "74db4a85-4cbb-4029-a780-09c6626e6a3b"
objKnackedenContainer.Name = "Knacke den Container"
objKnackedenContainer.Description = "Finde die (reale) Kiste und druecke den (virtuellen) Knopf."
objKnackedenContainer.Visible = true
objKnackedenContainer.Active = false
objKnackedenContainer.Complete = false
objKnackedenContainer.CorrectState = "None"
objGehezumHinterausgang = Wherigo.ZTask(objIAMLEGEND)
objGehezumHinterausgang.Id = "15629daa-403a-4fa9-b586-c9d378bc2a3f"
objGehezumHinterausgang.Name = "Gehe zum Hinterausgang"
objGehezumHinterausgang.Description = [[
Tja, das wars dann wohl. Gehe zum Hinterausgang.<BR>
Tus einfach!]]
objGehezumHinterausgang.Visible = true
objGehezumHinterausgang.Active = false
objGehezumHinterausgang.Complete = false
objGehezumHinterausgang.CorrectState = "None"
objOeffnedenDeckel = Wherigo.ZTask(objIAMLEGEND)
objOeffnedenDeckel.Id = "de325cc6-18a0-41f8-bd00-13c4c1d2674d"
objOeffnedenDeckel.Name = "Oeffne den Deckel"
objOeffnedenDeckel.Description = ""
objOeffnedenDeckel.Visible = true
objOeffnedenDeckel.Active = false
objOeffnedenDeckel.Complete = false
objOeffnedenDeckel.CorrectState = "None"
objBerichterstatten = Wherigo.ZTask(objIAMLEGEND)
objBerichterstatten.Id = "c425ef35-ff37-4549-a0f5-01e2a14d9dde"
objBerichterstatten.Name = "Bericht erstatten"
objBerichterstatten.Description = "Nachdem du geloggt hast, erstatte deinem Chef Bericht ueber deine Heldentat."
objBerichterstatten.Visible = true
objBerichterstatten.Active = false
objBerichterstatten.Complete = false
objBerichterstatten.CorrectState = "None"
objFINAL1 = Wherigo.ZTask(objIAMLEGEND)
objFINAL1.Id = "d4011e4e-a9f1-421b-bd1b-a4b2aa2cb81b"
objFINAL1.Name = "FINAL"
objFINAL1.Description = [[
-- FINAL 53 17 039 &nbsp;12 48 910 --<BR>
bodennah]]
objFINAL1.Visible = true
objFINAL1.Active = false
objFINAL1.Complete = false
objFINAL1.CorrectState = "None"
objlebensenergievar = 100
objbrutalinfaktor = "0"
objnotizbuch = "0"
objbibzombies = true
objhirn1 = true
objcodefreigabe = "0"
objswquer = true
objhirnbrutwirkung = true
objrettungsvariable = [[
hier steht spaeter der Rettungscode<BR>
(ist jetzt noch zu frueh!)]]
objfreddy = "0"
currentZone = "objTelefon"
currentCharacter = "objHologramm"
currentItem = "objBedienungsanleitung"
currentTask = "objDerWegzurKantine"
currentInput = "objzuHause"
currentTimer = "objbissintervalllangsam"
objIAMLEGEND.ZVariables = {
  objlebensenergievar = 100,
  objbrutalinfaktor = "0",
  objnotizbuch = "0",
  objbibzombies = true,
  objhirn1 = true,
  objcodefreigabe = "0",
  objswquer = true,
  objhirnbrutwirkung = true,
  objrettungsvariable = [[
hier steht spaeter der Rettungscode<BR>
(ist jetzt noch zu frueh!)]],
  objfreddy = "0",
  currentZone = "objTelefon",
  currentCharacter = "objHologramm",
  currentItem = "objBedienungsanleitung",
  currentTask = "objDerWegzurKantine",
  currentInput = "objzuHause",
  currentTimer = "objbissintervalllangsam"
}
objbissintervalllangsam = Wherigo.ZTimer(objIAMLEGEND)
objbissintervalllangsam.Id = "d7d92077-70bd-484a-8b16-a3ffdc2a1ffa"
objbissintervalllangsam.Name = "bissintervall langsam"
objbissintervalllangsam.Description = ""
objbissintervalllangsam.Visible = true
objbissintervalllangsam.Duration = 25
objbissintervalllangsam.Type = "Interval"
objh11 = Wherigo.ZTimer(objIAMLEGEND)
objh11.Id = "e3a4d1b9-6004-456a-8805-103e7d5740f6"
objh11.Name = "h11"
objh11.Description = ""
objh11.Visible = true
objh11.Duration = 120
objh11.Type = "Countdown"
objh12 = Wherigo.ZTimer(objIAMLEGEND)
objh12.Id = "296c6c7d-4207-47b4-abdb-0cb6e462eca4"
objh12.Name = "h12"
objh12.Description = ""
objh12.Visible = true
objh12.Duration = 120
objh12.Type = "Countdown"
objh21 = Wherigo.ZTimer(objIAMLEGEND)
objh21.Id = "f747595c-40aa-4087-9fda-6cb1f4f9d552"
objh21.Name = "h21"
objh21.Description = ""
objh21.Visible = true
objh21.Duration = 120
objh21.Type = "Countdown"
objz41 = Wherigo.ZTimer(objIAMLEGEND)
objz41.Id = "ed0723ba-059f-47ed-b2d7-2803dd6716c1"
objz41.Name = "z41"
objz41.Description = ""
objz41.Visible = true
objz41.Duration = 10
objz41.Type = "Countdown"
objz42 = Wherigo.ZTimer(objIAMLEGEND)
objz42.Id = "10629525-612f-4a1b-bfc0-656d1c04e4a0"
objz42.Name = "z42"
objz42.Description = ""
objz42.Visible = true
objz42.Duration = 10
objz42.Type = "Countdown"
objHinweis4 = Wherigo.ZTimer(objIAMLEGEND)
objHinweis4.Id = "de3a88c2-d6cf-475c-8576-c8409eccaa55"
objHinweis4.Name = "Hinweis"
objHinweis4.Description = "wenn man &nbsp;&nbsp;ueber eine zone stolpert"
objHinweis4.Visible = true
objHinweis4.Duration = 4
objHinweis4.Type = "Interval"
objh13 = Wherigo.ZTimer(objIAMLEGEND)
objh13.Id = "ec2ccfda-95ce-4fc3-9a6b-d549212fccfd"
objh13.Name = "h13"
objh13.Description = ""
objh13.Visible = true
objh13.Duration = 180
objh13.Type = "Countdown"
objh22 = Wherigo.ZTimer(objIAMLEGEND)
objh22.Id = "b746bb5b-f8b9-47a7-98be-a1877c49c839"
objh22.Name = "h22"
objh22.Description = ""
objh22.Visible = true
objh22.Duration = 120
objh22.Type = "Countdown"
objh31 = Wherigo.ZTimer(objIAMLEGEND)
objh31.Id = "d4c4b764-c11d-4c16-85ba-1ab3396b9205"
objh31.Name = "h31"
objh31.Description = ""
objh31.Visible = true
objh31.Duration = 120
objh31.Type = "Countdown"
objh32 = Wherigo.ZTimer(objIAMLEGEND)
objh32.Id = "e772cc42-1e06-4bc6-9eaa-99e57d593c2c"
objh32.Name = "h32"
objh32.Description = ""
objh32.Visible = true
objh32.Duration = 120
objh32.Type = "Countdown"
objk1 = Wherigo.ZTimer(objIAMLEGEND)
objk1.Id = "91de74cc-f3db-4e05-a6c1-d1edde095bed"
objk1.Name = "k1"
objk1.Description = ""
objk1.Visible = true
objk1.Duration = 120
objk1.Type = "Countdown"
objk2 = Wherigo.ZTimer(objIAMLEGEND)
objk2.Id = "ce282f72-9908-40c4-8747-bd5c687fa3e3"
objk2.Name = "k2"
objk2.Description = ""
objk2.Visible = true
objk2.Duration = 180
objk2.Type = "Countdown"
objhirnpause = Wherigo.ZTimer(objIAMLEGEND)
objhirnpause.Id = "22f13ec0-b6f9-46fd-ba64-197c50ae2ad1"
objhirnpause.Name = "hirnpause"
objhirnpause.Description = ""
objhirnpause.Visible = true
objhirnpause.Duration = 120
objhirnpause.Type = "Countdown"
objhirn1_1 = Wherigo.ZTimer(objIAMLEGEND)
objhirn1_1.Id = "7b6cb351-eee5-4d56-8c5c-477e97bf6c54"
objhirn1_1.Name = "hirn1"
objhirn1_1.Description = ""
objhirn1_1.Visible = true
objhirn1_1.Duration = 120
objhirn1_1.Type = "Countdown"
objhirn2 = Wherigo.ZTimer(objIAMLEGEND)
objhirn2.Id = "23843bd9-7ca5-481a-b8fa-27116bfc7c0e"
objhirn2.Name = "hirn2"
objhirn2.Description = ""
objhirn2.Visible = true
objhirn2.Duration = 120
objhirn2.Type = "Countdown"
objhirn3 = Wherigo.ZTimer(objIAMLEGEND)
objhirn3.Id = "274c4426-2095-4843-9108-a76eac35fed6"
objhirn3.Name = "hirn3"
objhirn3.Description = ""
objhirn3.Visible = true
objhirn3.Duration = 120
objhirn3.Type = "Countdown"
objhirn4 = Wherigo.ZTimer(objIAMLEGEND)
objhirn4.Id = "fe33e084-d0f3-496d-a99d-6d24f108c8a7"
objhirn4.Name = "hirn4"
objhirn4.Description = ""
objhirn4.Visible = true
objhirn4.Duration = 120
objhirn4.Type = "Countdown"
objhirn5 = Wherigo.ZTimer(objIAMLEGEND)
objhirn5.Id = "ba1ba081-943a-45fe-88a5-e53f2d13a184"
objhirn5.Name = "hirn5"
objhirn5.Description = ""
objhirn5.Visible = true
objhirn5.Duration = 120
objhirn5.Type = "Countdown"
objswquer1 = Wherigo.ZTimer(objIAMLEGEND)
objswquer1.Id = "5511738e-73f4-4826-a507-762a3b91f07b"
objswquer1.Name = "swquer1"
objswquer1.Description = ""
objswquer1.Visible = true
objswquer1.Duration = 10
objswquer1.Type = "Countdown"
objswquer2 = Wherigo.ZTimer(objIAMLEGEND)
objswquer2.Id = "93f55b5f-79d5-4ac9-96ab-2e5ec7ab4148"
objswquer2.Name = "swquer2"
objswquer2.Description = ""
objswquer2.Visible = true
objswquer2.Duration = 10
objswquer2.Type = "Countdown"
objx1 = Wherigo.ZTimer(objIAMLEGEND)
objx1.Id = "18b99b39-6375-4344-8394-4c72e13e2063"
objx1.Name = "x1"
objx1.Description = ""
objx1.Visible = true
objx1.Duration = 30
objx1.Type = "Countdown"
objbissintervalllaufen = Wherigo.ZTimer(objIAMLEGEND)
objbissintervalllaufen.Id = "bb802f42-86bf-4847-8243-f9e5c9d3b554"
objbissintervalllaufen.Name = "bissintervall laufen"
objbissintervalllaufen.Description = ""
objbissintervalllaufen.Visible = true
objbissintervalllaufen.Duration = 20
objbissintervalllaufen.Type = "Interval"
objtelefon1 = Wherigo.ZTimer(objIAMLEGEND)
objtelefon1.Id = "2df71a5e-9ce0-45a3-968c-63fb509243be"
objtelefon1.Name = "telefon"
objtelefon1.Description = ""
objtelefon1.Visible = true
objtelefon1.Duration = 4
objtelefon1.Type = "Interval"
objzuHause = Wherigo.ZInput(objIAMLEGEND)
objzuHause.Id = "9b808cb2-2e01-42d7-bf64-eba2ba302620"
objzuHause.Name = "zu Hause"
objzuHause.Description = ""
objzuHause.Visible = true
objzuHause.Media = objdenk
objzuHause.Choices = {
  "Hinfahren!",
  "Weiterpennen!"
}
objzuHause.InputType = "MultipleChoice"
objzuHause.Text = "Mann-Mann-Mann, was war denn das jetzt fuer ein sonderbares Telefonat? Was mach ich denn da jetz?"
objzuHauseSoundcheck = Wherigo.ZInput(objIAMLEGEND)
objzuHauseSoundcheck.Id = "da37c2ee-8eb7-412a-89b7-6cfdf9812c74"
objzuHauseSoundcheck.Name = "zu Hause Soundcheck"
objzuHauseSoundcheck.Description = ""
objzuHauseSoundcheck.Visible = true
objzuHauseSoundcheck.Media = objdenk
objzuHauseSoundcheck.Choices = {
  "leise",
  "laut",
  "Alles Ok!"
}
objzuHauseSoundcheck.InputType = "MultipleChoice"
objzuHauseSoundcheck.Text = "Mal schaun, ob die Sounds so eingestellt sind, dass ich alles gut hoeren kann.."
objSchranke = Wherigo.ZInput(objIAMLEGEND)
objSchranke.Id = "e4bbbafc-19db-4316-a199-2eaaa24aa54d"
objSchranke.Name = "Schranke"
objSchranke.Description = ""
objSchranke.Visible = true
objSchranke.Media = objschrankpf
objSchranke.InputType = "Text"
objSchranke.Text = [[
Hei, wie war das gleich wieder mit dem Code?<BR>
Ach ja, ich hab ihn mir gleich zu Beginn meiner Ausbildung hier in die Laterne geritzt. Ich bin so schlau!<BR>
<BR>
hier ist der Code:]]
objNotizeneintragen = Wherigo.ZInput(objIAMLEGEND)
objNotizeneintragen.Id = "dd920e2c-d004-469e-998b-82d6fbef1674"
objNotizeneintragen.Name = "Notizeneintragen"
objNotizeneintragen.Description = ""
objNotizeneintragen.Visible = true
objNotizeneintragen.Media = objbuchoffen
objNotizeneintragen.InputType = "Text"
objNotizeneintragen.Text = [[
Wie praktisch, ich gebe hier den gefundenen Code ein und der Hinweis erscheint automatisch im Notizbuch!<BR>
(Ich muss allerdings geduldig sein mit dem Geraet, es kann sein, dass es etwas rechnen muss..)]]
objzuHauseGeraetecheck = Wherigo.ZInput(objIAMLEGEND)
objzuHauseGeraetecheck.Id = "11b1259f-34ae-4e1c-9b46-c8acaeef04a6"
objzuHauseGeraetecheck.Name = "zu Hause Geraetecheck"
objzuHauseGeraetecheck.Description = ""
objzuHauseGeraetecheck.Visible = true
objzuHauseGeraetecheck.Media = objdenk
objzuHauseGeraetecheck.Choices = {
  "Musik",
  "Piepsen",
  "Keine Ahnung!"
}
objzuHauseGeraetecheck.InputType = "MultipleChoice"
objzuHauseGeraetecheck.Text = [[
Erstmal muss ich schauen, was fuer ein Geraet ich hab..<BR>
Kann es Musikdateien abspielen (Android, i-phone, handy...) oder nur piespen (Garmin)]]
objzuHausePiepcheck = Wherigo.ZInput(objIAMLEGEND)
objzuHausePiepcheck.Id = "d9e705b4-239a-4777-acd2-9186e9615f6f"
objzuHausePiepcheck.Name = "zu Hause Piepcheck"
objzuHausePiepcheck.Description = ""
objzuHausePiepcheck.Visible = true
objzuHausePiepcheck.Choices = {
  "Achtung!",
  "Schaden!",
  "So, alles gemerkt.."
}
objzuHausePiepcheck.InputType = "MultipleChoice"
objzuHausePiepcheck.Text = [[
Dummerweise kann mein Geraet nur piepsen!<BR>
Umso wichtiger ist, dass ich mir die Signale anhoere und deren "Bedeutung" einpraege, nur so kann das richtige "Feeling" entstehen und eine Verwirrung vermieden werden. ]]
objzuHausesoundoderpiep = Wherigo.ZInput(objIAMLEGEND)
objzuHausesoundoderpiep.Id = "96ee5d85-dd6f-4b70-9d2b-50f739a107c9"
objzuHausesoundoderpiep.Name = "zu Hause sound oder piep"
objzuHausesoundoderpiep.Description = ""
objzuHausesoundoderpiep.Visible = true
objzuHausesoundoderpiep.Choices = {
  "Bitte nochmal!",
  "Sound",
  "Piepsen",
  "Nichts :("
}
objzuHausesoundoderpiep.InputType = "MultipleChoice"
objzuHausesoundoderpiep.Text = "Aha! Was habe ich da gerade gehoert?"
objiq1 = Wherigo.ZInput(objIAMLEGEND)
objiq1.Id = "1d67ed9a-8fe3-47bc-be31-134178222392"
objiq1.Name = "iq1"
objiq1.Description = ""
objiq1.Visible = true
objiq1.Media = objiqtest
objiq1.Choices = {
  "keinen Plan!",
  "finnische Zecke",
  "canadische Maus",
  "afrikanische Muecke",
  "canadische Zecke",
  "finnische Muecke",
  "afrikanische Zecke",
  "finnische Maus",
  "canadische Muecke",
  "afrikanische Maus"
}
objiq1.InputType = "MultipleChoice"
objiq1.Text = "Wer uebertraegt den Paamulu-Virus?"
objiq2 = Wherigo.ZInput(objIAMLEGEND)
objiq2.Id = "6d0ccd91-87bc-432f-a8c0-10a6bfa22602"
objiq2.Name = "iq2"
objiq2.Description = ""
objiq2.Visible = true
objiq2.Media = objiqtest
objiq2.Choices = {
  "keinen Plan!",
  "canadische Maus",
  "finnische Maus",
  "canadische Zecke",
  "afrikanische Maus",
  "afrikanische Muecke",
  "canadische Muecke",
  "finnische Zecke",
  "finnische Muecke",
  "afrikanische Zecke"
}
objiq2.InputType = "MultipleChoice"
objiq2.Text = "Wer uebertraegt den Kyusuna-Virus?"
objiq3 = Wherigo.ZInput(objIAMLEGEND)
objiq3.Id = "b319a04e-3dce-49d9-a5ab-ebde36f80dd1"
objiq3.Name = "iq3"
objiq3.Description = ""
objiq3.Visible = true
objiq3.Media = objiqtest
objiq3.Choices = {
  "keinen Plan!",
  "canadische Maus",
  "afrikanische Muecke",
  "canadische Muecke",
  "finnische Zecke",
  "finnische Maus",
  "canadische Zecke",
  "afrikanische Maus",
  "finnische Muecke",
  "afrikanische Zecke"
}
objiq3.InputType = "MultipleChoice"
objiq3.Text = "Wer uebertraegt den Banyumwara-Virus?"
objgerettetwerden = Wherigo.ZInput(objIAMLEGEND)
objgerettetwerden.Id = "8870e0bd-3235-43ec-bf9a-a88502167bc8"
objgerettetwerden.Name = "gerettet werden"
objgerettetwerden.Description = ""
objgerettetwerden.Visible = true
objgerettetwerden.Media = objdefib
objgerettetwerden.InputType = "Text"
objgerettetwerden.Text = [[
Gib hier den Rettungscode ein, den dir Dein Teammitglied freundlicherweise mitteilt!<BR>
<BR>
Und artig Danke sagen :)]]
objPasswort = Wherigo.ZInput(objIAMLEGEND)
objPasswort.Id = "cbbe176c-3f35-48f6-b4dd-81862286f370"
objPasswort.Name = "Passwort"
objPasswort.Description = ""
objPasswort.Visible = true
objPasswort.Media = objpasswort
objPasswort.InputType = "Text"
objPasswort.Text = "Zum Aktivieren bitte das Passwort eingeben. Dieses bekommst du nach erfolgreichem Loesen des Startraetsels im Listing...."
objbetonkiste = Wherigo.ZInput(objIAMLEGEND)
objbetonkiste.Id = "cffdce3d-31c7-46ee-9128-0fc13ce99026"
objbetonkiste.Name = "betonkiste"
objbetonkiste.Description = ""
objbetonkiste.Visible = true
objbetonkiste.Media = objdosefrage
objbetonkiste.InputType = "Text"
objbetonkiste.Text = [[
Beantworten Sie zum Oeffnen die Sicherheitsfrage:<BR>
<BR>
Wie heisst das Wort das auf der Seitenwand zu sehen ist?]]
function objIAMLEGEND:OnStart()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objPasswort)
  end)
end
function objIAMLEGEND:OnRestore()
  objHinweis4:Stop()
  objbissintervalllaufen:Stop()
  objbissintervalllangsam:Stop()
end
function objIAMLEGEND:OnSync()
  objHinweis4:Stop()
  objbissintervalllaufen:Stop()
  objbissintervalllangsam:Stop()
end
function objTelefon:OnEnter()
  currentZone = "objTelefon"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Ahh, da ist ja ein Hologramm! Mal schauen, was es zu sagen hat...<BR>
<BR>
(-&gt; You see)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objTodeszone:OnEnter()
  currentZone = "objTodeszone"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Stopp! Zutritt nur fuer autorisiertes Personal!<BR>
Geben Sie Ihren Zugangscode ein]],
    Media = objtastatur,
    Buttons = {"???"},
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(objSchranke)
        end)
      end
    end
  })
end
function objKantine:OnEnter()
  currentZone = "objKantine"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Ah, da sitzt einer! Der schaut aber gar nicht gut aus, scheint ein Wissenschaftler zu sein...<BR>
<BR>
(-&gt; you see)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objseltsameDame:OnEnter()
  currentZone = "objseltsameDame"
  objbisskauz()
end
function objseltlsamedamerahmen:OnEnter()
  currentZone = "objseltlsamedamerahmen"
  objseltsameDame.Active = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Oh, da rechts steht ja eine junge Dame (rote Augen!)<BR>
Was ist denn der passiert?<BR>
Ob die wohl Hilfe benoetigt? (siehe auch "Locations")]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objseltlsamedamerahmen:OnExit()
  currentZone = "objseltlsamedamerahmen"
  objseltsameDame.Active = false
  objHinweis4:Stop()
end
function objzombie3ausloeser:OnEnter()
  currentZone = "objzombie3ausloeser"
  objAussichtshuegel.Active = false
  objSprintzumHoersaal.Active = true
  objDieSpurzumAuditorium.Active = false
  objIAMLEGEND:RequestSync()
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Au weia! Sie haben mich bemerkt, sobald ich mich bewege, werden sie auf mich zustuermen und mich beissen...<BR>
Bei dem Hoersaal werde ich dann hoffentlich sicher sein....<BR>
<BR>
Bevor Du nun losrennst, verpack alles gut, dass du nichts verlierst! Rucksack zu? Etc.<BR>
<BR>
Und dann heissts: LAUFEN!!!<BR>
<BR>
(AUTOSAVE)]],
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
      end
    end
  })
end
function objzombie3ausloeser:OnExit()
  currentZone = "objzombie3ausloeser"
  objzombie3ausloeser.Active = false
  objHinweis4:Stop()
  objbissintervalllangsam:Start()
end
function objLagerhaus:OnEnter()
  currentZone = "objLagerhaus"
  objZombies.Active = false
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") then
    objbrutalinfaktor = "h1"
    objHinweis1.Active = true
    objDieSpurzumLagerhaus.Active = false
    objHinweis4:Start()
    _Urwigo.MessageBox({
      Text = "so, hier muss ich wohl den 1. Hinweis suchen und ins Notizbuch eintragen...",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objcodefreigabe = tostring(1)
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objAuditorium:OnEnter()
  currentZone = "objAuditorium"
  objbissintervalllangsam:Stop()
  objzombie3ausloeser.Active = false
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") then
    objmedikitII.Active = true
    objSprintzumHoersaal.Active = false
    objHinweis3.Active = true
    objbrutalinfaktor = "h3"
    objcodefreigabe = tostring(3)
    objHinweis4:Start()
    _Urwigo.MessageBox({
      Text = [[
Puh! Hier bin ich erstmal in Sicherheit!<BR>
Wo nur hat der Typ den 3. Hinweis versteckt, mal gucken..]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objZombies:OnEnter()
  currentZone = "objZombies"
  objbissintervalllangsam:Start()
end
function objZombies:OnExit()
  currentZone = "objZombies"
  objbissintervalllangsam:Stop()
end
function objKuehlhaus:OnEnter()
  currentZone = "objKuehlhaus"
  objZombielinks.Active = false
  objZombiesrechts1.Active = false
  objZombiesrechts2.Active = false
  objZombieslinks.Active = false
  objSicherheitszone.Active = false
  objz2i.Active = false
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") then
    objHinweis4:Start()
    _Urwigo.MessageBox({
      Text = "Hier muss irgendwo der 2. Hinweis versteckt sein!",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objHinweis4:Stop()
          objcodefreigabe = tostring(2)
          objbrutalinfaktor = "h2"
          objHinweis2.Active = true
          objDieSpurzumKuelhaus.Active = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objZombiedort:OnEnter()
  currentZone = "objZombiedort"
  objbiss()
end
function objZombiedrueben:OnEnter()
  currentZone = "objZombiedrueben"
  objbiss()
end
function objZombiesrechts:OnEnter()
  currentZone = "objZombiesrechts"
  objbissintervalllangsam:Start()
end
function objZombiesrechts:OnExit()
  currentZone = "objZombiesrechts"
  objbissintervalllangsam:Stop()
end
function objEingangzurBibliothek:OnEnter()
  currentZone = "objEingangzurBibliothek"
  objmedikitII.Active = false
  objEingangzurBibliothek.Active = false
  objHinterausgangBibliothek.Active = true
  objZombiesrechts.Active = true
  objZombieslinks1.Active = true
  objZurBibliothek.Active = false
  objZumHinterausgangderBibliothek.Active = true
  objz41:Start()
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Diese Mist-Viecher haben sich hier ueberall versteckt. Sie tauchen auf und gleich sind sie wieder verschwunden! Mit etwas Geschick komme ich bis zum Hinterausgang ohne gebissen zu werden.<BR>
(AUTOSAVE)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
      end
    end
  })
end
function objEingangzurBibliothek:OnExit()
  currentZone = "objEingangzurBibliothek"
  objHinweis4:Stop()
end
function objGaragen:OnEnter()
  currentZone = "objGaragen"
  objHinterausgangBibliothek.Active = false
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") then
    objcodefreigabe = tostring(4)
    objnotizbuch = "31"
    objSucheErleuchtung.Active = true
    objZudenGaragen.Active = false
    objbrutalinfaktor = "k0"
    objHinweis4:Start()
    _Urwigo.MessageBox({
      Text = [[
Ohh ist das entspannt hier, wenn ich doch nur wuesste wo ich.. hm.... Hier muss es doch irgendwo sein..<BR>
<BR>
(-&gt;Tasks)]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objHinweis4:Stop()
        end
      end
    })
  end
end
function objZombielinks:OnEnter()
  currentZone = "objZombielinks"
  objSicherheitszone.Active = true
  objintervallbissenter()
end
function objZombielinks:OnExit()
  currentZone = "objZombielinks"
  objSicherheitszone.Active = false
  objintervallbissexit()
end
function objZombiesrechts1:OnEnter()
  currentZone = "objZombiesrechts1"
  objSicherheitszone.Active = true
  objintervallbissenter()
end
function objZombiesrechts1:OnExit()
  currentZone = "objZombiesrechts1"
  objSicherheitszone.Active = false
  objintervallbissexit()
end
function objZombieslinks:OnEnter()
  currentZone = "objZombieslinks"
  objSicherheitszone.Active = true
  objintervallbissenter()
end
function objZombieslinks:OnExit()
  currentZone = "objZombieslinks"
  objSicherheitszone.Active = false
  objintervallbissexit()
end
function objZombiesrechts2:OnEnter()
  currentZone = "objZombiesrechts2"
  objSicherheitszone.Active = true
  objintervallbissenter()
end
function objZombiesrechts2:OnExit()
  currentZone = "objZombiesrechts2"
  objSicherheitszone.Active = false
  objintervallbissexit()
end
function objz2i:OnEnter()
  currentZone = "objz2i"
  objZombielinks.Active = true
  objZombiesrechts1.Active = true
  objZombiesrechts2.Active = false
  objZombieslinks.Active = false
end
function objz2i:OnExit()
  currentZone = "objz2i"
  objZombielinks.Active = false
  objZombiesrechts1.Active = false
  objZombiesrechts2.Active = true
  objZombieslinks.Active = true
  objmedikit1.Active = false
end
function objAussichtshuegel:OnEnter()
  currentZone = "objAussichtshuegel"
  objZombieza2.Active = false
  objZombieza3.Active = false
  objZombiea1.Active = false
  objZumAussichtshuegel.Active = false
  objDieSpurzumAuditorium.Active = true
  objzombie3ausloeser.Active = true
  objAuditorium.Active = true
  objrettungsvariable = "stg25819"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Oh weh! Ich muss zu dem kleinen Waldstueck Richtung nordwesten, dort ist der Hoersaal, da ist er wohl hingelaufen.<BR>
Dummerweise sind diese verdammten Zombies ueberall auf dem Feld. Ich muss versuchen mich da vorsichtig durchzuschleichen...<BR>
]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objAussichtshuegel.Active = false
        objHinweis4:Stop()
      end
    end
  })
end
function objAussichtshuegel:OnExit()
  currentZone = "objAussichtshuegel"
  objHinweis4:Stop()
end
function objHinterausgangBibliothek:OnEnter()
  currentZone = "objHinterausgangBibliothek"
  objbibzombies = false
  objmedikitII.Active = false
  objZombiesrechts.Active = false
  objZombieslinks1.Active = false
  objZumHinterausgangderBibliothek.Active = false
  objZudenGaragen.Active = true
  objrettungsvariable = "hbib3512"
  objGaragen.Active = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Und zack! Zu die Tuer. Dreckskreaturen!!!<BR>
<BR>
Jetzt ist es nicht mehr weit zu den Kryotanks, da knacke ich in Ruhe das beknackte 3-Finger system!<BR>
<BR>
(AUTOSAVE)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objcodefreigabe = tostring(0)
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        objIAMLEGEND:RequestSync()
      end
    end
  })
end
function objHinterausgangBibliothek:OnExit()
  currentZone = "objHinterausgangBibliothek"
  objHinweis4:Stop()
end
function objZombiea1:OnEnter()
  currentZone = "objZombiea1"
  objbiss()
end
function objZombieza2:OnEnter()
  currentZone = "objZombieza2"
  objbiss()
end
function objZombieza3:OnEnter()
  currentZone = "objZombieza3"
  objbiss()
end
function objZombieslinks1:OnEnter()
  currentZone = "objZombieslinks1"
  objbissintervalllangsam:Start()
end
function objZombieslinks1:OnExit()
  currentZone = "objZombieslinks1"
  objbissintervalllangsam:Stop()
end
function objFamama:OnEnter()
  currentZone = "objFamama"
  objHundemuggelnichtstoeren.Active = false
  objzumFamama.Active = false
  objFolgederorangenSpur.Active = true
  objHundemuggel.Visible = false
  objbrutalinfaktor = "ende"
  objrettungsvariable = "fama5410"
  objFamama.Active = false
  objswzombiesquerrahmen.Active = true
  objswquerstop.Active = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Ok, ich seh' schon!<BR>
der Forscher ist schon ein Hundling, hat der glatt eine leuchtende Spur dort an der Ecke gelegt.<BR>
Der folge ich mal (orange Reflektoren)!<BR>
<BR>
Super, das ist ja wie bei einer Schnitzeljagd, ich hab' da so Freunde, die machen sowas mit ihren Handys und hinterher schreiben sie das ins Internetz oder so..<BR>
Egal, ich habe eine Auftrag und wenn der nur "Ueberleben" heisst..<BR>
<BR>
(AUTOSAVE)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        objIAMLEGEND:RequestSync()
      end
    end
  })
end
function objZombies1:OnEnter()
  currentZone = "objZombies1"
  objbiss()
end
function objswzombiesquerrahmen:OnEnter()
  currentZone = "objswzombiesquerrahmen"
  objswquer1:Start()
  objHinweis4:Start()
  objAbdurchdieMitte.Active = true
  _Urwigo.MessageBox({
    Text = [[
Oh je, da vorne ist eine Kreuzung.<BR>
Da queren diese Zombies meinen Weg. Ich muss da eine Luecke finden, in der ich durchsausen kann!<BR>
(zuerst Zombies beobachten, dann LAUFEN!!)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objswquerstop:OnEnter()
  currentZone = "objswquerstop"
  objAbdurchdieMitte.Active = false
  objswquer = false
  objswzombiesquerrahmen.Active = false
  objfinalewarnung.Active = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
puh, geschafft...<BR>
<BR>
(AUTOSAVE)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        objIAMLEGEND:RequestSync()
      end
    end
  })
end
function objfinalewarnung:OnEnter()
  currentZone = "objfinalewarnung"
  objFolgederorangenSpur.Active = false
  objFolgederorangenenSpur.Active = true
  objswquerstop.Active = false
  objHundertevonihnen.Active = true
  objroteInfosaeule.Active = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Oh mein Gott, ich kann sie hoeren, da vorne muessen ja Hunderte sein, da ist wirklich kein Durchkommen (siehe Locations).<BR>
<BR>
Zum Glueck gibt es eine Abzweigung!<BR>
Kurz vor den Zombies geht auf der linken Seite ein Weg weg, der mit orangenen Reflektoren markiert ist. Dieser fuehrt zur Roten Infosaeule.]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objfinalewarnung.Active = false
        objHinweis4:Stop()
      end
    end
  })
end
function objHundertevonihnen:OnEnter()
  currentZone = "objHundertevonihnen"
  objbissintervalllangsam:Start()
end
function objHundertevonihnen:OnExit()
  currentZone = "objHundertevonihnen"
  objbissintervalllangsam:Stop()
end
function objmedikit1:OnEnter()
  currentZone = "objmedikit1"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
cool! Hier liegt ein 1.Hilfe Koffer rum, den kann ich gut brauchen!<BR>
(-&gt; you see)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objmedikitII:OnEnter()
  currentZone = "objmedikitII"
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = [[
Ui, ein 1. Hilfe-Koffer!<BR>
G'schmeidig, da kann ich mich etwas verarzten! Den nehm ich mit..<BR>
(-&gt; I see)]],
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objroteInfosaeule:OnEnter()
  currentZone = "objroteInfosaeule"
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") then
    objFolgederorangenenSpur.Active = false
    objHinweiszettel1.Active = true
    objHundertevonihnen.Active = false
    objHinweis4:Start()
    _Urwigo.MessageBox({
      Text = [[
Hier an der Roten Infosaeule hangt ein Zettel. Der Prof hat eine Nachricht hinterlassen.<BR>
<BR>
Schlaues Kerlchen, er musste wohl geahnt haben, dass diese Untoten so ihre Schwierigkeiten mit lesen haben.<BR>
<BR>
("You see")]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objHinweis.Visible = true
          objcodefreigabe = "5"
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objStrehlow:OnEnter()
  currentZone = "objStrehlow"
  if Wherigo.NoCaseEquals(objcodefreigabe, "0") or Wherigo.NoCaseEquals(objcodefreigabe, "5") then
    objrettungsvariable = "finl4780"
    objcodefreigabe = "6"
    objbrutalinfaktor = "x"
    objVersteckdesProfs.Active = true
    objSpurtzumVersteck.Active = false
  end
end
function objnichtbetreten:OnEnter()
  currentZone = "objnichtbetreten"
  objnichtbetreten.Active = false
  objZombiesrechts2.Active = true
  objZombieslinks.Active = true
end
function h2:OnEnter()
  currentZone = "h2"
  objcodefreigabe = "7"
end
function objzuHause:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Hinfahren!") then
    _Urwigo.MessageBox({
      Text = [[
Meine Sieben Sachen habe ich ja schon gepackt (zum Teil sind sie bei "Inventory" zu finden).<BR>
Trotzdem sollte ich noch mein elektronisches Geraet auf Funktionstuechtigkeit pruefen...]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objzuHauseGeraetecheck)
          end)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "Weiterpennen!") then
    _Urwigo.MessageBox({
      Text = "Hach, ist das schoen kuschelig in meinem Bett, ich brauch doch meinen Schoenheitsschlaf! So viel Aufregung tut nicht gut, da mach ich doch lieber einen gemuetlichen Tradi wenn die Sonne wieder hoch am Himmel steht..",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.Command("SaveClose")
        end
      end
    })
  end
end
function objzuHauseSoundcheck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "leise") then
    Wherigo.PlayAudio(objsoundHinweis)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHauseSoundcheck)
    end)
  elseif Wherigo.NoCaseEquals(input, "laut") then
    Wherigo.PlayAudio(objsoundlaut)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHauseSoundcheck)
    end)
  else
    _Urwigo.MessageBox({
      Text = [[
Toll, wenn die Technik funzt!<BR>
Jetzt kann ich mich noch mit dem Geraet vertraut machen.<BR>
(-&gt; Locations -&gt;Inventory -&gt;Tasks)<BR>
Danach aber schnell zum Start, hoffentlich bin ich dann nicht zu spaet!]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objIAMLEGEND:RequestSync()
          objTelefon.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objSchranke:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "2020") then
    _Urwigo.MessageBox({
      Text = "Der Zugang ist gestattet!",
      Media = objtastaturOK,
      Buttons = {
        "Schranke oeffnen"
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.PlayAudio(objsoundschranke)
          objTodeszone.Active = false
          objGehezumEingangTodeszone.Active = false
          objDerWegzurKantine.Active = true
          objrettungsvariable = "pass5930"
          objseltlsamedamerahmen.Active = true
          objKantine.Active = true
          _Urwigo.MessageBox({
            Text = [[
Na gut, dann schau ich mich hier mal um! Hier entlang gehts zur Kantine, soviel wie da immer geratscht wird, kann ich da bestimmt etwas in Erfahrung bringen!<BR>
Genaueres erfahre ich bei den "Tasks"]],
            Media = objdenk,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = [[
An entscheidenden Huerden wird automatisch gespeichert, so muss ich nicht ganz von Vorne anfangen, sehr praktisch!<BR>
(AUTOSAVE)]],
                  Media = objdenk,
                  Callback = function(action)
                    if action ~= nil then
                      objIAMLEGEND:RequestSync()
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
  elseif Wherigo.NoCaseEquals(input, "1968") then
    _Urwigo.MessageBox({
      Text = "Dieser Code ist veraltet und funktioniert nicht mehr. Du bist mit einer veralteten Cartridge unterwegs. Lade Dir die aktuelle herunter.",
      Media = objtastatur,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objSchranke)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Oh, das ist der falsche Code, da gibt es noch einen anderen.",
      Media = objtastatur,
      Buttons = {
        "neuer Versuch",
        "Abbruch"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" == true then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(objSchranke)
            end)
          elseif action == "Button2" == true then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objNotizeneintragen:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "paamulu") then
    if Wherigo.NoCaseEquals(objcodefreigabe, tostring(1)) then
      objh11:Stop()
      objh12:Stop()
      objh13:Stop()
      objZombies.Active = false
      objLagerhaus.Active = false
      objz2i.Active = true
      objZombielinks.Active = true
      objZombiesrechts1.Active = true
      objKuehlhaus.Active = true
      objmedikit1.Active = true
      objHinweis1.Active = false
      objDieSpurzumKuelhaus.Active = true
      objHundemuggelnichtstoeren.Active = true
      objrettungsvariable = "stg15610"
      objbrutalinfaktor = "0"
      objcodefreigabe = tostring(0)
      objnotizbuch = tostring(1)
      objHundemuggel.Visible = true
      objBrutalin.Commands.cmdNocheine.Enabled = false
      objBrutalin.Commands.cmdWirktesschon.Enabled = false
      objBrutalin.Commands.cmdEinnahme.Enabled = true
      _Urwigo.MessageBox({
        Text = [[
Aha der "Paamulu"-Virus also..<BR>
<BR>
Hinweise:<BR>
- Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
<BR>
- Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
<BR>
(Diese Hinweise sind nun im Notizbuch vermerkt)<BR>
<BR>
Anscheinend ist der wissenschaftliche Mitarbeiter weiter gelaufen!<BR>
Hinterher!<BR>
<BR>
Um den naechsten Hinweis heile zu erreichen schaue ich mir lieber noch den Task an (ist immer zu empfehlen...)<BR>
<BR>
(AUTOSAVE)]],
        Media = objdenk,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            objIAMLEGEND:RequestSync()
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "dieser Code ist zur falschen Zeit oder doppelt eingegeben worden!",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(input, "Banyumwara") then
    if Wherigo.NoCaseEquals(objcodefreigabe, tostring(2)) then
      objh21:Stop()
      objh22:Stop()
      objKuehlhaus.Active = false
      objZombieza3.Active = true
      objZombieza2.Active = true
      objZombiea1.Active = true
      objAussichtshuegel.Active = true
      objHinweis2.Active = false
      objZumAussichtshuegel.Active = true
      objrettungsvariable = "stg27810"
      objbrutalinfaktor = "0"
      objcodefreigabe = tostring(0)
      objnotizbuch = tostring(2)
      objBrutalin.Commands.cmdWirktesschon.Enabled = false
      objBrutalin.Commands.cmdNocheine.Enabled = false
      objBrutalin.Commands.cmdEinnahme.Enabled = true
      _Urwigo.MessageBox({
        Text = [[
Soso, das "Banyumwara"-Virus<BR>
<BR>
Hinweise:<BR>
- Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
<BR>
- Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
<BR>
Jetzt gehe ich erst mal zu dem Aussichtshuegel und verschaffe mir einen Ueberblick.<BR>
<BR>
(AUTOSAVE)]],
        Media = objdenk,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            objIAMLEGEND:RequestSync()
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "dieser Code ist zur falschen Zeit oder doppelt eingegeben worden!",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(input, "kyusuna") then
    if Wherigo.NoCaseEquals(objcodefreigabe, tostring(3)) then
      objh31:Stop()
      objh32:Stop()
      objzombie3ausloeser.Active = false
      objAuditorium.Active = false
      objEingangzurBibliothek.Active = true
      objHinweis3.Active = false
      objZurBibliothek.Active = true
      objrettungsvariable = "stg32519"
      objbrutalinfaktor = "0"
      objcodefreigabe = tostring(0)
      objnotizbuch = tostring(3)
      objBrutalin.Commands.cmdNocheine.Enabled = false
      objBrutalin.Commands.cmdWirktesschon.Enabled = false
      objBrutalin.Commands.cmdEinnahme.Enabled = true
      _Urwigo.MessageBox({
        Text = [[
Hm, das "Kyusuna"-Virus<BR>
<BR>
Hinweise:<BR>
- Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
<BR>
- Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Tja und was soll mir das jetzt alles sagen? Das klingt alles nach diesen bescheuerten Logik-Raetseln..<BR>
Mensch, wo habe ich bloss mein Hirn gelassen?<BR>
<BR>
Bevor ich mich aber ins Loesen stuerze gehe ich lieber zuerst &nbsp;an einen Ort, wo &nbsp;es sich besser gruebeln laesst! Bei den Kryotanks hinter der Bibliothek, da sollte ich meine Ruhe haben, dieses untote Gesocks haelt mich ganz schoen auf Trab..<BR>
<BR>
(-Tasks&gt;)<BR>
<BR>
(AUTOSAVE)]],
        Media = objdenk,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            objIAMLEGEND:RequestSync()
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "dieser Code ist zur falschen Zeit oder doppelt eingegeben worden!",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(input, "4") then
    if Wherigo.NoCaseEquals(objcodefreigabe, tostring(4)) then
      objk1:Stop()
      objk2:Stop()
      objSucheErleuchtung.Active = false
      objbenutzedeinHirn.Active = true
      objcodefreigabe = tostring(0)
      objbrutalinfaktor = "h"
      objBrutalin.Commands.cmdEinnahme.Enabled = true
      objBrutalin.Commands.cmdWirktesschon.Enabled = false
      objBrutalin.Commands.cmdNocheine.Enabled = false
      objHirn.Visible = true
      _Urwigo.MessageBox({
        Text = [[
Ahhhh! Mei bin ich schlau!<BR>
Jetzt kann ich endlich mein Hirn anstrengen und schauen ob ich dieses doofe 3-Finger-System loesen kann. Hier wird mein (reeller) Zettel mit echtem Stift nuetzlich sein..<BR>
Wenn ich eine Loesung habe kann ich es testen ob ich richtig liege.<BR>
(siehe Items "Hirn").<BR>
Dabei darf ich die Medizin nicht vergessen...]],
        Media = objdenk,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            objIAMLEGEND:RequestSync()
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "dieser Code ist zur falschen Zeit oder doppelt eingegeben worden!",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(input, "depot51") then
    if Wherigo.NoCaseEquals(objcodefreigabe, "6") then
      objx1:Stop()
      objBrutalin.Commands.cmdWirktesschon.Enabled = false
      objBrutalin.Commands.cmdNocheine.Enabled = false
      objBrutalin.Commands.cmdEinnahme.Enabled = true
      objbrutalinfaktor = "ende"
      objrettungsvariable = "finl4780"
      objVersteckdesProfs.Active = false
      objGehezumHinterausgang.Active = true
      objStrehlow.Active = false
      h2.Active = true
      _Urwigo.MessageBox({
        Text = [[
Oh nein, hier muss das Heilmittel versteckt gewesen sein, aber da ist nur noch ein Loch im Boden. Ich war zu langsam, es wurde geklaut!<BR>
<BR>
Tja das wars dann wohl. Die Apocalypse ist nah!<BR>
Bleibt mir nur noch nach Hause zu fahren und mich fuer den Zombieansturm zu wappnen.]],
        Media = objdenk,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            objIAMLEGEND:RequestSync()
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = "dieser Code ist zur falschen Zeit oder doppelt eingegeben worden!<BR>\n",
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif Wherigo.NoCaseEquals(input, "123") then
    _Urwigo.MessageBox({
      Text = [[
plus1001<BR>
Paamulu<BR>
Banyumwara<BR>
Kyusuna<BR>
pass5930<BR>
kant5910<BR>
stg15610<BR>
stg27810<BR>
stg25819<BR>
stg32519<BR>
hbib3512<BR>
kryo5312<BR>
fama5410<BR>
baum5733<BR>
finl4780<BR>
Ende5639<BR>
f-2cheat]]
    })
  elseif Wherigo.NoCaseEquals(input, "plus1001") then
    objlebensenergievar = objlebensenergievar + 1000
  elseif Wherigo.NoCaseEquals(input, "paracomplete") then
    objIAMLEGEND.Complete = true
    objNotizbuch.Commands.cmdUnlockcode.Enabled = true
  elseif Wherigo.NoCaseEquals(input, "test") or Wherigo.NoCaseEquals(input, "geocaching") or Wherigo.NoCaseEquals(input, "zombie") or Wherigo.NoCaseEquals(input, "keogarl") then
    _Urwigo.MessageBox({
      Text = "ohoh, von blinden Versuchen wuerde ich die Finger lassen, das kann nach hinten losgehen..",
      Media = objanleitung,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "CNNZHYH") then
    _Urwigo.MessageBox({
      Text = [[
Ok, das ist schon der richtige Hinweis, nur muss er erst noch entschluesselt werden, bloss wie? Ich habe so eine Vermutung, dass da was in meinem Arbeitsvertrag gestanden hat, so eine Tabelle...<BR>
(zur Not: Tabletten vom Prof.)]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "5599988777788662") then
    _Urwigo.MessageBox({
      Text = [[
Ok, das ist schon der richtige Hinweis, nur muss er erst noch entschluesselt werden, bloss wie? Irgendwie habe ich die Vermutung es koennte was mit einem Handy zu tun haben..<BR>
(zur Not: Tabletten vom Prof.)]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "hilfe") then
    _Urwigo.MessageBox({
      Text = "Hilfe? wer soll mir denn helfen? Ich bin allein auf mich gestellt, huaaaahhh.....",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "hirn") or Wherigo.NoCaseEquals(input, "gebt mir hirn") or Wherigo.NoCaseEquals(input, "gebt mir hirn!") or Wherigo.NoCaseEquals(input, "ich will hirn!") then
    _Urwigo.MessageBox({
      Text = [[
Hirn? habe ich das echt gerade geschrieben? Oh weh, ich glaube der Virus macht sich schon bemerkbar! ich habe nicht mehr viel Zeit...<BR>
(Nach dem richtigen Code muss ich jetzt noch schauen, das wars nicht..)]],
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Falscher Code!",
      Media = objbuchoffen,
      Buttons = {
        "neuer Versuch",
        "ich geb' auf!"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(objNotizeneintragen)
            end)
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objzuHauseGeraetecheck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Musik") then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHauseSoundcheck)
    end)
  elseif Wherigo.NoCaseEquals(input, "Piepsen") then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausePiepcheck)
    end)
  else
    Wherigo.PlayAudio(objsoundHinweis)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausesoundoderpiep)
    end)
  end
end
function objzuHausePiepcheck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Achtung!") then
    Wherigo.PlayAudio(objsoundHinweis)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausePiepcheck)
    end)
  elseif Wherigo.NoCaseEquals(input, "Schaden!") then
    Wherigo.PlayAudio(objsoundlaut)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausePiepcheck)
    end)
  else
    _Urwigo.MessageBox({
      Text = [[
Toll, wenn die Technik funzt!<BR>
Jetzt kann ich mich noch mit dem Geraet vertraut machen.<BR>
(-&gt; Locations -&gt;Inventory -&gt;Tasks)<BR>
Danach aber schnell zum Hintereingang des Forschungszentrums geduest, hoffentlich bin ich dann nicht zu spaet!]],
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          objIAMLEGEND:RequestSync()
          objTelefon.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objzuHausesoundoderpiep:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "Bitte nochmal!") then
    Wherigo.PlayAudio(objsoundHinweis)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausesoundoderpiep)
    end)
  elseif Wherigo.NoCaseEquals(input, "Sound") then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHauseSoundcheck)
    end)
  elseif Wherigo.NoCaseEquals(input, "Piepsen") then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHausePiepcheck)
    end)
  else
    _Urwigo.MessageBox({
      Text = "Oh je, da habe ich jetzt aber ein Problem! Mit diesem Geraet klappt das nicht! Der Cache wird so leider nur schwer machbar sein! Es geht nur, wenn ich die ganze Zeit auf mein Display schaue und auf diese Art \"Veraenderungen\" bemerke! ",
      Buttons = {
        "Dann halt nicht!",
        "Trotzdem versuch ichs.."
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            Wherigo.Command("SaveClose")
          else
            _Urwigo.MessageBox({
              Text = [[
So viel Zeit vertueddelt...<BR>
Jetzt aber mal schnell zum Hintereingang des Forschungszentrums geduest, hoffentlich bin ich nicht zu spaet!]],
              Media = objdenk,
              Callback = function(action)
                if action ~= nil then
                  objTelefon.Active = true
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
function objiq1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "finnische Maus") then
    objiqpositiv()
  elseif Wherigo.NoCaseEquals(input, "keinen Plan!") then
    _Urwigo.MessageBox({
      Text = "Bevor ich was falsches tippe, ueberlege ich noch weiter, besser so!",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objhirnpause:Start()
    _Urwigo.MessageBox({
      Text = ([[
ui, das war falsch! Da habe ich jetzt gehudelt!<BR>
Lieber nochmal nachdenken, &nbsp;(unter Zuhilfenahme von Brutalin..)<BR>
<BR>
In ]] .. objhirnpause.Remaining) .. " Sekunden kann ich einen weiteren Versuch starten.",
      Media = objdenk,
      Buttons = {
        "Aktualisieren",
        "Weiter raetseln"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objhirn6()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objiq2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "canadische Zecke") then
    objiqpositiv()
  elseif Wherigo.NoCaseEquals(input, "keinen Plan!") then
    _Urwigo.MessageBox({
      Text = "Bevor ich was falsches tippe, ueberlege ich noch weiter, besser so!",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objhirnpause:Start()
    _Urwigo.MessageBox({
      Text = ([[
ui, das war falsch! Da habe ich jetzt gehudelt!<BR>
Lieber nochmal nachdenken, &nbsp;(unter Zuhilfenahme von Brutalin..)<BR>
<BR>
In ]] .. objhirnpause.Remaining) .. " Sekunden kann ich einen weiteren Versuch starten.",
      Media = objdenk,
      Buttons = {
        "Aktualisieren",
        "Weiter raetseln"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objhirn6()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objiq3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "afrikanische Muecke") then
    objiqpositiv()
  elseif Wherigo.NoCaseEquals(input, "keinen Plan!") then
    _Urwigo.MessageBox({
      Text = "Bevor ich was falsches tippe, ueberlege ich noch weiter, besser so!",
      Media = objdenk,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objhirnpause:Start()
    _Urwigo.MessageBox({
      Text = ([[
ui, das war falsch! Da habe ich jetzt gehudelt!<BR>
Lieber nochmal nachdenken, &nbsp;(unter Zuhilfenahme von Brutalin..)<BR>
<BR>
In ]] .. objhirnpause.Remaining) .. " Sekunden kann ich einen weiteren Versuch starten.",
      Media = objdenk,
      Buttons = {
        "Aktualisieren",
        "Weiter raetseln"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objhirn6()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objgerettetwerden:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "pass5930") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann... Wobei es schon schwierig werden wird, wenn das Geraet jetzt schon abstuerzt :(]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objKantine.Active = true
          objseltlsamedamerahmen.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "kant5910") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 74
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objDieSpurzumLagerhaus.Active = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objLagerhaus.Active = true
          objZombies.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "stg15610") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objHundemuggelnichtstoeren.Active = true
    objTelefon.Active = false
    objlebensenergievar = 64
    objHundemuggel.Visible = true
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objDieSpurzumKuelhaus.Active = true
    objnotizbuch = tostring(1)
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objmedikit1.Active = true
          objKuehlhaus.Active = true
          objz2i.Active = true
          objZombiesrechts1.Active = true
          objZombielinks.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "stg27810") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 54
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objZumAussichtshuegel.Active = true
    objHundemuggelnichtstoeren.Active = true
    objHundemuggel.Visible = true
    objnotizbuch = tostring(2)
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objAussichtshuegel.Active = true
          objZombiea1.Active = true
          objZombieza2.Active = true
          objZombieza3.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "stg25819") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 49
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objDieSpurzumAuditorium.Active = true
    objHundemuggelnichtstoeren.Active = true
    objnotizbuch = tostring(2)
    objHundemuggel.Visible = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objAuditorium.Active = true
          objzombie3ausloeser.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "stg32519") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 39
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objZurBibliothek.Active = true
    objMediKit.Visible = true
    objnotizbuch = "3"
    objHundemuggel.Visible = true
    objHundemuggelnichtstoeren.Active = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objEingangzurBibliothek.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "hbib3512") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 29
    objBrutalin.Visible = true
    obj3Codes.Active = true
    objZudenGaragen.Active = true
    objHundemuggelnichtstoeren.Active = true
    objHundemuggel.Visible = true
    objnotizbuch = "3"
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objGaragen.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "kryo5312") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 25
    objBrutalin.Visible = true
    objzumFamama.Active = true
    objHirn1.Visible = true
    objnotizbuch = "e"
    objHundemuggel.Visible = true
    objHundemuggelnichtstoeren.Active = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objFamama.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "fama5410") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 23
    objBrutalin.Visible = true
    objFolgederorangenSpur.Active = true
    objHirn1.Visible = true
    objnotizbuch = "e"
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objswzombiesquerrahmen.Active = true
          objswquerstop.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "baum5733") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 14
    objBrutalin.Visible = true
    objHirn1.Visible = true
    objcodefreigabe = "5"
    objnotizbuch = "e"
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Ich schaue mal ob alles in Ordnung ist. Falls irgendwas nicht so richtig laeuft, kann ich mich nach der naechsten Station nochmal reanimieren lassen, vielleicht klappts dann...]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          objSpurtzumVersteck.Active = true
          objHinweiszettel.Visible = true
          objStrehlow.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "finl4780") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 14
    objBrutalin.Visible = true
    objHirn1.Visible = true
    objbrutalinfaktor = "ende"
    objcodefreigabe = "6"
    objnotizbuch = "e"
    objGehezumHinterausgang.Active = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier in diesem Alptraum...<BR>
<BR>
Na gut, hilft ja eh nix. Anscheinend ist hier ja eh schon Ende Gelaende..]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          h2.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "Ende5639") then
    Wherigo.PlayAudio(objsoundappear)
    objBedienungsanleitung.Visible = false
    objzumHintereingang.Active = false
    objTelefon.Active = false
    objlebensenergievar = 9
    objBrutalin.Visible = true
    objHirn1.Visible = true
    objbrutalinfaktor = "ende"
    objcodefreigabe = "0"
    objnotizbuch = "e"
    objNotizbuch.Commands.cmdUnlockcode.Enabled = true
    objIAMLEGEND.Complete = true
    _Urwigo.MessageBox({
      Text = [[
... ich habe da dieses Licht gesehen! Es war so freundlich, doch dann auf einmal... wurde ich zurueckgerissen und jetzt bin ich wieder hier.. Wie es aussieht ist hier aber eh ENDE.<BR>
Zumindest den Unlock-code kann ich noch abstauben..]],
      Media = objrettung,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Hm, es tut sich nichts, ist wohl ein falscher Code!",
      Media = objdenk
    })
  end
end
function objPasswort:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "GC8HZ1N") then
    _Urwigo.MessageBox({
      Text = [[
Bist Du Dir absolut sicher?<BR>
Du kannst bei der Mission drauf gehen....]],
      Media = objangst,
      Buttons = {"Los gehts!"},
      Callback = function(action)
        if action ~= nil then
          objtelefon1:Start()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(input, "Hirnwurst") then
    _Urwigo.MessageBox({
      Text = "Dieses Passwort ist leider nicht mehr aktuell. Beantrage bitte ein neues, du weisst schon wie...",
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objPasswort)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = "Nein, das war falsch!",
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(objPasswort)
          end)
        end
      end
    })
  end
end
function objbetonkiste:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, "biohazard") or Wherigo.NoCaseEquals(input, "biogefaehrdung") or Wherigo.NoCaseEquals(input, "biologische gefaehrdung") or Wherigo.NoCaseEquals(input, "biologische gefahr") then
    Wherigo.PlayAudio(objsounddose)
    _Urwigo.MessageBox({
      Text = "Korrekt!",
      Callback = function(action)
        if action ~= nil then
          objfreddy = "3"
          h2.ShowObjects = "Always"
          h2.Visible = false
          objContainer.Visible = false
          objKnackedenContainer.Active = false
          objOeffnedenDeckel.Active = true
          objBerichterstatten.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    objfreddy = "2"
    _Urwigo.MessageBox({
      Text = "das ist leider falsch!"
    })
  end
end
function objbissintervalllangsam:OnStart()
  objbiss()
end
function objh11:OnStart()
  objbrutalinfaktor = "h11s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objh11:OnTick()
  objbrutalinfaktor = "h11e"
  objHinweis4:Start()
  objwirktsschon()
end
function objh12:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objh12:OnTick()
  objbrutalinfaktor = "h12e"
  objHinweis4:Start()
  objwirktsschon()
end
function objh21:OnStart()
  objbrutalinfaktor = "h21s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objh21:OnTick()
  objbrutalinfaktor = "h21e"
  objHinweis4:Start()
  objwirktsschon()
end
function objz41:OnStart()
  objZombiedort.Active = true
end
function objz41:OnTick()
  objZombiedort.Active = false
  if objbibzombies == true then
    objz42:Start()
  end
end
function objz42:OnStart()
  objZombiedrueben.Active = true
end
function objz42:OnTick()
  objZombiedrueben.Active = false
  if objbibzombies == true then
    objz41:Start()
  end
end
function objHinweis4:OnStart()
  Wherigo.PlayAudio(objsoundHinweis)
end
function objh13:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objh13:OnTick()
  objbrutalinfaktor = "h13e"
  objHinweis4:Start()
  objwirktsschon()
end
function objh22:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objh22:OnTick()
  objbrutalinfaktor = "h22e"
  objHinweis4:Start()
  objwirktsschon()
end
function objh31:OnStart()
  objbrutalinfaktor = "h31s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objh31:OnTick()
  objbrutalinfaktor = "h31e"
  objHinweis4:Start()
  objwirktsschon()
end
function objh32:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objh32:OnTick()
  objbrutalinfaktor = "h32e"
  objHinweis4:Start()
  objwirktsschon()
end
function objk1:OnStart()
  objbrutalinfaktor = "k1s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objk1:OnTick()
  objbrutalinfaktor = "k1e"
  objHinweis4:Start()
  objwirktsschon()
end
function objk2:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objk2:OnTick()
  objbrutalinfaktor = "k2e"
  objHinweis4:Start()
  objwirktsschon()
end
function objhirnpause:OnStart()
  objhirn1 = false
end
function objhirnpause:OnTick()
  objhirn1 = true
end
function objhirn1_1:OnStart()
  objbrutalinfaktor = "h1s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objhirn1_1:OnTick()
  if objhirnbrutwirkung == true then
    objbrutalinfaktor = "h1e"
    objHinweis4:Start()
    objwirktsschon()
  end
end
function objhirn2:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objhirn2:OnTick()
  if objhirnbrutwirkung == true then
    objbrutalinfaktor = "h2e"
    objHinweis4:Start()
    objwirktsschon()
  end
end
function objhirn3:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objhirn3:OnTick()
  if objhirnbrutwirkung == true then
    objbrutalinfaktor = "h3e"
    objHinweis4:Start()
    objwirktsschon()
  end
end
function objhirn4:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objhirn4:OnTick()
  if objhirnbrutwirkung == true then
    objbrutalinfaktor = "h4e"
    objHinweis4:Start()
    objwirktsschon()
  end
end
function objhirn5:OnStart()
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objwirktsschon()
end
function objhirn5:OnTick()
  if objhirnbrutwirkung == true then
    objbrutalinfaktor = "h5e"
    objHinweis4:Start()
    objwirktsschon()
  end
end
function objswquer1:OnStart()
  objZombies1.Active = true
end
function objswquer1:OnTick()
  objZombies1.Active = false
  objswquer2:Start()
end
function objswquer2:OnTick()
  if objswquer == true then
    objswquer1:Start()
  else
    objAbdurchdieMitte.Active = false
    objZombies1.Active = false
    objswzombiesquerrahmen.Active = false
  end
end
function objx1:OnStart()
  objbrutalinfaktor = "x1s"
  objBrutalin.Commands.cmdEinnahme.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = true
  objwirktsschon()
end
function objx1:OnTick()
  objbrutalinfaktor = "x1e"
  objHinweis4:Start()
  objwirktsschon()
end
function objbissintervalllaufen:OnStart()
  objbiss()
end
function objtelefon1:OnStart()
  Wherigo.PlayAudio(objsoundtel)
  _Urwigo.MessageBox({
    Text = "",
    Media = objtelefon,
    Buttons = {
      "Abheben",
      "Intro ueberspringen"
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objtelefon1:Stop()
          objtelefonat()
        else
          objtelefon1:Stop()
          objTelefon.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function objHologramm:OncmdAnsprechen(target)
  _Urwigo.MessageBox({
    Text = "Programm starten!",
    Media = objdenksprech,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = "A...I..dh...dh.. huaaahhh! sch..h..h.. gnn... zh..z.. huaaah!",
          Callback = function(action)
            if action ~= nil then
              _Urwigo.MessageBox({
                Text = "Mensch, was ist denn mit dem los?",
                Media = objdenk,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.MessageBox({
                      Text = [[
Ich sag nur "Virus", der brauch ein Update...<BR>
Ok, dann mach ich mir mal ein Bild von der Situation.<BR>
Da vorn ist der Eingang...<BR>
<BR>
Vor jedem naechsten Auftrag immer die -&gt;Tasks lesen!!]],
                      Media = objdenk,
                      Callback = function(action)
                        if action ~= nil then
                          objHologramm.Visible = false
                          objTelefon.Active = false
                          objTodeszone.Active = true
                          objzumHintereingang.Active = false
                          objGehezumEingangTodeszone.Active = true
                          objTodeszone.Visible = true
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
  })
end
function objHologramm2:OncmdAnsprechen(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Programm starten!",
      Media = objdenksprech
    },
    {
      Text = "Hologramme sind sehr einfache Programme. Es sind vorgefertigte Ablaufe, die den Eindruck von Intelligenz vermitteln sollen. Was kann ich Fur Sie tun?"
    },
    {
      Text = "Gibt es etwas was sie mir sagen sollen?",
      Media = objdenksprech
    },
    {
      Text = "Es tut mir leid, meine Antworten sind begrenzt. Sie mussen die richtigen Fragen stellen"
    },
    {
      Text = "Was ist hier passiert?",
      Media = objdenksprech
    },
    {
      Text = [[
Folgendes ist passiert:<BR>
<BR>
Es ist ein Experiment ausser Kontrolle geraten. Wir untersuchten die Eklipse, bei der kurz nach der Infektion einer Wirtszelle das Virus nicht mehr in seiner infektioesen, partikulaeren Form, oder auch Virion vorliegt, da die virale Nukleinsaeure vom Kapsid und gegebenenfalls der Virushuelle getrennt wurde...]]
    },
    {Text = "oh....", Media = objdenksprech},
    {
      Text = "Na es ist doch so: Die Freisetzung der Nukleinsaeure ist notwendig, damit virale Proteine hergestellt oder bei Retroviren und temperenten Phagen die Nukleinsaeure in das Genom der Zelle integriert werden kann..."
    },
    {Text = "Okay!", Media = objdenksprech},
    {
      Text = [[
Ich machs kurz:<BR>
<BR>
Wir haben einen Virus erschaffen, der bei Infektion zum Tode fuehrt, allerdings mit der fatalen Nebenwirkung, dass die Erkrankten nicht sterben, sie bleiben untot! Wir haben eine Art Zombievirus erschaffen...]]
    },
    {
      Text = "Wurde nach einem Gegenmittel geforscht?",
      Media = objdenksprech
    },
    {Text = "Ja."},
    {
      Text = "Oeha, der meint es tatsaechlich ernst..",
      Media = objdenk
    }
  }, function(action)
    objForscherauftrag()
  end)
end
function objHologramm3:OncmdAnsprechen(target)
  if Wherigo.NoCaseEquals(objfreddy, "0") then
    _Urwigo.MessageBox({
      Text = "Programm starten!",
      Media = objdenksprech,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = ("Hallo" .. Player.Name) .. "! Ich habe Dich erwartet!",
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Sorry ich hatte mit diesen verdammten Zombies zu tun.",
                  Media = objdenksprech,
                  Callback = function(action)
                    if action ~= nil then
                      _Urwigo.MessageBox({
                        Text = [[
Du brauchst dich nicht zu rechtfertigen. Es ist ja nicht Deine Schuld, dass die Wissenschaftler so rumgepfuscht haben.<BR>
<BR>
Aber zum Glueck gibts ja Programme wie mich. Ich habe alles unter Kontrolle!<BR>
Dank meines unermuedlichen Einsatzes und meiner unvergleichlichen Gerissenheit habe ich es geschafft Schlimmeres zu verhindern!<BR>
Ich konnte diese Kiste hier sicherstellen. Darin ist ein Heilmittel, das diesen boesen Virus ausrotten wird.]],
                        Callback = function(action)
                          if action ~= nil then
                            _Urwigo.MessageBox({
                              Text = "Was fuer eine Kiste? Wo ist sie?",
                              Media = objdenksprech,
                              Callback = function(action)
                                if action ~= nil then
                                  _Urwigo.MessageBox({
                                    Text = [[
Na da steht sie doch! (-&gt; You see)<BR>
Ich habe sie bloss noch nicht aufbekommen.]],
                                    Buttons = {
                                      "Ich probiers mal"
                                    },
                                    Callback = function(action)
                                      if action ~= nil then
                                        if action == "Button1" == true then
                                          objContainer.Visible = true
                                          objGehezumHinterausgang.Active = false
                                          objKnackedenContainer.Active = true
                                          objfreddy = "1"
                                          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                                        end
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
                })
              end
            end
          })
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objfreddy, "1") then
    _Urwigo.MessageBox({
      Text = "Aehh, was soll ich nochmal tun?",
      Media = objdenksprech,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = ("Sag mal hoerst du nicht zu? Was ist bloss los mit dir " .. Player.Name) .. [[
?<BR>
<BR>
Suche die graue Kiste, dann druecke den &nbsp;(virtuellen) Knopf, beantworte die Frage.<BR>
Ist doch nicht sooo schwer.]],
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Ok, schon verstanden!",
                  Media = objdenksprech,
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
  elseif Wherigo.NoCaseEquals(objfreddy, "2") then
    _Urwigo.MessageBox({
      Text = "Sagen Sie mal Chef? Es ist nichts auf der Seite der Kiste!",
      Media = objdenksprech,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = ("Na komm schon " .. Player.Name) .. "! Mach deine Glubscher auf und schau nochmal genau! Da ist ein Schriftzug in der Kiste zu sehen.",
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Naja, ich habe meine Brille nicht dabei, aber ich schau nochmal nach...",
                  Media = objdenksprech,
                  Callback = function(action)
                    if action ~= nil then
                      objfreddy = "21"
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
  elseif Wherigo.NoCaseEquals(objfreddy, "21") then
    _Urwigo.MessageBox({
      Text = "Ich find nix, Chef!",
      Media = objdenksprech,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = ("Heieiei! " .. Player.Name) .. [[
, du bist mir schon so ein Pfeifendeckel! Was mach ich nur mir Dir? Schau in Hohe des Daches.<BR>
<BR>
Schaue im Menue bei "You see" nach dem Container und klicke auf "Knopf druecken".]],
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Ich glaub jetzt hab ichs begriffen. Ansonsten frag ich einfach nochmal!",
                  Media = objdenksprech,
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
  elseif Wherigo.NoCaseEquals(objfreddy, "3") then
    _Urwigo.MessageBox({
      Text = [[
Chef ich habs geschafft!<BR>
<BR>
Ich habe die Welt gerettet, cool oder?<BR>
<BR>
Dafuer habe ich mir meinen Urlaub wahrlich verdient, &nbsp;meinen Sie nicht auch?]],
      Media = objdenksprech,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = [[
Was? Du willst was gemacht haben? die Welt gewas?... ha... haha.... hahahahaha, das ist komisch, das ist echt komisch!<BR>
<BR>
Im Ernst:<BR>
Es tut mir Leid, aber das mit dem Urlaub wird nichts, wir haben momentan aus gegebenen Anlass einen akuten Personal-Ausfall zu beklagen.<BR>
<BR>
Aber ich will kein Unmensch sein. Du hast dich wirklich ins Zeug gehaengt - eeehm... also, nach Deinen Moeglichkeiten halt.<BR>
Als Dank schreibe ich dir einen Code ins Notizbuch, damit kannst du dir einen Bonuspunkt abholen. Den hast du dir verdient.<BR>
<BR>
Jetzt schau aber dass Du heimkommst und eine Muetze Schlaf bekommst. Du hast morgen Fruehschicht.<BR>
<BR>
FINAL 53 17 039 &nbsp;12 48 910 &nbsp;bodennah]],
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = "Danke Chef, Sie sind zu guetig zu mir!",
                  Media = objdenksprech,
                  Buttons = {"ENDE"},
                  Callback = function(action)
                    if action ~= nil then
                      objHologramm3.Visible = false
                      objBrutalin.Commands.cmdWirktesschon.Enabled = false
                      objBrutalin.Commands.cmdNocheine.Enabled = false
                      objBrutalin.Commands.cmdEinnahme.Enabled = true
                      objNotizbuch.Commands.cmdUnlockcode.Enabled = true
                      objOeffnedenDeckel.Active = false
                      objBerichterstatten.Active = false
                      objFINAL1.Active = true
                      objOnlineLoggen.Active = true
                      objIAMLEGEND.Complete = true
                      objcodefreigabe = "0"
                      objbrutalinfaktor = "ende"
                      objrettungsvariable = "Ende5639"
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
function objBedienungsanleitung:OncmdAllgemein(target)
  _Urwigo.MessageBox({
    Text = [[
Viele Probleme lassen sich durch richtiges Verhalten vermeiden!<BR>
deswegen ein paar Tipps:<BR>
<BR>
- beim Betreten von Zonen lieber ein paar Meter weiter reinlaufen, so dass man eindeutig drinnen steht<BR>
<BR>
- immer wieder die "Aufgaben" lesen!<BR>
<BR>
- waehrend "Konversationen" mit dem Display nicht umherrennen (Ausser man ist auf der Flucht, aber dann hilft auch kein Reden..). Durch neue Positionen bekommt das Geraet neue Befehle und dann gibts Kuddelmuddel. "Konversationen" immer bis zum Ende durchfuehren.<BR>
<BR>
- immer wieder die "Aufgaben" lesen!<BR>
<BR>
- nicht hektisch auf dem Display rumklicken, immer die Ruhe bewahren, auch wenn die Gefahr im Nacken sitzt<BR>
<BR>
- immer wieder die "Aufgaben" lesen!<BR>
<BR>
- auf guten Empfang achten, das Geraet nicht in die Tasche stecken!<BR>
<BR>
- immer wieder die "Aufgaben" lesen!]]
  })
end
function objBedienungsanleitung:OncmdGarmin(target)
  _Urwigo.MessageBox({
    Text = [[
- Scheinbar funktionieren manche Geraete besser, wenn sie nicht im Stromsparmodus laufen<BR>
<BR>
- geduldig sein bei Konversationen oder Eingaben, das Geraet rechnet manchmal recht lange (Denksekunde!), immer warten, bis sich nichts mehr tut..<BR>
<BR>
- den besten Ueberblick ueber nahende Gefahren bekommt man in der "Locations"-Liste<BR>
<BR>
- immer wieder die "Aufgaben" lesen!]]
  })
end
function objBedienungsanleitung:OncmdPPCPDA(target)
  _Urwigo.MessageBox({
    Text = [[
- Falls die Grafik verzerrt sein sollte, liegt das daran, dass der Player fuer kleine Displays konzipiert wurde und du eine zu hohe Aufloesung hast, moeglicherweise gibt es eine Software, mit der Du die Aufloesung aendern kannst<BR>
<BR>
- es gibt eine praktische Map in der die Zonen angezeigt werden, hilft definitiv beim Navigieren<BR>
<BR>
- immer wieder die Tasks lesen!]]
  })
end
function objBedienungsanleitung:OncmdAndroid(target)
  _Urwigo.MessageBox({
    Text = [[
- beim erstmaligen Benutzen von WhereYouGo muss man anscheinend der App erst erlauben, das GPS zu benutzen<BR>
<BR>
- vor Oeffnen der Cartridge auf vollen GPS-Empfang achten<BR>
<BR>
- unter Standort die Buttons "Standort" und "Kompass" aktivieren<BR>
<BR>
- auf der "Locations"-Liste werden die Richtungen der jeweiligen Zonen leider nicht angezeigt, dafuer gibt es eine tolle Karte auf der alle Grenzen angezeigt werden, sehr angenehm!<BR>
<BR>
- immer wieder die Tasks lesen!]]
  })
end
function objBedienungsanleitung:OncmdIPhone(target)
  _Urwigo.MessageBox({
    Text = [[
- beim i-Phone gibt es teilweise resourcenfressende Autosaves<BR>
<BR>
- der Ton ist manchmal nur sporadisch zu hoeren, das kann gefaehrlich sein, dafuer kann man sich den Sound-Dateinamen anzeigen lassen<BR>
<BR>
- wenn es keine andere Moeglichkeit gibt als das I-Phone muss man einfach hinnehmen, dass der Spass eingeschraenkt ist und man mit einem I-Phone einfach gefaehrlicher lebt ;)]]
  })
end
function objBedienungsanleitung:OncmdJavafaehigesHandy(target)
  _Urwigo.MessageBox({
    Text = [[
- leider werden bei den "Locations" keine Entfernungen und Richtungen angezeigt, was es sehr schwer macht, sich ordentlich zu orientieren<BR>
<BR>
- am besten ein anderes Geraet aufstellen]]
  })
end
function objNotizbuch:OncmdLesen(target)
  objHinweis4:Stop()
  objNotizbuch1()
end
function objNotizbuch:OncmdCodeeintragen(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objNotizeneintragen)
  end)
end
function objNotizbuch:OncmdUnlockcode(target)
  _Urwigo.MessageBox({
    Text = "Dein \"Unlock-Code\" fuer die Wherigo-Seite lautet:<BR>\n" .. string.sub(Player.CompletionCode, 1, 15),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objStetoskop:OncmdDiagnose(target)
  if objlebensenergievar >= 100 then
    _Urwigo.MessageBox({
      Text = ("Was will man mehr: Bumperlgsund! Ich habe noch eine stolze Lebensenergie von " .. objlebensenergievar) .. "%",
      Media = objherz100,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objlebensenergievar < 100 and objlebensenergievar > 75 then
    _Urwigo.MessageBox({
      Text = ("Die paar Kratzer.. Immerhin habe ich noch eine Lebensenergie von " .. objlebensenergievar) .. "%",
      Media = objherz075,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objlebensenergievar < 76 and objlebensenergievar > 50 then
    _Urwigo.MessageBox({
      Text = ("Ja, langsam tuts schon weh! Jetzt habe ich nur noch " .. objlebensenergievar) .. "% Lebensenergie..",
      Media = objherz050,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objlebensenergievar < 51 and objlebensenergievar > 25 then
    _Urwigo.MessageBox({
      Text = ("Ui! Langsam sollte ich etwas aufpassen.. Nur noch " .. objlebensenergievar) .. "%",
      Media = objherz025,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objlebensenergievar < 26 and objlebensenergievar > 0 then
    _Urwigo.MessageBox({
      Text = ("Aaahh, oooh, Hilfeeee... Ich habe nur noch " .. objlebensenergievar) .. "% Lebensenergie",
      Media = objherz025,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objStetoskop:OncmdAutopsie(target)
  _Urwigo.MessageBox({
    Text = "Da ist einfach nichts mehr zu machen.. Keine Atmung, kein Herzschlag und dann ist da dieser sonderbare Appetit auf... HIRN... ",
    Media = objrip,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objBrutalin:OncmdEinnahme(target)
  if Wherigo.NoCaseEquals(objbrutalinfaktor, tostring(0)) then
    _Urwigo.MessageBox({
      Text = "das macht momentan keinen Sinn! Zuoft sollte ich es eh nicht nehmen, sonst verliert es seine Wirkung..",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h1") then
    Wherigo.PlayAudio(objsoundschluck)
    objh11:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h2") then
    Wherigo.PlayAudio(objsoundschluck)
    objh21:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h3") then
    Wherigo.PlayAudio(objsoundschluck)
    objh31:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k0") then
    Wherigo.PlayAudio(objsoundschluck)
    objk1:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h") then
    Wherigo.PlayAudio(objsoundschluck)
    objhirn1_1:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "x") then
    Wherigo.PlayAudio(objsoundschluck)
    objx1:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "Ende") then
    _Urwigo.MessageBox({
      Text = [[
Mist, die Packung ist leer!<BR>
Ob ich das Zeug wohl ohne Rezept bekomme?<BR>
Werd den Owner mal anhauen, der kann mir da bestimmt was aufstellen, hehe...]],
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objBrutalin:OncmdWirktesschon(target)
  objwirktsschon()
end
function objBrutalin:OncmdNocheine(target)
  if Wherigo.NoCaseEquals(objbrutalinfaktor, "h11e") then
    objbrutalinfaktor = "h12s"
    objh12:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h12e") then
    objbrutalinfaktor = "h13s"
    objh13:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h13e") then
    _Urwigo.MessageBox({
      Text = "Nanana, jetzt ist aber mal genug!",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h21e") then
    objbrutalinfaktor = "h22s"
    objh22:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h22e") then
    _Urwigo.MessageBox({
      Text = "so, jetzt ist es aber genug! Da sind ja schon Suchttendenzen erkennbar!",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h31e") then
    objbrutalinfaktor = "h32s"
    objh32:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h32e") then
    _Urwigo.MessageBox({
      Text = "nanana! alter Suechtling!",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k1e") then
    objbrutalinfaktor = "k2s"
    objk2:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k2e") then
    _Urwigo.MessageBox({
      Text = "Schluss jetzt, es ist genug...",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h1e") then
    objbrutalinfaktor = "h2s"
    objhirn2:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h2e") then
    objbrutalinfaktor = "h3s"
    objhirn3:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h3e") then
    objbrutalinfaktor = "h4s"
    objhirn4:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h4e") then
    objbrutalinfaktor = "h5s"
    objhirn5:Start()
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h5e") then
    _Urwigo.MessageBox({
      Text = "Schluss jetzt, es ist genug. Ich weiss doch schon alles...",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "x1e") then
    _Urwigo.MessageBox({
      Text = [[
Mist, die Packung ist leer!<BR>
Ob ich das Zeug wohl ohne Rezept bekomme?]],
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objHirn:OncmdIQTest(target)
  objhirn6()
end
function objMedikit:OncmdAnwenden(target)
  if objlebensenergievar > 74 then
    objlebensenergievar = 99
  else
    objlebensenergievar = objlebensenergievar + 25
  end
  objMedikit.Visible = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objMedikit1:OncmdAufheben(target)
  objMedikit.Visible = true
  objMedikit1.Visible = false
  objmedikit1.Active = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objSicherheitsTerminal:OncmdEingeben(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objSchranke)
  end)
end
function objMediKit:OncmdAufheben(target)
  objMediKit.Visible = false
  objMediKit1.Visible = true
  objmedikitII.Active = false
end
function objMediKit1:OncmdAnwenden(target)
  if objlebensenergievar > 74 then
    objlebensenergievar = 99
  else
    objlebensenergievar = objlebensenergievar + 25
  end
  objMediKit1.Visible = false
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objDefibrillator:OncmdRetten(target)
  _Urwigo.MessageBox({
    Text = [[
Um deinen Kollegen wieder zurueck ins Spiel zu holen (ueberlegs dir gut!) teile ihm folgenden Code mit, den er in seinen Defibrillator eingeben muss:<BR>
<BR>
]] .. objrettungsvariable,
    Media = objdefib
  })
end
function objDefibrillator:OncmdGerettetwerden(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objgerettetwerden)
  end)
end
function objHinweis:OncmdAbnehmen(target)
  objHinweis.Visible = false
  objHinweiszettel.Visible = true
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function objHinweiszettel:OncmdAnschauen(target)
  objHinweiszettel1.Active = false
  objSpurtzumVersteck.Active = true
  objrettungsvariable = "baum5733"
  objroteInfosaeule.Active = false
  objStrehlow.Active = true
  objHinweiszettel.Commands.cmdAnschauen.Enabled = false
  objHinweiszettel.Commands.cmdVorderseite.Enabled = true
  objHinweiszettel.Commands.cmdRueckseite.Enabled = true
  _Urwigo.MessageBox({
    Text = "Was will mir der Prof. wohl mit dieser Zeichnung sagen? Ahh da steht noch was auf der Rueckseite...",
    Media = objhinweisprof,
    Buttons = {"Rueckseite", "Ok"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objrueckseite()
        else
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function objHinweiszettel:OncmdVorderseite(target)
  objvorderseite()
end
function objHinweiszettel:OncmdRueckseite(target)
  objrueckseite()
end
function objHundemuggel:OncmdAusloesen(target)
  objschafalarm1()
end
function objContainer:OncmdKnopfdruecken(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(objbetonkiste)
  end)
end
function objbiss()
  if objlebensenergievar > 0 then
    Wherigo.PlayAudio(objsoundbiss)
    if objlebensenergievar > 50 then
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.25 then
        objlebensenergievar = objlebensenergievar + -6
      elseif _rndChoiceValue < 0.5 then
        objlebensenergievar = objlebensenergievar + -5
      elseif _rndChoiceValue < 0.75 then
        objlebensenergievar = objlebensenergievar + -4
      else
        objlebensenergievar = objlebensenergievar + -3
      end
    elseif objlebensenergievar <= 50 and objlebensenergievar > 30 then
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.333333333333333 then
        objlebensenergievar = objlebensenergievar + -3
      elseif _rndChoiceValue < 0.666666666666667 then
        objlebensenergievar = objlebensenergievar + -4
      else
        objlebensenergievar = objlebensenergievar + -2
      end
    else
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.333333333333333 then
        objlebensenergievar = objlebensenergievar + -1
      elseif _rndChoiceValue < 0.666666666666667 then
        objlebensenergievar = objlebensenergievar + -2
      else
        objlebensenergievar = objlebensenergievar + -3
      end
    end
    if objlebensenergievar > 0 then
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.25 then
        _Urwigo.MessageBox({
          Text = ([[
Aua, sag a mal! Beisst mich der, sowas..<BR>
(meine Lebensenergie liegt jetzt nur noch bei ]] .. objlebensenergievar) .. "%)",
          Media = objblut
        })
      elseif _rndChoiceValue < 0.5 then
        _Urwigo.MessageBox({
          Text = ([[
Au! mein Arm! schau mal wie ich blute..<BR>
(meine Lebensenergie liegt jetzt nur noch bei ]] .. objlebensenergievar) .. "%)",
          Media = objblut
        })
      elseif _rndChoiceValue < 0.75 then
        _Urwigo.MessageBox({
          Text = ([[
Brennt Dir der Hut, ich beiss Dich gleich zurueck!<BR>
(meine Lebensenergie liegt jetzt nur noch bei ]] .. objlebensenergievar) .. "%)",
          Media = objblut
        })
      else
        _Urwigo.MessageBox({
          Text = ([[
AAhh, das tut weh!<BR>
(meine Lebensenergie liegt jetzt nur noch bei ]] .. objlebensenergievar) .. "%)",
          Media = objblut
        })
      end
    else
      objtod()
    end
  else
    Wherigo.PlayAudio(objsoundbiss)
    _Urwigo.MessageBox({
      Text = [[
Ahh, &nbsp;servus Kollege!<BR>
Hast du etwas Hirn fuer mich?]],
      Media = objz13,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objintervallbissenter()
  if objlebensenergievar > 0 then
    objbissintervalllangsam:Start()
  end
end
function objintervallbissexit()
  if objlebensenergievar > 0 then
    objbissintervalllangsam:Stop()
  end
end
function objtod()
  objStetoskop.Commands.cmdDiagnose.Enabled = false
  objStetoskop.Commands.cmdAutopsie.Enabled = true
  objHinweis4:Start()
  _Urwigo.MessageBox({
    Text = "Verdammt! Das wars dann wohl! Jetzt bin ich auch einer dieser Zombies! Mal schauen, ob ich das GPS noooch bediiiiehhhneeeeen kaahhhnn.. &nbsp;AAAaahhrrhhh..",
    Callback = function(action)
      if action ~= nil then
        objHinweis4:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objForscherauftrag()
  _Urwigo.Dialog(false, {
    {
      Text = [[
Sie muessen so schnell wie moeglich die Antiviren finden.<BR>
<BR>
Dieses sind kurze verschluesselte Code-Woerter. Leider hat einer meiner Mitarbeiter die kryptischen Hinweise verschleppt nachdem er begonnen hatte, sich so komisch zu benehmen.]]
    },
    {
      Text = "Wo finde ich die Hinweise?",
      Media = objdenksprech
    },
    {
      Text = "In Richtung Lagerhaus, finden Sie diese.. SCHNEELLL!!!"
    },
    {
      Text = "Boah jetzt auch noch weiter laufen, wo ich doch schon halb schlafe..",
      Media = objdenksprech
    },
    {
      Text = [[
Da habe ich hier was fuer Sie! Eine Packung "Brutalin" das weckt muede Geister und hilft beim Denken, kann Ihnen nicht schaden!<BR>
<BR>
(-&gt;Inventory)]]
    },
    {
      Text = "Eigentlich bevorzuge ich ja planzliche Wirkstoffe...",
      Media = objdenksprech
    },
    {
      Text = "Meine Guete, was sind Sie denn fuer ein Waschlappen, ein bischen Chemie wird Sie schon nicht umbringen!<BR>\n"
    },
    {
      Text = "Ich haenge mich ja gleich an seine Fersen, aber erklaeren Sie mir noch bitte, was es mit den Codes auf sich hat..",
      Media = objdenksprech
    },
    {
      Text = [[
Ach, das ist eigentlich ganz einfach:<BR>
Finden sie die Hinweiiiiisssaeaeae. oooooh! wieee wiaaard miiiiiiaaaarhhh???? &nbsp;huaaaarhhrrhh, rrrroaaaahooaaarrhhh...]]
    }
  }, function(action)
    objBrutalin.Visible = true
    _Urwigo.MessageBox({
      Text = "Verdammt, es scheint ihn erwischt zu haben.. Habe ich jetzt alles verstanden? Oder mache ich mich lieber schleunigst vom Acker?",
      Media = objdenk,
      Buttons = {
        "Also nochmal..",
        "Weg hier!"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objForscherauftrag()
          else
            objHologramm2.Visible = false
            obj3Codes.Active = true
            objDerWegzurKantine.Active = false
            objDieSpurzumLagerhaus.Active = true
            objseltlsamedamerahmen.Active = false
            objKantine.Active = false
            objLagerhaus.Active = true
            objZombies.Active = true
            objrettungsvariable = "kant5910"
            _Urwigo.MessageBox({
              Text = "(AUTOSAVE)",
              Callback = function(action)
                if action ~= nil then
                  objIAMLEGEND:RequestSync()
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          end
        end
      end
    })
  end)
end
function objwirktsschon()
  if Wherigo.NoCaseEquals(objbrutalinfaktor, "h11s") then
    _Urwigo.MessageBox({
      Text = ("Aha, bis das Brutalin wirkt dauert es noch " .. objh11.Remaining) .. " Sekunden! Inzwischen koennte ich ja schauen, ob ich entdecke!!!",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Suchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h11e") then
    _Urwigo.MessageBox({
      Text = "Aha, auf der Rueckseite steht \"CNNZHYH\", was damit wohl gemeint ist?",
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h12s") then
    _Urwigo.MessageBox({
      Text = ("Irgendwie muss &nbsp;doch dieses \"CNNZHYH zu Entschluesseln sein.. In " .. objh12.Remaining) .. "Sekunden bin ich schlauer, hoffentlich!",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h12e") then
    _Urwigo.MessageBox({
      Text = "Aha ich erinnere mich. Auf meinem Arbeitsvertrag war so eine Tabelle, mit der klappt es... Einfach \"CNNZHYH\" umwandeln und dann ins Notizbuch eintragen",
      Media = objdecryptionkey,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h13s") then
    _Urwigo.MessageBox({
      Text = ("Also irgendwas verstehe ich nicht so ganz. Da nehme ich doch gleich noch eine Pille. In &nbsp;" .. objh13.Remaining) .. " Sekunden wird es wirken.",
      Media = objdecryptionkey,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h13e") then
    _Urwigo.MessageBox({
      Text = [[
Na gut, dann halt mit der Brechstange: Dank einer goettlichen Eingebung weiss ich aber dass er "Paamulu" heisst.<BR>
<BR>
Netterweise werde ich auf alle Faelle dem Owner Bescheid geben, dass da evtl. was nicht stimmt! Tja so bin ich :)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h21s") then
    _Urwigo.MessageBox({
      Text = ("Oh mann, das dauert noch " .. objh21.Remaining) .. " Sekunden bis ich schlauer bin! Inzwischen koennte ich ja nochmal schauen, da muss doch was sein!",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Suchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h21e") then
    _Urwigo.MessageBox({
      Text = "Schaue etwas naher am Boden!",
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h22s") then
    _Urwigo.MessageBox({
      Text = ("Hmm eigentlich muss es hier am Schild sein. &nbsp;Noch " .. objh22.Remaining) .. " Sekunden, dann faellt es mir ein",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h22e") then
    _Urwigo.MessageBox({
      Text = [[
banyumwara<BR>
<BR>
Netterweise werde ich auf alle Faelle dem Owner Bescheid geben, wenn der Hinweis weg ist, oder sonst irgendwas nicht stimmt! Tja so bin ich :)]],
      Media = objMorse,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h31s") then
    _Urwigo.MessageBox({
      Text = ("Hier beim Hoersaal muss der Hinweis sein, bis das Teufelszeug wirkt schaue ich mir mal das Schild genauer an. Es wird noch " .. objh31.Remaining) .. " Sekunden dauern, bis es wirkt.",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h31e") then
    _Urwigo.MessageBox({
      Text = [[
Aha, da sind Zahlen, naemlich:<BR>
5599988777788662]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h32s") then
    _Urwigo.MessageBox({
      Text = ("An irgendwas erinnert mich das. Es wird aber wohl noch &nbsp;" .. objh32.Remaining) .. " Sekunden dauern bis das Groscherl faellt.",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h32e") then
    _Urwigo.MessageBox({
      Text = [[
Ja klar! Damals vor T9, da musste man zum simsen noch die Buchstaben haendisch auswaehlen, das war noch Daumensport.<BR>
Also einfach die Zahlen 5599988777788662 in die Tasten hauen und sehen was rauskommt.<BR>
<BR>
Falls irgendwas nicht stimmen sollte werde ich netterweise dem Owner Bescheid geben! Tja so bin ich :)]],
      Media = objvanity,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k1s") then
    _Urwigo.MessageBox({
      Text = ("Boah keine Ahnung was ich hier soll! Bis das Brutalin wirkt kann ich ja nochmal sinnieren, ob es vielleicht am Torrahmen mit dem \"GC\" drauf ist, um den es geht. Es dauert noch " .. objk1.Remaining) .. " Sekunden.",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k1e") then
    _Urwigo.MessageBox({
      Text = "\"GC\" nur die Zahl eingeben",
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k2s") then
    _Urwigo.MessageBox({
      Text = ("Also wenn ich wirklich nicht weiter komme, kann es auch sein, dass der Hinweis verschwunden ist! Lieber warte ich mal noch" .. objk2.Remaining) .. " Sekunden. Oder halt nochmal ganz genau schauen..",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "k2e") then
    _Urwigo.MessageBox({
      Text = [[
Na gut, der Hinweis scheint weg zu sein. Das ist aber aergerlich.<BR>
Dank einer goettlichen Eingebung weiss ich aber dass er "4" heisst.<BR>
<BR>
Netterweise werde ich auf alle Faelle dem Owner Bescheid geben, dass da was nicht stimmt! Tja so bin ich :)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h1s") then
    _Urwigo.MessageBox({
      Text = ([[
Bis es wirkt, ueberlege ich, ob es nicht einen Zusammenhang zwischen Hinweis 1 und 4 gibt..<BR>
<BR>
Es dauert noch ]] .. objhirn1_1.Remaining) .. " Sekunden. ",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "ich habs...."
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            objhirn6()
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h1e") then
    _Urwigo.MessageBox({
      Text = [[
Ahh, klar:<BR>
Paamulu muss durch die Maus uebertragen werden, weil es ja entweder von Uganda oder Finnland stammt, also nicht Canada!<BR>
<BR>
Folgerung A: "Paamulu wird durch die Maus uebertragen<BR>
<BR>
(-&gt;Notizbuch)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "a"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h2s") then
    _Urwigo.MessageBox({
      Text = ([[
Na gut, zum Zeitvertreib schaue ich mir Hinweis 3 und Folgerung A an.<BR>
<BR>
Schliesslich dauert es ja noch ]] .. objhirn2.Remaining) .. " Sekunden. ",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h2e") then
    _Urwigo.MessageBox({
      Text = [[
Na logo, Bunyamwera kann garnicht durch die Maus uebertragen werden, da die Maus ja schon Paamulu uebertraegt, folglich kommt es nicht aus Canada.<BR>
<BR>
Folgerung B: Bunyamwera kommt nicht aus Canada<BR>
<BR>
(-&gt;Notizbuch)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "b"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h3s") then
    _Urwigo.MessageBox({
      Text = ([[
Hoffentlich machen diese Tabletten nicht suechtig!<BR>
Bis zur naechsten Erkenntnis nehme ich mir Hinweis 1 und Folgerung B zur Brust.<BR>
<BR>
]] .. objhirn3.Remaining) .. " Sekunden noch..",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h3e") then
    _Urwigo.MessageBox({
      Text = [[
Na servus, das ist doch garnicht so schwer. Wenn weder Paamulu noch Bunyamwera aus Canada kommen, bleibt nur noch das Kyusuna-Virus.<BR>
<BR>
Folgerung C: Kyusuna stammt aus Canada<BR>
<BR>
(-&gt;Notizbuch)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "c"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h4s") then
    _Urwigo.MessageBox({
      Text = ([[
Langsam klaert sich alles. Aus Hinweis 5 und Folgerung C komme ich zu dem Schluss, dass das Kyusuna-Virus aus Canada stammt (Folgerung D).<BR>
<BR>
Jetzt brauche ich eigentlich nur noch Hinweis 1 und 2 mit der Folgerung A kombinieren.<BR>
<BR>
In<BR>
<BR>
]] .. objhirn4.Remaining) .. " Sekunden bin ich fast schon erloest...",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h4e") then
    _Urwigo.MessageBox({
      Text = [[
Logo, Paamulu kann nicht aus Uganda kommen, da es von der Maus uebertragen wird und man sich den afrikanischen Virus von der Muecke holt.<BR>
<BR>
Folgerung D: Paamulu stammt aus Finnland<BR>
<BR>
(-&gt;Notizbuch)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "d"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h5s") then
    _Urwigo.MessageBox({
      Text = ([[
Na jetzt aber, ohne Drogen scheint das Groscherl wohl nicht zu fallen...<BR>
<BR>
Die Folgerungen A, D und E machen doch alles klar!<BR>
<BR>
In<BR>
]] .. objhirn5.Remaining) .. " Sekunden weiss ich alles...",
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "Weitersuchen"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "h5e") then
    _Urwigo.MessageBox({
      Text = [[
Ok, schon klar!<BR>
Die finnische Maus bringt den Paamulu-virus<BR>
die canadische Zecke den Kyusuna<BR>
bleibt nur noch:<BR>
die afrikanische Muecke fuer den Banyumwera-Virus!<BR>
<BR>
(-&gt;Notizbuch)]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "e"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "x1s") then
    _Urwigo.MessageBox({
      Text = ([[
Ok, also es muss das weisse Schild an der Hauptstrasse sein. Ich leuchte nochmal den Baum ab, an dem was rotes haengt.<BR>
<BR>
Es dauert noch ]] .. objx1.Remaining) .. [[
 Sekunden.<BR>
<BR>
Dann weiss ich mehr.]],
      Media = objsanduhr,
      Buttons = {
        "Aktualisieren",
        "ich habs...."
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objwirktsschon()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objbrutalinfaktor, "x1e") then
    _Urwigo.MessageBox({
      Text = [[
Also wenn an dem Schild nichts zu finden ist, scheint der Code weg zu sein.<BR>
Er haette geheissen: "depot51"<BR>
(steht auch im Notizbuch)<BR>
<BR>
Ich werde dem Owner Bescheid geben, dass da was im argen ist, so nett wie ich bin.]],
      Media = objidee,
      Callback = function(action)
        if action ~= nil then
          objnotizbuch = "x"
          objBrutalin.Commands.cmdNocheine.Enabled = true
          objHinweis4:Stop()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objNotizbuch1()
  if Wherigo.NoCaseEquals(objnotizbuch, tostring(0)) then
    _Urwigo.MessageBox({Text = "Leer...", Media = objbuchoffen})
  elseif Wherigo.NoCaseEquals(objnotizbuch, tostring(1)) then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, tostring(2)) then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, tostring(3)) then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Zum Loesen dieser Behauptungen gehe ich dann doch lieber an einen sicheren Ort..]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "31") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "a") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "b") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen<BR>
B: Bunyamwera kommt nicht aus Canada]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "c") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen<BR>
B: Bunyamwera kommt nicht aus Canada<BR>
C: Kyusuna stammt aus Canada]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "d") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen<BR>
B: Bunyamwera kommt nicht aus Canada<BR>
C: Kyusuna stammt aus Canada<BR>
D: Paamulu stammt aus Finnland]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "e") then
    _Urwigo.MessageBox({
      Text = [[
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen<BR>
B: Bunyamwera kommt nicht aus Canada<BR>
C: Kyusunar stammt aus Canada<BR>
D: Paamulu stammt aus Finnland<BR>
E: die Loesung:<BR>
Bunyamwera wird durch die afrikanische Muecke,<BR>
Paamulu durch die finnische Maus und<BR>
Kyusuna durch die canadische Zecke uebertragen]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(objnotizbuch, "x") then
    _Urwigo.MessageBox({
      Text = [[
Der Code beim Versteck des Professors unter dem "Schild":<BR>
"depot51"<BR>
<BR>
Hinweise:<BR>
1. Das Paamulu-Virus kommt aus Finnland oder Uganda<BR>
2. Den Virus aus Uganda holt man sich vom Mueckenstich<BR>
3. Wenn Banyumwara durch die Maus uebertragen wird, dann kommt es aus Canada<BR>
4. Wenn Paamulu nicht aus Canada stammt, dann wird es von der Maus uebertragen<BR>
5. Kyusuna wird von der canadischen Zecke uebertragen oder von der afrikanischen Maus<BR>
6. Der Virus aus Canada wird von Maeusen oder Zecken uebertragen<BR>
<BR>
Folgerungen:<BR>
A: Paamulu wird durch die Maus uebertragen<BR>
B: Bunyamwera kommt nicht aus Canada<BR>
C: Kyusunar stammt aus Canada<BR>
D: Paamulu stammt aus Finnland<BR>
E: die Loesung:<BR>
Bunyamwera wird durch die afrikanische Muecke,<BR>
Paamulu durch die finnische Maus und<BR>
Kyusuna durch die canadische Zecke uebertragen]],
      Media = objbuchoffen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function objbisskauz()
  Wherigo.PlayAudio(objsoundbiss)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.25 then
    objlebensenergievar = objlebensenergievar + -6
  elseif _rndChoiceValue < 0.5 then
    objlebensenergievar = objlebensenergievar + -8
  elseif _rndChoiceValue < 0.75 then
    objlebensenergievar = objlebensenergievar + -9
  else
    objlebensenergievar = objlebensenergievar + -7
  end
  _Urwigo.MessageBox({
    Text = ([[
Aua, hat die mich doch glatt gebissen! Was geht? Die ist doch nicht ganz sauber, ich hau lieber ab!<BR>
<BR>
(Mit dem Stetoskop, das ich mir schlauerweise eingepackt habe, kann ich jederzeit pruefen, wie es um meine Gesundheit steht. Diese liegt jetzt nur noch bei ]] .. objlebensenergievar) .. "%)",
    Media = objdenk,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function objiqtest1()
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.333333333333333 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objiq1)
    end)
  elseif _rndChoiceValue < 0.666666666666667 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objiq2)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objiq3)
    end)
  end
end
function objhirn6()
  if objhirn1 == true then
    objiqtest1()
  else
    _Urwigo.MessageBox({
      Text = ([[
Oh, mein Hirn raucht so, ich mach lieber mal noch eine Pause!<BR>
<BR>
Noch<BR>
]] .. objhirnpause.Remaining) .. "Sekunden, dann kann ich einen neuen Test wagen. Besser ich helfe noch ein wenig nach mit diesem Wundermittel und versuche sicherzugehen mit der Antwort..",
      Media = objdenk,
      Buttons = {
        "Aktualisieren",
        "Weiter raetseln"
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            objhirn6()
          else
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      end
    })
  end
end
function objiqpositiv()
  objhirnbrutwirkung = false
  objGaragen.Active = false
  objFamama.Active = true
  objrettungsvariable = "kryo5312"
  objcodefreigabe = "0"
  objbrutalinfaktor = "0"
  objHirn.Visible = false
  objHirn1.Visible = true
  obj3Codes.Active = false
  objbenutzedeinHirn.Active = false
  objzumFamama.Active = true
  objBrutalin.Commands.cmdNocheine.Enabled = false
  objBrutalin.Commands.cmdWirktesschon.Enabled = false
  objBrutalin.Commands.cmdEinnahme.Enabled = true
  _Urwigo.MessageBox({
    Text = [[
Ah, jetzt wo ich mein Hirn mit den korrekten Infos gefuettert hab', schliesst sich langsam der Kreis, die Synapsen finden sich, Licht kommt ins Dunkel, das Groscherl ist gefallen..<BR>
<BR>
Es ist doch eigentlich klar:<BR>
Uganda ist im Sueden,Canada &nbsp;im Westen und Finnland im Norden, was fehlt? klar, der Osten!<BR>
<BR>
Ausserdem:<BR>
Die Zecke hat 8 Beine, die Muecke 6, die Maus 4, was fehlt?<BR>
Na klar die 2!<BR>
<BR>
Das heisst dann wohl dass es zu Gebaeude Nr. 2 im Osten geht. &nbsp;Das muss das Facility-Management-Main-Distribution-Head-Quarter (kurz Famama) sein.<BR>
<BR>
Wie? obstrus? wie? an den Haaren herbeigezogen? wie? skurill?<BR>
Das liegt einfach an der Ueberdosierung von diesem Brutalin, da werden einem Zusammenhaenge bewusst, die jenseits von Gut und Boese liegen.<BR>
<BR>
IS' SO, BASTA!<BR>
<BR>
(AUTOSAVE)]],
    Media = objidee,
    Buttons = {"weiter"},
    Callback = function(action)
      if action ~= nil then
        objbissintervalllangsam:Stop()
        objbissintervalllaufen:Stop()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        objIAMLEGEND:RequestSync()
      end
    end
  })
end
function objtelefonat()
  _Urwigo.Dialog(false, {
    {
      Text = "..ja.. Hallo? Wer ist am Apparat?",
      Media = objdenksprech
    },
    {
      Text = "Hier ist Ben, ich bin ein automatischer Telefonbot.",
      Media = objhoerer
    },
    {
      Text = "Oh, hallo! Wissen Sie eigentlich wie spaet es ist?",
      Media = objdenksprech
    },
    {
      Text = "Stell' Dich nicht so an, raus aus den Federn!",
      Media = objhoerer
    },
    {
      Text = "Aber es ist mitten in der Nacht! Was ist denn los?",
      Media = objdenksprech
    },
    {
      Text = "Im &nbsp;Forschungsinstitut ist ein Unfall passiert, wir koennen noch nichts genaues sagen, aber es gehen seltsame Dinge vor sich...",
      Media = objhoerer
    },
    {
      Text = "War ja klar, dass es irgendwann soweit kommen musste! Aber was bitte hab ich mit der Sache zu tun?",
      Media = objdenksprech
    },
    {
      Text = "Ich glaube, Du hast den Ernst der Lage noch nicht ganz begriffen: Da ist die Kacke am dampfen! Pack' die Sieben Sachen zusammen und schaff' Deinen traegen Hintern hier her!",
      Media = objhoerer
    },
    {
      Text = "Jaja, ist ja gut, ich komm' gleich.",
      Media = objdenksprech
    },
    {
      Text = "So fing es damal an. Der Virus breitete sich rasend schnell aus.",
      Media = objhoerer
    },
    {
      Text = "Jetzt befinden wir uns in der Gegenwart.....",
      Media = objdenksprech
    },
    {Text = "im Jetzt", Media = objhoerer}
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(objzuHause)
    end)
  end)
end
function objrueckseite()
  _Urwigo.MessageBox({
    Text = [[
*** Wenn einer der mit Muehe kaum,<BR>
geflohen ist zum blauen Baum,<BR>
gleich meint, dass er gerettet waer,<BR>
dann irrt sich der! ***<BR>
<BR>
Wer immer das hier liest! Sie sind die letzte Hoffnung...<BR>
Suchen Sie das rettende Serum. Ich habe es unter einem Stein am weissen Schild deponiert. Einfach an den orangen Markierungen &nbsp;zuruckgehen und dann weiter geradeaus. zur Hauptstrasse<BR>
<BR>
An der typischen roten Markierung finden Sie in der Nahe ein Codewort.<BR>
<BR>
Der Prof.]],
    Buttons = {
      "Vorderseite",
      "OK"
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objvorderseite()
        else
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function objvorderseite()
  _Urwigo.MessageBox({
    Text = "",
    Media = objhinweisprof,
    Buttons = {"Rueckseite", "OK"},
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          objrueckseite()
        else
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function objschafalarm1()
  Wherigo.PlayAudio(objsoundHinweis)
  if objZombielinks.Active == true then
    objZombielinks.Active = false
    objZombiesrechts1.Active = false
    objmedikit1.Active = false
    objnichtbetreten.Active = true
    _Urwigo.MessageBox({
      Text = [[
Vielen vielen Dank fuer die Ruecksicht!<BR>
Gehe nun um die Schafe herum zur Zone Schaf. Dort geht es weiter. Denk dran du musst dort zwischen den Zombies links und rechts durch.]],
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objZombiesrechts2.Active == true then
    objZombiesrechts2.Active = false
    objZombieslinks.Active = false
    _Urwigo.MessageBox({
      Text = "Vielen Dank fuer die Ruecksicht! Gehe nun um die Schafe herum zur Zone Kuehlhaus. Dort geht es weiter. &nbsp;",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objAuditorium.Active == true then
    objzombie3ausloeser.Active = false
    objbissintervalllangsam:Stop()
    _Urwigo.MessageBox({
      Text = "Vielen Dank fuer die Ruecksicht! Gehe nun um die Schafe herum zur Zone \"Auditorium\". Dort geht es weiter. &nbsp;",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objHinterausgangBibliothek.Active == true or objTelefon.Active == true then
    objbibzombies = false
    objmedikitII.Active = false
    objZombiesrechts.Active = false
    objZombieslinks1.Active = false
    objZumHinterausgangderBibliothek.Active = false
    objZudenGaragen.Active = true
    objrettungsvariable = "hbib3512"
    objGaragen.Active = true
    _Urwigo.MessageBox({
      Text = "Vielen Dank fuer die Ruecksicht! Gehe nun um die Schafe herum zur Zone \"Kryotank\". Dort geht es weiter. &nbsp;",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif objFamama.Active == true then
    _Urwigo.MessageBox({
      Text = "Vielen Dank fuer die Ruecksicht! Gehe nun um die Schafe herum zur Zone \"famama\". Dort geht es weiter. ",
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = [[
Hier sollen Schafe sein?<BR>
Oh weh, da wurde noch kein Ausweichsmanoever geplant! Versuche es spaeter nochmal und nehme in jedem Fall Ruecksicht auf die Schafe. &nbsp;Bitte KEIN Aerger mit dem Schaefer!!<BR>
Bitte auch den Owner informieren, dann kann der nachruesten. DANKE!]],
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
return objIAMLEGEND
