require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _rZ_(str)
  local res = ""
  local dtable = "f+\021\029uKDZy\025I\022{krvR \0175\004*\"#'d@`\003x\016]M?\r=\023\014\001%\n\019\026b)N\\_h!\a8\028[BT<J4eHpz\0246\027Y;m|/^9U3c~As(F}:\000.\031\002\t\020qLj&WV>\bQ\005\006SawPO07gi\fo1G\v$l,2\018\015EtCX-\030n"
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
var_cartridge = Wherigo.ZCartridge()
_9LtD = Wherigo.ZMedia(var_cartridge)
_9LtD.Id = "47d1fb7c-7787-44e8-92cb-e6779472003c"
_9LtD.Name = _rZ_("eL1g<m\127<")
_9LtD.Description = ""
_9LtD.AltText = ""
_9LtD.Resources = {
  {
    Type = "jpg",
    Filename = "Sight06.jpg",
    Directives = {}
  }
}
_uKH = Wherigo.ZMedia(var_cartridge)
_uKH.Id = "abd1ab34-c85e-4cbe-a938-c77f61d173cd"
_uKH.Name = _rZ_("\017otf\127\026")
_uKH.Description = ""
_uKH.AltText = ""
_uKH.Resources = {
  {
    Type = "jpg",
    Filename = "Sight05.jpg",
    Directives = {}
  }
}
_MuXP = Wherigo.ZMedia(var_cartridge)
_MuXP.Id = "ab0bd5cb-29b6-4f76-88f8-ceb25b8f152f"
_MuXP.Name = _rZ_("\017otf\127\026}\vLo\127")
_MuXP.Description = ""
_MuXP.AltText = ""
_MuXP.Resources = {
  {
    Type = "jpg",
    Filename = "Sight05Icon.jpg",
    Directives = {}
  }
}
_wkYSx = Wherigo.ZMedia(var_cartridge)
_wkYSx.Id = "645b54d1-90dd-4f6a-8f30-4de1ffe4bd92"
_wkYSx.Name = _rZ_("8mzt<")
_wkYSx.Description = ""
_wkYSx.AltText = ""
_wkYSx.Resources = {
  {
    Type = "jpg",
    Filename = "Title.jpg",
    Directives = {}
  }
}
_dh_ = Wherigo.ZMedia(var_cartridge)
_dh_.Id = "12dee812-a99e-4b4f-bf10-c56d3d267578"
_dh_.Name = _rZ_("8mzt<}\vLo\127")
_dh_.Description = ""
_dh_.AltText = ""
_dh_.Resources = {
  {
    Type = "jpg",
    Filename = "TitleIcon.jpg",
    Directives = {}
  }
}
_EeQbp = Wherigo.ZMedia(var_cartridge)
_EeQbp.Id = "bed957b4-fae9-470f-9549-9785e3b48e65"
_EeQbp.Name = _rZ_("!\005Om\014f\127z<\127")
_EeQbp.Description = ""
_EeQbp.AltText = ""
_EeQbp.Resources = {
  {
    Type = "jpg",
    Filename = "Sight04.jpg",
    Directives = {}
  }
}
_uL1rZ = Wherigo.ZMedia(var_cartridge)
_uL1rZ.Id = "cfe91c50-c1a5-456a-82f4-4b50690dcc35"
_uL1rZ.Name = _rZ_("!\005Om\014f\127z<\127}\vLo\127")
_uL1rZ.Description = ""
_uL1rZ.AltText = ""
_uL1rZ.Resources = {
  {
    Type = "jpg",
    Filename = "Sight04Icon.jpg",
    Directives = {}
  }
}
_kwD2 = Wherigo.ZMedia(var_cartridge)
_kwD2.Id = "ca3a9045-ab8d-4f74-92d6-3c411674b0c1"
_kwD2.Name = _rZ_("N\005zoEfz}{oo\015\026O")
_kwD2.Description = ""
_kwD2.AltText = ""
_kwD2.Resources = {
  {
    Type = "png",
    Filename = "AutomatCoords.png",
    Directives = {}
  }
}
_2O8GH = Wherigo.ZMedia(var_cartridge)
_2O8GH.Id = "0b2c766a-60f1-4d50-81f5-ec0dfe16280e"
_2O8GH.Name = _rZ_("N\005zoEfz}{oo\015\026O}\vLo\127")
_2O8GH.Description = ""
_2O8GH.AltText = ""
_2O8GH.Resources = {
  {
    Type = "png",
    Filename = "AutomatCoordsIcon.png",
    Directives = {}
  }
}
_XnfG = Wherigo.ZMedia(var_cartridge)
_XnfG.Id = "6f67863d-7b6a-42bf-a201-c3dbf6209bec"
_XnfG.Name = _rZ_("eL1g<m\127<}\vLo\127")
_XnfG.Description = ""
_XnfG.AltText = ""
_XnfG.Resources = {
  {
    Type = "jpg",
    Filename = "Sight06Icon.jpg",
    Directives = {}
  }
}
_C0F1 = Wherigo.ZMedia(var_cartridge)
_C0F1.Id = "c024d27b-881f-435a-9e85-0ef7f75a85ed"
_C0F1.Name = _rZ_("{om\127")
_C0F1.Description = ""
_C0F1.AltText = ""
_C0F1.Resources = {
  {
    Type = "jpg",
    Filename = "Coin.jpg",
    Directives = {}
  }
}
_H_0P = Wherigo.ZMedia(var_cartridge)
_H_0P.Id = "656af257-adff-4a52-a586-23fcd51c0bbe"
_H_0P.Name = _rZ_("{om\127}\vLo\127")
_H_0P.Description = ""
_H_0P.AltText = ""
_H_0P.Resources = {
  {
    Type = "jpg",
    Filename = "CoinIcon.jpg",
    Directives = {}
  }
}
_rJsT = Wherigo.ZMedia(var_cartridge)
_rJsT.Id = "2a5be41a-e1d6-4ff9-88ac-132e6e648e69"
_rJsT.Name = _rZ_("q<t\026,o<\015O<")
_rJsT.Description = ""
_rJsT.AltText = ""
_rJsT.Resources = {
  {
    Type = "jpg",
    Filename = "Boerse.jpg",
    Directives = {}
  }
}
_xd7_C = Wherigo.ZMedia(var_cartridge)
_xd7_C.Id = "545559b6-d6dc-479b-826d-b79f951e43bc"
_xd7_C.Name = _rZ_("q<t\026,o<\015O<}\vLo\127")
_xd7_C.Description = ""
_xd7_C.AltText = ""
_xd7_C.Resources = {
  {
    Type = "jpg",
    Filename = "BoerseIcon.jpg",
    Directives = {}
  }
}
_Hrm = Wherigo.ZMedia(var_cartridge)
_Hrm.Id = "63fd2c30-fe8f-4284-9570-113504d729af"
_Hrm.Name = _rZ_("N\005zoEfz<\127}ezfzmo\127")
_Hrm.Description = ""
_Hrm.AltText = ""
_Hrm.Resources = {
  {
    Type = "png",
    Filename = "Automaten.png",
    Directives = {}
  }
}
_dq8A = Wherigo.ZMedia(var_cartridge)
_dq8A.Id = "72c39308-0fd4-4507-ad7c-ca79e94085ab"
_dq8A.Name = _rZ_("N\005zoEfz<\127}ezfzmo\127}\vLo\127")
_dq8A.Description = ""
_dq8A.AltText = ""
_dq8A.Resources = {
  {
    Type = "png",
    Filename = "AutomatenIcon.png",
    Directives = {}
  }
}
_ZksVj = Wherigo.ZMedia(var_cartridge)
_ZksVj.Id = "902ed4e5-d917-4f40-8457-8aa9111fbc1e"
_ZksVj.Name = _rZ_("^1<\015mlo}\006oo\015\026m\127fz<\127")
_ZksVj.Description = _rZ_("q{k{=Q4")
_ZksVj.AltText = ""
_ZksVj.Resources = {
  {
    Type = "png",
    Filename = "KoordsWherigo.png",
    Directives = {}
  }
}
_X01Ox = Wherigo.ZMedia(var_cartridge)
_X01Ox.Id = "d5a6d244-d023-4e90-95b6-1c50a8d971a7"
_X01Ox.Name = _rZ_("^1<\015mlo}\006oo\015\026m\127fz<\127}\vLo\127")
_X01Ox.Description = ""
_X01Ox.AltText = ""
_X01Ox.Resources = {
  {
    Type = "png",
    Filename = "KoordsWherigoIcon.png",
    Directives = {}
  }
}
_llKe = Wherigo.ZMedia(var_cartridge)
_llKe.Id = "d670c62d-f054-40cf-ac6d-59bc5b353f83"
_llKe.Name = _rZ_("7o\127\005O}\006oo\015\026m\127fz<\127")
_llKe.Description = _rZ_("q{k=vhN")
_llKe.AltText = ""
_llKe.Resources = {
  {
    Type = "png",
    Filename = "KoordsBonus.png",
    Directives = {}
  }
}
_XLqU = Wherigo.ZMedia(var_cartridge)
_XLqU.Id = "fb485b74-99ba-4a0b-a843-a8cd204618e9"
_XLqU.Name = _rZ_("7o\127\005O}\006oo\015\026m\127fz<\127}\vLo\127")
_XLqU.Description = ""
_XLqU.AltText = ""
_XLqU.Resources = {
  {
    Type = "png",
    Filename = "KoordsBonusIcon.png",
    Directives = {}
  }
}
_fev = Wherigo.ZMedia(var_cartridge)
_fev.Id = "28c307f7-0d3c-477a-ad24-f09ad053bb66"
_fev.Name = _rZ_("N\005zoEfz}{f\127\026\t")
_fev.Description = ""
_fev.AltText = ""
_fev.Resources = {
  {
    Type = "png",
    Filename = "AutomatCandy.png",
    Directives = {}
  }
}
_RswIr = Wherigo.ZMedia(var_cartridge)
_RswIr.Id = "f761d431-f98e-468a-80a3-7075239e5bbf"
_RswIr.Name = _rZ_("N\005zoEfz}{f\127\026\t}\vLo\127")
_RswIr.Description = ""
_RswIr.AltText = ""
_RswIr.Resources = {
  {
    Type = "png",
    Filename = "AutomatCandyIcon.png",
    Directives = {}
  }
}
_IWU = Wherigo.ZMedia(var_cartridge)
_IWU.Id = "c8a2212c-1dcd-495b-a6c1-238fdde9f61d"
_IWU.Name = _rZ_("N\005zoEfz}\a\015m\127\014O")
_IWU.Description = ""
_IWU.AltText = ""
_IWU.Resources = {
  {
    Type = "png",
    Filename = "AutomatDrinks.png",
    Directives = {}
  }
}
_qIK = Wherigo.ZMedia(var_cartridge)
_qIK.Id = "e60411a7-acd0-42e7-8ed8-30ec24f6b143"
_qIK.Name = _rZ_("N\005zoEfz}\a\015m\127\014O}\vLo\127")
_qIK.Description = ""
_qIK.AltText = ""
_qIK.Resources = {
  {
    Type = "png",
    Filename = "AutomatDrinksIcon.png",
    Directives = {}
  }
}
_Kef = Wherigo.ZMedia(var_cartridge)
_Kef.Id = "a2401147-2535-43ac-8974-768b8878e9e1"
_Kef.Name = _rZ_("[oL1")
_Kef.Description = ""
_Kef.AltText = ""
_Kef.Resources = {
  {
    Type = "jpg",
    Filename = "Sight02.jpg",
    Directives = {}
  }
}
_fTvg = Wherigo.ZMedia(var_cartridge)
_fTvg.Id = "447b9897-5422-4345-877e-67ee6d0d4508"
_fTvg.Name = _rZ_("[oL1}\vLo\127")
_fTvg.Description = ""
_fTvg.AltText = ""
_fTvg.Resources = {
  {
    Type = "jpg",
    Filename = "Sight02Icon.jpg",
    Directives = {}
  }
}
_zzDw = Wherigo.ZMedia(var_cartridge)
_zzDw.Id = "ee2a0480-c89d-4401-bafd-a81978f0b398"
_zzDw.Name = _rZ_("e>\005L\014Oz<m\127")
_zzDw.Description = ""
_zzDw.AltText = ""
_zzDw.Resources = {
  {
    Type = "jpg",
    Filename = "Sight07.jpg",
    Directives = {}
  }
}
_jGf = Wherigo.ZMedia(var_cartridge)
_jGf.Id = "bf0aafb3-6a48-4f2f-8303-123a97da8ec3"
_jGf.Name = _rZ_("e>\005L\014Oz<m\127}\vLo\127")
_jGf.Description = ""
_jGf.AltText = ""
_jGf.Resources = {
  {
    Type = "jpg",
    Filename = "Sight07Icon.jpg",
    Directives = {}
  }
}
_zol = Wherigo.ZMedia(var_cartridge)
_zol.Id = "feca9b76-5b75-4fbb-a0d3-9afebefd6781"
_zol.Name = _rZ_("8oot")
_zol.Description = ""
_zol.AltText = ""
_zol.Resources = {
  {
    Type = "png",
    Filename = "Tool.png",
    Directives = {}
  }
}
_Msxu = Wherigo.ZMedia(var_cartridge)
_Msxu.Id = "84123b9d-692f-439a-87fb-afed2210e6cb"
_Msxu.Name = _rZ_("8oot}\vLo\127")
_Msxu.Description = ""
_Msxu.AltText = ""
_Msxu.Resources = {
  {
    Type = "png",
    Filename = "ToolIcon.png",
    Directives = {}
  }
}
_zCDYg = Wherigo.ZMedia(var_cartridge)
_zCDYg.Id = "ec6953f2-fe7d-42ce-acb4-cd84d0a6a6ed"
_zCDYg.Name = _rZ_("qtoL\014<\127O>m<t")
_zCDYg.Description = ""
_zCDYg.AltText = ""
_zCDYg.Resources = {
  {
    Type = "jpg",
    Filename = "Sight01.jpg",
    Directives = {}
  }
}
_GQP = Wherigo.ZMedia(var_cartridge)
_GQP.Id = "f48fe461-6cb5-4ee5-9cec-ecf2b814a484"
_GQP.Name = _rZ_("qtoL\014<\127O>m<t}\vLo\127")
_GQP.Description = ""
_GQP.AltText = ""
_GQP.Resources = {
  {
    Type = "jpg",
    Filename = "Sight01Icon.jpg",
    Directives = {}
  }
}
_T0M = Wherigo.ZMedia(var_cartridge)
_T0M.Id = "be787862-cf43-4cee-aa5a-72c3fc8b2317"
_T0M.Name = _rZ_("!fttQfE<")
_T0M.Description = ""
_T0M.AltText = ""
_T0M.Resources = {
  {
    Type = "jpg",
    Filename = "Sight03.jpg",
    Directives = {}
  }
}
_LP9i = Wherigo.ZMedia(var_cartridge)
_LP9i.Id = "04c9d08d-d21d-4472-85f0-6dfd3fcded43"
_LP9i.Name = _rZ_("!fttQfE<}\vLo\127")
_LP9i.Description = ""
_LP9i.AltText = ""
_LP9i.Resources = {
  {
    Type = "jpg",
    Filename = "Sight03Icon.jpg",
    Directives = {}
  }
}
_QxMob = Wherigo.ZMedia(var_cartridge)
_QxMob.Id = "29257a55-ed77-4b6f-b3e4-c94b0bf37f23"
_QxMob.Name = _rZ_("ezf\026zgffl<")
_QxMob.Description = ""
_QxMob.AltText = ""
_QxMob.Resources = {
  {
    Type = "jpg",
    Filename = "Sight08.jpg",
    Directives = {}
  }
}
_iw5 = Wherigo.ZMedia(var_cartridge)
_iw5.Id = "31fc7acf-288d-40c2-ac5a-c5a8874396c2"
_iw5.Name = _rZ_("ezf\026zgffl<}\vLo\127")
_iw5.Description = ""
_iw5.AltText = ""
_iw5.Resources = {
  {
    Type = "jpg",
    Filename = "Sight08Icon.jpg",
    Directives = {}
  }
}
_DY_ = Wherigo.ZMedia(var_cartridge)
_DY_.Id = "d73be698-789d-464e-9247-390d6a29403e"
_DY_.Name = _rZ_("8o\014<\127")
_DY_.Description = ""
_DY_.AltText = ""
_DY_.Resources = {
  {
    Type = "jpg",
    Filename = "Token.jpg",
    Directives = {}
  }
}
_W7PjL = Wherigo.ZMedia(var_cartridge)
_W7PjL.Id = "5ef22b65-1088-4ad9-b025-d06a8971df66"
_W7PjL.Name = _rZ_("8o\014<\127}\vLo\127")
_W7PjL.Description = ""
_W7PjL.AltText = ""
_W7PjL.Resources = {
  {
    Type = "jpg",
    Filename = "TokenIcon.jpg",
    Directives = {}
  }
}
_q2E = Wherigo.ZMedia(var_cartridge)
_q2E.Id = "ad1b3896-4c10-4496-a085-051a693794b8"
_q2E.Name = _rZ_("\a\015m\127\014O7<<\015")
_q2E.Description = ""
_q2E.AltText = ""
_q2E.Resources = {
  {
    Type = "png",
    Filename = "DrinksBeer.png",
    Directives = {}
  }
}
_twpX = Wherigo.ZMedia(var_cartridge)
_twpX.Id = "9aa5fab8-f9e5-49a7-9cfe-218f423823e0"
_twpX.Name = _rZ_("\a\015m\127\014O7<<\015}\vLo\127")
_twpX.Description = ""
_twpX.AltText = ""
_twpX.Resources = {
  {
    Type = "png",
    Filename = "DrinksBierIcon.png",
    Directives = {}
  }
}
_L1Pj = Wherigo.ZMedia(var_cartridge)
_L1Pj.Id = "2a6337bd-83ce-4a5f-a9bf-f298a0915557"
_L1Pj.Name = _rZ_("\a\015m\127\014O[mEo")
_L1Pj.Description = ""
_L1Pj.AltText = ""
_L1Pj.Resources = {
  {
    Type = "png",
    Filename = "DrinksLimo.png",
    Directives = {}
  }
}
_OKXn = Wherigo.ZMedia(var_cartridge)
_OKXn.Id = "9e749907-9b84-43ff-8e32-2508cb29fbc4"
_OKXn.Name = _rZ_("\a\015m\127\014O[mEo}\vLo\127")
_OKXn.Description = ""
_OKXn.AltText = ""
_OKXn.Resources = {
  {
    Type = "png",
    Filename = "DrinksLimoIcon.png",
    Directives = {}
  }
}
_W92M = Wherigo.ZMedia(var_cartridge)
_W92M.Id = "fda2ee79-c5ed-4ec8-a799-7ea170a68c9b"
_W92M.Name = _rZ_("{f\127\026\t\006t\005z<\127")
_W92M.Description = ""
_W92M.AltText = ""
_W92M.Resources = {
  {
    Type = "png",
    Filename = "CandyKluten.png",
    Directives = {}
  }
}
_lzUn = Wherigo.ZMedia(var_cartridge)
_lzUn.Id = "dfbbcf2e-9a22-445a-8f42-49dfa1a77bca"
_lzUn.Name = _rZ_("{f\127\026\t\006t\005z<\127}\vLo\127")
_lzUn.Description = ""
_lzUn.AltText = ""
_lzUn.Resources = {
  {
    Type = "png",
    Filename = "CandyKlutenIcon.png",
    Directives = {}
  }
}
_N7Fw1 = Wherigo.ZMedia(var_cartridge)
_N7Fw1.Id = "807ff5fb-2c69-4a6b-ae5d-8bfa7afd9653"
_N7Fw1.Name = _rZ_("{f\127\026\t7f,,<t<\015")
_N7Fw1.Description = ""
_N7Fw1.AltText = ""
_N7Fw1.Resources = {
  {
    Type = "png",
    Filename = "CandyBabbeler.png",
    Directives = {}
  }
}
_15h7 = Wherigo.ZMedia(var_cartridge)
_15h7.Id = "cb1bccd0-545c-4284-8c35-98720caa7ef9"
_15h7.Name = _rZ_("{f\127\026\t7f,,<t<\015}\vLo\127")
_15h7.Description = ""
_15h7.AltText = ""
_15h7.Resources = {
  {
    Type = "png",
    Filename = "CandyBabbelerIcon.png",
    Directives = {}
  }
}
_XvRtp = Wherigo.ZMedia(var_cartridge)
_XvRtp.Id = "fff2f603-8bd0-4818-bfa9-fc8a26d4d3c2"
_XvRtp.Name = _rZ_("=m\127\127<\015\014")
_XvRtp.Description = ""
_XvRtp.AltText = ""
_XvRtp.Resources = {
  {
    Type = "jpg",
    Filename = "PersonHinnerk.jpg",
    Directives = {}
  }
}
_PAgli = Wherigo.ZMedia(var_cartridge)
_PAgli.Id = "e38d5cfc-91d8-49e7-b5ff-f23ef92a0068"
_PAgli.Name = _rZ_("=m\127\127<\015\014}\vLo\127")
_PAgli.Description = ""
_PAgli.AltText = ""
_PAgli.Resources = {
  {
    Type = "jpg",
    Filename = "PersonHinnerkIcon.jpg",
    Directives = {}
  }
}
_T1vz = Wherigo.ZMedia(var_cartridge)
_T1vz.Id = "fce712d7-6828-4d96-95a6-94ee54abcd06"
_T1vz.Name = _rZ_("\006m\127\026")
_T1vz.Description = ""
_T1vz.AltText = ""
_T1vz.Resources = {
  {
    Type = "jpg",
    Filename = "PersonKind.jpg",
    Directives = {}
  }
}
_5t5 = Wherigo.ZMedia(var_cartridge)
_5t5.Id = "89970952-54ea-4b30-bcd1-ec0267a0157f"
_5t5.Name = _rZ_("\006m\127\026}\vLo\127")
_5t5.Description = ""
_5t5.AltText = ""
_5t5.Resources = {
  {
    Type = "jpg",
    Filename = "PersonKindIcon.jpg",
    Directives = {}
  }
}
_b8cP = Wherigo.ZMedia(var_cartridge)
_b8cP.Id = "9d194e63-4c80-4c7a-8fb7-95afe56d4549"
_b8cP.Name = _rZ_(":oll<\015m\127")
_b8cP.Description = ""
_b8cP.AltText = ""
_b8cP.Resources = {
  {
    Type = "jpg",
    Filename = "PersonJoggerin.jpg",
    Directives = {}
  }
}
_ttbZ = Wherigo.ZMedia(var_cartridge)
_ttbZ.Id = "a18f751b-e854-41d7-b594-910bead3d89d"
_ttbZ.Name = _rZ_(":oll<\015m\127}\vLo\127")
_ttbZ.Description = ""
_ttbZ.AltText = ""
_ttbZ.Resources = {
  {
    Type = "jpg",
    Filename = "PersonJoggerinIcon.jpg",
    Directives = {}
  }
}
_QsW0N = Wherigo.ZMedia(var_cartridge)
_QsW0N.Id = "9bf25e0c-762e-4b60-95d8-a3848f4e31c3"
_QsW0N.Name = _rZ_("iEf")
_QsW0N.Description = ""
_QsW0N.AltText = ""
_QsW0N.Resources = {
  {
    Type = "jpg",
    Filename = "PersonOma.jpg",
    Directives = {}
  }
}
_twx = Wherigo.ZMedia(var_cartridge)
_twx.Id = "6d593b32-d68d-49cb-926b-67c308b9bef8"
_twx.Name = _rZ_("iEf}\vLo\127")
_twx.Description = ""
_twx.AltText = ""
_twx.Resources = {
  {
    Type = "jpg",
    Filename = "PersonOmaIcon.jpg",
    Directives = {}
  }
}
_uhPEF = Wherigo.ZMedia(var_cartridge)
_uhPEF.Id = "34c8e0a5-b2cb-43d8-b1e6-c1a2b40813d0"
_uhPEF.Name = _rZ_("e>\015fL1<")
_uhPEF.Description = ""
_uhPEF.AltText = ""
_uhPEF.Resources = {
  {
    Type = "jpg",
    Filename = "Language.jpg",
    Directives = {}
  }
}
_GFjL_ = Wherigo.ZMedia(var_cartridge)
_GFjL_.Id = "b227da89-c3dc-45b5-a9fa-042e07bb6d23"
_GFjL_.Name = _rZ_("e>\015fL1<}\vLo\127")
_GFjL_.Description = ""
_GFjL_.AltText = ""
_GFjL_.Resources = {
  {
    Type = "jpg",
    Filename = "LanguageIcon.jpg",
    Directives = {}
  }
}
_beWzP = Wherigo.ZMedia(var_cartridge)
_beWzP.Id = "82efa003-c12e-4df0-8361-0f60125068a0"
_beWzP.Name = _rZ_("eL1\005<zzm\127l")
_beWzP.Description = ""
_beWzP.AltText = ""
_beWzP.Resources = {
  {
    Type = "jpg",
    Filename = "Sight09.jpg",
    Directives = {}
  }
}
_6Fvz = Wherigo.ZMedia(var_cartridge)
_6Fvz.Id = "9de1e06b-400b-4ead-ae59-d7bdc5df0507"
_6Fvz.Name = _rZ_("eL1\005<zzm\127l}\vLo\127")
_6Fvz.Description = ""
_6Fvz.AltText = ""
_6Fvz.Resources = {
  {
    Type = "jpg",
    Filename = "Sight09Icon.jpg",
    Directives = {}
  }
}
_FDi = Wherigo.ZMedia(var_cartridge)
_FDi.Id = "311c0f10-9da1-4417-805e-c7ff64a591e4"
_FDi.Name = _rZ_("!\005<1t<")
_FDi.Description = ""
_FDi.AltText = ""
_FDi.Resources = {
  {
    Type = "jpg",
    Filename = "Sight10.jpg",
    Directives = {}
  }
}
_3To7I = Wherigo.ZMedia(var_cartridge)
_3To7I.Id = "59fce88d-6461-4498-8d14-470c7d32b506"
_3To7I.Name = _rZ_("!\005<1t<}\vLo\127")
_3To7I.Description = ""
_3To7I.AltText = ""
_3To7I.Resources = {
  {
    Type = "jpg",
    Filename = "Sight10Icon.jpg",
    Directives = {}
  }
}
_ir6sI = Wherigo.ZMedia(var_cartridge)
_ir6sI.Id = "2f388b40-ced8-4981-a851-f3696106fbd3"
_ir6sI.Name = _rZ_("!f\127\005ft")
_ir6sI.Description = ""
_ir6sI.AltText = ""
_ir6sI.Resources = {
  {
    Type = "png",
    Filename = "Manual.png",
    Directives = {}
  }
}
_IXZ = Wherigo.ZMedia(var_cartridge)
_IXZ.Id = "92572ceb-9659-4949-8de7-bbe8103b92ee"
_IXZ.Name = _rZ_("!f\127\005ft}\vLo\127")
_IXZ.Description = ""
_IXZ.AltText = ""
_IXZ.Resources = {
  {
    Type = "png",
    Filename = "ManualIcon.png",
    Directives = {}
  }
}
_oR3qR = Wherigo.ZMedia(var_cartridge)
_oR3qR.Id = "807b1428-6b6b-40cd-a0d5-a86b4068796a"
_oR3qR.Name = _rZ_("!f>")
_oR3qR.Description = ""
_oR3qR.AltText = ""
_oR3qR.Resources = {
  {
    Type = "jpg",
    Filename = "Map.jpg",
    Directives = {}
  }
}
_nGP = Wherigo.ZMedia(var_cartridge)
_nGP.Id = "cc9cfbce-a432-4ac9-8df3-cb74d763c251"
_nGP.Name = _rZ_("!f>}\vLo\127")
_nGP.Description = ""
_nGP.AltText = ""
_nGP.Resources = {
  {
    Type = "jpg",
    Filename = "MapIcon.jpg",
    Directives = {}
  }
}
_4A7Z = Wherigo.ZMedia(var_cartridge)
_4A7Z.Id = "6a2d669e-b833-4efa-b55e-cfa0c4bc227e"
_4A7Z.Name = _rZ_("JO<\015")
_4A7Z.Description = ""
_4A7Z.AltText = ""
_4A7Z.Resources = {
  {
    Type = "jpg",
    Filename = "User.jpg",
    Directives = {}
  }
}
_bx1 = Wherigo.ZMedia(var_cartridge)
_bx1.Id = "2555e160-c2d9-4d9a-9e8b-0d8248392c83"
_bx1.Name = _rZ_("JO<\015}\vLo\127")
_bx1.Description = ""
_bx1.AltText = ""
_bx1.Resources = {
  {
    Type = "jpg",
    Filename = "UserIcon.jpg",
    Directives = {}
  }
}
_W6PC = Wherigo.ZMedia(var_cartridge)
_W6PC.Id = "ae61a3b1-b0ad-4f9a-9b30-c4150e39755b"
_W6PC.Name = _rZ_("h<\015Oo\127O")
_W6PC.Description = ""
_W6PC.AltText = ""
_W6PC.Resources = {
  {
    Type = "jpg",
    Filename = "Persons.jpg",
    Directives = {}
  }
}
_5X2hh = Wherigo.ZMedia(var_cartridge)
_5X2hh.Id = "369f4463-6977-4646-92da-3aeb0b491dac"
_5X2hh.Name = _rZ_("h<\015Oo\127O}\vLo\127")
_5X2hh.Description = ""
_5X2hh.AltText = ""
_5X2hh.Resources = {
  {
    Type = "jpg",
    Filename = "PersonsIcon.jpg",
    Directives = {}
  }
}
_wTGG = Wherigo.ZMedia(var_cartridge)
_wTGG.Id = "9eb4a1ab-dae6-495e-89ec-3dad5ecf2a1e"
_wTGG.Name = _rZ_("e\005LL<OO\018Q\026t")
_wTGG.Description = ""
_wTGG.AltText = ""
_wTGG.Resources = {
  {
    Type = "fdl",
    Filename = "success.fdl",
    Directives = {}
  }
}
_YL3 = Wherigo.ZMedia(var_cartridge)
_YL3.Id = "a33a1f41-a492-438e-bb8c-576c1cd49944"
_YL3.Name = _rZ_("e\005LL<OO\018^f\016")
_YL3.Description = ""
_YL3.AltText = ""
_YL3.Resources = {
  {
    Type = "wav",
    Filename = "success.wav",
    Directives = {}
  }
}
_OFT = Wherigo.ZMedia(var_cartridge)
_OFT.Id = "7c46656c-d595-4450-817c-a04de99970f1"
_OFT.Name = _rZ_("7<<>\018Q\026t")
_OFT.Description = ""
_OFT.AltText = ""
_OFT.Resources = {
  {
    Type = "fdl",
    Filename = "beep.fdl",
    Directives = {}
  }
}
_gdT = Wherigo.ZMedia(var_cartridge)
_gdT.Id = "1b7b81b1-e7ae-4dfc-8924-9da850d6f1a3"
_gdT.Name = _rZ_("7<<>\018^f\016")
_gdT.Description = ""
_gdT.AltText = ""
_gdT.Resources = {
  {
    Type = "wav",
    Filename = "beep.wav",
    Directives = {}
  }
}
_fhGX = Wherigo.ZMedia(var_cartridge)
_fhGX.Id = "e974c404-80d6-41d8-ae33-84cffde3cb26"
_fhGX.Name = _rZ_("\017fz1f\005O")
_fhGX.Description = ""
_fhGX.AltText = ""
_fhGX.Resources = {
  {
    Type = "jpg",
    Filename = "Sight11.jpg",
    Directives = {}
  }
}
_hc9Ko = Wherigo.ZMedia(var_cartridge)
_hc9Ko.Id = "21e2781b-071e-4af5-84c2-f369f25dd85a"
_hc9Ko.Name = _rZ_("\017fz1f\005O}\vLo\127")
_hc9Ko.Description = ""
_hc9Ko.AltText = ""
_hc9Ko.Resources = {
  {
    Type = "jpg",
    Filename = "Sight11Icon.jpg",
    Directives = {}
  }
}
_x6wgz = Wherigo.ZMedia(var_cartridge)
_x6wgz.Id = "797b9bce-3616-4396-ad81-4555c6dc7bc5"
_x6wgz.Name = _rZ_("eL1\127oo\015")
_x6wgz.Description = ""
_x6wgz.AltText = ""
_x6wgz.Resources = {
  {
    Type = "jpg",
    Filename = "Sight12.jpg",
    Directives = {}
  }
}
_ej5 = Wherigo.ZMedia(var_cartridge)
_ej5.Id = "dbb6c040-b720-4a95-9065-a0d6750fb7f8"
_ej5.Name = _rZ_("eL1\127oo\015}\vLo\127")
_ej5.Description = ""
_ej5.AltText = ""
_ej5.Resources = {
  {
    Type = "jpg",
    Filename = "Sight12Icon.jpg",
    Directives = {}
  }
}
_WwAF = Wherigo.ZMedia(var_cartridge)
_WwAF.Id = "81822418-fef2-4efc-8c6d-3ccd6f327112"
_WwAF.Name = _rZ_("q<g<\015,<1f\005O")
_WwAF.Description = ""
_WwAF.AltText = ""
_WwAF.Resources = {
  {
    Type = "jpg",
    Filename = "Sight13.jpg",
    Directives = {}
  }
}
_brmy = Wherigo.ZMedia(var_cartridge)
_brmy.Id = "0931b513-cac1-4369-b6ac-f836276444be"
_brmy.Name = _rZ_("q<g<\015,<1f\005O}\vLo\127")
_brmy.Description = ""
_brmy.AltText = ""
_brmy.Resources = {
  {
    Type = "jpg",
    Filename = "Sight13Icon.jpg",
    Directives = {}
  }
}
_ZlBV = Wherigo.ZMedia(var_cartridge)
_ZlBV.Id = "9cd02390-1916-4f3a-9112-f63cb4fe4412"
_ZlBV.Name = _rZ_("Nt<\030")
_ZlBV.Description = ""
_ZlBV.AltText = ""
_ZlBV.Resources = {
  {
    Type = "jpg",
    Filename = "Sight14.jpg",
    Directives = {}
  }
}
_LTPMD = Wherigo.ZMedia(var_cartridge)
_LTPMD.Id = "956fde04-ba49-4b42-91ff-bbb26d88f8a6"
_LTPMD.Name = _rZ_("Nt<\030}\vLo\127")
_LTPMD.Description = ""
_LTPMD.AltText = ""
_LTPMD.Resources = {
  {
    Type = "jpg",
    Filename = "Sight14Icon.jpg",
    Directives = {}
  }
}
_EKMF = Wherigo.ZMedia(var_cartridge)
_EKMF.Id = "a531cc8c-c5bf-4e56-ae58-dc9e84441da9"
_EKMF.Name = _rZ_("q<\015mL1z")
_EKMF.Description = ""
_EKMF.AltText = ""
_EKMF.Resources = {
  {
    Type = "jpg",
    Filename = "Sight15.jpg",
    Directives = {}
  }
}
_ryuh = Wherigo.ZMedia(var_cartridge)
_ryuh.Id = "f40e3115-7f47-4dc6-8395-2f8746c20d43"
_ryuh.Name = _rZ_("q<\015mL1z}\vLo\127")
_ryuh.Description = ""
_ryuh.AltText = ""
_ryuh.Resources = {
  {
    Type = "jpg",
    Filename = "Sight15Icon.jpg",
    Directives = {}
  }
}
_5Z8 = Wherigo.ZMedia(var_cartridge)
_5Z8.Id = "fbdca676-0413-448a-b100-a90a479d8854"
_5Z8.Name = _rZ_("qtoL\014<")
_5Z8.Description = ""
_5Z8.AltText = ""
_5Z8.Resources = {
  {
    Type = "jpg",
    Filename = "Sight16.jpg",
    Directives = {}
  }
}
_Wgr = Wherigo.ZMedia(var_cartridge)
_Wgr.Id = "ed57e0a5-01c7-49d4-9d9a-0d1d20d50388"
_Wgr.Name = _rZ_("qtoL\014<}\vLo\127")
_Wgr.Description = ""
_Wgr.AltText = ""
_Wgr.Resources = {
  {
    Type = "jpg",
    Filename = "Sight16Icon.jpg",
    Directives = {}
  }
}
_gWW = Wherigo.ZMedia(var_cartridge)
_gWW.Id = "b0deec92-ba12-43f9-b27a-84f2742372af"
_gWW.Name = _rZ_("\006\005\127Oz1ftt<")
_gWW.Description = ""
_gWW.AltText = ""
_gWW.Resources = {
  {
    Type = "jpg",
    Filename = "Sight17.jpg",
    Directives = {}
  }
}
_4km = Wherigo.ZMedia(var_cartridge)
_4km.Id = "d1a17d6b-03ae-4903-89c2-cf3dd1c46c83"
_4km.Name = _rZ_("\006\005\127Oz1ftt<}\vLo\127")
_4km.Description = ""
_4km.AltText = ""
_4km.Resources = {
  {
    Type = "jpg",
    Filename = "Sight17Icon.jpg",
    Directives = {}
  }
}
_MhZB = Wherigo.ZMedia(var_cartridge)
_MhZB.Id = "9af42c9d-64e0-4988-82e7-61caa865db0c"
_MhZB.Name = _rZ_("q<OL1mL1z<\1271f\005O")
_MhZB.Description = ""
_MhZB.AltText = ""
_MhZB.Resources = {
  {
    Type = "jpg",
    Filename = "Sight18.jpg",
    Directives = {}
  }
}
_IA2s = Wherigo.ZMedia(var_cartridge)
_IA2s.Id = "db5f37be-94c7-4d1f-923b-524f7547ce7c"
_IA2s.Name = _rZ_("q<OL1mL1z<\1271f\005O}\vLo\127")
_IA2s.Description = ""
_IA2s.AltText = ""
_IA2s.Resources = {
  {
    Type = "jpg",
    Filename = "Sight18Icon.jpg",
    Directives = {}
  }
}
_Z_pU4 = Wherigo.ZMedia(var_cartridge)
_Z_pU4.Id = "56ae788b-013c-48f8-8f38-a895e8825950"
_Z_pU4.Name = _rZ_("[o\015moz")
_Z_pU4.Description = ""
_Z_pU4.AltText = ""
_Z_pU4.Resources = {
  {
    Type = "jpg",
    Filename = "Sight19.jpg",
    Directives = {}
  }
}
_ru7xE = Wherigo.ZMedia(var_cartridge)
_ru7xE.Id = "aa3b3e63-f406-42a5-946c-5e2a0f709ad8"
_ru7xE.Name = _rZ_("[o\015moz}\vLo\127")
_ru7xE.Description = ""
_ru7xE.AltText = ""
_ru7xE.Resources = {
  {
    Type = "jpg",
    Filename = "Sight19Icon.jpg",
    Directives = {}
  }
}
_nEBH = Wherigo.ZMedia(var_cartridge)
_nEBH.Id = "49881fce-4cd4-41f9-b826-a88895550dc8"
_nEBH.Name = _rZ_("\aoE")
_nEBH.Description = ""
_nEBH.AltText = ""
_nEBH.Resources = {
  {
    Type = "jpg",
    Filename = "Sight20.jpg",
    Directives = {}
  }
}
_SXsR = Wherigo.ZMedia(var_cartridge)
_SXsR.Id = "18d6b5ef-403a-44ac-92a0-83a9ec6c8e29"
_SXsR.Name = _rZ_("\aoE}\vLo\127")
_SXsR.Description = ""
_SXsR.AltText = ""
_SXsR.Resources = {
  {
    Type = "jpg",
    Filename = "Sight20Icon.jpg",
    Directives = {}
  }
}
_t3Qq = Wherigo.ZMedia(var_cartridge)
_t3Qq.Id = "8bbc9434-3644-4ecd-85b1-a5c064df207f"
_t3Qq.Name = _rZ_("ez<>1f\127m")
_t3Qq.Description = ""
_t3Qq.AltText = ""
_t3Qq.Resources = {
  {
    Type = "jpg",
    Filename = "Sight21.jpg",
    Directives = {}
  }
}
_QLwy = Wherigo.ZMedia(var_cartridge)
_QLwy.Id = "85026b68-51a8-48c9-ba17-57bd88fcd04e"
_QLwy.Name = _rZ_("ez<>1f\127m}\vLo\127")
_QLwy.Description = ""
_QLwy.AltText = ""
_QLwy.Resources = {
  {
    Type = "jpg",
    Filename = "Sight21Icon.jpg",
    Directives = {}
  }
}
_c_s = Wherigo.ZMedia(var_cartridge)
_c_s.Id = "304ffc3e-fd34-43ac-82a0-6af0ed15b93e"
_c_s.Name = _rZ_("\006<\t>f\026")
_c_s.Description = ""
_c_s.AltText = ""
_c_s.Resources = {
  {
    Type = "jpg",
    Filename = "Keypad.jpg",
    Directives = {}
  }
}
_3x4 = Wherigo.ZMedia(var_cartridge)
_3x4.Id = "57cd8d67-d070-45e7-8b21-97aa29cd81b5"
_3x4.Name = _rZ_("\006<\t>f\026}\vLo\127")
_3x4.Description = ""
_3x4.AltText = ""
_3x4.Resources = {
  {
    Type = "jpg",
    Filename = "KeypadIcon.jpg",
    Directives = {}
  }
}
_6Ip1_ = Wherigo.ZMedia(var_cartridge)
_6Ip1_.Id = "7569d6cd-410b-47c2-83df-9e19cbc02a2b"
_6Ip1_.Name = _rZ_(".oz<O")
_6Ip1_.Description = ""
_6Ip1_.AltText = ""
_6Ip1_.Resources = {
  {
    Type = "jpg",
    Filename = "Notes.jpg",
    Directives = {}
  }
}
_6u_ = Wherigo.ZMedia(var_cartridge)
_6u_.Id = "ef8b99a7-90e9-471b-aee2-0632ee46ae2d"
_6u_.Name = _rZ_(".oz<O}\vLo\127")
_6u_.Description = ""
_6u_.AltText = ""
_6u_.Resources = {
  {
    Type = "jpg",
    Filename = "NotesIcon.jpg",
    Directives = {}
  }
}
var_cartridge.Id = "06ac2d74-2897-457a-b989-9d5a68264ed0"
var_cartridge.Name = "I love Bremen"
var_cartridge.Description = ""
var_cartridge.Visible = true
var_cartridge.Activity = "TourGuide"
var_cartridge.StartingLocationDescription = "<BR>\n<BR>\nStarte auf dem sch\195\182nen Bremer Marktplatz. Einige Sehensw\195\188rdigkeiten sind nur ein paar Schritte entfernt.<BR>\n"
var_cartridge.StartingLocation = ZonePoint(53.075783, 8.807183, 0)
var_cartridge.Version = "1.3"
var_cartridge.Company = ""
var_cartridge.Author = "Steinpilz42"
var_cartridge.BuilderVersion = "URWIGO 1.22.5798.37755"
var_cartridge.CreateDate = "01/11/2018 10:38:18"
var_cartridge.PublishDate = "1/1/0001 12:00:00 AM"
var_cartridge.UpdateDate = "08/19/2019 08:58:56"
var_cartridge.LastPlayedDate = "1/1/0001 12:00:00 AM"
var_cartridge.TargetDevice = "PocketPC"
var_cartridge.TargetDeviceVersion = "0"
var_cartridge.StateId = "1"
var_cartridge.CountryId = "2"
var_cartridge.Complete = false
var_cartridge.UseLogging = true
var_cartridge.Media = _wkYSx
var_cartridge.Icon = _dh_
zone_sight4 = Wherigo.Zone(var_cartridge)
zone_sight4.Id = "30db69b2-fa3a-445a-a7af-9707fb2a2deb"
zone_sight4.Name = _rZ_("ezf\026zE\005Om\014f\127z<\127")
zone_sight4.Description = ""
zone_sight4.Visible = false
zone_sight4.Media = _EeQbp
zone_sight4.Icon = _uL1rZ
zone_sight4.Commands = {}
zone_sight4.DistanceRange = Distance(-1, "feet")
zone_sight4.ShowObjects = "OnEnter"
zone_sight4.ProximityRange = Distance(60, "meters")
zone_sight4.AllowSetPositionTo = false
zone_sight4.Active = true
zone_sight4.Points = {
  ZonePoint(53.07638543878, 8.80769433782018, 0),
  ZonePoint(53.0763813303145, 8.80735684746028, 0),
  ZonePoint(53.0761984499927, 8.80722261817336, 0),
  ZonePoint(53.0761391034275, 8.80745729012363, 0),
  ZonePoint(53.0762214979196, 8.80774894841439, 0)
}
zone_sight4.OriginalPoint = ZonePoint(53.0762651640869, 8.80749600839837, 0)
zone_sight4.DistanceRangeUOM = "Feet"
zone_sight4.ProximityRangeUOM = "Meters"
zone_sight4.OutOfRangeName = ""
zone_sight4.InRangeName = ""
zone_sight5 = Wherigo.Zone(var_cartridge)
zone_sight5.Id = "392e453c-bcf7-4caf-9c14-ad956303401e"
zone_sight5.Name = _rZ_("\017otf\127\026")
zone_sight5.Description = ""
zone_sight5.Visible = false
zone_sight5.Media = _uKH
zone_sight5.Icon = _MuXP
zone_sight5.Commands = {}
zone_sight5.DistanceRange = Distance(-1, "feet")
zone_sight5.ShowObjects = "OnEnter"
zone_sight5.ProximityRange = Distance(60, "meters")
zone_sight5.AllowSetPositionTo = false
zone_sight5.Active = true
zone_sight5.Points = {
  ZonePoint(53.0759964493929, 8.80735281563737, 0),
  ZonePoint(53.0759614416508, 8.80714673743998, 0),
  ZonePoint(53.0758359081935, 8.8071306191942, 0),
  ZonePoint(53.075768970439, 8.807322453151, 0),
  ZonePoint(53.0758211169807, 8.807552424654, 0),
  ZonePoint(53.0759322545373, 8.80746121751093, 0)
}
zone_sight5.OriginalPoint = ZonePoint(53.0758860235324, 8.80732771126458, 0)
zone_sight5.DistanceRangeUOM = "Feet"
zone_sight5.ProximityRangeUOM = "Meters"
zone_sight5.OutOfRangeName = ""
zone_sight5.InRangeName = ""
zone_sight6 = Wherigo.Zone(var_cartridge)
zone_sight6.Id = "65698595-7c85-41e8-a471-699dad06f3be"
zone_sight6.Name = _rZ_("eL1g<m\127<\026<\127\014Eft")
zone_sight6.Description = ""
zone_sight6.Visible = false
zone_sight6.Media = _9LtD
zone_sight6.Icon = _XnfG
zone_sight6.Commands = {}
zone_sight6.DistanceRange = Distance(-1, "feet")
zone_sight6.ShowObjects = "OnEnter"
zone_sight6.ProximityRange = Distance(60, "meters")
zone_sight6.AllowSetPositionTo = false
zone_sight6.Active = true
zone_sight6.Points = {
  ZonePoint(53.0786297586027, 8.80833550450101, 0),
  ZonePoint(53.0783950031748, 8.80820501375484, 0),
  ZonePoint(53.0781910886933, 8.80867879390531, 0),
  ZonePoint(53.0784170856475, 8.80902189455465, 0),
  ZonePoint(53.0786369117887, 8.80870762620702, 0)
}
zone_sight6.OriginalPoint = ZonePoint(53.0784539695814, 8.80858976658457, 0)
zone_sight6.DistanceRangeUOM = "Feet"
zone_sight6.ProximityRangeUOM = "Meters"
zone_sight6.OutOfRangeName = ""
zone_sight6.InRangeName = ""
zone_automatenStation = Wherigo.Zone(var_cartridge)
zone_automatenStation.Id = "d671dc45-7984-4fc6-91b8-2dc21e1710a4"
zone_automatenStation.Name = _rZ_("N\005zoEfz<\127}ezfzmo\127")
zone_automatenStation.Description = _rZ_("=m<\015\018lm,z\018<O\018N\005zoEfz<\127u\018\026m<\018Ef\127\018Emz\018!\005<\127?<\127\018o\026<\015\0188o\014<\127O\018\001\005<zz<\015\127\018\014f\127\127U")
zone_automatenStation.Visible = true
zone_automatenStation.Media = _Hrm
zone_automatenStation.Icon = _dq8A
zone_automatenStation.Commands = {}
zone_automatenStation.DistanceRange = Distance(-1, "feet")
zone_automatenStation.ShowObjects = "OnEnter"
zone_automatenStation.ProximityRange = Distance(60, "meters")
zone_automatenStation.AllowSetPositionTo = false
zone_automatenStation.Active = true
zone_automatenStation.Points = {
  ZonePoint(53.0753390077037, 8.80697245687568, 0),
  ZonePoint(53.0754586399635, 8.80718092834117, 0),
  ZonePoint(53.075315132724, 8.80746690920984, 0),
  ZonePoint(53.0751287879648, 8.80711195917455, 0)
}
zone_automatenStation.OriginalPoint = ZonePoint(53.075310392089, 8.80718306340031, 0)
zone_automatenStation.DistanceRangeUOM = "Feet"
zone_automatenStation.ProximityRangeUOM = "Meters"
zone_automatenStation.OutOfRangeName = ""
zone_automatenStation.InRangeName = ""
zone_sight7 = Wherigo.Zone(var_cartridge)
zone_sight7.Id = "3b74503b-79c6-4c09-96a5-dcf625ee2fbd"
zone_sight7.Name = _rZ_("e>\005L\014Oz<m\127")
zone_sight7.Description = ""
zone_sight7.Visible = false
zone_sight7.Media = _zzDw
zone_sight7.Icon = _jGf
zone_sight7.Commands = {}
zone_sight7.DistanceRange = Distance(-1, "feet")
zone_sight7.ShowObjects = "OnEnter"
zone_sight7.ProximityRange = Distance(60, "meters")
zone_sight7.AllowSetPositionTo = false
zone_sight7.Active = true
zone_sight7.Points = {
  ZonePoint(53.0759511207827, 8.80891053305918, 0),
  ZonePoint(53.0758653798237, 8.80883146698086, 0),
  ZonePoint(53.0757492657595, 8.80885028652414, 0),
  ZonePoint(53.0757321151043, 8.80899043647798, 0),
  ZonePoint(53.0757944179374, 8.8092593927667, 0),
  ZonePoint(53.075978355698, 8.80919182973681, 0)
}
zone_sight7.OriginalPoint = ZonePoint(53.0758451091843, 8.80900565759094, 0)
zone_sight7.DistanceRangeUOM = "Feet"
zone_sight7.ProximityRangeUOM = "Meters"
zone_sight7.OutOfRangeName = ""
zone_sight7.InRangeName = ""
zone_sight1 = Wherigo.Zone(var_cartridge)
zone_sight1.Id = "891283c1-86ba-43fe-bd6a-a15f61be844e"
zone_sight1.Name = _rZ_("7\015<E<\015\018[oL1")
zone_sight1.Description = ""
zone_sight1.Visible = false
zone_sight1.Media = _Kef
zone_sight1.Icon = _fTvg
zone_sight1.Commands = {}
zone_sight1.DistanceRange = Distance(-1, "feet")
zone_sight1.ShowObjects = "OnEnter"
zone_sight1.ProximityRange = Distance(60, "meters")
zone_sight1.AllowSetPositionTo = false
zone_sight1.Active = true
zone_sight1.Points = {
  ZonePoint(53.0755949934566, 8.80722460727472, 0),
  ZonePoint(53.0754957898818, 8.80744798998761, 0),
  ZonePoint(53.0755834838249, 8.80756792483055, 0),
  ZonePoint(53.0755710399636, 8.80777982436774, 0),
  ZonePoint(53.0757193239872, 8.8077125005567, 0),
  ZonePoint(53.0757737940938, 8.80754198811653, 0),
  ZonePoint(53.0757329296266, 8.80739763128756, 0)
}
zone_sight1.OriginalPoint = ZonePoint(53.0756387649764, 8.8075246380602, 0)
zone_sight1.DistanceRangeUOM = "Feet"
zone_sight1.ProximityRangeUOM = "Meters"
zone_sight1.OutOfRangeName = ""
zone_sight1.InRangeName = ""
zone_sight8 = Wherigo.Zone(var_cartridge)
zone_sight8.Id = "e18d246c-f63c-4b61-857a-55ef5c4bc721"
zone_sight8.Name = _rZ_("ezf\026zgffl<")
zone_sight8.Description = ""
zone_sight8.Visible = false
zone_sight8.Media = _QxMob
zone_sight8.Icon = _iw5
zone_sight8.Commands = {}
zone_sight8.DistanceRange = Distance(-1, "feet")
zone_sight8.ShowObjects = "OnEnter"
zone_sight8.ProximityRange = Distance(60, "meters")
zone_sight8.AllowSetPositionTo = false
zone_sight8.Active = true
zone_sight8.Points = {
  ZonePoint(53.0763661686853, 8.80509547066183, 0),
  ZonePoint(53.0766915098088, 8.80546021368285, 0),
  ZonePoint(53.076477059311, 8.80592957393404, 0),
  ZonePoint(53.0762099487816, 8.80544834669766, 0)
}
zone_sight8.OriginalPoint = ZonePoint(53.0764361716467, 8.80548340124409, 0)
zone_sight8.DistanceRangeUOM = "Feet"
zone_sight8.ProximityRangeUOM = "Meters"
zone_sight8.OutOfRangeName = ""
zone_sight8.InRangeName = ""
zone_sight2 = Wherigo.Zone(var_cartridge)
zone_sight2.Id = "33b97562-91d3-4de6-bab3-c2db8ce47557"
zone_sight2.Name = _rZ_("qtoL\014<\127O>m<t\0187o<zzL1<\015Oz\015fOO<")
zone_sight2.Description = ""
zone_sight2.Visible = false
zone_sight2.Media = _zCDYg
zone_sight2.Icon = _GQP
zone_sight2.Commands = {}
zone_sight2.DistanceRange = Distance(-1, "feet")
zone_sight2.ShowObjects = "OnEnter"
zone_sight2.ProximityRange = Distance(60, "meters")
zone_sight2.AllowSetPositionTo = false
zone_sight2.Active = true
zone_sight2.Points = {
  ZonePoint(53.0751141241793, 8.80581367853951, 0),
  ZonePoint(53.075125921411, 8.80561338178737, 0),
  ZonePoint(53.0750527785223, 8.80549556016847, 0),
  ZonePoint(53.0749159302034, 8.80550341494302, 0),
  ZonePoint(53.0748286301865, 8.8056408734984, 0),
  ZonePoint(53.0749135707458, 8.80598648358055, 0),
  ZonePoint(53.0750669352202, 8.8059472097076, 0)
}
zone_sight2.OriginalPoint = ZonePoint(53.0750025557812, 8.80571437174642, 0)
zone_sight2.DistanceRangeUOM = "Feet"
zone_sight2.ProximityRangeUOM = "Meters"
zone_sight2.OutOfRangeName = ""
zone_sight2.InRangeName = ""
zone_sight3 = Wherigo.Zone(var_cartridge)
zone_sight3.Id = "e2edcbfa-af3d-4214-9b1d-b3477a9fbb7b"
zone_sight3.Name = _rZ_("!ftt\018o\001\018QfE<")
zone_sight3.Description = ""
zone_sight3.Visible = false
zone_sight3.Media = _T0M
zone_sight3.Icon = _LP9i
zone_sight3.Commands = {}
zone_sight3.DistanceRange = Distance(-1, "feet")
zone_sight3.ShowObjects = "OnEnter"
zone_sight3.ProximityRange = Distance(60, "meters")
zone_sight3.AllowSetPositionTo = false
zone_sight3.Active = true
zone_sight3.Points = {
  ZonePoint(53.0773031860282, 8.80713693338781, 0),
  ZonePoint(53.0771260553342, 8.80713170807639, 0),
  ZonePoint(53.0769317342049, 8.80689603616624, 0),
  ZonePoint(53.0781169070605, 8.80451998352308, 0),
  ZonePoint(53.0783595674901, 8.80487994674383, 0)
}
zone_sight3.OriginalPoint = ZonePoint(53.0775674900236, 8.80611292157947, 0)
zone_sight3.DistanceRangeUOM = "Feet"
zone_sight3.ProximityRangeUOM = "Meters"
zone_sight3.OutOfRangeName = ""
zone_sight3.InRangeName = ""
zone_sight9 = Wherigo.Zone(var_cartridge)
zone_sight9.Id = "34c9ad25-e7e6-4090-8125-2b502b69014a"
zone_sight9.Name = _rZ_("eL1\005<zzm\127l")
zone_sight9.Description = ""
zone_sight9.Visible = false
zone_sight9.Media = _beWzP
zone_sight9.Icon = _6Fvz
zone_sight9.Commands = {}
zone_sight9.DistanceRange = Distance(-1, "feet")
zone_sight9.ShowObjects = "OnEnter"
zone_sight9.ProximityRange = Distance(60, "meters")
zone_sight9.AllowSetPositionTo = false
zone_sight9.Active = true
zone_sight9.Points = {
  ZonePoint(53.07588711036, 8.80632282160358, 0),
  ZonePoint(53.0755675882444, 8.80592331597529, 0),
  ZonePoint(53.0752688460148, 8.80629850375469, 0),
  ZonePoint(53.0755837024641, 8.80701169636918, 0),
  ZonePoint(53.0759007151511, 8.80666909544503, 0)
}
zone_sight9.OriginalPoint = ZonePoint(53.0756415924469, 8.80644508662956, 0)
zone_sight9.DistanceRangeUOM = "Feet"
zone_sight9.ProximityRangeUOM = "Meters"
zone_sight9.OutOfRangeName = ""
zone_sight9.InRangeName = ""
zone_sight10 = Wherigo.Zone(var_cartridge)
zone_sight10.Id = "c354d826-cee1-437e-8000-2c9586b7309e"
zone_sight10.Name = _rZ_("!\005<1t<\018fE\018^ftt")
zone_sight10.Description = ""
zone_sight10.Visible = false
zone_sight10.Media = _FDi
zone_sight10.Icon = _3To7I
zone_sight10.Commands = {}
zone_sight10.DistanceRange = Distance(-1, "feet")
zone_sight10.ShowObjects = "OnEnter"
zone_sight10.ProximityRange = Distance(60, "meters")
zone_sight10.AllowSetPositionTo = false
zone_sight10.Active = true
zone_sight10.Points = {
  ZonePoint(53.0804367068439, 8.80685050878565, 0),
  ZonePoint(53.0802904389859, 8.8065441725765, 0),
  ZonePoint(53.0799603077581, 8.80612002463333, 0),
  ZonePoint(53.0798028958237, 8.80638658297201, 0),
  ZonePoint(53.0797039116486, 8.80676886705844, 0),
  ZonePoint(53.0796099963853, 8.80722628044353, 0),
  ZonePoint(53.08005823617, 8.80771260282409, 0),
  ZonePoint(53.0803423405408, 8.80727073922646, 0)
}
zone_sight10.OriginalPoint = ZonePoint(53.0800256042695, 8.806859972315, 0)
zone_sight10.DistanceRangeUOM = "Feet"
zone_sight10.ProximityRangeUOM = "Meters"
zone_sight10.OutOfRangeName = ""
zone_sight10.InRangeName = ""
zone_sight11 = Wherigo.Zone(var_cartridge)
zone_sight11.Id = "235d88d1-f331-4247-aace-dcdad39453df"
zone_sight11.Name = _rZ_("\017fz1f\005O")
zone_sight11.Description = ""
zone_sight11.Visible = false
zone_sight11.Media = _fhGX
zone_sight11.Icon = _hc9Ko
zone_sight11.Commands = {}
zone_sight11.DistanceRange = Distance(-1, "feet")
zone_sight11.ShowObjects = "OnEnter"
zone_sight11.ProximityRange = Distance(60, "meters")
zone_sight11.AllowSetPositionTo = false
zone_sight11.Active = true
zone_sight11.Points = {
  ZonePoint(53.0761406152262, 8.80751917820917, 0),
  ZonePoint(53.0761322247793, 8.80728299937756, 0),
  ZonePoint(53.0760271247578, 8.80734169091554, 0),
  ZonePoint(53.0758508282914, 8.80763514860529, 0),
  ZonePoint(53.0757825132166, 8.807791048003, 0),
  ZonePoint(53.0757756405774, 8.80828383611392, 0),
  ZonePoint(53.0760960349411, 8.80884490576446, 0),
  ZonePoint(53.0764013898241, 8.80825003861724, 0)
}
zone_sight11.OriginalPoint = ZonePoint(53.0760257964517, 8.80786860570077, 0)
zone_sight11.DistanceRangeUOM = "Feet"
zone_sight11.ProximityRangeUOM = "Meters"
zone_sight11.OutOfRangeName = ""
zone_sight11.InRangeName = ""
zone_sight12 = Wherigo.Zone(var_cartridge)
zone_sight12.Id = "42dc4de1-a784-4a1d-9039-0d850ed18485"
zone_sight12.Name = _rZ_("eL1\127oo\015")
zone_sight12.Description = ""
zone_sight12.Visible = false
zone_sight12.Media = _x6wgz
zone_sight12.Icon = _ej5
zone_sight12.Commands = {}
zone_sight12.DistanceRange = Distance(-1, "feet")
zone_sight12.ShowObjects = "OnEnter"
zone_sight12.ProximityRange = Distance(60, "meters")
zone_sight12.AllowSetPositionTo = false
zone_sight12.Active = true
zone_sight12.Points = {
  ZonePoint(53.0732400203911, 8.80880759636217, 0),
  ZonePoint(53.073073458678, 8.80870799842144, 0),
  ZonePoint(53.0729382377322, 8.80903708573648, 0),
  ZonePoint(53.072748994262, 8.80978289207241, 0),
  ZonePoint(53.0726515995423, 8.81002697914644, 0),
  ZonePoint(53.0725810303428, 8.81020807530623, 0),
  ZonePoint(53.072521164234, 8.81030490724246, 0),
  ZonePoint(53.0724719834301, 8.81036917629682, 0),
  ZonePoint(53.0725877953192, 8.81075110657202, 0),
  ZonePoint(53.072763698607, 8.81039719841848, 0),
  ZonePoint(53.0730777938714, 8.80939356401805, 0),
  ZonePoint(53.073162551759, 8.80905362240907, 0)
}
zone_sight12.OriginalPoint = ZonePoint(53.0728181940141, 8.80973668350017, 0)
zone_sight12.DistanceRangeUOM = "Feet"
zone_sight12.ProximityRangeUOM = "Meters"
zone_sight12.OutOfRangeName = ""
zone_sight12.InRangeName = ""
zone_sight13 = Wherigo.Zone(var_cartridge)
zone_sight13.Id = "20a02f28-b6f4-41df-a700-e6b613294956"
zone_sight13.Name = _rZ_("q<g<\015,<1f\005O")
zone_sight13.Description = ""
zone_sight13.Visible = false
zone_sight13.Media = _WwAF
zone_sight13.Icon = _brmy
zone_sight13.Commands = {}
zone_sight13.DistanceRange = Distance(-1, "feet")
zone_sight13.ShowObjects = "OnEnter"
zone_sight13.ProximityRange = Distance(60, "meters")
zone_sight13.AllowSetPositionTo = false
zone_sight13.Active = true
zone_sight13.Points = {
  ZonePoint(53.079073493513, 8.80266735730637, 0),
  ZonePoint(53.0789369394735, 8.80335479415417, 0),
  ZonePoint(53.0784930118971, 8.80293646509398, 0),
  ZonePoint(53.0786064643603, 8.80240998368283, 0)
}
zone_sight13.OriginalPoint = ZonePoint(53.078777477311, 8.80284215005934, 0)
zone_sight13.DistanceRangeUOM = "Feet"
zone_sight13.ProximityRangeUOM = "Meters"
zone_sight13.OutOfRangeName = ""
zone_sight13.InRangeName = ""
zone_sight14 = Wherigo.Zone(var_cartridge)
zone_sight14.Id = "c917bd9f-96b1-4b82-b7a8-8accef56c224"
zone_sight14.Name = _rZ_("Nt<\030f\127\026<\015\018\016o\127\018=\005E,ot\026z")
zone_sight14.Description = ""
zone_sight14.Visible = false
zone_sight14.Media = _ZlBV
zone_sight14.Icon = _LTPMD
zone_sight14.Commands = {}
zone_sight14.DistanceRange = Distance(-1, "feet")
zone_sight14.ShowObjects = "OnEnter"
zone_sight14.ProximityRange = Distance(60, "meters")
zone_sight14.AllowSetPositionTo = false
zone_sight14.Active = true
zone_sight14.Points = {
  ZonePoint(53.0752825065868, 8.80358396646514, 0),
  ZonePoint(53.0750975400881, 8.80266764442949, 0),
  ZonePoint(53.0745998881825, 8.80293887575205, 0),
  ZonePoint(53.0745690599992, 8.80378189202484, 0),
  ZonePoint(53.0748597248508, 8.8040531233474, 0)
}
zone_sight14.OriginalPoint = ZonePoint(53.0748817439415, 8.80340510040378, 0)
zone_sight14.DistanceRangeUOM = "Feet"
zone_sight14.ProximityRangeUOM = "Meters"
zone_sight14.OutOfRangeName = ""
zone_sight14.InRangeName = ""
zone_sight15 = Wherigo.Zone(var_cartridge)
zone_sight15.Id = "f111a1b5-684c-4205-aa91-975474c53d85"
zone_sight15.Name = _rZ_("Ntz<O\018q<\015mL1zO1f\005O")
zone_sight15.Description = ""
zone_sight15.Visible = false
zone_sight15.Media = _EKMF
zone_sight15.Icon = _ryuh
zone_sight15.Commands = {}
zone_sight15.DistanceRange = Distance(-1, "feet")
zone_sight15.ShowObjects = "OnEnter"
zone_sight15.ProximityRange = Distance(60, "meters")
zone_sight15.AllowSetPositionTo = false
zone_sight15.Active = true
zone_sight15.Points = {
  ZonePoint(53.0746307163438, 8.81054068335989, 0),
  ZonePoint(53.0746879685847, 8.8101888156982, 0),
  ZonePoint(53.0744765753167, 8.80971232823963, 0),
  ZonePoint(53.0741903119454, 8.80979296457875, 0),
  ZonePoint(53.0740229570929, 8.81040140241047, 0),
  ZonePoint(53.0740141489248, 8.81040873298674, 0),
  ZonePoint(53.074225544463, 8.81071661719075, 0)
}
zone_sight15.OriginalPoint = ZonePoint(53.0743211746673, 8.8102516492092, 0)
zone_sight15.DistanceRangeUOM = "Feet"
zone_sight15.ProximityRangeUOM = "Meters"
zone_sight15.OutOfRangeName = ""
zone_sight15.InRangeName = ""
zone_sight16 = Wherigo.Zone(var_cartridge)
zone_sight16.Id = "0718d69d-c19f-4cf8-9e49-a660e536d656"
zone_sight16.Name = _rZ_("\am<\018qtoL\014<")
zone_sight16.Description = ""
zone_sight16.Visible = false
zone_sight16.Media = _5Z8
zone_sight16.Icon = _Wgr
zone_sight16.Commands = {}
zone_sight16.DistanceRange = Distance(-1, "feet")
zone_sight16.ShowObjects = "OnEnter"
zone_sight16.ProximityRange = Distance(60, "meters")
zone_sight16.AllowSetPositionTo = false
zone_sight16.Active = true
zone_sight16.Points = {
  ZonePoint(53.075256094595, 8.80860167368067, 0),
  ZonePoint(53.0750853699215, 8.80847057077817, 0),
  ZonePoint(53.0748532490734, 8.80871720930949, 0),
  ZonePoint(53.0747634444807, 8.80887433048768, 0),
  ZonePoint(53.0746119951628, 8.80971286715314, 0),
  ZonePoint(53.075227153272, 8.80981997482851, 0)
}
zone_sight16.OriginalPoint = ZonePoint(53.0749662177509, 8.80903277103961, 0)
zone_sight16.DistanceRangeUOM = "Feet"
zone_sight16.ProximityRangeUOM = "Meters"
zone_sight16.OutOfRangeName = ""
zone_sight16.InRangeName = ""
zone_sight17 = Wherigo.Zone(var_cartridge)
zone_sight17.Id = "19a065ed-de15-4ca8-9aea-b221f8b6e42c"
zone_sight17.Name = _rZ_("\006\005\127Oz1ftt<")
zone_sight17.Description = ""
zone_sight17.Visible = false
zone_sight17.Media = _gWW
zone_sight17.Icon = _4km
zone_sight17.Commands = {}
zone_sight17.DistanceRange = Distance(-1, "feet")
zone_sight17.ShowObjects = "OnEnter"
zone_sight17.ProximityRange = Distance(60, "meters")
zone_sight17.AllowSetPositionTo = false
zone_sight17.Active = true
zone_sight17.Points = {
  ZonePoint(53.0733657886514, 8.8133240098431, 0),
  ZonePoint(53.0729087095201, 8.81245396377035, 0),
  ZonePoint(53.0721115423784, 8.81314303794115, 0),
  ZonePoint(53.0724682875092, 8.81427194668912, 0),
  ZonePoint(53.0732346189081, 8.81411800458713, 0)
}
zone_sight17.OriginalPoint = ZonePoint(53.0728177893934, 8.81346219256617, 0)
zone_sight17.DistanceRangeUOM = "Feet"
zone_sight17.ProximityRangeUOM = "Meters"
zone_sight17.OutOfRangeName = ""
zone_sight17.InRangeName = ""
zone_sight18 = Wherigo.Zone(var_cartridge)
zone_sight18.Id = "110db68b-e6d4-4766-b92b-8da8810abf4f"
zone_sight18.Name = _rZ_("q<OL1mL1z<\1271f\005O")
zone_sight18.Description = ""
zone_sight18.Visible = false
zone_sight18.Media = _MhZB
zone_sight18.Icon = _IA2s
zone_sight18.Commands = {}
zone_sight18.DistanceRange = Distance(-1, "feet")
zone_sight18.ShowObjects = "OnEnter"
zone_sight18.ProximityRange = Distance(60, "meters")
zone_sight18.AllowSetPositionTo = false
zone_sight18.Active = true
zone_sight18.Points = {
  ZonePoint(53.0726444568541, 8.80970133237529, 0),
  ZonePoint(53.0726972799397, 8.8094492222625, 0),
  ZonePoint(53.0725314820119, 8.8092407802497, 0),
  ZonePoint(53.0724003965456, 8.80955493760478, 0),
  ZonePoint(53.0725302507256, 8.80991124577347, 0)
}
zone_sight18.OriginalPoint = ZonePoint(53.0725607732154, 8.80957150365315, 0)
zone_sight18.DistanceRangeUOM = "Feet"
zone_sight18.ProximityRangeUOM = "Meters"
zone_sight18.OutOfRangeName = ""
zone_sight18.InRangeName = ""
zone_sight19 = Wherigo.Zone(var_cartridge)
zone_sight19.Id = "04c003a3-e0f1-444c-b224-35cef3bd1f15"
zone_sight19.Name = _rZ_("[o\015moz}eo\001f")
zone_sight19.Description = ""
zone_sight19.Visible = false
zone_sight19.Media = _Z_pU4
zone_sight19.Icon = _ru7xE
zone_sight19.Commands = {}
zone_sight19.DistanceRange = Distance(-1, "feet")
zone_sight19.ShowObjects = "OnEnter"
zone_sight19.ProximityRange = Distance(60, "meters")
zone_sight19.AllowSetPositionTo = false
zone_sight19.Active = true
zone_sight19.Points = {
  ZonePoint(53.0806565153001, 8.79566814331818, 0),
  ZonePoint(53.0806983916421, 8.79527514469913, 0),
  ZonePoint(53.0802978048288, 8.79506649473822, 0),
  ZonePoint(53.0802807438586, 8.79547675761297, 0),
  ZonePoint(53.0803348543229, 8.7956995864914, 0),
  ZonePoint(53.0805569913059, 8.79579440729077, 0)
}
zone_sight19.OriginalPoint = ZonePoint(53.0804708835431, 8.79549675569178, 0)
zone_sight19.DistanceRangeUOM = "Feet"
zone_sight19.ProximityRangeUOM = "Meters"
zone_sight19.OutOfRangeName = ""
zone_sight19.InRangeName = ""
zone_sight20 = Wherigo.Zone(var_cartridge)
zone_sight20.Id = "e63cf8c7-205e-41c7-92d4-1fc57331c0cb"
zone_sight20.Name = _rZ_("ezU\018h<z\015m\018\aoE")
zone_sight20.Description = ""
zone_sight20.Visible = false
zone_sight20.Media = _nEBH
zone_sight20.Icon = _SXsR
zone_sight20.Commands = {}
zone_sight20.DistanceRange = Distance(-1, "feet")
zone_sight20.ShowObjects = "OnEnter"
zone_sight20.ProximityRange = Distance(60, "meters")
zone_sight20.AllowSetPositionTo = false
zone_sight20.Active = true
zone_sight20.Points = {
  ZonePoint(53.0756409232546, 8.80949187852271, 0),
  ZonePoint(53.0758092900677, 8.80850738654621, 0),
  ZonePoint(53.0756884113967, 8.80814448986874, 0),
  ZonePoint(53.0753408833273, 8.80810855950461, 0),
  ZonePoint(53.0753149805017, 8.80853253780109, 0),
  ZonePoint(53.0752696505195, 8.80934815706629, 0)
}
zone_sight20.OriginalPoint = ZonePoint(53.0755106898446, 8.80868883488494, 0)
zone_sight20.DistanceRangeUOM = "Feet"
zone_sight20.ProximityRangeUOM = "Meters"
zone_sight20.OutOfRangeName = ""
zone_sight20.InRangeName = ""
zone_sight21 = Wherigo.Zone(var_cartridge)
zone_sight21.Id = "c2bc47a5-794d-48ac-957b-6f3863b19971"
zone_sight21.Name = _rZ_("\006\005tz\005\015\014m\015L1<\018ezU\018ez<>1f\127m")
zone_sight21.Description = ""
zone_sight21.Visible = false
zone_sight21.Media = _t3Qq
zone_sight21.Icon = _QLwy
zone_sight21.Commands = {}
zone_sight21.DistanceRange = Distance(-1, "feet")
zone_sight21.ShowObjects = "OnEnter"
zone_sight21.ProximityRange = Distance(60, "meters")
zone_sight21.AllowSetPositionTo = false
zone_sight21.Active = true
zone_sight21.Points = {
  ZonePoint(53.0812945917838, 8.79398333002318, 0),
  ZonePoint(53.0806851467363, 8.79326743298813, 0),
  ZonePoint(53.0803405501573, 8.79452854961945, 0),
  ZonePoint(53.08110378515, 8.79487464553709, 0)
}
zone_sight21.OriginalPoint = ZonePoint(53.0808560184568, 8.79416348954196, 0)
zone_sight21.DistanceRangeUOM = "Feet"
zone_sight21.ProximityRangeUOM = "Meters"
zone_sight21.OutOfRangeName = ""
zone_sight21.InRangeName = ""
_cTe_f = Wherigo.ZCharacter(var_cartridge)
_cTe_f.Id = "7e79080b-46f5-4f81-8e07-2db3b8cbb0fa"
_cTe_f.Name = _rZ_("=m\127\127<\015\014")
_cTe_f.Description = ""
_cTe_f.Visible = true
_cTe_f.Media = _XvRtp
_cTe_f.Icon = _PAgli
_cTe_f.Commands = {
  _RydM = Wherigo.ZCommand({
    Text = _rZ_("N\127O>\015<L1<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_cTe_f.Commands._RydM.Custom = true
_cTe_f.Commands._RydM.Id = "8ed0ff49-e42b-4cfc-83bb-817fe09eed8c"
_cTe_f.Commands._RydM.WorksWithAll = true
_cTe_f.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_cTe_f.Gender = "Male"
_cTe_f.Type = "NPC"
_LTJ0 = Wherigo.ZCharacter(var_cartridge)
_LTJ0.Id = "69a7f492-61d4-4551-9001-5f57f4e0ac78"
_LTJ0.Name = _rZ_("iEf\018\006f<z1<")
_LTJ0.Description = ""
_LTJ0.Visible = true
_LTJ0.Media = _QsW0N
_LTJ0.Icon = _twx
_LTJ0.Commands = {
  _znmj = Wherigo.ZCommand({
    Text = _rZ_("N\127O>\015<L1<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_LTJ0.Commands._znmj.Custom = true
_LTJ0.Commands._znmj.Id = "495ab294-6a85-46b4-a8ee-d07effb1d60b"
_LTJ0.Commands._znmj.WorksWithAll = true
_LTJ0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_LTJ0.Gender = "Female"
_LTJ0.Type = "NPC"
_i14yj = Wherigo.ZCharacter(var_cartridge)
_i14yj.Id = "765c3df2-6ccc-4640-8507-062cb2ed6d88"
_i14yj.Name = _rZ_("\006t<m\127\018y\015\127f")
_i14yj.Description = ""
_i14yj.Visible = true
_i14yj.Media = _T1vz
_i14yj.Icon = _5t5
_i14yj.Commands = {
  _E3F = Wherigo.ZCommand({
    Text = _rZ_("N\127O>\015<L1<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_i14yj.Commands._E3F.Custom = true
_i14yj.Commands._E3F.Id = "1aca2e8d-8b0c-4261-a548-eff57330535a"
_i14yj.Commands._E3F.WorksWithAll = true
_i14yj.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_i14yj.Gender = "Female"
_i14yj.Type = "NPC"
_lQTt = Wherigo.ZCharacter(var_cartridge)
_lQTt.Id = "2c46d76d-883e-4bf1-9a57-7aa765e6ccf4"
_lQTt.Name = _rZ_(":\005tmf")
_lQTt.Description = ""
_lQTt.Visible = true
_lQTt.Media = _b8cP
_lQTt.Icon = _ttbZ
_lQTt.Commands = {
  _cc66L = Wherigo.ZCommand({
    Text = _rZ_("N\127O>\015<L1<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_lQTt.Commands._cc66L.Custom = true
_lQTt.Commands._cc66L.Id = "a000a211-2697-45b9-9cae-fd51201b9411"
_lQTt.Commands._cc66L.WorksWithAll = true
_lQTt.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_lQTt.Gender = "Female"
_lQTt.Type = "NPC"
item_token1 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight1})
item_token1.Id = "8106cd17-08a7-47a3-a1b6-19851d334330"
item_token1.Name = _rZ_("8o\014<\127\0187\015<E<\015\018[oL1")
item_token1.Description = ""
item_token1.Visible = true
item_token1.Media = _DY_
item_token1.Icon = _W7PjL
item_token1.Commands = {
  _tqHt = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
item_token1.Commands._tqHt.Custom = true
item_token1.Commands._tqHt.Id = "8d0e6339-299a-4e5b-8870-a0ac6ee71c4c"
item_token1.Commands._tqHt.WorksWithAll = true
item_token1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_token1.Locked = false
item_token1.Opened = false
item_wallet = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
item_wallet.Id = "b294b104-b2c1-466f-8f13-6b3ea4084ed8"
item_wallet.Name = _rZ_("q<t\026,o<\015O<")
item_wallet.Description = _rZ_("=m<\015\018,<gf1\015Oz\018\a\005\018!\005<\127?<\127\018\005\127\026\0188o\014<\127O\018f\005\001")
item_wallet.Visible = true
item_wallet.Media = _rJsT
item_wallet.Icon = _xd7_C
item_wallet.Commands = {
  event_countContent = Wherigo.ZCommand({
    Text = _rZ_("\v\1271ftz\018?f<1t<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
item_wallet.Commands.event_countContent.Custom = true
item_wallet.Commands.event_countContent.Id = "60828ebb-7f51-43e0-b65f-1d443a9cb92f"
item_wallet.Commands.event_countContent.WorksWithAll = true
item_wallet.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_wallet.Locked = false
item_wallet.Opened = false
item_machineCoords = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_automatenStation})
item_machineCoords.Id = "d371d192-a4a0-46df-98a5-5ccb817960c3"
item_machineCoords.Name = _rZ_("\006oo\015\026m\127fz<\127}N\005zoEfz")
item_machineCoords.Description = _rZ_("=m<\015\018\014f\127\127Oz\018\a\005\018\006oo\015\026m\127fz<\127\018<\0151ftz<\127U97\017`\am<\0188o\014<\127O\018,<1f<tzOz\018\a\005")
item_machineCoords.Visible = true
item_machineCoords.Media = _kwD2
item_machineCoords.Icon = _2O8GH
item_machineCoords.Commands = {
  _Q2NWR = Wherigo.ZCommand({
    Text = _rZ_("^1<\015mlo}\006oo\015\026m\127fz<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  }),
  _2n6 = Wherigo.ZCommand({
    Text = _rZ_("7o\127\005O}\006oo\015\026m\127fz<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_machineCoords.Commands._Q2NWR.Custom = true
item_machineCoords.Commands._Q2NWR.Id = "b0e4f48b-ef6f-4902-85f0-74917a4cc0d7"
item_machineCoords.Commands._Q2NWR.WorksWithAll = true
item_machineCoords.Commands._2n6.Custom = true
item_machineCoords.Commands._2n6.Id = "b41d42fd-29f4-4351-aa1d-310c32de1323"
item_machineCoords.Commands._2n6.WorksWithAll = true
item_machineCoords.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_machineCoords.Locked = false
item_machineCoords.Opened = false
item_coordsWherigo = Wherigo.ZItem(var_cartridge)
item_coordsWherigo.Id = "df555a5a-9a4e-4ed7-83bd-8b384262dd90"
item_coordsWherigo.Name = _rZ_("^1<\015mlo}\006oo\015\026m\127fz<\127")
item_coordsWherigo.Description = _rZ_(".\018\020K?\018j;U\020Iv\025y\018jj4?\018;4UKvK\025")
item_coordsWherigo.Visible = true
item_coordsWherigo.Media = _ZksVj
item_coordsWherigo.Icon = _X01Ox
item_coordsWherigo.Commands = {}
item_coordsWherigo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_coordsWherigo.Locked = false
item_coordsWherigo.Opened = false
item_coordsBonus = Wherigo.ZItem(var_cartridge)
item_coordsBonus.Id = "aae78545-05d4-4b47-abcb-52feefca7c3b"
item_coordsBonus.Name = _rZ_("7o\127\005O}\006oo\015\026m\127fz<\127")
item_coordsBonus.Description = _rZ_(".\018\020K?\018j;UAk\020\025y\018jj4?\018;4U\020v;\025")
item_coordsBonus.Visible = true
item_coordsBonus.Media = _llKe
item_coordsBonus.Icon = _XLqU
item_coordsBonus.Commands = {}
item_coordsBonus.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_coordsBonus.Locked = false
item_coordsBonus.Opened = false
_lL7kn = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
_lL7kn.Id = "f5294f91-e19e-4d99-ac84-639e9d7b45fb"
_lL7kn.Name = _rZ_("7<zf}8oot")
_lL7kn.Description = _rZ_("{1<fz}8oot\018\001\005\015\0187<zf}8<Oz<\015")
_lL7kn.Visible = false
_lL7kn.Media = _zol
_lL7kn.Icon = _Msxu
_lL7kn.Commands = {
  _Jql6 = Wherigo.ZCommand({
    Text = _rZ_("N\026\026\018v\018{om\127O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _qtv = Wherigo.ZCommand({
    Text = _rZ_("eml1z\018tmOz"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _ssJl = Wherigo.ZCommand({
    Text = _rZ_("N\026\026\018\020\0188o\014<\127O"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _KveuG = Wherigo.ZCommand({
    Text = _rZ_("q<z\0187<<\015"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _pUQe = Wherigo.ZCommand({
    Text = _rZ_("q<z\018[<Eo\127f\026<"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _FzY2B = Wherigo.ZCommand({
    Text = _rZ_("q<z\018\006t\005z<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _Ux9V_ = Wherigo.ZCommand({
    Text = _rZ_("q<z\0187f,,<t<\015"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_lL7kn.Commands._Jql6.Custom = true
_lL7kn.Commands._Jql6.Id = "ff562f22-e3f1-4d01-b2e2-28a91c7fc88c"
_lL7kn.Commands._Jql6.WorksWithAll = true
_lL7kn.Commands._qtv.Custom = true
_lL7kn.Commands._qtv.Id = "78c4a1b8-2218-45bd-871f-d4974fc381cf"
_lL7kn.Commands._qtv.WorksWithAll = true
_lL7kn.Commands._ssJl.Custom = true
_lL7kn.Commands._ssJl.Id = "2b19843e-c511-4e07-8da8-fb7e26cc882b"
_lL7kn.Commands._ssJl.WorksWithAll = true
_lL7kn.Commands._KveuG.Custom = true
_lL7kn.Commands._KveuG.Id = "dac68476-29ab-4ca1-ab3c-ebd83b260a9b"
_lL7kn.Commands._KveuG.WorksWithAll = true
_lL7kn.Commands._pUQe.Custom = true
_lL7kn.Commands._pUQe.Id = "8ce88265-ca75-4d70-9900-68cdf2dd60e7"
_lL7kn.Commands._pUQe.WorksWithAll = true
_lL7kn.Commands._FzY2B.Custom = true
_lL7kn.Commands._FzY2B.Id = "b21727f5-3ac3-4f4b-ad18-ca8b5d9e9c47"
_lL7kn.Commands._FzY2B.WorksWithAll = true
_lL7kn.Commands._Ux9V_.Custom = true
_lL7kn.Commands._Ux9V_.Id = "d7e47b26-5278-40ce-9b84-05cd316c1778"
_lL7kn.Commands._Ux9V_.WorksWithAll = true
_lL7kn.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_lL7kn.Locked = false
_lL7kn.Opened = false
item_machineDrinks = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_automatenStation})
item_machineDrinks.Id = "8f08c7e5-ef77-4345-80a8-4fdb80206422"
item_machineDrinks.Name = _rZ_("q<z\015f<\127\014<}N\005zoEfz")
item_machineDrinks.Description = _rZ_("=m<\015\018\014f\127\127Oz\018\026\005\018q<z\015f<\127\014<\018\014f\005\001<\127")
item_machineDrinks.Visible = true
item_machineDrinks.Media = _IWU
item_machineDrinks.Icon = _qIK
item_machineDrinks.Commands = {
  _zYAH = Wherigo.ZCommand({
    Text = _rZ_("\006f\005\001<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_machineDrinks.Commands._zYAH.Custom = true
item_machineDrinks.Commands._zYAH.Id = "1de5724b-bb87-46cd-91b6-1f3fc02dd111"
item_machineDrinks.Commands._zYAH.WorksWithAll = true
item_machineDrinks.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_machineDrinks.Locked = false
item_machineDrinks.Opened = false
item_machineCandy = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_automatenStation})
item_machineCandy.Id = "aed1d658-cbbc-4183-90db-61a8b16e547b"
item_machineCandy.Name = _rZ_("e\005<OOml\014<mz<\127}N\005zoEfz")
item_machineCandy.Description = _rZ_("=m<\015\018\014f\127\127Oz\018\026\005\018e\005<OO\005ml\014<mz<\127\018\014f\005\001<\127")
item_machineCandy.Visible = true
item_machineCandy.Media = _fev
item_machineCandy.Icon = _RswIr
item_machineCandy.Commands = {
  _zy1 = Wherigo.ZCommand({
    Text = _rZ_("\006f\005\001<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
item_machineCandy.Commands._zy1.Custom = true
item_machineCandy.Commands._zy1.Id = "383c0e5f-9b6d-474b-a707-8db8c9c45606"
item_machineCandy.Commands._zy1.WorksWithAll = true
item_machineCandy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_machineCandy.Locked = false
item_machineCandy.Opened = false
item_coin = Wherigo.ZItem(var_cartridge)
item_coin.Id = "5f029624-4005-47f3-87fe-368a5dea74ab"
item_coin.Name = _rZ_("!\005<\127?<")
item_coin.Description = ""
item_coin.Visible = true
item_coin.Media = _C0F1
item_coin.Icon = _H_0P
item_coin.Commands = {
  _ces = Wherigo.ZCommand({
    Text = _rZ_("!\005<\127?<\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_coin.Commands._ces.Custom = true
item_coin.Commands._ces.Id = "14703345-fc13-4586-9496-20fc86d52afa"
item_coin.Commands._ces.WorksWithAll = true
item_coin.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_coin.Locked = false
item_coin.Opened = false
item_beer = Wherigo.ZItem(var_cartridge)
item_beer.Id = "70a147e0-8d50-4ed5-9122-78ee6966f79e"
item_beer.Name = _rZ_("7m<\015")
item_beer.Description = _rZ_("8\015f\026mzmo\127<tt<O\0187\015<E<\015\0187m<\015")
item_beer.Visible = true
item_beer.Media = _q2E
item_beer.Icon = _twpX
item_beer.Commands = {}
item_beer.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_beer.Locked = false
item_beer.Opened = false
item_limo = Wherigo.ZItem(var_cartridge)
item_limo.Id = "da3fed4c-6830-40dc-b969-712d0da0a70b"
item_limo.Name = _rZ_("[mEo")
item_limo.Description = _rZ_("\am<\018,<\015\005<1Ez<\018q{}[mEo\127f\026<")
item_limo.Visible = true
item_limo.Media = _L1Pj
item_limo.Icon = _OKXn
item_limo.Commands = {}
item_limo.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_limo.Locked = false
item_limo.Opened = false
item_babbeler = Wherigo.ZItem(var_cartridge)
item_babbeler.Id = "dd95dd05-4ff6-4efa-ad85-ff09b0293fe1"
item_babbeler.Name = _rZ_("7f,,<t<\015")
item_babbeler.Description = _rZ_("8\t>mOL1<\0187\015<E<\015\018[\005zOL1<\015")
item_babbeler.Visible = true
item_babbeler.Media = _N7Fw1
item_babbeler.Icon = _15h7
item_babbeler.Commands = {}
item_babbeler.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_babbeler.Locked = false
item_babbeler.Opened = false
item_kluten = Wherigo.ZItem(var_cartridge)
item_kluten.Id = "d34e3e07-e905-47db-bf23-96105da74147"
item_kluten.Name = _rZ_("\006t\005z<\127")
item_kluten.Description = _rZ_("8\015f\026mzmo\127<tt<O\0187\015<E<\015\018.fOL1g<\015\014")
item_kluten.Visible = true
item_kluten.Media = _W92M
item_kluten.Icon = _lzUn
item_kluten.Commands = {}
item_kluten.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_kluten.Locked = false
item_kluten.Opened = false
item_manual = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
item_manual.Id = "c59c721a-38cc-439f-8390-12e93daaab2e"
item_manual.Name = _rZ_("N\127t<mz\005\127l")
item_manual.Description = ""
item_manual.Visible = true
item_manual.Media = _ir6sI
item_manual.Icon = _IXZ
item_manual.Commands = {
  _HMPKr = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127OG\006oo\015\026m\127fz<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _LhfG3 = Wherigo.ZCommand({
    Text = _rZ_("^m<\018O\005L1<\018mL1\""),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _E6tI = Wherigo.ZCommand({
    Text = _rZ_("=mt\001<\018\016o\127\018hfOOf\127z<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  }),
  _ofL = Wherigo.ZCommand({
    Text = _rZ_("!\005<\127?<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_manual.Commands._HMPKr.Custom = true
item_manual.Commands._HMPKr.Id = "181a3af5-8a99-4b5f-b8be-5c934fa4ae7f"
item_manual.Commands._HMPKr.WorksWithAll = true
item_manual.Commands._LhfG3.Custom = true
item_manual.Commands._LhfG3.Id = "a5ac4686-06aa-4789-9f60-f762d2fc3d92"
item_manual.Commands._LhfG3.WorksWithAll = true
item_manual.Commands._E6tI.Custom = true
item_manual.Commands._E6tI.Id = "b65c5324-f987-4dd0-a734-7239c58c81e9"
item_manual.Commands._E6tI.WorksWithAll = true
item_manual.Commands._ofL.Custom = true
item_manual.Commands._ofL.Id = "13bb9bed-d5a3-4868-953e-fad478115df0"
item_manual.Commands._ofL.WorksWithAll = true
item_manual.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_manual.Locked = false
item_manual.Opened = false
item_token2 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight2})
item_token2.Id = "e61b4bb5-2931-4e82-8504-215b1f119f6b"
item_token2.Name = _rZ_("8o\014<\127\018qtoL\014<\127O>m<t")
item_token2.Description = ""
item_token2.Visible = true
item_token2.Media = _DY_
item_token2.Icon = _W7PjL
item_token2.Commands = {
  _QGgg9 = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_token2.Commands._QGgg9.Custom = true
item_token2.Commands._QGgg9.Id = "75276083-d443-46d3-bc8d-17381a6f1835"
item_token2.Commands._QGgg9.WorksWithAll = true
item_token2.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_token2.Locked = false
item_token2.Opened = false
_roJ = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight3})
_roJ.Id = "ee7d3adb-4c55-4df2-ac0b-2b981aa52501"
_roJ.Name = _rZ_("8o\014<\127\018!ftt\018o\001\018QfE<")
_roJ.Description = ""
_roJ.Visible = true
_roJ.Media = _DY_
_roJ.Icon = _W7PjL
_roJ.Commands = {
  _uFa6 = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_roJ.Commands._uFa6.Custom = true
_roJ.Commands._uFa6.Id = "f79322b8-86cb-4acd-96f9-15e47b08d6fc"
_roJ.Commands._uFa6.WorksWithAll = true
_roJ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_roJ.Locked = false
_roJ.Opened = false
_fYQ7 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight4})
_fYQ7.Id = "63de3cd5-f7ab-4d08-806e-3a4ea4ccc3aa"
_fYQ7.Name = _rZ_("8o\014<\127\018ezf\026zE\005Om\014f\127z<\127")
_fYQ7.Description = ""
_fYQ7.Visible = true
_fYQ7.Media = _DY_
_fYQ7.Icon = _W7PjL
_fYQ7.Commands = {
  _ousJ = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_fYQ7.Commands._ousJ.Custom = true
_fYQ7.Commands._ousJ.Id = "88018ec4-1040-47eb-b777-82c83330861a"
_fYQ7.Commands._ousJ.WorksWithAll = true
_fYQ7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fYQ7.Locked = false
_fYQ7.Opened = false
_XEf = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight5})
_XEf.Id = "b74c7d42-0972-4c0f-a99c-0adb51e5caef"
_XEf.Name = _rZ_("8o\014<\127\018\017otf\127\026")
_XEf.Description = ""
_XEf.Visible = true
_XEf.Media = _DY_
_XEf.Icon = _W7PjL
_XEf.Commands = {
  _fZ_ = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_XEf.Commands._fZ_.Custom = true
_XEf.Commands._fZ_.Id = "85aab5b5-95c2-48d0-b77d-9c1cce0670fd"
_XEf.Commands._fZ_.WorksWithAll = true
_XEf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_XEf.Locked = false
_XEf.Opened = false
_13fID = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight6})
_13fID.Id = "049ddddc-c9ac-4681-a329-7692f7fe275a"
_13fID.Name = _rZ_("8o\014<\127\018eL1g<m\127<\026<\127\014Eft")
_13fID.Description = ""
_13fID.Visible = true
_13fID.Media = _DY_
_13fID.Icon = _W7PjL
_13fID.Commands = {
  _Et4 = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_13fID.Commands._Et4.Custom = true
_13fID.Commands._Et4.Id = "f16c9b35-dd65-47ee-889c-fc373058d5f1"
_13fID.Commands._Et4.WorksWithAll = true
_13fID.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_13fID.Locked = false
_13fID.Opened = false
_dHaD = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight7})
_dHaD.Id = "5b47a865-856d-4c1d-a18d-1c3fbf7e9815"
_dHaD.Name = _rZ_("8o\014<\127\018e>\005L\014Oz<m\127")
_dHaD.Description = ""
_dHaD.Visible = true
_dHaD.Media = _DY_
_dHaD.Icon = _W7PjL
_dHaD.Commands = {
  _8Cx = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_dHaD.Commands._8Cx.Custom = true
_dHaD.Commands._8Cx.Id = "4d767b68-e1ae-47e1-b40c-a8cfddcd38ba"
_dHaD.Commands._8Cx.WorksWithAll = true
_dHaD.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dHaD.Locked = false
_dHaD.Opened = false
_klWw = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight8})
_klWw.Id = "202622b5-4b9c-40c7-86d1-40f3cf550b54"
_klWw.Name = _rZ_("8o\014<\127\018ezf\026zgffl<")
_klWw.Description = ""
_klWw.Visible = true
_klWw.Media = _DY_
_klWw.Icon = _W7PjL
_klWw.Commands = {
  _Hfl = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_klWw.Commands._Hfl.Custom = true
_klWw.Commands._Hfl.Id = "aa75d831-edad-4a81-9a88-02e54d0c57a4"
_klWw.Commands._Hfl.WorksWithAll = true
_klWw.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_klWw.Locked = false
_klWw.Opened = false
_m8DPu = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight9})
_m8DPu.Id = "f3b747ee-64a5-49ad-a606-06d53b2080bf"
_m8DPu.Name = _rZ_("8o\014<\127\018eL1\005<zzm\127l")
_m8DPu.Description = ""
_m8DPu.Visible = true
_m8DPu.Media = _DY_
_m8DPu.Icon = _W7PjL
_m8DPu.Commands = {
  _ldrHv = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_m8DPu.Commands._ldrHv.Custom = true
_m8DPu.Commands._ldrHv.Id = "d394f11e-2f52-4ca4-be6f-64ead20c2515"
_m8DPu.Commands._ldrHv.WorksWithAll = true
_m8DPu.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_m8DPu.Locked = false
_m8DPu.Opened = false
_BfvX = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight10})
_BfvX.Id = "6edf5fc7-8c6d-43d3-9334-eadce8fd420c"
_BfvX.Name = _rZ_("8o\014<\127\018!\005<1t<")
_BfvX.Description = ""
_BfvX.Visible = true
_BfvX.Media = _DY_
_BfvX.Icon = _W7PjL
_BfvX.Commands = {
  _bat = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_BfvX.Commands._bat.Custom = true
_BfvX.Commands._bat.Id = "b85002ce-6842-4e3f-805f-237587bd16d1"
_BfvX.Commands._bat.WorksWithAll = true
_BfvX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_BfvX.Locked = false
_BfvX.Opened = false
_i1Sq = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight11})
_i1Sq.Id = "117db2ee-af34-4056-970a-56f27d5dcd20"
_i1Sq.Name = _rZ_("8o\014<\127\018\017fz1f\005O")
_i1Sq.Description = ""
_i1Sq.Visible = true
_i1Sq.Media = _DY_
_i1Sq.Icon = _W7PjL
_i1Sq.Commands = {
  _GeG3b = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_i1Sq.Commands._GeG3b.Custom = true
_i1Sq.Commands._GeG3b.Id = "1dbfe64e-140a-4631-8e3f-463f65a9edf6"
_i1Sq.Commands._GeG3b.WorksWithAll = true
_i1Sq.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_i1Sq.Locked = false
_i1Sq.Opened = false
_iOh7 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight12})
_iOh7.Id = "0ac58940-b734-4d63-aba0-58d4813ec124"
_iOh7.Name = _rZ_("8o\014<\127\018eL1\127oo\015")
_iOh7.Description = ""
_iOh7.Visible = true
_iOh7.Media = _DY_
_iOh7.Icon = _W7PjL
_iOh7.Commands = {
  _zmn = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_iOh7.Commands._zmn.Custom = true
_iOh7.Commands._zmn.Id = "59417be4-dcd1-411a-b8c6-ee33795bf3ba"
_iOh7.Commands._zmn.WorksWithAll = true
_iOh7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_iOh7.Locked = false
_iOh7.Opened = false
_9P6 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight13})
_9P6.Id = "bbfae609-ec03-4932-bdbe-2f8841c3cfa3"
_9P6.Name = _rZ_("8o\014<\127\018q<g<\015,<1f\005O")
_9P6.Description = ""
_9P6.Visible = true
_9P6.Media = _DY_
_9P6.Icon = _W7PjL
_9P6.Commands = {
  _mTf = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_9P6.Commands._mTf.Custom = true
_9P6.Commands._mTf.Id = "3bcd4bdf-1007-4600-9d2b-7f40258d935d"
_9P6.Commands._mTf.WorksWithAll = true
_9P6.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_9P6.Locked = false
_9P6.Opened = false
_J0Gf = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight14})
_J0Gf.Id = "4ac4ef90-e8a4-4ef3-b2d1-5b9d1847e13a"
_J0Gf.Name = _rZ_("8o\014<\127\018Nt<\030")
_J0Gf.Description = ""
_J0Gf.Visible = true
_J0Gf.Media = _DY_
_J0Gf.Icon = _W7PjL
_J0Gf.Commands = {
  _xdhVy = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_J0Gf.Commands._xdhVy.Custom = true
_J0Gf.Commands._xdhVy.Id = "458c4488-983f-4ea1-885b-3cb8d721759f"
_J0Gf.Commands._xdhVy.WorksWithAll = true
_J0Gf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_J0Gf.Locked = false
_J0Gf.Opened = false
_rhHz = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight15})
_rhHz.Id = "071ab720-d5da-4478-85ce-85b0e7157b85"
_rhHz.Name = _rZ_("8o\014<\127\018q<\015mL1zO1f\005O")
_rhHz.Description = ""
_rhHz.Visible = true
_rhHz.Media = _DY_
_rhHz.Icon = _W7PjL
_rhHz.Commands = {
  _9nX9 = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_rhHz.Commands._9nX9.Custom = true
_rhHz.Commands._9nX9.Id = "81b7b6db-503b-41cc-bb04-e0b78d79e6cf"
_rhHz.Commands._9nX9.WorksWithAll = true
_rhHz.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rhHz.Locked = false
_rhHz.Opened = false
_U2ZX = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight16})
_U2ZX.Id = "0d6a3fb4-eba5-42a5-bf91-ae4ea2389b0f"
_U2ZX.Name = _rZ_("8o\014<\127\018qtoL\014<")
_U2ZX.Description = ""
_U2ZX.Visible = true
_U2ZX.Media = _DY_
_U2ZX.Icon = _W7PjL
_U2ZX.Commands = {
  _GD6 = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_U2ZX.Commands._GD6.Custom = true
_U2ZX.Commands._GD6.Id = "1f6d9668-e6b6-4dad-a77a-1fa607bb68f7"
_U2ZX.Commands._GD6.WorksWithAll = true
_U2ZX.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_U2ZX.Locked = false
_U2ZX.Opened = false
_dgBO8 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight17})
_dgBO8.Id = "56be798a-121b-49bd-8802-1d490388d5b1"
_dgBO8.Name = _rZ_("8o\014<\127\018\006\005\127Oz1ftt<")
_dgBO8.Description = ""
_dgBO8.Visible = true
_dgBO8.Media = _DY_
_dgBO8.Icon = _W7PjL
_dgBO8.Commands = {
  _Gsqre = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_dgBO8.Commands._Gsqre.Custom = true
_dgBO8.Commands._Gsqre.Id = "93ebc9e2-9533-435a-ad42-7d49f0f88e04"
_dgBO8.Commands._Gsqre.WorksWithAll = true
_dgBO8.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_dgBO8.Locked = false
_dgBO8.Opened = false
_taS7l = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight18})
_taS7l.Id = "57301f6c-00c5-4b23-87a2-31836f6fc386"
_taS7l.Name = _rZ_("8o\014<\127\018q<OL1mL1z<\1271f\005O")
_taS7l.Description = ""
_taS7l.Visible = true
_taS7l.Media = _DY_
_taS7l.Icon = _W7PjL
_taS7l.Commands = {
  _pyf_ = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_taS7l.Commands._pyf_.Custom = true
_taS7l.Commands._pyf_.Id = "e8f6f2ae-49e8-4714-8f32-c3d284a689e5"
_taS7l.Commands._pyf_.WorksWithAll = true
_taS7l.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_taS7l.Locked = false
_taS7l.Opened = false
_haZiR = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight19})
_haZiR.Id = "55abda8f-3fbb-4166-9976-2db984a383b6"
_haZiR.Name = _rZ_("8o\014<\127\018[o\015moz}eo\001f")
_haZiR.Description = ""
_haZiR.Visible = true
_haZiR.Media = _DY_
_haZiR.Icon = _W7PjL
_haZiR.Commands = {
  _32K = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_haZiR.Commands._32K.Custom = true
_haZiR.Commands._32K.Id = "054a3bf7-0b1d-49a6-b57d-b1264d15f567"
_haZiR.Commands._32K.WorksWithAll = true
_haZiR.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_haZiR.Locked = false
_haZiR.Opened = false
_fvy = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight20})
_fvy.Id = "f4748c05-9cc1-4f78-8fa7-704f9c4b75b0"
_fvy.Name = _rZ_("8o\014<\127\018\aoE")
_fvy.Description = ""
_fvy.Visible = true
_fvy.Media = _DY_
_fvy.Icon = _W7PjL
_fvy.Commands = {
  _DKHaQ = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_fvy.Commands._DKHaQ.Custom = true
_fvy.Commands._DKHaQ.Id = "1e0bc805-ce96-4bfa-a4ed-18992d411301"
_fvy.Commands._DKHaQ.WorksWithAll = true
_fvy.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_fvy.Locked = false
_fvy.Opened = false
_G5LB1 = Wherigo.ZItem({Cartridge = var_cartridge, Container = zone_sight21})
_G5LB1.Id = "27b4afd9-bed2-4d64-879f-583ca5eaab41"
_G5LB1.Name = _rZ_("8o\014<\127\018\006\005tz\005\015\014m\015L1<")
_G5LB1.Description = ""
_G5LB1.Visible = true
_G5LB1.Media = _DY_
_G5LB1.Icon = _W7PjL
_G5LB1.Commands = {
  _21f = Wherigo.ZCommand({
    Text = _rZ_("8o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<\018>fL\014<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
_G5LB1.Commands._21f.Custom = true
_G5LB1.Commands._21f.Id = "b30d8d5e-d382-43d1-8376-5cac64b3275b"
_G5LB1.Commands._21f.WorksWithAll = true
_G5LB1.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_G5LB1.Locked = false
_G5LB1.Opened = false
item_notes = Wherigo.ZItem({Cartridge = var_cartridge, Container = Player})
item_notes.Id = "b49cbeb6-4ba8-4a86-b8e0-1c5ec7f62b77"
item_notes.Name = _rZ_(".ozm?<\127")
item_notes.Description = ""
item_notes.Visible = true
item_notes.Media = _6Ip1_
item_notes.Icon = _6u_
item_notes.Commands = {
  _GLe = Wherigo.ZCommand({
    Text = _rZ_("N\127O<1<\127"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _rZ_(".oz1m\127l\018f\016fmtf,t<")
  })
}
item_notes.Commands._GLe.Custom = true
item_notes.Commands._GLe.Id = "e8eb2d14-ee34-44c1-a645-ed9904b68da2"
item_notes.Commands._GLe.WorksWithAll = true
item_notes.ObjectLocation = Wherigo.INVALID_ZONEPOINT
item_notes.Locked = false
item_notes.Opened = false
task_bonus = Wherigo.ZTask(var_cartridge)
task_bonus.Id = "be3e8c72-f9dc-434b-9160-6ff70b28d3a3"
task_bonus.Name = _rZ_("7o\127\005O}\006oo\015\026m\127fz<\127\018<\015Emzz<t\127")
task_bonus.Description = ""
task_bonus.Visible = true
task_bonus.Active = true
task_bonus.Complete = false
task_bonus.CorrectState = "None"
task_wherigo = Wherigo.ZTask(var_cartridge)
task_wherigo.Id = "15061fbb-0a94-4499-9dbd-4c244acd543b"
task_wherigo.Name = _rZ_("^1<\015mlo}\006oo\015\026m\127fz<\127\018<\015Emzz<t\127")
task_wherigo.Description = ""
task_wherigo.Visible = true
task_wherigo.Active = true
task_wherigo.Complete = false
task_wherigo.CorrectState = "None"
var_TokenCount = 0
var_CoordinateWherigo = _rZ_(".\018\020K?\018j;U\020Iv\025\018y\018jj4?\018;4UKvK\025")
var_CoordinateBonus = _rZ_(".\018\020K?\018j;UAvj\025\018y\018jj4?\018;4U;4j\025")
_tNi = false
_Z_zAE = false
_nQuf = 0
var_CoinCount = 0
var_language = _rZ_("\026<")
_1Tyzc = ""
_nAys = ""
var_res_CoinSingular = _rZ_("!\005<\127?<")
var_res_CoinPlural = _rZ_("!\005<\127?<\127")
var_res_CoinsTokesUseFor = _rZ_("8o\014<\127O\018\014f\127\127\018Ef\127\018fE\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018,<\127\005z?<\127u\018Emz\018!\005<\127?<\127\018\014f\127\127\018Ef\127\018fE\018q<z\015f<\127\014<}\018\005\127\026\018e\005<OOml\014<mz<\127}N\005zoEfz<\127\018,<?f1t<\127")
var_res_TokenPlural = _rZ_("8o\014<\127O")
_CbVx = _rZ_("8o\014<\127")
var_res_CoinInWallet = _rZ_("\a\005\018Oz<L\014Oz\018\026m<\018!\005<\127?<\018m\127\018\026m<\018q<t\026,o<\015O<")
var_res_TokenInWallet = _rZ_("\a\005\018Oz<L\014Oz\018\026<\127\0188o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<")
var_res_CoordsSuccess1 = _rZ_("qt\005<L\014g\005\127OL1297\017`\a<\015\018N\005zoEfz\018O>\005L\014z\018<m\127<\127\018\b<zz<t\018Emz\018\026<\127\018\006oo\015\026m\127fz<\127\018\001\005<\015\018\026<\127\018")
var_res_CoordsSuccess2 = _rZ_("}{fL1<\018f\005O2")
var_res_CoordsValidate1 = _rZ_("\a\005\018,\015f\005L1Oz\018Em\127\026<Oz<\127O\018")
var_res_CoordsValidate2 = _rZ_("\0188o\014<\127O\018\001\005<\015\018\026m<\018")
var_RequireWherigo = 15
var_RequireBonus = 20
var_res_TokensNeeded = _rZ_("\0188o\014<\127O\018\127ozg<\127\026ml")
var_res_WhatToBuy = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018\014f\005\001<\127\"")
var_res_NotEnoughCoins = _rZ_(".mL1z\018l<\127\005l\018!\005<\127?<\1272")
var_nl = ""
_FqnH2 = ""
var_res_CoordsValidate3 = _rZ_("}\006oo\015\026m\127fz<U")
_WlRH = false
_A0n = false
_XWh = false
_Eil = false
var_CodeBonus = _rZ_("q{k=vhN")
var_CodeGold = _rZ_("q{k{=Q4")
var_CurrentZoneName = ""
_Ufn = ""
var_res_Nothing = _rZ_(".mL1zO")
var_res_WhatToOffer = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018f\127,m<z<\127\"")
var_res_hinnerk1 = _rZ_("!om\127U\018^fO\018l<1z\"")
var_res_hinnerk2 = _rZ_("=ftto297\017`\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"\018\a\005\018\014<\127\127Oz\018\amL1\018\026oL1\018OmL1<\015\0181m<\015\018f\005Ou\018o\026<\015\"")
var_res_hinnerk3 = _rZ_("_m<tt<mL1zU\018=fOz\018\a\005\018gfO\018?\005\018z\015m\127\014<\127\018\001\005<\015\018EmL1\"")
var_res_hinnerk4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\0187m<\0152")
var_res_hinnerk4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\018[mEo2")
var_res_hinnerk4c = _rZ_("\vL1\018\005\127z<\015Oz\005<z?<\018\026oL1\018\026<m\127<\0188\015m\127\014O\005L1z\018\127mL1zu\018\026f\127\127\018O\005L1<\018mL1\018<,<\127\018O<t,Oz\018g<mz<\0152")
var_res_hinnerk5a = _rZ_("\af\127\014<u\018{1<\001297\017`\006<\127\127Oz\018\a\005\018\026<\127\127\018OL1o\127\018\026m<O<\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`")
var_res_hinnerk5b = _rZ_("y\015\0181f\005z\018\026m<\018QtfOL1<\018f\005\001\018\026<\127\0187o\026<\127297\017`7f1u\018gfO\018Oott\018mL1\018\026<\127\127\018\026fEmzu\0181fOz\018\a\005\018\127mL1zO\018Emz\018ezo\001\001\"")
var_res_ManualCoords1 = _rZ_("JE\018\006oo\015\026m\127fz<\127\018?\005\018<\0151ftz<\127\018E\005<OO<\127\0188o\014<\127O\018l<OfEE<tz\018g<\015\026<\127S")
var_res_ManualCoords2 = _rZ_("N\127\018\\<\026<\015\018<\127z\026<L\014z<\127\018e<1<\127Og\005<\015\026ml\014<mz\018\001m\127\026<Oz\018\a\005\018<m\127<\127\0188o\014<\127U97\017`\am<\018\006oo\015\026m\127fz<\127\018<\0151f<tz\018Ef\127\018fE\018\006oo\026m\127fz<\127}N\005zoEfz<\127\018m\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018\026\005\015L1\018.fL1g<mO\018\026<\015\018<\127zO>\015<L1<\127\026<\127\018N\127?f1t\0188o\014<\127OU")
var_res_ManualMap = _rZ_("\am<\018l<O\005L1z<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018,<\001m\127\026<\127\018OmL1\018m\127\127<\0151ft,\018\026<\015\0187\015<E<\015\018\v\127\127<\127Ozf\026zu\018?gmOL1<\127\018\026<E\018^fOO<\015tf\005\001\018\026<\015\018^fttf\127tfl<\127\018\005\127\026\018\026<\015\018^<O<\015U97\017`^<\127\127\018\a\005\018<m\127<\018e<1<\127Og\005<\015\026ml\014<mz\018<\127z\026<L\014Ozu\018<\015\014tm\127lz\018<m\127\0188o\127\018\005\127\026\018\026m<\018\bo\127<\018zf\005L1z\018f\005\001U")
var_res_julia1 = _rZ_("i1u\018l\005z<\127\0188flU")
var_res_julia2 = _rZ_("=ftto\018\\\005\127l<\018Q\015f\005297\017`\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"\018\a\005\018\014oEEOz\018\026oL1\0181m<\015\018lf\127?\018OL1o<\127\018\015\005Eu\018o\026<\015\"")
var_res_julia3 = _rZ_("\vL1\018,m\127\018Oo\018f\005Ol<>og<\015z\018\005\127\026\0181f,<\018<m\127<\018z\015oL\014<\127<\018\006<1t<U\018=fOz\018\a\005\018\016m<tt<mL1z\018Qt\005<OOml\014<mz\018\001\005\015\018EmL1\"")
var_res_julia4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\0187m<\0152")
var_res_julia4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\018[mEo2")
var_res_julia4c = _rZ_("[<m\026<\015\018\127mL1zu\018\026f\127\127\018O\005L1<\018mL1\018<,<\127\018O<t,Oz\018g<mz<\0152")
var_res_julia5a = _rZ_("h\001\005mu\018gmttOz\018\a\005\018EmL1\018\016<\015lm\001z<\127\"")
var_res_julia5b = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`\006<\127\127Oz\018\a\005\018\026<\127\127\018OL1o\127\018\026m<O<\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`")
var_res_ManualPersons = _rZ_("^<\127\127\018\026\005\018qt\005<L\014\0181fOzu\018\014f\127\127Oz\018\026\005\018f\127\018<m\127ml<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018f\005\001\018hfOOf\127z<\127\018z\015<\001\001<\127U\018\am<O<\018l<,<\127\018\026m\015\018\016m<tt<mL1z\018=m\127g<mO<\018f\005\001\018\127oL1\018\001<1t<\127\026<\018e<1<\127Og\005<\015\026ml\014<mz<\127U\018N,<\015\018Om<\018EfL1<\127\018\026fO\018\127mL1z\018\005EOo\127Oz\018UUU")
var_RequireAll = 21
var_res_ManualCoins = _rZ_("!f\127L1Eft\018\001m\127\026<zO\018\026\005\018f\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018f\005L1\018!\005<\127?<\127U\01897\017`\afEmz\018\014f\127\127Oz\018\a\005\018m\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018q<z\015f<\127\014<\018o\026<\015\018e\005<OOml\014<mz<\127\018\014f\005\001<\127U")
var_res_erna1 = _rZ_("q\005z<\127\0188fl2")
var_res_erna2 = _rZ_("=ftto\018\006t<m\127<297\017`\006<\127\127Oz\018\a\005\018\amL1\0181m<\015\018f\005O\"\018\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"")
var_res_erna3 = _rZ_("=EEu\018mL1\018g<mOO\018\127mL1zU\018\vL1\018Oott\018<ml<\127ztmL1\018\127mL1z\018Emz\018\001\015<E\026<\127\018[<\005z<\127\018\015<\026<\127U")
var_res_erna4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\018>ff\015\0187\015<E<\015\018\006t\005z<\1272")
var_res_erna4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\127\0187f,,<t<\0152")
var_res_erna4c = _rZ_("N,<\015\018mL1\018z\005<\018\am\015\018\127mL1zOU\018qm,\018Em\015\018\026oL1\018,mzz<\018<m\127<\127\0188m>>\"")
var_res_erna5a = _rZ_("J\127\026\018e\005<OOml\014<mz<\127\018Oott\018mL1\018<\015Oz\018\015<L1z\018\127mL1z\018f\127\127<1E<\127U97\017`N\005\001\018^m<\026<\015O<1<\1272")
var_res_erna5b = _rZ_("J\127\026\018e\005<OOml\014<mz<\127\018Oott\018mL1\018<\015Oz\018\015<L1z\018\127mL1z\018f\127\127<1E<\127U97\017`N\005\001\018^m<\026<\015O<1<\1272")
var_res_erna5c = _rZ_(".f\018l\005z297\017`!<m\127\018[m<,tm\127lOo\015z\018mOz\018\026<\015\0181m<\015S97\017`97\017`")
var_res_oma1 = _rZ_(".f\018E<m\127\018[\005<zz<\0152")
var_res_oma2 = _rZ_("q\005z<\127\0188fl\018l\127f<\026ml<\018Q\015f\005297\017`\006o<\127\127<\127\018em<\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"")
var_res_oma3 = _rZ_("_m<tt<mL1z2\018=f,<\127\018em<\018\016m<tt<mL1z\018gfO\018?\005\018OL1tmL\014<\015\127\"")
var_res_oma4a = _rZ_("=m<\015\0181f,<\018mL1\018<m\127\018>ff\015\018\006t\005z<\127\018\001\005\015\018em<2")
var_res_oma4b = _rZ_("=m<\015S\018<m\127<\127\0187\015<E<\015\0187f,,<t<\015")
var_res_oma4c = _rZ_("[<m\026<\015\018\127mL1zu\018\026f\127\127\018E\005OO\018mL1\018<,<\127\018O<t,Oz\018g<mz<\015\018O\005L1<\1272")
var_res_oma5a = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`^f\015<\127\018em<\018\026<\127\127\018OL1o\127\018,<m\018\026m<O<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`")
var_res_oma5b = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`^f\015<\127\018em<\018\026<\127\127\018OL1o\127\018,<m\018\026m<O<\015\018e<1<\127Og\005<\015\026ml\014<mzS97\017`97\017`")
var_res_erna6c = _rZ_("\vL1\018E\005OO\018toO\018}\0188OL1\005<OO2")
var_res_VisitedSights = _rZ_("7<O\005L1z<\018e<1<\127Og\005<\015\026ml\014<mz<\127S")
var_res_None = _rZ_("\006<m\127<")
var_KeyDrink = _rZ_(".\aL\030!b$$")
var_KeyCurrent = ""
var_KeyCandy = _rZ_("!\al\030.b$$")
var_KeyCoordinates = _rZ_("!\\yj!l$$")
var_res_KeyNotValid = _rZ_("{o\026<\018\127mL1z\018\014o\015\015<\014z2")
var_CompletionCode = _rZ_("\030\030\030")
var_res_ZoneHint = _rZ_("Qf<\127lz\018Emz\018\025U\030U\025\018f\127\018\005\127\026\018mOz\018<zgf\018U\tU\018!<z<\015\018m\127\018U?U\018q\015f\026\018<\127z\001<\015\127z")
var_res_ThenInsertCoordinates = _rZ_("\af\127\127\018\026fEmz\018f\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018\026<\127\127\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018\001\005zz<\015\127U")
var_res_DontKnowAny = _rZ_("\a\005\0181fOz\018\026oL1\018,<\015<mzO\018ftt<\018e<1<\127Og\005<\015\026ml\014<mz<\127\018l<\001\005\127\026<\1272")
CurrZone = _rZ_("?o\127<0Oml1z;")
_CpHyP = _rZ_("0L8<0\001")
_8Tz = _rZ_("mz<E0zo\014<\127p")
_J3x = _rZ_("zfO\0140,o\127\005O")
_mTGuY = _rZ_("Z\015\t0[f\127l\005fl<")
_kiXR = _rZ_("\026\005EE\t")
var_cartridge.ZVariables = {
  var_TokenCount = 0,
  var_CoordinateWherigo = _rZ_(".\018\020K?\018j;U\020Iv\025\018y\018jj4?\018;4UKvK\025"),
  var_CoordinateBonus = _rZ_(".\018\020K?\018j;UAvj\025\018y\018jj4?\018;4U;4j\025"),
  _tNi = false,
  _Z_zAE = false,
  _nQuf = 0,
  var_CoinCount = 0,
  var_language = _rZ_("\026<"),
  _1Tyzc = "",
  _nAys = "",
  var_res_CoinSingular = _rZ_("!\005<\127?<"),
  var_res_CoinPlural = _rZ_("!\005<\127?<\127"),
  var_res_CoinsTokesUseFor = _rZ_("8o\014<\127O\018\014f\127\127\018Ef\127\018fE\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018,<\127\005z?<\127u\018Emz\018!\005<\127?<\127\018\014f\127\127\018Ef\127\018fE\018q<z\015f<\127\014<}\018\005\127\026\018e\005<OOml\014<mz<\127}N\005zoEfz<\127\018,<?f1t<\127"),
  var_res_TokenPlural = _rZ_("8o\014<\127O"),
  _CbVx = _rZ_("8o\014<\127"),
  var_res_CoinInWallet = _rZ_("\a\005\018Oz<L\014Oz\018\026m<\018!\005<\127?<\018m\127\018\026m<\018q<t\026,o<\015O<"),
  var_res_TokenInWallet = _rZ_("\a\005\018Oz<L\014Oz\018\026<\127\0188o\014<\127\018m\127\018\026m<\018q<t\026,o<\015O<"),
  var_res_CoordsSuccess1 = _rZ_("qt\005<L\014g\005\127OL1297\017`\a<\015\018N\005zoEfz\018O>\005L\014z\018<m\127<\127\018\b<zz<t\018Emz\018\026<\127\018\006oo\015\026m\127fz<\127\018\001\005<\015\018\026<\127\018"),
  var_res_CoordsSuccess2 = _rZ_("}{fL1<\018f\005O2"),
  var_res_CoordsValidate1 = _rZ_("\a\005\018,\015f\005L1Oz\018Em\127\026<Oz<\127O\018"),
  var_res_CoordsValidate2 = _rZ_("\0188o\014<\127O\018\001\005<\015\018\026m<\018"),
  var_RequireWherigo = 15,
  var_RequireBonus = 20,
  var_res_TokensNeeded = _rZ_("\0188o\014<\127O\018\127ozg<\127\026ml"),
  var_res_WhatToBuy = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018\014f\005\001<\127\""),
  var_res_NotEnoughCoins = _rZ_(".mL1z\018l<\127\005l\018!\005<\127?<\1272"),
  var_nl = "",
  _FqnH2 = "",
  var_res_CoordsValidate3 = _rZ_("}\006oo\015\026m\127fz<U"),
  _WlRH = false,
  _A0n = false,
  _XWh = false,
  _Eil = false,
  var_CodeBonus = _rZ_("q{k=vhN"),
  var_CodeGold = _rZ_("q{k{=Q4"),
  var_CurrentZoneName = "",
  _Ufn = "",
  var_res_Nothing = _rZ_(".mL1zO"),
  var_res_WhatToOffer = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018f\127,m<z<\127\""),
  var_res_hinnerk1 = _rZ_("!om\127U\018^fO\018l<1z\""),
  var_res_hinnerk2 = _rZ_("=ftto297\017`\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"\018\a\005\018\014<\127\127Oz\018\amL1\018\026oL1\018OmL1<\015\0181m<\015\018f\005Ou\018o\026<\015\""),
  var_res_hinnerk3 = _rZ_("_m<tt<mL1zU\018=fOz\018\a\005\018gfO\018?\005\018z\015m\127\014<\127\018\001\005<\015\018EmL1\""),
  var_res_hinnerk4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\0187m<\0152"),
  var_res_hinnerk4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\018[mEo2"),
  var_res_hinnerk4c = _rZ_("\vL1\018\005\127z<\015Oz\005<z?<\018\026oL1\018\026<m\127<\0188\015m\127\014O\005L1z\018\127mL1zu\018\026f\127\127\018O\005L1<\018mL1\018<,<\127\018O<t,Oz\018g<mz<\0152"),
  var_res_hinnerk5a = _rZ_("\af\127\014<u\018{1<\001297\017`\006<\127\127Oz\018\a\005\018\026<\127\127\018OL1o\127\018\026m<O<\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`"),
  var_res_hinnerk5b = _rZ_("y\015\0181f\005z\018\026m<\018QtfOL1<\018f\005\001\018\026<\127\0187o\026<\127297\017`7f1u\018gfO\018Oott\018mL1\018\026<\127\127\018\026fEmzu\0181fOz\018\a\005\018\127mL1zO\018Emz\018ezo\001\001\""),
  var_res_ManualCoords1 = _rZ_("JE\018\006oo\015\026m\127fz<\127\018?\005\018<\0151ftz<\127\018E\005<OO<\127\0188o\014<\127O\018l<OfEE<tz\018g<\015\026<\127S"),
  var_res_ManualCoords2 = _rZ_("N\127\018\\<\026<\015\018<\127z\026<L\014z<\127\018e<1<\127Og\005<\015\026ml\014<mz\018\001m\127\026<Oz\018\a\005\018<m\127<\127\0188o\014<\127U97\017`\am<\018\006oo\015\026m\127fz<\127\018<\0151f<tz\018Ef\127\018fE\018\006oo\026m\127fz<\127}N\005zoEfz<\127\018m\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018\026\005\015L1\018.fL1g<mO\018\026<\015\018<\127zO>\015<L1<\127\026<\127\018N\127?f1t\0188o\014<\127OU"),
  var_res_ManualMap = _rZ_("\am<\018l<O\005L1z<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018,<\001m\127\026<\127\018OmL1\018m\127\127<\0151ft,\018\026<\015\0187\015<E<\015\018\v\127\127<\127Ozf\026zu\018?gmOL1<\127\018\026<E\018^fOO<\015tf\005\001\018\026<\015\018^fttf\127tfl<\127\018\005\127\026\018\026<\015\018^<O<\015U97\017`^<\127\127\018\a\005\018<m\127<\018e<1<\127Og\005<\015\026ml\014<mz\018<\127z\026<L\014Ozu\018<\015\014tm\127lz\018<m\127\0188o\127\018\005\127\026\018\026m<\018\bo\127<\018zf\005L1z\018f\005\001U"),
  var_res_julia1 = _rZ_("i1u\018l\005z<\127\0188flU"),
  var_res_julia2 = _rZ_("=ftto\018\\\005\127l<\018Q\015f\005297\017`\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\"\018\a\005\018\014oEEOz\018\026oL1\0181m<\015\018lf\127?\018OL1o<\127\018\015\005Eu\018o\026<\015\""),
  var_res_julia3 = _rZ_("\vL1\018,m\127\018Oo\018f\005Ol<>og<\015z\018\005\127\026\0181f,<\018<m\127<\018z\015oL\014<\127<\018\006<1t<U\018=fOz\018\a\005\018\016m<tt<mL1z\018Qt\005<OOml\014<mz\018\001\005\015\018EmL1\""),
  var_res_julia4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\0187m<\0152"),
  var_res_julia4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\018[mEo2"),
  var_res_julia4c = _rZ_("[<m\026<\015\018\127mL1zu\018\026f\127\127\018O\005L1<\018mL1\018<,<\127\018O<t,Oz\018g<mz<\0152"),
  var_res_julia5a = _rZ_("h\001\005mu\018gmttOz\018\a\005\018EmL1\018\016<\015lm\001z<\127\""),
  var_res_julia5b = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`\006<\127\127Oz\018\a\005\018\026<\127\127\018OL1o\127\018\026m<O<\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`"),
  var_res_ManualPersons = _rZ_("^<\127\127\018\026\005\018qt\005<L\014\0181fOzu\018\014f\127\127Oz\018\026\005\018f\127\018<m\127ml<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018f\005\001\018hfOOf\127z<\127\018z\015<\001\001<\127U\018\am<O<\018l<,<\127\018\026m\015\018\016m<tt<mL1z\018=m\127g<mO<\018f\005\001\018\127oL1\018\001<1t<\127\026<\018e<1<\127Og\005<\015\026ml\014<mz<\127U\018N,<\015\018Om<\018EfL1<\127\018\026fO\018\127mL1z\018\005EOo\127Oz\018UUU"),
  var_RequireAll = 21,
  var_res_ManualCoins = _rZ_("!f\127L1Eft\018\001m\127\026<zO\018\026\005\018f\127\018e<1<\127Og\005<\015\026ml\014<mz<\127\018f\005L1\018!\005<\127?<\127U\01897\017`\afEmz\018\014f\127\127Oz\018\a\005\018m\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018q<z\015f<\127\014<\018o\026<\015\018e\005<OOml\014<mz<\127\018\014f\005\001<\127U"),
  var_res_erna1 = _rZ_("q\005z<\127\0188fl2"),
  var_res_erna2 = _rZ_("=ftto\018\006t<m\127<297\017`\006<\127\127Oz\018\a\005\018\amL1\0181m<\015\018f\005O\"\018\006f\127\127Oz\018\a\005\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\""),
  var_res_erna3 = _rZ_("=EEu\018mL1\018g<mOO\018\127mL1zU\018\vL1\018Oott\018<ml<\127ztmL1\018\127mL1z\018Emz\018\001\015<E\026<\127\018[<\005z<\127\018\015<\026<\127U"),
  var_res_erna4a = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127\018>ff\015\0187\015<E<\015\018\006t\005z<\1272"),
  var_res_erna4b = _rZ_("=m<\015\0181fOz\018\a\005\018<m\127<\127\0187f,,<t<\0152"),
  var_res_erna4c = _rZ_("N,<\015\018mL1\018z\005<\018\am\015\018\127mL1zOU\018qm,\018Em\015\018\026oL1\018,mzz<\018<m\127<\127\0188m>>\""),
  var_res_erna5a = _rZ_("J\127\026\018e\005<OOml\014<mz<\127\018Oott\018mL1\018<\015Oz\018\015<L1z\018\127mL1z\018f\127\127<1E<\127U97\017`N\005\001\018^m<\026<\015O<1<\1272"),
  var_res_erna5b = _rZ_("J\127\026\018e\005<OOml\014<mz<\127\018Oott\018mL1\018<\015Oz\018\015<L1z\018\127mL1z\018f\127\127<1E<\127U97\017`N\005\001\018^m<\026<\015O<1<\1272"),
  var_res_erna5c = _rZ_(".f\018l\005z297\017`!<m\127\018[m<,tm\127lOo\015z\018mOz\018\026<\015\0181m<\015S97\017`97\017`"),
  var_res_oma1 = _rZ_(".f\018E<m\127\018[\005<zz<\0152"),
  var_res_oma2 = _rZ_("q\005z<\127\0188fl\018l\127f<\026ml<\018Q\015f\005297\017`\006o<\127\127<\127\018em<\018Em\015\018\016m<tt<mL1z\0181<t\001<\127u\018e<1<\127Og\005<\015\026ml\014<mz<\127\018?\005\018\001m\127\026<\127\""),
  var_res_oma3 = _rZ_("_m<tt<mL1z2\018=f,<\127\018em<\018\016m<tt<mL1z\018gfO\018?\005\018OL1tmL\014<\015\127\""),
  var_res_oma4a = _rZ_("=m<\015\0181f,<\018mL1\018<m\127\018>ff\015\018\006t\005z<\127\018\001\005\015\018em<2"),
  var_res_oma4b = _rZ_("=m<\015S\018<m\127<\127\0187\015<E<\015\0187f,,<t<\015"),
  var_res_oma4c = _rZ_("[<m\026<\015\018\127mL1zu\018\026f\127\127\018E\005OO\018mL1\018<,<\127\018O<t,Oz\018g<mz<\015\018O\005L1<\1272"),
  var_res_oma5a = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`^f\015<\127\018em<\018\026<\127\127\018OL1o\127\018,<m\018\026m<O<\127\018e<1<\127Og\005<\015\026ml\014<mz<\127S97\017`97\017`"),
  var_res_oma5b = _rZ_("i1u\018\016m<t<\127\018\af\127\014297\017`^f\015<\127\018em<\018\026<\127\127\018OL1o\127\018,<m\018\026m<O<\015\018e<1<\127Og\005<\015\026ml\014<mzS97\017`97\017`"),
  var_res_erna6c = _rZ_("\vL1\018E\005OO\018toO\018}\0188OL1\005<OO2"),
  var_res_VisitedSights = _rZ_("7<O\005L1z<\018e<1<\127Og\005<\015\026ml\014<mz<\127S"),
  var_res_None = _rZ_("\006<m\127<"),
  var_KeyDrink = _rZ_(".\aL\030!b$$"),
  var_KeyCurrent = "",
  var_KeyCandy = _rZ_("!\al\030.b$$"),
  var_KeyCoordinates = _rZ_("!\\yj!l$$"),
  var_res_KeyNotValid = _rZ_("{o\026<\018\127mL1z\018\014o\015\015<\014z2"),
  var_CompletionCode = _rZ_("\030\030\030"),
  var_res_ZoneHint = _rZ_("Qf<\127lz\018Emz\018\025U\030U\025\018f\127\018\005\127\026\018mOz\018<zgf\018U\tU\018!<z<\015\018m\127\018U?U\018q\015f\026\018<\127z\001<\015\127z"),
  var_res_ThenInsertCoordinates = _rZ_("\af\127\127\018\026fEmz\018f\127\018\026<\015\018N\005zoEfz<\127}ezfzmo\127\018\026<\127\127\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018\001\005zz<\015\127U"),
  var_res_DontKnowAny = _rZ_("\a\005\0181fOz\018\026oL1\018,<\015<mzO\018ftt<\018e<1<\127Og\005<\015\026ml\014<mz<\127\018l<\001\005\127\026<\1272"),
  CurrZone = _rZ_("?o\127<0Oml1z;"),
  _CpHyP = _rZ_("0L8<0\001"),
  _8Tz = _rZ_("mz<E0zo\014<\127p"),
  _J3x = _rZ_("zfO\0140,o\127\005O"),
  _mTGuY = _rZ_("Z\015\t0[f\127l\005fl<"),
  _kiXR = _rZ_("\026\005EE\t")
}
qry_Language = Wherigo.ZInput(var_cartridge)
qry_Language.Id = "67209ab5-fdd8-4a10-bf7c-6d9bbbcce38c"
qry_Language.Name = _rZ_("b\005<\015\t0[f\127l\005fl<")
qry_Language.Description = _rZ_("7mzz<\018e>\015fL1<\018gf<1t<\12797\017`ht<fO<\018L1ooO<\018\to\005\015\018tf\127l\005fl<")
qry_Language.Visible = true
qry_Language.Media = _uhPEF
qry_Language.Icon = _GFjL_
qry_Language.Choices = {"Deutsch", "English"}
qry_Language.InputType = "MultipleChoice"
qry_Language.Text = _rZ_("7mzz<\018e>\015fL1<\018gf<1t<\12797\017`ht<fO<\018L1ooO<\018\to\005\015\018tf\127l\005fl<")
qry_BuyDrink = Wherigo.ZInput(var_cartridge)
qry_BuyDrink.Id = "c0650423-e274-4fc6-962c-3bb645d301f3"
qry_BuyDrink.Name = _rZ_("b\005<\015\t07\005\t\a\015m\127\014")
qry_BuyDrink.Description = ""
qry_BuyDrink.Visible = true
qry_BuyDrink.Media = _IWU
qry_BuyDrink.Choices = {"Bier", "Limo"}
qry_BuyDrink.InputType = "MultipleChoice"
qry_BuyDrink.Text = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018\014f\005\001<\127\"97\017`7m<\015\018\014oOz<z\018v\018!\005<\127?<\127\018\005\127\026\018[mEo\018p\018!\005<\127?<")
qry_BuyCandy = Wherigo.ZInput(var_cartridge)
qry_BuyCandy.Id = "edeff0f9-a715-41d6-bdfc-8e1f4946e732"
qry_BuyCandy.Name = _rZ_("b\005<\015\t07\005\t{f\127\026\t")
qry_BuyCandy.Description = ""
qry_BuyCandy.Visible = true
qry_BuyCandy.Media = _fev
qry_BuyCandy.Choices = {"Babbeler", "Kluten"}
qry_BuyCandy.InputType = "MultipleChoice"
qry_BuyCandy.Text = _rZ_("^fO\018Eo<L1z<Oz\018\a\005\018\014f\005\001<\127\"97\017`\006t\005z<\127\018\014oOz<\127\018v\018!\005<\127?<\127\018\005\127\026\018<m\127\0187f,,<t<\015\018p\018!\005<\127?<")
qry_HinnerkDrink = Wherigo.ZInput(var_cartridge)
qry_HinnerkDrink.Id = "9ea089a4-07a9-4194-aa26-d362dea58ce2"
qry_HinnerkDrink.Name = _rZ_("b\005<\015\t0=m\127\127<\015\014\a\015m\127\014")
qry_HinnerkDrink.Description = ""
qry_HinnerkDrink.Visible = true
qry_HinnerkDrink.Choices = {"1", "2"}
qry_HinnerkDrink.InputType = "MultipleChoice"
qry_HinnerkDrink.Text = _rZ_("^fO\018EoL1z<Oz\018\a\005\018f\127,m<z<\127\"")
qry_JuliaDrink = Wherigo.ZInput(var_cartridge)
qry_JuliaDrink.Id = "ffea7a9c-76eb-4389-9f31-2fd09c3b17d7"
qry_JuliaDrink.Name = _rZ_("b\005<\015\t0:\005tmf\a\015m\127\014")
qry_JuliaDrink.Description = ""
qry_JuliaDrink.Visible = true
qry_JuliaDrink.Choices = {"1", "2"}
qry_JuliaDrink.InputType = "MultipleChoice"
qry_JuliaDrink.Text = _rZ_("^fO\018EoL1z<Oz\018\a\005\018f\127,m<z<\127\"")
qry_ErnaCandy = Wherigo.ZInput(var_cartridge)
qry_ErnaCandy.Id = "7579caf1-e422-4acb-9be5-2d5ec88d505c"
qry_ErnaCandy.Name = _rZ_("b\005<\015\t0y\015\127f{f\127\026\t")
qry_ErnaCandy.Description = ""
qry_ErnaCandy.Visible = true
qry_ErnaCandy.Choices = {"1", "2"}
qry_ErnaCandy.InputType = "MultipleChoice"
qry_ErnaCandy.Text = _rZ_("^fO\018EoL1z<Oz\018\a\005\018f\127,m<z<\127\"")
qry_OmaCandy = Wherigo.ZInput(var_cartridge)
qry_OmaCandy.Id = "d058b62e-c014-4fef-bdac-d409bc891f51"
qry_OmaCandy.Name = _rZ_("b\005<\015\t0iEf{f\127\026\t")
qry_OmaCandy.Description = ""
qry_OmaCandy.Visible = true
qry_OmaCandy.Choices = {"1", "2"}
qry_OmaCandy.InputType = "MultipleChoice"
qry_OmaCandy.Text = _rZ_("^fO\018EoL1z<Oz\018\a\005\018f\127,m<z<\127\"")
_F4Iuo = Wherigo.ZInput(var_cartridge)
_F4Iuo.Id = "f89f1580-cbcb-4422-ac92-777af610f61b"
_F4Iuo.Name = _rZ_("b\005<\015\t0\006<\t{f\127\026\t")
_F4Iuo.Description = ""
_F4Iuo.Visible = true
_F4Iuo.Media = _c_s
_F4Iuo.Icon = _3x4
_F4Iuo.InputType = "Text"
_F4Iuo.Text = _rZ_("7mzz<\018\026<\127\018\bf1t<\127Lo\026<\018\016oE\018e\005<OOml\014<mz<\127}N\005zoEfz<\127\018P\015<L1z<\015\018\006fOz<\127-\018f,t<O<\127\018\005\127\026\018<m\127l<,<\127U")
_BOTu = Wherigo.ZInput(var_cartridge)
_BOTu.Id = "e9e5a755-1050-409b-8ba4-ea2ca19f3a15"
_BOTu.Name = _rZ_("b\005<\015\t0\006<\t\a\015m\127\014")
_BOTu.Description = ""
_BOTu.Visible = true
_BOTu.Media = _c_s
_BOTu.Icon = _3x4
_BOTu.InputType = "Text"
_BOTu.Text = _rZ_("7mzz<\018\026<\127\018\bf1t<\127Lo\026<\018\016oE\018q<z\015f<\127\014<}N\005zoEfz<\127\018Ptm\127\014<\015\018\006fOz<\127-\018f,t<O<\127\018\005\127\026\018<m\127l<,<\127U")
_jjBsc = Wherigo.ZInput(var_cartridge)
_jjBsc.Id = "bef91ca8-aa7f-4053-86cc-bcc1162a7244"
_jjBsc.Name = _rZ_("b\005<\015\t0\006<\t{oo\015\026m\127fz<O^1<\015mlo")
_jjBsc.Description = ""
_jjBsc.Visible = true
_jjBsc.Media = _c_s
_jjBsc.Icon = _3x4
_jjBsc.InputType = "Text"
_jjBsc.Text = _rZ_("7mzz<\018\026<\127\018\bf1t<\127Lo\026<\018\016oE\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018PEmzzt<\015<\015\018\006fOz<\127-\018f,t<O<\127\018\005\127\026\018<m\127l<,<\127U")
_VRnq = Wherigo.ZInput(var_cartridge)
_VRnq.Id = "9db8235a-91a1-441d-9f51-4c9507a6db60"
_VRnq.Name = _rZ_("b\005<\015\t0\006<\t{oo\015\026m\127fz<O7o\127\005O")
_VRnq.Description = ""
_VRnq.Visible = true
_VRnq.Media = _c_s
_VRnq.Icon = _3x4
_VRnq.InputType = "Text"
_VRnq.Text = _rZ_("7mzz<\018\026<\127\018\bf1t<\127Lo\026<\018\016oE\018\006oo\015\026m\127fz<\127}N\005zoEfz<\127\018PEmzzt<\015<\015\018\006fOz<\127-\018f,t<O<\127\018\005\127\026\018<m\127l<,<\127U")
function var_cartridge:OnStart()
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(qry_Language)
  end)
  Init()
end
function var_cartridge:OnRestore()
end
function zone_sight4:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1z;")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight5:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1z\020")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight6:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zA")
  _Urwigo.GlobalZoneEnter()
end
function zone_automatenStation:OnEnter()
  CurrZone = _rZ_("?o\127<0f\005zoEfz<\127ezfzmo\127")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight7:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zk")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight1:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zp")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight8:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1z4")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight2:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zv")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight3:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zK")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight9:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zI")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight10:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpj")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight11:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpp")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight12:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpv")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight13:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpK")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight14:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zp;")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight15:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zp\020")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight16:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpA")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight17:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpk")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight18:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zp4")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight19:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zpI")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight20:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zvj")
  _Urwigo.GlobalZoneEnter()
end
function zone_sight21:OnEnter()
  CurrZone = _rZ_("?o\127<0Oml1zvp")
  _Urwigo.GlobalZoneEnter()
end
function qry_Language:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 57985 then
    var_language = _rZ_("<\127")
    _Urwigo.Dialog(false, {
      {
        Text = _rZ_("^<tLoE<297\017`^ft\014\018f\015o\005\127\026\0187\015<E<\127\018f\127\026\018\001m\127\026\018Oml1zOU\018:\005Oz\018\016mOmz\018z1<\018Lmz\t\018tm\014<\018f\018E\005llt<\018zo\005\015mOz\018go\005t\0262"),
        Media = _4A7Z
      }
    }, function(action)
      InitResources("en")
      _H8CGA()
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    var_language = _rZ_("\026<")
    _Urwigo.Dialog(false, {
      {
        Text = _rZ_("^mtt\014oEE<\127297\017`y\015\014\005\127\026<\0187\015<E<\127\018Emz\018\026m<O<E\018\014oOz<\127toO<\127\018eml1zO<<m\127l}8\015m>\018\026<\015\018,<Oo\127\026<\015<\127\018N\015z2"),
        Media = _4A7Z
      }
    }, function(action)
      InitResources("de")
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  zone_sight2.Name = _rZ_("qtoL\014<\127O>m<t\0187o<zzL1<\015Oz\015fOO<")
end
function qry_BuyDrink:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, _rZ_("7m<\015")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("7<<\015")) then
    if var_CoinCount >= 2 then
      var_CoinCount = var_CoinCount - 2
      item_beer:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
    else
      _Urwigo.OldDialog({
        {Text = var_res_NotEnoughCoins}
      })
    end
  elseif Wherigo.NoCaseEquals(_Ufn, _rZ_("[mEo")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("[<Eo\127f\026<")) then
    if var_CoinCount >= 1 then
      var_CoinCount = var_CoinCount - 1
      item_limo:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
    else
      _Urwigo.OldDialog({
        {Text = var_res_NotEnoughCoins}
      })
    end
  end
end
function qry_BuyCandy:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, _rZ_("\006t\005z<\127")) then
    if var_CoinCount >= 2 then
      var_CoinCount = var_CoinCount - 2
      item_kluten:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
    else
      _Urwigo.OldDialog({
        {Text = var_res_NotEnoughCoins}
      })
    end
  elseif Wherigo.NoCaseEquals(_Ufn, _rZ_("7f,,<t<\015")) then
    if var_CoinCount >= 1 then
      var_CoinCount = var_CoinCount - 1
      item_babbeler:MoveTo(Player)
      Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
    else
      _Urwigo.OldDialog({
        {Text = var_res_NotEnoughCoins}
      })
    end
  end
end
function qry_HinnerkDrink:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, _rZ_("7m<\015")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("7<<\015")) then
    item_beer:MoveTo(nil)
    _Urwigo.OldDialog({
      {Text = var_res_hinnerk4a, Media = _q2E},
      {
        Text = var_res_hinnerk5a .. HintZoneList(2),
        Media = _XvRtp
      }
    })
  elseif Wherigo.NoCaseEquals(_Ufn, _rZ_("[mEo")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("[<Eo\127f\026<")) then
    item_limo:MoveTo(nil)
    _Urwigo.OldDialog({
      {Text = var_res_hinnerk4b, Media = _L1Pj},
      {Text = var_res_hinnerk5b, Media = _XvRtp}
    })
  else
    _Urwigo.OldDialog({
      {Text = var_res_hinnerk4c, Media = _4A7Z}
    })
  end
end
function qry_JuliaDrink:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, _rZ_("7m<\015")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("7<<\015")) then
    _Urwigo.OldDialog({
      {Text = var_res_julia4a, Media = _q2E},
      {Text = var_res_julia5a, Media = _b8cP}
    })
  elseif Wherigo.NoCaseEquals(_Ufn, _rZ_("[mEo")) or Wherigo.NoCaseEquals(_Ufn, _rZ_("[<Eo\127f\026<")) then
    item_limo:MoveTo(nil)
    _Urwigo.OldDialog({
      {Text = var_res_julia4b, Media = _L1Pj},
      {
        Text = var_res_julia5b .. HintZoneList(1),
        Media = _b8cP
      }
    })
  else
    _Urwigo.OldDialog({
      {Text = var_res_julia4c, Media = _4A7Z}
    })
  end
end
function qry_ErnaCandy:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, item_kluten.Name) then
    _Urwigo.Dialog(false, {
      {Text = var_res_erna4a, Media = _W92M},
      {Text = var_res_erna5a, Media = _W92M}
    }, function(action)
      _i14yj:MoveTo(nil)
    end)
  elseif Wherigo.NoCaseEquals(_Ufn, item_babbeler.Name) then
    _Urwigo.Dialog(false, {
      {Text = var_res_erna4b, Media = _N7Fw1},
      {Text = var_res_erna5b, Media = _T1vz}
    }, function(action)
      _i14yj:MoveTo(nil)
    end)
  else
    _Urwigo.Dialog(false, {
      {Text = var_res_erna4c, Media = _4A7Z},
      {
        Text = var_res_erna5c .. HintZoneList(1),
        Media = _T1vz
      },
      {Text = var_res_erna6c, Media = _T1vz}
    }, function(action)
      _i14yj:MoveTo(nil)
    end)
  end
end
function qry_OmaCandy:OnGetInput(input)
  if input == nil then
    input = ""
  end
  _Ufn = input
  if Wherigo.NoCaseEquals(_Ufn, item_kluten.Name) then
    item_kluten:MoveTo(nil)
    _Urwigo.OldDialog({
      {Text = var_res_oma4a, Media = _W92M},
      {
        Text = var_res_oma5a .. HintZoneList(2),
        Media = _QsW0N
      }
    })
  elseif Wherigo.NoCaseEquals(_Ufn, item_babbeler.Name) then
    item_babbeler:MoveTo(nil)
    _Urwigo.OldDialog({
      {Text = var_res_oma4b, Media = _N7Fw1},
      {
        Text = var_res_oma5b .. HintZoneList(1),
        Media = _QsW0N
      }
    })
  else
    _Urwigo.OldDialog({
      {Text = var_res_oma4c, Media = _4A7Z}
    })
  end
end
function _F4Iuo:OnGetInput(input)
  if input == nil then
    input = ""
  end
  var_KeyCurrent = input
  if CheckKey(var_KeyCurrent, var_KeyCandy) == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(qry_BuyCandy)
    end)
  else
    _Urwigo.MessageBox({Text = var_res_KeyNotValid})
  end
end
function _BOTu:OnGetInput(input)
  if input == nil then
    input = ""
  end
  var_KeyCurrent = input
  if CheckKey(var_KeyCurrent, var_KeyDrink) == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(qry_BuyDrink)
    end)
  else
    _Urwigo.MessageBox({Text = var_res_KeyNotValid})
  end
end
function _jjBsc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  var_KeyCurrent = input
  if CheckKey(var_KeyCurrent, var_KeyCoordinates) == true then
    if var_TokenCount >= var_RequireWherigo then
      _Urwigo.Dialog(false, {
        {
          Text = (var_res_CoordsSuccess1 .. _rZ_("^1<\015mlo")) .. var_res_CoordsSuccess2,
          Media = _ZksVj
        }
      }, function(action)
        task_wherigo.Complete = true
        _tNi = true
        item_coordsWherigo:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
      end)
    else
      _Urwigo.OldDialog({
        {
          Text = (((var_res_CoordsValidate1 .. var_RequireWherigo) .. var_res_CoordsValidate2) .. _rZ_("^1<\015mlo")) .. var_res_CoordsValidate3
        }
      })
    end
  else
    _Urwigo.MessageBox({Text = var_res_KeyNotValid})
  end
end
function _VRnq:OnGetInput(input)
  if input == nil then
    input = ""
  end
  var_KeyCurrent = input
  if CheckKey(var_KeyCurrent, var_KeyCoordinates) == true then
    if var_TokenCount >= var_RequireBonus then
      _Urwigo.Dialog(false, {
        {
          Text = (var_res_CoordsSuccess1 .. _rZ_("7o\127\005O")) .. var_res_CoordsSuccess2,
          Media = _llKe
        }
      }, function(action)
        task_bonus.Complete = true
        _Z_zAE = true
        item_coordsBonus:MoveTo(Player)
        Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
      end)
    else
      _Urwigo.OldDialog({
        {
          Text = (((var_res_CoordsValidate1 .. var_RequireBonus) .. var_res_CoordsValidate2) .. _rZ_("7o\127\005O")) .. var_res_CoordsValidate3
        }
      })
    end
  else
    _Urwigo.MessageBox({Text = var_res_KeyNotValid})
  end
end
function _cTe_f:On_RydM(target)
  _Urwigo.MessageBox({
    Text = var_res_hinnerk1,
    Media = _XvRtp,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {Text = var_res_hinnerk2, Media = _4A7Z},
          {Text = var_res_hinnerk3, Media = _XvRtp}
        }, function(action)
          qry_HinnerkDrink.Choices = DrinkOptions()
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(qry_HinnerkDrink)
          end)
        end)
      end
    end
  })
end
function _LTJ0:On_znmj(target)
  _Urwigo.MessageBox({
    Text = var_res_oma1,
    Media = _QsW0N,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {Text = var_res_oma2, Media = _4A7Z},
          {Text = var_res_oma3, Media = _QsW0N}
        }, function(action)
          qry_OmaCandy.Choices = CandyOptions()
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(qry_OmaCandy)
          end)
        end)
      end
    end
  })
end
function _i14yj:On_E3F(target)
  _Urwigo.MessageBox({
    Text = var_res_erna1,
    Media = _T1vz,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {Text = var_res_erna2, Media = _4A7Z},
          {Text = var_res_erna3, Media = _T1vz}
        }, function(action)
          qry_ErnaCandy.Choices = CandyOptions()
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(qry_ErnaCandy)
          end)
        end)
      end
    end
  })
end
function _lQTt:On_cc66L(target)
  _Urwigo.MessageBox({
    Text = var_res_julia1,
    Media = _b8cP,
    Callback = function(action)
      if action ~= nil then
        _Urwigo.Dialog(false, {
          {Text = var_res_julia2, Media = _4A7Z},
          {Text = var_res_julia3, Media = _b8cP}
        }, function(action)
          qry_JuliaDrink.Choices = DrinkOptions()
          _Urwigo.RunDialogs(function()
            Wherigo.GetInput(qry_JuliaDrink)
          end)
        end)
      end
    end
  })
end
function item_token1:On_tqHt(target)
  item_token1:MoveTo(nil)
  TakeToken(1)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function item_wallet:Onevent_countContent(target)
  _Urwigo.Dialog(false, {
    {
      Text = ((((((((var_res_TokenPlural .. _rZ_("S\018")) .. var_TokenCount) .. var_nl) .. var_res_CoinPlural) .. _rZ_("S\018")) .. var_CoinCount) .. var_nl) .. var_nl) .. var_res_CoinsTokesUseFor
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function item_machineCoords:On_Q2NWR(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_jjBsc)
  end)
end
function item_machineCoords:On_2n6(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_VRnq)
  end)
end
function _lL7kn:On_Jql6(target)
  var_CoinCount = var_CoinCount + 2
  Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
end
function _lL7kn:On_qtv(target)
  _Urwigo.MessageBox({
    Text = (((((_rZ_("J\127\016mOmz<\026\018eml1zOS") .. var_nl) .. UnvisitedZoneList(21)) .. var_nl) .. _rZ_("_mOmz<\026\018eml1zOS")) .. var_nl) .. VisitedZoneList()
  })
end
function _lL7kn:On_ssJl(target)
  var_TokenCount = var_TokenCount + 5
end
function _lL7kn:On_KveuG(target)
  item_beer:MoveTo(Player)
end
function _lL7kn:On_pUQe(target)
  item_limo:MoveTo(Player)
end
function _lL7kn:On_FzY2B(target)
  item_kluten:MoveTo(Player)
end
function _lL7kn:On_Ux9V_(target)
  item_babbeler:MoveTo(Player)
end
function item_machineDrinks:On_zYAH(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_BOTu)
  end)
end
function item_machineCandy:On_zy1(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_F4Iuo)
  end)
end
function item_coin:On_ces(target)
  var_CoinCount = var_CoinCount + 1
  item_coin:MoveTo(nil)
  var_cartridge:RequestSync()
  _Urwigo.OldDialog({
    {
      Text = ((((((((var_res_CoinInWallet .. var_nl) .. var_nl) .. var_res_TokenPlural) .. _rZ_("S\018")) .. var_TokenCount) .. var_nl) .. var_res_CoinPlural) .. _rZ_("S\018")) .. var_CoinCount,
      Media = _rJsT
    }
  })
end
function item_manual:On_HMPKr(target)
  _Urwigo.OldDialog({
    {
      Text = (((((((((((((var_res_ManualCoords1 .. var_nl) .. var_nl) .. var_RequireWherigo) .. var_res_CoordsValidate2) .. _rZ_("^1<\015mlo")) .. var_res_CoordsValidate3) .. var_nl) .. var_RequireBonus) .. var_res_CoordsValidate2) .. _rZ_("7o\127\005O")) .. var_res_CoordsValidate3) .. var_nl) .. var_nl) .. var_res_ManualCoords2,
      Media = _DY_
    }
  })
end
function item_manual:On_LhfG3(target)
  _Urwigo.OldDialog({
    {Text = var_res_ManualMap, Media = _oR3qR}
  })
end
function item_manual:On_E6tI(target)
  _Urwigo.OldDialog({
    {Text = var_res_ManualPersons, Media = _W6PC}
  })
end
function item_manual:On_ofL(target)
  _Urwigo.OldDialog({
    {Text = var_res_ManualCoins, Media = _C0F1}
  })
end
function item_token2:On_QGgg9(target)
  item_token2:MoveTo(nil)
  TakeToken(2)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _roJ:On_uFa6(target)
  _roJ:MoveTo(nil)
  TakeToken(3)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _fYQ7:On_ousJ(target)
  _fYQ7:MoveTo(nil)
  TakeToken(4)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _XEf:On_fZ_(target)
  _XEf:MoveTo(nil)
  TakeToken(5)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _13fID:On_Et4(target)
  _13fID:MoveTo(nil)
  TakeToken(6)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _dHaD:On_8Cx(target)
  _dHaD:MoveTo(nil)
  TakeToken(7)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _klWw:On_Hfl(target)
  _klWw:MoveTo(nil)
  TakeToken(8)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _m8DPu:On_ldrHv(target)
  _m8DPu:MoveTo(nil)
  TakeToken(9)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _BfvX:On_bat(target)
  _BfvX:MoveTo(nil)
  TakeToken(10)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _i1Sq:On_GeG3b(target)
  _i1Sq:MoveTo(nil)
  TakeToken(11)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _iOh7:On_zmn(target)
  _iOh7:MoveTo(nil)
  TakeToken(12)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _9P6:On_mTf(target)
  _9P6:MoveTo(nil)
  TakeToken(13)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _J0Gf:On_xdhVy(target)
  _J0Gf:MoveTo(nil)
  TakeToken(14)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _rhHz:On_9nX9(target)
  _rhHz:MoveTo(nil)
  TakeToken(15)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _U2ZX:On_GD6(target)
  _U2ZX:MoveTo(nil)
  TakeToken(16)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _dgBO8:On_Gsqre(target)
  _dgBO8:MoveTo(nil)
  TakeToken(17)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _taS7l:On_pyf_(target)
  _taS7l:MoveTo(nil)
  TakeToken(18)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _haZiR:On_32K(target)
  _haZiR:MoveTo(nil)
  TakeToken(19)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _fvy:On_DKHaQ(target)
  _fvy:MoveTo(nil)
  TakeToken(20)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function _G5LB1:On_21f(target)
  _G5LB1:MoveTo(nil)
  TakeToken(21)
  _Urwigo.OldDialog({
    {
      Text = tostring(WalletResult()),
      Media = _rJsT
    }
  })
end
function item_notes:On_GLe(target)
  _Urwigo.MessageBox({
    Text = (((((var_nl .. var_res_VisitedSights) .. _rZ_("\018P")) .. VisitedZoneCount()) .. _rZ_("-")) .. var_nl) .. VisitedZoneList()
  })
end
function _Urwigo.GlobalZoneEnter()
  if Wherigo.NoCaseEquals(Env.Platform, _rZ_("_<\127\026o\015\018p\018N\017!I")) then
    Wherigo.PlayAudio(_wTGG)
  else
    Wherigo.PlayAudio(_YL3)
  end
  if _G[CurrZone] == zone_automatenStation then
  else
    var_CurrentZoneName = _G[CurrZone].Name
    VisitZone()
    if _G[CurrZone].Visible == false then
      do
        local _rndChoiceValue = math.random()
        if _rndChoiceValue < 0.25 then
          item_coin:MoveTo(_G[CurrZone])
        else
        end
        local _rndChoiceValue = math.random()
        if _rndChoiceValue < 0.1 then
          if _WlRH == false then
            _cTe_f:MoveTo(_G[CurrZone])
            _WlRH = true
            PersonInZone("Hinnerk")
          end
        elseif _rndChoiceValue < 0.2 then
          if _A0n == false then
            _LTJ0:MoveTo(_G[CurrZone])
            _A0n = true
            PersonInZone("Oma Kaethe")
          end
        elseif _rndChoiceValue < 0.3 then
          if _XWh == false then
            _i14yj:MoveTo(_G[CurrZone])
            _XWh = true
            PersonInZone("Klein Erna")
          end
        elseif _rndChoiceValue < 0.4 and _Eil == false then
          _lQTt:MoveTo(_G[CurrZone])
          _Eil = true
          PersonInZone("Julia")
        end
      end
    else
    end
    _G[CurrZone].Visible = true
  end
end
function _H8CGA()
  if Wherigo.NoCaseEquals(var_language, _rZ_("<\127")) then
    item_wallet.Commands.event_countContent.Text = _rZ_("{o\005\127z\018{o\127z<\127z")
    item_coin.Commands._ces.Text = _rZ_("h\005z\018Lom\127\018m\127\018gftt<z")
    item_machineDrinks.Commands._zYAH.Text = _rZ_("7\005\t")
    item_machineCandy.Commands._zy1.Text = _rZ_("7\005\t")
    item_machineCoords.Commands._Q2NWR.Text = _rZ_("^1<\015mlo\018Loo\015\026m\127fz<O")
    item_machineCoords.Commands._2n6.Text = _rZ_("7o\127\005O\018Loo\015\026m\127fz<O")
    item_manual.Commands._HMPKr.Text = _rZ_("8o\014<\127OG{oo\015\026m\127fz<O")
    item_manual.Commands._ofL.Text = _rZ_("{om\127O")
    item_manual.Commands._LhfG3.Text = _rZ_("=og\018\026o\018\v\018O<<\014\"")
    item_manual.Commands._E6tI.Text = _rZ_("=<t>\018\001\015oE\018><\026<Oz\015mf\127O")
    item_notes.Commands._GLe.Text = _rZ_("e1og")
    _cTe_f.Commands._RydM.Text = _rZ_("8ft\014\018zo")
    _lQTt.Commands._cc66L.Text = _rZ_("8ft\014\018zo")
    _i14yj.Commands._E3F.Text = _rZ_("8ft\014\018zo")
    _LTJ0.Commands._znmj.Text = _rZ_("8ft\014\018zo")
    _F4Iuo.Text = _rZ_("ht<fO<\018\015<f\026\018z1<\018\127\005E,<\015\018Lo\026<\018\001\015oE\018z1<\018Lf\127\026\t\018EfL1m\127<\018P\015ml1z\018,o\030-\018f\127\026\018<\127z<\015\018mzU")
    qry_BuyCandy.Text = _rZ_("^1fz\018\026o\018\to\005\018tm\014<\018zo\018,\005\t\"97\017`\006t\005z<\127\018LoOzO\018v\018Lom\127O\018f\127\026\018f\0187f,,<t<\015\018LoOzO\018p\018Lom\127U")
    _BOTu.Text = _rZ_("ht<fO<\018\015<f\026\018z1<\018\127\005E,<\015\018Lo\026<\018\001\015oE\018z1<\018\026\015m\127\014\018EfL1m\127<\018Pt<\001z\018,o\030-\018f\127\026\018<\127z<\015\018mz")
    qry_BuyDrink.Text = _rZ_("^1fz\018\026o\018\to\005\018tm\014<\018zo\018,\005\t\"97\017`7<<\015\018LoOzO\018v\018Lom\127O\018f\127\026\018[<Eo\127f\026<\018LoOzO\018p\018Lom\127U")
    _VRnq.Text = _rZ_("ht<fO<\018\015<f\026\018z1<\018\127\005E,<\015\018Lo\026<\018\001\015oE\018z1<\018Loo\015\026m\127fz<O\018EfL1m\127<\018PEm\026\026t<\018,o\030-\018f\127\026\018<\127z<\015\018mz")
    _jjBsc.Text = _rZ_("ht<fO<\018\015<f\026\018z1<\018\127\005E,<\015\018Lo\026<\018\001\015oE\018z1<\018Loo\015\026m\127fz<O\018EfL1m\127<\018PEm\026\026t<\018,o\030-\018f\127\026\018<\127z<\015\018mz")
    qry_HinnerkDrink.Text = _rZ_("^1fz\018\026o\018\to\005\018o\001\001<\015\"")
    qry_JuliaDrink.Text = _rZ_("^1fz\018\026o\018\to\005\018o\001\001<\015\"")
    qry_ErnaCandy.Text = _rZ_("^1fz\018\026o\018\to\005\018o\001\001<\015\"")
    qry_OmaCandy.Text = _rZ_("^1fz\018\026o\018\to\005\018o\001\001<\015\"")
    _J0Gf.Commands._xdhVy.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    item_token1.Commands._tqHt.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _fvy.Commands._DKHaQ.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _rhHz.Commands._9nX9.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _taS7l.Commands._pyf_.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _9P6.Commands._mTf.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _U2ZX.Commands._GD6.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    item_token2.Commands._QGgg9.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _G5LB1.Commands._21f.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _dgBO8.Commands._Gsqre.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _haZiR.Commands._32K.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _roJ.Commands._uFa6.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _BfvX.Commands._bat.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _i1Sq.Commands._GeG3b.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _XEf.Commands._fZ_.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _iOh7.Commands._zmn.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _m8DPu.Commands._ldrHv.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _13fID.Commands._Et4.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _dHaD.Commands._8Cx.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _fYQ7.Commands._ousJ.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
    _klWw.Commands._Hfl.Text = _rZ_("h\005z\018zo\014<\127\018m\127\018gftt<z")
  else
  end
end
NL = "<BR>\n"
zones = {}
tokenZones = {}
visitZones = {}
hintZones = {}
personZones = {}
function Init()
  zones[1] = zone_sight1
  zones[2] = zone_sight2
  zones[3] = zone_sight3
  zones[4] = zone_sight4
  zones[5] = zone_sight5
  zones[6] = zone_sight6
  zones[7] = zone_sight7
  zones[8] = zone_sight8
  zones[9] = zone_sight9
  zones[10] = zone_sight10
  zones[11] = zone_sight11
  zones[12] = zone_sight12
  zones[13] = zone_sight13
  zones[14] = zone_sight14
  zones[15] = zone_sight15
  zones[16] = zone_sight16
  zones[17] = zone_sight17
  zones[18] = zone_sight18
  zones[19] = zone_sight19
  zones[20] = zone_sight20
  zones[21] = zone_sight21
  for i = 1, #zones do
    tokenZones[i] = false
    visitZones[i] = false
    hintZones[i] = false
    personZones[i] = ""
  end
end
function GetZoneIndexByName(zoneName)
  for i = 1, #zones do
    if zones[i].Name == zoneName then
      return i
    end
  end
  return 0
end
function VisitZone()
  visitZones[GetZoneIndexByName(var_CurrentZoneName)] = true
  local intCount = 0
  for i = 1, #zones do
    if visitZones[i] == true then
      intCount = intCount + 1
    end
  end
end
function PersonInZone(name)
  personZones[GetZoneIndexByName(var_CurrentZoneName)] = name
end
function TakeToken(zoneIndex)
  tokenZones[zoneIndex] = true
  var_TokenCount = var_TokenCount + 1
end
function TookToken()
  return tokenZones[GetZoneIndexByName(var_CurrentZoneName)]
end
function WalletResult()
  return var_res_TokenInWallet .. var_nl .. var_nl .. var_res_TokenPlural .. ":" .. var_TokenCount .. var_nl .. var_res_CoinPlural .. ":" .. var_CoinCount
end
function FullZoneList()
  local out = ""
  for i = 1, #zones do
    out = out .. "- " .. zones[i].Name .. NL
  end
  return out
end
function UnvisitedZoneList(suggestCount)
  local out = ""
  local intCount = 0
  local zoneName = ""
  for i = 1, #zones do
    zoneName = zones[i].Name
    if visitZones[i] == false and suggestCount > intCount then
      intCount = intCount + 1
      out = out .. "- " .. zones[i].Name .. NL
    end
  end
  return out
end
function VisitedZoneCount()
  local intCount = 0
  for i = 1, #zones do
    if visitZones[i] == true then
      intCount = intCount + 1
    end
  end
  return intCount
end
function VisitedZoneList()
  local out = ""
  local intCount = 0
  local zoneName = ""
  for i = 1, #zones do
    zoneName = zones[i].Name
    if visitZones[i] == true then
      intCount = intCount + 1
      out = out .. "- " .. zones[i].Name
      if personZones[i] ~= "" or tokenZones[i] == false then
        out = out .. " ("
        if personZones[i] ~= "" then
          out = out .. personZones[i]
        end
        if tokenZones[i] == false then
          if personZones[i] ~= "" then
            out = out .. " + "
          end
          out = out .. "Token"
        end
        out = out .. ")"
      end
      out = out .. NL
    end
  end
  if out == "" then
    out = "- " .. var_res_None .. " -"
  end
  return out
end
function HintZoneList(suggestCount)
  local out = ""
  local intCount = 0
  local zoneName = ""
  for i = 1, #zones do
    zoneName = zones[i].Name
    if visitZones[i] == false and hintZones[i] == false and suggestCount > intCount then
      intCount = intCount + 1
      out = out .. "- " .. zones[i].Name .. NL
      hintZones[i] = true
    end
  end
  if intCount == 0 then
    out = out .. var_res_DontKnowAny .. NL
  end
  return out
end
function ActivateDeactivateZones(max_active)
  local index = 0
  local object
  local distances = {}
  for index = 1, #zones do
    object = zones[index]
    if object ~= nil then
      local d, b = Wherigo.VectorToPoint(object.OriginalPoint, Player.ObjectLocation)
      local dn = d:GetValue("m")
      object.distance2player = dn
      table.insert(distances, dn)
    end
  end
  table.sort(distances)
  if max_active > #distances then
    max_active = #distances
  end
  ActivateDeactivateZonesDistance(distances[max_active])
end
function ActivateDeactivateZonesDistance(distance)
  local index = 0
  local object
  local distances = {}
  for index = 1, #zones do
    object = zones[index]
    if object ~= nil then
      if distance >= object.distance2player then
        object.Active = true
      else
        object.Active = false
      end
    end
  end
end
function InitResources(lang)
  var_nl = NL
  if lang == "en" then
    zone_automatenStation.Name = "Machine Station"
    zone_automatenStation.Description = "Here are machines where you can insert coins or tokens."
    zone_sight1.Description = "Underground collection box. When a coin is added, you hear one of the Bremen Town Musicians thanking you. The money goes to the Wilhelm Kaisen charity. The sounds of a crowing cock, a cat's miaow, a barking dog and the loud hee-haw of a donkey can be heard to emanate from the pavement right in front of the State Parliament on the market square."
    zone_sight2.Description = "Built in the 1920s, this fascinating 110 metre-long lane houses shops and restaurants, museums, workshops and a carillon. The name Boettcherstrasse derives from the coopers (boettcher) who used to live and work there. Today, this narrow lane is home to arts and craft shops and studios. At the start of the 20th century, Ludwig Roselius, a local coffee merchant, began to buy up all the houses in the dilapidated street. The carillon consists of 30 Meissen porcelain bells. The revolving tower features ten carved wooden panels depicting various Atlantic crossings."
    zone_sight3.Description = "The Lloyd Passage shopping arcade has the inofficial name 'Mall of Fame'. You can spot the hand prints of several German celebrities."
    zone_sight4.Description = "To the west of the town hall stands the most famous representation of the Bremen Town Musicians, the bronze sculpture created in 1951 by the artist Gerhard Marcks."
    zone_sight5.Description = "Bremen's 'statue of liberty' - a symbol of trading rights and freedom since 1404. Germany's largest Roland statue. Together with Bremen's town hall, the statue received World Heritage status on 2 June 2004."
    zone_sight6.Description = "The monument, consisting of the swineherd, his dog and his herd with five pigs and four piglets, was made in 1974 according to a design by the Bremen sculptor Peter Lehmann (1921-1995) made of bronze. The very popular group of sculptures was financed by the merchants of Soegestrasse. It stands for the origin of the name Soegestrasse: The current pedestrian zone Soegestrasse was in the Middle Ages as Soghestrate the street on which probably many pigsties were."
    zone_sight7.Description = "The stone in the cobbles of cathedral square is a reminder of the public execution of the infamous poisoner Gesche Gottfried. This stone was set into the pavement of Domshof square to mark the spot where Gesche Gottfried was executed. The spitting stone allows locals to convey their disgust for the notorious poisoner to this day. Between 1813 and 1828, Gesche Gottfried murdered a total of 15 people with arsenic. Her motives remain the subject of speculation. On 21 April 1831, she was executed in Domshof square ? the last public execution in Bremen."
    zone_sight8.Description = "Splendid Renaissance exterior. Built in 1586/88 by Lueder von Bentheim, rebuilt after the war. Home to the Guenter Grass foundation and German Philharmonic Chamber Orchestra. The former municipal weigh house (Stadtwaage) dating from 1587 was destroyed on 6 October 1944 in one of the many wartime air raids on Bremen. The building, designed by Lueder von Bentheim, was gutted by fire, the upper part of its ornate gable collapsed and the structure across the back was completely destroyed ? all that remained was a U-shaped ruin."
    zone_sight9.Description = "Bremen former merchants' guildhouse, now the chamber of commerce. Built in 1537/38 in the Flanders Renaissance style. It was built in 1537/38 by Johann den Buschener in the style of the Renaissance buildings of Flanders. During decorative refurbishment of the front of the building facing the market in 1594, the merchants' coat of arms was added above the entrance, next to that of the city of Bremen."
    zone_sight10.Description = "Mill dating back over a century in Wallanlagen Park. Open to visitors, also houses a restaurant. If you are strolling from the main station to the city centre, the first notable feature you come across is the windmill in Wallanlagen Park. This is a great place for a walk, or simply to wind down and relax."
    zone_sight11.Description = "Built between 1405 and 1410 with a Weser Renaissance facade added in the 17th century. One of Germany's most beautiful town halls. UNESCO World heritage site."
    zone_sight12.Description = "Bremen's oldest district, the Schnoor quarter, is a maze of lanes lined with little 15th and 16th century houses. Pretty little half-timbered houses dating back to the 15th and 16th centuries, with narrow lanes between the rows of buildings. The name of the quarter may allude to the fact that the houses are lined up like pearls on a string, Schnoor being Low German for Schnur (string). Another interpretation of the name is that this part of the old fishermen's quarter, right by the river Weser, was where the rope makers used to live. Visitors can browse for arts and crafts and handmade gold, rest their legs in one of the many caf?s and restaurants or buy a souvenir to take home. "
    zone_sight13.Description = "A real gem on Ansgariikirchhof square. The historical Gewerbehaus with its magnificent exterior is the seat of the chamber of skilled trades. It is used, among other things, as a venue for talks and events."
    zone_sight14.Description = "Green Sails and the magic of Joe Cockers 'Sail away' ? that?s the story of the famous squarerigger 'Alexander von Humboldt'. "
    zone_sight15.Description = "The most impressive of Bremen's courthouses is the heritage-listed Altes Gerichtshaus, which is richly adorned with allegorical decorations. Justice has been dispensed in this building with ist striking towers since 1895."
    zone_sight16.Description = "Die Glocke has been a prestigious part of Bremen's music scene for more than 75 years and is renowned for ist excellent acoustics and amazing atmosphere."
    zone_sight17.Description = "Collection of paintings/sculptures dating from the 14th century through to the present day. One of Europe?s largest collections of etchings, German and French impressionists, major touring exhibitions."
    zone_sight18.Description = "Accompany some of Bremen's famous names on an entertaining journey through the city's past at the always exciting House of History. Some of the city's more colourful historical characters are played by costumed actors, so you can get all the gossip from Fish Lucie from the market or hear Heini Holtenbeen's latest anecdotes."
    zone_sight19.Description = "A bronze replica of the Loriot sofa, well-known in Germany from the Loriot television series, commemorates the successful collaboration between comic Vicco von Buelow, aka 'Loriot', and broadcaster Radio Bremen."
    zone_sight20.Description = "Cathedral music highlights - choral and orchestral recitals of well-known passions, oratorios, symphonic and chamber works."
    zone_sight21.Description = "Church that doubles as a cultural exhibition. Built in 1139, destroyed in 1944 and rebuilt in 1950 with Beckerath organ and Mitzlaff windows. St. Stephen's Church, dating from 1139, was completely destroyed during the Second World War and rebuilt in 1950. Its overall appearance is dominated by a Beckerath organ and a window by the artist Mitzlaff."
    item_coin.Name = "Coin"
    item_wallet.Name = "Wallet"
    item_wallet.Description = "Here you collect coins and tokens"
    item_machineCoords.Name = "Coordinates machine"
    item_machineCoords.Description = "Here you can get coordinates. You keep the tokens"
    item_machineCandy.Name = "Candy machine"
    item_machineDrinks.Description = "Here you can buy candy"
    item_machineDrinks.Name = "Drinks machine"
    item_machineDrinks.Description = "Here you can buy drinks"
    item_coordsWherigo.Name = "Wherigo coordinates"
    item_coordsWherigo.Description = var_CodeWherigo
    item_coordsBonus.Name = "Bonus coordinates"
    item_coordsBonus.Description = var_CodeBonus
    item_limo.Name = "Lemonade"
    item_limo.Description = "The famous GC-Lemonade"
    item_beer.Name = "Beer"
    item_beer.Description = "Traditional Beer of Bremen"
    item_manual.Name = "Manual"
    item_babbeler.Description = "Typical Lollipop of Bremen"
    item_kluten.Description = "Typical Candy of Bremen"
    item_notes.Name = "Notes"
    qry_BuyDrink.Choices = {"Beer", "Lemonade"}
    var_res_CoinSingular = "Coin"
    var_res_CoinPlural = "Coins"
    var_res_CoinsTokesUseFor = "You can use tokens at the coordinate machine and coins to pay at the drink or candy machine."
    var_res_CoinInWallet = "You put the coin in the wallet"
    var_res_TokenInWallet = "You put the token in the wallet"
    var_res_TokensNeeded = " Tokens needed"
    var_res_CoordsValidate1 = "You need at least "
    var_res_CoordsValidate2 = " tokens for the "
    var_res_CoordsValidate3 = " coordinates!"
    var_res_CoordsSuccess1 = "Congratluations!" .. NL .. "The machine spits out a paper with the coordinates for the "
    var_res_CoordsSuccess2 = "-Cache!"
    var_res_WhatToBuy = "What do you like to buy?"
    var_res_WhatToOffer = "What do you offer?"
    var_res_NotEnoughCoins = "Not enough coins!"
    var_res_Nothing = "Nothing"
    var_res_None = "None"
    var_res_VisitedSights = "Visited Sights:"
    var_res_ManualCoords1 = "To get Coordinates you need to collect tokens:"
    var_res_ManualCoords2 = "You will find a token on each new sight you explore." .. NL .. "The coordinates machine at the machine station will give you coordinates depending the number of tokens are collected."
    var_res_ManualMap = "All sights are located in the City Center of Bremen inside the area between the water of the 'Wallanlagen' and the river Weser." .. NL .. "If you find a sight, you here a sound and the zone appears."
    var_res_ManualPersons = "If you are lucky, you will meet persons at some sights. They might help you finding some of the hidden sights. But they don't help you for free ..."
    var_res_ManualCoins = "From time to time you'll find coins at a sight." .. NL .. "With these you can buy drinks or candy at the machine station."
    var_res_hinnerk1 = "Hi there, how are you doing?"
    var_res_hinnerk2 = "Hi!" .. NL .. "Can you help me finding some sights? You know this area, right?"
    var_res_hinnerk3 = "Maybe. Do you have anything to drink?"
    var_res_hinnerk4a = "Here is a beer!"
    var_res_hinnerk4b = "Here is lemonade!"
    var_res_hinnerk4c = "I don't support drinkng, so I will seek on my own!"
    var_res_hinnerk5a = "Thanks!" .. NL .. "Do you know these sights already?" .. NL .. NL
    var_res_hinnerk5b = "He crashes the bottle on the floor!" .. NL .. "A lemonade - what the f**k!"
    var_res_julia1 = "Oh, hi there!"
    var_res_julia2 = "Hello young lady!" .. NL .. "Can you help me finding some sights? You know this area, right?"
    var_res_julia3 = "Oh, I'm exhausted. Do you have anything to drink?"
    var_res_julia4a = "Here is a beer!"
    var_res_julia4b = "Here is lemonade!"
    var_res_julia4c = "Sorry - no! So I will seek on my own!"
    var_res_julia5a = "Bah, do you want to poison me?"
    var_res_julia5b = "Thank you!" .. NL .. "Do you know these sights already:" .. NL .. NL
    var_res_erna1 = "Hello"
    var_res_erna2 = "Hello little darling!" .. NL .. "Do you know this area? Can you help me finding some sights?"
    var_res_erna3 = "Hmm, I shouldn't talk to strangers."
    var_res_erna4a = "Here are some Bremer Kluten!"
    var_res_erna4b = "Here is a Babbeler!"
    var_res_erna4c = "But I'm kind. Please give me a hint?"
    var_res_erna5a = "And I shouldn't take candy from a stranger. Goody bye!"
    var_res_erna5b = "And I shouldn't take candy from a stranger. Goody bye!"
    var_res_erna5c = "Ok!" .. NL .. "My favourite place is this one:" .. NL .. NL
    var_res_erna6c = "I need to go - bye!"
    var_res_oma1 = "Hello young fellow!"
    var_res_oma2 = "Hello!" .. NL .. "Can you help me finding some sights?"
    var_res_oma3 = "Maybe! Do you have some sweets?"
    var_res_oma4a = "Here are some Bremer Kluten"
    var_res_oma4b = "Here is a Babbeler!"
    var_res_oma4c = "Sorry - no! So I will seek on my own!"
    var_res_oma5a = "Thank you!" .. NL .. "Do you know these sights already:" .. NL .. NL
    var_res_oma5b = "Thank you!" .. NL .. "Do you know this sight already:" .. NL .. NL
    var_res_KeyNotValid = "Code not valid!"
    var_res_ZoneHint = "Starts with '.x.' and is about .y. meters away in .z. degrees"
    var_res_ThenInsertCoordinates = "Then feed them to the Coordinates Machine at the Machine Station"
    var_res_DontKnowAny = "You've found all sights already!"
    task_wherigo.Name = "Find " .. var_RequireWherigo .. " Token for Wherigo Coordinates"
    task_wherigo.Description = var_RequireWherigo .. var_res_TokensNeeded .. "." .. var_res_ThenInsertCoordinates
    task_bonus.Name = "Find " .. var_RequireBonus .. " Token for Bonus Coordinates"
    task_bonus.Description = var_RequireBonus .. var_res_TokensNeeded .. "." .. var_res_ThenInsertCoordinates
  else
    zone_sight1.Description = "Hahnenschreie, Maunzen, Bellen und ein lautes IA - so klingt es aus einem Gully-Deckel direkt vor der Bremer Buergerschaft am Bremer Marktplatz. Mit dem 'Gesang' der Bremer Stadtmusikanten wird belohnt, wer eine Muenze in den Gully wirft. Denn dahinter verbirgt sich eine ungewoehnliche Spendenbox. Die Muenzen kommen der Wilhelm-Kaisen-Buergerhilfe zu Gute, die damit Projekte fuer die Menschen in der Stadt unterstuetzt. Also, schnell ein paar Muenzen vorgekramt und die Stadtmusikanten zum Singen gebracht."
    zone_sight2.Description = "Zwischen 1922 und 1931 erbaute Ludwig Roselius, Kaffeekaufmann und Erfinder koffeinfreien Kaffees, die Boettcherstrasse. Als heimliche Hauptstrasse der Stadt beheimatet sie nicht nur ein einzigartiges und weltberuehmtes Gebaeudeensemble aus Backsteinarchitektur. Mit dem Ludwig Roselius Museum und dem Paula Modersohn-Becker Museum zaehlt die Boettcherstrasse auch zu den kulturellen Highlights der Stadt. Glockenspiel aus 30 Meissener Porzellanglocken. Im drehbaren Turm werden 10 holzgeschnitzte Tafeln mit Darstellungen der Ozeanueberquerer gezeigt."
    zone_sight3.Description = "Mall of Fame ist der inoffizielle Name einer Fussgaengerzone in Bremen. Sie verlaeuft unter dem Glasdach der 250 Meter langen Lloyd-Passage im Zentrum der Hansestadt. Seit 2003 werden im Granitboden die Handabdruecke verschiedener Prominenter eingelassen, die einen Bezug zur Freien Hansestadt Bremen besitzen oder sich um die Stadt verdient gemacht haben."
    zone_sight4.Description = "Das wohl bekannteste Wahrzeichen der Hansestadt sind die Bremer Stadtmusikanten. Eine Bronzestatue von Gerhard Marcks erinnert seit 1953 an der linken Seite des Rathauses an das beliebte Maerchen der Brueder Grimm. Esel, Hund, Katze und Hahn machten sich der Geschichte nach einst auf in die Stadt an der Weser, um hier ein besseres Leben zu finden."
    zone_sight5.Description = "1404 entstand der steinerne Roland vor dem aRathaus. Er war von Anfang an eine Symbolfigur fuer die 'Freiheiten' und Rechte der Stadt."
    zone_sight6.Description = "Das Denkmal, bestehend aus dem Schweinehirten, seinem Hund und seiner Herde mit fuenf Schweinen und vier Ferkeln, wurde 1974 nach einem Entwurf des Bremer Bildhauers Peter Lehmann (1921?1995) aus Bronze gefertigt. Die sehr beliebte Skulpturengruppe wurde von den Kaufleuten der Soegestrasse finanziert. Sie steht fuer die Herkunft des Namens Soegestrasse: Die heutige Fussgaengerzone Soegestrasse war im Mittelalter als Soghestrate (Plattdeutsch fuer Sauen) die Strasse, an der wahrscheinlich viele Schweinestaelle standen. "
    zone_sight7.Description = "Der 'Spuckstein' ist ein unscheinbares dunkles Steinquadrat, das in das Pflaster des Domshofes eingelassen wurde. Seine Geschichte ist umso spannender: Der Stein erinnert an die legendaere Moerderin Gesche Gottfried, die 15 Menschen mit Arsen vergiftete. Er markiert die Stelle, an der ihr am 21. April 1831 der Kopf abgeschlagen wurde. Aus Abscheu ueber ihre Verbrechen spucken die Bremerinnen und Bremer bis heute gern im Vorbeigehen auf den Stein."
    zone_sight8.Description = "Praechtige Renaissance-Fassade von Lueder von Bentheim 1586/88 gebaut, nach dem Krieg durch die Sparkasse Bremen wieder errichtet. Sitz der Guenther-Grass-Stiftung und Deutschen Kammerphilharmonie Bremen. Die einstige staedtische Waage von 1587 wurde beim 137. Luftangriff auf Bremen am 6. Oktober 1944 jaeh zerstoert. Lueder von Bentheims Stadtwaage brannte vollstaendig aus, der obere Teil des Prachtgiebels stuerzte ein, der Querbau an der Rueckseite wurde komplett zerstoert - es blieb lediglich eine U-foermige Ruine zurueck."
    zone_sight9.Description = "Das Haus Schuetting ist traditionell der Sitz der Kaufmannschaft, der Sitz der Handelskammer, und wurde 1537/38 im Stil der Renaissancebauten Flanderns errichtet."
    zone_sight10.Description = "Kommen Besucherinnen und Besucher erstmals vom Bahnhof aus in die Bremer Innenstadt, ueberrascht sie der Anblick der grossen, rund 100 Jahre alten Herdentorswallmuehle inmitten der City. Eingebettet in ein Meer aus saisonalen Blumen, ist die Muehle in den Wallanlagen eine der meist fotografierten Sehenswuerdigkeiten der Stadt. Wo bis 1950 noch Mehl gemahlen wurde, befindet sich heute ein Caf? und es besteht die Moeglichkeit, das Bauwerk zu besichtigen."
    zone_sight11.Description = "1405-1410 errichtet, im 17. Jahrhundert mit einer Fassade im Stil der Weser-Renaissance versehen. Eines der schoensten Rathaeuser Deutschlands. UNESCO-Welterbe (zusammen mit dem Roland)."
    zone_sight12.Description = "Kleine, schmale Fachwerkhaeuser aus dem 15. und 16. Jahrhundert mit schmalen Gaengen zwischen den gegenueberliegenden Gebaeudereihen. Der Name des Viertels geht darauf zurueck, dass sich die Haeuser aneinanderreihen wie die Perlen an einer Schnur, plattdeutsch 'Schnoor'. Eine andere Interpretation fuehrt die Bezeichnung darauf zurueck, dass in diesem Teil des alten Fischerquartiers die Taumacher wohnten. Im Schnoor schlendern Besucher in unmittelbarer Naehe der Weser zwischen Goldschmiede- und Kunsthandwerk, ruhen sich in einem der zahlreichen Caf?s oder Restaurants aus oder erwerben Mitbringsel aus der Hansestadt."
    zone_sight13.Description = "Das historische Gewerbehaus mit seiner schmucken Fassade ist Sitz der Handwerkskammer. Hier finden z. B. Vortraege und Veranstaltungen statt."
    zone_sight14.Description = "Das beruehmte gruene Segelschiff 'Alexander von Humboldt' liegt seit Anfang 2016 dauerhaft an der Schlachte in Bremen. Bereits seit Mai 2015 ist es im Europahafen als Restaurant- und Hotelschiff in Betrieb."
    zone_sight15.Description = "Das architektonisch und allegorisch auffaelligste Gerichtsgebaeude in Bremen ist das unter Denkmalschutz stehende sogenannte 'Alte Gerichtshaus'. Seit 1895 wird in dem Gebaeude mit den markanten Tuermchen Recht gesprochen."
    zone_sight16.Description = "Die Glocke ist seit ueber 75 Jahren das traditionsreiche Zentrum des Bremer Musiklebens und beruehmt fuer exzellente Akustik und einzigartiges Ambiente."
    zone_sight17.Description = "Meisterwerke aus 600 Jahren: Malerei, Bildhauerei, Druckgrafik, Medienkunst - in der Kunsthalle Bremen haben viele Stilrichtungen ihren Platz."
    zone_sight18.Description = "Mitten im historischen Schnoorviertel steht es: das Bremer Geschichtenhaus. Hier wird Stadtgeschichte lebendig. Darsteller in historischen Kostuemen verkoerpern Bremer Originale. Treffen Sie zum Beispiel auf einen Schnack die Fisch-Lucie vom Marktplatz oder lassen Sie sich von Heini Holtenbeen Anekdoten erzaehlen."
    zone_sight19.Description = "Ein beliebtes Fotomotiv ist das Bronzedenkmal vor dem Eingang des Sendezentrums von Radio Bremen an der Diepenau. Das 2013 aufgestellte Sofa erinnert an den Humoristen Vicco von Buelow, besser bekannt als 'Loriot'. Das originale gruene Loriot-Sofa aus seiner Fernsehserie steht im Foyer von Radio Bremen. Der Mops auf der bronzenen Nachbildung erinnert daran, dass Buelow ein begeisterter Liebhaber dieser Hunderasse war."
    zone_sight20.Description = "Evangelisch-lutherische Kirche mit einer ueber 1.200-jaehrigen Geschichte. Fruehgotisches Gepraege aus der 1. Haelfte des 13. Jahrhunderts. Aelteste Teile sind die Krypten."
    zone_sight21.Description = "Die Kirche zwischen Marktplatz und Ueberseestadt - direkt an der Weserpromenade Schlachte - pflegt den Dialog zwischen Kirche und Kultur. Im zweiten Weltkrieg wurde die 1139 erbaute Kirche St. Stephani vollkommen zerstoert. 1950 wurde sie jedoch wieder aufgebaut. Eine Beckerath-Orgel und Fenster von dem Kuenstler Erhart Mitzlaff praegen ihr Bild."
    task_wherigo.Name = "Finde " .. var_RequireWherigo .. " Token fuer Wherigo Koordinaten"
    task_wherigo.Description = var_RequireWherigo .. var_res_TokensNeeded .. "." .. var_res_ThenInsertCoordinates
    task_bonus.Name = "Finde " .. var_RequireBonus .. " Token fuer Bonus Koordinaten"
    task_bonus.Description = var_RequireBonus .. var_res_TokensNeeded .. "." .. var_res_ThenInsertCoordinates
  end
  var_language = lang
end
function DrinkOptions()
  local opt = {}
  local optCount = 1
  opt[optCount] = var_res_Nothing
  if Player:Contains(item_beer) then
    optCount = optCount + 1
    opt[optCount] = item_beer.Name
  end
  if Player:Contains(item_limo) then
    optCount = optCount + 1
    opt[optCount] = item_limo.Name
  end
  return opt
end
function CandyOptions()
  local opt = {}
  local optCount = 1
  opt[optCount] = var_res_Nothing
  if Player:Contains(item_kluten) then
    optCount = optCount + 1
    opt[optCount] = item_kluten.Name
  end
  if Player:Contains(item_babbeler) then
    optCount = optCount + 1
    opt[optCount] = item_babbeler.Name
  end
  return opt
end
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function Encode(data)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    for i = 8, 1, -1 do
      r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    for i = 1, 6 do
      c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
    end
    return b:sub(c + 1, c + 1)
  end) .. ({
    "",
    "==",
    "="
  })[#data % 3 + 1]
end
function CheckKey(enterValue, correctValue)
  if Encode(enterValue) == correctValue then
    return true
  else
    return false
  end
end
function Round(num, numDecimalPlaces)
  local mult = 10 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
return var_cartridge
