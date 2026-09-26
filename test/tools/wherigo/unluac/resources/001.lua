require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _bKb4(str)
  local res = ""
  local dtable = "4\001\021$\0200`\004\nX2)\023\r}B:J(-\0259fI\006\005p\022e/q6\017&#*hCGs\028uD^A!lWQ\000 \a8<P@RV\029\031x~%\tt_n\024\v\015M\026k\f>mKy[wb'|g+o15\"F;O\\H\018\014\019LY3vz\027{j.\030N\016Z\002=\003\b7rTd],ESiUc?a"
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
_Xt61 = Wherigo.ZCartridge()
_7Tcg = Wherigo.ZMedia(_Xt61)
_7Tcg.Id = "bd421763-4149-4202-9a2c-9117f2af7ba4"
_7Tcg.Name = _bKb4("/TV%*Q\029t")
_7Tcg.Description = ""
_7Tcg.AltText = ""
_7Tcg.Resources = {
  {
    Type = "jpg",
    Filename = "logohuber1.jpg",
    Directives = {}
  }
}
_tiVos = Wherigo.ZMedia(_Xt61)
_tiVos.Id = "ef306a36-a2cd-4427-b6ed-78cab1f307e7"
_tiVos.Name = _bKb4("^*Q\029t")
_tiVos.Description = ""
_tiVos.AltText = ""
_tiVos.Resources = {
  {
    Type = "jpg",
    Filename = "huber1.jpg",
    Directives = {}
  }
}
_Fpli = Wherigo.ZMedia(_Xt61)
_Fpli.Id = "29bd5776-63d5-407f-a3be-c4746c57abb4"
_Fpli.Name = _bKb4("/VTVb*\027\029")
_Fpli.Description = ""
_Fpli.AltText = ""
_Fpli.Resources = {
  {
    Type = "jpg",
    Filename = "logoLupe.jpg",
    Directives = {}
  }
}
_x9U5 = Wherigo.ZMedia(_Xt61)
_x9U5.Id = "7fb5ba29-d0f6-4d9a-9be9-402bad403e90"
_x9U5.Name = _bKb4("b*\027\029")
_x9U5.Description = ""
_x9U5.AltText = ""
_x9U5.Resources = {
  {
    Type = "jpg",
    Filename = "lupe.jpg",
    Directives = {}
  }
}
_bRn = Wherigo.ZMedia(_Xt61)
_bRn.Id = "af149ea6-b26d-479d-8f69-c999139a497b"
_bRn.Name = _bKb4("/VTV0*t(A")
_bRn.Description = ""
_bRn.AltText = ""
_bRn.Resources = {
  {
    Type = "jpg",
    Filename = "Logomcol_sausage.jpg",
    Directives = {}
  }
}
_sQPJA = Wherigo.ZMedia(_Xt61)
_sQPJA.Id = "a9f77d5e-4aec-45f1-aba1-47cad103f29f"
_sQPJA.Name = _bKb4("0*t(A")
_sQPJA.Description = ""
_sQPJA.AltText = ""
_sQPJA.Resources = {
  {
    Type = "jpg",
    Filename = "mcol_sausage.jpg",
    Directives = {}
  }
}
_hfx = Wherigo.ZMedia(_Xt61)
_hfx.Id = "db0a8d70-1565-4a5a-be8e-bbfa35b7e758"
_hfx.Name = _bKb4("'\029/v")
_hfx.Description = ""
_hfx.AltText = ""
_hfx.Resources = {
  {
    Type = "jpg",
    Filename = "Geldsack-Kopie.jpg",
    Directives = {}
  }
}
_R_v = Wherigo.ZMedia(_Xt61)
_R_v.Id = "de62bb65-4cc1-4caa-afc3-12351b74294f"
_R_v.Name = _bKb4("^\127CvN")
_R_v.Description = ""
_R_v.AltText = ""
_R_v.Resources = {
  {
    Type = "jpg",
    Filename = "handy.jpg",
    Directives = {}
  }
}
_TQHUh = Wherigo.ZMedia(_Xt61)
_TQHUh.Id = "56c370a3-3241-4e41-a418-e1b96f29b3fc"
_TQHUh.Name = _bKb4("bVTV^\127CvN")
_TQHUh.Description = ""
_TQHUh.AltText = ""
_TQHUh.Resources = {
  {
    Type = "jpg",
    Filename = "logoHandy.jpg",
    Directives = {}
  }
}
_eXSH = Wherigo.ZMedia(_Xt61)
_eXSH.Id = "4ee25701-e87b-4cda-a7ba-c3b23e3c5f8d"
_eXSH.Name = _bKb4("-tfA")
_eXSH.Description = ""
_eXSH.AltText = ""
_eXSH.Resources = {
  {
    Type = "jpg",
    Filename = "Arzt_kleiner.jpg",
    Directives = {}
  }
}
_89f = Wherigo.ZMedia(_Xt61)
_89f.Id = "fad4d334-a5f5-4ff0-abad-ea5d9bc21aac"
_89f.Name = _bKb4("bVTV-tfA")
_89f.Description = ""
_89f.AltText = ""
_89f.Resources = {
  {
    Type = "jpg",
    Filename = "logoArzt.jpg",
    Directives = {}
  }
}
_h6b1u = Wherigo.ZMedia(_Xt61)
_h6b1u.Id = "716317e5-98eb-4ccc-82f5-1cd918489667"
_h6b1u.Name = _bKb4("u\029tL{CI\127/\029Cv\029t")
_h6b1u.Description = ""
_h6b1u.AltText = ""
_h6b1u.Resources = {
  {
    Type = "jpg",
    Filename = "lexikon.jpg",
    Directives = {}
  }
}
_NElY = Wherigo.ZMedia(_Xt61)
_NElY.Id = "99ac1557-ef44-4fd8-b1b8-07ad81670942"
_NElY.Name = _bKb4("bVTVM\127/\029Cv\029t")
_NElY.Description = ""
_NElY.AltText = ""
_NElY.Resources = {
  {
    Type = "jpg",
    Filename = "Logolexikon.jpg",
    Directives = {}
  }
}
_FA3 = Wherigo.ZMedia(_Xt61)
_FA3.Id = "8587ecb1-b5bc-4a91-9519-2c6ecc6c8e03"
_FA3.Name = _bKb4("lVA{ff\029AA\029/")
_FA3.Description = ""
_FA3.AltText = ""
_FA3.Resources = {
  {
    Type = "jpg",
    Filename = "papers.jpg",
    Directives = {}
  }
}
_COc = Wherigo.ZMedia(_Xt61)
_COc.Id = "414adbb6-9583-4655-90cf-800e596dc331"
_COc.Name = _bKb4("bVTV7\127\027{\029t")
_COc.Description = ""
_COc.AltText = ""
_COc.Resources = {
  {
    Type = "jpg",
    Filename = "logopapers.jpg",
    Directives = {}
  }
}
_aoT = Wherigo.ZMedia(_Xt61)
_aoT.Id = "1ad188ec-79be-44a1-8007-9ffa315f1563"
_aoT.Name = _bKb4("bVTV'\029/v")
_aoT.Description = ""
_aoT.AltText = ""
_aoT.Resources = {
  {
    Type = "jpg",
    Filename = "LogoGeldsack.jpg",
    Directives = {}
  }
}
_JYR = Wherigo.ZMedia(_Xt61)
_JYR.Id = "e1de7ee7-6cf9-4579-8fba-534180c97e19"
_JYR.Name = _bKb4("bVTVyt/P\029{C")
_JYR.Description = ""
_JYR.AltText = ""
_JYR.Resources = {
  {
    Type = "jpg",
    Filename = "Logopolizei.jpg",
    Directives = {}
  }
}
_0izE = Wherigo.ZMedia(_Xt61)
_0izE.Id = "abc2686a-91ba-46cb-bb86-7f9129185f34"
_0izE.Name = _bKb4("yt/P\029{C")
_0izE.Description = ""
_0izE.AltText = ""
_0izE.Resources = {
  {
    Type = "jpg",
    Filename = "polizei.jpg",
    Directives = {}
  }
}
_bqq = Wherigo.ZMedia(_Xt61)
_bqq.Id = "78105576-4011-4a6a-a655-c5254b66a15b"
_bqq.Name = _bKb4("/VTV'\029/v")
_bqq.Description = ""
_bqq.AltText = ""
_bqq.Resources = {
  {
    Type = "jpg",
    Filename = "LogoGeldsack1.jpg",
    Directives = {}
  }
}
_Pja = Wherigo.ZMedia(_Xt61)
_Pja.Id = "dd5680c6-6b68-4895-ac65-edb46ffa683d"
_Pja.Name = _bKb4("/VTVc\127}%AI/*Q")
_Pja.Description = ""
_Pja.AltText = ""
_Pja.Resources = {
  {
    Type = "jpg",
    Filename = "Logoyachtclub.jpg",
    Directives = {}
  }
}
_gmv8 = Wherigo.ZMedia(_Xt61)
_gmv8.Id = "78b4cb6e-6a1a-4ea6-a09a-34885a37ac4c"
_gmv8.Name = _bKb4("Z\029*\029tP\029%t")
_gmv8.Description = ""
_gmv8.AltText = ""
_gmv8.Resources = {
  {
    Type = "jpg",
    Filename = "feuerwehr.jpg",
    Directives = {}
  }
}
_5O6Ie = Wherigo.ZMedia(_Xt61)
_5O6Ie.Id = "0dd8e14e-edd5-4500-9812-df4ba887ecd0"
_5O6Ie.Name = _bKb4("bVTVZ\029*\029tP\029%t")
_5O6Ie.Description = ""
_5O6Ie.AltText = ""
_5O6Ie.Resources = {
  {
    Type = "jpg",
    Filename = "Logofeuerwehr.jpg",
    Directives = {}
  }
}
_68eL = Wherigo.ZMedia(_Xt61)
_68eL.Id = "88ea895a-0b7d-442f-9a9e-3ddc4cd0ca5f"
_68eL.Name = _bKb4("A\127AVtA")
_68eL.Description = ""
_68eL.AltText = ""
_68eL.Resources = {
  {
    Type = "jpg",
    Filename = "tatort.jpg",
    Directives = {}
  }
}
_NDbO = Wherigo.ZMedia(_Xt61)
_NDbO.Id = "094b63b6-6f2e-4465-a397-a757aae825c3"
_NDbO.Name = _bKb4("/VTVA\127AVtA")
_NDbO.Description = ""
_NDbO.AltText = ""
_NDbO.Resources = {
  {
    Type = "jpg",
    Filename = "Logotatort.jpg",
    Directives = {}
  }
}
_OvX = Wherigo.ZMedia(_Xt61)
_OvX.Id = "febc88dc-3d1d-45fe-9663-197c3818ad75"
_OvX.Name = _bKb4("z\029T\029/}/*Q")
_OvX.Description = ""
_OvX.AltText = ""
_OvX.Resources = {
  {
    Type = "jpg",
    Filename = "segelclub.jpg",
    Directives = {}
  }
}
_gEk = Wherigo.ZMedia(_Xt61)
_gEk.Id = "f54a52ef-cca1-4165-9556-7398c429dc6e"
_gEk.Name = _bKb4("bVTV(\029T\029/}/*Q")
_gEk.Description = ""
_gEk.AltText = ""
_gEk.Resources = {
  {
    Type = "jpg",
    Filename = "logosegelclub.jpg",
    Directives = {}
  }
}
_dYEc = Wherigo.ZMedia(_Xt61)
_dYEc.Id = "cb4ff223-4479-4687-9956-31c19235fcca"
_dYEc.Name = _bKb4("y{CI\127*\023")
_dYEc.Description = ""
_dYEc.AltText = ""
_dYEc.Resources = {
  {
    Type = "jpg",
    Filename = "Einkaufzentrum.jpg",
    Directives = {}
  }
}
_6cyv = Wherigo.ZMedia(_Xt61)
_6cyv.Id = "a5156942-067c-4e94-a118-30941d4813cb"
_6cyv.Name = _bKb4("bVTVy{CI\127*\023")
_6cyv.Description = ""
_6cyv.AltText = ""
_6cyv.Resources = {
  {
    Type = "jpg",
    Filename = "logoEinkaufzentrum.jpg",
    Directives = {}
  }
}
_6cLB = Wherigo.ZMedia(_Xt61)
_6cLB.Id = "453a2a25-49dd-41cb-835c-da25464ec3a6"
_6cLB.Name = _bKb4("M*C(A")
_6cLB.Description = ""
_6cLB.AltText = ""
_6cLB.Resources = {
  {
    Type = "jpg",
    Filename = "kunstzentrum.jpg",
    Directives = {}
  }
}
_5Kj = Wherigo.ZMedia(_Xt61)
_5Kj.Id = "939b0b5d-c521-4c55-a900-35f03a605485"
_5Kj.Name = _bKb4("bVTVM*C(A")
_5Kj.Description = ""
_5Kj.AltText = ""
_5Kj.Resources = {
  {
    Type = "jpg",
    Filename = "logokunstzentrum.jpg",
    Directives = {}
  }
}
_P3Dmi = Wherigo.ZMedia(_Xt61)
_P3Dmi.Id = "d957e1ec-cb99-4aa8-ba7d-f9ac17a10e75"
_P3Dmi.Name = _bKb4("\016\127CI")
_P3Dmi.Description = ""
_P3Dmi.AltText = ""
_P3Dmi.Resources = {
  {
    Type = "jpg",
    Filename = "cacherbank.jpg",
    Directives = {}
  }
}
_zD2J = Wherigo.ZMedia(_Xt61)
_zD2J.Id = "1a0c7db9-3cb2-4031-90d5-4b77f0e378c8"
_zD2J.Name = _bKb4("/VTV\016\127CI")
_zD2J.Description = ""
_zD2J.AltText = ""
_zD2J.Resources = {
  {
    Type = "jpg",
    Filename = "Logocacherbank.jpg",
    Directives = {}
  }
}
_YAEt = Wherigo.ZMedia(_Xt61)
_YAEt.Id = "369105f2-bc15-4c2c-9789-8f1403f7bed7"
_YAEt.Name = _bKb4("c\127}%AI/*Q")
_YAEt.Description = ""
_YAEt.AltText = ""
_YAEt.Resources = {
  {
    Type = "jpg",
    Filename = "yachtclub.jpg",
    Directives = {}
  }
}
_rc3v = Wherigo.ZMedia(_Xt61)
_rc3v.Id = "f1248335-3583-481c-a9db-627a6f1c8f39"
_rc3v.Name = _bKb4("'\029V(%V\027")
_rc3v.Description = ""
_rc3v.AltText = ""
_rc3v.Resources = {
  {
    Type = "jpg",
    Filename = "Geoverkaeufer.jpg",
    Directives = {}
  }
}
_Jas = Wherigo.ZMedia(_Xt61)
_Jas.Id = "4c9f6668-f279-42b8-87c7-2c391d1fc8fb"
_Jas.Name = _bKb4("bVTV'\029V")
_Jas.Description = ""
_Jas.AltText = ""
_Jas.Resources = {
  {
    Type = "jpg",
    Filename = "LogoGeoverkaeufer.jpg",
    Directives = {}
  }
}
_gLzns = Wherigo.ZMedia(_Xt61)
_gLzns.Id = "bbf64ac3-fc32-4fc7-a61b-bbdf3e75953f"
_gLzns.Name = _bKb4("0\127}%%*Cv")
_gLzns.Description = ""
_gLzns.AltText = ""
_gLzns.Resources = {
  {
    Type = "jpg",
    Filename = "Wachhund.jpg",
    Directives = {}
  }
}
_U8HFT = Wherigo.ZMedia(_Xt61)
_U8HFT.Id = "92806e30-1377-4bfa-867a-014328a5e705"
_U8HFT.Name = _bKb4("bVTV0\127}%%*Cv")
_U8HFT.Description = ""
_U8HFT.AltText = ""
_U8HFT.Resources = {
  {
    Type = "jpg",
    Filename = "LogoWachhund.jpg",
    Directives = {}
  }
}
_LvPm = Wherigo.ZMedia(_Xt61)
_LvPm.Id = "e40f324d-5cf4-49eb-9b6f-ab0ceb19030e"
_LvPm.Name = _bKb4("c\127}%AI/*Q")
_LvPm.Description = ""
_LvPm.AltText = ""
_LvPm.Resources = {
  {
    Type = "jpg",
    Filename = "retislit.jpg",
    Directives = {}
  }
}
_mZT2 = Wherigo.ZMedia(_Xt61)
_mZT2.Id = "aa1cda4c-57af-41ed-a98d-f2f80b1acc54"
_mZT2.Name = _bKb4("bVTVt\029A{(/{A")
_mZT2.Description = ""
_mZT2.AltText = ""
_mZT2.Resources = {
  {
    Type = "jpg",
    Filename = "Logoretislit.jpg",
    Directives = {}
  }
}
_Jr9X = Wherigo.ZMedia(_Xt61)
_Jr9X.Id = "bb6b3e0a-0bd0-4fe8-b288-393ca29e05ff"
_Jr9X.Name = _bKb4("+tVT\029t{\029")
_Jr9X.Description = ""
_Jr9X.AltText = ""
_Jr9X.Resources = {
  {
    Type = "jpg",
    Filename = "Drogerie.jpg",
    Directives = {}
  }
}
_SZWg3 = Wherigo.ZMedia(_Xt61)
_SZWg3.Id = "acbfcd9c-6e54-41fa-824f-dce2460afcd1"
_SZWg3.Name = _bKb4("bVTV+tVT\029t{\029")
_SZWg3.Description = ""
_SZWg3.AltText = ""
_SZWg3.Resources = {
  {
    Type = "jpg",
    Filename = "LogoDrogerie.jpg",
    Directives = {}
  }
}
_ybW = Wherigo.ZMedia(_Xt61)
_ybW.Id = "4a9c4601-da01-4b8d-bbfe-70346e7de7db"
_ybW.Name = _bKb4("(\027{\029/P\127t\029C")
_ybW.Description = ""
_ybW.AltText = ""
_ybW.Resources = {
  {
    Type = "jpg",
    Filename = "Spielwaren.jpg",
    Directives = {}
  }
}
_pIQ = Wherigo.ZMedia(_Xt61)
_pIQ.Id = "cf29b95c-4d23-49f8-bde2-d3e2689f53c0"
_pIQ.Name = _bKb4("/VTVz\027{\029/P\127t\029C")
_pIQ.Description = ""
_pIQ.AltText = ""
_pIQ.Resources = {
  {
    Type = "jpg",
    Filename = "LogoSpielwaren.jpg",
    Directives = {}
  }
}
_240K4 = Wherigo.ZMedia(_Xt61)
_240K4.Id = "80b2bce3-7585-473e-9e87-8689d5608fc0"
_240K4.Name = _bKb4("Tt\029C\127v{\029t")
_240K4.Description = ""
_240K4.AltText = ""
_240K4.Resources = {
  {
    Type = "jpg",
    Filename = "grenadier.jpg",
    Directives = {}
  }
}
_RnjTx = Wherigo.ZMedia(_Xt61)
_RnjTx.Id = "aa8947e5-4438-4a4e-be9b-8ebfdd79ff71"
_RnjTx.Name = _bKb4("/VTVTt\029C\127v{\029t")
_RnjTx.Description = ""
_RnjTx.AltText = ""
_RnjTx.Resources = {
  {
    Type = "jpg",
    Filename = "logogrenadier.jpg",
    Directives = {}
  }
}
_J9M = Wherigo.ZMedia(_Xt61)
_J9M.Id = "5258ea32-80a0-4796-8fc7-f99d7a6d21c5"
_J9M.Name = _bKb4("\023t\127CI3C3(A\029{C")
_J9M.Description = ""
_J9M.AltText = ""
_J9M.Resources = {
  {
    Type = "jpg",
    Filename = "franknstein.jpg",
    Directives = {}
  }
}
_hqF = Wherigo.ZMedia(_Xt61)
_hqF.Id = "f27d56f5-ed0e-4b5b-8b0e-599190b4a64d"
_hqF.Name = _bKb4("/VTV\023t\127CIC(A\029{C")
_hqF.Description = ""
_hqF.AltText = ""
_hqF.Resources = {
  {
    Type = "jpg",
    Filename = "logofranknstein.jpg",
    Directives = {}
  }
}
_biW = Wherigo.ZMedia(_Xt61)
_biW.Id = "7c0111f3-a59b-41f8-9148-303e4754c7e8"
_biW.Name = _bKb4("\027/\127C")
_biW.Description = ""
_biW.AltText = ""
_biW.Resources = {
  {
    Type = "jpg",
    Filename = "map.jpg",
    Directives = {}
  }
}
_3Ant = Wherigo.ZMedia(_Xt61)
_3Ant.Id = "31413017-150d-40ee-8956-a92f0c5f8ff1"
_3Ant.Name = _bKb4("/VTV\027/\127C")
_3Ant.Description = ""
_3Ant.AltText = ""
_3Ant.Resources = {
  {
    Type = "jpg",
    Filename = "logomap.jpg",
    Directives = {}
  }
}
_lmOj1 = Wherigo.ZMedia(_Xt61)
_lmOj1.Id = "52da0692-4214-43c8-8e74-a4c0fe715050"
_lmOj1.Name = _bKb4("(A\127tAA\127(I")
_lmOj1.Description = ""
_lmOj1.AltText = ""
_lmOj1.Resources = {
  {
    Type = "jpg",
    Filename = "task.jpg",
    Directives = {}
  }
}
_NKR = Wherigo.ZMedia(_Xt61)
_NKR.Id = "03a11087-5a5b-4615-8f96-a8a9985facff"
_NKR.Name = _bKb4("/VTV(A\127tAA\127(I")
_NKR.Description = ""
_NKR.AltText = ""
_NKR.Resources = {
  {
    Type = "jpg",
    Filename = "Logotask.jpg",
    Directives = {}
  }
}
_hkF = Wherigo.ZMedia(_Xt61)
_hkF.Id = "7f27ae0e-f1e3-409e-8dd5-f520a7691ca9"
_hkF.Name = _bKb4("bVTV\023\029tA{Tu\127(I")
_hkF.Description = ""
_hkF.AltText = ""
_hkF.Resources = {
  {
    Type = "jpg",
    Filename = "Logotask_report_hot.jpg",
    Directives = {}
  }
}
_dUQM = Wherigo.ZMedia(_Xt61)
_dUQM.Id = "775fbf95-fa18-4cbb-8034-2f2e0ad67458"
_dUQM.Name = _bKb4("\023\029tA{Tu\127(I")
_dUQM.Description = ""
_dUQM.AltText = ""
_dUQM.Resources = {
  {
    Type = "jpg",
    Filename = "task_report_hot.jpg",
    Directives = {}
  }
}
_AV4_ = Wherigo.ZMedia(_Xt61)
_AV4_.Id = "59f43b51-a859-4126-89d3-d398a74e0fbf"
_AV4_.Name = _bKb4("P\127((\029t\027{(AV/\029")
_AV4_.Description = ""
_AV4_.AltText = ""
_AV4_.Resources = {
  {
    Type = "jpg",
    Filename = "waterpistol.jpg",
    Directives = {}
  }
}
_O3S = Wherigo.ZMedia(_Xt61)
_O3S.Id = "cdec0867-3513-43ce-8804-0ae0183c8643"
_O3S.Name = _bKb4("/VTVP\127((\029t\027{(AV/\029")
_O3S.Description = ""
_O3S.AltText = ""
_O3S.Resources = {
  {
    Type = "jpg",
    Filename = "logoWaterpistol.jpg",
    Directives = {}
  }
}
_KTD = Wherigo.ZMedia(_Xt61)
_KTD.Id = "f756e487-6b05-4313-bca4-212395f84103"
_KTD.Name = _bKb4("\016\127CII\127tA\029")
_KTD.Description = ""
_KTD.AltText = ""
_KTD.Resources = {
  {
    Type = "jpg",
    Filename = "H_Bankkarte.jpg",
    Directives = {}
  }
}
_yu0G = Wherigo.ZMedia(_Xt61)
_yu0G.Id = "59c9b857-7eb7-4b1f-90d8-86f0c85b08df"
_yu0G.Name = _bKb4("/VTV\016\127CII\127tA\029")
_yu0G.Description = ""
_yu0G.AltText = ""
_yu0G.Resources = {
  {
    Type = "jpg",
    Filename = "logoHBankkarte.jpg",
    Directives = {}
  }
}
_cU9_C = Wherigo.ZMedia(_Xt61)
_cU9_C.Id = "971034bc-deaa-48e7-9a75-86487bcb79c6"
_cU9_C.Name = _bKb4("G\029((\029t")
_cU9_C.Description = ""
_cU9_C.AltText = ""
_cU9_C.Resources = {
  {
    Type = "jpg",
    Filename = "messer.jpg",
    Directives = {}
  }
}
_ly4H = Wherigo.ZMedia(_Xt61)
_ly4H.Id = "9427e0eb-465f-476f-aa08-d107cf58bb66"
_ly4H.Name = _bKb4("/VTVG\029((\029t")
_ly4H.Description = ""
_ly4H.AltText = ""
_ly4H.Resources = {
  {
    Type = "jpg",
    Filename = "logoMesser.jpg",
    Directives = {}
  }
}
_SQlY = Wherigo.ZMedia(_Xt61)
_SQlY.Id = "e485497c-19b5-4ee4-95aa-efe8da4108b5"
_SQlY.Name = _bKb4("z}%t\029{QA{(}%")
_SQlY.Description = ""
_SQlY.AltText = ""
_SQlY.Resources = {
  {
    Type = "jpg",
    Filename = "schreibtisch.jpg",
    Directives = {}
  }
}
_5ismL = Wherigo.ZMedia(_Xt61)
_5ismL.Id = "813d88cd-7ecf-4dbd-8fda-96f95e179c0e"
_5ismL.Name = _bKb4("/VTVz}%t\029{QA{(}%")
_5ismL.Description = ""
_5ismL.AltText = ""
_5ismL.Resources = {
  {
    Type = "jpg",
    Filename = "logoSchreibtisch.jpg",
    Directives = {}
  }
}
_9sGa = Wherigo.ZMedia(_Xt61)
_9sGa.Id = "c8a40fe1-073a-4124-84d4-24f27d317d3d"
_9sGa.Name = _bKb4("Z\029*\029t/V\029(}%\029t")
_9sGa.Description = ""
_9sGa.AltText = ""
_9sGa.Resources = {
  {
    Type = "jpg",
    Filename = "Feuerloescher.jpg",
    Directives = {}
  }
}
_LPWkR = Wherigo.ZMedia(_Xt61)
_LPWkR.Id = "e1f77b29-6d2d-4eb9-81a4-16c049c4ca0b"
_LPWkR.Name = _bKb4("/VTVZ\029*\029t/V\029(}%\029t")
_LPWkR.Description = ""
_LPWkR.AltText = ""
_LPWkR.Resources = {
  {
    Type = "jpg",
    Filename = "logoFeuerloescher.jpg",
    Directives = {}
  }
}
_aO3E = Wherigo.ZMedia(_Xt61)
_aO3E.Id = "1ca475d2-a53c-46f6-9592-716a2df4552b"
_aO3E.Name = _bKb4("L\029AfT\029t")
_aO3E.Description = ""
_aO3E.AltText = ""
_aO3E.Resources = {
  {
    Type = "jpg",
    Filename = "metzger.jpg",
    Directives = {}
  }
}
_sDZO = Wherigo.ZMedia(_Xt61)
_sDZO.Id = "e74f5393-336b-4fec-8851-b82b4cabd295"
_sDZO.Name = _bKb4("/VTVL\029AfT\029t")
_sDZO.Description = ""
_sDZO.AltText = ""
_sDZO.Resources = {
  {
    Type = "jpg",
    Filename = "Logometzger.jpg",
    Directives = {}
  }
}
_uoz5I = Wherigo.ZMedia(_Xt61)
_uoz5I.Id = "2e7c7f04-33ba-42e3-846a-b1735635b652"
_uoz5I.Name = _bKb4("y{(e\029tI\127\029*\023\029t{C")
_uoz5I.Description = ""
_uoz5I.AltText = ""
_uoz5I.Resources = {
  {
    Type = "jpg",
    Filename = "Icecreamstandgraphic.jpg",
    Directives = {}
  }
}
_QElQu = Wherigo.ZMedia(_Xt61)
_QElQu.Id = "e5a1cd76-f061-4234-b4b5-839f5a92b876"
_QElQu.Name = _bKb4("/VTV\029{(e\029tI\127\029*\023\029t{C")
_QElQu.Description = ""
_QElQu.AltText = ""
_QElQu.Resources = {
  {
    Type = "jpg",
    Filename = "logoIcecreamstandgraphic.jpg",
    Directives = {}
  }
}
_HWP = Wherigo.ZMedia(_Xt61)
_HWP.Id = "5ef6003d-973f-48e3-a4f7-5c3a104530a3"
_HWP.Name = _bKb4("}V{C")
_HWP.Description = ""
_HWP.AltText = ""
_HWP.Resources = {
  {
    Type = "jpg",
    Filename = "coin.jpg",
    Directives = {}
  }
}
_BCKU = Wherigo.ZMedia(_Xt61)
_BCKU.Id = "60c6277d-147f-42f2-a40f-a33593635f4b"
_BCKU.Name = _bKb4("/VTV}V{C")
_BCKU.Description = ""
_BCKU.AltText = ""
_BCKU.Resources = {
  {
    Type = "jpg",
    Filename = "logo_coin.jpg",
    Directives = {}
  }
}
_wYk = Wherigo.ZMedia(_Xt61)
_wYk.Id = "4f5acf0f-2e75-4f2c-9232-6de0b5346965"
_wYk.Name = _bKb4("(%*AA/\029")
_wYk.Description = ""
_wYk.AltText = ""
_wYk.Resources = {
  {
    Type = "jpg",
    Filename = "shuttle.jpg",
    Directives = {}
  }
}
_H7sD = Wherigo.ZMedia(_Xt61)
_H7sD.Id = "571607e6-4268-4bfc-81ee-dcb34870541b"
_H7sD.Name = _bKb4("/VTV(%*AA/\029")
_H7sD.Description = ""
_H7sD.AltText = ""
_H7sD.Resources = {
  {
    Type = "jpg",
    Filename = "logoshuttle.jpg",
    Directives = {}
  }
}
_Xt61.Id = "8dcd94fd-6a01-489b-90a4-379ff861ca80"
_Xt61.Name = "Inspektor Huber macht Urlaub"
_Xt61.Description = [[
In diesem Wherigo schluepft ihr in die Rolle Inspektor Hubers. Dieser ist ein etwas schrulliger Polizist, der sich mit dem Loesen komplizierter Faelle befasst.<BR>
<BR>
<BR>
Noch ein paar Hinweise vorab:<BR>
<BR>
- Nicht immer ist alles gleich offensichtlich, manchmal braucht es auch etwas Geduld und eine genauere Suche.<BR>
- Solltest du an einer Stelle nicht weiter kommen, kann es helfen die letzten Zonen noch einmal genau unter die Lupe zu nehmen. <BR>
- Schaue regelmaessig nach, ob neue Gegenstaende, Personen, Zonen oder auch Aufgaben vorhanden sind.<BR>
- Wenn du Gegenstaende beim genau unter die Lupe nehmen gefunden hast, vergiss nicht, sie auch in dein Inventar einzupacken.<BR>
- Ihr findet die Gegenstaende alle virtuell im Geraet und braucht bis auf den Final nichts vorort suchen.<BR>
<BR>
<BR>
Und nun viel Spass beim Loesen dieses kleinen Kriminalfalls.]]
_Xt61.Visible = true
_Xt61.Activity = "Geocache"
_Xt61.StartingLocationDescription = "Der Startpunkt ist in Berlin-Tegel"
_Xt61.StartingLocation = ZonePoint(52.585833, 13.28685, 0)
_Xt61.Version = "1.3"
_Xt61.Company = ""
_Xt61.Author = "mar-ion und DenDan"
_Xt61.BuilderVersion = "URWIGO 1.21.5528.18461"
_Xt61.CreateDate = "04/02/2011 06:40:06"
_Xt61.PublishDate = "1/1/0001 12:00:00 AM"
_Xt61.UpdateDate = "03/21/2015 09:14:35"
_Xt61.LastPlayedDate = "1/1/0001 12:00:00 AM"
_Xt61.TargetDevice = "PocketPC"
_Xt61.TargetDeviceVersion = "0"
_Xt61.StateId = "1"
_Xt61.CountryId = "2"
_Xt61.Complete = false
_Xt61.UseLogging = true
_Xt61.Icon = _7Tcg
_1y8UO = Wherigo.Zone(_Xt61)
_1y8UO.Id = "722d1170-27fa-4a8c-8a84-0c2e5a3848d7"
_1y8UO.Name = _bKb4("z\029T\029/}/*Q")
_1y8UO.Description = ""
_1y8UO.Visible = true
_1y8UO.Media = _OvX
_1y8UO.Icon = _gEk
_1y8UO.Commands = {}
_1y8UO.DistanceRange = Distance(-1, "feet")
_1y8UO.ShowObjects = "OnEnter"
_1y8UO.ProximityRange = Distance(60, "meters")
_1y8UO.AllowSetPositionTo = false
_1y8UO.Active = false
_1y8UO.Points = {
  ZonePoint(52.5778460764471, 13.2710830294304, 0),
  ZonePoint(52.5776358146223, 13.2711018048935, 0),
  ZonePoint(52.5776798229946, 13.2716033779793, 0),
  ZonePoint(52.5778574859747, 13.2714934074097, 0)
}
_1y8UO.OriginalPoint = ZonePoint(52.5777548000097, 13.2713204049282, 0)
_1y8UO.DistanceRangeUOM = "Feet"
_1y8UO.ProximityRangeUOM = "Meters"
_1y8UO.OutOfRangeName = ""
_1y8UO.InRangeName = ""
_ggB = Wherigo.Zone(_Xt61)
_ggB.Id = "16911533-e1f3-41f6-8d1d-b89354e60ba3"
_ggB.Name = _bKb4("c\127}%A}/*Q")
_ggB.Description = ""
_ggB.Visible = true
_ggB.Media = _YAEt
_ggB.Icon = _Pja
_ggB.Commands = {}
_ggB.DistanceRange = Distance(-1, "feet")
_ggB.ShowObjects = "OnEnter"
_ggB.ProximityRange = Distance(60, "meters")
_ggB.AllowSetPositionTo = false
_ggB.Active = false
_ggB.Points = {
  ZonePoint(52.5794939074563, 13.2749775969201, 0),
  ZonePoint(52.5795004269417, 13.2753531061821, 0),
  ZonePoint(52.5792657248589, 13.2755194031411, 0),
  ZonePoint(52.5792689846186, 13.2750419699364, 0)
}
_ggB.OriginalPoint = ZonePoint(52.5793822609689, 13.2752230190449, 0)
_ggB.DistanceRangeUOM = "Feet"
_ggB.ProximityRangeUOM = "Meters"
_ggB.OutOfRangeName = ""
_ggB.InRangeName = ""
_0s_an = Wherigo.Zone(_Xt61)
_0s_an.Id = "7f3a99d6-84df-487c-b883-67b0a9ef9330"
_0s_an.Name = _bKb4("u\127AVtA")
_0s_an.Description = ""
_0s_an.Visible = true
_0s_an.Media = _68eL
_0s_an.Icon = _NDbO
_0s_an.Commands = {}
_0s_an.DistanceRange = Distance(-1, "feet")
_0s_an.ShowObjects = "OnEnter"
_0s_an.ProximityRange = Distance(60, "meters")
_0s_an.AllowSetPositionTo = false
_0s_an.Active = false
_0s_an.Points = {
  ZonePoint(52.5864211286884, 13.281896355074, 0),
  ZonePoint(52.5862206857209, 13.2819446348362, 0),
  ZonePoint(52.5862581669959, 13.2822852753811, 0),
  ZonePoint(52.5864577949857, 13.2822168790512, 0)
}
_0s_an.OriginalPoint = ZonePoint(52.5863394440977, 13.2820857860856, 0)
_0s_an.DistanceRangeUOM = "Feet"
_0s_an.ProximityRangeUOM = "Meters"
_0s_an.OutOfRangeName = ""
_0s_an.InRangeName = ""
_hgZ83 = Wherigo.Zone(_Xt61)
_hgZ83.Id = "0743166e-7f76-48d6-9a85-9898f6a6a87c"
_hgZ83.Name = _bKb4("y{CI\127*\023(f\029CAt*L")
_hgZ83.Description = ""
_hgZ83.Visible = true
_hgZ83.Media = _dYEc
_hgZ83.Icon = _6cyv
_hgZ83.Commands = {}
_hgZ83.DistanceRange = Distance(-1, "feet")
_hgZ83.ShowObjects = "OnEnter"
_hgZ83.ProximityRange = Distance(60, "meters")
_hgZ83.AllowSetPositionTo = false
_hgZ83.Active = true
_hgZ83.Points = {
  ZonePoint(52.5858279452165, 13.2870609485321, 0),
  ZonePoint(52.5861000935753, 13.2868329607659, 0),
  ZonePoint(52.5857847598426, 13.2865727864914, 0),
  ZonePoint(52.5855492765831, 13.2867940687352, 0)
}
_hgZ83.OriginalPoint = ZonePoint(52.5858155188044, 13.2868151911311, 0)
_hgZ83.DistanceRangeUOM = "Feet"
_hgZ83.ProximityRangeUOM = "Meters"
_hgZ83.OutOfRangeName = ""
_hgZ83.InRangeName = ""
_o6P = Wherigo.Zone(_Xt61)
_o6P.Id = "91aa7dfa-0f66-44b0-89d5-d4eecfb5f3b3"
_o6P.Name = _bKb4("M*C(Af\029CAt*L")
_o6P.Description = ""
_o6P.Visible = true
_o6P.Media = _6cLB
_o6P.Icon = _5Kj
_o6P.Commands = {}
_o6P.DistanceRange = Distance(-1, "feet")
_o6P.ShowObjects = "OnEnter"
_o6P.ProximityRange = Distance(60, "meters")
_o6P.AllowSetPositionTo = false
_o6P.Active = false
_o6P.Points = {
  ZonePoint(52.5788468437139, 13.2786079668217, 0),
  ZonePoint(52.5788183205331, 13.2787769459896, 0),
  ZonePoint(52.5785974689913, 13.2786991619282, 0),
  ZonePoint(52.5786455511561, 13.2785073839837, 0)
}
_o6P.OriginalPoint = ZonePoint(52.5787270460986, 13.2786478646808, 0)
_o6P.DistanceRangeUOM = "Feet"
_o6P.ProximityRangeUOM = "Meters"
_o6P.OutOfRangeName = ""
_o6P.InRangeName = ""
_BooaU = Wherigo.Zone(_Xt61)
_BooaU.Id = "66244b58-61f2-4fe8-b5a4-a67e911aec4f"
_BooaU.Name = _bKb4("Z\029*\029tP\127}%\029")
_BooaU.Description = ""
_BooaU.Visible = true
_BooaU.Media = _gmv8
_BooaU.Icon = _5O6Ie
_BooaU.Commands = {}
_BooaU.DistanceRange = Distance(-1, "feet")
_BooaU.ShowObjects = "OnEnter"
_BooaU.ProximityRange = Distance(60, "meters")
_BooaU.AllowSetPositionTo = false
_BooaU.Active = false
_BooaU.Points = {
  ZonePoint(52.5861522415711, 13.286309930008, 0),
  ZonePoint(52.5862060191265, 13.2867766343766, 0),
  ZonePoint(52.586447202503, 13.286576809805, 0),
  ZonePoint(52.5863592033168, 13.2862603091412, 0)
}
_BooaU.OriginalPoint = ZonePoint(52.5862911666294, 13.2864809208327, 0)
_BooaU.DistanceRangeUOM = "Feet"
_BooaU.ProximityRangeUOM = "Meters"
_BooaU.OutOfRangeName = ""
_BooaU.InRangeName = ""
_bv17 = Wherigo.Zone(_Xt61)
_bv17.Id = "1d8ec270-5819-4826-9ed0-6105e625ea4e"
_bv17.Name = _bKb4("'\029/v\127*AVL\127A")
_bv17.Description = ""
_bv17.Visible = true
_bv17.Media = _P3Dmi
_bv17.Icon = _zD2J
_bv17.Commands = {}
_bv17.DistanceRange = Distance(-1, "feet")
_bv17.ShowObjects = "OnEnter"
_bv17.ProximityRange = Distance(60, "meters")
_bv17.AllowSetPositionTo = false
_bv17.Active = false
_bv17.Points = {
  ZonePoint(52.5877826499489, 13.2852129065209, 0),
  ZonePoint(52.5878429437485, 13.2853845678978, 0),
  ZonePoint(52.5880881919969, 13.2851351224595, 0),
  ZonePoint(52.5880254542035, 13.2849527322464, 0)
}
_bv17.OriginalPoint = ZonePoint(52.5879348099744, 13.2851713322811, 0)
_bv17.DistanceRangeUOM = "Feet"
_bv17.ProximityRangeUOM = "Meters"
_bv17.OutOfRangeName = ""
_bv17.InRangeName = ""
_XiM = Wherigo.Zone(_Xt61)
_XiM.Id = "8fcfecd2-fb5c-449c-9525-c5135a900e46"
_XiM.Name = _bKb4("z{}%\029t%\029{A")
_XiM.Description = ""
_XiM.Visible = true
_XiM.Commands = {}
_XiM.DistanceRange = Distance(-1, "feet")
_XiM.ShowObjects = "OnEnter"
_XiM.ProximityRange = Distance(60, "meters")
_XiM.AllowSetPositionTo = false
_XiM.Active = false
_XiM.Points = {
  ZonePoint(52.5787441601767, 13.2753034853154, 0),
  ZonePoint(52.5788843312949, 13.2752257012539, 0),
  ZonePoint(52.5788810715065, 13.2753705405407, 0),
  ZonePoint(52.5788158756885, 13.2753893160038, 0)
}
_XiM.OriginalPoint = ZonePoint(52.5788313596666, 13.2753222607784, 0)
_XiM.DistanceRangeUOM = "Feet"
_XiM.ProximityRangeUOM = "Meters"
_XiM.OutOfRangeName = ""
_XiM.InRangeName = ""
_uaPW = Wherigo.Zone(_Xt61)
_uaPW.Id = "91bf7703-35a5-4d60-b7b1-f16e82771e8b"
_uaPW.Name = _bKb4("Z/*\029}%A\029Cv\029t")
_uaPW.Description = ""
_uaPW.Visible = true
_uaPW.Media = _J9M
_uaPW.Icon = _hqF
_uaPW.Commands = {}
_uaPW.DistanceRange = Distance(-1, "feet")
_uaPW.ShowObjects = "OnEnter"
_uaPW.ProximityRange = Distance(60, "meters")
_uaPW.AllowSetPositionTo = false
_uaPW.Active = false
_uaPW.Points = {
  ZonePoint(52.5791206653046, 13.2775028967076, 0),
  ZonePoint(52.5790000536242, 13.2774412059002, 0),
  ZonePoint(52.5789519718482, 13.2777067445927, 0),
  ZonePoint(52.5790636192809, 13.2777510010415, 0)
}
_uaPW.OriginalPoint = ZonePoint(52.5790340775145, 13.2776004620605, 0)
_uaPW.DistanceRangeUOM = "Feet"
_uaPW.ProximityRangeUOM = "Meters"
_uaPW.OutOfRangeName = ""
_uaPW.InRangeName = ""
_xX9XA = Wherigo.Zone(_Xt61)
_xX9XA.Id = "5d1cceef-7df5-4407-8e56-fadccfc5a862"
_xX9XA.Name = _bKb4("Z/*\029}%A\029Cv\029t")
_xX9XA.Description = ""
_xX9XA.Visible = true
_xX9XA.Media = _J9M
_xX9XA.Icon = _hqF
_xX9XA.Commands = {}
_xX9XA.DistanceRange = Distance(-1, "feet")
_xX9XA.ShowObjects = "OnEnter"
_xX9XA.ProximityRange = Distance(60, "meters")
_xX9XA.AllowSetPositionTo = false
_xX9XA.Active = false
_xX9XA.Points = {
  ZonePoint(52.5783236441327, 13.2770375334435, 0),
  ZonePoint(52.5782356286363, 13.276946338337, 0),
  ZonePoint(52.578167172017, 13.2771394573861, 0),
  ZonePoint(52.5782617073204, 13.2773003899269, 0)
}
_xX9XA.OriginalPoint = ZonePoint(52.5782470380266, 13.2771059297734, 0)
_xX9XA.DistanceRangeUOM = "Feet"
_xX9XA.ProximityRangeUOM = "Meters"
_xX9XA.OutOfRangeName = ""
_xX9XA.InRangeName = ""
_EH0Zk = Wherigo.Zone(_Xt61)
_EH0Zk.Id = "f271abb1-0ba1-4638-b1ce-ac309945e5d8"
_EH0Zk.Name = _bKb4("Z/*\029}%A\029Cv\029t")
_EH0Zk.Description = ""
_EH0Zk.Visible = true
_EH0Zk.Media = _J9M
_EH0Zk.Icon = _hqF
_EH0Zk.Commands = {}
_EH0Zk.DistanceRange = Distance(-1, "feet")
_EH0Zk.ShowObjects = "OnEnter"
_EH0Zk.ProximityRange = Distance(60, "meters")
_EH0Zk.AllowSetPositionTo = false
_EH0Zk.Active = false
_EH0Zk.Points = {
  ZonePoint(52.5784026949371, 13.2787219607048, 0),
  ZonePoint(52.5785787250824, 13.2784577631169, 0),
  ZonePoint(52.5783415731937, 13.2783571802788, 0)
}
_EH0Zk.OriginalPoint = ZonePoint(52.5784409977377, 13.2785123013668, 0)
_EH0Zk.DistanceRangeUOM = "Feet"
_EH0Zk.ProximityRangeUOM = "Meters"
_EH0Zk.OutOfRangeName = ""
_EH0Zk.InRangeName = ""
_fQN = Wherigo.Zone(_Xt61)
_fQN.Id = "12596534-293c-4012-b623-40aa5bdfcdf9"
_fQN.Name = _bKb4("\016\029t{}%A")
_fQN.Description = ""
_fQN.Visible = true
_fQN.Commands = {}
_fQN.DistanceRange = Distance(-1, "feet")
_fQN.ShowObjects = "OnEnter"
_fQN.ProximityRange = Distance(60, "meters")
_fQN.AllowSetPositionTo = false
_fQN.Active = false
_fQN.Points = {
  ZonePoint(52.578548818216, 13.2691903891243, 0),
  ZonePoint(52.5784088625221, 13.2690995973667, 0),
  ZonePoint(52.5783754132347, 13.2694103773414, 0),
  ZonePoint(52.5785334709569, 13.2694660628678, 0)
}
_fQN.OriginalPoint = ZonePoint(52.5784666412324, 13.2692916066751, 0)
_fQN.DistanceRangeUOM = "Feet"
_fQN.ProximityRangeUOM = "Meters"
_fQN.OutOfRangeName = ""
_fQN.InRangeName = ""
_4BlLr = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _hgZ83})
_4BlLr.Id = "9f4bb5e7-a450-47f3-b36c-c5a6e0912933"
_4BlLr.Name = _bKb4("Z/\029{(}%\029t")
_4BlLr.Description = _bKb4(":Vt3+{t3(A\029%A3\029{C3C\029AA\029t3:\029tI\127\029*\023\029t3%{CA\029t3\029{C\029t3T*A3(VtA{\029tA\029C30*t(A\0203*Cv3Z/\029{(}%A%\029I\029j3+*3I\127CC(A3\029{C{T\0293MV\029(A/{}%I\029{A\029C3\029CAv\029}I\029Cx3v{\0293+{t3v\127(30\127((\029t3{L3G*Cv3f*(\127LL\029C3/\127*\023\029C3/\127((\029Cj36\0169K-Q\029t3C\127}%v\029L3+*3(V3\127*(T{\029Q{T3f*3G{AA\127T3T\029T\029((\029C3%\127(Ax3L\029tI(A3+*x3v\127((3+*3\029{T\029CA/{}%3T\127t3C{}%A(3L\029%t3%\029t*CA\029t3Q\029IVLL(Aj3+V}%3v\127CC3\029CAv\029}I(A3+*x3v\127((3\029(3%{\029t3e\029tv\127LLA3T*A3\127*((\029%\029Cv\02930*\029t(A}%\029C3T{QAj36\0169K:{\029//\029{}%A3P{t(A3+*3i\1273vV}%3CV}%3(}%P\127}%~36\0169K\\v\029t3e{\029//\029{}%A3I\127CC(A3+*3({\0293\127*}%3\029{C\023\127}%3(\027\127\029A\029t3\029((\029C~")
_4BlLr.Visible = true
_4BlLr.Media = _aO3E
_4BlLr.Icon = _sDZO
_4BlLr.Commands = {
  _ksSu = Wherigo.ZCommand({
    Text = _bKb4(":\029tI\127\029*\023\029t3\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_4BlLr.Commands._ksSu.Custom = true
_4BlLr.Commands._ksSu.Id = "e3a50e49-9b83-4f2b-b4a0-100a91f3e4c5"
_4BlLr.Commands._ksSu.WorksWithAll = true
_4BlLr.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4BlLr.Gender = "Male"
_4BlLr.Type = "NPC"
_nIIaJ = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _hgZ83})
_nIIaJ.Id = "7c4dd51e-5b66-429c-96b4-ea8bc6959e5f"
_nIIaJ.Name = _bKb4("z\027{\029/P\127t\029C/\127v\029C")
_nIIaJ.Description = _bKb4("M{Cv\029tjjj6\0169K*\029Q\029t\127//3M{Cv\029tjjj6\0169KPV%{C3v\127(3-*T\0293t\029{}%A3M\024l+y9jjj6\0169K6\0169K+*3*\029Q\029t/\029T(A3VQ3+*3%{\029t3(}%/\029*C{T(A3P{\029v\029t3t\127*(t\029CC(Ax3v\029CC3P\127(3+*3CV}%3L\029%t3%\127((A3\127/(3G\029C(}%\029CL\127((\029Cx3({Cv3G\127((\029C3\127C3M\024l+y9l.6\0169K6\0169K+{\0293IV\029CCA\029C3i\1273(VC(A3P\127(3\023*\029t3\127C(A\029}I\029Cv\0293M\029{L\0293L{A3({}%3%\029t*L(}%/\029\027\027\029Cj6\0169K+*3vt\029%(A3v{}%3\127*\0233v\029L3-Q(\127Af3*Ljjj6\0169Kjjjj3*Cv3\029CAv\029}I(A3{C3\029{C\029t3t*%{T\029C3y}I\0293\029{C\029C3z\027{\029/\127*AVL\127A\029Cx3v\029t3+\029{C\0293-*\023L\029tI(\127LI\029{A3\127*\0233({}%3f{\029%Aj6\0169K+*3Q/{}I(A3v*t}%3v{\0293'/\127((}%\029{Q\0293*Cv3\029CAv\029}I(A3\029{C3\027\127\127t3'\029T\029C(A\127\029Cv\0293{C3v\029L3-*AVL\127A\029Cx3v{\0293+*3(}%VC3{LL\029t3T\029tC\0293T\029%\127QA3%\127\029AA\029(Aj3-Q\029t3P{//(A3+*3+\029{C3'/*\029}I3P{tI/{}%3e\029t(*}%\029C~")
_nIIaJ.Visible = true
_nIIaJ.Media = _ybW
_nIIaJ.Icon = _pIQ
_nIIaJ.Commands = {
  _2LO = Wherigo.ZCommand({
    Text = _bKb4("-*AVL\127A3Q\029C*Af\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_nIIaJ.Commands._2LO.Custom = true
_nIIaJ.Commands._2LO.Id = "516d0a72-7e31-44f5-84a8-95e1852475b5"
_nIIaJ.Commands._2LO.WorksWithAll = true
_nIIaJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nIIaJ.Gender = "Male"
_nIIaJ.Type = "NPC"
_CK6 = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _hgZ83})
_CK6.Id = "b3c11929-1305-483c-95d4-e9652a1fc076"
_CK6.Name = _bKb4("y{(e\029tI\127*\023")
_CK6.Description = _bKb4("y{C3y{((A\127Cv.36\0169K6\0169K+\1273/\127\029*\023A3v{t3vV}%3T/\127AA3(}%VC3P{\029v\029t3v\127(30\127((\029t3{L3G*Cv3f*(\127LL\029Cj3zV3\029{C3y{(3\127/(3l\127}%A{(}%x3%\127\029AA\0293(}%VC3P\127(.6\0169K6\0169K+*3(}%\127*(A3v{t3v\029C3zA\127Cv3T\029C\127*\029t3\127C3*Cv3Q\029L\029tI(A3\029{C3z}%{/v3L{A3v\029t3-*\023(}%t{\023A\0176\0169K6\0169KYl*t3v{\029(\02930V}%\029.3G*AA\029tL{/}%\029{(\127IA{VC.6\0169K\018\029v\029(3G{/}%\029{(3{(A3\127*(3G*AA\029tL{/}%3%\029tT\029(A\029//A.6\0169KzV3T\029(*Cv3%\127Q\029C3z{\0293CV}%3C{\0293\029{C3y{(3T\029T\029((\029C.6\0169K|Cv3eVt3\127//\029L\0173-CA{IV\029t\027\029t3T\029T\029C3e{\029/\0293Mt\127CI%\029{A\029C3{CI/*({e\029.Y")
_CK6.Visible = true
_CK6.Media = _uoz5I
_CK6.Icon = _QElQu
_CK6.Commands = {
  _ExbVi = Wherigo.ZCommand({
    Text = _bKb4("y{(3I\127*\023\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_CK6.Commands._ExbVi.Custom = true
_CK6.Commands._ExbVi.Id = "c90228f6-b821-422e-b266-eb71e897e3f0"
_CK6.Commands._ExbVi.WorksWithAll = true
_CK6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_CK6.Gender = "Male"
_CK6.Type = "NPC"
_D0GCK = Wherigo.ZCharacter(_Xt61)
_D0GCK.Id = "af064801-ea4a-4c8d-b5df-43d466111238"
_D0GCK.Name = _bKb4("+tj3^\127*(\029t")
_D0GCK.Description = ""
_D0GCK.Visible = true
_D0GCK.Media = _eXSH
_D0GCK.Icon = _89f
_D0GCK.Commands = {
  _kITM = Wherigo.ZCommand({
    Text = _bKb4("\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_D0GCK.Commands._kITM.Custom = true
_D0GCK.Commands._kITM.Id = "5098a4be-e0fe-468d-bcfc-104dc53a5a43"
_D0GCK.Commands._kITM.WorksWithAll = true
_D0GCK.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_D0GCK.Gender = "Male"
_D0GCK.Type = "NPC"
_eg3q = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _hgZ83})
_eg3q.Id = "e0b58593-d9f8-4bb4-816e-3c2bd162a4d1"
_eg3q.Name = _bKb4("+tVT\029t{\029")
_eg3q.Description = _bKb4("9\127({\029tI/{CT\029Cx3+*(}%T\029/x3ZVAV\029CAP{}I/\029tx3+*\023AI\029tf\029Cx37\127t\023*\029L(x30{Cv\029/Cx3+\029Vx3z%\127L\027VVx3z}%L{CI*A\029C({/{\029Cx3Z\029*}%AA*\029}%\029tx3\\(A\029t\127tA{I\029/x3b\127IAV(\029\023t\029{\0293G*\029(/{t{\029T\029/x3z}%C*//\029tx3MV\029tC\029t3i\029v\029t3-tA3\019f*L3y((\029C3*Cv3\127*}%3{C3M{((\029C\fx30\127AA\029\027\127v(x3+\127L\029C%NT{\029C\029\027tVv*IA\029jjjjjjjj6\0169K6\0169K+\127(3-CT\029QVA3v{\029(\029(3b\127v\029C(3*\029Q\029t\023Vtv\029tA3v{}%3(}%/{}%AP\029Tj3n*L3'/*\029}I3(A\029%A3T\029t\127v\0293\029{C\0293:\029tI\127\029*\023\029t{C3C\127%\0293\127L3y{CT\127CT3*Cv3\023*\029//A3bV}I3\0203bV}I3\0203+V(\029C3{C3v\127(30\127t\029Ct\029T\127/j6\0169K6\0169K+*3*\029Q\029tP{Cv\029(A3v\029{C\0293zVf{V\027%VQ{\0293*Cv3(\027t{}%(A3({\0293\127Cx3VQ3({\0293v{t3\029{C\029C3(\027\029f{\029//\029C3-tA{I\029/3\127*(3v\029L3zVtA{L\029CA3\029L\027\023\029%/\029C3I\127CCj")
_eg3q.Visible = true
_eg3q.Media = _Jr9X
_eg3q.Icon = _SZWg3
_eg3q.Commands = {
  _BYM5o = Wherigo.ZCommand({
    Text = _bKb4(":\029tI\127\029*\023\029t{C3\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_eg3q.Commands._BYM5o.Custom = true
_eg3q.Commands._BYM5o.Id = "ab6298bf-ced7-4904-90d6-826aa76ff00c"
_eg3q.Commands._BYM5o.WorksWithAll = true
_eg3q.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_eg3q.Gender = "Female"
_eg3q.Type = "NPC"
__KA = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _0s_an})
__KA.Id = "55c78c16-0a7c-4e86-8aed-b3f79b941d21"
__KA.Name = _bKb4("^\127*\027AIVL{((\127t3yt/P\029{C")
__KA.Description = ""
__KA.Visible = true
__KA.Media = _0izE
__KA.Icon = _JYR
__KA.Commands = {
  _rRXrj = Wherigo.ZCommand({
    Text = _bKb4("\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
__KA.Commands._rRXrj.Custom = true
__KA.Commands._rRXrj.Id = "09c6b95a-fb3d-4c6e-9f18-f6f36f5e3fc7"
__KA.Commands._rRXrj.WorksWithAll = true
__KA.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__KA.Gender = "Male"
__KA.Type = "NPC"
_KNFo = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _ggB})
_KNFo.Id = "0398e133-3eed-4fd8-96de-49add8013a65"
_KNFo.Name = _bKb4("0\127}%%*Cv")
_KNFo.Description = ""
_KNFo.Visible = false
_KNFo.Media = _gLzns
_KNFo.Icon = _U8HFT
_KNFo.Commands = {
  _fBf = Wherigo.ZCommand({
    Text = _bKb4("\023*\029AA\029tC"),
    CmdWith = true,
    Enabled = false,
    EmptyTargetListText = _bKb4("+*3%\127(A3C{}%A(x3P\127(3v*3e\029t\023*\029AA\029tC3IV\029CCA\029(A")
  })
}
_KNFo.Commands._fBf.Custom = true
_KNFo.Commands._fBf.Id = "6c8da618-7dd0-4e21-88f9-bb84601b0961"
_KNFo.Commands._fBf.WorksWithAll = false
_KNFo.Commands._fBf.WorksWithListIds = {
  "3203638d-11f0-40bb-a349-19d0c3f4d146"
}
_KNFo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_KNFo.Gender = "Male"
_KNFo.Type = "NPC"
_t4bNx = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _ggB})
_t4bNx.Id = "954c1273-6f47-4280-a121-36f407d753b3"
_t4bNx.Name = _bKb4("\016j39\029A{(/{A")
_t4bNx.Description = ""
_t4bNx.Visible = false
_t4bNx.Media = _LvPm
_t4bNx.Icon = _mZT2
_t4bNx.Commands = {
  _cNF8 = Wherigo.ZCommand({
    Text = _bKb4("\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_t4bNx.Commands._cNF8.Custom = true
_t4bNx.Commands._cNF8.Id = "60e36b27-1894-48b4-aa0e-987a592f5739"
_t4bNx.Commands._cNF8.WorksWithAll = true
_t4bNx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_t4bNx.Gender = "Male"
_t4bNx.Type = "NPC"
_joD = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _hgZ83})
_joD.Id = "815eeae5-becf-4794-986c-8b3a276f3f8c"
_joD.Name = _bKb4("'\029V}\127}%{CT\020z%V\027")
_joD.Description = _bKb4("0VPjjj6\0169K+\127(3({\029%A3e\029tv\127LLA3{CA\029t\029((\127CA3\127*(j6\0169K+{\029(\029t3b\127v\029C3f{\029%A3v{}%3L\127T{(}%3\127Cj6\0169K6\0169K^{\029t3(}%\029{CA3\127//\029(3\127*\0233^V}%T/\127Cf3\027V/{\029tA3f*3(\029{C3*Cv3eVt3\127//\029L3({\029%(A3+*3LVL\029CA\127C3I\029{C\0293G\029C(}%\029C3*Cv3\127L3\127//\029tQ\029(A\029C3{(A\0173I\029{C\0293I/\029{C\029Cx3C\127x3P{\0293%\029{((\029C3v{\029jjj3\127}%i\127jjjM\024l+y93{C3v\029t3l\127\029%\0293v{\029(\029(3b\127v\029C(x3\127/(V3t\029{C3L{A3+{t.6\0169K6\0169K+\127CC3\029t{CC\029t(A3+*3+{}%3\127C3v\029C3\023/*\029}%A{T\029C3GV\029tv\029tx3v\029L3v*3LVL\029CA\127C3\127*\0233v\029t3z\027*t3Q{(Aj3+{\029(\029t3(V//3i\1273\029{C3'\029V}\127}%\029t3L{A3b\029{Q3*Cv3z\029\029/\0293(\029{Cj3:{\029//\029{}%A3I\127CC(A3v*3%{\029t3\029{C3P\029C{T3L\029%t3*\029Q\029t3(\029{C3L\029tIP*\029tv{T\029(3^VQQN3\029t\023\127%t\029Cj")
_joD.Visible = true
_joD.Media = _rc3v
_joD.Icon = _Jas
_joD.Commands = {
  __7bS = Wherigo.ZCommand({
    Text = _bKb4("*L(\029%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _DVC = Wherigo.ZCommand({
    Text = _bKb4("-*(t*\029(A*CT3I\127*\023\029C"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _hFEx = Wherigo.ZCommand({
    Text = _bKb4("&V{C3I\127*\023\029C"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _8vw = Wherigo.ZCommand({
    Text = _bKb4("z%*AA/\0293I\127*\023\029C"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_joD.Commands.__7bS.Custom = true
_joD.Commands.__7bS.Id = "354081cf-7581-485e-af4a-7917e93627be"
_joD.Commands.__7bS.WorksWithAll = true
_joD.Commands._DVC.Custom = true
_joD.Commands._DVC.Id = "263c640a-7659-4724-9576-1254e5b964cc"
_joD.Commands._DVC.WorksWithAll = true
_joD.Commands._hFEx.Custom = true
_joD.Commands._hFEx.Id = "50553745-525d-416e-ae74-cc619f62354e"
_joD.Commands._hFEx.WorksWithAll = true
_joD.Commands._8vw.Custom = true
_joD.Commands._8vw.Id = "adda36f8-5594-4a18-9c39-b18d0a41541b"
_joD.Commands._8vw.WorksWithAll = true
_joD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_joD.Gender = "Male"
_joD.Type = "NPC"
_67l9 = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _1y8UO})
_67l9.Id = "e69213b1-b133-4865-b846-1aa419e4dfb5"
_67l9.Name = _bKb4("G{((3't\029C\127v{\029t")
_67l9.Description = ""
_67l9.Visible = true
_67l9.Media = _240K4
_67l9.Icon = _RnjTx
_67l9.Commands = {
  _cypes = Wherigo.ZCommand({
    Text = _bKb4("\127C(\027t\029}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_67l9.Commands._cypes.Custom = true
_67l9.Commands._cypes.Id = "d0d9edcd-b4a8-4963-985c-5d0070716b64"
_67l9.Commands._cypes.WorksWithAll = true
_67l9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_67l9.Gender = "Male"
_67l9.Type = "NPC"
_6yvj = Wherigo.ZCharacter({Cartridge = _Xt61, Container = _o6P})
_6yvj.Id = "869ea831-eaed-4e71-b138-aa010e87f218"
_6yvj.Name = _bKb4("Zt\127CI3lj3zA\029{C")
_6yvj.Description = ""
_6yvj.Visible = true
_6yvj.Media = _J9M
_6yvj.Icon = _hqF
_6yvj.Commands = {}
_6yvj.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6yvj.Gender = "Male"
_6yvj.Type = "NPC"
_pgd = Wherigo.ZItem(_Xt61)
_pgd.Id = "e167fa7c-9389-4dfd-8d14-5620cd51d60f"
_pgd.Name = _bKb4("b*\027\029")
_pgd.Description = _bKb4("n*3P\127(3(V3\029{C\0293b*\027\0293\127//\029(3T*A3(\029{C3I\127CCjjj6\0169Kn\029%\029CC\127\029T\029/3(}%P\127tf3\023\127\029tQ\029Cjjj6\0169K+{\0293M/{L\127\029tP\127\029tL*CT3eVt\127C3At\029{Q\029Cjjj6\0169K-\029\027\023\029/3Qt\127A\029Cjjj6\0169K6\0169Kjjj3Vv\029t3T\127Cf3\029{C\023\127}%3e\029t(}%{\029v\029C(A\0293\\tA\0293\127*\023(3T\029C\127*\029(A\0293*CA\029t3v{\0293b*\027\0293f*3C\029%L\029Cj6\0169K6\0169K+{\029(\029(3y=\029L\027/\127t3{(A3\023\127(A3(V3T*Ax3P{\0293v\029{C\0293\029{T\029C\029x3v{\0293v*3i\1273\127*\023Tt*Cv3v\029{C\029(3|t/\127*Q\029(3vV}%3L\127/3f*3^\127*(\0293T\029/\127((\029C3%\127(Aj")
_pgd.Visible = true
_pgd.Media = _x9U5
_pgd.Icon = _Fpli
_pgd.Commands = {
  _5GIBJ = Wherigo.ZCommand({
    Text = _bKb4("*CA\029t(*}%\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_pgd.Commands._5GIBJ.Custom = true
_pgd.Commands._5GIBJ.Id = "641f4093-3b5b-4674-8d07-102d1fdb3331"
_pgd.Commands._5GIBJ.WorksWithAll = true
_pgd.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_pgd.Locked = false
_pgd.Opened = false
_3_QL = Wherigo.ZItem({Cartridge = _Xt61, Container = Player})
_3_QL.Id = "527a8243-9f58-45c6-9ca6-3027f2e05ca3"
_3_QL.Name = _bKb4("'\029/v")
_3_QL.Description = _bKb4("y{C3(}%V\029C\029(3b\029v\029tQ\029*A\029/}%\029C3C\029CC(A3+*3+\029{C3\029{T\029Cj3+\127(3%\127(A3+*3*\029Q\029t3v{\0293\018\127%t\0293{LL\029t3T*A3T\029\027\023/\029TAj3|Cv3i\127x3P\127(3(V//3L\127C3v\1273(\127T\029Cx3v*3%\127(A3v\1273\029AP\127(3(}%VC3\023\127(A3\029{Cf{T\127tA{T\029(3{C3v\029{C\029t3^\127Cvx3v\029CC3P\029t3e\029tf{}%A\029A3%\029*Af*A\127T\0293CV}%3\127*\0233v{\029(\0293IVL{(}%\029C3C\029*LVv{(}%\029C3'\029/vQV\029t(\029C3L{A3v\029C3e{\029/\029C3y{C(A\029}I\023\127\029}%\029tCj36\0169K6\0169K-/(3v*3v\029{C\029C3'\029/vQ\029*A\029/3v*t}%(*}%(Ax3(A\029//(A3+*3\023\029(Ax3v\127((3+*3CV}%3W\0063y*tV3Q\029{3+{t3%\127(Aj")
_3_QL.Visible = true
_3_QL.Media = _hfx
_3_QL.Icon = _aoT
_3_QL.Commands = {}
_3_QL.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3_QL.Locked = false
_3_QL.Opened = false
_L3Ot = Wherigo.ZItem(_Xt61)
_L3Ot.Id = "6ef50090-36cc-43e5-bbef-d0a17bcc4cbe"
_L3Ot.Name = _bKb4("0\127((\029t\027{(AV/\029")
_L3Ot.Description = _bKb4("G\029{C3l\127L\0293{(A3^*Q\029tjjjj6\0169K\018\127L\029(3^*Q\029tjjj6\0169K6\0169K|Cv3v\127(3{(A3L\029{C\0293b\029Q\029C(e\029t({}%\029t*CT\0176\0169KM\127/{Q\029t\0173\006x 3b{A\029t6\0169KuV\029v/{}%3\023*\029t3\127//\0293M\029tf\029C3{CC\029t%\127/Q3eVC3W3G\029A\029t6\0169K6\0169K-/(V3C{LL3+{}%3eVt3L{t3{C3\127}%A.6\0169K6\0169K+{\029(\029(3GVv\029//3\127\029%C\029/A3v\029t3Q\029t*\029%LA\029C30\127/A%\029t377Mx3L{A3v\029L3|CA\029t(}%{\029vx3v\127((3v{\0293b\127v*CT3*CA\029tP\029T(3T\029(}%*\029AA\029/A3*Cv3C{}%A3T\029t*\029%tA3P{tvj")
_L3Ot.Visible = true
_L3Ot.Media = _AV4_
_L3Ot.Icon = _O3S
_L3Ot.Commands = {}
_L3Ot.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_L3Ot.Locked = false
_L3Ot.Opened = false
_nc00 = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_nc00.Id = "5e717817-d4fc-43d6-8030-541216d942a8"
_nc00.Name = _bKb4("b\029{}%\029")
_nc00.Description = _bKb4("uVAx3i\1273\029{Cv\029*A{T3AVAj6\0169Kn*L{Cv\029(A3Qt\127*}%A3({}%3v{\029(\029t3G\127CC3I\029{C\0293zVtT\029C3v\127t*\029Q\029t3f*3L\127}%\029Cx3v\127((3v{\0293Zt{(V\029t\0293\029{C\02930V}%\0293/\127CT3(At\029{I\029Cj")
_nc00.Visible = true
_nc00.Commands = {
  _8zD = Wherigo.ZCommand({
    Text = _bKb4("Q\029At\127}%A\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_nc00.Commands._8zD.Custom = true
_nc00.Commands._8zD.Id = "8bcb7391-d4cf-4f5f-a848-85c9997f5b26"
_nc00.Commands._8zD.WorksWithAll = true
_nc00.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_nc00.Locked = false
_nc00.Opened = false
_IUk = Wherigo.ZItem(_Xt61)
_IUk.Id = "3203638d-11f0-40bb-a349-19d0c3f4d146"
_IUk.Name = _bKb4("0*t(A")
_IUk.Description = _bKb4("0*t(A~6\0169K9{Cv(\020&*ttNP*t(A~6\0169K'\127Q(3v\1273C{}%A3C\029*/{}%3\029{C\029C3Z\127//x3Q\029{3v\029L3\029{C\029t3v\127t\127C3T\029(AVtQ\029C3{(A~6\0169K6\0169K-}%3\029T\127/3v\029CI(A3v*3v{tj30*t(A3I\127CC3L\127C3C{\0293T\029C*T3\029((\029C.")
_IUk.Visible = true
_IUk.Media = _sQPJA
_IUk.Icon = _bRn
_IUk.Commands = {
  _rX1 = Wherigo.ZCommand({
    Text = _bKb4("\029((\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_IUk.Commands._rX1.Custom = true
_IUk.Commands._rX1.Id = "11b85e7e-e153-4a61-b1a6-94739b6c4d80"
_IUk.Commands._rX1.WorksWithAll = true
_IUk.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_IUk.Locked = false
_IUk.Opened = false
_OMz = Wherigo.ZItem({Cartridge = _Xt61, Container = Player})
_OMz.Id = "5efd466e-55c1-4974-8fa4-8ce43aef1a03"
_OMz.Name = _bKb4("I/{CT\029/Cv\029(3^\127CvN")
_OMz.Description = _bKb4("1*\127vt\127A{(}%x3*C%\127Cv/{}%3*Cv3t{\029(\029CTtV((j6\0169K6\0169K\018\127x3L\127C3IV\029CCA\0293\029(3\127*}%3\127/(3u\029/\029\023VCf\029//\0293Q\029f\029{}%C\029Cx3v\029CC3\029{C\0293T\029P{((\0293-\029%C/{}%I\029{A3{(A3v*t}%\127*(3eVt%\127Cv\029Cj36\0169Ky(3(}%\029{CA3v\127(3GVv\029//3\023*\029t3v\127(3\029t(A\0293^\127CvN3T\029P\029(\029C3f*3(\029{Cx3(V3\127/A3*Cv3*C\023V\029tL{T3P{\0293v{\029(\029(3'\029t\127\029A3{(Aj6\0169K6\0169K-Q\029t3\029(3\023*CIA{VC{\029tA3C\127}%3P{\0293eVt3A\127v\029//V(x3%\127A3%\127/A3I\029{C\0293AV//\029C3n*(\127Af\023*CIA{VC\029Cx3Vv\029t3\024CA\029tC\029Af*T\127CT3Vv\029t3T\127t3'\029V}\127}%{CT(V\023AP\127t\029x3\127Q\029t3PVf*3L\127C3(VP\127(3Qt\127*}%Ax3%\127(A3v*3\029%3CV}%3C{\0293e\029t(A\127Cv\029Cj6\0169K6\0169K\024C3v\029{C\029C3/\029AfA\029C3ytL{AA/*CT(\023\127\029//\029C3%\127A3\029(3v{t3\127*\0233i\029v\029C3Z\127//3(\029%t3T*A\0293+{\029C(A\0293T\029/\029{(A\029Aj6\0169K")
_OMz.Visible = true
_OMz.Media = _R_v
_OMz.Icon = _TQHUh
_OMz.Commands = {
  _UyCk = Wherigo.ZCommand({
    Text = _bKb4("-Ct*\0233\127CC\029%L\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _KDTU = Wherigo.ZCommand({
    Text = _bKb4("zGz3/\029(\029C"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _VbM = Wherigo.ZCommand({
    Text = _bKb4("\127Ct*\023\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_OMz.Commands._UyCk.Custom = true
_OMz.Commands._UyCk.Id = "3039d591-12cd-44be-90e5-7b8e5db41bee"
_OMz.Commands._UyCk.WorksWithAll = true
_OMz.Commands._KDTU.Custom = true
_OMz.Commands._KDTU.Id = "a6a7967d-21f4-433e-8684-371a98848f28"
_OMz.Commands._KDTU.WorksWithAll = true
_OMz.Commands._VbM.Custom = true
_OMz.Commands._VbM.Id = "d076282e-8521-4dfb-8046-d9164f750837"
_OMz.Commands._VbM.WorksWithAll = true
_OMz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_OMz.Locked = false
_OMz.Opened = false
_niey9 = Wherigo.ZItem({Cartridge = _Xt61, Container = Player})
_niey9.Id = "0271ff25-40f6-40fa-bb52-5a76f2a6c43a"
_niey9.Name = _bKb4("zA\127vA\027/\127C")
_niey9.Description = _bKb4("9\029T\029/L\127\029(({T3T\029Q*\029T\029/A3*Cv3{C3ZV/{\0293e\029t\027\127}IAx3%{/\023A3\029{C\029L3(V3\029{C37/\127C3*CT\029L\029{C3P\029{A\029tx3P\029CC3L\127C3\029AP\127(3{C3v\029t3TtV((\029C3zA\127vA3(*}%Aj6\0169KG\127C3L*((3C*t3\127*\023\027\127((\029Cx3v\127((3i\029v\0293y}I\0293\029=\127IA3\127*\0233v\029t3\127Cv\029t\029C3/{\029TA3Q\029{L3n*(\127LL\029C\023\127/A\029Cj6\0169K6\0169K0\029CC3\024%t3\029{C\0293nVC\0293f*t3n\029{A3C{}%A3Qt\127*}%Ax3(}%\127/A\029A3v{\029(\0293*\029Q\029t3v{\0293-IA{VC3\127*(3Vv\029t3Q\029{3\016\029v\127t\0233P{\029v\029t3\029{Cj3|L(V3P\029C{T\029t3nVC\029C3\127IA{e3({Cvx3v\029(AV3(A\127Q{/\029t3I\127CC3P\029{A\029t3\029tL{AA\029/A3P\029tv\029Cj")
_niey9.Visible = true
_niey9.Media = _biW
_niey9.Icon = _3Ant
_niey9.Commands = {
  _fub = Wherigo.ZCommand({
    Text = _bKb4("M\127*\023%\127*("),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _SQyZT = Wherigo.ZCommand({
    Text = _bKb4("z\029T\029/I/*Q"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _oc6 = Wherigo.ZCommand({
    Text = _bKb4("c\127}%AI/*Q"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _DOG = Wherigo.ZCommand({
    Text = _bKb4("u\127AVtA"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _8x8Uw = Wherigo.ZCommand({
    Text = _bKb4("Z\029*\029tP\127}%\029"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _0iSy = Wherigo.ZCommand({
    Text = _bKb4("'\029/v\127*AVL\127A"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  }),
  _SnpP = Wherigo.ZCommand({
    Text = _bKb4("M*C(Af\029CAt*L"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_niey9.Commands._fub.Custom = true
_niey9.Commands._fub.Id = "30b9fb65-972c-4d61-a0db-3b813a6adfc6"
_niey9.Commands._fub.WorksWithAll = true
_niey9.Commands._SQyZT.Custom = true
_niey9.Commands._SQyZT.Id = "34aac598-2b30-457b-a621-1f0764777618"
_niey9.Commands._SQyZT.WorksWithAll = true
_niey9.Commands._oc6.Custom = true
_niey9.Commands._oc6.Id = "c6c2a412-233b-48e7-8380-b0fb92ae7340"
_niey9.Commands._oc6.WorksWithAll = true
_niey9.Commands._DOG.Custom = true
_niey9.Commands._DOG.Id = "591f5be7-2999-4aee-8f20-1fc95474fb50"
_niey9.Commands._DOG.WorksWithAll = true
_niey9.Commands._8x8Uw.Custom = true
_niey9.Commands._8x8Uw.Id = "20f50ec1-b005-4418-b9c7-c6f6e5850131"
_niey9.Commands._8x8Uw.WorksWithAll = true
_niey9.Commands._0iSy.Custom = true
_niey9.Commands._0iSy.Id = "25a7ebdf-abc9-410f-b6f9-45baaf44c879"
_niey9.Commands._0iSy.WorksWithAll = true
_niey9.Commands._SnpP.Custom = true
_niey9.Commands._SnpP.Id = "5eb99220-a351-4ac0-80bb-7b0fcfb803b7"
_niey9.Commands._SnpP.WorksWithAll = true
_niey9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_niey9.Locked = false
_niey9.Opened = false
_sAx = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_sAx.Id = "f1ac03ab-2cb7-47f1-b5bc-38ac0cdb3d0f"
_sAx.Name = _bKb4("M\127L{C")
_sAx.Description = _bKb4("z}%P\127tf\029t3G\127LVt3e\029tI/\029{v\029A3v{\0293\024CC\029C(\029{A\0293v{\029(\029(3CVQ/\029C3M\127L{C(j3+V}%3Q\029{3T\029C\127*\029t\029t3\016\029At\127}%A*CT3(A\029//(A3v*3\023\029(Ax3v\127((3v\029t3G\127LVt3\029{T\029CA/{}%3P\029{((3{(Aj36\0169K0\029t3C{LLA3v\029CC3P\029{((\0293G\127A\029t{\127/{\029C3*L3\029{C\029C3M\127L{C3\024llyl3v\127L{A3f*3e\029tI/\029{v\029C~~~")
_sAx.Visible = false
_sAx.Commands = {
  _DSlO_ = Wherigo.ZCommand({
    Text = _bKb4("Q\029At\127}%A\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_sAx.Commands._DSlO_.Custom = true
_sAx.Commands._DSlO_.Id = "e2f80786-2da9-4910-ac8a-645ed900a146"
_sAx.Commands._DSlO_.WorksWithAll = true
_sAx.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_sAx.Locked = false
_sAx.Opened = false
_1ThD = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_1ThD.Id = "5edb60c7-4838-42a2-b5bd-c421b19ca9ad"
_1ThD.Name = _bKb4("G\029((\029t")
_1ThD.Description = _bKb4("y{C3GVtv(v{CT.36\0169K\019\018\1273v\127(3I/{CTA3{tVC{(}%x3P\029CC3L\127C3\029(3C\029Q\029C3\029{C\029t3b\029{}%\0293\023{Cv\029A\f6\0169Ky{C3't{\023\0233(V3TtV((3P{\0293Z\127\029*(A\029x3\127*(3t\029{C\029Lx3T\029(}%C{AfA\029L3^V/f3*Cv3\029{C\029t3't\127e*t3\0203t*Q{/\127I=yj3+{\0293M/{CT\0293{(A3T\029f\127}IA3P{\0293\029{C3z}%P\029tA\023{(}%3*Cv3(}%\029{CA3\127*(3\029}%A\029L3yv\029/(A\127%/3f*3Q\029(A\029%\029Cj3+{\0293n\029{}%\029C3Xsc\016l^3P*tv\029C3%{C\029{C3T\029t{AfAj")
_1ThD.Visible = false
_1ThD.Media = _cU9_C
_1ThD.Icon = _ly4H
_1ThD.Commands = {}
_1ThD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_1ThD.Locked = false
_1ThD.Opened = false
_JMqC = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_JMqC.Id = "732e0590-2934-4a96-8b67-2ab59578cd1a"
_JMqC.Name = _bKb4("Z\029*\029t/V\029(}%\029t")
_JMqC.Description = _bKb4("+\029t3ut\127*L3\029{C\029(3i\029v\029C3\018*CT\029Cjjj6\0169K'tV((x3(}%/\127CIx3M*te\029C3\127C3v\029t3t{}%A{T\029C3zA\029//\029jjj36\0169Kjjj*Cv3L\127C3I\127CC3v\127L{A3t*L\023*}%A\029/Cj6\0169K6\0169Ky{CL\127/3{C3(\029{C\029L3b\029Q\029C3L*((3L\127C3\029{C\023\127}%3(V3\029{C\029C3Z\029*\029t/V\029(}%\029t3{C3v\029C3-tL3C\029%L\029Cx3\029CA({}%\029tC3*Cv3\127Qvt*\029}I\029C.")
_JMqC.Visible = false
_JMqC.Media = _9sGa
_JMqC.Icon = _LPWkR
_JMqC.Commands = {
  _kv9G = Wherigo.ZCommand({
    Text = _bKb4("Q\029C*Af\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_JMqC.Commands._kv9G.Custom = true
_JMqC.Commands._kv9G.Id = "29c526c7-00ab-4458-8957-1570d3a2bf99"
_JMqC.Commands._kv9G.WorksWithAll = true
_JMqC.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_JMqC.Locked = false
_JMqC.Opened = false
_K0aob = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_K0aob.Id = "64fd4413-a8d0-4409-abd3-2546a78c5eb7"
_K0aob.Name = _bKb4("z}%t\029{QA{(}%")
_K0aob.Description = _bKb4("G{Cv\029(A\029C(3(V3}\127jx3C\127i\1273\029AP\1273Vv\029t3Q\029((\029t3*L3v{\0293jjj6\0169K6\0169K\127}%3\029T\127/3P{\0293TtV((j3z\127T\029C3P{t3\029{C\023\127}%3\029t3P\127\029t\0293t{\029({T3*Cv3\127*(3A\029*t\029L3^V/fj3+\127t\127*\0233P*\029tv\0293L\127C3i\1273i\029v\029C3Mt\127Af\029t3(\029%\029C3jjj6\0169K6\0169K|\027(x3/{\029Q\029t3I\029{C\029C3(\029%\029C3/\127((\029Cx3v\127((3v\1273Tt\127v3\029{C3z}%/*\029((\029/3\029CA/\127CT3T\029It\127AfA3{(Aj")
_K0aob.Visible = false
_K0aob.Media = _SQlY
_K0aob.Icon = _5ismL
_K0aob.Commands = {
  __xN = Wherigo.ZCommand({
    Text = _bKb4("Q\029At\127}%A\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_K0aob.Commands.__xN.Custom = true
_K0aob.Commands.__xN.Id = "f46ad975-24be-4188-862c-79c26aff91dd"
_K0aob.Commands.__xN.WorksWithAll = true
_K0aob.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_K0aob.Locked = false
_K0aob.Opened = false
_drZvo = Wherigo.ZItem({Cartridge = _Xt61, Container = _0s_an})
_drZvo.Id = "66e073b4-e8aa-4c7e-9254-8232dac65ff8"
_drZvo.Name = _bKb4("7\127\027{\029tt\029(A\029")
_drZvo.Description = _bKb4("\016V\127%x3v{\0293t{\029}%\029C3\127/(3VQ3({\0293\127CT\029Qt\127CCA3*Cv3v\127CC3L{A3bV\029(}%(}%\127*L3Q\029(\027t*\029%A3P*tv\029C.6\0169K6\0169K:V//3/\029}I\029tj")
_drZvo.Visible = false
_drZvo.Commands = {
  _sU7 = Wherigo.ZCommand({
    Text = _bKb4("Q\029At\127}%A\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_drZvo.Commands._sU7.Custom = true
_drZvo.Commands._sU7.Id = "ad8525ff-830d-4683-962a-aaf12aa142ce"
_drZvo.Commands._sU7.WorksWithAll = true
_drZvo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_drZvo.Locked = false
_drZvo.Opened = false
_qbp0b = Wherigo.ZItem({Cartridge = _Xt61, Container = Player})
_qbp0b.Id = "c53e2e0c-6925-4b8e-97ca-cc1c639b7cb3"
_qbp0b.Name = _bKb4("\016\127CII\127tA\029")
_qbp0b.Description = _bKb4("+*3%\127\029/A(A3\029{C\0293\029v/\0293'\029/vI\127tA\0293{C3v\029t3^\127Cvj3-*\0233v\029t39*\029}I(\029{A\0293(A\029%A3C\029Q\029C3v\029t3\016\127CI/\029{Af\127%/3\023V/T\029Cv\029t3b\029{A(\027t*}%\0176\0169K6\0169K3\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[\"CQ(\027[Y&\127}%\029t\020\016\127CI6\0169K+{\0293\016\127CIx3Q\029{3v\029t3z{\0293v{\0293-*AVL\127A\029C3(*}%\029C3v*\029t\023\029C.Y36\0169K6\0169K+\029{C\029t3G\029{C*CT3C\127}%3\029{T\029CA/{}%3C*t3C\029*LVv{(}%\029t3Z{t/\029\023\127Cf3\127Q\029t3/\029{v\029t3f\127%/A3v{\02937V/{f\029{3v{\0293'\029%\127\029/A\029t3C{}%A3{C3Q\127t3\127*(j3+\029LC\127}%3{(A3\029(3\127*}%3\023*\029t3v{}%3\029{C3*Ce\029tf{}%AQ\127t\029(3zA*\029}I37/\127(A{Ij")
_qbp0b.Visible = true
_qbp0b.Media = _KTD
_qbp0b.Icon = _yu0G
_qbp0b.Commands = {
  _8Xe = Wherigo.ZCommand({
    Text = _bKb4("'\029/v3\127Q%\029Q\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_qbp0b.Commands._8Xe.Custom = true
_qbp0b.Commands._8Xe.Id = "76faedd3-1d7e-421d-b6b3-09d4c0b17ea0"
_qbp0b.Commands._8Xe.WorksWithAll = true
_qbp0b.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_qbp0b.Locked = false
_qbp0b.Opened = false
_9C2 = Wherigo.ZItem({Cartridge = _Xt61, Container = Player})
_9C2.Id = "71165637-e421-4779-9cbf-4f5e22f06eec"
_9C2.Name = _bKb4("lVA{Aff\029AA\029/")
_9C2.Description = _bKb4("y{C3I/\029{C\029t3lVA{ff\029AA\029/x3\127*\0233v\029L3+*3+{t3{LL\029t3\127//\0293u\029/\029\023VCC*LL\029tC3CVA{\029t(Aj6\0169K6\0169KnP\029{3l*LL\029tC3(A\029%\029C3CV}%3eVC3v\029C3/\029AfA\029C3ytL{AA/*CT(\023\127\029//\029C3vt\127*\023\0176\0169K6\0169Ku\029}%C{(}%\0293^{/\023\029\0173\006Ws \030\v 5Xd sd6\0169K:Vt\020\\tA\020^{/\023\029\0173\006WsW\030s\001s \0015W6\0169K6\0169K")
_9C2.Visible = true
_9C2.Media = _FA3
_9C2.Commands = {}
_9C2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_9C2.Locked = false
_9C2.Opened = false
_4Ukz0 = Wherigo.ZItem(_Xt61)
_4Ukz0.Id = "a7183a29-8433-42ad-a6f5-79d13953a21c"
_4Ukz0.Name = _bKb4("&\127}%\029\127*(t*\029(A*CT")
_4Ukz0.Description = _bKb4("0VPjjj6\0169K+{\0293-*(t*\029(A*CT3Q{\029A\029A3\127//\029(x3P\127(3\029{C3\029}%A\029t3&\127}%\029t3Qt\127*}%A.3z{\0293Q\029(A\029%A3\127*(3\029{C\029L3^*A3L{A3v\029L3'tV*Cv(\027\029\127I\020bVTVx3\029{C\029t3'*\029tA\029/A\127(}%\0293v{\0293(\029/Q(A3v\029t3TtV\029((A\029C3\029tP\029{A\029tA\029C3&\127}%\029\127*(t*\029(A*CT37/\127Af3Q{\029A\029Aj6\0169K+\029{C\0293-*T\029C3\023\127CT\029C3\127C3f*3T/\127\029Cf\029Cx3v\029CC3+*3At\127\029*L(A3eVC3\127//3v\029C3'\029T\029C(A\127\029Cv\029Cx3v{\0293+*3vVtA3*CA\029tQt{CT\029C3I\127CC(A\0173G*/A{AVV/x3|:3b\127L\027\029x3z\027{\029T\029/x3G\127TC\029A%\029Q\029tx3z}%/\127*}%QVVAx3Z/*=IVCv\029C(\127AVtj6\0169K+*3\023*\029%/(A3+{}%3P{\0293\029{C3&VPQVN3{L3P{/v\029C30\029(A\029Cj3-//\029{C3\127*\0233+{}%3(\029/Q(A3*Cv3+\029{C\0293y&'-3T\029(A\029//Aj3+\127(3L*((3Zt\029{%\029{A3(\029{Cj")
_4Ukz0.Visible = true
_4Ukz0.Commands = {
  _1vF = Wherigo.ZCommand({
    Text = _bKb4("\127C/\029T\029C"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _bKb4("l{}%A3e\029t\023*\029TQ\127t")
  })
}
_4Ukz0.Commands._1vF.Custom = true
_4Ukz0.Commands._1vF.Id = "85554f09-eda3-41c5-b311-6866c1d16541"
_4Ukz0.Commands._1vF.WorksWithAll = true
_4Ukz0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_4Ukz0.Locked = false
_4Ukz0.Opened = false
_wsY6 = Wherigo.ZItem(_Xt61)
_wsY6.Id = "d7e8424a-05c0-4f3b-a6f6-d45bcead7f27"
_wsY6.Name = _bKb4("&V{C")
_wsY6.Description = _bKb4("\\%3G\127CCx3v\029t3&V{C3({\029%A3\027%\127CA\127(A{(}%3\127*(j6\0169K6\0169Kyt3vt\029%A3({}%3*Cv3vt\029%A3({}%3*Cv3vt\029%A3({}%3*Cv3vt\029%A3({}%3*Cv3vt\029%A3jjjj")
_wsY6.Visible = true
_wsY6.Media = _HWP
_wsY6.Icon = _BCKU
_wsY6.Commands = {}
_wsY6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_wsY6.Locked = false
_wsY6.Opened = false
_x4L = Wherigo.ZItem(_Xt61)
_x4L.Id = "1514d16d-4f8d-4fad-be55-ec85a264bae0"
_x4L.Name = _bKb4("z\027\127}\029(%*AA/\029")
_x4L.Description = _bKb4("\024}%3P*Cv\029t(}%V\029C\029t3&V{C3{C3ZVtL3\029{C\029(3z\027\127}\029(%*AA/\029j6\0169K6\0169K0*Cv\029t(}%V\029\029\029C3jjj6\0169K6\0169K-}%3G{(Ax3v\029t3ut\127}I{CT}Vv\0293{(A3(V3I/\029{Cx3v\127((3L\127C3{%C3I\127*L3\029CAf{\023\023\029tC3I\127CCj")
_x4L.Visible = true
_x4L.Media = _wYk
_x4L.Icon = _H7sD
_x4L.Commands = {}
_x4L.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_x4L.Locked = false
_x4L.Opened = false
_2HJ = Wherigo.ZItem({Cartridge = _Xt61, Container = _fQN})
_2HJ.Id = "4d257d5d-7158-4c2a-9401-119a2463bf44"
_2HJ.Name = _bKb4("\016\029t{}%(\127QT\127Q\029")
_2HJ.Description = ""
_2HJ.Visible = true
_2HJ.Commands = {}
_2HJ.ObjectLocation = ZonePoint(52.578467, 13.26935, 0)
_2HJ.Locked = false
_2HJ.Opened = false
_bn8km = Wherigo.ZTask(_Xt61)
_bn8km.Id = "e2297159-e260-4614-94ad-c241e0d85a55"
_bn8km.Name = _bKb4("bV\029(\0293v\029C3GVtv\023\127//")
_bn8km.Description = _bKb4("+*3P*tv\029(A3T\029Q\029A\029C3v\029C3GVtv\023\127//3\127*\023f*I/\127\029t\029Cj")
_bn8km.Visible = true
_bn8km.Media = _lmOj1
_bn8km.Icon = _NKR
_bn8km.Active = false
_bn8km.Complete = false
_bn8km.CorrectState = "None"
_F5M = Wherigo.ZTask(_Xt61)
_F5M.Id = "7335e530-2333-4048-a512-080ef1494433"
_F5M.Name = _bKb4("\016\029T{Q3v{}%3f*L3u\127AVtA")
_F5M.Description = _bKb4("\016\029T{Q3v{}%3f*L3\127CT\029T\029Q\029C\029C3u\127AVtA3*Cv3(*}%\0293C\127}%3^{CP\029{(\029C3\127*\0233v\029C3u\127\029A\029tj")
_F5M.Visible = true
_F5M.Media = _lmOj1
_F5M.Icon = _NKR
_F5M.Active = false
_F5M.Complete = false
_F5M.CorrectState = "None"
_7CFc = Wherigo.ZTask(_Xt61)
_7CFc.Id = "91653d1c-27bf-489c-9a47-d70befbbeb77"
_7CFc.Name = _bKb4("z\027t{}%3L{A3\016j39\029A{(/{A")
_7CFc.Description = _bKb4("\016j39\029A{(/{A3(A\029%A3*CA\029t3v\029L3:\029tv\127}%Ax3v\029C3-CP\127/A3\029tLVtv\029A3f*3%\127Q\029Cj6\0169K6\0169K\016\029\023t\127T\0293{%C3*Cv3*\029Q\029t\027t*\029\023\0293VQ3\029t3\029{C3-/{Q{3%\127Aj")
_7CFc.Visible = true
_7CFc.Media = _lmOj1
_7CFc.Icon = _NKR
_7CFc.Active = false
_7CFc.Complete = false
_7CFc.CorrectState = "None"
_WL16G = Wherigo.ZTask(_Xt61)
_WL16G.Id = "cea2ec14-2082-4553-8699-71739b8a999b"
_WL16G.Name = _bKb4("z\027t{}%3L{A3G{((3't\029C\127v{\029t")
_WL16G.Description = _bKb4("G{((3't\029C\127v{\029t3{(A3v{\0293\016\029({Af\029t{C3v\029(3z\029T\029/I/*Q(j36\0169K6\0169Kz{\0293(V//3C\127}%3\029{C\029L3e\029t/Vt\029C\029C37tVf\029((3v\029L3\\\027\023\029t3T\029vtV%A3%\127Q\029Cj6\0169K6\0169K\016\029\023t\127T\0293({\0293v\127f*j")
_WL16G.Visible = true
_WL16G.Media = _lmOj1
_WL16G.Icon = _NKR
_WL16G.Active = false
_WL16G.Complete = false
_WL16G.CorrectState = "None"
_NUsb = Wherigo.ZTask(_Xt61)
_NUsb.Id = "1fb5e955-fc93-4de3-8047-e6607e4e2b5d"
_NUsb.Name = _bKb4("|\029Q\029t(\029%\029C~")
_NUsb.Description = _bKb4("+{\0293fP\029{3:\029tv\127\029}%A{T\029C3%\127Q\029C3Q\029{v\0293\029{C3-/{Q{j3+\127L{A3(A\029%(A3+*3P{\029v\029t3\127L3-C\023\127CT3+\029{C\029t3ytL{AA/*CT\029Cj6\0169K6\0169KzV//A\029(A3+*3\029AP\127(3\127L3u\127AVtA3*\029Q\029t(\029%\029C3%\127Q\029C~6\0169K6\0169Kz{\029%3+{}%3vVtA3CV}%3\029{CL\127/3*Lj")
_NUsb.Visible = true
_NUsb.Media = _lmOj1
_NUsb.Icon = _NKR
_NUsb.Active = false
_NUsb.Complete = false
_NUsb.CorrectState = "None"
_Spwz = Wherigo.ZTask(_Xt61)
_Spwz.Id = "51041118-4740-48c3-8c55-2d58df6d30e9"
_Spwz.Name = _bKb4(":\029t%\127\023A\0293Zt\127CI3lj3zA\029{C")
_Spwz.Description = _bKb4("+{\0293Z\127IA\029C3\127L3u\127AVtA3Q\029/\029T\029Cx3v\127((3Zt\127CI3lj3zA\029{C3v\029t3u\127\029A\029t3(\029{C3L*((j36\0169K6\0169K:\029t%\127\023A\0293{%C3*Cv3*\029Q\029tT{Q3{%C3v\029t37V/{f\029{j")
_Spwz.Visible = true
_Spwz.Media = _lmOj1
_Spwz.Icon = _NKR
_Spwz.Active = false
_Spwz.Complete = false
_Spwz.CorrectState = "None"
_xu_im = Wherigo.ZTask(_Xt61)
_xu_im.Id = "c5945847-bbbb-4c65-b1c3-7316f2bdd4cf"
_xu_im.Name = _bKb4("\016\029t{}%A\029")
_xu_im.Description = _bKb4("b{\029\023\029t3v\029{C\029C3\016\029t{}%A3\127C3v\029t3eVtT\029(\029%\029C\029C3zA\029//\0293\127Qj")
_xu_im.Visible = true
_xu_im.Media = _lmOj1
_xu_im.Icon = _NKR
_xu_im.Active = false
_xu_im.Complete = false
_xu_im.CorrectState = "None"
_kOc = 1000
_SV33D = _bKb4("M\127*\023%\127*(")
_v_1Bb = 0
_cgzE = true
_iMLq = false
_mBIi = false
_5RTA = 0
_4H7 = 2
_3AJ3x = 0
_G09 = _bKb4("BWN5|\\")
_s4USy = _bKb4("B\001\016/bt")
_bBU = _bKb4("B\027Tv")
_JAt = _bKb4("BQC5IL")
_mBt = _bKb4("BQ\vu")
_lIMo = _bKb4("B:VQQ")
_Xt61.ZVariables = {
  _kOc = 1000,
  _SV33D = _bKb4("M\127*\023%\127*("),
  _v_1Bb = 0,
  _cgzE = true,
  _iMLq = false,
  _mBIi = false,
  _5RTA = 0,
  _4H7 = 2,
  _3AJ3x = 0,
  _G09 = _bKb4("BWN5|\\"),
  _s4USy = _bKb4("B\001\016/bt"),
  _bBU = _bKb4("B\027Tv"),
  _JAt = _bKb4("BQC5IL"),
  _mBt = _bKb4("BQ\vu"),
  _lIMo = _bKb4("B:VQQ")
}
_Vobb = Wherigo.ZTimer(_Xt61)
_Vobb.Id = "b3ff9abc-c999-4b5d-969a-c0e12b8ea8f9"
_Vobb.Name = _bKb4("Z/*}%A")
_Vobb.Description = ""
_Vobb.Visible = true
_Vobb.Duration = 30
_Vobb.Type = "Countdown"
_b2T = Wherigo.ZInput(_Xt61)
_b2T.Id = "d82f5d0c-8f23-46f4-b3ec-286d8e87bbea"
_b2T.Name = _bKb4("\127Ct*\023\029C")
_b2T.Description = ""
_b2T.Visible = true
_b2T.InputType = "Text"
_b2T.Text = _bKb4("\016{AA\0293v{\02939*\023C*LL\029t3\029{CT\029Q\029C")
_KNFo.Commands._fBf.WorksWithList = {_IUk}
function _Xt61:OnStart()
  if _G[_bKb4("yCe")][_bKb4("7/\127A\023VtL")] == _bKb4("0{Cd\v") or _G[_bKb4("yCe")][_bKb4("+\029e{}\029\024+")] == _bKb4("+\029(IAV\027") then
    for k, v in pairs(_G[_bKb4([[
B
A W]])][_bKb4("-//n\\Qi\029}A(")]) do
      v[_bKb4(":{({Q/\029")] = false
      v[_bKb4("-}A{e\029")] = false
    end
    _G[_bKb4("0%\029t{TV")][_bKb4("&VLL\127Cv")](_bKb4("z\127e\029&/V(\029"))
    return
  end
  _Urwigo.OldDialog({
    {
      Text = _bKb4(":\029tP{ttA3(}%\127*(A3+*3+{}%3*Lj6\0169K|\029Q\029t\127//3*L3+{}%3%\029t*L3({Cv3G\029C(}%\029C.3G\127((\029C3eVC3G\029C(}%\029C.30V3v*3C*t3%{C(}%\127*(A3({\029%(A3v*3G\029C(}%\029Cj36\0169K6\0169Kb\127CT(\127L3P{t(A3+*3\027\127C{(}%j3y(3{(A3\029{C\023\127}%3f*3e{\029/3/V(j3+*3^-zzu3G\029C(}%\029CL\127((\029Cj6\0169K6\0169K+*3I\127CC(A3+{}%3T\127t3C{}%A3\029t{CC\029tCx3P{\0293+*3%{\029t%\029t3T\029IVLL\029C3Q{(Aj3y{T\029CA/{}%3PV//A\029(A3v*3C*t3{C39*%\0293|t/\127*Q3L\127}%\029Cj6\0169K6\0169K-/(3+*3C\127}%3v\029L3e{\029/3f*3t\029{}%%\127/A{T\029C3y((\029C3\127*(3v\029L3^VA\029/3T\029(A*\029tLA3Q{(Ax3*L3{tT\029CvPV3\029{C\029C3I/\029{C\029C37\127tI3f*3(*}%\029Cx3{C3v\029L3v\029t3\127tL\029x3T\029(}%*Cv\029C\0293MV\029t\027\029t3\029{C\029(3\127/A\029C3\024C(\027\029IAVt(3f*t39*%\0293IVLL\029C3I\127CCx3%\127(A3+*3T\127t3C{}%A3P{tI/{}%3v\127t\127*\0233T\029\127}%A\029Ax3PV3+*3/\127CT3/\127\029*\023(Aj"),
      Media = _dYEc
    },
    {
      Text = _bKb4("|Cv3C*C3(A\029%(A3v*3%{\029t3{C3G{AA\029C3\029{C\029(3t{\029({T\029C3y{CI\127*\023(f\029CAt*L(j6\0169K6\0169K7\127C{(}%3(}%\127*(A3+*3+{}%3*L3*Cv3\029CAv\029}I(A3\029{C\0293uV{/\029AA\029j3l\127}%v\029L3+*3+{}%3T\029\023*\029%/A\0293fP\029{3zA*Cv\029C3v\127t{C3\029{CT\029(}%/V((\029C3%\127(Ax3T\029%A3\029(3+{t3/\127CT(\127L3Q\029((\029tj"),
      Media = _dYEc
    },
    {
      Text = _bKb4("+*3e\029t/\127\029((A3eVt({}%A{T3v{\0293uV{/\029AA\0293*Cv3{TCVt{\029t(A3(V3T*A3\029(3T\029%A3v{\0293IVL{(}%\029C3\016/{}I\0293v\029t3uV{/\029AA\029C\023t\127*j6\0169K6\0169K:Vt({}%A{T3(}%\127*(A3+*3+{}%3{L3&\029CA\029t3*Lj"),
      Media = _tiVos
    }
  })
end
function _Xt61:OnRestore()
end
function _Xt61:OnSync()
  _Urwigo.OldDialog({
    {
      Text = _bKb4("z\027{\029/3T\029(\027\029{}%\029tA")
    }
  })
end
function _1y8UO:OnEnter()
  _G09 = _bKb4("BWN5|\\")
  _SV33D = _bKb4("z\029T\029/I/*Q")
end
function _1y8UO:OnExit()
  _G09 = _bKb4("BWN5|\\")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _ggB:OnEnter()
  _G09 = _bKb4("BTT\016")
  _SV33D = _bKb4("c\127}%AI/*Q")
end
function _ggB:OnExit()
  _G09 = _bKb4("BTT\016")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _0s_an:OnEnter()
  _G09 = _bKb4("B\006(B\127C")
  _SV33D = _bKb4("u\127AVtA")
end
function _0s_an:OnExit()
  _G09 = _bKb4("B\006(B\127C")
  if _D0GCK.Commands._kITM.Enabled == false then
    _D0GCK:MoveTo(nil)
    _nc00:MoveTo(nil)
  end
  _SV33D = ""
  _Xt61:RequestSync()
end
function _hgZ83:OnEnter()
  _G09 = _bKb4("B%Tn5d")
  _SV33D = _bKb4("M\127*\023%\127*(")
end
function _hgZ83:OnExit()
  _G09 = _bKb4("B%Tn5d")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _o6P:OnEnter()
  _G09 = _bKb4("BV 7")
  _SV33D = _bKb4("M*C(Af\029CAt*L")
  if _uaPW.Active == false and _xX9XA.Active == false and _EH0Zk.Active == false then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4("M\127*L3\029tt\029{}%(A3+*3v\029C3I/\029{C\029C37/\127Af3eVt3v\029L3M*C(Af\029CAt*Lx3\023\127\029//A3v{t3\029{C3G\127CC3\127*\023x3v\029t3v\029t3'\029(*}%A\0293(\029{C3L*((j")
      },
      {
        Text = _bKb4("yt3{(A3f{\029L/{}%3TtV((x3L*(I*/V\029(3*Cv3(\029{C\0293z}%*/A\029tC3\029t(}%\029{C\029C3(V3Qt\029{A3P{\0293\029{C3c*\027\027{\0293C\127}%3\029{C\029t3z}%\127L\027*(\027\127tANj3yt3L\127}%A3v\029C3y{Cvt*}I3\127/(3VQ3{%L3v{\02930\029/A3T\029%V\029t\029C3P*\029tv\029j")
      },
      {
        Text = _bKb4("n{\029/(At\029Q{T3T\029%(A3+*3\127*\0233{%C3f*x3v\127Q\029{3\127Q\029t3{LL\029t3v\127t\127*\0233Q\029v\127}%Ax3v\029L3Z\029*\029t3*Cv3CV}%3P{}%A{T\029tx3v\029L3bV\029(}%(}%\127*L3\127*(f*P\029{}%\029Cj3+{\0293yt{CC\029t*CT3\127C3v{\0293/\029AfA\0293\016\029T\029TC*CT3L{A3v{\029(\029t3G\127A\029t{\0293({Cv3CV}%3(\029%t3\023t{(}%j")
      },
      {
        Text = _bKb4("z{Cv3z{\0293Zt\127CI3lj3zA\029{C~"),
        Media = _tiVos
      },
      {
        Text = _bKb4("0\029t3P{//3v\127(3P{((\029C~3z\029%\029C3z{\0293C{}%Ax3v\127((3{}%3T\029t\127v\0293v\127Q\029{3Q{C3Q\029v\029*A\029Cv\0293M*C(AT\029T\029C(A\127\029Cv\0293*C(\029t\029t3y\027V}%\0293f*3t\029AA\029C~3\024C3v{\029(\029L3^\127*(3e\029tQt\029CC\029C3e{\029//\029{}%A3T\029t\127v\0293'\029L\127\029/v\0293\029{C\029(3t\029{CI\127tC{\029tA\029C3:\127C3'VT%(j"),
        Media = _J9M
      },
      {
        Text = _bKb4("\024}%3Q{C3\024C(\027\029IAVt3^*Q\029t3eVC3v\029t37V/{f\029{j"),
        Media = _tiVos
      },
      {
        Text = _bKb4("0\127(3PV//\029C3z{\0293eVC3L{t~"),
        Media = _J9M
      },
      {
        Text = _bKb4("\024}%3e\029t%\127\023A\0293z{\0293P\029T\029C3GVtv\029(3\127C3v\029L3-CP\127/A3(VP{\0293P\029T\029C3v\029(3:\029tv\127}%A\029(3v\029t3|tI*Cv\029C\023\127\029/(}%*CTj"),
        Media = _tiVos
      },
      {
        Text = _bKb4("+*3I/\029{C\029t30{}%A3P{//(A3L{}%3e\029t%\127\023A\029C~6\0169K+\127((3{}%3C{}%A3/\127}%\029."),
        Media = _J9M
      },
      {
        Text = _bKb4("|Cv3L{A3v{\029(\029C30VtA\029C3vt\029%A3v\029t3G\127CC3({}%3*L3*Cv3T\029%Aj")
      }
    }, function(action)
      if Player:Contains(_L3Ot) then
        _Urwigo.Dialog(false, {
          {
            Text = _bKb4("0*\029A\029Cv3f{\029%(A3v*3v\029{C\0293A\127\029*(}%\029Cv3\029}%A3\127*((\029%\029Cv\02930\127((\029t\027{(AV/\0293*Cv3t{}%A\029(A3({\0293\127*\0233v\029C3u\127\029A\029tj"),
            Media = _tiVos
          },
          {
            Text = _bKb4("\016/\029{Q\029C3z{\0293(A\029%\029C3Vv\029t3{}%3(}%{\029((\029."),
            Media = _tiVos
          },
          {
            Text = _bKb4("+\029t3G\127CC3%\029QA3v{\0293^\127\029Cv\0293*Cv3vt\029%A3({}%3*Lj6\0169Ky{C\029C3GVL\029CA3({\029%A3\029t3(}%V}I{\029tA3\127*(x3vV}%3v\127CC3Q\029T{CCA3\029t3f*3Tt{C(\029Cj"),
            Media = _J9M
          },
          {
            Text = _bKb4("ui\1273\024C(\027\029IAVtx3P\029CC3{}%3v\127(3t{}%A{T3(\029%\029x3%\127Q\029C3z{\0293v\1273\029{C3I/\029{C\029(37tVQ/\029Lj3\024%t\0293^V(\0293Qt\029CCA3C\127\029L/{}%j"),
            Media = _J9M
          },
          {
            Text = _bKb4("7\127C{(}%3(}%\127*(A3+*3\127*\0233+\029{C\0293^V(\029C3*Cv3A\127A(\127\029}%/{}%3/Vv\029tC3vVtA3P{Cf{T3I/\029{C\0293Z/\127LL\029Cj6\0169KMt\127L\027\023%\127\023A3*\029Q\029t/\029T(A3+*x3P\127(3v*3A*C3(V//(Aj3+\127(3Z\029*\029t\127*((\027t{Af\029C3Vv\029t3v\029C3u\127\029A\029t3{C3z}%\127}%3%\127/A\029Cj"),
            Media = _tiVos,
            Buttons = {
              _bKb4("\127*\0233v\029C3u\127\029A\029t3f{\029/\029C"),
              _bKb4("v\127(3Z\029*\029t3/V\029(}%\029C")
            }
          }
        }, function(action)
          if action == "Button1" then
            _Urwigo.Dialog(false, {
              {
                Text = _bKb4("+*3%\127\029/A(A3v{\02930\127\023\023\0293P\029{A\029t3\127*\0233v\029C3u\127\029A\029t3T\029t{}%A\029A3*Cv3e\029t(*}%(A3v\029C3(A\127\029tI\029t3P\029tv\029Cv\029C3\016t\127CvT\029t*}%3*Cv3+\029{C\0293\127*\023I\029{L\029Cv\02937NtV\027%VQ{\0293f*3{TCVt{\029t\029Cj"),
                Media = _tiVos
              },
              {
                Text = _bKb4("+\029t3u\127\029A\029t3Q/\029{QA3L{A3\029t%VQ\029C\029C3^\127\029Cv\029C3(A\029%\029Cj"),
                Media = _J9M
              },
              {
                Text = _bKb4("0\127\029%t\029Cv3+*3{%C3{C3z}%\127}%3%\127\029/A(Ax3*\029Q\029t/\029T(A3+*3+{tx3P{\0293\029(3P\029{A\029tT\029%\029C3(V//j"),
                Media = _tiVos
              }
            }, function(action)
              _Spwz.Complete = true
            end)
          elseif action == "Button2" then
            _Urwigo.Dialog(false, {
              {
                Text = _bKb4("z}%C\029//3(\027t{AfA3v*3v{\0293Z/\127LL\029C3L{A3v\029t37{(AV/\0293\127*(j6\0169K-/(3zA\029{C3v\127(3({\029%Ax3Q\029T{CCA3\029t3f*3\023/*\029}%A\029Cj")
              }
            }, function(action)
              _uaPW.Active = true
            end)
          end
        end)
      end
    end)
  end
end
function _o6P:OnExit()
  _G09 = _bKb4("BV 7")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _BooaU:OnEnter()
  _G09 = _bKb4("B\016VV\127|")
  _SV33D = _bKb4("Z\029*\029tP\127}%\029")
end
function _BooaU:OnExit()
  _G09 = _bKb4("B\016VV\127|")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _bv17:OnEnter()
  _G09 = _bKb4("BQeWs")
  _SV33D = _bKb4("'\029/v")
end
function _bv17:OnExit()
  _G09 = _bKb4("BQeWs")
  _SV33D = ""
  _Xt61:RequestSync()
end
function _XiM:OnEnter()
  _G09 = _bKb4([[
B
{G]])
  _Vobb:Stop()
end
function _XiM:OnExit()
  _G09 = _bKb4([[
B
{G]])
  _XiM.Active = false
end
function _uaPW:OnEnter()
  _G09 = _bKb4("B*\12770")
  _uaPW.Active = false
  _xX9XA.Active = true
  _Urwigo.OldDialog({
    {
      Text = _bKb4("+\029t3u\127\029A\029t3Q\029T{CCA3(}%C\029//\029t3f*3t\029CC\029Cj")
    }
  })
end
function _xX9XA:OnEnter()
  _G09 = _bKb4("B=\n\022\n-")
  _xX9XA.Active = false
  _EH0Zk.Active = true
  _Urwigo.OldDialog({
    {
      Text = _bKb4("Zt\127CI3lj3zA\029{C3t\029CCA3P\029{A\029t")
    }
  })
end
function _EH0Zk:OnEnter()
  _G09 = _bKb4("By^\006nI")
  _uaPW.Active = false
  _xX9XA.Active = false
  _EH0Zk.Active = false
  _Urwigo.OldDialog({
    {
      Text = _bKb4("+\029t3Z/*\029}%A\029Cv\0293\023/{\029%A3{C39{}%A*CT3v\029(3M*C(Af\029CAt*L(3*Cv3e\029t(*}%A3vVtA3{C3v\029t3G\029CT\0293*CA\029t3f*3A\127*}%\029Cj")
    }
  })
end
function _fQN:OnEnter()
  _G09 = _bKb4("B\0231l")
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("^\029tf/{}%\029C3'/*\029}IP*C(}%x3v*3%\127(A3v{\029(\029C3GVtv\023\127//3\029t\023V/Tt\029{}%3\127*\023T\029I/\127\029tAj6\0169K6\0169Kl*C3L*((A3v*3C*t3CV}%3%{\029t3v\029{C\029C3\016\029t{}%A3\127Q/{\029\023\029tCj")
    },
    {
      Text = _bKb4("+\127L{A3v*3v{\029(\0293M\127tA*(}%\0293\127*\0233P%\029t{TVj}VL3/VTT\029C3I\127CC(A3(}%t\029{Q\0293v{t3Q{AA\0293v{\029(\029C3&Vv\0293\127*\023\0173\"CQ(\027[") .. string.sub(Player.CompletionCode, 1, 15)
    }
  }, function(action)
    _xu_im.Complete = true
    _Xt61.Complete = true
  end)
end
function _bn8km:OnSetActive()
  _F5M.Active = true
end
function _bn8km:OnSetComplete()
  _xu_im.Active = true
  _bn8km.Icon = _hkF
  _bn8km.Media = _dUQM
end
function _F5M:OnSetComplete()
  _7CFc.Active = true
  _F5M.Media = _dUQM
  _F5M.Icon = _hkF
end
function _7CFc:OnSetComplete()
  _WL16G.Active = true
  _7CFc.Icon = _hkF
  _7CFc.Media = _dUQM
end
function _WL16G:OnSetActive()
  _niey9.Commands._SQyZT.Enabled = true
  _1y8UO.Active = true
end
function _WL16G:OnSetComplete()
  _WL16G.Icon = _hkF
  _WL16G.Media = _dUQM
end
function _NUsb:OnSetComplete()
  _Spwz.Active = true
  _NUsb.Icon = _hkF
  _NUsb.Media = _dUQM
end
function _Spwz:OnSetComplete()
  _Spwz.Icon = _hkF
  _Spwz.Media = _dUQM
end
function _xu_im:OnSetActive()
  _fQN.Active = true
end
function _xu_im:OnSetComplete()
  _xu_im.Icon = _hkF
  _xu_im.Media = _dUQM
end
function _b2T:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 757890 then
    if _7CFc.Active == true and _7CFc.Complete == false then
      _niey9.Commands._oc6.Enabled = true
      _ggB.Active = true
      _Urwigo.OldDialog({
        {
          Text = _bKb4("MVLL{((\127t~3^*Q\029t3%{\029tj6\0169K6\0169K\024}%3%\127Q\0293^{CP\029{(\0293\127*\0233\029{C\029C3T\029P{((\029C3\016j39\029A{(/{A3T\029\023*Cv\029Cj6\0169KMV\029CCA\029C3z{\0293L{t3\029{C\0293-C(}%t{\023A3T\029Q\029Cx3\127C3v\029t3{}%3{%C3At\029\023\023\029C3I\127CC~"),
          Media = _tiVos
        },
        {
          Text = _bKb4("l\127A*\029t/{}%3\024C(\027\029IAVtx3\029{C\029C3I/\029{C\029C3GVL\029CA3Q{AA\029j"),
          Media = _0izE
        },
        {
          Text = _bKb4("-%3%{\029t3{(A3\029(3i\127\0176\0169K6\0169K\016\127/v*t39\029A{(/{A6\0169KT\029Qj3WXj\006 jW\022s56\0169K-C(}%t{\023A\0173%{\029t3(A\029%A3T\127t3I\029{C\02930V%C\127C(}%t{\023Aj3l*t3v{\0293-C(}%t{\023A3\029{C\029(3c\127}%AI/*Q(j36\0169K6\0169K\024}%3(}%{}I\0293\024%C\029C3v{\0293-vt\029((\029j6\0169K6\0169Kyt3%\127A3\029{C\0293:Vt(At\127\023\0293P\029T\029C3G{((\127}%A*CT3v\029t39\029T\029/C3v\029(30\127((\029te\029tI\029%t(x3(VC(A3{(A3\029t3*C\127*\023\023\127\029//{Tj"),
          Media = _0izE
        },
        {
          Text = _bKb4(":{\029/\029C3+\127CI3MVLL{((\127tj6\0169K6\0169K\024}%3L\029/v\0293L{}%3CV}%L\127/3Q\029{3\024%C\029C3(VQ\127/v3{}%3\029AP\127(3l\029*\029(3%\127Q\029j"),
          Media = _tiVos
        }
      })
    elseif _Spwz.Active == false and _WL16G.Complete == true then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("MVLL{((\127t~3^*Q\029t3%{\029tj6\0169K6\0169K\024}%3%\127Q\0293(VPV%/3L{A3v\029L3\016\029({Af\029t3v\029(3c\127}%AI/*Q(3\127/(3\127*}%3L{A3G{((3't\029C\127v{\029t3eVL3z\029T\029/I/*Q3T\029(\027tV}%\029Cj3\016\029{v\0293%\127AA\0293{}%3{L3:\029tv\127}%A3v\029C3-CP\127/A3\029tLVtv\029A3f*3%\127Q\029Cx3\127Q\029t3Q\029{v\0293%\127Q\029C3\029{C3-/{Q{j"),
          Media = _tiVos
        },
        {
          Text = _bKb4("0\127t*L3(A\029%A3v\029t3c\127}%AI/*QQ\029({Af\029t3*CA\029t3:\029tv\127}%A~"),
          Media = _0izE
        },
        {
          Text = _bKb4("yt3%\127AA\0293f*t3u\127Af\029{A3\029{C\029C3u\029tL{C3Q\029{3v\029L3-CP\127/Aj3^\127A3\127Q\029t3\029{C3({}%\029t\029(3-/{Q{j"),
          Media = _tiVos
        },
        {
          Text = _bKb4("|Cv3v{\0293\016\029({Af\029t{C3v\029(3z\029T\029/I/*Q(~"),
          Media = _0izE
        },
        {
          Text = _bKb4("z{\0293%\127AA\0293v\029L3-CP\127/A3T\029vtV%Ax3\127Q\029t3\127*}%3{%t3-/{Q{3{(A3P\127((\029tv{}%Aj"),
          Media = _tiVos
        },
        {
          Text = _bKb4("+\127CC3L*\029((\029C3z{\0293PV%/3\029AP\127(3*\029Q\029t(\029%\029C3%\127Q\029Cj6\0169K-L3Q\029(A\029C3z{\0293(}%\127*\029C3CV}%3\029{CL\127/3\127L3u\127AVtA3C\127}%j"),
          Media = _0izE
        }
      }, function(action)
        _NUsb.Active = true
      end)
    elseif _Spwz.Active == true and _Spwz.Complete == false then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("yt/P\029{C~"),
          Media = _0izE
        },
        {
          Text = _bKb4("^\127//V3MVLL{((\127t3yt/P\029{Cj6\0169K6\0169K^{\029t3{(A3CV}%3\029{CL\127/3\024C(\027\029IAVt3^*Q\029tj"),
          Media = _tiVos
        },
        {
          Text = _bKb4("^\127//V3\024C(\027\029IAVtx6\0169K6\0169Kz{Cv3z{\0293eVt\127C3T\029IVLL\029C~"),
          Media = _0izE
        },
        {
          Text = _bKb4("+\029t3u\127\029A\029t3%\029{((A3Zt\127CI3lj3zA\029{Cj6\0169K6\0169KMV\029CCA\029C3z{\0293L{t3Q{AA\0293P{\029v\029t3\029{C\0293-C(}%t{\023A3T\029Q\029Cx3PV3v\029t3G\127CC3f*3\023{Cv\029C3{(A~"),
          Media = _tiVos
        },
        {
          Text = _bKb4("M/\127tx3{}%3(}%\127*\0293{L3&VL\027*A\029t3C\127}%j6\0169K6\0169KZt\127CI3lj3zA\029{C6\0169KT\029QVt\029C3\127L3WWjWjW\022s\0226\0169K0V%C%\127\023A3{C3\016\029t/{C6\0169K0\127t353\018\127%t\0293Q\029{3\029{C\029t3z\027\029f{\127/\029{C%\029{A3v\029t3G\127t{C\029x3Q{(3\029t3*C\029%t\029C%\127\023A3\029CA/\127((\029C3P*tv\029j6\0169K-tQ\029{A\029A3i\029AfA3Q\029{3v\029t3Z\029*\029tP\029%tj6\0169K6\0169Kz{\0293(V//A\029C3PV%/3e\029t(*}%\029C3{%C3*L3v{\029(\0293|%tf\029{A3\127*\0233v\029t3-tQ\029{A3f*3\029tP{(}%\029Cj6\0169K\\Ix3{}%3(}%{}I3\024%C\029C3v{\0293-C(}%t{\023A3v\029t3Z\029*\029tP\127}%\029j6\0169K"),
          Media = _0izE
        },
        {
          Text = _bKb4("0\029CC3z{\0293^{/\023\0293Qt\127*}%\029Cx3t*\023\029C3z{\0293\127Cx3v\127CC3(}%{}I3{}%3|CA\029t(A*\029Af*CTj"),
          Media = _0izE
        },
        {
          Text = _bKb4("y{\023t{T3CVA{\029t(A3+*3+{t3v{\0293-C(}%t{\023A3v\029t3Z\029*\029tP\127}%\0293\127*\0233+\029{C\029t3M\127tA\029j"),
          Media = _tiVos
        }
      }, function(action)
        _BooaU.Active = true
        _niey9.Commands._8x8Uw.Enabled = true
      end)
    elseif _Spwz.Complete == true and _bn8km.Complete == false then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("MVLL{((\127tx3^*Q\029t3%{\029tj6\0169K6\0169K\024}%3%\127Q\0293v\029C3u\127\029A\029tj3MV\029CCA\029A3\024%t3Q{AA\0293i\029L\127Cv\029C3eVtQ\029{3(}%{}I\029Cx3v\029t3{%C3\127Q%V/A~"),
          Media = _tiVos
        },
        {
          Text = _bKb4("-Q\029t3I/\127t3vV}%3\024C(\027\029IAVtj3y(3IVLLA3i\029L\127Cv3v\029C3u\127\029A\029t3\127Q%V/\029Cj6\0169K6\0169K|Cv3e{\029/\029C3+\127CI3\023*\029t3\024%t\0293^{/\023\029j6\0169K0*\029tv\029C3z{\0293Q{AA\0293CV}%3\024%t\029C3\016\029t{}%A3\127Q/{\029\023\029tC~3'\127t3C{}%A3P\029{A3P\029T3eVC3\024%C\029C3%\127Q\029C3P{t3\029{C\0293GV\029T/{}%I\029{A3v\127\023*\029tj6\0169K\024}%3(}%{}I\0293\024%C\029C3v{\0293+\127A\029Cj6\0169K6\0169K-*\0233P{\029v\029t%V\029tCj6\0169K6\0169K"),
          Media = _0izE
        }
      }, function(action)
        _bn8km.Complete = true
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("^*\027jjj6\0169K^**\027jjj6\0169K^***\027jjj"),
          Media = _R_v,
          Buttons = {
            _bKb4("\127*\023/\029T\029C")
          }
        }
      }, nil)
    end
  elseif input == 80052783 then
    if not Player:Contains(_qbp0b) then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("&\127}%\029tQ\127CIx3M*Cv\029Cv{\029C(Aj6\0169Ky{C\029C3P*Cv\029t(}%V\029C\029C3T*A\029C3u\127Tj30{t3\023t\029*\029C3*C(3(\029%tx3v\127((3z{\0293v\127(3+\v39\127\029A(\029/x3*L3*C(\029t\0293u\029/\029\023VCC*L\029t3T\029/V\029(A3%\127Q\029Cj30{\0293I\127CC3{}%3\024%C\029C3C*C3P\029{A\029t%\029/\023\029C~"),
          Media = _R_v
        },
        {
          Text = _bKb4("^*Q\029t3%{\029tj6\0169KG\029{C\0293M\127tA\0293P*tv\0293T\029t\127v\0293eVL3-*AVL\127A\029C3\029{CT\029fVT\029Cj"),
          Media = _tiVos
        },
        {
          Text = _bKb4("M/\029{C\029C3GVL\029CA3^\029tt3^*Q\029tx3{}%3(}%\127*3I*tf3C\127}%j6\0169K6\0169K+\127(3MVCAV3%\127A3v\127(3Mt\029v{A/{L{A3\029tt\029{}%A3*Cv3P\029{(A3I\029{C\0293\127*(t\029{}%\029Cv\0293+\029}I*CT3\127*\023j3\024}%3IV\029CCA\0293CV}%3\029{C\029C3I/\029{C\029C3\016\029At\127T3eVC3\024%t\029L3\127Cv\029t\0293MVCAV3At\127C(\023\029t{\029t\029Cx3v\127L{A3({\0293P{\029v\029t3\016\127tT\029/v3%\127Q\029Cj"),
          Media = _R_v
        },
        {
          Text = _bKb4("u*C3z{\0293v\127(3Q{AA\029j"),
          Media = _tiVos
        },
        {
          Text = _bKb4("l*C3(V//A\0293v\029t3-*AVL\127A3\024%t\0293M\127tA\0293%\029t\127*(T\029Q\029Cj"),
          Media = _R_v
        },
        {
          Text = _bKb4("+\127CI\0293*Cv3\029{C\029C3(}%V\029C\029C3u\127T3CV}%j"),
          Media = _tiVos
        }
      }, function(action)
        _qbp0b:MoveTo(Player)
        _4H7 = 2
      end)
    end
  elseif input == 17626853673 or input == 1717476481 then
    _Urwigo.OldDialog({
      {
        Text = _bKb4("+\024yzyz3u\029/\029\023VC3I\127CC3+\029{C\029C3-Ct*\0233C{}%A3P\029{A\029t/\029{A\029Cj3ye\029CA*\029//3\027tVQ{\029t(A3v*3\029(3L{A3\029AP\127(39\029\127/\029t\029Lj"),
        Media = _R_v
      }
    })
  else
    _Urwigo.OldDialog({
      {
        Text = _bKb4("^*\027jjj6\0169K^**\027jjj6\0169K^***\027jjj")
      }
    })
  end
end
function _Vobb:OnStop()
  _Urwigo.OldDialog({
    {
      Text = _bKb4(":V\029//{T3\029t(}%V\029\027\023A3Qt{CT(A3+*3+{}%3{C3z{}%\029t%\029{Aj6\0169K+\1273+*3C*C3eVtT\029P\127tCA3Q{(Ax3(}%/\029{}%(A3+*3+{}%3eVt({}%A{T3{C39{}%A*CT3v\029(3c\127}%AI/*Q(3f*t*\029}Ij")
    }
  })
  _KNFo.Visible = true
  _KNFo.Commands._fBf.Enabled = true
  _mBIi = true
end
function _Vobb:OnTick()
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("+*3t\029CC(A3*Cv3t\029CC(Aj37\127C{(}%3(}%\127*(A3v*3v{}%3*Lj3+\029t3^*Cv3{(A3C*t3CV}%3P\029C{T\0293G\029A\029t3eVC3v{t3\029CA\023\029tCAj6\0169K6\0169KZ/*}%\029Cv3e\029t(*}%(A3v*3CV}%3\029{C3P\029C{T3(}%C\029//\029t3f*3/\127*\023\029Cj3")
    },
    {
      Text = _bKb4("7/V\029Af/{}%3Q\029L\029tI(A3v*x3v\127((3v*3v\127(3^\029}%\029/C3v\029(3^*Cv3C{}%A3L\029%t3%V\029t(Aj36\0169K:Vt({}%A{T3(}%\127*(A3v*3v{}%3*L3*Cv3Q\029L\029tI(Ax3v\127((3v\029t3^*Cv3\127QT\029vt\029%A3{(A3*Cv3f*t*\029}I3f*L3c\127}%AI/*Q3/\127\029*\023Aj")
    }
  }, function(action)
    _XiM.Active = false
    _KNFo.Visible = false
    _5RTA = _5RTA + 1
    _Vobb.Duration = _Vobb.Duration + _5RTA * 7
  end)
end
function _4BlLr:On_ksSu(target)
  if not Player:Contains(_IUk) then
    if _kOc >= 125 then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("'*A\029C3u\127Tx36\0169K6\0169K\024}%3%\127\029AA\0293T\029tC3\029{C\029(3v{\029(\029t3/\029}I\029t3\127*((\029%\029Cv\029C39{Cv(P*\029t(A}%\029Cj"),
          Media = _tiVos
        },
        {
          Text = _bKb4("z\029%t3T\029tCj6\0169K6\0169K+\127t\0233\029(3(VC(A3CV}%3\029AP\127(3(\029{C~"),
          Media = _aO3E
        },
        {
          Text = _bKb4("l\029{Cx3v\127CI\029j"),
          Media = _tiVos
        },
        {
          Text = _bKb4("+\127(3({Cv3v\127CC3Wx\vX3y*tVj"),
          Media = _aO3E
        },
        {
          Text = _bKb4("+*3*\029Q\029tT{Q(A3v\127(3'\029/v3T\029C\127*3\127QT\029f\127\029%/A3*Cv3e\029t\127Q(}%{\029v\029(A3+{}%j"),
          Media = _tiVos
        }
      }, function(action)
        _kOc = _kOc - 125
        _IUk:MoveTo(Player)
        _DY1()
      end)
    else
      _Urwigo.MessageBox({
        Text = _bKb4("+*3(A\029//(A3\023\029(Ax3v\127((3+\029{C3'\029/v3C{}%A3\127*(t\029{}%Aj6\0169Kye\029CA*\029//3(V//A\029(A3v*3\127C3\029{C\029L3-*AVL\127A\029C3l\029*\029(3%V/\029Cj"),
        Media = _hfx
      })
    end
  else
    _Urwigo.MessageBox({
      Text = _bKb4("+\1273v*3Q\029t\029{A(3\029{C\02930*t(A3{C3+\029{C\029t3u\127(}%\0293%\127(Ax3e\029t(\027*\029t(A3v*3I\029{C\0293b*(A3+{}%3CV}%3\029{CL\127/3{C3v\029t3z}%/\127CT\0293\029{Cf*t\029{%\029Cj"),
      Media = _sQPJA
    })
  end
end
function _nIIaJ:On_2LO(target)
  if _kOc >= 100 then
    _Urwigo.MessageBox({
      Text = _bKb4("+*3P{t\023(A3\029{C\029C3y*tV3{C3v\029C3-*AVL\127A\029C3*Cv3\027tVQ{\029t(Ax3P\029/}%\029(3u\029{/3v\029t3't\029{\023\029t3PV%/3f*3\023\127((\029C3Q\029IVLLAj"),
      Media = _hfx,
      Callback = function(action)
        if action ~= nil then
          _kOc = _kOc - 100
          _DY1()
          if not Player:Contains(_L3Ot) then
            local _rndChoiceValue = math.random()
            if _rndChoiceValue < 0.333333333333333 then
              _Urwigo.MessageBox({
                Text = _bKb4("+*3\029tTt\029{\023(A3\029{C\02930\127((\029t\027{(AV/\0293*Cv3C\127e{T{\029t(A3({\0293eVt({}%A{T3f*L3-*(T\127Q\029(}%\127}%Aj"),
                Media = _AV4_,
                Callback = function(action)
                  if action ~= nil then
                    _L3Ot:MoveTo(Player)
                  end
                end
              })
            else
              _Urwigo.MessageBox({
                Text = _bKb4("+{t3T\029/{CTA3\029(3\029{C3z\027{\029/f\029*T3f*3\029tTt\029{\023\029C3\127Q\029t3/\029{v\029t3e\029t/{\029t(A3+*3\029(3P{\029v\029tj3:{\029//\029{}%A3e\029t(*}%(A3+*3\029(3\029{C\023\127}%3CV}%L\127/~"),
                Media = _hfx
              })
            end
          else
            _Urwigo.MessageBox({
              Text = _bKb4("\024L3-*AVL\1273{(A3I\029{C3z\027{\029/f\029*T3L\029%tx3P\029/}%\029(3v{t3T\029\023\127\029//Aj")
            })
          end
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _bKb4("+*3%\127(A3I\029{C\029C3y*tV3L\029%t3{C3+\029{C\029t3u\127(}%\029j"),
      Media = _hfx
    })
  end
end
function _CK6:On_ExbVi(target)
  if _kOc >= 180 then
    _kOc = _kOc - 180
    _DY1()
    _Urwigo.MessageBox({
      Text = _bKb4("+*3t\029{}%(A3v\029L3:\029tI\127\029*\023\029t3Wx5\0063y*tV3*Cv3C{LL(A3v\127\023*\029t3+\029{C\0293M*T\029/3G*AA\029tL{/}%\020y{(3\029CAT\029T\029Cj6\0169K6\0169K+*3t{\029}%(A3I*tf3v\127t\127C3\0203%Lx3(*\029((/{}%x3v\029t3'\029t*}%3P\029}IA3\029{C3P\127tL\029(x3PV%/{T\029(3'\029\023*\029%/3{C3+{tj3'\029t\127v\0293\127/(3+*3T\029C*\029((/{}%3\127C\023\127CT\029C3P{//(A3v\127(3y{(3f*3(}%/\029}I\029Cx3\023\127\029//A3+{t3\029{Cx3PV%\029t3v{\0293't*Cvf*A\127A\029C3IVLL\029C3*Cv3+*3P{t\023(A3v\127(3y{(3\127CT\029P{v\029tA3P\029Tj")
    })
  else
    _Urwigo.MessageBox({
      Text = _bKb4("+*3%\127(A3C{}%A3T\029C*\029T\029Cv3'\029/v3v\127Q\029{j3ye\029CA*\029//3(V//A\029(A3+*3+{}%3C\127}%3\029{C\029L3'\029/v\127*AVL\127A\029C3*L(\029%\029Cj")
    })
  end
end
function _D0GCK:On_kITM(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("+tj3^\127*(\029t~6\0169K6\0169K0\127(3L\127}%\029C3z{\0293v\029CC3%{\029t~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\024}%3P\127t3{L3C\127%\029C3Mt\127CI\029C%\127*(3\127/(39\029\023\029t\029CA3\023*\029t3\029{C\029C3:VtAt\127T3f*L3u%\029L\1273v\029t3\\Qv*IA{VC3eVC3GVtvV\027\023\029tC3L{A3*CI/\127t\029t3uVv\029(*t(\127}%\0293\029{CT\029/\127v\029Cj3+{\0293Q\029{(\027{\029//V(\0293-C\127/NA{I3v\029t3M{//\029tP*t(A3%\127A3{C3Z\127}%It\029{(\029C3TtV((\0293-*\023L\029tI(\127LI\029{A3\029tt\029TAj3+\029t3Z\127}%e\029tQ\127Cv3v\029t3-CA{%{(A\127L{C{I\127%\029t(A\029//\029t3P{//3C*C3\029{C3'\029T\029CL{AA\029/3T\029T\029C39{Cv(P*t(A\127//\029tT{\0293\029t\023{Cv\029Cj6\0169K6\0169K-/(3v\127CC3\029{C3G\029v{f{C\029t3%{\029t3%\029tT\029t*\023\029C3P*tv\029x3QVA3{}%3L{}%3\127Cx3v\029C3Z\127//3f*3*\029Q\029tC\029%L\029Cj"),
      Media = _eXSH
    },
    {
      Text = _bKb4("|Cv3IVCCA\029C3z{\0293(}%VC3\029AP\127(3\029CAv\029}I\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("+\029t3uVA\0293(}%\029{CA3L{A3\029{C\029L3TtV((\029C3G\029((\029t3\029t(AV}%\029C3PVtv\029C3f*3(\029{Cj6\0169K6\0169K'\029C\127*\029t\029(3I\127CC3{}%3\127Q\029t3\029t(A3C\127}%3v\029t3\\Qv*IA{VC3(\127T\029Cj3"),
      Media = _eXSH
    },
    {
      Text = _bKb4("MV\029CC\029C3z{\0293v{\0293uVv\029(f\029{A3\029AP\127(3\029{CTt\029Cf\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("+\127(3L*((3(V3T\029T\029C3Wd\017\006\0063|%t3T\029P\029(\029C3(\029{Cj"),
      Media = _eXSH
    },
    {
      Text = _bKb4("'*Ax3v\127CI\029j3\024}%3L\029/v\0293L{}%3(\027\127\029A\029t3Q\029{3\024%C\029Cj"),
      Media = _tiVos
    }
  }, function(action)
    _D0GCK.Commands._kITM.Enabled = false
  end)
end
function _eg3q:On_BYM5o(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("'*A\029C3u\127Tx3P{\0293I\127CC3{}%3\024%C\029C3%\029/\023\029C~"),
      Media = _Jr9X
    },
    {
      Text = _bKb4("0\127(3e\029tI\127*\023\029C3z{\0293%{\029t~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\\%x3P{t3%\127Q\029C3\127//\029(3LV\029T/{}%\0293{L3-CT\029QVAj6\0169K9\029{C{T*CT(\127tA{I\029/x3\016\127QN(\127}%\029Cx37\023/\029T\029\027tVv*IA\029jjj6\0169K6\0169K+{\029(\02930V}%\0293({Cv3v{\0293Z\029*}%AA*\029}%\029t3{L3-CT\029QVA3\023*\029t3C*t3dx\022\0223y*tV3(VP{\0293v{\029(\02937/\127(A{I/*\027\029j3M{Cv\029t3/{\029Q\029C3({\029.3z{\0293IV(A\029A3\127*}%3C*t3Wx\001X3y*tVj"),
      Media = _Jr9X,
      Buttons = {
        _bKb4("\024}%3C\029%L\029jjj"),
        _bKb4("l\029{Cx3v\127CI\029j")
      }
    }
  }, function(action)
    if action == "Button1" == true then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("0\127(3(V//3{}%3C*t3I\127*\023\029C~3+\029{C3\016/{}I3P\127Cv\029tA3eVC3v\029C3Z\029*}%AA*\029}%\029tC3f*t3b*\027\0293*Cv3P{\029v\029t3f*t*\029}Ij"),
          Media = _tiVos,
          Buttons = {
            _bKb4("b*\027\029"),
            _bKb4("Z\029*}%AA*\029}%\029t")
          }
        }
      }, function(action)
        if action == "Button1" == true then
          if not Player:Contains(_pgd) then
            if _kOc >= 145 then
              _pgd:MoveTo(Player)
              _kOc = _kOc - 145
              _DY1()
              _Urwigo.MessageBox({
                Text = _bKb4("+*3Q\029f\127%/(A3v{\0293b*\027\0293*Cv3e\029t\127Q(}%{\029v\029(A3+{}%j"),
                Media = _tiVos
              })
            else
              _Urwigo.MessageBox({
                Text = _bKb4("yCA(}%*/v{T\029C3z{\029x3\127Q\029t3v\127(3t\029{}%A3/\029{v\029t3C{}%Aj"),
                Media = _Jr9X
              })
            end
          else
            _Urwigo.MessageBox({
              Text = _bKb4("yCA(}%*/v{T*CTx3/\029{v\029t3({Cv3v{\0293T\029t\127v\0293\127*(e\029tI\127*\023Aj"),
              Media = _Jr9X
            })
          end
        elseif action == "Button2" == true then
          if _kOc >= 399 then
            _kOc = _kOc - 399
            _DY1()
            _Urwigo.MessageBox({
              Text = _bKb4("+*3Q\029f\127%/(A3v{\0293u*\029}%\029t3*Cv3Q\029T{CC(A3(V\023VtA3+{t3Tt*\029Cv/{}%(A3v{\0293^\127\029Cv\0293f*3t\029{C{T\029Cj6\0169K6\0169Kl\127}%3\029{C3\027\127\127t3G{C*A\029C3(A\029//(A3+*3\029t(}%tV}I\029C3\023\029(Ax3v\127((3+*3v{\02937\127}I*CT3Q\029t\029{A(3e\029tQt\127*}%A3%\127(A3*Cv3({\0293I\029{C\0293P\029{A\029t\029C3u*\029}%\029t3\029CA%\127\029/Aj"),
              Media = _tiVos
            })
          else
            _Urwigo.MessageBox({
              Text = _bKb4("yCA(}%*/v{T\029C3z{\029x3\127Q\029t3v\127(3t\029{}%A3/\029{v\029t3C{}%Aj"),
              Media = _Jr9X
            })
          end
        else
          _Urwigo.MessageBox({
            Text = _bKb4("\024}%3I\127CC3L{}%3C{}%A3\029CA(}%\029{v\029Cj6\0169K"),
            Media = _Jr9X
          })
        end
      end)
    end
  end)
end
function __KA:On_rRXrj(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("'*A\029C3u\127Tx6\0169K6\0169Kz{\0293L*\029((\029C3^\127*\027AIVLL{((\127t3yt/P\029{C3(\029{Cj"),
      Media = _tiVos
    },
    {
      Text = _bKb4("'\029C\127*j3z{Cv3z{\0293\024C(\027\029IAVt3^*Q\029t~"),
      Media = _0izE
    },
    {
      Text = _bKb4("'\029C\127*j6\0169K6\0169K0\127(3IV\029CC\029C3z{\0293L{t3*\029Q\029t3v\029C3Z\127//3(\127T\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("0{t3%\127Q\029C3%{\029t3v{\0293b\029{}%\0293\029{C\029(39\029}%A(\127CP\127/A\029(j6\0169Kz\029{C\0293z\029It\029A\127\029t{C3%\127A3{%C3%\029*A\0293G{AA\127T3T\029\023*Cv\029Cx3\127/(3({\0293\127*(3v\029t3G{AA\127T(\027\127*(\0293P{\029v\029tI\127Lj36\0169K6\0169Kz{\0293%\127A3v\127CC3(V\023VtA3v{\02937V/{f\029{3\127CT\029t*\023\029Cj6\0169K6\0169K0{t3%\127Q\029C3%{\029t3\127//\029(3T\127Cf3T\029C\127*3*CA\029t(*}%Ax3IVCCA\029C3\127Q\029t3C{}%A(3\029CAv\029}I\029Cx3P\127(3*C(3P\029{A\029t%\127/\023j6\0169K6\0169K\024}%3%\127Q\0293T\029t\127v\0293CV}%3\029{C\029C3\127Cv\029t\029C3Z\127//3t\029{CQ\029IVLL\029Cj3z{\0293IV\029CC\029C3L{}%3\127Q\029t3i\029v\029tf\029{A3\127Ct*\023\029Cx3P\029CC3z{\0293^{/\023\0293Q\029CV\029A{T\029Cj6\0169KG\029{C\0293l*LL\029t3/\127*A\029A3sXs5\022\006j6\0169K\016{AA\0293%\127/A\029C3z{\0293L{}%3*\029Q\029t3v{\0293ytL{AA/*CT\029C3\127*\0233v\029L3b\127*\023\029Cv\029C.6\0169K"),
      Media = _0izE
    },
    {
      Text = _bKb4(":{\029/3yt\023V/Tj6\0169K6\0169K\024}%3(}%\127*3L{}%3%{\029t3CV}%3\029AP\127(3*Lj"),
      Media = _tiVos
    }
  }, function(action)
    _9C2.Description = _9C2.Description .. _bKb4("6\0169Kyt/P\029{C\0173sXs5\022\006")
    _D0GCK:MoveTo(_0s_an)
    __KA:MoveTo(nil)
  end)
end
function _KNFo:On_fBf(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("+*3C\127\029%\029t(A3v{}%3eVt({}%A{T3v\029L3^*Cvj3\024CC\029t/{}%3I\127\029L\027\023(A3+*3L{A3+\029{C\029t3MNCV\027%VQ{\029j3\"CQ(\027[-/(3v{\029(\029t3P{\029v\029t3\127C\023\127\029CTA3f*3IC*tt\029Cx3P{t\023(A3+*3{%L3v{\02930*t(A3%{Cj6\0169K6\0169K'{\029t{T3(}%C\127\027\027A3\029t3v\127C\127}%3*Cv3f{\029%A3v\127CC3(}%P\127CfP\029v\029/Cv3L{A3v\029t30*t(A3\127Qj37*%x3T\029(}%\127\023\023Aj"),
      Media = _gLzns
    }
  }, function(action)
    _KNFo.Visible = false
    _IUk:MoveTo(nil)
    _iMLq = true
  end)
end
function _t4bNx:On_cNF8(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("\016j39\029A{(/{A~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\018\127x3P\127(3I\127CC3{}%3\023*\029t3z{\0293A*C~"),
      Media = _LvPm
    },
    {
      Text = _bKb4("'*A\029C3u\127Tx6\0169K6\0169K\024}%3Q{C3\024C(\027\029IAVt3^*Q\029t3*Cv3\029tL{AA/\0293{C3\029{C\029L3GVtv\023\127//j6\0169KMV\029CC\029C3z{\0293L{t3(\127T\029Cx3PV3({\0293%\029*A\0293G{AA\127T3T\029T\029C3Wdj\006\0063|%t3P\127t\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\024}%~36\0169K\024}%3P\127t3\127*\0233v\029L30\029T3%{\029t3%\029t3*Cv3%\127Q\0293{C3\029{C\029L39\029(A\127*t\127CA3f*3G{AA\127T3T\029T\029((\029Cj3\"CQ(\027[6\0169K6\0169KGVtv\023\127//3(\127TA\029C3({\029~30\029t3{(A3v\029CC3T\029(AVtQ\029C~"),
      Media = _LvPm
    },
    {
      Text = _bKb4("+\029t39\029}%A(\127CP\127/Ax3Q\029{3v\029L3z{\0293%\029*A\0293\029{C\029C3u\029tL{C3%\127AA\029Cx3P*tv\0293AVA3{C3(\029{C\029L3\016*\029tV3\127*\023T\029\023*Cv\029Cj6\0169K6\0169KM\127CC3{tT\029Cv3i\029L\127Cv3\024%t3-/{Q{3Q\029(A\127\029A{T\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\018\127x3{}%3P\127t3eVC3}\127j3W\vj\006\0063|%t3\0203W\001j\006\0063|%t3CV}%3{C3v\029L39\029(A\127*t\127CAj3+\1273T\127Q3\029(3i\029v\0293G\029CT\0293b\029*A\0293v{\0293L{}%3T\029(\029%\029C3%\127Q\029Cj6\0169K6\0169K\024}%3%\127AA\0293v\029C3u\029tL{C3\127Q(\127T\029C3L*\029((\029Cx3v\1273({}%3\029{C3:\029tAt\029A\029t3v\029t30\127((\029t(}%*Af\027V/{f\029{3L{A3L{t3At\029\023\023\029C3PV//A\029j"),
      Media = _LvPm
    },
    {
      Text = _bKb4("MV\029CC\029C3z{\0293L{t3(\127T\029Cx3PVt*L3\029(3Q\029{3\024%t\029L3ut\029\023\023\029C3L{A3v\029L3-CP\127/A3%\029*A\0293T{CT~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("yt3%\127A3\023*\029t3L{}%3\029{C\029C37tVf\029((3T\029PVCC\029Cj3+{\0293\127/A\0293^\029=\0293eVL3z\029T\029/I/*Q3PV//A\0293*C(3e\029tQ{\029A\029C3/\127((\029Cx3%{\029t3\127*\0233v\029L3z\029\0293L{A3c\127}%A\029C3f*3\023\127%t\029Cj6\0169K6\0169K\016\029(A{LLA3P\127t3({\0293\029(3\127*}%x3v{\0293v\029C3\127tL\029C3M\029t/3*LT\029Qt\127}%A3%\127Aj3z{\0293P\127t3(AV}I(\127*\029tx3v\127((3\029t3v\029C3Z\127//3T\029PVCC\029C3%\127A3*Cv3%\127A3T\029vtV%Ax3v\127((3v\127(3ZV/T\029C3\023*\029t3*C(3\127//\0293%\127Q\029C3P{tvj3:{\029//\029{}%A3Q{C3{}%3i\1273(}%VC3v\029t3C\127\029}%(A\029~"),
      Media = _LvPm
    },
    {
      Text = _bKb4(":{\029/\029C3+\127CI3\023*\029t3\024%t\0293\024C\023VtL\127A{VCj6\0169K\024}%3L\029/v\0293L{}%3Q\029{3\024%C\029Cx3P\029CC3{}%3CV}%3Zt\127T\029C3%\127Q\029j"),
      Media = _tiVos
    }
  }, function(action)
    _7CFc.Complete = true
  end)
end
function _joD:On__7bS(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("l\029*T{\029t{T3Q\029At{AA(A3v*3v\029C3b\127v\029C3*Cv3(}%\127*(A3+{}%3*Lj6\0169K6\0169K^{\029t3T{QA3\029(3\127//\029(3P\127(3v\127(3&\127}%\029t%\029tf3Q\029T\029%tAj36\0169K\024C3\029{C\029t3t{\029({T\029C3:{At{C\0293\127C3v\029t30\127Cv3\029CAv\029}I(A3+*3\029{C\0293T\127Cf\0293z\127LL/*CT3eVC3&V{C(j6\0169K6\0169K+\127t*CA\029t3\029{C3G{C{(%*AA/\0293(VP{\0293v\029C3\029=At\029L3(\029/A\029C\029C3Y'\029tL\127CN(3C\029=A3'\029V}\127}%\029Y3\0203&V{C6\0169K"),
      Media = _tiVos
    },
    {
      Text = _bKb4("-C3\029{C\029t3\127Cv\029t\029C30\127Cv3\029CAv\029}I(A3+*3\029{C\0293IVL\027/\029AA\0293&\127}%\029t\127*(t*\029(A*CTj3z{\0293\029CA%\127\029/A3\029{C\029C3^*A3L{A3v\029L3'tV*Cv(\027\029\127I\020bVTV3*Cv3\029{C\0293'*\029tA\029/A\127(}%\0293v{\0293(\029/Q(A3v\029t3TtV\029((A\029C3\029tP\029{A\029tA\029C3&\127}%\029\127*(t*\029(A*CT37/\127Af3Q{\029A\029Aj3+\029{C\0293-*T\029C3\023\127CT\029C3\127C3f*3T/\127\029Cf\029Cx3v\029CC3+*3At\127\029*L(A3eVC3\127//3v\029C3'\029T\029C(A\127\029Cv\029Cx3v{\0293+*3vVtA3*CA\029tQt{CT\029C3I\127CC(A\0173G*/A{AVV/x3|:3b\127L\027\029x3z\027{\029T\029/x3G\127TC\029A%\029Q\029tx3z}%/\127*}%QVVAx3Z/*=IVCv\029C(\127AVtj6\0169K+*3\023*\029%/(A3+{}%3P{\0293\029{C3&VPQVN3{L3P{/v\029C30\029(A\029Cj3-//\029{C3\127*\0233+{}%3(\029/Q(A3*Cv3+\029{C\0293y&'-3T\029(A\029//Aj3+\127(3L*((3Zt\029{%\029{A3(\029{Cj6\0169K6\0169K-/(3Q\029(VCv\029t\029(3^{T%/{T%A3T{QA3\029(3\127/(3-IA{VC(\127CT\029QVA3\029{C3&%\029\127AQVVI3L{A3v\029C3bV\029(*CT\029C3\023*\029t3*\029Q\029t3W\006\0063G*/A{(3*Cv3GN(A\029t{\029(3v\029t3|LT\029Q*CTj3+*3(}%\127*v\029t(Ax3v\029CC3v\127(3P{v\029t(\027t{}%A3({}%3L{A3+\029{C\029L3y%t\029CIVv\029=3*Cv3v\029C3'*{v\029/{C\029(3eVC3'tV*Cv(\027\029\127Ij"),
      Media = _tiVos
    },
    {
      Text = _bKb4("+{t\029IA3*\029Q\029t3v\029L3:\029tI\127*\023(At\029(\029C3\029CAv\029}I(A3+*3\029{C3TtV((\029(3z}%{/v\0176\0169K6\0169K^\029*A\0293\127//\0293-CT\029QVA\0293f*t3^\127\029/\023A\0293v\029(3CVtL\127/\029C37t\029{(\029(j6\0169K+{t3(AV}IA3v\029t3-A\029L3*Cv3+*3Q\029At\127}%A\029(A3\127//\0293-tA{I\029/3L{A3CV}%3TtV\029((\029t\029L3\024CA\029t\029((\029j"),
      Media = _tiVos
    }
  }, function(action)
    if not Player:Contains(_wsY6) then
      _joD.Commands._hFEx.Enabled = true
    end
    if not Player:Contains(_x4L) then
      _joD.Commands._8vw.Enabled = true
    end
    if not Player:Contains(_4Ukz0) then
      _joD.Commands._DVC.Enabled = true
    end
  end)
end
function _joD:On_DVC(target)
  if _kOc >= 699 then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4("+*3T\029%(A3\127*\0233v\029C3:\029tI\127\029*\023\029t3f*3*Cv3P{t(A3\023t\029*Cv/{}%3Q\029Tt*\029((Aj"),
        Media = _tiVos
      },
      {
        Text = _bKb4("'*A\029C3u\127Tx3{}%3%\127\029AA\0293T\029tC3v{\0293\029tP\029{A\029tA\0293&\127}%\029\127*(t*\029(A*CTj"),
        Media = _tiVos
      },
      {
        Text = _bKb4("y{C\0293(\029%t3T*A\02930\127%/j3G\127C3L\029tIAx3v\127((3z{\0293\127*\0233v\029L30\029T3f*L37tV\023{3({Cvj"),
        Media = _rc3v
      },
      {
        Text = _bKb4("zV//3{}%3\024%C\029C3v{\0293-tA{I\029/3\029{C\027\127}I\029C~"),
        Media = _rc3v
      },
      {
        Text = _bKb4("\018\1273Q{AA\029j"),
        Media = _tiVos
      },
      {
        Text = _bKb4("+\127(3L\127}%A3v\127CC3 x\022\0223y*tVj"),
        Media = _rc3v
      },
      {
        Text = _bKb4("+*3*\029Q\029tT{Q(A3v\029L3:\029tI\127\029*\023\029t3+\029{C3'\029/v3T\029C\127*3\127QT\029f\127\029%/A3*Cv3C{LL(A3+\029{C\029C3\016\029*A\029/3\029CAT\029T\029Cj"),
        Media = _tiVos
      }
    }, function(action)
      _kOc = _kOc - 699
      _DY1()
      _4Ukz0:MoveTo(Player)
      _joD.Commands._DVC.Enabled = false
    end)
  else
    _Urwigo.OldDialog({
      {
        Text = _bKb4("+*3%\127(A3C{}%A3T\029C*\029T\029Cv3'\029/v3v\127Q\029{j3ye\029CA*\029//3(V//A\029(A3+*3\127L3C\127%\029C3'\029/v\127*AVL\127A\029C3\029AP\127(3'\029/v3\127Q%\029Q\029Cj"),
        Media = _tiVos
      }
    })
  end
end
function _joD:On_hFEx(target)
  if _kOc >= 480 then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4("+*3Q{AA\029(A3v\029C3:\029tI\127\029*\023\029t3v{t3v\029C3Y'\029tL\127CN(3C\029=A3'\029V}\127}%\029tY3\0203&V{C3\127*(3v\029t3:{At{C\0293f*3T\029Q\029C3*Cv3*\029Q\029tT{Q(A3{%L3v\029C3\016\029At\127T3eVC3\001x5\0063y*tV3C\127A*\029t/{}%3\027\127((\029Cvj"),
        Media = _tiVos
      }
    }, function(action)
      _kOc = _kOc - 480
      _DY1()
      _wsY6:MoveTo(Player)
      _joD.Commands._hFEx.Enabled = false
    end)
  else
    _Urwigo.OldDialog({
      {
        Text = _bKb4("+*3%\127(A3C{}%A3T\029C*\029T\029Cv3'\029/v3v\127Q\029{j3ye\029CA*\029//3(V//A\029(A3+*3\127L3C\127%\029C3'\029/v\127*AVL\127A\029C3\029AP\127(3'\029/v3\127Q%\029Q\029Cj"),
        Media = _tiVos
      }
    })
  end
end
function _joD:On_8vw(target)
  if _kOc >= 299 then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4(":Vt({}%A{T3C{LL(A3+*3v\127(3\029v/\0293'\029\023\127\029%tA3eVC3v\029L3:\029tI\127\029*\023\029t3{C3yL\027\023\127CT3*Cv3I/\127\027\027(A3eVt({}%A{T3v\029C3+\029}I\029/3\127*\023x3*CA\029t3v\029L3({}%3v{\0293ut\127}I{CTC*LL\029t3e\029tQ{tTAj6\0169K6\0169K+\127((3+*3v\029L3:\029tI\127\029*\023\029t3v{\0293T\029P*\029C(}%A\029C35x\022\0223y*tV3T{Q(Ax3L\029tI(A3+*3I\127*L3eVt3zA\127*C\029Cj"),
        Media = _tiVos
      }
    }, function(action)
      _kOc = _kOc - 299
      _DY1()
      _x4L:MoveTo(Player)
      _joD.Commands._8vw.Enabled = false
    end)
  else
    _Urwigo.OldDialog({
      {
        Text = _bKb4("+*3%\127(A3C{}%A3T\029C*\029T\029Cv3'\029/v3v\127Q\029{j3ye\029CA*\029//3(V//A\029(A3+*3\127L3C\127%\029C3'\029/v\127*AVL\127A\029C3\029AP\127(3'\029/v3\127Q%\029Q\029Cj"),
        Media = _tiVos
      }
    })
  end
end
function _67l9:On_cypes(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("G{((3't\029C\127v{\029t~6\0169K6\0169KG\029{C\0293l\127L\0293{(A3^*Q\029tj3\024C(\027\029IAVt3^*Q\029t3eVC3v\029t37V/{f\029{j6\0169K\024}%3\029tL{AA/\0293{C3\029{C\029L3GVtv\023\127//3*Cv3%\127\029AA\0293\029{C3\027\127\127t3Zt\127T\029C3\127C3z{\029j"),
      Media = _tiVos
    },
    {
      Text = _bKb4("y{C3GVtv~3^{\029t~6\0169K0\029t3P*tv\0293v\029CC3*LT\029Qt\127}%A~3^V\023\023\029CA/{}%3I\029{C\02930\127((\029t/\029{}%\029x3v{\0293(A{CI\029C3{LL\029t3(V3(}%C\029//j6\0169K6\0169Kz\029/Q(Ae\029t(A\127\029Cv/{}%3Q\029\127CAPVtA\0293{}%3\024%C\029C3v{\0293Zt\127T\029Cx3P\029CC3\029(3\024%C\029C3P\029{A\029t%{/\023Aj"),
      Media = _240K4
    },
    {
      Text = _bKb4("l\029{C3C\029{Cx3I\029{C\02930\127((\029t/\029{}%\029j3+\029t3-CP\127/Ax3v\029t3v\029C3c\127}%AI/*Q3{C3\024%t\029L37tVf\029((3e\029tAt\029A\029C3%\127Ax3P*tv\0293%\029*A\0293\029t(AV}%\029C3{C3(\029{C\029L3\016*\029tV3\127*\023T\029\023*Cv\029Cj6\0169K6\0169KMV\029CC\029C3z{\0293L{t3(\127T\029Cx3PV3z{\0293%\029*A\0293G{AA\127T3{C3v\029t3n\029{A3fP{(}%\029C3W\v\017\006\0063|%t3*Cv3W\001\017\006\0063|%t3P\127t\029C~"),
      Media = _tiVos
    },
    {
      Text = _bKb4("\018\127x3v\1273P\127t3{}%3Q\029{L3ut\127{C{T3*C(\029t\029t3\018*T\029Cv\020z\029T\029/A\020u\029{/C\029%L\029tj36\0169K+\127(3({Cv3/\127*A\029t3\018*T\029Cv/{}%\0293fP{(}%\029C3W\v3*Cv3W53\018\127%t\029Cx3v{\0293A\127\029T/{}%3fP{(}%\029C3WW3*Cv3W 3|%t3Q\029{3*C(3At\127{C{\029t\029Cj6\0169Kz\029%t3\029CT\127T{\029tA\0293i*CT\0293b\029*A\029j3+\127(3I\029CCA3L\127C3%\029*A\0293(VC(A3T\127t3C{}%A3L\029%tj3+{\0293\018*T\029Cv3eVC3\"CQ(\027[%\029*A\0293t\029CCA3vV}%3C*t3CV}%3L{A3\029/\029IAt{(}%\029C3'\127vT\029A(3t*L3*Cv3{CA\029t\029(({\029tA3({}%3I\029{C\029C3+\029*A3L\029%t3\023*\029t3*C(\029t\0293(}%V\029C\0293l\127A*tj6\0169K6\0169K+\127t\0233{}%3\023t\127T\029Cx3P{\029(V3{}%3e\029tv\127\029}%A{TA3P\029tv\029~"),
      Media = _240K4
    },
    {
      Text = _bKb4("+\029t3\016\029({Af\029t3v\029(3c\127}%AI/*Q(3L\029{CA\029x3({\0293%\127\029AA\029C3v\029L3\\\027\023\029t3C\127}%3v\029t3:\029t%\127Cv/*CT3T\029vtV%Aj"),
      Media = _tiVos
    },
    {
      Text = _bKb4("+\127L\127/(3P\127t3{}%3\127*}%3\029}%A3(\127*\029tx3v\127((3v{\029(\029t3MVLV\029v{\127CA3L{A3(\029{C\029L3z}%L{\029t\029CA%\029\127A\029t3v\127(3'\029t{}%A3*\029Q\029tf\029*T\029C3IVCCA\029j3-Q\029t3v\029(P\029T\029C3Qt{CT3{}%3vV}%3I\029{C\029C3*L3\019*Cv3P\029CC3v\127CC3C{}%A3\127*\0233(V3\027/*L\027\0293-tA3*Cv30\029{(\029\fj6\0169K6\0169K\024}%3L*((3C*C3P{\029v\029t3/V(x3v{\0293z\029T\029/\023*\029%t\029t(}%\029{C\020u\029{/C\029%L\029t3P\127tA\029Cj3-*\0233v\029L37/\127C3(A\029%A3%\029*A\0293t*\029}IP\127\029tA(3\029{C\027\127tI\029C3*CA\029t3\016\029t*\029}I({}%A{T*CT3v\029t3z\029{A\029C(\027{\029T\029/j6\0169K6\0169Ky{C\029C3(}%V\029C\029C3u\127T3CV}%x3\024C(\027\029IAVtj"),
      Media = _240K4
    },
    {
      Text = _bKb4("+\127CI\029x3\024%C\029C3\127*}%j"),
      Media = _tiVos
    }
  }, function(action)
    _WL16G.Complete = true
  end)
end
function _pgd:On_5GIBJ(target)
  _k_uy()
end
function _nc00:On_8zD(target)
  _Urwigo.MessageBox({
    Text = _bKb4("y{C3t\029/\127A{e3i*CT\029t3G\127CC3/{\029TA3{C3\029{C\029t3TtV((\029C3\016/*A/\127}%\0293\127L3\016Vv\029Cj3yt3(}%\029{CA3T\029t\127v\0293\127*(3v\029L3Z\029C(A\029t3T\029(\029%\029C3f*3%\127Q\029Cx3\127/(3v\029t3GV\029tv\029t3{%C3eVC3%{CA\029C3*\029Q\029tt\127(}%A3%\127Aj")
  })
end
function _IUk:On_rX1(target)
  _Urwigo.MessageBox({
    Text = _bKb4("'\029C*\029((/{}%3e\029t(\027\029{(A3+*3+\029{C\02930*t(Aj"),
    Media = _tiVos,
    Callback = function(action)
      if action ~= nil then
        _IUk.Commands._rX1.Enabled = false
        _IUk:MoveTo(nil)
      end
    end
  })
end
function _OMz:On_UyCk(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("^*Q\029tjjj"),
      Media = _tiVos
    },
    {
      Text = _bKb4("^{\029t3{(A3^\127*\027AIVL{((\127t3yt/P\029{Cx6\0169K6\0169K\024C(\027\029IAVtx3P{t3%\127Q\029C3T\029%V\029tAx3v\127((3({\0293{C3v\029t3zA\127vA3({Cvj3y(3T{QA3%{\029t3\029{C\029C3GVtv\023\127//x3{C3v\029L3P{t3\029{C\023\127}%3I\029{C\029t/\029{3^{CP\029{(\0293\023{Cv\029Cx3\127C3v\029C\029C3P{t3L{A3*C(\029t\029C3ytL{AA/*CT\029C3\127C(\029Af\029C3IV\029CCA\029Cj6\0169K6\0169K0*\029tv\029C3z{\0293*C(3\029e\029CA*\029//3Q\029{3v{\029(\029L3Z\127//3*CA\029t(A*\029Af\029C~"),
      Media = _0izE
    },
    {
      Text = _bKb4("y{T\029CA/{}%3%\127Q\0293{}%3i\1273|t/\127*Qjjj"),
      Media = _tiVos
    },
    {
      Text = _bKb4("+\029t3u\127AVtA3{(A3T\127t3C{}%A3P\029{A3eVC3\024%t\029L3^VA\029/3\029CA\023\029tCAj3"),
      Media = _0izE
    },
    {
      Text = _bKb4("G%Lx3C*Ci\127x3\029{T\029CA/{}%3%\127Q\0293{}%3T\029t\127v\0293C{}%A3P{tI/{}%3e{\029/3f*3A*Cx3(V//A\0293i\1273\127*}%3\029{C3|t/\127*Q3(\029{Cj6\0169K-}%x3P\127(3(V//(x3{}%3T/\127*Q\0293{}%3IVLL\0293eVtQ\029{j3\024}%3P\029tv\0293L{t3C*t3CV}%3eVt%\029t3\029{C3\027\127\127t3+{CT\0293Q\029(VtT\029C3L*\029((\029Cx3v\029CC3V%C\0293\027\127((\029Cv\0293-*(t*\029(A*CT3I\127CC3{}%3I\029{C\029C3Z\127//3/V\029(\029Cj"),
      Media = _tiVos
    },
    {
      Text = _bKb4("z*\027\029t.6\0169K6\0169K\024}%3(}%{}I\0293\024%C\029C3v{\0293-C(}%t{\023A3\027\029t3zGzj6\0169K6\0169K\016{(3T/\029{}%j"),
      Media = _0izE
    }
  }, function(action)
    _OMz.Name = _bKb4("^\127CvN")
    _OMz.Commands._KDTU.Enabled = true
    _OMz.Commands._UyCk.Enabled = false
    _bn8km.Active = true
  end)
end
function _OMz:On_KDTU(target)
  _Urwigo.MessageBox({
    Text = _bKb4("-%x3v\1273{(A3v{\0293-C(}%t{\023A3v\029(3u\127AVtA\029(j6\0169K+*3V\029\023\023C\029(A3+\029{C3zA{\023A\029A*{3*Cv3f\029{}%C\029(A3v{\0293-C(}%t{\023A3T\127Cf3\029=\127IA3{C3+\029{C\029C3zA\127vA\027/\127Cj3+*3Q{(A3L{A3v\029L3ytT\029QC{(3(\029%t3f*\023t{\029v\029Cj"),
    Media = _R_v,
    Callback = function(action)
      if action ~= nil then
        _OMz.Commands._KDTU.Enabled = false
        _niey9.Commands._DOG.Enabled = true
        _0s_an.Active = true
      end
    end
  })
end
function _OMz:On_VbM(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_b2T)
  end)
end
function _niey9:On_fub(target)
  if _hgZ83.Active == false then
    _hgZ83.Active = true
  else
    _hgZ83.Active = false
  end
end
function _niey9:On_SQyZT(target)
  if _1y8UO.Active == false then
    _1y8UO.Active = true
  else
    _1y8UO.Active = false
  end
end
function _niey9:On_oc6(target)
  if _ggB.Active == false then
    _ggB.Active = true
  else
    _ggB.Active = false
  end
end
function _niey9:On_DOG(target)
  if _0s_an.Active == false then
    _0s_an.Active = true
  else
    _0s_an.Active = false
  end
end
function _niey9:On_8x8Uw(target)
  if _BooaU.Active == false then
    _BooaU.Active = true
  else
    _BooaU.Active = false
  end
end
function _niey9:On_0iSy(target)
  if _bv17.Active == false then
    _bv17.Active = true
  else
    _bv17.Active = false
  end
end
function _niey9:On_SnpP(target)
  if _o6P.Active == false then
    _o6P.Active = true
  else
    _o6P.Active = false
  end
end
function _sAx:On_DSlO_(target)
  if _cgzE == true then
    _Urwigo.OldDialog({
      {
        Text = _bKb4("y{C3t{\029({T\029t3(A\029{C\029tC\029t3M\127L{C3{C3v\029L3\029{C3I/\029{C\029(3Z\029*\029t3/Vv\029tAj")
      }
    })
  elseif _drZvo.Visible == false then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4("z}%\029{C\127t3({Cv3\029{C3\027\127\127t3z}%\127*L(\027t{Af\029t3eVC3+\029{C\029t3-IA{VC3A\127A(\127\029}%/{}%3{L3M\127L{C3T\029/\127Cv\029A3\0203\029{C30*Cv\029tj3+*3%\127(A3\029{C3P\029C{T3z}%*/vT\029\023*\029%/\0293P\029T\029C3v\029t3:\029tP*\029(A*CTx3v{\0293+*3\127L3u\127AVtA3\127CT\029t{}%A\029A3%\127(Aj3-*\0233v\029t3\127Cv\029t\029C3z\029{A\0293Q{(A3+*3\127*}%3Q\029t*%{TAx3v\127((3Z\029*\029t/V\029(}%\029t3{LL\029t%{C3v\127(3%\127/A\029Cx3P\127(3v{\02930\029tQ*CT3e\029t(\027t{}%Aj6\0169K6\0169K+\127(3Z\029*\029t3{(A3i\029v\029C\023\127//(3\127*(3*Cv3+*3\029tI\029CC(A3\029{C3\027\127\127t37\127\027{\029tt\029(A\0293{L3Z\029*\029tj")
      }
    }, function(action)
      _drZvo.Visible = true
    end)
  else
    _Urwigo.OldDialog({
      {
        Text = _bKb4("+{\0293I/\127\029T/{}%\029C3|\029Q\029tt\029(A\0293v\029(3Z\029*\029t(3({Cv3L{A3z}%\127*L3Q\029v\029}IAj6\0169K6\0169KM\029{C3Q\029(VCv\029t(3C\029AA\029t3-CQ/{}Ij")
      }
    })
  end
end
function _JMqC:On_kv9G(target)
  if _cgzE == true then
    _Urwigo.Dialog(false, {
      {
        Text = _bKb4("Zt\029*v{T3\029CA\023\029tC(A3+*3v{\0293z{}%\029t%\029{A(/\127(}%\0293*Cv3Q\029A\127\029A{T(A3v\029C3-*(/V\029(\029tj3zV\023VtA3(\027t{AfA3z}%\127*L3\127*(3v\029t3+*\029(\029j6\0169K6\0169K+{\0293\029t(A\029C3z\029I*Cv\029C3I\127CC(A3+*3\029(3CV}%3IVCAtV//{\029t\029Cx3vV}%3v\127CC3/\127Cv\029A3\029{C3z}%\127*LAtV\027\023\029C3\127*\0233v\029{C\029L3-Cf*T3*Cv3+*3Q\029T{CC(A3\027\127C{(}%3v{\029(\029C3P\029Tf*P{(}%\029Cj")
      },
      {
        Text = _bKb4("+{\0293+*\029(\0293v\029(3Z\029*\029t/V\029(}%\029t(3/\127\029((A3+*3v\127Q\029{3\023\127//\029C3*Cv3v\029t3z}%\127*L3e\029tA\029{/A3({}%3{L3IVL\027/\029AA\029C39\127*Lj")
      }
    }, function(action)
      _cgzE = false
    end)
  else
    _Urwigo.MessageBox({
      Text = _bKb4("+*3%\127(A3Q\029t\029{A(3T\029C*T3z}%\127v\029C3\127CT\029t{}%A\029Aj")
    })
  end
end
function _K0aob:On__xN(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("y{C3t{\029({T\029t3z}%t\029{QA{(}%x3v\029t3Q\029(A{LLA3e{\029/3'\029/v3T\029IV(A\029A3%\127Aj6\0169K+{t\029IA3\127*\0233v\029t3L{A3z\127LA3\127*(T\029/\029TA\029C3-tQ\029{A(\023/\127\029}%\0293/{\029TA3v\029t3\127*\023T\029(}%/\127T\029C\0293u\029tL{CI\127/\029Cv\029t3v\029(3\\\027\023\029t(j")
    },
    {
      Text = _bKb4("+*3T\029%(A3\029{C3P\029C{T3C\127\029%\029t3*Cv3\029CAv\029}I(Ax3v\127((3v\029t3uVA\0293%\029*A\0293C*t3*L3W\v3|%t3\029{C\029C3u\029tL{C3L{A3\029{C\029L3^\029ttC39\029A{(/{A3T\029%\127QA3%\127Aj30\029{A\029t\0293y{CAt\127T*CT\029C3(A\029%\029C3\023*\029t3v\029C3%\029*A{T\029C3u\127T3C{}%A3vt{Cj")
    },
    {
      Text = _bKb4("\024C3\029{C\029L3v\029t3|CA\029t(}%t\127\029CI\0293\023{Cv\029(A3v*3v{\0293(\029%t3Vtv\029CA/{}%3(VtA{\029tA\029C3-IA\029Cj36\0169K6\0169K+\029t3-CP\127/A3(}%\029{CA3\029{C3(\029%t3\127*(T\029I/*\029T\029/A\029(3zN(A\029L3f*t3zVtA{\029t*CT3T\029%\127QA3f*3%\127Q\029Cj3+\127(3/\127\029((A3(VT\127t3v\127(3^\029tf3\029{C\029(3\127/A\029Cx3\027{CT\029/{T\029C3\024C(\027\029IAVt(3%V\029%\029t3(}%/\127T\029Cj36\0169K6\0169K0VPx3\023\127(f{C{\029tA3Q\029At\127}%A\029(A3v*3v{\0293-IA\029Cj6\0169Kz{\0293({Cv3(VPV%/3C\127}%3l\127L\029Cx3\127/(3\127*}%3C\127}%3+\127A*L3(VtA{\029tA3*Cv3\127*}%3C\127}%3v\029L3l\127L\029C3v\029(3M/{\029CA\029Cj6\0169Ky{CL\127/3L\029%t3Q\029t\029*(A3+*3\029(x3v\127((3+*3v\029C3uVA\029C3C{}%A3L\029%t3f*3b\029Qf\029{A\029C3I\029CC\029C/\029tC\029C3IVCCA\029(Aj3+*3Q{(A3+{t3({}%\029tx3v\127((3\024%t3e{\029/\0293'\029L\029{C(\127LI\029{A\029C3T\029%\127QA3%\127\029AA\029Aj")
    },
    {
      Text = _bKb4("+V}%3P\127\029%t\029Cv3v*3v{\0293-IA\029C3(V3Q\029At\127}%A\029(A3*Cv3*\029Q\029t3v\127(3b\029Q\029C3({CC{\029t(Ax3\023\127\029//A3+{t3\127*\023x3v\127((3%{\029t3{tT\029Cv3\029AP\127(3C{}%A3(A{LLAj")
    }
  }, function(action)
    if _NUsb.Active == true then
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("+*3(}%\127*(A3CV}%3\029{CL\127/3T\127Cf3T\029C\127*3%{C3*Cv3\127*\0233\029{CL\127/3{(A3\127//\029(3I/\127tj6\0169K6\0169Kn*(\127\029Af/{}%3f*t3zVtA{\029t*CT3v\029t3-IA\029C3C\127}%3l\127L\0293*Cv3-IA*\127/{A\127\029A3%\127A3v\029t3\027\029t\023\029IA{VC{(A{(}%\0293-CP\127/A3v{\0293-IA\029C3CV}%3L{A3Z\127tQL\127tI{\029t*CT\029C3e\029t(\029%\029Cj3+\029{C\0293\016\029P*Cv\029t*CT3(A\029{TA3{C(3't\029Cf\029C/V(\029j6\0169K6\0169K|Cv3\029{C\0293-IA\0293{(A3C{}%A3T\029C\127*3v\127x3PV3({\0293(\029{C3(V//A\029j"),
          Media = _tiVos
        },
        {
          Text = _bKb4("0\127%t(}%\029{C/{}%3%\127AA\0293\029(3v\029t3u\127\029A\029t3(V3\029{/{Tx3v{\0293-IA\0293f*t*\029}I3f*3(A\029}I\029Cx3v\127((3\029t3({}%3*L3\029{C\02930{Cf{TI\029{A3e\029tA\127C3%\127Aj36\0169K6\0169K+*3f{\029%(A3v{\0293Q\029At\029\023\023\029Cv\0293-IA\0293%\029t\127*(3*Cv3I\127CC(A3A\127A(\127\029}%/{}%3:\029t\127\029Cv\029t*CT\029C3\127C3\029{C\029L3v\029t3+VI*L\029CA\0293\023\029(A(A\029//\029Cj3M\029{C30*Cv\029tx3v\029CC3{C3+\029{C\029t3Zt\029{f\029{A3IVtt{T{\029t(A3+*3zA\029t\029VQ{/v\029t3\023*\029t3\029{C\029C3\016*}%e\029t/\127Tj"),
          Media = _tiVos
        },
        {
          Text = _bKb4("\024C3v\029L3u\029(A\127L\029CA3v\029t37\029t(VC3P*tv\0293\029{C3l\127L\0293\127*(T\029A\127*(}%Aj6\0169K+\029L3-CP\127/A3P\127\029t\0293v\127(3P\127%t(}%\029{C/{}%3(V\023VtA3\127*\023T\029\023\127//\029Cx3v\127%\029t3L*((A\0293\029t3(A\029tQ\029Cj")
        }
      }, function(action)
        _NUsb.Complete = true
      end)
    else
      _Urwigo.OldDialog({
        {
          Text = _bKb4("+V}%x3{tT\029Cv\029AP\127(3(A{LLA3C{}%Aj6\0169Ky{C\0293M/\029{C{TI\029{A3At*\029QA3v{\02937\029t\023\029IA{VCx3vV}%3+*3IVLL(A3\029{C\023\127}%3C{}%A3v\127%{CA\029tx3P\127(3\029(3{(Aj"),
          Media = _tiVos
        }
      })
    end
  end)
end
function _drZvo:On_sU7(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("'\127Cf3eVt({}%A{T3\127CT\029/(A3+*3L{A3\029{C\029t37{Cf\029AA\0293v{\02937\127\027{\029tt\029(A\0293\127*(3v\029L3Z\029*\029tj36\0169K6\0169K-/(3+*3({\0293+{t3\127*(3v\029t3l\127\029%\0293Q\029At\127}%A\029(A3(A\029//(A3+*3\023\029(Ax3v\127((3\029(3({}%3*L39\029(A\0293\029{C\029t3-IA\0293%\127Cv\029/Aj3+*3I\127CC(A3CV}%3v\029C3l\127L\029C3\016j39\029A{(/{A3\029CAf{\023\023\029tCj6\0169K6\0169K:{\029//\029{}%A3(V//A\029(A3+*3L\127/3L{A3v{\029(\029L3^\029ttC3(\027t\029}%\029Cx3P{\029(V3%{\029t3(\029{C\0293-IA\0293T\029Qt\127CCA3%\127Aj")
    }
  }, function(action)
    _F5M.Complete = true
  end)
end
function _qbp0b:On_8Xe(target)
  if Wherigo.NoCaseEquals(_SV33D, _bKb4("'\029/v")) then
    if _4H7 < 1 then
      _qbp0b:MoveTo(nil)
      _Urwigo.OldDialog({
        {
          Text = _bKb4("+{\0293M\127tA\0293P{tv3\029{CT\029fVT\029Cj6\0169K+{\0293z\029te{}\029%VA/{C\0293\029tt\029{}%\029C3z{\0293*CA\029t3v\029t35\006\006M\127tA\029j")
        }
      })
    else
      _Urwigo.Dialog(false, {
        {
          Text = _bKb4("+*3%\029Q(A3W\0063y*tV3\127Qj"),
          Media = _hfx
        }
      }, function(action)
        _4H7 = _4H7 + -1
        _kOc = _kOc + 1000
        _DY1()
      end)
    end
  end
end
function _4Ukz0:On_1vF(target)
  _Urwigo.Dialog(false, {
    {
      Text = _bKb4("\016\029T\029{(A\029tA3eVC3v\029{C\029L3l\029*\029tP\029tQ3/\029T(A3+*3v{\0293C\029*\0293&\127}%\029\127*(t*\029(A*CT3\127C3*Cv3\023*\029%/(A3v{}%3v\127v*t}%3T/\029{}%3P{\0293\029{C37tV\023{\020&\127}%\029tj")
    }
  }, function(action)
    _4Ukz0.Visible = false
  end)
end
function _DY1()
  _3_QL.Description = (_bKb4("y{C3(}%V\029C\029(3b\029v\029tQ\029*A\029/}%\029C3C\029CC(A3+*3+\029{C3\029{T\029Cj3+\127(3%\127(A3+*3*\029Q\029t3v{\0293\018\127%t\0293{LL\029t3T*A3T\029\027\023/\029TAj3|Cv3i\127x3P\127(3(V//3L\127C3v\1273(\127T\029Cx3v*3%\127(A3v\1273\029AP\127(3(}%VC3\023\127(A3\029{Cf{T\127tA{T\029(3{C3v\029{C\029t3^\127Cvx3v\029CC3P\029t3e\029tf{}%A\029A3%\029*Af*A\127T\0293CV}%3\127*\0233v{\029(\0293IVL{(}%\029C3C\029*LVv{(}%\029C3'\029/vQV\029t(\029C3L{A3v\029C3e{\029/\029C3y{C(A\029}I\023\127\029}%\029tCj36\0169K6\0169K-/(3v*3v\029{C\029C3'\029/vQ\029*A\029/3v*t}%(*}%(Ax3(A\029//(A3+*3\023\029(Ax3v\127((3+*3CV}%3") .. _kOc / 100) .. _bKb4("3y*tV3Q\029{3+{t3%\127(Aj")
end
function _k_uy()
  if _v_1Bb <= 3 then
    if Wherigo.NoCaseEquals(_SV33D, _bKb4("M\127*\023%\127*(")) then
      _Urwigo.MessageBox({
        Text = _bKb4("\016\029{3v\029C3T\127Cf\029C3G\029C(}%\029CL\127((\029C3I\127CC(A3v*3I\127*L3\029AP\127(3\029CAv\029}I\029Cj6\0169K6\0169Kb\029v{T/{}%3i\029v\0293G\029CT\0293G*\029//3/{\029TA3%{\029t3e\029t(At\029*Aj3+*3P{v\029t(A\029%(A3v\029t3:\029t(*}%*CT3\029{C\029C3&\024u\\3f*3e\029t\127C(A\127/A\029Cj"),
        Media = _x9U5
      })
    elseif Wherigo.NoCaseEquals(_SV33D, _bKb4("u\127AVtA")) then
      local _rndChoiceValue = math.random()
      if _rndChoiceValue < 0.222222222222222 then
        if _sAx.Visible == false then
          _sAx.Visible = true
          _Urwigo.MessageBox({
            Text = _bKb4("-C3v\029t3zA{tC(\029{A\0293v\029(3\"CQ(\027[9\127*L\029(3\027t\127((\029/A3\029{C3I/\029{C\029(3Z\029*\029t3{C3\029{C\029L3T{T\127CA{(}%\029Cx3L{A3G\127LVt3e\029tI/\029{v\029A\029C3M\127L{Cj"),
            Media = _x9U5
          })
        else
          _v_1Bb = _v_1Bb + 1
          _k_uy()
        end
      elseif _rndChoiceValue < 0.444444444444444 then
        if _1ThD.Visible == false then
          _1ThD.Visible = true
          _Urwigo.MessageBox({
            Text = _bKb4("l\029Q\029C3v\029t3b\029{}%\0293/{\029TA3\029{C3G\029((\029tj3y(3(}%\029{CA3({}%3%{\029tQ\029{3\127Q\029t3*L3\029{C\0293(\029%t3(\027\029f{\029//\02930\127\023\023\0293f*3%\127Cv\029/Cx3P{\0293({\0293eVC3z\027\029f{\127/\029{C%\029{A\029C3v\029t3-tL\029\0293T\029C*AfA3P\029tv\029Cj6\0169K6\0169K-L3't{\023\0233I\127CC(A3v*3v{\0293l*LL\029t3Xsc\016l^3/\029(\029Cj"),
            Media = _x9U5
          })
        else
          _v_1Bb = _v_1Bb + 1
          _k_uy()
        end
      elseif _rndChoiceValue < 0.666666666666667 then
        if _JMqC.Visible == false then
          _JMqC.Visible = true
          _Urwigo.MessageBox({
            Text = _bKb4("\024C3\029{C\029t3e\029tv\029}IA\029C3I/\029{C\029C3l{(}%\0293\023{Cv\029(A3+*3\029{C\029C3\027*Af{T\029Cx3I/\029{C\029C3Z\029*\029t/V\029(}%\029tx3v\029t3+\029{C3^\029tf3%V\029%\029t3(}%/\127T\029C3/\127\029((Aj"),
            Media = _x9U5
          })
        else
          _v_1Bb = _v_1Bb + 1
          _k_uy()
        end
      elseif _rndChoiceValue < 0.888888888888889 then
        if _K0aob.Visible == false then
          _K0aob.Visible = true
          _Urwigo.MessageBox({
            Text = _bKb4(":Vt3v\029L3Z\029C(A\029t3(A\029%A3\029{C3{L\027V(\127CA\029t3z}%t\029{QA{(}%3\127*(3v*CI/\029L3^V/fj"),
            Media = _x9U5
          })
        else
          _v_1Bb = _v_1Bb + 1
          _k_uy()
        end
      else
        _Urwigo.MessageBox({
          Text = _bKb4("+\029{C3\016/{}I3P\127Cv\029tA3{LL\029t3P{\029v\029t3f*3v\029t3b\029{}%\0293v\029(3-CP\127/A(x3\127Q\029t3+*3I\127CC(A3\029{C\023\127}%3I\029{C\029C3^{CP\029{(\0293\029CAv\029}I\029Cj"),
          Media = _x9U5
        })
      end
    elseif Wherigo.NoCaseEquals(_SV33D, _bKb4("c\127}%AI/*Q")) then
      if _KNFo.Visible == false and _iMLq == false and _mBIi == false then
        _KNFo:MoveTo(_ggB)
        _XiM.Active = true
        _Urwigo.Dialog(false, {
          {
            Text = _bKb4("'\029t\127v\0293\127/(3+*3+{}%3\127*\0233v\029L3'\029/\127\029Cv\0293v\029(3c\127}%AI/*Q(3*L(\029%\029C3P{//(Ax3IVLLA3\029{C3f{\029L/{}%3\127TTt\029(({e3\127*((\029%\029Cv\029t30\127}%%*Cv3\127CT\029t\127CCAj3+\029{C\0293MNCV\027%VQ{\0293{(A3\029AP\1273T\029C\127*(V3TtV((3P{\0293+\029{C\0293b\127}%\127CV\027%VQ{\029x3PVQ\029{3/\029AfA\029t\0293\127*\0233\029{C\029t3zI\127/\1273eVC3W\020W\0063\029AP\1273Q\029{3WW3t\127CT{\029tAj")
          },
          {
            Text = _bKb4("\016\029//\029Cv3*Cv3f\127\029%C\029\023/\029A(}%\029Cv3IVLLA3\029t3\127*\0233v{}%3f*3T\029t\127CCAj3+\127(3^\029tf3t*A(}%A3+{t3{C3v{\0293^V(\029CA\127(}%\029j")
          },
          {
            Text = _bKb4("+*3I\127CC(A3+{}%3C{}%A3\029CA(}%\029{v\029Cx3P\127(3+*3A*C3(V//(A\0176\0169K'\029L*\029(\029LVv*(3Vv\029t3P\029T/\127*\023\029C~3\024L3/\029AfA\029C3GVL\029CA3\023\127\029//A3+{t3+\029{C\0293b\127}%\127CV\027%VQ{\0293\029{C3*Cv3v\029t3f\127\029%C\029\023/\029A(}%\029Cv\0293^*Cv3\029t(}%\029{CA3{C3+\029{C\029C3-*T\029C3\027/V\029Af/{}%3C*t3CV}%3P{\0293\029{C3f\127%L\029(3G\029\029t(}%P\029{C}%\029C3\127*\0233z\027\029\029vj30\127\029%t\029Cv3+*3P\029{A\029t3v{\0293z{A*\127A{VC3\127QP\127\029T(Ax3\029CAv\029}I(A3+*3\029{C{T\0293G\029A\029t3P\029{A\029t3\029{C\0293zA\029//\029x3\127C3v\029t3+*3+{}%3{C3z{}%\029t%\029{A3T/\127*Q(Aj")
          },
          {
            Text = (_bKb4("+*3(}%\127\029AfAx3v\127((3v\029t3^*Cv3v{}%3{C3}\127j3") .. _Vobb.Duration) .. _bKb4("3z\029I*Cv\029C3\029{CT\029%V/A3%\127Ax3P\029CC3+*3\018yunu3/V(t\029CC(Aj"),
            Buttons = {
              _bKb4("P\029Tt\029CC\029C")
            }
          }
        }, function(action)
          _Vobb:Start()
        end)
      elseif _t4bNx.Visible == false and _iMLq == true then
        _t4bNx.Visible = true
        _Urwigo.OldDialog({
          {
            Text = _bKb4("-/(3+*3+{}%3\127*\0233v\029L3'\029/\127\029Cv\0293*L({\029%(A3\029CAv\029}I(A3+*3{C3\029{C\029L3\016*\029tV3\016j39\029A{(/{Aj3yt3({AfA3\127C3(\029{C\029L3z}%t\029{QA{(}%3*Cv3\127tQ\029{A\029Aj3+*3Q\029VQ\127}%A\029(A3{%C3\029t(AL\127/3\029{C\0293T\127Cf\02930\029{/\0293*Cv3(A\029//(A3\023\029(Ax3v\127((3\029t3{tT\029CvP{\0293\029{C\0293T\029/Q/{}%\0293'\029({}%A(%\127*A3%\127A3L{A3*Ct\029T\029/L\127\029(({T3TtV((\029C37Vt\029Cj3-*(3{tT\029Cv\029{C\029L3't*Cv3/\127\029*\023A3+{t3v\127(30\127((\029t3{L3G*Cv3f*(\127LL\029C3*Cv3+*3%\127(A3\127*\0233\029{CL\127/3(}%t\029}I/{}%\029C3^*CT\029t3C\127}%3M-yzy.3+*3(}%*\029AA\029/(A3+{}%3*Cv3e\029t(*}%(A3+{}%3P{\029v\029t3\127*\0233+\029{C\0293\029{T\029CA/{}%\0293-*\023T\127Q\0293f*3IVCf\029CAt{\029t\029Cj"),
            Media = _x9U5
          }
        })
      else
        _Urwigo.OldDialog({
          {
            Text = _bKb4("+*3\023{Cv\029(A3C{}%A("),
            Media = _x9U5
          }
        })
      end
    elseif Wherigo.NoCaseEquals(_SV33D, _bKb4("Z\029*\029tP\127}%\029")) then
      if _3AJ3x == 0 then
        _3AJ3x = _3AJ3x + 1
        _Urwigo.OldDialog({
          {
            Text = _bKb4("^{\029t3(}%\029{CA3I\029{C\029t3f*3(\029{Cj"),
            Media = _x9U5
          }
        })
      elseif _3AJ3x == 1 then
        _3AJ3x = _3AJ3x + 1
        _Urwigo.OldDialog({
          {
            Text = _bKb4("+{\0293y{C(\127Af\023\127%tf\029*T\0293(}%\029{C\029C3\127*}%3P\029T3f*3(\029{C"),
            Media = _x9U5
          }
        })
      elseif _3AJ3x == 2 then
        _3AJ3x = _3AJ3x + 1
        _Urwigo.OldDialog({
          {
            Text = _bKb4("0\127%t(}%\029{C/{}%3T{QA3\029(3T\029t\127v\0293\029{C\029C3y{C(\127Af3*Cv3\127//\0293({Cv3\127*(T\029t*\029}IAj"),
            Media = _x9U5
          }
        })
      elseif _3AJ3x == 3 then
        _3AJ3x = _3AJ3x + 1
        _Urwigo.Dialog(false, {
          {
            Text = _bKb4("-/(3+*3+{}%3T\029C\127*\029t3*L({\029%(A3IVLLA3\029{C3l\127}%Q\127t3eVtQ\029{x3v\029t3+{t3\029tf\127\029%/Ax3v\127((3v\127(3M*C(Af\029CAt*L3u\029T\029/3z*\029v3Qt\029CCAj3yt3\029tI/\127\029tA3+{t3\127*}%x3PV3+*3v\127(3n\029CAt*L3\023{Cv\029(Aj"),
            Media = _x9U5
          }
        }, function(action)
          _niey9.Commands._SnpP.Enabled = true
          _o6P.Active = true
        end)
      else
        _Urwigo.OldDialog({
          {
            Text = _bKb4("+*3I\127CC(A3C{}%A(3l\029*\029(3L\029%t3\029CAv\029}I\029Cj"),
            Media = _x9U5
          }
        })
      end
    else
      _Urwigo.MessageBox({
        Text = _bKb4("+*3\023{Cv\029(A3C{}%A(j"),
        Media = _x9U5
      })
    end
  else
    _v_1Bb = 0
    _Urwigo.MessageBox({
      Text = _bKb4("\\QPV%/3+*3\127//\029(3T\029C\127*3\127Q(*}%(A3*Cv3\127*}%3L\029%t\023\127}%3C\127}%(}%\127*(Ax3I\127CC(A3+*3C{}%A(3\029CAv\029}I\029Cj"),
      Media = _x9U5
    })
  end
end
return _Xt61
