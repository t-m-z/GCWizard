require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _OCpG(str)
  local res = ""
  local dtable = "z\014W(K\021:]Zqd\023\029gi={1I\025e*fS#<\020\005`J}Yu\018\003BU\bc\026k\022\vGF_\006QNv8H7Pj\030@\000!\002.\">D5h,|\016s?\019-\a\0013 y&2;\004+M\nt%Xm\024\\$\028~L6Ew9VT\015\031\f40l\rCo\027\tr)Ra'nAp^\017Ox[/b"
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
cartDerGrueneDiamant = Wherigo.ZCartridge()
zmediaAlteFrau_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaAlteFrau_Icon.Id = "622ebe86-affb-48b5-bf8b-f8a853e856aa"
zmediaAlteFrau_Icon.Name = _OCpG("wkV\021-qt!.\019'nv")
zmediaAlteFrau_Icon.Description = ""
zmediaAlteFrau_Icon.AltText = ""
zmediaAlteFrau_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "bunt_icon_AlteFrau.JPG",
    Directives = {}
  }
}
zmediaAlteFrau_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaAlteFrau_komplett.Id = "bf992200-8f6e-440c-ac75-7ac88242761c"
zmediaAlteFrau_komplett.Name = _OCpG("wkV\021-qt!.)nYxk\021VV")
zmediaAlteFrau_komplett.Description = ""
zmediaAlteFrau_komplett.AltText = ""
zmediaAlteFrau_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "bunt_klein_AlteFrau.JPG",
    Directives = {}
  }
}
zmediaAlteFrau_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaAlteFrau_Ausschnitt.Id = "da89d09c-7694-449c-9967-10b92241eae2"
zmediaAlteFrau_Ausschnitt.Name = _OCpG("wkV\021-qt!.w!FF'Bv\015VV")
zmediaAlteFrau_Ausschnitt.Description = ""
zmediaAlteFrau_Ausschnitt.AltText = ""
zmediaAlteFrau_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "bunt_klein_ausschnitt_AlteFrau.JPG",
    Directives = {}
  }
}
zmediaBettler_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaBettler_komplett.Id = "af4e6ca3-0f5a-49cd-b9b3-2928a2e2fefa"
zmediaBettler_komplett.Name = _OCpG("$\021VVk\021q.)nYxk\021VV")
zmediaBettler_komplett.Description = ""
zmediaBettler_komplett.AltText = ""
zmediaBettler_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Bettler_komplett.JPG",
    Directives = {}
  }
}
zmediaBettler_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaBettler_Ausschnitt.Id = "dc940a3b-03ce-4b63-bab8-22492e15a2fe"
zmediaBettler_Ausschnitt.Name = _OCpG("$\021VVk\021q.w!FF'Bv\015VV")
zmediaBettler_Ausschnitt.Description = ""
zmediaBettler_Ausschnitt.AltText = ""
zmediaBettler_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Bettler_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaBettler_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaBettler_Icon.Id = "86641413-de5e-4cd0-9a93-2ec14443a023"
zmediaBettler_Icon.Name = _OCpG("$\021VVk\021q.\019'nv")
zmediaBettler_Icon.Description = ""
zmediaBettler_Icon.AltText = ""
zmediaBettler_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Bettler_Icon.JPG",
    Directives = {}
  }
}
zmediaDrehorgelspieler_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDrehorgelspieler_komplett.Id = "a653e0ff-b432-4859-a5a4-8b444cb71549"
zmediaDrehorgelspieler_komplett.Name = _OCpG("@q\021Bnq\014\021kFx\015\021k\021q.)nYxk\021VV")
zmediaDrehorgelspieler_komplett.Description = ""
zmediaDrehorgelspieler_komplett.AltText = ""
zmediaDrehorgelspieler_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Drehorgespieler_komplett.JPG",
    Directives = {}
  }
}
zmediaDrehorgelspieler_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDrehorgelspieler_Icon.Id = "276cc5d6-98f5-4ab8-85c5-803b4f5990b9"
zmediaDrehorgelspieler_Icon.Name = _OCpG("@q\021Bnq\014\021kFx\015\021k\021q.\019'nv")
zmediaDrehorgelspieler_Icon.Description = ""
zmediaDrehorgelspieler_Icon.AltText = ""
zmediaDrehorgelspieler_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Drehorgespieler_Icon.JPG",
    Directives = {}
  }
}
zmediaDrehorgellspieler_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDrehorgellspieler_Ausschnitt.Id = "69e26f7b-ed56-467a-af0e-db6fd8814687"
zmediaDrehorgellspieler_Ausschnitt.Name = _OCpG("@q\021Bnq\014\021kkFx\015\021k\021q.w!FF'Bv\015VV")
zmediaDrehorgellspieler_Ausschnitt.Description = ""
zmediaDrehorgellspieler_Ausschnitt.AltText = ""
zmediaDrehorgellspieler_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Drehorgespieler_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaJungerGeiger_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaJungerGeiger_Ausschnitt.Id = "c83e3969-7dab-4664-8890-36fe73fa3680"
zmediaJungerGeiger_Ausschnitt.Name = _OCpG("\030!v\014\021q,\021\015\014\021q.w!FF'Bv\015VV")
zmediaJungerGeiger_Ausschnitt.Description = ""
zmediaJungerGeiger_Ausschnitt.AltText = ""
zmediaJungerGeiger_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "JungerGeiger_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaJungerGeiger_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaJungerGeiger_Icon.Id = "1e9c7f51-771f-486b-b144-f6ddcd32fdff"
zmediaJungerGeiger_Icon.Name = _OCpG("\030!v\014\021q,\021\015\014\021q.\019'nv")
zmediaJungerGeiger_Icon.Description = ""
zmediaJungerGeiger_Icon.AltText = ""
zmediaJungerGeiger_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "JungerGeiger_Icon.JPG",
    Directives = {}
  }
}
zmediaJungerGeiger_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaJungerGeiger_komplett.Id = "7f19bd4e-7100-46b9-ac8a-b4a97ee76548"
zmediaJungerGeiger_komplett.Name = _OCpG("\030!v\014\021q,\021\015\014\021q.)nYxk\021VV")
zmediaJungerGeiger_komplett.Description = ""
zmediaJungerGeiger_komplett.AltText = ""
zmediaJungerGeiger_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "JungerGeiger_komplett.JPG",
    Directives = {}
  }
}
zmediaMarktfrau_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMarktfrau_Ausschnitt.Id = "b6b785b5-64fb-495d-baeb-3889641ba430"
zmediaMarktfrau_Ausschnitt.Name = _OCpG("Ttq)V\023qt!.w!FF'Bv\015VV")
zmediaMarktfrau_Ausschnitt.Description = ""
zmediaMarktfrau_Ausschnitt.AltText = ""
zmediaMarktfrau_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Marktfrau_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaMarktfrau_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMarktfrau_Icon.Id = "71b2d082-2da7-4dd6-853d-5e94407c7415"
zmediaMarktfrau_Icon.Name = _OCpG("Ttq)V\023qt!.\019'nv")
zmediaMarktfrau_Icon.Description = ""
zmediaMarktfrau_Icon.AltText = ""
zmediaMarktfrau_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Marktfrau_Icon.JPG",
    Directives = {}
  }
}
zmediaMarktfrau_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMarktfrau_komplett.Id = "06dc5860-2f0f-479f-9e46-3fb0ef87e239"
zmediaMarktfrau_komplett.Name = _OCpG("Ttq)V\023qt!.)nYxk\021VV")
zmediaMarktfrau_komplett.Description = ""
zmediaMarktfrau_komplett.AltText = ""
zmediaMarktfrau_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Marktfrau_komplett.JPG",
    Directives = {}
  }
}
zmediaNetterHerr_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaNetterHerr_Ausschnitt.Id = "3c173626-d3ed-479b-8201-83777f4334c2"
zmediaNetterHerr_Ausschnitt.Name = _OCpG("1\021VV\021q4\021qq.w!FF'Bv\015VV")
zmediaNetterHerr_Ausschnitt.Description = ""
zmediaNetterHerr_Ausschnitt.AltText = ""
zmediaNetterHerr_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "NetterHerr_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaNetterHerr_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaNetterHerr_Icon.Id = "f84d9265-9f2d-4ccf-9cd3-8d71471b9b61"
zmediaNetterHerr_Icon.Name = _OCpG("1\021VV\021q4\021qq.\019'nv")
zmediaNetterHerr_Icon.Description = ""
zmediaNetterHerr_Icon.AltText = ""
zmediaNetterHerr_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "NetterHerr_Icon.JPG",
    Directives = {}
  }
}
zmediaNetterHerr_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaNetterHerr_komplett.Id = "5dc9374e-f50e-4fe8-a6ca-bf42827a86ac"
zmediaNetterHerr_komplett.Name = _OCpG("1\021VV\021q4\021qq.)nYxk\021VV")
zmediaNetterHerr_komplett.Description = ""
zmediaNetterHerr_komplett.AltText = ""
zmediaNetterHerr_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "NetterHerr_komplett.JPG",
    Directives = {}
  }
}
zmediaOrdnerin_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaOrdnerin_Ausschnitt.Id = "6d56b4f6-8e5e-4b9c-bf5a-cdf1cff67c64"
zmediaOrdnerin_Ausschnitt.Name = _OCpG("{q\vv\021q\015v.w!FF'Bv\015VV")
zmediaOrdnerin_Ausschnitt.Description = ""
zmediaOrdnerin_Ausschnitt.AltText = ""
zmediaOrdnerin_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Ordnerin_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaOrdnerin_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaOrdnerin_Icon.Id = "13d61312-fcdb-4dd9-8e50-1e4938814909"
zmediaOrdnerin_Icon.Name = _OCpG("{q\vv\021q\015v.\019'nv")
zmediaOrdnerin_Icon.Description = ""
zmediaOrdnerin_Icon.AltText = ""
zmediaOrdnerin_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Ordnerin_Icon.JPG",
    Directives = {}
  }
}
zmediaOrdnerin_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaOrdnerin_komplett.Id = "be9054f8-ab55-4a92-b7f1-bbf0ffe77353"
zmediaOrdnerin_komplett.Name = _OCpG("{q\vv\021q\015v.)nYxk\021VV")
zmediaOrdnerin_komplett.Description = ""
zmediaOrdnerin_komplett.AltText = ""
zmediaOrdnerin_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Ordnerin_komplett.JPG",
    Directives = {}
  }
}
zmediaPolizist_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaPolizist_Ausschnitt.Id = "05d558a5-85f4-444c-b97a-105e5b7d3df6"
zmediaPolizist_Ausschnitt.Name = _OCpG("6nk\015\001\015FV.w!FF'Bv\015VV")
zmediaPolizist_Ausschnitt.Description = ""
zmediaPolizist_Ausschnitt.AltText = ""
zmediaPolizist_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Polizist_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaPolizist_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaPolizist_Icon.Id = "bd648a58-eff8-4d47-8d4a-739bdc2a31e2"
zmediaPolizist_Icon.Name = _OCpG("6nk\015\001\015FV.\019'nv")
zmediaPolizist_Icon.Description = ""
zmediaPolizist_Icon.AltText = ""
zmediaPolizist_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Polizist_Icon.JPG",
    Directives = {}
  }
}
zmediaPolizist_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaPolizist_komplett.Id = "342b8b74-9323-4e3f-95dc-e816abe53342"
zmediaPolizist_komplett.Name = _OCpG("6nk\015\001\015FV.)nYxk\021VV")
zmediaPolizist_komplett.Description = ""
zmediaPolizist_komplett.AltText = ""
zmediaPolizist_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Polizist_komplett.JPG",
    Directives = {}
  }
}
zmediaReporter_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaReporter_Ausschnitt.Id = "7368a7c3-fbf3-4442-9606-568e2bd88739"
zmediaReporter_Ausschnitt.Name = _OCpG("s\021xnqV\021q.w!FF'Bv\015VV")
zmediaReporter_Ausschnitt.Description = ""
zmediaReporter_Ausschnitt.AltText = ""
zmediaReporter_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "Reporter_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaReporter_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaReporter_Icon.Id = "b01eac47-5722-435c-b174-4b164704924f"
zmediaReporter_Icon.Name = _OCpG("s\021xnqV\021q.\019'nv")
zmediaReporter_Icon.Description = ""
zmediaReporter_Icon.AltText = ""
zmediaReporter_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Reporter_Icon.JPG",
    Directives = {}
  }
}
zmediaReporter_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaReporter_komplett.Id = "559a7872-9840-431a-8ab2-39e4687f622a"
zmediaReporter_komplett.Name = _OCpG("s\021xnqV\021q.)nYxk\021VV")
zmediaReporter_komplett.Description = ""
zmediaReporter_komplett.AltText = ""
zmediaReporter_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Reporter_komplett.JPG",
    Directives = {}
  }
}
zmediaSherlockHolmes_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaSherlockHolmes_Ausschnitt.Id = "37933a6c-2857-4be9-977a-b5bb67c7b4d6"
zmediaSherlockHolmes_Ausschnitt.Name = _OCpG("\024B\021qkn')4nkY\021F.w!FF'Bv\015VV")
zmediaSherlockHolmes_Ausschnitt.Description = ""
zmediaSherlockHolmes_Ausschnitt.AltText = ""
zmediaSherlockHolmes_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "SherlockHolmes_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaSherlockHolmes_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaSherlockHolmes_komplett.Id = "499286e7-e2ec-48ec-9b8d-591d3983851d"
zmediaSherlockHolmes_komplett.Name = _OCpG("\024B\021qkn')4nkY\021F.)nYxk\021VV")
zmediaSherlockHolmes_komplett.Description = ""
zmediaSherlockHolmes_komplett.AltText = ""
zmediaSherlockHolmes_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Sherlockholmes_komplett.JPG",
    Directives = {}
  }
}
zmediaTaschentuecher_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaTaschentuecher_komplett.Id = "dd6ae82e-b567-4030-b077-69eb16afff90"
zmediaTaschentuecher_komplett.Name = _OCpG("etF'B\021vV!\021'B\021q.)nYxk\021VV")
zmediaTaschentuecher_komplett.Description = ""
zmediaTaschentuecher_komplett.AltText = ""
zmediaTaschentuecher_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "taschentuecher.jpg",
    Directives = {}
  }
}
zmediaTaschentuecher_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaTaschentuecher_Icon.Id = "8af3add8-60cc-4ec3-91b5-14828dc207ab"
zmediaTaschentuecher_Icon.Name = _OCpG("etF'B\021vV!\021'B\021q.\019'nv")
zmediaTaschentuecher_Icon.Description = ""
zmediaTaschentuecher_Icon.AltText = ""
zmediaTaschentuecher_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "taschentuecher_Icon.jpg",
    Directives = {}
  }
}
zmedia2EUR_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmedia2EUR_Icon.Id = "41a42418-62d0-4e94-b962-41a9679ccdf3"
zmedia2EUR_Icon.Name = _OCpG("Pa%s.\019'nv")
zmedia2EUR_Icon.Description = ""
zmedia2EUR_Icon.AltText = ""
zmedia2EUR_Icon.Resources = {
  {
    Type = "gif",
    Filename = "2EUR_Icon.gif",
    Directives = {}
  }
}
zmediaEuro_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaEuro_komplett.Id = "a21a5d46-4cff-4a82-a79c-4e63f91f3543"
zmediaEuro_komplett.Name = _OCpG("a!qn.)nYxk\021VV")
zmediaEuro_komplett.Description = ""
zmediaEuro_komplett.AltText = ""
zmediaEuro_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "Euro_komplett.jpg",
    Directives = {}
  }
}
zmediaMaedchen_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMaedchen_Ausschnitt.Id = "3cd1df67-2354-4ce1-96f2-a996a5bec046"
zmediaMaedchen_Ausschnitt.Name = _OCpG("Tt\021\v'B\021v.w!FF'Bv\015VV")
zmediaMaedchen_Ausschnitt.Description = ""
zmediaMaedchen_Ausschnitt.AltText = ""
zmediaMaedchen_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "JungeKirsche_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaWuerstelmann_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaWuerstelmann_Icon.Id = "f0ed464f-8d10-42a9-b002-50a540d9f103"
zmediaWuerstelmann_Icon.Name = _OCpG("\003!\021qFV\021kYtvv.\019'nv")
zmediaWuerstelmann_Icon.Description = ""
zmediaWuerstelmann_Icon.AltText = ""
zmediaWuerstelmann_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "wuerstelmann_Icon.JPG",
    Directives = {}
  }
}
zmediaWuerstelmann_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaWuerstelmann_komplett.Id = "aa8761a3-1b8a-4ad9-829a-a3c5546899ec"
zmediaWuerstelmann_komplett.Name = _OCpG("\003!\021qFV\021kYtvv.)nYxk\021VV")
zmediaWuerstelmann_komplett.Description = ""
zmediaWuerstelmann_komplett.AltText = ""
zmediaWuerstelmann_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "wuestelmann_komplett.JPG",
    Directives = {}
  }
}
zmediaMaedchen_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMaedchen_Icon.Id = "d95bd596-eb31-4a15-b2b0-014b4724ba0b"
zmediaMaedchen_Icon.Name = _OCpG("Tt\021\v'B\021v.\019'nv")
zmediaMaedchen_Icon.Description = ""
zmediaMaedchen_Icon.AltText = ""
zmediaMaedchen_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "JungeKirsche_Icon.JPG",
    Directives = {}
  }
}
zmediaGruenerDiamant_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGruenerDiamant_Icon.Id = "2e91d2f2-4659-4630-970d-4dd502f7e7ca"
zmediaGruenerDiamant_Icon.Name = _OCpG(",q!\021v\021q@\015tYtvV.\019'nv")
zmediaGruenerDiamant_Icon.Description = ""
zmediaGruenerDiamant_Icon.AltText = ""
zmediaGruenerDiamant_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "gruener_diamant_Icon.jpg",
    Directives = {}
  }
}
zmediaMaedchen_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaMaedchen_komplett.Id = "21d0d7db-00dd-4521-b60e-bec704521b7a"
zmediaMaedchen_komplett.Name = _OCpG("Tt\021\v'B\021v.)nYxk\021VV")
zmediaMaedchen_komplett.Description = ""
zmediaMaedchen_komplett.AltText = ""
zmediaMaedchen_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "JungeKirsche_komplett.JPG",
    Directives = {}
  }
}
zmediaWuerstelmann_nichtfertig = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaWuerstelmann_nichtfertig.Id = "38ece265-c6aa-470c-87bd-f980b9a5f134"
zmediaWuerstelmann_nichtfertig.Name = _OCpG("\003!\021qFV\021kYtvv.v\015'BV\023\021qV\015\014")
zmediaWuerstelmann_nichtfertig.Description = ""
zmediaWuerstelmann_nichtfertig.AltText = ""
zmediaWuerstelmann_nichtfertig.Resources = {
  {
    Type = "JPG",
    Filename = "wuestelmann_Ausschnitt_nichtfertig.JPG",
    Directives = {}
  }
}
zmediaGruenerDiamant_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGruenerDiamant_komplett.Id = "9771fdf6-1d31-4176-98ad-ec214f556544"
zmediaGruenerDiamant_komplett.Name = _OCpG(",q!\021v\021q@\015tYtvV.)nYxk\021VV")
zmediaGruenerDiamant_komplett.Description = ""
zmediaGruenerDiamant_komplett.AltText = ""
zmediaGruenerDiamant_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "gruener_diamant.jpg",
    Directives = {}
  }
}
zmediaDieb_nichtda = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDieb_nichtda.Id = "e5ae78e2-0958-49f0-9148-b15c9ded5320"
zmediaDieb_nichtda.Name = _OCpG("@\015\021\127.v\015'BV\vt")
zmediaDieb_nichtda.Description = ""
zmediaDieb_nichtda.AltText = ""
zmediaDieb_nichtda.Resources = {
  {
    Type = "JPG",
    Filename = "Dieb_Ausschnitt.JPG",
    Directives = {}
  }
}
zmedia2EUR_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmedia2EUR_komplett.Id = "8dbb6e6b-3cb5-464a-bc8e-ec7c5f55b716"
zmedia2EUR_komplett.Name = _OCpG("Pa%s.)nYxk\021VV")
zmedia2EUR_komplett.Description = ""
zmedia2EUR_komplett.AltText = ""
zmedia2EUR_komplett.Resources = {
  {
    Type = "gif",
    Filename = "2EUR_komplett.gif",
    Directives = {}
  }
}
zmediaWuerstelmann_Ausschnitt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaWuerstelmann_Ausschnitt.Id = "9f2732c0-cf2a-4cac-8869-9244c2cf8235"
zmediaWuerstelmann_Ausschnitt.Name = _OCpG("\003!\021qFV\021kYtvv.w!FF'Bv\015VV")
zmediaWuerstelmann_Ausschnitt.Description = ""
zmediaWuerstelmann_Ausschnitt.AltText = ""
zmediaWuerstelmann_Ausschnitt.Resources = {
  {
    Type = "JPG",
    Filename = "wuestelmann_Ausschnitt.JPG",
    Directives = {}
  }
}
zmediaBratwurst_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaBratwurst_komplett.Id = "c224011b-b982-49b3-8457-e0f93d319b00"
zmediaBratwurst_komplett.Name = _OCpG("$qtVb!qFV.)nYxk\021VV")
zmediaBratwurst_komplett.Description = ""
zmediaBratwurst_komplett.AltText = ""
zmediaBratwurst_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "Bratwurst_lomplett.jpg",
    Directives = {}
  }
}
zmediaParkschein_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaParkschein_Icon.Id = "7fa741fb-22d6-4e5b-a3c0-67582364d5b4"
zmediaParkschein_Icon.Name = _OCpG("6tq)F'B\021\015v.\019'nv")
zmediaParkschein_Icon.Description = ""
zmediaParkschein_Icon.AltText = ""
zmediaParkschein_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "parkschein_Icon.jpg",
    Directives = {}
  }
}
zmediaParkschein_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaParkschein_komplett.Id = "f6409ae6-b442-4cde-a747-7b7ec4e3ea88"
zmediaParkschein_komplett.Name = _OCpG("6tq)F'B\021\015v.)nYxk\021VV")
zmediaParkschein_komplett.Description = ""
zmediaParkschein_komplett.AltText = ""
zmediaParkschein_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "parkschein_komplett.jpg",
    Directives = {}
  }
}
zmediaBratwurst_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaBratwurst_Icon.Id = "e15800c2-322b-4e83-a8cd-52b6534c5ed8"
zmediaBratwurst_Icon.Name = _OCpG("$qtVb!qFV.\019'nv")
zmediaBratwurst_Icon.Description = ""
zmediaBratwurst_Icon.AltText = ""
zmediaBratwurst_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "Bratwurst_Icon.jpg",
    Directives = {}
  }
}
zmediaSanduhr_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaSanduhr_komplett.Id = "487ab054-23c5-43c0-897d-576ed1d91113"
zmediaSanduhr_komplett.Name = _OCpG("\024tv\v!Bq.)nYxk\021VV")
zmediaSanduhr_komplett.Description = ""
zmediaSanduhr_komplett.AltText = ""
zmediaSanduhr_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "Sanduhr_komplett.jpg",
    Directives = {}
  }
}
zmediaSanduhr_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaSanduhr_Icon.Id = "32dfc13d-70fb-442e-ad5d-d00ab06cbaed"
zmediaSanduhr_Icon.Name = _OCpG("\024tv\v!Bq.\019'nv")
zmediaSanduhr_Icon.Description = ""
zmediaSanduhr_Icon.AltText = ""
zmediaSanduhr_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "Sanduhr_Icon.jpg",
    Directives = {}
  }
}
zmediaGutschein_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGutschein_komplett.Id = "54f726d7-e908-4c81-90ac-8a34e73092c1"
zmediaGutschein_komplett.Name = _OCpG(",!VF'B\021\015v.)nYxk\021VV")
zmediaGutschein_komplett.Description = ""
zmediaGutschein_komplett.AltText = ""
zmediaGutschein_komplett.Resources = {
  {
    Type = "jpg",
    Filename = "Gutschein_lomplett.jpg",
    Directives = {}
  }
}
zmediaGutschein_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGutschein_Icon.Id = "66ffd193-291f-4937-af5a-ba03dbe18bec"
zmediaGutschein_Icon.Name = _OCpG(",!VF'B\021\015v.\019'nv")
zmediaGutschein_Icon.Description = ""
zmediaGutschein_Icon.AltText = ""
zmediaGutschein_Icon.Resources = {
  {
    Type = "jpg",
    Filename = "Gutschein_lcon.jpg",
    Directives = {}
  }
}
zmediaGruenerDiamant_klein = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGruenerDiamant_klein.Id = "6bde3dc7-e191-4129-8e71-b82e23222301"
zmediaGruenerDiamant_klein.Name = _OCpG(",q!\021v\021q@\015tYtvV.)k\021\015v")
zmediaGruenerDiamant_klein.Description = ""
zmediaGruenerDiamant_klein.AltText = ""
zmediaGruenerDiamant_klein.Resources = {
  {
    Type = "jpg",
    Filename = "gruener_diamant_klein.jpg",
    Directives = {}
  }
}
zmediaTaschentuecher_klein = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaTaschentuecher_klein.Id = "ec239e64-fbd2-4d35-94aa-bc4b84a5fcf5"
zmediaTaschentuecher_klein.Name = _OCpG("etF'B\021vV!\021'B\021q.)k\021\015v")
zmediaTaschentuecher_klein.Description = ""
zmediaTaschentuecher_klein.AltText = ""
zmediaTaschentuecher_klein.Resources = {
  {
    Type = "jpg",
    Filename = "taschentuecher_klein.jpg",
    Directives = {}
  }
}
zmediaDigicam_komplett = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDigicam_komplett.Id = "4a7654e7-6d43-40b5-808b-ec15e17443ba"
zmediaDigicam_komplett.Name = _OCpG("@\015\014\015'tY.)nYxk\021VV")
zmediaDigicam_komplett.Description = ""
zmediaDigicam_komplett.AltText = ""
zmediaDigicam_komplett.Resources = {
  {
    Type = "JPG",
    Filename = "Digicam_komplett.JPG",
    Directives = {}
  }
}
zmediaDigicam_Icon = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaDigicam_Icon.Id = "d722785a-c607-400a-af2f-88e299da7238"
zmediaDigicam_Icon.Name = _OCpG("@\015\014\015'tY.\019'nv")
zmediaDigicam_Icon.Description = ""
zmediaDigicam_Icon.AltText = ""
zmediaDigicam_Icon.Resources = {
  {
    Type = "JPG",
    Filename = "Digicam_Icon.JPG",
    Directives = {}
  }
}
zmediaGruenesGewoelbe = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaGruenesGewoelbe.Id = "22ef006c-c125-41cd-9930-8c2664674f5a"
zmediaGruenesGewoelbe.Name = _OCpG(",q!\021v\021F,\021bn\021k\127\021")
zmediaGruenesGewoelbe.Description = ""
zmediaGruenesGewoelbe.AltText = ""
zmediaGruenesGewoelbe.Resources = {
  {
    Type = "jpg",
    Filename = "GruenesGewoelbe.jpg",
    Directives = {}
  }
}
zmediaHofkirche = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaHofkirche.Id = "ea344de6-92e7-465c-975b-c378392ad788"
zmediaHofkirche.Name = _OCpG("4n\023)\015q'B\021")
zmediaHofkirche.Description = ""
zmediaHofkirche.AltText = ""
zmediaHofkirche.Resources = {
  {
    Type = "jpg",
    Filename = "Hofkirche_komplett.jpg",
    Directives = {}
  }
}
zmediaFuerstenzug = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaFuerstenzug.Id = "567999f4-2926-4557-bd0e-7dd71f36573c"
zmediaFuerstenzug.Name = _OCpG("-!\021qFV\021v\001!\014")
zmediaFuerstenzug.Description = ""
zmediaFuerstenzug.AltText = ""
zmediaFuerstenzug.Resources = {
  {
    Type = "jpg",
    Filename = "Fuerstenzug.jpg",
    Directives = {}
  }
}
zmediaFrauenkirche = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaFrauenkirche.Id = "10e3e606-3913-4982-b06e-ba13403b1b86"
zmediaFrauenkirche.Name = _OCpG("-qt!\021v)\015q'B\021")
zmediaFrauenkirche.Description = ""
zmediaFrauenkirche.AltText = ""
zmediaFrauenkirche.Resources = {
  {
    Type = "jpg",
    Filename = "Frauenkirche.jpg",
    Directives = {}
  }
}
zmediaKulturpalast = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaKulturpalast.Id = "46c80459-cdcd-4d17-9bd5-717c9eb37a85"
zmediaKulturpalast.Name = _OCpG("\005!kV!qxtktFV")
zmediaKulturpalast.Description = ""
zmediaKulturpalast.AltText = ""
zmediaKulturpalast.Resources = {
  {
    Type = "jpg",
    Filename = "Kulturpalast.jpg",
    Directives = {}
  }
}
zmediaAltmarkt = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaAltmarkt.Id = "1b1cb99a-185e-4cf1-ab47-c1cf11884db0"
zmediaAltmarkt.Name = _OCpG("wkVYtq)V")
zmediaAltmarkt.Description = ""
zmediaAltmarkt.AltText = ""
zmediaAltmarkt.Resources = {
  {
    Type = "jpg",
    Filename = "Altmarkt.jpg",
    Directives = {}
  }
}
zmediaAltmarktgalerie = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaAltmarktgalerie.Id = "d8c21717-16e6-4660-a457-2c756473ecda"
zmediaAltmarktgalerie.Name = _OCpG("wkVYtq)V\014tk\021q\015\021")
zmediaAltmarktgalerie.Description = ""
zmediaAltmarktgalerie.AltText = ""
zmediaAltmarktgalerie.Resources = {
  {
    Type = "jpg",
    Filename = "Altmarktgalerie.jpg",
    Directives = {}
  }
}
zmediaHilton = Wherigo.ZMedia(cartDerGrueneDiamant)
zmediaHilton.Id = "a4d60e18-edd5-4889-a8f3-77871ef5480b"
zmediaHilton.Name = _OCpG("4\015kVnv")
zmediaHilton.Description = ""
zmediaHilton.AltText = ""
zmediaHilton.Resources = {
  {
    Type = "jpg",
    Filename = "Hilton.jpg",
    Directives = {}
  }
}
cartDerGrueneDiamant.Id = "1c75c67d-2ea5-4e73-91b5-19f38d6b127d"
cartDerGrueneDiamant.Name = "Die Jagd nach dem Gr\195\188nen Diamanten"
cartDerGrueneDiamant.Description = "Die Strecke verl\195\164uft durch die Innenstadt und ist f\195\188r Touristen sehr zu empfehlen! Ihr seht und erhaltet Informationen u.a. zu folgenden Sehensw\195\188rdigkeiten:<BR>\nFrauenkirche, Striezelmarkt, Residenzschloss, Semperoper, Zwinger, Hofkirche, F\195\188rstenzug, Kulturpalast usw... Max. 45 Minuten werdet ihr brauchen.<BR>\n<BR>\nIn diesem Sinn: Viel Spass beim Jagen!<BR>\n<BR>\nEuer *Nathus*"
cartDerGrueneDiamant.Visible = true
cartDerGrueneDiamant.Activity = "Geocache"
cartDerGrueneDiamant.StartingLocationDescription = "Historisches und Neues Gruenes Gewoelbe. Weltberuehmte Kunstschaetze."
cartDerGrueneDiamant.StartingLocation = ZonePoint(51.052667, 13.737, 0)
cartDerGrueneDiamant.Version = "1.6"
cartDerGrueneDiamant.Company = ""
cartDerGrueneDiamant.Author = "Nathus"
cartDerGrueneDiamant.BuilderVersion = "URWIGO 1.15.4973.39887"
cartDerGrueneDiamant.CreateDate = "10/19/2010 21:48:39"
cartDerGrueneDiamant.PublishDate = "1/1/0001 12:00:00 AM"
cartDerGrueneDiamant.UpdateDate = "12/18/2013 11:36:36"
cartDerGrueneDiamant.LastPlayedDate = "1/1/0001 12:00:00 AM"
cartDerGrueneDiamant.TargetDevice = "PocketPC"
cartDerGrueneDiamant.TargetDeviceVersion = "0"
cartDerGrueneDiamant.StateId = "1"
cartDerGrueneDiamant.CountryId = "2"
cartDerGrueneDiamant.Complete = false
cartDerGrueneDiamant.UseLogging = true
cartDerGrueneDiamant.Media = zmediaGruenerDiamant_komplett
cartDerGrueneDiamant.Icon = zmediaGruenerDiamant_Icon
zoneGruenesGewoelbe = Wherigo.Zone(cartDerGrueneDiamant)
zoneGruenesGewoelbe.Id = "195ab59b-1f5f-4549-8321-f66b7ad9a163"
zoneGruenesGewoelbe.Name = _OCpG(",q!\021v\021FM,\021bn\021k\127\021")
zoneGruenesGewoelbe.Description = _OCpG("4\015FVnq\015F'B\021FM!v\vM1\021!\021FM,q!\021v\021FM,\021bn\021k\127\021=M\003\021kV\127\021q!\021BYV\021M\005!vFVF'Bt\021V\001\021=")
zoneGruenesGewoelbe.Visible = false
zoneGruenesGewoelbe.Media = zmediaGruenesGewoelbe
zoneGruenesGewoelbe.Commands = {}
zoneGruenesGewoelbe.DistanceRange = Distance(-1, "feet")
zoneGruenesGewoelbe.ShowObjects = "OnEnter"
zoneGruenesGewoelbe.ProximityRange = Distance(200, "feet")
zoneGruenesGewoelbe.AllowSetPositionTo = false
zoneGruenesGewoelbe.Active = false
zoneGruenesGewoelbe.Points = {
  ZonePoint(51.0526195650748, 13.7359118368054, 0),
  ZonePoint(51.0525647682948, 13.7366082797623, 0),
  ZonePoint(51.0519622075964, 13.7365881631947, 0),
  ZonePoint(51.0521190125574, 13.7355993594551, 0)
}
zoneGruenesGewoelbe.OriginalPoint = ZonePoint(51.05225, 13.73625, 0)
zoneGruenesGewoelbe.DistanceRangeUOM = "Feet"
zoneGruenesGewoelbe.ProximityRangeUOM = "Feet"
zoneGruenesGewoelbe.OutOfRangeName = ""
zoneGruenesGewoelbe.InRangeName = ""
zoneHofkirche = Wherigo.Zone(cartDerGrueneDiamant)
zoneHofkirche.Id = "d0fa7970-ec9c-427f-98d4-a7e1236e636e"
zoneHofkirche.Name = _OCpG("4n\023)\015q'B\021")
zoneHofkirche.Description = _OCpG("\005tVBnk\015F'B\021M4n\023)\015q'B\021")
zoneHofkirche.Visible = false
zoneHofkirche.Media = zmediaHofkirche
zoneHofkirche.Commands = {}
zoneHofkirche.DistanceRange = Distance(-1, "feet")
zoneHofkirche.ShowObjects = "OnEnter"
zoneHofkirche.ProximityRange = Distance(200, "feet")
zoneHofkirche.AllowSetPositionTo = false
zoneHofkirche.Active = false
zoneHofkirche.Points = {
  ZonePoint(51.0538940683243, 13.7377765889549, 0),
  ZonePoint(51.0538148259102, 13.7384873754977, 0),
  ZonePoint(51.0534819483873, 13.7384203202723, 0),
  ZonePoint(51.0533647696841, 13.7378127987766, 0)
}
zoneHofkirche.OriginalPoint = ZonePoint(51.05368, 13.73802, 0)
zoneHofkirche.DistanceRangeUOM = "Feet"
zoneHofkirche.ProximityRangeUOM = "Feet"
zoneHofkirche.OutOfRangeName = ""
zoneHofkirche.InRangeName = ""
zoneFuerstenzug = Wherigo.Zone(cartDerGrueneDiamant)
zoneFuerstenzug.Id = "932fce5d-bedf-4f2e-b943-813158e031e6"
zoneFuerstenzug.Name = _OCpG("-!\021qFV\021v\001!\014")
zoneFuerstenzug.Description = _OCpG("4\015FVnq\015F'B\021FM,qt\023\023\015V\015")
zoneFuerstenzug.Visible = false
zoneFuerstenzug.Media = zmediaFuerstenzug
zoneFuerstenzug.Commands = {}
zoneFuerstenzug.DistanceRange = Distance(-1, "feet")
zoneFuerstenzug.ShowObjects = "OnEnter"
zoneFuerstenzug.ProximityRange = Distance(200, "feet")
zoneFuerstenzug.AllowSetPositionTo = false
zoneFuerstenzug.Active = false
zoneFuerstenzug.Points = {
  ZonePoint(51.0527980234974, 13.7379852281723, 0),
  ZonePoint(51.053233371003, 13.7388459153442, 0),
  ZonePoint(51.0528447907464, 13.7398407080041, 0),
  ZonePoint(51.05223026503, 13.739537953373, 0)
}
zoneFuerstenzug.OriginalPoint = ZonePoint(51.05279, 13.739009, 0)
zoneFuerstenzug.DistanceRangeUOM = "Feet"
zoneFuerstenzug.ProximityRangeUOM = "Feet"
zoneFuerstenzug.OutOfRangeName = ""
zoneFuerstenzug.InRangeName = ""
zoneHiltonHotel = Wherigo.Zone(cartDerGrueneDiamant)
zoneHiltonHotel.Id = "2c3a9da1-b02c-430a-b26a-a38f81de65c7"
zoneHiltonHotel.Name = _OCpG("4\015kVnvM4nV\021k")
zoneHiltonHotel.Description = ""
zoneHiltonHotel.Visible = false
zoneHiltonHotel.Media = zmediaHilton
zoneHiltonHotel.Commands = {}
zoneHiltonHotel.DistanceRange = Distance(-1, "feet")
zoneHiltonHotel.ShowObjects = "OnEnter"
zoneHiltonHotel.ProximityRange = Distance(200, "feet")
zoneHiltonHotel.AllowSetPositionTo = false
zoneHiltonHotel.Active = false
zoneHiltonHotel.Points = {
  ZonePoint(51.0527265415704, 13.7404227987766, 0),
  ZonePoint(51.0525950294934, 13.7411537018871, 0),
  ZonePoint(51.0520799397089, 13.7408734110451, 0),
  ZonePoint(51.0522156684202, 13.7401854232788, 0)
}
zoneHiltonHotel.OriginalPoint = ZonePoint(51.052377, 13.740627, 0)
zoneHiltonHotel.DistanceRangeUOM = "Feet"
zoneHiltonHotel.ProximityRangeUOM = "Feet"
zoneHiltonHotel.OutOfRangeName = ""
zoneHiltonHotel.InRangeName = ""
zoneFrauenkirche = Wherigo.Zone(cartDerGrueneDiamant)
zoneFrauenkirche.Id = "f94d27a8-74b3-4713-8e3f-ab71a653f6fa"
zoneFrauenkirche.Name = _OCpG("-qt!\021v)\015q'B\021")
zoneFrauenkirche.Description = _OCpG("@q\021F\v\021vFM\003tBq\001\021\015'B\021v")
zoneFrauenkirche.Visible = false
zoneFrauenkirche.Media = zmediaFrauenkirche
zoneFrauenkirche.Commands = {}
zoneFrauenkirche.DistanceRange = Distance(-1, "feet")
zoneFrauenkirche.ShowObjects = "OnEnter"
zoneFrauenkirche.ProximityRange = Distance(200, "feet")
zoneFrauenkirche.AllowSetPositionTo = false
zoneFrauenkirche.Active = false
zoneFrauenkirche.Points = {
  ZonePoint(51.0518236327476, 13.7412981631946, 0),
  ZonePoint(51.0517646198138, 13.7417823030758, 0),
  ZonePoint(51.0514679913227, 13.7416817202377, 0),
  ZonePoint(51.0514292111054, 13.7410969975185, 0)
}
zoneFrauenkirche.OriginalPoint = ZonePoint(51.05172, 13.7415, 0)
zoneFrauenkirche.DistanceRangeUOM = "Feet"
zoneFrauenkirche.ProximityRangeUOM = "Feet"
zoneFrauenkirche.OutOfRangeName = ""
zoneFrauenkirche.InRangeName = ""
zoneKulturpalast = Wherigo.Zone(cartDerGrueneDiamant)
zoneKulturpalast.Id = "fdac3ea3-c188-4ebc-b22e-6890b9e78103"
zoneKulturpalast.Name = _OCpG("\005!kV!qxtktFV")
zoneKulturpalast.Description = _OCpG("d\021qtvFVtkV!v\014\021vM2nvM6nxM\127\015FM\005ktFF\015)")
zoneKulturpalast.Visible = false
zoneKulturpalast.Media = zmediaKulturpalast
zoneKulturpalast.Commands = {}
zoneKulturpalast.DistanceRange = Distance(-1, "feet")
zoneKulturpalast.ShowObjects = "OnEnter"
zoneKulturpalast.ProximityRange = Distance(200, "feet")
zoneKulturpalast.AllowSetPositionTo = false
zoneKulturpalast.Active = false
zoneKulturpalast.Points = {
  ZonePoint(51.050813320382, 13.7377536159038, 0),
  ZonePoint(51.0506666277504, 13.7388975792027, 0),
  ZonePoint(51.0500764946502, 13.7388707571125, 0),
  ZonePoint(51.0502746164234, 13.7375081937789, 0)
}
zoneKulturpalast.OriginalPoint = ZonePoint(51.050525, 13.738277, 0)
zoneKulturpalast.DistanceRangeUOM = "Feet"
zoneKulturpalast.ProximityRangeUOM = "Feet"
zoneKulturpalast.OutOfRangeName = ""
zoneKulturpalast.InRangeName = ""
zoneAltmarktTiefgarage = Wherigo.Zone(cartDerGrueneDiamant)
zoneAltmarktTiefgarage.Id = "3670034f-8270-4457-b520-22e326db80f5"
zoneAltmarktTiefgarage.Name = _OCpG("wkVYtq)VMe\015\021\023\014tqt\014\021")
zoneAltmarktTiefgarage.Description = _OCpG("\019YM\024nYY\021qM\021VbtFM)tq\014CM\001!M\003\021\015Bvt'BV\021vMt\127\021qM\014\021Y!\021Vk\015'BCMb\021\015kM\024Vq\015\021\001\021kYtq)V=")
zoneAltmarktTiefgarage.Visible = false
zoneAltmarktTiefgarage.Media = zmediaAltmarkt
zoneAltmarktTiefgarage.Commands = {}
zoneAltmarktTiefgarage.DistanceRange = Distance(-1, "feet")
zoneAltmarktTiefgarage.ShowObjects = "OnEnter"
zoneAltmarktTiefgarage.ProximityRange = Distance(200, "feet")
zoneAltmarktTiefgarage.AllowSetPositionTo = false
zoneAltmarktTiefgarage.Active = false
zoneAltmarktTiefgarage.Points = {
  ZonePoint(51.0500324797217, 13.7373099717236, 0),
  ZonePoint(51.0498604923105, 13.7387842552948, 0),
  ZonePoint(51.0492891115987, 13.738636733799, 0),
  ZonePoint(51.0493725771871, 13.7372938784695, 0)
}
zoneAltmarktTiefgarage.OriginalPoint = ZonePoint(51.0497, 13.73797, 0)
zoneAltmarktTiefgarage.DistanceRangeUOM = "Feet"
zoneAltmarktTiefgarage.ProximityRangeUOM = "Feet"
zoneAltmarktTiefgarage.OutOfRangeName = ""
zoneAltmarktTiefgarage.InRangeName = ""
zoneAltmarktgalerie = Wherigo.Zone(cartDerGrueneDiamant)
zoneAltmarktgalerie.Id = "e64114f6-98dd-4edb-897c-7466da2f6898"
zoneAltmarktgalerie.Name = _OCpG("wkVYtq)V\014tk\021q\015\021")
zoneAltmarktgalerie.Description = _OCpG("a\015v\021qM\v\021qM\014qnFF\021vMa\015v)t!\023FV\021Yx\021kM\v\021qM\019vv\021vFVt\vV")
zoneAltmarktgalerie.Visible = false
zoneAltmarktgalerie.Media = zmediaAltmarktgalerie
zoneAltmarktgalerie.Commands = {}
zoneAltmarktgalerie.DistanceRange = Distance(-1, "feet")
zoneAltmarktgalerie.ShowObjects = "OnEnter"
zoneAltmarktgalerie.ProximityRange = Distance(200, "feet")
zoneAltmarktgalerie.AllowSetPositionTo = false
zoneAltmarktgalerie.Active = false
zoneAltmarktgalerie.Points = {
  ZonePoint(51.0487691327506, 13.7358138568293, 0),
  ZonePoint(51.0486224336443, 13.7358299500834, 0),
  ZonePoint(51.04857522004, 13.7361799783598, 0),
  ZonePoint(51.0488155030611, 13.7362363047491, 0)
}
zoneAltmarktgalerie.OriginalPoint = ZonePoint(51.04915, 13.73627, 0)
zoneAltmarktgalerie.DistanceRangeUOM = "Feet"
zoneAltmarktgalerie.ProximityRangeUOM = "Feet"
zoneAltmarktgalerie.OutOfRangeName = ""
zoneAltmarktgalerie.InRangeName = ""
zcharacterAlteFrau = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterAlteFrau.Id = "babe1b49-865f-45c9-b54a-0ec67a72be76"
zcharacterAlteFrau.Name = _OCpG("wkV\021M-qt!")
zcharacterAlteFrau.Description = ""
zcharacterAlteFrau.Visible = false
zcharacterAlteFrau.Media = zmediaAlteFrau_komplett
zcharacterAlteFrau.Icon = zmediaAlteFrau_Icon
zcharacterAlteFrau.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterAlteFrau.Commands.Sprechen.Custom = true
zcharacterAlteFrau.Commands.Sprechen.Id = "1cbf94fb-5092-46eb-843a-a29bb57bdddb"
zcharacterAlteFrau.Commands.Sprechen.WorksWithAll = true
zcharacterAlteFrau.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterAlteFrau.Gender = "Female"
zcharacterAlteFrau.Type = "NPC"
zcharacterPolizist = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterPolizist.Id = "eb3a22e6-e60a-4ee3-a446-8fc13904d62b"
zcharacterPolizist.Name = _OCpG("6nk\015\001\015FV")
zcharacterPolizist.Description = ""
zcharacterPolizist.Visible = false
zcharacterPolizist.Media = zmediaPolizist_komplett
zcharacterPolizist.Icon = zmediaPolizist_Icon
zcharacterPolizist.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterPolizist.Commands.Sprechen.Custom = true
zcharacterPolizist.Commands.Sprechen.Id = "6122ac92-533b-4dc8-9e3f-e41337daa32e"
zcharacterPolizist.Commands.Sprechen.WorksWithAll = true
zcharacterPolizist.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterPolizist.Gender = "Male"
zcharacterPolizist.Type = "NPC"
zcharacterJournalist = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterJournalist.Id = "39cd83ad-0afc-4111-beaa-f9f4978afc1e"
zcharacterJournalist.Name = _OCpG("\030n!qvtk\015FV")
zcharacterJournalist.Description = ""
zcharacterJournalist.Visible = false
zcharacterJournalist.Media = zmediaReporter_komplett
zcharacterJournalist.Icon = zmediaReporter_Icon
zcharacterJournalist.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterJournalist.Commands.Sprechen.Custom = true
zcharacterJournalist.Commands.Sprechen.Id = "0d4bdf34-d231-422d-8b22-0dbd3460faba"
zcharacterJournalist.Commands.Sprechen.WorksWithAll = true
zcharacterJournalist.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterJournalist.Gender = "Male"
zcharacterJournalist.Type = "NPC"
zcharacterNetterHerr = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterNetterHerr.Id = "60b4a332-6834-42d1-aab4-8c9a05b1dab4"
zcharacterNetterHerr.Name = _OCpG("1\021VV\021qM4\021qq")
zcharacterNetterHerr.Description = ""
zcharacterNetterHerr.Visible = false
zcharacterNetterHerr.Media = zmediaNetterHerr_komplett
zcharacterNetterHerr.Icon = zmediaNetterHerr_Icon
zcharacterNetterHerr.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterNetterHerr.Commands.Sprechen.Custom = true
zcharacterNetterHerr.Commands.Sprechen.Id = "5329609c-0ad9-4b4b-b9de-690e7d211733"
zcharacterNetterHerr.Commands.Sprechen.WorksWithAll = true
zcharacterNetterHerr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterNetterHerr.Gender = "Male"
zcharacterNetterHerr.Type = "NPC"
zcharacterBettler = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterBettler.Id = "a806bd66-22b0-4d64-80c0-c40ffc18f4cb"
zcharacterBettler.Name = _OCpG("$\021VVk\021q")
zcharacterBettler.Description = ""
zcharacterBettler.Visible = false
zcharacterBettler.Media = zmediaBettler_komplett
zcharacterBettler.Icon = zmediaBettler_Icon
zcharacterBettler.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterBettler.Commands.Sprechen.Custom = true
zcharacterBettler.Commands.Sprechen.Id = "c9b28872-3ff8-46c5-8d9f-1d004cbf0f35"
zcharacterBettler.Commands.Sprechen.WorksWithAll = true
zcharacterBettler.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterBettler.Gender = "Male"
zcharacterBettler.Type = "NPC"
zcharacterOrdnerin = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterOrdnerin.Id = "e56a243f-dba6-4c34-8398-738d1ab55d9f"
zcharacterOrdnerin.Name = _OCpG("{q\vv\021q\015v")
zcharacterOrdnerin.Description = ""
zcharacterOrdnerin.Visible = false
zcharacterOrdnerin.Media = zmediaOrdnerin_komplett
zcharacterOrdnerin.Icon = zmediaOrdnerin_Icon
zcharacterOrdnerin.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterOrdnerin.Commands.Sprechen.Custom = true
zcharacterOrdnerin.Commands.Sprechen.Id = "c42b89e4-9a76-46f1-a22f-f4a9f3e2bc45"
zcharacterOrdnerin.Commands.Sprechen.WorksWithAll = true
zcharacterOrdnerin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterOrdnerin.Gender = "Female"
zcharacterOrdnerin.Type = "NPC"
zcharacterDrehorgelspieler = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterDrehorgelspieler.Id = "228d8708-ff51-4bc8-afbe-cc18a0a65732"
zcharacterDrehorgelspieler.Name = _OCpG("@q\021Bnq\014\021kFx\015\021k\021q")
zcharacterDrehorgelspieler.Description = ""
zcharacterDrehorgelspieler.Visible = false
zcharacterDrehorgelspieler.Media = zmediaDrehorgelspieler_komplett
zcharacterDrehorgelspieler.Icon = zmediaDrehorgelspieler_Icon
zcharacterDrehorgelspieler.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterDrehorgelspieler.Commands.Sprechen.Custom = true
zcharacterDrehorgelspieler.Commands.Sprechen.Id = "ebe885d2-3934-47a4-b0c4-1f6b8e75f224"
zcharacterDrehorgelspieler.Commands.Sprechen.WorksWithAll = true
zcharacterDrehorgelspieler.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterDrehorgelspieler.Gender = "Male"
zcharacterDrehorgelspieler.Type = "NPC"
zcharacterGeigespielenderJunge = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterGeigespielenderJunge.Id = "2b21273f-c486-4e18-ba91-6ba85e9678af"
zcharacterGeigespielenderJunge.Name = _OCpG(",\021\015\014\021Fx\015\021k\021v\v\021qM\030!v\014\021")
zcharacterGeigespielenderJunge.Description = ""
zcharacterGeigespielenderJunge.Visible = false
zcharacterGeigespielenderJunge.Media = zmediaJungerGeiger_komplett
zcharacterGeigespielenderJunge.Icon = zmediaJungerGeiger_Icon
zcharacterGeigespielenderJunge.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterGeigespielenderJunge.Commands.Sprechen.Custom = true
zcharacterGeigespielenderJunge.Commands.Sprechen.Id = "5047497e-ab14-4a2c-910e-dd13daf166f7"
zcharacterGeigespielenderJunge.Commands.Sprechen.WorksWithAll = true
zcharacterGeigespielenderJunge.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterGeigespielenderJunge.Gender = "Male"
zcharacterGeigespielenderJunge.Type = "NPC"
zcharacterWuerstchenverkaufer = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterWuerstchenverkaufer.Id = "f8d7245c-01c9-4e4b-8670-7c25f427e6a9"
zcharacterWuerstchenverkaufer.Name = _OCpG("\003!\021qFV'B\021v2\021q)t!\023\021q")
zcharacterWuerstchenverkaufer.Description = ""
zcharacterWuerstchenverkaufer.Visible = false
zcharacterWuerstchenverkaufer.Media = zmediaWuerstelmann_komplett
zcharacterWuerstchenverkaufer.Icon = zmediaWuerstelmann_Icon
zcharacterWuerstchenverkaufer.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterWuerstchenverkaufer.Commands.Sprechen.Custom = true
zcharacterWuerstchenverkaufer.Commands.Sprechen.Id = "f6df8d7f-8c65-4734-a3ff-ec3a56e321ab"
zcharacterWuerstchenverkaufer.Commands.Sprechen.WorksWithAll = true
zcharacterWuerstchenverkaufer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterWuerstchenverkaufer.Gender = "Male"
zcharacterWuerstchenverkaufer.Type = "NPC"
zcharacterMarktfrau = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterMarktfrau.Id = "0346c73d-dfe7-432c-ba8e-f131c46a8b7a"
zcharacterMarktfrau.Name = _OCpG("Ttq)V\023qt!")
zcharacterMarktfrau.Description = ""
zcharacterMarktfrau.Visible = false
zcharacterMarktfrau.Media = zmediaMarktfrau_komplett
zcharacterMarktfrau.Icon = zmediaMarktfrau_Icon
zcharacterMarktfrau.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterMarktfrau.Commands.Sprechen.Custom = true
zcharacterMarktfrau.Commands.Sprechen.Id = "5c5dfe14-f77f-4e3b-8b37-1ba8810af8f4"
zcharacterMarktfrau.Commands.Sprechen.WorksWithAll = true
zcharacterMarktfrau.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterMarktfrau.Gender = "Male"
zcharacterMarktfrau.Type = "NPC"
zcharacterMaedchen = Wherigo.ZCharacter(cartDerGrueneDiamant)
zcharacterMaedchen.Id = "6900337c-2891-46d8-9d0a-fa9843556251"
zcharacterMaedchen.Name = _OCpG("Tt\021\v'B\021v")
zcharacterMaedchen.Description = ""
zcharacterMaedchen.Visible = false
zcharacterMaedchen.Media = zmediaMaedchen_komplett
zcharacterMaedchen.Icon = zmediaMaedchen_Icon
zcharacterMaedchen.Commands = {
  Sprechen = Wherigo.ZCommand({
    Text = _OCpG("\024xq\021'B\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zcharacterMaedchen.Commands.Sprechen.Custom = true
zcharacterMaedchen.Commands.Sprechen.Id = "72ac5012-b206-42ab-9643-d69ca470fb6b"
zcharacterMaedchen.Commands.Sprechen.WorksWithAll = true
zcharacterMaedchen.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zcharacterMaedchen.Gender = "Male"
zcharacterMaedchen.Type = "NPC"
zitemTaschentuecher = Wherigo.ZItem(cartDerGrueneDiamant)
zitemTaschentuecher.Id = "77826de0-5ab1-487c-90c5-24546e9bfa60"
zitemTaschentuecher.Name = _OCpG("etF'B\021vV!\021'B\021q")
zitemTaschentuecher.Description = _OCpG("1\021!M!v\vM2\021qF'BknFF\021v")
zitemTaschentuecher.Visible = false
zitemTaschentuecher.Media = zmediaTaschentuecher_komplett
zitemTaschentuecher.Icon = zmediaTaschentuecher_Icon
zitemTaschentuecher.Commands = {
  Geben = Wherigo.ZCommand({
    Text = _OCpG("1\021VV\021YM4\021qqvM,\021\127\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
zitemTaschentuecher.Commands.Geben.Custom = true
zitemTaschentuecher.Commands.Geben.Id = "6eb0d59f-662b-4fcf-8d56-eb5206881550"
zitemTaschentuecher.Commands.Geben.WorksWithAll = true
zitemTaschentuecher.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemTaschentuecher.Locked = false
zitemTaschentuecher.Opened = false
zitem2Euro = Wherigo.ZItem(cartDerGrueneDiamant)
zitem2Euro.Id = "e4c761f4-d771-4aea-973a-a74fd21caf3a"
zitem2Euro.Name = _OCpG("PMa!qn")
zitem2Euro.Description = ""
zitem2Euro.Visible = false
zitem2Euro.Media = zmediaEuro_komplett
zitem2Euro.Icon = zmedia2EUR_Icon
zitem2Euro.Commands = {
  Geben = Wherigo.ZCommand({
    Text = _OCpG(",\021\127\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _OCpG("1\021\021=M$\021BtkVM\015'BMYtkMk\015\021\127\021q=")
  }),
  Nehmen = Wherigo.ZCommand({
    Text = _OCpG("1\021BY\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zitem2Euro.Commands.Geben.Custom = true
zitem2Euro.Commands.Geben.Id = "ecaa6200-bb75-4064-b369-c00d62941984"
zitem2Euro.Commands.Geben.WorksWithAll = true
zitem2Euro.Commands.Nehmen.Custom = true
zitem2Euro.Commands.Nehmen.Id = "9111ef21-e80e-4e4d-bea9-78a1afd886f9"
zitem2Euro.Commands.Nehmen.WorksWithAll = true
zitem2Euro.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitem2Euro.Locked = false
zitem2Euro.Opened = false
zitemParkzettel = Wherigo.ZItem(cartDerGrueneDiamant)
zitemParkzettel.Id = "88e74e26-d205-4e5b-8a24-9bf557c92077"
zitemParkzettel.Name = _OCpG("6tq)\001\021VV\021k")
zitemParkzettel.Description = ""
zitemParkzettel.Visible = false
zitemParkzettel.Media = zmediaParkschein_komplett
zitemParkzettel.Icon = zmediaParkschein_Icon
zitemParkzettel.Commands = {
  Nehmen = Wherigo.ZCommand({
    Text = _OCpG("1\021BY\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1\021\021CM\015'BMv\021BYMv\015'BVFM2nvM\023q\021Y\v\021YM_\021!V\021v===")
  }),
  Zeigen = Wherigo.ZCommand({
    Text = _OCpG("\t\021\015\014\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
zitemParkzettel.Commands.Nehmen.Custom = true
zitemParkzettel.Commands.Nehmen.Id = "0c9b0181-4717-43fb-9e3a-47d6586269e6"
zitemParkzettel.Commands.Nehmen.WorksWithAll = true
zitemParkzettel.Commands.Zeigen.Custom = true
zitemParkzettel.Commands.Zeigen.Id = "dc62a173-ad5f-4f12-9d1a-f79144c765e8"
zitemParkzettel.Commands.Zeigen.WorksWithAll = true
zitemParkzettel.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemParkzettel.Locked = false
zitemParkzettel.Opened = false
zitemWurstgutschein = Wherigo.ZItem(cartDerGrueneDiamant)
zitemWurstgutschein.Id = "e7eda55e-f299-4f5e-9bdd-5d93c5c49fb9"
zitemWurstgutschein.Name = _OCpG("\003!qFV\014!VF'B\021\015v")
zitemWurstgutschein.Description = _OCpG(",!VF'B\021\015vM\023!\021qM\021\015v\021M$qtVb!qFV")
zitemWurstgutschein.Visible = false
zitemWurstgutschein.Media = zmediaGutschein_komplett
zitemWurstgutschein.Icon = zmediaGutschein_Icon
zitemWurstgutschein.Commands = {
  Geben = Wherigo.ZCommand({
    Text = _OCpG(",\021\127\021vMtvM\003!qFVBt\021v\vk\021q"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("\003\021vMn\v\021qM\003tFG")
  }),
  _dSEW = Wherigo.ZCommand({
    Text = _OCpG(",\021\127\021vMtvM\030!v\014\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _OCpG("1\015'BVM2\021q\023!\014\127tq")
  })
}
zitemWurstgutschein.Commands.Geben.Custom = true
zitemWurstgutschein.Commands.Geben.Id = "2e714869-aadd-4659-a771-3cee8d08c5e9"
zitemWurstgutschein.Commands.Geben.WorksWithAll = true
zitemWurstgutschein.Commands._dSEW.Custom = true
zitemWurstgutschein.Commands._dSEW.Id = "91dce7fe-3fa2-42b1-a25c-7c61d035ab50"
zitemWurstgutschein.Commands._dSEW.WorksWithAll = true
zitemWurstgutschein.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemWurstgutschein.Locked = false
zitemWurstgutschein.Opened = false
zitemBratwurst = Wherigo.ZItem(cartDerGrueneDiamant)
zitemBratwurst.Id = "b52cc44f-255e-4c79-b6c5-755e4478e963"
zitemBratwurst.Name = _OCpG("$qtVb!qFV")
zitemBratwurst.Description = _OCpG("_\021')\021qM\003!qFV=")
zitemBratwurst.Visible = false
zitemBratwurst.Media = zmediaBratwurst_komplett
zitemBratwurst.Icon = zmediaBratwurst_Icon
zitemBratwurst.Commands = {
  Geben = Wherigo.ZCommand({
    Text = _OCpG(",\021\127\021vMtvM\030!v\014\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _OCpG("wvMb\021vG")
  }),
  Verzehren = Wherigo.ZCommand({
    Text = _OCpG("d\021q\001\021Bq\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zitemBratwurst.Commands.Geben.Custom = true
zitemBratwurst.Commands.Geben.Id = "8ac577c9-3e4c-41f9-ab40-5a8dab2ebdad"
zitemBratwurst.Commands.Geben.WorksWithAll = true
zitemBratwurst.Commands.Verzehren.Custom = true
zitemBratwurst.Commands.Verzehren.Id = "a9d8ee75-2e43-478f-9bfc-c563489e199e"
zitemBratwurst.Commands.Verzehren.WorksWithAll = true
zitemBratwurst.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemBratwurst.Locked = false
zitemBratwurst.Opened = false
zitemSanduhr = Wherigo.ZItem(cartDerGrueneDiamant)
zitemSanduhr.Id = "7397a751-1852-4c5d-9af9-575887641ac3"
zitemSanduhr.Name = _OCpG("\024tv\v!Bq")
zitemSanduhr.Description = _OCpG("\t\021\015\014VM\v\015\021M\t\021\015VMtvCM\v\015\021Mt\127\014\021kt!\023\021vM\015FV=")
zitemSanduhr.Visible = false
zitemSanduhr.Media = zmediaSanduhr_komplett
zitemSanduhr.Icon = zmediaSanduhr_Icon
zitemSanduhr.Commands = {
  Angucken = Wherigo.ZCommand({
    Text = _OCpG("wv\014!')\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zitemSanduhr.Commands.Angucken.Custom = true
zitemSanduhr.Commands.Angucken.Id = "a7ae867b-9350-428b-a96c-beb2a2aa53a1"
zitemSanduhr.Commands.Angucken.WorksWithAll = true
zitemSanduhr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemSanduhr.Locked = false
zitemSanduhr.Opened = false
zitemDigitalkamera = Wherigo.ZItem(cartDerGrueneDiamant)
zitemDigitalkamera.Id = "7f9d3135-fa66-4717-872b-f024742b89cc"
zitemDigitalkamera.Name = _OCpG("@\015\014\015Vtk)tY\021qt")
zitemDigitalkamera.Description = ""
zitemDigitalkamera.Visible = false
zitemDigitalkamera.Media = zmediaDigicam_komplett
zitemDigitalkamera.Icon = zmediaDigicam_Icon
zitemDigitalkamera.Commands = {
  Anschalten = Wherigo.ZCommand({
    Text = _OCpG("wvF'BtkV\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  }),
  Nehmen = Wherigo.ZCommand({
    Text = _OCpG("1\021BY\021v"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  }),
  Bilderanschauen = Wherigo.ZCommand({
    Text = _OCpG("$\015k\v\021qMtvF'Bt!\021v"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zitemDigitalkamera.Commands.Anschalten.Custom = true
zitemDigitalkamera.Commands.Anschalten.Id = "640947a2-d97d-4d59-a80a-c1a81153efb6"
zitemDigitalkamera.Commands.Anschalten.WorksWithAll = true
zitemDigitalkamera.Commands.Nehmen.Custom = true
zitemDigitalkamera.Commands.Nehmen.Id = "e2bb291b-28d5-4ea6-923c-ddaf0bfa1d5a"
zitemDigitalkamera.Commands.Nehmen.WorksWithAll = true
zitemDigitalkamera.Commands.Bilderanschauen.Custom = true
zitemDigitalkamera.Commands.Bilderanschauen.Id = "c6295d55-5b1f-4f73-afd1-be142484a46c"
zitemDigitalkamera.Commands.Bilderanschauen.WorksWithAll = true
zitemDigitalkamera.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDigitalkamera.Locked = false
zitemDigitalkamera.Opened = false
zitemDerGrueneDiamant = Wherigo.ZItem(cartDerGrueneDiamant)
zitemDerGrueneDiamant.Id = "8ebc3f14-49a4-44a7-bb80-0da4bc9ec6bc"
zitemDerGrueneDiamant.Name = _OCpG("@\021qM,q!\021v\021M@\015tYtvV")
zitemDerGrueneDiamant.Description = ""
zitemDerGrueneDiamant.Visible = false
zitemDerGrueneDiamant.Media = zmediaGruenerDiamant_komplett
zitemDerGrueneDiamant.Icon = zmediaGruenerDiamant_Icon
zitemDerGrueneDiamant.Commands = {
  GEFUNDEN = Wherigo.ZCommand({
    Text = _OCpG("@\015tYtvV\016mt'B\021M\014\021\023!v\v\021vG"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _OCpG("1nVB\015v\014Mt2t\015kt\127k\021")
  })
}
zitemDerGrueneDiamant.Commands.GEFUNDEN.Custom = true
zitemDerGrueneDiamant.Commands.GEFUNDEN.Id = "273228b8-3a0a-4fea-b702-73ba4345eb55"
zitemDerGrueneDiamant.Commands.GEFUNDEN.WorksWithAll = true
zitemDerGrueneDiamant.ObjectLocation = Wherigo.INVALID_ZONEPOINT
zitemDerGrueneDiamant.Locked = false
zitemDerGrueneDiamant.Opened = false
ztaskGehezurHofkirche = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskGehezurHofkirche.Id = "54353f8e-418a-49c4-ab3b-908162294353"
ztaskGehezurHofkirche.Name = _OCpG(",\021B\021M\001!qM4n\023)\015q'B\021")
ztaskGehezurHofkirche.Description = _OCpG("@\021\015v\021M1\021!\014\015\021qM\015FVM\014\021b\021')V=M_nFM\014\021BVuFCMs\015'BV!v\014Mw!\014!FV!F\127q!\021')\021M\001!YMa\015v\014tv\014M\v\021qM)tVBnk\015F'B\021vM4n\023)\015q'B\021=")
ztaskGehezurHofkirche.Visible = true
ztaskGehezurHofkirche.Active = false
ztaskGehezurHofkirche.Complete = false
ztaskGehezurHofkirche.CorrectState = "None"
ztaskGehezumFuerstenzug = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskGehezumFuerstenzug.Id = "3705f54a-92f5-48e4-8114-9709f36f3947"
ztaskGehezumFuerstenzug.Name = _OCpG(",\021B\021M\001!YM-!\021qFV\021v\001!\014")
ztaskGehezumFuerstenzug.Description = _OCpG("\030\021V\001VM\014\021BVuFMk\015v)FM\015vM\v\015\021M)k\021\015v\021M,tFF\021Mq\021\015v=")
ztaskGehezumFuerstenzug.Visible = true
ztaskGehezumFuerstenzug.Active = false
ztaskGehezumFuerstenzug.Complete = false
ztaskGehezumFuerstenzug.CorrectState = "None"
ztaskZumHiltonHotel = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskZumHiltonHotel.Id = "e007f15f-da2a-4d3a-84f9-aee21c36d2c7"
ztaskZumHiltonHotel.Name = _OCpG("\t!YM4\015kVnvM4nV\021k")
ztaskZumHiltonHotel.Description = _OCpG("\003\021\015V\021qMv!vM\001!YM4\015kVnv=")
ztaskZumHiltonHotel.Visible = true
ztaskZumHiltonHotel.Active = false
ztaskZumHiltonHotel.Complete = false
ztaskZumHiltonHotel.CorrectState = "None"
ztaskZurFrauenkirche = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskZurFrauenkirche.Id = "68ce711e-6d57-48ad-8bc2-670d45081055"
ztaskZurFrauenkirche.Name = _OCpG("\t!qM-qt!\021v)\015q'B\021")
ztaskZurFrauenkirche.Description = _OCpG("1\015'BVM\001!M2\021q\023\021Bk\021v=Mw\127Fnk!V\021qMen!q\015FV\021vYt\014v\021V=")
ztaskZurFrauenkirche.Visible = true
ztaskZurFrauenkirche.Active = false
ztaskZurFrauenkirche.Complete = false
ztaskZurFrauenkirche.CorrectState = "None"
ztaskZumKulturpalast = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskZumKulturpalast.Id = "a43dd2e0-e8bb-4d6f-a5ee-ffd4c3abbafb"
ztaskZumKulturpalast.Name = _OCpG("\t!YM\005!kV!qxtktFV")
ztaskZumKulturpalast.Description = _OCpG("\024x!V\021M\v\015'B;M@tvvM)q\015\021\014FVM\v!M\v\021vM@\015\021\127;")
ztaskZumKulturpalast.Visible = true
ztaskZumKulturpalast.Active = false
ztaskZumKulturpalast.Complete = false
ztaskZumKulturpalast.CorrectState = "None"
ztaskAltmarkt = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskAltmarkt.Id = "76f34b6e-29a7-42c8-b362-fa812d6d15e4"
ztaskAltmarkt.Name = _OCpG("wkVYtq)V")
ztaskAltmarkt.Description = _OCpG("@\021qM@\015\021\127M\015FVMb\021\014CMt\127\021qMbnM\015FVM\v\021qM,q!\021v\021M@\015tYtvVG")
ztaskAltmarkt.Visible = true
ztaskAltmarkt.Active = false
ztaskAltmarkt.Complete = false
ztaskAltmarkt.CorrectState = "None"
ztaskGruenesGewoelbe = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskGruenesGewoelbe.Id = "81875b39-e748-41f5-88b7-1f9cc2bab83a"
ztaskGruenesGewoelbe.Name = _OCpG(",q!\021v\021FM,\021bn\021k\127\021")
ztaskGruenesGewoelbe.Description = _OCpG("$\021\014\015\127M\v\015'BM\001!YMa\015v\014tv\014M\v\021FM,q!\021v\021vM,\021bn\021k\127\021F=")
ztaskGruenesGewoelbe.Visible = true
ztaskGruenesGewoelbe.Active = false
ztaskGruenesGewoelbe.Complete = false
ztaskGruenesGewoelbe.CorrectState = "None"
ztaskHofkircheangucken = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskHofkircheangucken.Id = "b5240557-1340-4033-baec-64c4e006f82b"
ztaskHofkircheangucken.Name = _OCpG("4n\023)\015q'B\021Mtv\014!')\021v")
ztaskHofkircheangucken.Description = _OCpG("@\021qMTtvvM\015FVM\014tv\001MF'Bn\021vMt!\023\014\021q\021\014V=M\003\015\021M)tvvM\015'BM\015BYM\127knFFMB\021k\023\021vG")
ztaskHofkircheangucken.Visible = true
ztaskHofkircheangucken.Active = false
ztaskHofkircheangucken.Complete = false
ztaskHofkircheangucken.CorrectState = "None"
ztaskFuerstenzuganschauen = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskFuerstenzuganschauen.Id = "da89ef31-7f6e-4b79-b549-67b14a425be8"
ztaskFuerstenzuganschauen.Name = _OCpG("-!\021qFV\021v\001!\014MtvF'Bt!\021v")
ztaskFuerstenzuganschauen.Description = _OCpG("dnqM\v\021YM-!\021qFV\021v\001!\014MFV\021BVM\021\015vM2\021q\001b\021\015\023\021kVMt!FF\021B\021v\v\021FMTt\021\v'B\021v=M\003tFMBtVMF\015\021Mv!qG")
ztaskFuerstenzuganschauen.Visible = true
ztaskFuerstenzuganschauen.Active = false
ztaskFuerstenzuganschauen.Complete = false
ztaskFuerstenzuganschauen.CorrectState = "None"
ztaskParkzettel = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskParkzettel.Id = "781b648d-2bd1-4200-a351-29aa62ccbb89"
ztaskParkzettel.Name = _OCpG("6tq)\001\021VV\021k")
ztaskParkzettel.Description = _OCpG("\003tFM\023tv\014\021M\015'BMY\015VM\v\021YM6tq)\001\021VV\021kMtvG")
ztaskParkzettel.Visible = true
ztaskParkzettel.Active = false
ztaskParkzettel.Complete = false
ztaskParkzettel.CorrectState = "None"
ztaskJungespieltGeige = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskJungespieltGeige.Id = "f773f106-b0b4-4f08-ab28-a44012a6e9ac"
ztaskJungespieltGeige.Name = _OCpG("\030!v\014\021MFx\015\021kVM,\021\015\014\021")
ztaskJungespieltGeige.Description = _OCpG("@\021qM\030!v\014\021MFx\015\021kVM\021'BVM\014!VCM\021\015vMt\127Fnk!V\021FM1tV!qVtk\021vV=M@\021vM_\021!V\021vMF'B\021\015vVM\021FM\001!M\014\021\023tkk\021v=M\024\015\021M\014\021\127\021vMnq\v\021vVk\015'BM,\021k\v=M4!v\014\021qMBtVM\v\021qM7!v\014\021MT!F\015)\021qMt!'B=")
ztaskJungespieltGeige.Visible = true
ztaskJungespieltGeige.Active = false
ztaskJungespieltGeige.Complete = false
ztaskJungespieltGeige.CorrectState = "None"
ztaskFrauenkircheangucken = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskFrauenkircheangucken.Id = "7e29ee58-9225-45de-b57a-30e010faae5d"
ztaskFrauenkircheangucken.Name = _OCpG("-qt!\021v)\015q'B\021Mtv\014!')\021v")
ztaskFrauenkircheangucken.Description = _OCpG(",\021qt\v\021MtkFM\v!M\v\015\021M-qt!\021v)\015q'B\021M\127\021Vq\021V\021vMb\015kkFVCMFxq\015'BVM\v\015'BM\021\015v\021MFVq\021v\014M\vq\021\015v\127k\015')\021v\v\021M{q\vv\021q\015vMtv===")
ztaskFrauenkircheangucken.Visible = true
ztaskFrauenkircheangucken.Active = false
ztaskFrauenkircheangucken.Complete = false
ztaskFrauenkircheangucken.CorrectState = "None"
ztaskGameOver = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskGameOver.Id = "1b701419-a482-4f71-bf49-2fcc260d8cbc"
ztaskGameOver.Name = _OCpG(",tY\021M{2\021q")
ztaskGameOver.Description = _OCpG("@tFMbtqMk\021\015\v\021qMv\015|=M@tFFM\v!Mt\127\021qMt!'BM\015YY\021qMv!qMtvMaFF\021vM\v\021v)\021vMY!FFV===Me7tCM6\021'BM\014\021Bt\127V=M@!MY!FFVM2nvM2nqvMtv\023tv\014\021vM\004\003\021qM)k!\014M\015FVCMBtVM\001b\015F'B\021v\v!q'BM\014\021Fx\021\015'B\021qV===r=")
ztaskGameOver.Visible = true
ztaskGameOver.Active = false
ztaskGameOver.Complete = false
ztaskGameOver.CorrectState = "None"
ztaskZurAltmarktgalerie = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskZurAltmarktgalerie.Id = "12cf628a-90ca-406f-b7b8-c19f286ff547"
ztaskZurAltmarktgalerie.Name = _OCpG("\t!qMwkVYtq)V\014tk\021q\015\021")
ztaskZurAltmarktgalerie.Description = _OCpG("@\021qM@\015\021\127M\015FVMb\021\014=Mw\127\021qMbtFMbnkkV\021M\021qM\015vM\v\021qMwkVYtq)V\014tk\021q\015\021GM_nFM\014\021BVuF=")
ztaskZurAltmarktgalerie.Visible = true
ztaskZurAltmarktgalerie.Active = false
ztaskZurAltmarktgalerie.Complete = false
ztaskZurAltmarktgalerie.CorrectState = "None"
ztaskDigitalkamera = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskDigitalkamera.Id = "c7499fba-0bfd-4a30-a1c4-65be433de3c0"
ztaskDigitalkamera.Name = _OCpG("@\015\014\015Vtk)tY\021qt")
ztaskDigitalkamera.Description = _OCpG("\005qtFF=M@nqVMk\015\021\014VM\021\015v\021M@\015\014\015Vtk)tY\021qtMt!\023M\v\021YM$n\v\021v=M\003\021YM\v\015\021MbnBkM\014\021Bn\021qVM!v\vMn\127M\v\015\021M\023!v)V\015nv\015\021qVG")
ztaskDigitalkamera.Visible = true
ztaskDigitalkamera.Active = false
ztaskDigitalkamera.Complete = false
ztaskDigitalkamera.CorrectState = "None"
ztaskDerGrueneDiamant = Wherigo.ZTask(cartDerGrueneDiamant)
ztaskDerGrueneDiamant.Id = "cf9e7f19-602f-4c0d-8073-e6aa1c686b92"
ztaskDerGrueneDiamant.Name = _OCpG("@\021qM,q!\021v\021M@\015tYtvV")
ztaskDerGrueneDiamant.Description = _OCpG("-\0191@aM@a1M,s%a1a1M@\019wTw1ea1;;;")
ztaskDerGrueneDiamant.Visible = true
ztaskDerGrueneDiamant.Active = false
ztaskDerGrueneDiamant.Complete = false
ztaskDerGrueneDiamant.CorrectState = "None"
VarMin = 0
Fuerstenzug = ""
CountdownVariable = 0
VarSek = 0
_sno = _OCpG("\001nv\021,q!\021v\021F,\021bn\021k\127\021")
_OMVX2 = _OCpG("\001'Btqt'V\021qwkV\021-qt!")
_j6dT = _OCpG("\001\015V\021YetF'B\021vV!\021'B\021q")
_nIAP = _OCpG("\001VtF),\021B\021\001!q4n\023)\015q'B\021")
_jDo = _OCpG("\001\015vx!V6\021qFnv\015v-!\021qFV\021v\001!\014")
_L_eg_ = _OCpG("\001V\015Y\021qmn!vV\vnbve\015Y\021q")
cartDerGrueneDiamant.ZVariables = {
  VarMin = 0,
  Fuerstenzug = "",
  CountdownVariable = 0,
  VarSek = 0,
  _sno = _OCpG("\001nv\021,q!\021v\021F,\021bn\021k\127\021"),
  _OMVX2 = _OCpG("\001'Btqt'V\021qwkV\021-qt!"),
  _j6dT = _OCpG("\001\015V\021YetF'B\021vV!\021'B\021q"),
  _nIAP = _OCpG("\001VtF),\021B\021\001!q4n\023)\015q'B\021"),
  _jDo = _OCpG("\001\015vx!V6\021qFnv\015v-!\021qFV\021v\001!\014"),
  _L_eg_ = _OCpG("\001V\015Y\021qmn!vV\vnbve\015Y\021q")
}
ztimerCountdownTimer = Wherigo.ZTimer(cartDerGrueneDiamant)
ztimerCountdownTimer.Id = "e83b6c55-f87c-476a-b988-c6254081ae79"
ztimerCountdownTimer.Name = _OCpG("mn!vV\vnbve\015Y\021q")
ztimerCountdownTimer.Description = ""
ztimerCountdownTimer.Visible = true
ztimerCountdownTimer.Duration = 420
ztimerCountdownTimer.Type = "Interval"
ztimerTimerSek = Wherigo.ZTimer(cartDerGrueneDiamant)
ztimerTimerSek.Id = "5b6045ea-877d-4f69-86da-0b90e16f53af"
ztimerTimerSek.Name = _OCpG("e\015Y\021q\024\021)")
ztimerTimerSek.Description = ""
ztimerTimerSek.Visible = true
ztimerTimerSek.Duration = 1
ztimerTimerSek.Type = "Interval"
zinputPersoninFuerstenzug = Wherigo.ZInput(cartDerGrueneDiamant)
zinputPersoninFuerstenzug.Id = "cd2a872d-6c72-49e5-b403-cd87c2de5398"
zinputPersoninFuerstenzug.Name = _OCpG("6\021qFnvM\015vM-!\021qFV\021v\001!\014")
zinputPersoninFuerstenzug.Description = ""
zinputPersoninFuerstenzug.Visible = true
zinputPersoninFuerstenzug.Media = zmediaMaedchen_Ausschnitt
zinputPersoninFuerstenzug.InputType = "Text"
zinputPersoninFuerstenzug.Text = _OCpG(">\005n\021vv\021vM\024\015\021MY\015qM2\015\021kk\021\015'BVMB\021k\023\021vCMb\015\021M\v\015\021M6\021qFnvMq\021'BVFM2nvMw!\014!FVM\019\019=M\004w!\014!FVM\v\021qM\024Vtq)\021rMIMB\021\015FFVG>")
function cartDerGrueneDiamant:OnStart()
  _Urwigo.OldDialog({
    {
      Text = _OCpG("\003\015kk)nYY\021vM\127\021\015YM\003B\021q\015\014nI\024x\015\021kM>@\015\021M\030t\014\vMvt'BM\v\021YM,q!\021v\021vM@\015tYtvV\021v>="),
      Media = zmediaGruenerDiamant_komplett
    },
    {
      Text = _OCpG("\019'BCM1tVB!FCM\023q\021!\021MY\015'BCM\vtFFM\v!MY\021\015v\021M\003B\021q\015\014nImtqVq\015\v\014\021Mq!vV\021q\014\021kt\v\021vMBtFVM!v\vMb!\021vF'B\021M2\015\021kMaq\023nk\014M\127\021\015YM\024x\015\021k\021v=Ma\015vM4\015vb\021\015FM\001!M$\021\014\015vv\aMa\015vMtkV\127\021)tvvV\021FM\024xq\015'BbnqVMFt\014VCM\021FM\023!\021Bq\021vM2\015\021k\021M\003\021\014\021Mvt'BMsnY===M%v\v\aM\019YY\021qMF'Bn\021vMt!\023M\v\021\015vM,\021\023!\021BkMBn\021q\021v===Md\015\021kM\024xtFF;")
    },
    {
      Text = _OCpG("a\014tkMn\127Men!q\015FVMn\v\021qMa\015vB\021\015Y\015F'B\021qMIMtkFM,\021n't'B\021qM\014!')FVM\v!M\v\015qM\014\021qvM\v\015\021MB\015FVnq\015F'B\021MwkVFVt\vVM@q\021F\v\021vFMtv=M\t!vt\021'BFVM\001\015\021BVM\v\015'BM\vtFM,q!\021v\021M,\021bn\021k\127\021M\015vM\v\021vM$tvv=M4\015\021qMb\015q\vM!=t=M\v\021qMb\021kV\127\021q!\021BYV\021M,q!\021v\021M@\015tYtvVMt!F\014\021FV\021kkV="),
      Media = zmediaGruenerDiamant_komplett
    }
  })
  zoneGruenesGewoelbe.Visible = true
  zoneGruenesGewoelbe.Active = true
  zcharacterAlteFrau:MoveTo(zoneGruenesGewoelbe)
  zcharacterPolizist:MoveTo(zoneGruenesGewoelbe)
  zcharacterJournalist:MoveTo(zoneGruenesGewoelbe)
  zitemTaschentuecher:MoveTo(zoneGruenesGewoelbe)
  ztaskGruenesGewoelbe.Active = true
end
function cartDerGrueneDiamant:OnRestore()
end
function zoneGruenesGewoelbe:OnEnter()
  _sno = _OCpG("\001nv\021,q!\021v\021F,\021bn\021k\127\021")
  _Urwigo.OldDialog({
    {
      Text = _OCpG("\003tFM\015FVM\v\021vvMB\015\021qMknFG"),
      Media = zmediaGruenesGewoelbe
    },
    {
      Text = _OCpG("dnqM\v\021YMa\015v\014tv\014M\v\021FM,q!\021v\021vM,\021bn\021k\127\021FCM\021\015v\021qMb\021kV\127\021q!\021YV\021vM\024'BtV\001)tYY\021qCMBtVMF\015'BM\021\015v\021Mq\015\021F\015\014\021MT\021vF'B\021vY\021v\014\021M2\021qFtYY\021kV=")
    },
    {
      Text = _OCpG("wkk\021MF\015v\vM\015vMB\021kk\021qMw!\023q\021\014!v\014=M%\021\127\021qtkkM6nk\015\001\021\015CM\005tY\021qtV\021tYFM!v\vM\v\015\021M6q\021FF\021="),
      Media = zmediaReporter_Ausschnitt
    },
    {
      Text = _OCpG("\019'BM\014kt!\127CM\015'BMFnkkV\021MYtkM\v\015\021MtkV\021M-qt!M\023qt\014\021v="),
      Media = zmediaAlteFrau_Ausschnitt
    }
  })
  zcharacterAlteFrau.Visible = true
  ztaskGruenesGewoelbe.Complete = true
end
function zoneGruenesGewoelbe:OnExit()
  _sno = _OCpG("\001nv\021,q!\021v\021F,\021bn\021k\127\021")
  if ztaskGehezurHofkirche.Active == true then
    zitemTaschentuecher.Visible = true
    _Urwigo.MessageBox({
      Text = _OCpG("{BCM\vtMk\015\021\014VM7tM\021\015v\021M!v\127\021v!V\001V\021CMvt\014\021kv\021!\021MetF'B\021vV!'Bxt')!v\014Mt!\023M\v\021YM$n\v\021v==="),
      Media = zmediaTaschentuecher_komplett,
      Buttons = {
        _OCpG("\019'BMv\021BY\021MF\015\021="),
        _OCpG("\019'BMktFFMF\015\021Mk\015\021\014\021v=")
      },
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          zitemTaschentuecher:MoveTo(Player)
          zoneGruenesGewoelbe.Visible = false
          zoneGruenesGewoelbe.Active = false
        end
      end
    })
  end
end
function zoneHofkirche:OnEnter()
  _sno = _OCpG("\001nv\0214n\023)\015q'B\021")
  ztaskGehezurHofkirche.Complete = true
  zcharacterNetterHerr.Visible = true
  if Player:Contains(zitemTaschentuecher) then
    zitemTaschentuecher.Commands.Geben.Enabled = true
  end
  _Urwigo.MessageBox({
    Text = _OCpG("T\015FV=M\005\021\015vM@\015\021\127Mb\021\015VM!v\vM\127q\021\015VM\001!MF\021B\021v=M%\021\127\021qM\v\015\021Mw!\014!FV!F\127q!\021')\021Mq!\021\127\021qMBt\127\021M\015'BM)\021\015v\021M_!FV==="),
    Media = zmediaDieb_nichtda
  })
end
function zoneHofkirche:OnExit()
  _sno = _OCpG("\001nv\0214n\023)\015q'B\021")
  if (ztaskGehezumFuerstenzug.Active and Player:Contains(zitem2Euro)) == true then
    zoneHofkirche.Visible = false
    zoneHofkirche.Active = false
    zoneGruenesGewoelbe.Visible = false
    zoneGruenesGewoelbe.Active = false
  end
end
function zoneFuerstenzug:OnEnter()
  _sno = _OCpG("\001nv\021-!\021qFV\021v\001!\014")
  if ztaskFuerstenzuganschauen.Active == false or ztaskFuerstenzuganschauen.Complete == false then
    ztaskGehezumFuerstenzug.Complete = true
    _Urwigo.MessageBox({
      Text = _OCpG("\003nbCM\vtFMF\015v\vM7tM2\015\021k\021M\127\021q!\021BYV\021M6\021qFnv\021vMt!FM\v\021qMd\021q\014tv\014\021vB\021\015V===M@tFM\015FVMbnBkM\v\021qM-!\021qFV\021v\001!\014CMb\015\021M\v\021qMv\021VV\021CMt\021kV\021q\021M4\021qqMY\015qM\021\127\021vM\021qkt!V\021qV\021====M\024\021BqMF'B\015')="),
      Media = zmediaFuerstenzug
    })
    ztaskFuerstenzuganschauen.Active = true
    zcharacterMaedchen.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _OCpG("@!M\127\015FVMtYM-!\021qFV\021v\001!\014Mtv\014\021)nYY\021v="),
      Media = zmediaFuerstenzug
    })
    zitemWurstgutschein.Commands.Geben.Enabled = true
  end
end
function zoneFuerstenzug:OnExit()
  _sno = _OCpG("\001nv\021-!\021qFV\021v\001!\014")
  zitemWurstgutschein.Commands.Geben.Enabled = false
  if Player:Contains(zitemBratwurst) then
    zoneFuerstenzug.Visible = false
    zoneFuerstenzug.Active = false
  end
end
function zoneHiltonHotel:OnEnter()
  _sno = _OCpG("\001nv\0214\015kVnv4nV\021k")
  if Player:Contains(zitemBratwurst) then
    zitemBratwurst.Commands.Geben.Enabled = true
  else
    ztaskZumHiltonHotel.Complete = true
    zcharacterGeigespielenderJunge:MoveTo(zoneHiltonHotel)
    zcharacterBettler.Visible = true
    zitem2Euro.Commands.Geben.Enabled = false
  end
  _Urwigo.MessageBox({
    Text = _OCpG("@!M\127\015FVM\127\021\015YM4\015kVnvM4nV\021kMtv\014\021)nYY\021v="),
    Media = zmediaHilton
  })
end
function zoneHiltonHotel:OnExit()
  _sno = _OCpG("\001nv\0214\015kVnv4nV\021k")
  zitemWurstgutschein.Commands._dSEW.Enabled = false
end
function zoneFrauenkirche:OnEnter()
  _sno = _OCpG("\001nv\021-qt!\021v)\015q'B\021")
  zoneFuerstenzug.Active = false
  zoneFuerstenzug.Visible = false
  zoneHiltonHotel.Active = false
  zoneHiltonHotel.Visible = false
  zitemWurstgutschein.Visible = false
  VarMin = 0
  VarSek = 0
  ztimerTimerSek:Stop()
  ztaskZurFrauenkirche.Complete = true
  zcharacterOrdnerin.Visible = true
  _Urwigo.MessageBox({
    Text = _OCpG("\003nbCM\vtFM\015FVMtkFnM\v\015\021Mb\015\021\v\021qt!\023\014\021\127t!V\021M-qt!\021v)\015q'B\021;M@\015\021Mb!q\v\021M\vn'BMav\v\021M\v\021FM\tb\021\015V\021vM\003\021kV)q\015\021\014\021FM)tx!VVM\014\021\127nY\127VM!v\vMv!vMvt'BM\v\021qM\003\021v\v\021Mb\015\021\v\021qMt!\023\014\021\127t!V=Mw!\023\023t\021kk\015\014MF\015v\vM\v\015\021M\v!v)k\021vM\024tv\vFV\021\015v\021CM\v\015\021M\015YY\021qMb\015\021\v\021qM\001b\015F'B\021vM\v\021vM4\021kk\021vM\001!MF\021B\021vMF\015v\v=M@tFMF\015v\vM{q\015\014\015vtkFV\021\015v\021CM\v\015\021M2nvM\v\021qMs!\015v\021M!\021\127q\015\014M\014\021\127k\015\021\127\021vMbtq\021v=M\024\015\021Mb!q\v\021vM\014qn\021FFV\021vV\021\015kFMb\015\021\v\021qMtvM\015Bq\021M{q\015\014\015vtkFV\021kk\021vM\021\015v\014\021F\021V\001V="),
    Media = zmediaFrauenkirche
  })
end
function zoneFrauenkirche:OnExit()
  _sno = _OCpG("\001nv\021-qt!\021v)\015q'B\021")
  if ztaskFrauenkircheangucken.Complete == true then
    CountdownVariable = 0
    ztimerCountdownTimer:Start()
    ztimerTimerSek:Start()
  end
end
function zoneKulturpalast:OnEnter()
  _sno = _OCpG("\001nv\021\005!kV!qxtktFV")
  if CountdownVariable == 0 then
    ztimerCountdownTimer:Stop()
    ztimerTimerSek:Stop()
    zitemParkzettel.Commands.Zeigen.Enabled = true
    ztaskZumKulturpalast.Complete = true
    zoneFrauenkirche.Visible = false
    zoneFrauenkirche.Active = false
    zcharacterDrehorgelspieler.Visible = true
    _Urwigo.MessageBox({
      Text = _OCpG("4!qqt;M@!MBtFVM\021FM\015vv\021qBtk\127M2nvM5MT\015v!V\021vM\014\021F'Bt\023\023V===M@\021qM@q\021Bnq\014\021kFx\015\021k\021qM\015FVMvn'BM\vt=M4\015\021qMvn'BM\021\015vMxttqM\019v\023nFM\001!YM\005!kV!qxtktFV\aM4\015\021qM\023\015v\v\021vM!=t=M2\015\021k\021M\005nv\001\021qV\021M2nvM\005ktFF\015)CM6nxM\127\015FM\024'Bkt\014\021qMFVtVV=M@\021qM\014qn\021FFV\021MT\021Bq\001b\021')FttkM@q\021F\v\021vFMb!q\v\021M\n!t\v\021q\023n\021qY\015\014M\015YM\024V\015kM\v\021qM$t!Bt!FITn\v\021qv\021M\021qq\015'BV\021VM!v\vM\018c`cM\021qn\021\023\023v\021V=MaqMBtVM\127\015FM\001!MPiLAM\024\015V\001xkt\021V\001\021M!v\vM\015FVM\023\021FV\021M\024x\015\021kFVt\021VV\021M\v\021qM@q\021F\vv\021qM6B\015kBtqYnv\015\021=\026$s?\024\021\015VM\024\021xV\021Y\127\021qMPj\018PMb\015q\vM\v\021qM\005!kV!qxtktFVM\015vv\021vM2nkkFVt\021v\v\015\014M!Y\014\021\127t!V=M@\021qM\005nv\001\021qVFttkMBtVM\vtvt'BMv!qMvn'BM't=M\0183jjM6kt\021V\001\021CMFnkkMt\127\021qM\023!\021qM\v\015\021M@q\021F\vv\021qM6B\015kBtqYnv\015\021M\021\015v\021M\v\021!Vk\015'BM\127\021FF\021q\021Mw)!FV\015)MBt\127\021vCMbtFMtkk\021q\v\015v\014FMF\021BqM!YFVq\015VV\021vM\015FV=Mw!FF\021q\v\021YMFnkk\021vM\vtFM\005t\127tq\021VVM4\021q)!k\021F)\021!k\021M!v\vM\v\015\021M\024Vt\021\vV\015F'B\021M$\015\127k\015nVB\021)M\021\015v\001\015\021B\021v=M@\021qM%Y\127t!Mb\015q\vM!\021\127\021qM3jMT\015kk\015nv\021vMa%sM)nFV\021vM!v\vM\127\015FMPj\018AM\vt!\021qv=M1n\021V\015\014M\014\021bnq\v\021vMbtqM\vtFM$t!xqn7\021)VCM\vtM\v\015\021M1!V\001!v\014F\014\021v\021BY\015\014!v\014Mav\v\021MPj\018\018Mt\127\014\021kt!\023\021vMbtq="),
      Media = zmediaKulturpalast
    })
  else
    _Urwigo.MessageBox({
      Text = _OCpG("\t!MFxt\021V;;;M@\021qM@q\021Bnq\014\021kFx\015\021k\021qM\015FVM\127\021q\021\015VFMvt'BM4t!F\021M\014\021\014tv\014\021v===M@tM\vtFMB\015\021qMt\127\021qM\014k!\021')k\015'B\021qb\021\015F\021Mv!qM\021\015vMmnYx!V\021qFx\015\021kM\015FVCM\vtq\023FVM\v!Mvn'BMYtkM\001!q!\021')M\001!qM-qt!\021v)\015q'B\021M!v\vM\v\021\015vM,k!\021')M\021qv\021!VM2\021qF!'B\021v="),
      Media = zmediaKulturpalast
    })
  end
end
function zoneKulturpalast:OnExit()
  _sno = _OCpG("\001nv\021\005!kV!qxtktFV")
  if zoneAltmarktTiefgarage.Active == true then
    zoneKulturpalast.Visible = false
    zoneKulturpalast.Active = false
    zitemParkzettel.Visible = false
  end
end
function zoneAltmarktTiefgarage:OnEnter()
  _sno = _OCpG("\001nv\021wkVYtq)Ve\015\021\023\014tqt\014\021")
  zcharacterMarktfrau.Visible = true
  _Urwigo.MessageBox({
    Text = _OCpG("wBtCM\vtFM\015FVMtkFnM\v\021qM@q\021F\vv\021qMwkVYtq)VCM\021\015v\021qM\v\021qMb\015'BV\015\014FV\021vM6kt\021V\001\021M\015vM@q\021F\v\021v=M4\015\021qM\023\015v\v\021VM7\021\v\021FM\030tBqM\015YM@\021\001\021Y\127\021qM\v\021qMb\021kV\127\021q!\021BYV\021M\024Vq\015\021\001\021kYtq)VMFVtVV=M\024\021\015VM\018iLiM\001\015\021BVM\v\021qM\003\021\015Bvt'BVFYtq)VMT\021vF'B\021vMt!FM\v\021YM\019vIM!v\vMw!Fktv\vMtv=M\019v\001b\015F'B\021vMq!v\vMPCAMT\015nM_\021!V\021MxqnM\030tBq=M4\021q2nq\001!B\021\127\021vMF\015v\vM\v\015\021Mb\021kV\014qn\021FFV\021M\024V!\023\021vxNqtY\015\v\021M\004\018iC`PMT\021V\021qrM!v\vM\v\021qMb\021kV\014qn\021FFV\021M\127\021\014\021B\127tq\021M\024'Bb\015\127\127n\014\021vM\004\018LCAM|MAMT\021V\021qrMIM\127\021\015\v\021Maq\001\014\021\127\015q\014\015F'B\021Mdnk)F)!vFV="),
    Media = zmediaAltmarkt
  })
  ztaskAltmarkt.Complete = true
end
function zoneAltmarktTiefgarage:OnExit()
  _sno = _OCpG("\001nv\021wkVYtq)Ve\015\021\023\014tqt\014\021")
  if zoneAltmarktgalerie.Active == true then
    zoneAltmarktTiefgarage.Visible = false
    zoneAltmarktTiefgarage.Active = false
    zitemSanduhr.Visible = false
  end
end
function zoneAltmarktgalerie:OnEnter()
  _sno = _OCpG("\001nv\021wkVYtq)V\014tk\021q\015\021")
  ztaskZurAltmarktgalerie.Complete = true
  ztaskDigitalkamera.Active = true
  _Urwigo.MessageBox({
    Text = _OCpG("@!M\127\015FVMtvM\v\021qMwkVYtq)V\014tk\021q\015\021Mtv\014\021)nYY\021v=Ma\015v\021qM\v\021qM\014qnFF\021vMa\015v)t!\023FV\021Yx\021kM\v\021qM\019vv\021vFVt\vV="),
    Media = zmediaAltmarktgalerie
  })
  zitemDigitalkamera.Visible = true
end
function zinputPersoninFuerstenzug:OnGetInput(input)
  if input == nil then
    input = ""
  end
  Fuerstenzug = input
  Fuerstenzug = tostring(string.lower(Fuerstenzug))
  Fuerstenzug = tostring(string.gsub(Fuerstenzug, "[^%l]", ""))
  print("Fuerstenzug: " .. Fuerstenzug)
  if Wherigo.NoCaseEquals(Fuerstenzug, _OCpG("t!\014!FV\015\015\015")) then
    _Urwigo.OldDialog({
      {
        Text = _OCpG("w\127Fnk!VM)nqq\021)V;")
      },
      {
        Text = _OCpG(">{BCM2\015\021k\021vM@tv)=M@tFFM\015'BM\vtMF\021k\127\021qMv\015'BVM\vqt!\023M\014\021)nYY\021vM\127\015v;M\024V\021BVM\vn'BM\vt=M@tFM\015FVM\v\021qM\024nBvM2nvMw!\014!FVM\v\021YM\024Vtq)\021vCM\021qMBtVM\v\015\021M4n\023)\015q'B\021M\021q\127t!VM!v\vMtkFM\005!vFVk\015\021\127Bt\127\021qM!=t=M\v\021vM,q!\021v\021vM@\015tYtvV\021vM\014\021)t!\023V===>"),
        Media = zmediaMaedchen_Ausschnitt
      },
      {
        Text = _OCpG(">wkFM@tv)\021F'Bn\021vMF'B\021v)\021M\015'BM\019Bv\021vM\v\015\021F\021vM,!VF'B\021\015vM\023!\021qM\021\015v\021M$qtVb!qFV=M@\021vMBtVMY\015qM\v\021qM\003!\021qFV'B\021v2\021q)t\021!\023\021qM\vnqVM\vq!\021\127\021vM\014\021F'B\021v)V=M$qt!'B\021M\015'BM\021BMv\015'BV=M$\015vMvt\021Yk\015'BMd\021\014\021Vtq\015\021q\015v=M4\015\021qCM$\015VV\021F'Bn\021v;>"),
        Media = zmediaMaedchen_Ausschnitt
      }
    })
    ztaskFuerstenzuganschauen.Complete = true
    zitemWurstgutschein:MoveTo(Player)
    zitemWurstgutschein.Visible = true
    zcharacterWuerstchenverkaufer.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _OCpG("_\021\015\v\021qM\023tkF'B=Md\021qF!'BM\021FMvn'BM\021\015vYtk=")
    })
  end
end
function ztimerCountdownTimer:OnTick()
  CountdownVariable = 1
end
function ztimerTimerSek:OnTick()
  VarSek = VarSek + 1
  if VarSek >= 60 then
    VarMin = VarMin + 1
    VarSek = 0
  end
end
function zcharacterAlteFrau:OnSprechen(target)
  _Urwigo.OldDialog({
    {
      Text = _OCpG(">\003tFMB\015\021qMknFM\015FVGM===M\005\021\015v\021MwBv!v\014=>"),
      Media = zmediaAlteFrau_Ausschnitt
    },
    {
      Text = _OCpG(">\024'B\021\015vVMbtFM\024'Bk\015YY\021FM\001!MF\021\015v=M\024nM2\015\021k\021Mt!\023\014\021q\021\014V\021MT\021vF'B\021v=M===M@nqVM\v\015\021M\005tY\021qtk\021!V\021===M@tM)nYYVM\021\015vM6nk\015\001\015FV=M-qt\014\021vMb\015qM\v\021vMYtk=M>"),
      Media = zmediaAlteFrau_Ausschnitt
    }
  })
  zcharacterPolizist.Visible = true
end
function zcharacterPolizist:OnSprechen(target)
  _Urwigo.OldDialog({
    {
      Text = _OCpG(">$\015VV\021M\014\021B\021vM\024\015\021Mb\021\015V\021q;M4\015\021qM\014\015\127VM\021FMv\015'BVFM\001!MF\021B\021v=>"),
      Media = zmediaPolizist_Ausschnitt
    },
    {
      Text = _OCpG(">@tFM\014\015kVMt!'BM\023!qM\024\015\021;M\003\021\015V\021q\014\021B\021v;;;>"),
      Media = zmediaPolizist_Ausschnitt
    }
  })
  zcharacterJournalist.Visible = true
end
function zcharacterJournalist:OnSprechen(target)
  _Urwigo.OldDialog({
    {
      Text = _OCpG(">@\021qM,q!\021v\021M@\015tYtvVM\015FVM\014\021FVnBk\021vMbnq\v\021v=Mw!FM\v\021YM,q!\021v\021vM,\021bn\021k\127\021=Ma\015v\023t'BM\023nqV===M\003tFM\023!\021qM\021\015v\021M1t'Bq\015'BV;M===Mw'BMFnCM\015'BMBt\127\021MY\015'BMvn'BM\014tqMv\015'BVM2nq\014\021FV\021kkV\aMstk\023Ms\021\v\021Y!v\vM2nvM\v\021vM@q\021F\vv\021qM1\021!\021FV\021M1t'Bq\015'BV\021v=>"),
      Media = zmediaReporter_Ausschnitt
    },
    {
      Text = _OCpG(">\019'BMBt\127\021M\014\021qt\v\021MY\015VM\v\021YM,\021v\021qtk\v\015q\021)VnqM\v\021qM\024VttVk\015'B\021vM\005!vFVFtYYk!v\014\021vCM@q=M4tqVb\015\014M-\015F'B\021qCM\014\021Fxqn'B\021v=MTtvMV\015xxVMt!\023M\021\015v\021vMa\015v\001\021kVt\021V\021q=M@\021qM@\015\021\127MFnkkMs\015'BV!v\014Mw!\014!FV!F\127q!\021')\021Mt\127\014\021Bt!\021vMF\021\015v=M@\015\021M6nk\015\001\021\015M\015FVM\015BYMt!\023M\v\021vM-\021qF\021v===>"),
      Media = zmediaReporter_Ausschnitt
    }
  })
  ztaskGehezurHofkirche.Active = true
  zoneHofkirche.Visible = true
  zoneHofkirche.Active = true
  zcharacterNetterHerr:MoveTo(zoneHofkirche)
end
function zcharacterNetterHerr:OnSprechen(target)
  if ztaskHofkircheangucken.Active == false then
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">\003!FFV\021vM\024\015\021CM\v\015\021M)tVBnk\015F'B\021M4n\023)\015q'B\021Mb!q\v\021M!vV\021qM\005!q\023!\021qFVM-q\015\021\vq\015'BMw!\014!FVM\019\019=M2nvM\024t'BF\021vM2nvM\0185LcM\127\015FM\0185AAM\015YM\024V\015kM\v\021FM$tqn')FM\021qq\015'BV\021VM!v\vM\014\015kVMtkFM\021\015v\021M\v\021qM\014qn\021FFV\021vM\005\015q'B\021v\127t!V\021vM\024t'BF\021vF=>"),
        Media = zmediaNetterHerr_Ausschnitt
      },
      {
        Text = _OCpG(">wkFMw!\014!FVM\019\019\019=MbtqM\021qM\014k\021\015'B\001\021\015VM\005n\021v\015\014M2nvM6nk\021vM!v\vM,qnFFB\021q\001n\014M2nvM_\015Vt!\021v=MaqMbtqM)\021\015vM\014qnFF\021qM6nk\015V\015)\021qMb\015\021MF\021\015vMdtV\021qCMw!\014!FVM\v\021qM\024Vtq)\021CM\vt\023!\021qM\021\015vM!YFnM\014qn\021FF\021q\021qM\005!vFVk\015\021\127Bt\127\021q=MaqM)t!\023V\021M\0185i\018M\023!\021qMijj=jjjMetk\021qM\015vM_\021\015x\001\015\014M\021\015v\021vMbtBq\021vM6qt'BV\v\015tYtvV\021v=M@\021vMFn\014\021vtvvV\021vM,q!\021v\021vM@\015tYtvV\021v===>"),
        Media = zmediaNetterHerr_Ausschnitt
      },
      {
        Text = _OCpG(">===Mw'BCMb\015\021FnMF\015v\vM\024\015\021Mt!\023M\021\015vYtkMFnMt!\023\014\021q\021\014VGM====M@asM@\019wTw1eM\003%s@aM,a\024e{4_a1GGGM@tFM\015FVM7tM!v\023tFF\127tq;;;>"),
        Media = zmediaNetterHerr_Ausschnitt
      },
      {
        Text = _OCpG(">T\015qM\015FVMt!\023M\021\015vYtkM\014tv\001MB\021\015FFM\014\021bnq\v\021v=M\019'BMF'Bb\015V\001\021MtYM\014tv\001\021vM\005n\021qx\021q===M@tFMxtFF\015\021qVM\015YY\021qCMb\021vvM\015'BMY\015'BMF\021BqMt!\023q\021\014\021=M1t7tCMYtvM\015FVMBtkVMv\015'BVMY\021BqM\v\021qM\030!\021v\014FV\021=>"),
        Media = zmediaNetterHerr_Ausschnitt
      }
    })
    ztaskHofkircheangucken.Active = true
  elseif ztaskHofkircheangucken.Complete == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">_nFM\127\021\021\015k\021vM\024\015\021MF\015'B;M@tvvMBnk\021vM\024\015\021M\v\021vM@\015\021\127M\021\015v=>"),
      Media = zmediaNetterHerr_Ausschnitt
    })
  else
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">{BMTtvvCMY\015qMq\015vvVM\v\021qM\024'Bb\021\015FFM2nvM\v\021qM\024V\015qv=>"),
        Media = zmediaNetterHerr_Ausschnitt
      }
    })
  end
end
function zcharacterBettler:OnSprechen(target)
  _Urwigo.MessageBox({
    Text = _OCpG(">\003\021vvM\024\015\021MY\015qM\001b\021\015Ma!qnM\014\021\127\021vCM2\021qqtV\021M\015'BM\019Bv\021vM\021\015vM,\021B\021\015Yv\015F=M\019'BM\127\015vMvt\021Yk\015'BM\021\015vMtqY\021qM\024'Bk!')\021qCMb\015FF\021vM\024\015\021GM$\015VV\021CM\127\015VV\021;>"),
    Media = zmediaBettler_Ausschnitt,
    Buttons = {
      _OCpG("1\021\021=M_tFFMYtk="),
      _OCpG("1tM\014!V=M4\015\021q=")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button2" then
          zitem2Euro:MoveTo(zcharacterBettler)
          _Urwigo.MessageBox({
            Text = _OCpG(">{BCM@tv)\021;M\030\021V\001VM2\021qqtV\021M\015'BM\019Bv\021vMYtkMbtF\aMT\015VM\v\021YM,\021k\vM\014\021B\021M\015'BM\015vM\v\021vMvt\021'BFV\021vM\024!x\021qYtq)VM!v\vMBnk\021MY\015qMbtFM\001!MFt!\023\021v===M4tBt===M%v\vMb\021\014M\127\015vM\015'B=M4tBttt===>"),
            Media = zmediaBettler_Ausschnitt
          })
          zcharacterBettler.Visible = false
          zcharacterBettler:MoveTo(zoneGruenesGewoelbe)
        else
          _Urwigo.MessageBox({
            Text = _OCpG(">@tvvM\021q\023tBq\021vM\024\015\021M\vtFM,\021B\021\015Yv\015FMBtkVMv\015'BV=M\024\015\021MtkV\021qM\005vt!F\021q;>"),
            Media = zmediaBettler_Ausschnitt
          })
        end
      end
    end
  })
  zcharacterGeigespielenderJunge.Visible = true
  zitemWurstgutschein.Commands._dSEW.Enabled = true
end
function zcharacterOrdnerin:OnSprechen(target)
  if ztaskFrauenkircheangucken.Active == false then
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">4n\021q\021vM\024\015\021M\127\015VV\021CMB\015\021qM\v!\021q\023\021vM\024\015\021Mv\015'BVMq\021\015v=M@tFM\015FVM\v\021qMw!F\014tv\014=>"),
        Media = zmediaOrdnerin_Ausschnitt
      },
      {
        Text = _OCpG(">@tFMb!FFV\021vM\024\015\021Mv\015'BVGM\005\021\015vM6qn\127k\021Y=M\003\021v\015\014FV\021vFMF\015v\vM\024\015\021Mv\015'BVMFnM!v\023q\021!v\vk\015'BCMb\015\021M\v\021qMTtvvM\021\127\021v=M@\021qMbnkkV\021MVqnV\001\v\021YMB\015\021qMq\021\015v=>"),
        Media = zmediaOrdnerin_Ausschnitt
      },
      {
        Text = _OCpG(">wkFM\015'BM\015BYMY\015VM\v\021YM\024\015'B\021qB\021\015VF\v\015\021vFVM\vqnBV\021CM\015FVM\021qM\001\015\021Yk\015'BMv\021q2n\021FM\014\021bnq\v\021vM!v\vMs\015'BV!v\014M\005!kV!qxtktFVMt\127\014\021Bt!\021v=M@t\127\021\015M\015FVM\015BYM\v\015\021F\021qM\t\021VV\021kMt!FM\v\021qMetF'B\021M\014\021\023tkk\021v=>"),
        Media = zmediaOrdnerin_Ausschnitt
      }
    })
    zitemParkzettel.Visible = true
    ztaskFrauenkircheangucken.Active = true
  elseif ztaskFrauenkircheangucken.Complete == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">$\021\021\015k\021vM\024\015\021MF\015'B;M\024\015\021MBt\127\021vM5MT\015v!V\021vM\t\021\015VM!YM\v\021vM@q\021Bnq\014\021kFx\015\021k\021qM\001!M\021qb\015F'B\021v=>"),
      Media = zmediaOrdnerin_Ausschnitt
    })
  else
    _Urwigo.MessageBox({
      Text = _OCpG(">\003nkk\021vM\024\015\021M\v\021vM6tq)\001\021VV\021kG>"),
      Media = zmediaOrdnerin_Ausschnitt
    })
  end
end
function zcharacterDrehorgelspieler:OnSprechen(target)
  if ztaskParkzettel.Complete == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">@nqVMt!\023M\v\021qMtv\v\021q\021vM\024VqtFF\021vF\021\015V\021M\015FVM\v\021qMwkVYtq)V;M===M\019'BM\014\021BM7\021V\001VMvt'BM4t!F\021=Mm\015tn=>"),
      Media = zmediaDrehorgellspieler_Ausschnitt
    })
    zcharacterDrehorgelspieler.Visible = false
  else
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">\003tFM\014q!\021\127\021kvM\024\015\021M\v\021vvMFnGM\024\015\021MF!'B\021vM\021\015v\021vM@\015\021\127GMw'BM\v\021vMeNx\021vCM\v\021qM\v\021vM,q!\021v\021vM@\015tYtvV\021vMt!FM\v\021YM,q!\021v\021vM,\021bn\021k\127\021M\014\021FVnBk\021vMBtVG>"),
        Media = zmediaDrehorgellspieler_Ausschnitt
      },
      {
        Text = _OCpG(">@tM)nYY\021vM\024\015\021M\001!MFxt\021V=M@\015\021M6nk\015\001\021\015MBtVM\015BvM\127\021q\021\015VFM\023\021FV\014\021vnYY\021v=MaqMbnkkV\021MF\015'BMtYM6nFVxktV\001MY\015VM\v\021qM\024VqtFF\021v\127tBvMt!FM\v\021YM\024Vt!\127MYt'B\021v===M\005tYM\021\127\021vM\015YMst\v\015n=MdnYM@\015tYtvV\021vM\023\021BkVMtkk\021q\v\015v\014FM7\021\v\021M\024x!q===>"),
        Media = zmediaDrehorgellspieler_Ausschnitt
      },
      {
        Text = _OCpG(">1tCMv\015'BVMFnM\021vVVt\021!F'BVM\014!')\021v=M@t'BV\021vMbnBkM\024\015\021MF\015v\vM\024B\021qkn')M4nkY\021FGM4tBtG>"),
        Media = zmediaSherlockHolmes_Ausschnitt
      }
    })
    ztaskParkzettel.Active = true
  end
end
function zcharacterGeigespielenderJunge:OnSprechen(target)
  if ztaskJungespieltGeige.Active == false then
    _Urwigo.MessageBox({
      Text = _OCpG(">\019'BM)nYY\021Mn\023VMB\015\021qMB\021qM!v\vMFx\015\021k\021M,\021\015\014\021=M@tFMYt'BVMVnVtkM\024xtFFM!v\vM2\015\021k\021MT\021vF'B\021vMBn\021q\021vMY\015qM\001!=MTtv'B\021M_\021!V\021Mb\021q\023\021vM\021VbtFM\005k\021\015v\014\021k\vM\015vMY\021\015v\021vM4!V=>"),
      Media = zmediaJungerGeiger_Ausschnitt
    })
    zitem2Euro.Commands.Geben.Enabled = true
    ztaskJungespieltGeige.Active = true
  elseif ztaskJungespieltGeige.Complete == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">d\015\021k\021vM@tv);M\019'BMY!FFM7\021V\001VMb\021\015V\021qMFx\015\021k\021v=>"),
      Media = zmediaJungerGeiger_Ausschnitt
    })
  else
    _Urwigo.MessageBox({
      Text = _OCpG(">\024\021B\021vM\024\015\021CM\v\015\021Mv\021VV\021M-qt!MBtVMY\015qM\021\015vMxttqMa!qnM\015vM\v\021vM4!VM\014\021bnq\023\021v===Md\015\021k\021vM@tv)CM\014vt\021\v\015\014\021M@tY\021;>"),
      Media = zmediaJungerGeiger_Ausschnitt
    })
  end
end
function zcharacterWuerstchenverkaufer:OnSprechen(target)
  if ztaskZumHiltonHotel.Active == false then
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">,\021B\021vM\024\015\021Mb\021\014;M\019'BMBt\127\021Mvn'BMv\015'BVM\014\021n\021\023\023v\021V=M\024\015\021MF\021B\021vM\vn'BCM\vtFFMY\021\015v\021M\003!\021qFV\021Mvn'BMv\015'BVM\023\021qV\015\014MF\015v\v=>"),
        Media = zmediaWuerstelmann_nichtfertig
      },
      {
        Text = _OCpG(">avVF'B!k\v\015\014\021vM\024\015\021M\127\015VV\021CM\vtFFM\015'BMFnM!v\014\021BtkV\021vM\127\015v=Mw\127\021qM\021\127\021vMbtqMFnuvMeNxMY\015VM\v!v)k\021qM\024nvv\021v\127q\015kk\021M!v\vMw)V\021v)n\023\023\021qMB\015\021q=M@\021qMb!q\v\021Mq\015'BV\015\014Mt\014q\021FF\0152CMtkFM\015'BM\015BYM\021q)kt\021qV\021CM\vtFFM\015'BMvn'BMv\015'BVFM2\021q)t!\023\021=MaqMBt\021VV\021M\014qnFF\021vM4!v\014\021qCMt\127\021qM)\021\015v\021M\t\021\015VM\001!MbtqV\021vCMq\015\021\023M\021q===M\024'Bk\015\021FFk\015'BM\015FVM\021qMs\015'BV!v\014M4\015kVnvM4nV\021kMt\127\014\021\vtYx\023V=>"),
        Media = zmediaWuerstelmann_nichtfertig
      }
    })
    ztaskZumHiltonHotel.Active = true
    zoneHiltonHotel.Active = true
    zoneHiltonHotel.Visible = true
    zcharacterBettler:MoveTo(zoneHiltonHotel)
  elseif ztaskJungespieltGeige.Active == true and not Player:Contains(zitemWurstgutschein) then
    _Urwigo.MessageBox({
      Text = _OCpG(">_tFF\021vM\024\015\021M\021FMF\015'BMF'BY\021')\021vM!v\vMw!\023M\003\015\021\v\021qF\021B\021v;>"),
      Media = zmediaWuerstelmann_komplett
    })
  elseif ztaskJungespieltGeige.Active == true and Player:Contains(zitemWurstgutschein) then
    _Urwigo.MessageBox({
      Text = _OCpG(">\030\021V\001VMF\015v\vMY\021\015v\021M\003!\021qFV'B\021vMx\021q\023\021)VM\014\021\127qtV\021v=M\003nkk\021vM\024\015\021M\021\015v\021GM@tvvM\014\021\127\021vM\024\015\021MY\015qM\127\015VV\021M\019Bq\021vM,!VF'B\021\015v=>"),
      Media = zmediaWuerstelmann_Ausschnitt
    })
  else
    _Urwigo.MessageBox({
      Text = _OCpG(">\024nqqNCM)nYY\021vM\024\015\021MFxt\021V\021qMvn'BM\021\015vYtkMb\015\021\v\021q=M@tvvM\127\021)nYY\021vM\024\015\021M\014\021qvM\021\015v\021M$qtVb!qFV=>"),
      Media = zmediaWuerstelmann_nichtfertig
    })
  end
end
function zcharacterMarktfrau:OnSprechen(target)
  if ztaskAltmarkt.Active == true then
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">\024\015\021Mb!\021vF'B\021vG===M\024\015\021Mbnkk\021vM\014tqMv\015'BVFM)t!\023\021vG===Mw'BCM\024\015\021Mbnkk\021vMb\015FF\021vCMbnM\v\015\021Me\015\021\023\014tqt\014\021M\015FVG>"),
        Media = zmediaMarktfrau_Ausschnitt
      },
      {
        Text = _OCpG(">1tV!\021qk\015'BM!vV\021qM!vF;M4\015B\015===M1\021\015vCM\015YMaqvFV\aM@nqVM\vq!\021\127\021vMF\021B\021vM\024\015\021Meq\021xx\021vCMb\021k'B\021M\v\015q\021)VM\001!qMe\015\021\023\014tqt\014\021M\023!Bq\021v===M1tCM\023\015v\v\021vM\024\015\021M\015BqMw!VnMvn'BCMb\021vvM\024\015\021Mv\015'BVMYtkMY\021BqMb\015FF\021vCMbnM\v\015\021M,tqt\014\021M\015FVG===M4\015B\015===4t4t===>"),
        Media = zmediaMarktfrau_Ausschnitt
      },
      {
        Text = _OCpG(">w\127\021qM\024\015\021MF\015v\vMB\021!V\021Mv\015'BVM\v\021qM\021qFV\021Md\021qq!\021')V\021=MdnqB\015vMBt\127\021M\015'BM\021\015v\021vMTtvvM\127\021\v\015\021vVCM\v\021qM\014q!YY\021kV\021M\015vMF\021\015v\021vM$tqV\aMaqMBt\021VV\021MF\021\015vM6tq)V\015')\021VM2\021qknq\021vCMb!\021FFV\021Mv\015'BVCMb\015\021M\021qM7\021V\001VMt!FM\v\021qMe\015\021\023\014tqt\014\021M\023tBq\021vMFnkk\021=M@\021Fb\021\014\021vMbnkk\021M\021qM7\021V\001VM\001!YM6nFVxktV\001M!YMY\015VM\v\021qM\024VqtFF\021v\127tBvMb\021\015V\021qM\001!M\023tBq\021v=>"),
        Media = zmediaMarktfrau_Ausschnitt
      },
      {
        Text = _OCpG(">6kn\021V\001k\015'BM\015FVM\021qM\014tv\001M\127k\021\015'BM2nqM\024'Bq\021')M\014\021bnq\v\021vM!v\vMY\021\015vV\021CM\vtFFMF\021\015v\021M@\015\014\015Vtk)tY\021qtMb\021\014MF\021\015=M@\015\021MBt\021VV\021M\021qM\127\021\015YMa\015v)t!\023\021vM\015vM\v\021qMwkVYtq)V\014tk\021q\015\021M\021\127\021vMvn'BM\127\021\015MF\015'BM\014\021Bt\127V=MaqM!\021\127\021qk\021\014V\021M)!q\001CMn\127M\021qM\vtB\015vM\001!q!\021')Mkt!\023\021vMFnkk\021=MavVF'B\015\021\vMF\015'BM\vtvvMt\127\021qM!YM!v\vMqtvvV\021Ms\015'BV!v\014M6nFVxktV\001M\023nqV===a\015vMF\021kVFtY\021qM\005t!\001CMbtFG>"),
        Media = zmediaMarktfrau_Ausschnitt
      }
    })
    ztaskAltmarkt.Active = false
    ztaskAltmarkt.Complete = true
    zoneAltmarktgalerie.Active = true
    zoneAltmarktgalerie.Visible = true
    zitemDigitalkamera:MoveTo(zoneAltmarktgalerie)
    ztaskZurAltmarktgalerie.Active = true
  else
    _Urwigo.MessageBox({
      Text = _OCpG("@tFFM\v\015\021M_\021!V\021MB\021!V\001!Vt\014\021MF'BnvM@\015\014\015Vtk)tY\021qtFM2\021qk\015\021q\021v===M\024nMbtF;===M\024'Bn\021v\021vMet\014Mvn'B;"),
      Media = zmediaMarktfrau_Ausschnitt
    })
  end
end
function zcharacterMaedchen:OnSprechen(target)
  if ztaskFuerstenzuganschauen.Complete == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">d\015\021k\021vM@tv)Mvn'BM\021\015vYtkCM\vtFFM\024\015\021MY\015qM\014\021Bnk\023\021vMBt\127\021v=M\019'BMY!FFM7\021V\001VMb\021\015V\021q=>"),
      Media = zmediaMaedchen_Ausschnitt
    })
    zcharacterMaedchen.Visible = false
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(zinputPersoninFuerstenzug)
    end)
  end
end
function zitemTaschentuecher:OnGeben(target)
  if ztaskHofkircheangucken.Active == true then
    zitemTaschentuecher.Visible = false
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">{BCM2\015\021k\021vM@tv);M@tFM\015FVMF\021BqMv\021VVM2nvM\019Bv\021v=M\030\021V\001VM)tvvM\015'BMY\015qM\v\021vM\024'Bb\021\015FFM2nvM\v\021qM\024V\015qvMb\015F'B\021v===M!v\vMY\021\015v\021M$q\015kk\021Mx!V\001\021v;M4\015B\015=>"),
        Media = zmediaNetterHerr_Ausschnitt
      },
      {
        Text = _OCpG(">@tM\023t\021kkVMY\015qM\014\021qt\v\021M\021\015v===M\024\015\021MFt\014V\021vCM\v\021qM@\015\021\127MFnkkM!\021\127\021qM\v\015\021Mw!\014!FV!F\127q!\021')\021MF\021\015vGMdnqB\015vM\015FVM\021\015vMTtvvMB\015\021qM2nq\127\021\015\014\021qtvvV=MaqMBtVM\021\015v\021YMeNx\021vMY\015VM\021\015v\021qMq\015\021F\021vM\024nvv\021v\127q\015kk\021M\021\015v\021vM\005n\023\023\021qM\015vM\v\015\021M4tv\vM\014\021\vq!\021')VM!v\vM\015FVM\vtvvM!\021\127\021qM\v\015\021M$q!\021')\021Mb\021\015V\021q=M@\021qMTtvvMY\015VM\v\021qM\024nvv\021v\127q\015kk\021Mt\127\021qM\015FVM\vnqVMq!\021\127\021qM\015vM\v\015\021M,tFF\021MY\015VM\v\021YM-!\021qFV\021v\001!\014M\014\021kt!\023\021v===>"),
        Media = zmediaNetterHerr_Ausschnitt
      },
      {
        Text = _OCpG(">{BCMF'Bt!\021vM\024\015\021MYtk;M@tM\vq!\021\127\021vMk\015\021\014\021vM\001b\021\015Ma!qnMt!\023M\v\021qM!vV\021qFV\021vMeq\021xx\021vFV!\023\021=M@\015\021MBtVMbnBkM7\021Ytv\vM2\021qknq\021v;>"),
        Media = zmediaNetterHerr_Ausschnitt
      }
    })
    zitemTaschentuecher.Commands.Geben.Enabled = false
    zitem2Euro:MoveTo(zoneHofkirche)
    zitem2Euro.Visible = true
    ztaskHofkircheangucken.Complete = true
    ztaskGehezumFuerstenzug.Active = true
    zoneFuerstenzug.Active = true
    zoneFuerstenzug.Visible = true
    zcharacterMaedchen:MoveTo(zoneFuerstenzug)
    zcharacterWuerstchenverkaufer:MoveTo(zoneFuerstenzug)
  else
    _Urwigo.MessageBox({
      Text = _OCpG("1\021\021CM\v\015\021M\127\021BtkVM\015'BMYtkMk\015\021\127\021q=Md\015\021kk\021\015'BVMBnkM\015'BMY\015qMvn'BM\021\015v\021vM\024'Bv!x\023\021v==="),
      Media = zmediaTaschentuecher_komplett
    })
  end
end
function zitem2Euro:OnGeben(target)
  if ztaskJungespieltGeige.Active == true then
    zitem2Euro:MoveTo(zcharacterGeigespielenderJunge)
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">{BCM\vtFM\015FVMk\015\021\127=Md\015\021k\021vM@tv);;;>"),
        Media = zmediaJungerGeiger_komplett
      },
      {
        Text = _OCpG(">\024nkkM\015'BM\019Bv\021vMYtkMbtFM\005nY\015F'B\021FM\021q\001t\021Bk\021vGM\019YY\021qMb\021vvM\015'BMYtkM\vq\015v\014\021v\vM\023!\021qM)k\021\015v\021M\030!v\014FMY!FFCMkt\021FFVMY\015'BM\v\021qM6nqV\015\021qM\015vFM4\015kVnvM4nV\021kMt!\023M\v\015\021Men\015k\021VV\021M\014\021B\021v=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      },
      {
        Text = _OCpG(">wkFM\015'BM2nqM\021\015vMxttqMT\015v!V\021vM\014\021qt\v\021M\vnqVMbtqCMBn\021qV\021M\015'BM\015vM\v\021qM1t'B\127tq)t\127\015v\021M\021\015v\021vMTtvvMV\021k\021\023nv\015\021q\021v=M@\021qM)ktv\014M\014tv\001Mt!\023\014\021q\021\014VM!v\vMY\021\015vV\021M\127\021\014\021\015FV\021qVCM\vtFFM\021qM\v\021vM\014q!\021v\021vM\024V\021\015vMBtVCM!v\vMF'Bv\021kkM\001!YMeq\021\023\023x!v)VM)nYYV=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      },
      {
        Text = _OCpG(">dnqB\021qMb\015kkM\021qMF\015'BMt\127\021qMvn'BMF'Bv\021kkM\v\015\021M-qt!\021v)\015q'B\021Mtv\014!')\021v===M\005nY\015F'BCMn\v\021qGM===M{BM\015'BMY!FFMb\021\015V\021qFx\015\021k\021v=MaFMF\015v\vM\014\021qt\v\021M2\015\021k\021M_\021!V\021M\vt=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      }
    })
    ztaskJungespieltGeige.Complete = true
    ztaskZurFrauenkirche.Active = true
    zoneFrauenkirche.Active = true
    zoneFrauenkirche.Visible = true
    zcharacterBettler.Visible = false
    zcharacterOrdnerin:MoveTo(zoneFrauenkirche)
    zitemParkzettel:MoveTo(zoneFrauenkirche)
  else
    _Urwigo.MessageBox({
      Text = _OCpG("1\021\021CM\v\015\021M\127\021BtkV\021M\015'BMk\015\021\127\021qM!v\vM)t!\023\021MY\015qMbtFM_\021')\021q\021FM\001!MaFF\021v=MTBY==="),
      Media = zmediaEuro_komplett
    })
  end
end
function zitem2Euro:OnNehmen(target)
  zitem2Euro:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _OCpG("1\021!\021FM\019v2\021vVtq\aMPMa!qn")
  })
  zitem2Euro.Commands.Nehmen.Enabled = false
end
function zitemParkzettel:OnNehmen(target)
  zitemParkzettel:MoveTo(Player)
  zitemParkzettel.Commands.Nehmen.Enabled = false
  _Urwigo.OldDialog({
    {
      Text = _OCpG(">$\015VV\021MF'Bn\021v;MT\015VM\v\021YM6tq)\001\021VV\021kM)tvvM\015'BM\021BMv\015'BVFMtv\023tv\014\021v=M\003\021vvM\024\015\021MF\015'BM\127\021\021\015k\021vCM\021qb\015F'B\021vM\024\015\021M\v\021vM@q\021Bnq\014\021kFx\015\021k\021qMtYM\005!kV!qxtktFV=M@\021qM\021q\001t\021BkVM\015YY\021qMFnMk!FV\015\014\021M,\021F'B\015'BV\021v=>M"),
      Media = zmediaOrdnerin_Ausschnitt
    },
    {
      Text = _OCpG(">wkk\021q\v\015v\014FMBt\127\021vM\024\015\021Mv!qMvn'BM5MT\015v!V\021vM\t\021\015V=M@tvt'BMYt'BVM\021qM-\021\015\021qt\127\021v\v===M4\015\021qMBt\127\021vM\024\015\021M\021\015v\021M\024tv\v!Bq=M@tMF\021B\021vM\024\015\021CMb\015\0212\015\021kM\t\021\015VMF'BnvM2\021q\014tv\014\021vM\015FV=>"),
      Media = zmediaOrdnerin_Ausschnitt
    }
  })
  zoneKulturpalast.Active = true
  zoneKulturpalast.Visible = true
  ztaskZumKulturpalast.Active = true
  ztaskFrauenkircheangucken.Complete = true
  zcharacterDrehorgelspieler:MoveTo(zoneKulturpalast)
  zitemSanduhr:MoveTo(Player)
  zitemSanduhr.Visible = true
end
function zitemParkzettel:OnZeigen(target)
  if ztaskParkzettel.Active == true then
    zitemParkzettel.Commands.Zeigen.Enabled = false
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">\003tFMFnkkM\015'BMY\015VM\v\021YM6tq)\001\021VV\021kG>"),
        Media = zmediaDrehorgellspieler_Ausschnitt
      },
      {
        Text = _OCpG(">\t\021\015\014\021vM\024\015\021MYtk;===M@tFM\015FVM\014tv\001M\021\015v\023t'B=M@\021qM\014\021Bn\021qVM\001!qMe\015\021\023\014tqt\014\021M!vV\021qM\v\021YMwkVYtq)V=M,k\021\015'BMt!\023M\v\021qMtv\v\021q\021vM\024\021\015V\021M\v\021qM\024VqtFF\021===M%v\vMbtFMbnkk\021vM\024\015\021M\vtY\015VGM\0194sMw!VnMF'B\021\015vVM\vtM7tMv\015'BVM\001!MFV\021B\021vCMb\021vvM\024\015\021M\v\021vM6tq)F'B\021\015vM,a-%1@a1MBt\127\021v===>"),
        Media = zmediaDrehorgellspieler_Ausschnitt
      }
    })
    ztaskParkzettel.Complete = true
    ztaskAltmarkt.Active = true
    zoneAltmarktTiefgarage.Active = true
    zoneAltmarktTiefgarage.Visible = true
    zcharacterMarktfrau:MoveTo(zoneAltmarktTiefgarage)
  else
    _Urwigo.MessageBox({
      Text = _OCpG("1\021\015vCMbn\001!M\001\021\015\014\021vGM\019'BM)\021vv\021M\015BvM\vn'BMvn'BM\014tqMv\015'BV="),
      Media = zmediaParkschein_komplett
    })
  end
end
function zitemWurstgutschein:OnGeben(target)
  if zcharacterGeigespielenderJunge.Visible == true then
    _Urwigo.MessageBox({
      Text = _OCpG(">\024\015\021MBt\127\021vM\021\015v\021vM,!VF'B\021\015vM\023!\021qM\021\015v\021M$qtVb!qFVGMwkk\021FM)ktq=M4\015\021qCM\127\015VV\021F'Bn\021v=M_tFF\021vM\024\015\021M\021FMF\015'BMF'BY\021')\021v=>"),
      Media = zmediaWuerstelmann_Ausschnitt
    })
    zitemWurstgutschein:MoveTo(zcharacterWuerstchenverkaufer)
    zitemWurstgutschein.Commands.Geben.Enabled = false
    zitemBratwurst:MoveTo(Player)
    zitemBratwurst.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _OCpG(">\019'BMBt\127\021Mvn'BMv\015'BVM\014\021n\021\023\023v\021V;>"),
      Media = zmediaWuerstelmann_nichtfertig
    })
  end
end
function zitemWurstgutschein:On_dSEW(target)
  _Urwigo.MessageBox({
    Text = _OCpG(">TYYB=Ma\015v\021M$qtVb!qFVMb!\021q\v\021M\015'BM7\021V\001VM\014\021qvM\021FF\021v=Mw\127\021qM\015'BM)tvvMB\015\021qMv\015'BVMb\021\014=>"),
    Media = zmediaJungerGeiger_Ausschnitt
  })
end
function zitemBratwurst:OnGeben(target)
  if not zcharacterGeigespielenderJunge:Contains(zitem2Euro) then
    zitemBratwurst:MoveTo(zcharacterGeigespielenderJunge)
    zitemBratwurst.Commands.Geben.Enabled = false
    _Urwigo.OldDialog({
      {
        Text = _OCpG(">{BCM\vtFM\015FVMk\015\021\127=Md\015\021k\021vM@tv);;;>"),
        Media = zmediaJungerGeiger_Ausschnitt
      },
      {
        Text = _OCpG(">\024nkkM\015'BM\019Bv\021vMYtkMbtFM\005nY\015F'B\021FM\021q\001t\021Bk\021vGM\019YY\021qMb\021vvM\015'BMYtkM\vq\015v\014\021v\vM\023!\021qM)k\021\015v\021M\030!v\014FMY!FFCMkt\021FFVMY\015'BM\v\021qM6nqV\015\021qM\015vFM4\015kVnvM4nV\021kMt!\023M\v\015\021Men\015k\021VV\021M\014\021B\021v=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      },
      {
        Text = _OCpG(">wkFM\015'BM2nqM\021\015vMxttqMT\015v!V\021vM\014\021qt\v\021M\vnqVMbtqCMBn\021qV\021M\015'BM\015vM\v\021qM1t'B\127tq)t\127\015v\021M\021\015v\021vMTtvvMV\021k\021\023nv\015\021q\021v=M@\021qM)ktv\014M\014tv\001Mt!\023\014\021q\021\014VM!v\vMY\021\015vV\021M\127\021\014\021\015FV\021qVCM\vtFFM\021qM\v\021vM\014q!\021v\021vM\024V\021\015vMBtVCM!v\vMF'Bv\021kkM\001!YMeq\021\023\023x!v)VM)nYYV=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      },
      {
        Text = _OCpG(">dnqB\021qMb\015kkM\021qMF\015'BMt\127\021qMvn'BMF'Bv\021kkM\v\015\021M-qt!\021v)\015q'B\021Mtv\014!')\021v===M\005nY\015F'BCMn\v\021qGM===M{BM\015'BMY!FFMb\021\015V\021qFx\015\021k\021v=MaFMF\015v\vM\014\021qt\v\021M2\015\021k\021M_\021!V\021M\vt=>"),
        Media = zmediaJungerGeiger_Ausschnitt
      }
    })
    ztaskJungespieltGeige.Complete = true
    ztaskZurFrauenkirche.Active = true
    zoneFrauenkirche.Active = true
    zoneFrauenkirche.Visible = true
    zcharacterOrdnerin:MoveTo(zoneFrauenkirche)
    zitemParkzettel:MoveTo(zoneFrauenkirche)
    zoneFuerstenzug.Visible = false
    zoneFuerstenzug.Active = false
  else
    _Urwigo.MessageBox({
      Text = _OCpG(">@tFM\015FVMk\015\021\127=Md\015\021k\021vM@tv);MTYYB=M\024'BY\021')VM\v\015\021Mk\021')\021q=M>"),
      Media = zmediaJungerGeiger_Ausschnitt
    })
  end
end
function zitemBratwurst:OnVerzehren(target)
  if not zcharacterGeigespielenderJunge:Contains(zitem2Euro) then
    _Urwigo.MessageBox({
      Text = _OCpG("$\015FVM\v!M\v\015qMF\015'B\021qCM\vtFFM\v!M\v\015\021Mb\015q)k\015'BMF\021k\127\021qM\021FF\021vMb\015kkFVG"),
      Buttons = {
        _OCpG("\030t=M\019'BMBt\127\021M4!v\014\021q="),
        _OCpG("1\021\015v=")
      },
      Callback = function(action)
        if action ~= nil and action == "Button1" then
          _Urwigo.MessageBox({
            Text = _OCpG("@\015\021MF'BY\021')VMb\015q)k\015'BMF\021BqMk\021')\021q=Mwkk\021q\v\015v\014FCMbtFM\014\021\127\021M\015'BM7\021V\001VM\v\021YM\030!v\014\021vM,\021\015\014\021qGM===MT\015FVCMY\015qMb\015q\vM\014tv\001M!\021\127\021k=M\024'B\021\015v\127tqMBt\127\021M\015'BM\v\015\021M\003!qFVMv\015'BVM2\021qVqt\014\021v=M@tFMbtqM\021FM\vtvvMY\015VMY\021\015v\021YMw\127\021vV\021!\021q===Mw%\024M%1@Md{s$a\019=M@tMY!FFM\015'BMbnBkMb\015\021\v\021qM2nvM2nqvMtv\023tv\014\021v===")
          })
          zitemBratwurst:MoveTo(zoneGruenesGewoelbe)
          zitemBratwurst.Visible = false
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _OCpG("\024'BY\021')VM\vtFMk\021')\021q=M\024nMYt'BVM@\021V\021)V\0152tq\127\021\015VM\024xtFF="),
      Media = zmediaBratwurst_komplett
    })
    zitemBratwurst.Visible = false
  end
end
function zitemSanduhr:OnAngucken(target)
  _Urwigo.MessageBox({
    Text = (((_OCpG("$\015FM7\021V\001VMF\015v\vM") .. VarMin) .. _OCpG("MT\015v!V\021vM!v\vM")) .. VarSek) .. _OCpG("M\024\021)!v\v\021vM2\021q\014tv\014\021v="),
    Media = zmediaSanduhr_komplett
  })
end
function zitemDigitalkamera:OnAnschalten(target)
  ztaskDigitalkamera.Complete = true
  _Urwigo.OldDialog({
    {
      Text = _OCpG("\024'B\021\015vVM\001!M\023!v)V\015nv\015\021q\021v===M{\127M\v\015\021M\v\021YM@\015\021\127M\014\021Bn\021qVMBtVGG"),
      Media = zmediaDigicam_komplett
    },
    {
      Text = _OCpG("\019'BMF'Bt!\021MY\015qMYtkM\v\015\021Mk\021V\001V\021vM$\015k\v\021qMtvCM2\015\021kk\021\015'BVM\021vV\v\021')\021M\015'BM7tM\021\015v\021vM4\015vb\021\015FMt!\023M\v\021vM,q!\021v\021vM@\015tYtvV\021v===G"),
      Media = zmediaDigicam_komplett
    }
  })
  zitemDigitalkamera.Commands.Anschalten.Enabled = false
  zitemDigitalkamera.Commands.Bilderanschauen.Enabled = true
end
function zitemDigitalkamera:OnNehmen(target)
  zitemDigitalkamera:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _OCpG("\003nb=M@\015\021Mk\015\021\014VMB\015\021qM\021\015v\023t'BMFnMq!Y===M\003\021vvM\024\015\021Mv\015\021Ytv\vM\014\021Bn\021qVCMv\021BY\021M\015'BMF\015\021===M,k\021\015'BMYtkMtvF'BtkV\021v==="),
    Media = zmediaDigicam_komplett
  })
  zitemDigitalkamera.Commands.Nehmen.Enabled = false
  zitemDigitalkamera.Commands.Anschalten.Enabled = true
end
function zitemDigitalkamera:OnBilderanschauen(target)
  _Urwigo.MessageBox({
    Text = _OCpG("wBt===M\019'BM)tvvM\v\021vMa\015v\014tv\014M\021q)\021vv\021vCM2\015\021k\021M_\021!V\021CM\v\015\021M\021\015vIM!v\vMt!FFVqn\021Y\021v===M%v\vMB\015\021qMFV\021B\021vM\v\015\021M\005nnq\v\015vtV\021vCMbnM\vtFM$\015k\vMt!\023\014\021vnYY\021vMb!q\v\021M===M1MA\018M,qt\vMjP=cPjMaMj\018LM,qt\vMii=\018A\018\026$s?d\015\021kk\021\015'BVMBtVM\v\021qM@\015\021\127M\vnqVM\v\021vM,q!\021v\021vM@\015tYtvV\021vM2\021qFV\021')V===G")
  })
  ztaskDerGrueneDiamant.Active = true
  zitemDerGrueneDiamant:MoveTo(zoneAltmarktgalerie)
  zitemDerGrueneDiamant.Visible = true
end
function zitemDerGrueneDiamant:OnGEFUNDEN(target)
  _Urwigo.MessageBox({
    Text = _OCpG("4tFVM\v!M\v\021vM,q!\021v\021vM@\015tYtvV\021vM\016M,\021n't'B\021MF'BnvM\014\021\023!v\v\021vGGGM%v\127\021\v\015v\014VM\003w4s4a\019e\024,aTwa\024\024M\127\021tvVbnqV\021v;"),
    Media = zmediaGruenerDiamant_komplett,
    Buttons = {
      _OCpG("\030t;"),
      _OCpG("_\021\015\v\021qMv\021\015v=")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          zitemDerGrueneDiamant:MoveTo(Player)
          cartDerGrueneDiamant.Complete = true
          _Urwigo.OldDialog({
            {
              Text = _OCpG("4%ssw;M,swe%_we\019{1;;;M@!MBtFVM\v\021vMb\021qV2nkk\021vM,q!\021v\021vM@\015tYtvV\021vM\014\021\023!v\v\021v=M@tMb\015q\vMF\015'BM\vtFM,q!\021v\021M,\021bn\021k\127\021Mt\127\021qM\023q\021!\021v="),
              Media = zmediaGruenerDiamant_komplett
            },
            {
              Text = _OCpG("\019'BMBn\023\023\021CM\vtFFM\v\015qM\vtFM\024x\015\021k\021vM2nvM>@\015\021M\030t\014\vMvt'BM\v\021YM,q!\021v\021vM@\015tYtvV\021v>M\014\021\023tkk\021vMBtVM!v\vM\023q\021!\021MY\015'BM!\021\127\021qM\v\021\015v\021vM_n\014\021\015vVqt\014M\127\021\015M\014\021n't'B\015v\014='nYM!v\vMbB\021q\015\014n='nY\026$s?$\015VV\021Mv\015'BVFM\001!YM-\015vtkMFxn\015k\021qv;M@tv)\021=")
            },
            {
              Text = _OCpG("$\015VV\021MB\015k\023CM\vtFM-\015vtkM\024w%$asM!v\vM{s@a1e_\019m4M\001!MBtkV\021v=Md\015\021k\021vM@tv);")
            },
            {
              Text = _OCpG("-tkkFM\v!Mt!'BMt!\023Mbbb=bB\021q\015\014n='nYMkn\014\014\021vMb\015kkFVCM\127\021)nYYFVM\v!Mt!\023M\v\021qMvt\021'BFV\021vM\024\021\015V\021M\v\021vM%vkn')Imn\v\021=MwvY\021q)!v\014\aMbB\021q\015\014n='nYM\014\021Bn\021qVMb\015\021M\014\021n't'B\015v\014='nYM\001!M,qn!v\vFx\021t)=M@nqVMb\021q\v\021vM\v\015\021M\003B\021q\015\014nI\024x\015\021k\021M\004mtqVq\015\v\014\021FrMBn'BIM\127\001b=Mq!vV\021q\014\021kt\v\021v=M@!M)tvvFVM\vnqVMkn\014\014\021vM!v\vM\v\021\015vM\024x\015\021kMY\015VM\v\021YM%vkn')Imn\v\021MtkFM>\023\021qV\015\014M\014\021Fx\015\021kV>M\023q\021\015F'BtkV\021v=")
            },
            {
              Text = string.sub(Player.CompletionCode, 1, 15)
            },
            {
              Text = _OCpG("\019'BMb!\021vF'B\021Mb\021\015V\021qB\015vM2\015\021kM\024xtFFM\127\021\015YMmt'B\021v=\026$s?1tVB!F")
            }
          })
        else
          _Urwigo.OldDialog({
            {
              Text = _OCpG("4Y===M2\015\021kk\021\015'BVMB\021\015FFVM\021FMv\015'BVM@asM,q!\021v\021M@\015tYtvVCMFnv\v\021qvM@w\024M,q!\021v\021M@\015tYtvVI===G")
            },
            {
              Text = _OCpG("@\015\021M\005nnq\v\015vtV\021vMF\015v\vMF\021BqM\014\021vt!=Mwkk\021q\v\015v\014FMv!qMt!\023M\v\021qM\005tqV\021=Mw!\023\014q!v\vM\v\021qMw\127F'BtVV!v\014M\v\021FM,\021\127t\021!\v\021FMtq\127\021\015V\021VM\v\021\015vM,6\024Is\021'\015\0212\021qMBn\021'BFVbtBqF'B\021\015vk\015'BMF\021BqM!v\014\021vt!=M-nk\014\021MtkFnMv\015'BVM\v\021YM\005nYxtFFCMFnv\v\021qvMF'Bt!\021Mt!\023M\v\015\021M\005tqV\021M\004tYM$\021FV\021vM,nn\014k\021M\024tV\021kk\015V\021vMwvF\015'BVr;")
            },
            {
              Text = _OCpG("@!MY!FFVM\vtFM,\021\127t\021!\v\021M1\019m4eM\127\021Vq\021V\021vCMt\127\021qMvtB\021MqtvMFnkkV\021FVM\v!MF'BnvM)nYY\021v===")
            },
            {
              Text = _OCpG("@!MY!FFVMv\015'BVFMd\021q\127nV\021v\021FMn\v\021qMw!\023\023t\021kk\015\014\021FMV!v=M\024!'B\021MY\015VM\v\021\015v\021vMw!\014\021v;MaqFVMb\021vvM\v!M\v\021vM,s%a1a1M@\019wTw1ea1M\014\021\023!v\v\021vMBtFVCM\014q\021\015\023\021M\001!=M\003\021qM\015q\014\021v\vbnM\015YM@q\021')Mb!\021BkVCMk\015\021\014VM\v\021\023\015v\015V\0152M\023tkF'B=M6\023ktv\001\021vM!v\vM\v\015\021M\024Vt\vVYn\v\021kk\021MF\015v\vMVt\127!;")
            },
            {
              Text = _OCpG("@!M\023\015v\v\021FVM\015YY\021qMvn'BMv\015'BVFGMw'BMFnCM\v!M)nYYFVMv\015'BVMt!FM\v\021qM\021B\021Ytk\015\014\021vM@@sM\arM$\0212nqM\v!M2\021q\001b\021\015\023\021kFVCMq!\023M\vn'BM\021\015v\023t'BMtv\aMj\0185`I`PM\018PM\018jMP\018=Mwkk\021M{FF\015FMFnkkV\021vMF\015'BMt\127\021qMB!\021V\021vM!v\vM\015Bq\021vMd\021qFVtv\vM\021\015vF'BtkV\021vM\arrr")
            }
          })
        end
      end
    end
  })
end
cartDerGrueneDiamant.MsgBoxCBFuncs = {}
function cartDerGrueneDiamant.MsgBoxCBFuncs.MsgBoxCB3(action)
  if action == "Button1" then
    Wherigo.MessageBox({
      Text = "Die schmeckt wirklich sehr lecker. Allerdings, was gebe ich jetzt dem Jungen Geiger? ... Mist, mir wird ganz uebel. Scheinbar habe ich die Wurst nicht vertragen. Das war es dann mit meinem Abenteuer... AUS UND VORBEI. Da muss ich wohl wieder von vorn anfangen..."
    })
    zitemBratwurst.Visible = false
  end
end
function cartDerGrueneDiamant.MsgBoxCBFuncs.MsgBoxCB2(action)
  if action == "Button2" then
    zitem2Euro:MoveTo(zcharacterBettler)
    Wherigo.MessageBox({
      Text = "\"Oh, Danke! Jetzt verrate ich Ihnen mal was: Mit dem Geld gehe ich in den naechsten Supermarkt und hole mir was zu saufen... Haha... Und weg bin ich. Hahaaa...\"",
      Media = zmediaBettler_Ausschnitt
    })
    zcharacterBettler.Visible = false
    zcharacterBettler:MoveTo(zoneGruenesGewoelbe)
  else
    Wherigo.MessageBox({
      Text = "\"Dann erfahren Sie das Geheimnis halt nicht. Sie alter Knauser!\"",
      Media = zmediaBettler_Ausschnitt
    })
  end
end
function cartDerGrueneDiamant.MsgBoxCBFuncs.MsgBoxCB1(action)
  if action == "Button1" then
    zitemTaschentuecher:MoveTo(Player)
  end
end
function cartDerGrueneDiamant.MsgBoxCBFuncs.MsgBoxCB4(action)
  if action == "Button1" then
    Wherigo.Dialog({
      {
        Text = "HURRA! GRATULATION!!! Du hast den wertvollen Gruenen Diamanten gefunden. Da wird sich das Gruene Gewoelbe aber freuen.",
        Media = zmediaGruenerDiamant_komplett
      },
      {
        Text = "Ich, Nathus, der ich diesen Wherigo programmiert habe, hoffe, dass dir das Spielen von \"Die Jagd nach dem Gruenen Diamanten\" gefallen hat und freue mich ueber deinen Logeintrag bei GC.com und wherigo.com"
      },
      {
        Text = "Ich wuensche weiterhin viel Spass beim Cachen."
      }
    })
  else
    Wherigo.MessageBox({
      Text = "Schau dir mal den Lueftungsschacht genau an... VORSICHTIG ziehen! Und lass dich nicht erwischen!"
    })
  end
end
return cartDerGrueneDiamant
