require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _d7gW(str)
  local res = ""
  local dtable = "\fE\005w\019\0018'1\014r!\byI/\0184Rq\02672)}*X\030nZW$\"-t\n^<\\jO\029\027.:JVGop\028c,@56\006`M\r>gS\031C~u\002L\015Af\000\022\021em|Y {\025=\a3z\023Q\004i&N\003\tkHhxF\017]\016(U+#?_D9%a;b[sT\v\020K\024v0lBdP"
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
_yCJ8 = Wherigo.ZCartridge()
_Yf6k = Wherigo.ZMedia(_yCJ8)
_Yf6k.Id = "f0a66194-5648-4665-adf5-e7c691f06a82"
_Yf6k.Name = _d7gW("\0311|Ht>LaLC|")
_Yf6k.Description = _d7gW("0\vCtL|Z>LtP\0311|Ht>LaLC|5P~ptPLtPmZ\vPLZt_p|#P~L\029P\019C4_L\029PaL\vC\029#L\v|pCHL\029P|ptt#,")
_Yf6k.AltText = _d7gW("mCPa1\vt#PLZ\029P\0041|Htp\v#Z>LtP0LaLC|")
_Yf6k.Resources = {
  {
    Type = "mp3",
    Filename = "wolf1_1.mp3",
    Directives = {}
  }
}
_6HUO = Wherigo.ZMedia(_yCJ8)
_6HUO.Id = "e5e24deb-2f6e-4635-9615-37be824d3127"
_6HUO.Name = _d7gW("\015\029t2L_#1\vP;C|~L\vt")
_6HUO.Description = ""
_6HUO.AltText = ""
_6HUO.Resources = {
  {
    Type = "jpg",
    Filename = "cartridge_inspektor_black.jpg",
    Directives = {}
  }
}
_tvu = Wherigo.ZMedia(_yCJ8)
_tvu.Id = "e334a831-710c-4ce4-a378-b842372558d4"
_tvu.Name = _d7gW("\01541\029P\015\029t2L_#1\vP;C|~L\vt")
_tvu.Description = ""
_tvu.AltText = ""
_tvu.Resources = {
  {
    Type = "jpg",
    Filename = "icon_inspektor_black_icon.jpg",
    Directives = {}
  }
}
_Wx_u = Wherigo.ZMedia(_yCJ8)
_Wx_u.Id = "0736a7eb-4c59-4fbd-a5f1-e1345e17796a"
_Wx_u.Name = _d7gW("\0301\029LP0|C#a")
_Wx_u.Description = ""
_Wx_u.AltText = ""
_Wx_u.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Gluth.jpg",
    Directives = {}
  }
}
_Tu1dK = Wherigo.ZMedia(_yCJ8)
_Tu1dK.Id = "1b56278d-bee9-497b-9580-1af93739f011"
_Tu1dK.Name = _d7gW("\0301\029LP`ptt")
_Tu1dK.Description = ""
_Tu1dK.AltText = ""
_Tu1dK.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Hass.jpg",
    Directives = {}
  }
}
_VeJ = Wherigo.ZMedia(_yCJ8)
_VeJ.Id = "a39a9a0c-f553-4875-85f6-542a7352e78f"
_VeJ.Name = _d7gW("\0301\029LP\019p#aapCt")
_VeJ.Description = ""
_VeJ.AltText = ""
_VeJ.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Rathhaus.jpg",
    Directives = {}
  }
}
_mdfiv = Wherigo.ZMedia(_yCJ8)
_mdfiv.Id = "b03a26af-265b-4fb5-9f9f-381cdb7ba5e6"
_mdfiv.Name = _d7gW("\0301\029LP.LtCt")
_mdfiv.Description = ""
_mdfiv.AltText = ""
_mdfiv.Resources = {
  {
    Type = "jpg",
    Filename = "zone_jesus.jpg",
    Directives = {}
  }
}
_8FWf = Wherigo.ZMedia(_yCJ8)
_8FWf.Id = "4f5330f6-10d2-4d22-b037-d0af51cf1871"
_8FWf.Name = _d7gW("\0301\029LPx\vLCV")
_8FWf.Description = ""
_8FWf.AltText = ""
_8FWf.Resources = {
  {
    Type = "jpg",
    Filename = "zone_kreuz.jpg",
    Directives = {}
  }
}
_EUk = Wherigo.ZMedia(_yCJ8)
_EUk.Id = "5fdaa663-524a-4eab-add4-d5a6d50194eb"
_EUk.Name = _d7gW("\0311|H")
_EUk.Description = ""
_EUk.AltText = ""
_EUk.Resources = {
  {
    Type = "jpg",
    Filename = "wolf_230_130.jpg",
    Directives = {}
  }
}
_UKW = Wherigo.ZMedia(_yCJ8)
_UKW.Id = "56ddc4f9-13aa-40d1-9af3-f89ba495dcaa"
_UKW.Name = _d7gW("\0301\029LPcL\vZL\029\0041a\029C\029>")
_UKW.Description = ""
_UKW.AltText = ""
_UKW.Resources = {
  {
    Type = "jpg",
    Filename = "zone_ferienhaus.jpg",
    Directives = {}
  }
}
_5bC = Wherigo.ZMedia(_yCJ8)
_5bC.Id = "3176b039-86d5-44ca-8111-138a2421e8bd"
_5bC.Name = _d7gW("\01541\029PcL\vZL\029\0041a\029C\029>")
_5bC.Description = ""
_5bC.AltText = ""
_5bC.Resources = {
  {
    Type = "jpg",
    Filename = "icon_ferienhaus.jpg",
    Directives = {}
  }
}
_bqp = Wherigo.ZMedia(_yCJ8)
_bqp.Id = "d7f7533d-e781-43c9-b2ac-ddfdb3f2f447"
_bqp.Name = _d7gW("\01541\029P}\vZb\029L\v")
_bqp.Description = ""
_bqp.AltText = ""
_bqp.Resources = {
  {
    Type = "jpg",
    Filename = "icon_FrauBrixner.jpg",
    Directives = {}
  }
}
_cu3K2 = Wherigo.ZMedia(_yCJ8)
_cu3K2.Id = "6df2e134-7fcc-4c96-8d90-a80c735ea654"
_cu3K2.Name = _d7gW("\01541\029P0pL\v#\029L\v")
_cu3K2.Description = ""
_cu3K2.AltText = ""
_cu3K2.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Gartner.jpg",
    Directives = {}
  }
}
_cCoom = Wherigo.ZMedia(_yCJ8)
_cCoom.Id = "fbb82f28-73e2-4fc2-aa23-899575ac1f67"
_cCoom.Name = _d7gW("\01541\029P?4a\004Lt#L\vP0|C#a")
_cCoom.Description = ""
_cCoom.AltText = ""
_cCoom.Resources = {
  {
    Type = "jpg",
    Filename = "icon_schwester_gluth.jpg",
    Directives = {}
  }
}
_7Z3oo = Wherigo.ZMedia(_yCJ8)
_7Z3oo.Id = "bc25c963-891b-469c-a400-66889b3ad66b"
_7Z3oo.Name = _d7gW("xp\v#LPc\vZL~a1H")
_7Z3oo.Description = ""
_7Z3oo.AltText = ""
_7Z3oo.Resources = {
  {
    Type = "jpg",
    Filename = "plan_friedhof_130.jpg",
    Directives = {}
  }
}
_pKP41 = Wherigo.ZMedia(_yCJ8)
_pKP41.Id = "2d200b84-28fe-40fd-8d02-baa023598230"
_pKP41.Name = _d7gW("}\vZb\029L\vl\tU{")
_pKP41.Description = ""
_pKP41.AltText = ""
_pKP41.Resources = {
  {
    Type = "jpg",
    Filename = "FrauBrixner_130.jpg",
    Directives = {}
  }
}
__ZQRU = Wherigo.ZMedia(_yCJ8)
__ZQRU.Id = "0b798448-8081-4552-bbf5-05b841e5c34f"
__ZQRU.Name = _d7gW("0pL\v#\029L\vl\tU{")
__ZQRU.Description = ""
__ZQRU.AltText = ""
__ZQRU.Resources = {
  {
    Type = "jpg",
    Filename = "Gartner_130.jpg",
    Directives = {}
  }
}
_d4fL5 = Wherigo.ZMedia(_yCJ8)
_d4fL5.Id = "80a041bd-f4e5-4261-9d89-d72f7f94bded"
_d4fL5.Name = _d7gW("?4a\004Lt#L\vl0|C#al\tU{")
_d4fL5.Description = ""
_d4fL5.AltText = ""
_d4fL5.Resources = {
  {
    Type = "jpg",
    Filename = "schwester_gluth_130_1.jpg",
    Directives = {}
  }
}
_5Gt = Wherigo.ZMedia(_yCJ8)
_5Gt.Id = "86c1bcda-2a25-44b6-936c-9a784acfe2cb"
_5Gt.Name = _d7gW("xpHHLL")
_5Gt.Description = ""
_5Gt.AltText = ""
_5Gt.Resources = {
  {
    Type = "jpg",
    Filename = "HeisserKaffee_130.jpg",
    Directives = {}
  }
}
_ST7G = Wherigo.ZMedia(_yCJ8)
_ST7G.Id = "2270cca1-942a-4bec-8153-9cb9d3548315"
_ST7G.Name = _d7gW("\01541\029PxpHHLL")
_ST7G.Description = ""
_ST7G.AltText = ""
_ST7G.Resources = {
  {
    Type = "jpg",
    Filename = "icon_HeisserKaffee.jpg",
    Directives = {}
  }
}
_Xvej = Wherigo.ZMedia(_yCJ8)
_Xvej.Id = "d80a2506-4a0e-4b74-8ce5-606159c4d5fa"
_Xvej.Name = _d7gW(".C\029>tl\tU{")
_Xvej.Description = ""
_Xvej.AltText = ""
_Xvej.Resources = {
  {
    Type = "jpg",
    Filename = "jungs_130_1.jpg",
    Directives = {}
  }
}
_aqb = Wherigo.ZMedia(_yCJ8)
_aqb.Id = "9a89659f-c936-428d-b1f9-4e6179c15bfd"
_aqb.Name = _d7gW("\01541\029\".C\029>t")
_aqb.Description = ""
_aqb.AltText = ""
_aqb.Resources = {
  {
    Type = "jpg",
    Filename = "icon_jungs1.jpg",
    Directives = {}
  }
}
_tjEjL = Wherigo.ZMedia(_yCJ8)
_tjEjL.Id = "c415af3b-07f3-4150-ae07-f0c9862a90fc"
_tjEjL.Name = _d7gW("?4a\vLZ\"0|C#a")
_tjEjL.Description = ""
_tjEjL.AltText = ""
_tjEjL.Resources = {
  {
    Type = "mp3",
    Filename = "gluth.mp3",
    Directives = {}
  }
}
_svS = Wherigo.ZMedia(_yCJ8)
_svS.Id = "ad5aef23-79e0-4d9b-a910-cab1f25e20fd"
_svS.Name = _d7gW("?#ZMML\"`ptt")
_svS.Description = ""
_svS.AltText = ""
_svS.Resources = {
  {
    Type = "mp3",
    Filename = "hass1.mp3",
    Directives = {}
  }
}
_lu5u = Wherigo.ZMedia(_yCJ8)
_lu5u.Id = "94575ace-30d5-407b-8e55-081058d78638"
_lu5u.Name = _d7gW("?#ZMML\"\019p#aapCt")
_lu5u.Description = ""
_lu5u.AltText = ""
_lu5u.Resources = {
  {
    Type = "mp3",
    Filename = "rathhaus1.mp3",
    Directives = {}
  }
}
_RuTDS = Wherigo.ZMedia(_yCJ8)
_RuTDS.Id = "2e28d3aa-1433-48f1-acc0-68ffd96e9f5a"
_RuTDS.Name = _d7gW("cCttpr~\vC4_l\tU{")
_RuTDS.Description = ""
_RuTDS.AltText = ""
_RuTDS.Resources = {
  {
    Type = "jpg",
    Filename = "fussabdruck_130.jpg",
    Directives = {}
  }
}
_88uun = Wherigo.ZMedia(_yCJ8)
_88uun.Id = "1f10acbe-4687-45d9-be70-befd529773c1"
_88uun.Name = _d7gW("\01541\029lcCttpr~\vC4_")
_88uun.Description = ""
_88uun.AltText = ""
_88uun.Resources = {
  {
    Type = "jpg",
    Filename = "icon_fussabdruck_130.jpg",
    Directives = {}
  }
}
_MHFZ = Wherigo.ZMedia(_yCJ8)
_MHFZ.Id = "56959243-3c2c-4b48-be25-e1ff68bc1094"
_MHFZ.Name = _d7gW("?4aMC4_")
_MHFZ.Description = ""
_MHFZ.AltText = ""
_MHFZ.Resources = {
  {
    Type = "jpg",
    Filename = "schmuck_130.jpg",
    Directives = {}
  }
}
_2AsVQ = Wherigo.ZMedia(_yCJ8)
_2AsVQ.Id = "3af310e4-c364-4669-a641-29977195c2b1"
_2AsVQ.Name = _d7gW("?LL|L\029t#LZ\029l\tU{")
_2AsVQ.Description = ""
_2AsVQ.AltText = ""
_2AsVQ.Resources = {
  {
    Type = "jpg",
    Filename = "seelenstein.jpg",
    Directives = {}
  }
}
_7qpxb = Wherigo.ZMedia(_yCJ8)
_7qpxb.Id = "e11b7833-0f49-41ad-a03a-f58f8c4712d2"
_7qpxb.Name = _d7gW("\01541\029l?LL|L\029t#LZ\029")
_7qpxb.Description = ""
_7qpxb.AltText = ""
_7qpxb.Resources = {
  {
    Type = "jpg",
    Filename = "icon_seelenstein.jpg",
    Directives = {}
  }
}
_ud4a = Wherigo.ZMedia(_yCJ8)
_ud4a.Id = "2605d091-51c8-4c93-a62e-053672853079"
_ud4a.Name = _d7gW("\\1#ZVL\029")
_ud4a.Description = ""
_ud4a.AltText = ""
_ud4a.Resources = {
  {
    Type = "jpg",
    Filename = "notes.jpg",
    Directives = {}
  }
}
_D6s = Wherigo.ZMedia(_yCJ8)
_D6s.Id = "6852d632-da0d-4129-b08f-f08c233aae6e"
_D6s.Name = _d7gW("\01541\029l\\1#ZVL\029")
_D6s.Description = ""
_D6s.AltText = ""
_D6s.Resources = {
  {
    Type = "jpg",
    Filename = "icon_notes.jpg",
    Directives = {}
  }
}
_uYxmk = Wherigo.ZMedia(_yCJ8)
_uYxmk.Id = "cf33df4c-24a7-4c36-a3fd-f95a99a8299b"
_uYxmk.Name = _d7gW("\019L>L|\029")
_uYxmk.Description = ""
_uYxmk.AltText = ""
_uYxmk.Resources = {
  {
    Type = "jpg",
    Filename = "regeln.jpg",
    Directives = {}
  }
}
_xJRZm = Wherigo.ZMedia(_yCJ8)
_xJRZm.Id = "bbf37343-c765-4fab-95ad-bf0efdc1b5b0"
_xJRZm.Name = _d7gW("h\029|14_41~L")
_xJRZm.Description = ""
_xJRZm.AltText = ""
_xJRZm.Resources = {
  {
    Type = "jpg",
    Filename = "code.jpg",
    Directives = {}
  }
}
_yEEc = Wherigo.ZMedia(_yCJ8)
_yEEc.Id = "8a195af2-5797-4dc3-8e43-c1cff007ccde"
_yEEc.Name = _d7gW("\01541\029lh\029|14_41~L")
_yEEc.Description = ""
_yEEc.AltText = ""
_yEEc.Resources = {
  {
    Type = "jpg",
    Filename = "icon_code.jpg",
    Directives = {}
  }
}
_aJX = Wherigo.ZMedia(_yCJ8)
_aJX.Id = "5ecfa863-7e8f-4fb5-a7b8-7a6c4fbcbccd"
_aJX.Name = _d7gW("\0301\029Ll0|C#al\019p#L\029")
_aJX.Description = ""
_aJX.AltText = ""
_aJX.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Gluth_ohne_Vornamen.jpg",
    Directives = {}
  }
}
_DF7 = Wherigo.ZMedia(_yCJ8)
_DF7.Id = "2b458111-c3c8-41ec-b718-1b7d7b5865cf"
_DF7.Name = _d7gW("\0301\029Ll`pttl\019p#L\029")
_DF7.Description = ""
_DF7.AltText = ""
_DF7.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Hass_ohne_Datum.jpg",
    Directives = {}
  }
}
__ruD = Wherigo.ZMedia(_yCJ8)
__ruD.Id = "d2f39c7f-4e75-4027-b857-c13fa9e683fb"
__ruD.Name = _d7gW("\0301\029Ll\019p#aapCtl\019p#L\029")
__ruD.Description = ""
__ruD.AltText = ""
__ruD.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Grab_Rathhaus_Raetsel.jpg",
    Directives = {}
  }
}
_eLHa = Wherigo.ZMedia(_yCJ8)
_eLHa.Id = "3db2ddda-5daf-4472-9221-2f018ffd2908"
_eLHa.Name = _d7gW("\0301\029LP\127p\v_2|p#V")
_eLHa.Description = ""
_eLHa.AltText = ""
_eLHa.Resources = {
  {
    Type = "jpg",
    Filename = "zone_Parkplatz.jpg",
    Directives = {}
  }
}
_M7IG = Wherigo.ZMedia(_yCJ8)
_M7IG.Id = "5d7f5cf5-3a4e-4a88-b29a-606ad795f678"
_M7IG.Name = _d7gW("\01541\029l\127p\v_2|p#V")
_M7IG.Description = ""
_M7IG.AltText = ""
_M7IG.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Parkplatz.jpg",
    Directives = {}
  }
}
_ISJJZ = Wherigo.ZMedia(_yCJ8)
_ISJJZ.Id = "00af9b6d-f2a6-40ec-a4de-51da72f7bb8f"
_ISJJZ.Name = _d7gW("\01541\029l\002Z\029>p\029>")
_ISJJZ.Description = ""
_ISJJZ.AltText = ""
_ISJJZ.Resources = {
  {
    Type = "jpg",
    Filename = "icon_eingang1.jpg",
    Directives = {}
  }
}
_8Kz00 = Wherigo.ZMedia(_yCJ8)
_8Kz00.Id = "57a90509-fea3-4dc2-8f5f-da3d703cdd20"
_8Kz00.Name = _d7gW("\0301\029Ll0pL\v#\029L\vLZ")
_8Kz00.Description = ""
_8Kz00.AltText = ""
_8Kz00.Resources = {
  {
    Type = "jpg",
    Filename = "zone_gaertnerei1.jpg",
    Directives = {}
  }
}
_vFL2 = Wherigo.ZMedia(_yCJ8)
_vFL2.Id = "126f7133-bbed-4f90-99fc-f258c6408f74"
_vFL2.Name = _d7gW("\01541\029l0pL\v#\029L\vLZ")
_vFL2.Description = ""
_vFL2.AltText = ""
_vFL2.Resources = {
  {
    Type = "jpg",
    Filename = "icon_gaertnerei1.jpg",
    Directives = {}
  }
}
_BWk = Wherigo.ZMedia(_yCJ8)
_BWk.Id = "9e8d59ad-eb4d-4dee-aada-90adde359286"
_BWk.Name = _d7gW("\0301\029Ll\002Z\029>p\029>")
_BWk.Description = ""
_BWk.AltText = ""
_BWk.Resources = {
  {
    Type = "jpg",
    Filename = "zone_eingang1.jpg",
    Directives = {}
  }
}
_dfoU = Wherigo.ZMedia(_yCJ8)
_dfoU.Id = "03b76194-759d-44a3-b964-9a62794a837f"
_dfoU.Name = _d7gW("Z41\029lLZ\029>p\029>")
_dfoU.Description = ""
_dfoU.AltText = ""
_dfoU.Resources = {
  {
    Type = "jpg",
    Filename = "icon_eingang1_1.jpg",
    Directives = {}
  }
}
_dx83 = Wherigo.ZMedia(_yCJ8)
_dx83.Id = "df75b48e-4867-41f6-9d54-7405edab7b3d"
_dx83.Name = _d7gW("\0301\029Ll}|C#t2C\v")
_dx83.Description = ""
_dx83.AltText = ""
_dx83.Resources = {
  {
    Type = "jpg",
    Filename = "zone_weihwasser_130.jpg",
    Directives = {}
  }
}
_NEO = Wherigo.ZMedia(_yCJ8)
_NEO.Id = "c483573f-7d18-4962-8c01-b255f14fdbdd"
_NEO.Name = _d7gW("\01541\029l}|C#t2C\v")
_NEO.Description = ""
_NEO.AltText = ""
_NEO.Resources = {
  {
    Type = "jpg",
    Filename = "icon_weihwasser_130.jpg",
    Directives = {}
  }
}
_E68 = Wherigo.ZMedia(_yCJ8)
_E68.Id = "81d7c1db-6957-4154-b56b-ace61fc100ee"
_E68.Name = _d7gW("\0301\029Ll\030ZL|l~L\vl.C\029>t")
_E68.Description = ""
_E68.AltText = ""
_E68.Resources = {
  {
    Type = "jpg",
    Filename = "Zone_ZielderJungs.jpg",
    Directives = {}
  }
}
_FdR = Wherigo.ZMedia(_yCJ8)
_FdR.Id = "192adecc-b267-43de-b5ff-afe04d8f9500"
_FdR.Name = _d7gW("\01541\029l\030ZL|l~L\vl.C\029>t")
_FdR.Description = ""
_FdR.AltText = ""
_FdR.Resources = {
  {
    Type = "jpg",
    Filename = "Icon_ZielderJungs.jpg",
    Directives = {}
  }
}
_EENpc = Wherigo.ZMedia(_yCJ8)
_EENpc.Id = "47b93a58-e831-435f-ab52-236ea723e6ef"
_EENpc.Name = _d7gW("\0301\029Ll?21Z|L\vlcCttpr~\vC4_")
_EENpc.Description = ""
_EENpc.AltText = ""
_EENpc.Resources = {
  {
    Type = "jpg",
    Filename = "zone_fusspur_spoiler.jpg",
    Directives = {}
  }
}
_QsEX = Wherigo.ZMedia(_yCJ8)
_QsEX.Id = "2ab7b451-3207-4fff-9c53-e629cfd095f0"
_QsEX.Name = _d7gW("\01541\029l?21Z|L\vlcCttpr~\vC4_")
_QsEX.Description = ""
_QsEX.AltText = ""
_QsEX.Resources = {
  {
    Type = "jpg",
    Filename = "icon_fusspur_spoiler.jpg",
    Directives = {}
  }
}
_yFMu = Wherigo.ZMedia(_yCJ8)
_yFMu.Id = "6ccd5244-3825-4247-bd32-3b45d20d3bd3"
_yFMu.Name = _d7gW("\01541\029lcZ\029p|")
_yFMu.Description = ""
_yFMu.AltText = ""
_yFMu.Resources = {
  {
    Type = "jpg",
    Filename = "Icon_Buch.jpg",
    Directives = {}
  }
}
_n3JNI = Wherigo.ZMedia(_yCJ8)
_n3JNI.Id = "16e0f85a-95e1-421e-9e70-655e796953b9"
_n3JNI.Name = _d7gW("\01541\029lx\vLCV")
_n3JNI.Description = ""
_n3JNI.AltText = ""
_n3JNI.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Kreuz.jpg",
    Directives = {}
  }
}
_w9Spg = Wherigo.ZMedia(_yCJ8)
_w9Spg.Id = "18d7b6a4-18ca-4792-8b6a-86c5c3f44687"
_w9Spg.Name = _d7gW("\01541\029l0\vprl0|C#a")
_w9Spg.Description = ""
_w9Spg.AltText = ""
_w9Spg.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Grab_Gluth.jpg",
    Directives = {}
  }
}
_xuqh2 = Wherigo.ZMedia(_yCJ8)
_xuqh2.Id = "bea38dae-ed07-496e-91e5-20b023b4cbe7"
_xuqh2.Name = _d7gW("\01541\029l0\vprl`ptt")
_xuqh2.Description = ""
_xuqh2.AltText = ""
_xuqh2.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Grab_Hass.jpg",
    Directives = {}
  }
}
_LUh = Wherigo.ZMedia(_yCJ8)
_LUh.Id = "f8bf84b1-b999-4f2e-9e33-021702e2a681"
_LUh.Name = _d7gW("\01541\029l0\vprl\019p#aapCt")
_LUh.Description = ""
_LUh.AltText = ""
_LUh.Resources = {
  {
    Type = "jpg",
    Filename = "icon_Grab_Rathhaus.jpg",
    Directives = {}
  }
}
_b9qJ = Wherigo.ZMedia(_yCJ8)
_b9qJ.Id = "4b93759c-522a-4dad-a314-b7a017271766"
_b9qJ.Name = _d7gW("\01541\029l?4aMC4_")
_b9qJ.Description = ""
_b9qJ.AltText = ""
_b9qJ.Resources = {
  {
    Type = "jpg",
    Filename = "icon_schmuck.jpg",
    Directives = {}
  }
}
_1iqV = Wherigo.ZMedia(_yCJ8)
_1iqV.Id = "3346e519-a27c-4856-b6b3-3cd12ff7fee4"
_1iqV.Name = _d7gW("}p4_C2l\tU{")
_1iqV.Description = ""
_1iqV.AltText = ""
_1iqV.Resources = {
  {
    Type = "gif",
    Filename = "backup_130.gif",
    Directives = {}
  }
}
_Kh5OE = Wherigo.ZMedia(_yCJ8)
_Kh5OE.Id = "cf911f6d-89cf-495e-a205-e776f8d0dae5"
_Kh5OE.Name = _d7gW("\01541\029P}p4_C2")
_Kh5OE.Description = ""
_Kh5OE.AltText = ""
_Kh5OE.Resources = {
  {
    Type = "gif",
    Filename = "backup_32.gif",
    Directives = {}
  }
}
_xMi = Wherigo.ZMedia(_yCJ8)
_xMi.Id = "273ef574-48fd-481d-8029-872f9b152ade"
_xMi.Name = _d7gW("uL|LH1\029_|Z\029>L|\029")
_xMi.Description = ""
_xMi.AltText = ""
_xMi.Resources = {
  {
    Type = "mp3",
    Filename = "Klingelton-altes-Telefon1.mp3",
    Directives = {}
  }
}
_HXtV = Wherigo.ZMedia(_yCJ8)
_HXtV.Id = "f64a50d1-6ef6-4369-a396-70722ec76858"
_HXtV.Name = _d7gW("\0301\029LPG~1|H")
_HXtV.Description = ""
_HXtV.AltText = ""
_HXtV.Resources = {
  {
    Type = "jpg",
    Filename = "Zone_Adolf.jpg",
    Directives = {}
  }
}
_jHpHw = Wherigo.ZMedia(_yCJ8)
_jHpHw.Id = "11607fd1-cd76-43df-9392-c9d282f3a722"
_jHpHw.Name = _d7gW("\01541\029lG~1|H")
_jHpHw.Description = ""
_jHpHw.AltText = ""
_jHpHw.Resources = {
  {
    Type = "jpg",
    Filename = "Icon_Adolf.jpg",
    Directives = {}
  }
}
_LS2 = Wherigo.ZMedia(_yCJ8)
_LS2.Id = "230ba199-ece8-4a1c-87ad-311b9aab5240"
_LS2.Name = _d7gW("\0301\029LlHZ\029p|")
_LS2.Description = ""
_LS2.AltText = ""
_LS2.Resources = {
  {
    Type = "jpg",
    Filename = "Zone_Buch.jpg",
    Directives = {}
  }
}
_Lw0qG = Wherigo.ZMedia(_yCJ8)
_Lw0qG.Id = "4aae1a23-06f1-461a-aeb9-059fcd47cb92"
_Lw0qG.Name = _d7gW("\031p\v\029C\029>l\tU{")
_Lw0qG.Description = ""
_Lw0qG.AltText = ""
_Lw0qG.Resources = {
  {
    Type = "jpg",
    Filename = "Warnung.jpg",
    Directives = {}
  }
}
_yCJ8.Id = "4253fa65-5548-4130-b673-09e2801ebf6e"
_yCJ8.Name = "Der verlassene Friedhof"
_yCJ8.Description = [[
<BR>
Du, Inspektor Fritz Mulders, bist mal wieder wegen Deiner Forschungen zu paranormalen Phaenomenen vom Dienst suspendiert worden. Dein Chef meinte nur: "Sie halten sich wohl fur Fox Mulder oder was?" Der wird schon noch sehen...]]
_yCJ8.Visible = true
_yCJ8.Activity = "Geocache"
_yCJ8.StartingLocationDescription = [[
<BR>
Der Start kann zuhause gespielt werden, erst beim Verlassen der Startzone muss zum angegebenen Parkplatz gefahren werden.]]
_yCJ8.StartingLocation = ZonePoint(52.526, 13.114833, 0)
_yCJ8.Version = "2"
_yCJ8.Company = "k-zuse@web.de"
_yCJ8.Author = "k-zuse"
_yCJ8.BuilderVersion = "URWIGO 1.22.5798.37755"
_yCJ8.CreateDate = "01/15/2012 07:12:44"
_yCJ8.PublishDate = "1/1/0001 12:00:00 AM"
_yCJ8.UpdateDate = "09/19/2020 16:21:22"
_yCJ8.LastPlayedDate = "1/1/0001 12:00:00 AM"
_yCJ8.TargetDevice = "PocketPC"
_yCJ8.TargetDeviceVersion = "0"
_yCJ8.StateId = "1"
_yCJ8.CountryId = "2"
_yCJ8.Complete = false
_yCJ8.UseLogging = true
_yCJ8.Media = _6HUO
_yCJ8.Icon = _tvu
_CFowp = Wherigo.Zone(_yCJ8)
_CFowp.Id = "334012dd-d225-4a72-959e-f2276e26cc98"
_CFowp.Name = _d7gW("\002Z\029>p\029>PVCMPc\vZL~a1H")
_CFowp.Description = _d7gW("`ZL\vPt#La#PLZ\029P>\v1ttLtP0L~L\029__\vLCV5PaZL\vPrZ\029PZ4aP\0041a|P\vZ4a#Z>,PGCHP~LMPc\vZL~a1HPt1||PZ4aPLZ\029Hp4aP~L\029P\031L>PZMP\\1\v~\004Lt#L\029P\029LaML\0295Pap#P~L\vPp|#LP0pL\v#\029L\vP>Ltp>#,Pm1\v#Pt1||PZ4aP\015\v\v||Z4a#L\vPtLaL\029PC\029~P~ZLP0|C#aPtC4aL\029,P`MMM,,,")
_CFowp.Visible = true
_CFowp.Media = _BWk
_CFowp.Icon = _ISJJZ
_CFowp.Commands = {}
_CFowp.DistanceRange = Distance(-1, "feet")
_CFowp.ShowObjects = "Always"
_CFowp.ProximityRange = Distance(60, "meters")
_CFowp.AllowSetPositionTo = false
_CFowp.Active = false
_CFowp.Points = {
  ZonePoint(52.526552509976, 13.1145607307553, 0),
  ZonePoint(52.5264953955715, 13.1148705258965, 0),
  ZonePoint(52.5266700022319, 13.1149670854211, 0),
  ZonePoint(52.5267258925349, 13.11463650316, 0)
}
_CFowp.OriginalPoint = ZonePoint(52.5266109500786, 13.1147587113082, 0)
_CFowp.DistanceRangeUOM = "Feet"
_CFowp.ProximityRangeUOM = "Meters"
_CFowp.OutOfRangeName = ""
_CFowp.InRangeName = ""
startzone = Wherigo.Zone(_yCJ8)
startzone.Id = "edebae9a-1a0f-4884-90e9-ed0b27fc73ed"
startzone.Name = _d7gW("cL\vZL\029\0041a\029C\029>")
startzone.Description = _d7gW("\015\029P~ZLtLPcL\vZL\029\0041a\029C\029>PZ\029P~L\vP\\pLaLPz1\029P}L\v|Z\029PHpa\vLPZ4aPt4a1\029PtLZ#P.pa\vL\029,PmZLP/L\vMZL#L\vZ\0295Pc\vpCP}\vZb\029L\vPZt#PLZ\029LP\029L##LPpL|#L\vLPc\vpC5P~ZLPtZ4aPtLa\vPHC\vPMLZ\029LPc1\vt4aC\029>L\029PVCP2p\vp\0291\vMp|L\029P\127apL\0291ML\029L\029PZ\029#L\vLttZL\v#,")
startzone.Visible = true
startzone.Media = _UKW
startzone.Icon = _5bC
startzone.Commands = {}
startzone.DistanceRange = Distance(-1, "feet")
startzone.ShowObjects = "Always"
startzone.ProximityRange = Distance(60, "meters")
startzone.AllowSetPositionTo = false
startzone.Active = false
startzone.Points = {
  ZonePoint(52.524085199549, 13.104841120243, 0),
  ZonePoint(52.5236282565666, 13.1015151810645, 0),
  ZonePoint(52.5218265493454, 13.1030601334571, 0)
}
startzone.OriginalPoint = ZonePoint(52.5231800018203, 13.1031388115882, 0)
startzone.DistanceRangeUOM = "Feet"
startzone.ProximityRangeUOM = "Meters"
startzone.OutOfRangeName = ""
startzone.InRangeName = ""
_NNXV = Wherigo.Zone(_yCJ8)
_NNXV.Id = "a76effbd-a03c-4e4b-a79e-36299bf92cc1"
_NNXV.Name = _d7gW("G|#LP0pL\v#\029L\vLZ")
_NNXV.Description = _d7gW("`ZL\vP\0041a\029#PLZ\029Pp|#L\vP0pL\v#\029L\v5P~L\vP~ZLPzL\vMZtt#L\029P.C\029>tPVC|L#V#P|LrL\029~P>LtLaL\029Pap#,P/ZL||LZ4a#P\004LZttPL\vPMLa\vk")
_NNXV.Visible = true
_NNXV.Media = _8Kz00
_NNXV.Icon = _vFL2
_NNXV.Commands = {}
_NNXV.DistanceRange = Distance(-1, "feet")
_NNXV.ShowObjects = "Always"
_NNXV.ProximityRange = Distance(60, "meters")
_NNXV.AllowSetPositionTo = false
_NNXV.Active = false
_NNXV.Points = {
  ZonePoint(52.5288730233734, 13.1158435416221, 0),
  ZonePoint(52.5288974996594, 13.1163799834251, 0),
  ZonePoint(52.5281566780284, 13.1161010336875, 0),
  ZonePoint(52.5282186856044, 13.1155887317657, 0)
}
_NNXV.OriginalPoint = ZonePoint(52.5285364716664, 13.1159783226251, 0)
_NNXV.DistanceRangeUOM = "Feet"
_NNXV.ProximityRangeUOM = "Meters"
_NNXV.OutOfRangeName = ""
_NNXV.InRangeName = ""
_MC1oP = Wherigo.Zone(_yCJ8)
_MC1oP.Id = "d2e1c54f-e9b6-4d6e-a661-80361e969e54"
_MC1oP.Name = _d7gW("\127p\v_L\029PrLZMPc\vZL~a1H")
_MC1oP.Description = _d7gW("`ZL\vP_p\029\029t#PmCPpMPrLt#L\029P2p\v_L\029,")
_MC1oP.Visible = true
_MC1oP.Media = _eLHa
_MC1oP.Icon = _M7IG
_MC1oP.Commands = {}
_MC1oP.DistanceRange = Distance(-1, "feet")
_MC1oP.ShowObjects = "Always"
_MC1oP.ProximityRange = Distance(60, "meters")
_MC1oP.AllowSetPositionTo = false
_MC1oP.Active = false
_MC1oP.Points = {
  ZonePoint(52.5258093005348, 13.1146808040141, 0),
  ZonePoint(52.5266774450296, 13.1150221151113, 0),
  ZonePoint(52.5266268581332, 13.1152521145343, 0),
  ZonePoint(52.5256807908456, 13.1148994040489, 0)
}
_MC1oP.OriginalPoint = ZonePoint(52.5261985986358, 13.1149636094272, 0)
_MC1oP.DistanceRangeUOM = "Feet"
_MC1oP.ProximityRangeUOM = "Meters"
_MC1oP.OutOfRangeName = ""
_MC1oP.InRangeName = ""
_NCt5 = Wherigo.Zone(_yCJ8)
_NCt5.Id = "8ae5d825-d1a5-45d3-ad46-b8940ec5756f"
_NCt5.Name = _d7gW("\031L>PpCHP~L\029Pc\vZL~a1H")
_NCt5.Description = _d7gW("\015\029P~ZLtLP\019Z4a#C\029>Pt1||PZ4aP>LaL\029PC\029~P\029p4aP~L\vP0|C#PtC4aL\029Pap#P~L\vP0pL\v#\029L\vP>Ltp>#,")
_NCt5.Visible = true
_NCt5.Commands = {}
_NCt5.DistanceRange = Distance(-1, "feet")
_NCt5.ShowObjects = "OnProximity"
_NCt5.ProximityRange = Distance(60, "meters")
_NCt5.AllowSetPositionTo = false
_NCt5.Active = false
_NCt5.Points = {
  ZonePoint(52.5270677601399, 13.1148775666952, 0),
  ZonePoint(52.5267691360784, 13.1147132813931, 0),
  ZonePoint(52.5268583056499, 13.1142613895554, 0),
  ZonePoint(52.5271459143417, 13.1144176282305, 0)
}
_NCt5.OriginalPoint = ZonePoint(52.5269602790525, 13.1145674664686, 0)
_NCt5.DistanceRangeUOM = "Feet"
_NCt5.ProximityRangeUOM = "Meters"
_NCt5.OutOfRangeName = ""
_NCt5.InRangeName = ""
_y3_Ad = Wherigo.Zone(_yCJ8)
_y3_Ad.Id = "41eb195c-56b9-45ab-9c62-7fb91a18e68b"
_y3_Ad.Name = _d7gW("\019p#aapCt")
_y3_Ad.Description = _d7gW("`ZL\vPt1||PZ4aP\019p#PrL_1MML\029k")
_y3_Ad.Visible = true
_y3_Ad.Media = __ruD
_y3_Ad.Commands = {}
_y3_Ad.DistanceRange = Distance(-1, "feet")
_y3_Ad.ShowObjects = "Always"
_y3_Ad.ProximityRange = Distance(30, "meters")
_y3_Ad.AllowSetPositionTo = false
_y3_Ad.Active = false
_y3_Ad.Points = {
  ZonePoint(52.5282206257871, 13.1142086908221, 0),
  ZonePoint(52.5281243508331, 13.1149067357183, 0),
  ZonePoint(52.5278265498512, 13.1147645786405, 0),
  ZonePoint(52.5279216016168, 13.114057816565, 0)
}
_y3_Ad.OriginalPoint = ZonePoint(52.528023282022, 13.1144844554365, 0)
_y3_Ad.DistanceRangeUOM = "Feet"
_y3_Ad.ProximityRangeUOM = "Meters"
_y3_Ad.OutOfRangeName = ""
_y3_Ad.InRangeName = ""
_4SzwM = Wherigo.Zone(_yCJ8)
_4SzwM.Id = "882e03f8-2a7a-4d40-ba76-00c52f85600c"
_4SzwM.Name = _d7gW("x\vLCV")
_4SzwM.Description = _d7gW("mptPx\vLCVP_C\vVPz1\vP\002\029~LP~LtP\031L>Lt,")
_4SzwM.Visible = true
_4SzwM.Media = _8FWf
_4SzwM.Commands = {}
_4SzwM.DistanceRange = Distance(-1, "feet")
_4SzwM.ShowObjects = "Always"
_4SzwM.ProximityRange = Distance(30, "meters")
_4SzwM.AllowSetPositionTo = false
_4SzwM.Active = false
_4SzwM.Points = {
  ZonePoint(52.5287048529704, 13.1143454834819, 0),
  ZonePoint(52.5286265284637, 13.1148604676127, 0),
  ZonePoint(52.5282381673876, 13.1147048994899, 0),
  ZonePoint(52.5283230196806, 13.1141952797771, 0)
}
_4SzwM.OriginalPoint = ZonePoint(52.5284731421256, 13.1145265325904, 0)
_4SzwM.DistanceRangeUOM = "Feet"
_4SzwM.ProximityRangeUOM = "Meters"
_4SzwM.OutOfRangeName = ""
_4SzwM.InRangeName = ""
_fsfyQ = Wherigo.Zone(_yCJ8)
_fsfyQ.Id = "c21387f4-33ee-4d45-82ee-cce4b9e8687f"
_fsfyQ.Name = _d7gW("/p#L\vP`ptt")
_fsfyQ.Description = _d7gW("\031ptPMZ4aPaZL\vP\0041a|PL\v\004p\v#L#k")
_fsfyQ.Visible = true
_fsfyQ.Media = _DF7
_fsfyQ.Commands = {}
_fsfyQ.DistanceRange = Distance(-1, "feet")
_fsfyQ.ShowObjects = "OnProximity"
_fsfyQ.ProximityRange = Distance(20, "meters")
_fsfyQ.AllowSetPositionTo = false
_fsfyQ.Active = false
_fsfyQ.Points = {
  ZonePoint(52.5272004448497, 13.1139110100269, 0),
  ZonePoint(52.5275741288942, 13.1140719425678, 0),
  ZonePoint(52.5276671414591, 13.1135381829738, 0),
  ZonePoint(52.527293458206, 13.1133584749698, 0)
}
_fsfyQ.OriginalPoint = ZonePoint(52.5274337933523, 13.1137199026346, 0)
_fsfyQ.DistanceRangeUOM = "Feet"
_fsfyQ.ProximityRangeUOM = "Meters"
_fsfyQ.OutOfRangeName = ""
_fsfyQ.InRangeName = ""
_6MVMb = Wherigo.Zone(_yCJ8)
_6MVMb.Id = "3d340319-f916-46d0-af67-6b295884c018"
_6MVMb.Name = _d7gW("hM>Lt#CL\vV#L\vP.LtCt")
_6MVMb.Description = _d7gW("`ZL\vP|ZL>#PLZ\029PCM>Lt#CL\vV#LtPx\vLCVPMZ#P.LtCtP~p\vp\029,P?4a\004Lt#L\vP0|C#a\btP?LL|LP_1L\029\029#LPtZ4aP~pHCL\vPZ\029#L\vLttZL\vL\029,PmCPapt#P?ZLP~14aPMZ#>L\0291MML\0295P1~L\vk&}\019=&}\019=&}\019=")
_6MVMb.Visible = true
_6MVMb.Media = _mdfiv
_6MVMb.Commands = {}
_6MVMb.DistanceRange = Distance(-1, "feet")
_6MVMb.ShowObjects = "Always"
_6MVMb.ProximityRange = Distance(20, "meters")
_6MVMb.AllowSetPositionTo = false
_6MVMb.Active = false
_6MVMb.Points = {
  ZonePoint(52.5275480200687, 13.1145466935634, 0),
  ZonePoint(52.5271514903724, 13.1143415045738, 0),
  ZonePoint(52.5272600060566, 13.1137970161437, 0),
  ZonePoint(52.5276358891819, 13.1139599865942, 0)
}
_6MVMb.OriginalPoint = ZonePoint(52.5273988514199, 13.1141613002188, 0)
_6MVMb.DistanceRangeUOM = "Feet"
_6MVMb.ProximityRangeUOM = "Meters"
_6MVMb.OutOfRangeName = ""
_6MVMb.InRangeName = ""
_paM81 = Wherigo.Zone(_yCJ8)
_paM81.Id = "4de0973a-74e8-4e23-8d38-3959b8bd1903"
_paM81.Name = _d7gW("cCttpr~\vC4_")
_paM81.Description = _d7gW("`ZL\vPMCttPLtPZ\v>L\029~\0041PLZ\029L\029PcCttpr~\vC4_PVCPHZ\029~L\029P>LrL\029,P?4a\004Lt#L\vP0|C#atP?LL|LP_1L\029\029#LPMZ\vPzZL||LZ4a#P\004LZ#L\vPaL|HL\0295P\004L\029\029PZ4aP~ZLP?2C\vPHZ\029~L,")
_paM81.Visible = true
_paM81.Media = _EENpc
_paM81.Icon = _QsEX
_paM81.Commands = {}
_paM81.DistanceRange = Distance(-1, "feet")
_paM81.ShowObjects = "Always"
_paM81.ProximityRange = Distance(60, "meters")
_paM81.AllowSetPositionTo = false
_paM81.Active = false
_paM81.Points = {
  ZonePoint(52.5261707575172, 13.1137098443508, 0),
  ZonePoint(52.5263306788448, 13.1137661707401, 0),
  ZonePoint(52.5263731068544, 13.1134443056583, 0),
  ZonePoint(52.5262213449389, 13.1133826148509, 0)
}
_paM81.OriginalPoint = ZonePoint(52.5262739720388, 13.1135757339, 0)
_paM81.DistanceRangeUOM = "Feet"
_paM81.ProximityRangeUOM = "Meters"
_paM81.OutOfRangeName = ""
_paM81.InRangeName = ""
_Yn7T = Wherigo.Zone(_yCJ8)
_Yn7T.Id = "10cb8979-b2b4-45da-bc58-22637ca7234d"
_Yn7T.Name = _d7gW("G~Z~pt\"cCttpr~\vC4_")
_Yn7T.Description = _d7gW("`ZL\vPL\vZ\029\029L\v#P~L\vPc\vZL~a1Htr1~L\029PtZ4aP~p\vp\0295PVC|L#V#PMZ#PG~Z~pt\"?4aCaL\029PrL#\vL#L\029P\0041\v~L\029PVCPtLZ\029,")
_Yn7T.Visible = true
_Yn7T.Media = _RuTDS
_Yn7T.Icon = _88uun
_Yn7T.Commands = {}
_Yn7T.DistanceRange = Distance(-1, "feet")
_Yn7T.ShowObjects = "Always"
_Yn7T.ProximityRange = Distance(60, "meters")
_Yn7T.AllowSetPositionTo = false
_Yn7T.Active = false
_Yn7T.Points = {
  ZonePoint(52.5263798939816, 13.1142948060792, 0),
  ZonePoint(52.526260496894, 13.1142428001415, 0),
  ZonePoint(52.5262075517828, 13.1144947809265, 0),
  ZonePoint(52.5263283086563, 13.1145566208719, 0)
}
_Yn7T.OriginalPoint = ZonePoint(52.5262940628287, 13.1143972520048, 0)
_Yn7T.DistanceRangeUOM = "Feet"
_Yn7T.ProximityRangeUOM = "Meters"
_Yn7T.OutOfRangeName = ""
_Yn7T.InRangeName = ""
_ww1 = Wherigo.Zone(_yCJ8)
_ww1.Id = "01bf24cb-7472-45f9-99ca-eff226f2d9d2"
_ww1.Name = _d7gW("\\Z_L\"cCttpr~\vC4_")
_ww1.Description = _d7gW("`ZL\vPL\vZ\029\029L\v#P~L\vPc\vZL~a1Htr1~L\029PtZ4aP~p\vp\0295PVC|L#V#PMZ#P\\Z_L\"?4aCaL\029PrL#\vL#L\029P\0041\v~L\029PVCPtLZ\029,")
_ww1.Visible = true
_ww1.Media = _RuTDS
_ww1.Icon = _88uun
_ww1.Commands = {}
_ww1.DistanceRange = Distance(-1, "feet")
_ww1.ShowObjects = "Always"
_ww1.ProximityRange = Distance(60, "meters")
_ww1.AllowSetPositionTo = false
_ww1.Active = false
_ww1.Points = {
  ZonePoint(52.5266541179802, 13.1142651287477, 0),
  ZonePoint(52.5267002637085, 13.1140041313696, 0),
  ZonePoint(52.5265625543317, 13.1139380449726, 0),
  ZonePoint(52.5265115136292, 13.114201947698, 0)
}
_ww1.OriginalPoint = ZonePoint(52.5266071124124, 13.114102313197, 0)
_ww1.DistanceRangeUOM = "Feet"
_ww1.ProximityRangeUOM = "Meters"
_ww1.OutOfRangeName = ""
_ww1.InRangeName = ""
_1Uew = Wherigo.Zone(_yCJ8)
_1Uew.Id = "dbb37179-1bd0-45f9-a857-d6f0f305dad4"
_1Uew.Name = _d7gW("\127CMp\"cCttpr~\vC4_")
_1Uew.Description = _d7gW("`ZL\vPL\vZ\029\029L\v#P~L\vPc\vZL~a1Htr1~L\029PtZ4aP~p\vp\0295PVC|L#V#PMZ#P\127CMp\"?4aCaL\029PrL#\vL#L\029P\0041\v~L\029PVCPtLZ\029,")
_1Uew.Visible = true
_1Uew.Media = _RuTDS
_1Uew.Icon = _88uun
_1Uew.Commands = {}
_1Uew.DistanceRange = Distance(-1, "feet")
_1Uew.ShowObjects = "Always"
_1Uew.ProximityRange = Distance(60, "meters")
_1Uew.AllowSetPositionTo = false
_1Uew.Active = false
_1Uew.Points = {
  ZonePoint(52.5263993957719, 13.1129035445414, 0),
  ZonePoint(52.526354520018, 13.1132115523017, 0),
  ZonePoint(52.5261851692192, 13.1131508303228, 0),
  ZonePoint(52.5262362553222, 13.1128414814578, 0)
}
_1Uew.OriginalPoint = ZonePoint(52.5262938350828, 13.1130268521559, 0)
_1Uew.DistanceRangeUOM = "Feet"
_1Uew.ProximityRangeUOM = "Meters"
_1Uew.OutOfRangeName = ""
_1Uew.InRangeName = ""
__NU8 = Wherigo.Zone(_yCJ8)
__NU8.Id = "013198bf-b0cd-400d-ae38-6301584d3002"
__NU8.Name = _d7gW("\030ZL|P~L\vP.C\029>t")
__NU8.Description = _d7gW("`ZL\vPtZ\029~P~ZLP.C\029>tPaZ\029>L\vp\029\029#,")
__NU8.Visible = true
__NU8.Media = _E68
__NU8.Icon = _FdR
__NU8.Commands = {}
__NU8.DistanceRange = Distance(-1, "feet")
__NU8.ShowObjects = "Always"
__NU8.ProximityRange = Distance(60, "meters")
__NU8.AllowSetPositionTo = false
__NU8.Active = false
__NU8.Points = {
  ZonePoint(52.5256693879264, 13.1126336003054, 0),
  ZonePoint(52.5256453356444, 13.112808177152, 0),
  ZonePoint(52.5255491030837, 13.1127293282111, 0),
  ZonePoint(52.5255667772686, 13.1125706061085, 0)
}
__NU8.OriginalPoint = ZonePoint(52.5256076509808, 13.1126854279442, 0)
__NU8.DistanceRangeUOM = "Feet"
__NU8.ProximityRangeUOM = "Meters"
__NU8.OutOfRangeName = ""
__NU8.InRangeName = ""
_h9Uz = Wherigo.Zone(_yCJ8)
_h9Uz.Id = "ba64485d-1575-480a-9bef-c28b6ca97b9d"
_h9Uz.Name = _d7gW("cZ\029p|V1\029L")
_h9Uz.Description = _d7gW("`ZL\vPMCttPLtPzL\vt#L4_#PtLZ\029\fP?C4aLPpMP}pCM\fPmZLP>L\029pCLP\030ZL|_11\v~Z\029p#LP|pC#L#-&}\019=&}\019=\\P7\023PU\t,8{8P\002P{\tUP{8,\0228\022P&}\019=&}\019=\031L\029\029PmCP~ZLPm1tLP>LHC\029~L\029Papt#5P_|Z4_LPpCHP~L\029P?4ap#VPHCL\vP~ptP\002\029~LP~L\vP0Lt4aZ4a#LPC\029~PmLZ\029L\029Ph\029|14_41~L\f")
_h9Uz.Visible = true
_h9Uz.Media = _LS2
_h9Uz.Icon = _yFMu
_h9Uz.Commands = {}
_h9Uz.DistanceRange = Distance(-1, "feet")
_h9Uz.ShowObjects = "OnEnter"
_h9Uz.ProximityRange = Distance(30, "meters")
_h9Uz.AllowSetPositionTo = false
_h9Uz.Active = false
_h9Uz.Points = {
  ZonePoint(52.5266129118067, 13.1128936644512, 0),
  ZonePoint(52.5268355211534, 13.1129769377121, 0),
  ZonePoint(52.5268898487701, 13.1125865336938, 0),
  ZonePoint(52.5266483457587, 13.1125378032121, 0)
}
_h9Uz.OriginalPoint = ZonePoint(52.5267466568722, 13.1127487347673, 0)
_h9Uz.DistanceRangeUOM = "Feet"
_h9Uz.ProximityRangeUOM = "Meters"
_h9Uz.OutOfRangeName = ""
_h9Uz.InRangeName = ""
_9W1 = Wherigo.Zone(_yCJ8)
_9W1.Id = "eae782be-49b9-4d95-917b-f0c6c5ed08fe"
_9W1.Name = _d7gW("\031LZa\004pttL\vrL4_L\029")
_9W1.Description = _d7gW("`ZL\vPZ\029P~L\vP\\pLaLP~LtP\031LZa\004pttL\vrL4_L\029tPap#PLZ\029L\vP~L\vP.C\029>tP>Lt4a\vZL\029,P`ZL\vP_p\029\029PZ4aPrLt#ZMM#PL#\004ptPHZ\029~L\029,P\031L\029\029PZ4aPL#\004ptP>LHC\029~L\029PaprL5PH\vp>PZ4aPMp|P?4a\004Lt#L\vP0|C#aP~pVC,")
_9W1.Visible = true
_9W1.Media = _dx83
_9W1.Icon = _NEO
_9W1.Commands = {}
_9W1.DistanceRange = Distance(-1, "feet")
_9W1.ShowObjects = "OnEnter"
_9W1.ProximityRange = Distance(20, "meters")
_9W1.AllowSetPositionTo = false
_9W1.Active = false
_9W1.Points = {
  ZonePoint(52.528345039371, 13.1150480497508, 0),
  ZonePoint(52.5286093857158, 13.1151338804393, 0),
  ZonePoint(52.5286142810035, 13.11472350246, 0),
  ZonePoint(52.5283890972056, 13.1146564472347, 0)
}
_9W1.OriginalPoint = ZonePoint(52.528489450824, 13.1148904699712, 0)
_9W1.DistanceRangeUOM = "Feet"
_9W1.ProximityRangeUOM = "Meters"
_9W1.OutOfRangeName = ""
_9W1.InRangeName = ""
_kcl = Wherigo.Zone(_yCJ8)
_kcl.Id = "f4bcc606-0e5a-42c5-9161-0877eb8a3372"
_kcl.Name = _d7gW("\030\004LZPG~1|Ht")
_kcl.Description = _d7gW("`ZL\vP|ZL>#PLZ\029PC\029>L\0041La\029|Z4aL\vP0\vprt#LZ\029PpCHP~LMP\02914aPt4a\004p4aPV\004LZMp|P!G~1|H!PVCP|LtL\029PZt#,")
_kcl.Visible = false
_kcl.Media = _HXtV
_kcl.Icon = _jHpHw
_kcl.Commands = {}
_kcl.DistanceRange = Distance(-1, "feet")
_kcl.ShowObjects = "OnEnter"
_kcl.ProximityRange = Distance(60, "meters")
_kcl.AllowSetPositionTo = false
_kcl.Active = false
_kcl.Points = {
  ZonePoint(52.5262968884386, 13.112667791632, 0),
  ZonePoint(52.526326387647, 13.1125193927237, 0),
  ZonePoint(52.5264408086316, 13.112584041753, 0),
  ZonePoint(52.5264139912401, 13.1127236248846, 0)
}
_kcl.OriginalPoint = ZonePoint(52.5263695189893, 13.1126237127483, 0)
_kcl.DistanceRangeUOM = "Feet"
_kcl.ProximityRangeUOM = "Meters"
_kcl.OutOfRangeName = ""
_kcl.InRangeName = ""
_3dJy5 = Wherigo.ZCharacter({Cartridge = _yCJ8, Container = startzone})
_3dJy5.Id = "6466ee5c-9a78-4575-a34b-8afaad55c006"
_3dJy5.Name = _d7gW("c\vpCP}\vZb\029L\v")
_3dJy5.Description = _d7gW("c\vpCP}\vZb\029L\vPZt#P~ZLP/L\vMZL#L\vZ\029PMLZ\029L\vPcL\vZL\029\0041a\029C\029>,P?ZLPZt#PG\029Hp\029>P8{5Pc\vCLa\vL\029#\029L\vZ\029PC\029~PtLa\vP\029L##,P?ZLP|ZLr#P`1\v\v1\vHZ|MLPC\029~P0\vCtL|>Lt4aZ4a#L\029PC\029~Pap#PtZ4aP~Ltap|rPt4a1\029P1LH#L\vPz1\029PMLZ\029L\029P`1rr\014\"c1\vt4aC\029>L\029PVCP2p\vp\0291\vMp|L\029P\127apL\0291ML\029L\029PL\vVpLa|L\029P|pttL\029,")
_3dJy5.Visible = false
_3dJy5.Media = _pKP41
_3dJy5.Icon = _bqp
_3dJy5.Commands = {
  _lTc1 = Wherigo.ZCommand({
    Text = _d7gW("\031ptPZt#P~L\029\029P|1tk"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_3dJy5.Commands._lTc1.Custom = true
_3dJy5.Commands._lTc1.Id = "922edd18-0604-4135-ad09-333edd1cb297"
_3dJy5.Commands._lTc1.WorksWithAll = true
_3dJy5.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_3dJy5.Gender = "Female"
_3dJy5.Type = "NPC"
_e4Q = Wherigo.ZCharacter({Cartridge = _yCJ8, Container = _NNXV})
_e4Q.Id = "df1c266f-85e8-4b45-9543-5cd70e438393"
_e4Q.Name = _d7gW("G|#L\vP0pL\v#\029L\v")
_e4Q.Description = _d7gW("mL\vPp|#LP0pL\v#\029L\vPap#P~ptP\004L##L\v>L>L\vr#LP0LtZ4a#PLZ\029LtP\022{\"(pLa\vZ>L\0295P~ptPt4a1\029PzZL|P>LtLaL\029Pap#,P\002\vPap#P~ZLPzL\vt4a\004C\029~L\029L\029P.C\029>tPp|tP|L#V#L\vP|LrL\029~P>LtLaL\029,")
_e4Q.Visible = false
_e4Q.Media = __ZQRU
_e4Q.Icon = _cu3K2
_e4Q.Commands = {
  _z_N = Wherigo.ZCommand({
    Text = _d7gW(";Z#P~LMP0pL\v#\029L\vPt2\vL4aL\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_e4Q.Commands._z_N.Custom = true
_e4Q.Commands._z_N.Id = "84620fad-96e8-42d9-a7fa-e9e326ca257a"
_e4Q.Commands._z_N.WorksWithAll = true
_e4Q.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_e4Q.Gender = "Male"
_e4Q.Type = "NPC"
_QxT = Wherigo.ZCharacter(_yCJ8)
_QxT.Id = "bd8063ab-3dc7-483d-a3b2-931cd0460d76"
_QxT.Name = _d7gW("?4a\004Lt#L\vP0|C#atP?LL|L")
_QxT.Description = _d7gW("mZLP?LL|LP~L\vP>C#L\029P?4a\004Lt#L\vP0|C#a5PLZ\029LP~L\vP\004L\029Z>L\029PH\vLC\029~|Z4aL\029P\vpt#|1tL\029P?LL|L\029PaZL\vPpCHP~LMPc\vZL~a1H,P)rPtZLPMZ\vPaZ|H#k")
_QxT.Visible = true
_QxT.Media = _d4fL5
_QxT.Icon = _cCoom
_QxT.Commands = {
  _dYPV = Wherigo.ZCommand({
    Text = _d7gW("}Lt4a\0041L\vLP~ZLP?LL|L-P`Z|HPMZ\v\f"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _HwPv = Wherigo.ZCommand({
    Text = _d7gW("\031ptPt1||PZ4aP(L#V#PMp4aL\029k"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _Ynsd = Wherigo.ZCommand({
    Text = _d7gW("\0154aPaprLPL#\004ptP>LHC\029~L\029\f"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _TxV2 = Wherigo.ZCommand({
    Text = _d7gW("\0154aPaprLPrLZP~L\vP}|C#t2C\vPL#\004ptPL\029#~L4_#,"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = ""
  }),
  _hzu = Wherigo.ZCommand({
    Text = _d7gW("\0154aPaprLP.LtCtP>LHC\029~L\0295P\004ptP\029C\029k"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_QxT.Commands._dYPV.Custom = true
_QxT.Commands._dYPV.Id = "e44e03ae-36b5-41db-ad66-7d1f14d8ca4f"
_QxT.Commands._dYPV.WorksWithAll = true
_QxT.Commands._HwPv.Custom = true
_QxT.Commands._HwPv.Id = "f585551d-ad8c-4aaa-a7ba-d6585fec3951"
_QxT.Commands._HwPv.WorksWithAll = true
_QxT.Commands._Ynsd.Custom = true
_QxT.Commands._Ynsd.Id = "4e945435-78c1-4b4c-9ecb-b4e852486ce2"
_QxT.Commands._Ynsd.WorksWithAll = true
_QxT.Commands._TxV2.Custom = true
_QxT.Commands._TxV2.Id = "631681e6-186a-4078-a78e-96c99ddf2bdf"
_QxT.Commands._TxV2.WorksWithAll = true
_QxT.Commands._hzu.Custom = true
_QxT.Commands._hzu.Id = "a12ac315-5ed5-4ab8-b366-8098f498c3ed"
_QxT.Commands._hzu.WorksWithAll = true
_QxT.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_QxT.Gender = "Female"
_QxT.Type = "NPC"
_sGBb = Wherigo.ZCharacter({Cartridge = _yCJ8, Container = __NU8})
_sGBb.Id = "8c5b8fe1-b8fd-4e26-b2cd-96bc2bdbf27c"
_sGBb.Name = _d7gW("m\vLZP.C\029>t")
_sGBb.Description = _d7gW("mZLP~\vLZP.C\029>tP2pttL\029P>L\029pCPVC\vP}Lt4a\vLZrC\029>5PMp|PtLaL\0295P\004ptPtZLPVCPtp>L\029PaprL\029\f")
_sGBb.Visible = false
_sGBb.Media = _Xvej
_sGBb.Icon = _aqb
_sGBb.Commands = {
  _WFJj = Wherigo.ZCommand({
    Text = _d7gW("mL\029P>\v1Ltt#L\029Pp\029t2\vL4aL\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _GLoL1 = Wherigo.ZCommand({
    Text = _d7gW("\\pML\029P~LtP0\v1Ltt#L\029PL\v\vp#L\029"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _Ql_ = Wherigo.ZCommand({
    Text = _d7gW("\0311PZt#P~ptP/L\vt#L4_k"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_sGBb.Commands._WFJj.Custom = true
_sGBb.Commands._WFJj.Id = "8c0f86c5-c861-4ccd-9f24-5dc9de2a97d4"
_sGBb.Commands._WFJj.WorksWithAll = true
_sGBb.Commands._GLoL1.Custom = true
_sGBb.Commands._GLoL1.Id = "5d341808-09f4-4882-bf7c-4089a6bad100"
_sGBb.Commands._GLoL1.WorksWithAll = true
_sGBb.Commands._Ql_.Custom = true
_sGBb.Commands._Ql_.Id = "5919ca41-7368-4459-bb07-ea488b649041"
_sGBb.Commands._Ql_.WorksWithAll = true
_sGBb.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_sGBb.Gender = "Male"
_sGBb.Type = "NPC"
_eD9w = Wherigo.ZItem(_yCJ8)
_eD9w.Id = "7f612515-58cc-44d7-8114-51999f6b855a"
_eD9w.Name = _d7gW("mpM2HL\029~PaLZttL\vPxpHHLL")
_eD9w.Description = _d7gW("mL\vPxpHHLLP~CH#L#P_1Lt#|Z4a5PzZL||LZ4a#Pt1||#LPZ4aPLZ\029LPupttLPMZ#Pc\vpCP}\vZb\029L\vP#\vZ\029_L\029k")
_eD9w.Visible = true
_eD9w.Media = _5Gt
_eD9w.Icon = _ST7G
_eD9w.Commands = {
  _656H = Wherigo.ZCommand({
    Text = _d7gW("xpHHLLP#\vZ\029_L\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _qOEq = Wherigo.ZCommand({
    Text = _d7gW("\\14aPLZ\029L\029PxpHHLLP#\vZ\029_L\029P"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\0154aP>|pCrL5PZ4aP#\vZ\029_LP\02914aPLZ\029L\029PxpHHLLPMZ#Pc\vpCP}\vZb\029L\v,")
  })
}
_eD9w.Commands._656H.Custom = true
_eD9w.Commands._656H.Id = "59eb8550-6233-4492-bb2a-c98e01b48063"
_eD9w.Commands._656H.WorksWithAll = true
_eD9w.Commands._qOEq.Custom = true
_eD9w.Commands._qOEq.Id = "89583970-8386-4178-a474-a93057c069f9"
_eD9w.Commands._qOEq.WorksWithAll = true
_eD9w.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_eD9w.Locked = false
_eD9w.Opened = false
_1gvh = Wherigo.ZItem(_yCJ8)
_1gvh.Id = "9d4797ce-a7fb-451c-a153-8527219d4c52"
_1gvh.Name = _d7gW("?LL|L\029t#LZ\029")
_1gvh.Description = _d7gW("?1|p\029>LPmCP~ZLtL\029P?#LZ\029PrLZPmZ\vPrLapL|t#5PrL>|LZ#L#PmZ4aP?4a\004Lt#L\vP0|C#a\btP?LL|L,P\031L\029\029PtZLPVCP\015a\vLMP0\vprPVC\vCL4__La\vL\029Pt1||5PMCtt#PmCP~ZLtL\029P?#LZ\029P\004L>\004L\vHL\029,")
_1gvh.Visible = true
_1gvh.Media = _2AsVQ
_1gvh.Icon = _7qpxb
_1gvh.Commands = {
  _jpdN = Wherigo.ZCommand({
    Text = _d7gW("\031L>\004L\vHL\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_1gvh.Commands._jpdN.Custom = true
_1gvh.Commands._jpdN.Id = "937a0b02-6f0f-49dd-bc2c-01b7e6d0207c"
_1gvh.Commands._jpdN.WorksWithAll = true
_1gvh.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_1gvh.Locked = false
_1gvh.Opened = false
_bEW7 = Wherigo.ZItem(_yCJ8)
_bEW7.Id = "9e23b48e-0920-4064-8dc9-97ae256cdb10"
_bEW7.Name = _d7gW("h\029|14_41~L")
_bEW7.Description = ""
_bEW7.Visible = false
_bEW7.Media = _xJRZm
_bEW7.Icon = _yEEc
_bEW7.Commands = {
  _A8A5 = Wherigo.ZCommand({
    Text = _d7gW("h\029|14_41~LPp\029VLZ>L\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_bEW7.Commands._A8A5.Custom = true
_bEW7.Commands._A8A5.Id = "4742ab64-fadd-49c0-aca7-df29a53b99bb"
_bEW7.Commands._A8A5.WorksWithAll = true
_bEW7.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_bEW7.Locked = false
_bEW7.Opened = false
_ZIe = Wherigo.ZItem(_yCJ8)
_ZIe.Id = "2b9c8421-fdf7-4e50-a1d8-ac488e932480"
_ZIe.Name = _d7gW("0\vprt#LZ\029P~L\vP0|C#a")
_ZIe.Description = _d7gW("?4a\004Lt#L\vP0|C#atP0\vprt#LZ\029,PcZ\029~LPZa\029PC\029~P|ZLtPZa\vL\029P/1\v\029pML\029P|pC#Pz1\v,,,")
_ZIe.Visible = true
_ZIe.Media = _aJX
_ZIe.Icon = _w9Spg
_ZIe.Commands = {
  _O4Kb = Wherigo.ZCommand({
    Text = _d7gW("EZLtP~L\029P/1\v\029pML\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_ZIe.Commands._O4Kb.Custom = true
_ZIe.Commands._O4Kb.Id = "5840481c-25ea-4cc2-a122-5bbc484b6526"
_ZIe.Commands._O4Kb.WorksWithAll = true
_ZIe.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_ZIe.Locked = false
_ZIe.Opened = false
_z3g0 = Wherigo.ZItem(_yCJ8)
_z3g0.Id = "94f2bb97-8cd0-4d59-9418-c0737495f9a0"
_z3g0.Name = _d7gW("0\vprt#LZ\029P~LtP\019p#aapCt")
_z3g0.Description = _d7gW("hMPtZ4aL\vPVCP>LaL\0295P~pttPZ4aPpMP\vZ4a#Z>L\029P0\vprPrZ\0295PMCttPZ4aP~L\029PL\vt#L\029P}L\vCHP~LtP`L\v\v\029P\019p#apCtP\029L\029\029L\029,")
_z3g0.Visible = true
_z3g0.Media = __ruD
_z3g0.Icon = _LUh
_z3g0.Commands = {
  _agv = Wherigo.ZCommand({
    Text = _d7gW("}L\vCHPp\029>LrL\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_z3g0.Commands._agv.Custom = true
_z3g0.Commands._agv.Id = "e465a5ff-e773-4445-9369-443f1b476e0a"
_z3g0.Commands._agv.WorksWithAll = true
_z3g0.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_z3g0.Locked = false
_z3g0.Opened = true
_zrZ = Wherigo.ZItem(_yCJ8)
_zrZ.Id = "f1a3b844-6c90-4149-90cf-8d93849928df"
_zrZ.Name = _d7gW("0\vprt#LZ\029P~LtP`ptt")
_zrZ.Description = _d7gW("hMPtZ4aL\vPVCP>LaL\0295P~pttPZ4aPpMP\vZ4a#Z>L\029P0\vprPrZ\0295PMCttPZ4aP~ptPu1~Lt(pa\vPz1\029P;C##L\vP`pttPp\029>LrL\029,")
_zrZ.Visible = true
_zrZ.Media = _DF7
_zrZ.Icon = _xuqh2
_zrZ.Commands = {
  _uYxA = Wherigo.ZCommand({
    Text = _d7gW("u1~Lt(pa\vPp\029>LrL\029"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_zrZ.Commands._uYxA.Custom = true
_zrZ.Commands._uYxA.Id = "45022af5-e334-4ec4-9753-6da121a0918a"
_zrZ.Commands._uYxA.WorksWithAll = true
_zrZ.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zrZ.Locked = false
_zrZ.Opened = false
__5n = Wherigo.ZItem({Cartridge = _yCJ8, Container = Player})
__5n.Id = "f35fba2a-c0ce-46c4-960f-ea2888c2c90d"
__5n.Name = _d7gW("\\1#ZVrC4a")
__5n.Description = _d7gW("\015\029PMLZ\029LMP\\1#ZVrC4aPap|#LPZ4aPp||LtPHLt#5P\004ptPHCL\vPLZ\029L\029Pcp||P\004Z4a#Z>PtLZ\029P_1L\029\029#L5P~pMZ#PZ4aP(L~L\vVLZ#P\029p4at4a|p>L\029P_p\029\029,")
__5n.Visible = true
__5n.Media = _ud4a
__5n.Icon = _D6s
__5n.Commands = {
  _oL8 = Wherigo.ZCommand({
    Text = _d7gW("\002\vt#LP\\1#ZVL\029"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _rbSD = Wherigo.ZCommand({
    Text = _d7gW("xp\v#L"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  }),
  _KoHoQ = Wherigo.ZCommand({
    Text = _d7gW("mZLP\019\0020\002E\\"),
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
__5n.Commands._oL8.Custom = true
__5n.Commands._oL8.Id = "98018a58-7935-4d10-881d-1774ed96375c"
__5n.Commands._oL8.WorksWithAll = true
__5n.Commands._rbSD.Custom = true
__5n.Commands._rbSD.Id = "cde7a707-492f-4bf1-be67-0e4f152224bc"
__5n.Commands._rbSD.WorksWithAll = true
__5n.Commands._KoHoQ.Custom = true
__5n.Commands._KoHoQ.Id = "ef7ab911-fc32-4166-81fc-53d9c2e29d88"
__5n.Commands._KoHoQ.WorksWithAll = true
__5n.ObjectLocation = Wherigo.INVALID_ZONEPOINT
__5n.Locked = false
__5n.Opened = false
_GO6Ie = Wherigo.ZItem({Cartridge = _yCJ8, Container = _h9Uz})
_GO6Ie.Id = "4f92cca3-acef-4c48-973d-1b28c85e251f"
_GO6Ie.Name = _d7gW("?4ap#V")
_GO6Ie.Description = _d7gW("mCPapt#P~L\029P?4ap#VP>LHC\029~L\029k")
_GO6Ie.Visible = true
_GO6Ie.Media = _MHFZ
_GO6Ie.Icon = _b9qJ
_GO6Ie.Commands = {
  _bMFzn = Wherigo.ZCommand({
    Text = _d7gW("0LHC\029~L\029\f"),
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = _d7gW("\\Z4a#PzL\vHC>rp\v")
  })
}
_GO6Ie.Commands._bMFzn.Custom = true
_GO6Ie.Commands._bMFzn.Id = "2c10ba9a-4130-4431-89d2-54647eafd1ea"
_GO6Ie.Commands._bMFzn.WorksWithAll = true
_GO6Ie.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_GO6Ie.Locked = false
_GO6Ie.Opened = false
_rnV = Wherigo.ZItem(_yCJ8)
_rnV.Id = "d63634fd-9bed-45aa-b574-33355709749a"
_rnV.Name = _d7gW("?2ZL|t#p\029~t41~Lt")
_rnV.Description = _d7gW("}LZP\\LCt#p\v#P~L\029PC,p,PA1~LPp\029>LrL\0295PCMPVC\vPL\029#t2\vL4aL\029~L\029P?#L||LPVCP_1MML\029-")
_rnV.Visible = true
_rnV.Media = _1iqV
_rnV.Icon = _Kh5OE
_rnV.Commands = {}
_rnV.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_rnV.Locked = false
_rnV.Opened = false
_hteO = Wherigo.ZTask(_yCJ8)
_hteO.Id = "a0c789b2-aaf3-4e5f-b9f6-48030805d9d2"
_hteO.Name = _d7gW("0pL\v#\029L\vPrLtC4aL\029")
_hteO.Description = _d7gW("mL\vPp|#LP0pL\v#\029L\vP\0041a\029#PZ\029P~L\vPp|#L\029P0pL\v#\029L\vLZ,")
_hteO.Visible = true
_hteO.Active = false
_hteO.Complete = false
_hteO.CorrectState = "None"
_bDTe = Wherigo.ZTask(_yCJ8)
_bDTe.Id = "06844fe7-e460-43bf-a781-409e9ef901d2"
_bDTe.Name = _d7gW("0pL\v#\029L\vPp\029t2\vL4aL\029")
_bDTe.Description = _d7gW("/ZL||LZ4a#Pap#P~L\vP0pL\v#\029L\vP\004LZ#L\vLP\015\029H1\vMp#Z1\029L\029,")
_bDTe.Visible = true
_bDTe.Active = false
_bDTe.Complete = false
_bDTe.CorrectState = "None"
_LRSL = Wherigo.ZTask(_yCJ8)
_LRSL.Id = "1f1a80e9-d21b-48e0-8e07-ea383fa183a2"
_LRSL.Name = _d7gW("\127p\v_L\029")
_LRSL.Description = _d7gW("\127p\v_LPrLZP~L\vPp\029>L>LrL\029L\029P;1>|Z4a_LZ#,")
_LRSL.Visible = true
_LRSL.Active = false
_LRSL.Complete = false
_LRSL.CorrectState = "None"
_giC6D = Wherigo.ZTask(_yCJ8)
_giC6D.Id = "7fb99b2a-e746-4ec9-a53e-4d3d1ac63357"
_giC6D.Name = _d7gW("\030CMP\002Z\029>p\029>")
_giC6D.Description = _d7gW("mL\vP\002Z\029>p\029>PZt#Pp\029P~L\vPtCL~1Lt#|Z4aL\029P\0024_LP~LtPc\vZL~a1HLtPrLZMP>\v1ttL\029P0L~L\029__\vLCV,")
_giC6D.Visible = true
_giC6D.Active = false
_giC6D.Complete = false
_giC6D.CorrectState = "None"
_viC = Wherigo.ZTask(_yCJ8)
_viC.Id = "3ad9bd25-271d-4a05-a669-868c3f76067e"
_viC.Name = _d7gW("mZLP0|C#aPtC4aL\029")
_viC.Description = _d7gW("/L\v|pttLP~L\029P\002Z\029>p\029>trL\vLZ4aPCLrL\vP~L\029P\031L>PZMP\\1\v~\004Lt#L\029PC\029~PmCPt1||#Lt#P~ZLP0|C#aPHZ\029~L\029,")
_viC.Visible = true
_viC.Active = false
_viC.Complete = false
_viC.CorrectState = "None"
_0Cp = Wherigo.ZTask(_yCJ8)
_0Cp.Id = "3502b781-a3b7-4d5e-b8e3-cbf6f0de8ed6"
_0Cp.Name = _d7gW("/1\v\029pML\029P\029L\029\029L\029")
_0Cp.Description = _d7gW("?C4aLP~L\029P0\vprt#LZ\029Pz1\029P?4a\004Lt#L\vP0|C#aPC\029~Pt2\vZ4aP~1\v#P~L\029P/1\v\029pML\029P~L\vP0|C#aP|pC#PpCt,")
_0Cp.Visible = true
_0Cp.Active = false
_0Cp.Complete = false
_0Cp.CorrectState = "None"
_VBp = Wherigo.ZTask(_yCJ8)
_VBp.Id = "fda60aec-819f-4087-b157-6a0bb3a3d341"
_VBp.Name = _d7gW("mL\029P\015\v\v|Z4a#L\v\029PH1|>L\029")
_VBp.Description = _d7gW("c1|>LP~L\vP?2C\vP~L\vP\015\v\v|Z4a#L\vPL\vt#P\029p4aP\\1\v~L\029PC\029~P~p\029\029P\029p4aP)t#L\0295PrZtPmCPpCHPL#\004ptP}Lt1\029~L\vLtPt#1Ltt#,")
_VBp.Visible = true
_VBp.Active = false
_VBp.Complete = false
_VBp.CorrectState = "None"
__gokc = Wherigo.ZTask(_yCJ8)
__gokc.Id = "ff1ed7f9-1113-49ee-b17d-be00d8522f31"
__gokc.Name = _d7gW(".LtCtPp\029tLaL\029")
__gokc.Description = _d7gW("\031L|4aL\vPx1L\v2L\v#LZ|PZt#P~LMPCM>Lt#CL\v#V#L\029P.LtCtPprap\029~L\029P>L_1MML\029kP?2\vZ4aPMZ#P?4a\004Lt#L\vP0|C#atP?LL|L\f")
__gokc.Visible = true
__gokc.Active = false
__gokc.Complete = false
__gokc.CorrectState = "None"
_ElmD = Wherigo.ZTask(_yCJ8)
_ElmD.Id = "cd740872-5b87-492b-a676-1ef4aef988cd"
_ElmD.Name = _d7gW("\030CMPp|#L\029P\019p#aapCt")
_ElmD.Description = _d7gW("c1|>LP~L\029P\015\v\v|Z4a#L\v\0295PrZtPmCPVCMPp|#L\029P\019p#aapCtP_1MMt#,")
_ElmD.Visible = true
_ElmD.Active = false
_ElmD.Complete = false
_ElmD.CorrectState = "None"
_su66 = Wherigo.ZTask(_yCJ8)
_su66.Id = "3a5176b5-8384-4c2c-b7cd-b18947dd4c7e"
_su66.Name = _d7gW("}L\vCHP\029L\029\029L\029")
_su66.Description = _d7gW("\031L\029\029PmCP~L\029P0\vprt#LZ\029P>LHC\029~L\029Papt#5PtZLa\bPZa\029PmZ\vP>L\029pCPp\029PC\029~P\029L\029\029LP~L\029PL\vt#L\029P}L\vCHP~LtPp|#L\029P\019p#aapCt,")
_su66.Visible = true
_su66.Active = false
_su66.Complete = false
_su66.CorrectState = "None"
_hiZt = Wherigo.ZTask(_yCJ8)
_hiZt.Id = "659c56b4-1b09-4514-8176-122f673eed06"
_hiZt.Name = _d7gW("\031LZa\004pttL\vrL4_L\029PHZ\029~L\029")
_hiZt.Description = _d7gW("c1|>LP~L\029P\015\v\v|Z4a#L\v\029PVCMP>\v1ttL\029Px\vLCVPC\029~P~p\029\029P~L\029PV\004LZ#L\029P\031L>P\vL4a#tPrZtPVCMP_|LZ\029L\029P\031LZa\004pttL\vrL4_L\029,")
_hiZt.Visible = true
_hiZt.Active = false
_hiZt.Complete = false
_hiZt.CorrectState = "None"
_GWl = Wherigo.ZTask(_yCJ8)
_GWl.Id = "784cc8d3-b8dc-4afb-b65d-2d6f39b3ee34"
_GWl.Name = _d7gW("?2C\vPHZ\029~L\029")
_GWl.Description = _d7gW("?C4aLPLZ\029LP?2C\vPZ\029P~L\vP\\pLaLP~LtP\031LZa\004pttL\vrL4_L\029tPg;Z4\v1\"m1tLPMZ#P|pMZ\029ZL\v#LMP\030L##L|P~p\vZ\029\024,")
_GWl.Visible = true
_GWl.Active = false
_GWl.Complete = false
_GWl.CorrectState = "None"
_BIKo = Wherigo.ZTask(_yCJ8)
_BIKo.Id = "57ba8fe7-9dc7-45a4-8f06-30b61fa81d52"
_BIKo.Name = _d7gW("}|C#t2C\vPC\029#L\vtC4aL\029")
_BIKo.Description = _d7gW("h\029#L\vtC4aLP~ZLP}|C#t2C\vP>L\029pCL\vPpCHP`Z\029\004LZtL,PmL\029_Pp\029PmLZ\029P0Lt2\vpL4aPMZ#Pc\vpCP}\vZb\029L\v\f")
_BIKo.Visible = true
_BIKo.Active = false
_BIKo.Complete = false
_BIKo.CorrectState = "None"
_umvVT = Wherigo.ZTask(_yCJ8)
_umvVT.Id = "f27e7057-905a-48f4-aaca-02292d7e07c1"
_umvVT.Name = _d7gW("\030CMP\019p#aapCt")
_umvVT.Description = _d7gW("0LaLPL\vt#Mp|PVC\vCL4_PVCMP0\vprP~LtP`L\v\v\029P\019p#aapCt")
_umvVT.Visible = true
_umvVT.Active = false
_umvVT.Complete = false
_umvVT.CorrectState = "None"
_O7fd = Wherigo.ZTask(_yCJ8)
_O7fd.Id = "0dd11594-19df-43f1-ae4e-240ae3268930"
_O7fd.Name = _d7gW("/p#L\vP`pttPtC4aL\029")
_O7fd.Description = _d7gW("?4a\004Lt#L\vP0|C#aPap##LPLZ\029L\029P0LZt#Ltr|Z#V,P?ZLP\004LZt#PmZ\vP~L\029P\031L>PVCP/p#L\vP`ptt\f")
_O7fd.Visible = true
_O7fd.Active = false
_O7fd.Complete = false
_O7fd.CorrectState = "None"
_s44R = Wherigo.ZTask(_yCJ8)
_s44R.Id = "efe2c8f9-796e-48b7-8321-6f3bfece7794"
_s44R.Name = _d7gW("?#L\vrL~p#CMP\029L\029\029L\029")
_s44R.Description = _d7gW("?C4aLP~L\029P0\vprt#LZ\029PC\029~P\029L\029\029LP[\029rt2q~ptP?#L\vrL~p#CMPz1\029P;C##L\vP`ptt,")
_s44R.Visible = true
_s44R.Active = false
_s44R.Complete = false
_s44R.CorrectState = "None"
_4dH = Wherigo.ZTask(_yCJ8)
_4dH.Id = "c09b7619-a408-49d5-8ae1-b688fe5a6121"
_4dH.Name = _d7gW("cCttpr~\vC4_PtC4aL\029")
_4dH.Description = _d7gW("c1|>LP~LMP\031L>PrZtPVC\vPcCttpr~\vC4_,PmZLP\015\v\v|Z4a#L\vP>LrL\029PmZ\vPLZ\029L\029PuZ225P\0041PmCPZa\029PHZ\029~L\029P_p\029\029t#Pg?Mp||\"m1tLPMZ#P|pMZ\029ZL\v#LMPcCttpr~\vC4_P~p\vZ\029\024,")
_4dH.Visible = true
_4dH.Active = false
_4dH.Complete = false
_4dH.CorrectState = "None"
_7MM8P = Wherigo.ZTask(_yCJ8)
_7MM8P.Id = "60da430c-42c7-455a-a1ee-1e5f0d88ddac"
_7MM8P.Name = _d7gW("cCttpr~\vC4_PZ~L\029#ZHZVZL\vL\029")
_7MM8P.Description = _d7gW("cZ\029~LPLZ\029L\029PUm\">L~\vC4_#L\029PcC?pr~\vC4_PC\029~Pt#L||LP~ZLP\vZ4a#Z>LP?4aCaMp\v_LPHLt#")
_7MM8P.Visible = true
_7MM8P.Active = false
_7MM8P.Complete = false
_7MM8P.CorrectState = "None"
_udHM = Wherigo.ZTask(_yCJ8)
_udHM.Id = "eb636470-5bbc-45cb-bc91-188800a35fb6"
_udHM.Name = _d7gW("\\pL4at#L\vPcCttpr~\vC4_")
_udHM.Description = _d7gW("cZ\029~LP~ZLP?#L||L5P\0041PVC|L#V#P?4aCaLP~ZLtL\vP;p\v_LP~L\029P}1~L\029PrL#\vL#L\029PaprL\029")
_udHM.Visible = true
_udHM.Active = false
_udHM.Complete = false
_udHM.CorrectState = "None"
_68Hip = Wherigo.ZTask(_yCJ8)
_68Hip.Id = "6ee6677a-424d-4cdb-910b-f346f5b3e9f6"
_68Hip.Name = _d7gW("\030CMPL\vt#L\029PcCttpr~\vC4_")
_68Hip.Description = _d7gW("0LaLP\02914aMp|PVC\vCL4_PC\029~PtZLaPmZ\vP~1\v#P~ZLP?4aCaMp\v_LP\02914aMp|P>L\029pCL\vPp\029,")
_68Hip.Visible = true
_68Hip.Active = false
_68Hip.Complete = false
_68Hip.CorrectState = "None"
_KmA5l = Wherigo.ZTask(_yCJ8)
_KmA5l.Id = "adbbcb3f-4d94-4f71-838f-01ca36ff5536"
_KmA5l.Name = _d7gW(".C\029>tPHp\029>L\029")
_KmA5l.Description = _d7gW("c1|>LP~L\029P.C\029>tPt4a\029L||P>L\029C>5PCMPtZLPLZ\029VCa1|L\029")
_KmA5l.Visible = true
_KmA5l.Active = false
_KmA5l.Complete = false
_KmA5l.CorrectState = "None"
_W4_ = Wherigo.ZTask(_yCJ8)
_W4_.Id = "7562b626-9213-4cfe-be11-5e54bcd6127a"
_W4_.Name = _d7gW(".C\029>tPp\029t2\vL4aL\029")
_W4_.Description = _d7gW("?2\vZ4aP~ZLP.C\029>tPp\029")
_W4_.Visible = true
_W4_.Active = false
_W4_.Complete = false
_W4_.CorrectState = "None"
_5EDI = Wherigo.ZTask(_yCJ8)
_5EDI.Id = "c0425c21-f85b-476b-8661-4aa4ba495830"
_5EDI.Name = _d7gW("\\pML\029P\029L\029\029L\029")
_5EDI.Description = _d7gW("?p>LP~L\029P\vZ4a#Z>L\029P\\pML\029P~LtPpL|#Lt#L\029P.C\029>L\029")
_5EDI.Visible = true
_5EDI.Active = false
_5EDI.Complete = false
_5EDI.CorrectState = "None"
_cHUT = Wherigo.ZTask(_yCJ8)
_cHUT.Id = "fded7ad1-5282-4ee3-9bcd-7632e844fe5a"
_cHUT.Name = _d7gW(".C\029>tPH1|>L\029")
_cHUT.Description = _d7gW("EpttPmZ\vPz1\029P~L\029P.C\029>tP~ptP/L\vt#L4_PVLZ>L\029")
_cHUT.Visible = true
_cHUT.Active = false
_cHUT.Complete = false
_cHUT.CorrectState = "None"
_yfpk = Wherigo.ZTask(_yCJ8)
_yfpk.Id = "e70c8cdc-9dfe-456e-814d-b112e6987333"
_yfpk.Name = _d7gW("A1~LPLZ\029>LrL\029")
_yfpk.Description = _d7gW("0ZrP~L\029PA1~LPz1\029P~L\vPL\vt#L\029P?LZ#LP~LtPE1>rC4aLtPLZ\0295PCMP~L\029Pc\vLZt4ap|#41~LPHCL\vP\031aL\vLZ>1PVCPrL_1MML\029,")
_yfpk.Visible = true
_yfpk.Active = false
_yfpk.Complete = false
_yfpk.CorrectState = "None"
_zElG = Wherigo.ZTask(_yCJ8)
_zElG.Id = "2856f31f-cb0a-4ba3-b409-2a984dd00728"
_zElG.Name = _d7gW("\030C\vCL4_PVCMPx\vLCV")
_zElG.Description = _d7gW("0LaLPVC\vCL4_PrZtPVCMP|L#V#L\029Px\vLCV5PzZL||LZ4a#PHpL||#P?4a\004Lt#L\vP0|C#aP~p\029\029P\004ZL~L\vPLZ\0295P\004ZLPMp\029PVCP/p#L\vP`pttP_1MM#,,,")
_zElG.Visible = true
_zElG.Media = _8FWf
_zElG.Active = false
_zElG.Complete = false
_zElG.CorrectState = "None"
_wUCn = Wherigo.ZTask(_yCJ8)
_wUCn.Id = "c95517d3-ee98-4944-81b5-bca6847cfa4f"
_wUCn.Name = _d7gW("c\vpCP}\vZb\029L\vPVCa1L\vL\029")
_wUCn.Description = _d7gW("c\vpCP}\vZb\029L\vPtZLa#PpCt5Pp|tP1rP?ZLPC\029rL~Z\029>#PL#\004ptPL\vVpLa|L\029P\0041||#L")
_wUCn.Visible = true
_wUCn.Active = false
_wUCn.Complete = false
_wUCn.CorrectState = "None"
_3hY = Wherigo.ZTask(_yCJ8)
_3hY.Id = "615d4b55-c299-4ce5-ad83-bb9cc8e5ce02"
_3hY.Name = _d7gW("xpHHLLP#\vZ\029_L\029")
_3hY.Description = _d7gW("c\vpCP}\vZb\029L\vP\004LZttPrLt#ZMM#P\02914aPMLa\v,PGCttL\v~LMPZt#PtZLPrL|LZ~Z>#5P\004L\029\029P~L\vPxpHHLLP_p|#P\004Z\v~,")
_3hY.Visible = true
_3hY.Active = false
_3hY.Complete = false
_3hY.CorrectState = "None"
_J1dP1 = Wherigo.ZTask(_yCJ8)
_J1dP1.Id = "554502ef-d2e3-49e8-8541-1fc1c8e5feaa"
_J1dP1.Name = _d7gW("0|C#aPrLt4a\0041L\vL\029")
_J1dP1.Description = _d7gW("}Lt4a\0041L\vLP~ZLP?LL|LP~L\vP?4a\004Lt#L\vP0|C#a5PMZ#PmZ\vPVCP_1MML\029,")
_J1dP1.Visible = true
_J1dP1.Active = false
_J1dP1.Complete = false
_J1dP1.CorrectState = "None"
_Jedy = Wherigo.ZTask(_yCJ8)
_Jedy.Id = "35a9730b-c8de-4d50-bbc4-d48ae9244206"
_Jedy.Name = _d7gW("0|C#aPrLH\vp>L\029")
_Jedy.Description = _d7gW("?2\vZ4aPMZ#P?4a\004L#tL\vP0|C#atP?LL|LPCMPaL\vpCtVCrL_1MML\0295P\004ptP?ZLP\004LZtt,")
_Jedy.Visible = true
_Jedy.Active = false
_Jedy.Complete = false
_Jedy.CorrectState = "None"
_zXAOJ = Wherigo.ZTask(_yCJ8)
_zXAOJ.Id = "4cd641fa-7eab-49f5-804e-f808cfa6643b"
_zXAOJ.Name = _d7gW("\019p#aapCtPrLH\vp>L\029")
_zXAOJ.Description = _d7gW("\031LZttP`L\v\vP\019p#aapCtPL#\004ptPCLrL\vP~ZLP.C\029>tkP?4a\004Lt#L\vP0|C#aP_p\029\029PmZ\vPrLt#ZMM#PaL|HL\0295PL#\004ptPaL\vpCtVCHZ\029~L\029,")
_zXAOJ.Visible = true
_zXAOJ.Active = false
_zXAOJ.Complete = false
_zXAOJ.CorrectState = "None"
_8qtX = Wherigo.ZTask(_yCJ8)
_8qtX.Id = "31cdaa42-7a47-47e5-bad5-dd49abc4c830"
_8qtX.Name = _d7gW("`pttPrLH\vp>L\029")
_8qtX.Description = _d7gW("\031LZttP/p#L\vP`pttPL#\004ptPCLrL\vP~ZLP.C\029>tkP?4a\004Lt#L\vP0|C#aP_p\029\029PmZ\vPrLt#ZMM#PaL|HL\0295PL#\004ptPaL\vpCtVCHZ\029~L\029,")
_8qtX.Visible = true
_8qtX.Active = false
_8qtX.Complete = false
_8qtX.CorrectState = "None"
_KxPr = Wherigo.ZTask(_yCJ8)
_KxPr.Id = "be73a38f-e1a9-440f-bf72-e9d069614e9b"
_KxPr.Name = _d7gW("\\p4aP?CL~L\029")
_KxPr.Description = _d7gW("/p#L\vP`pttPtp>#L5P~ZLP.C\029>tPtLZL\029P\029p4aP)t#L\029PC\029~P~p\029\029P~L\029PL\vt#L\029P\031L>P\029p4aP?CL~L\029P>L>p\029>L\029,Pc1|>LP\015a\029L\029\f")
_KxPr.Visible = true
_KxPr.Active = false
_KxPr.Complete = false
_KxPr.CorrectState = "None"
_bqo = Wherigo.ZTask(_yCJ8)
_bqo.Id = "749b58cb-ce6e-4a0c-916d-b4b3ceeaef54"
_bqo.Name = _d7gW("\\1#ZVrC4aPp\029tLaL\029")
_bqo.Description = _d7gW("mCPapt#PLZ\029LPxp\v#LPz1\029Pc\vpCP}\vZb\029L\vPrL_1MML\0295P~ZLPmCPZ\029tP\\1#ZVrC4aP>L|L>#Papt#,P?4apC\bPtZLPmZ\vPMp|Pp\029\f")
_bqo.Visible = true
_bqo.Active = false
_bqo.Complete = false
_bqo.CorrectState = "None"
_6U_k = Wherigo.ZTask(_yCJ8)
_6U_k.Id = "c6a83c56-305d-49f3-b3b5-f77a49d37cee"
_6U_k.Name = _d7gW("/L\vt#L4_#Pap|#L\029")
_6U_k.Description = _d7gW("`p|#LPmZ4aPV\004LZP;Z\029C#L\029PzL\vt#L4_#5PrZtP~ZLP.C\029>tP\004ZL~L\vPpCH#pC4aL\029,")
_6U_k.Visible = true
_6U_k.Active = false
_6U_k.Complete = false
_6U_k.CorrectState = "None"
_vAzTb = Wherigo.ZTask(_yCJ8)
_vAzTb.Id = "d2999a17-2240-41df-8fe5-3d123e4d1ba1"
_vAzTb.Name = _d7gW("G\029P.C\029>tPp\029t4a|LZ4aL\029")
_vAzTb.Description = _d7gW("?4a|LZ4aLPmZ4aPz1\vtZ4a#Z>Pp\029P~ZLP.C\029>tPp\029,")
_vAzTb.Visible = true
_vAzTb.Active = false
_vAzTb.Complete = false
_vAzTb.CorrectState = "None"
_AYO = true
_JuZO1 = ""
_3E8_p = ""
backup1Code = ""
backup2Code = ""
backup3Code = ""
compCode = ""
backup4Code = ""
backup5Code = ""
backup6Code = ""
_aJrHZ = _d7gW("lAc1\0042")
_W8QYq = _d7gW("lU~.\0147")
_odHHs = _d7gW("lLmn\004")
_iXUT = _d7gW("la#L)")
_ZnMyR = _d7gW("l\0204_")
_PA2C = _d7gW("lcE4\019")
_yCJ8.ZVariables = {
  _AYO = true,
  _JuZO1 = "",
  _3E8_p = "",
  backup1Code = "",
  backup2Code = "",
  backup3Code = "",
  compCode = "",
  backup4Code = "",
  backup5Code = "",
  backup6Code = "",
  _aJrHZ = _d7gW("lAc1\0042"),
  _W8QYq = _d7gW("lU~.\0147"),
  _odHHs = _d7gW("lLmn\004"),
  _iXUT = _d7gW("la#L)"),
  _ZnMyR = _d7gW("l\0204_"),
  _PA2C = _d7gW("lcE4\019")
}
_FLcR = Wherigo.ZTimer(_yCJ8)
_FLcR.Id = "cd33b010-efa3-48d0-b681-09f88c5b2010"
_FLcR.Name = _d7gW(".C\029>tPLZ\029a1|L\029")
_FLcR.Description = ""
_FLcR.Visible = true
_FLcR.Duration = 90
_FLcR.Type = "Countdown"
_We7 = Wherigo.ZTimer(_yCJ8)
_We7.Id = "d2adbdb3-aac7-433e-840c-70a0bfc85afd"
_We7.Name = _d7gW("GCHP.C\029>tP\004p\v#L\029")
_We7.Description = ""
_We7.Visible = true
_We7.Duration = 120
_We7.Type = "Countdown"
_Xyvl = Wherigo.ZTimer(_yCJ8)
_Xyvl.Id = "e5b53166-bfe1-40fd-b3d2-d736d893acca"
_Xyvl.Name = _d7gW("`p\029~\014\"G\029\vCH")
_Xyvl.Description = ""
_Xyvl.Visible = true
_Xyvl.Duration = 30
_Xyvl.Type = "Countdown"
_qck = Wherigo.ZInput(_yCJ8)
_qck.Id = "a63d54ce-72d2-414c-a800-83f4ad6d6784"
_qck.Name = _d7gW("cC\029~PpMP\031LZa\004pttL\vrL4_L\029")
_qck.Description = _d7gW("\031ptPapt#PmCP~L\029\029P>LHC\029~L\029k")
_qck.Visible = true
_qck.Choices = {
  "Fingerabdruecke",
  "Blutspur",
  "Kleidungsfetzen"
}
_qck.InputType = "MultipleChoice"
_qck.Text = _d7gW("\031ptPapt#PmCP~L\029\029P>LHC\029~L\029k")
_3D8s = Wherigo.ZInput(_yCJ8)
_3D8s.Id = "6b5d340a-02b3-4b34-abaa-c31041630ce7"
_3D8s.Name = _d7gW("\002\029#~L4_C\029>PrLZP~L\vP}|C#t2C\v")
_3D8s.Description = ""
_3D8s.Visible = true
_3D8s.Choices = {
  "Schwester Rache",
  "Bruder Mord",
  "Vater Hass"
}
_3D8s.InputType = "MultipleChoice"
_3D8s.Text = _d7gW("?1t15PmCPapt#PrLZP~L\vP}|C#t2C\vPp|t1PLZ\029L\029P`Z\029\004LZtPL\029~L4_#5P~L\vP`Z|HLPzL\vt2\vZ4a#,&}\019=\031L\vP1~L\vP\004ptP_p\029\029PmZ\vPaL|HL\029k")
_DunBe = Wherigo.ZInput(_yCJ8)
_DunBe.Id = "1773ffd2-2d4e-4dd7-a50f-e2aaf7a818d4"
_DunBe.Name = _d7gW("\031Z\v_|Z4aPVC\vCL4_t4aZ4_L\029k")
_DunBe.Description = _d7gW("?Z4aL\vaLZ#tprH\vp>L5P~pMZ#P?4a\004Lt#L\vP0|C#a\btP?LL|LP\029Z4a#PzL\vtLaL\029#|Z4aPVC\vCL4_>Lt4aZ4_#P\004Z\v~,")
_DunBe.Visible = true
_DunBe.Choices = {"Ja", "Nein"}
_DunBe.InputType = "MultipleChoice"
_DunBe.Text = _d7gW("\031L\029\029PmCP~ZLtL\029P?#LZ\029P\004L>\004Z\vHt#5P\004Z\v~P?4a\004Lt#L\vP0|C#a\btP?LL|LPVC\vCL4_>Lt4aZ4_#,P}Zt#PmCPtZ4aL\v5P~pttPmCP~ptP\004Z||t#k")
_AVfxJ = Wherigo.ZInput(_yCJ8)
_AVfxJ.Id = "950ce9bf-88e1-4fe8-8a14-e2df3218da8d"
_AVfxJ.Name = _d7gW("\031ptPZt#PMZ#P.LtCtk")
_AVfxJ.Description = _d7gW("GrH\vp>L5P1rPMp\029PpC4aP#p#tp4a|Z4aPrLZP.LtCtPp\029>L_1MML\029PZt#,")
_AVfxJ.Visible = true
_AVfxJ.Choices = {
  "Eine Hand",
  "Ein Teil vom Kopf",
  "Ein Fuss"
}
_AVfxJ.InputType = "MultipleChoice"
_AVfxJ.Text = _d7gW("\031ptPHLa|#P~LMP.LtCtPpMPx\vLCVk")
_QfZ9 = Wherigo.ZInput(_yCJ8)
_QfZ9.Id = "a4741861-e23a-4adb-9e92-cc7c017f559a"
_QfZ9.Name = _d7gW("cCttpr~\vC4_P>LHC\029~L\029")
_QfZ9.Description = ""
_QfZ9.Visible = true
_QfZ9.Choices = {
  "Puma",
  "Nike",
  "Adidas"
}
_QfZ9.InputType = "MultipleChoice"
_QfZ9.Text = _d7gW("/1\029P\004L|4aL\vPuC\v\029t4aCaMp\v_LPt#pMM#P~L\vPGr~\vC4_P~L\029\029k&}\019=")
_UcC8 = Wherigo.ZInput(_yCJ8)
_UcC8.Id = "e250eee5-aad2-4e12-9c05-b676aa667ab5"
_UcC8.Name = _d7gW("\\pML\029P~LtP>\v1Ltt#L\029P.C\029>L\029P\vp#L\029")
_UcC8.Description = ""
_UcC8.Visible = true
_UcC8.Choices = {
  "Klaus",
  "Hans",
  "Peter"
}
_UcC8.InputType = "MultipleChoice"
_UcC8.Text = _d7gW("mCPrZt#,,,")
_slMsS = Wherigo.ZInput(_yCJ8)
_slMsS.Id = "2388e819-f239-494c-a1ff-8386801832f5"
_slMsS.Name = _d7gW("EZLtP~L\029P/1\v\029pML\029")
_slMsS.Description = ""
_slMsS.Visible = true
_slMsS.Media = _aJX
_slMsS.InputType = "Text"
_slMsS.Text = _d7gW("\031ZLPaZLttP?4a\004Lt#L\vP0|C#aPMZ#P/1\v\029pML\029k")
_Jsc = Wherigo.ZInput(_yCJ8)
_Jsc.Id = "470ec987-3958-4290-be0c-7d1df8e9acaa"
_Jsc.Name = _d7gW("}L\vCHP\vp#L\029")
_Jsc.Description = ""
_Jsc.Visible = true
_Jsc.Media = __ruD
_Jsc.InputType = "Text"
_Jsc.Text = _d7gW("?p>\bPMZ\vPrZ##LP~ZLPL\vt#LP?Z|rLPg7P}C4at#prL\029\024P~LtPL\vt#L\029P}L\vCHLtPz1\029P`L\v\v\029P\019p#aapCt5PL\vP\004p\vP,,,,,\"PC\029~P`p\029~L|t>pL\v#\029L\vP-")
_ha0js = Wherigo.ZInput(_yCJ8)
_ha0js.Id = "e90c0532-f763-4bd4-89ab-2c4004376a35"
_ha0js.Name = _d7gW("u1~Lt(pa\vP\vp#L\029")
_ha0js.Description = ""
_ha0js.Visible = true
_ha0js.Choices = {
  "1932",
  "1935",
  "Keines angegeben"
}
_ha0js.InputType = "MultipleChoice"
_ha0js.Text = _d7gW("\031L|4aLtPu1~Lt(pa\vPZt#PrLZP;C##L\vP`pttPp\029>L>LrL\029k")
_9X2 = Wherigo.ZInput(_yCJ8)
_9X2.Id = "f2288e78-5199-414c-983a-c4529bae2d6b"
_9X2.Name = _d7gW("?2ZL|t#p\029~")
_9X2.Description = _d7gW("0ZrP~L\029PA1~LPHC\vPLZ\029L\029P?2ZL|t#p\029~PLZ\0295PCMPp\029P~ZLtL\vP?#L||LP\004ZL~L\vPpCHVCtL#VL\029,P}L>ZrPmZ4aP~p\029\029PZ\029P~ZLP\vZ4a#Z>LP\0301\029L,P}LZPC\029>C|#Z>LMPA1~LPrL>Z\029\029#P~ptP?2ZL|PpMP?#p\v#,")
_9X2.Visible = true
_9X2.Media = _1iqV
_9X2.InputType = "Text"
_9X2.Text = _d7gW("mL\vPA1~LP|pC#L#k&}\019=")
_0J2 = Wherigo.ZInput(_yCJ8)
_0J2.Id = "51266ac4-47f9-4fba-97a9-01dfcb4de862"
_0J2.Name = _d7gW("?2ZL|t#p\029~Ep~L\029")
_0J2.Description = ""
_0J2.Visible = true
_0J2.Media = _1iqV
_0J2.Choices = {"Ja", "Nein"}
_0J2.InputType = "MultipleChoice"
_0J2.Text = _d7gW("\031Z||t#PLZ\029L\029P?2ZL|t#p\029~P|p~L\029k")
function _yCJ8:OnStart()
  if _G[_d7gW("\002\029z")][_d7gW("\127|p#H1\vM")] == _d7gW("\031Z\029U\023") or _G[_d7gW("\002\029z")][_d7gW("mLzZ4L\015m")] == _d7gW("mLt_#12") then
    for k, v in pairs(_G[_d7gW("l\014A.\a")][_d7gW("G||\030)r(L4#t")]) do
      v[_d7gW("/ZtZr|L")] = false
      v[_d7gW("G4#ZzL")] = false
    end
    _Urwigo.MessageBox({
      Text = tostring(_d7gW("?2ZL|L\029PZMP?ZMC|p#1\vPZt#P\029Z4a#PHpZ\v\f")),
      Callback = function(action)
        if action ~= nil then
          _G[_d7gW("\031aL\vZ>1")][_d7gW("A1MMp\029~")](_d7gW("?pzLA|1tL"))
        end
      end
    })
    return
  end
  _Urwigo.MessageBox({
    Text = _d7gW("GCH>\vC\029~PMLa\vL\vL\vP}Lt4a\004L\v~L\029PrZ##LPZ4aPLZ\029~\vZ\029>|Z4a5P\004L~L\vP~ZLPG\029\0041a\029L\vP\029LrL\029P~LMPc\vZL~a1HP\02914aP~L\vL\029P`C\029~LPV,},P~C\v4aPEpL\vMP1~L\vPELC4a#L\029PZ\029P0pL\v#L\029PC\029~P`pLCtL\vPVCPrL|pLt#Z>L\029\f"),
    Media = _Lw0qG,
    Callback = function(action)
      if action ~= nil then
        compCode = string.sub(Player.CompletionCode, 1, 15)
        calcBackupCodes()
        _Urwigo.RunDialogs(function()
          Wherigo.GetInput(_0J2)
        end)
      end
    end
  })
end
function _yCJ8:OnRestore()
end
function _CFowp:OnEnter()
  _aJrHZ = _d7gW("lAc1\0042")
  Wherigo.PlayAudio(_Yf6k)
  _giC6D.Active = false
  _NNXV.Active = false
  _MC1oP.Active = false
  _viC.Active = true
  Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _CFowp)
end
function _CFowp:OnExit()
  _aJrHZ = _d7gW("lAc1\0042")
  _NCt5.Active = true
end
function startzone:OnExit()
  _aJrHZ = _d7gW("t#p\v#V1\029L")
  if _hteO.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("c\vpCP}\vZb\029L\vP\vCH#PMZ\vP\02914aPaZ\029#L\vaL\v-P!?LZL\029P?ZLPr|1ttPz1\vtZ4a#Z>PpCHP~LMPzL\v|pttL\029L\029Pc\vZL~a1H5P`L\v\vP\015\029t2L_#1\v\fPh\029~PzL\v>LttL\029P?ZLP\015a\vLPh/\"EpM2LP\029Z4a#\f!"),
      Media = _pKP41,
      Buttons = {
        _d7gW(".p(p,,,")
      },
      Callback = function(action)
        if action ~= nil then
          startzone.Active = false
          _MC1oP.Active = true
          _3dJy5:MoveTo(nil)
          _eD9w:MoveTo(nil)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("c\vpCP}\vZb\029L\vPt#La#PZ\029P~L\vPuCL\vPC\029~P\004Z\029_#PaLH#Z>5Pp\029t4aLZ\029L\029~P\0041||#LP?ZLPMZ\vPC\029rL~Z\029>#P\02914aPL#\004ptP\004Z4a#Z>LtPtp>L\029,PGMPrLt#L\029PZ4aPHpa\vLP\02914aMp|PVC\vCL4_PVC\vPcL\vZL\029\0041a\029C\029>\f"),
      Media = _pKP41
    })
  end
end
function _NNXV:OnEnter()
  _aJrHZ = _d7gW("l\\\\\027/")
  startzone.Active = false
  _hteO.Active = false
  _e4Q.Visible = true
  _bDTe.Active = true
  Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _NNXV)
end
function _NNXV:OnExit()
  _aJrHZ = _d7gW("l\\\\\027/")
  if _AYO == true then
    _Urwigo.MessageBox({
      Text = _d7gW("mZ\vPHp||L\029Pc\vpCP}\vZb\029L\vtP\0311\v#LPLZ\029-P!?LZL\029P?ZLPr|1ttPz1\vtZ4a#Z>5P\004L\029\029P?ZLPVCMPzL\v|pttL\029L\029Pc\vZL~a1HP>LaL\029\f!"),
      Media = _pKP41,
      Buttons = {
        _d7gW(";MMMa,,,")
      }
    })
    _AYO = false
  end
end
function _MC1oP:OnEnter()
  _aJrHZ = _d7gW("l;A\t1\127")
  Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _MC1oP)
end
function _NCt5:OnEnter()
  _aJrHZ = _d7gW("l\\A#7")
  if _viC.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup1Code,
        Media = _1iqV
      },
      {
        Text = _d7gW("mCPapt#P(L#V#PLZ\029LPEZt#LP~L\vP?2ZL|t#p\029~t41~LtPZMP\015\029zL\029#p\v5PZ\029P~ZLPp||LPA1~LtPLZ\029>L#\vp>L\029P\004L\v~L\029,")
      }
    }, function(action)
      _rnV:MoveTo(Player)
      _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
      _viC.Active = false
      _0Cp.Active = true
      _CFowp.Active = false
      _NCt5.Media = _aJX
      _NCt5.Description = _d7gW("`ZL\vPZ\v>L\029~\0041P|ZL>#P?4a\004Lt#L\vP0|C#aPrLL\v~Z>#5P~\vCMPMLZ\029#LP~L\vPp|#LP0pL\v#\029L\v5PZ4aPt1||PVCL\vt#PVC\vP0|C#aP>LaL\029,PmL\029P0\vprt#LZ\029PMCttPZ4aPMZ\vP\0041a|PMp|P>L\029pCL\vPp\029tLaL\029,")
      _NCt5.Name = _d7gW("?4a\004Lt#L\vP0|C#atP0\vpr")
      _NCt5.Media = _aJX
      _ZIe:MoveTo(_NCt5)
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _NCt5)
    end)
  end
end
function _y3_Ad:OnEnter()
  _aJrHZ = _d7gW("l\014UlG~")
  if _ElmD.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup3Code,
      Media = _1iqV,
      Callback = function(action)
        if action ~= nil then
          _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\019p#aapCtP>LHC\029~L\029-P")) .. backup3Code
          _ElmD.Active = false
          _su66.Active = true
          _y3_Ad.Name = _d7gW("`L\v\vP\019p#aapCt\bP0\vpr")
          _y3_Ad.Description = _d7gW("`ZL\vP|ZL>#P~ZLP\vpt#|1tLP?LL|LPz1\029P`L\v\v\029P\019p#aapCt5P~ZLP_p\029\029PMZ\vPrLt#ZMM#PaL|HL\029,P;p|PtLaL\0295P\0041PtLZ\029P0\vprt#LZ\029PZt#,P\031L\029\029PmCPZa\029P>LHC\029~L\029Papt#5PtZLa\bPZa\029PmZ\vP>L\029pCPp\029,")
          _z3g0:MoveTo(_y3_Ad)
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _y3_Ad)
        end
      end
    })
  end
end
function _4SzwM:OnEnter()
  _aJrHZ = _d7gW("l\018?V\004;")
  if _zElG.Active == true then
    _zElG.Active = false
    _O7fd.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("?4a\004Lt#L\vP0|C#a\btP?LL|LPt4aLZ\029#PLZ\029L\029P0LZt#Ltr|Z#VP>Lapr#PVCPaprL\0295PVCMZ\029~Lt#P_|p\029>PtZLPt1P_1MZt4a,,,&}\019=&}\019=/ZL||LZ4a#Pt1||#LPZ4aPMp|PMZ#PZa\vP\vL~L\029,,,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _fsfyQ:OnEnter()
  _aJrHZ = _d7gW("lHtH\014X")
  if _O7fd.Active == true then
    _O7fd.Active = false
    _Urwigo.MessageBox({
      Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup5Code,
      Media = _1iqV,
      Callback = function(action)
        if action ~= nil then
          _rnV.Description = (_rnV.Description .. _d7gW("&}\019=`pttP>LHC\029~L\029-P")) .. backup5Code
          _s44R.Active = true
          _fsfyQ.Description = _d7gW("mptP0\vprPz1\029P/p#L\vPC\029~P;C##L\vP`ptt,,,P?C4aLP~L\029P0\vprt#LZ\029PC\029~PtZLa\bPZa\029PmZ\vP>L\029pCPp\029\f")
          _zrZ:MoveTo(_fsfyQ)
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _fsfyQ)
        end
      end
    })
  end
end
function _6MVMb:OnEnter()
  _aJrHZ = _d7gW("l8;/;r")
  if _VBp.Active == true then
    _VBp.Active = false
    _Urwigo.MessageBox({
      Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup2Code,
      Callback = function(action)
        if action ~= nil then
          _rnV.Description = (_rnV.Description .. _d7gW("&}\019=.LtCtP>LHC\029~L\029-P")) .. backup2Code
          __gokc.Active = true
          _QxT.Commands._hzu.Enabled = true
          _QxT.Commands._HwPv.Enabled = false
          _NCt5.Active = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _6MVMb)
        end
      end
    })
  end
end
function _paM81:OnEnter()
  _aJrHZ = _d7gW("l2p;\a\t")
  if _4dH.Active == true then
    _4dH.Active = false
    _Urwigo.MessageBox({
      Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup6Code,
      Media = _1iqV,
      Callback = function(action)
        if action ~= nil then
          _rnV.Description = (_rnV.Description .. _d7gW("&}\019=cCttpr~\vC4_P>LHC\029~L\029-P")) .. backup6Code
          _7MM8P.Active = true
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _paM81)
        end
      end
    })
  elseif _68Hip.Active == true then
    _68Hip.Active = false
    _7MM8P.Active = true
    Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _paM81)
  end
end
function _Yn7T:OnEnter()
  _aJrHZ = _d7gW("lO\029\022u")
  if _udHM.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("mL\vP}1~L\029Ptp>#PMZ\v5P~pttPaZL\vPVC|L#V#P(LMp\029~PMZ#PG~Z~pt\"?4aCaL\029P\004p\v,PG||L\v~Z\029>tPZt#P~ptPt4a1\029PV\004LZP\03114aL\029PaL\v5PrZt#PmCPtZ4aL\v5P~pttPmCP~ZLP\vZ4a#Z>LP?4aCaMp\v_LPL\v_p\029\029#Papt#kP0La\bP\02914aMp|PVC\vCL4_PVCMP?4aCapr~\vC4_5PtZLaPZa\029PmZ\vP\02914aMp|Pp\029PC\029~P~p\029\029PrLH\vp>LPZ4aP~L\029P}1~L\029P\02914aMp|,P"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")a(L\f")
      },
      Callback = function(action)
        if action ~= nil then
          _Yn7T.Active = false
          _udHM.Active = false
          _paM81.Active = true
          _68Hip.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _ww1:OnEnter()
  _aJrHZ = _d7gW("l\004\004\t")
  if _ww1.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("mL\vP}1~L\029Ptp>#PMZ\v5P~pttPaZL\vPVC|L#V#P(LMp\029~PMZ#P\\Z_L\"?4aCaL\029P\004p\v,PG||L\v~Z\029>tPZt#P~ptPt4a1\029P~\vLZP\03114aL\029PaL\v5PrZt#PmCPtZ4aL\v5P~pttPmCP~ZLP\vZ4a#Z>LP?4aCaMp\v_LPL\v_p\029\029#Papt#kP0La\bP\02914aMp|PVC\vCL4_PVCMP?4aCapr~\vC4_5PtZLaPZa\029PmZ\vP\02914aMp|Pp\029PC\029~P~p\029\029PrLH\vp>LPZ4aP~L\029P}1~L\029P\02914aMp|,P"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")a(L\f")
      },
      Callback = function(action)
        if action ~= nil then
          _ww1.Active = false
          _udHM.Active = false
          _paM81.Active = true
          _68Hip.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _1Uew:OnEnter()
  _aJrHZ = _d7gW("l\thL\004")
  if _udHM.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("mpPtZ\029~P~\vLZP.C\029>t\fP;Zt#5P?ZLPt4aLZ\029L\029PMZ4aPrLML\v_#PVCPaprL\029PC\029~P\vL\029\029L\029PZ\029P\019Z4a#C\029>P?CL~L\029PpMP\019p\029~P~LtPcL|~LtP~pz1\029,P.L#V#PprL\vPt4a\029L||PaZ\029#L\vaL\v5PzZL||LZ4a#PL\v\004Zt4aLPZ4aPtZLP\02914a\fP;Z\vPr|LZrL\029Pa14at#L\029tPn{P?L_C\029~L\0295PCMPtZLPVCPL\v\004Zt4aL\029\f"),
      Media = _Xvej,
      Callback = function(action)
        if action ~= nil then
          _FLcR:Start()
          _Urwigo.MessageBox({
            Text = _d7gW("?4a\004Lt#L\vP0|C#atP?LL|LPVC4_#PML\v_\004CL\v~Z>PC\029~Ptp>#-P!mL\029_Pr|1ttPp\029PmLZ\029P/L\vt2\vL4aL\029Pp\029PMZ4a\f!"),
            Media = _d4fL5,
            Buttons = {
              _d7gW(")x")
            },
            Callback = function(action)
              if action ~= nil then
                _QxT.Commands._Ynsd.Enabled = false
                _QxT.Commands._HwPv.Enabled = true
                _udHM.Active = false
                __NU8.Active = true
                _1gvh.Commands._jpdN.Enabled = true
                _KmA5l.Active = true
              end
            end
          })
        end
      end
    })
  else
    __NU8.Active = true
    _1gvh.Commands._jpdN.Enabled = true
  end
end
function _1Uew:OnExit()
  _aJrHZ = _d7gW("l\thL\004")
  if Player:Contains(_QxT) then
    Wherigo.PlayAudio(_tjEjL)
    _Urwigo.MessageBox({
      Text = _d7gW("?4a\004Lt#L\vP0|C#a\btP?LL|LP_\vLZt4a#PHC\v4a#L\v|Z4a-P!\015\015\015\015\015\015aaaaaa\fP\0154aP~p\vHP~L\029Pc\vZL~a1HP\029Z4a#PzL\v|pttL\029\fP\030C\vC4_PVCMPc\vZL~a1HPC\029~P\004Z\vHP~L\029P?LL|L\029t#LZ\029P\004L>5P|1t\f!&}\019=&}\019=mZLP.C\029>tP|pCHL\029Pt4a\029L||L\v5Pp|tPtZLP~ptP0L_\vLZt4aLPa1L\vL\029\f"),
      Media = _2AsVQ,
      Buttons = {
        _d7gW(")a\004LZp\fP.p5PMp4aPZ4aPt1H1\v#\f")
      },
      Callback = function(action)
        if action ~= nil then
          _FLcR.Duration = _FLcR.Duration - 30
          _1Uew.Active = true
          __NU8.Active = false
          _1gvh.Commands._jpdN.Enabled = false
        end
      end
    })
  else
    _1Uew.Active = false
  end
end
function __NU8:OnEnter()
  _aJrHZ = _d7gW("ll\\h\a")
  if _KmA5l.Active == true or _vAzTb.Active == true then
    _FLcR:Stop()
    _vAzTb.Active = false
    _KmA5l.Active = false
    _W4_.Active = true
    _sGBb.Visible = true
    Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _sGBb)
  end
end
function _h9Uz:OnEnter()
  _aJrHZ = _d7gW("lanhV")
  _kcl.Active = false
  __NU8.Active = false
  _cHUT.Active = false
  _sGBb.Description = _d7gW("mZLP.C\029>tPtZ\029~PH\v1a5P~pttP~ptPGrL\029#LCL\vPz1\vrLZPZt#PC\029~PmCPtZLPMZ#P\029p4aP`pCtLP\029ZMMt#\f")
  _sGBb:MoveTo(Player)
  _MC1oP.Active = true
  Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _h9Uz)
end
function _9W1:OnEnter()
  _aJrHZ = _d7gW("ln\031\t")
  if _hiZt.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("GCHP~ZLtL\029P?2ZL|t#p\029~P_p\029\029t#PmCP\029p4aPLZ\029LMP\\LCt#p\v#PVC\vC4_tL#VL\029\fP\\1#ZL\vLPmZ\vP~pHCL\vP~L\029PA1~L-P&}\019=&}\019=") .. backup4Code,
        Media = _1iqV
      },
      {
        Text = _d7gW("`ZL\vPZ\029P~L\vP\\pLaLPZt#PLZ\029P0\vprPMZ#PLZ\029LMP_|LZ\029L\029P\031LZa\004pttL\vrL4_L\029,PcZ\029~LPLtPC\029~Pt2\vZ4aPMZ4aP~p\029\029P\02914aMp|Pp\029,")
      }
    }, function(action)
      _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\031LZa\004pttL\vP>LHC\029~L\029-P")) .. backup4Code
      _hiZt.Active = false
      _GWl.Active = true
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _9W1)
    end)
  end
end
function _kcl:OnEnter()
  _aJrHZ = _d7gW("l_4|")
  _Urwigo.OldDialog({
    {
      Text = _d7gW("`ZL\vPz1\v\029LP>La#PLtP\vL4a#tPZ\029P~L\029P\031p|~PaZ\029LZ\0295P~pP|ZL>#PLZ\029PtL|#tpML\vPLZ\029VL|\029L\vP>\v1ttL\vP0\vprt#LZ\0295PpCHP~LMPV\004LZMp|P!G~1|H!Pt#La#,"),
      Media = _Xvej
    },
    {
      Text = _d7gW("h\029~Pz1\029P~pk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("c1|>L\029P?ZLPLZ\029Hp4aP>\v1rP~LMP\031L>PZ\029P~L\029P\031p|~,P\002#\004ptP|Z\029_tP>Zr#PLtPLZ\029L\029P}pCM5Pp\029P~LttL\029P?#pMMPLZ\029PLZ\029Pt#LZ\029L\v\029LtP}C4aP|ZL>#,Pm1\v#PaprL\029P\004Z\vP~ZLPxL\v|LP>LtLaL\0295P_1\029\029#L\029PprL\vP_LZ\029P/L\vt#L4_PHZ\029~L\029,"),
      Media = _Xvej
    }
  })
end
function _qck:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 8818 then
    _GWl.Active = false
    _BIKo.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("mLtap|rPap#PLZ\029L\vP~L\vP.C\029>tP\0041a|P>Lt4a\vZL\0295P\004LZ|PL\vPtZ4aPzL\v|L#V#Pap#,P[\029rt2qcp||tP~ZLP?2C\vPz1\029PLZ\029LMP~L\vP.C\029>tPZt#,,,PGMPrLt#L\0295PmCPC\029#L\vtC4at#\bP~ZLP}|C#t2C\vP\02914aPMp|P>L\029pCL\v\f"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          _QxT.Commands._Ynsd.Enabled = false
          _QxT.Commands._TxV2.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\015\029#L\vLttp\029#,PGrL\vPZ\v>L\029~\004ZLPaZ|H#PC\029tP~ptP\029Z4a#P\004LZ#L\v,P?C4a\bP\02914aPMp|P\004LZ#L\v5P1rPmCP\004ptPp\029~L\vLtPHZ\029~Lt#,"),
      Media = _d4fL5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _3D8s:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 28250 then
    _BIKo.Active = false
    _zElG.Active = true
    _9W1.Active = false
    _4SzwM.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("/p#L\vP`ptt5PaMMM,,,PmptPtp>#PMZ\vPZ\v>L\029~\004pt,P/L\vt#L4_\bP~ZLP}|C#t2C\vP\004ZL~L\v5P~ZLP)\v#t21|ZVLZPt1||PtZ4aP(pPpC4aP\02914aPH\vLCL\029P_1L\029\029L\029,Pmp\029\029P>La\bPL\vt#Mp|PVC\vCL4_PVCMPx\vLCV5PzZL||LZ4a#PHpL||#\btPMZ\vP\004ZL~L\vPLZ\029,,,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          _QxT.Commands._TxV2.Enabled = false
          _QxT.Commands._HwPv.Enabled = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aPaprLP~ptP0LHCLa|5PmCP\vpL#t#P\029C\v5PmCPt1||t#PtC4aL\029\fP\031L\029\029PZ4aP\029Z4a#Pt1P\029L##P\004pL\vL5P\004CL\v~LPZ4aPmZ4aP(L#V#PzL\v|pttL\029PC\029~PmCPMCLtt#Lt#Pz1\029Pz1\v\029LPp\029Hp\029>L\029\fP?C4aP|ZLrL\vP\02914aPMp|5P\004L\vP\004LZtt5P\004ptPt1\029t#P2pttZL\v#\f"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _DunBe:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _Tqx()
  end
  Wherigo.ShowScreen(Wherigo.MAINSCREEN)
end
function _AVfxJ:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 41098 then
    __gokc.Active = false
    _6MVMb.Active = false
    _ElmD.Active = true
    _y3_Ad.Active = true
    _QxT.Commands._HwPv.Enabled = true
    _QxT.Commands._hzu.Enabled = false
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("\127\vZMp5PmCPapt#PmZ4aP\02914aP\029Z4a#PzL\vZ\v\v#\fPmp\029\029P|pttPC\029tP(L#V#P\019p#PrLZMPp|#L\029P\019p#aapCtPa1|L\029,P\031L\029~LPmZ4aP\029p4aP\\1\v~L\029PC\029~PH1|>LP~LMP\031L>PrZtPmCPzZL|LP\015\v\v|Z4a#L\vPtZLat#5P~p\029\029PrZt#PmCPrLZMPp|#L\029P\019p#aapCt,"),
        Media = _d4fL5
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aP>|pCrL5PmCPapt#PmZ4aPzL\vZ\v\v#,P}LZMP.LtCt5P~L\029PZ4aPMLZ\029LPt#ZMM#PmLZ\029LPG\029#\0041\v#P(L~L\029Hp||tP\029Z4a#\f"),
      Media = _d4fL5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _QfZ9:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 6658 then
    _1Uew.Active = true
    _Yn7T.Active = false
    _ww1.Active = false
  elseif _Urwigo.Hash(string.lower(input)) == 2286 then
    _Yn7T.Active = true
    _1Uew.Active = false
    _ww1.Active = false
  elseif _Urwigo.Hash(string.lower(input)) == 57194 then
    _ww1.Active = true
    _Yn7T.Active = false
    _1Uew.Active = false
  end
  _Urwigo.MessageBox({
    Text = _d7gW("\0154aPVLZ>LPmZ\vP~ZLP?#L||L5P\0041PVC|L#V#P~L\vP}1~L\029PMZ#P?4aCaL\029P~ZLtL\vP;p\v_LPrL#\vL#L\029P\004C\v~L\f"),
    Media = _d4fL5,
    Buttons = {
      _d7gW("mptPtLaLPZ4aPMZ\vPMp|Pp\029\f")
    },
    Callback = function(action)
      if action ~= nil then
        _paM81.Active = false
        _7MM8P.Active = false
        _udHM.Active = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _UcC8:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 34518 then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("\019Z4a#Z>P\015\029t2L_#1\v5Pp||LPG4a#C\029>\fP?ZLPMp4aL\029P\015a\vLPG\vrLZ#PprL\vP>\vCL\029~|Z4a\fPG|t15P\004ptP\0041||L\029P?ZLP\004ZttL\029k"),
        Media = _Xvej
      },
      {
        Text = _d7gW("\031ptPMp4a#PZa\vP~L\029\029PaZL\vPC\029~P\004p\vCMPtLZ~PZa\vPtLZ#P~\vLZPup>L\029Pz1\029PVCapCtLP\004L>k"),
        Media = _6HUO
      },
      {
        Text = _d7gW(".pppp,,,,PmptP\004p\vPLZ>L\029#|Z4aP\029C\vPp|tP;C#2\v1rLP>L~p4a#5PCMP~L\029PrLZ~L\029P!x|LZ\029L\029!PaZL\vPL#\004ptPG\029>t#PVCPMp4aL\029,P\031Z\vP\0041||#L\029PMp|PtLaL\0295P\004L\vPtZ4aP#\vpC#5PaZL\vPpMPzL\v>LttL\029L\029Pc\vZL~a1HPVCPCLrL\v\029p4a#L\029,"),
        Media = _Xvej
      },
      {
        Text = _d7gW("h\029~P~p\029\029k"),
        Media = _6HUO
      },
      {
        Text = _d7gW("mp\029\029P_pML\029P\029p4a#tPZ\v>L\029~\004L|4aLPxL\v|L5P~ZLPtZ4aPaZL\vPrLZP~L\vP?1|p\vp\029|p>LP\vCM>L#\vZLrL\029Pap##L\029PC\029~P~p\029\029P~pPaZ\029#L\029PZMP\031p|~PzL\vt4a\004C\029~L\029PtZ\029~,P\031Z\vP>|pCrL\0295P~pttPtZLP~1\v#PL#\004ptPzL\vt#L4_#PaprL\029PC\029~P\0041||#L\029P~Ltap|rPpr\004p\v#L\0295P1rPtZLP\004ZL~L\v_1MML\0295PprL\vP>Lt#L\v\029P_pMP_LZ\029L\v,P\031Z\vPaprL\029PpC4aPC\029>LHpLa\vPp\029P~L\vP?#L||LP>LtC4a#5PprL\vP\029Z4a#tP>LHC\029~L\029,PGrL\vP\004Z\vPaprL\029P(pPpC4aP\029Z4a#Pt1PLZ\029LP?2CL\v\029ptLP\004ZLP?ZL,P?1||L\029P\004Z\vPtZLPMp|PaZ\029HCLa\vL\029k"),
        Media = _Xvej
      },
      {
        Text = _d7gW(".p5PpCHP(L~L\029Pcp||\f"),
        Media = _6HUO
      }
    }, function(action)
      _sGBb.Commands._GLoL1.Enabled = false
      _sGBb.Commands._Ql_.Enabled = true
      _sGBb.Description = _d7gW(";p|P>Lt2p\029\029#5P\004ptPHCL\vPLZ\029P/L\vt#L4_P~ZLP~\vLZP.C\029>tP>LHC\029~L\029PaprL\029,,,")
      Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _sGBb)
    end)
  else
    _Urwigo.MessageBox({
      Text = _d7gW("`papapap\fPcp|t4a\fP\0154aP\004Ctt#LPLt5PtZLPtZ\029~Pt1PLZ\029P1rL\vH|pL4a|Z4aL\vPu\01425P~L\vP\029Z4a#Pp\029t#pL\029~Z>P\vL4aL\v4aZL\v#PC\029~PtZ4aP_LZ\029LP\\1#ZVL\029PMp4a#,&}\019=&}\019=\\pP>C#5P\vp#L\029P?ZLP\02914aMp|5P\004Z\vP\0041||L\029P(pP_LZ\029LPt4a|L4a#L\029Px\vZ#Z_L\029PHC\vP~ZLtL\029P\031aL\vZ>15P\004LZ|PL\vP?ZLP>|LZ4aPrLZMPHp|t4aL\029P\019p#L\029P\02914aMp|PVCMPxpHHLL#\vZ\029_L\029PVCPc\vpCP}\vZb\029L\vPt4aZ4_#,,,P?4apCL\029P?ZLPZ\029P\015a\vLP\\1#ZVL\0295P;p\029\029\f"),
      Media = _Xvej,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _slMsS:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 16118 then
    _0Cp.Active = false
    _ZIe.Commands._O4Kb.Enabled = false
    _ZIe.Description = _d7gW("?4a\004Lt#L\vPG>\029LtP0|C#atP0\vprt#LZ\029,\002Z\029LP\004pa\vapH#P>C#LP\vpt#|1tLP?LL|L\f")
    _QxT:MoveTo(_NCt5)
    _QxT.Commands._dYPV.Enabled = true
    _NCt5.Media = _Wx_u
    _ZIe.Media = _Wx_u
    _0Cp.Active = false
    _J1dP1.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("`p||1Pc\vLM~L\v5PZ4aPrZ\029P?4a\004Lt#L\vP0|C#a,PmCPapt#PMZ4aP>L\vCHL\029\fPmCPapt#P0|CL4_5P~pttPmCP~L\029PzL\v|pttL\029L\029Pc\vZL~a1HPz1\029P~ZLtL\vP?LZ#LPrL#\vZ##t#,P`ZL\vP>Zr#PLtPzZL|LP\vpt#|1tLP?LL|L\0295PCLrL\vP~L\vL\029P0\vpLrL\v\029P\015\v\v|Z4a#L\vP#p\029VL\0295Pt1P\004ZLPCLrL\vPMLZ\029LM,P\\Z4a#Pp||LP~ZLtLP?LL|L\029PtZ\029~Pt1P\029L##P\004ZLPZ4a,P\0154aP_p\029\029PmZ\vPaL|HL\0295P\004L\029\029PmCPMZ4aPMZ#\029ZMMt#5PprL\vPZ4aP~p\vHP~L\029Pc\vZL~a1HP\029Z4a#PzL\v|pttL\029,P\031L\029\029PZ4aPMZ#_1MML\029Pt1||5PMCtt#PmCPMLZ\029LP?LL|LPrLt4a\0041L\vL\029,,,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\\Z4a#P\vp#L\0295PtC4aL\029\f"),
      Buttons = {
        _d7gW(")_5PZ4aPzL\vtC4a\bt")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _Jsc:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 62656 then
    _su66.Active = false
    _zXAOJ.Active = true
    _z3g0.Commands._agv.Enabled = false
    _z3g0.Description = _d7gW("`ZL\vP|ZL>#P~L\vPxC\029t#\"PC\029~P`p\029~L|t>pL\v#\029L\vP\019LZ\029a1|~P\019p#aapCtPrLL\v~Z>#,")
    _y3_Ad.Media = _VeJ
    _z3g0.Media = _VeJ
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aPrZ\029P\0041a|PpMP\vZ4a#Z>L\029P0\vpr,P.L#V#P_p\029\029PMZ\vPrLt#ZMM#P?4a\004Lt#L\vP0|C#aP\004LZ#L\vPaL|HL\029\f"),
      Media = _6HUO,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\\Z4a#P\vp#L\0295PtC4aL\029\f"),
      Buttons = {
        _d7gW(")_5PZ4aPzL\vtC4a\bt")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _ha0js:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 859 then
    _zrZ.Commands._uYxA.Enabled = false
    _zrZ.Description = _d7gW("`ZL\vPZt#P/p#L\vP`pttPrLL\v~Z>#,P)rP;C##L\vP`pttP\0041a|P\02914aP|Lr#k")
    _fsfyQ.Media = _Tu1dK
    _zrZ.Media = _Tu1dK
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aPrZ\029P\0041a|PpMP\vZ4a#Z>L\029P0\vpr,P.L#V#P_p\029\029PMZ\vPrLt#ZMM#P?4a\004Lt#L\vP0|C#aP\004LZ#L\vPaL|HL\029\f"),
      Media = _6HUO,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          _s44R.Active = false
          _8qtX.Active = true
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\\Z4a#P\vp#L\0295PtC4aL\029\f"),
      Buttons = {
        _d7gW(")_5PZ4aPzL\vtC4a\bt")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _9X2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if Wherigo.NoCaseEquals(input, backup1Code) then
    _viC.Active = true
    _NCt5.Active = true
  elseif Wherigo.NoCaseEquals(input, backup2Code) then
    _tU52()
    _VBp.Active = true
    _6MVMb.Active = true
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
  elseif Wherigo.NoCaseEquals(input, backup3Code) then
    _tU52()
    _y3_Ad.Active = true
    _ElmD.Active = true
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=.LtCtP>LHC\029~L\029-P")) .. backup2Code
  elseif Wherigo.NoCaseEquals(input, backup4Code) then
    _tU52()
    _hiZt.Active = true
    _9W1.Active = true
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=.LtCtP>LHC\029~L\029-P")) .. backup2Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\019p#aapCtP>LHC\029~L\029-P")) .. backup3Code
  elseif Wherigo.NoCaseEquals(input, backup5Code) then
    _tU52()
    _O7fd.Active = true
    _fsfyQ.Active = true
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=.LtCtP>LHC\029~L\029-P")) .. backup2Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\019p#aapCtP>LHC\029~L\029-P")) .. backup3Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\031LZa\004pttL\vP>LHC\029~L\029-P")) .. backup4Code
  elseif Wherigo.NoCaseEquals(input, backup6Code) then
    _tU52()
    _paM81.Active = true
    _4dH.Active = true
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=0|C#aP>LHC\029~L\029-P")) .. backup1Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=.LtCtP>LHC\029~L\029-P")) .. backup2Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\019p#aapCtP>LHC\029~L\029-P")) .. backup3Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=\031LZa\004pttL\vP>LHC\029~L\029-P")) .. backup4Code
    _rnV.Description = (_rnV.Description .. _d7gW("&}\019=`pttP>LHC\029~L\029-P")) .. backup5Code
  else
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aPrZ\029PZ\029P~ZLP\\pLaLPz1\029P}L\v|Z\029PVCPMLZ\029L\vPEZLr|Z\029>tHL\vZL\029\0041a\029C\029>P>LHpa\vL\0295PCMPMZ4aPL\vt#Mp|PVCPL\029#t2p\029\029L\029,P\127|1L#V|Z4aP_1MM#PMLZ\029LP/L\vMZL#L\vZ\029Pc\vpCP}\vZb\029L\vP>p\029VPpCH>L\vL>#PaL\vLZ\029PC\029~Pt2\vZ4a#PMZ4aPp\029-P!\015\029t2L_#1\v5P?ZLPMCLttL\029PC\029tPaL|HL\029\f!,,,"),
      Media = _UKW,
      Callback = function(action)
        if action ~= nil then
          _wUCn.Active = true
          move_startzone(startzone)
        end
      end
    })
    startzone.Active = true
    _3dJy5.Visible = true
  end
end
function _0J2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 13166 then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_9X2)
    end)
  else
    _3dJy5.Visible = true
    startzone.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("\0154aPrZ\029PZ\029P~ZLP\\pLaLPz1\029P}L\v|Z\029PVCPMLZ\029L\vPEZLr|Z\029>tHL\vZL\029\0041a\029C\029>P>LHpa\vL\0295PCMPMZ4aPL\vt#Mp|PVCPL\029#t2p\029\029L\029,P\127|1L#V|Z4aP_1MM#PMLZ\029LP/L\vMZL#L\vZ\029Pc\vpCP}\vZb\029L\vP>p\029VPpCH>L\vL>#PaL\vLZ\029PC\029~Pt2\vZ4a#PMZ4aPp\029-P!\015\029t2L_#1\v5P?ZLPMCLttL\029PC\029tPaL|HL\029\f!,,,"),
      Media = _UKW,
      Callback = function(action)
        if action ~= nil then
          _wUCn.Active = true
          move_startzone(startzone)
        end
      end
    })
  end
end
function _FLcR:OnTick()
  __NU8.Active = false
  _Urwigo.MessageBox({
    Text = _d7gW("mZLP.C\029>tPtZ\029~PMZ\vP\0041a|PL\029#\004Zt4a#,,,P\0154aP\004L\v~LPMZ4aPMp|PV\004LZP;Z\029C#L\029PpCHP~ZLPEpCL\vP|L>L\0295PzZL||LZ4a#PtLaLPZ4aP?ZLP~p\029\029P\004ZL~L\vPC\029~P_\vZL>LPtZLP~ZLtMp|,P}|1ttP\029Z4a#PrL\004L>L\029\f"),
    Media = _6HUO,
    Buttons = {
      _d7gW(";Zt#5PprL\vP\029pP>C#,")
    },
    Callback = function(action)
      if action ~= nil then
        _KmA5l.Active = false
        _6U_k.Active = true
        _We7:Start()
      end
    end
  })
end
function _We7:OnTick()
  __NU8.Active = true
  _6U_k.Active = false
  _vAzTb.Active = true
  _Urwigo.MessageBox({
    Text = _d7gW("mpPtZ\029~PtZLP(pP\004ZL~L\v\fP;p|P>p\029VP|LZtLPaZ\029t4a|LZ4aL\029\f"),
    Media = _Xvej,
    Buttons = {
      _d7gW(")x5P>p\029VP|LZtL,,,")
    }
  })
end
function _Xyvl:OnTick()
  Wherigo.PlayAudio(_xMi)
  _Urwigo.MessageBox({
    Text = _d7gW("\127|1L#V|Z4aP_|Z\029>L|#PMLZ\029P`p\029~\014,P\002tPZt#Pc\vpCP}\vZb\029L\v-&}\019=&}\019=!`L\v\vP\015\029t2L_#1\v5PL\029#t4aC|~Z>L\029P?ZL5P~pttPZ4aPt#1L\vL,PGrL\vPZ4aPaprLP>L\vp~LPZMP\019p~Z1P>La1L\v#5P~pttP~ZLP\1271|ZVLZPpCttL\vPLZ\029LMP2pttL\029~L\029PcCttpr~\vC4_PZMP\031p|~t#CL4_PrLZPLZ\029LMP}pCMPMZ#P0LrCLt4aPpMP\031L>Lt\vp\029~PZMP?CL~\004Lt#L\029P~LtPc\vZL~a1HLtP\029Z4a#tP\004LZ#L\vP>LHC\029~L\029Pap#,P?ZLP\004Z||PM1\v>L\029PLZ\029P|L#V#LtP;p|PtC4aL\029,P/ZL||LZ4a#P_1L\029\029L\029P?ZLPMZ#P~LMPcCttpr~\vC4_P(pP\004ptPp\029Hp\029>L\029,,,P/ZL|P0|CL4_\f"),
    Media = _pKP41,
    Buttons = {
      _d7gW(")x5PZ4aPtC4aPMp|,,,")
    },
    Callback = function(action)
      if action ~= nil then
        _KxPr.Active = false
        _paM81.Active = true
        _4dH.Active = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _3dJy5:On_lTc1(target)
  _Urwigo.Dialog(false, {
    {
      Text = _d7gW("`L\v\vP\015\029t2L_#1\v5PaprL\029P?ZLPt4a1\029P~ZLP0Lt4aZ4a#LPz1\029P~L\029PzL\vt4a\004C\029~L\029L\029PxZ\029~L\v\029P>La1L\v#kPmZLP\1271|ZVLZP#p22#Pz1L||Z>PZMPmC\029_L|\0295PZ4aP>|pCrL5P\029C\vP?ZLP_1L\029\029L\029PC\029tPaL|HL\029\f"),
      Media = _pKP41
    },
    {
      Text = _d7gW("\031ptPZt#P~L\029\029P2pttZL\v#k"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\015\029P~L\029P|L#V#L\029Pup>L\029PtZ\029~P~\vLZP.C\029>tPaZL\vPpCtP~L\vP0L>L\029~PzL\vt4a\004C\029~L\029,P\030C|L#V#Pap#PMp\029PtZLPrLZMPzL\v|pttL\029L\029Pc\vZL~a1HP>LtLaL\029,PxLZ\029L\vP\004LZttP>L\029pC5P\004ptP|1tPZt#5Pup#tp4aLPZt#P\029C\v5P~pttP~ZLPxZ\029~L\vPt4a1\029PtLZ#P~\vLZPup>L\029P\004L>PtZ\029~PC\029~P~pttPtZ4aP~ZLP\002|#L\v\029P>\v1ttLP?1\v>L\029PMp4aL\029,P;p\0294aLPMC\029_L|\029PL#\004ptPz1\029P\031L\v\0041L|HL\0295PprL\vP\0311|Ht>LaLC|PZt#PZ\029P}\vp\029~L\029rC\v>P(pP\029Z4a#tP\\LCLtPMLa\v,,,"),
      Media = _pKP41
    },
    {
      Text = _d7gW("/L\v|pttL\029L\vPc\vZL~a1HkP\031L\v\0041L|HLkP/L\vt4a\004C\029~L\029LP.C\029>tk,,,P&}\019=mptP_|Z\029>#Pt2p\029\029L\029~5P~ptPtLaLPZ4aPMZ\vPMp|Pp\029\f"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\0154aP\004Ctt#LP~14a5P~pttP?ZLPtZ4aP~\vCMP_CLMML\v\029\fP/1\vaL\vPt1||#L\029P\004Z\vPprL\vPL\vt#Mp|PLZ\029L\029PxpHHLLP#\vZ\029_L\029,"),
      Media = _pKP41
    },
    {
      Text = _d7gW("c\vpCP}\vZb\029L\vPt#L||#P~CH#L\029~L\029PxpHHLLPpCHP~L\029PuZt4a,"),
      Media = _5Gt
    }
  }, function(action)
    _3dJy5.Description = _d7gW("c\vpCP}\vZb\029L\vPZt#P~ZLP/L\vMZL#L\vZ\029PMLZ\029L\vPcL\vZL\029\0041a\029C\029>,P?ZLPZt#PG\029Hp\029>P8{5Pc\vCLa\vL\029#\029L\vZ\029PC\029~PtLa\vP\029L##,P?ZLP|ZLr#P`1\v\v1\vHZ|MLPC\029~P0\vCtL|>Lt4aZ4a#L\029PC\029~Pap#PtZ4aP~Ltap|rPt4a1\029P1LH#L\vPz1\029PMLZ\029L\029P`1rr\014\"c1\vt4aC\029>L\029PVCP2p\vp\0291\vMp|L\029P\127apL\0291ML\029L\029PL\vVpLa|L\029P|pttL\029,P?ZLP#\vZ\029_#P>L\v\029LPxpHHLLPMZ#PMZ\v,")
    _eD9w:MoveTo(startzone)
    _wUCn.Active = false
    _3hY.Active = true
    _3dJy5.Commands._lTc1.Enabled = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _e4Q:On_z_N(target)
  _Urwigo.Dialog(false, {
    {
      Text = _d7gW("\b\\prL\029~,P\031ptPMp4aL\029P?ZLP~L\029\029PaZL\vPCMP~ZLtLP\030LZ#k"),
      Media = __ZQRU
    },
    {
      Text = _d7gW("0C#L\029PGrL\029~5PZ4aPrZ\029P\015\029t2L_#1\vPc\vZ#VP;C|~L\vt,P\0154aPtC4aLP\029p4aP~L\029P~\vLZPzL\vMZtt#L\029P.C\029>tPC\029~PaprLP>La1L\v#5P?ZLPapL##L\029PtZLPp|tP|L#V#L\vP>LtLaL\029,"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\002Z\029P\1271|ZVZt#kP`ZL\vP\004p\vL\029Pt4a1\029PLZ\029Z>LP\015a\vL\vPx1||L>L\0295P~L\029L\029PZ4aPt4a1\029Pp||LtP\031Z4a#Z>LPL\vVpLa|#PaprL,P\031ptPZ\029#L\vLttZL\v#P?ZLP~L\029\029P\02914ak"),
      Media = __ZQRU
    },
    {
      Text = _d7gW("\031ptP\004ZttL\029P?ZLP~L\029\029PCLrL\vP~ZLP.C\029>tkP\031ptP>L\029pCPaprL\029P?ZLP>LtLaL\029k"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\002tP\004p\vL\029P~\vLZ5PLZ\029P>\v1ttL\vPC\029~PV\004LZP_|LZ\029L\vL,P\0154aPaprLP?ZLPZMPh\029#L\va1|VP>LtLaL\0295P1rP\02914aP(LMp\029~PrLZP\015a\029L\029P\004p\vP_1\029\029#LPZ4aP\029Z4a#PL\v_L\029\029L\029,PGCHP(L~L\029Pcp||PaprLPZ4aPt4a\004Z\v\vL\029~LPEZ4a#L\vP>LtLaL\029PC\029~PC\029>L\0041La\029|Z4aLP0L\vpLCt4aLP>La1L\v#5P~ZLPZ4aPt1P\02914aP\029ZLP>La1L\v#PaprL,P0\vCtL|Z>P\004p\vP~pt\f"),
      Media = __ZQRU
    },
    {
      Text = _d7gW("\015t#PLtPpMPzL\v|pttL\029L\029Pc\vZL~a1HP\029Z4a#PZMML\vP>\vCtL|Z>PC\029~P>LHpLa\v|Z4ak"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\\Z4a#5P\004L\029\029PMp\029Pm\015\002P\019\0020\002E\\PrLp4a#L#,"),
      Media = __ZQRU
    },
    {
      Text = _d7gW("mZLP\019\0020\002E\\k"),
      Media = _6HUO
    },
    {
      Text = _d7gW(".p-&}\019=\t,P}L#\vZ##P~L\029Pc\vZL~a1HPrLZP\\p4a#P\029C\vPz1\029P?CL~1t#L\029Pg~p5P\0041P~ptP>\v1ttLP0L~L\029__\vLCVPHCL\vP~ZLPx\vZL>t#1#L\029Pt#La#\024&}\019=\023,P\031L\029\029PmCP~ZLP0\vpLrL\vPrL#\vZ##t#5P\vZt_ZL\vt#PmCP~ZLP\019p4aLP~L\vPu1#L\029\f&}\019=U,P\0311P~ZLP\vpt#|1tL\029P?LL|L\029Pt2C_L\0295PtZLat#PmCPZMPEpM2L\029t4aLZ\029P\015\v\v|Z4a#L\v,P"),
      Media = __ZQRU
    },
    {
      Text = _d7gW("mptP\0291#ZL\vLPZ4aPMZ\vPMp|P|ZLrL\v,"),
      Media = _uYxmk
    },
    {
      Text = _d7gW("\\14aP\004pt-P\031L\029\029P?ZLP\004Z\v_|Z4aPpCHP~L\029Pc\vZL~a1HP\0041||L\0295PtC4aL\029P?ZLPtZ4aL\vaLZ#tap|rL\vPVCL\vt#P~ZLP0|C#a,P\031L\029\029P?ZLPz1MP>\v1ttL\029P0L~L\029__\vLCVP~LMP\031L>PZMP\\1\v~\004Lt#L\029PH1|>L\0295PMCLtt#L\029P?ZLPtZLPt4a\029L||PHZ\029~L\0295PtZLPtLaL\029P~p\029\029PrLt#ZMM#Pt4a1\029P~ZLP\015\v\v|Z4a#L\v,"),
      Media = __ZQRU
    },
    {
      Text = _d7gW(")_5PMp4a\bZ4a,Pg.L#V#P\vL~L#PL\vPprL\vP\004Z\v\vLtP\030LC>\f\024"),
      Media = _6HUO
    },
    {
      Text = _d7gW("mL\vP0pL\v#\029L\vP>La#P1a\029LP\004LZ#L\vL\029Px1MML\029#p\vP\004ZL~L\vPVCPtLZ\029LMP}LL#,"),
      Media = __ZQRU
    }
  }, function(action)
    _bDTe.Active = false
    _CFowp.Active = true
    _giC6D.Active = true
    __5n.Commands._KoHoQ.Enabled = true
    _e4Q.Description = _d7gW("mL\vPp|#LP0pL\v#\029L\vPZt#PrLZPtLZ\029L\029P}LL#L\029PC\029~Pp\vrLZ#L#P~1\v#PC\029rLZ\v\v#Pz1\vPtZ4aPaZ\029,")
    _e4Q.Commands._z_N.Enabled = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _QxT:On_dYPV(target)
  _J1dP1.Active = false
  _Jedy.Active = true
  _QxT:MoveTo(Player)
  _QxT.Commands._dYPV.Enabled = false
  _QxT.Commands._HwPv.Enabled = true
  _QxT.Description = _d7gW("mZLP?LL|LP~L\vP>C#L\029P?4a\004Lt#L\vP0|C#a5PLZ\029LP~L\vP\004L\029Z>L\029PH\vLC\029~|Z4aL\029P\vpt#|1tL\029P?LL|L\029PaZL\vPpCHP~LMPc\vZL~a1H,")
  _1gvh:MoveTo(Player)
  _Urwigo.MessageBox({
    Text = _d7gW("\002tPH\vLC#PMZ4a5P~pttPZ4aPMp|P\004ZL~L\vP(LMp\029~LMPaL|HL\029P_p\029\0295PZ4aP_1MMLP>L\v\029LPMZ#PmZ\v,P\0154aP>LrLPmZ\vP~ZLtL\029P?LL|L\029t#LZ\0295P~pMZ#PmCPMZ4aPMZ#\029LaML\029P_p\029\029t#,P\031p\029\029PZMML\vPmCPL#\004ptP\004ZttL\029P\004Z||t#5PH\vp>\bPMZ4aPLZ\029Hp4a,PGrL\vP~L\029_P~p\vp\0295P~pttPZ4aP~L\029Pc\vZL~a1HP\029Z4a#PzL\v|pttL\029P~p\vH5PzL\vt2\vZ4at#PmCPMZ\vP~ptk"),
    Media = _2AsVQ,
    Buttons = {
      _d7gW("/L\vt2\v14aL\029\fPh\029~P~p\029_LPmZ\v\f")
    },
    Callback = function(action)
      if action ~= nil then
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _QxT:On_HwPv(target)
  if _Jedy.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("mCPtC4at#PrLt#ZMM#P~ZLP~\vLZP.C\029>t5P~ZLP\029LC|Z4aPaZL\vP\004p\vL\029,PmZLPtZ\029~Pp\029PMZ\vPz1\vrLZP>L_1MML\029PC\029~P\004LZ#L\vP\019Z4a#C\029>P\\1\v~L\029P~LMP\031L>P>LH1|>#,P0LaPL\vt#Mp|P\004LZ#L\vP\029p4aP\\1\v~L\029PC\029~P\004L\029\029P\029p4aP4p,PU{P;L#L\v\029PLZ\029PXCL\v\004L>P_1MM#5PrZL>t#PmCP|Z\029_tPprP\"PH1|>LPLZ\029Hp4aP~L\029P\015\v\v|Z4a#L\v\029,P\031L\029\029PmCPzZL|LP\015\v\v|Z4a#L\vPtZLat#5P_p\029\029PZ4aPmZ\vPaL|HL\029PC\029~PMZ#P~L\vP\vpt#|1tL\029P?LL|LP~1\v#P\vL~L\029,P"),
        Media = _d4fL5
      }
    }, function(action)
      _Jedy.Active = false
      _VBp.Active = true
      _6MVMb.Active = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _ElmD.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("c1|>LPz1MPCM>Lt#CL\vV#L\029P.LtCtPpCtP~LMP\031L>P\029p4aP\\1\v~L\0295PrZtPmCP~ZLP\015\v\v|Z4a#L\vPtZLat#PC\029~PVCMPp|#L\029P\019p#aapCtP_1MMt#,"),
      Media = _d4fL5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _zXAOJ.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("`ZL\vP|ZL>#P~ZLP\vpt#|1tLP?LL|LPz1\029P`L\v\v\029P\019p#aapCt,P?1||PZ4aPZa\029PH\vp>L\0295P1rPL\vPL#\004ptPCrL\vP~ZLP.C\029>tP\004LZttk"),
        Media = _d4fL5
      },
      {
        Text = _d7gW(".pPrZ##L5PH\vp>\bPZa\029,"),
        Media = _6HUO
      }
    }, function(action)
      Wherigo.PlayAudio(_lu5u)
      _Urwigo.MessageBox({
        Text = _d7gW("`L\v\vP\019p#aapCtPtp>#5PtZLPtLZL\029PaZL\vPz1\vrLZP>L_1MML\029PC\029~P\004LZ#L\vP\019Z4a#C\029>P\\1\v~L\029PrZtPVCP~LMPx\vLCVP>L>p\029>L\029,Pm1\v#Pr1>L\029P~ZLP.C\029>tPZ\029P~L\029PV\004LZ#L\029P\031L>P\029p4aP~LMPx\vLCVP\vL4a#tPprPC\029~P>Z\029>L\029P\004pa\vt4aLZ\029|Z4aPrZtPVCMP0\vprPMZ#P~LMP_|LZ\029L\029P\031LZa\004pttL\vrL4_L\029,Pm1\v#Pap#PL\vPLZ\029L\029Pz1\029P\015a\029L\029P2|1L#V|Z4aPt4a\vLZL\029Pa1L\vL\0295PZ\v>L\029~\004ptPMCttP~1\v#PVCPHZ\029~L\029PtLZ\029,"),
        Media = _d4fL5,
        Buttons = {
          _d7gW("mp\029_LPmZ\v\f")
        },
        Callback = function(action)
          if action ~= nil then
            _zXAOJ.Active = false
            _hiZt.Active = true
            _9W1.Active = true
            _y3_Ad.Active = false
            Wherigo.ShowScreen(Wherigo.MAINSCREEN)
          end
        end
      })
    end)
  elseif _GWl.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("`L\v\vP\019p#aapCtPtp>#LP~14a5PaZL\vPMCttPL#\004ptPVCPHZ\029~L\029PtLZ\029,P?C4aPMp|5P1rPmCPZ\v>L\029~LZ\029L\029P`Z\029\004LZtPHZ\029~Lt#PgP;Z4\v1\"m1tLPg_|LZ\029L\vP!0\vprt#LZ\029!\024PMZ#P|pMZ\029ZL\v#LMP\030L##L|\024,P\031L\029\029PmCPL#\004ptP>LHC\029~L\029Papt#5Pt2\vZ4a\bPMZ4aP\02914aPMp|Pp\029,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          _QxT.Commands._Ynsd.Enabled = true
          _QxT.Commands._HwPv.Enabled = false
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _QxT)
        end
      end
    })
  elseif _O7fd.Active == true then
    _O7fd.Description = _d7gW("hMP/p#L\vP`pttPVCPHZ\029~L\029PMCtt#PmCPp\029P`L\v\v\029P\019p#apCt\bP0\vprPz1\vrLZPrZtPVCMPCM>Lt#CL\vV#L\029P.LtCtPC\029~P~p\029\029P_C\vVP~p\029p4aP~L\029P\029pL4at#L\029P\031L>P\vL4a#tP\vLZ\029,Pm1\v#P\004Z\vt#PmCP~p\029\029P\004ZL~L\vP~ZLP\015\v\v|Z4a#L\vPtLaL\029,")
    _4SzwM.Active = false
    _fsfyQ.Active = true
    _Urwigo.MessageBox({
      Text = _d7gW("hMP/p#L\vP`pttPVCPHZ\029~L\029PMCtt#PmCPp\029P`L\v\v\029P\019p#apCt\bP0\vprPz1\vrLZPrZtPVCMPCM>Lt#CL\vV#L\029P.LtCtPC\029~P~p\029\029P_C\vVP~p\029p4aP~L\029P\029pL4at#L\029P\031L>P\vL4a#tP\vLZ\029,Pm1\v#P\004Z\vt#PmCP~p\029\029P\004ZL~L\vP~ZLP\015\v\v|Z4a#L\vPtLaL\029,"),
      Media = _d4fL5,
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  elseif _8qtX.Active == true then
    _Urwigo.Dialog(false, {
      {
        Text = _d7gW("`ZL\vP|ZL>L\029P~ZLP\vpt#|1tL\029P?LL|L\029Pz1\029P/p#L\vP`pttPC\029~PtLZ\029L\vPc\vpC,P?1||PZ4aPZa\029PH\vp>L\0295P1rPL\vPL#\004ptPCLrL\vP~ZLP.C\029>tP\004LZttk"),
        Media = _d4fL5
      },
      {
        Text = _d7gW(".pPrZ##L5PH\vp>\bPZa\029,"),
        Media = _6HUO
      }
    }, function(action)
      Wherigo.PlayAudio(_svS)
      _Urwigo.Dialog(false, {
        {
          Text = _d7gW("/p#L\vP`pttPtp>#5PtZLPtLZL\029PaZL\vPZ\029P\019Z4a#C\029>P)t#L\029Pz1\vrLZP>L_1MML\029PC\029~PrLZMP\029pL4at#L\029P\031L>P\vL4a#tP\019Z4a#C\029>P?CL~L\029P>L>p\029>L\029,P\031L\029\029PmCPtZLPHZ\029~L\029P\004Z||t#5PH1|>LP~LMP\031L>PZ\029P~ZLtLP\019Z4a#C\029>,&}\019=&}\019=mCPMCtt#Pp|t1PZ\029P~ZLP\019Z4a#C\029>PVC\vCL4_5PpCtP~L\vPmCP>L_1MML\029PrZt#PC\029~P~p\029\029P\vL4a#tP>LaL\029,"),
          Media = _d4fL5
        }
      }, function(action)
        _8qtX.Active = false
        _fsfyQ.Active = false
        _KxPr.Active = true
        _Xyvl:Start()
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end)
  elseif _7MM8P.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("?C4aLPz1\vP)\v#P\029p4aPLZ\029LMPcCttpr~\vC4_5PL\vPZt#PMZ#Pm\vpa#Pp\029P~L\029P}pCMP>LrC\029~L\029,P\031L\029\029PmCPZa\029P>LHC\029~L\029Papt#5PH\vp>LPMZ4aP\004ZL~L\v,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x")
      },
      Callback = function(action)
        if action ~= nil then
          _QxT.Commands._HwPv.Enabled = false
          _QxT.Commands._Ynsd.Enabled = true
          Wherigo.ShowScreen(Wherigo.DETAILSCREEN, _QxT)
        end
      end
    })
  elseif _6U_k.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("`p|#LPmZ4aPV\004LZP;Z\029C#L\029P|p\029>PzL\vt#L4_#5PzZL||LZ4a#P#pC4aL\029P~ZLP.C\029>tP~p\029\029P\004ZL~L\vPpCH\f")
    })
  elseif _vAzTb.Active == true then
    _Urwigo.MessageBox({
      Text = _d7gW("?4a|LZ4aLPmZ4aPz1\vtZ4a#Z>Pp\029P~ZLP.C\029>tP\vp\0295P~pMZ#PtZLP\029Z4a#P\004ZL~L\vP\004L>|pCHL\029\f")
    })
  else
    _Urwigo.MessageBox({
      Text = _d7gW("`ZL\vPaprLPZ4aPpC4aP_LZ\029LP\015~LL5PMp4aP~14aPL\vt#Mp|P\004LZ#L\vPMZ#PmLZ\029L\vPGCH>prL,P\031L\029\029P_LZ\029LPGCH>prLPp\029>L>LrL\029PZt#5PtZLa\bPmZ\vP~ZLP0L>L\029t#pL\029~LPZ\029PmLZ\029L\vP\0301\029LP>L\029pCPp\0295P1rPLtP~pP\004ptPVCP#C\029P>Zr#,P\031L\029\029PmZ\vP>p\vP\029Z4a#tPLZ\029HpL||#5P>La\bPVCP~L\029P\029pL4at#L\029P\015\v\v|Z4a#L\v\029,"),
      Media = _d4fL5,
      Buttons = {
        _d7gW(")x5PZ4aP2\v1rZL\v\bt,")
      },
      Callback = function(action)
        if action ~= nil then
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end
      end
    })
  end
end
function _QxT:On_Ynsd(target)
  if _GWl.Active == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_qck)
    end)
  elseif _7MM8P.Active == true or _udHM.Active == true then
    _Urwigo.RunDialogs(function()
      Wherigo.GetInput(_QfZ9)
    end)
  end
end
function _QxT:On_TxV2(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_3D8s)
  end)
end
function _QxT:On_hzu(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_AVfxJ)
  end)
end
function _sGBb:On_WFJj(target)
  _W4_.Active = false
  _Urwigo.Dialog(false, {
    {
      Text = _d7gW("`p||1P0\v1ttL\v5PZ4aPrZ\029P\1271|ZVLZZ\029t2L_#1\vPc\vZ#VP;C|~L\vt,P\031ptPMp4a#PZa\vP~L\029\029PaZL\vk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("mptP>La#P?ZLP>p\vP\029Z4a#tPp\0295P\004Z\vPtp>L\029P\029Z4a#t5P?ZLP\004ZttL\029P(pP\029Z4a#PMp|5P\004L\vP\004Z\vPtZ\029~\f"),
      Media = _Xvej
    },
    {
      Text = _d7gW("mptP~L\029_t#PpC4aP\029C\vPmC\f"),
      Media = _6HUO
    }
  }, function(action)
    _sGBb.Commands._GLoL1.Enabled = true
    _sGBb.Commands._WFJj.Enabled = false
    _sGBb.Description = _d7gW(";p|PtLaL\0295P1rP~ptP~ZLP~\vLZPzL\vMZtt#L\029P.C\029>tPtZ\029~")
  end)
end
function _sGBb:On_GLoL1(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_UcC8)
  end)
end
function _sGBb:On_Ql_(target)
  _Urwigo.MessageBox({
    Text = _d7gW("x1MML\029P?ZLPMZ#PVC\vCL4_PVCMP\031p|~\vp\029~,P}LZP~L\029PV\004LZPG~1|HtP>La#PLtPpMPrL\020CLMt#L\029PZ\029P~L\029P\031p|~,P}Lt#ZMM#PaprL\029PtZLP~ptP/L\vt#L4_PZ\v>L\029~\004ZLPMp\v_ZL\v#,,,&}\019=&}\019=mZLP.C\029>tP\vL\029\029L\029PpMP\019p\029~P~LtPcL|~LtPVC\vCL4_P\019Z4a#C\029>P\031p|~PC\029~P~p\029\029P\029p4aP\031Lt#L\029,"),
    Media = _Xvej,
    Callback = function(action)
      if action ~= nil then
        _cHUT.Active = true
        _sGBb:MoveTo(_h9Uz)
        _h9Uz.Active = true
        _1Uew.Active = false
        __NU8.Active = false
        _sGBb.Commands._Ql_.Enabled = false
        _kcl.Active = true
        _kcl.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _eD9w:On_656H(target)
  _eD9w.Visible = false
  _Urwigo.Dialog(false, {
    {
      Text = _d7gW(".L#V#P#\vZ\029_L\029P?ZLPL\vt#Mp|PLZ\029L\029PxpHHLLPMZ#PMZ\vPc\vpCP}\vZb\029L\vPC\029~PL\vVpLa|L\029P?ZLPMp|PLZ\029tP\029p4aP~LMPp\029~L\vL\029,P\031ptPap#PLtP~L\029\029PMZ#P~LMPc\vZL~a1HPHCL\vPLZ\029LP}L\004p\029~#\029Ztk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("G\029>Lr|Z4aPt2C_L\029P~1\v#P\029p4a#tP\vpt#|1tLP?LL|L\029P~L\v(L\029Z>L\0295P~ZLP~1\v#PrLL\v~Z>#P\004C\v~L\029,P\015MP?4aLZ\029PLZ\029L\vPupt4aL\029|pM2LPt1||PMp\029P~L\vL\029P0\vpLrL\vPp\029P\015\v\v|Z4a#L\v\029PL\v_L\029\029L\0295P~ZLPZ\029P~L\vP\\pLaLP\vCMt4a\004Z\v\vL\029,P&}\019=&}\019=GP2\v121tPupt4aL\029|pM2L-P?#ZMM#PLtPLZ>L\029#|Z4a5P~pttPMp\029PMZ#Ph/\"EZ4a#P}|C#t2C\vL\029PtZ4a#rp\vPMp4aL\029P_p\029\029k"),
      Media = _pKP41
    },
    {
      Text = _d7gW(".pP\029p#CL\v|Z4a5P\004p\vCMPH\vp>L\029P?ZLk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("mp\029\029Pt1||#L\029P?ZLPpCHP(L~L\029Pcp||PLZ\029LPh/\"EpM2LPMZ#\029LaML\0295P\004L\029\029P?ZLPVCMPzL\v|pttL\029L\029Pc\vZL~a1HP>LaL\029,PmpPZt#PrLt#ZMM#P\004ptP?4a|ZMMLtP2pttZL\v#\f"),
      Media = _pKP41
    },
    {
      Text = _d7gW(";LZ\029L\029P?ZL5P~L\029PxZ\029~L\v\029PZt#PL#\004ptPVC>Lt#1ttL\029kP\002\vVpLa|L\029P?ZLP~14aPMp|PMLa\vPCLrL\vP~ZLP.C\029>t,"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\002tP\004p\vL\029P~\vLZP.C>L\029~|Z4aL5P`p\029t5P\127L#L\vPC\029~Px|pCt5P~ZLPz1\vP~\vLZPup>L\029PzL\vt4a\004C\029~L\029PtZ\029~,P`p\029t5P~L\vPpL|#Lt#LPZt#P\t75PtZLa#PprL\vPzZL|PpL|#L\vPpCt5P\004LZ|PL\vPt4a1\029P\t5\a7P>\v1ttPZt#PC\029~P?4aCa>\v1LttLP\0188Pap#P\"PL\vPap#PMZ\vP\029LC|Z4aPtLZ\029LPuC\v\029t4aCaLP>LVLZ>#\fP\127L#L\vPC\029~Px|pCtPtZ\029~PL\vt#P\t\018PC\029~PLZ\029L\029Px12HP_|LZ\029L\v5PprL\vPtZLP\0041||L\029P`p\029tPZMML\vPrL\004LZtL\0295P~pttPtZLPpC4aPt4a1\029P\b>\v1tt\bPtZ\029~\f&}\019=&}\019=\030C|L#V#Pap#PtZLP~L\vP0pL\v#\029L\vPz1\029P~L\vPp|#L\029P0pL\v#\029L\vLZ5P~Z\vL_#P\029LrL\029P~LMPzL\v>LttL\029L\029Pc\vZL~a1HP|LrL\029~P>LtLaL\029,"),
      Media = _pKP41
    },
    {
      Text = _d7gW("0|pCrL\029P?ZL5P~ZLtL\vP0pL\v#\029L\vP\004LZttPMLa\vk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("}Lt#ZMM#\fPGrL\vPL\vPZt#Pt4a1\029PL#\004ptPML\v_\004CL\v~Z>PC\029~P\004Z\v_#PMp\0294aMp|PzL\v\004Z\v\v#,P\031pa\vt4aLZ\029|Z4aP\0041a\029#PL\vPt4a1\029PVCP|p\029>LP\029LrL\029P~LMPzL\v>LttL\029L\029Pc\vZL~a1H\f"),
      Media = _pKP41
    },
    {
      Text = _d7gW("mptPMCttPZ4aPMZ\vPL\vt#Mp|Pp||LtP\0291#ZL\vL\029PC\029~P~p\029\029PHpa\vLPZ4aPMp|PaZ\029,Px1L\029\029L\029P?ZLPMZ\vPtp>L\0295P\004ZLPZ4aP~pPaZ\029P_1MMLk"),
      Media = _ud4a
    },
    {
      Text = _d7gW("?ZLPaprL\029P~14aP~ZLtLtP\029LCM1~Zt4aLP0\127?\"mZ\029>t5P~pP>LrLPZ4aP\015a\029L\029PpMPrLt#L\029PLZ\029L\029P\127|p\029PMZ#P~L\029Px11\v~Z\029p#L\029P~L\vP0pL\v#\029L\vLZPC\029~PLZ\029L\vP\127p\v_>L|L>L\029aLZ#PrLZMPc\vZL~a1H,PmZLPt1||#L\029P?ZLPZ\029PZa\vP\\1#ZVrC4aP|L>L\029PC\029~PtZ4aPp\029t4apCL\0295PrLz1\vP?ZLP|1tHpa\vL\029,"),
      Media = _pKP41
    },
    {
      Text = _d7gW("0C#5P~p\029\029PaprLPZ4aP(pPp||LtPC\029~P_p\029\029Pt1H1\v#P|1tHpa\vL\0295P1~L\vk"),
      Media = _6HUO
    },
    {
      Text = _d7gW("\0154aP~L\029_L5P?ZLPt1||#L\029PL\vt#P\029p4a#tPpCHP~L\029Pc\vZL~a1HP>LaL\0295P\004L\029\029P~ZLP.1C\v\029p|Zt#L\029Pp||LP\004L>PtZ\029~5Pt1\029t#P_\vZL>L\029P?ZLP\02914aPMLa\vPGL\v>L\vPMZ#P\015a\vLMPAaLH5P\004L\029\029P\vpCt_1MM#5P~pttP?ZLPt4a1\029P\004ZL~L\vP\004ptPMZ#P2p\vp\0291\vMp|L\029P\127apL\0291ML\029L\029PMp4aL\029,,,P&}\019=&}\019=h\029~P~L\029_L\029P?ZLPpCHP(L~L\029Pcp||P~p\vp\0295P\015a\vLPEpM2L\029PLZ\029VC2p4_L\029\f"),
      Media = _pKP41
    }
  }, function(action)
    _eD9w.Visible = true
    __5n.Commands._rbSD.Enabled = true
    __5n.Commands._oL8.Enabled = true
    _3hY.Active = false
    _bqo.Active = true
    _eD9w.Commands._656H.Enabled = false
    _eD9w.Commands._qOEq.Enabled = true
    _eD9w.Description = _d7gW("mL\vPxpHHLLP~CH#L#P_1Lt#|Z4a5PzZL||LZ4a#Pt1||#LPZ4aP\02914aPLZ\029LPupttLPMZ#Pc\vpCP}\vZb\029L\vP#\vZ\029_L\029k")
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _eD9w:On_qOEq(target)
  _Urwigo.MessageBox({
    Text = _d7gW("uC#PMZ\vP|LZ~P`L\v\vP\015\029t2L_#1\v5PMLa\vPxpHHLLP_p\029\029PZ4aP\029Z4a#PMZ#P\015a\029L\029P#\vZ\029_L\029P\"PMLZ\029P`L\vV5P\004ZttL\029P?ZLk&}\019=&}\019=c\vpCP}\vZb\029L\vP#\vpL>#P~L\029PxpHHLLP\004L>PC\029~Pr|LZr#PZ\029P~L\vPxCL4aL,"),
    Media = _pKP41,
    Buttons = {
      _d7gW("\\pP>C#5P~p\029\029Pap|#P\029Z4a#,")
    },
    Callback = function(action)
      if action ~= nil then
        _3dJy5:MoveTo(nil)
        _eD9w:MoveTo(nil)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end
    end
  })
end
function _1gvh:On_jpdN(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_DunBe)
  end)
end
function _bEW7:On_A8A5(target)
  _Urwigo.MessageBox({Text = _3E8_p, Media = _xJRZm})
end
function _ZIe:On_O4Kb(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_slMsS)
  end)
end
function _z3g0:On_agv(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Jsc)
  end)
end
function _zrZ:On_uYxA(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_ha0js)
  end)
end
function __5n:On_oL8(target)
  _Urwigo.MessageBox({
    Text = _d7gW("\"Ph/PMZ#\029LaML\029Pg}|C#t2C\vL\029k\024&}\019=\"Pupt4aL\029|pM2L-P\015\v\v|Z4a#L\vPrLZP\vpt#|1tL\029P?LL|L\029PZ\029P0\vpLrL\v\029&}\019=\"P`p\029t5P\t75P\t\a74M5PuC\v\029t4aCaLP0\v1LttLP\0188&}\019=\"P\127L#L\vPC\029~Px|pCtP\t\0185P4p,P\t87P4M"),
    Media = _ud4a,
    Buttons = {
      _d7gW(")x")
    }
  })
end
function __5n:On_rbSD(target)
  _Urwigo.MessageBox({
    Text = _d7gW("`ZL\vP_p\029\029PZ4aPrLZMPc\vZL~a1HP2p\v_L\029-P&}\019=\\P7\023PU\t,78{P\002P{\tUP{8,\an{P&}\019=&}\019=mZLP0pL\v#\029L\vLZPZt#P~p\029\029P>p\029VPZ\029P~L\vP\\pLaL,&}\019=&}\019=0C#5P~pttPZ4aPMLZ\029P0\127?P~prLZPaprL\f"),
    Media = _7Z3oo,
    Buttons = {
      _d7gW(")x")
    },
    Callback = function(action)
      if action ~= nil then
        _bqo.Active = false
        _hteO.Active = true
        _NNXV.Active = true
      end
    end
  })
end
function __5n:On_KoHoQ(target)
  _Urwigo.MessageBox({
    Text = _d7gW("\t,P}L#\vZ##P~L\029Pc\vZL~a1HPrLZP\\p4a#P\029C\vPz1\029P?CL~1t#L\029Pg~p5P\0041P~ptP>\v1ttLP0L~L\029__\vLCVPHCL\vP~ZLPx\vZL>t#1#L\029Pt#La#\024&}\019=\023,P\031L\029\029PmCP~ZLP0\vpLrL\vPrL#\vZ##t#5P\vZt_ZL\vt#PmCP~ZLP\019p4aLP~L\vPu1#L\029\f&}\019=U,P\0311P~ZLP\vpt#|1tL\029P?LL|L\029Pt2C_L\0295PtZLat#PmCPZMPEpM2L\029t4aLZ\029P\015\v\v|Z4a#L\v,P"),
    Media = _uYxmk,
    Buttons = {
      _d7gW(")x")
    }
  })
end
function _GO6Ie:On_bMFzn(target)
  _Urwigo.MessageBox({
    Text = _d7gW("`L\vV|Z4aL\029P0|CL4_\004C\029t4a\f&}\019=&}\019=\015MP/L\vt#L4_PHp\029~L\029PtZ4aPLZ\029LP;L\029>LP>Lt#1a|L\029LP?4aMC4_t#CL4_L5P~ZLPZ\029P~L\029P|L#V#L\029P;1\029p#L\029Pz1\029PLZ\029L\vPrL\vC4a#Z>#L\029P?4aMC4_~ZLrrp\029~LP>Lt#1a|L\029P\004C\v~L\029,Pmp\029_PmLZ\029LtPcC\029~LtP>L|Z\029>#PLt5P~ZLP}p\029~LPL\029~|Z4aPVCPCLrL\vHCLa\vL\029,PmZLP.C\029>tP\004L\v~L\029Pp|tPx\v1\029VLC>L\029PMZ#P>\v1ttLMPmp\029_PC\029~PE1rPz1\029P1HHZVZL||L\vP?LZ#LPCLrL\vt4aCL##L#PC\029~P\015a\vLP_|LZ\029LP!?4ap\029~#p#!P\004Z\v~PZa\029L\029Pt4a\029L||PzL\vVZLaL\029,&}\019=&}\019=\\C\vPmLZ\029LP\002\v|Lr\029ZttLPMZ#P~L\vP?LL|LPz1\029P?4a\004Lt#L\vP0|C#aP\004Z\v~PmZ\vPmLZ\029PAaLHP\0041a|P\029Z4a#Ppr_pCHL\029,Ph\029~P~L\vPzL\vH|Zb#LP?LL|L\029t#LZ\029P\004p\vPpC4aP\029Z4a#P\004ZL~L\vVCHZ\029~L\029,&}\019=&}\019=\\p(p5PzZL||LZ4a#PrLZMP\029pL4at#L\029PGrL\029#LCL\v\f&}\019=&}\019=\127,?,-P/L\v>Ztt\bP\029Z4a#5P~ptPE1>rC4aPVCPtZ>\029ZL\vL\029\f"),
    Media = _MHFZ,
    Buttons = {
      _d7gW(")x")
    },
    Callback = function(action)
      if action ~= nil then
        _bEW7.Visible = true
        _bEW7:MoveTo(Player)
        _yCJ8.Complete = true
        _3E8_p = ((_d7gW("mL\vPh\029|14_41~LP~L\vP\029C\vPHCL\vP~L\029P?2ZL|L\vP") .. Player.Name) .. _d7gW("P>CL|#Z>PZt#5P|pC#L#P-P")) .. string.sub(Player.CompletionCode, 1, 15)
        _bEW7.Description = _3E8_p
        _Urwigo.MessageBox({
          Text = _d7gW("mZLPAp\v#\vZ~>LP\004C\v~LPp|tP~C\v4a>Lt2ZL|#Pg41M2|L#L~\024PMp\v_ZL\v#PC\029~PLZ\029Ph\029|14_41~LP>L\029L\vZL\v#,P\002\vPrLHZ\029~L#PtZ4aP(L#V#PZ\029P~LZ\029LMP\015\029zL\029#p\v,PmCP_p\029\029t#PZa\029PrL\029C#VL\0295PCMPVCtp#V|Z4aPpC4aPpCHP\004aL\vZ>1,41MPVCP|1>>L\029,"),
          Media = _xJRZm,
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
function _Tqx()
  _QxT:MoveTo(_NCt5)
  _1gvh:MoveTo(nil)
  _QxT.Commands._dYPV.Enabled = true
  _QxT.Commands._HwPv.Enabled = false
  _QxT.Commands._Ynsd.Enabled = false
  _QxT.Commands._TxV2.Enabled = false
  _QxT.Commands._hzu.Enabled = false
end
function _tU52()
  _rnV:MoveTo(Player)
  _QxT:MoveTo(Player)
  _1gvh:MoveTo(Player)
  _QxT.Commands._HwPv.Enabled = true
end
function move_startzone(zone)
  zone.Active = false
  zone.OriginalPoint = Player.ObjectLocation
  zone.Points = GetZonePoints(Player.ObjectLocation, 100)
  zone.Active = true
end
function GetZonePoints(refPt, radi)
  local dist = Wherigo.Distance(radi, "m")
  local pts = {
    Wherigo.TranslatePoint(refPt, dist, 22.5),
    Wherigo.TranslatePoint(refPt, dist, 67.5),
    Wherigo.TranslatePoint(refPt, dist, 112.5),
    Wherigo.TranslatePoint(refPt, dist, 157.5),
    Wherigo.TranslatePoint(refPt, dist, 202.5),
    Wherigo.TranslatePoint(refPt, dist, 247.5),
    Wherigo.TranslatePoint(refPt, dist, 292.5),
    Wherigo.TranslatePoint(refPt, dist, 337.5)
  }
  return pts
end
function calcBackupCodes()
  backup1Code = string.upper(string.sub(compCode, 1, 1) .. "q" .. string.sub(compCode, 2, 2))
  backup2Code = string.upper(string.sub(compCode, 3, 3) .. "j" .. string.sub(compCode, 4, 4))
  backup3Code = string.upper(string.sub(compCode, 5, 5) .. "x" .. string.sub(compCode, 6, 6))
  backup4Code = string.upper(string.sub(compCode, 7, 7) .. "r" .. string.sub(compCode, 8, 8))
  backup5Code = string.upper(string.sub(compCode, 9, 9) .. "f" .. string.sub(compCode, 10, 10))
  backup6Code = string.upper(string.sub(compCode, 11, 11) .. "y" .. string.sub(compCode, 12, 12))
end
return _yCJ8
