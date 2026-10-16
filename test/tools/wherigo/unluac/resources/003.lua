require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _xcL(str)
  local res = ""
  local dtable = "\r6\002k\014\"Q-\017eP\027\023E'7M\022Tn\020#4&\001]8Io\015\018;s=/\f\005u\0212U\0160\004>.\vX\t5GhDV(:W@?alvm\\)LAO{\a9jq$\003K\nxR*3f\b\026gc%\031~\019br\025y, wt\000\028d[Y\030iB^}CSJ_\024Z\029<`1p+zFN!|\006H"
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
_DSDk = Wherigo.ZCartridge()
_v9k = Wherigo.ZMedia(_DSDk)
_v9k.Id = "9bcb7f15-0d40-435b-938b-2a6699896197"
_v9k.Name = _xcL("j\\i\020U4<&!\n\020`j<&?\\\n!b")
_v9k.Description = ""
_v9k.AltText = ""
_v9k.Resources = {
  {
    Type = "jpg",
    Filename = "Alt-BringhausenHolzalternative.jpg",
    Directives = {}
  }
}
_QAjd = Wherigo.ZMedia(_DSDk)
_QAjd.Id = "ff858b9e-2ffe-417a-9b1a-05b09620cbab"
_QAjd.Name = _xcL("j\\i\020U4<&!\n\020`9\nU`y&?`z\\i\ne4\029R")
_QAjd.Description = ""
_QAjd.AltText = ""
_QAjd.Resources = {
  {
    Type = "jpg",
    Filename = "Alt-BringhausenWegFriedhof.jpg",
    Directives = {}
  }
}
_rgT = Wherigo.ZMedia(_DSDk)
_rgT.Id = "cb350cf7-72f8-496b-97ac-31c689f54ac3"
_rgT.Name = _xcL("j\\i\020U4<&!\n\020`3\\&\020e?<&\n\\\020`\127\029=y")
_rgT.Description = ""
_rgT.AltText = ""
_rgT.Resources = {
  {
    Type = "jpg",
    Filename = "Alt-BringhausenHolz.jpg",
    Directives = {}
  }
}
_6zi = Wherigo.ZMedia(_DSDk)
_6zi.Id = "86ad8465-3dae-4b87-8562-32d87d9ff2fb"
_6zi.Name = _xcL("j\\i\020U4<&!\n\020`<=b`j\\&\nV\004\n")
_6zi.Description = ""
_6zi.AltText = ""
_6zi.Resources = {
  {
    Type = "jpg",
    Filename = "Alt-Bringhausen1.jpg",
    Directives = {}
  }
}
_5yR71 = Wherigo.ZMedia(_DSDk)
_5yR71.Id = "38983ed3-aef3-4d82-888e-9668abf3a140"
_5yR71.Name = _xcL("j\\i\020U4<&!\n\020`<=b")
_5yR71.Description = ""
_5yR71.AltText = ""
_5yR71.Resources = {
  {
    Type = "jpg",
    Filename = "Alt-Bringhausen2.jpg",
    Directives = {}
  }
}
_CLtw2 = Wherigo.ZMedia(_DSDk)
_CLtw2.Id = "fe00f560-c0ff-4094-aafa-2164364acc45"
_CLtw2.Name = _xcL("C!\n=`j\\&\nV\004\n")
_CLtw2.Description = ""
_CLtw2.AltText = ""
_CLtw2.Resources = {
  {
    Type = "jpg",
    Filename = "Asel-Brucke.jpg",
    Directives = {}
  }
}
_634J = Wherigo.ZMedia(_DSDk)
_634J.Id = "b50e36af-bbfc-4c1e-99f6-fe7b590bf193"
_634J.Name = _xcL("C!\n=`5\n\020\004?<=")
_634J.Description = ""
_634J.AltText = ""
_634J.Resources = {
  {
    Type = "jpg",
    Filename = "Asel-Denkmal.jpg",
    Directives = {}
  }
}
_Kn_B = Wherigo.ZMedia(_DSDk)
_Kn_B.Id = "dfa9ba35-76aa-441f-9c48-42a8456e2311"
_Kn_B.Name = _xcL("C!\n=`5\029\\RU\n?\ni\020!V4<Rb")
_Kn_B.Description = ""
_Kn_B.AltText = ""
_Kn_B.Resources = {
  {
    Type = "jpg",
    Filename = "Asel-Dorfgemeinschaft.jpg",
    Directives = {}
  }
}
_VV6LJ = Wherigo.ZMedia(_DSDk)
_VV6LJ.Id = "eb4d6c60-2cc5-4131-942b-54a0d7e85d79"
_VV6LJ.Name = _xcL("C!\n=`z\\i\ne4\029R")
_VV6LJ.Description = ""
_VV6LJ.AltText = ""
_VV6LJ.Resources = {
  {
    Type = "jpg",
    Filename = "Asel-Friedhof.jpg",
    Directives = {}
  }
}
_PXR = Wherigo.ZMedia(_DSDk)
_PXR.Id = "c6c01a81-e613-4c99-bb7f-14163ba33ed1"
_PXR.Name = _xcL("nb&R\n`v`nw\029i=\n\\`(")
_PXR.Description = ""
_PXR.AltText = ""
_PXR.Resources = {
  {
    Type = "jpg",
    Filename = "Stufe1Foto2.jpg",
    Directives = {}
  }
}
_uUJ = Wherigo.ZMedia(_DSDk)
_uUJ.Id = "de0aabf5-dbfb-4940-9bb3-0797fcf53cfa"
_uUJ.Name = _xcL("nb&R\n`v`nw\029i=\n\\`v")
_uUJ.Description = ""
_uUJ.AltText = ""
_uUJ.Resources = {
  {
    Type = "jpg",
    Filename = "Stufe1Foto1.jpg",
    Directives = {}
  }
}
_QuGeS = Wherigo.ZMedia(_DSDk)
_QuGeS.Id = "bc4fa4e4-51fa-4b16-89b7-4db923b92c68"
_QuGeS.Name = _xcL("nb&R\n`(`nw\029i=\n\\")
_QuGeS.Description = ""
_QuGeS.AltText = ""
_QuGeS.Resources = {
  {
    Type = "jpg",
    Filename = "Stufe2Foto.jpg",
    Directives = {}
  }
}
_xdt = Wherigo.ZMedia(_DSDk)
_xdt.Id = "a348d83b-8886-4b1c-ae4c-8cf1d22ebec9"
_xdt.Name = _xcL("nb&R\n`Q`nw\029i=\n\\")
_xdt.Description = ""
_xdt.AltText = ""
_xdt.Resources = {
  {
    Type = "jpg",
    Filename = "Stufe3Foto.jpg",
    Directives = {}
  }
}
_mAok = Wherigo.ZMedia(_DSDk)
_mAok.Id = "b93d5cbc-3aa7-415c-8dfa-a040f7b71468"
_mAok.Name = _xcL("nw\n\\?<&\n\\?\029e\n==`\017\n!!&\020U")
_mAok.Description = ""
_mAok.AltText = ""
_mAok.Resources = {
  {
    Type = "jpg",
    Filename = "Sperrmauermessen.jpg",
    Directives = {}
  }
}
_vmjGe = Wherigo.ZMedia(_DSDk)
_vmjGe.Id = "c81dfc32-f0d7-4a1c-97bf-e9b6f9e0f946"
_vmjGe.Name = _xcL("nw\029i=\n\\`nb\ni\020")
_vmjGe.Description = ""
_vmjGe.AltText = ""
_vmjGe.Resources = {
  {
    Type = "jpg",
    Filename = "SpoilerStein.jpg",
    Directives = {}
  }
}
_7bou = Wherigo.ZMedia(_DSDk)
_7bou.Id = "7b1dc8b7-9285-4b7b-aba2-362b73f01be2"
_7bou.Name = _xcL("nw\029i=\n\\`\127\029=y`a\nib\n\\`a\nU")
_7bou.Description = ""
_7bou.AltText = ""
_7bou.Resources = {
  {
    Type = "jpg",
    Filename = "PlaketteBaum.jpg",
    Directives = {}
  }
}
_8GQO = Wherigo.ZMedia(_DSDk)
_8GQO.Id = "e4491612-317c-4abd-ac80-b48c3e00aa42"
_8GQO.Name = _xcL("nw\029i=\n\\`nb\ni\020`a\nib\n\\`a\nU")
_8GQO.Description = ""
_8GQO.AltText = ""
_8GQO.Resources = {
  {
    Type = "jpg",
    Filename = "PlaketteStein.jpg",
    Directives = {}
  }
}
_lsf = Wherigo.ZMedia(_DSDk)
_lsf.Id = "ad9ffd7a-5ce4-4fb7-8238-be93bc0a5da0"
_lsf.Name = _xcL("\v<\\\004\n\020`nb<&?<&\n\\")
_lsf.Description = ""
_lsf.AltText = ""
_lsf.Resources = {
  {
    Type = "jpg",
    Filename = "ParkenStaumauer.jpg",
    Directives = {}
  }
}
_cdjry = Wherigo.ZMedia(_DSDk)
_cdjry.Id = "69758f14-5386-4f4b-9c64-211ecd34be64"
_cdjry.Name = _xcL("nw\029i=\n\\`\127\029=y`v")
_cdjry.Description = ""
_cdjry.AltText = ""
_cdjry.Resources = {
  {
    Type = "jpg",
    Filename = "HolzSpoiler1.jpg",
    Directives = {}
  }
}
_RCtz = Wherigo.ZMedia(_DSDk)
_RCtz.Id = "38f33560-9c21-4834-8f33-eb9220a715fb"
_RCtz.Name = _xcL("j\\i\020U4<&!`z\\i\ne4\029R")
_RCtz.Description = ""
_RCtz.AltText = ""
_RCtz.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofAlt-Bringhausen.jpg",
    Directives = {}
  }
}
_WE5 = Wherigo.ZMedia(_DSDk)
_WE5.Id = "a4c6dee4-dc5c-44b5-aa06-aaa5e39b5d2e"
_WE5.Name = _xcL("j\n\\iV4`9\0294\0204<&!")
_WE5.Description = ""
_WE5.AltText = ""
_WE5.Resources = {
  {
    Type = "jpg",
    Filename = "BerichWohnhaus.jpg",
    Directives = {}
  }
}
_akoE = Wherigo.ZMedia(_DSDk)
_akoE.Id = "139c23de-6ce7-40d5-b171-9b68feb1033c"
_akoE.Name = _xcL("j\n\\iV4`z&bb\n\\b\\\029U")
_akoE.Description = ""
_akoE.AltText = ""
_akoE.Resources = {
  {
    Type = "jpg",
    Filename = "FuttertrogSpoiler.jpg",
    Directives = {}
  }
}
_Vsr = Wherigo.ZMedia(_DSDk)
_Vsr.Id = "e3d4555e-fab2-412c-8ce5-71b9c5dc57ae"
_Vsr.Name = _xcL("j\029H\n")
_Vsr.Description = ""
_Vsr.AltText = ""
_Vsr.Resources = {
  {
    Type = "jpg",
    Filename = "Boje.jpg",
    Directives = {}
  }
}
_qh3xQ = Wherigo.ZMedia(_DSDk)
_qh3xQ.Id = "81e7c691-de01-4e10-898d-50ef9ca4a36c"
_qh3xQ.Name = _xcL("O\n4[<V4`\017\n!!&\020U")
_qh3xQ.Description = ""
_qh3xQ.AltText = ""
_qh3xQ.Resources = {
  {
    Type = "jpg",
    Filename = "GleiseMessung.jpg",
    Directives = {}
  }
}
_bhir = Wherigo.ZMedia(_DSDk)
_bhir.Id = "ab902742-3350-4d87-be4e-c8783f357edb"
_bhir.Name = _xcL([[
O
4[<V4`nV4i=e]])
_bhir.Description = ""
_bhir.AltText = ""
_bhir.Resources = {
  {
    Type = "jpg",
    Filename = "GleiseSchild.jpg",
    Directives = {}
  }
}
_rd4iN = Wherigo.ZMedia(_DSDk)
_rd4iN.Id = "f72820ca-ffe2-421c-b9d4-41be5e9eeb9b"
_rd4iN.Name = _xcL("nb\ni\020`nw\029i=\n\\`U\n?&UU\n=b")
_rd4iN.Description = ""
_rd4iN.AltText = ""
_rd4iN.Resources = {
  {
    Type = "jpg",
    Filename = "Steingemuggelt.jpg",
    Directives = {}
  }
}
_ES1lQ = Wherigo.ZMedia(_DSDk)
_ES1lQ.Id = "205d9ae3-3515-480a-8393-a960b1357204"
_ES1lQ.Name = _xcL("\127\029=y`nw\029i=\n\\`U\n?&UU\n=b")
_ES1lQ.Description = ""
_ES1lQ.AltText = ""
_ES1lQ.Resources = {
  {
    Type = "jpg",
    Filename = "HolzSpoiler2.jpg",
    Directives = {}
  }
}
_NvO9 = Wherigo.ZMedia(_DSDk)
_NvO9.Id = "600c5ba1-4767-4077-8454-b529f778da62"
_NvO9.Name = _xcL("j\n\\iV4`z&bb\n\\b\\\029U")
_NvO9.Description = ""
_NvO9.AltText = ""
_NvO9.Resources = {
  {
    Type = "jpg",
    Filename = "BerichFuttertrog.jpg",
    Directives = {}
  }
}
_Z8iUX = Wherigo.ZMedia(_DSDk)
_Z8iUX.Id = "2d212d21-28ad-4171-af88-0fa5a55f4302"
_Z8iUX.Name = _xcL("\019ib\n=")
_Z8iUX.Description = ""
_Z8iUX.AltText = ""
_Z8iUX.Resources = {
  {
    Type = "jpg",
    Filename = "Titel.jpg",
    Directives = {}
  }
}
_aqLt = Wherigo.ZMedia(_DSDk)
_aqLt.Id = "e6627aef-4c25-477a-9b3a-cae2a233940d"
_aqLt.Name = _xcL("\019ib\n=`\004=\ni\020")
_aqLt.Description = ""
_aqLt.AltText = ""
_aqLt.Resources = {
  {
    Type = "jpg",
    Filename = "TitelIcon.jpg",
    Directives = {}
  }
}
_2xbNn = Wherigo.ZMedia(_DSDk)
_2xbNn.Id = "8b8a55b3-f83b-4213-948a-e27852198dce"
_2xbNn.Name = _xcL("\019<e<")
_2xbNn.Description = ""
_2xbNn.AltText = ""
_2xbNn.Resources = {
  {
    Type = "wav",
    Filename = "tada.wav",
    Directives = {}
  }
}
_d8s = Wherigo.ZMedia(_DSDk)
_d8s.Id = "db598b45-3885-4757-b5d0-b85f0be88f05"
_d8s.Name = _xcL("6\029\\\0204<U\n\020`nV4<R!b<==")
_d8s.Description = ""
_d8s.AltText = ""
_d8s.Resources = {
  {
    Type = "jpg",
    Filename = "VornhagenSchafstall.jpg",
    Directives = {}
  }
}
_2mq = Wherigo.ZMedia(_DSDk)
_2mq.Id = "7f7314dd-3442-42d7-997c-ee546713a0fe"
_2mq.Name = _xcL("j\n\\iV4`j\\&\nV\004\n")
_2mq.Description = ""
_2mq.AltText = ""
_2mq.Resources = {
  {
    Type = "jpg",
    Filename = "BerichBrucke.jpg",
    Directives = {}
  }
}
_BJLQ = Wherigo.ZMedia(_DSDk)
_BJLQ.Id = "984a0664-60d8-47a1-9c83-ba5d382a7c9c"
_BJLQ.Name = _xcL("j\n\\iV4`L=\029!b\n\\\\\n!b\n")
_BJLQ.Description = ""
_BJLQ.AltText = ""
_BJLQ.Resources = {
  {
    Type = "jpg",
    Filename = "BerichKloserreste.jpg",
    Directives = {}
  }
}
_cbG = Wherigo.ZMedia(_DSDk)
_cbG.Id = "12521274-4106-4b7d-ac31-9fd353ca3374"
_cbG.Name = _xcL("j\n\\iV4`\\<&V4\n\020e")
_cbG.Description = ""
_cbG.AltText = ""
_cbG.Resources = {
  {
    Type = "jpg",
    Filename = "Berichrauchend.jpg",
    Directives = {}
  }
}
_tmj = Wherigo.ZMedia(_DSDk)
_tmj.Id = "d7e38b19-12bd-49c9-88e0-f2d547cd2a69"
_tmj.Name = _xcL("j\n\\iV4`>\029\\`e\n\\`r\n\\!b\029\n\\&\020U")
_tmj.Description = ""
_tmj.AltText = ""
_tmj.Resources = {
  {
    Type = "jpg",
    Filename = "BerichvorderZerstorung.jpg",
    Directives = {}
  }
}
_FO3 = Wherigo.ZMedia(_DSDk)
_FO3.Id = "c6300294-3533-4c69-a089-d884010eda1e"
_FO3.Name = _xcL([[
j
\iV4]])
_FO3.Description = ""
_FO3.AltText = ""
_FO3.Resources = {
  {
    Type = "jpg",
    Filename = "Berich.jpg",
    Directives = {}
  }
}
_cNS2C = Wherigo.ZMedia(_DSDk)
_cNS2C.Id = "2cd63f74-aa0d-4489-8637-81a4c6f35975"
_cNS2C.Name = _xcL("j\n\\iV4\n\\`\127&\nbb\n`vGv(")
_cNS2C.Description = ""
_cNS2C.AltText = ""
_cNS2C.Resources = {
  {
    Type = "jpg",
    Filename = "BericherHutte1912.jpg",
    Directives = {}
  }
}
_cpK = Wherigo.ZMedia(_DSDk)
_cpK.Id = "140a7732-e0d2-4159-9557-f62534134cd9"
_cpK.Name = _xcL("j\n\\iV4\n\\`\127&\nbb\n`vG2Q")
_cpK.Description = ""
_cpK.AltText = ""
_cpK.Resources = {
  {
    Type = "jpg",
    Filename = "BericherHutte1953.jpg",
    Directives = {}
  }
}
_RP2 = Wherigo.ZMedia(_DSDk)
_RP2.Id = "15d21d15-a81d-4ba0-b8a5-dd59086d9bf2"
_RP2.Name = _xcL("j\n\\iV4\n\\`\127&\nbb\n`(+v\002")
_RP2.Description = ""
_RP2.AltText = ""
_RP2.Resources = {
  {
    Type = "jpg",
    Filename = "BericherHutte.jpg",
    Directives = {}
  }
}
_U3jv2 = Wherigo.ZMedia(_DSDk)
_U3jv2.Id = "53dfe897-f4c0-4f0a-a630-462c4a874482"
_U3jv2.Name = _xcL("j\\i\020U4<&!\n\020`j\\&\nV\004\n`C&!!V4\020ibb")
_U3jv2.Description = ""
_U3jv2.AltText = ""
_U3jv2.Resources = {
  {
    Type = "jpg",
    Filename = "BrueckeAlt-BringhausenAlt.jpg",
    Directives = {}
  }
}
_LwqV = Wherigo.ZMedia(_DSDk)
_LwqV.Id = "341cd69b-9b97-4fd3-902f-bf852f630f45"
_LwqV.Name = _xcL("j\\i\020U4<&!\n\020`j\\&\nV\004\n`(+v\002")
_LwqV.Description = ""
_LwqV.AltText = ""
_LwqV.Resources = {
  {
    Type = "jpg",
    Filename = "BrueckeAlt-Bringhausen.jpg",
    Directives = {}
  }
}
_tTBe = Wherigo.ZMedia(_DSDk)
_tTBe.Id = "dba582f5-35d0-4058-a4c8-1637db424fdf"
_tTBe.Name = _xcL("j&\\U`j\\i\020U`(+v\002")
_tTBe.Description = ""
_tTBe.AltText = ""
_tTBe.Resources = {
  {
    Type = "jpg",
    Filename = "BurgBring.jpg",
    Directives = {}
  }
}
_JtBnY = Wherigo.ZMedia(_DSDk)
_JtBnY.Id = "e47ba0c5-21f4-425a-8ea9-2cdc97615e44"
_JtBnY.Name = _xcL("j&\\U`\014=y")
_JtBnY.Description = ""
_JtBnY.AltText = ""
_JtBnY.Resources = {
  {
    Type = "jpg",
    Filename = "BurgElz.jpg",
    Directives = {}
  }
}
_JU_y = Wherigo.ZMedia(_DSDk)
_JU_y.Id = "f8402af1-b975-439f-92b3-b09cdfec555a"
_JU_y.Name = _xcL("j\n\\iV4`5\n\020\004?<=")
_JU_y.Description = ""
_JU_y.AltText = ""
_JU_y.Resources = {
  {
    Type = "jpg",
    Filename = "DenkmalBerich.jpg",
    Directives = {}
  }
}
_APWv = Wherigo.ZMedia(_DSDk)
_APWv.Id = "7d0edb72-70fd-4250-b134-ffc6aa1eae0f"
_APWv.Name = _xcL("j\n\\iV4`z\\i\ne4\029R`<=b")
_APWv.Description = ""
_APWv.AltText = ""
_APWv.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofBerichalt.jpg",
    Directives = {}
  }
}
_nvCr9 = Wherigo.ZMedia(_DSDk)
_nvCr9.Id = "450e80e1-f5d2-4526-b97d-1839d29de0d2"
_nvCr9.Name = _xcL("j\n\\iV4`z\\i\ne4\029R`B&Rb[i=e")
_nvCr9.Description = ""
_nvCr9.AltText = ""
_nvCr9.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofBerichLuftaufnahme.jpg",
    Directives = {}
  }
}
_XBr = Wherigo.ZMedia(_DSDk)
_XBr.Id = "17577642-5c8f-402b-84ae-5fc650b053bb"
_XBr.Name = _xcL("j\n\\iV4`z\\i\ne4\029R`?ib`\028\020R\029b<R\n=")
_XBr.Description = ""
_XBr.AltText = ""
_XBr.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofBerichmitInfotafel.jpg",
    Directives = {}
  }
}
_x8GjC = Wherigo.ZMedia(_DSDk)
_x8GjC.Id = "63ff8616-60e5-4300-b177-8ec2de1ddd0a"
_x8GjC.Name = _xcL("j\n\\iV4`z\\i\ne4\029R`C[ya\niU")
_x8GjC.Description = ""
_x8GjC.AltText = ""
_x8GjC.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofBerichWeg.jpg",
    Directives = {}
  }
}
_kPTx = Wherigo.ZMedia(_DSDk)
_kPTx.Id = "00968647-115d-460a-9c37-7bc2aeb2ac0d"
_kPTx.Name = _xcL("j\n\\iV4`z\\i\ne4\029R`(+v\002")
_kPTx.Description = ""
_kPTx.AltText = ""
_kPTx.Resources = {
  {
    Type = "jpg",
    Filename = "FriedhofBerich.jpg",
    Directives = {}
  }
}
_Ojk = Wherigo.ZMedia(_DSDk)
_Ojk.Id = "16aed362-bfda-4710-a9ea-567e5d63e133"
_Ojk.Name = _xcL([[
O
4[<V4`3=
i!
]])
_Ojk.Description = ""
_Ojk.AltText = ""
_Ojk.Resources = {
  {
    Type = "jpg",
    Filename = "Gleise.jpg",
    Directives = {}
  }
}
_AwC = Wherigo.ZMedia(_DSDk)
_AwC.Id = "b572d6ff-559c-4e1f-bfb1-aab667305e52"
_AwC.Name = _xcL("3&b`6\029\\\0204<U\n\020`vGQ\023")
_AwC.Description = ""
_AwC.AltText = ""
_AwC.Resources = {
  {
    Type = "jpg",
    Filename = "GutVornhagen1934.jpg",
    Directives = {}
  }
}
_kSFzE = Wherigo.ZMedia(_DSDk)
_kSFzE.Id = "2333f72d-bc93-4381-9a80-456aa369a2ec"
_kSFzE.Name = _xcL("3&b`6\029\\\0204<U\n\020`(+vQ")
_kSFzE.Description = ""
_kSFzE.AltText = ""
_kSFzE.Resources = {
  {
    Type = "jpg",
    Filename = "GutVornhagen2013.jpg",
    Directives = {}
  }
}
_x_X = Wherigo.ZMedia(_DSDk)
_x_X.Id = "8a5c7e53-6b2d-44b4-86b9-d12cb165c73d"
_x_X.Name = _xcL("3&b`6\029\\\0204<U\n\020`nb\ni\020\n=<U\n\\")
_x_X.Description = ""
_x_X.AltText = ""
_x_X.Resources = {
  {
    Type = "jpg",
    Filename = "GutVornhagenSteinelager.jpg",
    Directives = {}
  }
}
_zH_8h = Wherigo.ZMedia(_DSDk)
_zH_8h.Id = "330e49de-8d5c-417b-a37b-6067fee08eb6"
_zH_8h.Name = _xcL("3&b`6\029\\\0204<U\n\020`>\029\\`vGv\023")
_zH_8h.Description = ""
_zH_8h.AltText = ""
_zH_8h.Resources = {
  {
    Type = "jpg",
    Filename = "GutVornhagenvor1914.jpg",
    Directives = {}
  }
}
_Mn2 = Wherigo.ZMedia(_DSDk)
_Mn2.Id = "2dfc2881-d118-4f91-9638-4f95f32669e7"
_Mn2.Name = _xcL("\127\029wR\n\020[\n\\U")
_Mn2.Description = ""
_Mn2.AltText = ""
_Mn2.Resources = {
  {
    Type = "jpg",
    Filename = "Hopfenberg.jpg",
    Directives = {}
  }
}
_8p_d9 = Wherigo.ZMedia(_DSDk)
_8p_d9.Id = "b3486aa1-e363-4412-8877-781dab679a1c"
_8p_d9.Name = _xcL([[
L
==
\`(++Q]])
_8p_d9.Description = ""
_8p_d9.AltText = ""
_8p_d9.Resources = {
  {
    Type = "jpg",
    Filename = "Keller2003.jpg",
    Directives = {}
  }
}
_Klr0 = Wherigo.ZMedia(_DSDk)
_Klr0.Id = "f8fdf830-a0ef-4a2c-bb66-3a941544442c"
_Klr0.Name = _xcL("L\n==\n\\`(++\016")
_Klr0.Description = ""
_Klr0.AltText = ""
_Klr0.Resources = {
  {
    Type = "jpg",
    Filename = "Keller2007.jpg",
    Directives = {}
  }
}
_YuJg = Wherigo.ZMedia(_DSDk)
_YuJg.Id = "1d843f12-c402-4d12-a876-a065efedf3a7"
_YuJg.Name = _xcL([[
L
==
\`(+vQ]])
_YuJg.Description = ""
_YuJg.AltText = ""
_YuJg.Resources = {
  {
    Type = "jpg",
    Filename = "Keller2013.jpg",
    Directives = {}
  }
}
_3Icce = Wherigo.ZMedia(_DSDk)
_3Icce.Id = "d434cd29-d730-447d-8818-8bfdffe4f715"
_3Icce.Name = _xcL("L\n==\n\\`(+v\002")
_3Icce.Description = ""
_3Icce.AltText = ""
_3Icce.Resources = {
  {
    Type = "jpg",
    Filename = "Keller2016.jpg",
    Directives = {}
  }
}
_yRt2 = Wherigo.ZMedia(_DSDk)
_yRt2.Id = "49e6ea67-8da8-44a9-be01-a0730d564f89"
_yRt2.Name = _xcL("\127\029wR\n\020[\n\\U`L\nbb\n")
_yRt2.Description = ""
_yRt2.AltText = ""
_yRt2.Resources = {
  {
    Type = "jpg",
    Filename = "Kette.jpg",
    Directives = {}
  }
}
_Rc0 = Wherigo.ZMedia(_DSDk)
_Rc0.Id = "4049bbd2-a525-4805-a950-3047789ae9d4"
_Rc0.Name = _xcL("\v<\\\004\n\020`v`\014&\\\029")
_Rc0.Description = ""
_Rc0.AltText = ""
_Rc0.Resources = {
  {
    Type = "jpg",
    Filename = "Parken1Euro.jpg",
    Directives = {}
  }
}
_mGG76 = Wherigo.ZMedia(_DSDk)
_mGG76.Id = "31b759f2-fcbc-402c-8758-8656738e4756"
_mGG76.Name = _xcL("\v<\\\004\n\020`(`\014&\\\029")
_mGG76.Description = ""
_mGG76.AltText = ""
_mGG76.Resources = {
  {
    Type = "jpg",
    Filename = "Parken2Euro.jpg",
    Directives = {}
  }
}
_CC3Gm = Wherigo.ZMedia(_DSDk)
_CC3Gm.Id = "6c4e5902-e767-4de8-989f-ca907ac2eb46"
_CC3Gm.Name = _xcL("O\029==[\029?[\n`?ib`j\029?[\n\\")
_CC3Gm.Description = ""
_CC3Gm.AltText = ""
_CC3Gm.Resources = {
  {
    Type = "jpg",
    Filename = "RollbombemitBomber.jpg",
    Directives = {}
  }
}
_YALmA = Wherigo.ZMedia(_DSDk)
_YALmA.Id = "c1095c6b-9a14-44f2-85d9-09c3fff7d0b3"
_YALmA.Name = _xcL("O\029==[\029?[\n`nV4\n?<")
_YALmA.Description = ""
_YALmA.AltText = ""
_YALmA.Resources = {
  {
    Type = "jpg",
    Filename = "RollbombeSchema.jpg",
    Directives = {}
  }
}
_iuelY = Wherigo.ZMedia(_DSDk)
_iuelY.Id = "e72cc168-7c0a-406a-a1f9-a850ada1c5fe"
_iuelY.Name = _xcL("nw\n\\\\?<&\n\\?\029e\n==")
_iuelY.Description = ""
_iuelY.AltText = ""
_iuelY.Resources = {
  {
    Type = "jpg",
    Filename = "Sperrmauer2.jpg",
    Directives = {}
  }
}
_u3tUg = Wherigo.ZMedia(_DSDk)
_u3tUg.Id = "b9419b7e-1c21-4d33-b917-85508e39063a"
_u3tUg.Name = _xcL("nw\n\\\\?<&\n\\?\029e\n==`9\nU")
_u3tUg.Description = ""
_u3tUg.AltText = ""
_u3tUg.Resources = {
  {
    Type = "jpg",
    Filename = "Sperrmauermodell-Weg.jpg",
    Directives = {}
  }
}
_4jts = Wherigo.ZMedia(_DSDk)
_4jts.Id = "3d4d63f8-67cc-4910-8bbc-761ce516aba6"
_4jts.Name = _xcL("nb<&?<&\n\\`vG\023Q")
_4jts.Description = ""
_4jts.AltText = ""
_4jts.Resources = {
  {
    Type = "jpg",
    Filename = "Staumauer1943.jpg",
    Directives = {}
  }
}
_sZNm = Wherigo.ZMedia(_DSDk)
_sZNm.Id = "f210fa73-9fb2-4b37-a601-fd2345661225"
_sZNm.Name = _xcL("nb\029==?&\n4=\n`n\029\020<\\")
_sZNm.Description = ""
_sZNm.AltText = ""
_sZNm.Resources = {
  {
    Type = "jpg",
    Filename = "StollmuhleSonar.jpg",
    Directives = {}
  }
}
_Afk = Wherigo.ZMedia(_DSDk)
_Afk.Id = "09ecbb7a-b2eb-4a7c-8f58-f243e2d6fbbc"
_Afk.Name = _xcL("nb\029==?&\n4=\n")
_Afk.Description = ""
_Afk.AltText = ""
_Afk.Resources = {
  {
    Type = "jpg",
    Filename = "Stollmuhle.jpg",
    Directives = {}
  }
}
_46Kq = Wherigo.ZMedia(_DSDk)
_46Kq.Id = "1ecea18f-21e5-4f5e-9f49-be070d23e1f2"
_46Kq.Name = _xcL("\019\\<&[\n\020\niV4\n")
_46Kq.Description = ""
_46Kq.AltText = ""
_46Kq.Resources = {
  {
    Type = "jpg",
    Filename = "Traubeneiche.jpg",
    Directives = {}
  }
}
_PZ35O = Wherigo.ZMedia(_DSDk)
_PZ35O.Id = "aa79ccef-4eff-483c-8937-acc6379bb80e"
_PZ35O.Name = _xcL("6\029\\\0204<U\n\020`nV4<R!b<==`n\029\020<\\")
_PZ35O.Description = ""
_PZ35O.AltText = ""
_PZ35O.Resources = {
  {
    Type = "jpg",
    Filename = "VornhagenSchafstallSonar.jpg",
    Directives = {}
  }
}
_DSDk.Id = "a1e44d20-a51a-4749-803c-06a523ba04d2"
_DSDk.Name = "Edersee-Atlantis"
_DSDk.Description = [[
Dieser Wherigo fuehrt dich zu einigen interessanten Bauwerken und Bodenerhebungen, die normalerweise in den Fluten versunken sind. <BR>
Je nach aktuellen Pegelstand kannst du dich dabei fuer drei verschieden Stufen entscheiden.<BR>
Die 1. Stufe wird man nahezu jedes Jahr spielen koennen, die 3. Stufe wohl nur alle paar Jahre.]]
_DSDk.Visible = true
_DSDk.Activity = "Geocache"
_DSDk.StartingLocationDescription = "Edersee"
_DSDk.StartingLocation = ZonePoint(51.184517, 8.950283, 0)
_DSDk.Version = "2.2"
_DSDk.Company = ""
_DSDk.Author = "Barfussmann"
_DSDk.BuilderVersion = "URWIGO 1.22.5798.37755"
_DSDk.CreateDate = "11/13/2016 11:20:30"
_DSDk.PublishDate = "1/1/0001 12:00:00 AM"
_DSDk.UpdateDate = "11/23/2018 12:22:05"
_DSDk.LastPlayedDate = "1/1/0001 12:00:00 AM"
_DSDk.TargetDevice = "PocketPC"
_DSDk.TargetDeviceVersion = "0"
_DSDk.StateId = "1"
_DSDk.CountryId = "2"
_DSDk.Complete = false
_DSDk.UseLogging = true
_DSDk.Media = _Z8iUX
_DSDk.Icon = _aqLt
_bSOL = Wherigo.Zone(_DSDk)
_bSOL.Id = "d567bbc7-b09c-4dd3-aa78-b2ea8f8ed904"
_bSOL.Name = _xcL("5\n\020\004?<=`\b`C!\n=")
_bSOL.Description = ""
_bSOL.Visible = true
_bSOL.Commands = {}
_bSOL.DistanceRange = Distance(-1, "feet")
_bSOL.ShowObjects = "OnEnter"
_bSOL.ProximityRange = Distance(60, "meters")
_bSOL.AllowSetPositionTo = false
_bSOL.Active = false
_bSOL.Points = {
  ZonePoint(51.1853364453201, 8.94854304190507, 0),
  ZonePoint(51.1853566836081, 8.94821540332005, 0),
  ZonePoint(51.185207170188, 8.94821082953462, 0),
  ZonePoint(51.1851115333835, 8.94814855464813, 0),
  ZonePoint(51.1850562936573, 8.9484910729437, 0)
}
_bSOL.OriginalPoint = ZonePoint(51.1852136252314, 8.94832178047031, 0)
_bSOL.DistanceRangeUOM = "Feet"
_bSOL.ProximityRangeUOM = "Meters"
_bSOL.OutOfRangeName = ""
_bSOL.InRangeName = ""
_zSv = Wherigo.Zone(_DSDk)
_zSv.Id = "6c562f5d-4d72-4b65-bdd4-dcc7f493866a"
_zSv.Name = _xcL("\vv")
_zSv.Description = _xcL("L\029!b\n\020=\029!")
_zSv.Visible = true
_zSv.Commands = {}
_zSv.DistanceRange = Distance(-1, "feet")
_zSv.ShowObjects = "OnEnter"
_zSv.ProximityRange = Distance(60, "meters")
_zSv.AllowSetPositionTo = false
_zSv.Active = false
_zSv.Points = {
  ZonePoint(51.1845262762901, 8.94585573417277, 0),
  ZonePoint(51.1842283246042, 8.94554074572752, 0),
  ZonePoint(51.184021818942, 8.94600238297107, 0),
  ZonePoint(51.1843510208924, 8.94634029447174, 0)
}
_zSv.OriginalPoint = ZonePoint(51.1842818601822, 8.94593478933577, 0)
_zSv.DistanceRangeUOM = "Feet"
_zSv.ProximityRangeUOM = "Meters"
_zSv.OutOfRangeName = ""
_zSv.InRangeName = ""
_OcyF = Wherigo.Zone(_DSDk)
_OcyF.Id = "6dff3fd9-7e68-421b-853a-9dbc99f9a4c2"
_OcyF.Name = _xcL("\v(")
_OcyF.Description = _xcL("L\029!b\n\020=\029!")
_OcyF.Visible = true
_OcyF.Commands = {}
_OcyF.DistanceRange = Distance(-1, "feet")
_OcyF.ShowObjects = "OnEnter"
_OcyF.ProximityRange = Distance(60, "meters")
_OcyF.AllowSetPositionTo = false
_OcyF.Active = false
_OcyF.Points = {
  ZonePoint(51.1891516179803, 8.94603309607989, 0),
  ZonePoint(51.1890806366653, 8.94657646974855, 0),
  ZonePoint(51.1887050363314, 8.94645259964869, 0),
  ZonePoint(51.1888381272921, 8.94589153025151, 0)
}
_OcyF.OriginalPoint = ZonePoint(51.1889438545673, 8.94623842393216, 0)
_OcyF.DistanceRangeUOM = "Feet"
_OcyF.ProximityRangeUOM = "Meters"
_OcyF.OutOfRangeName = ""
_OcyF.InRangeName = ""
_syX = Wherigo.Zone(_DSDk)
_syX.Id = "8c6a963e-ada2-4a77-8c36-9cb8a1ec606c"
_syX.Name = _xcL("z\\i\ne4\029R`\b`C!\n=")
_syX.Description = ""
_syX.Visible = true
_syX.Commands = {}
_syX.DistanceRange = Distance(-1, "feet")
_syX.ShowObjects = "OnEnter"
_syX.ProximityRange = Distance(60, "meters")
_syX.AllowSetPositionTo = false
_syX.Active = false
_syX.Points = {
  ZonePoint(51.1888664347787, 8.94735592296608, 0),
  ZonePoint(51.189002675354, 8.94701853007621, 0),
  ZonePoint(51.1887414549937, 8.94674159881049, 0),
  ZonePoint(51.1885973141777, 8.94709612050706, 0)
}
_syX.OriginalPoint = ZonePoint(51.188801969826, 8.94705304308996, 0)
_syX.DistanceRangeUOM = "Feet"
_syX.ProximityRangeUOM = "Meters"
_syX.OutOfRangeName = ""
_syX.InRangeName = ""
_35_a = Wherigo.Zone(_DSDk)
_35_a.Id = "ad7a2842-b7cf-422b-a723-53f2fd52e819"
_35_a.Name = _xcL("{\029\n\\e=iV4\n!`j\\&\nV\004\n\020\n\020e\n")
_35_a.Description = ""
_35_a.Visible = true
_35_a.Commands = {}
_35_a.DistanceRange = Distance(-1, "feet")
_35_a.ShowObjects = "OnEnter"
_35_a.ProximityRange = Distance(60, "meters")
_35_a.AllowSetPositionTo = false
_35_a.Active = false
_35_a.Points = {
  ZonePoint(51.18373996785, 8.95175363215421, 0),
  ZonePoint(51.1840048070667, 8.95214272025703, 0),
  ZonePoint(51.183897, 8.952362, 0),
  ZonePoint(51.183622, 8.951969, 0)
}
_35_a.OriginalPoint = ZonePoint(51.1838159437292, 8.95205683810281, 0)
_35_a.DistanceRangeUOM = "Feet"
_35_a.ProximityRangeUOM = "Meters"
_35_a.OutOfRangeName = ""
_35_a.InRangeName = ""
__Ar = Wherigo.Zone(_DSDk)
__Ar.Id = "d5e79cd0-3332-4cd2-898a-1dc338b3428e"
__Ar.Name = _xcL("n&\ne=iV4\n!`j\\&\nV\004\n\020\n\020e\n")
__Ar.Description = ""
__Ar.Visible = true
__Ar.Commands = {}
__Ar.DistanceRange = Distance(-1, "feet")
__Ar.ShowObjects = "OnEnter"
__Ar.ProximityRange = Distance(60, "meters")
__Ar.AllowSetPositionTo = false
__Ar.Active = false
__Ar.Points = {
  ZonePoint(51.1836797797252, 8.95286477477972, 0),
  ZonePoint(51.1833900966626, 8.95248931703103, 0),
  ZonePoint(51.1832915051844, 8.95269487476023, 0),
  ZonePoint(51.1835780023061, 8.9530534652885, 0)
}
__Ar.OriginalPoint = ZonePoint(51.1834848459696, 8.95277560796487, 0)
__Ar.DistanceRangeUOM = "Feet"
__Ar.ProximityRangeUOM = "Meters"
__Ar.OutOfRangeName = ""
__Ar.InRangeName = ""
_aCJ = Wherigo.Zone(_DSDk)
_aCJ.Id = "7b4fd1b8-9bff-4b6b-8cfc-caa172b4532d"
_aCJ.Name = _xcL("nw\n\\\\?<&\n\\?\029e\n==")
_aCJ.Description = ""
_aCJ.Visible = true
_aCJ.Commands = {}
_aCJ.DistanceRange = Distance(-1, "feet")
_aCJ.ShowObjects = "OnEnter"
_aCJ.ProximityRange = Distance(60, "meters")
_aCJ.AllowSetPositionTo = false
_aCJ.Active = false
_aCJ.Points = {
  ZonePoint(51.191933, 9.013416, 0),
  ZonePoint(51.191933, 9.013116, 0),
  ZonePoint(51.191733, 9.013116, 0),
  ZonePoint(51.191733, 9.013416, 0)
}
_aCJ.OriginalPoint = ZonePoint(51.191833, 9.013266, 0)
_aCJ.DistanceRangeUOM = "Feet"
_aCJ.ProximityRangeUOM = "Meters"
_aCJ.OutOfRangeName = ""
_aCJ.InRangeName = ""
_pQR = Wherigo.Zone(_DSDk)
_pQR.Id = "0fd486e2-b436-4309-87e4-2b6648a4c198"
_pQR.Name = _xcL("j\n\\iV4\n\\`\127&\nbb\n")
_pQR.Description = ""
_pQR.Visible = true
_pQR.Commands = {}
_pQR.DistanceRange = Distance(-1, "feet")
_pQR.ShowObjects = "OnEnter"
_pQR.ProximityRange = Distance(60, "meters")
_pQR.AllowSetPositionTo = false
_pQR.Active = false
_pQR.Points = {
  ZonePoint(51.19205, 9.013034, 0),
  ZonePoint(51.19205, 9.012734, 0),
  ZonePoint(51.19185, 9.012734, 0),
  ZonePoint(51.19185, 9.013034, 0)
}
_pQR.OriginalPoint = ZonePoint(51.19195, 9.012884, 0)
_pQR.DistanceRangeUOM = "Feet"
_pQR.ProximityRangeUOM = "Meters"
_pQR.OutOfRangeName = ""
_pQR.InRangeName = ""
_Kkc = Wherigo.Zone(_DSDk)
_Kkc.Id = "adf380b4-a5cb-4364-936f-699d36df2820"
_Kkc.Name = _xcL([[
9
Ua
i!
\]])
_Kkc.Description = _xcL("\127i\n\\`U\n4b\015!`\\&\020b\n\\.")
_Kkc.Visible = true
_Kkc.Commands = {}
_Kkc.DistanceRange = Distance(-1, "feet")
_Kkc.ShowObjects = "OnEnter"
_Kkc.ProximityRange = Distance(60, "meters")
_Kkc.AllowSetPositionTo = false
_Kkc.Active = false
_Kkc.Points = {
  ZonePoint(51.1929714359719, 9.01261391268641, 0),
  ZonePoint(51.1929337301967, 9.01202806930337, 0),
  ZonePoint(51.1925492559539, 9.01209531323387, 0),
  ZonePoint(51.1925913980523, 9.01268115661692, 0)
}
_Kkc.OriginalPoint = ZonePoint(51.1927614550437, 9.01235461296014, 0)
_Kkc.DistanceRangeUOM = "Feet"
_Kkc.ProximityRangeUOM = "Meters"
_Kkc.OutOfRangeName = ""
_Kkc.InRangeName = ""
_4TV = Wherigo.Zone(_DSDk)
_4TV.Id = "1c9ac6e7-edbc-4ff6-9fc1-5649f3c791b8"
_4TV.Name = _xcL("\vv")
_4TV.Description = _xcL("L\029!b\n\020=\029!`<[\n\\`\020&\\`\v=<by`R&\n\\`a\n\020iU\n`C&b\029!")
_4TV.Visible = true
_4TV.Commands = {}
_4TV.DistanceRange = Distance(-1, "feet")
_4TV.ShowObjects = "OnEnter"
_4TV.ProximityRange = Distance(60, "meters")
_4TV.AllowSetPositionTo = false
_4TV.Active = false
_4TV.Points = {
  ZonePoint(51.1936529615819, 9.00890329522372, 0),
  ZonePoint(51.1935354099195, 9.00832806930338, 0),
  ZonePoint(51.1931753326587, 9.00852626194065, 0),
  ZonePoint(51.1933106289994, 9.00910502701519, 0)
}
_4TV.OriginalPoint = ZonePoint(51.1934185832899, 9.00871566337073, 0)
_4TV.DistanceRangeUOM = "Feet"
_4TV.ProximityRangeUOM = "Meters"
_4TV.OutOfRangeName = ""
_4TV.InRangeName = ""
_41Gfk = Wherigo.Zone(_DSDk)
_41Gfk.Id = "6879f54b-169e-405e-b46f-495abaa639d8"
_41Gfk.Name = _xcL("\v(")
_41Gfk.Description = _xcL("L\029!b\n\020=\029!`<[\n\\`\020&\\`\v=<by`R&\n\\`a\n\020iU\n`C&b\029!.`9\nib\n\\`y&`=<&R\n\020`<=!`>\029\020`\vv.")
_41Gfk.Visible = true
_41Gfk.Commands = {}
_41Gfk.DistanceRange = Distance(-1, "feet")
_41Gfk.ShowObjects = "OnEnter"
_41Gfk.ProximityRange = Distance(60, "meters")
_41Gfk.AllowSetPositionTo = false
_41Gfk.Active = false
_41Gfk.Points = {
  ZonePoint(51.1945586776921, 9.01759826820849, 0),
  ZonePoint(51.1942814381746, 9.01697349412886, 0),
  ZonePoint(51.1939435390473, 9.01736280109493, 0),
  ZonePoint(51.1942229985235, 9.01796634024918, 0)
}
_41Gfk.OriginalPoint = ZonePoint(51.1942516633594, 9.01747522592036, 0)
_41Gfk.DistanceRangeUOM = "Feet"
_41Gfk.ProximityRangeUOM = "Meters"
_41Gfk.OutOfRangeName = ""
_41Gfk.InRangeName = ""
_rbnc = Wherigo.Zone(_DSDk)
_rbnc.Id = "d76e7554-9dbc-489e-ba7a-03d4976cf2b4"
_rbnc.Name = _xcL("nb\ni\020")
_rbnc.Description = ""
_rbnc.Visible = true
_rbnc.Commands = {}
_rbnc.DistanceRange = Distance(-1, "feet")
_rbnc.ShowObjects = "OnEnter"
_rbnc.ProximityRange = Distance(10, "meters")
_rbnc.AllowSetPositionTo = false
_rbnc.Active = false
_rbnc.Points = {
  ZonePoint(51.191667, 9.013417, 0),
  ZonePoint(51.191667, 9.013117, 0),
  ZonePoint(51.191467, 9.013117, 0),
  ZonePoint(51.191467, 9.013417, 0)
}
_rbnc.OriginalPoint = ZonePoint(51.191567, 9.013267, 0)
_rbnc.DistanceRangeUOM = "Feet"
_rbnc.ProximityRangeUOM = "Meters"
_rbnc.OutOfRangeName = ""
_rbnc.InRangeName = ""
_NaBOl = Wherigo.Zone(_DSDk)
_NaBOl.Id = "0651dbb1-cd8e-40f8-b05b-02ea259a6dd1"
_NaBOl.Name = _xcL("\127\029=y")
_NaBOl.Description = ""
_NaBOl.Visible = true
_NaBOl.Commands = {}
_NaBOl.DistanceRange = Distance(-1, "feet")
_NaBOl.ShowObjects = "OnEnter"
_NaBOl.ProximityRange = Distance(20, "meters")
_NaBOl.AllowSetPositionTo = false
_NaBOl.Active = false
_NaBOl.Points = {
  ZonePoint(51.19135, 9.013067, 0),
  ZonePoint(51.19135, 9.012767, 0),
  ZonePoint(51.19115, 9.012767, 0),
  ZonePoint(51.19115, 9.013067, 0)
}
_NaBOl.OriginalPoint = ZonePoint(51.19125, 9.012917, 0)
_NaBOl.DistanceRangeUOM = "Feet"
_NaBOl.ProximityRangeUOM = "Meters"
_NaBOl.OutOfRangeName = ""
_NaBOl.InRangeName = ""
_wR46N = Wherigo.Zone(_DSDk)
_wR46N.Id = "0e119df1-7cb8-4c6c-b81c-b18c6b8c5634"
_wR46N.Name = _xcL("5\029\\R\\\n!b\n`\b`j\n\\iV4")
_wR46N.Description = ""
_wR46N.Visible = true
_wR46N.Commands = {}
_wR46N.DistanceRange = Distance(-1, "feet")
_wR46N.ShowObjects = "OnEnter"
_wR46N.ProximityRange = Distance(60, "meters")
_wR46N.AllowSetPositionTo = false
_wR46N.Active = false
_wR46N.Points = {
  ZonePoint(51.1969115574745, 9.0327417730313, 0),
  ZonePoint(51.1969936123885, 9.03177362407149, 0),
  ZonePoint(51.1966512732426, 9.03169930497766, 0),
  ZonePoint(51.1965625645619, 9.03268514895982, 0)
}
_wR46N.OriginalPoint = ZonePoint(51.1967797519169, 9.03222496276007, 0)
_wR46N.DistanceRangeUOM = "Feet"
_wR46N.ProximityRangeUOM = "Meters"
_wR46N.OutOfRangeName = ""
_wR46N.InRangeName = ""
_TZWTn = Wherigo.Zone(_DSDk)
_TZWTn.Id = "e2fefd12-78b8-4b54-95ab-63e43b85116f"
_TZWTn.Name = _xcL("\vv")
_TZWTn.Description = _xcL("L\029!b\n\020=\029!")
_TZWTn.Visible = true
_TZWTn.Commands = {}
_TZWTn.DistanceRange = Distance(-1, "feet")
_TZWTn.ShowObjects = "OnEnter"
_TZWTn.ProximityRange = Distance(60, "meters")
_TZWTn.AllowSetPositionTo = false
_TZWTn.Active = false
_TZWTn.Points = {
  ZonePoint(51.1991077824034, 9.03007399294194, 0),
  ZonePoint(51.19911, 9.02952, 0),
  ZonePoint(51.19871, 9.02952, 0),
  ZonePoint(51.1987166528469, 9.030066914933, 0)
}
_TZWTn.OriginalPoint = ZonePoint(51.1989111088126, 9.02979522696874, 0)
_TZWTn.DistanceRangeUOM = "Feet"
_TZWTn.ProximityRangeUOM = "Meters"
_TZWTn.OutOfRangeName = ""
_TZWTn.InRangeName = ""
_F0lou = Wherigo.Zone(_DSDk)
_F0lou.Id = "07689bd8-b77b-4a4d-8ae4-747225925ff4"
_F0lou.Name = _xcL("\v(")
_F0lou.Description = _xcL("v`\014&\\\029")
_F0lou.Visible = true
_F0lou.Commands = {}
_F0lou.DistanceRange = Distance(-1, "feet")
_F0lou.ShowObjects = "OnEnter"
_F0lou.ProximityRange = Distance(60, "meters")
_F0lou.AllowSetPositionTo = false
_F0lou.Active = false
_F0lou.Points = {
  ZonePoint(51.1974947545669, 9.03657843276321, 0),
  ZonePoint(51.1972485920639, 9.03586518462022, 0),
  ZonePoint(51.1968663326061, 9.0362297020804, 0),
  ZonePoint(51.1971124971515, 9.03693233321, 0)
}
_F0lou.OriginalPoint = ZonePoint(51.1971805440971, 9.03640141316846, 0)
_F0lou.DistanceRangeUOM = "Feet"
_F0lou.ProximityRangeUOM = "Meters"
_F0lou.OutOfRangeName = ""
_F0lou.InRangeName = ""
_k5m4 = Wherigo.Zone(_DSDk)
_k5m4.Id = "6d26db68-e574-4be8-97d7-859ae0681a84"
_k5m4.Name = _xcL("5\n\020\004?<=`\b`j\n\\iV4")
_k5m4.Description = ""
_k5m4.Visible = true
_k5m4.Commands = {}
_k5m4.DistanceRange = Distance(-1, "feet")
_k5m4.ShowObjects = "OnEnter"
_k5m4.ProximityRange = Distance(60, "meters")
_k5m4.AllowSetPositionTo = false
_k5m4.Active = false
_k5m4.Points = {
  ZonePoint(51.1964730980554, 9.03622735564472, 0),
  ZonePoint(51.1962578209468, 9.03675729251542, 0),
  ZonePoint(51.1960657118256, 9.03644148711283, 0),
  ZonePoint(51.1961902449653, 9.03608870937041, 0)
}
_k5m4.OriginalPoint = ZonePoint(51.1962467189483, 9.03637871116084, 0)
_k5m4.DistanceRangeUOM = "Feet"
_k5m4.ProximityRangeUOM = "Meters"
_k5m4.OutOfRangeName = ""
_k5m4.InRangeName = ""
_lIYn = Wherigo.Zone(_DSDk)
_lIYn.Id = "99ca7681-4bf4-425b-be95-5ad46d1c06c0"
_lIYn.Name = _xcL("z\\i\ne4\029R`\b`j\n\\iV4")
_lIYn.Description = ""
_lIYn.Visible = true
_lIYn.Commands = {}
_lIYn.DistanceRange = Distance(-1, "feet")
_lIYn.ShowObjects = "OnEnter"
_lIYn.ProximityRange = Distance(60, "meters")
_lIYn.AllowSetPositionTo = false
_lIYn.Active = false
_lIYn.Points = {
  ZonePoint(51.1967854313029, 9.04056820607378, 0),
  ZonePoint(51.1965061736005, 9.04098552701091, 0),
  ZonePoint(51.1967669690472, 9.04143250254689, 0),
  ZonePoint(51.1970440075954, 9.04100313123435, 0)
}
_lIYn.OriginalPoint = ZonePoint(51.1967756453865, 9.04099734171648, 0)
_lIYn.DistanceRangeUOM = "Feet"
_lIYn.ProximityRangeUOM = "Meters"
_lIYn.OutOfRangeName = ""
_lIYn.InRangeName = ""
_euiH2 = Wherigo.Zone(_DSDk)
_euiH2.Id = "a43893c3-b447-4d84-ab22-0b4d9c3d59ee"
_euiH2.Name = _xcL("\vv")
_euiH2.Description = _xcL("v`\014&\\\029")
_euiH2.Visible = true
_euiH2.Commands = {}
_euiH2.DistanceRange = Distance(-1, "feet")
_euiH2.ShowObjects = "OnEnter"
_euiH2.ProximityRange = Distance(60, "meters")
_euiH2.AllowSetPositionTo = false
_euiH2.Active = false
_euiH2.Points = {
  ZonePoint(51.197489387806, 9.03973457252663, 0),
  ZonePoint(51.1970725902081, 9.03919529928149, 0),
  ZonePoint(51.1968972976179, 9.03956824850775, 0),
  ZonePoint(51.1973297237855, 9.04008491460898, 0)
}
_euiH2.OriginalPoint = ZonePoint(51.1971972498544, 9.03964575873121, 0)
_euiH2.DistanceRangeUOM = "Feet"
_euiH2.ProximityRangeUOM = "Meters"
_euiH2.OutOfRangeName = ""
_euiH2.InRangeName = ""
_Hb3W = Wherigo.Zone(_DSDk)
_Hb3W.Id = "4b6c997b-89d5-4490-91c9-92426f7ecabb"
_Hb3W.Name = _xcL("\v(")
_Hb3W.Description = _xcL("v`\014&\\\029")
_Hb3W.Visible = true
_Hb3W.Commands = {}
_Hb3W.DistanceRange = Distance(-1, "feet")
_Hb3W.ShowObjects = "OnEnter"
_Hb3W.ProximityRange = Distance(60, "meters")
_Hb3W.AllowSetPositionTo = false
_Hb3W.Active = false
_Hb3W.Points = {
  ZonePoint(51.1979733482536, 9.04125224571148, 0),
  ZonePoint(51.1977516029138, 9.04140087028073, 0),
  ZonePoint(51.197902389861, 9.04205198744124, 0),
  ZonePoint(51.1981174821521, 9.0418927468313, 0)
}
_Hb3W.OriginalPoint = ZonePoint(51.1979362057951, 9.04164946256619, 0)
_Hb3W.DistanceRangeUOM = "Feet"
_Hb3W.ProximityRangeUOM = "Meters"
_Hb3W.OutOfRangeName = ""
_Hb3W.InRangeName = ""
_cXq = Wherigo.Zone(_DSDk)
_cXq.Id = "31903276-d64a-4898-8259-69e300735265"
_cXq.Name = _xcL([[
nw
\\?<&
\]])
_cXq.Description = ""
_cXq.Visible = true
_cXq.Commands = {}
_cXq.DistanceRange = Distance(-1, "feet")
_cXq.ShowObjects = "OnEnter"
_cXq.ProximityRange = Distance(60, "meters")
_cXq.AllowSetPositionTo = false
_cXq.Active = false
_cXq.Points = {
  ZonePoint(51.1821510732971, 9.05735495933339, 0),
  ZonePoint(51.1821539700814, 9.05790180152767, 0),
  ZonePoint(51.1827414511405, 9.05805499206153, 0),
  ZonePoint(51.1833632046449, 9.05848589705162, 0),
  ZonePoint(51.1838677361607, 9.05916071052668, 0),
  ZonePoint(51.1842703381561, 9.06006317192098, 0),
  ZonePoint(51.1845964941562, 9.05977861202189, 0),
  ZonePoint(51.1841633177156, 9.0587379358194, 0),
  ZonePoint(51.1836231155094, 9.05802247093023, 0),
  ZonePoint(51.1829758837747, 9.05756717509163, 0)
}
_cXq.OriginalPoint = ZonePoint(51.1833906584637, 9.0585127726285, 0)
_cXq.DistanceRangeUOM = "Feet"
_cXq.ProximityRangeUOM = "Meters"
_cXq.OutOfRangeName = ""
_cXq.InRangeName = ""
_SdqT = Wherigo.Zone(_DSDk)
_SdqT.Id = "3d81987e-972f-4cbd-a869-38885895fb2a"
_SdqT.Name = _xcL("\vv")
_SdqT.Description = _xcL("(`\014&\\\029")
_SdqT.Visible = true
_SdqT.Commands = {}
_SdqT.DistanceRange = Distance(-1, "feet")
_SdqT.ShowObjects = "OnEnter"
_SdqT.ProximityRange = Distance(60, "meters")
_SdqT.AllowSetPositionTo = false
_SdqT.Active = false
_SdqT.Points = {
  ZonePoint(51.1781035169767, 9.05583542484851, 0),
  ZonePoint(51.1773440745094, 9.05498174515118, 0),
  ZonePoint(51.1762125329976, 9.05451831902974, 0),
  ZonePoint(51.176146270697, 9.05507117826229, 0),
  ZonePoint(51.1771911651172, 9.05546143183823, 0),
  ZonePoint(51.1779149317597, 9.05629885096991, 0)
}
_SdqT.OriginalPoint = ZonePoint(51.1771520820096, 9.05536115834998, 0)
_SdqT.DistanceRangeUOM = "Feet"
_SdqT.ProximityRangeUOM = "Meters"
_SdqT.OutOfRangeName = ""
_SdqT.InRangeName = ""
_IyQ = Wherigo.Zone(_DSDk)
_IyQ.Id = "88f4c3e3-08fe-4e35-8903-cb6b0b4fe8fc"
_IyQ.Name = _xcL("\v(")
_IyQ.Description = _xcL("\004\029!b\n\020=\029!`<[\n\\`\020iV4b`U<\020y`=\nU<=")
_IyQ.Visible = true
_IyQ.Commands = {}
_IyQ.DistanceRange = Distance(-1, "feet")
_IyQ.ShowObjects = "OnEnter"
_IyQ.ProximityRange = Distance(60, "meters")
_IyQ.AllowSetPositionTo = false
_IyQ.Active = false
_IyQ.Points = {
  ZonePoint(51.1814606811386, 9.05586739452481, 0),
  ZonePoint(51.1812878364244, 9.056069187387, 0),
  ZonePoint(51.1815224802087, 9.05658830337607, 0),
  ZonePoint(51.1816904960119, 9.05638342970684, 0)
}
_IyQ.OriginalPoint = ZonePoint(51.1814903734459, 9.05622707874868, 0)
_IyQ.DistanceRangeUOM = "Feet"
_IyQ.ProximityRangeUOM = "Meters"
_IyQ.OutOfRangeName = ""
_IyQ.InRangeName = ""
_EsK = Wherigo.Zone(_DSDk)
_EsK.Id = "b3dee626-f0ec-447d-a0b3-9c7ac52be407"
_EsK.Name = _xcL("5&\\V4R<4\\b`nb\029==\n\020?&4=\n")
_EsK.Description = ""
_EsK.Visible = false
_EsK.Commands = {}
_EsK.DistanceRange = Distance(-1, "feet")
_EsK.ShowObjects = "OnEnter"
_EsK.ProximityRange = Distance(60, "meters")
_EsK.AllowSetPositionTo = false
_EsK.Active = false
_EsK.Points = {
  ZonePoint(51.1930632299861, 9.05001757140798, 0),
  ZonePoint(51.1931785614117, 9.05020714094617, 0),
  ZonePoint(51.1929392445074, 9.05061767050184, 0),
  ZonePoint(51.1928194766299, 9.05043871810714, 0)
}
_EsK.OriginalPoint = ZonePoint(51.1930001281338, 9.05032027524078, 0)
_EsK.DistanceRangeUOM = "Feet"
_EsK.ProximityRangeUOM = "Meters"
_EsK.OutOfRangeName = ""
_EsK.InRangeName = ""
_gSx1 = Wherigo.Zone(_DSDk)
_gSx1.Id = "04ea1ae1-6ffc-4c52-a6f4-c1cf7a9969d7"
_gSx1.Name = _xcL("\127\029wR\n\020[\n\\U")
_gSx1.Description = ""
_gSx1.Visible = true
_gSx1.Commands = {}
_gSx1.DistanceRange = Distance(-1, "feet")
_gSx1.ShowObjects = "OnEnter"
_gSx1.ProximityRange = Distance(60, "meters")
_gSx1.AllowSetPositionTo = false
_gSx1.Active = false
_gSx1.Points = {
  ZonePoint(51.1950237233333, 9.05340065821724, 0),
  ZonePoint(51.1950237233333, 9.05379195148591, 0),
  ZonePoint(51.1952408503029, 9.05379195148594, 0),
  ZonePoint(51.1952430681014, 9.05341127530645, 0)
}
_gSx1.OriginalPoint = ZonePoint(51.1951328412677, 9.05359895912389, 0)
_gSx1.DistanceRangeUOM = "Feet"
_gSx1.ProximityRangeUOM = "Meters"
_gSx1.OutOfRangeName = ""
_gSx1.InRangeName = ""
_YVBK = Wherigo.Zone(_DSDk)
_YVBK.Id = "ecd0f8aa-dd0e-43e2-b0c2-9cd5f56c62de"
_YVBK.Name = _xcL("\v\\\n==[\029V\004")
_YVBK.Description = ""
_YVBK.Visible = true
_YVBK.Commands = {}
_YVBK.DistanceRange = Distance(-1, "feet")
_YVBK.ShowObjects = "OnEnter"
_YVBK.ProximityRange = Distance(60, "meters")
_YVBK.AllowSetPositionTo = false
_YVBK.Active = false
_YVBK.Points = {
  ZonePoint(51.1833032771733, 9.01921319335838, 0),
  ZonePoint(51.1831388349549, 9.01898160421384, 0),
  ZonePoint(51.1832872561367, 9.01872525510138, 0),
  ZonePoint(51.1834462418625, 9.01896544282301, 0)
}
_YVBK.OriginalPoint = ZonePoint(51.1832939025319, 9.01897137387415, 0)
_YVBK.DistanceRangeUOM = "Feet"
_YVBK.ProximityRangeUOM = "Meters"
_YVBK.OutOfRangeName = ""
_YVBK.InRangeName = ""
_6iCkx = Wherigo.Zone(_DSDk)
_6iCkx.Id = "2bd7df41-c734-41f9-88de-294f23931668"
_6iCkx.Name = _xcL("nV4i=e")
_6iCkx.Description = ""
_6iCkx.Visible = true
_6iCkx.Commands = {}
_6iCkx.DistanceRange = Distance(-1, "feet")
_6iCkx.ShowObjects = "OnEnter"
_6iCkx.ProximityRange = Distance(60, "meters")
_6iCkx.AllowSetPositionTo = false
_6iCkx.Active = false
_6iCkx.Points = {
  ZonePoint(51.1824734158543, 9.02119297462658, 0),
  ZonePoint(51.1824216175838, 9.02136542740884, 0),
  ZonePoint(51.1824493934752, 9.02151033564948, 0),
  ZonePoint(51.1825207098766, 9.0215678199102, 0),
  ZonePoint(51.1826152977755, 9.0215450657237, 0),
  ZonePoint(51.1826731013961, 9.02143848032356, 0),
  ZonePoint(51.1826836111375, 9.02130674555934, 0),
  ZonePoint(51.1826415721575, 9.02120854328047, 0),
  ZonePoint(51.1825552419892, 9.0211606397299, 0)
}
_6iCkx.OriginalPoint = ZonePoint(51.1825593290273, 9.02136622580134, 0)
_6iCkx.DistanceRangeUOM = "Feet"
_6iCkx.ProximityRangeUOM = "Meters"
_6iCkx.OutOfRangeName = ""
_6iCkx.InRangeName = ""
_ihg7 = Wherigo.Zone(_DSDk)
_ihg7.Id = "7e8019fa-d01d-411a-b729-d15a7a6ef3c6"
_ihg7.Name = _xcL("\vv")
_ihg7.Description = _xcL("=\nie\n\\`\020iV4b`\004\029!b\n\020=\029!")
_ihg7.Visible = true
_ihg7.Commands = {}
_ihg7.DistanceRange = Distance(-1, "feet")
_ihg7.ShowObjects = "OnEnter"
_ihg7.ProximityRange = Distance(60, "meters")
_ihg7.AllowSetPositionTo = false
_ihg7.Active = false
_ihg7.Points = {
  ZonePoint(51.1836339992414, 9.02409889018461, 0),
  ZonePoint(51.1834667229637, 9.02396133259373, 0),
  ZonePoint(51.1833046195999, 9.02447579798354, 0),
  ZonePoint(51.1834701719652, 9.0246078532708, 0)
}
_ihg7.OriginalPoint = ZonePoint(51.1834688784426, 9.02428596850817, 0)
_ihg7.DistanceRangeUOM = "Feet"
_ihg7.ProximityRangeUOM = "Meters"
_ihg7.OutOfRangeName = ""
_ihg7.InRangeName = ""
_5hre = Wherigo.Zone(_DSDk)
_5hre.Id = "958d08f1-76ca-4e6e-9da4-8e00e59e4e49"
_5hre.Name = _xcL("z\\i\ne4\029R`\029[\n\\`\019\ni=")
_5hre.Description = ""
_5hre.Visible = true
_5hre.Commands = {}
_5hre.DistanceRange = Distance(-1, "feet")
_5hre.ShowObjects = "OnEnter"
_5hre.ProximityRange = Distance(60, "meters")
_5hre.AllowSetPositionTo = false
_5hre.Active = false
_5hre.Points = {
  ZonePoint(51.174863, 9.004011, 0),
  ZonePoint(51.1749712406431, 9.00418245769966, 0),
  ZonePoint(51.1748298992508, 9.00441107927342, 0),
  ZonePoint(51.1747140683434, 9.00423745947552, 0)
}
_5hre.OriginalPoint = ZonePoint(51.1748445520593, 9.00421049911215, 0)
_5hre.DistanceRangeUOM = "Feet"
_5hre.ProximityRangeUOM = "Meters"
_5hre.OutOfRangeName = ""
_5hre.InRangeName = ""
_xQO = Wherigo.Zone(_DSDk)
_xQO.Id = "0017c35a-3cfc-4ae6-b243-0088df05abc1"
_xQO.Name = _xcL("z\\i\ne4\029R`&\020b\n\\`\019\ni=")
_xQO.Description = ""
_xQO.Visible = true
_xQO.Commands = {}
_xQO.DistanceRange = Distance(-1, "feet")
_xQO.ShowObjects = "OnEnter"
_xQO.ProximityRange = Distance(60, "meters")
_xQO.AllowSetPositionTo = false
_xQO.Active = false
_xQO.Points = {
  ZonePoint(51.175159727529, 9.00448510846024, 0),
  ZonePoint(51.1750283759623, 9.00470594399417, 0),
  ZonePoint(51.1749153405042, 9.00453494577008, 0),
  ZonePoint(51.1750515214993, 9.00430948866245, 0)
}
_xQO.OriginalPoint = ZonePoint(51.1750387413737, 9.00450887172174, 0)
_xQO.DistanceRangeUOM = "Feet"
_xQO.ProximityRangeUOM = "Meters"
_xQO.OutOfRangeName = ""
_xQO.InRangeName = ""
_cJX = Wherigo.Zone(_DSDk)
_cJX.Id = "00a3479c-08b4-45ab-9494-ad7218a63f0b"
_cJX.Name = _xcL("\vv")
_cJX.Description = _xcL("\v<\\\004biV\004\nb`\n\\R\029\\e\n\\=iV4")
_cJX.Visible = true
_cJX.Commands = {}
_cJX.DistanceRange = Distance(-1, "feet")
_cJX.ShowObjects = "OnEnter"
_cJX.ProximityRange = Distance(60, "meters")
_cJX.AllowSetPositionTo = false
_cJX.Active = false
_cJX.Points = {
  ZonePoint(51.1723950161317, 9.00712479633896, 0),
  ZonePoint(51.1719479150172, 9.00687062204526, 0),
  ZonePoint(51.1717730574616, 9.00761549393367, 0),
  ZonePoint(51.1722090934225, 9.00791203060961, 0)
}
_cJX.OriginalPoint = ZonePoint(51.1720812705083, 9.00738073573187, 0)
_cJX.DistanceRangeUOM = "Feet"
_cJX.ProximityRangeUOM = "Meters"
_cJX.OutOfRangeName = ""
_cJX.InRangeName = ""
_6ky = Wherigo.Zone(_DSDk)
_6ky.Id = "474cd885-71b5-4c93-ac96-af27b16344d3"
_6ky.Name = _xcL("Bi\n[\n!i\020!\n=")
_6ky.Description = ""
_6ky.Visible = true
_6ky.Commands = {}
_6ky.DistanceRange = Distance(-1, "feet")
_6ky.ShowObjects = "OnEnter"
_6ky.ProximityRange = Distance(60, "meters")
_6ky.AllowSetPositionTo = false
_6ky.Active = false
_6ky.Points = {
  ZonePoint(51.1764895638653, 9.00269819694444, 0),
  ZonePoint(51.1764683562676, 9.00249984163846, 0),
  ZonePoint(51.176483779976, 9.00225843246757, 0),
  ZonePoint(51.1765695742595, 9.00209698047431, 0),
  ZonePoint(51.1766524764492, 9.00200164691638, 0),
  ZonePoint(51.1767440542762, 9.00204470078126, 0),
  ZonePoint(51.176771045601, 9.0022215291548, 0),
  ZonePoint(51.1767546580129, 9.00245217485946, 0),
  ZonePoint(51.1766997113512, 9.00264591725139, 0),
  ZonePoint(51.1766283769908, 9.00274586372337, 0),
  ZonePoint(51.1765628264003, 9.00278122939811, 0)
}
_6ky.OriginalPoint = ZonePoint(51.1766204021318, 9.00240422850996, 0)
_6ky.DistanceRangeUOM = "Feet"
_6ky.ProximityRangeUOM = "Meters"
_6ky.OutOfRangeName = ""
_6ky.InRangeName = ""
_C_G9 = Wherigo.Zone(_DSDk)
_C_G9.Id = "0d1c9041-cad8-4a8d-8203-ac460c119038"
_C_G9.Name = _xcL("\vv")
_C_G9.Description = _xcL("L\029!b\n\020=\029!")
_C_G9.Visible = true
_C_G9.Commands = {}
_C_G9.DistanceRange = Distance(-1, "feet")
_C_G9.ShowObjects = "OnEnter"
_C_G9.ProximityRange = Distance(60, "meters")
_C_G9.AllowSetPositionTo = false
_C_G9.Active = false
_C_G9.Points = {
  ZonePoint(51.1751322354971, 8.99659129643196, 0),
  ZonePoint(51.1753128433979, 8.99605673441603, 0),
  ZonePoint(51.1754789634094, 8.99623543526287, 0),
  ZonePoint(51.1753041510553, 8.99674534888611, 0)
}
_C_G9.OriginalPoint = ZonePoint(51.1753070483399, 8.99640720374924, 0)
_C_G9.DistanceRangeUOM = "Feet"
_C_G9.ProximityRangeUOM = "Meters"
_C_G9.OutOfRangeName = ""
_C_G9.InRangeName = ""
_xwK = Wherigo.Zone(_DSDk)
_xwK.Id = "04d5eb98-fe1b-4a22-8478-ae0f97862c52"
_xwK.Name = _xcL("C=b\bj\\i\020U4<&!\n\020`\b`\127\029=y")
_xwK.Description = ""
_xwK.Visible = false
_xwK.Commands = {}
_xwK.DistanceRange = Distance(-1, "feet")
_xwK.ShowObjects = "OnEnter"
_xwK.ProximityRange = Distance(60, "meters")
_xwK.AllowSetPositionTo = false
_xwK.Active = false
_xwK.Points = {
  ZonePoint(51.1776440365841, 9.00248328921683, 0),
  ZonePoint(51.1777068000218, 9.00241751841398, 0),
  ZonePoint(51.1777310085975, 9.00225271214339, 0),
  ZonePoint(51.1776692107842, 9.00212287176522, 0),
  ZonePoint(51.1775687709304, 9.00210566345085, 0),
  ZonePoint(51.177502144925, 9.00217497449919, 0),
  ZonePoint(51.1774866954028, 9.00234440150637, 0),
  ZonePoint(51.1775542870244, 9.00247070163901, 0)
}
_xwK.OriginalPoint = ZonePoint(51.1776078692838, 9.00229651657935, 0)
_xwK.DistanceRangeUOM = "Feet"
_xwK.ProximityRangeUOM = "Meters"
_xwK.OutOfRangeName = ""
_xwK.InRangeName = ""
_ybh6 = Wherigo.Zone(_DSDk)
_ybh6.Id = "61d2e410-533e-46df-ad12-7594df581aec"
_ybh6.Name = _xcL("5\029\\R\\\n!b\n`\b`C=b\bj\\i\020U4<&!\n\020")
_ybh6.Description = ""
_ybh6.Visible = true
_ybh6.Commands = {}
_ybh6.DistanceRange = Distance(-1, "feet")
_ybh6.ShowObjects = "OnEnter"
_ybh6.ProximityRange = Distance(60, "meters")
_ybh6.AllowSetPositionTo = false
_ybh6.Active = false
_ybh6.Points = {
  ZonePoint(51.1771964918498, 9.0024120849041, 0),
  ZonePoint(51.1773307010953, 9.00019091509578, 0),
  ZonePoint(51.178909, 9.000706, 0),
  ZonePoint(51.178572, 9.002744, 0)
}
_ybh6.OriginalPoint = ZonePoint(51.1780020482363, 9.00151324999997, 0)
_ybh6.DistanceRangeUOM = "Feet"
_ybh6.ProximityRangeUOM = "Meters"
_ybh6.OutOfRangeName = ""
_ybh6.InRangeName = ""
_lOan = Wherigo.Zone(_DSDk)
_lOan.Id = "9bb57597-3eec-4886-9a23-ab464ba56c5f"
_lOan.Name = _xcL("j\\&\nV\004\n\020wR\ni=\n\\`n9")
_lOan.Description = ""
_lOan.Visible = true
_lOan.Commands = {}
_lOan.DistanceRange = Distance(-1, "feet")
_lOan.ShowObjects = "OnEnter"
_lOan.ProximityRange = Distance(60, "meters")
_lOan.AllowSetPositionTo = false
_lOan.Active = false
_lOan.Points = {
  ZonePoint(51.1801017592053, 9.00341853963965, 0),
  ZonePoint(51.1798213413315, 9.00388230980301, 0),
  ZonePoint(51.1800228267725, 9.00424088737736, 0),
  ZonePoint(51.1803012202148, 9.00376392728166, 0)
}
_lOan.OriginalPoint = ZonePoint(51.180061786881, 9.00382641602542, 0)
_lOan.DistanceRangeUOM = "Feet"
_lOan.ProximityRangeUOM = "Meters"
_lOan.OutOfRangeName = ""
_lOan.InRangeName = ""
_gVBA = Wherigo.Zone(_DSDk)
_gVBA.Id = "b4b92421-b858-4f74-858d-efe3d820d46b"
_gVBA.Name = _xcL("j\\&\nV\004\n\020wR\ni=\n\\`{D")
_gVBA.Description = ""
_gVBA.Visible = true
_gVBA.Commands = {}
_gVBA.DistanceRange = Distance(-1, "feet")
_gVBA.ShowObjects = "OnEnter"
_gVBA.ProximityRange = Distance(60, "meters")
_gVBA.AllowSetPositionTo = false
_gVBA.Active = false
_gVBA.Points = {
  ZonePoint(51.1804822409488, 9.00511806018347, 0),
  ZonePoint(51.1807539200588, 9.00465257707233, 0),
  ZonePoint(51.1805858044898, 9.00434948175405, 0),
  ZonePoint(51.1803161344136, 9.00481450680272, 0)
}
_gVBA.OriginalPoint = ZonePoint(51.1805345249778, 9.00473365645314, 0)
_gVBA.DistanceRangeUOM = "Feet"
_gVBA.ProximityRangeUOM = "Meters"
_gVBA.OutOfRangeName = ""
_gVBA.InRangeName = ""
_YFO = Wherigo.Zone(_DSDk)
_YFO.Id = "c64acc22-b1c0-4203-8fbe-e2fc33b579a2"
_YFO.Name = _xcL("zi\020<=`\b`nb&R\n`v")
_YFO.Description = ""
_YFO.Visible = true
_YFO.Commands = {}
_YFO.DistanceRange = Distance(-1, "feet")
_YFO.ShowObjects = "OnEnter"
_YFO.ProximityRange = Distance(15, "meters")
_YFO.AllowSetPositionTo = false
_YFO.Active = false
_YFO.Points = {
  ZonePoint(51.1772907516905, 8.98199554232534, 0),
  ZonePoint(51.1772907516905, 8.98203309325615, 0),
  ZonePoint(51.1773109298178, 8.98203376380844, 0),
  ZonePoint(51.1773105094403, 8.98199353066834, 0)
}
_YFO.OriginalPoint = ZonePoint(51.1773007356598, 8.98201398251457, 0)
_YFO.DistanceRangeUOM = "Feet"
_YFO.ProximityRangeUOM = "Meters"
_YFO.OutOfRangeName = ""
_YFO.InRangeName = ""
_vzpn = Wherigo.Zone(_DSDk)
_vzpn.Id = "82bc645a-b893-410a-a74a-92313b136e6a"
_vzpn.Name = _xcL("zi\020<=`\b`nb&R\n`(")
_vzpn.Description = ""
_vzpn.Visible = true
_vzpn.Commands = {}
_vzpn.DistanceRange = Distance(-1, "feet")
_vzpn.ShowObjects = "OnEnter"
_vzpn.ProximityRange = Distance(15, "meters")
_vzpn.AllowSetPositionTo = false
_vzpn.Active = false
_vzpn.Points = {
  ZonePoint(51.1770674459513, 8.97951676380778, 0),
  ZonePoint(51.1770909872121, 8.97951676380778, 0),
  ZonePoint(51.1770914075916, 8.97947921287841, 0),
  ZonePoint(51.1770674459513, 8.9794798834307, 0)
}
_vzpn.OriginalPoint = ZonePoint(51.1770793216766, 8.97949815598117, 0)
_vzpn.DistanceRangeUOM = "Feet"
_vzpn.ProximityRangeUOM = "Meters"
_vzpn.OutOfRangeName = ""
_vzpn.InRangeName = ""
_SQg = Wherigo.Zone(_DSDk)
_SQg.Id = "fbeb38f6-6470-43d0-a3bf-16602f1eb2b9"
_SQg.Name = _xcL("zi\020<=`\b`nb&R\n`Q")
_SQg.Description = ""
_SQg.Visible = true
_SQg.Commands = {}
_SQg.DistanceRange = Distance(-1, "feet")
_SQg.ShowObjects = "OnEnter"
_SQg.ProximityRange = Distance(15, "meters")
_SQg.AllowSetPositionTo = false
_SQg.Active = false
_SQg.Points = {
  ZonePoint(51.17839117228, 8.97751355398464, 0),
  ZonePoint(51.1783907519123, 8.97754842270183, 0),
  ZonePoint(51.1784100888208, 8.97755043435859, 0),
  ZonePoint(51.1784105091883, 8.97751154232787, 0)
}
_SQg.OriginalPoint = ZonePoint(51.1784006305504, 8.97753098834323, 0)
_SQg.DistanceRangeUOM = "Feet"
_SQg.ProximityRangeUOM = "Meters"
_SQg.OutOfRangeName = ""
_SQg.InRangeName = ""
_FWV6 = Wherigo.Zone(_DSDk)
_FWV6.Id = "0cfd4c13-93e6-47a4-90a9-4f7c523f8a30"
_FWV6.Name = _xcL([[
9
Ua
i!
\]])
_FWV6.Description = ""
_FWV6.Visible = true
_FWV6.Commands = {}
_FWV6.DistanceRange = Distance(-1, "feet")
_FWV6.ShowObjects = "OnEnter"
_FWV6.ProximityRange = Distance(60, "meters")
_FWV6.AllowSetPositionTo = false
_FWV6.Active = false
_FWV6.Points = {
  ZonePoint(51.1973061977901, 9.04029139089177, 0),
  ZonePoint(51.1974432412363, 9.04066563797081, 0),
  ZonePoint(51.1976864440948, 9.04045772292687, 0),
  ZonePoint(51.197554226827, 9.04006191428769, 0)
}
_FWV6.OriginalPoint = ZonePoint(51.1974975274871, 9.04036916651928, 0)
_FWV6.DistanceRangeUOM = "Feet"
_FWV6.ProximityRangeUOM = "Meters"
_FWV6.OutOfRangeName = ""
_FWV6.InRangeName = ""
_I_PH = Wherigo.Zone(_DSDk)
_I_PH.Id = "964fe31b-d3d7-4904-a060-ef8e7d3e57c6"
_I_PH.Name = _xcL("O&i\020\n\020`C=b\bC!\n=`v")
_I_PH.Description = ""
_I_PH.Visible = true
_I_PH.Commands = {}
_I_PH.DistanceRange = Distance(-1, "feet")
_I_PH.ShowObjects = "OnEnter"
_I_PH.ProximityRange = Distance(60, "meters")
_I_PH.AllowSetPositionTo = false
_I_PH.Active = false
_I_PH.Points = {
  ZonePoint(51.1851698370903, 8.94981627054291, 0),
  ZonePoint(51.1850880182845, 8.94982229513777, 0),
  ZonePoint(51.1850867595325, 8.94967971306063, 0),
  ZonePoint(51.1851706594463, 8.94967797631145, 0)
}
_I_PH.OriginalPoint = ZonePoint(51.1851288185884, 8.94974906376319, 0)
_I_PH.DistanceRangeUOM = "Feet"
_I_PH.ProximityRangeUOM = "Meters"
_I_PH.OutOfRangeName = ""
_I_PH.InRangeName = ""
_Rxj = Wherigo.Zone(_DSDk)
_Rxj.Id = "3d88ab6d-f5b4-4f00-b57c-1de78b368f6d"
_Rxj.Name = _xcL("O&i\020\n\020`C=b\bC!\n=`(")
_Rxj.Description = ""
_Rxj.Visible = true
_Rxj.Commands = {}
_Rxj.DistanceRange = Distance(-1, "feet")
_Rxj.ShowObjects = "OnEnter"
_Rxj.ProximityRange = Distance(60, "meters")
_Rxj.AllowSetPositionTo = false
_Rxj.Active = false
_Rxj.Points = {
  ZonePoint(51.1855276922876, 8.94945422135336, 0),
  ZonePoint(51.1854597202792, 8.94946024594815, 0),
  ZonePoint(51.1854597202792, 8.94933573765547, 0),
  ZonePoint(51.1855281429801, 8.9493325662092, 0)
}
_Rxj.OriginalPoint = ZonePoint(51.1854938189565, 8.94939569279154, 0)
_Rxj.DistanceRangeUOM = "Feet"
_Rxj.ProximityRangeUOM = "Meters"
_Rxj.OutOfRangeName = ""
_Rxj.InRangeName = ""
_SKs = Wherigo.Zone(_DSDk)
_SKs.Id = "27a7be4f-712e-43e5-bdfd-8bb0b00bde4a"
_SKs.Name = _xcL("O&i\020\n\020`C=b\bC!\n=`Q")
_SKs.Description = ""
_SKs.Visible = true
_SKs.Commands = {}
_SKs.DistanceRange = Distance(-1, "feet")
_SKs.ShowObjects = "OnEnter"
_SKs.ProximityRange = Distance(60, "meters")
_SKs.AllowSetPositionTo = false
_SKs.Active = false
_SKs.Points = {
  ZonePoint(51.1856905826477, 8.94993172125882, 0),
  ZonePoint(51.1856918413832, 8.95005020495675, 0),
  ZonePoint(51.1856251283542, 8.95005422135333, 0),
  ZonePoint(51.1856213521421, 8.94993573765536, 0)
}
_SKs.OriginalPoint = ZonePoint(51.1856572261318, 8.94999297130606, 0)
_SKs.DistanceRangeUOM = "Feet"
_SKs.ProximityRangeUOM = "Meters"
_SKs.OutOfRangeName = ""
_SKs.InRangeName = ""
_aKBkN = Wherigo.Zone(_DSDk)
_aKBkN.Id = "4ed84309-6b73-4825-b520-3a2cb52f5d33"
_aKBkN.Name = _xcL("\014V\004\n")
_aKBkN.Description = ""
_aKBkN.Visible = true
_aKBkN.Commands = {}
_aKBkN.DistanceRange = Distance(-1, "feet")
_aKBkN.ShowObjects = "OnEnter"
_aKBkN.ProximityRange = Distance(60, "meters")
_aKBkN.AllowSetPositionTo = false
_aKBkN.Active = false
_aKBkN.Points = {
  ZonePoint(51.1921274151392, 9.01288657398407, 0),
  ZonePoint(51.1919626389235, 9.01290041197071, 0),
  ZonePoint(51.1919597481075, 9.01266977886022, 0),
  ZonePoint(51.1921274151392, 9.01266055353584, 0)
}
_aKBkN.OriginalPoint = ZonePoint(51.1920443043273, 9.01277932958771, 0)
_aKBkN.DistanceRangeUOM = "Feet"
_aKBkN.ProximityRangeUOM = "Meters"
_aKBkN.OutOfRangeName = ""
_aKBkN.InRangeName = ""
_apmiY = Wherigo.Zone(_DSDk)
_apmiY.Id = "59c7a27d-4e93-4ae0-8af4-c2bac0a79a9d"
_apmiY.Name = _xcL("6\029\\\0204<U\n\020`nV4<R!b<==")
_apmiY.Description = _xcL("\v\nU\n=`R&\n\\`D[\n\\\004<\020b\n8`(v\023_+2`?tjO-z&\n\\`)\020b\n\\\004<\020b\n8`(+G_\016`?")
_apmiY.Visible = true
_apmiY.Commands = {}
_apmiY.DistanceRange = Distance(-1, "feet")
_apmiY.ShowObjects = "OnEnter"
_apmiY.ProximityRange = Distance(60, "meters")
_apmiY.AllowSetPositionTo = false
_apmiY.Active = false
_apmiY.Points = {
  ZonePoint(51.197412988653, 9.06127936795817, 0),
  ZonePoint(51.1974158772856, 9.06201231402973, 0),
  ZonePoint(51.19707452495, 9.06200772537052, 0),
  ZonePoint(51.1970634495755, 9.06128728469216, 0)
}
_apmiY.OriginalPoint = ZonePoint(51.197241710116, 9.06164667301265, 0)
_apmiY.DistanceRangeUOM = "Feet"
_apmiY.ProximityRangeUOM = "Meters"
_apmiY.OutOfRangeName = ""
_apmiY.InRangeName = ""
_mReoG = Wherigo.Zone(_DSDk)
_mReoG.Id = "d96eb75a-0885-493b-be05-f8b77d33a5e9"
_mReoG.Name = _xcL("3&b`6\029\\\0204<U\n\020")
_mReoG.Description = _xcL("\v\nU\n=`R&\n\\`3\\&\020e?<&\n\\\0208`(v\027_G2`?")
_mReoG.Visible = true
_mReoG.Commands = {}
_mReoG.DistanceRange = Distance(-1, "feet")
_mReoG.ShowObjects = "OnEnter"
_mReoG.ProximityRange = Distance(60, "meters")
_mReoG.AllowSetPositionTo = false
_mReoG.Active = false
_mReoG.Points = {
  ZonePoint(51.2000770864816, 9.05382517133985, 0),
  ZonePoint(51.1992385811389, 9.05365485946621, 0),
  ZonePoint(51.1990403867369, 9.05509034525832, 0),
  ZonePoint(51.199863650206, 9.05535797820265, 0)
}
_mReoG.OriginalPoint = ZonePoint(51.1995549261408, 9.05448208856676, 0)
_mReoG.DistanceRangeUOM = "Feet"
_mReoG.ProximityRangeUOM = "Meters"
_mReoG.OutOfRangeName = ""
_mReoG.InRangeName = ""
_1lq4 = Wherigo.Zone(_DSDk)
_1lq4.Id = "1b963bc5-552a-45f9-a53a-f03d383f0b1a"
_1lq4.Name = _xcL("j\n\\iV4\n\\`j\\&\nV\004\n")
_1lq4.Description = _xcL("\014\\!V4\ni\020b`<[`\v\nU\n=`(v\016`?tjO-6\029==!b<\n\020eiU`<[`\v\nU\n=`(vv_\0162`?")
_1lq4.Visible = true
_1lq4.Commands = {}
_1lq4.DistanceRange = Distance(-1, "feet")
_1lq4.ShowObjects = "OnEnter"
_1lq4.ProximityRange = Distance(60, "meters")
_1lq4.AllowSetPositionTo = false
_1lq4.Active = false
_1lq4.Points = {
  ZonePoint(51.1958540407835, 9.0308664546932, 0),
  ZonePoint(51.1952832935944, 9.03059110545898, 0),
  ZonePoint(51.1953496599099, 9.03023103338347, 0),
  ZonePoint(51.195927042821, 9.03052756332795, 0)
}
_1lq4.OriginalPoint = ZonePoint(51.1956035092772, 9.0305540392159, 0)
_1lq4.DistanceRangeUOM = "Feet"
_1lq4.ProximityRangeUOM = "Meters"
_1lq4.OutOfRangeName = ""
_1lq4.InRangeName = ""
_Aqu8 = Wherigo.Zone(_DSDk)
_Aqu8.Id = "f660e28b-5608-4a7c-844e-1bee6891db9b"
_Aqu8.Name = _xcL("C&R`e\n?`9\nU`y&?`\127\029wR\n\020[\n\\U")
_Aqu8.Description = ""
_Aqu8.Visible = false
_Aqu8.Commands = {}
_Aqu8.DistanceRange = Distance(-1, "feet")
_Aqu8.ShowObjects = "OnEnter"
_Aqu8.ProximityRange = Distance(60, "meters")
_Aqu8.AllowSetPositionTo = false
_Aqu8.Active = false
_Aqu8.Points = {
  ZonePoint(51.1864571867882, 9.04815373093762, 0),
  ZonePoint(51.1859995502139, 9.04834843124018, 0),
  ZonePoint(51.1862893872385, 9.05000338381269, 0),
  ZonePoint(51.1867775296865, 9.04971133335867, 0)
}
_Aqu8.OriginalPoint = ZonePoint(51.1863809134818, 9.04905421983729, 0)
_Aqu8.DistanceRangeUOM = "Feet"
_Aqu8.ProximityRangeUOM = "Meters"
_Aqu8.OutOfRangeName = ""
_Aqu8.InRangeName = ""
_mxHN4 = Wherigo.Zone(_DSDk)
_mxHN4.Id = "99c1860d-8560-4f01-b74a-278625075437"
_mxHN4.Name = _xcL("zi\020<=`nb&R\n`(`U\\\029!!")
_mxHN4.Description = ""
_mxHN4.Visible = true
_mxHN4.Commands = {}
_mxHN4.DistanceRange = Distance(-1, "feet")
_mxHN4.ShowObjects = "OnEnter"
_mxHN4.ProximityRange = Distance(60, "meters")
_mxHN4.AllowSetPositionTo = false
_mxHN4.Active = false
_mxHN4.Points = {
  ZonePoint(51.1773655450489, 8.97906542963758, 0),
  ZonePoint(51.1767986911246, 8.97902033978513, 0),
  ZonePoint(51.1767993344136, 8.97991783739288, 0),
  ZonePoint(51.1773565066463, 8.97992421339133, 0)
}
_mxHN4.OriginalPoint = ZonePoint(51.1770800193084, 8.97948195505173, 0)
_mxHN4.DistanceRangeUOM = "Feet"
_mxHN4.ProximityRangeUOM = "Meters"
_mxHN4.OutOfRangeName = ""
_mxHN4.InRangeName = ""
_PH0 = Wherigo.Zone(_DSDk)
_PH0.Id = "c5739636-7168-4ea5-968b-eaab90ee01ad"
_PH0.Name = _xcL("zi\020<=`nb&R\n`v`U\\\029!!")
_PH0.Description = ""
_PH0.Visible = true
_PH0.Commands = {}
_PH0.DistanceRange = Distance(-1, "feet")
_PH0.ShowObjects = "OnEnter"
_PH0.ProximityRange = Distance(60, "meters")
_PH0.AllowSetPositionTo = false
_PH0.Active = false
_PH0.Points = {
  ZonePoint(51.1776183069577, 8.98148403055668, 0),
  ZonePoint(51.1769439656176, 8.98151069683662, 0),
  ZonePoint(51.1769441192488, 8.98257989553564, 0),
  ZonePoint(51.177610793383, 8.98255602460137, 0)
}
_PH0.OriginalPoint = ZonePoint(51.1772792963018, 8.98203266188258, 0)
_PH0.DistanceRangeUOM = "Feet"
_PH0.ProximityRangeUOM = "Meters"
_PH0.OutOfRangeName = ""
_PH0.InRangeName = ""
_ja5 = Wherigo.Zone(_DSDk)
_ja5.Id = "5114b5bb-0a5c-4f2b-8c31-7654816ebe89"
_ja5.Name = _xcL("zi\020<=`nb&R\n`Q`U\\\029!!")
_ja5.Description = ""
_ja5.Visible = true
_ja5.Commands = {}
_ja5.DistanceRange = Distance(-1, "feet")
_ja5.ShowObjects = "OnEnter"
_ja5.ProximityRange = Distance(60, "meters")
_ja5.AllowSetPositionTo = false
_ja5.Active = false
_ja5.Points = {
  ZonePoint(51.1780562484906, 8.97704149749318, 0),
  ZonePoint(51.1780742558851, 8.97806189067581, 0),
  ZonePoint(51.1786918885477, 8.97807558913306, 0),
  ZonePoint(51.1786916071566, 8.97709759971873, 0)
}
_ja5.OriginalPoint = ZonePoint(51.17837850002, 8.9775691442552, 0)
_ja5.DistanceRangeUOM = "Feet"
_ja5.ProximityRangeUOM = "Meters"
_ja5.OutOfRangeName = ""
_ja5.InRangeName = ""
_w32 = Wherigo.Zone(_DSDk)
_w32.Id = "f2eae910-8ebb-4cab-8a05-0545f711eaa2"
_w32.Name = _xcL("\v<\\\004w=<by`zi\020<=")
_w32.Description = _xcL("j\n!b\n\\`=\nU<=\n\\`\v<\\\004w=<by`R&\n\\`<==\n`e\\\ni`zi\020<=!")
_w32.Visible = true
_w32.Commands = {}
_w32.DistanceRange = Distance(-1, "feet")
_w32.ShowObjects = "OnEnter"
_w32.ProximityRange = Distance(60, "meters")
_w32.AllowSetPositionTo = false
_w32.Active = false
_w32.Points = {
  ZonePoint(51.1776043288071, 8.98723975927959, 0),
  ZonePoint(51.177186445141, 8.9873337471233, 0),
  ZonePoint(51.1772108222688, 8.9876560286026, 0),
  ZonePoint(51.1776300538331, 8.98760092508981, 0)
}
_w32.OriginalPoint = ZonePoint(51.1774079125125, 8.98745761502382, 0)
_w32.DistanceRangeUOM = "Feet"
_w32.ProximityRangeUOM = "Meters"
_w32.OutOfRangeName = ""
_w32.InRangeName = ""
_0at6 = Wherigo.Zone(_DSDk)
_0at6.Id = "12686f5c-71ff-4e46-b93c-6b3b6ce4f5df"
_0at6.Name = _xcL("j&\\U`j\\i\020U")
_0at6.Description = ""
_0at6.Visible = true
_0at6.Commands = {}
_0at6.DistanceRange = Distance(-1, "feet")
_0at6.ShowObjects = "OnEnter"
_0at6.ProximityRange = Distance(60, "meters")
_0at6.AllowSetPositionTo = false
_0at6.Active = false
_0at6.Points = {
  ZonePoint(51.1767645531215, 9.00234826846217, 0),
  ZonePoint(51.1766956797774, 9.00233409300249, 0),
  ZonePoint(51.1766858258247, 9.00245179172621, 0),
  ZonePoint(51.1767546991835, 9.00246521600458, 0)
}
_0at6.OriginalPoint = ZonePoint(51.1767251894768, 9.00239984229886, 0)
_0at6.DistanceRangeUOM = "Feet"
_0at6.ProximityRangeUOM = "Meters"
_0at6.OutOfRangeName = ""
_0at6.InRangeName = ""
_rVgz = Wherigo.Zone(_DSDk)
_rVgz.Id = "ca0b4c4e-a95b-4c5a-97c4-50af45e46cd1"
_rVgz.Name = _xcL([[
C[ya
iU`y&\`nb&R
`Q]])
_rVgz.Description = _xcL("\127i\n\\`y&?`zi\020<=`nb&R\n`Q`<[ya\niU\n\020.")
_rVgz.Visible = true
_rVgz.Commands = {}
_rVgz.DistanceRange = Distance(-1, "feet")
_rVgz.ShowObjects = "OnEnter"
_rVgz.ProximityRange = Distance(60, "meters")
_rVgz.AllowSetPositionTo = false
_rVgz.Active = false
_rVgz.Points = {
  ZonePoint(51.1775693081877, 8.97950938846516, 0),
  ZonePoint(51.1773348829895, 8.97936370733076, 0),
  ZonePoint(51.1774413635235, 8.97921466948821, 0),
  ZonePoint(51.1776057851626, 8.97930440903877, 0)
}
_rVgz.OriginalPoint = ZonePoint(51.1774878349658, 8.97934804358072, 0)
_rVgz.DistanceRangeUOM = "Feet"
_rVgz.ProximityRangeUOM = "Meters"
_rVgz.OutOfRangeName = ""
_rVgz.InRangeName = ""
_Xdc = Wherigo.Zone(_DSDk)
_Xdc.Id = "7a8bf219-1922-409e-bb6f-ac482c99dd37"
_Xdc.Name = _xcL("j<&?\bO\n!b")
_Xdc.Description = ""
_Xdc.Visible = false
_Xdc.Commands = {}
_Xdc.DistanceRange = Distance(-1, "feet")
_Xdc.ShowObjects = "OnEnter"
_Xdc.ProximityRange = Distance(60, "meters")
_Xdc.AllowSetPositionTo = false
_Xdc.Active = false
_Xdc.Points = {
  ZonePoint(51.177940021193, 9.00280197242989, 0),
  ZonePoint(51.1779397591005, 9.00302757144152, 0),
  ZonePoint(51.1777963479745, 9.00303773567054, 0),
  ZonePoint(51.1777912045043, 9.0027993072642, 0)
}
_Xdc.OriginalPoint = ZonePoint(51.1778668331931, 9.00291664670154, 0)
_Xdc.DistanceRangeUOM = "Feet"
_Xdc.ProximityRangeUOM = "Meters"
_Xdc.OutOfRangeName = ""
_Xdc.InRangeName = ""
_Llejb = Wherigo.Zone(_DSDk)
_Llejb.Id = "f1156311-d5a2-471f-855a-b8902d45a9a7"
_Llejb.Name = _xcL("6\029\\e\n\\\n\\`r&U<\020U")
_Llejb.Description = ""
_Llejb.Visible = true
_Llejb.Commands = {}
_Llejb.DistanceRange = Distance(-1, "feet")
_Llejb.ShowObjects = "OnEnter"
_Llejb.ProximityRange = Distance(60, "meters")
_Llejb.AllowSetPositionTo = false
_Llejb.Active = false
_Llejb.Points = {
  ZonePoint(51.1748581523551, 8.99794792041435, 0),
  ZonePoint(51.1747102560576, 8.9979092702462, 0),
  ZonePoint(51.1746835176932, 8.99816782654342, 0),
  ZonePoint(51.174832249648, 8.99819581459621, 0)
}
_Llejb.OriginalPoint = ZonePoint(51.1747710439385, 8.99805520795005, 0)
_Llejb.DistanceRangeUOM = "Feet"
_Llejb.ProximityRangeUOM = "Meters"
_Llejb.OutOfRangeName = ""
_Llejb.InRangeName = ""
_pmrZ = Wherigo.Zone(_DSDk)
_pmrZ.Id = "ec912329-4018-4cdf-85e4-2ab7964d3407"
_pmrZ.Name = _xcL("\127i\020b\n\\\n\\`r&U<\020U")
_pmrZ.Description = ""
_pmrZ.Visible = true
_pmrZ.Commands = {}
_pmrZ.DistanceRange = Distance(-1, "feet")
_pmrZ.ShowObjects = "OnEnter"
_pmrZ.ProximityRange = Distance(60, "meters")
_pmrZ.AllowSetPositionTo = false
_pmrZ.Active = false
_pmrZ.Points = {
  ZonePoint(51.1746042074591, 8.99948568149846, 0),
  ZonePoint(51.1747614563379, 8.99951152737366, 0),
  ZonePoint(51.1747600120765, 8.99975879798505, 0),
  ZonePoint(51.1746013957796, 8.99973589053307, 0)
}
_pmrZ.OriginalPoint = ZonePoint(51.1746817679133, 8.99962297434756, 0)
_pmrZ.DistanceRangeUOM = "Feet"
_pmrZ.ProximityRangeUOM = "Meters"
_pmrZ.OutOfRangeName = ""
_pmrZ.InRangeName = ""
_bHJ = Wherigo.Zone(_DSDk)
_bHJ.Id = "91725ac0-9bff-4500-a6fa-4cce97a20cb9"
_bHJ.Name = _xcL("\v(")
_bHJ.Description = _xcL("\004\029!b\n\020=\029!")
_bHJ.Visible = true
_bHJ.Commands = {}
_bHJ.DistanceRange = Distance(-1, "feet")
_bHJ.ShowObjects = "OnEnter"
_bHJ.ProximityRange = Distance(60, "meters")
_bHJ.AllowSetPositionTo = false
_bHJ.Active = false
_bHJ.Points = {
  ZonePoint(51.1750037537949, 8.99743112902859, 0),
  ZonePoint(51.1748809143465, 8.99740663734079, 0),
  ZonePoint(51.1748386882105, 8.99769747613312, 0),
  ZonePoint(51.174963447137, 8.99774339804771, 0)
}
_bHJ.OriginalPoint = ZonePoint(51.1749217008722, 8.99756966013755, 0)
_bHJ.DistanceRangeUOM = "Feet"
_bHJ.ProximityRangeUOM = "Meters"
_bHJ.OutOfRangeName = ""
_bHJ.InRangeName = ""
_Rv8P = Wherigo.Zone(_DSDk)
_Rv8P.Id = "1a3f950d-6d07-4a73-a39a-eaf17df44488"
_Rv8P.Name = _xcL("5\029\\R\\\n!b\n`j\n\\iV4")
_Rv8P.Description = ""
_Rv8P.Visible = true
_Rv8P.Commands = {}
_Rv8P.DistanceRange = Distance(-1, "feet")
_Rv8P.ShowObjects = "OnEnter"
_Rv8P.ProximityRange = Distance(60, "meters")
_Rv8P.AllowSetPositionTo = false
_Rv8P.Active = false
_Rv8P.Points = {
  ZonePoint(51.1969873849931, 9.03177651091018, 0),
  ZonePoint(51.1966612904331, 9.03171146341196, 0),
  ZonePoint(51.1965593854098, 9.03267091401073, 0),
  ZonePoint(51.1969007663507, 9.03272783057167, 0)
}
_Rv8P.OriginalPoint = ZonePoint(51.1967772067967, 9.03222167972613, 0)
_Rv8P.DistanceRangeUOM = "Feet"
_Rv8P.ProximityRangeUOM = "Meters"
_Rv8P.OutOfRangeName = ""
_Rv8P.InRangeName = ""
_2q3 = Wherigo.Zone(_DSDk)
_2q3.Id = "e755243f-bc82-4ee5-8e33-30f1e76ae7bf"
_2q3.Name = _xcL("j\n\\iV4\n\\`\127&\nbb\n`\0294\020\n`9\nUa\ni!\n\\")
_2q3.Description = ""
_2q3.Visible = false
_2q3.Commands = {}
_2q3.DistanceRange = Distance(-1, "feet")
_2q3.ShowObjects = "OnEnter"
_2q3.ProximityRange = Distance(60, "meters")
_2q3.AllowSetPositionTo = false
_2q3.Active = false
_2q3.Points = {
  ZonePoint(51.1922748086636, 9.0122640291625, 0),
  ZonePoint(51.1916639687476, 9.01223945758884, 0),
  ZonePoint(51.1916588356048, 9.01359908466857, 0),
  ZonePoint(51.1922696755888, 9.01361546571768, 0)
}
_2q3.OriginalPoint = ZonePoint(51.1919668221512, 9.0129295092844, 0)
_2q3.DistanceRangeUOM = "Feet"
_2q3.ProximityRangeUOM = "Meters"
_2q3.OutOfRangeName = ""
_2q3.InRangeName = ""
_OHy9A = Wherigo.Zone(_DSDk)
_OHy9A.Id = "13ef2e11-afe2-4f85-bc7c-1bacf115aa36"
_OHy9A.Name = _xcL("z\\i\ne4\029R`j\n\\iV4`\0294\020\n`9\nUa\ni!\n\\")
_OHy9A.Description = ""
_OHy9A.Visible = false
_OHy9A.Commands = {}
_OHy9A.DistanceRange = Distance(-1, "feet")
_OHy9A.ShowObjects = "OnEnter"
_OHy9A.ProximityRange = Distance(60, "meters")
_OHy9A.AllowSetPositionTo = false
_OHy9A.Active = false
_OHy9A.Points = {
  ZonePoint(51.1969446403914, 9.04007635651202, 0),
  ZonePoint(51.1963084332874, 9.04049409773803, 0),
  ZonePoint(51.1969204282004, 9.04213001192527, 0),
  ZonePoint(51.197434549966, 9.04164195352957, 0)
}
_OHy9A.OriginalPoint = ZonePoint(51.1969020129613, 9.04108560492622, 0)
_OHy9A.DistanceRangeUOM = "Feet"
_OHy9A.ProximityRangeUOM = "Meters"
_OHy9A.OutOfRangeName = ""
_OHy9A.InRangeName = ""
_n2mHq = Wherigo.ZItem(_DSDk)
_n2mHq.Id = "ea444f62-57a8-4465-944a-d80517a9d3be"
_n2mHq.Name = _xcL("L\029\029\\ei\020<b\n\020`nb&R\n`v")
_n2mHq.Description = ""
_n2mHq.Visible = true
_n2mHq.Commands = {}
_n2mHq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_n2mHq.Locked = false
_n2mHq.Opened = false
_GZ0WP = Wherigo.ZItem(_DSDk)
_GZ0WP.Id = "ab151a25-a1c2-4ecc-9367-ffbe77e44443"
_GZ0WP.Name = _xcL("L\029\029\\ei\020<b\n\020`nb&R\n`(")
_GZ0WP.Description = ""
_GZ0WP.Visible = true
_GZ0WP.Commands = {}
_GZ0WP.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_GZ0WP.Locked = false
_GZ0WP.Opened = false
__7Z = Wherigo.ZItem(_DSDk)
__7Z.Id = "7fdfa110-401b-481d-a8fa-83add971237d"
__7Z.Name = _xcL("L\029\029\\ei\020<b\n\020`nb&R\n`Q")
__7Z.Description = ""
__7Z.Visible = true
__7Z.Commands = {}
__7Z.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__7Z.Locked = false
__7Z.Opened = false
_MKBn = Wherigo.ZItem(_DSDk)
_MKBn.Id = "4ddc3f47-6c86-44aa-bc68-9db7f2c196c8"
_MKBn.Name = _xcL("\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR")
_MKBn.Description = ""
_MKBn.Visible = true
_MKBn.Commands = {}
_MKBn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_MKBn.Locked = false
_MKBn.Opened = false
_2yV0v = Wherigo.ZItem(_DSDk)
_2yV0v.Id = "48ea4ffa-f2a0-455b-8832-33e86589511f"
_2yV0v.Name = _xcL("nw\029i=\n\\`nb&R\n`v`7z\029b\029!A")
_2yV0v.Description = ""
_2yV0v.Visible = true
_2yV0v.Commands = {}
_2yV0v.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2yV0v.Locked = false
_2yV0v.Opened = false
_tGF = Wherigo.ZItem(_DSDk)
_tGF.Id = "96b33102-eadf-40cd-aa2c-60fd8dbf3a26"
_tGF.Name = _xcL("nw\029i=\n\\`nb&R\n`(`7z\029b\029A")
_tGF.Description = ""
_tGF.Visible = true
_tGF.Commands = {}
_tGF.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tGF.Locked = false
_tGF.Opened = false
_rXC = Wherigo.ZItem(_DSDk)
_rXC.Id = "ef15031b-a5cb-4bfd-b76e-a97fa44502b6"
_rXC.Name = _xcL("nw\029i=\n\\`nb&R\n`Q`7z\029b\029A")
_rXC.Description = ""
_rXC.Visible = true
_rXC.Commands = {}
_rXC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rXC.Locked = false
_rXC.Opened = false
_BZat = Wherigo.ZItem(_DSDk)
_BZat.Id = "320a30f4-d0ac-4647-86a3-9b6bff07d0bd"
_BZat.Name = _xcL(")\020=\029V\004\bm\029e\n")
_BZat.Description = ""
_BZat.Visible = true
_BZat.Commands = {}
_BZat.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BZat.Locked = false
_BZat.Opened = false
_kH04N = Wherigo.ZItem(_DSDk)
_kH04N.Id = "855d4111-333d-47fe-b994-ce4dcab7480d"
_kH04N.Name = _xcL("ji=e`e\n\\`U\n!&V4b\n\020`O\n!b\n")
_kH04N.Description = ""
_kH04N.Visible = true
_kH04N.Commands = {}
_kH04N.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_kH04N.Locked = false
_kH04N.Opened = false
_q88p = Wherigo.ZItem(_DSDk)
_q88p.Id = "7fc43b17-d880-46f0-8b63-ab64b547dd88"
_q88p.Name = _xcL("6i\n=\br&\b\017<b!V4iU\bL\020\029wR")
_q88p.Description = ""
_q88p.Visible = true
_q88p.Commands = {}
_q88p.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_q88p.Locked = false
_q88p.Opened = false
_ZHm4x = Wherigo.ZItem(_DSDk)
_ZHm4x.Id = "37ca0749-61ba-4b68-83d9-fc4f4c99ab57"
_ZHm4x.Name = _xcL("nw\029i=\n\\`nb&R\n`v`7\019\nNbA")
_ZHm4x.Description = ""
_ZHm4x.Visible = true
_ZHm4x.Commands = {}
_ZHm4x.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ZHm4x.Locked = false
_ZHm4x.Opened = false
_BI7w = Wherigo.ZItem(_DSDk)
_BI7w.Id = "6ba81535-c646-45b8-ba80-0bee2996fee7"
_BI7w.Name = _xcL("nw\029i=\n\\`nb&R\n`(`7\019\nNbA`")
_BI7w.Description = ""
_BI7w.Visible = true
_BI7w.Commands = {}
_BI7w.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BI7w.Locked = false
_BI7w.Opened = false
_tEN = Wherigo.ZItem(_DSDk)
_tEN.Id = "110603bf-49da-47e0-b9ba-c737ea57eaa3"
_tEN.Name = _xcL("nw\029i=\n\\`nb&R\n`Q`7\019\nNbA`")
_tEN.Description = ""
_tEN.Visible = true
_tEN.Commands = {}
_tEN.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_tEN.Locked = false
_tEN.Opened = false
_IIuy = Wherigo.ZItem(_DSDk)
_IIuy.Id = "268e61a3-3aa8-40b4-94e2-41c73b2cb8b3"
_IIuy.Name = _xcL("zi\020e\n\br\029\020\n\b{iV4b\bL\020\029wR")
_IIuy.Description = ""
_IIuy.Visible = true
_IIuy.Commands = {}
_IIuy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_IIuy.Locked = false
_IIuy.Opened = false
_MqId = Wherigo.ZItem(_DSDk)
_MqId.Id = "883a1ba7-e2bc-46a6-aaca-82806bc7ab5f"
_MqId.Name = _xcL("nw\029i=\n\\`j<&?\\\n!b")
_MqId.Description = ""
_MqId.Visible = true
_MqId.Commands = {}
_MqId.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_MqId.Locked = false
_MqId.Opened = false
_3FiB = Wherigo.ZTask(_DSDk)
_3FiB.Id = "c27477cf-040f-4d49-a05d-4a5105f7d4b2"
_3FiB.Name = _xcL("nb&R\n`v8`5\n\020\004?<=`&\020e`j\\&\nV\004\n`[\ni`C!\n=")
_3FiB.Description = ""
_3FiB.Visible = true
_3FiB.Active = false
_3FiB.Complete = false
_3FiB.CorrectState = "None"
_xwq = Wherigo.ZTask(_DSDk)
_xwq.Id = "44173c88-2fab-443b-9074-2292ccb1ab41"
_xwq.Name = _xcL("nb&R\n`v8`z\\i\ne4\029R`C=b\bC!\n=`[\n!&V4\n\020")
_xwq.Description = ""
_xwq.Visible = true
_xwq.Active = false
_xwq.Complete = false
_xwq.CorrectState = "None"
_uVKJ = Wherigo.ZTask(_DSDk)
_uVKJ.Id = "8c96e591-126d-4efe-9aa2-15a571d729dc"
_uVKJ.Name = _xcL("nb&R\n`Q8`j\n\\iV4\n\\`\127&\nbb\n`&\020e`nw\n\\\\?<&\n\\?\029e\n==`[\n!&V4\n\020")
_uVKJ.Description = ""
_uVKJ.Visible = true
_uVKJ.Active = false
_uVKJ.Complete = false
_uVKJ.CorrectState = "None"
_0xC = Wherigo.ZTask(_DSDk)
_0xC.Id = "f5aa4fc5-b6af-4748-8c9f-ca8dfc3be99c"
_0xC.Name = _xcL("nb&R\n`v8`5\029\\R\\\n!b\n`j\n\\iV4`\n\\\004&\020e\n\020")
_0xC.Description = ""
_0xC.Visible = true
_0xC.Active = false
_0xC.Complete = false
_0xC.CorrectState = "None"
_I0oF = Wherigo.ZTask(_DSDk)
_I0oF.Id = "b1f408ab-4ecb-40b3-8248-3b10c526b6f6"
_I0oF.Name = _xcL("nb&R\n`(8`z\\i\ne4\029R`>\029\020`j\n\\iV4`[\n!&V4\n\020")
_I0oF.Description = ""
_I0oF.Visible = true
_I0oF.Active = false
_I0oF.Complete = false
_I0oF.CorrectState = "None"
_p_T = Wherigo.ZTask(_DSDk)
_p_T.Id = "6ed77572-4d13-475d-b3d3-8398a924edfa"
_p_T.Name = _xcL("nb&R\n`v8`nw\n\\\\?<&\n\\`<\020!V4<&\n\020")
_p_T.Description = ""
_p_T.Visible = true
_p_T.Active = false
_p_T.Complete = false
_p_T.CorrectState = "None"
_JQtI = Wherigo.ZTask(_DSDk)
_JQtI.Id = "7805e3ac-adf2-4561-91c7-a95d4bfbb8d2"
_JQtI.Name = _xcL("nb&R\n`(8`3=\ni!\n`[\ni`O\n4[<V4`\n\\\004&\020e\n\020")
_JQtI.Description = ""
_JQtI.Visible = true
_JQtI.Active = false
_JQtI.Complete = false
_JQtI.CorrectState = "None"
_jBF9t = Wherigo.ZTask(_DSDk)
_jBF9t.Id = "dc602595-03fe-4b04-8570-5352aad6107a"
_jBF9t.Name = _xcL("nb&R\n`(8`z\\i\ne4\029R`>\029\020`C=b\bj\\i\020U4<&!\n\020`[\n!&V4\n\020")
_jBF9t.Description = ""
_jBF9t.Visible = true
_jBF9t.Active = false
_jBF9t.Complete = false
_jBF9t.CorrectState = "None"
_3_2 = Wherigo.ZTask(_DSDk)
_3_2.Id = "3e555494-c8e6-4727-8600-134efc9e59c1"
_3_2.Name = _xcL("nb&R\n`v8`O\n!b\n`e\n\\`j&\\U`j\\i\020U`[\n!&V4\n\020")
_3_2.Description = ""
_3_2.Visible = true
_3_2.Active = false
_3_2.Complete = false
_3_2.CorrectState = "None"
_5sM = Wherigo.ZTask(_DSDk)
_5sM.Id = "4425a251-658f-4ecb-993f-0cde953099d4"
_5sM.Name = _xcL("nb&R\n`Q8`5\029\\R\\\n!b\n`C=b\bj\\i\020U4<&!\n\020`\n\\\004&\020e\n\020")
_5sM.Description = ""
_5sM.Visible = true
_5sM.Active = false
_5sM.Complete = false
_5sM.CorrectState = "None"
_0fzmj = Wherigo.ZTask(_DSDk)
_0fzmj.Id = "c878a67e-4cb8-4f49-9910-0d99c313140d"
_0fzmj.Name = _xcL("nb&R\n`Q8`j\\&\nV\004\n`[\ni`C=b\bj\\i\020U4<&!\n\020`[\n!&V4\n\020")
_0fzmj.Description = ""
_0fzmj.Visible = true
_0fzmj.Active = false
_0fzmj.Complete = false
_0fzmj.CorrectState = "None"
_afnxp = Wherigo.ZTask(_DSDk)
_afnxp.Id = "0df123fc-24e6-4a29-8511-b541c4a10970"
_afnxp.Name = _xcL("nb&R\n`Q8`\127\029wR\n\020[\n\\U`\n\\\004=i??\n\020")
_afnxp.Description = ""
_afnxp.Visible = true
_afnxp.Active = false
_afnxp.Complete = false
_afnxp.CorrectState = "None"
_CvVXL = Wherigo.ZTask(_DSDk)
_CvVXL.Id = "a7ab2fa4-b609-4bc1-8450-dddebdb06a29"
_CvVXL.Name = _xcL("zi\020<=`nb&R\n`v")
_CvVXL.Description = ""
_CvVXL.Visible = true
_CvVXL.Active = false
_CvVXL.Complete = false
_CvVXL.CorrectState = "None"
_WWB = Wherigo.ZTask(_DSDk)
_WWB.Id = "39af9931-8e2e-4569-adfe-18facc3dd8ab"
_WWB.Name = _xcL("zi\020<=`nb&R\n`(")
_WWB.Description = ""
_WWB.Visible = true
_WWB.Active = false
_WWB.Complete = false
_WWB.CorrectState = "None"
_Ube = Wherigo.ZTask(_DSDk)
_Ube.Id = "1f66d3bf-77cf-4e5a-a7a8-6702ebdc0778"
_Ube.Name = _xcL("zi\020<=`nb&R\n`Q")
_Ube.Description = ""
_Ube.Visible = true
_Ube.Active = false
_Ube.Complete = false
_Ube.CorrectState = "None"
_GIhl = false
_0NcV = false
_kEjQ = false
_eohTA = ""
_GoeB = ""
_H1H1 = ""
_xhZw = false
_9bXr = 0
_zLo = false
_ghgX = false
_6NtP = false
_audU0 = false
_XG6m = false
_wvtHg = false
_vCk = false
_7aC = false
_GAck = false
_SdDiw = false
_6rY = false
_D5QbZ = false
_WXqqT = false
_3FA = false
_tMz = ""
_bVv0 = false
_U5n9 = false
_m6HM = false
_wp_NK = false
_OX5nA = false
_9Ss = false
_s3wZT = false
_SHf2 = false
_Z3dY = _xcL("p[nDB")
_pYeZu = _xcL("e&??^")
_1Sx9C = _xcL("p\020(?\127I")
_fH8FQ = _xcL("pQzij")
_5dlY = _xcL("pg\0285\127)")
_Z72 = _xcL("e&??^")
_DSDk.ZVariables = {
  _GIhl = false,
  _0NcV = false,
  _kEjQ = false,
  _eohTA = "",
  _GoeB = "",
  _H1H1 = "",
  _xhZw = false,
  _9bXr = 0,
  _zLo = false,
  _ghgX = false,
  _6NtP = false,
  _audU0 = false,
  _XG6m = false,
  _wvtHg = false,
  _vCk = false,
  _7aC = false,
  _GAck = false,
  _SdDiw = false,
  _6rY = false,
  _D5QbZ = false,
  _WXqqT = false,
  _3FA = false,
  _tMz = "",
  _bVv0 = false,
  _U5n9 = false,
  _m6HM = false,
  _wp_NK = false,
  _OX5nA = false,
  _9Ss = false,
  _s3wZT = false,
  _SHf2 = false,
  _Z3dY = _xcL("p[nDB"),
  _pYeZu = _xcL("e&??^"),
  _1Sx9C = _xcL("p\020(?\127I"),
  _fH8FQ = _xcL("pQzij"),
  _5dlY = _xcL("pg\0285\127)"),
  _Z72 = _xcL("e&??^")
}
_YIDHU = Wherigo.ZInput(_DSDk)
_YIDHU.Id = "59980779-c4ad-4409-bf9b-3c72b40607b2"
_YIDHU.Name = _xcL("nb&R\n\020\bC&!a<4=")
_YIDHU.Description = ""
_YIDHU.Visible = true
_YIDHU.Choices = {
  "Stufe 1",
  "Stufe 2",
  "Stufe 3",
  "Stufe 1 und 2",
  "Stufe 2 und 3",
  "Stufe 1, 2 und 3"
}
_YIDHU.InputType = "MultipleChoice"
_YIDHU.Text = _xcL("\014\020b!V4\nie\n`eiV4`H\nbyb8")
_P8jN = Wherigo.ZInput(_DSDk)
_P8jN.Id = "de5a6e40-651e-4f36-9547-630c965f5d2c"
_P8jN.Name = _xcL("C!\n=\b5\n\020\004?<=")
_P8jN.Description = ""
_P8jN.Visible = true
_P8jN.Choices = {
  "1314",
  "1317",
  "1514",
  "1517",
  "1914",
  "1917"
}
_P8jN.InputType = "MultipleChoice"
_P8jN.Text = _xcL("9<\020\020`a&\\e\n`C!\n=`=<&b`5\n\020\004?<=`U\nU\\&\n\020e\nb;")
_FucO = Wherigo.ZInput(_DSDk)
_FucO.Id = "efe0238f-ad23-4db8-9645-fc10d6d66b1e"
_FucO.Name = _xcL("nV4i=e`<?`j<&?")
_FucO.Description = ""
_FucO.Visible = true
_FucO.InputType = "Text"
_FucO.Text = _xcL("C&R`ei\n!\n?`\004=\ni\020\n\020_`wibb\029\\\n!\004\n\020`z\\i\ne4\029R`!b\n4b`<&V4`\ni\020`[\n!\029\020e\n\\\n\\`j<&?`?ib`\ni\020\n?`nV4i=e.tjO-9\nV4\n!`9\029\\b`!b\n4b`<&R`ei\n!\n?`nV4i=e;")
_Vg7C = Wherigo.ZInput(_DSDk)
_Vg7C.Id = "158751ba-6c05-4231-ade6-711303ca21e1"
_Vg7C.Name = _xcL("\017\029e\n==`\017\n!!&\020U")
_Vg7C.Description = ""
_Vg7C.Visible = true
_Vg7C.InputType = "Text"
_Vg7C.Text = _xcL("j\\\nib\n`i\020`r\n\020bi?\nb\n\\\020`7\0294\020\n`{<V4\004\029??<!b\n==\n\020A;")
_6djr = Wherigo.ZInput(_DSDk)
_6djr.Id = "1465ac30-8afd-4f49-8092-8a286ef3c391"
_6djr.Name = _xcL("\017\029e\n==`\v\028{")
_6djr.Description = ""
_6djr.Visible = true
_6djr.InputType = "Text"
_6djr.Text = _xcL("9i\n`=<&b\nb`ei\n`!\nV4!!b\n==iU\n`r<4=`<&R`e\n\\`\017\nb<==w=<\004\nbb\n;")
_VKB = Wherigo.ZInput(_DSDk)
_VKB.Id = "deaf8639-ffd4-4c7e-9bef-ec56daf89e83"
_VKB.Name = _xcL("z&bb\n\\b\\\029U")
_VKB.Description = ""
_VKB.Visible = true
_VKB.InputType = "Text"
_VKB.Text = _xcL("9\n=V4\n`B<\n\020U\n`7i\020`r\n\020bi?\nb\n\\\020A`4<b`e\n\\`?ibb=\n\\\n`\019\\\029U;")
_rr3Cf = Wherigo.ZInput(_DSDk)
_rr3Cf.Id = "69e450e8-807a-4c9e-8f46-99e0e379a210"
_rr3Cf.Name = _xcL("m4\029\\")
_rr3Cf.Description = ""
_rr3Cf.Visible = true
_rr3Cf.Choices = {
  "Welche Tafel?",
  "Edersee-Atlantis-Chor",
  "Edersee-Frauen-Chor",
  "Edersee-Maenner-Chor",
  "Edersee-Shanty-Chor",
  "Edersee-Gospel-Chor"
}
_rr3Cf.InputType = "MultipleChoice"
_rr3Cf.Text = _xcL("9\n=V4\n\\`m4\029\\`i!b`<&R`e\n\\`\019<R\n=`e\n!`9\0294\0204<&!\n!`e\n\\`z<?i=i\n`\127\ni\020\\iV4`L\020&\nww\n=`\n\\a<\n4\020b;")
_IcLw = Wherigo.ZInput(_DSDk)
_IcLw.Id = "eef65ecc-f691-46cf-856d-49123f38a170"
_IcLw.Name = _xcL("5\n\020\004?<=`j\n\\iV4")
_IcLw.Description = ""
_IcLw.Visible = true
_IcLw.Choices = {
  "1114",
  "1196",
  "1213",
  "1259",
  "1914"
}
_IcLw.InputType = "MultipleChoice"
_IcLw.Text = _xcL("9<\020\020`a&\\e\n`e<!`5\029\\R`j\n\\iV4`U\nU\\&\n\020e\nb;")
_LX3m = Wherigo.ZInput(_DSDk)
_LX3m.Id = "391db866-562b-47ed-8b24-d29ee914b762"
_LX3m.Name = _xcL("z\\i\ne4\029R`j\n\\iV4")
_LX3m.Description = ""
_LX3m.Visible = true
_LX3m.InputType = "Text"
_LX3m.Text = _xcL("9i\n`>i\n=\n`3\\<\n[\n\\`\004\029\n\020\020b\n\020`!iV4`?<Ni?<=`i\020\020\n\\4<=[`e\n\\`\014i\020R<!!&\020U`[\nRi\020e\n\020;")
_KaI = Wherigo.ZInput(_DSDk)
_KaI.Id = "4a04c1b5-9600-406b-98a0-bcada0ba7739"
_KaI.Name = _xcL([[
L
bb
]])
_KaI.Description = ""
_KaI.Visible = true
_KaI.InputType = "Text"
_KaI.Text = _xcL("C\020y<4=`e\n\\`L\nbb\n\020U=i\ne\n\\_`?ib`e\n\\`ei\n`j\029H\n`[\nR\n!biUb`i!b;")
_oRNb = Wherigo.ZInput(_DSDk)
_oRNb.Id = "f9fbac98-0ba4-4dfc-a7d9-02117afbedbc"
_oRNb.Name = _xcL("{iV\029=\n")
_oRNb.Description = ""
_oRNb.Visible = true
_oRNb.InputType = "Text"
_oRNb.Text = _xcL("z<[i\029_`\028\020U\029`&\020e`a\n\\`\020\029V4;tjO-tjO-\006\127i=R\n\006`\ni\020U\n[\n\020_`a\n\020\020`e&`\020iV4b!`Ri\020e\n!b|")
_ZiQPR = Wherigo.ZInput(_DSDk)
_ZiQPR.Id = "89d02c83-f88f-4f43-a5ae-5d633fed6f81"
_ZiQPR.Name = _xcL("\v\\\n==[\029V\004")
_ZiQPR.Description = ""
_ZiQPR.Visible = true
_ZiQPR.InputType = "Text"
_ZiQPR.Text = _xcL("9i\n`[\\\nib`i!b`e\n\\`\v\\\n==[\029V\004`i\020`r\n\020bi?\nb\n\\\020;")
_eFvwm = Wherigo.ZInput(_DSDk)
_eFvwm.Id = "85fb7039-31b8-45df-9a51-9bd27ef970e1"
_eFvwm.Name = _xcL([[
O
4[<V4`nV4i=e]])
_eFvwm.Description = ""
_eFvwm.Visible = true
_eFvwm.InputType = "Text"
_eFvwm.Text = _xcL("9i\n`>i\n=\n`r\n\020bi?\nb\n\\`!\029==\n\020`H\na\ni=!`=i\020\004!`&\020e`\\\nV4b!`e\n\\`nV4i\n\020\n\020`R\\\ni`U\n4<=b\n\020`a\n\\e\n\020;")
_48h5 = Wherigo.ZInput(_DSDk)
_48h5.Id = "81c024ac-8ee4-4a74-b138-00e776b547c3"
_48h5.Name = _xcL("z\\i\n4\029R`C=b\bj\\i\020U4<&!\n\020")
_48h5.Description = ""
_48h5.Visible = true
_48h5.InputType = "Text"
_48h5.Text = _xcL("9\n=V4\n`{&??\n\\`4<b`e<!`3\\<[_`<&R`a\n=V4\n!`e\n\\`\vR\ni=`i?`\n[\n\020`U\ny\niUb\n\020`ji=e`e\n&b\nb\n.")
function _DSDk:OnStart()
  if _G[_xcL("\014\020>")][_xcL("5\n>iV\n\0285")] == _xcL("5\n!\004b\029w") or _G[_xcL("\014\020>")][_xcL("\v=<bR\029\\?")] == _xcL("9i\020Q(") then
    for k, v in pairs(_G[_xcL("p5n5\004")][_xcL([[
C==rD[H
Vb!]])]) do
      v[_xcL("6i!i[=\n")] = false
      v[_xcL("CVbi>\n")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_xcL("5<`?<\020`yai!V4\n\020e&\\V4`\ni\020`w<<\\`z\\<U\n\020`[\n<\020ba\029\\b\n\020`?&!!_`\004\029??b`?<\020`i?`ni?&=<b\029\\`\n4`\020iV4b`!\029\020e\n\\=iV4`a\nib.")),
      Callback = function(action)
        if action ~= nil then
          _G[_xcL("94\n\\iU\029")][_xcL("m\029??<\020e")](_xcL("n<>\nm=\029!\n"))
        end
      end
    })
    return
  end
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("\127<==\029`") .. Player.Name
    }
  }, function(action)
    _Urwigo.MessageBox({
      Text = _xcL("r&\n\\!b`[\n\004\029??!b`e&`H\nbyb`\ni\020`a\n\020iU`<==U\n?\ni\020\n`\028\020R\029!`y&`ei\n!\n\\`m<\\b\\ieU\n`&\020e`e<\020<V4`U\n4b`\n!`a\nib\n\\`y&\\`nb&R\n\020\bC&!a<4=."),
      Buttons = {
        _xcL("\028\020R\029!|"),
        _xcL("L\ni\020\n`\028\020R\029!|")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _GKa9i()
          else
            _8lK()
          end
        end
      end
    })
  end)
end
function _DSDk:OnRestore()
end
function _bSOL:OnEnter()
  _Z3dY = _xcL("p[nDB")
  _Urwigo.GlobalZoneEnter()
  _bSOL.Active = false
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_P8jN)
  end)
end
function _zSv:OnEnter()
  _Z3dY = _xcL("pyn>")
  _Urwigo.GlobalZoneEnter()
end
function _OcyF:OnEnter()
  _Z3dY = _xcL("pDV^z")
  _Urwigo.GlobalZoneEnter()
end
function _syX:OnEnter()
  _Z3dY = _xcL("p!^0")
  _Urwigo.GlobalZoneEnter()
  _syX.Active = false
  if _m6HM == false then
    _m6HM = true
    _I_PH.Active = false
    _Rxj.Active = false
    _SKs.Active = false
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_FucO)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_FucO)
    end)
  end
end
function _35_a:OnEnter()
  _Z3dY = _xcL("pQ2p<")
  _Urwigo.GlobalZoneEnter()
  if _wp_NK == false then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5i\n!\n`j\\&\nV\004\n`a&\\e\n`v\027\027\016`[i!`v\027G+`\n\\[<&b.tjO-j\n>\029\\`!i\n`\020&\\`a\n\020iU\n`o<4\\\n`!w<\nb\n\\`i\020`e\n\020`z=&b\n\020`>\n\\!<\020\004_`a&\\e\n\020`<&!`niV4\n\\4\nib!U\\&\n\020e\n\020`ei\n`[\nie\n\020`3\n=<\n\020e\n\\`<[U\n\\i!!\n\020.")
      },
      {
        Text = _xcL("C\020!\029\020!b\n\020`i!b`!i\n`H\ne\029V4`\020\029V4`i??\n\\`>\029==`R&\020\004bi\029\020!R<\n4iU.tjO-5<?ib`ei\n!`<&V4`!\029`[=\ni[b_`a&\\e\n`!i\n`vG\027(`&\020e`vG\027G`\\\n!b<&\\i\n\\b`&\020e`!b\n4b`<&!!\n\\e\n?`&\020b\n\\`5\n\020\004?<=!V4&by.")
      },
      {
        Text = _xcL("n\029_`H\nbyb`<[\n\\`\020\029V4`!V4\020\n==`<&R`ei\n`<\020e\n\\\n`n\nib\n|tjO-")
      }
    }, function(action)
      _35_a.Active = false
      __Ar.Active = true
    end)
    _wp_NK = true
  end
end
function __Ar:OnEnter()
  _Z3dY = _xcL("ppC\\")
  _Urwigo.GlobalZoneEnter()
  if _OX5nA == false then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL(")\020e;")
      },
      {
        Text = _xcL("9<\\`e\029V4`V\029\029=_`\ni\020\n`j\\&\nV\004\n`y&`&\n[\n\\I&\n\\\n\020_`ei\n`ei\n`?\ni!b\n`r\nib`i\020`e\n\020`=\nbyb\n\020`v++`o<4\\\n\020`i?`9<!!\n\\`>\n\\!&\020\004\n\020`a<\\_`\029e\n\\;")
      },
      {
        Text = _xcL("5i\n`\n\\!b\n`C&RU<[\n`4<!b`e&`!\029?ib`\n\\R\029=U\\\niV4`U\n?\ni!b\n\\b`&\020e`e&`\004<\020\020!b`e&`\020<\nV4!b\n`<\004bi>i\n\\\n\020.")
      },
      {
        Text = _xcL("9<\\\n\020`ei\\`<&R`e\n?`9\nU`4i\n\\4\n\\`\niU\n\020b=iV4`\020\029V4`O&i\020\n\020`>\029\020`C=b\bC!\n=`<&RU\nR<==\n\020;")
      },
      {
        Text = _xcL("j\ni`?\ni\020\n\\`\v=<\020&\020U`!i\020e`?i\\`!\029=V4\n`\020<\n?=iV4`\n\020bU<\020U\n\020_`<[\n\\`!w<\nb\n\\`[\ni?`nV4\\\ni[\n\020`e\n\\`m<\\b\\ieU\n`[i\020`iV4`a<\n4\\\n\020e`?\ni\020\n\\`O\nV4\n\\V4\n`H\ne\029V4`<&R`L\029\029\\ei\020<b\n\020`U\n!b\029!!\n\020_`[\ni`e\n\020\n\020`?<\020`<\020U\n[=iV4`\020\029V4`\nba<!`!\n4\n\020`\004<\020\020.")
      },
      {
        Text = _xcL("\028V4`4<[\n`ei\n`\n\020b!w\\\nV4\n\020e\n\020`r\029\020\n\020`H\nbyb`?<=`<\004bi>i\n\\b.tjO-5&`\004<\020\020!b`ei\n!\n`r\029\020\n\020`<&R!&V4\n\020`&\020e`?<=`!V4<&\n\020_`\029[`e&`\020\029V4`\nba<!`\n\\\004\n\020\020\n\020`\004<\020\020!b.tjO-\028!b`<[\n\\`R\\\niai==iU`&\020e`\n!`a\n\\e\n\020`[\ni?`j\nb\\\nb\n\020`e\n\\`r\029\020\n\020`<&V4`\004\ni\020\n`C\004bi\029\020\n\020`<&!U\n=\029\n!b.")
      }
    }, function(action)
      __Ar.Active = false
      _bSOL.Active = false
      _zSv.Active = false
      _OcyF.Active = false
      _3FiB.Active = false
      _xwq.Active = true
      _I_PH.Active = true
      _Rxj.Active = true
      _SKs.Active = true
      _ceLKO()
    end)
    _OX5nA = true
  end
end
function _aCJ:OnEnter()
  _Z3dY = _xcL("p<mo")
  _Urwigo.GlobalZoneEnter()
  _aCJ.Active = false
  if _s3wZT == false then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("`\028?`6\029\\R\n=e`e\n!`nw\n\\\\?<&\n\\[<&!`a&\\e\n`y&`\019\n!bya\nV\004\n\020`\ni\020`\017\029e\n==`e\n\\`!w<\nb\n\\\n\020`\019<=!w\n\\\\\n`\n\\\\iV4b\nb.")
      },
      {
        Text = _xcL("\028\020b\n\\\n!!<\020b\n\\a\ni!\n`Ri\020e\nb`?<\020`i?`{\nby`!\029a\0294=`C\020U<[\n\020_`e<!!`e<!`\017\029e\n==`e\n\020`\017<!!!b<[`v8(2`<=!`<&V4`v8\023+`4<[\n\020`!\029==.")
      },
      {
        Text = _xcL("5<`ei\n`\nV4b\n`nb<&?<&\n\\`\ni\020\n`\127\029\n4\n`>\029\020`\nba<`\023\027`?`<&Ra\ni!b_`i!b`=\niV4b`\n\\!iV4b=iV4_`e<!!`e\n\\`\017<!!!b<[`a\0294=`\n4\n\\`v8\023+`!\ni\020`?&!!`7R<!b`(`?`4\029V4`i!b`e<!`\017\029e\n==`\020<\n?=iV4`\020iV4bA`&\020e`9i\004iw\nei<`!\029?ib`\020iV4b`i??\n\\`O\nV4b`4<b.")
      },
      {
        Text = _xcL("5<!`\017\029e\n==`b<&V4b`\020&\\`<==\n`w<<\\`o<4\\\n`<&!`e\n\020`z=&b\n\020`<&R.tjO-r&=\nbyb`i\020`e\n\020`o<4\\\n\020`vGG+_`(++Q_`(+vv_`(+v\002`&\020e`(+v\027`7nb<\020e`(+v\027A.")
      },
      {
        Text = _xcL("C&R`ei\n!\n?`z\029b\029`!i\n4b`?<\020_`ai\n`e<!`\017\029e\n==`<&!!i\n4b_`a\n\020\020`\n!`>\029==\004\029??\n\020`b\\\029V\004\n\020`U\nR<==\n\020`i!b`&\020e`>\029?`nV4=<??`[\nR\\\nib`a&\\e\n."),
        Media = _iuelY
      },
      {
        Text = _xcL("\028V4`4<[\n`ei\n!\n\020`94\n\\iU\029`\020iV4b`U\n!V4\\i\n[\n\020_`e<?ib`?<\020`ei\n`\n\020b!w\\\nV4\n\020e\n\020`r\029\020\n\020`>i\n==\niV4b`[\ni`4\0294\n?`\v\nU\n=!b<\020e`\ni\020R<V4`w\n\\`j\029\029b`\029e\n\\`!V4ai??\n\020e`<&R!&V4b`7\029[a\0294=`e<!`<[`e\n\\`m<\\b\\ieU\n\b6\n\\!i\029\020`v.G`a\0294=`b4\n\029\\\nbi!V4`?\029\nU=iV4`i!bA.tjO-6i\n=?\n4\\`ai==`iV4`\n&V4`[\n!\029\020e\n\\\n`D\\b\n`y\niU\n\020_`ei\n`\020\029\\?<=\n\\a\ni!\n`&\020b\n\\`9<!!\n\\`=i\nU\n\020.")
      },
      {
        Text = _xcL("5<4\n\\`a<\\b\nb`H\nbyb`\020\029V4`\ni\020\n`\004=\ni\020\n_`\ni\020R<V4\n`C&RU<[\n`<&R`eiV4.")
      },
      {
        Text = _xcL("\014ba<!`y&?`\017\n!!\n\020`4<!b`e&`H<`4\029RR\n\020b=iV4`e<[\ni.tjO-C\020!\029\020!b\n\020`w\\\029[i\n\\\n`\n!`?ib`nV4<\nby\n\020.")
      },
      {
        Text = _xcL("\127i\n\\`\ni\020`ji=e_`e<?ib`e&`a\ni!!b_`a<!`e&`?\n!!\n\020`!\029==!b`7!V4<&`U\n\020<&_`\020iV4b`e<!`\\&\020e\n`B\029V4A."),
        Media = _mAok
      }
    }, function(action)
      _s3wZT = true
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_Vg7C)
      end)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_Vg7C)
    end)
  end
end
function _pQR:OnEnter()
  _Z3dY = _xcL("pw\aO")
  _Urwigo.GlobalZoneEnter()
  _pQR.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("v\01622`a&\\e\n`4i\n\\`<\020`ei\n!\n\\`nb\n==\n`\ni\020`\127&\nbb\n\020a\n\\\004`\n\\[<&b`&\020e`e\n\\`9\n\\[\n[<V4`&?U\n=\nib\nb_`&?`\ni\020`\127<??\n\\a\n\\\004`<\020y&b\\\ni[\n\020_`i\020`e\n?`\014i!\n\020`>\n\\4&\nbb\nb`a&\\e\n.")
    },
    {
      Text = _xcL("5i\n`\014i!\n\020\n\\y>\n\\4&\nbb&\020U`a&\\e\n`v\027\0162`\ni\020U\n!b\n==b.tjO-5<\020<V4`>\n\\Ri\n=`e<!`9\n\\\004_`ai\n`?<\020`<&R`ei\n!\n?`ji=e`>\029\020`vGv(`\n\\\004\n\020\020\n\020`\004<\020\020.`"),
      Media = _cNS2C
    },
    {
      Text = _xcL("\028?`\n4\n?<=iU\n\020`9\0294\0204<&!`a&\\e\n`!\nib`e\n\\`nbi===\nU&\020U`\ni\020\n`3<!bai\\b!V4<Rb`[\nb\\i\n[\n\020_`ei\n`C\020R<\020U`e\n!`(+.`o<4\\4&\020e\n\\b!`\ni\020`[\n=i\n[b\n\\`\019\\\nRRw&\020\004b`R&\n\\`H&\020U\n`B\n&b\n`<&!`e\n\\`O\nUi\029\020`a<\\.tjO-")
    },
    {
      Text = _xcL(")\020e`4i\n\\`\ni\020`z\029b\029`e\n\\`O&i\020\n`<&!`e\n?`o<4\\\n`vG2Q_`a\029`!\n=[iU\n`\020\029V4`\ni\020`\004=\ni\020`a\n\020iU`[\n!!\n\\`\n\\4<=b\n\020`i!b`<=!`e\n\\y\nib`7<[\n\\`<==y&`U\\\029!!`i!b`e\n\\`)\020b\n\\!V4i\ne`\020iV4bA."),
      Media = _cpK
    },
    {
      Text = _xcL("9\n!b=iV4`e\n\\`O&i\020\n`\004<\020\020`?<\020`&\n[\\iU\n\020!`<&V4`\020\029V4`O\n!b\n`\ni\020\n\\`U\nwR=<!b\n\\b\n\020`nb\\<!!\n`\n\\\004\n\020\020\n\020.")
    },
    {
      Text = _xcL(")\020e`H\nbyb`U\n4b`\n!`a\nib\n\\`y&?`nw\n\\\\?<&\n\\?\029e\n==.tjO-\028V4`4\029RR\n_`e&`\004<\020\020!b`ei\n`r\029\020\n`w\\\029[=\n?=\029!`\n\\\\\niV4\n\020.")
    }
  }, function(action)
    _pQR.Active = false
    _aCJ.Active = true
  end)
end
function _Kkc:OnEnter()
  _Z3dY = _xcL("pL\004V")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("\127i\n\\`H\nbyb`ei\n`nb\\<!!\n`>\n\\=<!!\n\020`&\020e`\\&\020b\n\\`y&\\`j\n\\iV4\n\\`\127&\nbb\n."),
      Media = _u3tUg
    }
  }, function(action)
    _Kkc.Active = false
    _2q3.Active = false
    _pQR.Active = true
  end)
end
function _4TV:OnEnter()
  _Z3dY = _xcL("p\023\0196")
  _Urwigo.GlobalZoneEnter()
end
function _41Gfk:OnEnter()
  _Z3dY = _xcL("p\023v3R\004")
  _Urwigo.GlobalZoneEnter()
end
function _rbnc:OnEnter()
  _Z3dY = _xcL("p\\[\020V")
  _Urwigo.GlobalZoneEnter()
  _rbnc.Active = false
  _WXqqT = true
  _Urwigo.MessageBox({
    Text = _xcL("5i\n`r\029\020\n`4<!b`e&`!V4\029\020`?<=`\n\\\\\niV4b.tjO-B\nie\n\\`i!b`a\0294=`ei\n`\017\nb<==w=<\004\nbb\n`?ib`e\n\\`!\nV4!!b\n==iU\n\020`r<4=_`ei\n`e&`4i\n\\`4<\nbb\n!b`Ri\020e\n\020`!\029==\n\020_`\n\\\020\n&b`>\n\\!V4a&\020e\n\020."),
    Callback = function(action)
      if action ~= nil then
        if _3FA == false then
          _Urwigo.MessageBox({
            Text = _xcL("r&?`3=&\nV\004`4<!b`e&`\020\029V4`\ni\020`ya\nib\n`m4<\020V\n_`a\029`<\020e\n\\!`\ni\020\n`\v=<\004\nbb\n`y&`Ri\020e\n\020."),
            Callback = function(action)
              if action ~= nil then
                _NaBOl.Active = true
                _rbnc.Active = false
              end
            end
          })
        else
          _Urwigo.Dialog(false, {
            {
              Text = _xcL("j\ni?`j<&?!b&?wR`4<!b`e&`=\nie\n\\`\020iV4b!`U\nR&\020e\n\020.")
            },
            {
              Text = _xcL([[
5<!`i!b`!V4=
V4b.]])
            },
            {
              Text = _xcL("z<==!`\n!`\020&\\`<\020`\ni\020\n?`y&`4\0294\n?`\v\nU\n=`U\n=\nU\n\020`4<b_`e<\020\020`?&!!b`e&`H\nbyb`a\0294=`=\nie\n\\`<[[\\\nV4\n\020`7[ya.`U\nU\n[\n\020\n\020R<==!`?ib`nb&R\n`v`&\020e`(`a\nib\n\\`?<V4\n\020A.")
            },
            {
              Text = _xcL("z<==!`e&`H\ne\029V4`e<>\029\020`&\n[\n\\y\n&Ub`[i!b_`e<!!`\n!`\020iV4b`<?`9<!!\n\\!b<\020e`=<U`&\020e`ei\n`[\nie\n\020`\v=<\004\nbb\n\020`<?`j<&?!b<??`U\n?&UU\n=b`a&\\e\n\020`7\004<\020\020`iV4`?i\\`\004<&?`>\029\\!b\n==\n\020_`<[\n\\`?<\020`a\ni!!`H<`\020i\nA_`e<\020\020`[i\nb\n`iV4`ei\\`<=!`=\nbyb\n`\017\029\nU=iV4\004\nib`<\020_`?i\\`<[!\029=&b`\ni\020e\n&biU\n`j\na\ni!R\029b\029!_`<&R`e\n\020\n\020`e<!`z\n4=\n\020`e\n\\`\v=<\004\nbb\n\020`y&`\n\\\004\n\020\020\n\020`i!b_`>\029\\y&U!a\ni!\n`w\n\\`94<b!Cww`\029e\n\\`\020\029bR<==!`w\n\\`\017<i=`y&`!V4iV\004\n\020.")
            },
            {
              Text = _xcL(")\020e`R<==!`e&`?iV4`?ib`e\n\020`z\029b\029!`>\029\020`e\n?`z\n4=\n\020`e\n\\`\v=<\004\nbb\n\020`&\n[\n\\y\n&U\n\020`\004\029\020\020b\n!b_`e<\020\020`a\n\\e\n`iV4`>\n\\!&V4\n\020_`ei\\`?\029\nU=iV4!b`y\nib\020<4`ei\n`!\nV4!!b\n==iU\n`r<4=`?iby&b\ni=\n\020`7!\029R\n\\\020`iV4`?iV4`\020iV4b`U\n\\<e\n`i\020`\ni\020\n?`z&\020\004=\029V4`<&R4<=b\n`\029e\n\\`?\029?\n\020b<\020`<[!\029=&b`\004\ni\020\n`r\nib`4<[\nA.tjO-C&R`\ni\020\n`94<b!Cww\b{<V4\\iV4b`a&\n\\e\n`iV4`>\n\\?&b=iV4`!V4\020\n==\n\\`\\\n<Ui\n\\\n\020`<=!`<&R`\ni\020\n`\017<i=.")
            },
            {
              Text = _xcL("5i\n!\n\020`j<&?!b&?wR`!\029==b\n!b`e&`R&\n\\`?iV4`R\029b\029U\\<Ri\n\\\n\020|"),
              Media = _ES1lQ
            },
            {
              Text = _xcL(")\020e`e<\020\020`<\020`?iV4`!V4iV\004\n\0208tjO-94<b!Cww8`+v2(Q\0232Q\027((+tjO-\017<i=8`B\nwie\029wb\n\\iN:\029\020=i\020\n4\029?\n.e\n")
            }
          }, function(action)
            _aCJ.Active = true
          end)
        end
      end
    end
  })
end
function _rbnc:OnProximity()
  _Z3dY = _xcL("p\\[\020V")
  Wherigo.PlayAudio(_2xbNn)
  _Urwigo.MessageBox({
    Text = _xcL("\127i\n\\`?<=`\ni\020`z\029b\029`y&\\`D\\i\n\020bi\n\\&\020U_`a\029`e&`U=\niV4`\ni\020\n`\017\nb<==w=<\004\nbb\n`?ib`\ni\020\n\\`!\nV4!!b\n==iU\n\020`r<4=`Ri\020e\n\020`!\029==b\n!b."),
    Media = _8GQO
  })
end
function _NaBOl:OnEnter()
  _Z3dY = _xcL("p{<jD=")
  _Urwigo.GlobalZoneEnter()
  _NaBOl.Active = false
  _3FA = true
  _Urwigo.MessageBox({
    Text = _xcL("5i\n`r\029\020\n`4<!b`e&`!V4\029\020`?<=`\n\\\\\niV4b.tjO-)\020e`4<!b`e&`<&V4`ei\n`!\nV4!!b\n==iU\n`r<4=`<&R`\ni\020\n\\`e\n\\`\017\nb<==w=<\004\nbb\n\020`\n\020be\nV\004b`&\020e`\004<\020\020!b`!i\n`\ni\020iU\n\\?<!!\n\020`\n\020byiRR\n\\\020;"),
    Buttons = {
      _xcL("3\nR&\020e\n\020"),
      _xcL("j\\<&V4\n`\127i=R\n")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" == true then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_6djr)
          end)
        else
          _Urwigo.MessageBox({
            Text = _xcL("\127i\n\\`\020\029V4`?<=`\ni\020`ji=e`e\n!`&\\<=b\n\020`j<&?!b&?wR\n!_`<\020`e\n?`e&`ei\n`\v=<\004\nbb\n\020`Ri\020e\n\020`\004<\020\020!b."),
            Media = _cdjry,
            Callback = function(action)
              if action ~= nil then
                _Urwigo.MessageBox({
                  Text = _xcL("\127i\n\\`!\029==b\n`\ni\020\n`\v=<\004\nbb\n`?ib`\ni\020\n?`5\\<4b!\ni=`R\n!bU\n[&\020e\n\020`!\ni\020.`5i\n`<\020e\n\\\n`!\029==b\n`ei\\\n\004b`<?`nb&?wR`R\n!bU\n!V4\\<&[b`!\ni\020."),
                  Media = _ES1lQ,
                  Buttons = {
                    _xcL("o\nbyb`U\nR&\020e\n\020"),
                    _xcL("{\029V4`?\n4\\`\127i=R\n")
                  },
                  Callback = function(action)
                    if action ~= nil then
                      if action == "Button1" == true then
                        _Urwigo.RunDialogs(function()
                          Wherigo.GetInput(_6djr)
                        end)
                      else
                        _Urwigo.Dialog(false, {
                          {
                            Text = _xcL("\014\020ba\ne\n\\`[i!b`e&`\ni\020R<V4`\020&\\`y&`e\029\029R.")
                          },
                          {
                            Text = _xcL("De\n\\`ei\n`\v=<\004\nbb\n\020`!i\020e`>\n\\!V4a&\020e\n\020.")
                          },
                          {
                            Text = _xcL("6i\n==\niV4b`i!b`<&V4`e\n\\`9<!!\n\\!b<\020e`\020\029V4`y&`4\029V4.")
                          }
                        }, function(action)
                          if _WXqqT == false then
                            _Urwigo.MessageBox({
                              Text = _xcL("r&?`3=&\nV\004`4<!b`e&`\020\029V4`\ni\020`ya\nib\n`m4<\020V\n_`a\029`<\020e\n\\!`\ni\020\n`\v=<\004\nbb\n`y&`Ri\020e\n\020."),
                              Callback = function(action)
                                if action ~= nil then
                                  _NaBOl.Active = false
                                  _rbnc.Active = true
                                end
                              end
                            })
                          else
                            _Urwigo.Dialog(false, {
                              {
                                Text = _xcL("j\ni`e\n\020`nb\ni\020\n\020`4<!b`e&`H<`<&V4`!V4\029\020`\020iV4b!`U\nR&\020e\n\020.")
                              },
                              {
                                Text = _xcL([[
5<!`i!b`!V4=
V4b.]])
                              },
                              {
                                Text = _xcL("z<==!`\n!`\020&\\`<\020`\ni\020\n?`y&`4\0294\n?`\v\nU\n=`U\n=\nU\n\020`4<b_`e<\020\020`?&!!b`e&`H\nbyb`a\0294=`=\nie\n\\`<[[\\\nV4\n\020`7[ya.`U\nU\n[\n\020\n\020R<==!`?ib`nb&R\n`v`&\020e`(`a\nib\n\\`?<V4\n\020A.")
                              },
                              {
                                Text = _xcL("z<==!`e&`H\ne\029V4`e<>\029\020`&\n[\n\\y\n&Ub`[i!b_`e<!!`\n!`\020iV4b`<?`9<!!\n\\!b<\020e`=<U`&\020e`ei\n`[\nie\n\020`\v=<\004\nbb\n\020`U\n?&UU\n=b`a&\\e\n\020`7\004<\020\020`iV4`?i\\`\004<&?`>\029\\!b\n==\n\020_`<[\n\\`?<\020`a\ni!!`H<`\020i\nA_`e<\020\020`[i\nb\n`iV4`ei\\`<=!`=\nbyb\n`\017\029\nU=iV4\004\nib`<\020_`?i\\`<[!\029=&b`\ni\020e\n&biU\n`j\na\ni!R\029b\029!_`<&R`e\n\020\n\020`e<!`z\n4=\n\020`e\n\\`\v=<\004\nbb\n\020`y&`\n\\\004\n\020\020\n\020`i!b_`>\029\\y&U!a\ni!\n`w\n\\`94<b!Cww`\029e\n\\`\020\029bR<==!`w\n\\`\017<i=`y&`!V4iV\004\n\020.")
                              },
                              {
                                Text = _xcL(")\020e`R<==!`e&`?iV4`?ib`e\n\020`z\029b\029!`>\029\020`e\n?`z\n4=\n\020`e\n\\`\v=<\004\nbb\n\020`&\n[\n\\y\n&U\n\020`\004\029\020\020b\n!b_`e<\020\020`a\n\\e\n`iV4`>\n\\!&V4\n\020_`ei\\`?\029\nU=iV4!b`y\nib\020<4`ei\n`!\nV4!!b\n==iU\n`r<4=`?iby&b\ni=\n\020`7!\029R\n\\\020`iV4`?iV4`\020iV4b`U\n\\<e\n`i\020`\ni\020\n?`z&\020\004=\029V4`<&R4<=b\n`\029e\n\\`?\029\020\n\020b<\020`<[!\029=&b`\004\ni\020\n`r\nib`4<[\nA.tjO-C&R`\ni\020\n`94<b!Cww\b{<V4\\iV4b`a&\n\\e\n`iV4`>\n\\?&b=iV4`!V4\020\n==\n\\`\\\n<Ui\n\\\n\020`<=!`<&R`\ni\020\n`\017<i=.")
                              },
                              {
                                Text = _xcL("j\ni`<\020e\n\\\n\020`3\\&\n\020e\n\020`7y.`j.`y&`4\0294\n\\`\v\nU\n=_`y&`eiV\004\n`\014i!!V4iV4bA`a<\\`iV4`[i!4\n\\`i??\n\\`4<\\b4\n\\yiU`&\020e`4<[\n`ei\n`r<4=`\020iV4b`\\<&!U\n\\&\nV\004b.tjO-\017iV4`<=!\029`[ibb\n`\020&\\`\004\029\020b<\004bi\n\\\n\020_`a\n\020\020`\v=<\004\nbb\n\020`ai\\\004=iV4`\ni\020e\n&biU`U\n?&UU\n=b`a&\\e\n\020_`e<?ib`iV4`?i\\`\020iV4b`i??\n\\`!\029`Ri\n!`>\029\\\004\029??\n_`a\n\020\020`iV4`[\ni`<\020e\n\\\n\020`3\\&\n\020e\n\020`\020iV4b`a\nib\n\\4\n=R\n.")
                              },
                              {
                                Text = _xcL("\017<V4\n`[ibb\n`\ni\020`z\029b\029`>\029\020`ei\n!\n?`j<&?!b&?wR."),
                                Media = _ES1lQ
                              },
                              {
                                Text = _xcL(")\020e`e<\020\020`<\020`?iV4`!V4iV\004\n\0208tjO-94<b!Cww8`+v2(Q\0232Q\027((+tjO-\017<i=8`B\nwie\029wb\n\\iN:\029\020=i\020\n4\029?\n.e\n")
                              },
                              {
                                Text = _xcL(")\020e`R<==!`e&`\020&\\`>\029\\\ni=iU`y&`>i\n=`\127i=R\n`<\020U\nR\029\\e\n\\b`4<!b`&\020e`e\029V4`\020\029V4`?<=`w\\\029[i\n\\\n\020`ai==!b_`\ni\020\n`e\n\\`[\nie\n\020`\v=<\004\nbb\n\020`y&`Ri\020e\n\020_`e<\020\020`!&V4\n`\ni\020R<V4`\020\029V4`?<=`ei\n`<\004bi>\n`r\029\020\n`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`<&R.")
                              }
                            }, function(action)
                              _aCJ.Active = true
                            end)
                          end
                        end)
                      end
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
function _NaBOl:OnProximity()
  _Z3dY = _xcL("p{<jD=")
  Wherigo.PlayAudio(_2xbNn)
  _Urwigo.MessageBox({
    Text = _xcL("\127i\n\\`?<=`\ni\020`z\029b\029`y&\\`D\\i\n\020bi\n\\&\020U_`a\029`e&`U=\niV4`\ni\020\n`\017\nb<==w=<\004\nbb\n`?ib`\ni\020\n\\`!\nV4!!b\n==iU\n\020`r<4=`Ri\020e\n\020`!\029==b\n!b."),
    Media = _7bou
  })
end
function _wR46N:OnEnter()
  _Z3dY = _xcL("paO\023\002{")
  _Urwigo.GlobalZoneEnter()
  _wR46N.Active = false
  if _bVv0 == false then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\014i\020`\nNb\\<`e<R&\n\\`U\nU\\&\n\020e\nb\n\\`z\029\n\\e\n\\>\n\\\ni\020`4<b`(+vQ`e<?ib`[\nU\029\020\020\n\020_`<=b\n`3\\&\020e?<&\n\\\020`R\\\niy&=\nU\n\020`&\020e`<&R`\ni\020\n`\127\029\n4\n`>\029\020`2+`V?`ai\ne\n\\`<&R?<&\n\\\020`y&`=<!!\n\020.")
      },
      {
        Text = _xcL("\028\020!U\n!<?b`!\029==\n\020`7&\n[\n\\`\ni\020\n\020`!\n4\\`=<\020U\n\020`r\nib\\<&?A`ei\n`3\\&\020e?<&\n\\\020`>\029\020`\\&\020e`(+`\127<\n&!\n\\`\\\n!b<&\\i\n\\b`a\n\\e\n\020.")
      },
      {
        Text = _xcL("6\029\\`e\n\\`z=&b&\020U`a&\\e\n\020`ei\n`3\n[<\n&e\n`U\\\029\n!!b\n\020b\ni=!`U\n!w\\\n\020Ub`74i\n\\`<&R`e\n?`z\029b\029`!i\n4b`?<\020`\n!`\020\029V4`I&<=?\n\020A."),
        Media = _cbG
      },
      {
        Text = _xcL("{&\\`\ni\020\n`n\nib\n\020a<\020e`e\n\\`Li\\V4\n`7aiV4biU\n`\019\ni=`ei\n!\n\\`Li\\V4\n`a&\\e\n\020`&\n[\\iU\n\020!`\020<V4`{\n&\bj\n\\iV4`b\\<\020!=\029yi\n\\bA`4<b`ei\n`nw\\\n\020U&\020U\n\020`i\\U\n\020eai\n`&\n[\n\\!b<\020e\n\020`&\020e`\n!`Ui[b`!V4\029\n\020\n`C&R\020<4?\n\020_`a\029`!\n=[iU\n`<&!`e\n?`9<!!\n\\`e\n!`\014e\n\\!\n\n!`\\<Ub.tjO-9i\n`=<\020U\n`ei\n!\n\\`r&!b<\020e`<\020e<&\n\\b\n_`\004\029\020\020b\n`iV4`=\nie\n\\`\020iV4b`i\020`\014\\R<4\\&\020U`[\\i\020U\n\020.`"),
        Media = _BJLQ
      },
      {
        Text = _xcL("z<==!`e\n\\`\v\nU\n=`U\n\\<e\n`\nNb\\\n?`\020i\ne\\iU`!\ni\020`!\029==b\n`7&\020b\n\\`(v\016`?A_`!\029`\004<\020\020!b`e&`>\029\020`4i\n\\`<&!`<&V4`ei\n`<=b\n`j\\&\nV\004\n`>\029\020`j\n\\iV4`!\n4\n\020.tjO-5<?ib`e&`!\029`>i\n=`>\029\020`e\n\\`j\\&\nV\004\n`!\n4\n\020`\004<\020\020!b_`ai\n`<&R`ei\n!\n?`ji=e_`?&\n!!b\n`e\n\\`\v\nU\n=`<[\n\\`\020\029V4`e\n&b=iV4`a\nib\n\\`R<==\n\020.tjO-5<!`a<\\`e<!`=\nbyb\n`\017<=`vG\016\027`e\n\\`z<==`7nb<\020e`(+v\002A."),
        Media = _2mq
      },
      {
        Text = _xcL("5i\n`&\020U\nR<\n4\\\n`B<U\n`e\n\\`j\\&\nV\004\n`4<[\n`iV4`ei\\`<=!`r\029\020\n`?<\\\004i\n\\b.tjO-C&R!&V4\n\020`?&!!b`e&`ei\n!\n`r\029\020\n`\020<b&\n\\=iV4`\020iV4b.")
      },
      {
        Text = _xcL(")\020e`e<?ib`ei\\`\020iV4b`=<\020Ua\ni=iU`ai\\e_`a<\\b\n\020`H\nbyb`\020\029V4`ya\ni`\004=\ni\020\n`C&RU<[\n\020`<&R`eiV4.")
      }
    }, function(action)
      _1lq4.Active = true
      _bVv0 = true
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_rr3Cf)
      end)
    end)
  elseif Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\bn4<\020b^\bm4\029\\")) then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_VKB)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_rr3Cf)
    end)
  end
end
function _TZWTn:OnEnter()
  _Z3dY = _xcL("p\019r9\019\020")
  _Urwigo.GlobalZoneEnter()
end
function _F0lou:OnEnter()
  _Z3dY = _xcL("pz+=\029&")
  _Urwigo.GlobalZoneEnter()
end
function _k5m4:OnEnter()
  _Z3dY = _xcL("p\0042?\023")
  _Urwigo.GlobalZoneEnter()
  _Rv8P.Active = false
  _k5m4.Active = false
  _1lq4.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("9i\n`!V4\029\020`[\ni?`C!\n=\n\\`5\n\020\004?<=`!\029==b\n!b`e&`<&V4`4i\n\\`\004&\\y`e\n\\`B\n&b\n`U\ne\n\020\004\n\020_`ei\n`a\nU\n\020`e\n!`\014e\n\\!\n\n!`i4\\\n`\127\ni?<b`>\n\\=<!!\n\020`?&!!b\n\020.")
    },
    {
      Text = _xcL("5i\n`?\ni!b\n\020`4<[\n\020`\ni\020\n`j=\ni[\n`U<\020y`i\020`e\n\\`{<\n4\n`U\nR&\020e\n\020_`<[\n\\`<V4b`z<?i=i\n\020`7!\029ai\n`\020\n&\020`<&!`j\\i\020U4<&!\n\020A`a&\\e\n\020`\020<V4`{\n&\bj\n\\iV4`7B&Rb=i\020i\n`((`\004?`\n\020bR\n\\\020bA`&?U\n!i\ne\n=b.")
    },
    {
      Text = _xcL("o\nbyb`\020\029V4`\ni\020\n`=\nbyb\n_`!\n4\\`\ni\020R<V4\n`z\\<U\n`&\020e`ei\n`<\004b&\n==\n`C&RU<[\n`i!b`\n\\=\neiUb.")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_IcLw)
    end)
  end)
end
function _lIYn:OnEnter()
  _Z3dY = _xcL("p=\028g\020")
  _Urwigo.GlobalZoneEnter()
  _lIYn.Active = false
  if _9Ss == false then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5i\n`3\\<\n[\n\\`ei\n!\n!`z\\i\ne4\029R!`a&\\e\n`>\029\\`e\n\\`\n\\!b\n\020`z=&b&\020U`?ib`j\nb\029\020w=<bb\n\020`<[U\ne\nV\004b`&\020e`e&\\V4\020&??\n\\i\n\\b.`tjO-n\029`\004\029\020\020b\n\020`ei\n`C\020U\n4\029\n\\iU\n\020`[\ni`w<!!\n\020e\n?`\v\nU\n=!b<\020e`i4\\\n\\`\019\029b\n\020`>\029\\`D\\b`U\ne\n\020\004\n\020.`"),
        Media = _kPTx
      },
      {
        Text = _xcL("5i\n`3\\<[!b\ni\020\n`a&\\e\n\020`<&R`\ni\020\n?`<\020e\n\\\n\020`z\\i\ne4\029R`<&!!\n\\4<=[`e\n!`nb<&\\<&?\n!`&?U\n!\nbyb.`\014[\n\020e!\029`a&\\e\n\020`ya\ni`\019\029b\n`<&R`e\n\020`!\n=[\n\020`z\\i\ne4\029R`&?U\n[\nbb\nb.")
      },
      {
        Text = _xcL("5\\&V4`z\\\029!b`&\020e`9\n==\n\020!V4=<U`4<b`e\n\\`j\nb\029\020!V4&by`!b\n==\n\020a\ni!\n`=\nie\n\\`!V4\029\020`!\n4\\`U\n=ibb\n\020.tjO-\014i\020\n`n<\020i\n\\&\020U`a<\n\\\n`=<&b`z\029\ne\n\\>\n\\\ni\020`y&\\`\014\\4<=b&\020\020U`e\n\\`5\029\\R!b\n==\n`j\n\\iV4`=\nie\n\\`y&`b\n&\n\\`&\020e`i!b`e<4\n\\`\020iV4b`U\nw=<\020b.")
      },
      {
        Text = _xcL("(+v2`4<bb\n`e\n\\`z\029\n\\e\n\\>\n\\\ni\020`<\020`ei\n!\n\\`nb\n==\n`\ni\020\n`\028\020R\029\\?<bi\029\020b<R\n=`<&RU\n!b\n==b`7!i\n4\n`z\029b\029A.tjO-j\ni`?\ni\020\n?`j\n!&V4`(+v\002`a<\\`e<>\029\020`=\nie\n\\`\020iV4b!`y&`!\n4\n\020."),
        Media = _XBr
      },
      {
        Text = _xcL("C[\n\\`ai\n`?\ni\020\n`!w<\nb\n\\\n`\028\020b\n\\\020\nb\\\nV4\n\\V4\n`\n\\U\n[\n\020`4<b_`4<\nbb\n`iV4`ei\n!\n`>\n\\?&b=iV4`<\020`e\n\\`)R\n\\w\\\029?\n\020<e\n`Ri\020e\n\020`\004\029\n\020\020\n\020.")
      },
      {
        Text = _xcL("o\nbyb`a<\\b\nb`\020\029V4`\ni\020\n`\004=\ni\020\n`C&RU<[\n`<&R`eiV4.")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_LX3m)
      end)
    end)
  else
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_LX3m)
    end)
  end
  _9Ss = true
end
function _euiH2:OnEnter()
  _Z3dY = _xcL("p\n&i\127(")
  _Urwigo.GlobalZoneEnter()
end
function _Hb3W:OnEnter()
  _Z3dY = _xcL("p\127[Q9")
  _Urwigo.GlobalZoneEnter()
end
function _cXq:OnEnter()
  _Z3dY = _xcL("pV0I")
  _Urwigo.GlobalZoneEnter()
  _cXq.Active = false
  _mReoG.Active = false
  _apmiY.Active = false
  _SHf2 = true
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("o\nbyb`\004\029??b`\ni\020`\004=\ni\020\n\\`U\n!V4iV4b=iV4\n\\`\014N\004&\\!_`e\n\\`!iV4`?ib`e\n\\`j\029?[<\\ei\n\\&\020U`e\n!`nb<&e<??\n!`a<\n4\\\n\020e`e\n!`ya\nib\n\020`9\n=b\004\\i\nU\n!`[\n!V4<\nRbiUb`7R<==!`\n!`eiV4`\020iV4b`i\020b\n\\\n!!i\n\\b_`\004<\020\020!b`e&`eiV4`!V4\020\n==`e&\\V4\004=iV\004\n\020_`\0294\020\n`ei\n`\019\nNb\n`y&`=\n!\n\020A.")
    },
    {
      Text = _xcL("j\n\\\nib!`vGQ\016`4<bb\n\020`[\\ibbi!V4\n`\017i==ib<\n\\!`!iV4`3\ne<\020\004\n\020`&\n[\n\\`\ni\020\n`?\029\nU=iV4\n`r\n\\!b\029\n\\&\020U`e\n&b!V4\n\\`\019<=!w\n\\\\\n\020`U\n?<V4b.")
    },
    {
      Text = _xcL("n<\n?b=iV4\n`\v=<\n\020\n`U<=b\n\020`H\ne\029V4`=<\020U\n`<=!`\020iV4b`e&\\V4R&\n4\\[<\\_`a\ni=`ei\n`\019<=!w\n\\\\\n\020`y.`j.`e&\\V4`\019\029\\w\ne\029\020\nby\n`U\n!iV4\n\\b`a<\\\n\020.")
    },
    {
      Text = _xcL("C[\n\\`e<\020\020`a&\\e\n`\nNb\\<`R&\n\\`ei\n!\n\020`ra\nV\004`ei\n`!\029U\n\020<\020\020b\n`O\029==[\029?[\n`\n\\R&\020e\n\020.tjO-5i\n!\n`a&\\e\n\020`>\029\020`!\n4\\`R=<V4`&\020e`[\ni`4\0294\n\\`3\n!V4ai\020eiU\004\nib`R=i\nU\n\020e\n\020`!w\nyi\n==`&?U\n[<&b\n\020`j\029?[\n\\\020`e\n!`\019^w!`B<\020V<!b\n\\`<[U\na\029\\R\n\020."),
      Media = _CC3Gm
    },
    {
      Text = _xcL(")?`ei\n`\020\029ba\n\020eiU\n`z=&U4\029\n4\n`a<\n4\\\n\020e`e\n!`j\029?[\n\020<[a&\\R\n!`y&`U\na<\n4\\=\ni!b\n\020_`4<bb\n\020`ei\n!\n`j\029?[\n\\`H\na\ni=!`<?`j&U`&\020e`\127\nV\004`nV4\ni\020a\n\\R\n\\_`ei\n`!\029`\ni\020U\n!b\n==b`a<\\\n\020_`e<!!`!iV4`ei\n`BiV4b\004\nU\n=`U\n\020<&`[\ni`v\027`?`z=&U4\029\n4\n`&\n[\n\\!V4\020ibb\n\020.")
    },
    {
      Text = _xcL("5i\n`j\029?[\n`4&\nwRb\n`<&R`e\n\\`9<!!\n\\\029[\n\\R=<\nV4\n`&\n[\n\\`ei\n`\019\029\\w\ne\029<[a\n4\\\020\nbyb\n`ai\n`\ni\020`R=<V4\n\\`Li\n!\n=!b\ni\020`[i!`!i\n`U\nU\n\020`ei\n`\017<&\n\\`b\\<R_`e\029\\b`<[!<\020\004`&\020e`[\ni`v+`?`9<!!\n\\bi\nR\n`e&\\V4`\ni\020\n\020`5\\&V\004y&\n\020e\n\\`y&\\`5\nb\029\020bi\029\020`U\n[\\<V4b`a&\\e\n."),
      Media = _YALmA
    },
    {
      Text = _xcL("\028\020`e\n\\`{<V4b`>\029?`v\002.`<&R`e\n\020`v\016.`\017<i`vG\023Q`!V4<RRb\n\020`ei\n`j\\ib\n\020`<&R`ei\n!\n`9\ni!\n_`ei\n`\017\029\n4\020\nb<=\b`&\020e`ei\n`\014e\n\\!\n\n!w\n\\\\?<&\n\\`7z\029b\029A`!V4a\n\\`y&`[\n!V4<\nei\020U\n\020."),
      Media = _4jts
    },
    {
      Text = _xcL("vQ++`[i!`(\023++`\017\n\020!V4\n\020`7e<\\&\020b\n\\`\ni\020`\n\\4\n[=iV4\n\\`C\020b\ni=`ra<\020U!<\\[\nib\n\\\028\020\020\n\020`&\020e`L\\i\nU!U\nR<\020U\n\020\nA`\004<?\n\020`e<[\ni`&?!`B\n[\n\020.tjO-\014[\n\020!\029`!b<\\[\n\020`2Q`e\n\\`vQQ`<?`C\020U\\iRR`[\nb\ni=iUb\n\020`[\\ibi!V4\n\020`n\029=e<b\n\020_`e<`\nb=iV4\n`e\n\\`vG`[\nb\ni=iUb\n\020`j\029?[\n\\`<[U\n!V4\029!!\n\020`a&\\e\n\020`\029e\n\\`[\ni?`bi\nR\n\020`z=&U`\004\020<ww`&\n[\n\\`e\n\020`j<&?aiwR\n=\020`?ib`\127\029V4!w<\020\020&\020U!=\nib&\020U\n\020`\004\029==iei\n\\b\n\020.`")
    },
    {
      Text = _xcL(")\020e`!V4\029\020`i!b`e\n\\`\004=\ni\020\n`\014N\004&\\!`R\n\\biU.tjO-5i\n`C&RU<[\n`i!b`e<?ib`<[U\n4<\004b`&\020e`e&`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020.")
    }
  }, function(action)
    _SdqT.Active = false
    _IyQ.Active = false
    _p_T.Active = false
    if _0NcV == false and _kEjQ == false then
      _3_2.Active = true
    elseif _0NcV == true and _kEjQ == false then
      _JQtI.Active = true
    elseif _kEjQ == true then
      _afnxp.Active = true
    end
    _ceLKO()
  end)
end
function _SdqT:OnEnter()
  _Z3dY = _xcL("pneI\019")
  _Urwigo.GlobalZoneEnter()
end
function _IyQ:OnEnter()
  _Z3dY = _xcL("p\028^\a")
  _Urwigo.GlobalZoneEnter()
end
function _EsK:OnEnter()
  _Z3dY = _xcL("p\014!L")
  _Urwigo.GlobalZoneEnter()
  _EsK.Active = false
  _apmiY.Active = false
  _mReoG.Active = false
  _Urwigo.OldDialog({
    {
      Text = _xcL("5&`[\nRi\020e\n!b`eiV4`H\nbyb`i\020`\nba<`[\ni`e\n\\`5&\\V4R<4\\b`e\n\\`nV4=\nww[<4\020_`a\n=V4\n`R&\n\\`e\n\020`3&\nb\n\\>\n\\\004\n4\\`[\ni?`j<&`e\n\\`nb<&?<&\n\\`<=!`C[\004&\n\\y&\020U`U\n!V4<RR\n\020`a&\\e\n.")
    },
    {
      Text = _xcL("\028?`B<&R\n`e\n\\`o<4\\\n`4<[\n\020`!iV4`i\020`ei\n!\n?`5&\\V4[\\&V4`nb\ni\020\n`<\020U\n!<??\n=b_`!\029`e<!!`\n\\`H\nbyb`!V4\029\020`<[`\ni\020\n\020`\v\nU\n=!b<\020e`>\029\020`((\023`?`b\\\029V\004\n\020\n\020`z&!!\n!`y&`&\n[\n\\I&\n\\\n\020`i!b`7&\020e`\020iV4b`\n\\!b`<[`((+`?A.")
    },
    {
      Text = _xcL("3<\020y`i\020`e\n\\`{<\n4\n`e\n\\`5&\\V4R<4\\b_`a\n!b=iV4`<\020`e\n\020`\127\029wR\n\020[\n\\U`<\020U\n!V4?i\nUb_`!b<\020e`R\\&\n4\n\\`ei\n`nb\029==?&\n4=\n`7\029e\n\\`nb\029==\n\020?&\n4=\nA.tjO-5i\n`\028\020R\029b<R\n=`\029[\n\020`<\020`e\n\\`\127<??\n\\[\n\\U!wiby\n`4<!b`e&`H<`>i\n==\niV4b`U\n=\n!\n\020.")
    },
    {
      Text = _xcL("6\029\\`e\n\\`z=&b&\020U`e\n!`\014e\n\\!\n\n!`a&\\e\n`ei\n`\017&\n4=\n`<[U\n[\\<\020\020b."),
      Media = _Afk
    },
    {
      Text = _xcL("5i\n`O&i\020\n\020`!i\020e`!\nib`e\n\\`z=&b&\020U`\020iV4b`ai\ne\n\\`<&RU\nb<&V4b`&\020e`a&\\e\n\020`>\n\\?&b=iV4`(+v2`\n\\!b?<=!`>\029\020`\ni\020\n?`\019<&V4\n\\b\n<?`[\n!&V4b.tjO-5i\n`\\&!!U\n!V4a<\n\\yb\n\020`3\\&\020e?<&\n\\\020`\b`&\020e`\020\029V4`!\029`\ni\020iU\n!`<\020e\n\\\n`\b`!i\020e`&\020b\n\\`9<!!\n\\`\020\029V4`U&b`y&`\n\\\004\n\020\020\n\020`U\na\n!\n\020.tjO-C\020[\ni`\ni\020\n`n\029\020<\\<&R\020<4?\n`e\n\\`O&i\020\n\020."),
      Media = _sZNm
    }
  })
end
function _gSx1:OnEnter()
  _Z3dY = _xcL("pUnNv")
  _Urwigo.GlobalZoneEnter()
  _gSx1.Active = false
  _mReoG.Active = false
  _apmiY.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("nV4\029\020`U<\020y`!V4\029\n\020`?\n\\\004a&\n\\eiU_`4i\n\\`\029[\n\020`<&R`e\n?`3iwR\n=`e\n!`\127\029wR\n\020[\n\\U\n!`\ni\020\n`j\029H\n`y&`!\n4\n\020."),
      Media = _Mn2
    },
    {
      Text = _xcL(")?`y&`[\na\ni!\n\020_`e<!!`e&`ai\\\004=iV4`e\n\020`\127\029wR\n\020[\n\\U`\n\\\004=\029??\n\020`4<!b_`?&!!b`e&`H\nbyb`\020\029V4`\ni\020\n`\004=\ni\020\n`C&RU<[\n`[\na<\n=biU\n\020.")
    },
    {
      Text = _xcL("5<[\ni`4<!b`e&`ei\n`9<4=`yai!V4\n\020`\ni\020\n\\`C&RU<[\n_`ei\n`\nV4b`nV4\ni!!\n`i!b`&\020e`\ni\020\n\\_`ei\n`[\n!V4i!!\n\020`i!b."),
      Buttons = {
        _xcL([[
nV4
i!!
]]),
        _xcL("[\n!V4i!!\n\020")
      }
    }
  }, function(action)
    if action == "Button1" == true then
      _Drx4x()
    elseif action == "Button2" == true then
      _RwfBG()
    end
  end)
end
function _YVBK:OnEnter()
  _Z3dY = _xcL("pg6jL")
  _Urwigo.GlobalZoneEnter()
  _YVBK.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("j\ni`ei\n!\n\020`3=\ni!\n\020`&\020e`e\n?`w\\i?ibi>\n\020`\v\\\n==[\029V\004`4<\020e\n=b`\n!`!iV4`a\0294=`\020iV4b`&?`\ni\020`O\n=i\004b`<&!`e\n\\`r\nib`>\029\\`e\n\\`z=&b&\020U`e\n!`\014e\n\\!\n\n!."),
      Media = _Ojk
    },
    {
      Text = _xcL("5i\n`3=\ni!\n`ei\n\020\n\020`a\0294=`>i\n=?\n4\\`e<y&_`j\029\029b\n`<\020`ei\n!\n\\`nb\n==\n`i\020!`9<!!\n\\`y&`=<!!\n\020.")
    },
    {
      Text = _xcL("9i\n`<=b`ei\n`3=\ni!\n`&\020e`e\n\\`\v\\\n==[\029V\004`!i\020e_`\004\029\020\020b\n`iV4`=\nie\n\\`\020iV4b`\n\\?ibb\n=\020.")
    },
    {
      Text = _xcL("\014i\020\n\020`r\029==!b\029V\004`\029e\n\\`\ni\020`\017<!![<\020e`4<!b`e&`4\029RR\n\020b=iV4`e<[\ni."),
      Media = _qh3xQ
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_ZiQPR)
    end)
  end)
end
function _6iCkx:OnEnter()
  _Z3dY = _xcL("p\002im\004N")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_eFvwm)
  end)
end
function _ihg7:OnEnter()
  _Z3dY = _xcL("pi4U\016")
  _Urwigo.GlobalZoneEnter()
end
function _5hre:OnEnter()
  _Z3dY = _xcL("p24\\\n")
  _Urwigo.GlobalZoneEnter()
  _CSd()
end
function _xQO:OnEnter()
  _Z3dY = _xcL("pN\aD")
  _Urwigo.GlobalZoneEnter()
  _CSd()
end
function _cJX:OnEnter()
  _Z3dY = _xcL("pVo0")
  _Urwigo.GlobalZoneEnter()
end
function _6ky:OnEnter()
  _Z3dY = _xcL("p\002\004^")
  _Urwigo.GlobalZoneEnter()
  _6ky.Active = false
  _pmrZ.Active = false
  _Llejb.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("C&R`e\n\\`Bi\n[\n!i\020!\n=`7ei\n`e<?<=!`\020<b&\n\\=iV4`\004\ni\020\n`\028\020!\n=`!\029\020e\n\\\020`\ni\020`\004=\ni\020\n\\`j\n\\U`a<\\A`!b<\020e`\ni\020!b?<=`\ni\020\n\\`e\n\\`w\\<\nV4biU!b\n\020`j&\\U\n\020`5\n&b!V4=<\020e!.")
    },
    {
      Text = _xcL("9i\\\004=iV4`\ni\020\n`nV4<\020e\n_`e<!!`ei\n!\n`R&\n\\`e\n\020`j<&`e\n\\`\019<=!w\n\\\\\n`e\n?`\014\\e[\029e\n\020`U=\niV4`U\n?<V4b`a&\\e\n_`!\029`e<!!`4\n&b\n`\020&\\`\020\029V4`ai\020yiU\n`O\n!b\n`\n\\4<=b\n\020`!i\020e.")
    },
    {
      Text = _xcL("\127i\n\\`\ni\020`ji=e`>\029\020`vGv(_`ai\n`ei\n`j&\\U`\020\029V4`\004&\\y`>\029\\`e\n\\`z=&b&\020U`e\n!`\014e\n\\!\n\n!`<&!!<4."),
      Media = _JtBnY
    },
    {
      Text = _xcL("DL_`e<!`i!b`\020<b&\n\\=iV4`<==\n!`U\n=\029U\n\020`&\020e`e<!`z\029b\029`y\niUb\n`i\020`9i\\\004=iV4\004\nib`ei\n`j&\\U`\014=by`7ai\n`e&`>\n\\?&b=iV4`\n4`\n\\\004<\020\020b`4<!bA|")
    },
    {
      Text = _xcL("\019<b!<\nV4=iV4`i!b`&\n[\n\\`ei\n`3\n!V4iV4b\n`e\n\\`j&\\U`j\\i\020U`\020iV4b`>i\n=`[\n\004<\020\020b.`n\029`a\ni!!`?<\020`y.`j.`\020iV4b_`a<\020\020`!i\n`U\n[<&b`a&\\e\n.tjO-\014\\!b?<=!`&\\\004&\020e=iV4`\n\\a<\n4\020b`a&\\e\n`\ni\020`\006Oibb\n\\`>\029\020`j\\i\020U4<&!\n\020\006`i?`o<4\\`vvG\002_`<[\n\\`ei\n`j&\\U`i!b`!\n4\\`a<4\\!V4\ni\020=iV4`<\n=b\n\\.")
    },
    {
      Text = _xcL("\014!`i!b`<&V4`\020iV4b`[\n\004<\020\020b_`a<\020\020`ei\n`j&\\U`<&RU\nU\n[\n\020`\029e\n\\`y\n\\!b\029\n\\b`a&\\e\n.tjO-C&R`H\ne\n\020`z<==`a<\\\n\020`[\n\\\nib!`i?`vG.`o<4\\4&\020e\n\\b`\020&\\`\020\029V4`a\n\020iU\n`\017<&\n\\\\\n!b\n`\n\\4<=b\n\020.tjO-z<==!`r\niV4\020&\020U\n\020`\029e\n`3\n?<\n=e\n`\nNi!bi\n\\\n\020_`<&R`e\n\020\n\020`?<\020`\n\\\004\n\020\020\n\020`\004<\020\020`ai\n`ei\n`j&\\U`R\\&\n4\n\\`<&!!<4_`!\029`\004\029\020\020b\n`iV4`e<y&`i?`\028\020b\n\\\020\nb`\020iV4b!`Ri\020e\n\020.")
    },
    {
      Text = _xcL("\017ib`e\n?`j\n!&V4`e\n\\`Bi\n[\n!i\020!\n=`4<!b`e&`H\nbyb`ei\n`<\004b&\n==\n`C&RU<[\n`\n\\=\neiUb.tjO-z<==!`e&`ei\n`O&i\020\n\020`\020\029V4`\020iV4b`\n\020be\nV\004b`4<!b8`5i\n!\n`!i\020e`\020\029V4`?<=`<=!`r\029\020\n`U\n!\029\020e\n\\b`?<\\\004i\n\\b.tjO-\017&!!b`e&`<[\n\\`\020iV4b`&\020[\nei\020Ub`<&R!&V4\n\020.`C&RU<[\n`i!b`!V4\029\020`<[U\n4<\004b.tjO-C[\n\\`>i\n==\niV4b`i!b`e<`H<`\020\029V4`\ni\020\n`5\029!\n`>\n\\!b\nV\004b_`ei\n`e&`\020\029V4`\020iV4b`U\n=\029UUb`4<!b;`De\n\\`4<!b`e&`ei\n`!V4\029\020`U\nR&\020e\n\020`\029e\n\\`a&\\e\n`!i\n`[\n\\\nib!`ai\ne\n\\`<\\V4i>i\n\\b;")
    },
    {
      Text = _xcL(")\020e`e<`ei\n!`U=\niV4y\nibiU`ei\n`=\nbyb\n`C&RU<[\n`e\n\\`nb&R\n`v`a<\\_`\004<\020\020!b`e&`<[`H\nbyb`H\ne\n\\y\nib`\006zi\020<=`nb&R\n`v\006`<\004bi>i\n\\\n\020.")
    }
  }, function(action)
    _3_2.Active = false
    _CvVXL.Active = true
    _C_G9.Active = false
    _bHJ.Active = false
    if _kEjQ == true then
      _Urwigo.OldDialog({
        {
          Text = _xcL("j\n>\029\\`e&`eiV4`<[\n\\`<&R`e\n\020`9\nU`y&?`zi\020<=`>\029\020`nb&R\n`v`?<V4!b_`!\029==b\n!b`e&`\n\\!b`\020\029V4`ei\n`\\\n!b=iV4\n\020`[\nie\n\020`\014e\n\\!\n\n\bCb=<\020bi!\bC&RU<[\n\020`\n\\=\neiU\n\020.tjO-5<\020\020`\004<\020\020!b`e&`<\020!V4=i\n!!\n\020e`U=\niV4`<==\n`e\\\ni`5\029!\n\020`<&R`\ni\020?<=`\ni\020!<??\n=\020.")
        }
      })
      _5sM.Active = true
    end
    _ceLKO()
  end)
end
function _C_G9:OnEnter()
  _Z3dY = _xcL("pmp3G")
  _Urwigo.GlobalZoneEnter()
end
function _xwK:OnEnter()
  _Z3dY = _xcL("pNaL")
  _Urwigo.GlobalZoneEnter()
  _kH04N:MoveTo(nil)
  _IIuy:MoveTo(nil)
  _xwK.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("DL_`iV4`U=<&[\n`ei\n!\n`C&RU<[\n`a<\\`\020iV4b`ai\\\004=iV4`!V4ai\n\\iU.tjO-j\n!bi??b`4<!b`e&`\020iV4b`=<\020U\n`\029e\n\\`>i\n==\niV4b`<&V4`U<\\`\020iV4b`!&V4\n\020`?&\n!!\n\020.tjO-5i\n`<\004b&\n==\n`C&RU<[\n`i!b`e<?ib`\n\\R&\n==b.")
    }
  }, function(action)
    _5sM.Active = false
    _0fzmj.Active = true
    _ceLKO()
  end)
end
function _ybh6:OnEnter()
  _Z3dY = _xcL("p^[4\002")
  _Urwigo.GlobalZoneEnter()
  _ybh6.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("5<!`3\n[i\nb_`i\020`e\n?`?<\020`4i\n\\`\020\029V4`O\n!b\n`e\n\\`3\n[<\n&e\n`\n\\\004\n\020\020\n\020`\004<\020\020_`i!b`\\\n=<bi>`U\\\029!!`&\020e`ei\n`>\029\020`?i\\`<\020U\nU\n[\n\020\n`r\029\020\n`a\0294=`\\\nV4b`&\020U\n\020<&.")
    },
    {
      Text = _xcL("C=!`iV4`!\n=[\n\\`4i\n\\`\\&?U\n=<&R\n\020`[i\020_`&?`ei\n!\n\020`94\n\\iU\029`y&`w=<\020\n\020_`e<`4<[\n`iV4`\020<V4`O\n!b\n\020`\ni\020\n!`L\n==\n\\U\na\029\n=[\n!`U\n!&V4b_`>\029\020`e\n?`iV4`>\029\\4\n\\`i?`{\nby`ji=e\n\\`U\nR&\020e\n\020`4<bb\n.tjO-C&R`e\n?`\014e\n\\!\n\n\bCb=<\020bi!\bnV4i=e`[\ni`e\n?`\ni\020\n?`>\029\020`?i\\`\n?wR\0294=\n\020\n\020`\v<\\\004w=<by_`ai\\e`e<!`L\n==\n\\U\na\029\n=[\n`\n[\n\020R<==!`\n\\a<\n4\020b.")
    },
    {
      Text = _xcL("\014iU\n\020b=iV4`a<\\`U\nw=<\020b_`e<!!`e&`ei\n!\n!`L\n==\n\\U\na\029\n=[\n`Ri\020e\n\020`?&!!b`7\0294\020\n`\ni\020\n`?<\\\004i\n\\b\n`r\029\020\nA.")
    },
    {
      Text = _xcL("C[\n\\`e<`iV4`!\n=[\n\\`<\020`e\n\\`C&RU<[\n`U\n!V4\nib\n\\b`[i\020_`4<[\n`iV4`?i\\`e\029V4`\nba<!`e\n&b=iV4`=\niV4b\n\\\n!`R&\n\\`eiV4`<&!U\ne<V4b.")
    },
    {
      Text = _xcL("j\ni`e\n?`L\n==\n\\U\na\029\n=[\n`4<bb\n`iV4`U\ne<V4b_`iV4`a<\n\\\n`4<&wb!<\nV4=iV4`U\n!V4\nib\n\\b_`a\ni=`iV4`a\nU\n\020`\ni\020\n!`\019\n\\?i\020\n!`<\\U`&\020b\n\\`r\nibe\\&V\004`!b<\020e.")
    },
    {
      Text = _xcL("C[\n\\`\ni\020\n`U\n\020<&\n\\\n`O\nV4\n\\V4\n`i?`{\nby`=<\n!!b`?iV4`H\nbyb`\n4\n\\`U=<&[\n\020_`e<!!`?<\020`?\029?\n\020b<\020`>\029\\`D\\b`7R<!b;A`\020iV4b!`?\n4\\`>\029\020`e\n?`3\na\029\n=[\n`\n\\\004\n\020\n\020`\004<\020\020_`e<`ei\n!\n!`>\n\\?&b=iV4`?ibb=\n\\a\ni=\n`>\029==\004\029??\n\020`>\029\020`nV4=<??`[\ne\nV\004b`i!b.")
    },
    {
      Text = _xcL("n\029`!<4`\n!`\020\029V4`(++Q`<&!.`tjO-\028??\n\\4i\020`\027\016`o<4\\\n`\020<V4`e\n\\`z=&b&\020U`e\n!`\014e\n\\!\n\n!."),
      Media = _8p_d9
    },
    {
      Text = _xcL("n\029`(++\016."),
      Media = _Klr0
    },
    {
      Text = _xcL(")\020e`!\029`(+vQ."),
      Media = _YuJg
    },
    {
      Text = _xcL("C[\n\\`e<`iV4`y&\\`6\029\\[\n\\\nib&\020U`e\n!`9\0283!`\020\029V4`\ni\020`ya\nib\n!`\017<=`>\029\\`D\\b`a<\\`&\020e`iV4`e<`?\n4\\`r\nib`4<bb\n`7&\020e`?ib`nw\029i=\n\\[i=e\n\\\020`<&!U\n!b<bb\nb`a<\\A_`4<[\n`iV4`ei\n`O\n!b\n`e\n!`L\n==\n\\U\na\029\n=[\n!`e<\020\020`e\029V4`\020\029V4`U\nR&\020e\n\020.")
    },
    {
      Text = _xcL(")\020e`ai\n`\n\\a<\\b\nb_`a<\\`(+v\002`\020\029V4`a\n\020iU\n\\`e<>\029\020`y&`\n\\\004\n\020\020\n\020`&\020e`\0294\020\n`ei\n`<=b\n\020`z\029b\029!`a<\n\\\n`iV4`a\0294=`\020iV4b`<&R`ei\n`\028e\n\n`U\n\004\029??\n\020_`e<!!`ei\n!`e<!`<=b\n`L\n==\n\\U\na\029\n=[\n`!\ni\020`!\029==."),
      Media = _3Icce
    },
    {
      Text = _xcL("o\nbyb`<[\n\\`y&`e\ni\020\n\\`ai\\\004=iV4`=\niV4b\n\020`C&RU<[\n8")
    },
    {
      Text = _xcL("\017<\020`\004<\020`4i\n\\`\ni\020iU\n`3\\&\020e?<&\n\\\020`\020\029V4`\\\n=<bi>`e\n&b=iV4`\n\\\004\n\020\020\n\020.")
    },
    {
      Text = _xcL("\014i\020\n!`e\n\\`3\n[<&\ne\n`4<bb\n`<\020`e\n\\`\ni\020\n\020`n\nib\n`a\0294=`\004\ni\020\n`9<\020e`<&!`nb\ni\020`!\029\020e\n\\\020`<&!`\127\029=y.")
    },
    {
      Text = _xcL("5i\n`O\n!b\n`ei\n!\n!`3\n[<&\ne\n!`?&!!b`e&`Ri\020e\n\020.tjO-5\029\\b`[\nRi\020e\nb`!iV4`\ni\020\n`>\n\\!b\nV\004b\n`r\029\020\n_`ei\n`e&`[\nb\\\nb\n\020`?&!!b_`&?`ei\n`<\004b&\n==\n`C&RU<[\n`y&`\n\\R&\n==\n\020.")
    },
    {
      Text = _xcL("5<`iV4`\020iV4b`<&!!V4=i\n!!\n\020`\004<\020\020_`e<!!`\n!`\n>\n\020b&\n==`?\n4\\\n\\\n`\v=<\nby\n`Ui[b_`ei\n`y&`?\ni\020\n\\`j\n!V4\\\ni[&\020U`w<!!\n\020`7[\ni`?\ni\020\n?`ya\nib\n\020`j\n!&V4`4<[\n`iV4`b<b!<\nV4=iV4`!\029=V4\n`\n\020be\nV\004bA_`4i\n\\`\ni\020`ji=e_`ai\n`ei\n`3\\&\020e?<&\n\\\020`e\n!`U\n!&V4b\n\020`3\n[<&\ne\n!`<&!!\n4\n\020`!\029==\n\020`7e<!`ji=e`[\nRi\020e\nb`!iV4`<&V4`\020\029V4`?<=`i\020`e\ni\020\n?`\028\020>\n\020b<\\A."),
      Media = _rgT
    }
  }, function(action)
    _kH04N:MoveTo(Player)
    _IIuy:MoveTo(Player)
    _xwK.Active = true
  end)
end
function _lOan:OnEnter()
  _Z3dY = _xcL("p=D<\020")
  _Urwigo.GlobalZoneEnter()
  _lOan.Active = false
  _DFlc()
end
function _gVBA:OnEnter()
  _Z3dY = _xcL("pU6jC")
  _Urwigo.GlobalZoneEnter()
  _gVBA.Active = false
  _DFlc()
end
function _YFO:OnEnter()
  _Z3dY = _xcL("pgzD")
  _Urwigo.GlobalZoneEnter()
end
function _vzpn:OnEnter()
  _Z3dY = _xcL("p>yw\020")
  _Urwigo.GlobalZoneEnter()
end
function _SQg:OnEnter()
  _Z3dY = _xcL("pn\aU")
  _Urwigo.GlobalZoneEnter()
end
function _FWV6:OnEnter()
  _Z3dY = _xcL("pz96\002")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.MessageBox({
    Text = _xcL(")\020e`H\nbyb`U=\niV4`a\nib\n\\`y&?`<=b\n\020`z\\i\ne4\029R."),
    Media = _x8GjC
  })
  _FWV6.Active = false
  _OHy9A.Active = false
  _lIYn.Active = true
end
function _I_PH:OnEnter()
  _Z3dY = _xcL("p\028p\v\127")
  _Urwigo.GlobalZoneEnter()
end
function _Rxj:OnEnter()
  _Z3dY = _xcL("pONH")
  _Urwigo.GlobalZoneEnter()
end
function _SKs:OnEnter()
  _Z3dY = _xcL("pnL!")
  _Urwigo.GlobalZoneEnter()
end
function _aKBkN:OnEnter()
  _Z3dY = _xcL("p<Lj\004{")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.MessageBox({
    Text = _xcL("3\n\020&U`U\n!V4<\n?b.tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`?<=`<?`nw\n\\\\?<&\n\\?\029e\n==_`\020<V4e\n?`e&`\ni\020`a\nib\n\\\n!`\017<=`\ni\020\n\020`j=iV\004`<&R`ei\n!\n!`ji=e`U\na\029\\R\n\020`4<!b.tjO-"),
    Media = _mAok,
    Callback = function(action)
      if action ~= nil then
        _aKBkN.Active = false
        _aCJ.Active = true
      end
    end
  })
end
function _apmiY:OnEnter()
  _Z3dY = _xcL("p<w?ig")
  _Urwigo.GlobalZoneEnter()
end
function _mReoG:OnEnter()
  _Z3dY = _xcL("p?O\n\0293")
  _Urwigo.GlobalZoneEnter()
end
function _1lq4:OnEnter()
  _Z3dY = _xcL("pv=I\023")
  _Urwigo.GlobalZoneEnter()
end
function _Aqu8:OnEnter()
  _Z3dY = _xcL("pCI&\027")
  _Urwigo.GlobalZoneEnter()
  _Aqu8.Active = false
  _apmiY.Active = false
  _mReoG.Active = false
  _Urwigo.OldDialog({
    {
      Text = _xcL("9i\n`[\n\\\nib!`[\ni`e\n\020`<==U\n?\ni\020\n\020`\014\\\004=<\n\\&\020U\n\020`\n\\a<\n4\020b_`Ui[b`\n!`\ni\020\n`nb<bi\029\020_`R&\n\\`ei\n`e&`\ni\020`U&b\n!`nb&\nV\004`=<&R\n\020`?&!!b`&\020e`ai\n`e&`a<4\\!V4\ni\020=iV4`!V4\029\020`\\iV4biU`>\n\\?&b\nb`4<!b_`4<\020e\n=b`\n!`!iV4`e<[\ni`&?`ei\n`nb\\\nV\004\n`y&?`\127\029wR\n\020[\n\\U.tjO-C[\n\\`ei\n`\127<\n=Rb\n`[i!`y&\\`\127<??\n\\[\n\\U!wiby\n`4<!b`e&`H<`!V4\029\020`4i\020b\n\\`ei\\`7>i\n==\niV4b`<&V4`!V4\029\020`?\n4\\_`R<==!`e&`>\029\020`ei\n!\n\\`\017\n=e&\020U`\020iV4b!`?ib[\n\004\029??\n\020`4<!b`&\020e`!i\n`>i\n=`y&`!w<\nb`=i\n!bA.")
    },
    {
      Text = _xcL("\028V4`w\n\\!\029\n\020=iV4`Ri\020e\n`e\n\020`9\nU`ei\\\n\004b`<?`\006)R\n\\\006`e\n!`\014e\n\\!\n\n!`!\n4\\`!V4\029\n\020.tjO-\017<\020`\004<\020\020`!iV4`\004<&?`>\029\\!b\n==\n\020_`e<!!`4i\n\\`?<\020V4?<=`e<!`9<!!\n\\`[i!`R<!b`<\020`e\n\020`9\nU`\\\niV4b.")
    },
    {
      Text = _xcL(")\020e`>i\n==\niV4b`\004\029\020\020b\n!b`e&`ei\\`e\n\020`=<\020U\n\020`9\nU`?ib`\ni\020`a\n\020iU`j\niR<\020U`>\n\\!&\n!!\n\020_`!\029R\n\\\020`e&`ei\n`5\029!\n\020`\020\029V4`\020iV4b`>\029\\4\n\\`[\n!&V4b`4<!b`&\020e`ei\n!\n`i??\n\\`\020\029V4`<\004bi>`!i\020e.")
    },
    {
      Text = _xcL("o\nbyb`ai==`iV4`eiV4`<[\n\\`\020iV4b`a\nib\n\\`<&R4<=b\n\020.")
    }
  })
end
function _mxHN4:OnEnter()
  _Z3dY = _xcL("p?N\127{\023")
  _Urwigo.GlobalZoneEnter()
  _mxHN4.Active = false
  _Urwigo.OldDialog({
    {
      Text = _xcL("5&`[i!b`H\nbyb`\020iV4b`?\n4\\`a\nib`>\029\020`e\n\\`5\029!\n`e\n\\`nb&R\n`(`\n\020bR\n\\\020b.")
    },
    {
      Text = _xcL("5i\n`zi\020<=\br\029\020\n`4<[\n`iV4`\nNb\\<`!\029`\004=\ni\020`U\na<\n4=b_`e<?ib`e&`eiV4`[\n!!\n\\`>\029?`\v=<^\n\\`e\029\\b`4i\020`=\nib\n\020`=<!!\n\020`\004<\020\020!b`74<b`H<`\020iV4b`H\ne\n\\`\020\029V4`y&!<\nby=iV4`\ni\020`3\vn\b3\n\\<\nb`e<[\ni_`i\020`e\n?`\n\\`ei\n`zi\020<=\004\029\029\\ei<\020b\n\020`\ni\020U\n[\n\020`\004<\020\020A.tjO-5&`?&!!b`ei\\`\004\ni\020\n`\017&\n4\n`U\n[\n\020_`ei\n`ai\020yiU\n`r\029\020\n`y&`[\nb\\\nb\n\020.`C\004bi\029\020\n\020`a\n\\e\n\020`e<e&\\V4`\n4`\020iV4b`<&!U\n=\029\n!b.")
    },
    {
      Text = _xcL("5\n\020\004`e\\<\020_`e<!!`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`\ni\020`nw\029i=\n\\\bz\029b\029`[\nRi\020e\nb.`D4\020\n`ei\n!\n!`i!b`\n!`>\n\\?&b=iV4`\nNb\\\n?`!V4a\n\\_`ei\n`5\029!\n`y&`Ri\020e\n\020.tjO-\014\\U<\n\020yb`ai\\e`e<!`z\029b\029`\020\029V4`e&\\V4`\ni\020\n\020`nw\029i=\n\\\b\019\nNb_`e<?ib`e&`<&V4`\ni\020\n`m4<\020V\n`4<!b_`!\029==b\n`e\ni\020`3\n\\<\nb`<&!`i\\U\n\020e\ni\020\n?`3\\&\020e`e<!`z\029b\029`\020iV4b`<\020y\niU\n\020.")
    }
  })
  _tGF:MoveTo(Player)
  _BI7w:MoveTo(Player)
end
function _PH0:OnEnter()
  _Z3dY = _xcL("p\v\127+")
  _Urwigo.GlobalZoneEnter()
  _PH0.Active = false
  _Urwigo.OldDialog({
    {
      Text = _xcL("5&`[i!b`H\nbyb`\020iV4b`?\n4\\`a\nib`>\029\020`e\n\\`5\029!\n`e\n\\`nb&R\n`v`\n\020bR\n\\\020b.")
    },
    {
      Text = _xcL("5i\n`zi\020<=\br\029\020\n`4<[\n`iV4`\nNb\\<`!\029`\004=\ni\020`U\na<\n4=b_`e<?ib`e&`eiV4`[\n!!\n\\`>\029?`\v=<^\n\\`e\029\\b`4i\020`=\nib\n\020`=<!!\n\020`\004<\020\020!b`74<b`H<`\020iV4b`H\ne\n\\`\020\029V4`y&!<\nby=iV4`\ni\020`3\vn\b3\n\\<\nb`e<[\ni_`i\020`e\n?`\n\\`ei\n`zi\020<=\004\029\029\\ei<\020b\n\020`\ni\020U\n[\n\020`\004<\020\020A.tjO-5&`?&!!b`ei\\`\004\ni\020\n`\017&\n4\n`U\n[\n\020_`ei\n`ai\020yiU\n`r\029\020\n`y&`[\nb\\\nb\n\020.`C\004bi\029\020\n\020`a\n\\e\n\020`e<e&\\V4`\n4`\020iV4b`<&!U\n=\029\n!b.")
    },
    {
      Text = _xcL("5\n\020\004`e\\<\020_`e<!!`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`ya\ni`w<!!\n\020e\n`nw\029i=\n\\\bz\029b\029!`[\nRi\020e\n\020.`D4\020\n`ei\n!\n`i!b`\n!`>\n\\?&b=iV4`\nNb\\\n?`!V4a\n\\_`ei\n`5\029!\n`y&`Ri\020e\n\020.tjO-\014\\U<\n\020yb`a\n\\e\n\020`ei\n`z\029b\029!`\020\029V4`e&\\V4`\ni\020\n\020`nw\029i=\n\\\b\019\nNb_`e<?ib`e&`<&V4`\ni\020\n`m4<\020V\n`4<!b_`!\029==b\n`e\ni\020`3\n\\<\nb`<&!`i\\U\n\020e\ni\020\n?`3\\&\020e`ei\n`z\029b\029!`\020iV4b`<\020y\niU\n\020.")
    }
  })
  _2yV0v:MoveTo(Player)
  _ZHm4x:MoveTo(Player)
end
function _ja5:OnEnter()
  _Z3dY = _xcL("pH<2")
  _Urwigo.GlobalZoneEnter()
  _ja5.Active = false
  _rVgz.Active = false
  _Urwigo.OldDialog({
    {
      Text = _xcL("5&`[i!b`H\nbyb`\020iV4b`?\n4\\`a\nib`>\029\020`e\n\\`5\029!\n`e\n\\`nb&R\n`Q`\n\020bR\n\\\020b.")
    },
    {
      Text = _xcL("5i\n`zi\020<=\br\029\020\n`4<[\n`iV4`\nNb\\<`!\029`\004=\ni\020`U\na<\n4=b_`e<?ib`e&`eiV4`[\n!!\n\\`>\029?`\v=<^\n\\`e\029\\b`4i\020`=\nib\n\020`=<!!\n\020`\004<\020\020!b`74<b`H<`\020iV4b`H\ne\n\\`\020\029V4`y&!<\nby=iV4`\ni\020`3\vn\b3\n\\<\nb`e<[\ni_`i\020`e\n?`\n\\`ei\n`zi\020<=\004\029\029\\ei<\020b\n\020`\ni\020U\n[\n\020`\004<\020\020A.tjO-5&`?&!!b`ei\\`\004\ni\020\n`\017&\n4\n`U\n[\n\020_`ei\n`ai\020yiU\n`r\029\020\n`y&`[\nb\\\nb\n\020.`C\004bi\029\020\n\020`a\n\\e\n\020`e<e&\\V4`\n4`\020iV4b`<&!U\n=\029\n!b.tjO-CV4b&\020U|`\028V4`?&!!b\n`ei\n`5\029!\n`&?`\027+`V?`>\n\\=\nU\n\020.tjO-C&R`e\n?`nw\029i=\n\\[i=e`a<\n\\\n`!i\n`H\nbyb`<?`&\020b\n\\\n\020`ji=e\\<\020e.tjO-")
    },
    {
      Text = _xcL("5\n\020\004`e\\<\020_`e<!!`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`\ni\020`nw\029i=\n\\\bz\029b\029`[\nRi\020e\nb.`D4\020\n`ei\n!\n!`i!b`\n!`>\n\\?&b=iV4`\nNb\\\n?`!V4a\n\\_`ei\n`5\029!\n`y&`Ri\020e\n\020.tjO-\014\\U<\n\020yb`ai\\e`e<!`z\029b\029`\020\029V4`e&\\V4`\ni\020\n\020`nw\029i=\n\\\b\019\nNb_`e<?ib`e&`<&V4`\ni\020\n`m4<\020V\n`4<!b_`!\029==b\n`e\ni\020`3\n\\<\nb`<&!`i\\U\n\020e\ni\020\n?`3\\&\020e`e<!`z\029b\029`\020iV4b`<\020y\niU\n\020.")
    }
  })
  _rXC:MoveTo(Player)
  _tEN:MoveTo(Player)
end
function _w32:OnEnter()
  _Z3dY = _xcL("paQ(")
  _Urwigo.GlobalZoneEnter()
end
function _0at6:OnEnter()
  _Z3dY = _xcL("p+<b\002")
  _Urwigo.GlobalZoneEnter()
  _0at6.Active = false
  _3_2.Active = false
  _CvVXL.Active = true
  _C_G9.Active = false
  _bHJ.Active = false
  if _kEjQ == true then
    _5sM.Active = true
  end
end
function _rVgz:OnEnter()
  _Z3dY = _xcL("p\\6Uy")
  _Urwigo.GlobalZoneEnter()
  _rVgz.Active = false
  _Urwigo.MessageBox({
    Text = _xcL("\127i\n\\`!\029==b\n!b`e&`e\n\020`\127<&wba\nU`>\n\\=<!!\n\020_`&?`y&?`zi\020<=`>\029\020`nb&R\n`Q`y&`U\n=<\020U\n\020.")
  })
end
function _Xdc:OnEnter()
  _Z3dY = _xcL("p0eV")
  _Urwigo.GlobalZoneEnter()
  _MqId:MoveTo(nil)
  _Xdc.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("DL_`iV4`U=<&[\n`ei\n!\n`C&RU<[\n`a<\\`H\nbyb`<[\n\\`ai\\\004=iV4`\020iV4b`!V4ai\n\\iU`74\029\nV4!b\n\020!`\nba<!`?<b!V4iUA.tjO-5i\n`<\004b&\n==\n`C&RU<[\n`i!b`e<?ib`\n\\R&\n==b.")
    }
  }, function(action)
    _5sM.Active = false
    _0fzmj.Active = true
    _ceLKO()
  end)
end
function _Llejb:OnEnter()
  _Z3dY = _xcL([[
pB=
H[]])
  _Urwigo.GlobalZoneEnter()
end
function _pmrZ:OnEnter()
  _Z3dY = _xcL("pw?\\r")
  _Urwigo.GlobalZoneEnter()
end
function _bHJ:OnEnter()
  _Z3dY = _xcL("p[\127o")
  _Urwigo.GlobalZoneEnter()
end
function _Rv8P:OnEnter()
  _Z3dY = _xcL("pO>\027\v")
  _Urwigo.GlobalZoneEnter()
end
function _2q3:OnEnter()
  _Z3dY = _xcL("p(IQ")
  _Urwigo.GlobalZoneEnter()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("\014iU\n\020b=iV4`a<\\`iV4`e<>\029\020`<&!U\nU<\020U\n\020_`e<!!`e&`[\ni?`9\nUa\ni!\n\\`>\029\\[\ni`\004\029??!b_`<[\n\\`i\\U\n\020eai\n`[i!b`e&`<\020`e\n\\`r\029\020\n`e\\<\020`>\029\\[\ni`U\n=<&R\n\020."),
      Media = _u3tUg
    },
    {
      Text = _xcL("C[\n\\`iV4`4<[\n`>\029\\U\n!\029\\Ub`&\020e`e&`?&!!b`\020iV4b`ai\ne\n\\`4\029V4`y&?`9\nUa\ni!\n\\`!\029\020e\n\\\020`e<\\R!b`ei\\\n\004b`y&`e\n\020`O&i\020\n\020`a\nib\n\\=<&R\n\020.tjO-5i\n`\n\020b!w\\\nV4\n\020e\n`r\029\020\n`i!b`H\nbyb`<\004bi>i\n\\b.")
    }
  }, function(action)
    _Kkc.Active = false
    _2q3.Active = false
    _pQR.Active = true
  end)
end
function _OHy9A:OnEnter()
  _Z3dY = _xcL("pD\127^GC")
  _Urwigo.GlobalZoneEnter()
  _FWV6.Active = false
  _OHy9A.Active = false
  _lIYn.Active = true
  _Urwigo.OldDialog({
    {
      Text = _xcL("\014iU\n\020b=iV4`a<\\`iV4`e<>\029\020`<&!U\nU<\020U\n\020_`e<!!`e&`[\ni?`9\nUa\ni!\n\\`>\029\\[\ni`\004\029??!b_`<[\n\\`i\\U\n\020eai\n`[i!b`e&`<\020`e\n\\`r\029\020\n`e\\<\020`>\029\\[\ni`U\n=<&R\n\020."),
      Media = _u3tUg
    },
    {
      Text = _xcL("C[\n\\`iV4`4<[\n`>\029\\U\n!\029\\Ub`&\020e`e&`?&!!b`\020iV4b`ai\ne\n\\`4\029V4`y&?`9\nUa\ni!\n\\`!\029\020e\n\\\020`e<\\R!b`ei\\\n\004b`y&?`z\\i\ne4\029R`a\nib\n\\=<&R\n\020.tjO-5i\n`\n\020b!w\\\nV4\n\020e\n`r\029\020\n`i!b`H\nbyb`<\004bi>i\n\\b.")
    }
  })
end
function _3FiB:OnClick()
  if _zLo == false then
    _zSv.Active = true
    _OcyF.Active = true
    _bSOL.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("5\ni\020\n`\n\\!b\n`C&RU<[\n`[\n!b\n4b`e<\\i\020_`ei\n`<=b\n`j\\&\nV\004\n`[\ni`C!\n=`y&`&\n[\n\\I&\n\\\n\020.tjO-C[\n\\`\n\\!b`\020<V4e\n?`e&`ei\\`e<!`5\n\020\004?<=`R&\n\\`e\n\020`<=b\n\020`D\\b`<\020U\n!V4<&b`4<!b|")
      },
      {
        Text = _xcL("C\020`\ni\020\n?`!\029\020\020iU\n\020`9\029V4\n\020\n\020e\n`\004<\020\020`4i\n\\`>\n\\?&b=iV4`e\n\\`\019\n&R\n=`=\029!`!\ni\020.tjO-C[\n\\`\004\ni\020\n`C\020U!b_`e&`?&!!b`4i\n\\`\020iV4b!`?<V4\n\020_`a<!`ei\\`w\ni\020=iV4`!\ni\020`\004\029\n\020\020b\n.")
      },
      {
        Text = _xcL("\028V4`4<[\n`ei\\`\ni\020\n\020`\004\029!b\n\020=\029!\n\020`\v<\\\004w=<by`i\020`e\n\\`{<\n4\n`\\<&!U\n!&V4b`7\vvA`&\020e`<&V4`U=\niV4`\ni\020\n`C=b\n\\\020<bi>\n_`R<==!`e\029\\b`\004\ni\020`\v=<by`?\n4\\`!\ni\020`!\029==b\n`7\v(A.")
      },
      {
        Text = _xcL("5i\n`\n\020b!w\\\nV4\n\020e\n\020`r\029\020\n\020`!i\020e`H\nbyb`<\004bi>.tjO-9i\n`[\n\\\nib!`i\020`e\n\020`<==U\n?\ni\020\n\020`\014\\\004=<\n\\&\020U\n\020`<\020U\n!w\\\029V4\n\020_`?&!!b`e&`ei\n`\v<\\\004w=<byy\029\020\n\020`\020iV4b`<&R!&V4\n\020`7\n!`a\n\\e\n\020`e\029\\b`<&V4`\004\ni\020\n`C\004bi\029\020\n\020`<&!U\n=\029\n!b`\b`i!b`ai\\\004=iV4`\020&\\`\ni\020`6\029\\!V4=<U`y&?`\v<\\\004\n\020A.")
      },
      {
        Text = _xcL("z<==!`\n!`i\020`e\n\020`=\nby\n\020`\019<U\n\020`U\n\\\nU\020\nb`4<b_`\004<\020\020`\n!`!\ni\020_`e<!!`e\n\\`9\nU`y&\\`j\\&\nV\004\n`\nba<!`?<b!V4iU`i!b.tjO-\014>\n\020b&\n==`\004\029\n\020\020b\n\020`3&??i!bi\nR\n=`i\020`e\n?`z<==`U<\020y`\020&\nby=iV4`!\ni\020.")
      },
      {
        Text = _xcL("j\nUi[`eiV4`H\nbyb`y&\n\\!b`\ni\020?<=`y&?`C!\n=\b5\n\020\004?<=|"),
        Media = _634J
      }
    })
  else
    _bSOL.Active = true
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
  _zLo = true
end
function _xwq:OnClick()
  if _ghgX == false then
    _OcyF.Active = true
    _syX.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("C=!`\020<\nV4!b\n!`ai==`iV4`ei\\`e\n\020`z\\i\ne4\029R`>\029\020`C=b\bC!\n=`y\niU\n\020.tjO-5i\n!\n\\`U\n4\029\n\\b`ya<\\`\niU\n\020b=iV4`\020iV4b`y&?`\006\014e\n\\!\n\n\bCb=<\020bi!\006_`e<`\n\\`\020i\n`&\n[\n\\R=&b\nb`ai\\e_`<[\n\\`e\n\\`j\n!&V4`!b\n==b`\004\ni\020\n\020`)?a\nU`e<\\`&\020e`ei\n`B\029V<bi\029\020`w<!!b`U&b`y&?`O\n!b`e\n!`94\n\\iU\029!.")
      },
      {
        Text = _xcL("5\ni\020`C&b\029`!\029==b\n!b`e&`U\nU\n[\n\020\n\020R<==!`\020\029V4`&?w<\\\004\n\020.tjO-")
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _uVKJ:OnClick()
  if _6NtP == false then
    _4TV.Active = true
    _41Gfk.Active = true
    _Kkc.Active = true
    _2q3.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("o\nbyb`[\n\004\029??!b`e&`ei\n`O\n!b\n`e\n\\`j\n\\iV4\n\\`\127&\nbb\n`&\020e`e<!`\017\029e\n==`e\n\\`nw\n\\\\?<&\n\\`U\ny\niUb."),
        Media = _RP2
      },
      {
        Text = _xcL("5i\n`[\nie\n\020`\020<\nV4!bU\n=\nU\n\020\n\020`\v<\\\004w=<\nby\n`4<[\n`iV4`ei\\`\\<&!U\n!&V4b.`tjO-z<==!`e&`e\029\\b`\004\ni\020\n\020`\v=<by`?\n4\\`[\n\004\029??\n\020`!\029==b\n!b_`?&!!b`e&`a\0294=`\ni\020`\004=\ni\020`a\n\020iU`a\nib\n\\`=<&R\n\020.")
      },
      {
        Text = _xcL("z<==!`e\n\\`9<!!\n\\!b<\020e`\020iV4b`\nNb\\\n?`\020i\ne\\iU`!\ni\020`!\029==b\n_`ai\\!b`e&`4i\n\\`?ib`!\n4\\`U\\\029!!\n\\`9<4\\!V4\ni\020=iV4\004\nib`R&\n\\`3&??i!bi\nR\n=`!\n4\\`e<\020\004[<\\`!\ni\020.")
      },
      {
        Text = _xcL(")\020e`R<==!`e\n\\`\v\nU\n=!b<\020e`!\029U<\\`\020\029V4`e\n&b=iV4`4\029\n4\n\\`=i\nU\n\020`!\029==b\n`<=!`((+_2+`?_`e<\020\020`\004\029\n\020\020b\n`!\029U<\\`e\n\\`\014i\020!<by`\ni\020\n\\`9<b4\029!\n`i\020`j\nb\\<V4b`\004\029??\n\020.")
      },
      {
        Text = _xcL("j\nUi[`eiV4`H\nbyb`\n\\!b`\ni\020?<=`y&?`9\nUa\ni!\n\\."),
        Media = _u3tUg
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
  _6NtP = true
end
function _0xC:OnClick()
  if _audU0 == false then
    _wR46N.Active = true
    _TZWTn.Active = true
    _F0lou.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("z<==!`e&`?ib`e\n?`C&b\029`&\020b\n\\a\nU!`[i!b_`!\029`\004<\020\020`iV4`ei\\`ya\ni`\v<\\\004w=<\nby\n`\n?wR\n4=\n\020.tjO-\028V4`a&\n\\e\n`ei\\`y&?`\004\029!b\n\020=\029!\n\020`\v<\\\004w=<by`\\<b\n\020_`<&V4`a\n\020\020`e&`e<\020\020`\ni\020`\004=\ni\020`a\n\020iU`?\n4\\`y&`=<&R\n\020`4<!b.tjO-5<R&\n\\`?&!!b`e&`<[\n\\`<&V4`\020iV4b`ei\n`!\n=[\n`nb\\\nV\004\n`4i\020\b`&\020e`y&\\&\nV\004`=<&R\n\020.")
      },
      {
        Text = _xcL("6\029?`\004\029!b\n\020=\029!\n\020`\v<\\\004w=<by`<&!`U\n4b`\n!`ei\\\n\004b`<&R`e\n\\`U\nU\n\020&\n[\n\\=i\nU\n\020e\n\020`nb\\<!!\n\020!\nib\n`\ni\020\n`\004=\ni\020\n`\019\\\nww\n`\\&\020b\n\\.")
      },
      {
        Text = _xcL("9\nib\n\\`U\n4b`\n!_`!\029[<=e`e&`ei\n`O&i\020\n\020`>\029\020`j\n\\iV4`\n\\\\\niV4b`4<!b."),
        Media = _FO3
      }
    })
  else
    _wR46N.Active = true
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
  _audU0 = true
end
function _I0oF:OnClick()
  if _XG6m == false then
    _FWV6.Active = true
    _OHy9A.Active = true
    _euiH2.Active = true
    _Hb3W.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("3=\niV4`ai\\!b`e&`e&`e\n?`<=b\n\020`z\\i\ne4\029R`>\029\020`j\n\\iV4`\ni\020\n\020`j\n!&V4`<[!b<bb\n\020.")
      },
      {
        Text = _xcL("5i\n`[\nie\n\020`<\020U\nU\n[\n\020\n\020`\v<\\\004w=<\nby\n`\004\029!b\n\020`=\nie\n\\`[\nie\n`\nba<!.tjO-5i\n`C&RU<[\n`>\029\\`D\\b`ai\\e`<==\n\\ei\020U!`\020iV4b`<==y&`=<\020U\n`e<&\n\\\020`&\020e`>i\n==\niV4b`\004<\020\020!b`e&`\n!`H<`\\i!\004i\n\\\n\020_`<&R`\ni\020`\v<\\\004biV\004\nb`y&`>\n\\yiV4b\n\020.tjO-C[\n\\`e<!`i!b`e\ni\020\n`\014\020b!V4\nie&\020U.")
      },
      {
        Text = _xcL("5\n\020`U&\n\020!biU!b\n\020`r&U<\020U`y&?`<=b\n\020`z\\i\ne4\029R`4<[\n`iV4`ei\\`<=!`r\029\020\n`?<\\\004i\n\\b."),
        Media = _x8GjC
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _p_T:OnClick()
  if _wvtHg == false then
    if _kEjQ == true then
      if _GIhl == true then
        _Urwigo.Dialog(false, {
          {
            Text = _xcL("9\n\020\020`e&`!V4\029\020`?<=`<?`\014e\n\\!\n\n`[i!b`?\029\nV4b\n!b`e&`>i\n==\niV4b`<&V4`ei\n`nb<&?<&\n\\`\004&\\y`[\n!&V4\n\020_`<&V4`a\n\020\020`e<!`\020iV4b`U<\020y`y&`e\n\020`<\020e\n\\\n\020`D\\b\n\020`w<!!b_`y&`e\n\020\n\020`iV4`eiV4`!\029\020!b`!\029`R&\n4\\\n.")
          }
        }, function(action)
          _Urwigo.MessageBox({
            Text = _xcL("5<`ei\n`nb&R\n`Q`<\004bi>`i!b_`a<\n\\\n`e<!`<&V4`\020&\\`\ni\020`!\n4\\`\004=\ni\020\n\\`C[!b\nV4\n\\."),
            Buttons = {
              _xcL("o<`U\n\\\020\n|"),
              _xcL("\019\\\029bye\n?`\020iV4b|")
            },
            Callback = function(action)
              if action ~= nil then
                if action == "Button1" == true then
                  _bR9()
                else
                  _Urwigo.MessageBox({
                    Text = _xcL("DL_`e<\020\020`\n[\n\020`\020iV4b.tjO-5&`\004<\020\020!b`H\nbyb`U=\niV4`ei\n`\020<\nV4!b\n`C&RU<[\n`<\004bi>i\n\\\n\020.")
                  })
                  _afnxp.Active = true
                  _p_T.Active = false
                end
              end
            end
          })
        end)
      end
    elseif _0NcV == true and _kEjQ == false then
      if _GIhl == true then
        _Urwigo.Dialog(false, {
          {
            Text = _xcL("9\n\020\020`e&`!V4\029\020`?<=`<?`\014e\n\\!\n\n`[i!b`?\029\nV4b\n!b`e&`>i\n==\niV4b`<&V4`ei\n`nb<&?<&\n\\`\004&\\y`[\n!&V4\n\020_`<&V4`a\n\020\020`e<!`\020iV4b`U<\020y`y&`e\n\020`<\020e\n\\\n\020`D\\b\n\020`w<!!b_`y&`e\n\020\n\020`iV4`eiV4`!\029\020!b`!\029`R&\n4\\\n."),
            Buttons = {
              _xcL("o<`U\n\\\020\n|"),
              _xcL("L\ni\020\n`B&!b|")
            }
          }
        }, function(action)
          if action == "Button1" == true then
            _bR9()
          else
            _Urwigo.MessageBox({
              Text = _xcL("DL_`e<\020\020`\n[\n\020`\020iV4b.tjO-5&`\004<\020\020!b`H\nbyb`U=\niV4`ei\n`\020<\nV4!b\n`C&RU<[\n`<\004bi>i\n\\\n\020.")
            })
            _JQtI.Active = true
            _p_T.Active = false
          end
        end)
      end
    elseif _GIhl == true and _0NcV == false and _kEjQ == false then
      _Urwigo.Dialog(false, {
        {
          Text = _xcL("9\n\020\020`e&`!V4\029\020`?<=`<?`\014e\n\\!\n\n`[i!b`?\029\nV4b\n!b`e&`>i\n==\niV4b`<&V4`ei\n`nb<&?<&\n\\`\004&\\y`[\n!&V4\n\020_`<&V4`a\n\020\020`e<!`\020iV4b`U<\020y`y&`e\n\020`<\020e\n\\\n\020`D\\b\n\020`w<!!b_`y&`e\n\020\n\020`iV4`eiV4`!\029\020!b`!\029`R&\n4\\\n."),
          Buttons = {
            _xcL("o<`U\n\\\020\n|"),
            _xcL("L\ni\020\n`B&!b|")
          }
        }
      }, function(action)
        if action == "Button1" == true then
          _bR9()
        else
          _Urwigo.MessageBox({
            Text = _xcL("DL_`e<\020\020`\n[\n\020`\020iV4b.tjO-5&`\004<\020\020!b`H\nbyb`U=\niV4`ei\n`\020<\nV4!b\n`C&RU<[\n`<\004bi>i\n\\\n\020.")
          })
          _3_2.Active = true
          _p_T.Active = false
        end
      end)
    end
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _JQtI:OnClick()
  if _vCk == false then
    _apmiY.Active = false
    _mReoG.Active = false
    _YVBK.Active = true
    _ihg7.Active = true
    _Urwigo.OldDialog({
      {
        Text = _xcL("C=!`\020<\nV4!b\n!`R&\n4\\\n`iV4`\n&V4`y&`e\n?`\014\020e\n`e\n\\`3=\ni!\n`i\020`O\n4[<V4."),
        Media = _Ojk
      },
      {
        Text = _xcL("5&`ai\\!b`\nba<!`y&?`B<\n\020U\n\020?\n!!\n\020`[\n\020\029\nbiU\n\020.")
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.tjO-tjO-De\n\\`Ui[b`\n!`\ni\020`7b\nV4\020i!V4\n!A`\v\\\029[=\n?`&\020e`e&`\004\029??!b`\020iV4b`a\nib\n\\_`a\ni=`y.`j.`\004\ni\020\n`r\029\020\n\020`?\n4\\`<\004bi>`!i\020e;tjO-tjO-5<\020\020`\004=iV\004\n`<&R`e\n\020`\v\\\029[=\n?\bj&bb\029\020`&\020e`[\n!&V4\n`7\020\029V4`\ni\020?<=A`e\n\020`\v\\\n==[\029V\004."),
      Buttons = {
        _xcL("\v\\\029[=\n?"),
        _xcL([[
C==
!`DL]])
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" == true then
            _YVBK.Active = true
          elseif action == "Button2" == true then
            _Urwigo.MessageBox({
              Text = _xcL("DL_`e<\020\020`H\nbyb`\ni\020R<V4`a\nib\n\\?<V4\n\020|")
            })
          end
        end
      end
    })
  end
  _vCk = true
end
function _jBF9t:OnClick()
  if _7aC == false then
    _5hre.Active = true
    _xQO.Active = true
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("{<V4e\n?`e&`!V4\029\020`[\ni?`z\\i\ne4\029R`>\029\020`j\n\\iV4`a<\\!b_`a\n\\e\n`iV4`ei\\`H\nbyb`<&V4`\020\029V4`e\n\020`z\\i\ne4\029R`>\029\020`C=b\bj\\i\020U4<&!\n\020`y\niU\n\020.")
      }
    }, function(action)
      if _GIhl == false and _0NcV == true and _kEjQ == false then
        _cJX.Active = true
        _Urwigo.MessageBox({
          Text = _xcL("5\n\020`R&\n\\`eiV4`U&\n\020!biU!b\n\020`\v<\\\004w=<by`4<[\n`iV4`?<\\\004i\n\\b.")
        })
      else
        _C_G9.Active = true
        _bHJ.Active = true
        _Urwigo.Dialog(false, {
          {
            Text = _xcL("5\n\\`\v<\\\004w=<by_`e\n\020`iV4`ei\\`?<\\\004i\n\\b`4<[\n_`i!b`\020iV4b`e\n\\`\020<\nV4!bU\n=\nU\n\020\n`!\029\020e\n\\\020`\niU\n\020b=iV4`e\n\\`R&\n\\`ei\n`<\020!V4=i\n!!\n\020e\n`C&RU<[\n.tjO-n\029`!w<\\!b`e&`ei\\`H\ne\029V4`e<!`)?w<\\\004\n\020`&\020e`\004<\020\020!b`ei\\\n\004b`>\029?`z\\i\ne4\029R`y&\\`\020<\nV4!b\n\020`C&RU<[\n`!w<yi\n\\\n\020`7i\020!U\n!<?b`e<4\n\\`e\n&b=iV4`a\n\020iU\n\\`y&`=<&R\n\020A.tjO-")
          }
        }, function(action)
          if _kEjQ == true then
            _Urwigo.OldDialog({
              {
                Text = _xcL(")\020e`iV4`a&\n\\e\n`e\\i\020U\n\020e`e<y&`\\<b\n\020_`H\nbyb`!V4\029\020`?<=`e\ni\020\n`3&??i!bi\nR\n=`<\020y&yi\n4\n\020.tjO-\028\020![\n!\029\020e\n\\\n`[\ni`e\n\\`=\nbyb\n\020`C&RU<[\n_`ei\n`<&R`eiV4`a<\\b\nb_`\004\029\n\020\020b\n`\n!`!\n4\\`?<b!V4iU`a\n\\e\n\020`7a<\\`y&?i\020e\n!b`[\ni`?\ni\020\n?`j\n!&V4`e\n\\`z<==A`&\020e`e&`\004\029??!b`>\029\\4\n\\`\020iV4b`ai\ne\n\\`[\ni?`C&b\029`>\029\\[\ni.")
              }
            })
          else
            _Urwigo.OldDialog({
              {
                Text = _xcL("6\n\\?&b=iV4`\004\029\n\020\020b\n`\n!`!V4=<&`!\ni\020_`!V4\029\020`?<=`H\nbyb`e\ni\020\n`3&??i!bi\nR\n=`<\020y&yi\n4\n\020.tjO-5\n\\`9\nU`y&?`z\\i\ne4\029R`i!b`>\n\\?&b=iV4`\004\ni\020`\v\\\029[=\n?_`<[\n\\`e\n\\`9\nU`>\029\020`e\n\\`=\nbyb\n\020`C&RU<[\n`y&\\&\nV\004`y&?`\v<\\\004w=<by`\004\029\n\020\020b\n`\nba<!`?<b!V4iU`!\ni\020.`3\n4b`>\n\\?&b=iV4`<[\n\\`<&V4`?ib`\020\029\\?<=\n\020`nV4&4\n\020_`<[\n\\`iV4`\004<\020\020`\020iV4b!`U<\\<\020bi\n\\\n\020.")
              }
            })
          end
        end)
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _3_2:OnClick()
  if _GAck == false then
    _C_G9.Active = true
    _bHJ.Active = true
    _6ky.Active = true
    _0at6.Active = true
    if _0NcV == false then
      _Llejb.Active = true
      _pmrZ.Active = true
    end
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C=!`\020<\nV4!b\n!`R&\n4\\b`eiV4`ei\n!\n\\`94\n\\iU\029`y&\\`!\029U\n\020<\020\020b\n\020`Bi\n[\n!i\020!\n=.")
      },
      {
        Text = _xcL("5\029\\b`\004<\020\020!b`e&`&\020b\n\\`<\020e\n\\\n?`\ni\020\n`V<.`2++`o<4\\\n`<=b\n`\019\\<&[\n\020\niV4\n`[\na&\020e\n\\\020_`ei\n`<&R`\ni\020\n\\`z\n=!!wiby\n`a<\nV4!b."),
        Media = _46Kq
      },
      {
        Text = _xcL("O&i\020\n\020`Ui[b`\n!`<[\n\\`<&V4`y&`\n\020be\nV\004\n\020.tjO-j\ni`<[!\029=&b\n\020`\127\029V4!b<\020e`i?`\014e\n\\!\n\n`=i\nU\n\020`ei\n`&\020b\n\\\n\020`\019\ni=\n`ei\n!\n\\`O&i\020\n\020`a\0294=`&\020b\n\\`9<!!\n\\."),
        Media = _tTBe
      }
    }, function(action)
      if _0NcV == false and _kEjQ == false then
        _Urwigo.MessageBox({
          Text = _xcL("\017<\020V4?<=`i!b`e\n\\`9\nU`y&\\`Bi\n[\n!i\020!\n=`!b\n==\n\020a\ni!\n`\nba<!`?<b!V4iU`&\020e`3&??i!bi\nR\n=`\004\029\n\020\020b\n\020`w\\<\004bi!V4`!\ni\020.tjO-9<4\\!V4\ni\020=iV4`U\n4b`\n!`<[\n\\`<&V4`\0294\020\n_`i\020![\n!\029\020e\n\\\n`a\n\020\020`e&`eiV4`R&\n\\`e\n\020`4i\020b\n\\\n\020`r&U<\020U`\n\020b!V4\nie\n!b.")
        })
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _5sM:OnClick()
  _0at6.Active = false
  if _SdDiw == false then
    _C_G9.Active = true
    _bHJ.Active = true
    _ybh6.Active = true
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C=b\bj\\i\020U4<&!\n\020`a<\\`?ib`\nba<`G++`\014i\020a\0294\020\n\\\020`e<!`U\\\029\n!!b\n`e\n\\`e\\\ni`5\029\n\\R\n\\_`a\n=V4\n`e\n?`\014e\n\\!\n\n`a\niV4\n\020`?&!!b\n\020."),
        Media = _5yR71
      },
      {
        Text = _xcL("5\n\\`)?y&U`e\n\\`\n4\n?<=iU\n\020`j\na\0294\020\n\\`i\020`i4\\\n`\020\n&\n`\127\ni?<b`y\029U`!iV4`e<?<=!`&\n[\n\\`!\nV4!`o<4\\\n`4i\020.tjO-5i\n`v22`3\n[<\n&e\n`a&\\e\n\020`<==\n\\ei\020U!`<\020`\ni\020\n?`\ni\020yiU\n\020`\019<U`e\n?`\014\\e[\029e\n\020`U=\niV4`U\n?<V4b."),
        Media = _6zi
      },
      {
        Text = _xcL("o\nbyb`!\029==b\n!b`e&`eiV4`<&R?<V4\n\020_`ei\n`O&i\020\n\020`y&`\n\\\004&\020e\n\020.")
      }
    }, function(action)
      if _GIhl == false and _0NcV == false and _kEjQ == true then
        _Urwigo.MessageBox({
          Text = _xcL("\014>\n\020b&\n==`\004\029\n\020\020b\n`\n!`<&!U\n!w\\\029V4\n\020`!i\020\020>\029==`!\ni\020_`R&\n\\`ei\n!\n`&\020e`i\020![\n!\029\020e\n\\\n`ei\n`\020<\nV4!b\n`C&RU<[\n_`ei\n`U=\niV4`i?`C\020!V4=&!!`\004\029??b_`3&??i!bi\nR\n=`<\020y&yi\n4\n\020.tjO-j\ni`?\ni\020\n?`\niU\n\020\n\020`j\n!&V4`>\029\\`D\\b`a<\n\\\n`iV4`\0294\020\n`3&??i!bi\nR\n`<&R`H\ne\n\020`z<==`>\029==\004\029??\n\020`<&RU\n!V4?i!!\n\020`U\na\n!\n\020_`<[\n\\`>i\n==\niV4b`!i\n4b`e<!`4\n&b\n`>\029\\`D\\b`<&V4`U<\020y`<\020e\n\\!`<&!.")
        })
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _0fzmj:OnClick()
  if _6rY == false then
    _lOan.Active = true
    _q88p:MoveTo(Player)
    _Urwigo.OldDialog({
      {
        Text = _xcL(")\020e`H\nbyb`\004\029??b`!V4\029\020`ei\n`<==\n\\=\nbyb\n`C&RU<[\n_`ei\n`e&`\n\\R&\n==\n\020`?&!!b_`&?`ei\n`zi\020<=\004\029\029\\ei\020<b\n\020`e\n\\`nb&R\n`Q`y&`[\n\004\029??\n\0208tjO-tjO-nV4<&\n`ei\\`ei\n`O\n!b\n`e\n\\`<=b\n\020`j\\&\nV\004\n`>\029\020`C=b\bj\\i\020U4<&!\n\020`\020<V4`nV4\nie`U<\020y`<&!`e\n\\`{<\n4\n`<\020."),
        Media = _LwqV
      },
      {
        Text = _xcL("C=!`iV4`>\029\\`D\\b`a<\\_`&?`ei\n!\n\020`94\n\\iU\029`>\029\\y&[\n\\\nib\n\020_`a<\\`e\n\\`9\nU`y&`e\n\\`r\029\020\n_`ei\n`e&`U=\niV4`<&R!&V4\n\020`?&!!b_`>\n\\e<??b`?<b!V4iU`&\020e`iV4`[i\020`?ib`?\ni\020\n\020`3&??i!bi\nR\n=\020`<\020`>i\n=\n\020`nb\n==\n\020`U<\020y`!V4\029\n\020`i?`\017<b!V4`>\n\\!&\020\004\n\020`7i??\n\\`?ib`e\n\\`C\020U!b_`e<!!`iV4`?<=`y&`bi\nR`>\n\\!i\020\004\n`\029e\n\\`y&?i\020e\n!b`?iV4`>\029==`<&R`ei\n`z\\\n!!\n`=\nU\n`&\020e`e<\020<V4`ai\n`\ni\020`nV4=<???\029\020!b\n\\`<&!!\n4\nA.`tjO-\028!b`<[\n\\`<==\n!`U&b`U\nU<\020U\n\020`&\020e`>i\n==\niV4b`a<\\`\n!`<&V4`\020&\\`!\029`?<b!V4iU_`a\ni=`\n!`ei\n`\019<U\n`y&>\029\\`>i\n=`U\n\\\nU\020\nb`4<b.")
      },
      {
        Text = _xcL("\028V4`4<[\n`ji=e\n\\`i?`{\nby`U\nR&\020e\n\020_`e<`!<4`\n!`!\029`<&!_`<=!`\029[`e\n\\`9\nU`y&`e\n\020`j\\&\nV\004\n\020\\\n!b\n\020`\004\ni\020`nb&\nV\004`?<b!V4iU`a<\n\\\n.tjO-9<\\\n\020`<[\n\\`a\0294=`<==\n`<&!`e\n?`o<4\\\n`(++Q_`a\029`e\n\\`9<!!\n\\!b<\020e`ai\\\004=iV4`\nNb\\\n?`\020i\ne\\iU`a<\\.tjO-C[\n\\`>i\n==\niV4b`4<!b`e&`H<`3=&\nV\004`&\020e`?&!!b`\020iV4b`?ib`e\n?`\017<b!V4`\004<\n?wR\n\020`7<[4<\n\020UiU`>\029?`{i\ne\n\\!V4=<U`e\n\\`=\nbyb\n\020`\019<U\n_`e\n?`<\004b&\n==\n\020`\v\nU\n=!b<\020e`&\020e`>\029\\`<==\n\020_`e\n\\`5<&\n\\_`ai\n`=<\020U\n`e\n\\`n\n\nU\\&\020e`!V4\029\020`b\\\029V\004\n\020`U\nR<==\n\020`i!bA.tjO-")
      }
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _afnxp:OnClick()
  if _D5QbZ == false then
    _gSx1.Active = true
    _Aqu8.Active = true
    _EsK.Active = true
    _SdqT.Active = true
    _IyQ.Active = true
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C=!`\020<\nV4!b\n!`?&!!b`e&`\ni\020\n\020`=<\n\020U\n\\\n\020`nw<yi\n\\U<\020U`y&?`\127\029wR\n\020[\n\\U`&\020b\n\\\020\n4?\n\020`&\020e`ei\n!\n\020`\n\\\004=i??\n\020.")
      }
    }, function(action)
      if _SHf2 == true then
        _Urwigo.MessageBox({
          Text = _xcL("5<`e&`ei\\`>\029\\4i\020`ei\n`nb<&?<&\n\\`<\020U\n!V4<&b`4<!b_`!\029==b\n`e\ni\020`C&b\029`7!\029R\n\\\020`e&`?ib`\ni\020\n?`!\029=V4\n\020`&\020b\n\\a\nU!`[i!bA`[\n\\\nib!`<?`\\iV4biU\n\020`D\\b`!b\n4\n\020."),
          Callback = function(action)
            if action ~= nil and _GIhl == true and _0NcV == true and _kEjQ == true then
              _Urwigo.MessageBox({
                Text = _xcL("B<&b`\014\\R<4\\&\020U![\n\\iV4b\n\020`>\029\020`<\020e\n\\\n\020`m<V4\n\\\020`!\029==b\nb!b`e&`H\nbyb`&\n[\\iU\n\020!`y\nib=iV4`U\n!\n4\n\020`){3\014zC\014\127O`ei\n`\127<\n=Rb\n`e\n!`94\n\\iU\029!`7U\na<\n4=b`!i\020e`<==\n`e\\\ni`nb&R\n\020A`U\n!wi\n=b`4<[\n\020.tjO-\028V4`4\029RR\n_`e<!!`e<!`\004\ni\020`<==y&`U\\\029?\n\\`nV4\029V\004`R&\n\\`eiV4`i!b`&\020e`e&`U\n4\029RRb`4<bb\n!b_`U=\niV4`R\n\\biU`y&`!\ni\020.")
              })
            end
          end
        })
      else
        _Urwigo.Dialog(false, {
          {
            Text = _xcL("\017<\020`\004<\020`=\nie\n\\`\020iV4b`\020<4`<?`\127\029wR\n\020[\n\\U`w<\\\004\n\020_`!\029`e<!!`H\nbyb`\ni\020`\nba<!`=<\n\020U\n\\\n\\`nw<yi\n\\U<\020U`<&R`eiV4`y&`\004\029??b.tjO-\028V4`4<[\n`ya\ni`\v<\\\004?\029\nU=iV4\004\nib\n\020`R&\n\\`eiV4`?<\\\004i\n\\b.")
          },
          {
            Text = _xcL("\028\020`e\n\020`ei\\\n\004b`!&\ne=iV4`e\n\\`nb<&?<&\n\\`U\n=\nU\n\020\n\020`D\\b!b\ni=`\006\014e\n\\!\n\n\006`e<\\R`?<\020`\020&\\`<=!`C\020a\0294\020\n\\`\029e\n\\`z\n\\i\n\020U<!b`?ib`e\n?`C&b\029`\\\ni\020R<4\\\n\020.")
          },
          {
            Text = _xcL("C==\n`<\020e\n\\\n\020`?&\n!!\n\020`i4\\`C&b\029`<&R`e\n?`U\\\029!!\n\020`\v<\\\004w=<by`<?`D\\b!\ni\020U<\020U`<[!b\n==\n\020.")
          },
          {
            Text = _xcL("n\029==b\n!b`[i!4\n\\`\020\029V4`\020iV4b`[\n\\\nib`U\na\n!\n\020`!\ni\020_`ei\\`\ni\020`\v<\\\004biV\004\nb`y&`\004<&R\n\020`&\020e`<&V4`4i\n\\`U\n\\\020\n`e<\\<&R`>\n\\yiV4b\n\020_`<[\n\\`<&V4`\020iV4b`e<!`Oi!i\004\029`\ni\020U\n4\n\020`a\029==\n\020_`\ni\020`L\020\029\n==V4\n\020`a\nU\n\020`R\n4=\n\020e\n?`\v<\\\004biV\004\nb`y&`[\n\004\029??\n\020_`!\029`\004\029\n\020\020b\n!b`e&`\020<b&\n\\=iV4`\ni\020R<V4`!\029`b&\020_`<=!`a\n\020\020`e&`[\n\\\nV4biUb`a<\n\\!b_`i\020`e\n\020`D\\b`y&`R<4\\\n\020.")
          },
          {
            Text = _xcL("z<==!`e&`<=!\029`ei\n`\004\029!b\n\020=\029!\n`\v<\\\004w=<by<=b\n\\\020<bi>\n`<\020!b\n&\n\\\020`ai==!b_`!\029`!\029==b\n!b`e&`\020<V4`e\n?`\029RRiyi\n==\n\020`\v<\\\004w=<by`ei\n`\n\\!b\n`nb\\<!!\n`\020\n4?\n\020_`ei\n`\020<V4`=i\020\004!`<[U\n4b`7\006C?`3\\<[\n\020\006A`&\020e`ei\n!\n`[i!`y&?`\014\020e\n`R<4\\\n\020.tjO-C?`ri\n=`i!b`\v=<by`R&\n\\`e\\\ni`\029e\n\\`>i\n\\`C&b\029!."),
            Media = _lsf
          }
        }, function(action)
          if _GIhl == true and _0NcV == true and _kEjQ == true then
            _Urwigo.MessageBox({
              Text = _xcL("B<&b`\014\\R<4\\&\020U![\n\\iV4b\n\020`>\029\020`<\020e\n\\\n\020`m<V4\n\\\020`!\029==b\nb!b`e&`H\nbyb`&\n[\\iU\n\020!`y\nib=iV4`U\n!\n4\n\020`){3\014zC\014\127O`ei\n`\127<\n=Rb\n`e\n!`94\n\\iU\029!`7U\na<\n4=b`!i\020e`<==\n`e\\\ni`nb&R\n\020A`U\n!wi\n=b`4<[\n\020.tjO-\028V4`4\029RR\n_`e<!!`e<!`\004\ni\020`<==y&`U\\\029?\n\\`nV4\029V\004`R&\n\\`eiV4`i!b`&\020e`e&`U\n4\029RRb`4<bb\n!b_`U=\niV4`R\n\\biU`y&`!\ni\020.")
            })
          end
        end)
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("5&`4<!b`ei\n!\n`C&RU<[\n`e\029V4`!V4\029\020`<\020U\n\004=iV\004b.tjO-9<!`y&`b&\020`i!b_`!\029==b\n`\004=<\\`!\ni\020.tjO-C\020!\029\020!b\n\020`\ni\020R<V4`ei\n`\020<\nV4!b\n`r\029\020\n`<&R!&V4\n\020.")
    })
  end
end
function _CvVXL:OnClick()
  if _5sM.Active == true or _0fzmj.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\014!`a<\n\\\n`e\n&b=iV4`!V4=<&\n\\_`e<!`zi\020<=`e\n\\`nb&R\n`v`\n\\!b`<&Ry&!&V4\n\020_`\020<V4e\n?`e&`ei\n`\\\n!b=iV4\n\020`\014e\n\\!\n\n\bCb=<\020bi!\bC&RU<[\n\020`\n\\=\neiUb`4<!b.")
      },
      {
        Text = _xcL("C\020\029\020!b\n\020`ai\\e`e<!`\ni\020`yi\n?=iV4\n!`O&?U\nU&\\\004\n."),
        Buttons = {
          _xcL("C&R`y&?`zi\020<="),
          _xcL("5\029V4`\020\029V4`\020iV4b")
        }
      }
    }, function(action)
      if action == "Button1" then
        _Urwigo.MessageBox({
          Text = _xcL("5&`ai\\!b`!V4\029\020`e\ni\020\n`3\\&\n\020e\n`4<[\n\020."),
          Callback = function(action)
            if action ~= nil then
              _Dg7bB()
            end
          end
        })
      end
    end)
  else
    _Dg7bB()
  end
end
function _WWB:OnClick()
  if _3_2.Active == true or _5sM.Active == true or _0fzmj.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\014!`a<\n\\\n`e\n&b=iV4`!V4=<&\n\\_`e<!`zi\020<=`e\n\\`nb&R\n`(`\n\\!b`<&Ry&!&V4\n\020_`\020<V4e\n?`e&`ei\n`\\\n!b=iV4\n\020`\014e\n\\!\n\n\bCb=<\020bi!\bC&RU<[\n\020`\n\\=\neiUb`4<!b.")
      },
      {
        Text = _xcL("C\020\029\020!b\n\020`ai\\e`e<!`\ni\020`yi\n?=iV4\n!`O&?U\nU&\\\004\n."),
        Buttons = {
          _xcL("C&R`y&?`zi\020<="),
          _xcL("5\029V4`\020\029V4`\020iV4b")
        }
      }
    }, function(action)
      if action == "Button1" then
        _Urwigo.MessageBox({
          Text = _xcL("5&`ai\\!b`!V4\029\020`e\ni\020\n`3\\&\n\020e\n`4<[\n\020."),
          Callback = function(action)
            if action ~= nil then
              _WIXAQ()
            end
          end
        })
      end
    end)
  else
    _WIXAQ()
  end
end
function _Ube:OnClick()
  _bvL5P()
end
function _YIDHU:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _eohTA = input
  if Wherigo.NoCaseEquals(_eohTA, _xcL([[
nb&R
`v]])) then
    _GIhl = true
  elseif Wherigo.NoCaseEquals(_eohTA, _xcL([[
nb&R
`(]])) then
    _0NcV = true
  elseif Wherigo.NoCaseEquals(_eohTA, _xcL([[
nb&R
`Q]])) then
    _kEjQ = true
  elseif Wherigo.NoCaseEquals(_eohTA, _xcL("nb&R\n`v`&\020e`(")) then
    _GIhl = true
    _0NcV = true
    _MKBn:MoveTo(Player)
  elseif Wherigo.NoCaseEquals(_eohTA, _xcL("nb&R\n`(`&\020e`Q")) then
    _0NcV = true
    _kEjQ = true
    _MKBn:MoveTo(Player)
  elseif Wherigo.NoCaseEquals(_eohTA, _xcL("nb&R\n`v_`(`&\020e`Q")) then
    _GIhl = true
    _0NcV = true
    _kEjQ = true
    _MKBn:MoveTo(Player)
  end
  _Urwigo.Dialog(false, {
    {
      Text = (_xcL([[
5&`4<!b`eiV4`R&
\`]]) .. _eohTA) .. _xcL("`\n\020b!V4i\ne\n\020.")
    },
    {
      Text = _xcL("j\n>\029\\`e&`eiV4`H\nbyb`<\020`ei\n`\014\\R&\n==&\020U`e\n\\`\n\\!b\n\020`C&RU<[\n`?<V4!b_`ei\n!\n`[ibb\n`R&\n\\`a\nib\n\\\n`\014i\020y\n=4\nib\n\020`&\020e`y&\\`C\004bi>i\n\\&\020U`e\n\\`\n\020b!w\\\nV4\n\020e\n\020`r\029\020\n\020`&\020[\nei\020Ub`\n\\!b`\ni\020?<=`<\020\004=iV\004\n\020.")
    }
  }, function(action)
    _RP8U4()
  end)
end
function _P8jN:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _GoeB = input
  if Wherigo.NoCaseEquals(_GoeB, _xcL("vQv\016")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5<!`a<\\`\020<b&\n\\=iV4`ei\n`\\iV4biU\n`C\020ba\029\\b.`C[\n\\`4i\n\\`\004<\020\020`a\0294=`\n4`\004<&?`H\n?<\020e`\n\\\020!b4<Rb`\ni\020\n\020`z\n4=\n\\`?<V4\n\020.")
      },
      {
        Text = _xcL("o\nbyb`U\ne\n\020\004\n`\020\029V4`\004&\\y`e\n\\`<\\?\n\020`B\n&b\n_`ei\n`4i\n\\`i4\\`>\029\\`&\n[\n\\`v++`o<4\\\n\020`i4\\`\127\ni?<be\029\\R`>\n\\=<!!\n\020`?&!!b\n\020_`[\n>\029\\`\n!`>\029\020`L<i!\n\\=iV4\n\020`\vi\029\020i\n\\\n\020`U\n!w\\\n\020Ub`a&\\e\n.tjO-")
      },
      {
        Text = _xcL("C&R`ei\n!\n?`ji=e`!i\n4b`?<\020`ei\n`>\n\\!<??\n=b\n`5\029\\RU\n?\ni\020!V4<Rb`\020<V4`e\n?`=\nbyb\n\020`3\029bb\n!ei\n\020!b`>\029\\`e\n\\`)?!i\ne=&\020U."),
        Media = _Kn_B
      },
      {
        Text = _xcL("o\nbyb`?<V4\n`eiV4`<&R_`&?`ei\n`<=b\n`j\\&\nV\004\n`y&`&\n[\n\\I&\n\\\n\020."),
        Media = _CLtw2
      }
    }, function(action)
      _bSOL.Active = false
      _35_a.Active = true
    end)
  elseif Wherigo.NoCaseEquals(_GoeB, _xcL("vGv\023")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\127<!b`e&`ei\n`z\\<U\n`\020iV4b`>\n\\!b<\020e\n\020;`\028V4`4<[\n`\020<V4`e\n?`3\\&\n\020e&\020U!e<b&?`U\nR\\<Ub|")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _bSOL.Active = true
    end)
  elseif Wherigo.NoCaseEquals(_GoeB, _xcL("vQv\023")) or Wherigo.NoCaseEquals(_GoeB, _xcL("v2v\023")) or Wherigo.NoCaseEquals(_GoeB, _xcL("v2v\016")) or Wherigo.NoCaseEquals(_GoeB, _xcL("vGv\016")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("j\\<&V4!b`e&`\ni\020\n`j\\i==\n_`\029e\n\\`a<!;")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _bSOL.Active = true
    end)
  end
end
function _FucO:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _H1H1 = input
  if _H1H1 == _xcL("{C\019)O\b5\014{L\017CB") then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("L<\020\020`e&`\n!`<&V4`\020iV4b`=\nie\n\020_`a\n\020\020`e&`ei\\`[\ni`\ni\020\n\\`z\\<U\n!b\n==&\020U_`ei\n`!iV4`\ni\020`Da\020\n\\`<&!U\ne<V4b`4<b_`[\ni`i\\U\n\020ea\n=V4\n\020`L=\ni\020iU\004\nib\n\020_`ei\n`<[\n\\`>i\n==\niV4b`aiV4biU`!i\020e_`\020iV4b`!iV4\n\\`[i!b_`a<!`e\n\\`Da\020\n\\`U\n\020<&`ai!!\n\020`ai==;")
      },
      {
        Text = _xcL("\017&!!b\n`?<\020`4i\n\\`ei\n`3\\\029!!\b`&\020e`L=\ni\020!V4\\\ni[&\020U`[\n<V4b\n\020;")
      },
      {
        Text = _xcL(")\020e`a<!`i!b`?ib`e\n?`ji\020e\n!b\\iV4;tjO-\017&!!b\n`?<\020`e\n\020`<&V4`?ib`\ni\020U\n[\n\020`\029e\n\\`a\nU=<!!\n\020;")
      },
      {
        Text = _xcL("9<\\&?`\004\029\020\020b\n`e\n\\`Da\020\n\\`!iV4`\004\ni\020\n`\ni\020e\n&biU\n\\\n`z\\<U\n`<&!e\n\020\004\n\020;")
      },
      {
        Text = _xcL("5&`4<!b`eiV4`<=!\029`\n\020b!V4i\ne\n\020_`ei\n`3\\\029!![&V4!b<[\n\020`&\020e`<&V4`e\n\020`ji\020e\n!b\\iV4`y&`&\n[\n\\\020\n4?\n\020.")
      },
      {
        Text = _xcL("5i\\`i!b`<[\n\\`!V4\029\020`\004=<\\_`e<!!`e\n\\`ji\020e\n!b\\iV4`<&R`e\n?`nV4i=e`\020&\\`e\n!4<=[`[\n\020&byb`ai\\e_`a\ni=`e<!`9\029\\b`\020iV4b`i\020`\ni\020\n`r\ni=\n`w<!!b_`\029e\n\\;")
      },
      {
        Text = _xcL("C[\n\\`iV4`ai==`?<=`\020iV4b`!\029`!\ni\020`&\020e`e\ni\020\n`C\020ba\029\\b`U\n=b\n\020`=<!!\n\020.")
      },
      {
        Text = _xcL("C&RU<[\n`\n\\R\029=U\\\niV4`U\n?\ni!b\n\\b`&\020e`ei\n`\020<\nV4!b\n`\004<\020\020`H\nbyb`<\004bi>i\n\\b`a\n\\e\n\020.")
      }
    }, function(action)
      _xwq.Active = false
      _syX.Active = false
      _OcyF.Active = false
      if _kEjQ == true then
        _uVKJ.Active = true
      else
        _0xC.Active = true
      end
      _ceLKO()
    end)
  elseif _H1H1 == _xcL("{C\019)O5\014{L\017CB") then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("L<\020\020`e&`\n!`<&V4`\020iV4b`=\nie\n\020_`a\n\020\020`e&`ei\\`[\ni`\ni\020\n\\`z\\<U\n!b\n==&\020U_`ei\n`!iV4`\ni\020`Da\020\n\\`<&!U\ne<V4b`4<b_`[\ni`i\\U\n\020ea\n=V4\n\020`L=\ni\020iU\004\nib\n\020_`ei\n`<[\n\\`>i\n==\niV4b`aiV4biU`!i\020e_`\020iV4b`!iV4\n\\`[i!b_`a<!`e\n\\`Da\020\n\\`U\n\020<&`ai!!\n\020`ai==;")
      },
      {
        Text = _xcL("\017&!!b\n`?<\020`4i\n\\`ei\n`3\\\029!!\b`&\020e`L=\ni\020!V4\\\ni[&\020U`[\n<V4b\n\020;")
      },
      {
        Text = _xcL(")\020e`a<!`i!b`?ib`e\n?`ji\020e\n!b\\iV4;tjO-\017&!!b\n`?<\020`e\n\020`<&V4`?ib`\ni\020U\n[\n\020`\029e\n\\`a\nU=<!!\n\020;")
      },
      {
        Text = _xcL("9<\\&?`\004\029\020\020b\n`e\n\\`Da\020\n\\`!iV4`\004\ni\020\n`\ni\020e\n&biU\n\\\n`z\\<U\n`<&!e\n\020\004\n\020;")
      },
      {
        Text = _xcL("5&`4<!b`eiV4`<=!\029`e<y&`\n\020b!V4i\ne\n\020_`ei\n`3\\\029!!!V4\\\ni[&\020U`y&`&\n[\n\\\020\n4?\n\020_`<[\n\\`e\n\020`ji\020e\n!b\\iV4`a\nUy&=<!!\n\020.")
      },
      {
        Text = _xcL("\028V4`e\n\020\004\n_`iV4`w\n\\!\029\n\020=iV4`4<\nbb\n`?iV4`<&V4`R&\n\\`ei\n!\n`6<\\i<\020b\n`\n\020b!V4i\ne\n\020.")
      },
      {
        Text = _xcL("C&RU<[\n`\n\\R\029=U\\\niV4`U\n?\ni!b\n\\b`&\020e`ei\n`\020<\nV4!b\n`\004<\020\020`H\nbyb`<\004bi>i\n\\b`a\n\\e\n\020.")
      }
    }, function(action)
      _xwq.Active = false
      _syX.Active = false
      _OcyF.Active = false
      if _kEjQ == true then
        _uVKJ.Active = true
      else
        _0xC.Active = true
      end
      _ceLKO()
    end)
  elseif _H1H1 == _xcL("{<b&\\e\n\020\004?<=") then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("L<\020\020`e&`\n!`<&V4`\020iV4b`=\nie\n\020_`a\n\020\020`e&`ei\\`[\ni`\ni\020\n\\`z\\<U\n!b\n==&\020U_`ei\n`!iV4`\ni\020`Da\020\n\\`<&!U\ne<V4b`4<b_`[\ni`i\\U\n\020ea\n=V4\n\020`L=\ni\020iU\004\nib\n\020_`ei\n`<[\n\\`>i\n==\niV4b`aiV4biU`!i\020e_`\020iV4b`!iV4\n\\`[i!b_`a<!`e\n\\`Da\020\n\\`U\n\020<&`ai!!\n\020`ai==;")
      },
      {
        Text = _xcL("\017&!!b\n`?<\020`4i\n\\`ei\n`3\\\029!!\b`&\020e`L=\ni\020!V4\\\ni[&\020U`[\n<V4b\n\020;")
      },
      {
        Text = _xcL(")\020e`a<!`i!b`?ib`e\n?`ji\020e\n!b\\iV4;tjO-\017&!!b\n`?<\020`e\n\020`<&V4`?ib`\ni\020U\n[\n\020`\029e\n\\`a\nU=<!!\n\020;")
      },
      {
        Text = _xcL("9<\\&?`\004\029\020\020b\n`e\n\\`Da\020\n\\`!iV4`\004\ni\020\n`\ni\020e\n&biU\n\\\n`z\\<U\n`<&!e\n\020\004\n\020;")
      },
      {
        Text = _xcL("C&R`e\n\020`<==\n\\?\ni!b\n\020`nV4i=e\n\\\020`ei\n!\n\\`C\\b`!b\n4b`b<b!<\nV4=iV4`\006{<b&\\e\n\020\004?<=\006.tjO-C[\n\\`4i\n\\`!b\n4b`\niU\n\020b=iV4`\006{C\019)O5\014{L\017CB\006`[ya.`\006{C\019)O\b5\014{L\017CB\006.")
      },
      {
        Text = _xcL("C[\n\\`e\ni\020\n`C\020ba\029\\b`=<!!\n`iV4`b\\\029bye\n?`U\n=b\n\020.tjO-")
      },
      {
        Text = _xcL("C&RU<[\n`\n\\R\029=U\\\niV4`U\n?\ni!b\n\\b`&\020e`ei\n`\020<\nV4!b\n`\004<\020\020`H\nbyb`<\004bi>i\n\\b`a\n\\e\n\020.")
      }
    }, function(action)
      _xwq.Active = false
      _syX.Active = false
      _OcyF.Active = false
      if _kEjQ == true then
        _uVKJ.Active = true
      else
        _0xC.Active = true
      end
      _ceLKO()
    end)
  elseif _H1H1 == _xcL("{<b&\\\b5\n\020\004?<=") then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("L<\020\020`e&`\n!`<&V4`\020iV4b`=\nie\n\020_`a\n\020\020`e&`ei\\`[\ni`\ni\020\n\\`z\\<U\n!b\n==&\020U_`ei\n`!iV4`\ni\020`Da\020\n\\`<&!U\ne<V4b`4<b_`[\ni`i\\U\n\020ea\n=V4\n\020`L=\ni\020iU\004\nib\n\020_`ei\n`<[\n\\`>i\n==\niV4b`aiV4biU`!i\020e_`\020iV4b`!iV4\n\\`[i!b_`a<!`e\n\\`Da\020\n\\`U\n\020<&`ai!!\n\020`ai==;")
      },
      {
        Text = _xcL("\017&!!b\n`?<\020`4i\n\\`ei\n`3\\\029!!\b`&\020e`L=\ni\020!V4\\\ni[&\020U`[\n<V4b\n\020;")
      },
      {
        Text = _xcL(")\020e`a<!`i!b`?ib`e\n?`ji\020e\n!b\\iV4;tjO-\017&!!b\n`?<\020`e\n\020`<&V4`?ib`\ni\020U\n[\n\020`\029e\n\\`a\nU=<!!\n\020;")
      },
      {
        Text = _xcL("9<\\&?`\004\029\020\020b\n`e\n\\`Da\020\n\\`!iV4`\004\ni\020\n`\ni\020e\n&biU\n\\\n`z\\<U\n`<&!e\n\020\004\n\020;")
      },
      {
        Text = _xcL("5i\n`3\\\029!!!V4\\\ni[&\020U`<&R`e\n?`nV4i=e`4<!b`e&`<=!\029`\ni\020R<V4`?<=`iU\020\029\\i\n\\b.")
      },
      {
        Text = _xcL("C[\n\\`e\n\020`ji\020e\n!b\\iV4_`e\n\\`\0294\020\n`\ni\020\n\020`r\ni=\n\020&?[\\&V4`&\n[\n\\4<&wb`\004\ni\020\n\020`ni\020\020`?<V4b_`4<!b`e&`&\n[\n\\\020\029??\n\020.")
      },
      {
        Text = _xcL("C[\n\\`iV4`4<[\n`4\n&b\n`?\ni\020\n\020`U\\\029!!y&\nUiU\n\020`\019<U`&\020e`=<!!\n`e\ni\020\n`C\020ba\029\\b`b\\\029bye\n?`U\n=b\n\020.")
      },
      {
        Text = _xcL("C&RU<[\n`\n\\R\029=U\\\niV4`U\n?\ni!b\n\\b`&\020e`ei\n`\020<\nV4!b\n`\004<\020\020`H\nbyb`<\004bi>i\n\\b`a\n\\e\n\020.")
      }
    }, function(action)
      _xwq.Active = false
      _syX.Active = false
      _OcyF.Active = false
      if _kEjQ == true then
        _uVKJ.Active = true
      else
        _0xC.Active = true
      end
      _ceLKO()
    end)
  elseif Wherigo.NoCaseEquals(_H1H1, _xcL("\127i=R\n")) or Wherigo.NoCaseEquals(_H1H1, _xcL([[
4
=w]])) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\127i\n\\`<&R`ei\n!\n?`nw\029i=\n\\[i=e`i!b`e<!`nV4i=e_`&?`a\n=V4\n!`\n!`U\n4b_`?ib`\ni\020\n?`\\\029b\n\020`\v&\020\004b`?<\\\004i\n\\b."),
        Media = _VV6LJ
      },
      {
        Text = _xcL("\028!b`e<!`{C\019)O5\014{L\017CB`>i\n==\niV4b`U\nR<\n==b`a\029\\e\n\020;tjO-L<\020\020`iV4`?i\\`\004<&?`>\029\\!b\n==\n\020.")
      },
      {
        Text = _xcL("C[\n\\`>i\n==\niV4b`\004<\020\020!b`e&`H<`\\<b\n\020_`a<!`<&R`e\n?`nV4i=e`U\n!b<\020e\n\020`4<[\n\020`\004\029\n\020\020b\n.")
      },
      {
        Text = _xcL(")\020e`a\n\020\020`\020iV4b_`e<\020\020`ai\\!b`e&`R&\n\\`e\ni\020\n`5&??4\nib`4<=b`[\n!b\\<Rb`&\020e`\004\029??!b`\020iV4b`a\nib\n\\.")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_FucO)
      end)
    end)
  elseif _H1H1 == _xcL("\020<b&\\e\n\020\004?<=") then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`?<U`\n!`\020iV4b_`a\n\020\020`B\n&b\n`<&R`3\\\029!!!V4\\\ni[&\020U`>\n\\yiV4b\n\020|tjO-jibb\n`\020\029V4`?<=`\020\n&`\ni\020U\n[\n\020.tjO-79<!`[i\020`iV4`e\029V4`R&\n\\`\ni\020`aie\n\\=iV4\n\\`nV4&=?\ni!b\n\\A"),
      Callback = function(action)
        if action ~= nil then
          _syX.Active = true
        end
      end
    })
  elseif _H1H1 == _xcL("\020<b&\\\be\n\020\004?<=") then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`?<U`\n!`\020iV4b_`a\n\020\020`B\n&b\n`<&R`3\\\029!!!V4\\\ni[&\020U`>\n\\yiV4b\n\020|tjO-jibb\n`\020\029V4`?<=`\020\n&`\ni\020U\n[\n\020.tjO-79<!`[i\020`iV4`e\029V4`R&\n\\`\ni\020`aie\n\\=iV4\n\\`nV4&=?\ni!b\n\\A"),
      Callback = function(action)
        if action ~= nil then
          _syX.Active = true
        end
      end
    })
  elseif Wherigo.NoCaseEquals(_H1H1, "") then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_FucO)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C=!\029`ei\n!\n`C\020ba\029\\b`!V4\ni\020b`<[!\029=&b\n\\`\a&<b!V4`y&`!\ni\020.tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=.")
      },
      {
        Text = _xcL(")\020e`a\n\020\020`e&`w<\\b\029&b`\020iV4b`a\nib\n\\`\004\029??!b_`e<\020\020`Ui[`\006\127i=R\n\006`<=!`B\029\n!&\020U`\ni\020.")
      }
    }, function(action)
      _syX.Active = true
    end)
  end
end
function _Vg7C:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_Vg7C)
          end)
        end
      end
    })
    return
  end
  if input == 15 then
    _Urwigo.MessageBox({
      Text = _xcL("n&w\n\\|tjO-5<!`i!b`U\n\020<&`e\n\\`9\n\\b_`e\n\020`iV4`<&V4`U\n?\n!!\n\020`4<[\n.tjO-5<?ib`4<!b`e&`ei\n!\n`C&RU<[\n`\n\\=\neiUb`&\020e`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020."),
      Callback = function(action)
        if action ~= nil then
          _4TV.Active = false
          _41Gfk.Active = false
          _xhZw = true
          _aCJ.Active = false
          _uVKJ.Active = false
          if _GIhl == false and _0NcV == false and _kEjQ == true then
            _NLgzM()
          end
          if _GIhl == true then
            _0xC.Active = true
          elseif _GIhl == false and _0NcV == true then
            _I0oF.Active = true
          elseif _GIhl == false and _0NcV == false and _kEjQ == true then
            _afnxp.Active = true
          end
          _ceLKO()
        end
      end
    })
  elseif input == 14 then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`!\n=[!b`4<bb\n`ya<\\`v2`V?`U\n?\n!!\n\020_`<[\n\\`v\023`V?`=<!!\n`iV4`U\n=b\n\020.tjO-5<?ib`4<!b`e&`ei\n!\n`C&RU<[\n`\n\\=\neiUb`&\020e`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020."),
      Callback = function(action)
        if action ~= nil then
          _xhZw = true
          _aCJ.Active = false
          _4TV.Active = false
          _41Gfk.Active = false
          _xhZw = true
          _aCJ.Active = false
          _uVKJ.Active = false
          if _GIhl == false and _0NcV == false and _kEjQ == true then
            _NLgzM()
          end
          if _GIhl == true then
            _0xC.Active = true
          elseif _GIhl == false and _0NcV == true then
            _I0oF.Active = true
          elseif _GIhl == false and _0NcV == false and _kEjQ == true then
            _afnxp.Active = true
          end
          _ceLKO()
        end
      end
    })
  elseif input == 16 then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`!\n=[!b`4<bb\n`ya<\\`v2`V?`U\n?\n!!\n\020_`<[\n\\`v\002`V?`=<!!\n`iV4`U\n=b\n\020.tjO-5<?ib`4<!b`e&`ei\n!\n`C&RU<[\n`\n\\=\neiUb`&\020e`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020."),
      Callback = function(action)
        if action ~= nil then
          _xhZw = true
          _aCJ.Active = false
          _4TV.Active = false
          _41Gfk.Active = false
          _xhZw = true
          _aCJ.Active = false
          _uVKJ.Active = false
          if _GIhl == false and _0NcV == false and _kEjQ == true then
            _NLgzM()
          end
          if _GIhl == true then
            _0xC.Active = true
          elseif _GIhl == false and _0NcV == true then
            _I0oF.Active = true
          elseif _GIhl == false and _0NcV == false and _kEjQ == true then
            _afnxp.Active = true
          end
          _ceLKO()
        end
      end
    })
  elseif input == 17 or input == 18 or input == 12 or input == 13 then
    _Urwigo.MessageBox({
      Text = _xcL("5<`4<!b`e&`>\n\\?&b=iV4`\nba<!`&\020U\n\020<&`U\n?\n!!\n\020`\029e\n\\`\020&\\`U\n\\<b\n\020#U\n!V4<\nbyb.tjO-r&\\`nb\\<R\n`?&!!b`e&`i\020`ei\n`\014V\004\n`&\020e`eiV4`!V4<\n?\n\020."),
      Callback = function(action)
        if action ~= nil then
          _aCJ.Active = false
          _aKBkN.Active = true
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("\v&4_`e\ni\020`\014\\U\n[\020i!`i!b`U<\020y`!V4\029\n\020`e<\020\n[\n\020`7<&R`H\ne\n\020`z<==`?i\020e\n!b\n\020!`\023`V?`C[a\niV4&\020UA.tjO-r&\\`nb\\<R\n`?&!!b`e&`i\020`ei\n`\014V\004\n`&\020e`eiV4`!V4<\n?\n\020."),
      Callback = function(action)
        if action ~= nil then
          _aCJ.Active = false
          _aKBkN.Active = true
        end
      end
    })
  end
end
function _6djr:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_6djr)
      end)
    end)
    return
  end
  if input == 851100 then
    _Urwigo.MessageBox({
      Text = _xcL("n&w\n\\|tjO-5<?ib`4<!b`e&`ei\n!\n`C&RU<[\n`\n\\=\neiUb`&\020e`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020."),
      Callback = function(action)
        if action ~= nil then
          _rbnc.Active = false
          _NaBOl.Active = false
          _4TV.Active = false
          _41Gfk.Active = false
          _uVKJ.Active = false
          if _GIhl == false and _0NcV == false and _kEjQ == true then
            _NLgzM()
          end
          if _GIhl == true then
            _0xC.Active = true
          elseif _GIhl == false and _0NcV == true then
            _I0oF.Active = true
          elseif _GIhl == false and _0NcV == false and _kEjQ == true then
            _afnxp.Active = true
          end
          _ceLKO()
        end
      end
    })
  elseif input == 999 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028!b`e\n\\`9<!!\n\\!b<\020e`>i\n==\niV4b`e\029V4`y&`4\029V4;tjO-)\020e`e&`4<!b`ei\n`\v=<\004\nbb\n`\020iV4b`ai\\\004=iV4`U\nR&\020e\n\020;tjO-5<\020\020`?&!!b`e&`ei\n`nb&R\n`Q`H\nbyb`a\0294=`[\n\n\020e\n\020`7\029e\n\\`\020\029V4`?<=`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\ni\020!b\niU\n\020_`R<==!`e&`y&`>\029\\\ni=iU`a<\\!bA.")
      }
    }, function(action)
      _aCJ.Active = true
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("B\nie\n\\`>\n\\\004\n4\\b|tjO-\127<!b`a\0294=`9&\\!bRi\020U\n\\`\029e\n\\`!V4=\nV4b\n`C&U\n\020;tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=.tjO-tjO-)?`y&\\&\nV\004`i\020!`\017\n\020&`y&`\004\029??\n\020_`Ui[`\006GGG\006`\ni\020."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_6djr)
          end)
        end
      end
    })
  end
end
function _VKB:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_VKB)
          end)
        end
      end
    })
    return
  end
  if input >= 240 and input <= 250 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028?`O<4?\n\020`e\n\\`\017\n!!U\n\020<&iU\004\nib`=<!!\n`iV4`ei\n!\n!`\014\\U\n[\020i!`<&R`H\ne\n\020`z<==`U\n=b\n\020.")
      },
      {
        Text = _xcL("o\nbyb`[\n!&V4\n`\020\029V4`\004&\\y`e<!`5\n\020\004?<=."),
        Media = _JU_y
      }
    }, function(action)
      _wR46N.Active = false
      _k5m4.Active = true
    end)
  elseif input > 215 and input < 240 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("n\029`U<\020y`\\iV4biU`i!b`e\ni\020\n`C\020ba\029\\b`\020iV4b.tjO-\014i\020`\004=\ni\020`a\n\020iU`=<\n\020U\n\\`i!b`e\n\\`\019\\\029U`!V4\029\020.tjO-\028V4`U=<&[\n_`e&`4<!b`\020&\\`U\n!V4<\nbyb`&\020e`\020iV4b`U\n?\n!!\n\020.tjO-)\020e`e<!`\020iV4b`!\029\020e\n\\=iV4`U&b`4i\020[\n\004\029??\n\020.tjO-")
      },
      {
        Text = _xcL("{&\\`R&\n\\`e\n\020`z<==_`e<!!`e&`\n>\n\020b&\n==`\ni\020\n\020`R<=!V4\n\020`z&bb\n\\b\\\029U`>\n\\?\n!!\n\020`4<[\n\020`!\029==b\n!b_`i!b`4i\n\\`\020\029V4`?<=`\ni\020`nw\029i=\n\\[i=e."),
        Media = _akoE
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|tjO-7\020<V4e\n?`e&`ei\n`r\029\020\n`\004&\\y`>\n\\=<!!\n\020`&\020e`ai\ne\n\\`[\nb\\\nb\n\020`4<!bA")
      }
    }, function(action)
      _wR46N.Active = true
      _Rv8P.Active = false
    end)
  elseif input > 250 and input < 275 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("n\029`U<\020y`\\iV4biU`i!b`e\ni\020\n`C\020ba\029\\b`\020iV4b.tjO-\014i\020`\004=\ni\020`a\n\020iU`\004&\n\\y\n\\`i!b`e\n\\`\019\\\029U`!V4\029\020.tjO-\028V4`U=<&[\n_`e&`4<!b`\020&\\`U\n!V4<\nbyb`&\020e`\020iV4b`U\n?\n!!\n\020.tjO-)\020e`e<!`\020iV4b`!\029\020e\n\\=iV4`U&b`4i\020[\n\004\029??\n\020.tjO-")
      },
      {
        Text = _xcL("{&\\`R&\n\\`e\n\020`z<==_`e<!!`e&`\n>\n\020b&\n==`\ni\020\n\020`R<=!V4\n\020`z&bb\n\\b\\\029U`>\n\\?\n!!\n\020`4<[\n\020`!\029==b\n!b_`i!b`4i\n\\`\020\029V4`?<=`\ni\020`nw\029i=\n\\[i=e."),
        Media = _akoE
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|tjO-7\020<V4e\n?`e&`ei\n`r\029\020\n`\004&\\y`>\n\\=<!!\n\020`&\020e`ai\ne\n\\`[\nb\\\nb\n\020`4<!bA")
      }
    }, function(action)
      _wR46N.Active = true
      _Rv8P.Active = false
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C=!\029`e\ni\020\n`C\020ba\029\\b`i!b`=\nie\n\\`>\029==\004\029??\n\020`7<&R`H\ne\n\020`z<==`?\n4\\`<=!`Q+`V?A`>\n\\\004\n4\\b.")
      },
      {
        Text = _xcL("\127<!b`e&`>i\n==\niV4b`\ni\020\n\020`R<=!V4\n\020`z&bb\n\\b\\\029U`>\n\\?\n!!\n\020;")
      },
      {
        Text = _xcL("\127i\n\\`\020\029V4`?<=`\ni\020`nw\029i=\n\\[i=e."),
        Media = _akoE
      },
      {
        Text = _xcL("De\n\\`4<!b`e&`<=!`\014i\0204\nib`\020iV4b`ai\n`U\nR\029\\e\n\\b`r\n\020bi?\nb\n\\`!\029\020e\n\\\020`\nba<!`<\020e\n\\\n!`U\na<\n4=b;")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _wR46N.Active = true
      _Rv8P.Active = false
    end)
  end
end
function _rr3Cf:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _tMz = input
  if Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\bn4<\020b^\bm4\029\\")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("DL_`e\ni\020\n`C\020ba\029\\b`i!b`\020<b&\n\\=iV4`\004\029\\\\\n\004b.tjO-5i\n!\n`C&RU<[\n`a<\\`H<`<&V4`\020iV4b`[\n!\029\020e\n\\!`!V4ai\n\\iU.")
      },
      {
        Text = _xcL("\127i\n\\`[\ni`e\n\\`\n4\n?<=iU\n\020`5\029\\R!b\n==\n`j\n\\iV4`\004<\020\020!b`e&`<&V4`\ni\020iU\n`z&bb\n\\b\\\029\nU\n`<&!`nb\ni\020`\n\020be\nV\004\n\020.tjO-C\020`\ni\020\n\\`nb\n==\n`!b\n4\n\020`e\\\ni`e<>\029\020`i\020`\ni\020\n\\`O\ni4\n.")
      }
    }, function(action)
      _Urwigo.MessageBox({
        Text = _xcL("nV4\029\020`U\nR&\020e\n\020;"),
        Buttons = {
          _xcL("C[\n\\`\004=<\\`e\029V4|"),
          _xcL("ji\020`y&`e\029\029R|")
        },
        Callback = function(action)
          if action ~= nil then
            if action == "Button1" == true then
              _Urwigo.RunDialogs(function()
                Wherigo.GetInput(_VKB)
              end)
            else
              _Urwigo.MessageBox({
                Text = _xcL("5<\020\020`!w\n\020ei\n\\\n`iV4`?<=`ei\n!\n!`nw\029i=\n\\[i=e."),
                Media = _NvO9,
                Callback = function(action)
                  if action ~= nil then
                    _Urwigo.RunDialogs(function()
                      Wherigo.GetInput(_VKB)
                    end)
                  end
                end
              })
            end
          end
        end
      })
    end)
  elseif Wherigo.NoCaseEquals(_tMz, _xcL("9\n=V4\n`\019<R\n=;")) then
    _Urwigo.MessageBox({
      Text = _xcL([[
5i
!
`4i
\|]]),
      Media = _WE5,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_rr3Cf)
          end)
        end
      end
    })
  elseif Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\bCb=<\020bi!\bm4\029\\")) or Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\bz\\<&\n\020\bm4\029\\")) or Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\b\017<\n\020\020\n\\\bm4\029\\")) or Wherigo.NoCaseEquals(_tMz, _xcL("\014e\n\\!\n\n\b3\029!w\n=\bm4\029\\")) then
    _Urwigo.MessageBox({
      Text = _xcL("\127<!b`e&`\ni\020R<V4`\020&\\`U\n\\<b\n\020;tjO-De\n\\`4<!b`e&`9&\\!bRi\020U\n\\;tjO-De\n\\`a\029==b\n!b`e&`?<=`<&!w\\\029[i\n\\\n\020_`a<!`w<!!i\n\\b_`a\n\020\020`e&`<[!iV4b=iV4`\ni\020\n`R<=!V4\n`C\020ba\029\\b`a<\n4=!b;tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|"),
      Callback = function(action)
        if action ~= nil then
          _wR46N.Active = true
          _Rv8P.Active = false
        end
      end
    })
  end
end
function _IcLw:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 47572 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5<!`a<\\`\020<b&\n\\=iV4`ei\n`\\iV4biU\n`C\020ba\029\\b.`C[\n\\`4i\n\\`\004<\020\020`a\0294=`\n4`\004<&?`H\n?<\020e`\n\\\020!b4<Rb`\ni\020\n\020`z\n4=\n\\`?<V4\n\020.")
      },
      {
        Text = _xcL("\127i\n\\`\020\029V4`?<=`\ni\020`z\029b\029_`ai\n`j\n\\iV4`\ni\020!b`<&!!<4."),
        Media = _tmj
      }
    }, function(action)
      _0xC.Active = false
      if _0NcV == false then
        _p_T.Active = true
      else
        _I0oF.Active = true
      end
      _k5m4.Active = false
      _F0lou.Active = false
      _TZWTn.Active = false
      _ceLKO()
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 15541 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\127<!b`e&`ei\n`z\\<U\n`\020iV4b`>\n\\!b<\020e\n\020;`\028V4`4<[\n`\020<V4`e\n?`3\\&\n\020e&\020U!e<b&?`U\nR\\<Ub`&\020e`\020iV4b_`a<\020\020`j\n\\iV4`i\020`e\n\020`z=&b\n\020`>\n\\!<\020\004|")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _k5m4.Active = true
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("j\\<&V4!b`e&`\ni\020\n`j\\i==\n_`\029e\n\\`a<!;")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _k5m4.Active = true
    end)
  end
end
function _LX3m:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("5&`!\029==!b`\ni\020\n`r<4=`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_LX3m)
          end)
        end
      end
    })
    return
  end
  if input == 43 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028V4`4<[\n`\020iV4b`\020<V4`e\n\\`C\020y<4=`e\n\\`>\029\\4<\020e\n\020\n\020`j\nb\029\020<[e\nV\004&\020U\n\020`U\nR\\<Ub`!\029\020e\n\\\020`ai\n`>i\n=\n`3\\<\n[\n\\`4i\n\\`i\020!U\n!<?b`\v=<by`4<\nbb\n\020.")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _lIYn.Active = true
    end)
  elseif input == 46 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5<!`i!b`ei\n`\004\029\\\\\n\004b\n`C\020ba\029\\b|")
      },
      {
        Text = _xcL("\127i\n\\`\ni\020`<=b\n!`ji=e_`<=!`e\n\\`r&!b<\020e`e\n!`3\\<\n[\n\\R\n=e\n!`\020\029V4`e\n&b=iV4`[\n!!\n\\`a<\\."),
        Media = _APWv
      },
      {
        Text = _xcL("5i\n`<\004b&\n==\n`C&RU<[\n`4<!b`e&`e<?ib`\n\\=\neiUb`&\020e`e&`\004<\020\020!b`ei\n`\020<\nV4!b\n`<\004bi>i\n\\\n\020.")
      }
    }, function(action)
      _NLgzM()
      _I0oF.Active = false
      _lIYn.Active = false
      _euiH2.Active = false
      _Hb3W.Active = false
      if _GIhl == true then
        _p_T.Active = true
      elseif _GIhl == false and _0NcV == true and _kEjQ == false then
        _JQtI.Active = true
      elseif _GIhl == false and _0NcV == true and _kEjQ == true then
        _afnxp.Active = true
      end
      _ceLKO()
    end)
  elseif input >= 47 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("n\n=[!b`a\n\020\020`e&`<==\n`=\n\n\\\n\020`3\\<\n[\n\\`?ibU\ny<\n4=b`4<!b_`!\029==b\n!b`e&`\020iV4b`<&R`\ni\020\n`!\029`4\0294\n`r<4=`\004\029??\n\020`\004\029\n\020\020\n\020.")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _lIYn.Active = true
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("L\ni\020\n`C4\020&\020U_`ai\n`e&`H\nbyb`<&R`ei\n!\n`r<4=`\004\029??!b.tjO-\028!b`<&R`H\ne\n\020`z<==`\020iV4b`e<!`a<!`iV4`4\029\n\\\n\020`a\029==b\n.")
      },
      {
        Text = _xcL("\127i\n\\`?<=`\ni\020\n`B&Rb[i=e<&R\020<4?\n_`ei\n`ei\\`[\ni?`r<\n4=\n\020`4\n=R\n\020`\004\029\n\020\020b\n."),
        Media = _nvCr9
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`H\nbyb`\020\029V4`\ni\020?<=|")
      }
    }, function(action)
      _lIYn.Active = true
    end)
  end
end
function _KaI:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("5&`!\029==!b`\ni\020\n`r<4=`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_KaI)
          end)
        end
      end
    })
    return
  end
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("L\ni\020\n`C4\020&\020U_`\029[`e\ni\020\n`C\020ba\029\\b`!bi??b.")
    },
    {
      Text = _xcL("\028V4`a<\\`e\029V4`\020iV4b`!\029`e&??_`&\020e`4<[\n`<==\n`L\nbb\n\020U=i\ne\n\\`U\ny<\n4=b.")
    },
    {
      Text = _xcL("6i\n=`y&`?&\n4!<?.`tjO-r&?<=`\ni\020iU\n`L\nbb\n\020U=i\ne\n\\`?\n4\\`\029e\n\\`a\n\020iU\n\\`&\020b\n\\`e\n\\`j\029H\n`=i\nU\n\020.tjO-\127<=b`\ni\020\n`C&RU<[\n_`ei\n`\nV4b`nV4\ni!!\n`i!b.")
    },
    {
      Text = _xcL("5\ni\020`j\n?&\n4\n\020`ai\\e`<[\n\\`<&R`H\ne\n\020`z<==`[\n=\0294\020b`&\020e`ei\n`<\004b&\n==\n`C&RU<[\n`Ui=b`e<?ib`<=!`\n\\=\neiUb.")
    }
  }, function(action)
    _CKzj6()
  end)
end
function _oRNb:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 8590 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5<!`a<\\`\020<b&\n\\=iV4`\\iV4biU.tjO-5i\n`<\004b&\n==\n`C&RU<[\n`Ui=b`e<?ib`<=!`\n\\=\neiUb.")
      }
    }, function(action)
      _CKzj6()
    end)
  elseif _Urwigo.Hash(string.lower(input)) == 63646 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("6i\n==\niV4b`\020&\nbyb`ei\\`ei\n!\n!`nw\029i=\n\\[i=e`H<`\nba<!."),
        Media = _Vsr,
        Buttons = {
          _xcL("3\nR&\020e\n\020|"),
          _xcL("5<`i!b`\020iV4b!|")
        }
      }
    }, function(action)
      if action == "Button1" == true then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_oRNb)
        end)
      elseif action == "Button2" == true then
        _Urwigo.Dialog(false, {
          {
            Text = _xcL("C=!\029`\niU\n\020b=iV4`\004<\020\020`?<\020`e<!`U<\\`\020iV4b`&\n[\n\\!\n4\n\020.")
          },
          {
            Text = _xcL("C[\n\\`>i\n==\niV4b`a&\\e\n`ei\n`j\029H\n`<&!U\nb<&!V4b`\029e\n\\`\020\n&`U\n!b\\iV4\n\020.")
          },
          {
            Text = _xcL("C[\n\\`y&?`3=&\nV\004`R&\n\\`eiV4`Ui[b`\n!`H<`\020\029V4`ei\n`nV4\ni!!\bC&RU<[\n.")
          }
        }, function(action)
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_KaI)
          end)
        end)
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("5i\n`C\020ba\029\\b`!V4\ni\020`?i\\`\020iV4b`\\iV4biU`y&`!\ni\020.tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`\ni\020?<=."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_oRNb)
          end)
        end
      end
    })
  end
end
function _ZiQPR:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_ZiQPR)
          end)
        end
      end
    })
    return
  end
  if input < 247 then
    _Urwigo.MessageBox({
      Text = _xcL("5i\n`r<4=`\n\\!V4\ni\020b`?i\\`\ni\020`a\n\020iU`\020i\ne\\iU.tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`?<=."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_ZiQPR)
          end)
        end
      end
    })
  elseif input > 253 then
    _Urwigo.MessageBox({
      Text = _xcL("5i\n`r<4=`\n\\!V4\ni\020b`?i\\`\ni\020`a\n\020iU`4\029V4.tjO-\v\\\029[i\n\\\n`\n!`\020\029V4`?<=."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_ZiQPR)
          end)
        end
      end
    })
  elseif input == 250 then
    _Urwigo.MessageBox({
      Text = _xcL("\v\n\\R\n\004b|tjO-3\n\020<&`(2+`V?`4<bb\n`iV4`<&V4`U\n?\n!!\n\020."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _xcL("o\nbyb`?&!!b`e&`\020\029V4`\ni\020\n`a\nib\n\\\n`z\\<U\n`[\n<\020ba\029\\b\n\020.tjO-6i\n==\niV4b`?&!!b`e&`\ni\020`a\n\020iU`!&V4\n\020_`&?`ei\n`C\020ba\029\\b`y&`Ri\020e\n\020."),
            Callback = function(action)
              if action ~= nil then
                _Urwigo.RunDialogs(function()
                  Wherigo.GetInput(_eFvwm)
                end)
              end
            end
          })
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`4<bb\n`ya<\\`(2+`V?`U\n?\n!!\n\020_`<[\n\\`i?`O<4?\n\020`e\n\\`\017\n!!U\n\020<&iU\004\nib`=<!!\n`iV4`e\ni\020\n`C\020ba\029\\b`?<=`U\n=b\n\020."),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _xcL("o\nbyb`?&!!b`e&`\020\029V4`\ni\020\n`a\nib\n\\\n`z\\<U\n`[\n<\020ba\029\\b\n\020.tjO-6i\n==\niV4b`?&!!b`e&`\ni\020`a\n\020iU`!&V4\n\020_`&?`ei\n`C\020ba\029\\b`y&`Ri\020e\n\020."),
            Callback = function(action)
              if action ~= nil then
                _Urwigo.RunDialogs(function()
                  Wherigo.GetInput(_eFvwm)
                end)
              end
            end
          })
        end
      end
    })
  end
end
function _eFvwm:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_eFvwm)
          end)
        end
      end
    })
    return
  end
  if input == 100 then
    _Urwigo.MessageBox({
      Text = _xcL("5<!`i!b`\\iV4biU|tjO-5<?ib`[i!b`e&`4i\n\\`R\n\\biU`&\020e`\004<\020\020!b`ei\n`\020<\nV4!b\n`C&RU<[\n`<\004bi>i\n\\\n\020."),
      Callback = function(action)
        if action ~= nil then
          _JQtI.Active = false
          _ihg7.Active = false
          _6iCkx.Active = false
          _jBF9t.Active = true
          _Kkc.Active = false
          _YVBK.Active = false
          _ceLKO()
        end
      end
    })
  elseif input == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("C\020ba\029\\b`i\020`r\n\020bi?\nb\n\\\020`&\020e`\020iV4b`i\020`\017\nb\n\\\020|")
      },
      {
        Text = _xcL("nb<\020e`e\029V4`\ni\020e\n&biU`[\ni`e\n\\`z\\<U\n`e<[\ni|")
      },
      {
        Text = _xcL("\v\\\029[i\n\\\n`\n!`H\nbyb`\020\029V4`\ni\020?<=.")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_eFvwm)
      end)
    end)
  elseif input == 999 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028V4`4<[\n`ei\\`ei\n`r\029\020\n_`i\020`e\n\\`e&`e<!`nV4i=e`?ib`e\n\\`\\iV4biU\n\020`\028\020R\029\\?<bi\029\020`Ri\020e\n\020`\004<\020\020!b_`H\nbyb`?<\\\004i\n\\b."),
        Media = _bhir
      },
      {
        Text = _xcL("n\029[<=e`e&`ei\n`r\029\020\n`\n\\\\\niV4b`4<!b_`\004<\020\020!b`e&`\n\\\020\n&b`\ni\020\n\020`B\029\n!&\020U!>\n\\!&V4`!b<\\b\n\020.")
      }
    }, function(action)
      _6iCkx.Active = true
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5i\n!\n`C\020ba\029\\b`i!b`>\n\\\004\n4\\b.")
      },
      {
        Text = _xcL("\127<!b`e&`ei\n!\n!`nV4i=e`>i\n==\niV4b`\020\029V4`\020iV4b`\n\020be\nV\004b;tjO-5\n\020\004`e\\<\0208`\014i\020U<[\n`i\020`r\n\020bi?\nb\n\\\020|"),
        Media = _bhir
      },
      {
        Text = _xcL(")\020e`!\029==b\n!b`e&`e<!`nV4i=e`\ni\020R<V4`\020iV4b`Ri\020e\n\020_`e<\020\020`Ui[`\006GGG\006`\ni\020.")
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_eFvwm)
      end)
    end)
  end
end
function _48h5:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    _Urwigo.MessageBox({
      Text = _xcL("{&\\`riRR\n\\\020`\ni\020U\n[\n\020|"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_48h5)
          end)
        end
      end
    })
    return
  end
  if _Urwigo.Hash(string.lower(input)) == 33911 then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("5<!`i!b`\020<b&\n\\=iV4`\004\029\\\\\n\004b`&\020e`ei\n`<\004b&\n==\n`C&RU<[\n`e<?ib`!V4\029\020`\n\\=\neiUb.")
      },
      {
        Text = _xcL(")\020e`e<`ei\n!`U=\niV4y\nibiU`ei\n`=\nbyb\n`C&RU<[\n`e\n\\`nb&R\n`(`a<\\_`\004<\020\020!b`e&`<[`H\nbyb`H\ne\n\\y\nib`\006zi\020<=`nb&R\n`(\006`<\004bi>i\n\\\n\020.")
      }
    }, function(action)
      _jBF9t.Active = false
      _WWB.Active = true
      _cJX.Active = false
      _C_G9.Active = false
      _bHJ.Active = false
      if _GIhl == true then
        _Urwigo.OldDialog({
          {
            Text = _xcL("j\n>\029\\`e&`eiV4`<[\n\\`<&R`e\n\020`9\nU`y&?`zi\020<=`>\029\020`nb&R\n`(`?<V4!b_`!\029==b\n!b`e&`\n\\!b`\020\029V4`ei\n`\\\n!b=iV4\n\020`\014e\n\\!\n\n\bCb=<\020bi!\bC&RU<[\n\020`\n\\=\neiU\n\020.tjO-5<\020\020`\004<\020\020!b`e&`<\020!V4=i\n!!\n\020e`U=\niV4`?\n4\\\n\\\n`5\029!\n\020`<&R`\ni\020?<=`\ni\020!<??\n=\020.")
          }
        })
        _3_2.Active = true
        if _kEjQ == false then
          _MKBn:MoveTo(nil)
        end
      elseif _GIhl == false and _kEjQ == true then
        _Urwigo.OldDialog({
          {
            Text = _xcL("j\n>\029\\`e&`eiV4`<[\n\\`<&R`e\n\020`9\nU`y&?`zi\020<=`>\029\020`nb&R\n`(`?<V4!b_`!\029==b\n!b`e&`\n\\!b`\020\029V4`ei\n`\\\n!b=iV4\n\020`\014e\n\\!\n\n\bCb=<\020bi!\bC&RU<[\n\020`\n\\=\neiU\n\020.tjO-5<\020\020`\004<\020\020!b`e&`<\020!V4=i\n!!\n\020e`U=\niV4`?\n4\\\n\\\n`5\029!\n\020`<&R`\ni\020?<=`\ni\020!<??\n=\020.")
          }
        })
        _5sM.Active = true
      end
      _ceLKO()
    end)
  elseif input > tonumber(_xcL("\002(")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("B\nie\n\\`>\n\\\004\n4\\b|tjO-5i\n`U\n!&V4b\n`3\\<[\020&??\n\\`i!b`\020iV4b`!\029`4\029V4."),
        Media = _RCtz
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_48h5)
      end)
    end)
  elseif input < tonumber(_xcL("\002(")) then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("B\nie\n\\`>\n\\\004\n4\\b|tjO-5i\n`U\n!&V4b\n`3\\<[\020&??\n\\`i!b`\020iV4b`!\029`\020i\ne\\iU."),
        Media = _RCtz
      }
    }, function(action)
      _Urwigo.RunDialogs(function()
        Wherigo.GetInput(_48h5)
      end)
    end)
  end
end
function _n2mHq:OnClick()
  _Urwigo.MessageBox({
    Text = _xcL("5<!`zi\020<=`e\n\\`nb&R\n`v`[\nRi\020e\nb`!iV4`[\ni`R\029=U\n\020e\n\020`L\029\029\\ei\020<b\n\0208tjO-tjO-{`2v\015`v+.\002Q\027tjO-\014`\024\020[!w +\027\015`2\027.G(v")
  })
end
function _GZ0WP:OnClick()
  _Urwigo.MessageBox({
    Text = _xcL("5<!`zi\020<=`e\n\\`nb&R\n`(`[\nRi\020e\nb`!iV4`[\ni`R\029=U\n\020e\n\020`L\029\029\\ei\020<b\n\0208tjO-tjO-{`2v\015`v+.\002(2tjO-\014`\024\020[!w +\027\015`2\027.\016\016+")
  })
end
function __7Z:OnClick()
  _Urwigo.MessageBox({
    Text = _xcL("5<!`zi\020<=`e\n\\`nb&R\n`Q`[\nRi\020e\nb`!iV4`[\ni`R\029=U\n\020e\n\020`L\029\029\\ei\020<b\n\0208tjO-tjO-{`2v\015`v+.\016+\023tjO-\014`\024\020[!w +\027\015`2\027.\0022(")
  })
end
function _MKBn:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("n\029`\ni\020`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR`i!b`\004\ni\020`nwi\n=y\n&U.")
    },
    {
      Text = _xcL("5&`!\029==b\n!b`i4\020`\020iV4b`=\niV4bR\n\\biU`e\\&\nV\004\n\020.")
    },
    {
      Text = _xcL("n\029\020e\n\\\020`ai\\\004=iV4`\020&\\_`a\n\020\020`e&`a\nU\n\020`e\n!`\v\nU\n=!b<\020e\n!`\020iV4b`a\nib\n\\`\004\029??\n\020`!\029==b\n!b.")
    },
    {
      Text = _xcL("5<!`5\\&\nV\004\n\020`e\n!`L\020\029wR\n!`\004<\020\020!b`e&`\020iV4b`\\&\nV\004U<\n\020Ui\020U`?<V4\n\020.")
    },
    {
      Text = _xcL("C=!\0298`5i\n!\n\020`L\020\029wR`ai\\\004=iV4`\020&\\`e\\&\nV\004\n\020_`a\n\020\020`e&`a\nU\n\020`e\n!`\v\nU\n=!b<\020e\n!`\020iV4b`a\nib\n\\`\004\029??\n\020`!\029==b\n!b.tjO-C==\n`<\020e\n\\\n\020`\v\\\029[=\n?\n`ai\\e`ei\n!\n\\`L\020\029wR`\020iV4b`=\029\n!\n\020`\004\029\n\020\020\n\020."),
      Buttons = {
        _xcL("o\nbyb`e\\&\nV\004\n\020"),
        _xcL("Bi\n[\n\\`\020iV4b")
      }
    }
  }, function(action)
    if action == "Button1" then
      if _GIhl == true and _0NcV == true and _kEjQ == false then
        _VuOSU()
      elseif _GIhl == false and _0NcV == true and _kEjQ == true then
        _PsxQ()
      elseif _GIhl == true and _0NcV == true and _kEjQ == true then
        _jKjv()
      end
    end
  end)
end
function _2yV0v:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("nw\029i=\n\\`v"),
      Media = _uUJ
    },
    {
      Text = _xcL("nw\029i=\n\\`("),
      Media = _PXR
    }
  })
end
function _tGF:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("nw\029i=\n\\"),
      Media = _QuGeS
    }
  })
end
function _rXC:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("5\029!\n`i!b`\020iV4b`?\n4\\`<\020`e\n\\`<&R`e\n?`nw\029i=\n\\`?<\\\004i\n\\b\n\020`nb\n==\n`!\029\020e\n\\\020`V<.`\027+`V?`a\nib\n\\`>\029?`j<&?`\n\020bR\n\\\020b`\nba<`<?`&\020b\n\\\n\020`ji=e\\<\020e."),
      Media = _xdt
    }
  })
end
function _BZat:OnClick()
  _Urwigo.MessageBox({
    Text = (_xcL("5\n\\`)\020=\029V\004\bm\029e\n`=<&b\nb8`") .. string.sub(Player.CompletionCode, 1, 15)) .. _xcL("tjO-tjO-5i\n!\n\020`m\029e\n`[\n\004\029??!b`e&_`!\029[<=e`e&`\ni\020\n`e\n\\`e\\\ni`nb&R\n\020`e&\\V4U\n!wi\n=b`4<!b.")
  })
end
function _kH04N:OnClick()
  _Urwigo.MessageBox({
    Text = _xcL("n\029`!\029==`\n!`<&!!\n4\n\020|"),
    Media = _rgT
  })
end
function _q88p:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL([[
9
iV4
i|]])
    },
    {
      Text = _xcL("6\029\020`!\029`\ni\020`[i!!V4\n\020`\017<b!V4`=<\n!!b`e&`eiV4`<&R4<=b\n\020;")
    },
    {
      Text = _xcL("C[\n\\`ei\n`O\n!b\n`e\n\\`j\\&\nV\004\n`?&!!b`e&`[\n!&V4\n\020_`!\029\020!b`[\n\004\029??!b`e&`ei\n`zi\020<=\004\029\029\\ei\020<b\n\020`R&\n\\`nb&R\n`Q`\020iV4b.")
    },
    {
      Text = _xcL("C[\n\\`\n!`Ui[b`H<`\020iV4b`\020&\\`e\n\020`<=b\n\020`j\\&\nV\004\n\020wR\ni=\n\\_`e\n\020`iV4`e\n\\y\nib`<=!`r\029\020\n`?<\\\004i\n\\b`4<[\n`!\029\020e\n\\\020`<&V4`\020\029V4`e\n\020`<?`<\020e\n\\\n\020`)R\n\\`e\n\\`\014e\n\\.")
    },
    {
      Text = _xcL(")\020e`y&`ei\n!\n?`<\020e\n\\\n\020`j\\&\nV\004\n\020wR\ni=\n\\`\004\029??b`?<\020_`\0294\020\n`e&\\V4`\017<b!V4`a<b\n\020`y&`?&\n!!\n\020.")
    },
    {
      Text = _xcL("{<b&\n\\=iV4`\020iV4b`>\029\020`4i\n\\`<&!.`5<`4<\nbb\n!b`e&`e\n\020`!\n=[\n\020`\017<b!V4`&\020e`y&!<\nby=iV4`\020\029V4`ei\n`\014e\n\\`y&`e&\\V4I&\n\\\n\020.")
    },
    {
      Text = _xcL("C[\n\\`e&`\004<\020\020!b`H<`y&\\&\nV\004`y&?`C&b\029`U\n4\n\020_`&?w<\\\004\n\020`&\020e`eiV4`e\n\\`\020\n&\n\020`r\029\020\n`>\029\020`{\029\\e\n\020`<&!`\020<\n4\n\\\020.")
    },
    {
      Text = _xcL("C==\n\\ei\020U!`a<\n\\\n\020`e<!`!V4\029\020`U<\020y`!V4\029\n\020`>i\n=\n`Li=\029?\nb\n\\_`ei\n`e&`y&!<\nby=iV4`?ib`e\n?`C&b\029`y&\\&\nV\004=\nU\n\020`?&\n!!\n!b`7i\020![\n!\029\020e\n\\\n`a\ni=`e<!`zi\020<=`e<\020\020`ai\ne\n\\`!&\ne=iV4`e\n\\`\014e\n\\_`\020iV4b`a\nib`>\029\020`4i\n\\_`>\n\\!b\nV\004b`i!bA.tjO-C=!\029`ai\\\004=iV4`\ni\020`\017\nU<\bOi\n!\n\020\b)?a\nU|")
    },
    {
      Text = _xcL("9i==!b`e&`&\020b\n\\`ei\n!\n\020`6\029\\<&!!\nby&\020U\n\020`\020iV4b`e\029V4`=i\n[\n\\`e\n\020`L<?wR`?ib`e\n?`\017<b!V4`<&R\020\n4?\n\020;"),
      Buttons = {
        _xcL("Oi\n!\n\020`)?a\nU|"),
        _xcL("5\029V4`\017<b!V4|")
      }
    }
  }, function(action)
    if action == "Button1" == true then
      _Urwigo.MessageBox({
        Text = _xcL("9i\n`e&`?\ni\020!b.tjO-\014i\020\n\020`\v<\\\004w=<by`?&!!b`e&`ei\\`!\n=[\n\\`!&V4\n\020_`<[\n\\`e<!`ai\\!b`e&`!V4\029\020`!V4<RR\n\020.")
      })
      _gVBA.Active = true
      _lOan.Active = false
      _q88p:MoveTo(nil)
    end
  end)
end
function _ZHm4x:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("j\ni`e\n?`6\n\\!b\nV\004`4<\020e\n=`\n!`!iV4`&?`\ni\020`j\029e\n\020>\n\\!b\nV\004_`a\n=V4\n!`<==\ni\020`?ib`\127i=R\n`e\n\\`L\029\029\\ei\020<b\n\020`\020&\\`!\n4\\`!V4a\n\\`y&`Ri\020e\n\020`!\ni\020`ai\\e.")
    },
    {
      Text = _xcL("5<!`nw\029i=\n\\[i=e`!\029==b\n`H\ne\029V4`<&!U\n!w\\\029V4\n\020`4i=R\\\niV4`!\ni\020.")
    },
    {
      Text = _xcL("r&\\`niV4\n\\4\nib`H\nbyb`<[\n\\`<&V4`\020\029V4`\ni\020\n`\004=\ni\020\n`\019\nNb[\n!V4\\\ni[&\020U8tjO-tjO-5<!`j\029e\n\020>\n\\!b\nV\004`[i=e\nb`?ib`ya\ni`!b<\\\004`[\n?\029\029!b\n\020`j<&?!b&?wR\\\n!b\n\020`\ni\020`&\020U\nR<\n4\\`U=\niV4!\nibiU\n!`5\\\ni\nV\004`7n\nib\n\020=<\n\020U\n`\nba<!`&\n[\n\\`\ni\020\n?`\017\nb\n\\A_`a\029[\ni`e<!`6\n\\!b\nV\004`i\020`OiV4b&\020U`9\nU`=i\nUb.")
    },
    {
      Text = _xcL("5i\n`<\020`!iV4`!V4\029\020`U\nb<\\\020b\n`C[e\nV\004&\020U`e\n!`j\029e\n\020>\n\\!b\nV\004\n!`i!b`\020\029V4`\ni\020?<=`?ib`B<&[`\029e\n\\`<\n4\020=iV4\n?`[\ne\nV\004b_`!\029`e<!!`\ni\020`y&R<\n==iU`>\029\\[\ni\004\029??\n\020e\n\\`\017&UU\n=`U<\\<\020bi\n\\b`\020iV4b!`\n\020e\nV\004b.")
    },
    {
      Text = _xcL("jibb\n`<\020!V4=i\n!!\n\020e`ai\ne\n\\`!\029`b<\\\020\n\020_`e<!!`e<!`6\n\\!b\nV\004`I&<!i`&\020!iV4b[<\\`i!b`7y.`j.`?ib`B<&[A.tjO-jibb\n`\020iV4b`?ib`eiV\004\n\020`C\n!b\n\020`\029e\n\\`<\n4\020=iV4\n?`\006b<\\\020\n\020\006.tjO-tjO-\017ib`z\029b\029`&\020e`\019\nNb[\n!V4\\\ni[&\020U`Ri\020e\n\020`\020<V4R\029=U\n\020e\n`m<V4\n\\`e<!`6\n\\!b\nV\004`<&V4`\0294\020\n`\ni\020\n`<&RR<\n==iU\n`\006\019<\\\020&\020U\006.")
    }
  })
end
function _BI7w:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("j\ni`e\n?`6\n\\!b\nV\004`4<\020e\n=`\n!`!iV4`&?`\ni\020`j\029e\n\020>\n\\!b\nV\004_`a\n=V4\n!`<==\ni\020`?ib`\127i=R\n`e\n\\`L\029\029\\ei\020<b\n\020`\020&\\`!\n4\\`!V4a\n\\`y&`Ri\020e\n\020`!\ni\020`ai\\e.")
    },
    {
      Text = _xcL("5<!`nw\029i=\n\\[i=e`!\029==b\n`H\ne\029V4`<&!U\n!w\\\029V4\n\020`4i=R\\\niV4`!\ni\020.")
    },
    {
      Text = _xcL("r&\\`niV4\n\\4\nib`H\nbyb`<[\n\\`<&V4`\020\029V4`\ni\020\n`\004=\ni\020\n`\019\nNb[\n!V4\\\ni[&\020U8tjO-tjO-5<!`j\029e\n\020>\n\\!b\nV\004`[\nRi\020e\nb`!iV4`i?`\017ibb\n=w&\020\004b`\ni\020\n!`&\020U\nR<\n4\\`U=\niV4!\nibiU\n\020`5\\\ni\nV\004!`7n\nib\n\020=<\n\020U\n`>i\n==\niV4b`Q`?A_`e<!`>\029\020`R\029=U\n\020e\n\020`5i\020U\n\020`U\n[i=e\nb`ai\\e8tjO-\014i\020`\\\n=<bi>`eiV\004\n\\`j<&?`?ib`a\ni!!\n\020`\v&\020\004b\n\020_`\ni\020`j<&?!b&?wR`&\020e`\ni\020`\004=\ni\020\n\\\n\\`j<&?`?ib`\ni\020\n\\`!\n4\\`bi\nR\n\020`C!bU<[\n=`7a\029[\ni`e\n\\`C[ya\niU`<[U\n!b\029\\[\n\020`&\020e`<[U\n[\\\029V4\n\020`i!b`\b`[\ni?`6\n\\!b\nV\004\n\020`=<U`i\020`ei\n!\n\\`bi\nR\n\020`C!bU<[\n`\ni\020`\\\n=<bi>`U\\\029!!\n\\`b\029b\n\\`C!bA.tjO-j<&?!b&?wR`&\020e`j<&?`?ib`bi\nR\n\\`C!bU<[\n=`!b\n4\n\020`&\020U\nR<\n4\\`<&R`\ni\020\n\\`Bi\020i\n`?ib`e\n?`nV4i=e_`a\n=V4\n!`<&R`ei\n`nV4\\<\020\004\n`4i\020a\ni!b.")
    },
    {
      Text = _xcL("5i\n`<\020`!iV4`!V4\029\020`U\nb<\\\020b\n`C[e\nV\004&\020U`e\n!`j\029e\n\020>\n\\!b\nV\004\n!`i!b`\020\029V4`\ni\020?<=`?ib`B<&[`\029e\n\\`<\n4\020=iV4\n?`[\ne\nV\004b_`!\029`e<!!`\ni\020`y&R<\n==iU`>\029\\[\ni\004\029??\n\020e\n\\`\017&UU\n=`U<\\<\020bi\n\\b`\020iV4b!`\n\020e\nV\004b.")
    },
    {
      Text = _xcL("jibb\n`<\020!V4=i\n!!\n\020e`ai\ne\n\\`!\029`b<\\\020\n\020_`e<!!`e<!`6\n\\!b\nV\004`I&<!i`&\020!iV4b[<\\`i!b`7y.`j.`?ib`B<&[A.tjO-jibb\n`\020iV4b`?ib`eiV\004\n\020`C\n!b\n\020`\029e\n\\`<\n4\020=iV4\n?`\006b<\\\020\n\020\006.tjO-tjO-\017ib`z\029b\029`&\020e`\019\nNb[\n!V4\\\ni[&\020U`Ri\020e\n\020`\020<V4R\029=U\n\020e\n`m<V4\n\\`e<!`6\n\\!b\nV\004`<&V4`\0294\020\n`\ni\020\n`<&RR<\n==iU\n`\006\019<\\\020&\020U\006.")
    }
  })
end
function _tEN:OnClick()
  _Urwigo.OldDialog({
    {
      Text = _xcL("j\ni`e\n?`6\n\\!b\nV\004`4<\020e\n=b`\n!`!iV4_`ai\n`[\ni`e\n\020`zi\020<=!`>\029\020`nb&R\n`v`&\020e`(_`&?`\ni\020`j\029e\n\020>\n\\!b\nV\004.tjO-5i\n!\n!`\017<=`<==\n\\ei\020U!`&\020b\n\\`\ni\020\n\\`j<&?!V4\ni[\n`7e<!`D\\iUi\020<=>\n\\!b\nV\004`i!b`>\n\\!V4a&\020e\n\020A.")
    },
    {
      Text = _xcL("5<!`nw\029i=\n\\[i=e`!\029==b\n`H\ne\029V4`<&!U\n!w\\\029V4\n\020`4i=R\\\niV4`!\ni\020.")
    },
    {
      Text = _xcL("r&\\`niV4\n\\4\nib`H\nbyb`<[\n\\`<&V4`\020\029V4`\ni\020\n`\004=\ni\020\n`\019\nNb[\n!V4\\\ni[&\020U8tjO-tjO-5i\n`j<&?!V4\ni[\n_`&\020b\n\\`e\n\\`!iV4`e<!`j\029e\n\020>\n\\!b\nV\004`[\nRi\020e\nb_`=i\nUb`yai!V4\n\020`ya\ni`j<&?!b&\n?wR\n\020_`a\029[\ni`e\n\\`\ni\020\n`ei\n!\n\\`nb&\n?wR\n`\ni\020\n\020`U\\&\n\020\n\020`\v&\020\004b`<&Ra\ni!b.")
    },
    {
      Text = _xcL("5i\n`j<&?!b&\n?wR\n`[\nRi\020e\n\020`!iV4`<&R`\ni\020\n\\`U\n\\<e\n\020`Bi\020i\n`>\029\020`\ni\020\n\\`U<\020y`H&\020U\n\020`7Ui=b`R&\n\\!`o<4\\`(+v\027A`ji\\\004\n`7g\bz\029\\?A`<?`9\nU`y&`\ni\020\n\\`?<\\\004<\020b\n\020`\014iV4\n.")
    },
    {
      Text = _xcL("z&\n\\`e\n\020`z<==_`e<!!`ei\n`nw\029i=\n\\`\020iV4b`<&!\\\niV4\n\020_`Ui[b`\n!`<&V4`\020\029V4`\ni\020`a\nib\n\\\n!`nw\029i=\n\\[i=e`i?`Bi!bi\020U.")
    }
  })
end
function _IIuy:OnClick()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("\014iU\n\020b=iV4`4<bb\n`iV4`U\ne<V4b_`e<!!`ei\n!\n`C&RU<[\n`\nNb\\\n?`=\niV4b`!\ni.")
    },
    {
      Text = _xcL("De\n\\`a\029==b\n!b`e&`ei\n!\n\020`L\020\029wR`\ni\020R<V4`?<=`<&!w\\\029[i\n\\\n\020;")
    },
    {
      Text = _xcL("De\n\\`>i\n==\niV4b`!i\020e`ei\n`O\n!b\n`\020<V4`&\n[\n\\`v++`o<4\\\n\020`H\nbyb`w=\029\nby=iV4`e\029V4`>\n\\!V4a&\020e\n\020`7!\n4\\`&\020a<4\\!V4\ni\020=iV4_`<[\n\\`\020<b&\n\\=iV4`\020iV4b`<&!y&!V4=i\n!!\n\020A.")
    },
    {
      Text = _xcL("De\n\\`e&`[i!b`\ni\020R<V4`\020&\\`y&`[=\029\ne.")
    },
    {
      Text = _xcL("z&\n\\`e\n\020`z<==_`e<!!`e&`ei\n`O\n!b\n`b<b!<\nV4=iV4`\020iV4b`Ri\020e\n!b`7a\ni=`!i\n`\020iV4b`?\n4\\`Ri\020e[<\\`!i\020e`\029e\n\\`e&`y&`[=\029\ne`[i!bA_`\004<\020\020`iV4`ei\\`\ni\020\n`\020\029V4`\ni\020R<V4\n\\\n`C=b\n\\\020<bi>\n`<\020[i\nb\n\020.")
    },
    {
      Text = _xcL("6i\n==\niV4b`4<!b`e&`ei\n`O\n!b\n`<&V4`\n\020be\nV\004b_`<[\n\\`e&`ai==!b`e<`\020iV4b`4i\020_`a\ni=`\n!`ei\\`y&`?<b!V4iU`i!b.tjO-\028\020`e\n?`z<==`!\029==b\n!b`e&`ei\n`C=b\n\\\020<bi>\n`=i\n[\n\\`\020iV4b`a<\n4=\n\020_`e<`ei\n!\n`\020\029V4`?<b!V4iU\n\\`!\ni\020`ai\\e.")
    },
    {
      Text = _xcL("n\029[<=e`e&`ei\n`\020\029V4`\ni\020R<V4\n\\\n`7<[\n\\`>i\n==\niV4b`?<b!V4iU\n\\\nA`C=b\n\\\020<bi>\n`U\na<\n4=b`4<!b_`ai\\e`ei\n`<=b\n`>\n\\!b\nV\004b\n`r\029\020\n`e\n<\004bi>i\n\\b`&\020e`ei\n`\020\n&\n`<\004bi>i\n\\b."),
      Buttons = {
        _xcL("C=b\n\\\020<bi>\n|"),
        _xcL("5\029V4`\020iV4b|")
      }
    }
  }, function(action)
    if action == "Button1" == true then
      _Urwigo.OldDialog({
        {
          Text = _xcL("5\ni\020\n`\020\029V4`\ni\020R<V4\n\\\n`C&RU<[\n`=<&b\nb`H\nbyb8tjO-tjO-zi\020e\n`\ni\020\n\020`<&RR<\n==iU\n\020`4\0294\n\020`j<&?!b&?wR`&\020e`[\nUi[`eiV4`e\029\\b`4i\020`7>\n\\!b\nV\004b\n`r\029\020\nA.")
        },
        {
          Text = _xcL(")\020e`R&\n\\`5&??i\n!`[\nRi\020e\nb`!iV4`!\029U<\\`\ni\020`nw\029i=\n\\[i=e`i\020`e\ni\020\n?`\028\020>\n\020b<\\.")
        }
      })
      _IIuy:MoveTo(nil)
      _xwK.Active = false
      _MqId:MoveTo(Player)
      _Xdc.Active = true
      _kH04N:MoveTo(nil)
    end
  end)
end
function _MqId:OnClick()
  _Urwigo.MessageBox({
    Text = _xcL("\014iU\n\020b=iV4`\004<&?`y&`&\n[\n\\!\n4\n\020|"),
    Media = _v9k
  })
end
function _Urwigo.GlobalZoneEnter()
  Wherigo.PlayAudio(_2xbNn)
end
function _8lK()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("\028V4`U\n4\n`?<=`e<>\029\020`<&!_`e<!!`e&`eiV4`7y.`j.`&\n[\n\\`ei\n`>\n\\=i\020\004b\n`3\\<Ri\004`i?`Bi!bi\020UA`[\ny&\nU=iV4`e\n!`<\004b&\n==\n\020`\v\nU\n=!b<\020e\n!`i?`\014e\n\\!\n\n`!V4=<&`U\n?<V4b`4<!b.")
    },
    {
      Text = _xcL("5i\n`\ni\020y\n=\020\n\020`nb&R\n\020`!i\020e`){3\014zC\014\127O`<[`R\029=U\n\020e\n\020`\v\nU\n=!b<\n\020e\n\020`!wi\n=[<\\8tjO-tjO-nb&R\n`v8`(Qv_2`?tjO-nb&R\n`(8`((\027`?tjO-nb&R\n`Q8`((+_2`?tjO-tjO-{<b&\n\\=iV4`Ui[b`\n!`4i\n\\`\ni\020\n\020`U\nai!!\n\020`nwi\n=\\<&?`&\020e`e&`\004<\020\020!b`e\ni\020`3=&\nV\004`U\n\\\020\n`<&V4`!V4\029\020`[\ni`\ni\020\n?`4\029\n4\n\\\n\020`\v\nU\n=!b<\020e`>\n\\!&V4\n\020.")
    },
    {
      Text = _xcL("n\029==b\n!b`e&`eiV4`U=\niV4`R&\n\\`\020&\\`\ni\020\n`\ni\020y\n=\020\n`nb&R\n`\n\020b!V4\nie\n\020`&\020e`a<\n4\\\n\020e`e\n!`nwi\n=\n!`R\n!b!b\n==\n\020_`e<!!`ei\n!\n`[\ni?`<\004b&\n==\n\020`\v\nU\n=!b<\020e`e\029V4`\020iV4b`?<V4[<\\`i!b_`?&!!b`e&`ei\n`m<\\b\\ieU\n`a\0294=`=\nie\n\\`[\n\n\020e\n\020`&\020e`\020\029V4`?<=`ai\ne\n\\\004\029??\n\020.tjO-5<!`!\029==b\n`!iV4`<[\n\\`a<4\\!V4\ni\020=iV4`!\n4\\`R\\&\n4`i?`nwi\n=`y\niU\n\020.")
    },
    {
      Text = _xcL("9<\n4=!b`e&`4i\020U\nU\n\020`ya\ni`\029e\n\\`!\029U<\\`<==\n`e\\\ni`nb&R\n\020`<&!_`!\029`ai\\e`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`\ni\020`\006\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\006`[\nRi\020e\n\020_`e\n\020`e&`[\n\020&by\n\020`\004<\020\020!b_`&?`i?`6\n\\=<&R`e\n!`nwi\n=\n!`ei\n`4\029\nV4!b\n`nb&R\n`<&!`e\n\\`C&!a<4=`ai\ne\n\\`y&`\n\020bR\n\\\020\n\020_`!\029`e<!!`e&`b\\\029bye\n?`a\nib\n\\!wi\n=\n\020`\004<\020\020!b.")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_YIDHU)
    end)
  end)
end
function _GKa9i()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("9i\n`ei\\`!iV4\n\\=iV4`!V4\029\020`e&\\V4!`B\n!\n\020`e\n!`Bi!bi\020U!`[\n\004<\020\020b`i!b_`ai\\e`eiV4`ei\n!\n`m<\\b\\ieU\n`y&`\ni\020iU\n\020`[\n!\029\020e\n\\\n\020`B\029V<bi\029\020!`\\&\020e`&?`e\n\020`\014e\n\\!\n\n`R&\n4\\\n\020.")
    },
    {
      Text = _xcL("5i\n`?\ni!b\n\020`D\\b\n`=i\nU\n\020`e<[\ni`\ni\020\n\020`3\\\029!!b\ni=`e\n!`o<4\\\n!`&\020b\n\\`9<!!\n\\`&\020e`!i\020e`\020&\\`[\ni`w<!!\n\020e\n?`\v\nU\n=!b<\020e`\0294\020\n`\127i=R!?ibb\n=`y&`\n\\\\\niV4\n\020.")
    },
    {
      Text = _xcL("C&R`H\ne\n\020`z<==`ai\\e`ei\n`\n\\!b\n`r\029\020\n_`ei\n`e&`[\n!&V4\n\020`?&!!b_`<?`\020\029\n\\e=iV4\n\020`O<\020e`e\n!`\014e\n\\!\n\n!`=i\nU\n\020`&\020e`e\ni\020\n`O\ni!\n`ai\\e`eiV4`i?`)4\\y\niU\n\\!i\020\020`\ni\020?<=`&?`e\n\020`\014e\n\\!\n\n`4\n\\&?R&\n4\\\n\020.`\028?`n&\ne\n\020_`i\020`e\n\\`{<\n4\n`e\n!`D\\b\n!`j\\i\020U4<&!\n\020_`ai\\e`e<!`C[\n\020b\n&\n\\`!\ni\020`\014\020e\n`Ri\020e\n\020.")
    },
    {
      Text = _xcL("z&\n\\`<==\n`e\\\ni`nb&R\n\020`y&!<??\n\020`?&!!b`e&`\nba<`Q+`[i!`Q2`\004?`?ib`e\n?`C&b\029`7\029e\n\\`z<4\\\\<eA`y&\\&\nV\004=\nU\n\020.")
    },
    {
      Text = _xcL("9\n\020\020`e&`\020&\\`\ni\020\n`\ni\020y\n=\020\n`nb&R\n`<&!a<\n4=!b_`>\n\\\\i\020U\n\\b`!iV4`ei\n`nb\\\nV\004\n_`ei\n`?ib`e\n?`C&b\029`y&\\&\nV\004U\n=\nUb`a\n\\e\n\020`?&!!_`\020&\\`U\n\\i\020UR&\nUiU.tjO-6\029\020`e<4\n\\`[i\nb\nb`\n!`!iV4`!\n4\\`<\020_`?\n4\\\n\\\n`nb&R\n\020`<&R`\ni\020?<=`y&`!wi\n=\n\020_`!\029R\n\\\020`e\n\\`\v\nU\n=!b<\020e`ei\n!`y&=<\n!!b.")
    },
    {
      Text = _xcL("\028V4`4<[\n`?iV4`[\n?&\n4b_`R&\n\\`H\ne\n`r\029\020\n_`ei\n`?<\020`<&R!&V4\n\020`?&!!_`e\n\020`[\n!b?\029\nU=iV4\n\020`\v<\\\004w=<by`\\<&!y&!&V4\n\020`7\vvA`&\020e`R&\n\\`e\n\020`z<==_`e<!!`e\029\\b`\004\ni\020`\v=<by`?\n4\\`R\\\ni`!\ni\020`!\029==b\n_`?\ni!b`\020\029V4`\ni\020\n`C=b\n\\\020<bi>\n`7\v(A`<\020y&[i\nb\n\020.")
    },
    {
      Text = _xcL("\028\020`e\n\\`{<\n4\n`\ni\020iU\n\\`r\029\020\n\020`\004\029\020\020b\n`iV4`=\nie\n\\`\004\ni\020\n`=\nU<=\n\020`\004\029!b\n\020=\029!b\n\020`\v<\\\004w=<\nby\n`\n\020be\nV\004\n\020.tjO-j\ni`e\n\020`>\029\020`?i\\`>\029\\U\n!V4=<U\n\020\n\020`\v<\\\004w=<\nby\n\020`?&!!`?<\020`e<\020\020`=\nie\n\\`v`\014&\\\029`\029e\n\\`b\ni=a\ni!\n`!\029U<\\`(`\014&\\\029`y<4=\n\020."),
      Media = _Rc0
    },
    {
      Text = _xcL("\028?`{\nby`4<[\n`iV4`ei\n`\028\020R\029\\?<bi\029\020`7!b<\020e`(+vvA`U\nR&\020e\n\020_`e<!!`ei\n`\019<U\n!\004<\\b\n`R&\n\\`Q`\014&\\\029`<&R`<==\n\020`\v<\\\004w=<\nby\n\020`\\&\020e`&?`e\n\020`\014e\n\\!\n\n`Ui=b.tjO-9\n\020\020`e&`[\n\\\nib`[i!b_`\ni\020\n\020`D[\029=&!`R&\n\\!`\v<\\\004\n\020`y&`[\ny<4=\n\020_`e<\020\020`a<\n\\\n`>\n\\?&b=iV4`!\029`\ni\020\n`\019<U\n!\004<\\b\n`ei\n`[\n!b\n`9<4=.")
    },
    {
      Text = _xcL("C==\n\\ei\020U!`\004<\020\020`iV4`?i\\`\004<&?`>\029\\!b\n==\n\020_`e<!!`i\020`e\n\\`o<4\\\n!y\nib_`i\020`e\n\\`?<\020`ei\n!\n`m<\\b\\ieU\n`!wi\n=\n\020`\004<\020\020_`<\020`e\n\020`\n\020b!w\\\nV4\n\020e\n\020`\v<\\\004w=<\nby\n\020`\\\nU\n=?<\n!!iU`ei\n`\v<\\\004biV\004\nb!`\004\029\020b\\\029==i\n\\b`a\n\\e\n\020.tjO-C[\n\\`\020<b&\n\\=iV4`&\n[\n\\\020\n4?\n`iV4`\004\ni\020\n`6\n\\<\020ba\029\\b&\020U_`!\029==b\n!b`e&`e\029V4`\ni\020`L\020\029\n==V4\n\020`[\n\004\029??\n\020_`a\ni=`e&`<&R`e<!`\v<\\\004biV\004\nb`>\n\\yiV4b\nb`4<!b.")
    },
    {
      Text = _xcL("9iV4biU8tjO-5i\n`\v<\\\004w=<byy\029\020\n\020`?&\n!!\n\020`\020iV4b`<&RU\n!&V4b`a\n\\e\n\020`7\n!`a\n\\e\n\020`e\029\\b`<&V4`\004\ni\020\n`C\004bi\029\020\n\020`<&!U\n=\029\n!bA.`tjO-5&`\004<\020\020!b`<&V4`<\020`[\n=i\n[iU\n\020`<\020e\n\\\n\020`nb\n==\n\020`w<\\\004\n\020`&\020e`eiV4`>\029\020`e\029\\b`ei\\\n\004b`y&\\`\niU\n\020b=iV4\n\020`ri\n=y\029\020\n`[\nU\n[\n\020.")
    },
    {
      Text = _xcL("5i\n`9\nU\n_`ei\n`>\029\020`e\n\020`\v<\\\004w=<\nby\n\020`[i!`y&\\`ri\n=y\029\020\n`U\n=<&R\n\020`a\n\\e\n\020`?&\n!!\n\020_`!i\020e`\b`[i!`<&R`\ni\020\n`C&!\020<4?\n`[\ni`nb&R\n`Q`\b`H\na\ni=!`\\\n=<bi>`\004&\\y.")
    },
    {
      Text = _xcL("C\020`\ni\020iU\n\020`nb<bi\029\020\n\020`?&!!b`e&`\nba<!`?\n!!\n\020.`5&`!\029==b\n!b`<=!\029`U\n\niU\020\nb\n`C&!\\&\n!b&\020U`?ib\020\n4?\n\020`\029e\n\\`4\029RR\n\020_`e<!!`e&`B<\n\020U\n\020`U&b`U\n\020&U`!V4<\nby\n\020`\004<\020\020!b.")
    },
    {
      Text = _xcL(")\020e`H\n`\020<V4`\v\nU\n=!b<\020e`&\020e`>i\n==\niV4b`<&V4`{i\ne\n\\!V4=<\nU\n\020`i\020`e\n\020`=\nbyb\n\020`\019<U\n\020`ai\\!b`e&`3&??i!bi\nR\n=`[\n\020\029\nbiU\n\020.tjO-j\ni`e\n\\`C&!<\\[\nib&\020U`a<\n\\\n`iV4`y&?i\020e\n!b`[\ni`e\n\\`nb&R\n`Q`\0294\020\n`?\ni\020\n`3&??i!bi\nR\n=`<&RU\n!V4?i!!\n\020`U\na\n!\n\020.")
    },
    {
      Text = _xcL("{<V4`H\ne\n\\`\n\\R\029=U\\\niV4`U\n=\029\n!b\n\020`C&RU<[\n`ai\\e`&\n[\\iU\n\020!`<&b\029?<bi!V4`<[U\n!w\niV4\n\\b.tjO-\028V4`\004<\020\020`<==\n\\ei\020U!`\020iV4b`U<\\<\020bi\n\\\n\020_`e<!!`?<\020`i\020`H\ne\n?`z<==`>\029\020`ei\n!\n\020`<[U\n!w\niV4\n\\b\n\020`nwi\n=\n\020`<&!`a\nib\n\\`?<V4\n\020`\004<\020\020.tjO-C[\n\\`ei\n`m4<\020V\n\020`e<R&\n\\`!i\020e`!\n4\\`4\029V4.")
    },
    {
      Text = _xcL(")\020e`H\nbyb`U\n4b`\n!`a\nib\n\\`?ib`e\n\\`nb&R\n\020\bC&!a<4=.")
    },
    {
      Text = _xcL("C&R`e\n?`i\v4\029\020\n`!i\020e`\ni\020`U<\020y`w<<\\`ji=e\n\\`&?`G+`3\\<e`U\ne\\\n4b_`<[\n\\`e<!`ai\\!b`e&`!V4\029\020`>\n\\\004\\<Rb\n\020_`!\029==b\n!b`e&`?ib`\ni\020\n?`!\029=V4\n\020`3\n\\<\nb`!wi\n=\n\020.")
    },
    {
      Text = _xcL("j\ni`\ni\020iU\n\020`C&RU<[\n\020`?&!!b`e&`\n>\n\020b&\n==`[\ni`\ni\020\n\\`z<=!V4\ni\020U<[\n`ei\n`r\029\020\n`>\n\\=<!!\n\020`&\020e`\n\\\020\n&b`[\nb\\\nb\n\020_`&?`\ni\020\n\020`\020\n&\n\020`6\n\\!&V4`y&`[\n\004\029??\n\020.`j\ni`?\ni\020\n\020`\019\n!b!`a<\\`e<!`<==\n\\ei\020U!`\020&\\`[\ni`j\n\020&by&\020U`\ni\020\n!`i\v4\029\020\n!`e\n\\`z<==`&\020e`\020iV4b`[\ni`?\ni\020\n?`C\020e\\\029ie\b\127<\020e^.")
    }
  }, function(action)
    _8lK()
  end)
end
function _RP8U4()
  if _GIhl == true then
    _3FiB.Active = true
  elseif _0NcV == true then
    if _kEjQ == true then
      _uVKJ.Active = true
    else
      _I0oF.Active = true
    end
  else
    _uVKJ.Active = true
  end
end
function __sX()
  if _GIhl == true and _0NcV == false and _kEjQ == false then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n`v`<\004bi>")
    })
  elseif _GIhl == false and _0NcV == true and _kEjQ == false then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n`(`<\004bi>")
    })
  elseif _GIhl == false and _0NcV == false and _kEjQ == true then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n`Q`<\004bi>")
    })
  elseif _GIhl == true and _0NcV == true and _kEjQ == false then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n\020`v`&\020e`(`<\004bi>")
    })
  elseif _GIhl == false and _0NcV == true and _kEjQ == true then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n\020`(`&\020e`Q`<\004bi>")
    })
  elseif _GIhl == true and _0NcV == true and _kEjQ == true then
    _Urwigo.MessageBox({
      Text = _xcL("nb&R\n\020`v_`(`&\020e`Q`<\004bi>")
    })
  end
end
function _opz1N()
  _3FiB.Active = false
  _I0oF.Active = false
  _uVKJ.Active = false
  _afnxp.Active = true
end
function _bR9()
  _cXq.Active = true
  _SdqT.Active = true
  _IyQ.Active = true
  _Urwigo.OldDialog({
    {
      Text = _xcL("\028\020`e\n\020`ei\\\n\004b`!&\ne=iV4`e\n\\`nb<&?<&\n\\`U\n=\nU\n\020\n\020`D\\b!b\ni=`\006\014e\n\\!\n\n\006`e<\\R`?<\020`\020&\\`<=!`C\020a\0294\020\n\\`\029e\n\\`z\n\\i\n\020U<!b`?ib`e\n?`C&b\029`\\\ni\020R<4\\\n\020.")
    },
    {
      Text = _xcL("C==\n`<\020e\n\\\n\020`?&\n!!\n\020`i4\\`C&b\029`<&R`e\n?`U\\\029!!\n\020`\v<\\\004w=<by`<?`D\\b!\ni\020U<\020U`<[!b\n==\n\020`7>\029\020`?i\\`\020<b&\n\\=iV4`<=!`r\029\020\n`\004\n\020\020b=iV4`U\n?<V4bA."),
      Media = _mGG76
    },
    {
      Text = _xcL("n\029==b\n!b`[i!4\n\\`\020\029V4`\020iV4b`[\n\\\nib`U\na\n!\n\020`!\ni\020_`ei\\`\ni\020`\v<\\\004biV\004\nb`y&`\004<&R\n\020`&\020e`<&V4`4i\n\\`U\n\\\020\n`e<\\<&R`>\n\\yiV4b\n\020_`<[\n\\`<&V4`\020iV4b`e<!`Oi!i\004\029`\ni\020U\n4\n\020`a\029==\n\020_`\ni\020`L\020\029\n==V4\n\020`a\nU\n\020`R\n4=\n\020e\n?`\v<\\\004biV\004\nb`y&`[\n\004\029??\n\020_`!\029`\004\029\n\020\020b\n!b`e&`\020<b&\n\\=iV4`\ni\020R<V4`!\029`b&\020_`<=!`a\n\020\020`e&`[\n\\\nV4biUb`a<\n\\!b_`i\020`e\n\020`D\\b`y&`R<4\\\n\020.")
    },
    {
      Text = _xcL("z<==!`e&`<=!\029`ei\n`\004\029!b\n\020=\029!\n`\v<\\\004w=<by<=b\n\\\020<bi>\n`<\020!b\n&\n\\\020`ai==!b_`!\029`!\029==b\n!b`e&`\020<V4`e\n?`\029RRiyi\n==\n\020`\v<\\\004w=<by`ei\n`\n\\!b\n`nb\\<!!\n`\020\n4?\n\020_`ei\n`\020<V4`=i\020\004!`<[U\n4b`7\006C?`3\\<[\n\020\006A`&\020e`ei\n!\n`[i!`y&?`\014\020e\n`R<4\\\n\020.tjO-C?`ri\n=`i!b`\v=<by`R&\n\\`e\\\ni`\029e\n\\`>i\n\\`C&b\029!."),
      Media = _lsf
    },
    {
      Text = _xcL("n\029[<=e`e&`e\ni\020`C&b\029`<[U\n!b\n==b`4<!b`7!\029R\n\\\020`>\029\\4<\020e\n\020A_`?&!!b`e&`\020&\\`\020\029V4`\ni\020\n\020`\004=\ni\020\n\020`nw<yi\n\\U<\020U`y&\\`nb<&?<&\n\\`?<V4\n\020_`&?`ei\n`<\004b&\n==\n`C&RU<[\n`y&`\n\\=\neiU\n\020.")
    }
  })
end
function _NLgzM()
  if _kEjQ == true then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\014!`Ui[b`\020\029V4`ya\ni`a\nib\n\\\n`>\n\\!&\020\004\n\020\n`O\n=i\004b\n_`ei\n`y&\\`5\029\\R!b\n==\n`j\n\\iV4`y<\n4=\n\020_`<&V4`a\n\020\020`!i\n`!iV4`\\<\n&?=iV4`\ni\020`a\n\020iU`a\nib\n\\`\n\020R\n\\\020b`[\nRi\020e\n\020.")
      },
      {
        Text = _xcL("5<[\ni`4<\020e\n=b`\n!`!iV4`&?`e<!`3&b`6\029\\\0204<U\n\020`&\020e`e\n\020`e<y&U\n4\029\n\\iU\n\020`nV4<R!b<==.")
      },
      {
        Text = _xcL("3&b`6\029\\\0204<U\n\020`a<\\`y&\020<\nV4!b`\ni\020\n`!\n=[!b!b<\n\020eiU\n`\017\ni\n\\\ni.`tjO-nw<\nb\n\\`ei\n\020b\n`\n!`i?`9\n!\n\020b=iV4\n\020`y&\\`)\020b\n\\[\\i\020U&\020U`>\029\020`6i\n4`&\020e`\014\\\020b\n>\029\\\\<\nb\n\020."),
        Media = _zH_8h
      },
      {
        Text = _xcL("\028?`o<4\\\n`vGQ\023`a<\\\n\020`4i\n\\`\020\029V4`[\n\ni\020e\\&V\004\n\020\n`O&i\020\n\020`y&`[\na&\020e\n\\\020."),
        Media = _AwC
      },
      {
        Text = _xcL("C==\n\\ei\020U!`a&\\e\n\020`ei\n`>\n\\[=i\n[\n\020\n\020`nb\ni\020\n`a\0294=`\020<V4`&\020e`\020<V4`<=!`j<&?<b\n\\i<=`a\nib\n\\>\n\\a\n\020e\nb.tjO-C&R`e\n?`ji=e`!i\n4b`?<\020`\ni\020\n\020`H&\020U\n\020`\017<\020\020_`ai\n`\n\\`>\n\\?&b=iV4`nb\ni\020\n`<&!`e\n\\`9<\020e`=\029\n!b."),
        Media = _x_X
      },
      {
        Text = _xcL("\127\n&b\n`\004<\020\020`?<\020`4<&wb!<\nV4=iV4`\020&\\`\020\029V4`ei\n`3\\&\020e?<&\n\\\020`[\na&\020e\n\\\020_`<[\n\\`<&V4`\020&\\`<[`\ni\020\n?`\v\nU\n=`>\029\020`\nba<`(vG`?."),
        Media = _kSFzE
      },
      {
        Text = _xcL("5\n\\`y&?`3&b`6\029\\\0204<U\n\020`U\n4\029\n\\\n\020e\n`nV4<R!b<==`=<U`\nba<!`<[!\nib!`&\020e`\020\029V4`e\n&b=iV4`bi\nR\n\\."),
        Media = _d8s
      },
      {
        Text = _xcL("C[`\ni\020\n\020`\v\nU\n=`>\029\020`\nba<`(v\023`?`!\029==b\n\020`ei\n`\n\\!b\n\020`O\n!b\n`<&Rb<&V4\n\020`&\020e`\n\\!b`<[`\ni\020\n?`\v\nU\n=`>\029\020`(+G_\016`?`ei\n`\004\029?w=\nbb\n\020`O&i\020\n\020.")
      },
      {
        Text = _xcL("{<V4`?\ni\020\n\020`O\nV4\n\\V4\n\020`i!b`e\n\\`\v\nU\n=`<[\n\\`\020&\\`\ni\020`\ni\020yiU\n!`\017<=`vG2G`\004\020<ww`&\020b\n\\`(v\023`?`U\nR<==\n\020.")
      },
      {
        Text = _xcL("(+v\002`4<bb\n`\ni\020`\019<&V4b\n<?`ei\n`\014\\=<&[\020i!`[\n\004\029??\n\020_`[\ni?`nV4<R!b<==`y&`b<&V4\n\020.`5i\n`)\n[\n\\\\\n!b\n`a<\\\n\020`\n\\!b<&\020=iV4`U&b`\n\\4<=b\n\020.")
      },
      {
        Text = _xcL("\127i\n\\`\ni\020`\\\nV4b`<\004b&\n==\n`n\029\020<\\[i=e_`a\n=V4\n!`[\ni?`nV4<R!b<==`<&RU\n\020\029??\n\020`a&\\e\n."),
        Media = _PZ35O
      },
      {
        Text = _xcL("5i\n`B<U\n`e\n!`3&b\n!`&\020e`e\n!`nV4<R!b<==\n!`4<[\n`iV4`<=!`r\029\020\n\020`?<\\\004i\n\\b_`a\029[\ni`iV4`\004\ni\020\n`3<\\<\020bi\n`R&\n\\`ei\n`L\029\\\\\n\004b4\nib`&\n[\n\\\020\n4?\n_`e<`iV4`ei\n`r\029\020\n\020`\020iV4b`>\029\\`D\\b`[\n!bi??\n\020`\004\029\020\020b\n.")
      },
      {
        Text = _xcL("5i\n`r\029\020\n\020`?&\n!!\n\020`!\n=[!b>\n\\!b<\n\020e=iV4`\020iV4b`<&RU\n!&V4b`a\n\\e\n\020.")
      }
    }, function(action)
      _mReoG.Active = true
      _apmiY.Active = true
    end)
  end
end
function _VuOSU()
  if _I0oF.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\019H<_`\ni\020\n\020`6\n\\!&V4`a<\\`\n!`a\n\\b.tjO-5<\020\020`?&!!b`e&`4<=b`\020&\\`?ib`e\n\\`nb&R\n`v`a\nib\n\\`?<V4\n\020.tjO-\014i\020\n`\020\n&\n`C&RU<[\n`i!b`H\nbyb`R\\\niU\n!V4<=b\nb."),
      Callback = function(action)
        if action ~= nil then
          _I0oF.Active = false
          _p_T.Active = true
          _lIYn.Active = false
          _euiH2.Active = false
          _Hb3W.Active = false
          _FWV6.Active = false
          _0NcV = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  elseif _JQtI.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`ei\n`C&RU<[\n`[\ni?`z\\i\ne4\029R`i\020`j\n\\iV4`\029RR\n\020[<\\`4i\020[\n\004\029??\n\020`4<!b.tjO-\019&b`?i\\`=\nie_`e<!!`\n!`R&\n\\`eiV4`?ib`nb&R\n`(`<\020`ei\n!\n\\`nb\n==\n`e<\020\020`e\029V4`\020iV4b`a\nib\n\\`U\n4b.tjO-\014i\020\n`\020\n&\n`C&RU<[\n`i!b`H\nbyb`R\\\niU\n!V4<=b\nb."),
      Callback = function(action)
        if action ~= nil then
          _JQtI.Active = false
          _3_2.Active = true
          _YVBK.Active = false
          _ihg7.Active = false
          _6iCkx.Active = false
          _0NcV = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  elseif _jBF9t.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`ei\n`C&RU<[\n\020`[\ni?`z\\i\ne4\029R`i\020`j\n\\iV4`&\020e`[\ni`e\n\020`3=\ni!\n\020`i\020`O\n4[<V4`\029RR\n\020[<\\`4i\020[\n\004\029??\n\020`4<!b.tjO-\019&b`?i\\`=\nie_`e<!!`\n!`R&\n\\`eiV4`?ib`nb&R\n`(`<\020`ei\n!\n\\`nb\n==\n`e<\020\020`e\029V4`\020iV4b`a\nib\n\\`U\n4b.tjO-\014i\020\n`\020\n&\n`C&RU<[\n`i!b`H\nbyb`R\\\niU\n!V4<=b\nb."),
      Callback = function(action)
        if action ~= nil then
          _jBF9t.Active = false
          _3_2.Active = true
          _xQO.Active = false
          _5hre.Active = false
          _cJX.Active = false
          _0NcV = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`e\n\020\004\n_`ei\n`j\n\020&by&\020U`e\n!`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\n!`?<V4b`e\n\\y\nib`\004\ni\020\n\020`ni\020\020_`e<`ei\n`<\004b&\n==\n`C&RU<[\n`y&\\`nb&R\n`v`U\n4\029\n\\b.`tjO-)\020e`a\n\020\020`e&`?ib`ei\n!\n\\`C&RU<[\n`a\nU\n\020`e\n!`\v\nU\n=!b<\020e\n!`\ni\020`\v\\\029[=\n?`4<!b_`e<\020\020`\004<\020\020`ei\\`<&V4`ei\n!\n\\`b\029==\n`L\020\029wR`\020iV4b`a\nib\n\\4\n=R\n\020.")
    })
  end
end
function _PsxQ()
  if _uVKJ.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\019H<_`\ni\020\n\020`6\n\\!&V4`a<\\`\n!`a\n\\b.tjO-5<\020\020`?&!!b`e&`4<=b`\020&\\`?ib`e\n\\`nb&R\n`(`a\nib\n\\`?<V4\n\020.tjO-\014i\020\n`\020\n&\n`C&RU<[\n`i!b`H\nbyb`R\\\niU\n!V4<=b\nb."),
      Callback = function(action)
        if action ~= nil then
          _uVKJ.Active = false
          _I0oF.Active = true
          _pQR.Active = false
          _NaBOl.Active = false
          _aCJ.Active = false
          _4TV.Active = false
          _41Gfk.Active = false
          _rbnc.Active = false
          _Kkc.Active = false
          _aKBkN.Active = false
          _kEjQ = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  elseif _afnxp.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("9\n\020\020`e&`>\029\\4i\020`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\n\\R\029=U\\\niV4`a<\\!b_`!\029`\004<\020\020`\n!`U<\\`\020iV4b`!\ni\020_`e<!!`e\n\\`\v\nU\n=`4i\n\\`<?`\127\029wR\n\020[\n\\U`y&`4\029V4`i!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<!`5\\&\nV\004\n\020`e\n!`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\n!`[\\i\020Ub`ei\\`<\020`ei\n!\n\\`nb\n==\n`\020iV4b!.")
    })
  elseif _5sM.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\029RR\n\020[<\\`\n\\R\029=U\\\niV4`a<\\!b.tjO-n\n4\\`&\020\n\\a<\\b\nb_`e<!!`e&`4i\n\\`e\029V4`\v\\\029[=\n?\n`4<!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<\020\020`i!b`R&\n\\`eiV4`?ib`nb&R\n`Q`=\nie\n\\`<\020`ei\n!\n\\`nb\n==\n`nV4=&!!."),
      Callback = function(action)
        if action ~= nil then
          _5sM.Active = false
          _ybh6.Active = false
          _xwK.Active = false
          _C_G9.Active = false
          _kEjQ = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  elseif _0fzmj.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\029RR\n\020[<\\`\n\\R\029=U\\\niV4`a<\\!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<\020\020`i!b`R&\n\\`eiV4`?ib`nb&R\n`Q`=\nie\n\\`<\020`ei\n!\n\\`nb\n==\n`nV4=&!!.")
      },
      {
        Text = _xcL("C[\n\\`4<=b|tjO-j\nRi\020e\nb`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`H\nbyb`\020iV4b`<&V4`\ni\020tjO-C==\n!\b6i\n=\br&\b\017<b!V4iU\bL\020\029wR;tjO-6i\n==\niV4b`!\029==b\n!b`e&`e\n\020`\n\\!b`\ni\020?<=`[\n\020&by\n\020_`[\n>\029\\`e&`ei\n`nb&R\n`Q`>\029\\\ni=iU`[\n\n\020e\n!b.")
      },
      {
        Text = _xcL("C=!\029`ai==!b`e&`?ib`e\n?`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR`ai\\\004=iV4`a\nib\n\\`?<V4\n\020;"),
        Buttons = {
          _xcL([[
9
ib
\]]),
          _xcL("C[[\\&V4")
        }
      }
    }, function(action)
      if action == "Button1" == true then
        _0fzmj.Active = false
        _gVBA.Active = false
        _lOan.Active = false
        _C_G9.Active = false
        _kEjQ = false
        _MKBn:MoveTo(nil)
        _q88p:MoveTo(nil)
        _Urwigo.MessageBox({
          Text = _xcL("\019&b`?i\\`=\nie_`<[\n\\`e<\020\020`i!b`R&\n\\`eiV4`?ib`nb&R\n`Q`<\020`ei\n!\n\\`nb\n==\n`ai\\\004=iV4`nV4=&!!.")
        })
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`e\n\020\004\n_`ei\n`j\n\020&by&\020U`e\n!`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\n!`?<V4b`e\n\\y\nib`\004\ni\020\n\020`ni\020\020_`e<`ei\n`<\004b&\n==\n`C&RU<[\n`y&\\`nb&R\n`(`U\n4\029\n\\b.`tjO-)\020e`a\n\020\020`e&`?ib`ei\n!\n\\`C&RU<[\n`a\nU\n\020`e\n!`\v\nU\n=!b<\020e\n!`\ni\020`\v\\\029[=\n?`4<!b_`e<\020\020`\004<\020\020`ei\\`<&V4`ei\n!\n\\`b\029==\n`L\020\029wR`\020iV4b`a\nib\n\\4\n=R\n\020.")
    })
  end
end
function _jKjv()
  if _uVKJ.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\019H<_`\ni\020\n\020`6\n\\!&V4`a<\\`\n!`a\n\\b.tjO-5<\020\020`?&!!b`e&`4<=b`\020&\\`?ib`e\n\020`nb&R\n\020`v`&\020e`(`a\nib\n\\`?<V4\n\020.tjO-\014i\020\n`\020\n&\n`C&RU<[\n`i!b`H\nbyb`R\\\niU\n!V4<=b\nb."),
      Callback = function(action)
        if action ~= nil then
          _uVKJ.Active = false
          _0xC.Active = true
          _pQR.Active = false
          _NaBOl.Active = false
          _aCJ.Active = false
          _4TV.Active = false
          _41Gfk.Active = false
          _rbnc.Active = false
          _Kkc.Active = false
          _aKBkN.Active = false
          _kEjQ = false
        end
      end
    })
  elseif _afnxp.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("9\n\020\020`e&`>\029\\4i\020`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\n\\R\029=U\\\niV4`a<\\!b_`!\029`\004<\020\020`\n!`U<\\`\020iV4b`!\ni\020_`e<!!`e\n\\`\v\nU\n=`4i\n\\`<?`\127\029wR\n\020[\n\\U`y&`4\029V4`i!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<!`5\\&\nV\004\n\020`e\n!`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\n!`[\\i\020Ub`ei\\`<\020`ei\n!\n\\`nb\n==\n`\020iV4b!.")
    })
  elseif _5sM.Active == true then
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\029RR\n\020[<\\`\n\\R\029=U\\\niV4`a<\\!b.tjO-n\n4\\`&\020\n\\a<\\b\nb_`e<!!`e&`4i\n\\`e\029V4`\v\\\029[=\n?\n`4<!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<\020\020`i!b`R&\n\\`eiV4`?ib`nb&R\n`Q`=\nie\n\\`<\020`ei\n!\n\\`nb\n==\n`nV4=&!!."),
      Callback = function(action)
        if action ~= nil then
          _5sM.Active = false
          _ybh6.Active = false
          _xwK.Active = false
          _C_G9.Active = false
          _kEjQ = false
          _MKBn:MoveTo(nil)
        end
      end
    })
  elseif _0fzmj.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _xcL("\028V4`4<bb\n`\n\\a<\\b\nb_`e<!!`e&`4i\n\\`\004\ni\020\n`\v\\\029[=\n?\n`?ib`e\n?`\v\nU\n=`4<[\n\020`a&\n\\e\n!b_`e<`e&`[\ni?`nw\n\\\\?<&\n\\?\029e\n==`\029RR\n\020[<\\`\n\\R\029=U\\\niV4`a<\\!b.tjO-\019&b`?i\\`=\nie_`<[\n\\`e<\020\020`i!b`R&\n\\`eiV4`?ib`nb&R\n`Q`=\nie\n\\`<\020`ei\n!\n\\`nb\n==\n`nV4=&!!.")
      },
      {
        Text = _xcL("C[\n\\`4<=b|tjO-j\nRi\020e\nb`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\`H\nbyb`\020iV4b`<&V4`\ni\020tjO-C==\n!\b6i\n=\br&\b\017<b!V4iU\bL\020\029wR;tjO-6i\n==\niV4b`!\029==b\n!b`e&`e\n\020`\n\\!b`\ni\020?<=`[\n\020&by\n\020_`[\n>\029\\`e&`ei\n`nb&R\n`Q`>\029\\\ni=iU`[\n\n\020e\n!b.")
      },
      {
        Text = _xcL("C=!\029`ai==!b`e&`?ib`e\n?`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR`ai\\\004=iV4`a\nib\n\\`?<V4\n\020;"),
        Buttons = {
          _xcL([[
9
ib
\]]),
          _xcL("C[[\\&V4")
        }
      }
    }, function(action)
      if action == "Button1" == true then
        _Urwigo.MessageBox({
          Text = _xcL("5<\020\020`i!b`H\nbyb`R&\n\\`eiV4`?ib`e\n\\`nb&R\n`Q`=\nie\n\\`ai\\\004=iV4`nV4=&!!.")
        })
        _0fzmj.Active = false
        _gVBA.Active = false
        _lOan.Active = false
        _C_G9.Active = false
        _kEjQ = false
        _MKBn:MoveTo(nil)
        _q88p:MoveTo(nil)
      end
    end)
  else
    _Urwigo.MessageBox({
      Text = _xcL("\028V4`e\n\020\004\n_`ei\n`j\n\020&by&\020U`e\n!`\v\nU\n=\b5\029V4\br&\b\127\029V4\bL\020\029wR\n!`?<V4b`e\n\\y\nib`\004\ni\020\n\020`ni\020\020_`e<`ei\n`<\004b&\n==\n`C&RU<[\n`\n\020ba\ne\n\\`y&\\`nb&R\n`v`\029e\n\\`nb&R\n`(`U\n4\029\n\\b.tjO-)\020e`a\n\020\020`e&`?ib`ei\n!\n\\`C&RU<[\n`a\nU\n\020`e\n!`\v\nU\n=!b<\020e\n!`\ni\020`\v\\\029[=\n?`4<!b_`e<\020\020`\004<\020\020`ei\\`<&V4`ei\n!\n\\`b\029==\n`L\020\029wR`\020iV4b`a\nib\n\\4\n=R\n\020.")
    })
  end
end
function _Drx4x()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("DL_`e&`4<!b`\n!`\020iV4b`<\020e\n\\!`U\na\029==b.")
    },
    {
      Text = _xcL("5i\n`j\029H\n`i!b`?ib`\ni\020\n\\`L\nbb\n`[\nR\n!biUb."),
      Media = _yRt2
    },
    {
      Text = _xcL("5\ni\020\n`C&RU<[\n`i!b`\n!`\020&\020_`ei\n`C\020y<4=`e\n\\`L\nbb\n\020U=i\ne\n\\`y&`\n\\?ibb\n=\020.")
    },
    {
      Text = _xcL(")\020e;`tjO-\127<[\n`iV4`y&`>i\n=`>\n\\!w\\\029V4\n\020;tjO-5<!`i!b`e\029V4`a\0294=`ai\\\004=iV4`\ni\020\n`nV4\ni!!\bC&RU<[\n_`\029e\n\\;")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_KaI)
    end)
  end)
end
function _RwfBG()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("5<!!`ei\n!\n`C&RU<[\n`>\n\\?&b=iV4`[\n!V4i!!\n\020`i!b`7y&?i\020e\n!b`[\ni?`B\nU\n\020`ei\n!\n!`m<V4\n!`a<\\`\n!`!\029A_`=i\nUb`a<4\\!V4\ni\020=iV4`<\020`e\n\020`L\029\\?\029\\<\020\n\020_`ei\n`!iV4`U\n\\\020\n`<&R`ei\n!\n\\`j\029H\n`<&R4<=b\n\020.")
    },
    {
      Text = _xcL("n&V4\n`ei\n`nb\n==\n_`a\029`!iV4`e\\\ni`\v\n\\!\029\020\n\020`<&R`\\\nV4b`\\<[i<b\n`C\\b`&\020e`9\ni!\n`>\n\\\naiUb`4<[\n\020.")
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_oRNb)
    end)
  end)
end
function _CKzj6()
  _afnxp.Active = false
  _EsK.Active = false
  _Aqu8.Active = false
  _SdqT.Active = false
  _IyQ.Active = false
  if _0NcV == true then
    _JQtI.Active = true
  elseif _0NcV == false then
    _5sM.Active = true
  end
  _ceLKO()
end
function _CSd()
  _5hre.Active = false
  _xQO.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("C\0204<\020e`e\n\\`j<&?!b&\n?wR\n`\004<\020\020`?<\020`\020\029V4`U&b`e\n\020`6\n\\=<&R`e\n!`\024\020[!w 9\nU\n!`\n\\\004\n\020\020\n\020_`e\n\\`>\029\020`C=b\bj\\i\020U4<&!\n\020`y&?`z\\i\ne4\029R`R&\n4\\b\n."),
      Media = _QAjd
    },
    {
      Text = _xcL("9i\n`<&V4`!V4\029\020`[\ni?`z\\i\ne4\029R`i\020`j\n\\iV4`a&\\e\n\020`<&V4`<&R`e\n?`z\\i\ne4\029R`>\029\020`C=b\bj\\i\020U4<&!\n\020`ei\n`<=b\n\020`3\\<\n[\n\\`?ib`j\nb\029\020<[e\nV\004&\020U\n\020`>\n\\!\n4\n\020.tjO-\127i\n\\`i\020`C=b\bj\\i\020U4<&!\n\020`Ui[b`\n!`H\ne\029V4`ya\ni`3\\<\n[\n\\R\n=e\n\\`&\020e`ei\n`{&??\n\\\020`<&R`e\n\020`3\\<\n[\n\\\020_`ei\n`y&\\`r&\029\\e\020&\020U`ei\n\020\n\020_`!i\020e`[\n!!\n\\`\n\\4<=b\n\020."),
      Media = _RCtz
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_48h5)
    end)
  end)
end
function _WIXAQ()
  _WWB.Active = false
  _w32.Active = true
  _mxHN4.Active = true
  _vzpn.Active = true
  _GZ0WP:MoveTo(Player)
  _BZat:MoveTo(Player)
  _tGF:MoveTo(Player)
  _BI7w:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _xcL("5i\n`zi\020<=\br\029\020\n`R&\n\\`nb&R\n`(`i!b`\020&\020`<\004bi>i\n\\b.tjO-\v<!!\n\020e\n`L\029\029\\ei\020<b\n\020`&\020e`nw\029i=\n\\`[\nRi\020e\n\020`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\.tjO-jibb\n`\020iV4b`?ib`e\n?`C&b\029`y&`\020<4`<\020!`zi\020<=`R<4\\\n\020_`&?`\004\ni\020`\017i!!b\\<&\n\020`[\ni?`o<Uew<\nV4b\n\\`y&`\n\\a\nV\004\n\020.tjO-\014i\020\n\020`\v<\\\004w=<by>\029\\!V4=<U`4<[\n`iV4`U\n?<V4b.")
  })
end
function _Dg7bB()
  _0at6.Active = false
  _n2mHq:MoveTo(Player)
  _2yV0v:MoveTo(Player)
  _ZHm4x:MoveTo(Player)
  _w32.Active = true
  _YFO.Active = true
  _PH0.Active = true
  _CvVXL.Active = false
  _BZat:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _xcL("5i\n`zi\020<=\br\029\020\n`R&\n\\`nb&R\n`v`i!b`\020&\020`<\004bi>i\n\\b.tjO-L\029\029\\ei\020<b\n\020`&\020e`w<!!\n\020e\n`nw\029i=\n\\`[\nRi\020e\n\020`!iV4`\020&\020`i\020`e\ni\020\n?`\028\020>\n\020b<\\.tjO-jibb\n`\020iV4b`?ib`e\n?`C&b\029`y&?`zi\020<=`R<4\\\n\020_`&?`\004\ni\020`\017i!!b\\<&\n\020`[\ni?`o<Uew<\nV4b\n\\`y&`\n\\a\nV\004\n\020.tjO-\014i\020\n\020`\v<\\\004w=<by>\029\\!V4=<U`4<[\n`iV4`U\n?<V4b.")
  })
end
function _bvL5P()
  _w32.Active = true
  _ja5.Active = true
  _rVgz.Active = true
  _SQg.Active = true
  _Ube.Active = false
  __7Z:MoveTo(Player)
  _BZat:MoveTo(Player)
  _rXC:MoveTo(Player)
  _tEN:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _xcL("5i\n`zi\020<=\br\029\020\n`R&\n\\`nb&R\n`Q`i!b`\020&\020`<\004bi>i\n\\b.tjO-\v<!!\n\020e\n`L\029\029\\ei\020<b\n\020`&\020e`nw\029i=\n\\`[\nRi\020e\n\020`!iV4`i\020`e\ni\020\n?`\028\020>\n\020b<\\.tjO-jibb\n`\020iV4b`?ib`e\n?`C&b\029`y&`\020<4`<\020!`zi\020<=`R<4\\\n\020_`&?`\004\ni\020`\017i!!b\\<&\n\020`[\ni?`o<Uew<\nV4b\n\\`y&`\n\\a\nV\004\n\020.tjO-\014i\020\n\020`\v<\\\004w=<by>\029\\!V4=<U`4<[\n`iV4`U\n?<V4b.")
  })
end
function _DFlc()
  _Urwigo.Dialog(false, {
    {
      Text = _xcL("5i\n`j\\&\nV\004\n_`[\ni`e\n\\\n\020`O\n!b\n\020`e&`H\nbyb`!b\n4!b_`a&\\e\n`\n\\!b`v\027G\016`\n\\[<&b.")
    },
    {
      Text = _xcL("{&\\`a\n\020iU\n`o<4\\\n`!w<\nb\n\\`a&\\e\n`!i\n`e<\020\020`>\029\\`e\n\\`z=&b&\020U`e\n!`\014e\n\\!\n\n!`ai\ne\n\\`U\n!w\\\n\020Ub.")
    },
    {
      Text = _xcL("\127i\n\\`?<=`\ni\020`ji=e_`ai\n`!i\n`i\020`e\n\020`a\n\020iU\n\020`o<4\\\n\020`i4\\\n\\`\014Ni!b\n\020!`<&!U\n!\n4\n\020`4<b."),
      Media = _U3jv2
    },
    {
      Text = _xcL("5i\n`=\nbyb\n`C&RU<[\n`4<!b`e&`\020&\020`\n\\R&\n==b`&\020e`y&\\`j\n=\0294\020&\020U`\004<\020\020!b`e&`<[`H\nbyb`H\ne\n\\y\nib`\006zi\020<=`nb&R\n`Q\006`<\004bi>i\n\\\n\020.")
    }
  }, function(action)
    _q88p:MoveTo(nil)
    _MKBn:MoveTo(nil)
    _0fzmj.Active = false
    _C_G9.Active = false
    _bHJ.Active = false
    _Ube.Active = true
    _ceLKO()
  end)
end
function _ceLKO()
  _DSDk:RequestSync()
end
return _DSDk
