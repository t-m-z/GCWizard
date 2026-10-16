require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _ocKm(str)
  local res = ""
  local dtable = "+6\019\025\031c\021Qh-\"a\a`e]_DL=M;{\017%\001l@\015\003O\023\014p<i5*~P/I\020\005|\004>HqYWF7nK\006t\\0d\000rsy1\029,\016)G\022.\018\027mk\fREN?w&\rV$vUC!#\v^(Xg29\024T}\026jfx\t'\nb A\030Z:3B\028[o\002u4z8SJ\b"
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
_VwtHO = Wherigo.ZCartridge()
_jKUq = Wherigo.ZMedia(_VwtHO)
_jKUq.Id = "251a3a5f-d91e-412d-9385-0b193ed99c8a"
_jKUq.Name = _ocKm("3\f\0279\015>")
_jKUq.Description = ""
_jKUq.AltText = ""
_jKUq.Resources = {
  {
    Type = "jpg",
    Filename = "wanderer.jpg",
    Directives = {}
  }
}
_p8mD = Wherigo.ZMedia(_VwtHO)
_p8mD.Id = "102a8b77-7566-4bd2-a0da-79ead7ef5cc2"
_p8mD.Name = _ocKm("*Km$??")
_p8mD.Description = ""
_p8mD.AltText = ""
_p8mD.Resources = {
  {
    Type = "jpg",
    Filename = "imbiss.jpg",
    Directives = {}
  }
}
_M6bVT = Wherigo.ZMedia(_VwtHO)
_M6bVT.Id = "064446c9-3e2e-439d-ba68-2a1ecb54f776"
_M6bVT.Name = _ocKm("N$\006\t9y6`\0173y>{\015\027h$\006\t9\015")
_M6bVT.Description = ""
_M6bVT.AltText = ""
_M6bVT.Resources = {
  {
    Type = "jpg",
    Filename = "Schild_Wurzelfichte.jpg",
    Directives = {}
  }
}
_Rxry = Wherigo.ZMedia(_VwtHO)
_Rxry.Id = "7c4eac1e-970e-4e7a-89f5-656eec07f337"
_Rxry.Name = _ocKm("ty\006LwR\017W\015>\027\f??\0156")
_Rxry.Description = ""
_Rxry.AltText = ""
_Rxry.Resources = {
  {
    Type = "jpg",
    Filename = "Buckow_raus.jpg",
    Directives = {}
  }
}
_yQCf = Wherigo.ZMedia(_VwtHO)
_yQCf.Id = "6c7a23e5-478f-4a7e-b1d0-31b27b2f164a"
_yQCf.Name = _ocKm("qR\015$nt>y\015\006L\0156")
_yQCf.Description = ""
_yQCf.AltText = ""
_yQCf.Resources = {
  {
    Type = "jpg",
    Filename = "Brueckenkreuzung.jpg",
    Directives = {}
  }
}
_e4A = Wherigo.ZMedia(_VwtHO)
_e4A.Id = "2f2c4389-9af5-43ea-8845-5770a430b184"
_e4A.Name = _ocKm("3y>{\015\027h$\006\t9\015")
_e4A.Description = ""
_e4A.AltText = ""
_e4A.Resources = {
  {
    Type = "jpg",
    Filename = "Wurzelfichtefichte.jpg",
    Directives = {}
  }
}
_gPf = Wherigo.ZMedia(_VwtHO)
_gPf.Id = "da1e86e2-d1b0-49eb-9445-b8d20b4de2d9"
_gPf.Name = _ocKm("\018\f?nR\f>n6$i")
_gPf.Description = ""
_gPf.AltText = ""
_gPf.Resources = {
  {
    Type = "jpg",
    Filename = "Daswarnix.jpg",
    Directives = {}
  }
}
_qjKQ = Wherigo.ZMedia(_VwtHO)
_qjKQ.Id = "c89143cc-6020-4eec-a89a-cd92af5c3c7f"
_qjKQ.Name = _ocKm("7>y`m\015>`")
_qjKQ.Description = ""
_qjKQ.AltText = ""
_qjKQ.Resources = {
  {
    Type = "jpg",
    Filename = "Krugberg.jpg",
    Directives = {}
  }
}
_LoNa = Wherigo.ZMedia(_VwtHO)
_LoNa.Id = "0d0d7e0b-e6d6-46c4-8771-2a36825f2643"
_LoNa.Name = _ocKm("7>y`m\015>`\017oy??$\006\t9")
_LoNa.Description = ""
_LoNa.AltText = ""
_LoNa.Resources = {
  {
    Type = "jpg",
    Filename = "Krugberg_Aussicht.jpg",
    Directives = {}
  }
}
_NhJBf = Wherigo.ZMedia(_VwtHO)
_NhJBf.Id = "8f26e37b-991c-435b-aec2-34f0a5641ba2"
_NhJBf.Name = _ocKm("3y>{\015\027h$\006\t9\015\017N\015?9")
_NhJBf.Description = ""
_NhJBf.AltText = ""
_NhJBf.Resources = {
  {
    Type = "jpg",
    Filename = "Wurzelfichte_Rest.jpg",
    Directives = {}
  }
}
_P7q = Wherigo.ZMedia(_VwtHO)
_P7q.Id = "88a39eb8-a4f3-4846-97e0-93b1c8e91c93"
_P7q.Name = _ocKm("7>y`m\015>`\0174\015\027<>\f6<")
_P7q.Description = ""
_P7q.AltText = ""
_P7q.Resources = {
  {
    Type = "jpg",
    Filename = "Krugberg_Feldrand.jpg",
    Directives = {}
  }
}
_jV6 = Wherigo.ZMedia(_VwtHO)
_jV6.Id = "6a6dda13-b0a6-45eb-8831-2807d9759d4e"
_jV6.Name = _ocKm("3\015`R\015$?\015>\017d\015yh\015\027??9\015$6")
_jV6.Description = ""
_jV6.AltText = ""
_jV6.Resources = {
  {
    Type = "jpg",
    Filename = "Abzweig_Teufelsstein.jpg",
    Directives = {}
  }
}
_kuk = Wherigo.ZMedia(_VwtHO)
_kuk.Id = "b06a8b48-818f-4f33-ad6b-c4c86fd207a8"
_kuk.Name = _ocKm("d\015yh\015\027??9\015$6\017t$\027<")
_kuk.Description = ""
_kuk.AltText = ""
_kuk.Resources = {
  {
    Type = "jpg",
    Filename = "Teufelsstein_Schild.jpg",
    Directives = {}
  }
}
_WxX = Wherigo.ZMedia(_VwtHO)
_WxX.Id = "1bd4bcf3-da60-42f2-86ec-d54cc8d2c722"
_WxX.Name = _ocKm("d\015yh\015\027??9\015$6")
_WxX.Description = ""
_WxX.AltText = ""
_WxX.Resources = {
  {
    Type = "jpg",
    Filename = "Teufelsstein.jpg",
    Directives = {}
  }
}
_1yFJ5 = Wherigo.ZMedia(_VwtHO)
_1yFJ5.Id = "69300a66-cd3c-45ab-a305-ea949c58f5ad"
_1yFJ5.Name = _ocKm("3\015`nWwKnd\015yh\015\027??9\015$6")
_1yFJ5.Description = ""
_1yFJ5.AltText = ""
_1yFJ5.Resources = {
  {
    Type = "jpg",
    Filename = "Weg-vom-Teufelsstein.jpg",
    Directives = {}
  }
}
_YQk = Wherigo.ZMedia(_VwtHO)
_YQk.Id = "170bb50e-5490-4d32-ab44-6b345378dc16"
_YQk.Name = _ocKm("3\015`n{yKn\018\f\006\t?m\015>`")
_YQk.Description = ""
_YQk.AltText = ""
_YQk.Resources = {
  {
    Type = "jpg",
    Filename = "Weg-zum-Dachsberg.jpg",
    Directives = {}
  }
}
_x719R = Wherigo.ZMedia(_VwtHO)
_x719R.Id = "2c0ce7fe-5ec6-4c71-823e-ef28ea94c195"
_x719R.Name = _ocKm("\018\f\006\t?m\015>`")
_x719R.Description = ""
_x719R.AltText = ""
_x719R.Resources = {
  {
    Type = "jpg",
    Filename = "Dachsberg.jpg",
    Directives = {}
  }
}
_XjBk = Wherigo.ZMedia(_VwtHO)
_XjBk.Id = "d99270c2-290f-4d97-aec7-688261c5c312"
_XjBk.Name = _ocKm("F>w??\015>n}9\015$6")
_XjBk.Description = ""
_XjBk.AltText = ""
_XjBk.Resources = {
  {
    Type = "jpg",
    Filename = "Grosser-Stein.jpg",
    Directives = {}
  }
}
_1FGp = Wherigo.ZMedia(_VwtHO)
_1FGp.Id = "6f0e6998-80b2-41a8-864c-138911e2d552"
_1FGp.Name = _ocKm("{yKndw>6wR?\015\015")
_1FGp.Description = ""
_1FGp.AltText = ""
_1FGp.Resources = {
  {
    Type = "jpg",
    Filename = "Weg-zum-Tornowsee.jpg",
    Directives = {}
  }
}
_FpB = Wherigo.ZMedia(_VwtHO)
_FpB.Id = "9642c7ea-3c5e-43e9-9b52-605a71506ca9"
_FpB.Name = _ocKm("Fy\01569\t\015>1y\015\027\027\015")
_FpB.Description = ""
_FpB.AltText = ""
_FpB.Resources = {
  {
    Type = "jpg",
    Filename = "Guentherquelle.jpg",
    Directives = {}
  }
}
_2O9 = Wherigo.ZMedia(_VwtHO)
_2O9.Id = "08a524ae-53a3-4919-ab9b-2a7b2182e719"
_2O9.Name = _ocKm("4\015\027<>\f6<")
_2O9.Description = ""
_2O9.AltText = ""
_2O9.Resources = {
  {
    Type = "jpg",
    Filename = "Feldrand.jpg",
    Directives = {}
  }
}
_sl8Hy = Wherigo.ZMedia(_VwtHO)
_sl8Hy.Id = "86475131-6e69-4d83-ac82-666f220d319a"
_sl8Hy.Name = _ocKm("76\015$\"\"")
_sl8Hy.Description = ""
_sl8Hy.AltText = ""
_sl8Hy.Resources = {
  {
    Type = "jpg",
    Filename = "Kneipp.jpg",
    Directives = {}
  }
}
_iKfA = Wherigo.ZMedia(_VwtHO)
_iKfA.Id = "c7f5e46e-c6e2-4e28-9a72-9bd229285da0"
_iKfA.Name = _ocKm("\018$\006L\015>nt\fyK")
_iKfA.Description = ""
_iKfA.AltText = ""
_iKfA.Resources = {
  {
    Type = "jpg",
    Filename = "Dicker-Baum.jpg",
    Directives = {}
  }
}
__CmO = Wherigo.ZMedia(_VwtHO)
__CmO.Id = "d719c00d-d0d9-4940-878a-2a976e1004eb"
__CmO.Name = _ocKm("0w\"h\0156R\015`")
__CmO.Description = ""
__CmO.AltText = ""
__CmO.Resources = {
  {
    Type = "jpg",
    Filename = "Hopfenweg.jpg",
    Directives = {}
  }
}
_rN7M = Wherigo.ZMedia(_VwtHO)
_rN7M.Id = "15cf0551-1beb-46b8-af42-060a14959d0d"
_rN7M.Name = _ocKm("3\015`R\015$?\015>\017(w\0159\0156?9\015$`")
_rN7M.Description = ""
_rN7M.AltText = ""
_rN7M.Resources = {
  {
    Type = "jpg",
    Filename = "Wegweiser.jpg",
    Directives = {}
  }
}
__40u = Wherigo.ZMedia(_VwtHO)
__40u.Id = "88610f6e-afba-44c8-8218-845668bf0877"
__40u.Name = _ocKm("(\027\f99\0156R\015`")
__40u.Description = ""
__40u.AltText = ""
__40u.Resources = {
  {
    Type = "jpg",
    Filename = "Plattenweg.jpg",
    Directives = {}
  }
}
_GJpa = Wherigo.ZMedia(_VwtHO)
_GJpa.Id = "894262f1-e728-44c3-9b05-a036126c3fb1"
_GJpa.Name = _ocKm("3\015`R\015$?\015>\017dw>6wR?\015\015")
_GJpa.Description = ""
_GJpa.AltText = ""
_GJpa.Resources = {
  {
    Type = "jpg",
    Filename = "Wegweiser_Tornowsee.jpg",
    Directives = {}
  }
}
_U9jQG = Wherigo.ZMedia(_VwtHO)
_U9jQG.Id = "68886b52-fcfa-412e-bb92-33b7eb062418"
_U9jQG.Name = _ocKm("t\f<\015?9\015\027\027\015")
_U9jQG.Description = ""
_U9jQG.AltText = ""
_U9jQG.Resources = {
  {
    Type = "jpg",
    Filename = "Badestelle.jpg",
    Directives = {}
  }
}
_qVXc1 = Wherigo.ZMedia(_VwtHO)
_qVXc1.Id = "eb42ad21-10fd-4fe3-9380-c1fcd2a013d5"
_qVXc1.Name = _ocKm("(>$9{\t\f`\0156\015>\017\021y\015\t\027\015")
_qVXc1.Description = ""
_qVXc1.AltText = ""
_qVXc1.Resources = {
  {
    Type = "jpg",
    Filename = "Pritzhagener-Muehle.jpg",
    Directives = {}
  }
}
_eiq2t = Wherigo.ZMedia(_VwtHO)
_eiq2t.Id = "d4e28687-cecb-40d9-86ab-05779b6f2d1d"
_eiq2t.Name = _ocKm("\018>\f\006\t\015")
_eiq2t.Description = ""
_eiq2t.AltText = ""
_eiq2t.Resources = {
  {
    Type = "jpg",
    Filename = "Drache.jpg",
    Directives = {}
  }
}
_54nS = Wherigo.ZMedia(_VwtHO)
_54nS.Id = "c551b53b-a541-4b10-aa46-61cfca88c9d7"
_54nS.Name = _ocKm("}9wmm\015>")
_54nS.Description = ""
_54nS.AltText = ""
_54nS.Resources = {
  {
    Type = "jpg",
    Filename = "Stobber.jpg",
    Directives = {}
  }
}
_jss9 = Wherigo.ZMedia(_VwtHO)
_jss9.Id = "694f0e7e-093b-4bca-91e9-7d18d4a68f82"
_jss9.Name = _ocKm("F$\015m\015\027\"hy\t\027")
_jss9.Description = ""
_jss9.AltText = ""
_jss9.Resources = {
  {
    Type = "jpg",
    Filename = "Giebelpfuhl.jpg",
    Directives = {}
  }
}
_XiJ = Wherigo.ZMedia(_VwtHO)
_XiJ.Id = "71c860f7-b17e-46c5-a213-d3780ca88244"
_XiJ.Name = _ocKm("F\195\18869\t\015>1y\015\027\027\015\nUw>h$6\f\027")
_XiJ.Description = ""
_XiJ.AltText = ""
_XiJ.Resources = {
  {
    Type = "jpg",
    Filename = "Guentherquelle-Vorfinal.jpg",
    Directives = {}
  }
}
_eIO = Wherigo.ZMedia(_VwtHO)
_eIO.Id = "a9a9c898-36a1-44bb-b8cc-d7a497a6db34"
_eIO.Name = _ocKm("F$\015m\015\027\"hy\t\027\017A")
_eIO.Description = ""
_eIO.AltText = ""
_eIO.Resources = {
  {
    Type = "jpg",
    Filename = "Gieblpfuhl_1.jpg",
    Directives = {}
  }
}
_sHi = Wherigo.ZMedia(_VwtHO)
_sHi.Id = "e1b3b453-90ac-4b7a-8bd8-e00060c1878c"
_sHi.Name = _ocKm("{yKn(\f>L\"\027\f9{\017A")
_sHi.Description = ""
_sHi.AltText = ""
_sHi.Resources = {
  {
    Type = "jpg",
    Filename = "zum_Parkplatz_1.jpg",
    Directives = {}
  }
}
_b3iKS = Wherigo.ZMedia(_VwtHO)
_b3iKS.Id = "f76b56a8-5f32-4c26-8c67-ec991f5cccea"
_b3iKS.Name = _ocKm("}\"w$\027\015>")
_b3iKS.Description = ""
_b3iKS.AltText = ""
_b3iKS.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler.jpg",
    Directives = {}
  }
}
_Z2d = Wherigo.ZMedia(_VwtHO)
_Z2d.Id = "7e0b4e77-4985-4782-9dbd-df0bbc8ad7a0"
_Z2d.Name = _ocKm("{yK\017(\f>L\"\027\f9{")
_Z2d.Description = ""
_Z2d.AltText = ""
_Z2d.Resources = {
  {
    Type = "jpg",
    Filename = "zumParkplatz.jpg",
    Directives = {}
  }
}
_n0wiP = Wherigo.ZMedia(_VwtHO)
_n0wiP.Id = "997549de-a588-4bd3-83c1-6ba973437d7c"
_n0wiP.Name = _ocKm("\fKnd\015$\006\t")
_n0wiP.Description = ""
_n0wiP.AltText = ""
_n0wiP.Resources = {
  {
    Type = "jpg",
    Filename = "amTeich.jpg",
    Directives = {}
  }
}
_Lax = Wherigo.ZMedia(_VwtHO)
_Lax.Id = "0ac2ddf6-be25-456b-82db-aa4787ff2f78"
_Lax.Name = _ocKm("\fKnd\015$\006\t\017A")
_Lax.Description = ""
_Lax.AltText = ""
_Lax.Resources = {
  {
    Type = "jpg",
    Filename = "amTeich_1.jpg",
    Directives = {}
  }
}
_Ud0 = Wherigo.ZMedia(_VwtHO)
_Ud0.Id = "2ab1c9af-e75a-4f95-9752-2ee9d0ff3449"
_Ud0.Name = _ocKm("(w\0159\0156?9\015$`\017W\015>\027\f??\0156\017A")
_Ud0.Description = ""
_Ud0.AltText = ""
_Ud0.Resources = {
  {
    Type = "jpg",
    Filename = "Poetensteigverlassen_1.jpg",
    Directives = {}
  }
}
_DFQH = Wherigo.ZMedia(_VwtHO)
_DFQH.Id = "7e26d6e3-8887-46df-ae6a-f803f6a32857"
_DFQH.Name = _ocKm("(w\0159\0156?9\015$`\017W\015>\027\f??\0156")
_DFQH.Description = ""
_DFQH.AltText = ""
_DFQH.Resources = {
  {
    Type = "jpg",
    Filename = "Poetensteigverlassen.jpg",
    Directives = {}
  }
}
_oIWC = Wherigo.ZMedia(_VwtHO)
_oIWC.Id = "504dd33a-727d-4d52-b9f1-4fc7b3d5034d"
_oIWC.Name = _ocKm("(w\0159\0156?9\015$`")
_oIWC.Description = ""
_oIWC.AltText = ""
_oIWC.Resources = {
  {
    Type = "jpg",
    Filename = "Poetensteig.jpg",
    Directives = {}
  }
}
_2wK = Wherigo.ZMedia(_VwtHO)
_2wK.Id = "bfc4ab0d-6578-4a06-8a70-45fed4d42f4e"
_2wK.Name = _ocKm("(w\0159\0156?9\015$`\017A")
_2wK.Description = ""
_2wK.AltText = ""
_2wK.Resources = {
  {
    Type = "jpg",
    Filename = "Poetensteig_1.jpg",
    Directives = {}
  }
}
_BdEgj = Wherigo.ZMedia(_VwtHO)
_BdEgj.Id = "beb030ca-92d1-4749-9717-b8f7095bf39e"
_BdEgj.Name = _ocKm("Uw>h$6\f\027")
_BdEgj.Description = ""
_BdEgj.AltText = ""
_BdEgj.Resources = {
  {
    Type = "jpg",
    Filename = "Vorfinal.jpg",
    Directives = {}
  }
}
_7L0 = Wherigo.ZMedia(_VwtHO)
_7L0.Id = "adb2e9ea-ca12-46c9-b5ef-d156e533b3cb"
_7L0.Name = _ocKm("Uw>h$6\f\027\017A")
_7L0.Description = ""
_7L0.AltText = ""
_7L0.Resources = {
  {
    Type = "jpg",
    Filename = "Vorfinal_1.jpg",
    Directives = {}
  }
}
_5NAsj = Wherigo.ZMedia(_VwtHO)
_5NAsj.Id = "605c0a4a-8f28-44d2-8149-4026d3b54995"
_5NAsj.Name = _ocKm("4$6\f\027\017A")
_5NAsj.Description = ""
_5NAsj.AltText = ""
_5NAsj.Resources = {
  {
    Type = "jpg",
    Filename = "Final_1.jpg",
    Directives = {}
  }
}
_g05Dg = Wherigo.ZMedia(_VwtHO)
_g05Dg.Id = "93d65d68-29b9-4886-ae41-9805b8051237"
_g05Dg.Name = _ocKm("6\f\006\tnF$\015m\015\027\"hy\t\027")
_g05Dg.Description = ""
_g05Dg.AltText = ""
_g05Dg.Resources = {
  {
    Type = "jpg",
    Filename = "nachGiebelpfuhl.jpg",
    Directives = {}
  }
}
_Jrx = Wherigo.ZMedia(_VwtHO)
_Jrx.Id = "dbccaafd-de52-4b0f-897f-6131b52b2c4e"
_Jrx.Name = _ocKm("6\f\006\tnF$\015m\015\027\"hy\t\027\017A")
_Jrx.Description = ""
_Jrx.AltText = ""
_Jrx.Resources = {
  {
    Type = "jpg",
    Filename = "nachGiebelpfuhl_1.jpg",
    Directives = {}
  }
}
_nBGsr = Wherigo.ZMedia(_VwtHO)
_nBGsr.Id = "c073d4a8-8bc8-4bcd-99de-5e26ef78672a"
_nBGsr.Name = _ocKm("};A\017}\006\t$\027<\017A")
_nBGsr.Description = ""
_nBGsr.AltText = ""
_nBGsr.Resources = {
  {
    Type = "jpg",
    Filename = "S01_Schild_1.jpg",
    Directives = {}
  }
}
_CZJ = Wherigo.ZMedia(_VwtHO)
_CZJ.Id = "3b5b99bb-d87b-491a-a6c6-5977b269e759"
_CZJ.Name = _ocKm("};a")
_CZJ.Description = ""
_CZJ.AltText = ""
_CZJ.Resources = {
  {
    Type = "jpg",
    Filename = "S02.jpg",
    Directives = {}
  }
}
_UN6 = Wherigo.ZMedia(_VwtHO)
_UN6.Id = "c2ec2747-d7ac-44cd-b479-ab78b32865f0"
_UN6.Name = _ocKm("};a\017A")
_UN6.Description = ""
_UN6.AltText = ""
_UN6.Resources = {
  {
    Type = "jpg",
    Filename = "S02_1.jpg",
    Directives = {}
  }
}
_U4GUO = Wherigo.ZMedia(_VwtHO)
_U4GUO.Id = "eed333a9-6673-4b8b-92fc-d5544be8f03b"
_U4GUO.Name = _ocKm("};s\017A")
_U4GUO.Description = ""
_U4GUO.AltText = ""
_U4GUO.Resources = {
  {
    Type = "jpg",
    Filename = "S03_1.jpg",
    Directives = {}
  }
}
_YpNI8 = Wherigo.ZMedia(_VwtHO)
_YpNI8.Id = "78e79f6f-92ed-4486-8312-e18a4cc32751"
_YpNI8.Name = _ocKm("t>y\015\006L\015")
_YpNI8.Description = ""
_YpNI8.AltText = ""
_YpNI8.Resources = {
  {
    Type = "jpg",
    Filename = "Brueckenkreuzung_Brucke.jpg",
    Directives = {}
  }
}
_CgQoE = Wherigo.ZMedia(_VwtHO)
_CgQoE.Id = "74926e33-99de-4662-acd0-cccf94e3a9be"
_CgQoE.Name = _ocKm("t>y\015\006L\0156L>\015y{y6`\017A")
_CgQoE.Description = ""
_CgQoE.AltText = ""
_CgQoE.Resources = {
  {
    Type = "jpg",
    Filename = "Brueckenkreuzung_1.jpg",
    Directives = {}
  }
}
_UuZ = Wherigo.ZMedia(_VwtHO)
_UuZ.Id = "d82e0e69-a6c4-4d50-93c0-b4dbf0951b2d"
_UuZ.Name = _ocKm("}\"w$\027\015>\0176\f\t")
_UuZ.Description = ""
_UuZ.AltText = ""
_UuZ.Resources = {
  {
    Type = "jpg",
    Filename = "Spoiler_nah.jpg",
    Directives = {}
  }
}
_VwtHO.Id = "2405ea40-b499-4c4c-9240-604ebe1b0962"
_VwtHO.Name = "Wandern mit Walter - Stobbertal"
_VwtHO.Description = "Mit Walter durch den Naturpark M\195\164rkische Schweiz. "
_VwtHO.Visible = true
_VwtHO.Activity = "Geocache"
_VwtHO.StartingLocationDescription = "Hier koennt Ihr parken."
_VwtHO.StartingLocation = ZonePoint(52.576167, 14.0724, 0)
_VwtHO.Version = "1.4"
_VwtHO.Company = ""
_VwtHO.Author = "Walter"
_VwtHO.BuilderVersion = "URWIGO 1.22.5798.37755"
_VwtHO.CreateDate = "08/22/2015 19:45:09"
_VwtHO.PublishDate = "1/1/0001 12:00:00 AM"
_VwtHO.UpdateDate = "12/31/2022 07:57:12"
_VwtHO.LastPlayedDate = "1/1/0001 12:00:00 AM"
_VwtHO.TargetDevice = "PocketPC"
_VwtHO.TargetDeviceVersion = "0"
_VwtHO.StateId = "1"
_VwtHO.CountryId = "2"
_VwtHO.Complete = false
_VwtHO.UseLogging = true
_VwtHO.Media = _jKUq
_VwtHO.Icon = _jKUq
_fRPL = Wherigo.Zone(_VwtHO)
_fRPL.Id = "ae784dad-82f9-49ca-ab29-7bd2c1f8e2e2"
_fRPL.Name = _ocKm(";an\t$\015>n>\015\006\t9?")
_fRPL.Description = _ocKm("O>?9K\f\027n<$\015n}9>\f??\015n>y69\015>nm$?n{y>nO\006L\015H")
_fRPL.Visible = false
_fRPL.Media = _jKUq
_fRPL.Icon = _jKUq
_fRPL.Commands = {}
_fRPL.DistanceRange = Distance(-1, "feet")
_fRPL.ShowObjects = "OnEnter"
_fRPL.ProximityRange = Distance(60, "meters")
_fRPL.AllowSetPositionTo = false
_fRPL.Active = false
_fRPL.Points = {
  ZonePoint(52.575792032983, 14.0700377145216, 0),
  ZonePoint(52.5758090391911, 14.0703175547613, 0),
  ZonePoint(52.5756559830816, 14.0703735228092, 0),
  ZonePoint(52.5755858321862, 14.0700831885606, 0)
}
_fRPL.OriginalPoint = ZonePoint(52.5757107218605, 14.0702029951632, 0)
_fRPL.DistanceRangeUOM = "Feet"
_fRPL.ProximityRangeUOM = "Meters"
_fRPL.OutOfRangeName = ""
_fRPL.InRangeName = ""
_MTZ = Wherigo.Zone(_VwtHO)
_MTZ.Id = "ccce4278-64e0-43d5-b0f7-e829be6a167d"
_MTZ.Name = _ocKm(";sn>\015\006\t9?n$6n<\0156n3\f\027<")
_MTZ.Description = _ocKm("o6n<\015Kn}\006\t$\027<nWw>m\015$ny6<ny\015m\015>n<$\015nt>y\015\006L\015H")
_MTZ.Visible = false
_MTZ.Media = _Rxry
_MTZ.Icon = _Rxry
_MTZ.Commands = {}
_MTZ.DistanceRange = Distance(-1, "feet")
_MTZ.ShowObjects = "OnEnter"
_MTZ.ProximityRange = Distance(60, "meters")
_MTZ.AllowSetPositionTo = false
_MTZ.Active = false
_MTZ.Points = {
  ZonePoint(52.5776935765481, 14.0694197729655, 0),
  ZonePoint(52.5777721780704, 14.0695338981386, 0),
  ZonePoint(52.5777005305507, 14.0696049900998, 0),
  ZonePoint(52.5776238825365, 14.0694955240571, 0)
}
_MTZ.OriginalPoint = ZonePoint(52.5776975419264, 14.0695135463152, 0)
_MTZ.DistanceRangeUOM = "Feet"
_MTZ.ProximityRangeUOM = "Meters"
_MTZ.OutOfRangeName = ""
_MTZ.InRangeName = ""
_Ed8 = Wherigo.Zone(_VwtHO)
_Ed8.Id = "79ff84d9-d824-467e-9898-6775a6e003af"
_Ed8.Name = _ocKm(";znt>y\015\006L\0156L>\015y{y6`")
_Ed8.Description = ""
_Ed8.Visible = false
_Ed8.Media = _yQCf
_Ed8.Icon = _yQCf
_Ed8.Commands = {}
_Ed8.DistanceRange = Distance(-1, "feet")
_Ed8.ShowObjects = "OnEnter"
_Ed8.ProximityRange = Distance(60, "meters")
_Ed8.AllowSetPositionTo = false
_Ed8.Active = false
_Ed8.Points = {
  ZonePoint(52.5812523623223, 14.0717007330944, 0),
  ZonePoint(52.5810647393885, 14.0720043654539, 0),
  ZonePoint(52.5809278568189, 14.0718268355404, 0),
  ZonePoint(52.5811046830972, 14.0713831337368, 0)
}
_Ed8.OriginalPoint = ZonePoint(52.5810874104067, 14.0717287669564, 0)
_Ed8.DistanceRangeUOM = "Feet"
_Ed8.ProximityRangeUOM = "Meters"
_Ed8.OutOfRangeName = ""
_Ed8.InRangeName = ""
_oR1NG = Wherigo.Zone(_VwtHO)
_oR1NG.Id = "a562fd85-193d-4ef3-9323-27ecb5c6dc4a"
_oR1NG.Name = _ocKm(";%n3y>{\015\027h$\006\t9\015")
_oR1NG.Description = _ocKm("3$>n`\015\t\0156n\fyhn<\015Kn?\006\tK\f\027\0156n3\015`nm\015>`\fyhn\fKn4\027$\015\195\159n\01569\027\f6`ny6<nLwKK\0156nm\f\027<n\fyhn\015$6\0156nm>\015$9\0156n3\015`Hn")
_oR1NG.Visible = false
_oR1NG.Media = _CgQoE
_oR1NG.Icon = _CgQoE
_oR1NG.Commands = {}
_oR1NG.DistanceRange = Distance(-1, "feet")
_oR1NG.ShowObjects = "OnEnter"
_oR1NG.ProximityRange = Distance(60, "meters")
_oR1NG.AllowSetPositionTo = false
_oR1NG.Active = false
_oR1NG.Points = {
  ZonePoint(52.5862489886536, 14.0647843856954, 0),
  ZonePoint(52.5863910705571, 14.0652880908372, 0),
  ZonePoint(52.5861680936357, 14.0655309652939, 0),
  ZonePoint(52.5859874445253, 14.0650505482186, 0)
}
_oR1NG.OriginalPoint = ZonePoint(52.5861988993429, 14.0651634975113, 0)
_oR1NG.DistanceRangeUOM = "Feet"
_oR1NG.ProximityRangeUOM = "Meters"
_oR1NG.OutOfRangeName = ""
_oR1NG.InRangeName = ""
_9Y0 = Wherigo.Zone(_VwtHO)
_9Y0.Id = "e74a7dbd-97f2-45eb-b0cc-631d66491fb4"
_9Y0.Name = _ocKm(";An}9\f>9n<\015>n3\f6<\015>y6`")
_9Y0.Description = ""
_9Y0.Visible = true
_9Y0.Media = _jKUq
_9Y0.Icon = _jKUq
_9Y0.Commands = {}
_9Y0.DistanceRange = Distance(-1, "feet")
_9Y0.ShowObjects = "OnEnter"
_9Y0.ProximityRange = Distance(60, "meters")
_9Y0.AllowSetPositionTo = false
_9Y0.Active = true
_9Y0.Points = {
  ZonePoint(52.576199987051, 14.0723365129566, 0),
  ZonePoint(52.5762235669445, 14.0724382227179, 0),
  ZonePoint(52.5761594594098, 14.0724579871768, 0),
  ZonePoint(52.5761401743625, 14.0723461423205, 0)
}
_9Y0.OriginalPoint = ZonePoint(52.576180796942, 14.0723947162929, 0)
_9Y0.DistanceRangeUOM = "Feet"
_9Y0.ProximityRangeUOM = "Meters"
_9Y0.OutOfRangeName = ""
_9Y0.InRangeName = ""
_y1vj = Wherigo.Zone(_VwtHO)
_y1vj.Id = "33cea0fe-7d1f-455d-8b0d-31ab46860134"
_y1vj.Name = _ocKm(";\002n\018>\f\006\t\0156L\015\t\027\015")
_y1vj.Description = ""
_y1vj.Visible = false
_y1vj.Media = _jKUq
_y1vj.Icon = _jKUq
_y1vj.Commands = {}
_y1vj.DistanceRange = Distance(-1, "feet")
_y1vj.ShowObjects = "OnEnter"
_y1vj.ProximityRange = Distance(60, "meters")
_y1vj.AllowSetPositionTo = false
_y1vj.Active = false
_y1vj.Points = {
  ZonePoint(52.5848190714135, 14.0670807294669, 0),
  ZonePoint(52.5849167403752, 14.0675018795019, 0),
  ZonePoint(52.5846789327736, 14.0677068970036, 0),
  ZonePoint(52.5845883390622, 14.0673092873033, 0)
}
_y1vj.OriginalPoint = ZonePoint(52.5847507709061, 14.0673996983189, 0)
_y1vj.DistanceRangeUOM = "Feet"
_y1vj.ProximityRangeUOM = "Meters"
_y1vj.OutOfRangeName = ""
_y1vj.InRangeName = ""
_2H5L = Wherigo.Zone(_VwtHO)
_2H5L.Id = "3fb176c2-3455-415d-b16e-9fa80a6b0c11"
_2H5L.Name = _ocKm(";5n>\015\006\t9?n{yKn7>y`m\015>`")
_2H5L.Description = _ocKm("3$>nhw\027`\0156n<\015Kn3\015`nm$?nLy>{ny69\015>Kn7>y`m\015>`H")
_2H5L.Visible = false
_2H5L.Media = _eiq2t
_2H5L.Icon = _eiq2t
_2H5L.Commands = {}
_2H5L.DistanceRange = Distance(-1, "feet")
_2H5L.ShowObjects = "OnEnter"
_2H5L.ProximityRange = Distance(60, "meters")
_2H5L.AllowSetPositionTo = false
_2H5L.Active = false
_2H5L.Points = {
  ZonePoint(52.5873291776926, 14.0814219123746, 0),
  ZonePoint(52.5874509176801, 14.0816765063154, 0),
  ZonePoint(52.5873050294279, 14.0819166314947, 0),
  ZonePoint(52.5871737295856, 14.0816344844091, 0)
}
_2H5L.OriginalPoint = ZonePoint(52.5873147135966, 14.0816623836484, 0)
_2H5L.DistanceRangeUOM = "Feet"
_2H5L.ProximityRangeUOM = "Meters"
_2H5L.OutOfRangeName = ""
_2H5L.InRangeName = ""
_pY1 = Wherigo.Zone(_VwtHO)
_pY1.Id = "1743d7f6-7ddf-4cd1-86d5-a4d4cb939e4e"
_pY1.Name = _ocKm(";|n7>y`m\015>`")
_pY1.Description = _ocKm("F\027\015$\006\tn?$6<nR$>n\fyhn<\015Kn\tw\015\006\t?9\0156n(y6L9H")
_pY1.Visible = false
_pY1.Media = _qjKQ
_pY1.Commands = {}
_pY1.DistanceRange = Distance(-1, "feet")
_pY1.ShowObjects = "OnEnter"
_pY1.ProximityRange = Distance(60, "meters")
_pY1.AllowSetPositionTo = false
_pY1.Active = false
_pY1.Points = {
  ZonePoint(52.5872436194557, 14.082887802071, 0),
  ZonePoint(52.5872062759085, 14.0831824209415, 0),
  ZonePoint(52.5870463735146, 14.0830514157383, 0),
  ZonePoint(52.5871195100004, 14.0828136406687, 0)
}
_pY1.OriginalPoint = ZonePoint(52.5871539447198, 14.0829838198549, 0)
_pY1.DistanceRangeUOM = "Feet"
_pY1.ProximityRangeUOM = "Meters"
_pY1.OutOfRangeName = ""
_pY1.InRangeName = ""
_dRm = Wherigo.Zone(_VwtHO)
_dRm.Id = "9844ffae-103e-4593-9540-b59b0e52e1fa"
_dRm.Name = _ocKm(";bn4\015\027<>\f6<")
_dRm.Description = _ocKm("O?n`\015\t9nR$\015<\015>n>y69\015>H")
_dRm.Visible = false
_dRm.Media = _P7q
_dRm.Icon = _P7q
_dRm.Commands = {}
_dRm.DistanceRange = Distance(-1, "feet")
_dRm.ShowObjects = "OnEnter"
_dRm.ProximityRange = Distance(60, "meters")
_dRm.AllowSetPositionTo = false
_dRm.Active = false
_dRm.Points = {
  ZonePoint(52.5856685722868, 14.0846300007198, 0),
  ZonePoint(52.5854331003502, 14.0850270129305, 0),
  ZonePoint(52.5851861406185, 14.0845071159879, 0),
  ZonePoint(52.5854733029655, 14.0841573671355, 0)
}
_dRm.OriginalPoint = ZonePoint(52.5854402790552, 14.0845803741934, 0)
_dRm.DistanceRangeUOM = "Feet"
_dRm.ProximityRangeUOM = "Meters"
_dRm.OutOfRangeName = ""
_dRm.InRangeName = ""
_ZxD1 = Wherigo.Zone(_VwtHO)
_ZxD1.Id = "9d30886a-c050-460d-87b5-1e112d592b16"
_ZxD1.Name = _ocKm("A;n3\015`R\015$?\015>")
_ZxD1.Description = _ocKm("0$\015>n`\015\t9k?n\fKn4\015\027<>\f6<nR\015$9\015>H")
_ZxD1.Visible = false
_ZxD1.Media = _2O9
_ZxD1.Icon = _2O9
_ZxD1.Commands = {}
_ZxD1.DistanceRange = Distance(-1, "feet")
_ZxD1.ShowObjects = "OnEnter"
_ZxD1.ProximityRange = Distance(60, "meters")
_ZxD1.AllowSetPositionTo = false
_ZxD1.Active = false
_ZxD1.Points = {
  ZonePoint(52.5836470524633, 14.0862587989166, 0),
  ZonePoint(52.5836910319932, 14.0864929498161, 0),
  ZonePoint(52.5835339635245, 14.086556356722, 0),
  ZonePoint(52.5834865465177, 14.0862783418268, 0)
}
_ZxD1.OriginalPoint = ZonePoint(52.5835896486247, 14.0863966118204, 0)
_ZxD1.DistanceRangeUOM = "Feet"
_ZxD1.ProximityRangeUOM = "Meters"
_ZxD1.OutOfRangeName = ""
_ZxD1.InRangeName = ""
_xCHP = Wherigo.Zone(_VwtHO)
_xCHP.Id = "a24d54e1-260b-49cc-8476-a6da9499b590"
_xCHP.Name = _ocKm("AAnom{R\015$`n{yKnd\015yh\015\027??9\015$6")
_xCHP.Description = _ocKm("3$>nR\f6<\015>6nR\015$9\015>n\fyhn<\015Kn(w\0159\0156?9\015$`H")
_xCHP.Visible = false
_xCHP.Media = _jKUq
_xCHP.Icon = _jKUq
_xCHP.Commands = {}
_xCHP.DistanceRange = Distance(-1, "feet")
_xCHP.ShowObjects = "OnEnter"
_xCHP.ProximityRange = Distance(60, "meters")
_xCHP.AllowSetPositionTo = false
_xCHP.Active = false
_xCHP.Points = {
  ZonePoint(52.5833606097627, 14.088455728865, 0),
  ZonePoint(52.5835496947138, 14.0887091927879, 0),
  ZonePoint(52.5834218051731, 14.0889541918853, 0),
  ZonePoint(52.5832645076068, 14.08875759187, 0)
}
_xCHP.OriginalPoint = ZonePoint(52.5833991543141, 14.088719176352, 0)
_xCHP.DistanceRangeUOM = "Feet"
_xCHP.ProximityRangeUOM = "Meters"
_xCHP.OutOfRangeName = ""
_xCHP.InRangeName = ""
_ns2R = Wherigo.Zone(_VwtHO)
_ns2R.Id = "09160914-e856-40b5-bd6d-679794360f3f"
_ns2R.Name = _ocKm("Aand\015yh\015\027??9\015$6")
_ns2R.Description = _ocKm("O9R\f?n<\0156n3\015`n\tw\006\tny6<n\fyhn<\015>n>\015\006\t9\0156n}\015$9\015nh$6<\0156nR$>n<\0156nd\015yh\015\027??9\015$6H")
_ns2R.Visible = false
_ns2R.Media = _WxX
_ns2R.Icon = _kuk
_ns2R.Commands = {}
_ns2R.DistanceRange = Distance(-1, "feet")
_ns2R.ShowObjects = "OnEnter"
_ns2R.ProximityRange = Distance(60, "meters")
_ns2R.AllowSetPositionTo = false
_ns2R.Active = false
_ns2R.Points = {
  ZonePoint(52.5834456161787, 14.0902845164346, 0),
  ZonePoint(52.5836071327456, 14.0901415045989, 0),
  ZonePoint(52.5834593037543, 14.0898642260922, 0),
  ZonePoint(52.5833021038191, 14.0901078990466, 0)
}
_ns2R.OriginalPoint = ZonePoint(52.5834535391244, 14.0900995365431, 0)
_ns2R.DistanceRangeUOM = "Feet"
_ns2R.ProximityRangeUOM = "Meters"
_ns2R.OutOfRangeName = ""
_ns2R.InRangeName = ""
_vqV = Wherigo.Zone(_VwtHO)
_vqV.Id = "180c5325-eb70-4396-a7dc-bdcd7b75cee0"
_vqV.Name = _ocKm("Asn(w\0159\0156?9\015$`")
_vqV.Description = _ocKm("0$\015>n`\015\t9?nR$\015<\015>n>y69\015>n{yKn(w\0159\0156?9\015$`H")
_vqV.Visible = false
_vqV.Media = _1yFJ5
_vqV.Icon = _1yFJ5
_vqV.Commands = {}
_vqV.DistanceRange = Distance(-1, "feet")
_vqV.ShowObjects = "OnEnter"
_vqV.ProximityRange = Distance(60, "meters")
_vqV.AllowSetPositionTo = false
_vqV.Active = false
_vqV.Points = {
  ZonePoint(52.5828309926713, 14.0909804595952, 0),
  ZonePoint(52.5830205834221, 14.0911824872521, 0),
  ZonePoint(52.5827634308079, 14.0913167521214, 0),
  ZonePoint(52.5826330316235, 14.0911801834009, 0)
}
_vqV.OriginalPoint = ZonePoint(52.5828120096312, 14.0911649705924, 0)
_vqV.DistanceRangeUOM = "Feet"
_vqV.ProximityRangeUOM = "Meters"
_vqV.OutOfRangeName = ""
_vqV.InRangeName = ""
_Dy0OK = Wherigo.Zone(_VwtHO)
_Dy0OK.Id = "77b9eb1d-9157-44d3-877b-bff8ca65e446"
_Dy0OK.Name = _ocKm("Azn\018\f\006\t?m\015>`")
_Dy0OK.Description = _ocKm("qyKn\018\f\006\t?m\015>`n`\015\t9n\015?nR$\015<\015>n\0159R\f?n\tw\006\tH")
_Dy0OK.Visible = false
_Dy0OK.Media = _YQk
_Dy0OK.Icon = _YQk
_Dy0OK.Commands = {}
_Dy0OK.DistanceRange = Distance(-1, "feet")
_Dy0OK.ShowObjects = "OnEnter"
_Dy0OK.ProximityRange = Distance(60, "meters")
_Dy0OK.AllowSetPositionTo = false
_Dy0OK.Active = false
_Dy0OK.Points = {
  ZonePoint(52.5819634592005, 14.0915300097687, 0),
  ZonePoint(52.5821369165442, 14.0916539765015, 0),
  ZonePoint(52.5820670742737, 14.0918773779612, 0),
  ZonePoint(52.5819058172917, 14.0917529064854, 0)
}
_Dy0OK.OriginalPoint = ZonePoint(52.5820183168275, 14.0917035676792, 0)
_Dy0OK.DistanceRangeUOM = "Feet"
_Dy0OK.ProximityRangeUOM = "Meters"
_Dy0OK.OutOfRangeName = ""
_Dy0OK.InRangeName = ""
_YEA3 = Wherigo.Zone(_VwtHO)
_YEA3.Id = "4f57112d-5374-4017-9f76-7468d43654fe"
_YEA3.Name = _ocKm("A%nF>w??\015>n}9\015$6")
_YEA3.Description = _ocKm("3$>n`\015\t\0156n<\0156n3\015`nR\015$9\015>nm$?n{yKnF>w??\0156n}9\015$6H")
_YEA3.Visible = false
_YEA3.Media = _jKUq
_YEA3.Icon = _jKUq
_YEA3.Commands = {}
_YEA3.DistanceRange = Distance(-1, "feet")
_YEA3.ShowObjects = "OnEnter"
_YEA3.ProximityRange = Distance(60, "meters")
_YEA3.AllowSetPositionTo = false
_YEA3.Active = false
_YEA3.Points = {
  ZonePoint(52.5812318345626, 14.0953619607312, 0),
  ZonePoint(52.5814327481846, 14.0954211299171, 0),
  ZonePoint(52.5814031111407, 14.0956064731806, 0),
  ZonePoint(52.5811986149917, 14.0955625760918, 0)
}
_YEA3.OriginalPoint = ZonePoint(52.5813165772199, 14.0954880349802, 0)
_YEA3.DistanceRangeUOM = "Feet"
_YEA3.ProximityRangeUOM = "Meters"
_YEA3.OutOfRangeName = ""
_YEA3.InRangeName = ""
_K1ZB_ = Wherigo.Zone(_VwtHO)
_K1ZB_.Id = "ad0d9498-22ef-47a6-b760-1239fee8167b"
_K1ZB_.Name = _ocKm("A\002n>\015\006\t9?n\fmn{yKndw>6wR?\015\015")
_K1ZB_.Description = ""
_K1ZB_.Visible = false
_K1ZB_.Media = _jKUq
_K1ZB_.Icon = _jKUq
_K1ZB_.Commands = {}
_K1ZB_.DistanceRange = Distance(-1, "feet")
_K1ZB_.ShowObjects = "OnEnter"
_K1ZB_.ProximityRange = Distance(60, "meters")
_K1ZB_.AllowSetPositionTo = false
_K1ZB_.Active = false
_K1ZB_.Points = {
  ZonePoint(52.5819863848917, 14.0965158893618, 0),
  ZonePoint(52.5820106665356, 14.0969136309336, 0),
  ZonePoint(52.5818713740915, 14.0970111800197, 0),
  ZonePoint(52.5816577981546, 14.0966616010272, 0)
}
_K1ZB_.OriginalPoint = ZonePoint(52.5818815559184, 14.0967755753356, 0)
_K1ZB_.DistanceRangeUOM = "Feet"
_K1ZB_.ProximityRangeUOM = "Meters"
_K1ZB_.OutOfRangeName = ""
_K1ZB_.InRangeName = ""
_3Ju0 = Wherigo.Zone(_VwtHO)
_3Ju0.Id = "9b2bd7e0-c3ed-4143-a56b-b13ca7094e57"
_3Ju0.Name = _ocKm("A5n3\015`R\015$?\015>")
_3Ju0.Description = ""
_3Ju0.Visible = false
_3Ju0.Media = _GJpa
_3Ju0.Icon = _GJpa
_3Ju0.Commands = {}
_3Ju0.DistanceRange = Distance(-1, "feet")
_3Ju0.ShowObjects = "OnEnter"
_3Ju0.ProximityRange = Distance(60, "meters")
_3Ju0.AllowSetPositionTo = false
_3Ju0.Active = false
_3Ju0.Points = {
  ZonePoint(52.5781601459239, 14.0970714010758, 0),
  ZonePoint(52.578354123526, 14.0971170060581, 0),
  ZonePoint(52.5783101282032, 14.0974479742082, 0),
  ZonePoint(52.5781200050503, 14.0973859176801, 0)
}
_3Ju0.OriginalPoint = ZonePoint(52.5782361006758, 14.0972555747556, 0)
_3Ju0.DistanceRangeUOM = "Feet"
_3Ju0.ProximityRangeUOM = "Meters"
_3Ju0.OutOfRangeName = ""
_3Ju0.InRangeName = ""
_Yl9Qs = Wherigo.Zone(_VwtHO)
_Yl9Qs.Id = "64edbbc8-72b0-458d-9a33-ea22234f14dc"
_Yl9Qs.Name = _ocKm("A|n(\027\f99\0156R\015`")
_Yl9Qs.Description = _ocKm("\018\0156n3\015`n>y69\015>ny6<n`\015>\f<\015\fy?n6\f\006\tn(>$9{\t\f`\0156H")
_Yl9Qs.Visible = false
_Yl9Qs.Media = _1FGp
_Yl9Qs.Icon = _1FGp
_Yl9Qs.Commands = {}
_Yl9Qs.DistanceRange = Distance(-1, "feet")
_Yl9Qs.ShowObjects = "OnEnter"
_Yl9Qs.ProximityRange = Distance(60, "meters")
_Yl9Qs.AllowSetPositionTo = false
_Yl9Qs.Active = false
_Yl9Qs.Points = {
  ZonePoint(52.5788174544727, 14.1016745980047, 0),
  ZonePoint(52.5789016423053, 14.1018511504947, 0),
  ZonePoint(52.578878732597, 14.1018972294918, 0),
  ZonePoint(52.5787947302307, 14.1020040489849, 0),
  ZonePoint(52.5787450923933, 14.1017945989981, 0)
}
_Yl9Qs.OriginalPoint = ZonePoint(52.5788275303998, 14.1018443251948, 0)
_Yl9Qs.DistanceRangeUOM = "Feet"
_Yl9Qs.ProximityRangeUOM = "Meters"
_Yl9Qs.OutOfRangeName = ""
_Yl9Qs.InRangeName = ""
_JRF = Wherigo.Zone(_VwtHO)
_JRF.Id = "fbf24ad1-6d35-49d1-9bc6-6b0a56fc9f58"
_JRF.Name = _ocKm("Abn>\015\006\t9?n\fm")
_JRF.Description = _ocKm("3\015$9\015>n`\015\t9?n\fyhn<\015Kn(\027\f99\0156R\015`nm$?n{y>no?\"\t\f\0279?9>\f??\015H")
_JRF.Visible = false
_JRF.Media = __40u
_JRF.Icon = __40u
_JRF.Commands = {}
_JRF.DistanceRange = Distance(-1, "feet")
_JRF.ShowObjects = "OnEnter"
_JRF.ProximityRange = Distance(60, "meters")
_JRF.AllowSetPositionTo = false
_JRF.Active = false
_JRF.Points = {
  ZonePoint(52.5790214396172, 14.1037473491849, 0),
  ZonePoint(52.5787991109945, 14.1036738321809, 0),
  ZonePoint(52.5787888300893, 14.1040569099326, 0),
  ZonePoint(52.5789433696632, 14.1041080653405, 0)
}
_JRF.OriginalPoint = ZonePoint(52.578888187591, 14.1038965391597, 0)
_JRF.DistanceRangeUOM = "Feet"
_JRF.ProximityRangeUOM = "Meters"
_JRF.OutOfRangeName = ""
_JRF.InRangeName = ""
_s2Ui2 = Wherigo.Zone(_VwtHO)
_s2Ui2.Id = "3afe2373-a4d8-4383-9a94-59a4da3398fb"
_s2Ui2.Name = _ocKm("a;nt\f<\015?9\015\027\027\015")
_s2Ui2.Description = _ocKm("3$>nm\027\015$m\0156n\fyhn<\015>no?\"\t\f\0279?9>\f??\015H")
_s2Ui2.Visible = false
_s2Ui2.Media = _jKUq
_s2Ui2.Icon = _jKUq
_s2Ui2.Commands = {}
_s2Ui2.DistanceRange = Distance(-1, "feet")
_s2Ui2.ShowObjects = "OnEnter"
_s2Ui2.ProximityRange = Distance(60, "meters")
_s2Ui2.AllowSetPositionTo = false
_s2Ui2.Active = false
_s2Ui2.Points = {
  ZonePoint(52.57835010671, 14.1067433520078, 0),
  ZonePoint(52.5783478863069, 14.1071177583007, 0),
  ZonePoint(52.5781538294731, 14.1070821745501, 0),
  ZonePoint(52.5781544410232, 14.1066478786962, 0)
}
_s2Ui2.OriginalPoint = ZonePoint(52.5782515658783, 14.1068977908887, 0)
_s2Ui2.DistanceRangeUOM = "Feet"
_s2Ui2.ProximityRangeUOM = "Meters"
_s2Ui2.OutOfRangeName = ""
_s2Ui2.InRangeName = ""
_5wT4b = Wherigo.Zone(_VwtHO)
_5wT4b.Id = "137b34d5-51b7-41bc-8d5c-c9745115b980"
_5wT4b.Name = _ocKm("aAn3\015`R\015$?\015>")
_5wT4b.Description = ""
_5wT4b.Visible = false
_5wT4b.Media = _jKUq
_5wT4b.Icon = _jKUq
_5wT4b.Commands = {}
_5wT4b.DistanceRange = Distance(-1, "feet")
_5wT4b.ShowObjects = "OnEnter"
_5wT4b.ProximityRange = Distance(60, "meters")
_5wT4b.AllowSetPositionTo = false
_5wT4b.Active = false
_5wT4b.Points = {
  ZonePoint(52.5782913851236, 14.1085336879906, 0),
  ZonePoint(52.5782924682386, 14.1088019319401, 0),
  ZonePoint(52.5781021709001, 14.1087841473394, 0),
  ZonePoint(52.5781159813423, 14.1084700808713, 0)
}
_5wT4b.OriginalPoint = ZonePoint(52.5782005014012, 14.1086474620353, 0)
_5wT4b.DistanceRangeUOM = "Feet"
_5wT4b.ProximityRangeUOM = "Meters"
_5wT4b.OutOfRangeName = ""
_5wT4b.InRangeName = ""
_6_yEA = Wherigo.Zone(_VwtHO)
_6_yEA.Id = "743b87b0-d2f9-43b2-8ff5-168055eb2a96"
_6_yEA.Name = _ocKm("aa\fn*Km$??")
_6_yEA.Description = _ocKm("3$>nhw\027`\0156n<\015Kn3\015`ny6<n\f6n<\015Kn\018$\006L\0156nKy\015??\0156nR$>n\027$6L?n\fmHn")
_6_yEA.Visible = false
_6_yEA.Media = _iKfA
_6_yEA.Icon = _iKfA
_6_yEA.Commands = {}
_6_yEA.DistanceRange = Distance(-1, "feet")
_6_yEA.ShowObjects = "OnEnter"
_6_yEA.ProximityRange = Distance(60, "meters")
_6_yEA.AllowSetPositionTo = false
_6_yEA.Active = false
_6_yEA.Points = {
  ZonePoint(52.579496395205, 14.1106305365189, 0),
  ZonePoint(52.5796275678397, 14.1109761554889, 0),
  ZonePoint(52.5794208488398, 14.1111249880713, 0),
  ZonePoint(52.5793191039741, 14.1108007456597, 0)
}
_6_yEA.OriginalPoint = ZonePoint(52.5794659789646, 14.1108831064347, 0)
_6_yEA.DistanceRangeUOM = "Feet"
_6_yEA.ProximityRangeUOM = "Meters"
_6_yEA.OutOfRangeName = ""
_6_yEA.InRangeName = ""
_FDSB2 = Wherigo.Zone(_VwtHO)
_FDSB2.Id = "9df5f7f2-21d2-4a82-bd94-490237ec9726"
_FDSB2.Name = _ocKm("asn\027$6L?n\fmn$6?n}9wmm\015>9\f\027")
_FDSB2.Description = _ocKm("~\0159{9n`\015\t9?n$6?n}9wmm\015>9\f\027H")
_FDSB2.Visible = false
_FDSB2.Media = _jKUq
_FDSB2.Icon = _jKUq
_FDSB2.Commands = {}
_FDSB2.DistanceRange = Distance(-1, "feet")
_FDSB2.ShowObjects = "OnEnter"
_FDSB2.ProximityRange = Distance(60, "meters")
_FDSB2.AllowSetPositionTo = false
_FDSB2.Active = false
_FDSB2.Points = {
  ZonePoint(52.57587, 14.1069443219114, 0),
  ZonePoint(52.5759654287374, 14.1072845759014, 0),
  ZonePoint(52.5757570773382, 14.1073377303951, 0),
  ZonePoint(52.575692472052, 14.1070294343316, 0)
}
_FDSB2.OriginalPoint = ZonePoint(52.5758212445319, 14.1071490156349, 0)
_FDSB2.DistanceRangeUOM = "Feet"
_FDSB2.ProximityRangeUOM = "Meters"
_FDSB2.OutOfRangeName = ""
_FDSB2.InRangeName = ""
_KXQ5l = Wherigo.Zone(_VwtHO)
_KXQ5l.Id = "f6c51224-b3ad-4a70-8f33-e2b617727a8d"
_KXQ5l.Name = _ocKm("azn0w\"h\0156R\015`")
_KXQ5l.Description = _ocKm("3$>nhw\027`\0156n<\015Kn3\015`n\01569\027\f6`n<\015>n}9wmm\015>H")
_KXQ5l.Visible = false
_KXQ5l.Media = _jKUq
_KXQ5l.Icon = _jKUq
_KXQ5l.Commands = {}
_KXQ5l.DistanceRange = Distance(-1, "feet")
_KXQ5l.ShowObjects = "OnEnter"
_KXQ5l.ProximityRange = Distance(60, "meters")
_KXQ5l.AllowSetPositionTo = false
_KXQ5l.Active = false
_KXQ5l.Points = {
  ZonePoint(52.5758856643728, 14.0902497007551, 0),
  ZonePoint(52.5759580449316, 14.090359329894, 0),
  ZonePoint(52.5759099242997, 14.0905203365766, 0),
  ZonePoint(52.5758136828774, 14.0903989217012, 0)
}
_KXQ5l.OriginalPoint = ZonePoint(52.5758918291204, 14.0903820722317, 0)
_KXQ5l.DistanceRangeUOM = "Feet"
_KXQ5l.ProximityRangeUOM = "Meters"
_KXQ5l.OutOfRangeName = ""
_KXQ5l.InRangeName = ""
_7Ux7 = Wherigo.Zone(_VwtHO)
_7Ux7.Id = "9e0aecf5-8b92-499c-bf7c-9e1ab2140cbd"
_7Ux7.Name = _ocKm("a%nFy\01569\015>1y\015\027\027\015")
_7Ux7.Description = _ocKm("oyhn<\015Kn0w\"h\0156R\015`n`\015\t9k?nR\015$9\015>nm$?n{y>nF\195\18869\015>1y\015\027\027\015H")
_7Ux7.Visible = false
_7Ux7.Media = __CmO
_7Ux7.Icon = __CmO
_7Ux7.Commands = {}
_7Ux7.DistanceRange = Distance(-1, "feet")
_7Ux7.ShowObjects = "OnEnter"
_7Ux7.ProximityRange = Distance(60, "meters")
_7Ux7.AllowSetPositionTo = false
_7Ux7.Active = false
_7Ux7.Points = {
  ZonePoint(52.5748962261762, 14.0848216049676, 0),
  ZonePoint(52.5749024894642, 14.0851975910812, 0),
  ZonePoint(52.5747238160284, 14.0852137905784, 0),
  ZonePoint(52.5747165510053, 14.0847999410744, 0)
}
_7Ux7.OriginalPoint = ZonePoint(52.5748097706685, 14.0850082319254, 0)
_7Ux7.DistanceRangeUOM = "Feet"
_7Ux7.ProximityRangeUOM = "Meters"
_7Ux7.OutOfRangeName = ""
_7Ux7.InRangeName = ""
_0et = Wherigo.Zone(_VwtHO)
_0et.Id = "8d08c8c3-72f7-4197-9259-65172f6b078c"
_0et.Name = _ocKm("a\002nF$\015m\015\027\"hy\t\027")
_0et.Description = _ocKm("0$\015>n`\015\t\0156nR$>nR$\015<\015>n>\015$6n$6n<\0156n3\f\027<H")
_0et.Visible = false
_0et.Media = _XiJ
_0et.Icon = _XiJ
_0et.Commands = {}
_0et.DistanceRange = Distance(-1, "feet")
_0et.ShowObjects = "OnEnter"
_0et.ProximityRange = Distance(60, "meters")
_0et.AllowSetPositionTo = false
_0et.Active = false
_0et.Points = {
  ZonePoint(52.5787822525389, 14.0864043256649, 0),
  ZonePoint(52.5786187523297, 14.0866841905772, 0),
  ZonePoint(52.5784913512149, 14.0864054460297, 0),
  ZonePoint(52.578665079916, 14.086114789322, 0)
}
_0et.OriginalPoint = ZonePoint(52.5786393589999, 14.0864021878985, 0)
_0et.DistanceRangeUOM = "Feet"
_0et.ProximityRangeUOM = "Meters"
_0et.OutOfRangeName = ""
_0et.InRangeName = ""
_40n = Wherigo.Zone(_VwtHO)
_40n.Id = "650bebc4-e7c2-43fc-9247-898df28d24b9"
_40n.Name = _ocKm("abn4$6\f\027")
_40n.Description = _ocKm("~\0159{9n?$6<nR$>n`\027\015$\006\tn\fKn4$6\f\027H")
_40n.Visible = false
_40n.Media = _7L0
_40n.Icon = _7L0
_40n.Commands = {}
_40n.DistanceRange = Distance(-1, "feet")
_40n.ShowObjects = "OnEnter"
_40n.ProximityRange = Distance(60, "meters")
_40n.AllowSetPositionTo = false
_40n.Active = false
_40n.Points = {
  ZonePoint(52.5797733778018, 14.0774305584342, 0),
  ZonePoint(52.5799075803325, 14.0777265909378, 0),
  ZonePoint(52.5797590278573, 14.0779261681674, 0),
  ZonePoint(52.5795802073531, 14.0775939314442, 0)
}
_40n.OriginalPoint = ZonePoint(52.5797550483362, 14.0776693122459, 0)
_40n.DistanceRangeUOM = "Feet"
_40n.ProximityRangeUOM = "Meters"
_40n.OutOfRangeName = ""
_40n.InRangeName = ""
_gPir = Wherigo.Zone(_VwtHO)
_gPir.Id = "c4a5ff19-4307-4ad6-abd4-0cb6fb90b6da"
_gPir.Name = _ocKm("a|nUw>h$6\f\027")
_gPir.Description = _ocKm("~\0159{9n`\015\t9n\015?n\0159R\f?n<\0156nt\015>`n\tw\006\tH")
_gPir.Visible = false
_gPir.Media = _Jrx
_gPir.Icon = _Jrx
_gPir.Commands = {}
_gPir.DistanceRange = Distance(-1, "feet")
_gPir.ShowObjects = "OnEnter"
_gPir.ProximityRange = Distance(60, "meters")
_gPir.AllowSetPositionTo = false
_gPir.Active = false
_gPir.Points = {
  ZonePoint(52.5796003626684, 14.0812357033323, 0),
  ZonePoint(52.579274542112, 14.0814250741456, 0),
  ZonePoint(52.5791753327892, 14.0809704973603, 0),
  ZonePoint(52.5795352086745, 14.0807368064777, 0)
}
_gPir.OriginalPoint = ZonePoint(52.579396361561, 14.081092020329, 0)
_gPir.DistanceRangeUOM = "Feet"
_gPir.ProximityRangeUOM = "Meters"
_gPir.OutOfRangeName = ""
_gPir.InRangeName = ""
_rY32l = Wherigo.Zone(_VwtHO)
_rY32l.Id = "c995183e-6bf2-44d4-8168-324a93ffd744"
_rY32l.Name = _ocKm("a5n>\015\006\t9?n\tw\006\t")
_rY32l.Description = _ocKm("3$>n`\015\t\0156n<\0156n0\fy\"9R\015`n\01569\027\f6`nm$?n{y>n6\f\015\006\t?9\0156n7>\015y{y6`H")
_rY32l.Visible = false
_rY32l.Media = _Jrx
_rY32l.Icon = _Jrx
_rY32l.Commands = {}
_rY32l.DistanceRange = Distance(-1, "feet")
_rY32l.ShowObjects = "OnEnter"
_rY32l.ProximityRange = Distance(60, "meters")
_rY32l.AllowSetPositionTo = false
_rY32l.Active = false
_rY32l.Points = {
  ZonePoint(52.5782749687839, 14.0814453018092, 0),
  ZonePoint(52.5784124273963, 14.0819515799003, 0),
  ZonePoint(52.5786775763345, 14.0818239725811, 0),
  ZonePoint(52.5785950301389, 14.0813547069559, 0)
}
_rY32l.OriginalPoint = ZonePoint(52.5784900006634, 14.0816438903116, 0)
_rY32l.DistanceRangeUOM = "Feet"
_rY32l.ProximityRangeUOM = "Meters"
_rY32l.OutOfRangeName = ""
_rY32l.InRangeName = ""
_h3a = Wherigo.Zone(_VwtHO)
_h3a.Id = "6bde0f4b-c5e7-419d-be7a-a84eac871e6e"
_h3a.Name = _ocKm("asn\027$6L?n\fmn$6?n}9wmm\015>9\f\027")
_h3a.Description = _ocKm("3$>n`\015\t\0156n<\0156n3\015`n{y>y\015\006Lny6<nLw\01566\0156n<\f66n<\015Kn>w9\0156n(y6L9nm$?n{y>n6\f\015\006\t?9\0156n}9\f9$w6nhw\027`\0156Hn")
_h3a.Visible = false
_h3a.Media = _jKUq
_h3a.Icon = _jKUq
_h3a.Commands = {}
_h3a.DistanceRange = Distance(-1, "feet")
_h3a.ShowObjects = "OnEnter"
_h3a.ProximityRange = Distance(60, "meters")
_h3a.AllowSetPositionTo = false
_h3a.Active = false
_h3a.Points = {
  ZonePoint(52.57587, 14.1069443219114, 0),
  ZonePoint(52.5759654287374, 14.1072845759014, 0),
  ZonePoint(52.5757570773382, 14.1073377303951, 0),
  ZonePoint(52.575692472052, 14.1070294343316, 0)
}
_h3a.OriginalPoint = ZonePoint(52.5758212445319, 14.1071490156349, 0)
_h3a.DistanceRangeUOM = "Feet"
_h3a.ProximityRangeUOM = "Meters"
_h3a.OutOfRangeName = ""
_h3a.InRangeName = ""
_Ied_k = Wherigo.ZCharacter({Cartridge = _VwtHO, Container = Player})
_Ied_k.Id = "97b7a059-8312-4e19-9094-0db73f474ca7"
_Ied_k.Name = _ocKm("3\f\0279\015>")
_Ied_k.Description = ""
_Ied_k.Visible = false
_Ied_k.Media = _jKUq
_Ied_k.Commands = {}
_Ied_k.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_Ied_k.Gender = "Male"
_Ied_k.Type = "NPC"
_8st = Wherigo.ZItem({Cartridge = _VwtHO, Container = _Ied_k})
_8st.Id = "a975e2ba-be56-40b9-979c-5994550bab01"
_8st.Name = _ocKm("}\"w$\027\015>")
_8st.Description = ""
_8st.Visible = true
_8st.Media = _b3iKS
_8st.Commands = {}
_8st.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_8st.Locked = false
_8st.Opened = false
_SAzgJ = Wherigo.ZItem(_VwtHO)
_SAzgJ.Id = "d1614c84-9cd3-4a67-a911-5be046913f1b"
_SAzgJ.Name = _ocKm("X6\027w\006L\006w<\015")
_SAzgJ.Description = ""
_SAzgJ.Visible = true
_SAzgJ.Commands = {
  _EE1V = Wherigo.ZCommand({
    Text = _ocKm("Yw<\015n\fm>yh\0156"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _ocKm("P$\006\t9nW\015>h\195\188`m\f>")
  })
}
_SAzgJ.Commands._EE1V.Custom = true
_SAzgJ.Commands._EE1V.Id = "415382ec-9017-47b4-aa66-fbff3d2a5469"
_SAzgJ.Commands._EE1V.WorksWithAll = true
_SAzgJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_SAzgJ.Locked = false
_SAzgJ.Opened = false
_BFR = Wherigo.ZItem({Cartridge = _VwtHO, Container = _Ied_k})
_BFR.Id = "bd93bc24-7a02-44b1-8cc0-560423cdff56"
_BFR.Name = _ocKm("}\"w$\027\015>\0176\f\t")
_BFR.Description = ""
_BFR.Visible = true
_BFR.Media = _UuZ
_BFR.Commands = {}
_BFR.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BFR.Locked = false
_BFR.Opened = false
_xOfI = _ocKm("\018d7a%")
_ZA9h = 43
_eZ_cy = 5
_x1t = _ocKm("\017hN(\019")
_3zW = _ocKm("\017*\015<\017L")
_JHN = _ocKm("\017|?9")
_p3g = _ocKm("<yKK@")
_xxYJ = _ocKm("\017Xbg>Y")
_wFY = _ocKm("<yKK@")
_VwtHO.ZVariables = {
  _xOfI = _ocKm("\018d7a%"),
  _ZA9h = 43,
  _eZ_cy = 5,
  _x1t = _ocKm("\017hN(\019"),
  _3zW = _ocKm("\017*\015<\017L"),
  _JHN = _ocKm("\017|?9"),
  _p3g = _ocKm("<yKK@"),
  _xxYJ = _ocKm("\017Xbg>Y"),
  _wFY = _ocKm("<yKK@")
}
_U9jrC = Wherigo.ZInput(_VwtHO)
_U9jrC.Id = "98534e97-bf03-4668-848b-2bf4e227db0c"
_U9jrC.Name = _ocKm("4>\f`\015\017}9\f>9")
_U9jrC.Description = ""
_U9jrC.Visible = true
_U9jrC.InputType = "Text"
_U9jrC.Text = _ocKm("t\015Ww>n\015?n\027w?`\015\t9nKy??9n<ynK$>n6w\006\tn\015$6\015n4>\f`\015nm\015\f69Rw>9\0156Hn3\015\027\006\t\015n\018\f9\0156`>y6<\027\f`\015n\t\f9n<$\015n*6hw9\fh\015\027n\v\fyhn\015$6\0156nt\027$\006L\vn^>\015\006\t9?ny69\0156EQ")
_CCLU = Wherigo.ZInput(_VwtHO)
_CCLU.Id = "75cdacf6-dbd0-4aff-9416-7c815011676b"
_CCLU.Name = _ocKm("4>\f`\015\017\018\f\006\t?m\015>`")
_CCLU.Description = ""
_CCLU.Visible = true
_CCLU.InputType = "Text"
_CCLU.Text = _ocKm("t\015Ww>n\015?nR\015$9\015>n`\015\t9nKy??9n<ynK$>n6w\006\tn\015$6\015n4>\f`\015nm\015\f69Rw>9\0156Hn#tN/3$\015W$\015\027\015n\021\0159\015>n\f6n0w\015\t\015nW\015>\027$\015>9n<\015>n}9w\015mm\015>n\fyhn?\015$6\015>na%nLKn\027\f6`\0156n}9>\015\006L\015Q")
_mzV0 = Wherigo.ZInput(_VwtHO)
_mzV0.Id = "f614eaa3-2353-4b71-98e0-7d5f0a5d6df4"
_mzV0.Name = _ocKm("7>y`m\015>`\0174>\f`\015")
_mzV0.Description = ""
_mzV0.Visible = true
_mzV0.InputType = "Text"
_mzV0.Text = _ocKm("t\015Ww>n\015?nR$\015<\015>n>y69\015>n`\015\t9n6w\006\tn\015$6\015n4>\f`\015Hn3\015\027\006\t\015nPyKK\015>n\t\f9n<\015>n\021\f?9n<\015>n$66\015>\t\f\027mn<\015>nXK{\f\015y6y6`n?9\015\t9Q")
function _VwtHO:OnStart()
end
function _VwtHO:OnRestore()
end
function _fRPL:OnEnter()
  _x1t = _ocKm("\017hN(\019")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>nKy\015??\0156nR$>n>\015\006\t9?n\fmHn(\f??n\fyhn<\0156n}9>\f??\0156W\015>L\015\t>n\fyhZ"),
      Media = _jKUq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _MTZ.Visible = true
  _MTZ.Active = true
end
function _fRPL:OnExit()
  _x1t = _ocKm("\017hN(\019")
  _9Y0.Active = false
  _9Y0.Visible = false
  _VwtHO:RequestSync()
end
function _MTZ:OnEnter()
  _x1t = _ocKm("\017\021dq")
  _Ed8.Active = true
  _Ed8.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>n`\015\t9?n>\015\006\t9?n>\015$6nN$\006\t9y6`n3y>{\015\027h$\006\t9\015ny6<n$KK\015>n\fKn}w\"\t$\0156h\027$\015??n\01569\027\f6`H"),
      Media = _M6bVT
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _MTZ:OnExit()
  _x1t = _ocKm("\017\021dq")
  _fRPL.Active = false
  _fRPL.Visible = false
  _VwtHO:RequestSync()
end
function _Ed8:OnEnter()
  _x1t = _ocKm("\017O<|")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>n$?9n<\015>ny>?\">y\0156`\027$\006\t\015n3\015`n`\015?\"\015>>9ny6<nR$>nKy\015??\0156n\fyhn<$\015n\f6<\015>\015nXh\015>?\015$9\015nR\015\006\t?\015\0276HnF\027\015$\006\tn6\f\006\tn<\015>n\015>?9\0156nt>y\015\006L\015n`\015\t\0156nR$>n6\f\006\tn\027$6L?H"),
      Media = _YpNI8
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _oR1NG.Active = true
  _oR1NG.Visible = true
end
function _Ed8:OnExit()
  _x1t = _ocKm("\017O<|")
  _MTZ.Active = false
  _MTZ.Visible = false
  _VwtHO:RequestSync()
end
function _oR1NG:OnEnter()
  _x1t = _ocKm("\017wNAPF")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>n?9\015\t\0156nR$>n\f6n<\015KnN\015?9nWw6n<\015>n3y>{\015\027h$\006\t9\015Hn"),
      Media = _jKUq
    },
    {
      Text = _ocKm("oKnA|H;AHa;;5n\t\f9n\015$6n\031>L\f6n<\015?n}9y>K9$\015h?n\v7@>$\027\027\vn<$\015n3y>{\015\027h$\006\t9\015n`\015h\f\015\027\0279H#tN/76\f\"\"n\195\188m\015>n<\015>n3y>{\015\027n$?9n<\015>n}9\fKKn<\015?n\015\t\015K\f\027?ns%nKn\tw\t\0156nt\fyK\015?n`\015m>w\006\t\0156H#tN/"),
      Media = _e4A
    },
    {
      Text = _ocKm("3\015$9\015>n`\015\t9?n{y>n\018>\f\006\t\0156L\015\t\027\015Hn\018\f{ynKy\015??\0156nR$>n<\0156n3\015`n{y>\195\188\006L`\015\t\0156n<\0156nR$>n`\015LwKK\0156n?$6<Hn"),
      Media = _jKUq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _y1vj.Active = true
  _y1vj.Visible = true
end
function _oR1NG:OnExit()
  _x1t = _ocKm("\017wNAPF")
  _Ed8.Active = false
  _Ed8.Visible = false
  _VwtHO:RequestSync()
end
function _9Y0:OnEnter()
  _x1t = _ocKm("\017b2;")
  _Urwigo.Dialog(false, {
    {
      Text = (_ocKm("0\f\027\027wn") .. Player.Name) .. _ocKm("nS6m?\"\022$\006\tnm$6n3\f\0279\015>ny6<n$\006\tnR\015><\015n<$\006\tn\fyhn<\015>nA;nLKn3\f6<\015>y6`n$KnP\f9y>\"\f>Ln\021\f\015>L$?\006\t\015n}\006\tR\015${nm\015`\027\015$9\0156Hn#tN/*\006\tn\twhh\015n<ynm$?9n`y9n\fy?`\015>y\015?9\0159Hn\018\f66nLw\01566\0156nR$>ng\fn?9\f>9\0156H"),
      Media = _jKUq
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_U9jrC)
    end)
  end)
end
function _9Y0:OnExit()
  _x1t = _ocKm("\017b2;")
  _VwtHO:RequestSync()
end
function _y1vj:OnEnter()
  _x1t = _ocKm("\017@AWg")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nK\195\188??\0156nR$>n\027$6L?n\fmn$6n<$\015n\018>\f\006\t\0156L\015\t\027\015Hn3$>nR\f6<\015>6ng\0159{9n\tw\006\tn{yKn7>y`m\015>`H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _2H5L.Active = true
  _2H5L.Visible = true
end
function _y1vj:OnExit()
  _x1t = _ocKm("\017@AWg")
  _oR1NG.Visible = false
  _oR1NG.Active = false
  _VwtHO:RequestSync()
end
function _2H5L:OnEnter()
  _x1t = _ocKm("\017a0%\019")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nR$>n6\f\006\tn>\015\006\t9?HnPy>n6w\006\tna;;n\021\0159\015>nm$?n{yKn7>y`m\015>`H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _pY1.Active = true
  _pY1.Visible = true
end
function _2H5L:OnExit()
  _x1t = _ocKm("\017a0%\019")
  _y1vj.Active = false
  _y1vj.Visible = false
  _VwtHO:RequestSync()
end
function _pY1:OnEnter()
  _x1t = _ocKm("\017\"2A")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("3$>n\t\fm\0156n\015?n`\015?\006\t\fhh9ny6<n?$6<n\fyhn<\015Kn7>y`m\015>`n\nn<\015>n\tw\015\006\t?9\0156nO>\t\015my6`n$KnP\f9y>\"\f>LHn"),
      Media = _LoNa
    }
  }, function(action)
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_mzV0)
    end)
  end)
end
function _pY1:OnExit()
  _x1t = _ocKm("\017\"2A")
  _2H5L.Active = false
  _2H5L.Visible = false
  _VwtHO:RequestSync()
end
function _dRm:OnEnter()
  _x1t = _ocKm("\017<NK")
  _ZxD1.Active = true
  _ZxD1.Visible = true
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>ny\015m\015>1y\015>\0156nR$>n<\0156nm>\015$9\0156n3\015`ny6<n`\015\t\0156n\fKn4\015\027<>\f6<nR\015$9\015>HnF\015\027m\015>n(y6L9Z"),
      Media = _jKUq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _dRm:OnExit()
  _x1t = _ocKm("\017<NK")
  _pY1.Active = false
  _pY1.Visible = false
  _VwtHO:RequestSync()
end
function _ZxD1:OnEnter()
  _x1t = _ocKm("\017qi\018A")
  _xCHP.Active = true
  _xCHP.Visible = true
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nm$\015`\0156nR$>n6\f\006\tn\027$6L?n\fmn\fyhn<\0156n(w\0159\0156?9\015$`H"),
    Media = _rN7M,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _ZxD1:OnExit()
  _x1t = _ocKm("\017qi\018A")
  _dRm.Active = false
  _dRm.Visible = false
  _VwtHO:RequestSync()
end
function _xCHP:OnEnter()
  _x1t = _ocKm("\017iY0(")
  _ns2R.Active = true
  _ns2R.Visible = true
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nR$>n\027$6L?n\tw\006\tCn<\01566n$\006\tnR$\027\027n<$>n<\0156nd\015yh\015\027??9\015$6n{\015$`\0156Hn"),
    Media = _jV6,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _xCHP:OnExit()
  _x1t = _ocKm("\017iY0(")
  _ZxD1.Active = false
  _ZxD1.Visible = false
  _VwtHO:RequestSync()
end
function _ns2R:OnEnter()
  _x1t = _ocKm("\0176?aN")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("3$>n\t\fm\0156n<\0156nd\015yh\015\027??9\015$6n\015>>\015$\006\t9Hnqyn<\015Kn}9\015$6n`$m9n\015?n\015$6\015n}\f`\015H"),
      Media = _WxX
    },
    {
      Text = _ocKm("Uw>n\027\f6`\015>nq\015$9nR\f>n<$\015?\015>n}9\015$6n6w\006\tn6$\006\t9n{\015>m>w\006\t\0156Hn\018$\015nt\fy\015>6n6y9{9\0156n$\t6n\f\027?nd$?\006\tnh\195\188>n$\t>n7\f>9\0156?\"$\015\027Hno6n\015$6\015Kn?w\027\006\t\0156nd\f`CnL\fKn<\015>nd\015yh\015\027n<\f\t\015>HnO>n?\f\tn?$\006\tn<$\015n\021\f\01566\015>ny6<n$\t>nd>\015$m\0156n\015$6\015n{\015$9\027\f6`n\f6CnK$?\006\t9\015n?$\006\tn<\f66n\fm\015>nm\f\027<n\015$6Hnoyhn<$\015n4w><\015>y6`n<\015?nd\015yh\015\027?CnK$9?\"$\015\027\0156n{yn<y\015>h\0156Cn`$6`\0156n<$\015n\021\f\01566\015>nw\t6\015n`>w??\015?nqw\015`\015>6n\015$6Hn"),
      Media = _kuk
    },
    {
      Text = _ocKm("O$6nom?\006\t\027\f`\0156n<$\015?\015>nt$99\015n\t\f\01599\015n$\t6\0156n<\015>nd\015yh\015\027n?$\006\t\015>n6$\006\t9nW\015>{$\015\t\0156Hn}wn?\"$\015\0279\0156n<$\015n\021\f\01566\015>ny6<n<\015>nd\015yh\015\027HnP\f\006\t<\015Kn<\015>nd\015yh\015\027n<$\015n\015>?9\0156n}\"$\015\027\015nW\015>\027w>ny6<ng\015<\015?K\f\027n\015$6nFw\027<?9y\015\006Ln\fy?n?\015$6\015Kn\f6`\015\t\f\015yh9\0156nU\015>Kw\015`\0156n\fm`\015m\0156nKy??9\015Cnm\015?\006\t\027w??n\015>CnL\027\015$6\015nd>$\006L?n\f6{yR\0156<\0156nyKn?\015$6nFw\027<nR$\015<\015>n{yn\tw\027\0156Hn\018w\006\tn<$\015n\021\f\01566\015>n\015>\f\t69\0156n<\015?nd\015yh\015\027?n\019$?9Hn}$\015n?\"$\015\0279\0156n6w\006\tn`\015>$??\0156\015>n\f\027?n<\015>nd\015yh\015\027HnX6<n?wn{w`\0156n?$\015n$\tKn\015$6nFw\027<?9y\015\006Ln6\f\006\tn<\015Kn\f6<\015>\0156n\fy?n<\015>nd\f?\006\t\015H"),
      Media = _kuk
    },
    {
      Text = _ocKm("X6<ny6R\015$`\015>\027$\006\tnL\fKn\015?Cn<\f??n<\015>nd\015yh\015\027n?\015$6n\027\0159{9\015?nFw\027<?9y\015\006Ln\fy?n<\015>nd\f?\006\t\015n\tw\0279\015Hnom\015>n\fy\006\tn<$\015?\015>nO$6?\f9{nm>\f\006\t9\015n$\tKnL\015$6nF\027y\015\006Lny6<n\015>nW\015>\027w>HnUw\027\027\015>n3y9n?\">\f6`n<\015>nd\015yh\015\027n\fyhHnO$6n`\015R\f\0279$`\015>nt\027$9{n?\006\t\027y`n\fy`\0156m\027$\006L\027$\006\tn$6n<\0156n}9\015$6n\015$6Cn?\"\f\0279\0159\015n$\t6ny6<n<\015>nd\015yh\015\027n\01569R$\006\tCnyK`\015m\0156nWw6n\015$6\015>n}\006\tR\015h\015\027Rw\027L\015Cn$6n<$\015n0w\015\027\027\015Hn"),
      Media = _kuk
    },
    {
      Text = _ocKm("~\0159{9n`\015\t9n\015?nR$\015<\015>n>y69\015>n{yKn(w\0159\0156?9\015$`H"),
      Media = _jKUq
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _vqV.Active = true
  _vqV.Visible = true
end
function _ns2R:OnExit()
  _x1t = _ocKm("\0176?aN")
  _xCHP.Active = false
  _xCHP.Visible = false
  _VwtHO:RequestSync()
end
function _vqV:OnEnter()
  _x1t = _ocKm("\017W1U")
  _Urwigo.MessageBox({
    Text = _ocKm("3$>n?$6<nR$\015<\015>n\fyhn<\015Kn(w\0159\0156?9\015$`ny6<n\015?n`\015\t9n`\015>\f<\015\fy?nR\015$9\015>n{yKn\018\f\006\t?m\015>`H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _Dy0OK.Active = true
  _Dy0OK.Visible = true
end
function _vqV:OnExit()
  _x1t = _ocKm("\017W1U")
  _ns2R.Active = false
  _ns2R.Visible = false
  _VwtHO:RequestSync()
end
function _Dy0OK:OnEnter()
  _x1t = _ocKm("\017\018@;\0317")
  _Urwigo.MessageBox({
    Text = _ocKm("3$>n\t\fm\0156n<\0156n\018\f\006\t?m\015>`n\015>>\015$\006\t9Hn3\01566n\018ynR$\027\027?9nLw\01566\0156nR$>n\0159R\f?n\fy?>y\t\0156ny6<n<$\015noy??$\006\t9n`\0156$\015??\0156H"),
    Media = _x719R,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_CCLU)
        end)
      end
    end
  })
end
function _Dy0OK:OnExit()
  _x1t = _ocKm("\017\018@;\0317")
  _vqV.Active = false
  _vqV.Visible = false
  _VwtHO:RequestSync()
end
function _YEA3:OnEnter()
  _x1t = _ocKm("\0172Oos")
  _Urwigo.MessageBox({
    Text = _ocKm("O9R\f?n<\0156n0\f6`n>\015\006\t9?n>y69\015>n\027$\015`9n\015$6nw><\01569\027$\006\t\015>nt>w\006L\0156Hn}$\015\tn$\t6n<$>n>y\t$`n\f6Cn$\006\tnR\f>9\015n\t$\015>n\fyhn<$\006\tH"),
    Media = _XjBk,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _K1ZB_.Active = true
  _K1ZB_.Visible = true
end
function _YEA3:OnExit()
  _x1t = _ocKm("\0172Oos")
  _Dy0OK.Active = false
  _Dy0OK.Visible = false
  _VwtHO:RequestSync()
end
function _K1ZB_:OnEnter()
  _x1t = _ocKm("\0177Aqt\017")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nR$>n>\015\006\t9?n\fmnN$\006\t9y6`ndw>6wR?\015\015H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _3Ju0.Active = true
  _3Ju0.Visible = true
end
function _K1ZB_:OnExit()
  _x1t = _ocKm("\0177Aqt\017")
  _YEA3.Active = false
  _YEA3.Visible = false
  _VwtHO:RequestSync()
end
function _3Ju0:OnEnter()
  _x1t = _ocKm("\017s~y;")
  _Urwigo.MessageBox({
    Text = _ocKm("F\027\015$\006\tn<$\015nO>?9\015n\027$6L?n>y69\015>n{yKnF>w??\0156ndw>6wR?\015\015H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _Yl9Qs.Active = true
  _Yl9Qs.Visible = true
end
function _3Ju0:OnExit()
  _x1t = _ocKm("\017s~y;")
  _K1ZB_.Active = false
  _K1ZB_.Visible = false
  _VwtHO:RequestSync()
end
function _Yl9Qs:OnEnter()
  _x1t = _ocKm("\0172\027b\b?")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>n?$6<nR$>n$6n(>$9{\t\f`\0156Hn4y\015>ny6?n`\015\t9n\015?n\027$6L?n>yKn\fyhn<\0156n(\027\f99\0156R\015`H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _JRF.Active = true
  _JRF.Visible = true
end
function _Yl9Qs:OnExit()
  _x1t = _ocKm("\0172\027b\b?")
  _3Ju0.Active = false
  _3Ju0.Visible = false
  _VwtHO:RequestSync()
end
function _JRF:OnEnter()
  _x1t = _ocKm("\017~N4")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nR$>n>\015\006\t9?n\fmn\fyhn<$\015no?\"\t\f\0279?9>\f??\015Hno\006\t9y6`noy9wW\015>L\015\t>Z"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _s2Ui2.Active = true
  _s2Ui2.Visible = true
end
function _JRF:OnExit()
  _x1t = _ocKm("\017~N4")
  _Yl9Qs.Active = false
  _Yl9Qs.Visible = false
  _VwtHO:RequestSync()
end
function _s2Ui2:OnEnter()
  _x1t = _ocKm("\017?aX$a")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>n>\015\006\t9?n`$m9n\015?n\015$6\015nt\f<\015?9\015\027\027\015HnU$\015\027\027\015$\006\t9nKw\015\006\t9\015?9n<yn<$>n\0159R\f?n<$\015n4y\015??\015nLy\015\t\027\0156QZ"),
    Media = _U9jQG,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _5wT4b.Active = true
  _5wT4b.Visible = true
end
function _s2Ui2:OnExit()
  _x1t = _ocKm("\017?aX$a")
  _JRF.Active = false
  _JRF.Visible = false
  _VwtHO:RequestSync()
end
function _5wT4b:OnEnter()
  _x1t = _ocKm("\017%Rdzm")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("3$>n\t\fm\0156n<\0156n`>w\015??9\0156nd\015$\027n<\015>nNy6<\015n`\015?\006\t\fhh9H"),
      Media = _jKUq
    },
    {
      Text = _ocKm("Y\fHna;;n\021\0159\015>nWw6n\t$\015>nLw\01566\0156nR$>ny6?nWw6nAaH;;nm$?nA5H;;nX\t>n^\018$\n}wEn\0159R\f?n?9\f\015>L\0156Hn\031mn<\f?n\fy\006\tn$KK\015>n$6n<\0156n3$69\015>Kw6\f9\0156n`$\0279nL\f66n$\006\tn6$\006\t9n?\f`\0156Z#tN/3$\027\027?9n<yn<$\006\tn\0159R\f?n\fy?>y\t\0156ny6<n?9\f\015>L\0156Q"),
      Media = _p8mD,
      Buttons = {
        _ocKm("~o"),
        _ocKm("PO*P")
      }
    }
  }, function(action)
    if action == "Button1" then
      _Urwigo.MessageBox({
        Text = _ocKm("P\fn<\f66n\015$6h\f\006\tn`\015>\f<\015\fy?H"),
        Media = _jKUq,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
      _6_yEA.Active = true
      _6_yEA.Visible = true
    elseif action == "Button2" then
      _Urwigo.MessageBox({
        Text = _ocKm("\0317Zn\018\f66n`\015\t9?n>\015\006\t9?n>yKnR\015$9\015>H"),
        Media = _jKUq,
        Callback = function(action)
          if action ~= nil then
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
      _FDSB2.Active = true
      _FDSB2.Visible = true
    end
  end)
end
function _5wT4b:OnExit()
  _x1t = _ocKm("\017%Rdzm")
  _s2Ui2.Active = false
  _s2Ui2.Visible = false
  _VwtHO:RequestSync()
end
function _6_yEA:OnEnter()
  _x1t = _ocKm("\017\002\017@Oo")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nLw\01566\0156nR$>n\0159R\f?n\fy?>y\t\0156ny6<n\0159R\f?n\015??\0156ny6<n9>$6L\0156H"),
    Media = _qVXc1,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _h3a.Active = true
  _h3a.Visible = true
  _5wT4b.Active = false
  _5wT4b.Visible = false
end
function _6_yEA:OnExit()
  _x1t = _ocKm("\017\002\017@Oo")
  _VwtHO:RequestSync()
end
function _FDSB2:OnEnter()
  _x1t = _ocKm("\0174\018}ta")
  _Urwigo.MessageBox({
    Text = _ocKm("~\0159{9n`\015\t9n\015?n\027$6L?n$6?n}9wmm\015>9\f\027H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _KXQ5l.Active = true
  _KXQ5l.Visible = true
end
function _FDSB2:OnExit()
  _x1t = _ocKm("\0174\018}ta")
  _5wT4b.Visible = false
  _5wT4b.Active = false
  _6_yEA.Active = false
  _6_yEA.Visible = false
  _VwtHO:RequestSync()
end
function _KXQ5l:OnEnter()
  _x1t = _ocKm("\0177_\b%\027")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>n`\015\t9?n`\015>\f<\015\fy?ny6<n<\f66n\027$6L?n\fyhn<\0156n0w\"h\0156R\015`H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _7Ux7.Active = true
  _7Ux7.Visible = true
end
function _KXQ5l:OnExit()
  _x1t = _ocKm("\0177_\b%\027")
  _FDSB2.Active = false
  _FDSB2.Visible = false
  _VwtHO:RequestSync()
end
function _7Ux7:OnEnter()
  _x1t = _ocKm("\0175Xi5")
  _Urwigo.Dialog(false, {
    {
      Text = _ocKm("0$\015>n?9\015\t\0156nR$>n\f6n<\015>nFy\01569\015>1y\015\027\027\015H"),
      Media = _FpB
    },
    {
      Text = _ocKm("O$6n\"\f\f>n\021\0159\015>nR\015$9\015>n\t\f?9n<yn<$\015n6\f\015\006\t?9\015n\021w\015`\027$\006\tL\015$9n<\015$6\015n4y\015??\015n{ynLy\015\t\027\0156H"),
      Media = _sl8Hy
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
  _0et.Active = true
  _0et.Visible = true
end
function _7Ux7:OnExit()
  _x1t = _ocKm("\0175Xi5")
  _KXQ5l.Active = false
  _KXQ5l.Visible = false
  _VwtHO:RequestSync()
end
function _0et:OnEnter()
  _x1t = _ocKm("\017;\0159")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nK$>n6w\006\tK\f\027n\027$6L?ny6<n<\f66n\t\fm\0156nR$>n\015?n\fy\006\tnm\f\027<n`\015?\006\t\fhh9H"),
    Media = _jss9,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _rY32l.Visible = true
  _rY32l.Active = true
end
function _0et:OnExit()
  _x1t = _ocKm("\017;\0159")
  _7Ux7.Active = false
  _7Ux7.Visible = false
  _VwtHO:RequestSync()
end
function _40n:OnEnter()
  _x1t = _ocKm("\017z;6")
  _Urwigo.MessageBox({
    Text = _ocKm("3$>n\t\fm\0156n<\f?n4$6\f\027n\015>>\015$\006\t9Zn0\015>{\027$\006\t\0156nF\027y\015\006LRy6?\006\tZn\018\015>nY\f\006\t\015nm\015h$6<\0159n?$\006\tn\027$6L?nWwKn3\015`n$6n\015$6\015Kn9w9\0156n\027$\015`\0156<\0156nt\fyKH#tN/Py9{9n<$\015n}\"w$\027\015>m$\027<\015>n$Kn*6W\01569\f>nyKn<\0156nY\f\006\t\015n{ynh$6<\0156Hn#tN/*Kn*6W\01569\f>nh$6<\015?9n<yn\fy\006\tn<\0156nX6\027w\006L\006w<\015H#tN/4y\015>n<\0156nNy\015\006LR\015`n\015$6h\f\006\tn<\0156n3\015`nR\015$9\015>n`\015\t\0156ny6<n\f6n<\015>n6\f\015\006\t?9\0156n7>\015y{y6`n6\f\006\tn\027$6L?n^(w\0159\0156?9\015$`En\fmm$\015`\0156ny6<n<\0156n3\015`nm$?n{yKn(\f>L\"\027\f9{nhw\027`\0156H#tN/*\006\tn\twhh\015nR$>n?\015\t\0156ny6?n\fyhn\015$6\015>n<\015>n6\f\015\006\t?9\0156n3\f6<\015>y6`\0156nR$\015<\015>H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _VwtHO.Complete = true
  _8st:MoveTo(Player)
  _BFR:MoveTo(Player)
  _SAzgJ:MoveTo(Player)
  _VwtHO:RequestSync()
end
function _40n:OnExit()
  _x1t = _ocKm("\017z;6")
  _gPir.Active = false
  _gPir.Visible = false
  _VwtHO:RequestSync()
end
function _gPir:OnEnter()
  _x1t = _ocKm("\017`($>")
  _Urwigo.MessageBox({
    Text = _ocKm("3$>n?$6<n\f6n<\015>n\027\0159{9\0156n7>\015y{y6`nWw>n<\015Kn4$6\f\027Hn3$>n`\015\t\0156n\027$6L?n>yKny6<n?$6<n<\f66n`\027\015$\006\tn<\fH"),
    Media = _BdEgj,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _40n.Active = true
  _40n.Visible = true
end
function _gPir:OnExit()
  _x1t = _ocKm("\017`($>")
  _rY32l.Active = false
  _rY32l.Visible = false
  _VwtHO:RequestSync()
end
function _rY32l:OnEnter()
  _x1t = _ocKm("\017>2sa\027")
  _Urwigo.MessageBox({
    Text = _ocKm("0$\015>nKy\015??\0156nR$>n>\015\006\t9?n\tw\006\tH"),
    Media = _g05Dg,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _gPir.Active = true
  _gPir.Visible = true
end
function _rY32l:OnExit()
  _x1t = _ocKm("\017>2sa\027")
  _0et.Active = false
  _0et.Visible = false
  _VwtHO:RequestSync()
end
function _h3a:OnEnter()
  _x1t = _ocKm("\017\ts\f")
  _Urwigo.MessageBox({
    Text = _ocKm("~\0159{9n`\015\t9n\015?n\027$6L?n$6?n}9wmm\015>9\f\027H"),
    Media = _jKUq,
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
  _KXQ5l.Active = true
  _KXQ5l.Visible = true
end
function _h3a:OnExit()
  _x1t = _ocKm("\017\ts\f")
  _5wT4b.Visible = false
  _5wT4b.Active = false
  _6_yEA.Active = false
  _6_yEA.Visible = false
  _VwtHO:RequestSync()
end
function _U9jrC:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(_xOfI, input) then
    _Urwigo.MessageBox({
      Text = _ocKm("(\015>h\015L9Cn<\f66nL\195\18266\0156nR$>ng\fn\027w?H"),
      Media = _jKUq,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
    _fRPL.Active = true
    _fRPL.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _ocKm("U\015>?y\006\tn\015?n6w\006\tK\f\027H"),
      Media = _gPf,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_U9jrC)
          end)
        end
      end
    })
  end
end
function _CCLU:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if _ZA9h == input then
    _Urwigo.MessageBox({
      Text = _ocKm("om?w\027y9n>$\006\t9$`Zn3\015$9\015>n`\015\t9?H"),
      Media = _jKUq,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
    _YEA3.Active = true
    _YEA3.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _ocKm("U\015>?y\006\tn\015?n6w\006\tK\f\027H"),
      Media = _gPf,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_CCLU)
          end)
        end
      end
    })
  end
end
function _mzV0:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if _eZ_cy == input then
    _Urwigo.MessageBox({
      Text = _ocKm("N$\006\t9$`ZnF\015\t\0156nR$>nR$\015<\015>n>y69\015>nWwKn7>y`m\015>`H"),
      Media = _jKUq,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
    _dRm.Active = true
    _dRm.Visible = true
  else
    _Urwigo.MessageBox({
      Text = _ocKm("P\015\015CnP\015\015ZnU\015>?y\006\tn\015?n6w\006\tK\f\027H"),
      Media = _gPf,
      Callback = function(action)
        if action ~= nil then
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(_mzV0)
          end)
        end
      end
    })
  end
end
function _SAzgJ:On_EE1V(target)
  _Urwigo.MessageBox({
    Text = string.sub(Player.CompletionCode, 1, 15)
  })
end
return _VwtHO
