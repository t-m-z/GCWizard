require("Wherigo")
ZonePoint = Wherigo.ZonePoint
Distance = Wherigo.Distance
Player = Wherigo.Player
function _aNeWb(str)
  local res = ""
  local dtable = "G9\019B7m\030HW#Q\003/'\024\005V\027$\017EF\022\r\fz\015\016}&\n4\002w|C5>*oqI+=A\"\014\001\029,3Z\v\018L\020;J!aY2?Ut81.uevi[bP6j)<Ox]_nk^\\~RM\025\028r\000\026`:hcK\004Tg\021sS\b\023N\tlfyDp(%-\a0{\031X @\006d"
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
_eiXtn = Wherigo.ZCartridge()
_rZ0wN = Wherigo.ZMedia(_eiXtn)
_rZ0wN.Id = "225425b9-d6ff-4e6a-814a-fa0e7c2d43c8"
_rZ0wN.Name = "Till Eulenspiegel"
_rZ0wN.Description = ""
_rZ0wN.AltText = ""
_rZ0wN.Resources = {
  {
    Type = "jpg",
    Filename = "till_garmin.jpg",
    Directives = {}
  }
}
_rPW_3 = Wherigo.ZMedia(_eiXtn)
_rPW_3.Id = "e6bc7e4d-2c0b-4c3f-b7fa-86b7d4e4e21b"
_rPW_3.Name = "Notizzettel 0"
_rPW_3.Description = ""
_rPW_3.AltText = ""
_rPW_3.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_0.jpg",
    Directives = {}
  }
}
_OVQaC = Wherigo.ZMedia(_eiXtn)
_OVQaC.Id = "21606876-05dc-4381-8d14-170a08d5ad30"
_OVQaC.Name = "Notizzettel 1"
_OVQaC.Description = ""
_OVQaC.AltText = ""
_OVQaC.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_1.jpg",
    Directives = {}
  }
}
_cvENm = Wherigo.ZMedia(_eiXtn)
_cvENm.Id = "432c7f51-8f51-4a96-9683-a600d8b7049e"
_cvENm.Name = "Notizzettel 2"
_cvENm.Description = ""
_cvENm.AltText = ""
_cvENm.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_2.jpg",
    Directives = {}
  }
}
_6wiy = Wherigo.ZMedia(_eiXtn)
_6wiy.Id = "de3c726b-53cf-4b59-b77e-0bf5abbbef14"
_6wiy.Name = "Notizzettel 3"
_6wiy.Description = ""
_6wiy.AltText = ""
_6wiy.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_3.jpg",
    Directives = {}
  }
}
_l_3y = Wherigo.ZMedia(_eiXtn)
_l_3y.Id = "224b60e8-3d63-43e6-b541-7e7e568de0b1"
_l_3y.Name = "Notizzettel 5"
_l_3y.Description = ""
_l_3y.AltText = ""
_l_3y.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_5.jpg",
    Directives = {}
  }
}
_YVNt = Wherigo.ZMedia(_eiXtn)
_YVNt.Id = "aa614b2c-b0fc-43a6-9656-f0d4f19cce19"
_YVNt.Name = "Till Startbild"
_YVNt.Description = ""
_YVNt.AltText = ""
_YVNt.Resources = {
  {
    Type = "jpg",
    Filename = "till_title.jpg",
    Directives = {}
  }
}
_Vq2o = Wherigo.ZMedia(_eiXtn)
_Vq2o.Id = "7a47add0-bccd-47df-bd56-ed3324a80583"
_Vq2o.Name = "Aufgabe 1"
_Vq2o.Description = ""
_Vq2o.AltText = ""
_Vq2o.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_1.jpg",
    Directives = {}
  }
}
_Wji = Wherigo.ZMedia(_eiXtn)
_Wji.Id = "96b00318-9307-401b-97ec-725a9d4bbb2e"
_Wji.Name = "Aufgabe 2"
_Wji.Description = ""
_Wji.AltText = ""
_Wji.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_2.jpg",
    Directives = {}
  }
}
_jdR = Wherigo.ZMedia(_eiXtn)
_jdR.Id = "53291cf1-c85c-4513-a7b7-592140dbfb1f"
_jdR.Name = "Aufgabe 3"
_jdR.Description = ""
_jdR.AltText = ""
_jdR.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_3.jpg",
    Directives = {}
  }
}
_r4FOM = Wherigo.ZMedia(_eiXtn)
_r4FOM.Id = "cbdfd546-8be2-455d-a995-cc76a180b4c4"
_r4FOM.Name = "Aufgabe 4"
_r4FOM.Description = ""
_r4FOM.AltText = ""
_r4FOM.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_4.jpg",
    Directives = {}
  }
}
_CqN4 = Wherigo.ZMedia(_eiXtn)
_CqN4.Id = "ec69bd71-3a39-4cd2-83cf-eeadefe7f5ec"
_CqN4.Name = "Aufgabe 5"
_CqN4.Description = ""
_CqN4.AltText = ""
_CqN4.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_5.jpg",
    Directives = {}
  }
}
_La_ = Wherigo.ZMedia(_eiXtn)
_La_.Id = "c347e5c1-53d3-44e6-ba42-f291a0dbd680"
_La_.Name = "Zone 1"
_La_.Description = ""
_La_.AltText = ""
_La_.Resources = {
  {
    Type = "jpg",
    Filename = "zone_1.jpg",
    Directives = {}
  }
}
_c97x = Wherigo.ZMedia(_eiXtn)
_c97x.Id = "fba3b572-23a0-4f17-af85-f9679257fa98"
_c97x.Name = "Zone 2"
_c97x.Description = ""
_c97x.AltText = ""
_c97x.Resources = {
  {
    Type = "jpg",
    Filename = "zone_2.jpg",
    Directives = {}
  }
}
_pse = Wherigo.ZMedia(_eiXtn)
_pse.Id = "9b2f7b0c-4510-4d72-962d-a7bdb73a4f55"
_pse.Name = "Zone 3"
_pse.Description = ""
_pse.AltText = ""
_pse.Resources = {
  {
    Type = "jpg",
    Filename = "zone_3.jpg",
    Directives = {}
  }
}
_ymSV = Wherigo.ZMedia(_eiXtn)
_ymSV.Id = "38868db8-76e1-4de3-b17e-0c92b209f04e"
_ymSV.Name = "Zone 4"
_ymSV.Description = ""
_ymSV.AltText = ""
_ymSV.Resources = {
  {
    Type = "jpg",
    Filename = "zone_4.jpg",
    Directives = {}
  }
}
_3pE = Wherigo.ZMedia(_eiXtn)
_3pE.Id = "dbd1ad72-1688-4d8a-a374-6d01e199be93"
_3pE.Name = "Zone 6"
_3pE.Description = ""
_3pE.AltText = ""
_3pE.Resources = {
  {
    Type = "jpg",
    Filename = "zone_6.jpg",
    Directives = {}
  }
}
_aLFg = Wherigo.ZMedia(_eiXtn)
_aLFg.Id = "fe2dc34a-3f50-432e-8e95-9d533a81a78a"
_aLFg.Name = "Zone 7"
_aLFg.Description = ""
_aLFg.AltText = ""
_aLFg.Resources = {
  {
    Type = "jpg",
    Filename = "zone_7.jpg",
    Directives = {}
  }
}
_ih3 = Wherigo.ZMedia(_eiXtn)
_ih3.Id = "ea8f921f-69cc-49d4-9e0a-74feec2b0a8b"
_ih3.Name = "Coin"
_ih3.Description = ""
_ih3.AltText = ""
_ih3.Resources = {
  {
    Type = "jpg",
    Filename = "Kavalier.jpg",
    Directives = {}
  }
}
_hyU = Wherigo.ZMedia(_eiXtn)
_hyU.Id = "2d563935-cfdb-44e8-bb5d-2a4cdb8d9981"
_hyU.Name = "Aufgabe 7"
_hyU.Description = ""
_hyU.AltText = ""
_hyU.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_7.jpg",
    Directives = {}
  }
}
__WNf = Wherigo.ZMedia(_eiXtn)
__WNf.Id = "304246e8-29cc-46ad-bb16-0d4f69363232"
__WNf.Name = "Aufgabe 8"
__WNf.Description = ""
__WNf.AltText = ""
__WNf.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_8.jpg",
    Directives = {}
  }
}
_nRI = Wherigo.ZMedia(_eiXtn)
_nRI.Id = "ba079902-08a5-407b-ad03-0dbcfae88f9b"
_nRI.Name = "Beep Garmin"
_nRI.Description = ""
_nRI.AltText = ""
_nRI.Resources = {
  {
    Type = "fdl",
    Filename = "Beep.fdl",
    Directives = {}
  }
}
_0Z3pA = Wherigo.ZMedia(_eiXtn)
_0Z3pA.Id = "b53e2d0e-73f1-4e42-acc6-5ea226364a63"
_0Z3pA.Name = "Till Pictogramm"
_0Z3pA.Description = ""
_0Z3pA.AltText = ""
_0Z3pA.Resources = {
  {
    Type = "jpg",
    Filename = "till_picto.jpg",
    Directives = {}
  }
}
_RcWNN = Wherigo.ZMedia(_eiXtn)
_RcWNN.Id = "cb621a2a-fe6e-48ae-b60e-0fba8b82add3"
_RcWNN.Name = "Notizzettel Pictogramm"
_RcWNN.Description = ""
_RcWNN.AltText = ""
_RcWNN.Resources = {
  {
    Type = "jpg",
    Filename = "notizzettel_picto.jpg",
    Directives = {}
  }
}
_azc = Wherigo.ZMedia(_eiXtn)
_azc.Id = "cc24251f-3ba9-4b63-adf0-69604d09e9e7"
_azc.Name = "Wegpunkt 1"
_azc.Description = ""
_azc.AltText = ""
_azc.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp1.jpg",
    Directives = {}
  }
}
_YXqr9 = Wherigo.ZMedia(_eiXtn)
_YXqr9.Id = "28821552-3e64-44f2-8a02-c0c47a641081"
_YXqr9.Name = "Wegpunkt 2"
_YXqr9.Description = ""
_YXqr9.AltText = ""
_YXqr9.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp2.jpg",
    Directives = {}
  }
}
_R4V = Wherigo.ZMedia(_eiXtn)
_R4V.Id = "4012929f-8937-4001-ab26-cf187c810267"
_R4V.Name = "Wegpunkt 3"
_R4V.Description = ""
_R4V.AltText = ""
_R4V.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp3.jpg",
    Directives = {}
  }
}
_7hi = Wherigo.ZMedia(_eiXtn)
_7hi.Id = "30b41048-69f9-41e1-a055-3d8a9f71e875"
_7hi.Name = "Wegpunkt 4"
_7hi.Description = ""
_7hi.AltText = ""
_7hi.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp4.jpg",
    Directives = {}
  }
}
_bY8q = Wherigo.ZMedia(_eiXtn)
_bY8q.Id = "de007ba3-ff44-4f6d-ac73-d599b746f350"
_bY8q.Name = "Wegpunkt 5"
_bY8q.Description = ""
_bY8q.AltText = ""
_bY8q.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp5.jpg",
    Directives = {}
  }
}
_Ro5T = Wherigo.ZMedia(_eiXtn)
_Ro5T.Id = "420aa7ef-92f2-48a1-abcf-9a2369349efa"
_Ro5T.Name = "Rassel"
_Ro5T.Description = ""
_Ro5T.AltText = ""
_Ro5T.Resources = {
  {
    Type = "jpg",
    Filename = "rassel.jpg",
    Directives = {}
  }
}
_kpw = Wherigo.ZMedia(_eiXtn)
_kpw.Id = "da568302-ce4d-4e29-9f11-9cb535b2c674"
_kpw.Name = "Spiegel1"
_kpw.Description = ""
_kpw.AltText = ""
_kpw.Resources = {
  {
    Type = "jpg",
    Filename = "spiegel.jpg",
    Directives = {}
  }
}
_gI_xL = Wherigo.ZMedia(_eiXtn)
_gI_xL.Id = "b6fe6874-324c-4c91-9a1d-efeca4e06eba"
_gI_xL.Name = "Spiegel 2"
_gI_xL.Description = ""
_gI_xL.AltText = ""
_gI_xL.Resources = {
  {
    Type = "jpg",
    Filename = "spiegel2.jpg",
    Directives = {}
  }
}
_FBA = Wherigo.ZMedia(_eiXtn)
_FBA.Id = "067c32a9-3740-49ef-89be-3f49f261ada3"
_FBA.Name = "Zettel1"
_FBA.Description = ""
_FBA.AltText = ""
_FBA.Resources = {
  {
    Type = "jpg",
    Filename = "zettel1.jpg",
    Directives = {}
  }
}
_WZh = Wherigo.ZMedia(_eiXtn)
_WZh.Id = "5b621356-fc1e-4d4b-b597-d2e92e6fdbe8"
_WZh.Name = "Zettel2"
_WZh.Description = ""
_WZh.AltText = ""
_WZh.Resources = {
  {
    Type = "jpg",
    Filename = "zettel2.jpg",
    Directives = {}
  }
}
_Fn3K5 = Wherigo.ZMedia(_eiXtn)
_Fn3K5.Id = "bbbbf693-c65f-4159-9af6-4431d0885ed1"
_Fn3K5.Name = "Zettel3"
_Fn3K5.Description = ""
_Fn3K5.AltText = ""
_Fn3K5.Resources = {
  {
    Type = "jpg",
    Filename = "zettel3.jpg",
    Directives = {}
  }
}
_M1j = Wherigo.ZMedia(_eiXtn)
_M1j.Id = "fdf7631d-bfb0-403d-88b6-bf03e616faa4"
_M1j.Name = "Zone 5"
_M1j.Description = ""
_M1j.AltText = ""
_M1j.Resources = {
  {
    Type = "jpg",
    Filename = "zone_5.jpg",
    Directives = {}
  }
}
_XvS5d = Wherigo.ZMedia(_eiXtn)
_XvS5d.Id = "42c8cdbb-745f-41da-b3be-9f56754e8e33"
_XvS5d.Name = "Aufgabe 6"
_XvS5d.Description = ""
_XvS5d.AltText = ""
_XvS5d.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_6.jpg",
    Directives = {}
  }
}
_gSY7X = Wherigo.ZMedia(_eiXtn)
_gSY7X.Id = "87d4fab0-c54d-4934-8a0e-d4a022863f97"
_gSY7X.Name = "Zettel1 Pictogramm"
_gSY7X.Description = ""
_gSY7X.AltText = ""
_gSY7X.Resources = {
  {
    Type = "jpg",
    Filename = "zettel1_picto.jpg",
    Directives = {}
  }
}
_nJH = Wherigo.ZMedia(_eiXtn)
_nJH.Id = "dae6e234-0e67-4583-8e63-8e31a198f0c0"
_nJH.Name = "Zettel2 Pictogramm"
_nJH.Description = ""
_nJH.AltText = ""
_nJH.Resources = {
  {
    Type = "jpg",
    Filename = "zettel2_picto.jpg",
    Directives = {}
  }
}
_dKxRF = Wherigo.ZMedia(_eiXtn)
_dKxRF.Id = "8fc2e5e0-4c0f-404a-a36d-da4138011fa0"
_dKxRF.Name = "Spiegel Pictogramm"
_dKxRF.Description = ""
_dKxRF.AltText = ""
_dKxRF.Resources = {
  {
    Type = "jpg",
    Filename = "spiegel_picto.jpg",
    Directives = {}
  }
}
_JpzFB = Wherigo.ZMedia(_eiXtn)
_JpzFB.Id = "2d042001-d3e4-4e6f-b22b-9082f7ae22be"
_JpzFB.Name = "Rassel Pictogramm"
_JpzFB.Description = ""
_JpzFB.AltText = ""
_JpzFB.Resources = {
  {
    Type = "jpg",
    Filename = "rassel_picto.jpg",
    Directives = {}
  }
}
_wijr = Wherigo.ZMedia(_eiXtn)
_wijr.Id = "80a4cf5a-2348-474d-9224-45ef0b3e39eb"
_wijr.Name = "Coin Pictogramm"
_wijr.Description = ""
_wijr.AltText = ""
_wijr.Resources = {
  {
    Type = "jpg",
    Filename = "Kavalier_picto.jpg",
    Directives = {}
  }
}
_pKpB = Wherigo.ZMedia(_eiXtn)
_pKpB.Id = "e9b35d06-5471-4c5f-b944-b52224de6ac3"
_pKpB.Name = "Muenze werfen"
_pKpB.Description = ""
_pKpB.AltText = ""
_pKpB.Resources = {
  {
    Type = "jpg",
    Filename = "muenze_werfen.jpg",
    Directives = {}
  }
}
_xDkd = Wherigo.ZMedia(_eiXtn)
_xDkd.Id = "f295d8de-cadf-4610-85ab-747229a5f624"
_xDkd.Name = "Muenze Logo"
_xDkd.Description = ""
_xDkd.AltText = ""
_xDkd.Resources = {
  {
    Type = "jpg",
    Filename = "muenze_logo.jpg",
    Directives = {}
  }
}
_mnr = Wherigo.ZMedia(_eiXtn)
_mnr.Id = "61b9968c-1adf-4f16-8594-3a35d31cc162"
_mnr.Name = "Muenze Frosch"
_mnr.Description = ""
_mnr.AltText = ""
_mnr.Resources = {
  {
    Type = "jpg",
    Filename = "muenze_frog.jpg",
    Directives = {}
  }
}
_sc6 = Wherigo.ZMedia(_eiXtn)
_sc6.Id = "40c26316-1b03-4a8e-89d8-68731f1f2ed2"
_sc6.Name = "Zone Gluecksspiel"
_sc6.Description = ""
_sc6.AltText = ""
_sc6.Resources = {
  {
    Type = "jpg",
    Filename = "zone_spiel.jpg",
    Directives = {}
  }
}
_bCD = Wherigo.ZMedia(_eiXtn)
_bCD.Id = "9508633b-13c7-46a1-8b26-4e832a69acf5"
_bCD.Name = "Muenze Frosch Pictogramm"
_bCD.Description = ""
_bCD.AltText = ""
_bCD.Resources = {
  {
    Type = "jpg",
    Filename = "muenze_frog_picto.jpg",
    Directives = {}
  }
}
__XD = Wherigo.ZMedia(_eiXtn)
__XD.Id = "0bcfd61d-078a-409a-96fd-1f0d22102014"
__XD.Name = "Muenze Logo Pictogramm"
__XD.Description = ""
__XD.AltText = ""
__XD.Resources = {
  {
    Type = "jpg",
    Filename = "muenze_logo_picto.jpg",
    Directives = {}
  }
}
_IGGw = Wherigo.ZMedia(_eiXtn)
_IGGw.Id = "f278871d-0b4e-4f82-a349-18cc8a9cee77"
_IGGw.Name = "Beep andere"
_IGGw.Description = ""
_IGGw.AltText = ""
_IGGw.Resources = {
  {
    Type = "mp3",
    Filename = "Beep.mp3",
    Directives = {}
  }
}
_XFZ9_ = Wherigo.ZMedia(_eiXtn)
_XFZ9_.Id = "773601dd-40bd-43db-b216-e2d7439aed69"
_XFZ9_.Name = "rasseln"
_XFZ9_.Description = ""
_XFZ9_.AltText = ""
_XFZ9_.Resources = {
  {
    Type = "mp3",
    Filename = "rasseln.mp3",
    Directives = {}
  }
}
_ICm = Wherigo.ZMedia(_eiXtn)
_ICm.Id = "bd876a07-7943-4f2b-94d6-e73fafdae5aa"
_ICm.Name = "Aufgabe 1 Pictogramm"
_ICm.Description = ""
_ICm.AltText = ""
_ICm.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_1_picto.jpg",
    Directives = {}
  }
}
_HBXxc = Wherigo.ZMedia(_eiXtn)
_HBXxc.Id = "0b58ee96-a0f6-4edc-af16-0c8364c6c3bf"
_HBXxc.Name = "Aufgabe 2 Pictogramm"
_HBXxc.Description = ""
_HBXxc.AltText = ""
_HBXxc.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_2_picto.jpg",
    Directives = {}
  }
}
_FiJ = Wherigo.ZMedia(_eiXtn)
_FiJ.Id = "f1568bfd-a42c-49da-abf1-38ac09921727"
_FiJ.Name = "Aufgabe 3 Pictogramm"
_FiJ.Description = ""
_FiJ.AltText = ""
_FiJ.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_3_picto.jpg",
    Directives = {}
  }
}
_0i17 = Wherigo.ZMedia(_eiXtn)
_0i17.Id = "351e2468-8a21-4b42-9ed4-3e082351b11f"
_0i17.Name = "Aufgabe 4 Pictogramm"
_0i17.Description = ""
_0i17.AltText = ""
_0i17.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_4_picto.jpg",
    Directives = {}
  }
}
_KD0 = Wherigo.ZMedia(_eiXtn)
_KD0.Id = "f0470e60-3ba0-4438-b75f-f1617670a27c"
_KD0.Name = "Aufgabe 5 Pictogramm"
_KD0.Description = ""
_KD0.AltText = ""
_KD0.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_5_picto.jpg",
    Directives = {}
  }
}
_19P = Wherigo.ZMedia(_eiXtn)
_19P.Id = "6fc501a1-2feb-4414-9a56-ff3e5c0f1d73"
_19P.Name = "Aufgabe 6 Pictogramm"
_19P.Description = ""
_19P.AltText = ""
_19P.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_6_picto.jpg",
    Directives = {}
  }
}
_vzSDc = Wherigo.ZMedia(_eiXtn)
_vzSDc.Id = "556f28a6-4595-44cb-b128-bd94900c6723"
_vzSDc.Name = "Aufgabe 7 Pictogramm"
_vzSDc.Description = ""
_vzSDc.AltText = ""
_vzSDc.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_7_picto.jpg",
    Directives = {}
  }
}
_UxT = Wherigo.ZMedia(_eiXtn)
_UxT.Id = "1ff12c26-103c-4ad2-809f-f128823699cf"
_UxT.Name = "Aufgabe 8 Pictogramm"
_UxT.Description = ""
_UxT.AltText = ""
_UxT.Resources = {
  {
    Type = "jpg",
    Filename = "aufgabe_8_picto.jpg",
    Directives = {}
  }
}
_I7Ynz = Wherigo.ZMedia(_eiXtn)
_I7Ynz.Id = "a469d8d1-5cf6-4d7a-9d69-5922af0d6aa5"
_I7Ynz.Name = "Wegpunkt 1 Pictogramm"
_I7Ynz.Description = ""
_I7Ynz.AltText = ""
_I7Ynz.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp1_picto.jpg",
    Directives = {}
  }
}
_xdx8 = Wherigo.ZMedia(_eiXtn)
_xdx8.Id = "dd8456a7-6a85-4f32-bfbb-9cb1f3309062"
_xdx8.Name = "Wegpunkt 2 Pictogramm"
_xdx8.Description = ""
_xdx8.AltText = ""
_xdx8.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp2_picto.jpg",
    Directives = {}
  }
}
_ROQ49 = Wherigo.ZMedia(_eiXtn)
_ROQ49.Id = "a6d286d9-66ad-4b9a-bdd1-4f5962bd6203"
_ROQ49.Name = "Wegpunkt 3 Pictogramm"
_ROQ49.Description = ""
_ROQ49.AltText = ""
_ROQ49.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp3_picto.jpg",
    Directives = {}
  }
}
_1Jvx = Wherigo.ZMedia(_eiXtn)
_1Jvx.Id = "eda158db-7baf-4f7c-b16d-d9da08b05b29"
_1Jvx.Name = "Wegpunkt 4 Pictogramm"
_1Jvx.Description = ""
_1Jvx.AltText = ""
_1Jvx.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp4_picto.jpg",
    Directives = {}
  }
}
_4UB9u = Wherigo.ZMedia(_eiXtn)
_4UB9u.Id = "4c24574e-dbb6-4091-9575-e81e45798aee"
_4UB9u.Name = "Wegpunkt 5 Pictogramm"
_4UB9u.Description = ""
_4UB9u.AltText = ""
_4UB9u.Resources = {
  {
    Type = "jpg",
    Filename = "zone_wp5_picto.jpg",
    Directives = {}
  }
}
_C1Ze = Wherigo.ZMedia(_eiXtn)
_C1Ze.Id = "958672ea-7593-4793-a1f4-153a856573b4"
_C1Ze.Name = "Zone 1 Pictogramm"
_C1Ze.Description = ""
_C1Ze.AltText = ""
_C1Ze.Resources = {
  {
    Type = "jpg",
    Filename = "zone_1_picto.jpg",
    Directives = {}
  }
}
_ur_ = Wherigo.ZMedia(_eiXtn)
_ur_.Id = "0acf6e87-9e36-4c55-b4b0-7d30c96ed41d"
_ur_.Name = "Zone 2 Pictogramm"
_ur_.Description = ""
_ur_.AltText = ""
_ur_.Resources = {
  {
    Type = "jpg",
    Filename = "zone_2_picto.jpg",
    Directives = {}
  }
}
_xdI = Wherigo.ZMedia(_eiXtn)
_xdI.Id = "10ae0516-3686-4ff7-a9d9-896cb5d557f5"
_xdI.Name = "Zone 3 Pictogramm"
_xdI.Description = ""
_xdI.AltText = ""
_xdI.Resources = {
  {
    Type = "jpg",
    Filename = "zone_3_picto.jpg",
    Directives = {}
  }
}
_WKSYP = Wherigo.ZMedia(_eiXtn)
_WKSYP.Id = "f1124a51-716a-4539-b99f-f366c4d222ce"
_WKSYP.Name = "Zone 4 Pictogramm"
_WKSYP.Description = ""
_WKSYP.AltText = ""
_WKSYP.Resources = {
  {
    Type = "jpg",
    Filename = "zone_4_picto.jpg",
    Directives = {}
  }
}
_cKf56 = Wherigo.ZMedia(_eiXtn)
_cKf56.Id = "aa650a57-de5d-4798-b898-65e6bafb9cfc"
_cKf56.Name = "Zone 5 Pictogramm"
_cKf56.Description = ""
_cKf56.AltText = ""
_cKf56.Resources = {
  {
    Type = "jpg",
    Filename = "zone_5_picto.jpg",
    Directives = {}
  }
}
_xBLde = Wherigo.ZMedia(_eiXtn)
_xBLde.Id = "ee9560fd-0a77-4141-b8f9-83988158566b"
_xBLde.Name = "Zone 6 Pictogramm"
_xBLde.Description = ""
_xBLde.AltText = ""
_xBLde.Resources = {
  {
    Type = "jpg",
    Filename = "zone_6_picto.jpg",
    Directives = {}
  }
}
_CgTLI = Wherigo.ZMedia(_eiXtn)
_CgTLI.Id = "733b853d-81cb-4187-98af-1cf4e95f469b"
_CgTLI.Name = "Zone 7 Pictogramm"
_CgTLI.Description = ""
_CgTLI.AltText = ""
_CgTLI.Resources = {
  {
    Type = "jpg",
    Filename = "zone_7_picto.jpg",
    Directives = {}
  }
}
_1Bu = Wherigo.ZMedia(_eiXtn)
_1Bu.Id = "b1c5105e-c92d-4982-8b10-43561bb7a5aa"
_1Bu.Name = "Zone Gluecksspiel Pictogramm"
_1Bu.Description = ""
_1Bu.AltText = ""
_1Bu.Resources = {
  {
    Type = "jpg",
    Filename = "zone_spiel_picto.jpg",
    Directives = {}
  }
}
_eiXtn.Id = "54d1f7dd-0837-4e72-9654-cb46a031f3e3"
_eiXtn.Name = "Till Eulenspiegel"
_eiXtn.Description = [[
Hier beginnt die illustre Demonstration des Till Eulenspiegel<BR>
<BR>
Keine Sorge, es tut auch nicht weh. Es besteht keinerlei Zeitdruck, d.h. es muss keine Aufgabe in einer bestimmten Zeit geschafft werden. Bei Fragen wird euch Till vielleicht sogar helfen.<BR>
<BR>
Benoetigte Ausruestung:<BR>
- provisorische Angel (magnetischer Gegenstand an einem ca. 30cm langen Faden)<BR>
- Ausdauer<BR>
- Humor<BR>
<BR>
Dauer: kommt auf euch an ;) (ca. 2 - 2,5h)<BR>
Strecke: ca. 1,5km<BR>
<BR>
Bitte reagiert nicht hastig, sondern lasst die Cartridge etwas laden. Manchmal braucht sie eine gewisse Zeit bis es weiter geht.]]
_eiXtn.Visible = true
_eiXtn.Activity = "TourGuide"
_eiXtn.StartingLocationDescription = ""
_eiXtn.StartingLocation = ZonePoint(50.955017, 11.19985, 0)
_eiXtn.Version = "1.4"
_eiXtn.Company = ""
_eiXtn.Author = "spilles &amp; MiWue"
_eiXtn.BuilderVersion = "URWIGO 1.14.4469.18959"
_eiXtn.CreateDate = "09/12/2011 19:12:30"
_eiXtn.PublishDate = "1/1/0001 12:00:00 AM"
_eiXtn.UpdateDate = "11/12/2012 20:56:46"
_eiXtn.LastPlayedDate = "1/1/0001 12:00:00 AM"
_eiXtn.TargetDevice = "PocketPC"
_eiXtn.TargetDeviceVersion = "0"
_eiXtn.StateId = "1"
_eiXtn.CountryId = "2"
_eiXtn.Complete = false
_eiXtn.UseLogging = true
_eiXtn.Media = _YVNt
_eiXtn.Icon = _0Z3pA
_4VcW = Wherigo.Zone(_eiXtn)
_4VcW.Id = "cae77b4d-50c1-4424-bd12-406fb988075e"
_4VcW.Name = "Lesen will gelernt sein"
_4VcW.Description = "Jaja, wer lesen kann ist klar im Vorteil ..."
_4VcW.Visible = false
_4VcW.Media = _La_
_4VcW.Icon = _C1Ze
_4VcW.Commands = {}
_4VcW.DistanceRange = Distance(-1, "feet")
_4VcW.ShowObjects = "OnEnter"
_4VcW.ProximityRange = Distance(5, "meters")
_4VcW.AllowSetPositionTo = false
_4VcW.Active = true
_4VcW.Points = {
  ZonePoint(50.9551152994476, 11.1999043822289, 0),
  ZonePoint(50.9551136098463, 11.1996549367905, 0),
  ZonePoint(50.9549480286228, 11.1996522545815, 0),
  ZonePoint(50.9549463390155, 11.1999097466469, 0)
}
_4VcW.OriginalPoint = ZonePoint(50.955030819233, 11.1997803300619, 0)
_4VcW.DistanceRangeUOM = "Feet"
_4VcW.ProximityRangeUOM = "Meters"
_4VcW.OutOfRangeName = ""
_4VcW.InRangeName = ""
_MMx = Wherigo.Zone(_eiXtn)
_MMx.Id = "6f12b67a-60cb-4ab8-93ed-f7794667e7b7"
_MMx.Name = "Mir ist alles ei(n)erlei"
_MMx.Description = "Ja welch ein Spass ... wer suchet der findet"
_MMx.Visible = false
_MMx.Media = _c97x
_MMx.Icon = _ur_
_MMx.Commands = {}
_MMx.DistanceRange = Distance(-1, "feet")
_MMx.ShowObjects = "OnEnter"
_MMx.ProximityRange = Distance(5, "meters")
_MMx.AllowSetPositionTo = false
_MMx.Active = false
_MMx.Points = {
  ZonePoint(50.9520147777277, 11.1997407674789, 0),
  ZonePoint(50.9519539479847, 11.19957447052, 0),
  ZonePoint(50.9518289088187, 11.19957447052, 0),
  ZonePoint(50.9517765274465, 11.1997327208519, 0),
  ZonePoint(50.9518356677011, 11.1999043822289, 0),
  ZonePoint(50.9519488788359, 11.1999043822289, 0)
}
_MMx.OriginalPoint = ZonePoint(50.9518931180858, 11.1997385323048, 0)
_MMx.DistanceRangeUOM = "Feet"
_MMx.ProximityRangeUOM = "Meters"
_MMx.OutOfRangeName = ""
_MMx.InRangeName = ""
_8Xm = Wherigo.Zone(_eiXtn)
_8Xm.Id = "abaea60c-2083-4377-baa4-738ad6cd7323"
_8Xm.Name = "Ich angel mir 'ne Dose"
_8Xm.Description = "Tief verborgen befindet sie sich, die gesuchte Dose"
_8Xm.Visible = false
_8Xm.Media = _pse
_8Xm.Icon = _xdI
_8Xm.Commands = {}
_8Xm.DistanceRange = Distance(-1, "feet")
_8Xm.ShowObjects = "OnEnter"
_8Xm.ProximityRange = Distance(5, "meters")
_8Xm.AllowSetPositionTo = false
_8Xm.Active = false
_8Xm.Points = {
  ZonePoint(50.9511530156109, 11.2000438570976, 0),
  ZonePoint(50.9510685282689, 11.1998078227043, 0),
  ZonePoint(50.9508894145958, 11.1998024582863, 0),
  ZonePoint(50.9508116858058, 11.2000384926796, 0),
  ZonePoint(50.9508894145957, 11.2002611160278, 0),
  ZonePoint(50.9510651487721, 11.2002718448639, 0)
}
_8Xm.OriginalPoint = ZonePoint(50.9509795346082, 11.2000375986099, 0)
_8Xm.DistanceRangeUOM = "Feet"
_8Xm.ProximityRangeUOM = "Meters"
_8Xm.OutOfRangeName = ""
_8Xm.InRangeName = ""
_ex7 = Wherigo.Zone(_eiXtn)
_ex7.Id = "61a0795e-b423-48c5-b244-8f599b7a8ded"
_ex7.Name = "ACHTUNG, hisst die Dose(n)"
_ex7.Description = "Im Narrenreich werden nun die Dosen am Maste hochgezogen"
_ex7.Visible = false
_ex7.Media = _ymSV
_ex7.Icon = _WKSYP
_ex7.Commands = {}
_ex7.DistanceRange = Distance(-1, "feet")
_ex7.ShowObjects = "Always"
_ex7.ProximityRange = Distance(5, "meters")
_ex7.AllowSetPositionTo = false
_ex7.Active = false
_ex7.Points = {
  ZonePoint(50.9504297989933, 11.2006875872612, 0),
  ZonePoint(50.9503875546842, 11.2004971504211, 0),
  ZonePoint(50.9502287157382, 11.2004810571671, 0),
  ZonePoint(50.9501814019045, 11.2006822228432, 0),
  ZonePoint(50.9502236464011, 11.2008458375931, 0),
  ZonePoint(50.9503436205619, 11.200840473175, 0)
}
_ex7.OriginalPoint = ZonePoint(50.9502991230472, 11.2006723880768, 0)
_ex7.DistanceRangeUOM = "Feet"
_ex7.ProximityRangeUOM = "Meters"
_ex7.OutOfRangeName = ""
_ex7.InRangeName = ""
_q45R8 = Wherigo.Zone(_eiXtn)
_q45R8.Id = "2ea883b0-cd16-4de9-b429-c56da7677e89"
_q45R8.Name = "Verflixt noch eins, geh' doch auf"
_q45R8.Description = "Hier verbirgt sich das Versteck des Schallmey Till"
_q45R8.Visible = false
_q45R8.Media = _3pE
_q45R8.Icon = _xBLde
_q45R8.Commands = {}
_q45R8.DistanceRange = Distance(-1, "feet")
_q45R8.ShowObjects = "OnEnter"
_q45R8.ProximityRange = Distance(5, "meters")
_q45R8.AllowSetPositionTo = false
_q45R8.Active = false
_q45R8.Points = {
  ZonePoint(50.9514588585057, 11.2050354480743, 0),
  ZonePoint(50.9514588585056, 11.2048557400703, 0),
  ZonePoint(50.9513693025075, 11.204786002636, 0),
  ZonePoint(50.9512493309942, 11.2048557400703, 0),
  ZonePoint(50.9512527104777, 11.2050139904022, 0),
  ZonePoint(50.9513574743439, 11.2051279842854, 0)
}
_q45R8.OriginalPoint = ZonePoint(50.9513577558891, 11.2049458175898, 0)
_q45R8.DistanceRangeUOM = "Feet"
_q45R8.ProximityRangeUOM = "Meters"
_q45R8.OutOfRangeName = ""
_q45R8.InRangeName = ""
_LLC = Wherigo.Zone(_eiXtn)
_LLC.Id = "59ebe455-3607-4b2e-b1a1-18d83815fbe8"
_LLC.Name = "Jetzt wird verschnauft"
_LLC.Description = "Nach all' der Schinderei wird noch verschnauft"
_LLC.Visible = false
_LLC.Media = _aLFg
_LLC.Icon = _CgTLI
_LLC.Commands = {}
_LLC.DistanceRange = Distance(-1, "feet")
_LLC.ShowObjects = "OnEnter"
_LLC.ProximityRange = Distance(5, "meters")
_LLC.AllowSetPositionTo = false
_LLC.Active = false
_LLC.Points = {
  ZonePoint(50.9502405441894, 11.202629506588, 0),
  ZonePoint(50.9501645040956, 11.2023988366127, 0),
  ZonePoint(50.9500394601154, 11.2023961544037, 0),
  ZonePoint(50.9499634196926, 11.2025946378708, 0),
  ZonePoint(50.9500377703296, 11.202809214592, 0),
  ZonePoint(50.9501560551886, 11.202811896801, 0)
}
_LLC.OriginalPoint = ZonePoint(50.9501002922685, 11.2026067078114, 0)
_LLC.DistanceRangeUOM = "Feet"
_LLC.ProximityRangeUOM = "Meters"
_LLC.OutOfRangeName = ""
_LLC.InRangeName = ""
_kcK = Wherigo.Zone(_eiXtn)
_kcK.Id = "2b6c73d7-4ad2-48c4-b377-a47b3fe49218"
_kcK.Name = "Wegpunkt 1"
_kcK.Description = "Biege hier rechts ab."
_kcK.Visible = false
_kcK.Media = _azc
_kcK.Icon = _I7Ynz
_kcK.Commands = {}
_kcK.DistanceRange = Distance(-1, "feet")
_kcK.ShowObjects = "OnEnter"
_kcK.ProximityRange = Distance(5, "meters")
_kcK.AllowSetPositionTo = false
_kcK.Active = false
_kcK.Points = {
  ZonePoint(50.952473532809, 11.200747936964, 0),
  ZonePoint(50.9525166200702, 11.2009102106094, 0),
  ZonePoint(50.9524051000182, 11.2009611725807, 0),
  ZonePoint(50.9523780648138, 11.2007975578308, 0)
}
_kcK.OriginalPoint = ZonePoint(50.9524433294278, 11.2008542194962, 0)
_kcK.DistanceRangeUOM = "Feet"
_kcK.ProximityRangeUOM = "Meters"
_kcK.OutOfRangeName = ""
_kcK.InRangeName = ""
_oBORv = Wherigo.Zone(_eiXtn)
_oBORv.Id = "daf9478b-627f-4214-8e30-30051cbc5f53"
_oBORv.Name = "Wegpunkt 2"
_oBORv.Description = "Biege hier rechts ab."
_oBORv.Visible = false
_oBORv.Media = _YXqr9
_oBORv.Icon = _xdx8
_oBORv.Commands = {}
_oBORv.DistanceRange = Distance(-1, "feet")
_oBORv.ShowObjects = "OnEnter"
_oBORv.ProximityRange = Distance(5, "meters")
_oBORv.AllowSetPositionTo = false
_oBORv.Active = false
_oBORv.Points = {
  ZonePoint(50.9518077873058, 11.1999835073948, 0),
  ZonePoint(50.9519598619921, 11.1999191343784, 0),
  ZonePoint(50.9519750694334, 11.2000559270382, 0),
  ZonePoint(50.9518213050758, 11.2001068890095, 0)
}
_oBORv.OriginalPoint = ZonePoint(50.9518910059518, 11.2000163644552, 0)
_oBORv.DistanceRangeUOM = "Feet"
_oBORv.ProximityRangeUOM = "Meters"
_oBORv.OutOfRangeName = ""
_oBORv.InRangeName = ""
_iYWZn = Wherigo.Zone(_eiXtn)
_iYWZn.Id = "479e9114-d127-4388-a366-156aaa747ee7"
_iYWZn.Name = "Wegpunkt 3"
_iYWZn.Description = "Biege hier rechts ab."
_iYWZn.Visible = false
_iYWZn.Media = _R4V
_iYWZn.Icon = _ROQ49
_iYWZn.Commands = {}
_iYWZn.DistanceRange = Distance(-1, "feet")
_iYWZn.ShowObjects = "OnEnter"
_iYWZn.ProximityRange = Distance(5, "meters")
_iYWZn.AllowSetPositionTo = false
_iYWZn.Active = false
_iYWZn.Points = {
  ZonePoint(50.9511073924662, 11.2003764510155, 0),
  ZonePoint(50.9511327386637, 11.2005347013474, 0),
  ZonePoint(50.9509772817677, 11.2006205320358, 0),
  ZonePoint(50.9509502457328, 11.2004542350769, 0)
}
_iYWZn.OriginalPoint = ZonePoint(50.9510419146576, 11.2004964798689, 0)
_iYWZn.DistanceRangeUOM = "Feet"
_iYWZn.ProximityRangeUOM = "Meters"
_iYWZn.OutOfRangeName = ""
_iYWZn.InRangeName = ""
_i0qYP = Wherigo.Zone(_eiXtn)
_i0qYP.Id = "def7e25d-24da-4d7c-9357-7c8df954ee08"
_i0qYP.Name = "Wegpunkt 4"
_i0qYP.Description = "Biege hier rechts ab."
_i0qYP.Visible = false
_i0qYP.Media = _7hi
_i0qYP.Icon = _1Jvx
_i0qYP.Commands = {}
_i0qYP.DistanceRange = Distance(-1, "feet")
_i0qYP.ShowObjects = "OnEnter"
_i0qYP.ProximityRange = Distance(5, "meters")
_i0qYP.AllowSetPositionTo = false
_i0qYP.Active = false
_i0qYP.Points = {
  ZonePoint(50.950508373307, 11.2008713185787, 0),
  ZonePoint(50.9503867097983, 11.2009356915951, 0),
  ZonePoint(50.9503698120636, 11.2008042633533, 0),
  ZonePoint(50.9504914756165, 11.200747936964, 0)
}
_i0qYP.OriginalPoint = ZonePoint(50.9504390926964, 11.2008398026228, 0)
_i0qYP.DistanceRangeUOM = "Feet"
_i0qYP.ProximityRangeUOM = "Meters"
_i0qYP.OutOfRangeName = ""
_i0qYP.InRangeName = ""
_MnK = Wherigo.Zone(_eiXtn)
_MnK.Id = "7e8ad315-1009-4fd6-a53c-29bf1be4d4fb"
_MnK.Name = "Wegpunkt 5"
_MnK.Description = "Gehe aus dem Wald hinaus, bis zur Strasse hinunter und darueber hinweg."
_MnK.Visible = false
_MnK.Media = _bY8q
_MnK.Icon = _4UB9u
_MnK.Commands = {}
_MnK.DistanceRange = Distance(-1, "feet")
_MnK.ShowObjects = "OnEnter"
_MnK.ProximityRange = Distance(5, "meters")
_MnK.AllowSetPositionTo = false
_MnK.Active = false
_MnK.Points = {
  ZonePoint(50.9501062066056, 11.2009987235069, 0),
  ZonePoint(50.9500183377877, 11.20101749897, 0),
  ZonePoint(50.9500403050078, 11.2012293934822, 0),
  ZonePoint(50.9501298635667, 11.2012106180191, 0)
}
_MnK.OriginalPoint = ZonePoint(50.9500736782419, 11.2011140584946, 0)
_MnK.DistanceRangeUOM = "Feet"
_MnK.ProximityRangeUOM = "Meters"
_MnK.OutOfRangeName = ""
_MnK.InRangeName = ""
_BR8N = Wherigo.Zone(_eiXtn)
_BR8N.Id = "73bff733-51ac-4730-ad44-e2dc675cadf2"
_BR8N.Name = "Lass mal hoeren"
_BR8N.Description = ""
_BR8N.Visible = false
_BR8N.Media = _M1j
_BR8N.Icon = _cKf56
_BR8N.Commands = {}
_BR8N.DistanceRange = Distance(-1, "feet")
_BR8N.ShowObjects = "OnEnter"
_BR8N.ProximityRange = Distance(5, "meters")
_BR8N.AllowSetPositionTo = false
_BR8N.Active = false
_BR8N.Points = {
  ZonePoint(50.9506198979095, 11.202809214592, 0),
  ZonePoint(50.9506959372583, 11.2029540538788, 0),
  ZonePoint(50.9506520034275, 11.2031230330467, 0),
  ZonePoint(50.950559066341, 11.2031257152557, 0),
  ZonePoint(50.9505235812225, 11.2029701471329, 0),
  ZonePoint(50.9505303402948, 11.2028333544731, 0)
}
_BR8N.OriginalPoint = ZonePoint(50.9505968044089, 11.2029692530632, 0)
_BR8N.DistanceRangeUOM = "Feet"
_BR8N.ProximityRangeUOM = "Meters"
_BR8N.OutOfRangeName = ""
_BR8N.InRangeName = ""
_lJLB = Wherigo.Zone(_eiXtn)
_lJLB.Id = "0eeafe0b-2755-43c4-9a9e-5895f1592630"
_lJLB.Name = "Gluecksspiel"
_lJLB.Description = "Ein kleines Gluecksspiel wird doch niemand verwehren"
_lJLB.Visible = false
_lJLB.Media = _sc6
_lJLB.Icon = _1Bu
_lJLB.Commands = {}
_lJLB.DistanceRange = Distance(-1, "feet")
_lJLB.ShowObjects = "OnEnter"
_lJLB.ProximityRange = Distance(5, "meters")
_lJLB.AllowSetPositionTo = false
_lJLB.Active = false
_lJLB.Points = {
  ZonePoint(50.9538007710838, 11.2000747025013, 0),
  ZonePoint(50.9538430122907, 11.2003429234028, 0),
  ZonePoint(50.9536503920756, 11.2004099786282, 0),
  ZonePoint(50.9536182886289, 11.2001417577267, 0)
}
_lJLB.OriginalPoint = ZonePoint(50.9537281160197, 11.2002423405647, 0)
_lJLB.DistanceRangeUOM = "Feet"
_lJLB.ProximityRangeUOM = "Meters"
_lJLB.OutOfRangeName = ""
_lJLB.InRangeName = ""
_L0J = Wherigo.ZCharacter(_eiXtn)
_L0J.Id = "91c83dce-becf-40b6-a712-50344ef440ce"
_L0J.Name = "Till Eulenspiegel"
_L0J.Description = ""
_L0J.Visible = true
_L0J.Media = _rZ0wN
_L0J.Icon = _0Z3pA
_L0J.Commands = {
  _PxceW = Wherigo.ZCommand({
    Text = "1. Code eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Eingabe Code 1"
  }),
  _geDc = Wherigo.ZCommand({
    Text = "1. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Hinweis fur erste Station"
  }),
  _NvOw8 = Wherigo.ZCommand({
    Text = "2. Code eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Eingabe Code 2"
  }),
  _wyQ_ = Wherigo.ZCommand({
    Text = "2. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Hinweis fur zweite Station"
  }),
  _VTA9p = Wherigo.ZCommand({
    Text = "3. Code eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Eingabe Code 3"
  }),
  _y5s = Wherigo.ZCommand({
    Text = "3. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Hinweis fur dritte Station"
  }),
  _zFj = Wherigo.ZCommand({
    Text = "4. Code eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Eingabe Code 4"
  }),
  _mHC = Wherigo.ZCommand({
    Text = "4. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Hinweis fur vierte Station"
  }),
  _Cxo = Wherigo.ZCommand({
    Text = "Quersumme eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Quersumme aller Codes eingeben"
  }),
  _NZ26o = Wherigo.ZCommand({
    Text = "6. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Hilfe furs Final"
  }),
  _5oL5 = Wherigo.ZCommand({
    Text = "6. Code eingeben",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _SNuPZ = Wherigo.ZCommand({
    Text = "Statistik",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _6RK = Wherigo.ZCommand({
    Text = "Bonus suchen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _2o1Fe = Wherigo.ZCommand({
    Text = "Runde beenden",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _56roN = Wherigo.ZCommand({
    Text = "Dreieck 1",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _2fMhu = Wherigo.ZCommand({
    Text = "Kreis 1",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _4_eJF = Wherigo.ZCommand({
    Text = "Quadrat 1",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _CP43O = Wherigo.ZCommand({
    Text = "Kreuz 1",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _HQOjW = Wherigo.ZCommand({
    Text = "Raute 1",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _aAjV = Wherigo.ZCommand({
    Text = "5. Hilfe holen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _utQ = Wherigo.ZCommand({
    Text = "Nein danke",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _0Wo = Wherigo.ZCommand({
    Text = "Spielchen spielen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _S50 = Wherigo.ZCommand({
    Text = "Paare zuordnen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
_L0J.Commands._PxceW.Custom = true
_L0J.Commands._PxceW.Id = "a4d20b89-f5bc-4bad-93b2-21eab9b18b9e"
_L0J.Commands._PxceW.WorksWithAll = true
_L0J.Commands._geDc.Custom = true
_L0J.Commands._geDc.Id = "36781516-4996-4745-8dd4-4c7ad6d94d6c"
_L0J.Commands._geDc.WorksWithAll = true
_L0J.Commands._NvOw8.Custom = true
_L0J.Commands._NvOw8.Id = "c82d20ff-969e-4d51-9dd4-8bd45e9c3646"
_L0J.Commands._NvOw8.WorksWithAll = true
_L0J.Commands._wyQ_.Custom = true
_L0J.Commands._wyQ_.Id = "882bb82d-2708-407f-95c8-69dfbd799257"
_L0J.Commands._wyQ_.WorksWithAll = true
_L0J.Commands._VTA9p.Custom = true
_L0J.Commands._VTA9p.Id = "7c622b6b-4a15-4ab9-8dc7-06f085aeb7f8"
_L0J.Commands._VTA9p.WorksWithAll = true
_L0J.Commands._y5s.Custom = true
_L0J.Commands._y5s.Id = "82f9bea2-fa11-40e1-923c-c6f1cb0d5bdd"
_L0J.Commands._y5s.WorksWithAll = true
_L0J.Commands._zFj.Custom = true
_L0J.Commands._zFj.Id = "0f93bb4f-ec0c-4b72-8a91-b3411b813932"
_L0J.Commands._zFj.WorksWithAll = true
_L0J.Commands._mHC.Custom = true
_L0J.Commands._mHC.Id = "cd15bf3f-ad6d-40a2-8fa7-a1a7c24372ae"
_L0J.Commands._mHC.WorksWithAll = true
_L0J.Commands._Cxo.Custom = true
_L0J.Commands._Cxo.Id = "3fe445f3-5463-43d6-9dad-bd568d1cc523"
_L0J.Commands._Cxo.WorksWithAll = true
_L0J.Commands._NZ26o.Custom = true
_L0J.Commands._NZ26o.Id = "5744cf12-ff8c-4a80-bd45-c982b2b36b6c"
_L0J.Commands._NZ26o.WorksWithAll = true
_L0J.Commands._5oL5.Custom = true
_L0J.Commands._5oL5.Id = "06ef6952-35f0-4822-8b55-c55ce5c5ab54"
_L0J.Commands._5oL5.WorksWithAll = true
_L0J.Commands._SNuPZ.Custom = true
_L0J.Commands._SNuPZ.Id = "0283f5e6-cd0e-456f-bc61-c1ad115f82e9"
_L0J.Commands._SNuPZ.WorksWithAll = true
_L0J.Commands._6RK.Custom = true
_L0J.Commands._6RK.Id = "43c6e8e0-6e48-4e0e-af6a-8679c0c52554"
_L0J.Commands._6RK.WorksWithAll = true
_L0J.Commands._2o1Fe.Custom = true
_L0J.Commands._2o1Fe.Id = "68a04067-958f-446e-9c71-580f1403359f"
_L0J.Commands._2o1Fe.WorksWithAll = true
_L0J.Commands._56roN.Custom = true
_L0J.Commands._56roN.Id = "5cff099f-d2ec-443a-afd7-865a448356e5"
_L0J.Commands._56roN.WorksWithAll = true
_L0J.Commands._2fMhu.Custom = true
_L0J.Commands._2fMhu.Id = "6ef6eca8-1d88-4590-9c64-066943803af1"
_L0J.Commands._2fMhu.WorksWithAll = true
_L0J.Commands._4_eJF.Custom = true
_L0J.Commands._4_eJF.Id = "0333dc58-bb79-409d-8356-e4d6bfff2e8c"
_L0J.Commands._4_eJF.WorksWithAll = true
_L0J.Commands._CP43O.Custom = true
_L0J.Commands._CP43O.Id = "5aea6dbc-f4e5-411a-b0dc-8588deb2f63c"
_L0J.Commands._CP43O.WorksWithAll = true
_L0J.Commands._HQOjW.Custom = true
_L0J.Commands._HQOjW.Id = "4788f9e4-43de-4bcc-b6f9-78af45998a2f"
_L0J.Commands._HQOjW.WorksWithAll = true
_L0J.Commands._aAjV.Custom = true
_L0J.Commands._aAjV.Id = "03c82a6a-d2e0-4b3e-b8ab-8b50920e59ce"
_L0J.Commands._aAjV.WorksWithAll = true
_L0J.Commands._utQ.Custom = true
_L0J.Commands._utQ.Id = "2fdf4126-f923-4c25-8acf-08d1ea2eb776"
_L0J.Commands._utQ.WorksWithAll = true
_L0J.Commands._0Wo.Custom = true
_L0J.Commands._0Wo.Id = "ff5f61a0-210a-4706-a0c1-5d08a70b3927"
_L0J.Commands._0Wo.WorksWithAll = true
_L0J.Commands._S50.Custom = true
_L0J.Commands._S50.Id = "e078a8a5-9818-4df7-9384-220e10167e72"
_L0J.Commands._S50.WorksWithAll = true
_L0J.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_L0J.Gender = "Male"
_L0J.Type = "NPC"
_LQrTf = Wherigo.ZItem({Cartridge = _eiXtn, Container = Player})
_LQrTf.Id = "9ba32069-55e2-4374-8916-fd4ed43ede88"
_LQrTf.Name = "Notizzettel"
_LQrTf.Description = "Dieser kleine Spicker hilft dir, deinem Gedaechtnissieb vorerst die Loecher zu stopfen!"
_LQrTf.Visible = false
_LQrTf.Media = _rPW_3
_LQrTf.Icon = _RcWNN
_LQrTf.Commands = {}
_LQrTf.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_LQrTf.Locked = false
_LQrTf.Opened = false
_A3b = Wherigo.ZItem({Cartridge = _eiXtn, Container = Player})
_A3b.Id = "d6556f8f-7cb8-4fd2-b7a5-12d6ae8af031"
_A3b.Name = "Coin"
_A3b.Description = [[
Als Dank darfst du diesen Coin bewundern.<BR>
4MP4JA]]
_A3b.Visible = false
_A3b.Media = _ih3
_A3b.Icon = _wijr
_A3b.Commands = {}
_A3b.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_A3b.Locked = false
_A3b.Opened = false
_zS9 = Wherigo.ZItem({Cartridge = _eiXtn, Container = Player})
_zS9.Id = "4baa9241-93bc-44dd-ae9b-a41ef313cbca"
_zS9.Name = "Glockenrassel"
_zS9.Description = "Ein kleines nerrisches Spielzeug zum Zeitvertreib"
_zS9.Visible = true
_zS9.Media = _Ro5T
_zS9.Icon = _JpzFB
_zS9.Commands = {
  _Rtb = Wherigo.ZCommand({
    Text = "rasseln",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = ""
  })
}
_zS9.Commands._Rtb.Custom = true
_zS9.Commands._Rtb.Id = "f2494579-3ce6-4346-85cc-be7d24d314ee"
_zS9.Commands._Rtb.WorksWithAll = true
_zS9.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_zS9.Locked = false
_zS9.Opened = false
_6Yi = Wherigo.ZItem({Cartridge = _eiXtn, Container = Player})
_6Yi.Id = "e4c6e18e-4920-4670-a931-21bb4174e9cc"
_6Yi.Name = "Spiegel"
_6Yi.Description = "Ein unverzichtbares Utensil fuer einen Narren"
_6Yi.Visible = true
_6Yi.Media = _kpw
_6Yi.Icon = _dKxRF
_6Yi.Commands = {
  _Up1ND = Wherigo.ZCommand({
    Text = "Spiegelbild",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _OZ80J = Wherigo.ZCommand({
    Text = "Zettel lesen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
_6Yi.Commands._Up1ND.Custom = true
_6Yi.Commands._Up1ND.Id = "60894a26-6053-4e0a-b4ad-fe31d74ed117"
_6Yi.Commands._Up1ND.WorksWithAll = true
_6Yi.Commands._OZ80J.Custom = true
_6Yi.Commands._OZ80J.Id = "23d421af-1bb6-4bd8-8948-1211d4a75145"
_6Yi.Commands._OZ80J.WorksWithAll = true
_6Yi.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_6Yi.Locked = false
_6Yi.Opened = false
_cEE37 = Wherigo.ZItem(_eiXtn)
_cEE37.Id = "b6f0c27a-108a-4c17-9ee6-ee57bcd6bc0d"
_cEE37.Name = "Zettel"
_cEE37.Description = "Ein unscheinbarer Zettel"
_cEE37.Visible = false
_cEE37.Media = _FBA
_cEE37.Icon = _gSY7X
_cEE37.Commands = {
  _U40e = Wherigo.ZCommand({
    Text = "Entfalten",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _9k5f6 = Wherigo.ZCommand({
    Text = "Aufnehmen",
    CmdWith = false,
    Enabled = true,
    EmptyTargetListText = "Nicht verfugbar"
  }),
  _L_l = Wherigo.ZCommand({
    Text = "Wegwerfen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
_cEE37.Commands._U40e.Custom = true
_cEE37.Commands._U40e.Id = "14e902ca-76d0-4e31-94f2-ca8c38436f99"
_cEE37.Commands._U40e.WorksWithAll = true
_cEE37.Commands._9k5f6.Custom = true
_cEE37.Commands._9k5f6.Id = "0b15b9cd-2796-4878-b684-087710d3958e"
_cEE37.Commands._9k5f6.WorksWithAll = true
_cEE37.Commands._L_l.Custom = true
_cEE37.Commands._L_l.Id = "240b39f3-c381-41ac-8fa0-189d206c6038"
_cEE37.Commands._L_l.WorksWithAll = true
_cEE37.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_cEE37.Locked = false
_cEE37.Opened = false
_M8c4 = Wherigo.ZItem(_eiXtn)
_M8c4.Id = "ca52032e-5e45-492e-b656-164458e6a2a3"
_M8c4.Name = "Muenze"
_M8c4.Description = "Diese Muenze wird dir vielleicht noch einmal Glueck bringen"
_M8c4.Visible = true
_M8c4.Commands = {
  _KIon = Wherigo.ZCommand({
    Text = "drehen",
    CmdWith = false,
    Enabled = false,
    EmptyTargetListText = "Nicht verfugbar"
  })
}
_M8c4.Commands._KIon.Custom = true
_M8c4.Commands._KIon.Id = "2741805b-1ccc-4371-ad14-cf506fc6bbe6"
_M8c4.Commands._KIon.WorksWithAll = true
_M8c4.ObjectLocation = Wherigo.INVALID_ZONEPOINT
_M8c4.Locked = false
_M8c4.Opened = false
_Aie = Wherigo.ZTask(_eiXtn)
_Aie.Id = "c536a0fe-ddc0-4808-84bb-bdf2e80bf5d3"
_Aie.Name = "Suche den geheimen Code"
_Aie.Description = "Suche den richtigen Code, doch nur einer ist der Wahre"
_Aie.Visible = true
_Aie.Media = _Vq2o
_Aie.Icon = _ICm
_Aie.Active = false
_Aie.Complete = false
_Aie.CorrectState = "None"
_n1j = Wherigo.ZTask(_eiXtn)
_n1j.Id = "7c2fe47a-eee0-4e23-a361-9323653bc857"
_n1j.Name = "Finde das richtige Ei"
_n1j.Description = "Wer suchet der findet, genau ein Ei wird dir weiter helfen"
_n1j.Visible = true
_n1j.Media = _Wji
_n1j.Icon = _HBXxc
_n1j.Active = false
_n1j.Complete = false
_n1j.CorrectState = "None"
_Idq = Wherigo.ZTask(_eiXtn)
_Idq.Id = "7bb39c21-e9b7-4014-bcbf-79b3026bc32b"
_Idq.Name = "Angel die richtige Dose"
_Idq.Description = "Ausgeruestet mit deiner Dosenangel musst du die richtige Dose angeln"
_Idq.Visible = true
_Idq.Media = _jdR
_Idq.Icon = _FiJ
_Idq.Active = false
_Idq.Complete = false
_Idq.CorrectState = "None"
_Qv3CJ = Wherigo.ZTask(_eiXtn)
_Qv3CJ.Id = "a584b5ea-8819-49b8-9828-536e9295cd07"
_Qv3CJ.Name = "Hisse die wahre Dose"
_Qv3CJ.Description = "Finde den richtigen \"Mast\" um die notige Dose zu hissen"
_Qv3CJ.Visible = true
_Qv3CJ.Media = _r4FOM
_Qv3CJ.Icon = _0i17
_Qv3CJ.Active = false
_Qv3CJ.Complete = false
_Qv3CJ.CorrectState = "None"
_UWv_y = Wherigo.ZTask(_eiXtn)
_UWv_y.Id = "e5f6eb05-2f38-4c9f-a299-66ad5bfb8e32"
_UWv_y.Name = "Errechne die Quersumme"
_UWv_y.Description = "Ermittle von allen Codes die Quersummen und summiere diese Quersummen auf"
_UWv_y.Visible = true
_UWv_y.Media = _CqN4
_UWv_y.Icon = _KD0
_UWv_y.Active = false
_UWv_y.Complete = false
_UWv_y.CorrectState = "None"
_AHC = Wherigo.ZTask(_eiXtn)
_AHC.Id = "6e42a21d-3efe-4c6b-bcb1-f549f9e50635"
_AHC.Name = "Oeffne den begehrten Schatz"
_AHC.Description = "Hier befindet sich der begehrte Schatz und der Hinweis fuer den Bonus"
_AHC.Visible = true
_AHC.Media = _hyU
_AHC.Icon = _vzSDc
_AHC.Active = false
_AHC.Complete = false
_AHC.CorrectState = "None"
_DWmPW = Wherigo.ZTask(_eiXtn)
_DWmPW.Id = "54b07860-b108-4b67-9305-72da8df6905e"
_DWmPW.Name = "Verschnaufspause"
_DWmPW.Description = "Erst rasten, dann nochmal hasten (und zwar hoch)"
_DWmPW.Visible = true
_DWmPW.Media = __WNf
_DWmPW.Icon = _UxT
_DWmPW.Active = false
_DWmPW.Complete = false
_DWmPW.CorrectState = "None"
_E1g33 = Wherigo.ZTask(_eiXtn)
_E1g33.Id = "0a0b7d87-4ae8-42ea-9bb5-70234280f869"
_E1g33.Name = "Suche die richtigen Paare zusammen"
_E1g33.Description = "Finde heraus, welche Paare zusammen gehoeren."
_E1g33.Visible = true
_E1g33.Media = _XvS5d
_E1g33.Icon = _19P
_E1g33.Active = false
_E1g33.Complete = false
_E1g33.CorrectState = "None"
FalscheEingabe = 0
_5AB = 0
_zNq = false
_aabUE = false
_0BV3 = false
_QxjT = false
_3Lo73 = false
_wS7 = false
_47Jq = false
_YqV_C = 0
_CkuVd = 0
_pqm = 0
_USPpZ = 0
_v19P = 0
_Z1J = 0
_4Ed = 0
_zMkrb = 0
_B6lZ = 0
_gCT7i = false
_5b_ = "_4VcW"
_77bX = "_L0J"
_NuVS = "_LQrTf"
_KlC = "_Aie"
_gJANZ = "_Ejb_"
_4f5B = "_0DdyD"
_eiXtn.ZVariables = {
  FalscheEingabe = 0,
  _5AB = 0,
  _zNq = false,
  _aabUE = false,
  _0BV3 = false,
  _QxjT = false,
  _3Lo73 = false,
  _wS7 = false,
  _47Jq = false,
  _YqV_C = 0,
  _CkuVd = 0,
  _pqm = 0,
  _USPpZ = 0,
  _v19P = 0,
  _Z1J = 0,
  _4Ed = 0,
  _zMkrb = 0,
  _B6lZ = 0,
  _gCT7i = false,
  _5b_ = "_4VcW",
  _77bX = "_L0J",
  _NuVS = "_LQrTf",
  _KlC = "_Aie",
  _gJANZ = "_Ejb_",
  _4f5B = "_0DdyD"
}
_0DdyD = Wherigo.ZTimer(_eiXtn)
_0DdyD.Id = "4cfc2f9c-2e12-4816-acae-78b96a494635"
_0DdyD.Name = "Laufzeit1"
_0DdyD.Description = ""
_0DdyD.Visible = true
_0DdyD.Duration = 1800
_0DdyD.Type = "Countdown"
_jFLYg = Wherigo.ZTimer(_eiXtn)
_jFLYg.Id = "e7f43b80-2bdb-486e-bf93-c60d07e8b4fc"
_jFLYg.Name = "Laufzeit2"
_jFLYg.Description = ""
_jFLYg.Visible = true
_jFLYg.Duration = 1800
_jFLYg.Type = "Countdown"
_DOz = Wherigo.ZTimer(_eiXtn)
_DOz.Id = "a71d8e35-6d99-44d6-9841-052826ed4762"
_DOz.Name = "Laufzeit7"
_DOz.Description = ""
_DOz.Visible = true
_DOz.Duration = 1800
_DOz.Type = "Countdown"
__81JY = Wherigo.ZTimer(_eiXtn)
__81JY.Id = "c505cb29-d64d-41de-8a12-1181635de388"
__81JY.Name = "Laufzeit6"
__81JY.Description = ""
__81JY.Visible = true
__81JY.Duration = 1800
__81JY.Type = "Countdown"
_mM7 = Wherigo.ZTimer(_eiXtn)
_mM7.Id = "5945381a-ac5c-4f4d-a82f-b26cab38bf5c"
_mM7.Name = "Laufzeit5"
_mM7.Description = ""
_mM7.Visible = true
_mM7.Duration = 1800
_mM7.Type = "Countdown"
_6coIH = Wherigo.ZTimer(_eiXtn)
_6coIH.Id = "d9ab1242-ad02-47ee-88f3-13ed873873ae"
_6coIH.Name = "Laufzeit4"
_6coIH.Description = ""
_6coIH.Visible = true
_6coIH.Duration = 1800
_6coIH.Type = "Countdown"
_u4mh = Wherigo.ZTimer(_eiXtn)
_u4mh.Id = "a95d1420-9be9-45fd-aa60-c503bdac277e"
_u4mh.Name = "Laufzeit3"
_u4mh.Description = ""
_u4mh.Visible = true
_u4mh.Duration = 1800
_u4mh.Type = "Countdown"
_dtA = Wherigo.ZTimer(_eiXtn)
_dtA.Id = "17e95eed-a19a-4a90-a432-d2f95400ab5b"
_dtA.Name = "LaufzeitKomplett"
_dtA.Description = ""
_dtA.Visible = true
_dtA.Duration = 86400
_dtA.Type = "Countdown"
_Ejb_ = Wherigo.ZInput(_eiXtn)
_Ejb_.Id = "f5572f12-a2a0-426e-8273-2a0e6cbd9c28"
_Ejb_.Name = "Code 1"
_Ejb_.Description = "Eingabe des ersten Codes"
_Ejb_.Visible = true
_Ejb_.Media = _rZ0wN
_Ejb_.Icon = _rZ0wN
_Ejb_.InputType = "Text"
_Ejb_.Text = "Wie lautet denn der einzig wahre Code?"
_7cbr = Wherigo.ZInput(_eiXtn)
_7cbr.Id = "9fac1b03-9077-4abf-8092-4b239babbeb4"
_7cbr.Name = "Code 2"
_7cbr.Description = "Eingabe des zweiten Codes"
_7cbr.Visible = true
_7cbr.Media = _rZ0wN
_7cbr.Icon = _rZ0wN
_7cbr.InputType = "Text"
_7cbr.Text = "Du hast das richtige Ei gefunden? Prima, wie lautet denn der Code?"
_RyKN = Wherigo.ZInput(_eiXtn)
_RyKN.Id = "4c8a0fb0-91b3-4c5f-9031-1acb74562e05"
_RyKN.Name = "Code 3"
_RyKN.Description = "Eingabe des dritten Codes"
_RyKN.Visible = true
_RyKN.Media = _rZ0wN
_RyKN.Icon = _rZ0wN
_RyKN.InputType = "Text"
_RyKN.Text = "Bist du ein guter Dosenangler? Dann fluestere mir doch den Code zu!"
_je3bS = Wherigo.ZInput(_eiXtn)
_je3bS.Id = "dde81729-12f0-48e3-8ebf-0b0bc53dfdf6"
_je3bS.Name = "Code 4"
_je3bS.Description = "Eingabe des vierten Codes"
_je3bS.Visible = true
_je3bS.Media = _rZ0wN
_je3bS.Icon = _rZ0wN
_je3bS.InputType = "Text"
_je3bS.Text = "Hast du den richtigen \"Mast\" mit der richtigen Dose gefunden? Wunderbar, so sage mir doch gleich den Code!"
_BDS = Wherigo.ZInput(_eiXtn)
_BDS.Id = "fb4a3749-0dbe-4ba8-95ba-5245759e424a"
_BDS.Name = "Quersumme"
_BDS.Description = "Eingabe der Quersumme aller Codes"
_BDS.Visible = true
_BDS.Media = _rZ0wN
_BDS.Icon = _rZ0wN
_BDS.InputType = "Text"
_BDS.Text = "Hast du die richtige Quersumme fuer mich? Dann lass mal hoeren!"
_gqdqQ = Wherigo.ZInput(_eiXtn)
_gqdqQ.Id = "fda56379-691f-4770-9690-a910d3cc6aed"
_gqdqQ.Name = "Bonus"
_gqdqQ.Description = "Eingabe fuer den Bonus"
_gqdqQ.Visible = true
_gqdqQ.Media = _rZ0wN
_gqdqQ.Icon = _rZ0wN
_gqdqQ.InputType = "Text"
_gqdqQ.Text = "Bist du fuendig geworden? Dann versuche dein Glueck."
_LBrY8 = Wherigo.ZInput(_eiXtn)
_LBrY8.Id = "b7666434-e842-4277-809f-844a93be9304"
_LBrY8.Name = "PaarDreieck"
_LBrY8.Description = "Zuordnung des Geraeuschpaares Dreieck"
_LBrY8.Visible = true
_LBrY8.Choices = {
  "Dreieck 2",
  "Kreis 2",
  "Quadrat 2",
  "Kreuz 2",
  "Raute 2"
}
_LBrY8.InputType = "MultipleChoice"
_LBrY8.Text = "Hast du die richtigen Paare zuordnen koennen? Dann lass mich mal sehen."
_zi3o = Wherigo.ZInput(_eiXtn)
_zi3o.Id = "2a448150-dc31-4379-a049-35ff4cd7c7bd"
_zi3o.Name = "PaarKreis"
_zi3o.Description = "Zuordnung des Geraeuschpaares Kreis"
_zi3o.Visible = true
_zi3o.Choices = {
  "Dreieck 2",
  "Kreis 2",
  "Quadrat 2",
  "Kreuz 2",
  "Raute 2"
}
_zi3o.InputType = "MultipleChoice"
_zi3o.Text = "Hast du die richtigen Paare zuordnen koennen? Dann lass mich mal sehen."
_vLf = Wherigo.ZInput(_eiXtn)
_vLf.Id = "ecc86891-e4ed-49e5-a1aa-3cb043a41976"
_vLf.Name = "PaarRaute"
_vLf.Description = "Zuordnung des Geraeuschpaares Raute"
_vLf.Visible = true
_vLf.Choices = {
  "Dreieck 2",
  "Kreis 2",
  "Quadrat 2",
  "Kreuz 2",
  "Raute 2"
}
_vLf.InputType = "MultipleChoice"
_vLf.Text = "Hast du die richtigen Paare zuordnen koennen? Dann lass mich mal sehen."
_CLPx = Wherigo.ZInput(_eiXtn)
_CLPx.Id = "d5cbf92c-a5b1-4b78-93d6-0ecac4b4ea8a"
_CLPx.Name = "PaarKreuz"
_CLPx.Description = "Zuordnung des Geraeuschpaares Kreuz"
_CLPx.Visible = true
_CLPx.Choices = {
  "Dreieck 2",
  "Kreis 2",
  "Quadrat 2",
  "Kreuz 2",
  "Raute 2"
}
_CLPx.InputType = "MultipleChoice"
_CLPx.Text = "Hast du die richtigen Paare zuordnen koennen? Dann lass mich mal sehen."
_C3F2 = Wherigo.ZInput(_eiXtn)
_C3F2.Id = "87a65018-b297-4ac0-8994-e829cb6b007d"
_C3F2.Name = "PaarQuadrat"
_C3F2.Description = "Zuordnung des Geraeuschpaares Quadrat"
_C3F2.Visible = true
_C3F2.Choices = {
  "Dreieck 2",
  "Kreis 2",
  "Quadrat 2",
  "Kreuz 2",
  "Raute 2"
}
_C3F2.InputType = "MultipleChoice"
_C3F2.Text = "Hast du die richtigen Paare zuordnen koennen? Dann lass mich mal sehen."
function _eiXtn:OnStart()
  _KMOuP()
  _dtA:Start()
  _0DdyD:Start()
  _WLFf8()
  _Urwigo.Dialog(false, {
    {
      Text = "Ich heisse dich willkommen, hier im Reich der Narren! Doch lasse dich nicht an der Nase herumfuehren (naja, vielleicht ein bisschen). Ich werde dir auf Schritt und Tritt folgen und dir ueber die Schulter blicken - ach wird das ein Spass!",
      Media = _rZ0wN
    },
    {
      Text = "Unterwegs kann ich dir auch einige Hinweise geben. Doch sei sehr sparsam mit ihnen! Ebenso solltest du dir nicht zu viele Fehler erlauben! Merke dir diese Worte!",
      Media = _rZ0wN
    },
    {
      Text = "Doch nun geh' ruhig, alles Weitere lasse ich dir unterwegs zukommen.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    local _rndChoiceValue = math.random()
    if _rndChoiceValue < 0.2 then
      _cEE37:MoveTo(_4VcW)
    elseif _rndChoiceValue < 0.4 then
      _cEE37:MoveTo(_MMx)
    elseif _rndChoiceValue < 0.6 then
      _cEE37:MoveTo(_8Xm)
    elseif _rndChoiceValue < 0.8 then
      _cEE37:MoveTo(_ex7)
    else
      _cEE37:MoveTo(_BR8N)
    end
    _cEE37.Visible = true
    _Aie.Active = true
    _4VcW.Active = true
    _4VcW.Visible = true
    _L0J:MoveTo(_4VcW)
    _LQrTf.Visible = true
  end)
end
function _eiXtn:OnRestore()
end
function _4VcW:OnEnter()
  _5b_ = "_4VcW"
  _Urwigo.GlobalZoneEnter()
end
function _4VcW:OnExit()
  _5b_ = "_4VcW"
  _Urwigo.GlobalZoneExit()
end
function _4VcW:OnProximity()
  _5b_ = "_4VcW"
  if _zNq == false then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Nicht weit entfernt findest du einen geheimen Code, der doch so offensichtlich ist. Verrate ihn mir und ich sage dir, wie es weiter geht.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._PxceW.Enabled = true
      _L0J.Commands._geDc.Enabled = true
      _zNq = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _MMx:OnEnter()
  _5b_ = "_MMx"
  _Urwigo.GlobalZoneEnter()
end
function _MMx:OnExit()
  _5b_ = "_MMx"
  _Urwigo.GlobalZoneExit()
end
function _MMx:OnProximity()
  _5b_ = "_MMx"
  if _aabUE == false then
    _KMOuP()
    _L0J:MoveTo(_MMx)
    _Urwigo.Dialog(false, {
      {
        Text = "Nun finde eine verborgene kleine Kiste. Dort wirst du einen weiteren Code entdecken der dir weiter hilft!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._NvOw8.Enabled = true
      _L0J.Commands._wyQ_.Enabled = true
      _aabUE = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _8Xm:OnEnter()
  _5b_ = "_8Xm"
  _Urwigo.GlobalZoneEnter()
end
function _8Xm:OnExit()
  _5b_ = "_8Xm"
  _Urwigo.GlobalZoneExit()
end
function _8Xm:OnProximity()
  _5b_ = "_8Xm"
  if _0BV3 == false then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Ich hoffe du hast deine Angel nicht vergessen. Denn diese wirst du hier brauchen. Finde einfach die richtige Dose und verrate mir den Code.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._VTA9p.Enabled = true
      _L0J.Commands._y5s.Enabled = true
      _0BV3 = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _ex7:OnEnter()
  _5b_ = "_ex7"
  _Urwigo.GlobalZoneEnter()
end
function _ex7:OnExit()
  _5b_ = "_ex7"
  _Urwigo.GlobalZoneExit()
end
function _ex7:OnProximity()
  _5b_ = "_ex7"
  if _QxjT == false then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Nun darfst du dich mal austoben. Hisse die Dosen! Doch wo sind sie - und welche ist doch gleich die Richtige? Wenn du sie gefunden haben solltest rufe mich einfach und sage mir den Code.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._zFj.Enabled = true
      _L0J.Commands._mHC.Enabled = true
      _QxjT = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _q45R8:OnEnter()
  _5b_ = "_q45R8"
  _Urwigo.GlobalZoneEnter()
end
function _q45R8:OnExit()
  _5b_ = "_q45R8"
  _Urwigo.GlobalZoneExit()
end
function _q45R8:OnProximity()
  _5b_ = "_q45R8"
  if _3Lo73 == false then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Hast du es doch tatsaechlich zu meinem Geheimversteck geschafft! Nun denn, deine Muehen sollen belohnt werden. Doch gib' Acht, von Zeit zu Zeit komme ich vorbei und schaue nach dem Rechten!",
        Media = _rZ0wN
      },
      {
        Text = "Falls du anschliessend auch den Bonus suchen moechtest, suche hier im Versteck nach dem letzten Code und verrate ihn mir.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._NZ26o.Enabled = true
      _L0J.Commands._6RK.Enabled = true
      _L0J.Commands._2o1Fe.Enabled = true
      _3Lo73 = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _LLC:OnEnter()
  _5b_ = "_LLC"
  _Urwigo.GlobalZoneEnter()
end
function _LLC:OnExit()
  _5b_ = "_LLC"
  _Urwigo.GlobalZoneExit()
end
function _LLC:OnProximity()
  _5b_ = "_LLC"
  if _wS7 == false then
    _dtA:Stop()
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Wunderbar, du hast den Weg hier her gefunden. Doch setze dich erst einmal und raste ein wenig. Anschliessend kannst du dich nochmal etwas betaetigen und nach dem Versteck suchen.",
        Media = _rZ0wN
      },
      {
        Text = "Nun sind wir auch schon am Ende dieser illustren Reise. Fuer etwaige Aergernisse oder Probleme bist du selber Schuld, immerhin wolltest du diesen Cache angehen.",
        Media = _rZ0wN
      },
      {
        Text = "Auch wenn es sehr verlockend aussieht, der angeschraubte Vogelkasten ist es nicht! Bitte versuche nicht, ihn zu oeffnen!!!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _DWmPW.Complete = true
      _LQrTf.Visible = false
      _cEE37.Visible = false
      _M8c4.Visible = false
      _zS9.Visible = false
      _6Yi.Visible = false
      _wS7 = true
      _L0J.Visible = true
      _L0J.Commands._SNuPZ.Enabled = true
      _L0J.Description = "Hier sind wir nun am Ende der Runde. Als Belohnung darfst du meinen Coin noch discovern."
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _kcK:OnEnter()
  _5b_ = "_kcK"
  _Urwigo.GlobalZoneEnter()
end
function _kcK:OnExit()
  _5b_ = "_kcK"
  _Urwigo.GlobalZoneExit()
end
function _kcK:OnProximity()
  _5b_ = "_kcK"
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Biege hier nun rechts ab und laufe in den Wald hinein.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _oBORv.Active = true
    _oBORv.Visible = true
    _kcK.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _oBORv:OnEnter()
  _5b_ = "_oBORv"
  _Urwigo.GlobalZoneEnter()
end
function _oBORv:OnExit()
  _5b_ = "_oBORv"
  _Urwigo.GlobalZoneExit()
end
function _oBORv:OnProximity()
  _5b_ = "_oBORv"
  _KMOuP()
  if _aabUE == false then
    _Urwigo.Dialog(false, {
      {
        Text = "So weit, so gut. Drehe dich nun nach rechts und suche nach Hinweisen, wo die naechste Station versteck ist.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _MMx.Active = true
      _MMx.Visible = true
      _oBORv.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _aabUE == true then
    _Urwigo.Dialog(false, {
      {
        Text = "Folge nun dem Waldweg weiter, um den naechsten Wegpunkt zu erreichen.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _iYWZn.Active = true
      _iYWZn.Visible = true
      _oBORv.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _iYWZn:OnEnter()
  _5b_ = "_iYWZn"
  _Urwigo.GlobalZoneEnter()
end
function _iYWZn:OnExit()
  _5b_ = "_iYWZn"
  _Urwigo.GlobalZoneExit()
end
function _iYWZn:OnProximity()
  _5b_ = "_iYWZn"
  _KMOuP()
  if _0BV3 == false then
    _Urwigo.Dialog(false, {
      {
        Text = "An dieser Wegeskreuzung drehst du dich nun wieder nach rechts und begibst dich somit in die naechste Zone.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _8Xm.Active = true
      _8Xm.Visible = true
      _iYWZn.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _0BV3 == true then
    _Urwigo.Dialog(false, {
      {
        Text = "Anschliessend laeufst du wieder den langen Waldweg entlang und kommst somit auch schon bald zum naechsten Wegpunkt.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _i0qYP.Active = true
      _i0qYP.Visible = true
      _iYWZn.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _i0qYP:OnEnter()
  _5b_ = "_i0qYP"
  _Urwigo.GlobalZoneEnter()
end
function _i0qYP:OnExit()
  _5b_ = "_i0qYP"
  _Urwigo.GlobalZoneExit()
end
function _i0qYP:OnProximity()
  _5b_ = "_i0qYP"
  _KMOuP()
  if _QxjT == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Nun geht es noch ein letztes Mal wieder vom Weg ab. Begib dich wieder nach rechts und werde dort fuendig.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _ex7.Active = true
      _ex7.Visible = true
      _i0qYP.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _QxjT == true then
    _Urwigo.Dialog(false, {
      {
        Text = "Bald hast du alle Aufgaben gemeistert. Das ersehnte Final ist nicht mehr weit entfernt. Gehe nun erst einmal aus dem Wald hinaus.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _MnK.Active = true
      _MnK.Visible = true
      _i0qYP.Active = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _MnK:OnEnter()
  _5b_ = "_MnK"
  _Urwigo.GlobalZoneEnter()
end
function _MnK:OnExit()
  _5b_ = "_MnK"
  _Urwigo.GlobalZoneExit()
end
function _MnK:OnProximity()
  _5b_ = "_MnK"
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Laufe nun am Waldesrand entlang bis vor zur Strasse und darueber hinweg.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _BR8N.Active = true
    _BR8N.Visible = true
    _MnK.Active = false
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _BR8N:OnEnter()
  _5b_ = "_BR8N"
  _Urwigo.GlobalZoneEnter()
end
function _BR8N:OnExit()
  _5b_ = "_BR8N"
  _Urwigo.GlobalZoneExit()
end
function _BR8N:OnProximity()
  _5b_ = "_BR8N"
  if _47Jq == false then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Hier befindet sich ein Kistlein, in der ein wahrer Ohrenschmaus enthalten ist. Finde sie und sortiere die entsprechenden Paare zusammen.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Commands._S50.Enabled = true
      _L0J.Commands._aAjV.Enabled = true
      _47Jq = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _lJLB:OnEnter()
  _5b_ = "_lJLB"
  _Urwigo.GlobalZoneEnter()
end
function _lJLB:OnExit()
  _5b_ = "_lJLB"
  _Urwigo.GlobalZoneExit()
  _Urwigo.Dialog(false, {
    {
      Text = "Wie ich sehe bist du wohl kein wirklicher Spielertyp. Na gut, dann folge deinem Wege und suche nach den weiteren geheimen Codes.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _lJLB.Visible = false
    _lJLB.Active = false
    _L0J.Commands._utQ.Enabled = false
    _L0J.Commands._0Wo.Enabled = false
    _L0J:MoveTo(_MMx)
  end)
end
function _lJLB:OnProximity()
  _5b_ = "_lJLB"
  if _gCT7i == false then
    _Urwigo.Dialog(false, {
      {
        Text = "Na, wie sieht es aus. Wollen wir ein kleines Gluecksspiel spielen? Solltest du gewinnen, so will ich dir ein bisschen Sucherei ersparen und dich nah zum Final bringen. Die Entscheidung liegt bei dir!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _lJLB.Visible = true
      _L0J.Commands._utQ.Enabled = true
      _L0J.Commands._0Wo.Enabled = true
      _gCT7i = true
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _Ejb_:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 491 then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Wunderbach, du scheinst sehr gute Augen zu haben. Doch nun wartet bereits die naechste Aufgabe auf dich. Gehe weiter Richtung Wald, um die weiteren Codes zu suchen. Den gesuchten Code habe ich dir sicherheitshalber auf deinen Notizzettel geschrieben.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _LQrTf.Media = _OVQaC
      _Aie.Complete = true
      _n1j.Active = true
      _n1j.Visible = true
      _kcK.Active = true
      _kcK.Visible = true
      _4VcW.Active = false
      _lJLB.Active = true
      _L0J.Commands._PxceW.Enabled = false
      _L0J.Commands._geDc.Enabled = false
      _L0J:MoveTo(_lJLB)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _7cbr:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 8249 then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Deine Ausdauer soll belohnt werden. Denn ich zeige dir sogleich den Weg zur naechsten Station. Den gesuchten Code habe ich dir soeben auch auf deinen Notizzettel geschrieben.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _LQrTf.Media = _cvENm
      _n1j.Complete = true
      _Idq.Active = true
      _Idq.Visible = true
      _oBORv.Active = true
      _oBORv.Visible = true
      _MMx.Active = false
      _L0J.Commands._NvOw8.Enabled = false
      _L0J.Commands._wyQ_.Enabled = false
      _L0J:MoveTo(_8Xm)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _RyKN:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 10492 then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Offenbar bist du doch ein guter Dosenangler. Doch wie ist es um deine anderen Fertigkeiten bestellt? Komm, lass uns weiter zur naechsten Aufgabe gehen, dann sehen wir weiter. Den eben gefundenen Code findest du auf deinem Notizzettel wieder.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _LQrTf.Media = _6wiy
      _Idq.Complete = true
      _Qv3CJ.Active = true
      _Qv3CJ.Visible = true
      _iYWZn.Active = true
      _iYWZn.Visible = true
      _8Xm.Active = false
      _L0J.Commands._VTA9p.Enabled = false
      _L0J.Commands._y5s.Enabled = false
      _L0J:MoveTo(_ex7)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _je3bS:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 510429 then
    _KMOuP()
    _LQrTf.Visible = false
    _LQrTf.Media = _l_3y
    _Urwigo.Dialog(false, {
      {
        Text = "Du solltest dich bei der Bundeswehr melden, denn Dosen hissen kannst du ja schon ziemlich gut. Doch nun geht es auch schon fast direkt zum Geheimversteck.",
        Media = _rZ0wN
      },
      {
        Text = "Prima, du hast soweit alle Aufgaben gemeistert. Doch lasse mich noch eines wissen, eh' ich dich zum Geheimverstecke lasse: ermittle zu jedem Code die Quersumme, addiere diese zusammen und nenne mir das Ergebnis!",
        Media = _rZ0wN
      },
      {
        Text = "Ach herrje, ich habe den Notizzettel mittlerweile so oft in die Tasche gesteckt, dass er schon total zerfleddert ist. Vielleicht kannst du ja noch ein bisschen darauf erkennen. Ansonsten weisst du ja, wo du die Codes noch einmal her bekommst.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _L0J.Visible = true
      _L0J.Commands._Cxo.Enabled = true
      _LQrTf.Visible = true
      _Qv3CJ.Complete = true
      _L0J.Commands._zFj.Enabled = false
      _L0J.Commands._mHC.Enabled = false
      _UWv_y.Active = true
      _UWv_y.Visible = true
      _ex7.Visible = false
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _BDS:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 74 then
    _KMOuP()
    _Urwigo.Dialog(false, {
      {
        Text = "Korrekt, du erscheinst mir wuerdig, dich auf die weitere Suche zu begeben.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _UWv_y.Complete = true
      _L0J.Commands._Cxo.Enabled = false
      _E1g33.Active = true
      _E1g33.Visible = true
      _i0qYP.Active = true
      _i0qYP.Visible = true
      _ex7.Active = false
      _L0J:MoveTo(_BR8N)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _gqdqQ:OnGetInput(input)
  input = tonumber(input)
  if input == nil then
    return
  end
  if input == 1337 then
    _KMOuP()
    _LLC.Active = true
    if FalscheEingabe > 0 and FalscheEingabe <= 5 then
      _Urwigo.Dialog(false, {
        {
          Text = "Herzlichen Glueckwunsch, du hast die gestellten Aufgaben ganz gut gemeistert. Doch ganz so schnell will ich dich auch nicht weiter ziehen lassen!",
          Media = _rZ0wN
        },
        {
          Text = "Blicke von hier aus in 230 Grad. Dort wirst du einen ordentlich geratenen Baum finden. Schaue doch mal dort nach.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        _DWmPW.Description = "Erst rasten, dann nochmal hasten (und zwar hoch), blicke in 230 Grad und suche dort einmal, es ist nicht der Vogelkasten!!!"
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif FalscheEingabe > 5 and FalscheEingabe < 10 then
      _Urwigo.Dialog(false, {
        {
          Text = "Na gut, ein paar Fehler hast du dir ja erlaubt. Doch am Ende bist du ja doch noch fuendig geworden.",
          Media = _rZ0wN
        },
        {
          Text = "So blicke nun nach SW und finde dort den zweiten geheimen Schatz. Schaue dir auch das Zonenbild einmal genau an.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        _DWmPW.Description = "Erst rasten, dann nochmal hasten (und zwar hoch), blicke nach SW, schaue das Zonenbild an und suche dort, es ist nicht der Vogelkasten!!!"
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif FalscheEingabe == 0 then
      _Urwigo.Dialog(false, {
        {
          Text = "HEUREKA, du hast mir alle Codes absolut richtig genannt und hast dich wacker geschlagen. Somit will ich dir gleich den wahren Weg zum Bonus verraten.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        _DWmPW.Description = "Erst rasten, dann nochmal hasten (und zwar hoch), es ist nicht der Vogelkasten!!!"
        _LLC.Visible = true
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    else
      _Urwigo.Dialog(false, {
        {
          Text = "Du hast dir ja einige Fehler geleistet. Ich denke, das haette man auch mit weniger Fehlern bis hier her schaffen koennen.",
          Media = _rZ0wN
        },
        {
          Text = "Dennoch will ich auch dir zum zweiten geheimen Versteck weiter helfen. Die letzte geheime Dose befindet sich so ziemlich genau 224 m von hier entfernt und zwar da, wo es laut wird.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        _DWmPW.Description = "Erst rasten, dann nochmal hasten (und zwar hoch), suche im Abstand von 224 m, da wo es laut wird, es ist nicht der Vogelkasten!!!"
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
    _q45R8.Active = false
    _L0J.Commands._NZ26o.Enabled = false
    _L0J.Commands._5oL5.Enabled = false
    _AHC.Complete = true
    _DWmPW.Active = true
    _A3b.Visible = true
    _L0J:MoveTo(_LLC)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das war er wohl nicht ... versuche es doch einfach erneut!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    FalscheEingabe = FalscheEingabe + 1
  end
end
function _LBrY8:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 35864 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 347 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 28049 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 50467 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 18002 then
    _CkuVd = _CkuVd + 1
  end
  _L0J.Commands._56roN.Enabled = false
  _18H()
end
function _zi3o:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 35864 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 347 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 28049 then
    _CkuVd = _CkuVd + 1
  elseif _Urwigo.Hash(string.lower(input)) == 50467 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 18002 then
    _YqV_C = _YqV_C + 1
  end
  _L0J.Commands._2fMhu.Enabled = false
  _18H()
end
function _vLf:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 35864 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 347 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 28049 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 50467 then
    _CkuVd = _CkuVd + 1
  elseif _Urwigo.Hash(string.lower(input)) == 18002 then
    _YqV_C = _YqV_C + 1
  end
  _L0J.Commands._HQOjW.Enabled = false
  _18H()
end
function _CLPx:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 35864 then
    _CkuVd = _CkuVd + 1
  elseif _Urwigo.Hash(string.lower(input)) == 347 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 28049 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 50467 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 18002 then
    _YqV_C = _YqV_C + 1
  end
  _L0J.Commands._CP43O.Enabled = false
  _18H()
end
function _C3F2:OnGetInput(input)
  if input == nil then
    input = ""
  end
  if _Urwigo.Hash(string.lower(input)) == 35864 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 347 then
    _CkuVd = _CkuVd + 1
  elseif _Urwigo.Hash(string.lower(input)) == 28049 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 50467 then
    _YqV_C = _YqV_C + 1
  elseif _Urwigo.Hash(string.lower(input)) == 18002 then
    _YqV_C = _YqV_C + 1
  end
  _L0J.Commands._4_eJF.Enabled = false
  _18H()
end
function _0DdyD:OnTick()
  _jFLYg:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Du hast bereits eine halbe Stunde im Wald verbracht. Suche nur schoen weiter.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _jFLYg:OnTick()
  _u4mh:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Bereits eine Stunde ist vergangen. Ich hoffe du kommst gut voran. Wenn nicht, frage mich einfach.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _DOz:OnTick()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Die veranschlagten dreieinhalb Stunden sind nun vorbei. Und noch bist du am Suchen. Aber lass dich nicht beirren. Ich lasse dich nun auch in Ruhe.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function __81JY:OnTick()
  _DOz:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Drei Stunden sind es nun. Langsam verbringst du doch recht viel Zeit hier. Dir scheint es hier zu gefallen.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _mM7:OnTick()
  __81JY:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Noch sind die eingeschaetzten dreieinhalb Stunden nicht vorbei. Jedoch sind es schon zweieinhalb Stunden, die du dich hier im Wald rumtreibst.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _6coIH:OnTick()
  _mM7:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Die Zeit laeuft und laeuft ... schon zwei Stunden sind vorbei. Und noch stehst du nicht vor dem Final.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _u4mh:OnTick()
  _6coIH:Start()
  _KMOuP()
  _Urwigo.Dialog(false, {
    {
      Text = "Nun sind schon ein und eine halbestunde vergangen. Die Zeit vergeht schon ordentlich.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _L0J:On_PxceW(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_Ejb_)
  end)
end
function _L0J:On_geDc(target)
  if _USPpZ == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Du siehst den Code nicht? Er ist doch so offensichtlich und fur jedermann sichtbar. Suche nicht im Zweibeiner-Bereich!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Aie.Description = [[
Suche den richtigen Code, doch nur einer ist der Wahre<BR>
<BR>
Hinweise:<BR>
- Du siehst den Code nicht? Er ist doch so offensichtlich und fur jedermann sichtbar. Suche nicht im Zweibeiner-Bereich!]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _USPpZ == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "Nun gut, dann gibt es noch einen Hinweis, der Code ist lediglich 3-stellig.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Aie.Description = [[
Suche den richtigen Code, doch nur einer ist der Wahre<BR>
<BR>
Hinweise:<BR>
- Du siehst den Code nicht? Er ist doch so offensichtlich und fur jedermann sichtbar. Suche nicht im Zweibeiner-Bereich!<BR>
- Nun gut, dann gibt es noch einen Hinweis, der Code ist lediglich 3-stellig.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Wie oft willst du denn noch einen Hinweis haben? Ich denke mit den genannten Hinweisen musst du auskommen!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _USPpZ = _USPpZ + 1
end
function _L0J:On_NvOw8(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_7cbr)
  end)
end
function _L0J:On_wyQ_(target)
  if _v19P == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "Abgedeckt mit naturlichen Utensilien, wirst du alsbald das Gesuchte finden.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _n1j.Description = [[
Wer suchet der findet, genau ein Ei wird dir weiter helfen<BR>
<BR>
Hinweise:<BR>
- Suche nah am Waldesrand und schon wirst du fuendig.<BR>
- Abgedeckt mit naturlichen Utensilien, wirst du alsbald das Gesuchte finden.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _v19P == 2 then
    _Urwigo.Dialog(false, {
      {
        Text = "Siehst du die weissen Markierungen? Dort muss doch irgend etwas sein ...",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _n1j.Description = [[
Wer suchet der findet, genau ein Ei wird dir weiter helfen<BR>
<BR>
Hinweise:<BR>
- Suche nah am Waldesrand und schon wirst du fuendig.<BR>
- Abgedeckt mit naturlichen Utensilien, wirst du alsbald das Gesuchte finden.<BR>
- Siehst du die weissen Markierungen? Dort muss doch irgend etwas sein ...]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _v19P == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Suche nah am Waldesrand und schon wirst du fuendig.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _n1j.Description = [[
Wer suchet der findet, genau ein Ei wird dir weiter helfen<BR>
<BR>
Hinweise:<BR>
- Suche nah am Waldesrand und schon wirst du fuendig.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Du hast bisher aber schon recht haeufig meine Hilfe in Anspruch nehmen muessen! Und du willst es noch bis zum Final schaffen? Fuer diese Station gibt es keinen weiteren Hinweis!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _v19P = _v19P + 1
end
function _L0J:On_VTA9p(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_RyKN)
  end)
end
function _L0J:On_y5s(target)
  if _Z1J == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Du bist noch am suchen? Na gut, dann helfe ich dir etwas: suche innerhalb der gelb-weissen Punkte.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Idq.Description = [[
Ausgeruestet mit deiner Dosenangel musst du die richtige Dose angeln<BR>
<BR>
Hinweise:<BR>
- Du bist noch am suchen? Na gut, dann helfe ich dir etwas: suche innerhalb der gelb-weissen Punkte.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Z1J == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "Am Boden bist du schon ganz richtig. Suche einfach gruendlich genug.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Idq.Description = [[
Ausgeruestet mit deiner Dosenangel musst du die richtige Dose angeln<BR>
<BR>
Hinweise:<BR>
- Du bist noch am suchen? Na gut, dann helfe ich dir etwas: suche innerhalb der gelb-weissen Punkte.<BR>
- Am Boden bist du schon ganz richtig. Suche einfach gruendlich genug.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _Z1J == 3 then
    _Urwigo.Dialog(false, {
      {
        Text = "Die gesuchte Dose muss nicht immer direkt an einem Baum sein. Ihr Geocacher sucht doch sonst auch immer sehr gruendlich den ganzen Waldboden ab.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Idq.Description = [[
Ausgeruestet mit deiner Dosenangel musst du die richtige Dose angeln<BR>
<BR>
Hinweise:<BR>
- Du bist noch am suchen? Na gut, dann helfe ich dir etwas: suche innerhalb der gelb-weissen Punkte.<BR>
- Am Boden bist du schon ganz richtig. Suche einfach gruendlich genug.<BR>
- Die gesuchte Dose muss nicht immer direkt an einem Baum sein. Ihr Geocacher sucht doch sonst auch immer sehr gruendlich den ganzen Waldboden ab.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Oje oje, mehr Hinweise kann ich dir nun aber auch nicht mehr geben! Versuche einfach mal dein Glueck!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _Z1J = _Z1J + 1
end
function _L0J:On_zFj(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_je3bS)
  end)
end
function _L0J:On_mHC(target)
  if _4Ed == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Bei Station 1 hattest du doch noch so gute Adlersaugen ... na gut, ich sage dir mal so viel: die gesuchte Dose befindet sich nicht unten.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Qv3CJ.Description = [[
Finde den richtigen "Mast" um die notige Dose zu hissen<BR>
<BR>
Hinweise:<BR>
- Bei Station 1 hattest du doch noch so gute Adlersaugen ... na gut, ich sage dir mal so viel: die gesuchte Dose befindet sich nicht unten.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _4Ed == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "An die gesuchte Dose kommst du ganz bequem im stehen heran.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Qv3CJ.Description = [[
Finde den richtigen "Mast" um die notige Dose zu hissen<BR>
<BR>
Hinweise:<BR>
- Bei Station 1 hattest du doch noch so gute Adlersaugen ... na gut, ich sage dir mal so viel: die gesuchte Dose befindet sich nicht unten.<BR>
- An die gesuchte Dose kommst du ganz bequem im stehen heran.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _4Ed == 2 then
    _Urwigo.Dialog(false, {
      {
        Text = "Du benoetigst keinerlei Hilfsmittel, lediglich deine Adlersaugen sowie deine Haende. Und immer schoen \"Guck in die Luft\".",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _Qv3CJ.Description = [[
Finde den richtigen "Mast" um die notige Dose zu hissen<BR>
<BR>
Hinweise:<BR>
- Bei Station 1 hattest du doch noch so gute Adlersaugen ... na gut, ich sage dir mal so viel: die gesuchte Dose befindet sich nicht unten.<BR>
- An die gesuchte Dose kommst du ganz bequem im stehen heran.<BR>
- Du benoetigst keinerlei Hilfsmittel, lediglich deine Adlersaugen sowie deine Haende. Und immer schoen "Guck in die Luft".]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Hier kann ich dir nun wirklich nicht mehr weiter helfen. Dass du es uberhaupt bis hier her geschafft hast?!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _4Ed = _4Ed + 1
end
function _L0J:On_Cxo(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_BDS)
  end)
end
function _L0J:On_NZ26o(target)
  if _B6lZ == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Du hast die erste Tuer geoeffnet? Gut, dann musst du nur noch die letzte Tuer oeffnen. Achso, du hast den Schluessel gar nicht? Dann suche im Umkreis von etwa 10m am Boden.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _AHC.Description = [[
Hier befindet sich der begehrte Schatz und der Hinweis fuer den Bonus<BR>
<BR>
Hinweise:<BR>
- Du hast die erste Tuer geoeffnet? Gut, dann musst du nur noch die letzte Tuer oeffnen. Achso, du hast den Schluessel gar nicht? Dann suche im Umkreis von etwa 10m am Boden.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _B6lZ == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "Der verkorkste Schluessel liegt ganz nah am Kistlein. Doch ist er nicht offensichtlich sondern huebsch verpackt.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _AHC.Description = [[
Hier befindet sich der begehrte Schatz und der Hinweis fuer den Bonus<BR>
<BR>
Hinweise:<BR>
- Du hast die erste Tuer geoeffnet? Gut, dann musst du nur noch die letzte Tuer oeffnen. Achso, du hast den Schluessel gar nicht? Dann suche im Umkreis von etwa 10m am Boden.<BR>
- Der verkorkste Schluessel liegt ganz nah am Kistlein. Doch ist er nicht offensichtlich sondern huebsch verpackt.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _B6lZ == 2 then
    _Urwigo.Dialog(false, {
      {
        Text = "Es ist brennbar, es ist lang, und es hilfe dir, die Tuere zu oeffnen. Was ist das?",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _AHC.Description = [[
Hier befindet sich der begehrte Schatz und der Hinweis fuer den Bonus<BR>
<BR>
Hinweise:<BR>
- Du hast die erste Tuer geoeffnet? Gut, dann musst du nur noch die letzte Tuer oeffnen. Achso, du hast den Schluessel gar nicht? Dann suche im Umkreis von etwa 10m am Boden.<BR>
- Der verkorkste Schluessel liegt ganz nah am Kistlein. Doch ist er nicht offensichtlich sondern huebsch verpackt.<BR>
- Es ist brennbar, es ist lang, und es hilfe dir, die Tuere zu oeffnen. Was ist das?]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Da habe ich dir schon soweit geholfen und dann fragst du mich noch nach einer Hilfe?! Da musst du jetzt wohl so durch!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _B6lZ = _B6lZ + 1
end
function _L0J:On_5oL5(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_gqdqQ)
  end)
end
function _L0J:On_SNuPZ(target)
  _Urwigo.Dialog(false, {
    {
      Text = ((((((("Bis hier her hast du mir " .. FalscheEingabe) .. " falsche Antworten gegeben und ") .. _USPpZ + _v19P + _Z1J + _4Ed + _zMkrb + _B6lZ) .. [[
-mal meine Hilfe gebraucht.<BR>
Ausserdem hast du ]]) .. _pqm) .. [[
-mal mit meiner Rassel herum gespielt.<BR>
Deine komplette Spielzeit betrug ]]) .. _Urwigo.Ceil((_dtA.Duration - _dtA.Remaining) / 60, 0)) .. " Minuten.",
      Media = _rZ0wN
    },
    {
      Text = "Du darfst du geehrt fuehlen, dass du die Runde geschafft hast!",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _L0J:On_6RK(target)
  _Urwigo.Dialog(false, {
    {
      Text = "So, du moechtest also noch ein weiteres Versteck suchen. Dann suche in dieser Behausung nach dem letzten Code und nenne ihn mir.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _L0J.Commands._5oL5.Enabled = true
    _L0J.Commands._6RK.Enabled = false
    _L0J.Commands._2o1Fe.Enabled = false
  end)
end
function _L0J:On_2o1Fe(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Bist du dir ganz sicher, dass du die Runde beenden willst? Danach gibt es kein Zurueck mehr! Entscheide dich jetzt.",
      Media = _rZ0wN,
      Buttons = {"Ja", "Nein"}
    }
  }, function(action)
    _dtA:Stop()
    if action == "Button1" then
      _Urwigo.Dialog(false, {
        {
          Text = ((((((("Dir reicht also die Runde bis hier her. Ok, dann soll es so sein. &nbsp;Bis hier hast du mir " .. FalscheEingabe) .. " falsche Antworten gegeben und ") .. _USPpZ + _v19P + _Z1J + _4Ed + _zMkrb + _B6lZ) .. [[
-mal meine Hilfe gebraucht.<BR>
Ausserdem hast du ]]) .. _pqm) .. "-mal mit meiner Rassel herum gespielt. Deine komplette Spielzeit betrug ") .. (_dtA.Duration - _dtA.Remaining) / 60) .. " Minuten.",
          Media = _rZ0wN
        },
        {
          Text = "Solltest du spaeter nochmal nach dem Bonus suchen wollen, so musst du die Runde erneut absolvieren. Aber du bist doch schon gross und schaffst das doch nochmal.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        _L0J.Visible = true
        _L0J.Commands._SNuPZ.Enabled = true
        _L0J.Commands._NZ26o.Enabled = false
        _L0J.Commands._6RK.Enabled = false
        _L0J.Commands._2o1Fe.Enabled = false
        _A3b.Visible = true
        _LQrTf.Visible = false
        _6Yi.Visible = false
        _zS9.Visible = false
        _M8c4.Visible = false
        _cEE37.Visible = false
        _AHC.Complete = true
        _q45R8.Visible = false
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    elseif action == "Button2" then
      _Urwigo.Dialog(false, {
        {
          Text = "Da hast du es dir ja gerade so nochmal ueberlegt. Ok, dann nenne mir den letzten Code und du gelangst auch weiter zum letzten Versteck.",
          Media = _rZ0wN,
          Buttons = {"Ok"}
        }
      }, function(action)
        Wherigo.ShowScreen(Wherigo.MAINSCREEN)
      end)
    end
  end)
end
function _L0J:On_56roN(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_LBrY8)
  end)
end
function _L0J:On_2fMhu(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_zi3o)
  end)
end
function _L0J:On_4_eJF(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_C3F2)
  end)
end
function _L0J:On_CP43O(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_CLPx)
  end)
end
function _L0J:On_HQOjW(target)
  _Urwigo.RunDialogs(function()
    Wherigo.GetInput(_vLf)
  end)
end
function _L0J:On_aAjV(target)
  if _zMkrb == 0 then
    _Urwigo.Dialog(false, {
      {
        Text = "Ach herrje, du bist so weit gekommen und findest diese Station nicht? Suche am grossen offensichtlichen Objekt.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _E1g33.Description = [[
Finde heraus, welche Paare zusammen gehoeren.<BR>
<BR>
Hinweise:<BR>
- Ach herrje, du bist so weit gekommen und findest diese Station nicht? Suche am grossen offensichtlichen Objekt.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  elseif _zMkrb == 1 then
    _Urwigo.Dialog(false, {
      {
        Text = "Na gut, es ist grau und liegt quasi vor deinen Fuessen.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _E1g33.Description = [[
Finde heraus, welche Paare zusammen gehoeren.<BR>
<BR>
Hinweise:<BR>
- Ach herrje, du bist so weit gekommen und findest diese Station nicht? Suche am grossen offensichtlichen Objekt.<BR>
- Na gut, es ist grau und liegt quasi vor deinen Fuessen.]]
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Hier kann ich dir nun wirklich nicht mehr weiter helfen. Dass du es uberhaupt bis hier her geschafft hast?!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
  _zMkrb = _zMkrb + 1
end
function _L0J:On_utQ(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Du wolltest es noch nicht einmal probieren, aber ok. Deine Chance waere sowieso nur 0,1% gewesen, dass du es gewinnst. Nun gehe und versuche dein weiteres Glueck.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _lJLB.Visible = false
    _lJLB.Active = false
    _L0J.Commands._utQ.Enabled = false
    _L0J.Commands._0Wo.Enabled = false
    _L0J:MoveTo(_MMx)
  end)
end
function _L0J:On_0Wo(target)
  _Urwigo.Dialog(true, {
    {
      Text = "Du willst es also wirklich versuchen. Nun gut, dann schauen wir doch mal, wie es um dein Glueck steht ...",
      Media = _rZ0wN
    },
    {
      Text = "Siehst du das Geocaching Logo, so gewinne ich, siehst du das Geocaching Maskottchen, so gewinnst du.",
      Media = _rZ0wN
    },
    {
      Text = "Die Muenze wird nach oben geworfen und landet auf Till seiner Hand und zeigt ....",
      Media = _pKpB,
      Buttons = {"Ok"}
    }
  }, nil)
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.999 then
    _Urwigo.Dialog(false, {
      {
        Text = "Das Geocaching Logo",
        Media = _xDkd
      },
      {
        Text = "Tja, da hast du wohl Pech gehabt ...",
        Media = _rZ0wN
      },
      {
        Text = "Gehe einfach weiter zum naechsten Wegpunkt und versuche dich an den zahlreichen Stationen. So wirst du auch den Weg zum Final finden.",
        Media = _rZ0wN
      },
      {
        Text = "Als kleines Andenken sollst du die Muenze haben und dich gern an dieses Spielchen erinnern.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _M8c4.Media = _xDkd
      _M8c4.Icon = __XD
      _M8c4:MoveTo(Player)
      _M8c4.Commands._KIon.Enabled = true
      _L0J.Commands._utQ.Enabled = false
      _L0J.Commands._0Wo.Enabled = false
      _lJLB.Active = false
      _L0J:MoveTo(_BR8N)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  else
    _Urwigo.Dialog(false, {
      {
        Text = "Das Geocaching Maskottchen",
        Media = _mnr
      },
      {
        Text = "Potzblitz, du hast es tatsaechlich geschafft ...",
        Media = _rZ0wN
      },
      {
        Text = "Deine Chancen standen gerade einmal 1 zu 1000. Nun gut, so soll es sein. Ich werde dir zeigen, wie es recht schnell zum Final geht. Doch eine weitere Station sollst du wenigstens absolvieren.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      _M8c4.Media = _mnr
      _M8c4.Icon = _bCD
      _M8c4:MoveTo(Player)
      _cEE37:MoveTo(_BR8N)
      _M8c4.Commands._KIon.Enabled = true
      _L0J.Commands._utQ.Enabled = false
      _L0J.Commands._0Wo.Enabled = false
      _n1j.Active = false
      _E1g33.Active = true
      _E1g33.Visible = true
      _kcK.Active = false
      _lJLB.Active = false
      _BR8N.Active = true
      _BR8N.Visible = true
      _L0J:MoveTo(_BR8N)
      Wherigo.ShowScreen(Wherigo.MAINSCREEN)
    end)
  end
end
function _L0J:On_S50(target)
  _L0J.Commands._aAjV.Enabled = false
  _L0J.Commands._S50.Enabled = false
  _L0J.Commands._56roN.Enabled = true
  _L0J.Commands._2fMhu.Enabled = true
  _L0J.Commands._4_eJF.Enabled = true
  _L0J.Commands._CP43O.Enabled = true
  _L0J.Commands._HQOjW.Enabled = true
end
function _zS9:On_Rtb(target)
  if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
    Wherigo.PlayAudio(_nRI)
  else
    Wherigo.PlayAudio(_XFZ9_)
  end
  local _rndChoiceValue = math.random()
  if _rndChoiceValue < 0.25 then
    _pqm = _pqm + 1
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  elseif _rndChoiceValue < 0.5 then
    _pqm = _pqm + 1
    Wherigo.ShowScreen(Wherigo.INVENTORYSCREEN)
  elseif _rndChoiceValue < 0.75 then
    _pqm = _pqm + 1
    Wherigo.ShowScreen(Wherigo.ITEMSCREEN)
  else
    _pqm = _pqm + 1
    Wherigo.ShowScreen(Wherigo.TASKSCREEN)
  end
end
function _6Yi:On_Up1ND(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Hi hi hi herrlich ists, ein lustger Narr zu sein",
      Media = _gI_xL,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _6Yi:On_OZ80J(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Welch Glueck, dass ich immer einen Spiegel bei mir hab. Schauen wir mal, was sich hinter der Botschaft verbirgt.",
      Media = _rZ0wN
    },
    {Text = "", Media = _Fn3K5},
    {
      Text = "Was genau soll das bedeuten? Vielleicht wird uns diese Information noch einmal nuetzlich sein.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, nil)
end
function _cEE37:On_U40e(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Sieh an, dort steht sogar was drauf. Doch was soll das nur heissen?",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _cEE37.Media = _WZh
    _cEE37.Commands._U40e.Enabled = false
    _6Yi.Commands._OZ80J.Enabled = true
    _cEE37.Icon = _nJH
    _cEE37.Description = "Ganz so unscheinbar scheint er doch nicht zu sein, man muesste es nur lesen koennen"
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _cEE37:On_9k5f6(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Du hast also irgend einen zerknuellten, pappigen Zettel aufgehoben ... naja, wenn er dir so gefaellt.",
      Media = _rZ0wN,
      Buttons = {"Ok"}
    }
  }, function(action)
    _cEE37:MoveTo(Player)
    _cEE37.Commands._9k5f6.Enabled = false
    _cEE37.Commands._U40e.Enabled = true
    _cEE37.Commands._L_l.Enabled = true
    Wherigo.ShowScreen(Wherigo.MAINSCREEN)
  end)
end
function _cEE37:On_L_l(target)
  _Urwigo.Dialog(false, {
    {
      Text = "Den brauchst du sowieso nicht mehr, was wollen wir den also laenger mit uns rum schleppen.",
      Media = _rZ0wN
    },
    {
      Text = "Ploetzlich kommt eine starke Windboehe und blaest den Zettel ganz weit weg, so dass du ihn aus den Augen verlierst",
      Buttons = {"Ok"}
    }
  }, function(action)
    _cEE37.Visible = false
    _6Yi.Commands._OZ80J.Enabled = false
  end)
end
function _M8c4:On_KIon(target)
  if _M8c4.Media == _xDkd then
    _Urwigo.Dialog(false, {
      {
        Text = "Diese Seite haette dir mehr Glueck gebracht.",
        Media = _mnr,
        Buttons = {"Ok"}
      }
    }, nil)
  elseif _M8c4.Media == _mnr then
    _Urwigo.Dialog(false, {
      {
        Text = "Damit haettest du alt ausgesehen. Denn du haettest verloren.",
        Media = _xDkd,
        Buttons = {"Ok"}
      }
    }, nil)
  end
end
function _Urwigo.GlobalZoneEnter()
  _eiXtn:RequestSync()
end
function _Urwigo.GlobalZoneExit()
  _eiXtn:RequestSync()
end
function _WLFf8()
  if (_G[_aNeWb("\021TG")][_aNeWb("Ko<Ap(]\006")] == _aNeWb("\tHT3>") or _G[_aNeWb("\021TG")][_aNeWb("rFGHcF*r")] == _aNeWb("rFiUA(s")) == true then
    _Urwigo.Dialog(true, {
      {
        Text = "Du wolltest die Cartridge doch nicht etwa im Simulator spielen? Geh mal lieber raus und spiele sie richtig!",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, nil)
    Wherigo.Command("SaveClose")
  end
end
function _18H()
  if _YqV_C + _CkuVd == 5 then
    _Urwigo.Dialog(false, {
      {
        Text = "So, du hast nun alle Paare zugeordnet. Mal sehen ob du auch richtig liegst.",
        Media = _rZ0wN,
        Buttons = {"Ok"}
      }
    }, function(action)
      if _CkuVd == 5 then
        _Urwigo.Dialog(false, {
          {
            Text = "Super, du hast alle Paare richtig zuordnen koennen. Dann lasse ich dich sofort weiter ziehen zum Final.",
            Media = _rZ0wN,
            Buttons = {"Ok"}
          }
        }, function(action)
          _E1g33.Complete = true
          _AHC.Active = true
          _AHC.Visible = true
          _q45R8.Active = true
          _q45R8.Visible = true
          _BR8N.Active = false
          _L0J.Commands._aAjV.Enabled = false
          _L0J:MoveTo(_q45R8)
          Wherigo.ShowScreen(Wherigo.MAINSCREEN)
        end)
      else
        _Urwigo.Dialog(false, {
          {
            Text = "Da scheint dir ein Fehler unterlaufen zu sein. Versuche es nochmal.",
            Media = _rZ0wN,
            Buttons = {"Ok"}
          }
        }, function(action)
          _YqV_C = 0
          _CkuVd = 0
          _L0J.Commands._56roN.Enabled = true
          _L0J.Commands._2fMhu.Enabled = true
          _L0J.Commands._4_eJF.Enabled = true
          _L0J.Commands._CP43O.Enabled = true
          _L0J.Commands._HQOjW.Enabled = true
          FalscheEingabe = FalscheEingabe + 1
        end)
      end
    end)
  end
end
function _KMOuP()
  if Wherigo.NoCaseEquals(Env.Platform, "Vendor 1 ARM9") then
    Wherigo.PlayAudio(_nRI)
  else
    Wherigo.PlayAudio(_IGGw)
  end
end
return _eiXtn
