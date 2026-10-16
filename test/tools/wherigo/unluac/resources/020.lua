require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _yhK5(str)
  local res = ""
  local dtable = "CcS*^=Euf!i\t@B9\001)\004[<`T\022'4XAG+\v\016J-1I\0026\028\021 D\014s257b8d\\x\023\r>\027NP,\a#\025~On(:\003g\019a\015\020eh\029j\030];w/k?{y$r\006z\"ZRL|\005t\026_\018\b\f\n}.m3%FW\000Mq\031&HUYQvlp0V\017o\024K"
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
_Ftnpx = Wherigo.ZCartridge()
IMG_Intro10 = Wherigo.ZMedia(_Ftnpx)
IMG_Intro10.Id = "2fb6f9e4-5ceb-4c17-ba82-97b3b0927ccb"
IMG_Intro10.Name = _yhK5("#@`W}\"z")
IMG_Intro10.Description = ""
IMG_Intro10.AltText = ""
IMG_Intro10.Resources = {
  {
    Type = "jpg",
    Filename = "intro10.jpg",
    Directives = {}
  }
}
IMG_Intro20 = Wherigo.ZMedia(_Ftnpx)
IMG_Intro20.Id = "4d069185-36e9-4b7e-8bf9-a06414cfe387"
IMG_Intro20.Name = _yhK5("#@`W},z")
IMG_Intro20.Description = ""
IMG_Intro20.AltText = ""
IMG_Intro20.Resources = {
  {
    Type = "jpg",
    Filename = "intro20.jpg",
    Directives = {}
  }
}
IMG_Intro30 = Wherigo.ZMedia(_Ftnpx)
IMG_Intro30.Id = "f243c61a-7a71-401a-8039-57fce59fd8c1"
IMG_Intro30.Name = _yhK5("#@`W}jz")
IMG_Intro30.Description = ""
IMG_Intro30.AltText = ""
IMG_Intro30.Resources = {
  {
    Type = "jpg",
    Filename = "intro30.jpg",
    Directives = {}
  }
}
IMG_Passwort = Wherigo.ZMedia(_Ftnpx)
IMG_Passwort.Id = "3551bbf6-7f2e-4ee7-9261-25e212ed58b1"
IMG_Passwort.Name = _yhK5("9F++P}W`")
IMG_Passwort.Description = ""
IMG_Passwort.AltText = ""
IMG_Passwort.Resources = {
  {
    Type = "jpg",
    Filename = "passwort.jpg",
    Directives = {}
  }
}
IMG_Parkplatz = Wherigo.ZMedia(_Ftnpx)
IMG_Parkplatz.Id = "3b57a6bd-2a07-4cc3-9a6a-1878a0eeb048"
IMG_Parkplatz.Name = _yhK5("9FWRyxF`Y")
IMG_Parkplatz.Description = ""
IMG_Parkplatz.AltText = ""
IMG_Parkplatz.Resources = {
  {
    Type = "jpg",
    Filename = "parkplatz.jpg",
    Directives = {}
  }
}
IMG_Raebe01 = Wherigo.ZMedia(_Ftnpx)
IMG_Raebe01.Id = "1ea9d2ae-4ab2-4b6b-ab83-abc6543f33ee"
IMG_Raebe01.Name = _yhK5("\\FI/Iz\"")
IMG_Raebe01.Description = ""
IMG_Raebe01.AltText = ""
IMG_Raebe01.Resources = {
  {
    Type = "jpg",
    Filename = "Raebe01.jpg",
    Directives = {}
  }
}
IMG_Kunitz1 = Wherigo.ZMedia(_Ftnpx)
IMG_Kunitz1.Id = "28f2e488-0eba-402d-8b81-85f9e8d842a5"
IMG_Kunitz1.Name = _yhK5("\127\b@\v`Y\"")
IMG_Kunitz1.Description = ""
IMG_Kunitz1.AltText = ""
IMG_Kunitz1.Resources = {
  {
    Type = "jpg",
    Filename = "Kunitz1.jpg",
    Directives = {}
  }
}
IMG_Kunitz2 = Wherigo.ZMedia(_Ftnpx)
IMG_Kunitz2.Id = "932f42ab-f624-4672-8cbb-8be13b4af967"
IMG_Kunitz2.Name = _yhK5("\127\b@\v`Y,")
IMG_Kunitz2.Description = ""
IMG_Kunitz2.AltText = ""
IMG_Kunitz2.Resources = {
  {
    Type = "jpg",
    Filename = "Kunitz2.jpg",
    Directives = {}
  }
}
IMG_Ba1Zone = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1Zone.Id = "79a6e731-bc0c-4d7c-b6c4-ca319649eb59"
IMG_Ba1Zone.Name = _yhK5("\014F\"[}@I")
IMG_Ba1Zone.Description = ""
IMG_Ba1Zone.AltText = ""
IMG_Ba1Zone.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1Zone.jpg",
    Directives = {}
  }
}
IMG_Ba1A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1A.Id = "60e82d51-3c1e-43d2-a07e-45f0e3f5e42e"
IMG_Ba1A.Name = _yhK5("\014F\"\027")
IMG_Ba1A.Description = ""
IMG_Ba1A.AltText = ""
IMG_Ba1A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1A.jpg",
    Directives = {}
  }
}
IMG_Ba1B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1B.Id = "2751036c-ad10-47a2-b31c-205e5b6b46fa"
IMG_Ba1B.Name = _yhK5("\014F\"\014")
IMG_Ba1B.Description = ""
IMG_Ba1B.AltText = ""
IMG_Ba1B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1B.jpg",
    Directives = {}
  }
}
IMG_Ba1C = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1C.Id = "42854917-70cb-4251-8f81-37fc8b9c639b"
IMG_Ba1C.Name = _yhK5("\014F\"\001")
IMG_Ba1C.Description = ""
IMG_Ba1C.AltText = ""
IMG_Ba1C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1C.jpg",
    Directives = {}
  }
}
IMG_Ast = Wherigo.ZMedia(_Ftnpx)
IMG_Ast.Id = "3074f861-5fad-4db5-87c1-d1998e620581"
IMG_Ast.Name = _yhK5("\027+`")
IMG_Ast.Description = ""
IMG_Ast.AltText = ""
IMG_Ast.Resources = {
  {
    Type = "jpg",
    Filename = "Ast.jpg",
    Directives = {}
  }
}
IMG_Laterne = Wherigo.ZMedia(_Ftnpx)
IMG_Laterne.Id = "d401febd-634a-4eee-b419-2fa8dcae4b45"
IMG_Laterne.Name = _yhK5("]F`IW@I")
IMG_Laterne.Description = ""
IMG_Laterne.AltText = ""
IMG_Laterne.Resources = {
  {
    Type = "jpg",
    Filename = "Laterne.jpg",
    Directives = {}
  }
}
IMG_Notiz = Wherigo.ZMedia(_Ftnpx)
IMG_Notiz.Id = "23f2c31f-d1af-4a78-af2a-28af6ae9c358"
IMG_Notiz.Name = _yhK5("8}`\vY")
IMG_Notiz.Description = ""
IMG_Notiz.AltText = ""
IMG_Notiz.Resources = {
  {
    Type = "jpg",
    Filename = "Notiz.jpg",
    Directives = {}
  }
}
IMG_Lollis = Wherigo.ZMedia(_Ftnpx)
IMG_Lollis.Id = "eab9e32c-1d49-4424-b056-798d4873b66e"
IMG_Lollis.Name = _yhK5("]}xx\v+")
IMG_Lollis.Description = ""
IMG_Lollis.AltText = ""
IMG_Lollis.Resources = {
  {
    Type = "jpg",
    Filename = "Lollis.jpg",
    Directives = {}
  }
}
IMG_Huehnchen = Wherigo.ZMedia(_Ftnpx)
IMG_Huehnchen.Id = "eaef1aaa-413b-4da2-a225-70b55c3a66eb"
IMG_Huehnchen.Name = _yhK5("s\bIJ@\002JI@")
IMG_Huehnchen.Description = ""
IMG_Huehnchen.AltText = ""
IMG_Huehnchen.Resources = {
  {
    Type = "jpg",
    Filename = "Huehnchen.jpg",
    Directives = {}
  }
}
IMG_Spieler = Wherigo.ZMedia(_Ftnpx)
IMG_Spieler.Id = "13d963b2-5409-4899-895a-bb78d0e8fe43"
IMG_Spieler.Name = _yhK5("\003y\vIxIW")
IMG_Spieler.Description = ""
IMG_Spieler.AltText = ""
IMG_Spieler.Resources = {
  {
    Type = "jpg",
    Filename = "Spieler.jpg",
    Directives = {}
  }
}
IMG_Ba1Troll = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1Troll.Id = "e29786d9-5bae-463d-a97b-00bb8ca8bb7e"
IMG_Ba1Troll.Name = _yhK5("\014F\"\022W}xx")
IMG_Ba1Troll.Description = ""
IMG_Ba1Troll.AltText = ""
IMG_Ba1Troll.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1Troll.jpg",
    Directives = {}
  }
}
IMG_Ba2Zone = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2Zone.Id = "7f2371ef-fb34-4779-9480-60967e4c8285"
IMG_Ba2Zone.Name = _yhK5("\014F,[}@I")
IMG_Ba2Zone.Description = ""
IMG_Ba2Zone.AltText = ""
IMG_Ba2Zone.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2Zone.jpg",
    Directives = {}
  }
}
IMG_Ba3A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3A.Id = "ca88995b-03c8-4a20-b3c4-7fa74c466104"
IMG_Ba3A.Name = _yhK5("\014Fj\027")
IMG_Ba3A.Description = ""
IMG_Ba3A.AltText = ""
IMG_Ba3A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3A.jpg",
    Directives = {}
  }
}
IMG_Ba3Zone = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3Zone.Id = "aae610a5-e6c1-420c-9c8e-046781f4adfd"
IMG_Ba3Zone.Name = _yhK5("\014Fj[}@I")
IMG_Ba3Zone.Description = ""
IMG_Ba3Zone.AltText = ""
IMG_Ba3Zone.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3Zone.jpg",
    Directives = {}
  }
}
IMG_Ba3BibZelt = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3BibZelt.Id = "64de1a28-ec33-4bb8-ac6f-720eae4f2047"
IMG_Ba3BibZelt.Name = _yhK5("\014Fj\014\v/[Ix`")
IMG_Ba3BibZelt.Description = ""
IMG_Ba3BibZelt.AltText = ""
IMG_Ba3BibZelt.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3BibZelt.jpg",
    Directives = {}
  }
}
IMG_Bibliothekar = Wherigo.ZMedia(_Ftnpx)
IMG_Bibliothekar.Id = "23e9aaf0-93d0-4607-9e2d-d20e14272c04"
IMG_Bibliothekar.Name = _yhK5("\014\v/x\v}`JIRFW")
IMG_Bibliothekar.Description = ""
IMG_Bibliothekar.AltText = ""
IMG_Bibliothekar.Resources = {
  {
    Type = "jpg",
    Filename = "Bibliothekar.jpg",
    Directives = {}
  }
}
IMG_Ba3B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3B.Id = "4b346b5d-2ae8-4108-92e4-4415f2405533"
IMG_Ba3B.Name = _yhK5("\014Fj\014")
IMG_Ba3B.Description = ""
IMG_Ba3B.AltText = ""
IMG_Ba3B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3B.jpg",
    Directives = {}
  }
}
IMG_Ba3CBibl = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3CBibl.Id = "204ef6c9-1d23-4f48-8d6e-0f81d70caa78"
IMG_Ba3CBibl.Name = _yhK5("\014Fj\001\014\v/x")
IMG_Ba3CBibl.Description = ""
IMG_Ba3CBibl.AltText = ""
IMG_Ba3CBibl.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3CBibl.jpg",
    Directives = {}
  }
}
IMG_Ba3CRaebe = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3CRaebe.Id = "7420124d-98a0-4d19-9e0d-409f252f3520"
IMG_Ba3CRaebe.Name = _yhK5("\014Fj\001\\FI/I")
IMG_Ba3CRaebe.Description = ""
IMG_Ba3CRaebe.AltText = ""
IMG_Ba3CRaebe.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3CRaebe.jpg",
    Directives = {}
  }
}
IMG_Ba3CBuch = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3CBuch.Id = "b0416486-1192-4d61-bb77-2645b4b9a98f"
IMG_Ba3CBuch.Name = _yhK5("\014Fj\001\014\b\002J")
IMG_Ba3CBuch.Description = ""
IMG_Ba3CBuch.AltText = ""
IMG_Ba3CBuch.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3CBuch.jpg",
    Directives = {}
  }
}
IMG_Intro40 = Wherigo.ZMedia(_Ftnpx)
IMG_Intro40.Id = "69eda461-acac-4e93-b84b-a985c658be48"
IMG_Intro40.Name = _yhK5("#@`W}\025z")
IMG_Intro40.Description = ""
IMG_Intro40.AltText = ""
IMG_Intro40.Resources = {
  {
    Type = "jpg",
    Filename = "intro40.jpg",
    Directives = {}
  }
}
IMG_Intro50 = Wherigo.ZMedia(_Ftnpx)
IMG_Intro50.Id = "f246df4a-0760-4168-bc53-eafe3be03da0"
IMG_Intro50.Name = _yhK5("#@`W}-z")
IMG_Intro50.Description = ""
IMG_Intro50.AltText = ""
IMG_Intro50.Resources = {
  {
    Type = "jpg",
    Filename = "intro50.jpg",
    Directives = {}
  }
}
IMG_IcoAst = Wherigo.ZMedia(_Ftnpx)
IMG_IcoAst.Id = "40e3606d-a4bd-4b30-bb89-97d37b1b61ec"
IMG_IcoAst.Name = _yhK5("#\002}\027+`")
IMG_IcoAst.Description = ""
IMG_IcoAst.AltText = ""
IMG_IcoAst.Resources = {
  {
    Type = "png",
    Filename = "Ico32-tree-branch.png",
    Directives = {}
  }
}
IMG_IcoLaterne = Wherigo.ZMedia(_Ftnpx)
IMG_IcoLaterne.Id = "9275381e-50a8-4069-a711-ef53200e2a0c"
IMG_IcoLaterne.Name = _yhK5("#\002}]F`IW@I")
IMG_IcoLaterne.Description = ""
IMG_IcoLaterne.AltText = ""
IMG_IcoLaterne.Resources = {
  {
    Type = "png",
    Filename = "Ico32-lantern-flame.png",
    Directives = {}
  }
}
IMG_IcoLolli = Wherigo.ZMedia(_Ftnpx)
IMG_IcoLolli.Id = "b6caf74b-6034-448f-9de6-d41d5d23c8bd"
IMG_IcoLolli.Name = _yhK5("#\002}]}xx\v")
IMG_IcoLolli.Description = ""
IMG_IcoLolli.AltText = ""
IMG_IcoLolli.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Lolli.png",
    Directives = {}
  }
}
IMG_IcoNotiz = Wherigo.ZMedia(_Ftnpx)
IMG_IcoNotiz.Id = "1a4e4b8f-5599-42d6-8e8d-1cf85add8d83"
IMG_IcoNotiz.Name = _yhK5("#\002}8}`\vY")
IMG_IcoNotiz.Description = ""
IMG_IcoNotiz.AltText = ""
IMG_IcoNotiz.Resources = {
  {
    Type = "png",
    Filename = "Ico32-folded-paper.png",
    Directives = {}
  }
}
IMG_IcoKeule = Wherigo.ZMedia(_Ftnpx)
IMG_IcoKeule.Id = "f772f731-6311-4996-b4bc-ea9bad7474c7"
IMG_IcoKeule.Name = _yhK5("#\002}\127I\bxI")
IMG_IcoKeule.Description = ""
IMG_IcoKeule.AltText = ""
IMG_IcoKeule.Resources = {
  {
    Type = "png",
    Filename = "Ico32-bone.png",
    Directives = {}
  }
}
IMG_Ba1D = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1D.Id = "7c073f3c-1498-4fa5-bb7f-3954242636dc"
IMG_Ba1D.Name = _yhK5("\014F\")")
IMG_Ba1D.Description = ""
IMG_Ba1D.AltText = ""
IMG_Ba1D.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1D.jpg",
    Directives = {}
  }
}
IMG_Ba1E = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1E.Id = "92677fa2-f102-4b41-a51a-11d7074a7a1d"
IMG_Ba1E.Name = _yhK5("\014F\"\a")
IMG_Ba1E.Description = ""
IMG_Ba1E.AltText = ""
IMG_Ba1E.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1E.jpg",
    Directives = {}
  }
}
IMG_Ba1G = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1G.Id = "2ff1ca01-ff96-4110-bc36-0e22641d6f27"
IMG_Ba1G.Name = _yhK5("\014F\"\028")
IMG_Ba1G.Description = ""
IMG_Ba1G.AltText = ""
IMG_Ba1G.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1G.jpg",
    Directives = {}
  }
}
IMG_Troellchen = Wherigo.ZMedia(_Ftnpx)
IMG_Troellchen.Id = "962598a4-9248-48fd-a3a1-7def8e2449a0"
IMG_Troellchen.Name = _yhK5("\022W}Ixx\002JI@")
IMG_Troellchen.Description = ""
IMG_Troellchen.AltText = ""
IMG_Troellchen.Resources = {
  {
    Type = "jpg",
    Filename = "Troellchen.jpg",
    Directives = {}
  }
}
IMG_Ba1TrollGefangen = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1TrollGefangen.Id = "35339f05-36eb-49eb-91eb-a78db801a226"
IMG_Ba1TrollGefangen.Name = _yhK5("\014F\"\022W}xx\028I\tF@DI@")
IMG_Ba1TrollGefangen.Description = ""
IMG_Ba1TrollGefangen.AltText = ""
IMG_Ba1TrollGefangen.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1TrollGefangen.jpg",
    Directives = {}
  }
}
IMG_Ba2A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2A.Id = "ba1a0c91-5a85-471e-9b45-7cdcea3665e3"
IMG_Ba2A.Name = _yhK5("\014F,\027")
IMG_Ba2A.Description = ""
IMG_Ba2A.AltText = ""
IMG_Ba2A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2A.jpg",
    Directives = {}
  }
}
IMG_Ba2B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2B.Id = "00f9cf8b-6ae2-45e7-b4f1-d8922dc7ac6a"
IMG_Ba2B.Name = _yhK5("\014F,\014")
IMG_Ba2B.Description = ""
IMG_Ba2B.AltText = ""
IMG_Ba2B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2B.jpg",
    Directives = {}
  }
}
IMG_Huegel = Wherigo.ZMedia(_Ftnpx)
IMG_Huegel.Id = "3f755230-3aaf-44c4-82ac-ef285c6dc659"
IMG_Huegel.Name = _yhK5("s\bIDIx")
IMG_Huegel.Description = ""
IMG_Huegel.AltText = ""
IMG_Huegel.Resources = {
  {
    Type = "jpg",
    Filename = "Huegel.jpg",
    Directives = {}
  }
}
IMG_Ba4A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba4A.Id = "516667eb-55bd-422c-8e2a-847b4bc8ef59"
IMG_Ba4A.Name = _yhK5("\014F\025\027")
IMG_Ba4A.Description = ""
IMG_Ba4A.AltText = ""
IMG_Ba4A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba4A.jpg",
    Directives = {}
  }
}
IMG_Ba4Zo = Wherigo.ZMedia(_Ftnpx)
IMG_Ba4Zo.Id = "80c6aac8-0c4f-410b-a7b8-ac76d6eebdf9"
IMG_Ba4Zo.Name = _yhK5("\014F\025[}")
IMG_Ba4Zo.Description = ""
IMG_Ba4Zo.AltText = ""
IMG_Ba4Zo.Resources = {
  {
    Type = "jpg",
    Filename = "Ba4Zo.jpg",
    Directives = {}
  }
}
IMG_Ba4B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba4B.Id = "8757f3d0-7a05-4cfb-99da-a688373c6152"
IMG_Ba4B.Name = _yhK5("\014F\025\014")
IMG_Ba4B.Description = ""
IMG_Ba4B.AltText = ""
IMG_Ba4B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba4B.jpg",
    Directives = {}
  }
}
IMG_Ba4C = Wherigo.ZMedia(_Ftnpx)
IMG_Ba4C.Id = "c1e893c6-09ab-46a1-9063-6dc7ea01e8bd"
IMG_Ba4C.Name = _yhK5("\014F\025\001")
IMG_Ba4C.Description = ""
IMG_Ba4C.AltText = ""
IMG_Ba4C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba4C.jpg",
    Directives = {}
  }
}
IMG_Ba4D = Wherigo.ZMedia(_Ftnpx)
IMG_Ba4D.Id = "68e559c2-fb51-47fc-bef0-4bb2874e44cd"
IMG_Ba4D.Name = _yhK5("\014F\025)")
IMG_Ba4D.Description = ""
IMG_Ba4D.AltText = ""
IMG_Ba4D.Resources = {
  {
    Type = "jpg",
    Filename = "Ba4D.jpg",
    Directives = {}
  }
}
IMG_Ba5A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba5A.Id = "30210d08-2fdf-4e9f-9c9d-30d196f4061f"
IMG_Ba5A.Name = _yhK5("\014F-\027")
IMG_Ba5A.Description = ""
IMG_Ba5A.AltText = ""
IMG_Ba5A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba5A.jpg",
    Directives = {}
  }
}
IMG_Ba5B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba5B.Id = "3db6c4c8-8e19-4271-bc36-dac0edf26980"
IMG_Ba5B.Name = _yhK5("\014F-\014")
IMG_Ba5B.Description = ""
IMG_Ba5B.AltText = ""
IMG_Ba5B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba5B.jpg",
    Directives = {}
  }
}
IMG_Ba5C = Wherigo.ZMedia(_Ftnpx)
IMG_Ba5C.Id = "b3638a66-ced1-460f-89fc-1fe9f6fdd272"
IMG_Ba5C.Name = _yhK5("\014F-\001")
IMG_Ba5C.Description = ""
IMG_Ba5C.AltText = ""
IMG_Ba5C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba5C.jpg",
    Directives = {}
  }
}
IMG_Ba5D = Wherigo.ZMedia(_Ftnpx)
IMG_Ba5D.Id = "0842ea21-0076-4941-978b-9f3234d311ed"
IMG_Ba5D.Name = _yhK5("\014F-)")
IMG_Ba5D.Description = ""
IMG_Ba5D.AltText = ""
IMG_Ba5D.Resources = {
  {
    Type = "jpg",
    Filename = "Ba5D.jpg",
    Directives = {}
  }
}
IMG_Ba6A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba6A.Id = "77ac6fb0-6171-4a21-9aa2-3b07aced2345"
IMG_Ba6A.Name = _yhK5("\014F%\027")
IMG_Ba6A.Description = ""
IMG_Ba6A.AltText = ""
IMG_Ba6A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba6A.jpg",
    Directives = {}
  }
}
IMG_Ba6B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba6B.Id = "011e3d63-8115-47df-9fdd-2e9f5ac2b26f"
IMG_Ba6B.Name = _yhK5("\014F%\014")
IMG_Ba6B.Description = ""
IMG_Ba6B.AltText = ""
IMG_Ba6B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba6B.jpg",
    Directives = {}
  }
}
IMG_Ba6C = Wherigo.ZMedia(_Ftnpx)
IMG_Ba6C.Id = "71809991-fdab-44ba-b86e-24a898986d90"
IMG_Ba6C.Name = _yhK5("\014F%\001")
IMG_Ba6C.Description = ""
IMG_Ba6C.AltText = ""
IMG_Ba6C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba6C.jpg",
    Directives = {}
  }
}
IMG_Beeren = Wherigo.ZMedia(_Ftnpx)
IMG_Beeren.Id = "265592d0-16cb-4a65-88b7-abbff098303b"
IMG_Beeren.Name = _yhK5("\014IIWI@")
IMG_Beeren.Description = ""
IMG_Beeren.AltText = ""
IMG_Beeren.Resources = {
  {
    Type = "jpg",
    Filename = "Beeren.jpg",
    Directives = {}
  }
}
IMG_Ba8A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba8A.Id = "13ea07ff-cf12-466d-9761-cb2359a1395e"
IMG_Ba8A.Name = _yhK5("\014F0\027")
IMG_Ba8A.Description = ""
IMG_Ba8A.AltText = ""
IMG_Ba8A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba8A.jpg",
    Directives = {}
  }
}
IMG_Burg = Wherigo.ZMedia(_Ftnpx)
IMG_Burg.Id = "b4e0a4da-ebe3-4696-a274-0b1c78ed7700"
IMG_Burg.Name = _yhK5("\014\bWD")
IMG_Burg.Description = ""
IMG_Burg.AltText = ""
IMG_Burg.Resources = {
  {
    Type = "jpg",
    Filename = "Burg.jpg",
    Directives = {}
  }
}
IMG_Huegel1 = Wherigo.ZMedia(_Ftnpx)
IMG_Huegel1.Id = "419ffc68-36aa-464c-a304-aa2502d0bdcf"
IMG_Huegel1.Name = _yhK5("s\bDIx\"")
IMG_Huegel1.Description = ""
IMG_Huegel1.AltText = ""
IMG_Huegel1.Resources = {
  {
    Type = "jpg",
    Filename = "Huegel1.jpg",
    Directives = {}
  }
}
IMG_Huegelfoto = Wherigo.ZMedia(_Ftnpx)
IMG_Huegelfoto.Id = "9b82fee4-970e-4922-b974-16450203a2aa"
IMG_Huegelfoto.Name = _yhK5("s\bIDIx\t}`}")
IMG_Huegelfoto.Description = ""
IMG_Huegelfoto.AltText = ""
IMG_Huegelfoto.Resources = {
  {
    Type = "jpg",
    Filename = "Huegelfoto.jpg",
    Directives = {}
  }
}
IMG_Piraten1 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten1.Id = "c44d7c0d-9898-4265-87b7-7f715ae69626"
IMG_Piraten1.Name = _yhK5("9\vWF`I@\"")
IMG_Piraten1.Description = ""
IMG_Piraten1.AltText = ""
IMG_Piraten1.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten1.jpg",
    Directives = {}
  }
}
IMG_Piraten2 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten2.Id = "cbe0a0e6-9d61-4f5f-aae9-d371802cd369"
IMG_Piraten2.Name = _yhK5("9\vWF`I@,")
IMG_Piraten2.Description = ""
IMG_Piraten2.AltText = ""
IMG_Piraten2.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten2.jpg",
    Directives = {}
  }
}
IMG_Piraten3 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten3.Id = "2a5c5803-5b55-41ec-bc0a-04baf700aae5"
IMG_Piraten3.Name = _yhK5("9\vWF`I@j")
IMG_Piraten3.Description = ""
IMG_Piraten3.AltText = ""
IMG_Piraten3.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten3.jpg",
    Directives = {}
  }
}
IMG_Piraten4 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten4.Id = "5f73a524-cf07-46c7-a4cb-b65f4e0d7daa"
IMG_Piraten4.Name = _yhK5("9\vWF`I@\025")
IMG_Piraten4.Description = ""
IMG_Piraten4.AltText = ""
IMG_Piraten4.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten4.jpg",
    Directives = {}
  }
}
IMG_Fledermaus1 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus1.Id = "be40211e-886b-4b10-933b-95465409e8df"
IMG_Fledermaus1.Name = _yhK5("lxI1IWiF\b+\"")
IMG_Fledermaus1.Description = ""
IMG_Fledermaus1.AltText = ""
IMG_Fledermaus1.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus1.jpg",
    Directives = {}
  }
}
IMG_Fledermaus2 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus2.Id = "a7232e38-5421-446d-ab3c-76e36ed4c467"
IMG_Fledermaus2.Name = _yhK5("lxI1IWiF\b+,")
IMG_Fledermaus2.Description = ""
IMG_Fledermaus2.AltText = ""
IMG_Fledermaus2.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus2.jpg",
    Directives = {}
  }
}
IMG_Fledermaus3 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus3.Id = "2807cdb6-f0b3-410d-86aa-6438ae81ff90"
IMG_Fledermaus3.Name = _yhK5("lxI1IWiF\b+j")
IMG_Fledermaus3.Description = ""
IMG_Fledermaus3.AltText = ""
IMG_Fledermaus3.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus3.jpg",
    Directives = {}
  }
}
IMG_Ba1Troll2 = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1Troll2.Id = "bb91ff2e-83d6-44ec-b00e-a952accda117"
IMG_Ba1Troll2.Name = _yhK5("\014F\"\022W}xx,")
IMG_Ba1Troll2.Description = ""
IMG_Ba1Troll2.AltText = ""
IMG_Ba1Troll2.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1Troll2.jpg",
    Directives = {}
  }
}
IMG_Ba2C = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2C.Id = "3eaa1bf4-f1b4-410c-98a7-b64ef607ffaa"
IMG_Ba2C.Name = _yhK5("\014F,\001")
IMG_Ba2C.Description = ""
IMG_Ba2C.AltText = ""
IMG_Ba2C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2C.jpg",
    Directives = {}
  }
}
IMG_Ba2D = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2D.Id = "979efbd3-abd5-48ae-add3-9efb1ece30cb"
IMG_Ba2D.Name = _yhK5("\014F,)")
IMG_Ba2D.Description = ""
IMG_Ba2D.AltText = ""
IMG_Ba2D.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2D.jpg",
    Directives = {}
  }
}
IMG_Lolli1 = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli1.Id = "e8036a4e-034a-4a69-9668-4e5d31b377ef"
IMG_Lolli1.Name = _yhK5("]}xx\v\"")
IMG_Lolli1.Description = ""
IMG_Lolli1.AltText = ""
IMG_Lolli1.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli1.jpg",
    Directives = {}
  }
}
IMG_Lolli1a = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli1a.Id = "fe6b710c-0f81-467f-92f0-93acb15cd2d0"
IMG_Lolli1a.Name = _yhK5("]}xx\v\"F")
IMG_Lolli1a.Description = ""
IMG_Lolli1a.AltText = ""
IMG_Lolli1a.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli1a.jpg",
    Directives = {}
  }
}
IMG_Lolli2 = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli2.Id = "3f757090-53b9-4102-a3d6-168067dfd919"
IMG_Lolli2.Name = _yhK5("]}xx\v,")
IMG_Lolli2.Description = ""
IMG_Lolli2.AltText = ""
IMG_Lolli2.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli2.jpg",
    Directives = {}
  }
}
IMG_Lolli2a = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli2a.Id = "6e030381-152f-4309-aba2-aa511743f290"
IMG_Lolli2a.Name = _yhK5("]}xx\v,F")
IMG_Lolli2a.Description = ""
IMG_Lolli2a.AltText = ""
IMG_Lolli2a.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli2a.jpg",
    Directives = {}
  }
}
IMG_Lolli3 = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli3.Id = "f1c2bdc2-c693-46fa-8376-c5f92859c100"
IMG_Lolli3.Name = _yhK5("]}xx\vj")
IMG_Lolli3.Description = ""
IMG_Lolli3.AltText = ""
IMG_Lolli3.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli3.jpg",
    Directives = {}
  }
}
IMG_Lolli3a = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli3a.Id = "f805c56f-cd47-494b-a4dd-1761e9264334"
IMG_Lolli3a.Name = _yhK5("]}xx\vjF")
IMG_Lolli3a.Description = ""
IMG_Lolli3a.AltText = ""
IMG_Lolli3a.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli3a.jpg",
    Directives = {}
  }
}
IMG_Ba2E = Wherigo.ZMedia(_Ftnpx)
IMG_Ba2E.Id = "28ff49b0-bb1a-406f-b9fd-807a49cdd570"
IMG_Ba2E.Name = _yhK5("\014F,\a")
IMG_Ba2E.Description = ""
IMG_Ba2E.AltText = ""
IMG_Ba2E.Resources = {
  {
    Type = "jpg",
    Filename = "Ba2E.jpg",
    Directives = {}
  }
}
IMG_Piraten0 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten0.Id = "6072ce2e-84a7-4264-bf0a-7ffe539bea35"
IMG_Piraten0.Name = _yhK5("9\vWF`I@z")
IMG_Piraten0.Description = ""
IMG_Piraten0.AltText = ""
IMG_Piraten0.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten0.jpg",
    Directives = {}
  }
}
IMG_Piraten5 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten5.Id = "5da24d6f-134b-4427-b3ca-049dfc5dfabb"
IMG_Piraten5.Name = _yhK5("9\vWF`I@-")
IMG_Piraten5.Description = ""
IMG_Piraten5.AltText = ""
IMG_Piraten5.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten5.jpg",
    Directives = {}
  }
}
IMG_Ora1 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora1.Id = "a83057ae-2784-4856-87bc-b648da7ca0ee"
IMG_Ora1.Name = _yhK5("?WF\"")
IMG_Ora1.Description = ""
IMG_Ora1.AltText = ""
IMG_Ora1.Resources = {
  {
    Type = "jpg",
    Filename = "Ora1.jpg",
    Directives = {}
  }
}
IMG_Ora2 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora2.Id = "4b4783f5-0349-4476-a582-be13422facfc"
IMG_Ora2.Name = _yhK5("?WF,")
IMG_Ora2.Description = ""
IMG_Ora2.AltText = ""
IMG_Ora2.Resources = {
  {
    Type = "jpg",
    Filename = "Ora2.jpg",
    Directives = {}
  }
}
IMG_Ora3 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora3.Id = "0c65226c-6955-412d-aaa9-d77db97a8603"
IMG_Ora3.Name = _yhK5("?WFj")
IMG_Ora3.Description = ""
IMG_Ora3.AltText = ""
IMG_Ora3.Resources = {
  {
    Type = "jpg",
    Filename = "Ora3.jpg",
    Directives = {}
  }
}
IMG_Ora4 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora4.Id = "ec3aab16-6308-41fc-8b94-bd2b66fce81a"
IMG_Ora4.Name = _yhK5("?WF\025")
IMG_Ora4.Description = ""
IMG_Ora4.AltText = ""
IMG_Ora4.Resources = {
  {
    Type = "jpg",
    Filename = "Ora4.jpg",
    Directives = {}
  }
}
IMG_Py1 = Wherigo.ZMedia(_Ftnpx)
IMG_Py1.Id = "4f2fb2f6-4440-4bc7-b7fb-29880d039e93"
IMG_Py1.Name = _yhK5("9U\"")
IMG_Py1.Description = ""
IMG_Py1.AltText = ""
IMG_Py1.Resources = {
  {
    Type = "jpg",
    Filename = "Py1.jpg",
    Directives = {}
  }
}
IMG_Nekra1 = Wherigo.ZMedia(_Ftnpx)
IMG_Nekra1.Id = "eecfa00d-5f99-406a-8109-b124157ee5f3"
IMG_Nekra1.Name = _yhK5("8IRWF\"")
IMG_Nekra1.Description = ""
IMG_Nekra1.AltText = ""
IMG_Nekra1.Resources = {
  {
    Type = "jpg",
    Filename = "Nekra1.jpg",
    Directives = {}
  }
}
IMG_Fledermaus4 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus4.Id = "8612f061-48cd-4379-87ae-821a8c0d2728"
IMG_Fledermaus4.Name = _yhK5("lxI1IWiF\b+\025")
IMG_Fledermaus4.Description = ""
IMG_Fledermaus4.AltText = ""
IMG_Fledermaus4.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus4.jpg",
    Directives = {}
  }
}
IMG_Skelett1 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett1.Id = "3cfbc8e1-a009-445d-a7de-d0e9ff4b4cf3"
IMG_Skelett1.Name = _yhK5("\003RIxI``\"")
IMG_Skelett1.Description = ""
IMG_Skelett1.AltText = ""
IMG_Skelett1.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett1.jpg",
    Directives = {}
  }
}
IMG_Skelett2 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett2.Id = "013acfbe-3d1b-4030-a2ff-044696dada91"
IMG_Skelett2.Name = _yhK5("\003RIxI``,")
IMG_Skelett2.Description = ""
IMG_Skelett2.AltText = ""
IMG_Skelett2.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett2.jpg",
    Directives = {}
  }
}
IMG_Steinhaufen1 = Wherigo.ZMedia(_Ftnpx)
IMG_Steinhaufen1.Id = "22efdad1-54e0-450a-8868-d4ec89b8e867"
IMG_Steinhaufen1.Name = _yhK5("\003`I\v@JF\b\tI@\"")
IMG_Steinhaufen1.Description = ""
IMG_Steinhaufen1.AltText = ""
IMG_Steinhaufen1.Resources = {
  {
    Type = "jpg",
    Filename = "Steinhaufen1.jpg",
    Directives = {}
  }
}
IMG_Skelett3 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett3.Id = "c14fe9db-e079-4a1c-9128-2945f161157f"
IMG_Skelett3.Name = _yhK5("\003RIxI``j")
IMG_Skelett3.Description = ""
IMG_Skelett3.AltText = ""
IMG_Skelett3.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett3.jpg",
    Directives = {}
  }
}
IMG_Nekra2 = Wherigo.ZMedia(_Ftnpx)
IMG_Nekra2.Id = "07494b4d-6b4c-4ee2-a49e-c03f7864bea0"
IMG_Nekra2.Name = _yhK5("8IRWF,")
IMG_Nekra2.Description = ""
IMG_Nekra2.AltText = ""
IMG_Nekra2.Resources = {
  {
    Type = "jpg",
    Filename = "Nekra2.jpg",
    Directives = {}
  }
}
IMG_Nekra3 = Wherigo.ZMedia(_Ftnpx)
IMG_Nekra3.Id = "e421cab9-0cea-401b-9224-d2ae65ea9eb0"
IMG_Nekra3.Name = _yhK5("8IRWFj")
IMG_Nekra3.Description = ""
IMG_Nekra3.AltText = ""
IMG_Nekra3.Resources = {
  {
    Type = "jpg",
    Filename = "Nekra3.jpg",
    Directives = {}
  }
}
IMG_Skelett4 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett4.Id = "60df4934-6b06-41b5-9719-5f1696c05247"
IMG_Skelett4.Name = _yhK5("\003RIxI``\025")
IMG_Skelett4.Description = ""
IMG_Skelett4.AltText = ""
IMG_Skelett4.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett4.jpg",
    Directives = {}
  }
}
IMG_Fledermaus0 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus0.Id = "61ace1cb-8300-4eaf-a997-2b780bbefead"
IMG_Fledermaus0.Name = _yhK5("lxI1IWiF\b+z")
IMG_Fledermaus0.Description = ""
IMG_Fledermaus0.AltText = ""
IMG_Fledermaus0.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus0.jpg",
    Directives = {}
  }
}
IMG_Skelett5 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett5.Id = "a943f1c6-1e11-45ab-9dc1-188b31da5ff1"
IMG_Skelett5.Name = _yhK5("\003RIxI``-")
IMG_Skelett5.Description = ""
IMG_Skelett5.AltText = ""
IMG_Skelett5.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett5.jpg",
    Directives = {}
  }
}
IMG_Schatztruhe1 = Wherigo.ZMedia(_Ftnpx)
IMG_Schatztruhe1.Id = "bd3222c5-cb16-4420-8599-50c1704f41a1"
IMG_Schatztruhe1.Name = _yhK5("\003\002J`F`Y`W\bJI\"")
IMG_Schatztruhe1.Description = ""
IMG_Schatztruhe1.AltText = ""
IMG_Schatztruhe1.Resources = {
  {
    Type = "jpg",
    Filename = "Schatztruhe1.jpg",
    Directives = {}
  }
}
IMG_Piraten6 = Wherigo.ZMedia(_Ftnpx)
IMG_Piraten6.Id = "9f9a148e-a6be-4e33-b7ff-3b97507c95f8"
IMG_Piraten6.Name = _yhK5("9\vWF`I@%")
IMG_Piraten6.Description = ""
IMG_Piraten6.AltText = ""
IMG_Piraten6.Resources = {
  {
    Type = "jpg",
    Filename = "Piraten6.jpg",
    Directives = {}
  }
}
IMG_Schatztruhe2 = Wherigo.ZMedia(_Ftnpx)
IMG_Schatztruhe2.Id = "27ac626b-b86e-46f4-8611-cc4ccd2e40d5"
IMG_Schatztruhe2.Name = _yhK5("\003\002JF`Y`W\bJI,")
IMG_Schatztruhe2.Description = ""
IMG_Schatztruhe2.AltText = ""
IMG_Schatztruhe2.Resources = {
  {
    Type = "jpg",
    Filename = "Schatztruhe2.jpg",
    Directives = {}
  }
}
IMG_Schatztruhe3 = Wherigo.ZMedia(_Ftnpx)
IMG_Schatztruhe3.Id = "ad74a1cb-d92d-4553-85a7-5dbea0c059c5"
IMG_Schatztruhe3.Name = _yhK5("\003\002JF`Y`W\bJIj")
IMG_Schatztruhe3.Description = ""
IMG_Schatztruhe3.AltText = ""
IMG_Schatztruhe3.Resources = {
  {
    Type = "jpg",
    Filename = "Schatztruhe3.jpg",
    Directives = {}
  }
}
Img_Ba1H = Wherigo.ZMedia(_Ftnpx)
Img_Ba1H.Id = "2643c2f0-340e-4520-8088-a151a073d5c2"
Img_Ba1H.Name = _yhK5("\014F\"s")
Img_Ba1H.Description = ""
Img_Ba1H.AltText = ""
Img_Ba1H.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1H.jpg",
    Directives = {}
  }
}
Img_Ba1J = Wherigo.ZMedia(_Ftnpx)
Img_Ba1J.Id = "69041ae9-3188-44b4-a66b-6a312cc5d739"
Img_Ba1J.Name = _yhK5("\014F\" ")
Img_Ba1J.Description = ""
Img_Ba1J.AltText = ""
Img_Ba1J.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1J.jpg",
    Directives = {}
  }
}
IMG_Ba1Troll3 = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1Troll3.Id = "f1bf0550-7dcd-4c60-ae87-6b9f0e121921"
IMG_Ba1Troll3.Name = _yhK5("\014F\"\022W}xxj")
IMG_Ba1Troll3.Description = ""
IMG_Ba1Troll3.AltText = ""
IMG_Ba1Troll3.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1Troll3.jpg",
    Directives = {}
  }
}
IMG_Wegweiser = Wherigo.ZMedia(_Ftnpx)
IMG_Wegweiser.Id = "c3e381cc-9b2c-471f-a7b9-0fe2ccb2b433"
IMG_Wegweiser.Name = _yhK5("mIDPI\v+IW")
IMG_Wegweiser.Description = ""
IMG_Wegweiser.AltText = ""
IMG_Wegweiser.Resources = {
  {
    Type = "jpg",
    Filename = "Wegweiser.jpg",
    Directives = {}
  }
}
IMG_BA8B = Wherigo.ZMedia(_Ftnpx)
IMG_BA8B.Id = "41d4fd52-f13e-402e-9100-27fa353f6c97"
IMG_BA8B.Name = _yhK5("\014\0270\014")
IMG_BA8B.Description = ""
IMG_BA8B.AltText = ""
IMG_BA8B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba8B.jpg",
    Directives = {}
  }
}
IMG_Raebe02 = Wherigo.ZMedia(_Ftnpx)
IMG_Raebe02.Id = "d3ea710d-dcdf-4c60-8973-10275c646300"
IMG_Raebe02.Name = _yhK5("\\FI/Iz,")
IMG_Raebe02.Description = ""
IMG_Raebe02.AltText = ""
IMG_Raebe02.Resources = {
  {
    Type = "jpg",
    Filename = "Raebe02.jpg",
    Directives = {}
  }
}
IMG_Goldschmied01 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied01.Id = "e2fa8d89-f9fa-4326-8150-10893b76acb1"
IMG_Goldschmied01.Name = _yhK5("\028}x1+\002Ji\vI1z\"")
IMG_Goldschmied01.Description = ""
IMG_Goldschmied01.AltText = ""
IMG_Goldschmied01.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied01.jpg",
    Directives = {}
  }
}
IMG_Goldschmied02 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied02.Id = "aa572f24-f85c-4100-a6e7-954deca84869"
IMG_Goldschmied02.Name = _yhK5("\028}x1+\002Ji\vI1z,")
IMG_Goldschmied02.Description = ""
IMG_Goldschmied02.AltText = ""
IMG_Goldschmied02.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied02.jpg",
    Directives = {}
  }
}
IMG_Goldschmied03 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied03.Id = "352742bd-d64f-46ca-a9b7-6e6e24903af9"
IMG_Goldschmied03.Name = _yhK5("\028}x1+\002Ji\vI1zj")
IMG_Goldschmied03.Description = ""
IMG_Goldschmied03.AltText = ""
IMG_Goldschmied03.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied03.jpg",
    Directives = {}
  }
}
IMG_Goldschmied04 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied04.Id = "e89a031a-aac4-4491-bf26-1711f14352cc"
IMG_Goldschmied04.Name = _yhK5("\028}x1+\002Ji\vI1z\025")
IMG_Goldschmied04.Description = ""
IMG_Goldschmied04.AltText = ""
IMG_Goldschmied04.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied04.jpg",
    Directives = {}
  }
}
IMG_Goldschmied05 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied05.Id = "8d658289-3c83-4b1e-9d1a-252e74e48ad5"
IMG_Goldschmied05.Name = _yhK5("\028}x1+\002Ji\vI1z-")
IMG_Goldschmied05.Description = ""
IMG_Goldschmied05.AltText = ""
IMG_Goldschmied05.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied05.jpg",
    Directives = {}
  }
}
IMG_Goldschmied06 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied06.Id = "6e24377d-5b75-460a-a4ce-f120b11096f1"
IMG_Goldschmied06.Name = _yhK5("\028}x1+\002Ji\vI1z%")
IMG_Goldschmied06.Description = ""
IMG_Goldschmied06.AltText = ""
IMG_Goldschmied06.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied06.jpg",
    Directives = {}
  }
}
IMG_Ba7A = Wherigo.ZMedia(_Ftnpx)
IMG_Ba7A.Id = "c0c7ded1-191a-4984-b3ef-98daef7b36de"
IMG_Ba7A.Name = _yhK5("\014F.\027")
IMG_Ba7A.Description = ""
IMG_Ba7A.AltText = ""
IMG_Ba7A.Resources = {
  {
    Type = "jpg",
    Filename = "Ba7A.jpg",
    Directives = {}
  }
}
IMG_Ba7B = Wherigo.ZMedia(_Ftnpx)
IMG_Ba7B.Id = "7cc21629-4034-4fe9-9082-63b942aff3c5"
IMG_Ba7B.Name = _yhK5("\014F.\014")
IMG_Ba7B.Description = ""
IMG_Ba7B.AltText = ""
IMG_Ba7B.Resources = {
  {
    Type = "jpg",
    Filename = "Ba7B.jpg",
    Directives = {}
  }
}
IMG_Skelett6 = Wherigo.ZMedia(_Ftnpx)
IMG_Skelett6.Id = "6691f7d0-6619-4ec9-beea-1416320bb831"
IMG_Skelett6.Name = _yhK5("\003RIxI``%")
IMG_Skelett6.Description = ""
IMG_Skelett6.AltText = ""
IMG_Skelett6.Resources = {
  {
    Type = "jpg",
    Filename = "Skelett6.jpg",
    Directives = {}
  }
}
IMG_Raebe03 = Wherigo.ZMedia(_Ftnpx)
IMG_Raebe03.Id = "07dfb081-d1dc-41f5-9db9-1a164cf8fea4"
IMG_Raebe03.Name = _yhK5("\\FI/Izj")
IMG_Raebe03.Description = ""
IMG_Raebe03.AltText = ""
IMG_Raebe03.Resources = {
  {
    Type = "jpg",
    Filename = "Raebe03.jpg",
    Directives = {}
  }
}
IMG_Keule = Wherigo.ZMedia(_Ftnpx)
IMG_Keule.Id = "5dee9e67-dcb3-4e7c-8b06-16a116016756"
IMG_Keule.Name = _yhK5("\127I\bxI")
IMG_Keule.Description = ""
IMG_Keule.AltText = ""
IMG_Keule.Resources = {
  {
    Type = "jpg",
    Filename = "Keule.jpg",
    Directives = {}
  }
}
IMG_Knochen = Wherigo.ZMedia(_Ftnpx)
IMG_Knochen.Id = "e72e26cb-e726-4fd0-a193-3b1d1521f3e6"
IMG_Knochen.Name = _yhK5("\127@}\002JI@")
IMG_Knochen.Description = ""
IMG_Knochen.AltText = ""
IMG_Knochen.Resources = {
  {
    Type = "jpg",
    Filename = "Knochen.jpg",
    Directives = {}
  }
}
IMG_IcoDokumente = Wherigo.ZMedia(_Ftnpx)
IMG_IcoDokumente.Id = "245b1637-87b2-49c0-91f1-18a979e6e706"
IMG_IcoDokumente.Name = _yhK5("#\002})}R\biI@`I")
IMG_IcoDokumente.Description = ""
IMG_IcoDokumente.AltText = ""
IMG_IcoDokumente.Resources = {
  {
    Type = "png",
    Filename = "Ico32-papers.png",
    Directives = {}
  }
}
IMG_IcoBuch = Wherigo.ZMedia(_Ftnpx)
IMG_IcoBuch.Id = "f7951642-31b7-4dd2-a68f-35b58380d66e"
IMG_IcoBuch.Name = _yhK5("#\002}\014\b\002J")
IMG_IcoBuch.Description = ""
IMG_IcoBuch.AltText = ""
IMG_IcoBuch.Resources = {
  {
    Type = "png",
    Filename = "Ico32-book.png",
    Directives = {}
  }
}
IMG_IcoBeeren = Wherigo.ZMedia(_Ftnpx)
IMG_IcoBeeren.Id = "7aa6175d-268b-4f82-921f-d3545a020f63"
IMG_IcoBeeren.Name = _yhK5("#\002}\014IIWI@")
IMG_IcoBeeren.Description = ""
IMG_IcoBeeren.AltText = ""
IMG_IcoBeeren.Resources = {
  {
    Type = "png",
    Filename = "Ico32-elderberry.png",
    Directives = {}
  }
}
IMG_IcoSchluessel = Wherigo.ZMedia(_Ftnpx)
IMG_IcoSchluessel.Id = "9e4095c0-29ee-4775-835b-48004ec8f8ad"
IMG_IcoSchluessel.Name = _yhK5("#\002}\003\002Jx\bI++Ix")
IMG_IcoSchluessel.Description = ""
IMG_IcoSchluessel.AltText = ""
IMG_IcoSchluessel.Resources = {
  {
    Type = "png",
    Filename = "Ico32-key.png",
    Directives = {}
  }
}
IMG_IcoGral = Wherigo.ZMedia(_Ftnpx)
IMG_IcoGral.Id = "d4bb9429-6fd0-43a7-af49-6254d5054e96"
IMG_IcoGral.Name = _yhK5("#\002}\028WFx")
IMG_IcoGral.Description = ""
IMG_IcoGral.AltText = ""
IMG_IcoGral.Resources = {
  {
    Type = "png",
    Filename = "Ico32-glass.png",
    Directives = {}
  }
}
IMG_IcoMuenzen = Wherigo.ZMedia(_Ftnpx)
IMG_IcoMuenzen.Id = "51b1b335-ab6a-48bb-9027-9c0b99ea0b01"
IMG_IcoMuenzen.Name = _yhK5("#\002}o\bI@YI@")
IMG_IcoMuenzen.Description = ""
IMG_IcoMuenzen.AltText = ""
IMG_IcoMuenzen.Resources = {
  {
    Type = "png",
    Filename = "Ico32-coins.png",
    Directives = {}
  }
}
IMG_IcoTroll = Wherigo.ZMedia(_Ftnpx)
IMG_IcoTroll.Id = "d72fa420-40f9-4e6c-b847-00c6b2a870fd"
IMG_IcoTroll.Name = _yhK5("#\002}\022W}xx")
IMG_IcoTroll.Description = ""
IMG_IcoTroll.AltText = ""
IMG_IcoTroll.Resources = {
  {
    Type = "png",
    Filename = "IcoTroll.png",
    Directives = {}
  }
}
IMG_BlaueMauritius = Wherigo.ZMedia(_Ftnpx)
IMG_BlaueMauritius.Id = "bf35dc98-0e86-4aef-a99e-175e2dfe9ded"
IMG_BlaueMauritius.Name = _yhK5("\014xF\bIoF\bW\v`\v\b+")
IMG_BlaueMauritius.Description = ""
IMG_BlaueMauritius.AltText = ""
IMG_BlaueMauritius.Resources = {
  {
    Type = "jpg",
    Filename = "Blaue_Mauritius.jpg",
    Directives = {}
  }
}
IMG_IcoRaebe = Wherigo.ZMedia(_Ftnpx)
IMG_IcoRaebe.Id = "a9d5fc13-c7da-437d-87ae-08e4d6d17798"
IMG_IcoRaebe.Name = _yhK5("#\002}\\FI/I")
IMG_IcoRaebe.Description = ""
IMG_IcoRaebe.AltText = ""
IMG_IcoRaebe.Resources = {
  {
    Type = "png",
    Filename = "IcoRaebe.png",
    Directives = {}
  }
}
IMG_IcoCartridge = Wherigo.ZMedia(_Ftnpx)
IMG_IcoCartridge.Id = "7f5f6ce9-0d6f-4125-9ea1-2b476db0651b"
IMG_IcoCartridge.Name = _yhK5("#\002}\001FW`W\v1DI")
IMG_IcoCartridge.Description = ""
IMG_IcoCartridge.AltText = ""
IMG_IcoCartridge.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Cartridge.png",
    Directives = {}
  }
}
IMG_Cover = Wherigo.ZMedia(_Ftnpx)
IMG_Cover.Id = "be461733-3cc1-4cd8-9e65-a265e7457c35"
IMG_Cover.Name = _yhK5("\001}wIW")
IMG_Cover.Description = ""
IMG_Cover.AltText = ""
IMG_Cover.Resources = {
  {
    Type = "jpg",
    Filename = "cover.jpg",
    Directives = {}
  }
}
IMG_Ba3Troll = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3Troll.Id = "b9c84ca1-76af-4cc1-8a04-448e1c39b55f"
IMG_Ba3Troll.Name = _yhK5("\014Fj\022W}xx")
IMG_Ba3Troll.Description = ""
IMG_Ba3Troll.AltText = ""
IMG_Ba3Troll.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3Troll.jpg",
    Directives = {}
  }
}
IMG_Ba3Rucksack = Wherigo.ZMedia(_Ftnpx)
IMG_Ba3Rucksack.Id = "b467cfbb-8c7a-494a-8b53-1196320c0254"
IMG_Ba3Rucksack.Name = _yhK5("\014Fj\\\b\002R+F\002R")
IMG_Ba3Rucksack.Description = ""
IMG_Ba3Rucksack.AltText = ""
IMG_Ba3Rucksack.Resources = {
  {
    Type = "jpg",
    Filename = "Ba3Rucksack.jpg",
    Directives = {}
  }
}
IMG_Ba6Beeren = Wherigo.ZMedia(_Ftnpx)
IMG_Ba6Beeren.Id = "5c15a14b-82b8-418b-94ff-6d62093121cb"
IMG_Ba6Beeren.Name = _yhK5("\014F%\014IIWI@")
IMG_Ba6Beeren.Description = ""
IMG_Ba6Beeren.AltText = ""
IMG_Ba6Beeren.Resources = {
  {
    Type = "jpg",
    Filename = "Ba6Beeren.jpg",
    Directives = {}
  }
}
IMG_Trollbuch = Wherigo.ZMedia(_Ftnpx)
IMG_Trollbuch.Id = "d3b4534e-483e-44e4-80b3-5c90bda8e18a"
IMG_Trollbuch.Name = _yhK5("\022W}xx/\b\002J")
IMG_Trollbuch.Description = ""
IMG_Trollbuch.AltText = ""
IMG_Trollbuch.Resources = {
  {
    Type = "jpg",
    Filename = "Troellbuch.jpg",
    Directives = {}
  }
}
IMG_Ausweis = Wherigo.ZMedia(_Ftnpx)
IMG_Ausweis.Id = "4726c040-d3bf-49ff-8b05-0ecb5289ce43"
IMG_Ausweis.Name = _yhK5("\027\b+PI\v+")
IMG_Ausweis.Description = ""
IMG_Ausweis.AltText = ""
IMG_Ausweis.Resources = {
  {
    Type = "jpg",
    Filename = "Ausweis.jpg",
    Directives = {}
  }
}
IMG_IcoAusweis = Wherigo.ZMedia(_Ftnpx)
IMG_IcoAusweis.Id = "e3962ada-7f89-412c-98ab-7b98c8363ef5"
IMG_IcoAusweis.Name = _yhK5("#\002}\027\b+PI\v+")
IMG_IcoAusweis.Description = ""
IMG_IcoAusweis.AltText = ""
IMG_IcoAusweis.Resources = {
  {
    Type = "png",
    Filename = "Ico32-ausweis.png",
    Directives = {}
  }
}
IMG_TuchWeiss = Wherigo.ZMedia(_Ftnpx)
IMG_TuchWeiss.Id = "4d280103-901d-4394-bf90-46b6c0d574f7"
IMG_TuchWeiss.Name = _yhK5("\022\b\002JmI\v++")
IMG_TuchWeiss.Description = ""
IMG_TuchWeiss.AltText = ""
IMG_TuchWeiss.Resources = {
  {
    Type = "jpg",
    Filename = "TuchWeiss.jpg",
    Directives = {}
  }
}
IMG_IcoTuch = Wherigo.ZMedia(_Ftnpx)
IMG_IcoTuch.Id = "d1cb55e3-9081-4434-835f-71b2098a1f90"
IMG_IcoTuch.Name = _yhK5("#\002}\022\b\002J")
IMG_IcoTuch.Description = ""
IMG_IcoTuch.AltText = ""
IMG_IcoTuch.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Tuch.png",
    Directives = {}
  }
}
IMG_Schluessel = Wherigo.ZMedia(_Ftnpx)
IMG_Schluessel.Id = "d656b356-6d9a-4883-8a45-2d5860ab7864"
IMG_Schluessel.Name = _yhK5("\003\002Jx\bI++Ix")
IMG_Schluessel.Description = ""
IMG_Schluessel.AltText = ""
IMG_Schluessel.Resources = {
  {
    Type = "jpg",
    Filename = "Schluessel.jpg",
    Directives = {}
  }
}
IMG_Gral = Wherigo.ZMedia(_Ftnpx)
IMG_Gral.Id = "5a7007dc-ccfe-40f9-bce9-4b8be58e1dce"
IMG_Gral.Name = _yhK5("\028WFx")
IMG_Gral.Description = ""
IMG_Gral.AltText = ""
IMG_Gral.Resources = {
  {
    Type = "jpg",
    Filename = "Gral.jpg",
    Directives = {}
  }
}
IMG_Gold = Wherigo.ZMedia(_Ftnpx)
IMG_Gold.Id = "7f368f51-e378-4331-86cb-6e124f0f02bc"
IMG_Gold.Name = _yhK5("\028}x1")
IMG_Gold.Description = ""
IMG_Gold.AltText = ""
IMG_Gold.Resources = {
  {
    Type = "jpg",
    Filename = "Gold.jpg",
    Directives = {}
  }
}
IMG_IcoBriefmarke = Wherigo.ZMedia(_Ftnpx)
IMG_IcoBriefmarke.Id = "e2e016c8-444d-4ec4-8ed0-6d3b3747fe17"
IMG_IcoBriefmarke.Name = _yhK5("#\002}\014W\vI\tiFWRI")
IMG_IcoBriefmarke.Description = ""
IMG_IcoBriefmarke.AltText = ""
IMG_IcoBriefmarke.Resources = {
  {
    Type = "png",
    Filename = "Ico32-briefmarke.png",
    Directives = {}
  }
}
IMG_IcoFoto = Wherigo.ZMedia(_Ftnpx)
IMG_IcoFoto.Id = "f568b6ba-6cc9-4b2c-af7a-5dd0f72afe7a"
IMG_IcoFoto.Name = _yhK5("#\002}l}`}")
IMG_IcoFoto.Description = ""
IMG_IcoFoto.AltText = ""
IMG_IcoFoto.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Foto.png",
    Directives = {}
  }
}
IMG_Dokument = Wherigo.ZMedia(_Ftnpx)
IMG_Dokument.Id = "ed446c05-4c12-4247-884a-0be01ef41fb6"
IMG_Dokument.Name = _yhK5(")}R\biI@`")
IMG_Dokument.Description = ""
IMG_Dokument.AltText = ""
IMG_Dokument.Resources = {
  {
    Type = "jpg",
    Filename = "Dokument.jpg",
    Directives = {}
  }
}
IMG_Haar = Wherigo.ZMedia(_Ftnpx)
IMG_Haar.Id = "e6dea094-5b79-4ed3-b705-10668384173e"
IMG_Haar.Name = _yhK5("sFFW")
IMG_Haar.Description = ""
IMG_Haar.AltText = ""
IMG_Haar.Resources = {
  {
    Type = "jpg",
    Filename = "Haar.jpg",
    Directives = {}
  }
}
IMG_IcoHaar = Wherigo.ZMedia(_Ftnpx)
IMG_IcoHaar.Id = "bfa4bb20-5b80-4a3f-a660-b1e7af8fd0c9"
IMG_IcoHaar.Name = _yhK5("#\002}sFFW")
IMG_IcoHaar.Description = ""
IMG_IcoHaar.AltText = ""
IMG_IcoHaar.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Draht.png",
    Directives = {}
  }
}
IMG_Kettchen = Wherigo.ZMedia(_Ftnpx)
IMG_Kettchen.Id = "a730b588-4d82-4d78-88e2-38c10438120a"
IMG_Kettchen.Name = _yhK5("\127I``\002JI@")
IMG_Kettchen.Description = ""
IMG_Kettchen.AltText = ""
IMG_Kettchen.Resources = {
  {
    Type = "jpg",
    Filename = "Kettchen.jpg",
    Directives = {}
  }
}
_opRKv = Wherigo.ZMedia(_Ftnpx)
_opRKv.Id = "2bb1440b-8693-413b-b738-a108cb0cc5e5"
_opRKv.Name = _yhK5("#\002}\127I``\002JI@")
_opRKv.Description = ""
_opRKv.AltText = ""
_opRKv.Resources = {
  {
    Type = "png",
    Filename = "Ico32-gem-chain.png",
    Directives = {}
  }
}
IMG_Lolli4x = Wherigo.ZMedia(_Ftnpx)
IMG_Lolli4x.Id = "63006190-d80b-4c29-a21c-230328dbcf54"
IMG_Lolli4x.Name = _yhK5("]}xx\v\0253")
IMG_Lolli4x.Description = ""
IMG_Lolli4x.AltText = ""
IMG_Lolli4x.Resources = {
  {
    Type = "jpg",
    Filename = "Lolli4x.jpg",
    Directives = {}
  }
}
IMG_Schild = Wherigo.ZMedia(_Ftnpx)
IMG_Schild.Id = "43aa0df4-9840-444d-9d6d-cef71993ed07"
IMG_Schild.Name = _yhK5("\003\002J\vx1")
IMG_Schild.Description = ""
IMG_Schild.AltText = ""
IMG_Schild.Resources = {
  {
    Type = "jpg",
    Filename = "Schild.jpg",
    Directives = {}
  }
}
IMG_Uhr = Wherigo.ZMedia(_Ftnpx)
IMG_Uhr.Id = "c517a076-94f7-43ab-b92d-ac10fd373c6d"
IMG_Uhr.Name = _yhK5("tJW")
IMG_Uhr.Description = ""
IMG_Uhr.AltText = ""
IMG_Uhr.Resources = {
  {
    Type = "jpg",
    Filename = "uhr.jpg",
    Directives = {}
  }
}
IMG_IcoUhr = Wherigo.ZMedia(_Ftnpx)
IMG_IcoUhr.Id = "6495bb27-c329-4df1-a6ba-13fe82af2972"
IMG_IcoUhr.Name = _yhK5("#\002}tJW")
IMG_IcoUhr.Description = ""
IMG_IcoUhr.AltText = ""
IMG_IcoUhr.Resources = {
  {
    Type = "png",
    Filename = "Ico32-stopwatch.png",
    Directives = {}
  }
}
IMG_IcoWegweiser = Wherigo.ZMedia(_Ftnpx)
IMG_IcoWegweiser.Id = "79a3eede-5bb3-4ca2-adc4-b37f2d7a1054"
IMG_IcoWegweiser.Name = _yhK5("#\002}mIDPI\v+IW")
IMG_IcoWegweiser.Description = ""
IMG_IcoWegweiser.AltText = ""
IMG_IcoWegweiser.Resources = {
  {
    Type = "png",
    Filename = "Ico32-wegweiser.png",
    Directives = {}
  }
}
IMG_BibRuf = Wherigo.ZMedia(_Ftnpx)
IMG_BibRuf.Id = "0aa00909-a20f-46d4-a238-caf4eff78f25"
IMG_BibRuf.Name = _yhK5("\014\v/\\\b\t")
IMG_BibRuf.Description = ""
IMG_BibRuf.AltText = ""
IMG_BibRuf.Resources = {
  {
    Type = "jpg",
    Filename = "BibRuf.jpg",
    Directives = {}
  }
}
IMG_SchatzkisteOffen = Wherigo.ZMedia(_Ftnpx)
IMG_SchatzkisteOffen.Id = "20516ccb-c315-46df-8105-d045f9fc3587"
IMG_SchatzkisteOffen.Name = _yhK5("\003\002JF`YR\v+`I?\t\tI@")
IMG_SchatzkisteOffen.Description = ""
IMG_SchatzkisteOffen.AltText = ""
IMG_SchatzkisteOffen.Resources = {
  {
    Type = "jpg",
    Filename = "SchatzkisteOffen.jpg",
    Directives = {}
  }
}
IMG_UhrZoom = Wherigo.ZMedia(_Ftnpx)
IMG_UhrZoom.Id = "b261d42c-7550-4e14-a392-44c6aa1fae9d"
IMG_UhrZoom.Name = _yhK5("tJW[}}i")
IMG_UhrZoom.Description = ""
IMG_UhrZoom.AltText = ""
IMG_UhrZoom.Resources = {
  {
    Type = "jpg",
    Filename = "uhr-zoom.jpg",
    Directives = {}
  }
}
IMG_Anhaenger = Wherigo.ZMedia(_Ftnpx)
IMG_Anhaenger.Id = "acbeb5ce-a87f-4962-9b9d-bd135cb39742"
IMG_Anhaenger.Name = _yhK5("\027@JFI@DIW")
IMG_Anhaenger.Description = ""
IMG_Anhaenger.AltText = ""
IMG_Anhaenger.Resources = {
  {
    Type = "jpg",
    Filename = "Anhaenger.jpg",
    Directives = {}
  }
}
IMG_Indy = Wherigo.ZMedia(_Ftnpx)
IMG_Indy.Id = "59ae1d0c-4e86-49e4-ac7b-70e092fa4060"
IMG_Indy.Name = _yhK5("#@1U")
IMG_Indy.Description = ""
IMG_Indy.AltText = ""
IMG_Indy.Resources = {
  {
    Type = "jpg",
    Filename = "Indy.jpg",
    Directives = {}
  }
}
IMG_FinA1 = Wherigo.ZMedia(_Ftnpx)
IMG_FinA1.Id = "ab2393ff-78ad-4ff7-80dd-79424b2362a4"
IMG_FinA1.Name = _yhK5("l\v@\027\"")
IMG_FinA1.Description = ""
IMG_FinA1.AltText = ""
IMG_FinA1.Resources = {
  {
    Type = "jpg",
    Filename = "finA1.jpg",
    Directives = {}
  }
}
IMG_FinA2 = Wherigo.ZMedia(_Ftnpx)
IMG_FinA2.Id = "60e2757d-b905-4d58-96db-95d63596cb77"
IMG_FinA2.Name = _yhK5("l\v@\027,")
IMG_FinA2.Description = ""
IMG_FinA2.AltText = ""
IMG_FinA2.Resources = {
  {
    Type = "jpg",
    Filename = "finA2.jpg",
    Directives = {}
  }
}
IMG_FinA3 = Wherigo.ZMedia(_Ftnpx)
IMG_FinA3.Id = "7e3618f9-1733-4437-a62e-4ad9905fd3c8"
IMG_FinA3.Name = _yhK5("l\v@\027j")
IMG_FinA3.Description = ""
IMG_FinA3.AltText = ""
IMG_FinA3.Resources = {
  {
    Type = "jpg",
    Filename = "finA3.jpg",
    Directives = {}
  }
}
IMG_FinB = Wherigo.ZMedia(_Ftnpx)
IMG_FinB.Id = "03878341-70ec-4b5e-b7e2-bcbf54f1b5e5"
IMG_FinB.Name = _yhK5("l\v@\014")
IMG_FinB.Description = ""
IMG_FinB.AltText = ""
IMG_FinB.Resources = {
  {
    Type = "jpg",
    Filename = "finB.jpg",
    Directives = {}
  }
}
IMG_Raebe04 = Wherigo.ZMedia(_Ftnpx)
IMG_Raebe04.Id = "c6526e80-e56f-4fe5-9dbc-0843822c6573"
IMG_Raebe04.Name = _yhK5("\\FI/Iz\025")
IMG_Raebe04.Description = ""
IMG_Raebe04.AltText = ""
IMG_Raebe04.Resources = {
  {
    Type = "jpg",
    Filename = "Raebe04.jpg",
    Directives = {}
  }
}
IMG_Fledermaus5 = Wherigo.ZMedia(_Ftnpx)
IMG_Fledermaus5.Id = "f33f4dfc-dccb-4de9-8b86-543eb06b2a47"
IMG_Fledermaus5.Name = _yhK5("lxI1IWiF\b+-")
IMG_Fledermaus5.Description = ""
IMG_Fledermaus5.AltText = ""
IMG_Fledermaus5.Resources = {
  {
    Type = "jpg",
    Filename = "Fledermaus5.jpg",
    Directives = {}
  }
}
IMG_FinC1 = Wherigo.ZMedia(_Ftnpx)
IMG_FinC1.Id = "73abbb04-03be-4cd1-ae44-e71d5b5048b5"
IMG_FinC1.Name = _yhK5("l\v@\001\"")
IMG_FinC1.Description = ""
IMG_FinC1.AltText = ""
IMG_FinC1.Resources = {
  {
    Type = "jpg",
    Filename = "finC1.jpg",
    Directives = {}
  }
}
IMG_FinC2 = Wherigo.ZMedia(_Ftnpx)
IMG_FinC2.Id = "8c7b2a87-6c5c-486d-801d-32ebbe39716c"
IMG_FinC2.Name = _yhK5("l\v@\001,")
IMG_FinC2.Description = ""
IMG_FinC2.AltText = ""
IMG_FinC2.Resources = {
  {
    Type = "jpg",
    Filename = "finC2.jpg",
    Directives = {}
  }
}
IMG_IcoAnhaenger = Wherigo.ZMedia(_Ftnpx)
IMG_IcoAnhaenger.Id = "8abd4045-5132-44e5-b092-5274e4fe299f"
IMG_IcoAnhaenger.Name = _yhK5("#\002}\027@JFI@DIW")
IMG_IcoAnhaenger.Description = ""
IMG_IcoAnhaenger.AltText = ""
IMG_IcoAnhaenger.Resources = {
  {
    Type = "png",
    Filename = "Ico32-anhaenger.png",
    Directives = {}
  }
}
IMG_IcoRinge = Wherigo.ZMedia(_Ftnpx)
IMG_IcoRinge.Id = "8fd90988-d5b9-4db7-aa32-8a3647b2ffa3"
IMG_IcoRinge.Name = _yhK5("#\002}\\\v@DI")
IMG_IcoRinge.Description = ""
IMG_IcoRinge.AltText = ""
IMG_IcoRinge.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Ringe.png",
    Directives = {}
  }
}
IMG_Sonne0 = Wherigo.ZMedia(_Ftnpx)
IMG_Sonne0.Id = "06f775ec-a429-478e-b258-71ba9e07b4a9"
IMG_Sonne0.Name = _yhK5("\003}@@Iz")
IMG_Sonne0.Description = ""
IMG_Sonne0.AltText = ""
IMG_Sonne0.Resources = {
  {
    Type = "jpg",
    Filename = "Sonne0.jpg",
    Directives = {}
  }
}
IMG_IcoCode = Wherigo.ZMedia(_Ftnpx)
IMG_IcoCode.Id = "cd5a5c66-489a-4924-b92a-0531a8ab9294"
IMG_IcoCode.Name = _yhK5("#\002}\001}1I")
IMG_IcoCode.Description = ""
IMG_IcoCode.AltText = ""
IMG_IcoCode.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Code.png",
    Directives = {}
  }
}
IMG_Indy2 = Wherigo.ZMedia(_Ftnpx)
IMG_Indy2.Id = "d31d5068-07f6-425c-8568-2da5b40a89fe"
IMG_Indy2.Name = _yhK5("#@1U,")
IMG_Indy2.Description = ""
IMG_Indy2.AltText = ""
IMG_Indy2.Resources = {
  {
    Type = "jpg",
    Filename = "Indy2.jpg",
    Directives = {}
  }
}
IMG_Code = Wherigo.ZMedia(_Ftnpx)
IMG_Code.Id = "22ca83fb-748c-44c6-bac7-ecd0a714e18c"
IMG_Code.Name = _yhK5("\001}1I")
IMG_Code.Description = ""
IMG_Code.AltText = ""
IMG_Code.Resources = {
  {
    Type = "jpg",
    Filename = "Code.jpg",
    Directives = {}
  }
}
IMG_BibRuf0 = Wherigo.ZMedia(_Ftnpx)
IMG_BibRuf0.Id = "86880933-40af-4962-b495-127f77e77a0d"
IMG_BibRuf0.Name = _yhK5("\014\v/\\\b\tz")
IMG_BibRuf0.Description = ""
IMG_BibRuf0.AltText = ""
IMG_BibRuf0.Resources = {
  {
    Type = "jpg",
    Filename = "BibRuf0.jpg",
    Directives = {}
  }
}
IMG_Gummiringe = Wherigo.ZMedia(_Ftnpx)
IMG_Gummiringe.Id = "c4bc8fff-053e-49a5-af66-dcf7f8558018"
IMG_Gummiringe.Name = _yhK5("\028\bii\vW\v@DI")
IMG_Gummiringe.Description = ""
IMG_Gummiringe.AltText = ""
IMG_Gummiringe.Resources = {
  {
    Type = "jpg",
    Filename = "Gummiringe.jpg",
    Directives = {}
  }
}
IMG_BA3D1 = Wherigo.ZMedia(_Ftnpx)
IMG_BA3D1.Id = "bf25fe4d-4cb7-41ff-8c4c-609da5e3f21c"
IMG_BA3D1.Name = _yhK5("\014\027j)\"")
IMG_BA3D1.Description = ""
IMG_BA3D1.AltText = ""
IMG_BA3D1.Resources = {
  {
    Type = "jpg",
    Filename = "BA3D1.jpg",
    Directives = {}
  }
}
IMG_BA3D2 = Wherigo.ZMedia(_Ftnpx)
IMG_BA3D2.Id = "043e0ece-f14c-4efd-80a3-2a4cd6ec2104"
IMG_BA3D2.Name = _yhK5("\014\027j),")
IMG_BA3D2.Description = ""
IMG_BA3D2.AltText = ""
IMG_BA3D2.Resources = {
  {
    Type = "jpg",
    Filename = "BA3D2.jpg",
    Directives = {}
  }
}
IMG_BA3D3 = Wherigo.ZMedia(_Ftnpx)
IMG_BA3D3.Id = "791a42a5-4a5c-4eee-b35a-ec3ecdc50b8c"
IMG_BA3D3.Name = _yhK5("\014\027j)j")
IMG_BA3D3.Description = ""
IMG_BA3D3.AltText = ""
IMG_BA3D3.Resources = {
  {
    Type = "jpg",
    Filename = "BA3D3.jpg",
    Directives = {}
  }
}
IMG_BA7C = Wherigo.ZMedia(_Ftnpx)
IMG_BA7C.Id = "1545dce0-9ad4-42db-8068-48ced2b1cf1b"
IMG_BA7C.Name = _yhK5("\014\027.\001")
IMG_BA7C.Description = ""
IMG_BA7C.AltText = ""
IMG_BA7C.Resources = {
  {
    Type = "jpg",
    Filename = "Ba7C.jpg",
    Directives = {}
  }
}
IMG_WegweiserZone = Wherigo.ZMedia(_Ftnpx)
IMG_WegweiserZone.Id = "6e859b39-ff51-4cd4-a6c9-3dc19194db7f"
IMG_WegweiserZone.Name = _yhK5("mIDPI\v+IW[}@I")
IMG_WegweiserZone.Description = ""
IMG_WegweiserZone.AltText = ""
IMG_WegweiserZone.Resources = {
  {
    Type = "jpg",
    Filename = "WegweiserZone.jpg",
    Directives = {}
  }
}
IMG_Mitternacht = Wherigo.ZMedia(_Ftnpx)
IMG_Mitternacht.Id = "7f38b619-6e90-40a9-824e-06b1fcd6f275"
IMG_Mitternacht.Name = _yhK5("o\v``IW@F\002J`")
IMG_Mitternacht.Description = ""
IMG_Mitternacht.AltText = ""
IMG_Mitternacht.Resources = {
  {
    Type = "jpg",
    Filename = "Mitternacht.jpg",
    Directives = {}
  }
}
IMG_TuchBunt = Wherigo.ZMedia(_Ftnpx)
IMG_TuchBunt.Id = "939b56af-1ac2-4bc9-8519-192c53227a53"
IMG_TuchBunt.Name = _yhK5("\022\b\002J\014\b@`")
IMG_TuchBunt.Description = ""
IMG_TuchBunt.AltText = ""
IMG_TuchBunt.Resources = {
  {
    Type = "jpg",
    Filename = "TuchBunt.jpg",
    Directives = {}
  }
}
IMG_GralMix1 = Wherigo.ZMedia(_Ftnpx)
IMG_GralMix1.Id = "a7874000-ab41-4c1f-863a-0dfeccd929cd"
IMG_GralMix1.Name = _yhK5("\028WFxo\v3\"")
IMG_GralMix1.Description = ""
IMG_GralMix1.AltText = ""
IMG_GralMix1.Resources = {
  {
    Type = "jpg",
    Filename = "GralMix1.jpg",
    Directives = {}
  }
}
IMG_GralMin2 = Wherigo.ZMedia(_Ftnpx)
IMG_GralMin2.Id = "825c17e2-b19b-46f7-8607-2cb6efb626a6"
IMG_GralMin2.Name = _yhK5("\028WFxo\v@,")
IMG_GralMin2.Description = ""
IMG_GralMin2.AltText = ""
IMG_GralMin2.Resources = {
  {
    Type = "jpg",
    Filename = "GralMix2.jpg",
    Directives = {}
  }
}
IMG_GralMin3 = Wherigo.ZMedia(_Ftnpx)
IMG_GralMin3.Id = "1aa7624a-076e-4a96-b40d-9f37b1d6b9b3"
IMG_GralMin3.Name = _yhK5("\028WFxo\v@j")
IMG_GralMin3.Description = ""
IMG_GralMin3.AltText = ""
IMG_GralMin3.Resources = {
  {
    Type = "jpg",
    Filename = "GralMix3.jpg",
    Directives = {}
  }
}
IMG_FinD1 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD1.Id = "b2e21a15-b072-4d32-9cdd-47e7c25e1601"
IMG_FinD1.Name = _yhK5("l\v@)\"")
IMG_FinD1.Description = ""
IMG_FinD1.AltText = ""
IMG_FinD1.Resources = {
  {
    Type = "jpg",
    Filename = "FinD1.jpg",
    Directives = {}
  }
}
IMG_FinD2 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD2.Id = "82a5e87a-1627-4950-974b-af60c83a6174"
IMG_FinD2.Name = _yhK5("l\v@),")
IMG_FinD2.Description = ""
IMG_FinD2.AltText = ""
IMG_FinD2.Resources = {
  {
    Type = "jpg",
    Filename = "FinD2.jpg",
    Directives = {}
  }
}
IMG_FinD3 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD3.Id = "1791fc46-4e4f-4f4b-834b-af901b6d98fa"
IMG_FinD3.Name = _yhK5("l\v@)j")
IMG_FinD3.Description = ""
IMG_FinD3.AltText = ""
IMG_FinD3.Resources = {
  {
    Type = "jpg",
    Filename = "FinD3.jpg",
    Directives = {}
  }
}
IMG_FinD4 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD4.Id = "805c0f87-944f-4467-953a-7cedbba7fbe4"
IMG_FinD4.Name = _yhK5("l\v@)\025")
IMG_FinD4.Description = ""
IMG_FinD4.AltText = ""
IMG_FinD4.Resources = {
  {
    Type = "jpg",
    Filename = "FinD4.jpg",
    Directives = {}
  }
}
IM_FinD0 = Wherigo.ZMedia(_Ftnpx)
IM_FinD0.Id = "6b8e45b2-8eb2-4b9f-8cd2-40ae44586b79"
IM_FinD0.Name = _yhK5("l\v@)z")
IM_FinD0.Description = ""
IM_FinD0.AltText = ""
IM_FinD0.Resources = {
  {
    Type = "jpg",
    Filename = "FinD0.jpg",
    Directives = {}
  }
}
IMG_BA5E = Wherigo.ZMedia(_Ftnpx)
IMG_BA5E.Id = "f4d6f25c-df01-4eb7-9b6c-52b2311bbaf9"
IMG_BA5E.Name = _yhK5("\014F-\a")
IMG_BA5E.Description = ""
IMG_BA5E.AltText = ""
IMG_BA5E.Resources = {
  {
    Type = "jpg",
    Filename = "Ba5E.jpg",
    Directives = {}
  }
}
IMG_Goldschmied00 = Wherigo.ZMedia(_Ftnpx)
IMG_Goldschmied00.Id = "43c85382-7147-4dab-82a9-d214427c4953"
IMG_Goldschmied00.Name = _yhK5("\028}x1+\002Ji\vI1zz")
IMG_Goldschmied00.Description = ""
IMG_Goldschmied00.AltText = ""
IMG_Goldschmied00.Resources = {
  {
    Type = "jpg",
    Filename = "Goldschmied00.jpg",
    Directives = {}
  }
}
IMG_FinD5 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD5.Id = "413f61cb-73fd-4e5c-8045-a3ab02a86ea9"
IMG_FinD5.Name = _yhK5("l\v@)-")
IMG_FinD5.Description = ""
IMG_FinD5.AltText = ""
IMG_FinD5.Resources = {
  {
    Type = "jpg",
    Filename = "FinD5.jpg",
    Directives = {}
  }
}
IMG_FinE1 = Wherigo.ZMedia(_Ftnpx)
IMG_FinE1.Id = "9498d6a5-a6aa-4b22-a6f1-3a75f43946bc"
IMG_FinE1.Name = _yhK5("l\v@\a\"")
IMG_FinE1.Description = ""
IMG_FinE1.AltText = ""
IMG_FinE1.Resources = {
  {
    Type = "jpg",
    Filename = "FinE1.jpg",
    Directives = {}
  }
}
IMG_FinE2 = Wherigo.ZMedia(_Ftnpx)
IMG_FinE2.Id = "5f96dfbb-84ca-42e0-b92b-52b4499a1b77"
IMG_FinE2.Name = _yhK5("l\v@\a,")
IMG_FinE2.Description = ""
IMG_FinE2.AltText = ""
IMG_FinE2.Resources = {
  {
    Type = "jpg",
    Filename = "FinE2.jpg",
    Directives = {}
  }
}
IMG_FinE3 = Wherigo.ZMedia(_Ftnpx)
IMG_FinE3.Id = "969b5174-606a-4858-b615-59b4fd978d19"
IMG_FinE3.Name = _yhK5("l\v@\aj")
IMG_FinE3.Description = ""
IMG_FinE3.AltText = ""
IMG_FinE3.Resources = {
  {
    Type = "jpg",
    Filename = "FinE3.jpg",
    Directives = {}
  }
}
IMG_Haar1 = Wherigo.ZMedia(_Ftnpx)
IMG_Haar1.Id = "7d258b8e-629d-4a4c-8e0c-91939e74fdbe"
IMG_Haar1.Name = _yhK5("sFFW\"")
IMG_Haar1.Description = ""
IMG_Haar1.AltText = ""
IMG_Haar1.Resources = {
  {
    Type = "jpg",
    Filename = "Haar1.jpg",
    Directives = {}
  }
}
IMG_FinD6 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD6.Id = "6d5b8973-12cd-4fa0-a4ab-312c0e4e9c25"
IMG_FinD6.Name = _yhK5("l\v@)%")
IMG_FinD6.Description = ""
IMG_FinD6.AltText = ""
IMG_FinD6.Resources = {
  {
    Type = "jpg",
    Filename = "FinD6.jpg",
    Directives = {}
  }
}
IMG_Haar2 = Wherigo.ZMedia(_Ftnpx)
IMG_Haar2.Id = "ca8453c7-8eca-427d-a54b-4ce030b8de41"
IMG_Haar2.Name = _yhK5("sFFW,")
IMG_Haar2.Description = ""
IMG_Haar2.AltText = ""
IMG_Haar2.Resources = {
  {
    Type = "jpg",
    Filename = "Haar2.jpg",
    Directives = {}
  }
}
IMG_FinD4b = Wherigo.ZMedia(_Ftnpx)
IMG_FinD4b.Id = "edf43d0e-9e95-4f77-881d-7ae4e817f891"
IMG_FinD4b.Name = _yhK5("l\v@)\025/")
IMG_FinD4b.Description = ""
IMG_FinD4b.AltText = ""
IMG_FinD4b.Resources = {
  {
    Type = "jpg",
    Filename = "FinD4b.jpg",
    Directives = {}
  }
}
IMG_FinD4c = Wherigo.ZMedia(_Ftnpx)
IMG_FinD4c.Id = "7b2a1dd0-d4df-4bb9-bf31-396ed14cb0ba"
IMG_FinD4c.Name = _yhK5("l\v@)\025\002")
IMG_FinD4c.Description = ""
IMG_FinD4c.AltText = ""
IMG_FinD4c.Resources = {
  {
    Type = "jpg",
    Filename = "finD4c.jpg",
    Directives = {}
  }
}
IMG_Parkplatz2 = Wherigo.ZMedia(_Ftnpx)
IMG_Parkplatz2.Id = "5efc01fe-d9cf-4079-8c62-3ee8d01f1a99"
IMG_Parkplatz2.Name = _yhK5("9FWRyxF`Y,")
IMG_Parkplatz2.Description = ""
IMG_Parkplatz2.AltText = ""
IMG_Parkplatz2.Resources = {
  {
    Type = "jpg",
    Filename = "parkplatz2.jpg",
    Directives = {}
  }
}
IMG_Mumie1 = Wherigo.ZMedia(_Ftnpx)
IMG_Mumie1.Id = "c8610163-bb05-47ca-bb23-c59be4874291"
IMG_Mumie1.Name = _yhK5("o\bi\vI\"")
IMG_Mumie1.Description = ""
IMG_Mumie1.AltText = ""
IMG_Mumie1.Resources = {
  {
    Type = "jpg",
    Filename = "Mumie1.jpg",
    Directives = {}
  }
}
IMG_Mumie2 = Wherigo.ZMedia(_Ftnpx)
IMG_Mumie2.Id = "c57fc28e-903e-43f9-9e76-ebb642e76448"
IMG_Mumie2.Name = _yhK5("o\bi\vI,")
IMG_Mumie2.Description = ""
IMG_Mumie2.AltText = ""
IMG_Mumie2.Resources = {
  {
    Type = "jpg",
    Filename = "Mumie2.jpg",
    Directives = {}
  }
}
IMG_Mumie3 = Wherigo.ZMedia(_Ftnpx)
IMG_Mumie3.Id = "91e6fc0d-2dff-4e4e-96f5-c5620c4b6e5b"
IMG_Mumie3.Name = _yhK5("o\bi\vIj")
IMG_Mumie3.Description = ""
IMG_Mumie3.AltText = ""
IMG_Mumie3.Resources = {
  {
    Type = "jpg",
    Filename = "Mumie3.jpg",
    Directives = {}
  }
}
IMG_Mumie4 = Wherigo.ZMedia(_Ftnpx)
IMG_Mumie4.Id = "f154a286-c731-4954-84b1-e51a3f52c703"
IMG_Mumie4.Name = _yhK5("o\bi\vI\025")
IMG_Mumie4.Description = ""
IMG_Mumie4.AltText = ""
IMG_Mumie4.Resources = {
  {
    Type = "jpg",
    Filename = "Mumie4.jpg",
    Directives = {}
  }
}
IMG_Emilio0 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio0.Id = "fedfd2a5-31d6-47d2-b60f-345de22b0835"
IMG_Emilio0.Name = _yhK5("\ai\vx\v}z")
IMG_Emilio0.Description = ""
IMG_Emilio0.AltText = ""
IMG_Emilio0.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio0.jpg",
    Directives = {}
  }
}
IMG_Emilio1 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio1.Id = "1eb5bd7d-2193-4783-b088-2b20b831983e"
IMG_Emilio1.Name = _yhK5("\ai\vx\v}\"")
IMG_Emilio1.Description = ""
IMG_Emilio1.AltText = ""
IMG_Emilio1.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio1.jpg",
    Directives = {}
  }
}
IMG_Emilio2 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio2.Id = "005d9516-3cda-4339-8916-261c04cf1a89"
IMG_Emilio2.Name = _yhK5("\ai\vx\v},")
IMG_Emilio2.Description = ""
IMG_Emilio2.AltText = ""
IMG_Emilio2.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio2.jpg",
    Directives = {}
  }
}
IMG_Emilio3 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio3.Id = "62a38295-c39c-450b-93b8-9295b8f040db"
IMG_Emilio3.Name = _yhK5("\ai\vx\v}j")
IMG_Emilio3.Description = ""
IMG_Emilio3.AltText = ""
IMG_Emilio3.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio3.jpg",
    Directives = {}
  }
}
IMG_Emilio4 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio4.Id = "c44c7b10-decf-47ab-b20b-a85c4dc24320"
IMG_Emilio4.Name = _yhK5("\ai\vx\v}\025")
IMG_Emilio4.Description = ""
IMG_Emilio4.AltText = ""
IMG_Emilio4.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio4.jpg",
    Directives = {}
  }
}
IMG_Emilio5 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio5.Id = "b2d09891-8332-4412-8aeb-6331d9de4c1b"
IMG_Emilio5.Name = _yhK5("\ai\vx\v}-")
IMG_Emilio5.Description = ""
IMG_Emilio5.AltText = ""
IMG_Emilio5.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio5.jpg",
    Directives = {}
  }
}
IMG_Emilio6 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio6.Id = "9ed0bb14-a854-4a12-9c0e-9eef24a93c25"
IMG_Emilio6.Name = _yhK5("\ai\vx\v}%")
IMG_Emilio6.Description = ""
IMG_Emilio6.AltText = ""
IMG_Emilio6.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio6.jpg",
    Directives = {}
  }
}
IMG_Emilio7 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio7.Id = "fa53f07e-fb1b-4319-b184-478ff6dd93a7"
IMG_Emilio7.Name = _yhK5("\ai\vx\v}.")
IMG_Emilio7.Description = ""
IMG_Emilio7.AltText = ""
IMG_Emilio7.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio7.jpg",
    Directives = {}
  }
}
IMG_Emilio8 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio8.Id = "104e9ece-b666-49c5-8d52-c1f87c8f8c31"
IMG_Emilio8.Name = _yhK5("\ai\vx\v}0")
IMG_Emilio8.Description = ""
IMG_Emilio8.AltText = ""
IMG_Emilio8.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio8.jpg",
    Directives = {}
  }
}
IMG_Emilio9 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio9.Id = "949bfd56-c611-4225-859e-259ad3a07677"
IMG_Emilio9.Name = _yhK5("\ai\vx\v}\015")
IMG_Emilio9.Description = ""
IMG_Emilio9.AltText = ""
IMG_Emilio9.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio9.jpg",
    Directives = {}
  }
}
IMG_Emilio10 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio10.Id = "ec96571f-f900-437a-ade3-fe2c577f9bc8"
IMG_Emilio10.Name = _yhK5("\ai\vx\v}\"z")
IMG_Emilio10.Description = ""
IMG_Emilio10.AltText = ""
IMG_Emilio10.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio10.jpg",
    Directives = {}
  }
}
IMG_Tisch = Wherigo.ZMedia(_Ftnpx)
IMG_Tisch.Id = "fed100fb-f4fc-4bcb-bc11-5fdcdf47cdf9"
IMG_Tisch.Name = _yhK5("\022\v+\002J")
IMG_Tisch.Description = ""
IMG_Tisch.AltText = ""
IMG_Tisch.Resources = {
  {
    Type = "jpg",
    Filename = "Tisch.jpg",
    Directives = {}
  }
}
IMG_Emilio11 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio11.Id = "ce67ec53-5d7a-4fd2-99cd-1d8cc32287f3"
IMG_Emilio11.Name = _yhK5("\ai\vx\v}\"\"")
IMG_Emilio11.Description = ""
IMG_Emilio11.AltText = ""
IMG_Emilio11.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio11.jpg",
    Directives = {}
  }
}
IMG_Emilio12 = Wherigo.ZMedia(_Ftnpx)
IMG_Emilio12.Id = "d28b7243-c347-4e57-93ca-aebe7c425edf"
IMG_Emilio12.Name = _yhK5("\ai\vx\v}\",")
IMG_Emilio12.Description = ""
IMG_Emilio12.AltText = ""
IMG_Emilio12.Resources = {
  {
    Type = "jpg",
    Filename = "Emilio12.jpg",
    Directives = {}
  }
}
IMG_Xfern = Wherigo.ZMedia(_Ftnpx)
IMG_Xfern.Id = "2691f617-c03f-480c-bda1-1adb80321878"
IMG_Xfern.Name = _yhK5("\026\tIW@")
IMG_Xfern.Description = ""
IMG_Xfern.AltText = ""
IMG_Xfern.Resources = {
  {
    Type = "jpg",
    Filename = "xfern.jpg",
    Directives = {}
  }
}
IMG_XNah = Wherigo.ZMedia(_Ftnpx)
IMG_XNah.Id = "79d9faa7-3de2-4b2e-a787-143d10f6d9e2"
IMG_XNah.Name = _yhK5("38FJ")
IMG_XNah.Description = ""
IMG_XNah.AltText = ""
IMG_XNah.Resources = {
  {
    Type = "jpg",
    Filename = "xnah.jpg",
    Directives = {}
  }
}
IMG_XNah0 = Wherigo.ZMedia(_Ftnpx)
IMG_XNah0.Id = "85e6b084-2243-4a28-a081-259989d04a39"
IMG_XNah0.Name = _yhK5("\0268FJz")
IMG_XNah0.Description = ""
IMG_XNah0.AltText = ""
IMG_XNah0.Resources = {
  {
    Type = "jpg",
    Filename = "xnah0.jpg",
    Directives = {}
  }
}
IMG_SpinneR1 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneR1.Id = "e0f75ab4-96b4-40dc-bc37-719db44caeb9"
IMG_SpinneR1.Name = _yhK5("\003y\v@@I\\\"")
IMG_SpinneR1.Description = ""
IMG_SpinneR1.AltText = ""
IMG_SpinneR1.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneR1.jpg",
    Directives = {}
  }
}
IMG_SpinneS1 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneS1.Id = "1aaeba52-dae5-47f0-acb6-fbfab814c625"
IMG_SpinneS1.Name = _yhK5("\003y\v@@I\003\"")
IMG_SpinneS1.Description = ""
IMG_SpinneS1.AltText = ""
IMG_SpinneS1.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneS1.jpg",
    Directives = {}
  }
}
IMG_SpinneR2 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneR2.Id = "e4ce8c05-c5de-4c5d-af3c-c3d7804258da"
IMG_SpinneR2.Name = _yhK5("\003y\v@@I\\,")
IMG_SpinneR2.Description = ""
IMG_SpinneR2.AltText = ""
IMG_SpinneR2.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneR2.jpg",
    Directives = {}
  }
}
IMG_SpinneS2 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneS2.Id = "41636942-d9b0-4dcb-b81d-bcefe02e80e9"
IMG_SpinneS2.Name = _yhK5("\003y\v@@I\003,")
IMG_SpinneS2.Description = ""
IMG_SpinneS2.AltText = ""
IMG_SpinneS2.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneS2.jpg",
    Directives = {}
  }
}
IMG_SpinneR3 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneR3.Id = "290210ac-9099-4242-89fb-b2832945bb86"
IMG_SpinneR3.Name = _yhK5("\003y\v@@I\\j")
IMG_SpinneR3.Description = ""
IMG_SpinneR3.AltText = ""
IMG_SpinneR3.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneR3.jpg",
    Directives = {}
  }
}
IMG_SpinneS3 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneS3.Id = "92c17d2d-5285-40a0-b3f9-3df4a0b565e1"
IMG_SpinneS3.Name = _yhK5("\003y\v@@I\003j")
IMG_SpinneS3.Description = ""
IMG_SpinneS3.AltText = ""
IMG_SpinneS3.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneS3.jpg",
    Directives = {}
  }
}
IMG_SpinneR4 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneR4.Id = "166c75d7-a875-41f3-9f57-3b4a9b585979"
IMG_SpinneR4.Name = _yhK5("\003y\v@@I\\\025")
IMG_SpinneR4.Description = ""
IMG_SpinneR4.AltText = ""
IMG_SpinneR4.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneR4.jpg",
    Directives = {}
  }
}
IMG_SpinneS4 = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneS4.Id = "0e061592-32f1-472e-b699-9696f5e5dae7"
IMG_SpinneS4.Name = _yhK5("\003y\v@@I\003\025")
IMG_SpinneS4.Description = ""
IMG_SpinneS4.AltText = ""
IMG_SpinneS4.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneS4.jpg",
    Directives = {}
  }
}
IMG_Naturschutzgebiet = Wherigo.ZMedia(_Ftnpx)
IMG_Naturschutzgebiet.Id = "40320493-723d-40ae-94bd-6745d3445e3e"
IMG_Naturschutzgebiet.Name = _yhK5("8F`\bW+\002J\b`YDI/\vI`")
IMG_Naturschutzgebiet.Description = ""
IMG_Naturschutzgebiet.AltText = ""
IMG_Naturschutzgebiet.Resources = {
  {
    Type = "jpg",
    Filename = "Naturschutzgebiet.jpg",
    Directives = {}
  }
}
IMG_Ba1K = Wherigo.ZMedia(_Ftnpx)
IMG_Ba1K.Id = "dee53897-e24c-46d6-a031-5de7880fa128"
IMG_Ba1K.Name = _yhK5("\014F\"\127")
IMG_Ba1K.Description = ""
IMG_Ba1K.AltText = ""
IMG_Ba1K.Resources = {
  {
    Type = "jpg",
    Filename = "Ba1K.jpg",
    Directives = {}
  }
}
IMG_IcoTool = Wherigo.ZMedia(_Ftnpx)
IMG_IcoTool.Id = "cfc3f07b-44a3-4c5b-a703-6e9f293afe20"
IMG_IcoTool.Name = _yhK5("#\002}\022}}x")
IMG_IcoTool.Description = ""
IMG_IcoTool.AltText = ""
IMG_IcoTool.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Tool.png",
    Directives = {}
  }
}
IMG_IcoPirat = Wherigo.ZMedia(_Ftnpx)
IMG_IcoPirat.Id = "cc779d20-229e-4a6c-ad93-bcec10ea1932"
IMG_IcoPirat.Name = _yhK5("#\002}9\vWF`")
IMG_IcoPirat.Description = ""
IMG_IcoPirat.AltText = ""
IMG_IcoPirat.Resources = {
  {
    Type = "png",
    Filename = "IcoPirat.png",
    Directives = {}
  }
}
IMG_IcoKuerbis = Wherigo.ZMedia(_Ftnpx)
IMG_IcoKuerbis.Id = "bd99d6ab-74c3-4128-a03b-9c252a2434e1"
IMG_IcoKuerbis.Name = _yhK5("#\002}\127\bIW/\v+")
IMG_IcoKuerbis.Description = ""
IMG_IcoKuerbis.AltText = ""
IMG_IcoKuerbis.Resources = {
  {
    Type = "png",
    Filename = "IcoKuerbis.png",
    Directives = {}
  }
}
IMG_Ora5 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora5.Id = "d629feab-d143-411c-a68c-49b64b606663"
IMG_Ora5.Name = _yhK5("?WF-")
IMG_Ora5.Description = ""
IMG_Ora5.AltText = ""
IMG_Ora5.Resources = {
  {
    Type = "jpg",
    Filename = "Ora5.jpg",
    Directives = {}
  }
}
IMG_IcoCodeCard = Wherigo.ZMedia(_Ftnpx)
IMG_IcoCodeCard.Id = "2715f27e-471b-44d7-83b5-6d85f099e591"
IMG_IcoCodeCard.Name = _yhK5("#\002}\001}1I\001FW1")
IMG_IcoCodeCard.Description = ""
IMG_IcoCodeCard.AltText = ""
IMG_IcoCodeCard.Resources = {
  {
    Type = "png",
    Filename = "Ico32-puzzle.png",
    Directives = {}
  }
}
IMG_CoCaFledermaus = Wherigo.ZMedia(_Ftnpx)
IMG_CoCaFledermaus.Id = "937e21b3-8fac-49ac-b780-7840ea45c6d8"
IMG_CoCaFledermaus.Name = _yhK5("\001}\001FlxI1IWiF\b+")
IMG_CoCaFledermaus.Description = ""
IMG_CoCaFledermaus.AltText = ""
IMG_CoCaFledermaus.Resources = {
  {
    Type = "jpg",
    Filename = "CoCaFledermaus.jpg",
    Directives = {}
  }
}
IMG_CoCaPiraten = Wherigo.ZMedia(_Ftnpx)
IMG_CoCaPiraten.Id = "e6351c46-5319-49bc-92c2-7457a9c1ee1a"
IMG_CoCaPiraten.Name = _yhK5("\001}\001F9\vWF`I@")
IMG_CoCaPiraten.Description = ""
IMG_CoCaPiraten.AltText = ""
IMG_CoCaPiraten.Resources = {
  {
    Type = "jpg",
    Filename = "CoCaPiraten.jpg",
    Directives = {}
  }
}
IMG_CoCaSpinne = Wherigo.ZMedia(_Ftnpx)
IMG_CoCaSpinne.Id = "557f009e-7830-4e0d-b971-59ea0fe6324a"
IMG_CoCaSpinne.Name = _yhK5("\001}\001F\003y\v@@I")
IMG_CoCaSpinne.Description = ""
IMG_CoCaSpinne.AltText = ""
IMG_CoCaSpinne.Resources = {
  {
    Type = "jpg",
    Filename = "CoCaSpinne.jpg",
    Directives = {}
  }
}
IMG_CoCaEmilio = Wherigo.ZMedia(_Ftnpx)
IMG_CoCaEmilio.Id = "eb589ea6-4a14-4451-a6c6-6092caa22a9c"
IMG_CoCaEmilio.Name = _yhK5("\001}\001F\ai\vx\v}")
IMG_CoCaEmilio.Description = ""
IMG_CoCaEmilio.AltText = ""
IMG_CoCaEmilio.Resources = {
  {
    Type = "jpg",
    Filename = "CoCaEmilio.jpg",
    Directives = {}
  }
}
IMG_CoCaBib = Wherigo.ZMedia(_Ftnpx)
IMG_CoCaBib.Id = "1203439a-c352-437b-bbe2-ac0832d41a8a"
IMG_CoCaBib.Name = _yhK5("\001}\001F\014\v/")
IMG_CoCaBib.Description = ""
IMG_CoCaBib.AltText = ""
IMG_CoCaBib.Resources = {
  {
    Type = "jpg",
    Filename = "CoCaBib.jpg",
    Directives = {}
  }
}
IMG_FinD7 = Wherigo.ZMedia(_Ftnpx)
IMG_FinD7.Id = "dd1517d5-7651-4d04-bab6-417e0517c519"
IMG_FinD7.Name = _yhK5("l\v@).")
IMG_FinD7.Description = ""
IMG_FinD7.AltText = ""
IMG_FinD7.Resources = {
  {
    Type = "jpg",
    Filename = "FinD7.jpg",
    Directives = {}
  }
}
IMG_IcoBib = Wherigo.ZMedia(_Ftnpx)
IMG_IcoBib.Id = "b45ce6c1-f3df-4d5a-b6d5-d3ba0eb857b8"
IMG_IcoBib.Name = _yhK5("#\002}\014\v/")
IMG_IcoBib.Description = ""
IMG_IcoBib.AltText = ""
IMG_IcoBib.Resources = {
  {
    Type = "png",
    Filename = "IcoBib.png",
    Directives = {}
  }
}
IMG_IcoFM = Wherigo.ZMedia(_Ftnpx)
IMG_IcoFM.Id = "67834660-70cd-4d89-8014-a19132193664"
IMG_IcoFM.Name = _yhK5("#\002}lo")
IMG_IcoFM.Description = ""
IMG_IcoFM.AltText = ""
IMG_IcoFM.Resources = {
  {
    Type = "png",
    Filename = "IcoFM.png",
    Directives = {}
  }
}
IMG_IcoEmilio = Wherigo.ZMedia(_Ftnpx)
IMG_IcoEmilio.Id = "f55aa1e6-a484-4ec2-b54e-c44f68ae5a1b"
IMG_IcoEmilio.Name = _yhK5("#\002}\ai\vx\v}")
IMG_IcoEmilio.Description = ""
IMG_IcoEmilio.AltText = ""
IMG_IcoEmilio.Resources = {
  {
    Type = "png",
    Filename = "IcoEmilio.png",
    Directives = {}
  }
}
IMG_IcoMumie = Wherigo.ZMedia(_Ftnpx)
IMG_IcoMumie.Id = "c33806e1-37cb-4100-b4e5-55b581dd8f25"
IMG_IcoMumie.Name = _yhK5("#\002}o\bi\vI")
IMG_IcoMumie.Description = ""
IMG_IcoMumie.AltText = ""
IMG_IcoMumie.Resources = {
  {
    Type = "png",
    Filename = "IcoMumie.png",
    Directives = {}
  }
}
IMG_IcoSkel = Wherigo.ZMedia(_Ftnpx)
IMG_IcoSkel.Id = "7de6ea21-59d7-4a07-89b9-056f1dbbd207"
IMG_IcoSkel.Name = _yhK5("#\002}\003RIx")
IMG_IcoSkel.Description = ""
IMG_IcoSkel.AltText = ""
IMG_IcoSkel.Resources = {
  {
    Type = "png",
    Filename = "IcoSkel.png",
    Directives = {}
  }
}
IMG_IcoHuhn = Wherigo.ZMedia(_Ftnpx)
IMG_IcoHuhn.Id = "1ff1fde1-1c0b-4799-b832-ac6c438591a1"
IMG_IcoHuhn.Name = _yhK5("#\002}s\bJ@")
IMG_IcoHuhn.Description = ""
IMG_IcoHuhn.AltText = ""
IMG_IcoHuhn.Resources = {
  {
    Type = "png",
    Filename = "IcoHuhn.png",
    Directives = {}
  }
}
IMG_IcoSpinne = Wherigo.ZMedia(_Ftnpx)
IMG_IcoSpinne.Id = "8608d246-27d4-433f-9b25-1195ea2ecf93"
IMG_IcoSpinne.Name = _yhK5("#\002}\003y\v@@I")
IMG_IcoSpinne.Description = ""
IMG_IcoSpinne.AltText = ""
IMG_IcoSpinne.Resources = {
  {
    Type = "png",
    Filename = "IcoSpinne.png",
    Directives = {}
  }
}
IMG_WeihMaus0 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus0.Id = "5f9c0f6b-df8a-49d1-9032-bab3a36e009a"
IMG_WeihMaus0.Name = _yhK5("mI\vJoF\b+z")
IMG_WeihMaus0.Description = ""
IMG_WeihMaus0.AltText = ""
IMG_WeihMaus0.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus0.jpg",
    Directives = {}
  }
}
IMG_IcoWeihMaus = Wherigo.ZMedia(_Ftnpx)
IMG_IcoWeihMaus.Id = "63a75924-7b0e-4270-94af-0ebc2ccae7ac"
IMG_IcoWeihMaus.Name = _yhK5("#\002}mI\vJoF\b+")
IMG_IcoWeihMaus.Description = ""
IMG_IcoWeihMaus.AltText = ""
IMG_IcoWeihMaus.Resources = {
  {
    Type = "png",
    Filename = "IcoWeihMaus.png",
    Directives = {}
  }
}
IMG_SpinneR1a = Wherigo.ZMedia(_Ftnpx)
IMG_SpinneR1a.Id = "05afe11e-0c68-4c17-8d1b-85c828ba4f41"
IMG_SpinneR1a.Name = _yhK5("\003y\v@@I\\\"F")
IMG_SpinneR1a.Description = ""
IMG_SpinneR1a.AltText = ""
IMG_SpinneR1a.Resources = {
  {
    Type = "jpg",
    Filename = "SpinneR1a.jpg",
    Directives = {}
  }
}
IMG_FinE4 = Wherigo.ZMedia(_Ftnpx)
IMG_FinE4.Id = "76f6d184-fb07-47cd-b250-91202862f5ef"
IMG_FinE4.Name = _yhK5("l\v@\a\025")
IMG_FinE4.Description = ""
IMG_FinE4.AltText = ""
IMG_FinE4.Resources = {
  {
    Type = "jpg",
    Filename = "FinE4.jpg",
    Directives = {}
  }
}
IMG_FinE5 = Wherigo.ZMedia(_Ftnpx)
IMG_FinE5.Id = "5343eff2-bf9d-4ccf-acdf-25481cc8c6c9"
IMG_FinE5.Name = _yhK5("l\v@\a-")
IMG_FinE5.Description = ""
IMG_FinE5.AltText = ""
IMG_FinE5.Resources = {
  {
    Type = "jpg",
    Filename = "FinE5.jpg",
    Directives = {}
  }
}
IMG_Ora6 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora6.Id = "57b30dfb-87e3-4c1e-b645-a741f0e0be2a"
IMG_Ora6.Name = _yhK5("?WF%")
IMG_Ora6.Description = ""
IMG_Ora6.AltText = ""
IMG_Ora6.Resources = {
  {
    Type = "jpg",
    Filename = "Ora6.jpg",
    Directives = {}
  }
}
IMG_Ora7 = Wherigo.ZMedia(_Ftnpx)
IMG_Ora7.Id = "f72ff7d7-88e9-4204-a67f-b318b22c4edf"
IMG_Ora7.Name = _yhK5("?WF.")
IMG_Ora7.Description = ""
IMG_Ora7.AltText = ""
IMG_Ora7.Resources = {
  {
    Type = "jpg",
    Filename = "Ora7.jpg",
    Directives = {}
  }
}
IMG_WeihMaus1 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus1.Id = "3df8e701-8c57-4ba0-b1b4-7b6b0caae942"
IMG_WeihMaus1.Name = _yhK5("mI\vJoF\b+\"")
IMG_WeihMaus1.Description = ""
IMG_WeihMaus1.AltText = ""
IMG_WeihMaus1.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus1.jpg",
    Directives = {}
  }
}
IMG_WeihMaus2 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus2.Id = "3802fe6b-5ce2-46ae-ac1a-3ca701b4033b"
IMG_WeihMaus2.Name = _yhK5("mI\vJoF\b+,")
IMG_WeihMaus2.Description = ""
IMG_WeihMaus2.AltText = ""
IMG_WeihMaus2.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus2.jpg",
    Directives = {}
  }
}
IMG_WeihMaus3 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus3.Id = "595e57ea-49d0-4c98-a732-a3a348d86955"
IMG_WeihMaus3.Name = _yhK5("mI\vJoF\b+j")
IMG_WeihMaus3.Description = ""
IMG_WeihMaus3.AltText = ""
IMG_WeihMaus3.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus3.jpg",
    Directives = {}
  }
}
IMG_WeihMaus4 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus4.Id = "16e1966d-85d5-448d-8e91-1afdf1846a99"
IMG_WeihMaus4.Name = _yhK5("mI\vJoF\b+\025")
IMG_WeihMaus4.Description = ""
IMG_WeihMaus4.AltText = ""
IMG_WeihMaus4.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus4.jpg",
    Directives = {}
  }
}
IMG_WeihMaus5 = Wherigo.ZMedia(_Ftnpx)
IMG_WeihMaus5.Id = "9099b9d1-c780-4de0-982a-5a42fe787fd5"
IMG_WeihMaus5.Name = _yhK5("mI\vJoF\b+-")
IMG_WeihMaus5.Description = ""
IMG_WeihMaus5.AltText = ""
IMG_WeihMaus5.Resources = {
  {
    Type = "jpg",
    Filename = "WeihMaus5.jpg",
    Directives = {}
  }
}
IMG_Geschenk0 = Wherigo.ZMedia(_Ftnpx)
IMG_Geschenk0.Id = "8d1f83da-0dc9-4b8d-801e-dfc214403dba"
IMG_Geschenk0.Name = _yhK5("\028I+\002JI@Rz")
IMG_Geschenk0.Description = ""
IMG_Geschenk0.AltText = ""
IMG_Geschenk0.Resources = {
  {
    Type = "jpg",
    Filename = "Geschenk0.jpg",
    Directives = {}
  }
}
IMG_IcoGeschenk = Wherigo.ZMedia(_Ftnpx)
IMG_IcoGeschenk.Id = "79f244c0-1333-4427-b6ab-414bad2f80a6"
IMG_IcoGeschenk.Name = _yhK5("#\002}\028I+\002JI@R")
IMG_IcoGeschenk.Description = ""
IMG_IcoGeschenk.AltText = ""
IMG_IcoGeschenk.Resources = {
  {
    Type = "png",
    Filename = "Ico32-Present.png",
    Directives = {}
  }
}
IMG_Geschenk1 = Wherigo.ZMedia(_Ftnpx)
IMG_Geschenk1.Id = "850d0a7e-ea92-4c1e-b7c3-e54928c6d371"
IMG_Geschenk1.Name = _yhK5("\028I+\002JI@R\"")
IMG_Geschenk1.Description = ""
IMG_Geschenk1.AltText = ""
IMG_Geschenk1.Resources = {
  {
    Type = "jpg",
    Filename = "Geschenk1.jpg",
    Directives = {}
  }
}
IMG_Geschenk2 = Wherigo.ZMedia(_Ftnpx)
IMG_Geschenk2.Id = "12a02193-a428-4183-a248-4428da65f252"
IMG_Geschenk2.Name = _yhK5("\028I+\002JI@R,")
IMG_Geschenk2.Description = ""
IMG_Geschenk2.AltText = ""
IMG_Geschenk2.Resources = {
  {
    Type = "jpg",
    Filename = "Geschenk2.jpg",
    Directives = {}
  }
}
IMG_Geschenk3 = Wherigo.ZMedia(_Ftnpx)
IMG_Geschenk3.Id = "68ec3386-e6b4-463b-a715-fee80c64b572"
IMG_Geschenk3.Name = _yhK5("\028I+\002JI@Rj")
IMG_Geschenk3.Description = ""
IMG_Geschenk3.AltText = ""
IMG_Geschenk3.Resources = {
  {
    Type = "jpg",
    Filename = "Geschenk3.jpg",
    Directives = {}
  }
}
IMG_Weih01 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih01.Id = "6dfacdb9-ef69-4a2f-aa8b-3a2e28c86450"
IMG_Weih01.Name = _yhK5("mI\vJz\"")
IMG_Weih01.Description = ""
IMG_Weih01.AltText = ""
IMG_Weih01.Resources = {
  {
    Type = "jpg",
    Filename = "Weih01.jpg",
    Directives = {}
  }
}
IMG_Weih02 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih02.Id = "a7e86583-f811-43b8-865d-a0ae1a83f8c4"
IMG_Weih02.Name = _yhK5("mI\vJz,")
IMG_Weih02.Description = ""
IMG_Weih02.AltText = ""
IMG_Weih02.Resources = {
  {
    Type = "jpg",
    Filename = "Weih02.jpg",
    Directives = {}
  }
}
IMG_Weih03 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih03.Id = "545b71b5-8595-4f5c-bca5-3a3d8466bc6b"
IMG_Weih03.Name = _yhK5("mI\vJzj")
IMG_Weih03.Description = ""
IMG_Weih03.AltText = ""
IMG_Weih03.Resources = {
  {
    Type = "jpg",
    Filename = "Weih03.jpg",
    Directives = {}
  }
}
IMG_Weih04 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih04.Id = "feab0b44-14d6-4b32-81d9-c34f32e91088"
IMG_Weih04.Name = _yhK5("mI\vJz\025")
IMG_Weih04.Description = ""
IMG_Weih04.AltText = ""
IMG_Weih04.Resources = {
  {
    Type = "jpg",
    Filename = "Weih04.jpg",
    Directives = {}
  }
}
IMG_Weih05 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih05.Id = "fc5b14ba-af7a-409d-9db8-38616f85a771"
IMG_Weih05.Name = _yhK5("mI\vJz-")
IMG_Weih05.Description = ""
IMG_Weih05.AltText = ""
IMG_Weih05.Resources = {
  {
    Type = "jpg",
    Filename = "Weih05.jpg",
    Directives = {}
  }
}
IMG_Weih06 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih06.Id = "661a164e-4819-499b-b22e-43657374a85c"
IMG_Weih06.Name = _yhK5("mI\vJz%")
IMG_Weih06.Description = ""
IMG_Weih06.AltText = ""
IMG_Weih06.Resources = {
  {
    Type = "jpg",
    Filename = "Weih06.jpg",
    Directives = {}
  }
}
IMG_Weih07 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih07.Id = "c48e1b7f-ac62-416c-9a75-f4fa10061cb3"
IMG_Weih07.Name = _yhK5("mI\vJz.")
IMG_Weih07.Description = ""
IMG_Weih07.AltText = ""
IMG_Weih07.Resources = {
  {
    Type = "png",
    Filename = "Weih07.png",
    Directives = {}
  }
}
IMG_Weih08 = Wherigo.ZMedia(_Ftnpx)
IMG_Weih08.Id = "59521bd3-26f3-4874-97b0-d9cc1fd8961b"
IMG_Weih08.Name = _yhK5("mI\vJz0")
IMG_Weih08.Description = ""
IMG_Weih08.AltText = ""
IMG_Weih08.Resources = {
  {
    Type = "jpg",
    Filename = "Weih08.jpg",
    Directives = {}
  }
}
IMG_IcoWeihKa = Wherigo.ZMedia(_Ftnpx)
IMG_IcoWeihKa.Id = "c39bf0b8-3f08-4a3d-ad41-f0cfcf7365b9"
IMG_IcoWeihKa.Name = _yhK5("#\002}mI\vJ\127F")
IMG_IcoWeihKa.Description = ""
IMG_IcoWeihKa.AltText = ""
IMG_IcoWeihKa.Resources = {
  {
    Type = "png",
    Filename = "Ico32-envelope.png",
    Directives = {}
  }
}
IMG_EinsiedelA01 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelA01.Id = "d41b9533-9564-4aa2-8ed3-a095f3672f1b"
IMG_EinsiedelA01.Name = _yhK5("\a\v@+\vI1Ix\027z\"")
IMG_EinsiedelA01.Description = ""
IMG_EinsiedelA01.AltText = ""
IMG_EinsiedelA01.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelA01.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB01 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB01.Id = "1443a489-f1bb-450e-a6bb-a5e9ef16abf0"
IMG_EinsiedelB01.Name = _yhK5("\a\v@+\vI1Ix\014z\"")
IMG_EinsiedelB01.Description = ""
IMG_EinsiedelB01.AltText = ""
IMG_EinsiedelB01.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB01.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB02 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB02.Id = "859e575e-00ef-4844-a6d4-dce43217196e"
IMG_EinsiedelB02.Name = _yhK5("\a\v@+\vI1Ix\014z,")
IMG_EinsiedelB02.Description = ""
IMG_EinsiedelB02.AltText = ""
IMG_EinsiedelB02.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB02.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB03 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB03.Id = "4ec714b6-0788-427b-baed-54c7c01c1e02"
IMG_EinsiedelB03.Name = _yhK5("\a\v@+\vI1Ix\014zj")
IMG_EinsiedelB03.Description = ""
IMG_EinsiedelB03.AltText = ""
IMG_EinsiedelB03.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB03.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB04 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB04.Id = "75ff1934-3c26-4322-bfbb-db79078aee48"
IMG_EinsiedelB04.Name = _yhK5("\a\v@+\vI1Ix\014z\025")
IMG_EinsiedelB04.Description = ""
IMG_EinsiedelB04.AltText = ""
IMG_EinsiedelB04.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB04.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB05 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB05.Id = "42ca312e-6b66-43d8-b47a-66362e454aee"
IMG_EinsiedelB05.Name = _yhK5("\a\v@+\vI1Ix\014z-")
IMG_EinsiedelB05.Description = ""
IMG_EinsiedelB05.AltText = ""
IMG_EinsiedelB05.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB05.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB06 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB06.Id = "3caf67a6-d5bf-48a7-9b6d-87793c260327"
IMG_EinsiedelB06.Name = _yhK5("\a\v@+\vI1Ix\014z%")
IMG_EinsiedelB06.Description = ""
IMG_EinsiedelB06.AltText = ""
IMG_EinsiedelB06.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB06.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB07 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB07.Id = "054ce7e3-0ba1-44cd-9595-b808d8c9a478"
IMG_EinsiedelB07.Name = _yhK5("\a\v@+\vI1Ix\014z.")
IMG_EinsiedelB07.Description = ""
IMG_EinsiedelB07.AltText = ""
IMG_EinsiedelB07.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB07.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB08 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB08.Id = "0949b523-5c3a-41ca-bfdc-492674ed92e5"
IMG_EinsiedelB08.Name = _yhK5("\a\v@+\vI1Ix\014z0")
IMG_EinsiedelB08.Description = ""
IMG_EinsiedelB08.AltText = ""
IMG_EinsiedelB08.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB08.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB09 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB09.Id = "247bde10-fe0a-4218-aa9a-f780185235b3"
IMG_EinsiedelB09.Name = _yhK5("\a\v@+\vI1Ix\014z\015")
IMG_EinsiedelB09.Description = ""
IMG_EinsiedelB09.AltText = ""
IMG_EinsiedelB09.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB09.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB10 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB10.Id = "4327d32e-e08c-4bc7-a581-2d3f6822a055"
IMG_EinsiedelB10.Name = _yhK5("\a\v@+\vI1Ix\014\"z")
IMG_EinsiedelB10.Description = ""
IMG_EinsiedelB10.AltText = ""
IMG_EinsiedelB10.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB10.jpg",
    Directives = {}
  }
}
IMG_EinsiedelB11 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelB11.Id = "48407e99-05fe-4484-a13a-076ad353c931"
IMG_EinsiedelB11.Name = _yhK5("\a\v@+\vI1Ix\014\"\"")
IMG_EinsiedelB11.Description = ""
IMG_EinsiedelB11.AltText = ""
IMG_EinsiedelB11.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelB11.jpg",
    Directives = {}
  }
}
IMG_IcoLicht = Wherigo.ZMedia(_Ftnpx)
IMG_IcoLicht.Id = "888d45de-e94d-4445-8c7d-5872c589bbb4"
IMG_IcoLicht.Name = _yhK5("#\002}]\v\002J`")
IMG_IcoLicht.Description = ""
IMG_IcoLicht.AltText = ""
IMG_IcoLicht.Resources = {
  {
    Type = "png",
    Filename = "IcoLicht.png",
    Directives = {}
  }
}
IMG_EinsiedelA02 = Wherigo.ZMedia(_Ftnpx)
IMG_EinsiedelA02.Id = "9ff07d7f-8f6c-4f14-bc92-07414890f6eb"
IMG_EinsiedelA02.Name = _yhK5("\a\v@+\vI1Ix\027z,")
IMG_EinsiedelA02.Description = ""
IMG_EinsiedelA02.AltText = ""
IMG_EinsiedelA02.Resources = {
  {
    Type = "jpg",
    Filename = "EinsiedelA02.jpg",
    Directives = {}
  }
}
IMG_IcoGeist = Wherigo.ZMedia(_Ftnpx)
IMG_IcoGeist.Id = "71b1d63b-5cb6-4c4d-9edd-77733070c5d5"
IMG_IcoGeist.Name = _yhK5("#\002}\028I\v+`")
IMG_IcoGeist.Description = ""
IMG_IcoGeist.AltText = ""
IMG_IcoGeist.Resources = {
  {
    Type = "png",
    Filename = "IcoGeist.png",
    Directives = {}
  }
}
_Ftnpx.Id = "2a7fea00-dbb4-461e-aa99-5ac224b9b866"
_Ftnpx.Name = "Piraebe 2 - Der Feuerball"
_Ftnpx.Description = [[
Den Raeben kennst Du ja schon aus dem ersten Teil. Wenn nicht, dann fang lieber damit an, denn es handelt sich hier um die direkte Fortsetzung der Geschichte und es macht wenig Sinn, mitten in der Mitte zu starten.<BR>
<BR>
Und wie mag es nun weitergehen? Ach ja, da waren ja noch diese Dokumente, die die Piraten haben wollten ...]]
_Ftnpx.Visible = true
_Ftnpx.Activity = "Fiction"
_Ftnpx.StartingLocationDescription = ""
_Ftnpx.StartingLocation = ZonePoint(50.9558, 11.638483, 0)
_Ftnpx.Version = "1.6"
_Ftnpx.Company = ""
_Ftnpx.Author = "J.T."
_Ftnpx.BuilderVersion = "URWIGO 1.22.5798.37755"
_Ftnpx.CreateDate = "06/01/2014 16:33:15"
_Ftnpx.PublishDate = "1/1/0001 12:00:00 AM"
_Ftnpx.UpdateDate = "02/16/2020 16:46:28"
_Ftnpx.LastPlayedDate = "1/1/0001 12:00:00 AM"
_Ftnpx.TargetDevice = "PocketPC"
_Ftnpx.TargetDeviceVersion = "0"
_Ftnpx.StateId = "1"
_Ftnpx.CountryId = "2"
_Ftnpx.Complete = false
_Ftnpx.UseLogging = true
_Ftnpx.Media = IMG_Cover
_Ftnpx.Icon = IMG_IcoCartridge
Z_Kunitz = Wherigo.Zone(_Ftnpx)
Z_Kunitz.Id = "69a667b1-1fa3-4161-b3c2-c9eaf7b866b8"
Z_Kunitz.Name = _yhK5("\127\b@\v`Y")
Z_Kunitz.Description = _yhK5(")F+(\v+`(1\vI(\003`IxxI:(F@(1IW(1IW(\\FI/I(F\b\t()\v\002J(PFW`I`h")
Z_Kunitz.Visible = true
Z_Kunitz.Media = IMG_Kunitz1
Z_Kunitz.Commands = {}
Z_Kunitz.DistanceRange = Distance(-1, "feet")
Z_Kunitz.ShowObjects = "OnEnter"
Z_Kunitz.ProximityRange = Distance(60, "meters")
Z_Kunitz.AllowSetPositionTo = false
Z_Kunitz.Active = true
Z_Kunitz.Points = {
  ZonePoint(50.9559050485882, 11.638501807375, 0),
  ZonePoint(50.9558451249066, 11.6385971009731, 0),
  ZonePoint(50.9557581117272, 11.6384562849998, 0),
  ZonePoint(50.9558383666072, 11.638303399086, 0)
}
Z_Kunitz.OriginalPoint = ZonePoint(50.9558366629573, 11.6384646481085, 0)
Z_Kunitz.DistanceRangeUOM = "Feet"
Z_Kunitz.ProximityRangeUOM = "Meters"
Z_Kunitz.OutOfRangeName = ""
Z_Kunitz.InRangeName = ""
Z_Bergauf10 = Wherigo.Zone(_Ftnpx)
Z_Bergauf10.Id = "2cb6c6eb-beb8-48d9-9ab7-015cc8568228"
Z_Bergauf10.Name = _yhK5("\014IWDF\b\t(A\"\017")
Z_Bergauf10.Description = _yhK5("#WDI@1P}(YP\v+\002JI@(\b@`I@(\b@1(}/I@:(FxxIW1\v@D+(\viiIW(@}\002J(1I\b`x\v\002J(iIJW(\b@`I@(Fx+(}/I@h")
Z_Bergauf10.Visible = true
Z_Bergauf10.Media = IMG_Ba1Zone
Z_Bergauf10.Commands = {}
Z_Bergauf10.DistanceRange = Distance(-1, "feet")
Z_Bergauf10.ShowObjects = "OnEnter"
Z_Bergauf10.ProximityRange = Distance(60, "meters")
Z_Bergauf10.AllowSetPositionTo = false
Z_Bergauf10.Active = false
Z_Bergauf10.Points = {
  ZonePoint(50.9573594074918, 11.6413239067459, 0),
  ZonePoint(50.9570531551261, 11.6411975026131, 0),
  ZonePoint(50.9570396388778, 11.641363799572, 0),
  ZonePoint(50.9573437535139, 11.6414925456047, 0)
}
Z_Bergauf10.OriginalPoint = ZonePoint(50.9571989887524, 11.6413444386339, 0)
Z_Bergauf10.DistanceRangeUOM = "Feet"
Z_Bergauf10.ProximityRangeUOM = "Meters"
Z_Bergauf10.OutOfRangeName = ""
Z_Bergauf10.InRangeName = ""
Z_Bergauf20 = Wherigo.Zone(_Ftnpx)
Z_Bergauf20.Id = "eed2589c-bc85-4676-91e0-2a879f20be50"
Z_Bergauf20.Name = _yhK5("\014IWDF\b\t(A,\017")
Z_Bergauf20.Description = _yhK5("s}IJIW(Fx+(DIWF1I(I/I@:(F/IW(\viiIW(@}\002J(1I\b`x\v\002J(Y\b(PI\v`(\b@`I@h")
Z_Bergauf20.Visible = true
Z_Bergauf20.Media = IMG_Ba2Zone
Z_Bergauf20.Commands = {}
Z_Bergauf20.DistanceRange = Distance(-1, "feet")
Z_Bergauf20.ShowObjects = "OnEnter"
Z_Bergauf20.ProximityRange = Distance(60, "meters")
Z_Bergauf20.AllowSetPositionTo = false
Z_Bergauf20.Active = false
Z_Bergauf20.Points = {
  ZonePoint(50.9572576047222, 11.644356587696, 0),
  ZonePoint(50.9571976091172, 11.6444832072745, 0),
  ZonePoint(50.9572613879179, 11.644549592439, 0),
  ZonePoint(50.9573184118737, 11.6444402922373, 0)
}
Z_Bergauf20.OriginalPoint = ZonePoint(50.9572587534078, 11.6444574199117, 0)
Z_Bergauf20.DistanceRangeUOM = "Feet"
Z_Bergauf20.ProximityRangeUOM = "Meters"
Z_Bergauf20.OutOfRangeName = ""
Z_Bergauf20.InRangeName = ""
Z_Bergauf30 = Wherigo.Zone(_Ftnpx)
Z_Bergauf30.Id = "6149657b-e59d-4832-8902-516eb7afabe6"
Z_Bergauf30.Name = _yhK5("\014IWDF\b\t(Aj\017")
Z_Bergauf30.Description = _yhK5(")\vI(sFIx\t`I(1I+(\027\b\t+`\vID+(+}xx`I(J\vIW(\b@DI\tFIJW(DI+\002JF\t\t`(+I\v@h(m\vW1(LF(F\b\002J([I\v`h")
Z_Bergauf30.Visible = true
Z_Bergauf30.Media = IMG_Ba3Zone
Z_Bergauf30.Commands = {}
Z_Bergauf30.DistanceRange = Distance(-1, "feet")
Z_Bergauf30.ShowObjects = "OnEnter"
Z_Bergauf30.ProximityRange = Distance(60, "meters")
Z_Bergauf30.AllowSetPositionTo = false
Z_Bergauf30.Active = false
Z_Bergauf30.Points = {
  ZonePoint(50.9602050897264, 11.6453698434512, 0),
  ZonePoint(50.9602788577519, 11.6453617078684, 0),
  ZonePoint(50.9602746366339, 11.6455292068791, 0),
  ZonePoint(50.9602000224055, 11.6455088732048, 0)
}
Z_Bergauf30.OriginalPoint = ZonePoint(50.9602396516294, 11.6454424078509, 0)
Z_Bergauf30.DistanceRangeUOM = "Feet"
Z_Bergauf30.ProximityRangeUOM = "Meters"
Z_Bergauf30.OutOfRangeName = ""
Z_Bergauf30.InRangeName = ""
Z_Bergauf40 = Wherigo.Zone(_Ftnpx)
Z_Bergauf40.Id = "da97b3c2-485c-42bc-b8d2-d99002be3efb"
Z_Bergauf40.Name = _yhK5("\014IWDF\b\t(A\025\017")
Z_Bergauf40.Description = _yhK5("\003\v@1(P\vW(/Fx1(1FS( F:(LF:(@\bW(@}\002J(\bi(1\vI(\127\bWwI(\b@1(\bI/IW(1I@(s\bIDIx(\b@1(hhh")
Z_Bergauf40.Visible = true
Z_Bergauf40.Media = IMG_Ba4Zo
Z_Bergauf40.Commands = {}
Z_Bergauf40.DistanceRange = Distance(-1, "feet")
Z_Bergauf40.ShowObjects = "OnEnter"
Z_Bergauf40.ProximityRange = Distance(60, "meters")
Z_Bergauf40.AllowSetPositionTo = false
Z_Bergauf40.Active = false
Z_Bergauf40.Points = {
  ZonePoint(50.9592560743026, 11.6462672883606, 0),
  ZonePoint(50.9592613194054, 11.646054983139, 0),
  ZonePoint(50.959477568567, 11.6461086273193, 0),
  ZonePoint(50.9594708107959, 11.6462856531143, 0)
}
Z_Bergauf40.OriginalPoint = ZonePoint(50.9593664432677, 11.6461791379833, 0)
Z_Bergauf40.DistanceRangeUOM = "Feet"
Z_Bergauf40.ProximityRangeUOM = "Meters"
Z_Bergauf40.OutOfRangeName = ""
Z_Bergauf40.InRangeName = ""
Z_Bergauf60 = Wherigo.Zone(_Ftnpx)
Z_Bergauf60.Id = "c145e4ef-fe37-4e05-a8e8-eefe083a5b8b"
Z_Bergauf60.Name = _yhK5("\014IWDF\b\t(A%\017")
Z_Bergauf60.Description = _yhK5("]F@D+Fi(R}iiI@(P\vW(1IW(\014\bWD(1}\002J(`F`+FI\002Jx\v\002J(@FIJIWh")
Z_Bergauf60.Visible = true
Z_Bergauf60.Media = IMG_Ba6A
Z_Bergauf60.Commands = {}
Z_Bergauf60.DistanceRange = Distance(-1, "feet")
Z_Bergauf60.ShowObjects = "OnEnter"
Z_Bergauf60.ProximityRange = Distance(60, "meters")
Z_Bergauf60.AllowSetPositionTo = false
Z_Bergauf60.Active = false
Z_Bergauf60.Points = {
  ZonePoint(50.9581590570759, 11.6473083534465, 0),
  ZonePoint(50.9582915646951, 11.6473209857941, 0),
  ZonePoint(50.9582413024664, 11.6471238434315, 0)
}
Z_Bergauf60.OriginalPoint = ZonePoint(50.9582306414125, 11.6472510608907, 0)
Z_Bergauf60.DistanceRangeUOM = "Feet"
Z_Bergauf60.ProximityRangeUOM = "Meters"
Z_Bergauf60.OutOfRangeName = ""
Z_Bergauf60.InRangeName = ""
Z_Tisch = Wherigo.Zone(_Ftnpx)
Z_Tisch.Id = "c29c916d-4813-43ea-8c98-176c56bc4dc7"
Z_Tisch.Name = _yhK5("\022\v+\002J")
Z_Tisch.Description = _yhK5(")\vWIR`(@I/I@(1IW(9UWFi\v1I(+`IJ`(I\v@(\022\v+\002J(i\v`(I\v@(yFFW(\014FI@RI@(1W\bi(JIW\bih")
Z_Tisch.Visible = true
Z_Tisch.Media = IMG_Tisch
Z_Tisch.Commands = {}
Z_Tisch.DistanceRange = Distance(-1, "feet")
Z_Tisch.ShowObjects = "OnEnter"
Z_Tisch.ProximityRange = Distance(60, "meters")
Z_Tisch.AllowSetPositionTo = false
Z_Tisch.Active = false
Z_Tisch.Points = {
  ZonePoint(50.9605900903344, 11.6487059638758, 0),
  ZonePoint(50.9605190693647, 11.6486847221404, 0),
  ZonePoint(50.9605122316728, 11.6488043745431, 0),
  ZonePoint(50.9605806776229, 11.648812348878, 0)
}
Z_Tisch.OriginalPoint = ZonePoint(50.9605505172487, 11.6487518523593, 0)
Z_Tisch.DistanceRangeUOM = "Feet"
Z_Tisch.ProximityRangeUOM = "Meters"
Z_Tisch.OutOfRangeName = ""
Z_Tisch.InRangeName = ""
Z_Innenhof = Wherigo.Zone(_Ftnpx)
Z_Innenhof.Id = "4c8bf03b-772c-4878-8033-38d42161e3a6"
Z_Innenhof.Name = _yhK5("#@@I@J}\t")
Z_Innenhof.Description = _yhK5("lW\bIJIW(PFW(J\vIW(iFx(1F+(#@@IWI(1IW(\014\bWDh(sI\b`I(\v+`(\bI/IWFxx(Z1WF\b++I@Zh")
Z_Innenhof.Visible = true
Z_Innenhof.Media = IMG_Burg
Z_Innenhof.Commands = {}
Z_Innenhof.DistanceRange = Distance(-1, "feet")
Z_Innenhof.ShowObjects = "OnEnter"
Z_Innenhof.ProximityRange = Distance(60, "meters")
Z_Innenhof.AllowSetPositionTo = false
Z_Innenhof.Active = false
Z_Innenhof.Points = {
  ZonePoint(50.9608987687467, 11.6479073287682, 0),
  ZonePoint(50.9609306551373, 11.6478095557142, 0),
  ZonePoint(50.9608668846924, 11.6476913474828, 0),
  ZonePoint(50.9608082186919, 11.6477411017036, 0)
}
Z_Innenhof.OriginalPoint = ZonePoint(50.9608761318171, 11.6477873334172, 0)
Z_Innenhof.DistanceRangeUOM = "Feet"
Z_Innenhof.ProximityRangeUOM = "Meters"
Z_Innenhof.OutOfRangeName = ""
Z_Innenhof.InRangeName = ""
Z_Nekramora = Wherigo.Zone(_Ftnpx)
Z_Nekramora.Id = "33b3b0eb-bf02-4126-a0fa-87fd0ee1702c"
Z_Nekramora.Name = _yhK5("8IRWFi}WF+(]FDIW")
Z_Nekramora.Description = _yhK5(")F+(]FDIW(1IW(iU+`IW\v}I+I@(8IRWFi}WFh(s\vIWJIW(\v+`(1\vI(lxI1IWiF\b+(DI\tx}DI@h({\vIxxI\v\002J`(\v+`(+\vI(\viiIW(@}\002J(J\vIW(\vWDI@1P}h")
Z_Nekramora.Visible = true
Z_Nekramora.Media = IMG_Nekra1
Z_Nekramora.Commands = {}
Z_Nekramora.DistanceRange = Distance(-1, "feet")
Z_Nekramora.ShowObjects = "OnEnter"
Z_Nekramora.ProximityRange = Distance(60, "meters")
Z_Nekramora.AllowSetPositionTo = false
Z_Nekramora.Active = false
Z_Nekramora.Points = {
  ZonePoint(50.9607906201213, 11.6482153592245, 0),
  ZonePoint(50.9607422837279, 11.6482550696055, 0),
  ZonePoint(50.9607875010831, 11.6482978610311, 0),
  ZonePoint(50.960824724428, 11.6482603621162, 0)
}
Z_Nekramora.OriginalPoint = ZonePoint(50.9607862823401, 11.6482571629943, 0)
Z_Nekramora.DistanceRangeUOM = "Feet"
Z_Nekramora.ProximityRangeUOM = "Meters"
Z_Nekramora.OutOfRangeName = ""
Z_Nekramora.InRangeName = ""
Z_Local_FMaus = Wherigo.Zone(_Ftnpx)
Z_Local_FMaus.Id = "22ebbf1a-eca3-4674-af96-1fffe483d5bd"
Z_Local_FMaus.Name = _yhK5("lxI1IWiF\b+")
Z_Local_FMaus.Description = _yhK5("s\vIW(JFI@D`(1\vI(lxI1IWiF\b+(DIWF1I(W\bih")
Z_Local_FMaus.Visible = false
Z_Local_FMaus.Media = IMG_Fledermaus0
Z_Local_FMaus.Commands = {}
Z_Local_FMaus.DistanceRange = Distance(-1, "feet")
Z_Local_FMaus.ShowObjects = "OnEnter"
Z_Local_FMaus.ProximityRange = Distance(60, "meters")
Z_Local_FMaus.AllowSetPositionTo = false
Z_Local_FMaus.Active = false
Z_Local_FMaus.Points = {
  ZonePoint(50.9608670200563, 11.6481733596784, 0),
  ZonePoint(50.9607840361144, 11.6481056339008, 0),
  ZonePoint(50.9607643101051, 11.6481773352331, 0),
  ZonePoint(50.9608482481258, 11.6482375113281, 0)
}
Z_Local_FMaus.OriginalPoint = ZonePoint(50.9608159036004, 11.6481734600351, 0)
Z_Local_FMaus.DistanceRangeUOM = "Feet"
Z_Local_FMaus.ProximityRangeUOM = "Meters"
Z_Local_FMaus.OutOfRangeName = ""
Z_Local_FMaus.InRangeName = ""
Z_Parkplatz = Wherigo.Zone(_Ftnpx)
Z_Parkplatz.Id = "4b69bc76-6fb1-42e8-bdc5-8b31305fc52c"
Z_Parkplatz.Name = _yhK5("9FWRyxF`Y")
Z_Parkplatz.Description = _yhK5("mIW(F\b\t(w\vIW(\\FI1IW@(F@WI\v+`:(1IW(RF@@(+I\v@I(\014xI\002J1}+I(J\vIW(F/+`IxxI@h")
Z_Parkplatz.Visible = true
Z_Parkplatz.Media = IMG_Parkplatz
Z_Parkplatz.Commands = {}
Z_Parkplatz.DistanceRange = Distance(-1, "feet")
Z_Parkplatz.ShowObjects = "OnEnter"
Z_Parkplatz.ProximityRange = Distance(60, "meters")
Z_Parkplatz.AllowSetPositionTo = false
Z_Parkplatz.Active = true
Z_Parkplatz.Points = {
  ZonePoint(50.9541646737522, 11.6408452989257, 0),
  ZonePoint(50.9541312318198, 11.6407780549998, 0),
  ZonePoint(50.9540866425393, 11.6408913079277, 0),
  ZonePoint(50.9541245434305, 11.6409550126996, 0)
}
Z_Parkplatz.OriginalPoint = ZonePoint(50.9541267728855, 11.6408674186382, 0)
Z_Parkplatz.DistanceRangeUOM = "Feet"
Z_Parkplatz.ProximityRangeUOM = "Meters"
Z_Parkplatz.OutOfRangeName = ""
Z_Parkplatz.InRangeName = ""
Z_TrollPwd = Wherigo.Zone(_Ftnpx)
Z_TrollPwd.Id = "27dfdf2a-38ee-492a-9b0d-cfa4c46afc9e"
Z_TrollPwd.Name = _yhK5("9F++P}W`")
Z_TrollPwd.Description = _yhK5("s\vIW(JF/`(\vJW(1F+(9F++P}W`(DI\t\b@1I@:(i\v`(1Ii(\vJW(1I@(\022W}xx(DI+\002JW\biy\t`(JF/`h\020\014\\6)IW(\\FI/I(iI\v@`I(LF:(\vJW(P\bIW1I`(I+(JI\b`I(@}\002J(iFx(/WF\b\002JI@(\b@1(wIWi\b`x\v\002J(JF`(IW(1Fi\v`(WI\002J`h")
Z_TrollPwd.Visible = true
Z_TrollPwd.Media = IMG_Passwort
Z_TrollPwd.Commands = {}
Z_TrollPwd.DistanceRange = Distance(-1, "feet")
Z_TrollPwd.ShowObjects = "OnEnter"
Z_TrollPwd.ProximityRange = Distance(60, "meters")
Z_TrollPwd.AllowSetPositionTo = false
Z_TrollPwd.Active = true
Z_TrollPwd.Points = {
  ZonePoint(50.9506682894222, 11.6273619660282, 0),
  ZonePoint(50.9505770408831, 11.6273013569581, 0),
  ZonePoint(50.9505635224658, 11.6274254826675, 0),
  ZonePoint(50.9506573524624, 11.6274797807486, 0)
}
Z_TrollPwd.OriginalPoint = ZonePoint(50.9506165513084, 11.6273921466006, 0)
Z_TrollPwd.DistanceRangeUOM = "Feet"
Z_TrollPwd.ProximityRangeUOM = "Meters"
Z_TrollPwd.OutOfRangeName = ""
Z_TrollPwd.InRangeName = ""
Z_Lollistelle1 = Wherigo.Zone(_Ftnpx)
Z_Lollistelle1.Id = "32eb7528-1e01-4cc0-8003-5522c3214a4c"
Z_Lollistelle1.Name = _yhK5("]}xx\v+`IxxI(A\"\017")
Z_Lollistelle1.Description = _yhK5("s\vIW(\v+`(I\v@IW(1IW(]}xx\v+(DIxF@1I`h")
Z_Lollistelle1.Visible = false
Z_Lollistelle1.Media = IMG_Lolli3a
Z_Lollistelle1.Commands = {}
Z_Lollistelle1.DistanceRange = Distance(-1, "feet")
Z_Lollistelle1.ShowObjects = "OnEnter"
Z_Lollistelle1.ProximityRange = Distance(60, "meters")
Z_Lollistelle1.AllowSetPositionTo = false
Z_Lollistelle1.Active = false
Z_Lollistelle1.Points = {
  ZonePoint(50.95726, 11.6443380465349, 0),
  ZonePoint(50.9572214465529, 11.6442890660252, 0),
  ZonePoint(50.9573003283486, 11.6442914617594, 0)
}
Z_Lollistelle1.OriginalPoint = ZonePoint(50.9572605916338, 11.6443061914398, 0)
Z_Lollistelle1.DistanceRangeUOM = "Feet"
Z_Lollistelle1.ProximityRangeUOM = "Meters"
Z_Lollistelle1.OutOfRangeName = ""
Z_Lollistelle1.InRangeName = ""
Z_Lollistelle2 = Wherigo.Zone(_Ftnpx)
Z_Lollistelle2.Id = "58d847de-4cbc-4973-bef4-6dcbe8d2089c"
Z_Lollistelle2.Name = _yhK5("]}xx\v+`IxxI(A,\017")
Z_Lollistelle2.Description = _yhK5("s\vIW(\v+`(I\v@IW(1IW(]}xx\v+(DIxF@1I`h")
Z_Lollistelle2.Visible = false
Z_Lollistelle2.Media = IMG_Lolli2a
Z_Lollistelle2.Commands = {}
Z_Lollistelle2.DistanceRange = Distance(-1, "feet")
Z_Lollistelle2.ShowObjects = "OnEnter"
Z_Lollistelle2.ProximityRange = Distance(60, "meters")
Z_Lollistelle2.AllowSetPositionTo = false
Z_Lollistelle2.Active = false
Z_Lollistelle2.Points = {
  ZonePoint(50.9571836530999, 11.644457085147, 0),
  ZonePoint(50.9571055266586, 11.6444782116865, 0),
  ZonePoint(50.9571826890726, 11.6445801691802, 0)
}
Z_Lollistelle2.OriginalPoint = ZonePoint(50.9571572896104, 11.6445051553379, 0)
Z_Lollistelle2.DistanceRangeUOM = "Feet"
Z_Lollistelle2.ProximityRangeUOM = "Meters"
Z_Lollistelle2.OutOfRangeName = ""
Z_Lollistelle2.InRangeName = ""
Z_Lollistelle3 = Wherigo.Zone(_Ftnpx)
Z_Lollistelle3.Id = "16316fb2-5d42-46ab-93ec-3f8cb0025ea9"
Z_Lollistelle3.Name = _yhK5("]}xx\v+`IxxI(Aj\017")
Z_Lollistelle3.Description = _yhK5("s\vIW(\v+`(I\v@IW(1IW(]}xx\v+(DIxF@1I`h")
Z_Lollistelle3.Visible = false
Z_Lollistelle3.Media = IMG_Lolli1a
Z_Lollistelle3.Commands = {}
Z_Lollistelle3.DistanceRange = Distance(-1, "feet")
Z_Lollistelle3.ShowObjects = "OnEnter"
Z_Lollistelle3.ProximityRange = Distance(60, "meters")
Z_Lollistelle3.AllowSetPositionTo = false
Z_Lollistelle3.Active = false
Z_Lollistelle3.Points = {
  ZonePoint(50.9572991662365, 11.6444991545963, 0),
  ZonePoint(50.9572898862771, 11.6446735440747, 0),
  ZonePoint(50.957383548141, 11.6445143881589, 0)
}
Z_Lollistelle3.OriginalPoint = ZonePoint(50.9573242002182, 11.6445623622766, 0)
Z_Lollistelle3.DistanceRangeUOM = "Feet"
Z_Lollistelle3.ProximityRangeUOM = "Meters"
Z_Lollistelle3.OutOfRangeName = ""
Z_Lollistelle3.InRangeName = ""
Z_Holzzelt = Wherigo.Zone(_Ftnpx)
Z_Holzzelt.Id = "cd78899f-629d-4481-8b29-beff665a7d6a"
Z_Holzzelt.Name = _yhK5("s}xYYIx`")
Z_Holzzelt.Description = _yhK5(")\vI(\127}@+`W\bR`\v}@(+\vIJ`(DF@Y(FIJ@x\v\002J(F\b+(P\vI(1\vI:(\v@(1IW(1\vI(9\vWF`I@(PFWI@h(mIW(iFD(P}Jx(J\vIW(1W\v@(Y\b(\t\v@1I@(+I\v@S")
Z_Holzzelt.Visible = true
Z_Holzzelt.Media = IMG_Ba3BibZelt
Z_Holzzelt.Commands = {}
Z_Holzzelt.DistanceRange = Distance(-1, "feet")
Z_Holzzelt.ShowObjects = "OnEnter"
Z_Holzzelt.ProximityRange = Distance(60, "meters")
Z_Holzzelt.AllowSetPositionTo = false
Z_Holzzelt.Active = false
Z_Holzzelt.Points = {
  ZonePoint(50.9602988451673, 11.6455439555539, 0),
  ZonePoint(50.9601711092174, 11.6455525132286, 0),
  ZonePoint(50.960180709869, 11.6453173542454, 0),
  ZonePoint(50.9603047384809, 11.6453440114626, 0)
}
Z_Holzzelt.OriginalPoint = ZonePoint(50.9602388506837, 11.6454394586226, 0)
Z_Holzzelt.DistanceRangeUOM = "Feet"
Z_Holzzelt.ProximityRangeUOM = "Meters"
Z_Holzzelt.OutOfRangeName = ""
Z_Holzzelt.InRangeName = ""
Z_Local_Bib = Wherigo.Zone(_Ftnpx)
Z_Local_Bib.Id = "7aa5b26c-37a2-4392-bb5f-4c2e2c917b45"
Z_Local_Bib.Name = _yhK5("]}\002Fxb\014\v/")
Z_Local_Bib.Description = ""
Z_Local_Bib.Visible = false
Z_Local_Bib.Commands = {}
Z_Local_Bib.DistanceRange = Distance(-1, "feet")
Z_Local_Bib.ShowObjects = "OnEnter"
Z_Local_Bib.ProximityRange = Distance(60, "meters")
Z_Local_Bib.AllowSetPositionTo = false
Z_Local_Bib.Active = false
Z_Local_Bib.Points = {
  ZonePoint(50.9620375754707, 11.6383356492992, 0),
  ZonePoint(50.9618078259926, 11.6382283621668, 0),
  ZonePoint(50.9616997081981, 11.6389579146669, 0),
  ZonePoint(50.9619970315277, 11.6390222869463, 0)
}
Z_Local_Bib.OriginalPoint = ZonePoint(50.9618855352973, 11.6386360532698, 0)
Z_Local_Bib.DistanceRangeUOM = "Feet"
Z_Local_Bib.ProximityRangeUOM = "Meters"
Z_Local_Bib.OutOfRangeName = ""
Z_Local_Bib.InRangeName = ""
Z_Bergauf80 = Wherigo.Zone(_Ftnpx)
Z_Bergauf80.Id = "9688835d-8e31-4b9b-977a-4c88899dcb02"
Z_Bergauf80.Name = _yhK5("\014IWDF\b\t(A0\017")
Z_Bergauf80.Description = _yhK5("?/I@\n\n\n(\027x+}(\tF+`h")
Z_Bergauf80.Visible = true
Z_Bergauf80.Media = IMG_Ba8A
Z_Bergauf80.Commands = {}
Z_Bergauf80.DistanceRange = Distance(-1, "feet")
Z_Bergauf80.ShowObjects = "OnEnter"
Z_Bergauf80.ProximityRange = Distance(60, "meters")
Z_Bergauf80.AllowSetPositionTo = false
Z_Bergauf80.Active = false
Z_Bergauf80.Points = {
  ZonePoint(50.9603922872333, 11.6480641104507, 0),
  ZonePoint(50.9606466481684, 11.6475623846054, 0),
  ZonePoint(50.9606973301449, 11.647669672966, 0),
  ZonePoint(50.9604743290351, 11.6481202840805, 0)
}
Z_Bergauf80.OriginalPoint = ZonePoint(50.9605526486454, 11.6478541130256, 0)
Z_Bergauf80.DistanceRangeUOM = "Feet"
Z_Bergauf80.ProximityRangeUOM = "Meters"
Z_Bergauf80.OutOfRangeName = ""
Z_Bergauf80.InRangeName = ""
Z_Bergauf50 = Wherigo.Zone(_Ftnpx)
Z_Bergauf50.Id = "93c538e9-c5a8-4ba5-a7f0-a562ce7fa141"
Z_Bergauf50.Name = _yhK5("\014IWDF\b\t(A-\017")
Z_Bergauf50.Description = _yhK5("hhh(\b@1(\bi(1\vI(@FI\002J+`I(\127\bWwI(\b@1(\bI/IW(1I@(@FI\002J+`I@(s\bIDIx(hhh")
Z_Bergauf50.Visible = true
Z_Bergauf50.Media = IMG_Ba5A
Z_Bergauf50.Commands = {}
Z_Bergauf50.DistanceRange = Distance(-1, "feet")
Z_Bergauf50.ShowObjects = "OnEnter"
Z_Bergauf50.ProximityRange = Distance(60, "meters")
Z_Bergauf50.AllowSetPositionTo = false
Z_Bergauf50.Active = false
Z_Bergauf50.Points = {
  ZonePoint(50.9579469665556, 11.6476483877325, 0),
  ZonePoint(50.9580116336488, 11.6477307715156, 0),
  ZonePoint(50.9579368733931, 11.6477924623229, 0)
}
Z_Bergauf50.OriginalPoint = ZonePoint(50.9579651578658, 11.647723873857, 0)
Z_Bergauf50.DistanceRangeUOM = "Feet"
Z_Bergauf50.ProximityRangeUOM = "Meters"
Z_Bergauf50.OutOfRangeName = ""
Z_Bergauf50.InRangeName = ""
Z_Beeren1 = Wherigo.Zone(_Ftnpx)
Z_Beeren1.Id = "bb05dd33-6448-4caf-ac80-66e0a592d7fb"
Z_Beeren1.Name = _yhK5("\014IIWI@(A\"\017")
Z_Beeren1.Description = _yhK5("s\vIW(D\v/`(I+(\014IIWI@(\t\bIW(1I@(\\FI/I@h")
Z_Beeren1.Visible = false
Z_Beeren1.Media = IMG_Beeren
Z_Beeren1.Commands = {}
Z_Beeren1.DistanceRange = Distance(-1, "feet")
Z_Beeren1.ShowObjects = "OnEnter"
Z_Beeren1.ProximityRange = Distance(60, "meters")
Z_Beeren1.AllowSetPositionTo = false
Z_Beeren1.Active = false
Z_Beeren1.Points = {
  ZonePoint(50.9584204340905, 11.6471537901783, 0),
  ZonePoint(50.958522914546, 11.6470280327537, 0),
  ZonePoint(50.9585398093165, 11.6472131051757, 0)
}
Z_Beeren1.OriginalPoint = ZonePoint(50.9584943859843, 11.6471316427026, 0)
Z_Beeren1.DistanceRangeUOM = "Feet"
Z_Beeren1.ProximityRangeUOM = "Meters"
Z_Beeren1.OutOfRangeName = ""
Z_Beeren1.InRangeName = ""
Z_Beeren2 = Wherigo.Zone(_Ftnpx)
Z_Beeren2.Id = "124c1067-0fb5-48de-995d-a1c5ca0f70a3"
Z_Beeren2.Name = _yhK5("\014IIWI@(A,\017")
Z_Beeren2.Description = _yhK5("s\vIW(D\v/`(I+(\014IIWI@(\t\bIW(1I@(\\FI/I@h")
Z_Beeren2.Visible = false
Z_Beeren2.Media = IMG_Beeren
Z_Beeren2.Commands = {}
Z_Beeren2.DistanceRange = Distance(-1, "feet")
Z_Beeren2.ShowObjects = "OnEnter"
Z_Beeren2.ProximityRange = Distance(60, "meters")
Z_Beeren2.AllowSetPositionTo = false
Z_Beeren2.Active = false
Z_Beeren2.Points = {
  ZonePoint(50.9587929685273, 11.6470836736107, 0),
  ZonePoint(50.9589030453958, 11.6469462253787, 0),
  ZonePoint(50.9589089585178, 11.6471983530261, 0)
}
Z_Beeren2.OriginalPoint = ZonePoint(50.958868324147, 11.6470760840052, 0)
Z_Beeren2.DistanceRangeUOM = "Feet"
Z_Beeren2.ProximityRangeUOM = "Meters"
Z_Beeren2.OutOfRangeName = ""
Z_Beeren2.InRangeName = ""
Z_Orakel = Wherigo.Zone(_Ftnpx)
Z_Orakel.Id = "45eca054-d8b8-4a02-b6df-e117bde0e1b8"
Z_Orakel.Name = _yhK5("?WFRIx")
Z_Orakel.Description = _yhK5(")IW(\014F\bi(Fi(mIDI+WF@1(JF`(/IJF\by`I`:(J\vIW(DFI/I(I+(I\v@(?WFRIxh")
Z_Orakel.Visible = true
Z_Orakel.Media = IMG_Ora1
Z_Orakel.Commands = {}
Z_Orakel.DistanceRange = Distance(-1, "feet")
Z_Orakel.ShowObjects = "OnEnter"
Z_Orakel.ProximityRange = Distance(60, "meters")
Z_Orakel.AllowSetPositionTo = false
Z_Orakel.Active = false
Z_Orakel.Points = {
  ZonePoint(50.9596163424113, 11.6514565182423, 0),
  ZonePoint(50.9596989705345, 11.6516073554681, 0),
  ZonePoint(50.9595821124722, 11.6516784159811, 0)
}
Z_Orakel.OriginalPoint = ZonePoint(50.9596324751393, 11.6515807632305, 0)
Z_Orakel.DistanceRangeUOM = "Feet"
Z_Orakel.ProximityRangeUOM = "Meters"
Z_Orakel.OutOfRangeName = ""
Z_Orakel.InRangeName = ""
Z_Huegel = Wherigo.Zone(_Ftnpx)
Z_Huegel.Id = "c473d906-3780-4519-b9dd-fe58d81ecb0c"
Z_Huegel.Name = _yhK5("s\bIDIx")
Z_Huegel.Description = _yhK5("\a\v@I(\014F@R(F\b\t(I\v@Ii(s\bIDIxh")
Z_Huegel.Visible = true
Z_Huegel.Media = IMG_Huegel
Z_Huegel.Commands = {}
Z_Huegel.DistanceRange = Distance(-1, "feet")
Z_Huegel.ShowObjects = "OnEnter"
Z_Huegel.ProximityRange = Distance(60, "meters")
Z_Huegel.AllowSetPositionTo = false
Z_Huegel.Active = false
Z_Huegel.Points = {
  ZonePoint(50.9589695599496, 11.6439533000286, 0),
  ZonePoint(50.9590795599269, 11.6440568025265, 0),
  ZonePoint(50.959048689149, 11.6441784564149, 0),
  ZonePoint(50.9589383821065, 11.6440792189757, 0)
}
Z_Huegel.OriginalPoint = ZonePoint(50.959009047783, 11.6440669444864, 0)
Z_Huegel.DistanceRangeUOM = "Feet"
Z_Huegel.ProximityRangeUOM = "Meters"
Z_Huegel.OutOfRangeName = ""
Z_Huegel.InRangeName = ""
Z_Steinhaufen = Wherigo.Zone(_Ftnpx)
Z_Steinhaufen.Id = "2fccb8a5-4be3-4f22-b517-0e25860107bb"
Z_Steinhaufen.Name = _yhK5("\003`I\v@JF\b\tI@")
Z_Steinhaufen.Description = _yhK5("\027@(1\vI+IW(\003`IxxI(P}xxI@(P\vW(I+(@\b@(Y\b(\a@1I(/W\v@DI@:(+FD`I(Y\bi\v@1I+`(1\vI(lxI1IWiF\b+h")
Z_Steinhaufen.Visible = true
Z_Steinhaufen.Media = IMG_Steinhaufen1
Z_Steinhaufen.Commands = {}
Z_Steinhaufen.DistanceRange = Distance(-1, "feet")
Z_Steinhaufen.ShowObjects = "OnEnter"
Z_Steinhaufen.ProximityRange = Distance(60, "meters")
Z_Steinhaufen.AllowSetPositionTo = false
Z_Steinhaufen.Active = false
Z_Steinhaufen.Points = {
  ZonePoint(50.9607647602626, 11.6481880688142, 0),
  ZonePoint(50.9607873273116, 11.6481205628567, 0),
  ZonePoint(50.9608705068572, 11.6481885266707, 0),
  ZonePoint(50.9608522707195, 11.6482549088401, 0)
}
Z_Steinhaufen.OriginalPoint = ZonePoint(50.9608187162877, 11.6481880167954, 0)
Z_Steinhaufen.DistanceRangeUOM = "Feet"
Z_Steinhaufen.ProximityRangeUOM = "Meters"
Z_Steinhaufen.OutOfRangeName = ""
Z_Steinhaufen.InRangeName = ""
Z_Bergauf70 = Wherigo.Zone(_Ftnpx)
Z_Bergauf70.Id = "c9560fbf-edf8-477b-a2b9-8d59aa589c07"
Z_Bergauf70.Name = _yhK5("\014IWDF\b\t(A.\017")
Z_Bergauf70.Description = _yhK5(")\vI(xI`Y`I(\014F@R(w}W(Z}/I@Z(xFI1`(I\v@:(@}\002J(iFx(I\v@I(R\bWYI(9F\b+I(Y\b(iF\002JI@h")
Z_Bergauf70.Visible = true
Z_Bergauf70.Media = IMG_Ba7A
Z_Bergauf70.Commands = {}
Z_Bergauf70.DistanceRange = Distance(-1, "feet")
Z_Bergauf70.ShowObjects = "OnEnter"
Z_Bergauf70.ProximityRange = Distance(60, "meters")
Z_Bergauf70.AllowSetPositionTo = false
Z_Bergauf70.Active = false
Z_Bergauf70.Points = {
  ZonePoint(50.95991, 11.64656, 0),
  ZonePoint(50.9599945093728, 11.6466464723873, 0),
  ZonePoint(50.9599266211475, 11.6467311079693, 0)
}
Z_Bergauf70.OriginalPoint = ZonePoint(50.9599437101734, 11.6466458601189, 0)
Z_Bergauf70.DistanceRangeUOM = "Feet"
Z_Bergauf70.ProximityRangeUOM = "Meters"
Z_Bergauf70.OutOfRangeName = ""
Z_Bergauf70.InRangeName = ""
Z_Mitternacht = Wherigo.Zone(_Ftnpx)
Z_Mitternacht.Id = "bec6b469-478c-4c8f-97db-7c44af37ba14"
Z_Mitternacht.Name = _yhK5("o\v``IW@F\002J`")
Z_Mitternacht.Description = _yhK5("s\vIW(\v+`(I+(-(o\v@\b`I@(@F\002J(o\v``IW@F\002J`:(w\vIxxI\v\002J`(+}DFW(\t\bIW(\viiIWh")
Z_Mitternacht.Visible = true
Z_Mitternacht.Media = IMG_Mitternacht
Z_Mitternacht.Commands = {}
Z_Mitternacht.DistanceRange = Distance(-1, "feet")
Z_Mitternacht.ShowObjects = "OnEnter"
Z_Mitternacht.ProximityRange = Distance(60, "meters")
Z_Mitternacht.AllowSetPositionTo = false
Z_Mitternacht.Active = false
Z_Mitternacht.Points = {
  ZonePoint(50.9604068940916, 11.6487849564314, 0),
  ZonePoint(50.9603323963968, 11.6487330130674, 0),
  ZonePoint(50.9604110738225, 11.6489265298635, 0)
}
Z_Mitternacht.OriginalPoint = ZonePoint(50.9603834547703, 11.6488148331208, 0)
Z_Mitternacht.DistanceRangeUOM = "Feet"
Z_Mitternacht.ProximityRangeUOM = "Meters"
Z_Mitternacht.OutOfRangeName = ""
Z_Mitternacht.InRangeName = ""
Z_Wegweiser = Wherigo.Zone(_Ftnpx)
Z_Wegweiser.Id = "3d4b55f0-609f-483c-adfe-bd3e595613ea"
Z_Wegweiser.Name = _yhK5("mIDPI\v+IW")
Z_Wegweiser.Description = _yhK5("s\vIW(+`IJ`(I\v@(mIDPI\v+IW(\v@(1IW(\028IDI@1(JIW\bi:(1IW(mIDI(PI\v+`(\b@1(\022I3`I(wIW+\002Jx\bI++Ix`h")
Z_Wegweiser.Visible = true
Z_Wegweiser.Media = IMG_WegweiserZone
Z_Wegweiser.Commands = {}
Z_Wegweiser.DistanceRange = Distance(-1, "feet")
Z_Wegweiser.ShowObjects = "OnEnter"
Z_Wegweiser.ProximityRange = Distance(60, "meters")
Z_Wegweiser.AllowSetPositionTo = false
Z_Wegweiser.Active = false
Z_Wegweiser.Points = {
  ZonePoint(50.9595225830859, 11.6493808411484, 0),
  ZonePoint(50.959474754877, 11.6494342153903, 0),
  ZonePoint(50.9594970900014, 11.6494987060943, 0),
  ZonePoint(50.9595421690474, 11.6494417653913, 0)
}
Z_Wegweiser.OriginalPoint = ZonePoint(50.9595091492529, 11.6494388820061, 0)
Z_Wegweiser.DistanceRangeUOM = "Feet"
Z_Wegweiser.ProximityRangeUOM = "Meters"
Z_Wegweiser.OutOfRangeName = ""
Z_Wegweiser.InRangeName = ""
Z_Final = Wherigo.Zone(_Ftnpx)
Z_Final.Id = "4ed4ed67-d838-4572-b9dd-98d98b7388e7"
Z_Final.Name = _yhK5("\026")
Z_Final.Description = _yhK5(")F+(\026(iFWR\vIW`(1\vI(\003`IxxIh")
Z_Final.Visible = true
Z_Final.Media = IMG_Xfern
Z_Final.Commands = {}
Z_Final.DistanceRange = Distance(-1, "feet")
Z_Final.ShowObjects = "OnEnter"
Z_Final.ProximityRange = Distance(60, "meters")
Z_Final.AllowSetPositionTo = false
Z_Final.Active = false
Z_Final.Points = {
  ZonePoint(50.959941, 11.65359, 0),
  ZonePoint(50.959920298003, 11.6535929029972, 0),
  ZonePoint(50.959928745135, 11.6536177134305, 0)
}
Z_Final.OriginalPoint = ZonePoint(50.9599300143793, 11.6536002054759, 0)
Z_Final.DistanceRangeUOM = "Feet"
Z_Final.ProximityRangeUOM = "Meters"
Z_Final.OutOfRangeName = ""
Z_Final.InRangeName = ""
Z_FinalHint = Wherigo.Zone(_Ftnpx)
Z_FinalHint.Id = "ef6e0724-f38b-4b4b-997f-b8cccc99a3b3"
Z_FinalHint.Name = _yhK5("\026tiDI/\b@D")
Z_FinalHint.Description = ""
Z_FinalHint.Visible = false
Z_FinalHint.Commands = {}
Z_FinalHint.DistanceRange = Distance(-1, "feet")
Z_FinalHint.ShowObjects = "OnEnter"
Z_FinalHint.ProximityRange = Distance(60, "meters")
Z_FinalHint.AllowSetPositionTo = false
Z_FinalHint.Active = false
Z_FinalHint.Points = {
  ZonePoint(50.9599624585362, 11.6534223105823, 0),
  ZonePoint(50.9598283484561, 11.6535360612345, 0),
  ZonePoint(50.9598814303025, 11.6537733822292, 0),
  ZonePoint(50.9600103742152, 11.6536493273423, 0)
}
Z_FinalHint.OriginalPoint = ZonePoint(50.9599206528775, 11.6535952703471, 0)
Z_FinalHint.DistanceRangeUOM = "Feet"
Z_FinalHint.ProximityRangeUOM = "Meters"
Z_FinalHint.OutOfRangeName = ""
Z_FinalHint.InRangeName = ""
Z_Beeren3 = Wherigo.Zone(_Ftnpx)
Z_Beeren3.Id = "a142a821-e196-45a3-9e8a-f2756f9b41c4"
Z_Beeren3.Name = _yhK5("\014IIWI@(Aj\017")
Z_Beeren3.Description = _yhK5("s\vIW(D\v/`(I+(\014IIWI@(\t\bIW(1I@(\\FI/I@h")
Z_Beeren3.Visible = false
Z_Beeren3.Media = IMG_Beeren
Z_Beeren3.Commands = {}
Z_Beeren3.DistanceRange = Distance(-1, "feet")
Z_Beeren3.ShowObjects = "OnEnter"
Z_Beeren3.ProximityRange = Distance(60, "meters")
Z_Beeren3.AllowSetPositionTo = false
Z_Beeren3.Active = false
Z_Beeren3.Points = {
  ZonePoint(50.9581214462681, 11.6473701780826, 0),
  ZonePoint(50.9581636835477, 11.6475391572505, 0),
  ZonePoint(50.9580335926035, 11.6475150173694, 0)
}
Z_Beeren3.OriginalPoint = ZonePoint(50.9581062408064, 11.6474747842342, 0)
Z_Beeren3.DistanceRangeUOM = "Feet"
Z_Beeren3.ProximityRangeUOM = "Meters"
Z_Beeren3.OutOfRangeName = ""
Z_Beeren3.InRangeName = ""
Z_Parkplatz2 = Wherigo.Zone(_Ftnpx)
Z_Parkplatz2.Id = "eddd19fe-d12a-4e9c-ab8f-ce4ad4859213"
Z_Parkplatz2.Name = _yhK5("9FWRyxFI`Y\002JI@")
Z_Parkplatz2.Description = _yhK5("mIW(@\bW(F\b\t(,(\\FI1IW@(F@WI\v+`:(1IW(yFWR`(Fi(/I+`I@(J\vIWh")
Z_Parkplatz2.Visible = true
Z_Parkplatz2.Media = IMG_Parkplatz2
Z_Parkplatz2.Commands = {}
Z_Parkplatz2.DistanceRange = Distance(-1, "feet")
Z_Parkplatz2.ShowObjects = "OnEnter"
Z_Parkplatz2.ProximityRange = Distance(60, "meters")
Z_Parkplatz2.AllowSetPositionTo = false
Z_Parkplatz2.Active = true
Z_Parkplatz2.Points = {
  ZonePoint(50.955850874727, 11.6381029389517, 0),
  ZonePoint(50.9559222158507, 11.6379923388332, 0),
  ZonePoint(50.955790123215, 11.6379711036104, 0)
}
Z_Parkplatz2.OriginalPoint = ZonePoint(50.9558544045976, 11.6380221271318, 0)
Z_Parkplatz2.DistanceRangeUOM = "Feet"
Z_Parkplatz2.ProximityRangeUOM = "Meters"
Z_Parkplatz2.OutOfRangeName = ""
Z_Parkplatz2.InRangeName = ""
Z_Pyramide = Wherigo.Zone(_Ftnpx)
Z_Pyramide.Id = "6b7b00f6-03ff-438a-868b-8b3bd034e13a"
Z_Pyramide.Name = _yhK5("9UWFi\v1I")
Z_Pyramide.Description = _yhK5("\127xI\v@IW(Fx+(iF@(+\v\002J(9UWFi\v1I@(w}W+`Ixx`:(F/IW(F\b\002J(@FIJIWh")
Z_Pyramide.Visible = true
Z_Pyramide.Media = IMG_Py1
Z_Pyramide.Commands = {}
Z_Pyramide.DistanceRange = Distance(-1, "feet")
Z_Pyramide.ShowObjects = "OnEnter"
Z_Pyramide.ProximityRange = Distance(60, "meters")
Z_Pyramide.AllowSetPositionTo = false
Z_Pyramide.Active = false
Z_Pyramide.Points = {
  ZonePoint(50.9606639104105, 11.6487567055225, 0),
  ZonePoint(50.9605586840932, 11.6487043630424, 0),
  ZonePoint(50.9606088383597, 11.6489305341918, 0)
}
Z_Pyramide.OriginalPoint = ZonePoint(50.9606104776211, 11.6487972009189, 0)
Z_Pyramide.DistanceRangeUOM = "Feet"
Z_Pyramide.ProximityRangeUOM = "Meters"
Z_Pyramide.OutOfRangeName = ""
Z_Pyramide.InRangeName = ""
Z_Tafel = Wherigo.Zone(_Ftnpx)
Z_Tafel.Id = "11a76890-d284-47de-acc6-4825131f64f1"
Z_Tafel.Name = _yhK5("\022F\tIx")
Z_Tafel.Description = _yhK5("\a\v@I(DIJI\vi@\v+w}xxI(\022F\tIx:(i\v``I@(\vi(mFx1h")
Z_Tafel.Visible = true
Z_Tafel.Media = IMG_EinsiedelA02
Z_Tafel.Commands = {}
Z_Tafel.DistanceRange = Distance(-1, "feet")
Z_Tafel.ShowObjects = "OnEnter"
Z_Tafel.ProximityRange = Distance(60, "meters")
Z_Tafel.AllowSetPositionTo = false
Z_Tafel.Active = false
Z_Tafel.Points = {
  ZonePoint(50.9604746969238, 11.6509520797796, 0),
  ZonePoint(50.9603356330549, 11.6509096086465, 0),
  ZonePoint(50.9603210165562, 11.6510986519135, 0),
  ZonePoint(50.960460594593, 11.6511325886311, 0)
}
Z_Tafel.OriginalPoint = ZonePoint(50.960397985282, 11.6510232322427, 0)
Z_Tafel.DistanceRangeUOM = "Feet"
Z_Tafel.ProximityRangeUOM = "Meters"
Z_Tafel.OutOfRangeName = ""
Z_Tafel.InRangeName = ""
Z_Einsiedelei = Wherigo.Zone(_Ftnpx)
Z_Einsiedelei.Id = "983e2a3f-5062-45b8-9b76-86e5821b00a6"
Z_Einsiedelei.Name = _yhK5("\a\v@+\vI1IxI\v")
Z_Einsiedelei.Description = ""
Z_Einsiedelei.Visible = true
Z_Einsiedelei.Media = IMG_EinsiedelB01
Z_Einsiedelei.Commands = {}
Z_Einsiedelei.DistanceRange = Distance(-1, "feet")
Z_Einsiedelei.ShowObjects = "OnEnter"
Z_Einsiedelei.ProximityRange = Distance(60, "meters")
Z_Einsiedelei.AllowSetPositionTo = false
Z_Einsiedelei.Active = false
Z_Einsiedelei.Points = {
  ZonePoint(50.9602201504022, 11.6516511872291, 0),
  ZonePoint(50.9602114537619, 11.6514180443281, 0),
  ZonePoint(50.9603546787712, 11.651414949226, 0),
  ZonePoint(50.960365232695, 11.6516582431541, 0)
}
Z_Einsiedelei.OriginalPoint = ZonePoint(50.9602878789076, 11.6515356059843, 0)
Z_Einsiedelei.DistanceRangeUOM = "Feet"
Z_Einsiedelei.ProximityRangeUOM = "Meters"
Z_Einsiedelei.OutOfRangeName = ""
Z_Einsiedelei.InRangeName = ""
P_Raebe = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Kunitz})
P_Raebe.Id = "d3be9600-3105-44af-a0a6-afa85f34d4ab"
P_Raebe.Name = _yhK5("\\FI/I")
P_Raebe.Description = _yhK5(")IW(\\FI/I:(sIx1(1\vI+I+(\003y\vIx+(\b@1(F@DIJI@1IW(9\vWF`h")
P_Raebe.Visible = true
P_Raebe.Media = IMG_Raebe01
P_Raebe.Icon = IMG_IcoRaebe
P_Raebe.Commands = {
  _PoKq = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _YWV = Wherigo.ZCommand({
    Text = _yhK5("l}`}DWF\t\vIWI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _uctcs = Wherigo.ZCommand({
    Text = _yhK5("\027\b\tPI\002RI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Raebe.Commands._PoKq.Custom = true
P_Raebe.Commands._PoKq.Id = "f01bccd0-e24d-42ac-b108-80c978369f41"
P_Raebe.Commands._PoKq.WorksWithAll = true
P_Raebe.Commands._YWV.Custom = true
P_Raebe.Commands._YWV.Id = "eb6cc70a-a487-4bbd-81e3-dfbc4b462ef5"
P_Raebe.Commands._YWV.WorksWithAll = true
P_Raebe.Commands._uctcs.Custom = true
P_Raebe.Commands._uctcs.Id = "4aea620b-0f43-4cfa-9715-956942a38a99"
P_Raebe.Commands._uctcs.WorksWithAll = true
P_Raebe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Raebe.Gender = "Male"
P_Raebe.Type = "NPC"
P_Troellchen = Wherigo.ZCharacter(_Ftnpx)
P_Troellchen.Id = "68e214dd-f43e-4868-b074-19d9e002be7f"
P_Troellchen.Name = _yhK5("\022W}Ixx\002JI@")
P_Troellchen.Description = _yhK5(")\vI(\026\026o\v@\v!{IW+\v}@(1I+(DIPFx`\vDI@(\022W}xx+h")
P_Troellchen.Visible = true
P_Troellchen.Media = IMG_Troellchen
P_Troellchen.Icon = IMG_IcoTroll
P_Troellchen.Commands = {
  _nWE = Wherigo.ZCommand({
    Text = _yhK5("\027@+IJI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _oO8w = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _Vho2 = Wherigo.ZCommand({
    Text = _yhK5("\027/+I`YI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Troellchen.Commands._nWE.Custom = true
P_Troellchen.Commands._nWE.Id = "54c505b0-4c46-4a87-8cc3-4acb9aa8e38c"
P_Troellchen.Commands._nWE.WorksWithAll = true
P_Troellchen.Commands._oO8w.Custom = true
P_Troellchen.Commands._oO8w.Id = "de1e2b34-9495-40e8-b377-7c4f2be8638f"
P_Troellchen.Commands._oO8w.WorksWithAll = true
P_Troellchen.Commands._Vho2.Custom = true
P_Troellchen.Commands._Vho2.Id = "c0ad44a7-892f-4d0a-8147-4c7c47e6b3ad"
P_Troellchen.Commands._Vho2.WorksWithAll = true
P_Troellchen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Troellchen.Gender = "Male"
P_Troellchen.Type = "NPC"
P_Huehnchen = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Bergauf10})
P_Huehnchen.Id = "d8cb258d-d494-41de-bc72-b2f82088949c"
P_Huehnchen.Name = _yhK5("s\bIJ@\002JI@")
P_Huehnchen.Description = _yhK5("\a\v@(s\bIJ@\002JI@(+\v`Y`(F\b\t(1IW(\014F@R(Fi(mIDI+WF@1(\b@1(\v+`(xI\v\002J`(DI@IWw`h")
P_Huehnchen.Visible = true
P_Huehnchen.Media = IMG_Huehnchen
P_Huehnchen.Icon = IMG_IcoHuhn
P_Huehnchen.Commands = {
  _mgjgQ = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Huehnchen.Commands._mgjgQ.Custom = true
P_Huehnchen.Commands._mgjgQ.Id = "e3d2e838-0248-4860-8c1f-7edc22ec4c01"
P_Huehnchen.Commands._mgjgQ.WorksWithAll = true
P_Huehnchen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Huehnchen.Gender = "Male"
P_Huehnchen.Type = "NPC"
P_Bibliothekar = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Holzzelt})
P_Bibliothekar.Id = "1ba2f261-fb70-4186-a18d-020c6cd976be"
P_Bibliothekar.Name = _yhK5("\014\v/x\v}`JIRFW")
P_Bibliothekar.Description = _yhK5(")IW(\014\v/x\v}`JIRFW(1IW(DW}I++`I@(mF@1IW/\v/x\v}`JIR(\v@(1IW(DF@YI@(\028IDI@1h(tDJ:(\bDJh")
P_Bibliothekar.Visible = true
P_Bibliothekar.Media = IMG_Bibliothekar
P_Bibliothekar.Icon = IMG_IcoBib
P_Bibliothekar.Commands = {
  _Sdh7 = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Bibliothekar.Commands._Sdh7.Custom = true
P_Bibliothekar.Commands._Sdh7.Id = "e2b1a0e4-9b5e-4a82-a373-c99303a40f64"
P_Bibliothekar.Commands._Sdh7.WorksWithAll = true
P_Bibliothekar.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Bibliothekar.Gender = "Male"
P_Bibliothekar.Type = "NPC"
P_Troll = Wherigo.ZCharacter(_Ftnpx)
P_Troll.Id = "c9fa95af-838c-4a42-9e0c-0ea45ed5e332"
P_Troll.Name = _yhK5("\022W}xx")
P_Troll.Description = _yhK5("s\b\v:(1IW(\v+`(F/IW(P\vI1IW(DF@Y(+\002J}I@(DW}++h(m\vW(+}xx`I@(wIW+\b\002JI@:(1\vI+I@([\b+`F@1(@\v\002J`(FxxY\b(xF@DI(F@1F\bIW@(Y\b(xF++I@h")
P_Troll.Visible = true
P_Troll.Media = IMG_Ba3Troll
P_Troll.Icon = IMG_IcoTroll
P_Troll.Commands = {
  _iiW0l = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Troll.Commands._iiW0l.Custom = true
P_Troll.Commands._iiW0l.Id = "ff0d8797-89a2-41c8-9539-3a03f06b3b03"
P_Troll.Commands._iiW0l.WorksWithAll = true
P_Troll.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Troll.Gender = "Male"
P_Troll.Type = "NPC"
P_Fledermaus = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Bergauf60})
P_Fledermaus.Id = "72ab2cb4-91f0-467e-ace5-a094a9f09a6d"
P_Fledermaus.Name = _yhK5("lxI1IWiF\b+")
P_Fledermaus.Description = _yhK5("\a\v@I(\tWI\002JI(RxI\v@I(lxI1IWiF\b+:(1\vI(DIW@I(\014\v/x\v}`JIRFWI(FIWDIW`h(\003\vI(\v+`(I\v@IW(w}@(8IRWFi}WF+(\003\002JIWDI@h")
P_Fledermaus.Visible = true
P_Fledermaus.Media = IMG_Fledermaus0
P_Fledermaus.Icon = IMG_IcoFM
P_Fledermaus.Commands = {
  _vKObE = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Fledermaus.Commands._vKObE.Custom = true
P_Fledermaus.Commands._vKObE.Id = "9e6fcdf7-93a6-4d12-a199-6791fe45cee1"
P_Fledermaus.Commands._vKObE.WorksWithAll = true
P_Fledermaus.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Fledermaus.Gender = "Male"
P_Fledermaus.Type = "NPC"
P_Piraten = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Innenhof})
P_Piraten.Id = "aa30c382-d886-4c98-a2a0-1b806f45ba40"
P_Piraten.Name = _yhK5("9\vWF`I@")
P_Piraten.Description = _yhK5(")F(+\v@1(+\vI(P\vI1IWh")
P_Piraten.Visible = true
P_Piraten.Media = IMG_Piraten1
P_Piraten.Icon = IMG_IcoPirat
P_Piraten.Commands = {
  _kg0 = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Piraten.Commands._kg0.Custom = true
P_Piraten.Commands._kg0.Id = "989c711c-3e62-4740-9728-e47e37bfffc1"
P_Piraten.Commands._kg0.WorksWithAll = true
P_Piraten.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Piraten.Gender = "Male"
P_Piraten.Type = "NPC"
P_Emilio = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Tisch})
P_Emilio.Id = "01ad3d30-0e6a-46b9-80c8-96a1da783db1"
P_Emilio.Name = _yhK5("lW}+\002J")
P_Emilio.Description = _yhK5("\027i(\022\v+\002J(+\v`Y`(I\v@(lW}+\002Jh")
P_Emilio.Visible = true
P_Emilio.Media = IMG_Emilio0
P_Emilio.Icon = IMG_IcoEmilio
P_Emilio.Commands = {
  _4lGeK = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _XGo4m = Wherigo.ZCommand({
    Text = _yhK5("[I\vDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Emilio.Commands._4lGeK.Custom = true
P_Emilio.Commands._4lGeK.Id = "f4958a76-bd54-4577-bb3f-8aba88833e76"
P_Emilio.Commands._4lGeK.WorksWithAll = true
P_Emilio.Commands._XGo4m.Custom = true
P_Emilio.Commands._XGo4m.Id = "ac86d60d-1d53-43ec-8f07-925e47b20335"
P_Emilio.Commands._XGo4m.WorksWithAll = false
P_Emilio.Commands._XGo4m.WorksWithListIds = {
  "4c0b58ec-a390-404f-b315-e6b5b3170404",
  "1d6a1294-84b0-4ede-8e67-af578c7f7220",
  "0210d7a8-afb5-4360-a69c-d4b52365cd12",
  "f0f403fa-e938-4dbb-b47c-8cf71f04bba5",
  "32c7240a-1f2e-4b05-b146-4862de49bcf3",
  "c01b3db3-fc5d-48be-a076-5d9f78f36e97",
  "d5e6972c-9beb-4442-84bf-8302242a0bc3",
  "8e0fd44c-e492-4bc6-853a-c91d0f16f301",
  "f54bf18c-e392-40b6-8968-883212cc6ed7",
  "1f3883e4-9d5d-4608-a690-ae079227f174",
  "b2a1a7a0-c1ef-4b80-a484-9ff6e4e0bd03",
  "8d5f8edd-d973-4541-8285-b16d3df13d07",
  "69b92883-f3af-49f9-8372-b89a9861c72c"
}
P_Emilio.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Emilio.Gender = "Male"
P_Emilio.Type = "NPC"
P_Skelett = Wherigo.ZCharacter(_Ftnpx)
P_Skelett.Id = "2eca2d11-3051-478b-8f28-d4b8b131f886"
P_Skelett.Name = _yhK5("\003RIxI``")
P_Skelett.Description = _yhK5("8\v\002J`(FxxI(+`I\002RI@(\vi(\014}1I@(\tI+`h()\vI+I+(xFI\b\t`(JIW\bih")
P_Skelett.Visible = true
P_Skelett.Media = IMG_Skelett4
P_Skelett.Icon = IMG_IcoSkel
P_Skelett.Commands = {
  _XujO = Wherigo.ZCommand({
    Text = _yhK5("\127@}\002JI@(@IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Skelett.Commands._XujO.Custom = true
P_Skelett.Commands._XujO.Id = "d9c1c7e6-ab36-42b7-a017-799d8b4d8df1"
P_Skelett.Commands._XujO.WorksWithAll = true
P_Skelett.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Skelett.Gender = "Male"
P_Skelett.Type = "NPC"
P_Goldschmied = Wherigo.ZCharacter(_Ftnpx)
P_Goldschmied.Id = "bd290812-dfe7-40ac-9d14-471a03489c77"
P_Goldschmied.Name = _yhK5("\028}x1+\002Ji\vI1")
P_Goldschmied.Description = _yhK5(")IW(\028}x1+\002Ji\vI1:(1IW(J\vIW(\viiIW(-(o\v@\b`I@(@F\002J(o\v``IW@F\002J`(JIW\bi+y\bR`h")
P_Goldschmied.Visible = true
P_Goldschmied.Media = IMG_Goldschmied01
P_Goldschmied.Icon = IMG_IcoKuerbis
P_Goldschmied.Commands = {
  _OgGl = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _mZXP = Wherigo.ZCommand({
    Text = _yhK5("[I\vDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")IW(\028}x1+\002Ji\vI1(\v+`(Y\b(PI\v`(PIDh")
  })
}
P_Goldschmied.Commands._OgGl.Custom = true
P_Goldschmied.Commands._OgGl.Id = "fd574a4a-1e8c-43e6-ac66-d8589fb0af51"
P_Goldschmied.Commands._OgGl.WorksWithAll = true
P_Goldschmied.Commands._mZXP.Custom = true
P_Goldschmied.Commands._mZXP.Id = "cdb97e8d-0622-4182-b9fe-522cb2134a5e"
P_Goldschmied.Commands._mZXP.WorksWithAll = false
P_Goldschmied.Commands._mZXP.WorksWithListIds = {
  "4c0b58ec-a390-404f-b315-e6b5b3170404",
  "1d6a1294-84b0-4ede-8e67-af578c7f7220",
  "0210d7a8-afb5-4360-a69c-d4b52365cd12",
  "f0f403fa-e938-4dbb-b47c-8cf71f04bba5",
  "32c7240a-1f2e-4b05-b146-4862de49bcf3",
  "c01b3db3-fc5d-48be-a076-5d9f78f36e97",
  "d5e6972c-9beb-4442-84bf-8302242a0bc3",
  "92b17abe-cd0b-4db4-9031-2e9313e44508",
  "463eaaba-2590-4081-b153-828ef6975e55",
  "41eeb262-d174-4e42-a549-e17c0421c1c0",
  "cb7e2ba6-6a52-4d74-849f-650052f66852",
  "36bb4d84-5f00-4b05-911e-e450d7704a7d",
  "5a3ca8e3-202e-4eec-a5f1-bb66735b952d",
  "b2a1a7a0-c1ef-4b80-a484-9ff6e4e0bd03",
  "04d53d1d-d60e-42ae-9775-4818c6c246e1",
  "af05a89e-8db2-4be3-9b7a-629d962bd15c",
  "46822cbc-71c2-474a-8dbe-c0194b43aee9",
  "1f3883e4-9d5d-4608-a690-ae079227f174"
}
P_Goldschmied.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Goldschmied.Gender = "Male"
P_Goldschmied.Type = "NPC"
P_Mumie = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Pyramide})
P_Mumie.Id = "82c58caa-d7c5-4c3a-b4a2-40734e40606d"
P_Mumie.Name = _yhK5("o\bi\vI")
P_Mumie.Description = _yhK5("[\b(I\v@IW(W\v\002J`\vDI@(9UWFi\v1I(DIJ}IW`(F\b\002J(I\v@I(W\v\002J`\vDI(o\bi\vIh")
P_Mumie.Visible = true
P_Mumie.Media = IMG_Mumie1
P_Mumie.Icon = IMG_IcoMumie
P_Mumie.Commands = {
  _8T4 = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
P_Mumie.Commands._8T4.Custom = true
P_Mumie.Commands._8T4.Id = "1017a53c-1682-4f10-a906-b3e600dbdfcd"
P_Mumie.Commands._8T4.WorksWithAll = true
P_Mumie.ObjectLocation = Wherigo.INVALID_ZONEPOINT
P_Mumie.Gender = "Male"
P_Mumie.Type = "NPC"
_aRYZ3 = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Wegweiser})
_aRYZ3.Id = "501cb7ab-a54e-4701-ae4e-01d11b093bd7"
_aRYZ3.Name = _yhK5("\003y\v@@I")
_aRYZ3.Description = _yhK5("\027\b\t(1Ii(mIDPI\v+IW(+\v`Y`(I\v@I(\tI``I(\003y\v@@Ih()\vI(+y\v@@`(P}Jx\n")
_aRYZ3.Visible = true
_aRYZ3.Media = IMG_SpinneS1
_aRYZ3.Icon = IMG_IcoSpinne
_aRYZ3.Commands = {}
_aRYZ3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_aRYZ3.Gender = "Male"
_aRYZ3.Type = "NPC"
_2now = Wherigo.ZCharacter(_Ftnpx)
_2now.Id = "ec56cbc8-35dd-41b7-8a3c-805d791950fb"
_2now.Name = _yhK5("mI\vJ@F\002J`+iF\b+")
_2now.Description = _yhK5("\a\v@I(oF\b+(i\v`(mI\vJ@F\002J`+iF\b+i\bI`YI(+\v`Y`(w}W(1IW(?WFRIxJ}IJxIh")
_2now.Visible = true
_2now.Media = IMG_WeihMaus0
_2now.Icon = IMG_IcoWeihMaus
_2now.Commands = {
  BTN_WM_Sprechen = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
_2now.Commands.BTN_WM_Sprechen.Custom = true
_2now.Commands.BTN_WM_Sprechen.Id = "91e14828-0057-4397-bdb5-ef37ec718593"
_2now.Commands.BTN_WM_Sprechen.WorksWithAll = true
_2now.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2now.Gender = "Male"
_2now.Type = "NPC"
_UsT = Wherigo.ZCharacter({Cartridge = _Ftnpx, Container = Z_Einsiedelei})
_UsT.Id = "7d5114ed-4d58-487b-9575-0ca2ad6cc00e"
_UsT.Name = _yhK5("]\v\002J`")
_UsT.Description = _yhK5("\a`PF+(+`WFJx`(\v@(1IW()\b@RIxJI\v`:(F/IW(I+(/xI@1I`(+}(+IJW:(1F++(iF@(@\v\002J`(DI@F\b(IWRI@@I@(RF@@:(PF+(I+(\v+`h(")
_UsT.Visible = true
_UsT.Media = IMG_EinsiedelB03
_UsT.Icon = IMG_IcoLicht
_UsT.Commands = {
  BTN_LichtUntersuchen = Wherigo.ZCommand({
    Text = _yhK5("t@`IW+\b\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
_UsT.Commands.BTN_LichtUntersuchen.Custom = true
_UsT.Commands.BTN_LichtUntersuchen.Id = "28533fb5-be01-4d52-8849-cac452f7a047"
_UsT.Commands.BTN_LichtUntersuchen.WorksWithAll = true
_UsT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_UsT.Gender = "Male"
_UsT.Type = "NPC"
_Xu42P = Wherigo.ZCharacter(_Ftnpx)
_Xu42P.Id = "482080d4-265c-45fc-b0d2-73452bbf4aec"
_Xu42P.Name = _yhK5("\028I\v+`")
_Xu42P.Description = _yhK5("\127F\bi(Y\b(DxF\b/I@:(I\v@(\028I\v+`(i\v`(/xF\bIi(s\b`h")
_Xu42P.Visible = true
_Xu42P.Media = IMG_EinsiedelB05
_Xu42P.Icon = IMG_IcoGeist
_Xu42P.Commands = {
  BTN_GeistSprechen = Wherigo.ZCommand({
    Text = _yhK5("\003yWI\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
_Xu42P.Commands.BTN_GeistSprechen.Custom = true
_Xu42P.Commands.BTN_GeistSprechen.Id = "2d16aa5b-ac6f-489e-b18c-5b4d7b54da85"
_Xu42P.Commands.BTN_GeistSprechen.WorksWithAll = true
_Xu42P.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Xu42P.Gender = "Male"
_Xu42P.Type = "NPC"
ITM_Laterne = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Laterne.Id = "4c0b58ec-a390-404f-b315-e6b5b3170404"
ITM_Laterne.Name = _yhK5("]F`IW@I")
ITM_Laterne.Description = _yhK5(")\vI(\127IWYI(\v@(1IW(]FiyI(xI\b\002J`I`(@}\002J(\viiIW:(P\vWRx\v\002J(/IiIWRI@+PIW`h")
ITM_Laterne.Visible = true
ITM_Laterne.Media = IMG_Laterne
ITM_Laterne.Icon = IMG_IcoLaterne
ITM_Laterne.Commands = {
  _aDHF = Wherigo.ZCommand({
    Text = _yhK5("\028I/I@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Laterne.Commands._aDHF.Custom = true
ITM_Laterne.Commands._aDHF.Id = "6b7a1996-ea86-45cb-87a6-0c324b3e9e56"
ITM_Laterne.Commands._aDHF.WorksWithAll = true
ITM_Laterne.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Laterne.Locked = false
ITM_Laterne.Opened = false
ITM_Ast = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Ast.Id = "1d6a1294-84b0-4ede-8e67-af578c7f7220"
ITM_Ast.Name = _yhK5("\027+`")
ITM_Ast.Description = _yhK5("\aW+`F\b@x\v\002J:(1F++(1IW(\\FI/I(1IW(oI\v@\b@D(PFW:(1F++()\b(1\vI+I@(\027+`(IW@I\b`(i\v`()\vW(JIW\bi+\002JxIyyI@(+}xx+`h(\027@1IWIW+I\v`+:(IW(i\b++(\vJ@(LF(F\b\002J(@\v\002J`(`WFDI@h")
ITM_Ast.Visible = true
ITM_Ast.Media = IMG_Ast
ITM_Ast.Icon = IMG_IcoAst
ITM_Ast.Commands = {
  _Rs7S1 = Wherigo.ZCommand({
    Text = _yhK5("sIW\bi+`}\002JIW@"),
    CmdWith = true,
    Enabled = true,
    EmptyTargetListText = _yhK5(")\b(+`}\002JIW+`(i\v`(1Ii(\027+`(P\vx1(\v@(1IW(\028IDI@1(JIW\bih(mF+(DI@F\b()\b(1Fi\v`(/IYPI\002R+`:(PI\v++`(P}Jx(@\bW()\b(+Ix/+`h")
  })
}
ITM_Ast.Commands._Rs7S1.Custom = true
ITM_Ast.Commands._Rs7S1.Id = "e7e2f4ee-c061-4925-877a-9f18bb7c6bf8"
ITM_Ast.Commands._Rs7S1.WorksWithAll = false
ITM_Ast.Commands._Rs7S1.WorksWithListIds = {
  "d3be9600-3105-44af-a0a6-afa85f34d4ab",
  "68e214dd-f43e-4868-b074-19d9e002be7f",
  "36bb4d84-5f00-4b05-911e-e450d7704a7d"
}
ITM_Ast.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Ast.Locked = false
ITM_Ast.Opened = false
ITM_Keule = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Keule.Id = "0210d7a8-afb5-4360-a69c-d4b52365cd12"
ITM_Keule.Name = _yhK5("\127I\bxI")
ITM_Keule.Description = _yhK5(")\vI(\127I\bxI(DIJ}IW`I(\tW\bIJIW(iFx(1Ii(\022W}xxh()FiFx+(PFW(+\vI(@}\002J(W\vI+\vD:(P\vI(w}i(\014I\v@(I\v@I+(\axI\tF@`I@h( I`Y`(IW\v@@IW`(+\vI(iIJW(F@(1I@(s\bIJ@IWR@}\002JI@(w}i(xI`Y`I@(o\v``FDI++I@h(?/(1IW(\022W}xx(+\vI(P}Jx(wIWi\v++`S(\027\002J(PF+:(+\v\002JIW(JF`(IW(xFI@D+`(I\v@I(@I\bI(DI\t\b@1I@h")
ITM_Keule.Visible = true
ITM_Keule.Media = IMG_Keule
ITM_Keule.Icon = IMG_IcoKeule
ITM_Keule.Commands = {
  _w5mQ_ = Wherigo.ZCommand({
    Text = _yhK5("{IW`F\b+\002JI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Keule.Commands._w5mQ_.Custom = true
ITM_Keule.Commands._w5mQ_.Id = "d593232d-1329-4b4c-a405-9a9647f98a95"
ITM_Keule.Commands._w5mQ_.WorksWithAll = true
ITM_Keule.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Keule.Locked = false
ITM_Keule.Opened = false
ITM_Lollis = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Lollis.Id = "f0f403fa-e938-4dbb-b47c-8cf71f04bba5"
ITM_Lollis.Name = _yhK5("]}xx\v+")
ITM_Lollis.Description = _yhK5(")\vI(]}xx\v+(F\b+(1IW(\022W}xx!\022W\bJI:(`}xxh()\vI(iI\v+`I@(+\v@1(@}\002J(\v@(9Fy\vIW(I\v@DIP\v\002RIx`:(LI1}\002J(@\v\002J`(FxxIh(oF@\002JI(w}@(#J@I@(+IJI@(iF``(F\b+:(F@1IWI(P\vI1IW(+\v@1(+}(RxFW(P\vI(I\v@I(\127W\v+`FxxR\bDIxh")
ITM_Lollis.Visible = true
ITM_Lollis.Media = IMG_Lollis
ITM_Lollis.Icon = IMG_IcoLolli
ITM_Lollis.Commands = {
  _rcTB = Wherigo.ZCommand({
    Text = _yhK5("]}xx\v+(DI/I@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("mI@@()\b(]}xx\v+(JFI``I+`:(P\bIW1I+`()\b(DF@Y(+\v\002JIW(DIW@I(PIx\002JI(F/DI/I@h")
  }),
  _j7O6f = Wherigo.ZCommand({
    Text = _yhK5("]\b`+\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Lollis.Commands._rcTB.Custom = true
ITM_Lollis.Commands._rcTB.Id = "1aade0f2-2e55-4713-b2ee-5df2478cace9"
ITM_Lollis.Commands._rcTB.WorksWithAll = false
ITM_Lollis.Commands._rcTB.WorksWithListIds = {
  "d3be9600-3105-44af-a0a6-afa85f34d4ab"
}
ITM_Lollis.Commands._j7O6f.Custom = true
ITM_Lollis.Commands._j7O6f.Id = "73b087e9-278c-413d-a66f-dc5ace9fd34d"
ITM_Lollis.Commands._j7O6f.WorksWithAll = true
ITM_Lollis.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Lollis.Locked = false
ITM_Lollis.Opened = false
ITM_LolliFeder = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Z_Lollistelle2})
ITM_LolliFeder.Id = "32c7240a-1f2e-4b05-b146-4862de49bcf3"
ITM_LolliFeder.Name = _yhK5("]}xx\v(i\v`(lI1IW")
ITM_LolliFeder.Description = _yhK5("\027@(1\vI+Ii(]}xx\v(RxI/`(I\v@I(lI1IWh")
ITM_LolliFeder.Visible = true
ITM_LolliFeder.Media = IMG_Lolli2
ITM_LolliFeder.Icon = IMG_IcoLolli
ITM_LolliFeder.Commands = {
  _34e4o = Wherigo.ZCommand({
    Text = _yhK5("8IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  __oru = Wherigo.ZCommand({
    Text = _yhK5("]\b`+\002JI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_LolliFeder.Commands._34e4o.Custom = true
ITM_LolliFeder.Commands._34e4o.Id = "8727b58f-351f-47f7-8588-8881cfe227ac"
ITM_LolliFeder.Commands._34e4o.WorksWithAll = true
ITM_LolliFeder.Commands.__oru.Custom = true
ITM_LolliFeder.Commands.__oru.Id = "9968f2d3-7785-411e-aae9-ca9feb8876f9"
ITM_LolliFeder.Commands.__oru.WorksWithAll = true
ITM_LolliFeder.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_LolliFeder.Locked = false
ITM_LolliFeder.Opened = false
ITM_LolliHaar = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Z_Lollistelle3})
ITM_LolliHaar.Id = "c01b3db3-fc5d-48be-a076-5d9f78f36e97"
ITM_LolliHaar.Name = _yhK5("]}xx\v(i\v`(sFFW")
ITM_LolliHaar.Description = _yhK5("\027@(1\vI+Ii(]}xx\v(RxI/`(1F+(sFFW(I\v@I+(1WI\vR}Iy\t\vDI@(\027\t\tI@h")
ITM_LolliHaar.Visible = true
ITM_LolliHaar.Media = IMG_Lolli1
ITM_LolliHaar.Icon = IMG_IcoLolli
ITM_LolliHaar.Commands = {
  _6IsGG = Wherigo.ZCommand({
    Text = _yhK5("8IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _yzHs = Wherigo.ZCommand({
    Text = _yhK5("]\b`+\002JI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_LolliHaar.Commands._6IsGG.Custom = true
ITM_LolliHaar.Commands._6IsGG.Id = "535b5334-ca59-4f03-8594-e1ea288ef7f7"
ITM_LolliHaar.Commands._6IsGG.WorksWithAll = true
ITM_LolliHaar.Commands._yzHs.Custom = true
ITM_LolliHaar.Commands._yzHs.Id = "c61dead9-bcbd-430e-9912-87c4acfe8085"
ITM_LolliHaar.Commands._yzHs.WorksWithAll = true
ITM_LolliHaar.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_LolliHaar.Locked = false
ITM_LolliHaar.Opened = false
ITM_LolliDreck = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Z_Lollistelle1})
ITM_LolliDreck.Id = "d5e6972c-9beb-4442-84bf-8302242a0bc3"
ITM_LolliDreck.Name = _yhK5("]}xx\v(i\v`()WI\002R")
ITM_LolliDreck.Description = _yhK5("tI/IW(1\vI+I@(]}xx\v(+\002JI\v@`(I\v@I(\003\002J@I\002RI(DIRW}\002JI@(Y\b(+I\v@h")
ITM_LolliDreck.Visible = true
ITM_LolliDreck.Media = IMG_Lolli3
ITM_LolliDreck.Icon = IMG_IcoLolli
ITM_LolliDreck.Commands = {
  _ZLZ8f = Wherigo.ZCommand({
    Text = _yhK5("8IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _tL2 = Wherigo.ZCommand({
    Text = _yhK5("]\b`+\002JI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_LolliDreck.Commands._ZLZ8f.Custom = true
ITM_LolliDreck.Commands._ZLZ8f.Id = "a0800a5a-38a6-473d-b627-ecd23fbe48ca"
ITM_LolliDreck.Commands._ZLZ8f.WorksWithAll = true
ITM_LolliDreck.Commands._tL2.Custom = true
ITM_LolliDreck.Commands._tL2.Id = "a7059ecb-775c-47ad-817d-379a4dcacbc7"
ITM_LolliDreck.Commands._tL2.WorksWithAll = true
ITM_LolliDreck.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_LolliDreck.Locked = false
ITM_LolliDreck.Opened = false
ITM_Notiz = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Notiz.Id = "8e0fd44c-e492-4bc6-853a-c91d0f16f301"
ITM_Notiz.Name = _yhK5("8}`\vY")
ITM_Notiz.Description = _yhK5("\028F@Y(\b@`I@(\v@()I\v@Ii(\\\b\002R+F\002R(x\vID`(I\v@(YIWR@\v``IW`I+(\014xF``(9Fy\vIWh()FWF\b\t(+`IJ`(i\v`(DW}++I@(\014\b\002J+`F/I@(Z9\vWFI/I\r\022!?@x\v@Ih1IZ(\b@1(1FW\b@`IW(I`PF+(RxI\v@IWB(mI@@\024+(iFx(@\v\002J`(iIJW(PI\v`IW(DIJ`h\020\014\\6\020\014\\6\a+(\v+`(IW+`F\b@x\v\002Jh(oF@\002JI()\v@DI(/xI\v/I@(+Ix/+`(1F@@(\v@(I\v@Ii(\\\b\002R+F\002R(x\vIDI@:(PI@@(iF@(\vJ@(R}iyxI``(xIIW(WFI\bi`h()Fi\v`(+\v\002J(1FWF@(F\b\002J(PI\v`IWJ\v@(@\v\002J`+(FI@1IW`:(xID+`()\b(1I@([I``Ix(Y\bW\bI\002R(\v@(1\vI(1\b@RIx+`I(\a\002RI(1I+(\\\b\002R+F\002R+h")
ITM_Notiz.Visible = true
ITM_Notiz.Media = IMG_Notiz
ITM_Notiz.Icon = IMG_IcoNotiz
ITM_Notiz.Commands = {
  BTN_Notiz_Weglegen = Wherigo.ZCommand({
    Text = _yhK5("mIDxIDI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Notiz.Commands.BTN_Notiz_Weglegen.Custom = true
ITM_Notiz.Commands.BTN_Notiz_Weglegen.Id = "aeb7af85-005c-4c15-a02d-061864ffefee"
ITM_Notiz.Commands.BTN_Notiz_Weglegen.WorksWithAll = true
ITM_Notiz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Notiz.Locked = false
ITM_Notiz.Opened = false
ITM_Buch = Wherigo.ZItem(_Ftnpx)
ITM_Buch.Id = "46535312-d074-488a-81cc-a70762904c45"
ITM_Buch.Name = _yhK5("\014\b\002J")
ITM_Buch.Description = _yhK5(")F+(\014\b\002J:(1F+(1Ii(\014\v/x\v}`JIRFW(\bI/IW(1I@(\127}y\t(DIPF\002J+I@(\v+`h")
ITM_Buch.Visible = true
ITM_Buch.Media = IMG_Trollbuch
ITM_Buch.Icon = IMG_IcoBuch
ITM_Buch.Commands = {
  _LDd = Wherigo.ZCommand({
    Text = _yhK5("]I+I@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  _W7hAn = Wherigo.ZCommand({
    Text = _yhK5("\014\b\002J(DI/I@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Buch.Commands._LDd.Custom = true
ITM_Buch.Commands._LDd.Id = "53a924bb-2c6a-423f-8dba-0d6b293fe2f9"
ITM_Buch.Commands._LDd.WorksWithAll = true
ITM_Buch.Commands._W7hAn.Custom = true
ITM_Buch.Commands._W7hAn.Id = "7cfa5a79-6bf5-4018-aa4e-ee4140747272"
ITM_Buch.Commands._W7hAn.WorksWithAll = false
ITM_Buch.Commands._W7hAn.WorksWithListIds = {
  "c9fa95af-838c-4a42-9e0c-0ea45ed5e332"
}
ITM_Buch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Buch.Locked = false
ITM_Buch.Opened = false
ITM_Buechlein = Wherigo.ZItem(_Ftnpx)
ITM_Buechlein.Id = "20a8ee66-ed6c-4841-bd48-896ac193b3e5"
ITM_Buechlein.Name = _yhK5("\014\bI\002JxI\v@")
ITM_Buechlein.Description = _yhK5("Z\022W}xx(\022I\002J@}x}D\vI(!(\022JI}W\vI(\b@1(9WF3\v+Z(LI`Y`(P\vI1IW(\v@(?W\vD\v@FxDW}I++Ih")
ITM_Buechlein.Visible = true
ITM_Buechlein.Media = IMG_Trollbuch
ITM_Buechlein.Icon = IMG_IcoBuch
ITM_Buechlein.Commands = {
  _Tlyh = Wherigo.ZCommand({
    Text = _yhK5("\014\b\002J(DI/I@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Buechlein.Commands._Tlyh.Custom = true
ITM_Buechlein.Commands._Tlyh.Id = "79cda446-d77c-46e8-a665-1a9a43e4fa4b"
ITM_Buechlein.Commands._Tlyh.WorksWithAll = false
ITM_Buechlein.Commands._Tlyh.WorksWithListIds = {
  "1ba2f261-fb70-4186-a18d-020c6cd976be"
}
ITM_Buechlein.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Buechlein.Locked = false
ITM_Buechlein.Opened = false
ITM_BibAusweis = Wherigo.ZItem(_Ftnpx)
ITM_BibAusweis.Id = "463eaaba-2590-4081-b153-828ef6975e55"
ITM_BibAusweis.Name = _yhK5("\014\v/x\v}`JIR+!\027\b+PI\v+")
ITM_BibAusweis.Description = _yhK5("o\v`(1\vI+Ii(\027\b+PI\v+(RF@@(iF@(1\vI(mF@1IW/\v/x\v}`JIR(JIW/I\vW\b\tI@h")
ITM_BibAusweis.Visible = true
ITM_BibAusweis.Media = IMG_Ausweis
ITM_BibAusweis.Icon = IMG_IcoAusweis
ITM_BibAusweis.Commands = {
  _jwO = Wherigo.ZCommand({
    Text = _yhK5("\014\v/x\v}`JIR(W\b\tI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_BibAusweis.Commands._jwO.Custom = true
ITM_BibAusweis.Commands._jwO.Id = "73c7aafe-3038-41fe-813c-16d88ef9be93"
ITM_BibAusweis.Commands._jwO.WorksWithAll = true
ITM_BibAusweis.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_BibAusweis.Locked = false
ITM_BibAusweis.Opened = false
ITM_Amulett = Wherigo.ZItem(_Ftnpx)
ITM_Amulett.Id = "f54bf18c-e392-40b6-8968-883212cc6ed7"
ITM_Amulett.Name = _yhK5("\027i\bxI``")
ITM_Amulett.Description = _yhK5("\a\v@(P\vWRx\v\002J(/II\v@1W\b\002RI@1I+(\127I``\002JI@(F\b+(\028\bii\v@\byy+\vI+:(hhh(J}\t\tI@(P\vW(iFx:(1F++(1F+(Fx+(\027i\bxI``(1\bW\002JDIJ`h")
ITM_Amulett.Visible = true
ITM_Amulett.Media = IMG_Kettchen
ITM_Amulett.Icon = _opRKv
ITM_Amulett.Commands = {
  _qFJH = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  })
}
ITM_Amulett.Commands._qFJH.Custom = true
ITM_Amulett.Commands._qFJH.Id = "c4aabaf1-d6ef-4129-968c-a4d4451f4ada"
ITM_Amulett.Commands._qFJH.WorksWithAll = false
ITM_Amulett.Commands._qFJH.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Amulett.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Amulett.Locked = false
ITM_Amulett.Opened = false
ITM_WeissesTuch = Wherigo.ZItem(_Ftnpx)
ITM_WeissesTuch.Id = "1f3883e4-9d5d-4608-a690-ae079227f174"
ITM_WeissesTuch.Name = _yhK5("mI\v++I+(\022\b\002J")
ITM_WeissesTuch.Description = _yhK5(")\vI+I+(\022\b\002J(JF`()\vW(1F+(s\bIJ@\002JI@(DI/I@(Fx+()F@R(1F\t\bIW:(1F++()\b(1I@(\022W}xx(/I+I\v`\vD`(JF+`h()\b(JFI``I+`(1F+(\022\b\002J(LI`Y`(wIWi\b`x\v\002J(@\v\002J`:(PI@@(1F+(s\bIJ@\002JI@(DIP\b++`(JFI``I:(PF+(F@(1IW(\014W\bI\002RI(yF++\vIW`(\v+`h")
ITM_WeissesTuch.Visible = true
ITM_WeissesTuch.Media = IMG_TuchWeiss
ITM_WeissesTuch.Icon = IMG_IcoTuch
ITM_WeissesTuch.Commands = {}
ITM_WeissesTuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_WeissesTuch.Locked = false
ITM_WeissesTuch.Opened = false
ITM_Beeren = Wherigo.ZItem(_Ftnpx)
ITM_Beeren.Id = "41eeb262-d174-4e42-a549-e17c0421c1c0"
ITM_Beeren.Name = _yhK5("\014IIWI@")
ITM_Beeren.Description = _yhK5(")\vI(\014IIWI@:(1\vI(1IW(\\FI/I(JF/I@(P}xx`Ih")
ITM_Beeren.Visible = true
ITM_Beeren.Media = IMG_Beeren
ITM_Beeren.Icon = IMG_IcoBeeren
ITM_Beeren.Commands = {
  _eDe = Wherigo.ZCommand({
    Text = _yhK5("8IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Beeren.Commands._eDe.Custom = true
ITM_Beeren.Commands._eDe.Id = "b6fc601c-0074-49c5-a476-d26e2580e41e"
ITM_Beeren.Commands._eDe.WorksWithAll = true
ITM_Beeren.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Beeren.Locked = false
ITM_Beeren.Opened = false
ITM_Schluessel = Wherigo.ZItem(_Ftnpx)
ITM_Schluessel.Id = "cb7e2ba6-6a52-4d74-849f-650052f66852"
ITM_Schluessel.Name = _yhK5("\003\002Jx\bI++Ix")
ITM_Schluessel.Description = _yhK5(")IW(\003\002Jx\bI++Ix(Y\bW(\003\002JF`YR\v+`I(1IW(9\vWF`I@h")
ITM_Schluessel.Visible = true
ITM_Schluessel.Media = IMG_Schluessel
ITM_Schluessel.Icon = IMG_IcoSchluessel
ITM_Schluessel.Commands = {}
ITM_Schluessel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Schluessel.Locked = false
ITM_Schluessel.Opened = false
ITM_Schatztruhe = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Z_Innenhof})
ITM_Schatztruhe.Id = "69b16398-47c5-4907-a6af-715b49944460"
ITM_Schatztruhe.Name = _yhK5("\003\002JF`Y`W\bJI")
ITM_Schatztruhe.Description = _yhK5("[\b(W\v\002J`\vDI@(9\vWF`I@(DIJ}IW`(F\b\002J(I\v@I(W\v\002J`\vDI(\003\002JF`Y`W\bJIh")
ITM_Schatztruhe.Visible = true
ITM_Schatztruhe.Media = IMG_Schatztruhe1
ITM_Schatztruhe.Commands = {
  _y27 = Wherigo.ZCommand({
    Text = _yhK5("?I\t\t@I@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Schatztruhe.Commands._y27.Custom = true
ITM_Schatztruhe.Commands._y27.Id = "084a4d2f-0f3d-4c71-84df-c646bb0c851c"
ITM_Schatztruhe.Commands._y27.WorksWithAll = true
ITM_Schatztruhe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Schatztruhe.Locked = false
ITM_Schatztruhe.Opened = false
ITM_Gral = Wherigo.ZItem(_Ftnpx)
ITM_Gral.Id = "36bb4d84-5f00-4b05-911e-e450d7704a7d"
ITM_Gral.Name = _yhK5(")IW(JI\vx\vDI(\028WFx")
ITM_Gral.Description = _yhK5(")IW(JI\vx\vDI(\028WFx:(}1IW(PI@@(iF@(1\vI(\028W}I++I(/I1I@R`:(w\vIxxI\v\002J`(1}\002J(@\bW(1IW(JI\vx\vDI(\a\vIW/I\002JIWS(mIW(PI\v++h")
ITM_Gral.Visible = true
ITM_Gral.Media = IMG_Gral
ITM_Gral.Icon = IMG_IcoGral
ITM_Gral.Commands = {
  _DYufo = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  }),
  _VGq_t = Wherigo.ZCommand({
    Text = _yhK5("\003ID@I@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Gral.Commands._DYufo.Custom = true
ITM_Gral.Commands._DYufo.Id = "cd8b245c-92db-4f1a-9bd0-ab9606f2f754"
ITM_Gral.Commands._DYufo.WorksWithAll = false
ITM_Gral.Commands._DYufo.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Gral.Commands._VGq_t.Custom = true
ITM_Gral.Commands._VGq_t.Id = "f84534ed-8207-42cd-91ce-129347e5f269"
ITM_Gral.Commands._VGq_t.WorksWithAll = false
ITM_Gral.Commands._VGq_t.WorksWithListIds = {
  "41eeb262-d174-4e42-a549-e17c0421c1c0",
  "1f3883e4-9d5d-4608-a690-ae079227f174",
  "0210d7a8-afb5-4360-a69c-d4b52365cd12",
  "f0f403fa-e938-4dbb-b47c-8cf71f04bba5"
}
ITM_Gral.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Gral.Locked = false
ITM_Gral.Opened = false
ITM_Muenzen = Wherigo.ZItem(_Ftnpx)
ITM_Muenzen.Id = "af05a89e-8db2-4be3-9b7a-629d962bd15c"
ITM_Muenzen.Name = _yhK5("\028}x1i\bI@YI@")
ITM_Muenzen.Description = _yhK5("\028IJ}IW`(I\v@\tF\002J(\v@(LI1I(D\b`(+}W`\vIW`I(\003\002JF`YR\v+`Ih")
ITM_Muenzen.Visible = true
ITM_Muenzen.Media = IMG_Gold
ITM_Muenzen.Icon = IMG_IcoMuenzen
ITM_Muenzen.Commands = {
  _eNmRW = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  })
}
ITM_Muenzen.Commands._eNmRW.Custom = true
ITM_Muenzen.Commands._eNmRW.Id = "439fc058-4a23-40a5-a304-c3c232e11005"
ITM_Muenzen.Commands._eNmRW.WorksWithAll = false
ITM_Muenzen.Commands._eNmRW.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Muenzen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Muenzen.Locked = false
ITM_Muenzen.Opened = false
ITM_Briefmarke = Wherigo.ZItem(_Ftnpx)
ITM_Briefmarke.Id = "5a3ca8e3-202e-4eec-a5f1-bb66735b952d"
ITM_Briefmarke.Name = _yhK5("\014xF\bI(oF\bW\v`\v\b+")
ITM_Briefmarke.Description = _yhK5("\a\v@(/xF\bI(\014W\vI\tiFWRI:(1\vI(+\v\002J(+}DFW(I\v@I@(I\vDI@I@(8FiI@(xI\v+`I@(RF@@h(\a+(\v+`(D\b`:(+\vI(1F/I\v(Y\b(JF/I@(!(+\002J}@(FxxI\v@(\t\bIW(1I@(lFxx:(1F++()\b(DF@Y(1W\v@DI@1(I\v@I@(\014W\vI\t(wIW+\002J\v\002RI@(i\b++`h")
ITM_Briefmarke.Visible = true
ITM_Briefmarke.Media = IMG_BlaueMauritius
ITM_Briefmarke.Icon = IMG_IcoBriefmarke
ITM_Briefmarke.Commands = {
  _XQgLK = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  })
}
ITM_Briefmarke.Commands._XQgLK.Custom = true
ITM_Briefmarke.Commands._XQgLK.Id = "3de7886b-9978-4a6f-b76e-ba6a0c123ad6"
ITM_Briefmarke.Commands._XQgLK.WorksWithAll = false
ITM_Briefmarke.Commands._XQgLK.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Briefmarke.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Briefmarke.Locked = false
ITM_Briefmarke.Opened = false
ITM_BuntesTuch = Wherigo.ZItem(_Ftnpx)
ITM_BuntesTuch.Id = "b2a1a7a0-c1ef-4b80-a484-9ff6e4e0bd03"
ITM_BuntesTuch.Name = _yhK5("\014\b@`I+(\022\b\002J")
ITM_BuntesTuch.Description = _yhK5("\a\v@(I\v@+`iFx+(PI\v++I+(\022\b\002J:(@\b@(wIWY\vIW`(i\v`(I\v@Ii(JI\vx\vDI@(o\b+`IW(F\b+(1Ii(\003F\t`(W}`IW(\014IIWI@h([\b+FiiI@(i\v`(1I@(\\I+`I@(1IW(\bW+yW\bI@Dx\v\002JI@(PI\v++I@(lFW/I(+}xx`I(1F+(/\b@`(DI@\bD(+I\v@h")
ITM_BuntesTuch.Visible = true
ITM_BuntesTuch.Media = IMG_TuchBunt
ITM_BuntesTuch.Icon = IMG_IcoTuch
ITM_BuntesTuch.Commands = {}
ITM_BuntesTuch.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_BuntesTuch.Locked = false
ITM_BuntesTuch.Opened = false
ITM_Foto = Wherigo.ZItem(_Ftnpx)
ITM_Foto.Id = "11485aaf-f90b-4e36-9c4d-678ed305da14"
ITM_Foto.Name = _yhK5("l}`}")
ITM_Foto.Description = _yhK5("\027\b\t()I\v@Ii(sF@1U(/I\t\v@1I`(+\v\002J(@\b@(I\v@(l}`}(i\v`(1Ii(\022\v`Ix(Z\\FI/I(F\b\t(I\v@IW(\014F@R(F\b\t(I\v@Ii(s\bIDIxZh")
ITM_Foto.Visible = true
ITM_Foto.Media = IMG_Huegelfoto
ITM_Foto.Icon = IMG_IcoFoto
ITM_Foto.Commands = {
  _70V = Wherigo.ZCommand({
    Text = _yhK5("\028I/I@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Foto.Commands._70V.Custom = true
ITM_Foto.Commands._70V.Id = "3f7547d3-e4d3-4010-ac50-44aedab6e2c2"
ITM_Foto.Commands._70V.WorksWithAll = false
ITM_Foto.Commands._70V.WorksWithListIds = {
  "1ba2f261-fb70-4186-a18d-020c6cd976be"
}
ITM_Foto.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Foto.Locked = false
ITM_Foto.Opened = false
ITM_Dokument = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Player})
ITM_Dokument.Id = "8d5f8edd-d973-4541-8285-b16d3df13d07"
ITM_Dokument.Name = _yhK5(")}R\biI@`")
ITM_Dokument.Description = _yhK5(")IW(9Fy\vIWRWFi:(1I@(#JW(\t\bIW(1\vI(9\vWF`I@(I\v@DI+FiiIx`(JF/`h()FWF\b\t(+`IJ`([I\bD(\v@(I\v@IW(\b@/IRF@@`I@(Fx`IW`\bIix\v\002JI@(\003yWF\002JIh(\027\b++IW1Ii(+`IJI@(1FWF\b\t(I\v@(yFFW(8}`\vYI@:(1\vI(P}Jx(1IW({IW+\b\002J(I\v@IW(tI/IW+I`Y\b@D(+\v@1h(t@`IW(\vJ@I@(\t\v@1I`(+\v\002J(F\b\002J(1F+(m}W`(\127\b@\v`Y/\bWDh")
ITM_Dokument.Visible = true
ITM_Dokument.Media = IMG_Dokument
ITM_Dokument.Icon = IMG_IcoDokumente
ITM_Dokument.Commands = {}
ITM_Dokument.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Dokument.Locked = false
ITM_Dokument.Opened = false
ITM_Haar = Wherigo.ZItem(_Ftnpx)
ITM_Haar.Id = "3593549c-028a-4d46-8e60-10b09258ba3b"
ITM_Haar.Name = _yhK5("sFFW")
ITM_Haar.Description = _yhK5(")\vI+I+(sFFW(JF`(1\vI(lxI1IWiF\b+(w}@(8IRWFi}WF(DIRxF\b`h")
ITM_Haar.Visible = true
ITM_Haar.Media = IMG_Haar
ITM_Haar.Icon = IMG_IcoHaar
ITM_Haar.Commands = {
  _21c = Wherigo.ZCommand({
    Text = _yhK5("\127}i/\v@\vIWI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Haar.Commands._21c.Custom = true
ITM_Haar.Commands._21c.Id = "02cda4d6-6ed8-4731-bee5-6cfe5bd6b036"
ITM_Haar.Commands._21c.WorksWithAll = false
ITM_Haar.Commands._21c.WorksWithListIds = {
  "0210d7a8-afb5-4360-a69c-d4b52365cd12",
  "3c8e70bc-5521-42ff-b918-be3bdd61097d"
}
ITM_Haar.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Haar.Locked = false
ITM_Haar.Opened = false
ITM_Knochen = Wherigo.ZItem(_Ftnpx)
ITM_Knochen.Id = "3c8e70bc-5521-42ff-b918-be3bdd61097d"
ITM_Knochen.Name = _yhK5("\127@}\002JI@")
ITM_Knochen.Description = _yhK5("?/(1IW(\003RIxI``RW\vIDIW(P}Jx(i\v`(+I\v@Ii(@I\bI@(\127@}\002JI@(Y\b\tW\vI1I@(\v+`S()\b(LI1I@\tFxx+(/\v+`(I+h")
ITM_Knochen.Visible = true
ITM_Knochen.Media = IMG_Knochen
ITM_Knochen.Icon = IMG_IcoKeule
ITM_Knochen.Commands = {}
ITM_Knochen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Knochen.Locked = false
ITM_Knochen.Opened = false
ITM_Ringe = Wherigo.ZItem(_Ftnpx)
ITM_Ringe.Id = "92b17abe-cd0b-4db4-9031-2e9313e44508"
ITM_Ringe.Name = _yhK5("\028\bii\vW\v@DI")
ITM_Ringe.Description = _yhK5("\a\v@I(\022\bI`I(w}xxIW(\028\bii\vW\v@DIh(mF+(JF/I@(1\vI(@\bW(F\b\t(I\v@IW(\014F@R(i\v``I@(\vi(mFx1(wIWx}WI@S")
ITM_Ringe.Visible = true
ITM_Ringe.Media = IMG_Gummiringe
ITM_Ringe.Icon = IMG_IcoRinge
ITM_Ringe.Commands = {}
ITM_Ringe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Ringe.Locked = false
ITM_Ringe.Opened = false
ITM_Uhr = Wherigo.ZItem(_Ftnpx)
ITM_Uhr.Id = "46822cbc-71c2-474a-8dbe-c0194b43aee9"
ITM_Uhr.Name = _yhK5("tJW")
ITM_Uhr.Description = _yhK5("\a\v@I(Fx`I(\022F+\002JI@\bJW:(`\v\002R(`F\002R:(`\v\002R(`F\002R:(`\v\002R(`F\002R:(hhh")
ITM_Uhr.Visible = true
ITM_Uhr.Media = IMG_Uhr
ITM_Uhr.Icon = IMG_IcoUhr
ITM_Uhr.Commands = {
  _HcSK = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  }),
  _f6Q40 = Wherigo.ZCommand({
    Text = _yhK5("\027@+IJI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Uhr.Commands._HcSK.Custom = true
ITM_Uhr.Commands._HcSK.Id = "67a3d35a-fc8c-47ff-ad28-eaab7ab00fef"
ITM_Uhr.Commands._HcSK.WorksWithAll = false
ITM_Uhr.Commands._HcSK.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Uhr.Commands._f6Q40.Custom = true
ITM_Uhr.Commands._f6Q40.Id = "50e98872-bcc0-4358-acff-a5f514c62ebe"
ITM_Uhr.Commands._f6Q40.WorksWithAll = true
ITM_Uhr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Uhr.Locked = false
ITM_Uhr.Opened = false
ITM_Anhaenger = Wherigo.ZItem(_Ftnpx)
ITM_Anhaenger.Id = "04d53d1d-d60e-42ae-9775-4818c6c246e1"
ITM_Anhaenger.Name = _yhK5("\027@JFI@DIW")
ITM_Anhaenger.Description = _yhK5("\a\v@(\028\bii\v!\127\bIW/\v+R}y\t(i\v`(I\v@IW(?+I(1WF@h")
ITM_Anhaenger.Visible = true
ITM_Anhaenger.Media = IMG_Anhaenger
ITM_Anhaenger.Icon = IMG_IcoAnhaenger
ITM_Anhaenger.Commands = {
  _GpSaB = Wherigo.ZCommand({
    Text = _yhK5("\027/xIDI@"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _yhK5(")\vI(\003\002JF`YR\v+`I(\v+`(Y\b(PI\v`(PIDh")
  })
}
ITM_Anhaenger.Commands._GpSaB.Custom = true
ITM_Anhaenger.Commands._GpSaB.Id = "7ce77d62-7ec1-4098-91e1-e5e4cf14fed5"
ITM_Anhaenger.Commands._GpSaB.WorksWithAll = false
ITM_Anhaenger.Commands._GpSaB.WorksWithListIds = {
  "69b16398-47c5-4907-a6af-715b49944460"
}
ITM_Anhaenger.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Anhaenger.Locked = false
ITM_Anhaenger.Opened = false
ITM_Schild = Wherigo.ZItem(_Ftnpx)
ITM_Schild.Id = "f9d7f2da-6c81-404e-af3d-12a9b251723b"
ITM_Schild.Name = _yhK5("\003\002J\vx1")
ITM_Schild.Description = _yhK5(")F(JFI@D`(I\v@(\003\002J\vx1(F@(1IW(\014\bWDW\b\v@Ih")
ITM_Schild.Visible = true
ITM_Schild.Media = IMG_Schild
ITM_Schild.Commands = {
  _xGC = Wherigo.ZCommand({
    Text = _yhK5("]I+I@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Schild.Commands._xGC.Custom = true
ITM_Schild.Commands._xGC.Id = "2285b69b-1d21-4a3c-969d-f51ab5ac6510"
ITM_Schild.Commands._xGC.WorksWithAll = true
ITM_Schild.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Schild.Locked = false
ITM_Schild.Opened = false
ITM_WegweiserCode = Wherigo.ZItem(_Ftnpx)
ITM_WegweiserCode.Id = "2b44523a-b343-406f-81b2-dff5893fb029"
ITM_WegweiserCode.Name = _yhK5("mIDPI\v+IW!\001}1I")
ITM_WegweiserCode.Description = _yhK5(")\vI+I@([I``Ix(JF`()\vW(\ai\vx\v}(DIDI/I@h(\a+(\v+`(I\v@(\a\v@RF\b\t+YI``Ix(\t\bIW(\014\b\002J+`F/I@:(F/Y\bJ}xI@(Fi(mIDPI\v+IWh")
ITM_WegweiserCode.Visible = true
ITM_WegweiserCode.Media = IMG_Wegweiser
ITM_WegweiserCode.Icon = IMG_IcoWegweiser
ITM_WegweiserCode.Commands = {
  _pK4 = Wherigo.ZCommand({
    Text = _yhK5("]I+I@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_WegweiserCode.Commands._pK4.Custom = true
ITM_WegweiserCode.Commands._pK4.Id = "52970020-cc37-4e6e-ae40-8120b73437e7"
ITM_WegweiserCode.Commands._pK4.WorksWithAll = true
ITM_WegweiserCode.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_WegweiserCode.Locked = false
ITM_WegweiserCode.Opened = false
ITM_LolliX = Wherigo.ZItem(_Ftnpx)
ITM_LolliX.Id = "69b92883-f3af-49f9-8372-b89a9861c72c"
ITM_LolliX.Name = _yhK5("]}xx\v(i\v`(\026")
ITM_LolliX.Description = _yhK5("\027\b\t(1\vI+I@(]}xx\v(JF`(LIiF@1(I\v@(\026(DIiFx`h(s}\t\tI@`x\v\002J(i\v`(]I/I@+i\v``Ix\tFW/Ih")
ITM_LolliX.Visible = true
ITM_LolliX.Media = IMG_Lolli4x
ITM_LolliX.Icon = IMG_IcoLolli
ITM_LolliX.Commands = {}
ITM_LolliX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_LolliX.Locked = false
ITM_LolliX.Opened = false
ITM_DevTool = Wherigo.ZItem(_Ftnpx)
ITM_DevTool.Id = "75a60ca8-c496-4088-98a9-6ede9fea8e16"
ITM_DevTool.Name = _yhK5(")Iw\022}}x")
ITM_DevTool.Description = _yhK5(")F+(\v+`(@\bW(\t\bIW(i\v\002Jh(lFxx+()\b(I+(Y\b\tFIxx\vD(DI\t\b@1I@(JF/I@(+}xx`I+`:(xF++(1\vI(l\v@DIW(1Fw}@h\020\014\\6\020\014\\6mIW(I+(\b@/I\t\bD`(/I@\b`Y`:(P\vW1(/I\vi(@FI\002J+`I@(\028IP\v``IW(w}i(\014x\v`Y(IW+\002JxFDI@h")
ITM_DevTool.Visible = true
ITM_DevTool.Icon = IMG_IcoTool
ITM_DevTool.Commands = {
  BTN_Dbg_Startpunkt = Wherigo.ZCommand({
    Text = _yhK5("\003`FW`y\b@R`"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  BTN_DevToolFlags = Wherigo.ZCommand({
    Text = _yhK5("lxFD(+I`YI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_DevTool.Commands.BTN_Dbg_Startpunkt.Custom = true
ITM_DevTool.Commands.BTN_Dbg_Startpunkt.Id = "72f1a7d5-c45b-4ae1-a959-6573e24f7b5e"
ITM_DevTool.Commands.BTN_Dbg_Startpunkt.WorksWithAll = true
ITM_DevTool.Commands.BTN_DevToolFlags.Custom = true
ITM_DevTool.Commands.BTN_DevToolFlags.Id = "62d6d3d5-958e-4dff-9da7-cd9aca762801"
ITM_DevTool.Commands.BTN_DevToolFlags.WorksWithAll = true
ITM_DevTool.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_DevTool.Locked = false
ITM_DevTool.Opened = false
ITM_Schild2 = Wherigo.ZItem({Cartridge = _Ftnpx, Container = Z_Orakel})
ITM_Schild2.Id = "2fdd37fc-0946-468f-b700-b230f5ac9a60"
ITM_Schild2.Name = _yhK5("\003\002J\vx1")
ITM_Schild2.Description = _yhK5(")\vI(\027/PI+I@JI\v`+@}`\vY(1I+(?WFRIx+h")
ITM_Schild2.Visible = true
ITM_Schild2.Media = IMG_Ora5
ITM_Schild2.Commands = {
  BTN_Sch2Untersuchen = Wherigo.ZCommand({
    Text = _yhK5("t@`IW+\b\002JI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Schild2.Commands.BTN_Sch2Untersuchen.Custom = true
ITM_Schild2.Commands.BTN_Sch2Untersuchen.Id = "3c2ff4bb-1954-454a-ae94-f94bcf4ec2eb"
ITM_Schild2.Commands.BTN_Sch2Untersuchen.WorksWithAll = true
ITM_Schild2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Schild2.Locked = false
ITM_Schild2.Opened = false
ITM_Geschenk = Wherigo.ZItem(_Ftnpx)
ITM_Geschenk.Id = "db116fcd-bfa7-4156-810a-e23f430b997c"
ITM_Geschenk.Name = _yhK5("\028I+\002JI@R")
ITM_Geschenk.Description = _yhK5(")F+(yIW\tIR`I(mI\vJ@F\002J`+DI+\002JI@R:(\tFxx+(iF@(1IW(mIW/\b@D(DxF\b/`h")
ITM_Geschenk.Visible = true
ITM_Geschenk.Media = IMG_Geschenk0
ITM_Geschenk.Icon = IMG_IcoGeschenk
ITM_Geschenk.Commands = {
  ITM_Auspacken = Wherigo.ZCommand({
    Text = _yhK5("\027\b+yF\002RI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Geschenk.Commands.ITM_Auspacken.Custom = true
ITM_Geschenk.Commands.ITM_Auspacken.Id = "ea39e836-3bbc-40a5-b910-bb335a61bc43"
ITM_Geschenk.Commands.ITM_Auspacken.WorksWithAll = true
ITM_Geschenk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Geschenk.Locked = false
ITM_Geschenk.Opened = false
ITM_CoCaOra = Wherigo.ZItem(_Ftnpx)
ITM_CoCaOra.Id = "b7ee65aa-d439-4810-8229-cadd8dfe10d2"
ITM_CoCaOra.Name = _yhK5("{\v+\v`I@RFW`I(1I+(?WFRIx+")
ITM_CoCaOra.Description = _yhK5("\ai\vx\v}\020\014\\6\020\014\\69\b@R`PIW`B(\"z\020\014\\6\020\014\\6lFIJ\vDRI\v`I@B(mI\v++(JI\b`I(+\002J}@(PF+(i}WDI@(yF++\vIW`h")
ITM_CoCaOra.Visible = true
ITM_CoCaOra.Media = IMG_CoCaEmilio
ITM_CoCaOra.Icon = IMG_IcoCodeCard
ITM_CoCaOra.Commands = {
  BTN_CoCaOra = Wherigo.ZCommand({
    Text = _yhK5("\001}1I(F@YI\vDI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_CoCaOra.Commands.BTN_CoCaOra.Custom = true
ITM_CoCaOra.Commands.BTN_CoCaOra.Id = "2d64d495-f879-4336-afdc-010c89f22850"
ITM_CoCaOra.Commands.BTN_CoCaOra.WorksWithAll = true
ITM_CoCaOra.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_CoCaOra.Locked = false
ITM_CoCaOra.Opened = false
ITM_Weihnachtskarte = Wherigo.ZItem(_Ftnpx)
ITM_Weihnachtskarte.Id = "0e780a12-370b-424c-9d4d-005db087b79e"
ITM_Weihnachtskarte.Name = _yhK5("mI\vJ@F\002J`+RFW`I")
ITM_Weihnachtskarte.Description = _yhK5(")\vI(\127FW`I(F\b+(1Ii(\028I+\002JI@RIRFW`}@h")
ITM_Weihnachtskarte.Visible = true
ITM_Weihnachtskarte.Media = IMG_Weih08
ITM_Weihnachtskarte.Icon = IMG_IcoWeihKa
ITM_Weihnachtskarte.Commands = {
  BTM_WeihKaLesen = Wherigo.ZCommand({
    Text = _yhK5("]I+I@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_Weihnachtskarte.Commands.BTM_WeihKaLesen.Custom = true
ITM_Weihnachtskarte.Commands.BTM_WeihKaLesen.Id = "cb023b3c-cb9d-430f-a0b3-cfac0ee9d698"
ITM_Weihnachtskarte.Commands.BTM_WeihKaLesen.WorksWithAll = true
ITM_Weihnachtskarte.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_Weihnachtskarte.Locked = false
ITM_Weihnachtskarte.Opened = false
ITM_CoCaBib = Wherigo.ZItem(_Ftnpx)
ITM_CoCaBib.Id = "32128e2d-823d-4166-b8c8-3a01f54d2643"
ITM_CoCaBib.Name = _yhK5("{\v+\v`I@RFW`I(1IW(\014\v/x\v}`JIRFW+")
ITM_CoCaBib.Description = _yhK5("\014\v/x\v}`JIRFW\020\014\\6\020\014\\69\b@R`PIW`B(\"z\020\014\\6\020\014\\6lFIJ\vDRI\v`I@B(mI\v++(AI\vDI@I@(\027@DF/I@(Y\b\t}xDI\017(iIJW(Fx+(\028}}DxI(\b@1(\t\b@R`\v}@\vIW`(+}DFW(}\t\tx\v@Ih")
ITM_CoCaBib.Visible = true
ITM_CoCaBib.Media = IMG_CoCaBib
ITM_CoCaBib.Icon = IMG_IcoCodeCard
ITM_CoCaBib.Commands = {
  BTN_CoCaBib = Wherigo.ZCommand({
    Text = _yhK5("\001}1I(F@YI\vDI@"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  }),
  BTN_CoCaBibNehmen = Wherigo.ZCommand({
    Text = _yhK5("8IJiI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_CoCaBib.Commands.BTN_CoCaBib.Custom = true
ITM_CoCaBib.Commands.BTN_CoCaBib.Id = "4631425e-1665-4756-a58c-1dff44e21277"
ITM_CoCaBib.Commands.BTN_CoCaBib.WorksWithAll = true
ITM_CoCaBib.Commands.BTN_CoCaBibNehmen.Custom = true
ITM_CoCaBib.Commands.BTN_CoCaBibNehmen.Id = "8c7a677a-29c9-413b-be13-763b9c994ae7"
ITM_CoCaBib.Commands.BTN_CoCaBibNehmen.WorksWithAll = true
ITM_CoCaBib.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_CoCaBib.Locked = false
ITM_CoCaBib.Opened = false
ITM_CoCaSpinne = Wherigo.ZItem(_Ftnpx)
ITM_CoCaSpinne.Id = "bf6fb366-2828-4102-a6d6-b377dbacf54e"
ITM_CoCaSpinne.Name = _yhK5("{\v+\v`I@RFW`I(1IW(\003y\v@@I")
ITM_CoCaSpinne.Description = _yhK5("\003y\v@@I\020\014\\6\020\014\\69\b@R`PIW`B(j\020\014\\6\020\014\\6lFIJ\vDRI\v`I@B(\003\vI(\v+`(D\v\t`\vD:(+}xx`I(iF@(Y\bi\v@1I+`(wIWi\b`I@:(+}(P\vI(+\vI(F\b++\vIJ`h")
ITM_CoCaSpinne.Visible = true
ITM_CoCaSpinne.Media = IMG_CoCaSpinne
ITM_CoCaSpinne.Icon = IMG_IcoCodeCard
ITM_CoCaSpinne.Commands = {
  BTN_CoCaSpinne = Wherigo.ZCommand({
    Text = _yhK5("\001}1I(F@YI\vDI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_CoCaSpinne.Commands.BTN_CoCaSpinne.Custom = true
ITM_CoCaSpinne.Commands.BTN_CoCaSpinne.Id = "2ee30d51-1841-498a-9bb1-da96502020af"
ITM_CoCaSpinne.Commands.BTN_CoCaSpinne.WorksWithAll = true
ITM_CoCaSpinne.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_CoCaSpinne.Locked = false
ITM_CoCaSpinne.Opened = false
ITM_CoCaPiraten = Wherigo.ZItem(_Ftnpx)
ITM_CoCaPiraten.Id = "3a72108b-62bb-4f54-95af-947425d8fc1e"
ITM_CoCaPiraten.Name = _yhK5("{\v+\v`I@RFW`I(1IW(9\vWF`I@")
ITM_CoCaPiraten.Description = _yhK5("9\vWF`I@\020\014\\6\020\014\\69\b@R`PIW`B(,\020\014\\6\020\014\\6lFIJ\vDRI\v`I@B(\003\vI(+y\v@@I@(\003IIiF@@+DFW@(}J@I(\a@1Ih(\027\b\t(I\v@Ii(\003\002J\v\t\t(JF`(iF@(+\vI(LI1}\002J(@}\002J(@\vI(DI+IJI@h")
ITM_CoCaPiraten.Visible = true
ITM_CoCaPiraten.Media = IMG_CoCaPiraten
ITM_CoCaPiraten.Icon = IMG_IcoCodeCard
ITM_CoCaPiraten.Commands = {
  BTN_CoCaPiraten = Wherigo.ZCommand({
    Text = _yhK5("\001}1I(F@YI\vDI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_CoCaPiraten.Commands.BTN_CoCaPiraten.Custom = true
ITM_CoCaPiraten.Commands.BTN_CoCaPiraten.Id = "91c21ae6-da9f-4b1b-bc1e-1c7facfba686"
ITM_CoCaPiraten.Commands.BTN_CoCaPiraten.WorksWithAll = true
ITM_CoCaPiraten.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_CoCaPiraten.Locked = false
ITM_CoCaPiraten.Opened = false
ITM_CoCaFM = Wherigo.ZItem(_Ftnpx)
ITM_CoCaFM.Id = "f148225e-b483-4906-b9b2-e55a5afdc079"
ITM_CoCaFM.Name = _yhK5("{\v+\v`I@RFW`I(1IW(lxI1IWiF\b+")
ITM_CoCaFM.Description = _yhK5("lxI1IWiF\b+\020\014\\6\020\014\\69\b@R`PIW`B(-\020\014\\6\020\014\\6lFIJ\vDRI\v`I@B({IW+`IJ`(+\v\002J(yW\viF(i\v`(\003RIxI``I@h")
ITM_CoCaFM.Visible = true
ITM_CoCaFM.Media = IMG_CoCaFledermaus
ITM_CoCaFM.Icon = IMG_IcoCodeCard
ITM_CoCaFM.Commands = {
  BTN_CoCaFM = Wherigo.ZCommand({
    Text = _yhK5("\001}1I(F@YI\vDI@"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _yhK5("8\v\002J`(wIW\t\bD/FW")
  })
}
ITM_CoCaFM.Commands.BTN_CoCaFM.Custom = true
ITM_CoCaFM.Commands.BTN_CoCaFM.Id = "521bf1ee-3c1c-4a0b-8c5b-6de5758933e3"
ITM_CoCaFM.Commands.BTN_CoCaFM.WorksWithAll = true
ITM_CoCaFM.ObjectLocation = Wherigo.INVALID_ZONEPOINT
ITM_CoCaFM.Locked = false
ITM_CoCaFM.Opened = false
T_Kunitz = Wherigo.ZTask(_Ftnpx)
T_Kunitz.Id = "a3bcbd8f-25fe-4036-b808-564e7b86d13a"
T_Kunitz.Name = _yhK5("\127\b@\v`Y")
T_Kunitz.Description = _yhK5("\028IJI(@F\002J(\127\b@\v`Yh(\014ID\v/()\v\002J(1\vWIR`(1}W`J\v@h(\028IJI(@\v\002J`(Fi(\014F@RF\b`}iF`I@(w}W/I\vh([\vIJI(RI\v@I(,zz(\a\bW}(I\v@h")
T_Kunitz.Visible = true
T_Kunitz.Active = true
T_Kunitz.Complete = false
T_Kunitz.CorrectState = "None"
T_NachOben = Wherigo.ZTask(_Ftnpx)
T_NachOben.Id = "26ea7fa0-ba7a-4796-944e-46c0106c95bc"
T_NachOben.Name = _yhK5("8F\002J(}/I@")
T_NachOben.Description = _yhK5("Z\127\b@\v`Y/\bWDZ(xF\b`I`(1\vI(\\\v\002J`\b@D:(DW}/(DI+yW}\002JI@h(mF+(DI@F\b()\b(1}W`(P\vxx+`:(PI\v++`()\b(@\v\002J`:(F/IW(iFx(IJWx\v\002J:(PFW(1F+(/\v+JIW(LIiFx+(F@1IW+S")
T_NachOben.Visible = true
T_NachOben.Active = false
T_NachOben.Complete = false
T_NachOben.CorrectState = "None"
T_Schrumpfkur = Wherigo.ZTask(_Ftnpx)
T_Schrumpfkur.Id = "04ee8a57-23bf-4425-b576-906b3a56c71c"
T_Schrumpfkur.Name = _yhK5("\003\002JW\biy\tR\bW")
T_Schrumpfkur.Description = _yhK5("\014W\v@DI(1F+(W\vI+\vDI(\014\b\002J(1IW(\014\v/x\v}`JIR(P\vI1IW(F\b\t(?W\vD\v@FxDW}I++Ih")
T_Schrumpfkur.Visible = true
T_Schrumpfkur.Active = false
T_Schrumpfkur.Complete = false
T_Schrumpfkur.CorrectState = "None"
T_Foto = Wherigo.ZTask(_Ftnpx)
T_Foto.Id = "870e1487-9d56-4710-a08c-65bc2fa8a3cb"
T_Foto.Name = _yhK5("l}`}")
T_Foto.Description = _yhK5("ti(1I@(\027\b+PI\v+(Y\b(IWJFx`I@(/I@}I`\vD+`()\b(I\v@(l}`}h(oF\002J(I\v@I+(\b@1(/W\v@DI(I+(1Ii(\014\v/x\v}`JIRFWh")
T_Foto.Visible = true
T_Foto.Active = false
T_Foto.Complete = false
T_Foto.CorrectState = "None"
T_Zeitsprung = Wherigo.ZTask(_Ftnpx)
T_Zeitsprung.Id = "a6f0ae04-25c7-4c78-92b3-440e955bc1d1"
T_Zeitsprung.Name = _yhK5("[I\v`+yW\b@D")
T_Zeitsprung.Description = _yhK5("\127IJWI(Y\bW\bI\002R(\v@(1\vI(@}WiFxI([I\v`h")
T_Zeitsprung.Visible = true
T_Zeitsprung.Active = false
T_Zeitsprung.Complete = false
T_Zeitsprung.CorrectState = "None"
T_Orakel = Wherigo.ZTask(_Ftnpx)
T_Orakel.Id = "cc0e5753-34a7-474c-b698-322a0a94a9c6"
T_Orakel.Name = _yhK5("?WFRIx")
T_Orakel.Description = _yhK5("l\v@1I(1F+(?WFRIx(\b@1(/W\v@DI(I+(1FY\b:()\vW(/I\vi(]I+I@(1I+()}R\biI@`+(Y\b(JIx\tI@h")
T_Orakel.Visible = true
T_Orakel.Active = false
T_Orakel.Complete = false
T_Orakel.CorrectState = "None"
T_Amulett = Wherigo.ZTask(_Ftnpx)
T_Amulett.Id = "1758a003-e19d-4fcd-83c3-a534acb7763c"
T_Amulett.Name = _yhK5("\027i\bxI``")
T_Amulett.Description = _yhK5("\014I+}WDI(I\v@(\027i\bxI``h")
T_Amulett.Visible = true
T_Amulett.Active = false
T_Amulett.Complete = false
T_Amulett.CorrectState = "None"
T_Kopftuch = Wherigo.ZTask(_Ftnpx)
T_Kopftuch.Id = "7f988c9f-11a5-4091-ae49-9f8a4d538c58"
T_Kopftuch.Name = _yhK5("\127}y\t`\b\002J")
T_Kopftuch.Description = _yhK5("\014I+}WDI(I\v@(/\b@`I+(\127}y\t`\b\002Jh")
T_Kopftuch.Visible = true
T_Kopftuch.Active = false
T_Kopftuch.Complete = false
T_Kopftuch.CorrectState = "None"
T_Begleiter = Wherigo.ZTask(_Ftnpx)
T_Begleiter.Id = "7a9ae467-8e83-4b7b-a4a4-84e15182c427"
T_Begleiter.Name = _yhK5("\014IDxI\v`IW")
T_Begleiter.Description = _yhK5("\014W\v@DI(I\v@I(\127F`YI:(I\v@I@(9FyFDI\v(}1IW(I\v@I(lxI1IWiF\b+(Y\bi(?WFRIxh")
T_Begleiter.Visible = true
T_Begleiter.Active = false
T_Begleiter.Complete = false
T_Begleiter.CorrectState = "None"
T_Hellsehen = Wherigo.ZTask(_Ftnpx)
T_Hellsehen.Id = "63da1c9d-5712-40f9-8665-2c9110d1adee"
T_Hellsehen.Name = _yhK5("sIxx+IJI@")
T_Hellsehen.Description = _yhK5("\014W\v@DI(\ai\vx\v}(I\v@(\127}y\t`\b\002J:(I\v@(\027i\bxI``:(I\v@I(\127W\v+`FxxR\bDIx(\b@1(I\v@I@(`\vIW\v+\002JI@(\014IDxI\v`IWh")
T_Hellsehen.Visible = true
T_Hellsehen.Active = false
T_Hellsehen.Complete = false
T_Hellsehen.CorrectState = "None"
T_Uebersetzung = Wherigo.ZTask(_Ftnpx)
T_Uebersetzung.Id = "139e3877-53eb-438c-a195-c4320f55fc1f"
T_Uebersetzung.Name = _yhK5("tI/IW+I`Y\b@D")
T_Uebersetzung.Description = _yhK5("l\v@1I(JIWF\b+:(PF+(\v@(1Ii()}R\biI@`(DI+\002JW\vI/I@(+`IJ`h")
T_Uebersetzung.Visible = true
T_Uebersetzung.Active = false
T_Uebersetzung.Complete = false
T_Uebersetzung.CorrectState = "None"
T_Nekramora = Wherigo.ZTask(_Ftnpx)
T_Nekramora.Id = "78315fdb-7c3b-4bcc-a426-338e0cea8b31"
T_Nekramora.Name = _yhK5("8IRWFi}WF")
T_Nekramora.Description = _yhK5("\014I+}WDI(I\v@(\022I\vx(w}@(8IRWFi}WFh")
T_Nekramora.Visible = true
T_Nekramora.Active = false
T_Nekramora.Complete = false
T_Nekramora.CorrectState = "None"
T_Piraten1 = Wherigo.ZTask(_Ftnpx)
T_Piraten1.Id = "9fa10f65-65ee-4568-be32-482ce5d3def3"
T_Piraten1.Name = _yhK5("9\vWF`I@(#")
T_Piraten1.Description = _yhK5("\003yW\v\002J(i\v`(1I@(9\vWF`I@")
T_Piraten1.Visible = true
T_Piraten1.Active = false
T_Piraten1.Complete = false
T_Piraten1.CorrectState = "None"
T_Troll = Wherigo.ZTask(_Ftnpx)
T_Troll.Id = "b58a320c-4cc8-42d9-8291-7417c828fb01"
T_Troll.Name = _yhK5("\022W}xx")
T_Troll.Description = _yhK5("lF@DI(1I@(\022W}xx(I\v@(\b@1(+FD(1Ii(s\bIJ@\002JI@(\014I+\002JI\v1:(PI@@(I+(IWxI1\vD`(\v+`h")
T_Troll.Visible = true
T_Troll.Active = false
T_Troll.Complete = false
T_Troll.CorrectState = "None"
T_Skelett = Wherigo.ZTask(_Ftnpx)
T_Skelett.Id = "a1b4460d-ce22-47e4-8188-52228b758a9b"
T_Skelett.Name = _yhK5("\003RIxI``")
T_Skelett.Description = _yhK5("\014I+}WDI(I\v@(\022I\vx(I\v@I+(\003RIxI``+h")
T_Skelett.Visible = true
T_Skelett.Active = false
T_Skelett.Complete = false
T_Skelett.CorrectState = "None"
T_Feuer = Wherigo.ZTask(_Ftnpx)
T_Feuer.Id = "9df36746-41f5-47f8-8b51-c9810ac1116a"
T_Feuer.Name = _yhK5("lI\bIW")
T_Feuer.Description = _yhK5("{IW/\v@1I(1\vI(/I\v1I@(\022I\vxI(w}@(8IRWFi}WF(\b@1(\vJWI@(\003RIxI``I@(\b@1(wIW/WI@@I(+\vI(DIiI\v@+Fi(\v@(I\v@Ii(iFI\002J`\vDI@()WF\002JI@\tI\bIWh")
T_Feuer.Visible = true
T_Feuer.Active = false
T_Feuer.Complete = false
T_Feuer.CorrectState = "None"
T_Piraten2 = Wherigo.ZTask(_Ftnpx)
T_Piraten2.Id = "f8a00a7f-f8b3-4c10-9e2d-e91e51398887"
T_Piraten2.Name = _yhK5("9\vWF`I@(##")
T_Piraten2.Description = _yhK5("\014IW\v\002J`I(1I@(9\vWF`I@(w}@()I\v@Ii(\aW\t}xDh")
T_Piraten2.Visible = true
T_Piraten2.Active = false
T_Piraten2.Complete = false
T_Piraten2.CorrectState = "None"
T_Belohnung = Wherigo.ZTask(_Ftnpx)
T_Belohnung.Id = "b64cc353-2c86-44d6-81b8-edcb0b242068"
T_Belohnung.Name = _yhK5("\014Ix}J@\b@D")
T_Belohnung.Description = _yhK5("\028I+\002JF\t\t`h(\a@1x\v\002J(9\vWF`(+I\v@h(t@1(I\v@I(\014Ix}J@\b@D(DF/(I+(}/I@1WF\b\th(\028IJ(\b@1(J}x(+\vI()\vWh")
T_Belohnung.Visible = true
T_Belohnung.Active = false
T_Belohnung.Complete = false
T_Belohnung.CorrectState = "None"
T_Kristallkugel = Wherigo.ZTask(_Ftnpx)
T_Kristallkugel.Id = "0252d5f8-02ce-458c-82d0-47f99c35fbcb"
T_Kristallkugel.Name = _yhK5("\127W\v+`FxxR\bDIx")
T_Kristallkugel.Description = _yhK5("\014I+}WDI(I\v@I(\127W\v+`FxxR\bDIxh")
T_Kristallkugel.Visible = true
T_Kristallkugel.Active = false
T_Kristallkugel.Complete = false
T_Kristallkugel.CorrectState = "None"
V_TempInt = 0
V_InventarEingabe = ""
V_StoryLine = 0
V_BibStatus = 0
V_PiratenStatus = 0
V_SchatzStatus = 0
V_FarbStatus = 0
V_FMausStatus = 0
V_TaschenuhrZeit = 0
V_TempStr = ""
V_TempStr2 = ""
V_BakFMZoneAktiv = true
V_SchmiedStatus = 0
V_NachtStatus = 0
V_KugelStatus = 0
V_LolliCounter = 0
V_LolliHilfeStatus = 0
V_KochenCounter = 0
V_EasyMode = 0
V_DtNotiz = 0
V_DtLolli = 0
V_HeuteIstWeihnachten = false
V_StatWert = 0
V_StatAnzahl = 0
V_FlyerGelesen = false
V_EinsiedeleiStatus = 0
_sjq = _yhK5("[b\127\b@\v`Y")
_DQB89 = _yhK5("9b\\FI/I")
_c7M = _yhK5("#\022ob]F`IW@I")
_RbgXh = _yhK5("\022b\127\b@\v`Y")
_dXo9 = _yhK5("#89b)/D\003`FW`y\b@R`")
_aEu = _yhK5("\022o\\bs\b@DIW")
_Ftnpx.ZVariables = {
  V_TempInt = 0,
  V_InventarEingabe = "",
  V_StoryLine = 0,
  V_BibStatus = 0,
  V_PiratenStatus = 0,
  V_SchatzStatus = 0,
  V_FarbStatus = 0,
  V_FMausStatus = 0,
  V_TaschenuhrZeit = 0,
  V_TempStr = "",
  V_TempStr2 = "",
  V_BakFMZoneAktiv = true,
  V_SchmiedStatus = 0,
  V_NachtStatus = 0,
  V_KugelStatus = 0,
  V_LolliCounter = 0,
  V_LolliHilfeStatus = 0,
  V_KochenCounter = 0,
  V_EasyMode = 0,
  V_DtNotiz = 0,
  V_DtLolli = 0,
  V_HeuteIstWeihnachten = false,
  V_StatWert = 0,
  V_StatAnzahl = 0,
  V_FlyerGelesen = false,
  V_EinsiedeleiStatus = 0,
  _sjq = _yhK5("[b\127\b@\v`Y"),
  _DQB89 = _yhK5("9b\\FI/I"),
  _c7M = _yhK5("#\022ob]F`IW@I"),
  _RbgXh = _yhK5("\022b\127\b@\v`Y"),
  _dXo9 = _yhK5("#89b)/D\003`FW`y\b@R`"),
  _aEu = _yhK5("\022o\\bs\b@DIW")
}
TMR_Hunger = Wherigo.ZTimer(_Ftnpx)
TMR_Hunger.Id = "d142ea89-f51d-43ce-abae-f7f7428c0ff5"
TMR_Hunger.Name = _yhK5("s\b@DIW")
TMR_Hunger.Description = ""
TMR_Hunger.Visible = true
TMR_Hunger.Duration = 15
TMR_Hunger.Type = "Interval"
TMR_SkelettDraussen = Wherigo.ZTimer(_Ftnpx)
TMR_SkelettDraussen.Id = "ba95776f-0840-4377-9fec-0203815a861e"
TMR_SkelettDraussen.Name = _yhK5("\003RIxI``)WF\b++I@")
TMR_SkelettDraussen.Description = ""
TMR_SkelettDraussen.Visible = true
TMR_SkelettDraussen.Duration = 10
TMR_SkelettDraussen.Type = "Countdown"
TMR_SkelettDrinnen = Wherigo.ZTimer(_Ftnpx)
TMR_SkelettDrinnen.Id = "cfc2e5f2-d5f4-403e-a90d-ebceee2bdc93"
TMR_SkelettDrinnen.Name = _yhK5("\003RIxI``)W\v@@I@")
TMR_SkelettDrinnen.Description = ""
TMR_SkelettDrinnen.Visible = true
TMR_SkelettDrinnen.Duration = 5
TMR_SkelettDrinnen.Type = "Countdown"
TMR_NachtAus = Wherigo.ZTimer(_Ftnpx)
TMR_NachtAus.Id = "237f108f-5b15-4fdf-b63f-0c831a733be4"
TMR_NachtAus.Name = _yhK5("8F\002J`\027\b+")
TMR_NachtAus.Description = _yhK5("\027\b\t(\"z(i\v@(DI+I`Y`(\b@1(1Fi\v`(yWFR`\v+\002J(\b@P\vWR+Fih(mFW(@\bW(xF+`\vDh")
TMR_NachtAus.Visible = true
TMR_NachtAus.Duration = 600
TMR_NachtAus.Type = "Countdown"
TMR_HlpLollis = Wherigo.ZTimer(_Ftnpx)
TMR_HlpLollis.Id = "d6fa2ed4-68e7-41a6-9f92-71ceb942626b"
TMR_HlpLollis.Name = _yhK5("sxy]}xx\v+")
TMR_HlpLollis.Description = _yhK5("s\vx\tI(\t\bW(]}xx\v!\003\b\002JI")
TMR_HlpLollis.Visible = true
TMR_HlpLollis.Duration = 120
TMR_HlpLollis.Type = "Countdown"
_srCZ = Wherigo.ZTimer(_Ftnpx)
_srCZ.Id = "56668389-a4b1-4d9b-a516-cd38a8341f6a"
_srCZ.Name = _yhK5("sxyli")
_srCZ.Description = _yhK5("s\vx\tI(\t\bW(lxI1IWiF\b+!\003\b\002JI")
_srCZ.Visible = true
_srCZ.Duration = 300
_srCZ.Type = "Countdown"
INP_DbgStartpunkt = Wherigo.ZInput(_Ftnpx)
INP_DbgStartpunkt.Id = "d3b30efb-7287-4440-9c68-19e2320fd80a"
INP_DbgStartpunkt.Name = _yhK5(")/D\003`FW`y\b@R`")
INP_DbgStartpunkt.Description = ""
INP_DbgStartpunkt.Visible = true
INP_DbgStartpunkt.Choices = {
  "BA2",
  "BA4",
  "BA8",
  "Nacht",
  "Emilio liest",
  "vor Feuer",
  "Final"
}
INP_DbgStartpunkt.InputType = "MultipleChoice"
INP_DbgStartpunkt.Text = _yhK5("\003`FW`y\b@R`(PFIJxI@")
INP_Buecherliste = Wherigo.ZInput(_Ftnpx)
INP_Buecherliste.Id = "b7c1041e-836b-4fbb-8a4b-90c7e961d6fc"
INP_Buecherliste.Name = _yhK5("\014\bI\002JIWx\v+`I")
INP_Buecherliste.Description = ""
INP_Buecherliste.Visible = true
INP_Buecherliste.Choices = {
  "Fledermaeuse von A bis Z",
  "Hellsehen fuer Anfaenger",
  "Lottozahlen sicher vorhersagen",
  "Geschichte der Pyramiden",
  "Wie werde ich Pirat?",
  "Gute Nachtgeschichten",
  "Die Legende vom Goldschmied"
}
INP_Buecherliste.InputType = "MultipleChoice"
INP_Buecherliste.Text = _yhK5("#\002J(JF/I(\t}xDI@1I(\014\bI\002JIW(i}iI@`F@(/I\v(i\vWh(\003\b\002J()\vW(F\b+:(PIx\002JI+()\b(xI+I@(i}I\002J`I+`h")
INP_Troll = Wherigo.ZInput(_Ftnpx)
INP_Troll.Id = "f5de9df2-bb96-4f1d-a766-6a36ac240880"
INP_Troll.Name = _yhK5("\022W}xx")
INP_Troll.Description = ""
INP_Troll.Visible = true
INP_Troll.Media = IMG_Spieler
INP_Troll.InputType = "Text"
INP_Troll.Text = _yhK5(")\b(+FD+`B")
INP_VorOrtCheck = Wherigo.ZInput(_Ftnpx)
INP_VorOrtCheck.Id = "c55344df-a5b1-48e3-b1f6-7d7bf262344c"
INP_VorOrtCheck.Name = _yhK5("{}W?W`\001JI\002R")
INP_VorOrtCheck.Description = ""
INP_VorOrtCheck.Visible = true
INP_VorOrtCheck.Media = IMG_Spieler
INP_VorOrtCheck.InputType = "Text"
INP_VorOrtCheck.Text = _yhK5("\127xFW(RF@@(\v\002J(1F+B")
INP_Schatzkiste = Wherigo.ZInput(_Ftnpx)
INP_Schatzkiste.Id = "6950a5cb-ac50-4d6f-ab68-f65dae571f0c"
INP_Schatzkiste.Name = _yhK5("\003\002JF`YR\v+`I")
INP_Schatzkiste.Description = ""
INP_Schatzkiste.Visible = true
INP_Schatzkiste.Choices = {
  "jede Menge Goldmuenzen",
  "den heiligen Gral",
  "ein Anhaenger",
  "die Blaue Mauritius",
  "eine Taschenuhr"
}
INP_Schatzkiste.InputType = "MultipleChoice"
INP_Schatzkiste.Text = _yhK5("mIx\002JI+(\022I\vx(i}I\002J`I+`()\b(@IJiI@S")
INP_Uhrzeit = Wherigo.ZInput(_Ftnpx)
INP_Uhrzeit.Id = "b04db087-73d9-4d78-b649-9c84e3b183aa"
INP_Uhrzeit.Name = _yhK5("tJWYI\v`")
INP_Uhrzeit.Description = ""
INP_Uhrzeit.Visible = true
INP_Uhrzeit.InputType = "Text"
INP_Uhrzeit.Text = _yhK5("mIx\002JI([FJx(JF+`()\b(I\v@DI+`Ixx`:(/Iw}W()\b(F\b\t(1I@(\127@}y\t(DI1W\bI\002R`(JF+`S")
INP_NachtEnde = Wherigo.ZInput(_Ftnpx)
INP_NachtEnde.Id = "3994e5f8-37d5-4b04-b2e4-928f7dd4eca8"
INP_NachtEnde.Name = _yhK5("8F\002J`\a@1I")
INP_NachtEnde.Description = ""
INP_NachtEnde.Visible = true
INP_NachtEnde.InputType = "Text"
INP_NachtEnde.Text = _yhK5("\028\b`:(Fx+}(1F+(1W\v``I(m}W`(\v@(1IW(w}WxI`Y`I@([I\vxIh")
INP_Wegweiser = Wherigo.ZInput(_Ftnpx)
INP_Wegweiser.Id = "2e1ff1cc-fb4c-433a-b5b9-7b0878beca70"
INP_Wegweiser.Name = _yhK5("mIDPI\v+IW")
INP_Wegweiser.Description = ""
INP_Wegweiser.Visible = true
INP_Wegweiser.Media = IMG_Wegweiser
INP_Wegweiser.InputType = "Text"
INP_Wegweiser.Text = _yhK5("s\vIW(\v+`(1\vI(\001}1I!]\v+`I(1IW(/I@}I`\vD`I@(\014\b\002J+`F/I@B(\001\"!\015(r@/+yO\027,!,()\"!0(\014,!,(\a\"!%")
INP_FinalHint = Wherigo.ZInput(_Ftnpx)
INP_FinalHint.Id = "8a9f545a-f603-4d54-a331-c562487e879d"
INP_FinalHint.Name = _yhK5("l\v@Fx!s\v@`")
INP_FinalHint.Description = ""
INP_FinalHint.Visible = true
INP_FinalHint.Media = IMG_Raebe02
INP_FinalHint.Choices = {
  "Zeig Sie mir.",
  "War nur ein Scherz, schlaf weiter."
}
INP_FinalHint.InputType = "MultipleChoice"
INP_FinalHint.Text = _yhK5("\003}xx(\v\002J(\003\vI()\vW(YI\vDI@:(}1IW(P\vxx+`()\b(1}\002J(x\vI/IW(+Ix/+`(PI\v`IW(+\b\002JI@S")
INP_UnlockCode = Wherigo.ZInput(_Ftnpx)
INP_UnlockCode.Id = "7d10f654-1fa4-46d3-b4dd-267db2eeb432"
INP_UnlockCode.Name = _yhK5("t@x}\002R\001}1I")
INP_UnlockCode.Description = ""
INP_UnlockCode.Visible = true
INP_UnlockCode.Media = IMG_Spieler
INP_UnlockCode.InputType = "Text"
INP_UnlockCode.Text = _yhK5("s\vIW(+`IJ`B")
INP_Spinne1 = Wherigo.ZInput(_Ftnpx)
INP_Spinne1.Id = "da38e7f0-b97b-4f5c-a036-55fed6d6acb8"
INP_Spinne1.Name = _yhK5("\003y\v@@I\"")
INP_Spinne1.Description = ""
INP_Spinne1.Visible = true
INP_Spinne1.Media = IMG_SpinneR1
INP_Spinne1.Choices = {
  "Ich habe eine Laterne ...",
  "Ich habe einen Troll ...",
  "Ich bin bald ein Pirat ...",
  "Ich hasse Spinnen ...",
  "Ich bin muede."
}
INP_Spinne1.InputType = "MultipleChoice"
INP_Spinne1.Text = ""
INP_Spinne2 = Wherigo.ZInput(_Ftnpx)
INP_Spinne2.Id = "835c905c-1e5a-4144-8179-f8cee9f558dc"
INP_Spinne2.Name = _yhK5("\003y\v@@I,")
INP_Spinne2.Description = ""
INP_Spinne2.Visible = true
INP_Spinne2.Media = IMG_SpinneR2
INP_Spinne2.Choices = {
  "Ich habe einen Troll ...",
  "Ich habe einen Ast ...",
  "Ich bin ein Rabe ...",
  "Ich hasse Spinnen ...",
  "Ich bin muede."
}
INP_Spinne2.InputType = "MultipleChoice"
INP_Spinne2.Text = ""
INP_Spinne3 = Wherigo.ZInput(_Ftnpx)
INP_Spinne3.Id = "e0b009ce-dd67-4f38-a4c4-db8e7123585f"
INP_Spinne3.Name = _yhK5("\003y\v@@Ij")
INP_Spinne3.Description = ""
INP_Spinne3.Visible = true
INP_Spinne3.Media = IMG_SpinneR3
INP_Spinne3.Choices = {
  "Ich habe einen Troll ...",
  "Ich kenne einen Drachen ...",
  "Ich kann die Zeit manipulieren ...",
  "Ich kenne einen Bibliothekar ...",
  "Ich bin muede."
}
INP_Spinne3.InputType = "MultipleChoice"
INP_Spinne3.Text = ""
INP_Spinne4 = Wherigo.ZInput(_Ftnpx)
INP_Spinne4.Id = "59ec72e4-4702-490c-9d47-68af7c47af0d"
INP_Spinne4.Name = _yhK5("\003y\v@@I\025")
INP_Spinne4.Description = ""
INP_Spinne4.Visible = true
INP_Spinne4.Media = IMG_SpinneR4
INP_Spinne4.Choices = {
  "Ich kenne einen Bibliothekar ...",
  "Ich habe einen Troll ...",
  "Ich hasse Spinnen ...",
  "Ich habe eine Laterne ...",
  "Ich bin muede."
}
INP_Spinne4.InputType = "MultipleChoice"
INP_Spinne4.Text = ""
INP_ModusFestlegen = Wherigo.ZInput(_Ftnpx)
INP_ModusFestlegen.Id = "82f6edfa-86e7-4d9b-b6a3-c05451b72a2b"
INP_ModusFestlegen.Name = _yhK5("o}1\b+lI+`xIDI@")
INP_ModusFestlegen.Description = ""
INP_ModusFestlegen.Visible = true
INP_ModusFestlegen.Media = IMG_Huehnchen
INP_ModusFestlegen.Choices = {
  "Ein wahrer Held natuerlich!",
  "Och, ein Warmduscher?"
}
INP_ModusFestlegen.InputType = "MultipleChoice"
INP_ModusFestlegen.Text = _yhK5(")F+(x\vID`(DF@Y(F@()\vWh(\014\v+`()\b(I\v@(PFJWIW(sIx1(}1IW(I\v@(mFWi1\b+\002JIWS(tI/IWxIDI()\vW()I\v@I(\027@`P}W`(D\b`:(+\vI(I@`+\002JI\v1I`(P\vI()I\v@(PI\v`IWIW(mID(wIWxFI\b\t`h")
INP_WarmDuscherRetry = Wherigo.ZInput(_Ftnpx)
INP_WarmDuscherRetry.Id = "55bec5dd-c920-431a-8715-09931515d36c"
INP_WarmDuscherRetry.Name = _yhK5("mFWi)\b+\002JIW\\I`WU")
INP_WarmDuscherRetry.Description = ""
INP_WarmDuscherRetry.Visible = true
INP_WarmDuscherRetry.Media = IMG_Huehnchen
INP_WarmDuscherRetry.Choices = {
  "Ich bin halt ein Warmduscher.",
  "Ich ueberleg noch mal."
}
INP_WarmDuscherRetry.InputType = "MultipleChoice"
INP_WarmDuscherRetry.Text = _yhK5("\014\v+`()\b()\vW(DF@Y(+\v\002JIWS()\b(P\vW+`(@\v\002J`(1\vI(R}iyxI``I(\028I+\002J\v\002J`I(IW\tFJWI@h()\v@DI(PIW1I@(\tIJxI@:(F/IW()\b(P\vW+`(F\b\002J(+\002J@IxxIW(\tIW`\vD(+I\v@h")
INP_DevToolDrop = Wherigo.ZInput(_Ftnpx)
INP_DevToolDrop.Id = "246a1545-8d99-4be9-8275-05ca21ea3730"
INP_DevToolDrop.Name = _yhK5(")Iw\022}}x)W}y")
INP_DevToolDrop.Description = ""
INP_DevToolDrop.Visible = true
INP_DevToolDrop.Media = IMG_Lollis
INP_DevToolDrop.InputType = "Text"
INP_DevToolDrop.Text = _yhK5("o}I\002J`I+`()\b(1I@(]}xx\v+(I`PF+(i\v``I\vxI@S")
_F7OU = Wherigo.ZInput(_Ftnpx)
_F7OU.Id = "1bd917c4-eb76-4205-8571-fc712169b237"
_F7OU.Name = _yhK5(")/DlxFD\003I`YI@")
_F7OU.Description = ""
_F7OU.Visible = true
_F7OU.Choices = {
  "Easy mode",
  "Weihnachten",
  "Schild gelesen"
}
_F7OU.InputType = "MultipleChoice"
_F7OU.Text = _yhK5("lxFD(+I`YI@")
INP_Geisterfrage = Wherigo.ZInput(_Ftnpx)
INP_Geisterfrage.Id = "3395b8b9-136b-4890-89ba-b29e4650cb20"
INP_Geisterfrage.Name = _yhK5("\028I\v+`IW\tWFDI")
INP_Geisterfrage.Description = ""
INP_Geisterfrage.Visible = true
INP_Geisterfrage.Media = IMG_EinsiedelB08
INP_Geisterfrage.InputType = "Text"
INP_Geisterfrage.Text = _yhK5("8F`\bIWx\v\002J(/\v@(\v\002J(I+h(#\002J(/\v@(hhh")
P_Emilio.Commands._XGo4m.WorksWithList = {
  ITM_Laterne,
  ITM_Ast,
  ITM_Keule,
  ITM_Lollis,
  ITM_LolliFeder,
  ITM_LolliHaar,
  ITM_LolliDreck,
  ITM_Notiz,
  ITM_Amulett,
  ITM_WeissesTuch,
  ITM_BuntesTuch,
  ITM_Dokument,
  ITM_LolliX
}
P_Goldschmied.Commands._mZXP.WorksWithList = {
  ITM_Laterne,
  ITM_Ast,
  ITM_Keule,
  ITM_Lollis,
  ITM_LolliFeder,
  ITM_LolliHaar,
  ITM_LolliDreck,
  ITM_Ringe,
  ITM_BibAusweis,
  ITM_Beeren,
  ITM_Schluessel,
  ITM_Gral,
  ITM_Briefmarke,
  ITM_BuntesTuch,
  ITM_Anhaenger,
  ITM_Muenzen,
  ITM_Uhr,
  ITM_WeissesTuch
}
ITM_Ast.Commands._Rs7S1.WorksWithList = {
  P_Raebe,
  P_Troellchen,
  ITM_Gral
}
ITM_Lollis.Commands._rcTB.WorksWithList = {P_Raebe}
ITM_Buch.Commands._W7hAn.WorksWithList = {P_Troll}
ITM_Buechlein.Commands._Tlyh.WorksWithList = {P_Bibliothekar}
ITM_Amulett.Commands._qFJH.WorksWithList = {ITM_Schatztruhe}
ITM_Gral.Commands._DYufo.WorksWithList = {ITM_Schatztruhe}
ITM_Gral.Commands._VGq_t.WorksWithList = {
  ITM_Beeren,
  ITM_WeissesTuch,
  ITM_Keule,
  ITM_Lollis
}
ITM_Muenzen.Commands._eNmRW.WorksWithList = {ITM_Schatztruhe}
ITM_Briefmarke.Commands._XQgLK.WorksWithList = {ITM_Schatztruhe}
ITM_Foto.Commands._70V.WorksWithList = {P_Bibliothekar}
ITM_Haar.Commands._21c.WorksWithList = {ITM_Keule, ITM_Knochen}
ITM_Uhr.Commands._HcSK.WorksWithList = {ITM_Schatztruhe}
ITM_Anhaenger.Commands._GpSaB.WorksWithList = {ITM_Schatztruhe}
function _Ftnpx:OnStart()
  if _G[_yhK5("\a@w")][_yhK5("9xF`\t}Wi")] == _yhK5("m\v@j,") or _G[_yhK5("\a@w")][_yhK5(")Iw\v\002I#)")] == _yhK5(")I+R`}y") then
    for k, v in pairs(_G[_yhK5("bl`@y3")][_yhK5("\027xx[?/LI\002`+")]) do
      v[_yhK5("{\v+\v/xI")] = false
      v[_yhK5("\027\002`\vwI")] = false
    end
    _G[_yhK5("mJIW\vD}")][_yhK5("\001}iiF@1")](_yhK5("\003FwI\001x}+I"))
    return
  end
  FCT_Start()
end
function _Ftnpx:OnRestore()
end
function Z_Bergauf10:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t\"z")
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("8}\002J(RI\v@I(-z(s}IJI@iI`IW(DI+\002JF\t\t`(\b@1(+\002J}@(+\v`Y`(1IW(\\FI/I(F\b\t(I\v@IW(\014F@Rh(8F(1F+(RF@@(LF(JI\v`IW(PIW1I@h(\027/IW(IW(JF`(\028I+Ixx+\002JF\t`h("),
      Media = IMG_Ba1A
    },
    {
      Text = _yhK5("hhh(\v\002J(JF/(RI\v@I(\027J@\b@D(P}(IW(JIW(RFih(\027\b\t(I\v@iFx(PFW(IW(1Fh(t@1(LI`Y`(`WFiyIx`(IW(J\vIW(yIWiF@I@`(1\bW\002J+(\028I/\bI+\002J(\b@1(@IWw`(FxxI(i\v`(+I\v@Ii(\028I/WF//Ixh(Z[}xx(/IYFJxI@:([}xx(/IYFJxI@:(hhhZ(w}@(i}WDI@+(/\v+(F/I@1+(\b@1(1\bW\002J(1\vI(DF@YI(8F\002J`h(#\002J(PIW1(@}\002J(PFJ@+\v@@\vDh(mF+(1I@@(@\bW(\t\bIW(I\v@I@([}xx(\b@1(PFW\bi(+}xx(\v\002J(1I@(/IYFJxI@S(\014\v``I:(RF@@+`()\b(@\v\002J`(iF\002JI@:(1F++(IW(P\vI1IW(F/JF\b`:(/Iw}W(P\vW(J\vIW(FxxI(\v@(1\vI(\127xFy+i\bIJxI(I\v@DIx\vI\tIW`(PIW1I@S"),
      Media = IMG_Ba1B
    },
    {
      Text = _yhK5("\027x+(1IW(\\FI/I(/IiIWR`:(1F++()\b(F\b\002J(F@DIR}iiI@(/\v+`:(R}ii`(IW(I\v@(\003`\bI\002R(PI\v`(F\b\t()\v\002J(Y\b(\b@1(\tx\bI+`IW`B(Z9+++`h(\a+(DF/(1F(P}Jx(hhh(FIJi(hhh(I\v@I@(\127}xxF`IWFx+\002JF1I@h()IW(\022W}xx(@IWw`(LI`Y`(J\vIWh(#\002J(DxF\b/I:(P\vW(JF/I@(1F(PF+(\v@(?W1@\b@D(Y\b(/W\v@DI@hZ"),
      Media = IMG_Ba1C
    }
  }, function(action)
    V_StoryLine = 5
    T_Troll.Active = true
    ITM_Lollis.Commands._rcTB.Enabled = true
    P_Troellchen:MoveTo(Z_Bergauf10)
  end)
end
function Z_Bergauf20:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t,z")
  if Z_Lollistelle1.Active == false then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Z]F\b\tI@(1F\bIW`(1}\002J(xFI@DIW(Fx+(\tx\vIDI@Z(DW\v@+`()\v\002J(1IW(\\FI/I(F@:(Fx+(IW()\v\002J(F\b\t(1IW(@FI\002J+`I@(\014F@R(IWPFW`I`h(r@/+yO\003I\v@(\014x\v\002R(\t\v3\vIW`(1F/I\v(1I@(\\\b\002R+F\002R:(1I@()\b(F\b\t(1Ii(\\\bI\002RI@(`WFID+`h(Z\003FD(iFx:(\v+`()\vW(I\vDI@`x\v\002J(RxFW:(1F++(1F(9FW`U(\v@()I\v@Ii(\\\b\002R+F\002R(\v+`SZ"),
        Media = IMG_Ba2A
      },
      {
        Text = _yhK5(")\b(JF+`(F\b\002J(+\002J}@(/IiIWR`:(1F++(1IW(\022W}xx(1F(1W\v@@I@(Y\b(`}/I@(/ID}@@I@(JF`(\b@1(/I+\002Jx\vI++`:(1}\002J(iFx(@F\002J(1Ii(\\I\002J`I@(Y\b(+IJI@h()\b(+`Ixx+`(Fx+}(1I@(\\\b\002R+F\002R(F\b\t(1IW(\014F@R(F/(\b@1(}\t\t@I+`(DF@Y(w}W+\v\002J`\vD(1I@(\\I\v++wIW+\002Jx\b++h(\127F\bi(JF+`()\b(1F+(DI`F@:(wIWPF@1Ix`(+\v\002J(1IW(\\\b\002R+F\002R(\v@(I\v@I@({\bxRF@(\b@1(I\v@(]}xx\v!\\IDI@(yWF++Ix`(F\b\t()\v\002J(@\vI1IWh("),
        Media = IMG_Ba2C
      },
      {
        Text = _yhK5("\027x+(1\vI(\aW\by`\v}@(\vJW(\a@1I(DI\t\b@1I@(JF`(\b@1(F\b\002J(\vi(#@@IWI@(1I+({\bxRF@+(P\vI1IW(\\\bJI(I\v@DIRIJW`(\v+`:(/ID\v@@`(1IW(\\FI/I(+}DxI\v\002J(1\vI({IWP\bI+`\b@D(Y\b(/I+I\v`\vDI@:(1\vI(1IW(\022W}xx(F@DIW\v\002J`I`(JF`h()\b(+Ix/+`(+`IJ+`(@}\002J(\viiIW(DF@Y(wIWP\vWW`(\v@(1IW(mIx`DI+\002J\v\002J`I(JIW\bi:(Fx+(1IW(\\FI/I(1\vI(iI\v+`I@(1IW(]}xx\v+(+\002J}@(P\vI1IW(I\v@DI+FiiIx`(JF`h"),
        Media = IMG_Ba2D
      },
      {
        Text = _yhK5(")}\002J(yx}I`Yx\v\002J(\txF``IW`(IW(F\b\t(1\vI(\014F@R(Y\bW\bI\002R(\b@1(+FD`B(Z)\vI(xI`Y`I@(j(JF/I(\v\002J()\vW(\bI/W\vD(DIxF++I@:(+\002Jx\vI++x\v\002J(i}I\002J`I+`()\b(LF(F\b\002J(I\v@I@(\014I\v`WFD(Y\b(\b@+IWIi(\aW\t}xD(DIxI\v+`I`(JF/I@:(}1IWSZ()FWF\b\t(P\v\002RIx`(IW(I\v@I@(1IW(I\v@DI+FiiIx`I@(]}xx\v+(F\b+(1Ii(9Fy\vIW:(+\002J\vI/(\vJ@(+\v\002J(\v@(1I@(\003\002J@F/Ix(\b@1(/I}/F\002J`I`(DI+yF@@`:(PF+()\b(@\b@(`\b+`h"),
        Media = IMG_Ba2B
      }
    }, function(action)
      Z_Lollistelle1.Active = true
      Z_Lollistelle2.Active = true
      Z_Lollistelle3.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function Z_Bergauf30:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\tjz")
  if Player:Contains(ITM_Foto) then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\\FI/I(+\v`Y`(F\b\t(I\v@Ii(\027+`(Fi(mIDI+WF@1(\b@1(IWPFW`I`()\v\002Jh(Z#\002J(DxF\b/I:(1}W`(1W\bI/I@(\v+`(LIiF@1h(]F++(\b@+(1}\002J(iFx(@F\002J+IJI@hZ"),
      Media = IMG_Ba3A,
      Callback = function(action)
        if action ~= nil then
          FCT_HolzzeltBetreten()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\\FI/I(+\v`Y`(F\b\t(I\v@Ii(\027+`(Fi(mIDI+WF@1(\b@1(IWPFW`I`()\v\002Jh(Z\027\b\t(1Ii(s\bIDIx(PFW(I+(P\vWRx\v\002J(+IJW(J\bI/+\002Jh()\b(JFI``I+`(W\bJ\vD(iFx(w}W/I\vR}iiI@(\b@1(I\v@(l}`}(w}@(i\vW(iF\002JI@(R}I@@I@h()\b(P\vW+`(I+(/I+`\vii`(@}\002J(/IWI\bI@:(1F++()\b(1\vI(\028IxIDI@JI\v`(@\v\002J`(DI@\b`Y`(JF+`h(\027/IW(LI`Y`(xF++(\b@+(iFx(1}W`(W\bI/IW(+\002JF\bI@:(\v\002J(DxF\b/I:(1}W`(1W\bI/I@(\v+`(LIiF@1h(Z"),
      Media = IMG_Ba3A,
      Callback = function(action)
        if action ~= nil then
          FCT_HolzzeltBetreten()
        end
      end
    })
  end
end
function Z_Bergauf40:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t\025z")
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\003\002J}@(P\vI1IW(+\v`Y`(1IW(\\FI/I(Fi(\014}1I@(\b@1(PFW`I`(F\b\t()\v\002Jh()\b(/\v+`(DI+yF@@`:(PF+(IW(1\vI+iFx(JF`h"),
      Media = IMG_Ba4A
    },
    {
      Text = _yhK5("\003\002JF\b()\vW(1}\002J(iFx(1\vI+I@(\014F\bi(F@h(\027x+}(PI@@(1IW(@\v\002J`(+yWI\002JI@(RF@@:(1F@@(D\v/`(I+(RI\v@I(+yWI\002JI@1I@(\014FI\biI(\b@1(P\vW(JF/I@(1F+(DI+`IW@(@\bW(DI`WFI\bi`h(#\002J(yW}/\vIW(I+(iFxh\020\014\\6sFxx}}}}\b\b:(JFxx}}}\b\b\b(\014F\biiiS"),
      Media = IMG_Ba4B
    },
    {
      Text = _yhK5("mF+(\v+`(1I@@S(t@1(P}JIW(PI\v++`()\b(\bI/IWJF\by`:(1F++(\v\002J(+yWI\002JI@(RF@@S()F+(JF`()\vW(1}\002J(/I+`\vii`(1\vI+I+(DI+\002JPFI`Y\vDI(?WFRIx(wIWWF`I@h()F+(RF@@(I\v@\tF\002J(RI\v@(\028IJI\vi@\v+(\t\bIW(+\v\002J(/IJFx`I@h"),
      Media = IMG_Ba4D
    },
    {
      Text = _yhK5("8\vIiF@1(JF`(\vWDI@1PF+(wIWWF`I@h(#\002J(RI@@I(i\v\002J(I\v@\tF\002J(F\b+(i\v`(+yWI\002JI@1I@(\014FI\biI@h\020\014\\6\027/IW(hhh(PF+(\v+`(1I@@(1F+(\t\bIW(I\v@(?WFRIx:(w}@(1Ii()\b(1F(DI+yW}\002JI@(JF+`S"),
      Media = IMG_Ba4C
    },
    {
      Text = _yhK5("mF+(\t\bIW(I\v@(?WFRIxS(#\002J(RI@@I(RI\v@(?WFRIxh"),
      Media = IMG_Ba4D
    },
    {
      Text = _yhK5("\127}ii:(R}ii:(R}ii:(LI`Y`(WI1()\v\002J(@\v\002J`(WF\b+:(\v\002J(JF/I(DI@F\b(DIJ}IW`:(1F++()\b(w}@(I\v@Ii(?WFRIx(DI+yW}\002JI@(JF+`h"),
      Media = IMG_Ba4C
    },
    {
      Text = _yhK5("\027\002J(PF+(+}xx\024+h(mI@@(1F+(?WFRIx(`WF`+\002JI@(1FW\t:(1FW\t(\v\002J(I+(F\b\002Jh(\003}xxI@(1}\002J(FxxI(P\v++I@:(1F++(1F(}/I@(I\v@(?WFRIx(P}J@`:(i\vW(1}\002J(m\bW+\002J`h(sF+`()\b(w\vIxxI\v\002J`(F\b\002J(@}\002J(I\v@I(\127FW`I(1F/I\v:(F\b\t(1IW(\v\002J()\vW(I\v@YI\v\002J@I@(+}xx:(P}(I+(Y\b(\t\v@1I@(\v+`S"),
      Media = IMG_Ba4D
    },
    {
      Text = _yhK5("?J(yW\viF:(J\vIW(iF\002Jh"),
      Media = IMG_Ba4C
    },
    {
      Text = _yhK5("\027\b\002J(1F+(@}\002J:(\v\002J(+}xx`I(/I++IW(iI\v@I@(o\b@1(JFx`I@h(8\b@(D\v/(+\vI(+\002J}@(JIW:(\v\002J(YI\v\002J@I(I+()\vW(I\v@(\b@1(1F@@(\v+`(F/IW(\003\002Jx\b++h(?J@I(iI\v@I@(\027@PFx`(+FD(\v\002J(RI\v@(m}W`(iIJWh(\003yWI\002JI@1I(\014FI\biI:(PIW(JF`(+\v\002J(1\vI+I@(v\bF`+\002J(I\vDI@`x\v\002J(F\b+DI1F\002J`S"),
      Media = IMG_Ba4D
    },
    {
      Text = _yhK5("Z)F@RI:(`W}`Y1IihZ(+yWF\002J(1IW(\\FI/I(\b@1(+\002JPF@D(+\v\002J(P\vI1IW(\v@(1\vI(]\b\t`h"),
      Media = IMG_Ba4C
    }
  }, function(action)
    Z_Bergauf40.Active = false
    Z_Bergauf50.Active = true
    Z_Orakel.Active = true
    P_Raebe:MoveTo(Z_Bergauf50)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Z_Bergauf60:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t%z")
  if V_EasyMode == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Z8F:(F\b\002J(1FSZ(/IDW\bI++`()\v\002J(1IW(\\FI/Ih(Z#\002J(JF/(\v@YP\v+\002JI@(iFx(1\vI(\027\b++\v\002J`(J\vIW(F\b+PI@1\vD(DIxIW@`hZ"),
        Media = IMG_Ba6B
      },
      {
        Text = _yhK5("\027/IW(xF@D+Fi(RW\vID(\v\002J(P\vWRx\v\002J(s\b@DIW(\b@1(1\vI(]}xx\v+(+\v@1(RI\v@(I\002J`I+(\\FI/I@\t\b``IWh(\022\b(i\vW(1}\002J(iFx(I\v@I@(\028I\tFxxI@(\b@1(+FiixI(I\v@(yFFW(w}@(1I@(\014IIWI@(I\v@:(1\vI(J\vIW(\bI/IWFxx(W\bi+`IJI@h(#\002J(PFW`I(+}xF@DI(\vi(\\\b\002R+F\002R(\b@1(PIW\tI(@}\002J(iFx(I\v@I@(\014x\v\002R(F\b\t(1\vI()}R\biI@`Ih"),
        Media = IMG_Ba6C
      },
      {
        Text = _yhK5("\003Ix/+`(y\tx\bI\002RI@(\v+`(P}Jx(RI\v@I(?y`\v}@:(PF+S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("\127I\v@I([I\v`:(\v\002J(i\b++(1W\v@DI@1(@}\002J(iFx(PF+(@F\002J+\002JF\bI@(/Iw}W(P\vW(}/I@(+\v@1h"),
        Media = IMG_Raebe02
      }
    }, function(action)
      TMR_Hunger:Start()
      P_Raebe:MoveTo(Player)
      Z_Bergauf60.Active = false
      Z_Beeren1.Active = true
      Z_Beeren2.Active = true
      Z_Beeren3.Active = true
      Z_Bergauf70.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Z8F:(F\b\002J(1FSZ(/IDW\bI++`()\v\002J(1IW(\\FI/Ih(Z#\002J(JF/(\v@YP\v+\002JI@(iFx(1\vI(\027\b++\v\002J`(J\vIW(F\b+PI@1\vD(DIxIW@`hZ\020\014\\6\014I++IW(\v\002J(+`I\vD(LI`Y`(Y\b()\vW(\v@(1I@(\\\b\002R+F\002Rh(\014Fx1(+\v@1(P\vW(F\b\t(1IW(\014\bWD:(1F(+}xx`I@(P\vW(Y\b+FiiI@(/xI\v/I@h(mIW(PI\v++:(PIW(+\v\002J(1F(}/I@(FxxI+(W\bi`WI\v/`h("),
        Media = IMG_Ba6B
      }
    }, function(action)
      P_Raebe:MoveTo(Player)
      Z_Bergauf60.Active = false
      Z_Bergauf80.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function Z_Tisch:OnEnter()
  _sjq = _yhK5("[b\022\v+\002J")
  if V_StoryLine >= 240 then
    P_Emilio.Commands._XGo4m.Enabled = true
  end
end
function Z_Tisch:OnExit()
  _sjq = _yhK5("[b\022\v+\002J")
  P_Emilio.Commands._XGo4m.Enabled = false
end
function Z_Nekramora:OnEnter()
  _sjq = _yhK5("[b8IRWFi}WF")
  if V_FMausStatus < 5 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("s\vIW(Fx+}(/I\t\v@1I`(+\v\002J(1F+(]FDIW(1IW(iU+`IW\v}I+I@(8IRWFi}WFh(\003\vI(+`IJ`(\v@(I\v@IW(\027W`(\022JW}@(\b@1(\bi(+\vI(JIW\bi(PF\002J+I@(\003RIxI``I(F\b+(1Ii(\014}1I@h(\a\vDI@`x\v\002J(i}I\002J`I+`()\b(DFW(@\v\002J`(@FIJIW(F@(+\vI(JIWF@`WI`I@:(Fx+()\b(I+(DIWF1I(+\002J}@(`\b+`:(F/IW(+Ix/+`(PI@@()\b(P}xx`I+`:()\b(R}I@@`I+`(I+(DFW(@\v\002J`h"),
        Media = IMG_Nekra2
      },
      {
        Text = _yhK5("8IRWFi}WF(JF`(I\v@I(\014FWW\vIWI(/I+\002JP}WI@:(1\vI(+\v\002J(P\vI(I\v@I(\028xF+R\byyIx(\bI/IW(1F+(]FDIW(IWJI/`(\b@1(w}@(1I@(\003RIxI``I@(Fi(\014}1I@(wIWF@RIW`(P\vW1h(oF@(+\vIJ`(+\vI(YPFW(@\v\002J`:(F/IW(iF@(RF@@(i\v`(1Ii(l\v@DIW(1FWF@(F@Rx}y\tI@:(IW+`F\b@x\v\002Jh"),
        Media = IMG_Skelett1
      },
      {
        Text = _yhK5("Z#JW(1\bIW\t`(\b@+(J\vIW(@\v\002J`(WI\v@xF++I@:(PF+SZ(+yW\v\002J`(1IW(\\FI/I(I\v@I+(1IW(\003RIxI``I(F@:(1}\002J(IW(IWJFIx`(RI\v@I(\027@`P}W`h"),
        Media = IMG_Skelett2
      }
    }, function(action)
      V_FMausStatus = 5
      Z_Local_FMaus.Active = true
      FCT_Lager()
    end)
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(Rx}y\t+`(F@(1\vI(\014FWW\vIWI:(F/IW(@\vIiF@1(W\b\t`(ZsIWI\v@Zh()\b(/\v+`(@\v\002J`(P\vWRx\v\002J(/}I+I(1W\bih"),
      Media = IMG_Nekra3,
      Callback = function(action)
        if action ~= nil then
          FCT_Lager()
        end
      end
    })
  end
end
function Z_Nekramora:OnExit()
  _sjq = _yhK5("[b8IRWFi}WF")
  TMR_SkelettDraussen:Stop()
  TMR_SkelettDrinnen:Stop()
  ITM_Keule.Commands._w5mQ_.Enabled = false
  P_Skelett:MoveTo(nil)
end
function Z_Holzzelt:OnEnter()
  _sjq = _yhK5("[bs}xYYIx`")
  if V_BibStatus == 20 then
    ITM_Foto.Commands._70V.Enabled = true
  end
end
function Z_Holzzelt:OnExit()
  _sjq = _yhK5("[bs}xYYIx`")
  ITM_Foto.Commands._70V.Enabled = false
end
function Z_Local_Bib:OnExit()
  _sjq = _yhK5("[b]}\002Fxb\014\v/")
  Z_Local_Bib.Active = false
end
function Z_Bergauf80:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t0z")
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("Z9++++`:(+I\v(iFx(+`\vxxZ:(\tx\bI+`IW`(1IW(\\FI/I(F\b+()I\v@Ii(\\\bI\002R+F\002Rh(Zs}IW+`()\b(1\vI(\003`\viiI@(1F(}/I@h(#\002J(IWRI@@I(+\vIh()F+(+\v@1(1\vI(9\vWF`I@h(\003\v@1(+\vI(Fx+}(P\vWRx\v\002J(J\vIWh(sF/I@(P}Jx(I\v@\tF\002J(I\v@+(\b@1(I\v@+(Y\b+FiiI@DIYFIJx`h({IWW\bI\002R`:(1\vI(9\vWF`I@h(\027@1IWIW+I\v`+(\v+`(I+(F\b\002J(DF@Y(yWFR`\v+\002Jh([\b(1I@I@(i\b++(\v\002J(LF(+}P\vI+}(@}\002Jh(]F++(\b@+(1F+(iFx(DxI\v\002J(IWxI1\vDI@hZ"),
      Media = IMG_BA8B
    }
  }, function(action)
    Z_Bergauf80.Active = false
    Z_Innenhof.Active = true
    T_NachOben.Complete = true
    T_Piraten1.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Z_Bergauf50:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t-z")
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\014IWI\v`+(F\b+(1IW(lIW@I(+\vIJ+`()\b:(1F++(1IW(\\FI/I(IW@I\b`(9xF`Y(DI@}iiI@(JF`(\b@1(i\v`(LIiF@1Ii(Y\b(+yWI\002JI@(+\002JI\v@`h(\027x+()\b(@FIJIW(R}ii+`(IWRI@@+`()\b(I\v@I(lxI1IWiF\b+:(1\vI(I+(+\v\002J(\v@(I\v@IW(RxI\v@I@(s}IJxI(DIi\bI`x\v\002J(DIiF\002J`(JF`h"),
      Media = IMG_Ba5B
    },
    {
      Text = _yhK5("hhh(@F(LI1I@\tFxx+(JF/(\v\002J(1\vI+Ii(\027\t\tI@(I\v@I@(Y\vIix\v\002JI@(\003\002JWI\002RI@(I\v@DILFD`h()F+(PFW(I\v@(\003yF++:(+FD(\v\002J()\vWh(mFJW+\002JI\v@x\v\002J(+\v`Y`(IW(\viiIW(@}\002J(F\b\t(+I\v@Ii(W\vI+\vDI@(\014\b\002J(\b@1(JI\bx`h(8\b@(F/IW(DI@\bD(DI+\002JPF`Y`h(#\002J(i\b++(LI`Y`(P\vI1IW(F\b\tyF++I@h"),
      Media = IMG_Ba5C
    },
    {
      Text = _yhK5("\027\b\t(PF+(i\b++`()\b(1I@@(F\b\tyF++I@S"),
      Media = IMG_Ba5D
    },
    {
      Text = _yhK5("#\002J(i\b++(wIWJ\v@1IW@:(1F++(\a\\(I+(+\002JF\t\t`:(/\v+(Y\bW(\014\bWD(J\v@F\b\t(Y\b(R}iiI@h"),
      Media = IMG_Ba5C
    },
    {
      Text = _yhK5("\a\\S"),
      Media = IMG_Ba5D
    },
    {
      Text = _yhK5(" F(\a\\h(oI\v@I(sIWW\v@:(1\vI(iFI\002J`\vDI(8IRWFi}WF(P\vW1(+I\v`(DI+`IW@(/IxFDIW`(w}@(j(9\vWF`I@h(t@1(P\vI(P\vW(\v@YP\v+\002JI@(JIWF\b+DI\t\b@1I@(JF/I@:(PFW`I@(1\vI(j(9\vWF`I@(1FWF\b\t:(1F++(I\v@(\014}`I(/I\v(\vJ@I@(I\v@`W\v\t\t`:(1IW(\t\bIW(+\vI(I\v@(P\v\002J`\vDI+()}R\biI@`(/I+}WDI@(+}xx`Ih(t@1(1\vI+I+()}R\biI@`(RF@@(+IJW(DI\tFIJWx\v\002J(\t\bIW(\b@+(PIW1I@h()FJIW(i\b++(\b@/I1\v@D`(wIWJ\v@1IW`(PIW1I@:(1F++(\a\\(I+(/\v+(Y\b(1I@(9\vWF`I@(+\002JF\t\t`h()\b(JF+`(@\v\002J`(Y\b\tFIxx\vD(1I@(\014}`I@(DI+IJI@S"),
      Media = IMG_Ba5C
    },
    {
      Text = _yhK5("8I\v@:(J\vIW(+\v@1(RI\v@I(\014}}`I(PI\v`(\b@1(/WI\v`:(1F+(P\bI++`I(\v\002Jh(#\002J(RI@@(i\v\002J(F\b+(i\v`(\014}}`I@:(\v\002J(/\v@(I\v@(9\vWF`:(hhh(FIJi(\tF+`(hhh"),
      Media = IMG_Ba5D
    },
    {
      Text = _yhK5("\028\b`:(D\b`h(mI@@(FxxI+(+}(W\bJ\vD(\v+`:(1F@@(RF@@+`()\b(i\v\002J(1}\002J(+\v\002JIW(iFx(R\bWY(wIW`WI`I@h(#\002J(JF/(LI`Y`(@FIix\v\002J(lI\vIWF/I@1(\b@1(RI\v@I(]\b+`(Y\b(PFW`I@:(/\v+(1\vI(\027/x}I+\b@D(J\vIW(\v+`h()\vI(tI/IW+`\b@1I@(/IYFJx`(+\vI(i\vW(IJ(@\v\002J`:(1\vI+I(hhh"),
      Media = IMG_Ba5C
    },
    {
      Text = _yhK5(")I@(\\I+`(1I+(\003F`YI+(J}IW+`()\b(+\002J}@(@\v\002J`(iIJW:(1I@@(1\vI(lxI1IWiF\b+(\v+`(F\b\t(\b@1(1Fw}@:(}J@I(\bI/IWJF\by`(F\b\t(I\v@I(\027@`P}W`(Y\b(PFW`I@h()\b(+\002JF\b+`(\vJW(@}\002J(I\v@I(mI\vxI(J\v@`IWJIW(\b@1(wIW+\b\002J+`()\vW(Y\b(iIWRI@:(P}J\v@(+\vI(DI\tx}DI@(\v+`h()}W`(\vWDI@1P}(i\b++(+\v\002J(1F+(]FDIW(1\vI+IW(iU+`IW\v}I+I@(8IRWFi}WF(/I\t\v@1I@h"),
      Media = IMG_BA5E
    }
  }, function(action)
    P_Fledermaus:MoveTo(Z_Local_FMaus)
    P_Raebe:MoveTo(Z_Bergauf60)
    Z_Bergauf50.Active = false
    Z_Bergauf60.Active = true
    Z_Nekramora.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Z_Beeren1:OnEnter()
  _sjq = _yhK5("[b\014IIWI@\"")
  ITM_Beeren:MoveTo(Z_Beeren1)
end
function Z_Beeren2:OnEnter()
  _sjq = _yhK5("[b\014IIWI@,")
  ITM_Beeren:MoveTo(Z_Beeren2)
end
function Z_Orakel:OnEnter()
  _sjq = _yhK5("[b?WFRIx")
  if V_StoryLine < 210 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Zs\027\027\027]]????:(?\\\027\127\a]:(m?(\014#\003\022()tSZ(\\\b\t`(1IW(\\FI/I:(F/IW(@\vIiF@1(F@`P}W`I`h(Z)F(JF`(\b@+(1IW(\014F\bi(P}Jx(1}\002J(I\v@I@(\014FIWI@(F\b\tDI/\b@1I@h(o\v+`Z"),
        Media = IMG_Ora2
      },
      {
        Text = _yhK5("#JW(+\002JF\b`(\a\b\002J(@}\002J(I\v@(PI@\vD(\bih(\028IWF1I(Fx+(#JW(P\vI1IW(DIJI@(P}xx`:(I@`1I\002R`(1IW(\\FI/I(F@(I\v@Ii(\014F\bi+`\biy\t(I\v@(\003\002J\vx1(i\v`(1IW(\027\b\t+\002JW\v\t`B\020\014\\6\020\014\\6\014\v@(wIWWI\v+`(Y\b(1I@(9UWFi\v1I@\n"),
        Media = IMG_Ora3
      },
      {
        Text = _yhK5("8F(yW\viF(\b@1(@\b@S(\003}xxI@(P\vW(LI`Y`(@F\002J(\027IDUy`I@(WI\v+I@(}1IW(P\vI(JF`(+\v\002J(1F+(?WFRIx(1F+(w}WDI+`Ixx`S(\127I@@+`()\b()\v\002J(F\b+(i\v`(9UWFi\v1I@(\b@1(P\vI(iF@(1F(J\v@(R}ii`S"),
        Media = IMG_Ora4
      },
      {
        Text = _yhK5("8}Ih"),
        Media = IMG_Spieler
      }
    }, function(action)
      T_Orakel.Active = true
      V_StoryLine = 210
    end)
  end
end
function Z_Huegel:OnEnter()
  _sjq = _yhK5("[bs\bIDIx")
  P_Raebe:MoveTo(Z_Huegel)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")IW(\\FI/I(+\v`Y`(F\b\t(1IW(\014F@R(\b@1(+`FWW`(]}I\002JIW(\v@(1\vI(]\b\t`:(Fx+(}/(I+(@\v\002J`+(Y\b(`\b@(DFI/Ih(Z#\002J(JF/(DWF1(9F\b+IZ(/IDW\bI++`(IW()\v\002Jh"),
      Media = IMG_Huegel1
    },
    {
      Text = _yhK5("oF\002J(1}\002J(iFx(I\v@(l}`}h(Z\\FI/I(F\b\t(I\v@IW(\014F@R(F\b\t(I\v@Ii(s\bIDIxZ(\v+`(1}\002J(I\v@(+\002J}I@I+(o}`\vw(\b@1(1F@@(@}\002J(/I\v(1\vI+Ii(mI``IW:(\b@+\002JxFD/FW\n"),
      Media = IMG_Huegel1
    }
  }, function(action)
    P_Raebe.Commands._YWV.Enabled = true
  end)
end
function Z_Huegel:OnExit()
  _sjq = _yhK5("[bs\bIDIx")
  FCT_HuegelVerlassen()
end
function Z_Steinhaufen:OnEnter()
  _sjq = _yhK5("[b\003`I\v@JF\b\tI@")
  if V_StoryLine < 350 then
    ITM_Laterne.Commands._aDHF.Enabled = true
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\\FI/I(\b@1(1\vI(lxI1IWiF\b+(+\v`YI@(F\b\t(1Ii(\003`I\v@JF\b\tI@(\b@1(IWPFW`I@()\v\002Jh(\014I\v(\vJ@I@(x\vID`(1IW(/IJFFW`I(\127@}\002JI@h"),
      Media = IMG_FinB,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function Z_Steinhaufen:OnExit()
  _sjq = _yhK5("[b\003`I\v@JF\b\tI@")
  ITM_Laterne.Commands._aDHF.Enabled = false
end
function Z_Bergauf70:OnEnter()
  _sjq = _yhK5("[b\014IWDF\b\t.z")
  if Player:Contains(ITM_Beeren) then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")IW(\\FI/I(+\002JI\v@`(P\vI1IW(Y\b(\127WFI\t`I@(DIR}iiI@(Y\b(+I\v@h()\vI(\014IIWI@(LI1I@\tFxx+(+\v@1(\tF+`(FxxI(\b@1(IW(\txF``IW`()\vW(+\002J}@(P\vI1IW(w}W(1IW(8F+I(JIW\bi:(Y\bi\v@1I+`(/\v+(IW(1\vI(\014F@R(I@`1I\002R`:(F\b\t(1\vI(IW(+\v\002J(+}DxI\v\002J(+I`Y`h(Z\127}ii(JIWZ:(W\b\t`(IW()\vW(Y\b:(Z+I`Y(r@/+yO)\v\002JZh"),
        Media = IMG_Ba7B
      },
      {
        Text = _yhK5(")\b(\t}xD+`(+I\v@IW(\027\b\t\t}W1IW\b@D(\b@1(+I`Y`()\v\002Jh(\027x+()I\v@(\014x\v\002R(1F/I\v(\bI/IW(1I@(\014}1I@(+`WI\v\t`:(I@`1I\002R+`()\b(I\v@(\022\bI`\002JI@(i\v`(\028\bii\vW\v@DI@:(1F+(1}W`(\b@`IW(1IW(\014F@R(x\vID`h(ZmIW(F\b\002J(\viiIW(1F+(J\vIW(wIWx}WI@(JF`:(P\vW1(P}Jx(@\v\002J`(iIJW(JIWR}iiI@:(\bi(1F@F\002J(Y\b(+\b\002JI@h(\014Iw}W(I+(@}\002J(PI\v`IW(1\vI(]F@1+\002JF\t`(wIW+\002JF@1Ix`:(yF\002R(\v\002J(I+(x\vI/IW(I\v@hZ(1I@R+`()\b(\b@1(P\vW\t+`(I+(\v@(1I@(\\\b\002R+F\002Rh"),
        Media = IMG_BA7C
      }
    }, function(action)
      Z_Bergauf70.Active = false
      Z_Bergauf80.Active = true
      ITM_Ringe:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    TMR_Hunger:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("?J(LI:(o\vxx\v}@I@(w}@(\014IIWI@(DF/(I+(J\vIW(Y\b(y\tx\bI\002RI@(\b@1()\b(/\v+`(F@(FxxI@(w}W/I\v(DIxF\b\tI@h()}W`(PFWI@(PIx\002JI(\b@1(1}W`(\b@1(1}W`:()\b(\014x\v@1+\002JxI\v\002JIh(8\b@(P\vW+`()\b(P}Jx(@}\002J(iFx(Y\bW\bI\002R(DIJI@(i\bI++I@h"),
        Media = IMG_Raebe02
      },
      {
        Text = _yhK5(")\b(/\v+`(\tWI\002J(\\FI/I\n(#\002J(JF/(+\vI(JFx`(@\v\002J`(DI+IJI@h"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5(" F(D\b`h(8\b@(J}x(+\vI(F/IWh"),
        Media = IMG_Raebe02
      }
    }, function(action)
      Z_Beeren1.Visible = true
      Z_Beeren2.Visible = true
      Z_Beeren3.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function Z_Mitternacht:OnEnter()
  _sjq = _yhK5("[bo\v``IW@F\002J`")
  FCT_NachtStartGespraech()
end
function Z_FinalHint:OnEnter()
  _sjq = _yhK5("[bl\v@Fxs\v@`")
  P_Raebe.Commands._uctcs.Enabled = true
  if V_StoryLine < 390 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\vI(lxI1IWiF\b+(\v+`(\a\b\002J(}\t\tI@/FW(DI\t}xD`(\b@1(JF`(@}\002J(I\v@I@(xI`Y`I@(\127}iiI@`FW(F\b\t(1I@(]\vyyI@B(\a+(D\v/`(J\vIW(@}\002J(I\v@I@(t@x}\002R!\001}1I(Y\b(DIP\v@@I@(\b@1(\v\002J(JF/I(\vJ@h(\003FD(i\vW(1I@(\001}1I:(1IW(F\b\t(1IW()}+I(+`IJ`(\b@1(\v\002J(+\002JI@RI()\vW(1I@(t@x}\002R!\001}1Ih"),
        Media = IMG_Fledermaus0
      }
    }, function(action)
      V_StoryLine = 390
      P_Fledermaus:MoveTo(Z_FinalHint)
    end)
  end
end
function Z_FinalHint:OnExit()
  _sjq = _yhK5("[bl\v@Fxs\v@`")
  P_Raebe.Commands._uctcs.Enabled = false
end
function Z_Beeren3:OnEnter()
  _sjq = _yhK5("[b\014IIWI@j")
  ITM_Beeren:MoveTo(Z_Beeren3)
end
function Z_Tafel:OnEnter()
  _sjq = _yhK5("[b\022F\tIx")
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\003\vIJ+`()\b:(1\vI+I(\022F\tIx(J\vIW(iI\v@I(\v\002Jh(\a\v@I(+\002JPI1\v+\002JI(\028WFI\t\v@:(1\vI(\"0\"\025(w}@(J\vIW(@F\002J(m\vI@(WI\v+`Ih(9F++I@1IW(DIJ`(LF(P}Jx(@\v\002J`h"),
      Media = IMG_EinsiedelA01
    },
    {
      Text = _yhK5("\028\b`(DIiF\002J`h(t@1(LI`Y`(xF++(\b@+(Y\b(1IW(\\\b\v@I(+\002JxI\v\002JI@h({\vIxxI\v\002J`(+IJI@(P\vW(1I@(\028I\v+`(LFh(\027/IW(x\vI+()\vW(1I@(\022I3`(F\b\t(1IW(\022F\tIx(w}WJIW(}W1I@`x\v\002J(1\bW\002J:(1Fi\v`(P\vW(@\v\002J`(1\bii(1F(+`IJI@:(\tFxx+(P\vW(\v@(I\v@(\028I+yWFI\002J(wIWP\v\002RIx`(PIW1I@h"),
      Media = IMG_Raebe01
    }
  }, function(action)
    Z_Einsiedelei.Active = true
    Z_Tafel.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function Z_Einsiedelei:OnEnter()
  _sjq = _yhK5("[b\a\v@+\vI1IxI\v")
  if V_EinsiedeleiStatus < 10 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#JW(+`}xyIW`(1\bW\002J(1\vI()\b@RIxJI\v`h([\bi(\028x\bI\002R(JF`(1IW(o}@1(I`PF+(o\v`xI\v1(\b@1(PI\v+`(\a\b\002J(1I@(mIDh"),
        Media = IMG_EinsiedelB02
      },
      {
        Text = _yhK5("8F\002J(I\v@(yFFW(\003\002JW\v``I@(`F\b\002J`(Fi(\014}1I@(I\v@(\\I\002J`I\002R(F\b+(\003`I\v@I@(F\b\t:(1F+(P}Jx(\tW\bIJIW(iFx(I\v@(sF\b+(DIPI+I@(+I\v@(i\b++h(#@(+I\v@IW(o\v``I(x\vIDI@(@}\002J(iIJW(\003`I\v@Ih(\027xxIW1\v@D+(Y\b(PI@\vD:(\bi(1Fi\v`(1F+(sF\b+(P\vI1IW(F\b\tY\b/F\bI@h"),
        Media = IMG_EinsiedelB01
      },
      {
        Text = _yhK5("\027x+(\vJW(\a\b\002J(1Ii(\003`I\v@JF\b\tI@(@FIJIW`:(/ID\v@@`(IW(yx}I`Yx\v\002J(Y\b(xI\b\002J`I@h"),
        Media = IMG_EinsiedelB03
      }
    }, function(action)
      V_EinsiedeleiStatus = 10
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_DbgStartpunkt:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 39026 then
    V_StoryLine = 60
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_Bergauf20.Active = true
    P_Raebe:MoveTo(Z_Bergauf20)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Troellchen:MoveTo(Player)
    if V_EasyMode == 0 then
      ITM_WeissesTuch:MoveTo(Player)
    else
      ITM_BuntesTuch:MoveTo(Player)
      T_Kopftuch.Complete = true
    end
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 39028 then
    V_StoryLine = 100
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Bergauf40.Active = true
    P_Raebe:MoveTo(Z_Bergauf40)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Troellchen:MoveTo(Player)
    if V_EasyMode == 0 then
      ITM_WeissesTuch:MoveTo(Player)
    else
      ITM_BuntesTuch:MoveTo(Player)
    end
    FCT_DbgLollisNehmen()
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    Z_Local_Bib.Active = true
    V_BibStatus = 30
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 39032 then
    V_StoryLine = 100
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Bergauf80.Active = true
    Z_Nekramora.Active = true
    Z_Orakel.Active = true
    P_Raebe:MoveTo(Player)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Troellchen:MoveTo(Player)
    if V_EasyMode == 0 then
      ITM_WeissesTuch:MoveTo(Player)
      ITM_Beeren:MoveTo(Player)
      ITM_Beeren.Commands._eDe.Enabled = false
      ITM_Ringe:MoveTo(Player)
    else
      ITM_BuntesTuch:MoveTo(Player)
    end
    FCT_DbgLollisNehmen()
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    Z_Local_Bib.Active = true
    V_BibStatus = 30
    P_Fledermaus:MoveTo(Z_Local_FMaus)
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 52539 then
    V_StoryLine = 240
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Innenhof.Active = true
    Z_Local_FMaus.Active = true
    P_Raebe:MoveTo(Player)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Troellchen:MoveTo(Player)
    ITM_WeissesTuch:MoveTo(Player)
    FCT_DbgLollisNehmen()
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    Z_Local_Bib.Active = true
    V_BibStatus = 30
    P_Fledermaus:MoveTo(Z_Local_FMaus)
    ITM_Beeren:MoveTo(Player)
    ITM_Beeren.Commands._eDe.Enabled = false
    ITM_Schluessel:MoveTo(Player)
    V_PiratenStatus = 20
    ITM_Ringe:MoveTo(Player)
    ITM_Uhr:MoveTo(Player)
    ITM_Uhr.Commands._HcSK.Enabled = true
    V_SchatzStatus = 1
    FCT_NachtmodusAus()
    FCT_EmilioRename()
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 51540 then
    V_StoryLine = 240
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Innenhof.Active = true
    Z_Nekramora.Active = true
    Z_Tisch.Active = true
    P_Raebe:MoveTo(Player)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Troellchen:MoveTo(Player)
    ITM_BuntesTuch:MoveTo(Player)
    FCT_DbgLollisNehmen()
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    V_BibStatus = 30
    Z_Local_Bib.Active = true
    P_Fledermaus:MoveTo(Z_Tisch)
    ITM_Beeren:MoveTo(Player)
    ITM_Beeren.Commands._eDe.Enabled = false
    ITM_Schluessel:MoveTo(Player)
    V_PiratenStatus = 20
    V_FMausStatus = 20
    V_SchatzStatus = 1
    ITM_Amulett:MoveTo(Player)
    ITM_Ringe:MoveTo(Player)
    FCT_EmilioRename()
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 11210 then
    V_StoryLine = 260
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Innenhof.Active = true
    Z_Nekramora.Active = true
    Z_Tisch.Active = true
    Z_Steinhaufen.Active = true
    P_Raebe:MoveTo(Z_Steinhaufen)
    P_Raebe.Commands._PoKq.Enabled = true
    P_Fledermaus:MoveTo(Z_Steinhaufen)
    P_Troellchen:MoveTo(Player)
    ITM_Keule:MoveTo(nil)
    P_Skelett.Commands._XujO.Enabled = false
    FCT_DbgLollisNehmen()
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    V_BibStatus = 30
    Z_Local_Bib.Active = true
    ITM_Beeren:MoveTo(Player)
    ITM_Beeren.Commands._eDe.Enabled = false
    ITM_Schluessel:MoveTo(Player)
    V_PiratenStatus = 30
    V_FMausStatus = 40
    V_SchatzStatus = 1
    ITM_Ringe:MoveTo(Player)
    FCT_EmilioRename()
    ITM_Laterne.Commands._aDHF.Enabled = true
    ITM_CoCaSpinne:MoveTo(Player)
    FCT_AufgabenAnpassen()
  elseif _Urwigo.Hash(string.lower(input)) == 56553 then
    V_StoryLine = 350
    Z_Kunitz.Active = false
    Z_Parkplatz.Active = false
    Z_Parkplatz2.Active = false
    Z_TrollPwd.Active = false
    Z_Final.Active = true
    Z_FinalHint.Active = true
    P_Raebe:MoveTo(Player)
    P_Raebe.Commands._PoKq.Enabled = true
    ITM_Laterne:MoveTo(nil)
    ITM_Keule:MoveTo(nil)
    FCT_DbgLollisNehmen()
    ITM_LolliX:MoveTo(Player)
    ITM_CoCaPiraten:MoveTo(Player)
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    ITM_BibAusweis:MoveTo(Player)
    V_BibStatus = 30
    Z_Local_Bib.Active = true
    ITM_Beeren:MoveTo(Player)
    ITM_Beeren.Commands._eDe.Enabled = false
    ITM_Schluessel:MoveTo(Player)
    P_Emilio.Commands._XGo4m.Enabled = true
    V_PiratenStatus = 50
    V_FMausStatus = 50
    V_SchatzStatus = 1
    ITM_Ringe:MoveTo(Player)
    FCT_EmilioRename()
    ITM_CoCaSpinne:MoveTo(Player)
    FCT_AufgabenAnpassen()
  end
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function INP_Buecherliste:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if V_StoryLine < 100 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\027\002J(JIWWLI:(\t\bIW(1I@(\022WF@+y}W`(iFD(I+(LF(w}@({}W`I\vx(+I\v@:(1F++()I\v@I(\014\bI\002JIW(+}(P\v@Y\vD(+\v@1:(F/IW(Y\bi(]I+I@(+\v@1(+\vI(1F1\bW\002J(@\v\002J`(iIJW(P\vWRx\v\002J(DII\vD@I`h"),
        Media = IMG_Ba3CRaebe
      },
      {
        Text = _yhK5("\027xxI+(@\bW(I\v@I(lWFDI(1IW(W\v\002J`\vDI@(mIWRYI\bDIh()\b(P\vW+`(+\002J}@(@}\002J(1Fi\v`(Y\bWI\002J`(R}iiI@:(\tW\bIJIW(}1IW(+yFI`IWh"),
        Media = IMG_Ba3CBibl
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 43841 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(+\002JxFID+`(1F+(\014\b\002J(F\b\t(\b@1(/ID\v@@+`(Y\b(xI+I@B\020\014\\6\020\014\\6)\vI({}WJIW+FDI(1IW(]}``}YFJxI@(\v+`(\vi(\028W\b@1I(DF@Y(I\v@\tF\002Jh(oF@(/WF\b\002J`(1F\t\bIW(@\bW(I\v@I([I\v`iF+\002J\v@I:(i\v`(1IW(iF@(I\v@\vDI(PI\v@\vDI(\022FDI(\v@(1\vI([\bR\b@\t`(WI\v+I@(RF@@(hhh")
      },
      {
        Text = _yhK5("\003}(I\v@(\014x}I1+\v@@h(xF++(\b@+(1\vI([I\v`(i\v`(F@1IWI@()\v@DI@(wIW+\002JPI@1I@h")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 2007 then
    if Z_Tisch:Contains(Player) and V_StoryLine == 230 then
      P_Emilio.Commands._XGo4m.Enabled = true
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5("s\vIW(\ai\vx\v}:(x\vI+(1}\002J(1F+(iFxh"),
          Media = IMG_Emilio11
        },
        {
          Text = _yhK5("\ai\vx\v}(/xFI``IW`(Y\b@FI\002J+`(+\002J@Ixx:(1F@@(\viiIW(xF@D+FiIW(\v@(1Ii(\014\b\002J(\b@1(/ID\v@@`(+\002Jx\vI++x\v\002J(xF\b`(Y\b(xI+I@B\020\014\\6\020\014\\6)\vI(I\v@\tF\002J+`I({FW\vF@`I(1I+(sIxx+IJI@+:(1\vI(\v@+/I+}@1IWI(w}@(\027@\tFI@DIW@(DI@\b`Y`(PIW1I@(RF@@:(\bi(+\002J@Ixx(\aW\t}xDI(Y\b(IWY\vIxI@:(\v+`(\b@`IW(1Ii(8FiI@(Z[\vDI\b@IW\v@(i\v`(\028xF+R\bDIxZ(/IRF@@`h(ti(+\vI(DxF\b/JF\t`(r@/+yOF@Y\bPI@1I@(+\v@1(\t}xDI@1I(t`I@+\vx\vI@(@}I`\vDB(I\v@(/\b@`I+(\127}y\t`\b\002J:(I\v@(\027i\bxI``:(I\v@I(\028xF+R\bDIx(\b@1(I\v@(`\vIW\v+\002JIW(\014IDxI\v`IW(AiI\v+`(\127F`YI:(9FyFDI\v(}1IW(lxI1IWiF\b+\017h"),
          Media = IMG_Emilio12
        },
        {
          Text = _yhK5(")F@@(RxFyy`(\ai\vx\v}(1F+(\014\b\002J(Y\b:(D\v/`(I+()\vW(Y\bW\bI\002R(\b@1(+FD`B(\014I+}WD`(1F+([I\bD(\b@1(\v\002J(yW}/\vIWI(I+h"),
          Media = IMG_Emilio11
        }
      }, function(action)
        T_Orakel.Complete = true
        T_Amulett.Active = true
        T_Kopftuch.Active = true
        T_Begleiter.Active = true
        T_Kristallkugel.Active = true
        T_Hellsehen.Active = true
        V_StoryLine = 240
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.MessageBox({
        Text = _yhK5(")F+(\014\b\002J(JI\v++`(YPFW(ZsIxx+IJI@(\t\bIW(\027@\tFI@DIWZ(F/IW(@F\002J1Ii()\b(1\vI(IW+`I@(/I\v1I@(\003FI`YI(DIxI+I@(JF+`(P\vW1()\vW(RxFW:(1F++()\b(\vi(\014IY\bD(F\b\t(1F+(sIxx+IJI@(@}\002J(@\v\002J`(iFx(1I@(\003`F`\b+(I\v@I+(\027@\tFI@DIW+(IWWI\v\002J`(JF+`h"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _Urwigo.Hash(string.lower(input)) == 1946 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")IW(\\FI/I(x\vI+`(1\vI(IW+`I@(j(\003FI`YI:(RxFyy`(1F+(\014\b\002J(DI@IWw`(P\vI1IW(Y\b(+FD`B(Z)\vI(JF/I@(1}\002J(+}(PF+(w}@(RI\v@I(\027J@\b@DhZ")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 24514 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(/xFI``IW+`(\v@(1Ii(\014\b\002J(J\v@(\b@1(JIW(\b@1(\t\v@1I+`(w\vIxI(@\b`Yx}+I(#@\t}WiF`\v}@I@(\bI/IW(lxI1IWiFI\b+I:(P\vI(/I\v+y\vIx+PI\v+I(1\vI+I(J\vIWB\020\014\\6\020\014\\6hhh(I\v@\vDI(PI@\vDI(w}@(#J@I@(+\v@1(+IJW(wIW+y\vIx`h(sF`(iF@(I\v@iFx(JIWF\b+DI\t\b@1I@:(P}WF@(+\vI(\003yF++(JF/I@:(RF@@(iF@(+\vI(1Fi\v`(F@x}\002RI@(\b@1(+}(F@(LI1I(/Ix\vI/\vDI(\003`IxxI(\t\bIJWI@(hhh\020\014\\6\020\014\\6\022}xx:(+}(I`PF+(i\b++(iF@(\b@/I1\v@D`(P\v++I@h()\b(RxFyy+`(1F+(\014\b\002J(P\vI1IW(Y\b(\b@1(D\v/+`(I+(Y\bW\bI\002Rh")
      }
    }, function(action)
      if V_FMausStatus == 10 and V_StoryLine == 240 then
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5("mF+(DxF\b/+`()\b(P}Jx(iF\002J`(\b@+IWIW(lxI1IWiF\b+(\003yF++S"),
            Media = IMG_Spieler
          },
          {
            Text = _yhK5("#\002J(DxF\b/I:(1\vI(FIWDIW`(DIW@I(\014\v/x\v}`JIRFWIh"),
            Media = IMG_Raebe01
          }
        }, function(action)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      else
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 46343 then
    if V_StoryLine < 210 then
      _Urwigo.MessageBox({
        Text = _yhK5(")\vI(9UWFi\v1I(\v+`(I\v@I(\014F\b\t}Wi:(iI\v+`(i\v`(p\bF1WF`\v+\002JIW(\028W\b@1\txFI\002JI:(1\vI(F\b+(\b@`IW+\002J\vI1x\v\002JI@(Fx`I@(\127\bx`\bWI@(/IRF@@`(\v+`:(P\vI(\027IDUy`I@:(]F`I\v@FiIW\vRF:(\001J\v@F(hhh\020\014\\6\020\014\\68\bW(i\v`(o\bIJI(DIx\v@D`(I+()\vW:(1\vI(\027\bDI@(}\t\tI@(Y\b(JFx`I@h(\014Iw}W(@}\002J(I\v@(t@\tFxx(yF++\vIW`(RxFyy+`()\b(1F+(\014\b\002J(x\vI/IW(+\002J@Ixx(P\vI1IW(Y\b+FiiI@(\b@1(D\v/+`(I+(1Ii(\014\v/x\v}`JIRFW(Y\bW\bI\002Rh"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif V_StoryLine == 210 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(/xFI``IW+`(F@+(\a@1I(1I+(\014\b\002JI+(P}()\b(I\v@(\127Fy\v`Ix(I@`1I\002R`(JF+`:(\v@(1Ii(I+(\bi(I\v@(yFFW(RxI\v@IWI(9UWFi\v1I@(DF@Y(\v@(1IW(8FIJI(DIJ`h")
        },
        {
          Text = _yhK5("sIU(+\002JF\b(iFx:(J\vIW(+`IJ`:(1F++(1\vWIR`(@I/I@(1IW(\127\b@\v`Y/\bWD(F\b\002J(I\v@I(9UWFi\v1I(IWW\v\002J`I`(P\bW1Ih(]F++(\b@+(1}\002J(I\v@\tF\002J(@\bW(Y\bW(\003\v\002JIWJI\v`(iFx(@F\002J+IJI@:(}/(1F+(?WFRIx(@\v\002J`(w\vIxxI\v\002J`(1}W`(\v+`h(s\vIW(\v+`(F\b\002J(DI@F\b(/I+\002JW\vI/I@:(P}(iF@(+\vI(\t\v@1I`h"),
          Media = IMG_Raebe01
        }
      }, function(action)
        Z_Orakel.Active = false
        Z_Pyramide.Active = true
        V_StoryLine = 220
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.MessageBox({
        Text = _yhK5("l\bIW(JI\b`I(JF/I(\v\002J(DI@\bD(\bI/IW(9UWFi\v1I@(DIxIW@`h"),
        Media = IMG_Raebe01,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _Urwigo.Hash(string.lower(input)) == 47981 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("hhh(+}(xI/`(+I\v`(iIJWIWI@(J\b@1IW`( FJWI@(1\vWIR`(@I/I@(1IW(\127\b@\v`Y/\bWD(I\v@I(\bI/xI(\022}`I@/I+\002JP}IWIW\v@(@FiI@+(8IRWFi}WF:(F/DI+\002J\vWi`(w}@(1IW(\027\b++I@PIx`(1\bW\002J(I\v@I(\127\byyIx:(1\vI(+\vI(IW+\002JF\t\tI@(JF`(\b@1(w}@(\vJWIW(\003RIxI``!\027WiII(/IPF\002JI@(xFI++`h\020\014\\6\020\014\\6\003I\v`(+\vI(+\v\002J(1}W`(@\vI1IWDIxF++I@(JF`:(yF++\vIWI@(w\vIxI(iIWRP\bIW1\vDI()\v@DIh(\003}(IW+\002JI\v@`(/I\v+y\vIx+PI\v+I(LI1I@(\022FD(DI@F\b(-(o\v@\b`I@(@F\002J(o\v``IW@F\002J`(\b@PI\v`(1IW(\014\bWDW\b\v@I(I\v@(Fx`IW(\028}x1+\002Ji\vI1:(1IW(I\v@+`(1F\t\bIW(/IW\bIJi`(PFW:(1\vI(+\002J}I@+`I@(\027i\bxI``I(\v@(1IW(DF@YI@(\028IDI@1(JIW+`IxxI@(Y\b(R}I@@I@h(mF+(\vJ@(1FY\b(`WI\v/`(/I\v(1IW(\\\b\v@I(JIW\biY\b+y\b\002RI@:(PI\v++(@\vIiF@1(DI@F\b(Y\b(+FDI@h(8\bW(+}w\vIx(\v+`(+\v\002JIW:(8IRWFi}WF(JF`(1F/I\v(\vJWI(l\v@DIW(\vi(\003y\vIxh()IW(]IDI@1I(@F\002J(DI+\002JFJ(I+(+}(hhh")
      }
    }, function(action)
      if T_Amulett.Active == true and T_Amulett.Complete == false then
        _Urwigo.MessageBox({
          Text = _yhK5("sIU:(1IW(RF@@(\027i\bxI``I(/F\bI@h()Ii(+}xx`I@(P\vW(iFx(I\v@I@(\014I+\b\002J(F/+`F``I@h(mF+(+`F@1(1F(DI+\002JW\vI/I@S(-(o\v@\b`I@(@F\002J(o\v``IW@F\002J`h(#\002J(JF/(F/IW(I\vDI@`x\v\002J(RI\v@I(]\b+`:(/\v+(\v@(1\vI(8F\002J`(Y\b(PFW`I@h(]F++(\b@+(1\vI(8F\002J`(J\vIWJIW(J}xI@(hhh"),
          Media = IMG_Raebe01,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      else
        _Urwigo.MessageBox({
          Text = _yhK5("\127x\v@D`(+yF@@I@1:(F/IW(@\v\002J`(LI`Y`h"),
          Media = IMG_Raebe01,
          Callback = function(action)
            if action ~= nil then
              Wherigo.ShowScreen(Wherigo.MAINSCREEN)
            end
          end
        })
      end
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 16101 then
    if V_NachtStatus == 0 or V_NachtStatus == 100 then
      _Urwigo.MessageBox({
        Text = _yhK5(")F+(\014\b\002J(/I+`IJ`(F\b+(xF\b`IW(xIIWI@(\003I\v`I@:(P\vI(xF@DPI\vx\vDh\020\014\\6\020\014\\6\027xxIW1\v@D+(/IiIWR+`()\b(I\v@(xI\v\002J`I+(l\b@RIx@:(PI@@()\b(\v@(I\v@Ii(+IJW(\txF\002JI@(m\v@RIx(F\b\t(1F+(9Fy\vIW(+\002JF\b+`:(\tF+`(+}:(Fx+(}/(1}W`(1}\002J(I`PF+(+`IJ`:(DI+\002JW\vI/I@(\v@(PI\v++IW(\003\002JW\v\t`(F\b\t(PI\v++Ii(\028W\b@1h( F(+\v@1(P\vW(1I@@(J\vIW(\v@(?+`\tW\vI+xF@1S\020\014\\6"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(+\002JxFID+`(1F+(\014\b\002J(F\b\t(\b@1(1F+(PF+(/I\v(\022FDI+x\v\002J`(@\bW(P\vI(I\v@(+\002JPF\002JI+(l\b@RIx@(P\vWR`I:(I@`y\byy`(+\v\002J(/I\v(8F\002J`(Y\bi(\028x\viiI@(w}@(\014\b\002J+`F/I@h()\b(/xFI``IW+`(I\v@(PI@\vD(J\v@(\b@1(JIW(\b@1(/xI\v/+`(1F@@(F@(\t}xDI@1IW(9F++FDI(JFI@DI@B")
        },
        {
          Text = _yhK5("hhh(\b@1(+}(WI\v+`I(1\vI(+\002JPI1\v+\002JI(\028WFI\t\v@(\vi(lW\bIJLFJW(\"0\"\025(w}@(\127\b@\v`Y(@F\002J(m\vI@h(\027xxI(DxF\b/`I@:(+\vI(+I\v(1Fi\v`(w}@(J\vIW(wIW+\002JP\b@1I@:(1}\002J(FxxI(\vWW`I@h()I@@(+\vI(RFi(Y\bW\bI\002R(\b@1(DI\v+`IW`(@\b@(\v@(LI1IW(8F\002J`(1\bW\002J(1\vI(\028W\b@1iF\bIW@(\vJWI+(sF\b+I+h()\b(DxF\b/+`(I+(@\v\002J`S()F@@(+\vIJ(1}\002J(@F\002J\n")
        },
        {
          Text = _yhK5("\127xFW(DxF\b/(\v\002J(I+h(8F\002J+IJI@(P\vxx(\v\002J(F/IW(`W}`Y1Iih(8\bW(P}S"),
          Media = IMG_Raebe01
        },
        {
          Text = _yhK5("#\002J(DxF\b/I:(1F(RF@@(\v\002J(JIx\tI@h()}W`(1W\bI/I@(JF/I(\v\002J(iFx(I\v@I(\022F\tIx(DI+IJI@h()IW(\022I3`(1F(1FWF\b\t(yF++`(Y\b(1\vI+IW(\028I+\002J\v\002J`I(J\vIW(P\vI(1\vI(lF\b+`(F\b\t\024+(\027\bDIh(\028\v/(iFx(1\vI(\127FW`I:(\v\002J(YI\v\002J@I(1\vI(\003`IxxI(I\v@h\020\014\\6\020\014\\6\027/IW(\v\002J(JF/I(1F+(\028I\t\bIJx:(1F+(JF`(i\v`(\b@+IWIW(I\vDI@`x\v\002JI@(\027\b\tDF/I(DFW(@\v\002J`+(Y\b(`\b@h()F+(\t\bIJx`(+\v\002J(F@(P\vI(I\v@(\014}@\b+:(1I@(iF@(F\b\002J(F\b+xF++I@(RF@@(\b@1(\v\002J(/\v@(I\002J`(+\002J}@(DI@\bD(DIxF\b\tI@(JI\b`I(hhh"),
          Media = IMG_Spieler
        },
        {
          Text = _yhK5("o\vW(1}\002J(IDFx:(\v\002J(P\vxx(`W}`Y1Ii(J\v@h"),
          Media = IMG_Raebe01
        },
        {
          Text = _yhK5("siiiiii(hhhhh"),
          Media = IMG_Spieler
        }
      }, function(action)
        Z_Tafel.Active = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(/xFI``IW+`(1\bW\002J(1\vI(\003I\v`I@(1I+(\014\b\002JI+(\b@1(x\vI+`(iFx(J\vIW(I\v@I@(\003F`Y:(iFx(1}W`(I\v@I@:(\t\v@1I+`(F/IW(RI\v@I(\003`IxxI:(1\vI()I\v@(#@`IWI++I(PI\002R`(\b@1(+`Ixx+`(I+(P\vI1IW(Y\bW\bI\002Rh"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_Troll:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 38777 and Player:Contains(P_Troellchen) then
    _Urwigo.MessageBox({
      Text = _yhK5(")I\v@(\\\b\002R+F\002R(+yF@@`(+\v\002J:(1\vI(8FIJ`I(R@FWWI@:(1IW()I\002RIx(P\vW1(F\b\tDI+\002JxI\b1IW`(\b@1(RI\v@I(,(\003IR\b@1I@(+yFI`IW(+`IJ`(I\v@(\022W}xx(\v@(w}xxIW(]I/I@+DW}I++I(w}W()\vWh(\027i(WI\002J`I@(l\b++(`WFID`(IW(I\v@I@(\\\b\002R+F\002R(Fx+(\003\002J\bJh(\003\002J\v\002Rh"),
      Media = IMG_Ba3Troll,
      Callback = function(action)
        if action ~= nil then
          P_Troellchen:MoveTo(nil)
          P_Troll:MoveTo(Z_Holzzelt)
          ITM_Buch.Commands._W7hAn.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 21302 and Z_Holzzelt:Contains(P_Troll) then
    _Urwigo.MessageBox({
      Text = _yhK5("mF+(I/I@(@}\002J(1IW(\003\002J\bJ(I\v@I+(\022W}xx+(PFW(\v+`(@\b@(P\vI1IW(I\v@(\\\b\002R+F\002R(i\v`(I\v@Ii(\022W}xx(1FW\v@h"),
      Media = IMG_Ba3Rucksack,
      Callback = function(action)
        if action ~= nil then
          P_Troll:MoveTo(nil)
          P_Troellchen:MoveTo(Player)
          ITM_Buch.Commands._W7hAn.Enabled = false
          if P_Troll:Contains(ITM_Buch) then
            ITM_Buechlein:MoveTo(Player)
            ITM_Buechlein.Commands._Tlyh.Enabled = true
            P_Troellchen.Commands._oO8w.Enabled = false
          end
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\022W}xx(F@`P}W`I`B(Z[}xx(/IYFJxI@hZ"),
      Media = IMG_Troellchen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_VorOrtCheck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 64075 or _Urwigo.Hash(string.lower(input)) == 55241 then
    _Urwigo.MessageBox({
      Text = _yhK5("9IW\tIR`:(1F@@(xF++(\b@+(F\b\t/WI\002JI@h(#\002J(\tx\vID(w}WF\b+h(l}xDI(i\vWh\020\014\\6)F+(\022W}xx!9F++P}W`(RI@@+`()\b(J}\t\tI@`x\v\002J(F\b\002Jh(mI@@(@\v\002J`:(1WIJ(x\vI/IW(LI`Y`(\bi:(Fx+(+yFI`IWh"),
      Media = IMG_Kunitz2,
      Callback = function(action)
        if action ~= nil then
          Z_Kunitz.Active = false
          Z_Bergauf10.Active = true
          Z_Parkplatz.Active = false
          Z_Parkplatz2.Active = false
          T_Kunitz.Complete = true
          T_NachOben.Active = true
          P_Raebe:MoveTo(Z_Bergauf10)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("\003`\vii`(@\v\002J`(DF@Yh(9W}/\vIW\024+(@}\002J(iFxh"),
      Media = IMG_Kunitz2,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_Schatzkiste:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 38897 then
    _Urwigo.MessageBox({
      Text = _yhK5("Z\028}x1(RF@@(iF@(@\vI(DI@\bD(JF/I@Z(1F\002J`I@(F\b\002J(+\002J}@(F@1IWI(w}W()\vW(\b@1(+\v@1(1Fi\v`(iFI\002J`\vD(F\b\t(1\vI(8F+I(DI\tFxxI@h(\027/IW()\b(P\vW+`(+\002J}@(P\v++I@:(PF+()\b(`\b+`h"),
      Media = IMG_Gold,
      Callback = function(action)
        if action ~= nil then
          ITM_Muenzen:MoveTo(Player)
          ITM_Muenzen.Commands._eNmRW.Enabled = true
          V_SchatzStatus = 1
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 51134 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\a@1x\v\002J(JF+`()\b(1I@(JI\vx\vDI@(\028WFx(DI\t\b@1I@h"),
        Media = IMG_Indy2
      },
      {
        Text = _yhK5(")\b(JF+`(\vJ@(YPFW(@\vI(DI+\b\002J`:(\vi(\028IDI@+F`Y(Y\b(iF@\002J(F@1IWI@:(hhh"),
        Media = IMG_Indy
      },
      {
        Text = _yhK5("hhh(1F+(iF\002J`(1I@(l\b@1(LI1}\002J(@\v\002J`(PI@\vDIW(IW\tWI\bx\v\002Jh"),
        Media = IMG_Indy2
      }
    }, function(action)
      ITM_Gral:MoveTo(Player)
      ITM_Gral.Commands._DYufo.Enabled = true
      ITM_Gral.Commands._VGq_t.Enabled = true
      V_SchatzStatus = 1
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 50315 then
    if V_EasyMode == 1 then
      _Urwigo.MessageBox({
        Text = _yhK5("\a\v@(\028\bii\v!#i\v`F`(I\v@I+(\027i\bxI``+h(m\vI(yWFR`\v+\002J:(DI@F\b(+}(PF+(+\b\002J+`()\b:(\b@DI\tFIJW(Y\bi\v@1I+`h()F@I/I@(x\vID`(@}\002J(I\v@([I``Ix:(F\b\t(1Ii(+`IJ`B(Z\027@DI\tIW`\vD`(w}i(\bWFx`I@(\028I\v+`(I\v@I+(/IW\bIJi`I@(\028}x1+\002Ji\vI1+(\t\bIW(I\v@I@(PFJWI@(sIx1I@hZ("),
        Media = IMG_Kettchen,
        Callback = function(action)
          if action ~= nil then
            ITM_Amulett:MoveTo(Player)
            ITM_Amulett.Commands._qFJH.Enabled = true
            V_SchatzStatus = 1
            T_Amulett.Complete = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif V_SchmiedStatus < 20 then
      _Urwigo.MessageBox({
        Text = _yhK5(")\b(I@`+\002JI\v1I+`()\v\002J(\t\bIW(1I@(\027@JFI@DIWh(\014I+}@1IW+(PIW`w}xx(+\vIJ`(IW(@\v\002J`(DIWF1I(F\b+h(\003\v\002JIW(JF`(IW(Z\v@@IWIW(mIW`IZ:(+}@+`(xFIDI(IW(LF(@\v\002J`(\v@(I\v@IW(\003\002JF`Y`W\bJIh"),
        Media = IMG_Anhaenger,
        Callback = function(action)
          if action ~= nil then
            ITM_Anhaenger:MoveTo(Player)
            ITM_Anhaenger.Commands._GpSaB.Enabled = true
            V_SchatzStatus = 1
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("8\b@(LF:(DI@F\b(DI@}iiI@(\v+`(I+(LF(RI\v@(\027@JFI@DIW(iIJW:(+}@1IW@(I\v@(\127I``\002JI@h(\027/IW(1F+(i\bI++I@(1\vI(9\vWF`I@(@\v\002J`(P\v++I@:(+}@+`(LFiiIW@(+\vI(P\vI1IW:(PF+(P\vW(i\v`(\vJWIi(\127WFi(DIiF\002J`(JF/I@:(Fx+}(@I@@I@(P\vW(I+(W\bJ\vD(PI\v`IW(\027@JFI@DIWh"),
        Media = IMG_Kettchen,
        Callback = function(action)
          if action ~= nil then
            ITM_Amulett:MoveTo(Player)
            ITM_Amulett.Commands._qFJH.Enabled = true
            V_SchatzStatus = 1
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif _Urwigo.Hash(string.lower(input)) == 55695 then
    _Urwigo.MessageBox({
      Text = _yhK5("\014W\vI\tiFWRI@(+FiiIx@(\v+`(LF(I\vDI@`x\v\002J(I\v@(/\v++\002JI@(F\b+(1IW(o}1I(DIR}iiI@h(\027/IW(/I\v(I\v@IW(\014xF\bI@(oF\bW\v`\v\b+(RF@@(iF@(+\002J}@(iFx(I\v@I(\027\b+@FJiI(iF\002JI@h"),
      Media = IMG_BlaueMauritius,
      Callback = function(action)
        if action ~= nil then
          ITM_Briefmarke:MoveTo(Player)
          ITM_Briefmarke.Commands._XQgLK.Enabled = true
          V_SchatzStatus = 1
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 25461 then
    if V_EasyMode == 0 then
      _Urwigo.MessageBox({
        Text = _yhK5("\a\v@I(\022F+\002JI@\bJW:(P\vI(+\vI(F\b\002J()I\v@(tW}yF(/I+I++I@(JF`h(\028IWF1I(\v@(1\vI+Ii(\027\bDI@/x\v\002R(P\vW1()\vW(RxFW:(PFW\bi(IW()I\v@(tJW!?yF(PFWh"),
        Media = IMG_Uhr,
        Callback = function(action)
          if action ~= nil then
            ITM_Uhr:MoveTo(Player)
            ITM_Uhr.Commands._HcSK.Enabled = true
            V_SchatzStatus = 1
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("t@`IW()\vW(J}IW+`()\b(I\v@I@(1IW(9\vWF`I@(W\b\tI@B(Z)\vI(\v+`(@\bW(\t\bIW(PFJWI(sIx1I@h(mFWi1\b+\002JIW(R}I@@I@(1Fi\v`(@\v\002J`+(F@\tF@DI@hZ"),
        Media = IMG_Piraten6,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end
end
function INP_Uhrzeit:OnGetInput(input)
  local _Urwigo_Date = os.date("*t")
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _yhK5("mF+(PFW(1I@@(1F+(\t\bIW(I\v@I([FJxS")
    })
    return
  end
  V_TaschenuhrZeit = input
  if V_TaschenuhrZeit < 0 then
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(DIJ`(@\v\002J`:(I\v@(o\v@\b+(R}ii`(\v@(1Ii(lIx1(@\v\002J`(w}W"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_TaschenuhrZeit > 1439 then
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(DIJ`(@\v\002J`:(1\vI(DW}I++`I([FJx:(1\vI(iF@(I\v@DI/I@(RF@@(\v+`(1\vI(\"\025j\015h()F@F\002J(+\002J@\vyy+`(1\vI(\027@YI\vDI(P\vI1IW(F\b\t(zh"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    V_TaschenuhrZeit = V_TaschenuhrZeit + _Urwigo.Date_MinuteInDay(_Urwigo_Date)
    if V_TaschenuhrZeit == 1445 then
      _Urwigo.MessageBox({
        Text = _yhK5(")\vI([I\vDIW(1IW(tJW(/ID\v@@I@(+\v\002J(Y\b(1WIJI@(\b@1(/xI\v/I@(F\b\t(-(o\v@\b`I@(@F\002J(\",(+`IJI@h()\b(xFI++`(1I@(\127@}y\t(x}+:(1}\002J(IW(+\002JI\v@`(I`PF+(Y\b(RxIiiI@h(ti()\v\002J(JIW\bi(P\vW1(I+(1\b@RxIW:(1IW(m\v@1(Y\vIJ`(xI\v\002J`(F@h(\027@()I\v@Ii(?JW(y\tI\v\t`(I\v@I(\014}II(w}W/I\v(\b@1(+FI\b+Ix`(Z\014\bJJJJJJJJJJJJJJZh()\b(/\v+`()\vW(DFW(@\v\002J`(iFx(+}(+\v\002JIW:(}/(1IW(m\v@1(FxxI\v@(J\vIW(1\vI(\028IWFI\b+\002JI(iF\002J`:(}1IW(}/(1F(w\vIxxI\v\002J`(LIiF@1(@F\002JJ\vx\t`:(\vWDI@1P}hhh:(r@/+yO\v@(1IW()\b@RIxJI\v`(hhhh"),
        Callback = function(action)
          if action ~= nil then
            FCT_NachtmodusAn()
            TMR_NachtAus:Start()
            if Z_Mitternacht:Contains(Player) then
              FCT_NachtStartGespraech()
            end
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      V_TempStr = _yhK5(")\vI([I\vDIW(1IW(tJW(/ID\v@@I@(+\v\002J(Y\b(1WIJI@(\b@1(/xI\v/I@(/I\v(")
      V_TempStr2 = _yhK5("(tJW(+`IJI@h()F/I\v(JF+`()\b(1F+(\028I\t\bIJx:(1\vI(mIx`(\bi()\v\002J(JIW\bi(wIWFI@1IW`(+\v\002Jh()\b(xFI++`(1I@(\127@}y\t(x\vI/IW(P\vI1IW(x}+(\b@1(+\002JF\b+`(Y\b:(P\vI(+\v\002J(1\vI([I\vDIW(Y\bW\bI\002R(F\b\t(\vJWI(\bW+yW\bI@Dx\v\002JI(9}+\v`\v}@(/IPIDI@h")
      V_TempStr = (V_TempStr .. MinutesToTime(V_TaschenuhrZeit)) .. V_TempStr2
      _Urwigo.MessageBox({
        Text = V_TempStr,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end
end
function INP_NachtEnde:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 6491 then
    _Urwigo.MessageBox({
      Text = _yhK5("\127F\bi(JF+`()\b(1F+(m}W`(F\b+DI+yW}\002JI@:(J}IW+`()\b(I\v@(I@`\tIW@`I+(\127xF\002RI@h()IW(\127@}y\t(F@(1IW(tJW(+\002JI\v@`(+\v\002J(P\vI1IW(DIx}I+`(Y\b(JF/I@h(ti()\v\002J(JIW\bi(\tx\viiIW`(I+(R\bWY:(1F@@(P\vW1(I+(P\vI1IW(JIxxIW(\b@1(FxxI+(\v+`(P\vI1IW(@}WiFxh"),
      Callback = function(action)
        if action ~= nil then
          ITM_Schild:MoveTo(nil)
          T_Zeitsprung.Complete = true
          FCT_NachtmodusAus()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("8\v\002J`+(yF++\vIW`h(\003\002JI\v@`(\vWDI@1P\vI(1F+(\tFx+\002JI(m}W`(DIPI+I@(Y\b(+I\v@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_Wegweiser:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 10491 then
    _Urwigo.MessageBox({
      Text = _yhK5("\028I+\002JF\t\t`h(t@1(@\b@(@\v\002J`+(P\vI(Y\bW\bI\002R(Y\b(\ai\vx\v}h"),
      Callback = function(action)
        if action ~= nil then
          V_StoryLine = 255
          Z_Wegweiser.Active = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("#WDI@1P\vI(JF+`()\b(1F+(\028I\t\bIJx:()\b(JF+`()\v\002J(wIW`F@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_FinalHint:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 45374 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\003\002JF\b(iFx(1}W`(1\vI(,(\014FI\biI:(1\vI(+}(1\v\002J`(Y\b+FiiI@(+`IJI@h"),
        Media = IMG_XNah0
      },
      {
        Text = _yhK5("t@`I@(J\v@`IW(1Ii(\003`I\v@h"),
        Media = IMG_XNah
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_UnlockCode:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 6485 then
    T_Belohnung.Complete = true
    if V_EasyMode == 0 then
      _Ftnpx.Complete = true
      ITM_CoCaFM:MoveTo(Player)
      V_StoryLine = 395
      _Ftnpx:RequestSync()
      _Urwigo.MessageBox({
        Text = _yhK5("Z\028I@F\bZ(+FD`(1\vI(lxI1IWiF\b+h(Z)IW(t@x}\002R!\001}1I(+`IJ`(J\vIW(F\b\t(1IW(\\\bI\002R+I\v`I(iI\v@IW({\v+\v`I@RFW`IhZ\020\014\\6o\v`(1\vI+I@(m}W`I@(P\vW\t`(+\vI(\v@(I\v@Ii(yIW\tIR`(F\b+DI\t\bIJW`I@(lx\bIDIx+\002JxFD(I\v@(RxI\v@I+(\127FIW`\002JI@(\v@()I\v@I@(\\\b\002R+F\002Rh\020\014\\6\020\014\\6\027\b++IW1Ii(RF@@(\v\002J()\vW(@}\002J(I`PF+(\003`F`\v+`\vR(wIWWF`I@h"),
        Media = IMG_Fledermaus0,
        Callback = function(action)
          if action ~= nil then
            FCT_Statistik()
          end
        end
      })
    else
      V_StoryLine = 395
      _Urwigo.MessageBox({
        Text = _yhK5("Z\028I@F\bZ(+FD`(1\vI(lxI1IWiF\b+h()\b(JF+`(Fx+}(1\vI()}+I(`F`+FI\002Jx\v\002J(DI\t\b@1I@h(#\002J(DWF`\bx\vIWI()\vWh()I@(t@x}\002R!\001}1I(RF@@(\v\002J()\vW(F/IW(xI\v1IW(`W}`Y1Ii(@\v\002J`(DI/I@h()IW(\v+`(@\bW(\t\bIW(PFJWI(sIx1I@(DII\vD@I`h(sF`(+\002JFW\tI(\127F@`I@:(Y\b(J}JI({IWxI`Y\b@D+DI\tFJW:()\b(wIW+`IJ+`(hhh\020\014\\6\020\014\\6\027/IW(\v\002J(RF@@()\vW(@}\002J(I`PF+(\003`F`\v+`\vR(wIWWF`I@h"),
        Media = IMG_Fledermaus0,
        Callback = function(action)
          if action ~= nil then
            FCT_Statistik()
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _yhK5("8II:(+`\vii`(@\v\002J`h"),
      Media = IMG_Fledermaus0,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_Spinne1:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 36407 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I(]F`IW@I(\b@1(PI@@()\b(@\v\002J`(F\b+yF++`:(1F@@(iF\002JI(\v\002J(F\b+()\vW(I\v@I@(\tI``I@(\003y\v@@I@/WF`I@h"),
        Media = IMG_SpinneR1
      },
      {
        Text = _yhK5(" F(RxFW:()\b(\v++`(\003y\v@@I@/WF`I@h(\003}(+\vIJ+`()\b(+\002J}@(F\b+h"),
        Media = IMG_SpinneS1
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne1)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 32726 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I@(\022W}xx(\b@1(\v\002J(PIW1I(\vJ@(/I@\b`YI@h"),
        Media = IMG_SpinneR1
      },
      {
        Text = _yhK5("\aWPFIJ@`I(\v\002J(+\002J}@:(1F++(iI\v@(\028\v\t`(+}(+`FWR(\v+`:(1F++(I\v@(\014\v++(\t\bIW(\"z(\022W}xxI(WI\v\002J`S"),
        Media = IMG_SpinneS1
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne1)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 53193 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(/\v@(/Fx1(I\v@(iFI\002J`\vDIW(9\vWF`:(Fx+}(PI@@(1F+()}R\biI@`(\bI/IW+I`Y`(\v+`h(\027/IW(1F+(DIJ`()\v\002J(DFW(@\v\002J`+(F@h()\b(i\b++`(@\bW(P\v++I@B(9#\\\027\022:(/\bJh"),
        Media = IMG_SpinneR1
      },
      {
        Text = _yhK5("\003`I\002R()\vW()I\v@(Z/\bJZ(+}@+`(P}(J\v@h(?/P}Jx:(PFW`I(iFx:(i\v`(9\vWF`I@(PFW(1F(PF+(\v@(1IW(9W}yJIYI\v\b@Dh(8I\v@:(F/IW(1F+(RF@@(@\v\002J`(+I\v@h"),
        Media = IMG_SpinneS1
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne2)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 6930 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF++I(\003y\v@@I@h"),
        Media = IMG_SpinneR1
      },
      {
        Text = _yhK5("t@1(\v\002J(JF++I(\\F/I@h"),
        Media = IMG_SpinneS1
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne1)
      end)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFh(m\b++`(\v\002J(I+(1}\002Jh()\b(/\v+`(i\vW(@\v\002J`(DIPF\002J+I@h"),
        Media = IMG_SpinneS1
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_Spinne2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 18036 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I@(\027+`:(1I@(JF`(i\vW(I\v@(+yWI\002JI@1IW(\014F\bi(DI+\002JI@R`h"),
        Media = IMG_SpinneR2
      },
      {
        Text = _yhK5("8F(\b@1:(PF+(P\vxx+`()\b(1Fi\v`(iF\002JI@S(#J@(1FY\b(/W\v@DI@:(1F++(IW(i\vW(\028I+\002J\v\002J`I@(IWYFIJx`(\b@1(i\v\002J(1Fi\v`(Y\b(\022}1I(xF@DPI\vx`S"),
        Media = IMG_SpinneS2
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne1)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 32726 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I@(\022W}xx(\b@1(\v\002J(PIW1I(\vJ@(/I@\b`YI@h"),
        Media = IMG_SpinneR2
      },
      {
        Text = _yhK5("\aWPFIJ@`I(\v\002J(+\002J}@:(1F++(iI\v@(\028\v\t`(+}(+`FWR(\v+`:(1F++(I\v@(\014\v++(\t\bIW(\"z(\022W}xxI(WI\v\002J`S"),
        Media = IMG_SpinneS2
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne2)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 17767 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(/\v@(I\v@(\\F/I:(+}(+\002JPFWY(P\vI(1\vI(8F\002J`(\b@1(PIW1I()\v\002J(1F+(l\bIW\002J`I@(xIJWI@h"),
        Media = IMG_SpinneR2
      },
      {
        Text = _yhK5("\a\v@(\\F/I:(P\vI(+\bI++h(\003\002JPFWY(P\vI(1\vI(hhh(S({IW1Fii`h(\\F/I@(+\v@1(+\002JPFWYh(t@1(9\vWF`(P\vxx(IW(PIW1I@h(\a\v@(+\002JPFWYIW(9\vWF`h(\027IJi:()\b:(+FD(iFx:(JF+`()\b(+\002J}@(iFx(1FW\bI/IW(@F\002JDI1F\002J`:()I\v@I(lI1IW@(Y\b(\tFIW/I@S(\003\002JPFWY(\v+`(LF(w}Ixx\vD(F\b+(1IW(o}1I(DIR}iiI@h"),
        Media = IMG_SpinneS2
      },
      {
        Text = _yhK5("\003\002JPFWY(P\vI(1\vI(8F\002J`\n"),
        Media = IMG_SpinneR3
      },
      {
        Text = _yhK5("o\v+`h"),
        Media = IMG_SpinneS3
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne3)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 6930 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF++I(\003y\v@@I@h"),
        Media = IMG_SpinneR2
      },
      {
        Text = _yhK5("t@1(\v\002J(JF++I(\\F/I@h"),
        Media = IMG_SpinneS2
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne2)
      end)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFh(m\b++`(\v\002J(I+(1}\002Jh()\b(/\v+`(i\vW(@\v\002J`(DIPF\002J+I@h"),
        Media = IMG_SpinneS2
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_Spinne3:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 56657 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(RF@@(1\vI([I\v`(iF@\vy\bx\vIWI@:(DF@Y(}J@I(lx\b3R}iyI@+F`}Wh(#\002J(/WF\b\002JI(1FY\b(@\bW(I\v@I(tJW:(1\vI(hhh(FIJi(hhh(x\vID`(DxI\v\002J(1}W`(1W\bI/I@(\v@(1IW(9\vWF`I@R\v+`Ih(\028FW(@\v\002J`(PI\v`(PID:(@\v\002J`(PI\v`(PIDh"),
        Media = IMG_SpinneR3
      },
      {
        Text = _yhK5("\022F`+FI\002Jx\v\002J:(\v\002J(+y\bIWI(I+h(\028IWF1I(I/I@(JF+`()\b()\v\002J(P\vI1IW(I\v@I(\\\b@1I(\v@(1IW([I\v`(Y\bW\bI\002R(iF@\vy\bx\vIW`h(\028WF`\bx\vIWIh"),
        Media = IMG_SpinneS3
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne2)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 32726 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I@(\022W}xx(\b@1(\v\002J(PIW1I(\vJ@(/I@\b`YI@h"),
        Media = IMG_SpinneR3
      },
      {
        Text = _yhK5("\aWPFIJ@`I(\v\002J(+\002J}@:(1F++(iI\v@(\028\v\t`(+}(+`FWR(\v+`:(1F++(I\v@(\014\v++(\t\bIW(\"z(\022W}xxI(WI\v\002J`S"),
        Media = IMG_SpinneS3
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne3)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 23512 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(RI@@I(I\v@I@()WF\002JI@:(1Ii(JF/I(\v\002J(DIJ}x\tI@(\b@1(+I\v`1Ii(+\v@1(P\vW(1\v\002RI(lWI\b@1Ih(mI@@(1IW(JIWR}ii`:(1F@@(hhh"),
        Media = IMG_SpinneR3
      },
      {
        Text = _yhK5(" I`Y`(P\vW1(i\vW(1\vI(\003F\002JI(F/IW(\b@JI\vix\v\002J:(I\v@(+\002JPFWYIW(9\vWF`(i\v`(I\v@Ii()WF\002JI@h(\027/IW(\v\002J(wIWyxFyyIW(i\v\002Jh()Fw}@(RF@@+`()\b(@\v\002J`+(P\v++I@(\b@1(\v\002J(PIW1I(I+(@\v\002J`(wIWWF`I@h"),
        Media = IMG_SpinneS3
      },
      {
        Text = _yhK5("\003}(+}:(1IW()WF\002JI(iF\002J`()\vW(Fx+}(\027@D+`h(#\002J(PIW1\024+(i\vW(iIWRI@h"),
        Media = IMG_SpinneR4
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne4)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 22937 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(RI@@I(I\v@I@(\014\v/x\v}`JIRFW:(1IW(JF`(FxxI(\014\bI\002JIW(1IW(mIx`(\b@1(1F(+`IJ`(/I+`\vii`(F\b\002J(\v@(I\v@Ii(1W\v@:(P\vI(iF@(+\v\002J(xFI+`\vDI(\003y\v@@I@(w}@(sFx+(+\002JF\t\t`h"),
        Media = IMG_SpinneR3
      },
      {
        Text = _yhK5(")I@(RI@@I(\v\002J(F\b\002J(\b@1(+I\v@I(\003y\v@@I@/\bI\002JIW(JF/I(\v\002J(FxxI(\v@(\028\v\t`(F\b\tDIx}I+`h"),
        Media = IMG_SpinneS3
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne3)
      end)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFh(m\b++`(\v\002J(I+(1}\002Jh()\b(/\v+`(i\vW(@\v\002J`(DIPF\002J+I@h"),
        Media = IMG_SpinneS3
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_Spinne4:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 32726 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I@(\022W}xx(\b@1(\v\002J(PIW1I(\vJ@(/I@\b`YI@h"),
        Media = IMG_SpinneR4
      },
      {
        Text = _yhK5("\aWPFIJ@`I(\v\002J(+\002J}@:(1F++(iI\v@(\028\v\t`(+}(+`FWR(\v+`:(1F++(I\v@(\014\v++(\t\bIW(\"z(\022W}xxI(WI\v\002J`S"),
        Media = IMG_SpinneS4
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne4)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 36407 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/I(I\v@I(]F`IW@I(\b@1(\v@(1IW(/WI@@`(I\v@(lI\bIW:(1F+(JF`(i\vW(1IW()WF\002JI(F@DIY\bI@1I`h(s}IW+`(1\b:(1IW()\\\027\001s\a\n\n\n"),
        Media = IMG_SpinneR4
      },
      {
        Text = _yhK5("m\027\003S()\b(JF+`(1F+()WF\002JI@\tI\bIW(/I\v()\vWS(#\002J(/\v@(1F@@(iFx(PIDh(\003}xx(1}\002J(8IRWFi}WF(\vJWI@(/x}I1I@(mIDPI\v+IW(FxxI\v@I(/IPF\002JI@h"),
        Media = IMG_SpinneS4
      }
    }, function(action)
      _aRYZ3:MoveTo(nil)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 22937 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(RI@@I(I\v@I@(\014\v/x\v}`JIRFW:(1IW(JF`(FxxI(\014\bI\002JIW(1IW(mIx`(\b@1(1F(+`IJ`(/I+`\vii`(F\b\002J(\v@(I\v@Ii(1W\v@:(P\vI(iF@(+\v\002J(xFI+`\vDI(\003y\v@@I@(w}@(sFx+(+\002JF\t\t`h"),
        Media = IMG_SpinneR4
      },
      {
        Text = _yhK5(")I@(RI@@I(\v\002J(F\b\002J(\b@1(+I\v@I(\003y\v@@I@/\bI\002JIW(JF/I(\v\002J(FxxI(\v@(\028\v\t`(F\b\tDIx}I+`h"),
        Media = IMG_SpinneS4
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne4)
      end)
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 6930 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF++I(\003y\v@@I@h"),
        Media = IMG_SpinneR4
      },
      {
        Text = _yhK5("t@1(\v\002J(JF++I(\\F/I@h"),
        Media = IMG_SpinneS4
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Spinne3)
      end)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFh(m\b++`(\v\002J(I+(1}\002Jh()\b(/\v+`(i\vW(@\v\002J`(DIPF\002J+I@h"),
        Media = IMG_SpinneS4
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_ModusFestlegen:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 27845 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(INP_WarmDuscherRetry)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("8\v\002J`+(F@1IWI+(JF/I(\v\002J(IWPFW`I`h(s\vIW(@\vii(Fx+(\014Ix}J@\b@D(1\vI+I+(PI\v++I(\022\b\002J(w}@(i\vWh(\a+(\v+`(@\v\002J`(w\vIx:(F/IW()\b(+\vIJ+`(+}(F\b+:(Fx+(R}I@@`I+`()\b(I+(\vWDI@1PF@@(DI/WF\b\002JI@h"),
        Media = IMG_Ba1G
      },
      {
        Text = _yhK5(")IW(\\FI/I(1I@R`(R\bWY(1FW\bI/IW(@F\002J:(P\vI(iF@(P}Jx(F\b++IJI@(i\b++:(\bi(\v@(1\vI(\127F`ID}W\vI(Z/WF\b\002J`(PI\v++I+(\022\b\002JZ(Y\b(\tFxxI@:(+FD`(1F@@(F/IW(1}\002J(@\bWB(Z{\vIxI@()F@R:(F/IW(1F+(PFIWI(1}\002J(P\vWRx\v\002J(@\v\002J`(@}I`\vD(DIPI+I@h(#\002J(DxF\b/:(P\vW(i\bI++I@(1F@@(LI`Y`(F\b\002J(iFx(PI\v`IWh(oF\002J+(D\b`:(s\bIJ@\002JI@hZ"),
        Media = IMG_Ba1E
      }
    }, function(action)
      V_EasyMode = 0
      ITM_WeissesTuch:MoveTo(Player)
      Z_Bergauf10.Active = false
      Z_Bergauf20.Active = true
      T_Troll.Complete = true
      P_Raebe:MoveTo(Z_Bergauf20)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function INP_WarmDuscherRetry:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 22124 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(\bI/IWWF+\002J+`(i\v\002Jh(#\002J(JFI``I()\vW(iIJW(Y\bDI`WF\b`h(8\b@:(1F@@(P\vxx(\v\002J()\vW(1\vI+I+(/\b@`I(\022\b\002J(+\002JI@RI@h(\a+(PFW(\tW\bIJIW(iFx(PI\v++h(#\002J(JF/I(I+(yIW+}I@x\v\002J(\vi(sI\vx\vDI@(\028WFx(DI\tFIW/`h(lFIW/I@(\v+`(@FIix\v\002J(I\v@I(\027\b\tDF/I(\t\bIW(PFJWI(sIx1I@h()FW\bi(i\b++`()\b()\v\002J(@\b@(@\v\002J`(iIJW(R\bIiiIW@h"),
        Media = IMG_Ba1K
      },
      {
        Text = _yhK5("\a\v@(PI@\vD(Y\v\002R\vD(1F+(s\bIJ@\002JI@:(1I@R`(1IW(\\FI/I:(+FD`(1F@@(F/IW(1}\002J(@\bWB(Z{\vIxI@()F@R:(F/IW(1F+(PFIWI(1}\002J(P\vWRx\v\002J(@\v\002J`(@}I`\vD(DIPI+I@h(#\002J(DxF\b/:(P\vW(i\bI++I@(1F@@(LI`Y`(F\b\002J(iFx(PI\v`IWh(oF\002J+(D\b`:(s\bIJ@\002JI@hZ"),
        Media = IMG_Ba1E
      }
    }, function(action)
      V_EasyMode = 1
      ITM_BuntesTuch:MoveTo(Player)
      Z_Bergauf10.Active = false
      Z_Bergauf20.Active = true
      T_Troll.Complete = true
      P_Raebe:MoveTo(Z_Bergauf20)
      T_Kopftuch.Complete = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(INP_ModusFestlegen)
    end)
  end
end
function INP_DevToolDrop:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53452 then
    _Urwigo.MessageBox({
      Text = _yhK5("\014\v``Ih"),
      Media = IMG_Lollis,
      Callback = function(action)
        if action ~= nil then
          ITM_DevTool:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("]}xx\v+(JF/I@(RI\v@I(?JWI@:(Fx+}(PF+(+}xx(1F+S"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _F7OU:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 38243 then
    V_EasyMode = 1
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(mFWi1\b+\002JIWh("),
      Media = IMG_Raebe01,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 20062 then
    V_HeuteIstWeihnachten = true
    _Urwigo.MessageBox({
      Text = _yhK5("lW}JI(mI\vJ@F\002J`I@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _Urwigo.Hash(string.lower(input)) == 64413 then
    V_FlyerGelesen = true
    _Urwigo.MessageBox({
      Text = _yhK5("mI\vJ@F\002J`I@(RF@@(R}iiI@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function INP_Geisterfrage:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 3999 or _Urwigo.Hash(string.lower(input)) == 30810 or _Urwigo.Hash(string.lower(input)) == 42758 or _Urwigo.Hash(string.lower(input)) == 57148 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\127FWx(\027\bD\b+`S(\a@1x\v\002J(/\v+`()\b(Y\bW\bI\002R\n(#\002J(JFI``I()\v\002J(\tF+`(@\v\002J`(IWRF@@`h"),
        Media = IMG_EinsiedelB07
      },
      {
        Text = _yhK5("8F(LF:(\v\002J(/I\tF++I(i\v\002J(\v@(xI`Y`IW([I\v`(I`PF+(i\v`(9\vWF`IW\vIh()F+(xFI++`(i\v\002J(+\v\002JIW(wIWPIDI@IW(F\b++IJI@\n"),
        Media = IMG_EinsiedelB08
      },
      {
        Text = _yhK5("?J(LF:(1F+(\v+`(I+:(wIWPIDI@\n"),
        Media = IMG_EinsiedelB07
      },
      {
        Text = _yhK5("t@1:(PF+(iF\002J+`()\b(+}S"),
        Media = IMG_EinsiedelB08
      },
      {
        Text = _yhK5("#\002J(xI+I(w\vIxh([\bi(\028x\bI\002R(D\v/`(I+(J\vIW(I\v@I@(\014\v/x\v}`JIWRFW:(1IW(\viiIW(IW+\002JI\v@`:(PI@@(iF@(I\v@(@I\bI+(\014\b\002J(/WF\b\002J`h(\028IWF1I(JI\b`I(i}WDI@(PFW(IW(P\vI1IW(J\vIWh("),
        Media = IMG_EinsiedelB07
      },
      {
        Text = _yhK5("#\002J(DxF\b/I:(1I@(RI@@I(\v\002J(F\b\002Jh(#@(1IW(\022F`:(+IJW(@\bI`Yx\v\002Jh"),
        Media = IMG_EinsiedelB08
      },
      {
        Text = _yhK5(")F+(\v+`(LF(IW+`F\b@x\v\002Jh(\aW(PI\v++(1}\002J:(1F++(\v\002J(F\b\t()\v\002J(PFW`I(\b@1(JF`(I+(`W}`Y1Ii(@\vI(IWPFIJ@`h(oI\v@I@(P\vW(P\vWRx\v\002J(1I@+Ix/I@S(\003\002JF\b(iFx:(1}W`(\b@`I@(i\b++(\vWDI@1P}(I\v@I({\v+`\v`I@RFW`I(w}@(\vJi(x\vIDI@h()\vI(\v+`(JI\b`I(i}WDI@(F\b+(1Ii(\014\b\002J(DI\tFxxI@h(#+`(I+(1IWS"),
        Media = IMG_EinsiedelB07
      }
    }, function(action)
      ITM_CoCaBib:MoveTo(Z_Einsiedelei)
      V_EinsiedeleiStatus = 20
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Z8I\v@:(F\b\t()\v\002J(PFW`I(\v\002J(@\v\002J`h(\003\b\002J()\vW(I\v@I@(F@1IWI@(\028I\v+`:(i\v`(1Ii()\b(+y\vIxI@(RF@@+`hZ(o\v`(1\vI+I@(m}W`I@(1WIJ`I(+\v\002J(1IW(\028I\v+`(\bi(\b@1(x\vI\t(\v@(1\vI()\b@RIxJI\v`(1IW(8F\002J`(J\v@I\v@:(+}(PI\v`(\vJ@(+I\v@I(\028I\v+IW/I\v@I(`WFDI@(R}@@`I@h(mF+(\b@DI\tFIJW(j(oI`IW(PFWI@h"),
        Media = IMG_EinsiedelB09
      },
      {
        Text = _yhK5("\003\002JI\v@`(I`PF+(Y\v\002R\vD(Y\b(+I\v@:(1\vI(\028\b`Ih(\028F@Y(RxFW(I\v@I(sIWY}D\v@h(\127F@@+`()\b()\v\002J(IW\v@@IW@:(PF+(+\vI(+}(FxxI+(\t\bIW(]I\b`I(RF@@`IS"),
        Media = IMG_EinsiedelB08
      },
      {
        Text = _yhK5("#\002J(hhh(FIJiii:(hhh(@IIS"),
        Media = IMG_Spieler
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function TMR_Hunger:OnTick()
  _Urwigo.MessageBox({
    Text = _yhK5("st8\028\a\\\n"),
    Media = IMG_Raebe02,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function TMR_SkelettDraussen:OnStart()
  ITM_Keule.Commands._w5mQ_.Enabled = false
  P_Skelett:MoveTo(nil)
end
function TMR_SkelettDraussen:OnTick()
  TMR_SkelettDrinnen:Start()
end
function TMR_SkelettDrinnen:OnStart()
  P_Skelett:MoveTo(Z_Nekramora)
  if Player:Contains(ITM_Keule) then
    ITM_Keule.Commands._w5mQ_.Enabled = true
  end
end
function TMR_SkelettDrinnen:OnTick()
  TMR_SkelettDraussen:Start()
end
function TMR_NachtAus:OnTick()
  if V_NachtStatus < 10 then
    FCT_NachtmodusAus()
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(J}IW+`(I\v@(\127xF\002RI@(F@(1IW(tJWh(\003\002JI\v@/FW(JF`(+\v\002J(1IW(wIWRxIii`I(\127@}y\t(P\vI1IW(DIx}I+`h()\vI()\b@RIxJI\v`(PI\v\002J`:(\bi()\v\002J(JIW\bi(\t\bIJx`(+\v\002J(FxxI+(P\vI1IW(@}WiFx(F@h")
    })
  end
end
function TMR_HlpLollis:OnTick()
  _Urwigo.MessageBox({
    Text = _yhK5("\127}ii(1}\002J(iFx(JIW(Y\b(i\vW:(P\vW(i\bI++I@(WI1I@h"),
    Media = IMG_Ba2B
  })
end
function _srCZ:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("#\002J(JF/(+\vI(I@`1I\002R`h()}W`(w}W@I(\v+`(+\vIh"),
      Media = IMG_Raebe01
    }
  }, function(action)
    Z_Local_FMaus.Visible = true
  end)
end
function P_Raebe:On_PoKq(target)
  if Z_Kunitz:Contains(P_Raebe) then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("Z\027\002J(1F(/\v+`(LFhZ(/IDW\bI++`()\v\002J(1IW(\\FI/Ih(Z\014\v+`()\b(1}\002J:(}1IWSZ"),
        Media = IMG_Kunitz2
      },
      {
        Text = _yhK5(")\vI(lWFDI(wIW+`IJ(\v\002J(@\v\002J`h"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("8F(LF:(PI\v++`()\b:(I+(\v+`(wIWW\bI\002R`:(F/IW(I+(+}xx(LF(]I\b`I(DI/I@:(1\vI(+\v`YI@(Y\bJF\b+I(F\b\t(1Ii(\003}\tF(\b@1(D\b\002RI@(I\v@\tF\002J(@\bW(\vi(\ai\bxF`}W(Y\b:(P\vI(\v\002J(i\v\002J(J\vIW(F/i\bIJI:(+`F``(JIW(Y\b(R}iiI@(\b@1(Y\b(JIx\tI@h(\027/IW(+}(I\v@IW(/\v+`()\b(LF(@\v\002J`h"),
        Media = IMG_Kunitz2
      },
      {
        Text = _yhK5("8IIII:(F\b\t(RI\v@I@(lFxxh"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5(")F+(\v+`(D\b`h()F@@(RF@@+`()\b(i\vW(LF(+\v\002JIW(+FDI@:(PIx\002JI([FJx(1}W`(1W\bI/I@(\v@(PI\v++IW(\003\002JW\v\t`(F\b\t(1IW(]F`IW@I(DI+\002JW\vI/I@(+`IJ`h"),
        Media = IMG_Kunitz2
      }
    }, function(action)
      V_DtLolli = -1
      V_DtNotiz = -1
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_VorOrtCheck)
      end)
    end)
  elseif V_StoryLine <= 10 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("ZmF+(JFIx`+`()\b(1Fw}@:(iFx(I\v@I@(]\b\t`F@DW\v\t\t(Y\b(wIW+\b\002JI@SZ(+FD+`()\b(Y\bi(\\FI/I@h()IW(xFI++`(+\v\002J(@\v\002J`(xF@DI(/\v``I@:(+\002J@Fyy`(+\v\002J(I\v@(RxI\v@I+(\003`I\v@\002JI@:(JI/`(F/:(RWI\v+`(I\v@I(mI\vxI(\bI/IW(1Ii(\022W}Ixx\002JI@(\b@1(R}ii`(+\002Jx\vI++x\v\002J(P\vI1IW(Y\b()\vW(Y\bW\bI\002Rh(Z#\002J(/WF\b\002JI(\vWDI@1PF+(F@1IWI+:(PF+(\v\002J(F\b\t(\vJ@(PIW\tI@(RF@@:(+}@+`(P\vW1(1F+(@\v\002J`+h()\vI(\003`I\v@I:(1\vI(\v\002J(+\002JxIyyI@(RF@@:(1\vI(iF\002JI@(\vJi(@\v\002J`+(F\b+hZ"),
        Media = Img_Ba1H
      },
      {
        Text = _yhK5("sii:(iFx(\bI/IWxIDI@(hhh"),
        Media = IMG_Spieler
      }
    }, function(action)
      V_StoryLine = 20
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_StoryLine == 50 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(JF/(iI\v@I@(\022I\vx(IWxI1\vD`h(\a\v@+FiiIx@(i\b++`()\b(\vJ@(+\002J}@h"),
        Media = IMG_Raebe01
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif Z_Bergauf20:Contains(P_Raebe) then
    FCT_LollisSammeln()
  elseif V_StoryLine == 210 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(PF+(@\b@S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("]I+I@(/\vx1I`h"),
        Media = IMG_Raebe01
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif Z_Steinhaufen:Contains(P_Raebe) then
    if 50 > V_FMausStatus then
      ITM_Laterne.Commands._aDHF.Enabled = true
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(IW\v@@IW+`()\v\002J:(PF+(DI+\002JW\vI/I@(+`F@1S(\a\v@(DIPFx`\vDI+()WF\002JI@\tI\bIW(P\bIW1I(LI`Y`(PI\v`IWJIx\tI@h()\b(JF+`(1}\002J(\127}@`FR`I(Y\b()WF\002JI@h(\127F@@+`()\b(1F(@\v\002J`(PF+(I\v@\tFI1Ix@S"),
          Media = IMG_Raebe04
        },
        {
          Text = _yhK5(")\b(RI@@+`(1}\002J(F/IW(1\vI()WF\002JI@(DI@F\b(+}(D\b`(P\vI(\v\002Jh"),
          Media = IMG_Spieler
        },
        {
          Text = _yhK5("#\002J(i\b++(F/IW(J\vIW(F\b\t(1I@(\127@}\002JI@(F\b\tyF++I@h"),
          Media = IMG_Raebe04
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.MessageBox({
        Text = _yhK5("m\vW(/WF\b\002JI@(I\v@(DW}I++IWI+(lI\bIW:(\028\\?\a\003\003\a\\:(+\002J@Ixx\n"),
        Media = IMG_Raebe01,
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
        Text = _yhK5("\003\002J}I@I+(mI``IW(JI\b`I:(PF+S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5(")\vI(I\v@I@(+FDI@(+}:(1\vI(F@1IWI@(F@1IW+h"),
        Media = IMG_Raebe01
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Raebe:On_YWV(target)
  if Z_Huegel:Contains(Player) then
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(+\b\002J+`()\vW(I\v@I(D\b`I(9}+\v`\v}@:(W\b\t+`(1Ii(\\FI/I@(Y\bB(Z\003FD(1}\002J(iFx(\001JIIII+IZ(\b@1(1W\bI\002R+`(F/h"),
      Media = IMG_Huegelfoto,
      Callback = function(action)
        if action ~= nil then
          ITM_Foto:MoveTo(Player)
          FCT_HuegelVerlassen()
          Z_Huegel.Active = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("8F(x}+(\\FI/I:(iF\002JI@(P\vW(I\v@(l}`}h"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("\027x+}(\v\002J(PFW(LF(w}WJ\v@(F\b\t(1IW(\014F@R(F\b\t(1Ii(s\bIDIxh()F+(PFW(I\v@I(P\vWRx\v\002J(D\b`I(\003`IxxI:(\bi(I\v@(l}`}(Y\b(iF\002JI@h(#\002J(\t\v@1I(P\vW(+}xx`I@(1}W`(@}\002J(iFx(J\v@(DIJI@h(\003\002Jx\vI++x\v\002J(i\b++(\v\002J(LF(D\b`(F\b++IJI@(F\b\t(iI\v@Ii(\014\v/x\v}`JIR+F\b+PI\v+h"),
        Media = IMG_Raebe01
      },
      {
        Text = _yhK5("o\b++(1F+(LI`Y`(P\vWRx\v\002J(+I\v@S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("\a+(ot\003\003h"),
        Media = IMG_Raebe01
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Raebe:On_uctcs(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(\vWW+`(\biJIW:(RF@@+`(F/IW(1\vI(/x}I1I(\127\v+`I(I\v@\tF\002J(@\v\002J`(I@`1I\002RI@h({\vIxxI\v\002J`(JF`(LF(1IW(\\FI/I(iIJW(\028x\bI\002R(1I@R+`()\b(\b@1(I@`+\002Jx\vI++`()\v\002J:(\vJ@(1}\002J(@}\002J(iFx(PF\002J(Y\b(iF\002JI@h"),
      Media = IMG_Spieler
    },
    {
      Text = _yhK5("\028FIJ@@@@(hhhh\020\014\\6]F++(i\v\002J(WF`I@h()\b(\t\v@1I+`(1\vI(\127\v+`I(@\v\002J`h()F/I\v(+IJ(\v\002J(+\vI(+Ix/+`(w}@(J\vIW(F\b+h"),
      Media = IMG_Raebe02
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(INP_FinalHint)
    end)
  end)
end
function P_Troellchen:On_nWE(target)
  if V_StoryLine < 50 then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\022W}xx(WI@@`(J\vIW(1\bW\002J+(\028I/\bI+\002J(\b@1(iF\002J`(FxxI(PFJ@+\v@@\vDh()F(JF/I@(P\vW(LF(PF+(+\002J}@I+(F@DIW\v\002J`I`h"),
      Media = IMG_Ba1Troll,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_StoryLine == 50 then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\022W}xx(RxI/`(Fi(]}xx\v(P\vI(1\vI(lx\vIDI(F@(1IW(lx\vIDI@\tFxxIh()\b(yF\002R+`(1I@(]}xx\v(Fi(\003`\vIx(\b@1(/I\t}IW1IW+`(1F+(\028I+Fi`R\b@+`PIWR(i\v`(I\v@Ii(DIR}@@`I@(\003\002JP\b@D(\v@()I\v@I@(\\\b\002R+F\002Rh()}W`(W\bi}W`(I+(@}\002J(I\v@I([I\v`(xF@D:(1F@@(P\vW1(I+(xF@D+Fi(W\bJ\vDIW:(F/DI+IJI@(w}@(I\v@Ii(+\002JiF`YI@1I@(\028IWFI\b+\002J(1Ii()\b(I@`@\vii+`:(1F++(1IW(]}xx\v(+\v\002J(P}Jx(DIWF1I(F\b\t(1Ii(mID(\v@(1I@(oFDI@(1I+(\022W}xx+(/I\t\v@1I`h"),
      Media = IMG_Ba1TrollGefangen,
      Callback = function(action)
        if action ~= nil then
          P_Troellchen:MoveTo(Player)
          V_StoryLine = 60
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\022W}xx:()I\v@(@I\bI+(sF\b+`\vIWh"),
      Media = IMG_Troellchen,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function P_Troellchen:On_oO8w(target)
  if Z_Holzzelt:Contains(Player) then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\022W}xx(JF`(+\v\002J(i\v``xIWPI\vxI(/IW\bJ\vD`(\b@1(+\002JI\v@`(1I@(\\\b\002R+F\002R(Fx+(+I\v@(@I\bI+([\bJF\b+I(FRYIy`\vIW`(Y\b(JF/I@h()\b(wIW+\b\002J+`(iFx(\vJ@(F@Y\b+yWI\002JI@h"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(INP_Troll)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(JF+`(1Ii(\022W}xx(DIWF1I(@\v\002J`(Y\b(+FDI@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function P_Troellchen:On_Vho2(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(+I`Y`(1I@(\022W}xx(@I/I@(1IW(\127IWYI(F\b\t(1I@(\003`I\v@JF\b\tI@:(1W\bI\002R+`(\vJi(1\vI(\127IWYI(\v@(1\vI(sF@1(\b@1(@\v\002R+`(\vJi(1F/I\v(i\v`(I\v@Ii(r@/+yO\tWI\b@1x\v\002JI@(Z[}xxZ(F\b\t(1I@(]\vyyI@(Y\bh()F@F\002J(+yW\v\002J+`()\b(1\vI(iFD\v+\002JI([FJx(F\b+:(P\vI(+\002J}@(+}(}\t`h\020\014\\6)IW(\022W}xx(/ID\v@@`(Y\b(PF\002J+I@:(i\v`(\vJi(1\vI(\127IWYIh"),
      Media = IMG_FinD4
    },
    {
      Text = _yhK5(")IW(\003\002J@II(+\002Ji\vxY`:(1F+(lI\bIW(DIP\v@@`(P\vI1IW(1\vI(?/IWJF@1(\b@1(8IRWFi}WF(JF`(IW@I\b`(F@DI\tF@DI@(Y\b(Dx\bIJI@h(Z\127}ii`(\003RIxI``I:(P\vW(wIW+\002JP\v@1I@(J\vIWhZ(W\b\t`(\003\vI(F\b\t(I\v@iFx:(ZJ\vIW(P\vW1(I+(Y\b(\b@DIi\bI`x\v\002JhZh()\vI(xI\b\002J`I@1I(\127\bDIx(\bi(+\vI(JIW\bi(/ID\v@@`(1\vI(\003RIxI``I(\v@+(+\v\002J(F\b\tY\b+F\bDI@h"),
      Media = IMG_Sonne0
    },
    {
      Text = _yhK5("#JW(DIJ`(J\v@`IW(1Ii(\003`I\v@JF\b\tI@(\v@()I\002R\b@D:(\bi(@\v\002J`(F\b\002J(\v@(1I@(\003}D(Y\b(DIWF`I@:(1IW(@F\002J(\b@1(@F\002J(1\vI(\003RIxI``I(\v@(\vJWI(\127@}\002JI@(YIWxID`(\b@1(LI1I@(I\v@YIx@I@(1Fw}@(i\v`(+\v\002J(WI\v++`h"),
      Media = IMG_FinD4b
    },
    {
      Text = _yhK5(")F@@(IWJI/`(+\v\002J(1IW(\014Fxx}@(\v@(1\vI(]\b\t`(\b@1(+\002JPI/`(1Ii(s\viiIx(I@`DIDI@:(hhh"),
      Media = IMG_FinD4c
    },
    {
      Text = _yhK5("hhh(\bi(\vWDI@1PF@@(+\002Jx\vI++x\v\002J(Fi(s}W\vY}@`(Y\b(wIW+\002JP\v@1I@h"),
      Media = IMG_FinD5
    },
    {
      Text = _yhK5("\022+\002J\bI++(8IRWFi}WF\n"),
      Media = IMG_FinD6
    }
  }, function(action)
    V_PiratenStatus = 40
    P_Raebe:MoveTo(Player)
    P_Fledermaus:MoveTo(Z_Tisch)
    Z_Steinhaufen.Active = false
    Z_Nekramora.Active = false
    Z_Orakel.Active = false
    P_Troellchen:MoveTo(nil)
    T_Feuer.Complete = true
    T_Piraten2.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function P_Huehnchen:On_mgjgQ(target)
  if V_StoryLine < 60 then
    _Urwigo.MessageBox({
      Text = _yhK5("\014\v``I:(/\v``I:(iF\002J(1F++(IW(I@1x\v\002J(wIW+\002JP\v@1I`h"),
      Media = IMG_Ba1D,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(/\v+`(iI\v@(sIx1h(\a@1x\v\002J(P\vI1IW(\\\bJIh( I`Y`(JF+`()\b(1I@(xI\v\002J`+\v@@\vDI@(]I\b`I@:(1\vI(+}(I\v@(DI\tFIJWx\v\002JI+({\vIJ(\tWI\vDIxF++I@(JF/I@:(F/IW(iFx(DIYI\vD`(P}(1IW(sFiiIW(JFI@D`h(#\002J(/\v@(+}(+`}xY(F\b\t()\v\002Jh"),
        Media = IMG_Ba1B
      },
      {
        Text = _yhK5("8\b@(LF:(w\vIxxI\v\002J`(PFW(I+(LF(@\bW(I\v@({IW+IJI@:(1F++(IW(I@`R}iiI@(hhh"),
        Media = IMG_Ba1E
      },
      {
        Text = _yhK5("9FyyIWxFyFyyh(\003}(PF+(\v+`(@\v\002J`(Y\b(I@`+\002J\bx1\vDI@h(\027/IW(1F@R()\vW(\v+`(I+(LF(@\b@(\bI/IW+`F@1I@h(t@1(1FW\bi(JF/I(\v\002J(F\b\002J(I\v@I(\014Ix}J@\b@D(\t\bIW()\v\002Jh"),
        Media = IMG_Ba1B
      },
      {
        Text = _yhK5("\a\v@I(\014Ix}J@\b@D:(?J(yW\viF:(PF+(\v+`(I+(1I@@S"),
        Media = IMG_Ba1E
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_ModusFestlegen)
      end)
    end)
  end
end
function P_Bibliothekar:On_Sdh7(target)
  if V_BibStatus < tonumber(_yhK5("\"z")) then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\028\b`I@(\022FD:(\v\002J(/\v@(1IW(\\FI/I(\b@1(/Fx1(I\v@(iFI\002J`\vDIW(9\vWF`h(t@1(PIW(/\v+`()\b(+}S"),
        Media = IMG_Ba3CRaebe
      },
      {
        Text = _yhK5("#\002J(/\v@(\014\v/x\v}`JIRFW:(JF/I(1\vI(DW}I++`I(mF@1IW/\v/x\v}`JIR(PI\v`(\b@1(/WI\v`(\b@1(+\v`YI(xI\v1IW(i}iI@`F@(J\vIW(I`PF+(\tI+`h(o}I\002J`I+`()\b(I\v@(\014\b\002J(xI\vJI@S"),
        Media = IMG_Ba3CBibl
      },
      {
        Text = _yhK5("tDJ:(\bDJh"),
        Media = IMG_Ba3CRaebe
      },
      {
        Text = _yhK5("m\vI(/\v``IS"),
        Media = IMG_Ba3CBibl
      },
      {
        Text = _yhK5("\027\002J(@\v\002J`+:(\t\vIx(i\vW(@\bW(DIWF1I(+}(I\v@h(\027/IW(Y\bW\bI\002R(Y\b()\vWh()\b(+yWF\002J+`(1Fw}@:(1F++()\b(J\vIW(\tI+`+\v`Y`h(m\vI+}(I\vDI@`x\v\002JS"),
        Media = IMG_Ba3CRaebe
      },
      {
        Text = _yhK5(")F+(\v+`(I\v@I(1\biiI(\028I+\002J\v\002J`Ih()}W`(}/I@(F\b\t(1IW(\014\bWD:(1F(JF\b+`(/}I+I+({}xRh(]I\b`I(1I@I@(iF@(/I++IW(F\b+(1Ii(mID(DIJ`h(\a\v@I(lxI1IWiF\b+:(1\vI(Y\b(1I@I@(DIJ}IW`:(JF`(+\v\002J(DI+`IW@(/\v+(J\vIW(W\b@`IW(wIW\vWW`(\b@1(@F`\bIWx\v\002J(@\v\002J`+(F@1IWI+(\vi(\003\v@@(DIJF/`:(Fx+(i\vW(1\vWIR`(I\v@I@(\bI/xI@(\003`WI\v\002J(Y\b(+y\vIxI@h("),
        Media = IMG_Ba3CBibl
      },
      {
        Text = _yhK5("oI\v@I(\014\bI\002JIW(JF/I@(LF(I\v@I(F@DIiI++I@(DIW\v@DI(\028W}I++I:(1Fi\v`(\v\002J(+\vI(`WF@+y}W`\vIWI@(RF@@h(t@1(1\vI+I(wIW\tx\b\002J`I(lxI1IWiF\b+(JF`(r@/+yO@\bW(I\v@I@(R\bWYI@(iFD\v+\002JI@(\014x\v\002R(F\b\t(I\v@I+(1IW(\014\bI\002JIW(DIW\v\002J`I`(\b@1(I+(\t\v@D(F@(Y\b(PF\002J+I@h(sFI``I(i\v\002J(\tF+`(IW+\002JxFDI@(1Fi\v`h([\bi(\028x\bI\002R(JF`(+\vI(+\002J@Ixx(1F+(#@`IWI++I(wIWx}WI@(\b@1(\v+`(DxI\v\002J(P\vI1IW(F/DIY}DI@h"),
        Media = IMG_Ba3CBibl
      },
      {
        Text = _yhK5("\028\b`:(JF/(\v\002J(wIW+`F@1I@h(t@1(P}(R}ii`(LI`Y`(1\vI(\003`IxxI(i\v`(1Ii(\tI+`+\v`YI@S"),
        Media = IMG_Ba3CRaebe
      },
      {
        Text = _yhK5("8F(1F+(\v+`(1}\002J(}\t\tI@+\v\002J`x\v\002Jh()F+(\014\b\002J(\v+`(\\#\a\003#\028h(m\vI(+}xx(\v\002J(1I@@(1F+(LI`Y`(`WF@+y}W`\vIWI@h(t@1(Y\bW\bI\002RxF++I@(RF@@(\v\002J(I+(F\b\002J(@\v\002J`h(\a\v@(\014\v/x\v}`JIRFW(xFI++`(RI\v@I+(+I\v@IW(\014\bI\002JIW(\vi(\003`\v\002Jh"),
        Media = IMG_Ba3CBuch
      }
    }, function(action)
      T_Schrumpfkur.Active = true
      ITM_Buch:MoveTo(Z_Holzzelt)
      V_BibStatus = 10
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_BibStatus == 20 then
    _Urwigo.MessageBox({
      Text = _yhK5("oF\002J(I\v@(l}`}(\b@1(D\v/(I+(i\vWh"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("]F++(i\v\002J(1}\002J(iFx(I\v@I@(\014x\v\002R(F\b\t()I\v@I(\014\bI\002JIW(PIW\tI@h"),
      Media = IMG_BibRuf,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(INP_Buecherliste)
          end)
        end
      end
    })
  end
end
function P_Troll:On_iiW0l(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\vI(\127}@wIW+F`\v}@(i\v`(1Ii(\022W}xx(\v+`(YPFW(\viiIW(WI\002J`(I\v@+I\v`\vD:(`W}`Y1Ii(wIW+\b\002J+`()\b(I+(IW@I\b`h"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(INP_Troll)
        end)
      end
    end
  })
end
function P_Fledermaus:On_vKObE(target)
  if V_FMausStatus < 10 then
    _srCZ:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFxx}(lxI1IWiF\b+:(1F(/\v+`()\b(LF(P\vI1IWh"),
        Media = IMG_Fledermaus1
      },
      {
        Text = _yhK5("sFxx}(\\FI/Ih(m}xx`I+`()\b(@\v\002J`(mF\002JI(JFx`I@:(1Fi\v`(\a\\(I+(@\v\002J`(/\v+(J\vIW(J}\002J(+\002JF\t\t`S"),
        Media = IMG_Fledermaus3
      },
      {
        Text = _yhK5(")F+(\v+`(@\v\002J`(iIJW(@}I`\vDh(\a\\(\v+`(xFI@D+`(J\vIWh"),
        Media = IMG_Fledermaus2
      },
      {
        Text = _yhK5("\027\002J(+}h(8F(1F@@(\v+`\024+(LF(D\b`h"),
        Media = IMG_Fledermaus3
      },
      {
        Text = _yhK5("\027/IW(+FD(iFx:(PI\v++`()\b(Y\b\tFIxx\vD:(P\vI(P\vW(Y\b(8IRWFi}WF(WI\v@(R}iiI@S"),
        Media = IMG_Fledermaus2
      },
      {
        Text = _yhK5(")F(R}ii`(@\vIiF@1(J\v@h(mI@@(LIiF@1(wIW+\b\002J`(1\vI(\014FWW\vIWI(Y\b(1\bW\002J/WI\002JI@(+\002JxFDI@(1\vI(\003RIxI``I(+}\t}W`(\027xFWi(\b@1(PF+(1F@@(yF++\vIW`:(1F+(P\vxx+`()\b(DFW(@\v\002J`(P\v++I@(hhh"),
        Media = IMG_Fledermaus3
      }
    }, function(action)
      V_FMausStatus = 10
      if V_StoryLine == 240 and V_EasyMode == 1 then
        FCT_FmHolen()
      else
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end)
  elseif V_FMausStatus == 10 and V_StoryLine == 240 and V_EasyMode == 1 then
    FCT_FmHolen()
  elseif V_FMausStatus == 30 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sF+`()\b(DIJ}IW`:(PF+(1F+(?WFRIx(w}WDIxI+I@(JF`S(\a\v@(+\002JPFWYIW(9\vWF`(!(Fx+}(\v\002J(!(P\vW1(+\vI(wIW`WI\v/I@h(t@1(I\v@IW(\vJWIW(\003\002JIWDI@(P\vW1(i\vW(1F/I\v(JIx\tI@h()F+(/\v+`(LF(1F@@(P}Jx()\bh(\027x+}(J\vx\t(iFxh"),
        Media = IMG_Raebe01
      },
      {
        Text = _yhK5("#\002J(R}I@@`I(WI\v@(\tx\vIDI@(\b@1(\vJW(I\v@(sFFW(RxF\bI@h()F+(RW\vID(\v\002J(J\v@h(\027/IW(\bi(1\vI(\003RIxI``I(i\b++`()\b(1\v\002J(+Ix/+`(R\bIiiIW@h(o\v`(1I@I@(P\vxx(\v\002J(@\v\002J`+(Y\b(`\b@(JF/I@h"),
        Media = IMG_Fledermaus0
      },
      {
        Text = _yhK5(")\vI(lxI1IWiF\b+(+\002JP\v@D`(+\v\002J(\v@(1\vI(]\b\t`:(`F\b\002J`(w}@(}/I@(1\bW\002J(1\vI(\014FWW\vIWI(Fx+(}/(+\vI(@\v\002J`(1F(PFIWIh()W\v@@I@(\txF``IW`(+\vI(I\v@I(mI\vxI(\bi(8IRWFi}WF+(\127}y\t(\b@1(Y\by\t`(\vJW(1F/I\v(I\v@(sFFW(F\b+h(Z\014x}I1I+({\vIJ:(RF@@+`()\b(@\v\002J`(F\b\tyF++I@Z(W\b\t`(\vJW(8IRWFi}WF(wIWFIWDIW`(Y\b:(+\002JI@R`(\vJW(F/IW(+}@+`(PI\v`IW(RI\v@I(\014IF\002J`\b@Dh("),
        Media = IMG_Haar1
      },
      {
        Text = _yhK5("s\vIW:(I\v@(\022I\vx(w}@(8IRWFi}WF:(/\v``I(+\002J}I@h()\b(RF@@+`(LI`Y`(F@(1I@(\003F`Y(i\v`(1IW(s\vx\tI(w}i(\003\002JIWDI@(I\v@I@(sFRI@(iF\002JI@h"),
        Media = IMG_Haar2
      }
    }, function(action)
      V_FMausStatus = 40
      ITM_Haar:MoveTo(Player)
      ITM_Haar.Commands._21c.Enabled = true
      T_Nekramora.Complete = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif Z_Steinhaufen:Contains(P_Fledermaus) then
    ITM_Laterne.Commands._aDHF.Enabled = true
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")F(+`F@1(PF+(DI+\002JW\vI/I@(w}@(I\v@Ii(DIPFx`\vDI@()WF\002JI@\tI\bIWh"),
        Media = IMG_Fledermaus5
      },
      {
        Text = _yhK5(")\b(RI@@+`(@\v\002J`(Y\b\tFIxx\vD(I\v@I@()WF\002JI@(J\vIW(\v@(1IW(8FIJIh"),
        Media = IMG_Raebe04
      },
      {
        Text = _yhK5(")IW(\003\002JIWDI(JF`(+I\v@I@(\014I\v`WFD(/IWI\v`+(DIxI\v+`I`:(\tFxx+()\b()\v\002J(IW\v@@IW+`h(#\002J(+\002JF\bI(@\bW(Y\bh"),
        Media = IMG_Fledermaus5
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_StoryLine == 390 then
    _Urwigo.MessageBox({
      Text = _yhK5("8F(\b@1:(JF+`()\b(1I@(\001}1I(DI\t\b@1I@S"),
      Media = IMG_Fledermaus0,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(INP_UnlockCode)
          end)
        end
      end
    })
  elseif V_StoryLine >= 395 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\aWYFIJx(i\vW(1}\002J(@}\002J(iFx:(P\vI(D\b`(\v\002J(PFWh"),
        Media = IMG_Raebe01
      }
    }, function(action)
      FCT_Statistik()
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFxx}(lxI1IWiF\b+h"),
        Media = IMG_Raebe01
      },
      {
        Text = _yhK5("sFxx}(\\FI/Ih"),
        Media = IMG_Fledermaus0
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Piraten:On_kg0(target)
  if V_PiratenStatus == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFxx}(9\vWF`I@\n"),
        Media = IMG_Piraten0
      },
      {
        Text = _yhK5("sFxx}(9\vWF`I@!\027@PFIW`IW\n"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("#\002J(JF/(\a\b\002J(1F(PF+(i\v`DI/WF\002J`h"),
        Media = IMG_Piraten5
      },
      {
        Text = _yhK5("m\vW(JF/I@(@\v\002J`+(F@1IWI+(w}@()\vW(IWPFW`I`h(hhh(\027xxIW1\v@D+(hhh(@\b@(LF(hhh(JF/I@(P\vW(\tF+`(I\v@(PI@\vD(1I@(\a\v@1W\b\002R:(Fx+(P}xx`I+`()\b(1F+(\028IJI\vi@\v+(1I+()}R\biI@`+(F\b\t(I\vDI@I(\\I\002J@\b@D(IWDW\bI@1I@h"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("8I\v@:(@I\v@:(F\b\t(DFW(RI\v@I@(lFxxh(#\002J(P}xx`I(\a\b\002J(@\bW(I\v@I(lWI\b1I(iF\002JI@(\b@1(1I@(\022I3`(\bI/IW+I`Y`(JF/I@:(PI@@(\v\002J(I+(\a\b\002J(Y\bW\bI\002R(DI/Ih"),
        Media = IMG_Piraten2
      },
      {
        Text = _yhK5("8\b@(PI@@(1F+(+}(\v+`:(1F@@(P}xxI@(P\vW()\v\002J(@\v\002J`(F\b\tJFx`I@h(lFJWI(\t}W`(i\v`()I\v@IW(\003\b\002JI(@F\002J(1IW(tI/IW+I`Y\b@Dh"),
        Media = IMG_Piraten3
      },
      {
        Text = _yhK5("si:(LF:(\v\002J(iF\002J(1F@@(iFxh(\027/IW(1F@@(/\v@(\v\002J(9\vWF`S"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5(")F@@(/\v+`()\b(9\vWF`\n\020\014\\6\020\014\\6\027\002J(\b@1(+I\v(w}W+\v\002J`\vD:(PI@@()\b(1F(1W\bI/I@(DxI\v\002J(\bi(1\vI(\a\002RI(1\bW\002J(1\vI(\028IDI@1(+`}xyIW+`h()F(P\viiIx`(I+(@\bW(+}(w}@(\003RIxI``I@h()F(`WI\v/`(+\v\002J(+}(I\v@I(\022F@`I(W\bi:(1\vI(1\vI(\014\vI+`IW(/I+\002JP}IW`h(tI/xI+(\028I+\v@1Ix:(DF@Y(\bI/Ixh(\a+(i\bI++`I(+\v\002J(I\vDI@`x\v\002J(iFx(LIiF@1(1W\bi(R\bIiiIW@:(1F++(+\vI(wIW+\002JP\v@1I`h"),
        Media = IMG_Piraten3
      },
      {
        Text = _yhK5("\027/IW(@\v\002J`(\v\002J\n"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("8I\v@h(\014W\v@D()\b(@\bW(1F+(i\v`(1Ii()}R\biI@`(Y\b(\a@1I:(iIJW(@\v\002J`h(\027/IW(+}xx`I(I+(1F/I\v(WI\v@(Y\b\tFIxx\vD(yF++\vIWI@:(1F++(1\vI(\022F@`I(F\b\t(I\v@iFx(PID(\v+`:(1F@@(PFIWI@(P\vW(+\v\002JIW(@\v\002J`(/}I+I(1I+PIDI@h"),
        Media = IMG_Piraten2
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      T_Piraten1.Complete = true
      T_Uebersetzung.Active = true
      V_PiratenStatus = 10
    end)
  elseif V_StoryLine == 240 and V_PiratenStatus == 10 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\003FD`(iFx:(#JW(+I\v1(1}\002J(9\vWF`I@h(t@1(9\vWF`I@(JF/I@(\003\002JFI`YIh()F(\v+`(1}\002J(/I+`\vii`(I\v@(\027i\bxI``(i\v`(1F/I\v:(1F+(\vJW(I@`/IJWI@(R}I@@`:(@\v\002J`(PFJWS"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("8F`\bIWx\v\002J(JF/I@(P\vW(\003\002JFI`YI(\b@1(@F`\bIWx\v\002J(R}I@@I@(P\vW(@\v\002J`+(1Fw}@(I@`/IJWI@h(m\vW1(FxxI+(DI/WF\b\002J`h"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5(")F@@(P\vW1(1F+()}R\biI@`(P}Jx(/\v+(\v@(FxxI(\aP\vDRI\v`I@(\b@xI+/FW(/xI\v/I@:(P\vI(+\002JF1Ih"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("mFW`I:(PFW`I:(@\v\002J`(+}(+\002J@Ixxh(#@(1Ii(lFxx(PIW1I@(P\vW(iFx(I\v@I(\027\b+@FJiI(iF\002JI@h(s\vIW(\v+`(1IW(\003\002Jx\bI++Ix(Y\b(\b@+IWIW(\003\002JF`YR\v+`Ih(\003\002JF\b(@F\002J:(}/()\b(PF+(yF++I@1I+(\t\v@1I+`h(\027/IW(1Fi\v`()\b(I+(PI\v++`h()\b(1FW\t+`()\vW(@\bW(I\v@(\022I\vx(1FWF\b+(@IJiI@h(mI@@()\b(i\v`(1Ii(@\v\002J`+(F@\tF@DI@(RF@@+`:(/W\v@D(I+(Y\bW\bI\002R:(/Iw}W()\b(I\v@(F@1IWI+(@\vii+`h(m\vW(JF/I@(I\v@(\027\bDI(F\b\t()\v\002J:(Fx+}(`\b(@\v\002J`+(\tFx+\002JI+h"),
        Media = IMG_Piraten2
      },
      {
        Text = _yhK5(")F@RIh(\a+(\v+`(\viiIW(P\vI1IW(@I``:(i\v`(\a\b\002J(Y\b(WI1I@h"),
        Media = IMG_Piraten4
      }
    }, function(action)
      ITM_Schluessel:MoveTo(Player)
      V_PiratenStatus = 20
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_StoryLine < 260 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(P\vI(/\v+`()\b(i\v`(1IW(tI/IW+I`Y\b@D(+}(w}WF@(DIR}iiI@S"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("#\002J(FW/I\v`I(1WF@h"),
        Media = IMG_Piraten4
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_PiratenStatus < 30 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(P\vI(/\v+`()\b(i\v`(1IW(tI/IW+I`Y\b@D(+}(w}WF@(DIR}iiI@S"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("\027xxI+(IWxI1\vD`h()F(+`IJ`(1W\v@B(Z\a\v@(+\002JPFWYIW(9\vWF`(P\vW1(R}iiI@(\b@1(1\vI(\022F@`I(wIW`WI\v/I@hZ"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5(")F@@(xF++(iFx(\bI/IWxIDI@h(mIW(w}@(\b@+(FxxI@(\v+`(+\002JPFWYS"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("#\002JS"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("\028I@F\bh"),
        Media = IMG_Piraten2
      },
      {
        Text = _yhK5("#\002J(iF\002J(i\v\002J(1F@@(iFx(P\vI1IW(F\b\t(1I@(mIDh"),
        Media = IMG_Piraten4
      }
    }, function(action)
      V_PiratenStatus = 30
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_PiratenStatus < 40 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(P\vI(xFI\b\t`(1\vI({IW`WI\v/\b@D(+}S"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("#\002J(FW/I\v`I(1WF@h"),
        Media = IMG_Piraten4
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_PiratenStatus < 50 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(P\vI(xFI\b\t`(1\vI({IW`WI\v/\b@D(+}S"),
        Media = IMG_Piraten1
      },
      {
        Text = _yhK5("\027xxI+(IWxI1\vD`h(#\002J(JF/(+\vI(F\b\tDI/xF+I@(\b@1(1Fw}@(\tx\vIDI@(xF++I@h(mFW(DF@Y(I\v@\tF\002J:(\vi(\028W\b@1Ih(sF`(F\b\002J(DFW(@\v\002J`(xF@DI(DI1F\bIW`(\b@1(\v\002J(i\b++`I(1F\t\bIW(F\b\002J(\tF+`(\bI/IWJF\by`(@\v\002J`(`}@@I@PI\v+I([I\bD(w}@(\027(@F\002J(r@/+yO\014(@F\002J(\001(\b@1(P\vI1IW(Y\bW\bI\002R(@F\002J(\027(+\002JxIyyI@h(\028F@Y(IF+Uh"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("m\vI(+\v\002J(1F+(\t\bIW(I\v@I@(W\v\002J`\vDI@(9\vWF`I@(DIJ}IW`h"),
        Media = IMG_Piraten2
      },
      {
        Text = _yhK5(")F@@(/\v@(\v\002J(LI`Y`(9\vWF`S"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5(")I@RI(+\002J}@h("),
        Media = IMG_Piraten3
      },
      {
        Text = _yhK5("t@1(J\vIW(\v+`()I\v@(m\vxxR}iiI@+!\028I+\002JI@Rh(\014\v``I(+\002J}I@h"),
        Media = IMG_FinE1
      },
      {
        Text = _yhK5("\a\v@(]}xx\vS"),
        Media = IMG_FinE2
      },
      {
        Text = _yhK5("\a\v@(]}xx\v(i\v`(I\v@Ii(\026(1WF\b\t\n"),
        Media = IMG_FinE3
      },
      {
        Text = _yhK5("\027\002J(+}:(@F(1F@@h(\003}(I\v@I@(JF``I(\v\002J(LF(@}\002J(@\vIh()F@RI:(x\vI/I(o\v`!9\vWF`I@h"),
        Media = IMG_FinE2
      },
      {
        Text = _yhK5("t@1(J\vIW(PFIWI(1F@@(@}\002J(I\v@I({\v+\v`I@RFW`I(\t\bIW()\v\002Jh"),
        Media = IMG_FinE4
      },
      {
        Text = _yhK5("\027\b\t(1Ii(\014\vx1(+I\v1(F/IW(@\bW(\vJW(1WF\b\th"),
        Media = IMG_FinE5
      },
      {
        Text = _yhK5("l\bIW(1I@(\027@\tF@D(i\b++(1F+(i\b++(WI\v\002JI@h"),
        Media = IMG_FinE3
      }
    }, function(action)
      ITM_LolliX:MoveTo(Player)
      ITM_CoCaPiraten:MoveTo(Player)
      V_PiratenStatus = 50
      T_Piraten2.Complete = true
      T_Belohnung.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFxx}(9\vWF`I@\n"),
        Media = IMG_Piraten4
      },
      {
        Text = _yhK5("sFxx}(9\vWF`h"),
        Media = IMG_Piraten1
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Emilio:On_4lGeK(target)
  if V_StoryLine == 220 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\028\b`I@(\022FDh()\vI(o\bi\vI(+\002J\v\002R`(i\v\002J(Y\b()\vWh(#\002J(+\b\002JI(I\v@(?WFRIxh(\127F@@+`()\b(i\vW(w\vIxxI\v\002J`(+FDI@:(}/()\b(J\vIW(I\v@I+(DI+IJI@(JF+`S"),
        Media = IMG_Emilio1
      },
      {
        Text = _yhK5("sF+`()\b(I`PF(I`PF+(i\v`(1\vI+Ii(DF@YI@(\b@`}`I@(\028I+\v@1Ix(Y\b(`\b@:(1F+(+\v\002J(J\vIW(JIW\bi`WI\v/`S()\b(+\vIJ+`(DFW(@\v\002J`(\b@`}`(F\b+S"),
        Media = IMG_Emilio3
      },
      {
        Text = _yhK5("\014\v@(\v\002J(F\b\002J(@\v\002J`h(#\002J(PFW(@\bW(Y\b\tFIxx\vD(/I\v(1IW(9UWFi\v1I(\b@1(i\b++`I(i\v\002J(w}@(1IW(o\bi\vI(F@y\txF\biI@(xF++I@h(\003IJW(\b@\tWI\b1x\v\002J:(1\vI+I(t@`}`I@h(8F(LF:(JFI@D`(w\vIxxI\v\002J`(i\v`(1Ii(\b@`}`(+I\v@(Y\b+FiiI@h"),
        Media = IMG_Emilio2
      },
      {
        Text = _yhK5("\003\v\002JIW:(F/IW(I\v@I(9xFDI(+\v@1(+\vI(FxxIiFxh(mI@@(@\bW(iFx(LIiF@1(RFIiI:(1IW(1\vI+I(DF@YI(\014F@1I(J\vIW(wIWLFDI@(P\bIW1Ih(\027/IW(Y\bW\bI\002R(Y\b()I\v@IW(lWFDIh()\b(+\b\002J+`(I\v@(?WFRIxS(8\b@:(1\b(+yW\v\002J+`(/IWI\v`+(i\v`(\vJi:(\ai\vx\v}(\v+`(iI\v@(8FiIh"),
        Media = IMG_Emilio0
      },
      {
        Text = _yhK5("\014I+}@1IW+(PI\v`(/\v+`()\b(F/IW(@\v\002J`(DIR}iiI@:(PF+S"),
        Media = IMG_Emilio2
      },
      {
        Text = _yhK5("#\002J(/\v@(@}\002J(\v@(1IW(\027\b+/\vx1\b@Dh()F+(PFW(iI\v@(IW+`IW({IW+\b\002J(i\v`(1Ii(iFD\v+\002JI@(\\I\v+I@:(\v\002J(\t\v@1I(1F\t\bIW(JF`(I+(DF@Y(D\b`(\t\b@R`\v}@\vIW`h(mI\v`(DIR}iiI@(/\v@(\v\002J(YPFW(@\v\002J`:(F/IW(\viiIWJ\v@(\v+`(I+(I\v@I(9UWFi\v1Ih(oF@\002JI(?WFRIx!\027Y\b/\v+(+\v@1(+\002J}@(\vi(oF\bx(I\v@I+(\127W}R}1\vx+(DIxF@1I`h()F+(PFW(YPFW(w\vIx(PI\v`IW(PID:(F/IW(F\b\002J(w\vIx(\b@DI+\bI@1IW:(DxF\b/I(i\vWh"),
        Media = IMG_Emilio3
      },
      {
        Text = _yhK5("\027\002J(JIWWLI:(I\v@I(o}I\002J`IDIW@!?WFRIx:(P\vW(JF/I@(F/IW(F\b\002J(I\v@(\028x\bI\002R(JI\b`Ih"),
        Media = IMG_Emilio2
      },
      {
        Text = _yhK5(")F+(i\b++(\v\002J(i\vW(w}@(I\v@Ii(o}I\002J`IDIW@!9\vWF`I@(@\v\002J`(+FDI@(xF++I@h"),
        Media = IMG_Emilio3
      },
      {
        Text = _yhK5("#\002J(/\v@(hhh:(@\b@(LF:(hhh(+\002JI\v@/FW(JF+`()\b(P}Jx(1}\002J(DIP\v++I(+IJIW\v+\002JI(lFIJ\vDRI\v`I@h({IW+\b\002J(1}\002J(iFx:(}/()\b(F\b\002J(xI+I@(RF@@+`:(PF+(J\vIW(\v@(1\vI+Ii()}R\biI@`(+`IJ`h"),
        Media = IMG_Emilio4
      },
      {
        Text = _yhK5("\028\v/`(iFx(JIWh"),
        Media = IMG_Emilio0
      },
      {
        Text = _yhK5("siii:(\v\002J(+y\bIWI:(1F++(I+(\bi(1\vI(\003RIxI``!\022F@`I(w}@(@I/I@F@(DIJ`h(\027/IW(P}W\bi(DI@F\b:(RF@@(\v\002J(@\v\002J`(IWRI@@I@h()\vI(9Fy\vIWI(+\v@1(Y\b(Fx`:(FxxI+(\v+`(+}(wIW+\002JP}iiI@h(#\002J(\t\bIW\002J`I:(1F\t\bIW(RI@@I(\v\002J(i\v\002J(@}\002J(Y\b(PI@\vD(i\v`(sIxx+IJI@(F\b+h(\020\014\\6#\002J(/\v@(1}\002J(IW+`(\vi(IW+`I@(]IJWLFJWh(\014\v+JIW(JF``I@(P\vW(@\bW(Z\127F\t\tII(R}\002JI@Z(\b@1(I/I@(ZoFD\v+\002JI+(\\I\v+I@Zh(#\002J(JF/(@}\002J(@\v\002J`(iFx(iI\v@I(DF@YI@(\003\002J\bx/\bI\002JIW(/I\v+FiiI@h(\022\b`(i\vW(]I\v1h(\027/IW:(P\vI(PFIW\024+(i\v`(I\v@Ii(\127F\t\tIIS"),
        Media = IMG_Emilio5
      },
      {
        Text = _yhK5("8I\v@(1F@RI:(#\002J(i\b++(1F@@(P}Jx(iFx(PI\v`IW:(LIiF@1I@(+\b\002JI@:(1IW(1F+(J\vIW(xI+I@(RF@@h"),
        Media = IMG_Emilio2
      }
    }, function(action)
      V_StoryLine = 230
      FCT_EmilioRename()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_StoryLine == 230 then
    _Urwigo.MessageBox({
      Text = _yhK5("mI@@(\v\002J(1}\002J(@\bW(PI@\vD+`I@+(iI\v@I(\003\002J\bx/\bI\002JIW(+\002J}@(JFI``I:(w\vIxxI\v\002J`(R}I@@`I(\v\002J()\vW(1F@@(JIx\tI@h"),
      Media = IMG_Emilio3,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_StoryLine == 240 then
    if Player:Contains(ITM_BuntesTuch) and Player:Contains(ITM_Amulett) and Z_Tisch:Contains(P_Fledermaus) then
      FCT_HellsehenAn()
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5("t@1(JF+`()\b(FxxI+(Y\b+FiiI@S(#\002J(/WF\b\002JIB\020\014\\6\020\014\\6!(I\v@(/\b@`I+(\127}y\t`\b\002J\020\014\\6!(I\v@(\027i\bxI``\020\014\\6!(I\v@I(\028xF+R\bDIx\020\014\\6!(I\v@I(\127F`YI:(9FyFDI\v(}1IW(lxI1IWiF\b+h"),
          Media = IMG_Emilio3
        },
        {
          Text = _yhK5("#\002J(+\b\002JI(@}\002Jh"),
          Media = IMG_Emilio2
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  elseif V_StoryLine == 250 then
    _Urwigo.MessageBox({
      Text = _yhK5("#\002J(+IJI(hhh(\v\002J(+IJI(hhh(r@/+yO\v\002J(+IJI:(1F++()\b(i\vW(I\v@I@(]}xx\v(DI/I@(i}I\002J`I+`h"),
      Media = IMG_Emilio7,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_StoryLine == 254 then
    _Urwigo.MessageBox({
      Text = _yhK5("s}x(i\vW(1\vI(\014\b\002J+`F/I@:(PI@@(I+(PI\v`IWDIJI@(+}xxh"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_StoryLine == 255 then
    FCT_DokumentLesen()
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("m\vI(PFIW\024+(i\v`(I\v@Ii(\127F\t\tIIS"),
        Media = IMG_Emilio1
      },
      {
        Text = _yhK5(")F@RI:(F/IW(\v\002J(i\b++(PI\v`IWh"),
        Media = IMG_Emilio2
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Emilio:On_XGo4m(target)
  if target == ITM_Amulett then
    _Urwigo.MessageBox({
      Text = _yhK5("\a\v@(/II\v@1W\b\002RI@1I+(\027i\bxI``h(#\002J(/\v@(/II\v@1W\b\002R`h"),
      Media = IMG_Emilio0,
      Callback = function(action)
        if action ~= nil then
          FCT_HellsehenAn()
        end
      end
    })
  elseif target == ITM_WeissesTuch then
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(\v+`(+\002J}@(iFx(I\v@(\022\b\002J:(F/IW(I+(I@`JFIx`(Y\b(w\vIx(PI\v++I(lFW/I:(\bi(@}\002J(Fx+(/\b@`(1\bW\002JY\bDIJI@h"),
      Media = IMG_Emilio0,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_BuntesTuch then
    _Urwigo.MessageBox({
      Text = _yhK5("8\b@(\v+`(I+(I\v@(/\b@`I+(\022\b\002Jh(t@1(PI@@(\v\002J(I+(F\b\t(1I@(\127}y\t(`\bI(\v+`(I+(+}DFW(I\v@(/\b@`I+(\127}y\t`\b\002J:(DI@F\b(P\vI(I+(\vi(\014\b\002J(DI+\002JW\vI/I@(+`F@1h()F+(R}I@@I@(P\vW(/I@\b`YI@h"),
      Media = IMG_Emilio0,
      Callback = function(action)
        if action ~= nil then
          T_Kopftuch.Complete = true
          FCT_HellsehenAn()
        end
      end
    })
  elseif target == ITM_Lollis then
    if V_StoryLine < 250 then
      V_KugelStatus = 10
      _Urwigo.MessageBox({
        Text = _yhK5(")F(+\v@1(I\v@(yFFW(1F/I\v:(1\vI(+IJI@(P\vWRx\v\002J(F\b+(P\vI(I\v@I(\127W\v+`FxxR\bDIx(Fi(\003`\vIxh(#\002J(DxF\b/I:(1\vI(R}I@@`I@(P\vW(Fx+(\aW+F`YR\bDIx(wIWPI@1I@h"),
        Media = IMG_Emilio0,
        Callback = function(action)
          if action ~= nil then
            T_Kristallkugel.Complete = true
            FCT_HellsehenAn()
          end
        end
      })
    elseif V_StoryLine == 250 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(+\b\002J+`(F\b+(FxxI@(]}xx\v+(1I@LI@\vDI@(JIWF\b+:(1IW(1\vI(iI\v+`I(\027IJ@x\v\002JRI\v`(i\v`(I\v@IW(\127W\v+`FxxR\bDIx(JF`:(xID+`(1F+()}R\biI@`(F\b\t(1I@(\014}1I@(\b@1(JFIx`+`(1\vI(\127\bDIx(i\v`(1Ii(yWFR`\v+\002JI@(\022WFDIDW\v\t\t(1\vWIR`(YP\v+\002JI@()}R\biI@`(\b@1(\ai\vx\v}h\020\014\\6\ai\vx\v}(/ID\v@@`(1\vI(sFI@1I(\bI/IW(1IW(\127\bDIx(RWI\v+I@(Y\b(xF++I@:(+I`Y`(I\v@I(P\v\002J`\vDI(o\v@I(F\b\t(\b@1(x\vI+`B"),
          Media = IMG_Emilio8
        },
        {
          Text = _yhK5("hhh(1F@F\002J(P\vW1(1\vI(\014\bWD(\bI/IW(w\vIxI( FJWJ\b@1IW`I(J\v@PID(w}@(1IW(iFI\002J`\vDI@(8IRWFi}WF(/IxFDIW`(PIW1I@h(#JWI(\003RIxI``FWiII(/I+\002J\bI`Y`(+\vI(DIDI@(FxxI:(1\vI(wIW+\b\002JI@(+\vI(w}@(J\vIW(Y\b(wIW`WI\v/I@h\020\014\\6)}\002J(F\b\002J(\vJWI(sIWW+\002JF\t`(P\vW1(@\v\002J`(IP\vD(1F\bIW@h(\a\v@(+\002JPFWYIW(9\vWF`(P\vW1(R}iiI@h(\aW(hhh"),
          Media = IMG_Emilio8
        },
        {
          Text = _yhK5("9x}I`Yx\v\002J(DIWFI`(\ai\vx\v}(\v@+(\003`}\002RI@h(Z\003}(I\v@(o\v+`:(J\vIW(\v+`(1IW(\022I3`(F\b\t(I\v@iFx(\002}1\vIW`h(\027/IW(\v\002J(+IJI(1\vI(\003`IxxI:(w}@(1IW(P\vW(1I@(\003\002Jx\bI++Ix(J}xI@(R}I@@I@h(m\vW(/WF\b\002JI@(@\bW(I\v@(yFFW(\014\b\002J+`F/I@(w}@(I\v@Ii(mIDPI\v+IW(@\v\002J`(PI\v`(w}@(J\vIWh(\028IJ(+\002J@Ixx(\b@1(J}xI(+\vI:(1F@@(iF\002JI@(P\vW(PI\v`IWh(#\002J(+\002JWI\v/()\vW(F\b\t:(PF+(\v\002J(/WF\b\002JI:(1Fi\v`(+}xx`I(I+(I\vDI@`x\v\002J(DF@Y(I\v@\tF\002J(+I\v@:(+\vI(Y\b(J}xI@hZ\020\014\\6\020\014\\6\ai\vx\v}(1W\bI\002R`()\vW(I\v@I@([I``Ix(\v@(1\vI(sF@1(\b@1(wIW+`\bii`h"),
          Media = IMG_Emilio9
        }
      }, function(action)
        V_StoryLine = 254
        Z_Wegweiser.Active = true
        ITM_WegweiserCode:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif V_StoryLine < 255 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(i\b++`(IW+`(Y\bi(mIDPI\v+IW(DIJI@:(/Iw}W(P\vW(PI\v`IWiF\002JI@(R}I@@I@h"),
          Media = IMG_Emilio9
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif V_StoryLine == 255 then
      FCT_DokumentLesen()
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")F+(JF/I@(P\vW(1}\002J(+\002J}@(DIxI+I@h(\a\v@(\003`\bI\002R(8IRWFi}WF:(I\v@(\003`\bI\002R(\003RIxI``:(/I\v1I+(i\v+\002JI@(\b@1(F/(1Fi\v`(\v@+()WF\002JI@\tI\bIWh(\027\002J(LF(\b@1(I\v@(\003\002JIWDI(8IRWFi}WF+(P\vW1()\vW(JIx\tI@h(\027xxI+(RxFWS"),
          Media = IMG_Emilio9
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  elseif target == ITM_Dokument then
    if V_StoryLine < 250 then
      _Urwigo.MessageBox({
        Text = _yhK5("\014I+}WD(i\vW(1I@(DF@YI@([\vDI\b@IW!\127WIiyIx(\b@1(\v\002J(wIW+\b\002JI(I+(Y\b(xI+I@h"),
        Media = IMG_Emilio0,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif V_StoryLine == 250 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5("\028\v/`(i\vW(1I@(]}xx\v(1\bW\002J(1I@(\v\002J(I+(/I`WF\002J`I@(+}xx(\b@1(\v\002J(wIW+\b\002JI(I+(Y\b(xI+I@h"),
          Media = IMG_Emilio9
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif V_StoryLine < 255 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(i\b++`(IW+`(Y\bi(mIDPI\v+IW(DIJI@:(/Iw}W(P\vW(PI\v`IWiF\002JI@(R}I@@I@h"),
          Media = IMG_Emilio9
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif V_StoryLine == 255 then
      FCT_DokumentLesen()
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")F+(JF/I@(P\vW(1}\002J(+\002J}@(DIxI+I@h(\a\v@(\003`\bI\002R(8IRWFi}WF:(I\v@(\003`\bI\002R(\003RIxI``:(/I\v1I+(i\v+\002JI@(\b@1(F/(1Fi\v`(\v@+()WF\002JI@\tI\bIWh(\027\002J(LF(\b@1(I\v@(\003\002JIWDI(8IRWFi}WF+(P\vW1()\vW(JIx\tI@h(\027xxI+(RxFWS"),
          Media = IMG_Emilio9
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  elseif target == ITM_LolliFeder then
    if V_StoryLine < 250 then
      _Urwigo.MessageBox({
        Text = _yhK5("mI@@(iF@(FxxI(s\bIJ@IWF\bDI@(Y\b1W\bI\002R`:(R}I@@`I(1F+(Fx+(\028xF+R\bDIx(1\bW\002JDIJI@h"),
        Media = IMG_Emilio0,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("#\002J(+IJI(I\v@I@(\003yF`Yhhh:(r@/+yOF\b\t(I\v@Ii(\022\v+\002Jh(t@1(hhh(IW(y\v\002R`(I\v@(yFFW(\014W}`RW\bIiIx(F\b\th(\027i(\022\v+\002J(+\v`Y`(LIiF@1(i\v`(I\v@IW([I\v`\b@D(\v@(1IW(sF@1h(t@1(hhh(1F(+`IJ`(DI+\002JW\vI/I@B(Z\027xxI(PFWI@(\bI/IWWF+\002J`(\bI/IW(1I@(WF+F@`I@(\127\bW+F@+`\vID(1IW(\027R`\vI(1IW(l\vWiF(hhhZ()IW(\\I+`(P\vW1(wIW1I\002R`(w}@(1IW(lI1IWh"),
        Media = IMG_Emilio10,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == ITM_LolliHaar then
    if V_StoryLine < 250 then
      _Urwigo.MessageBox({
        Text = _yhK5("mI@@(iF@(FxxI(s\bIJ@IWF\bDI@(Y\b1W\bI\002R`:(R}I@@`I(1F+(Fx+(\028xF+R\bDIx(1\bW\002JDIJI@h"),
        Media = IMG_Emilio0,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("#\002J(+IJI(I\v@I@(1WI\vR}Iy\t\vDI@(\027\t\tI@(\b@1(hhh(J\b\002J:(1F(\v+`(LF(F\b\002J(\028\bU/W\b+J(\022JWIIyP}}1(1W\v@h(m\vI(R}ii`(1I@@(1IW(1F(WI\v@S"),
        Media = IMG_Emilio10,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == ITM_LolliDreck then
    if V_StoryLine < 250 then
      _Urwigo.MessageBox({
        Text = _yhK5("mI@@(iF@(FxxI(s\bIJ@IWF\bDI@(Y\b1W\bI\002R`:(R}I@@`I(1F+(Fx+(\028xF+R\bDIx(1\bW\002JDIJI@h"),
        Media = IMG_Emilio0,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("#\002J(+IJI(I\v@I(\003\002J@I\002RIhhh:(r@/+yOF\b\t(I\v@Ii(\014II`h(t@1(hhh(+\vI(\tW\v++`(I\v@I@(\003FxF`R}y\th(8I/I@(1Ii(\003FxF`R}y\t(x\vID`(I\v@I([I\v`\b@Dh(t@1(hhh(1F(+`IJ`(DI+\002JW\vI/I@B(Z)\vI(]}``}YFJxI@(w}i(m}\002JI@I@1I(xF\b`I@(hhhZ()IW(\\I+`(\v+`(wIW1I\002R`(w}@()WI\002Rh"),
        Media = IMG_Emilio10,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == ITM_LolliX then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sFxx}(\ai\vx\v}h(]\vI+`(1}\002J(iFx(w}W:(PF+(\v@(1Ii(1W\v@(+`IJ`h"),
        Media = IMG_Emilio2
      },
      {
        Text = _yhK5("\028\v/`(JIWh(?J:(1F(\v+`(LF(I\v@(\026(1WF\b\th()F+(\026(iFWR\vIW`(1\vI(\003`IxxI:(PI\v++(1}\002J(LI1IWh()F\t\bIW(i\b++(iF@(RI\v@(sIxx+IJIW(+I\v@h(oFx(+IJI@:(}/(\v\002J(IWRI@@I@(RF@@:(P}(1\vI(\003`IxxI(\v+`h"),
        Media = IMG_Emilio9
      },
      {
        Text = _yhK5("\ai\vx\v}(w}xx\t\bIJW`(+I\v@(\bI/x\v\002JI+(s}R\b+y}R\b+(\b@1(wIWx\vI+`(+\002Jx\vI++x\v\002J(1\vI(\127}}W1\v@F`I@:(1\vI(Y\b(Z1IW(\003`IxxIZ(DIJ}IWI@h"),
        Media = IMG_Emilio10
      },
      {
        Text = _yhK5("sIU(`}xx:(1F+(I@1I`(LF(DI@F\b(P\vI(DI+`IW@h([\bi(\003\002Jx\b++(D\v/`\024+(I\v@I(\127\v+`Ih(8F()\b(PI\v++`(LF:(PF+(1Fi\v`(Y\b(`\b@(\v+`h(#\002J(xID(i\v\002J(\vi(\\\b\002R+F\002R(+\002JxF\tI@(\b@1()\b(DIJ(iFx(1I@(\003\002JF`Y(JI/I@h(#\002J(/\v@(LI`Y`(9\vWF`:(\v\002J(RF@@(i\v\002J(\bi(1\vI+I@(\127xI\v@RWFi(@\v\002J`(iIJW(R\bIiiIW@h"),
        Media = IMG_Emilio2
      }
    }, function(action)
      Z_Final.Active = true
      Z_FinalHint.Active = true
      Z_Innenhof.Active = false
      Z_Tisch.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_StoryLine < 250 then
    _Urwigo.MessageBox({
      Text = _yhK5("#\002J(\t\bIW\002J`I:(1F+(J\vx\t`(\b@+(@\v\002J`(PI\v`IWh"),
      Media = IMG_Emilio0,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5("#\002J(\t\bIW\002J`I:(1F+(J\vx\t`(\b@+(@\v\002J`(PI\v`IWh"),
      Media = IMG_Emilio9,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function P_Skelett:On_XujO(target)
  if V_KochenCounter <= 0 then
    V_TempStr = _yhK5("Z{\vIxxI\v\002J`(+}xx`I@(P\vW(1Ii(\003RIxI``(I\v@I@(\aW+F`Y(\t\bIW(+I\v@I@(\127@}\002JI@(J\vIW(xF++I@Z(+FD`(IW(Y\b()\vW(Fx+(IW(1I@(@}I`\vDI@(\027/+`F@1(YP\v+\002JI@(+\v\002J(\b@1(1I@(\127@}\002JI@iF@@(DI/WF\002J`(JF`h")
    V_KochenCounter = 1
  elseif V_KochenCounter <= 1 then
    V_TempStr = _yhK5("8I\v@:(@I\v@:(@I\v@:(+}(P\vW1(1F+(@\v\002J`+h(m\vW(/WF\b\002JI@(I\v@I@(\aW+F`Yh(?J@I(I`PF+(Y\bi(\022F\b+\002JI@(\tx\vIDI@(P\vW(\viiIW(P\vI1IW(F\b\th")
    V_KochenCounter = 2
  elseif V_KochenCounter <= 2 then
    V_TempStr = _yhK5("#\002J(DxF\b/I:(I+(+y\vIx`(F\b\002J(1F+(W\v\002J`\vDI(\022\vi\v@D(I\v@I(\\}xxIh(mFW`I:(/\v+(1F+(\003RIxI``(J\vIW(\v+`(\b@1(1F@@(iF\002JI@(P\vW(I\v@I@(\027\b+`F\b+\002Jh")
    V_KochenCounter = 3
  else
    V_TempStr = _yhK5("9F++(F\b\t:(\v\002J(JF/I(I\v@I@(9xF@h(m\vW(JF/I@(1}\002J(1\vI(\127I\bxI(w}i(\022W}xxh(\003\002JF\b()\vW(1\vI(\v@(FxxIW(\\\bJI(F@(\b@1(PFW`I(+}(xF@DI:(/\v+(1F+(\003RIxI``(iFx(P\vI1IW(J\vIW(\v+`h()F/I\v(\viiIW(\tI+`(1I@(\014x\v\002R(F\b\t(1\vI(\127I\bxI(DIW\v\002J`I`h()F+(\003RIxI``(R}ii`(+\002J}@(w}@(DF@Y(FxxI\v@(w}W/I\v:(PI@@(+I\v@I([I\v`(DIR}iiI@(\v+`h(\027x+}(1\vI(\127I\bxI(F@+\002JF\bI@(\b@1(PFW`I@(\b@1(PFW`I@:(\028I1\bx1(JF/I@(\b@1(1F@@(yx}I`Yx\v\002J:(+\002JP\byy+(`F\b+\002JI@h")
  end
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")IW(\\FI/I(+\002J@Fyy`(+\v\002J(1I@(\127@}\002JI@:(1}\002J(Fx+(IW(+\v\002J(DIWF1I(1Fi\v`(F\b\t(\b@1(1Fw}@(iF\002JI@(P\vxx:(+y\bIW`(IW(F\b\t(I\v@iFx(I\v@I(Y\vIix\v\002J(\txI\v+\002Jx}+I(sF@1(F\b\t(+I\v@Ii(\127}y\th(\\I\txI3FW`\vD(xFI++`(IW(1I@(\127@}\002JI@(Y\b(\014}1I@(+F\b+I@(\b@1(+\vIJ`(Y\b:(1F++(IW(]F@1(DIP\v@@`h"),
      Media = IMG_Skelett6
    },
    {Text = V_TempStr, Media = IMG_Raebe03}
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function P_Goldschmied:On_OgGl(target)
  if V_SchmiedStatus < 10 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("\003FD(iFx:(sIWW(\028}x1+\002Ji\vI1:()\b(RF@@+`(Fx+}(\027i\bxI``I(/F\bI@:(+}(Fx+(\028}x1+\002Ji\vI1:(@\v\002J`(PFJWS"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("\003Ix/+`wIW+`FI@1x\v\002J(RF@@(\v\002J(1F+h(\027/IW(\v\002J(JF/(RI\v@(oF`IW\vFx(1F/I\vh(\028WI\v\t(iFx(I\v@Ii(@F\002R`I@(oF@@(\v@(1\vI(\022F+\002JIh(\014W\v@D(i\vW()\v@DI:(F\b+(1I@I@(iF@(I\v@I@(\027i\bxI``(iF\002JI@(RF@@(\b@1(\v\002J(iF\002JI()\vW(I\v@I+h(\014\bJh"),
        Media = IMG_Goldschmied02
      },
      {
        Text = _yhK5("\027/IW(IW(i\b++(+yIR`FR\bxFIW(PIW1I@h"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5(")F@@(/W\v@D(i\vW(+yIR`FR\bxFIWI+(oF`IW\vFxh"),
        Media = IMG_Goldschmied02
      }
    }, function(action)
      P_Goldschmied.Commands._mZXP.Enabled = true
      V_SchmiedStatus = 10
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_SchmiedStatus < 20 then
    _Urwigo.MessageBox({
      Text = _yhK5("\014I+}WDI(i\vW(oF`IW\vFx:(F\b+(1Ii(\v\002J()\vW(1F+(\027i\bxI``(/F\bI@(RF@@:(J\b+\002J:(J\b+\002Jh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(+FD(iFx:(sIWW(\028}x1+\002Ji\vI1:(\v\002J(JF/I(LF(LI`Y`(iI\v@(\027i\bxI``(\b@1(P\bIW1I(i\v\002J(DIW@I(\bi(1I@(\\I+`(F\b\002J(@}\002J(R\bIiiIW@:(F/IW(\vWDI@1P\vI(JFI@DI(\v\002J(J\vIW(\tI+`h"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5(")F(DIJ`(I+()\vW(P\vI(i\vWh(s\vIW(\v+`(I+(\viiIW(-(o\v@\b`I@(@F\002J(o\v``IW@F\002J`h"),
        Media = IMG_Goldschmied02
      },
      {
        Text = _yhK5(")F+(\v+`(F/IW(/x}I1h"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("{\vIxxI\v\002J`(JF+`()\b(LF(\028x\bI\002Rh(#\002J(JF``I(+\002J}@(I\v@iFx(\014I+\b\002Jh()IW(+`F@1(1FiFx+(1F@@(\vWDI@1PF@@(w}W(1Ii(\003\002J\vx1:(1F+(1}W`(J\v@`I@(F@(1IW(\127\b@\v`Y/\bWD(JFI@D`(\b@1(JF`(1I@(\022I3`(w}WDIxI+I@:(1IW(1FWF\b\t(DI+\002JW\vI/I@(+`IJ`h(t@1(Fx+(IW(1F+(1W\v``I(m}W`(\v@(1IW(w}WxI`Y`I@([I\vxI(F\b+DI+yW}\002JI@(JF`:(PFW(IW(wIW+\002JP\b@1I@h(#\002J(JF/(RI\v@I(\027J@\b@D(P}J\v@:(F/IW()\b(RF@@+`(I+(DIW@I(iFx(wIW+\b\002JI@:(\014\bJh"),
        Media = IMG_Goldschmied06
      },
      {
        Text = _yhK5("t@1(PI@@(i\v\002J(1F+(F\b\t(1I@(o}@1(RF`Fy\bx`\vIW`S"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5(")F@@(/\v+`()\b(1F@F\002J(F\b\t(1Ii(o}@1h(?1IW()\b(/xI\v/+`(I/I@(F\b\t(\viiIW(iI\v@(\028F+`(\bi(-(@F\002J(o\v``IW@F\002J`h()I\v@I(\a@`+\002JI\v1\b@Dh"),
        Media = IMG_Goldschmied02
      },
      {
        Text = _yhK5("\027\002J:(I+(PFW(LF(@I``(/I\v()\vW:(F/IW(\v\002J(yW}/\vIW(1F@@(w\vIxxI\v\002J`(1}\002J(iFx(1F+(i\v`(1Ii(\003\002J\vx1h"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("8F(Fx+}:(/\bJh"),
        Media = IMG_Goldschmied02
      }
    }, function(action)
      ITM_Schild:MoveTo(Z_Innenhof)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function P_Goldschmied:On_mZXP(target)
  if target == ITM_Lollis then
    _Urwigo.MessageBox({
      Text = _yhK5(")\vW(\v+`(+\002J}@(RxFW:(1F++(1\vI(I\vDI@`x\v\002J(Y\bi(I++I@(1F(+\v@1S"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_LolliHaar then
    _Urwigo.MessageBox({
      Text = _yhK5("\027@(1Ii(RxI/`(LF(I\v@(sFFWh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_LolliDreck then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\v+`(1}\002J(F/IW(1WI\002R\vDh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_LolliFeder then
    _Urwigo.MessageBox({
      Text = _yhK5("\003\vIJ`(D\b`(F\b+:(+}(I\v@(DI\tI1IW`IW(]}xx\vh(\027/IW(\003\002Ji\b\002R(RF@@(iF@(1FWF\b+(@\v\002J`(iF\002JI@h"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_Ringe then
    _Urwigo.MessageBox({
      Text = _yhK5("\\\v@DI(F\b+(\028\bii\vh()F+(P\vW1(LF(P\vWRx\v\002J(+IJW(/II\v@1W\b\002RI@1IW(\003\002Ji\b\002R(PIW1I@h(\027/IW(/I++IW(Fx+(@\v\002J`+h(\027x+}(JIW(i\v`(1Ii([I\bDh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          ITM_Ringe:MoveTo(P_Goldschmied)
          FCT_Schmieden()
        end
      end
    })
  elseif target == ITM_Anhaenger then
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(/\v@(LF(\v\002J\n(mI@@(F\b\002J(F\b+(hhh(\028\bii\vS(m\vWRx\v\002J(/II\v@1W\b\002RI@1h(sIW(1Fi\v`h()FWF\b+(iF\002JI(\v\002J()\vW(I\v@(iFI\002J`\vDI+(\027i\bxI``h(8IRWFi}WF(P\vW1(+\v\002J(P\b@1IW@(hhh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          ITM_Anhaenger:MoveTo(P_Goldschmied)
          ITM_Anhaenger.Commands._GpSaB.Enabled = false
          FCT_Schmieden()
        end
      end
    })
  elseif target == ITM_Muenzen then
    _Urwigo.MessageBox({
      Text = _yhK5("\028}x1(!(1F+(yIW\tIR`I(oF`IW\vFx(\t\bIW(I\v@I@(\028}x1+\002Ji\vI1hhh:(FIJihhh:(1IW(mIWRYI\bD(/I+\v`Y`h(l\bIW(I\v@I@(\028}x1+\002Ji\vI1(}J@I(mIWRYI\bD(xI\v1IW(Y\b(JFW`h()\b(i\b++`(i\vW(\003F\002JI@(/W\v@DI@:(1\vI(\v\002J(FxxI\v@(i\v`(iI\v@I@(sFI@1I@(wIWFW/I\v`I@(RF@@h(\022\b`(i\vW(]I\v1h"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(J\vx\t`(\b@+(@\v\002J`(PI\v`IWh"),
      Media = IMG_Goldschmied02,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function P_Mumie:On_8T4(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\028\b`I@(\022FD(sIWW(o\bi\vIh"),
      Media = IMG_Mumie2
    },
    {
      Text = _yhK5("{IW+\002JP\v@1I(J\vIW:(1F+(\v+`(iI\v@I(9UWFi\v1Ih"),
      Media = IMG_Mumie3
    },
    {
      Text = _yhK5("#\002J(P\vxx()\v\002J(LF(F\b\002J(DFW(@\v\002J`(xF@DI(+`}IWI@h(m}xx`I(@\bW(R\bWY(\tWFDI@:(}/()\b(Y\b\tFIxx\vD(J\vIW(I\v@(?WFRIx(DI+IJI@(JF+`h"),
      Media = IMG_Mumie4
    },
    {
      Text = _yhK5("s\vIW(D\v/`\024+(RI\v@I(?WFRIxh(t@1(PI@@()\b(@IWw\vDI(lWFDI@(+`IxxI@(P\vxx+`:(1F@@(\tWFD(/I++IW(1I@(lW}+\002J(1}W`(1W\bI/I@(Fi(\022\v+\002Jh(r@/+yO)I@(i\b++`I(\v\002J(R\bWY(w}W()\vW(F\b\002J(+\002J}@(w}@(J\vIW(wIW+\002JI\b\002JI@h()F+(\v+`(I\v@({IWRIJW(JI\b`Ih(#\002J(DxF\b/I(\v\002J(i\b++(iFx(i\v`(8IRWFi}WF(WI1I@:(1Fi\v`(+\vI(PF+(DIDI@(1\vI+I(DF@YI@(\022}\bW\v+`I@(\b@`IW@\vii`h(t@1(LI`Y`(iF\002J()\v\002J(I@1x\v\002J(w}i(\027\002RIWh(#\002J(P\vxx(iI\v@I(\\\bJI(JF/I@h"),
      Media = IMG_Mumie1
    },
    {
      Text = _yhK5("\\ID()\v\002J(F/:(/\v@(LF(+\002J}@(PIDh"),
      Media = IMG_Mumie4
    }
  }, function(action)
    Z_Pyramide.Active = false
    Z_Tisch.Active = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _2now:OnBTN_WM_Sprechen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\127F\bi(Y\b(DxF\b/I@:(1\vI(mIW/\b@D(JF`(@\v\002J`(DIx}DI@h(\028\b`I@(\022FD:(\v\002J(/\v@(1IW(\\FI/I(\b@1(F\b\t(1IW(\003\b\002JI(@F\002J(1Ii(yIW\tIR`I@(mI\vJ@F\002J`+DI+\002JI@Rh"),
      Media = IMG_WeihMaus1
    },
    {
      Text = _yhK5("s}(J}(J}h(t@1(\v\002J(/\v@(1\vI(mI\vJ@F\002J`+iF\b+(\b@1(P\bW1I(w}@(1\vI+Ii(yx}I`Yx\v\002J(I\v@+I`YI@1I@(\003\002J@II(Y\vIix\v\002J(\bI/IWWF+\002J`h(t@1(1F+(?WFRIx(\v+`(F\b\002J(DIWF1I(@\v\002J`(1Fh"),
      Media = IMG_WeihMaus2
    },
    {
      Text = _yhK5(" F:(\v\002J(PI\v++h()F+(?WFRIx(+\v`Y`(1F(w}W@I(\b@1(}WFRIx`(\t\bIW(i\v\002Jh"),
      Media = IMG_WeihMaus1
    },
    {
      Text = _yhK5("t@1(PFW\bi(/\v+`()\b(1F@@(J\vIW(JIW(DIR}iiI@:(PI@@()\b(PI\v++`:(P}(1F+(?WFRIx(P\vWRx\v\002J(\v+`S"),
      Media = IMG_WeihMaus2
    },
    {
      Text = _yhK5("mI\vx(F\b\t(1Ii([I``Ix(+`F@1:(PI@@(\003\002J@II(x\vID`:(D\v/`(I+(J\vIW(\028I+\002JI@RI!\014IWF`\b@Dh(t@1(I+(x\vID`(\003\002J@IIh(9\b@R`h"),
      Media = IMG_WeihMaus1
    },
    {
      Text = _yhK5("sii:(1F(\v+`(PF+(1WF@h(8\b@(\v\002J(+Ix/+`(RF@@(xI\v1IW(@\v\002J`(}WFRIx@:(F/IW(\v\002J(JFI``I(1F(@}\002J(I\v@(\028I+\002JI@R:(1F++(i\vW(1F+(?WFRIx(\t\bIW(8}`\tFIxxI(J\vIW(DIxF++I@(JF`h(\027/IW(P\vWRx\v\002J(@\bW(\t\bIW(8}`\tFIxxIh"),
      Media = IMG_WeihMaus2
    },
    {
      Text = _yhK5("sIU:(\v\002J(/\v@(1I@(PI\v`I@(mID(w}@(DF@Y(1}W`(w}W@I(/\v+(J\vIW(J\v@`IW(DIxF\b\tI@(\b@1(1F+(}/P}Jx(\v\002J(i\vW(\bI/IWJF\by`(@\v\002J`(+\v\002JIW(PFW:(}/(I+(+\v\002J(x}J@`(\b@1(}/P}Jx(\v\002J(1I@(DF@YI@(\022FD(+\002J}@(@\v\002J`+(F@1IWI+(iF\002JI(Fx+(J\vIW(J\v@(\b@1(JIW(\b@1(J\v@(\b@1(JIW(hhh"),
      Media = IMG_WeihMaus1
    },
    {
      Text = _yhK5("#+`(LF(+\002J}@(D\b`h(\a+(\v+`(I\v@(8}`\tFxxh(\a\v@I@(o}iI@`:(\v\002J(J}xI(I+(hhh"),
      Media = IMG_WeihMaus3
    },
    {
      Text = _yhK5("s\vIW(/\v``Ih({\vIx(\003yF++(1Fi\v`h"),
      Media = IMG_WeihMaus4
    },
    {
      Text = _yhK5("?J:(I\v@(\028I+\002JI@Rh(m\vI(x\vI/(w}@()\vWh()F@RI+\002J}I@:(x\vI/I(mI\vJ@F\002J`+iF\b+h"),
      Media = IMG_WeihMaus5
    }
  }, function(action)
    ITM_Geschenk:MoveTo(Player)
    Z_Orakel.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _UsT:OnBTN_LichtUntersuchen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(R@I\v\t+`(1\vI(\027\bDI@(Y\b+FiiI@(\b@1(RF@@+`(`F`+FI\002Jx\v\002J(@F\002J(I\v@IW(mI\vxI(I\v@I(l}Wi(F\b+iF\002JI@h()}W`(+\002JPI/`(I\v@(hhh(\028I\v+`(hhh"),
      Media = IMG_EinsiedelB04
    },
    {
      Text = _yhK5("hhh(I\v@(\028I\v+`(i\v`(I\v@Ii(/xF\bI@(s\b`h"),
      Media = IMG_EinsiedelB05
    }
  }, function(action)
    _Xu42P:MoveTo(Z_Einsiedelei)
    _UsT:MoveTo(nil)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _Xu42P:OnBTN_GeistSprechen(target)
  if V_EinsiedeleiStatus < 20 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")IW(\\FI/I(\txF``IW`(@I/I@(1Ii(\028I\v+`(Y\b(\014}1I@(\b@1(/ID\v@@`(1\vWIR`(I\v@I(\127}@wIW+F`\v}@h"),
        Media = IMG_EinsiedelB06
      },
      {
        Text = _yhK5("sFxx}(\028I\v+`h"),
        Media = IMG_EinsiedelB08
      },
      {
        Text = _yhK5("\014\v+`()\b(I+S(#\002J(PFW`I(J\vIW(+\002J}@(+}(xF@DIh(\003FD:(/\v+`()\b(I+S"),
        Media = IMG_EinsiedelB07
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(INP_Geisterfrage)
      end)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@1:(\v+`(IW(I+S"),
        Media = IMG_EinsiedelB07
      },
      {
        Text = _yhK5("#\002J(JF/(@}\002J(@\v\002J`(@F\002JDI+\002JF\b`h"),
        Media = IMG_EinsiedelB08
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function ITM_Laterne:On_aDHF(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(WI\v\002J+`(1Ii(\\FI/I@(1\vI(]F`IW@Ih()IW(+\002JF\b`(IW+`(+RIy`\v+\002J:(@\vii`(+\vI(1F@@(F/IW(1}\002Jh"),
      Media = IMG_FinC1
    },
    {
      Text = _yhK5("mFW\bi(I\vDI@`x\v\002J(@\v\002J`h()F(1W\v@@I@(/WI@@`(I\v@(lI\bIW(\b@1(w}@(I\v@Ii()WF\002JI@(JF/I@(P\vW(1\vI(]F`IW@I(F\b\002Jh(t@1(DF@Y(/I+`\vii`(JF`(1IW()WF\002JI(RI\v@(\003`WI\v\002JJ}xY(/I@\b`Y`(\bi(+\vI(F@Y\bY\bI@1I@:(Fx+}(\v+`(I+(LF(\vWDI@1P\vI(+}DFW(I\v@()WF\002JI@\tI\bIWh(8\bW(}/(1F+(RxI\v@I(lxFIii\002JI@(+\002J}@(Fx+(ZDIPFx`\vDZ(YFIJx`:(1F(JF/I(\v\002J(iI\v@I([PI\v\tIxh(\027/IW(xF++(I+(\b@+(`W}`Y1Ii(wIW+\b\002JI@(hhh"),
      Media = IMG_Raebe04
    },
    {
      Text = _yhK5(")IW(\\FI/I(J}x`(1\vI(\127IWYI(F\b+(1Ii(#@@IWI@(1IW(]F`IW@I(\b@1(JFIx`(1I@(\127@}\002JI@(J\v@I\v@h()\vI(lxFiiI(/ID\v@@`(F\b\tY\b\txF\002RIW@h()}\002J(@\v\002J`(@\bW(1\vI(lxFiiI(J\vIWh("),
      Media = IMG_FinC2
    },
    {
      Text = _yhK5("\027\b\002J(\bi(8IRWFi}WF(JIW\bi(/\vx1I`(+\v\002J(I\v@I(W}`(xI\b\002J`I@1I(\127\bDIxh(\003}:(+}:(1F+(Fx+}(JF/I@(1\vI(Fx`I@(\003\002JW\v\t`I@(Fx+(\vJW(\003\002J\v\002R+Fx(w}WDI+IJI@h"),
      Media = IM_FinD0
    },
    {
      Text = _yhK5("\027/IW(JFx`:(Y\b(\tW\bIJ(DI\tWI\b`h(\027\b\t(I\v@iFx(/ID\v@@`(I+(Y\b(+\002J@I\vI@h(\a+(1F\bIW`(RI\v@I(-(o\v@\b`I@(\b@1(1IW(DF@YI(\014}1I@(\v+`(/I1I\002R`(i\v`(I\v@IW(1\v\002RI@(\003\002J\v\002J`(\003\002J@IIh()F+(W}`I(]I\b\002J`I@(J\v@DIDI@(\v+`(P\vI1IW(wIW+\002J\b@1I@h"),
      Media = IMG_FinD1
    },
    {
      Text = _yhK5(")IW(\\FI/I(\b@1(1\vI(lxI1IWiF\b+(\txF``IW@(\t\bIW(I\v@I@(\027\bDI/x\v\002R(F\b\t(I\v@I@(\027+`(I\v@(\003`\bI\002R(PI\v`IW(}/I@:(\bi(+\v\002J(I\v@I@(tI/IW/x\v\002R(Y\b(wIW+\002JF\t\tI@h(Z)F+(PFW(DF@YI(\027W/I\v`Z:(+FD`(1\vI(lxI1IWiF\b+:(Z F(LF:(8IRWFi}WF(\v+`(D\b`(\v@(\028IDI@YF\b/IW@hZ"),
      Media = IMG_FinD3
    }
  }, function(action)
    if V_FlyerGelesen == true then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(W\b\t+`(w}@(\b@`I@B(Z#\002J(JF/(\bI/W\vDI@+(@}\002J(RI\v@I(mI\vJ@F\002J`+DI+\002JI@RIZ"),
          Media = IMG_Spieler
        },
        {
          Text = _yhK5("m\vI(R}ii+`()\b(1I@@(LI`Y`(F\b\t(+}(I\v@I@(/x}I1+\v@@\vDI@(\028I1F@RI@S(m\vW(JF/I@(DIWF1I(I\v@I(DW}++I(oFD\vIW\v@(Y\b(/I+\vIDI@\n"),
          Media = IMG_FinD7
        },
        {
          Text = _yhK5("#\002J(+FD\024+(LF(@\bWh(8\v\002J`(1F++()\b(+yFI`IW(LFiiIW+`h"),
          Media = IMG_Spieler
        },
        {
          Text = _yhK5("8\v3(1F:(Y\bW\bI\002R(Y\bi()WF\002JI@\tI\bIWh([\bi(\028x\bI\002R(JFIx`(I+(@}\002J(1\bW\002Jh(\027/IW(PIW(PI\v++:(P\vI(xF@DI(@}\002Jh(m\vW(i\bI++I@(I+(P}Jx(1}\002J(DIPFx`\vDIW(iF\002JI@h()\vI(lWFDI(\v+`(@\bW:(P\vIS(m\vI(iF\002J`(iF@()\v@DI(1}\002J(DxI\v\002J(@}\002J(iFx(DW}I++IWS"),
          Media = IMG_FinD2
        }
      }, function(action)
        FCT_LaterneGeben()
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")}\002J(+\002J@Ixx(Y\bW\bI\002R(Y\bi()WF\002JI@\tI\bIWh([\bi(\028x\bI\002R(JFIx`(I+(@}\002J(1\bW\002Jh(\027/IW(PIW(PI\v++:(P\vI(xF@DI(@}\002Jh(m\vW(i\bI++I@(I+(P}Jx(1}\002J(DIPFx`\vDIW(iF\002JI@h()\vI(lWFDI(\v+`(@\bW:(P\vIS(m\vI(iF\002J`(iF@()\v@DI(1}\002J(DxI\v\002J(@}\002J(iFx(DW}I++IWS"),
          Media = IMG_FinD2
        }
      }, function(action)
        FCT_LaterneGeben()
      end)
    end
  end)
end
function ITM_Ast:On_Rs7S1(target)
  if target == P_Raebe then
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(RF@@+`(I+(I\v@\tF\002J(@\v\002J`(xF++I@:(PF+S"),
      Media = IMG_Raebe01,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == P_Troellchen then
    if V_StoryLine < 60 then
      _Urwigo.MessageBox({
        Text = _yhK5("\\IxF`\vw(Dx\bI\002Rx}+(wIW+\b\002J+`()\b:(1F+(\022W}Ixx\002JI@(i\v`(1Ii(\027+`(I\v@Y\b\tF@DI@h(9x}I`Yx\v\002J(yF\002R`(1F+(\022W}Ixx\002JI@(1I@(\027+`(\b@1(+\002JxI\b1IW`()\v\002J(Y\bW(\003I\v`Ih(8\bW(i\v`(8}`(RF@@+`()\b()\v\002J(F\b\t(1I@(\014I\v@I@(JFx`I@h(\003\vIJ`(+}(F\b+:(Fx+(JFI``I(+\v\002J(I\v@(\028W}++`I\vx(1IW(\127WF\t`(1I+(\022W}xx+(\v@(1F+(\022W}Ixx\002JI@(J\v@I\v@R}iyW\vi\vIW`h(\003}(RW\vID+`()\b(\vJ@(@\v\002J`h\020\014\\6)\b(+}xx`I+`()\v\002J(P}Jx(1}\002J(/I++IW(@}\002J(iFx(i\v`(1Ii(\\FI/I@(/IWF`I@:(}/(\a\b\002J(@\v\002J`(PF+(F@1IWI+(I\v@\tFIxx`h"),
        Media = IMG_Ba1Troll,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5("m\vW+`()\b(P}Jx(F\b\tJ}IWI@:(1F+(\022W}Ixx\002JI@(Y\b(FIWDIW@h"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == ITM_Gral then
    if V_FarbStatus == 10 then
      _Urwigo.MessageBox({
        Text = _yhK5(")IW(\\FI/I(@\vii`(1I@(\027+`(\b@1(W\bIJW`(1Fi\v`(\v@(1I@(\014IIWI@(JIW\bi:(1\vI(\vi(\028WFx(x\vIDI@h(\014Fx1(\tF@DI@(+\vI(F@(Y\b(YIWyxF`YI@(\b@1(PF+(\bI/W\vD(/xI\v/`(\v+`(JI\vx\vDIW(\014IIWI@iF`+\002Jh"),
        Media = IMG_GralMin2,
        Callback = function(action)
          if action ~= nil then
            V_FarbStatus = 20
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5(")IW(\027+`(\v+`(Y\b(DW}++:(\bi(\vJ@(\v@(1I@(\028WFx(Y\b(xIDI@h()F(i\b++(IW(P}Jx(xI\v1IW(\b@JI\vx\vD(/xI\v/I@:(FWiIW(\027+`h"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(+`}\002JIW+`(i\v`(1Ii(\027+`(P\vx1(\v@(1IW(\028IDI@1(JIW\bih(mF+(DI@F\b()\b(1Fi\v`(/IYPI\002R+`:(PI\v++`(P}Jx(@\bW()\b(+Ix/+`h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function ITM_Keule:On_w5mQ_(target)
  ITM_Keule:MoveTo(nil)
  ITM_Knochen:MoveTo(Player)
  ITM_Keule.Commands._w5mQ_.Enabled = false
  P_Skelett.Commands._XujO.Enabled = false
  T_Skelett.Complete = true
  _Urwigo.MessageBox({
    Text = _yhK5("\027x+(1Ii(\003RIxI``(DIWF1I(iFx(P\vI1IW(I\v@IW(+I\v@IW(\127@}\002JI@(I@`DxI\v`I`(@\b`Y`(1IW(\\FI/I(1\vI(\028IxIDI@JI\v`(\b@1(wIW`F\b+\002J`(\tx\v@R(P\vI(I\v@(s\bI`\002JI@+y\vIxIW(\127@}\002JI@(\b@1(\127I\bxIh\020\014\\6\003\002J@Ixx(/IiIWR`(1F+(\003RIxI``(1I@({IWx\b+`(\b@1(RIJW`(\bi:(1}\002J(1F(\v+`(1IW(\\FI/I(xFI@D+`(\tIW`\vD:(+I`Y`(+I\v@(\b@+\002J\bx1\vD+`I+(\028I+\v\002J`(F\b\t(\b@1(DW\bI++`(P}JxIWY}DI@(i\v`(Z\028\b`I@(\022FD(sIWW(\127@}\002JI@iF@@Zh"),
    Media = IMG_Skelett5,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Lollis:On_rcTB(target)
  if V_StoryLine == 20 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(YI\vD+`(\vJi(1\vI(]}xx\v+h(Z?/(1\vI(P}Jx(Fx+(o\b@\v`\v}@(`F\bDI@SZ(\tWFD+`()\b(\v@(\\\v\002J`\b@D(1I+(\\FI/I@h"),
        Media = Img_Ba1J
      },
      {
        Text = _yhK5("{\vIx(/I++IW(Fx+(+}(I\v@(\003`I\v@\002JI@(+\v@1(1\vI(F\b\002J(@\v\002J`:(F/IW(\v\002J(wIW+\b\002JI(I+(`W}`Y1Ii(iFxh"),
        Media = Img_Ba1H
      },
      {
        Text = _yhK5(")\b(/I}/F\002J`I+`(F\b+(1IW(lIW@I:(P\vI(1IW(]}xx\v(Y\vIx+\v\002JIW(\v@(\\\v\002J`\b@D(\022W}xxR}y\t(+`\bIWY`h()IW(Y\b\002R`(R\bWY(Y\b+FiiI@(\b@1(+`}I++`(F@+\002Jx\vI++I@1(I\v@I@(lx\b\002J(\v@(\\\v\002J`\b@D(s\viiIx(F\b+B(Z[}xx(/IYFJxI@\n\n\nZh"),
        Media = IMG_Ba1Troll2
      },
      {
        Text = _yhK5("\127\bWY(1FWF\b\t(+\v`Y`(1IW(\\FI/I(P\vI1IW(w}W()\vW(\b@1(/IW\v\002J`I`B(Zm\vI(\v\002J(I+(i\vW(1F\002J`I:(1F+(\028IP\v\002J`(JF`(\vJi(@\v\002J`(w\vIx(F\b+DIiF\002J`h(\027/IW(I+(+FJ(+}(F\b+:(Fx+(}/(IW(DF@Y(wIW@FWW`(\v@(1\vI+I()\v@DIW(PFIWIh(\127I\v@(m\b@1IWh(m\vW1(+\vI(P}Jx(@\v\002J`(\bi+}@+`(\v@(+I\v@IW(\127\v+`I(DIxFDIW`(JF/I@h(t@1(PI@@(IW(@\v\002J`(Y\b(/x}I1(PFIWI(+\vI(F\b+Y\bP\v\002RIx@:(PFIWI(IW(LI`Y`(i\v`(+\002JxI\002RI@(/I+\002JF\t`\vD`h(\022W}xx(I/I@hZ"),
        Media = Img_Ba1H
      }
    }, function(action)
      V_StoryLine = 40
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(/\vI`I+`(1Ii(\\FI/I@(I\v@I@(1IW(]}xx\v+(F@:(F/IW(1IW(xIJ@`(1F@RI@1(F/B(Z[\b(w\vIx([\b\002RIW(\v+`(DFW(@\v\002J`(DI+\b@1Z")
    })
  end
end
function ITM_Lollis:On_j7O6f(target)
  if V_StoryLine == 0 and 0 <= V_DtLolli then
    V_DtLolli = V_DtLolli + 1
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(@\vii+`()\vW(I\v@I@(1IW(]}xx\vI+(\b@1(+`I\002R+`(\vJ@(\v@(1I@(o\b@1h(sii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWIh\020\014\\6\a+(1F\bIW`(@\v\002J`(xF@DI(\b@1(1\vI(\127\bxxIW(JF`(+\v\002J(\v@(I\v@I(RxI/W\vDI(lx\b++\vDRI\v`(wIWPF@1Ix`:(1\vI(LI`Y`(\v@()I\v@Ii(oFDI@(J\v@(\b@1(JIW(+\002JPFyyIW`h"),
      Callback = function(action)
        if action ~= nil then
          FCT_DevToolDrop()
        end
      end
    })
  elseif V_StoryLine == 40 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(@\vii+`()\vW(I\v@I@(1IW(]}xx\v+(\b@1(+`I\002R+`(\vJ@(\v@(1I@(o\b@1h(sii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWIh\020\014\\68}\002J(/Iw}W(+\v\002J(1F+(s\vi/IIWFW}iF(w}xx(I@`\tFx`I@(RF@@:(P\vW1(1\vW(yx}I`Yx\v\002J(RxFW:(1F++(1\vI+IW(]}xx\v(I\v@I(J}IJIWI(\014I+`\vii\b@D(JF`h()\b(WI\v\002J+`(1F+(F@DI+\002JxF//IW`I()\v@D(1Ii(\\FI/I@(\b@1(1IW(\v+`(+}\t}W`(P\vI1IW(F\b\t(\022W}xxR\bW+(\v@(1IW(]\b\t`h")
      },
      {
        Text = _yhK5("\aW(RWI\v+`(I\v@(mI\vxI(\bI/IW(1Ii(\022W}Ixx\002JI@(\b@1(xFI++`(1F@@(1I@(s\vi/IIWRxI/IW(F\b\t(1F+(\127}Iy\t\002JI@(1I+(\022W}Ixx\002JI@+(JIW\b@`IWyWF++Ix@h\020\014\\6)IW(\022W}xx(\v+`(/IDI\v+`IW`h(\a@1x\v\002J(RF@@(IW(]}xx\v(x\b`+\002JI@(}J@I(xFI+`\vDI({IWyF\002R\b@Dh()IW([\b\002RIW(/ID\v@@`(+\v\002J(Y\b(x}I+I@(\b@1(IWD\v/`(I\v@I(oI@DI(RxI/W\vDI(oF++Ih(\a+(+\002JI\v@`(1Ii(\022W}xx(LI1}\002J(@\v\002J`+(F\b+Y\biF\002JI@:(1F++(IW(yWFR`\v+\002J(F@(1IW(\127\bDIx(\tI+`RxI/`h()\vI(w}xxI(\127}@YI@`WF`\v}@(1I+(\022W}Ixx\002JI@+:(\tFxx+(I+(+}(I`PF+(\bI/IWJF\by`(D\v/`:(\v+`(i}iI@`F@(\v@([\b\002RIWPF++IW(DI/\b@1I@h"),
        Media = IMG_Ba1Troll3
      }
    }, function(action)
      V_StoryLine = 50
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(@\vii+`()\vW(I\v@I@(1IW(]}xx\vI+(\b@1(+`I\002R+`(\vJ@(\v@(1I@(o\b@1h(sii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWIh\020\014\\6\a+(1F\bIW`(@\v\002J`(xF@DI(\b@1(1\vI(\127\bxxIW(JF`(+\v\002J(\v@(I\v@I(RxI/W\vDI(lx\b++\vDRI\v`(wIWPF@1Ix`:(1\vI(LI`Y`(\v@()I\v@Ii(oFDI@(J\v@(\b@1(JIW(+\002JPFyyIW`h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function ITM_LolliFeder:On_34e4o(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(JI/+`(1I@(]}xx\v(F\b\t(\b@1(yF\002R+`(\vJ@(i\b`\vD(Y\bW\bI\002R(\v@()I\v@I@(\\\b\002R+F\002Rh()IW(\v+`(1}\002J(@}\002J(D\b`:(1I@(RF@@(iF@(1}\002J(@}\002J(hhh:(@I\v@(RF@@(iF@(@\v\002J`h()\b(@\vii+`(\vJ@(F/IW(`W}`Y1Ii(i\v`h"),
    Media = IMG_Lolli2a,
    Callback = function(action)
      if action ~= nil then
        ITM_LolliFeder:MoveTo(Player)
        ITM_LolliFeder.Commands._34e4o.Enabled = false
        ITM_LolliFeder.Commands.__oru.Enabled = true
        FCT_RestartHelpCountDown()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_LolliFeder:On__oru(target)
  _Urwigo.MessageBox({
    Text = _yhK5("Zsii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWI(i\v`(I\v@Ii(sF\b\002J(w}@(\003yF`YhZ:(1I@R+`()\b()\vW:(P\vxx+`(I+(F/IW(@\v\002J`(P\vWRx\v\002J(F\b+yW}/\vIWI@h"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_LolliHaar:On_6IsGG(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(JI/+`(1I@(]}xx\v(F\b\t(\b@1(yF\002R+`(\vJ@(i\b`\vD(Y\bW\bI\002R(\v@()I\v@I@(\\\b\002R+F\002Rh()IW(\v+`(1}\002J(@}\002J(D\b`:(1I@(RF@@(iF@(1}\002J(@}\002J(hhh:(@I\v@(RF@@(iF@(@\v\002J`h()\b(@\vii+`(\vJ@(F/IW(`W}`Y1Ii(i\v`h"),
    Media = IMG_Lolli1a,
    Callback = function(action)
      if action ~= nil then
        ITM_LolliHaar:MoveTo(Player)
        ITM_LolliHaar.Commands._6IsGG.Enabled = false
        ITM_LolliHaar.Commands._yzHs.Enabled = true
        FCT_RestartHelpCountDown()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_LolliHaar:On_yzHs(target)
  _Urwigo.MessageBox({
    Text = _yhK5("Zsii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWI(i\v`(I\v@Ii(sF\b\002J(w}@(1WI\vR}Iy\t\vDIi(\027\t\tI@Z:(1I@R+`()\b()\vW:(P\vxx+`(I+(F/IW(@\v\002J`(P\vWRx\v\002J(F\b+yW}/\vIWI@h"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_LolliDreck:On_ZLZ8f(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(JI/+`(1I@(]}xx\v(F\b\t(\b@1(yF\002R+`(\vJ@(i\b`\vD(Y\bW\bI\002R(\v@()I\v@I@(\\\b\002R+F\002Rh()IW(\v+`(1}\002J(@}\002J(D\b`:(1I@(RF@@(iF@(1}\002J(@}\002J(hhh:(@I\v@(RF@@(iF@(@\v\002J`h()\b(@\vii+`(\vJ@(F/IW(`W}`Y1Ii(i\v`h"),
    Media = IMG_Lolli3a,
    Callback = function(action)
      if action ~= nil then
        ITM_LolliDreck:MoveTo(Player)
        ITM_LolliDreck.Commands._ZLZ8f.Enabled = false
        ITM_LolliDreck.Commands._tL2.Enabled = true
        FCT_RestartHelpCountDown()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_LolliDreck:On_tL2(target)
  _Urwigo.MessageBox({
    Text = _yhK5("Zsii:(xI\002RIW:(+\002JiI\002R`(@F\002J(s\vi/IIWI(i\v`(I\v@Ii(sF\b\002J(w}@(\003\002J@I\002RIhZ:(1I@R+`()\b()\vW:(P\vxx+`(I+(F/IW(@\v\002J`(P\vWRx\v\002J(F\b+yW}/\vIWI@h"),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Notiz:OnBTN_Notiz_Weglegen(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1I@([I``Ix(Y\bW\bI\002R(\v@(1\vI(1\b@RIx+`I(\a\002RI(1I+(\\\b\002R+F\002R+h"),
    Callback = function(action)
      if action ~= nil then
        if V_DtNotiz >= 0 then
          V_DtNotiz = V_DtNotiz + 1
          FCT_DevToolDrop()
        else
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function ITM_Buch:On_LDd(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(DI+`F``I+`(1}\002J(+\v\002JIW:(1F++(\v\002J(iFx(I\v@I@(\014x\v\002R(J\v@I\v@(PIW\tIS"),
      Media = IMG_Ba3CRaebe
    },
    {
      Text = _yhK5(")\vI+(\v+`(I\v@I(\014\v/x\v}`JIRh(#\002J(/\v@(I+(DIP}J@`:(1F++(]I\b`I(iI\v@I(\014\bI\002JIW(xI+I@h(8\bW(Y\bh"),
      Media = IMG_Ba3CBibl
    },
    {
      Text = _yhK5("Z\022W}xx(\022I\002J@}x}D\vI(!(\022JI}W\vI(\b@1(9WF3\v+Z:(Jiii:(@F(}/(1F+(+}(iI\v@+(\v+`h(#\002J(+\002JxFD(iFx(I\v@I(Y\b\tFIxx\vDI(\003I\v`I(F\b\th\020\014\\6\020\014\\6hhh(\b@1(+}(R}ii`(I+(i\v`\b@`IW(w}W:(1F++(iF@(\022W}xxI(i\v`(s\vx\tI(w}@(9F++P}IW`IW@(+\002JW\biy\tI@(RF@@h()F/I\v(\v+`(LI1}\002J(Y\b(/IF\002J`I@:(1F++(1\vI+IW({}WDF@D(+\v\002J(+}(I\v@\tF\002J(\biRIJWI@(xFI++`:(P\vI(1F+(m}W`(+Ix/+`(hhh")
    },
    {
      Text = _yhK5("\027\002J()F@RI:(\v\002J(DxF\b/I(w}@(\022W}xxI@(JF/I(\v\002J(IW+`(iFx(DI@\bDh(sF+`()\b(@}\002J(F@1IWI(\014\bI\002JIWh"),
      Media = IMG_Ba3CRaebe
    },
    {
      Text = _yhK5("\003Ix/+`wIW+`FI@1x\v\002Jh(m\vW\t(I\v@\tF\002J(I\v@I@(\014x\v\002R(F\b\t(iI\v@I(\027\b+PFJx(J\vIWh"),
      Media = IMG_Ba3CBibl
    }
  }, function(action)
    P_Troellchen.Commands._oO8w.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function ITM_Buch:On_W7hAn(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(WI\v\002J+`(1Ii(\022W}xx(1F+(\014\b\002Jh(\028F@Y(\b@DxFI\b/\vD(+\002JF\b`(IW()\v\002J(F@(\b@1(\tWFD`(Z[}xxSZ([\bi(\028x\bI\002R(wIW+\b\002J`(IW(PI@\vD+`I@+(@\v\002J`:(I+(Y\b(I++I@h"),
    Callback = function(action)
      if action ~= nil then
        ITM_Buch:MoveTo(P_Troll)
        ITM_Buch.Commands._W7hAn.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Buechlein:On_Tlyh(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("s\vIW:(\014\v/x\v}`JIRFW:(+\002JF\b(iFx:(PF+(1IW(\022W}xx(\t\bIW()\v\002J(DI+\002JW\biy\t`(JF`h"),
      Media = IMG_BA3D1
    },
    {
      Text = _yhK5("#\002J(P\b++`I(1}\002J:(1F++(\v\002J(F\b\t()\v\002J(/F\bI@(RF@@h(sF/(w\vIxI@()F@Rh(\027x+(\014Ix}J@\b@D(DI/I(\v\002J()\vW(I\v@I@(r@/+yO\014\v/x\v}`JIR+!\027\b+PI\v+h(\003}(I`PF+(/I+\v`Y`(@\v\002J`(LI1IWh(#\002J(/WF\b\002JI(@\bW(@}\002J(I\v@(l}`}(w}@()\vW(\b@1(+\002J}@(RF@@(\v\002J(\vJ@(F\b++`IxxI@h"),
      Media = IMG_Bibliothekar
    }
  }, function(action)
    V_StoryLine = 100
    Z_TrollPwd.Active = false
    ITM_Buechlein:MoveTo(nil)
    T_Schrumpfkur.Complete = true
    ITM_Buechlein.Commands._Tlyh.Enabled = false
    if Player:Contains(ITM_Foto) then
      FCT_AusweisGeben()
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5("\a\v@(l}`}(JF/(\v\002J(LI`Y`(F/IW(DIWF1I(@\v\002J`(1F/I\vh(\028IJ`(I+(F\b\002J(}J@IS"),
          Media = IMG_Raebe01
        },
        {
          Text = _yhK5("8I\v@h(oF\002J(+\002J@Ixx(I\v@+(\b@1(R}ii(Y\bW\bI\002R:(\v\002J(PFW`I(+}xF@DIh"),
          Media = IMG_Bibliothekar
        }
      }, function(action)
        P_Raebe.Commands._YWV.Enabled = true
        T_Foto.Active = true
        V_BibStatus = 20
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  end)
end
function ITM_BibAusweis:On_jwO(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")IW(\\FI/I(`\vyy`(i\v`(1Ii(\003\002J@F/Ix(F\b\t(1\vI(\003`IxxI:(F\b\t(1IW(DI+\002JW\vI/I@(+`IJ`(Z\014\v/x\v}`JIR(W\b\tI@Z(\b@1(+\002J}@(+`IJ`(1IW(\014\v/x\v}`JIRFW(w}W()\vWh(\a\v@(\003iFW`yJ}@I(\v+`(I\v@()WI\002R(1FDIDI@h"),
    Media = IMG_BibRuf0,
    Callback = function(action)
      if action ~= nil then
        if V_FMausStatus == 10 and V_StoryLine == 240 then
          V_TempInt = tonumber(MeasureDistanceToZone(Z_Local_FMaus))
          if V_TempInt < 20 then
            if Z_Tisch:Contains(Player) then
              P_Fledermaus:MoveTo(Z_Tisch)
              Z_Local_FMaus.Active = false
              V_FMausStatus = 20
              T_Begleiter.Complete = true
              _Urwigo.Dialog(false, {
                {
                  Text = _yhK5("#WDI@1P\vI(+\002JI\v@`(1IW(lxI1IWiF\b+(1F+(\003y\vIx(xF@D+Fi(xF@DPI\vx\vD(Y\b(PIW1I@h\020\014\\6\020\014\\6Z\027\002J:(1F@@(iF\002J`(1}\002J(i\v`(1I@(\014\bI\002JIW@(PF+(\vJW(P}xx`h(#\002J(+\002JF\b(iFx(1Ii(?WFRIx(/I\vi(}WFRIx@(Y\bh(#+`(/I+`\vii`(w\vIx(\v@`IWI++F@`IWhZ"),
                  Media = IMG_Emilio6
                }
              }, function(action)
                FCT_HellsehenAn()
              end)
            else
              CenterLocal(Z_Local_FMaus, 5)
              Z_Local_Bib.Active = false
              Z_Local_FMaus.Active = true
              Z_Local_FMaus.Visible = true
              _Urwigo.MessageBox({
                Text = _yhK5("{IW1Fii`:(1\vI(lxI1IWiF\b+(JF`(1I@(\014\v/x\v}`JIRFW(I@`1I\002R`h\020\014\\6m\vI(\vWWI(/ID\v@@`(+\vI(Y\b(R\v\002JIW@(\b@1(P\vW\t`(iFD\v+\002JI(\014x\v\002RI(\v@(\\\v\002J`\b@D(+I\v@IW(\014\bI\002JIWh([\bi(\028x\bI\002R(PFW(1IW(\014\v/x\v}`JIRFW(1FWF\b\t(DI\tF++`(\b@1(\v+`(DI@F\b(+}(+\002J@Ixx(P\vI1IW(wIW+\002JP\b@1I@:(P\vI(IW(F\b\tDI`F\b\002J`(\v+`h()F\t\bIW(JFI@D`(LI`Y`(1\vI(lxI1IWiF\b+(Fi(@FI\002J+`I@(\027+`(1\vWIR`(@I/I@()\vWh"),
                Media = IMG_Fledermaus4,
                Callback = function(action)
                  if action ~= nil then
                    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                  end
                end
              })
            end
          else
            _Urwigo.MessageBox({
              Text = _yhK5("]I\v\002J`(@IWw}I+(+\002JF\b`(IW(+\v\002J(\bi(\b@1(+FD`(+\002Jx\vI++x\v\002JB(Z\003I\v@(/x}++(w}W+\v\002J`\vDh()\vI(lxI1IWiF\b+(\v+`(J\vIW(\vWDI@1P}h()F+(DI\tFIxx`(i\vW(DFW(@\v\002J`h(mIW(PI\v++:(PF+(+\vI(F@+`Ixx`:(PI@@()\b(1F+(\v@(\vJWIW(8FIJI(iF\002J+`hZ"),
              Media = IMG_Bibliothekar,
              Callback = function(action)
                if action ~= nil then
                  CenterLocal(Z_Local_Bib, 10)
                  Z_Local_Bib.Active = true
                  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
                end
              end
            })
          end
        else
          CenterLocal(Z_Local_Bib, 10)
          Z_Local_Bib.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    end
  })
end
function ITM_Amulett:On_qFJH(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1F+(\127I``\002JI@(\v@(1\vI(\022W\bJI(\b@1(J}\t\t+`:(1F++(1\vI(9\vWF`I@(@\v\002J`(iIWRI@:(PF+()\b(F\b+(\vJWIi(\027@JFI@DIW(DIiF\002J`(JF+`h(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
    Callback = function(action)
      if action ~= nil then
        V_SchatzStatus = 0
        ITM_Amulett:MoveTo(nil)
        ITM_Amulett.Commands._qFJH.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Beeren:On_eDe(target)
  TMR_Hunger:Stop()
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(y\tx\bI\002R+`(I\v@(yFFW(w}@(1I@(\014IIWI@(\b@1(P\vW\t+`(+\vI(1Ii(\\FI/I@(\vi(\\\b\002R+F\002R(Y\bB(Zs\vIW:(\t\bIW()\v\002JhZ"),
    Media = IMG_Ba6Beeren,
    Callback = function(action)
      if action ~= nil then
        ITM_Beeren:MoveTo(Player)
        Z_Beeren1.Active = false
        Z_Beeren2.Active = false
        Z_Beeren3.Active = false
        ITM_Beeren.Commands._eDe.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Schatztruhe:On_y27(target)
  if Player:Contains(ITM_Schluessel) then
    if V_SchatzStatus == 0 then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(}I\t\t@I+`(1\vI(\022W\bJI(\b@1(/\v+`(DI/xI@1I`(w}@(1Ii(\\I\v\002J`\bi:(1I@(1\vI(9\vWF`I@(F@DI+FiiIx`(JF/I@h()F+(JFI``I+`()\b(1I@(1WI\vI@(DFW(@\v\002J`(Y\bDI`WF\b`h(\027@1IWIW+I\v`+:(I+(+\v@1(\viiIWJ\v@(9\vWF`I@:(DI@F\b(P\vI()\b:(/Fx1(hhh"),
          Media = IMG_SchatzkisteOffen
        }
      }, function(action)
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(INP_Schatzkiste)
        end)
      end)
    else
      _Urwigo.MessageBox({
        Text = _yhK5("t@`IW()\vW(J}IW+`()\b(I\v@I@(1IW(9\vWF`I@(W\b\tI@B(Z I1IW(9\vWF`I@F@PFIW`IW(\viiIW(@\bW(I\v@(\022I\vxhZ"),
        Media = IMG_Piraten6,
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
        Text = _yhK5("?J@I(1I@(yF++I@1I@(\003\002Jx\b++Ix(\v+`(1F(P}Jx(@\v\002J`+(Y\b(iF\002JI@:(+\002J}@(DFW(@\v\002J`:(PI@@(1\vI(9\vWF`I@(1\vWIR`(1FW\b@`IW(+\v`YI@h"),
        Media = IMG_Schatztruhe2
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function ITM_Gral:On_DYufo(target)
  if V_FarbStatus >= 10 and V_FarbStatus < 30 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("8\v\002J`(+}xF@DI(1\vI(\014IIWI@(1W\v@(+\v@1h()F(LFiiIW@(1\vI(9\vWF`I@(@\bW(W\bih")
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_FarbStatus == 30 then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")\b(xID+`(1I@(JI\vx\vDI@(\028WFx(\v@(1\vI(\022W\bJI(Y\bW\bI\002Rh(Z\003FD(iFx:(RF@@(1F+(+I\v@:(1F+(1IW(F@1IW+(F\b++\vIJ`(Fx+(w}WJIWSZ(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h"),
        Media = IMG_Piraten6
      },
      {
        Text = _yhK5("8}I:(@}I:(DI@F\b(P\vI(\viiIW:(FxxI+(/I+`I@+h"),
        Media = IMG_Schatztruhe3
      }
    }, function(action)
      V_FarbStatus = 40
      V_SchatzStatus = 0
      ITM_Gral:MoveTo(nil)
      ITM_Gral.Commands._DYufo.Enabled = false
      ITM_Gral.Commands._VGq_t.Enabled = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(xID+`(1I@(JI\vx\vDI@(\028WFx(\v@(1\vI(\022W\bJI(Y\bW\bI\002Rh(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
      Callback = function(action)
        if action ~= nil then
          V_SchatzStatus = 0
          ITM_Gral:MoveTo(nil)
          ITM_Gral.Commands._DYufo.Enabled = false
          ITM_Gral.Commands._VGq_t.Enabled = false
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function ITM_Gral:On_VGq_t(target)
  if target == ITM_Keule then
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(xID+`(1\vI(\127I\bxI(\v@(1I@(JI\vx\vDI@(\028WFx(J\v@I\v@h(mI@@()\b(@}\002J(I\v@(yFFW(\022W}y\tI@(mF++IW(J\v@Y\b(`\b@(P\bIW1I+`:(+FIJI(I+(F\b+(P\vI(1IW(\014}1I@+F`Y(I\v@IW(JI\vx\vDI@(s\bIJ@IW+\byyIh(]I\v1IW(JF+`()\b(1F\t\bIW(\bI/IWJF\by`(RI\v@I({IWPI@1\b@D(\b@1(+}(@\vii+`()\b(1\vI(\127I\bxI(P\vI1IW(JIWF\b+h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_Lollis then
    _Urwigo.MessageBox({
      Text = _yhK5(")\b(P\vxx+`(1\vI(]}xx\v+(\v@(1I@(\028WFx(xIDI@:(\bI/IWxID+`(I+()\vW(\v@(xI`Y`IW(\003IR\b@1I(F/IW(1}\002J(@}\002J(F@1IW+h({IWi\b`x\v\002J(1FW\t(iF@(+\vI(@\v\002J`(iIJW(I++I@:(PI@@(+\vI(I\v@iFx(JI\vx\vD(DIP}W1I@(+\v@1(\b@1(1F+(P\vxx+`()\b(@\v\002J`(W\v+R\vIWI@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_Beeren then
    if V_FarbStatus == 0 then
      _Urwigo.MessageBox({
        Text = _yhK5(")IW(\\FI/I(+\b\002J`(1\vI(WI+`x\v\002JI@(\014IIWI@(Y\b+FiiI@:(1\vI(@}\002J(\vi(\\\b\002R+F\002R(JIW\biR\bxxIW@(\b@1(xID`(+\vI(\v@(1I@(\028WFxh(\003\vIJ`(J\bI/+\002J(F\b+h()F+(1FW\t(+}(/xI\v/I@h"),
        Media = IMG_GralMix1,
        Callback = function(action)
          if action ~= nil then
            V_FarbStatus = 10
            ITM_Beeren:MoveTo(nil)
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  elseif target == ITM_WeissesTuch then
    if V_FarbStatus == 10 then
      _Urwigo.MessageBox({
        Text = _yhK5(")F(+\v@1(+\002J}@(1\vI(\014IIWI@(\vi(\028WFx:(mI@@()\b(1F+(\022\b\002J(LI`Y`(@}\002J(1FY\b(`\b+`:(P\vW1(I+(@\bW(1WI\002R\vDh(\027xxIW1\v@D+:(w\vIxxI\v\002J`(\v+`(I+(LF(DI@F\b(1F+:(PF+()\b(P\vxx+`h(#@(1Ii(lFxx(FxxIW1\v@D+(P\vW1(I+(@}\002J(@\v\002J`(1WI\002R\vD(DI@\bDh"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    elseif V_FarbStatus == 20 then
      _Urwigo.MessageBox({
        Text = _yhK5(")IW(\014IIWI@iF`+\002J(D\v/`(I\v@(D\b`I+(lFIW/Ii\v``Ix(F/h()IW(\\FI/I(`F\b\002J`(1F+(\022\b\002J(DW\bI@1x\v\002J(I\v@(\b@1(+F\bD`(FxxI+(F\b\t:(PF+(+I\v@I(sI\vx\vDRI\v`:(1IW(\028WFx:(JIWD\v/`h()F@F\002J(JF+`()\b(I\v@(/\b@`I+(\022\b\002J(\b@1(I\v@I(/x\v`Y/xF@RI(\\Ix\vp\b\vIh"),
        Media = IMG_GralMin3,
        Callback = function(action)
          if action ~= nil then
            V_FarbStatus = 30
            ITM_WeissesTuch:MoveTo(nil)
            ITM_BuntesTuch:MoveTo(Player)
            T_Kopftuch.Complete = true
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _yhK5(")\b(xID+`(1F+(\022\b\002J(\v@(1I@(\028WFx:(PFW`I+`(I\v@I(mI\vxI(\b@1(@\vii+`(I+(P\vI1IW(JIWF\b+h(mI@@(I+(LI`Y`(LIiF@1(/I@\b`Y`:(\bi(+\v\002J(Fx+(\028I+yI@+`(Y\b(wIWRxI\v1I@:(1F@@(IWD\v/`(1F+(I\v@I@(JI\vx\vDI@(\028I\v+`h"),
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end
  end
end
function ITM_Muenzen:On_eNmRW(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1\vI(\028}x1i\bI@YI@(\v@(1\vI(\022W\bJI(Y\bW\bI\002Rh(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
    Callback = function(action)
      if action ~= nil then
        V_SchatzStatus = 0
        ITM_Muenzen:MoveTo(nil)
        ITM_Muenzen.Commands._eNmRW.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Briefmarke:On_XQgLK(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1\vI(\014xF\bI(oF\bW\v`\v\b+(\v@(1\vI(\022W\bJI(Y\bW\bI\002R:(+\002Jx\vI++x\v\002J(P\vxx+`()\b(i}iI@`F@(+}P\vI+}(RI\v@I@(\014W\vI\t(wIW+\002J\v\002RI@h(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
    Callback = function(action)
      if action ~= nil then
        V_SchatzStatus = 0
        ITM_Briefmarke:MoveTo(nil)
        ITM_Briefmarke.Commands._XQgLK.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Foto:On_70V(target)
  FCT_AusweisGeben()
end
function ITM_Haar:On_21c(target)
  if target == ITM_Keule then
    _Urwigo.MessageBox({
      Text = _yhK5(")F+(\v+`(YPFW(F\b\002J(I\v@(\127@}\002JI@:(F/IW(PI@@()\b(8IRWFi}WF(P\vWRx\v\002J(x}+PIW1I@(P\vxx+`:(1F@@(i\b++`()\b()\vW(+\002J}@(I\v@I@(w}@(\vJWIW(\003RIxI``!\027WiII(/I+}WDI@h"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif target == ITM_Knochen then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")IW(\\FI/I(P\v\002RIx`(1F+(sFFW(\bi(1I@(\127@}\002JI@(\b@1(JF`(@\b@(I\v@(I\v@YIx@I+()\v@D:(1F+(Y\b(I\v@Ii(\022I\vx(w}@(1IW(\003RIxI``!\027WiII(\b@1(Y\bi(F@1IWI@(\022I\vx(w}@(8IRWFi}WF(+`Fii`h(r@/+yO\003}(+`F@1(I+(DI+\002JW\vI/I@:(Fx+}(`\b`(IW(I+(+}h"),
        Media = IMG_FinA1
      },
      {
        Text = _yhK5(")Fi\v`(IWPI\002R`(IW(+}DxI\v\002J(P\vI1IW(1F+(#@`IWI++I(1IW(lxI1IWiF\b+h(\003\vI(\txF``IW`(\bi(+I\v@I@(\127}y\t(JIW\bi(\b@1(+FD`B(Z]F++(\b@+(1\vI(\003F\002JI(1}W`(w}W@I(F@(1Ii(\003`I\v@JF\b\tI@(Y\b(\a@1I(/W\v@DI@h()F+(+\002JI\v@`(i\vW(I\v@I(D\b`I(\003`IxxI(1F\t\bIW(Y\b(+I\v@hZ"),
        Media = IMG_FinA2
      },
      {
        Text = _yhK5(")IW(\\FI/I(@\v\002R`(\b@1(\tx\bI+`IW`()\vW(Y\bB(Zl}xDI(\b@+:(\b@F\b\t\tFIxx\vDhZ()F@@(yF\002R`(IW(1I@(\127@}\002JI@(i\v`(+I\v@Ii(\003\002J@F/Ix(\b@1(\txF``IW`(DIiI\v@+Fi(i\v`(1IW(lxI1IWiF\b+(x}+(\v@(\\\v\002J`\b@D(Y\bi(\003`I\v@JF\b\tI@h"),
        Media = IMG_FinA3
      }
    }, function(action)
      ITM_Haar:MoveTo(nil)
      ITM_Knochen:MoveTo(nil)
      P_Raebe:MoveTo(Z_Steinhaufen)
      P_Fledermaus:MoveTo(Z_Steinhaufen)
      Z_Steinhaufen.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function ITM_Uhr:On_HcSK(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1\vI(tJW(\v@(1\vI(\022W\bJI(Y\bW\bI\002Rh()\b(P\vxx+`(x\vI/IW(DFW(@\v\002J`(P\v++I@:(P\vI(xF@DI()\b(LI`Y`(+\002J}@(wIW+\b\002J+`:(1F+()}R\biI@`(Y\b(I@`+\002Jx\bI++Ix@h()F(\v+`(I+(/I++IW:(PI@@()\b(DFW(RI\v@I(tJW(1F/I\v(JF+`h(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
    Callback = function(action)
      if action ~= nil then
        V_SchatzStatus = 0
        ITM_Uhr:MoveTo(nil)
        ITM_Uhr.Commands._HcSK.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Uhr:On_f6Q40(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\003\vIJ`(F\b+(P\vI(I\v@I(DF@Y(@}WiFxI(Fx`I(\022F+\002JI@\bJW:(Fx+}(\tF+`h()}W`(P}(I\vDI@`x\v\002J(1F+()F`\bi(+I\v@(+}xx`I:(/I\t\v@1I`(+\v\002J(I\v@(/WI\v`I+(lIx1:(\v@(1Ii(iF@(I\v@I(w\vIW+`Ixx\vDI([FJx(+\vIJ`h()\b(JF+`(\bI/IWJF\by`(RI\v@I({}W+`Ixx\b@D:(PF+(+\vI(/I1I\b`I@(R}I@@`I:(F/IW()\b(/IiIWR+`(+\002J@Ixx:(1F++()\b(+\vI(wIWFI@1IW@(RF@@+`:(+}/Fx1()\b(F@(1Ii(RxI\v@I@(\\FI1\002JI@(1F@I/I@(1WIJ+`h(t@1(iF@(RF@@(F@(1Ii(\\FI1\002JI@(@\v\002J`(@\bW(1WIJI@:(iF@(RF@@(I+(F\b\002J(\v@(1\vI(tJW(J\v@I\v@(1W\bI\002RI@h(t@1(PI\vx(iF@(I+(RF@@:(`\b+`()\b(I+(F\b\002J:(x}D\v+\002Jh"),
      Media = IMG_UhrZoom
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(INP_Uhrzeit)
    end)
  end)
end
function ITM_Anhaenger:On_GpSaB(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(xID+`(1I@(\027@JFI@DIW(\v@(1\vI(\022W\bJI(Y\bW\bI\002Rh(\aW(+FJ(IJ(@\v\002J`(/I+}@1IW+(PIW`w}xx(F\b+h(Z\028\b`(DIiF\002J`Z(J}IW+`()\b(1\vI(9\vWF`I@(W\b\tI@h(Z I`Y`(1FW\t+`()\b(IW@I\b`(PFIJxI@hZ"),
    Callback = function(action)
      if action ~= nil then
        V_SchatzStatus = 0
        ITM_Anhaenger:MoveTo(nil)
        ITM_Anhaenger.Commands._GpSaB.Enabled = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Schild:On_xGC(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(INP_NachtEnde)
  end)
end
function ITM_WegweiserCode:On_pK4(target)
  if Z_Wegweiser:Contains(Player) then
    if Z_Wegweiser:Contains(_aRYZ3) then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5("#JJJ:(1F+(+\v`Y`(LF(I\v@I(\tI``I(\003y\v@@I(F\b\t(1Ii(mIDPI\v+IWh()\vI(+\vIJ`(DI\tFIJWx\v\002J(F\b+h(?/(1\vI(\b@+(P}Jx(\v@(\\\bJI(1\vI(\014\b\002J+`F/I@(+\b\002JI@(xFI++`S"),
          Media = IMG_SpinneR1
        },
        {
          Text = _yhK5("8I\v@(xFI++`(+\vI(@\v\002J`h(8IRWFi}WF(JF`(i\v\002J(J\vIWJIW(DI+\002J\v\002R`:(1Fi\v`(\v\002J(\a\b\002J(Y\bi(\022I\b\tIx(LFDI:(\tFxx+(#JW(\a\b\002J(J\vIWJIW(PFD`h(t@1(1F+(PIW1I(\v\002J(LI`Y`(F\b\002J(`\b@h\020\014\\6\020\014\\6t@1(@\bW(1Fi\v`()\b(I+(PI\v++`:(\v\002J(/\v@(wIW1Fii`(D\v\t`\vDh()F+(RF@@(\v\002J()\vW(+}DFW(+\002JW\v\t`x\v\002J(DI/I@h(s\vIW(/\v``Ih"),
          Media = IMG_SpinneS1
        },
        {
          Text = _yhK5(")\vI(\003y\v@@I(WI\v\002J`(1Ii(\\FI/I@(\vJWI({\v+`I@RFW`I:(1IW(x\vI+`(1\vI(\127FW`I(\b@1(+`I\002R`(+\vI(I\v@\vDIWiF++I@(\b@/II\v@1W\b\002R`(I\v@h"),
          Media = IMG_SpinneR1a
        },
        {
          Text = _yhK5("?\002J(iI@@}h(#\002J(JF/(LI`Y`(I\002J`(1\vI(8F+I(w}xx(w}@(1\vI+IW(/x}I1I@(8IRWF1\v@D+1Fh( I`Y`(J}IW(D\b`(Y\b(\003y\v@@Ih(#\002J(+FD()\vW(iFx(PF+:(F/IW(@\bW(I\v@iFxB("),
          Media = IMG_SpinneR1
        },
        {
          Text = _yhK5("#\002J(J}IWIh"),
          Media = IMG_SpinneS1
        }
      }, function(action)
        ITM_CoCaSpinne:MoveTo(Player)
        if V_EasyMode == 0 then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(INP_Spinne1)
          end)
        else
          _Urwigo.Dialog(false, {
            {
              Text = _yhK5("#\002J(/\v@(I\v@(mFWi1\b+\002JIW(\b@1()\b(1FW\t+`(i\v\002J(@\v\002J`(i\v`(PI\v`IWI@(+\v@@x}+I@(\027\b\tDF/I@(/IxFI+`\vDI@h"),
              Media = IMG_SpinneR2
            },
            {
              Text = _yhK5("\027x+(}/(i\v\002J(1F+(\v@`IWI++\vIWI@(i\bI++`Ih(\027/IW(hhh(JFx`(iFx(hhh(/\v+`()\b(I`PF(1IW(+\002JPFWYI(9\vWF`S(sF+`()\b(I\v@()WF\002JI@\tI\bIW(1F/I\vS"),
              Media = IMG_SpinneS2
            },
            {
              Text = _yhK5(")\b(+yW\v\002J+`(w}@(iI\v@IW(]F`IW@IS"),
              Media = IMG_SpinneR3
            },
            {
              Text = _yhK5("{IW1Fii`h()Fi\v`(P\vxx(\v\002J(@\v\002J`+(Y\b(`\b@(JF/I@h(#\002J(i\b++(DIJI@h"),
              Media = IMG_SpinneS3
            },
            {
              Text = _yhK5(")F@@(RF@@(\v\002J(i\v\002J(LF(LI`Y`(\bi(1I@([I``Ix(R\bIiiIW@h()FWF\b\t(\v+`(I\v@I(\003R\vYYI(1I+(mIDPI\v+IW+(Y\b(+IJI@h(t@1(1F@@(+`IJ`(1F(@}\002J(Fx+(\aWRxFIW\b@DB()IW(\001}1I(\027,!0(/I1I\b`I`:(\v\002J(/WF\b\002JI(w}i(\014WI``\002JI@(\027(F\b+([I\vxI(,(1I@(0h(\014\b\002J+`F/I@h"),
              Media = IMG_SpinneR4
            }
          }, function(action)
            _aRYZ3:MoveTo(nil)
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(INP_Wegweiser)
            end)
          end)
        end
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(")\b(+\002JF\b+`()\vW(1I@([I``Ix(F@h()FWF\b\t(\v+`(I\v@I(\003R\vYYI(1I+(mIDPI\v+IW+(Y\b(+IJI@h(t@1(1F@@(+`IJ`(1F(@}\002J(Fx+(\aWRxFIW\b@DB()IW(\001}1I(\027,!0(/I1I\b`I`:(\v\002J(/WF\b\002JI(w}i(\014WI``\002JI@(\027(F\b+([I\vxI(,(1I@(0h(\014\b\002J+`F/I@h(\a+(YFIJxI@(F/IW(@\bW(1\vI([I\vxI@(i\v`(1IW(DW}?I@(PI\v++I@(\003\002JW\v\t`:(@\v\002J`(1F+(RxI\v@I(\028IRW\bIiIx(1W\bI/IW(\b@1(1W\b@`IWh(\027,!0(PFIWI(Fx+}(I\v@(ZYZh"),
          Media = IMG_Wegweiser
        }
      }, function(action)
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(INP_Wegweiser)
        end)
      end)
    end
  else
    _Urwigo.MessageBox({
      Text = _yhK5("8\v\002J`(J\vIWh"),
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function ITM_DevTool:OnBTN_Dbg_Startpunkt(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(INP_DbgStartpunkt)
  end)
end
function ITM_DevTool:OnBTN_DevToolFlags(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_F7OU)
  end)
end
function ITM_Schild2:OnBTN_Sch2Untersuchen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\027\b\t(1Ii(\003\002J\vx1(+`IJ`(DI+\002JW\vI/I@B(Z\014\v@(wIWWI\v+`(Y\b(1I@(9UWFi\v1I@\nZ"),
      Media = IMG_Ora3
    },
    {
      Text = _yhK5("#@(1IW(s}\t\t@\b@D:(@}\002J(I`PF+(iIJW(#@\t}WiF`\v}@I@(Y\b(\t\v@1I@:(+\002JF\b`(1IW(\\FI/I(F\b\002J(@}\002J(F\b\t(1\vI(\\\bI\002R+I\v`I(1I+([I``Ix+h(]I\v1IW(/I\t\v@1I`(+\v\002J(1}W`(@\bW(?WFRIxPIW/\b@Dh(?\t\tI@/FW(JF`(1F+(?WFRIx(I\v@I@(Fx`I@(lxUIW(/I@\b`Y`:(\bi(1\vI(8}`\vY(F\b\tY\b+\002JWI\v/I@h()}W`(+`IJ`(@FIix\v\002JB"),
      Media = IMG_Ora6
    },
    {
      Text = _yhK5("mI\vJ@F\002J`I@(+`IJ`(w}W(1IW(\022\bIW(\b@1(#J@I@(\tIJx`(@}\002J(1F+(yF++I@1I(\028I+\002JI@RS\020\014\\6\020\014\\6\127I\v@(9W}/xIih(\014I+\b\002JI@(\003\vI(1\vI(?WFRIxJ}IJxI(\b@1(IW\tFJWI@(\003\vI(w}@(\b@+IWIi(R}iyI`I@`I@(?WFRIx`IFi:(PF+(1F+(}y`\viFxI(\028I+\002JI@R(\t\bIW(#JWI(lWI\b@1I(\b@1({IWPF@1`I@(\v+`h\020\014\\6\020\014\\6?I\t\t@\b@D+YI\v`I@B(\viiIW(PI@@(\003\002J@II(x\vID`h"),
      Media = IMG_Ora7
    },
    {
      Text = _yhK5("\003\v@@x}+h(mIW/\b@D(\t\bW(mI\vJ@F\002J`+DI+\002JI@RI:(F/IW(@\v\002J`+(w}@(9UWFi\v1I@h"),
      Media = IMG_Ora6
    },
    {
      Text = _yhK5("m}/I\v:(+}(I\v@(yIW\tIR`(yF++I@1I+(mI\vJ@F\002J`+DI+\002JI@R(\v+`(+\002J}@(RI\v@I(+\002JxI\002J`I(\003F\002JIh"),
      Media = IMG_Spieler
    },
    {
      Text = _yhK5("sIU:(\v\002J(P\vxx(9\vWF`(PIW1I@:(@\v\002J`(mI\vJ@F\002J`+iF@@h(\027/IW(F/DIiF\002J`h(lFxx+(\b@+(\vWDI@1PF@@(iFx(I\v@I(\003\002J@II\tx}\002RI(\bI/IW(1I@(mID(xFI\b\t`:(R}iiI@(P\vW(@}\002J(iFx(JIWh(\027/IW(\t\bIW(1I@(o}iI@`(+\b\002JI@(P\vW(9UWFi\v1I@h"),
      Media = IMG_Ora4
    },
    {
      Text = _yhK5(" F:(LF:(LI`Y`(9UWFi\v1I@h(\027/IW(1F+(i\v`(1Ii(\003\002J@II(+}xx`I@(P\vW(\b@+(1F+(D\b`(iIWRI@(hhh"),
      Media = IMG_Spieler
    }
  }, function(action)
    V_FlyerGelesen = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function ITM_Geschenk:OnITM_Auspacken(target)
  local _Urwigo_Date = os.date("*t")
  V_TempInt = _Urwigo_Date.day + _Urwigo_Date.month * 100
  if V_TempInt == 1224 or V_TempInt == 1225 or V_TempInt == 1226 or V_HeuteIstWeihnachten == true then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")F(JF/I@(P\vW(F/IW(P\vWRx\v\002J(\028x\bI\002R:(1F++(DIWF1I(mI\vJ@F\002J`I@(\v+`h"),
        Media = IMG_Geschenk1
      }
    }, function(action)
      if Player:Contains(ITM_CoCaOra) then
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5(")IW(\\FI/I(+yW\v@D`(F\b\t(1I@(\127FW`}@(\b@1(WI\v++`(1\vI({IWyF\002R\b@D(F\b\t(hhh"),
            Media = IMG_Weih01
          },
          {
            Text = _yhK5("hhh(1IW(\127FW`}@(/ID\v@@`(Y\b(PF@RI@(\b@1(R\vyy`(+\002Jx\vI++x\v\002J(\bih(\a\v@(]I/R\b\002JI@\tx\b++(/FJ@`(+\v\002J(+I\v@I@(mID(@F\002J(1WF\b++I@h"),
            Media = IMG_Weih02
          },
          {
            Text = _yhK5("\a+(\t}xDI@(9xFI`Y\002JI@(\bI/IW(9xFI`Y\002JI@:(PI\v`(iIJW(Fx+(LIiFx+(\v@(1I@(\127FW`}@(JFI``I@(J\v@I\v@(yF++I@(R}I@@@I@h()IW(\\FI/I(\v+`(/IDI\v+`IW`h"),
            Media = IMG_Weih03
          },
          {
            Text = _yhK5("#WDI@1PF@@:(Fx+(1F+([\viiIW(+\002J}@(Y\bW(sFIx\t`I(i\v`(9xFI`Y\002JI@(DI\tx\b`I`(\v+`:(R}ii`(}/I@(F\b\t(1Ii(\003`W}i(I\v@I(\127FW`I(1FJIWDI+\002JP}iiI@h"),
            Media = IMG_Weih04
          },
          {
            Text = _yhK5("\028W\bI++I(w}@(\ai\vx\v}(\b@1(I\v@(DF@YI+([\viiIW(w}xxIW(9xFI`Y\002JI@h(lW}JI(mI\vJ@F\002J`I@\n()\vI(\127FW`I(+`I\002R`(1IW(\\FI/I(DxI\v\002J(iFx(\v@(+I\v@I@(\\\b\002R+F\002R:(F\b\002J(PI@@(IW(1F\t\bIW(`F\b\002JI@(i\b++(\vi(9xFI`Y\002JI@iIIWh"),
            Media = IMG_Weih05
          }
        }, function(action)
          ITM_Weihnachtskarte:MoveTo(Player)
          ITM_Geschenk:MoveTo(nil)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      else
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5("\014Iw}W()\b(FxxI+(F\b\tWI\v++`:(+\002JF\b(IW+`(iFx(1F(F@(1IW(\003I\v`Ih()F(+`I\002R`(@}\002J(I\v@([I``Ix(1WF@h"),
            Media = IMG_Geschenk2
          },
          {
            Text = _yhK5("\001}}x:(1\vI({\v+\v`I@RFW`I(w}i(?WFRIxh"),
            Media = IMG_Geschenk3
          },
          {
            Text = _yhK5(")F@@(+yW\v@D`(1IW(\\FI/I(F\b\t(1I@(\127FW`}@(\b@1(WI\v++`(1\vI({IWyF\002R\b@D(F\b\t(hhh"),
            Media = IMG_Weih01
          },
          {
            Text = _yhK5("hhh(1IW(\127FW`}@(/ID\v@@`(Y\b(PF@RI@(\b@1(R\vyy`(+\002Jx\vI++x\v\002J(\bih(\a\v@(]I/R\b\002JI@\tx\b++(/FJ@`(+\v\002J(+I\v@I@(mID(@F\002J(1WF\b++I@h"),
            Media = IMG_Weih02
          },
          {
            Text = _yhK5("\a+(\t}xDI@(9xFI`Y\002JI@(\bI/IW(9xFI`Y\002JI@:(PI\v`(iIJW(Fx+(LIiFx+(\v@(1I@(\127FW`}@(JFI``I@(J\v@I\v@(yF++I@(R}I@@@I@h()IW(\\FI/I(\v+`(/IDI\v+`IW`h"),
            Media = IMG_Weih03
          },
          {
            Text = _yhK5("#WDI@1PF@@:(Fx+(1F+([\viiIW(+\002J}@(Y\bW(sFIx\t`I(i\v`(9xFI`Y\002JI@(DI\tx\b`I`(\v+`:(R}ii`(}/I@(F\b\t(1Ii(\003`W}i(I\v@I(\127FW`I(1FJIWDI+\002JP}iiI@h"),
            Media = IMG_Weih04
          },
          {
            Text = _yhK5("\028W\bI++I(w}@(\ai\vx\v}(\b@1(I\v@(DF@YI+([\viiIW(w}xxIW(9xFI`Y\002JI@h(lW}JI(mI\vJ@F\002J`I@\n()\vI(\127FW`I(+`I\002R`(1IW(\\FI/I(DxI\v\002J(iFx(\v@(+I\v@I@(\\\b\002R+F\002R:(F\b\002J(PI@@(IW(1F\t\bIW(`F\b\002JI@(i\b++(\vi(9xFI`Y\002JI@iIIWh"),
            Media = IMG_Weih05
          }
        }, function(action)
          ITM_CoCaOra:MoveTo(Player)
          ITM_Weihnachtskarte:MoveTo(Player)
          ITM_Geschenk:MoveTo(nil)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("sIU(\\FI/I:(PF+(iF\002J+`()\b(1FS(sI\b`I(\v+`(@\v\002J`(mI\vJ@F\002J`I@\n"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("?\002J(oI@@}h"),
        Media = IMG_Geschenk1
      },
      {
        Text = _yhK5(")\b(P\vW+`(1}\002J(1F+(yIW\tIR`I(\028I+\002JI@R(@\v\002J`(Fi(\tFx+\002JI@(\022FD(}I\t\t@I@(P}xxI@h"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("m}JIW(+}xx(\v\002J(P\v++I@:(}/(I+(yIW\tIR`(\v+`:(PI@@(\v\002J(I+(@\v\002J`(F\b\tiF\002JI@(1FW\tS"),
        Media = IMG_Geschenk1
      }
    }, function(action)
      if Player:Contains(ITM_CoCaOra) then
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5("9IW\tIR`(}1IW(@\bW(JFx/(yIW\tIR`:(+y\vIx`(RI\v@I(\\}xxI:(mI\vJ@F\002J`I@(\v+`(JI\b`I(LI1I@\tFxx+(@\v\002J`h"),
            Media = IMG_Spieler
          }
        }, function(action)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      else
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5("9IW\tIR`(}1IW(@\bW(JFx/(yIW\tIR`:(+y\vIx`(RI\v@I(\\}xxI:(mI\vJ@F\002J`I@(\v+`(JI\b`I(LI1I@\tFxx+(@\v\002J`h(\027/IW(+\002JF\b(iFx:(1F(F@(1IW(\003I\v`I(+`I\002R`(@}\002J(I\v@([I``Ix(1WF@h"),
            Media = IMG_Geschenk2
          },
          {
            Text = _yhK5("\001}}x:(1\vI({\v+\v`I@RFW`I(w}i(?WFRIxh(8F(PI@\vD+`I@+(PF+h"),
            Media = IMG_Geschenk3
          }
        }, function(action)
          ITM_CoCaOra:MoveTo(Player)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      end
    end)
  end
end
function ITM_CoCaOra:OnBTN_CoCaOra(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(1WIJ+`(1\vI(\127FW`I(\bi(\b@1(+\vIJ+`(F\b\t(1IW(\\\bI\002R+I\v`I(1I@(\t}xDI@1I@(\001}1IB(") .. GetTransferCode("Emilo", 5),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_Weihnachtskarte:OnBTM_WeihKaLesen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")F(\v+`(I\v@(\014\vx1(w}@(\ai\vx\v}(\v@(mI\vJ@F\002J+wIWRxI\v1\b@D(1WF\b\th()FW\b@`IW(+`IJ`(ZlW}JI(mI\vJ@F\002J`I@Zh"),
      Media = IMG_Weih05
    },
    {
      Text = _yhK5(")\vI(\\\bI\002R+I\v`I(+\002JI\v@`(\ai\vx\v}(/I@\b`Y`(Y\b(JF/I@:(Fx+(IW(iFx(Z\003\002J\v\t\tI(wIW+I@RI@Z(DI+y\vIx`(JF`h"),
      Media = IMG_Weih06
    },
    {
      Text = _yhK5("Z#@(PIx\002JIi(t@\vwIW+\bi(\v+`(1I@@(+}(I\v@I(\027@}W1@\b@D(w}@(\003\002J\v\t\tI@(IWxF\b/`SZ(1I@R`(+\v\002J(1IW(\\FI/I(\b@1(yF\002R`(1\vI(\127FW`I(P\vI1IW(PIDh"),
      Media = IMG_Weih07
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function ITM_CoCaBib:OnBTN_CoCaBib(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(1WIJ+`(1\vI(\127FW`I(\bi(\b@1(+\vIJ+`(F\b\t(1IW(\\\bI\002R+I\v`I(1I@(\t}xDI@1I@(\001}1IB(") .. GetTransferCode("Bibli", 5),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_CoCaBib:OnBTN_CoCaBibNehmen(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")IW(\\F/I(`F+`I`(+\v\002J(1\bW\002J(1\vI()\b@RIxJI\v`(\b@1(P\vW1(\b@`IWJFx/(1I+(\003`I\v@JF\b\tI@+(`F`+FI\002Jx\v\002J(\t\bI@1\vDh"),
      Media = IMG_EinsiedelB10
    },
    {
      Text = _yhK5(")F+(\v+`(1}\002J(`F`+FI\002Jx\v\002J(1\vI({\v+`\v`I@RFW`I(iI\v@I+(]\vI/x\v@D+/x\v/x\v}`JIRFW+h(8F(1\vI(@IJi(\v\002J(1}\002J(DxI\v\002J(iFx(i\v`h"),
      Media = IMG_EinsiedelB11
    }
  }, function(action)
    ITM_CoCaBib:MoveTo(Player)
    Z_Einsiedelei.Active = false
    ITM_CoCaBib.Commands.BTN_CoCaBib.Enabled = true
    ITM_CoCaBib.Commands.BTN_CoCaBibNehmen.Enabled = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function ITM_CoCaSpinne:OnBTN_CoCaSpinne(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(1WIJ+`(1\vI(\127FW`I(\bi(\b@1(+\vIJ+`(F\b\t(1IW(\\\bI\002R+I\v`I(1I@(\t}xDI@1I@(\001}1IB(") .. GetTransferCode("Spine", 5),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_CoCaPiraten:OnBTN_CoCaPiraten(target)
  _Urwigo.MessageBox({
    Text = _yhK5(")\b(1WIJ+`(1\vI(\127FW`I(\bi(\b@1(+\vIJ+`(F\b\t(1IW(\\\bI\002R+I\v`I(1I@(\t}xDI@1I@(\001}1IB(") .. GetTransferCode("Pirat", 5),
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function ITM_CoCaFM:OnBTN_CoCaFM(target)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(1WIJ+`(1\vI(\127FW`I(\bi(\b@1(+\vIJ+`(F\b\t(1IW(\\\bI\002R+I\v`I(1I@(\t}xDI@1I@(\001}1IB(") .. GetTransferCode("Flema", 5)
    },
    {
      Text = _yhK5(")FW\b@`IW(+`IJ`(@}\002J(I\v@(PI\v`IWIW(\001}1Ih()F/I\v(JF@1Ix`(I+(+\v\002J(\bi(1I@(t@x}\002R!\001}1I:(1I@(1\vI(lxI1IWiF\b+()\vW(F\b\tDI+\002JW\vI/I@(JF`h()\vI+I@(\001}1I(/I@}I`\vD+`()\b:(\tFxx+()\b(1\vWIR`(F\b\t(1IW()}P@x}F1!\003I\v`I(1I+(\001FW`W\v1DI+(I\v@I@(\a\v@`WFD(iF\002JI@(i}I\002J`I+`h()IW(t@x}\002R!\001}1I(xF\b`I`B(") .. string.sub(Player.CompletionCode, 1, 15)
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_HuegelVerlassen()
  P_Raebe.Commands._YWV.Enabled = false
  if Z_Holzzelt.Active == false then
    P_Raebe:MoveTo(Z_Bergauf30)
  else
    P_Raebe:MoveTo(Player)
  end
end
function FCT_AusweisGeben()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(YI\vD+`(1Ii(\014\v/x\v}`JIRFW(1F+(l}`}:(1F+()\b(F\b\t(1Ii(s\bIDIx(w}i(\\FI/I@(DIiF\002J`(JF+`h(Zs\vIW(DIJ`(1F+SZ"),
      Media = IMG_BA3D2
    },
    {
      Text = _yhK5("Z F:(1F+(DIJ`hZ(F@`P}W`I`(1IW(\014\v/x\v}`JIRFW:(+\002J@Fyy`(+\v\002J(1F+(sF@1U(\b@1(wIW+\002JP\v@1I`(1Fi\v`(R\bWY(\vi(J\v@`IWI@(\022I\vx(1I+(s}xYYIx`I+h(\a+(/x\v`Y`(R\bWY(I`PF+(F\b\t:(1F@@(y\tI\v\t`(\b@1(RxFyyIW`(I+(\b@1(+\002J}@(+`IJ`(1IW(\014\v/x\v}`JIRFW(P\vI1IW(w}W()\vW:(D\v/`()\vW(1F+(sF@1U(Y\bW\bI\002R(\b@1(JFIx`(1I@(\tIW`\vDI@(\027\b+PI\v+(\v@(+I\v@IW(sF@1h\020\014\\6lWFD(/\v``I(@\v\002J`:(PF+(IW(DI@F\b(DI`F@(JF`:(1F+(PI\v++(@\bW(IWh"),
      Media = IMG_Bibliothekar
    },
    {
      Text = _yhK5("s\vIW(\v+`()I\v@(\014\v/x\v}`JIR+!\027\b+PI\v+h(mF@@(\viiIW()\b(I\v@(D\b`I+(\014\b\002J(/WF\b\002J+`:(/I@\b`Y(\vJ@(I\v@\tF\002J(\b@1(\v\002J(/\v@(Y\bW(\003`IxxIh\020\014\\6 I`Y`(i\b++(\v\002J(i\v\002J(F/IW(IW+`(iFx(+y\b`I@h(\022IWi\v@I:(\022IWi\v@Ih(\027xxI+(\v+`(\v@({IWY\bDh(oF\002J\024+(D\b`h(m\vW(+IJI@(\b@+(/I+`\vii`(/Fx1(P\vI1IWh"),
      Media = IMG_BA3D3
    },
    {
      Text = _yhK5(")F@RIh(o\v`(1Ii(\022W}xx(JF/I(\v\002J(LF(LI`Y`(F\b\002J(1F+(yF++I@1I(mIWRYI\bD:(\bi()I\v@I(\014\bI\002JIW(\v@(]I+IDW}I++I(Y\b(PF@1Ix@h(mIW(JFI``I(1F+(DI1F\002J`h()IW(\022W}xx(\v+`(1IW(\003\002Jx\bI++Ix(Y\bi(m\v++I@(1\vI+IW(mIx`h()FWF\b\t(I\v@(Z[}xx(/IYFJxI@Z\n\020\014\\6\027x+}(iF\002J\024+(D\b`h(m\vW(JF/I@(F\b\002J(@}\002J([I\bD(Y\b(IWxI1\vDI@h"),
      Media = IMG_Raebe01
    }
  }, function(action)
    P_Bibliothekar:MoveTo(Z_Local_Bib)
    Z_Local_Bib.Active = true
    T_Foto.Complete = true
    ITM_Foto:MoveTo(nil)
    ITM_Foto.Commands._70V.Enabled = false
    ITM_BibAusweis:MoveTo(Player)
    V_BibStatus = 30
    Z_Holzzelt.Active = false
    Z_Bergauf40.Active = true
    P_Raebe:MoveTo(Z_Bergauf40)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_Lager()
  if V_FMausStatus < 10 then
    _Urwigo.MessageBox({
      Text = _yhK5(")IW(\\FI/I(PI@1I`(+\v\002J()\vW(Y\b(\b@1(+FD`B(Zm\vW(+}xx`I@(iFx(wIW+\b\002JI@:(1\vI(lxI1IWiF\b+(Y\b(\t\v@1I@h(#\002J(+IJI(+\vI(@\v\002J`(J\v@`IW(1IW(\014FWW\vIWIh(\003\vI(i\b++(\vWDI@1P}(DF@Y(\v@(1IW(8FIJI(F\b++IWJFx/(1IW(\014FWW\vIWI(+I\v@h"),
      Media = IMG_Raebe01
    })
  elseif P_Skelett.Commands._XujO.Enabled == true then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("t@`IW(Fxx(1I@(\003RIxI``I@:(1\vI(1\vI(\014FWW\vIWI(/IPF\002JI@:(\tFIxx`()\vW(I\v@I+(/I+}@1IW+(F\b\th(\a+(+`I\002R`(@\v\002J`(\vi(\014}1I@:(+}@1IW@(xFI\b\t`(Fi(\\F@1I(1IW(\014FWW\vIWI(I@`xF@Dh()F/I\v(wIWx\vIW`(I+(F/(\b@1(Y\b(iFx(I\v@I@(\127@}\002JI@:(JI/`(\vJ@(F/IW(+}\t}W`(P\vI1IW(F\b\th(r@/+yO\028F@Y(+\002J}I@(RxFyyW\vD:(1\vI+I+(\003RIxI``h"),
        Media = IMG_Skelett3
      }
    }, function(action)
      TMR_SkelettDrinnen:Start()
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")F+(RxFyyW\vDI(\003RIxI``(xFI\b\t`(@}\002J(\viiIW(J\v@(\b@1(JIW:(F/IW(1IW(\aW+F`YR@}\002JI@(+\002JI\v@`(w\vIx(/I++IW(Y\b(yF++I@(Fx+(1F+(?W\vD\v@Fxh( I1I@\tFxx+(\tFIxx`(IW(@\v\002J`(iIJW(+`FI@1\vD(Y\b(\014}1I@h(8F(PI@@(1F+(RI\v@I(D\b`I(\022F`(PFW:(1\vI()\b(1F(w}xx/WF\002J`(JF+`\n"),
        Media = IMG_Skelett3
      }
    }, function(action)
      TMR_SkelettDrinnen:Start()
    end)
  end
end
function FCT_NachtmodusAn()
  Z_Nekramora.Active = false
  Z_Tisch.Active = false
  V_BakFMZoneAktiv = Z_Local_FMaus.Active
  Z_Local_FMaus.Active = false
  P_Piraten:MoveTo(nil)
  Z_Mitternacht.Active = true
  ITM_Uhr.Commands._f6Q40.Enabled = false
  if V_NachtStatus < 5 then
    V_NachtStatus = 5
  end
end
function FCT_NachtmodusAus()
  Z_Nekramora.Active = true
  Z_Tisch.Active = true
  Z_Local_FMaus.Active = V_BakFMZoneAktiv
  P_Piraten:MoveTo(Z_Innenhof)
  Z_Mitternacht.Active = false
  ITM_Uhr.Commands._f6Q40.Enabled = true
  Z_Tafel.Active = false
  Z_Einsiedelei.Active = false
  if V_SchmiedStatus < 20 then
    V_NachtStatus = 0
  elseif V_NachtStatus < 100 then
    V_NachtStatus = 100
  end
end
function FCT_DokumentLesen()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("Z F:(i\v`(1I@(\014\b\002J+`F/I@(RF@@(\v\002J(LI`Y`(F\b\002J(1I@(\\I+`(I@`Y\v\t\tIW@hZ(\ai\vx\v}+(sFI@1I(RWI\v+I@(IW@I\b`(\bI/IW(1IW(\127\bDIx(\b@1(IW(/ID\v@@`(P\vI1IW(Y\b(xI+I@h"),
      Media = IMG_Emilio9
    },
    {
      Text = _yhK5("hhh()}\002J(F\b\002J(\vJWI(sIWW+\002JF\t`(P\vW1(@\v\002J`(IP\vD(1F\bIW@h(\a\v@(+\002JPFWYIW(9\vWF`(P\vW1(R}iiI@h(\aW(P\vW1(1F+({IW`WF\bI@(I\v@I+(w}@(8IRWFi}WF+(\003\002JIWDI@(IWxF@DI@h(o\v`(1I++I@(s\vx\tI(P\vW1(I+(\vJi(DIx\v@DI@:(+}P}Jx(w}@(\vJWI@(\003RIxI``I@(Fx+(F\b\002J(w}@(8IRWFi}WF(+Ix/+`(I\v@(RxI\v@I+(\022I\vx(Y\b(+`IJxI@(\b@1(/I\v1I+(DIiI\v@+Fi(\v@(I\v@Ii(iFI\002J`\vDI@()WF\002JI@\tI\bIW(Y\b(wIW/WI@@I@h()Fi\v`(P\vW1(1F+(\a@1I(w}@(8IRWFi}WF(/I+\vIDIx`(+I\v@h(hhh"),
      Media = IMG_Emilio8
    }
  }, function(action)
    V_FMausStatus = 30
    V_StoryLine = 260
    T_Kopftuch.Complete = true
    T_Nekramora.Active = true
    T_Skelett.Active = true
    T_Feuer.Active = true
    T_Uebersetzung.Complete = true
    ITM_WegweiserCode:MoveTo(nil)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_NachtStartGespraech()
  if V_NachtStatus < 10 then
    TMR_NachtAus:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("]F@D+Fi(JF+`()\b(1\vI(\003`IxxI(F\b+DIiF\002J`:(w}@(1IW(1\vI(\028IWFI\b+\002JI(R}iiI@h(\a\v@(\028I\v+`(i\v`(Dx\bIJI@1Ii(\127}y\t(`F\b\002J`(1\vWIR`(w}W()\vW(F\b\t(\b@1(+FD`B(Z\014\bJhZ"),
        Media = IMG_Goldschmied00
      },
      {
        Text = _yhK5("\028\b`I@(\022FD:(sIWW(\028I\v+`h(o\b++(\v\002J(i\v\002J(LI`Y`(DW\b+Ix@S"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("\028F@Y(P\vI()\b(i}I\002J`I+`h(o\vW(\v+`(1F+(\vi(\028W\b@1I(IDFxh(#\002J(i\b++(I\v@\tF\002J(Y\b(FxxI@(Z\014\bJZ(+FDI@:(1\vI(i\v`(\bI/IW(1I@(mID(xF\b\tI@:(+}@+`(RW\vIDI(\v\002J(\027IWDIW(i\v`(8IRWFi}WFh([\bi(\028x\bI\002R(/IDID@I@(i\vW(J\vIW(@\v\002J`(}\t`(]I\b`I(\bi(1\vI+I(tJWYI\v`h"),
        Media = IMG_Goldschmied02
      },
      {
        Text = _yhK5("t@1(PFW\bi(i\b++`()\b(J\vIW(]I\b`I(IW+\002JWI\002RI@S"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("#\002J(PFW(I\v@+`(I\v@(/IW\bIJi`IW(\028}x1+\002Ji\vI1h(\a\v@I+(\022FDI+(RFi(I\v@I(lWF\b(/I\v(i\vW(w}W/I\v(\b@1(/I+`Ixx`I(I\v@(\027i\bxI``h(\003\vI(DF/(i\vW(I\v@I@(/x\b`W}`(\t\b@RIx@1I@(\a1Ix+`I\v@:(1I@(\v\002J(I\v@FW/I\v`I@(+}xx`I(\b@1(+}(`F`(\v\002J(F\b\002Jh([PI\v(m}\002JI@(+yFI`IW(J}x`I(+\vI(I+(F/h(#@(1Ii(\027\bDI@/x\v\002R:(\v@(1Ii(\v\002J(I+(\vJW(\bI/IWDF/:(wIW+\002JPF@1(iI\v@(\127}IWyIW(\b@1(iI\v@(\127}y\t(/IDF@@(Y\b(Dx\bIJI@h(\003I\v`1Ii(JF`(+\vI(1\vI(\127}@`W}xxI(\bI/IW(i\v\002Jh(\014\bJh"),
        Media = IMG_Goldschmied02
      }
    }, function(action)
      P_Goldschmied:MoveTo(Z_Mitternacht)
      V_NachtStatus = 10
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function FCT_Schmieden()
  if P_Goldschmied:Contains(ITM_Ringe) and P_Goldschmied:Contains(ITM_Anhaenger) then
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("#\002J(1F+(LI`Y`(DI@\bD(oF`IW\vFxS"),
        Media = IMG_Goldschmied03
      },
      {
        Text = _yhK5("8\b@(LF:(9WI\v+I(PIW1I(\v\002J(i\v`(1Ii(\aWDI/@\v+(+\v\002JIW(RI\v@I(DIP\v@@I@:(F/IW(iF@(i\b++(1Ii(\027i\bxI``(LF(F\b\002J(@\v\002J`(\b@/I1\v@D`(F@+IJI@:(PIx\002JI(oF\002J`(\v\002J(\v@(I+(J\v@I\v@(+\002Ji\vI1Ih\020\014\\6\020\014\\6#\002J(xID(iFx(x}+h(\027\b+(1I@(\028\bii\v@\byy+\vI+(iF\002JI@(P\vW(I\v@(\127I``\002JI@:(w}W@I(R}ii`(1IW(\027@JF@DIW(1WF@:(1F+(DF@YI(DIP\bIWY`(i\v`(}W1I@`x\v\002J(oFD\vI(\b@1(hhh(\003\002JP\byy1\vP\byy(hhh(I\v@(\027i\bxI``h(\014\v``I(+\002J}I@:(FIJ(@I\v@h(\014\bJh"),
        Media = IMG_Goldschmied04
      },
      {
        Text = _yhK5("sF/(w\vIxI@()F@R:(x\vI/IW(sIWW(\028}x1+\002Ji\vI1h( I`Y`(/\v@(\v\002J(/Fx1(9\vWF`:( \b\002JJ\bh"),
        Media = IMG_Goldschmied05
      }
    }, function(action)
      V_SchmiedStatus = 20
      ITM_Amulett:MoveTo(Player)
      T_Amulett.Complete = true
      T_Zeitsprung.Active = true
      ITM_Amulett.Commands._qFJH.Enabled = true
      P_Goldschmied.Commands._mZXP.Enabled = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function FCT_HellsehenAn()
  if Player:Contains(ITM_BuntesTuch) and Player:Contains(ITM_Amulett) then
    if Z_Tisch:Contains(P_Fledermaus) then
      if V_KugelStatus < 10 then
        _Urwigo.Dialog(false, {
          {
            Text = _yhK5(")F(JF+`()\b(LF(\v@YP\v+\002JI@(I\v@I(oI@DI([I\bD(Y\b+FiiI@DI+FiiIx`h(\003\002J}@(I\v@I(#1II:(PF+(P\vW(Fx+(\127W\v+`FxxR\bDIx(/I@\b`YI@(P}xxI@S"),
            Media = IMG_Emilio3
          },
          {
            Text = _yhK5("\014I\v(1I@(]}xx\v+(+\v@1(I\v@(yFFW(1F/I\v:(1\vI(+IJI@(P\vWRx\v\002J(F\b+(P\vI(I\v@I(\127W\v+`FxxR\bDIx(Fi(\003`\vIxh(#\002J(DxF\b/I:(1\vI(R}I@@`I@(P\vW(Fx+(\aW+F`YR\bDIx(wIWPI@1I@h"),
            Media = IMG_Emilio2
          }
        }, function(action)
          T_Kristallkugel.Complete = true
          V_KugelStatus = 10
          FCT_HellsehenAn2()
        end)
      else
        FCT_HellsehenAn2()
      end
    elseif 10 > V_FMausStatus then
      _Urwigo.Dialog(false, {
        {
          Text = _yhK5(" I`Y`(/WF\b\002JI@(P\vW(@\bW(@}\002J(+}(I\v@(\022\vIW\002JI@h({IW+\b\002J(Fi(/I+`I@(1\vI(lxI1IWiF\b+(Y\b(\t\v@1I@h(ti(1\vI([I\v`(iF\002J`(+\vI(iI\v+`I@+(I\v@(8\v\002RIW\002JI@(F@(1Ii(\003`I\v@JF\b\tI@(1\vWIR`(@I/I@(1Ii(]FDIW(1IW(t@`}`I@h"),
          Media = IMG_Emilio3
        }
      }, function(action)
        _srCZ:Start()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end
  else
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function FCT_HellsehenAn2()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\003\vIJ`(+}(F\b+:(Fx+(JFI``I+`()\b(FxxI+(Y\b+FiiI@h"),
      Media = IMG_Emilio0
    },
    {
      Text = _yhK5("#\002J(1I@RI(+\002J}@h(#\002J(JF/I(I\v@(/\b@`I+(\022\b\002J:(1F+(\vi(JI\vx\vDI@(\028WFx(DI\tFIW/`(P\bW1I:(I\v@I(\127W\v+`FxxR\bDIx:(1\vI(\v\002J(I\v@Ii(DIPFx`\vDI@(\022W}xx(DIRxF\b`(JF/I:(I\v@(\027i\bxI``:(1F++(1IW(\bWFx`I(\028I\v+`(I\v@I+(/IW\bIJi`I@(\028}x1+\002Ji\vI1+(yIW+}I@x\v\002J(F@DI\tIW`\vD`(JF`(\b@1(I\v@I(y\t\v\t\t\vDI(lxI1IWiF\b+:(1\vI(8IRWFi}WF(/I+`I@+(RI@@`h"),
      Media = IMG_Emilio2
    },
    {
      Text = _yhK5("8F(PI@@(P\vW(1Fi\v`(1F+()}R\biI@`(@\v\002J`(DIxI+I@(RW\vIDI@:(1F@@(RF@@(I+(@\vIiF@1(xI+I@h(\028\b`(DIiF\002J`:(\\FI/Ih(\027x+}(xF++(\b@+(F@\tF@DI@h(?R:(\v\002J(Y\vIJ(1F+([I\bD(LI`Y`(iFx(F@h"),
      Media = IMG_Emilio0
    },
    {
      Text = _yhK5("t@1(@\b@(D\v/(i\vW(1I@(]}xx\v:(1I@(\v\002J(Y\bi(]I+I@(/I@\b`YI@(+}xxh"),
      Media = IMG_Emilio7
    }
  }, function(action)
    T_Hellsehen.Complete = true
    V_StoryLine = 250
    ITM_BuntesTuch:MoveTo(nil)
    ITM_Amulett:MoveTo(nil)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_Start()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(x\vID+`(@}\002J(DF@Y(wIW+\002JxF\tI@(\vi(\014I``(\b@1(wIW+\b\002J+`()\v\002J(F@(1\vI+I@(wIWW\bI\002R`I@(\022WF\bi(Y\b(IW\v@@IW@:(1I@()\b(1F(DIWF1I(JF``I+`h()F(RFiI@()WF\002JI@(1W\v@(w}W(\b@1(\022W}xxI(\b@1(w}W(FxxI@(+}(I\v@(RxI\v@IW(\tWI\002JIW(\\F/Ih()IW(P}xx`I(9\vWF`(PIW1I@h(mF+(iF@(1}\002J(iF@\002JiFx(\t\bIW(I\v@I@(t@+\v@@(Y\b+FiiI@`WFI\bi`:(\b@DxF\b/x\v\002Jh(]F@D+Fi(}I\t\t@I+`()\b(1\vI(\027\bDI@(\b@1(hhh"),
      Media = IMG_Intro10
    },
    {
      Text = _yhK5("?J(@I\v@:(1F@@(PFW(1F+(I`PF(DFW(RI\v@(\022WF\biS(\003\002JWFID(DIDI@\bI/IW(+\v`Y`(1IW(\\FI/I(\b@1(PI@1I`(1\vI([I``Ix(J\v@(\b@1(JIW:(1\vI(IW(DIWF1I(I/I@(\v@()I\v@Ii(\022WF\bi(\t\bIW(1\vI(9\vWF`I@(I\v@+FiiIx@(+}xx`Ih("),
      Media = IMG_Intro20
    },
    {
      Text = _yhK5("\027J:()\b(/\v+`(PF\002Jh(#\002J(1F\002J`I(+\002J}@:()\b(P\vxx+`(@}\002J(IP\vD(+\002JxF\tI@h(s\b+\002J:(WF\b+(F\b+(1I@(lI1IW@:(P\vW(JF/I@()\v@DI(Y\b(`\b@h(#\002J(/\v@(+\002J}@(iFx(1\vI()}R\biI@`I(1\bW\002JDIDF@DI@:(1\vI(P\vW(1F(DI+`IW@(I\v@DI+FiiIx`(JF/I@h({\vIx(RF@@(iF@(1Fi\v`(xI\v1IW(@\v\002J`(F@\tF@DI@h()IW(\022I3`(1FWF\b\t(\v+`(\v@(I\v@IW(w}Ixx\vD(\b@xI+/FWI@(\003yWF\002JI(DI+\002JW\vI/I@h"),
      Media = IMG_Intro30
    },
    {
      Text = _yhK5("\027/IW(P\vW(JF/I@(\028x\bI\002R(!(I`PF+(Y\bi\v@1I+`h(\003\002JI\v@/FW(JF`(+\v\002J(+\002J}@(iFx(PIW(F@(I\v@IW(tI/IW+I`Y\b@D(wIW+\b\002J`(\b@1(I\v@(yFFW(9F++FDI@(i\v`(8}`\vYI@(wIW+IJI@h(\a+(DIJ`(\bi(1\vI(\127\b@\v`Y/\bWD:(+}w\vIx(\v+`(+\002J}@(iFx(+\v\002JIWh(t@1(\vWDI@1P}(/I\v(1IW(\127\b@\v`Y/\bWD(+}xx(+\v\002J(F\b\002J(LIiF@1(W\bi`WI\v/I@:(1IW(1\vI+I+(\127W\v3RWF3(J\vIW(F@DI/x\v\002J(xI+I@(RF@@h()Fi\v`(1\bIW\t`I(1F@@(LF(P}Jx(F\b\002J(RxFW(+I\v@:(P}(I+(Fx+(@FI\002J+`I+(J\v@(DIJ`h"),
      Media = IMG_Intro30
    },
    {
      Text = _yhK5("Z\127xFW(\v+`(1F+(RxFWh(\027@(1I@(lW\bIJ+`\bI\002R+`\v+\002J:(P}J\v@(1I@@(+}@+`hZ(xF\b`I`()I\v@I(\027@`P}W`h(\003\002JI\v@/FW(PFW(1F+(F/IW(@\v\002J`(1\vI(\027@`P}W`:(1\vI(1IW(\\FI/I(J}IWI@(P}xx`I(\b@1(DI@F\b+}(PI@\vD(1\vI:(1\vI(IW(Y\b(FRYIy`\vIWI@(/IWI\v`(\v+`h"),
      Media = IMG_Intro40
    },
    {
      Text = _yhK5("8I\v@:(@I\v@:(@I\v@h(\127\b@\v`Y/\bWD(JI\v++`(1F+([\vIx(@F`\bIWx\v\002Jh([\bi(\028x\bI\002R(\v+`(1IW(\\\b\002R+F\002R(LF(@}\002J(DIyF\002R`h(#\002J(+}W`\vIW(@\bW(+\002J@Ixx(1F+(\b@@\bI`YI([I\bD(F\b+:(1F@@(RF@@(I+(x}+DIJI@h\020\014\\6\027xxIW1\v@D+(JF/I(\v\002J(\vWDI@1P\vI(F/IW(1F+(\028I\t\bIJx:(P\vW(/WF\b\002JI@(1F+(9F++P}W`(@}\002J(iFx:(i\v`(1Ii(P\vW(1I@(\022W}xx(DI+\002JW\biy\t`(JF/I@h()\b(RF@@+`()\v\002J(1}\002J(@}\002J(IW\v@@IW@(P\vI(I+(J\vI++:(}1IWS(lFxx+(@\v\002J`:(+\002JF\b(x\vI/IW(@}\002J(iFx(@F\002Jh(#\002J(\tx\vID(+\002J}@(iFx(w}W:(i\b++(I\v@(PI@\vD(1\vI(lx\bIDIx(/IPIDI@h(m\vW(`WI\t\tI@(\b@+(1F@@(\b@`IWJFx/(1IW(\127\b@\v`Y/\bWDh()}W`(\v@(1IW(8FIJI(\v+`(F\b\002J(I\v@(9FWRyxF`Y:(\tFxx+()\b(+}(PF+(/WF\b\002J+`h"),
      Media = IMG_Intro50
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_EmilioRename()
  P_Emilio.Name = _yhK5("\ai\vx\v}")
  P_Emilio.Description = _yhK5("\a\v@(+IJW(`FxI@`\vIW`IW(?WFRIx!\027Y\b/\vh(]I\v1IW(JF`(IW(1\vI(]IJWI(DIWF1I(IW+`(/ID}@@I@h")
end
function FCT_LollisSammeln()
  V_LolliCounter = 0
  if Player:Contains(ITM_LolliFeder) then
    V_LolliCounter = V_LolliCounter + 1
  end
  if Player:Contains(ITM_LolliHaar) then
    V_LolliCounter = V_LolliCounter + 1
  end
  if Player:Contains(ITM_LolliDreck) then
    V_LolliCounter = V_LolliCounter + 1
  end
  if V_LolliCounter >= 3 then
    TMR_HlpLollis:Stop()
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5(")F@@(JFI``I@(P\vW(LI`Y`(Fx+}(1I@(o\bIxx/IWD(P\vI1IW(/I+I\v`\vD`:(1I@(1IW(\022W}xx(F@DIJFI\b\t`(JF`h(sF+`()\b(\tI\v@(DIiF\002J`h(\022W\v\t\t`(+\v\002J(D\b`:(1F++(\v\002J(iI\v@I@(]}xx\v(F\b\002J(DIWF1I(F\b\tDIx\b`+\002J`(JF/Ih()F@@(xF++(\b@+(iFx(PI\v`IWY\vIJI@h"),
        Media = IMG_Ba2A
      },
      {
        Text = _yhK5("#\002J(iF\002JI(@}\002J(I\v@I@(RxI\v@I@(\027/+`I\002JIW(Y\b(1IW(\014F@R:(1\vI(\v\002J(DIWF1I(1}W`(F\b\t(1Ii(s\bIDIx(I@`1I\002R`(JF/Ih()\vI(+\vIJ`(DIi\bI`x\v\002J(F\b+h(\127}ii(W\bJ\vD(F\b\002J(iFx(w}W/I\vh"),
        Media = IMG_Ba2E
      }
    }, function(action)
      Z_Bergauf20.Active = false
      Z_Bergauf30.Active = true
      Z_Lollistelle1.Active = false
      Z_Lollistelle2.Active = false
      Z_Lollistelle3.Active = false
      Z_Huegel.Active = true
      P_Raebe:MoveTo(Z_Bergauf30)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_LolliHilfeStatus == 0 then
    V_LolliHilfeStatus = 10
    _Urwigo.MessageBox({
      Text = _yhK5("\003\b\002J()\b(iFx(+\002J}I@(1I@(\\I+`(w}i(o\bIxx(Y\b+FiiI@:(1I@(P\vW(J\vIW(wIW+`WI\b`(JF/I@:(\v\002J(I++I(DIWF1Ih(j(]}xx\v+(i\b++`()\b(\t\v@1I@:(1\vI(F@1IWI@(JF/(\v\002J(LF(+\002J}@(I\v@DI+FiiIx`(\b@1(1F+(PFWI@(w\vIx(iIJW(Fx+(j:(RF@@+`I(P}Jx(P\v++I@h(hhh( F(D\b`:(\v\002J(JF/()\vW(1\vI(\bI/W\vD(DIxF++I@:(1\vI(Fi(PI\v`I+`I@(DI\tx}DI@(+\v@1:(DI/(\v\002J(LF(Y\b:(F/IW(PI\v`IW(Fx+(,z(oI`IW(x\vID`(DFWF@`\vIW`(RI\v@IW(PIDh"),
      Media = IMG_Ba2B,
      Callback = function(action)
        if action ~= nil then
          TMR_HlpLollis:Start()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif 0 < TMR_HlpLollis.Remaining then
    V_TempStr = (_yhK5("]F++(i\v\002J(LI`Y`(IW+`(iFx(@}\002J(") .. TMR_HlpLollis.Remaining) .. _yhK5("(\003IR\b@1I@(F@(iI\v@Ii(]}xx\v(x\b`+\002JI@:(1F@@(R}I@@I@(P\vW(\b@+(\b@`IWJFx`I@h\020\014\\6t@1(1\b(`FI`I+`(D\b`(1FWF@:(J\vIW(\v@(1IW([P\v+\002JI@YI\v`(1\vI(\028IDI@1(F/Y\b+\b\002JI@h")
    _Urwigo.MessageBox({
      Text = V_TempStr,
      Media = IMG_Ba2B,
      Callback = function(action)
        if action ~= nil then
          TMR_HlpLollis:Start()
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif V_LolliHilfeStatus == 10 then
    V_LolliHilfeStatus = 20
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("mF+(+}xx(\v\002J(iF\002JI@S(s\vx\t(i\vW(1}\002J(iFx:(\v\002J(JF/(RI\v@I@(9xF@h"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("\027\002J(JIWLI:(1F(JF+`()\b()\vW(@\b@(+\002J}@(+}(I\v@(`I\bWI+(]}xx\v!\003\b\002JDIWFI`(DIRF\b\t`(\b@1(PI\v++`(@\v\002J`:(P\vI(iF@(I+(/I1\vI@`h(8F(\v\002J(IWRxFIW(I+()\vW(iFxh\020\014\\6\020\014\\6)\b(i\b++`(I+(\002Fh(\":,j(i(\bI/IW(1I@(\014}1I@(JFx`I@(\b@1(1F@@()I\v@I(\027\bDI@(i\v`(+`FWIi(\014x\v\002R(F\b\t(1\vI(\003`IxxI(W\v\002J`I@:(P}(Zu}\b(+IIZ(+`IJ`h()FY\b(/WF//Ix+`()\b(1F@@(Z\003\b\002J(1I@(]}xx\v:(+\b\002JhZ(\b@1(xFI\b\t+`(P\vI(I\v@([}i/\vI(Y\vIxx}+(1\bW\002J(1\vI(\028IDI@1:(/\v+(1}W`(/I\v(Zu}\b(+IIZ(1F+(m}W`(Z]}xx\vZ(F\b\t`F\b\002J`h()F@@(/\bI\002R+`()\b()\v\002J(\b@1(JI/+`(\vJ@(F\b\th(\027xxI+(RxFWS(t@1(@\b@(+\b\002J(1I@(]}xx\v:(+\b\002Jh"),
        Media = IMG_Ba2B
      }
    }, function(action)
      TMR_HlpLollis:Start()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_LolliHilfeStatus == 20 then
    V_LolliHilfeStatus = 30
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("m\vI(PFW(1F+(1}\002J(DxI\v\002J(@}\002J(iFx(i`(1I@(]}xx\v+S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("\003FD(LI`Y`(@\v\002J`:()\b(JF+`(\viiIW(@}\002J(@\v\002J`(1\vI(j(]}xx\v+(DI\t\b@1I@h(\003`FWWIW(\014x\v\002R(F\b\t(1F+(]}xx\v!\003\b\002JDIWFI`(\b@1(Y\b(Zu}\b(+IIZ(D\b\002RI@h\020\014\\6\020\014\\6)I@(I\v@I@(+IJI(\v\002J(LF(+}DFW(+\002J}@(w}@(J\vIW(F\b+h(\028\v/(iFx()I\v@I(\127FW`I(JIW:(\v\002J(YI\v\002J@I()\vW(I\v@:(P}()\b(\vJ@(\t\v@1I+`h"),
        Media = IMG_Ba2B
      }
    }, function(action)
      Z_Lollistelle1.Visible = true
      TMR_HlpLollis:Start()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif V_LolliHilfeStatus == 30 then
    V_LolliHilfeStatus = 40
    _Urwigo.Dialog(false, {
      {
        Text = _yhK5("m\vI(PFW(1F+(1}\002J(DxI\v\002J(@}\002J(iFx(i`(1I@(]}xx\v+S"),
        Media = IMG_Spieler
      },
      {
        Text = _yhK5("?R:(\v\002J(DI/I(F\b\t:()\b(xIW@+`(I+(@\vIh()IW(YPI\v`I(x\vID`(1}W`(1W\bI/I@(\b@1(1IW(1W\v``I(1}W`(J\v@`I@h(mI@@()\b(+}(PI\v`IW(iF\002J+`:(P\vW1(F\b+(i\vW(F/IW(RI\v@(9\vWF`h"),
        Media = IMG_Ba2B
      }
    }, function(action)
      Z_Lollistelle2.Visible = true
      Z_Lollistelle3.Visible = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _yhK5("#\002J(I++I(DIWF1I(\b@1(W\bIJWI(i\v\002J(@\v\002J`(w}@(1IW(\003`IxxI:(/\v+()\b(I+(I@1x\v\002J(DI+\002JF\t\t`(JF+`:(1\vI(j()\v@DIW(w}i(\014}1I@(F\b\tY\bJI/I@h"),
      Media = IMG_Ba2B,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function FCT_RestartHelpCountDown()
  if V_LolliHilfeStatus >= 10 then
    TMR_HlpLollis:Stop()
    TMR_HlpLollis:Start()
  end
end
function FCT_HolzzeltBetreten()
  if V_BibStatus == 20 then
    ITM_Foto.Commands._70V.Enabled = true
  end
  P_Raebe:MoveTo(Player)
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5("\003\vIJ+`()\b(1F+(s}xYYIx`(1}W`(1W\bI/I@S()}W`(DIJ`(1\vI(\028I+\002J\v\002J`I(LI`Y`(PI\v`IWh"),
      Media = IMG_Ba3BibZelt
    },
    {
      Text = _yhK5("\027/IW()\b(IW\v@@IW+`()\v\002J(LF:(J\vIW(\v+`(I\v@(8F`\bW+\002J\b`YDI/\vI`(\b@1(\v\002J(P\vxx()\vW(@\v\002J`(Y\bi\b`I@:(DIDI@(1\vI(\\IDIx@(Y\b(wIW+`}++I@(\b@1(1I@(mID(Y\b(wIWxF++I@h()FW\bi(i\b++`()\b(@\v\002J`(J\v@DIJI@:(+`F``1I++I@(P\vW1(1F+([Ix`(Y\b()\vW(J\vIWJIW(F\b\t(1I@(mID(R}iiI@:(wIWW\bI\002R`(PF+S(\027/IW(F\b\002J(@\v\002J`(iIJW(Fx+(1IW(DF@YI(\\I+`h"),
      Media = IMG_Naturschutzgebiet
    },
    {
      Text = _yhK5("\027x+()\b()\v\002J(1IW(}\t\tI@I@(\003I\v`I(1I+(s}xYYIx`I+(@FJIW+`:(IWRI@@+`()\b(xF@D+Fi:(PIW(+\v\002J(1}W`(F\b\tJFIx`h()\vI(9\vWF`I@(+\v@1(I+(+\002J}@(iFx(@\v\002J`:(+\vIJ`(iIJW(P\vI(I\v@(?WF@D!t`F@(F\b+h"),
      Media = IMG_Ba3B
    }
  }, function(action)
    Z_Holzzelt.Active = true
    Z_Bergauf30.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_FmHolen()
  _Urwigo.Dialog(false, {
    {
      Text = _yhK5(")\b(lxI1IWiF\b+:(P\vW(R}I@@`I@()\v\002J(1F(1W\bI/I@(/I\vi(?WFRIx(D\b`(DI/WF\b\002JI@h(oFD+`()\b(@\v\002J`(W\bI/IW(R}iiI@S"),
      Media = IMG_Fledermaus2
    },
    {
      Text = _yhK5("mFW\bi(@\v\002J`h(l\bIW(I\v@I@(mFWi1\b+\002JIW(iF\002J(\v\002J(1F+(1}\002J(DIW@Ih"),
      Media = IMG_Fledermaus3
    },
    {
      Text = _yhK5("\003}(PFWi(1\b+\002JI(\v\002J(DFW(@\v\002J`h(#\002J(\t\v@1I:(1F+(\v+`(\viiIW(@}\002J(I\v@I(Y\vIix\v\002JI(o\bIJI:(1\vI(\v\002J(J\vIW(JF/Ih"),
      Media = IMG_Fledermaus1
    },
    {
      Text = _yhK5("\028F@Y:(P\vI()\b(iI\v@+`h"),
      Media = IMG_Fledermaus3
    }
  }, function(action)
    P_Fledermaus:MoveTo(Z_Tisch)
    Z_Local_FMaus.Active = false
    V_FMausStatus = 20
    T_Begleiter.Complete = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_DevToolDrop()
  if V_DtLolli == 1 and V_DtNotiz == 0 then
    V_DtLolli = 0
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif V_DtLolli == 0 and V_DtNotiz == 1 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif V_DtLolli == 1 and V_DtNotiz == 1 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif V_DtLolli == 1 and V_DtNotiz == 2 then
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif V_DtLolli == 2 and V_DtNotiz == 2 then
    V_DtLolli = -1
    V_DtNotiz = -1
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(INP_DevToolDrop)
    end)
  else
    V_DtLolli = -1
    V_DtNotiz = -1
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end
end
function FCT_DbgLollisNehmen()
  ITM_LolliFeder:MoveTo(Player)
  ITM_LolliFeder.Commands._34e4o.Enabled = false
  ITM_LolliFeder.Commands.__oru.Enabled = true
  ITM_LolliHaar:MoveTo(Player)
  ITM_LolliHaar.Commands._6IsGG.Enabled = false
  ITM_LolliHaar.Commands._yzHs.Enabled = true
  ITM_LolliDreck:MoveTo(Player)
  ITM_LolliDreck.Commands._ZLZ8f.Enabled = false
  ITM_LolliDreck.Commands._tL2.Enabled = true
end
function FCT_AufgabenAnpassen()
  if V_StoryLine >= 60 then
    T_Kunitz.Complete = true
    T_NachOben.Active = true
  end
  if V_StoryLine >= 100 and V_EasyMode ~= 0 then
    T_Kopftuch.Complete = true
  end
  if V_StoryLine >= 240 then
    T_NachOben.Complete = true
    T_Amulett.Active = true
    T_Kopftuch.Active = true
    T_Begleiter.Active = true
    T_Hellsehen.Active = true
    T_Uebersetzung.Active = true
  end
  if V_StoryLine >= 260 then
    T_Feuer.Active = true
    T_Amulett.Complete = true
    T_Kopftuch.Complete = true
    T_Begleiter.Complete = true
    T_Hellsehen.Complete = true
    T_Uebersetzung.Complete = true
    T_Nekramora.Active = true
    T_Nekramora.Complete = true
    T_Skelett.Active = true
    T_Skelett.Complete = true
  end
end
function FCT_Statistik()
  V_StatWert = 0
  V_StatAnzahl = 0
  if Player:Contains(ITM_CoCaPiraten) then
    V_StatAnzahl = V_StatAnzahl + 1
    V_StatWert = V_StatWert + 2
  end
  if Player:Contains(ITM_CoCaSpinne) then
    V_StatAnzahl = V_StatAnzahl + 1
    V_StatWert = V_StatWert + 3
  end
  if Player:Contains(ITM_CoCaFM) then
    V_StatAnzahl = V_StatAnzahl + 1
    V_StatWert = V_StatWert + 5
  end
  if Player:Contains(ITM_CoCaBib) then
    V_StatAnzahl = V_StatAnzahl + 1
    V_StatWert = V_StatWert + 10
  end
  if Player:Contains(ITM_CoCaOra) then
    V_StatAnzahl = V_StatAnzahl + 1
    V_StatWert = V_StatWert + 10
  end
  _Urwigo.Dialog(false, {
    {
      Text = (((_yhK5(")\b(JF+`(") .. V_StatAnzahl) .. _yhK5("(w}@(-(i}IDx\v\002JI@({\v+\v`I@RFW`I@(DI\t\b@1I@(i\v`(I\v@Ii(\028I+Fi`PIW`(w}@(")) .. V_StatWert) .. _yhK5("(9\b@R`I@(/I\v(jz(i}IDx\v\002JI@(9\b@R`I@h"),
      Media = IMG_Fledermaus0
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function FCT_LaterneGeben()
  P_Troellchen.Commands._Vho2.Enabled = true
  ITM_Laterne:MoveTo(nil)
  V_FMausStatus = 50
  V_StoryLine = 350
  Z_Orakel.Visible = false
  Z_Orakel.Active = true
  _2now:MoveTo(Z_Orakel)
  ITM_Schild2:MoveTo(nil)
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function CheckInventory(input)
  if input == nil then
    input = ""
  end
  input = Trim(string.lower(input))
  local inv = {
    "zettel",
    "blatt 1",
    "blatt 2",
    "truhe",
    "laterne",
    "ast",
    "lollis",
    "keule",
    "niespulver",
    "notiz",
    "raebe",
    "unlock-code"
  }
  local found = false
  if input == "" then
    return -1
  end
  if input == "easy" then
    return -2
  end
  if input == "lollies" then
    input = "lollis"
  elseif input == "laterne am stiel" then
    input = "laterne"
  elseif input == "blatt" then
    input = "blatt 1"
  elseif input == "debugba2" then
    return -10
  elseif input == "debugba4" then
    return -11
  elseif input == "debugba8" then
    return -12
  elseif input == "debugnacht" then
    return -13
  elseif input == "debugfin" then
    return -14
  elseif input == "debugxxxxx" then
    return -15
  end
  for i, name in ipairs(inv) do
    if name == input then
      found = true
      break
    end
  end
  print(input)
  if found then
    if V_InventarEingabe == "" then
      V_InventarEingabe = {}
    end
    if V_InventarEingabe[input] == true then
      print("Wiederholung")
      return 0
    end
    V_InventarEingabe[input] = true
    local cnt = TableLength(V_InventarEingabe)
    print(cnt)
    return cnt
  else
    print("ungueltig")
    return -1
  end
end
function Trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end
function TableLength(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end
function CenterLocal(zone, radius)
  local refPoint = Player.ObjectLocation
  local points = {}
  for i = 60, 360, 60 do
    local dist = Wherigo.Distance(radius, "m")
    local p1 = Wherigo.TranslatePoint(refPoint, dist, i)
    table.insert(points, p1)
  end
  local active = zone.Active
  zone.Active = false
  zone.Points = points
  zone.Active = active
end
function GetZoneCenter(zone)
  local median_lat = 0
  local median_long = 0
  local zonePointCount = #zone.Points
  for i = 1, zonePointCount do
    median_lat = median_lat + zone.Points[i].latitude
    median_long = median_long + zone.Points[i].longitude
  end
  median_lat = median_lat / zonePointCount
  median_long = median_long / zonePointCount
  return ZonePoint(median_lat, median_long, 0)
end
function MeasureDistanceToZone(zone)
  local zoneCenter = GetZoneCenter(zone)
  local r, a = Wherigo.VectorToPoint(zoneCenter, Player.ObjectLocation)
  local dist = r:GetValue("m")
  print(dist)
  return dist
end
function MinutesToTime(minutes)
  if minutes >= 1440 then
    minutes = minutes - 1440
  end
  local h = math.floor(minutes / 60)
  local m = minutes - 60 * h
  return string.format("%d:%02d", h, m)
end
function GetTransferCode(content, maxLen2)
  local name = Player.Name
  if string.len(name) < 1 then
    name = " "
  end
  if string.len(content) < 1 then
    content = " "
  end
  local l1 = string.len(content)
  local l2 = string.len(name)
  local maxl = l1 > l2 and l1 or l2
  if maxLen2 < maxl then
    maxl = maxLen2
  end
  local p1 = 1
  local p2 = 1
  local result = ""
  for i = 1, maxl do
    if l1 < p1 then
      p1 = 1
    end
    if l2 < p2 then
      p2 = 2
    end
    local b1 = string.byte(content, p1)
    local b2 = string.byte(name, p2)
    result = result .. string.format("%02x", bxor(b1, b2))
    p1 = p1 + 1
    p2 = p2 + 1
  end
  return result
end
function bxor(a, b)
  local r = 0
  for i = 0, 31 do
    local x = a / 2 + b / 2
    if x ~= math.floor(x) then
      r = r + 2 ^ i
    end
    a = math.floor(a / 2)
    b = math.floor(b / 2)
  end
  return r
end
return _Ftnpx
