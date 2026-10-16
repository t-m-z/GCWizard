require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _TBt27(str)
  local res = ""
  local dtable = "P)[?*4V2%R\0148{\004YO\019Fkf\001unT\026G\030\btj\024\v9\003\n\"]Z\005\031h=L\016\021i6Cc\r1\025K\\_\018\022dw\023\000.graQ0p(o-'z\fXm!b\015}^W;Av\006\029/\020Iq7<3xM:J~U\002lSD\t@> #\017,`ye+B$\028s\0275\aHEN&|"
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
_cEcz = Wherigo.ZCartridge()
_Lm3H = Wherigo.ZMedia(_cEcz)
_Lm3H.Id = "3a84ccd1-72a5-4159-865a-119341051614"
_Lm3H.Name = _TBt27("+.?\022w\029r@;r?")
_Lm3H.Description = ""
_Lm3H.AltText = ""
_Lm3H.Resources = {
  {
    Type = "jpg",
    Filename = "Ligusterweg.jpg",
    Directives = {}
  }
}
_bRH = Wherigo.ZMedia(_cEcz)
_bRH.Id = "41b4b783-3932-4bfe-adb9-f2c220169d30"
_bRH.Name = _TBt27("R.\023\019rf?Awwr")
_bRH.Description = ""
_bRH.AltText = ""
_bRH.Resources = {
  {
    Type = "jpg",
    Filename = "Winkelgasse.jpg",
    Directives = {}
  }
}
_tK_pr = Wherigo.ZMedia(_cEcz)
_tK_pr.Id = "df767cd8-9ac4-45a8-b135-077ba3a583d9"
_tK_pr.Name = _TBt27("\026fr.wl!l^X\006")
_tK_pr.Description = ""
_tK_pr.AltText = ""
_tK_pr.Resources = {
  {
    Type = "jpg",
    Filename = "KingsCross.jpg",
    Directives = {}
  }
}
_ERe = Wherigo.ZMedia(_cEcz)
_ERe.Id = "6913086c-bfb6-47c5-92e4-3f3a003908c7"
_ERe.Name = _TBt27("{F?;A@\029w")
_ERe.Description = ""
_ERe.AltText = ""
_ERe.Resources = {
  {
    Type = "jpg",
    Filename = "Hogwarts.jpg",
    Directives = {}
  }
}
_NGTgz = Wherigo.ZMedia(_cEcz)
_NGTgz.Id = "205efb80-cd10-43eb-a581-140876a8c060"
_NGTgz.Name = _TBt27("hr@l\024@FD\020r\023:rl5rwwrf")
_NGTgz.Description = ""
_NGTgz.AltText = ""
_NGTgz.Resources = {
  {
    Type = "jpg",
    Filename = "DerTropfendeKessel.jpg",
    Directives = {}
  }
}
_BrRPb = Wherigo.ZMedia(_cEcz)
_BrRPb.Id = "b229a08d-2f6d-4976-b542-dd15105aab8b"
_BrRPb.Name = _TBt27("hr@l\ar@NF\029r\023rlRAf:")
_BrRPb.Description = ""
_BrRPb.AltText = ""
_BrRPb.Resources = {
  {
    Type = "jpg",
    Filename = "VerbotenerWald.jpg",
    Directives = {}
  }
}
_KRbwq = Wherigo.ZMedia(_cEcz)
_KRbwq.Id = "1f0c6a66-91b2-40d2-a0e5-0c25e37ee4f7"
_KRbwq.Name = _TBt27("{A@@ql\001F\029\029r@l+F?F")
_KRbwq.Description = ""
_KRbwq.AltText = ""
_KRbwq.Resources = {
  {
    Type = "jpg",
    Filename = "HPLogo.jpg",
    Directives = {}
  }
}
_RQ0 = Wherigo.ZMedia(_cEcz)
_RQ0.Id = "db964b5c-18d5-4f89-986d-d46e6944e982"
_RQ0.Name = _TBt27("{A@@ql\001F\029\029r@l\024)rLr")
_RQ0.Description = ""
_RQ0.AltText = _TBt27("{A@@ql\001F\029\029r@l\024)rLr")
_RQ0.Resources = {
  {
    Type = "wav",
    Filename = "HarryPotterThemeShort.wav",
    Directives = {}
  }
}
_BdA = Wherigo.ZMedia(_cEcz)
_BdA.Id = "3cb8864b-92f5-4f38-819c-d7f4810e5a9c"
_BdA.Name = _TBt27("\n\022Nr\022wl{A?@.:")
_BdA.Description = ""
_BdA.AltText = ""
_BdA.Resources = {
  {
    Type = "jpg",
    Filename = "RubeusHagrid.jpg",
    Directives = {}
  }
}
_uLOgI = Wherigo.ZMedia(_cEcz)
_uLOgI.Id = "56013bec-a6fb-47a1-9a8c-dd5bfd7de7bb"
_uLOgI.Name = _TBt27("\ar@\023F\023lh\022@wfrq")
_uLOgI.Description = ""
_uLOgI.AltText = ""
_uLOgI.Resources = {
  {
    Type = "jpg",
    Filename = "VernonDursley.jpg",
    Directives = {}
  }
}
_0BDe4 = Wherigo.ZMedia(_cEcz)
_0BDe4.Id = "d594b9ba-52bd-4f19-8212-3a65fac05b1f"
_0BDe4.Name = _TBt27("{A@@ql\001F\029\029r@")
_0BDe4.Description = ""
_0BDe4.AltText = ""
_0BDe4.Resources = {
  {
    Type = "jpg",
    Filename = "HarryPotter.jpg",
    Directives = {}
  }
}
_DUP = Wherigo.ZMedia(_cEcz)
_DUP.Id = "7e66a9ba-e1da-45fe-9dd6-f8507b4623f9"
_DUP.Name = _TBt27("\026A@@.1\019l\016ff.UA\023:r@")
_DUP.Description = ""
_DUP.AltText = ""
_DUP.Resources = {
  {
    Type = "jpg",
    Filename = "ollivander.jpg",
    Directives = {}
  }
}
__3SHa = Wherigo.ZMedia(_cEcz)
__3SHa.Id = "144f1e89-72fa-4886-ac79-68a10f5f4b80"
__3SHa.Name = _TBt27("`FffqlRrAwfrq")
__3SHa.Description = ""
__3SHa.AltText = ""
__3SHa.Resources = {
  {
    Type = "jpg",
    Filename = "MollyWeasley.jpg",
    Directives = {}
  }
}
_n6d = Wherigo.ZMedia(_cEcz)
_n6d.Id = "15345347-47a6-47ab-8ee1-7ae032413ead"
_n6d.Name = _TBt27("`.\023r@UAl`1\026F\023A?Aff")
_n6d.Description = ""
_n6d.AltText = ""
_n6d.Resources = {
  {
    Type = "jpg",
    Filename = "MinervaMcGonagall.jpg",
    Directives = {}
  }
}
__z_H = Wherigo.ZMedia(_cEcz)
__z_H.Id = "1fa22560-1cbb-4695-927a-753770a030e4"
__z_H.Name = _TBt27("T@A?F?")
__z_H.Description = ""
__z_H.AltText = ""
__z_H.Resources = {
  {
    Type = "jpg",
    Filename = "Aragog.jpg",
    Directives = {}
  }
}
_PRI = Wherigo.ZMedia(_cEcz)
_PRI.Id = "0860de03-521f-466c-8bb2-188c471c8ffe"
_PRI.Name = _TBt27("\001Fw\029r\022fr")
_PRI.Description = ""
_PRI.AltText = ""
_PRI.Resources = {
  {
    Type = "jpg",
    Filename = "Posteule.jpg",
    Directives = {}
  }
}
_1NLg = Wherigo.ZMedia(_cEcz)
_1NLg.Id = "ef31a65a-dcd5-468e-8bf3-834775ec53f1"
_1NLg.Name = _TBt27("t@.r\020lUF\023l{F?;A@\029w")
_1NLg.Description = ""
_1NLg.AltText = ""
_1NLg.Resources = {
  {
    Type = "JPG",
    Filename = "Brief.JPG",
    Directives = {}
  }
}
_Zjn = Wherigo.ZMedia(_cEcz)
_Zjn.Id = "39b9cd52-805c-4745-8874-0af7087748b0"
_Zjn.Name = _TBt27("Z\023wrflL.\029l\024\022@L")
_Zjn.Description = ""
_Zjn.AltText = ""
_Zjn.Resources = {
  {
    Type = "jpg",
    Filename = "Insel.jpg",
    Directives = {}
  }
}
_DkN8a = Wherigo.ZMedia(_cEcz)
_DkN8a.Id = "671de5e3-f29c-4f45-b7ec-44a91668ceb0"
_DkN8a.Name = _TBt27("\026@.\023?F\029\029w")
_DkN8a.Description = ""
_DkN8a.AltText = ""
_DkN8a.Resources = {
  {
    Type = "jpg",
    Filename = "Gringotts.jpg",
    Directives = {}
  }
}
_gJv = Wherigo.ZMedia(_cEcz)
_gJv.Id = "83919a32-c9f5-4f0b-85b5-61177462b15f"
_gJv.Name = _TBt27("\016ff.UA\023:r@")
_gJv.Description = ""
_gJv.AltText = ""
_gJv.Resources = {
  {
    Type = "jpg",
    Filename = "OllivandersZauberstabe.jpg",
    Directives = {}
  }
}
_2byTd = Wherigo.ZMedia(_cEcz)
_2byTd.Id = "fb1859ea-9150-41ca-924f-4749475df191"
_2byTd.Name = _TBt27("\018fF\022@.w)l\022\023:ltfF\029\029w")
_2byTd.Description = ""
_2byTd.AltText = ""
_2byTd.Resources = {
  {
    Type = "jpg",
    Filename = "FlourishUndBlotts.jpg",
    Directives = {}
  }
}
_YKB = Wherigo.ZMedia(_cEcz)
_YKB.Id = "168f2542-293f-4743-a9a2-10980657d3ab"
_YKB.Name = _TBt27("\001F\029A?rwl5rwwrffA:r\023")
_YKB.Description = ""
_YKB.AltText = ""
_YKB.Resources = {
  {
    Type = "jpg",
    Filename = "PotagesKesselladen.jpg",
    Directives = {}
  }
}
__ny6r = Wherigo.ZMedia(_cEcz)
__ny6r.Id = "df07bbd8-7f53-4dfe-951f-df6b7871239c"
__ny6r.Name = _TBt27("`A:ALl`Af\019.\023w")
__ny6r.Description = ""
__ny6r.AltText = ""
__ny6r.Resources = {
  {
    Type = "jpg",
    Filename = "MadamMalkins.jpg",
    Directives = {}
  }
}
_gzWDT = Wherigo.ZMedia(_cEcz)
_gzWDT.Id = "937392e9-34ce-4929-8492-5d98ed6613e3"
_gzWDT.Name = _TBt27("tA1\019w\029r.\023LA\022r@")
_gzWDT.Description = ""
_gzWDT.AltText = ""
_gzWDT.Resources = {
  {
    Type = "JPG",
    Filename = "Backsteinmauer.JPG",
    Directives = {}
  }
}
_epB4W = Wherigo.ZMedia(_cEcz)
_epB4W.Id = "449e4212-e14d-4b81-906d-f4392c6c3ecc"
_epB4W.Name = _TBt27("`A\022r@")
_epB4W.Description = ""
_epB4W.AltText = ""
_epB4W.Resources = {
  {
    Type = "JPG",
    Filename = "Mauer.JPG",
    Directives = {}
  }
}
_yWA = Wherigo.ZMedia(_cEcz)
_yWA.Id = "ccc2fbf3-53b3-4e03-bfdc-6ffca6857e4d"
_yWA.Name = _TBt27("5rwwrf")
_yWA.Description = ""
_yWA.AltText = ""
_yWA.Resources = {
  {
    Type = "jpg",
    Filename = "Kessel.jpg",
    Directives = {}
  }
}
_tYSC = Wherigo.ZMedia(_cEcz)
_tYSC.Id = "4bde4f1d-a792-4c76-9cca-1ed1811ea565"
_tYSC.Name = _TBt27("\001AD.r@l\022\023:l\018r:r@")
_tYSC.Description = ""
_tYSC.AltText = ""
_tYSC.Resources = {
  {
    Type = "jpg",
    Filename = "PapierUndFeder.jpg",
    Directives = {}
  }
}
_5I9A = Wherigo.ZMedia(_cEcz)
_5I9A.Id = "54c01867-b823-4ff4-b013-7c1acee80f83"
_5I9A.Name = _TBt27("\026AffrF\023r\023")
_5I9A.Description = ""
_5I9A.AltText = ""
_5I9A.Resources = {
  {
    Type = "jpg",
    Filename = "Sickel.jpg",
    Directives = {}
  }
}
_Sr0 = Wherigo.ZMedia(_cEcz)
_Sr0.Id = "0a27dcbc-51b2-485c-9dde-8c62f01ebb6c"
_Sr0.Name = _TBt27("dL)A\023?")
_Sr0.Description = ""
_Sr0.AltText = ""
_Sr0.Resources = {
  {
    Type = "jpg",
    Filename = "Umhang.jpg",
    Directives = {}
  }
}
_WSQ = Wherigo.ZMedia(_cEcz)
_WSQ.Id = "3aa44497-c857-479d-b450-248000534c62"
_WSQ.Name = _TBt27("&A\022Nr@w\029AN7Af\029")
_WSQ.Description = ""
_WSQ.AltText = ""
_WSQ.Resources = {
  {
    Type = "jpg",
    Filename = "Zauberstab.jpg",
    Directives = {}
  }
}
_hRY = Wherigo.ZMedia(_cEcz)
_hRY.Id = "2f5b656e-3fc9-4223-b17a-2dfa4efe204e"
_hRY.Name = _TBt27("t\195\1881)r@")
_hRY.Description = ""
_hRY.AltText = ""
_hRY.Resources = {
  {
    Type = "jpg",
    Filename = "Buecher.jpg",
    Directives = {}
  }
}
_k08is = Wherigo.ZMedia(_cEcz)
_k08is.Id = "ac85df64-319d-4487-8017-181f605ed8a5"
_k08is.Name = _TBt27("&A\022Nr@\029@A\023\019\020fAw1)r\023")
_k08is.Description = ""
_k08is.AltText = ""
_k08is.Resources = {
  {
    Type = "jpg",
    Filename = "Zaubertrankflaschen.jpg",
    Directives = {}
  }
}
_xWl = Wherigo.ZMedia(_cEcz)
_xWl.Id = "24def239-558a-40c8-97ed-0bf62c034123"
_xWl.Name = _TBt27("5@A;A\029\029rl\026@q\020\020.\023:F@")
_xWl.Description = ""
_xWl.AltText = ""
_xWl.Resources = {
  {
    Type = "jpg",
    Filename = "Krawatte1.jpg",
    Directives = {}
  }
}
_GD5Ln = Wherigo.ZMedia(_cEcz)
_GD5Ln.Id = "552cd80b-4e62-4bb1-83d5-8636b04412f8"
_GD5Ln.Name = _TBt27("\ar@f.rwl/\f\\")
_GD5Ln.Description = ""
_GD5Ln.AltText = ""
_GD5Ln.Resources = {
  {
    Type = "jpg",
    Filename = "Verlies_687.jpg",
    Directives = {}
  }
}
_xm3Zd = Wherigo.ZMedia(_cEcz)
_xm3Zd.Id = "66e2e149-e17f-4942-aed4-14fbaf16d1e7"
_xm3Zd.Name = _TBt27("t\0221)")
_xm3Zd.Description = ""
_xm3Zd.AltText = ""
_xm3Zd.Resources = {
  {
    Type = "jpg",
    Filename = "AltesBuch.jpg",
    Directives = {}
  }
}
_jYrl = Wherigo.ZMedia(_cEcz)
_jYrl.Id = "e978a7a2-1489-4321-9baf-933467fc80a6"
_jYrl.Name = _TBt27("\026r@w\029r")
_jYrl.Description = ""
_jYrl.AltText = _TBt27("\026r@w\029r")
_jYrl.Resources = {
  {
    Type = "jpg",
    Filename = "Gerste.jpg",
    Directives = {}
  }
}
_dwn = Wherigo.ZMedia(_cEcz)
_dwn.Id = "ec911f75-a4dc-49cc-97ef-e444dca66c13"
_dwn.Name = _TBt27("{r\020r")
_dwn.Description = ""
_dwn.AltText = _TBt27("{r\020r")
_dwn.Resources = {
  {
    Type = "jpg",
    Filename = "Hefe.jpg",
    Directives = {}
  }
}
_USCN = Wherigo.ZMedia(_cEcz)
_USCN.Id = "17dc2e09-c833-4075-8bec-d3ccd1a35370"
_USCN.Name = _TBt27("{.@wr")
_USCN.Description = ""
_USCN.AltText = _TBt27("{.@wr")
_USCN.Resources = {
  {
    Type = "jpg",
    Filename = "Hirse.jpg",
    Directives = {}
  }
}
_GuMxK = Wherigo.ZMedia(_cEcz)
_GuMxK.Id = "36f07419-241d-4282-ae89-a2ee57ed72ca"
_GuMxK.Name = _TBt27("{FD\020r\023")
_GuMxK.Description = ""
_GuMxK.AltText = _TBt27("{FD\020r\023")
_GuMxK.Resources = {
  {
    Type = "jpg",
    Filename = "Hopfen.jpg",
    Directives = {}
  }
}
_dcVF = Wherigo.ZMedia(_cEcz)
_dcVF.Id = "4610d955-5f41-4bcd-b336-b7293cb6ed51"
_dcVF.Name = _TBt27("5A@:ALF\023")
_dcVF.Description = ""
_dcVF.AltText = _TBt27("5A@:ALF\023")
_dcVF.Resources = {
  {
    Type = "jpg",
    Filename = "Kardamon.jpg",
    Directives = {}
  }
}
_lF2Y = Wherigo.ZMedia(_cEcz)
_lF2Y.Id = "af3cda34-a2c0-4ab5-af10-6c0b579ed313"
_lF2Y.Name = _TBt27("`AfI")
_lF2Y.Description = ""
_lF2Y.AltText = _TBt27("`AfI")
_lF2Y.Resources = {
  {
    Type = "jpg",
    Filename = "Malz.jpg",
    Directives = {}
  }
}
_1_ZR1 = Wherigo.ZMedia(_cEcz)
_1_ZR1.Id = "40ef9b55-95e8-40ab-8ce2-d85795e4c33e"
_1_ZR1.Name = _TBt27("\016@A\023?r\023w1)Afr\023")
_1_ZR1.Description = ""
_1_ZR1.AltText = _TBt27("\016@A\023?r\023w1)Afr\023")
_1_ZR1.Resources = {
  {
    Type = "jpg",
    Filename = "Orangenschalen.jpg",
    Directives = {}
  }
}
_3ge = Wherigo.ZMedia(_cEcz)
_3ge.Id = "66997841-9ca2-4504-99d3-23e9fa890891"
_3ge.Name = _TBt27("\nF??r\023")
_3ge.Description = ""
_3ge.AltText = _TBt27("\nF??r\023")
_3ge.Resources = {
  {
    Type = "jpg",
    Filename = "Roggen.jpg",
    Directives = {}
  }
}
_z9c = Wherigo.ZMedia(_cEcz)
_z9c.Id = "8ed578e9-03bc-47fe-9d4d-5dfa54f6367a"
_z9c.Name = _TBt27("RAwwr@")
_z9c.Description = ""
_z9c.AltText = _TBt27("RAwwr@")
_z9c.Resources = {
  {
    Type = "jpg",
    Filename = "Wasser.jpg",
    Directives = {}
  }
}
_WC9Et = Wherigo.ZMedia(_cEcz)
_WC9Et.Id = "3cbd5d55-ce29-42f9-9e91-4627b9d0cff2"
_WC9Et.Name = _TBt27("Rr.Ir\023")
_WC9Et.Description = ""
_WC9Et.AltText = _TBt27("Rr.Ir\023")
_WC9Et.Resources = {
  {
    Type = "jpg",
    Filename = "Weizen.jpg",
    Directives = {}
  }
}
_KFo = Wherigo.ZMedia(_cEcz)
_KFo.Id = "0eb8da3b-e837-4fd4-88fa-fb5f113ed605"
_KFo.Name = _TBt27("t\022\029\029r@N.r@")
_KFo.Description = ""
_KFo.AltText = ""
_KFo.Resources = {
  {
    Type = "jpg",
    Filename = "Butterbier.jpg",
    Directives = {}
  }
}
_AhdW = Wherigo.ZMedia(_cEcz)
_AhdW.Id = "f3a1f068-8a70-4d9a-8846-f2b3b3e61fd0"
_AhdW.Name = _TBt27("\018@r:l\022\023:l\026rF@?r")
_AhdW.Description = ""
_AhdW.AltText = ""
_AhdW.Resources = {
  {
    Type = "jpg",
    Filename = "FredUndGeorge.jpg",
    Directives = {}
  }
}
_6IFAT = Wherigo.ZMedia(_cEcz)
_6IFAT.Id = "af70492b-f089-414d-a2d1-625009cd52a2"
_6IFAT.Name = _TBt27("5A@\029rl:rwl{r@\022L\029@r.Nr@w")
_6IFAT.Description = ""
_6IFAT.AltText = ""
_6IFAT.Resources = {
  {
    Type = "jpg",
    Filename = "KarteDesHerumtreibers.jpg",
    Directives = {}
  }
}
_SN75x = Wherigo.ZMedia(_cEcz)
_SN75x.Id = "5beb8392-f63c-4270-acea-9f25528855f0"
_SN75x.Name = _TBt27("g.@.\022wltfA1\019")
_SN75x.Description = ""
_SN75x.AltText = ""
_SN75x.Resources = {
  {
    Type = "jpg",
    Filename = "Sirius_Black.jpg",
    Directives = {}
  }
}
_Gsqp = Wherigo.ZMedia(_cEcz)
_Gsqp.Id = "c83cba21-ff8c-49b2-83bc-9cf07bc44f04"
_Gsqp.Name = _TBt27("\ar@\023F\023")
_Gsqp.Description = _TBt27("R.@l\020A)@r\023l;r?")
_Gsqp.AltText = _TBt27("\ar@\023F\023")
_Gsqp.Resources = {
  {
    Type = "wav",
    Filename = "Vernon.wav",
    Directives = {}
  }
}
_a0U = Wherigo.ZMedia(_cEcz)
_a0U.Id = "80a67af1-7bd4-498a-8700-ef48eaed2f2a"
_a0U.Name = _TBt27("h\022lN.w\029lr.\023l&A\022Nr@r@")
_a0U.Description = _TBt27("h\022lN.w\029lr.\023l&A\022Nr@r@l{A@@q")
_a0U.AltText = _TBt27("h\022lN.w\029lr.\023l&A\022Nr@r@")
_a0U.Resources = {
  {
    Type = "wav",
    Filename = "DuBistEinZauberer.wav",
    Directives = {}
  }
}
_nbIVv = Wherigo.ZMedia(_cEcz)
_nbIVv.Id = "df125db7-79a7-47b5-a196-7d27dff3a304"
_nbIVv.Name = _TBt27("R.ff\019FLLr\023l.\023l:r@lR.\023\019rf?Awwr")
_nbIVv.Description = _TBt27("R.ff\019FLLr\023l{A@@ql.\023l:r@lR.\023\019rf?Awwr")
_nbIVv.AltText = _TBt27("R.ff\019FLLr\023l.\023l:r@lR.\023\019rf?Awwr")
_nbIVv.Resources = {
  {
    Type = "wav",
    Filename = "WillkommenInDerWinkelgasse.wav",
    Directives = {}
  }
}
_VArS = Wherigo.ZMedia(_cEcz)
_VArS.Id = "40d834a9-2310-4804-8ce7-5778170cd353"
_VArS.Name = _TBt27("\026rf:lAN)rNr\023")
_VArS.Description = _TBt27("`.w\029r@l{A@@ql\001F\029\029r@l;\195\188\023w1)\029lr\029;AwlANI\022)rNr\023")
_VArS.AltText = _TBt27("\026rf:lAN)rNr\023")
_VArS.Resources = {
  {
    Type = "wav",
    Filename = "GeldAbheben.wav",
    Directives = {}
  }
}
_fqj = Wherigo.ZMedia(_cEcz)
_fqj.Id = "8b7dd003-702c-4524-a667-b1fb14f42d26"
_fqj.Name = _TBt27("|.?r\023A@\029.?")
_fqj.Description = _TBt27("|.?r\023A@\029.?ol;.@\019f.1)lr.?r\023A@\029.?")
_fqj.AltText = _TBt27("|.?r\023A@\029.?")
_fqj.Resources = {
  {
    Type = "wav",
    Filename = "Eigenartig.wav",
    Directives = {}
  }
}
_5It4e = Wherigo.ZMedia(_cEcz)
_5It4e.Id = "f50643fc-cd11-4800-ae39-abc34453e605"
_5It4e.Name = _TBt27("\nr\023\023lf.rNr@")
_5It4e.Description = _TBt27("\nr\023\023lf.rNr@lr.\023lN.ww1)r\023l;r\023\023l:\022l\023r@U\195\182wlN.w\029")
_5It4e.AltText = _TBt27("\nr\023\023lf.rNr@")
_5It4e.Resources = {
  {
    Type = "wav",
    Filename = "RennLieber.wav",
    Directives = {}
  }
}
_bL8Le = Wherigo.ZMedia(_cEcz)
_bL8Le.Id = "6cb2c0fa-0e94-4011-a1b2-bf92e5f58fa1"
_bL8Le.Name = _TBt27("R.ff\019FLLr\023l.\023l{F?;A@\029w")
_bL8Le.Description = _TBt27("R.ff\019FLLr\023l.\023l{F?;A@\029w")
_bL8Le.AltText = _TBt27("R.ff\019FLLr\023l.\023l{F?;A@\029w")
_bL8Le.Resources = {
  {
    Type = "wav",
    Filename = "WillkommenInHogwarts.wav",
    Directives = {}
  }
}
_0ju = Wherigo.ZMedia(_cEcz)
_0ju.Id = "3c7082c0-fb79-402e-9d46-ba2cbd00e4e3"
_0ju.Name = _TBt27("\024\022\023.1)\029?\022\029")
_0ju.Description = _TBt27("Z1)lw1);\195\182@rl\020r.r@f.1)ol.1)lN.\023lr.\023l\024\022\023.1)\029?\022\029M")
_0ju.AltText = _TBt27("\024\022\023.1)\029?\022\029")
_0ju.Resources = {
  {
    Type = "wav",
    Filename = "Tunichtgut.wav",
    Directives = {}
  }
}
_fc8 = Wherigo.ZMedia(_cEcz)
_fc8.Id = "43573e17-98aa-4298-a681-4a17be0ef580"
_fc8.Name = _TBt27("g1@.NN\022f\022w")
_fc8.Description = ""
_fc8.AltText = ""
_fc8.Resources = {
  {
    Type = "jpg",
    Filename = "Scribbulus.jpg",
    Directives = {}
  }
}
_H9PyJ = Wherigo.ZMedia(_cEcz)
_H9PyJ.Id = "00c4a66b-2b64-4a2b-9222-60797ab947b2"
_H9PyJ.Name = _TBt27("h.rl\001r.\029w1)r\023:rlRr.:r")
_H9PyJ.Description = ""
_H9PyJ.AltText = ""
_H9PyJ.Resources = {
  {
    Type = "jpg",
    Filename = "DiePeitschendeWeide.jpg",
    Directives = {}
  }
}
_mPlrx = Wherigo.ZMedia(_cEcz)
_mPlrx.Id = "5da7ed78-04ac-4258-9d7f-fafac17a223e"
_mPlrx.Name = _TBt27("h.rl{r\022fr\023:rl{\022r\029\029r")
_mPlrx.Description = ""
_mPlrx.AltText = ""
_mPlrx.Resources = {
  {
    Type = "jpg",
    Filename = "DieHeulendeHutte.jpg",
    Directives = {}
  }
}
_jEv = Wherigo.ZMedia(_cEcz)
_jEv.Id = "da072409-13b8-4f56-bb75-8847309cf95d"
_jEv.Name = _TBt27("tA1\019w\029r.\023;A\023:")
_jEv.Description = ""
_jEv.AltText = ""
_jEv.Resources = {
  {
    Type = "jpg",
    Filename = "Backsteinwand.jpg",
    Directives = {}
  }
}
_RfPd = Wherigo.ZMedia(_cEcz)
_RfPd.Id = "f720f63d-5f41-4024-8973-5cb938704322"
_RfPd.Name = _TBt27("{A@@q\001\022ff.")
_RfPd.Description = ""
_RfPd.AltText = ""
_RfPd.Resources = {
  {
    Type = "jpg",
    Filename = "HarryPulli.jpg",
    Directives = {}
  }
}
_AMk = Wherigo.ZMedia(_cEcz)
_AMk.Id = "50f441e5-de87-4780-8957-18e63c73eac4"
_AMk.Name = _TBt27("5FNFf:")
_AMk.Description = ""
_AMk.AltText = ""
_AMk.Resources = {
  {
    Type = "jpg",
    Filename = "Kobold.jpg",
    Directives = {}
  }
}
_jWr = Wherigo.ZMedia(_cEcz)
_jWr.Id = "09f874e6-b40c-4331-9082-70c4f7db6b36"
_jWr.Name = _TBt27("5.\023?Hwl0@Fww")
_jWr.Description = ""
_jWr.AltText = ""
_jWr.Resources = {
  {
    Type = "jpg",
    Filename = "kings_cross.jpg",
    Directives = {}
  }
}
_LadtD = Wherigo.ZMedia(_cEcz)
_LadtD.Id = "c794c771-1c23-48a9-ab14-80fcb85f130a"
_LadtD.Name = _TBt27("\024A?rwD@FD)r\029")
_LadtD.Description = ""
_LadtD.AltText = ""
_LadtD.Resources = {
  {
    Type = "jpg",
    Filename = "prophet.jpg",
    Directives = {}
  }
}
_847 = Wherigo.ZMedia(_cEcz)
_847.Id = "814b9f57-d113-440f-9775-c8427848b577"
_847.Name = _TBt27("\018rf:w1)f\195\182ww1)r\023")
_847.Description = ""
_847.AltText = ""
_847.Resources = {
  {
    Type = "jpg",
    Filename = "Feldschloesschen.jpg",
    Directives = {}
  }
}
_hNx = Wherigo.ZMedia(_cEcz)
_hNx.Id = "4252aa87-57ec-42fe-9f4e-426bce7bc053"
_hNx.Name = _TBt27("{A@@q\026F+F?F")
_hNx.Description = ""
_hNx.AltText = ""
_hNx.Resources = {
  {
    Type = "jpg",
    Filename = "HarryGoLogo.jpg",
    Directives = {}
  }
}
_PnYc = Wherigo.ZMedia(_cEcz)
_PnYc.Id = "983fcf36-aae8-4b6a-ad0b-fe4fbebf07c5"
_PnYc.Name = _TBt27("R\195\1641)\029r@")
_PnYc.Description = ""
_PnYc.AltText = ""
_PnYc.Resources = {
  {
    Type = "jpg",
    Filename = "tor.jpg",
    Directives = {}
  }
}
_YWA_ = Wherigo.ZMedia(_cEcz)
_YWA_.Id = "b949df7a-d856-40df-a582-1c8fc4fdfe5b"
_YWA_.Name = _TBt27("\nF\023")
_YWA_.Description = ""
_YWA_.AltText = ""
_YWA_.Resources = {
  {
    Type = "jpg",
    Filename = "Ron.jpg",
    Directives = {}
  }
}
_4Fgw = Wherigo.ZMedia(_cEcz)
_4Fgw.Id = "197e7a1e-c83f-4b74-957f-e3fe76fafd5e"
_4Fgw.Name = _TBt27("{r@L.\023r")
_4Fgw.Description = ""
_4Fgw.AltText = ""
_4Fgw.Resources = {
  {
    Type = "jpg",
    Filename = "Hermine.jpg",
    Directives = {}
  }
}
_hAk6 = Wherigo.ZMedia(_cEcz)
_hAk6.Id = "10634027-109b-4768-bd31-deff9e42e0eb"
_hAk6.Name = _TBt27("\nF\023l\022\023:l{r@L.\023r")
_hAk6.Description = ""
_hAk6.AltText = ""
_hAk6.Resources = {
  {
    Type = "jpg",
    Filename = "Ron_und_Hermine.jpg",
    Directives = {}
  }
}
_Krt8R = Wherigo.ZMedia(_cEcz)
_Krt8R.Id = "fb393ee8-5543-47e0-baba-123a795ae53d"
_Krt8R.Name = _TBt27("{r:;.?w\024)rLr")
_Krt8R.Description = ""
_Krt8R.AltText = _TBt27("{r:;.?w\024)rLr")
_Krt8R.Resources = {
  {
    Type = "wav",
    Filename = "HedwigsTheme.wav",
    Directives = {}
  }
}
_zQV = Wherigo.ZMedia(_cEcz)
_zQV.Id = "e313dd30-3c09-44e6-81b4-0f8c8f48cb28"
_zQV.Name = _TBt27("\024\195\188@r")
_zQV.Description = ""
_zQV.AltText = ""
_zQV.Resources = {
  {
    Type = "jpg",
    Filename = "Ture.jpg",
    Directives = {}
  }
}
_IAZb8 = Wherigo.ZMedia(_cEcz)
_IAZb8.Id = "7583f69f-dd1b-4237-9709-559c820d4b0a"
_IAZb8.Name = _TBt27("{F?;A@\029wr_D@rww")
_IAZb8.Description = ""
_IAZb8.AltText = ""
_IAZb8.Resources = {
  {
    Type = "jpg",
    Filename = "HogwartsExpress.jpg",
    Directives = {}
  }
}
_CgrEl = Wherigo.ZMedia(_cEcz)
_CgrEl.Id = "b86b4f86-8311-4303-82e8-b20bcd3721fa"
_CgrEl.Name = _TBt27("RA\023:N.f:")
_CgrEl.Description = ""
_CgrEl.AltText = ""
_CgrEl.Resources = {
  {
    Type = "jpg",
    Filename = "Wandbild.jpg",
    Directives = {}
  }
}
_bRB = Wherigo.ZMedia(_cEcz)
_bRB.Id = "1d914fac-93f6-403a-b5dc-813cd8c559dc"
_bRB.Name = _TBt27("\001.1\029F?@AL")
_bRB.Description = ""
_bRB.AltText = ""
_bRB.Resources = {
  {
    Type = "jpg",
    Filename = "HarryGoPicto.jpg",
    Directives = {}
  }
}
_hKxZ4 = Wherigo.ZMedia(_cEcz)
_hKxZ4.Id = "a395807d-6450-46e8-a241-04c3f6104913"
_hKxZ4.Name = _TBt27("&A\022Nr@w\029AN")
_hKxZ4.Description = ""
_hKxZ4.AltText = ""
_hKxZ4.Resources = {
  {
    Type = "jpg",
    Filename = "Zauberstab2.jpg",
    Directives = {}
  }
}
_TPZx6 = Wherigo.ZMedia(_cEcz)
_TPZx6.Id = "aebfc5b3-1393-4642-9839-44b22e2a9791"
_TPZx6.Name = _TBt27("5@A;A\029\029rl\nAUr\0231fA;")
_TPZx6.Description = ""
_TPZx6.AltText = ""
_TPZx6.Resources = {
  {
    Type = "jpg",
    Filename = "Krawatte2.jpg",
    Directives = {}
  }
}
_woyfP = Wherigo.ZMedia(_cEcz)
_woyfP.Id = "afdccf47-83d3-41f5-9bce-d4428628cac0"
_woyfP.Name = _TBt27("5@A;A\029\029rlgfq\029)r@.\023")
_woyfP.Description = ""
_woyfP.AltText = ""
_woyfP.Resources = {
  {
    Type = "jpg",
    Filename = "Krawatte3.jpg",
    Directives = {}
  }
}
_ZDQ = Wherigo.ZMedia(_cEcz)
_ZDQ.Id = "d1aac7b1-6dd5-469d-9bae-083f7a6ef351"
_ZDQ.Name = _TBt27("5@A;A\029\029rl{\022\020\020frD\022\020\020")
_ZDQ.Description = ""
_ZDQ.AltText = ""
_ZDQ.Resources = {
  {
    Type = "jpg",
    Filename = "Krawatte4.jpg",
    Directives = {}
  }
}
_zJP = Wherigo.ZMedia(_cEcz)
_zJP.Id = "597532b9-cd34-4270-9e20-c25a60c62d6e"
_zJP.Name = _TBt27("\024\195\188@r\b")
_zJP.Description = ""
_zJP.AltText = ""
_zJP.Resources = {
  {
    Type = "jpg",
    Filename = "Ture2.jpg",
    Directives = {}
  }
}
_5BH = Wherigo.ZMedia(_cEcz)
_5BH.Id = "e434c2b3-002f-4b02-83b8-ee71e0506808"
_5BH.Name = _TBt27("\024\195\188@r^")
_5BH.Description = ""
_5BH.AltText = ""
_5BH.Resources = {
  {
    Type = "jpg",
    Filename = "Ture3.jpg",
    Directives = {}
  }
}
_cEcz.Id = "7f7c0ad4-3b36-489f-8d23-74a56bb9f305"
_cEcz.Name = "HarryGo"
_cEcz.Description = "Das komplette Listing findest du hier: https://www.geocaching.com/geocache/GC7XABX_harrygo<BR>\n<BR>\nDiese Rheinfelder Adaption der Fantasygeschichte rund um die Hauptfigur Harry Potter beginnt an seinem elften Geburtstag, als Harry von seiner Herkunft erf\195\164hrt. Bis dahin ist er bei seinen Muggel-Verwandten, den Dursleys, am Ligusterweg aufgewachsen, die ihm seine magische Herkunft verheimlicht hatten. Onkel Vernon und Tante Petunia haben ihren Neffen als Baby widerwillig bei sich aufgenommen, nachdem Harrys Eltern gestorben waren. Nun also ist es deine Aufgabe, Harry auf dem Weg nach Hogwarts, der Schule f\195\188r Hexerei und Zauberei, zu begleiten und ihm bei den Aufgaben, die sich ihm als angehenden Zaubersch\195\188ler stellen, zu helfen."
_cEcz.Visible = true
_cEcz.Activity = "Geocache"
_cEcz.StartingLocationDescription = "Der Harry Potter Wherigo in Rheinfelden startet hier."
_cEcz.StartingLocation = ZonePoint(47.546367, 7.79205, 0)
_cEcz.Version = "2"
_cEcz.Company = ""
_cEcz.Author = ""
_cEcz.BuilderVersion = "URWIGO 1.22.5798.37755"
_cEcz.CreateDate = "12/26/2017 21:42:06"
_cEcz.PublishDate = "1/1/0001 12:00:00 AM"
_cEcz.UpdateDate = "04/08/2021 17:49:40"
_cEcz.LastPlayedDate = "1/1/0001 12:00:00 AM"
_cEcz.TargetDevice = "PocketPC"
_cEcz.TargetDeviceVersion = "0"
_cEcz.StateId = "1"
_cEcz.CountryId = "2"
_cEcz.Complete = false
_cEcz.UseLogging = true
_cEcz.Media = _hNx
_cEcz.Icon = _bRB
_qMGT = Wherigo.Zone(_cEcz)
_qMGT.Id = "d9654494-7520-441f-a236-7b66b4e9cf38"
_qMGT.Name = _TBt27("+.?\022w\029r@;r?")
_qMGT.Description = _TBt27("{.r@l;F)\023r\023l:.rlh\022@wfrqw>")
_qMGT.Visible = false
_qMGT.Media = _Lm3H
_qMGT.Icon = _Lm3H
_qMGT.Commands = {}
_qMGT.DistanceRange = Distance(-1, "feet")
_qMGT.ShowObjects = "OnEnter"
_qMGT.ProximityRange = Distance(60, "meters")
_qMGT.AllowSetPositionTo = false
_qMGT.Active = false
_qMGT.Points = {
  ZonePoint(47.5473310718989, 7.79229418474289, 0),
  ZonePoint(47.5474297498428, 7.79163638540022, 0),
  ZonePoint(47.5471683177596, 7.79150510105986, 0),
  ZonePoint(47.5470685889968, 7.79218697440145, 0)
}
_qMGT.OriginalPoint = ZonePoint(47.5472494321245, 7.79190566140111, 0)
_qMGT.DistanceRangeUOM = "Feet"
_qMGT.ProximityRangeUOM = "Meters"
_qMGT.OutOfRangeName = ""
_qMGT.InRangeName = ""
_1t7 = Wherigo.Zone(_cEcz)
_1t7.Id = "1c5819cc-421f-4c30-98c9-5bd2c71d99f7"
_1t7.Name = _TBt27("hr@l\024@FD\020r\023:rl5rwwrf")
_1t7.Description = _TBt27("ZLl{.\023\029r@)F\020l:rwl\024@FD\020r\023:r\023l5rwwrfwlNr\020.\023:r\029lw.1)l:r@l|.\023?A\023?lI\022@lR.\023\019rf?Awwr>")
_1t7.Visible = false
_1t7.Media = _NGTgz
_1t7.Icon = _NGTgz
_1t7.Commands = {}
_1t7.DistanceRange = Distance(-1, "feet")
_1t7.ShowObjects = "OnEnter"
_1t7.ProximityRange = Distance(60, "meters")
_1t7.AllowSetPositionTo = false
_1t7.Active = false
_1t7.Points = {
  ZonePoint(47.5543227479551, 7.79424022746226, 0),
  ZonePoint(47.5542952278231, 7.79445480862434, 0),
  ZonePoint(47.5544367296428, 7.79469075006741, 0),
  ZonePoint(47.5545834227253, 7.79462177854467, 0),
  ZonePoint(47.5544853727937, 7.79426435615615, 0)
}
_1t7.OriginalPoint = ZonePoint(47.554424700188, 7.79445438417097, 0)
_1t7.DistanceRangeUOM = "Feet"
_1t7.ProximityRangeUOM = "Meters"
_1t7.OutOfRangeName = ""
_1t7.InRangeName = ""
_MSkmJ = Wherigo.Zone(_cEcz)
_MSkmJ.Id = "923a465c-c48b-447d-a8c6-466a5543f359"
_MSkmJ.Name = _TBt27("R.\023\019rf?Awwr")
_MSkmJ.Description = _TBt27("{.r@lr@fr:.?r\023l{r_r\023l\022\023:l&A\022Nr@r@l.)@rl|.\023\019\195\164\022\020r>")
_MSkmJ.Visible = false
_MSkmJ.Media = _bRH
_MSkmJ.Icon = _bRH
_MSkmJ.Commands = {}
_MSkmJ.DistanceRange = Distance(-1, "feet")
_MSkmJ.ShowObjects = "OnEnter"
_MSkmJ.ProximityRange = Distance(60, "meters")
_MSkmJ.AllowSetPositionTo = false
_MSkmJ.Active = false
_MSkmJ.Points = {
  ZonePoint(47.5545711012208, 7.7945707721765, 0),
  ZonePoint(47.5544865505046, 7.79426656541568, 0),
  ZonePoint(47.5542626217068, 7.79422470275694, 0),
  ZonePoint(47.5542291369445, 7.79442781417527, 0),
  ZonePoint(47.5543951921965, 7.79446643680004, 0),
  ZonePoint(47.5544771253417, 7.79481699313928, 0),
  ZonePoint(47.5553018954885, 7.79455799713472, 0),
  ZonePoint(47.5552824282211, 7.79436629498672, 0)
}
_MSkmJ.OriginalPoint = ZonePoint(47.5546257564531, 7.79446219707314, 0)
_MSkmJ.DistanceRangeUOM = "Feet"
_MSkmJ.ProximityRangeUOM = "Meters"
_MSkmJ.OutOfRangeName = ""
_MSkmJ.InRangeName = ""
_LUd = Wherigo.Zone(_cEcz)
_LUd.Id = "b18b1c5a-3251-4c0b-bcb1-d0587809662d"
_LUd.Name = _TBt27("\026fr.wl!l^X\006")
_LUd.Description = _TBt27("\aF\023l).r@lA\022wl\020\195\164)@\029l:r@l{F?;A@\029wG|_D@rwwlfFw>l}.1)\029l:.rl\026fr.wrlNr\029@r\029r\023M")
_LUd.Visible = false
_LUd.Media = _tK_pr
_LUd.Icon = _tK_pr
_LUd.Commands = {}
_LUd.DistanceRange = Distance(-1, "feet")
_LUd.ShowObjects = "OnEnter"
_LUd.ProximityRange = Distance(25, "meters")
_LUd.AllowSetPositionTo = false
_LUd.Active = false
_LUd.Points = {
  ZonePoint(47.5511071167875, 7.79267518101582, 0),
  ZonePoint(47.5509700410543, 7.79277440157987, 0),
  ZonePoint(47.5511238809445, 7.79323802151911, 0),
  ZonePoint(47.5512546750693, 7.79315120793439, 0)
}
_LUd.OriginalPoint = ZonePoint(47.5511139284639, 7.7929597030123, 0)
_LUd.DistanceRangeUOM = "Feet"
_LUd.ProximityRangeUOM = "Meters"
_LUd.OutOfRangeName = ""
_LUd.InRangeName = ""
_gGZ = Wherigo.Zone(_cEcz)
_gGZ.Id = "4153e32e-3768-40df-a37e-ad6b62042e98"
_gGZ.Name = _TBt27("{F?;A@\029w")
_gGZ.Description = _TBt27("h.rlNrw\029rlg1)\022frl\020\195\188@l\030\022\023?rl{r_r\023l\022\023:l&A\022Nr@r@>")
_gGZ.Visible = false
_gGZ.Media = _ERe
_gGZ.Icon = _ERe
_gGZ.Commands = {}
_gGZ.DistanceRange = Distance(-1, "feet")
_gGZ.ShowObjects = "OnEnter"
_gGZ.ProximityRange = Distance(60, "meters")
_gGZ.AllowSetPositionTo = false
_gGZ.Active = false
_gGZ.Points = {
  ZonePoint(47.546918895295, 7.78578907632216, 0),
  ZonePoint(47.5468166870954, 7.78584630938018, 0),
  ZonePoint(47.5468682849273, 7.78601353227675, 0),
  ZonePoint(47.5469647979387, 7.78595127538259, 0)
}
_gGZ.OriginalPoint = ZonePoint(47.5468921663141, 7.78590004834042, 0)
_gGZ.DistanceRangeUOM = "Feet"
_gGZ.ProximityRangeUOM = "Meters"
_gGZ.OutOfRangeName = ""
_gGZ.InRangeName = ""
_9rbkZ = Wherigo.Zone(_cEcz)
_9rbkZ.Id = "f00659fb-2a3f-42c1-86d8-1fd2f2c477c0"
_9rbkZ.Name = _TBt27("Z\023wrflL.\029l\024\022@L")
_9rbkZ.Description = ""
_9rbkZ.Visible = false
_9rbkZ.Media = _Zjn
_9rbkZ.Icon = _Zjn
_9rbkZ.Commands = {}
_9rbkZ.DistanceRange = Distance(-1, "feet")
_9rbkZ.ShowObjects = "OnEnter"
_9rbkZ.ProximityRange = Distance(60, "meters")
_9rbkZ.AllowSetPositionTo = false
_9rbkZ.Active = false
_9rbkZ.Points = {
  ZonePoint(47.5514529628267, 7.7963587007017, 0),
  ZonePoint(47.5511910386427, 7.79635046524846, 0),
  ZonePoint(47.5511848588222, 7.7967473149462, 0),
  ZonePoint(47.5514540791673, 7.79675204279999, 0)
}
_9rbkZ.OriginalPoint = ZonePoint(47.5513207348647, 7.79655213092409, 0)
_9rbkZ.DistanceRangeUOM = "Feet"
_9rbkZ.ProximityRangeUOM = "Meters"
_9rbkZ.OutOfRangeName = ""
_9rbkZ.InRangeName = ""
_Jdr = Wherigo.Zone(_cEcz)
_Jdr.Id = "c2135fd7-0353-4169-bae6-00de58a85761"
_Jdr.Name = _TBt27("\026@.\023?F\029\029w")
_Jdr.Description = ""
_Jdr.Visible = false
_Jdr.Media = _DkN8a
_Jdr.Icon = _DkN8a
_Jdr.Commands = {}
_Jdr.DistanceRange = Distance(-1, "feet")
_Jdr.ShowObjects = "OnEnter"
_Jdr.ProximityRange = Distance(60, "meters")
_Jdr.AllowSetPositionTo = false
_Jdr.Active = false
_Jdr.Points = {
  ZonePoint(47.5552774656844, 7.79433722231961, 0),
  ZonePoint(47.5551128492369, 7.79437673108875, 0),
  ZonePoint(47.5551304386323, 7.79462653660989, 0),
  ZonePoint(47.5552917570221, 7.79457479023931, 0)
}
_Jdr.OriginalPoint = ZonePoint(47.5552031276439, 7.79447882006439, 0)
_Jdr.DistanceRangeUOM = "Feet"
_Jdr.ProximityRangeUOM = "Meters"
_Jdr.OutOfRangeName = ""
_Jdr.InRangeName = ""
_Ahs = Wherigo.Zone(_cEcz)
_Ahs.Id = "aa309af6-8fa4-40de-820c-06abb519ab56"
_Ahs.Name = _TBt27("\016ff.UA\023:r@")
_Ahs.Description = ""
_Ahs.Visible = false
_Ahs.Media = _gJv
_Ahs.Icon = _gJv
_Ahs.Commands = {}
_Ahs.DistanceRange = Distance(-1, "feet")
_Ahs.ShowObjects = "OnEnter"
_Ahs.ProximityRange = Distance(60, "meters")
_Ahs.AllowSetPositionTo = false
_Ahs.Active = false
_Ahs.Points = {
  ZonePoint(47.5554179929495, 7.79380766826548, 0),
  ZonePoint(47.5549161225143, 7.7937556227571, 0),
  ZonePoint(47.5549124203619, 7.79398163256169, 0),
  ZonePoint(47.5554177231408, 7.79401517601095, 0)
}
_Ahs.OriginalPoint = ZonePoint(47.5551660647416, 7.7938900248988, 0)
_Ahs.DistanceRangeUOM = "Feet"
_Ahs.ProximityRangeUOM = "Meters"
_Ahs.OutOfRangeName = ""
_Ahs.InRangeName = ""
_NfIX = Wherigo.Zone(_cEcz)
_NfIX.Id = "cefddbb8-3444-488e-83e3-912240b3e751"
_NfIX.Name = _TBt27("\018fF\022@.w)l\022\023:ltfF\029\029w")
_NfIX.Description = ""
_NfIX.Visible = false
_NfIX.Media = _2byTd
_NfIX.Icon = _2byTd
_NfIX.Commands = {}
_NfIX.DistanceRange = Distance(-1, "feet")
_NfIX.ShowObjects = "OnEnter"
_NfIX.ProximityRange = Distance(60, "meters")
_NfIX.AllowSetPositionTo = false
_NfIX.Active = false
_NfIX.Points = {
  ZonePoint(47.5551500184915, 7.79336918693404, 0),
  ZonePoint(47.5551437729109, 7.79364833241417, 0),
  ZonePoint(47.5558630902668, 7.79369329688408, 0),
  ZonePoint(47.5558285391006, 7.79342476894008, 0)
}
_NfIX.OriginalPoint = ZonePoint(47.5554963551924, 7.79353389629309, 0)
_NfIX.DistanceRangeUOM = "Feet"
_NfIX.ProximityRangeUOM = "Meters"
_NfIX.OutOfRangeName = ""
_NfIX.InRangeName = ""
_tnVG5 = Wherigo.Zone(_cEcz)
_tnVG5.Id = "55744578-82bd-4e97-98d8-effc76a96be7"
_tnVG5.Name = _TBt27("`A:ALl`Af\019.\023w")
_tnVG5.Description = ""
_tnVG5.Visible = false
_tnVG5.Media = __ny6r
_tnVG5.Icon = __ny6r
_tnVG5.Commands = {}
_tnVG5.DistanceRange = Distance(-1, "feet")
_tnVG5.ShowObjects = "OnEnter"
_tnVG5.ProximityRange = Distance(60, "meters")
_tnVG5.AllowSetPositionTo = false
_tnVG5.Active = false
_tnVG5.Points = {
  ZonePoint(47.5551894917448, 7.79207129020599, 0),
  ZonePoint(47.5549397655365, 7.79215285140442, 0),
  ZonePoint(47.5549716659292, 7.79236021703433, 0),
  ZonePoint(47.5552217464829, 7.79226755591143, 0)
}
_tnVG5.OriginalPoint = ZonePoint(47.5550806674234, 7.79221297863904, 0)
_tnVG5.DistanceRangeUOM = "Feet"
_tnVG5.ProximityRangeUOM = "Meters"
_tnVG5.OutOfRangeName = ""
_tnVG5.InRangeName = ""
_HeL1v = Wherigo.Zone(_cEcz)
_HeL1v.Id = "10e53832-94e0-41df-b92c-a084342be255"
_HeL1v.Name = _TBt27("\001F\029A?rwl5rwwrffA:r\023")
_HeL1v.Description = ""
_HeL1v.Visible = false
_HeL1v.Media = _YKB
_HeL1v.Icon = _YKB
_HeL1v.Commands = {}
_HeL1v.DistanceRange = Distance(-1, "feet")
_HeL1v.ShowObjects = "OnEnter"
_HeL1v.ProximityRange = Distance(60, "meters")
_HeL1v.AllowSetPositionTo = false
_HeL1v.Active = false
_HeL1v.Points = {
  ZonePoint(47.5546599762107, 7.79192613452495, 0),
  ZonePoint(47.5544883759896, 7.79197390550101, 0),
  ZonePoint(47.5545174960667, 7.79221121938207, 0),
  ZonePoint(47.5546953361865, 7.7921572844091, 0)
}
_HeL1v.OriginalPoint = ZonePoint(47.5545902961134, 7.79206713595428, 0)
_HeL1v.DistanceRangeUOM = "Feet"
_HeL1v.ProximityRangeUOM = "Meters"
_HeL1v.OutOfRangeName = ""
_HeL1v.InRangeName = ""
_4BVI = Wherigo.Zone(_cEcz)
_4BVI.Id = "185a7b5f-fd42-4025-8d97-2bc8b0443852"
_4BVI.Name = _TBt27("g1@.NN\022f\022wlg1)@r.N;A@r\023")
_4BVI.Description = ""
_4BVI.Visible = false
_4BVI.Media = _fc8
_4BVI.Icon = _fc8
_4BVI.Commands = {}
_4BVI.DistanceRange = Distance(-1, "feet")
_4BVI.ShowObjects = "OnEnter"
_4BVI.ProximityRange = Distance(60, "meters")
_4BVI.AllowSetPositionTo = false
_4BVI.Active = false
_4BVI.Points = {
  ZonePoint(47.5552534945336, 7.79226839713516, 0),
  ZonePoint(47.5550385692051, 7.7923572745466, 0),
  ZonePoint(47.5550980514972, 7.79273909791915, 0),
  ZonePoint(47.5553220013257, 7.79264619168389, 0)
}
_4BVI.OriginalPoint = ZonePoint(47.5551780291404, 7.7925027403212, 0)
_4BVI.DistanceRangeUOM = "Feet"
_4BVI.ProximityRangeUOM = "Meters"
_4BVI.OutOfRangeName = ""
_4BVI.InRangeName = ""
_hQEW = Wherigo.Zone(_cEcz)
_hQEW.Id = "51b941cf-b75b-481a-8b27-8a30eb6a2baf"
_hQEW.Name = _TBt27("h.rl\001r.\029w1)r\023:rlRr.:r")
_hQEW.Description = ""
_hQEW.Visible = false
_hQEW.Media = _H9PyJ
_hQEW.Icon = _H9PyJ
_hQEW.Commands = {}
_hQEW.DistanceRange = Distance(-1, "feet")
_hQEW.ShowObjects = "OnEnter"
_hQEW.ProximityRange = Distance(60, "meters")
_hQEW.AllowSetPositionTo = false
_hQEW.Active = false
_hQEW.Points = {
  ZonePoint(47.5442022787573, 7.79237932953855, 0),
  ZonePoint(47.5438882545936, 7.79242092071121, 0),
  ZonePoint(47.5439277676713, 7.7927798371272, 0),
  ZonePoint(47.5442313934851, 7.79272284181653, 0)
}
_hQEW.OriginalPoint = ZonePoint(47.5440624236268, 7.79257573229837, 0)
_hQEW.DistanceRangeUOM = "Feet"
_hQEW.ProximityRangeUOM = "Meters"
_hQEW.OutOfRangeName = ""
_hQEW.InRangeName = ""
_IBcW = Wherigo.Zone(_cEcz)
_IBcW.Id = "c96c9481-3d56-42fe-8b13-672acde79034"
_IBcW.Name = _TBt27("h.rl{r\022fr\023:rl{\195\188\029\029r")
_IBcW.Description = _TBt27("h.rl{r\022fr\023:rl{\195\188\029\029rl.\023l{F?wLrA:r>")
_IBcW.Visible = false
_IBcW.Media = _mPlrx
_IBcW.Icon = _mPlrx
_IBcW.Commands = {}
_IBcW.DistanceRange = Distance(-1, "feet")
_IBcW.ShowObjects = "OnEnter"
_IBcW.ProximityRange = Distance(60, "meters")
_IBcW.AllowSetPositionTo = false
_IBcW.Active = false
_IBcW.Points = {
  ZonePoint(47.5426634210931, 7.79129295930901, 0),
  ZonePoint(47.5429593925721, 7.79102121663697, 0),
  ZonePoint(47.5431214005709, 7.79152345921026, 0),
  ZonePoint(47.5428470636755, 7.79181666023728, 0)
}
_IBcW.OriginalPoint = ZonePoint(47.5428978194779, 7.79141357384838, 0)
_IBcW.DistanceRangeUOM = "Feet"
_IBcW.ProximityRangeUOM = "Meters"
_IBcW.OutOfRangeName = ""
_IBcW.InRangeName = ""
_Tog0 = Wherigo.Zone(_cEcz)
_Tog0.Id = "abb9353b-123e-407a-8854-333df7cb30b9"
_Tog0.Name = _TBt27("tA)\023)F\020l5.\023?Hwl0@Fww")
_Tog0.Description = ""
_Tog0.Visible = false
_Tog0.Media = _jWr
_Tog0.Icon = _jWr
_Tog0.Commands = {}
_Tog0.DistanceRange = Distance(-1, "feet")
_Tog0.ShowObjects = "OnEnter"
_Tog0.ProximityRange = Distance(60, "meters")
_Tog0.AllowSetPositionTo = false
_Tog0.Active = false
_Tog0.Points = {
  ZonePoint(47.5512426952412, 7.79232033491636, 0),
  ZonePoint(47.551101364161, 7.79241805469067, 0),
  ZonePoint(47.551216522887, 7.79276085115737, 0),
  ZonePoint(47.551352618986, 7.79265382432417, 0)
}
_Tog0.OriginalPoint = ZonePoint(47.5512283003188, 7.79253826627214, 0)
_Tog0.DistanceRangeUOM = "Feet"
_Tog0.ProximityRangeUOM = "Meters"
_Tog0.OutOfRangeName = ""
_Tog0.InRangeName = ""
_uXFP = Wherigo.Zone(_cEcz)
_uXFP.Id = "0bf6f0c7-b362-4694-91e7-9363ceac95e5"
_uXFP.Name = _TBt27("hrUrfFDr@`F:r")
_uXFP.Description = ""
_uXFP.Visible = false
_uXFP.Commands = {}
_uXFP.DistanceRange = Distance(-1, "feet")
_uXFP.ShowObjects = "OnEnter"
_uXFP.ProximityRange = Distance(60, "meters")
_uXFP.AllowSetPositionTo = false
_uXFP.Active = true
_uXFP.Points = {
  ZonePoint(47.5544754269599, 7.58908852114993, 0),
  ZonePoint(47.5550694926932, 7.58929165512633, 0),
  ZonePoint(47.55495885748, 7.59001866093684, 0),
  ZonePoint(47.5543623853493, 7.58990462080966, 0)
}
_uXFP.OriginalPoint = ZonePoint(47.5547165406206, 7.58957586450569, 0)
_uXFP.DistanceRangeUOM = "Feet"
_uXFP.ProximityRangeUOM = "Meters"
_uXFP.OutOfRangeName = ""
_uXFP.InRangeName = ""
_Wiu = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _9rbkZ})
_Wiu.Id = "bfe5c131-a52d-4df2-abf7-9fd7ddf20d1f"
_Wiu.Name = _TBt27("\n\022Nr\022wl{A?@.:")
_Wiu.Description = ""
_Wiu.Visible = true
_Wiu.Media = _BdA
_Wiu.Icon = _BdA
_Wiu.Commands = {
  _g0n = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l{A?@.:>")
  }),
  _RIQIZ = Wherigo.ZCommand({
    Text = _TBt27("T\023\029;F@\029l?rNr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("trA\023\029;F@\029rl:.rl\018@A?r>")
  })
}
_Wiu.Commands._g0n.Custom = true
_Wiu.Commands._g0n.Id = "30eda1bb-7a23-45f3-989d-9892d0cec19b"
_Wiu.Commands._g0n.WorksWithAll = true
_Wiu.Commands._RIQIZ.Custom = true
_Wiu.Commands._RIQIZ.Id = "acfdc31d-4167-476d-a3ac-fa9181b5df7d"
_Wiu.Commands._RIQIZ.WorksWithAll = true
_Wiu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Wiu.Gender = "Male"
_Wiu.Type = "NPC"
_04s = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _qMGT})
_04s.Id = "58450d5f-5359-4229-b929-20f031180d78"
_04s.Name = _TBt27("\ar@\023F\023lh\022@wfrq")
_04s.Description = ""
_04s.Visible = false
_04s.Media = _uLOgI
_04s.Icon = _uLOgI
_04s.Commands = {
  _0PuDh = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l\ar@\023F\023>")
  })
}
_04s.Commands._0PuDh.Custom = true
_04s.Commands._0PuDh.Id = "298092e9-759d-4a30-a5b6-5501461548a8"
_04s.Commands._0PuDh.WorksWithAll = true
_04s.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_04s.Gender = "Male"
_04s.Type = "NPC"
_Y1E3 = Wherigo.ZCharacter({Cartridge = _cEcz, Container = Player})
_Y1E3.Id = "51df8f3f-2b4a-4790-87bc-b67f0c82b02d"
_Y1E3.Name = _TBt27("{A@@ql\001F\029\029r@")
_Y1E3.Description = ""
_Y1E3.Visible = true
_Y1E3.Media = _0BDe4
_Y1E3.Icon = _0BDe4
_Y1E3.Commands = {
  _hg7fu = Wherigo.ZCommand({
    Text = _TBt27("gDr.1)r@\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gDr.1)r@rl:AwlgD.rf")
  }),
  _0vmPw = Wherigo.ZCommand({
    Text = _TBt27("|.\023\020\195\188)@\022\023?lfrwr\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  _FwoW = Wherigo.ZCommand({
    Text = _TBt27("0F:rl\022\023:lg\029A\029.w\029.\019lA\023Ir.?r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  }),
  _A6_ = Wherigo.ZCommand({
    Text = _TBt27("t@A\022D@FIrwwlw\029A@\029r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("}.1)\029lUr@\020\195\188?NA@")
  })
}
_Y1E3.Commands._hg7fu.Custom = true
_Y1E3.Commands._hg7fu.Id = "5da57a7e-1e56-4c93-8e3d-0841eb86d84a"
_Y1E3.Commands._hg7fu.WorksWithAll = true
_Y1E3.Commands._0vmPw.Custom = true
_Y1E3.Commands._0vmPw.Id = "64066f67-5e88-44e9-98b1-3535229c9eaf"
_Y1E3.Commands._0vmPw.WorksWithAll = true
_Y1E3.Commands._FwoW.Custom = true
_Y1E3.Commands._FwoW.Id = "40b3ae11-3501-4745-ab02-74affc9288e6"
_Y1E3.Commands._FwoW.WorksWithAll = true
_Y1E3.Commands._A6_.Custom = true
_Y1E3.Commands._A6_.Id = "63dbd86f-6623-43c6-8c18-59848569a47d"
_Y1E3.Commands._A6_.WorksWithAll = true
_Y1E3.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Y1E3.Gender = "Male"
_Y1E3.Type = "NPC"
_bZH_ = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _Tog0})
_bZH_.Id = "863372fb-a3fe-464d-9868-e523761e76d5"
_bZH_.Name = _TBt27("`FffqlRrAwfrq")
_bZH_.Description = ""
_bZH_.Visible = true
_bZH_.Media = __3SHa
_bZH_.Icon = __3SHa
_bZH_.Commands = {
  _ta7Fq = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l`FffqlRrAwfrq>")
  })
}
_bZH_.Commands._ta7Fq.Custom = true
_bZH_.Commands._ta7Fq.Id = "7779332b-073f-4d8f-b2b2-e3ee71f22100"
_bZH_.Commands._ta7Fq.WorksWithAll = true
_bZH_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_bZH_.Gender = "Female"
_bZH_.Type = "NPC"
_wiKC = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _gGZ})
_wiKC.Id = "ae585f16-4ff1-4531-a1f8-3658c5c5a4f7"
_wiKC.Name = _TBt27("`.\023r@UAl`1\026F\023A?Aff")
_wiKC.Description = ""
_wiKC.Visible = false
_wiKC.Media = _n6d
_wiKC.Icon = _n6d
_wiKC.Commands = {
  _DEG_H = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l`.\023r@UAl`1\026F\023A?Aff>")
  }),
  _tMu = Wherigo.ZCommand({
    Text = _TBt27("T\023\029;F@\029r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_wiKC.Commands._DEG_H.Custom = true
_wiKC.Commands._DEG_H.Id = "275ab651-ebb8-4ea5-8676-92ed48bb0248"
_wiKC.Commands._DEG_H.WorksWithAll = true
_wiKC.Commands._tMu.Custom = true
_wiKC.Commands._tMu.Id = "122882a3-b78e-4037-8f36-5d101f8a2820"
_wiKC.Commands._tMu.WorksWithAll = true
_wiKC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_wiKC.Gender = "Female"
_wiKC.Type = "NPC"
_g5NNA = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _qMGT})
_g5NNA.Id = "ad9d5fef-7d04-4986-bea8-de795529cecb"
_g5NNA.Name = _TBt27("\001Fw\029r\022fr")
_g5NNA.Description = ""
_g5NNA.Visible = true
_g5NNA.Media = _PRI
_g5NNA.Icon = _PRI
_g5NNA.Commands = {
  _3ifr = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l:r@l\001Fw\029r\022fr>")
  }),
  _fBx0 = Wherigo.ZCommand({
    Text = _TBt27("\001Aww;F@\029lr.\023?rNr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_g5NNA.Commands._3ifr.Custom = true
_g5NNA.Commands._3ifr.Id = "5b68b5b6-857d-4470-9d8b-ff3357271ac9"
_g5NNA.Commands._3ifr.WorksWithAll = true
_g5NNA.Commands._fBx0.Custom = true
_g5NNA.Commands._fBx0.Id = "356863fb-d529-4fac-a21b-10451925b636"
_g5NNA.Commands._fBx0.WorksWithAll = true
_g5NNA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_g5NNA.Gender = "Female"
_g5NNA.Type = "NPC"
_Sy40 = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _1t7})
_Sy40.Id = "ea3233f2-e1f5-47f3-bb66-2b14526496c5"
_Sy40.Name = _TBt27("tA1\019w\029r.\023LA\022r@")
_Sy40.Description = ""
_Sy40.Visible = true
_Sy40.Media = _gzWDT
_Sy40.Icon = _gzWDT
_Sy40.Commands = {
  _XXbT = Wherigo.ZCommand({
    Text = _TBt27("d\023\029r@w\0221)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("d\023\029r@w\0221)rl:.rltA1\019w\029r.\023LA\022r@>")
  }),
  _zah6G = Wherigo.ZCommand({
    Text = _TBt27("\nr.)r\023\020Ff?rlr.\023?rNr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("\026.Nl:.rl\nr.)r\023\020Ff?rl:r@ltA1\019w\029r.\023rlr.\023>")
  })
}
_Sy40.Commands._XXbT.Custom = true
_Sy40.Commands._XXbT.Id = "3761d13b-88d7-458b-92c1-e16999d6ffcd"
_Sy40.Commands._XXbT.WorksWithAll = true
_Sy40.Commands._zah6G.Custom = true
_Sy40.Commands._zah6G.Id = "93b8a7f3-408c-4c13-9aeb-08b05a1206b3"
_Sy40.Commands._zah6G.WorksWithAll = true
_Sy40.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Sy40.Gender = "It"
_Sy40.Type = "NPC"
_Qdmgs = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _Jdr})
_Qdmgs.Id = "a2e3a7e8-7a0c-435d-9761-5879f5427554"
_Qdmgs.Name = _TBt27("\ar@f.rwl/\f\\")
_Qdmgs.Description = ""
_Qdmgs.Visible = true
_Qdmgs.Media = _GD5Ln
_Qdmgs.Icon = _GD5Ln
_Qdmgs.Commands = {
  _26EaE = Wherigo.ZCommand({
    Text = _TBt27("\026rf:lAN)rNr\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("{rNrl\026rf:lAN>")
  })
}
_Qdmgs.Commands._26EaE.Custom = true
_Qdmgs.Commands._26EaE.Id = "8062ceac-ca7d-414f-a3dc-8f3e0aaeb1c6"
_Qdmgs.Commands._26EaE.WorksWithAll = true
_Qdmgs.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Qdmgs.Gender = "It"
_Qdmgs.Type = "NPC"
_vxc = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _gGZ})
_vxc.Id = "ef23df63-24bd-4db2-8fc2-72127efeaa97"
_vxc.Name = _TBt27("\018@r:l\022\023:l\026rF@?r")
_vxc.Description = ""
_vxc.Visible = false
_vxc.Media = _AhdW
_vxc.Icon = _AhdW
_vxc.Commands = {
  _bhz = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("gD@.1)lL.\029l\018@r:l\022\023:l\026rF@?r>")
  })
}
_vxc.Commands._bhz.Custom = true
_vxc.Commands._bhz.Id = "32bb4186-83f5-4292-993b-eb9a5785bcee"
_vxc.Commands._bhz.WorksWithAll = true
_vxc.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_vxc.Gender = "Male"
_vxc.Type = "NPC"
_UvDuh = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _hQEW})
_UvDuh.Id = "e2735f7d-8e88-439d-92c4-94e8c0201707"
_UvDuh.Name = _TBt27("\nF\023l\022\023:l{r@L.\023r")
_UvDuh.Description = ""
_UvDuh.Visible = true
_UvDuh.Media = _hAk6
_UvDuh.Icon = _hAk6
_UvDuh.Commands = {
  _5Ek2 = Wherigo.ZCommand({
    Text = _TBt27("gD@r1)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  _kWD = Wherigo.ZCommand({
    Text = _TBt27("T\023\029;F@\029l?rNr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_UvDuh.Commands._5Ek2.Custom = true
_UvDuh.Commands._5Ek2.Id = "b1b47d4d-6443-4d39-aaf4-92f0c1945e01"
_UvDuh.Commands._5Ek2.WorksWithAll = true
_UvDuh.Commands._kWD.Custom = true
_UvDuh.Commands._kWD.Id = "98e801d7-0c2f-4399-9f3f-8c84d345f6e0"
_UvDuh.Commands._kWD.WorksWithAll = true
_UvDuh.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_UvDuh.Gender = "It"
_UvDuh.Type = "NPC"
_yk3i = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _4BVI})
_yk3i.Id = "69b929f7-67d9-481c-bb1e-26ca8487fe8e"
_yk3i.Name = _TBt27("\024\195\188@r")
_yk3i.Description = ""
_yk3i.Visible = true
_yk3i.Media = _zQV
_yk3i.Icon = _zQV
_yk3i.Commands = {
  _I9Ews = Wherigo.ZCommand({
    Text = _TBt27("|.\023\029@r\029r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_yk3i.Commands._I9Ews.Custom = true
_yk3i.Commands._I9Ews.Id = "c65740fa-ee8d-467c-9d84-885afd725c46"
_yk3i.Commands._I9Ews.WorksWithAll = true
_yk3i.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_yk3i.Gender = "It"
_yk3i.Type = "NPC"
_Qv5q = Wherigo.ZCharacter({Cartridge = _cEcz, Container = _LUd})
_Qv5q.Id = "484fc873-6a73-4a57-81d5-e657906406ec"
_Qv5q.Name = _TBt27("{F?;A@\029wr_D@rww")
_Qv5q.Description = ""
_Qv5q.Visible = true
_Qv5q.Media = _IAZb8
_Qv5q.Icon = _IAZb8
_Qv5q.Commands = {
  _aGMmu = Wherigo.ZCommand({
    Text = _TBt27("d\023\029r@w\0221)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  _4_Q0 = Wherigo.ZCommand({
    Text = _TBt27("&A\022Nr@wD@\0221)lwA?r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_Qv5q.Commands._aGMmu.Custom = true
_Qv5q.Commands._aGMmu.Id = "a3dad06d-d4c8-4e92-baef-9117ef9d1939"
_Qv5q.Commands._aGMmu.WorksWithAll = true
_Qv5q.Commands._4_Q0.Custom = true
_Qv5q.Commands._4_Q0.Id = "769397d8-b411-4a3e-850f-20e0d4bd49e0"
_Qv5q.Commands._4_Q0.WorksWithAll = true
_Qv5q.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Qv5q.Gender = "It"
_Qv5q.Type = "NPC"
_UO_t = Wherigo.ZItem({Cartridge = _cEcz, Container = _NfIX})
_UO_t.Id = "1f615b45-c2af-4f09-afc9-80ad271b02a1"
_UO_t.Name = _TBt27("g1)\022fN\195\1881)r@")
_UO_t.Description = _TBt27("g1)\022fN\195\1881)r@]t\nkE\006\bl\026AffrF\023r\023\002")
_UO_t.Visible = true
_UO_t.Media = _hRY
_UO_t.Icon = _hRY
_UO_t.Commands = {
  _38P0 = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("h.rlt\195\1881)r@l\019A\022\020r\023>")
  }),
  __Kx = Wherigo.ZCommand({
    Text = _TBt27("t\195\1881)r@lA\022ww\0221)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("g\0221)rl:.rlt\195\1881)r@lA\022wol:.rl:\022lNr\023\195\182\029.?w\029>")
  }),
  _3gbF8 = Wherigo.ZCommand({
    Text = _TBt27("}A1)l\nrIrD\029lw\0221)r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("h\022@1)w\0221)rl:.rlt\195\1881)r@l\023A1)lr.\023rLlt\022\029\029r@N.r@@rIrD\029>")
  })
}
_UO_t.Commands._38P0.Custom = true
_UO_t.Commands._38P0.Id = "3e645269-66a7-4d2b-8910-2f7029117570"
_UO_t.Commands._38P0.WorksWithAll = true
_UO_t.Commands.__Kx.Custom = true
_UO_t.Commands.__Kx.Id = "a93d33a7-bc24-4069-abe9-e6d9c20faf1f"
_UO_t.Commands.__Kx.WorksWithAll = true
_UO_t.Commands._3gbF8.Custom = true
_UO_t.Commands._3gbF8.Id = "e6f89a32-61e6-4535-bf09-4c8b62bd395b"
_UO_t.Commands._3gbF8.WorksWithAll = true
_UO_t.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_UO_t.Locked = false
_UO_t.Opened = false
_K53_ = Wherigo.ZItem({Cartridge = _cEcz, Container = _Jdr})
_K53_.Id = "87b6fe3c-981b-4cf3-afdc-8ca9bb9816cb"
_K53_.Name = _TBt27("\026AffrF\023r\023")
_K53_.Description = _TBt27("\b!l5\023\022\029wlw.\023:lr.\023lg.1\019rfl\022\023:l3\\lg.1\019rflw.\023:lr.\023rl\026AffrF\023r>l}.1)\029wlr.\023\020A1)r@lAfwl:Aw>")
_K53_.Visible = false
_K53_.Media = _5I9A
_K53_.Icon = _5I9A
_K53_.Commands = {
  _krgX = Wherigo.ZCommand({
    Text = _TBt27("\001@\195\188\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_K53_.Commands._krgX.Custom = true
_K53_.Commands._krgX.Id = "c2934960-4bed-4699-a460-0788bb9f6162"
_K53_.Commands._krgX.WorksWithAll = true
_K53_.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_K53_.Locked = false
_K53_.Opened = false
_3C2 = Wherigo.ZItem({Cartridge = _cEcz, Container = _Ahs})
_3C2.Id = "4d90168b-16a1-4ba0-9c5f-981310a743ae"
_3C2.Name = _TBt27("&A\022Nr@w\029AN")
_3C2.Description = _TBt27("hr@l&A\022Nr@r@l;\195\164)f\029l\023.1)\029l:r\023l&A\022Nr@w\029AN>lhr@l&A\022Nr@w\029ANl;\195\164)f\029l:r\023l&A\022Nr@r@>")
_3C2.Visible = true
_3C2.Media = _hKxZ4
_3C2.Icon = _hKxZ4
_3C2.Commands = {
  _o2x = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("hr\023l&A\022Nr@w\029ANl\019A\022\020r\023>")
  }),
  _oYyps = Wherigo.ZCommand({
    Text = _TBt27("g1);.\023?r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("g1);.\023?rl:r.\023r\023l&A\022Nr@w\029AN>")
  }),
  _b7oBD = Wherigo.ZCommand({
    Text = _TBt27("5A@\029rlA\023\029.DDr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("\024.DDrlL.\029l:rLl&A\022Nr@w\029ANl:.rl5A@\029rl:rwl{r@\022L\029@r.Nr@wlA\023>")
  }),
  _3EUA = Wherigo.ZCommand({
    Text = _TBt27("d\023\029r@w\0221)r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_3C2.Commands._o2x.Custom = true
_3C2.Commands._o2x.Id = "27fb3dc3-2d30-4799-b652-224ab06c9d78"
_3C2.Commands._o2x.WorksWithAll = true
_3C2.Commands._oYyps.Custom = true
_3C2.Commands._oYyps.Id = "c145fb32-6658-477c-bd65-5348cb96a134"
_3C2.Commands._oYyps.WorksWithAll = true
_3C2.Commands._b7oBD.Custom = true
_3C2.Commands._b7oBD.Id = "6fde00ed-77a7-4896-8676-3ee0f4aca508"
_3C2.Commands._b7oBD.WorksWithAll = true
_3C2.Commands._3EUA.Custom = true
_3C2.Commands._3EUA.Id = "14203518-71df-4f9b-ba63-1889fe40e44e"
_3C2.Commands._3EUA.WorksWithAll = true
_3C2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3C2.Locked = false
_3C2.Opened = false
_2W_Pn = Wherigo.ZItem({Cartridge = _cEcz, Container = _HeL1v})
_2W_Pn.Id = "eb575fe5-854e-437a-b0a7-917913774a96"
_2W_Pn.Name = _TBt27("5rwwrf")
_2W_Pn.Description = _TBt27("|.\023l5rwwrfl\020\195\188@l&A\022Nr@\029@\195\164\023\019rl.\023l:r@lg\029A\023:A@:A\022w\020\195\188)@\022\023?>]t\nkE33l\026AffrF\023r\023\002")
_2W_Pn.Visible = false
_2W_Pn.Media = _yWA
_2W_Pn.Icon = _yWA
_2W_Pn.Commands = {
  _23Rs = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("hr\023l5rwwrfl\019A\022\020r\023>")
  }),
  _TmHa = Wherigo.ZCommand({
    Text = _TBt27("dL@\195\188)@r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("\ar@L.w1)rl:.rl&\022\029A\029r\023l.Ll5rwwrf>")
  }),
  _crijv = Wherigo.ZCommand({
    Text = _TBt27("|@).\029Ir\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("|@).\029Irl:r\023lZ\023)Af\029l:rwl5rwwrfwlA\022\020lr.\023rlNrw\029.LL\029rl\024rLDr@A\029\022@>")
  }),
  _c0T7 = Wherigo.ZCommand({
    Text = _TBt27("\026\195\164@r\023lfAwwr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("+Awwrl:r\023lZ\023)Af\029l?\195\164@r\023>")
  }),
  _NsAxS = Wherigo.ZCommand({
    Text = _TBt27("T\022wfrr@r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("|\023\029\020r@\023rlAffrl&\022\029A\029r\023lA\022wl:rLl5rwwrf>")
  }),
  _xyex = Wherigo.ZCommand({
    Text = _TBt27("&\022\029A\029l).\023r.\023?rNr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_2W_Pn.Commands._23Rs.Custom = true
_2W_Pn.Commands._23Rs.Id = "dc81cee8-05ad-4dfd-9835-ba746477cbc8"
_2W_Pn.Commands._23Rs.WorksWithAll = true
_2W_Pn.Commands._TmHa.Custom = true
_2W_Pn.Commands._TmHa.Id = "a7c06a2f-e656-4396-ace2-7a0205d84949"
_2W_Pn.Commands._TmHa.WorksWithAll = true
_2W_Pn.Commands._crijv.Custom = true
_2W_Pn.Commands._crijv.Id = "5581bbdf-03ec-409a-955c-8b7578a30587"
_2W_Pn.Commands._crijv.WorksWithAll = true
_2W_Pn.Commands._c0T7.Custom = true
_2W_Pn.Commands._c0T7.Id = "494333be-8b16-4854-8907-d9fc713c9119"
_2W_Pn.Commands._c0T7.WorksWithAll = true
_2W_Pn.Commands._NsAxS.Custom = true
_2W_Pn.Commands._NsAxS.Id = "90554f22-04f2-40aa-a60e-9dccedf10766"
_2W_Pn.Commands._NsAxS.WorksWithAll = true
_2W_Pn.Commands._xyex.Custom = true
_2W_Pn.Commands._xyex.Id = "dacae8da-6155-4ab0-ab52-a7c68d8a5bd5"
_2W_Pn.Commands._xyex.WorksWithAll = true
_2W_Pn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_2W_Pn.Locked = false
_2W_Pn.Opened = false
_anI = Wherigo.ZItem({Cartridge = _cEcz, Container = _tnVG5})
_anI.Id = "d9d2bd93-aec7-481f-830f-dbe0de508f3d"
_anI.Name = _TBt27("dL)A\023?")
_anI.Description = _TBt27("|.\023l@.1)\029.?r@l&A\022Nr@r@l\022\023:lr.\023rl@.1)\029.?rl{r_rlN@A\0221)r\023lr.\023r\023ldL)A\023?M]t\nkE3\\l\026AffrF\023r\023\002")
_anI.Visible = false
_anI.Media = _Sr0
_anI.Icon = _Sr0
_anI.Commands = {
  _MIEn = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("hr\023ldL)A\023?l\019A\022\020r\023>")
  }),
  _5CW = Wherigo.ZCommand({
    Text = _TBt27("T\023I.r)r\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _TBt27("&.r)rl:r\023ldL)A\023?lA\023>")
  })
}
_anI.Commands._MIEn.Custom = true
_anI.Commands._MIEn.Id = "15768e5c-385c-4ab8-98cd-9cba4ecd4b8b"
_anI.Commands._MIEn.WorksWithAll = true
_anI.Commands._5CW.Custom = true
_anI.Commands._5CW.Id = "230b4c67-0108-44ff-ac71-16ad93491cd1"
_anI.Commands._5CW.WorksWithAll = true
_anI.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_anI.Locked = false
_anI.Opened = false
_nMqCp = Wherigo.ZItem({Cartridge = _cEcz, Container = _4BVI})
_nMqCp.Id = "0385b9f0-40f4-4fd3-a5fc-9f0de2518361"
_nMqCp.Name = _TBt27("\001AD.r@l\022\023:l\018r:r@")
_nMqCp.Description = _TBt27("\001AD.r@l\022\023:l\018r:r@>]t\nkET\019\029.F\023wD@r.wal\006l\026AffrF\023r\023\002")
_nMqCp.Visible = false
_nMqCp.Media = _tYSC
_nMqCp.Icon = _tYSC
_nMqCp.Commands = {
  _b8sUo = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("\001AD.r@l\022\023:l\018r:r@l\019A\022\020r\023>")
  }),
  _q61s = Wherigo.ZCommand({
    Text = _TBt27("+F?lw1)@r.Nr\023"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  })
}
_nMqCp.Commands._b8sUo.Custom = true
_nMqCp.Commands._b8sUo.Id = "a55f4a38-1318-4697-917d-8f11f16b1232"
_nMqCp.Commands._b8sUo.WorksWithAll = true
_nMqCp.Commands._q61s.Custom = true
_nMqCp.Commands._q61s.Id = "2dc4b642-12b2-4fa4-9a79-81110275e4cc"
_nMqCp.Commands._q61s.WorksWithAll = true
_nMqCp.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nMqCp.Locked = false
_nMqCp.Opened = false
_j7wSq = Wherigo.ZItem({Cartridge = _cEcz, Container = _tnVG5})
_j7wSq.Id = "3c8a725f-9fff-49fb-9f03-b286351dba9f"
_j7wSq.Name = _TBt27("5@A;A\029\029rl.\023l\026@q\020\020.\023:F@\020A@Nr\023")
_j7wSq.Description = _TBt27("5@A;A\029\029rl.\023l:r\023l\026@q\020\020.\023:F@\020A@Nr\023>]t\nkE\\l\026AffrF\023r\023\002")
_j7wSq.Visible = false
_j7wSq.Media = _xWl
_j7wSq.Icon = _xWl
_j7wSq.Commands = {
  _M0_FE = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("h.rl5@A;A\029\029rl\019A\022\020r\023>")
  })
}
_j7wSq.Commands._M0_FE.Custom = true
_j7wSq.Commands._M0_FE.Id = "2980e2b9-e7b8-49f6-86d9-426c5939f272"
_j7wSq.Commands._M0_FE.WorksWithAll = true
_j7wSq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_j7wSq.Locked = false
_j7wSq.Opened = false
_59lH = Wherigo.ZItem({Cartridge = _cEcz, Container = _HeL1v})
_59lH.Id = "bf583f12-d1a8-4f78-921a-82bb7b082ca9"
_59lH.Name = _TBt27("&A\022Nr@\029@A\023\019\020fAw1)r\023")
_59lH.Description = _TBt27("&A\022Nr@\029@A\023\019\020fAw1)r\023>lgrfNw\029r@\019f\195\164@r\023:>]t\nkE3Cl\026AffrF\023r\023\002")
_59lH.Visible = false
_59lH.Media = _k08is
_59lH.Icon = _k08is
_59lH.Commands = {
  _kgl6 = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("h.rl&A\022Nr@\029@A\023\019\020fAw1)r\023l\019A\022\020r\023>")
  })
}
_59lH.Commands._kgl6.Custom = true
_59lH.Commands._kgl6.Id = "ce5f332f-e2fe-4840-8eee-1d8d1a6dc0d4"
_59lH.Commands._kgl6.WorksWithAll = true
_59lH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_59lH.Locked = false
_59lH.Opened = false
_vwx = Wherigo.ZItem({Cartridge = _cEcz, Container = Player})
_vwx.Id = "e433de92-2514-4c9d-a951-05f82dc6be1f"
_vwx.Name = _TBt27("5A@\029rl:rwl\n\022L\029@r.Nr@w")
_vwx.Description = _TBt27("h.rl5A@\029rl:rwl\n\022L\029@r.Nr@wlUF\023l5@F\023rol\024A\029Irol`FF\023ql\022\023:lR\022@Lw1);A\023I>")
_vwx.Visible = false
_vwx.Media = _6IFAT
_vwx.Icon = _6IFAT
_vwx.Commands = {
  _DtXvN = Wherigo.ZCommand({
    Text = _TBt27("T\023w1)A\022r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _TBt27("g1)A\022rl:.@l:.rl5A@\029rlA\023>")
  })
}
_vwx.Commands._DtXvN.Custom = true
_vwx.Commands._DtXvN.Id = "6a4664b5-5f6b-49a0-a665-dceb58b09b9a"
_vwx.Commands._DtXvN.WorksWithAll = true
_vwx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_vwx.Locked = false
_vwx.Opened = false
_7mUH = Wherigo.ZItem(_cEcz)
_7mUH.Id = "e4b715d6-c6c1-4f7d-9d92-460e7bcbc5f4"
_7mUH.Name = _TBt27("t@.r\020lUF\023l{F?;A@\029w")
_7mUH.Description = ""
_7mUH.Visible = true
_7mUH.Media = _1NLg
_7mUH.Icon = _1NLg
_7mUH.Commands = {
  _h8QO = Wherigo.ZCommand({
    Text = _TBt27("+rwr\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_7mUH.Commands._h8QO.Custom = true
_7mUH.Commands._h8QO.Id = "4b3cdbdb-60f0-49e4-b132-42ed6bee265d"
_7mUH.Commands._h8QO.WorksWithAll = true
_7mUH.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_7mUH.Locked = false
_7mUH.Opened = false
_ppHB = Wherigo.ZItem({Cartridge = _cEcz, Container = _tnVG5})
_ppHB.Id = "00fcced5-2a85-4476-b09f-53b0315738c7"
_ppHB.Name = _TBt27("5@A;A\029\029rl.\023l\nAUr\0231fA;\020A@Nr\023")
_ppHB.Description = _TBt27("5@A;A\029\029rl.\023l:r\023l\nAUr\0231fA;\020A@Nr\023>]t\nkE\\l\026AffrF\023r\023\002")
_ppHB.Visible = false
_ppHB.Media = _TPZx6
_ppHB.Icon = _TPZx6
_ppHB.Commands = {
  _XcdQ = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_ppHB.Commands._XcdQ.Custom = true
_ppHB.Commands._XcdQ.Id = "85c62739-58f3-4ffe-9586-e6777e3a9b31"
_ppHB.Commands._XcdQ.WorksWithAll = true
_ppHB.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ppHB.Locked = false
_ppHB.Opened = false
_Uh6aL = Wherigo.ZItem({Cartridge = _cEcz, Container = _tnVG5})
_Uh6aL.Id = "6ce7d8b5-4cb3-478e-b476-c0dd4d46729c"
_Uh6aL.Name = _TBt27("5@A;A\029\029rl.\023lgfq\029)r@.\023\020A@Nr\023")
_Uh6aL.Description = _TBt27("5@A;A\029\029rl.\023l:r\023lgfq\029)r@.\023\020A@Nr\023>]t\nkE\\l\026AffrF\023r\023\002")
_Uh6aL.Visible = false
_Uh6aL.Media = _woyfP
_Uh6aL.Icon = _woyfP
_Uh6aL.Commands = {
  _uIDtl = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_Uh6aL.Commands._uIDtl.Custom = true
_Uh6aL.Commands._uIDtl.Id = "01f21d0b-db0f-4ddd-acef-d0dd2a47cca5"
_Uh6aL.Commands._uIDtl.WorksWithAll = true
_Uh6aL.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Uh6aL.Locked = false
_Uh6aL.Opened = false
_32KS = Wherigo.ZItem({Cartridge = _cEcz, Container = _tnVG5})
_32KS.Id = "3d86ba7e-44e1-4259-940d-c65bbb66cf0c"
_32KS.Name = _TBt27("5@A;A\029\029rl.\023l{\022\020\020frD\022\020\020\020A@Nr\023")
_32KS.Description = _TBt27("5@A;A\029\029rl.\023l:r\023l{\022\020\020frD\022\020\020\020A@Nr\023>]t\nkE\\l\026AffrF\023r\023\002")
_32KS.Visible = false
_32KS.Media = _ZDQ
_32KS.Icon = _ZDQ
_32KS.Commands = {
  _PhE = Wherigo.ZCommand({
    Text = _TBt27("5A\022\020r\023"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_32KS.Commands._PhE.Custom = true
_32KS.Commands._PhE.Id = "a699cd8b-7536-41b6-900b-0c5861ed1ed1"
_32KS.Commands._PhE.WorksWithAll = true
_32KS.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_32KS.Locked = false
_32KS.Opened = false
_AHB = Wherigo.ZTask(_cEcz)
_AHB.Id = "653aa0c3-154f-46f1-84a4-6926d2ac071c"
_AHB.Name = _TBt27("\026r)rlI\022Ll+.?\022w\029r@;r?")
_AHB.Description = _TBt27("\026r)rlI\022Ll+.?\022w\029r@;r?>")
_AHB.Visible = true
_AHB.Media = _Lm3H
_AHB.Icon = _Lm3H
_AHB.Active = false
_AHB.Complete = false
_AHB.CorrectState = "None"
_f18uQ = Wherigo.ZTask(_cEcz)
_f18uQ.Id = "512b7fcd-e0dc-4fd2-8ad1-1e086276dc4d"
_f18uQ.Name = _TBt27("gD@.1)lL.\029l\ar@\023F\023")
_f18uQ.Description = _TBt27("gD@.1)lL.\029l\ar@\023F\023>")
_f18uQ.Visible = true
_f18uQ.Media = _uLOgI
_f18uQ.Icon = _uLOgI
_f18uQ.Active = false
_f18uQ.Complete = false
_f18uQ.CorrectState = "None"
_UP4 = Wherigo.ZTask(_cEcz)
_UP4.Id = "9d085834-abf0-48f7-b035-080583a39c4b"
_UP4.Name = _TBt27("\026r)rlI\022Ll\024@FD\020r\023:r\023l5rwwrf")
_UP4.Description = _TBt27("\026r)rlI\022Ll\024@FD\020r\023:r\023l5rwwrf>")
_UP4.Visible = true
_UP4.Media = _NGTgz
_UP4.Icon = _NGTgz
_UP4.Active = false
_UP4.Complete = false
_UP4.CorrectState = "None"
_ZrT7z = Wherigo.ZTask(_cEcz)
_ZrT7z.Id = "df85e490-63dd-463a-951b-9a0b5086f437"
_ZrT7z.Name = _TBt27("g\0221)rl:.rl|\022fr")
_ZrT7z.Description = _TBt27("g\0221)rl:.rl|\022fr>")
_ZrT7z.Visible = true
_ZrT7z.Media = _PRI
_ZrT7z.Icon = _PRI
_ZrT7z.Active = false
_ZrT7z.Complete = false
_ZrT7z.CorrectState = "None"
_zmvsK = Wherigo.ZTask(_cEcz)
_zmvsK.Id = "87a918bb-57f2-4fd8-8adb-5ce8379832b3"
_zmvsK.Name = _TBt27("\026r)rlI\022@lZ\023wrflL.\029l:rLl\024\022@L")
_zmvsK.Description = _TBt27("\026r)rlI\022@lZ\023wrflL.\029l:rLl\024\022@L>")
_zmvsK.Visible = true
_zmvsK.Media = _Zjn
_zmvsK.Icon = _Zjn
_zmvsK.Active = false
_zmvsK.Complete = false
_zmvsK.CorrectState = "None"
_R2QK = Wherigo.ZTask(_cEcz)
_R2QK.Id = "f48ea901-d203-48de-ad72-ad97791a2897"
_R2QK.Name = _TBt27("gD@.1)lL.\029l{A?@.:")
_R2QK.Description = _TBt27("gD@.1)lL.\029l{A?@.:>")
_R2QK.Visible = true
_R2QK.Media = _BdA
_R2QK.Icon = _BdA
_R2QK.Active = false
_R2QK.Complete = false
_R2QK.CorrectState = "None"
_7mHt = Wherigo.ZTask(_cEcz)
_7mHt.Id = "dcb1ad19-4f18-4c73-abcd-3a0a51b4aa4f"
_7mHt.Name = _TBt27("\018.\023:rlr.\023r\023lRr?l.\023l:.rlR.\023\019rf?Awwr")
_7mHt.Description = _TBt27("\018.\023:rlr.\023r\023lRr?l.\023l:.rlR.\023\019rf?Awwr>")
_7mHt.Visible = true
_7mHt.Media = _bRH
_7mHt.Icon = _bRH
_7mHt.Active = false
_7mHt.Complete = false
_7mHt.CorrectState = "None"
_EhFk = Wherigo.ZTask(_cEcz)
_EhFk.Id = "3c8726f9-372f-4d05-af7d-e01097691eb2"
_EhFk.Name = _TBt27("{rNrl\026rf:lAN")
_EhFk.Description = _TBt27("{rNrl\026rf:lNr.l\026@.\023?F\029\029wlAN>")
_EhFk.Visible = true
_EhFk.Media = _DkN8a
_EhFk.Icon = _DkN8a
_EhFk.Active = false
_EhFk.Complete = false
_EhFk.CorrectState = "None"
_nYcC = Wherigo.ZTask(_cEcz)
_nYcC.Id = "b63a5bcd-85e5-48bf-aa66-4b472a074db3"
_nYcC.Name = _TBt27("\026r)rl|.\023\019A\022\020r\023")
_nYcC.Description = _TBt27("\026r)rl.\023l:r@l`A@\019\029?Awwrlr.\023\019A\022\020r\023>lh\022lNr\023\195\182\029.?w\029l\020Ff?r\023:rlh.\023?ra]t\nk]t\nk5rwwrf]t\nkg1)\022fN\195\1881)r@]t\nkdL)A\023?]t\nk\001AD.r@l\022\023:l\018r:r@]t\nk&A\022Nr@w\029AN")
_nYcC.Visible = true
_nYcC.Media = _bRH
_nYcC.Icon = _bRH
_nYcC.Active = false
_nYcC.Complete = false
_nYcC.CorrectState = "None"
__8WBE = Wherigo.ZTask(_cEcz)
__8WBE.Id = "b3c9aa50-c7ed-47fc-925e-36736bf7b336"
__8WBE.Name = _TBt27("\026r)rlI\022LltA)\023)F\020")
__8WBE.Description = _TBt27("\026r)rlI\022LltA)\023)F\020l5.\023?Hwl0@Fwwl\022\023:lw\0221)rl\026fr.wl!l^X\006>")
__8WBE.Visible = true
__8WBE.Media = _jWr
__8WBE.Icon = _jWr
__8WBE.Active = false
__8WBE.Complete = false
__8WBE.CorrectState = "None"
_SSYom = Wherigo.ZTask(_cEcz)
_SSYom.Id = "7a8b8f4e-eabd-477b-8e28-a340875776be"
_SSYom.Name = _TBt27("gD@.1)lL.\029l`FffqlRrAwfrq")
_SSYom.Description = _TBt27("gD@.1)lL.\029l`FffqlRrAwfrq>")
_SSYom.Visible = true
_SSYom.Media = __3SHa
_SSYom.Icon = __3SHa
_SSYom.Active = false
_SSYom.Complete = false
_SSYom.CorrectState = "None"
_tSi = Wherigo.ZTask(_cEcz)
_tSi.Id = "c86b9ac4-07ed-4a24-9c83-0e3d9f538420"
_tSi.Name = _TBt27("\026r)rl\023A1)l{F?;A@\029w")
_tSi.Description = _TBt27("\026r)rl\023A1)l{F?;A@\029w>l\018Ff?rl:r\023l\026fr.wr\023lI\022Llg1)fFwwlEN.\029\029rl:.rl\026fr.wrl\023.1)\029lNr\029@r\029r\023M\002>")
_tSi.Visible = true
_tSi.Media = _ERe
_tSi.Icon = _ERe
_tSi.Active = false
_tSi.Complete = false
_tSi.CorrectState = "None"
_Pf4 = Wherigo.ZTask(_cEcz)
_Pf4.Id = "28203749-7f36-45dc-b670-4f9485a9effa"
_Pf4.Name = _TBt27("gD@.1)lL.\029l`.\023r@UAl`1\026F\023A?Aff")
_Pf4.Description = _TBt27("gD@.1)lL.\029l`.\023r@UAl`1\026F\023A?Aff>")
_Pf4.Visible = true
_Pf4.Media = _n6d
_Pf4.Icon = _n6d
_Pf4.Active = false
_Pf4.Complete = false
_Pf4.CorrectState = "None"
_DvLoX = Wherigo.ZTask(_cEcz)
_DvLoX.Id = "0150c8cf-d91c-4298-bcc6-54d1d74f862e"
_DvLoX.Name = _TBt27("t@A\022rlr.\023lt\022\029\029r@N.r@")
_DvLoX.Description = _TBt27("t@A\022rlr.\023lt\022\029\029r@N.r@>")
_DvLoX.Visible = true
_DvLoX.Media = _KFo
_DvLoX.Icon = _KFo
_DvLoX.Active = false
_DvLoX.Complete = false
_DvLoX.CorrectState = "None"
_Boyl = Wherigo.ZTask(_cEcz)
_Boyl.Id = "471955b7-4f16-413f-ae8b-51caef769c85"
_Boyl.Name = _TBt27("gD@.1)lL.\029l\018@r:l\022\023:l\026rF@?r")
_Boyl.Description = _TBt27("gD@.1)lL.\029l\018@r:l\022\023:l\026rF@?r>")
_Boyl.Visible = true
_Boyl.Media = _AhdW
_Boyl.Icon = _AhdW
_Boyl.Active = false
_Boyl.Complete = false
_Boyl.CorrectState = "None"
_t2Lz = Wherigo.ZTask(_cEcz)
_t2Lz.Id = "305d1616-d320-4d7e-ab6e-5de589d31a53"
_t2Lz.Name = _TBt27("g1)A\022l:.@l:.rl5A@\029rl:rwl\n\022L\029@r.Nr@wlA\023")
_t2Lz.Description = _TBt27("g1)A\022l:.@l:.rl5A@\029rl:rwl\n\022L\029@r.Nr@wlA\023>")
_t2Lz.Visible = true
_t2Lz.Media = _6IFAT
_t2Lz.Icon = _6IFAT
_t2Lz.Active = false
_t2Lz.Complete = false
_t2Lz.CorrectState = "None"
_epfQo = Wherigo.ZTask(_cEcz)
_epfQo.Id = "66224dee-db33-4b9e-8289-9d8eacfa7508"
_epfQo.Name = _TBt27("\026r)rlI\022@l\001r.\029w1)r\023:r\023lRr.:r")
_epfQo.Description = _TBt27("\026r)rlI\022@l\001r.\029w1)r\023:r\023lRr.:r>")
_epfQo.Visible = true
_epfQo.Media = _H9PyJ
_epfQo.Icon = _H9PyJ
_epfQo.Active = false
_epfQo.Complete = false
_epfQo.CorrectState = "None"
_Ufxv = Wherigo.ZTask(_cEcz)
_Ufxv.Id = "08e61c2c-a971-4346-9279-b3760e694132"
_Ufxv.Name = _TBt27("\026.Nl:.1)lAfwlr1)\029r@l&A\022Nr@r@lF:r@lAfwlr1)\029rl{r_rlI\022lr@\019r\023\023r\023")
_Ufxv.Description = _TBt27("\026.Nl:.1)lAfwlr1)\029r@l&A\022Nr@r@lF:r@lAfwlr1)\029rl{r_rlI\022lr@\019r\023\023r\023>")
_Ufxv.Visible = true
_Ufxv.Media = _ERe
_Ufxv.Icon = _ERe
_Ufxv.Active = false
_Ufxv.Complete = false
_Ufxv.CorrectState = "None"
_XcsJS = Wherigo.ZTask(_cEcz)
_XcsJS.Id = "f56123a6-0318-4f12-b378-09901f67dd4f"
_XcsJS.Name = _TBt27("\026r)rlI\022@l{r\022fr\023:r\023l{\195\188\029\029r")
_XcsJS.Description = _TBt27("\026r)rlI\022@l{r\022fr\023:r\023l{\195\188\029\029r>")
_XcsJS.Visible = true
_XcsJS.Media = _mPlrx
_XcsJS.Icon = _mPlrx
_XcsJS.Active = false
_XcsJS.Complete = false
_XcsJS.CorrectState = "None"
_OHO = Wherigo.ZTask(_cEcz)
_OHO.Id = "13c5fb5d-544d-41a6-968b-1bbf53c19b47"
_OHO.Name = _TBt27("gD@.1)lL.\029l\nF\023l\022\023:l{r@L.\023r")
_OHO.Description = _TBt27("gD@.1)lL.\029l\nF\023l\022\023:l{r@L.\023r>")
_OHO.Visible = true
_OHO.Media = _hAk6
_OHO.Icon = _hAk6
_OHO.Active = false
_OHO.Complete = false
_OHO.CorrectState = "None"
_HO4r = Wherigo.ZTask(_cEcz)
_HO4r.Id = "0a2ae2b0-91db-4645-8150-f4b0bac19020"
_HO4r.Name = _TBt27("+.rwl:r\023lt@.r\020lUF\023l{F?;A@\029w")
_HO4r.Description = _TBt27("+.rwl:r\023lt@.r\020lUF\023l{F?;A@\029w>")
_HO4r.Visible = true
_HO4r.Media = _1NLg
_HO4r.Icon = _1NLg
_HO4r.Active = false
_HO4r.Complete = false
_HO4r.CorrectState = "None"
_tMZ5 = Wherigo.ZTask(_cEcz)
_tMZ5.Id = "4c938791-219b-4cd4-bc35-7f78d0220ae4"
_tMZ5.Name = _TBt27("\026r)rlI\022Ll\026fr.wl!l^X\006")
_tMZ5.Description = _TBt27("\026r)rlI\022Ll\026fr.wl!l^X\006>")
_tMZ5.Visible = true
_tMZ5.Media = _tK_pr
_tMZ5.Icon = _tK_pr
_tMZ5.Active = false
_tMZ5.Complete = false
_tMZ5.CorrectState = "None"
_Tty = Wherigo.ZTask(_cEcz)
_Tty.Id = "40fbda9a-f52a-4bba-b3d9-8200bbbc7cf1"
_Tty.Name = _TBt27("t@.\023?rl:r\023l&\022?lI\022Ll\018A)@r\023")
_Tty.Description = _TBt27("t@.\023?rl:r\023l{F?;A@\029wr_D@rwwlI\022Ll+Fw\020A)@r\023>")
_Tty.Visible = true
_Tty.Media = _LadtD
_Tty.Icon = _LadtD
_Tty.Active = false
_Tty.Complete = false
_Tty.CorrectState = "None"
_Aam = Wherigo.ZTask(_cEcz)
_Aam.Id = "44908ec1-9101-4dc0-8531-181219e8de6f"
_Aam.Name = _TBt27("+F??rl:r\023l0A1)r")
_Aam.Description = _TBt27("+F??rl:r\023l0A1)r>")
_Aam.Visible = true
_Aam.Media = _tYSC
_Aam.Icon = _tYSC
_Aam.Active = false
_Aam.Complete = false
_Aam.CorrectState = "None"
_0MG3 = false
_ZPmg = false
_Sjme = false
_zHLnz = false
_lhrEc = 0
_DOr = true
_R9e = false
_c1Qm = false
_Nqn = false
_gVgPJ = false
_EZYXZ = false
_FoyzV = false
_JZE = 0
_lhG = false
_K3zjX = false
_9hkU = false
_z6OXu = false
_kpUIL = false
_XuB = false
_yFfJ0 = false
_2AN = true
_Pav2 = true
_ePDv = true
_6ck = true
_a3X = true
_0JM = true
_vXJNe = true
_9qe = true
_k5p = true
_64l = true
_Ot0k = true
_wv0Ih = true
_QBdY = true
_QIsU_ = true
_GfnR = true
_q4285 = true
_C7t2l = true
_mrgN1 = true
_yXgfz = true
_wLBH = true
_X59 = false
_Eef = true
_kCQ_h = 1
_0EIf = true
_53Ql = true
_5WlDw = true
_sJ6X = 0
_9o5S = 0
_a7Q = 0
_TY_K = 0
_aYG0 = 0
_shTi = 0
_T5N = 0
_Kjh = false
_v_b = _TBt27("7[`\026\024")
_Pxp = _TBt27("7R.\022")
_7aTgg = _TBt27("7d\0167\029")
_LcwWX = _TBt27("7T{t")
_rEzo = _TBt27("7g7\029")
_LfsL = _TBt27("7\016+Id\030")
_cEcz.ZVariables = {
  _0MG3 = false,
  _ZPmg = false,
  _Sjme = false,
  _zHLnz = false,
  _lhrEc = 0,
  _DOr = true,
  _R9e = false,
  _c1Qm = false,
  _Nqn = false,
  _gVgPJ = false,
  _EZYXZ = false,
  _FoyzV = false,
  _JZE = 0,
  _lhG = false,
  _K3zjX = false,
  _9hkU = false,
  _z6OXu = false,
  _kpUIL = false,
  _XuB = false,
  _yFfJ0 = false,
  _2AN = true,
  _Pav2 = true,
  _ePDv = true,
  _6ck = true,
  _a3X = true,
  _0JM = true,
  _vXJNe = true,
  _9qe = true,
  _k5p = true,
  _64l = true,
  _Ot0k = true,
  _wv0Ih = true,
  _QBdY = true,
  _QIsU_ = true,
  _GfnR = true,
  _q4285 = true,
  _C7t2l = true,
  _mrgN1 = true,
  _yXgfz = true,
  _wLBH = true,
  _X59 = false,
  _Eef = true,
  _kCQ_h = 1,
  _0EIf = true,
  _53Ql = true,
  _5WlDw = true,
  _sJ6X = 0,
  _9o5S = 0,
  _a7Q = 0,
  _TY_K = 0,
  _aYG0 = 0,
  _shTi = 0,
  _T5N = 0,
  _Kjh = false,
  _v_b = _TBt27("7[`\026\024"),
  _Pxp = _TBt27("7R.\022"),
  _7aTgg = _TBt27("7d\0167\029"),
  _LcwWX = _TBt27("7T{t"),
  _rEzo = _TBt27("7g7\029"),
  _LfsL = _TBt27("7\016+Id\030")
}
_OLzUj = Wherigo.ZTimer(_cEcz)
_OLzUj.Id = "9345a10d-4c43-45bb-8955-36a6b406b108"
_OLzUj.Name = _TBt27("\026@.\023?F\029\029w\024.Lr@")
_OLzUj.Description = ""
_OLzUj.Visible = true
_OLzUj.Duration = 180
_OLzUj.Type = "Countdown"
_TVx = Wherigo.ZTimer(_cEcz)
_TVx.Id = "320a1077-3a51-4964-8655-3d0b686060ea"
_TVx.Name = _TBt27("\001fAq\024.Lr")
_TVx.Description = ""
_TVx.Visible = true
_TVx.Duration = 3600
_TVx.Type = "Interval"
_S_t = Wherigo.ZInput(_cEcz)
_S_t.Id = "9790a60d-0fc9-463c-9e50-6fe9401ea4ad"
_S_t.Name = _TBt27("t@.r\020")
_S_t.Description = ""
_S_t.Visible = true
_S_t.Media = _1NLg
_S_t.Icon = _1NLg
_S_t.InputType = "Text"
_S_t.Text = _TBt27("RAwlw\029r)\029l.Llt@.r\020\004")
__cf = Wherigo.ZInput(_cEcz)
__cf.Id = "68833fe8-0cee-49ed-b7a1-ebba0ad32f71"
__cf.Name = _TBt27("\024\022@L")
__cf.Description = ""
__cf.Visible = true
__cf.Media = _BdA
__cf.Icon = _BdA
__cf.InputType = "Text"
__cf.Text = _TBt27("RAwlw\029r)\029lA\022\020l:r.\023r@l\024F@\029rol:.rl.1)l:.@lI\022Llrf\020\029r\023l\026rN\022@\029w\029A?lr_\029@Al?rNA1\019r\023l)ANr\004")
_tK0Yx = Wherigo.ZInput(_cEcz)
_tK0Yx.Id = "fb7f244a-a83a-438d-9de5-88aa8411d7a5"
_tK0Yx.Name = _TBt27("tA1\019w\029r.\023l3")
_tK0Yx.Description = _TBt27("tA1\019w\029r.\023l3")
_tK0Yx.Visible = true
_tK0Yx.Media = _jEv
_tK0Yx.Icon = _jEv
_tK0Yx.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5"
}
_tK0Yx.InputType = "MultipleChoice"
_tK0Yx.Text = _TBt27("Rrf1)r@lg\029r.\023l.w\029l:r@l:\022\023\019rfw\029r\004")
_Y2LX = Wherigo.ZInput(_cEcz)
_Y2LX.Id = "2e33d49e-17c9-4892-8db5-d600e5a05a73"
_Y2LX.Name = _TBt27("tA1\019w\029r.\023l\b")
_Y2LX.Description = _TBt27("tA1\019w\029r.\023l\b")
_Y2LX.Visible = true
_Y2LX.Media = _jEv
_Y2LX.Icon = _jEv
_Y2LX.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5"
}
_Y2LX.InputType = "MultipleChoice"
_Y2LX.Text = _TBt27("T\022\020l;rf1)r\023lg\029r.\023lIr.?\029l:r@lgFf:A\029\004")
_8y7 = Wherigo.ZInput(_cEcz)
_8y7.Id = "337a72bd-461d-43a1-83d3-4f50b25d112c"
_8y7.Name = _TBt27("tA1\019w\029r.\023l^")
_8y7.Description = _TBt27("tA1\019w\029r.\023l^")
_8y7.Visible = true
_8y7.Media = _jEv
_8y7.Icon = _jEv
_8y7.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5"
}
_8y7.InputType = "MultipleChoice"
_8y7.Text = _TBt27("Rrf1)r@lg\029r.\023lNr\020.\023:r\029lw.1)l\195\188Nr@lr.\023rLl|.\023w1)\022wwfF1)\004")
_u7BF = Wherigo.ZInput(_cEcz)
_u7BF.Id = "5ed43007-817a-41f1-a201-c1039e944929"
_u7BF.Name = _TBt27("tA1\019w\029r.\023l\006")
_u7BF.Description = _TBt27("tA1\019w\029r.\023l\006")
_u7BF.Visible = true
_u7BF.Media = _jEv
_u7BF.Icon = _jEv
_u7BF.Choices = {
  "1",
  "2",
  "3",
  "4",
  "5"
}
_u7BF.InputType = "MultipleChoice"
_u7BF.Text = _TBt27("Rrf1)r@lg\029r.\023lNr\020.\023:r\029lw.1)l?r@A:rl\022\023\029r@l:rLl\026r.wwr\023\019FD\020\004")
_i_OM = Wherigo.ZInput(_cEcz)
_i_OM.Id = "73eb2921-b074-491a-aa98-6a07f9b38dfe"
_i_OM.Name = _TBt27("t\0221)r.\023?ANrl3")
_i_OM.Description = ""
_i_OM.Visible = true
_i_OM.Media = _xm3Zd
_i_OM.Icon = _xm3Zd
_i_OM.Choices = {
  "A",
  "B",
  "C"
}
_i_OM.InputType = "MultipleChoice"
_i_OM.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTalh\022\023\019frl5@\195\164\020\029ral|.\023l5\022@wlI\022@lgrfNw\029Ur@\029r.:.?\022\023?]t\nktal\024A\023IlL.\029lr.\023r@l\024F:rw\020rr]t\nk0al\024)rF@.rl:r@lLA?.w1)r\023l\ar@\029r.:.?\022\023?]t\nk")
_O3Hh = Wherigo.ZInput(_cEcz)
_O3Hh.Id = "f06865b0-8022-435b-b771-7d663def2914"
_O3Hh.Name = _TBt27("t\0221)r.\023?ANrl\b")
_O3Hh.Description = ""
_O3Hh.Visible = true
_O3Hh.Media = _xm3Zd
_O3Hh.Icon = _xm3Zd
_O3Hh.Choices = {
  "A",
  "B",
  "C"
}
_O3Hh.InputType = "MultipleChoice"
_O3Hh.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTal|.\023lbA)@lNr.lr.\023rLl\015r\029.]t\nktal&A\022Nr@\023l\020\195\188@lT\023\020\195\164\023?r@]t\nk0al+r)@N\0221)l:r@l&A\022Nr@wD@\195\1881)r")
_pcN = Wherigo.ZInput(_cEcz)
_pcN.Id = "1d531989-3e71-43b1-952e-4ea313cf94ce"
_pcN.Name = _TBt27("t\0221)r.\023?ANrl^")
_pcN.Description = ""
_pcN.Visible = true
_pcN.Media = _xm3Zd
_pcN.Icon = _xm3Zd
_pcN.Choices = {
  "A",
  "B",
  "C"
}
_pcN.InputType = "MultipleChoice"
_pcN.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTal\026ALLrf\023lL.\029l\026)\022fr\023]t\nktal\ar@;A\023:f\022\023?lGlh.rl&;.w1)r\023w\029\022\020r\023]t\nk0al\ar@;A\023:f\022\023?r\023l\020\195\188@lT\023\020\195\164\023?r@")
_aZN = Wherigo.ZInput(_cEcz)
_aZN.Id = "961cc327-0fa8-4851-ba0d-229030672a4d"
_aZN.Name = _TBt27("t\0221)r.\023?ANrl\006")
_aZN.Description = ""
_aZN.Visible = true
_aZN.Media = _xm3Zd
_aZN.Icon = _xm3Zd
_aZN.Choices = {
  "A",
  "B",
  "C"
}
_aZN.InputType = "MultipleChoice"
_aZN.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTal\024@.DwlL.\029l\024@Fffr\023]t\nktal\024A\022wr\023:l&A\022Nr@\019@\195\164\022\029r@l\022\023:lGD.fIr]t\nk0al\aF\023lTf@A\022\023r\023lN.wlI\022l&.\029\029r@\023:r\023l\026.\023w\029r@N\195\188w1)r\023")
_7e7 = Wherigo.ZInput(_cEcz)
_7e7.Id = "e9ad15cf-87ff-4ae5-8e87-05f0509ceecd"
_7e7.Name = _TBt27("t\0221)r.\023?ANrly")
_7e7.Description = ""
_7e7.Visible = true
_7e7.Media = _xm3Zd
_7e7.Icon = _xm3Zd
_7e7.Choices = {
  "A",
  "B",
  "C"
}
_7e7.InputType = "MultipleChoice"
_7e7.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTal&A\022Nr@\029@\195\164\023\019rl\022\023:l&A\022Nr@N@\195\164\022r]t\nktalRA\023:r@\022\023?r\023lL.\029lRr@;\195\182f\020r\023]t\nk0al&A\022Nr@\029@\195\164\023\019rl\020\195\188@lT\023\020\195\164\023?r@")
_aMJnV = Wherigo.ZInput(_cEcz)
_aMJnV.Id = "2d1ceb75-0b03-47a4-9a6a-a5c034934d72"
_aMJnV.Name = _TBt27("t\0221)r.\023?ANrl/")
_aMJnV.Description = ""
_aMJnV.Visible = true
_aMJnV.Media = _xm3Zd
_aMJnV.Icon = _xm3Zd
_aMJnV.Choices = {
  "A",
  "B",
  "C"
}
_aMJnV.InputType = "MultipleChoice"
_aMJnV.Text = _TBt27("Rrf1)rwl:.rwr@lt\195\1881)r@lNr\023\195\182\029.?w\029l:\022\004]t\nkTalZLlT\023?rw.1)\029l:rwl\026rw.1)\029wfFwr\023]t\nktal\018r@.r\023lL.\029l\ar\029\029rf\023]t\nk0al\018A\023\029Aw\029.w1)rl\024.r@;rwr\023l\022\023:l;Flw.rlI\022l\020.\023:r\023lw.\023:")
_pckJH = Wherigo.ZInput(_cEcz)
_pckJH.Id = "e4491875-50f6-43e1-b76c-35027c80defc"
_pckJH.Name = _TBt27("&A\022Nr@w\029AN")
_pckJH.Description = ""
_pckJH.Visible = true
_pckJH.Media = _WSQ
_pckJH.Icon = _WSQ
_pckJH.InputType = "Text"
_pckJH.Text = _TBt27("R.rU.rfl\019Fw\029r\029l:r@l&A\022Nr@w\029ANl.\023l\026AffrF\023r\023\004")
_Zt7wl = Wherigo.ZInput(_cEcz)
_Zt7wl.Id = "255ff157-9087-49c7-9457-9f5de7c0bc7e"
_Zt7wl.Name = _TBt27("g1@.NN\022f\022w")
_Zt7wl.Description = ""
_Zt7wl.Visible = true
_Zt7wl.Media = _fc8
_Zt7wl.Icon = _fc8
_Zt7wl.InputType = "Text"
_Zt7wl.Text = _TBt27("R.rl)r.ww\029l:Awlr@w\029rlA\023?rw1)@.rNr\023rl{A\022wl?r?r\023\195\188Nr@lUF\023lg1@.NN\022f\022wlETf\029w\029A:\029l\001ADr\029r@.r\002\004]t\nk$&\022Ll>>>$")
_QrUsI = Wherigo.ZInput(_cEcz)
_QrUsI.Id = "62030170-4a8e-4700-a3cb-b9f154daa7b1"
_QrUsI.Name = _TBt27("`A:ALl`Af\019.\023w")
_QrUsI.Description = ""
_QrUsI.Visible = true
_QrUsI.Media = __ny6r
_QrUsI.Icon = __ny6r
_QrUsI.InputType = "Text"
_QrUsI.Text = _TBt27("R.rU.rfrlUr@?.\029\029r@\029rl\018r\023w\029r@lw.r)w\029l:\022l\022\023\029r@l:r\023lU.r@lg1)A\022\020r\023w\029r@\023\004")
_uv7 = Wherigo.ZInput(_cEcz)
_uv7.Id = "3df74ff4-0e24-4dc7-be8f-8ecb5c1b9bba"
_uv7.Name = _TBt27("\001F\029A?rw")
_uv7.Description = ""
_uv7.Visible = true
_uv7.Media = _YKB
_uv7.Icon = _YKB
_uv7.InputType = "Text"
_uv7.Text = _TBt27("T\023l;.rU.rfr\023lRF1)r\023\029A?r\023l)A\029l:Awl\026rw1)\195\164\020\029lEt@F1\019r\023w\029\022Nr\002lF\020\020r\023\004")
_SOFBC = Wherigo.ZInput(_cEcz)
_SOFBC.Id = "053eea82-d455-478e-b39e-d5575e29324b"
_SOFBC.Name = _TBt27("&A\022Nr@wD@\0221)")
_SOFBC.Description = ""
_SOFBC.Visible = true
_SOFBC.Media = _IAZb8
_SOFBC.Icon = _IAZb8
_SOFBC.InputType = "Text"
_SOFBC.Text = _TBt27("Rrf1)r\023l&A\022Nr@wD@\0221)l)Aw\029l:\022l?r\020\022\023:r\023\004")
__bdz = Wherigo.ZInput(_cEcz)
__bdz.Id = "b8302f9a-c7aa-493d-92d9-2b2875a29a9f"
__bdz.Name = _TBt27("t@A\022D\020A\023\023r")
__bdz.Description = ""
__bdz.Visible = true
__bdz.InputType = "Text"
__bdz.Text = _TBt27("Z\023l;rf1)rLlbA)@l)A\029l\001@F\020rwwF@l\nF\023.?r@olr.\023r@l\022\023wr@r@l+r)@r@l\020\195\188@l&A\022Nr@\029@\195\164\023\019rolwr.\023r\023lfr\029I\029r\023l&A\022Nr@\029@A\023\019l?rN@A\022\029\004")
_erfiQ = Wherigo.ZInput(_cEcz)
_erfiQ.Id = "7ad51f9b-357c-4ed5-9128-6cec77315baa"
_erfiQ.Name = _TBt27("\001r.\029w1)r\023:rlRr.:r")
_erfiQ.Description = ""
_erfiQ.Visible = true
_erfiQ.Media = _H9PyJ
_erfiQ.Icon = _H9PyJ
_erfiQ.InputType = "Text"
_erfiQ.Text = _TBt27("T\022\020l;rf1)r@l{\195\182)rlw\029r)\029l:.rl\001r.\029w1)r\023:rlRr.:rlE|.1)r\002lF\020\020.I.rff\004")
_6oR4 = Wherigo.ZInput(_cEcz)
_6oR4.Id = "de0e77d3-bdfa-4f3a-ae1f-8ebd9513c52f"
_6oR4.Name = _TBt27("5rwwrfI\022\029A\029")
_6oR4.Description = ""
_6oR4.Visible = true
_6oR4.Media = _yWA
_6oR4.Icon = _yWA
_6oR4.Choices = {
  "Butter",
  "Gerste",
  "Hefe",
  "Hirse",
  "Hopfen",
  "Kardamon",
  "Malz",
  "Roggen",
  "Weizen",
  "Wasser"
}
_6oR4.InputType = "MultipleChoice"
_6oR4.Text = _TBt27("Rrf1)rl&\022\029A\029lL\195\1821)\029rw\029l:\022l).\023r.\023?rNr\023\004")
function _cEcz:OnStart()
  if _G[_TBt27("|\023U")][_TBt27("hrU.1rZh")] == _TBt27("hrw\019\029FD") or _G[_TBt27("|\023U")][_TBt27("\001fA\029\020F@L")] == _TBt27("R.\023^\b") then
    for k, v in pairs(_G[_TBt27("71|1I")][_TBt27("Tff&\016N\030r1\029w")]) do
      v[_TBt27("\a.w.Nfr")] = false
      v[_TBt27("T1\029.Ur")] = false
    end
    _G[_TBt27("R)r@.?F")][_TBt27("0FLLA\023:")](_TBt27("gAUr0fFwr"))
    return
  end
  _Urwigo.Dialog(false, {
    {
      Text = (_TBt27("{AffFl") .. Player.Name) .. _TBt27(">lR.ff\019FLLr\023lNr.Ll{A@@ql\001F\029\029r@lR)r@.?Fl.\023l\n)r.\023\020rf:r\023M"),
      Media = _0BDe4
    }
  }, function(action)
    Wherigo.PlayAudio(_RQ0)
    _fmz()
  end)
end
function _cEcz:OnEnd()
  _TVx:Stop()
  _cEcz:RequestSync()
end
function _cEcz:OnRestore()
  _TVx:Start()
end
function _cEcz:OnSync()
end
function _qMGT:OnEnter()
  _v_b = _TBt27("7[`\026\024")
  if _vXJNe == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023l.Ll+.?\022w\029r@;r?M"),
      Media = _Lm3H
    })
    _AHB.Complete = true
    _AHB.Active = false
    _ZrT7z.Active = true
    _vXJNe = false
  end
end
function _1t7:OnEnter()
  _v_b = _TBt27("73\029\\")
  if _a3X == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023l.Ll\024@FD\020r\023:r\023l5rwwrfM"),
      Media = _NGTgz
    })
    _UP4.Active = false
    _UP4.Complete = true
    _7mHt.Active = true
    _a3X = false
  end
end
function _LUd:OnEnter()
  _v_b = _TBt27("7+d:")
  if _yXgfz == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lA\022\020l\026fr.wl!l^X\006>l\aF\023l).r@lA\022wl\020\195\164)@\029l:r@l{F?;A@\029wr_D@rwwlAN>"),
      Media = _tK_pr
    })
    _yXgfz = false
  end
end
function _gGZ:OnEnter()
  _v_b = _TBt27("7?\026&")
  if _0EIf == true then
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("{Af\029Ml&\022\029@.\029\029l\023\022@l\020\195\188@lr1)\029rl&A\022Nr@r@l\022\023:lr1)\029rl{r_r\023Ml\026.Nl:.1)lAfwl&A\022Nr@r@lF:r@l{r_rlI\022lr@\019r\023\023r\023M"),
        Media = _PnYc
      }
    }, function(action)
      _tSi.Active = false
      _tSi.Complete = true
      _Ufxv.Active = true
      _3C2.Commands._oYyps.Enabled = true
      _anI.Commands._5CW.Enabled = true
      _0EIf = false
    end)
  end
end
function _gGZ:OnProximity()
  _v_b = _TBt27("7?\026&")
  if _64l == true then
    _Urwigo.OldDialog({
      {
        Text = _TBt27("{rql{A@@qolw1)\195\182\023l:Awwl:\022Hwl).r@)r@l?rw1)A\020\020\029l)Aw\029>l5FLLl;.@l?r)r\023lI\022Llg1)fFww>"),
        Media = _BdA
      }
    })
    _Wiu:MoveTo(Player)
    _gGZ.Visible = true
    _64l = false
  end
end
function _9rbkZ:OnEnter()
  _v_b = _TBt27("7!@N\019&")
  if _Ot0k == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lA\022\020l:r@lZ\023wrfM"),
      Media = _Zjn
    })
    _zmvsK.Complete = true
    _zmvsK.Active = false
    _R2QK.Active = true
    _Ot0k = false
  end
end
function _Jdr:OnEnter()
  _v_b = _TBt27("7b:@")
  if _6ck == true then
    Wherigo.PlayAudio(_VArS)
    _Urwigo.MessageBox({
      Text = _TBt27("`.w\029r@l{A@@ql\001F\029\029r@l;\195\188\023w1)\029lr\029;AwlANI\022)rNr\023>"),
      Media = _DkN8a
    })
    _6ck = false
  end
  _Qdmgs.Commands._26EaE.Enabled = true
end
function _Jdr:OnExit()
  _v_b = _TBt27("7b:@")
  _Qdmgs.Commands._26EaE.Enabled = false
end
function _Ahs:OnEnter()
  _v_b = _TBt27("7T)w")
  if _QBdY == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lNr.l\016ff.UA\023:r@Ml{.r@l?.N\029lrwl&A\022Nr@w\029\195\164NrlI\022l\019A\022\020r\023>]t\nk&;r.?rl\023A1)lf.\023\019wlANlE.\023l:.rlt@F:fA\022Nr\002l\022\023:lw\0221)rl:r\023l&A\022Nr@w\029ANl.\023lr.\023rLl:r@lg1)A\022\020r\023w\029r@>"),
      Media = _gJv
    })
    _Ahs.Visible = true
    _QBdY = false
  end
end
function _NfIX:OnEnter()
  _v_b = _TBt27("7}\020ZK")
  if _9qe == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lNr.l\018fF\022@.w)lA\023:ltfF\029\029wMl{.r@l\019A\023\023w\029l:\022lt\195\1881)r@l\019A\022\020r\023>"),
      Media = _2byTd
    })
    _NfIX.Visible = true
    _9qe = false
  end
end
function _tnVG5:OnEnter()
  _v_b = _TBt27("7\029\023\a\026y")
  if _wv0Ih == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lNr.l`A:ALl`Af\019.\023wMl{.r@l?.N\029lrwl5fr.:r@l\020\195\188@l\030\022\023?rl&A\022Nr@r@l\022\023:l{r_r\023>"),
      Media = __ny6r
    })
    _tnVG5.Visible = true
    _wv0Ih = false
  end
end
function _HeL1v:OnEnter()
  _v_b = _TBt27("7{r+3U")
  if _QIsU_ == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023l.\023l\001F\029A?rwl5rwwrffA:r\023Ml{.r@l\019A\023\023w\029l:\022l5rwwrfl.\023lAffr\023lgF@\029r\023l\022\023:l\026@\195\182wwr\023l\019A\022\020r\023>"),
      Media = _YKB
    })
    _QIsU_ = false
  end
end
function _4BVI:OnEnter()
  _v_b = _TBt27("7\006t\aZ")
  if _C7t2l == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lNr.lg1@.NN\022f\022wlg1)@r.N;A@r\023M"),
      Media = _fc8
    })
    _4BVI.Visible = true
    _C7t2l = false
  end
end
function _hQEW:OnEnter()
  _v_b = _TBt27("7)B|R")
  if _53Ql == true then
    _Urwigo.MessageBox({
      Text = _TBt27("R.ff\019FLLr\023lNr.l:r@lDr.\029w1)r\023:r\023lRr.:r>l5FLLl.)@lNrwwr@l\023.1)\029lI\022l\023A)rM"),
      Media = _H9PyJ
    })
    _epfQo.Active = false
    _epfQo.Complete = true
    _OHO.Active = true
    _53Ql = false
  end
end
function _IBcW:OnEnter()
  _v_b = _TBt27("7Zt1R")
  if _5WlDw == true then
    Wherigo.PlayAudio(_Krt8R)
    _XcsJS.Active = false
    _XcsJS.Complete = true
    _Aam.Active = true
    _nMqCp.Commands._q61s.Enabled = true
    _5WlDw = false
    _Urwigo.OldDialog({
      {
        Text = _TBt27("R.@l)ANr\023lrwl?rw1)A\020\020\029Mlh.rl5.w\029rl\020.\023:rw\029l:\022l).r@lA\023l:r@l{\195\188\029\029r\023;A\023:>lg.rl.w\029l?@Fwwl?r\023\022?ol:\022l\019A\023\023w\029lw.rl\023.1)\029l\195\188Nr@wr)r\023>ldLlw.rl\195\182\020\020\023r\023lI\022l\019\195\182\023\023r\023lL\022ww\029l:\022l\023F1)l:r\023l+F?lw1)@r.Nr\023ol\018r:r@l\022\023:l\001AD.r@l)Aw\029l:\022l\030Al:ANr.>"),
        Media = _0BDe4
      }
    })
  end
end
function _Tog0:OnEnter()
  _v_b = _TBt27("7\024F?C")
  if _k5p == true then
    _Urwigo.MessageBox({
      Text = _TBt27("{AffFol.1)lN.\023l`@wlRrAwfrqol\019A\023\023l.1)l:.@l)rf\020r\023\004"),
      Media = __3SHa
    })
    __8WBE.Complete = true
    __8WBE.Active = false
    _SSYom.Active = true
    _k5p = false
  end
end
function _uXFP:OnEnter()
  _v_b = _TBt27("7\022K\018\001")
  _Y1E3.Commands._A6_.Enabled = true
  _Urwigo.MessageBox({
    Text = _TBt27("hrUrfFDr@l`F:rlA1\029.UA\029r:")
  })
end
function _AHB:OnSetComplete()
  _cEcz:RequestSync()
end
function _f18uQ:OnSetComplete()
  _cEcz:RequestSync()
end
function _UP4:OnSetComplete()
  _cEcz:RequestSync()
end
function _ZrT7z:OnSetComplete()
  _cEcz:RequestSync()
end
function _zmvsK:OnSetComplete()
  _cEcz:RequestSync()
end
function _R2QK:OnSetComplete()
  _cEcz:RequestSync()
end
function _7mHt:OnSetComplete()
  _cEcz:RequestSync()
end
function _EhFk:OnSetComplete()
  _cEcz:RequestSync()
end
function _nYcC:OnSetComplete()
  _cEcz:RequestSync()
end
function __8WBE:OnSetComplete()
  _cEcz:RequestSync()
end
function _SSYom:OnSetComplete()
  _cEcz:RequestSync()
end
function _tSi:OnSetComplete()
  _cEcz:RequestSync()
end
function _Pf4:OnSetComplete()
  _cEcz:RequestSync()
end
function _DvLoX:OnSetComplete()
  _cEcz:RequestSync()
end
function _Boyl:OnSetComplete()
  _cEcz:RequestSync()
end
function _t2Lz:OnSetComplete()
  _cEcz:RequestSync()
end
function _epfQo:OnSetComplete()
  _cEcz:RequestSync()
end
function _Ufxv:OnSetComplete()
  _cEcz:RequestSync()
end
function _XcsJS:OnSetComplete()
  _cEcz:RequestSync()
end
function _OHO:OnSetComplete()
  _cEcz:RequestSync()
end
function _HO4r:OnSetComplete()
  _cEcz:RequestSync()
end
function _tMZ5:OnSetComplete()
  _cEcz:RequestSync()
end
function _Tty:OnSetComplete()
  _cEcz:RequestSync()
end
function _Aam:OnSetComplete()
  _cEcz:RequestSync()
end
function _S_t:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 38416 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?M"),
      Callback = function(action)
        if action ~= nil then
          _g5NNA.Visible = false
          _ZrT7z.Complete = true
          _ZrT7z.Active = false
          _f18uQ.Active = true
          _04s.Visible = true
          _Urwigo.MessageBox({
            Text = _TBt27("\ar@\023F\023l\023.LL\029l{A@@ql:r\023lt@.r\020l;r?olNrUF@lr@l.)\023lfrwr\023l\019A\023\023>")
          })
        end
      end
    })
  else
    if _a7Q >= 2 then
      _Urwigo.MessageBox({
        Text = _TBt27("h\022lw1)r.\023w\029lg1);.r@.?\019r.\029r\023lL.\029l:r@l|.\023?ANrlI\022l)ANr\023>l|wl\019A\023\023lwr.\023l:Awwl:.rlg\029A\029.F\023l).r@lUr@fF@r\023l?.\023?>lh\022l\019A\023\023w\029l).r@lAf\029r@\023A\029.Ulr.\023r\023lB\nG0F:rl\020.\023:r\023>l|@lNr\020.\023:r\029lw.1)lA\022\020l:r@l\n\195\1881\019wr.\029rl:rwl|fr\019\029@F\019Aw\029r\023w>"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_S_t)
            end)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _TBt27("+r.:r@l\020Afw1)M")
      })
      _a7Q = _a7Q + 1
    end
    _T5N = _T5N + 1
  end
end
function __cf:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 11129 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?M]t\nkTffrl&A\022Nr@r@l;r@:r\023l.\023l.)@rLlrf\020\029r\023l+rNr\023w\030A)@l\023A1)l{F?;A@\029wol:r@lg1)\022frl\020\195\188@l{r_r@r.l\022\023:l&A\022Nr@r.olr.\023?rfA:r\023>l+.rwl\023\022\023l:r.\023r\023lt@.r\020>"),
      Media = _BdA
    })
    _Wiu.Visible = false
    _R2QK.Complete = true
    _R2QK.Active = false
    _HO4r.Active = true
    _7mUH:MoveTo(Player)
    _Wiu.Commands._RIQIZ.Enabled = false
  else
    if _9o5S >= 2 then
      _Urwigo.MessageBox({
        Text = _TBt27("h\022lw1)r.\023w\029lg1);.r@.?\019r.\029r\023lL.\029l:r@l|.\023?ANrlI\022l)ANr\023>l|wl\019A\023\023lwr.\023l:Awwl:.rlg\029A\029.F\023l).r@lUr@fF@r\023l?.\023?>lh\022l\019A\023\023w\029l).r@lAf\029r@\023A\029.Ulr.\023r\023lB\nG0F:rl\020.\023:r\023>l|@lNr\020.\023:r\029lw.1)lA\023l:r@ld\023\029r@wr.\029rl:rwlt@.r\020\019Aw\029r\023w>"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(__cf)
            end)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _TBt27("+r.:r@l\020Afw1)Ml|wlw.\023:l?r\023A\022l:@r.lR\195\182@\029r@ol:.rl:\022lr.\023?rNr\023lL\022ww\029>"),
        Media = _BdA
      })
      _9o5S = _9o5S + 1
    end
    _T5N = _T5N + 1
  end
end
function _tK0Yx:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 53 then
    _0MG3 = true
  else
    _0MG3 = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Y2LX)
  end)
end
function _Y2LX:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 50 then
    _ZPmg = true
  else
    _ZPmg = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_8y7)
  end)
end
function _8y7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49 then
    _Sjme = true
  else
    _Sjme = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_u7BF)
  end)
end
function _u7BF:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 51 then
    _zHLnz = true
  else
    _zHLnz = false
  end
  if _0MG3 and _ZPmg and _Sjme and _zHLnz then
    Wherigo.PlayAudio(_nbIVv)
    _7mHt.Active = false
    _7mHt.Complete = true
    _EhFk.Active = true
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("\n.1)\029.?Mlh.rl`A\022r@l\195\182\020\020\023r\029lw.1)l\022\023:l:\022lNr\029@.\029\029w\029l:.rlR.\023\019rf?Awwr>"),
        Media = _bRH
      },
      {
        Text = _TBt27("TNr@l{A?@.:ol.1)l)ANl?A@l\019r.\023l\026rf:M"),
        Media = _RfPd
      },
      {
        Text = _TBt27("`A1)l:.@l:A@\195\188Nr@l\019r.\023rl\026r:A\023\019r\023>lR.@lLA1)r\023lI\022r@w\029lNr.l\026@.\023?F\029\029wl{Af\029>l&A\022Nr@r@NA\023\019>lR.@:lUF\023l5FNFf:r\023l?r\020\195\188)@\029>l}Al:A\023\023lfFw\226\128\166"),
        Media = _BdA
      },
      {
        Text = _TBt27("RF)r@l)ANrl.1)l:r\023\023l:Awl\026rf:\004"),
        Media = _RfPd
      },
      {
        Text = _TBt27("hr.\023rl|f\029r@\023l)ANr\023l:.@lr.\023rlNr\029@\195\1641)\029f.1)rlg\022LLrl).\023\029r@fAwwr\023>lR\022ww\029rw\029l:\022l:AwlA\0221)l\023.1)\029\004"),
        Media = _BdA
      }
    }, function(action)
      _dSeA()
    end)
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Mlg1)A\022l:.@l:AwlRA\023:N.f:l).r@l?r\023A\022lA\023>"),
      Media = _CgrEl
    })
    _T5N = _T5N + 1
  end
end
function _i_OM:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _R9e = true
  else
    _R9e = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_O3Hh)
  end)
end
function _O3Hh:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 99 then
    _c1Qm = true
  else
    _c1Qm = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_pcN)
  end)
end
function _pcN:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 99 then
    _Nqn = true
  else
    _Nqn = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_aZN)
  end)
end
function _aZN:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 98 then
    _gVgPJ = true
  else
    _gVgPJ = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_7e7)
  end)
end
function _7e7:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 97 then
    _EZYXZ = true
  else
    _EZYXZ = false
  end
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_aMJnV)
  end)
end
function _aMJnV:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 99 then
    _FoyzV = true
  else
    _FoyzV = false
  end
  if _R9e and _c1Qm and _Nqn and _gVgPJ and _EZYXZ and _FoyzV then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?Mlh\022l\019A\023\023w\029l:.rlt\195\1881)r@l\023\022\023l\019A\022\020r\023>"),
      Media = _hRY
    })
    _UO_t.Commands._38P0.Enabled = true
    _UO_t.Commands.__Kx.Enabled = false
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Ml{.f\020rlNr\020.\023:r\029lw.1)l.\023lr.\023rLl\018r\023w\029r@l:r@lt.Nf.F\029)r\019l).r@l.\023l:r@l\001AwwA?r>")
    })
    _T5N = _T5N + 1
  end
end
function _pckJH:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 22 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?Mlh\022l\019A\023\023w\029l:r\023l&A\022Nr@w\029ANl\023\022\023l\019A\022\020r\023>"),
      Callback = function(action)
        if action ~= nil then
          _3C2.Commands._o2x.Enabled = true
          _3C2.Commands._3EUA.Enabled = false
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)>l5r\023\023w\029l:\022l:r\023ldL@r1)\023\022\023?w\019\022@wl\020\195\188@l\026AffrF\023r\023\004"),
      Media = _5I9A
    })
    _T5N = _T5N + 1
  end
end
function _Zt7wl:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 51430 or _Urwigo.Hash(string.lower(input)) == 48578 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?ol:A\020\195\188@l\019@.r?w\029l:\022lr.\023r\023l\nANA\029\029lA\022\020l:r.\023r\023l|.\023\019A\022\020M"),
      Callback = function(action)
        if action ~= nil then
          _nMqCp.Visible = true
          _kCQ_h = 2
          _yk3i.Media = _zJP
          _yk3i.Icon = _zJP
          _yk3i:MoveTo(_tnVG5)
        end
      end
    })
  else
    if _Kjh == false then
      _Urwigo.MessageBox({
        Text = _TBt27("g\029.LL\029lfr.:r@l\023.1)\029>lhr@l}ALrl:rwl{A\022wrwlNrw\029r)\029lA\022wlI;r.lR\195\182@\029r@\023ol;FNr.l:Awlr@w\029rl$&\022L$lfA\022\029r\029>")
      })
      _Kjh = true
    else
      _Urwigo.MessageBox({
        Text = _TBt27("g\029.LL\029lfr.:r@l\023.1)\029>lhr@l}ALrl:rwl{A\022wrwlNrw\029r)\029lA\022wlI;r.lR\195\182@\029r@\023ol;FNr.l:Awlr@w\029rl$&\022L$lfA\022\029r\029>]t\nkhAwlI;r.\029rlRF@\029l)A\029lr\029;AwlL.\029lh\022LNfr:F@rwlgr)).f\020rlI\022l\029\022\023>>>")
      })
    end
    _T5N = _T5N + 1
  end
end
function _QrUsI:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 5 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?Ml5FLLl).\023r.\023M")
    })
    _anI.Visible = true
    _j7wSq.Visible = true
    _ppHB.Visible = true
    _Uh6aL.Visible = true
    _32KS.Visible = true
    _kCQ_h = 3
    _yk3i.Media = _5BH
    _yk3i.Icon = _5BH
    _yk3i:MoveTo(_HeL1v)
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Ml{Aw\029l:\022l;.@\019f.1)lAffrl?rI\195\164)f\029\004")
    })
    _T5N = _T5N + 1
  end
end
function _uv7:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 2 then
    _Urwigo.MessageBox({
      Text = _TBt27("\n.1)\029.?Ml5FLLl)r@r.\023M")
    })
    _2W_Pn.Visible = true
    _59lH.Visible = true
    _kCQ_h = 4
    _yk3i:MoveTo(nil)
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Mlg1)A\022l:.@l:Awlg1).f:lALl|.\023?A\023?l\023F1)LAfwlA\023>")
    })
    _T5N = _T5N + 1
  end
end
function _SOFBC:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 11912 then
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("TNr@l{A@@qol:\022l:A@\020w\029lA\022wwr@)AfNlUF\023l{F?;A@\029wl\023F1)l\023.1)\029lIA\022Nr@\023MlRA@\029rol.1)lLA1)rl:Awl\020\195\188@l:.1)>l+F1FLF\029F@M"),
        Media = __3SHa
      },
      {
        Text = _TBt27("hr@l{F?;A@\029wr_D@rwwl@Fff\029lfA\023?wALlfFwl\022\023:lUr@f\195\164ww\029l:r\023ltA)\023)F\020>"),
        Media = _tK_pr
      },
      {
        Text = _TBt27("dDDwol:\022l)\195\164\029\029rw\029lUF@)r@lr.\023w\029r.?r\023lwFffr\023>lbr\029I\029lL\022ww\029l:\022l)Af\029lI\022l\018\022wwl?r)r\023>lhAwlwFff\029rlANr@l\023.1)\029lAffI\022lw1);r@lwr.\023>l\018Ff?rlr.\023\020A1)l:r\023l\026fr.wr\023l)F1)lN.wlI\022Llg1)fFwwl.Ll\018rf:>ltr\029@.\029\029lN.\029\029rl\023.1)\029l:.rl\026fr.wrM"),
        Media = __3SHa
      }
    }, function(action)
      _Tty.Complete = true
      _Tty.Active = false
      _tSi.Active = true
      _gGZ.Active = true
      _Qv5q:MoveTo(nil)
    end)
  else
    if _sJ6X >= 2 then
      _Urwigo.MessageBox({
        Text = _TBt27("h\022lw1)r.\023w\029lg1);.r@.?\019r.\029r\023lL.\029l:r@l|.\023?ANrlI\022l)ANr\023>l|wl\019A\023\023lwr.\023l:Awwl:.rlg\029A\029.F\023l).r@lUr@fF@r\023l?.\023?>lh\022l\019A\023\023w\029l).r@lAf\029r@\023A\029.Ulr.\023r\023lB\nG0F:rl\020.\023:r\023>l|@lNr\020.\023:r\029lw.1)l.\023l:r@l\195\182w\029f.1)r\023l|1\019rl:rwl\026rN\195\164\022:rwlA\023lr.\023r@l\nr?r\023@.\023\023r>"),
        Callback = function(action)
          if action ~= nil then
            _Urwigo.RunDialogs(function()
              Wherigo.GetInput(_SOFBC)
            end)
          end
        end
      })
    else
      _Urwigo.MessageBox({
        Text = _TBt27("+r.:r@l\020Afw1)Mlg\0221)rl:F@\029l;Fl:r@lLqw\029r@.\195\182wrl&A\022Nr@r@l).\023Ir.?\029>l}.1)\029lAffrwl.w\029l\020rw\029l;Awl\020rw\029lw1)r.\023\029>")
      })
      _sJ6X = _sJ6X + 1
    end
    _T5N = _T5N + 1
  end
end
function __bdz:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 1875 then
    _X59 = true
    _wiKC.Commands._tMu.Enabled = false
    _Urwigo.MessageBox({
      Text = _TBt27("TNwFf\022\029l\019F@@r\019\029Ml}\022\023lL\195\188wwr\023lg.rl\023\022@l\023F1)lr.\023rlT\022\020?ANrl\020\195\188@lL.1)lr@\020\195\188ffr\023>l5FLLr\023lg.rlI\022lL.@l;r\023\023lg.rlNr@r.\029lw.\023:>"),
      Media = _n6d
    })
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Mltr.l:r@lt@A\022D\020A\023\023rlw\029r)r\023lI;r.lbA)@rwIA)fr\023>l\026.Nl:.rl?@\195\182wwr@rl:r@lNr.:r\023lr.\023>")
    })
    _T5N = _T5N + 1
  end
end
function _erfiQ:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 315 then
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("g\029.LL\029l?r\023A\022MlZ1)l)ANrlrwl\023A\029\195\188@f.1)l\023.1)\029lUr@?rwwr\023olwF\023:r@\023l;Fff\029rl\023\022@l:r.\023lR.wwr\023l\195\188Nr@l{F?;A@\029wl\029rw\029r\023>lZ1)l:r\023\019rl;.@l;r@:r\023l?\022\029rl\018@r\022\023:rl;r@:r\023>lh\022l\019A\023\023w\029l\023\022\023l:r\023l\026r)r.L?A\023?lI\022@l{r\022fr\023:r\023l{\195\188\029\029rl\023r)Lr\023>"),
        Media = _4Fgw
      },
      {
        Text = _TBt27("|wl?.N\029lI;r.lRr?r>l|\023\029;r:r@l:\022l\020Ff?w\029l:r@lg\029@Awwrlf.\023\019wlF:r@l:rLlRA\023:r@;r?l@r1)\029w>ltr.:rlRr?rl\020\195\188)@r\023lI\022@l{\195\188\029\029r>"),
        Media = _YWA_
      }
    }, function(action)
      _OHO.Active = false
      _OHO.Complete = true
      _XcsJS.Active = true
      _IBcW.Active = true
      _IBcW.Visible = true
      _UvDuh.Visible = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)Mlh\022l\020.\023:rw\029l:.rl\019F@@r\019\029rl&A)fl).r@l.\023l:r@l}\195\164)r>"),
      Media = _4Fgw
    })
    _T5N = _T5N + 1
  end
end
function _6oR4:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 49731 and _lhG == false then
    _K3zjX = true
  elseif _Urwigo.Hash(string.lower(input)) == 41337 and _lhG == true and _z6OXu == false then
    _9hkU = true
  elseif _Urwigo.Hash(string.lower(input)) == 17306 and _z6OXu == true and _XuB == false then
    _kpUIL = true
  elseif _Urwigo.Hash(string.lower(input)) == 52666 and _XuB == true and _yFfJ0 == false then
    _yFfJ0 = true
  else
    _2AN = false
  end
  _Urwigo.MessageBox({
    Text = (_TBt27("h\022l?.Nw\029l") .. input) .. _TBt27("l.\023l:r\023l5rwwrf>")
  })
end
function _OLzUj:OnTick()
  _OLzUj:Stop()
  _Qdmgs.Commands._26EaE.Enabled = true
  _OLzUj.Remaining = 180
end
function _TVx:OnTick()
  _TY_K = _TY_K + 1
end
function _Wiu:On_g0n(target)
  _Urwigo.Dialog(false, {
    {
      Text = _TBt27("Rr@lN.w\029l:\022\004"),
      Media = _RfPd
    },
    {
      Text = _TBt27("Z1)lN.\023l\n\022Nr\022wl{A?@.:olR.f:)\195\188\029r@lUF\023l{F?;A@\029w>l}r\023\023lL.1)l{A?@.:>l\195\156Nr@l{F?;A@\029wl;r.ww\029l:\022l\023A\029\195\188@f.1)lAffrw>"),
      Media = _BdA
    },
    {
      Text = _TBt27("|r)L>>>l}r.\023>>>"),
      Media = _RfPd
    },
    {
      Text = _TBt27("RAw\004l{Aw\029l:\022l:.1)l\023.rl?r\020@A?\029l;Fl:r.\023rl|f\029r@\023l:AwlAffrwl?rfr@\023\029l)ANr\023\004"),
      Media = _BdA
    },
    {
      Text = _TBt27("Tffrwl;Aw\004"),
      Media = _RfPd
    }
  }, function(action)
    Wherigo.PlayAudio(_a0U)
    _Urwigo.MessageBox({
      Text = _TBt27("h\022lN.w\029lr.\023l&A\022Nr@r@l{A@@qM]t\nkT1)lNrUF@l.1)wlUr@?rwwrol.1)l)ANl:.@lr.\023rl\026rN\022@\029w\029A?w\029F@\029rlL.\029?rN@A1)\029olANr@l.1)l)ANlw.rl;F)fl.@?r\023:;Fl).r@lUr@fr?\029>l5A\023\023w\029l:\022lw.rlw\0221)r\023\004"),
      Media = _BdA
    })
  end)
  _Wiu.Commands._RIQIZ.Enabled = true
  _Wiu.Commands._g0n.Enabled = false
end
function _Wiu:On_RIQIZ(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(__cf)
  end)
end
function _04s:On_0PuDh(target)
  _Urwigo.Dialog(false, {
    {
      Text = _TBt27("{A@@qol;.@lfAwwr\023l\023.1)\029lI\022ol:Awwl:\022lA\023l:.rwrlg1)\022frl?r)w\029>l5FLLol;.@lUr@w1);.\023:r\023lUF\023l).r@>"),
      Media = _uLOgI
    }
  }, function(action)
    Wherigo.PlayAudio(_Gsqp)
    _Urwigo.MessageBox({
      Text = _TBt27("R.@l\020A)@r\023l;r?ol;r.\029l;r?l;Fl:.rl\022\023wl\023.1)\029l\020.\023:r\023M"),
      Media = _uLOgI,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.MessageBox({
            Text = _TBt27("\ar@\023F\023l\020f.r)\029lL.\029lwr.\023r@l\018AL.f.rl\022\023:l{A@@qlA\022\020lr.\023rlAN?rfr?r\023rlZ\023wrf>l\018Ff?rl.)\023r\023l:F@\029l).\023>"),
            Media = _Zjn
          })
        end
      end
    })
  end)
  _f18uQ.Active = false
  _f18uQ.Complete = true
  _zmvsK.Active = true
  _04s.Visible = false
  _9rbkZ.Visible = true
  _9rbkZ.Active = true
end
function _Y1E3:On_hg7fu(target)
  _cEcz:RequestSync()
  _Urwigo.MessageBox({
    Text = _TBt27("gD.rfl?rwDr.1)r@\029M")
  })
end
function _Y1E3:On_0vmPw(target)
  _fmz()
end
function _Y1E3:On_FwoW(target)
  _Urwigo.MessageBox({
    Text = _TBt27("hr@l0F:rl\020\195\188@l:.rl\024@\022)rlfA\022\029r\029ly!\\\b>"),
    Callback = function(action)
      if action ~= nil then
        _Urwigo.MessageBox({
          Text = (((((((((_TBt27("hr.\023l0F:rlI\022LlfF??r\023lA\022\020lR)r@.?F>1FLlfA\022\029r\029a]t\nk") .. string.sub(Player.CompletionCode, 1, 15)) .. _TBt27("]t\nkh\022l)Aw\029l")) .. _TY_K) .. _TBt27("lg\029\022\023:r\023ol")) .. _aYG0) .. _TBt27("l`.\023\022\029r\023l\022\023:l")) .. _shTi) .. _TBt27("lgr\019\022\023:r\023l?rN@A\0221)\029ol\022LlI\022@l)r\022fr\023:r\023l{\195\188\029\029rlI\022l?rfA\023?r\023>]t\nkh\022lL\022ww\029rw\029l\022\023\029r@;r?wl33l\n\195\164\029wrflf\195\182wr\023l\022\023:l)Aw\029l:ANr.l")) .. _T5N) .. _TBt27("GLAflr.\023r\023l\018r)fr@l?rLA1)\029>]t\nk\a.rfr\023lhA\023\019l\020\195\188@wlgD.rfr\023M"),
          Callback = function(action)
            if action ~= nil then
              _z3JuH()
            end
          end
        })
      end
    end
  })
end
function _Y1E3:On_A6_(target)
  _2W_Pn:MoveTo(Player)
  _2W_Pn.Visible = true
  _gGZ.Active = true
  _gGZ.Visible = true
  _wiKC.Visible = true
  _X59 = true
end
function _bZH_:On_ta7Fq(target)
  if _GfnR == true then
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("R.rl\019FLLrl.1)lI\022Ll\026fr.wl!l^X\006\004"),
        Media = _RfPd
      }
    }, function(action)
      Wherigo.PlayAudio(_5It4e)
      _Urwigo.OldDialog({
        {
          Text = _TBt27("T1)wFol;.rl:\022lI\022Ll\026fr.wl\019FLLw\029>l|\023?rf1)r\023l\023\022@l\019r.\023rlgF@?rol\nF\023l\020\195\164)@\029lA\0221)lI\022Llr@w\029r\023l`Afl\023A1)l{F?;A@\029w>lh\022lL\022ww\029l\023\022@l\020Ff?r\023:rwl\029\022\023alh\022lf\195\164\022\020w\029l?r@A:r;r?wlA\022\020l:.rlRA\023:lI\022lI;.w1)r\023l\026fr.wl\023r\022\023l\022\023:lIr)\023>l\nr\023\023lf.rNr@lr.\023lN.ww1)r\023l;r\023\023l:\022l\023r@U\195\182wlN.w\029>"),
          Media = __3SHa
        },
        {
          Text = _TBt27("}.LLl\023.1)\029l:r\023l:.@r\019\029r\023lRr?lwF\023:r@\023lNr\023\022\029Irl:.rld\023\029r@\020\195\188)@\022\023?M"),
          Media = __3SHa
        }
      })
    end)
    _SSYom.Complete = true
    _SSYom.Active = false
    _tMZ5.Active = true
    _LUd.Active = true
    _LUd.Visible = true
    _GfnR = false
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+FwolANlL.\029l:.@M"),
      Media = __3SHa
    })
  end
end
function _wiKC:On_DEG_H(target)
  if _X59 == true then
    _Urwigo.MessageBox({
      Text = _TBt27("g.rlL\195\188wwr\023lr.\023rlT\022\020\023A)LrD@\195\188\020\022\023?lNrw\029r)r\023l\022Ll.\023l{F?;A@\029wlI\022@lg1)\022frlI\022l?r)r\023>lt@A\022r\023lg.rlL.@l:F1)lN.\029\029rlr.\023lt\022\029\029r@N.r@>l{.r@lw.\023:lr.\023.?rl&\022\029A\029r\023>lRr\023\023lg.rl.\023l:r@lR.\023\019rf?AwwrlAffrwlr.\023?r\019A\022\020\029l)ANr\023ol;AwlA\022\020l:r@l+.w\029rlw\029A\023:olwFff\029rl:.rwrlT\022\020?ANrl\019r.\023l\001@FNfrLl\020\195\188@lg.rl:A@w\029rffr\023>l\a.rfl|@\020Ff?M")
    })
    _2W_Pn.Commands._xyex.Enabled = true
    _2W_Pn.Commands._TmHa.Enabled = true
    _2W_Pn.Commands._crijv.Enabled = true
    _2W_Pn.Commands._NsAxS.Enabled = true
    _2W_Pn.Commands._c0T7.Enabled = true
    _UO_t.Commands._3gbF8.Enabled = true
    _Pf4.Complete = true
    _Pf4.Active = false
    _DvLoX.Active = true
    _X59 = false
  elseif _q4285 == true then
    _Urwigo.Dialog(false, {
      {
        Text = _TBt27("\026\022\029r\023l\024A?l`.w\029r@l\001F\029\029r@>lgr)r\023lg.rl:.rlr\023?rl\026Awwrl.\023l\n.1)\029\022\023?l:rwlg1)fFww\029\022@Lw\004"),
        Media = _n6d
      },
      {
        Text = _TBt27("\026r)rlI\022Ll\024F@l\022\023:l)Af\029rlT\022ww1)A\022l\023A1)l:r@l?@Fwwr\023lt@A\022D\020A\023\023rl.\023l:r@l\018AwwA:rlALl|\023:rl:r@l\026Awwr>l\a.rffr.1)\029lL\022ww\029l:\022l).r@l:r.\023rlgr)\019@A\020\029lL.\029lr.\023rLl{.f\020wL.\029\029rfl\022\023\029r@w\029\195\188\029Ir\023>lg\0221)rl:AwlbA)@ol.\023l:rLl\001@F\020rwwF@l\nF\023.?r@olr.\023r@l\022\023wr@r@l+r)@r@l\020\195\188@l&A\022Nr@\029@\195\164\023\019rolwr.\023r\023lfr\029I\029r\023l&A\022Nr@\029@A\023\019l?rN@A\022\029l)A\029>"),
        Media = _847
      }
    }, function(action)
      _wiKC.Commands._tMu.Enabled = true
      _q4285 = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _TBt27("T\023l:.rlT@Nr.\029l`.w\029r@l\001F\029\029r@>lg.rl)ANr\023lAffrwl;Awlg.rlNr\023\195\182\029.?r\023>")
    })
  end
end
function _wiKC:On_tMu(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(__bdz)
  end)
end
function _g5NNA:On_3ifr(target)
  _Urwigo.MessageBox({
    Text = _TBt27("Z1)lN.\023lr.\023rl\001Fw\029r\022frl\022\023:lwFffl{A@@ql\001F\029\029r@lr.\023rl}A1)@.1)\029lUF\023l{F?;A@\029wol:r@lg1)\022frl\020\195\188@l&A\022Nr@r@l\022\023:l{r_r\023olN@.\023?r\023>lg\0221)rlL.1)l).r@l.\023l:r@l&F\023rl\022\023:lUr@@A\029rlL.@l:Awl\001Aww;F@\029ol:Awl:\022lNr.lL.@l.LltA\0221)l\020.\023:rw\029>lh\022lL\022ww\029l\019r.\023rlD@.UA\029r\023l\026@\022\023:w\029\195\1881\019rlNr\029@r\029r\023M"),
    Media = _PRI
  })
  _g5NNA.Commands._fBx0.Enabled = true
end
function _g5NNA:On_fBx0(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_S_t)
  end)
end
function _Sy40:On_XXbT(target)
  _Urwigo.MessageBox({
    Text = _TBt27("|wlw1)r.\023\029lAfwlL\195\188ww\029rw\029l:\022l:.rltA1\019w\029r.\023rl.\023l:r@l@.1)\029.?r\023l\nr.)r\023\020Ff?rl:@\195\1881\019r\023>"),
    Media = _epB4W
  })
  _Sy40.Commands._zah6G.Enabled = true
end
function _Sy40:On_zah6G(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_tK0Yx)
  end)
end
function _Qdmgs:On_26EaE(target)
  if _DOr == true then
    _Urwigo.MessageBox({
      Text = _TBt27("\026\022\029r\023l\024A?olg.rl)ANr\023lr.\023r\023lg1)f\195\188wwrfolg.@\004"),
      Media = _AMk,
      Buttons = {
        _TBt27("bA"),
        _TBt27("}r.\023")
      },
      Callback = function(action)
        if action ~= nil then
          if action == "Button1" then
            _Qdmgs.Commands._26EaE.Enabled = false
            _Urwigo.MessageBox({
              Text = _TBt27("\001@.LAol).r@lw.\023:l3CCl\026AffrF\023r\023>l|.\023r\023lw1)\195\182\023r\023l\024A?l\023F1)>"),
              Media = _AMk,
              Callback = function(action)
                if action ~= nil then
                  _gqD()
                end
              end
            })
          else
            _Qdmgs.Commands._26EaE.Enabled = false
            _Urwigo.Dialog(false, {
              {
                Text = _TBt27("\024\022\029lL.@l+r.:olF)\023rlg1)f\195\188wwrfl\019A\023\023l.1)lfr.:r@l\023.1)\029wl\020\195\188@lg.rl\029\022\023>lg.\023:lg.rlw.1)r@ol:Awwlg.rl.)\023l\023.1)\029l:ANr.l)ANr\023\004"),
                Media = _AMk
              },
              {
                Text = _TBt27("{ANl.)\023ol:r\023lg1)f\195\188wwrfM"),
                Media = _BdA
              },
              {
                Text = _TBt27("hAwlw1)r.\023\029l.\023l\016@:\023\022\023?lI\022lwr.\023>l{.r@lw.\023:l3CCl\026AffrF\023r\023>l|.\023r\023lw1)\195\182\023r\023l\024A?l\023F1)>"),
                Media = _AMk
              }
            }, function(action)
              _gqD()
            end)
          end
          _OLzUj:Start()
          _DOr = false
          _K53_:MoveTo(Player)
          _K53_.Visible = true
          _lhrEc = _lhrEc + 100
          _EhFk.Complete = true
          _EhFk.Active = false
          _nYcC.Active = true
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _TBt27("h\022l)rNw\029l\023F1)LAfwl3CCl\026AffrF\023r\023lAN>"),
      Callback = function(action)
        if action ~= nil then
          _OLzUj:Start()
        end
      end
    })
    _lhrEc = _lhrEc + 100
    _Qdmgs.Commands._26EaE.Enabled = false
  end
end
function _vxc:On_bhz(target)
  if _Pav2 == true then
    _Urwigo.MessageBox({
      Text = _TBt27("{.l{A@@qMlR.@lw.\023:l\018@r:l\022\023:l\026rF@?rol:.rl&;.ff.\023?ww\195\182)\023rlUF\023l`@wlRrAwfrql\022\023:lw1)F\023lf\195\164\023?r@l.\023l{F?;A@\029w>lR.@l)ANr\023lrwl\020A\022w\029:.1\019l).\023\029r@l:r\023l\016)@r\023MlR.@l)ANr\023lr.\023l\026rw1)r\023\019l\020\195\188@l:.1)>l|@I\195\164)fl\023.rLA\023:rLl:AUF\023olrwl.w\029lr.\023l\026r)r.L\023.w>lhAwl.w\029l:.rl5A@\029rl:rwl\n\022L\029@r.Nr@wl\022\023:lw.rlIr.?\029l:.@ol;Fl:r@l|.\023?A\023?lI\022l{F?wLrA:rlf.r?\029>lZ\023l{F?wLrA:rl?.N\029wl:AwlNrw\029rlt\022\029\029r@N.r@l\022\023:l;.@l\020r.r@\023l:F@\029l:.rl\029Fffw\029r\023l\001A@\029qw>lR.rl:.rl&A\022Nr@\019A@\029rl\020\022\023\019\029.F\023.r@\029olL\022ww\029l:\022lAffr@:.\023?wlwrfNr@l)r@A\022w\020.\023:r\023M"),
      Media = _AhdW
    })
    _vwx.Visible = true
    _Boyl.Complete = true
    _Boyl.Active = false
    _t2Lz.Active = true
    _Pav2 = false
    _3C2.Commands._b7oBD.Enabled = true
  else
    _Urwigo.MessageBox({
      Text = _TBt27("\024.DDrl:.rl5A@\029rlL.\029l:r.\023rLl&A\022Nr@w\029ANlA\023l\022\023:lwA?ral$Z1)lw1);\195\182@rl\020r.r@f.1)ol:Awwl.1)lr.\023l\024\022\023.1)\029?\022\029lN.\023M$"),
      Media = _AhdW
    })
  end
end
function _UvDuh:On_5Ek2(target)
  _Urwigo.Dialog(false, {
    {
      Text = _TBt27("{AffFol.1)lN.\023l\nF\023lRrAwfrql\022\023:lN.\023lA\0221)l\023r\022l.\023l{F?;A@\029w>l\aF\023lLr.\023r\023lt@\195\188:r@\023l;r.wwl.1)ol:Awwlrwl).r@lNr.l:r@l\001r.\029w1)r\023:r\023lRr.:rlr.\023r\023l?r)r.Lr\023l|.\023?A\023?l\023A1)l{F?wLrA:rl?.N\029>"),
      Media = _YWA_
    },
    {
      Text = _TBt27("d\023:l.1)lN.\023l{r@L.\023rl\026@A\023?r@l\022\023:l\019A\023\023lL.1)lr.\023\020A1)l\023.1)\029lr@.\023\023r@\023olA\022\020l;rf1)r@l{\195\182)rl:.rl\001r.\029w1)r\023:rlRr.:rlE|.1)r\002lw\029r)\029>l\026.NlL.@l:F1)lN.\029\029rl:.rlF\020\020.I.rffrl{\195\182)rlA\023>"),
      Media = _4Fgw
    }
  }, function(action)
    _UvDuh.Commands._kWD.Enabled = true
  end)
end
function _UvDuh:On_kWD(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_erfiQ)
  end)
end
function _yk3i:On_I9Ews(target)
  if _kCQ_h == 1 then
    _Urwigo.MessageBox({
      Text = _TBt27("RA@\029rl\019\022@IMltrUF@l:\022lr.\023\029@r\029r\023l:A@\020w\029olL\022ww\029l:\022l\020Ff?r\023:rl\018@A?rlNrA\023\029;F@\029r\023a"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_Zt7wl)
          end)
        end
      end
    })
  elseif _kCQ_h == 2 then
    _Urwigo.MessageBox({
      Text = _TBt27("RA@\029rl\019\022@IMltrUF@l:\022l).\023r.\023l:A@\020w\029olL\022ww\029l:\022l\020Ff?r\023:rl\018@A?rlNrA\023\029;F@\029r\023a"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_QrUsI)
          end)
        end
      end
    })
  elseif _kCQ_h == 3 then
    _Urwigo.MessageBox({
      Text = _TBt27("RA@\029rl\019\022@IMltrUF@l:\022lr.\023\029@r\029r\023l:A@\020w\029olL\022ww\029l:\022l\020Ff?r\023:rl\018@A?rlNrA\023\029;F@\029r\023a"),
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_uv7)
          end)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _TBt27("\018r)fr@MlhAwl)\195\164\029\029rl\023.1)\029lDAww.r@r\023l:\195\188@\020r\023>>>]t\nkRr\023\023l:\022l:.rwrl}A1)@.1)\029lw.r)w\029olLrf:rlrwlN.\029\029rla\002")
    })
  end
end
function _Qv5q:On_aGMmu(target)
  _Urwigo.OldDialog({
    {
      Text = _TBt27("h\022lw.r)w\029l:r\023l[\022AfLr\023:r\023l\022\023:l:ALD\020r\023:r\023l{F?;A@\029wr_D@rwwlALl\026fr.wlw\029r)r\023>lhF1)lr@lw1)r.\023\029l\001@FNfrLrlNr.Ll+Fw\020A)@r\023lI\022l)ANr\023>"),
      Media = _IAZb8
    },
    {
      Text = _TBt27("h\022lr\023\029:r1\019w\029lr.\023rlA\019\029\022rffrlT\022w?ANrl:rwl\024A?rwD@FD)r\029r\023lA\022\020l:rLltF:r\023>lT\022\020l:r@l\024.\029rfwr.\029rlw.r)w\029l:\022l\020Ff?r\023:rwa")
    },
    {
      Text = _TBt27("$`qw\029r@.\195\182wr@l&A\022Nr@r@lUr@w\029r1\019\029l&A\022Nr@wD@\0221)lALltA)\023)F\020lA\022\020l\026fr.wl!l^X\006>$"),
      Media = _LadtD
    }
  })
  if _wLBH == true then
    _tMZ5.Complete = true
    _Qv5q.Commands._4_Q0.Enabled = true
    _Tty.Active = true
    _tMZ5.Active = false
  else
  end
end
function _Qv5q:On_4_Q0(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_SOFBC)
  end)
end
function _UO_t:On_38P0(target)
  if _lhrEc >= 42 then
    _lhrEc = _lhrEc + -42
    _UO_t:MoveTo(Player)
    _UO_t.Commands._38P0.Enabled = false
    _JZE = _JZE + 1
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rlg1)\022fN\195\1881)r@l?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>l\026r)rl\023\022\023l;.r:r@lI\022@\195\1881\019l.\023l:.rl`A@\019\029?Awwrl;r.\029r@lr.\023\019A\022\020r\023>"),
      Media = _hRY,
      Callback = function(action)
        if action ~= nil then
          _6tX()
          _cEcz:RequestSync()
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rlg1)\022fN\195\1881)r@l\023.1)\029lfr.w\029r\023>"),
      Media = _hRY
    })
  end
end
function _UO_t:On__Kx(target)
  _Urwigo.MessageBox({
    Text = _TBt27("h\022lL\022ww\029l:.rl@.1)\029.?r\023lg1)\022fN\195\1881)r@lA\022ww\0221)r\023>lZ\023l:r@l\001AwwA?rlI\022@lg\029A:\029N.Nf.F\029)r\019l\020.\023:rw\029l:\022l{.f\020r>"),
    Media = _hRY,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_i_OM)
        end)
      end
    end
  })
end
function _UO_t:On_3gbF8(target)
  _Urwigo.MessageBox({
    Text = _TBt27("h\022l\020.\023:rw\029lr.\023lt\022\029\029r@N.r@@rIrD\029a]t\nk$|@).\029IrlRTgg|\nl.\023lr.\023rLl5rwwrflA\022\020l/C\194\176>l\026rNrl`T+&l).\023I\022l\022\023:lr@).\029Irl:Awl\026rL.w1)l;r.\029r@lA\022\020l\\y\194\176>l\026rNrl{\016\001\018|}l).\023I\022l\022\023:l@\195\188)@rl:Awl\026rL.w1)l\022L>l\026rNrlw1)f.rwwf.1)l{|\018|l).\023I\022l\022\023:lfAwwrl:Awl\026A\023Irl?\195\164@r\023>$")
  })
end
function _K53_:On_krgX(target)
  _Urwigo.MessageBox({
    Text = (_TBt27("h\022l)Aw\029lLFLr\023\029A\023l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>")
  })
end
function _3C2:On_o2x(target)
  if _lhrEc >= 22 then
    Wherigo.PlayAudio(_fqj)
    _lhrEc = _lhrEc + -22
    _3C2:MoveTo(Player)
    _3C2.Commands._o2x.Enabled = false
    _JZE = _JZE + 1
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:r\023l&A\022Nr@w\029ANl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>l\026r)rl\023\022\023lI\022@\195\1881\019l.\023l:.rl`A@\019\029?Awwrl\022\023:l\019A\022\020rl;r.\029r@lr.\023>"),
      Media = _WSQ,
      Callback = function(action)
        if action ~= nil then
          _6tX()
        end
      end
    })
    _cEcz:RequestSync()
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:r\023l&A\022Nr@w\029ANl\023.1)\029lfr.w\029r\023>"),
      Media = _WSQ
    })
  end
end
function _3C2:On_oYyps(target)
  _Urwigo.MessageBox({
    Text = _TBt27("hAwl&A\022Nr@\023lA\022wwr@)AfNlUF\023l{F?;A@\029wl.w\029l\023.1)\029l?rw\029A\029\029r\029M"),
    Media = _PnYc
  })
  _3C2.Commands._oYyps.Enabled = false
end
function _3C2:On_b7oBD(target)
  Wherigo.PlayAudio(_0ju)
  _Urwigo.MessageBox({
    Text = _TBt27("Z1)lw1);\195\182@rl\020r.r@f.1)ol.1)lN.\023lr.\023l\024\022\023.1)\029?\022\029M")
  })
  _ePDv = false
  _3C2.Commands._b7oBD.Enabled = false
end
function _3C2:On_3EUA(target)
  _Urwigo.MessageBox({
    Text = _TBt27("h\022lw.r)w\029lr.\023r\023l&A\022Nr@w\029AN>"),
    Media = _WSQ,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_pckJH)
        end)
      end
    end
  })
end
function _2W_Pn:On_23Rs(target)
  if _lhrEc >= 11 then
    _lhrEc = _lhrEc + -11
    _2W_Pn:MoveTo(Player)
    _2W_Pn.Commands._23Rs.Enabled = false
    _JZE = _JZE + 1
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:r\023l5rwwrfl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _yWA,
      Callback = function(action)
        if action ~= nil then
          _6tX()
        end
      end
    })
    _cEcz:RequestSync()
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:r\023l5rwwrfl\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _2W_Pn:On_TmHa(target)
  _Urwigo.MessageBox({
    Text = _TBt27("h\022l@\195\188)@w\029l:r\023lZ\023)Af\029l:rwl5rwwrfwl\022L>")
  })
  if _kpUIL == true then
    _XuB = true
  end
end
function _2W_Pn:On_crijv(target)
  _Urwigo.MessageBox({
    Text = _TBt27("T\022\020l;rf1)rl\024rLDr@A\029\022@lL\195\1821)\029rw\029l:\022l:r\023l5rwwrflr@).\029Ir\023\004"),
    Buttons = {
      _TBt27("/C\194\176"),
      _TBt27("\\y\194\176")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _Urwigo.MessageBox({
            Text = _TBt27("h\022lr@).\029I\029l:r\023l5rwwrflA\022\020l/C\194\176>")
          })
          if _K3zjX == true then
            _lhG = true
          end
        else
          _Urwigo.MessageBox({
            Text = _TBt27("h\022lr@).\029I\029l:r\023l5rwwrflA\022\020l\\y\194\176>")
          })
          if _9hkU == true then
            _z6OXu = true
          end
        end
      end
    end
  })
end
function _2W_Pn:On_c0T7(target)
  if _yFfJ0 and _2AN then
    Wherigo.PlayAudio(_bL8Le)
    _Urwigo.MessageBox({
      Text = _TBt27("\001r@\020r\019\029Ml|.\023l;\022\023:r@NA@rwlt\022\029\029r@N.r@>lR.ff\019FLLr\023l.\023l{F?;A@\029wol`.w\029r@l\001F\029\029r@>"),
      Media = _n6d
    })
    _DvLoX.Complete = true
    _DvLoX.Active = false
    _Boyl.Active = true
    _vxc.Visible = true
    _wiKC.Visible = false
    _2W_Pn.Visible = false
    _UO_t.Visible = false
    _Tog0.Visible = false
    _Tog0.Active = false
    _LUd.Active = false
    _LUd.Visible = false
  else
    _Urwigo.MessageBox({
      Text = _TBt27("+r.:r@l\020Afw1)>lg1)A\022lLAfl.\023l:r.\023rLlZ\023Ur\023\029A@l\023A1)>l\a.rffr.1)\029l\020.\023:rw\029l:\022l:F@\029lr.\023lt\022\029\029r@N.r@@rIrD\029>]t\nk]t\nkh\022lfrr@w\029l:r\023l5rwwrflA\022w>")
    })
    _L_Pk3()
  end
end
function _2W_Pn:On_NsAxS(target)
  _Urwigo.MessageBox({
    Text = _TBt27("h\022lfrr@w\029l:r\023l5rwwrflA\022w>")
  })
  _L_Pk3()
end
function _2W_Pn:On_xyex(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_6oR4)
  end)
end
function _anI:On_MIEn(target)
  if _lhrEc >= 17 then
    _lhrEc = _lhrEc + -17
    _anI:MoveTo(Player)
    _anI.Commands._MIEn.Enabled = false
    _JZE = _JZE + 1
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:r\023ldL)A\023?l?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>l\026r)rl\023\022\023l:.rltA)\023)F\020w\029@Awwrl)F1)>lhF@\029lNr\019FLLw\029l:\022lr.\023r\023l5\022D\020r@\019rwwrf>"),
      Media = _Sr0,
      Callback = function(action)
        if action ~= nil then
          _6tX()
        end
      end
    })
    _HeL1v.Active = true
    _HeL1v.Visible = true
    _cEcz:RequestSync()
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:r\023ldL)A\023?l\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _anI:On_5CW(target)
  _Urwigo.MessageBox({
    Text = _TBt27("\016\019ol:\022l:A@\020w\029l{F?;A@\029wl\023\022\023lNr\029@r\029r\023>"),
    Media = _PnYc
  })
  _anI.Commands._5CW.Enabled = false
  _anI.Visible = false
  _3C2.Commands._oYyps.Enabled = false
  _Ufxv.Complete = true
  _Ufxv.Active = false
  _Pf4.Active = true
  _wiKC.Visible = true
end
function _nMqCp:On_b8sUo(target)
  if _lhrEc >= 4 then
    _lhrEc = _lhrEc + -4
    _nMqCp:MoveTo(Player)
    _nMqCp.Commands._b8sUo.Enabled = false
    _JZE = _JZE + 1
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l\001AD.r@l\022\023:l\018r:r@l?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _tYSC,
      Callback = function(action)
        if action ~= nil then
          _6tX()
        end
      end
    })
    _tnVG5.Active = true
    _cEcz:RequestSync()
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l\001AD.r@l\022\023:l\018r:r@l\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _nMqCp:On_q61s(target)
  _Urwigo.MessageBox({
    Text = _TBt27("hr@l0F:rl\020\195\188@l:.rl\024@\022)rlfA\022\029r\029ly!\\\b>"),
    Callback = function(action)
      if action ~= nil then
        _TVx:Stop()
        _aYG0 = _Urwigo.Floor((_TVx.Duration - _TVx.Remaining) / 60, 0)
        _shTi = _TVx.Duration - _TVx.Remaining - _aYG0 * 60
        _cEcz:RequestSync()
        _Urwigo.MessageBox({
          Text = (_TBt27("Rr\023\023l:\022l:AwlgD.rflA\022\020lR)r@.?F>1FLlfF??r\023lL\195\1821)\029rw\029ol).r@l.w\029l:r.\023l0F:ra]t\nk") .. string.sub(Player.CompletionCode, 1, 15)) .. _TBt27("]t\nk\018Affwl:\022l.)\023l:.@l\023F1)LAfwlA\023wr)r\023l;.ffw\029l\020.\023:rw\029l:\022l.)\023lNr.l{A@@ql.\023l:r.\023rLlZ\023Ur\023\029A@>l|@l)A\029lw.1)lA\0221)lA\022\020?rw1)@.rNr\023l;.rl:\022l:.1)l?rw1)fA?r\023l)Aw\029>>>"),
          Callback = function(action)
            if action ~= nil then
              _Y1E3.Commands._FwoW.Enabled = true
              _z3JuH()
            end
          end
        })
      end
    end
  })
end
function _j7wSq:On_M0_FE(target)
  if _lhrEc >= 7 then
    _lhrEc = _lhrEc + -7
    _j7wSq:MoveTo(Player)
    _j7wSq.Commands._M0_FE.Enabled = false
    _ppHB.Visible = false
    _Uh6aL.Visible = false
    _32KS.Visible = false
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rl5@A;A\029\029rl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _xWl
    })
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rl5@A;A\029\029rl\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _59lH:On_kgl6(target)
  if _lhrEc >= 10 then
    _lhrEc = _lhrEc + -10
    _59lH:MoveTo(Player)
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rl&A\022Nr@\029@A\023\019\020fAw1)r\023l?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _k08is
    })
    _59lH.Commands._kgl6.Enabled = false
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rl&A\022Nr@\029@A\023\019\020fAw1)r\023l\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _vwx:On_DtXvN(target)
  if _ePDv == true then
    _Urwigo.MessageBox({
      Text = _TBt27("h.rl5A@\029rl.w\029lfrr@>")
    })
  else
    _Urwigo.MessageBox({
      Text = _TBt27("hAwl.w\029lr.\023rl5A@\029rlUF\023l{F?;A@\029w>lh\022lw.r)w\029lg1)\022)AN:@\195\1881\019rlNr.l:r@l$\001r.\029w1)r\023:r\023lRr.:r$l\022\023:l:.rl}ALr\023l$\nF\023lRrAwfrq$l\022\023:l${r@L.\023rl\026@A\023?r@$l:A\023rNr\023>")
    })
    _t2Lz.Complete = true
    _t2Lz.Active = false
    _epfQo.Active = true
    _hQEW.Active = true
    _hQEW.Visible = true
  end
end
function _7mUH:On_h8QO(target)
  _Urwigo.Dialog(false, {
    {
      Text = _TBt27("{A@@qlf.rw\029a"),
      Media = _RfPd
    },
    {
      Text = _TBt27("gr)@l?rr)@\029r@l`@>l\001F\029\029r@o]t\nk;.@l\020@r\022r\023l\022\023wolZ)\023r\023lL.\029\029r.fr\023lI\022l\019\195\182\023\023r\023ol:Awwlg.rlA\023l:r@l{F?;A@\029wGg1)\022frl\020\195\188@l{r_r@r.l\022\023:l&A\022Nr@r.lA\022\020?r\023FLLr\023lw.\023:>ltr.?rfr?\029l\020.\023:r\023lg.rlr.\023rl+.w\029rlAffr@lNr\023\195\182\029.?\029r\023lg1)\022fLA\029r@.Af.r\023ol:.rlg.rlN.\029\029rlALlr@w\029r\023lg1)\022f\029A?lL.\029N@.\023?r\023>]t\nk]t\nkR.@l\020@r\022r\023l\022\023wolg.rlNAf:l.\023l{F?;A@\029wl;.ff\019FLLr\023lI\022l)r.wwr\023>]t\nk]t\nk`.\029l\020@r\022\023:f.1)r\023l\026@\195\188wwr\023]t\nk`.\023r@UAl`1\026F\023A?Aff]t\nkg\029rffUr@\029@r\029r\023:rlg1)\022ffr.\029r@.\023")
    },
    {
      Text = _TBt27("T\023Nr.l.w\029lr.\023rl+.w\029rlL.\029lAffr@fr.l\026r?r\023w\029\195\164\023:r\023>l{A@@ql\195\188Nr@\020f.r?\029lw.rl\019\022@I>]t\nk]t\nk5rwwrf]t\nkg1)\022fN\195\1881)r@]t\nkdL)A\023?]t\nk\001AD.r@l\022\023:l\018r:r@]t\nk&A\022Nr@w\029AN")
    }
  }, function(action)
    if _mrgN1 == true then
      _Urwigo.OldDialog({
        {
          Text = _TBt27("d\023:l:AwlAffrwl\019\195\182\023\023r\023l;.@l.\023l+F\023:F\023l\019A\022\020r\023\004"),
          Media = _RfPd
        },
        {
          Text = _TBt27("bA>lRr\023\023l:\022l;r.ww\029ol;F>l5FLLlL.\029l{A@@qol;.@lL\195\188wwr\023lI\022Ll\024@FD\020r\023:r\023l5rwwrf>"),
          Media = _BdA
        }
      })
      _HO4r.Complete = true
      _HO4r.Active = false
      _UP4.Active = true
      _1t7.Active = true
      _1t7.Visible = true
      _Wiu:MoveTo(Player)
      _mrgN1 = false
    else
    end
    _cEcz:RequestSync()
  end)
end
function _ppHB:On_XcdQ(target)
  if _lhrEc >= 7 then
    _lhrEc = _lhrEc + -7
    _ppHB:MoveTo(Player)
    _ppHB.Commands._XcdQ.Enabled = false
    _j7wSq.Visible = false
    _Uh6aL.Visible = false
    _32KS.Visible = false
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rl5@A;A\029\029rl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _xWl
    })
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rl5@A;A\029\029rl\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _Uh6aL:On_uIDtl(target)
  if _lhrEc >= 7 then
    _lhrEc = _lhrEc + -7
    _Uh6aL:MoveTo(Player)
    _Uh6aL.Commands._uIDtl.Enabled = false
    _j7wSq.Visible = false
    _ppHB.Visible = false
    _32KS.Visible = false
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rl5@A;A\029\029rl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _xWl
    })
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rl5@A;A\029\029rl\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _32KS:On_PhE(target)
  if _lhrEc >= 7 then
    _lhrEc = _lhrEc + -7
    _32KS:MoveTo(Player)
    _32KS.Commands._PhE.Enabled = false
    _j7wSq.Visible = false
    _Uh6aL.Visible = false
    _ppHB.Visible = false
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029l:.rl5@A;A\029\029rl?r\019A\022\020\029>lh\022lNrw.\029I\029l\023F1)l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>"),
      Media = _xWl
    })
  else
    _Urwigo.MessageBox({
      Text = (_TBt27("h\022l)Aw\029lfr.:r@l\023\022@l") .. _lhrEc) .. _TBt27("l\026AffrF\023r\023>lh\022l\019A\023\023w\029l:.@l:.rl5@A;A\029\029rl\023.1)\029lfr.w\029r\023>")
    })
  end
end
function _6tX()
  if _JZE >= 5 then
    _Urwigo.MessageBox({
      Text = _TBt27("Z1)l?fA\022Nrl:\022l)Aw\029l\030r\029I\029lAffrwl;Awl:\022lN@A\0221)w\029l{A@@q>lh\022lN.w\029l\023\022\023lNr@r.\029l\020\195\188@l:r.\023rl\nr.wrl\023A1)l{F?;A@\029w>l\026r)rl\023\022\023lI\022Ll\026fr.wl!l^X\006lALltA)\023)F\020>lZ1)lL\022wwlfFwol.1)l)ANrl\023F1)lr.\023lDAA@lh.\023?rl.\023l:r@lR.\023\019rf?AwwrlI\022lr@fr:.?r\023>lR.@lwr)r\023l\022\023wl.\023l{F?;A@\029wM"),
      Media = _BdA
    })
    _Wiu:MoveTo(_9rbkZ)
    _NfIX.Active = false
    _NfIX.Visible = false
    _Jdr.Active = false
    _Jdr.Visible = false
    _tnVG5.Active = false
    _tnVG5.Visible = false
    _Ahs.Active = false
    _Ahs.Visible = false
    _HeL1v.Active = false
    _HeL1v.Visible = false
    _MSkmJ.Active = false
    _MSkmJ.Visible = false
    _4BVI.Active = false
    _4BVI.Visible = false
    _Tog0.Active = true
    _Tog0.Visible = true
    _nYcC.Complete = true
    _nYcC.Active = false
    __8WBE.Active = true
  else
  end
end
function _L_Pk3()
  _K3zjX = false
  _lhG = false
  _9hkU = false
  _z6OXu = false
  _kpUIL = false
  _XuB = false
  _yFfJ0 = false
  _2AN = true
  _T5N = _T5N + 1
end
function _fmz()
  _Urwigo.MessageBox({
    Text = _TBt27("d\023\029r@l$T\022\020?ANr\023$l\020.\023:rw\029l:\022lZ\023\020F@LA\029.F\023r\023l:AI\022ol;AwlAfwl\023\195\1641)w\029rwlI\022l\029\022\023l.w\029>lgFff\029rw\029l:\022lr.\023LAfl\023.1)\029l;r.\029r@\019FLLr\023ol\019F\023\029@Fff.r@rl:r.\023lZ\023Ur\023\029A@>l`r.w\029r\023wl\020.\023:rw\029l:\022l:F@\029lr\029;Awol:Awl:.1)l;r.\029r@N@.\023?\029>]t\nk+.rwl:.rl\024r_\029rlTd\018`|\n5gT`l:\022@1)Ml}.1)\029l:Awwl:\022lr.\023r\023l;.1)\029.?r\023l{.\023;r.wlUr@DAww\029>>>"),
    Media = _hNx,
    Buttons = {
      _TBt27("Rr.\029r@")
    },
    Callback = function(action)
      if action ~= nil then
        _zhoZ()
      end
    end
  })
end
function _zhoZ()
  _Urwigo.MessageBox({
    Text = _TBt27("hAwlgD.rflUr@;r\023:r\029l\029r.f;r.wrl`\022w.\019ol\024\195\182\023rlF:r@lh.AfF?rl\022Llr.\023rlNrwwr@rlT\029LFwD)\195\164@rlI\022lr@Ir\022?r\023>lTNr@l\019r.\023rlT\023?w\029olrwl.w\029l\023.1)\029l\023\195\182\029.?lL.\029l\024F\023lI\022lwD.rfr\023ol:r\023\023lrwl;r@:r\023l\019r.\023rl;.1)\029.?r\023lZ\023\020F@LA\029.F\023r\023l\195\188Nr@l\024F\023lUr@L.\029\029rf\029>"),
    Media = _hNx,
    Buttons = {
      _TBt27("&\022@\195\1881\019"),
      _TBt27("Rr.\029r@")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _fmz()
        else
          _JtbY()
        end
      end
    end
  })
end
function _JtbY()
  _Urwigo.MessageBox({
    Text = _TBt27("h\022lL\022ww\029l.LLr@l;.r:r@l\018@A?r\023lNrA\023\029;F@\029r\023l\022LlUF@;\195\164@\029wlI\022l\019FLLr\023>l`A\0231)LAfl\019A\023\023w\029l:\022olA\023\029w\029A\029\029l:.rlT\023\029;F@\029lr.\023I\022\029.DDr\023olA\0221)lr.\023r\023lB\nG0F:rlr.\023w1A\023\023r\023>lhAwl.w\029lANr@l@r.\023lFD\029.F\023Af>l]t\nkgFff\029rw\029l:\022l;\195\164)@r\023:l:rwlgD.rfr\023wlr.\023r\023l\018r)fr@l\020.\023:r\023olw.\023:l;.@l\020@F)ol;r\023\023l:\022lrwl\022\023wlL.\029\029r.fw\029ol:AL.\029l;.@l.)\023lNr)rNr\023l\019\195\182\023\023r\023>"),
    Media = _hNx,
    Buttons = {
      _TBt27("&\022@\195\1881\019"),
      _TBt27("Rr.\029r@")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _zhoZ()
        elseif _Eef == true then
          _s9N()
          _Eef = false
        end
      else
      end
    end
  })
end
function _s9N()
  _Urwigo.MessageBox({
    Text = _TBt27("\018Affwl:\022l:.rwrl|.\023\020\195\188)@\022\023?l\023F1)LAfwlfrwr\023l;.ffw\029ol\020@A?lr.\023\020A1)l{A@@q>]t\nkhr.\023rl\nr.wrlw\029A@\029r\029l.Ll+.?\022w\029r@;r?ol;Fl{A@@ql\001F\029\029r@lNr.lwr.\023rLl\016\023\019rfl\ar@\023F\023l\022\023:lwr.\023r@l\024A\023\029rl\001r\029\022\023.AlfrN\029>l\026r)rlAfwlr@w\029rwl:F@\029l).\023>"),
    Media = _hNx,
    Buttons = {
      _TBt27("&\022@\195\1881\019"),
      _TBt27("Rr.\029r@")
    },
    Callback = function(action)
      if action ~= nil then
        if action == "Button1" then
          _JtbY()
        else
          _EmSV()
        end
      end
    end
  })
end
function _EmSV()
  _AHB.Active = true
  _qMGT.Active = true
  _qMGT.Visible = true
  _TVx:Start()
end
function _dSeA()
  _Urwigo.MessageBox({
    Text = _TBt27("R.ff\019FLLr\023l.\023l:r@lR.\023\019rf?AwwrM]t\nk{.r@l\020.\023:rw\029l:\022lAffr@fr.l\026rw1)\195\164\020\029rl\020\195\188@l&A\022Nr@r.Nr:A@\020>"),
    Media = _bRH
  })
  _1t7.Active = false
  _1t7.Visible = false
  _9rbkZ.Active = false
  _9rbkZ.Visible = false
  _qMGT.Active = false
  _qMGT.Visible = false
  _Jdr.Visible = true
  _Jdr.Active = true
  _MSkmJ.Visible = true
end
function _gqD()
  _Urwigo.OldDialog({
    {
      Text = _TBt27("gFol:A\023\023l\019\195\188LLr@\023l;.@l\022\023wlLAfl\022Ll:r.\023rl|.\023\019A\022\020wf.w\029r>"),
      Media = _BdA
    },
    {
      Text = _TBt27("{A@@ql\023.LL\029lwr.\023r\023lt@.r\020lUF\023l{F?;A@\029wl)r@UF@>lhA@.\023lw\029r)\029a]t\nk]t\nkh.\023?rol:.rlg.rl\020\195\188@wlr@w\029rlg1)\022f\030A)@lNr\023\195\182\029.?r\023a]t\nk5rwwrf]t\nkg1)\022fN\195\1881)r@]t\nkdL)A\023?]t\nk\001AD.r@l\022\023:l\018r:r@]t\nk&A\022Nr@w\029AN")
    },
    {
      Text = _TBt27("5r.\023l\001@FNfrLl{A@@qol:Awl\020.\023:r\023l;.@lAffrwl).r@>lR.@lL\195\188wwr\023lr.\023\020A1)lUF\023l).r@lA\022wl\023A1)lRrw\029r\023l:.rlE`A@\019\029G\002\026Awwrl)r@\022\023\029r@?r)r\023>lhA\023\023l\019FLLr\023l;.@lA\023lAffr\023l\026rw1)\195\164\020\029r\023lUF@Nr.>"),
      Media = _BdA
    }
  })
  _Ahs.Active = true
  _4BVI.Active = true
  _NfIX.Active = true
end
function _z3JuH()
  _Urwigo.MessageBox({
    Text = _TBt27("d\023\029r@l:rLl\020Ff?r\023:r\023l+.\023\019l\020.\023:rw\029l:\022lr.\023ltA\023\023r@ol:Awl:\022lA\022\020l:r.\023rLl\001@F\020.flD@\195\164wr\023\029.r@r\023l\019A\023\023w\029a"),
    Callback = function(action)
      if action ~= nil then
        if Player:Contains(_j7wSq) then
          _Urwigo.MessageBox({
            Text = _TBt27("\029_\029>:FX3\020\bwC")
          })
        elseif Player:Contains(_32KS) then
          _Urwigo.MessageBox({
            Text = _TBt27("\029_\029>:FX3\020\bw\019")
          })
        elseif Player:Contains(_ppHB) then
          _Urwigo.MessageBox({
            Text = _TBt27("\029_\029>:FX3\020\bw\006")
          })
        elseif Player:Contains(_Uh6aL) then
          _Urwigo.MessageBox({
            Text = _TBt27("l\029_\029>:FX3\020\bwf")
          })
        else
          _Urwigo.MessageBox({
            Text = _TBt27("\029_\029>:FX3\020\bwL")
          })
        end
      end
    end
  })
end
return _cEcz
